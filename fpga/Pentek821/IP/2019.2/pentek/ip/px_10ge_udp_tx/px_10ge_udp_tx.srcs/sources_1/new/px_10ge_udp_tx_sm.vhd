----------------------------------------------------------------------------------
-- Company:  Pentek 
-- Engineer: Michael Fernandez
-- 
-- Create Date: 01/04/2017
-- Design Name: sm
-- Module Name: px_10ge_udp_tx_sm
-- Project Name: px_10ge_udp_tx
-- Target Devices: Virtex 7
-- Tool Versions: Vivado 2016.4
-- Description: Builds the packets 64 bits per clock using the axis standard
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

entity px_10ge_udp_tx_sm is
  port (
    clk                 : in  std_logic;
    rstn                : in  std_logic;
    sm_enable           : in  std_logic;
    xilinx_core_rdy     : in  std_logic;
    fifo_rstn           : in  std_logic;
    mac_header          : in  std_logic_vector(111 downto 0);
    ip_header           : in  std_logic_vector(159 downto 0);
    udp_header          : in  std_logic_vector(63 downto 0);
    count_rd            : out std_logic;
    count               : in  std_logic_vector(15 downto 0);
    in_axis_data_count  : in  std_logic_vector(14 downto 0);
    out_axis_data_count : in  std_logic_vector(14 downto 0);
    s_axis_tvalid       : in  std_logic;
    s_axis_tready       : out std_logic;
    s_axis_tdata        : in  std_logic_vector(63 downto 0);
    s_axis_tkeep        : in  std_logic_vector(7 downto 0);
    s_axis_tlast        : in  std_logic;
    m_axis_tvalid       : out std_logic;
    m_axis_tready       : in  std_logic;
    m_axis_tdata        : out std_logic_vector(63 downto 0);
    m_axis_tkeep        : out std_logic_vector(7 downto 0);
    m_axis_tlast        : out std_logic;
    m_axis_tuser        : out std_logic_vector(0 downto 0)
    );
end px_10ge_udp_tx_sm;


architecture behavioral of px_10ge_udp_tx_sm is

  type ethernet_transfer_states is (reset_state,    --0
                                    idle,           --1
                                    eth_layer,      --2
                                    eth_ip_layer,   --3
                                    ip_layer,       --4
                                    ip_layer2,      --5
                                    ip_udp_layer,   --6
                                    udp_layer,      --7
                                    data_layer,     --8
                                    stop_fifo,      --9
                                    data_complete,  --10 
                                    error_state     --11
                                    );

  signal state            : ethernet_transfer_states;
  signal s_axis_tdata_old : std_logic_vector(63 downto 0);
  signal s_axis_tkeep_old : std_logic_vector(7 downto 0);
  signal counter          : integer;
  signal packet_data_size : integer;

begin

  packet_data_size <= to_integer(unsigned(count))+1;

  data_latch : process(clk)
  begin
    if rising_edge(clk) then
      if (rstn = '0') or (sm_enable = '0') then
        s_axis_tdata_old <= (others => '0');
        s_axis_tkeep_old <= (others => '0');
      else
        s_axis_tdata_old <= s_axis_tdata;
        s_axis_tkeep_old <= s_axis_tkeep;
      end if;
    end if;
  end process;


  ethernet_state_machine : process(rstn, clk, sm_enable)
  begin
    if rising_edge(clk) and sm_enable = '1' then
      if rstn = '0' then
        state <= reset_state;
      elsif (state /= reset_state and state /= idle) and fifo_rstn = '1' then
        state <= error_state;
      end if;
      case state is
        when reset_state =>
          ----------------------------------------------------------
          m_axis_tvalid   <= '0';
          m_axis_tkeep    <= x"00";
          m_axis_tdata    <= (others => '0');
          m_axis_tlast    <= '0';
          m_axis_tuser(0) <= '0';
          s_axis_tready   <= '0';
          count_rd        <= '0';
          counter         <= 0;
          if rstn = '0' then
            state <= reset_state;
          else
            state <= idle;
          end if;

        when idle =>
          ----------------------------------------------------------      
          if out_axis_data_count <= ((packet_data_size +1 +42)*2) and s_axis_tvalid = '1' and m_axis_tready = '1' and xilinx_core_rdy = '1' then
            m_axis_tvalid   <= '1';
            m_axis_tkeep    <= x"ff";
            m_axis_tdata    <= mac_header(55 downto 48) & mac_header(63 downto 56) & mac_header(71 downto 64) & mac_header(79 downto 72) & mac_header(87 downto 80) & mac_header(95 downto 88) & mac_header (103 downto 96) & mac_header(111 downto 104);
            m_axis_tlast    <= '0';
            m_axis_tuser(0) <= '0';
            state           <= eth_layer;
          else
            state <= idle;
          end if;

        when eth_layer =>
          m_axis_tdata <= ip_header (151 downto 144) & ip_header(159 downto 152) & mac_header(7 downto 0) & mac_header(15 downto 8)& mac_header(23 downto 16) & mac_header(31 downto 24) & mac_header(39 downto 32) & mac_header(47 downto 40);
          state        <= eth_ip_layer;

        when eth_ip_layer =>
          m_axis_tdata <= ip_header(87 downto 80) & ip_header(95 downto 88) & ip_header(103 downto 96) & ip_header(111 downto 104) & ip_header(119 downto 112) & ip_header(127 downto 120) & ip_header(135 downto 128) & ip_header(143 downto 136);
          state        <= ip_layer;

        when ip_layer =>
          m_axis_tdata <= ip_header(23 downto 16) & ip_header(31 downto 24) & ip_header(39 downto 32) & ip_header(47 downto 40) & ip_header(55 downto 48) & ip_header(63 downto 56) & ip_header(71 downto 64) & ip_header(79 downto 72);
          state        <= ip_layer2;

        when ip_layer2 =>
          m_axis_tdata  <= udp_header(23 downto 16) & udp_header(31 downto 24) & udp_header(39 downto 32) & udp_header(47 downto 40) & udp_header(55 downto 48) & udp_header(63 downto 56) & ip_header(7 downto 0) & ip_header(15 downto 8);
          s_axis_tready <= '1';
          state         <= ip_udp_layer;

        when ip_udp_layer =>
          m_axis_tdata <= s_axis_tdata(47 downto 0) & udp_header(7 downto 0) & udp_header(15 downto 8);
          state        <= udp_layer;

        when udp_layer =>
          m_axis_tdata <= s_axis_tdata(47 downto 0) & s_axis_tdata_old(63 downto 48);
          counter      <= counter + 1;
          state        <= data_layer;

        when data_layer =>
          ----------------------------------------------------------
          if counter >= ((packet_data_size)-2) then
            m_axis_tdata  <= s_axis_tdata(47 downto 0) & s_axis_tdata_old(63 downto 48);
            m_axis_tkeep  <= s_axis_tkeep(5 downto 0) & "11";
            counter       <= counter + 1;
            s_axis_tready <= '0';
            if (s_axis_tkeep(5) = '0' or s_axis_tkeep(4) = '0' or s_axis_tkeep(3) = '0' or s_axis_tkeep(2) = '0' or s_axis_tkeep(1) = '0' or s_axis_tkeep(0) = '0') or (s_axis_tkeep(6) = '0' and s_axis_tkeep(7) = '0') then
              m_axis_tlast <= '1';
              count_rd     <= '1';
              state        <= data_complete;
            else
              state <= stop_fifo;
            end if;
          else
            m_axis_tdata <= s_axis_tdata(47 downto 0) & s_axis_tdata_old(63 downto 48);
            counter      <= counter + 1;
            state        <= data_layer;
          end if;

        when stop_fifo =>
          ----------------------------------------------------------
          if counter >= ((packet_data_size)-1) then
            m_axis_tdata <= x"000000000000" & s_axis_tdata_old(63 downto 48);
            m_axis_tkeep <= "000000" & s_axis_tkeep_old(7) & s_axis_tkeep_old(6);
            m_axis_tlast <= '1';
            counter      <= counter + 1;
            count_rd     <= '1';
            state        <= data_complete;
          else
            m_axis_tdata <= s_axis_tdata(47 downto 0) & s_axis_tdata_old(63 downto 48);
            counter      <= counter + 1;
            state        <= data_layer;
          end if;

        when data_complete =>
          ----------------------------------------------------------
          m_axis_tvalid <= '0';
          m_axis_tkeep  <= x"00";
          m_axis_tdata  <= (others => '0');
          m_axis_tlast  <= '0';
          count_rd      <= '0';
          counter       <= 0;
          state         <= idle;

        when error_state =>
          ----------------------------------------------------------
          m_axis_tvalid   <= '1';
          m_axis_tkeep    <= x"00";
          m_axis_tdata    <= (others => '1');
          m_axis_tlast    <= '0';
          m_axis_tuser(0) <= '1';  --this causes the ip core to abort the frame 
          count_rd        <= '0';
          counter         <= 0;
          state           <= idle;


        when others =>
          --state <= reset_state;
          state <= error_state;

      end case;
    end if;
  end process;

end Behavioral;
