----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 12/15/2016 09:04:55 AM
-- Design Name: 
-- Module Name: px_dma_pcie2ddr_writer - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: PCIe to DDR4 DMA DDR4 Write Request Generation
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

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

entity px_dma_pcie2ddr_writer is
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
    all_wr_complete         : out std_logic; -- All Write Requests have been executed
    all_rqst_complete       : out std_logic; -- All Write Requests have been generated
    ----------------------------------------------------------------------------
    -- Read Response Input Interface (AXI-4 Stream) into Write Requester
    ----------------------------------------------------------------------------
    -- synchrobnous to axis_aclk
    s_axis_rcv_buf_tvalid    : in  std_logic;
    s_axis_rcv_buf_tlast     : in  std_logic;
    s_axis_rcv_buf_tdata     : in  std_logic_vector(255 downto 0);
    s_axis_rcv_buf_tuser     : in  std_logic_vector(31 downto 0);  -- mask bits - 0 is mask (no write)
    s_axis_rcv_buf_tkeep     : in  std_logic_vector(31 downto 0);
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
end px_dma_pcie2ddr_writer;

architecture Behavioral of px_dma_pcie2ddr_writer is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------
--AXI-S Width Conversion
COMPONENT px_dma_pcie2ddr_wc
  PORT (
    aclk          : IN STD_LOGIC;
    aresetn       : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata  : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    s_axis_tkeep  : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_tlast  : IN STD_LOGIC;
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata  : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
    m_axis_tkeep  : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
    m_axis_tlast  : OUT STD_LOGIC
  );
END COMPONENT;

-- 512 wide
-- 512 Deep
-- BRAM FIFO
-- Embedded Regs
-- prog_empty = 4
COMPONENT px_dma_pcie2ddr_win_fifo
  PORT (
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
    m_axis_tlast : OUT STD_LOGIC;
    axis_prog_empty : OUT STD_LOGIC
  );
END COMPONENT;

-- 512 x 512
-- afl at 511
-- embedded regs
COMPONENT px_dma_pcie2ddr_wrq_fifo
  PORT (
    m_aclk : IN STD_LOGIC;
    s_aclk : IN STD_LOGIC;
    s_aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
    s_axis_tlast : IN STD_LOGIC;
    s_axis_tuser : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
    m_axis_tlast : OUT STD_LOGIC;
    m_axis_tuser : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    axis_wr_data_count : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    axis_rd_data_count : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    axis_prog_full : OUT STD_LOGIC
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
reset_fifo_state,
wait_reset_over_state
);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal wc_axis_tvalid    : std_logic;
signal wc_axis_tlast     : std_logic;
signal wc_axis_tdata     : std_logic_vector(511 downto 0);
signal wc_axis_tkeep     : std_logic_vector(63 downto 0);
signal wc_axis_tready    : std_logic;
signal in_fifo_tvalid    : std_logic;
signal in_fifo_tlast     : std_logic;
signal in_fifo_tdata     : std_logic_vector(511 downto 0);
signal in_fifo_tkeep     : std_logic_vector(63 downto 0);
signal in_fifo_tready    : std_logic;
signal wr_tvalid         : std_logic;
signal wr_tlast          : std_logic;
signal wr_tdata          : std_logic_vector(511 downto 0);
signal wr_tuser          : std_logic_vector(255 downto 0);
signal wr_tready         : std_logic;
signal t1_axis_aresetn   : std_logic;
signal wr_access_cntr    : std_logic_vector(5 downto 0);
signal dest_addr         : std_logic_vector(31 downto 0);
signal length            : std_logic_vector(31 downto 0);
signal t1_length         : std_logic_vector(31 downto 0);
signal t1_buffer_rd_rqst_valid : std_logic;
signal inout_fifo_rst_n  : std_logic;
signal wr_addr           : std_logic_vector(31 downto 0);
signal in_fifo_prog_empty: std_logic;
signal wr_inc            : std_logic;
signal wr_count          : std_logic_vector(26 downto 0)  := (others => '0');
signal p_count_reached   : std_logic;
signal atleast_one       : std_logic;
signal inout_fifo_rst    : std_logic:= '0';
signal mid_packet_w      : std_logic:= '0';
signal mid_packet_r      : std_logic:= '0';
signal rst_wr_tvalid     : std_logic:= '0';
signal rst_rd_tvalid     : std_logic:= '0';
signal rst_wr_tlast      : std_logic:= '0';
signal rst_rd_tlast      : std_logic:= '0';
signal state             : state_type;
signal rst_cntr          : std_logic_vector(4 downto 0)  := (others => '0');
signal t1_conseq_access  : std_logic_vector(5 downto 0)  := (others => '0');
signal t1_fifo_flush     : std_logic:= '0';
signal t1_abort          : std_logic:= '0';
signal afl               : std_logic:= '0';
signal m_axis_rqst_tvalid_int: std_logic:= '0';
signal p_rqst_fifo_empty_n : std_logic:= '0';
signal rq_wr_count       : std_logic_vector(9 downto 0)  := (others => '0');
--------------------------------------------------------------------------------

begin

buffer_rd_rqst_ready <= '1';

process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      t1_axis_aresetn <= axis_aresetn; 
      t1_buffer_rd_rqst_valid <= buffer_rd_rqst_valid; 
      dest_addr <= buffer_rd_rqst_data(95 downto 64);
      length    <= buffer_rd_rqst_data(127 downto 96);
   end if;
end process;    

--------------------------------------------------------------------------------
-- Width Conversion
--------------------------------------------------------------------------------
-- Convert data stream to the 512-bit width of DDR4 Request interface
wc_inst : px_dma_pcie2ddr_wc
  PORT MAP (
    aclk           => axis_aclk,
    aresetn        => inout_fifo_rst_n,
    s_axis_tvalid  => s_axis_rcv_buf_tvalid,
    s_axis_tready  => s_axis_rcv_buf_tready,
    s_axis_tdata   => s_axis_rcv_buf_tdata,
    s_axis_tkeep   => s_axis_rcv_buf_tuser, --s_axis_rcv_buf_tkeep,
    s_axis_tlast   => s_axis_rcv_buf_tlast,
    m_axis_tvalid  => wc_axis_tvalid,
    m_axis_tready  => wc_axis_tready,
    m_axis_tdata   => wc_axis_tdata,
    m_axis_tkeep   => wc_axis_tkeep,
    m_axis_tlast   => wc_axis_tlast
);

--------------------------------------------------------------------------------
-- Input FIFO AXI-S 
--------------------------------------------------------------------------------

in_fifo_inst : px_dma_pcie2ddr_win_fifo
port map (
    s_aclk          => axis_aclk,
    s_aresetn       => inout_fifo_rst_n,
    s_axis_tvalid   => wc_axis_tvalid,  
    s_axis_tready   => wc_axis_tready,  
    s_axis_tdata    => wc_axis_tdata,   
    s_axis_tkeep    => wc_axis_tkeep,   
    s_axis_tlast    => wc_axis_tlast,    
    m_axis_tvalid   => in_fifo_tvalid,
    m_axis_tready   => in_fifo_tready,
    m_axis_tdata    => in_fifo_tdata,
    m_axis_tkeep    => in_fifo_tkeep,
    m_axis_tlast    => in_fifo_tlast,    
    axis_prog_empty => in_fifo_prog_empty
);
--------------------------------------------------------------------------------
-- Write Request Logic
--------------------------------------------------------------------------------
   
-- Count the number of consecutive accesses
process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      t1_axis_aresetn  <= axis_aresetn; 
      t1_conseq_access <= conseq_access; 
      if (inout_fifo_rst_n= '0') or (t1_axis_aresetn = '0') or (wr_access_cntr = t1_conseq_access) or (t1_buffer_rd_rqst_valid = '1') then
         wr_access_cntr <= "000000"; 
      elsif (in_fifo_tvalid = '1') and (in_fifo_tready = '1') then   
         wr_access_cntr <= wr_access_cntr + 1;
      end if;   
   end if;
end process;    

--------------------------------------------------------------------------------
-- Construct DDR4 Write Requests
-------------------------------------------------------------------------------- 

    -- tuser[127:0]   = Request Header
    -- tuser[31:0]    = Address (Address must be aligned to the request size boundaries)
    -- tuser[34:32]   = Future Address Expansion
    -- tuser[35]      = Read = 1, Write = 0
    -- tuser[39:36]   = Reserved
    -- tuser[119:40]  = Byte Masks
    -- tuser[255:128] = Upper 128-bits of RAM Data 
    
    wr_tvalid                <= in_fifo_tvalid or rst_wr_tvalid;   
    wr_tdata                 <= in_fifo_tdata;
    wr_tuser(31 downto 0)    <= wr_addr;
    wr_tuser(34 downto 32)   <= "000";
    wr_tuser(35)             <= '0'; -- write
    wr_tuser(39 downto 36)   <= "0000";
    wr_tuser(119 downto 40)  <= x"FFFF" & (not(in_fifo_tkeep));  -- Byte Masks
    wr_tuser(255 downto 120) <= (others => '0');
    wr_tlast <= '1' when ((in_fifo_prog_empty = '1') or (wr_access_cntr = conseq_access) or (rst_wr_tlast = '1')) else '0';  
    
    in_fifo_tready <= wr_tready; 
      
    m_axis_rqst_tid <= x"00"; -- ID Doesn't matter since we are only generating write requests and do not get responses back
    
--------------------------------------------------------------------------------
-- Counters
--------------------------------------------------------------------------------

    -- Write Address Counter
    process(axis_aclk)
    begin
       if rising_edge(axis_aclk) then
          if (inout_fifo_rst_n = '0') or (t1_axis_aresetn = '0') or  (t1_buffer_rd_rqst_valid = '1') then
             wr_addr(31 downto 6)    <= dest_addr(31 downto 6); -- destination address   
          elsif (wr_inc = '1') then
             wr_addr(31 downto 6)    <= wr_addr(31 downto 6) + 1;   
          end if;
       end if;
    end process;   
    
    wr_addr(5 downto 0)      <= "000000";
   
    wr_inc <= in_fifo_tready and in_fifo_tvalid;
    
    -- Write Counter
    process(axis_aclk)
    begin
       if rising_edge(axis_aclk) then
          if (inout_fifo_rst_n = '0') or (t1_axis_aresetn = '0') or (t1_buffer_rd_rqst_valid = '1') then
             wr_count <= ("000" & x"000000"); 
          elsif (wr_inc = '1') then
             wr_count <= wr_count + 1;
          end if;
       end if;
    end process;   
    
    process(axis_aclk)
    begin
       if rising_edge(axis_aclk) then
          if (inout_fifo_rst_n = '0') or (t1_axis_aresetn = '0')  or (t1_buffer_rd_rqst_valid = '1') then
            t1_length <= length;
          end if;
          if (inout_fifo_rst_n = '0') or (t1_axis_aresetn = '0')  or (t1_buffer_rd_rqst_valid = '1') then
             p_count_reached  <= '0'; 
          elsif (wr_count >= ('0' & t1_length(31 downto 6))) and (atleast_one = '1') then
             p_count_reached  <= '1';
          end if;
          if (inout_fifo_rst_n = '0') or (t1_axis_aresetn = '0')  or (t1_buffer_rd_rqst_valid = '1') then
             atleast_one <= '0';
          elsif (wr_inc = '1') then
             atleast_one <= '1';
          end if;
          all_rqst_complete   <= p_count_reached; -- All requests have been generated
          if (p_count_reached = '1') and (rq_wr_count(9 downto 2) = "00000000") then
            all_wr_complete     <= '1';
          else
            all_wr_complete     <= '0';
          end if;  
       end if;
    end process;   

-----------------------------------------------------------------------------------------------------
-- DDR Write Request Output FIFO
-----------------------------------------------------------------------------------------------------

wrq_fifo_inst : px_dma_pcie2ddr_wrq_fifo
port map (
    s_aclk                        => axis_aclk,
    s_aresetn                     => inout_fifo_rst_n,
    m_aclk                        => axis_ddr_aclk,
    s_axis_tvalid                 => wr_tvalid,
    s_axis_tready                 => wr_tready,
    s_axis_tdata                  => wr_tdata,
    s_axis_tlast                  => wr_tlast,
    s_axis_tuser                  => wr_tuser(127 downto 0),
    m_axis_tvalid                 => m_axis_rqst_tvalid_int,
    m_axis_tready                 => m_axis_rqst_tready,
    m_axis_tdata                  => m_axis_rqst_tdata,
    m_axis_tlast                  => m_axis_rqst_tlast,
    m_axis_tuser                  => m_axis_rqst_tuser(127 downto 0),
    axis_wr_data_count            => rq_wr_count,
    axis_rd_data_count            => open,
    axis_prog_full                => afl
  );
 
m_axis_rqst_tvalid <= m_axis_rqst_tvalid_int;  
m_axis_rqst_tuser(255 downto 128) <= (others => '0'); 


xpm_cdc_emp_inst: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 3, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => axis_ddr_aclk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => m_axis_rqst_tvalid_int,
     dest_clk => axis_aclk,
     dest_out => p_rqst_fifo_empty_n
  );

    
-- FIFO Flush State Machine
process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
     rqst_fifo_empty <= not p_rqst_fifo_empty_n;
     t1_fifo_flush   <= fifo_flush;
     t1_abort        <= abort;
     rqst_fifo_afl   <= afl;
     if (t1_axis_aresetn = '0') then
        inout_fifo_rst <= '1';
        state          <=  reset_state;
        rst_wr_tvalid  <= '0';
        rst_wr_tlast   <= '0';
        rst_cntr       <= "00000";  
        mid_packet_w   <= '0';  
        abort_busy     <= '0'; 
     else
        if (wr_tvalid = '1') and (wr_tready = '1') and (wr_tlast = '0') then
           mid_packet_w <= '1';
        elsif (wr_tvalid = '1') and (wr_tready = '1') and (wr_tlast = '1') then
           mid_packet_w <= '0';
        end if;   
        case state is
            when reset_state =>
                inout_fifo_rst <= '0'; 
                rst_cntr       <= "00000";
                if (t1_fifo_flush = '1') or (t1_abort = '1') then
                    state      <= suppress_state;
                    abort_busy <= t1_abort; 
                else    
                    state      <=  reset_state;
                end if;
            when suppress_state =>
                if (mid_packet_w = '1') and not ((wr_tlast = '1') and (wr_tready = '1') and (wr_tvalid= '1')) then
                   state    <= issue_w_tlast_state;
                   rst_wr_tvalid <= '1';
                   rst_wr_tlast  <= '1'; 
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
            when reset_fifo_state =>
                rst_cntr <= rst_cntr + 1;
                if rst_cntr = "11111" then
                    state <= wait_reset_over_state;
                end if;
            when wait_reset_over_state =>
                if (t1_fifo_flush = '0') then
                   inout_fifo_rst <= '0'; 
                   state <= reset_state;
                   abort_busy     <= '0'; 
                end if;    
            when others =>
               state <= reset_state;
        end case;  
     end if;   
     inout_fifo_rst_n <= not inout_fifo_rst;     
   end if;
end process;   

end Behavioral;
