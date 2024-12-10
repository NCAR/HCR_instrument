----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 05/16/2016 03:12:18 PM
-- Design Name: 
-- Module Name: px_axis_pdti_iqx4pack - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Pack IQ Stream four wide.
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axis_pdti_iqx4pack is
generic(
    gate_sync_pps_style : integer := 0     -- 0 = 4 positions in packed tuser  00003210
                                           -- 1 = 8 positions (each duplicated 33221100)
                                           -- 2 = 8 positions (each duplicated 32103210) 
);
port ( 
    aclk            : in std_logic;
    aresetn         : in std_logic;
    -----------------------------------------------------------------------------
    -- Input Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
    -----------------------------------------------------------------------------
    -- tuser[63:0]    = timestamp[63:0]
    -- tuser[71:64]   = Gate Positions  (in this case only 64 is required)
    -- tuser[79:72]   = Sync Positions  (in this case only 72 is required)    
    -- tuser[87:80]   = PPS  Positions  (in this case only 80 is required)
    -- tuser[91:88]   = Samples/Cycle
    -- tuser[92]      = IQ of first sample in data 0 = I, 1 = Q
    -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
    -- tuser[95]      = Data Type 0 = Real 1 = I/Q
    -- tuser[103:96]  = channel[7:0] 
    -- tuser[127:104] = Reserved 
    s_axis_pdti_tvalid   : in std_logic;
    s_axis_pdti_tdata    : in std_logic_vector(31 downto 0); -- I/Q, 16-bit 1 Sample/cycle 
    s_axis_pdti_tuser    : in std_logic_vector(127 downto 0);
    -----------------------------------------------------------------------------
    -- output Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
    -----------------------------------------------------------------------------
    -- tuser[63:0]    = timestamp[63:0]
    -- tuser[71:64]   = Gate Positions  (in this case only 64 is required)
    -- tuser[79:72]   = Sync Positions  (in this case only 72 is required)    
    -- tuser[87:80]   = PPS  Positions  (in this case only 80 is required)
    -- tuser[91:88]   = Samples/Cycle
    -- tuser[92]      = IQ of first sample in data 0 = I, 1 = Q
    -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
    -- tuser[95]      = Data Type 0 = Real 1 = I/Q
    -- tuser[103:96]  = channel[7:0] 
    -- tuser[127:104] = Reserved 
    m_axis_pdti_tvalid   : out std_logic;
    m_axis_pdti_tdata    : out std_logic_vector(127 downto 0);  -- I/Q, 16-bit 4 Samples/cycle 
    m_axis_pdti_tuser    : out std_logic_vector(127 downto 0)
);
end px_axis_pdti_iqx4pack;

architecture Behavioral of px_axis_pdti_iqx4pack is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of aclk: SIGNAL is "xilinx.com:signal:clock:1.0 aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_pdti:m_axis_pdti, ASSOCIATED_RESET aresetn";

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

COMPONENT axis_dwidth_iqx4pack
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_tuser : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    m_axis_tuser : OUT STD_LOGIC_VECTOR(511 DOWNTO 0)
  );
END COMPONENT;

signal m_axis_tuserx : std_logic_vector(511 downto 0) := (others => '0');

begin

packer_inst: axis_dwidth_iqx4pack
  PORT MAP (
    aclk            => aclk,
    aresetn         => aresetn,
    s_axis_tvalid   => s_axis_pdti_tvalid,
    s_axis_tready   => open,
    s_axis_tdata    => s_axis_pdti_tdata,
    s_axis_tuser    => s_axis_pdti_tuser,
    m_axis_tvalid   => m_axis_pdti_tvalid,
    m_axis_tready   => '1',
    m_axis_tdata    => m_axis_pdti_tdata,
    m_axis_tuser    => m_axis_tuserx
  );
  
  -- tuser[63:0]    = timestamp[63:0]
  -- tuser[71:64]   = Gate Positions  (in this case only 64 is required)
  -- tuser[79:72]   = Sync Positions  (in this case only 72 is required)    
  -- tuser[87:80]   = PPS  Positions  (in this case only 80 is required)
  -- tuser[91:88]   = Samples/Cycle
  -- tuser[92]      = IQ of first sample in data 0 = I, 1 = Q
  -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
  -- tuser[95]      = Data Type 0 = Real 1 = I/Q
  -- tuser[103:96]  = channel[7:0] 
  -- tuser[127:104] = Reserved 
  
m_axis_pdti_tuser(63 downto 0)    <= m_axis_tuserx(63 downto 0);
m_axis_pdti_tuser(91 downto 88)   <= "0100";
m_axis_pdti_tuser(127 downto 92)  <= m_axis_tuserx(127 downto 92);

gen_0: if (gate_sync_pps_style = 0) generate
m_axis_pdti_tuser(71 downto 64)   <= "0000" & m_axis_tuserx(384+64) & m_axis_tuserx(256+64) & m_axis_tuserx(128+64) & m_axis_tuserx(64);
m_axis_pdti_tuser(79 downto 72)   <= "0000" & m_axis_tuserx(384+72) & m_axis_tuserx(256+72) & m_axis_tuserx(128+72) & m_axis_tuserx(72);
m_axis_pdti_tuser(87 downto 80)   <= "0000" & m_axis_tuserx(384+80) & m_axis_tuserx(256+80) & m_axis_tuserx(128+80) & m_axis_tuserx(80);
end generate;

gen_1: if (gate_sync_pps_style = 1) generate
m_axis_pdti_tuser(71 downto 64)   <= m_axis_tuserx(384+64) & m_axis_tuserx(384+64) & m_axis_tuserx(256+64) & m_axis_tuserx(256+64) & m_axis_tuserx(128+64) & m_axis_tuserx(128+64) & m_axis_tuserx(64) & m_axis_tuserx(64);
m_axis_pdti_tuser(79 downto 72)   <= m_axis_tuserx(384+72) & m_axis_tuserx(384+72) & m_axis_tuserx(256+72) & m_axis_tuserx(256+72) & m_axis_tuserx(128+72) & m_axis_tuserx(128+72) & m_axis_tuserx(72) & m_axis_tuserx(72);
m_axis_pdti_tuser(87 downto 80)   <= m_axis_tuserx(384+80) & m_axis_tuserx(384+80) & m_axis_tuserx(256+80) & m_axis_tuserx(256+80) & m_axis_tuserx(128+80) & m_axis_tuserx(128+80) & m_axis_tuserx(80) & m_axis_tuserx(80);
end generate;

gen_2: if (gate_sync_pps_style = 2) generate
m_axis_pdti_tuser(71 downto 64)   <=  m_axis_tuserx(384+64) & m_axis_tuserx(256+64) & m_axis_tuserx(128+64) & m_axis_tuserx(64) & m_axis_tuserx(384+64) & m_axis_tuserx(256+64) & m_axis_tuserx(128+64) & m_axis_tuserx(64);
m_axis_pdti_tuser(79 downto 72)   <=  m_axis_tuserx(384+72) & m_axis_tuserx(256+72) & m_axis_tuserx(128+72) & m_axis_tuserx(72) & m_axis_tuserx(384+72) & m_axis_tuserx(256+72) & m_axis_tuserx(128+72) & m_axis_tuserx(72);
m_axis_pdti_tuser(87 downto 80)   <=  m_axis_tuserx(384+80) & m_axis_tuserx(256+80) & m_axis_tuserx(128+80) & m_axis_tuserx(80) & m_axis_tuserx(384+80) & m_axis_tuserx(256+80) & m_axis_tuserx(128+80) & m_axis_tuserx(80); 
end generate;

end Behavioral;
