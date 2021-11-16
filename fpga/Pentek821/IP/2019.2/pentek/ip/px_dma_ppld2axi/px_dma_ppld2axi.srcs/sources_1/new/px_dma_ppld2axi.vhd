
----------------------------------------------------------------------------------
-- Pentek PPLD Data Stream to AXI-4 DMA
----------------------------------------------------------------------------------
-- px_dma_ppld2axi.vhd
--
-- Target Device: Kintex UltraScale
--
-- Pentek Inc.
-- One Park Way, Upper Saddle River, NJ 07458
-- (201)818-5900
-- www.pentek.com
--
-- Copyright Pentek, Inc. 2018
--
-- Revision:
-- Revision 1.0 - File Created
-- 
-- Additional Comments: DMA Start Addresses MUST start on 64 byte address boundaries!

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- (c) Copyright 2018 Pentek, Inc. All rights reserved.
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

-------------------------------------------------------------------------------
-- Main Entity
-------------------------------------------------------------------------------


entity px_dma_ppld2axi is
generic(
channel_id                  : integer range 0 to 7 := 0; -- 0-7 (must be unique)
channel_id_width            : integer range 1 to 16 := 5; -- 0-6 (must be unique)
desc_axi_addr_width         : integer range 7 to 64 := 64;
data_axi_addr_width         : integer range 7 to 64 := 64
);
port (
   aclk                     : in  std_logic; 
   -- associated with aclk
   aresetn                  : in  std_logic;
   ----------------------------------------------------------------------------
   -- Control/Status Registers (AXI-LITE)
   ----------------------------------------------------------------------------
   -- associated with aclk
   s_axi_csr_aresetn        : in  std_logic; -- reset control/status registers only
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
   
   irq_clk                  : in  std_logic;
   irq                      : out std_logic; -- Interrupt out
   ----------------------------------------------------------------------------
   -- Linked List Descriptor RAM (AXI-4) 
   ----------------------------------------------------------------------------
   -- Associated with aclk
   m_axi_descr_arid         : out std_logic_vector(channel_id_width-1 downto 0);
   m_axi_descr_araddr       : out std_logic_vector(desc_axi_addr_width-1 downto 0);
   m_axi_descr_arprot       : out std_logic_vector(2 downto 0);
   m_axi_descr_arsize       : out std_logic_vector(2 downto 0);
   m_axi_descr_arburst      : out std_logic_vector(1 downto 0);
   m_axi_descr_arlen        : out std_logic_vector(7 downto 0);
   m_axi_descr_arvalid      : out std_logic;
   m_axi_descr_arready      : in  std_logic;
   m_axi_descr_rdata        : in  std_logic_vector(255 downto 0);
   m_axi_descr_rresp        : in  std_logic_vector(1 downto 0);
   m_axi_descr_rvalid       : in  std_logic;
   m_axi_descr_rlast        : in  std_logic;
   m_axi_descr_rready       : out std_logic;    
   m_axi_descr_rid          : in  std_logic_vector(channel_id_width-1 downto 0);
   -----------------------------------------------------------------------------
   -- Input AXI-S PPLD Stream (Pre-Packaged Payloads Packets)
   -----------------------------------------------------------------------------
   s_axis_ppld_tvalid       : in  std_logic;
   s_axis_ppld_tready       : out std_logic;
   s_axis_ppld_tdata        : in  std_logic_vector(511 downto 0);
   -- tuser[63:0]    = timestamp[63:0]  
   -- tuser[64]      = Start of Payload Packet   
   -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
   -- tuser[67]      = Data Type 0 = Real 1 = I/Q
   -- tuser[75:68]   = channel[7:0]
   -- tuser[77:76]   = Reserved
   -- tuser[78]      = Acq. Start
   -- tuser[79]      = Acq. End (Input PPKT had tlast)
   -- tuser[96:80]   = Payload Size (bytes)
   -- tuser[103:97]  = Number Valid Bytes in cycle
   s_axis_ppld_tuser        : in  std_logic_vector(103 downto 0);
   s_axis_ppld_tkeep        : in  std_logic_vector(63 downto 0); -- One per byte
   s_axis_ppld_tlast        : in  std_logic; -- End of Payload Packet    
   ----------------------------------------------------------------------------
   -- Output Data Bus (AXI-4 Master)
   ----------------------------------------------------------------------------  
   m_axi_s2mm_awid          : out std_logic_vector(channel_id_width-1 downto 0);        
   m_axi_s2mm_awaddr        : out std_logic_vector(data_axi_addr_width-1 downto 0);       
   m_axi_s2mm_awlen         : out std_logic_vector(7 downto 0);        
   m_axi_s2mm_awsize        : out std_logic_vector(2 downto 0);        
   m_axi_s2mm_awburst       : out std_logic_vector(1 downto 0);        
   m_axi_s2mm_awprot        : out std_logic_vector(2 downto 0);        
   m_axi_s2mm_awcache       : out std_logic_vector(3 downto 0);        
   m_axi_s2mm_awuser        : out std_logic_vector(3 downto 0);        
   m_axi_s2mm_awvalid       : out std_logic;                           
   m_axi_s2mm_awready       : in std_logic;                            
   m_axi_s2mm_wdata         : out std_logic_vector(511 downto 0);      
   m_axi_s2mm_wstrb         : out std_logic_vector(63 downto 0);       
   m_axi_s2mm_wlast         : out std_logic;                           
   m_axi_s2mm_wvalid        : out std_logic;                           
   m_axi_s2mm_wready        : in std_logic;                            
   m_axi_s2mm_bresp         : in std_logic_vector(1 downto 0);         
   m_axi_s2mm_bvalid        : in std_logic;                            
   m_axi_s2mm_bready        : out std_logic;   
   m_axi_s2mm_bid           : in  std_logic_vector(channel_id_width-1 downto 0);                   
   ----------------------------------------------------------------------------
   -- Misc. Control
   ------------------------------------------------------------------------------ 
   -- 64,128,256,512,1024,2048,4096,8192 bytes
   payload_size_ctl         : out std_logic_vector(13 downto 0);
   payload_size_ctl_en      : out std_logic;
   external_fifo_rstn       : out std_logic
);
end px_dma_ppld2axi;

architecture Behavioral of px_dma_ppld2axi is

-------------------------------------------------------------------------------
-- Components
-------------------------------------------------------------------------------

-- DMA State Machine
component px_dma_ppld2axi_dma_sm is
generic(
desc_ram_addr_width         : integer range 7 to 64 := 32   
);
port (
  clk                         : in  std_logic;
  rst_n                       : in  std_logic;
  ----------------------------------------------------------------------------
  -- Buffer Read Requests to Reader Module
  ----------------------------------------------------------------------------
  buffer_rd_rqst_valid        : out std_logic; 
  buffer_rd_rqst_ready        : in  std_logic; 
  buffer_rd_rqst_data         : out std_logic_vector(167 downto 0);
  -- buffer_rd_rqst_data[63:0]    = Destination Start Address -- PCIe Address -- Address must be on 4 byte address boundary
  -- buffer_rd_rqst_data[127:64]  = Destination Meta Start Address  -- Address must be on 4 byte address boundary
  -- buffer_rd_rqst_data[159:128] = Size in bytes
  -- buffer_rd_rqst_data[160]     = Write Meta Data
  -- buffer_rd_rqst_data[161]     = INCR AXI Type 
  -- buffer_rd_rqst_data[162]     = SOP Start 
  -- buffer_rd_rqst_data[163]     = Allow end on EOF      
  -- buffer_rd_rqst_data[167:164] = reserved
  buffer_rd_complete          : in  std_logic; -- All reads of FIFO required for the Buffer Read Request have completed.                
  buffer_actual_bytes         : in  std_logic_vector(31 downto 0); -- Actual number of bytes sent
  buffer_actual_bytes_valid   : in  std_logic;            
  ----------------------------------------------------------------------------
  -- Descriptor RAM interface
  ----------------------------------------------------------------------------
  -- Associated with clk
  m_axi_descr_araddr          : out std_logic_vector(desc_ram_addr_width -1 downto 0);
  m_axi_descr_arprot          : out std_logic_vector(2 downto 0);
  m_axi_descr_arsize          : out std_logic_vector(2 downto 0);
  m_axi_descr_arburst         : out std_logic_vector(1 downto 0);
  m_axi_descr_arlen           : out std_logic_vector(7 downto 0);
  m_axi_descr_arvalid         : out std_logic;
  m_axi_descr_arready         : in  std_logic;
  m_axi_descr_rdata           : in  std_logic_vector(255 downto 0);
  m_axi_descr_rresp           : in  std_logic_vector(1 downto 0);
  m_axi_descr_rvalid          : in  std_logic;
  m_axi_descr_rlast           : in  std_logic;
  m_axi_descr_rready          : out std_logic;          
  ----------------------------------------------------------------------------
  -- Controls
  ----------------------------------------------------------------------------
  dma_restart                 : in  std_logic; -- DMA Reset
  dma_advance                 : in  std_logic; -- DMA Advance
  dma_abort                   : in  std_logic; -- DMA Abort
  abort_all_out               : out std_logic; -- Abort to associated logic
  abort_all_done              : in  std_logic; 
  start_link_descr_addr       : in  std_logic_vector(63 downto 0);
  ----------------------------------------------------------------------------
  -- Status
  ----------------------------------------------------------------------------
  abort_cmplt                 : out std_logic; -- Abort Complete Status
  dma_active                  : out std_logic; -- Active Status 
  dma_paused                  : out std_logic; -- Pause Status 
  waiting_for_adv             : out std_logic; -- Waiting For Advance Status
  link_end                    : out std_logic; -- Link End interrupt pulse (one clock cycle)
  chain_end                   : out std_logic; -- Link End interrupt pulse (one clock cycle)
  link_end_int                : out std_logic; -- Link End interrupt pulse (one clock cycle)
  chain_end_int               : out std_logic; -- Link End interrupt pulse (one clock cycle)
  link_start                  : out std_logic; -- Start of link pulse 
 
  current_link_address        : out std_logic_vector(63 downto 0);  -- Current Link
  last_link_address           : out std_logic_vector(63 downto 0);  -- Last Link
  bytes_last_transferred      : out std_logic_vector(31 downto 0)   -- Last Bytes Transferred
  );
end component;

COMPONENT px_dma_ppld2axi_datamover
  PORT (
    m_axi_s2mm_aclk : IN STD_LOGIC;
    m_axi_s2mm_aresetn : IN STD_LOGIC;
    s2mm_halt : IN STD_LOGIC;
    s2mm_halt_cmplt : OUT STD_LOGIC;
    s2mm_err : OUT STD_LOGIC;
    m_axis_s2mm_cmdsts_awclk : IN STD_LOGIC;
    m_axis_s2mm_cmdsts_aresetn : IN STD_LOGIC;
    s_axis_s2mm_cmd_tvalid : IN STD_LOGIC;
    s_axis_s2mm_cmd_tready : OUT STD_LOGIC;
    s_axis_s2mm_cmd_tdata : IN STD_LOGIC_VECTOR(103 DOWNTO 0);
    m_axis_s2mm_sts_tvalid : OUT STD_LOGIC;
    m_axis_s2mm_sts_tready : IN STD_LOGIC;
    m_axis_s2mm_sts_tdata : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    m_axis_s2mm_sts_tkeep : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axis_s2mm_sts_tlast : OUT STD_LOGIC;
    s2mm_allow_addr_req : IN STD_LOGIC;
    s2mm_addr_req_posted : OUT STD_LOGIC;
    s2mm_wr_xfer_cmplt : OUT STD_LOGIC;
    s2mm_ld_nxt_len : OUT STD_LOGIC;
    s2mm_wr_len : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    m_axi_s2mm_awid : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    m_axi_s2mm_awaddr : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
    m_axi_s2mm_awlen : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    m_axi_s2mm_awsize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    m_axi_s2mm_awburst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_s2mm_awprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    m_axi_s2mm_awcache : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    m_axi_s2mm_awuser : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    m_axi_s2mm_awvalid : OUT STD_LOGIC;
    m_axi_s2mm_awready : IN STD_LOGIC;
    m_axi_s2mm_wdata : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
    m_axi_s2mm_wstrb : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
    m_axi_s2mm_wlast : OUT STD_LOGIC;
    m_axi_s2mm_wvalid : OUT STD_LOGIC;
    m_axi_s2mm_wready : IN STD_LOGIC;
    m_axi_s2mm_bresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_s2mm_bvalid : IN STD_LOGIC;
    m_axi_s2mm_bready : OUT STD_LOGIC;
    s_axis_s2mm_tdata : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
    s_axis_s2mm_tkeep : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    s_axis_s2mm_tlast : IN STD_LOGIC;
    s_axis_s2mm_tvalid : IN STD_LOGIC;
    s_axis_s2mm_tready : OUT STD_LOGIC;
    s2mm_dbg_sel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s2mm_dbg_data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

component px_dma_ppld2axi_reader
port (
    ----------------------------------------------------------------------------
    aclk                         : in  std_logic;
    aresetn                      : in  std_logic;
    ----------------------------------------------------------------------------
    -- Buffer Read Requests from DMA
    ----------------------------------------------------------------------------
    buffer_rd_rqst_valid         : in  std_logic; 
    buffer_rd_rqst_ready         : out std_logic; 
    buffer_rd_rqst_data          : in  std_logic_vector(167 downto 0);
    -- buffer_rd_rqst_data[63:0]    = Destination Start Address -- PCIe Address -- Address must be on 4 byte address boundary
    -- buffer_rd_rqst_data[127:64]  = Destination Meta Start Address  -- Address must be on 4 byte address boundary
    -- buffer_rd_rqst_data[159:128] = Size in bytes
    -- buffer_rd_rqst_data[160]     = Write Meta Data
    -- buffer_rd_rqst_data[161]     = INCR AXI Type 
    -- buffer_rd_rqst_data[162]     = Reserved 
    -- buffer_rd_rqst_data[163]     = Allow end on EOF      
    -- buffer_rd_rqst_data[167:164] = Reserved
    buffer_rd_complete           : out std_logic;
   -----------------------------------------------------------------------------
    -- Input AXI-S PPLD Stream (Pre-Packaged Payloads Packets)
    -----------------------------------------------------------------------------
    s_axis_ppld_tvalid       : in  std_logic;
    s_axis_ppld_tready       : out std_logic;
    s_axis_ppld_tdata        : in  std_logic_vector(511 downto 0);
    -- tuser[63:0]    = timestamp[63:0]  
    -- tuser[64]      = Start of Payload Packet   
    -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
    -- tuser[67]      = Data Type 0 = Real 1 = I/Q
    -- tuser[75:68]   = channel[7:0]
    -- tuser[77:76]   = Reserved
    -- tuser[78]      = Acq. Start (Input PPKT SOP)    
    -- tuser[79]      = Acq. End (Input PPKT had tlast)
    -- tuser[96:80]   = Payload Size (bytes)
    -- tuser[103:97]  = Number Valid Bytes in cycle
    s_axis_ppld_tuser        : in  std_logic_vector(103 downto 0);
    s_axis_ppld_tkeep        : in  std_logic_vector(63 downto 0); -- One per byte
    s_axis_ppld_tlast        : in  std_logic; -- End of Payload Packet    
    ----------------------------------------------------------------------------
    -- Commands to Data Mover (AXI Stream)
    ----------------------------------------------------------------------------    
    m_axis_s2mm_cmd_tvalid   : out std_logic;
    m_axis_s2mm_cmd_tready   : in  std_logic;
    m_axis_s2mm_cmd_tdata    : out std_logic_vector(103 downto 0);
    m_axi_s2mm_aresetn       : out std_logic;
    s2mm_halt                : out std_logic;
    s2mm_halt_cmplt          : in  std_logic;
    s2mm_err                 : in  std_logic;
    ----------------------------------------------------------------------------
    -- Status From Data Mover (AXI Stream)
    ----------------------------------------------------------------------------       
    s_axis_s2mm_sts_tvalid   : in  std_logic;
    s_axis_s2mm_sts_tready   : out std_logic;
    s_axis_s2mm_sts_tdata    : in  std_logic_vector(7 downto 0);
    s_axis_s2mm_sts_tkeep    : in  std_logic_vector(0 downto 0);
    s_axis_s2mm_sts_tlast    : in  std_logic;
    ----------------------------------------------------------------------------
    -- Data Out To Data Mover (AXI Stream)
    ----------------------------------------------------------------------------
    m_axis_s2mm_tvalid        : out std_logic;
    m_axis_s2mm_tready        : in  std_logic;
    m_axis_s2mm_tlast         : out std_logic;
    m_axis_s2mm_tdata         : out std_logic_vector(511 downto 0);
    m_axis_s2mm_tkeep         : out std_logic_vector(63 downto 0);
    ----------------------------------------------------------------------------
    -- Controls
    ----------------------------------------------------------------------------
    abort                        : in  std_logic;
    abort_busy                   : out std_logic; 
    fifo_flush                   : in std_logic;
    external_fifo_rstn           : out std_logic;
    ----------------------------------------------------------------------------
    -- Status
    ----------------------------------------------------------------------------
    eop_reached                  : out std_logic;
    actual_bytes                 : out std_logic_vector(31 downto 0); -- Actual number of Bytes Transferred
    actual_bytes_valid           : out std_logic;  -- Actual number of Bytes Transferred valid
    error_irq                    : out std_logic;
    xfr_error                    : out std_logic_vector(2 downto 0)
 );
end component;

-- Control/Status Registers
component px_dma_ppld2axi_csr
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    s_axi_csr_aclk        : in  std_logic;
    s_axi_csr_aresetn     : in  std_logic;
    s_axi_csr_awaddr      : in  std_logic_vector(5 downto 0); -- only [5:0] used
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
    s_axi_csr_araddr      : in  std_logic_vector(5 downto 0);  -- only [5:0] used
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
    start_link_descr_addr : out std_logic_vector(63 downto 0);
    dma_restart           : out std_logic;
    dma_advance           : out std_logic;
    dma_abort             : out std_logic;
    fifo_flush            : out std_logic;
    out_size_en           : out std_logic;
    out_size              : out std_logic_vector(13 downto 0);
--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------       	           
    current_link_address  : in  std_logic_vector(63 downto 0);
    last_link_address     : in  std_logic_vector(63 downto 0);
    bytes_last_transferred: in  std_logic_vector(31 downto 0); 
    dma_aborting          : in  std_logic;
    dma_waiting_for_sync  : in  std_logic;
    dma_waiting_for_adv   : in  std_logic;
    dma_paused            : in  std_logic;
    dma_active            : in  std_logic;
 --------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------    
    all_rds_cmplt         : in  std_logic;
    abort_cmplt           : in  std_logic;
    waiting_adv           : in  std_logic;
    chain_end_int         : in  std_logic;
    link_end_int          : in  std_logic;
    chain_end             : in  std_logic;
    link_end              : in  std_logic;
    link_start            : in  std_logic;
    eop_reached           : in  std_logic;
    error_irq             : in  std_logic;
    xfr_error             : in  std_logic_vector(2 downto 0)
);
end component;

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTERRUPT";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of aclk: SIGNAL is "xilinx.com:signal:clock:1.0 aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr:m_axi_s2mm:s_axis_ppld:m_axi_descr, ASSOCIATED_RESET s_axi_csr_aresetn:aresetn:external_fifo_rstn";

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal abort_cmplt                : std_logic := '0';
signal dma_advance                : std_logic := '0'; -- DMA Advance
signal dma_waiting_for_adv        : std_logic := '0'; -- Waiting For Advance Status
signal dma_waiting_for_sync       : std_logic := '0';
signal dma_active                 : std_logic := '0'; -- Active Status 
signal dma_paused                 : std_logic := '0'; -- Pause Status 
signal buffer_rqst_complete       : std_logic := '0'; -- All HMC requests required for a Buffer Read Request have been issued
signal buffer_rd_complete         : std_logic := '0'; -- All reads of the HMC required for the Buffer Read Request have completed.
signal link_end_int               : std_logic := '0'; -- Link End interrupt pulse
signal chain_end_int              : std_logic := '0'; -- Chain End interrupt pulse
signal link_start                 : std_logic := '0';  
signal dma_restart                : std_logic := '0';
signal dma_abort                  : std_logic := '0';
signal start_link_descr_addr      : std_logic_vector(63 downto 0) := (others => '0');
signal chain_end                  : std_logic := '0';
signal link_end                   : std_logic := '0';
signal current_link_address       : std_logic_vector(63 downto 0) := (others => '0');  -- Current Link
signal last_link_address          : std_logic_vector(63 downto 0) := (others => '0');  -- Last Link
signal bytes_last_transferred     : std_logic_vector(31 downto 0) := (others => '0');   -- Last Bytes Transferred
signal buffer_rd_rqst_valid       : std_logic := '0';
signal buffer_rd_rqst_ready       : std_logic := '0';
signal buffer_rd_rqst_data        : std_logic_vector(167 downto 0) := (others => '0'); 
signal buffer_actual_bytes        : std_logic_vector(31 downto 0) := (others => '0');      
signal abort_all_out              : std_logic := '0';                                                                                                                                
signal t1_reader_abort_busy       : std_logic := '0';
signal reader_abort_busy          : std_logic := '0';                                                       
signal fe_reader_abort_busy       : std_logic := '0';
signal t1_rst_n                   : std_logic := '0';
signal buffer_actual_bytes_valid  : std_logic := '0';
signal in_fifo_tuser              : std_logic_vector(87 downto 0) := (others => '0');
signal eop_reached                : std_logic := '0';
signal t1_s_axi_csr_aresetn       : std_logic := '0';
signal xfr_error                  : std_logic_vector(2 downto 0) := (others => '0');
signal error_irq                  : std_logic := '0';
signal m_axi_s2mm_aresetn         : std_logic := '0';
signal s2mm_halt                  : std_logic := '0';        
signal s2mm_halt_cmplt            : std_logic := '0';  
signal axis_s2mm_cmd_tvalid       : std_logic := '0';
signal axis_s2mm_cmd_tready       : std_logic := '0';
signal axis_s2mm_cmd_tdata        : std_logic_vector(103 downto 0) := (others => '0');
signal axis_s2mm_sts_tvalid       : std_logic := '0';
signal axis_s2mm_sts_tready       : std_logic := '0';
signal axis_s2mm_sts_tdata        : std_logic_vector(7 downto 0) := (others => '0');
signal axis_s2mm_sts_tkeep        : std_logic_vector(0 downto 0) := (others => '0');
signal axis_s2mm_sts_tlast        : std_logic := '0';
signal axis_s2mm_tvalid           : std_logic := '0';
signal axis_s2mm_tready           : std_logic := '0';
signal axis_s2mm_tlast            : std_logic := '0';
signal axis_s2mm_tdata            : std_logic_vector(511 downto 0) := (others => '0');
signal axis_s2mm_tkeep            : std_logic_vector(63 downto 0) := (others => '0');
signal fifo_flush                 : std_logic := '0';
signal axi_s2mm_awaddr            : std_logic_vector(63 downto 0) := (others => '0');  
signal s2mm_err                   : std_logic := '0';
signal irqx                       : std_logic := '0';
signal irqxx                      : std_logic := '0';
signal t1_s_axi_csr_areset        : std_logic := '0';

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

constant chan_id_num  : std_logic_vector(channel_id_width-1 downto 0)  := conv_std_logic_vector(channel_id, channel_id_width);

-------------------------------------------------------------------------------

begin

-------------------------------------------------------------------------------
-- Linked List DMA State Machine
-------------------------------------------------------------------------------
dma_sm_inst: px_dma_ppld2axi_dma_sm
generic map(
desc_ram_addr_width      => desc_axi_addr_width      
)
port map (
   clk                         =>  aclk,
   rst_n                       =>  t1_rst_n,
   ----------------------------------------------------------------------------
   -- Buffer Write Requests to HMC Writer Module
   ----------------------------------------------------------------------------
   buffer_rd_rqst_valid        =>  buffer_rd_rqst_valid, 
   buffer_rd_rqst_ready        =>  buffer_rd_rqst_ready, 
   buffer_rd_rqst_data         =>  buffer_rd_rqst_data,  
   -- buffer_rd_rqst_data[63:0]    = Destination Start Address -- PCIe Address -- Address must be on 4 byte address boundary
   -- buffer_rd_rqst_data[127:64]  = Destination Meta Start Address  -- Address must be on 4 byte address boundary
   -- buffer_rd_rqst_data[159:128] = Size in bytes
   -- buffer_rd_rqst_data[160]     = Write Meta Data
   -- buffer_rd_rqst_data[161]     = INCR AXI Type 
   -- buffer_rd_rqst_data[162]     = Reserved 
   -- buffer_rd_rqst_data[163]     = Allow end on EOF      
   -- buffer_rd_rqst_data[167:164] = reserved
   buffer_rd_complete          =>  buffer_rd_complete,   -- All reads required for the Buffer Read Request have completed.  
   buffer_actual_bytes         =>  buffer_actual_bytes,  -- Actual number of bytes read
   buffer_actual_bytes_valid   =>  buffer_actual_bytes_valid, 
  ----------------------------------------------------------------------------
   -- Descriptor RAM interface
   ----------------------------------------------------------------------------
   -- associated with clk
   m_axi_descr_araddr            => m_axi_descr_araddr  ,  
   m_axi_descr_arprot            => m_axi_descr_arprot  ,
   m_axi_descr_arsize            => m_axi_descr_arsize  ,
   m_axi_descr_arburst           => m_axi_descr_arburst ,
   m_axi_descr_arlen             => m_axi_descr_arlen   ,
   m_axi_descr_arvalid           => m_axi_descr_arvalid ,
   m_axi_descr_arready           => m_axi_descr_arready ,
   m_axi_descr_rdata             => m_axi_descr_rdata   ,
   m_axi_descr_rresp             => m_axi_descr_rresp   ,
   m_axi_descr_rvalid            => m_axi_descr_rvalid  ,
   m_axi_descr_rlast             => m_axi_descr_rlast   ,
   m_axi_descr_rready            => m_axi_descr_rready  ,
   ----------------------------------------------------------------------------
   -- Controls
   ----------------------------------------------------------------------------
   dma_restart                 => dma_restart,
   dma_advance                 => dma_advance,    
   dma_abort                   => dma_abort,  
   abort_all_out               => abort_all_out, -- Abort to associated logic
   abort_all_done              => fe_reader_abort_busy,
   start_link_descr_addr       => start_link_descr_addr,
   ----------------------------------------------------------------------------
   -- Status
   ----------------------------------------------------------------------------
   abort_cmplt                 => abort_cmplt,          
   waiting_for_adv             => dma_waiting_for_adv, 
   dma_active                  => dma_active,     
   dma_paused                  => dma_paused,     
   link_end                    => link_end,   
   chain_end                   => chain_end, 
   link_end_int                => link_end_int,   
   chain_end_int               => chain_end_int,      
   link_start                  => link_start,             
   current_link_address        => current_link_address,     
   last_link_address           => last_link_address,        
   bytes_last_transferred      => bytes_last_transferred  
);

datamover_inst : px_dma_ppld2axi_datamover
  port map (
    m_axi_s2mm_aclk              => aclk,
    m_axi_s2mm_aresetn           => m_axi_s2mm_aresetn,
    s2mm_halt                    => s2mm_halt,
    s2mm_halt_cmplt              => s2mm_halt_cmplt,
    s2mm_err                     => s2mm_err,
    m_axis_s2mm_cmdsts_awclk     => aclk,
    m_axis_s2mm_cmdsts_aresetn   => m_axi_s2mm_aresetn,
    s_axis_s2mm_cmd_tvalid       => axis_s2mm_cmd_tvalid,
    s_axis_s2mm_cmd_tready       => axis_s2mm_cmd_tready,
    s_axis_s2mm_cmd_tdata        => axis_s2mm_cmd_tdata,
    m_axis_s2mm_sts_tvalid       => axis_s2mm_sts_tvalid,
    m_axis_s2mm_sts_tready       => axis_s2mm_sts_tready,
    m_axis_s2mm_sts_tdata        => axis_s2mm_sts_tdata,
    m_axis_s2mm_sts_tkeep        => axis_s2mm_sts_tkeep,
    m_axis_s2mm_sts_tlast        => axis_s2mm_sts_tlast,
    s2mm_allow_addr_req          => '1',
    s2mm_addr_req_posted         => open,
    s2mm_wr_xfer_cmplt           => open,
    s2mm_ld_nxt_len              => open,
    s2mm_wr_len                  => open,
    m_axi_s2mm_awid              => open,
    m_axi_s2mm_awaddr            => axi_s2mm_awaddr,
    m_axi_s2mm_awlen             => m_axi_s2mm_awlen,
    m_axi_s2mm_awsize            => m_axi_s2mm_awsize,
    m_axi_s2mm_awburst           => m_axi_s2mm_awburst,
    m_axi_s2mm_awprot            => m_axi_s2mm_awprot,
    m_axi_s2mm_awcache           => m_axi_s2mm_awcache,
    m_axi_s2mm_awuser            => m_axi_s2mm_awuser,
    m_axi_s2mm_awvalid           => m_axi_s2mm_awvalid,
    m_axi_s2mm_awready           => m_axi_s2mm_awready,
    m_axi_s2mm_wdata             => m_axi_s2mm_wdata,
    m_axi_s2mm_wstrb             => m_axi_s2mm_wstrb,
    m_axi_s2mm_wlast             => m_axi_s2mm_wlast,
    m_axi_s2mm_wvalid            => m_axi_s2mm_wvalid,
    m_axi_s2mm_wready            => m_axi_s2mm_wready,
    m_axi_s2mm_bresp             => m_axi_s2mm_bresp,
    m_axi_s2mm_bvalid            => m_axi_s2mm_bvalid,
    m_axi_s2mm_bready            => m_axi_s2mm_bready,
    s_axis_s2mm_tdata            => axis_s2mm_tdata,
    s_axis_s2mm_tkeep            => axis_s2mm_tkeep,
    s_axis_s2mm_tlast            => axis_s2mm_tlast,
    s_axis_s2mm_tvalid           => axis_s2mm_tvalid,
    s_axis_s2mm_tready           => axis_s2mm_tready,
    s2mm_dbg_sel                 => "0000",
    s2mm_dbg_data                => open
  );


m_axi_s2mm_awaddr <= axi_s2mm_awaddr(data_axi_addr_width-1 downto 0);    
m_axi_s2mm_awid   <= chan_id_num;
m_axi_descr_arid  <= chan_id_num;

--------------------------------------------------------------------------------
-- FIFO to PCIe Payload State Machine
--------------------------------------------------------------------------------
reader_inst: px_dma_ppld2axi_reader
port map (
    ----------------------------------------------------------------------------
    aclk                         =>  aclk,
    aresetn                      =>  t1_rst_n,
    ----------------------------------------------------------------------------
    -- Buffer Read Requests from DMA
    ----------------------------------------------------------------------------
    buffer_rd_rqst_valid         => buffer_rd_rqst_valid,
    buffer_rd_rqst_ready         => buffer_rd_rqst_ready,
    buffer_rd_rqst_data          => buffer_rd_rqst_data, 
    -- buffer_rd_rqst_data[63:0]    = Destination Start Address -- PCIe Address -- Address must be on 4 byte address boundary
    -- buffer_rd_rqst_data[127:64]  = Destination Meta Start Address  -- Address must be on 4 byte address boundary
    -- buffer_rd_rqst_data[159:128] = Size in bytes
    -- buffer_rd_rqst_data[160]     = Write Meta Data
    -- buffer_rd_rqst_data[161]     = INCR AXI Type 
    -- buffer_rd_rqst_data[162]     = Reserved 
    -- buffer_rd_rqst_data[163]     = Allow end on EOF      
    -- buffer_rd_rqst_data[167:164] = Reserved
    buffer_rd_complete           => buffer_rd_complete,
    -----------------------------------------------------------------------------
    -- Input AXI-S PPLD Stream (Pre-Packaged Payloads Packets)
    -----------------------------------------------------------------------------
    s_axis_ppld_tvalid          => s_axis_ppld_tvalid,   
    s_axis_ppld_tready          => s_axis_ppld_tready,   
    s_axis_ppld_tdata           => s_axis_ppld_tdata,    
    -- tuser[63:0]    = timestamp[63:0]  
    -- tuser[64]      = Start of Payload Packet   
    -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
    -- tuser[67]      = Data Type 0 = Real 1 = I/Q
    -- tuser[75:68]   = channel[7:0]
    -- tuser[77:76]   = Reserved
    -- tuser[78]      = Acq. Start (Input PPKT SOP)    
    -- tuser[79]      = Acq. End (Input PPKT had tlast)
    -- tuser[96:80]   = Payload Size (bytes)
    -- tuser[103:97]  = Number Valid Bytes in cycle
    s_axis_ppld_tuser           => s_axis_ppld_tuser,
    s_axis_ppld_tkeep           => s_axis_ppld_tkeep,
    s_axis_ppld_tlast           => s_axis_ppld_tlast,
    ----------------------------------------------------------------------------
    -- Commands to Data Mover (AXI Stream)
    ----------------------------------------------------------------------------    
    m_axis_s2mm_cmd_tvalid      => axis_s2mm_cmd_tvalid,  
    m_axis_s2mm_cmd_tready      => axis_s2mm_cmd_tready,   
    m_axis_s2mm_cmd_tdata       => axis_s2mm_cmd_tdata,    
    m_axi_s2mm_aresetn          => m_axi_s2mm_aresetn,       
    s2mm_halt                   => s2mm_halt,                
    s2mm_halt_cmplt             => s2mm_halt_cmplt,   
    s2mm_err                    => s2mm_err,       
    ----------------------------------------------------------------------------
    -- Status From Data Mover (AXI Stream)
    ----------------------------------------------------------------------------       
    s_axis_s2mm_sts_tvalid      => axis_s2mm_sts_tvalid,
    s_axis_s2mm_sts_tready      => axis_s2mm_sts_tready,
    s_axis_s2mm_sts_tdata       => axis_s2mm_sts_tdata(7 downto 0), 
    s_axis_s2mm_sts_tkeep       => axis_s2mm_sts_tkeep(0 downto 0), 
    s_axis_s2mm_sts_tlast       => axis_s2mm_sts_tlast, 
    ----------------------------------------------------------------------------
    -- Data Out To Data Mover (AXI Stream)
    ----------------------------------------------------------------------------
    m_axis_s2mm_tvalid          => axis_s2mm_tvalid, 
    m_axis_s2mm_tready          => axis_s2mm_tready, 
    m_axis_s2mm_tlast           => axis_s2mm_tlast,  
    m_axis_s2mm_tdata           => axis_s2mm_tdata,  
    m_axis_s2mm_tkeep           => axis_s2mm_tkeep,  
    ----------------------------------------------------------------------------
    -- Controls
    ----------------------------------------------------------------------------
    abort                        => abort_all_out,
    abort_busy                   => reader_abort_busy, 
    fifo_flush                   => fifo_flush,
    external_fifo_rstn           => external_fifo_rstn,
    ----------------------------------------------------------------------------
    -- Status
    ----------------------------------------------------------------------------
    eop_reached                  => eop_reached,  
    actual_bytes                 => buffer_actual_bytes,      -- Actual number of Bytes Transferred
    actual_bytes_valid           => buffer_actual_bytes_valid, -- Actual number of Bytes Transferred valid
    error_irq                    => error_irq,
    xfr_error                    => xfr_error
 );


--------------------------------------------------------------------------------
-- Control/Status Registers
--------------------------------------------------------------------------------
csr_inst: px_dma_ppld2axi_csr
port map (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    s_axi_csr_aclk         => aclk,      
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
    
    irq                    => irqx,    -- interrupt
    --------------------------------------------------------------------------------
    -- Control Outputs
    --------------------------------------------------------------------------------    
    start_link_descr_addr  => start_link_descr_addr,   
    dma_restart            => dma_restart,           
    dma_advance            => dma_advance,           
    dma_abort              => dma_abort,    
    fifo_flush             => fifo_flush,
    out_size_en            => payload_size_ctl_en,
    out_size               => payload_size_ctl,
    --------------------------------------------------------------------------------
    -- Status Inputs
    --------------------------------------------------------------------------------                     
    current_link_address   => current_link_address,  
    last_link_address      => last_link_address,     
    bytes_last_transferred => bytes_last_transferred,
    dma_aborting           => reader_abort_busy,          
    dma_waiting_for_adv    => dma_waiting_for_adv,   
    dma_waiting_for_sync   => dma_waiting_for_sync, 
    dma_paused             => dma_paused,            
    dma_active             => dma_active,            
     --------------------------------------------------------------------------------
    -- Interrupt Sources
    --------------------------------------------------------------------------------    
    all_rds_cmplt          => buffer_rd_complete,   
    abort_cmplt            => abort_cmplt,    
    waiting_adv            => dma_waiting_for_adv,    
    chain_end              => chain_end,      
    link_end               => link_end,
    chain_end_int          => chain_end_int,      
    link_end_int           => link_end_int,
    link_start             => link_start,
    eop_reached            => eop_reached,
    error_irq              => error_irq,
    xfr_error              => xfr_error
    ); 

irq_cdc_inst : xpm_cdc_pulse
   generic map (
      DEST_SYNC_FF => 3,   -- DECIMAL; range: 2-10
      INIT_SYNC_FF => 1,   -- DECIMAL; 0=disable simulation init values, 1=enable simulation init values
      REG_OUTPUT => 1,     -- DECIMAL; 0=disable registered output, 1=enable registered output
      RST_USED => 1,       -- DECIMAL; 0=no reset, 1=implement reset
      SIM_ASSERT_CHK => 0  -- DECIMAL; 0=disable simulation messages, 1=enable simulation messages
   )
   port map (
      dest_pulse => irqxx,
      dest_clk  => irq_clk, 
      dest_rst  => '0',     
      src_clk   => aclk,    
      src_pulse => irqx,   
      src_rst   => t1_s_axi_csr_areset    
   );

t1_s_axi_csr_areset <= not t1_s_axi_csr_aresetn;

process(irq_clk)   
begin
   if rising_edge(irq_clk) then
      irq <= irqxx;
   end if;
end process;
    
-------------------------------------------------------------------------------
-- DMA Abort 
-------------------------------------------------------------------------------

process(aclk)   
begin
   if rising_edge(aclk) then
      t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
      t1_rst_n <= aresetn;
      t1_reader_abort_busy <= reader_abort_busy;
      fe_reader_abort_busy <= t1_reader_abort_busy and not reader_abort_busy;
   end if;
end process;


end Behavioral;

