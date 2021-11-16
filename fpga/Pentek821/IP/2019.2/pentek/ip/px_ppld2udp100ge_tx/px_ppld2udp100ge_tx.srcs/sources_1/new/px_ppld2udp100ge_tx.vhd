----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2018 08:25:15 AM
-- Design Name: 
-- Module Name: px_ppld2udp100ge_tx - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 1.0 - limited WIP release (untested)
-- Revision 1.1 - Fixed Address registers and fixed IPV4 Header total length field, fixed mixup of VITA49 modes, reversed VITA49 header
-- Revision 1.2 - Fixed VITA49 PKTCNT
-- Additional Comments:
-- 
-- Register Map
--
-- 0x00 Source MAC Address[31:0]
-- 0x04 Destinaton MAC Address[31:0]
-- 0x08 Destination MAC Address[47 downto 32]/Source MAC Address[47 downto 32] 
-- 0x0C Source IPV4 Address
-- 0x10 Destinaton IPV4 Address
-- 0x14 Control Register

-- Lookup Table
-- Channel X UDP Src/Dest Port Number
-- Channel X VITA 49 Stream ID 
-- Channel X VITA 49 Class Code Word 1
-- Channel X VITA 49 Class Code Word 2

-- Control Register
-- bit [0] Reset
-- bit [1] Tx Enable Output
-- bit [3:2] Packet Payload Size
-- bit [4] External FIFO Flush
-- bit [5] Enable VITA 49
-- bit [6] Timestamp Mode 0 = Free running 1 = PPS + Sample Count
-- bit [7] TSI Source 0=UTC 1=GPS

-- Interrupt
-- [0] LBUS Overflow
-- [1] stat_tx_local_fault

-------------------------
-- Operating Modes
-------------------------

-- Mode 0 - UDP with VITA 49 Disabled
-- Mode 1 --UDP with VITA 49 Enabled and VITA 49 PPS Timestamp Mode
-- Mode 2 --UDP with VITA 49 Enabled and VITA 49 Free-Running 64-bit Timestamp Mode
-- Mode 3 --Incoming Data already in Ethernet packet form (don't add headers)

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- (c) Copyright 2018-2019 Pentek, Inc. All rights reserved.
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_ppld2udp100ge_tx is
port (
    --------------------------------------------------------------------------------
    -- AXI-LITE Slave Interface 
    --------------------------------------------------------------------------------
    s_axi_csr_aclk            : in  std_logic;
    s_axi_csr_aresetn         : in  std_logic;
    s_axi_csr_awaddr          : in  std_logic_vector(12 downto 0);
    s_axi_csr_awprot          : in  std_logic_vector(2 downto 0); -- not used
    s_axi_csr_awvalid         : in  std_logic;
    s_axi_csr_awready         : out std_logic;
    s_axi_csr_wdata           : in  std_logic_vector(31 downto 0);
    s_axi_csr_wstrb           : in  std_logic_vector(3 downto 0); 
    s_axi_csr_wvalid          : in  std_logic;
    s_axi_csr_wready          : out std_logic;
    s_axi_csr_bresp           : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid          : out std_logic;
    s_axi_csr_bready          : in  std_logic;
    s_axi_csr_araddr          : in  std_logic_vector(12 downto 0);
    s_axi_csr_arprot          : in  std_logic_vector(2 downto 0); -- not used
    s_axi_csr_arvalid         : in  std_logic;
    s_axi_csr_arready         : out std_logic;
    s_axi_csr_rdata           : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp           : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid          : out std_logic;
    s_axi_csr_rready          : in  std_logic;
    irq                       : out std_logic;
    -----------------------------------------------------------------------------
    -- Input AXI-S PPLD Stream (Pre-Packaged Payloads Packets)
    -----------------------------------------------------------------------------
    -- synchronous to txclk 322.266MHz  - Sourced from tx_usrclk2_out of 100Ge core 
    s_axis_ppld_tvalid        : in  std_logic;
    s_axis_ppld_tready        : out std_logic;
    s_axis_ppld_tdata         : in  std_logic_vector(511 downto 0);
    -- tuser[63:0]    = timestamp[63:0]  
    -- tuser[64]      = Start of Payload Packet   
    -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
    -- tuser[67]      = Data Type 0 = Real 1 = I/Q
    -- tuser[75:68]   = channel[7:0]
    -- tuser[76]      = 0 = Payload Data only, 1 = Has Packet Header Already 
    -- tuser[77]      = Reserved    
    -- tuser[78]      = Acq. Start
    -- tuser[79]      = Acq. End (Input PPKT had tlast)
    -- tuser[96:80]   = Payload Size (bytes)
    -- tuser[103:97]  = Number Valid Bytes in cycle
    s_axis_ppld_tuser         : in  std_logic_vector(103 downto 0);
    s_axis_ppld_tkeep         : in  std_logic_vector(63 downto 0); -- One per byte
    s_axis_ppld_tlast         : in  std_logic; -- End of Payload Packet 
    -----------------------------------------------------------------------------
    -- synchronous to txclk 322.266MHz  - Sourced from tx_usrclk2_out of 100Ge core 
    ext_fifo_aresetn          : out std_logic;
    -----------------------------------------------------------------------------
    -- Output to 100GE Core
    -----------------------------------------------------------------------------
    -- synchronous to txclk 322.266MHz  - Sourced from tx_usrclk2_out of 100Ge core 
    -- Segmented local bus (LBUS)
    txclk                     : in std_logic;
    tx_ovfout                 : in std_logic;
    tx_rdyout                 : in std_logic;
    tx_unfout                 : in std_logic;
    tx_datain0                : out std_logic_vector(127 downto 0);
    tx_datain1                : out std_logic_vector(127 downto 0);
    tx_datain2                : out std_logic_vector(127 downto 0);
    tx_datain3                : out std_logic_vector(127 downto 0);
    tx_enain0                 : out std_logic;
    tx_enain1                 : out std_logic;
    tx_enain2                 : out std_logic;
    tx_enain3                 : out std_logic;
    tx_eopin0                 : out std_logic;
    tx_eopin1                 : out std_logic;
    tx_eopin2                 : out std_logic;
    tx_eopin3                 : out std_logic;
    tx_errin0                 : out std_logic;
    tx_errin1                 : out std_logic;
    tx_errin2                 : out std_logic;
    tx_errin3                 : out std_logic;
    tx_mtyin0                 : out std_logic_vector(3 downto 0);
    tx_mtyin1                 : out std_logic_vector(3 downto 0);
    tx_mtyin2                 : out std_logic_vector(3 downto 0);
    tx_mtyin3                 : out std_logic_vector(3 downto 0);
    tx_sopin0                 : out std_logic;
    tx_sopin1                 : out std_logic;
    tx_sopin2                 : out std_logic;
    tx_sopin3                 : out std_logic;
    usr_tx_reset              : in std_logic;
--------------------------------------------------------------------------------
-- TX Local Fault
--------------------------------------------------------------------------------
    stat_tx_local_fault       : in std_logic;
--------------------------------------------------------------------------------
-- Pause Flow Control
--------------------------------------------------------------------------------
    stat_rx_pause_req         : in std_logic_vector(8 downto 0);
    stat_rx_pause_valid       : in std_logic_vector(8 downto 0);
--------------------------------------------------------------------------------
-- Payload Size Control to AXI-S PPLD Source
--------------------------------------------------------------------------------
    -- synchronous to txclk 322.266MHz  - Sourced from tx_usrclk2_out of 100Ge core 
    payload_size_ctl          : out std_logic_vector(16 downto 0);  
    payload_size_ctl_en       : out std_logic
);
end px_ppld2udp100ge_tx;

architecture Behavioral of px_ppld2udp100ge_tx is

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of usr_tx_reset: SIGNAL is "xilinx.com:signal:reset:1.0 usr_tx_reset RST";
ATTRIBUTE X_INTERFACE_PARAMETER of usr_tx_reset: SIGNAL is "POLARITY ACTIVE_HIGH";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aresetn: SIGNAL is "xilinx.com:signal:reset:1.0 s_axi_csr_aresetn RST";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aresetn: SIGNAL is "POLARITY ACTIVE_LOW";

ATTRIBUTE X_INTERFACE_INFO of ext_fifo_aresetn: SIGNAL is "xilinx.com:signal:reset:1.0 ext_fifo_aresetn RST";
ATTRIBUTE X_INTERFACE_PARAMETER of ext_fifo_aresetn: SIGNAL is "POLARITY ACTIVE_LOW";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of txclk: SIGNAL is "xilinx.com:signal:clock:1.0 txclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of txclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_ppld, ASSOCIATED_RESET ext_fifo_aresetn";

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTERRUPT";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- AXI-LITE BRAM Controller
-- BRAM Latency = 2
COMPONENT px_ppld2udp100ge_brctlr
  PORT (
    s_axi_aclk : IN STD_LOGIC;
    s_axi_aresetn : IN STD_LOGIC;
    s_axi_awaddr : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
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
    s_axi_araddr : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
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
    bram_addr : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    bram_wrdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    bram_rddata : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

-- CSR Registers
COMPONENT px_ppld2udp100ge_csr
  PORT (
    s_axi_csr_aclk : IN STD_LOGIC;
    s_axi_csr_aresetn : IN STD_LOGIC;
    s_axi_csr_awaddr : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    s_axi_csr_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_csr_awvalid : IN STD_LOGIC;
    s_axi_csr_awready : OUT STD_LOGIC;
    s_axi_csr_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_csr_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_csr_wvalid : IN STD_LOGIC;
    s_axi_csr_wready : OUT STD_LOGIC;
    s_axi_csr_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_csr_bvalid : OUT STD_LOGIC;
    s_axi_csr_bready : IN STD_LOGIC;
    s_axi_csr_araddr : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    s_axi_csr_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_csr_arvalid : IN STD_LOGIC;
    s_axi_csr_arready : OUT STD_LOGIC;
    s_axi_csr_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_csr_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_csr_rvalid : OUT STD_LOGIC;
    s_axi_csr_rready : IN STD_LOGIC;
    reg0_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    reg1_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    reg2_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    reg3_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    reg4_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    reg5_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl0_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl1_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl2_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl3_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl4_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl5_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    intrpt_src_in : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    irq : OUT STD_LOGIC
  );
END COMPONENT;

-- AXI XBAR
-- Port 0 offset = 0x0000
-- Port 0 offset = 0x1000
COMPONENT px_ppld2udp100ge_axi_xbar
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axi_awaddr : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
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
    s_axi_araddr : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
    s_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_arvalid : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_arready : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_rvalid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_rready : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axi_awaddr : OUT STD_LOGIC_VECTOR(25 DOWNTO 0);
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
    m_axi_araddr : OUT STD_LOGIC_VECTOR(25 DOWNTO 0);
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
WAIT_SOP_STATE,
ELIM_BAD_SOP_STATE,
SOP1_STATE,
SOP2_STATE,
START_MODE0_STATE,
START_MODE1_STATE1,
START_MODE2_STATE1,
START_MODE1_STATE2,
START_MODE2_STATE2,
FINISH_MODE0_STATE,
FINISH_MODE1_STATE,
FINISH_MODE2_STATE,
MODE0_PACKET_STATE,
MODE1_PACKET_STATE,
MODE2_PACKET_STATE,
MODE3_PACKET_STATE,
HOLDOFF_WAIT,
HOLDOFF_WAIT3
);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal src_sum     :std_logic_vector(16 downto 0) := (others => '0');
signal dest_sum    :std_logic_vector(16 downto 0) := (others => '0');
signal sd_sum      :std_logic_vector(17 downto 0) := (others => '0');
signal pre_sum     :std_logic_vector(18 downto 0) := (others => '0');
signal total_sum   :std_logic_vector(19 downto 0) := (others => '0');
signal total_sum17 :std_logic_vector(16 downto 0) := (others => '0');
signal hdr_cs_inv  :std_logic_vector(15 downto 0) := (others => '0');
signal hdr_cs      :std_logic_vector(15 downto 0) := (others => '0');
signal src_ip_addr :std_logic_vector(31 downto 0) := (others => '0');
signal dest_ip_addr :std_logic_vector(31 downto 0) := (others => '0');
signal total_len   :std_logic_vector(15 downto 0) := (others => '0');
signal pld_len     :std_logic_vector(15 downto 0) := (others => '0');
signal header_mode :std_logic_vector(1 downto 0) := (others => '0');
signal hdr_mode0   :std_logic_vector(335 downto 0) := (others => '0');
signal hdr_mode1   :std_logic_vector(559 downto 0) := (others => '0');
signal hdr_mode2   :std_logic_vector(527 downto 0) := (others => '0');
signal vpx_hdr2    :std_logic_vector(191 downto 0) := (others => '0');
signal vpx_hdr2_rvrs :std_logic_vector(191 downto 0) := (others => '0');
signal vpx_hdr1    :std_logic_vector(223 downto 0) := (others => '0');
signal vpx_hdr1_rvrs :std_logic_vector(223 downto 0) := (others => '0');
signal mac_dest    :std_logic_vector(47 downto 0) := (others => '0');
signal mac_src     :std_logic_vector(47 downto 0) := (others => '0');
signal udp_src_port:std_logic_vector(15 downto 0) := (others => '0');
signal udp_dest_port:std_logic_vector(15 downto 0) := (others => '0');
signal udp_len     :std_logic_vector(15 downto 0) := (others => '0');
signal tsi         :std_logic_vector(1 downto 0) := (others => '0');
signal tsf         :std_logic_vector(1 downto 0) := (others => '0');
signal pktcnt      :std_logic_vector(3 downto 0) := (others => '0');
signal vpkt_size   :std_logic_vector(15 downto 0) := (others => '0');
signal stream_id   :std_logic_vector(31 downto 0) := (others => '0');
signal oui         :std_logic_vector(23 downto 0) := (others => '0');
signal class_code1 :std_logic_vector(31 downto 0) := (others => '0');
signal class_code2 :std_logic_vector(31 downto 0) := (others => '0');
signal ts          :std_logic_vector(63 downto 0) := (others => '0');
signal s_axis_ppld_tdata_rvs :std_logic_vector(511 downto 0) := (others => '0');
signal t1_s_axis_ppld_tdata_rvs :std_logic_vector(511 downto 0) := (others => '0');
signal state: state_type := RESET_STATE;
signal ppld_valid_bytes: integer range 0 to 64 := 0;
signal sm_reset_n  : std_logic := '0';  
signal lut_addr    :std_logic_vector(7 downto 0) := (others => '0');
signal lut_data    :std_logic_vector(127 downto 0) := (others => '0');
signal rem_bytes   : integer range 0 to 64 := 0;
signal pad         :std_logic_vector(5 downto 0) := (others => '0');
signal tx_enable   : std_logic := '0';  
signal bram_rst :std_logic := '0';
signal bram_clk :std_logic := '0';
signal bram_en : std_logic := '0';
signal bram_we : std_logic_vector(3 downto 0) := (others => '0');
signal bram_addr : std_logic_vector(9 downto 0) := (others => '0');
signal bram_wrdata : std_logic_vector(31 downto 0) := (others => '0');
signal bram_rddata : std_logic_vector(31 downto 0) := (others => '0');
signal ctl0_out : std_logic_vector(31 downto 0) := (others => '0');
signal ctl1_out : std_logic_vector(31 downto 0) := (others => '0');
signal ctl2_out : std_logic_vector(31 downto 0) := (others => '0');
signal ctl3_out : std_logic_vector(31 downto 0) := (others => '0');
signal ctl4_out : std_logic_vector(31 downto 0) := (others => '0');
signal ctl5_out : std_logic_vector(31 downto 0) := (others => '0');
signal intrpt_src_in: std_logic_vector(1 downto 0) := (others => '0');
signal sw_axi_awaddr : std_logic_vector(25 downto 0) := (others => '0');
signal sw_axi_awprot : std_logic_vector(5 downto 0) := (others => '0');
signal sw_axi_awvalid : std_logic_vector(1 downto 0) := (others => '0');
signal sw_axi_awready : std_logic_vector(1 downto 0) := (others => '0');
signal sw_axi_wdata : std_logic_vector(63 downto 0) := (others => '0');
signal sw_axi_wstrb : std_logic_vector(7 downto 0) := (others => '0');
signal sw_axi_wvalid : std_logic_vector(1 downto 0) := (others => '0');
signal sw_axi_wready : std_logic_vector(1 downto 0) := (others => '0');
signal sw_axi_bresp : std_logic_vector(3 downto 0) := (others => '0');
signal sw_axi_bvalid : std_logic_vector(1 downto 0) := (others => '0');
signal sw_axi_bready : std_logic_vector(1 downto 0) := (others => '0');
signal sw_axi_araddr : std_logic_vector(25 downto 0) := (others => '0');
signal sw_axi_arprot : std_logic_vector(5 downto 0) := (others => '0');
signal sw_axi_arvalid : std_logic_vector(1 downto 0) := (others => '0');
signal sw_axi_arready : std_logic_vector(1 downto 0) := (others => '0');
signal sw_axi_rdata : std_logic_vector(63 downto 0) := (others => '0');
signal sw_axi_rresp : std_logic_vector(3 downto 0) := (others => '0');
signal sw_axi_rvalid : std_logic_vector(1 downto 0) := (others => '0');
signal sw_axi_rready : std_logic_vector(1 downto 0) := (others => '0');
signal t1_s_axi_csr_aresetn: std_logic := '0';
signal rst_reg_x: std_logic := '0';
signal rst_reg: std_logic := '0';
signal h_mode_x: std_logic_vector(1 downto 0) := (others => '0');
signal h_mode: std_logic_vector(1 downto 0) := (others => '0');
signal time_type: std_logic_vector(1 downto 0) := (others => '0');
signal time_type_x: std_logic_vector(1 downto 0) := (others => '0');
signal ctl_x: std_logic_vector(7 downto 0) := (others => '0');
signal ctl: std_logic_vector(7 downto 0) := (others => '0');
signal pkt_pyld_size_x: std_logic_vector(1 downto 0) := (others => '0');
signal usr_tx_reset_x: std_logic := '0';
signal irq_x: std_logic := '0';
signal stat_rx_pause: std_logic := '0';
signal mode3_sop: std_logic  := '0';

--------------------------------------------------------------------------------

begin


--------------------------------------------------------------------------------
-- Headers
--------------------------------------------------------------------------------

-- ==============================================
-- VITA 49 Disabled
-- ==============================================
-- Header Mode 0
-------------------------------------------------
-- MAC Destination | MAC Source |0x0800     (14 bytes)
-------------------------------------------------
-- 0x4 | 0x5 | 000000 | 00 | Total Length   (4 bytes) -- Ethernet Header
-------------------------------------------------
-- 0x0000 | 0 DF 0 | 0000000000000          (4 bytes) -- IPV4 Header
-- TTL | 0x11 | HDR CHK SUM                 (4 bytes)
-- SRC IP ADDR                              (4 bytes)
-- DEST IP ADDR                             (4 bytes)
-------------------------------------------------
-- UDP SRC Port/DEST Port                   (4 bytes) -- UDP Header
-- UDP Length | CHK SUM 0x0000              (4 bytes)
-- Total Bytes = 42
hdr_mode0 <= mac_dest & mac_src & x"0800" & x"4500" & total_len & 
              x"0001" & x"0000" &
              x"40" & x"11" & hdr_cs &
             src_ip_addr & dest_ip_addr &
             udp_src_port & udp_dest_port &
             udp_len & x"0000";
             
 -- ==============================================
 -- VITA 49 Enabled and PPS Timestamp Mode
 -- ==============================================            
-------------------------------------------------
-- MAC Destination | MAC Source |0x0800     (14 bytes)
-------------------------------------------------
-- 0x4 | 0x5 | 000000 | 00 | Total Length   (4 bytes) -- Ethernet Header
-------------------------------------------------
-- 0x0000 | 0 DF 0 | 0000000000000          (4 bytes) -- IPV4 Header
-- TTL | 0x11 | HDR CHK SUM                 (4 bytes)
-- SRC IP ADDR                              (4 bytes)
-- DEST IP ADDR                             (4 bytes)
-------------------------------------------------
-- UDP SRC Port/DEST Port                   (4 bytes) -- UDP Header
-- UDP Length | CHK SUM 0x0000              (4 bytes)
-------------------------------------------------
-- 0001 | 1 | 0 | 00 | TSI | TSF | PKTCNT | PKT Size (4 bytes)  -- VITA 49 Header
-- Stream ID                                (4 Bytes)
-- 0x00 | OUI                               (4 Bytes)
-- Info Class Code | Packet Class Code      (4 Bytes)
-- Integer Seconds Timestamp                (4 bytes)
-- Fractional Seconds MSB                   (4 bytes)
-- Fractional Seconds LSB                   (4 bytes)     
-- Total Bytes = 70        

vpx_hdr1 <=  x"18" & tsi & tsf & pktcnt & vpkt_size & stream_id & x"00" & class_code1(23 downto 0) & class_code2 &
             ts(63 downto 32) & x"00000000" & ts(31 downto 0);

vpx_hdr1_rvrs <= vpx_hdr1(199 downto 192) & vpx_hdr1(207 downto 200) & vpx_hdr1(215 downto 208) & vpx_hdr1(223 downto 216) & 
                 vpx_hdr1(167 downto 160) & vpx_hdr1(175 downto 168) & vpx_hdr1(183 downto 176) & vpx_hdr1(191 downto 184) &
                 vpx_hdr1(135 downto 128) & vpx_hdr1(143 downto 136) & vpx_hdr1(151 downto 144) & vpx_hdr1(159 downto 152) &
                 vpx_hdr1(103 downto 96)  & vpx_hdr1(111 downto 104) & vpx_hdr1(119 downto 112) & vpx_hdr1(127 downto 120) &
                 vpx_hdr1(71 downto 64)   & vpx_hdr1(79 downto 72)   & vpx_hdr1(87 downto 80)   & vpx_hdr1(95 downto 88)   &
                 vpx_hdr1(39 downto 32)   & vpx_hdr1(47 downto 40)   & vpx_hdr1(55 downto 48)   & vpx_hdr1(63 downto 56)   &
                 vpx_hdr1(7 downto 0)     & vpx_hdr1(15 downto 8)    & vpx_hdr1(23 downto 16)   & vpx_hdr1(31 downto 24);
                  
hdr_mode1 <= mac_dest & mac_src & x"0800" & x"4500" & total_len & 
              x"0001" & x"0000" &
              x"40" & x"11" & hdr_cs &
             src_ip_addr & dest_ip_addr &
             udp_src_port & udp_dest_port &
             udp_len & x"0000" & vpx_hdr1_rvrs;

 
 -- ==============================================
 -- VITA 49 Enabled and Free-Running Counter Timestamp Mode
 -- ==============================================            
 -------------------------------------------------
 -- MAC Destination | MAC Source |0x0800     (14 bytes)
 -------------------------------------------------
 -- 0x4 | 0x5 | 000000 | 00 | Total Length   (4 bytes) -- Ethernet Header
 -------------------------------------------------
 -- 0x0000 | 0 DF 0 | 0000000000000          (4 bytes) -- IPV4 Header
 -- TTL | 0x11 | HDR CHK SUM                 (4 bytes)
 -- SRC IP ADDR                              (4 bytes)
 -- DEST IP ADDR                             (4 bytes)
 -------------------------------------------------
 -- UDP SRC Port/DEST Port                   (4 bytes) -- UDP Header
 -- UDP Length | CHK SUM 0x0000              (4 bytes)
 -------------------------------------------------
 -- 0001 | 1 | 0 | 00 | TSI | TSF | PKTCNT | PKT Size (4 bytes)  -- VITA 49 Header
 -- Stream ID                                (4 Bytes)
 -- 0x00 | OUI                               (4 Bytes)
 -- Info Class Code | Packet Class Code      (4 Bytes)
 -- Fractional Seconds MSB                   (4 bytes)
 -- Fractional Seconds LSB                   (4 bytes)  
 -- Total Bytes = 66    
 
 vpx_hdr2 <=  x"18" & tsi & tsf & pktcnt & vpkt_size & stream_id & x"00" &  class_code1(23 downto 0) & class_code2 & ts;      
 
 vpx_hdr2_rvrs <= vpx_hdr2(167 downto 160) & vpx_hdr2(175 downto 168) & vpx_hdr2(183 downto 176) & vpx_hdr2(191 downto 184) &
                  vpx_hdr2(135 downto 128) & vpx_hdr2(143 downto 136) & vpx_hdr2(151 downto 144) & vpx_hdr2(159 downto 152) &
                  vpx_hdr2(103 downto 96)  & vpx_hdr2(111 downto 104) & vpx_hdr2(119 downto 112) & vpx_hdr2(127 downto 120) &
                  vpx_hdr2(71 downto 64)   & vpx_hdr2(79 downto 72)   & vpx_hdr2(87 downto 80)   & vpx_hdr2(95 downto 88)   &
                  vpx_hdr2(39 downto 32)   & vpx_hdr2(47 downto 40)   & vpx_hdr2(55 downto 48)   & vpx_hdr2(63 downto 56)   &
                  vpx_hdr2(7 downto 0)     & vpx_hdr2(15 downto 8)    & vpx_hdr2(23 downto 16)   & vpx_hdr2(31 downto 24);
 
 hdr_mode2 <= mac_dest & mac_src & x"0800" & x"4500" & total_len & 
              x"0001" & x"0000" &
              x"40" & x"11" & hdr_cs &
              src_ip_addr & dest_ip_addr &
              udp_src_port & udp_dest_port &
              udp_len & x"0000" & vpx_hdr2_rvrs;  

 -- ==============================================
 -- Mode 3 Packet Already has Header Embedded
 -- ============================================== 
 -- For this mode we pass the packet directly without adding a header
              
--------------------------------------------------------------------------------
-- IP Header Check Sum
--------------------------------------------------------------------------------
-- We can pre-add all of the IP header words except the length because they do not
-- change except when changed by register setup.

-- It takes three clock cycles to calculate IPV4 Header Checksum from when length is known
process(txclk)
begin
    if rising_edge(txclk) then
        src_sum     <= ('0' & src_ip_addr(31 downto 16))  + ('0' & src_ip_addr(15 downto 0)); -- 17-bit
        dest_sum    <= ('0' & dest_ip_addr(31 downto 16)) + ('0' & dest_ip_addr(15 downto 0)); -- 17-bit
        sd_sum      <= ('0' & src_sum)  + ('0' & dest_sum);  -- 18-bit
        case header_mode is
            when "00" =>
              pre_sum     <= ('0' & sd_sum) + ("000" & x"852E"); -- 19-bit  x"8512" + 28
            when "01" =>
              pre_sum     <= ('0' & sd_sum) + ("000" & x"854A"); -- 19-bit  x"8512" + 56
            when "10" =>
              pre_sum     <= ('0' & sd_sum) + ("000" & x"8546"); -- 19-bit  x"8512" + 52
            when others =>
              pre_sum     <= ('0' & sd_sum) + ("000" & x"8546"); -- 19-bit  x"8512" + 52
        end case;
    end if;
end process; 

-- IPV4 Header Checksum
hdr_cs <= not hdr_cs_inv; -- one's comp.

-- Reverse Byte order
gen_rvrs: for i in 0 to 63 generate 
   s_axis_ppld_tdata_rvs(i*8+8-1 downto i*8) <= s_axis_ppld_tdata((63-i)*8+8-1 downto (63-i)*8);
end generate;

--------------------------------------------------------------------------------
-- Pause
--------------------------------------------------------------------------------

process(txclk)
begin
    if rising_edge(txclk) then
      stat_rx_pause <= (stat_rx_pause_req(0) and stat_rx_pause_valid(0)) or
      (stat_rx_pause_req(1) and stat_rx_pause_valid(1)) or
      (stat_rx_pause_req(2) and stat_rx_pause_valid(2)) or
      (stat_rx_pause_req(3) and stat_rx_pause_valid(3)) or
      (stat_rx_pause_req(4) and stat_rx_pause_valid(4)) or
      (stat_rx_pause_req(5) and stat_rx_pause_valid(5)) or
      (stat_rx_pause_req(6) and stat_rx_pause_valid(6)) or
      (stat_rx_pause_req(7) and stat_rx_pause_valid(7)) or
      (stat_rx_pause_req(8) and stat_rx_pause_valid(8));
   end if;
end process;

--------------------------------------------------------------------------------
-- State Machine
--------------------------------------------------------------------------------

ppld_valid_bytes <= conv_integer(s_axis_ppld_tuser(103 downto 97)) + conv_integer(pad);

tx_sopin1 <= '0';
tx_sopin2 <= '0';
tx_sopin3 <= '0';
    
process(txclk)
begin
    if rising_edge(txclk) then
      if (sm_reset_n = '0') or (stat_tx_local_fault = '1') then
         state <= RESET_STATE;
         tx_enain0 <= '0';
         tx_enain1 <= '0';
         tx_enain2 <= '0';
         tx_enain3 <= '0';
         tx_eopin0 <= '0';
         tx_eopin1 <= '0';
         tx_eopin2 <= '0';
         tx_eopin3 <= '0';
         tx_mtyin0 <= x"0";
         tx_mtyin1 <= x"0";
         tx_mtyin2 <= x"0";
         tx_mtyin3 <= x"0";
         tx_sopin0 <= '0';
         mode3_sop <= '0';
         pktcnt    <= "0000";
         s_axis_ppld_tready <= '0';
      else
         case state is
               when RESET_STATE =>
                  if (sm_reset_n = '1') and (stat_tx_local_fault = '0') then
                     state <= WAIT_SOP_STATE;
                  end if;
                  tx_enain0 <= '0';
                  tx_enain1 <= '0';
                  tx_enain2 <= '0';
                  tx_enain3 <= '0';
                  tx_eopin0 <= '0';
                  tx_eopin1 <= '0';
                  tx_eopin2 <= '0';
                  tx_eopin3 <= '0';
                  tx_mtyin0 <= x"0";
                  tx_mtyin1 <= x"0";
                  tx_mtyin2 <= x"0";
                  tx_mtyin3 <= x"0";
                  tx_sopin0 <= '0';
                  mode3_sop <= '0';
                  pktcnt    <= "0000";
                  s_axis_ppld_tready <= '0';
               when WAIT_SOP_STATE => -- Wait for a packet to be available
                  total_sum   <= ('0' & pre_sum) + (x"0" & s_axis_ppld_tuser(95 downto 80)); -- 20-bit total 
                  lut_addr    <= s_axis_ppld_tuser(75 downto 68); -- address of Look-Up Table based on channel number
                  ts          <= s_axis_ppld_tuser(63 downto 0);  -- timestamp
                  if (s_axis_ppld_tvalid = '1') and (tx_enable = '1') and (stat_rx_pause = '0') then
                     if (s_axis_ppld_tuser(64) = '0') then -- isn't SOP, so dump on floor
                        state <= ELIM_BAD_SOP_STATE;
                        s_axis_ppld_tready <= '1';
                     elsif (tx_rdyout = '1') then -- There is a good packet at input and we are not asked to hold off
                        if (s_axis_ppld_tuser(76) = '0') then
                           state <= SOP1_STATE; -- Create Header
                        else
                           state <= MODE3_PACKET_STATE;
                           mode3_sop <= '1'; 
                           s_axis_ppld_tready <= '1';
                        end if;
                     end if;
                  end if;  
                  tx_enain0 <= '0';
                  tx_enain1 <= '0';
                  tx_enain2 <= '0';
                  tx_enain3 <= '0';
                  tx_eopin0 <= '0';
                  tx_eopin1 <= '0';
                  tx_eopin2 <= '0';
                  tx_eopin3 <= '0';
                  tx_mtyin0 <= x"0";
                  tx_mtyin1 <= x"0";
                  tx_mtyin2 <= x"0";
                  tx_mtyin3 <= x"0";
                  tx_sopin0 <= '0';
               when ELIM_BAD_SOP_STATE => -- Drop bad data on floor
                  if (s_axis_ppld_tlast = '1') or (s_axis_ppld_tvalid = '0') then
                     s_axis_ppld_tready <= '0';
                     state <= WAIT_SOP_STATE;
                  end if; 
               when SOP1_STATE =>
                  total_sum17 <= ('0' & total_sum(15 downto 0)) + (x"000" & '0' & total_sum(19 downto 16)); -- 17-bit sum - fold back in carry bits
                  state <= SOP2_STATE;
               when SOP2_STATE =>
                  hdr_cs_inv  <= total_sum17(15 downto 0) + total_sum17(16); -- if still a carry, add it back in
                  if header_mode = "00" then
                     s_axis_ppld_tready <= '1';
                     state <= START_MODE0_STATE;
                     if (s_axis_ppld_tuser(95 downto 80) < 32) then -- short packet
                        total_len   <= conv_std_logic_vector(66,16); -- length = payload len + headers
                        udp_len     <= conv_std_logic_vector(36,16);
                        vpkt_size   <= x"0008";
                        pad <= 32 - s_axis_ppld_tuser(85 downto 80);
                     else
                        total_len   <= s_axis_ppld_tuser(95 downto 80) + 28; -- length = paload len + headers
                        udp_len     <= s_axis_ppld_tuser(95 downto 80) + 8;
                        vpkt_size   <= "00" & s_axis_ppld_tuser(95 downto 82);
                        pad <= "000000";
                     end if;
                  elsif header_mode = "01" then
                     s_axis_ppld_tready <= '0';
                     state <= START_MODE1_STATE1;
                     if (s_axis_ppld_tuser(95 downto 80) < 4) then -- short packet
                        total_len   <= conv_std_logic_vector(66,16); -- length = payload len + headers
                        udp_len     <= conv_std_logic_vector(36,16);
                        vpkt_size   <= x"0008";
                        pad <= 4 - s_axis_ppld_tuser(85 downto 80);   
                     else
                        total_len   <= s_axis_ppld_tuser(95 downto 80) + 56; -- length = payload len + headers
                        udp_len     <= s_axis_ppld_tuser(95 downto 80) + 36;
                        vpkt_size   <= ("00" & s_axis_ppld_tuser(95 downto 82)) + 7;
                        pad <= "000000";
                     end if; 
                  else
                     s_axis_ppld_tready <= '0';
                     state <= START_MODE2_STATE1;
                     if (s_axis_ppld_tuser(95 downto 80) < 8) then -- short packet
                        total_len   <= conv_std_logic_vector(66,16); -- length = payload len + headers
                        udp_len     <= conv_std_logic_vector(36,16);
                        vpkt_size   <= x"0008";
                        pad <= 8 - s_axis_ppld_tuser(85 downto 80);   
                     else
                        total_len   <= s_axis_ppld_tuser(95 downto 80) + 52; -- length = payload len + headers
                        udp_len     <= s_axis_ppld_tuser(95 downto 80) + 32;
                        vpkt_size <= ("00" & s_axis_ppld_tuser(95 downto 82)) + 6;
                        pad <= "000000";
                     end if;
                  end if;                     
               when START_MODE0_STATE =>
                  tx_sopin0 <= '1';
                  tx_datain0 <=  hdr_mode0(335 downto 208);
                  tx_datain1 <=  hdr_mode0(207 downto 80); 
                  tx_datain2 <=  hdr_mode0(79 downto 0) & s_axis_ppld_tdata_rvs(511 downto 464); 
                  tx_datain3 <=  s_axis_ppld_tdata_rvs(463 downto 336);
                  t1_s_axis_ppld_tdata_rvs <= s_axis_ppld_tdata_rvs;
                  rem_bytes <= ppld_valid_bytes - 22;
                  if s_axis_ppld_tlast = '1' then
                     case ppld_valid_bytes is
                        when 0 to 6 =>
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '1';
                           tx_enain3 <= '0';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '1';
                           tx_eopin3 <= '0';
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= conv_std_logic_vector((6 - ppld_valid_bytes),4);
                           tx_mtyin3 <= x"0";
                           state <= WAIT_SOP_STATE;
                        when 7 to 22 => 
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '1';
                           tx_enain3 <= '1';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '0';
                           tx_eopin3 <= '1';
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= x"0";
                           tx_mtyin3 <= conv_std_logic_vector((22 - ppld_valid_bytes),4);
                           state <= WAIT_SOP_STATE;
                        when others =>
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '1';
                           tx_enain3 <= '1';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '0';
                           tx_eopin3 <= '0';    
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= x"0"; 
                           tx_mtyin3 <= x"0"; 
                           state <= FINISH_MODE0_STATE;
                     end case;   
                     s_axis_ppld_tready <= '0';
                  else   
                     tx_enain0 <= '1';
                     tx_enain1 <= '1';
                     tx_enain2 <= '1';
                     tx_enain3 <= '1';
                     tx_eopin0 <= '0';
                     tx_eopin1 <= '0';
                     tx_eopin2 <= '0';
                     tx_eopin3 <= '0';    
                     tx_mtyin0 <= x"0";
                     tx_mtyin1 <= x"0";
                     tx_mtyin2 <= x"0"; 
                     tx_mtyin3 <= x"0"; 
                     state <= MODE0_PACKET_STATE;
                  end if;
               when START_MODE1_STATE1  =>
                  tx_sopin0 <= '1';
                  tx_enain0 <= '1';
                  tx_enain1 <= '1';
                  tx_enain2 <= '1';
                  tx_enain3 <= '1';
                  tx_eopin0 <= '0';
                  tx_eopin1 <= '0';
                  tx_eopin2 <= '0';
                  tx_eopin3 <= '0';    
                  tx_mtyin0 <= x"0";
                  tx_mtyin1 <= x"0";
                  tx_mtyin2 <= x"0"; 
                  tx_mtyin3 <= x"0"; 
                  tx_datain0 <=  hdr_mode1(559 downto 432);
                  tx_datain1 <=  hdr_mode1(431 downto 304); 
                  tx_datain2 <=  hdr_mode1(303 downto 176); 
                  tx_datain3 <=  hdr_mode1(175 downto 48);
                  s_axis_ppld_tready <= '1';  
                  state <= START_MODE1_STATE2;           
               when START_MODE2_STATE1  =>
                  tx_sopin0 <= '1';
                  tx_enain0 <= '1';
                  tx_enain1 <= '1';
                  tx_enain2 <= '1';
                  tx_enain3 <= '1';
                  tx_eopin0 <= '0';
                  tx_eopin1 <= '0';
                  tx_eopin2 <= '0';
                  tx_eopin3 <= '0';    
                  tx_mtyin0 <= x"0";
                  tx_mtyin1 <= x"0";
                  tx_mtyin2 <= x"0"; 
                  tx_mtyin3 <= x"0"; 
                  tx_datain0 <=  hdr_mode2(527 downto 400);
                  tx_datain1 <=  hdr_mode2(399 downto 272); 
                  tx_datain2 <=  hdr_mode2(271 downto 144); 
                  tx_datain3 <=  hdr_mode2(143 downto 16);
                  s_axis_ppld_tready <= '1';    
                  state <= START_MODE2_STATE2;
               when START_MODE1_STATE2  =>
                  pktcnt <= pktcnt + 1;
                  tx_sopin0 <= '0';
                  tx_datain0 <=  hdr_mode1(47 downto 0) & s_axis_ppld_tdata_rvs(511 downto 432);
                  tx_datain1 <=  s_axis_ppld_tdata_rvs(431 downto 304); 
                  tx_datain2 <=  s_axis_ppld_tdata_rvs(303 downto 176); 
                  tx_datain3 <=  s_axis_ppld_tdata_rvs(175 downto 48);     
                  t1_s_axis_ppld_tdata_rvs <= s_axis_ppld_tdata_rvs;     
                  rem_bytes <= ppld_valid_bytes - 58;  
                  if s_axis_ppld_tlast = '1' then
                     case ppld_valid_bytes is
                        when 0 to 10 =>
                           tx_enain0 <= '1';
                           tx_enain1 <= '0';
                           tx_enain2 <= '0';
                           tx_enain3 <= '0';
                           tx_eopin0 <= '1';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '0';
                           tx_eopin3 <= '0';
                           tx_mtyin0 <= conv_std_logic_vector((10 - ppld_valid_bytes),4);
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= x"0";
                           tx_mtyin3 <= x"0";
                           state <= WAIT_SOP_STATE;
                        when 11 to 26 => 
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '0';
                           tx_enain3 <= '0';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '1';
                           tx_eopin2 <= '0';
                           tx_eopin3 <= '0';
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= conv_std_logic_vector((26 - ppld_valid_bytes), 4);
                           tx_mtyin2 <= x"0";
                           tx_mtyin3 <= x"0";
                           state <= WAIT_SOP_STATE;
                        when 27 to 42 => 
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '1';
                           tx_enain3 <= '0';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '1';
                           tx_eopin3 <= '0';
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= conv_std_logic_vector((42 - ppld_valid_bytes),4);
                           tx_mtyin3 <= x"0";
                           state <= WAIT_SOP_STATE;
                        when 43 to 58 => 
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '1';
                           tx_enain3 <= '1';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '0';
                           tx_eopin3 <= '1';
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= x"0";
                           tx_mtyin3 <= conv_std_logic_vector((58 - ppld_valid_bytes),4);
                           state <= WAIT_SOP_STATE;
                        when others =>
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '1';
                           tx_enain3 <= '1';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '0';
                           tx_eopin3 <= '0';    
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= x"0"; 
                           tx_mtyin3 <= x"0"; 
                           state <= FINISH_MODE1_STATE;
                     end case;   
                     s_axis_ppld_tready <= '0';
                  else   
                     tx_enain0 <= '1';
                     tx_enain1 <= '1';
                     tx_enain2 <= '1';
                     tx_enain3 <= '1';
                     tx_eopin0 <= '0';
                     tx_eopin1 <= '0';
                     tx_eopin2 <= '0';
                     tx_eopin3 <= '0';    
                     tx_mtyin0 <= x"0";
                     tx_mtyin1 <= x"0";
                     tx_mtyin2 <= x"0"; 
                     tx_mtyin3 <= x"0"; 
                     state <= MODE1_PACKET_STATE;
                  end if;
               when START_MODE2_STATE2  =>
                  pktcnt <= pktcnt + 1;
                  tx_sopin0  <= '0';
                  tx_datain0 <=  hdr_mode2(15 downto 0) & s_axis_ppld_tdata_rvs(511 downto 400);
                  tx_datain1 <=  s_axis_ppld_tdata_rvs(399 downto 272); 
                  tx_datain2 <=  s_axis_ppld_tdata_rvs(271 downto 144); 
                  tx_datain3 <=  s_axis_ppld_tdata_rvs(143 downto 16);
                  t1_s_axis_ppld_tdata_rvs <= s_axis_ppld_tdata_rvs;   
                  rem_bytes <= ppld_valid_bytes - 62;  
                  if s_axis_ppld_tlast = '1' then
                     case ppld_valid_bytes is
                        when 0 to 14 =>
                           tx_enain0 <= '1';
                           tx_enain1 <= '0';
                           tx_enain2 <= '0';
                           tx_enain3 <= '0';
                           tx_eopin0 <= '1';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '0';
                           tx_eopin3 <= '0';
                           tx_mtyin0 <= conv_std_logic_vector((14 - ppld_valid_bytes),4);
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= x"0";
                           tx_mtyin3 <= x"0";
                           state <= WAIT_SOP_STATE;
                        when 15 to 30 => 
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '0';
                           tx_enain3 <= '0';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '1';
                           tx_eopin2 <= '0';
                           tx_eopin3 <= '0';
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= conv_std_logic_vector((30 - ppld_valid_bytes),4);
                           tx_mtyin2 <= x"0";
                           tx_mtyin3 <= x"0";
                           state <= WAIT_SOP_STATE;
                        when 31 to 46 => 
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '1';
                           tx_enain3 <= '0';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '1';
                           tx_eopin3 <= '0';
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= conv_std_logic_vector((46 - ppld_valid_bytes),4);
                           tx_mtyin3 <= x"0";
                           state <= WAIT_SOP_STATE;
                        when 47 to 62 => 
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '1';
                           tx_enain3 <= '1';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '0';
                           tx_eopin3 <= '1';
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= x"0";
                           tx_mtyin3 <= conv_std_logic_vector((62 - ppld_valid_bytes),4);
                           state <= WAIT_SOP_STATE;
                        when others =>
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '1';
                           tx_enain3 <= '1';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '0';
                           tx_eopin3 <= '0';    
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= x"0"; 
                           tx_mtyin3 <= x"0"; 
                           state <= FINISH_MODE2_STATE;
                     end case;   
                     s_axis_ppld_tready <= '0';
                  else   
                     tx_enain0 <= '1';
                     tx_enain1 <= '1';
                     tx_enain2 <= '1';
                     tx_enain3 <= '1';
                     tx_eopin0 <= '0';
                     tx_eopin1 <= '0';
                     tx_eopin2 <= '0';
                     tx_eopin3 <= '0';    
                     tx_mtyin0 <= x"0";
                     tx_mtyin1 <= x"0";
                     tx_mtyin2 <= x"0"; 
                     tx_mtyin3 <= x"0"; 
                     state <= MODE2_PACKET_STATE;
                  end if;    
               when FINISH_MODE0_STATE =>
                  tx_sopin0  <= '0';
                  tx_datain0 <=  t1_s_axis_ppld_tdata_rvs(335 downto 208);
                  tx_datain1 <=  t1_s_axis_ppld_tdata_rvs(207 downto 80); 
                  tx_datain2 <=  t1_s_axis_ppld_tdata_rvs(79 downto 0) & x"000000000000"; 
                  tx_datain3 <=  (others => '0');
                  case rem_bytes is
                     when 0 to 16 =>
                        tx_enain0 <= '1';
                        tx_enain1 <= '0';
                        tx_enain2 <= '0';
                        tx_enain3 <= '0';
                        tx_eopin0 <= '1';
                        tx_eopin1 <= '0';
                        tx_eopin2 <= '0';
                        tx_eopin3 <= '0';
                        tx_mtyin0 <= conv_std_logic_vector((16 - rem_bytes),4);
                        tx_mtyin1 <= x"0";
                        tx_mtyin2 <= x"0";
                        tx_mtyin3 <= x"0";      
                     when 17 to 32 => 
                        tx_enain0 <= '1';
                        tx_enain1 <= '1';
                        tx_enain2 <= '0';
                        tx_enain3 <= '0';
                        tx_eopin0 <= '0';
                        tx_eopin1 <= '1';
                        tx_eopin2 <= '0';
                        tx_eopin3 <= '0';
                        tx_mtyin0 <= x"0";
                        tx_mtyin1 <= conv_std_logic_vector((32 - rem_bytes),4);
                        tx_mtyin2 <= x"0";
                        tx_mtyin3 <= x"0";
                     when others =>
                        tx_enain0 <= '1';
                        tx_enain1 <= '1';
                        tx_enain2 <= '1';
                        tx_enain3 <= '0';
                        tx_eopin0 <= '0';
                        tx_eopin1 <= '0';
                        tx_eopin2 <= '1';
                        tx_eopin3 <= '0';
                        tx_mtyin0 <= x"0";
                        tx_mtyin1 <= x"0";
                        tx_mtyin2 <= conv_std_logic_vector((42 - rem_bytes),4);
                        tx_mtyin3 <= x"0";
                  end case;  
                  state <= WAIT_SOP_STATE; 
               when FINISH_MODE1_STATE =>
                  tx_sopin0 <= '0';
                  tx_datain0 <=  t1_s_axis_ppld_tdata_rvs(47 downto 0) & x"00000000000000000000";
                  tx_datain1 <=  (others => '0');
                  tx_datain2 <=  (others => '0');
                  tx_datain3 <=  (others => '0');
                  tx_enain0 <= '1';
                  tx_enain1 <= '0';
                  tx_enain2 <= '0';
                  tx_enain3 <= '0';
                  tx_eopin0 <= '1';
                  tx_eopin1 <= '0';
                  tx_eopin2 <= '0';
                  tx_eopin3 <= '0';
                  tx_mtyin0 <= conv_std_logic_vector((6 - rem_bytes),4);
                  tx_mtyin1 <= x"0";
                  tx_mtyin2 <= x"0";
                  tx_mtyin3 <= x"0";      
                  state <= WAIT_SOP_STATE; 
               when FINISH_MODE2_STATE =>
                  tx_sopin0 <= '0';
                  tx_datain0 <=  t1_s_axis_ppld_tdata_rvs(15 downto 0) & x"0000000000000000000000000000";
                  tx_datain1 <=  (others => '0');
                  tx_datain2 <=  (others => '0');
                  tx_datain3 <=  (others => '0');
                  tx_enain0 <= '1';
                  tx_enain1 <= '0';
                  tx_enain2 <= '0';
                  tx_enain3 <= '0';
                  tx_eopin0 <= '1';
                  tx_eopin1 <= '0';
                  tx_eopin2 <= '0';
                  tx_eopin3 <= '0';
                  tx_mtyin0 <= conv_std_logic_vector((2 - rem_bytes),4);
                  tx_mtyin1 <= x"0";
                  tx_mtyin2 <= x"0";
                  tx_mtyin3 <= x"0";      
                  state <= WAIT_SOP_STATE; 
               when MODE0_PACKET_STATE =>
                  tx_sopin0 <= '0';
                  rem_bytes <= ppld_valid_bytes - 22;
                  if s_axis_ppld_tlast = '1' then
                     case ppld_valid_bytes is
                        when 0 to 6 =>
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '1';
                           tx_enain3 <= '0';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '1';
                           tx_eopin3 <= '0';
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= conv_std_logic_vector((6 - ppld_valid_bytes),4);
                           tx_mtyin3 <= x"0";
                           state <= WAIT_SOP_STATE;
                        when 7 to 22 => 
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '1';
                           tx_enain3 <= '1';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '0';
                           tx_eopin3 <= '1';
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= x"0";
                           tx_mtyin3 <= conv_std_logic_vector((22 - ppld_valid_bytes),4);
                           state <= WAIT_SOP_STATE;
                        when others =>
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '1';
                           tx_enain3 <= '1';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '0';
                           tx_eopin3 <= '0';    
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= x"0"; 
                           tx_mtyin3 <= x"0"; 
                           state <= FINISH_MODE0_STATE;
                     end case;   
                     s_axis_ppld_tready <= '0';
                  elsif (tx_rdyout = '0') then -- hold off from 100ge core
                     state <= HOLDOFF_WAIT;
                     tx_enain0 <= '1';
                     tx_enain1 <= '1';
                     tx_enain2 <= '1';
                     tx_enain3 <= '1';
                     tx_eopin0 <= '0';
                     tx_eopin1 <= '0';
                     tx_eopin2 <= '0';
                     tx_eopin3 <= '0';    
                     tx_mtyin0 <= x"0";
                     tx_mtyin1 <= x"0";
                     tx_mtyin2 <= x"0"; 
                     tx_mtyin3 <= x"0"; 
                     s_axis_ppld_tready <= '0';
                  else
                     state <= MODE0_PACKET_STATE;
                     tx_enain0 <= '1';
                     tx_enain1 <= '1';
                     tx_enain2 <= '1';
                     tx_enain3 <= '1';
                     tx_eopin0 <= '0';
                     tx_eopin1 <= '0';
                     tx_eopin2 <= '0';
                     tx_eopin3 <= '0';    
                     tx_mtyin0 <= x"0";
                     tx_mtyin1 <= x"0";
                     tx_mtyin2 <= x"0"; 
                     tx_mtyin3 <= x"0"; 
                  end if;
                  tx_datain0 <=  t1_s_axis_ppld_tdata_rvs(335 downto 208);
                  tx_datain1 <=  t1_s_axis_ppld_tdata_rvs(207 downto 80); 
                  tx_datain2 <=  t1_s_axis_ppld_tdata_rvs(79 downto 0) & s_axis_ppld_tdata_rvs(511 downto 464); 
                  tx_datain3 <=  s_axis_ppld_tdata_rvs(463 downto 336);
                  t1_s_axis_ppld_tdata_rvs <= s_axis_ppld_tdata_rvs;
               when MODE1_PACKET_STATE =>
                  tx_sopin0 <= '0';
                  rem_bytes <= ppld_valid_bytes - 58;
                  if s_axis_ppld_tlast = '1' then
                     case ppld_valid_bytes is
                        when 0 to 10 =>
                           tx_enain0 <= '1';
                           tx_enain1 <= '0';
                           tx_enain2 <= '0';
                           tx_enain3 <= '0';
                           tx_eopin0 <= '1';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '0';
                           tx_eopin3 <= '0';
                           tx_mtyin0 <= conv_std_logic_vector((10 - ppld_valid_bytes),4);
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= x"0";
                           tx_mtyin3 <= x"0";
                           state <= WAIT_SOP_STATE;
                        when 11 to 26 => 
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '0';
                           tx_enain3 <= '0';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '1';
                           tx_eopin2 <= '0';
                           tx_eopin3 <= '0';
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= conv_std_logic_vector((26 - ppld_valid_bytes), 4);
                           tx_mtyin2 <= x"0";
                           tx_mtyin3 <= x"0";
                           state <= WAIT_SOP_STATE;
                        when 27 to 42 => 
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '1';
                           tx_enain3 <= '0';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '1';
                           tx_eopin3 <= '0';
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= conv_std_logic_vector((42 - ppld_valid_bytes),4);
                           tx_mtyin3 <= x"0";
                           state <= WAIT_SOP_STATE;
                        when 43 to 58 => 
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '1';
                           tx_enain3 <= '1';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '0';
                           tx_eopin3 <= '1';
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= x"0";
                           tx_mtyin3 <= conv_std_logic_vector((58 - ppld_valid_bytes),4);
                           state <= WAIT_SOP_STATE;
                        when others =>
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '1';
                           tx_enain3 <= '1';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '0';
                           tx_eopin3 <= '0';    
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= x"0"; 
                           tx_mtyin3 <= x"0"; 
                           state <= FINISH_MODE1_STATE;
                     end case;   
                     s_axis_ppld_tready <= '0';
                  elsif (tx_rdyout = '0') then -- hold off from 100ge core
                     state <= HOLDOFF_WAIT;
                     tx_enain0 <= '1';
                     tx_enain1 <= '1';
                     tx_enain2 <= '1';
                     tx_enain3 <= '1';
                     tx_eopin0 <= '0';
                     tx_eopin1 <= '0';
                     tx_eopin2 <= '0';
                     tx_eopin3 <= '0';    
                     tx_mtyin0 <= x"0";
                     tx_mtyin1 <= x"0";
                     tx_mtyin2 <= x"0"; 
                     tx_mtyin3 <= x"0"; 
                     s_axis_ppld_tready <= '0';
                  else
                     state <= MODE1_PACKET_STATE;
                     tx_enain0 <= '1';
                     tx_enain1 <= '1';
                     tx_enain2 <= '1';
                     tx_enain3 <= '1';
                     tx_eopin0 <= '0';
                     tx_eopin1 <= '0';
                     tx_eopin2 <= '0';
                     tx_eopin3 <= '0';    
                     tx_mtyin0 <= x"0";
                     tx_mtyin1 <= x"0";
                     tx_mtyin2 <= x"0"; 
                     tx_mtyin3 <= x"0"; 
                  end if;
                  tx_datain0 <=  t1_s_axis_ppld_tdata_rvs(47 downto 0) & s_axis_ppld_tdata_rvs(511 downto 432);
                  tx_datain1 <=  s_axis_ppld_tdata_rvs(431 downto 304); 
                  tx_datain2 <=  s_axis_ppld_tdata_rvs(303 downto 176); 
                  tx_datain3 <=  s_axis_ppld_tdata_rvs(175 downto 48);     
                  t1_s_axis_ppld_tdata_rvs <= s_axis_ppld_tdata_rvs;        
               when MODE2_PACKET_STATE =>
                  tx_sopin0 <= '0';
                  rem_bytes <= ppld_valid_bytes - 62;  
                  if s_axis_ppld_tlast = '1' then
                     case ppld_valid_bytes is
                        when 0 to 14 =>
                           tx_enain0 <= '1';
                           tx_enain1 <= '0';
                           tx_enain2 <= '0';
                           tx_enain3 <= '0';
                           tx_eopin0 <= '1';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '0';
                           tx_eopin3 <= '0';
                           tx_mtyin0 <= conv_std_logic_vector((14 - ppld_valid_bytes),4);
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= x"0";
                           tx_mtyin3 <= x"0";
                           state <= WAIT_SOP_STATE;
                        when 15 to 30 => 
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '0';
                           tx_enain3 <= '0';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '1';
                           tx_eopin2 <= '0';
                           tx_eopin3 <= '0';
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= conv_std_logic_vector((30 - ppld_valid_bytes),4);
                           tx_mtyin2 <= x"0";
                           tx_mtyin3 <= x"0";
                           state <= WAIT_SOP_STATE;
                        when 31 to 46 => 
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '1';
                           tx_enain3 <= '0';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '1';
                           tx_eopin3 <= '0';
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= conv_std_logic_vector((46 - ppld_valid_bytes),4);
                           tx_mtyin3 <= x"0";
                           state <= WAIT_SOP_STATE;
                        when 47 to 62 => 
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '1';
                           tx_enain3 <= '1';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '0';
                           tx_eopin3 <= '1';
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= x"0";
                           tx_mtyin3 <= conv_std_logic_vector((62 - ppld_valid_bytes),4);
                           state <= WAIT_SOP_STATE;
                        when others =>
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '1';
                           tx_enain3 <= '1';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '0';
                           tx_eopin3 <= '0';    
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= x"0"; 
                           tx_mtyin3 <= x"0"; 
                           state <= FINISH_MODE2_STATE;
                     end case;   
                     s_axis_ppld_tready <= '0';
                  elsif (tx_rdyout = '0') then -- hold off from 100ge core
                     state <= HOLDOFF_WAIT;
                     tx_enain0 <= '1';
                     tx_enain1 <= '1';
                     tx_enain2 <= '1';
                     tx_enain3 <= '1';
                     tx_eopin0 <= '0';
                     tx_eopin1 <= '0';
                     tx_eopin2 <= '0';
                     tx_eopin3 <= '0';    
                     tx_mtyin0 <= x"0";
                     tx_mtyin1 <= x"0";
                     tx_mtyin2 <= x"0"; 
                     tx_mtyin3 <= x"0"; 
                     s_axis_ppld_tready <= '0';
                  else
                     state <= MODE2_PACKET_STATE;
                     tx_enain0 <= '1';
                     tx_enain1 <= '1';
                     tx_enain2 <= '1';
                     tx_enain3 <= '1';
                     tx_eopin0 <= '0';
                     tx_eopin1 <= '0';
                     tx_eopin2 <= '0';
                     tx_eopin3 <= '0';    
                     tx_mtyin0 <= x"0";
                     tx_mtyin1 <= x"0";
                     tx_mtyin2 <= x"0"; 
                     tx_mtyin3 <= x"0"; 
                  end if;
                  tx_datain0 <=  t1_s_axis_ppld_tdata_rvs(15 downto 0) & s_axis_ppld_tdata_rvs(511 downto 400);
                  tx_datain1 <=  s_axis_ppld_tdata_rvs(399 downto 272); 
                  tx_datain2 <=  s_axis_ppld_tdata_rvs(271 downto 144); 
                  tx_datain3 <=  s_axis_ppld_tdata_rvs(143 downto 16);
                  t1_s_axis_ppld_tdata_rvs <= s_axis_ppld_tdata_rvs; 
               
               --------------------------------------------------------------
               -- Special Mode Where Incoming Data Already Has Header Data
               --------------------------------------------------------------   
               when MODE3_PACKET_STATE => -- Packet already has header
                  mode3_sop <= '0';
                  tx_sopin0 <= mode3_sop;
                  rem_bytes <= ppld_valid_bytes - 62;  
                  if s_axis_ppld_tlast = '1' then
                     case ppld_valid_bytes is
                        when 0 to 16 =>
                           tx_enain0 <= '1';
                           tx_enain1 <= '0';
                           tx_enain2 <= '0';
                           tx_enain3 <= '0';
                           tx_eopin0 <= '1';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '0';
                           tx_eopin3 <= '0';
                           tx_mtyin0 <= conv_std_logic_vector((16 - ppld_valid_bytes),4);
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= x"0";
                           tx_mtyin3 <= x"0";
                           state <= WAIT_SOP_STATE;
                        when 17 to 32 => 
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '0';
                           tx_enain3 <= '0';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '1';
                           tx_eopin2 <= '0';
                           tx_eopin3 <= '0';
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= conv_std_logic_vector((32 - ppld_valid_bytes),4);
                           tx_mtyin2 <= x"0";
                           tx_mtyin3 <= x"0";
                           state <= WAIT_SOP_STATE;
                        when 33 to 48 => 
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '1';
                           tx_enain3 <= '0';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '1';
                           tx_eopin3 <= '0';
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= conv_std_logic_vector((48 - ppld_valid_bytes),4);
                           tx_mtyin3 <= x"0";
                           state <= WAIT_SOP_STATE;
                        when 49 to 64 => 
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '1';
                           tx_enain3 <= '1';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '0';
                           tx_eopin3 <= '1';
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= x"0";
                           tx_mtyin3 <= conv_std_logic_vector((64 - ppld_valid_bytes),4);
                           state <= WAIT_SOP_STATE;
                        when others =>
                           tx_enain0 <= '1';
                           tx_enain1 <= '1';
                           tx_enain2 <= '1';
                           tx_enain3 <= '1';
                           tx_eopin0 <= '0';
                           tx_eopin1 <= '0';
                           tx_eopin2 <= '0';
                           tx_eopin3 <= '0';    
                           tx_mtyin0 <= x"0";
                           tx_mtyin1 <= x"0";
                           tx_mtyin2 <= x"0"; 
                           tx_mtyin3 <= x"0"; 
                           state <= WAIT_SOP_STATE;
                     end case;   
                     s_axis_ppld_tready <= '0';
                  elsif (tx_rdyout = '0') then -- hold off from 100ge core
                     state <= HOLDOFF_WAIT3;
                     tx_enain0 <= '1';
                     tx_enain1 <= '1';
                     tx_enain2 <= '1';
                     tx_enain3 <= '1';
                     tx_eopin0 <= '0';
                     tx_eopin1 <= '0';
                     tx_eopin2 <= '0';
                     tx_eopin3 <= '0';    
                     tx_mtyin0 <= x"0";
                     tx_mtyin1 <= x"0";
                     tx_mtyin2 <= x"0"; 
                     tx_mtyin3 <= x"0"; 
                     s_axis_ppld_tready <= '0';
                  else
                     state <= MODE3_PACKET_STATE;
                     tx_enain0 <= '1';
                     tx_enain1 <= '1';
                     tx_enain2 <= '1';
                     tx_enain3 <= '1';
                     tx_eopin0 <= '0';
                     tx_eopin1 <= '0';
                     tx_eopin2 <= '0';
                     tx_eopin3 <= '0';    
                     tx_mtyin0 <= x"0";
                     tx_mtyin1 <= x"0";
                     tx_mtyin2 <= x"0"; 
                     tx_mtyin3 <= x"0"; 
                  end if;
                  tx_datain0 <=  s_axis_ppld_tdata_rvs(511 downto 384);
                  tx_datain1 <=  s_axis_ppld_tdata_rvs(383 downto 256); 
                  tx_datain2 <=  s_axis_ppld_tdata_rvs(255 downto 128); 
                  tx_datain3 <=  s_axis_ppld_tdata_rvs(127 downto 0);                  
                   
               when HOLDOFF_WAIT =>
                  tx_enain0 <= '0';
                  tx_enain1 <= '0';
                  tx_enain2 <= '0';
                  tx_enain3 <= '0';
                  tx_eopin0 <= '0';
                  tx_eopin1 <= '0';
                  tx_eopin2 <= '0';
                  tx_eopin3 <= '0';    
                  tx_mtyin0 <= x"0";
                  tx_mtyin1 <= x"0";
                  tx_mtyin2 <= x"0"; 
                  tx_mtyin3 <= x"0"; 
                  if (tx_rdyout = '1') then
                     s_axis_ppld_tready <= '1';
                     case header_mode is
                        when "00" =>
                           state <= MODE0_PACKET_STATE;
                        when "01" =>
                           state <= MODE1_PACKET_STATE;
                        when "10" =>
                           state <= MODE2_PACKET_STATE;
                        when others =>
                           state <= MODE2_PACKET_STATE; 
                    end case;                         
                  end if;
               when HOLDOFF_WAIT3 =>
                  tx_enain0 <= '0';
                  tx_enain1 <= '0';
                  tx_enain2 <= '0';
                  tx_enain3 <= '0';
                  tx_eopin0 <= '0';
                  tx_eopin1 <= '0';
                  tx_eopin2 <= '0';
                  tx_eopin3 <= '0';    
                  tx_mtyin0 <= x"0";
                  tx_mtyin1 <= x"0";
                  tx_mtyin2 <= x"0"; 
                  tx_mtyin3 <= x"0"; 
                  if (tx_rdyout = '1') then
                     s_axis_ppld_tready <= '1';
                     state <= MODE3_PACKET_STATE;         
                  end if;
               when others => 
                  state <= RESET_STATE;
            end case;
         end if;        
      end if;
end process;    

--------------------------------------------------------------------------------
-- Channel Look-Up Table
--------------------------------------------------------------------------------
-- Latency = 2

-- Lookup Table
-- Channel X UDP Src/Dest Port Number
-- Channel X VITA 49 Stream ID 
-- Channel X VITA 49 Class Code Word 1
-- Channel X VITA 49 Class Code Word 2

lut_inst : xpm_memory_tdpram
   generic map (
      ADDR_WIDTH_A => 10,               -- DECIMAL
      ADDR_WIDTH_B => 8,               -- DECIMAL
      AUTO_SLEEP_TIME => 0,            -- DECIMAL
      BYTE_WRITE_WIDTH_A => 8,        -- DECIMAL
      BYTE_WRITE_WIDTH_B => 128,        -- DECIMAL
      CLOCKING_MODE => "independent_clock", -- String
      ECC_MODE => "no_ecc",            -- String
      MEMORY_INIT_FILE => "none",      -- String
      MEMORY_INIT_PARAM => "0",        -- String
      MEMORY_OPTIMIZATION => "true",   -- String
      MEMORY_PRIMITIVE => "auto",      -- String
      MEMORY_SIZE => 32768,             -- DECIMAL
      MESSAGE_CONTROL => 0,            -- DECIMAL
      READ_DATA_WIDTH_A => 32,         -- DECIMAL
      READ_DATA_WIDTH_B => 128,         -- DECIMAL
      READ_LATENCY_A => 2,             -- DECIMAL
      READ_LATENCY_B => 2,             -- DECIMAL
      READ_RESET_VALUE_A => "0",       -- String
      READ_RESET_VALUE_B => "0",       -- String
      USE_EMBEDDED_CONSTRAINT => 0,    -- DECIMAL
      USE_MEM_INIT => 1,               -- DECIMAL
      WAKEUP_TIME => "disable_sleep",  -- String
      WRITE_DATA_WIDTH_A => 32,        -- DECIMAL
      WRITE_DATA_WIDTH_B => 128,        -- DECIMAL
      WRITE_MODE_A => "no_change",     -- String
      WRITE_MODE_B => "no_change"      -- String
   )
   port map (
      dbiterra => open,             -- 1-bit output: Status signal to indicate double bit error occurrence
                                        -- on the data output of port A.
      dbiterrb => open,             -- 1-bit output: Status signal to indicate double bit error occurrence
                                        -- on the data output of port A.
      douta    => bram_rddata,                   -- READ_DATA_WIDTH_A-bit output: Data output for port A read operations.
      doutb    => lut_data,                   -- READ_DATA_WIDTH_B-bit output: Data output for port B read operations.
      sbiterra => open,             -- 1-bit output: Status signal to indicate single bit error occurrence
                                        -- on the data output of port A.
      sbiterrb => open,             -- 1-bit output: Status signal to indicate single bit error occurrence
                                        -- on the data output of port B.
      addra    => bram_addr,                   -- ADDR_WIDTH_A-bit input: Address for port A write and read operations.
      addrb    => lut_addr,                   -- ADDR_WIDTH_B-bit input: Address for port B write and read operations.
      clka     => s_axi_csr_aclk,                     -- 1-bit input: Clock signal for port A. Also clocks port B when
                                        -- parameter CLOCKING_MODE is "common_clock".
      clkb     => txclk,                     -- 1-bit input: Clock signal for port B when parameter CLOCKING_MODE is
                                        -- "independent_clock". Unused when parameter CLOCKING_MODE is
                                        -- "common_clock".
      dina     => bram_wrdata,                     -- WRITE_DATA_WIDTH_A-bit input: Data input for port A write operations.
      dinb     => x"00000000000000000000000000000000",                     -- WRITE_DATA_WIDTH_B-bit input: Data input for port B write operations.
      ena      => bram_en,                       -- 1-bit input: Memory enable signal for port A. Must be high on clock
                                        -- cycles when read or write operations are initiated. Pipelined
                                        -- internally.
      enb      => '1',                       -- 1-bit input: Memory enable signal for port B. Must be high on clock
                                        -- cycles when read or write operations are initiated. Pipelined
                                        -- internally.
      injectdbiterra => '0', -- 1-bit input: Controls double bit error injection on input data when
                                        -- ECC enabled (Error injection capability is not available in
                                        -- "decode_only" mode).
      injectdbiterrb => '0', -- 1-bit input: Controls double bit error injection on input data when
                                        -- ECC enabled (Error injection capability is not available in
                                        -- "decode_only" mode).
      injectsbiterra => '0', -- 1-bit input: Controls single bit error injection on input data when
                                        -- ECC enabled (Error injection capability is not available in
                                        -- "decode_only" mode).
      injectsbiterrb => '0', -- 1-bit input: Controls single bit error injection on input data when
                                        -- ECC enabled (Error injection capability is not available in
                                        -- "decode_only" mode).
      regcea   => '1',                 -- 1-bit input: Clock Enable for the last register stage on the output
                                        -- data path.
      regceb   => '1',                 -- 1-bit input: Clock Enable for the last register stage on the output
                                        -- data path.
      rsta     => bram_rst,                     -- 1-bit input: Reset signal for the final port A output register
                                        -- stage. Synchronously resets output port douta to the value specified
                                        -- by parameter READ_RESET_VALUE_A.
      rstb     => '0',                     -- 1-bit input: Reset signal for the final port B output register
                                        -- stage. Synchronously resets output port doutb to the value specified
                                        -- by parameter READ_RESET_VALUE_B.
      sleep    => '0',                   -- 1-bit input: sleep signal to enable the dynamic power saving feature.
      wea      => bram_we,                       -- WRITE_DATA_WIDTH_A-bit input: Write enable vector for port A input
                                        -- data port dina. 1 bit wide when word-wide writes are used. In
                                        -- byte-wide write configurations, each bit controls the writing one
                                        -- byte of dina to address addra. For example, to synchronously write
                                        -- only bits [15-8] of dina when WRITE_DATA_WIDTH_A is 32, wea would be
                                        -- 4'b0010.
      web     => "0"                        -- WRITE_DATA_WIDTH_B-bit input: Write enable vector for port B input
                                        -- data port dinb. 1 bit wide when word-wide writes are used. In
                                        -- byte-wide write configurations, each bit controls the writing one
                                        -- byte of dinb to address addrb. For example, to synchronously write
                                        -- only bits [15-8] of dinb when WRITE_DATA_WIDTH_B is 32, web would be
                                        -- 4'b0010.
 );
 
  
-- Channel X UDP Src/Dest Port Number
-- Channel X VITA 49 Stream ID 
-- Channel X VITA 49 Class Code Word 1
-- Channel X VITA 49 Class Code Word 2

udp_src_port  <= lut_data(31 downto 16);
udp_dest_port <= lut_data(15 downto 0); 
stream_id     <= lut_data(63 downto 32); 
class_code1   <= lut_data(95 downto 64);  
class_code2   <= lut_data(127 downto 96);  

--------------------------------------------------------------------------------
-- AXI-Lite BRAM Controller
--------------------------------------------------------------------------------

brctlr_inst : px_ppld2udp100ge_brctlr
  port map (
    s_axi_aclk       => s_axi_csr_aclk,
    s_axi_aresetn    => t1_s_axi_csr_aresetn,
    s_axi_awaddr     => sw_axi_awaddr(24 downto 13),
    s_axi_awprot     => sw_axi_awprot(5 downto 3),
    s_axi_awvalid    => sw_axi_awvalid(1),
    s_axi_awready    => sw_axi_awready(1),
    s_axi_wdata      => sw_axi_wdata(63 downto 32),
    s_axi_wstrb      => sw_axi_wstrb(7 downto 4),
    s_axi_wvalid     => sw_axi_wvalid(1),
    s_axi_wready     => sw_axi_wready(1),
    s_axi_bresp      => sw_axi_bresp(3 downto 2),
    s_axi_bvalid     => sw_axi_bvalid(1),
    s_axi_bready     => sw_axi_bready(1),
    s_axi_araddr     => sw_axi_araddr(24 downto 13),
    s_axi_arprot     => sw_axi_arprot(5 downto 3),
    s_axi_arvalid    => sw_axi_arvalid(1),
    s_axi_arready    => sw_axi_arready(1),
    s_axi_rdata      => sw_axi_rdata(63 downto 32),
    s_axi_rresp      => sw_axi_rresp(3 downto 2),
    s_axi_rvalid     => sw_axi_rvalid(1),
    s_axi_rready     => sw_axi_rready(1),
    bram_rst         => bram_rst,
    bram_clk         => open,
    bram_en          => bram_en,
    bram_we          => bram_we,
    bram_addr        => bram_addr,
    bram_wrdata      => bram_wrdata,
    bram_rddata      => bram_rddata
  );
  

  -- Register Map
  
  -- 0x00 Source MAC Address[31:0]
  -- 0x04 Destinaton MAC Address[31:0]
  -- 0x08 Destination MAC Address[47 downto 32]/Source MAC Address[47 downto 32] 
  -- 0x0C Source IPV4 Address
  -- 0x10 Destinaton IPV4 Address
  -- 0x14 Control Register
  
  -- Control Register
  -- bit [0] Reset
  -- bit [1] TX Enable Output
  -- bit [3:2] Packet Payload Size
  -- bit [4] External FIFO Flush
  -- bit [5] Enable VITA 49
  -- bit [6] Timestamp Mode 0 = Free running 1 = PPS + Sample Count
  -- bit [7] TSI Source 0=UTC 1=GPS
  
  
csr_inst : px_ppld2udp100ge_csr
port map (
  s_axi_csr_aclk     => s_axi_csr_aclk,
  s_axi_csr_aresetn  => t1_s_axi_csr_aresetn,
  s_axi_csr_awaddr   => sw_axi_awaddr(6 downto 0),
  s_axi_csr_awprot   => sw_axi_awprot(2 downto 0),
  s_axi_csr_awvalid  => sw_axi_awvalid(0),
  s_axi_csr_awready  => sw_axi_awready(0),
  s_axi_csr_wdata    => sw_axi_wdata(31 downto 0),
  s_axi_csr_wstrb    => sw_axi_wstrb(3 downto 0),
  s_axi_csr_wvalid   => sw_axi_wvalid(0),
  s_axi_csr_wready   => sw_axi_wready(0),
  s_axi_csr_bresp    => sw_axi_bresp(1 downto 0),
  s_axi_csr_bvalid   => sw_axi_bvalid(0),
  s_axi_csr_bready   => sw_axi_bready(0),
  s_axi_csr_araddr   => sw_axi_araddr(6 downto 0),
  s_axi_csr_arprot   => sw_axi_arprot(2 downto 0),
  s_axi_csr_arvalid  => sw_axi_arvalid(0),
  s_axi_csr_arready  => sw_axi_arready(0),
  s_axi_csr_rdata    => sw_axi_rdata(31 downto 0),
  s_axi_csr_rresp    => sw_axi_rresp(1 downto 0),
  s_axi_csr_rvalid   => sw_axi_rvalid(0),
  s_axi_csr_rready   => sw_axi_rready(0),
  reg0_init_val      => x"00000000",
  reg1_init_val      => x"00000000",
  reg2_init_val      => x"00000000",
  reg3_init_val      => x"00000000",
  reg4_init_val      => x"00000000",
  reg5_init_val      => x"00000000",
  ctl0_out           => ctl0_out,
  ctl1_out           => ctl1_out,
  ctl2_out           => ctl2_out,
  ctl3_out           => ctl3_out,
  ctl4_out           => ctl4_out,
  ctl5_out           => ctl5_out,
  intrpt_src_in      => intrpt_src_in,
  irq => irq_x
);

--------------------------------------------------------------------------------
-- AXI Switch
--------------------------------------------------------------------------------

axi_xbar_inst : px_ppld2udp100ge_axi_xbar
  PORT MAP (
    aclk => s_axi_csr_aclk,
    aresetn => t1_s_axi_csr_aresetn,
    s_axi_awaddr => s_axi_csr_awaddr,
    s_axi_awprot => s_axi_csr_awprot,
    s_axi_awvalid(0) => s_axi_csr_awvalid,
    s_axi_awready(0) => s_axi_csr_awready,
    s_axi_wdata => s_axi_csr_wdata,
    s_axi_wstrb => s_axi_csr_wstrb,
    s_axi_wvalid(0) => s_axi_csr_wvalid,
    s_axi_wready(0) => s_axi_csr_wready,
    s_axi_bresp => s_axi_csr_bresp,
    s_axi_bvalid(0) => s_axi_csr_bvalid,
    s_axi_bready(0) => s_axi_csr_bready,
    s_axi_araddr => s_axi_csr_araddr,
    s_axi_arprot => s_axi_csr_arprot,
    s_axi_arvalid(0) => s_axi_csr_arvalid,
    s_axi_arready(0) => s_axi_csr_arready,
    s_axi_rdata => s_axi_csr_rdata,
    s_axi_rresp => s_axi_csr_rresp,
    s_axi_rvalid(0) => s_axi_csr_rvalid,
    s_axi_rready(0) => s_axi_csr_rready,
    m_axi_awaddr => sw_axi_awaddr,
    m_axi_awprot => sw_axi_awprot,
    m_axi_awvalid => sw_axi_awvalid,
    m_axi_awready => sw_axi_awready,
    m_axi_wdata => sw_axi_wdata,
    m_axi_wstrb => sw_axi_wstrb,
    m_axi_wvalid => sw_axi_wvalid,
    m_axi_wready => sw_axi_wready,
    m_axi_bresp => sw_axi_bresp,
    m_axi_bvalid => sw_axi_bvalid,
    m_axi_bready => sw_axi_bready,
    m_axi_araddr => sw_axi_araddr,
    m_axi_arprot => sw_axi_arprot,
    m_axi_arvalid => sw_axi_arvalid,
    m_axi_arready => sw_axi_arready,
    m_axi_rdata => sw_axi_rdata,
    m_axi_rresp => sw_axi_rresp,
    m_axi_rvalid => sw_axi_rvalid,
    m_axi_rready => sw_axi_rready
  );

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      irq <= irq_x;
      t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
      rst_reg <= (not t1_s_axi_csr_aresetn) or ctl5_out(0);
      if (ctl5_out(5) = '0') then-- not VITA49 mode
         h_mode  <= "00";
      else
         if (ctl5_out(6) = '0') then-- free running
             h_mode  <= "10";
         else -- PPS + Sample Count
             h_mode  <= "01";
         end if;
      end if;
      if (ctl5_out(7) = '0') then 
         time_type <= "01"; -- UTC
      else
         time_type <= "10"; -- GPS
      end if; 
   end if;
end process;   

ctl <= ctl5_out(4) & h_mode & time_type & ctl5_out(3 downto 1);

-------------------------------------
-- Clock Crossing of Control Signals
-------------------------------------

xpm_cdc_sync_rst_inst : xpm_cdc_sync_rst
generic map (
   DEST_SYNC_FF => 2,   -- DECIMAL; range: 2-10
   INIT => 1,           -- DECIMAL; 0=initialize synchronization registers to 0, 1=initialize
                        -- synchronization registers to 1
   INIT_SYNC_FF => 1,   -- DECIMAL; integer; 0=disable simulation init values, 1=enable simulation init
                        -- values
   SIM_ASSERT_CHK => 0  -- DECIMAL; integer; 0=disable simulation messages, 1=enable simulation messages
)
port map (
   dest_rst => rst_reg_x, -- 1-bit output: src_rst synchronized to the destination clock domain. This output
                         -- is registered.
   dest_clk => txclk, -- 1-bit input: Destination clock.
   src_rst => rst_reg    -- 1-bit input: Source reset signal.
);

ctl_cdc_inst : xpm_cdc_array_single
generic map (
   DEST_SYNC_FF => 3,   -- DECIMAL; range: 2-10
   INIT_SYNC_FF => 0,   -- DECIMAL; integer; 0=disable simulation init values, 1=enable simulation init
                        -- values
   SIM_ASSERT_CHK => 0, -- DECIMAL; integer; 0=disable simulation messages, 1=enable simulation messages
   SRC_INPUT_REG => 1,  -- DECIMAL; 0=do not register input, 1=register input
   WIDTH => 8           -- DECIMAL; range: 1-1024
)
port map (
   dest_out => ctl_x, -- WIDTH-bit output: src_in synchronized to the destination clock domain. This
                         -- output is registered
   dest_clk => txclk, -- 1-bit input: Clock signal for the destination clock domain.
   src_clk => s_axi_csr_aclk,   -- 1-bit input: optional; required when SRC_INPUT_REG = 1
   src_in => ctl      -- WIDTH-bit input: Input single-bit array to be synchronized to destination clock
                         -- domain. It is assumed that each bit of the array is unrelated to the others.
                         -- This is reflected in the constraints applied to this macro. To transfer a binary
                         -- value losslessly across the two clock domains, use the XPM_CDC_GRAY macro
                         -- instead.
);

ctl_cdc_0_inst : xpm_cdc_array_single
generic map (
   DEST_SYNC_FF => 3,   -- DECIMAL; range: 2-10
   INIT_SYNC_FF => 0,   -- DECIMAL; integer; 0=disable simulation init values, 1=enable simulation init
                        -- values
   SIM_ASSERT_CHK => 0, -- DECIMAL; integer; 0=disable simulation messages, 1=enable simulation messages
   SRC_INPUT_REG => 1,  -- DECIMAL; 0=do not register input, 1=register input
   WIDTH => 32          -- DECIMAL; range: 1-1024
)
port map (
   dest_out => mac_src(31 downto 0), -- WIDTH-bit output: src_in synchronized to the destination clock domain. This
                         -- output is registered
   dest_clk => txclk, -- 1-bit input: Clock signal for the destination clock domain.
   src_clk => s_axi_csr_aclk,   -- 1-bit input: optional; required when SRC_INPUT_REG = 1
   src_in => ctl0_out      -- WIDTH-bit input: Input single-bit array to be synchronized to destination clock
                         -- domain. It is assumed that each bit of the array is unrelated to the others.
                         -- This is reflected in the constraints applied to this macro. To transfer a binary
                         -- value losslessly across the two clock domains, use the XPM_CDC_GRAY macro
                         -- instead.
);

ctl_cdc_1_inst : xpm_cdc_array_single
generic map (
   DEST_SYNC_FF => 3,   -- DECIMAL; range: 2-10
   INIT_SYNC_FF => 0,   -- DECIMAL; integer; 0=disable simulation init values, 1=enable simulation init
                        -- values
   SIM_ASSERT_CHK => 0, -- DECIMAL; integer; 0=disable simulation messages, 1=enable simulation messages
   SRC_INPUT_REG => 1,  -- DECIMAL; 0=do not register input, 1=register input
   WIDTH => 32          -- DECIMAL; range: 1-1024
)
port map (
   dest_out => mac_dest(31 downto 0), -- WIDTH-bit output: src_in synchronized to the destination clock domain. This
                         -- output is registered
   dest_clk => txclk, -- 1-bit input: Clock signal for the destination clock domain.
   src_clk => s_axi_csr_aclk,   -- 1-bit input: optional; required when SRC_INPUT_REG = 1
   src_in => ctl1_out      -- WIDTH-bit input: Input single-bit array to be synchronized to destination clock
                         -- domain. It is assumed that each bit of the array is unrelated to the others.
                         -- This is reflected in the constraints applied to this macro. To transfer a binary
                         -- value losslessly across the two clock domains, use the XPM_CDC_GRAY macro
                         -- instead.
);

ctl_cdc_2_inst : xpm_cdc_array_single
generic map (
   DEST_SYNC_FF => 3,   -- DECIMAL; range: 2-10
   INIT_SYNC_FF => 0,   -- DECIMAL; integer; 0=disable simulation init values, 1=enable simulation init
                        -- values
   SIM_ASSERT_CHK => 0, -- DECIMAL; integer; 0=disable simulation messages, 1=enable simulation messages
   SRC_INPUT_REG => 1,  -- DECIMAL; 0=do not register input, 1=register input
   WIDTH => 32          -- DECIMAL; range: 1-1024
)
port map (
   dest_out(15 downto 0) => mac_src(47 downto 32), -- WIDTH-bit output: src_in synchronized to the destination clock domain. This
                         -- output is registered
   dest_out(31 downto 16)=> mac_dest(47 downto 32),
   dest_clk => txclk, -- 1-bit input: Clock signal for the destination clock domain.
   src_clk => s_axi_csr_aclk,   -- 1-bit input: optional; required when SRC_INPUT_REG = 1
   src_in => ctl2_out      -- WIDTH-bit input: Input single-bit array to be synchronized to destination clock
                         -- domain. It is assumed that each bit of the array is unrelated to the others.
                         -- This is reflected in the constraints applied to this macro. To transfer a binary
                         -- value losslessly across the two clock domains, use the XPM_CDC_GRAY macro
                         -- instead.
);

ctl_cdc_3_inst : xpm_cdc_array_single
generic map (
   DEST_SYNC_FF => 3,   -- DECIMAL; range: 2-10
   INIT_SYNC_FF => 0,   -- DECIMAL; integer; 0=disable simulation init values, 1=enable simulation init
                        -- values
   SIM_ASSERT_CHK => 0, -- DECIMAL; integer; 0=disable simulation messages, 1=enable simulation messages
   SRC_INPUT_REG => 1,  -- DECIMAL; 0=do not register input, 1=register input
   WIDTH => 32          -- DECIMAL; range: 1-1024
)
port map (
   dest_out => src_ip_addr, -- WIDTH-bit output: src_in synchronized to the destination clock domain. This
                         -- output is registered
   dest_clk => txclk, -- 1-bit input: Clock signal for the destination clock domain.
   src_clk => s_axi_csr_aclk,   -- 1-bit input: optional; required when SRC_INPUT_REG = 1
   src_in => ctl3_out      -- WIDTH-bit input: Input single-bit array to be synchronized to destination clock
                         -- domain. It is assumed that each bit of the array is unrelated to the others.
                         -- This is reflected in the constraints applied to this macro. To transfer a binary
                         -- value losslessly across the two clock domains, use the XPM_CDC_GRAY macro
                         -- instead.
);

ctl_cdc_4_inst : xpm_cdc_array_single
generic map (
   DEST_SYNC_FF => 3,   -- DECIMAL; range: 2-10
   INIT_SYNC_FF => 0,   -- DECIMAL; integer; 0=disable simulation init values, 1=enable simulation init
                        -- values
   SIM_ASSERT_CHK => 0, -- DECIMAL; integer; 0=disable simulation messages, 1=enable simulation messages
   SRC_INPUT_REG => 1,  -- DECIMAL; 0=do not register input, 1=register input
   WIDTH => 32          -- DECIMAL; range: 1-1024
)
port map (
   dest_out => dest_ip_addr, -- WIDTH-bit output: src_in synchronized to the destination clock domain. This
                         -- output is registered
   dest_clk => txclk, -- 1-bit input: Clock signal for the destination clock domain.
   src_clk => s_axi_csr_aclk,   -- 1-bit input: optional; required when SRC_INPUT_REG = 1
   src_in => ctl4_out      -- WIDTH-bit input: Input single-bit array to be synchronized to destination clock
                         -- domain. It is assumed that each bit of the array is unrelated to the others.
                         -- This is reflected in the constraints applied to this macro. To transfer a binary
                         -- value losslessly across the two clock domains, use the XPM_CDC_GRAY macro
                         -- instead.
);

process(txclk)
begin
   if rising_edge(txclk) then
      ext_fifo_aresetn    <= not ctl_x(7);
   end if;
end process;

h_mode_x        <= ctl_x(6 downto 5);
time_type_x     <= ctl_x(4 downto 3);
pkt_pyld_size_x <= ctl_x(2 downto 1);
tx_enable       <= ctl_x(0);

cdc_async_txrst_inst : xpm_cdc_async_rst
   generic map (
      DEST_SYNC_FF => 2,    -- DECIMAL; range: 2-10
      INIT_SYNC_FF => 0,    -- DECIMAL; 0=disable simulation init values, 1=enable simulation init values
      RST_ACTIVE_HIGH => 1  -- DECIMAL; 0=active low reset, 1=active high reset
   )
   port map (
      dest_arst => usr_tx_reset_x, -- 1-bit output: src_arst asynchronous reset signal synchronized to destination
                              -- clock domain. This output is registered. NOTE: Signal asserts asynchronously
                              -- but deasserts synchronously to dest_clk. Width of the reset signal is at least
                              -- (DEST_SYNC_FF*dest_clk) period.

      dest_clk => txclk,   -- 1-bit input: Destination clock.
      src_arst => usr_tx_reset    -- 1-bit input: Source asynchronous reset signal.
   );


process(txclk)
begin
   if rising_edge(txclk) then
      sm_reset_n <= not (rst_reg_x or usr_tx_reset_x);
      if (state = RESET_STATE) or (state = WAIT_SOP_STATE) then -- allow mode change only in idle time
         header_mode <= h_mode_x;
         case h_mode_x is
            when "00" => -- No VITA 49
               tsi <= "00";
               tsf <= "00";
            when "01" => -- PPS + Sample Count
               tsi <= time_type_x;
               tsf <= "01";            
            when "10" => -- 64-bit Free running count
               tsi <= "00";
               tsf <= "11";   
            when others =>
               tsi <= "00";
               tsf <= "11";                              
         end case;
         case pkt_pyld_size_x is
            when "00" => -- 1024
               payload_size_ctl <= '0' & x"0400";
            when "01" => -- 1024
               payload_size_ctl <= '0' & x"0400";
            when "10" => -- 8192
               payload_size_ctl <= '0' & x"2000";
            when "11" => -- 8192
               payload_size_ctl <= '0' & x"2000";
            when others =>
               payload_size_ctl <= '0' & x"2000";
         end case; 
      end if;
   end if;
end process;   

payload_size_ctl_en <= '1';

-- Interrupt
-- [0] LBUS Overflow
-- [1] stat_tx_local_fault

  ovf_cdc_pulse_inst : xpm_cdc_pulse
   generic map (
      DEST_SYNC_FF => 3,   -- DECIMAL; range: 2-10
      INIT_SYNC_FF => 1,   -- DECIMAL; 0=disable simulation init values, 1=enable simulation init values
      REG_OUTPUT => 1,     -- DECIMAL; 0=disable registered output, 1=enable registered output
      RST_USED => 1,       -- DECIMAL; 0=no reset, 1=implement reset
      SIM_ASSERT_CHK => 0  -- DECIMAL; 0=disable simulation messages, 1=enable simulation messages
   )
   port map (
      dest_pulse => intrpt_src_in(0), -- 1-bit output: Outputs a pulse the size of one dest_clk period when a pulse
                                -- transfer is correctly initiated on src_pulse input. This output is
                                -- combinatorial unless REG_OUTPUT is set to 1.

      dest_clk => s_axi_csr_aclk,     -- 1-bit input: Destination clock.
      dest_rst => '0',     -- 1-bit input: optional; required when RST_USED = 1
      src_clk => txclk,       -- 1-bit input: Source clock.
      src_pulse => tx_ovfout,   -- 1-bit input: Rising edge of this signal initiates a pulse transfer to the
                                -- destination clock domain. The minimum gap between each pulse transfer must
                                -- be at the minimum 2*(larger(src_clk period, dest_clk period)). This is
                                -- measured between the falling edge of a src_pulse to the rising edge of the
                                -- next src_pulse. This minimum gap will guarantee that each rising edge of
                                -- src_pulse will generate a pulse the size of one dest_clk period in the
                                -- destination clock domain. When RST_USED = 1, pulse transfers will not be
                                -- guaranteed while src_rst and/or dest_rst are asserted.

      src_rst => rst_reg_x      -- 1-bit input: optional; required when RST_USED = 1
   );
   
  lf_cdc_pulse_inst : xpm_cdc_pulse
    generic map (
       DEST_SYNC_FF => 3,   -- DECIMAL; range: 2-10
       INIT_SYNC_FF => 1,   -- DECIMAL; 0=disable simulation init values, 1=enable simulation init values
       REG_OUTPUT => 1,     -- DECIMAL; 0=disable registered output, 1=enable registered output
       RST_USED => 1,       -- DECIMAL; 0=no reset, 1=implement reset
       SIM_ASSERT_CHK => 0  -- DECIMAL; 0=disable simulation messages, 1=enable simulation messages
    )
    port map (
       dest_pulse => intrpt_src_in(1), -- 1-bit output: Outputs a pulse the size of one dest_clk period when a pulse
                                 -- transfer is correctly initiated on src_pulse input. This output is
                                 -- combinatorial unless REG_OUTPUT is set to 1.
 
       dest_clk => s_axi_csr_aclk,     -- 1-bit input: Destination clock.
       dest_rst => '0',     -- 1-bit input: optional; required when RST_USED = 1
       src_clk => txclk,       -- 1-bit input: Source clock.
       src_pulse => stat_tx_local_fault,   -- 1-bit input: Rising edge of this signal initiates a pulse transfer to the
                                 -- destination clock domain. The minimum gap between each pulse transfer must
                                 -- be at the minimum 2*(larger(src_clk period, dest_clk period)). This is
                                 -- measured between the falling edge of a src_pulse to the rising edge of the
                                 -- next src_pulse. This minimum gap will guarantee that each rising edge of
                                 -- src_pulse will generate a pulse the size of one dest_clk period in the
                                 -- destination clock domain. When RST_USED = 1, pulse transfers will not be
                                 -- guaranteed while src_rst and/or dest_rst are asserted.
 
       src_rst => rst_reg_x      -- 1-bit input: optional; required when RST_USED = 1
    );

end Behavioral;
