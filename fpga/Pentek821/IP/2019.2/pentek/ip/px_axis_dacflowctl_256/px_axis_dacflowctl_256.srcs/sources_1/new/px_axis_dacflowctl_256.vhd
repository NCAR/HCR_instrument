----------------------------------------------------------------------------------
-- Pentek Data Stream Flow Control
----------------------------------------------------------------------------------
-- px_axis_pdti2ppkt_256.vhd
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
-- Revision 1.0 - 3/29 - Added Bad Trig interrupt bit. Fixed Retrigger behavior 

-- Additional Comments: 
-- This core can control flow of an input data stream into a packetized output
-- where the start and end of the packet are controlled by either a gata/trigger,
-- or a timestamp range. 
-- This core supports only single sample per cycle data streams
-- with either a single 16 bit real value, or 16-bit I/Q packed. 

-- Register Map
-- 0x00 Mode Control                    R/W   
-- 0x04 Trigger Clear                   R/W  
-- 0x08 Trigger Delay Value             R/W
-- 0x0C Trigger Length Value            R/W
-- 0x10 FIFO Flush                      R/W
-- 0x14 Output Rate Div                 R/W
-- 0x18                                 R/W
-- 0x1C                                 R/W
-- 0x20 Status                          RO 
-- 0x24 FIFO Count                      RO 
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
            --  "11" = Reserved 
--Bit [5:4] - data_mode_sel[1:0]
            -- "00" = Time Packed Real Data (I(t1),I(t0))
            -- "01" = I/Q Packed Data 
            -- "10" = 8-bit
            -- "11" = Reserved
-- Bit [6]  -- local gate reg mode
-- Bit [7]  -- Local gate register bit
-- Bit [8]  -- Realtime Lost LED Latch Clear
-- Bit [9]  -- Output at half rate
-- Trigger Clear Register
-- Bit [0] - Trigger Clear
-- Bit [1] - Disarm after trigger ends
-- FIFO Flush Register
-- Bit [0] - FIFO Flush

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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity px_axis_dacflowctl_256 is
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
    -- Input Data (AXI4-Stream Slave) from DMA
    -----------------------------------------------------------------------------
    -- synchronous to s_axi_csr_aclk
    s_axis_pd_tdata          : in  std_logic_vector(255 downto 0);  
    s_axis_pd_tkeep          : in  std_logic_vector(31 downto 0);
    s_axis_pd_tvalid         : in  std_logic;
    s_axis_pd_tready         : out std_logic;
    s_axis_pd_tlast          : in  std_logic;
    -----------------------------------------------------------------------------
    -- Input Control (AXI4-Stream Slave) from Sync Bus
    -----------------------------------------------------------------------------
    -- synchronous to s_axis_aclk
    -- [0] = gate -- [1] = sync -- [2] = pps
    s_axis_pctl_tdata        : in  std_logic_vector(7 downto 0);  
    s_axis_pctl_tvalid       : in  std_logic;
    ----------------------------------------------------------------------------
    -- Output Packetized Stream (AXI4-Stream Master) 
    ----------------------------------------------------------------------------
    -- No back pressure supported
    -- Constant output flow
    -- If input goes empty and real-time is lost, data with zer value are inserted
    -- in the stream.
    
    -- tuser[63:0]    = timestamp[63:0] -- all zero not supported here
    -- tuser[71:64]   = Gate Positions  -- Only [64] is used here
    -- tuser[79:72]   = Sync Positions  -- Only [72] is used here    
    -- tuser[87:80]   = PPS Positions   -- Only [80] is used here
    -- tuser[92:88]   = Samples/Cycle   
    -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3=32 bit
    -- tuser[95]      = Data Type 0 = Real 1 = I/Q
    -- tuser[103:96]  = channel[7:0] 
    -- tuser[127:104] = Reserved 
    m_axis_pdti_tvalid         : out std_logic; 
    m_axis_pdti_tdata          : out std_logic_vector(255 downto 0);
    m_axis_pdti_tuser          : out std_logic_vector(127 downto 0);
    ----------------------------------------------------------------------------
    -- Real Time Lost Status
    ----------------------------------------------------------------------------
    -- Synchronous with s_axis_aclk 
    realtime_lost            : out std_logic
);
end px_axis_dacflowctl_256;

architecture Behavioral of px_axis_dacflowctl_256 is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------
-- AXI-S FIFO
-- 512 deep
-- 256 Wide
-- Independent clocks
COMPONENT px_axis_dacflowctl_256_fifo
  PORT (
    m_aclk : IN STD_LOGIC;
    s_aclk : IN STD_LOGIC;
    s_aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    s_axis_tkeep : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_tlast : IN STD_LOGIC;
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(255 DOWNTO 0);
    m_axis_tkeep : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_tlast : OUT STD_LOGIC;
    axis_wr_data_count : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
    axis_rd_data_count : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
  );
END COMPONENT;

-- AXI_S Width Converter
-- 256 in
-- 32 out
COMPONENT px_axis_dacflowctl_256_wcnv
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    s_axis_tkeep : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_tlast : IN STD_LOGIC;
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_tkeep : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    m_axis_tlast : OUT STD_LOGIC
  );
END COMPONENT;

-- Control/Status Registers
component px_axis_dacflowctl_256_csr
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    axis_aclk             : in  std_logic;
    
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
-- Control Outputs
--------------------------------------------------------------------------------    
    trig_clear            : out std_logic;
    trig_arm              : out std_logic;
    disarm                : out std_logic;
    mode_sel              : out std_logic_vector(1 downto 0);
    data_mode_sel         : out std_logic_vector(1 downto 0);
    stay_armed            : out std_logic;
    trig_dly              : out std_logic_vector(31 downto 0);
    trig_len              : out std_logic_vector(31 downto 0);
    fifo_flush            : out std_logic;
    x_fifo_flush_n        : out std_logic;
    local_gate_mode       : out std_logic; 
    local_gate            : out std_logic; 
    rate_div              : out std_logic_vector(15 downto 0); 
    rt_clr                : out std_logic;
    half_rate_out         : out std_logic;
--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------     
    waiting_arm  	      : in  std_logic;     
    armed                 : in  std_logic;
    active                : in  std_logic;
    mode                  : in  std_logic_vector(1 downto 0);
    data_mode             : in  std_logic_vector(1 downto 0);
    fifo_count            : in  std_logic_vector(10 downto 0);
 --------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------    
    acq_start             : in  std_logic;  
    acq_end               : in  std_logic;  
    waiting_arm_re        : in  std_logic;  
    armed_re              : in  std_logic;
    bad_trig              : in  std_logic;
    fifo_empty            : in  std_logic;
    fifo_full             : in  std_logic;
    real_time_lost        : in  std_logic  
    );
end component;

-- DSP48 Based Down Counter
-- Stops at zero
component px_axis_dacflowctl_256_dwncntr 
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
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";

ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr:s_axis_pd";

ATTRIBUTE X_INTERFACE_INFO of s_axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_aclk: SIGNAL is "ASSOCIATED_BUSIF m_axis_pdti:s_axis_pctl";

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

constant GATE_MODE        : std_logic_vector(1 downto 0) := "00";
constant TRIG_MODE        : std_logic_vector(1 downto 0) := "01";
constant TRIG_HOLD_MODE   : std_logic_vector(1 downto 0) := "10";
constant TIME_PACKED_MODE : std_logic_vector(1 downto 0) := "00";
constant IQ_PACKED_MODE   : std_logic_vector(1 downto 0) := "01";
constant PACKED_8BIT_MODE : std_logic_vector(1 downto 0) := "10";

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal state             : state_type;                     
signal trig_clear        : std_logic := '0'; 
signal trig_arm          : std_logic := '0'; 
signal mode_sel          : std_logic_vector(1 downto 0) := (others => '0');  
signal data_mode_sel     : std_logic_vector(1 downto 0) := (others => '0');  
signal stay_armed        : std_logic := '0'; 
signal trig_len          : std_logic_vector(31 downto 0) := (others => '0');  
signal trig_dly          : std_logic_vector(31 downto 0) := (others => '0');  
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
signal t1_s_axis_pctl_tvalid: std_logic := '0';
signal t2_s_axis_pctl_tvalid: std_logic := '0'; 
signal t2_gatetrig      : std_logic := '0'; 
signal t2_gate          : std_logic := '0'; 
signal t3_gate          : std_logic := '0';   
signal t3_gatetrig      : std_logic := '0'; 
signal t4_gatetrig      : std_logic := '0'; 
signal t2_trig_re       : std_logic := '0';     
signal t2_trig_cntr_ld  : std_logic := '0';   
signal t2_trig_cntr_ce  : std_logic := '0';   
signal trig_cntr_ld_val : std_logic_vector(31 downto 0) := (others => '0'); 
signal trig_dly_cntr_ld_val : std_logic_vector(31 downto 0) := (others => '0');   
signal pack_cntr        : std_logic := '0';
signal t1_waiting_arm   : std_logic := '0';
signal t1_armed         : std_logic := '0';
signal t1_csr_irq       : std_logic := '0';
signal frst             : std_logic := '0';
signal t4_mux_gate      : std_logic := '0';
signal t5_mux_gate      : std_logic := '0';
signal t3_trig_cntr_tc  : std_logic := '0';
signal t3_ts_gate       : std_logic := '0';
signal t3_trig_hold     : std_logic := '0';
signal trig_cntr_sclr   : std_logic := '0';
signal trig_count       : std_logic_vector(31 downto 0) := (others => '0'); 
signal dly_count        : std_logic_vector(31 downto 0) := (others => '0'); 
signal disarm            : std_logic := '0';
signal t3_trig_cntr_ld   : std_logic := '0';
signal t4_trig_cntr_ld   : std_logic := '0';
signal t2_trig_dly_cntr_ce: std_logic := '0';
signal t3_trig_dly_cntr_tc: std_logic := '0';
signal local_gate_mode   : std_logic := '0'; 
signal local_gate        : std_logic := '0'; 
signal t2_trig_cntr_up_ce: std_logic := '0'; 
signal fifo_axis_tvalid  : std_logic := '0'; 
signal fifo_axis_tready  : std_logic := '0'; 
signal fifo_axis_tdata   : std_logic_vector(255 downto 0) := (others => '0');
signal fifo_axis_tkeep   : std_logic_vector(31 downto 0) := (others => '0');
signal fifo_axis_tlast   : std_logic := '0'; 
signal wcnv_axis_tvalid  : std_logic := '0'; 
signal wcnv_axis_tready  : std_logic := '0'; 
signal wcnv_axis_tdata   : std_logic_vector(31 downto 0) := (others => '0');
signal t1_s_axis_pctl_tdata: std_logic_vector(7 downto 0) := (others => '0');
signal t2_s_axis_pctl_tdata: std_logic_vector(7 downto 0) := (others => '0');
signal t3_s_axis_pctl_tdata: std_logic_vector(7 downto 0) := (others => '0');
signal t4_s_axis_pctl_tdata: std_logic_vector(7 downto 0) := (others => '0');
signal sm_tdata          : std_logic_vector(255 downto 0) := (others => '0');
signal t1_fifo_aresetn   : std_logic := '0'; 
signal x_fifo_aresetn    : std_logic := '0'; 
signal fifo_empty        : std_logic := '0'; 
signal fifo_full         : std_logic := '0'; 
signal fifo_count        : std_logic_vector(10 downto 0) := (others => '0');
signal fifo_flush        : std_logic := '0'; 
signal fifo_aresetn      : std_logic := '0'; 
signal qual_gate         : std_logic := '0'; 
signal t1_qual_gate      : std_logic := '0'; 
signal rate_div          : std_logic_vector(15 downto 0) := (others => '0');
signal rate_div_cntr     : std_logic_vector(15 downto 0) := (others => '0');
signal mux_sel           : std_logic := '0';
signal rt                : std_logic := '0';
signal p_csr_irq         : std_logic := '0';
signal rt_clr            : std_logic := '0';
signal half_rate_out     : std_logic := '0';
signal p_realtime_lost   : std_logic := '0';
signal sync_re           : std_logic := '0';
signal x_fifo_flush_n    : std_logic := '0';
signal out_dval          : std_logic := '0';
signal sync_ff           : std_logic := '0';
signal pps_ff            : std_logic := '0';
signal bad_trig          : std_logic := '0';
signal t1_bad_trig       : std_logic := '0';
signal retrig            : std_logic := '0';
signal t4_trig_dly_cntr_tc: std_logic := '0';
signal t1_s_axi_csr_aresetn: std_logic := '0';

--------------------------------------------------------------------------------

begin

--------------------------------------------------------------------------------
-- Control/Status Registers  
--------------------------------------------------------------------------------

-- Control/Status Registers
csr_inst: px_axis_dacflowctl_256_csr
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
    
    irq                   => p_csr_irq,             -- interrupt
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
    fifo_flush            => fifo_flush,
    x_fifo_flush_n        => x_fifo_flush_n,
    local_gate_mode       => local_gate_mode,     
    local_gate            => local_gate,
    rate_div              => rate_div, 
    rt_clr                => rt_clr,
    half_rate_out         => half_rate_out,
--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------     
    waiting_arm  	        => waiting_arm,
    armed                 => armed,      
    active                => active,     
    mode                  => mode,       
    data_mode             => data_mode,  
    fifo_count            => fifo_count,
 --------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------    
    acq_start             => acq_start,       
    acq_end               => acq_end,         
    waiting_arm_re        => waiting_arm_re,  
    armed_re              => armed_re,
    bad_trig              => t1_bad_trig, -- trigger occured before last acq was complete
    fifo_empty            => fifo_empty,
    fifo_full             => fifo_full,
    real_time_lost        => rt         
    );
  

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
        t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
        irq <= p_csr_irq;
   end if;
end process;

--------------------------------------------------------------------------------
-- Input Cross Clock FIFO
--------------------------------------------------------------------------------
-- Data from a DMA is in the PCIe Clock domain.  This FIFO acts as a reservoir
-- and converts to the DAC Clock domain before the data in width converted.

in_fifo_inst : px_axis_dacflowctl_256_fifo
port map (
    m_aclk             => s_axis_aclk,
    s_aclk             => s_axi_csr_aclk,
    s_aresetn          => x_fifo_aresetn,
    s_axis_tvalid      => s_axis_pd_tvalid,
    s_axis_tready      => s_axis_pd_tready,
    s_axis_tdata       => s_axis_pd_tdata,
    s_axis_tkeep       => s_axis_pd_tkeep,
    s_axis_tlast       => s_axis_pd_tlast,
    m_axis_tvalid      => fifo_axis_tvalid,
    m_axis_tready      => fifo_axis_tready,
    m_axis_tdata       => fifo_axis_tdata,
    m_axis_tkeep       => fifo_axis_tkeep,
    m_axis_tlast       => fifo_axis_tlast,
    axis_wr_data_count => open,
    axis_rd_data_count => fifo_count
  );

--------------------------------------------------------------------------------
-- Width Conversion
--------------------------------------------------------------------------------
-- The Data width is converted from 256-bit to 32-bit.
-- Any invalid data bytes are removed from the stream

--wcnv_inst : px_axis_dacflowctl_256_wcnv
--port map (
--    aclk                => s_axis_aclk,
--    aresetn             => fifo_aresetn,
--    s_axis_tvalid       => fifo_axis_tvalid,  
--    s_axis_tready       => fifo_axis_tready,  
--    s_axis_tdata        => fifo_axis_tdata,   
--    s_axis_tkeep        => fifo_axis_tkeep,   
--    s_axis_tlast        => fifo_axis_tlast,   
--    m_axis_tvalid       => wcnv_axis_tvalid,
--    m_axis_tready       => wcnv_axis_tready,
--    m_axis_tdata        => wcnv_axis_tdata,
--    m_axis_tkeep        => open,
--    m_axis_tlast        => open
--    );  

--------------------------------------------------------------------------------

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      t1_fifo_aresetn <= x_fifo_flush_n;
      x_fifo_aresetn  <= t1_fifo_aresetn;
   end if;
end process;

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
      fifo_aresetn <= not fifo_flush;
   
      if fifo_count = "00000000000" then
        fifo_empty   <= '1';
      else
        fifo_empty   <= '0';
      end if; 
      if fifo_count >= "10000000000" then
        fifo_full    <= '1';
      else
        fifo_full    <= '0';
      end if;  
   end if;
end process;
      
  
-- Register inputs
process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
     t1_s_axis_pctl_tdata  <= s_axis_pctl_tdata;
     t2_s_axis_pctl_tdata  <= t1_s_axis_pctl_tdata;
     t3_s_axis_pctl_tdata  <= t2_s_axis_pctl_tdata;
     t4_s_axis_pctl_tdata  <= t3_s_axis_pctl_tdata;
     t1_s_axis_pctl_tvalid <= s_axis_pctl_tvalid;
     t2_s_axis_pctl_tvalid <= t1_s_axis_pctl_tvalid;
     if (local_gate_mode = '0') then
         t2_gatetrig <= t1_s_axis_pctl_tdata(0);
         t2_gate     <= t1_s_axis_pctl_tdata(0);
     else
         t2_gatetrig <= local_gate;
         t2_gate     <= local_gate;
      end if;      
      t3_gatetrig  <= t2_gatetrig;
      t4_gatetrig  <= t3_gatetrig;
      t3_gate      <= t2_gate; 
   end if;
end process;

t2_trig_re <= (t2_gatetrig and not t3_gatetrig);

--------------------------------------------------------------------------------
-- Trigger Controls
--------------------------------------------------------------------------------

-- trigger load
t2_trig_cntr_ld     <= '1' when ((mode = TRIG_MODE) and (t2_trig_re = '1') and (armed = '1')) else '0';   
t2_trig_dly_cntr_ce <= '1' when ((mode = TRIG_MODE) and (armed = '1')) else '0'; 
t2_trig_cntr_ce     <= '1' when ((mode = TRIG_MODE) and (t2_s_axis_pctl_tvalid = '1') and (t3_trig_dly_cntr_tc = '1') and (armed = '1')) else '0';

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then   
      t4_trig_dly_cntr_tc  <= t3_trig_dly_cntr_tc;

      if(data_mode = TIME_PACKED_MODE) then
          trig_cntr_ld_val     <= "0000" & trig_len(31 downto 4);
      elsif(data_mode = IQ_PACKED_MODE) then
          trig_cntr_ld_val     <= "000" & trig_len(31 downto 3);
      elsif(data_mode = PACKED_8BIT_MODE) then
          trig_cntr_ld_val     <= "00000" & trig_len(31 downto 5);
      else
          trig_cntr_ld_val     <= "0000" & trig_len(31 downto 4);
      end if;
      
      trig_dly_cntr_ld_val <= trig_dly(31 downto 0); 
      if (t2_s_axis_pctl_tvalid = '1') then
        t3_trig_cntr_ld <= t2_trig_cntr_ld;
      end if;
      t4_trig_cntr_ld <= t3_trig_cntr_ld;
   end if;  
end process;

-- Multiplexer for trigger sources
process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
     if armed = '1' then
         case mode is
            when TRIG_MODE =>
               t4_mux_gate <= (not t3_trig_cntr_tc) and t3_trig_dly_cntr_tc;
            when TRIG_HOLD_MODE =>
               t4_mux_gate <= t3_trig_hold;
            when GATE_MODE =>
               t4_mux_gate <= t3_gate;
            when others =>
               t4_mux_gate <= '0';
         end case; 
      else
        t4_mux_gate <= '0';   
      end if;
   end if;
end process;   

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
        qual_gate    <= t4_mux_gate and active;
        t1_qual_gate <= qual_gate;
        acq_start    <= qual_gate and not t1_qual_gate;
        acq_end      <= (not qual_gate) and t1_qual_gate;
   end if;
end process;  

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

dwncntr_dly_inst: px_axis_dacflowctl_256_dwncntr 
port map ( 
    clk     => s_axis_aclk,
    sclr    => trig_cntr_sclr,
    ce      => t2_trig_dly_cntr_ce,
    ld      => t2_trig_cntr_ld,
    ld_val  => trig_dly_cntr_ld_val,
    tc      => t3_trig_dly_cntr_tc,
    count   => dly_count 
);

dwncntr_inst: px_axis_dacflowctl_256_dwncntr 
port map ( 
    clk     => s_axis_aclk,
    sclr    => trig_cntr_sclr,
    ce      => t2_trig_cntr_ce,
    ld      => t2_trig_cntr_ld,
    ld_val  => trig_cntr_ld_val,
    tc      => t3_trig_cntr_tc,
    count   => trig_count 
);

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
      if (trig_count(31 downto 1) /= "0000000000000000000000000000000") then
         bad_trig <= t2_trig_cntr_ld;
      else
         bad_trig <= '0';  
      end if;  
      t1_bad_trig <= bad_trig; 
    end if;
end process; 

--------------------------------------------------------------------------------
-- Trigger Control State Machine
--------------------------------------------------------------------------------

--sm_tvalid <= active;
fifo_axis_tready <= active and pack_cntr;
--fifo_axis_tready <= active;

--half_rate_out

sync_re <= t4_mux_gate and not t5_mux_gate;

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
        --if (active = '0') or (s_axis_aresetn = '0') then
        if (sync_re = '1') or (s_axis_aresetn = '0') then
            rate_div_cntr <= rate_div;    
            if (data_mode /= TIME_PACKED_MODE) then
                mux_sel   <= '1';
            else
                mux_sel   <= '0';
            end if;    
            out_dval <= '1';
        elsif (data_mode /= TIME_PACKED_MODE) then
            if (rate_div_cntr = (x"0000")) then
                mux_sel   <= '1'; 
                rate_div_cntr <= rate_div;
                out_dval <= '1';
            else
                rate_div_cntr <= rate_div_cntr-1;
                out_dval <= '0';
            end if;    
        else
            if (rate_div_cntr = (x"0000")) then
                rate_div_cntr <= rate_div;
                mux_sel       <= not mux_sel;
                out_dval <= '1'; 
            else
                rate_div_cntr <= rate_div_cntr-1;
                out_dval <= '0';
            end if;    
        end if;    
    end if;
end process; 

pack_cntr <= '1' when (rate_div_cntr = (x"0000")) else '0'; 

retrig  <= t4_trig_cntr_ld and active;

process(fifo_axis_tdata, data_mode, mux_sel, fifo_axis_tvalid, active)
begin
    if (fifo_axis_tvalid = '1') and (active = '1') then
        --if (data_mode = TIME_PACKED_MODE) then
        --    if mux_sel = '0' then
        --        sm_tdata(15 downto 0)    <= fifo_axis_tdata(15 downto 0);
        --        sm_tdata(31 downto 16)   <= fifo_axis_tdata(15 downto 0);
        --    else
        --        sm_tdata(15 downto 0)    <= fifo_axis_tdata(31 downto 16);  
        --        sm_tdata(31 downto 16)   <= fifo_axis_tdata(31 downto 16);   
        --    end if;
        --else
        --    sm_tdata(15 downto 0)     <= fifo_axis_tdata(15 downto 0);
        --    sm_tdata(31 downto 16)    <= fifo_axis_tdata(31 downto 16);
        --end if;
        
        sm_tdata <= fifo_axis_tdata;
        
     else
        sm_tdata <= (others => '0');
     end if;   
end process;  

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
       if (s_axis_aresetn = '0') or (active = '0') or ((fifo_axis_tready = '1') and (fifo_axis_tvalid = '1')) then
          rt <= '0';
       elsif (fifo_axis_tready = '1') and (fifo_axis_tvalid = '0') then
          rt <= '1';
       end if;
    end if;
end process;     

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
       if (s_axis_aresetn = '0') or (active = '0') or (rt_clr = '1') then
          p_realtime_lost <= '0';
       elsif (fifo_axis_tready = '1') and (fifo_axis_tvalid = '0') then
          p_realtime_lost <= '1';
       end if;
       realtime_lost <= p_realtime_lost;
    end if;
end process;       

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
        waiting_arm_re <= waiting_arm and not t1_waiting_arm;
        t1_waiting_arm <= waiting_arm;
        t1_armed       <= armed;
        armed_re       <= armed and not t1_armed;
        if (s_axis_aresetn = '0') then
           trig_cntr_sclr <= '1';
           armed          <= '0'; 
           mode           <= "00"; 
           data_mode      <= "00"; 
           active         <= '0';
           state <= RESET_STATE;
        else
            case state is
                when RESET_STATE =>
                    trig_cntr_sclr <= '1';
                    armed          <= '0';
                    mode           <= "00"; 
                    data_mode      <= "00";
                    active         <= '0';
                    waiting_arm    <= '0';
                    if (s_axis_aresetn = '0') then
                       state <= RESET_STATE;
                    elsif (trig_clear = '0') then 
                       state <= WAIT_TRIG_ARMED; 
                    end if;
                when WAIT_TRIG_ARMED =>
                    trig_cntr_sclr <= '0';
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
                    --if  (((t4_mux_gate = '0') and (t3_trig_dly_cntr_tc = '1')) or (trig_clear = '1')) and ((active = '1') or (t4_trig_cntr_ld = '1')) then
                    if  (((t4_mux_gate = '0') and ((t4_trig_dly_cntr_tc = '1') or (retrig= '1'))) or (trig_clear = '1')) and ((active = '1') or (t4_trig_cntr_ld = '1')) then
                        active <= '0'; 
                        trig_cntr_sclr <= trig_clear;       
                        if (stay_armed = '0') or (trig_clear = '1') or (disarm = '1') then
                            state <= RESET_STATE;
                        else    
                            state <= TRIG_ARMED_STATE;
                        end if;             
                    elsif (t4_mux_gate = '1') then        
                        active    <= '1';  
                    else    
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

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
       m_axis_pdti_tdata  <= sm_tdata;
       m_axis_pdti_tvalid <= out_dval;
       t5_mux_gate <= t4_mux_gate;
       m_axis_pdti_tuser(64) <= t5_mux_gate;
       m_axis_pdti_tuser(72) <= t4_s_axis_pctl_tdata(1) or sync_ff;
       m_axis_pdti_tuser(80) <= t4_s_axis_pctl_tdata(2) or pps_ff;
       m_axis_pdti_tuser(95) <= data_mode(0) and not data_mode(1);
       if  (out_dval = '1') then
         sync_ff <= '0';
       elsif (t4_s_axis_pctl_tdata(1) = '1') and (out_dval = '0') then
         sync_ff <= '1';
       end if; 
       if  (out_dval = '1') then
         pps_ff <= '0';
       elsif (t4_s_axis_pctl_tdata(2) = '1') and (out_dval = '0') then
         pps_ff <= '1';
       end if; 
    end if;
end process; 

--m_axis_pdti_tvalid <= '1';

    -- tuser[63:0]    = timestamp[63:0] -- all zero not supported here
    -- tuser[71:64]   = Gate Positions  -- Only [64] is used here
    -- tuser[79:72]   = Sync Positions  -- Only [72] is used here    
    -- tuser[87:80]   = PPS Positions   -- Only [80] is used here
    -- tuser[92:88]   = Samples/Cycle   
    -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3=32 bit
    -- tuser[95]      = Data Type 0 = Real 1 = I/Q
    -- tuser[103:96]  = channel[7:0] 
    -- tuser[127:104] = Reserved 

m_axis_pdti_tuser(63 downto 0) <= (others => '0'); 
m_axis_pdti_tuser(71 downto 65) <= (others => '0');
m_axis_pdti_tuser(79 downto 73) <= (others => '0');
m_axis_pdti_tuser(87 downto 81) <= (others => '0');
m_axis_pdti_tuser(92 downto 88) <= "00001";
m_axis_pdti_tuser(94 downto 93) <= "01";
m_axis_pdti_tuser(127 downto 96) <= (others => '0'); 


end Behavioral;
