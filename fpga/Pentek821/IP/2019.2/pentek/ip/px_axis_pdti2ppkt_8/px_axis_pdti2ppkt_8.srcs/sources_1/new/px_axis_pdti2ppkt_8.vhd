----------------------------------------------------------------------------------
-- Pentek Data Stream Flow Control for 8 Sample/Cycle AXI-Stream PDTI format
----------------------------------------------------------------------------------
-- px_axis_pdti2ppkt_8.vhd
--
-- Target Device: Kintex UltraScale
--
-- Pentek Inc.
-- One Park Way, Upper Saddle River, NJ 07458
-- (201)818-5900
-- www.pentek.com
--
-- Copyright Pentek, Inc. 2016, 2017
--
-- Revision:
-- Revision 1.00 - File Created
-- Revision 1.10 - 4/20/17 Fixed Retrigger behavior and added BAD_TRIG Interrupt source
--               - 7/26/17 Eliminated issue of tlast and sop when BAD_TRIG
--               - 7/27/17 Fixed Bad Trigger behavior when dval is not asserted every clock cycle 
-- Revision 1.30 - 4/23/18 Fixed Trig Clear Behavior in Hold mode
-- Revision 1.40 - 12/18/18 Fixed 8 bit behavior in gate mode.
-- Revision 1.50 - 08/29/19 Added wc_sync_enable - This signal allows the SYNC A signal 
--                         to reset the width converter. When operating in 8-bit mode 
--                         the data flow control core creates 8-bit samples out of the 
--                         incoming stream of 16-bit samples. Resetting this width 
--                         converter using the SYNC signal ensures that the width 
--                         conversion is started simultaneously across different 
--                         channels or boards.   Also gated t2_gate with t3_trig_hold
--                         to prevent data discontinuities.


-- Additional Comments: 
-- This core can control flow of an input data stream into a packetized output
-- where the start and end of the packet are controlled by either a gata/trigger,
-- or a timestamp range. 
-- This core supports only 8 sample per cycle data streams
-- with either a single 16 bit real value, 16-bit I/Q packed, or 32-bit unpacked I/Q. 

-- Register Map
-- 0x00 Mode Control                    R/W   
-- 0x04 Trigger Clear                   R/W  
-- 0x08 Trigger Delay Value             R/W
-- 0x0C Trigger Length Value            R/W
-- 0x10 TimeStamp Start (Lower)         R/W
-- 0x14 TimeStamp Start (Upper)         R/W
-- 0x18 TimeStamp End   (Lower)         R/W
-- 0x1C TimeStamp End   (Upper)         R/W
-- 0x20 Status                          RO 
-- 0x34 Interrupt Enables               R/W
-- 0x38 Interrupt Status Register       RO 
-- 0x3C Interrupt Flag Register         R/Clr

-- Mode Control Register
--Bit [0]   - trig_arm
--Bit [1]   - stay_armed
--Bit [3:2] - mode_sel[1:0]
            --  "00" = Gate Mode
            --  "01" = Trig Mode
            --  "10" = Trig Hold Mode
            --  "11" = Timestamp Mode 
--Bit [5:4] - data_mode_sel[1:0]
            -- "00" = 16-bit Real Data
            -- "01" = 16-bit I/Q Data
            -- "10" = 8-bit Real Data
            -- "11" = 24-bit I/Q
-- Bit [6]  -- local gate reg mode
-- Bit [7]  -- Local gate register bit  
-- Bit 8    -- Width converter sync enable
-- Trigger Clear Register
-- Bit [0] - Trigger Clear
-- Bit [1] - Disarm after trigger ends

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

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
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axis_pdti2ppkt_8 is
port (
    
    ----------------------------------------------------------------------------
    -- Control/Status Registers (AXI-LITE)
    ----------------------------------------------------------------------------
    s_axi_csr_aclk           : in  std_logic;
    -- associated with s_axi_aclk
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
    
    irq                      : out std_logic; -- Interrupt out
    -----------------------------------------------------------------------------
    s_axis_aclk              : in  std_logic; -- AXI Stream Clock
    s_axis_aresetn           : in  std_logic;
    -----------------------------------------------------------------------------
    -- Input Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
    -----------------------------------------------------------------------------
    -- 8 Samples/Cycle Only
    s_axis_pdti_tdata  : in  std_logic_vector(127 downto 0);  
    s_axis_pdti_tuser  : in  std_logic_vector(127 downto 0);
    s_axis_pdti_tvalid : in  std_logic;
    ----------------------------------------------------------------------------
    -- Output Packetized Stream (AXI4-Stream Master) 
    ----------------------------------------------------------------------------
    -- No back pressure supported
    -- tuser[63:0]    = timestamp[63:0]  
    -- tuser[64]      = SOP   
    -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 3 = 32-bit
    -- tuser[67]      = Data Type 0 = Real 1 = I/Q
    -- tuser[75:68]   = channel[7:0]
    -- tuser[79:76]   = user [3:0] (Considered valid on tlast only)
    m_axis_ppkt_tvalid   : out std_logic;
    m_axis_ppkt_tdata    : out std_logic_vector(127 downto 0);  
    m_axis_ppkt_tuser    : out std_logic_vector(79 downto 0);
    m_axis_ppkt_tkeep    : out std_logic_vector(7 downto 0); -- One per 16-bit word
    m_axis_ppkt_tlast    : out std_logic -- end of packet
);
end px_axis_pdti2ppkt_8;

architecture Behavioral of px_axis_pdti2ppkt_8 is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Control/Status Registers
component px_axis_pdti2ppkt_8_csr
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    s_axi_csr_aclk        : in  std_logic;
    s_axi_csr_aresetn     : in  std_logic;
    s_axi_csr_awaddr      : in  std_logic_vector(5 downto 0);
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
    s_axi_csr_araddr      : in  std_logic_vector(5 downto 0);
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
    trig_clear            : out std_logic;
    trig_arm              : out std_logic;
    disarm                : out std_logic;
    mode_sel              : out std_logic_vector(1 downto 0);
    data_mode_sel         : out std_logic_vector(1 downto 0);
    stay_armed            : out std_logic;
    trig_dly              : out std_logic_vector(31 downto 0);
    trig_len              : out std_logic_vector(31 downto 0);
    strt_ts_ldw           : out std_logic_vector(31 downto 0);
    strt_ts_udw           : out std_logic_vector(31 downto 0);  
    end_ts_ldw            : out std_logic_vector(31 downto 0);
    end_ts_udw            : out std_logic_vector(31 downto 0);
    local_gate_mode       : out std_logic; 
    local_gate            : out std_logic; 
    wc_sync_en            : out std_logic;
--------------------------------------------------------------------------------
-- Status Inputs (synchronous to axis_aclk)
--------------------------------------------------------------------------------     
    waiting_arm  	      : in  std_logic;     
    armed                 : in  std_logic;
    active                : in  std_logic;
    mode                  : in  std_logic_vector(1 downto 0);
    data_mode             : in  std_logic_vector(1 downto 0);
 --------------------------------------------------------------------------------
-- Interrupt Sources (synchronous to axis_aclk)
--------------------------------------------------------------------------------    
    acq_start             : in  std_logic;  
    acq_end               : in  std_logic;  
    waiting_arm_re        : in  std_logic;  
    armed_re              : in  std_logic;
    bad_trig              : in  std_logic
    );
end component;

-- DSP48 Based Down Counter
-- Stops at zero
component px_axis_pdti2ppkt_8_dwncntr 
port ( 
    clk     : in std_logic;
    sclr    : in std_logic;
    ce      : in std_logic;
    ld      : in std_logic; -- qualified by ce
    ld_val  : in std_logic_vector(31 downto 0);
    tc      : out std_logic;
    count   : out std_logic_vector(31 downto 0)  
);
end component;

-- Barrel Shift based on gate positions
component px_axis_pdti2ppkt_bs
port (
  aclk               : in  std_logic;
  aresetn            : in  std_logic;
  
  s_axis_pdti_tdata  : in  std_logic_vector(127 downto 0);  
  s_axis_pdti_tuser  : in  std_logic_vector(127 downto 0);
  s_axis_pdti_tvalid : in  std_logic;
  
  t3_trig_hold       : in  std_logic;
  m_axis_pdti_tdata  : out std_logic_vector(127 downto 0);  
  m_axis_pdti_tuser  : out std_logic_vector(127 downto 0);
  m_axis_pdti_tvalid : out std_logic
);
end component;

-- Output only top 8 bits of each 16-bit sample in 8 sample per cycle stream
component px_axis_pdti2ppkt_8_8bit
port (
  aclk               : in  std_logic;
  aresetn            : in  std_logic;
    
  s_axis_pdti_tdata  : in  std_logic_vector(127 downto 0);  
  s_axis_pdti_tuser  : in  std_logic_vector(127 downto 0);
  s_axis_pdti_tvalid : in  std_logic;

  m_axis_pdti_tdata  : out std_logic_vector(127 downto 0);  
  m_axis_pdti_tuser  : out std_logic_vector(127 downto 0);
  m_axis_pdti_tvalid : out std_logic;
  
  t3_trig_hold       : in  std_logic;
  wc_sync_en         : in  std_logic;
  mode_8bit          : in  std_logic
 );
end component;

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";

ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";
ATTRIBUTE X_INTERFACE_INFO of s_axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_pdti:m_axis_ppkt, ASSOCIATED_RESET s_axis_aresetn";

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

type state_type is
(
RESET_STATE,
WAIT_TRIG_ARMED,
TRIG_ARMED_STATE
);

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

constant GATE_MODE        : std_logic_vector(1 downto 0) := "00";
constant TRIG_MODE        : std_logic_vector(1 downto 0) := "01";
constant TRIG_HOLD_MODE   : std_logic_vector(1 downto 0) := "10";
constant TS_MODE          : std_logic_vector(1 downto 0) := "11";
constant REAL_MODE16      : std_logic_vector(1 downto 0) := "00";
constant IQ_MODE16        : std_logic_vector(1 downto 0) := "01";
constant REAL_MODE8       : std_logic_vector(1 downto 0) := "10";
constant IQ_MODE24        : std_logic_vector(1 downto 0) := "11";

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal state             : state_type;
signal m_axi_xc_awaddr   : std_logic_vector(5 downto 0) := (others => '0');    
signal m_axi_xc_awprot   : std_logic_vector(2 downto 0) := (others => '0');    
signal m_axi_xc_awvalid  : std_logic := '0';                       
signal m_axi_xc_awready  : std_logic := '0';                       
signal m_axi_xc_wdata    : std_logic_vector(31 downto 0) := (others => '0');   
signal m_axi_xc_wstrb    : std_logic_vector(3 downto 0) := (others => '0');    
signal m_axi_xc_wvalid   : std_logic := '0';                       
signal m_axi_xc_wready   : std_logic := '0';                       
signal m_axi_xc_bresp    : std_logic_vector(1 downto 0) := (others => '0');    
signal m_axi_xc_bvalid   : std_logic := '0';                       
signal m_axi_xc_bready   : std_logic := '0';                       
signal m_axi_xc_araddr   : std_logic_vector(5 downto 0) := (others => '0');    
signal m_axi_xc_arprot   : std_logic_vector(2 downto 0) := (others => '0');    
signal m_axi_xc_arvalid  : std_logic := '0';                       
signal m_axi_xc_arready  : std_logic := '0';                       
signal m_axi_xc_rdata    : std_logic_vector(31 downto 0) := (others => '0');   
signal m_axi_xc_rresp    : std_logic_vector(1 downto 0) := (others => '0');    
signal m_axi_xc_rvalid   : std_logic := '0';                       
signal m_axi_xc_rready   : std_logic := '0';                       
signal csr_irq           : std_logic := '0'; 
signal trig_clear        : std_logic := '0'; 
signal trig_arm          : std_logic := '0'; 
signal mode_sel          : std_logic_vector(1 downto 0) := (others => '0');  
signal data_mode_sel     : std_logic_vector(1 downto 0) := (others => '0');  
signal stay_armed        : std_logic := '0'; 
signal trig_len          : std_logic_vector(31 downto 0) := (others => '0');  
signal trig_dly          : std_logic_vector(31 downto 0) := (others => '0');  
signal strt_ts_ldw       : std_logic_vector(31 downto 0) := (others => '0');   
signal strt_ts_udw       : std_logic_vector(31 downto 0) := (others => '0');   
signal end_ts_ldw        : std_logic_vector(31 downto 0) := (others => '0');   
signal end_ts_udw        : std_logic_vector(31 downto 0) := (others => '0');   
signal waiting_arm       : std_logic := '0'; 
signal armed             : std_logic := '0'; 
signal active            : std_logic := '0'; 
signal mode              : std_logic_vector(1 downto 0) := (others => '0');  
signal data_mode         : std_logic_vector(1 downto 0) := (others => '0');  
signal acq_start         : std_logic := '0'; 
signal acq_end           : std_logic := '0'; 
signal waiting_arm_re    : std_logic := '0'; 
signal armed_re          : std_logic := '0'; 
signal xirq              : std_logic := '0'; 
signal xempty            : std_logic := '0'; 
signal xor_csr_irq       : std_logic := '0'; 
signal bs_axis_pdti_tdata : std_logic_vector(127 downto 0) := (others => '0');
signal bs8_axis_pdti_tdata : std_logic_vector(127 downto 0) := (others => '0');  
signal t1_s_axis_pdti_tdata : std_logic_vector(127 downto 0) := (others => '0'); 
signal t2_s_axis_pdti_tdata : std_logic_vector(127 downto 0) := (others => '0'); 
signal t3_s_axis_pdti_tdata : std_logic_vector(127 downto 0) := (others => '0'); 
signal t4_s_axis_pdti_tdata : std_logic_vector(127 downto 0) := (others => '0'); 
signal tx_s_axis_pdti_tdata : std_logic_vector(127 downto 0) := (others => '0'); 
signal bs_axis_pdti_tuser : std_logic_vector(127 downto 0) := (others => '0'); 
signal bs8_axis_pdti_tuser : std_logic_vector(127 downto 0) := (others => '0'); 
signal t1_s_axis_pdti_tuser : std_logic_vector(127 downto 0) := (others => '0'); 
signal t2_s_axis_pdti_tuser : std_logic_vector(127 downto 0) := (others => '0'); 
signal t3_s_axis_pdti_tuser : std_logic_vector(127 downto 0) := (others => '0'); 
signal t4_s_axis_pdti_tuser : std_logic_vector(127 downto 0) := (others => '0'); 
signal tx_s_axis_pdti_tuser : std_logic_vector(127 downto 0) := (others => '0'); 
signal bs_axis_pdti_tvalid: std_logic := '0';
signal bs8_axis_pdti_tvalid: std_logic := '0';
signal t1_s_axis_pdti_tvalid: std_logic := '0';
signal t2_s_axis_pdti_tvalid: std_logic := '0'; 
signal t3_s_axis_pdti_tvalid: std_logic := '0'; 
signal t4_s_axis_pdti_tvalid: std_logic := '0';
signal tx_s_axis_pdti_tvalid: std_logic := '0';
signal t2_gatetrig      : std_logic_vector(7 downto 0) := (others => '0'); 
signal t2_gate          : std_logic_vector(7 downto 0) := (others => '0'); 
signal t3_gate          : std_logic_vector(7 downto 0) := (others => '0'); 
signal t3_gatetrig      : std_logic_vector(7 downto 0) := (others => '0'); 
signal t4_gatetrig      : std_logic_vector(7 downto 0) := (others => '0'); 
signal t2_trig_re       : std_logic := '0';    
signal t1_ts_udw        : std_logic_vector(31 downto 0) := (others => '0'); 
signal t1_ts_ldw        : std_logic_vector(31 downto 0) := (others => '0'); 
signal t2_trig_cntr_ld  : std_logic := '0';   
signal t2_trig_cntr_ce  : std_logic := '0';   
signal trig_cntr_ld_val : std_logic_vector(31 downto 0) := (others => '0'); 
signal trig_dly_cntr_ld_val : std_logic_vector(31 downto 0) := (others => '0');   
signal pack_cntr        : std_logic := '0';
signal t1_waiting_arm   : std_logic := '0';
signal t1_armed         : std_logic := '0';
signal sop              : std_logic := '0';
signal t1_csr_irq       : std_logic := '0';
signal frst             : std_logic := '0';
signal t4_mux_gate      : std_logic_vector(7 downto 0) := (others => '0'); 
signal t3_trig_cntr_tc  : std_logic := '0';
signal t3_ts_gate       : std_logic := '0';
signal t3_trig_hold     : std_logic := '0';
signal trig_cntr_sclr   : std_logic := '0';
signal trig_count       : std_logic_vector(31 downto 0) := (others => '0'); 
signal dly_count        : std_logic_vector(31 downto 0) := (others => '0'); 
signal t2_strt_sub32_ldw_p: std_logic_vector(32 downto 0) := (others => '0');
signal t2_strt_sub32_udw_p: std_logic_vector(32 downto 0) := (others => '0'); 
signal t2_end_sub32_ldw_p: std_logic_vector(32 downto 0) := (others => '0');
signal t2_end_sub32_udw_p: std_logic_vector(32 downto 0) := (others => '0'); 
signal tx_strt_sub32_ldw_p: std_logic_vector(32 downto 0) := (others => '0');
signal tx_strt_sub32_udw_p: std_logic_vector(32 downto 0) := (others => '0'); 
signal tx_end_sub32_ldw_p: std_logic_vector(32 downto 0) := (others => '0');
signal tx_end_sub32_udw_p: std_logic_vector(32 downto 0) := (others => '0');
signal disarm            : std_logic := '0';
signal t3_trig_cntr_ld   : std_logic := '0';
signal t4_trig_cntr_ld   : std_logic := '0';
signal t2_trig_dly_cntr_ce: std_logic := '0';
signal t3_trig_dly_cntr_tc: std_logic := '0';
signal local_gate_mode   : std_logic := '0'; 
signal local_gate        : std_logic := '0'; 
signal t2_trig_cntr_up_ce: std_logic := '0'; 
signal tp1               : std_logic_vector(30 downto 0) := (others => '0');
signal tp2xm1            : std_logic_vector(31 downto 0) := (others => '0');
signal t1_des_ctl        : std_logic := '0';
signal  t3_trig_tc       : std_logic := '0';
signal remainder_tkeep   : std_logic_vector(7 downto 0) := (others => '0');
signal acqx_end          : std_logic := '0';
signal tx_gatetrig       : std_logic_vector(7 downto 0) := (others => '0'); 
signal tx_gate           : std_logic_vector(7 downto 0) := (others => '0'); 
signal ty_gatetrig       : std_logic_vector(7 downto 0) := (others => '0'); 
signal ty_gate           : std_logic_vector(7 downto 0) := (others => '0'); 
signal t2_gate_fe        : std_logic := '0';
signal t3_gate_fe        : std_logic := '0';
signal t4_gate_fe        : std_logic := '0';
signal t4_trig_cntr_tc   : std_logic := '0';
signal t2_ts_gate        : std_logic := '0';
signal ts_end            : std_logic := '0';
signal tx_ts_end         : std_logic := '0';
signal mode_8bit         : std_logic := '0';
signal t3_trig_re        : std_logic := '0';
signal retrig            : std_logic := '0';
signal t4_trig_dly_cntr_tc: std_logic := '0';
signal bad_trig          : std_logic := '0';
signal t1_bad_trig       : std_logic := '0';
signal t1_s_axi_csr_aresetn: std_logic := '0';
signal tn_trig_cntr_ld   : std_logic := '0';
signal t2_gate_fe_p      : std_logic := '0';
signal wc_sync_en        : std_logic;

--------------------------------------------------------------------------------

begin

--------------------------------------------------------------------------------
-- Control/Status Registers  
--------------------------------------------------------------------------------

-- Control/Status Registers
csr_inst: px_axis_pdti2ppkt_8_csr
port map (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    axis_aclk             => s_axis_aclk,   
    s_axi_csr_aclk        => s_axi_csr_aclk,   
    s_axi_csr_aresetn     => t1_s_axi_csr_aresetn,
    s_axi_csr_awaddr      => s_axi_csr_awaddr(5 downto 0),
    s_axi_csr_awprot      => s_axi_csr_awprot,            
    s_axi_csr_awvalid     => s_axi_csr_awvalid,           
    s_axi_csr_awready     => s_axi_csr_awready,           
    s_axi_csr_wdata       => s_axi_csr_wdata,             
    s_axi_csr_wstrb       => s_axi_csr_wstrb,             
    s_axi_csr_wvalid      => s_axi_csr_wvalid,            
    s_axi_csr_wready      => s_axi_csr_wready,            
    s_axi_csr_bresp       => s_axi_csr_bresp,             
    s_axi_csr_bvalid      => s_axi_csr_bvalid,            
    s_axi_csr_bready      => s_axi_csr_bready,            
    s_axi_csr_araddr      => s_axi_csr_araddr(5 downto 0),
    s_axi_csr_arprot      => s_axi_csr_arprot,            
    s_axi_csr_arvalid     => s_axi_csr_arvalid,           
    s_axi_csr_arready     => s_axi_csr_arready,           
    s_axi_csr_rdata       => s_axi_csr_rdata,             
    s_axi_csr_rresp       => s_axi_csr_rresp,             
    s_axi_csr_rvalid      => s_axi_csr_rvalid,            
    s_axi_csr_rready      => s_axi_csr_rready,             
    
    irq                   => csr_irq,             -- interrupt
--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------    
    trig_clear            => trig_clear,   
    trig_arm              => trig_arm,    
    disarm                => disarm, 
    mode_sel              => mode_sel,     
    data_mode_sel         => data_mode_sel,
    stay_armed            => stay_armed, 
    trig_dly              => trig_dly,
    trig_len              => trig_len,     
    strt_ts_ldw           => strt_ts_ldw,  
    strt_ts_udw           => strt_ts_udw,   
    end_ts_ldw            => end_ts_ldw,   
    end_ts_udw            => end_ts_udw,  
    local_gate_mode       => local_gate_mode,     
    local_gate            => local_gate,
    wc_sync_en            => wc_sync_en,
--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------     
    waiting_arm  	      => waiting_arm,
    armed                 => armed,      
    active                => active,     
    mode                  => mode,       
    data_mode             => data_mode,  
 --------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------    
    acq_start             => acq_start,       
    acq_end               => acq_end,         
    waiting_arm_re        => waiting_arm_re,  
    armed_re              => armed_re,
    bad_trig              => t1_bad_trig -- trigger occured before last acq was complete           
    );

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
        t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
        irq <= csr_irq;
   end if;
end process;

--------------------------------------------------------------------------------
-- Barrel Shift Data so that it starts aligned to the gate edge
--------------------------------------------------------------------------------
bs_inst: px_axis_pdti2ppkt_bs
port map(
  aclk               => s_axis_aclk,
  aresetn            => s_axis_aresetn,
  
  s_axis_pdti_tdata  => s_axis_pdti_tdata,
  s_axis_pdti_tuser  => s_axis_pdti_tuser,
  s_axis_pdti_tvalid => s_axis_pdti_tvalid,
  
  t3_trig_hold       => t3_trig_hold,
  m_axis_pdti_tdata  => bs_axis_pdti_tdata, 
  m_axis_pdti_tuser  => bs_axis_pdti_tuser,
  m_axis_pdti_tvalid => bs_axis_pdti_tvalid
);

mode8bit_inst: px_axis_pdti2ppkt_8_8bit
port map (
  aclk               => s_axis_aclk,   
  aresetn            => s_axis_aresetn,
    
  s_axis_pdti_tdata  => bs_axis_pdti_tdata, 
  s_axis_pdti_tuser  => bs_axis_pdti_tuser, 
  s_axis_pdti_tvalid => bs_axis_pdti_tvalid,

  m_axis_pdti_tdata  => bs8_axis_pdti_tdata,
  m_axis_pdti_tuser  => bs8_axis_pdti_tuser,
  m_axis_pdti_tvalid => bs8_axis_pdti_tvalid,
  
  t3_trig_hold       => t3_trig_hold,
  wc_sync_en         => wc_sync_en,
  mode_8bit          => mode_8bit          
 );

mode_8bit <= '1' when (data_mode = REAL_MODE8) else '0';

-- Register inputs
process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
      t1_s_axis_pdti_tdata  <= bs8_axis_pdti_tdata; 
      --t2_s_axis_pdti_tdata  <= t1_s_axis_pdti_tdata; 
      t3_s_axis_pdti_tdata  <= t2_s_axis_pdti_tdata; 
      t4_s_axis_pdti_tdata  <= t3_s_axis_pdti_tdata;
      t1_s_axis_pdti_tuser  <= bs8_axis_pdti_tuser; 
      --t2_s_axis_pdti_tuser  <= t1_s_axis_pdti_tuser; 
      t3_s_axis_pdti_tuser  <= t2_s_axis_pdti_tuser; 
      t4_s_axis_pdti_tuser  <= t3_s_axis_pdti_tuser; 
      t1_s_axis_pdti_tvalid <= bs8_axis_pdti_tvalid; 
      tx_s_axis_pdti_tvalid <= t1_s_axis_pdti_tvalid; 
      t2_s_axis_pdti_tvalid <= tx_s_axis_pdti_tvalid; 
      t3_s_axis_pdti_tvalid <= t2_s_axis_pdti_tvalid; 
      t4_s_axis_pdti_tvalid <= t3_s_axis_pdti_tvalid; 
      if t1_s_axis_pdti_tvalid = '1' then
         if (local_gate_mode = '0') then
            tx_gatetrig <= t1_s_axis_pdti_tuser(71 downto 64);
            tx_gate     <= t1_s_axis_pdti_tuser(71 downto 64);
         else
            tx_gatetrig <= local_gate & local_gate & local_gate & local_gate & local_gate & local_gate & local_gate & local_gate;
            tx_gate     <= local_gate & local_gate & local_gate & local_gate & local_gate & local_gate & local_gate & local_gate;
         end if;
         tx_s_axis_pdti_tuser  <= t1_s_axis_pdti_tuser; 
         tx_s_axis_pdti_tdata  <= t1_s_axis_pdti_tdata;
         t2_s_axis_pdti_tuser  <= tx_s_axis_pdti_tuser; 
         t2_s_axis_pdti_tdata  <= tx_s_axis_pdti_tdata;
         t2_gatetrig <= tx_gatetrig;
         t2_gate     <= tx_gate;
         ty_gatetrig <= t2_gatetrig;
         ty_gate     <= t2_gate;
--         if (t2_gate = x"FF") and (tx_gate /= x"FF") then
--            t2_gate_fe <= '1';
--         else 
--            t2_gate_fe <=  '0';
--         end if;   
      end if;   
      t3_gatetrig  <= t2_gatetrig;
      t4_gatetrig  <= t3_gatetrig;
      t3_gate      <= t2_gate; 
      t3_gate_fe   <= t2_gate_fe;
      t4_gate_fe   <= t3_gate_fe;
      t3_trig_re   <= t2_trig_re;
   end if;
end process;

t2_trig_re <= (t2_gatetrig(0) and not ty_gatetrig(0));
t2_gate_fe <= '1' when ((t2_gate /= x"00") and (tx_gate = x"00"))  else '0';
t1_ts_udw <= t1_s_axis_pdti_tuser(63 downto 32);
t1_ts_ldw <= t1_s_axis_pdti_tuser(31 downto 0);

--------------------------------------------------------------------------------
-- Trigger Controls
--------------------------------------------------------------------------------

-- trigger load
t2_trig_cntr_ld     <= '1' when ((mode = TRIG_MODE) and (t2_trig_re = '1') and (armed = '1')) else '0';   
t2_trig_dly_cntr_ce <= '1' when (((mode = TRIG_MODE) and (t2_s_axis_pdti_tvalid = '1') and (armed = '1'))  or (t2_trig_cntr_ld= '1')) else '0'; 
t2_trig_cntr_ce     <= '1' when (((mode = TRIG_MODE) and (t2_s_axis_pdti_tvalid = '1') and (t3_trig_dly_cntr_tc = '1')  and (armed = '1')) or (t2_trig_cntr_ld= '1')) else '0';
--t2_trig_dly_cntr_ce <= '1' when ((mode = TRIG_MODE) and (armed = '1')) else '0'; 
--t2_trig_cntr_ce     <= '1' when ((mode = TRIG_MODE) and (t2_s_axis_pdti_tvalid = '1') and (t3_trig_dly_cntr_tc = '1') and (armed = '1')) else '0';

-- When packed real data mode, shift trigger length right by one, effectively 
-- equivilent to counter counting by two.
process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then   
      case data_mode is
        when REAL_MODE8 =>
           trig_cntr_ld_val    <= "0000" & trig_len(31 downto 4);
           case trig_len(3 downto 1) is
               when "000" =>
                  remainder_tkeep <= "00000001"; 
               when "001" =>
                  remainder_tkeep <= "00000011";
               when "010" =>
                  remainder_tkeep <= "00000111";
               when "011" =>
                  remainder_tkeep <= "00001111";
               when "100" =>
                  remainder_tkeep <= "00011111";
               when "101" =>
                  remainder_tkeep <= "00111111";
               when "110" =>
                  remainder_tkeep <= "01111111";
               when "111" =>
                  remainder_tkeep <= "11111111";
               when others =>
                  remainder_tkeep <= "11111111";
           end case;
        when REAL_MODE16 =>
             trig_cntr_ld_val    <= "000" & trig_len(31 downto 3);
             case trig_len(2 downto 0) is
                 when "000" =>
                    remainder_tkeep <= "00000001"; 
                 when "001" =>
                    remainder_tkeep <= "00000011";
                 when "010" =>
                    remainder_tkeep <= "00000111";
                 when "011" =>
                    remainder_tkeep <= "00001111";
                 when "100" =>
                    remainder_tkeep <= "00011111";
                 when "101" =>
                    remainder_tkeep <= "00111111";
                 when "110" =>
                    remainder_tkeep <= "01111111";
                 when "111" =>
                    remainder_tkeep <= "11111111";
                 when others =>
                    remainder_tkeep <= "11111111";
             end case;
          when IQ_MODE16  => 
             trig_cntr_ld_val    <= "00" & trig_len(31 downto 2);
             case trig_len(1 downto 0) is
                 when "00" =>
                    remainder_tkeep <= "00000011"; 
                 when "01" =>
                    remainder_tkeep <= "00001111";
                 when "10" =>
                    remainder_tkeep <= "00111111";
                 when "11" =>
                    remainder_tkeep <= "11111111";
                 when others =>
                    remainder_tkeep <= "11111111";
             end case; 
          when IQ_MODE24 =>                                                        
             trig_cntr_ld_val    <= '0' & trig_len(31 downto 1);
             if trig_len(0) = '0' then
                remainder_tkeep <= "00001111"; 
             else
                remainder_tkeep <= "11111111"; 
             end if;
          when others =>
             trig_cntr_ld_val    <= '0' & trig_len(31 downto 1);
             if trig_len(0) = '0' then
                remainder_tkeep <= "00001111"; 
             else
                remainder_tkeep <= "11111111"; 
             end if;
      end case;
      trig_dly_cntr_ld_val      <= trig_dly(31 downto 0);
      if (t2_s_axis_pdti_tvalid = '1') then
        t3_trig_cntr_ld <= t2_trig_cntr_ld;
      end if;
      t4_trig_cntr_ld <= t3_trig_cntr_ld;
      tn_trig_cntr_ld <= t2_trig_cntr_ld;
   end if;  
end process;

-- Multiplexer for trigger sources
process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
     if armed = '1' then
         case mode is
            when TRIG_MODE =>
                if  (t3_trig_dly_cntr_tc = '1') and (t3_trig_tc = '0') then
                    if t3_trig_cntr_tc = '0' then
                       t4_mux_gate <= "11111111";
                    else
                       t4_mux_gate <= remainder_tkeep; 
                    end if;
                --elsif (t3_trig_dly_cntr_tc = '1') and (t3_gatetrig(0)= '1') and (t3_trig_cntr_tc = '1') then
                elsif (t3_trig_dly_cntr_tc = '1') and (t3_trig_re = '1') and (t3_trig_cntr_tc = '1') then
                    t4_mux_gate <= remainder_tkeep; 
                else
                   t4_mux_gate <= "00000000";
                end if;
            when TRIG_HOLD_MODE =>
               t4_mux_gate <= t3_trig_hold & t3_trig_hold & t3_trig_hold & t3_trig_hold & t3_trig_hold & t3_trig_hold & t3_trig_hold & t3_trig_hold;
            when GATE_MODE =>
               t4_mux_gate <= t3_gate;
            when TS_MODE =>
               t4_mux_gate <= t3_ts_gate & t3_ts_gate & t3_ts_gate & t3_ts_gate & t3_ts_gate & t3_ts_gate & t3_ts_gate & t3_ts_gate;
            when others =>
               t4_mux_gate <= "00000000";
         end case; 
      else
        t4_mux_gate <= "00000000";   
      end if;
      t4_trig_cntr_tc <= t3_trig_cntr_tc;
      t4_trig_dly_cntr_tc <= t3_trig_dly_cntr_tc;
   end if;
end process;   

--acqx_end <= (((t4_trig_cntr_tc and t3_trig_dly_cntr_tc) or trig_clear or retrig) and (active or t4_trig_cntr_ld or t4_mux_gate(0))) when (mode = TRIG_MODE) else
--           (t4_gate_fe  and active) when (mode = GATE_MODE) else 
--           (ts_end) when (mode = TS_MODE) else '0';      
                      
acqx_end <= (((t4_trig_cntr_tc and t3_trig_dly_cntr_tc) or trig_clear) and (active or t4_trig_cntr_ld or t4_mux_gate(0))) when (mode = TRIG_MODE) else
           ((t4_gate_fe  and active) or (t4_gate_fe  and sop)) when (mode = GATE_MODE) else 
           (ts_end) when (mode = TS_MODE) else trig_clear; --'0';       
  
--------------------------------------------------------------------------------
-- Trigger Hold
--------------------------------------------------------------------------------

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
     if trig_cntr_sclr = '1' or (mode /= TRIG_HOLD_MODE )then
        t3_trig_hold <= '0'; 
     elsif ((mode = TRIG_HOLD_MODE) and (t2_trig_re = '1') and (armed = '1')) then
        t3_trig_hold <= '1';  
     end if;
   end if;
end process;

--------------------------------------------------------------------------------
-- Trigger Counter
--------------------------------------------------------------------------------
process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
     if trig_cntr_sclr = '1' then
        dly_count <= x"00000000"; 
        t3_trig_dly_cntr_tc <= '1';
     elsif (t2_trig_dly_cntr_ce = '1') then
        if (t2_trig_cntr_ld = '1') then
           dly_count <= trig_dly_cntr_ld_val;
        elsif (dly_count /= x"00000000") then 
           dly_count <= dly_count -1;
        end if;
        if (t2_trig_cntr_ld = '1') then
           if (trig_dly_cntr_ld_val = x"00000000") then
              t3_trig_dly_cntr_tc <= '1';
           else
              t3_trig_dly_cntr_tc <= '0';           
           end if;
        elsif (dly_count = x"00000001") or (dly_count = x"00000000") then
           t3_trig_dly_cntr_tc <= '1';
        else
           t3_trig_dly_cntr_tc <= '0';
        end if;
     end if;
   end if;
end process;

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
     if trig_cntr_sclr = '1' then
        trig_count <= x"00000000"; 
        t3_trig_cntr_tc <= '1';
        t3_trig_tc <= '1';
     elsif (t2_trig_cntr_ce = '1') then
        if (t2_trig_cntr_ld = '1') then
           trig_count      <= trig_cntr_ld_val; 
           --t3_trig_cntr_tc <= '0';
        elsif ( trig_count /= x"00000000") then 
          trig_count <= trig_count -1;
        end if;
        if (t2_trig_cntr_ld = '1') then
            if (trig_cntr_ld_val = x"00000000") then
                t3_trig_cntr_tc <= '1';
            else
                t3_trig_cntr_tc <= '0';
            end if;    
        elsif (trig_count = x"00000001") or (trig_count = x"00000000") then
           t3_trig_cntr_tc <= '1';
        else
           t3_trig_cntr_tc <= '0';
        end if;
        if (t2_trig_cntr_ld = '1') then
            if (trig_cntr_ld_val = x"00000000") then
                t3_trig_tc <= '1';
            else
                t3_trig_tc <= '0';
            end if;    
        elsif (trig_count = x"00000000") then
           t3_trig_tc <= '1';
        else
           t3_trig_tc <= '0';
        end if;
     end if;
   end if;
end process;

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
      if (trig_count(31 downto 1) /= "0000000000000000000000000000000") then
         bad_trig <= t2_trig_cntr_ld and not tn_trig_cntr_ld;
      else
         bad_trig <= '0';  
      end if;  
      t1_bad_trig <= bad_trig; 
    end if;
end process; 

--------------------------------------------------------------------------------
-- Timestamp Comparators
--------------------------------------------------------------------------------

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
      t3_ts_gate         <= t2_ts_gate;
      tx_ts_end          <= t2_ts_gate and (not tx_end_sub32_ldw_p(32)) and (not tx_end_sub32_udw_p(32));
      ts_end             <= tx_ts_end; 
      if t1_s_axis_pdti_tvalid = '1' then
        tx_strt_sub32_ldw_p <= ('0' & t1_ts_ldw) - ('0' & strt_ts_ldw);
        tx_strt_sub32_udw_p <= ('0' & t1_ts_udw) - ('0' & strt_ts_udw);
        tx_end_sub32_ldw_p  <= ('0' & t1_ts_ldw) - ('0' & end_ts_ldw);
        tx_end_sub32_udw_p  <= ('0' & t1_ts_udw) - ('0' & end_ts_udw);
      end if;  
      if (trig_cntr_sclr = '1') or (mode /= TS_MODE) then
        t2_ts_gate <= '0';
      elsif (tx_end_sub32_ldw_p(32) = '0') and (tx_end_sub32_udw_p(32) = '0') and (t1_s_axis_pdti_tvalid = '1') then -- end timestamp reached
        t2_ts_gate <= '0';
      elsif (tx_strt_sub32_ldw_p(32) = '0') and (tx_strt_sub32_udw_p(32) = '0') and (t1_s_axis_pdti_tvalid = '1') and (armed = '1') and (mode = TS_MODE) then     
        t2_ts_gate <= '1';
      end if;
   end if;
end process;   

retrig  <= t4_trig_cntr_ld and active;

--------------------------------------------------------------------------------
-- Trigger Control State Machine
--------------------------------------------------------------------------------

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
        waiting_arm_re <= waiting_arm and not t1_waiting_arm;
        t1_waiting_arm <= waiting_arm;
        t1_armed       <= armed;
        armed_re       <= armed and not t1_armed;
        if (s_axis_aresetn = '0') then
           trig_cntr_sclr <= '1';
           pack_cntr      <= '0';
           m_axis_ppkt_tvalid    <= '0';
           m_axis_ppkt_tlast     <= '0';
           sop            <= '0'; 
           armed          <= '0'; 
           mode           <= "00"; 
           data_mode      <= "00"; 
           acq_end        <= '0';
           acq_start      <= '0';
           active         <= '0';
           state <= RESET_STATE;
        else
            case state is
                when RESET_STATE =>
                    trig_cntr_sclr <= '1';
                    pack_cntr      <= '0';
                    m_axis_ppkt_tvalid    <= '0';
                    m_axis_ppkt_tlast     <= '0';
                    sop            <= '0'; 
                    armed          <= '0';
                    mode           <= "00"; 
                    data_mode      <= "00";
                    acq_end        <= '0';
                    acq_start      <= '0';
                    active         <= '0';
                    waiting_arm    <= '0';
                    if (s_axis_aresetn = '0') then
                       state <= RESET_STATE;
                    elsif (trig_clear = '0') then 
                       state <= WAIT_TRIG_ARMED; 
                    end if;
                when WAIT_TRIG_ARMED =>
                    trig_cntr_sclr <= '0';
                    sop            <= '1'; 
                    acq_end        <= '0';
                    acq_start      <= '0';
                    waiting_arm    <= '1';
                    if (trig_clear = '1') then
                       state <= RESET_STATE;
                    elsif (trig_arm = '1') and (disarm = '0') then
                       state <= TRIG_ARMED_STATE;
                    else
                       state <= WAIT_TRIG_ARMED; 
                    end if;
                    mode      <= mode_sel;
                    data_mode <= data_mode_sel;
                when TRIG_ARMED_STATE =>   
                    armed          <= '1';
                    waiting_arm    <= '0';
                    if ((t4_s_axis_pdti_tvalid = '1') and (acqx_end = '1')) then
                        active <= '0'; 
                        trig_cntr_sclr <= trig_clear;       
                        acq_start <= sop;
                        acq_end   <= '1';
                        if (stay_armed = '0') or (trig_clear = '1') or (disarm = '1') then
                            state <= RESET_STATE;
                            sop   <= '0'; 
                        else    
                            state <= TRIG_ARMED_STATE;
                            sop   <= '1'; 
                        end if;  
                        m_axis_ppkt_tdata               <= t4_s_axis_pdti_tdata;
                        m_axis_ppkt_tvalid              <= '1';
                        m_axis_ppkt_tuser(63 downto 0)  <= t4_s_axis_pdti_tuser(63 downto 0);
                        m_axis_ppkt_tuser(64)           <= sop;
                        m_axis_ppkt_tuser(75 downto 65) <= t4_s_axis_pdti_tuser(103 downto 93);
                        m_axis_ppkt_tkeep               <= t4_mux_gate;
                        m_axis_ppkt_tlast               <= '1';    
                    elsif (t4_s_axis_pdti_tvalid  = '1') and (t4_mux_gate(0) = '1') then     
                        acq_end   <= '0';
                        acq_start <= sop;
                        active    <= '1';
                        m_axis_ppkt_tkeep  <= x"FF";
                        m_axis_ppkt_tdata  <= t4_s_axis_pdti_tdata;
                        m_axis_ppkt_tvalid <= '1';
                        m_axis_ppkt_tuser(63 downto 0)  <= t4_s_axis_pdti_tuser(63 downto 0);
                        m_axis_ppkt_tuser(64)           <= sop;
                        m_axis_ppkt_tuser(75 downto 65) <= t4_s_axis_pdti_tuser(103 downto 93);               
                        m_axis_ppkt_tlast               <= '0'; 
                        sop <= '0';  
                    else    
                        acq_end   <= '0';
                        acq_start <= '0';
                        m_axis_ppkt_tvalid <= '0';
                        m_axis_ppkt_tlast  <= '0';
                        if (trig_clear = '1') or (disarm = '1') then
                            state <= RESET_STATE;
                        else 
                            state <= TRIG_ARMED_STATE;
                        end if;    
                    end if;     
                when others =>
                   state <= RESET_STATE;
            end case;    
        end if;
     end if;
end process;


m_axis_ppkt_tuser(79 downto 76) <= "0000";                
          
    

end Behavioral;
