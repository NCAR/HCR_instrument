-------------------------------------------------------------------------------
-- PCIe Reader
-------------------------------------------------------------------------------
-- px_dma_pcie2pd_reader.vhd
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
--  

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

entity px_dma_pcie2pd_reader is
generic(
pcie_channel                : integer := 0 -- 0-7 Channel number (must be unique)
);
port (
    ----------------------------------------------------------------------------
    clk                          : in  std_logic;
    rst_n                        : in  std_logic;
    ----------------------------------------------------------------------------
    -- Buffer Read Requests from DMA
    ----------------------------------------------------------------------------
    buffer_rd_rqst_valid    : in  std_logic; 
    buffer_rd_rqst_ready    : out std_logic; 
    buffer_rd_rqst_data     : in  std_logic_vector(167 downto 0);
    -- buffer_rd_rqst_data[63:0]    = Source Start Address -- HMC Address (only 34 bits used in this case) -- Address must be on 4 byte address boundary
    -- buffer_rd_rqst_data[127:64]  = Source Meta Address  -- (only 34 bits used in this case) -- Meta Address must be on 16 byte address boundry
    -- buffer_rd_rqst_data[128]     = 0 = Use Descriptor Length 1 = Use Meta Data Length
    -- buffer_rd_rqst_data[130:129] = PCIe AT 
    -- buffer_rd_rqst_data[135:131] = Reserved 
    -- buffer_rd_rqst_data[167:136] = Size in bytes  
    buffer_rd_complete      : out std_logic;
    buffer_rqst_complete    : out std_logic;
    ----------------------------------------------------------------------------
    -- Output PCIe Requester Request Data Stream (AXI-Stream Stream Master)
    ----------------------------------------------------------------------------
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
    -- address aligned mode
    s_axis_pcie_rc_tvalid    : in  std_logic;
    s_axis_pcie_rc_tready    : out std_logic;
    s_axis_pcie_rc_tdata     : in  std_logic_vector(255 downto 0);
    s_axis_pcie_rc_tkeep     : in  std_logic_vector(7 downto 0);    
    s_axis_pcie_rc_tuser     : in  std_logic_vector(74 downto 0);
    s_axis_pcie_rc_tlast     : in  std_logic; -- end of packet
    ----------------------------------------------------------------------------
    -- Read Response Output Interface (AXI-4 Stream) to HMC Write Requester
    ----------------------------------------------------------------------------
    -- tuser[71:64] = Reserved
    -- tuser[63:0]  = HMC Header
    m_axis_rcv_buf_tvalid    : out std_logic;
    m_axis_rcv_buf_tlast     : out std_logic;
    m_axis_rcv_buf_tdata     : out std_logic_vector(255 downto 0);
    m_axis_rcv_buf_tkeep     : out std_logic_vector(31 downto 0);
    m_axis_rcv_buf_tready    : in  std_logic;
    
    --afl_in                   : in std_logic;
    ----------------------------------------------------------------------------
    -- Controls
    ----------------------------------------------------------------------------
    max_pcie_rqst_size       : in std_logic_vector(2 downto 0); 
    byte_swap                : in  std_logic;
    abort                    : in  std_logic;
    abort_busy               : out std_logic; 
    
    fifo_flush               : in  std_logic; -- Flush for FIFOs
    ----------------------------------------------------------------------------
    -- Status
    ----------------------------------------------------------------------------
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
end px_dma_pcie2pd_reader;

architecture Behavioral of px_dma_pcie2pd_reader is

-------------------------------------------------------------------------------
-- Components
-------------------------------------------------------------------------------

component px_dma_pcie2pd_rdrqst_sm is
generic(
    pcie_channel : std_logic_vector(2 downto 0) := "000"
);
port ( 
   clk                     : in  std_logic;
   rst_n                   : in  std_logic;
   ----------------------------------------------------------------------------
   -- Accept the Buffer Write Request from the DMA
   ----------------------------------------------------------------------------
   -- associated with hmc_clk
   buffer_rd_rqst_valid    : in  std_logic; 
   buffer_rd_rqst_ready    : out std_logic; 
   buffer_rd_rqst_data     : in  std_logic_vector(167 downto 0);
    -- buffer_rd_rqst_data[63:0]    = Source Start Address -- HMC Address (only 34 bits used in this case) -- Address must be on 4 byte address boundary
   -- buffer_rd_rqst_data[127:64]  = Source Meta Address  -- (only 34 bits used in this case) -- Meta Address must be on 16 byte address boundry
   -- buffer_rd_rqst_data[128]     = 0 = Use Descriptor Length 1 = Use Meta Data Length
   -- buffer_rd_rqst_data[130:129] = PCIe AT 
   -- buffer_rd_rqst_data[135:131] = Reserved 
   -- buffer_rd_rqst_data[167:136] = Size in bytes   
   buffer_rd_complete      : out std_logic;
   buffer_rqst_complete    : out std_logic;   
   ----------------------------------------------------------------------------
   -- Flow Control
   ----------------------------------------------------------------------------
   -- Found Meta Data
   s_axis_rd_rsp_tvalid    : in  std_logic;
   s_axis_rd_rsp_tdata     : in  std_logic_vector(31 downto 0); -- meta data length value when a meta data packet
   -- Response Tag to be monitored for completion
   meta_tvalid             : out std_logic;
   meta_tdata              : out std_logic_vector(2 downto 0); -- Return tag to look for for meta data
   
   incr_tag                : out std_logic;
   next_free_tag           : in  std_logic_vector(2 downto 0);
   num_free_tags           : in  std_logic_vector(3 downto 0);  
   rsp_pipe_afl            : in  std_logic;
    
   max_pcie_rqst_size      : in std_logic_vector(2 downto 0); 
   ----------------------------------------------------------------------------
   -- Control
   ----------------------------------------------------------------------------
   -- associated with pcie_clk
   abort                   : in  std_logic; 
   abort_busy              : out std_logic;
   fifo_flush              : in  std_logic;
   ----------------------------------------------------------------------------
   -- Actual Bytes Output
   ----------------------------------------------------------------------------
   -- associated with hmc_clk
   actual_bytes            : out std_logic_vector(31 downto 0); -- Actual number of Bytes Transferred
   actual_bytes_valid      : out std_logic; -- Actual number of Bytes Transferred valid
    ----------------------------------------------------------------------------
   -- Output PCIe Requester Request Data Stream (AXI-Stream Master)
   ----------------------------------------------------------------------------
   -- address aligned mode
   
   m_axis_pcie_rq_tvalid   : out std_logic;
   m_axis_pcie_rq_tready   : in  std_logic;
   m_axis_pcie_rq_tdata    : out std_logic_vector(255 downto 0); 
   m_axis_pcie_rq_tkeep    : out std_logic_vector(7 downto 0);    
   m_axis_pcie_rq_tuser    : out std_logic_vector(59 downto 0);
   m_axis_pcie_rq_tlast    : out std_logic; -- end of packet
   -----------------------------------------------------------------------------
   -- Status
   -----------------------------------------------------------------------------
   fifo_empty              : out std_logic;
   fifo_afl                : out std_logic
);
end component;

component px_dma_pcie2pd_rdrcv_buffer 
generic (
pcie_channel : std_logic_vector(2 downto 0) := "000"
);
port (
    abort                    : in  std_logic;
    abort_busy               : out std_logic;
    ----------------------------------------------------------------------------
    -- PCIe Requester Completion Interface (AXI Stream)
    ----------------------------------------------------------------------------   
    clk                      : in std_logic;
    rst_n                    : in std_logic;
    -- associated with pcie_clk
    -- address aligned mode
    s_axis_pcie_rc_tvalid    : in  std_logic;
    s_axis_pcie_rc_tready    : out std_logic;
    s_axis_pcie_rc_tdata     : in  std_logic_vector(255 downto 0);
    s_axis_pcie_rc_tkeep     : in  std_logic_vector(7 downto 0);    
    s_axis_pcie_rc_tuser     : in  std_logic_vector(74 downto 0);
    s_axis_pcie_rc_tlast     : in  std_logic; -- end of packet
     ---------------------------------------------------------------------------
     -- Response to be monitored by state machine
     ---------------------------------------------------------------------------
    -- Found Meta Data
     m_axis_rd_rsp_tvalid    : out std_logic;
     m_axis_rd_rsp_tdata     : out std_logic_vector(31 downto 0); -- meta data length value when a meta data packet
     -- Response Tag to be monitored for completion
     meta_tvalid             : in  std_logic;
     meta_tdata              : in  std_logic_vector(2 downto 0); -- Return tag to look for for meta data
    ----------------------------------------------------------------------------
    -- Output Interface (AXI Stream)
    ----------------------------------------------------------------------------
    -- tuser[71:64] = Reserved
    -- tuser[63:0]  = HMC Header
    m_axis_rcv_buf_tvalid    : out std_logic;
    m_axis_rcv_buf_tlast     : out std_logic;
    m_axis_rcv_buf_tdata     : out std_logic_vector(255 downto 0);
    m_axis_rcv_buf_tkeep     : out std_logic_vector(31 downto 0);
    m_axis_rcv_buf_tready    : in  std_logic;
    ----------------------------------------------------------------------------
    -- Flow Control
    ----------------------------------------------------------------------------
    -- associated with pcie_clk
    incr_tag                 : in  std_logic;
    next_free_tag            : out std_logic_vector(2 downto 0);
    num_free_tags            : out std_logic_vector(3 downto 0);
    fifo_flush_n             : in std_logic;
    ----------------------------------------------------------------------------
    -- PCIe Error Status
    ----------------------------------------------------------------------------
    error_out                : out std_logic;
    error_code               : out std_logic_vector(3 downto 0);
    fifo_data_count          : out std_logic_vector(11 downto 0);
    fifo_empty               : out std_logic;
    fifo_full                : out std_logic;
        
    byte_swap                : in  std_logic                             
);
end component;


-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal rd_rsp_tvalid            : std_logic := '0';                      
signal rd_rsp_tdata             : std_logic_vector(31 downto 0) := (others => '0');
signal meta_tvalid              : std_logic := '0';                                 
signal meta_tdata               : std_logic_vector(2 downto 0) := (others => '0'); 
signal incr_tag                 : std_logic := '0';
signal next_free_tag            : std_logic_vector(2 downto 0)  := (others => '0');
signal num_free_tags            : std_logic_vector(3 downto 0)  := (others => '0');    
signal pkt_info_tdata           : std_logic_vector(15 downto 0) := (others => '0');
signal pkt_info_tuser           : std_logic_vector(71 downto 0) := (others => '0'); 
signal pkt_info_tvalid          : std_logic := '0';
signal t1_abort                 : std_logic := '0';
signal t2_abort                 : std_logic := '0';
signal rqst_abort_busy          : std_logic := '0';
signal rcv_abort_busy           : std_logic := '0';
signal fifo_flush_n              : std_logic := '0';

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------

constant pcie_channel_num : std_logic_vector(2 downto 0) := conv_std_logic_vector(pcie_channel, 3);

-------------------------------------------------------------------------------

begin

fifo_flush_n <= not fifo_flush;  

-- PCIe Read Request generator
rdrqst_sm_inst: px_dma_pcie2pd_rdrqst_sm
generic map(
    pcie_channel => pcie_channel_num
)
port map( 
   clk                     => clk,
   rst_n                   => rst_n,
   ----------------------------------------------------------------------------
   -- Accept the Buffer Write Request from the DMA
   ----------------------------------------------------------------------------
   buffer_rd_rqst_valid    => buffer_rd_rqst_valid,   
   buffer_rd_rqst_ready    => buffer_rd_rqst_ready,
   buffer_rd_rqst_data     => buffer_rd_rqst_data(167 downto 0),
   -- buffer_rd_rqst_data[63:0]    = Source Start Address -- PCIe Address -- Address must be on 4 byte address boundary     
   -- buffer_rd_rqst_data[127:64]  = Source Meta Address  -- PCIe Address -- Meta Address must be on 4 byte address boundry 
   -- buffer_rd_rqst_data[191:128] = Destination Start Address -- HMC Address -- Address must be on 4 byte address boundary 
   -- buffer_rd_rqst_data[255:192] = Destination Meta Start Address  -- HMC Address must be on 16 byte address boundary     
   -- buffer_rd_rqst_data[258:256] = Cube Address                                                                           
   -- buffer_rd_rqst_data[259]     = 0 = Use Descriptor Length 1 = Use Meta Data Length                                     
   -- buffer_rd_rqst_data[261:260] = PCIe AT                                                                                
   -- buffer_rd_rqst_data[262]     = Reserved                                                                      
   -- buffer_rd_rqst_data[263]     = Reserved                                                                               
   -- buffer_rd_rqst_data[295:264] = Size in bytes  
   buffer_rd_complete      => buffer_rd_complete,
   buffer_rqst_complete    => buffer_rqst_complete,
   ----------------------------------------------------------------------------
   -- Flow Control
   ----------------------------------------------------------------------------
   -- Read Responses to be monitored for completion and for return of meta data 
   s_axis_rd_rsp_tvalid    => rd_rsp_tvalid,                    
   s_axis_rd_rsp_tdata     => rd_rsp_tdata, 
   
   meta_tvalid             => meta_tvalid,
   meta_tdata              => meta_tdata,
   
   incr_tag                => incr_tag,     
   next_free_tag           => next_free_tag,
   num_free_tags           => num_free_tags,  
   rsp_pipe_afl            => '0',  -- Read Response Pipeline is almost full (throttle back requests)

   max_pcie_rqst_size      => max_pcie_rqst_size,  
   ----------------------------------------------------------------------------
   -- Control
   ----------------------------------------------------------------------------
   abort                   => abort,
   abort_busy              => rqst_abort_busy,
   fifo_flush              => fifo_flush,
   ----------------------------------------------------------------------------
   -- Actual Bytes Output
   ----------------------------------------------------------------------------
   actual_bytes            => actual_bytes,       -- Actual number of Bytes Transferred
   actual_bytes_valid      => actual_bytes_valid, -- Actual number of Bytes Transferred valid
   ----------------------------------------------------------------------------
   -- Output PCIe Requester Request Data Stream (AXI-Stream Master)
   ----------------------------------------------------------------------------
   -- associated with clk
   -- address aligned mode
  
   m_axis_pcie_rq_tvalid   => m_axis_pcie_rq_tvalid, 
   m_axis_pcie_rq_tready   => m_axis_pcie_rq_tready,     
   m_axis_pcie_rq_tdata    => m_axis_pcie_rq_tdata,  
   m_axis_pcie_rq_tkeep    => m_axis_pcie_rq_tkeep,  
   m_axis_pcie_rq_tuser    => m_axis_pcie_rq_tuser,  
   m_axis_pcie_rq_tlast    => m_axis_pcie_rq_tlast,  
   -----------------------------------------------------------------------------
   -- Status
   -----------------------------------------------------------------------------
   fifo_empty              => rqst_fifo_empty,
   fifo_afl                => rqst_fifo_afl  
);

--------------------------------------------------------------------------------
-- Reorder Buffer
--------------------------------------------------------------------------------
-- Data received back from the PCIe may be out of order.
-- This module will check tags against outstanding tags to reorder the data.

rdrcv_buffer_inst: px_dma_pcie2pd_rdrcv_buffer 
generic map(
pcie_channel => pcie_channel_num
)
port map (
    abort                    => rqst_abort_busy, 
    abort_busy               => rcv_abort_busy,
    ----------------------------------------------------------------------------
    -- PCIe Requester Completion Interface (AXI Stream)
    ----------------------------------------------------------------------------    
    clk                      => clk,
    rst_n                    => rst_n,

    s_axis_pcie_rc_tvalid    => s_axis_pcie_rc_tvalid,
    s_axis_pcie_rc_tready    => s_axis_pcie_rc_tready,
    s_axis_pcie_rc_tdata     => s_axis_pcie_rc_tdata, 
    s_axis_pcie_rc_tkeep     => s_axis_pcie_rc_tkeep,   
    s_axis_pcie_rc_tuser     => s_axis_pcie_rc_tuser, 
    s_axis_pcie_rc_tlast     => s_axis_pcie_rc_tlast,
    ----------------------------------------------------------------------------
    -- Responses to be monitored by state machine
    ---------------------------------------------------------------------------- 
    m_axis_rd_rsp_tvalid     => rd_rsp_tvalid,                      
    m_axis_rd_rsp_tdata      => rd_rsp_tdata, 
    
    meta_tvalid             => meta_tvalid,
    meta_tdata              => meta_tdata,
    ----------------------------------------------------------------------------
    -- Output Interface (AXI Stream)
    ----------------------------------------------------------------------------
    m_axis_rcv_buf_tvalid    => m_axis_rcv_buf_tvalid,
    m_axis_rcv_buf_tlast     => m_axis_rcv_buf_tlast,
    m_axis_rcv_buf_tdata     => m_axis_rcv_buf_tdata,
    m_axis_rcv_buf_tkeep     => m_axis_rcv_buf_tkeep,
    m_axis_rcv_buf_tready    => m_axis_rcv_buf_tready,
    ----------------------------------------------------------------------------
    -- Flow Control
    ----------------------------------------------------------------------------
    incr_tag                 => incr_tag,
    next_free_tag            => next_free_tag,
    num_free_tags            => num_free_tags,
    fifo_flush_n             => fifo_flush_n, 
    ----------------------------------------------------------------------------
    -- PCIe Error Status
    ----------------------------------------------------------------------------
    error_out                => error_out,
    error_code               => error_code,
    fifo_data_count          => fifo_data_count,  
    fifo_empty               => data_fifo_empty,
    fifo_full                => data_fifo_full,
 
    byte_swap                => byte_swap                       
);

process(clk)
begin
    if rising_edge(clk) then
        abort_busy <= abort or t1_abort or t2_abort or rqst_abort_busy or rcv_abort_busy;
        t1_abort <= abort;
        t2_abort <= t2_abort;
    end if;
end process;    

process(clk)
begin
    if rising_edge(clk) then
        if num_free_tags >= "1000" then
            all_tags_returned <= '1';
        else
            all_tags_returned <= '0';
        end if; 
    end if;    
end process;
 
end Behavioral;