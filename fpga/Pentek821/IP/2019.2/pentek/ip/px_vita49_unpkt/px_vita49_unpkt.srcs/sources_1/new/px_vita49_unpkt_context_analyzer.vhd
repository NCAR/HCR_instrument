----------------------------------------------------------------------------------
-- Company:  Pentek 
-- Engineer: Michael Fernandez
-- 
-- Create Date: 8/18/2017
-- Design Name: px_vita49_unpkt_context_analyzer
-- Module Name: px_vita49_unpkt_context_analyzer
-- Project Name: px_vita49_unpkt
-- Target Devices: Kintex Ultrascale
-- Tool Versions: Vivado 2017.2
-- Description: Analyzer header for Vit49 Packet
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

entity px_vita49_unpkt_context_analyzer is
  port (
    aclk                    : in     std_logic;
    aresetn                 : in     std_logic;
    aclken                  : in     std_logic;
    tlast_enable            : in     std_logic;
    s_axis_tvalid           : in     std_logic;
    s_axis_tready           : out    std_logic;
    s_axis_tdata            : in     std_logic_vector(255 downto 0);
    s_axis_tkeep            : in     std_logic_vector(31 downto 0);
    s_axis_tlast            : in     std_logic;
    shifter                 : buffer std_logic_vector(2 downto 0) := (others => '0');
    packet_count_error      : out    std_logic;
    packet_size             : buffer std_logic_vector(15 downto 0);
    stream_id_en            : buffer std_logic;
    class_id_en             : buffer std_logic;
    integer_timestamp_en    : buffer std_logic;
    fractional_timestamp_en : buffer std_logic;
    trailer_en              : buffer std_logic;
    contains_header         : out    std_logic;
    contains_trailer        : out    std_logic;
    m_axis_tvalid           : out    std_logic;
    m_axis_tready           : in     std_logic;
    m_axis_tdata            : out    std_logic_vector(255 downto 0);
    m_axis_tkeep            : out    std_logic_vector(31 downto 0);
    m_axis_tlast            : out    std_logic

    );
end px_vita49_unpkt_context_analyzer;


architecture behavioral of px_vita49_unpkt_context_analyzer is

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

  signal s_axis_tdata_header      : std_logic_vector(31 downto 0) := (others => '0');
  signal tdata_latched            : std_logic                     := '0';
  signal count                    : std_logic_vector(15 downto 0) := (others => '0');
  signal packet_count             : std_logic_vector(3 downto 0)  := (others => '0');
  signal packet_count_p           : std_logic_vector(3 downto 0)  := (others => '0');
  signal remainder                : std_logic_vector(2 downto 0)  := (others => '0');
  signal remainder_sum            : std_logic_vector(2 downto 0)  := (others => '0');
  signal contains_delayed_trailer : std_logic;
  signal shifter_internal         : std_logic_vector(2 downto 0)  := (others => '0');
  signal s_axis_tready_internal   : std_logic                     := '0';
  signal s_axis_tvalid_internal   : std_logic                     := '0';


begin

  latch_first_data : process(aclk, aresetn, aclken)
  begin
    if aresetn = '0' then
      tdata_latched            <= '0';
      count                    <= (others => '0');
      remainder_sum            <= (others => '0');
      contains_header          <= '0';
      contains_trailer         <= '0';
      contains_delayed_trailer <= '0';
    elsif rising_edge(aclk) and aclken = '1' then
      if s_axis_tvalid = '0' and m_axis_tready = '1' then  --previous flag was eaten up this cycle
        contains_header  <= '0';
        contains_trailer <= '0';
      end if;
      if s_axis_tvalid_internal = '1' and tdata_latched = '0' and m_axis_tready = '1' then
        remainder_sum   <= remainder_sum + remainder;
        count           <= x"0008" - shifter_internal;
        tdata_latched   <= '1';
        contains_header <= '1';
        if contains_delayed_trailer = '1' then
          contains_trailer         <= '1';
          contains_delayed_trailer <= '0';
        else
          contains_trailer <= '0';
        end if;
--      elsif s_axis_tvalid_internal = '0' and m_axis_tready = '1' then  --no data, stop counting
--        contains_header  <= '0';
--        contains_trailer <= '0';

      elsif (s_axis_tlast = '1' and tlast_enable = '1') or (s_axis_tvalid_internal = '1' and packet_size - 8 = count and m_axis_tready = '1') then  -- this 256bit word evenly finishes
        tdata_latched <= '0';
        count         <= (others => '0');
        if trailer_en = '1' then
          contains_trailer <= '1';
        end if;

      elsif (packet_size - 8 - count) >= 1 and (packet_size - 8 - count) <= 7 and packet_size - 8 >= 8 and s_axis_tvalid_internal = '1' and m_axis_tready = '1' then  --if next 256bit word doesnt evenly finish
        tdata_latched   <= '0';
        contains_header <= '0';
        if trailer_en = '1' then        --this needs to be deylaed
          contains_delayed_trailer <= '1';
        end if;
      elsif (packet_size - count) >= 1 and (packet_size - count) <= 7 and packet_size - 8 < 8 and s_axis_tvalid_internal = '1' and m_axis_tready = '1' then  --if next 256bit word doesnt evenly finish
        tdata_latched   <= '0';
        contains_header <= '0';
        if trailer_en = '1' then        --this needs to be deylaed
          contains_trailer <= '1';
        end if;

      elsif s_axis_tvalid_internal = '1' and m_axis_tready = '1' then  --in the middle of data
        contains_header  <= '0';
        contains_trailer <= '0';
        count            <= count + 8;
      end if;
    end if;
  end process;


  latch_header : process(aclk, aresetn, aclken)
  begin
    if aresetn = '0' then
      s_axis_tdata_header <= (others => '0');
      shifter             <= (others => '0');
      packet_count_p      <= (others => '0');
    elsif rising_edge(aclk) and aclken = '1' then
      if s_axis_tvalid_internal = '1' then
        shifter <= shifter_internal;
      end if;
      if s_axis_tvalid_internal = '1' and tdata_latched = '0' and s_axis_tready_internal = '1' and m_axis_tready = '1' then
        packet_count_p <= packet_count;
        case shifter_internal is
          when "000"  => s_axis_tdata_header <= s_axis_tdata(31 downto 0);
          when "001"  => s_axis_tdata_header <= s_axis_tdata(63 downto 32);
          when "010"  => s_axis_tdata_header <= s_axis_tdata(95 downto 64);
          when "011"  => s_axis_tdata_header <= s_axis_tdata(127 downto 96);
          when "100"  => s_axis_tdata_header <= s_axis_tdata(159 downto 128);
          when "101"  => s_axis_tdata_header <= s_axis_tdata(191 downto 160);
          when "110"  => s_axis_tdata_header <= s_axis_tdata(223 downto 192);
          when "111"  => s_axis_tdata_header <= s_axis_tdata(255 downto 224);
          when others => s_axis_tdata_header <= x"DEADBEEF";
        end case;
      end if;
    end if;
  end process;



  shifter_internal <= remainder_sum + remainder;
  remainder        <= s_axis_tdata_header(2 downto 0) and "111";


  packet_count            <= s_axis_tdata_header(19 downto 16);
  packet_count_error      <= '0' when packet_count_p = x"0000" or packet_count_p = packet_count - 1 else '1';
  packet_size             <= s_axis_tdata_header(15 downto 0);
  stream_id_en            <= s_axis_tdata_header(28);
  class_id_en             <= s_axis_tdata_header(27);
  integer_timestamp_en    <= '0' when s_axis_tdata_header(23 downto 22) = "00"                      else '1';
  fractional_timestamp_en <= '0' when s_axis_tdata_header(21 downto 20) = "00"                      else '1';
  trailer_en              <= s_axis_tdata_header(26);


  s_axis_tready          <= s_axis_tready_internal and m_axis_tready;
  s_axis_tvalid_internal <= s_axis_tvalid and m_axis_tready;

  px_vita49_unpkt_slice_inst2 : px_vita49_unpkt_slice
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

