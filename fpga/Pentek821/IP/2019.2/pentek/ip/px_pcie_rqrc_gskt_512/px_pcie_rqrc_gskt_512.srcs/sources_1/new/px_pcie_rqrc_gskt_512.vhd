----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/17/2015 06:20:07 PM
-- Design Name: 
-- Module Name: px_pcie_rqrc_gskt - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Interfaces to RQ and RC on PCIe G3 Core, converting to non-standard
-- tready and tkeep signals.
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

-- (c) Copyright 2015 Pentek, Inc. All rights reserved.
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

entity px_pcie_rqrc_gskt_512 is
port (
    aclk                     : in STD_LOGIC;
    ----------------------------------------------------------------------------
    -- PCIe Requester Request Data Stream (AXI-Stream Stream Slave)
    ----------------------------------------------------------------------------
    -- associated with aclk
    -- Address aligned mode  
    s_axis_pcie_rq_tvalid    : in  std_logic;
    s_axis_pcie_rq_tready    : out std_logic;
    s_axis_pcie_rq_tdata     : in  std_logic_vector(511 downto 0); 
    s_axis_pcie_rq_tkeep     : in  std_logic_vector(63 downto 0);    
    s_axis_pcie_rq_tuser     : in  std_logic_vector(136 downto 0);
    s_axis_pcie_rq_tlast     : in  std_logic; -- end of packet
    ----------------------------------------------------------------------------
    -- PCIe Requester Request Data Stream (AXI-Stream Stream Master)
    ----------------------------------------------------------------------------
    -- associated with aclk
    -- Address aligned mode  
    m_axis_pcie_rq_tvalid    : out std_logic;
    m_axis_pcie_rq_tready    : in  std_logic_vector(3 downto 0);
    m_axis_pcie_rq_tdata     : out std_logic_vector(511 downto 0); 
    m_axis_pcie_rq_tkeep     : out std_logic_vector(15 downto 0);    
    m_axis_pcie_rq_tuser     : out std_logic_vector(136 downto 0);
    m_axis_pcie_rq_tlast     : out std_logic; -- end of packet
    ----------------------------------------------------------------------------
    -- Input PCIe Requester Completion Data Stream (AXI-Stream Stream Slave)
    ----------------------------------------------------------------------------
    -- associated with aclk
    -- address aligned mode
    s_axis_pcie_rc_tvalid    : in  std_logic;
    s_axis_pcie_rc_tready    : out std_logic;
    s_axis_pcie_rc_tdata     : in  std_logic_vector(511 downto 0);
    s_axis_pcie_rc_tkeep     : in  std_logic_vector(15 downto 0);    
    s_axis_pcie_rc_tuser     : in  std_logic_vector(160 downto 0);
    s_axis_pcie_rc_tlast     : in  std_logic; -- end of packet
    ----------------------------------------------------------------------------
    -- PCIe Requester Completion Data Stream (AXI-Stream Stream Master)
    ----------------------------------------------------------------------------
    -- associated with aclk
    -- address aligned mode
    m_axis_pcie_rc_tvalid    : out std_logic;
    m_axis_pcie_rc_tready    : in  std_logic;
    m_axis_pcie_rc_tdata     : out std_logic_vector(511 downto 0);
    m_axis_pcie_rc_tkeep     : out std_logic_vector(63 downto 0);    
    m_axis_pcie_rc_tuser     : out std_logic_vector(160 downto 0);
    m_axis_pcie_rc_tlast     : out std_logic -- end of packet
);
end px_pcie_rqrc_gskt_512;

architecture Behavioral of px_pcie_rqrc_gskt_512 is

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of aclk: SIGNAL is "xilinx.com:signal:clock:1.0 aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_pcie_rq:m_axis_pcie_rq:s_axis_pcie_rc:m_axis_pcie_rc";

begin

    m_axis_pcie_rq_tvalid    <= s_axis_pcie_rq_tvalid;
    s_axis_pcie_rq_tready    <= m_axis_pcie_rq_tready(0) or  m_axis_pcie_rq_tready(1) or  m_axis_pcie_rq_tready(2) or  m_axis_pcie_rq_tready(3);
    m_axis_pcie_rq_tdata     <= s_axis_pcie_rq_tdata;
    m_axis_pcie_rq_tkeep(0)  <= s_axis_pcie_rq_tkeep(0);
    m_axis_pcie_rq_tkeep(1)  <= s_axis_pcie_rq_tkeep(4);
    m_axis_pcie_rq_tkeep(2)  <= s_axis_pcie_rq_tkeep(8);
    m_axis_pcie_rq_tkeep(3)  <= s_axis_pcie_rq_tkeep(12);
    m_axis_pcie_rq_tkeep(4)  <= s_axis_pcie_rq_tkeep(16);
    m_axis_pcie_rq_tkeep(5)  <= s_axis_pcie_rq_tkeep(20);
    m_axis_pcie_rq_tkeep(6)  <= s_axis_pcie_rq_tkeep(24);
    m_axis_pcie_rq_tkeep(7)  <= s_axis_pcie_rq_tkeep(28); 
    m_axis_pcie_rq_tkeep(8)  <= s_axis_pcie_rq_tkeep(32);
    m_axis_pcie_rq_tkeep(9)  <= s_axis_pcie_rq_tkeep(36);
    m_axis_pcie_rq_tkeep(10)  <= s_axis_pcie_rq_tkeep(40);
    m_axis_pcie_rq_tkeep(11)  <= s_axis_pcie_rq_tkeep(44);
    m_axis_pcie_rq_tkeep(12)  <= s_axis_pcie_rq_tkeep(48);
    m_axis_pcie_rq_tkeep(13)  <= s_axis_pcie_rq_tkeep(52);
    m_axis_pcie_rq_tkeep(14)  <= s_axis_pcie_rq_tkeep(56);
    m_axis_pcie_rq_tkeep(15)  <= s_axis_pcie_rq_tkeep(60); 
    m_axis_pcie_rq_tuser     <= s_axis_pcie_rq_tuser; 
    m_axis_pcie_rq_tlast     <= s_axis_pcie_rq_tlast; 
    
    m_axis_pcie_rc_tvalid    <= s_axis_pcie_rc_tvalid;
    s_axis_pcie_rc_tready    <= m_axis_pcie_rc_tready;
    m_axis_pcie_rc_tdata     <= s_axis_pcie_rc_tdata; 
    m_axis_pcie_rc_tkeep(3 downto 0)    <= x"0" when (s_axis_pcie_rc_tkeep(0) = '0') else x"F"; 
    m_axis_pcie_rc_tkeep(7 downto 4)    <= x"0" when (s_axis_pcie_rc_tkeep(1) = '0') else x"F";
    m_axis_pcie_rc_tkeep(11 downto 8)   <= x"0" when (s_axis_pcie_rc_tkeep(2) = '0') else x"F";
    m_axis_pcie_rc_tkeep(15 downto 12)  <= x"0" when (s_axis_pcie_rc_tkeep(3) = '0') else x"F";
    m_axis_pcie_rc_tkeep(19 downto 16)  <= x"0" when (s_axis_pcie_rc_tkeep(4) = '0') else x"F";
    m_axis_pcie_rc_tkeep(23 downto 20)  <= x"0" when (s_axis_pcie_rc_tkeep(5) = '0') else x"F";
    m_axis_pcie_rc_tkeep(27 downto 24)  <= x"0" when (s_axis_pcie_rc_tkeep(6) = '0') else x"F";
    m_axis_pcie_rc_tkeep(31 downto 28)  <= x"0" when (s_axis_pcie_rc_tkeep(7) = '0') else x"F";
    m_axis_pcie_rc_tkeep(35 downto 32)  <= x"0" when (s_axis_pcie_rc_tkeep(8) = '0') else x"F"; 
    m_axis_pcie_rc_tkeep(39 downto 36)  <= x"0" when (s_axis_pcie_rc_tkeep(9) = '0') else x"F";
    m_axis_pcie_rc_tkeep(43 downto 40)  <= x"0" when (s_axis_pcie_rc_tkeep(10) = '0') else x"F";
    m_axis_pcie_rc_tkeep(47 downto 44)  <= x"0" when (s_axis_pcie_rc_tkeep(11) = '0') else x"F";
    m_axis_pcie_rc_tkeep(51 downto 48)  <= x"0" when (s_axis_pcie_rc_tkeep(12) = '0') else x"F";
    m_axis_pcie_rc_tkeep(55 downto 52)  <= x"0" when (s_axis_pcie_rc_tkeep(13) = '0') else x"F";
    m_axis_pcie_rc_tkeep(59 downto 56)  <= x"0" when (s_axis_pcie_rc_tkeep(14) = '0') else x"F";
    m_axis_pcie_rc_tkeep(63 downto 60)  <= x"0" when (s_axis_pcie_rc_tkeep(15) = '0') else x"F";
    m_axis_pcie_rc_tuser     <= s_axis_pcie_rc_tuser; 
    m_axis_pcie_rc_tlast     <= s_axis_pcie_rc_tlast; 

end Behavioral;
