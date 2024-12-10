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

-------------------------------------------------------------------------------
-- Main Entity
-------------------------------------------------------------------------------

entity px_dma_pcie2ddr is
generic(
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
   ----------------------------------------------------------------------------
   -- Input PCIe Requester Completion Data Stream (AXI-Stream Stream Slave)
   ----------------------------------------------------------------------------
   -- Associated with aclk
   -- address aligned mode
   s_axis_pcie_rc_tvalid    : in  std_logic;
   s_axis_pcie_rc_tready    : out std_logic;
   s_axis_pcie_rc_tdata     : in  std_logic_vector(255 downto 0);
   s_axis_pcie_rc_tkeep     : in  std_logic_vector(31 downto 0);    
   s_axis_pcie_rc_tuser     : in  std_logic_vector(74 downto 0);
   s_axis_pcie_rc_tlast     : in  std_logic; -- end of packet
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
end px_dma_pcie2ddr;

architecture Behavioral of px_dma_pcie2ddr is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of aclk: SIGNAL is "xilinx.com:signal:clock:1.0 aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr:m_axis_pcie_rq:s_axis_pcie_rc:s_axis_cntl, ASSOCIATED_RESET aresetn:s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of axis_ddr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 axis_ddr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of axis_ddr_aclk: SIGNAL is "ASSOCIATED_BUSIF m_axis_rqst";


-------------------------------------------------------------------------------
-- Components
-------------------------------------------------------------------------------
-- DMA State Machine
component px_dma_pcie2ddr_dma_sm 
port (
  clk                         : in  std_logic;
  rst_n                       : in  std_logic;
  ----------------------------------------------------------------------------
  -- Buffer Read Requests to PCIe Reader Module
  ----------------------------------------------------------------------------
  buffer_rd_rqst_valid        : out std_logic; 
  buffer_rd_rqst_ready        : in  std_logic; 
  buffer_rd_rqst_data         : out std_logic_vector(135 downto 0);
  -- buffer_rd_rqst_data[63:0]    = Source Start Address -- PCIe Address -- Address must be on 4 byte address boundary
  -- buffer_rd_rqst_data[95:64]   = Destination Address -- DDR4 Address must be on 64 byte address boundry
  -- buffer_rd_rqst_data[127:96]  = Size in bytes
  -- buffer_rd_rqst_data[129:128] = PCIe AT 
  -- buffer_rd_rqst_data[135:130] = Reserved                                                               
  pcie_rd_complete            : in  std_logic; -- All reads of PCIe required for the DMA have completed.       
  ddr_wr_complete             : in  std_logic; -- All writes to DDR4 SDRAM required for the DMA have completed.                
  buffer_actual_bytes         : in  std_logic_vector(31 downto 0); -- Actual number of bytes sent
  all_tags_returned           : in  std_logic;
  buffer_actual_bytes_valid   : in  std_logic;     
  ----------------------------------------------------------------------------
  -- Controls
  ----------------------------------------------------------------------------
  dma_restart                 : in  std_logic; -- DMA Reset
  dma_advance                 : in  std_logic; -- DMA Advance
  dma_abort                   : in  std_logic; -- DMA Abort
  abort_all_out               : out std_logic; -- Abort to associated logic
  abort_all_done              : in  std_logic; 
  source_addr                 : in  std_logic_vector(63 downto 0);   
  dest_addr                   : in  std_logic_vector(31 downto 0);
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

component px_dma_pcie2ddr_reader is
generic(
pcie_channel                : integer := 0 -- 0-7 Channel number (must be unique)
);
port (
    ----------------------------------------------------------------------------
    -- associated with s_axi_aclk
    clk                          : in  std_logic;
    rst_n                        : in  std_logic;
    ----------------------------------------------------------------------------
    -- Buffer Read Requests from DMA
    ----------------------------------------------------------------------------
   -- associated with s_axi_aclk
    buffer_rd_rqst_valid    : in  std_logic; 
    buffer_rd_rqst_ready    : out std_logic; 
    buffer_rd_rqst_data     : in  std_logic_vector(135 downto 0);
    -- buffer_rd_rqst_data[63:0]    = Source Start Address -- PCIe Address -- Address must be on 4 byte address boundary
    -- buffer_rd_rqst_data[95:64]   = Destination Address -- DDR4 Address must be on 64 byte address boundry
    -- buffer_rd_rqst_data[127:96]  = Size in bytes
    -- buffer_rd_rqst_data[129:128] = PCIe AT 
    -- buffer_rd_rqst_data[135:130] = Reserved    
    buffer_rd_complete      : out std_logic;
    buffer_rqst_complete    : out std_logic;
    ----------------------------------------------------------------------------
    -- Output PCIe Requester Request Data Stream (AXI-Stream Stream Master)
    ----------------------------------------------------------------------------
   -- associated with s_axi_aclk
    -- address aligned mode
    m_axis_pcie_rq_tvalid    : out std_logic;
    m_axis_pcie_rq_tready    : in  std_logic;
    m_axis_pcie_rq_tdata     : out std_logic_vector(255 downto 0); -- not used for read requests
    m_axis_pcie_rq_tkeep     : out std_logic_vector(7 downto 0);    
    m_axis_pcie_rq_tuser     : out std_logic_vector(59 downto 0);
    m_axis_pcie_rq_tlast     : out std_logic; -- end of packet
    ----------------------------------------------------------------------------
    -- Input PCIe Requester Completion Data Stream (AXI-Stream Stream Slave)
    ----------------------------------------------------------------------------
   -- associated with s_axi_aclk
    -- address aligned mode
    s_axis_pcie_rc_tvalid    : in  std_logic;
    s_axis_pcie_rc_tready    : out std_logic;
    s_axis_pcie_rc_tdata     : in  std_logic_vector(255 downto 0);
    s_axis_pcie_rc_tkeep     : in  std_logic_vector(7 downto 0);    
    s_axis_pcie_rc_tuser     : in  std_logic_vector(74 downto 0);
    s_axis_pcie_rc_tlast     : in  std_logic; -- end of packet
    ----------------------------------------------------------------------------
    -- Read Response Output Interface (AXI-4 Stream) 
    ----------------------------------------------------------------------------  
    m_axis_rcv_buf_tvalid    : out std_logic;
    m_axis_rcv_buf_tlast     : out std_logic;
    m_axis_rcv_buf_tdata     : out std_logic_vector(255 downto 0);
    m_axis_rcv_buf_tkeep     : out std_logic_vector(31 downto 0);
    m_axis_rcv_buf_tuser     : out std_logic_vector(31 downto 0);
    m_axis_rcv_buf_tready    : in  std_logic;
    --afl_in                   : in  std_logic;
    ----------------------------------------------------------------------------
    -- Controls
    ----------------------------------------------------------------------------
    max_pcie_rqst_size       : in std_logic_vector(2 downto 0); 
    byte_swap                : in  std_logic;
   -- associated with s_axi_aclk
    abort                    : in  std_logic;
    abort_busy               : out std_logic; 
    
    fifo_flush               : in  std_logic; -- Flush for FIFO
    ----------------------------------------------------------------------------
    -- Status
    ----------------------------------------------------------------------------
    -- associated with pcie_clk
    --data_err_out                 : out std_logic;
    error_out                : out std_logic;
    error_code               : out std_logic_vector(3 downto 0);
    rqst_fifo_empty          : out std_logic;
    rqst_fifo_afl            : out std_logic;
    all_tags_returned        : out std_logic;
    actual_bytes             : out std_logic_vector(31 downto 0); -- Actual number of Bytes Transferred
    actual_bytes_valid       : out std_logic  -- Actual number of Bytes Transferred valid
 );
end component;

component px_dma_pcie2ddr_writer
port (
    ----------------------------------------------------------------------------
    axis_aclk               : in  std_logic;
    axis_aresetn            : in  std_logic;
    ----------------------------------------------------------------------------
    -- Buffer Read Requests from DMA
    ----------------------------------------------------------------------------
    -- synchrobnous to axis_aclk
    buffer_rd_rqst_valid    : in  std_logic; 
    buffer_rd_rqst_ready    : out std_logic; 
    buffer_rd_rqst_data     : in  std_logic_vector(135 downto 0);
    -- buffer_rd_rqst_data[63:0]    = Source Start Address -- PCIe Address -- Address must be on 4 byte address boundary
    -- buffer_rd_rqst_data[95:64]   = Destination Address -- DDR4 Address must be on 64 byte address boundry
    -- buffer_rd_rqst_data[127:96]  = Size in bytes
    -- buffer_rd_rqst_data[129:128] = PCIe AT 
    -- buffer_rd_rqst_data[135:130] = Reserved    
    all_rqst_complete        : out std_logic; -- All Write Requests have been executed  
    all_wr_complete          : out std_logic; -- All Write Requests have been generated 
    ----------------------------------------------------------------------------
    -- Read Response Input Interface (AXI-4 Stream) into Write Requester
    ----------------------------------------------------------------------------
    -- synchrobnous to axis_aclk
    s_axis_rcv_buf_tvalid    : in  std_logic;
    s_axis_rcv_buf_tlast     : in  std_logic;
    s_axis_rcv_buf_tdata     : in  std_logic_vector(255 downto 0);
    s_axis_rcv_buf_tkeep     : in  std_logic_vector(31 downto 0);
    s_axis_rcv_buf_tuser     : in  std_logic_vector(31 downto 0);
    s_axis_rcv_buf_tready    : out std_logic;
    -----------------------------------------------------------------------------
    -- DDR4 Request Interface (AXI Stream)
    ----------------------------------------------------------------------------  
    axis_ddr_aclk         : in  std_logic;
    -- tuser[127:0]   = Request Header
    -- tuser[31:0]    = Address
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
    -- Controls
    ----------------------------------------------------------------------------
    abort                    : in  std_logic;
    abort_busy               : out std_logic; 
    conseq_access            : in  std_logic_vector(5 downto 0);
    fifo_flush               : in  std_logic; -- Flush for FIFOs
    ----------------------------------------------------------------------------
    -- Status
    ----------------------------------------------------------------------------
    rqst_fifo_empty          : out std_logic;
    rqst_fifo_afl            : out std_logic
 );
end component px_dma_pcie2ddr_writer;

-- Control/Status Registers
component px_dma_pcie2ddr_csr
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
    source_addr           : out std_logic_vector(63 downto 0);   
    dest_addr             : out std_logic_vector(31 downto 0);
    length                : out std_logic_vector(31 downto 0);
    dma_restart           : out std_logic;
    dma_advance           : out std_logic;
    dma_abort             : out std_logic;
    fifo_flush            : out std_logic;
    pcie_at               : out std_logic_vector(1 downto 0);
    conseq_access         : out std_logic_vector(5 downto 0);
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
    all_pcie_rd_cmplt     : in  std_logic;
    all_pcie_rqsts_cmplt  : in  std_logic;
    ddr_rqsts_complete    : in  std_logic;
    ddr_wr_complete       : in  std_logic;  
    pcie_data_error       : in  std_logic;
    pcie_error_code       : in  std_logic_vector(3 downto 0);
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
signal all_rqsts_complete         : std_logic := '0'; 
signal all_rd_complete            : std_logic := '0'; 
signal link_end_int               : std_logic := '0'; -- Link End interrupt pulse
signal chain_end_int              : std_logic := '0'; -- Chain End interrupt pulse
signal link_start                 : std_logic := '0';  
signal t1_rst_n                   : std_logic := '0';
signal dma_restart                : std_logic := '0';
signal dma_abort_busy             : std_logic := '0';
signal dma_abort                  : std_logic := '0';
signal buffer_actual_bytes        : std_logic_vector(31 downto 0) := (others => '0');
signal buffer_actual_bytes_valid  : std_logic := '0';
signal current_link_address       : std_logic_vector(31 downto 0) := (others => '0');  -- Current Link
signal last_link_address          : std_logic_vector(31 downto 0) := (others => '0');  -- Last Link
signal bytes_last_transferred     : std_logic_vector(31 downto 0) := (others => '0');   -- Last Bytes Transferred
signal buffer_rd_rqst_valid       : std_logic := '0';
signal buffer_rd_rqst_ready       : std_logic := '0';
signal buffer_rd_rqst_data        : std_logic_vector(135 downto 0) := (others => '0'); 
signal fifo_flush                 : std_logic := '0';
signal data_err_out               : std_logic := '0';
signal rqst_fifo_empty            : std_logic := '0';
signal rqst_fifo_afl              : std_logic := '0';  
signal descriptor_ram_address     : std_logic_vector(15 downto 0) := (others => '0');        
signal descriptor_ram_readdata    : std_logic_vector(255 downto 0) := (others => '0');          
signal abort_all_out              : std_logic := '0';                                                                                                                                
signal t1_reader_abort_busy       : std_logic := '0';
signal t2_reader_abort_busy       : std_logic := '0';
signal t3_reader_abort_busy       : std_logic := '0';
signal reader_abort_busy          : std_logic := '0';                                                       
signal fe_abort_busy              : std_logic := '0';
signal descr_bram_wea             : std_logic_vector(3 downto 0) := (others => '0');
signal descr_bram_addra           : std_logic_vector(12 downto 0) := (others => '0');
signal descr_bram_wrdata_a        : std_logic_vector(31 downto 0) := (others => '0');
signal descr_bram_rddata_a        : std_logic_vector(31 downto 0) := (others => '0');
signal t1_pcie_rst_n              : std_logic := '0';
signal descr_bram_clk_a           : std_logic := '0';
signal axi_descr_rvalid           : std_logic := '0';
signal axi_descr_rready           : std_logic := '0';
signal max_pcie_rqst_size         : std_logic_vector(2 downto 0) := "000";
signal pcie_data_error            : std_logic := '0';
signal pcie_error_code            : std_logic_vector(3 downto 0) := (others => '0');
signal pcie_rqst_fifo_empty       : std_logic := '0';
signal pcie_rqst_fifo_afl         : std_logic := '0';
signal all_tags_returned          : std_logic := '0';
signal byte_swap                  : std_logic := '0';
signal int_m_axis_pcie_rq_tkeep   : std_logic_vector(7 downto 0) := (others => '0');
signal int_s_axis_pcie_rc_tkeep   : std_logic_vector(7 downto 0) := (others => '0');
signal rcv_buf_tvalid             : std_logic := '0';
signal rcv_buf_tlast              : std_logic := '0';
signal rcv_buf_tdata              : std_logic_vector(255 downto 0):= (others => '0');
signal rcv_buf_tkeep              : std_logic_vector(31 downto 0):= (others => '0');
signal rcv_buf_tuser              : std_logic_vector(31 downto 0):= (others => '0');
signal rcv_buf_tready             : std_logic := '0';
signal source_addr                : std_logic_vector(63 downto 0):= (others => '0');
signal dest_addr                  : std_logic_vector(31 downto 0):= (others => '0');
signal length                     : std_logic_vector(31 downto 0):= (others => '0');
signal pcie_at                    : std_logic_vector(1 downto 0):= (others => '0');
signal ddr_wr_complete            : std_logic := '0';
signal dma_end                    : std_logic := '0';
signal conseq_access              : std_logic_vector(5 downto 0):= (others => '0');
signal ddr_rqsts_complete         : std_logic := '0';
signal ddr_rqst_fifo_empty        : std_logic := '0';
signal ddr_rqst_fifo_afl          : std_logic := '0';
signal abort_state                : abort_state_type := ABORT_RESET_STATE;
signal reader_abort               : std_logic := '0';
signal writer_abort               : std_logic := '0';
signal writer_abort_busy          : std_logic := '0';
signal t1_s_axi_csr_aresetn       : std_logic := '0';
-------------------------------------------------------------------------------

begin


process(aclk)
begin
    if rising_edge(aclk) then
        t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
        if s_axis_cntl_tvalid = '1' then  
            max_pcie_rqst_size <= s_axis_cntl_tdata(6 downto 4);
            byte_swap          <= s_axis_cntl_tdata(7);
        end if;
    end if;
end process;
 

-------------------------------------------------------------------------------
-- Linked List DMA State Machine
-------------------------------------------------------------------------------

dma_sm_inst: px_dma_pcie2ddr_dma_sm
port map (
   clk                         =>  aclk,
   rst_n                       =>  t1_rst_n,
   ----------------------------------------------------------------------------
   -- Buffer Write Requests to HMC Writer Module
   ----------------------------------------------------------------------------
   buffer_rd_rqst_valid        =>  buffer_rd_rqst_valid, 
   buffer_rd_rqst_ready        =>  buffer_rd_rqst_ready, 
   buffer_rd_rqst_data         =>  buffer_rd_rqst_data,  
  -- buffer_rd_rqst_data[63:0]    = Source Start Address -- PCIe Address -- Address must be on 4 byte address boundary
   -- buffer_rd_rqst_data[95:64]   = Destination Address -- DDR4 Address must be on 64 byte address boundry
   -- buffer_rd_rqst_data[127:96]  = Size in bytes
   -- buffer_rd_rqst_data[129:128] = PCIe AT 
   -- buffer_rd_rqst_data[135:130] = Reserved                                                                            
   pcie_rd_complete            =>  all_rd_complete,   -- All reads of PCIe required for the DMA have completed.         
   ddr_wr_complete             =>  ddr_wr_complete,   -- All writes to DDR4 SDRAM required for the DMA have completed.  
   buffer_actual_bytes         =>  buffer_actual_bytes,  -- Actual number of bytes written
   buffer_actual_bytes_valid   =>  buffer_actual_bytes_valid, 
   all_tags_returned           =>  all_tags_returned,             
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


--------------------------------------------------------------------------------
-- PCIe Read Request Generator
--------------------------------------------------------------------------------
reader_inst: px_dma_pcie2ddr_reader
generic map(
pcie_channel  => pcie_channel      -- 0-7 PCIe Channel number (must be unique)
)
port map(
    ----------------------------------------------------------------------------
    clk                         => aclk,                
    rst_n                       => t1_rst_n,                
    ----------------------------------------------------------------------------
    -- Buffer Read Requests from DMA
    ----------------------------------------------------------------------------
    buffer_rd_rqst_valid        =>  buffer_rd_rqst_valid, 
    buffer_rd_rqst_ready        =>  buffer_rd_rqst_ready, 
    buffer_rd_rqst_data         =>  buffer_rd_rqst_data,  
    -- buffer_rd_rqst_data[63:0]    = Source Start Address -- PCIe Address -- Address must be on 4 byte address boundary
    -- buffer_rd_rqst_data[95:64]   = Destination Address -- DDR4 Address must be on 64 byte address boundry
    -- buffer_rd_rqst_data[127:96]  = Size in bytes
    -- buffer_rd_rqst_data[129:128] = PCIe AT 
    -- buffer_rd_rqst_data[135:130] = Reserved          
    buffer_rqst_complete        =>  all_rqsts_complete,   
    buffer_rd_complete          =>  all_rd_complete,    
    ----------------------------------------------------------------------------
    -- PCIe Read Request Interface (AXI-4 Stream)
    ----------------------------------------------------------------------------
    -- associated with aclk
    -- address aligned mode
     
    m_axis_pcie_rq_tvalid       => m_axis_pcie_rq_tvalid, 
    m_axis_pcie_rq_tready       => m_axis_pcie_rq_tready,  
    m_axis_pcie_rq_tdata        => m_axis_pcie_rq_tdata,  
    m_axis_pcie_rq_tkeep        => int_m_axis_pcie_rq_tkeep,  
    m_axis_pcie_rq_tuser        => m_axis_pcie_rq_tuser,  
    m_axis_pcie_rq_tlast        => m_axis_pcie_rq_tlast,  
    ----------------------------------------------------------------------------
    -- Input PCIe Requester Completion Data Stream (AXI-Stream Stream Slave)
    ----------------------------------------------------------------------------
    -- associated with aclk
    -- address aligned mode
    s_axis_pcie_rc_tvalid       => s_axis_pcie_rc_tvalid,
    s_axis_pcie_rc_tready       => s_axis_pcie_rc_tready,
    s_axis_pcie_rc_tdata        => s_axis_pcie_rc_tdata, 
    s_axis_pcie_rc_tkeep        => int_s_axis_pcie_rc_tkeep, 
    s_axis_pcie_rc_tuser        => s_axis_pcie_rc_tuser, 
    s_axis_pcie_rc_tlast        => s_axis_pcie_rc_tlast, 
    ----------------------------------------------------------------------------
    -- Read Response Output Interface (AXI-4 Stream) to DDR4 Write Requester
    ----------------------------------------------------------------------------
    -- tuser[33:0]  = HMC byte address
    -- tuser[36:34] = HMC cube address
    -- tuser[39:37] = Size 000=16 byte -> 111 = 128 byte, steps of 16 bytes
    -- tuser[43:40] = First FLIT DW Enables 
    -- tuser[51:44] = Valid Data FLIT[7:0]   
    -- tuser[52]    = '1' = Write
    -- tuser[53]    = Posted (Writes) '1'= posted '0' = non-posted
    -- tuser[54]    = reserved
    -- tuser[63:55] = Tag -- Tag must be unique and not outstanding
    m_axis_rcv_buf_tvalid       => rcv_buf_tvalid,
    m_axis_rcv_buf_tlast        => rcv_buf_tlast, 
    m_axis_rcv_buf_tdata        => rcv_buf_tdata, 
    m_axis_rcv_buf_tuser        => rcv_buf_tuser,       
    m_axis_rcv_buf_tkeep        => rcv_buf_tkeep, 
    m_axis_rcv_buf_tready       => rcv_buf_tready,                              
    ----------------------------------------------------------------------------
    -- Controls
    ----------------------------------------------------------------------------
    max_pcie_rqst_size          => max_pcie_rqst_size,
    byte_swap                   => byte_swap,
    -- associated with aclk
    abort                       => reader_abort, 
    abort_busy                  => reader_abort_busy, 
    
    fifo_flush                  => fifo_flush, -- Flush for Read Request FIFO
    ----------------------------------------------------------------------------
    -- Status
    ----------------------------------------------------------------------------
    --data_err_out                 : out std_logic;
    error_out                   => pcie_data_error,
    error_code                  => pcie_error_code,
    rqst_fifo_empty             => pcie_rqst_fifo_empty,
    rqst_fifo_afl               => pcie_rqst_fifo_afl,
    all_tags_returned           => all_tags_returned,
    actual_bytes                => buffer_actual_bytes, -- Actual number of Bytes Transferred
    actual_bytes_valid          => buffer_actual_bytes_valid  -- Actual number of Bytes Transferred valid
);

m_axis_pcie_rq_tkeep(3 downto 0)   <= "0000" when (int_m_axis_pcie_rq_tkeep(0) = '0') else "1111";
m_axis_pcie_rq_tkeep(7 downto 4)   <= "0000" when (int_m_axis_pcie_rq_tkeep(1) = '0') else "1111";
m_axis_pcie_rq_tkeep(11 downto 8)  <= "0000" when (int_m_axis_pcie_rq_tkeep(2) = '0') else "1111";
m_axis_pcie_rq_tkeep(15 downto 12) <= "0000" when (int_m_axis_pcie_rq_tkeep(3) = '0') else "1111";
m_axis_pcie_rq_tkeep(19 downto 16) <= "0000" when (int_m_axis_pcie_rq_tkeep(4) = '0') else "1111";
m_axis_pcie_rq_tkeep(23 downto 20) <= "0000" when (int_m_axis_pcie_rq_tkeep(5) = '0') else "1111";
m_axis_pcie_rq_tkeep(27 downto 24) <= "0000" when (int_m_axis_pcie_rq_tkeep(6) = '0') else "1111";
m_axis_pcie_rq_tkeep(31 downto 28) <= "0000" when (int_m_axis_pcie_rq_tkeep(7) = '0') else "1111";

int_s_axis_pcie_rc_tkeep(0)        <= s_axis_pcie_rc_tkeep(0);
int_s_axis_pcie_rc_tkeep(1)        <= s_axis_pcie_rc_tkeep(4);
int_s_axis_pcie_rc_tkeep(2)        <= s_axis_pcie_rc_tkeep(8);
int_s_axis_pcie_rc_tkeep(3)        <= s_axis_pcie_rc_tkeep(12);
int_s_axis_pcie_rc_tkeep(4)        <= s_axis_pcie_rc_tkeep(16);
int_s_axis_pcie_rc_tkeep(5)        <= s_axis_pcie_rc_tkeep(20);
int_s_axis_pcie_rc_tkeep(6)        <= s_axis_pcie_rc_tkeep(24);
int_s_axis_pcie_rc_tkeep(7)        <= s_axis_pcie_rc_tkeep(28);

--------------------------------------------------------------------------------
-- Generate Write Rquests to the DDR4 SDRAM Conroller
--------------------------------------------------------------------------------
writer_inst: px_dma_pcie2ddr_writer
port map(
    ----------------------------------------------------------------------------
    axis_aclk               => aclk,     
    axis_aresetn            => t1_rst_n, 
    ----------------------------------------------------------------------------
    -- Buffer Read Requests from DMA
    ----------------------------------------------------------------------------
    -- synchrobnous to axis_aclk
    buffer_rd_rqst_valid    => buffer_rd_rqst_valid,       
    buffer_rd_rqst_ready    => open,       
    buffer_rd_rqst_data     => buffer_rd_rqst_data,        
    -- buffer_rd_rqst_data[63:0]    = Source Start Address -- PCIe Address -- Address must be on 4 byte address boundary
    -- buffer_rd_rqst_data[95:64]   = Destination Address -- DDR4 Address must be on 64 byte address boundry
    -- buffer_rd_rqst_data[127:96]  = Size in bytes
    -- buffer_rd_rqst_data[129:128] = PCIe AT 
    -- buffer_rd_rqst_data[135:130] = Reserved    
    all_rqst_complete       => ddr_rqsts_complete,
    all_wr_complete         => ddr_wr_complete,
    ----------------------------------------------------------------------------
    -- Read Response Input Interface (AXI-4 Stream) into Write Requester
    ----------------------------------------------------------------------------
    -- synchronous to axis_aclk
    s_axis_rcv_buf_tvalid   => rcv_buf_tvalid,     
    s_axis_rcv_buf_tlast    => rcv_buf_tlast,      
    s_axis_rcv_buf_tdata    => rcv_buf_tdata,      
    s_axis_rcv_buf_tkeep    => rcv_buf_tkeep, 
    s_axis_rcv_buf_tuser    => rcv_buf_tuser,       
    s_axis_rcv_buf_tready   => rcv_buf_tready,     
    -----------------------------------------------------------------------------
    -- DDR4 Request Interface (AXI Stream)
    ----------------------------------------------------------------------------  
    axis_ddr_aclk           => axis_ddr_aclk,
    -- tuser[127:0]   = Request Header
    -- tuser[31:0]    = Address
    -- tuser[34:32]   = Future Address Expansion
    -- tuser[35]      = Read = 1, Write = 0
    -- tuser[39:36]   = Reserved
    -- tuser[119:40]  = Byte Masks
    -- tuser[255:128] = Upper 128-bits of RAM Data 
    m_axis_rqst_tvalid      => m_axis_rqst_tvalid,    
    m_axis_rqst_tready      => m_axis_rqst_tready,    
    m_axis_rqst_tlast       => m_axis_rqst_tlast,     
    m_axis_rqst_tid         => m_axis_rqst_tid,       
    m_axis_rqst_tdata       => m_axis_rqst_tdata,     
    m_axis_rqst_tuser       => m_axis_rqst_tuser,     
    ----------------------------------------------------------------------------
    -- Controls
    ----------------------------------------------------------------------------
    abort                   => writer_abort,
    abort_busy              => writer_abort_busy, 
    conseq_access           => conseq_access,
    fifo_flush              => fifo_flush, -- Flush for Write Request FIFO
    ----------------------------------------------------------------------------
    -- Status
    ----------------------------------------------------------------------------
    rqst_fifo_empty         => ddr_rqst_fifo_empty,
    rqst_fifo_afl           => ddr_rqst_fifo_afl  
 );

--------------------------------------------------------------------------------
-- Control/Status Registers
--------------------------------------------------------------------------------
csr_inst: px_dma_pcie2ddr_csr
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
    fifo_flush             => fifo_flush,
    pcie_at                => pcie_at,
    conseq_access          => conseq_access,
--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------       	              
    bytes_last_transferred => bytes_last_transferred,
    dma_aborting           => dma_abort_busy,                    
    dma_active             => dma_active,            
    ddr_rqst_fifo_afl      => ddr_rqst_fifo_afl,
    ddr_rqst_fifo_empty    => ddr_rqst_fifo_empty,
    pcie_rqst_fifo_afl     => pcie_rqst_fifo_afl,         
    pcie_rqst_fifo_empty   => pcie_rqst_fifo_empty,           
 --------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------    
    all_pcie_rd_cmplt      => all_rd_complete,  
    all_pcie_rqsts_cmplt   => all_rqsts_complete,
    ddr_rqsts_complete     => ddr_rqsts_complete,
    ddr_wr_complete        => ddr_wr_complete,   
    pcie_data_error        => pcie_data_error,
    pcie_error_code        => pcie_error_code,    
    abort_cmplt            => abort_cmplt,        
    dma_end                => dma_end
);  

            
-------------------------------------------------------------------------------
-- DMA Abort 
-------------------------------------------------------------------------------

process(aclk)   
begin
   if rising_edge(aclk) then
      t1_rst_n <= aresetn;
      if (t1_rst_n = '0') then
         reader_abort   <= '0';
         writer_abort   <= '0';
         abort_state    <= ABORT_RESET_STATE; 
         fe_abort_busy  <= '0';
         dma_abort_busy <= '0';
      else
        case abort_state is 
            when ABORT_RESET_STATE =>
               if (abort_all_out = '1') then
                  abort_state    <= START_READER_ABORT_STATE;
                  reader_abort   <= '1';
                  dma_abort_busy <= '1';
               else
                  abort_state    <= ABORT_RESET_STATE; 
                  reader_abort   <= '0';
                  writer_abort   <= '0'; 
                  dma_abort_busy <= '0';
               end if; 
               fe_abort_busy <= '0';
            when START_READER_ABORT_STATE =>
               reader_abort  <= '0'; 
               abort_state   <= READER_ABORT_WAIT1_STATE;
            when READER_ABORT_WAIT1_STATE =>
               abort_state   <= READER_ABORT_WAIT2_STATE; 
            when READER_ABORT_WAIT2_STATE =>
               abort_state   <= READER_ABORT_STATE;   
            when READER_ABORT_STATE =>
                if (reader_abort_busy = '0') then
                  abort_state   <= START_WRITER_ABORT_STATE;
                  writer_abort  <= '1';  
                end if;
            when START_WRITER_ABORT_STATE =>
                writer_abort    <= '0'; 
                abort_state     <= WRITER_ABORT_WAIT1_STATE;
            when WRITER_ABORT_WAIT1_STATE =>
                abort_state     <= WRITER_ABORT_WAIT2_STATE;
            when WRITER_ABORT_WAIT2_STATE =>
                abort_state     <= WRITER_ABORT_STATE;               
            when WRITER_ABORT_STATE =>
                if (writer_abort_busy = '0') then
                   abort_state     <= ABORT_RESET_STATE;
                   dma_abort_busy  <= '0';
                   fe_abort_busy   <= '1';
                end if;
            when others => 
               abort_state     <= ABORT_RESET_STATE;
        end case;
      end if;  
   end if;
end process;



end Behavioral;
