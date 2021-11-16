----------------------------------------------------------------------------------
-- Pentek PPLD Data Stream to AXI DMA - Data Stream Reader State Machine
----------------------------------------------------------------------------------
-- px_dma_ppld2axi_reader.vhd
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

-- Additional Comments: 
--  
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_dma_ppld2axi_reader is
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
    fifo_flush                   : in  std_logic;
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
end px_dma_ppld2axi_reader;

architecture Behavioral of px_dma_ppld2axi_reader is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

COMPONENT px_dma_ppld2axi_fifo
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
    axis_prog_full : OUT STD_LOGIC
  );
END COMPONENT;

-------------------------------------------------------------------------------
-- Types
-------------------------------------------------------------------------------

type sm_type is (
   RESET_STATE,
   ACCEPT_READ_REQUEST_STATE,
   LOAD_CNTR_STATE,
   CHECK_LEFTOVER_STATE,
   LATCH_TS_STATE,
   POP_SOP_STATE,
   READ_STATE,
   READ_SOP_STATE,
   EOP_STATE,
   META_STATE,
   AFL_STATE,
   END_STATE
); 

type stat_state_type is (
   RESET_STATE,
   WAIT_STAT_STATE
); 

type abort_state_type is (
   RESET_STATE,
   ABORT_BUSY_STATE,
   HALT_MOVER_STATE,
   FIFO_FLUSH_STATE,
   FIFO_FLUSH_STATE1,
   FIFO_FLUSH_STATE2,
   FIFO_FLUSH_STATE3
);
-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal int_abort_busy            : std_logic := '0';
signal t1_abort                  : std_logic := '0';
signal t2_abort                  : std_logic := '0';
signal abort_re                  : std_logic := '0';
signal in_sm_abort_safe          : std_logic := '0';
signal t1_rst                    : std_logic := '0';
signal t2_rst                    : std_logic := '0';
signal t3_rst                    : std_logic := '0';
signal state                     : sm_type := RESET_STATE; 
signal buffer_rd_rqst_ready_int  : std_logic := '0';
signal out_sm_abort_safe         : std_logic := '0';
signal dest_start_address        : std_logic_vector(63 downto 0) := (others => '0');
signal dest_meta_address         : std_logic_vector(63 downto 0) := (others => '0');
signal buf_size                  : std_logic_vector(31 downto 0) := (others => '0');
signal wr_meta                   : std_logic := '0';   
signal dest_addr_cntr            : std_logic_vector(61 downto 0):= (others => '0');
signal dest_meta_addr_cntr       : std_logic_vector(61 downto 0):= (others => '0');
signal actual_cntr               : std_logic_vector(29 downto 0):= (others => '0');
signal data_buf_cntr             : std_logic_vector(29 downto 0):= (others => '0');
signal l_data_buf_cntr           : std_logic_vector(29 downto 0):= (others => '0');
signal strt_tuser                : std_logic_vector(75 downto 0):= (others => '0');
signal first_is_sop              : std_logic := '0';
signal last_is_eop               : std_logic := '0'; 
signal p_buffer_rd_complete      : std_logic := '0';    
signal meta_cntr                 : std_logic_vector(11 downto 0):= (others => '0');
signal l_s_axis_ppld_tuser       : std_logic_vector(11 downto 0):= (others => '0');
signal out_fifo_afl              : std_logic := '0';  
signal t1_out_fifo_afl           : std_logic := '0';  
signal axi_type                  : std_logic := '0';  
signal tag_cntr                  : std_logic_vector(3 downto 0) := x"0";
signal eop_enable                : std_logic := '0';   
signal last_tag_val              : std_logic_vector(3 downto 0) := x"0";
signal last_tag                  : std_logic := '0';
signal stat_state                : stat_state_type := RESET_STATE;
signal xfer_cmplt                : std_logic := '0';
signal error_abort               : std_logic := '0';
signal m_axis_str_tvalid         : std_logic := '0';
signal m_axis_str_tlast          : std_logic := '0';
signal m_axis_str_tdata          : std_logic_vector(511 downto 0):= (others => '0');
signal m_axis_str_tkeep          : std_logic_vector(63 downto 0):= (others => '0');
signal abort_state               : abort_state_type := RESET_STATE;
signal fifo_aresetn              : std_logic := '0';
signal halt_countdown            : std_logic_vector(15 downto 0) := x"0000";
signal axis_s2mm_cmd_tvalid      : std_logic := '0';
signal axis_s2mm_cmd_tready      : std_logic := '0';
signal axis_s2mm_cmd_tdata       : std_logic_vector(103 downto 0):= (others => '0');
signal axi_s2mm_aresetn          : std_logic := '0';
signal almost_full_cmd           : std_logic := '0';

--------------------------------------------------------------------------------

begin

buffer_rd_rqst_ready <= buffer_rd_rqst_ready_int;
 
--------------------------------------------------------------------------------
-- Abort
--------------------------------------------------------------------------------

abort_re <= t1_abort and not t2_abort;

external_fifo_rstn <= fifo_aresetn;

m_axi_s2mm_aresetn <= axi_s2mm_aresetn;

process(aclk)
begin
   if rising_edge(aclk) then
      t1_abort       <= abort;
      t2_abort       <= t1_abort;
      abort_busy     <= int_abort_busy; 
      if (t1_rst = '1') or (t2_rst = '1') or (t3_rst = '1') or (fifo_flush = '1') then
         abort_state      <= RESET_STATE;
         int_abort_busy   <= '0';
         fifo_aresetn     <= '0';
         axi_s2mm_aresetn <= '0';  
         s2mm_halt        <= '0';
         halt_countdown   <= x"FFFF";
      else      
         case abort_state is
            -- Reset State
            when RESET_STATE =>
               if (abort_re = '1') or (error_abort = '1') then
                  abort_state             <= ABORT_BUSY_STATE;
                  int_abort_busy          <= '1';
               else
                  abort_state             <= RESET_STATE;
                  int_abort_busy          <= '0';
               end if;
               fifo_aresetn     <= '1';
               axi_s2mm_aresetn <= '1';
               s2mm_halt        <= '0';  
               halt_countdown <= x"FFFF";
            when ABORT_BUSY_STATE =>
               if (in_sm_abort_safe = '1') or (halt_countdown = 0) then
                  abort_state          <= HALT_MOVER_STATE;
                  s2mm_halt            <= '1';
                  halt_countdown       <= x"FFFF";
               else
                  halt_countdown <= halt_countdown - 1;  
                  abort_state    <= ABORT_BUSY_STATE;
               end if;
            when HALT_MOVER_STATE =>
               if (s2mm_halt_cmplt = '1') or (halt_countdown = 0) then
                  abort_state          <= FIFO_FLUSH_STATE;
                  fifo_aresetn         <= '0';
                  s2mm_halt            <= '0';
               end if;  
               halt_countdown <= halt_countdown - 1;             
            when FIFO_FLUSH_STATE =>   
               abort_state             <= FIFO_FLUSH_STATE1;
            when FIFO_FLUSH_STATE1 =>   
               abort_state             <= FIFO_FLUSH_STATE2;
               axi_s2mm_aresetn <= '0';  
            when FIFO_FLUSH_STATE2 =>   
               abort_state             <= FIFO_FLUSH_STATE3;
            when FIFO_FLUSH_STATE3 =>   
               abort_state             <= RESET_STATE; 
               fifo_aresetn      <= '1';
               axi_s2mm_aresetn  <= '1';                               
            when others =>
               abort_state <= RESET_STATE;
          end case;       
       end if;      
    end if;
 end process;


    
-------------------------------------------------------------------------------
-- Read Request State Machine
-------------------------------------------------------------------------------
process(aclk)
begin
   if rising_edge(aclk) then
      t1_rst     <= not aresetn;
      t2_rst     <= t1_rst; 
      t3_rst     <= t2_rst;
      t1_out_fifo_afl <= out_fifo_afl;     
      if (t1_rst = '1') or (t2_rst = '1') or (t3_rst = '1') then
         state                  <= RESET_STATE;
         eop_reached            <= '0';
         actual_bytes(31 downto 2)  <= (others => '0');
         actual_bytes_valid     <= '0';
         p_buffer_rd_complete     <= '0'; 
         buffer_rd_rqst_ready_int <= '0';  
         m_axis_str_tvalid      <= '0';
         in_sm_abort_safe       <= '1'; 
         s_axis_ppld_tready     <= '0';
         meta_cntr              <= x"000";
         last_is_eop            <= '0';
         first_is_sop           <= '0';
         tag_cntr               <= "0000";
         last_tag_val           <= "0000";
         last_tag               <= '0';
         axis_s2mm_cmd_tvalid <= '0';
      else      
         case state is
      -- Reset State
            when RESET_STATE =>
               -- Start if there is a Buffer Read Request and no abort
               if (buffer_rd_rqst_valid = '1') and (int_abort_busy = '0') then  
                  state <= ACCEPT_READ_REQUEST_STATE;
                  buffer_rd_rqst_ready_int <= '1';
                  in_sm_abort_safe         <= '0'; 
               -- Otherwise, wait here.   
               else
                  state <= RESET_STATE;
                  buffer_rd_rqst_ready_int <= '0';
                  in_sm_abort_safe         <= '1'; 
               end if;          
               eop_reached            <= '0';
               actual_bytes_valid     <= '0';  
               actual_bytes(31 downto 2)  <= (others => '0');
               p_buffer_rd_complete   <= '0';
               m_axis_str_tvalid <= '0';
               s_axis_ppld_tready     <= '0';
               last_is_eop            <= '0';
               first_is_sop           <= '0';
               tag_cntr               <= "0000";
               last_tag_val           <= "0000";
               last_tag               <= '0';
               axis_s2mm_cmd_tvalid <= '0';
            ----------------------------------------------
            -- Read the Data Buffer Size
            ----------------------------------------------  
            when ACCEPT_READ_REQUEST_STATE =>
               state <= LOAD_CNTR_STATE;
               buffer_rd_rqst_ready_int <= '0';
               -- buffer_rd_rqst_data[63:0]    = Destination Start Address -- PCIe Address -- Address must be on 4 byte address boundary
               -- buffer_rd_rqst_data[127:64]  = Destination Meta Start Address  -- Address must be on 4 byte address boundary
               -- buffer_rd_rqst_data[159:128] = Size in bytes
               -- buffer_rd_rqst_data[160]     = Write Meta Data
               -- buffer_rd_rqst_data[161]     = INCR AXI Type 
               -- buffer_rd_rqst_data[162]     = Reserved
               -- buffer_rd_rqst_data[163]     = Allow end on EOF      
               -- buffer_rd_rqst_data[167:164] = Reserved
               dest_start_address       <= buffer_rd_rqst_data(63 downto 0);     -- Destination Start Address 
               dest_meta_address        <= buffer_rd_rqst_data(127 downto 64);   -- Destination Meta Address 
               buf_size                 <= buffer_rd_rqst_data(159 downto 130) & "00";  -- Size in bytes (Must be a multiple of max payload size)
               wr_meta                  <= buffer_rd_rqst_data(160);             -- Write Meta Data
               axi_type                 <= buffer_rd_rqst_data(161);             -- AXI Type 0 = Fixed, 1 = INCR
               eop_enable               <= buffer_rd_rqst_data(163);             -- EOP end enable
            ----------------------------------------------
            -- Load Counter State
            ----------------------------------------------  
            when LOAD_CNTR_STATE =>  
               dest_addr_cntr           <= dest_start_address(63 downto 2); -- Load the start address (in Words)
               dest_meta_addr_cntr      <= dest_meta_address(63 downto 2);
               actual_cntr              <= (others => '0');
               data_buf_cntr            <= buf_size(31 downto 2);
               if (t1_out_fifo_afl = '1') then -- Don't start if next-stage FIFO is almost full
                  state                 <= LOAD_CNTR_STATE;
               else
                  state                 <= LATCH_TS_STATE;
               end if;     
            ----------------------------------------------
            -- LATCH TS STATE
            ----------------------------------------------  
            when LATCH_TS_STATE =>  
               m_axis_str_tvalid <= '0';
               if (int_abort_busy = '1') then
                  state  <= RESET_STATE;
               elsif (s_axis_ppld_tvalid = '1') and (axis_s2mm_cmd_tready = '1') and (almost_full_cmd = '0') then
                  if (s_axis_ppld_tuser(64)='1') then
                     state       <= READ_SOP_STATE;
                     strt_tuser  <= s_axis_ppld_tuser(75 downto 0); -- Save Tuser from first data word in transfer (Timestamp Info)
                  else
                     state <= POP_SOP_STATE;  
                  end if;
                  s_axis_ppld_tready   <= '1';
               else
                  state  <= LATCH_TS_STATE;  
               end if;   
               first_is_sop            <=  s_axis_ppld_tuser(78);  -- Start of Acq.      
            ----------------------------------------------
            -- Pop until SOP State
            ----------------------------------------------
            when POP_SOP_STATE => 
               s_axis_ppld_tready   <= '0';      
               state <= LATCH_TS_STATE;        
            ----------------------------------------------
            -- Read First Word of Payload State
            ----------------------------------------------
            when READ_SOP_STATE =>
               if (int_abort_busy = '1') then
                  state  <= RESET_STATE;
               elsif (s_axis_ppld_tvalid = '1') and (s_axis_ppld_tuser(64)='1') then -- data is available and is in fact SOP and room for a command
                  -------------------------------------------------------------------
                  -- Output Write Request to Data Mover
                  -------------------------------------------------------------------
                  tag_cntr                            <= tag_cntr + 1;
                  last_tag_val                        <= tag_cntr;
                  axis_s2mm_cmd_tvalid <= '1';
                  axis_s2mm_cmd_tdata(23)           <= axi_type; -- [23] Type
                  axis_s2mm_cmd_tdata(29 downto 24) <= "000000"; -- [29:24] DSA - not used
                  axis_s2mm_cmd_tdata(30)           <= '1'; -- [30] EOF
                  axis_s2mm_cmd_tdata(31)           <= '0'; -- [31] DRR
                  axis_s2mm_cmd_tdata(95 downto 32) <= dest_addr_cntr & "00"; -- Destination Address 
                  axis_s2mm_cmd_tdata(99 downto 96) <= tag_cntr; -- TAG
                  axis_s2mm_cmd_tdata(103 downto 100) <= "0000";

                  m_axis_str_tdata <= s_axis_ppld_tdata;
                  m_axis_str_tkeep <= s_axis_ppld_tkeep;
                  m_axis_str_tlast <= s_axis_ppld_tlast;
                  if s_axis_ppld_tuser(93 downto 82) /= "000000000000" then
                    axis_s2mm_cmd_tdata(22 downto 0)  <= "000000000" & s_axis_ppld_tuser(93 downto 80); -- [22:0] Bytes to Transfer
                    if axi_type = '1' then
                      dest_addr_cntr(29 downto 0)<= dest_addr_cntr(29 downto 0) + ("000000000000000000" & s_axis_ppld_tuser(93 downto 82));
                    end if;  
                    actual_cntr                <= actual_cntr                 + ("000000000000000000" & s_axis_ppld_tuser(93 downto 82));
                    data_buf_cntr              <= data_buf_cntr               - ("000000000000000000" & s_axis_ppld_tuser(93 downto 82));
                  else
                    axis_s2mm_cmd_tdata(22 downto 0)  <= "00000000000000000000100" ; -- [22:0] Bytes to Transfer
                    if axi_type = '1' then
                       dest_addr_cntr(29 downto 0)<= dest_addr_cntr(29 downto 0) + 1;
                    end if;    
                    actual_cntr                <= actual_cntr                 + 1; 
                    data_buf_cntr              <= data_buf_cntr               - 1; 
                  end if;    
                  m_axis_str_tvalid    <= '1';
                  l_s_axis_ppld_tuser      <= s_axis_ppld_tuser(93 downto 82);
                  l_data_buf_cntr          <= data_buf_cntr;
                  if s_axis_ppld_tlast = '1' then -- Is end of Packet Payload
                     if s_axis_ppld_tuser(93 downto 82) /= "000000000000" then
                        if ((data_buf_cntr <= ("000000000000000000" & s_axis_ppld_tuser(93 downto 82)))) or ((s_axis_ppld_tuser(79) = '1') and (eop_enable = '1')) then -- buffer read complete
                           state                <= EOP_STATE; -- finish
                           s_axis_ppld_tready   <= '0';   
                           last_is_eop          <= s_axis_ppld_tuser(79);  
                        elsif (t1_out_fifo_afl = '0') and (axis_s2mm_cmd_tready = '1') and (almost_full_cmd = '0') then       
                           state                <= READ_SOP_STATE; -- Get next packet
                        else
                           state                <= AFL_STATE;
                           s_axis_ppld_tready   <= '0';  
                        end if;
                     else
                        if (data_buf_cntr = 1) or ((s_axis_ppld_tuser(79) = '1') and (eop_enable = '1')) then -- buffer read complete
                           state                <= EOP_STATE; -- finish
                           s_axis_ppld_tready   <= '0'; 
                           last_is_eop          <= s_axis_ppld_tuser(79);    
                        elsif (t1_out_fifo_afl = '0') and (axis_s2mm_cmd_tready = '1') and (almost_full_cmd = '0') then       
                           state                <= READ_SOP_STATE; -- Get next packet
                        else
                           state                <= AFL_STATE;
                           s_axis_ppld_tready   <= '0'; 
                        end if;
                     end if; 
                  else
                     state                   <= READ_STATE; -- Get rest of packet   
                  end if;   
               elsif (t1_out_fifo_afl = '0') and (axis_s2mm_cmd_tready = '1') and (almost_full_cmd = '0') then       
                  state                      <= READ_SOP_STATE; -- Get next packet
                  m_axis_str_tvalid          <= '0';
                  axis_s2mm_cmd_tvalid       <= '0';
               else
                  state                      <= AFL_STATE;
                  m_axis_str_tvalid          <= '0';
                  s_axis_ppld_tready         <= '0';
                  axis_s2mm_cmd_tvalid       <= '0';  
               end if;
            ----------------------------------------------
            -- Read First Word of Payload State
            ----------------------------------------------
            when READ_STATE =>
               axis_s2mm_cmd_tvalid <= '0';
               if (s_axis_ppld_tvalid = '1') then -- data is available 
                  m_axis_str_tdata             <= s_axis_ppld_tdata;
                  m_axis_str_tlast             <= s_axis_ppld_tlast;
                  m_axis_str_tkeep             <= s_axis_ppld_tkeep;
                  m_axis_str_tvalid    <= '1'; 
                  if s_axis_ppld_tlast = '1' then -- Is end of Packet Payload
                    if l_s_axis_ppld_tuser /= "000000000000" then
                       if (l_data_buf_cntr <= ("000000000000000000" & l_s_axis_ppld_tuser)) or ((s_axis_ppld_tuser(79) = '1') and (eop_enable = '1')) then -- buffer read complete
                          state                <= EOP_STATE; -- finish
                          s_axis_ppld_tready   <= '0';    
                          last_is_eop          <= s_axis_ppld_tuser(79);
                       elsif (t1_out_fifo_afl = '0') and (axis_s2mm_cmd_tready = '1') and (almost_full_cmd = '0') then        
                          state                <= READ_SOP_STATE; -- Get next packet
                       else
                          state                <= AFL_STATE;
                          s_axis_ppld_tready   <= '0';  
                       end if;
                    else
                       if (l_data_buf_cntr = 1)  or ((s_axis_ppld_tuser(79) = '1') and (eop_enable = '1')) then -- buffer read complete
                          state                <= EOP_STATE; -- finish
                          s_axis_ppld_tready   <= '0';   
                          last_is_eop          <= s_axis_ppld_tuser(79);  
                       elsif (t1_out_fifo_afl = '0') and (axis_s2mm_cmd_tready = '1') and (almost_full_cmd = '0') then        
                          state                <= READ_SOP_STATE; -- Get next packet
                       else
                          state                <= AFL_STATE;
                          s_axis_ppld_tready   <= '0';  
                       end if;
                    end if; 
                  else
                     state                     <= READ_STATE; -- Get rest of packet  
                  end if;   
               else
                  state                        <= READ_STATE; -- try again
                  m_axis_str_tvalid            <= '0';
               end if;
           ----------------------------------------------
           -- End of Packet Reached
           ----------------------------------------------   
           when EOP_STATE =>  
             axis_s2mm_cmd_tvalid <= '0';
             m_axis_str_tvalid      <= '0';
             if wr_meta = '1' then
                state                 <= META_STATE;
                last_tag              <= '0';
             else
                state                 <= END_STATE;
                last_tag              <= '1';
             end if;  
           ----------------------------------------------
           -- Meta Data Packet State
           ----------------------------------------------
           when META_STATE => 
               if (axis_s2mm_cmd_tready = '1') and (almost_full_cmd = '0') then
                  tag_cntr <= tag_cntr + 1;
                  axis_s2mm_cmd_tvalid <= '1';
                  axis_s2mm_cmd_tdata(22 downto 0)  <= "0000000" & x"0010"; -- [22:0] Bytes to Transfer =16
                  axis_s2mm_cmd_tdata(23)           <= axi_type; -- [23] Type
                  axis_s2mm_cmd_tdata(29 downto 24) <= "000000"; -- [29:24] DSA - not used
                  axis_s2mm_cmd_tdata(30)           <= '1'; -- [30] EOF
                  axis_s2mm_cmd_tdata(31)           <= '0'; -- [31] DRR
                  axis_s2mm_cmd_tdata(95 downto 32) <= dest_meta_addr_cntr & "00"; -- Destination Address
                  axis_s2mm_cmd_tdata(99 downto 96) <= tag_cntr; -- TAG
                  axis_s2mm_cmd_tdata(103 downto 100) <= "0000";
              
                  -- Meta Data Packet           
                  m_axis_str_tdata(63 downto 0) <= strt_tuser(63 downto 0); -- Timestamp
                  m_axis_str_tdata(95 downto 64)<= actual_cntr & "00"; -- Number of Valid Bytes
                  m_axis_str_tdata(99 downto 96)  <= "0000";
                  m_axis_str_tdata(111 downto 100) <= meta_cntr;
                  m_axis_str_tdata(119 downto 112)<= strt_tuser(75 downto 68); -- Channel Number
                  m_axis_str_tdata(121 downto 120)<= strt_tuser(66 downto 65); -- Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
                  m_axis_str_tdata(122)           <= strt_tuser(67);
                  m_axis_str_tdata(123)           <= '0';
                  m_axis_str_tdata(124)           <= first_is_sop;  
                  m_axis_str_tdata(125)           <= last_is_eop;
                  m_axis_str_tdata(127 downto 126)<= "00";
                  m_axis_str_tdata(511 downto 128)<= (others => '0');
                  m_axis_str_tlast                <= '1';
                  m_axis_str_tkeep                <= x"000000000000FFFF";
                  m_axis_str_tvalid               <= '1';
                  meta_cntr                       <= meta_cntr + 1;
                  state                           <= END_STATE;    
                  last_tag_val                    <= tag_cntr;
                  last_tag                        <= '1';              
               end if;
           ----------------------------------------------
           -- Output FIFO AFL State
           ----------------------------------------------
           when AFL_STATE =>
              axis_s2mm_cmd_tvalid <= '0';
              -- Stay here if Almost Full
              m_axis_str_tvalid     <= '0';
              if  (t1_out_fifo_afl = '1') or (axis_s2mm_cmd_tready = '0') or (almost_full_cmd = '1') then
                 state                 <= AFL_STATE;
                 s_axis_ppld_tready    <= '0';  
              else
                 state                 <= READ_SOP_STATE;
                 s_axis_ppld_tready    <= '1';    
              end if;
           ----------------------------------------------
           -- End State
           ----------------------------------------------
           when END_STATE =>
              axis_s2mm_cmd_tvalid <= '0';
              m_axis_str_tvalid <= '0';
              if xfer_cmplt = '1' then
                  state                 <= RESET_STATE; -- Start Over
                  p_buffer_rd_complete  <= '1';
                  actual_bytes(31 downto 2)  <= actual_cntr;
                  actual_bytes_valid    <= '1';
                  eop_reached           <= last_is_eop;
              end if;
           when others =>
              state <= RESET_STATE;
         end case;       
      end if;      
   end if;
end process;

actual_bytes(1 downto 0)  <= "00";


process(aclk)
begin
   if rising_edge(aclk) then
      buffer_rd_complete    <= p_buffer_rd_complete;
   end if;
end process;      

--------------------------------------------------------------------
-- Status State Machine
--------------------------------------------------------------------

process(aclk)
begin
   if rising_edge(aclk) then  
      if (t1_rst = '1') then
         s_axis_s2mm_sts_tready <= '0';
         stat_state  <= RESET_STATE;
         xfer_cmplt  <= '0';
         error_irq   <= '0';
         error_abort <= '0';
         xfr_error       <= "000";
      else      
         case stat_state is
      -- Reset State
            when RESET_STATE =>
                  s_axis_s2mm_sts_tready <= '1';
                  stat_state             <= WAIT_STAT_STATE;
                  xfer_cmplt             <= '0';
                  error_irq              <= '0';
                  error_abort            <= '0';
                  xfr_error                  <= "000";
            when WAIT_STAT_STATE =>
               if (s_axis_s2mm_sts_tvalid = '1') or (s2mm_err = '1') then
                  xfr_error(0)       <= s_axis_s2mm_sts_tdata(4);
                  xfr_error(1)       <= s_axis_s2mm_sts_tdata(5);
                  xfr_error(2)       <= s_axis_s2mm_sts_tdata(6);  
                  if  (s_axis_s2mm_sts_tdata(7) = '0') or (s2mm_err = '1') then -- Error was detected in transfer. End and abort
                     xfer_cmplt  <= '1';
                     error_irq   <= '1';
                     error_abort <= '1';
                     stat_state  <= RESET_STATE;
                  elsif (last_tag = '1') and (last_tag_val = s_axis_s2mm_sts_tdata(3 downto 0)) then -- Found completion of last tag
                     xfer_cmplt  <= '1';
                     stat_state  <= RESET_STATE;
                     error_irq   <= '0';
                     error_abort <= '0';
                  else
                     xfer_cmplt  <= '0';
                     stat_state  <= WAIT_STAT_STATE;
                     error_irq   <= '0';
                     error_abort <= '0';
                  end if;                  
               end if;
            when others =>
               stat_state <= RESET_STATE;
          end case;       
       end if;      
    end if;
 end process;

--------------------------------------------------------------------------------
-- Extra Command FIFO buffering
--------------------------------------------------------------------------------
 
cmd_fifo_inst : xpm_fifo_axis
 generic map (
    CDC_SYNC_STAGES => 2,            -- DECIMAL
    CLOCKING_MODE => "common_clock", -- String
    ECC_MODE => "no_ecc",            -- String
    FIFO_DEPTH => 32,              -- DECIMAL
    FIFO_MEMORY_TYPE => "distributed", -- String
    PACKET_FIFO => "false",          -- String
    PROG_EMPTY_THRESH => 10,         -- DECIMAL
    PROG_FULL_THRESH => 26,          -- DECIMAL
    RD_DATA_COUNT_WIDTH => 1,        -- DECIMAL
    RELATED_CLOCKS => 0,             -- DECIMAL
    TDATA_WIDTH => 104,               -- DECIMAL
    TDEST_WIDTH => 1,                -- DECIMAL
    TID_WIDTH => 1,                  -- DECIMAL
    TUSER_WIDTH => 1,                -- DECIMAL
    USE_ADV_FEATURES => "1002",      -- String
    WR_DATA_COUNT_WIDTH => 1         -- DECIMAL
 )
 port map (
    almost_empty_axis => open,   
    almost_full_axis => open,     
    dbiterr_axis => open,             
    m_axis_tdata => m_axis_s2mm_cmd_tdata,             
    m_axis_tdest => open,             
    m_axis_tid => open,                 
    m_axis_tkeep => open,             
    m_axis_tlast => open,             
    m_axis_tstrb => open,             
    m_axis_tuser => open,             
    m_axis_tvalid => m_axis_s2mm_cmd_tvalid,           
    prog_empty_axis => open,       
    prog_full_axis => almost_full_cmd,         
    rd_data_count_axis => open, 
    s_axis_tready => axis_s2mm_cmd_tready,           
    sbiterr_axis => open,             
    wr_data_count_axis => open, 
    injectdbiterr_axis => '0', 
    injectsbiterr_axis => '0', 
    m_aclk => aclk,                         
    m_axis_tready => m_axis_s2mm_cmd_tready,           
    s_aclk => aclk,                         
    s_aresetn => axi_s2mm_aresetn,                   
    s_axis_tdata => axis_s2mm_cmd_tdata,             
    s_axis_tdest => "0",            
    s_axis_tid => "0",                 
    s_axis_tkeep => "1111111111111",             
    s_axis_tlast => '0',             
    s_axis_tstrb => "1111111111111",             
    s_axis_tuser => "0",             
    s_axis_tvalid => axis_s2mm_cmd_tvalid           
 );
  
 
 ------------------------------------------------------------------------------------------
 -- AXI-Stream FIFO
 ------------------------------------------------------------------------------------------

fifo_inst : px_dma_ppld2axi_fifo
  PORT MAP (
    s_aclk        => aclk,
    s_aresetn     => fifo_aresetn,
    s_axis_tvalid => m_axis_str_tvalid,
    s_axis_tready => open,
    s_axis_tdata  => m_axis_str_tdata,
    s_axis_tkeep  => m_axis_str_tkeep,
    s_axis_tlast  => m_axis_str_tlast,
    m_axis_tvalid => m_axis_s2mm_tvalid,
    m_axis_tready => m_axis_s2mm_tready,
    m_axis_tdata  => m_axis_s2mm_tdata,
    m_axis_tkeep  => m_axis_s2mm_tkeep,
    m_axis_tlast  => m_axis_s2mm_tlast,
    axis_prog_full=> out_fifo_afl
  );
              
end Behavioral;
