----------------------------------------------------------------------------------
-- Company:  Pentek 
-- Engineer: Michael Fernandez
-- 
-- Create Date: 7/10/2017
-- Design Name: px_vita49_pkt_packet_sm
-- Module Name: px_vita49_pkt_packet_sm
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

entity packet_sm is
  port (

    aclk                  : in  std_logic;
    aresetn               : in  std_logic;
    aclken                : in  std_logic;
    trailer               : in  std_logic_vector(31 downto 0);
    sm_error              : out std_logic;
    s_axis_payload_tvalid : in  std_logic;
    s_axis_payload_tready : out std_logic;
    s_axis_payload_tdata  : in  std_logic_vector(255 downto 0);
    s_axis_payload_tkeep  : in  std_logic_vector(15 downto 0);
    s_axis_payload_tlast  : in  std_logic;
    s_axis_payload_tuser  : in  std_logic_vector(79 downto 0);
    s_axis_header_tvalid  : in  std_logic;
    s_axis_header_tready  : out std_logic;
    s_axis_header_tdata   : in  std_logic_vector(255 downto 0);
    s_axis_header_tuser   : in  std_logic_vector(79 downto 0);
    m_axis_tvalid         : out std_logic;
    m_axis_tready         : in  std_logic;
    m_axis_tdata          : out std_logic_vector(255 downto 0);
    m_axis_tkeep          : out std_logic_vector(15 downto 0);
    m_axis_tlast          : out std_logic;
    m_axis_tuser          : out std_logic_vector(79 downto 0)
    );
end packet_sm;


architecture behavioral of packet_sm is
  component px_vita49_pkt_axis_slice
    port (
      aclk          : in  std_logic;
      aresetn       : in  std_logic;
      aclken        : in  std_logic;
      s_axis_tvalid : in  std_logic;
      s_axis_tready : out std_logic;
      s_axis_tdata  : in  std_logic_vector(31 downto 0);
      s_axis_tkeep  : in  std_logic_vector(3 downto 0);
      s_axis_tlast  : in  std_logic;
      s_axis_tuser  : in  std_logic_vector(79 downto 0);
      m_axis_tvalid : out std_logic;
      m_axis_tready : in  std_logic;
      m_axis_tdata  : out std_logic_vector(31 downto 0);
      m_axis_tkeep  : out std_logic_vector(3 downto 0);
      m_axis_tlast  : out std_logic;
      m_axis_tuser  : out std_logic_vector(79 downto 0)
      );
  end component;

  type vita49_transfer_states is (reset_state,      --0
                                  pop,              --1
                                  pop_finish,       --1
                                  packet_start,     --2
                                  data_layer,       --3
                                  packet_complete,  --4 
                                  packet_last,
                                  error_state       --5
                                  );

  signal state                       : vita49_transfer_states;
  signal data_size                   : std_logic_vector(15 downto 0)  := (others => '0');
  signal data_size_latched           : std_logic                      := '0';
  signal counter                     : std_logic_vector(15 downto 0)  := (others => '0');
  signal s_axis_payload_tvalid_p1    : std_logic                      := '0';
  signal s_axis_payload_tdata_p1     : std_logic_vector(255 downto 0) := (others => '0');
  signal s_axis_payload_tkeep_p1     : std_logic_vector(15 downto 0)  := (others => '0');
  signal s_axis_payload_tlast_p1     : std_logic                      := '0';
  signal s_axis_payload_tuser_p1     : std_logic_vector(79 downto 0)  := (others => '0');
  signal s_axis_payload_tvalid_p2    : std_logic                      := '0';
  signal s_axis_payload_tdata_p2     : std_logic_vector(255 downto 0) := (others => '0');
  signal s_axis_payload_tkeep_p2     : std_logic_vector(15 downto 0)  := (others => '0');
  signal s_axis_payload_tlast_p2     : std_logic                      := '0';
  signal s_axis_payload_tuser_p2     : std_logic_vector(79 downto 0)  := (others => '0');
  signal s_axis_payload_tready_local : std_logic                      := '0';
  signal data_size_p1                   : std_logic_vector(15 downto 0)  := (others => '0');
  
begin
  s_axis_payload_tready <= s_axis_payload_tready_local and m_axis_tready;

  data_latch : process(aclk)
  begin
    if rising_edge(aclk) then
      if (aclken = '1' and s_axis_payload_tvalid = '1' and m_axis_tready = '1') then
        s_axis_payload_tvalid_p1 <= s_axis_payload_tvalid;
        s_axis_payload_tdata_p1  <= s_axis_payload_tdata;
        s_axis_payload_tkeep_p1  <= s_axis_payload_tkeep;
        s_axis_payload_tlast_p1  <= s_axis_payload_tlast;
        s_axis_payload_tuser_p1  <= s_axis_payload_tuser;
        s_axis_payload_tvalid_p2 <= s_axis_payload_tvalid_p1;
        s_axis_payload_tdata_p2  <= s_axis_payload_tdata_p1;
        s_axis_payload_tkeep_p2  <= s_axis_payload_tkeep_p1;
        s_axis_payload_tlast_p2  <= s_axis_payload_tlast_p1;
        s_axis_payload_tuser_p2  <= s_axis_payload_tuser_p1;
      elsif (aclken = '1' and s_axis_payload_tvalid = '0') then
        s_axis_payload_tvalid_p1 <= s_axis_payload_tvalid;
        s_axis_payload_tvalid_p2 <= s_axis_payload_tvalid_p1;
      end if;

      if (aclken = '1' and s_axis_payload_tvalid_p1 = '1' and m_axis_tready = '1') then
        s_axis_payload_tvalid_p2 <= s_axis_payload_tvalid_p1;
        s_axis_payload_tdata_p2  <= s_axis_payload_tdata_p1;
        s_axis_payload_tkeep_p2  <= s_axis_payload_tkeep_p1;
        s_axis_payload_tlast_p2  <= s_axis_payload_tlast_p1;
        s_axis_payload_tuser_p2  <= s_axis_payload_tuser_p1;
      elsif (aclken = '1' and s_axis_payload_tvalid_p1 = '0') then
        s_axis_payload_tvalid_p2 <= s_axis_payload_tvalid_p1;
      end if;

      if (aresetn = '0') then
        s_axis_payload_tvalid_p1 <= '0';
        s_axis_payload_tdata_p1  <= (others => '0');
        s_axis_payload_tkeep_p1  <= (others => '0');
        s_axis_payload_tlast_p1  <= '0';
        s_axis_payload_tuser_p1  <= (others => '0');
        s_axis_payload_tvalid_p2 <= '0';
        s_axis_payload_tdata_p2  <= (others => '0');
        s_axis_payload_tkeep_p2  <= (others => '0');
        s_axis_payload_tlast_p2  <= '0';
        s_axis_payload_tuser_p2  <= (others => '0');
      end if;

    end if;
  end process;

  count_latch : process(aclk)
  begin
    if rising_edge(aclk) then
     data_size_p1 <= data_size; --this is to fix timing. 
      if (aresetn = '0') then
        data_size         <= (others => '0');
        data_size_p1      <= (others => '0');
        data_size_latched <= '0';
      elsif (aclken = '1' and s_axis_header_tvalid = '1' and data_size_latched = '0') then
        data_size         <= s_axis_header_tdata(15 downto 0) - 8;
        data_size_latched <= '1';
      elsif (aclken = '1' and s_axis_payload_tlast_p1 = '1') then
        data_size         <= (others => '0');
        data_size_latched <= '0';
      end if;
    end if;
  end process;


  vita49_state_machine : process(aresetn, aclk, aclken)
  begin
    if rising_edge(aclk) then
      if aresetn = '0' then
        state <= reset_state;

      elsif aclken = '1' then
        case state is
          when reset_state =>
            counter                     <= (others => '0');
            s_axis_payload_tready_local <= '0';
            s_axis_header_tready        <= '0';
            m_axis_tvalid               <= '0';
            m_axis_tdata                <= (others => '0');
            m_axis_tkeep                <= (others => '0');
            m_axis_tlast                <= '0';
            m_axis_tuser                <= (others => '0');
            if aresetn = '1' then
              state <= pop;
            end if;

          when pop =>
            if m_axis_tready = '1' then
              m_axis_tvalid <= '0';
              if s_axis_header_tvalid = '1' and s_axis_payload_tvalid = '1' then
                counter                     <= (others => '0');
                m_axis_tvalid               <= '0';
                m_axis_tdata                <= (others => '0');
                m_axis_tkeep                <= (others => '0');
                m_axis_tlast                <= '0';
                m_axis_tuser                <= (others => '0');
                s_axis_payload_tready_local <= '1';
                state                       <= pop_finish;
              end if;
            -- else
            --   s_axis_payload_tready_local <= '0';
            end if;

          when pop_finish =>
            if m_axis_tready = '1' then
              state   <= packet_start;
              counter <= counter + 8;
            -- else
            -- s_axis_payload_tready_local <= '0';
            end if;


          when packet_start =>
            if s_axis_header_tvalid = '1' and s_axis_payload_tvalid_p1 = '1' and m_axis_tready = '1' then
              counter                     <= counter + 8;
              s_axis_header_tready        <= '1';
              s_axis_payload_tready_local <= '1';
              m_axis_tvalid               <= '1';
              m_axis_tdata                <= s_axis_payload_tdata_p1(31 downto 0) & s_axis_header_tdata(223 downto 0);
              m_axis_tkeep                <= s_axis_payload_tkeep_p1(1 downto 0) & "11" & x"FFF";
              m_axis_tlast                <= '0';
              m_axis_tuser                <= s_axis_header_tuser;
              if counter >= data_size_p1-1 then
                state <= packet_complete;
              else
                state <= data_layer;
              end if;
            -- else
            --   s_axis_payload_tready_local <= '0';
            end if;

          when data_layer =>
            s_axis_header_tready <= '0';
            --m_axis_tvalid <= s_axis_payload_tvalid_p1 and s_axis_payload_tvalid;
            if s_axis_payload_tvalid = '1' and m_axis_tready = '1' then
              s_axis_payload_tready_local <= '1';
            -- else
            --   s_axis_payload_tready_local <= '0';
            end if;
            if m_axis_tready = '1' then
              m_axis_tvalid <= s_axis_payload_tvalid_p1 and s_axis_payload_tvalid;
              if (s_axis_payload_tvalid = '1' and s_axis_payload_tvalid_p1 = '1') or (s_axis_payload_tvalid_p1 = '1' and counter >= data_size_p1-8)then
                counter      <= counter + 8;
                m_axis_tvalid <= '1';
                m_axis_tdata <= s_axis_payload_tdata_p1(31 downto 0) & s_axis_payload_tdata_p2(255 downto 32);
                m_axis_tkeep <= s_axis_payload_tkeep_p1(1 downto 0) & s_axis_payload_tkeep_p2(15 downto 2);
                m_axis_tlast <= '0';
                m_axis_tuser <= s_axis_payload_tuser_p1;
                if s_axis_payload_tlast_p1 = '1' then
                  state                       <= packet_last;
                  s_axis_payload_tready_local <= '0';

                  if s_axis_payload_tkeep_p1 < x"0003" then
                    m_axis_tdata <= trailer(15 downto 0) & s_axis_payload_tdata_p1(15 downto 0) & s_axis_payload_tdata_p2(255 downto 32);
                    m_axis_tkeep <= "1" & s_axis_payload_tkeep_p1(0) & s_axis_payload_tkeep_p2(15 downto 2);

                  end if;
                elsif counter >= data_size_p1-1 then
                  state <= packet_complete;
                elsif counter >= data_size_p1-8 then
                  s_axis_payload_tready_local <= '0';

                end if;
--                if counter >= data_size_p1-8 then
--                  s_axis_payload_tready_local <= '0';
--                end if;


              end if;
            end if;

          when packet_complete =>
            s_axis_payload_tready_local <= '0';
            m_axis_tvalid               <= s_axis_payload_tvalid_p1;
            if s_axis_payload_tvalid_p2 = '1' and m_axis_tready = '1' then
              s_axis_header_tready <= '0';
              m_axis_tvalid        <= s_axis_payload_tvalid_p2;
              m_axis_tdata         <= trailer & s_axis_payload_tdata_p2(255 downto 32);
              m_axis_tkeep         <= "11" & s_axis_payload_tkeep_p2(15 downto 2);
              m_axis_tlast         <= '0';
              m_axis_tuser         <= s_axis_payload_tuser_p2;
              state                <= pop;
            -- else
            --   s_axis_payload_tready_local <= '0';
            end if;

          when packet_last =>
            s_axis_payload_tready_local <= '0';
            m_axis_tvalid               <= s_axis_payload_tvalid_p1;
            if s_axis_payload_tvalid_p2 = '1' and m_axis_tready = '1' then
              s_axis_header_tready <= '0';
              m_axis_tvalid        <= s_axis_payload_tvalid_p2;
              m_axis_tlast         <= '1';
              m_axis_tuser         <= s_axis_payload_tuser_p2;
              state                <= pop;
              if s_axis_payload_tkeep_p2 = x"FFFF" then
                m_axis_tdata <= trailer & s_axis_payload_tdata_p2(255 downto 32);
                m_axis_tkeep <= "11" & s_axis_payload_tkeep_p2(15 downto 2);
              elsif s_axis_payload_tkeep_p2 = x"7FFF" then
                m_axis_tdata <= x"0000" & trailer & s_axis_payload_tdata_p2(239 downto 32);
                m_axis_tkeep <= "011" & s_axis_payload_tkeep_p2(14 downto 2);
              elsif s_axis_payload_tkeep_p2 = x"3FFF" then
                m_axis_tdata <= x"00000000" & trailer & s_axis_payload_tdata_p2(223 downto 32);
                m_axis_tkeep <= "0011" & s_axis_payload_tkeep_p2(13 downto 2);
              elsif s_axis_payload_tkeep_p2 = x"1FFF" then
                m_axis_tdata <= x"000000000000" & trailer & s_axis_payload_tdata_p2(207 downto 32);
                m_axis_tkeep <= "00011" & s_axis_payload_tkeep_p2(12 downto 2);
              elsif s_axis_payload_tkeep_p2 = x"0FFF" then
                m_axis_tdata <= x"0000000000000000" & trailer & s_axis_payload_tdata_p2(191 downto 32);
                m_axis_tkeep <= "000011" & s_axis_payload_tkeep_p2(11 downto 2);
              elsif s_axis_payload_tkeep_p2 = x"07FF" then
                m_axis_tdata <= x"00000000000000000000" & trailer & s_axis_payload_tdata_p2(175 downto 32);
                m_axis_tkeep <= "0000011" & s_axis_payload_tkeep_p2(10 downto 2);
              elsif s_axis_payload_tkeep_p2 = x"03FF" then
                m_axis_tdata <= x"000000000000000000000000" & trailer & s_axis_payload_tdata_p2(159 downto 32);
                m_axis_tkeep <= "00000011" & s_axis_payload_tkeep_p2(9 downto 2);
              elsif s_axis_payload_tkeep_p2 = x"01FF" then
                m_axis_tdata <= x"0000000000000000000000000000" & trailer & s_axis_payload_tdata_p2(143 downto 32);
                m_axis_tkeep <= "000000011" & s_axis_payload_tkeep_p2(8 downto 2);
              elsif s_axis_payload_tkeep_p2 = x"00FF" then
                m_axis_tdata <= x"00000000000000000000000000000000" & trailer & s_axis_payload_tdata_p2(127 downto 32);
                m_axis_tkeep <= "0000000011" & s_axis_payload_tkeep_p2(7 downto 2);
              elsif s_axis_payload_tkeep_p2 = x"007F" then
                m_axis_tdata <= x"000000000000000000000000000000000000" & trailer & s_axis_payload_tdata_p2(111 downto 32);
                m_axis_tkeep <= "00000000011" & s_axis_payload_tkeep_p2(6 downto 2);
              elsif s_axis_payload_tkeep_p2 = x"003F" then
                m_axis_tdata <= x"0000000000000000000000000000000000000000" & trailer & s_axis_payload_tdata_p2(95 downto 32);
                m_axis_tkeep <= "000000000011" & s_axis_payload_tkeep_p2(5 downto 2);
              elsif s_axis_payload_tkeep_p2 = x"001F" then
                m_axis_tdata <= x"00000000000000000000000000000000000000000000" & trailer & s_axis_payload_tdata_p2(79 downto 32);
                m_axis_tkeep <= "0000000000011" & s_axis_payload_tkeep_p2(4 downto 2);
              elsif s_axis_payload_tkeep_p2 = x"0007" then
                m_axis_tdata <= x"000000000000000000000000000000000000000000000000" & trailer & s_axis_payload_tdata_p2(63 downto 32);
                m_axis_tkeep <= "00000000000011" & s_axis_payload_tkeep_p2(3 downto 2);
              elsif s_axis_payload_tkeep_p2 = x"0003" then
                m_axis_tdata <= x"00000000000000000000000000000000000000000000000000000000" & trailer;
                m_axis_tkeep <= "0000000000000011";
              elsif s_axis_payload_tkeep_p2 = x"0001" then
                m_axis_tdata <= x"000000000000000000000000000000000000000000000000000000000000" & trailer(31 downto 16);
                m_axis_tkeep <= "0000000000000001";
              elsif s_axis_payload_tkeep_p2 = x"0000" then
                state <= error_state;
              else
                state <= error_state;
              end if;
            end if;

          when error_state =>
            sm_error <= '1';
          when others =>
            state <= error_state;
        end case;
      end if;
    end if;
  end process;

end Behavioral;
