----------------------------------------------------------------------------------
-- Pentek AXI4-Stream Combiner for I/O data, timestamp, and data info streams 
----------------------------------------------------------------------------------
-- px_axis_pdti_mrg.vhd
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
-- data_tdata[n:0]
-- data_tvalid 

-- Time Streams
-- pts_tdata[63:0]
-- pts_tuser[23:0]
-- pts_tvalid

-- tuser[7:0]        = Gate Positions
-- tuser[15:8]       = Sync Positions      
-- tuser[23:16]      = PPS Positions  
-- time_tdata[63:0]  = timestamp[63:0] 

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
-- tuser[87:80]   = PPS  Positions
-- tuser[92:88]   = Samples/Cycle
-- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
-- tuser[95]      = Data Type 0 = Real 1 = I/Q
-- tuser[103:96]  = channel[7:0] 
-- tuser[127:104] = Reserved 





-- This core enables the concatenation of data, time and data info streams into a 
-- combined Data/Time/Info Stream form.

-- The tvalid from the data stream is used as the output tvalid.
-- programmable delays are provided to allow you to align data , time and info streams so that
-- that are correspond correctly.

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

entity px_axis_pdti_mrg is
generic(
    data_byte_width         : integer := 2;  -- Width of input data stream in bytes
    data_stream_delay       : integer range 0 to 31 := 7;  -- delay for data stream input (delays tdata and tvalid) 
    info_stream_delay       : integer range 0 to 31 := 7; 
    time_stream_delay       : integer range 0 to 31 := 0  -- delay for data stream input 
);
port (
    s_axis_aclk           : in  std_logic;
    s_axis_aresetn        : in  std_logic;
    ----------------------------------------------------------------------------
    -- Input Raw Data Stream (AIX-Stream Slave) no back pressure
    ----------------------------------------------------------------------------
    s_axis_pd_tvalid    : in  std_logic;
    -- Earliest byte in lower byte 
    s_axis_pd_tdata     : in  std_logic_vector(((data_byte_width*8)-1) downto 0);
    -----------------------------------------------------------------------------
    -- Time Stamp Stream (AXI4-Stream Slave) no back pressure
    -----------------------------------------------------------------------------
    -- tuser[7:0]        = Gate Positions  
    -- tuser[15:8]       = Sync Positions      
    -- tuser[23:16]      = PPS Positions
    -- tdata[63:0]       = timestamp[63:0] 
    s_axis_pts_tdata     : in  std_logic_vector(63 downto 0);
    s_axis_pts_tuser     : in  std_logic_vector(23 downto 0);
    s_axis_pts_tvalid    : in  std_logic;
    -----------------------------------------------------------------------------
    -- Info Stream
    -----------------------------------------------------------------------------
    s_axis_pi_tvalid   : in  std_logic;
    -- dinfo_tdata [4:0]    = Samples/Cycle
    -- dinfo_tdata [6:5]    = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
    -- dinfo_tdata [7]      = Data Type 0 = Real 1 = I/Q
    -- dinfo_tdata [15:8]   = channel[7:0]   
    s_axis_pi_tdata    : in  std_logic_vector(15 downto 0);
    -----------------------------------------------------------------------------
    -- Output Data Stream (AXI4-Stream Master) no back pressure
    -----------------------------------------------------------------------------
    -- tuser[63:0]    = timestamp[63:0]
    -- tuser[71:64]   = Gate Positions  
    -- tuser[79:72]   = Sync Positions      
    -- tuser[87:80]   = PPS  Positions
    -- tuser[92:88]   = Samples/Cycle
    -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
    -- tuser[95]      = Data Type 0 = Real 1 = I/Q
    -- tuser[103:96]  = channel[7:0] 
    -- tuser[127:104] = Reserved 
    m_axis_pdti_tdata  : out std_logic_vector(((data_byte_width*8)-1) downto 0);
    m_axis_pdti_tuser  : out std_logic_vector(127 downto 0);
    m_axis_pdti_tvalid : out std_logic
    );
end px_axis_pdti_mrg;

architecture Behavioral of px_axis_pdti_mrg is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_pd:s_axis_pts:s_axis_pi:m_axis_pdti, ASSOCIATED_RESET s_axis_aresetn";

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

type td_data_type is array(0 to data_stream_delay) of std_logic_vector((data_byte_width*8) downto 0); 
type td_time_type is array(0 to time_stream_delay) of std_logic_vector(87 downto 0);
type td_info_type is array(0 to info_stream_delay) of std_logic_vector(15 downto 0); 
--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal td_data     : td_data_type;
signal td_time     : td_time_type;
signal td_info     : td_info_type;
signal data_in     : std_logic_vector((data_byte_width*8) downto 0);
signal ts_in       : std_logic_vector(87 downto 0);
signal info_in     : std_logic_vector(15 downto 0);
--------------------------------------------------------------------------------

begin

gen_no_data_dly: if (data_stream_delay = 0) generate

m_axis_pdti_tdata <= s_axis_pd_tdata;
m_axis_pdti_tvalid<= s_axis_pd_tvalid;

end generate;

gen_data_1dly: if (data_stream_delay = 1) generate

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
        m_axis_pdti_tdata <= s_axis_pd_tdata;
        m_axis_pdti_tvalid<= s_axis_pd_tvalid;
    end if;
end process;

end generate;

gen_data_dly: if (data_stream_delay > 1) generate

data_in <= s_axis_pd_tvalid & s_axis_pd_tdata;

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
        td_data(0)((data_byte_width*8) downto 0) <=  data_in; 
        td_data(1 to data_stream_delay-1) <= td_data(0 to data_stream_delay-2); 
    end if;
end process;

m_axis_pdti_tdata <= td_data(data_stream_delay-1)((data_byte_width*8)-1 downto 0);
m_axis_pdti_tvalid<= td_data(data_stream_delay-1)(data_byte_width*8);

end generate;


gen_no_ts_dly: if (time_stream_delay = 0) generate

m_axis_pdti_tuser(87 downto 0) <= s_axis_pts_tuser & s_axis_pts_tdata;

end generate;

gen_ts_1dly: if (time_stream_delay = 1) generate

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
        m_axis_pdti_tuser(87 downto 0) <= s_axis_pts_tuser & s_axis_pts_tdata;
    end if;
end process;

end generate;

gen_ts_dly: if (time_stream_delay > 1) generate

ts_in <= s_axis_pts_tuser & s_axis_pts_tdata;

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
        td_time(0)(87 downto 0) <=  ts_in; 
        td_time(1 to time_stream_delay-1) <= td_time(0 to time_stream_delay-2); 
    end if;
end process;

m_axis_pdti_tuser(87 downto 0)  <= td_time(time_stream_delay-1)(87 downto 0);

end generate;

gen_no_info_dly: if (info_stream_delay = 0) generate

m_axis_pdti_tuser(103 downto 88) <= s_axis_pi_tdata(15 downto 0);

end generate;

gen_info_1dly: if (info_stream_delay = 1) generate

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
        m_axis_pdti_tuser(103 downto 88) <= s_axis_pi_tdata(15 downto 0);
    end if;
end process;

end generate;

gen_info_dly: if (info_stream_delay > 1) generate

info_in <= s_axis_pi_tdata;

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
        td_info(0)(15 downto 0) <= info_in; 
        td_info(1 to info_stream_delay-1)     <= td_info(0 to info_stream_delay-2); 
    end if;
end process;

m_axis_pdti_tuser(103 downto 88)  <= td_info(info_stream_delay-1)(15 downto 0);

end generate;

m_axis_pdti_tuser(127 downto 104)  <= (others => '0');

end Behavioral;
