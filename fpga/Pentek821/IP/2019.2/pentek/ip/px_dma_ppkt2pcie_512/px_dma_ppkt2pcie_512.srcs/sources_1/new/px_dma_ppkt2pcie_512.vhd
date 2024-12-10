----------------------------------------------------------------------------------
-- Pentek Data Stream to PCI Express DMA
----------------------------------------------------------------------------------
-- px_dma_ppkt2pcie_512.vhd
--
-- Target Device: Kintex UltraScale
--
-- Pentek Inc.
-- One Park Way, Upper Saddle River, NJ 07458
-- (201)818-5900
-- www.pentek.com
--
-- Copyright Pentek, Inc. 2019
--
-- Revision:
-- Revision 1.0 - File Created - derived from px_dma_ppkt2pcie.vhd
 
-- 
-- Additional Comments: 
-- Important: Unlike the px_dma_ppkt2pcie ip core, this wider data version requires DATA ALIGNED mode for PCIe core. 

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- (c) Copyright 2019 Pentek, Inc. All rights reserved.
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

entity px_dma_ppkt2pcie_512 is
generic(
has_fifo_full_led           : boolean := true
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
   -- Input Data Stream (AIX-Stream Stream Slave)
   ----------------------------------------------------------------------------
   s_axis_ppkt_aclk      : in  std_logic;
   s_axis_ppkt_aresetn   : in  std_logic; 
   s_axis_ppkt_tvalid    : in  std_logic;
   s_axis_ppkt_tready    : out std_logic;
   -- Earliest byte in lower byte 
   s_axis_ppkt_tdata     : in  std_logic_vector(511 downto 0);
   -- tuser[63:0]    = timestamp[63:0]  
   -- tuser[64]      = SOP   
   -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
   -- tuser[67]      = Data Type 0 = Real 1 = I/Q
   -- tuser[75:68]   = channel[7:0]
   -- tuser[79:76]   = user[3:0] These bits only valid only with tlast   
   s_axis_ppkt_tuser     : in  std_logic_vector(79 downto 0);
   s_axis_ppkt_tkeep     : in  std_logic_vector(31 downto 0); -- One per 16-bit word
   s_axis_ppkt_tlast     : in  std_logic; -- end of packet
   ----------------------------------------------------------------------------
   -- Output PCIe Packet Data Stream (AXI-Stream Stream Master)
   ----------------------------------------------------------------------------  
   m_axis_pcie_rq_tvalid    : out std_logic;
   m_axis_pcie_rq_tready    : in  std_logic;
   m_axis_pcie_rq_tdata     : out std_logic_vector(511 downto 0);
   m_axis_pcie_rq_tkeep     : out std_logic_vector(63 downto 0);    
   m_axis_pcie_rq_tuser     : out std_logic_vector(136 downto 0);
   m_axis_pcie_rq_tlast     : out std_logic; -- end of packet
   ----------------------------------------------------------------------------
   -- PCI Express Misc. Control
   ------------------------------------------------------------------------------ 
   -- associated with aclk
   -- [2:0] - max payload size
   -- [6:4] - max request size
   -- [7]   - byte swap
   s_axis_cntl_tdata        : in  std_logic_vector(7 downto 0);   
   s_axis_cntl_tvalid       : in  std_logic;
   -----------------------------------------------------------------------------
   -- Misc.
   -----------------------------------------------------------------------------
   -- associated with s_axis_ppkt_aclk     
   fifo_rst_out_n           : out  std_logic;           
   fifo_full_led            : out  std_logic 
);
end px_dma_ppkt2pcie_512;

architecture Behavioral of px_dma_ppkt2pcie_512 is

-------------------------------------------------------------------------------
-- Components
-------------------------------------------------------------------------------

-- AXIS FIFO
-- 512 wide, 512 deep
-- afl at 511
COMPONENT px_dma_ppkt2pcie_in_strm_fifo32k
  PORT (
    m_aclk : IN STD_LOGIC;
    s_aclk : IN STD_LOGIC;
    s_aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
    s_axis_tlast : IN STD_LOGIC;
    s_axis_tuser : IN STD_LOGIC_VECTOR(87 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
    m_axis_tlast : OUT STD_LOGIC;
    m_axis_tuser : OUT STD_LOGIC_VECTOR(87 DOWNTO 0);
    axis_wr_data_count : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    axis_rd_data_count : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    axis_prog_full : OUT STD_LOGIC
  );
END COMPONENT;

-- Dual Port RAM
-- Port A 8kx32
-- Port B 1kx256
-- latency = 2
component px_dma_ppkt2pcie_descr_ram
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

-- AXI-LITE BRAM Controller (16K DWORD address space)
-- AXI-LITE BRAM Controller (16K DWORD address space)
component px_axil_bram_ctlr_dsp
  port (
    s_axi_aclk    : in  std_logic;
    s_axi_aresetn : in  std_logic;
    s_axi_awaddr  : in  std_logic_vector(14 downto 0);
    s_axi_awprot  : in  std_logic_vector(2 downto 0);
    s_axi_awvalid : in  std_logic;
    s_axi_awready : out std_logic;
    s_axi_wdata   : in  std_logic_vector(31 downto 0);
    s_axi_wstrb   : in  std_logic_vector(3 downto 0);
    s_axi_wvalid  : in  std_logic;
    s_axi_wready  : out std_logic;
    s_axi_bresp   : out std_logic_vector(1 downto 0);
    s_axi_bvalid  : out std_logic;
    s_axi_bready  : in  std_logic;
    s_axi_araddr  : in  std_logic_vector(14 downto 0);
    s_axi_arprot  : in  std_logic_vector(2 downto 0);
    s_axi_arvalid : in  std_logic;
    s_axi_arready : out std_logic;
    s_axi_rdata   : out std_logic_vector(31 downto 0);
    s_axi_rresp   : out std_logic_vector(1 downto 0);
    s_axi_rvalid  : out std_logic;
    s_axi_rready  : in  std_logic;
    bram_rst      : out std_logic;
    bram_clk      : out std_logic;
    bram_en       : out std_logic;
    bram_we       : out std_logic_vector(3 downto 0);
    bram_addr     : out std_logic_vector(12 downto 0);
    bram_wrdata   : out std_logic_vector(31 downto 0);
    bram_rddata   : in  std_logic_vector(31 downto 0)
  );
end component;

-- DMA State Machine
component px_dma_ppkt2pcie_512dmasm is
port (
  clk                         : in  std_logic;
  rst_n                       : in  std_logic;
  ----------------------------------------------------------------------------
  -- Buffer Read Requests to HMC Reader Module
  ----------------------------------------------------------------------------
  buffer_rd_rqst_valid        : out std_logic; 
  buffer_rd_rqst_ready        : in  std_logic; 
  buffer_rd_rqst_data         : out std_logic_vector(167 downto 0);
  -- buffer_rd_rqst_data[63:0]    = Destination Start Address -- PCIe Address -- Address must be on 4 byte address boundary
  -- buffer_rd_rqst_data[127:64]  = Destination Meta Start Address  -- Address must be on 4 byte address boundary
  -- buffer_wr_rqst_data[159:128] = Size in bytes
  -- buffer_wr_rqst_data[160]     = Write Meta Data
  -- buffer_wr_rqst_data[161]     = reserved 
  -- buffer_wr_rqst_data[162]     = SOP Start 
  -- buffer_wr_rqst_data[163]     = Allow end on EOF      
  -- buffer_rd_rqst_data[165:164] = PCIe AT 
  -- buffer_wr_rqst_data[167:166] = reserved 
  buffer_rd_complete          : in  std_logic; -- All reads of FIFO required for the Buffer Read Request have completed.                
  buffer_actual_bytes         : in  std_logic_vector(31 downto 0); -- Actual number of bytes sent
  buffer_actual_bytes_valid   : in  std_logic; 
  reader_fifo_empty           : in  std_logic;
  packetizer_fifo_empty       : in  std_logic;
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
  dma_active                  : out std_logic; -- Active Status 
  dma_paused                  : out std_logic; -- Pause Status 
  waiting_for_adv             : out std_logic; -- Waiting For Advance Status
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

component px_dma_ppkt2pcie_512_reader
port (
    ----------------------------------------------------------------------------
    clk                          : in  std_logic;
    rst_n                        : in  std_logic;
    ----------------------------------------------------------------------------
    -- Buffer Read Requests from DMA
    ----------------------------------------------------------------------------
    buffer_rd_rqst_valid         : in  std_logic; 
    buffer_rd_rqst_ready         : out std_logic; 
    buffer_rd_rqst_data          : in  std_logic_vector(167 downto 0);
    -- buffer_rd_rqst_data[63:0]    = Destination Start Address -- PCIe Address -- Address must be on 4 byte address boundary
    -- buffer_rd_rqst_data[127:64]  = Destination Meta Start Address  -- Address must be on 4 byte address boundary
    -- buffer_wr_rqst_data[159:128] = Size in bytes
    -- buffer_wr_rqst_data[160]     = Write Meta Data
    -- buffer_wr_rqst_data[161]     = reserved 
    -- buffer_wr_rqst_data[162]     = SOP Start 
    -- buffer_wr_rqst_data[163]     = Allow end on EOF      
    -- buffer_rd_rqst_data[165:164] = PCIe AT 
    -- buffer_wr_rqst_data[167:166] = reserved 
    buffer_rd_complete           : out std_logic;
    fifo_empty                   : out std_logic;
    ----------------------------------------------------------------------------
    -- Input Data Stream (AXI-Stream Stream Slave)
    ----------------------------------------------------------------------------
    s_axis_data_in_tvalid        : in  std_logic;
    s_axis_data_in_tready        : out std_logic;
    -- Earliest byte in lower byte 
    s_axis_data_in_tdata         : in  std_logic_vector(511 downto 0);
    -- tuser[63:0]    = timestamp[63:0]  
    -- tuser[64]      = SOP   
    -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
    -- tuser[67]      = Data Type 0 = Real 1 = I/Q
    -- tuser[75:68]   = channel[7:0]
    -- tuser[79:76]   = user[3:0] 
    -- tuser[87:80]   = valid bytes  
    s_axis_data_in_tuser         : in  std_logic_vector(87 downto 0);
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
    -- associated with hmc_clk
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

-- Control/Status Registers
component px_dma_ppkt2pcie_512_csr
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    s_axi_csr_aclk            : in  std_logic;
    s_axi_csr_aresetn         : in  std_logic;
    s_axi_csr_awaddr          : in  std_logic_vector(5 downto 0);
    s_axi_csr_awprot          : in  std_logic_vector(2 downto 0);
    s_axi_csr_awvalid         : in  std_logic;
    s_axi_csr_awready         : out std_logic;
    s_axi_csr_wdata           : in  std_logic_vector(31 downto 0);
    s_axi_csr_wstrb           : in  std_logic_vector(3 downto 0);
    s_axi_csr_wvalid          : in  std_logic;
    s_axi_csr_wready          : out std_logic;
    s_axi_csr_bresp           : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid          : out std_logic;
    s_axi_csr_bready          : in  std_logic;
    s_axi_csr_araddr          : in  std_logic_vector(5 downto 0);
    s_axi_csr_arprot          : in  std_logic_vector(2 downto 0);
    s_axi_csr_arvalid         : in  std_logic;
    s_axi_csr_arready         : out std_logic;
    s_axi_csr_rdata           : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp           : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid          : out std_logic;
    s_axi_csr_rready          : in  std_logic;
    
    irq                   : out std_logic; -- interrupt
--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------    
    start_link_descr_addr : out std_logic_vector(15 downto 0);
    dma_restart           : out std_logic;
    dma_advance           : out std_logic;
    dma_abort             : out std_logic;
    fifo_flush            : out std_logic;
    in_fifo_flush_n       : out std_logic;
--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------       	           
    current_link_address  : in  std_logic_vector(15 downto 0);
    last_link_address     : in  std_logic_vector(15 downto 0);
    bytes_last_transferred: in  std_logic_vector(31 downto 0); 
    dma_aborting          : in  std_logic;
    dma_waiting_for_sync  : in  std_logic;
    dma_waiting_for_adv   : in  std_logic;
    dma_paused            : in  std_logic;
    dma_active            : in  std_logic;
    in_fifo_afl           : in  std_logic;
    in_fifo_empty         : in  std_logic;
    rd_data_count         : in  std_logic_vector(15 downto 0); 
 --------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------    
    all_rds_cmplt         : in  std_logic;
    abort_cmplt           : in  std_logic;
    waiting_adv           : in  std_logic;
    chain_end             : in  std_logic;
    link_end              : in  std_logic;
    chain_end_int         : in  std_logic;
    link_end_int          : in  std_logic;
    link_start            : in  std_logic;
    eop_reached           : in  std_logic 
    );
end component;

component px_dma_ppkt2pcie_512_packetizer
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
    m_axis_rq_tdata           : out std_logic_vector(511 downto 0);
    m_axis_rq_tuser           : out std_logic_vector(136 downto 0);   
    m_axis_rq_tkeep           : out std_logic_vector(15 downto 0)    
    
);
end component;

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTERRUPT";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of fifo_rst_out_n: SIGNAL is "xilinx.com:signal:reset:1.0 fifo_rst_out_n RST";
ATTRIBUTE X_INTERFACE_PARAMETER of fifo_rst_out_n: SIGNAL is "POLARITY ACTIVE_LOW";

ATTRIBUTE X_INTERFACE_INFO of aclk: SIGNAL is "xilinx.com:signal:clock:1.0 aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr:s_axi_descr:m_axis_pcie_rq:s_axis_cntl, ASSOCIATED_RESET s_axi_csr_aresetn:aresetn";
ATTRIBUTE X_INTERFACE_INFO of s_axis_ppkt_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axis_ppkt_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_ppkt_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_ppkt, ASSOCIATED_RESET s_axis_ppkt_aresetn:fifo_rst_out_n";

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
signal t1_hmc_rst_n               : std_logic := '0';
signal dma_restart                : std_logic := '0';
signal dma_abort_busy             : std_logic := '0';
signal dma_abort                  : std_logic := '0';
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
signal buffer_actual_bytes        : std_logic_vector(31 downto 0) := (others => '0');
signal descriptor_ram_address     : std_logic_vector(15 downto 0) := (others => '0');           
signal descriptor_ram_readdata    : std_logic_vector(255 downto 0) := (others => '0');          
signal abort_all_out              : std_logic := '0';                                                                                                                                
signal t1_reader_abort_busy       : std_logic := '0';
signal reader_abort_busy          : std_logic := '0';                            
signal t1_pcie_abort_busy         : std_logic := '0';
signal pcie_abort_busy            : std_logic := '0';                             
signal fe_reader_abort_busy       : std_logic := '0';
signal descr_bram_wea             : std_logic_vector(3 downto 0) := (others => '0');
signal descr_bram_addra           : std_logic_vector(12 downto 0) := (others => '0');
signal descr_bram_wrdata_a        : std_logic_vector(31 downto 0) := (others => '0');
signal descr_bram_rddata_a        : std_logic_vector(31 downto 0) := (others => '0');
signal fe_pcie_abort_busy         : std_logic := '0'; 
signal t1_rst_n                   : std_logic := '0';
signal rsp_pipe_afl               : std_logic := '0';
signal descr_bram_clk_a           : std_logic := '0';
signal reader_rd_rsp_tvalid       : std_logic := '0'; 
signal reader_rd_rsp_tdata        : std_logic_vector(511 downto 0) := (others => '0');
signal reader_rd_rsp_tuser        : std_logic_vector(71 downto 0) := (others => '0');
signal reader_rd_rsp_tkeep        : std_logic_vector(3 downto 0)  := (others => '0');
signal pkt_info_tdata             : std_logic_vector(31 downto 0) := (others => '0'); 
signal pkt_info_tuser             : std_logic_vector(63 downto 0) := (others => '0');   
signal pkt_info_tvalid            : std_logic := '0';
signal axi_descr_rvalid           : std_logic := '0';
signal axi_descr_rready           : std_logic := '0';
signal pcie_max_payload_size      : std_logic_vector(2 downto 0) := (others => '0');
signal mux_sync_ram_tvalid        : std_logic_vector(1 downto 0) := "00";
signal mux_sync_ram_tready        : std_logic_vector(1 downto 0) := "00";
signal mux_sync_ram_tdata         : std_logic_vector(15 downto 0) := (others => '0');  
signal mux_sync_ram_tuser         : std_logic_vector(21 downto 0) := (others => '0');  
signal sm_sync_ram_tvalid         : std_logic := '0';                                
signal sm_sync_ram_tready         : std_logic := '0';                                
signal sm_sync_ram_tdata          : std_logic_vector(7 downto 0) := (others => '0'); 
signal sm_sync_ram_tuser          : std_logic_vector(10 downto 0) := (others => '0');
signal sync_ram_raddr             : std_logic_vector(10 downto 0) := (others => '0');
signal sync_ram_rdata             : std_logic_vector(7 downto 0) := (others => '0');
signal buffer_actual_bytes_valid  : std_logic := '0';
signal byte_swap                  : std_logic := '0';
signal t1_s_axis_ppkt_aresetn     : std_logic := '0';
signal data_in_tvalid             : std_logic := '0';
signal data_in_tready             : std_logic := '0';
signal data_in_tdata              : std_logic_vector(511 downto 0) := (others => '0');
signal data_in_tuser              : std_logic_vector(87 downto 0) := (others => '0');
signal data_in_tuser_x            : std_logic_vector(87 downto 0) := (others => '0');
signal data_in_tlast              : std_logic := '0';
signal in_fifo_tvalid             : std_logic := '0';
signal in_fifo_tready             : std_logic := '0';
signal in_fifo_tdata              : std_logic_vector(511 downto 0) := (others => '0');
signal in_fifo_tlast              : std_logic := '0';
signal in_fifo_tuser              : std_logic_vector(87 downto 0) := (others => '0');
signal in_fifo_flush_n            : std_logic := '0';
signal t1_in_fifo_flush_n         : std_logic := '0';
signal in_fifo_afl                : std_logic := '0';
signal in_fifo_empty              : std_logic := '0';
signal payload_tvalid             : std_logic := '0';
signal payload_tlast              : std_logic := '0';
signal payload_tdata              : std_logic_vector(511 downto 0):= (others => '0');
signal payload_tuser              : std_logic_vector(95 downto 0) := (others => '0');   
signal payload_tkeep              : std_logic_vector(15 downto 0) := (others => '0');
signal pcie_afl                   : std_logic := '0';
signal pcie_abort_re              : std_logic := '0';
signal pcie_abortbusy             : std_logic := '0';
signal eop_reached                : std_logic := '0';
signal pcie_abort_ff              : std_logic := '0';
signal t1_pcie_abort              : std_logic := '0';
signal t1_pcie_abortbusy          : std_logic := '0';
signal pcie_abortbusy_fe          : std_logic := '0';
signal int_m_axis_pcie_rq_tkeep   : std_logic_vector(15 downto 0) := (others => '0');
signal axis_rd_data_count         : std_logic_vector(15 downto 0) := (others => '0');
signal reader_fifo_empty          : std_logic := '0';
signal packetizer_fifo_empty      : std_logic := '0';
signal in_fifo_flush_nx           : std_logic := '0';
signal in_fifo_aflx               : std_logic := '0';
signal t1_in_fifo_afl             : std_logic := '0';
signal t2_in_fifo_afl             : std_logic := '0';
signal in_fifo_afl_gated          : std_logic := '0';
signal t1_s_axi_csr_aresetn       : std_logic := '0';
signal valid_bytes                : integer := 0;
--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

constant all_zeros      : std_logic_vector(255 downto 0):=  (others => '0');

-------------------------------------------------------------------------------

begin

process(aclk)
begin
    if rising_edge(aclk) then
        if s_axis_cntl_tvalid = '1' then
            pcie_max_payload_size  <= s_axis_cntl_tdata(2 downto 0);
            byte_swap              <= s_axis_cntl_tdata(7);
        end if;
    end if;
end process;

process(s_axis_ppkt_aclk)
begin
    if rising_edge(s_axis_ppkt_aclk) then
       t1_in_fifo_afl     <= in_fifo_afl;
       t1_in_fifo_flush_n <= in_fifo_flush_n;
       t2_in_fifo_afl     <= t1_in_fifo_afl;
       fifo_full_led      <= t2_in_fifo_afl;
       if (t1_in_fifo_flush_n = '0') or ((t1_in_fifo_afl= '0') and (t2_in_fifo_afl= '0')) then
          in_fifo_afl_gated <= '0';  
       elsif (t1_in_fifo_afl= '1') and (t2_in_fifo_afl= '0') and (t1_in_fifo_flush_n = '1') then
          in_fifo_afl_gated <= '1';   
       end if;   
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

   src_rst  => in_fifo_flush_nx,
   dest_clk => s_axis_ppkt_aclk,
   dest_rst => in_fifo_flush_n
);


process(s_axis_ppkt_aclk)
begin
    if rising_edge(s_axis_ppkt_aclk) then
        t1_s_axis_ppkt_aresetn     <= not ((not s_axis_ppkt_aresetn) or (not in_fifo_flush_n));
        fifo_rst_out_n             <= in_fifo_flush_n;
    end if;
end process;    

--------------------------------------------------------------------------------
-- Input Width Conversion to 512 bits
--------------------------------------------------------------------------------
data_in_tdata               <= s_axis_ppkt_tdata; 
data_in_tuser(79 downto 0)  <= s_axis_ppkt_tuser(79 downto 0);
data_in_tvalid              <= s_axis_ppkt_tvalid; 
s_axis_ppkt_tready          <= data_in_tready;
data_in_tlast               <= s_axis_ppkt_tlast;
data_in_tuser(87 downto 80) <= (conv_std_logic_vector(valid_bytes, 8)) when (s_axis_ppkt_tlast = '1') else x"40";

process(s_axis_ppkt_tkeep)
begin
        if s_axis_ppkt_tkeep(31 downto 28) /= 0 then
            if s_axis_ppkt_tkeep(31) = '1' then
                valid_bytes <= 64;
            elsif s_axis_ppkt_tkeep(30) = '1' then
                valid_bytes <= 62;
            elsif s_axis_ppkt_tkeep(29) = '1' then
                valid_bytes <= 60;
            else
                valid_bytes <= 58;
            end if;
        elsif s_axis_ppkt_tkeep(27 downto 24) /= 0 then
            if s_axis_ppkt_tkeep(27) = '1' then
                valid_bytes <= 56;
            elsif s_axis_ppkt_tkeep(26) = '1' then
                valid_bytes <= 54;
            elsif s_axis_ppkt_tkeep(25) = '1' then
                valid_bytes <= 52;
            else
                valid_bytes <= 50;
            end if;
        elsif s_axis_ppkt_tkeep(23 downto 20) /= 0 then
            if s_axis_ppkt_tkeep(23) = '1' then
                valid_bytes <= 48;
            elsif s_axis_ppkt_tkeep(22) = '1' then
                valid_bytes <= 46;
            elsif s_axis_ppkt_tkeep(21) = '1' then
                valid_bytes <= 44;
            else
                valid_bytes <= 42;
            end if;
        elsif s_axis_ppkt_tkeep(19 downto 16) /= 0 then
            if s_axis_ppkt_tkeep(19) = '1' then
                valid_bytes <= 40;
            elsif s_axis_ppkt_tkeep(18) = '1' then
                valid_bytes <= 38;
            elsif s_axis_ppkt_tkeep(17) = '1' then
                valid_bytes <= 36;
            else
                valid_bytes <= 34;
            end if;
        elsif s_axis_ppkt_tkeep(15 downto 12) /= 0 then
            if s_axis_ppkt_tkeep(15) = '1' then
                valid_bytes <= 32;
            elsif s_axis_ppkt_tkeep(14) = '1' then
                valid_bytes <= 30;
            elsif s_axis_ppkt_tkeep(13) = '1' then
                valid_bytes <= 28;
            else
                valid_bytes <= 26;
            end if;
        elsif s_axis_ppkt_tkeep(11 downto 8) /= 0 then
            if s_axis_ppkt_tkeep(11) = '1' then
                valid_bytes <= 24;
            elsif s_axis_ppkt_tkeep(10) = '1' then
                valid_bytes <= 22;
            elsif s_axis_ppkt_tkeep(9) = '1' then
                valid_bytes <= 20;
            else
                valid_bytes <= 18;
            end if;    
        elsif s_axis_ppkt_tkeep(7 downto 4) /= 0 then
            if s_axis_ppkt_tkeep(7) = '1' then
                valid_bytes <= 16;
            elsif s_axis_ppkt_tkeep(6) = '1' then
                valid_bytes <= 14;
            elsif s_axis_ppkt_tkeep(5) = '1' then
                valid_bytes <= 12;
            else
                valid_bytes <= 10;
            end if;  
         else
            if s_axis_ppkt_tkeep(3) = '1' then
                valid_bytes <= 8;
            elsif s_axis_ppkt_tkeep(2) = '1' then
                valid_bytes <= 6;
            elsif s_axis_ppkt_tkeep(1) = '1' then
                valid_bytes <= 4;
            else
                valid_bytes <= 2;
            end if;
         end if;
end process;  

-- A later stage uses 87:80 (number of valid bytes) in calculations and decisions. This is usually only valid with tlast.
-- However, in order to help meet timing, it will be set to a value of 17 DWords during (tlast = '0').
data_in_tuser_x <= data_in_tuser when (data_in_tlast = '1') else ("01000100" & data_in_tuser(79 downto 0));
 
--------------------------------------------------------------------------------
-- Input Data Stream FIFO
--------------------------------------------------------------------------------

-----------------------------------------------------------


-- 32k Bytes
-- FIFO
-- 512 deep
in_strm_fifo_inst: px_dma_ppkt2pcie_in_strm_fifo32k
port map (
   m_aclk           => aclk,
   s_aclk           => s_axis_ppkt_aclk,
   s_aresetn        => in_fifo_flush_n,
   s_axis_tvalid    => data_in_tvalid,
   s_axis_tready    => data_in_tready,
   s_axis_tdata     => data_in_tdata,
   s_axis_tlast     => data_in_tlast,
   s_axis_tuser     => data_in_tuser_x,
   m_axis_tvalid    => in_fifo_tvalid,
   m_axis_tready    => in_fifo_tready,
   m_axis_tdata     => in_fifo_tdata,
   m_axis_tlast     => in_fifo_tlast,
   m_axis_tuser     => in_fifo_tuser,
   axis_wr_data_count => open,
   axis_rd_data_count => axis_rd_data_count(13 downto 4),
   axis_prog_full   => in_fifo_afl
);

axis_rd_data_count(15 downto 14) <= "00";


---------------------------------------------------

in_fifo_empty <= not in_fifo_tvalid;


--------------------------------------------------------------------------------
-- AXI-LITE BRAM Controller
--------------------------------------------------------------------------------
bram_ctrl_inst: px_axil_bram_ctlr_dsp
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
-- Up to 1024 Links
descr_ram_inst: px_dma_ppkt2pcie_descr_ram
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
dma_sm_inst: px_dma_ppkt2pcie_512dmasm
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
   -- buffer_wr_rqst_data[159:128] = Size in bytes
   -- buffer_wr_rqst_data[160]     = Write Meta Data
   -- buffer_wr_rqst_data[161]     = reserved 
   -- buffer_wr_rqst_data[162]     = SOP Start 
   -- buffer_wr_rqst_data[163]     = Allow end on EOF      
   -- buffer_rd_rqst_data[165:164] = PCIe AT 
   -- buffer_wr_rqst_data[167:166] = reserved 
   buffer_rd_complete          =>  buffer_rd_complete,   -- All reads of the HMC required for the Buffer Read Request have completed.  
   buffer_actual_bytes         =>  buffer_actual_bytes,  -- Actual number of bytes read
   buffer_actual_bytes_valid   =>  buffer_actual_bytes_valid, 
   reader_fifo_empty           => reader_fifo_empty,
   packetizer_fifo_empty       => packetizer_fifo_empty,
  ----------------------------------------------------------------------------
   -- Descriptor RAM interface
   ----------------------------------------------------------------------------
   -- associated with clk
   descriptor_ram_address      => descriptor_ram_address,                       
   descriptor_ram_readdata     => descriptor_ram_readdata,                
   ----------------------------------------------------------------------------
   -- Controls
   ----------------------------------------------------------------------------
   dma_restart                 => dma_restart,
   dma_advance                 => dma_advance,    
   dma_abort                   => dma_abort,  
   abort_all_out               => abort_all_out, -- Abort to associated logic
   abort_all_done              => fe_pcie_abort_busy,
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
-- FIFO to PCIe Payload State Machine
--------------------------------------------------------------------------------
reader_inst: px_dma_ppkt2pcie_512_reader
port map (
    ----------------------------------------------------------------------------
    clk                          =>  aclk,
    rst_n                        =>  t1_rst_n,
    ----------------------------------------------------------------------------
    -- Buffer Read Requests from DMA
    ----------------------------------------------------------------------------
    buffer_rd_rqst_valid         => buffer_rd_rqst_valid,
    buffer_rd_rqst_ready         => buffer_rd_rqst_ready,
    buffer_rd_rqst_data          => buffer_rd_rqst_data, 
    -- buffer_rd_rqst_data[63:0]    = Destination Start Address -- PCIe Address -- Address must be on 4 byte address boundary
    -- buffer_rd_rqst_data[127:64]  = Destination Meta Start Address  -- Address must be on 4 byte address boundary
    -- buffer_wr_rqst_data[159:128] = Size in bytes
    -- buffer_wr_rqst_data[160]     = Write Meta Data
    -- buffer_wr_rqst_data[161]     = reserved 
    -- buffer_wr_rqst_data[162]     = SOP Start 
    -- buffer_wr_rqst_data[163]     = Allow end on EOF      
    -- buffer_rd_rqst_data[165:164] = PCIe AT 
    -- buffer_wr_rqst_data[167:166] = reserved 
    buffer_rd_complete           => buffer_rd_complete,
    fifo_empty                   => reader_fifo_empty,
    ----------------------------------------------------------------------------
    -- Input Data Stream (AXI-Stream Stream Slave)
    ----------------------------------------------------------------------------
    s_axis_data_in_tvalid        => in_fifo_tvalid,
    s_axis_data_in_tready        => in_fifo_tready,
    -- Earliest byte in lower byte 
    s_axis_data_in_tdata         => in_fifo_tdata,
    -- tuser[63:0]    = timestamp[63:0]  
    -- tuser[64]      = SOP   
    -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
    -- tuser[67]      = Data Type 0 = Real 1 = I/Q
    -- tuser[75:68]   = channel[7:0]
    -- tuser[79:76]   = user[3:0] 
    -- tuser[87:80]   = valid bytes  
    s_axis_data_in_tuser         => in_fifo_tuser,
    s_axis_data_in_tlast         => in_fifo_tlast, 
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
    eop_reached                  => eop_reached,  
    actual_bytes                 => buffer_actual_bytes,      -- Actual number of Bytes Transferred
    actual_bytes_valid           => buffer_actual_bytes_valid -- Actual number of Bytes Transferred valid
 );

--------------------------------------------------------------------------------
-- PCIe Packet Generator
--------------------------------------------------------------------------------
packetizer_inst: px_dma_ppkt2pcie_512_packetizer
generic map(
    pcie_channel => "000"
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
    m_axis_rq_tkeep           => int_m_axis_pcie_rq_tkeep   
);  

m_axis_pcie_rq_tkeep(3 downto 0)   <= "0000" when (int_m_axis_pcie_rq_tkeep(0) = '0')  else "1111";
m_axis_pcie_rq_tkeep(7 downto 4)   <= "0000" when (int_m_axis_pcie_rq_tkeep(1) = '0')  else "1111";
m_axis_pcie_rq_tkeep(11 downto 8)  <= "0000" when (int_m_axis_pcie_rq_tkeep(2) = '0')  else "1111";
m_axis_pcie_rq_tkeep(15 downto 12) <= "0000" when (int_m_axis_pcie_rq_tkeep(3) = '0')  else "1111";
m_axis_pcie_rq_tkeep(19 downto 16) <= "0000" when (int_m_axis_pcie_rq_tkeep(4) = '0')  else "1111";
m_axis_pcie_rq_tkeep(23 downto 20) <= "0000" when (int_m_axis_pcie_rq_tkeep(5) = '0')  else "1111";
m_axis_pcie_rq_tkeep(27 downto 24) <= "0000" when (int_m_axis_pcie_rq_tkeep(6) = '0')  else "1111";
m_axis_pcie_rq_tkeep(31 downto 28) <= "0000" when (int_m_axis_pcie_rq_tkeep(7) = '0')  else "1111";
m_axis_pcie_rq_tkeep(35 downto 32) <= "0000" when (int_m_axis_pcie_rq_tkeep(8) = '0')  else "1111";
m_axis_pcie_rq_tkeep(39 downto 36) <= "0000" when (int_m_axis_pcie_rq_tkeep(9) = '0')  else "1111";
m_axis_pcie_rq_tkeep(43 downto 40) <= "0000" when (int_m_axis_pcie_rq_tkeep(10) = '0') else "1111";
m_axis_pcie_rq_tkeep(47 downto 44) <= "0000" when (int_m_axis_pcie_rq_tkeep(11) = '0') else "1111";
m_axis_pcie_rq_tkeep(51 downto 48) <= "0000" when (int_m_axis_pcie_rq_tkeep(12) = '0') else "1111";
m_axis_pcie_rq_tkeep(55 downto 52) <= "0000" when (int_m_axis_pcie_rq_tkeep(13) = '0') else "1111";
m_axis_pcie_rq_tkeep(59 downto 56) <= "0000" when (int_m_axis_pcie_rq_tkeep(14) = '0') else "1111";
m_axis_pcie_rq_tkeep(63 downto 60) <= "0000" when (int_m_axis_pcie_rq_tkeep(15) = '0') else "1111";

--------------------------------------------------------------------------------
-- Control/Status Registers
--------------------------------------------------------------------------------
csr_inst: px_dma_ppkt2pcie_512_csr
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
    in_fifo_flush_n        => in_fifo_flush_nx,
--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------       	           
    current_link_address   => current_link_address(15 downto 0),  
    last_link_address      => last_link_address(15 downto 0),     
    bytes_last_transferred => bytes_last_transferred,
    dma_aborting           => dma_abort_busy,          
    dma_waiting_for_adv    => dma_waiting_for_adv,   
    dma_waiting_for_sync   => dma_waiting_for_sync, 
    dma_paused             => dma_paused,            
    dma_active             => dma_active,            
    in_fifo_afl            => in_fifo_aflx,   
    in_fifo_empty          => in_fifo_empty,   
    rd_data_count          => axis_rd_data_count,
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
    eop_reached            => eop_reached
);  

-- sync afl to aclk
afl_cdc_inst: xpm_cdc_single
generic map (
   DEST_SYNC_FF   => 3, -- integer; range: 2-10
   SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
   SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
)
port map (
   src_clk  => s_axis_ppkt_aclk,  -- optional; required when SRC_INPUT_REG = 1
   src_in   => in_fifo_afl_gated,
   dest_clk => aclk,
   dest_out => in_fifo_aflx
);

           
-------------------------------------------------------------------------------
-- DMA Abort 
-------------------------------------------------------------------------------

process(aclk)   
begin
   if rising_edge(aclk) then
      t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
      t1_rst_n <= aresetn;
      if (t1_rst_n = '0') or (fe_pcie_abort_busy = '1') then
         dma_abort_busy <= '0';
      elsif abort_all_out = '1' then
         dma_abort_busy <= '1';
      end if;   
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
