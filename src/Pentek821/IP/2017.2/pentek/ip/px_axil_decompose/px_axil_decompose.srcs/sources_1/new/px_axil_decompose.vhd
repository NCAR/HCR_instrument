----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 02/24/2016 11:10:20 AM
-- Design Name: 
-- Module Name: px_axil_decompose - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axil_decompose is
generic (
   num_addr_bits : integer := 7   
);
port(
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
--------------------------------------------------------------------------------
   s_axi_csr_aclk      : in  std_logic;
   s_axi_csr_aresetn   : in  std_logic;
   s_axi_csr_awaddr    : in  std_logic_vector(num_addr_bits-1 downto 0);
   s_axi_csr_awprot    : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_awvalid   : in  std_logic;
   s_axi_csr_awready   : out std_logic;
   s_axi_csr_wdata     : in  std_logic_vector(31 downto 0);
   s_axi_csr_wstrb     : in  std_logic_vector(3 downto 0); 
   s_axi_csr_wvalid    : in  std_logic;
   s_axi_csr_wready    : out std_logic;
   s_axi_csr_bresp     : out std_logic_vector(1 downto 0);
   s_axi_csr_bvalid    : out std_logic;
   s_axi_csr_bready    : in  std_logic;
   s_axi_csr_araddr    : in  std_logic_vector(num_addr_bits-1 downto 0);
   s_axi_csr_arprot    : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_arvalid   : in  std_logic;
   s_axi_csr_arready   : out std_logic;
   s_axi_csr_rdata     : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp     : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid    : out std_logic;
   s_axi_csr_rready    : in  std_logic;
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
--------------------------------------------------------------------------------
   m_axi_csr_awaddr    : out std_logic_vector(num_addr_bits-1 downto 0);
   m_axi_csr_awprot    : out std_logic_vector(2 downto 0); -- not used
   m_axi_csr_awvalid   : out std_logic;
   m_axi_csr_awready   : in  std_logic;
   m_axi_csr_wdata     : out std_logic_vector(31 downto 0);
   m_axi_csr_wstrb     : out std_logic_vector(3 downto 0); 
   m_axi_csr_wvalid    : out std_logic;
   m_axi_csr_wready    : in  std_logic;
   m_axi_csr_bresp     : in  std_logic_vector(1 downto 0);
   m_axi_csr_bvalid    : in  std_logic;
   m_axi_csr_bready    : out std_logic;
   m_axi_csr_araddr    : out std_logic_vector(num_addr_bits-1 downto 0);
   m_axi_csr_arprot    : out std_logic_vector(2 downto 0); -- not used
   m_axi_csr_arvalid   : out std_logic;
   m_axi_csr_arready   : in  std_logic;
   m_axi_csr_rdata     : in  std_logic_vector(31 downto 0);
   m_axi_csr_rresp     : in  std_logic_vector(1 downto 0);
   m_axi_csr_rvalid    : in  std_logic;
   m_axi_csr_rready    : out std_logic
);   
end px_axil_decompose;

architecture Behavioral of px_axil_decompose is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

begin

 
   m_axi_csr_awaddr    <= s_axi_csr_awaddr; 
   m_axi_csr_awprot    <= s_axi_csr_awprot; 
   m_axi_csr_awvalid   <= s_axi_csr_awvalid;
   s_axi_csr_awready   <= m_axi_csr_awready;
   m_axi_csr_wdata     <= s_axi_csr_wdata;  
   m_axi_csr_wstrb     <= s_axi_csr_wstrb; 
   m_axi_csr_wvalid    <= s_axi_csr_wvalid; 
   s_axi_csr_wready    <= m_axi_csr_wready; 
   s_axi_csr_bresp     <= m_axi_csr_bresp;  
   s_axi_csr_bvalid    <= m_axi_csr_bvalid; 
   m_axi_csr_bready    <= s_axi_csr_bready; 
   m_axi_csr_araddr    <= s_axi_csr_araddr; 
   m_axi_csr_arprot    <= s_axi_csr_arprot; 
   m_axi_csr_arvalid   <= s_axi_csr_arvalid;
   s_axi_csr_arready   <= m_axi_csr_arready;
   s_axi_csr_rdata     <= m_axi_csr_rdata;  
   s_axi_csr_rresp     <= m_axi_csr_rresp;  
   s_axi_csr_rvalid    <= m_axi_csr_rvalid; 
   m_axi_csr_rready    <= s_axi_csr_rready; 


end Behavioral;
