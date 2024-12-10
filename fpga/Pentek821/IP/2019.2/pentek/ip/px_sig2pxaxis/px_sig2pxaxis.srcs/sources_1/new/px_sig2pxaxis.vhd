----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2015 01:39:30 PM
-- Design Name: 
-- Module Name: px_sig2pxaxis - Behavioral
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

entity px_sig2pxaxis is
generic(
   gate_sig_width        : integer range 1 to 8  := 1;                -- Input gate,sync, and pps signal vector widths 
   data_byte_width       : integer range 1 to 32 := 2 ; -- Input Data Stream and output pd data width
   has_ptctl_output      : boolean := true;             -- Has PTCTL output
   has_pd_output         : boolean := true;             -- Has PD output 
   has_pts_output        : boolean := true;             -- Has PTS output
   has_pi_output         : boolean := true;             -- Has PI output
   use_info_inputs       : boolean := true;             -- true = Use Data Info Inputs, false = Use Generic values instead
   use_input_tvalid      : boolean := true;            -- use input tvalid passed to output m_axis_tvalid
   dflt_samples_per_cycle: integer range 1 to 16  := 1; -- Default samples/cycle
   dflt_data_format      : integer range 0 to 3   := 1; -- Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
   dflt_data_type        : integer range 0 to 1   := 0; -- Data Type 0 = Real 1 = I/Q
   dflt_channel          : integer range 0 to 255 := 0  -- channel[7:0]   
);
port ( 
   ----------------------------------------------------------------------------
   -- Gate and Sync Signals in
   ----------------------------------------------------------------------------
   gate_in               : in std_logic_vector(gate_sig_width-1 downto 0);
   sync_in               : in std_logic_vector(gate_sig_width-1 downto 0);
   pps_in                : in std_logic_vector(gate_sig_width-1 downto 0);
   timestamp_in          : in std_logic_vector(63 downto 0);
   ----------------------------------------------------------------------------
   -- Info Inputs (Usually constants)
   ----------------------------------------------------------------------------
   samples_per_cycle     : in std_logic_vector(4 downto 0); -- Samples/Cycle
   data_format           : in std_logic_vector(1 downto 0); --Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
   data_type             : in std_logic_vector(0 downto 0); -- Data Type 0 = Real 1 = I/Q
   channel               : in std_logic_vector(7 downto 0); -- channel[7:0]   
   ----------------------------------------------------------------------------
   -- Data Stream Vector
   ----------------------------------------------------------------------------
   data_stream_in        : in std_logic_vector(((data_byte_width*8)-1) downto 0);
   ----------------------------------------------------------------------------
   -- Input tvalid
   ----------------------------------------------------------------------------
   s_axis_tvalid         : in  std_logic;
   ----------------------------------------------------------------------------
   -- AXI-S Clock
   ----------------------------------------------------------------------------
   m_axis_aclk           : in  std_logic;
   m_axis_aresetn        : in  std_logic;
   ----------------------------------------------------------------------------
   -- Input Raw Data Stream (AIX-Stream Slave) no back pressure
   ----------------------------------------------------------------------------
   m_axis_pd_tvalid      : out std_logic;
   -- Earliest byte in lower byte 
   m_axis_pd_tdata       : out std_logic_vector(((data_byte_width*8)-1) downto 0);
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
   m_axis_pi_tvalid     : out std_logic;
   -- pi_tdata [4:0]    = Samples/Cycle
   -- pi_tdata [6:5]    = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
   -- pi_tdata [7]      = Data Type 0 = Real 1 = I/Q
   -- pi_tdata [15:8]   = channel[7:0]   
   m_axis_pi_tdata      : out std_logic_vector(15 downto 0);
   -----------------------------------------------------------------------------
   -- Timing Events (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------
   m_axis_ptctl_tdata   : out  std_logic_vector(((((gate_sig_width*3)+8)/8)*8)-1  downto 0);
   m_axis_ptctl_tvalid  : out  std_logic

);
end px_sig2pxaxis;

architecture Behavioral of px_sig2pxaxis is

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of m_axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 m_axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of m_axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis:m_axis_pd:m_axis_pts:m_axis_pi:m_axis_ptctl, ASSOCIATED_RESET m_axis_aresetn";


begin

gen_use_info_inputs: if (use_info_inputs= true) generate

m_axis_pi_tdata(4 downto 0)  <= samples_per_cycle;
m_axis_pi_tdata(6 downto 5)  <= data_format;
m_axis_pi_tdata(7 downto 7)  <= data_type;
m_axis_pi_tdata(15 downto 8) <= channel;

end generate gen_use_info_inputs; 

gen_no_info_inputs: if (use_info_inputs= false) generate

m_axis_pi_tdata(4 downto 0)  <= conv_std_logic_vector(dflt_samples_per_cycle, 5);
m_axis_pi_tdata(6 downto 5)  <= conv_std_logic_vector(dflt_data_format, 2);
m_axis_pi_tdata(7 downto 7)  <= conv_std_logic_vector(dflt_data_type, 1);
m_axis_pi_tdata(15 downto 8) <= conv_std_logic_vector(dflt_channel, 8);

end generate gen_no_info_inputs; 

m_axis_pd_tdata  <= data_stream_in;

m_axis_pts_tdata <= timestamp_in;

gen_gate_sig: for i in 0 to 7 generate

   m_axis_pts_tuser(i)   <= gate_in(i) when (gate_sig_width > i) else '0'; 
   m_axis_pts_tuser(8+i) <= sync_in(i) when (gate_sig_width > i) else '0';   
   m_axis_pts_tuser(16+i)<= pps_in(i)  when (gate_sig_width > i) else '0';      
   
end generate gen_gate_sig;  

gen_use_tvalid: if (use_input_tvalid = true) generate

m_axis_pi_tvalid    <= s_axis_tvalid;
m_axis_pd_tvalid    <= s_axis_tvalid;
m_axis_pts_tvalid   <= s_axis_tvalid;
m_axis_ptctl_tvalid <= s_axis_tvalid;

end generate gen_use_tvalid;

gen_dont_use_tvalid: if (use_input_tvalid = false) generate

m_axis_pi_tvalid    <= '1';
m_axis_pd_tvalid    <= '1';
m_axis_pts_tvalid   <= '1';
m_axis_ptctl_tvalid <= '1';

end generate gen_dont_use_tvalid;

gen_ptctl: for i in 0 to (gate_sig_width-1) generate

   m_axis_ptctl_tdata(i)                      <= gate_in(i);
   m_axis_ptctl_tdata(gate_sig_width + i)     <= sync_in(i);
   m_axis_ptctl_tdata((2*gate_sig_width) + i) <= pps_in(i);
   
end generate gen_ptctl;

gen_ptctl_zeros1: if (gate_sig_width = 1) generate

m_axis_ptctl_tdata(7 downto 3) <= (others => '0');

end generate;

gen_ptctl_zeros2: if (gate_sig_width = 2) generate

m_axis_ptctl_tdata(7 downto 6) <= (others => '0');

end generate;

gen_ptctl_zeros4: if (gate_sig_width = 4) generate

m_axis_ptctl_tdata(15 downto 12) <= (others => '0');

end generate;


end Behavioral;
