----------------------------------------------------------------------------------
-- Company:  Pentek 
-- Engineer: Michael Fernandez
-- 
-- Create Date: 04/10/2017
-- Design Name: Packet Parser 
-- Module Name: px_10ge_udp_rx_pkt_parse
-- Project Name: px_10ge_udp_rx
-- Target Devices: Virtex 7
-- Tool Versions: Vivado 2016.4
-- Description: Removes the header from the data.
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

entity px_10ge_udp_rx_pkt_parse is
  port (
    axis_aclk        : in  std_logic;
    axis_aresetn     : in  std_logic;
    s_axis_rx_tvalid : in  std_logic;
    s_axis_rx_tdata  : in  std_logic_vector(63 downto 0);
    s_axis_rx_tkeep  : in  std_logic_vector(7 downto 0);
    s_axis_rx_tlast  : in  std_logic;
    s_axis_rx_tuser  : in  std_logic_vector(0 downto 0);
    m_axis_tvalid    : out std_logic;
    m_axis_tready    : in  std_logic;
    m_axis_tdata     : out std_logic_vector(63 downto 0);
    m_axis_tkeep     : out std_logic_vector(7 downto 0);
    m_axis_tlast     : out std_logic;
    m_axis_tuser     : out std_logic_vector(0 downto 0);
    mac_source       : out std_logic_vector(47 downto 0);
    ip_source        : out std_logic_vector(31 downto 0);
    port_source      : out std_logic_vector(15 downto 0);
    parse_error      : out std_logic
    );
end px_10ge_udp_rx_pkt_parse;


architecture behavioral of px_10ge_udp_rx_pkt_parse is

  type ethernet_transfer_states is (reset_state,
                                    idle,
                                    mac_addr,
                                    skip1,
                                    ip_addr,
                                    udp_port,
                                    skip2,
                                    data,
                                    data_last,
                                    error_state
                                    );

  signal state               : ethernet_transfer_states;
  signal s_axis_rx_tdata_old : std_logic_vector(63 downto 0);
  signal s_axis_rx_tkeep_old : std_logic_vector(7 downto 0);

  signal mac_dest  : std_logic_vector(47 downto 0);
  signal ip_dest   : std_logic_vector(31 downto 0);
  signal port_dest : std_logic_vector(15 downto 0);

begin

  data_latch : process(axis_aclk)
  begin
    if rising_edge(axis_aclk) then
      if (axis_aresetn = '0') then
        s_axis_rx_tdata_old <= (others => '0');
        s_axis_rx_tkeep_old <= (others => '0');
      else
        s_axis_rx_tdata_old <= s_axis_rx_tdata;
        s_axis_rx_tkeep_old <= s_axis_rx_tkeep;
      end if;
    end if;
  end process;

  parse_data : process(axis_aclk)
  begin
    if rising_edge(axis_aclk) then
      if axis_aresetn = '0' then
        state <= reset_state;
      end if;
      case state is
        when reset_state =>
          if axis_aresetn = '1' then
            state <= idle;
          end if;

        when idle =>
          m_axis_tvalid <= '0';
          m_axis_tdata  <= (others => '0');
          m_axis_tkeep  <= (others => '0');
          m_axis_tlast  <= '0';
          if s_axis_rx_tvalid = '1' then
            mac_source(47 downto 0) <= s_axis_rx_tdata(7 downto 0) & s_axis_rx_tdata(15 downto 8) & s_axis_rx_tdata(23 downto 16) & s_axis_rx_tdata(31 downto 24) & s_axis_rx_tdata(39 downto 32) & s_axis_rx_tdata(47 downto 40);
            state                   <= mac_addr;
          end if;

        when mac_addr =>
          --  mac_source(31 downto 0) <= s_axis_rx_tdata_old(23 downto 16) & s_axis_rx_tdata_old(31 downto 24) & s_axis_rx_tdata_old(39 downto 32) & s_axis_rx_tdata_old(47 downto 40);
          -- mac_dest() <= s_axis_rx_tdata_old(23 downto 16) & s_axis_rx_tdata_old(31 downto 24) & s_axis_rx_tdata_old(39 downto 32) & s_axis_rx_tdata_old(47 downto 40);
          state <= skip1;

        when skip1 =>
          state <= ip_addr;

        when ip_addr =>
          ip_source <= s_axis_rx_tdata(23 downto 16) & s_axis_rx_tdata(31 downto 24) & s_axis_rx_tdata(39 downto 32) & s_axis_rx_tdata(47 downto 40);
          state     <= udp_port;

        when udp_port =>
          port_dest   <= s_axis_rx_tdata(39 downto 32) & s_axis_rx_tdata(47 downto 40);  --destination
          port_source <= s_axis_rx_tdata(23 downto 16) & s_axis_rx_tdata(31 downto 24);
          state       <= skip2;

        when skip2 =>
          state <= data;

        when data =>
          if m_axis_tready = '0' then
            state <= error_state;       --fifo was full
          else
            m_axis_tvalid <= '1';
            m_axis_tdata  <= s_axis_rx_tdata(15 downto 0) & s_axis_rx_tdata_old(63 downto 16);
            m_axis_tkeep  <= s_axis_rx_tkeep(1 downto 0) & s_axis_rx_tkeep_old(7 downto 2);
          end if;
          if s_axis_rx_tlast = '1' then
            if s_axis_rx_tkeep(2) = '1' or s_axis_rx_tkeep(3) = '1' or s_axis_rx_tkeep(4) = '1' or s_axis_rx_tkeep(5) = '1' or s_axis_rx_tkeep(6) = '1' or s_axis_rx_tkeep(7) = '1' then  --more data to send
              state <= data_last;
            else
              m_axis_tlast <= '1';
              state        <= idle;
            end if;
          end if;

        when data_last =>
          if m_axis_tready = '0' then
            state <= error_state;       --fifo was full
          else
            m_axis_tdata <= x"0000" & s_axis_rx_tdata_old(63 downto 16);
            m_axis_tkeep <= "00" & s_axis_rx_tkeep_old(7 downto 2);
            m_axis_tlast <= '1';
            state        <= idle;

          end if;

        when error_state =>
          parse_error     <= '1';
          m_axis_tuser(0) <= '1';
          state           <= idle;

        when others =>
          state <= error_state;

      end case;
    end if;
  end process;

end Behavioral;
