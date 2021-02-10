----------------------------------------------------------------------------------
-- Pentek PCIe to AXI-S DMA
----------------------------------------------------------------------------------
-- px_dma_pcie2pd.vhd
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
-- Revision 1.0 - Fixed loop increment count

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

entity px_dma_pcie2pd is
generic(
   pcie_channel             : integer range 0 to 7 := 0 -- 0-7 (must be unique) 
);
port (
   aclk                     : in  std_logic;
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
   
   irq                      : out std_logic; -- Interrupt out
   ----------------------------------------------------------------------------
   -- Linked List Descriptor RAM (AXI-LITE) 
   ----------------------------------------------------------------------------
   -- associated with aclk
   s_axi_descr_awaddr       : in  std_logic_vector(15 downto 0);
   s_axi_descr_awprot       : in  std_logic_vector(2 downto 0);
   s_axi_descr_awvalid      : in  std_logic;
   s_axi_descr_awready      : out std_logic;
   s_axi_descr_wdata        : in  std_logic_vector(31 downto 0);
   s_axi_descr_wstrb        : in  std_logic_vector(3 downto 0);
   s_axi_descr_wvalid       : in  std_logic;
   s_axi_descr_wready       : out std_logic;
   s_axi_descr_bresp        : out std_logic_vector(1 downto 0);
   s_axi_descr_bvalid       : out std_logic;
   s_axi_descr_bready       : in  std_logic;
   s_axi_descr_araddr       : in  std_logic_vector(15 downto 0);
   s_axi_descr_arprot       : in  std_logic_vector(2 downto 0);
   s_axi_descr_arvalid      : in  std_logic;
   s_axi_descr_arready      : out std_logic;
   s_axi_descr_rdata        : out std_logic_vector(31 downto 0);
   s_axi_descr_rresp        : out std_logic_vector(1 downto 0);
   s_axi_descr_rvalid       : out std_logic;
   s_axi_descr_rready       : in  std_logic;   
   ----------------------------------------------------------------------------
   -- Output PCIe Requester Request Data Stream (AXI-Stream Stream Master)
   ----------------------------------------------------------------------------
   -- associated with aclk
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
   -- associated with aclk
   -- address aligned mode
   s_axis_pcie_rc_tvalid    : in  std_logic;
   s_axis_pcie_rc_tready    : out std_logic;
   s_axis_pcie_rc_tdata     : in  std_logic_vector(255 downto 0);
   s_axis_pcie_rc_tkeep     : in  std_logic_vector(31 downto 0);    
   s_axis_pcie_rc_tuser     : in  std_logic_vector(74 downto 0);
   s_axis_pcie_rc_tlast     : in  std_logic; -- end of packet
   -----------------------------------------------------------------------------
   -- Data Output (AXI4-Stream Master) 
   -----------------------------------------------------------------------------
   m_axis_rcv_buf_tvalid    : out std_logic;
   m_axis_rcv_buf_tlast     : out std_logic;
   m_axis_rcv_buf_tdata     : out std_logic_vector(255 downto 0);
   m_axis_rcv_buf_tkeep     : out std_logic_vector(31 downto 0);
   m_axis_rcv_buf_tready    : in  std_logic;
   ----------------------------------------------------------------------------
   -- PCI Express Misc. Control
   ------------------------------------------------------------------------------ 
   -- associated with aclk
   -- [2:0] - max payload size
   -- [6:4] - max request size
   -- [7]   - byte swap
   s_axis_cntl_tdata        : in  std_logic_vector(7 downto 0);   
   s_axis_cntl_tvalid       : in  std_logic 
);
end px_dma_pcie2pd;

architecture Behavioral of px_dma_pcie2pd is

-------------------------------------------------------------------------------
-- Components
-------------------------------------------------------------------------------
-- Dual Port RAM
-- Port A 8kx32
-- Port B 1kx256
-- latency = 2
-- Common Clock
component px_dma_pcie2pd_descr_ram
port (
    clka    : in std_logic;
    ena     : in std_logic;
    wea     : in std_logic_vector(0 downto 0);
    addra   : in std_logic_vector(12 downto 0);
    dina    : in std_logic_vector(31 downto 0);
    douta   : out std_logic_vector(31 downto 0);
    clkb    : in std_logic;
    web     : in std_logic_vector(0 downto 0);
    addrb   : in std_logic_vector(9 downto 0);
    dinb    : in std_logic_vector(255 downto 0);
    doutb   : out std_logic_vector(255 downto 0)
);
end component;


-- AXI4-Stream 2 to 1 Switch
-- 1 Byte wide
-- 11 user bits
COMPONENT px_dma_pcie2pd_axis2to1
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axis_tready : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axis_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    s_axis_tuser : IN STD_LOGIC_VECTOR(21 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axis_tready : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axis_tdata : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    m_axis_tuser : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
    s_req_suppress : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_decode_err : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
  );
END COMPONENT;

-- AXI-LITE BRAM Controller (16K DWORD address space)
COMPONENT px_axil_bram_ctlr_dppd
  PORT (
    s_axi_aclk : IN STD_LOGIC;
    s_axi_aresetn : IN STD_LOGIC;
    s_axi_awaddr : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
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
    s_axi_araddr : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
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
    bram_addr : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
    bram_wrdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    bram_rddata : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

-- DMA State Machine
component px_dma_pcie2pd_dma_sm is
port (
    clk                         : in  std_logic;
    rst_n                       : in  std_logic;
    ----------------------------------------------------------------------------
    -- Buffer Read Requests to PCIe Reader Module
    ----------------------------------------------------------------------------
    buffer_rd_rqst_valid        : out std_logic; 
    buffer_rd_rqst_ready        : in  std_logic; 
    buffer_rd_rqst_data         : out std_logic_vector(167 downto 0);
  -- buffer_rd_rqst_data[63:0]    = Source Start Address -- PCIe Address -- Address must be on 4 byte address boundary
    -- buffer_rd_rqst_data[127:64]  = Source Meta Address -- Meta Address must be on 16 byte address boundry
    -- buffer_rd_rqst_data[128]     = 0 = Use Descriptor Length 1 = Use Meta Data Length
    -- buffer_rd_rqst_data[130:129] = PCIe AT 
    -- buffer_rd_rqst_data[135:131] = Reserved 
    -- buffer_rd_rqst_data[167:136] = Size in bytes                                                                             
    buffer_rqst_complete        : in  std_logic; -- All requests required for a Buffer Read Request have been issued
    buffer_rd_complete          : in  std_logic; -- All reads of PCIe required for the Buffer Read Request have completed.                
    buffer_actual_bytes         : in  std_logic_vector(31 downto 0); -- Actual number of bytes sent
    buffer_actual_bytes_valid   : in  std_logic; 
    all_tags_returned           : in  std_logic;
    ----------------------------------------------------------------------------
    -- Descriptor RAM interface
    ----------------------------------------------------------------------------
    -- Associated with clk
    descriptor_ram_address      : out std_logic_vector(15 downto 0);           
    descriptor_ram_readdata     : in  std_logic_vector(255 downto 0);          
    ----------------------------------------------------------------------------
    -- Controls
    ----------------------------------------------------------------------------
    dma_restart                 : in  std_logic; -- DMA Reset
    dma_advance                 : in  std_logic; -- DMA Advance
    dma_abort                   : in  std_logic; -- DMA Abort
    abort_all_out               : out std_logic; -- Abort to associated logic
    abort_all_done              : in  std_logic; 
    start_link_descr_addr       : in  std_logic_vector(15 downto 0);
    ----------------------------------------------------------------------------
    -- Status
    ----------------------------------------------------------------------------
    abort_cmplt                 : out std_logic; -- Abort Complete Status
    waiting_for_adv             : out std_logic; -- Waiting For Advance Status
    dma_active                  : out std_logic; -- Active Status 
    dma_paused                  : out std_logic; -- Pause Status 
    link_end                    : out std_logic; -- Link End interrupt pulse (one clock cycle)
    chain_end                   : out std_logic; -- Link End interrupt pulse (one clock cycle)
    link_end_int                : out std_logic; -- Link End interrupt pulse (one clock cycle)
    chain_end_int               : out std_logic; -- Link End interrupt pulse (one clock cycle)
    link_start                  : out std_logic; -- Start of link pulse 
    
    current_link_address        : out std_logic_vector(31 downto 0);  -- Current Link
    last_link_address           : out std_logic_vector(31 downto 0);  -- Last Link
    bytes_last_transferred      : out std_logic_vector(31 downto 0)  -- Last Bytes Transferred
  );
end component;

component px_dma_pcie2pd_reader is
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
    buffer_rd_rqst_data     : in  std_logic_vector(167 downto 0);
    -- buffer_rd_rqst_data[63:0]    = Source Start Address -- PCIe Address -- Address must be on 4 byte address boundary
    -- buffer_rd_rqst_data[127:64]  = Source Meta Address -- Meta Address must be on 16 byte address boundry
    -- buffer_rd_rqst_data[128]     = 0 = Use Descriptor Length 1 = Use Meta Data Length
    -- buffer_rd_rqst_data[130:129] = PCIe AT 
    -- buffer_rd_rqst_data[135:131] = Reserved 
    -- buffer_rd_rqst_data[167:136] = Size in bytes  
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
    fifo_data_count          : out std_logic_vector(11 downto 0); -- number of 256-bit words
    data_fifo_empty          : out std_logic;
    data_fifo_full           : out std_logic;
    rqst_fifo_empty          : out std_logic;
    rqst_fifo_afl            : out std_logic;
    all_tags_returned        : out std_logic;
    actual_bytes             : out std_logic_vector(31 downto 0); -- Actual number of Bytes Transferred
    actual_bytes_valid       : out std_logic  -- Actual number of Bytes Transferred valid
 );
end component;

-- Control/Status Registers
component px_dma_pcie2pd_csr
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
    start_link_descr_addr : out std_logic_vector(15 downto 0);
    dma_restart           : out std_logic;
    dma_advance           : out std_logic;
    dma_abort             : out std_logic;
    fifo_flush            : out std_logic;
--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------       	           
    current_link_address  : in  std_logic_vector(15 downto 0);
    last_link_address     : in  std_logic_vector(15 downto 0);
    bytes_last_transferred: in  std_logic_vector(31 downto 0); 
    dma_aborting          : in  std_logic;
    dma_waiting_for_adv   : in  std_logic;
    dma_paused            : in  std_logic;
    dma_active            : in  std_logic;
    data_buf_fifo_full    : in  std_logic;
    data_buf_fifo_empty   : in  std_logic;
    data_buf_fifo_count   : in  std_logic_vector(11 downto 0); 
    pcie_rqst_fifo_afl    : in  std_logic;
    pcie_rqst_fifo_empty  : in  std_logic;
 --------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------    
    all_rd_cmplt          : in  std_logic;
    all_rqsts_cmplt       : in  std_logic;
    pcie_data_error       : in  std_logic;
    pcie_error_code       : in  std_logic_vector(3 downto 0);
    abort_cmplt           : in  std_logic;
    waiting_adv           : in  std_logic;
    chain_end             : in  std_logic;
    link_end              : in  std_logic;
    chain_end_int         : in  std_logic;
    link_end_int          : in  std_logic;
    link_start            : in  std_logic
    );
end component;


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
signal start_link_descr_addr      : std_logic_vector(15 downto 0) := (others => '0');
signal chain_end                  : std_logic := '0';
signal link_end                   : std_logic := '0';
signal current_link_address       : std_logic_vector(31 downto 0) := (others => '0');  -- Current Link
signal last_link_address          : std_logic_vector(31 downto 0) := (others => '0');  -- Last Link
signal bytes_last_transferred     : std_logic_vector(31 downto 0) := (others => '0');   -- Last Bytes Transferred
signal buffer_rd_rqst_valid       : std_logic := '0';
signal buffer_rd_rqst_ready       : std_logic := '0';
signal buffer_rd_rqst_data        : std_logic_vector(167 downto 0) := (others => '0'); 
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
signal fe_reader_abort_busy       : std_logic := '0';
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
signal data_buf_fifo_count        : std_logic_vector(11 downto 0) := (others => '0');
signal data_buf_fifo_empty        : std_logic := '0';
signal data_buf_fifo_full         : std_logic := '0';
signal t1_s_axi_csr_aresetn       : std_logic := '0';
--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

constant all_zeros : std_logic_vector(255 downto 0):=  (others => '0');

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of aclk: SIGNAL is "xilinx.com:signal:clock:1.0 aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr:s_axi_descr:m_axis_pcie_rq:s_axis_pcie_rc:m_axis_rcv_buf:s_axis_cntl, ASSOCIATED_RESET aresetn:s_axi_csr_aresetn";

-------------------------------------------------------------------------------

begin


process(aclk)
begin
    if rising_edge(aclk) then
        t1_s_axi_csr_aresetn   <= s_axi_csr_aresetn;
        if s_axis_cntl_tvalid = '1' then  
            max_pcie_rqst_size <= s_axis_cntl_tdata(6 downto 4);
            byte_swap          <= s_axis_cntl_tdata(7);  
        end if;
    end if;
end process;

--------------------------------------------------------------------------------
-- AXI-LITE BRAM Controller
--------------------------------------------------------------------------------
bram_ctrl_inst: px_axil_bram_ctlr_dppd
  port map (
    s_axi_aclk    => aclk,
    s_axi_aresetn => t1_s_axi_csr_aresetn,
    s_axi_awaddr  => s_axi_descr_awaddr(14 downto 0),    
    s_axi_awprot  => s_axi_descr_awprot,                 
    s_axi_awvalid => s_axi_descr_awvalid,                
    s_axi_awready => s_axi_descr_awready,                
    s_axi_wdata   => s_axi_descr_wdata,                  
    s_axi_wstrb   => s_axi_descr_wstrb,                  
    s_axi_wvalid  => s_axi_descr_wvalid,                 
    s_axi_wready  => s_axi_descr_wready,                 
    s_axi_bresp   => s_axi_descr_bresp,                  
    s_axi_bvalid  => s_axi_descr_bvalid,                 
    s_axi_bready  => s_axi_descr_bready,                 
    s_axi_araddr  => s_axi_descr_araddr(14 downto 0),    
    s_axi_arprot  => s_axi_descr_arprot,                 
    s_axi_arvalid => s_axi_descr_arvalid,                
    s_axi_arready => s_axi_descr_arready,                
    s_axi_rdata   => s_axi_descr_rdata,                  
    s_axi_rresp   => s_axi_descr_rresp,                  
    s_axi_rvalid  => s_axi_descr_rvalid,                   
    s_axi_rready  => s_axi_descr_rready,                   
    bram_rst      => open,
    bram_clk      => descr_bram_clk_a,
    bram_en       => open,
    bram_we       => descr_bram_wea,
    bram_addr     => descr_bram_addra,
    bram_wrdata   => descr_bram_wrdata_a,
    bram_rddata   => descr_bram_rddata_a
  );

-------------------------------------------------------------------------------
-- Linked List RAM
-------------------------------------------------------------------------------
-- Up to 512 Links
descr_ram_inst : px_dma_pcie2pd_descr_ram
  PORT MAP (
    clka    => aclk,
    ena     => '1',
    wea(0)  => descr_bram_wea(0),
    addra   => descr_bram_addra, -- DWORD addressing
    dina    => descr_bram_wrdata_a,
    douta   => descr_bram_rddata_a,
    clkb    => aclk,
    web     => "0",
    addrb   => descriptor_ram_address(14 downto 5),
    dinb    => all_zeros,
    doutb   => descriptor_ram_readdata -- 256 bits
  );
  

-------------------------------------------------------------------------------
-- Linked List DMA State Machine
-------------------------------------------------------------------------------
dma_sm_inst: px_dma_pcie2pd_dma_sm
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
   -- buffer_rd_rqst_data[127:64]  = Source Meta Address -- Meta Address must be on 16 byte address boundry
   -- buffer_rd_rqst_data[128]     = 0 = Use Descriptor Length 1 = Use Meta Data Length
   -- buffer_rd_rqst_data[130:129] = PCIe AT 
   -- buffer_rd_rqst_data[135:131] = Reserved 
   -- buffer_rd_rqst_data[167:136] = Size in bytes                                                                        
   buffer_rqst_complete        =>  all_rqsts_complete,   -- All requests required for a Buffer have been issued
   buffer_rd_complete          =>  all_rd_complete,      -- All data required for the Buffer Requests have been received.  
   buffer_actual_bytes         =>  buffer_actual_bytes,  -- Actual number of bytes written
   buffer_actual_bytes_valid   =>  buffer_actual_bytes_valid, 
   all_tags_returned           =>  all_tags_returned,
  ----------------------------------------------------------------------------
   -- Descriptor RAM interface
   ----------------------------------------------------------------------------
   -- associated with hmc clk
   descriptor_ram_address      => descriptor_ram_address,                     
   descriptor_ram_readdata     => descriptor_ram_readdata,                
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


--------------------------------------------------------------------------------
-- PCIe Read Request Generator
--------------------------------------------------------------------------------
reader_inst: px_dma_pcie2pd_reader
generic map(
pcie_channel  => pcie_channel      -- 0-7 PCIe Channel number (must be unique)
)
port map(
    ----------------------------------------------------------------------------
    clk                         => aclk,                
    rst_n                       => t1_rst_n,                
    ----------------------------------------------------------------------------
    -- Buffer Write Requests from DMA
    ----------------------------------------------------------------------------
    buffer_rd_rqst_valid        =>  buffer_rd_rqst_valid, 
    buffer_rd_rqst_ready        =>  buffer_rd_rqst_ready, 
    buffer_rd_rqst_data         =>  buffer_rd_rqst_data,  
    -- buffer_rd_rqst_data[63:0]    = Source Start Address -- PCIe Address -- Address must be on 4 byte address boundary
    -- buffer_rd_rqst_data[127:64]  = Source Meta Address -- Meta Address must be on 16 byte address boundry
    -- buffer_rd_rqst_data[128]     = 0 = Use Descriptor Length 1 = Use Meta Data Length
    -- buffer_rd_rqst_data[130:129] = PCIe AT 
    -- buffer_rd_rqst_data[135:131] = Reserved 
    -- buffer_rd_rqst_data[167:136] = Size in bytes   
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
    -- Read Response Output Interface (AXI-4 Stream) to HMC Write Requester
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
    m_axis_rcv_buf_tvalid       => m_axis_rcv_buf_tvalid,
    m_axis_rcv_buf_tlast        => m_axis_rcv_buf_tlast, 
    m_axis_rcv_buf_tdata        => m_axis_rcv_buf_tdata, 
    m_axis_rcv_buf_tkeep        => m_axis_rcv_buf_tkeep, 
    m_axis_rcv_buf_tready       => m_axis_rcv_buf_tready,                              
    ----------------------------------------------------------------------------
    -- Controls
    ----------------------------------------------------------------------------
    max_pcie_rqst_size          => max_pcie_rqst_size,
    byte_swap                   => byte_swap,
    -- associated with aclk
    abort                       => abort_all_out, 
    abort_busy                  => reader_abort_busy, 
    
    fifo_flush                  => fifo_flush, -- Flush for Read Request FIFO
    ----------------------------------------------------------------------------
    -- Status
    ----------------------------------------------------------------------------
    --data_err_out                 : out std_logic;
    error_out                   => pcie_data_error,
    error_code                  => pcie_error_code,
    fifo_data_count             => data_buf_fifo_count, 
    data_fifo_empty             => data_buf_fifo_empty,
    data_fifo_full              => data_buf_fifo_full, 
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
-- Control/Status Registers
--------------------------------------------------------------------------------
px_dma_pcie2pd_csr_inst: px_dma_pcie2pd_csr
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
    start_link_descr_addr  => start_link_descr_addr,   
    dma_restart            => dma_restart,           
    dma_advance            => dma_advance,           
    dma_abort              => dma_abort,    
    fifo_flush             => fifo_flush,
--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------       	           
    current_link_address   => current_link_address(15 downto 0),  
    last_link_address      => last_link_address(15 downto 0),     
    bytes_last_transferred => bytes_last_transferred,
    dma_aborting           => dma_abort_busy,          
    dma_waiting_for_adv    => dma_waiting_for_adv,   
    dma_paused             => dma_paused,            
    dma_active             => dma_active,            
    data_buf_fifo_full     => data_buf_fifo_full,         
    data_buf_fifo_empty    => data_buf_fifo_empty,
    data_buf_fifo_count    => data_buf_fifo_count,  
    pcie_rqst_fifo_afl     => pcie_rqst_fifo_afl,         
    pcie_rqst_fifo_empty   => pcie_rqst_fifo_empty,           
 --------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------    
    all_rd_cmplt           => all_rd_complete,  
    all_rqsts_cmplt        => all_rqsts_complete,
    pcie_data_error        => pcie_data_error,
    pcie_error_code        => pcie_error_code,    
    abort_cmplt            => abort_cmplt,    
    waiting_adv            => dma_waiting_for_adv,    
    chain_end              => chain_end,      
    link_end               => link_end,
    chain_end_int          => chain_end_int,      
    link_end_int           => link_end_int,
    link_start             => link_start
);  

 
            
-------------------------------------------------------------------------------
-- DMA Abort 
-------------------------------------------------------------------------------

process(aclk)   
begin
   if rising_edge(aclk) then
      t1_rst_n <= aresetn;
      if (t1_rst_n = '0') or (fe_reader_abort_busy = '1') then
         dma_abort_busy <= '0';
      elsif abort_all_out = '1' then
         dma_abort_busy <= '1';
      end if;   
      t1_reader_abort_busy <= reader_abort_busy;
      t2_reader_abort_busy <= t1_reader_abort_busy;
      t3_reader_abort_busy <= t2_reader_abort_busy;
      fe_reader_abort_busy <= t3_reader_abort_busy and not t2_reader_abort_busy;
   end if;
end process;



end Behavioral;
