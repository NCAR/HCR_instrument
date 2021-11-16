----------------------------------------------------------------------------------
-- Pentek TimeStamp Generator
----------------------------------------------------------------------------------
-- px_timestamp_gen_sgate.vhd
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
-- Output tvalid is delayed 7 clock cycles from input tvalid

-- Register Map
-- 0x00 Mode Control                    R/W   
-- 0x04 Sample Counter Init Value       R/W   
-- 0x08 PPS Counter Init Value          R/W
-- 0x0C Sample Counter Incr Value       R/W
-- 0x10 Sample Counter Value Read-back  RO 
-- 0x14 PPS Counter Value Read-back     RO 
-- 0x18 Interrupt Enables               R/W
-- 0x1C Interrupt Status Register       RO 
-- 0x20 Interrupt Flag Register         R/Clr

-- Control
--Bit [0] - Counter Reset
--Bit [1] - Arm Load 
--Bit [2] - Arm Clear 
--Bit [3] - PPS Mode
--Bit [4] - PPS Active Edge
--Bit [5] - PPS Count Enable
--Bit [6] - Counter Load En
--Bit [7] - Latch Readback
--Bit [10:8] - Counter Load Mode
    -- 000 Always on Arm
    -- 001 AUX pulse rising edge
    -- 010 PPS rising edge
    -- 011 PPS falling edge
    -- 100 SYNC rising edge
    -- 101 SYNC falling edge
    -- 110 Gate rising_edge
    -- 111 Gate falling edge 
--Bit [11] - Stay Armed

-- Interrupts
-- Bit [0] PPS rising edge
-- Bit [1] PPS falling edge
-- Bit [2] Sample Counter wrapped
-- Bit [3] PPS counter wrapped
-- Bit [4] Timestamp loaded

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
use ieee.numeric_std.ALL;

Library UNISIM;
use UNISIM.vcomponents.all;

-------------------------------------------------------------------------------
-- Main Entity
-------------------------------------------------------------------------------

entity px_timestamp_gen_sgate is

port (
   ----------------------------------------------------------------------------
   -- Control/Status Registers (AXI4-LITE)
   ----------------------------------------------------------------------------
   -- associated with s_axi_csr_aclk
   s_axi_csr_aclk           : in  std_logic;
   s_axi_csr_aresetn        : in  std_logic;
   s_axi_csr_awaddr         : in  std_logic_vector(6 downto 0);
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
   s_axi_csr_araddr         : in  std_logic_vector(6 downto 0);
   s_axi_csr_arprot         : in  std_logic_vector(2 downto 0);
   s_axi_csr_arvalid        : in  std_logic;
   s_axi_csr_arready        : out std_logic;
   s_axi_csr_rdata          : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp          : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid         : out std_logic;
   s_axi_csr_rready         : in  std_logic;
   
   irq                      : out std_logic; -- Interrupt out
   -----------------------------------------------------------------------------
   -- Timing Events (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------
   -- tdata[0]      = Gate Positions
   -- tdata[1]      = Sync Positions   
   -- tdata[2]      = PPS Positions  
   s_axis_aclk              : in std_logic; -- Timestamp clock (usually data sample clock
   s_axis_aresetn           : in std_logic; -- reset   
   s_axis_ptctl_tdata       : in std_logic_vector(7 downto 0);
   s_axis_ptctl_tvalid      : in std_logic;
   -----------------------------------------------------------------------------
   -- Time Stamp Output (AXI4-Stream Master) no back pressure
   -----------------------------------------------------------------------------
   -- tuser[7:0]       = Gate Positions  
   -- tuser[15:8]      = Sync Positions      
   -- tuser[23:16]     = PPS Positions
   -- pts_tdata[63:0] = timestamp[63:0] 
   
   -- pps mode 1: 
   -- tdata[31:0] = sample count[31:0]
   -- tdata[63:0] = pps count[31:0]
   -- pps mode 0:
   -- tdata[63:0] = sample count[63:0] 
   m_axis_pts_tdata         : out std_logic_vector(63 downto 0);
   m_axis_pts_tuser         : out std_logic_vector(23 downto 0);
   m_axis_pts_tvalid        : out std_logic
   -----------------------------------------------------------------------------
);
end px_timestamp_gen_sgate;

architecture Behavioral of px_timestamp_gen_sgate is

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of s_axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_ptctl:m_axis_pts, ASSOCIATED_RESET s_axis_aresetn";

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- 48-bit DSP48 Accumulator
-- With carry out
-- Sel 00 = P+D
-- Sel 01 = C-A
-- Sel 10 = 0-A
component px_timestamp_gen_dsp48accl
  port (
    clk         : in  std_logic;
    sel         : in  std_logic_vector(0 downto 0);
--    a           : in  std_logic_vector(3 downto 0);
    c           : in  std_logic_vector(47 downto 0);
--    d           : in  std_logic_vector(15 downto 0);
    carrycascout: out std_logic;
    p           : out std_logic_vector(47 downto 0);
    cep         : in  std_logic;
    sclrp       : in  std_logic
  );
end component;

-- 16 bit DSP48 Accumulator
-- With carry in
component px_timestamp_gen_dsp48accu
  port (
    clk         : in std_logic;
    sel         : in std_logic_vector(0 downto 0);
    carrycascin : in std_logic;
    c           : in std_logic_vector(15 downto 0);
    p           : out std_logic_vector(15 downto 0);
    cep         : in std_logic;
    sclrp       : in std_logic
  );
end component;

-- 32-but DSP48 Counter
-- Load requires CE
-- latency = 1
component px_timestamp_gen_ppscntr
  port (
    clk : in std_logic;
    ce : in std_logic;
    sclr : in std_logic;
    load : in std_logic;
    l : in std_logic_vector(31 downto 0);
    q : out std_logic_vector(31 downto 0)
  );
end component;

-- AXI-LITE Clock Converter
component px_timestamp_gen_axiclkcnv
  port (
    s_axi_aclk : in std_logic;
    s_axi_aresetn : in std_logic;
    s_axi_awaddr : in std_logic_vector(4 downto 0);
    s_axi_awprot : in std_logic_vector(2 downto 0);
    s_axi_awvalid : in std_logic;
    s_axi_awready : out std_logic;
    s_axi_wdata : in std_logic_vector(31 downto 0);
    s_axi_wstrb : in std_logic_vector(3 downto 0);
    s_axi_wvalid : in std_logic;
    s_axi_wready : out std_logic;
    s_axi_bresp : out std_logic_vector(1 downto 0);
    s_axi_bvalid : out std_logic;
    s_axi_bready : in std_logic;
    s_axi_araddr : in std_logic_vector(4 downto 0);
    s_axi_arprot : in std_logic_vector(2 downto 0);
    s_axi_arvalid : in std_logic;
    s_axi_arready : out std_logic;
    s_axi_rdata : out std_logic_vector(31 downto 0);
    s_axi_rresp : out std_logic_vector(1 downto 0);
    s_axi_rvalid : out std_logic;
    s_axi_rready : in std_logic;
    m_axi_aclk : in std_logic;
    m_axi_aresetn : in std_logic;
    m_axi_awaddr : out std_logic_vector(4 downto 0);
    m_axi_awprot : out std_logic_vector(2 downto 0);
    m_axi_awvalid : out std_logic;
    m_axi_awready : in std_logic;
    m_axi_wdata : out std_logic_vector(31 downto 0);
    m_axi_wstrb : out std_logic_vector(3 downto 0);
    m_axi_wvalid : out std_logic;
    m_axi_wready : in std_logic;
    m_axi_bresp : in std_logic_vector(1 downto 0);
    m_axi_bvalid : in std_logic;
    m_axi_bready : out std_logic;
    m_axi_araddr : out std_logic_vector(4 downto 0);
    m_axi_arprot : out std_logic_vector(2 downto 0);
    m_axi_arvalid : out std_logic;
    m_axi_arready : in std_logic;
    m_axi_rdata : in std_logic_vector(31 downto 0);
    m_axi_rresp : in std_logic_vector(1 downto 0);
    m_axi_rvalid : in std_logic;
    m_axi_rready : out std_logic
  );
end component;

-- Control/Status Registers
component px_timestamp_gen_sgate_csr
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    s_axi_csr_aclk        : in  std_logic;
    s_axi_csr_aresetn     : in  std_logic;
    s_axi_csr_awaddr      : in  std_logic_vector(6 downto 0); -- only [5:0] used
    s_axi_csr_awprot      : in  std_logic_vector(2 downto 0);
    s_axi_csr_awvalid     : in  std_logic;
    s_axi_csr_awready     : out std_logic;
    s_axi_csr_wdata       : in  std_logic_vector(31 downto 0);
    s_axi_csr_wstrb       : in  std_logic_vector(3 downto 0);
    s_axi_csr_wvalid      : in  std_logic;
    s_axi_csr_wready      : out std_logic;
    s_axi_csr_bresp       : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid      : out std_logic;
    s_axi_csr_bready      : in  std_logic;
    s_axi_csr_araddr      : in  std_logic_vector(6 downto 0);  -- only [5:0] used
    s_axi_csr_arprot      : in  std_logic_vector(2 downto 0);
    s_axi_csr_arvalid     : in  std_logic;
    s_axi_csr_arready     : out std_logic;
    s_axi_csr_rdata       : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp       : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid      : out std_logic;
    s_axi_csr_rready      : in  std_logic;
    
    irq                   : out std_logic; -- interrupt
    --------------------------------------------------------------------------------
    axis_aclk             : in  std_logic; -- clock for controls and status
    --------------------------------------------------------------------------------
    -- Control Outputs (synchronous to axis_aclk)
    --------------------------------------------------------------------------------     
    pps_active_edge       : out std_logic;
    cntr_rst              : out std_logic;
    arm_load              : out std_logic;
    arm_clr               : out std_logic;
    stay_armed            : out std_logic;
    pps_mode              : out std_logic;
    pps_count_en          : out std_logic;
    count_load_mode       : out std_logic_vector(2 downto 0);
    count_load_en         : out std_logic;
    latch_readback        : out std_logic;
    sample_cntr_init_val  : out std_logic_vector(31 downto 0);
    pps_cntr_init_val     : out std_logic_vector(31 downto 0);
    sample_cntr_incr_val  : out std_logic_vector(31 downto 0);
--------------------------------------------------------------------------------
-- Status Inputs (synchronous to axis_aclk)
--------------------------------------------------------------------------------       	           
    sample_cnt            : in std_logic_vector(31 downto 0);
    pps_cnt               : in std_logic_vector(31 downto 0); 
 -------------------------------------------------------------------------------
-- Interrupt Sources (synchronous to axis_aclk)
--------------------------------------------------------------------------------
    pps_rising_edge_event : in std_logic;
    pps_falling_edge_event: in std_logic;
    sample_cntr_wrap_event: in std_logic;
    pps_cntr_wrap_event   : in std_logic;
    timestamp_load_event  : in std_logic;
    load_armed            : in std_logic
);
end component;

-- 1 bit
-- 16 deep
-- Distributed ram
component px_timestamp_gen_xclkfifo
  port (
    rst : in std_logic;
    wr_clk : in std_logic;
    rd_clk : in std_logic;
    din : in std_logic_vector(0 downto 0);
    wr_en : in std_logic;
    rd_en : in std_logic;
    dout : out std_logic_vector(0 downto 0);
    full : out std_logic;
    empty : out std_logic
  );
end component;

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

constant LOAD_ALWAYS_ON_ARM       : std_logic_vector(2 downto 0) := "000";
constant LOAD_ALWAYS_ON_ARM2      : std_logic_vector(2 downto 0) := "001";
constant LOAD_ON_PPS_RISING_EDGE  : std_logic_vector(2 downto 0) := "010";
constant LOAD_ON_PPS_FALLING_EDGE : std_logic_vector(2 downto 0) := "011";
constant LOAD_ON_SYNC_RISING_EDGE : std_logic_vector(2 downto 0) := "100";
constant LOAD_ON_SYNC_FALLING_EDGE: std_logic_vector(2 downto 0) := "101";
constant LOAD_ON_GATE_RISING_EDGE : std_logic_vector(2 downto 0) := "110";
constant LOAD_ON_GATE_FALLING_EDGE: std_logic_vector(2 downto 0) := "111";

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

type load_state_type is (
RESET_STATE,
WAIT_FOR_ARM,
ARMED_STATE
);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal load_state: load_state_type;
signal t1_s_axis_aresetn     : std_logic := '0';          
signal t1_s_axis_ptctl_tdata : std_logic_vector(2 downto 0);
signal t1_s_axis_ptctl_tvalid: std_logic := '0';          
signal t1_arm_load          : std_logic := '0';                                      
signal arm_re               : std_logic := '0';                              
signal cntr_rst             : std_logic := '0';                         
signal arm_load             : std_logic := '0';         
signal arm_clr              : std_logic := '0';         
signal pps_mode             : std_logic := '0';         
signal pps_active_edge      : std_logic := '0';     
signal pps_count_en         : std_logic := '0';      
signal count_load_mode      : std_logic_vector(2 downto 0) := (others => '0');   
signal count_load_en        : std_logic := '0';     
signal latch_readback       : std_logic := '0';     
signal sample_cntr_init_val : std_logic_vector(31 downto 0) := (others => '0');
signal pps_cntr_init_val    : std_logic_vector(31 downto 0) := (others => '0');
signal sample_cntr_incr_val : std_logic_vector(31 downto 0) := (others => '0');
signal readback_sample_cnt  : std_logic_vector(31 downto 0) := (others => '0'); 
signal readback_pps_cnt     : std_logic_vector(31 downto 0) := (others => '0'); 
signal t2_pps_re            : std_logic := '0'; 
signal t2_pps_fe            : std_logic := '0'; 
signal sample_cntr_wrap_event: std_logic := '0'; 
signal pps_cntr_wrap_event  : std_logic := '0'; 
signal t3_cntr_load         : std_logic := '0'; 
signal load_armed           : std_logic := '0';  
signal t2_sync_re           : std_logic := '0'; 
signal t2_sync_fe           : std_logic := '0'; 
signal t2_gate_re           : std_logic := '0'; 
signal t2_gate_fe           : std_logic := '0'; 
signal t2_s_axis_ptctl_tdata: std_logic_vector(2 downto 0) := (others => '0');  
signal t3_s_axis_ptctl_tdata: std_logic_vector(2 downto 0) := (others => '0');      
signal t4_s_axis_ptctl_tdata: std_logic_vector(2 downto 0) := (others => '0');     
signal t5_s_axis_ptctl_tdata: std_logic_vector(2 downto 0) := (others => '0');     
signal t6_s_axis_ptctl_tdata: std_logic_vector(2 downto 0) := (others => '0');     
signal t2_s_axis_ptctl_tvalid: std_logic := '0'; 
signal t3_s_axis_ptctl_tvalid: std_logic := '0'; 
signal t4_s_axis_ptctl_tvalid: std_logic := '0'; 
signal t5_s_axis_ptctl_tvalid: std_logic := '0'; 
signal t3_pps_incr           : std_logic := '0';
signal t3_pps_cntr_ce        : std_logic := '0';
signal dsp48accl_cin         : std_logic_vector(47 downto 0) := (others => '0'); 
signal dsp48accu_cin         : std_logic_vector(15 downto 0) := (others => '0'); 
signal t3_dsp48accl_incr_val : std_logic_vector(15 downto 0) := (others => '0'); 
signal t4_pps_cntr           : std_logic_vector(31 downto 0) := (others => '0');
signal t5_pps_cntr           : std_logic_vector(31 downto 0) := (others => '0');
signal t6_pps_cntr           : std_logic_vector(31 downto 0) := (others => '0');
signal t7_pps_cntr_msb       : std_logic := '0';
signal t7_smpl_cntr_msb      : std_logic := '0';
signal t4_sample_cntr_sclr   : std_logic := '0';
signal t5_sample_cntr_sclr   : std_logic := '0';
signal dsp48accl_carrycascout: std_logic := '0';
signal t5_sample_cntr        : std_logic_vector(47 downto 0):= (others => '0');
signal t6_sample_cntr        : std_logic_vector(63 downto 0):= (others => '0');
signal t6_s_axis_ptctl_tvalid: std_logic := '0';
signal csr_irq               : std_logic := '0';   
signal t2_pps                : std_logic := '0';
signal t2_aux                : std_logic := '0';
signal t2_sync               : std_logic := '0';
signal t2_gate               : std_logic := '0';
signal pps                   : std_logic := '0';
signal sync                  : std_logic := '0';
signal gate                  : std_logic := '0';
signal stay_armed            : std_logic := '0';
signal accl_sel              : std_logic_vector(1 downto 0):= (others => '0');
signal t2_pps_offset         : std_logic;
signal t2_sync_offset        : std_logic;
signal t2_gate_offset        : std_logic;
signal acclsel               : std_logic := '0';
signal cma                   : std_logic_vector(47 downto 0):= (others => '0');
signal ma                    : std_logic_vector(47 downto 0):= (others => '0');
signal t1_cma                : std_logic_vector(47 downto 0):= (others => '0');
signal t1_ma                 : std_logic_vector(47 downto 0):= (others => '0');
signal t1_s_axi_csr_aresetn  : std_logic := '0';
--------------------------------------------------------------------------------

begin

--------------------------------------------------------------------------------
-- Control/Status Registers
--------------------------------------------------------------------------------

-- 0x00 Mode Control
-- 0x04 Sample Counter Init Value
-- 0x08 PPS Counter Init Value
-- 0x0C Interrupt Enables
-- 0x10 Sample Counter Value Read-back
-- 0x14 PPS Counter Value Read-back
-- 0x18 Interrupt Status Register
-- 0x1C Interrupt Flag Register 

-- Control registers operate in Sample clock Domain
csr_inst: px_timestamp_gen_sgate_csr
port map (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
-- Address Range - BASE + 0x00 -> BASE + 0x3F
--------------------------------------------------------------------------------
    axis_aclk               => s_axis_aclk,   
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
-- Control Outputs
--------------------------------------------------------------------------------    
    cntr_rst                => cntr_rst,
    arm_load                => arm_load,   
    arm_clr                 => arm_clr,    
    stay_armed              => stay_armed,      
    pps_mode                => pps_mode,
    pps_active_edge         => pps_active_edge,              
    pps_count_en            => pps_count_en,         
    count_load_mode         => count_load_mode,      
    count_load_en           => count_load_en,        
    latch_readback          => latch_readback,       
    sample_cntr_init_val    => sample_cntr_init_val, 
    pps_cntr_init_val       => pps_cntr_init_val,
    sample_cntr_incr_val    => sample_cntr_incr_val,    
--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------       	           
    sample_cnt              => readback_sample_cnt,
    pps_cnt                 => readback_pps_cnt,   
 -------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------
    pps_rising_edge_event   => t2_pps_re, 
    pps_falling_edge_event  => t2_pps_fe,
    sample_cntr_wrap_event  => sample_cntr_wrap_event,
    pps_cntr_wrap_event     => pps_cntr_wrap_event,   
    timestamp_load_event    => t3_cntr_load,
    load_armed              => load_armed 
);

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
        t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
        irq <= csr_irq;
   end if;
end process;

--------------------------------------------------------------------------------

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
       t1_s_axis_aresetn           <= s_axis_aresetn;           
       t1_s_axis_ptctl_tdata       <= s_axis_ptctl_tdata(2 downto 0); 
       t1_s_axis_ptctl_tvalid      <= s_axis_ptctl_tvalid;
       
       t1_arm_load                 <= arm_load;
       arm_re                      <= arm_load and not t1_arm_load;
   end if;
end process;

--------------------------------------------------------------------------------
-- Counter Load Control
--------------------------------------------------------------------------------
-- Count Load Mode
    -- 000 Always on Arm
    -- 001 Always on Arm
    -- 010 PPS rising edge
    -- 011 PPS falling edge
    -- 100 SYNC rising edge
    -- 101 SYNC falling edge
    -- 110 Gate rising_edge
    -- 111 Gate falling edge 

process(s_axis_aclk)
begin
  if rising_edge(s_axis_aclk) then
    if t1_s_axis_aresetn = '0' then
       load_armed  <= '0';
       t3_cntr_load   <= '0';
       load_state  <= RESET_STATE;
    else
        case load_state is
            when RESET_STATE =>
               if t1_s_axis_aresetn = '0' then
                 load_armed  <= '0';
                 t3_cntr_load   <= '0';
                 load_state  <= RESET_STATE;
               else  
                 load_state  <= WAIT_FOR_ARM;
               end if;
            when WAIT_FOR_ARM =>
                if (arm_re = '1') and (arm_clr = '0') then
                   load_state  <= ARMED_STATE;                                                                                 
                   load_armed  <= '1';
                else
                   load_state  <= WAIT_FOR_ARM;
                end if;
                t3_cntr_load <= '0';
            when ARMED_STATE =>
                if arm_clr = '1' then -- clear ARM
                    load_state <= WAIT_FOR_ARM;
                    load_armed <= '0';
                else
                    -- Determine action based on load mode.
                    case count_load_mode is
                        when LOAD_ALWAYS_ON_ARM | LOAD_ALWAYS_ON_ARM2 =>
                            t3_cntr_load        <= '1';
                            load_state          <= WAIT_FOR_ARM;
                            load_armed          <= '0';
                        when LOAD_ON_PPS_RISING_EDGE =>
                            if (t2_pps_re = '1') and (count_load_en = '1') then
                                t3_cntr_load        <= '1';
--                                if ((t1_des_ctl = '0') and (pts_signal_width = 8) and (has_des_ctl = true)) then
--                                    t3_cntr_load_offset <= "00" & t2_pps_offset(2 downto 1);
--                                else                                    
--                                    t3_cntr_load_offset <= '0' & t2_pps_offset(2 downto 0);
--                                end if;    
                                load_state          <= WAIT_FOR_ARM;
                                if stay_armed = '0' then
                                    load_armed      <= '0';
                                end if;
                            else
                                load_state  <= ARMED_STATE;
                            end if;
                        when LOAD_ON_PPS_FALLING_EDGE =>
                            if (t2_pps_fe = '1') and (count_load_en = '1') then
                                t3_cntr_load        <= '1';
   
                                load_state          <= WAIT_FOR_ARM;
                                if stay_armed = '0' then
                                    load_armed      <= '0';
                                end if;
                            else
                                load_state  <= ARMED_STATE;
                            end if;                        
                        when LOAD_ON_SYNC_RISING_EDGE =>
                            if (t2_sync_re = '1') and (count_load_en = '1') then
                                t3_cntr_load        <= '1';
   
                                load_state          <= WAIT_FOR_ARM;
                                if stay_armed = '0' then
                                    load_armed      <= '0';
                                end if;
                            else
                                load_state  <= ARMED_STATE;
                            end if;
                        when LOAD_ON_SYNC_FALLING_EDGE =>
                            if (t2_sync_fe = '1') and (count_load_en = '1') then
                                t3_cntr_load   <= '1';
   
                                load_state          <= WAIT_FOR_ARM;
                                if stay_armed = '0' then
                                    load_armed      <= '0';
                                end if;
                            else
                                load_state  <= ARMED_STATE;
                            end if;                        
                        when LOAD_ON_GATE_RISING_EDGE =>
                            if (t2_gate_re = '1') and (count_load_en = '1') then
                                t3_cntr_load        <= '1';
   
                                load_state          <= WAIT_FOR_ARM;
                                if stay_armed = '0' then
                                    load_armed      <= '0';
                                end if;
                            else
                                load_state  <= ARMED_STATE;
                            end if;
                        when LOAD_ON_GATE_FALLING_EDGE =>
                            if (t2_gate_fe = '1') and (count_load_en = '1') then
                                t3_cntr_load   <= '1';
   
                                load_state          <= WAIT_FOR_ARM;
                                if stay_armed = '0' then
                                    load_armed      <= '0';
                                end if;
                            else
                                load_state  <= ARMED_STATE;
                            end if; 
                        when others =>
                            load_state <= RESET_STATE;
                    end case;    
                end if;
            when others =>
               load_state <= RESET_STATE;
         end case;
    end if;
  end if;  
end process;

--------------------------------------------------------------------------------
-- Compenstate for latencies
--------------------------------------------------------------------------------
-- tdata[n-1:0]       = Gate Positions
-- tdata[2n-1:n]      = Sync Positions   
-- tdata[3n-1:2n]     = PPS Positions  

process(t1_s_axis_ptctl_tdata)
begin
    gate <= t1_s_axis_ptctl_tdata(0);
    sync <= t1_s_axis_ptctl_tdata(1);   
    pps  <= t1_s_axis_ptctl_tdata(2);     
end process;

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then   
  
       t2_s_axis_ptctl_tdata    <= t1_s_axis_ptctl_tdata;
       t3_s_axis_ptctl_tdata    <= t2_s_axis_ptctl_tdata; 
       t4_s_axis_ptctl_tdata    <= t3_s_axis_ptctl_tdata; 
       t5_s_axis_ptctl_tdata    <= t4_s_axis_ptctl_tdata; 
       t6_s_axis_ptctl_tdata    <= t5_s_axis_ptctl_tdata; 
       t2_s_axis_ptctl_tvalid   <= t1_s_axis_ptctl_tvalid;
       t3_s_axis_ptctl_tvalid   <= t2_s_axis_ptctl_tvalid;
       t4_s_axis_ptctl_tvalid   <= t3_s_axis_ptctl_tvalid;
       t5_s_axis_ptctl_tvalid   <= t4_s_axis_ptctl_tvalid;
       t6_s_axis_ptctl_tvalid   <= t5_s_axis_ptctl_tvalid;      
       if pps_active_edge = '0' then -- rising edge
         t3_pps_incr <=  pps_count_en and t2_s_axis_ptctl_tvalid and t2_pps_re;
       else
         t3_pps_incr <=  pps_count_en and t2_s_axis_ptctl_tvalid and t2_pps_fe;
       end if;  
       t4_sample_cntr_sclr <= cntr_rst;
       t5_sample_cntr_sclr <= t4_sample_cntr_sclr;
       if t1_s_axis_aresetn = '0' then
          t2_pps_re      <= '0';
          t2_pps         <= '0';
          t2_pps_fe      <= '0';
          t2_sync_re     <= '0';
          t2_sync_fe     <= '0';
          t2_sync        <= '0'; 
          t2_gate_re     <= '0'; 
          t2_gate_fe     <= '0'; 
          t2_gate        <= '0'; 
          t2_pps_offset  <= '0';
          t2_sync_offset <= '0';
          t2_gate_offset <= '0';
       elsif t1_s_axis_ptctl_tvalid = '1' then
          t2_pps_re      <= pps and not t2_pps;
          t2_pps         <= pps;
          t2_pps_fe      <= t2_pps and not pps; 
          t2_pps_offset  <= t1_s_axis_ptctl_tdata(2);
          t2_sync_re     <= sync and not t2_sync;
          t2_sync_fe     <= t2_sync and not sync;
          t2_sync        <= sync;
          t2_sync_offset <= t1_s_axis_ptctl_tdata(1);
          t2_gate_re     <= gate and t2_gate;
          t2_gate_fe     <= t2_gate and not gate;
          t2_gate        <= gate;
          t2_gate_offset <= t1_s_axis_ptctl_tdata(0);
       end if;
   end if;
end process;

t3_pps_cntr_ce                      <= t3_pps_incr or t3_cntr_load;

-- Increment value
t3_dsp48accl_incr_val(15 downto 0)  <= sample_cntr_incr_val(15 downto 0);


--dsp48accl_cin <= (pps_cntr_init_val(15 downto 0) & sample_cntr_init_val(31 downto 0));
dsp48accu_cin <= pps_cntr_init_val(31 downto 16);

--------------------------------------------------------------------------------
-- 32-bit PPS counter
--------------------------------------------------------------------------------

-- 1 clock latency
ppscntr_inst : px_timestamp_gen_ppscntr
port map (
    clk     => s_axis_aclk,
    ce      => t3_pps_cntr_ce,
    sclr    => cntr_rst,
    load    => t3_cntr_load,
    l       => pps_cntr_init_val,
    q       => t4_pps_cntr
);

--------------------------------------------------------------------------------
-- 64-bit sample counter
--------------------------------------------------------------------------------

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
     cma <= (pps_cntr_init_val(15 downto 0) & sample_cntr_init_val(31 downto 0));
     ma  <=  (others => '0'); 
     t1_cma <= cma; 
     t1_ma  <= ma;
   end if;
end process;   

accl_sel <= (t3_pps_cntr_ce and pps_mode and not t3_cntr_load) & t3_cntr_load;

dsp48accl_cin <= t1_cma when (accl_sel = "01") else
                 t1_ma  when (accl_sel = "10") else
                 (x"00000000" & t3_dsp48accl_incr_val);
acclsel <= '1' when (accl_sel /= "00") else '0';                  
-- a,d,c and sel have a 1 clock latency
-- a,d, sel and c not effected by cep
-- overall 2 clock latency
dsp48accl_inst : px_timestamp_gen_dsp48accl
port map (  
  clk         => s_axis_aclk,
  sel(0)      => acclsel,
--  a           => t3_cntr_load_offset, -- offset
  c           => dsp48accl_cin, -- load value
--  d           => t3_dsp48accl_incr_val, -- increment value
  carrycascout=> dsp48accl_carrycascout,
  p           => t5_sample_cntr(47 downto 0),
  cep         => t4_s_axis_ptctl_tvalid,
  sclrp       => t4_sample_cntr_sclr  
  );


-- c and sel have a 2 clock latency
-- sel and c not effected by cep
-- overall 3 clock latency
dsp48accu_inst : px_timestamp_gen_dsp48accu
port map (
    clk             => s_axis_aclk,
    sel(0)          => t3_cntr_load,
    c               => dsp48accu_cin,
    carrycascin     => dsp48accl_carrycascout,
    p               => t6_sample_cntr(63 downto 48),
    cep             => t5_s_axis_ptctl_tvalid, -- delay to align lower and upper accumulator latencies
    sclrp           => t5_sample_cntr_sclr
  );

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
       t5_pps_cntr                 <= t4_pps_cntr; -- delay PPS counter to line up with sample counter
       t6_pps_cntr                 <= t5_pps_cntr;
       t6_sample_cntr(47 downto 0) <= t5_sample_cntr(47 downto 0); -- delay to align lower and upper accumulator latencies
    end if;
end process;

-- Counter Wrap Detection
process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
        if pps_mode = '0' then
            t7_smpl_cntr_msb       <= t6_sample_cntr(63);
            sample_cntr_wrap_event <= t6_sample_cntr(63) xor t7_smpl_cntr_msb;
        else
            t7_smpl_cntr_msb       <= t6_sample_cntr(31);
            sample_cntr_wrap_event <= t6_sample_cntr(31) xor t7_smpl_cntr_msb;
        end if;
        if pps_mode = '0' then
            pps_cntr_wrap_event    <= '0';
        else
            t7_pps_cntr_msb        <= t6_pps_cntr(31);
            pps_cntr_wrap_event    <= t6_pps_cntr(31) xor t7_pps_cntr_msb;
        end if;
    end if;
end process;


--------------------------------------------------------------------------------
-- Output Mux
--------------------------------------------------------------------------------
-- Select PPS mode or 64-bit free-running mode
process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
      if  t1_s_axis_aresetn = '0' then
        m_axis_pts_tdata   <= (others => '0');
        m_axis_pts_tuser   <= (others => '0');
        m_axis_pts_tvalid  <= '0'; 
        readback_sample_cnt <= (others => '0');
      else
        if pps_mode = '1' then
           m_axis_pts_tdata <= t6_pps_cntr(31 downto 0) & t6_sample_cntr(31 downto 0); 
           if latch_readback = '0' then
             readback_pps_cnt    <= t6_pps_cntr(31 downto 0);
             readback_sample_cnt <= t6_sample_cntr(31 downto 0);
           end if;
        else
           m_axis_pts_tdata        <= t6_sample_cntr(63 downto 0);
           if latch_readback = '0' then
              readback_pps_cnt    <= t6_sample_cntr(63 downto 32);
              readback_sample_cnt <= t6_sample_cntr(31 downto 0);
           end if;
        end if;
        
        if t5_s_axis_ptctl_tdata(0) = '1' then
            m_axis_pts_tuser(7 downto 0)  <= x"FF";
        else
            m_axis_pts_tuser(7 downto 0)  <= x"00";
        end if; 
        if t5_s_axis_ptctl_tdata(1) = '1' then
            m_axis_pts_tuser(15 downto 8)  <= x"FF";
        else
            m_axis_pts_tuser(15 downto 8)  <= x"00";
        end if;
        if t5_s_axis_ptctl_tdata(2) = '1' then
            m_axis_pts_tuser(23 downto 16)  <= x"FF";
        else
            m_axis_pts_tuser(23 downto 16)  <= x"00";
        end if;       
            
        m_axis_pts_tvalid  <= t5_s_axis_ptctl_tvalid;
      end if;
    end if;
end process;

end Behavioral;
