----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 01/23/2017 09:17:54 AM
-- Design Name: 
-- Module Name: px_syncbus_intrfc2 - Behavioral
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
-- [8:0]   sync_tap_delay[8:0]
-- [13:12] sync_int_delay[1:0] 
-- [24:16] ttlsync_tap_delay[8:0]
-- [29:28] sync_ttl_int_delay[1:0] 
-- Aux Receive Buffer Control
-- [8:0]   ttlssmc_tap_delay[8:0]
-- [13:12] ssmc_ttl_int_delay[1:0] 
-- Source Control Register
-- [0]     sync bus master
-- [1]     sync bus clock master
-- [6:4]   gate_rcv_src[2:0] 
-- [10:8]  sync_rcv_src[2:0] 
-- [15:12]  pps_rcv_src[3:0] 
-- [18:16] gate_drv_src[2:0]  
-- [22:20] sync_drv_src[2:0]       
-- [26:24] led_src[2:0]
-- Gate Generate    
-- [0]     gate_reg_gen    
-- Sync Generate      
-- [0]     sync_reg_gen    
-- PPS Generate      
-- [0]     pps_reg_gen

-- (Important! Expects a Divide by 2 Sample clock input)

----------------------------------------------------------------------------------

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

entity px_syncbus_intrfc2 is
generic(
    in_iodelay_grp                 : string  := "IODELAY_GRP";
    is_single_ended_sig_master     : boolean := true;   
    has_ssmc_gate_input            : boolean := true;
    has_user_pps_input             : boolean := true;
    has_user_sync_drive_in         : boolean := false;
    has_user_gate_drive_in         : boolean := false;
    has_gate_trig_se_out           : boolean := false;
    has_sync_pps_se_out            : boolean := false;
    has_ssmc_gate_se_out           : boolean := false;
    has_gate_trig_se_in            : boolean := false;
    has_sync_pps_se_in             : boolean := false;
    has_ssmc_gate_se_in            : boolean := false;
    initial_gate_tap_delay         : integer := 0;
    initial_sync_tap_delay         : integer := 0;
    initial_ttl_gate_tap_delay     : integer := 0;
    initial_ttl_sync_tap_delay     : integer := 0;
    initial_ssmc_gate_tap_delay    : integer := 0;
    initial_gate_int_delay         : integer range 0 to 3 := 0;
    initial_sync_int_delay         : integer range 0 to 3 := 0;    
    initial_ttl_gate_int_delay     : integer range 0 to 3 := 0;
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
    sample_clk              : in  std_logic; -- (Important! Expects a Divide by 2 Sample clock input)
    gate_in_p               : in  std_logic;
    gate_in_n               : in  std_logic;
    sync_pps_in_p           : in  std_logic;
    sync_pps_in_n           : in  std_logic;
    gate_trig_ttl_in        : in  std_logic; -- LVTTL Gate/Trig INPUT
    sync_pps_ttl_in         : in  std_logic; -- LVTTL Sync/PPS INPUT
    ssmc_gate_ttl_in        : in  std_logic; -- LVTTL SSMC Gate/Trig/Sync/PPS 
    -- Bus Output 
    gate_out_p              : out std_logic;
    gate_out_n              : out std_logic;
    sync_pps_out_p          : out std_logic;
    sync_pps_out_n          : out std_logic;
    -- Output to Single Ended Slave for Single ended signals
    mstr_gate_trig_se_out   : out std_logic_vector(1 downto 0);
    mstr_sync_pps_se_out    : out std_logic_vector(1 downto 0);
    mstr_ssmc_gate_se_out   : out std_logic_vector(1 downto 0);
    -- Input from Single Ended Master 
    slv_gate_trig_se_in     : in  std_logic_vector(1 downto 0);
    slv_sync_pps_se_in      : in  std_logic_vector(1 downto 0);
    slv_ssmc_gate_se_in     : in  std_logic_vector(1 downto 0);
    
    sbus_master_n           : out  std_logic;
    clk_master_n            : out  std_logic;
    
    user_pps_in             : in  std_logic_vector(1 downto 0);
    
    user_sync_drive_in      : in  std_logic_vector(1 downto 0);
    user_gate_drive_in      : in  std_logic_vector(1 downto 0);
-----------------------------------------------------------------------------
-- LED Drive
-----------------------------------------------------------------------------
    led_n                   : out std_logic;
-----------------------------------------------------------------------------
-- Timing Events (AXI4-Stream Slave) no back pressure
-----------------------------------------------------------------------------
    -- tdata[1:0]       = Gate
    -- tdata[3:2]       = Sync 
    -- tdata[5:4]       = PPS   
    m_axis_timecntl_tdata   : out std_logic_vector(7 downto 0);
    m_axis_timecntl_tvalid  : out std_logic 
 );
end px_syncbus_intrfc2;

architecture Behavioral of px_syncbus_intrfc2 is

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
component px_syncbus_intrfc2_csr
generic (
   initial_gate_tap_delay         : integer := 0;     
   initial_sync_tap_delay         : integer := 0;     
   initial_ttl_gate_tap_delay     : integer := 0;     
   initial_ttl_sync_tap_delay     : integer := 0;     
   initial_ssmc_gate_tap_delay    : integer := 0;     
   initial_gate_int_delay         : integer := 0;     
   initial_sync_int_delay         : integer := 0;     
   initial_ttl_gate_int_delay     : integer := 0;     
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
    sync_tap_delay        : out std_logic_vector(8 downto 0);
    ttlgate_tap_delay     : out std_logic_vector(8 downto 0);
    ttlsync_tap_delay     : out std_logic_vector(8 downto 0);
    ttlssmc_tap_delay     : out std_logic_vector(8 downto 0);
    gate_int_delay        : out std_logic_vector(1 downto 0);
    sync_int_delay        : out std_logic_vector(1 downto 0);
    gate_ttl_int_delay    : out std_logic_vector(1 downto 0);
    sync_ttl_int_delay    : out std_logic_vector(1 downto 0);
    ssmc_ttl_int_delay    : out std_logic_vector(1 downto 0);
    gate_rcv_src          : out std_logic_vector(2 downto 0);
    sync_rcv_src          : out std_logic_vector(2 downto 0);
    pps_rcv_src           : out std_logic_vector(3 downto 0);
    gate_drv_src          : out std_logic_vector(2 downto 0);
    sync_drv_src          : out std_logic_vector(2 downto 0);
    gate_reg_gen          : out std_logic;
    sync_reg_gen          : out std_logic;
    pps_reg_gen           : out std_logic;
    sbus_master_n         : out std_logic;
    clk_master_n          : out std_logic;
--    gate_en_vtc           : out std_logic;
--    sync_en_vtc           : out std_logic;
--    ssmc_en_vtc           : out std_logic;
    gate_dly_ld_ctl       : out std_logic;
    sync_dly_ld_ctl       : out std_logic;
    ssmc_dly_ld_ctl       : out std_logic;
--------------------------------------------------------------------------------
-- Status Inputs (synchronous to axis_aclk)
--------------------------------------------------------------------------------       	           
    selected_gate         : in std_logic;
    selected_sync         : in std_logic;
    selected_pps          : in std_logic;
    ttl_gate_pin          : in std_logic;
    ttl_sync_pin          : in std_logic;
    ttl_ssmc_pin          : in std_logic;
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

signal led_src            : std_logic_vector(2 downto 0) := (others => '0');
signal gate_tap_delay     : std_logic_vector(8 downto 0) := (others => '0');
signal sync_tap_delay     : std_logic_vector(8 downto 0) := (others => '0');
signal ttlgate_tap_delay  : std_logic_vector(8 downto 0) := (others => '0');
signal ttlsync_tap_delay  : std_logic_vector(8 downto 0) := (others => '0');
signal ttlssmc_tap_delay  : std_logic_vector(8 downto 0) := (others => '0');
signal gate_int_delay     : std_logic_vector(1 downto 0) := (others => '0');
signal sync_int_delay     : std_logic_vector(1 downto 0) := (others => '0');
signal gate_ttl_int_delay : std_logic_vector(1 downto 0) := (others => '0');
signal sync_ttl_int_delay : std_logic_vector(1 downto 0) := (others => '0');
signal ssmc_ttl_int_delay : std_logic_vector(1 downto 0) := (others => '0');
signal gate_rcv_src       : std_logic_vector(2 downto 0) := (others => '0');
signal sync_rcv_src       : std_logic_vector(2 downto 0) := (others => '0');
signal pps_rcv_src        : std_logic_vector(3 downto 0) := (others => '0');
signal gate_drv_src       : std_logic_vector(2 downto 0) := (others => '0');
signal sync_drv_src       : std_logic_vector(2 downto 0) := (others => '0');
signal gate_reg_gen       : std_logic := '0';
signal sync_reg_gen       : std_logic := '0';
signal pps_reg_gen        : std_logic := '0';
signal t3_mux_gate        : std_logic_vector(1 downto 0) := "00";
signal t3_mux_sync        : std_logic_vector(1 downto 0) := "00";
signal t3_mux_pps         : std_logic_vector(1 downto 0) := "00";
signal t2_gate_trig_ttl_rcv: std_logic := '0'; 
signal t2_sync_pps_ttl_rcv : std_logic := '0'; 
signal t2_ssmc_gate_ttl_rcv: std_logic := '0'; 
signal t2_gate_rcv         : std_logic := '0'; 
signal t2_sync_rcv         : std_logic := '0'; 
signal gate_re_event       : std_logic := '0';
signal gate_fe_event       : std_logic := '0';
signal sync_re_event       : std_logic := '0';
signal sync_fe_event       : std_logic := '0';
signal pps_re_event        : std_logic := '0';
signal pps_fe_event        : std_logic := '0'; 
signal csr_irq             : std_logic := '0';
signal ibuf_gate_rcv       : std_logic := '0';
signal ibuf_sync_rcv        : std_logic := '0';
signal gate_trig_ttl_in_ibuf: std_logic := '0';
signal sync_pps_ttl_in_ibuf: std_logic := '0';
signal ssmc_gate_ttl_in_ibuf: std_logic := '0';
signal gate_dly_ld         : std_logic := '0';
signal sync_dly_ld         : std_logic := '0';
signal ssmc_dly_ld         : std_logic := '0';
signal gate_ld_cntr        : std_logic_vector(5 downto 0) := "000000";
signal sync_ld_cntr        : std_logic_vector(5 downto 0) := "000000";
signal ssmc_ld_cntr        : std_logic_vector(5 downto 0) := "000000";
signal idelay_gate_rcv     : std_logic := '0';
signal idelay_sync_rcv     : std_logic := '0';
signal idelay_gate_trig_ttl: std_logic := '0';
signal idelay_sync_pps_ttl : std_logic := '0';
signal idelay_ssmc_gate_ttl: std_logic := '0';
signal q1_iddr_gate_rcv    : std_logic := '0';
signal q2_iddr_gate_rcv    : std_logic := '0';
signal q1_iddr_sync_rcv    : std_logic := '0';
signal q2_iddr_sync_rcv    : std_logic := '0';
signal t1_q1_gate_rcv         : std_logic := '0';
signal t1_q2_gate_rcv         : std_logic := '0';
signal t1_q1_sync_rcv         : std_logic := '0';
signal t1_q2_sync_rcv         : std_logic := '0';
signal t2_q1_gate_rcv         : std_logic := '0';
signal t2_q2_gate_rcv         : std_logic := '0';
signal t2_q1_sync_rcv         : std_logic := '0';
signal t2_q2_sync_rcv         : std_logic := '0';
signal t3_q1_gate_rcv         : std_logic := '0';
signal t3_q2_gate_rcv         : std_logic := '0';
signal t3_q1_sync_rcv         : std_logic := '0';
signal t3_q2_sync_rcv         : std_logic := '0';
signal t1_q1_gate_trig_ttl_rcv: std_logic := '0';
signal t1_q1_sync_pps_ttl_rcv : std_logic := '0';
signal t1_q1_ssmc_gate_ttl_rcv: std_logic := '0';
signal t1_q2_gate_trig_ttl_rcv: std_logic := '0';
signal t1_q2_sync_pps_ttl_rcv : std_logic := '0';
signal t1_q2_ssmc_gate_ttl_rcv: std_logic := '0';

signal t2_q1_gate_trig_ttl_rcv: std_logic := '0';
signal t2_q1_sync_pps_ttl_rcv : std_logic := '0';
signal t2_q1_ssmc_gate_ttl_rcv: std_logic := '0';
signal t2_q2_gate_trig_ttl_rcv: std_logic := '0';
signal t2_q2_sync_pps_ttl_rcv : std_logic := '0';
signal t2_q2_ssmc_gate_ttl_rcv: std_logic := '0';

signal t3_q1_gate_trig_ttl_rcv: std_logic := '0';
signal t3_q1_sync_pps_ttl_rcv : std_logic := '0';
signal t3_q1_ssmc_gate_ttl_rcv: std_logic := '0';
signal t3_q2_gate_trig_ttl_rcv: std_logic := '0';
signal t3_q2_sync_pps_ttl_rcv : std_logic := '0';
signal t3_q2_ssmc_gate_ttl_rcv: std_logic := '0';
         
signal t4_ssmc_gate_ttl_rcv: std_logic_vector(1 downto 0) := "00";         
signal t2_int_dly_gate_rcv : std_logic_vector(1 downto 0) := "00";
signal t2_int_dly_sync_rcv : std_logic_vector(1 downto 0) := "00";
signal t2_int_dly_ttl_gate_rcv: std_logic_vector(1 downto 0) := "00";
signal t2_int_dly_ttl_sync_rcv: std_logic_vector(1 downto 0) := "00"; 
signal t2_int_dly_ttl_ssmc_rcv: std_logic_vector(1 downto 0) := "00";       
signal t4_mux_gate         : std_logic_vector(1 downto 0) := "00";         
signal t4_mux_sync         : std_logic_vector(1 downto 0) := "00";          
signal t4_mux_pps          : std_logic_vector(1 downto 0) := "00";          
signal t3_re_gate          : std_logic_vector(1 downto 0) := "00";     
signal t3_fe_gate          : std_logic_vector(1 downto 0) := "00";    
signal t1_gate_reg_gen     : std_logic := '0'; 
signal t1_sync_reg_gen     : std_logic := '0'; 
signal t1_pps_reg_gen      : std_logic := '0'; 
signal t2_gate_out         : std_logic_vector(1 downto 0) := "00";    
signal t2_sync_out         : std_logic_vector(1 downto 0) := "00";     
signal t3_gate_out         : std_logic := '0'; 
signal t3_sync_out         : std_logic := '0'; 
signal pls_strch_cntr      : std_logic_vector(15 downto 0) := (others => '0');
signal led_lite            : std_logic := '0';
signal frst                : std_logic := '0'; 
signal gate_en_vtc         : std_logic := '0';
signal sync_en_vtc         : std_logic := '0';
signal ssmc_en_vtc         : std_logic := '0';
signal gate_dly_ld_ctl_re  : std_logic := '0';
signal t1_gate_dly_ld_ctl  : std_logic := '0';
signal gate_dly_ld_ctl     : std_logic := '0';
signal hs_gate_dly_ld_ctl  : std_logic := '0';
signal sync_dly_ld_ctl_re  : std_logic := '0';
signal t1_sync_dly_ld_ctl  : std_logic := '0';
signal sync_dly_ld_ctl     : std_logic := '0';
signal hs_sync_dly_ld_ctl  : std_logic := '0';
signal ssmc_dly_ld_ctl_re  : std_logic := '0';
signal t1_ssmc_dly_ld_ctl  : std_logic := '0';
signal ssmc_dly_ld_ctl     : std_logic := '0';
signal hs_ssmc_dly_ld_ctl  : std_logic := '0';
signal hs_s_axi_csr_aresetn: std_logic := '0';
signal sample_clk_n        : std_logic := '0';
signal q1_iddr_sync_pps_ttl : std_logic := '0';
signal q2_iddr_sync_pps_ttl : std_logic := '0';
signal q1_iddr_ssmc_gate_ttl: std_logic := '0';
signal q2_iddr_ssmc_gate_ttl: std_logic := '0';
signal q1_iddr_gate_trig_ttl: std_logic := '0';
signal q2_iddr_gate_trig_ttl: std_logic := '0';
signal t4_mux_gate_or : std_logic := '0';
signal t4_mux_sync_or : std_logic := '0';
signal t4_mux_pps_or  : std_logic := '0';
signal t1_s_axi_csr_aresetn: std_logic := '0';

-------------------------------------------------------------------------------

begin

--------------------------------------------------------------------------------
-- Control/Status Registers
--------------------------------------------------------------------------------

-- Control registers operate in Sample clock Domain
csr_inst: px_syncbus_intrfc2_csr
generic map(
   initial_gate_tap_delay         => initial_gate_tap_delay,     
   initial_sync_tap_delay         => initial_sync_tap_delay,     
   initial_ttl_gate_tap_delay     => initial_ttl_gate_tap_delay, 
   initial_ttl_sync_tap_delay     => initial_ttl_sync_tap_delay, 
   initial_ssmc_gate_tap_delay    => initial_ssmc_gate_tap_delay,
   initial_gate_int_delay         => initial_gate_int_delay,     
   initial_sync_int_delay         => initial_sync_int_delay,     
   initial_ttl_gate_int_delay     => initial_ttl_gate_int_delay, 
   initial_ttl_sync_int_delay     => initial_ttl_sync_int_delay, 
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
    ttlgate_tap_delay       => ttlgate_tap_delay,
    ttlsync_tap_delay       => ttlsync_tap_delay,
    ttlssmc_tap_delay       => ttlssmc_tap_delay,
    gate_int_delay          => gate_int_delay,
    sync_int_delay          => sync_int_delay,
    gate_ttl_int_delay      => gate_ttl_int_delay,
    sync_ttl_int_delay      => sync_ttl_int_delay,
    ssmc_ttl_int_delay      => ssmc_ttl_int_delay,
    gate_rcv_src            => gate_rcv_src,
    sync_rcv_src            => sync_rcv_src,
    pps_rcv_src             => pps_rcv_src,
    gate_drv_src            => gate_drv_src,
    sync_drv_src            => sync_drv_src,
    gate_reg_gen            => gate_reg_gen,
    sync_reg_gen            => sync_reg_gen,
    pps_reg_gen             => pps_reg_gen,
    sbus_master_n           => sbus_master_n,
    clk_master_n            => clk_master_n,
    gate_dly_ld_ctl         => gate_dly_ld_ctl,
    sync_dly_ld_ctl         => sync_dly_ld_ctl,
    ssmc_dly_ld_ctl         => ssmc_dly_ld_ctl,
--------------------------------------------------------------------------------
-- Status Inputs (synchronous to axis_aclk)
--------------------------------------------------------------------------------       	           
    selected_gate           => t4_mux_gate_or,
    selected_sync           => t4_mux_sync_or,
    selected_pps            => t4_mux_pps_or,
    ttl_gate_pin            => t2_q1_gate_trig_ttl_rcv, --t2_gate_trig_ttl_rcv,
    ttl_sync_pin            => t2_q1_sync_pps_ttl_rcv,  --t2_sync_pps_ttl_rcv,
    ttl_ssmc_pin            => t2_q1_ssmc_gate_ttl_rcv, --t2_ssmc_gate_ttl_rcv,
    diff_gate_pin           => t2_q1_gate_rcv, --t2_gate_rcv,
    diff_sync_pin           => t2_q1_sync_rcv, --t2_sync_rcv,
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

gate_ibufds_inst : IBUFDS
generic map (
   DIFF_TERM    => differential_term,
   IBUF_LOW_PWR => ibuf_low_pwr,      -- Low power (TRUE) vs. performance (FALSE)
   IOSTANDARD   => "LVDS"  
)
port map (
   I  => gate_in_p,
   IB => gate_in_n,
   O  => ibuf_gate_rcv
);

sync_ibufds_inst : IBUFDS
generic map (
   DIFF_TERM    => differential_term,
   IBUF_LOW_PWR => ibuf_low_pwr,      -- Low power (TRUE) vs. performance (FALSE)
   IOSTANDARD   => "LVDS"  
)
port map (
   I  => sync_pps_in_p,
   IB => sync_pps_in_n,
   O  => ibuf_sync_rcv
);


gen_ttl_ibufs: if (is_single_ended_sig_master = true) generate

ttlgate_ibuf: ibuf
port map (
    I => gate_trig_ttl_in,
    O => gate_trig_ttl_in_ibuf
 );   
 
ttlsync_ibuf: ibuf
port map  (
     I => sync_pps_ttl_in,
     O => sync_pps_ttl_in_ibuf
  );
    
gen_ssmc_ibuf: if (has_ssmc_gate_input = true) generate

    ttlssmc_ibuf: ibuf
    port map  (
         I => ssmc_gate_ttl_in,
         O => ssmc_gate_ttl_in_ibuf
      );

end generate gen_ssmc_ibuf;

gen_ssmc_noibuf: if (has_ssmc_gate_input = false) generate

   ssmc_gate_ttl_in_ibuf <= '0';

end generate gen_ssmc_noibuf;
  
end generate gen_ttl_ibufs;

gen_ttl_no_ibufs: if (is_single_ended_sig_master = false) generate

gate_trig_ttl_in_ibuf <= gate_trig_ttl_in;
sync_pps_ttl_in_ibuf  <= sync_pps_ttl_in;

gen_ssmc_x: if (has_ssmc_gate_input = true) generate
    ssmc_gate_ttl_in_ibuf <= ssmc_gate_ttl_in;
end generate gen_ssmc_x;

gen_ssmc_none: if (has_ssmc_gate_input = false) generate   
   ssmc_gate_ttl_in_ibuf <= '0';
end generate gen_ssmc_none;

end generate gen_ttl_no_ibufs;

--------------------------------------------------------------------------------

rst_HARD_SYNC_inst : HARD_SYNC
   generic map (
      INIT => '0',            -- Initial values, '0', '1'
      IS_CLK_INVERTED => '0', -- Programmable inversion on CLK input
      LATENCY => 2            -- 2-3
   )
   port map (
      DOUT => hs_s_axi_csr_aresetn, -- 1-bit output: Data
      CLK => sample_clk,   -- 1-bit input: Clock
      DIN => t1_s_axi_csr_aresetn    -- 1-bit input: Data
   );
   
hs_gate_dly_ld_ctl <=  gate_dly_ld_ctl;  
      
hs_sync_dly_ld_ctl <= sync_dly_ld_ctl;
  
hs_ssmc_dly_ld_ctl <= ssmc_dly_ld_ctl;
      
process(sample_clk)
begin
   if rising_edge(sample_clk) then
      if (hs_s_axi_csr_aresetn = '0') then 
         gate_dly_ld_ctl_re <= '0';
         t1_gate_dly_ld_ctl <= '0';
      else
         gate_dly_ld_ctl_re <= (not t1_gate_dly_ld_ctl) and hs_gate_dly_ld_ctl;
         t1_gate_dly_ld_ctl <= hs_gate_dly_ld_ctl;
      end if;   
      if (hs_s_axi_csr_aresetn = '0') or (gate_dly_ld_ctl_re = '1') then
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

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      if (hs_s_axi_csr_aresetn = '0') then 
         sync_dly_ld_ctl_re <= '0';
         t1_sync_dly_ld_ctl <= '0';
      else
         sync_dly_ld_ctl_re <= (not t1_sync_dly_ld_ctl) and hs_sync_dly_ld_ctl;
         t1_sync_dly_ld_ctl <= hs_sync_dly_ld_ctl;
      end if;   
      if (hs_s_axi_csr_aresetn = '0') or (sync_dly_ld_ctl_re = '1') then
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

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      if (hs_s_axi_csr_aresetn = '0') then 
         ssmc_dly_ld_ctl_re <= '0';
         t1_ssmc_dly_ld_ctl <= '0';
      else
         ssmc_dly_ld_ctl_re <= (not t1_ssmc_dly_ld_ctl) and hs_ssmc_dly_ld_ctl;
         t1_ssmc_dly_ld_ctl <= hs_ssmc_dly_ld_ctl;
      end if;   
      if (hs_s_axi_csr_aresetn = '0') or (ssmc_dly_ld_ctl_re = '1') then
         ssmc_ld_cntr <= "000000";
      elsif (ssmc_ld_cntr /= "111111") then       
         ssmc_ld_cntr <= ssmc_ld_cntr + 1;
      end if;   
      if ssmc_ld_cntr = "100000" then
        ssmc_dly_ld <= '1';
      else
        ssmc_dly_ld <= '0';
      end if;
      if ssmc_ld_cntr = "111111" then
        ssmc_en_vtc <= '1';
      else
        ssmc_en_vtc <= '0';
      end if;
   end if;
end process;

-------------------------------------------------------------------------------
-- Input Variable Delays for Front Panel Sync Bus
-------------------------------------------------------------------------------
-- These delays are tap delays prior to the I/O pin register. They create
-- delay in increments of 75psec.

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
      DATAOUT => idelay_gate_rcv,         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => sample_clk, --s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => gate_tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => gate_en_vtc,           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_gate_rcv,         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => gate_dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

sync_idelaye3_inst : IDELAYE3
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
      DATAOUT => idelay_sync_rcv,         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => sample_clk, --s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => sync_tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => sync_en_vtc,           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_sync_rcv,         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => sync_dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

------------
gen_ttl_idelays: if (is_single_ended_sig_master = true) generate
   
ttl_gate_idelaye3_inst : IDELAYE3
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
         DATAOUT => idelay_gate_trig_ttl,         -- 1-bit output: Delayed data output
         CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
         CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
         CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
         CLK => sample_clk, --s_axi_csr_aclk,                 -- 1-bit input: Clock input
         CNTVALUEIN => ttlgate_tap_delay,   -- 9-bit input: Counter value input
         DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
         EN_VTC => gate_en_vtc,           -- 1-bit input: Keep delay constant over VT
         IDATAIN => gate_trig_ttl_in_ibuf,         -- 1-bit input: Data input from the logic
         INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
         LOAD => gate_dly_ld,               -- 1-bit input: Load DELAY_VALUE input
         RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
      );   

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
         CLK => sample_clk, --s_axi_csr_aclk,                 -- 1-bit input: Clock input
         CNTVALUEIN => ttlsync_tap_delay,   -- 9-bit input: Counter value input
         DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
         EN_VTC => sync_en_vtc,           -- 1-bit input: Keep delay constant over VT
         IDATAIN => sync_pps_ttl_in_ibuf,         -- 1-bit input: Data input from the logic
         INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
         LOAD => sync_dly_ld,               -- 1-bit input: Load DELAY_VALUE input
         RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
      );

gen_ssmc_idelay: if (has_ssmc_gate_input = true) generate
ttl_ssmc_idelaye3_inst : IDELAYE3
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
         DATAOUT => idelay_ssmc_gate_ttl,         -- 1-bit output: Delayed data output
         CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
         CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
         CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
         CLK => sample_clk, --s_axi_csr_aclk,                 -- 1-bit input: Clock input
         CNTVALUEIN => ttlssmc_tap_delay,   -- 9-bit input: Counter value input
         DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
         EN_VTC => ssmc_en_vtc,           -- 1-bit input: Keep delay constant over VT
         IDATAIN => ssmc_gate_ttl_in_ibuf,         -- 1-bit input: Data input from the logic
         INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
         LOAD => ssmc_dly_ld,               -- 1-bit input: Load DELAY_VALUE input
         RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
      ); 
      
end generate gen_ssmc_idelay;      
      
end generate gen_ttl_idelays;

gen_ttl_noidelays: if (is_single_ended_sig_master = false) generate

idelay_gate_trig_ttl <= gate_trig_ttl_in_ibuf;
idelay_sync_pps_ttl  <= sync_pps_ttl_in_ibuf;
idelay_ssmc_gate_ttl <= ssmc_gate_ttl_in_ibuf;

end generate;

-------------------------------------------------------------------------------
-- Register the delayed signals with IO Flip-Flops
-------------------------------------------------------------------------------
sample_clk_n <= not sample_clk;


IDDR_gate_inst : IDDRE1 
generic map (
   DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
   IS_C_INVERTED => '0'   -- Optional inversion for C
   )
port map (
   Q1    => q1_iddr_gate_rcv,
   Q2    => q2_iddr_gate_rcv,
   C     => sample_clk,
   CB    => sample_clk_n,
   D     => idelay_gate_rcv,
   R     => '0'
);

IDDR_sync_inst : IDDRE1 
generic map (
   DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
   IS_C_INVERTED => '0'   -- Optional inversion for C
   )
port map (
   Q1    => q1_iddr_sync_rcv,
   Q2    => q2_iddr_sync_rcv,
   C     => sample_clk,
   CB    => sample_clk_n,
   D     => idelay_sync_rcv,
   R     => '0'
);

gen_ddr_se: if (is_single_ended_sig_master = true) generate

IDDR_gate_ttl_inst : IDDRE1 
generic map (
   DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
   IS_C_INVERTED => '0'   -- Optional inversion for C
   )
port map (
   Q1    => q1_iddr_gate_trig_ttl,
   Q2    => q2_iddr_gate_trig_ttl,
   C     => sample_clk,
   CB    => sample_clk_n,
   D     => idelay_gate_trig_ttl,
   R     => '0'
);

IDDR_sync_ttl_inst : IDDRE1 
generic map (
   DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
   IS_C_INVERTED => '0'   -- Optional inversion for C
   )
port map (
   Q1    => q1_iddr_sync_pps_ttl,
   Q2    => q2_iddr_sync_pps_ttl,
   C     => sample_clk,
   CB    => sample_clk_n,
   D     => idelay_sync_pps_ttl,
   R     => '0'
);
gen_ssmcddr: if (has_ssmc_gate_input = true) generate
IDDR_ssmc_inst : IDDRE1 
generic map (
   DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
   IS_C_INVERTED => '0'   -- Optional inversion for C
   )
port map (
   Q1    => q1_iddr_ssmc_gate_ttl,
   Q2    => q2_iddr_ssmc_gate_ttl,
   C     => sample_clk,
   CB    => sample_clk_n,
   D     => idelay_ssmc_gate_ttl,
   R     => '0'
);
end generate gen_ssmcddr;

end generate gen_ddr_se;

gen_noddr_se: if (is_single_ended_sig_master = false) generate

q1_iddr_gate_trig_ttl <= slv_gate_trig_se_in(0);
q2_iddr_gate_trig_ttl <= slv_gate_trig_se_in(1);
q1_iddr_sync_pps_ttl  <= slv_sync_pps_se_in(0);
q2_iddr_sync_pps_ttl  <= slv_sync_pps_se_in(1); 
q1_iddr_ssmc_gate_ttl <= slv_ssmc_gate_se_in(0);
q2_iddr_ssmc_gate_ttl <= slv_ssmc_gate_se_in(1);

end generate;

-- If single ended master then generate outputs to slave
gen_master_se_out: if (is_single_ended_sig_master = true) generate

mstr_gate_trig_se_out  <= t1_q2_gate_trig_ttl_rcv & t1_q1_gate_trig_ttl_rcv;
mstr_sync_pps_se_out   <= t1_q2_sync_pps_ttl_rcv  & t1_q1_sync_pps_ttl_rcv;
mstr_ssmc_gate_se_out  <= t1_q2_ssmc_gate_ttl_rcv & t1_q1_ssmc_gate_ttl_rcv;

end generate;

-- If single ended slave then zero outputs (not used)
gen_slave_se_out: if (is_single_ended_sig_master = false) generate

mstr_gate_trig_se_out  <= "00";
mstr_sync_pps_se_out   <= "00";
mstr_ssmc_gate_se_out  <= "00";

end generate;

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      t1_q1_gate_rcv            <= q1_iddr_gate_rcv;
      t1_q1_sync_rcv            <= q1_iddr_sync_rcv;
      t1_q1_gate_trig_ttl_rcv   <= q1_iddr_gate_trig_ttl;
      t1_q1_sync_pps_ttl_rcv    <= q1_iddr_sync_pps_ttl;
      t1_q1_ssmc_gate_ttl_rcv   <= q1_iddr_ssmc_gate_ttl;
      t1_q2_gate_rcv            <= q2_iddr_gate_rcv;
      t1_q2_sync_rcv            <= q2_iddr_sync_rcv;
      t1_q2_gate_trig_ttl_rcv   <= q2_iddr_gate_trig_ttl;
      t1_q2_sync_pps_ttl_rcv    <= q2_iddr_sync_pps_ttl;
      t1_q2_ssmc_gate_ttl_rcv   <= q2_iddr_ssmc_gate_ttl;
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
      t2_q1_gate_rcv  <= t1_q1_gate_rcv;
      t2_q2_gate_rcv  <= t1_q2_gate_rcv;
      t3_q1_gate_rcv  <= t2_q1_gate_rcv;
      t2_q1_sync_rcv  <= t1_q1_sync_rcv;
      t2_q2_sync_rcv  <= t1_q2_sync_rcv;
      t3_q1_sync_rcv  <= t2_q1_sync_rcv;
      t2_q1_gate_trig_ttl_rcv <= t1_q1_gate_trig_ttl_rcv;
      t2_q2_gate_trig_ttl_rcv <= t1_q2_gate_trig_ttl_rcv;
      t3_q1_gate_trig_ttl_rcv <= t2_q1_gate_trig_ttl_rcv;
      t2_q1_sync_pps_ttl_rcv  <= t1_q1_sync_pps_ttl_rcv;
      t2_q2_sync_pps_ttl_rcv  <= t1_q2_sync_pps_ttl_rcv;
      t3_q1_sync_pps_ttl_rcv  <= t2_q1_sync_pps_ttl_rcv;
      t2_q1_ssmc_gate_ttl_rcv <= t1_q1_ssmc_gate_ttl_rcv;
      t2_q2_ssmc_gate_ttl_rcv  <= t1_q2_ssmc_gate_ttl_rcv;
      t3_q1_ssmc_gate_ttl_rcv  <= t2_q1_ssmc_gate_ttl_rcv;
      case gate_int_delay is
         when "00" =>
            t2_int_dly_gate_rcv  <= t1_q2_gate_rcv & t1_q1_gate_rcv;
         when "01" =>
            t2_int_dly_gate_rcv  <= t2_q1_gate_rcv & t1_q2_gate_rcv;
         when "10" =>
            t2_int_dly_gate_rcv  <= t2_q2_gate_rcv & t2_q1_gate_rcv;
         when "11" =>        
            t2_int_dly_gate_rcv  <= t3_q1_gate_rcv & t2_q2_gate_rcv;
         when others =>
            t2_int_dly_gate_rcv  <= t3_q1_gate_rcv & t2_q2_gate_rcv;
      end case;  
      case sync_int_delay is
         when "00" =>
            t2_int_dly_sync_rcv <= t1_q2_sync_rcv & t1_q1_sync_rcv;
         when "01" =>
            t2_int_dly_sync_rcv <= t2_q1_sync_rcv & t1_q2_sync_rcv;
         when "10" =>
            t2_int_dly_sync_rcv <= t2_q2_sync_rcv & t2_q1_sync_rcv;
         when "11" =>
            t2_int_dly_sync_rcv <= t3_q1_sync_rcv & t2_q2_sync_rcv;
         when others =>
            t2_int_dly_sync_rcv <= t3_q1_sync_rcv & t2_q2_sync_rcv;
      end case;
      case gate_ttl_int_delay is
         when "00" =>
            t2_int_dly_ttl_gate_rcv  <= t1_q2_gate_trig_ttl_rcv & t1_q1_gate_trig_ttl_rcv;
         when "01" =>
            t2_int_dly_ttl_gate_rcv  <= t2_q1_gate_trig_ttl_rcv & t1_q2_gate_trig_ttl_rcv;
         when "10" =>
            t2_int_dly_ttl_gate_rcv  <= t2_q2_gate_trig_ttl_rcv & t2_q1_gate_trig_ttl_rcv;
         when "11" =>        
            t2_int_dly_ttl_gate_rcv  <= t3_q1_gate_trig_ttl_rcv & t2_q2_gate_trig_ttl_rcv;
         when others =>
            t2_int_dly_ttl_gate_rcv  <= t3_q1_gate_trig_ttl_rcv & t2_q2_gate_trig_ttl_rcv;
      end case;  
      case sync_ttl_int_delay is
         when "00" =>
            t2_int_dly_ttl_sync_rcv <= t1_q2_sync_pps_ttl_rcv & t1_q1_sync_pps_ttl_rcv;
         when "01" =>
            t2_int_dly_ttl_sync_rcv <= t2_q1_sync_pps_ttl_rcv & t1_q2_sync_pps_ttl_rcv;
         when "10" =>
            t2_int_dly_ttl_sync_rcv <= t2_q2_sync_pps_ttl_rcv & t2_q1_sync_pps_ttl_rcv;
         when "11" =>
            t2_int_dly_ttl_sync_rcv <= t3_q1_sync_pps_ttl_rcv & t2_q2_sync_pps_ttl_rcv;
         when others =>
            t2_int_dly_ttl_sync_rcv <= t3_q1_sync_pps_ttl_rcv & t2_q2_sync_pps_ttl_rcv;
      end case;
      case ssmc_ttl_int_delay is
         when "00" =>
            t2_int_dly_ttl_ssmc_rcv <= t1_q2_ssmc_gate_ttl_rcv & t1_q1_ssmc_gate_ttl_rcv;
         when "01" =>
            t2_int_dly_ttl_ssmc_rcv <= t2_q1_ssmc_gate_ttl_rcv & t1_q2_ssmc_gate_ttl_rcv;
         when "10" =>
            t2_int_dly_ttl_ssmc_rcv <= t2_q2_ssmc_gate_ttl_rcv & t2_q1_ssmc_gate_ttl_rcv;
         when "11" =>
            t2_int_dly_ttl_ssmc_rcv <= t3_q1_ssmc_gate_ttl_rcv & t2_q2_ssmc_gate_ttl_rcv;
         when others =>
            t2_int_dly_ttl_ssmc_rcv <= t3_q1_ssmc_gate_ttl_rcv & t2_q2_ssmc_gate_ttl_rcv;
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
-- 000 None (off)
-- 001 Gate Register Bit
-- 010 Front Panel LVTTL Gate/Trig input (Active high)
-- 011 Front Panel LVTTL Gate/Trig input (Active low)
-- 100 Rising Edge of Gate
-- 101 Falling Edge of Gate
-- 110 Front Panel Sync Bus Differential Gate/Trig (Active high)
-- 111 Front Panel Sync Bus Differential Gate/Trig (Active low)

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      case gate_rcv_src is
         -- Gate is parked off.
         when "000" =>
            t3_mux_gate <= "00";
         -- Gate Register Bit
         -- (Always active high.)
         when "001" =>
            t3_mux_gate  <= t1_gate_reg_gen & t1_gate_reg_gen;
         -- Front Panel LVTTL Gate/Trig input
         when "010" => -- Active high ttl gate
            t3_mux_gate  <= t2_int_dly_ttl_gate_rcv;
         when "011" => -- Active low ttl gate   
            t3_mux_gate  <= (not t2_int_dly_ttl_gate_rcv(1)) & (not t2_int_dly_ttl_gate_rcv(0));
         when "100" => -- Active high ssmc ttl gate  
            if (has_ssmc_gate_input = true) then
                t3_mux_gate  <= t2_int_dly_ttl_ssmc_rcv;
            else
                t3_mux_gate  <= "00";
            end if;    
         when "101" => -- Active low ssmc ttl gate  
            if (has_ssmc_gate_input = true) then
                t3_mux_gate  <= (not t2_int_dly_ttl_ssmc_rcv(1)) & (not t2_int_dly_ttl_ssmc_rcv(0));
            else
                t3_mux_gate  <= "00";
            end if;    
         -- Front Panel Sync Bus Differential Sync
         when "110" =>
            t3_mux_gate  <= t2_int_dly_gate_rcv;
         -- Front Panel Sync Bus Differential Gate/Trig 
         when "111" =>
            t3_mux_gate  <= (not t2_int_dly_gate_rcv(1)) & (not t2_int_dly_gate_rcv(0));            
         when others =>
            t3_mux_gate  <= (not t2_int_dly_gate_rcv(1)) & (not t2_int_dly_gate_rcv(0)); 
      end case;
      t4_mux_gate_or <= t3_mux_gate(1) or t3_mux_gate(0);
      t4_mux_sync_or <= t3_mux_sync(1) or t3_mux_sync(0);
      t4_mux_pps_or  <= t3_mux_pps(1) or t3_mux_pps(0);
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
-- 110 Front Panel Sync Bus Differential Sync (Active high)
-- 111 Front Panel Sync Bus Differential Sync (Active low)

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      case sync_rcv_src is
         -- Gate is parked off.
         when "000" =>
            t3_mux_sync  <= "00";
         -- Gate Register Bit
         -- (Always active high.)
         when "001" =>
            t3_mux_sync  <= t1_sync_reg_gen & t1_sync_reg_gen;
         -- Front Panel LVTTL Sync input
         when "010" => -- Active high ttl sync
            t3_mux_sync  <= t2_int_dly_ttl_sync_rcv;
         when "011" => -- Active low ttl sync   
            t3_mux_sync  <= (not t2_int_dly_ttl_sync_rcv(1)) & (not t2_int_dly_ttl_sync_rcv(0));
         when "100" => -- rising edge of gate  
            t3_mux_sync  <= t3_re_gate;
         when "101" => -- falling edge of gate
            t3_mux_sync  <= t3_fe_gate;
         -- Front Panel Sync Bus Differential Gate/Trig 
         when "110" =>
            t3_mux_sync  <= t2_int_dly_sync_rcv;
         -- Front Panel Sync Bus Differential Gate/Trig 
         when "111" =>
            t3_mux_sync  <= (not t2_int_dly_sync_rcv(1)) & (not t2_int_dly_sync_rcv(0));            
         when others =>
            t3_mux_sync  <= (not t2_int_dly_sync_rcv(1)) & (not t2_int_dly_sync_rcv(0));    
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
-- 0110 Front Panel Sync Bus Differential Sync (Active high)
-- 0111 Front Panel Sync Bus Differential Sync (Active low)
-- 1000 Front Panel LVTTL Gate/Trig input (Active high)
-- 1001 Front Panel LVTTL Gate/Trig input (Active low) 
-- 1010 Front Panel LVTTL SSMC Gate/Trig input (Active high)
-- 1011 Front Panel LVTTL SSMC Gate/Trig input (Active low) 

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      case pps_rcv_src is
         -- PPS is parked off.
         when "0000" =>
            t3_mux_pps  <= "00";
         -- PPS Register Bit
         -- (Always active high.)
         when "0001" =>
            t3_mux_pps  <=  t1_pps_reg_gen & t1_pps_reg_gen;
         -- Front Panel LVTTL Sync input
         when "0010" => -- Active high ttl sync
            t3_mux_pps  <= t2_int_dly_ttl_sync_rcv;
         when "0011" => -- Active low ttl sync   
            t3_mux_pps  <= (not t2_int_dly_ttl_sync_rcv(1)) & (not t2_int_dly_ttl_sync_rcv(0));
         when "0100" => -- rising edge of gate  
            t3_mux_pps  <= t3_re_gate;
         when "0101" => -- falling edge of gate
            t3_mux_pps  <= t3_fe_gate;
         -- Front Panel Sync Bus Differential Gate/Trig 
         when "0110" =>
            t3_mux_pps  <= t2_int_dly_sync_rcv;
         -- Front Panel Sync Bus Differential Gate/Trig 
         when "0111" =>
            t3_mux_pps  <= (not t2_int_dly_sync_rcv(1)) & (not t2_int_dly_sync_rcv(0));    
         when "1000" => -- Active high ttl gate
            t3_mux_pps  <= t2_int_dly_ttl_gate_rcv;
         when "1001" => -- Active low ttl gate   
            t3_mux_pps  <= (not t2_int_dly_ttl_gate_rcv(1)) & (not t2_int_dly_ttl_gate_rcv(0));
         when "1010" => -- Active high ssmc ttl gate  
            t3_mux_pps  <= t2_int_dly_ttl_ssmc_rcv;
         when "1011" => -- Active low ssmc ttl gate  
            if (has_ssmc_gate_input = true) then
                t3_mux_pps  <= (not t2_int_dly_ttl_ssmc_rcv(1)) & (not t2_int_dly_ttl_ssmc_rcv(0));
            else
                t3_mux_pps  <= "00";
            end if;    
         when "1100" => -- User PPS input
            if (has_user_pps_input = true) then
                t3_mux_pps  <=  user_pps_in;
            else
                t3_mux_pps  <= "00";
            end if;                
         when others =>
            t3_mux_pps  <= "00"; 
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
      gate_re_event <= (t3_mux_gate(1) and (not t3_mux_gate(0))) or (t3_mux_gate(0) and (not t4_mux_gate(1)));
      gate_fe_event <= (t3_mux_gate(0) and (not t3_mux_gate(1))) or (t4_mux_gate(1) and (not t3_mux_gate(0)));
      sync_re_event <= (t3_mux_sync(1) and (not t3_mux_sync(0))) or (t3_mux_sync(0) and (not t4_mux_sync(1)));
      sync_fe_event <= (t3_mux_sync(0) and (not t3_mux_sync(1))) or (t4_mux_sync(1) and (not t3_mux_sync(0)));
      pps_re_event  <= (t3_mux_pps(1) and (not t3_mux_pps(0))) or (t3_mux_pps(0) and (not t4_mux_pps(1)));
      pps_fe_event  <= (t3_mux_pps(0) and (not t3_mux_pps(1))) or (t4_mux_pps(1) and (not t3_mux_pps(0)));     
   end if;
end process;

t3_re_gate(0)   <= t3_mux_gate(0) and not t4_mux_gate(1);
t3_re_gate(1)   <= t3_mux_gate(1) and not t3_mux_gate(0);
t3_fe_gate(0)   <= t4_mux_gate(1) and not t3_mux_gate(0);
t3_fe_gate(1)   <= t3_mux_gate(0) and not t3_mux_gate(1);
-----------------------------------------------------------------------------
-- Timing Events (AXI4-Stream Slave) no back pressure
-----------------------------------------------------------------------------
    -- tdata[1:0]       = Gate
    -- tdata[3:2]       = Sync 
    -- tdata[5:4]       = PPS   

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      m_axis_timecntl_tdata(1 downto 0) <= t3_mux_gate;
      m_axis_timecntl_tdata(3 downto 2) <= t3_mux_sync;
      m_axis_timecntl_tdata(5 downto 4) <= t3_mux_pps;
   end if;
end process;

m_axis_timecntl_tvalid <= '1';
m_axis_timecntl_tdata(7 downto 6) <= (others => '0');
--=============================================================================
-- Sync Bus Drive Signals
--=============================================================================

-------------------------------------------------------------------------------
-- Front Panel Sync Bus Gate/Trig Output Selection
-------------------------------------------------------------------------------

-- Potential Sources:
-- Gate Register Bit
-- Front Panel LVTTL Gate/Trig input
-- Front Panel SSMC

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      case gate_drv_src is
         when "000" => -- Register Active High
            t2_gate_out <= t1_gate_reg_gen & t1_gate_reg_gen;
         when "001" => -- Register Inverted (Active Low Output)
            t2_gate_out <= (not t1_gate_reg_gen) & (not t1_gate_reg_gen);   
         when "010" => -- Front Panel LVTTL Gate/Trig input (As Received)
            t2_gate_out <= t1_q2_gate_trig_ttl_rcv & t1_q1_gate_trig_ttl_rcv;
         when "011" => -- Front Panel LVTTL Gate/Trig input (Inverted)
            t2_gate_out <= (not t1_q2_gate_trig_ttl_rcv) & (t1_q1_gate_trig_ttl_rcv);
         when "100" => -- Front Panel LVTTL Gate/Trig SSMC input (As Received)
            t2_gate_out <= t1_q2_ssmc_gate_ttl_rcv & t1_q1_ssmc_gate_ttl_rcv;
         when "101" => -- Front Panel LVTTL Gate/Trig SSMC input (Inverted)
            t2_gate_out <= (not t1_q2_ssmc_gate_ttl_rcv) & (not t1_q1_ssmc_gate_ttl_rcv);
         when "110" => -- User Signal Input  
            t2_gate_out <= user_gate_drive_in(1 downto 0);
         when others =>
            t2_gate_out <= user_gate_drive_in(1 downto 0);
      end case;
   end if;
end process;

-------------------------------------------------------------------------------
-- Front Panel Sync Bus Sync Output Selection
-------------------------------------------------------------------------------

-- Potential Sources:
-- Sync A Register Bit
-- Front Panel LVTTL Sync/PPS input
-- Rising and falling edge of selected gate

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      case sync_drv_src is
         when "000" => -- Register Active High
            t2_sync_out <= t1_sync_reg_gen & t1_sync_reg_gen;
         when "001" => -- Register Inverted (Active Low Output)
            t2_sync_out <= (not t1_sync_reg_gen) & (not t1_sync_reg_gen);   
         when "010" => -- Front Panel LVTTL Sync input (As Received)
            t2_sync_out <= t1_q2_sync_pps_ttl_rcv & t1_q1_sync_pps_ttl_rcv;
         when "011" => -- Front Panel LVTTL Sync input (Inverted)
            t2_sync_out <= (not t1_q2_sync_pps_ttl_rcv) & (not t1_q1_sync_pps_ttl_rcv);
         when "100" => -- Front Panel LVTTL Gate/Trig SSMC input (As Received)
            t2_sync_out <= t3_re_gate;
         when "101" => -- Front Panel LVTTL Gate/Trig SSMC input (Inverted)
            t2_sync_out <= t3_fe_gate;
         when "110" => -- User Signal Input  
            t2_sync_out <= user_sync_drive_in(1 downto 0);
         when others =>
            t2_sync_out <= user_sync_drive_in(1 downto 0);
      end case;
   end if;
end process;

-------------------------------------------------------------------------------
-- Output Pin DDR Flip-Flops
-------------------------------------------------------------------------------


g_out_ODDRE1_inst : ODDRE1
   generic map (
      IS_C_INVERTED => '0',  -- Optional inversion for C
      IS_D1_INVERTED => '0', -- Optional inversion for D1
      IS_D2_INVERTED => '0', -- Optional inversion for D2
      SRVAL => '0'           -- Initializes the ODDRE1 Flip-Flops to the specified value ('0', '1')
   )
   port map (
      Q => t3_gate_out,   -- 1-bit output: Data output to IOB
      C => sample_clk,   -- 1-bit input: High-speed clock input
      D1 => t2_gate_out(0), -- 1-bit input: Parallel data input 1
      D2 => t2_gate_out(1), -- 1-bit input: Parallel data input 2
      SR => '0'  -- 1-bit input: Active High Async Reset
   );

s_out_ODDRE1_inst : ODDRE1
   generic map (
      IS_C_INVERTED => '0',  -- Optional inversion for C
      IS_D1_INVERTED => '0', -- Optional inversion for D1
      IS_D2_INVERTED => '0', -- Optional inversion for D2
      SRVAL => '0'           -- Initializes the ODDRE1 Flip-Flops to the specified value ('0', '1')
   )
   port map (
      Q => t3_sync_out,   -- 1-bit output: Data output to IOB
      C => sample_clk,   -- 1-bit input: High-speed clock input
      D1 => t2_sync_out(0), -- 1-bit input: Parallel data input 1
      D2 => t2_sync_out(1), -- 1-bit input: Parallel data input 2
      SR => '0'  -- 1-bit input: Active High Async Reset
   );

--=============================================================================
-- Output Differential LVDS Buffers
--=============================================================================

-------------------------------------------------------------------------------
-- Front Panel Output Buffers
-------------------------------------------------------------------------------

gatea_OBUFDS_inst : OBUFDS
generic map (
   IOSTANDARD => "LVDS"
)
port map (
   I  => t3_gate_out,
   O  => gate_out_p,
   OB => gate_out_n
);

synca_OBUFDS_inst : OBUFDS
generic map (
   IOSTANDARD => "LVDS"
)
port map (
   I  => t3_sync_out,
   O  => sync_pps_out_p,
   OB => sync_pps_out_n
);

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
                led_lite  <= t3_mux_gate(1) or t3_mux_gate(0);
            when "010" =>    
                led_lite  <= t3_mux_sync(1) or t3_mux_sync(0);
            when "011" =>    
                led_lite  <= t3_mux_pps(1) or t3_mux_pps(0);
            when "100" =>    
                led_lite  <= t2_gate_out(1) or t2_gate_out(0);
            when "101" =>    
                led_lite  <= t2_sync_out(1) or t2_sync_out(0);
            when "110" =>    
                led_lite  <= user_pps_in(1) or user_pps_in(0);
            when "111" =>   
                led_lite  <= user_pps_in(1) or user_pps_in(0);
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

end Behavioral;