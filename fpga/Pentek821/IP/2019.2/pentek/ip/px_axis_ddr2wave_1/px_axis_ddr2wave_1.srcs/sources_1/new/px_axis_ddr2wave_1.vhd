----------------------------------------------------------------------------------
-- Pentek DDR4 SDRAM to DAC wave Module 
----------------------------------------------------------------------------------
-- px_axis_ddr2wave_1.vhd
--
-- Target Device: Kintex UltraScale
--
-- Pentek Inc.
-- One Park Way, Upper Saddle River, NJ 07458
-- (201)818-5900
-- www.pentek.com
--
-- Copyright Pentek, Inc. 2016
--
-- Revision:
-- Revision 1.0 - File Created
-- Revision 2.0 - 3/25/2017 Added Linked List support

-- Additional Comments: 
-- This core can generate DAC waveforms from DDR4 SDRAM and create a data stream
-- to the DAC.  It uses a linked list with up to 128 link descriptors to 
-- define trigger delay,length, and DDR4 address range.   
-- This core supports only single sample per cycle data streams
-- with either a two 16 bit real values, or 16-bit I/Q packed. 

-- Register Map
-- 0x00 Mode Control                    R/W   
-- 0x04 Trigger Clear                   R/W  
-- 0x08 Linked List Start Address Load  R/W
-- 0x0C Linked List Start Address       R/W
-- 0x10 FIFO Flush                      R/W
-- 0x14 Output Rate Div                 R/W
-- 0x18 Output Gate Delay               R/W
-- 0x1C                                 R/W
-- 0x20 Status                          RO
-- 0x24 Current Link/Next Link          RO 
-- 0x28 
-- 0x2C 
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
            -- "01" = Channel Packed I/Q Data or two channel Real (Q(0), I(0)) 
            -- "10" = Reserved
            -- "11" = Reserved
-- Bit [6]  -- local gate reg mode
-- Bit [7]  -- Local gate register bit 
-- Linked List Start Address Load  Register
-- Bit [0]  -- Load LL Start Address
-- Linked List Start Address Load  Register
-- Bit [5:0] -- LL Start Address 
-- Trigger Clear Register
-- Bit [0] - Trigger Clear
-- Bit [1] - Disarm after trigger ends
-- FIFO Flush Register
-- Bit [0] - FIFO Flush
-- Current Link/Next Link Register
-- [5:0] - Current Link
-- [21:16] - Next Link   

-- Interrupts
-- Bit [0] Start of Acquisition
-- Bit [1] End of Acquisition
-- Bit [2] Waiting for Arm Rising Edge
-- Bit [3] Armed Rising Edge
-- Bit [4] Trig Start
-- Bit [5] Link Start Interrupt
-- Bit [6] Link End Interrupt
-- Bit [7] Bad Trigger - trigger occured before acq. ended
-- Bit [8] Real Time Lost 
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

entity px_axis_ddr2wave_1 is
generic ( 
    ddr4_requestor_id: integer := 0
);
port (   
    ----------------------------------------------------------------------------
    -- Control/Status Registers (AXI-LITE)
    ----------------------------------------------------------------------------
    s_axi_csr_aclk           : in  std_logic;
    -- associated with s_axi_aclk
    s_axi_csr_aresetn        : in  std_logic;
    s_axi_csr_awaddr         : in  std_logic_vector(11 downto 0);
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
    s_axi_csr_araddr         : in  std_logic_vector(11 downto 0);
    s_axi_csr_arprot         : in  std_logic_vector(2 downto 0);
    s_axi_csr_arvalid        : in  std_logic;
    s_axi_csr_arready        : out std_logic;
    s_axi_csr_rdata          : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp          : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid         : out std_logic;
    s_axi_csr_rready         : in  std_logic;
    
    irq                      : out std_logic; -- Interrupt out
    ----------------------------------------------------------------------------
    -- DDR4 Request Interface (AXI Stream)
    ----------------------------------------------------------------------------  
    -- tuser[127:0] = Request Header
    -- tuser[31:0]  = Address (Address must be aligned to 64-byte boundaries 5:0 = 000000)
    -- tuser[34:32] = Future Address Expansion
    -- tuser[35]    = Read = 1, Write = 0
    -- tuser[39:36] = Reserved
    -- tuser[119:40]= Byte Masks
    -- tuser[255:128] = Upper 128-bits of RAM Data 
    m_axis_ddr_aclk          : in  std_logic; 
    m_axis_ddr_rqst_tvalid   : out std_logic;
    m_axis_ddr_rqst_tready   : in  std_logic;   
    m_axis_ddr_rqst_tlast    : out std_logic;
    m_axis_ddr_rqst_tid      : out std_logic_vector(7 downto 0);
    m_axis_ddr_rqst_tdata    : out std_logic_vector(511 downto 0); 
    m_axis_ddr_rqst_tuser    : out std_logic_vector(255 downto 0);
    ----------------------------------------------------------------------------
    -- DDR4 Response Interface (AXI Stream)
    ----------------------------------------------------------------------------
    -- tuser[127:0] = Response Header
    -- tuser[31:0]  = Address (Address must be aligned to 64-byte boundaries 5:0 = 000000)
    -- tuser[34:32] = Future Address Expansion
    -- tuser[39:36] = Reserved
    -- tuser[119:40]= Byte Masks 
   -- tuser[255:128] = Upper 128-bits of RAM Data 
    s_axis_ddr_rsp_tvalid    : in  std_logic;
    s_axis_ddr_rsp_tlast     : in  std_logic;
    s_axis_ddr_rsp_tid       : in  std_logic_vector(7 downto 0);
    s_axis_ddr_rsp_tdata     : in  std_logic_vector(511 downto 0); 
    s_axis_ddr_rsp_tuser     : in  std_logic_vector(255 downto 0);
    -----------------------------------------------------------------------------
    s_axis_aclk              : in  std_logic; -- AXI Stream Clock
    s_axis_aresetn           : in  std_logic;
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
    m_axis_pdti_tvalid       : out std_logic; 
    m_axis_pdti_tdata        : out std_logic_vector(31 downto 0);
    m_axis_pdti_tuser        : out std_logic_vector(127 downto 0);
    ----------------------------------------------------------------------------
    -- Real Time Lost Status
    ----------------------------------------------------------------------------
    realtime_lost            : out std_logic
);
end px_axis_ddr2wave_1;

architecture Behavioral of px_axis_ddr2wave_1 is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

COMPONENT px_ddr2wave_1_out_fifo
  PORT (
    m_aclk : IN STD_LOGIC;
    s_aclk : IN STD_LOGIC;
    s_aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
    s_axis_tkeep : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    s_axis_tlast : IN STD_LOGIC;
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
    m_axis_tkeep : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
    m_axis_tlast : OUT STD_LOGIC
  );
END COMPONENT;

-- AXI_S Width Converter
-- 512 in
-- 32 out
COMPONENT px_ddr2wave_1_wcnv
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
    s_axis_tkeep : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    s_axis_tlast : IN STD_LOGIC;
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_tkeep : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    m_axis_tlast : OUT STD_LOGIC
  );
END COMPONENT;

-- Control/Status Registers
component px_axis_ddr2wave_1_csr
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    axis_aclk             : in  std_logic; -- AXI-Stream Clock for clock domain crossing

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
    fifo_flush            : out std_logic;
    local_gate_mode       : out std_logic; 
    local_gate            : out std_logic; 
    rate_div              : out std_logic_vector(15 downto 0); 
    output_gate_delay     : out std_logic_vector(7 downto 0);
    ll_start_address      : out std_logic_vector(5 downto 0); 
    ll_start              : out std_logic;
    rt_clr                : out std_logic; 
--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------     
    waiting_arm  	        : in  std_logic;     
    armed                 : in  std_logic;
    active                : in  std_logic;
    mode                  : in  std_logic_vector(1 downto 0);
    data_mode             : in  std_logic_vector(1 downto 0);
    current_link          : in  std_logic_vector(5 downto 0);
    next_link             : in  std_logic_vector(5 downto 0);
 --------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------    
    acq_start             : in  std_logic;  
    acq_end               : in  std_logic;  
    waiting_arm_re        : in  std_logic;  
    armed_re              : in  std_logic;
    real_time_lost        : in  std_logic;
    bad_trig              : in  std_logic;
    trig_start            : in  std_logic;
    le_int                : in  std_logic;
    ls_int                : in  std_logic
    );
end component;

-- Independent Clock AXI-S FIFO
-- AFL = 511

COMPONENT px_ddr2wave_1_rqst_fifo
  PORT (
    m_aclk : IN STD_LOGIC;
    s_aclk : IN STD_LOGIC;
    s_aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
  );
END COMPONENT;

-- RAM Based Shift Register
-- Variable lossless
-- Registered output
-- Speed
COMPONENT px_ddr2wave_1_dly
  PORT (
    A : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    D : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    CLK : IN STD_LOGIC;
    Q : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
  );
END COMPONENT;

-- RAM Based Shift Register
-- fixed 32 delay
-- Registered output
-- Speed
COMPONENT px_ddr2wave_1_ddly
  PORT (
    D : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    CE: IN STD_LOGIC;
    CLK : IN STD_LOGIC;
    Q : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
  );
END COMPONENT;

component px_axis_ddr2wave_1_dwncntr
port ( 
    clk     : in  std_logic;
    sclr    : in  std_logic;
    ce      : in  std_logic;
    ld      : in  std_logic; -- qualified by ce
    ld_val  : in  std_logic_vector(31 downto 0);
    tc      : out std_logic;
    count   : out std_logic_vector(31 downto 0)  
);
end component;

-- latency = 2
COMPONENT px_axis_ddr2wave1_bramctlr
  PORT (
    s_axi_aclk : IN STD_LOGIC;
    s_axi_aresetn : IN STD_LOGIC;
    s_axi_awaddr : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    s_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_awvalid : IN STD_LOGIC;
    s_axi_awready : OUT STD_LOGIC;
    s_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_wvalid : IN STD_LOGIC;
    s_axi_wready : OUT STD_LOGIC;
    s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_bvalid : OUT STD_LOGIC;
    s_axi_bready : IN STD_LOGIC;
    s_axi_araddr : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    s_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_arvalid : IN STD_LOGIC;
    s_axi_arready : OUT STD_LOGIC;
    s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_rvalid : OUT STD_LOGIC;
    s_axi_rready : IN STD_LOGIC;
    bram_rst : OUT STD_LOGIC;
    bram_clk : OUT STD_LOGIC;
    bram_en : OUT STD_LOGIC;
    bram_we : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    bram_addr : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
    bram_wrdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    bram_rddata : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

-- AXI-Lite X-BAR 
COMPONENT px_axis_ddr2wave1_xbar
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axi_awaddr : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    s_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_awvalid : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_awready : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_wvalid : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_wready : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_bvalid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_bready : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_araddr : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    s_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_arvalid : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_arready : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_rvalid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_rready : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axi_awaddr : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
    m_axi_awprot : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
    m_axi_awvalid : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_awready : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_wdata : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
    m_axi_wstrb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    m_axi_wvalid : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_wready : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_bresp : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    m_axi_bvalid : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_bready : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_araddr : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
    m_axi_arprot : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
    m_axi_arvalid : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_arready : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_rdata : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    m_axi_rresp : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    m_axi_rvalid : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_rready : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
  );
END COMPONENT;

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
constant TIME_PACKED_MODE : std_logic_vector(1 downto 0) := "00";
constant CHAN_PACKED_MODE : std_logic_vector(1 downto 0) := "01";

--------------------------------------------------------------------------------
-- Functions
--------------------------------------------------------------------------------

function negate_vctr64 (l : STD_LOGIC_VECTOR(63 downto 0)) return STD_LOGIC_VECTOR is
variable result : STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
begin
for i in l'reverse_range loop
  result(i) :=  not l(i);
end loop;
return result;
end function negate_vctr64;

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";
	
ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr:s_axis_pd";

ATTRIBUTE X_INTERFACE_INFO of s_axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_aclk: SIGNAL is "ASSOCIATED_BUSIF m_axis_pdti:s_axis_pctl";

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
signal t5x_mux_gate     : std_logic := '0';
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
signal t4_trig_dly_cntr_tc: std_logic := '0';
signal local_gate_mode   : std_logic := '0'; 
signal local_gate        : std_logic := '0'; 
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
signal sm_tdata          : std_logic_vector(31 downto 0) := (others => '0');
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
signal rqst_ce           : std_logic := '0';
signal t1_active         : std_logic := '0';
signal data_cntr         : std_logic_vector(3 downto 0) := (others => '0');
signal rqst_addr         : std_logic_vector(31 downto 0) := (others => '0');
signal tx_rqst_addr      : std_logic_vector(31 downto 0) := (others => '0');
signal r_addr            : std_logic_vector(31 downto 0) := (others => '0');
signal ddr_strt_addr     : std_logic_vector(31 downto 0) := (others => '0');
signal ddr_end_addr      : std_logic_vector(31 downto 0) := (others => '0');
signal ddr_strt_addrx    : std_logic_vector(31 downto 0) := (others => '0');
signal ddr_end_addrx     : std_logic_vector(31 downto 0) := (others => '0');
signal p_ddr_strt_addr   : std_logic_vector(31 downto 0) := (others => '0');
signal p_ddr_end_addr    : std_logic_vector(31 downto 0) := (others => '0');
signal ltch_ddr_end_addr : std_logic_vector(31 downto 0) := (others => '0');
signal rqst_tvalid       : std_logic := '0';
signal rqst_byte_en      : std_logic_vector(63 downto 0) := (others => '0');
signal rqstout_tdata     : std_logic_vector(127 downto 0) := (others => '0');
signal rqst_tready       : std_logic := '0';
signal rqst_tdata        : std_logic_vector(127 downto 0) := (others => '0');
signal t1_s_axis_ddr_rsp_tvalid: std_logic := '0';
signal t1_s_axis_ddr_rsp_tlast : std_logic := '0';
signal t1_s_axis_ddr_rsp_tid   : std_logic_vector(7 downto 0) := (others => '0');
signal t1_s_axis_ddr_rsp_tdata : std_logic_vector(511 downto 0) := (others => '0');
signal t1_s_axis_ddr_rsp_tuser : std_logic_vector(255 downto 0) := (others => '0');
signal fifo_in_tvalid    : std_logic := '0';
signal fifo_in_tkeep     : std_logic_vector(63 downto 0) := (others => '0');
signal fifo_in_tdata     : std_logic_vector(511 downto 0) := (others => '0');
signal fifo_out_tvalid   : std_logic := '0';
signal fifo_out_tready   : std_logic := '0';
signal fifo_out_tkeep    : std_logic_vector(63 downto 0) := (others => '0');
signal fifo_out_tdata    : std_logic_vector(511 downto 0) := (others => '0');
signal tkeep_n           : std_logic_vector(63 downto 0) := (others => '0');
signal rqst_ovfl         : std_logic := '0';
signal output_gate_delay : std_logic_vector(7 downto 0) := (others => '0');
signal dly_in            : std_logic_vector(8 downto 0) := (others => '0');
signal dly_out           : std_logic_vector(8 downto 0) := (others => '0');
signal p_dly_out         : std_logic_vector(8 downto 0) := (others => '0');
signal pdly_out          : std_logic_vector(8 downto 0) := (others => '0');
signal dly_pack_cntr     : std_logic := '0';       
signal dly_data_mode     : std_logic_vector(1 downto 0) := (others => '0');       
signal dly_t4_s_axis_pctl_tdata2: std_logic := '0'; 
signal dly_t4_s_axis_pctl_tdata1: std_logic := '0'; 
signal dly_t4_mux_gate   : std_logic := '0';        
signal dly_mux_sel       : std_logic := '0';        
signal dly_active        : std_logic := '0';        
signal t1_dly_active     : std_logic := '0';     
signal t1_dly_pack_cntr  : std_logic := '0';     
signal t1_pack_cntr      : std_logic := '0';  
signal t1_data_cntr      : std_logic_vector(3 downto 0) := (others => '0');
signal p_realtime_lost   : std_logic := '0'; 
signal p_csr_irq         : std_logic := '0'; 
signal l_valid           : std_logic := '0'; 
signal rt_clr            : std_logic := '0';
signal sync_re           : std_logic := '0';
signal x_fifo_flush_n    : std_logic := '0';
signal out_dval          : std_logic := '0';
signal dly_out_dval      : std_logic := '0';
signal sync_ff           : std_logic := '0';
signal pps_ff            : std_logic := '0';
signal x_fifo_aresetn    : std_logic := '0';
signal dlyce             : std_logic := '0';
signal sff               : std_logic := '0';
signal pff               : std_logic := '0';
signal retrig            : std_logic := '0';
signal t1_retrig         : std_logic := '0';
signal t2_retrig         : std_logic := '0';
signal ll_start_address  : std_logic_vector(5 downto 0) := (others => '0');
signal ll_start          : std_logic := '0';
signal t1_s_axi_csr_aresetn: std_logic := '0';
signal axi_xbar_awaddr     : std_logic_vector(23 downto 0) := (others => '0');
signal axi_xbar_awprot     : std_logic_vector(5 downto 0) := (others => '0');
signal axi_xbar_awvalid    : std_logic_vector(1 downto 0) := (others => '0');
signal axi_xbar_awready    : std_logic_vector(1 downto 0) := (others => '0');
signal axi_xbar_wdata      : std_logic_vector(63 downto 0) := (others => '0');
signal axi_xbar_wstrb      : std_logic_vector(7 downto 0) := (others => '0');
signal axi_xbar_wvalid     : std_logic_vector(1 downto 0) := (others => '0');
signal axi_xbar_wready     : std_logic_vector(1 downto 0) := (others => '0');
signal axi_xbar_bresp      : std_logic_vector(3 downto 0) := (others => '0');
signal axi_xbar_bvalid     : std_logic_vector(1 downto 0) := (others => '0');
signal axi_xbar_bready     : std_logic_vector(1 downto 0) := (others => '0');
signal axi_xbar_araddr     : std_logic_vector(23 downto 0) := (others => '0');
signal axi_xbar_arprot     : std_logic_vector(5 downto 0) := (others => '0');
signal axi_xbar_arvalid    : std_logic_vector(1 downto 0) := (others => '0');
signal axi_xbar_arready    : std_logic_vector(1 downto 0) := (others => '0');
signal axi_xbar_rdata      : std_logic_vector(63 downto 0) := (others => '0');
signal axi_xbar_rresp      : std_logic_vector(3 downto 0) := (others => '0');
signal axi_xbar_rvalid     : std_logic_vector(1 downto 0) := (others => '0');
signal axi_xbar_rready     : std_logic_vector(1 downto 0) := (others => '0');
signal bram_rst            : std_logic := '0';                  
signal bram_clk            : std_logic := '0';                 
signal bram_en             : std_logic := '0';                 
signal bram_we             : std_logic_vector(3 downto 0) := (others => '0');
signal bram_addr           : std_logic_vector(8 downto 0) := (others => '0');
signal bram_wrdata         : std_logic_vector(31 downto 0) := (others => '0');
signal bram_rddata         : std_logic_vector(31 downto 0) := (others => '0');
signal link_addr           : std_logic_vector(5 downto 0) := (others => '0');
signal link_descriptor     : std_logic_vector(255 downto 0) := (others => '0');
signal p_disarm_at_end     : std_logic := '0'; 
signal disarm_at_end       : std_logic := '0';
signal current_link        : std_logic_vector(5 downto 0) := (others => '0');
signal next_link           : std_logic_vector(5 downto 0) := (others => '0');
signal t1_ll_start         : std_logic := '0';
signal t2_ll_start         : std_logic := '0';
signal t3_ll_start         : std_logic := '0';
signal t2_ll_adv           : std_logic := '0';
signal trig_start          : std_logic := '0';
signal p_int_at_link_end   : std_logic := '0';
signal int_at_link_end     : std_logic := '0';
signal t1_int_at_link_end  : std_logic := '0';
signal le_int              : std_logic := '0';
signal t1_le_int           : std_logic := '0';
signal le_int_re           : std_logic := '0';
signal ls_int              : std_logic := '0';
signal bad_trig            : std_logic := '0';
signal t1_bad_trig         : std_logic := '0';
--------------------------------------------------------------------------------

begin
 
--fifo_aresetn <= not fifo_flush;
 
flsh_cdc_inst: xpm_cdc_sync_rst
   generic map (
     -- Common module parameters
     DEST_SYNC_FF    => 3, -- integer; range: 2-10
     INIT            => 0, -- integer; 0=initialize synchronization registers to 0,
                           --          1=initialize synchronization registers to 1
     SIM_ASSERT_CHK  => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
     src_rst  => fifo_aresetn,
     dest_clk => m_axis_ddr_aclk,
     dest_rst => x_fifo_aresetn
  );

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
      fifo_aresetn <= not fifo_flush;
   end if;
end process;

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
        t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
   end if;
end process;

--------------------------------------------------------------------------------
-- Control/Status Registers  
--------------------------------------------------------------------------------

xbar_inst : px_axis_ddr2wave1_xbar
  port map (
    aclk             => s_axi_csr_aclk,
    aresetn          => t1_s_axi_csr_aresetn,
    s_axi_awaddr     => s_axi_csr_awaddr,
    s_axi_awprot     => s_axi_csr_awprot,
    s_axi_awvalid(0) => s_axi_csr_awvalid,
    s_axi_awready(0) => s_axi_csr_awready,
    s_axi_wdata      => s_axi_csr_wdata,
    s_axi_wstrb      => s_axi_csr_wstrb,
    s_axi_wvalid(0)  => s_axi_csr_wvalid,
    s_axi_wready(0)  => s_axi_csr_wready,
    s_axi_bresp      => s_axi_csr_bresp,
    s_axi_bvalid(0)  => s_axi_csr_bvalid,
    s_axi_bready(0)  => s_axi_csr_bready,
    s_axi_araddr     => s_axi_csr_araddr,
    s_axi_arprot     => s_axi_csr_arprot,
    s_axi_arvalid(0) => s_axi_csr_arvalid,
    s_axi_arready(0) => s_axi_csr_arready,
    s_axi_rdata      => s_axi_csr_rdata,
    s_axi_rresp      => s_axi_csr_rresp,
    s_axi_rvalid(0)  => s_axi_csr_rvalid,
    s_axi_rready(0)  => s_axi_csr_rready,
    m_axi_awaddr     => axi_xbar_awaddr,
    m_axi_awprot     => axi_xbar_awprot,
    m_axi_awvalid    => axi_xbar_awvalid,
    m_axi_awready    => axi_xbar_awready,
    m_axi_wdata      => axi_xbar_wdata,
    m_axi_wstrb      => axi_xbar_wstrb,
    m_axi_wvalid     => axi_xbar_wvalid,
    m_axi_wready     => axi_xbar_wready,
    m_axi_bresp      => axi_xbar_bresp,
    m_axi_bvalid     => axi_xbar_bvalid,
    m_axi_bready     => axi_xbar_bready,
    m_axi_araddr     => axi_xbar_araddr,
    m_axi_arprot     => axi_xbar_arprot,
    m_axi_arvalid    => axi_xbar_arvalid,
    m_axi_arready    => axi_xbar_arready,
    m_axi_rdata      => axi_xbar_rdata,
    m_axi_rresp      => axi_xbar_rresp,
    m_axi_rvalid     => axi_xbar_rvalid,
    m_axi_rready     => axi_xbar_rready
  );

-- Control/Status Registers
csr_inst: px_axis_ddr2wave_1_csr
port map (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    axis_aclk             => s_axis_aclk,
    
    s_axi_csr_aclk        => s_axi_csr_aclk,                        
    s_axi_csr_aresetn     => t1_s_axi_csr_aresetn,                     
    s_axi_csr_awaddr      => axi_xbar_awaddr(5 downto 0),          
    s_axi_csr_awprot      => axi_xbar_awprot(2 downto 0),                      
    s_axi_csr_awvalid     => axi_xbar_awvalid(0),                     
    s_axi_csr_awready     => axi_xbar_awready(0),                     
    s_axi_csr_wdata       => axi_xbar_wdata(31 downto 0),                       
    s_axi_csr_wstrb       => axi_xbar_wstrb(3 downto 0),                       
    s_axi_csr_wvalid      => axi_xbar_wvalid(0),                      
    s_axi_csr_wready      => axi_xbar_wready(0),                      
    s_axi_csr_bresp       => axi_xbar_bresp(1 downto 0),                       
    s_axi_csr_bvalid      => axi_xbar_bvalid(0),                      
    s_axi_csr_bready      => axi_xbar_bready(0),                      
    s_axi_csr_araddr      => axi_xbar_araddr(5 downto 0),          
    s_axi_csr_arprot      => axi_xbar_arprot(2 downto 0),                      
    s_axi_csr_arvalid     => axi_xbar_arvalid(0),                     
    s_axi_csr_arready     => axi_xbar_arready(0),                     
    s_axi_csr_rdata       => axi_xbar_rdata(31 downto 0),                       
    s_axi_csr_rresp       => axi_xbar_rresp(1 downto 0),                       
    s_axi_csr_rvalid      => axi_xbar_rvalid(0),                      
    s_axi_csr_rready      => axi_xbar_rready(0),                      
    
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
    fifo_flush            => fifo_flush,
    local_gate_mode       => local_gate_mode,     
    local_gate            => local_gate,
    rate_div              => rate_div,
    output_gate_delay     => output_gate_delay,
    ll_start_address      => ll_start_address,
    ll_start              => ll_start,
    rt_clr                => rt_clr,
--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------     
    waiting_arm  	        => waiting_arm,
    armed                 => armed,      
    active                => active,     
    mode                  => mode,       
    data_mode             => data_mode, 
    current_link          => current_link,
    next_link             => next_link,
 --------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------    
    acq_start             => acq_start,       
    acq_end               => acq_end,         
    waiting_arm_re        => waiting_arm_re,  
    armed_re              => armed_re,
    real_time_lost        => rt,
    bad_trig              => t1_bad_trig, -- trigger occured before last acq was complete
    trig_start            => trig_start,
    le_int                => le_int_re, -- link end interrupt  
    ls_int                => ls_int  -- link start interrupt                      
    );
  

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
        irq <= p_csr_irq;
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
      trig_start   <= t2_trig_re;
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
t2_ll_adv           <= '1' when ((t2_trig_re = '1') and (armed = '1')) else '0';

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then   
      t4_trig_dly_cntr_tc  <= t3_trig_dly_cntr_tc;
      --trig_cntr_ld_val     <= trig_len(31 downto 0);
      --trig_dly_cntr_ld_val <= trig_dly(31 downto 0); 
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

dwncntr_dly_inst: px_axis_ddr2wave_1_dwncntr 
port map ( 
    clk     => s_axis_aclk,
    sclr    => trig_cntr_sclr,
    ce      => t2_trig_dly_cntr_ce,
    ld      => t2_trig_cntr_ld,
    ld_val  => trig_dly_cntr_ld_val,
    tc      => t3_trig_dly_cntr_tc,
    count   => dly_count 
);

dwncntr_inst: px_axis_ddr2wave_1_dwncntr 
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

sync_re <= t4_mux_gate and not t5x_mux_gate;

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

pack_cntr <= mux_sel when (rate_div_cntr = (x"0000")) else '0'; 

retrig  <= t4_trig_cntr_ld and active;



process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
        t1_le_int  <= le_int;
        le_int_re  <= le_int and not t1_le_int;
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
                    le_int         <= '0';  
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
                    --if  (((t4_mux_gate = '0') and ((t3_trig_dly_cntr_tc = '1') or (retrig= '1'))) or (trig_clear = '1')) and ((active = '1') or (t4_trig_cntr_ld = '1')) then
                    if  (((t4_mux_gate = '0') and ((t4_trig_dly_cntr_tc = '1') or (retrig= '1'))) or (trig_clear = '1')) and ((active = '1') or (t4_trig_cntr_ld = '1')) then
                        active <= '0'; 
                        trig_cntr_sclr <= trig_clear;       
                        if (stay_armed = '0') or (trig_clear = '1') or (disarm = '1') or (disarm_at_end = '1') then
                            state <= RESET_STATE;
                        else    
                            state <= TRIG_ARMED_STATE;
                        end if;             
                        le_int <= t1_int_at_link_end;
                    elsif (t4_mux_gate = '1') then        
                        active    <= '1';  
                        le_int    <= t2_ll_adv and t1_int_at_link_end; 
                    else    
                        if (trig_clear = '1') or (disarm = '1') then
                            state <= RESET_STATE;
                        else 
                            state <= TRIG_ARMED_STATE;
                        end if;    
                        le_int <= t1_int_at_link_end;
                    end if;     
                when others =>
                   state <= RESET_STATE;
            end case;    
        end if;
     end if;
end process;

--------------------------------------------------------------------------------
-- DDR4 Request Generation
--------------------------------------------------------------------------------
-- Depending on the DATA_MODE, we need to request one 512-bit DDR4 read for
-- every 16 output samples.  Because we don't know when a gate in going
-- to end ahead of time, we must wait every 16 gated clock cycles, or until
-- the gate ends (whichever comes first) before generating a DDR4 Read Request.
-- In that way we know exactly how much data to request (number of TKEEPS).  
-- The actual gate is applied to the output FIFO after a programmable delay
-- that is greater than max DDR4 latency.
 
rqst_ce <= active and pack_cntr;

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
       t1_retrig    <= retrig;
       t2_retrig    <= t1_retrig;
       t1_pack_cntr <= pack_cntr;
       t1_data_cntr <= data_cntr;
       t1_active <= active;
       if (s_axis_aresetn = '0') or (active = '0') then 
         data_cntr <= "0000";
       elsif (t1_retrig = '1') then
         data_cntr <= "0001";
       elsif rqst_ce = '1' then
         data_cntr <= data_cntr + 1;  
       end if;
       if (s_axis_aresetn = '0') or (active = '0') or (t1_retrig = '1') or (rqst_addr(31 downto 6) = ltch_ddr_end_addr(31 downto 6)) then
         ltch_ddr_end_addr <= ddr_end_addr;
         rqst_addr <= ddr_strt_addr(31 downto 6) & "000000";
         tx_rqst_addr <= rqst_addr;
       else
          if (rqst_tvalid = '1') and  (t2_retrig = '0') then
            rqst_addr <= rqst_addr + 64;
          end if;
       end if;  
       if (rqst_ce = '1') and (data_cntr(3 downto 0) = "1111") then
          rqst_tvalid  <= '1';  
          rqst_byte_en <= x"0000000000000000";
          l_valid <= '0';
       elsif ((((t1_active = '1') and (active = '0')) or (t1_retrig = '1')) and ((t1_data_cntr(3 downto 0) /= "1111") or (t1_pack_cntr = '0'))) then
          rqst_tvalid  <= '1'; 
          l_valid <= '1';
          case t1_data_cntr(3 downto 0) is
              when "0000" => 
                  rqst_byte_en <= x"FFFFFFFFFFFFFFF0";
              when "0001" => 
                  rqst_byte_en <= x"FFFFFFFFFFFFFF00";
              when "0010" => 
                  rqst_byte_en <= x"FFFFFFFFFFFFF000";
              when "0011" => 
                  rqst_byte_en <= x"FFFFFFFFFFFF0000";
              when "0100" => 
                  rqst_byte_en <= x"FFFFFFFFFFF00000";
              when "0101" => 
                  rqst_byte_en <= x"FFFFFFFFFF000000";
              when "0110" => 
                  rqst_byte_en <= x"FFFFFFFFF0000000";
              when "0111" => 
                  rqst_byte_en <= x"FFFFFFFF00000000";
              when "1000" => 
                  rqst_byte_en <= x"FFFFFFF000000000";
              when "1001" => 
                  rqst_byte_en <= x"FFFFFF0000000000";
              when "1010" => 
                  rqst_byte_en <= x"FFFFF00000000000";
              when "1011" => 
                  rqst_byte_en <= x"FFFF000000000000";
              when "1100" => 
                  rqst_byte_en <= x"FFF0000000000000";
              when "1101" => 
                  rqst_byte_en <= x"FF00000000000000";
              when "1110" => 
                  rqst_byte_en <= x"F000000000000000";
              when "1111" => 
                  rqst_byte_en <= x"0000000000000000";     
              when others =>
                  rqst_byte_en <= x"0000000000000000";                                                   
          end case;
       else
          l_valid <= '0';
          rqst_tvalid  <= '0';  
          rqst_byte_en <= x"0000000000000000";  
       end if;
       rqst_ovfl <= rqst_tvalid and not rqst_tready;
    end if;
end process;

-- Request Construction

    -- tuser[127:0] = Request Header
    -- tuser[31:0]  = Address (Address must be aligned to 64-byte boundaries 5:0 = 000000)
    -- tuser[34:32] = Future Address Expansion
    -- tuser[35]    = Read = 1, Write = 0
    -- tuser[39:36] = Reserved
    -- tuser[119:40]= Byte Masks
    -- tuser[255:128] = Upper 128-bits of RAM Data 
--    m_axis_ddr_aclk          : in  std_logic; 
--    m_axis_ddr_rqst_tvalid   : out std_logic;
--    m_axis_ddr_rqst_tready   : in  std_logic;   
--    m_axis_ddr_rqst_tlast    : out std_logic;
--    m_axis_ddr_rqst_tid      : out std_logic_vector(7 downto 0);
--    m_axis_ddr_rqst_tdata    : out std_logic_vector(511 downto 0); 
--    m_axis_ddr_rqst_tuser    : out std_logic_vector(255 downto 0);

r_addr <= rqst_addr when (l_valid = '0') else tx_rqst_addr;

rqst_tdata  <= x"00FFFF" & rqst_byte_en & "0000" & '1' & "000" & r_addr ;


-- Output Request FIFO (Crosses Clock Domains to DDR4 Clock)

rqst_fifo_inst : px_ddr2wave_1_rqst_fifo
port map (
    m_aclk          => m_axis_ddr_aclk,
    s_aclk          => s_axis_aclk,
    s_aresetn       => fifo_aresetn, --s_axis_aresetn,
    s_axis_tvalid   => rqst_tvalid,
    s_axis_tready   => rqst_tready,
    s_axis_tdata    => rqst_tdata,
    m_axis_tvalid   => m_axis_ddr_rqst_tvalid,
    m_axis_tready   => m_axis_ddr_rqst_tready,
    m_axis_tdata    => rqstout_tdata
  );

m_axis_ddr_rqst_tuser  <= x"00000000000000000000000000000000" & rqstout_tdata;
m_axis_ddr_rqst_tdata  <= x"00000000000000000000000000000000" & x"00000000000000000000000000000000" &
                          x"00000000000000000000000000000000" & x"00000000000000000000000000000000";                
m_axis_ddr_rqst_tid    <= conv_std_logic_vector(ddr4_requestor_id, 8);
m_axis_ddr_rqst_tlast  <= '1';

--------------------------------------------------------------------------------
-- DDR4 Responses
--------------------------------------------------------------------------------

    -- tuser[127:0] = Response Header
    -- tuser[31:0]  = Address (Address must be aligned to 64-byte boundaries 5:0 = 000000)
    -- tuser[34:32] = Future Address Expansion
    -- tuser[39:36] = Reserved
    -- tuser[119:40]= Byte Masks 
    -- tuser[255:128] = Upper 128-bits of RAM Data 
    --s_axis_ddr_rsp_tvalid    : in  std_logic;
    --s_axis_ddr_rsp_tlast     : in  std_logic;
    --s_axis_ddr_rsp_tid       : in  std_logic_vector(7 downto 0);
    --s_axis_ddr_rsp_tdata     : in  std_logic_vector(511 downto 0); 
    --s_axis_ddr_rsp_tuser     : in  std_logic_vector(255 downto 0);
    
-- AXI-S Register Slice     
process(m_axis_ddr_aclk)
begin
   if rising_edge(m_axis_ddr_aclk) then
      t1_s_axis_ddr_rsp_tvalid <= s_axis_ddr_rsp_tvalid;
      t1_s_axis_ddr_rsp_tlast  <= s_axis_ddr_rsp_tlast;
      t1_s_axis_ddr_rsp_tid    <= s_axis_ddr_rsp_tid;  
      t1_s_axis_ddr_rsp_tdata  <= s_axis_ddr_rsp_tdata;
      t1_s_axis_ddr_rsp_tuser  <= s_axis_ddr_rsp_tuser;
   end if;
end process;   

tkeep_n <= t1_s_axis_ddr_rsp_tuser(103 downto 40);
fifo_in_tvalid <= t1_s_axis_ddr_rsp_tvalid when (t1_s_axis_ddr_rsp_tid = conv_std_logic_vector(ddr4_requestor_id,8)) else '0';
fifo_in_tkeep  <= (negate_vctr64(tkeep_n));
fifo_in_tdata  <= t1_s_axis_ddr_rsp_tdata;
 
--------------------------------------------------------------------------------
-- Output FIFO
--------------------------------------------------------------------------------

output_fifo : px_ddr2wave_1_out_fifo
port map (
    m_aclk          => s_axis_aclk,
    s_aclk          => m_axis_ddr_aclk,
    s_aresetn       => x_fifo_aresetn,
    s_axis_tvalid   => fifo_in_tvalid,
    s_axis_tready   => open,
    s_axis_tdata    => fifo_in_tdata,
    s_axis_tkeep    => fifo_in_tkeep,
    s_axis_tlast    => '1',
    m_axis_tvalid   => fifo_out_tvalid,
    m_axis_tready   => fifo_out_tready,
    m_axis_tdata    => fifo_out_tdata,
    m_axis_tkeep    => fifo_out_tkeep,
    m_axis_tlast    => open
);

--------------------------------------------------------------------------------
-- Output Width Conversion
--------------------------------------------------------------------------------
-- The Data width is converted from 512-bit to 32-bit.
-- Any invalid data bytes are removed from the stream

wcnv_inst : px_ddr2wave_1_wcnv
port map (
    aclk                => s_axis_aclk,
    aresetn             => fifo_aresetn,
    s_axis_tvalid       => fifo_out_tvalid,  
    s_axis_tready       => fifo_out_tready,  
    s_axis_tdata        => fifo_out_tdata,   
    s_axis_tkeep        => fifo_out_tkeep,   
    s_axis_tlast        => '1',   
    m_axis_tvalid       => wcnv_axis_tvalid,
    m_axis_tready       => wcnv_axis_tready,
    m_axis_tdata        => wcnv_axis_tdata,
    m_axis_tkeep        => open,
    m_axis_tlast        => open
    ); 

--------------------------------------------------------------------------------
-- Output Gate Delay
--------------------------------------------------------------------------------
-- We need to delay the active and mux_sel signals long enough for data to 
-- have been returned from the DDR4 RAM.
dly_in <= out_dval & pack_cntr &  data_mode & t4_s_axis_pctl_tdata(2) & t4_s_axis_pctl_tdata(1) & t4_mux_gate & mux_sel & active;

gate_dly_inst : px_ddr2wave_1_dly
port map (
    A   => output_gate_delay,
    D   => dly_in,
    CLK => s_axis_aclk,
    Q   => p_dly_out
);

gate_ddly_inst : px_ddr2wave_1_ddly
port map (
    D   => pdly_out,
    CE  => dlyce, 
    CLK => s_axis_aclk,
    Q   => dly_out
);
dlyce <= p_dly_out(8) or p_dly_out(7);
dly_out_dval                <= dly_out(8) and p_dly_out(8); 
dly_pack_cntr               <= p_dly_out(7) and p_dly_out(7); 
dly_data_mode               <= dly_out(6 downto 5);
dly_t4_s_axis_pctl_tdata2   <= dly_out(4);
dly_t4_s_axis_pctl_tdata1   <= dly_out(3);
dly_t4_mux_gate             <= dly_out(2);
dly_mux_sel                 <= dly_out(1);
dly_active                  <= dly_out(0);

pdly_out <= p_dly_out(8 downto 5) & pff & sff & p_dly_out(2 downto 0);

--------------------------------------------------------------------------------
-- Output
--------------------------------------------------------------------------------

wcnv_axis_tready <= (dly_active and dly_pack_cntr) or (t1_dly_active and (not dly_active) and (not t1_dly_pack_cntr));

process(wcnv_axis_tdata, dly_data_mode, dly_mux_sel, wcnv_axis_tvalid, dly_active)
begin
    if (wcnv_axis_tvalid = '1') and (dly_active = '1') then
        if (dly_data_mode = TIME_PACKED_MODE) then
            if dly_mux_sel = '0' then
                sm_tdata(15 downto 0)    <= wcnv_axis_tdata(15 downto 0);
                sm_tdata(31 downto 16)   <= wcnv_axis_tdata(15 downto 0);
            else
                sm_tdata(15 downto 0)    <= wcnv_axis_tdata(31 downto 16);  
                sm_tdata(31 downto 16)   <= wcnv_axis_tdata(31 downto 16);   
            end if;
        else
            sm_tdata(15 downto 0)     <= wcnv_axis_tdata(15 downto 0);
            sm_tdata(31 downto 16)    <= wcnv_axis_tdata(31 downto 16);
        end if;   
     else
        sm_tdata <= x"00000000";
     end if;   
end process;  

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
       t1_dly_active         <= dly_active;
       t1_dly_pack_cntr      <= dly_pack_cntr;
       m_axis_pdti_tdata     <= sm_tdata;
       m_axis_pdti_tvalid    <= dly_out_dval;
       t5x_mux_gate          <= t4_mux_gate;
       t5_mux_gate           <= dly_t4_mux_gate;
       m_axis_pdti_tuser(64) <= t5_mux_gate;
--       m_axis_pdti_tuser(72) <= dly_t4_s_axis_pctl_tdata1 or sync_ff;
--       m_axis_pdti_tuser(80) <= dly_t4_s_axis_pctl_tdata2 or pps_ff;
--       m_axis_pdti_tuser(95) <= dly_data_mode(0) and not dly_data_mode(1);
--       if  (dly_out_dval = '1') then
--         sync_ff <= '0';
--       elsif (dly_t4_s_axis_pctl_tdata1 = '1') and (dly_out_dval = '0') then
--         sync_ff <= '1';
--       end if; 
--       if  (dly_out_dval = '1') then
--         pps_ff <= '0';
--       elsif (dly_t4_s_axis_pctl_tdata2 = '1') and (dly_out_dval = '0') then
--         pps_ff <= '1';
--       end if; 
      m_axis_pdti_tuser(72) <= dly_t4_s_axis_pctl_tdata1;
      m_axis_pdti_tuser(80) <= dly_t4_s_axis_pctl_tdata2;
      m_axis_pdti_tuser(95) <= dly_data_mode(0) and not dly_data_mode(1);
      if  (p_dly_out(8) = '1') then
         sync_ff <= '0';
       elsif (p_dly_out(3) = '1') and (p_dly_out(8) = '0') then
         sync_ff <= '1';
       end if; 
       if  (p_dly_out(8) = '1') then
         pps_ff <= '0';
       elsif (p_dly_out(4) = '1') and (p_dly_out(8) = '0') then
         pps_ff <= '1';
       end if; 
    end if;
end process; 

sff <= sync_ff or p_dly_out(3);
pff <= pps_ff  or p_dly_out(4);

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

m_axis_pdti_tuser(63 downto 0)   <= (others => '0'); 
m_axis_pdti_tuser(71 downto 65)  <= (others => '0');
m_axis_pdti_tuser(79 downto 73)  <= (others => '0');
m_axis_pdti_tuser(87 downto 81)  <= (others => '0');
m_axis_pdti_tuser(92 downto 88)  <= "00001";
m_axis_pdti_tuser(94 downto 93)  <= "01";
m_axis_pdti_tuser(127 downto 96) <= (others => '0'); 


process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
       if (s_axis_aresetn = '0') or (dly_active = '0') or ((wcnv_axis_tready = '1') and (wcnv_axis_tvalid = '1')) then
          rt            <= '0';
       elsif ((wcnv_axis_tready = '1') and (wcnv_axis_tvalid = '0')) or (rqst_ovfl = '1') then
          rt            <= '1';
       end if;  
    end if;
end process;  

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
       if (s_axis_aresetn = '0') or (active = '0') or (rt_clr = '1') then
          p_realtime_lost <= '0';
       elsif ((wcnv_axis_tready = '1') and (wcnv_axis_tvalid = '0')) or (rqst_ovfl = '1') then
          p_realtime_lost <= '1';
       end if;
       realtime_lost <= p_realtime_lost;
    end if;
end process;   

--------------------------------------------------------------------------------
-- Linked List
--------------------------------------------------------------------------------

-- AXI-Lite BRAM Controller
bramctlr_inst : px_axis_ddr2wave1_bramctlr
  port map (
    s_axi_aclk    => s_axi_csr_aclk,
    s_axi_aresetn => t1_s_axi_csr_aresetn,
    s_axi_awaddr  => axi_xbar_awaddr(22 downto 12),               
    s_axi_awprot  => axi_xbar_awprot(5 downto 3),               
    s_axi_awvalid => axi_xbar_awvalid(1),                       
    s_axi_awready => axi_xbar_awready(1),                       
    s_axi_wdata   => axi_xbar_wdata(63 downto 32),               
    s_axi_wstrb   => axi_xbar_wstrb(7 downto 4),                
    s_axi_wvalid  => axi_xbar_wvalid(1),                        
    s_axi_wready  => axi_xbar_wready(1),                        
    s_axi_bresp   => axi_xbar_bresp(3 downto 2),                
    s_axi_bvalid  => axi_xbar_bvalid(1),                        
    s_axi_bready  => axi_xbar_bready(1),                        
    s_axi_araddr  => axi_xbar_araddr(22 downto 12),               
    s_axi_arprot  => axi_xbar_arprot(5 downto 3),               
    s_axi_arvalid => axi_xbar_arvalid(1),                       
    s_axi_arready => axi_xbar_arready(1),                       
    s_axi_rdata   => axi_xbar_rdata(63 downto 32),               
    s_axi_rresp   => axi_xbar_rresp(3 downto 2),                
    s_axi_rvalid  => axi_xbar_rvalid(1),                        
    s_axi_rready  => axi_xbar_rready(1),                        
    bram_rst      => bram_rst,
    bram_clk      => bram_clk,
    bram_en       => bram_en,
    bram_we       => bram_we,
    bram_addr     => bram_addr,
    bram_wrdata   => bram_wrdata,
    bram_rddata   => bram_rddata
  );

-- Linked Lisr True Dual Port RAM
ll_dpram_inst : xpm_memory_tdpram
    generic map (
  
      -- Common module generics
      MEMORY_SIZE        => 16384,        --positive integer
      MEMORY_PRIMITIVE   => "block",      --string; "auto", "distributed", "block" or "ultra" ;
      CLOCKING_MODE      => "independent_clock",--string; "common_clock", "independent_clock" 
      MEMORY_INIT_FILE   => "none",      --string; "none" or "<filename>.mem" 
      MEMORY_INIT_PARAM  => "",--string;
      USE_MEM_INIT       => 1,           --integer; 0,1
      WAKEUP_TIME        => "disable_sleep",--string; "disable_sleep" or "use_sleep_pin" 
      MESSAGE_CONTROL    => 0,           --integer;
      ECC_MODE           => "no_ecc",    --string; "no_ecc", "encode_only", "decode_only" or "both_encode_and_decode" 
      AUTO_SLEEP_TIME    => 0,           --Do not Change
  
      -- Port A module generics
      WRITE_DATA_WIDTH_A => 32,          --positive integer
      READ_DATA_WIDTH_A  => 32,          --positive integer
      BYTE_WRITE_WIDTH_A => 32,          --integer; 8, 9, or WRITE_DATA_WIDTH_A value
      ADDR_WIDTH_A       => 9,           --positive integer
      READ_RESET_VALUE_A => "0",         --string
      READ_LATENCY_A     => 2,           --non-negative integer
      WRITE_MODE_A       => "write_first", --string; "write_first", "read_first", "no_change" 
  
      -- Port B module generics
      WRITE_DATA_WIDTH_B => 256,          --positive integer
      READ_DATA_WIDTH_B  => 256,          --positive integer
      BYTE_WRITE_WIDTH_B => 256,          --integer; 8, 9, or WRITE_DATA_WIDTH_B value
      ADDR_WIDTH_B       => 6,           --positive integer
      READ_RESET_VALUE_B => "0",         --string
      READ_LATENCY_B     => 2,           --non-negative integer
      WRITE_MODE_B       => "write_first"  --string; "write_first", "read_first", "no_change" 
    )
    port map (
      -- Common module ports
      sleep          => '0',
      -- Port A module ports
      clka           => s_axi_csr_aclk,
      rsta           => '0',
      ena            => bram_en,
      regcea         => '1',
      wea            => bram_we(0 downto 0),
      addra          => bram_addr,
      dina           => bram_wrdata,
      injectsbiterra => '0',
      injectdbiterra => '0',
      douta          => bram_rddata,
      sbiterra       => open,
      dbiterra       => open,
      -- Port B module ports
      clkb           => s_axis_aclk,
      rstb           => '0',
      enb            => '1',
      regceb         => '1',
      web            => "0",
      addrb          => link_addr,
      dinb           => x"0000000000000000000000000000000000000000000000000000000000000000",
      injectsbiterrb => '0',
      injectdbiterrb => '0',
      doutb          => link_descriptor,
      sbiterrb       => open,
      dbiterrb       => open
    );

-- Linked List Descriptor    
-- [31:0]    = Trigger Delay
-- [63:32]    = Trigger Length
-- [95:64]   = SDRAM Start Byte Address
-- [127:96]  = SDRAM End Byte Address 
-- [134:128] = Next Link
-- [144]     = Disarm at end
-- [145]     = Interrupt at Link End
-- [146]     = Interrupt at link Start
 
-- Link 
process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
       t1_ll_start <= ll_start;
       t2_ll_start <= t1_ll_start;
       t3_ll_start <= t2_ll_start; 
       if (s_axis_aresetn = '0') or (ll_start = '1') then
          link_addr    <= ll_start_address;
          current_link <= ll_start_address;
       elsif (t2_ll_adv = '1') then
          link_addr <= link_descriptor(133 downto 128);
          current_link <= link_addr;
       end if;
       if (t3_ll_start = '1') or (t2_ll_adv = '1') then
          next_link <= link_descriptor(133 downto 128);
       end if;
       ls_int <= t2_ll_adv and link_descriptor(146);
    end if;
end process;   

trig_cntr_ld_val     <= link_descriptor(63 downto 32);  
trig_dly_cntr_ld_val <= link_descriptor(31 downto 0);

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
      if t2_ll_adv = '1' then
         p_ddr_strt_addr <= link_descriptor(95 downto 64);  --ddr_strt_addrx;
         p_ddr_end_addr  <= link_descriptor(127 downto 96); --ddr_end_addrx;
         p_disarm_at_end <= link_descriptor(144); -- disarm at link end
         p_int_at_link_end <= link_descriptor(145); -- interrupt at link end
      end if;
      ddr_strt_addr   <= p_ddr_strt_addr;
      ddr_end_addr    <= p_ddr_end_addr;
      disarm_at_end   <= p_disarm_at_end;
      int_at_link_end <= p_int_at_link_end;
      t1_int_at_link_end <= int_at_link_end;
    end if;
end process;        

end Behavioral;
