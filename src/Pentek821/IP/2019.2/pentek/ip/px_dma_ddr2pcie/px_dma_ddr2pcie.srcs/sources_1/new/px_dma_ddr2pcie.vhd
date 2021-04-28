----------------------------------------------------------------------------------
-- Pentek PCIe to DDR4 SDRAM Controller DMA
----------------------------------------------------------------------------------
-- px_dma_pcie2ddr.vhd
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
-- Revision 0.01 - File Created


-- Additional Comments: 
-----------------

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

-------------------------------------------------------------------------------
-- Main Entity
-------------------------------------------------------------------------------

entity px_dma_ddr2pcie is
generic(
   ddr4_requestor_id        : integer range 0 to 255 := 0; -- 0-255 (must be unique) 
   pcie_channel             : integer range 0 to 7 := 0 -- 0-7 (must be unique) 
);
port (
   aclk                     : in  std_logic;
   aresetn                  : in  std_logic;
   ----------------------------------------------------------------------------
   -- Control/Status Registers (AXI-LITE)
   ----------------------------------------------------------------------------
   -- Associated with aclk  
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
   
   irq                      : out std_logic; -- Interrupt out
   ----------------------------------------------------------------------------
   -- Output PCIe Requester Request Data Stream (AXI-Stream Stream Master)
   ----------------------------------------------------------------------------
   -- Associated with aclk
   -- Address aligned mode  
   m_axis_pcie_rq_tvalid    : out std_logic;
   m_axis_pcie_rq_tready    : in  std_logic;
   m_axis_pcie_rq_tdata     : out std_logic_vector(255 downto 0); -- not used for read requests
   m_axis_pcie_rq_tkeep     : out std_logic_vector(31 downto 0);    
   m_axis_pcie_rq_tuser     : out std_logic_vector(59 downto 0);
   m_axis_pcie_rq_tlast     : out std_logic; -- end of packet
   -----------------------------------------------------------------------------
   -- DDR4 Request Interface (AXI Stream)
   ----------------------------------------------------------------------------  
   axis_ddr_aclk         : in  std_logic;
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
   -----------------------------------------------------------------------------
   -- DDR4 Response Interface (AXI Stream)
   ----------------------------------------------------------------------------  
   -- tuser[127:0]   = Request Header
   -- tuser[31:0]    = Address (Address must be aligned to the request size boundaries)
   -- tuser[34:32]   = Future Address Expansion
   -- tuser[35]      = Read = 1, Write = 0
   -- tuser[39:36]   = Reserved
   -- tuser[119:40]  = Byte Masks
   -- tuser[255:128] = Upper 128-bits of RAM Data 
   s_axis_rsp_tvalid    : in  std_logic;
   s_axis_rsp_tlast     : in  std_logic;
   s_axis_rsp_tid       : in  std_logic_vector(7 downto 0);
   s_axis_rsp_tdata     : in  std_logic_vector(511 downto 0); 
   s_axis_rsp_tuser     : in  std_logic_vector(255 downto 0);
   ----------------------------------------------------------------------------
   -- PCI Express Misc. Control
   ------------------------------------------------------------------------------ 
   -- Associated with aclk
   -- [2:0] - max payload size
   -- [6:4] - max request size
   -- [7]   - byte swap
   s_axis_cntl_tdata        : in  std_logic_vector(7 downto 0);   
   s_axis_cntl_tvalid       : in  std_logic 
);
end px_dma_ddr2pcie;

architecture Behavioral of px_dma_ddr2pcie is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of aclk: SIGNAL is "xilinx.com:signal:clock:1.0 aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr:m_axis_pcie_rq:s_axis_cntl, ASSOCIATED_RESET aresetn:s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of axis_ddr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 axis_ddr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of axis_ddr_aclk: SIGNAL is "ASSOCIATED_BUSIF m_axis_rqst:s_axis_rsp";

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

constant pcie_chan_num  : std_logic_vector(2 downto 0)  := conv_std_logic_vector(pcie_channel, 3);

-------------------------------------------------------------------------------
-- Components
-------------------------------------------------------------------------------
-- DMA State Machine
component px_dma_ddr2pcie_dma_sm 
port (
  clk                         : in  std_logic;
  rst_n                       : in  std_logic;
  ----------------------------------------------------------------------------
  -- Buffer Read Requests to PCIe Reader Module
  ----------------------------------------------------------------------------
  buffer_wr_rqst_valid        : out std_logic; 
  buffer_wr_rqst_ready        : in  std_logic; 
  buffer_wr_rqst_data         : out std_logic_vector(135 downto 0);
  -- buffer_wr_rqst_data[63:0]    = Source Start Address -- PCIe Address -- Address must be on 4 byte address boundary
  -- buffer_wr_rqst_data[95:64]   = Destination Address -- DDR4 Address must be on 64 byte address boundry
  -- buffer_wr_rqst_data[127:96]  = Size in bytes
  -- buffer_wr_rqst_data[129:128] = PCIe AT 
  -- buffer_wr_rqst_data[135:130] = Reserved                                                               
  pcie_wr_complete            : in  std_logic; -- All writes to PCIe required for the DMA have completed.       
  ddr_rd_complete             : in  std_logic; -- All reads of DDR4 SDRAM required for the DMA have completed.                
  buffer_actual_bytes         : in  std_logic_vector(31 downto 0); -- Actual number of bytes sent
  buffer_actual_bytes_valid   : in  std_logic;
  reader_fifo_empty           : in  std_logic;  
  packetizer_fifo_empty       : in  std_logic;       
  ----------------------------------------------------------------------------
  -- Controls
  ----------------------------------------------------------------------------
  dma_restart                 : in  std_logic; -- DMA Reset
  dma_advance                 : in  std_logic; -- DMA Advance
  dma_abort                   : in  std_logic; -- DMA Abort
  abort_all_out               : out std_logic; -- Abort to associated logic
  abort_all_done              : in  std_logic; 
  source_addr                 : in  std_logic_vector(31 downto 0);   
  dest_addr                   : in  std_logic_vector(63 downto 0);
  length                      : in  std_logic_vector(31 downto 0);
  pcie_at                     : in  std_logic_vector(1 downto 0);
  ----------------------------------------------------------------------------
  -- Status
  ----------------------------------------------------------------------------
  abort_cmplt                 : out std_logic; -- Abort Complete Status
  dma_active                  : out std_logic; -- Active Status 
  dma_end                     : out std_logic; -- DMA End interrupt pulse (one clock cycle)
  bytes_last_transferred      : out std_logic_vector(31 downto 0)  -- Last Bytes Transferred
  );
end component;

-- DDR4 Reader
component px_dma_ddr2pcie_ddr_rdr
generic (
   ddr4_requestor_id : integer := 0
);
port (
    -----------------------------------------------------------------------------
    -- Command
    -----------------------------------------------------------------------------
    s_axis_ddr_cmd_tdata    : in  std_logic_vector(31 downto 0); -- DDR4 Address
    s_axis_ddr_cmd_tuser    : in  std_logic_vector(31 downto 0); -- Read Length (bytes)
    s_axis_ddr_cmd_tvalid   : in  std_logic;
    s_axis_ddr_cmd_tready   : out std_logic;
    s_axis_ddr_cmd_aclk     : in  std_logic;
    s_axis_ddr_cmd_aresetn  : in  std_logic;
    
    abort                   : in  std_logic;
    ddr_read_cmplt          : out std_logic;    
    -----------------------------------------------------------------------------
    -- DDR4 Request Interface (AXI Stream)
    ----------------------------------------------------------------------------  
    axis_ddr_aclk         : in  std_logic;
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
    -----------------------------------------------------------------------------
    -- DDR4 Response Interface (AXI Stream)
    ----------------------------------------------------------------------------  
    -- tuser[127:0]   = Request Header
    -- tuser[31:0]    = Address (Address must be aligned to the request size boundaries)
    -- tuser[34:32]   = Future Address Expansion
    -- tuser[35]      = Read = 1, Write = 0
    -- tuser[39:36]   = Reserved
    -- tuser[119:40]  = Byte Masks
    -- tuser[255:128] = Upper 128-bits of RAM Data 
    s_axis_rsp_tvalid    : in  std_logic;
    s_axis_rsp_tlast     : in  std_logic;
    s_axis_rsp_tid       : in  std_logic_vector(7 downto 0);
    s_axis_rsp_tdata     : in  std_logic_vector(511 downto 0); 
    s_axis_rsp_tuser     : in  std_logic_vector(255 downto 0);
    -----------------------------------------------------------------------------
    -- Output Data to PCIE Payload FIFO
    -----------------------------------------------------------------------------
    m_axis_tdata         : out std_logic_vector(511 downto 0);
    m_axis_tuser         : out std_logic_vector(7 downto 0); -- Valid Bytes
    m_axis_tlast         : out std_logic; 
    m_axis_tvalid        : out std_logic;
    pcie_afl             : in  std_logic;
        
    consec_access        : in  std_logic_vector(5 downto 0);
        
    ddr_rqst_fifo_afl    : out std_logic; 
    ddr_rqst_fifo_empty  : out std_logic
   );
end component px_dma_ddr2pcie_ddr_rdr;

-- 512 deep
-- afl at 384
COMPONENT px_dma_ddr2pcie_in_fifo
  PORT (
    m_aclk : IN STD_LOGIC;
    s_aclk : IN STD_LOGIC;
    s_aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
    s_axis_tlast : IN STD_LOGIC;
    s_axis_tuser : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
    m_axis_tlast : OUT STD_LOGIC;
    m_axis_tuser : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    axis_prog_full : OUT STD_LOGIC
  );
END COMPONENT;

component px_dma_ddr2pcie_reader
port (
    ----------------------------------------------------------------------------
    clk                          : in  std_logic;
    rst_n                        : in  std_logic;
    ----------------------------------------------------------------------------
    -- Buffer Read Requests from DMA
    ----------------------------------------------------------------------------
    buffer_rd_rqst_tvalid        : in  std_logic; 
    buffer_rd_rqst_tready        : out std_logic; 
    buffer_rd_rqst_tdata         : in  std_logic_vector(135 downto 0);    
    -- buffer_rd_rqst_data[63:0]    = Source Start Address -- PCIe Address -- Address must be on 4 byte address boundary
    -- buffer_rd_rqst_data[95:64]   = Destination Address -- DDR4 Address must be on 64 byte address boundry
    -- buffer_rd_rqst_data[127:96]  = Size in bytes
    -- buffer_rd_rqst_data[129:128] = PCIe AT 
    -- buffer_rd_rqst_data[135:130] = Reserved 
    buffer_rd_complete           : out std_logic;
    fifo_empty                   : out std_logic;
    ----------------------------------------------------------------------------
    -- DDR Read Requests
    ---------------------------------------------------------------------------- 
    ddr_rd_rqst_tvalid            : out std_logic; 
    ddr_rd_rqst_tready            : in  std_logic; 
    ddr_rd_rqst_tdata             : out std_logic_vector(135 downto 0);    
    -- ddr_rd_rqst_tdata[63:0]    = Source Start Address -- PCIe Address -- Address must be on 4 byte address boundary
    -- ddr_rd_rqst_tdata[95:64]   = Destination Address -- DDR4 Address must be on 64 byte address boundry
    -- ddr_rd_rqst_tdata[127:96]  = Size in bytes
    -- ddr_rd_rqst_tdata[129:128] = PCIe AT 
    -- ddr_rd_rqst_tdata[135:130] = Reserved 
    ----------------------------------------------------------------------------
    -- Input Data Stream (AXI-Stream Stream Slave)
    ----------------------------------------------------------------------------
    s_axis_data_in_tvalid        : in  std_logic;
    s_axis_data_in_tready        : out std_logic;
    -- Earliest byte in lower byte 
    s_axis_data_in_tdata         : in  std_logic_vector(511 downto 0);   
    -- tuser[7:0]   = valid bytes  
    s_axis_data_in_tuser         : in  std_logic_vector(7 downto 0);
    s_axis_data_in_tlast         : in  std_logic; -- end of packet
    ----------------------------------------------------------------------------
    -- Payload Data (AXI Stream)
    ----------------------------------------------------------------------------
    -- tuser
    -- [63:0]  = Destination Address
    -- [68:64] = first dw offset
    -- [69]    = SOP
    -- [71:70] = PCIe AT
    -- [75:72] = valid first bytes
    -- [79:76] = valid last bytes
    -- [87:80] = number of DWORDS in packet
    -- If Lite Mode, upper 8 tkeep bits are invalid as are the upper data bits [511:256]
    pcie_afl                     : in  std_logic;
    m_axis_payload_tvalid        : out std_logic;
    m_axis_payload_tlast         : out std_logic;
    m_axis_payload_tdata         : out std_logic_vector(511 downto 0);
    m_axis_payload_tuser         : out std_logic_vector(95 downto 0);   
    m_axis_payload_tkeep         : out std_logic_vector(15 downto 0);
    
    pcie_max_payload_size        : in  std_logic_vector(2 downto 0); -- From PCIe Core enumeration
    -- "000" = 128
    -- "001" = 256
    -- "010" = 512
    ----------------------------------------------------------------------------
    -- Controls
    ----------------------------------------------------------------------------
    abort                        : in  std_logic;
    abort_busy                   : out std_logic; 
    ----------------------------------------------------------------------------
    -- Status
    ----------------------------------------------------------------------------
    eop_reached                  : out std_logic;
    actual_bytes                 : out std_logic_vector(31 downto 0); -- Actual number of Bytes Transferred
    actual_bytes_valid           : out std_logic  -- Actual number of Bytes Transferred valid
 );
end component;

component px_dma_ddr2pcie_packetizer
generic(
    pcie_channel : std_logic_vector(2 downto 0)
);
port (
    clk                       : in  std_logic;
    rst_n                     : in  std_logic;
    
    abort                     : in  std_logic; 
    abort_busy                : out std_logic; 
    byte_swap                 : in  std_logic;
    fifo_empty                : out std_logic;
    ----------------------------------------------------------------------------
    -- Payload Data (AXI Stream)
    ----------------------------------------------------------------------------
    -- tuser
    -- [63:0]  = Destination Address
    -- [68:64] = first dw offset
    -- [69]    = SOP
    -- [71:70] = PCIe AT
    -- [75:72] = valid first bytes
    -- [79:76] = valid last bytes
    -- [87:80] = number of DWORDS in packet
    afl                       : out std_logic;
    s_axis_payload_tvalid     : in  std_logic;
    s_axis_payload_tlast      : in  std_logic;
    s_axis_payload_tdata      : in  std_logic_vector(511 downto 0);
    s_axis_payload_tuser      : in  std_logic_vector(95 downto 0);   
    s_axis_payload_tkeep      : in  std_logic_vector(15 downto 0);
    ----------------------------------------------------------------------------
    -- PCIe Packet Output Data (AXI Stream)
    ----------------------------------------------------------------------------    
    m_axis_rq_tvalid          : out std_logic;
    m_axis_rq_tready          : in  std_logic;    
    m_axis_rq_tlast           : out std_logic;
    m_axis_rq_tdata           : out std_logic_vector(255 downto 0);
    m_axis_rq_tuser           : out std_logic_vector(59 downto 0);   
    m_axis_rq_tkeep           : out std_logic_vector(7 downto 0);
    
    pkt_fifo_afl              : out std_logic;
    pkt_fifo_emp              : out std_logic    
    
);
end component;

-- Control/Status Registers
component px_dma_ddr2pcie_csr
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
-- Control Outputs
-------------------------------------------------------------------------------- 
    source_addr           : out std_logic_vector(31 downto 0);   
    dest_addr             : out std_logic_vector(63 downto 0);
    length                : out std_logic_vector(31 downto 0);
    dma_restart           : out std_logic;
    dma_advance           : out std_logic;
    dma_abort             : out std_logic;
    fifo_flush            : out std_logic;
    pcie_at               : out std_logic_vector(1 downto 0);
    consec_access         : out std_logic_vector(5 downto 0);
--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------                      
    bytes_last_transferred: in  std_logic_vector(31 downto 0); 
    dma_aborting          : in  std_logic;
    dma_active            : in  std_logic;
    ddr_rqst_fifo_afl     : in  std_logic;
    ddr_rqst_fifo_empty   : in  std_logic;
    pcie_rqst_fifo_afl    : in  std_logic;
    pcie_rqst_fifo_empty  : in  std_logic;
--------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------    
    all_pcie_wr_cmplt     : in  std_logic;
    all_pcie_rqsts_cmplt  : in  std_logic;
    ddr_rqsts_complete    : in  std_logic;
    ddr_rd_complete       : in  std_logic;  
    abort_cmplt           : in  std_logic;
    dma_end               : in  std_logic
);
end component;

-------------------------------------------------------------------------------
-- Types
-------------------------------------------------------------------------------
type abort_state_type is
(
ABORT_RESET_STATE,
START_READER_ABORT_STATE,
READER_ABORT_WAIT1_STATE,
READER_ABORT_WAIT2_STATE,
READER_ABORT_STATE,
START_WRITER_ABORT_STATE,
WRITER_ABORT_WAIT1_STATE,
WRITER_ABORT_WAIT2_STATE,
WRITER_ABORT_STATE
);

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal abort_cmplt                : std_logic := '0';
signal dma_advance                : std_logic := '0'; -- DMA Advance
signal dma_waiting_for_adv        : std_logic := '0'; -- Waiting For Advance Status
signal dma_active                 : std_logic := '0'; -- Active Status 
signal dma_paused                 : std_logic := '0'; -- Pause Status 
signal ddr_rd_complete            : std_logic := '0';   
signal t1_rst_n                   : std_logic := '0';
signal dma_restart                : std_logic := '0';
signal dma_abort_busy             : std_logic := '0';
signal dma_abort                  : std_logic := '0';
signal buffer_actual_bytes        : std_logic_vector(31 downto 0) := (others => '0');
signal buffer_actual_bytes_valid  : std_logic := '0';
signal bytes_last_transferred     : std_logic_vector(31 downto 0) := (others => '0');   -- Last Bytes Transferred
signal buffer_wr_rqst_valid       : std_logic := '0';
signal buffer_wr_rqst_ready       : std_logic := '0';
signal buffer_wr_rqst_data        : std_logic_vector(135 downto 0) := (others => '0'); 
signal ddr_rd_rqst_valid          : std_logic := '0';
signal ddr_rd_rqst_ready          : std_logic := '0';
signal ddr_rd_rqst_data           : std_logic_vector(135 downto 0) := (others => '0'); 
signal fifo_flush                 : std_logic := '0';         
signal abort_all_out              : std_logic := '0';                                                                                                                                
signal t1_reader_abort_busy       : std_logic := '0';
signal reader_abort_busy          : std_logic := '0';                                                       
signal fe_abort_busy              : std_logic := '0';
signal pcie_rqst_fifo_empty       : std_logic := '0';
signal pcie_rqst_fifo_afl         : std_logic := '0';
signal byte_swap                  : std_logic := '0';
signal int_m_axis_pcie_rq_tkeep   : std_logic_vector(7 downto 0) := (others => '0');
signal int_s_axis_pcie_rc_tkeep   : std_logic_vector(7 downto 0) := (others => '0');
signal source_addr                : std_logic_vector(31 downto 0):= (others => '0');
signal dest_addr                  : std_logic_vector(63 downto 0):= (others => '0');
signal length                     : std_logic_vector(31 downto 0):= (others => '0');
signal pcie_at                    : std_logic_vector(1 downto 0):= (others => '0');
signal ddr_wr_complete            : std_logic := '0';
signal dma_end                    : std_logic := '0';
signal consec_access              : std_logic_vector(5 downto 0):= (others => '0');
signal ddr_rqsts_complete         : std_logic := '0';
signal ddr_rqst_fifo_empty        : std_logic := '0';
signal ddr_rqst_fifo_afl          : std_logic := '0';
signal abort_state                : abort_state_type := ABORT_RESET_STATE;
signal reader_abort               : std_logic := '0';
signal t1_s_axi_csr_aresetn       : std_logic := '0';
signal pcie_max_payload_size      : std_logic_vector(2 downto 0):= (others => '0');
signal buffer_wr_complete         : std_logic := '0';
signal fifo_tvalid                : std_logic := '0';
signal fifo_tready                : std_logic := '0';
signal fifo_tdata                 : std_logic_vector(511 downto 0):= (others => '0');
signal fifo_tlast                 : std_logic := '0';
signal fifo_tuser                 : std_logic_vector(7 downto 0):= (others => '0');
signal fifo_out_tvalid            : std_logic := '0';
signal fifo_out_tready            : std_logic := '0';
signal fifo_out_tdata             : std_logic_vector(511 downto 0):= (others => '0');
signal fifo_out_tlast             : std_logic := '0';
signal fifo_out_tuser             : std_logic_vector(7 downto 0):= (others => '0');
signal in_fifo_afl                : std_logic := '0';
signal in_fifo_empty              : std_logic := '0';
signal reader_fifo_empty          : std_logic := '0';
signal packetizer_fifo_empty      : std_logic := '0';
signal payload_tvalid             : std_logic := '0';
signal payload_tlast              : std_logic := '0';
signal payload_tdata              : std_logic_vector(511 downto 0):= (others => '0');
signal payload_tuser              : std_logic_vector(95 downto 0):= (others => '0');   
signal payload_tkeep              : std_logic_vector(15 downto 0):= (others => '0');
signal pcie_afl                   : std_logic := '0';
signal fe_pcie_abort_busy         : std_logic := '0';
signal pcie_abort_ff              : std_logic := '0';
signal pcie_abortbusy_fe          : std_logic := '0';
signal t1_pcie_abort              : std_logic := '0';
signal pcie_abortbusy             : std_logic := '0';
signal t1_pcie_abortbusy          : std_logic := '0';
signal pcie_abort_re              : std_logic := '0';
signal pcie_abort_busy            : std_logic := '0';
signal t1_pcie_abort_busy         : std_logic := '0';
signal fe_reader_abort_busy       : std_logic := '0';
signal ddr_rqst_fifo_aflx         : std_logic := '0';
signal ddr_rqst_fifo_emptyx       : std_logic := '0';
signal fifo_flushx                : std_logic := '0';
signal t1_in_fifo_flush_n         : std_logic := '0';
signal t1_in_fifo_afl             : std_logic := '0';
signal ffx                        : std_logic := '0';
signal t1_dma_abort_busy          : std_logic := '0';
-------------------------------------------------------------------------------

begin

process(aclk)
begin
    if rising_edge(aclk) then
        t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
        if s_axis_cntl_tvalid = '1' then
            pcie_max_payload_size  <= s_axis_cntl_tdata(2 downto 0);
            byte_swap              <= s_axis_cntl_tdata(7);
        end if;
    end if;
end process;

process(axis_ddr_aclk)
begin
    if rising_edge(axis_ddr_aclk) then
       t1_in_fifo_afl     <= in_fifo_afl;
       t1_in_fifo_flush_n <= not fifo_flush;
    end if;
end process;


--sync flush to input clock
flush_cdc_sync_rst: xpm_cdc_sync_rst
generic map (
   -- Common module parameters
   DEST_SYNC_FF    => 3, -- integer; range: 2-10
   INIT            => 1, -- integer; 0=initialize synchronization registers to 0,
                         --          1=initialize synchronization registers to 1
   SIM_ASSERT_CHK  => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
)
port map (
   src_rst  => ffx,
   dest_clk => axis_ddr_aclk,
   dest_rst => fifo_flush
);

ffx <= fifo_flushx or not t1_rst_n;
-------------------------------------------------------------------------------
-- Linked List DMA State Machine
-------------------------------------------------------------------------------

dma_sm_inst: px_dma_ddr2pcie_dma_sm
port map (
   clk                         =>  aclk,
   rst_n                       =>  t1_rst_n,
   ----------------------------------------------------------------------------
   -- Buffer Write Requests to HMC Writer Module
   ----------------------------------------------------------------------------
   buffer_wr_rqst_valid        =>  buffer_wr_rqst_valid, 
   buffer_wr_rqst_ready        =>  buffer_wr_rqst_ready, 
   buffer_wr_rqst_data         =>  buffer_wr_rqst_data,  
  -- buffer_wr_rqst_data[63:0]    = Destination Start Address -- PCIe Address -- Address must be on 4 byte address boundary
   -- buffer_wr_rqst_data[95:64]   = Source  Address -- DDR4 Address must be on 64 byte address boundry
   -- buffer_wr_rqst_data[127:96]  = Size in bytes
   -- buffer_wr_rqst_data[129:128] = PCIe AT 
   -- buffer_wr_rqst_data[135:130] = Reserved                                                                            
   pcie_wr_complete            =>  buffer_wr_complete,   -- All writes to PCIe required for the DMA have completed.         
   ddr_rd_complete             =>  ddr_rd_complete,   -- All reads of DDR4 SDRAM required for the DMA have completed.  
   buffer_actual_bytes         =>  buffer_actual_bytes,  -- Actual number of bytes written
   buffer_actual_bytes_valid   =>  buffer_actual_bytes_valid, 
   reader_fifo_empty           =>  reader_fifo_empty,       
   packetizer_fifo_empty       =>  packetizer_fifo_empty,               
   ----------------------------------------------------------------------------
   -- Controls
   ----------------------------------------------------------------------------
   dma_restart                 => dma_restart,
   dma_advance                 => dma_advance,    
   dma_abort                   => dma_abort,  
   abort_all_out               => abort_all_out, -- Abort to associated logic
   abort_all_done              => fe_abort_busy,
   source_addr                 => source_addr, 
   dest_addr                   => dest_addr,   
   length                      => length,      
   pcie_at                     => pcie_at,     
   ----------------------------------------------------------------------------
   -- Status
   ----------------------------------------------------------------------------
   abort_cmplt                 => abort_cmplt,          
   dma_active                  => dma_active,       
   dma_end                     => dma_end,        
   bytes_last_transferred      => bytes_last_transferred  
);

-- buffer_wr_rqst_data[95:64]   = Source  Address -- DDR4 Address must be on 64 byte address boundry
-- buffer_wr_rqst_data[127:96]  = Size in bytes

ddr_rdr_inst: px_dma_ddr2pcie_ddr_rdr
generic map (
   ddr4_requestor_id => ddr4_requestor_id
)
port map (
    -----------------------------------------------------------------------------
    -- Command
    -----------------------------------------------------------------------------
    s_axis_ddr_cmd_tdata    => ddr_rd_rqst_data(95 downto 64), -- DDR4 Address
    s_axis_ddr_cmd_tuser    => ddr_rd_rqst_data(127 downto 96), -- Read Length (bytes)
    s_axis_ddr_cmd_tvalid   => ddr_rd_rqst_valid,
    s_axis_ddr_cmd_tready   => ddr_rd_rqst_ready,
    s_axis_ddr_cmd_aclk     => aclk,
    s_axis_ddr_cmd_aresetn  => t1_rst_n,    
    
    ddr_read_cmplt          => ddr_rd_complete,
    consec_access           => consec_access, 
    abort                   => abort_all_out,
    -----------------------------------------------------------------------------
    -- DDR4 Request Interface (AXI Stream)
    ----------------------------------------------------------------------------  
    axis_ddr_aclk      => axis_ddr_aclk,   
    -- tuser[127:0]   = Request Header
    -- tuser[31:0]    = Address (Address must be aligned to the request size boundaries)
    -- tuser[34:32]   = Future Address Expansion
    -- tuser[35]      = Read = 1, Write = 0
    -- tuser[39:36]   = Reserved
    -- tuser[119:40]  = Byte Masks
    -- tuser[255:128] = Upper 128-bits of RAM Data 
    m_axis_rqst_tvalid => m_axis_rqst_tvalid, 
    m_axis_rqst_tready => m_axis_rqst_tready, 
    m_axis_rqst_tlast  => m_axis_rqst_tlast,  
    m_axis_rqst_tid    => m_axis_rqst_tid,    
    m_axis_rqst_tdata  => m_axis_rqst_tdata,  
    m_axis_rqst_tuser  => m_axis_rqst_tuser,  
    -----------------------------------------------------------------------------
    -- DDR4 Response Interface (AXI Stream)
    ----------------------------------------------------------------------------  
    -- tuser[127:0]   = Request Header
    -- tuser[31:0]    = Address (Address must be aligned to the request size boundaries)
    -- tuser[34:32]   = Future Address Expansion
    -- tuser[35]      = Read = 1, Write = 0
    -- tuser[39:36]   = Reserved
    -- tuser[119:40]  = Byte Masks
    -- tuser[255:128] = Upper 128-bits of RAM Data 
    s_axis_rsp_tvalid  => s_axis_rsp_tvalid,  
    s_axis_rsp_tlast   => s_axis_rsp_tlast,   
    s_axis_rsp_tid     => s_axis_rsp_tid,     
    s_axis_rsp_tdata   => s_axis_rsp_tdata,   
    s_axis_rsp_tuser   => s_axis_rsp_tuser,   
    -----------------------------------------------------------------------------
    -- Output Data to PCIE Payload FIFO
    -----------------------------------------------------------------------------
    -- synchronout to axis_ddr_aclk
    m_axis_tdata       => fifo_tdata,  
    m_axis_tuser       => fifo_tuser, 
    m_axis_tlast       => fifo_tlast, 
    m_axis_tvalid      => fifo_tvalid, 
    pcie_afl           => t1_in_fifo_afl,
    
    ddr_rqst_fifo_afl    => ddr_rqst_fifo_afl,   
    ddr_rqst_fifo_empty  => ddr_rqst_fifo_empty
    );

--------------------------------------------------------------------------------
-- Input FIFO
--------------------------------------------------------------------------------

in_fifo_inst : px_dma_ddr2pcie_in_fifo
port map (
    m_aclk         => aclk,
    s_aclk         => axis_ddr_aclk,
    s_aresetn      => t1_in_fifo_flush_n,
    s_axis_tvalid  => fifo_tvalid,
    s_axis_tready  => open,
    s_axis_tdata   => fifo_tdata,
    s_axis_tlast   => fifo_tlast,
    s_axis_tuser   => fifo_tuser,
    m_axis_tvalid  => fifo_out_tvalid,
    m_axis_tready  => fifo_out_tready,
    m_axis_tdata   => fifo_out_tdata,
    m_axis_tlast   => fifo_out_tlast,
    m_axis_tuser   => fifo_out_tuser,
    axis_prog_full => in_fifo_afl
);    

in_fifo_empty <= not fifo_out_tvalid;

--------------------------------------------------------------------------------
-- FIFO to PCIe Payload State Machine
--------------------------------------------------------------------------------
reader_inst: px_dma_ddr2pcie_reader
port map (
    ----------------------------------------------------------------------------
    clk                          =>  aclk,
    rst_n                        =>  t1_rst_n,
    ----------------------------------------------------------------------------
    -- Buffer Read Requests from DMA
    ----------------------------------------------------------------------------
    buffer_rd_rqst_tvalid        => buffer_wr_rqst_valid,
    buffer_rd_rqst_tready        => buffer_wr_rqst_ready,
    buffer_rd_rqst_tdata         => buffer_wr_rqst_data, 
    -- buffer_rd_rqst_data[63:0]    = Source Start Address -- PCIe Address -- Address must be on 4 byte address boundary
    -- buffer_rd_rqst_data[95:64]   = Destination Address -- DDR4 Address must be on 64 byte address boundry
    -- buffer_rd_rqst_data[127:96]  = Size in bytes
    -- buffer_rd_rqst_data[129:128] = PCIe AT 
    -- buffer_rd_rqst_data[135:130] = Reserved 
    buffer_rd_complete           => buffer_wr_complete,
    fifo_empty                   => reader_fifo_empty,
    ----------------------------------------------------------------------------
    -- DDR Read Requests
    ---------------------------------------------------------------------------- 
    ddr_rd_rqst_tvalid           => ddr_rd_rqst_valid,      
    ddr_rd_rqst_tready           => ddr_rd_rqst_ready,      
    ddr_rd_rqst_tdata            => ddr_rd_rqst_data,          
    -- ddr_rd_rqst_tdata[63:0]    = Source Start Address -- PCIe Address -- Address must be on 4 byte address boundary
    -- ddr_rd_rqst_tdata[95:64]   = Destination Address -- DDR4 Address must be on 64 byte address boundry
    -- ddr_rd_rqst_tdata[127:96]  = Size in bytes
    -- ddr_rd_rqst_tdata[129:128] = PCIe AT 
    -- ddr_rd_rqst_tdata[135:130] = Reserved 
    ----------------------------------------------------------------------------
    -- Input Data Stream (AXI-Stream Stream Slave)
    ----------------------------------------------------------------------------
    s_axis_data_in_tvalid        => fifo_out_tvalid,
    s_axis_data_in_tready        => fifo_out_tready,
    -- Earliest byte in lower byte 
    s_axis_data_in_tdata         => fifo_out_tdata,
    -- tuser[7:0]   = valid bytes  
    s_axis_data_in_tuser         => fifo_out_tuser,
    s_axis_data_in_tlast         => fifo_out_tlast, 
    ----------------------------------------------------------------------------
    -- Payload Data (AXI Stream)
    ----------------------------------------------------------------------------
    -- tuser
    -- [63:0]  = Destination Address
    -- [68:64] = first dw offset
    -- [69]    = SOP
    -- [71:70] = PCIe AT
    -- [75:72] = valid first bytes
    -- [79:76] = valid last bytes
    -- [87:80] = number of DWORDS in packet
    pcie_afl                     => pcie_afl,           
    m_axis_payload_tvalid        => payload_tvalid,
    m_axis_payload_tlast         => payload_tlast, 
    m_axis_payload_tdata         => payload_tdata, 
    m_axis_payload_tuser         => payload_tuser,   
    m_axis_payload_tkeep         => payload_tkeep, 
    
    pcie_max_payload_size        => pcie_max_payload_size, -- From PCIe Core enumeration
    -- "000" = 128
    -- "001" = 256
    -- "010" = 512
    ----------------------------------------------------------------------------
    -- Controls
    ----------------------------------------------------------------------------
    -- associated with hmc_clk
    abort                        => abort_all_out,
    abort_busy                   => reader_abort_busy, 

    ----------------------------------------------------------------------------
    -- Status
    ----------------------------------------------------------------------------
    eop_reached                  => open,  
    actual_bytes                 => buffer_actual_bytes,      -- Actual number of Bytes Transferred
    actual_bytes_valid           => buffer_actual_bytes_valid -- Actual number of Bytes Transferred valid
 );
 
--------------------------------------------------------------------------------
-- PCIe Packet Generator
--------------------------------------------------------------------------------
packetizer_inst: px_dma_ddr2pcie_packetizer
generic map(
    pcie_channel => pcie_chan_num
)
port map (
    clk                       => aclk,       
    rst_n                     => t1_rst_n,       
    
    abort                     => pcie_abort_re,   
    abort_busy                => pcie_abortbusy,
    byte_swap                 => byte_swap,
    fifo_empty                => packetizer_fifo_empty,
    ----------------------------------------------------------------------------
    -- Payload Data (AXI Stream)
    ----------------------------------------------------------------------------
    afl                       => pcie_afl,
    s_axis_payload_tvalid     => payload_tvalid,
    s_axis_payload_tlast      => payload_tlast,    
    s_axis_payload_tdata      => payload_tdata, 
    s_axis_payload_tuser      => payload_tuser,  
    s_axis_payload_tkeep      => payload_tkeep,  
    ----------------------------------------------------------------------------
    -- PCIe Packet Output Data (AXI Stream)
    ----------------------------------------------------------------------------    
    m_axis_rq_tvalid          => m_axis_pcie_rq_tvalid, 
    m_axis_rq_tready          => m_axis_pcie_rq_tready, 
    m_axis_rq_tlast           => m_axis_pcie_rq_tlast,     
    m_axis_rq_tdata           => m_axis_pcie_rq_tdata,  
    m_axis_rq_tuser           => m_axis_pcie_rq_tuser,  
    m_axis_rq_tkeep           => int_m_axis_pcie_rq_tkeep,
    
    pkt_fifo_afl              => pcie_rqst_fifo_afl,  
    pkt_fifo_emp              => pcie_rqst_fifo_empty 
);  

m_axis_pcie_rq_tkeep(3 downto 0)   <= "0000" when (int_m_axis_pcie_rq_tkeep(0) = '0') else "1111";
m_axis_pcie_rq_tkeep(7 downto 4)   <= "0000" when (int_m_axis_pcie_rq_tkeep(1) = '0') else "1111";
m_axis_pcie_rq_tkeep(11 downto 8)  <= "0000" when (int_m_axis_pcie_rq_tkeep(2) = '0') else "1111";
m_axis_pcie_rq_tkeep(15 downto 12) <= "0000" when (int_m_axis_pcie_rq_tkeep(3) = '0') else "1111";
m_axis_pcie_rq_tkeep(19 downto 16) <= "0000" when (int_m_axis_pcie_rq_tkeep(4) = '0') else "1111";
m_axis_pcie_rq_tkeep(23 downto 20) <= "0000" when (int_m_axis_pcie_rq_tkeep(5) = '0') else "1111";
m_axis_pcie_rq_tkeep(27 downto 24) <= "0000" when (int_m_axis_pcie_rq_tkeep(6) = '0') else "1111";
m_axis_pcie_rq_tkeep(31 downto 28) <= "0000" when (int_m_axis_pcie_rq_tkeep(7) = '0') else "1111";


--------------------------------------------------------------------------------
-- Control/Status Registers
--------------------------------------------------------------------------------
csr_inst: px_dma_ddr2pcie_csr
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
    
    irq                    => irq,    -- interrupt
--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------      
    source_addr            => source_addr,  
    dest_addr              => dest_addr,
    length                 => length,
    dma_restart            => dma_restart,           
    dma_advance            => dma_advance,           
    dma_abort              => dma_abort,   
    fifo_flush             => fifo_flushx,
    pcie_at                => pcie_at,
    consec_access          => consec_access,
--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------       	              
    bytes_last_transferred => bytes_last_transferred,
    dma_aborting           => dma_abort_busy,                    
    dma_active             => dma_active,            
    ddr_rqst_fifo_afl      => ddr_rqst_fifo_aflx,
    ddr_rqst_fifo_empty    => ddr_rqst_fifo_emptyx,
    pcie_rqst_fifo_afl     => pcie_rqst_fifo_afl,         
    pcie_rqst_fifo_empty   => pcie_rqst_fifo_empty,           
 --------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------    
    all_pcie_wr_cmplt      => buffer_wr_complete,  
    all_pcie_rqsts_cmplt   => buffer_wr_complete,
    ddr_rqsts_complete     => ddr_rd_complete,--ddr_rqsts_complete,
    ddr_rd_complete        => ddr_rd_complete,       
    abort_cmplt            => abort_cmplt,        
    dma_end                => dma_end
);  

afl_cdc_inst: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 3, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => axis_ddr_aclk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => ddr_rqst_fifo_afl,
     dest_clk => aclk,
     dest_out => ddr_rqst_fifo_aflx
  );

emp_cdc_inst: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 3, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => axis_ddr_aclk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => ddr_rqst_fifo_empty,
     dest_clk => aclk,
     dest_out => ddr_rqst_fifo_emptyx
  );
  
-------------------------------------------------------------------------------
-- DMA Abort 
-------------------------------------------------------------------------------

process(aclk)   
begin
   if rising_edge(aclk) then
      t1_rst_n <= aresetn;
      if (t1_rst_n = '0') or (fe_pcie_abort_busy = '1') then
         dma_abort_busy    <= '0';
      elsif abort_all_out = '1' then
         dma_abort_busy    <= '1';
      end if;   
      t1_dma_abort_busy    <= dma_abort_busy;
      fe_abort_busy        <= t1_dma_abort_busy and not dma_abort_busy;
      t1_reader_abort_busy <= reader_abort_busy;
      t1_pcie_abort_busy   <= pcie_abort_busy;
      fe_reader_abort_busy <= t1_reader_abort_busy and not reader_abort_busy;
      fe_pcie_abort_busy   <= t1_pcie_abort_busy and not pcie_abort_busy;
   end if;
end process;


process(aclk)
begin
    if rising_edge(aclk) then
        if (t1_rst_n = '0') or (pcie_abortbusy_fe = '1') then
            pcie_abort_ff <= '0';
        elsif (abort_all_out = '1') then
            pcie_abort_ff <= '1';
        end if;
        t1_pcie_abort <= abort_all_out;
        t1_pcie_abortbusy <= pcie_abortbusy;    
    end if;
end process;

pcie_abort_re <= abort_all_out and not t1_pcie_abort;
pcie_abortbusy_fe <= t1_pcie_abortbusy and not pcie_abortbusy;

pcie_abort_busy <= pcie_abort_ff;


end Behavioral;
