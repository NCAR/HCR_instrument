----------------------------------------------------------------------------------
-- Company:  Pentek 
-- Engineer: Michael Fernandez
-- 
-- Create Date: 01/04/2017
-- Design Name: udp_header
-- Module Name: px_10ge_udp_tx_udp
-- Project Name: px_10ge_udp_tx
-- Target Devices: Virtex 7
-- Tool Versions: Vivado 2016.4
-- Description: Creates the udp header
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

entity px_10ge_udp_tx_udp is
  port (
    clk              : in  std_logic;
    count            : in  std_logic_vector(15 downto 0);
    source_port      : in  std_logic_vector(15 downto 0) := (others => '0');
    destination_port : in  std_logic_vector(15 downto 0) := (others => '0');
    udp_header       : out std_logic_vector(63 downto 0)
    );
end px_10ge_udp_tx_udp;


architecture behavioral of px_10ge_udp_tx_udp is

  component px_10ge_udp_tx_multi8
    port (
      A : in  std_logic_vector(15 downto 0);
      P : out std_logic_vector(15 downto 0)
      );
  end component;

  signal udp_length  : std_logic_vector(15 downto 0) := (others => '0');  -- as 8 bytes for header + packet_data_size
  signal checksum    : std_logic_vector(15 downto 0) := (others => '0');  --unused
  signal data_length : std_logic_vector(15 downto 0) := (others => '0');
  signal count1      : std_logic_vector(15 downto 0) := (others => '0');
begin

  count1 <= count + 1;

  process(clk)
  begin
    if rising_edge(clk) then
      udp_length <= data_length + 8;
      checksum   <= x"0000";
      udp_header <= source_port & destination_port & udp_length & checksum;
    end if;
  end process;

  px_10ge_udp_tx_multi8_udp : px_10ge_udp_tx_multi8
    port map (
      A => count1,
      P => data_length
      );

end Behavioral;
