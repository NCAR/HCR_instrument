----------------------------------------------------------------------------------
-- Company:  Pentek 
-- Engineer: Michael Fernandez
-- 
-- Create Date: 01/04/2017
-- Design Name: ip_header
-- Module Name: px_10ge_udp_tx_ip
-- Project Name: px_10ge_udp_tx
-- Target Devices: Virtex 7
-- Tool Versions: Vivado 2016.4
-- Description: Generates IP header
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

entity px_10ge_udp_tx_ip is
  port (
    clk                 : in  std_logic;
    count               : in  std_logic_vector(15 downto 0);
    source_address      : in  std_logic_vector(31 downto 0) := (others => '0');
    destination_address : in  std_logic_vector(31 downto 0) := (others => '0');
    ip_header           : out std_logic_vector(159 downto 0)
    );
end px_10ge_udp_tx_ip;


architecture behavioral of px_10ge_udp_tx_ip is
  component px_10ge_udp_tx_checksum_adder
    port (
      A     : in  std_logic_vector(15 downto 0);
      B     : in  std_logic_vector(15 downto 0);
      C_IN  : in  std_logic;
      C_OUT : out std_logic;
      S     : out std_logic_vector(15 downto 0)
      );
  end component;
  component px_10ge_udp_tx_multi8
    port (
      A : in  std_logic_vector(15 downto 0);
      P : out std_logic_vector(15 downto 0)
      );
  end component;

  signal version              : std_logic_vector(3 downto 0)  := (others => '0');
  signal ip_header_length     : std_logic_vector(3 downto 0)  := (others => '0');
  signal type_of_service      : std_logic_vector(7 downto 0)  := (others => '0');
  signal size_datagram        : std_logic_vector(15 downto 0) := (others => '0');
  signal identification       : std_logic_vector(15 downto 0) := (others => '0');
  signal flags                : std_logic_vector(2 downto 0)  := (others => '0');
  signal fragmentation_offset : std_logic_vector(12 downto 0) := (others => '0');
  signal time_to_live         : std_logic_vector(7 downto 0)  := (others => '0');
  signal protocol             : std_logic_vector(7 downto 0)  := (others => '0');
  signal header_checksum      : std_logic_vector(15 downto 0) := (others => '0');
  signal udp_length           : std_logic_vector(15 downto 0) := (others => '0');
  signal header_checksum_ones : std_logic_vector(15 downto 0) := (others => '0');
  signal result1              : std_logic_vector(15 downto 0) := (others => '0');
  signal c_out_1              : std_logic                     := '0';
  signal result2              : std_logic_vector(15 downto 0) := (others => '0');
  signal c_out_2              : std_logic                     := '0';
  signal result3              : std_logic_vector(15 downto 0) := (others => '0');
  signal c_out_3              : std_logic                     := '0';
  signal result4              : std_logic_vector(15 downto 0) := (others => '0');
  signal c_out_4              : std_logic                     := '0';
  signal result5              : std_logic_vector(15 downto 0) := (others => '0');
  signal c_out_5              : std_logic                     := '0';
  signal data_length          : std_logic_vector(15 downto 0) := (others => '0');
  signal count1               : std_logic_vector(15 downto 0) := (others => '0');


begin
  count1               <= count + 1;
  udp_length           <= data_length + 8;  --packet_data_size + 8(Header length) 
  header_checksum_ones <= result5 + c_out_5;

  version              <= x"4";
  ip_header_length     <= x"5";
  type_of_service      <= x"00";
  size_datagram        <= udp_length + 20;  -- in bytes size of ip header(20) and data(540), 540decimal 21Chex; 
  identification       <= x"0001";
  flags                <= "100";        -- bit: 2=unused 1=dont fragment 0=move
  fragmentation_offset <= "0"& x"000";
  time_to_live         <= x"04";
  protocol             <= x"11";        --17=UDP
  header_checksum      <= not header_checksum_ones;

  process(clk)
  begin
    if rising_edge(clk) then

      ip_header(159 downto 128) <= version & ip_header_length & type_of_service & size_datagram;
      ip_header(127 downto 96)  <= identification & flags & fragmentation_offset;
      ip_header(95 downto 64)   <= time_to_live & protocol & header_checksum;
      ip_header(63 downto 32)   <= source_address;
      ip_header(31 downto 0)    <= destination_address;

    end if;
  end process;

  px_10ge_udp_tx_multi8_ip : px_10ge_udp_tx_multi8
    port map (
      A => count1,
      P => data_length
      );

--calculate checksum
  px_10ge_udp_tx_checksum_adder_1 : px_10ge_udp_tx_checksum_adder
    port map (
      A     => x"c912",
      B     => source_address(31 downto 16),
      C_IN  => '0',
      C_OUT => c_out_1,
      S     => result1
      );
  px_10ge_udp_tx_checksum_adder_2 : px_10ge_udp_tx_checksum_adder
    port map (
      A     => result1,
      B     => source_address(15 downto 0),
      C_IN  => c_out_1,
      C_OUT => c_out_2,
      S     => result2
      );
  px_10ge_udp_tx_checksum_adder_3 : px_10ge_udp_tx_checksum_adder
    port map (
      A     => result2,
      B     => destination_address(31 downto 16),
      C_IN  => c_out_2,
      C_OUT => c_out_3,
      S     => result3
      );
  px_10ge_udp_tx_checksum_adder_4 : px_10ge_udp_tx_checksum_adder
    port map (
      A     => result3,
      B     => destination_address(15 downto 0),
      C_IN  => c_out_3,
      C_OUT => c_out_4,
      S     => result4
      );
  px_10ge_udp_tx_checksum_adder_5 : px_10ge_udp_tx_checksum_adder
    port map (
      A     => result4,
      B     => size_datagram,
      C_IN  => c_out_4,
      C_OUT => c_out_5,
      S     => result5
      );

end Behavioral;
