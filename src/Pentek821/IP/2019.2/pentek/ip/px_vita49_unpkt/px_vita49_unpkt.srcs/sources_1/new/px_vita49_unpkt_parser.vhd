----------------------------------------------------------------------------------
-- Company:  Pentek 
-- Engineer: Michael Fernandez
-- 
-- Create Date: 8/18/2017
-- Design Name: px_vita49_unpkt_parser
-- Module Name: px_vita49_unpkt_parser
-- Project Name: px_vita49_pkt
-- Target Devices: Kintex Ultrascale
-- Tool Versions: Vivado 2017.2
-- Description: Packages Vita49 Header with Data
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 

-- (Additional Info)

----------------------------------------------------------------------------------

-- (Technical Support for Pentek's GateFlow FPGA Design Kits)  
-- Technical support for Pentek's GateFlow FPGA Design Kits is available via e-mail 
-- (fpgasupport@pentek.com) or by phone (201-818-5900 ext. 238, 9 AM to 5 PM US 
-- Eastern time.) Names or initials contained within the source code are part of 
-- our revision control regime.  Please do not try to use these references to 
-- pursue technical support                              

-- (c) Copyright 2017 Pentek, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Pentek, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Pentek, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND PENTEK HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Pentek shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Pentek had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Pentek products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Pentek products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_TEXTIO.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use ieee.numeric_std.all;

entity px_vita49_unpkt_parser is
  port (
    aclk                    : in  std_logic;
    aresetn                 : in  std_logic;
    aclken                  : in  std_logic;
    shifter                 : in  std_logic_vector(2 downto 0);
    packet_size             : in  std_logic_vector(15 downto 0);
    stream_id_en            : in  std_logic;
    class_id_en             : in  std_logic;
    integer_timestamp_en    : in  std_logic;
    fractional_timestamp_en : in  std_logic;
    trailer_en              : in  std_logic;
    contains_header         : in  std_logic;
    contains_trailer        : in  std_logic;
    s_axis_tvalid           : in  std_logic;
    s_axis_tready           : out std_logic;
    s_axis_tdata            : in  std_logic_vector(255 downto 0);
    s_axis_tkeep            : in  std_logic_vector(31 downto 0);
    s_axis_tlast            : in  std_logic;
    parser_error            : out std_logic;
    m_axis_tvalid           : out std_logic;
    m_axis_tready           : in  std_logic;
    m_axis_tdata            : out std_logic_vector(255 downto 0);
    m_axis_tkeep            : out std_logic_vector(31 downto 0);
    m_axis_tlast            : out std_logic;
    keep_label              : out std_logic_vector(7 downto 0)
    );
end px_vita49_unpkt_parser;


architecture behavioral of px_vita49_unpkt_parser is
  component px_vita49_unpkt_slice
    port (
      aclk          : in  std_logic;
      aresetn       : in  std_logic;
      s_axis_tvalid : in  std_logic;
      s_axis_tready : out std_logic;
      s_axis_tdata  : in  std_logic_vector(255 downto 0);
      s_axis_tkeep  : in  std_logic_vector(31 downto 0);
      s_axis_tlast  : in  std_logic;
      m_axis_tvalid : out std_logic;
      m_axis_tready : in  std_logic;
      m_axis_tdata  : out std_logic_vector(255 downto 0);
      m_axis_tkeep  : out std_logic_vector(31 downto 0);
      m_axis_tlast  : out std_logic
      );
  end component;
  component px_vita49_pkt_subtractor
    port (
      A  : in  std_logic_vector(15 downto 0);
      B  : in  std_logic_vector(7 downto 0);
      CE : in  std_logic;
      S  : out std_logic_vector(15 downto 0)
      );
  end component;

  signal data_remaining_to_count   : std_logic_vector(15 downto 0);
  signal data_remaining_to_count_p : std_logic_vector(15 downto 0);
  signal data_size                 : std_logic_vector(15 downto 0);
  signal header_size               : std_logic_vector(2 downto 0);
  signal next_label                : std_logic_vector(7 downto 0);
  signal data_counted              : std_logic_vector(15 downto 0);
  signal s_axis_tready_internal    : std_logic := '0';
  signal s_axis_tvalid_internal    : std_logic := '0';

begin

  header_size             <= 1 + ("00" & stream_id_en) + ("00" & class_id_en) + ("00" & class_id_en) + ("00" & integer_timestamp_en) + ("00" & fractional_timestamp_en) + ("00" & fractional_timestamp_en);
  data_remaining_to_count <= data_size - data_counted;

  latch_remaining_count : process(aclk, aresetn, aclken)
  begin
    if aresetn = '0' then
      data_remaining_to_count_p <= (others => '0');
      data_size                 <= (others => '0');
    elsif rising_edge(aclk) and aclken = '1' then
      if s_axis_tvalid_internal = '1' then
        data_size <= packet_size - 1 - (x"000" & "000" & stream_id_en) - (x"000" & "000" & class_id_en) - (x"000" & "000" & class_id_en) - (x"000" & "000" & integer_timestamp_en) - (x"000" & "000" & fractional_timestamp_en) - (x"000" & "000" & fractional_timestamp_en) - (x"000" & "000" & trailer_en);
      end if;
    end if;
  end process;

  parse_data : process(aclk, aresetn, aclken)
  begin
    if aresetn = '0' then
      keep_label   <= "11111111";
      next_label   <= "11111111";
      data_counted <= (others => '0');

    elsif rising_edge(aclk) and aclken = '1' then
      if s_axis_tvalid_internal = '1' and m_axis_tready = '1' then
        keep_label <= "11111111";
      end if;

      if s_axis_tvalid_internal = '1' and contains_trailer = '1' and m_axis_tready = '1' then
        case data_remaining_to_count is
          when x"0000" =>
            keep_label(0) <= '0';
          when x"0001" =>
            keep_label(1) <= '0';
          when x"0002" =>
            keep_label(2) <= '0';
          when x"0003" =>
            keep_label(3) <= '0';
          when x"0004" =>
            keep_label(4) <= '0';
          when x"0005" =>
            keep_label(5) <= '0';
          when x"0006" =>
            keep_label(6) <= '0';
          when x"0007" =>
            keep_label(7) <= '0';
          when others =>
            keep_label <= "00000000";   --this shouldnt happen
        end case;
      end if;

      if next_label /= "11111111" and s_axis_tvalid_internal = '1' and m_axis_tready = '1' then
        next_label <= "11111111";
        case next_label is
          when "11111110" =>
            keep_label(0) <= '0';
            data_counted  <= x"0007";
          when "11111100" =>
            keep_label(0) <= '0';
            keep_label(1) <= '0';
            data_counted  <= x"0006";
          when "11111000" =>
            keep_label(0) <= '0';
            keep_label(1) <= '0';
            keep_label(2) <= '0';
            data_counted  <= x"0005";
          when "11110000" =>
            keep_label(0) <= '0';
            keep_label(1) <= '0';
            keep_label(2) <= '0';
            keep_label(3) <= '0';
            data_counted  <= x"0004";
          when "11100000" =>
            keep_label(0) <= '0';
            keep_label(1) <= '0';
            keep_label(2) <= '0';
            keep_label(3) <= '0';
            keep_label(4) <= '0';
            data_counted  <= x"0003";
          when "11000000" =>
            keep_label(0) <= '0';
            keep_label(1) <= '0';
            keep_label(2) <= '0';
            keep_label(3) <= '0';
            keep_label(4) <= '0';
            keep_label(5) <= '0';
            data_counted  <= x"0002";
          when "10000000" =>
            keep_label(0) <= '0';
            keep_label(1) <= '0';
            keep_label(2) <= '0';
            keep_label(3) <= '0';
            keep_label(4) <= '0';
            keep_label(5) <= '0';
            keep_label(6) <= '0';
            data_counted  <= x"0001";
          when "00000000" =>
            keep_label(0) <= '0';
            keep_label(1) <= '0';
            keep_label(2) <= '0';
            keep_label(3) <= '0';
            keep_label(4) <= '0';
            keep_label(5) <= '0';
            keep_label(6) <= '0';
            keep_label(7) <= '0';
          when others =>
            keep_label <= "00000000";   --this shouldnt happen
        end case;
      end if;

      if contains_header = '1' and s_axis_tvalid_internal = '1' and m_axis_tready = '1' then
        next_label   <= "11111111";
        data_counted <= (others => '0');
        case shifter is
          when "000" =>
            case header_size is
              when "001" =>
                keep_label(0) <= '0';
                data_counted  <= x"0007";
              when "010" =>
                keep_label(0) <= '0';
                keep_label(1) <= '0';
                data_counted  <= x"0006";
              when "011" =>
                keep_label(0) <= '0';
                keep_label(1) <= '0';
                keep_label(2) <= '0';
                data_counted  <= x"0005";
              when "100" =>
                keep_label(0) <= '0';
                keep_label(1) <= '0';
                keep_label(2) <= '0';
                keep_label(3) <= '0';
                data_counted  <= x"0004";
              when "101" =>
                keep_label(0) <= '0';
                keep_label(1) <= '0';
                keep_label(2) <= '0';
                keep_label(3) <= '0';
                keep_label(4) <= '0';
                data_counted  <= x"0003";
              when "110" =>
                keep_label(0) <= '0';
                keep_label(1) <= '0';
                keep_label(2) <= '0';
                keep_label(3) <= '0';
                keep_label(4) <= '0';
                keep_label(5) <= '0';
                data_counted  <= x"0002";
              when "111" =>
                keep_label(0) <= '0';
                keep_label(1) <= '0';
                keep_label(2) <= '0';
                keep_label(3) <= '0';
                keep_label(4) <= '0';
                keep_label(5) <= '0';
                keep_label(6) <= '0';
                data_counted  <= x"0001";
              when others =>
                keep_label <= "00000000";  --this shouldnt happen
            end case;

          when "001" =>
            case header_size is
              when "001" =>
                keep_label(1) <= '0';
                data_counted  <= x"0006";
              when "010" =>
                keep_label(1) <= '0';
                keep_label(2) <= '0';
                data_counted  <= x"0005";
              when "011" =>
                keep_label(1) <= '0';
                keep_label(2) <= '0';
                keep_label(3) <= '0';
                data_counted  <= x"0004";
              when "100" =>
                keep_label(1) <= '0';
                keep_label(2) <= '0';
                keep_label(3) <= '0';
                keep_label(4) <= '0';
                data_counted  <= x"0003";
              when "101" =>
                keep_label(1) <= '0';
                keep_label(2) <= '0';
                keep_label(3) <= '0';
                keep_label(4) <= '0';
                keep_label(5) <= '0';
                data_counted  <= x"0002";
              when "110" =>
                keep_label(1) <= '0';
                keep_label(2) <= '0';
                keep_label(3) <= '0';
                keep_label(4) <= '0';
                keep_label(5) <= '0';
                keep_label(6) <= '0';
                data_counted  <= x"0001";
              when "111" =>
                keep_label(1) <= '0';
                keep_label(2) <= '0';
                keep_label(3) <= '0';
                keep_label(4) <= '0';
                keep_label(5) <= '0';
                keep_label(6) <= '0';
                keep_label(7) <= '0';
              when others =>
                keep_label <= "00000000";  --this shouldnt happen
            end case;

          when "010" =>
            case header_size is
              when "001" =>
                keep_label(2) <= '0';
                data_counted  <= x"0005";
              when "010" =>
                keep_label(2) <= '0';
                keep_label(3) <= '0';
                data_counted  <= x"0004";
              when "011" =>
                keep_label(2) <= '0';
                keep_label(3) <= '0';
                keep_label(4) <= '0';
                data_counted  <= x"0003";
              when "100" =>
                keep_label(2) <= '0';
                keep_label(3) <= '0';
                keep_label(4) <= '0';
                keep_label(5) <= '0';
                data_counted  <= x"0002";
              when "101" =>
                keep_label(2) <= '0';
                keep_label(3) <= '0';
                keep_label(4) <= '0';
                keep_label(5) <= '0';
                keep_label(6) <= '0';
                data_counted  <= x"0001";
              when "110" =>
                keep_label(2) <= '0';
                keep_label(3) <= '0';
                keep_label(4) <= '0';
                keep_label(5) <= '0';
                keep_label(6) <= '0';
                keep_label(7) <= '0';
              when "111" =>
                keep_label(2) <= '0';
                keep_label(3) <= '0';
                keep_label(4) <= '0';
                keep_label(5) <= '0';
                keep_label(6) <= '0';
                keep_label(7) <= '0';
                next_label(0) <= '0';
              when others =>
                keep_label <= "00000000";  --this shouldnt happen
            end case;


          when "011" =>
            case header_size is
              when "001" =>
                keep_label(3) <= '0';
                data_counted  <= x"0004";
              when "010" =>
                keep_label(3) <= '0';
                keep_label(4) <= '0';
                data_counted  <= x"0003";
              when "011" =>
                keep_label(3) <= '0';
                keep_label(4) <= '0';
                keep_label(5) <= '0';
                data_counted  <= x"0002";
              when "100" =>
                keep_label(3) <= '0';
                keep_label(4) <= '0';
                keep_label(5) <= '0';
                keep_label(6) <= '0';
                data_counted  <= x"0001";
              when "101" =>
                keep_label(3) <= '0';
                keep_label(4) <= '0';
                keep_label(5) <= '0';
                keep_label(6) <= '0';
                keep_label(7) <= '0';
              when "110" =>
                keep_label(3) <= '0';
                keep_label(4) <= '0';
                keep_label(5) <= '0';
                keep_label(6) <= '0';
                keep_label(7) <= '0';
                next_label(0) <= '0';
              when "111" =>
                keep_label(3) <= '0';
                keep_label(4) <= '0';
                keep_label(5) <= '0';
                keep_label(6) <= '0';
                keep_label(7) <= '0';
                next_label(0) <= '0';
                next_label(1) <= '0';
              when others =>
                keep_label <= "00000000";  --this shouldnt happen
            end case;
          when "100" =>
            case header_size is
              when "001" =>
                keep_label(4) <= '0';
                data_counted  <= x"0003";
              when "010" =>
                keep_label(4) <= '0';
                keep_label(5) <= '0';
                data_counted  <= x"0002";
              when "011" =>
                keep_label(4) <= '0';
                keep_label(5) <= '0';
                keep_label(6) <= '0';
                data_counted  <= x"0001";
              when "100" =>
                keep_label(4) <= '0';
                keep_label(5) <= '0';
                keep_label(6) <= '0';
                keep_label(7) <= '0';
              when "101" =>
                keep_label(4) <= '0';
                keep_label(5) <= '0';
                keep_label(6) <= '0';
                keep_label(7) <= '0';
                next_label(0) <= '0';
              when "110" =>
                keep_label(4) <= '0';
                keep_label(5) <= '0';
                keep_label(6) <= '0';
                keep_label(7) <= '0';
                next_label(0) <= '0';
                next_label(1) <= '0';
              when "111" =>
                keep_label(4) <= '0';
                keep_label(5) <= '0';
                keep_label(6) <= '0';
                keep_label(7) <= '0';
                next_label(0) <= '0';
                next_label(1) <= '0';
                next_label(2) <= '0';
              when others =>
                keep_label <= "00000000";  --this shouldnt happen
            end case;
          when "101" =>
            case header_size is
              when "001" =>
                keep_label(5) <= '0';
                data_counted  <= x"0002";
              when "010" =>
                keep_label(5) <= '0';
                keep_label(6) <= '0';
                data_counted  <= x"0001";
              when "011" =>
                keep_label(5) <= '0';
                keep_label(6) <= '0';
                keep_label(7) <= '0';
              when "100" =>
                keep_label(5) <= '0';
                keep_label(6) <= '0';
                keep_label(7) <= '0';
                next_label(0) <= '0';
              when "101" =>
                keep_label(5) <= '0';
                keep_label(6) <= '0';
                keep_label(7) <= '0';
                next_label(0) <= '0';
                next_label(1) <= '0';
              when "110" =>
                keep_label(5) <= '0';
                keep_label(6) <= '0';
                keep_label(7) <= '0';
                next_label(0) <= '0';
                next_label(1) <= '0';
                next_label(2) <= '0';
              when "111" =>
                keep_label(5) <= '0';
                keep_label(6) <= '0';
                keep_label(7) <= '0';
                next_label(0) <= '0';
                next_label(1) <= '0';
                next_label(2) <= '0';
                next_label(3) <= '0';
              when others =>
                keep_label <= "00000000";  --this shouldnt happen
            end case;
          when "110" =>
            case header_size is
              when "001" =>
                keep_label(6) <= '0';
                data_counted  <= x"0001";
              when "010" =>
                keep_label(6) <= '0';
                keep_label(7) <= '0';
              when "011" =>
                keep_label(6) <= '0';
                keep_label(7) <= '0';
                next_label(0) <= '0';
              when "100" =>
                keep_label(6) <= '0';
                keep_label(7) <= '0';
                next_label(0) <= '0';
                next_label(1) <= '0';
              when "101" =>
                keep_label(6) <= '0';
                keep_label(7) <= '0';
                next_label(0) <= '0';
                next_label(1) <= '0';
                next_label(2) <= '0';
              when "110" =>
                keep_label(6) <= '0';
                keep_label(7) <= '0';
                next_label(0) <= '0';
                next_label(1) <= '0';
                next_label(2) <= '0';
                next_label(3) <= '0';
              when "111" =>
                keep_label(6) <= '0';
                keep_label(7) <= '0';
                next_label(0) <= '0';
                next_label(1) <= '0';
                next_label(2) <= '0';
                next_label(3) <= '0';
                next_label(4) <= '0';
              when others =>
                keep_label <= "00000000";  --this shouldnt happen
            end case;
          when "111" =>
            case header_size is
              when "001" =>
                keep_label(7) <= '0';
              when "010" =>
                keep_label(7) <= '0';
                next_label(0) <= '0';
              when "011" =>
                keep_label(7) <= '0';
                next_label(0) <= '0';
                next_label(1) <= '0';
              when "100" =>
                keep_label(7) <= '0';
                next_label(0) <= '0';
                next_label(1) <= '0';
                next_label(2) <= '0';
              when "101" =>
                keep_label(7) <= '0';
                next_label(0) <= '0';
                next_label(1) <= '0';
                next_label(2) <= '0';
                next_label(3) <= '0';
              when "110" =>
                keep_label(7) <= '0';
                next_label(0) <= '0';
                next_label(1) <= '0';
                next_label(2) <= '0';
                next_label(3) <= '0';
                next_label(4) <= '0';
              when "111" =>
                keep_label(7) <= '0';
                next_label(0) <= '0';
                next_label(1) <= '0';
                next_label(2) <= '0';
                next_label(3) <= '0';
                next_label(4) <= '0';
                next_label(5) <= '0';
              when others =>
                keep_label <= "00000000";  --this shouldnt happen
            end case;
          when others =>
            keep_label <= "00000000";      --this shouldnt happen
        end case;
      end if;

      if contains_header = '0' and contains_trailer = '0' and next_label = "11111111" and s_axis_tvalid_internal = '1' and m_axis_tready = '1' then  -- data coming in, but not the header, still part of header, or the end then count 8 pieces of data. 
        data_counted <= data_counted + 8;
      end if;

    end if;
  end process;

  s_axis_tready          <= s_axis_tready_internal and m_axis_tready;
  s_axis_tvalid_internal <= s_axis_tvalid and m_axis_tready;

  px_vita49_unpkt_slice_inst3 : px_vita49_unpkt_slice
    port map (
      aclk          => aclk,
      aresetn       => aresetn,
      s_axis_tvalid => s_axis_tvalid_internal,
      s_axis_tready => s_axis_tready_internal,
      s_axis_tdata  => s_axis_tdata,
      s_axis_tkeep  => s_axis_tkeep,
      s_axis_tlast  => s_axis_tlast,
      m_axis_tvalid => m_axis_tvalid,
      m_axis_tready => m_axis_tready,
      m_axis_tdata  => m_axis_tdata,
      m_axis_tkeep  => m_axis_tkeep,
      m_axis_tlast  => m_axis_tlast
      );
end Behavioral;
