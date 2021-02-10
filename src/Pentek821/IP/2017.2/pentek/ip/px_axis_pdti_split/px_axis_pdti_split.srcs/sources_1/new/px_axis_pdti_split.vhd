----------------------------------------------------------------------------------
-- Pentek AXI4-Stream Splitter for I/O data, timestamp, and data info streams 
----------------------------------------------------------------------------------
-- ptk_axis_datatimeinfo_combine.vhd
--
-- Target Device: Kintex UltraScale
--
-- Pentek Inc.
-- One Park Way, Upper Saddle River, NJ 07458
-- (201)818-5900
-- www.pentek.com
--
-- Copyright Pentek, Inc. 2015
--
-- Revision:
-- Revision 0.01 - File Created


-- Additional Comments: 
--  
-- Data streams for Pentek Onyx Ultra are in the following forms:

-- Input or Output Raw Data Stream
-- pd_tdata[n:0]
-- pd_tvalid 

-- Time Streams
-- pts_tdata[63:0]
-- pts_tuser[23:0]
-- pts_tvalid

-- tuser[7:0]        = Gate Positions  
-- tuser[15:8]       = Sync Positions      
-- tuser[23:16]      = PPS Positions
-- pts_tdata[63:0]  = timestamp[63:0] 

-- Data Info Streams

-- pi_tdata[15:0]
-- pi_tvalid

-- pi_tdata [4:0]    = Samples/Cycle
-- pi_tdata [6:5]    = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
-- pi_tdata [7]      = Data Type 0 = Real 1 = I/Q
-- pi_tdata [15:8]   = channel[7:0]   


-- Combined Data/Time/Info Streams
-- pdti_tdata[n:0]
-- pdti_tuser[127:0]
-- pdti_tvalid

-- tuser[63:0]    = timestamp[63:0]
-- tuser[71:64]   = Gate Positions  
-- tuser[79:72]   = Sync Positions      
-- tuser[87:80]   = PPS Positions
-- tuser[92:88]   = Samples/Cycle
-- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
-- tuser[95]      = Data Type 0 = Real 1 = I/Q
-- tuser[103:96]  = channel[7:0] 
-- tuser[127:104] = Reserved 


-- This core enables the splitting of a combined Data/Time/Info Stream into data, time and
-- data info streams. 

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

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

-------------------------------------------------------------------------------
-- Libraries
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axis_pdti_split is
generic(
    data_byte_width         : integer := 2  -- Width of input data stream in bytes
);
port (
    s_axis_aclk             : in  std_logic;
    s_axis_aresetn          : in  std_logic;
    -----------------------------------------------------------------------------
    -- Input Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
    -----------------------------------------------------------------------------
    -- tuser[63:0]    = timestamp[63:0]
    -- tuser[71:64]   = Gate Positions  
    -- tuser[79:72]   = Sync Positions      
    -- tuser[87:80]   = PPS Positions
    -- tuser[92:88]   = Samples/Cycle
    -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
    -- tuser[95]      = Data Type 0 = Real 1 = I/Q
    -- tuser[103:96]  = channel[7:0] 
    -- tuser[127:104] = Reserved 
    s_axis_pdti_tdata  : in  std_logic_vector(((data_byte_width*8)-1) downto 0);
    s_axis_pdti_tuser  : in  std_logic_vector(127 downto 0);
    s_axis_pdti_tvalid : in  std_logic;
    ----------------------------------------------------------------------------
    -- Output Raw Data Stream (AIX-Stream Slave) no back pressure
    ----------------------------------------------------------------------------
    m_axis_pd_tvalid         : out std_logic;
    -- Earliest byte in lower byte 
    m_axis_pd_tdata          : out std_logic_vector(((data_byte_width*8)-1) downto 0);
    -----------------------------------------------------------------------------
    -- Time Stamp Stream (AXI4-Stream Slave) no back pressure
    -----------------------------------------------------------------------------
    -- tuser[7:0]        = Gate Positions  
    -- tuser[15:8]       = Sync Positions      
    -- tuser[23:16]      = PPS Positions
    -- tdata[63:0]       = timestamp[63:0] 
    m_axis_pts_tdata     : out std_logic_vector(63 downto 0);
    m_axis_pts_tuser     : out std_logic_vector(23 downto 0);
    m_axis_pts_tvalid    : out std_logic;
    -----------------------------------------------------------------------------
    -- Info Stream
    -----------------------------------------------------------------------------
    m_axis_pi_tvalid   : out std_logic;
    -- pi_tdata [4:0]    = Samples/Cycle
    -- pi_tdata [6:5]    = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
    -- pi_tdata [7]      = Data Type 0 = Real 1 = I/Q
    -- pi_tdata [15:8]   = channel[7:0]   
    m_axis_pi_tdata    : out std_logic_vector(15 downto 0)
    );
end px_axis_pdti_split;

architecture Behavioral of px_axis_pdti_split is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_aclk: SIGNAL is "ASSOCIATED_BUSIF m_axis_pd:m_axis_pts:m_axis_pi:s_axis_pdti, ASSOCIATED_RESET s_axis_aresetn";


--------------------------------------------------------------------------------

begin

m_axis_pd_tdata   <= s_axis_pdti_tdata;
m_axis_pd_tvalid  <= s_axis_pdti_tvalid;

m_axis_pts_tdata   <= s_axis_pdti_tuser(63 downto 0);
m_axis_pts_tuser   <= s_axis_pdti_tuser(87 downto 64);
m_axis_pts_tvalid  <= s_axis_pdti_tvalid;

m_axis_pi_tvalid <= s_axis_pdti_tvalid;
m_axis_pi_tdata  <= s_axis_pdti_tuser(103 downto 88);

end Behavioral;
