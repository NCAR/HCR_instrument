----------------------------------------------------------------------------------
-- Company:  Pentek 
-- Engineer: Michael Fernandez
-- 
-- Create Date: 02/09/2017
-- Design Name: counter 
-- Module Name: px_10ge_udp_tx_counter
-- Project Name: px_10ge_udp_tx
-- Target Devices: Virtex 7
-- Tool Versions: Vivado 2016.4
-- Description: Counts until tlast or predefined count
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

entity px_10ge_udp_tx_counter is
  port (
    clk                  : in  std_logic;
    rstn                 : in  std_logic;
    packet_max_size      : in  std_logic_vector(15 downto 0);
    custom_size_enable   : in  std_logic;
    s_axis_eth_tvalid    : in  std_logic;
    s_axis_eth_tready    : in  std_logic;
    s_axis_eth_tkeep     : in  std_logic_vector(7 downto 0);
    s_axis_eth_tlast     : in  std_logic;
    s_axis_eth_tlast_fix : out std_logic;
    counter_error        : out std_logic;
    count_rd             : in  std_logic;
    count                : out std_logic_vector(15 downto 0)
    );
end px_10ge_udp_tx_counter;


architecture behavioral of px_10ge_udp_tx_counter is

  component px_10ge_udp_tx_count_fifo
    port (
      clk   : in  std_logic;
      srst  : in  std_logic;
      din   : in  std_logic_vector(15 downto 0);
      wr_en : in  std_logic;
      rd_en : in  std_logic;
      dout  : out std_logic_vector(15 downto 0);
      full  : out std_logic;
      empty : out std_logic
      );
  end component;

  signal rst      : std_logic;
  signal counter  : std_logic_vector(15 downto 0);
  signal count_wr : std_logic;
  signal counted  : std_logic_vector(15 downto 0);
  signal din      : std_logic_vector(15 downto 0);
  signal dout     : std_logic_vector(15 downto 0);
  signal pds_fix  : std_logic_vector(15 downto 0);
  signal c_error  : std_logic;
begin

  rst           <= not rstn;
  pds_fix       <= x"007F" when packet_max_size = x"400" else
                   x"03FF" when packet_max_size = x"2000";
  counter_error <= c_error;

  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        counter  <= (others => '0');
        count_wr <= '0';
        counted  <= (others => '0');
        c_error  <= '0';
      elsif (custom_size_enable = '1' and s_axis_eth_tlast = '1' and s_axis_eth_tkeep = x"00") or c_error = '1' then  --counter error, tlast cant be one while tkeep is all zeros. This must be reset.
        c_error <= '1';
      elsif custom_size_enable = '1'and s_axis_eth_tlast = '1' then
        counter  <= counter + 1;
        count_wr <= '1';
        counted  <= counter;
        counter  <= (others => '0');
      elsif s_axis_eth_tvalid = '1' and s_axis_eth_tready = '1' and counter = pds_fix then
        counter  <= counter + 1;
        count_wr <= '1';
        counted  <= counter;
        counter  <= (others => '0');
      elsif s_axis_eth_tvalid = '1' and s_axis_eth_tready = '1' and counter < pds_fix then
        counter  <= counter + 1;
        count_wr <= '0';
      end if;
    end if;
  end process;

  px_10ge_udp_tx_count_fifo_inst : px_10ge_udp_tx_count_fifo
    port map (
      clk   => clk,
      srst  => rst,
      din   => counted,
      wr_en => count_wr,
      rd_en => count_rd,
      dout  => dout,
      full  => open,
      empty => open
      );

  din <= counted when custom_size_enable = '1' else
         x"007F" when packet_max_size = x"0400" else
         x"03FF" when packet_max_size = x"2000" else
         x"DEAD";

  s_axis_eth_tlast_fix <= '1' when counter = pds_fix else  --forces '1' when max size met else looks for real tlast when custom size enabled else 0
                          s_axis_eth_tlast when custom_size_enable = '1' else
                          '0';

  count <= dout when custom_size_enable = '1' else
           x"007F" when packet_max_size = x"0400" else
           x"03FF" when packet_max_size = x"2000" else
           x"DEAD";
end Behavioral;
