----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 04/23/2018 09:17:54 AM
-- Design Name: 
-- Module Name: px_rfsoc_syncbus_intrfc - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 1.0 - File Created
-- Revision 1.1 - Fixed undriven m_axis_ptctl_tdata bits
-- Revision 1.2 - Removed unused sysref_tdly_out. Added generic to remove unclocked SYSREF mux for 6001
-- version that uses an externally provided AXIS clock (input clock is 500MHz and uses PLL for 4GHz instead of 4GHz directly)
-- Additional Comments:
-- 

-- Register Map
-- 0x00 Gate Receive Buffer Control
-- 0x04 Sync Receive Buffer Control
-- 0x08 Aux  Receive Buffer Control
-- 0x0C Source Select
-- 0x10 Gate Gen
-- 0x14 Sync Gen
-- 0x18 PPS Gen
-- 0x1C Sysref Gen
-- 0x20 Status Register
-- 0x24 Interrupt Enable Register
-- 0x28 Interrupt Status Register
-- 0x2C Interrupt Flag Register

-- Gate Receive Buffer Control
-- [8:0]   gate_tap_delay[8:0]
-- [9]     gate tap delay load
-- [13:12] gate_int_delay[1:0] 
-- [24:16] ttl_trig_tap_delay[8:0]
-- [25]    trig tap delay load
-- [29:28] ttl_trig_int_delay[1:0] 
-- Sync Receive Buffer Control
-- [8:0]   sync_tap_delay[8:0]
-- [9]     sync tap delay load
-- [13:12] sync_int_delay[1:0] 
-- Sysref Receive Buffer Control
-- [8:0]   sysref_tap_delay[8:0]
-- [9]     sysref tap delay load
-- [13:12] sysref_int_delay[1:0] 
-- Source Control Register
-- [0]     reserved
-- [1]     reserved
-- [6:4]   gate_rcv_src[2:0] 
-- [10:8]  sync_rcv_src[2:0] 
-- [15:12] pps_rcv_src[3:0] 
-- [19:16] sysref_rcv_src[3:0]
-- [22:20] reserved      
-- [25:24] led_src[1:0]
-- Gate Generate    
-- [0]     gate_reg_gen    
-- Sync Generate      
-- [0]     sync_reg_gen    
-- PPS Generate      
-- [0]     pps_reg_gen
-- Sysref Generate      
-- [0]     sysref_reg_gen

----------------------------------------------------------------------------------

-- (c) Copyright 2019 Pentek, Inc. All rights reserved.
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
use ieee.numeric_std.ALL;
Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
Library UNISIM;
use UNISIM.vcomponents.all;

entity px_rfsoc_syncbus_intrfc is
generic(
    has_pin_gate_in                : boolean := true;
    has_pin_sync_in                : boolean := true;
    has_pin_ttl_trig_in            : boolean := true;
    has_pin_sysref_in              : boolean := true;
    has_fabric_gate_in             : boolean := true;
    has_fabric_sync_in             : boolean := true;
    has_fabric_trig_in             : boolean := true;
    has_fabric_pps_in              : boolean := true; 
    has_fabric_sysref_in           : boolean := true;
    has_pps_in                     : boolean := true;
    has_rtc_pps_in                 : boolean := true;
    use_gate_tap_delay             : boolean := true;
    use_sync_tap_delay             : boolean := true;
    use_ttl_trig_tap_delay         : boolean := true;
    use_sysref_tap_delay           : boolean := true;
    initial_gate_tap_delay         : integer range 0 to 511 := 0;
    initial_sync_tap_delay         : integer range 0 to 511 := 0;
    initial_ttl_trig_tap_delay     : integer range 0 to 511 := 0;
    initial_sysref_tap_delay       : integer range 0 to 511 := 0;
    initial_gate_int_delay         : integer range 0 to 3 := 0;
    initial_sync_int_delay         : integer range 0 to 3 := 0;    
    initial_ttl_trig_int_delay     : integer range 0 to 3 := 0;
    initial_sysref_int_delay       : integer range 0 to 3 := 0;
    refclk_freq_int                : integer := 500;
    initial_led_src                : integer := 2; 
    led_pulse_stretch              : integer range 0 to 65535:= 65535; -- counts to pulse stretch LED
    ext_axiclk_version             : boolean := false -- For revisions of 6001 where the AXIS clock is brought in directly, removes unclocked SYSREF mux 
);
port (
----------------------------------------------------------------------------
-- Control/Status Registers (AXI4-LITE)
----------------------------------------------------------------------------
-- associated with s_axi_csr_aclk
   s_axi_csr_aclk           : in  std_logic;
   s_axi_csr_aresetn        : in  std_logic;
   s_axi_csr_awaddr         : in  std_logic_vector(5 downto 0);
   s_axi_csr_awprot         : in  std_logic_vector(2 downto 0);
   s_axi_csr_awvalid        : in  std_logic;
   s_axi_csr_awready        : out std_logic;
   s_axi_csr_wdata          : in  std_logic_vector(31 downto 0);
   s_axi_csr_wstrb          : in  std_logic_vector(3 downto 0);
   s_axi_csr_wvalid         : in  std_logic;
   s_axi_csr_wready         : out std_logic;
   s_axi_csr_bresp          : out std_logic_vector(1 downto 0);
   s_axi_csr_bvalid         : out std_logic;
   s_axi_csr_bready         : in  std_logic;
   s_axi_csr_araddr         : in  std_logic_vector(5 downto 0);
   s_axi_csr_arprot         : in  std_logic_vector(2 downto 0);
   s_axi_csr_arvalid        : in  std_logic;
   s_axi_csr_arready        : out std_logic;
   s_axi_csr_rdata          : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp          : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid         : out std_logic;
   s_axi_csr_rready         : in  std_logic;
    
   irq                      : out std_logic; -- Interrupt out (overload)
----------------------------------------------------------------------------
-- Sync Bus Front Panel I/O
----------------------------------------------------------------------------
   -- Bus Input
   sample_clk              : in  std_logic;
   pin_gate_in             : in  std_logic; -- SOM Input (from differential receiver buffer)
   pin_sync_in             : in  std_logic; -- SOM Input (from differential receiver buffer)
   pin_trig_ttl_in         : in  std_logic; -- SOM Input
   pps_in                  : in  std_logic; -- SOM Input (Pulse Per Second)
   rtc_pps_in              : in  std_logic; -- From ARM RTC
   pin_sysref_in           : in  std_logic; -- SOM Input (from differential receiver buffer)
   pin_trig_ttl_out        : out std_logic;
   --sysref_tdly_out         : out std_logic; 
   sysref_out              : out std_logic; 
   user_gate_in            : in  std_logic; -- From User fabric source
   user_sync_in            : in  std_logic; -- From User fabric source
   user_pps_in             : in  std_logic; -- From User fabric source
   user_sysref_in          : in  std_logic; -- From User fabric source    
-----------------------------------------------------------------------------
-- LED Drive
-----------------------------------------------------------------------------
   led_n                   : out std_logic;
-----------------------------------------------------------------------------
-- Timing Events (AXI4-Stream Slave) no back pressure
-----------------------------------------------------------------------------
   -- tdata[7:0]       = Gate
   -- tdata[15:8]      = Sync 
   -- tdata[23:16]     = PPS   
   m_axis_timecntl_tdata   : out std_logic_vector(31 downto 0);
   m_axis_timecntl_tvalid  : out std_logic;
   -- tdata[0]         = Gate
   -- tdata[1]        = Sync 
   -- tdata[2]        = PPS    
   m_axis_ptctl_tdata      : out std_logic_vector(7 downto 0);
   m_axis_ptctl_tvalid     : out std_logic  
 );
end px_rfsoc_syncbus_intrfc;

architecture Behavioral of px_rfsoc_syncbus_intrfc is

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTERRUPT";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of sample_clk: SIGNAL is "xilinx.com:signal:clock:1.0 sample_clk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of sample_clk: SIGNAL is "ASSOCIATED_BUSIF m_axis_timecntl:m_axis_ptctl";

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Control/Status Registers
component px_rfsoc_syncbus_intrfc_csr
generic (
   initial_gate_tap_delay         : integer range 0 to 511 := 0;
   initial_sync_tap_delay         : integer range 0 to 511 := 0;
   initial_ttl_trig_tap_delay     : integer range 0 to 511 := 0;
   initial_sysref_tap_delay       : integer range 0 to 511 := 0;
   initial_gate_int_delay         : integer range 0 to 3 := 0;
   initial_sync_int_delay         : integer range 0 to 3 := 0;    
   initial_ttl_trig_int_delay     : integer range 0 to 3 := 0;
   initial_sysref_int_delay       : integer range 0 to 3 := 0;  
   initial_led_src                : integer := 3
);
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
   s_axi_csr_aclk         : in  std_logic;
   s_axi_csr_aresetn      : in  std_logic;
   s_axi_csr_awaddr       : in  std_logic_vector(5 downto 0); -- only [5:0] used
   s_axi_csr_awprot       : in  std_logic_vector(2 downto 0);
   s_axi_csr_awvalid      : in  std_logic;
   s_axi_csr_awready      : out std_logic;
   s_axi_csr_wdata        : in  std_logic_vector(31 downto 0);
   s_axi_csr_wstrb        : in  std_logic_vector(3 downto 0);
   s_axi_csr_wvalid       : in  std_logic;
   s_axi_csr_wready       : out std_logic;
   s_axi_csr_bresp        : out std_logic_vector(1 downto 0);
   s_axi_csr_bvalid       : out std_logic;
   s_axi_csr_bready       : in  std_logic;
   s_axi_csr_araddr       : in  std_logic_vector(5 downto 0);  -- only [5:0] used
   s_axi_csr_arprot       : in  std_logic_vector(2 downto 0);
   s_axi_csr_arvalid      : in  std_logic;
   s_axi_csr_arready      : out std_logic;
   s_axi_csr_rdata        : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp        : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid       : out std_logic;
   s_axi_csr_rready       : in  std_logic;
    
    irq                   : out std_logic; -- interrupt
    --------------------------------------------------------------------------------
    axis_aclk             : in  std_logic; -- clock for controls and status
    --------------------------------------------------------------------------------
    -- Control Outputs (synchronous to axis_aclk)
    --------------------------------------------------------------------------------   
    led_src               : out std_logic_vector(1 downto 0);
    gate_tap_delay        : out std_logic_vector(8 downto 0);
    sync_tap_delay        : out std_logic_vector(8 downto 0);
    trig_ttl_tap_delay    : out std_logic_vector(8 downto 0);
    sysref_tap_delay      : out std_logic_vector(8 downto 0);
    gate_int_delay        : out std_logic_vector(1 downto 0);
    sync_int_delay        : out std_logic_vector(1 downto 0);
    trig_ttl_int_delay    : out std_logic_vector(1 downto 0);
    sysref_int_delay      : out std_logic_vector(1 downto 0);
    gate_rcv_src          : out std_logic_vector(2 downto 0);
    sync_rcv_src          : out std_logic_vector(2 downto 0);
    pps_rcv_src           : out std_logic_vector(3 downto 0);
    sysref_rcv_src        : out std_logic_vector(3 downto 0);
    gate_reg_gen          : out std_logic;
    sync_reg_gen          : out std_logic;
    pps_reg_gen           : out std_logic;
    sysref_reg_gen        : out std_logic;
    gate_dly_ld_ctl       : out std_logic;
    sync_dly_ld_ctl       : out std_logic;
    trig_dly_ld_ctl       : out std_logic;
    sysref_dly_ld_ctl     : out std_logic;
    sysref_sel            : out std_logic;
--------------------------------------------------------------------------------
-- Status Inputs (synchronous to axis_aclk)
--------------------------------------------------------------------------------       	           
    selected_gate         : in std_logic;
    selected_sync         : in std_logic;
    selected_pps          : in std_logic;
    selected_sysref       : in std_logic;
    ttl_trig_pin          : in std_logic;
    ttl_pps_pin           : in std_logic;
    rtc_pps_pin           : in std_logic;
    sysref_pin            : in std_logic;
    diff_gate_pin         : in std_logic;
    diff_sync_pin         : in std_logic;
 -------------------------------------------------------------------------------
-- Interrupt Sources (synchronous to axis_aclk)
--------------------------------------------------------------------------------
    gate_re_event         : in std_logic;
    gate_fe_event         : in std_logic;
    sync_re_event         : in std_logic;
    sync_fe_event         : in std_logic;
    pps_re_event          : in std_logic;
    pps_fe_event          : in std_logic;
    sysref_re_event       : in std_logic;
    sysref_fe_event       : in std_logic
);
end component;

component px_rfsoc_syncbus_intrfc_idelay
generic (
   refclk_freq                    : real := 500.0
);
port (
   data_in     : in  STD_LOGIC;
   data_out    : out STD_LOGIC;
   delay_val   : in  STD_LOGIC_VECTOR (8 downto 0);
   delay_load  : in  STD_LOGIC;
   clk         : in  STD_LOGIC;
   rst_n       : in  STD_LOGIC
   );
end component px_rfsoc_syncbus_intrfc_idelay;

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------

constant refclk_freq : real := real(refclk_freq_int);

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal led_src            : std_logic_vector(1 downto 0) := (others => '0');
signal gate_tap_delay     : std_logic_vector(8 downto 0) := (others => '0');
signal sync_tap_delay     : std_logic_vector(8 downto 0) := (others => '0');
signal trig_ttl_tap_delay : std_logic_vector(8 downto 0) := (others => '0');
signal sysref_tap_delay   : std_logic_vector(8 downto 0) := (others => '0');
signal gate_int_delay     : std_logic_vector(1 downto 0) := (others => '0');
signal sync_int_delay     : std_logic_vector(1 downto 0) := (others => '0');
signal trig_ttl_int_delay : std_logic_vector(1 downto 0) := (others => '0');
signal sysref_int_delay   : std_logic_vector(1 downto 0) := (others => '0');
signal gate_rcv_src       : std_logic_vector(2 downto 0) := (others => '0');
signal sync_rcv_src       : std_logic_vector(2 downto 0) := (others => '0');
signal pps_rcv_src        : std_logic_vector(3 downto 0) := (others => '0');
signal sysref_rcv_src     : std_logic_vector(3 downto 0) := (others => '0');
signal gate_reg_gen       : std_logic := '0';
signal sync_reg_gen       : std_logic := '0';
signal pps_reg_gen        : std_logic := '0';
signal sysref_reg_gen     : std_logic := '0';
signal t3_mux_gate        : std_logic := '0'; 
signal t3_mux_sync        : std_logic := '0';
signal t3_mux_pps         : std_logic := '0'; 
signal t3_mux_sysref      : std_logic := '0';
signal t2_trig_ttl_rcv: std_logic := '0'; 
signal t2_gate_rcv         : std_logic := '0'; 
signal t2_sync_rcv         : std_logic := '0'; 
signal t2_sysref_rcv       : std_logic := '0'; 
signal gate_re_event       : std_logic := '0';
signal gate_fe_event       : std_logic := '0';
signal sync_re_event       : std_logic := '0';
signal sync_fe_event       : std_logic := '0';
signal sysref_re_event     : std_logic := '0';
signal sysref_fe_event     : std_logic := '0';
signal pps_re_event        : std_logic := '0';
signal pps_fe_event        : std_logic := '0'; 
signal csr_irq             : std_logic := '0';
signal idelay_gate_rcv     : std_logic := '0';
signal idelay_sync_rcv     : std_logic := '0';
signal idelay_trig_ttl_rcv : std_logic := '0';
signal idelay_sysref_rcv   : std_logic := '0';
signal t1_gate_rcv         : std_logic := '0';
signal t1_sync_rcv         : std_logic := '0';
signal t1_trig_ttl_rcv     : std_logic := '0';
signal t1_sysref_rcv       : std_logic := '0';
signal t3_gate_rcv         : std_logic := '0';
signal t4_gate_rcv         : std_logic := '0';
signal t3_sync_rcv         : std_logic := '0';
signal t4_sync_rcv         : std_logic := '0';
signal t3_sysref_rcv       : std_logic := '0';
signal t4_sysref_rcv       : std_logic := '0';
signal t3_trig_ttl_rcv: std_logic := '0';
signal t4_trig_ttl_rcv: std_logic := '0';
signal t2_pps_rcv          : std_logic := '0';  
signal t2_rtc_pps_rcv      : std_logic := '0';          
signal t2_int_dly_gate_rcv : std_logic := '0';  
signal t2_int_dly_sync_rcv : std_logic := '0';  
signal t2_int_dly_sysref_rcv : std_logic := '0';  
signal t2_int_dly_ttl_trig_rcv: std_logic := '0';     
signal t4_mux_gate         : std_logic := '0';          
signal t4_mux_sync         : std_logic := '0';        
signal t4_mux_pps          : std_logic := '0';  
signal t4_mux_sysref       : std_logic := '0';      
signal t3_re_gate          : std_logic := '0'; 
signal t3_fe_gate          : std_logic := '0'; 
signal t1_gate_reg_gen     : std_logic := '0'; 
signal t1_sync_reg_gen     : std_logic := '0'; 
signal t1_pps_reg_gen      : std_logic := '0';
signal t1_sysref_reg_gen   : std_logic := '0';  
signal pls_strch_cntr      : std_logic_vector(15 downto 0) := (others => '0');
signal led_lite            : std_logic := '0';
signal gate_dly_ld_ctl     : std_logic := '0';
signal sync_dly_ld_ctl     : std_logic := '0';
signal trig_dly_ld_ctl     : std_logic := '0';
signal sysref_dly_ld_ctl   : std_logic := '0';
signal sample_clk_n        : std_logic := '0';
signal t1_s_axi_csr_aresetn: std_logic := '0';
signal t1_user_gate_rcv  : std_logic := '0';
signal t1_user_sync_rcv  : std_logic := '0';
signal t2_user_gate_rcv  : std_logic := '0';
signal t2_user_sync_rcv  : std_logic := '0';
signal t1_rtc_pps_rcv    : std_logic := '0'; 
signal t1_pps_rcv        : std_logic := '0'; 
signal t1_user_pps_in    : std_logic := '0'; 
signal t2_user_pps_in    : std_logic := '0';
signal sysref_sel        : std_logic := '0';
-------------------------------------------------------------------------------

begin

--------------------------------------------------------------------------------
-- Control/Status Registers
--------------------------------------------------------------------------------

-- Control registers operate in Sample clock Domain
csr_inst: px_rfsoc_syncbus_intrfc_csr
generic map(
   initial_gate_tap_delay         => initial_gate_tap_delay,     
   initial_sync_tap_delay         => initial_sync_tap_delay,     
   initial_ttl_trig_tap_delay     => initial_ttl_trig_tap_delay, 
   initial_gate_int_delay         => initial_gate_int_delay,     
   initial_sync_int_delay         => initial_sync_int_delay,     
   initial_ttl_trig_int_delay     => initial_ttl_trig_int_delay, 
   initial_led_src                => initial_led_src          
)
port map (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
--------------------------------------------------------------------------------
    axis_aclk               => sample_clk,   
    s_axi_csr_aclk          => s_axi_csr_aclk,   
    s_axi_csr_aresetn       => t1_s_axi_csr_aresetn,
    s_axi_csr_awaddr        => s_axi_csr_awaddr,  
    s_axi_csr_awprot        => s_axi_csr_awprot,  
    s_axi_csr_awvalid       => s_axi_csr_awvalid, 
    s_axi_csr_awready       => s_axi_csr_awready, 
    s_axi_csr_wdata         => s_axi_csr_wdata,   
    s_axi_csr_wstrb         => s_axi_csr_wstrb,   
    s_axi_csr_wvalid        => s_axi_csr_wvalid,  
    s_axi_csr_wready        => s_axi_csr_wready,  
    s_axi_csr_bresp         => s_axi_csr_bresp,   
    s_axi_csr_bvalid        => s_axi_csr_bvalid,  
    s_axi_csr_bready        => s_axi_csr_bready,  
    s_axi_csr_araddr        => s_axi_csr_araddr,  
    s_axi_csr_arprot        => s_axi_csr_arprot,  
    s_axi_csr_arvalid       => s_axi_csr_arvalid, 
    s_axi_csr_arready       => s_axi_csr_arready, 
    s_axi_csr_rdata         => s_axi_csr_rdata,   
    s_axi_csr_rresp         => s_axi_csr_rresp,   
    s_axi_csr_rvalid        => s_axi_csr_rvalid,  
    s_axi_csr_rready        => s_axi_csr_rready,  
    
    irq                     => csr_irq,           
--------------------------------------------------------------------------------
-- Control Outputs (synchronous to axis_aclk)
--------------------------------------------------------------------------------    
    led_src                 => led_src,
    gate_tap_delay          => gate_tap_delay,
    sync_tap_delay          => sync_tap_delay,
    trig_ttl_tap_delay      => trig_ttl_tap_delay,
    sysref_tap_delay        => sysref_tap_delay,
    gate_int_delay          => gate_int_delay,
    sync_int_delay          => sync_int_delay,
    trig_ttl_int_delay      => trig_ttl_int_delay,
    sysref_int_delay        => sysref_int_delay,
    gate_rcv_src            => gate_rcv_src,
    sync_rcv_src            => sync_rcv_src,
    pps_rcv_src             => pps_rcv_src,
    sysref_rcv_src          => sysref_rcv_src,
    gate_reg_gen            => gate_reg_gen,
    sync_reg_gen            => sync_reg_gen,
    pps_reg_gen             => pps_reg_gen,
    sysref_reg_gen          => sysref_reg_gen,
    gate_dly_ld_ctl         => gate_dly_ld_ctl,
    sync_dly_ld_ctl         => sync_dly_ld_ctl,
    trig_dly_ld_ctl         => trig_dly_ld_ctl,
    sysref_dly_ld_ctl       => sysref_dly_ld_ctl,
    sysref_sel              => sysref_sel,
--------------------------------------------------------------------------------
-- Status Inputs (synchronous to axis_aclk)
--------------------------------------------------------------------------------       	           
    selected_gate           => t3_mux_gate,
    selected_sync           => t3_mux_sync,
    selected_pps            => t3_mux_pps,
    selected_sysref         => t3_mux_sysref,
    ttl_trig_pin            => t2_trig_ttl_rcv,
    ttl_pps_pin             => t2_pps_rcv,
    rtc_pps_pin             => t2_rtc_pps_rcv,
    sysref_pin              => t2_sysref_rcv,
    diff_gate_pin           => t2_gate_rcv,
    diff_sync_pin           => t2_sync_rcv,
 -------------------------------------------------------------------------------
-- Interrupt Sources (synchronous to axis_aclk)
--------------------------------------------------------------------------------
    gate_re_event           => gate_re_event, 
    gate_fe_event           => gate_fe_event, 
    sync_re_event           => sync_re_event, 
    sync_fe_event           => sync_fe_event, 
    pps_re_event            => pps_re_event,  
    pps_fe_event            => pps_fe_event,
    sysref_re_event         => sysref_re_event,  
    sysref_fe_event         => sysref_fe_event   
);

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
        t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
        irq <= csr_irq;
   end if;
end process;

--------------------------------------------------------------------------------
-- IDELAYs
--------------------------------------------------------------------------------

gen_gate_idelay: if (has_pin_gate_in = true) and (use_gate_tap_delay = true) generate

gate_idelay: px_rfsoc_syncbus_intrfc_idelay
generic map(
   refclk_freq   => refclk_freq
)
port map (
   data_in     => pin_gate_in,
   data_out    => idelay_gate_rcv,
   delay_val   => gate_tap_delay,
   delay_load  => gate_dly_ld_ctl,
   clk         => s_axi_csr_aclk,
   rst_n       => t1_s_axi_csr_aresetn
   );
end generate;

gen_no_gate_idelay: if (has_pin_gate_in = false) or (use_gate_tap_delay = false) generate

idelay_gate_rcv <= pin_gate_in;

end generate;

gen_sync_idelay: if (has_pin_sync_in = true) and (use_sync_tap_delay = true) generate

sync_idelay: px_rfsoc_syncbus_intrfc_idelay
generic map(
   refclk_freq   => refclk_freq
)
port map (
   data_in     => pin_sync_in,
   data_out    => idelay_sync_rcv,
   delay_val   => sync_tap_delay,
   delay_load  => sync_dly_ld_ctl,
   clk         => s_axi_csr_aclk,     
   rst_n       => t1_s_axi_csr_aresetn
   );
end generate;

gen_no_sync_idelay: if (has_pin_sync_in = false) or (use_sync_tap_delay = false) generate

idelay_sync_rcv <= pin_sync_in;

end generate;

gen_ttl_trig_idelay: if (has_pin_ttl_trig_in = true) and (use_ttl_trig_tap_delay = true) generate

trig_idelay: px_rfsoc_syncbus_intrfc_idelay
generic map(
   refclk_freq   => refclk_freq
)
port map (
   data_in     => pin_trig_ttl_in,
   data_out    => idelay_trig_ttl_rcv,
   delay_val   => trig_ttl_tap_delay,
   delay_load  => trig_dly_ld_ctl,
   clk         => s_axi_csr_aclk,     
   rst_n       => t1_s_axi_csr_aresetn
   );
end generate;

gen_no_trig_idelay: if (has_pin_ttl_trig_in = false) or (use_ttl_trig_tap_delay = false) generate

idelay_trig_ttl_rcv <= pin_trig_ttl_in;

end generate;

gen_sysref_idelay: if (has_pin_sysref_in = true) and (use_sysref_tap_delay = true) generate

sysref_idelay: px_rfsoc_syncbus_intrfc_idelay
generic map(
   refclk_freq   => refclk_freq
)
port map (
   data_in     => pin_sysref_in,
   data_out    => idelay_sysref_rcv,
   delay_val   => sysref_tap_delay,
   delay_load  => sysref_dly_ld_ctl,
   clk         => s_axi_csr_aclk,     
   rst_n       => t1_s_axi_csr_aresetn
   );
end generate;

gen_no_sysref_idelay: if (has_pin_sysref_in = false) or (use_sysref_tap_delay = false) generate

idelay_sysref_rcv <= pin_sysref_in;

end generate;
 
-------------------------------------------------------------------------------
-- Register the input signals with IO Flip-Flops
-------------------------------------------------------------------------------

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      t1_gate_rcv            <= idelay_gate_rcv;
      t1_sync_rcv            <= idelay_sync_rcv;
      t1_trig_ttl_rcv        <= idelay_trig_ttl_rcv;
      t1_sysref_rcv          <= idelay_sysref_rcv;
   end if;
end process;

pin_trig_ttl_out <= t1_trig_ttl_rcv;

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      t1_user_gate_rcv       <= user_gate_in;
      t1_user_sync_rcv       <= user_sync_in;
      t1_rtc_pps_rcv         <= rtc_pps_in;
      t1_pps_rcv             <= pps_in;            
      t2_pps_rcv             <= t1_pps_rcv;
      t1_user_pps_in         <= user_pps_in;
      t2_user_pps_in         <= t1_user_pps_in;
   end if;
end process;


-------------------------------------------------------------------------------
-- Add desired Integer # clock cycles to selected signals
-------------------------------------------------------------------------------
-- This may be required to calibrate out SYNC Bus latency across multiple
-- boards.
 
process(sample_clk)
begin
   if rising_edge(sample_clk) then
      t2_gate_rcv       <= t1_gate_rcv;
      t3_gate_rcv       <= t2_gate_rcv;
      t4_gate_rcv       <= t3_gate_rcv;
      t2_sync_rcv       <= t1_sync_rcv;
      t3_sync_rcv       <= t2_sync_rcv;
      t4_sync_rcv       <= t3_sync_rcv;
      t2_trig_ttl_rcv   <= t1_trig_ttl_rcv;
      t3_trig_ttl_rcv   <= t2_trig_ttl_rcv;
      t4_trig_ttl_rcv   <= t3_trig_ttl_rcv;
      t2_sysref_rcv     <= t1_sysref_rcv;
      t3_sysref_rcv     <= t2_sysref_rcv;
      t4_sysref_rcv     <= t3_sysref_rcv;
      case gate_int_delay is
         when "00" =>
            t2_int_dly_gate_rcv  <= t1_gate_rcv;
         when "01" =>
            t2_int_dly_gate_rcv  <= t2_gate_rcv;
         when "10" =>
            t2_int_dly_gate_rcv  <= t3_gate_rcv;
         when "11" =>        
            t2_int_dly_gate_rcv  <= t4_gate_rcv;
         when others =>
            t2_int_dly_gate_rcv  <= t4_gate_rcv;
      end case;  
      case sync_int_delay is
         when "00" =>
            t2_int_dly_sync_rcv <= t1_sync_rcv;
         when "01" =>
            t2_int_dly_sync_rcv <= t2_sync_rcv;
         when "10" =>
            t2_int_dly_sync_rcv <= t3_sync_rcv;
         when "11" =>
            t2_int_dly_sync_rcv <= t4_sync_rcv;
         when others =>
            t2_int_dly_sync_rcv <= t4_sync_rcv;
      end case;
      case trig_ttl_int_delay is
         when "00" =>
            t2_int_dly_ttl_trig_rcv  <= t1_trig_ttl_rcv;
         when "01" =>
            t2_int_dly_ttl_trig_rcv  <= t2_trig_ttl_rcv;
         when "10" =>
            t2_int_dly_ttl_trig_rcv  <= t3_trig_ttl_rcv;
         when "11" =>        
            t2_int_dly_ttl_trig_rcv  <= t4_trig_ttl_rcv;
         when others =>
            t2_int_dly_ttl_trig_rcv  <= t4_trig_ttl_rcv;
      end case;  
      case sysref_int_delay is
         when "00" =>
            t2_int_dly_sysref_rcv  <= t1_sysref_rcv;
         when "01" =>
            t2_int_dly_sysref_rcv  <= t2_sysref_rcv;
         when "10" =>
            t2_int_dly_sysref_rcv  <= t3_sysref_rcv;
         when "11" =>        
            t2_int_dly_sysref_rcv  <= t4_sysref_rcv;
         when others =>
            t2_int_dly_sysref_rcv  <= t4_sysref_rcv;
      end case; 
      t2_user_gate_rcv <= t1_user_gate_rcv;
      t2_user_sync_rcv <= t1_user_sync_rcv;
      t2_rtc_pps_rcv   <= t1_rtc_pps_rcv;
   end if;
end process;

--=============================================================================
-- Select sources for internally used gate, sync and pps signals
--=============================================================================

-------------------------------------------------------------------------------
-- Gate Multiplexer
-------------------------------------------------------------------------------

-- Potential Sources:
-- 000 None (off)
-- 001 Gate Register Bit
-- 010 LVTTL Trig input (Active high)
-- 011 LVTTL Trig input (Active low)
-- 100 Sync Bus Differential Gate/Trig (Active high)
-- 101 Sync Bus Differential Gate/Trig (Active low)
-- 110 User Gate  (Active high)
-- 111 User Gate  (Active low)

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      case gate_rcv_src is
         -- Gate is parked off.
         when "000" =>
            t3_mux_gate <= '0';
         -- Gate Register Bit
         -- (Always active high.)
         when "001" =>
            t3_mux_gate  <= t1_gate_reg_gen;
         -- Front Panel LVTTL Gate/Trig input
         when "010" => -- Active high ttl trig
            t3_mux_gate  <= t2_int_dly_ttl_trig_rcv;
         when "011" => -- Active low ttl trig  
            t3_mux_gate  <= not t2_int_dly_ttl_trig_rcv;
         when "100" =>  -- Sync Bus Differential Gate (active high)
             t3_mux_gate <= t2_int_dly_gate_rcv; 
         when "101" => -- Sync Bus Differential Gate (active low)
            t3_mux_gate  <= not t2_int_dly_gate_rcv;   
         when "110" =>
            t3_mux_gate  <= t2_user_gate_rcv;
         -- Front Panel Sync Bus Differential Gate/Trig 
         when "111" =>
            t3_mux_gate  <= not t2_user_gate_rcv;         
         when others =>
            t3_mux_gate  <= not t2_user_gate_rcv; 
      end case;
   end if;
end process;

-------------------------------------------------------------------------------
-- Sync Multiplexer
-------------------------------------------------------------------------------

-- Potential Sources:
-- 000 None (off)
-- 001 Sync Register Bit
-- 010 Rising Edge of Gate 
-- 011 Falling Edge of Gate
-- 100 Sync Bus Differential Sync (Active high)
-- 101 Sync Bus Differential Sync (Active low) 
-- 110 User Sync Input (Active high)
-- 111 User Sync Input (Active low) 

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      case sync_rcv_src is
         -- Gate is parked off.
         when "000" =>
            t3_mux_sync  <= '0';
         -- Gate Register Bit
         -- (Always active high.)
         when "001" =>
            t3_mux_sync  <= t1_sync_reg_gen;
         when "010" => -- rising edge of gate  
            t3_mux_sync  <= t3_re_gate;
         when "011" => -- falling edge of gate
            t3_mux_sync  <= t3_fe_gate;
         -- Sync Bus Differential Gate/Trig 
         when "100" =>
            t3_mux_sync  <= t2_int_dly_sync_rcv;
         -- Sync Bus Differential Gate/Trig 
         when "101" =>
            t3_mux_sync  <= not t2_int_dly_sync_rcv;
         when "110" => -- Active high user sync
            t3_mux_sync  <= t2_user_sync_rcv;
         when "111" => -- Active low user sync   
            t3_mux_sync  <= not t2_user_sync_rcv;               
         when others =>
            t3_mux_sync  <= not t2_user_sync_rcv;
      end case;
   end if;
end process;

-------------------------------------------------------------------------------
-- PPS Multiplexer
-------------------------------------------------------------------------------

-- Potential Sources:
-- 0000 None (off)
-- 0001 PPS Register Bit
-- 0010 PPS input (Active high)
-- 0011 PPS input (Active low)
-- 0100 Rising Edge of Selected Gate
-- 0101 Falling Edge of Selected Gate
-- 0110 Sync Bus Differential Sync (Active high)
-- 0111 Sync Bus Differential Sync (Active low)
-- 1000 LVTTL Trig input (Active high)
-- 1001 LVTTL Trig input (Active low) 
-- 1010 RTC PPS (Active high)
-- 1011 RTC PPS (Active low) 
-- 1100 User PPS in 

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      case pps_rcv_src is
         -- PPS is parked off.
         when "0000" =>
            t3_mux_pps  <= '0';
         -- PPS Register Bit
         -- (Always active high.)
         when "0001" =>
            t3_mux_pps  <= t1_pps_reg_gen;
         when "0010" => -- Active high PPS in
            t3_mux_pps  <= t2_pps_rcv;
         when "0011" => -- Active low PPS in  
            t3_mux_pps  <= not t2_pps_rcv;
         when "0100" => -- rising edge of gate  
            t3_mux_pps  <= t3_re_gate;
         when "0101" => -- falling edge of gate
            t3_mux_pps  <= t3_fe_gate;
         -- Sync Bus Differential Sync
         when "0110" =>
            t3_mux_pps  <= t2_int_dly_sync_rcv;
         -- Sync Bus Differential Sync 
         when "0111" =>
            t3_mux_pps  <= not t2_int_dly_sync_rcv;    
         when "1000" => -- Active high ttl trig
            t3_mux_pps  <= t2_int_dly_ttl_trig_rcv;
         when "1001" => -- Active low ttl trig   
            t3_mux_pps  <= not t2_int_dly_ttl_trig_rcv;
         when "1010" => -- Active high rtc pps
            t3_mux_pps  <= t2_rtc_pps_rcv;
         when "1011" => -- Active low rtc pps  
            t3_mux_pps  <= not (t2_rtc_pps_rcv);
         when "1100" => -- User PPS input
            t3_mux_pps  <= t2_user_pps_in;    
         when others =>
            t3_mux_pps  <= '0'; 
      end case;
   end if;
end process;

-------------------------------------------------------------------------------
-- Sysref Multiplexer
-------------------------------------------------------------------------------

-- Potential Sources:
-- 0000 None (off)
-- 0001 Sysref Register Bit
-- 0010 Sysref input (Active high)
-- 0011 Sysref input (Active low)
-- 0100 Rising Edge of Selected Gate
-- 0101 Falling Edge of Selected Gate
-- 0110 Sync Bus Differential Sync (Active high)
-- 0111 Sync Bus Differential Sync (Active low)
-- 1000 LVTTL Trig input (Active high)
-- 1001 LVTTL Trig input (Active low) 
-- 1010 PPS (Active high)
-- 1011 PPS (Active low) 
-- 1100 User PPS in 

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      case sysref_rcv_src is
         -- PPS is parked off.
         when "0000" =>
            t3_mux_sysref  <= '0';
         -- PPS Register Bit
         -- (Always active high.)
         when "0001" =>
            t3_mux_sysref  <= t1_sysref_reg_gen;
         when "0010" => -- Active high sysref in
            t3_mux_sysref  <= t2_sysref_rcv;
         when "0011" => -- Active low sysref in  
            t3_mux_sysref  <= not t2_sysref_rcv;
         when "0100" => -- rising edge of gate  
            t3_mux_sysref  <= t3_re_gate;
         when "0101" => -- falling edge of gate
            t3_mux_sysref  <= t3_fe_gate;
         -- Sync Bus Differential Sync
         when "0110" =>
            t3_mux_sysref  <= t2_int_dly_sync_rcv;
         -- Sync Bus Differential Sync 
         when "0111" =>
            t3_mux_sysref  <= not t2_int_dly_sync_rcv;    
         when "1000" => -- Active high ttl trig
            t3_mux_sysref  <= t2_int_dly_ttl_trig_rcv;
         when "1001" => -- Active low ttl trig   
            t3_mux_sysref  <= not t2_int_dly_ttl_trig_rcv;
         when "1010" => -- Active high pps
            t3_mux_sysref  <= t2_pps_rcv;
         when "1011" => -- Active low pps  
            t3_mux_sysref  <= not t2_pps_rcv;
         when "1100" => -- User PPS input
            t3_mux_sysref  <= t2_user_pps_in;    
         when others =>
            t3_mux_sysref  <= '0'; 
      end case;
   end if;
end process;
gen_sr_mux: if (ext_axiclk_version = false) generate
sysref_out      <= t3_mux_sysref when (sysref_sel='1') else idelay_sysref_rcv;
end generate;

gen_no_sr_mux: if (ext_axiclk_version = true) generate
sysref_out      <= t3_mux_sysref;
end generate;

-------------------------------------------------------------------------------
-- Create Edge Signals for Interrupts
-------------------------------------------------------------------------------

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      t4_mux_gate   <= t3_mux_gate;
      t4_mux_sync   <= t3_mux_sync;
      t4_mux_pps    <= t3_mux_pps;
      t4_mux_sysref <= t3_mux_sysref;
      gate_re_event <= t3_mux_gate and (not t4_mux_gate);
      gate_fe_event <= t4_mux_gate and (not t3_mux_gate);
      sync_re_event <= t3_mux_sync and (not t4_mux_sync);
      sync_fe_event <= t4_mux_sync and (not t3_mux_sync);
      pps_re_event  <= t3_mux_pps  and (not t4_mux_pps );
      pps_fe_event  <= t4_mux_pps  and (not t3_mux_pps );   
      sysref_re_event  <= t3_mux_sysref  and (not t4_mux_sysref );
      sysref_fe_event  <= t4_mux_sysref  and (not t3_mux_sysref );
   end if;
end process;

t3_re_gate      <= t3_mux_gate and not t4_mux_gate;
t3_fe_gate      <= t4_mux_gate and not t3_mux_gate;

-----------------------------------------------------------------------------
-- Timing Events (AXI4-Stream Slave) no back pressure
-----------------------------------------------------------------------------
    -- tdata[7:0]       = Gate
    -- tdata[15:8]      = Sync 
    -- tdata[23:16]     = PPS   

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      m_axis_timecntl_tdata(7 downto 0)   <= t3_mux_gate & t3_mux_gate & t3_mux_gate & t3_mux_gate & t3_mux_gate & t3_mux_gate & t3_mux_gate & t3_mux_gate;
      m_axis_timecntl_tdata(15 downto 8)  <= t3_mux_sync & t3_mux_sync & t3_mux_sync & t3_mux_sync & t3_mux_sync & t3_mux_sync & t3_mux_sync & t3_mux_sync;
      m_axis_timecntl_tdata(23 downto 16) <= t3_mux_pps  & t3_mux_pps  & t3_mux_pps  & t3_mux_pps  & t3_mux_pps  & t3_mux_pps  & t3_mux_pps  & t3_mux_pps;
      m_axis_ptctl_tdata(0) <= t3_mux_gate;
      m_axis_ptctl_tdata(1) <= t3_mux_sync;
      m_axis_ptctl_tdata(2) <= t3_mux_pps;
   end if;
end process;

m_axis_ptctl_tdata(7 downto 3) <= "00000";
m_axis_ptctl_tvalid <= '1';
m_axis_timecntl_tvalid <= '1';
m_axis_timecntl_tdata(31 downto 24) <= (others => '0');

-------------------------------------------------------------------------------
-- Register the Control Register bits
-------------------------------------------------------------------------------

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      t1_gate_reg_gen    <= gate_reg_gen;
      t1_sync_reg_gen    <= sync_reg_gen;
      t1_pps_reg_gen     <= pps_reg_gen;
      t1_sysref_reg_gen  <= sysref_reg_gen;
   end if;
end process;

--------------------------------------------------------------------------------
-- LED Drive
--------------------------------------------------------------------------------

process(sample_clk)
begin
   if rising_edge(sample_clk) then
        case led_src(1 downto 0) is 
            when "00" =>
                led_lite  <= t3_mux_gate;
            when "01" =>    
                led_lite  <= t3_mux_sync;
            when "10" =>    
                led_lite  <= t3_mux_pps;
            when "11" =>    
                led_lite  <= t3_mux_sysref;
            when others =>
                led_lite  <= '0'; 
        end case;
  end if;
end process;   

-- Pulse Stretcher keeps LED lit longer than overload so it is more visible.         
process(sample_clk)
begin
   if rising_edge(sample_clk) then
      if led_lite = '1' then
         pls_strch_cntr    <= conv_std_logic_vector(led_pulse_stretch, 16);
      elsif pls_strch_cntr /= 0 then
         pls_strch_cntr    <= pls_strch_cntr - 1;
      end if;
    end if;
end process;

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      if (led_pulse_stretch = 0) then
         led_n <= not led_lite;
      elsif (pls_strch_cntr = 0) then
         led_n <= '1'; -- LED Drive (active low)
      else
         led_n <= '0';
      end if;
    end if;
end process;

end Behavioral;