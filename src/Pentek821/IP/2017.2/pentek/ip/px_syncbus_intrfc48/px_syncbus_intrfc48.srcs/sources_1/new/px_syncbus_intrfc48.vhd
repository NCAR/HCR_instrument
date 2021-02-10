----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 02/19/2015 09:17:54 AM
-- Design Name: 
-- Module Name: px_syncbus_intrfc1 - Behavioral
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

-- Register Map
-- 0x00 Gate Receive Buffer Control
-- 0x04 Sync Receive Buffer Control
-- 0x08 Aux  Receive Buffer Control
-- 0x0C Source Select
-- 0x10 Gate Gen
-- 0x14 Sync Gen
-- 0x18 PPS Gen
-- 0x1C Status Register
-- 0x20 Interrupt Enable Register
-- 0x24 Interrupt Status Register
-- 0x28 Interrupt Flag Register

-- Gate Receive Buffer Control
-- [8:0]   gate_tap_delay[8:0]
-- [13:12] gate_int_delay[1:0] 
-- [24:16] ttlgate_tap_delay[8:0]
-- [29:28] gate_ttl_int_delay[1:0] 
-- Sync Receive Buffer Control
-- [8:0]   reserved
-- [13:12] reserved
-- [24:16] ttlsync_tap_delay[8:0]
-- [29:28] sync_ttl_int_delay[1:0] 
-- Aux Receive Buffer Control
-- [8:0]   reserved
-- [13:12] reserved
-- Source Control Register
-- [0]     reserved
-- [1]     reserved
-- [6:4]   gate_rcv_src[2:0] 
-- [10:8]  sync_rcv_src[2:0] 
-- [15:12]  pps_rcv_src[3:0] 
-- [18:16] reserved
-- [22:20] reserved     
-- [26:24] led_src[2:0]
-- [29]   SDI External GATE DELAY  
-- [28]   SCLK External GATE DELAY  
-- [31]   SLOAD External GATE DELAY  

-- Gate Generate    
-- [0]     gate_reg_gen    
-- Sync Generate      
-- [0]     sync_reg_gen    
-- PPS Generate      
-- [0]     pps_reg_gen

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

-------------------------------------------------------------------------------
-- Libraries
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
Library UNISIM;
use UNISIM.vcomponents.all;

entity px_syncbus_intrfc48 is
generic(
    in_iodelay_grp                 : string  := "IODELAY_GRP";  
    has_user_pps_input             : boolean := true;
    has_user_sync_drive_in         : boolean := false;
    has_user_gate_drive_in         : boolean := false;
    initial_gate_tap_delay         : integer := 0;
    initial_sync_tap_delay         : integer := 0;
    initial_ttl_sync_tap_delay     : integer := 0;
    initial_gate_int_delay         : integer range 0 to 3 := 0;
    initial_sync_int_delay         : integer range 0 to 3 := 0;    
    initial_ttl_sync_int_delay     : integer range 0 to 3 := 0;   
    differential_term              : boolean := true;
    ibuf_low_pwr                   : boolean := false;
    idelaycntrl_refclk_freq        : integer := 200; -- in MHz 
    initial_led_src                : integer := 3; 
    led_pulse_stretch              : integer range 0 to 65535:= 65535 -- counts to pulse stretch LED
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
    gate_in_p               : in   std_logic_vector(3 downto 0);
    gate_in_n               : in   std_logic_vector(3 downto 0);
--    gate_trig_ttl_in        : in  std_logic; -- LVTTL Gate/Trig INPUT
    sync_pps_ttl_in         : in  std_logic; -- LVTTL Sync/PPS INPUT
       
    user_pps_in             : in  std_logic;
    
    user_sync_drive_in      : in  std_logic;
    user_gate_drive_in      : in  std_logic;
    
    ext_dly_sdi             : out std_logic;
    ext_dly_sclk            : out std_logic;
    ext_dly_sload           : out std_logic;
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
    m_axis_timecntl_tvalid  : out std_logic
 );
end px_syncbus_intrfc48;

architecture Behavioral of px_syncbus_intrfc48 is

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of sample_clk: SIGNAL is "xilinx.com:signal:clock:1.0 sample_clk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of sample_clk: SIGNAL is "ASSOCIATED_BUSIF m_axis_timecntl";

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Control/Status Registers
component px_syncbus_intrfc48_csr
generic (
   initial_gate_tap_delay         : integer := 0;          
   initial_ttl_sync_tap_delay     : integer := 0;       
   initial_gate_int_delay         : integer := 0;             
   initial_ttl_sync_int_delay     : integer := 0;    
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
    led_src               : out std_logic_vector(2 downto 0);
    gate_tap_delay        : out std_logic_vector(8 downto 0);
    ttlsync_tap_delay     : out std_logic_vector(8 downto 0);
    gate_int_delay        : out std_logic_vector(1 downto 0);
    sync_ttl_int_delay    : out std_logic_vector(1 downto 0);
    gate_rcv_src          : out std_logic_vector(3 downto 0);
    sync_rcv_src          : out std_logic_vector(3 downto 0);
    pps_rcv_src           : out std_logic_vector(3 downto 0);
    gate_reg_gen          : out std_logic;
    sync_reg_gen          : out std_logic;
    pps_reg_gen           : out std_logic;
    --gate_en_vtc           : out std_logic;
    --sync_en_vtc           : out std_logic;
    gate_dly_ld_ctl       : out std_logic;
    sync_dly_ld_ctl       : out std_logic;
    ext_dly_sdi           : out std_logic; -- External Gate Delay SPI 
    ext_dly_sclk          : out std_logic;
    ext_dly_sload         : out std_logic;    
--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------       	           
    selected_gate         : in std_logic;
    selected_sync         : in std_logic;
    selected_pps          : in std_logic;
    ttl_sync_pin          : in std_logic;
    diff_gate_pin         : in std_logic;
 -------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------
    gate_re_event         : in std_logic;
    gate_fe_event         : in std_logic;
    sync_re_event         : in std_logic;
    sync_fe_event         : in std_logic;
    pps_re_event          : in std_logic;
    pps_fe_event          : in std_logic
);
end component;

component IDELAYE3
   generic (
      CASCADE : string := "NONE";         -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT: string :=  "TIME";    -- Units of the DELAY_VALUE (COUNT, TIME)
      DELAY_SRC : string :=  "IDATAIN";    -- Delay input (DATAIN, IDATAIN)
      DELAY_TYPE : string := "VAR_LOAD";     -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE : integer := 0;          -- Input delay value setting
      IS_CLK_INVERTED : std_logic :=  '0';    -- Optional inversion for CLK
      IS_RST_INVERTED : std_logic :=  '0';    -- Optional inversion for RST
      REFCLK_FREQUENCY : real := 200.0; -- IDELAYCTRL clock input frequency in MHz (200.0-2400.0)
      UPDATE_MODE : string :=  "ASYNC"     -- Determines when updates to the delay will take effect (ASYNC, MANUAL, SYNC)
   );
   port (
      CASC_OUT : out std_logic;       -- 1-bit output: Cascade delay output to ODELAY input cascade
      CNTVALUEOUT: out std_logic_vector(8 downto 0); -- 9-bit output: Counter value output
      DATAOUT : out std_logic;        -- 1-bit output: Delayed data output
      CASC_IN : in  std_logic;        -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN : in  std_logic; -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE : in  std_logic;                   -- 1-bit input: Active high enable increment/decrement input
      CLK: in std_logic;                  -- 1-bit input: Clock input
      CNTVALUEIN : in std_logic_vector(8 downto 0);    -- 9-bit input: Counter value input
      DATAIN : in std_logic;           -- 1-bit input: Data input from the IOBUF
      EN_VTC : in std_logic;           -- 1-bit input: Keep delay constant over VT
      IDATAIN : in std_logic;          -- 1-bit input: Data input from the logic
      INC : in std_logic;                  -- 1-bit input: Increment / Decrement tap delay input
      LOAD: in std_logic;               -- 1-bit input: Load DELAY_VALUE input
      RST : in std_logic               -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
end component;

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

attribute IODELAY_GROUP : STRING;
attribute IODELAY_GROUP of IDELAYE3       : component is in_iodelay_grp;

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------

constant refclk_freq : real := real(idelaycntrl_refclk_freq);

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal m_axi_xc_awaddr    : std_logic_vector(5 downto 0);
signal m_axi_xc_awprot    : std_logic_vector(2 downto 0);
signal m_axi_xc_awvalid   : std_logic;
signal m_axi_xc_awready   : std_logic;
signal m_axi_xc_wdata     : std_logic_vector(31 downto 0);
signal m_axi_xc_wstrb     : std_logic_vector(3 downto 0);
signal m_axi_xc_wvalid    : std_logic;
signal m_axi_xc_wready    : std_logic;
signal m_axi_xc_bresp     : std_logic_vector(1 downto 0);
signal m_axi_xc_bvalid    : std_logic;
signal m_axi_xc_bready    : std_logic;
signal m_axi_xc_araddr    : std_logic_vector(5 downto 0);
signal m_axi_xc_arprot    : std_logic_vector(2 downto 0);
signal m_axi_xc_arvalid   : std_logic;
signal m_axi_xc_arready   : std_logic;
signal m_axi_xc_rdata     : std_logic_vector(31 downto 0);
signal m_axi_xc_rresp     : std_logic_vector(1 downto 0);
signal m_axi_xc_rvalid    : std_logic;
signal m_axi_xc_rready    : std_logic;
signal led_src            : std_logic_vector(2 downto 0);
signal gate_tap_delay     : std_logic_vector(8 downto 0);
signal sync_tap_delay     : std_logic_vector(8 downto 0);
signal ttlgate_tap_delay  : std_logic_vector(8 downto 0);
signal ttlsync_tap_delay  : std_logic_vector(8 downto 0);
signal ttlssmc_tap_delay  : std_logic_vector(8 downto 0);
signal gate_int_delay     : std_logic_vector(1 downto 0);
signal sync_int_delay     : std_logic_vector(1 downto 0);
signal gate_ttl_int_delay : std_logic_vector(1 downto 0);
signal sync_ttl_int_delay : std_logic_vector(1 downto 0);
signal ssmc_ttl_int_delay : std_logic_vector(1 downto 0);
signal gate_rcv_src       : std_logic_vector(3 downto 0);
signal sync_rcv_src       : std_logic_vector(3 downto 0);
signal pps_rcv_src        : std_logic_vector(3 downto 0);
signal gate_drv_src       : std_logic_vector(2 downto 0);
signal sync_drv_src       : std_logic_vector(2 downto 0);
signal gate_reg_gen       : std_logic;
signal sync_reg_gen       : std_logic;
signal pps_reg_gen        : std_logic;
signal t3_mux_gate        : std_logic_vector(3 downto 0); 
signal t3_mux_sync        : std_logic_vector(3 downto 0);
signal t3_mux_pps         : std_logic_vector(3 downto 0); 
--signal t2_gate_trig_ttl_rcv: std_logic; 
signal t2_sync_pps_ttl_rcv : std_logic; 
signal t2_ssmc_gate_ttl_rcv: std_logic; 
signal t2_gate_rcv         : std_logic_vector(3 downto 0); 
signal gate_re_event       : std_logic;
signal gate_fe_event       : std_logic;
signal sync_re_event       : std_logic;
signal sync_fe_event       : std_logic;
signal pps_re_event        : std_logic;
signal pps_fe_event        : std_logic; 
signal csr_irq             : std_logic;
signal ibuf_gate_rcv       : std_logic_vector(3 downto 0);
--signal gate_trig_ttl_in_ibuf: std_logic;
signal sync_pps_ttl_in_ibuf: std_logic;
signal ssmc_gate_ttl_in_ibuf: std_logic;
signal gate_dly_ld         : std_logic;
signal sync_dly_ld         : std_logic;
signal ssmc_dly_ld         : std_logic;
--signal ld_cntr             : std_logic_vector(4 downto 0);
signal idelay_gate_rcv     : std_logic_vector(3 downto 0);
signal idelay_gate_trig_ttl: std_logic;
signal idelay_sync_pps_ttl : std_logic;
signal t1_gate_rcv         : std_logic_vector(3 downto 0);
--signal t1_gate_trig_ttl_rcv: std_logic;
signal t1_sync_pps_ttl_rcv : std_logic;
signal t1_ssmc_gate_ttl_rcv: std_logic;
--signal t3_gate_trig_ttl_rcv: std_logic;
--signal t4_gate_trig_ttl_rcv: std_logic;      
signal t3_sync_pps_ttl_rcv : std_logic;     
signal t4_sync_pps_ttl_rcv : std_logic;               
signal t2_int_dly_gate_rcv : std_logic_vector(3 downto 0);  
--signal t2_int_dly_ttl_gate_rcv: std_logic_vector(3 downto 0);
signal t2_int_dly_ttl_sync_rcv: std_logic_vector(3 downto 0);         
signal t4_mux_gate         : std_logic_vector(3 downto 0);         
signal t4_mux_sync         : std_logic_vector(3 downto 0);        
signal t4_mux_pps          : std_logic_vector(3 downto 0);      
signal t3_re_gate          : std_logic_vector(3 downto 0); 
signal t3_fe_gate          : std_logic_vector(3 downto 0); 
signal t1_gate_reg_gen     : std_logic; 
signal t1_sync_reg_gen     : std_logic; 
signal t1_pps_reg_gen      : std_logic; 
signal pls_strch_cntr      : std_logic_vector(15 downto 0);
signal led_lite            : std_logic;
signal gate_en_vtc         : std_logic;
signal sync_en_vtc         : std_logic;
signal diff_gate_pin       : std_logic;
signal selected_gate       : std_logic;
signal selected_sync       : std_logic;
signal selected_pps        : std_logic;
signal gate_dly_ld_ctl_re  : std_logic;
signal t1_gate_dly_ld_ctl  : std_logic;
signal gate_dly_ld_ctl     : std_logic;
signal hs_gate_dly_ld_ctl  : std_logic;
signal sync_dly_ld_ctl_re  : std_logic;
signal t1_sync_dly_ld_ctl  : std_logic;
signal sync_dly_ld_ctl     : std_logic;
signal hs_sync_dly_ld_ctl  : std_logic;
signal gate_ld_cntr        : std_logic_vector(5 downto 0) := "000000";
signal sync_ld_cntr        : std_logic_vector(5 downto 0) := "000000";
signal sample_clk_n        : std_logic;
signal t1_s_axi_csr_aresetn: std_logic := '0';

-------------------------------------------------------------------------------

begin

--------------------------------------------------------------------------------
-- Control/Status Registers
--------------------------------------------------------------------------------


-- Control registers operate in Sample clock Domain
csr_inst: px_syncbus_intrfc48_csr
generic map(
   initial_gate_tap_delay      => initial_gate_tap_delay,       
   initial_ttl_sync_tap_delay  => initial_ttl_sync_tap_delay, 
   initial_gate_int_delay      => initial_gate_int_delay,        
   initial_ttl_sync_int_delay  => initial_ttl_sync_int_delay, 
   initial_led_src             => initial_led_src          
)
port map (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
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
    ttlsync_tap_delay       => ttlsync_tap_delay,
    gate_int_delay          => gate_int_delay,
    sync_ttl_int_delay      => sync_ttl_int_delay,
    gate_rcv_src            => gate_rcv_src,
    sync_rcv_src            => sync_rcv_src,
    pps_rcv_src             => pps_rcv_src,
    gate_reg_gen            => gate_reg_gen,
    sync_reg_gen            => sync_reg_gen,
    pps_reg_gen             => pps_reg_gen,
    gate_dly_ld_ctl         => gate_dly_ld_ctl,
    sync_dly_ld_ctl         => sync_dly_ld_ctl,
    ext_dly_sdi             => ext_dly_sdi,  -- External Gate Delay SPI 
    ext_dly_sclk            => ext_dly_sclk, 
    ext_dly_sload           => ext_dly_sload,
--------------------------------------------------------------------------------
-- Status Inputs (synchronous to axis_aclk)
--------------------------------------------------------------------------------       	           
    selected_gate           => selected_gate,
    selected_sync           => selected_sync,
    selected_pps            => selected_pps, 
    ttl_sync_pin            => t2_sync_pps_ttl_rcv,
    diff_gate_pin           => diff_gate_pin,
 -------------------------------------------------------------------------------
-- Interrupt Sources (synchronous to axis_aclk)
--------------------------------------------------------------------------------
    gate_re_event           => gate_re_event, 
    gate_fe_event           => gate_fe_event, 
    sync_re_event           => sync_re_event, 
    sync_fe_event           => sync_fe_event, 
    pps_re_event            => pps_re_event,  
    pps_fe_event            => pps_fe_event  
);

diff_gate_pin <= t2_gate_rcv(0) or t2_gate_rcv(1) or t2_gate_rcv(2) or t2_gate_rcv(3);
selected_gate <= t3_mux_gate(0) or t3_mux_gate(1) or t3_mux_gate(2) or t3_mux_gate(3);
selected_sync <= t3_mux_sync(0) or t3_mux_sync(1) or t3_mux_sync(2) or t3_mux_sync(3);
selected_pps  <= t3_mux_pps(0) or t3_mux_pps(1) or t3_mux_pps(2) or t3_mux_pps(3);

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
        t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
        irq <= csr_irq;
   end if;
end process;

-------------------------------------------------------------------------------
-- Sync Bus Receivers
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Input Differential LVDS Buffers for the Front Panel Sync Bus
-------------------------------------------------------------------------------
gengate: for i in 0 to 3 generate
gate_ibufds_inst : IBUFDS
generic map (
   DIFF_TERM    => differential_term,
   IBUF_LOW_PWR => ibuf_low_pwr,      -- Low power (TRUE) vs. performance (FALSE)
   IOSTANDARD   => "LVDS"  
)
port map (
   I  => gate_in_p(i),
   IB => gate_in_n(i),
   O  => ibuf_gate_rcv(i)
);
end generate;

--ttlgate_ibuf: ibuf
--port map (
--    I => gate_trig_ttl_in,
--    O => gate_trig_ttl_in_ibuf
-- );   
 
ttlsync_ibuf: ibuf
port map  (
     I => sync_pps_ttl_in,
     O => sync_pps_ttl_in_ibuf
  );


-------------------------------------------------------------------------------
-- Input Variable Delays for Front Panel Sync Bus
-------------------------------------------------------------------------------
-- These delays are tap delays prior to the I/O pin register. They create
-- delay in increments of 75psec.
gen_idly: for i in 0 to 3 generate
gate_idelaye3_inst : IDELAYE3
   generic map (
      CASCADE => "NONE",         -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",    -- Units of the DELAY_VALUE (COUNT, TIME)
      DELAY_SRC => "IDATAIN",    -- Delay input (DATAIN, IDATAIN)
      DELAY_TYPE => "VAR_LOAD",     -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,          -- Input delay value setting
      IS_CLK_INVERTED => '0',    -- Optional inversion for CLK
      IS_RST_INVERTED => '0',    -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq, -- IDELAYCTRL clock input frequency in MHz (200.0-2400.0)
      UPDATE_MODE => "ASYNC"     -- Determines when updates to the delay will take effect (ASYNC, MANUAL, SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to ODELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => idelay_gate_rcv(i),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk, --sample_clk,                  -- 1-bit input: Clock input
      CNTVALUEIN => gate_tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => gate_en_vtc,           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_gate_rcv(i),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => gate_dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

end generate;


ttl_sync_idelaye3_inst : IDELAYE3
      generic map (
         CASCADE => "NONE",         -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
         DELAY_FORMAT => "TIME",    -- Units of the DELAY_VALUE (COUNT, TIME)
         DELAY_SRC => "IDATAIN",    -- Delay input (DATAIN, IDATAIN)
         DELAY_TYPE => "VAR_LOAD",     -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
         DELAY_VALUE => 0,          -- Input delay value setting
         IS_CLK_INVERTED => '0',    -- Optional inversion for CLK
         IS_RST_INVERTED => '0',    -- Optional inversion for RST
         REFCLK_FREQUENCY => refclk_freq, -- IDELAYCTRL clock input frequency in MHz (200.0-2400.0)
         UPDATE_MODE => "ASYNC"     -- Determines when updates to the delay will take effect (ASYNC, MANUAL, SYNC)
      )
      port map (
         CASC_OUT => open,       -- 1-bit output: Cascade delay output to ODELAY input cascade
         CNTVALUEOUT => open, -- 9-bit output: Counter value output
         DATAOUT => idelay_sync_pps_ttl,         -- 1-bit output: Delayed data output
         CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
         CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
         CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
         CLK => s_axi_csr_aclk, --sample_clk,  -- 1-bit input: Clock input
         CNTVALUEIN => ttlsync_tap_delay,   -- 9-bit input: Counter value input
         DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
         EN_VTC => sync_en_vtc,           -- 1-bit input: Keep delay constant over VT
         IDATAIN => sync_pps_ttl_in_ibuf,         -- 1-bit input: Data input from the logic
         INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
         LOAD => sync_dly_ld,               -- 1-bit input: Load DELAY_VALUE input
         RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
      );    

-------------------------------------------------------------------------------
-- Register the delayed signals with IO Flip-Flops
-------------------------------------------------------------------------------

sample_clk_n <= not sample_clk;

gengate_reg: for i in 0 to 3 generate

IDDR_gate_inst : IDDRE1 
generic map (
   DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
   IS_C_INVERTED => '0'   -- Optional inversion for C
   )
port map (
   Q1    => t1_gate_rcv(i),
   Q2    => open,
   C     => sample_clk,
   CB    => sample_clk_n,
   D     => idelay_gate_rcv(i),
   R     => '0'
);

end generate;

IDDR_sync_inst : IDDRE1 
generic map (
   DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
   IS_C_INVERTED => '0'   -- Optional inversion for C
   )
port map (
   Q1    => t1_sync_pps_ttl_rcv,
   Q2    => open,
   C     => sample_clk,
   CB    => sample_clk_n,
   D     => idelay_sync_pps_ttl,
   R     => '0'
);

--process(sample_clk)
--begin
--   if rising_edge(sample_clk) then
--      t1_gate_rcv            <= idelay_gate_rcv;
----      t1_gate_trig_ttl_rcv   <= idelay_gate_trig_ttl;
--      t1_sync_pps_ttl_rcv    <= idelay_sync_pps_ttl;
--   end if;
--end process;

-------------------------------------------------------------------------------
-- Add desired Integer # clock cycles to selected signals
-------------------------------------------------------------------------------
-- This may be required to calibrate out SYNC Bus latency across multiple
-- boards.
 
process(sample_clk)
begin
   if rising_edge(sample_clk) then
      t2_gate_rcv  <= t1_gate_rcv;
      t2_sync_pps_ttl_rcv  <= t1_sync_pps_ttl_rcv;
      t3_sync_pps_ttl_rcv  <= t2_sync_pps_ttl_rcv;
      t4_sync_pps_ttl_rcv  <= t3_sync_pps_ttl_rcv;
      case gate_int_delay is
         when "00" =>
            t2_int_dly_gate_rcv  <= t1_gate_rcv;
         when "01" =>
            t2_int_dly_gate_rcv  <= t1_gate_rcv(2 downto 0) & t2_gate_rcv(3);
         when "10" =>
            t2_int_dly_gate_rcv  <= t1_gate_rcv(1 downto 0) & t2_gate_rcv(3 downto 2);
         when "11" =>        
            t2_int_dly_gate_rcv  <= t1_gate_rcv(0) & t2_gate_rcv(3 downto 1);
         when others =>
            t2_int_dly_gate_rcv  <= t1_gate_rcv;
      end case;  
      case sync_ttl_int_delay is
         when "00" =>
            t2_int_dly_ttl_sync_rcv <= t1_sync_pps_ttl_rcv & t1_sync_pps_ttl_rcv & t1_sync_pps_ttl_rcv & t1_sync_pps_ttl_rcv;
         when "01" =>
            t2_int_dly_ttl_sync_rcv <= t2_sync_pps_ttl_rcv & t2_sync_pps_ttl_rcv & t2_sync_pps_ttl_rcv & t2_sync_pps_ttl_rcv;
         when "10" =>
            t2_int_dly_ttl_sync_rcv <= t3_sync_pps_ttl_rcv & t3_sync_pps_ttl_rcv & t3_sync_pps_ttl_rcv & t3_sync_pps_ttl_rcv;
         when "11" =>
            t2_int_dly_ttl_sync_rcv <= t4_sync_pps_ttl_rcv & t4_sync_pps_ttl_rcv & t4_sync_pps_ttl_rcv & t4_sync_pps_ttl_rcv;
         when others =>
            t2_int_dly_ttl_sync_rcv <= t4_sync_pps_ttl_rcv & t4_sync_pps_ttl_rcv & t4_sync_pps_ttl_rcv & t4_sync_pps_ttl_rcv;
      end case;
   end if;
end process;

--=============================================================================
-- Select sources for internally used gate, sync and pps signals
--=============================================================================

-------------------------------------------------------------------------------
-- Gate Multiplexer
-------------------------------------------------------------------------------

-- Potential Sources:
-- 0000 None (off)
-- 0001 Gate Register Bit
-- 0010 Front Panel LVTTL Gate/Trig input (Active high)
-- 0011 Front Panel LVTTL Gate/Trig input (Active low)
-- 0100 reserved
-- 0101 reserved
-- 0110 Front Panel Sync Bus Differential Gate/Trig (Active high)
-- 0111 Front Panel Sync Bus Differential Gate/Trig (Active low)
-- 1000 User Gate

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      case gate_rcv_src is
         -- Gate is parked off.
         when "0000" =>
            t3_mux_gate <= "0000";
         -- Gate Register Bit
         -- (Always active high.)
         when "0001" =>
            t3_mux_gate  <= t1_gate_reg_gen & t1_gate_reg_gen & t1_gate_reg_gen & t1_gate_reg_gen;
         -- Front Panel LVTTL Gate/Trig input
         when "0010" => -- Active high ttl pps/sync/gate/trig
            t3_mux_gate  <= t2_int_dly_ttl_sync_rcv;
         when "0011" => -- Active low ttl gate   
            t3_mux_gate  <= not t2_int_dly_ttl_sync_rcv;
         when "0100" => -- Active high ssmc ttl gate  
            t3_mux_gate  <= "0000";
         when "0101" => -- Active low ssmc ttl gate  
            t3_mux_gate  <= "0000";    
         -- Front Panel Sync Bus Differential Sync
         when "0110" =>
            t3_mux_gate  <= t2_int_dly_gate_rcv;
         -- Front Panel Sync Bus Differential Gate/Trig 
         when "0111" =>
            t3_mux_gate  <= not t2_int_dly_gate_rcv;     
         when "1000" =>
            t3_mux_gate  <= user_gate_drive_in & user_gate_drive_in & user_gate_drive_in & user_gate_drive_in;               
         when others =>
            t3_mux_gate  <= user_gate_drive_in & user_gate_drive_in & user_gate_drive_in & user_gate_drive_in; 
      end case;
   end if;
end process;

-------------------------------------------------------------------------------
-- Sync Multiplexer
-------------------------------------------------------------------------------

-- Potential Sources:
-- 000 None (off)
-- 001 Gate Register Bit
-- 010 Front Panel LVTTL Sync input (Active high)
-- 011 Front Panel LVTTL Sync input (Active low)
-- 100 Rising Edge of Gate
-- 101 Falling Edge of Gate
-- 110 reserved
-- 111 reserved

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      case sync_rcv_src is
         -- Gate is parked off.
         when "0000" =>
            t3_mux_sync  <= "0000";
         -- Gate Register Bit
         -- (Always active high.)
         when "0001" =>
            t3_mux_sync  <= t1_sync_reg_gen & t1_sync_reg_gen & t1_sync_reg_gen & t1_sync_reg_gen;
         -- Front Panel LVTTL Sync input
         when "0010" => -- Active high ttl sync
            t3_mux_sync  <= t2_int_dly_ttl_sync_rcv;
         when "0011" => -- Active low ttl sync   
            t3_mux_sync  <= not t2_int_dly_ttl_sync_rcv;
         when "0100" => -- rising edge of gate  
            t3_mux_sync  <= t3_re_gate;
         when "0101" => -- falling edge of gate
            t3_mux_sync  <= t3_fe_gate;
         -- Front Panel Sync Bus Differential Gate/Trig 
         when "0110" =>
            t3_mux_sync  <= "0000";
         -- Front Panel Sync Bus Differential Gate/Trig 
         when "0111" =>
            t3_mux_sync  <= "0000"; 
         when "1000" =>
            t3_mux_sync  <=    user_sync_drive_in & user_sync_drive_in & user_sync_drive_in & user_sync_drive_in;           
         when others =>
            t3_mux_sync  <=    user_sync_drive_in & user_sync_drive_in & user_sync_drive_in & user_sync_drive_in;  
      end case;
   end if;
end process;

-------------------------------------------------------------------------------
-- PPS Multiplexer
-------------------------------------------------------------------------------


-- Potential Sources:
-- 0000 None (off)
-- 0001 PPS Register Bit
-- 0010 Front Panel LVTTL Sync/PPS input (Active high)
-- 0011 Front Panel LVTTL Sync/PPS input (Active low)
-- 0100 Rising Edge of Selected Gate
-- 0101 Falling Edge of Selected Gate
-- 0110 reserved
-- 0111 reserved
-- 1000 Front Panel LVTTL Gate/Trig input (Active high)
-- 1001 Front Panel LVTTL Gate/Trig input (Active low) 
-- 1010 reserved
-- 1011 reserved
-- 1100 User PPS Input

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      case pps_rcv_src is
         -- PPS is parked off.
         when "0000" =>
            t3_mux_pps  <= "0000";
         -- PPS Register Bit
         -- (Always active high.)
         when "0001" =>
            t3_mux_pps  <= t1_pps_reg_gen & t1_pps_reg_gen & t1_pps_reg_gen & t1_pps_reg_gen;
         -- Front Panel LVTTL Sync input
         when "0010" => -- Active high ttl sync
            t3_mux_pps  <= t2_int_dly_ttl_sync_rcv;
         when "0011" => -- Active low ttl sync   
            t3_mux_pps  <= not t2_int_dly_ttl_sync_rcv;
         when "0100" => -- rising edge of gate  
            t3_mux_pps  <= t3_re_gate;
         when "0101" => -- falling edge of gate
            t3_mux_pps  <= t3_fe_gate;
         -- Front Panel Sync Bus Differential Gate/Trig 
         when "0110" =>
            t3_mux_pps  <= "0000";
         -- Front Panel Sync Bus Differential Gate/Trig 
         when "0111" =>
            t3_mux_pps  <= "0000";    
         when "1000" => -- Active high ttl sync
            t3_mux_pps  <= t2_int_dly_ttl_sync_rcv;
         when "1001" => -- Active high ttl sync 
            t3_mux_pps  <= not t2_int_dly_ttl_sync_rcv;
         when "1010" => -- Active high ssmc ttl gate  
            t3_mux_pps  <= "0000";
         when "1011" => -- Active low ssmc ttl gate  
            t3_mux_pps  <= "0000";
         when "1100" => -- User PPS input
            if (has_user_pps_input = true) then
                t3_mux_pps  <= user_pps_in & user_pps_in & user_pps_in & user_pps_in;
            else
                t3_mux_pps  <= "0000";
            end if;                
         when others =>
            t3_mux_pps  <= "0000"; 
      end case;
   end if;
end process;

-------------------------------------------------------------------------------
-- Create Edge Signals for Interrupts
-------------------------------------------------------------------------------

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      t4_mux_gate   <= t3_mux_gate;
      t4_mux_sync   <= t3_mux_sync;
      t4_mux_pps    <= t3_mux_pps;
      gate_re_event <= (t3_mux_gate(3) and not t3_mux_gate(2)) or (t3_mux_gate(2) and not t3_mux_gate(1)) or (t3_mux_gate(1) and not t3_mux_gate(0)) or (t3_mux_gate(0) and not t4_mux_gate(3));
      gate_fe_event <= (t3_mux_gate(2) and not t3_mux_gate(3)) or (t3_mux_gate(1) and not t3_mux_gate(2)) or (t3_mux_gate(0) and not t3_mux_gate(1)) or (t4_mux_gate(3) and not t3_mux_gate(0));
      sync_re_event <= (t3_mux_sync(3) and not t3_mux_sync(2)) or (t3_mux_sync(2) and not t3_mux_sync(1)) or (t3_mux_sync(1) and not t3_mux_sync(0)) or (t3_mux_sync(0) and not t4_mux_sync(3));                
      sync_fe_event <= (t3_mux_sync(2) and not t3_mux_sync(3)) or (t3_mux_sync(1) and not t3_mux_sync(2)) or (t3_mux_sync(0) and not t3_mux_sync(1)) or (t4_mux_sync(3) and not t3_mux_sync(0));                
      pps_re_event  <= (t3_mux_pps(3) and not t3_mux_pps(2)) or (t3_mux_pps(2) and not t3_mux_pps(1)) or (t3_mux_pps(1) and not t3_mux_pps(0)) or (t3_mux_pps(0) and not t4_mux_pps(3));
      pps_fe_event  <= (t3_mux_pps(2) and not t3_mux_pps(3)) or (t3_mux_pps(1) and not t3_mux_pps(2)) or (t3_mux_pps(0) and not t3_mux_pps(1)) or (t4_mux_pps(3) and not t3_mux_pps(0));
   end if;
end process;

t3_re_gate      <= (t3_mux_gate(3) and not t3_mux_gate(2)) & (t3_mux_gate(2) and not t3_mux_gate(1)) & (t3_mux_gate(1) and not t3_mux_gate(0)) & (t3_mux_gate(0) and not t4_mux_gate(3));
t3_fe_gate      <= (t3_mux_gate(2) and not t3_mux_gate(3)) & (t3_mux_gate(1) and not t3_mux_gate(2)) & (t3_mux_gate(0) and not t3_mux_gate(1)) & (t4_mux_gate(3) and not t3_mux_gate(0));

-----------------------------------------------------------------------------
-- Timing Events (AXI4-Stream Slave) no back pressure
-----------------------------------------------------------------------------
    -- tdata[0]       = Gate
    -- tdata[1]       = Sync 
    -- tdata[2]       = PPS   

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      m_axis_timecntl_tdata(0) <= t3_mux_gate(0);
      m_axis_timecntl_tdata(1) <= t3_mux_gate(0);
      m_axis_timecntl_tdata(2) <= t3_mux_gate(1);
      m_axis_timecntl_tdata(3) <= t3_mux_gate(1);
      m_axis_timecntl_tdata(4) <= t3_mux_gate(2);
      m_axis_timecntl_tdata(5) <= t3_mux_gate(2);
      m_axis_timecntl_tdata(6) <= t3_mux_gate(3);
      m_axis_timecntl_tdata(7) <= t3_mux_gate(3);
      m_axis_timecntl_tdata(8) <= t3_mux_sync(0);
      m_axis_timecntl_tdata(9) <= t3_mux_sync(0);
      m_axis_timecntl_tdata(10) <= t3_mux_sync(1);
      m_axis_timecntl_tdata(11) <= t3_mux_sync(1);
      m_axis_timecntl_tdata(12) <= t3_mux_sync(2);
      m_axis_timecntl_tdata(13) <= t3_mux_sync(2);
      m_axis_timecntl_tdata(14) <= t3_mux_sync(3);
      m_axis_timecntl_tdata(15) <= t3_mux_sync(3);
      m_axis_timecntl_tdata(16) <= t3_mux_pps(0);
      m_axis_timecntl_tdata(17) <= t3_mux_pps(0);
      m_axis_timecntl_tdata(18) <= t3_mux_pps(1);
      m_axis_timecntl_tdata(19) <= t3_mux_pps(1);
      m_axis_timecntl_tdata(20) <= t3_mux_pps(2);
      m_axis_timecntl_tdata(21) <= t3_mux_pps(2);
      m_axis_timecntl_tdata(22) <= t3_mux_pps(3);
      m_axis_timecntl_tdata(23) <= t3_mux_pps(3);
   end if;
end process;
m_axis_timecntl_tdata(31 downto 24) <= x"00"; 
m_axis_timecntl_tvalid <= '1';

-------------------------------------------------------------------------------
-- Register the Control Register bits
-------------------------------------------------------------------------------

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      t1_gate_reg_gen <= gate_reg_gen;
      t1_sync_reg_gen <= sync_reg_gen;
      t1_pps_reg_gen  <= pps_reg_gen;
   end if;
end process;

--------------------------------------------------------------------------------
-- LED Drive
--------------------------------------------------------------------------------

process(sample_clk)
begin
   if rising_edge(sample_clk) then
        case led_src is 
            when "000" =>
                led_lite  <= '0';
            when "001" =>    
                if t3_mux_gate /= "0000" then
                    led_lite  <= '1';
                else
                    led_lite  <= '0';
                end if;    
            when "010" =>   
                if t3_mux_sync /= "0000" then
                    led_lite  <= '1';
                else
                    led_lite  <= '0';
                end if;   
            when "011" =>   
                if t3_mux_pps /= "0000" then
                    led_lite  <= '1';        
                else                         
                    led_lite  <= '0';        
                end if;                       
            when "100" =>    
                led_lite  <= '0';
            when "101" =>    
                led_lite  <= '0';
            when "110" =>    
                led_lite  <= user_pps_in;
            when "111" =>   
                led_lite  <= user_pps_in;
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
      if (pls_strch_cntr = 0) or (led_src = "000") then
         led_n <= '1'; -- Overload LED Drive (active low)
      else
         led_n <= '0';
      end if;
    end if;
end process;



--------------------------------------------------------------------------------
-- Sync Bus Delay Control
--------------------------------------------------------------------------------

g_HARD_SYNC_inst : HARD_SYNC
      generic map (
         INIT => '0',            -- Initial values, '0', '1'
         IS_CLK_INVERTED => '0', -- Programmable inversion on CLK input
         LATENCY => 2            -- 2-3
      )
      port map (
         DOUT => hs_gate_dly_ld_ctl, -- 1-bit output: Data
         CLK => s_axi_csr_aclk,   -- 1-bit input: Clock
         DIN => gate_dly_ld_ctl   -- 1-bit input: Data
      );
         
s_HARD_SYNC_inst : HARD_SYNC
         generic map (
            INIT => '0',            -- Initial values, '0', '1'
            IS_CLK_INVERTED => '0', -- Programmable inversion on CLK input
            LATENCY => 2            -- 2-3
         )
         port map (
            DOUT => hs_sync_dly_ld_ctl, -- 1-bit output: Data
            CLK => s_axi_csr_aclk,   -- 1-bit input: Clock
            DIN => sync_dly_ld_ctl    -- 1-bit input: Data
         );

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if (t1_s_axi_csr_aresetn = '0') then 
         gate_dly_ld_ctl_re <= '0';
         t1_gate_dly_ld_ctl <= '0';
      else
         gate_dly_ld_ctl_re <= (not t1_gate_dly_ld_ctl) and hs_gate_dly_ld_ctl;
         t1_gate_dly_ld_ctl <= hs_gate_dly_ld_ctl;
      end if;   
      if (t1_s_axi_csr_aresetn = '0') or (gate_dly_ld_ctl_re = '1') then
         gate_ld_cntr <= "000000";
      elsif (gate_ld_cntr /= "111111") then       
         gate_ld_cntr <= gate_ld_cntr + 1;
      end if;   
      if gate_ld_cntr = "100000" then
        gate_dly_ld <= '1';
      else
        gate_dly_ld <= '0';
      end if;
      if gate_ld_cntr = "111111" then
        gate_en_vtc <= '1';
      else
        gate_en_vtc <= '0';
      end if;
   end if;
end process;

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if (t1_s_axi_csr_aresetn = '0') then 
         sync_dly_ld_ctl_re <= '0';
         t1_sync_dly_ld_ctl <= '0';
      else
         sync_dly_ld_ctl_re <= (not t1_sync_dly_ld_ctl) and hs_sync_dly_ld_ctl;
         t1_sync_dly_ld_ctl <= hs_sync_dly_ld_ctl;
      end if;   
      if (t1_s_axi_csr_aresetn = '0') or (sync_dly_ld_ctl_re = '1') then
         sync_ld_cntr <= "000000";
      elsif (sync_ld_cntr /= "111111") then       
         sync_ld_cntr <= sync_ld_cntr + 1;
      end if;   
      if sync_ld_cntr = "100000" then
        sync_dly_ld <= '1';
      else
        sync_dly_ld <= '0';
      end if;
      if sync_ld_cntr = "111111" then
        sync_en_vtc <= '1';
      else
        sync_en_vtc <= '0';
      end if;
   end if;
end process;


end Behavioral;