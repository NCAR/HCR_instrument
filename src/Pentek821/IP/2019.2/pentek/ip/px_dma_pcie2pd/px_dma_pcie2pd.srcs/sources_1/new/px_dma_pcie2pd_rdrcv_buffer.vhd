----------------------------------------------------------------------------------
-- Pentek PCIe to AXI-S DMA Read Receive Buffer
----------------------------------------------------------------------------------
-- px_dma_pcie2pd_rd_rcv_buffer.vhd
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_dma_pcie2pd_rdrcv_buffer is
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
    m_axis_rcv_buf_tvalid    : out std_logic;
    m_axis_rcv_buf_tlast     : out std_logic;
    m_axis_rcv_buf_tready    : in  std_logic;
    m_axis_rcv_buf_tdata     : out std_logic_vector(255 downto 0);
    m_axis_rcv_buf_tkeep     : out std_logic_vector(31 downto 0);
    ----------------------------------------------------------------------------
    -- Flow Control
    ----------------------------------------------------------------------------
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
end px_dma_pcie2pd_rdrcv_buffer;

architecture Behavioral of px_dma_pcie2pd_rdrcv_buffer is
--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------
-- packet FIFO
-- 256 wide
-- 128 deep
COMPONENT px_dma_pcie2pd_cmp_fifo
  PORT (
    s_aclk : IN STD_LOGIC;
    s_aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    s_axis_tkeep : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_tlast : IN STD_LOGIC;
    s_axis_tuser : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(255 DOWNTO 0);
    m_axis_tkeep : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_tlast : OUT STD_LOGIC;
    m_axis_tuser : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
  );
END COMPONENT;

-- Data FIFO
-- 256 wide
-- 2048 deep
COMPONENT px_dma_pcie2pd_buf_fifo
  PORT (
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
    axis_data_count : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
  );
END COMPONENT;

COMPONENT px_dma_pcie2pd_tag_fifo
  PORT (
    clk : IN STD_LOGIC;
    srst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    data_count : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    wr_rst_busy : OUT STD_LOGIC;
    rd_rst_busy : OUT STD_LOGIC
  );
END COMPONENT;

-- AXI-S Pipeline Buffer
-- Full registered
COMPONENT px_dma_pcie2pd_buf_pipe
  PORT (
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
    m_axis_tlast : OUT STD_LOGIC
  );
END COMPONENT;

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

type tkeep_array is array (0 to 7) of std_logic_vector(31 downto 0);
type tdata_array is array (0 to 7) of std_logic_vector(255 downto 0);
type tuser_array is array (0 to 7) of std_logic_vector(0 downto 0);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal t1_s_axis_pcie_rc_tvalid : std_logic := '0';
signal t1_s_axis_pcie_rc_tdata  : std_logic_vector(255 downto 0) := (others => '0');
signal t1_s_axis_pcie_rc_tkeep  : std_logic_vector(7 downto 0) := (others => '0');
signal t1_s_axis_pcie_rc_tuser  : std_logic_vector(74 downto 0) := (others => '0');
signal t1_s_axis_pcie_rc_tlast  : std_logic := '0';
signal t2_pcie_rc_all_complete  : std_logic := '0';
signal next_tag                 : std_logic_vector(2 downto 0) := (others => '0');
signal t2_pcie_rc_tag           : std_logic_vector(7 downto 0) := (others => '0');
signal t2_pcie_rc_error_code    : std_logic_vector(3 downto 0) := (others => '0');
signal t1_pcie_rc_tvalid        : std_logic := '0';
signal t2_pcie_rc_error         : std_logic := '0';
signal t2_pcie_rc_tdata         : std_logic_vector(255 downto 0) := (others => '0');
signal t2_pcie_rc_tuser         : std_logic_vector(74 downto 0) := (others => '0');
signal t2_pcie_rc_tvalid        : std_logic := '0';
signal t2_pcie_rc_tlast         : std_logic := '0';
signal tag_loader_cntr          : std_logic_vector(4 downto 0) := (others => '0');
signal tag_fifo_rst             : std_logic := '0';
signal tag_wr                   : std_logic := '0';
signal tag_input                : std_logic_vector(2 downto 0) := (others => '0');
signal tag_fifo_count           : std_logic_vector(4 downto 0) := (others => '0');
signal abort_busy_re            : std_logic := '0';
signal abort_busy_fe            : std_logic := '0';
signal t1_abort_busy            : std_logic := '0';
signal abortbusy                : std_logic := '0';
signal t2_pcie_rc_tkeep         : std_logic_vector(7 downto 0) := (others => '0');
signal t2_pcie_rc_tkeepv        : std_logic_vector(31 downto 0) := (others => '0');
signal t2_pcie_rc_tlastx        : std_logic := '0';
signal t2_pcie_rc_tvalidv       : std_logic_vector(7 downto 0):= (others => '0');
signal cmp_fifo_tvalid          : std_logic_vector(7 downto 0):= (others => '0');
signal cmp_fifo_tready          : std_logic_vector(7 downto 0):= (others => '0');
signal cmp_fifo_tkeep           : tkeep_array;
signal cmp_fifo_tdata           : tdata_array;
signal cmp_fifo_tlast           : std_logic_vector(7 downto 0):= (others => '0');
signal cmp_fifo_tuser           : tuser_array;
signal output_sel_tag           : std_logic_vector(2 downto 0):= (others => '0');
signal used_tag_rd              : std_logic := '0';
signal out_fifo_tvalid          : std_logic := '0';
signal out_fifo_tready          : std_logic := '0';
signal out_fifo_tdata           : std_logic_vector(255 downto 0):= (others => '0');
signal out_fifo_tkeep           : std_logic_vector(31 downto 0):= (others => '0');
signal out_fifo_tlast           : std_logic := '0';
signal buf_pipe_tvalid          : std_logic := '0';
signal buf_pipe_tready          : std_logic := '0';
signal buf_pipe_tdata           : std_logic_vector(255 downto 0):= (others => '0');
signal buf_pipe_tkeep           : std_logic_vector(31 downto 0):= (others => '0');
signal buf_pipe_tlast           : std_logic := '0';
signal buf_pipe_tdata_bs        : std_logic_vector(255 downto 0):= (others => '0');
signal fifo_rstn                : std_logic := '0';
signal fifo_data_countx         : std_logic_vector(11 downto 0) := x"000";
signal t1_byte_swap             : std_logic := '0';
signal watch_for_meta           : std_logic := '0';
signal watch_for_meta_val       : std_logic_vector(2 downto 0):= (others => '0');
signal watch_for_meta_match     : std_logic := '0';
signal abort_timeout_cntr       : std_logic_vector(15 downto 0) := x"0000";

--------------------------------------------------------------------------------
 
begin

--------------------------------------------------------------------------------
-- Abort
--------------------------------------------------------------------------------
-- If abort is requested, we need to wait until the tag counter goes to
-- zero meaning there are no more completions in flight.
-- Mark Abort Busy until all outstanding completions have been received.

process(clk)
begin
    if rising_edge(clk) then
        if rst_n = '0' then
            abort_busy <= '0';
            abortbusy  <= '0';
        elsif abort = '1' then
            abort_busy <= '1';
            abortbusy  <= '1';
        -- All tags returned or we waited long enough and tags won't be returned.
        elsif (tag_fifo_count >= "01000") or (abort_timeout_cntr = x"0000") then
            abort_busy <= '0';
            abortbusy  <= '0';
        end if;
        t1_abort_busy <= abortbusy;
        abort_busy_re <= abortbusy and not t1_abort_busy;
        abort_busy_fe <= t1_abort_busy and not abortbusy;
    end if;
end process;  

-- abort timeout counter
-- If the DMA never receives back all of its tags, then end abort and reset tags
process(clk)
begin
    if rising_edge(clk) then
      if rst_n = '0' then
         abort_timeout_cntr <= x"0000";
      elsif abort = '1' then
         abort_timeout_cntr <= x"FFFF";
      elsif abort_timeout_cntr /= x"0000" then
         abort_timeout_cntr <= abort_timeout_cntr - 1;
      end if; 
    end if;
end process;  

---------------------------------------------------------------------------------

s_axis_pcie_rc_tready <= '1'; -- Always ready (We only ask for data we have room for) 

process(clk)
begin
    if rising_edge(clk) then
        t1_s_axis_pcie_rc_tvalid   <=  s_axis_pcie_rc_tvalid;
        t1_s_axis_pcie_rc_tdata    <=  s_axis_pcie_rc_tdata; 
        t1_s_axis_pcie_rc_tkeep    <=  s_axis_pcie_rc_tkeep; 
        t1_s_axis_pcie_rc_tuser    <=  s_axis_pcie_rc_tuser; 
        t1_s_axis_pcie_rc_tlast    <=  s_axis_pcie_rc_tlast; 
    end if;
end process;

-- PCIe Requester Completion Header fields
process(clk)
begin
    if rising_edge(clk) then
    -- If SOF and the Tag matches then latch the pertinent header info
        if (t1_s_axis_pcie_rc_tvalid = '1') and (t1_s_axis_pcie_rc_tuser(32) = '1') and (t1_s_axis_pcie_rc_tdata(69 downto 67) = pcie_channel) then 
            t2_pcie_rc_tag         <= t1_s_axis_pcie_rc_tdata(71 downto 64);
            t2_pcie_rc_error_code  <= t1_s_axis_pcie_rc_tdata(15 downto 12);
        end if;
        if (t1_s_axis_pcie_rc_tvalid = '1') and (t1_s_axis_pcie_rc_tuser(32) = '1') and (t1_s_axis_pcie_rc_tlast = '0') and (t1_s_axis_pcie_rc_tdata(69 downto 67) = pcie_channel) then 
            t1_pcie_rc_tvalid    <= '1';
        elsif (t1_s_axis_pcie_rc_tlast = '1') then
            t1_pcie_rc_tvalid    <= '0';
        end if; 
        if (t1_s_axis_pcie_rc_tvalid = '1') and (t1_s_axis_pcie_rc_tuser(32) = '1') and (t1_s_axis_pcie_rc_tdata(69 downto 67) = pcie_channel) then 
            if (t1_s_axis_pcie_rc_tdata(15 downto 12) /= "0000") then
              t2_pcie_rc_error        <= '1';
            else
              t2_pcie_rc_error        <= '0';
            end if;  
            t2_pcie_rc_all_complete   <= t1_s_axis_pcie_rc_tdata(30); -- Marker in last completion of a request
        end if;
        t2_pcie_rc_tdata        <= t1_s_axis_pcie_rc_tdata;
        t2_pcie_rc_tuser        <= t1_s_axis_pcie_rc_tuser;
        t2_pcie_rc_tvalid       <= t1_pcie_rc_tvalid; -- without header
        t2_pcie_rc_tkeep        <= t1_s_axis_pcie_rc_tkeep;
        t2_pcie_rc_tlast        <= t2_pcie_rc_all_complete and t1_s_axis_pcie_rc_tlast;   
        t2_pcie_rc_tlastx       <= t1_s_axis_pcie_rc_tlast;    
        error_out               <= t2_pcie_rc_error;
        error_code              <= t2_pcie_rc_error_code;
    end if;
end process;

t2_pcie_rc_tvalidv(0)    <= t2_pcie_rc_tvalid when ((t2_pcie_rc_tag(2 downto 0) = "000") and (watch_for_meta = '0')) else '0';
t2_pcie_rc_tvalidv(1)    <= t2_pcie_rc_tvalid when ((t2_pcie_rc_tag(2 downto 0) = "001") and (watch_for_meta = '0')) else '0';
t2_pcie_rc_tvalidv(2)    <= t2_pcie_rc_tvalid when ((t2_pcie_rc_tag(2 downto 0) = "010") and (watch_for_meta = '0')) else '0';
t2_pcie_rc_tvalidv(3)    <= t2_pcie_rc_tvalid when ((t2_pcie_rc_tag(2 downto 0) = "011") and (watch_for_meta = '0')) else '0';
t2_pcie_rc_tvalidv(4)    <= t2_pcie_rc_tvalid when ((t2_pcie_rc_tag(2 downto 0) = "100") and (watch_for_meta = '0')) else '0';
t2_pcie_rc_tvalidv(5)    <= t2_pcie_rc_tvalid when ((t2_pcie_rc_tag(2 downto 0) = "101") and (watch_for_meta = '0')) else '0';
t2_pcie_rc_tvalidv(6)    <= t2_pcie_rc_tvalid when ((t2_pcie_rc_tag(2 downto 0) = "110") and (watch_for_meta = '0')) else '0';
t2_pcie_rc_tvalidv(7)    <= t2_pcie_rc_tvalid when ((t2_pcie_rc_tag(2 downto 0) = "111") and (watch_for_meta = '0')) else '0';

t2_pcie_rc_tkeepv(3 downto 0)   <= t2_pcie_rc_tkeep(0) & t2_pcie_rc_tkeep(0) & t2_pcie_rc_tkeep(0) & t2_pcie_rc_tkeep(0);
t2_pcie_rc_tkeepv(7 downto 4)   <= t2_pcie_rc_tkeep(1) & t2_pcie_rc_tkeep(1) & t2_pcie_rc_tkeep(1) & t2_pcie_rc_tkeep(1);
t2_pcie_rc_tkeepv(11 downto 8)  <= t2_pcie_rc_tkeep(2) & t2_pcie_rc_tkeep(2) & t2_pcie_rc_tkeep(2) & t2_pcie_rc_tkeep(2);
t2_pcie_rc_tkeepv(15 downto 12) <= t2_pcie_rc_tkeep(3) & t2_pcie_rc_tkeep(3) & t2_pcie_rc_tkeep(3) & t2_pcie_rc_tkeep(3);
t2_pcie_rc_tkeepv(19 downto 16) <= t2_pcie_rc_tkeep(4) & t2_pcie_rc_tkeep(4) & t2_pcie_rc_tkeep(4) & t2_pcie_rc_tkeep(4);
t2_pcie_rc_tkeepv(23 downto 20) <= t2_pcie_rc_tkeep(5) & t2_pcie_rc_tkeep(5) & t2_pcie_rc_tkeep(5) & t2_pcie_rc_tkeep(5);
t2_pcie_rc_tkeepv(27 downto 24) <= t2_pcie_rc_tkeep(6) & t2_pcie_rc_tkeep(6) & t2_pcie_rc_tkeep(6) & t2_pcie_rc_tkeep(6);
t2_pcie_rc_tkeepv(31 downto 28) <= t2_pcie_rc_tkeep(7) & t2_pcie_rc_tkeep(7) & t2_pcie_rc_tkeep(7) & t2_pcie_rc_tkeep(7);

--------------------------------------------------------------------------------
-- Completion FIFOs
--------------------------------------------------------------------------------
-- There can be 8 possible outstanding completions per DMA
-- The tag[2:0] identify them

gen_cmp_buffer: for i in 0 to 7 generate
-- Packet FIFO
-- 256 wide
-- 128 deep
cmp_fifo_inst : px_dma_pcie2pd_cmp_fifo
  PORT MAP (
    s_aclk        => clk,
    s_aresetn     => fifo_rstn,
    s_axis_tvalid => t2_pcie_rc_tvalidv(i),
    s_axis_tready => open,
    s_axis_tdata  => t2_pcie_rc_tdata,
    s_axis_tkeep  => t2_pcie_rc_tkeepv,
    s_axis_tlast  => t2_pcie_rc_tlast,
    s_axis_tuser(0)  => t2_pcie_rc_tlastx,
    m_axis_tvalid => cmp_fifo_tvalid(i),
    m_axis_tready => cmp_fifo_tready(i),
    m_axis_tdata  => cmp_fifo_tdata(i)(255 downto 0),
    m_axis_tkeep  => cmp_fifo_tkeep(i),
    m_axis_tlast  => cmp_fifo_tlast(i),
    m_axis_tuser  => cmp_fifo_tuser(i)
  );
end generate;  
 
--------------------------------------------------------------------------------
-- Response to be monitored for Meta Data
--------------------------------------------------------------------------------
process(clk)
begin
    if rising_edge(clk) then
      if (rst_n = '0') or (abort_busy_fe = '1') or (watch_for_meta_match = '1') then
         watch_for_meta <= '0';
      elsif (meta_tvalid = '1') then 
         watch_for_meta <= '1'; -- Latch meta data tag to look for
         watch_for_meta_val <= meta_tdata; 
      end if;
         m_axis_rd_rsp_tvalid <= watch_for_meta_match and watch_for_meta; 
         m_axis_rd_rsp_tdata  <= t2_pcie_rc_tdata(95 downto 64); -- meta data length value when a meta data packet
    end if;
end process;

watch_for_meta_match <= '1' when ((t2_pcie_rc_tvalid='1') and (t2_pcie_rc_tlast='1') and (t2_pcie_rc_all_complete='1') and (t2_pcie_rc_tag(2 downto 0) = watch_for_meta_val)) else '0';

--------------------------------------------------------------------------------
-- Tag Management
--------------------------------------------------------------------------------

process(clk)
begin
    if rising_edge(clk) then
        if (rst_n = '0') or (abort_busy_fe = '1') then
            tag_loader_cntr <= "00000";
        elsif tag_loader_cntr /= "10000" then
            tag_loader_cntr <= tag_loader_cntr + 1;
        end if;
        if (tag_loader_cntr > "00111") and (tag_loader_cntr /= "10000") then
            tag_input <= tag_loader_cntr(2 downto 0);
            tag_wr    <= '1';
        elsif tag_loader_cntr = "10000" then
            tag_input <= output_sel_tag; --t2_pcie_rc_tag(2 downto 0);
            if (tag_fifo_count < "01000") then
               tag_wr    <= used_tag_rd;--tag_returned;
            else
               tag_wr    <= '0';
            end if;
        else
            tag_wr    <= '0';
        end if;
        if (tag_loader_cntr < "00100") then
            tag_fifo_rst <= '1';
        else
            tag_fifo_rst <= '0';
        end if;
    end if;
end process;    

tag_fifo_inst: px_dma_pcie2pd_tag_fifo
port map (
    clk         => clk,
    srst        => tag_fifo_rst,
    din         => tag_input,
    wr_en       => tag_wr,
    rd_en       => incr_tag,
    dout        => next_tag,
    full        => open,
    empty       => open,
    data_count  => tag_fifo_count,
    wr_rst_busy => open,
    rd_rst_busy => open
  );

 
num_free_tags <= tag_fifo_count(3 downto 0);
next_free_tag <= next_tag;

used_tag_fifo_inst: px_dma_pcie2pd_tag_fifo
port map (
    clk         => clk,
    srst        => tag_fifo_rst,
    din         => next_tag,
    wr_en       => incr_tag,
    rd_en       => used_tag_rd,
    dout        => output_sel_tag,
    full        => open,
    empty       => open,
    data_count  => open,
    wr_rst_busy => open,
    rd_rst_busy => open
  );

process(output_sel_tag, out_fifo_tready, cmp_fifo_tlast, cmp_fifo_tvalid, cmp_fifo_tkeep, cmp_fifo_tdata, cmp_fifo_tvalid, cmp_fifo_tuser)
begin
   case output_sel_tag is
      when "000" =>
         cmp_fifo_tready      <= "0000000" & out_fifo_tready;
         used_tag_rd          <= cmp_fifo_tlast(0) and out_fifo_tready and cmp_fifo_tvalid(0); 
         out_fifo_tvalid      <= cmp_fifo_tvalid(0);               
         out_fifo_tdata       <= cmp_fifo_tdata(0)(255 downto 0);  
         out_fifo_tkeep       <= cmp_fifo_tkeep(0);   
         out_fifo_tlast       <= cmp_fifo_tuser(0)(0);                           
      when "001" =>
         cmp_fifo_tready      <= "000000" & out_fifo_tready & '0';
         used_tag_rd          <= cmp_fifo_tlast(1) and out_fifo_tready and cmp_fifo_tvalid(1); 
         out_fifo_tvalid      <= cmp_fifo_tvalid(1);               
         out_fifo_tdata       <= cmp_fifo_tdata(1)(255 downto 0);  
         out_fifo_tkeep       <= cmp_fifo_tkeep(1);  
         out_fifo_tlast       <= cmp_fifo_tuser(1)(0);              
      when "010" =>
         cmp_fifo_tready      <= "00000" & out_fifo_tready & "00";
         used_tag_rd          <= cmp_fifo_tlast(2) and out_fifo_tready and cmp_fifo_tvalid(2);      
         out_fifo_tvalid      <= cmp_fifo_tvalid(2);               
         out_fifo_tdata       <= cmp_fifo_tdata(2)(255 downto 0);  
         out_fifo_tkeep       <= cmp_fifo_tkeep(2);
         out_fifo_tlast       <= cmp_fifo_tuser(2)(0);                      
      when "011" =>
         cmp_fifo_tready      <= "0000" & out_fifo_tready & "000";
         used_tag_rd          <= cmp_fifo_tlast(3) and out_fifo_tready and cmp_fifo_tvalid(3);
         out_fifo_tvalid      <= cmp_fifo_tvalid(3);               
         out_fifo_tdata       <= cmp_fifo_tdata(3)(255 downto 0);  
         out_fifo_tkeep       <= cmp_fifo_tkeep(3);
         out_fifo_tlast       <= cmp_fifo_tuser(3)(0);                  
      when "100" =>
         cmp_fifo_tready      <= "000" & out_fifo_tready & "0000";
         used_tag_rd          <= cmp_fifo_tlast(4) and out_fifo_tready and cmp_fifo_tvalid(4);
         out_fifo_tvalid      <= cmp_fifo_tvalid(4);               
         out_fifo_tdata       <= cmp_fifo_tdata(4)(255 downto 0);  
         out_fifo_tkeep       <= cmp_fifo_tkeep(4);
         out_fifo_tlast       <= cmp_fifo_tuser(4)(0);                  
      when "101" =>
         cmp_fifo_tready      <= "00" & out_fifo_tready & "00000";
         used_tag_rd          <=cmp_fifo_tlast(5) and out_fifo_tready and cmp_fifo_tvalid(5);
         out_fifo_tvalid      <= cmp_fifo_tvalid(5);               
         out_fifo_tdata       <= cmp_fifo_tdata(5)(255 downto 0);  
         out_fifo_tkeep       <= cmp_fifo_tkeep(5);
         out_fifo_tlast       <= cmp_fifo_tuser(5)(0);                    
      when "110" =>
         cmp_fifo_tready      <= '0' & out_fifo_tready & "000000";
         used_tag_rd          <= cmp_fifo_tlast(6) and out_fifo_tready and cmp_fifo_tvalid(6);
         out_fifo_tvalid      <= cmp_fifo_tvalid(6);               
         out_fifo_tdata       <= cmp_fifo_tdata(6)(255 downto 0);  
         out_fifo_tkeep       <= cmp_fifo_tkeep(6);
         out_fifo_tlast       <= cmp_fifo_tuser(6)(0);                    
      when "111" =>
         cmp_fifo_tready      <= out_fifo_tready & "0000000";
         used_tag_rd          <= cmp_fifo_tlast(7) and out_fifo_tready and cmp_fifo_tvalid(7);
         out_fifo_tvalid      <= cmp_fifo_tvalid(7);               
         out_fifo_tdata       <= cmp_fifo_tdata(7)(255 downto 0);  
         out_fifo_tkeep       <= cmp_fifo_tkeep(7);
         out_fifo_tlast       <= cmp_fifo_tuser(7)(0);                  
      when others =>
         cmp_fifo_tready      <= out_fifo_tready & "0000000";
         used_tag_rd          <= cmp_fifo_tlast(7) and out_fifo_tready and cmp_fifo_tvalid(7);
         out_fifo_tvalid      <= cmp_fifo_tvalid(7);               
         out_fifo_tdata       <= cmp_fifo_tdata(7)(255 downto 0);  
         out_fifo_tkeep       <= cmp_fifo_tkeep(7);
         out_fifo_tlast       <= cmp_fifo_tuser(7)(0);                     
   end case;                                        
end process;

--------------------------------------------------------------------------------
-- AXI-S Pipeline Buffer
--------------------------------------------------------------------------------
buf_pipe_inst : px_dma_pcie2pd_buf_pipe
  PORT MAP (
    s_aclk          => clk,
    s_aresetn       => fifo_rstn,
    s_axis_tvalid   => out_fifo_tvalid,
    s_axis_tready   => out_fifo_tready,
    s_axis_tdata    => out_fifo_tdata, 
    s_axis_tkeep    => out_fifo_tkeep, 
    s_axis_tlast    => out_fifo_tlast, 
    m_axis_tvalid   => buf_pipe_tvalid,
    m_axis_tready   => buf_pipe_tready,
    m_axis_tdata    => buf_pipe_tdata,
    m_axis_tkeep    => buf_pipe_tkeep,
    m_axis_tlast    => buf_pipe_tlast
  );

process(clk)
begin
    if rising_edge(clk) then
        fifo_rstn <= fifo_flush_n and rst_n;
        t1_byte_swap <= byte_swap;
    end if;    
end process;

buf_pipe_tdata_bs <= buf_pipe_tdata when (t1_byte_swap = '0') else 
    buf_pipe_tdata(7 downto 0) & buf_pipe_tdata(15 downto 8) & buf_pipe_tdata(23 downto 16) & buf_pipe_tdata(31 downto 24) &
    buf_pipe_tdata(39 downto 32) & buf_pipe_tdata(47 downto 40) & buf_pipe_tdata(55 downto 48) & buf_pipe_tdata(63 downto 56) &
    buf_pipe_tdata(71 downto 64) & buf_pipe_tdata(79 downto 72) & buf_pipe_tdata(87 downto 80) & buf_pipe_tdata(95 downto 88) &
    buf_pipe_tdata(103 downto 96) & buf_pipe_tdata(111 downto 104) & buf_pipe_tdata(119 downto 112) & buf_pipe_tdata(127 downto 120) &
    buf_pipe_tdata(135 downto 128) & buf_pipe_tdata(143 downto 136) & buf_pipe_tdata(151 downto 144) & buf_pipe_tdata(159 downto 152) &
    buf_pipe_tdata(167 downto 160) & buf_pipe_tdata(175 downto 168) & buf_pipe_tdata(183 downto 176) & buf_pipe_tdata(191 downto 184) &
    buf_pipe_tdata(199 downto 192) & buf_pipe_tdata(207 downto 200) & buf_pipe_tdata(215 downto 208) & buf_pipe_tdata(223 downto 216) &
    buf_pipe_tdata(231 downto 224) & buf_pipe_tdata(239 downto 232) & buf_pipe_tdata(247 downto 240) & buf_pipe_tdata(255 downto 248);     

--------------------------------------------------------------------------------
-- Output Buffer FIFO
--------------------------------------------------------------------------------
-- FWFT
-- 256 wide
-- 512 deep
out_fifo_inst : px_dma_pcie2pd_buf_fifo
port map (
    s_aclk          => clk,
    s_aresetn       => fifo_rstn,
    s_axis_tvalid   => buf_pipe_tvalid, 
    s_axis_tready   => buf_pipe_tready, 
    s_axis_tdata    => buf_pipe_tdata_bs,  
    s_axis_tkeep    => buf_pipe_tkeep,  
    s_axis_tlast    => buf_pipe_tlast,   
    m_axis_tvalid   => m_axis_rcv_buf_tvalid,
    m_axis_tready   => m_axis_rcv_buf_tready,
    m_axis_tdata    => m_axis_rcv_buf_tdata,
    m_axis_tkeep    => m_axis_rcv_buf_tkeep,
    m_axis_tlast    => m_axis_rcv_buf_tlast,
    axis_data_count => fifo_data_countx
);

fifo_data_count <= fifo_data_countx;

process(clk)
begin
    if rising_edge(clk) then
        fifo_full  <= fifo_data_countx(11);
        if (fifo_data_countx = x"000") then 
            fifo_empty <= '1';
        else
            fifo_empty <= '0';
        end if;       
    end if;    
end process;


end Behavioral;
