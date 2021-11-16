----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 11/14/2016 09:04:55 AM
-- Design Name: 
-- Module Name: px_pdti_ddr4_fifo - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: DDR4 Virtual FIFO Logic
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
-- 0x00 Control Register
-- 0x04 Start Address Register
-- 0x08 FIFO Size (in DWords) Register
-- 0x0C FIFO Flush Register
-- 0x10 FIFO Count Status (number of DWords)
-- 0x14 Peak FIFO Count Status (number of DWords)
-- 0x18 FIFO Flags Status
-- 0x1C Reserved
-- 0x20 Reserved
-- 0x24 Interrupt Enable
-- 0x28 Interrupt Status
-- 0x2C Interrupt Flag

-- Control Register
-- [0] - Read Disable
-- [1] - Bypass
-- [13:8] - Maximum Back to Back Read or Write Accesses Default 0x2F
-- FIFO Flush Register
-- [0] - FIFO Flush
-- FIFO Flags
-- [0] EMPTY
-- [1] AFL
-- Interrupt Flag Register
-- [0] = Overrun
----------------------------------------------------------------------------------

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

entity px_ppkt_ddr4_fifo is
generic (
    id : integer     := 0; -- 0-255;
    has_in_tready    : boolean := true; -- has input tready
    in_tdata_bytes   : integer := 4; -- number of input tdata bytes  2,4,8,16,32,64
    out_tdata_bytes  : integer := 32;  -- number of output tdata bytes 32,64
    default_strt_addr: std_logic_vector(31 downto 0) := x"00000000"; -- FIFO Start Address
    default_dw_size  : std_logic_vector(31 downto 0) := x"40000000"; -- FIFO Size in 32-bit DWords
    has_fifo_full_led: boolean := true;
    has_bypass_full_led: boolean := true
);
port ( 
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
--------------------------------------------------------------------------------
   s_axi_csr_aclk        : in  std_logic;
   s_axi_csr_aresetn     : in  std_logic;
   s_axi_csr_awaddr      : in  std_logic_vector(6 downto 0);
   s_axi_csr_awprot      : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_awvalid     : in  std_logic;
   s_axi_csr_awready     : out std_logic;
   s_axi_csr_wdata       : in  std_logic_vector(31 downto 0);
   s_axi_csr_wstrb       : in  std_logic_vector(3 downto 0); 
   s_axi_csr_wvalid      : in  std_logic;
   s_axi_csr_wready      : out std_logic;
   s_axi_csr_bresp       : out std_logic_vector(1 downto 0);
   s_axi_csr_bvalid      : out std_logic;
   s_axi_csr_bready      : in  std_logic;
   s_axi_csr_araddr      : in  std_logic_vector(6 downto 0);
   s_axi_csr_arprot      : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_arvalid     : in  std_logic;
   s_axi_csr_arready     : out std_logic;
   s_axi_csr_rdata       : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp       : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid      : out std_logic;
   s_axi_csr_rready      : in  std_logic;
   irq                   : out std_logic;
   -----------------------------------------------------------------------------
   -- AXI-S PPKT FIFO Input Stream
   ----------------------------------------------------------------------------- 
   axis_ppkt_aclk        : in  std_logic;
   axis_ppkt_aresetn     : in  std_logic; 
   s_axis_ppkt_tvalid    : in  std_logic;
   s_axis_ppkt_tready    : out std_logic;
   -- Earliest byte in lower byte 
   s_axis_ppkt_tdata     : in  std_logic_vector((in_tdata_bytes*8)-1 downto 0);
   -- tuser[63:0]    = timestamp[63:0]  
   -- tuser[64]      = SOP   
   -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
   -- tuser[67]      = Data Type 0 = Real 1 = I/Q
   -- tuser[75:68]   = channel[7:0]
   -- tuser[79:76]   = user[3:0] These bits only valid only with tlast   
   s_axis_ppkt_tuser     : in  std_logic_vector(79 downto 0);
   s_axis_ppkt_tkeep     : in  std_logic_vector((in_tdata_bytes/2)-1 downto 0); -- One per 16-bit word
   s_axis_ppkt_tlast     : in  std_logic; -- end of packet
   -----------------------------------------------------------------------------
   -- AXI-S PPKT FIFO Output Stream
   -----------------------------------------------------------------------------  
   m_axis_ppkt_tvalid    : out std_logic;
   m_axis_ppkt_tready    : in  std_logic;
   -- Earliest byte in lower byte 
   m_axis_ppkt_tdata     : out std_logic_vector((out_tdata_bytes*8)-1 downto 0);
   -- tuser[63:0]    = timestamp[63:0]  
   -- tuser[64]      = SOP   
   -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
   -- tuser[67]      = Data Type 0 = Real 1 = I/Q
   -- tuser[75:68]   = channel[7:0]
   -- tuser[79:76]   = user[3:0] These bits only valid only with tlast   
   m_axis_ppkt_tuser     : out std_logic_vector(79 downto 0);
   m_axis_ppkt_tkeep     : out std_logic_vector((out_tdata_bytes/2)-1 downto 0); -- One per 16-bit word
   m_axis_ppkt_tlast     : out std_logic; -- end of packet
   -----------------------------------------------------------------------------
   -- DDR4 Request Interface (AXI Stream)
   ----------------------------------------------------------------------------  
   axis_ddr_aclk         : in  std_logic;
   axis_ddr_aresetn      : in  std_logic;
   -- tuser[127:0]   = Request Header
   -- tuser[31:0]    = Address (Address must be aligned to the request size boundaries)
   -- tuser[34:32]   = Future Address Expansion
   -- tuser[35]      = Read = 1, Write = 0
   -- tuser[39:36]   = Reserved
   -- tuser[119:40]  = Byte Masks
   -- tuser[255:128] = Upper 128-bits of RAM Data 
   m_axis_rqst_tvalid    : out std_logic;
   m_axis_rqst_tready    : in  std_logic;   
   m_axis_rqst_tlast     : out std_logic;
   m_axis_rqst_tid       : out std_logic_vector(7 downto 0);
   m_axis_rqst_tdata     : out std_logic_vector(511 downto 0); 
   m_axis_rqst_tuser     : out std_logic_vector(255 downto 0);
   ----------------------------------------------------------------------------
   -- DDR4 Response Interface (AXI Stream)
   ----------------------------------------------------------------------------
   -- tuser[127:0] = Response Header
   -- tuser[31:0]  = Address (Address must be aligned to the request size boundaries)
   -- tuser[34:32] = Future Address Expansion
   -- tuser[39:36] = Reserved
   -- tuser[119:40]= Byte Masks 
   -- tuser[255:128] = Upper 128-bits of RAM Data 
   s_axis_rsp_tvalid     : in  std_logic;
   s_axis_rsp_tlast      : in  std_logic;
   s_axis_rsp_tid        : in  std_logic_vector(7 downto 0);
   s_axis_rsp_tdata      : in  std_logic_vector(511 downto 0); 
   s_axis_rsp_tuser      : in  std_logic_vector(255 downto 0);
   -----------------------------------------------------------------------------
   -- Misc.
   -----------------------------------------------------------------------------
   bypass_full_led_in      : in std_logic;  -- optional external fifo full signal input to use for bypass mode
   fifo_full_led           : out  std_logic -- active high indication of FIFO overflow
   );
end px_ppkt_ddr4_fifo;

architecture Behavioral of px_ppkt_ddr4_fifo is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------
-- 512 deep 
-- AEMP at 4
-- AFL at 256
COMPONENT px_ppkt_ddr4_fifo_fifo
  PORT (
    s_aclk : IN STD_LOGIC;
    m_aclk : IN STD_LOGIC;
    s_aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
    s_axis_tuser : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
    m_axis_tuser : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    axis_wr_data_count : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    axis_rd_data_count : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    axis_prog_empty : OUT STD_LOGIC;
    axis_prog_full : OUT STD_LOGIC
  );
END COMPONENT;

-- AXI-S Switch
COMPONENT px_ppkt_ddr4_fifo_arb
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axis_tready : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axis_tdata : IN STD_LOGIC_VECTOR(1023 DOWNTO 0);
    s_axis_tlast : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axis_tuser : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axis_tready : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axis_tdata : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
    m_axis_tlast : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axis_tuser : OUT STD_LOGIC_VECTOR(255 DOWNTO 0);
    s_req_suppress : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_decode_err : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT px_ppkt_ddr4_fifo_rs
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
    s_axis_tid : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    s_axis_tuser : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
    m_axis_tid : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    m_axis_tuser : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
  );
END COMPONENT;

COMPONENT px_ppkt_ddr4_fifo_rs2
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
    s_axis_tuser : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready: IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
    m_axis_tuser : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
  );
END COMPONENT;

COMPONENT px_ppkt_ddr4_fifo_csr
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
    ctl0_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl1_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl2_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl3_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat0_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat1_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat2_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat3_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat4_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    intrpt_src_in : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    irq : OUT STD_LOGIC
  );
END COMPONENT;

component px_ppkt_ddr4fifo_w512
generic (
    WORD_WIDTH : integer := 16 -- must be 1,2,4,8,16 (number of 16-bit words)
);
port (
    ----------------------------------------------------------------------------
    -- Input - Variable Width
    ----------------------------------------------------------------------------
    s_aclk          : in  std_logic;
    s_aresetn       : in  std_logic;
    s_axis_tvalid   : in  std_logic;
    s_axis_tready   : out std_logic;
    s_axis_tdata    : in  std_logic_vector((WORD_WIDTH*16)-1 downto 0);
    -- tuser[63:0]    = timestamp[63:0]  
    -- tuser[64]      = SOP   
    -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
    -- tuser[67]      = Data Type 0 = Real 1 = I/Q
    -- tuser[75:68]   = channel[7:0] 
    -- tuser[79:76]   = user[3:0] 
    s_axis_tuser    : in  std_logic_vector(79 downto 0);
    s_axis_tkeep    : in  std_logic_vector(WORD_WIDTH-1 downto 0); -- One per 16-bit word
    s_axis_tlast    : in  std_logic;
    ----------------------------------------------------------------------------
    -- Output 512 wide
    ----------------------------------------------------------------------------
    m_axis_tvalid   : out std_logic;
    m_axis_tready   : in  std_logic;
    m_axis_tdata    : out std_logic_vector(511 downto 0);
    -- tuser[63:0]    = timestamp[63:0]  
    -- tuser[64]      = SOP   
    -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
    -- tuser[67]      = Data Type 0 = Real 1 = I/Q
    -- tuser[75:68]   = channel[7:0]  
    -- tuser[79:76]   = user
    m_axis_tuser    : out std_logic_vector(79 downto 0);
    m_axis_tkeep    : out std_logic_vector(31 downto 0); -- One per 16-bit word
    m_axis_tlast    : out std_logic
  );
end component px_ppkt_ddr4fifo_w512;

component px_ppkt_ddr4fifo_512w
port (
    ----------------------------------------------------------------------------
    -- Input - Variable Width
    ----------------------------------------------------------------------------
    s_aclk          : in  std_logic;
    s_aresetn       : in  std_logic;
    s_axis_tvalid   : in  std_logic;
    s_axis_tready   : out std_logic;
    s_axis_tdata    : in  std_logic_vector(511 downto 0);
    -- tuser[63:0]    = timestamp[63:0]  
    -- tuser[64]      = SOP   
    -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
    -- tuser[67]      = Data Type 0 = Real 1 = I/Q
    -- tuser[75:68]   = channel[7:0] 
    -- tuser[79:76]   = user[3:0] 
    s_axis_tuser    : in  std_logic_vector(79 downto 0);
    s_axis_tkeep    : in  std_logic_vector(31 downto 0); -- One per 16-bit word
    s_axis_tlast    : in  std_logic;
    ----------------------------------------------------------------------------
    -- Output 512 wide
    ----------------------------------------------------------------------------
    m_axis_tvalid   : out std_logic;
    m_axis_tready   : in  std_logic;
    m_axis_tdata    : out std_logic_vector(255 downto 0);
    -- tuser[63:0]    = timestamp[63:0]  
    -- tuser[64]      = SOP   
    -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
    -- tuser[67]      = Data Type 0 = Real 1 = I/Q
    -- tuser[75:68]   = channel[7:0]  
    -- tuser[79:76]   = user
    m_axis_tuser    : out std_logic_vector(79 downto 0);
    m_axis_tkeep    : out std_logic_vector(15 downto 0); -- One per 16-bit word
    m_axis_tlast    : out std_logic
  );
end component px_ppkt_ddr4fifo_512w;

-- AXI-S Clock Converter
COMPONENT px_ppkt_ddr4_fifo_in_cc
  PORT (
    s_axis_aresetn : IN STD_LOGIC;
    m_axis_aresetn : IN STD_LOGIC;
    s_axis_aclk : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
    s_axis_tlast : IN STD_LOGIC;
    s_axis_tuser : IN STD_LOGIC_VECTOR(111 DOWNTO 0);
    m_axis_aclk : IN STD_LOGIC;
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
    m_axis_tlast : OUT STD_LOGIC;
    m_axis_tuser : OUT STD_LOGIC_VECTOR(111 DOWNTO 0)
  );
END COMPONENT;

----------------------------------------------------------------------------------
-- Types
----------------------------------------------------------------------------------
type state_type is
(
reset_state,
suppress_state,
issue_w_tlast_state,
issue_r_tlast_state,
reset_fifo_state,
wait_reset_over_state
);
----------------------------------------------------------------------------------
-- Signals
----------------------------------------------------------------------------------

signal in_tuser             : std_logic_vector(127 downto 0) := (others => '0');          
signal in_fifo_tvalid       : std_logic := '0';
signal in_fifo_tready       : std_logic := '0';
signal in_tready            : std_logic := '0';
signal in_fifo_tdata        : std_logic_vector(511 downto 0) := (others => '0');
signal in_fifo_tuser        : std_logic_vector(127 downto 0) := (others => '0'); 
signal in_fifo_rs_tvalid    : std_logic := '0';
signal in_fifo_rs_tready    : std_logic := '0';
signal in_fifo_rs_tdata     : std_logic_vector(511 downto 0) := (others => '0');
signal in_fifo_rs_tuser     : std_logic_vector(127 downto 0) := (others => '0'); 
signal in_fifo_prog_empty   : std_logic := '0';  
signal wr_tdata             : std_logic_vector(511 downto 0) := (others => '0');
signal wr_tuser             : std_logic_vector(255 downto 0) := (others => '0');    
signal wr_addr              : std_logic_vector(31 downto 0) := (others => '0');  
signal wr_tlast             : std_logic := '0';
signal wr_tvalid            : std_logic := '0';
signal wr_tready            : std_logic := '0';
signal wr_access_cntr       : std_logic_vector(5 downto 0) := (others => '0');  
signal rd_access_cntr       : std_logic_vector(5 downto 0) := (others => '0');  
signal rd_tvalid            : std_logic := '0';
signal rd_tready            : std_logic := '0';
signal rd_tdata             : std_logic_vector(511 downto 0) := (others => '0');
signal rd_tuser             : std_logic_vector(255 downto 0) := (others => '0'); 
signal rd_tlast             : std_logic := '0';
signal src_sends            : std_logic:= '0';
signal src_rcvs             : std_logic:= '0';
signal dest_reqs            : std_logic:= '0';
signal stat_regx            : std_logic_vector(55 downto 0)  := (others => '0');
signal stat_reg_rs          : std_logic_vector(55 downto 0)  := (others => '0');
signal src_sendc            : std_logic:= '0';
signal src_rcvc             : std_logic:= '0';
signal dest_reqc            : std_logic:= '0';
signal src_sendb            : std_logic:= '0';
signal src_rcvb             : std_logic:= '0';
signal dest_reqb            : std_logic:= '0';
signal src_sendr            : std_logic:= '0';
signal src_rcvr             : std_logic:= '0';
signal dest_reqr            : std_logic:= '0';
signal cntl_regx            : std_logic_vector(70 downto 0)  := (others => '0');
signal cntl_reg_rs          : std_logic_vector(70 downto 0)  := (others => '0');
signal cntl_regb_rs         : std_logic_vector(1 downto 0)  := (others => '0');
signal t1_s_axi_csr_aresetn: std_logic:= '0';
signal ctl0_out             : std_logic_vector(31 downto 0)  := (others => '0');
signal ctl1_out             : std_logic_vector(31 downto 0)  := (others => '0');
signal ctl2_out             : std_logic_vector(31 downto 0)  := (others => '0');
signal ctl3_out             : std_logic_vector(31 downto 0)  := (others => '0');
signal stat0_in             : std_logic_vector(31 downto 0)  := (others => '0');
signal stat1_in             : std_logic_vector(31 downto 0)  := (others => '0');
signal stat2_in             : std_logic_vector(31 downto 0)  := (others => '0');
signal fifo_rstn            : std_logic:= '0';
signal fifo_rstnb           : std_logic:= '0';
signal fifo_rstnc           : std_logic:= '0';
signal t1_fifo_rst          : std_logic:= '0';
signal start_addr           : std_logic_vector(31 downto 0)  := (others => '0');
signal fifo_size            : std_logic_vector(31 downto 0)  := (others => '0');
signal rd_disable           : std_logic:= '0';
signal rsx_tvalid           : std_logic:= '0';
signal rs_tvalid            : std_logic:= '0';
signal rs_tdata             : std_logic_vector(511 downto 0)  := (others => '0');
signal rs_tid               : std_logic_vector(7 downto 0)  := (others => '0');
signal rs_tuser             : std_logic_vector(127 downto 0)  := (others => '0');
signal out_fifo_afl         : std_logic:= '0';   
signal t1_out_fifo_afl      : std_logic:= '0';         
signal out_tvalid           : std_logic:= '0'; 
signal out_tuser            : std_logic_vector(127 downto 0)  := (others => '0');
signal in_fifo_count        : std_logic_vector(9 downto 0)  := (others => '0');
signal out_fifo_count       : std_logic_vector(9 downto 0)  := (others => '0');
signal t1_axis_aresetn      : std_logic:= '0'; 
signal s_decode_err         : std_logic_vector(1 downto 0)  := (others => '0');
signal rd_addr              : std_logic_vector(31 downto 0)  := (others => '0');
signal ddr_afl              : std_logic:= '0'; 
signal ddr_aafl             : std_logic:= '0'; 
signal ddr_emp              : std_logic:= '0';
signal ddr_aemp             : std_logic:= '0';
signal wr_inc               : std_logic:= '0';
signal rd_inc               : std_logic:= '0';
signal fifo_size_m1         : std_logic_vector(31 downto 0)  := (others => '0');
signal fifo_size_m2         : std_logic_vector(31 downto 0)  := (others => '0');
signal max_addr             : std_logic_vector(31 downto 0)  := (others => '0');
signal wr_count             : std_logic_vector(26 downto 0)  := (others => '0');
signal rd_count             : std_logic_vector(26 downto 0)  := (others => '0');
signal cnt_suma             : std_logic_vector(26 downto 0)  := (others => '0');
signal t1_out_fifo_count    : std_logic_vector(9 downto 0)  := (others => '0');
signal overrun              : std_logic:= '0';
signal intrpt_src_in        : std_logic_vector(0 downto 0)  := (others => '0');
signal total_count          : std_logic_vector(26 downto 0)  := (others => '0');
signal fifo_size_bytes      : std_logic_vector(33 downto 0)  := (others => '0');
signal max_count            : std_logic_vector(26 downto 0)  := (others => '0');
signal full                 : std_logic:= '0';
signal empty                : std_logic:= '0';
signal out_tready           : std_logic:= '0';
signal bypass               : std_logic:= '0';
signal in_rs_tvalid         : std_logic:= '0';
signal in_rs_tready         : std_logic:= '0';
signal in_rs_tdata          : std_logic_vector(511 downto 0)  := (others => '0');
signal in_rs_tuser          : std_logic_vector(127 downto 0)  := (others => '0');
signal inf_tvalid           : std_logic:= '0';
signal inf_tready           : std_logic:= '0';
signal inf_tdata            : std_logic_vector(511 downto 0)  := (others => '0');
signal inf_tuser            : std_logic_vector(127 downto 0)  := (others => '0');
signal in_tvalid            : std_logic:= '0';
signal in_tdata             : std_logic_vector(511 downto 0)  := (others => '0');
signal out_mux_tvalid       : std_logic:= '0';
signal out_mux_tready       : std_logic:= '0';
signal out_mux_tdata        : std_logic_vector(511 downto 0)  := (others => '0');
signal out_mux_tuser        : std_logic_vector(127 downto 0)  := (others => '0');
signal out_tdata            : std_logic_vector(511 downto 0)  := (others => '0');
signal out_rs_tuser         : std_logic_vector(127 downto 0)  := (others => '0');
signal out_rs_tvalid        : std_logic:= '0';
signal out_rs_tready        : std_logic:= '0';
signal out_rs_tdata         : std_logic_vector(511 downto 0)  := (others => '0');
signal t1_fifo_rstb         : std_logic:= '0';
signal t1_fifo_rstc         : std_logic:= '0';
signal dest_arst_a          : std_logic:= '0';
signal dest_arst_b          : std_logic:= '0';
signal rd_peak              : std_logic_vector(26 downto 0)  := (others => '0');
signal out_fifo_countx      : std_logic_vector(9 downto 0)  := (others => '0');
signal conseq_access        : std_logic_vector(5 downto 0)  := (others => '0');
signal p_conseq_access      : std_logic_vector(5 downto 0)  := (others => '0');
signal inout_fifo_rst       : std_logic:= '0';
signal inout_fifo_rst_n     : std_logic:= '0';
signal suppress             : std_logic_vector(1 downto 0)  := (others => '0');
signal mid_packet_w         : std_logic:= '0';
signal mid_packet_r         : std_logic:= '0';
signal rst_wr_tvalid        : std_logic:= '0';
signal rst_rd_tvalid        : std_logic:= '0';
signal rst_wr_tlast         : std_logic:= '0';
signal rst_rd_tlast         : std_logic:= '0';
signal dest_arst_c          : std_logic:= '0';
signal state                : state_type;
signal rst_cntr             : std_logic_vector(4 downto 0)  := (others => '0');
signal t1_overrun           : std_logic:= '0';
signal t1_bypass            : std_logic:= '0';
signal t1_bypass_full_led_in: std_logic:= '0';
signal t2_bypass_full_led_in: std_logic:= '0';

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of axis_ppkt_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 axis_ppkt_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of axis_ppkt_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_ppkt:m_axis_ppkt, ASSOCIATED_RESET axis_ppkt_aresetn";

ATTRIBUTE X_INTERFACE_INFO of axis_ddr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 axis_ddr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of axis_ddr_aclk: SIGNAL is "ASSOCIATED_BUSIF m_axis_rqst:s_axis_rsp, ASSOCIATED_RESET axis_ddr_aresetn";


--------------------------------------------------------------------------------

begin

--------------------------------------------------------------------------------
-- Input Width Conversion
--------------------------------------------------------------------------------

gen_inw512: if ( in_tdata_bytes /= 64) generate

w512_inst: px_ppkt_ddr4fifo_w512
generic map (
    WORD_WIDTH => (in_tdata_bytes/2) -- must be 1,2,4,8,16 (number of 16-bit words)  
)
port map(
    s_aclk          => axis_ppkt_aclk,
    s_aresetn       => fifo_rstnb,
    s_axis_tvalid   => s_axis_ppkt_tvalid,
    s_axis_tready   => s_axis_ppkt_tready,
    s_axis_tdata    => s_axis_ppkt_tdata,
    s_axis_tuser    => s_axis_ppkt_tuser,
    s_axis_tkeep    => s_axis_ppkt_tkeep,
    s_axis_tlast    => s_axis_ppkt_tlast,
    m_axis_tvalid   => in_tvalid,
    m_axis_tready   => in_tready,
    m_axis_tdata    => in_tdata,
    m_axis_tuser    => in_tuser(79 downto 0),
    m_axis_tkeep    => in_tuser(111 downto 80),
    m_axis_tlast    => in_tuser(112)
  );

end generate;

gen_inwn512: if ( in_tdata_bytes = 64) generate

in_tvalid              <= s_axis_ppkt_tvalid;
s_axis_ppkt_tready     <= in_tready;
in_tdata               <= s_axis_ppkt_tdata;
in_tuser(112 downto 0) <= s_axis_ppkt_tlast & s_axis_ppkt_tkeep & s_axis_ppkt_tuser;

end generate;

in_tuser(127 downto 113) <= (others => '0');

--------------------------------------------------------------------------------
-- Input AXI-S Reg Slice
--------------------------------------------------------------------------------
-- Register slice improves timing from FIFO to Arbiter
in_rs_inst : px_ppkt_ddr4_fifo_rs2
port map (
    aclk            => axis_ppkt_aclk,
    aresetn         => fifo_rstnb,
    s_axis_tvalid   => in_tvalid,
    s_axis_tready   => in_tready,
    s_axis_tdata    => in_tdata,
    s_axis_tuser    => in_tuser,
    m_axis_tvalid   => in_rs_tvalid,
    m_axis_tready   => in_rs_tready,
    m_axis_tdata    => in_rs_tdata,
    m_axis_tuser    => in_rs_tuser
  );
  
in_rs_tready   <= inf_tready when (bypass = '0') else out_mux_tready; 
inf_tvalid     <= in_rs_tvalid when (bypass = '0') else '0';
inf_tdata      <= in_rs_tdata;
inf_tuser      <= in_rs_tuser;

--------------------------------------------------------------------------------
-- Input FIFO
--------------------------------------------------------------------------------

-- Overrun
process(axis_ppkt_aclk)
begin
   if rising_edge(axis_ppkt_aclk) then
     if (has_in_tready = false) then
        overrun <= (not in_tready) and (not bypass) and fifo_rstnb and not empty;
     else
        overrun <= '0';
     end if;   
   end if;
end process;     

--s_axis_ppkt_tready <= in_tready;

in_fifo_inst : px_ppkt_ddr4_fifo_fifo
port map (
    m_aclk          => axis_ddr_aclk,
    s_aclk          => axis_ppkt_aclk,
    s_aresetn       => fifo_rstnc,
    s_axis_tvalid   => inf_tvalid,
    s_axis_tready   => inf_tready,
    s_axis_tdata    => inf_tdata,
    s_axis_tuser    => inf_tuser,
    m_axis_tvalid   => in_fifo_tvalid,
    m_axis_tready   => in_fifo_tready,
    m_axis_tdata    => in_fifo_tdata,
    m_axis_tuser    => in_fifo_tuser,
    axis_wr_data_count => open,
    axis_rd_data_count => in_fifo_count,
    axis_prog_empty => in_fifo_prog_empty,
    axis_prog_full  => open
);

--------------------------------------------------------------------------------
-- Input FIFO AXI-S Reg Slice
--------------------------------------------------------------------------------
-- Register slice improves timing from FIFO to Arbiter
inf_rs_inst : px_ppkt_ddr4_fifo_rs2
port map (
    aclk            => axis_ddr_aclk,
    aresetn         => inout_fifo_rst_n,
    s_axis_tvalid   => in_fifo_tvalid,
    s_axis_tready   => in_fifo_tready,
    s_axis_tdata    => in_fifo_tdata,
    s_axis_tuser    => in_fifo_tuser,
    m_axis_tvalid   => in_fifo_rs_tvalid,
    m_axis_tready   => in_fifo_rs_tready,
    m_axis_tdata    => in_fifo_rs_tdata,
    m_axis_tuser    => in_fifo_rs_tuser
  );

--------------------------------------------------------------------------------
-- Response AXI-S Reg Slice
--------------------------------------------------------------------------------

rsp_rs_inst : px_ppkt_ddr4_fifo_rs
port map (
    aclk            => axis_ddr_aclk,
    aresetn         => inout_fifo_rst_n,
    s_axis_tvalid   => s_axis_rsp_tvalid,
    s_axis_tdata    => s_axis_rsp_tdata,
    s_axis_tid      => s_axis_rsp_tid,
    s_axis_tuser    => s_axis_rsp_tuser(255 downto 128),
    m_axis_tvalid   => rs_tvalid,
    m_axis_tdata    => rs_tdata,
    m_axis_tid      => rs_tid,
    m_axis_tuser    => rs_tuser
  );

rsx_tvalid <= rs_tvalid when (rs_tid = conv_std_logic_vector(id,8)) else '0';

--------------------------------------------------------------------------------
-- Output FIFO
--------------------------------------------------------------------------------

out_fifo_inst : px_ppkt_ddr4_fifo_fifo
port map (
    s_aclk          => axis_ddr_aclk,
    m_aclk          => axis_ppkt_aclk,
    s_aresetn       => inout_fifo_rst_n,
    s_axis_tvalid   => rsx_tvalid,
    s_axis_tready   => open,
    s_axis_tdata    => rs_tdata,
    s_axis_tuser    => rs_tuser,
    m_axis_tvalid   => out_tvalid,
    m_axis_tready   => out_tready,
    m_axis_tdata    => out_tdata,
    m_axis_tuser    => out_tuser,
    axis_wr_data_count => open, --out_fifo_count,
    axis_rd_data_count => out_fifo_countx,
    axis_prog_empty => open,
    axis_prog_full  => out_fifo_afl
);

out_tready     <= (out_mux_tready and not rd_disable) when (bypass = '0') else '0'; 

cnt_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 3, -- integer; range: 2-10
  WIDTH          => 10 -- integer; range: 1-1024
)
port map (

  src_clk  => axis_ppkt_aclk,
  src_in   => out_fifo_countx,
  src_send => src_sendr,
  src_rcv  => src_rcvr,
  dest_clk => axis_ddr_aclk,
  dest_req => dest_reqr,
  dest_ack => dest_reqr, 
  dest_out => out_fifo_count
);
 
process(axis_ppkt_aclk)
begin
   if rising_edge(axis_ppkt_aclk) then
     if (src_rcvr = '1') then
       src_sendr <= '0';
     elsif (src_rcvr = '0') and (src_sendr = '0') then
       src_sendr <= '1';
     end if;  
   end if;
end process;    

--------------------------------------------------------------------------------
-- Output Register Slice to facilitate the Bypass Mux
--------------------------------------------------------------------------------

out_mux_tdata  <= out_tdata when (bypass = '0') else in_rs_tdata;
out_mux_tuser  <= out_tuser when (bypass = '0') else in_rs_tuser;
out_mux_tvalid <= in_rs_tvalid when (bypass = '1') else (out_tvalid and not rd_disable);

out_rs_inst : px_ppkt_ddr4_fifo_rs2
port map (
    aclk            => axis_ppkt_aclk,
    aresetn         => fifo_rstnb,
    s_axis_tvalid   => out_mux_tvalid,
    s_axis_tready   => out_mux_tready,
    s_axis_tdata    => out_mux_tdata,
    s_axis_tuser    => out_mux_tuser,
    m_axis_tvalid   => out_rs_tvalid,
    m_axis_tready   => out_rs_tready,
    m_axis_tdata    => out_rs_tdata,
    m_axis_tuser    => out_rs_tuser
  );

--------------------------------------------------------------------------------
-- Output Width Conversion
--------------------------------------------------------------------------------  
gen_out512w: if ( out_tdata_bytes /= 64) generate

a512w_inst: px_ppkt_ddr4fifo_512w
port map(
    s_aclk          => axis_ppkt_aclk,
    s_aresetn       => fifo_rstnb,
    s_axis_tvalid   => out_rs_tvalid,
    s_axis_tready   => out_rs_tready,
    s_axis_tdata    => out_rs_tdata,
    s_axis_tuser    => out_rs_tuser(79 downto 0),
    s_axis_tkeep    => out_rs_tuser(111 downto 80),
    s_axis_tlast    => out_rs_tuser(112),
    m_axis_tvalid   => m_axis_ppkt_tvalid,
    m_axis_tready   => m_axis_ppkt_tready,
    m_axis_tdata    => m_axis_ppkt_tdata,
    m_axis_tuser    => m_axis_ppkt_tuser,
    m_axis_tkeep    => m_axis_ppkt_tkeep,
    m_axis_tlast    => m_axis_ppkt_tlast
  );

end generate;

gen_outwn512: if ( out_tdata_bytes = 64) generate

m_axis_ppkt_tvalid <= out_rs_tvalid;
out_rs_tready      <= m_axis_ppkt_tready;
m_axis_ppkt_tdata  <= out_rs_tdata;
m_axis_ppkt_tkeep  <= out_rs_tuser(111 downto 80);
m_axis_ppkt_tuser  <= out_rs_tuser(79 downto 0);
m_axis_ppkt_tlast  <= out_rs_tuser(112);

end generate;

--------------------------------------------------------------------------------
-- Write Request Logic
--------------------------------------------------------------------------------

    -- tuser[127:0]   = Request Header
    -- tuser[31:0]    = Address (Address must be aligned to the request size boundaries)
    -- tuser[34:32]   = Future Address Expansion
    -- tuser[35]      = Read = 1, Write = 0
    -- tuser[39:36]   = Reserved
    -- tuser[119:40]  = Byte Masks
    -- tuser[255:128] = Upper 128-bits of RAM Data 
    
-- Count the number of consecutive accesses
process(axis_ddr_aclk)
begin
   if rising_edge(axis_ddr_aclk) then
      t1_axis_aresetn <= axis_ddr_aresetn;
      if (inout_fifo_rst_n= '0') or (t1_axis_aresetn = '0') or (in_fifo_prog_empty = '1') or (ddr_aafl = '1') or (wr_access_cntr = conseq_access) then
         wr_access_cntr <= "000000"; 
      elsif (in_fifo_rs_tvalid = '1') and (in_fifo_rs_tready = '1') then   
         wr_access_cntr <= wr_access_cntr + 1;
      end if;   
   end if;
end process;    
   
    wr_tdata                 <= in_fifo_rs_tdata;
    wr_tuser(31 downto 0)    <= wr_addr;
    wr_tuser(34 downto 32)   <= "000";
    wr_tuser(35)             <= '0'; -- write
    wr_tuser(39 downto 36)   <= "0000";
    wr_tuser(119 downto 40)  <= (others => '0');
    wr_tuser(207 downto 128) <= in_fifo_rs_tuser(79 downto 0); -- tuser
    wr_tuser(239 downto 208) <= in_fifo_rs_tuser(111 downto 80); -- tkeep
    wr_tuser(240)            <= in_fifo_rs_tuser(112); -- tlast
    wr_tuser(255 downto 241) <= (others => '0');
    --wr_tlast <= '1' when ((in_fifo_prog_empty = '1') or (ddr_aafl = '1') or (wr_access_cntr = "11111")) else '0';
    wr_tlast <= '1' when ((in_fifo_prog_empty = '1') or (ddr_aafl = '1') or (wr_access_cntr = conseq_access) or (rst_wr_tlast = '1')) else '0';  
--------------------------------------------------------------------------------
-- Read Request Logic
--------------------------------------------------------------------------------

-- Count the number of consecutive accesses
process(axis_ddr_aclk)
begin
   if rising_edge(axis_ddr_aclk) then
      if (inout_fifo_rst_n= '0') or (t1_axis_aresetn = '0') or (out_fifo_afl = '1') or (ddr_aemp = '1') or (rd_access_cntr = conseq_access) then
         rd_access_cntr <= "000000"; 
      elsif (rd_tvalid = '1') and (rd_tready = '1') then
         rd_access_cntr <= rd_access_cntr + 1;
      end if;
   end if;
end process;   

    rd_tdata                 <= (others => '0');
    rd_tuser(31 downto 0)    <= rd_addr;
    rd_tuser(34 downto 32)   <= "000";
    rd_tuser(35)             <= '1'; -- read
    rd_tuser(39 downto 36)   <= "0000";
    rd_tuser(255 downto 40)  <= (others => '0');
    --rd_tlast <= '1' when ((ddr_aemp = '1') or (out_fifo_afl = '1') or (rd_access_cntr = "11111")) else '0';
    rd_tlast <= '1' when ((ddr_aemp = '1') or (out_fifo_afl = '1') or (rd_access_cntr = conseq_access) or (rst_rd_tlast = '1')) else '0';
--------------------------------------------------------------------------------
-- Read/Write Arbiter
--------------------------------------------------------------------------------

arb : px_ppkt_ddr4_fifo_arb
port map (
    aclk                          => axis_ddr_aclk,
    aresetn                       => inout_fifo_rst_n,
    s_axis_tvalid(0)              => wr_tvalid,
    s_axis_tvalid(1)              => rd_tvalid,
    s_axis_tready(0)              => wr_tready,
    s_axis_tready(1)              => rd_tready,
    s_axis_tdata(511 downto 0)    => wr_tdata,
    s_axis_tdata(1023 downto 512) => rd_tdata,
    s_axis_tlast(0)               => wr_tlast,
    s_axis_tlast(1)               => rd_tlast,
    s_axis_tuser(255 downto 0)    => wr_tuser,
    s_axis_tuser(511 downto 256)  => rd_tuser,
    m_axis_tvalid(0)              => m_axis_rqst_tvalid,
    m_axis_tready(0)              => m_axis_rqst_tready,
    m_axis_tdata                  => m_axis_rqst_tdata,
    m_axis_tlast(0)               => m_axis_rqst_tlast,
    m_axis_tuser                  => m_axis_rqst_tuser,
    s_decode_err                  => s_decode_err,
    s_req_suppress                => suppress --"00"
  );
    
-- hold off when   
wr_tvalid      <= (in_fifo_rs_tvalid and not ddr_afl) or rst_wr_tvalid;
in_fifo_rs_tready <= wr_tready and not ddr_afl; 
  
m_axis_rqst_tid <= conv_std_logic_vector(id, 8);

-- FIFO Flush State Machine
process(axis_ddr_aclk)
begin
   if rising_edge(axis_ddr_aclk) then
     if (t1_axis_aresetn = '0') then
        inout_fifo_rst <= '0';
        suppress      <= "00";
        state         <=  reset_state;
        rst_wr_tvalid <= '0';
        rst_wr_tlast  <= '0';
        rst_rd_tvalid <= '0';
        rst_rd_tlast  <= '0';   
        rst_cntr      <= "00000";  
        mid_packet_w  <= '0';
        mid_packet_r  <= '0';    
     else
        if (wr_tvalid = '1') and (wr_tready = '1') and (wr_tlast = '0') then
           mid_packet_w <= '1';
        elsif (wr_tvalid = '1') and (wr_tready = '1') and (wr_tlast = '1') then
           mid_packet_w <= '0';
        end if;
        if (rd_tvalid = '1') and (rd_tready = '1') and (rd_tlast = '0') then
           mid_packet_r <= '1';
        elsif (rd_tvalid = '1') and (rd_tready = '1') and (rd_tlast = '1') then
           mid_packet_r <= '0';
        end if;        
        case state is
            when reset_state =>
                inout_fifo_rst <= '0'; 
                rst_cntr       <= "00000";
                if fifo_rstn = '0' then
                    state    <= suppress_state;
                    suppress <= "11";
                else    
                    state    <=  reset_state;
                    suppress <= "00";
                end if;
            when suppress_state =>
                if (mid_packet_w = '1') and not ((wr_tlast = '1') and (wr_tready = '1') and (wr_tvalid= '1')) then
                   state    <= issue_w_tlast_state;
                   rst_wr_tvalid <= '1';
                   rst_wr_tlast  <= '1'; 
                elsif (mid_packet_r = '1') and not ((rd_tlast = '1') and (rd_tready = '1') and (rd_tvalid= '1')) then
                   state    <= issue_r_tlast_state;
                   rst_rd_tvalid <= '1';
                   rst_rd_tlast  <= '1';
                else
                   state <= reset_fifo_state;
                   inout_fifo_rst <= '1'; 
                end if;
            when issue_w_tlast_state =>
                if (wr_tready = '1') then
                  state         <= reset_fifo_state;
                  rst_wr_tvalid <= '0';
                  rst_wr_tlast  <= '0';    
                  inout_fifo_rst <= '1';                          
                end if;
            when issue_r_tlast_state => 
                if (rd_tready = '1') then
                  state         <= reset_fifo_state;
                  rst_rd_tvalid <= '0';
                  rst_rd_tlast  <= '0'; 
                  inout_fifo_rst <= '1';                         
                end if;             
            when reset_fifo_state =>
                rst_cntr <= rst_cntr + 1;
                if rst_cntr = "11111" then
                    state <= wait_reset_over_state;
                end if;
            when wait_reset_over_state =>
                if fifo_rstn = '1' then
                   inout_fifo_rst <= '0'; 
                   state <= reset_state;
                end if;    
            when others =>
               state <= reset_state;
        end case;  
     end if;   
     inout_fifo_rst_n <= not inout_fifo_rst;     
   end if;
end process;   

--------------------------------------------------------------------------------
-- Counters
--------------------------------------------------------------------------------

fifo_size_bytes <= fifo_size(31 downto 0) & "00";

-- Write Address Counter
process(axis_ddr_aclk)
begin
   if rising_edge(axis_ddr_aclk) then
      fifo_size_m1(31 downto 6)  <= fifo_size_bytes(31 downto 6)-1;
      fifo_size_m2(31 downto 6)  <= fifo_size_bytes(31 downto 6)-2;
      max_addr(31 downto 6)      <= start_addr(31 downto 6) + fifo_size_m1(31 downto 6);
      if (inout_fifo_rst_n = '0') or (t1_axis_aresetn = '0') then
         wr_addr(31 downto 6)    <= start_addr(31 downto 6);   
      elsif (wr_inc = '1') then
         if (wr_addr(31 downto 6) = max_addr(31 downto 6)) then
            wr_addr(31 downto 6) <= start_addr(31 downto 6);
         else
            wr_addr(31 downto 6) <= wr_addr(31 downto 6) + 1;
         end if;   
      end if;
   end if;
end process;   

wr_addr(5 downto 0) <= "000000";
fifo_size_m1(5 downto 0) <= "000000";
fifo_size_m2(5 downto 0) <= "000000";

wr_inc <= in_fifo_rs_tready and in_fifo_rs_tvalid;

-- Read Address Counter
process(axis_ddr_aclk)
begin
   if rising_edge(axis_ddr_aclk) then
      if (inout_fifo_rst_n = '0') or (t1_axis_aresetn = '0') then
         rd_addr(31 downto 6) <= start_addr(31 downto 6); 
      elsif (rd_inc = '1') then
         if (rd_addr(31 downto 6) = max_addr(31 downto 6)) then
            rd_addr(31 downto 6) <= start_addr(31 downto 6);
         else
            rd_addr(31 downto 6) <= rd_addr(31 downto 6) + 1;
         end if;   
      end if;
   end if;
end process;   

rd_addr(5 downto 0) <= "000000";

rd_inc    <= (not ddr_emp) and (not t1_out_fifo_afl) and rd_tready;

rd_tvalid <= ((not ddr_emp) and (not t1_out_fifo_afl)) or rst_rd_tvalid;

process(axis_ddr_aclk)
begin
   if rising_edge(axis_ddr_aclk) then
        if (out_fifo_afl = '0') then
            t1_out_fifo_afl <= '0';
        elsif (out_fifo_afl = '1') and (rd_tvalid = '1') and (rd_tready = '1') then
            t1_out_fifo_afl <= '1';
        end if;
   end if;
end process;

-- Write Counter
process(axis_ddr_aclk)
begin
   if rising_edge(axis_ddr_aclk) then
      if (inout_fifo_rst_n = '0') or (t1_axis_aresetn = '0') then
         wr_count <= ("000" & x"000000"); 
      elsif ((wr_inc = '1') and (rsx_tvalid = '0')) then
         wr_count <= wr_count + 1;
      elsif (rsx_tvalid = '1') and (wr_inc = '0') then
         wr_count <= wr_count - 1;
      end if;
   end if;
end process;   

-- Read Counter
process(axis_ddr_aclk)
begin
   if rising_edge(axis_ddr_aclk) then
      if (inout_fifo_rst_n = '0') or (t1_axis_aresetn = '0') then
         rd_count <= ("000" & x"000000"); 
      elsif ((wr_inc = '1') and (rd_inc = '0')) then
         rd_count <= rd_count + 1;
      elsif (rd_inc = '1') and (wr_inc = '0') then
         rd_count <= rd_count - 1;
      end if;
   end if;
end process;   

process(axis_ddr_aclk)
begin
   if rising_edge(axis_ddr_aclk) then
      if (inout_fifo_rst_n = '0') or (t1_axis_aresetn = '0') then
         ddr_afl <= '0'; 
      elsif (wr_count = fifo_size_m1(31 downto 6)) and (wr_inc = '1') and (rsx_tvalid = '0') then
         ddr_afl <= '1'; 
      elsif (rsx_tvalid = '1') and (wr_inc = '0') then
         ddr_afl <= '0'; 
      end if;
   end if;
end process;   

process(axis_ddr_aclk)
begin
   if rising_edge(axis_ddr_aclk) then
      if (inout_fifo_rst_n = '0') or (t1_axis_aresetn = '0') then
         ddr_aafl <= '0'; 
      elsif (wr_count = fifo_size_m2(31 downto 6)) and (wr_inc = '1') and (rsx_tvalid = '0') then
         ddr_aafl <= '1'; 
      elsif (rsx_tvalid = '1') and (wr_inc = '0') and (ddr_afl = '0') then
         ddr_aafl <= '0'; 
      end if;
   end if;
end process; 

process(axis_ddr_aclk)
begin
   if rising_edge(axis_ddr_aclk) then
      if (inout_fifo_rst_n = '0') or (t1_axis_aresetn = '0') then
         ddr_emp <= '1'; 
      elsif (rd_count = "000000000000000000000000001") and (wr_inc = '0') and (rd_inc = '1') then
         ddr_emp <= '1'; 
      elsif (wr_inc = '1') and (rd_inc = '0') then
         ddr_emp <= '0'; 
      end if;
   end if;
end process;  

process(axis_ddr_aclk)
begin
   if rising_edge(axis_ddr_aclk) then
      if (inout_fifo_rst_n = '0') or (t1_axis_aresetn = '0') then
         ddr_aemp <= '1'; 
      elsif (rd_count = "000000000000000000000000010") and (wr_inc = '0') and (rd_inc = '1') then
         ddr_aemp <= '1'; 
      --elsif (rd_count = "000000000000000000000000001") and (wr_inc = '1') and (rd_inc = '0')then
      elsif (ddr_emp = '0') and (wr_inc = '1') and (rd_inc = '0')then
         ddr_aemp <= '0'; 
      end if;
   end if;
end process;  
--------------------------------------------------------------------------------
-- Control/Status Registers
--------------------------------------------------------------------------------
csr_inst: px_ppkt_ddr4_fifo_csr
port map (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    s_axi_csr_aclk         => s_axi_csr_aclk,      
    s_axi_csr_aresetn      => t1_s_axi_csr_aresetn,   
    s_axi_csr_awaddr       => s_axi_csr_awaddr,    
    s_axi_csr_awprot       => s_axi_csr_awprot,    
    s_axi_csr_awvalid      => s_axi_csr_awvalid,   
    s_axi_csr_awready      => s_axi_csr_awready,   
    s_axi_csr_wdata        => s_axi_csr_wdata,     
    s_axi_csr_wstrb        => s_axi_csr_wstrb,     
    s_axi_csr_wvalid       => s_axi_csr_wvalid,    
    s_axi_csr_wready       => s_axi_csr_wready,    
    s_axi_csr_bresp        => s_axi_csr_bresp,     
    s_axi_csr_bvalid       => s_axi_csr_bvalid,    
    s_axi_csr_bready       => s_axi_csr_bready,    
    s_axi_csr_araddr       => s_axi_csr_araddr,    
    s_axi_csr_arprot       => s_axi_csr_arprot,    
    s_axi_csr_arvalid      => s_axi_csr_arvalid,   
    s_axi_csr_arready      => s_axi_csr_arready,   
    s_axi_csr_rdata        => s_axi_csr_rdata,     
    s_axi_csr_rresp        => s_axi_csr_rresp,     
    s_axi_csr_rvalid       => s_axi_csr_rvalid,    
    s_axi_csr_rready       => s_axi_csr_rready,    
    reg0_init_val          => x"00002F00",
    reg1_init_val          => default_strt_addr,
    reg2_init_val          => default_dw_size,
    reg3_init_val          => x"00000000",
    ctl0_out               => ctl0_out, -- Control 
    ctl1_out               => ctl1_out, -- Start Address 
    ctl2_out               => ctl2_out, -- FIFO Size in DWords
    ctl3_out               => ctl3_out, -- FIFO Flush
    stat0_in               => stat0_in, -- DW Count
    stat1_in               => stat1_in,  -- FIFO Flags
    stat2_in               => stat2_in,  -- FIFO Flags
    stat3_in               => x"00000000",  -- FIFO Flags
    stat4_in               => x"00000000",  -- FIFO Flags
    intrpt_src_in          => intrpt_src_in,
    irq                    => irq
    );  
    
--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------              

cntl_regx <= ctl0_out(13 downto 8) & ctl0_out(1) & ctl2_out & ctl1_out; 

cntl_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 3, -- integer; range: 2-10
  WIDTH          => 71 -- integer; range: 1-1024
)
port map (

  src_clk  => s_axi_csr_aclk,
  src_in   => cntl_regx,
  src_send => src_sendc,
  src_rcv  => src_rcvc,
  dest_clk => axis_ddr_aclk,
  dest_req => dest_reqc,
  dest_ack => dest_reqc, 
  dest_out => cntl_reg_rs
);
 
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     if (src_rcvc = '1') then
       src_sendc <= '0';
     elsif (src_rcvc = '0') and (src_sendc = '0') then
       src_sendc <= '1';
     end if;  
   end if;
end process;      
        
process(axis_ddr_aclk)
begin
   if rising_edge(axis_ddr_aclk) then
     fifo_rstn       <= not (t1_fifo_rst or dest_arst_a or cntl_reg_rs(64) or (not axis_ddr_aresetn));
     t1_fifo_rst     <= dest_arst_a;
     start_addr      <= cntl_reg_rs(31 downto 0);
     fifo_size       <= cntl_reg_rs(63 downto 32);
     p_conseq_access <= cntl_reg_rs(70 downto 65);
     conseq_access   <= p_conseq_access; 
   end if;
end process;

cntlb_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 3, -- integer; range: 2-10
  WIDTH          => 2 -- integer; range: 1-1024
)
port map (

  src_clk  => s_axi_csr_aclk,
  src_in   => ctl0_out(1 downto 0),
  src_send => src_sendb,
  src_rcv  => src_rcvb,
  dest_clk => axis_ppkt_aclk,
  dest_req => dest_reqb,
  dest_ack => dest_reqb, 
  dest_out => cntl_regb_rs
);
 
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     if (src_rcvb = '1') then
       src_sendb <= '0';
     elsif (src_rcvb = '0') and (src_sendb = '0') then
       src_sendb <= '1';
     end if;  
   end if;
end process;   

process(axis_ppkt_aclk)
begin
   if rising_edge(axis_ppkt_aclk) then
     bypass      <= cntl_regb_rs(1);
     rd_disable  <= cntl_regb_rs(0);
   end if;
end process;  


a_cdc_rst_inst: xpm_cdc_async_rst
  generic map (

    -- Common module parameters
     DEST_SYNC_FF    => 3, -- integer; range: 2-10
     RST_ACTIVE_HIGH => 1  -- integer; 0=active low reset, 1=active high reset
  )
  port map (

     src_arst  => ctl3_out(0),
     dest_clk  => axis_ddr_aclk,
     dest_arst => dest_arst_a
  );

b_cdc_rst_inst: xpm_cdc_async_rst
  generic map (

    -- Common module parameters
     DEST_SYNC_FF    => 3, -- integer; range: 2-10
     RST_ACTIVE_HIGH => 1  -- integer; 0=active low reset, 1=active high reset
  )
  port map (

     src_arst  => ctl3_out(0),
     dest_clk  => axis_ppkt_aclk,
     dest_arst => dest_arst_b
  );
  
c_cdc_rst_inst: xpm_cdc_async_rst
    generic map (
  
      -- Common module parameters
       DEST_SYNC_FF    => 3, -- integer; range: 2-10
       RST_ACTIVE_HIGH => 1  -- integer; 0=active low reset, 1=active high reset
    )
    port map (
  
       src_arst  => inout_fifo_rst,
       dest_clk  => axis_ppkt_aclk,
       dest_arst => dest_arst_c
    );  
   

process(axis_ppkt_aclk)
begin
   if rising_edge(axis_ppkt_aclk) then
     fifo_rstnb   <= not (t1_fifo_rstb or dest_arst_b or (not axis_ppkt_aresetn));
     t1_fifo_rstb <= dest_arst_b;
     fifo_rstnc   <= not dest_arst_c;
   end if;
end process;   

      
--------------------------------------------------------------------------------
-- Status Clock Crossing
--------------------------------------------------------------------------------
process(axis_ddr_aclk)
begin
   if rising_edge(axis_ddr_aclk) then
     stat_regx <= rd_peak(26 downto 0) & empty & full & total_count(26 downto 0);
   end if;
end process;

-- Total Count
process(axis_ddr_aclk)
begin
   if rising_edge(axis_ddr_aclk) then
      cnt_suma              <= ("00000000000000000" & in_fifo_count) + (rd_count(26 downto 0));
      t1_out_fifo_count     <= out_fifo_count;
      total_count           <= cnt_suma + ("00000000000000000" &  t1_out_fifo_count); -- Total DWORD Count
      if (total_count = "000000000000000000000000000") then
        empty <= '1';
      else
        empty <= '0';
      end if;
      max_count <= fifo_size_bytes(32 downto 6) + 513;
      if (cnt_suma >= max_count) and (out_fifo_afl = '1') then
        full <= '1';
      else
        full <= '0';
      end if;
      if (fifo_rstn = '0') then
         rd_peak <= (others => '0');
      elsif (('0' & rd_peak) < ('0' & total_count)) then
         rd_peak <= total_count;
      end if; 
   end if;
end process;

stat_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 0, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 3, -- integer; range: 2-10
  WIDTH          => 56 -- integer; range: 1-1024
)
port map (

  src_clk  => axis_ddr_aclk,
  src_in   => stat_regx,
  src_send => src_sends,
  src_rcv  => src_rcvs,
  dest_clk => s_axi_csr_aclk,
  dest_req => dest_reqs,
  dest_ack => dest_reqs, 
  dest_out => stat_reg_rs
);
 
process(axis_ddr_aclk)
begin
   if rising_edge(axis_ddr_aclk) then
     if (src_rcvs = '1') then
       src_sends <= '0';
     elsif (src_rcvs = '0') and (src_sends = '0') then
       src_sends <= '1';
     end if;  
   end if;
end process;   

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      t1_s_axi_csr_aresetn  <= s_axi_csr_aresetn;
      stat0_in(30 downto 4) <= stat_reg_rs(26 downto 0); -- Total DWORD Count
      stat1_in(30 downto 4) <= stat_reg_rs(55 downto 29); -- Max DWORD Count
      stat2_in(0)           <= stat_reg_rs(28);
      stat2_in(1)           <= stat_reg_rs(27);
   end if;
end process;
 
stat0_in(31)          <= '0'; 
stat0_in(3 downto 0)  <= "0000"; 
stat1_in(31)          <= '0'; 
stat1_in(3 downto 0)  <= "0000"; 
stat2_in(31 downto 2) <= (others => '0');

overrun_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 0, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_ppkt_aclk,
    src_rst    => '0',  -- optional; required when RST_USED = 1
    src_pulse  => overrun,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => intrpt_src_in(0)
);

process(axis_ppkt_aclk)
begin
   if rising_edge(axis_ppkt_aclk) then
      t1_bypass <= bypass;
      t1_bypass_full_led_in <= bypass_full_led_in;
      t2_bypass_full_led_in <= t1_bypass_full_led_in;
      if (t1_bypass = '0') then
         t1_overrun    <= overrun;
      else
         t1_overrun    <= t2_bypass_full_led_in;
      end if;    
      fifo_full_led <= t1_overrun;
   end if;
end process;   


end Behavioral;
