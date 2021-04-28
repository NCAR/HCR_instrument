----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 01/05/2016 08:13:34 AM
-- Design Name: 
-- Module Name: px_axil_addr_sub - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Substitutes a given value for the specified number of upper bits of an
-- AXI-Lite Address.
-- 
-- Dependencies: 
-- 
-- Revision: 0.01
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

-- (c) Copyright 2016 Pentek, Inc. All rights reserved.
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

--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axil_addr_sub is
generic (
   num_bits          : integer := 8; -- Number of Address Bits to Substitute
   sub_address       : std_logic_vector(31 downto 0) := x"00000000" -- Address value to substitute
);
port (
   axi_aclk        : in  std_logic;
   axi_aresetn     : in  std_logic;
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
   s_axi_awaddr    : in  std_logic_vector(31 downto 0);
   s_axi_awprot    : in  std_logic_vector(2 downto 0); -- not used
   s_axi_awvalid   : in  std_logic;
   s_axi_awready   : out std_logic;
   s_axi_wdata     : in  std_logic_vector(31 downto 0);
   s_axi_wstrb     : in  std_logic_vector(3 downto 0); 
   s_axi_wvalid    : in  std_logic;
   s_axi_wready    : out std_logic;
   s_axi_bresp     : out std_logic_vector(1 downto 0);
   s_axi_bvalid    : out std_logic;
   s_axi_bready    : in  std_logic;
   s_axi_araddr    : in  std_logic_vector(31 downto 0);
   s_axi_arprot    : in  std_logic_vector(2 downto 0); -- not used
   s_axi_arvalid   : in  std_logic;
   s_axi_arready   : out std_logic;
   s_axi_rdata     : out std_logic_vector(31 downto 0);
   s_axi_rresp     : out std_logic_vector(1 downto 0);
   s_axi_rvalid    : out std_logic;
   s_axi_rready    : in  std_logic;
--------------------------------------------------------------------------------
-- AXI LITE Master Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
   m_axi_awaddr    : out std_logic_vector(31 downto 0);
   m_axi_awprot    : out std_logic_vector(2 downto 0); -- not used
   m_axi_awvalid   : out std_logic;
   m_axi_awready   : in  std_logic;
   m_axi_wdata     : out std_logic_vector(31 downto 0);
   m_axi_wstrb     : out std_logic_vector(3 downto 0); 
   m_axi_wvalid    : out std_logic;
   m_axi_wready    : in  std_logic;
   m_axi_bresp     : in  std_logic_vector(1 downto 0);
   m_axi_bvalid    : in  std_logic;
   m_axi_bready    : out std_logic;
   m_axi_araddr    : out std_logic_vector(31 downto 0);
   m_axi_arprot    : out std_logic_vector(2 downto 0); -- not used
   m_axi_arvalid   : out std_logic;
   m_axi_arready   : in  std_logic;
   m_axi_rdata     : in  std_logic_vector(31 downto 0);
   m_axi_rresp     : in  std_logic_vector(1 downto 0);
   m_axi_rvalid    : in  std_logic;
   m_axi_rready    : out std_logic
  ); 
end px_axil_addr_sub;

architecture Behavioral of px_axil_addr_sub is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of axi_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 axi_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of axi_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi:m_axi, ASSOCIATED_RESET axi_aresetn";

begin


m_axi_awaddr    <= (sub_address(31 downto (32-num_bits)) & s_axi_awaddr((31-num_bits) downto 0)) when ((num_bits > 0) and ((num_bits < 32))) else 
                   s_axi_awaddr when (num_bits = 0) else
                   sub_address; 
m_axi_awprot    <= s_axi_awprot; 
m_axi_awvalid   <= s_axi_awvalid;
s_axi_awready   <= m_axi_awready;
m_axi_wdata     <= s_axi_wdata;  
m_axi_wstrb     <= s_axi_wstrb;  
m_axi_wvalid    <= s_axi_wvalid; 
s_axi_wready    <= m_axi_wready; 
s_axi_bresp     <= m_axi_bresp;  
s_axi_bvalid    <= m_axi_bvalid; 
m_axi_bready    <= s_axi_bready; 
m_axi_araddr    <= (sub_address(31 downto (32-num_bits)) & s_axi_araddr((31-num_bits) downto 0)) when ((num_bits > 0) and ((num_bits < 32))) else 
                   s_axi_araddr when (num_bits = 0) else
                   sub_address;  
m_axi_arprot    <= s_axi_arprot; 
m_axi_arvalid   <= s_axi_arvalid;
s_axi_arready   <= m_axi_arready;
s_axi_rdata     <= m_axi_rdata;  
s_axi_rresp     <= m_axi_rresp;  
s_axi_rvalid    <= m_axi_rvalid; 
m_axi_rready    <= s_axi_rready; 


end Behavioral;
