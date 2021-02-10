----------------------------------------------------------------------------------
-- Pentek Data Stream to PCI Express DMA Data Stream Reader State Machine
----------------------------------------------------------------------------------
-- px_dma_ppkt2pcie_reader.vhd
--
-- Target Device: Kintex UltraScale
--
-- Pentek Inc.
-- One Park Way, Upper Saddle River, NJ 07458
-- (201)818-5900
-- www.pentek.com
--
-- Copyright Pentek, Inc. 2015
--
-- Revision:
-- Revision 1.0 - File Created
-- Revision 1.1 - Modified Abort sequence - 4/13/17

-- Additional Comments: 
--  
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- IMPORTANT! - Xilinx PCIe Core has a bug where packets of length = 1 DWord sometines cause a hang.
-- For now, a work-around is in place that will always give you two DWORDS when you want one.
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- (c) Copyright 2015 Pentek, Inc. All rights reserved.
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

entity px_dma_ppkt2pcie_reader is
generic(
    lite : boolean := false -- lite = 256 bit wide data
);
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
end px_dma_ppkt2pcie_reader;

architecture Behavioral of px_dma_ppkt2pcie_reader is

-------------------------------------------------------------------------------
-- Components
-------------------------------------------------------------------------------
-- AXI-S FIFO
-- PACKET FIFO
-- Common Clock Block RAM
-- AFL at 20
-- Depth = 32
-- Width = 512
component px_dma_ppkt2pcie_rdr_fifo
  port (
    s_aclk           : in  std_logic;
    s_aresetn        : in  std_logic;
    s_axis_tvalid    : in  std_logic;
    s_axis_tready    : out std_logic;
    s_axis_tdata     : in  std_logic_vector(511 downto 0);
    s_axis_tlast     : in  std_logic;
    m_axis_tvalid    : out std_logic;
    m_axis_tready    : in  std_logic;
    m_axis_tdata     : out std_logic_vector(511 downto 0);
    m_axis_tlast     : out std_logic;
    axis_prog_full   : out std_logic
  );
end component;

-- AXI-S FIFO
-- PACKET FIFO
-- Common Clock Block RAM
-- AFL at 20
-- Depth = 32
-- Width = 256
component px_dma_ppkt2pcie_rdr_lfifo
  port (
    s_aclk           : in  std_logic;
    s_aresetn        : in  std_logic;
    s_axis_tvalid    : in  std_logic;
    s_axis_tready    : out std_logic;
    s_axis_tdata     : in  std_logic_vector(255 downto 0);
    s_axis_tlast     : in  std_logic;
    m_axis_tvalid    : out std_logic;
    m_axis_tready    : in  std_logic;
    m_axis_tdata     : out std_logic_vector(255 downto 0);
    m_axis_tlast     : out std_logic;
    axis_prog_full   : out std_logic
  );
end component;

-- AXI-S FIFO
-- Common Clock Block RAM
-- Depth = 32
-- Width = 128
component px_dma_ppkt2pcie_hdr_fifo
  port (
    s_aclk           : in  std_logic;
    s_aresetn        : in  std_logic;
    s_axis_tvalid    : in  std_logic;
    s_axis_tready    : out std_logic;
    s_axis_tdata     : in  std_logic_vector(127 downto 0);
    m_axis_tvalid    : out std_logic;
    m_axis_tready    : in  std_logic;
    m_axis_tdata     : out std_logic_vector(127 downto 0)
  );
end component;

component px_dma_ppkt2pcie_leastof4 is
    Generic (
    lite : boolean := false -- false b = 16, true b= 8
);
 Port ( a : in STD_LOGIC_VECTOR (10 downto 0);
        --b : in STD_LOGIC_VECTOR (29 downto 0);
        c : in STD_LOGIC_VECTOR (10 downto 0);
        d : in STD_LOGIC_VECTOR (10 downto 0);
        d_large :in STD_LOGIC;
        x : out STD_LOGIC_VECTOR (10 downto 0);
        index : out STD_LOGIC_VECTOR (1 downto 0);
        aeqb : out STD_LOGIC
        );
end component px_dma_ppkt2pcie_leastof4;

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
   SECOND_STATE,
   EOP_STATE,
   META_STATE,
   AFL_STATE,
   END_STATE
); 

type out_sm_type is (
   RESET_STATE,
   READ_HEADER_STATE,
   READ_PAYLOAD_STATE,
   ABORT_STATE,
   ABORT_STATE1,
   ABORT_STATE2,
   ABORT_STATE3,
   ABORT_STATE4
);

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal int_abort_busy            : std_logic := '0';
signal t1_abort                  : std_logic := '0';
signal t2_abort                  : std_logic := '0';
signal abort_re                  : std_logic := '0';
signal max_loop                  : integer range 0 to 16 := 0;
signal dw_to_pcie4k_boundary     : std_logic_vector(10 downto 0) := "00000000000";--: integer range 0 to 1024 := 0;
signal valid_dw                  : std_logic_vector(5 downto 0)  := "000000";
signal index_of_smallest         : std_logic_vector(1 downto 0)  := "00"; --: integer range 0 to 3 := 0;
signal smallest_dw_rslt          : std_logic_vector(10 downto 0) := "00000000000"; 
signal smallest_dw               : std_logic_vector(4 downto 0)  := "00000";
signal in_sm_abort_safe          : std_logic := '0';
signal t1_in_sm_abort_safe       : std_logic := '0';
signal t2_in_sm_abort_safe       : std_logic := '0';
signal t3_in_sm_abort_safe       : std_logic := '0';
signal t4_in_sm_abort_safe       : std_logic := '0';
signal t1_rst                    : std_logic := '0';
signal t2_rst                    : std_logic := '0';
signal t3_rst                    : std_logic := '0';
signal state                     : sm_type := RESET_STATE; 
signal out_state                 : out_sm_type := RESET_STATE; 
signal buffer_rd_rqst_ready_int  : std_logic := '0';
signal loop_cnt                  : std_logic_vector(3 downto 0) := (others => '0');
signal left_over_data_valid      : std_logic := '0';
signal out_sm_abort_safe         : std_logic := '0';
signal dest_start_address        : std_logic_vector(63 downto 0) := (others => '0');
signal dest_meta_address         : std_logic_vector(63 downto 0) := (others => '0');
signal buf_size                  : std_logic_vector(31 downto 0) := (others => '0');
signal wr_meta                   : std_logic := '0';
signal start_on_sop              : std_logic := '0';
signal end_on_eop                : std_logic := '0';
signal at                        : std_logic_vector(1 downto 0)  := (others => '0');     
signal out_fifo_tdata            : std_logic_vector(511 downto 0):= (others => '0');
signal out_fifo_tvalid           : std_logic := '0';
signal out_fifo_tlast            : std_logic := '0';
signal pkt_hdr_tvalid            : std_logic := '0';
signal pkt_hdr                   : std_logic_vector(87 downto 0) := (others => '0');
signal pkt_hdr_tdata             : std_logic_vector(127 downto 0):= (others => '0');
signal dest_addr_cntr            : std_logic_vector(61 downto 0):= (others => '0');
signal dest_meta_addr_cntr       : std_logic_vector(61 downto 0):= (others => '0');
signal actual_cntr               : std_logic_vector(29 downto 0):= (others => '0');
signal data_buf_cntr             : std_logic_vector(29 downto 0):= (others => '0');
signal pcie_pkt_cntr             : std_logic_vector(7 downto 0)  := (others => '0'); 
signal fifo_rst_n                : std_logic := '0';
signal afl                       : std_logic := '0';
signal left_over_data            : std_logic_vector(511 downto 0):= (others => '0');
signal left_over_data_dw         : std_logic_vector(7 downto 0):= (others => '0');
signal left_over_data_offset     : std_logic_vector(4 downto 0):= (others => '0');
signal strt_tuser                : std_logic_vector(87 downto 0):= (others => '0');
signal first_is_sop              : std_logic := '0';
signal last_is_eop               : std_logic := '0';
signal reg_smallest_dw           : std_logic_vector(4 downto 0) := "00000"; 
signal reg_s_axis_data_in_tdata  : std_logic_vector(511 downto 0):= (others => '0');
signal sec_last_is_eop           : std_logic := '0';
signal payload_fifo_tvalid       : std_logic := '0';
signal payload_fifo_tready       : std_logic := '0';
signal payload_fifo_tlast        : std_logic := '0';
signal payload_fifo_tdata        : std_logic_vector(511 downto 0):= (others => '0');
signal header_fifo_tvalid        : std_logic := '0';                                
signal header_fifo_tready        : std_logic := '0';                                
signal header_fifo_tdata         : std_logic_vector(127 downto 0):= (others => '0');
signal reg_header                : std_logic_vector(87 downto 0):= (others => '0');
signal keep_sum                  : std_logic_vector(3 downto 0):= (others => '0');
signal reg_keep_sum              : std_logic_vector(3 downto 0):= (others => '0');
signal t1_buffer_rd_complete     : std_logic := '0';    
signal t2_buffer_rd_complete     : std_logic := '0';    
signal t3_buffer_rd_complete     : std_logic := '0';    
signal t4_buffer_rd_complete     : std_logic := '0';    
signal p_buffer_rd_complete      : std_logic := '0';    
signal large_data_buf_cntr       : std_logic := '0';  
signal meta_cntr                 : std_logic_vector(11 downto 0):= (others => '0');
signal xvalid_dw                 : std_logic_vector(10 downto 0):= (others => '0');
signal xdata_buf_cntr            : std_logic_vector(10 downto 0):= (others => '0');
signal aeqb                      : std_logic := '0'; 
signal abort_fifo_flush          : std_logic := '0'; 
--------------------------------------------------------------------------------

begin

buffer_rd_rqst_ready <= buffer_rd_rqst_ready_int;
 
--------------------------------------------------------------------------------
-- Abort
--------------------------------------------------------------------------------

process(clk)
begin
   if rising_edge(clk) then
      if (t1_rst = '1') then
         int_abort_busy <= '0';
      elsif abort_re = '1' then
         int_abort_busy <= '1';   
      elsif (in_sm_abort_safe = '1') and (out_sm_abort_safe = '1') then
         int_abort_busy <= '0';
      end if;   
      if (t1_rst = '1') then
         abort_busy     <= '0';
         t1_abort       <= '0';
         t2_abort       <= '0'; 
      else
         abort_busy     <= int_abort_busy; 
         t1_abort       <= abort;
         t2_abort       <= t1_abort;
      end if;
   end if;
end process;

abort_re <= t1_abort and not t2_abort;
    
--------------------------------------------------------------------------------

nlt_max: if (lite = false) generate
-- Number of loops is based on the maximum PCIe Payload Size
max_loop <= 2 when (pcie_max_payload_size = "000") else
            4 when (pcie_max_payload_size = "001") else 8;
end generate;

lt_max: if (lite = true) generate
-- Number of loops is based on the maximum PCIe Payload Size
max_loop <= 4 when (pcie_max_payload_size = "000") else
            8 when (pcie_max_payload_size = "001") else 16;
end generate;

--dw_to_pcie4k_boundary <= conv_integer( "10000000000" - ('0' & dest_addr_cntr(9 downto 0)));
dw_to_pcie4k_boundary <= "10000000000" - ('0' & dest_addr_cntr(9 downto 0));
-- Number of valid DWORDs in 
 
--valid_dw          <= (dw_conv_integer_rnd_up('0'& (s_axis_data_in_tuser(86 downto 80)))); 
-- Index of smallest number of DWORDs
--index_of_smallest <= index_of_least_of_4_values(dw_to_pcie4k_boundary, 16, valid_dw, conv_integer( data_buf_cntr));
-- Smallest number of DWORDs
--smallest_dw       <= select_least_of_4_values(dw_to_pcie4k_boundary, 16, valid_dw, conv_integer( data_buf_cntr));

valid_dw          <= ('0' & s_axis_data_in_tuser(86 downto 82)) when (s_axis_data_in_tuser(81 downto 80) = "00") else (('0' & s_axis_data_in_tuser(86 downto 82))+1); 
xvalid_dw         <= ("00000" & valid_dw);
xdata_buf_cntr    <= ("00000" & data_buf_cntr(5 downto 0));

leastof4: px_dma_ppkt2pcie_leastof4
generic map (
    lite => lite -- false b = 16, true b= 8
)
port map ( a       => dw_to_pcie4k_boundary,
           c       => xvalid_dw,
           d       => xdata_buf_cntr, 
           d_large => large_data_buf_cntr,
           x       => smallest_dw_rslt,
           index   => index_of_smallest,
           aeqb    => aeqb
           );
-- Because of "b" = 16, the result can not be greater than 16, so we only need the lower 5 bits of smallest_dw_rslt 
smallest_dw <= smallest_dw_rslt(4 downto 0);
-------------------------------------------------------------------------------
-- HMC Read Request State Machine
-------------------------------------------------------------------------------
process(clk)
begin
   if rising_edge(clk) then
      t1_in_sm_abort_safe <= in_sm_abort_safe;
      t2_in_sm_abort_safe <= t1_in_sm_abort_safe;
      t3_in_sm_abort_safe <= t2_in_sm_abort_safe;
      t4_in_sm_abort_safe <= t3_in_sm_abort_safe;
      t1_rst     <= not rst_n;
      t2_rst     <= t1_rst;
      t3_rst     <= t2_rst;
      fifo_rst_n <= not (abort_fifo_flush or t3_rst or t2_rst or t1_rst or not rst_n);
      if (lite = false) then -- normal mode
          if (data_buf_cntr(29 downto 6) = "000000000000000000000000") then
             large_data_buf_cntr   <= '0';
          else
             large_data_buf_cntr   <= '1';
          end if;    
      else -- lite mode
          if (data_buf_cntr(29 downto 5) = "0000000000000000000000000") then
             large_data_buf_cntr   <= '0';
          else
             large_data_buf_cntr   <= '1';
          end if;  
      end if;
      if (t1_rst = '1') or (int_abort_busy = '1') then
         state                  <= RESET_STATE;
         eop_reached            <= '0';
         actual_bytes           <= (others => '0');
         actual_bytes_valid     <= '0';
         p_buffer_rd_complete     <= '0'; 
         buffer_rd_rqst_ready_int <= '0';  
         loop_cnt               <= (others => '0');
         left_over_data_valid   <= '0';
         pkt_hdr_tvalid         <= '0';
         out_fifo_tvalid        <= '0'; 
         in_sm_abort_safe       <= '1'; 
         s_axis_data_in_tready  <= '0';
         meta_cntr              <= x"000";
      else      
         case state is
      -- Reset State
            when RESET_STATE =>
               -- Start if there is a Buffer Read Request and no abort
               if (buffer_rd_rqst_valid = '1') then  
                  state <= ACCEPT_READ_REQUEST_STATE;
                  buffer_rd_rqst_ready_int <= '1';
                  in_sm_abort_safe         <= '0'; 
               -- Otherwise, wait here.   
               else
                  state <= RESET_STATE;
                  buffer_rd_rqst_ready_int <= '0';
               end if;          
               eop_reached            <= '0';
               actual_bytes_valid     <= '0';  
               actual_bytes           <= (others => '0');
               p_buffer_rd_complete   <= '0';
               loop_cnt               <= (others => '0');
               pkt_hdr_tvalid         <= '0';
               out_fifo_tvalid        <= '0';
               s_axis_data_in_tready  <= '0';
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
               -- buffer_rd_rqst_data[161]     = reserved 
               -- buffer_rd_rqst_data[162]     = SOP Start 
               -- buffer_rd_rqst_data[163]     = Allow end on EOF      
               -- buffer_rd_rqst_data[165:164] = PCIe AT 
               -- buffer_rd_rqst_data[167:166] = reserved 
               dest_start_address       <= buffer_rd_rqst_data(63 downto 0);  -- Destination Start Address 
               dest_meta_address        <= buffer_rd_rqst_data(127 downto 64);-- Destination Meta Address 
               buf_size                 <= buffer_rd_rqst_data(159 downto 130) & "00";  -- Size in bytes
               wr_meta                  <= buffer_rd_rqst_data(160);          -- Use Meta Data Length
               start_on_sop             <= buffer_rd_rqst_data(162);
               end_on_eop               <= buffer_rd_rqst_data(163);
               at                       <= buffer_rd_rqst_data(165 downto 164);  -- AT
            ----------------------------------------------
            -- Load Counter State
            ----------------------------------------------  
            when LOAD_CNTR_STATE =>  
               dest_addr_cntr           <= dest_start_address(63 downto 2); -- Load the start address (in Words)
               dest_meta_addr_cntr      <= dest_meta_address(63 downto 2);
               actual_cntr              <= (others => '0');
               data_buf_cntr            <= buf_size(31 downto 2);
               pcie_pkt_cntr            <= (others => '0');
               loop_cnt                 <= (others => '0');
               if (afl = '1') then -- Don't start if the output FIFO is almost full
                  state                 <= LOAD_CNTR_STATE;
               elsif start_on_sop = '1' then
                  state                 <= LATCH_TS_STATE;
               else   
                  state                 <= CHECK_LEFTOVER_STATE;
               end if;     
            when CHECK_LEFTOVER_STATE =>
               if left_over_data_valid = '1' then
                  out_fifo_tdata             <= left_over_data;
                  out_fifo_tvalid            <= '1';   
                  out_fifo_tlast             <= '1';   
                  pkt_hdr_tvalid             <= '1';
                  pkt_hdr(63 downto 0)       <=  dest_addr_cntr & "00"; -- Destination Address
                  pkt_hdr(68 downto 64)      <=  left_over_data_offset; -- DW Offset
                  pkt_hdr(71 downto 70)      <=  at;
                  pkt_hdr(79 downto 72)      <=  x"FF";
                  pkt_hdr(87 downto 80)      <=  left_over_data_dw;   -- [87:80] = number of DWORDS in packet 
                  dest_addr_cntr(30 downto 0)<= dest_addr_cntr(30 downto 0) + left_over_data_dw;
                  actual_cntr                <= actual_cntr                 + left_over_data_dw;
                  data_buf_cntr              <= data_buf_cntr               - left_over_data_dw;
               end if; 
               state                         <=  LATCH_TS_STATE;    
               left_over_data_valid          <= '0'; 
            ----------------------------------------------
            -- LATCH TS STATE
            ----------------------------------------------  
            when LATCH_TS_STATE =>  
               out_fifo_tvalid            <= '0';  
               pkt_hdr_tvalid             <= '0';
               if start_on_sop = '1' then -- Wait until an SOP is reached if in start on sop mode 
                   if (s_axis_data_in_tvalid = '1') then
                      if (s_axis_data_in_tuser(64)='1') then
                         state       <= READ_STATE;
                         strt_tuser  <= s_axis_data_in_tuser; -- Save Tuser from first data word in transfer (Timestamp Info)
                      else
                         state <= POP_SOP_STATE;  
                      end if;
                      s_axis_data_in_tready   <= '1';
                   else
                      state  <= LATCH_TS_STATE;  
                   end if;   
               else
                  if (s_axis_data_in_tvalid = '1') then
                     state <= READ_STATE;
                     s_axis_data_in_tready   <= '1';
                     strt_tuser              <= s_axis_data_in_tuser; -- Save Tuser from first data word in transfer (Timestamp Info)
                  else
                     state <= LATCH_TS_STATE;
                  end if;     
               end if;  
               first_is_sop          <=  s_axis_data_in_tuser(64);      
            ----------------------------------------------
            -- Pop until SOP State
            ----------------------------------------------
            when POP_SOP_STATE => 
               s_axis_data_in_tready   <= '0';      
               state <= LATCH_TS_STATE;        
            ----------------------------------------------
            -- Read State
            ----------------------------------------------
            when READ_STATE =>
               if (s_axis_data_in_tvalid = '1') then -- data is available
                  -- Determine how many DW are available this cycle
                  -- This is determined by the smallest of:
                  --   0) DWORDS to 4k PCIe Boundary
                  --   1) 16 DWORDS (full 512 bit word is valid data
                  --   2) Valid Data DW at an End of Packet;  
                  --   3) Number od DW left to transfer (data_buf_cntr)    
                  dest_addr_cntr(29 downto 0)<= dest_addr_cntr(29 downto 0) + ("0000000000000000000000000" & smallest_dw);
                  actual_cntr                <= actual_cntr                 + ("0000000000000000000000000" & smallest_dw);
                  data_buf_cntr              <= data_buf_cntr               - ("0000000000000000000000000" & smallest_dw);
                  -- Store away Packet header info on first cycle of packet construction 
                  if (loop_cnt = x"0") then  -- First Read of Packet
                     -- [63:0]  = Destination Address
                     -- [68:64] = first dw offset
                     -- [69]    = SOP
                     -- [71:70] = PCIe AT
                     -- [75:72] = valid first bytes
                     -- [79:76] = valid last bytes
                     -- [87:80] = number of DWORDS in packet  
                     pkt_hdr(63 downto 0)  <=  dest_addr_cntr & "00"; -- Destination Address
                     pkt_hdr(68 downto 64) <=  "00000";
                     pkt_hdr(71 downto 70) <=  at;
                     pkt_hdr(79 downto 72) <=  x"FF";     
                  end if;
                  reg_smallest_dw              <= smallest_dw;  -- save boundary location 
                  reg_s_axis_data_in_tdata     <= s_axis_data_in_tdata; -- save left over data so we can send it in a second packet
                  -- Determine what to do based on the index of the smallest of:  
                  --   0) DWORDS to 4k PCIe Boundary
                  --   1) 16 DWORDS (full 512 bit word is valid data
                  --   2) Valid Data DW at an End of Packet
                  --   3) Number of DW left to transfer (data_buf_cntr) 
                  case index_of_smallest is
                     when "00" =>  -- 0) DWORDS to 4k PCIe Boundary
                        loop_cnt                     <= x"0"; -- Reset packet loop counter
                        pcie_pkt_cntr                <= x"00"; -- Reset packet DW counter
                        if aeqb = '0' then
                            state                    <= SECOND_STATE; -- finish whatever DWs exist in input over the boundary a seperate small packet.
                        else
                            state                    <= READ_STATE; -- Start again  
                        end if;       
                        pkt_hdr(87 downto 80)        <= pcie_pkt_cntr + ("000" & smallest_dw); -- Save number of DWs in packet
                        out_fifo_tdata               <= s_axis_data_in_tdata;
                        out_fifo_tvalid              <= '1';   
                        out_fifo_tlast               <= '1';
                        last_is_eop                  <= '0';
                        sec_last_is_eop              <= s_axis_data_in_tlast;
                        pkt_hdr_tvalid               <= '1';                           
                     when "01" =>  -- 1) 16 DWORDS (full 512 bit word is valid data)  (lite mode = 8 DWORDS (full 256 bit word is valid data))
                        if (loop_cnt = (max_loop-1)) then -- End packet because max loop count reached
                           pcie_pkt_cntr             <= x"00"; -- Reset packet DW counter
                           loop_cnt                  <= x"0";  -- Reset packet loop counter
                           pkt_hdr(87 downto 80)     <= pcie_pkt_cntr + ("000" & smallest_dw); -- Save number of DWs in packet
                           if (afl = '1') then -- Payload FIFO is AFL so go Wait until it isn't 
                              state                  <= AFL_STATE; -- Almost full, so wait   
                              s_axis_data_in_tready  <= '0';  
                           else
                              state                  <= READ_STATE; -- Start again  
                           end if; 
                           out_fifo_tlast            <= '1'; 
                           pkt_hdr_tvalid            <= '1'; 
                        else
                           loop_cnt                  <= loop_cnt + 1; 
                           state                     <= READ_STATE; -- Continue Read of packet  
                           pcie_pkt_cntr             <= pcie_pkt_cntr + ("000" & smallest_dw);
                           out_fifo_tlast            <= '0'; 
                           pkt_hdr_tvalid            <= '0'; 
                        end if;
                        out_fifo_tdata               <= s_axis_data_in_tdata;
                        out_fifo_tvalid              <= '1'; 
                        last_is_eop                  <= '0';
                     when "10" =>  -- 2) Valid Data DWs at an End of Packet
                        if (end_on_eop = '1') then -- End on EOP is Enabled so finish here
                           state                     <= EOP_STATE; -- finish  
                           s_axis_data_in_tready     <= '0';  
                        elsif (afl = '1') then -- Payload FIFO is AFL so go Wait until it isn't 
                           state                     <= AFL_STATE; -- Almost full, so wait
                           s_axis_data_in_tready    <= '0';     
                        else
                           state                     <= READ_STATE; -- Start again  
                        end if;     
                        pcie_pkt_cntr                <= x"00"; -- Reset packet DW counter
                        loop_cnt                     <= x"0";  -- Reset packet loop counter
                        pkt_hdr(87 downto 80)        <= pcie_pkt_cntr + ("000" & smallest_dw); -- Save number of DWs in packet
                        out_fifo_tdata               <= s_axis_data_in_tdata;
                        out_fifo_tvalid              <= '1';  
                        out_fifo_tlast               <= '1';  
                        last_is_eop                  <= '1';  
                        pkt_hdr_tvalid               <= '1';  
                     when "11" =>  -- 3) Number of DW left to transfer (data_buf_cntr) 
                        pcie_pkt_cntr                <= x"00";
                        state                        <= EOP_STATE; -- finish
                        s_axis_data_in_tready        <= '0';    
                        loop_cnt                     <= x"0"; 
                        pkt_hdr(87 downto 80)        <= pcie_pkt_cntr + ("000" & smallest_dw); -- Save number of DWs in packet
                        out_fifo_tdata               <= s_axis_data_in_tdata;
                        out_fifo_tvalid              <= '1';  
                        out_fifo_tlast               <= '1'; 
                        pkt_hdr_tvalid               <= '1'; 
                        if ((smallest_dw /= "10000") and (lite = false)) or ((smallest_dw /= "01000") and (lite = true)) then
                           left_over_data_valid       <= not s_axis_data_in_tlast; --'1';
                           --left_over_data             <= reg_s_axis_data_in_tdata;
                           left_over_data             <= s_axis_data_in_tdata;
                           left_over_data_offset      <= data_buf_cntr(4 downto 0);  
                        else
                           left_over_data_valid       <= '0';           
                        end if;
                        last_is_eop                   <= s_axis_data_in_tlast;
                     when others =>
                        if (loop_cnt = (max_loop-1)) then -- End packet because max loop count reached
                           pcie_pkt_cntr             <= x"00"; -- Reset packet DW counter
                           loop_cnt                  <= x"0";  -- Reset packet loop counter
                           pkt_hdr(87 downto 80)     <= pcie_pkt_cntr + ("000" & smallest_dw); -- Save number of DWs in packet
                           if (afl = '1') then -- Payload FIFO is AFL so go Wait until it isn't 
                              state                  <= AFL_STATE; -- Almost full, so wait   
                              s_axis_data_in_tready  <= '0';  
                           else
                              state                  <= READ_STATE; -- Start again  
                           end if; 
                           out_fifo_tlast            <= '1';
                           pkt_hdr_tvalid            <= '1'; 
                        else
                           loop_cnt                  <= loop_cnt + 1; 
                           state                     <= READ_STATE; -- Continue Read of packet  
                           pcie_pkt_cntr             <= pcie_pkt_cntr + ("000" & smallest_dw);
                           out_fifo_tlast            <= '0'; 
                           pkt_hdr_tvalid            <= '0'; 
                        end if;     
                        out_fifo_tdata               <= s_axis_data_in_tdata;
                        out_fifo_tvalid              <= '1';     
                        last_is_eop                  <= '0';          
                  end case;  
               else
                  state                              <= READ_STATE; -- try again
                  out_fifo_tvalid                    <= '0';  
                  pkt_hdr_tvalid                     <= '0'; 
                  out_fifo_tvalid                    <= '0';
               end if;
           ----------------------------------------------
           -- Finish 4k Boundary Crossing
           ----------------------------------------------   
           when SECOND_STATE =>
            if (lite = false) then -- normal mode
                if ( ("00000000000000000000000000" & ("10000" - reg_smallest_dw)) < ('0' & data_buf_cntr) ) then -- The amount of data left to send is greater than the data left over 4k boundary.
                   dest_addr_cntr(30 downto 0)<= dest_addr_cntr(30 downto 0) + ("00000000000000000000000000"& ("10000" - reg_smallest_dw));
                   actual_cntr                <= actual_cntr                 + ("0000000000000000000000000" & ("10000" - reg_smallest_dw));
                   data_buf_cntr              <= data_buf_cntr               - ("0000000000000000000000000" & ("10000" - reg_smallest_dw));
                   pkt_hdr(87 downto 80)      <= ("00010000" - ("000" & reg_smallest_dw)); -- Save number of DWs in packet
                   if (afl = '1') then -- Payload FIFO is AFL so go Wait until it isn't 
                      state                  <= AFL_STATE; -- Almost full, so wait  
                      s_axis_data_in_tready  <= '0';   
                   else
                      state                  <= READ_STATE; -- Start again  
                   end if;   
                elsif ( ("0000000000000000000000000" & ("10000" - reg_smallest_dw)) = data_buf_cntr ) then -- All data is used
                   dest_addr_cntr(30 downto 0)<= dest_addr_cntr(30 downto 0) + conv_integer( data_buf_cntr);
                   actual_cntr                <= actual_cntr                 + conv_integer( data_buf_cntr);
                   data_buf_cntr              <= (others => '0');
                   pkt_hdr(87 downto 80)      <= data_buf_cntr(7 downto 0);
                   state                      <= EOP_STATE; -- finish   
                   s_axis_data_in_tready      <= '0';    
                   left_over_data_valid       <= '0';          
                else 
                   dest_addr_cntr(30 downto 0)<= dest_addr_cntr(30 downto 0) + conv_integer( data_buf_cntr);
                   actual_cntr                <= actual_cntr                 + conv_integer( data_buf_cntr);
                   data_buf_cntr              <= (others => '0');
                   pkt_hdr(87 downto 80)      <= data_buf_cntr(7 downto 0);
                   state                      <= EOP_STATE; -- finish   
                   s_axis_data_in_tready      <= '0';  
                   left_over_data_valid       <= '1';
                   left_over_data             <= reg_s_axis_data_in_tdata;
                   left_over_data_offset      <= reg_smallest_dw + data_buf_cntr(4 downto 0);                      
                end if;  
            else -- lite mode
                if ( ("00000000000000000000000000" & ("01000" - reg_smallest_dw)) < ('0' & data_buf_cntr) ) then -- The amount of data left to send is greater than the data left over 4k boundary.
                   dest_addr_cntr(30 downto 0)<= dest_addr_cntr(30 downto 0) + ("00000000000000000000000000"& ("01000" - reg_smallest_dw));
                   actual_cntr                <= actual_cntr                 + ("0000000000000000000000000" & ("01000" - reg_smallest_dw));
                   data_buf_cntr              <= data_buf_cntr               - ("0000000000000000000000000" & ("01000" - reg_smallest_dw));
                   pkt_hdr(87 downto 80)      <= ("00001000" - ("000" & reg_smallest_dw)); -- Save number of DWs in packet
                   if (afl = '1') then -- Payload FIFO is AFL so go Wait until it isn't 
                      state                  <= AFL_STATE; -- Almost full, so wait  
                      s_axis_data_in_tready  <= '0';   
                   else
                      state                  <= READ_STATE; -- Start again  
                   end if;   
                elsif ( ("0000000000000000000000000" & ("01000" - reg_smallest_dw)) = data_buf_cntr ) then -- All data is used
                   dest_addr_cntr(30 downto 0)<= dest_addr_cntr(30 downto 0) + conv_integer( data_buf_cntr);
                   actual_cntr                <= actual_cntr                 + conv_integer( data_buf_cntr);
                   data_buf_cntr              <= (others => '0');
                   pkt_hdr(87 downto 80)      <= data_buf_cntr(7 downto 0);
                   state                      <= EOP_STATE; -- finish   
                   s_axis_data_in_tready      <= '0';    
                   left_over_data_valid       <= '0';          
                else 
                   dest_addr_cntr(30 downto 0)<= dest_addr_cntr(30 downto 0) + conv_integer( data_buf_cntr);
                   actual_cntr                <= actual_cntr                 + conv_integer( data_buf_cntr);
                   data_buf_cntr              <= (others => '0');
                   pkt_hdr(87 downto 80)      <= data_buf_cntr(7 downto 0);
                   state                      <= EOP_STATE; -- finish   
                   s_axis_data_in_tready      <= '0';  
                   left_over_data_valid       <= '1';
                   left_over_data             <= reg_s_axis_data_in_tdata;
                   left_over_data_offset      <= reg_smallest_dw + data_buf_cntr(4 downto 0);                      
                end if;  
            end if; 
            pkt_hdr(63 downto 0)          <=  dest_addr_cntr & "00"; -- Destination Address
            pkt_hdr(68 downto 64)         <=  reg_smallest_dw;
            pkt_hdr(71 downto 70)         <=  at;
            pkt_hdr(79 downto 72)         <=  x"FF";                
            -- One cycle packet
            out_fifo_tdata                <= reg_s_axis_data_in_tdata;
            out_fifo_tvalid               <= '1';
            out_fifo_tlast                <= '1';
            last_is_eop                   <= sec_last_is_eop;
            pkt_hdr_tvalid                <= '1'; 
           ----------------------------------------------
           -- End of Packet Reached
           ----------------------------------------------   
           when EOP_STATE =>  
             if (lite = false) then -- normal mode
                left_over_data_dw        <= 16 - ("000" & left_over_data_offset);
             else -- lite mode
                left_over_data_dw        <= 8  - ("000" & left_over_data_offset);
             end if;    
             out_fifo_tvalid          <= '0';
             pkt_hdr_tvalid           <= '0'; 
             s_axis_data_in_tready    <= '0';  
             if wr_meta = '1' then
                state                 <= META_STATE;
             else
                state                 <= END_STATE;
             end if;  
           ----------------------------------------------
           -- Meta Data Packet State
           ----------------------------------------------
           when META_STATE => 
              out_fifo_tdata(63 downto 0)   <= strt_tuser(63 downto 0); -- Timestamp
              out_fifo_tdata(95 downto 64)  <= actual_cntr & "00"; -- Number of Valid Bytes
              out_fifo_tdata(99 downto 96)  <= "0000";
              --out_fifo_tdata(103 downto 100) <= "0000";
              out_fifo_tdata(111 downto 100) <= meta_cntr;
              out_fifo_tdata(119 downto 112)<= strt_tuser(75 downto 68); -- Channel Number
              out_fifo_tdata(121 downto 120)<= strt_tuser(66 downto 65); -- Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
              out_fifo_tdata(122)           <= strt_tuser(67);
              out_fifo_tdata(123)           <= '0';
              out_fifo_tdata(124)           <= first_is_sop;  
              out_fifo_tdata(125)           <= last_is_eop;
              out_fifo_tdata(127 downto 126)<= "00";
              out_fifo_tdata(511 downto 128)<= (others => '0');
              out_fifo_tvalid               <= '1';   
              out_fifo_tlast                <= '1';   
              pkt_hdr(63 downto 0)          <=  dest_meta_address(63 downto 2) & "00"; -- Destination Address
              pkt_hdr(68 downto 64)         <=  "00000"; -- DW Offset
              pkt_hdr(71 downto 70)         <=  at;
              pkt_hdr(79 downto 72)         <=  x"FF";
              pkt_hdr(87 downto 80)         <=  x"04";   -- [87:80] = number of DWORDS in packet 
              pkt_hdr_tvalid                <= '1'; 
              -- meta_data[31:0]    = Timestamp Clock count[31:0]
              -- meta_data[63:32]   = Timestamp PPS count[31:0]
              -- meta_data[95:64]   = Number of Valid Bytes[31:0]
              -- meta_data[99:96]   = User[3:0]
              -- meta_data[111:100] = Counter
              -- meta_data[119:112] = Channel Number[7:0]
              -- meta_data[121:120] = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
              -- meta_data[122]     = Data Type 0 = Real 1 = I/Q
              -- meta_data[123]     = Type of first sample 0 = I 1 = Q
              -- meta_data[124]     = Sync Info - First is SOP
              -- meta_data[125]     = Sync Info - Last is EOP
              -- meta_data[126]     = Reserved
              -- meta_data[127]     = Reserved 
              
              -- tuser[63:0]        = timestamp[63:0]  
              -- tuser[64]          = SOP   
              -- tuser[66:65]       = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
              -- tuser[67]          = Data Type 0 = Real 1 = I/Q
              -- tuser[75:68]       = channel[7:0]
              -- tuser[79:76]       = user[3:0] 
              -- tuser[87:80]       = valid bytes 
              meta_cntr                <= meta_cntr + 1;
              state                    <= END_STATE;        
           ----------------------------------------------
           -- Output FIFO AFL State
           ----------------------------------------------
           when AFL_STATE =>
              -- Stay here if Almost Full
              if  (afl = '1') then
                 state                 <= AFL_STATE;
                 out_fifo_tvalid       <= '0';
                 pkt_hdr_tvalid        <= '0'; 
                 s_axis_data_in_tready <= '0';   
              else
                 state                 <= READ_STATE;
                 s_axis_data_in_tready <= '1';     
              end if;
           ----------------------------------------------
           -- End State
           ----------------------------------------------
           when END_STATE =>
              out_fifo_tvalid       <= '0'; 
              pkt_hdr_tvalid        <= '0'; 
              state                 <= RESET_STATE; -- Start Over
              p_buffer_rd_complete    <= '1';
              actual_bytes          <= actual_cntr & "00";
              actual_bytes_valid    <= '1';
              eop_reached           <= last_is_eop;
           when others =>
              state <= RESET_STATE;
         end case;       
      end if;      
   end if;
end process;

--------------------------------------------------------------------------------
-- Output FIFOs
--------------------------------------------------------------------------------

-- Data Payload FIFO
gen_nlt_f: if (lite = false) generate

payld_fifo_inst: px_dma_ppkt2pcie_rdr_fifo
port map (
    s_aclk        => clk,
    s_aresetn     => fifo_rst_n,
    s_axis_tvalid => out_fifo_tvalid,
    s_axis_tready => open,
    s_axis_tdata  => out_fifo_tdata,
    s_axis_tlast  => out_fifo_tlast,
    m_axis_tvalid => payload_fifo_tvalid,
    m_axis_tready => payload_fifo_tready,
    m_axis_tdata  => payload_fifo_tdata,
    m_axis_tlast  => payload_fifo_tlast,
    axis_prog_full=> afl
  );
end generate gen_nlt_f; 


gen_lt_f: if (lite = true) generate

payld_fifo_inst: px_dma_ppkt2pcie_rdr_lfifo
port map (
    s_aclk        => clk,
    s_aresetn     => fifo_rst_n,
    s_axis_tvalid => out_fifo_tvalid,
    s_axis_tready => open,
    s_axis_tdata  => out_fifo_tdata(255 downto 0),
    s_axis_tlast  => out_fifo_tlast,
    m_axis_tvalid => payload_fifo_tvalid,
    m_axis_tready => payload_fifo_tready,
    m_axis_tdata  => payload_fifo_tdata(255 downto 0),
    m_axis_tlast  => payload_fifo_tlast,
    axis_prog_full=> afl
  );
  
payload_fifo_tdata (511 downto 256) <= (others => '0');  
  
end generate gen_lt_f; 

-----------------------------------------------------
-- Header FIFO

pkt_hdr_tdata <= x"0000000000" & pkt_hdr;

header_fifo_inst: px_dma_ppkt2pcie_hdr_fifo
port map (
    s_aclk        => clk,
    s_aresetn     => fifo_rst_n,
    s_axis_tvalid => pkt_hdr_tvalid,
    s_axis_tready => open,
    s_axis_tdata  => pkt_hdr_tdata,
    m_axis_tvalid => header_fifo_tvalid,
    m_axis_tready => header_fifo_tready,
    m_axis_tdata  => header_fifo_tdata
  );

process(clk)
begin
   if rising_edge(clk) then
      fifo_empty            <= not payload_fifo_tvalid;
      buffer_rd_complete    <= t4_buffer_rd_complete;
      t1_buffer_rd_complete <= p_buffer_rd_complete;
      t2_buffer_rd_complete <= t1_buffer_rd_complete;
      t3_buffer_rd_complete <= t2_buffer_rd_complete;
      t4_buffer_rd_complete <= t3_buffer_rd_complete;
   end if;
end process;      

--------------------------------------------------------------------------------
-- Output Packet Generation
--------------------------------------------------------------------------------
-- tuser
-- [63:0]  = Destination Address
-- [68:64] = first dw offset
-- [69]    = SOP
-- [71:70] = PCIe AT
-- [75:72] = valid first bytes
-- [79:76] = valid last bytes
-- [87:80] = number of DWORDS in packet

-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- Xilinx PCIe Core has a bug where packets of length = 1 DWord sometines cause a hang.  For now this work-around will always give you two when you have one.
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
keep_sum     <= (header_fifo_tdata(83 downto 80) + header_fifo_tdata(67 downto 64)) when ((header_fifo_tdata(87 downto 80) + ("0000" & header_fifo_tdata(67 downto 64))) /= x"01") else x"2";
reg_keep_sum <= (reg_header(83 downto 80)        + reg_header(67 downto 64));

--keep_sum     <= header_fifo_tdata(83 downto 80) + header_fifo_tdata(67 downto 64);
--reg_keep_sum <= reg_header(83 downto 80)        + reg_header(67 downto 64);

gen_nlt_out: if (lite = false) generate

process(clk)
begin
   if rising_edge(clk) then
      if (t1_rst = '1') then
         out_state             <= RESET_STATE;
         header_fifo_tready    <= '0'; 
         payload_fifo_tready   <= '0'; 
         m_axis_payload_tvalid <= '0';
         abort_fifo_flush      <= '0';
         out_sm_abort_safe     <= '0'; --'1';
      else
         case out_state is
            when RESET_STATE =>
               if (int_abort_busy = '1') then
                  header_fifo_tready  <= '0'; 
                  payload_fifo_tready <= '0'; 
                  out_state <= ABORT_STATE;
               --elsif (pcie_afl = '0') and (header_fifo_tvalid = '1') and (payload_fifo_tvalid = '1') and (int_abort_busy = '0') then
               elsif (pcie_afl = '0') and (header_fifo_tvalid = '1') and (payload_fifo_tvalid = '1') then
                  header_fifo_tready  <= '1';
                  payload_fifo_tready <= '1'; 
                  out_state <= READ_HEADER_STATE;
               else
                  header_fifo_tready  <= '0'; 
                  payload_fifo_tready <= '0'; 
                  out_state <= RESET_STATE;
               end if;   
               m_axis_payload_tvalid  <= '0';
               out_sm_abort_safe      <= '0';
            when READ_HEADER_STATE =>
                  out_sm_abort_safe       <= '0';
                  header_fifo_tready      <= '0'; 
                  if ((header_fifo_tdata(87 downto 80) + ("0000" & header_fifo_tdata(67 downto 64))) /= x"01") then
                     m_axis_payload_tuser(87 downto 0)    <= header_fifo_tdata(87 downto 70) & '1' & header_fifo_tdata(68 downto 0); -- Header tuser with SOP marker
                     reg_header              <= header_fifo_tdata(87 downto 70) & '0' & header_fifo_tdata(68 downto 0); 
                  -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                  -- Xilinx PCIe Core has a bug where packets of length = 1 DWord sometines cause a hang.  For now this work-around will always give you two when you have one.
                  -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
                  else
                     m_axis_payload_tuser(87 downto 0)    <= x"02" & header_fifo_tdata(79 downto 70) & '1' & header_fifo_tdata(68 downto 0); -- Header tuser with SOP marker
                     reg_header              <= x"02" & header_fifo_tdata(79 downto 70) & '0' & header_fifo_tdata(68 downto 0); 
                  end if; 
                  --m_axis_payload_tuser(87 downto 0)    <= header_fifo_tdata(87 downto 70) & '1' & header_fifo_tdata(68 downto 0); -- Header tuser with SOP marker
                  --reg_header              <= header_fifo_tdata(87 downto 70) & '0' & header_fifo_tdata(68 downto 0); 
                  m_axis_payload_tdata    <= payload_fifo_tdata;
                  m_axis_payload_tlast    <= payload_fifo_tlast;
                  m_axis_payload_tvalid   <= '1';
                  if payload_fifo_tlast = '0' then
                     out_state            <= READ_PAYLOAD_STATE;
                     m_axis_payload_tkeep <= x"FFFF";
                  else
                     payload_fifo_tready  <= '0'; 
                     if (int_abort_busy = '0') then
                        out_state <= RESET_STATE;
                     else
                        out_state <= ABORT_STATE;
                     end if;  
                     case keep_sum is
                        when "0000" =>
                           m_axis_payload_tkeep <= x"FFFF";
                        when "0001" =>
                           m_axis_payload_tkeep <= x"0001";
                        when "0010" =>
                           m_axis_payload_tkeep <= x"0003";
                        when "0011" =>
                           m_axis_payload_tkeep <= x"0007";
                        when "0100" =>
                           m_axis_payload_tkeep <= x"000F";
                        when "0101" =>
                           m_axis_payload_tkeep <= x"001F";
                        when "0110" =>
                           m_axis_payload_tkeep <= x"003F";
                        when "0111" =>
                           m_axis_payload_tkeep <= x"007F";
                        when "1000" =>
                           m_axis_payload_tkeep <= x"00FF";
                        when "1001" =>
                           m_axis_payload_tkeep <= x"01FF";
                        when "1010" =>
                           m_axis_payload_tkeep <= x"03FF";
                        when "1011" =>
                           m_axis_payload_tkeep <= x"07FF";
                        when "1100" =>
                           m_axis_payload_tkeep <= x"0FFF";
                        when "1101" =>
                           m_axis_payload_tkeep <= x"1FFF";
                        when "1110" =>
                           m_axis_payload_tkeep <= x"3FFF";
                        when "1111" =>
                           m_axis_payload_tkeep <= x"7FFF";
                        when others =>
                           m_axis_payload_tkeep <= x"FFFF";
                     end case; 
                  end if;   
            when READ_PAYLOAD_STATE =>
               m_axis_payload_tuser(87 downto 0)     <= reg_header; -- Header tuser with SOP marker
               m_axis_payload_tdata     <= payload_fifo_tdata;
               m_axis_payload_tlast     <= payload_fifo_tlast;
               m_axis_payload_tvalid    <= '1';
               if payload_fifo_tlast = '0' then
                  out_state <= READ_PAYLOAD_STATE;
                  m_axis_payload_tkeep <= x"FFFF";
               else
                  payload_fifo_tready   <= '0'; 
                  if (int_abort_busy = '0') then
                     out_state <= RESET_STATE;
                  else
                     out_state <= ABORT_STATE;
                  end if;   
                  case reg_keep_sum is
                     when "0000" =>
                        m_axis_payload_tkeep <= x"FFFF";
                     when "0001" =>
                        m_axis_payload_tkeep <= x"0001";
                     when "0010" =>
                        m_axis_payload_tkeep <= x"0003";
                     when "0011" =>
                        m_axis_payload_tkeep <= x"0007";
                     when "0100" =>
                        m_axis_payload_tkeep <= x"000F";
                     when "0101" =>
                        m_axis_payload_tkeep <= x"001F";
                     when "0110" =>
                        m_axis_payload_tkeep <= x"003F";
                     when "0111" =>
                        m_axis_payload_tkeep <= x"007F";
                     when "1000" =>
                        m_axis_payload_tkeep <= x"00FF";
                     when "1001" =>
                        m_axis_payload_tkeep <= x"01FF";
                     when "1010" =>
                        m_axis_payload_tkeep <= x"03FF";
                     when "1011" =>
                        m_axis_payload_tkeep <= x"07FF";
                     when "1100" =>
                        m_axis_payload_tkeep <= x"0FFF";
                     when "1101" =>
                        m_axis_payload_tkeep <= x"1FFF";
                     when "1110" =>
                        m_axis_payload_tkeep <= x"3FFF";
                     when "1111" =>
                        m_axis_payload_tkeep <= x"7FFF";
                     when others =>
                        m_axis_payload_tkeep <= x"FFFF";
                  end case;                                                                                                      
               end if;
--            when ABORT_STATE =>
--               if (header_fifo_tvalid = '1') or (payload_fifo_tvalid = '1')  or (t4_in_sm_abort_safe  = '0') then 
--                  header_fifo_tready    <= '1'; 
--                  payload_fifo_tready   <= '1'; 
--                  out_state           <= ABORT_STATE;
--               else
--                  out_state           <= RESET_STATE;
--               end if;    
--               m_axis_payload_tvalid  <= '0';  
            when ABORT_STATE =>
                  if (t4_in_sm_abort_safe  = '0') then 
                     out_state           <= ABORT_STATE;
                  else
                     out_state           <= ABORT_STATE1;
                  end if;    
                  m_axis_payload_tvalid  <= '0';
                  header_fifo_tready     <= '0'; 
                  payload_fifo_tready    <= '0'; 
            when ABORT_STATE1 =>
               abort_fifo_flush    <= '1';
               out_state           <= ABORT_STATE2;
            when ABORT_STATE2 =>
               out_state           <= ABORT_STATE3;
            when ABORT_STATE3 =>
               out_state           <= ABORT_STATE4;
            when ABORT_STATE4 =>
               out_sm_abort_safe   <= '1';
               abort_fifo_flush    <= '0';
               if (int_abort_busy = '1') then
                  out_state           <= ABORT_STATE4;
               else
                  out_state        <= RESET_STATE;
               end if;                                   
            when others =>
               out_state <= RESET_STATE;
         end case;
      end if;
   end if;
end process;

end generate gen_nlt_out;

gen_lt_out: if (lite = true) generate

process(clk)
begin
   if rising_edge(clk) then
      if (t1_rst = '1') then
         out_state             <= RESET_STATE;
         header_fifo_tready    <= '0';
         payload_fifo_tready   <= '0';  
         m_axis_payload_tvalid <= '0';
         abort_fifo_flush      <= '0';
         out_sm_abort_safe     <= '0'; --'1';
      else
         case out_state is
            when RESET_STATE =>
               if (int_abort_busy = '1') then
                  header_fifo_tready  <= '0'; 
                  payload_fifo_tready <= '0'; 
                  out_state <= ABORT_STATE;
               --elsif (pcie_afl = '0') and (header_fifo_tvalid = '1') and (payload_fifo_tvalid = '1') and (int_abort_busy = '0') then
               elsif (pcie_afl = '0') and (header_fifo_tvalid = '1') and (payload_fifo_tvalid = '1') then
                  header_fifo_tready  <= '1';
                  payload_fifo_tready <= '1'; 
                  out_state <= READ_HEADER_STATE;
               else
                  header_fifo_tready  <= '0'; 
                  payload_fifo_tready <= '0'; 
                  out_state <= RESET_STATE;
               end if;   
               m_axis_payload_tvalid  <= '0';
               out_sm_abort_safe      <= '0';
            when READ_HEADER_STATE =>
                  out_sm_abort_safe       <= '0';
                  header_fifo_tready      <= '0'; 
                  if ((header_fifo_tdata(87 downto 80) + ("0000" & header_fifo_tdata(67 downto 64))) /= x"01") then
                     m_axis_payload_tuser(87 downto 0)    <= header_fifo_tdata(87 downto 70) & '1' & header_fifo_tdata(68 downto 0); -- Header tuser with SOP marker
                     reg_header              <= header_fifo_tdata(87 downto 70) & '0' & header_fifo_tdata(68 downto 0);
                  -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                  -- Xilinx PCIe Core has a bug where packets of length = 1 DWord sometines cause a hang.  For now this work-around will always give you two when you have one.
                  -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
                  else  
                     m_axis_payload_tuser(87 downto 0)    <= x"02" & header_fifo_tdata(79 downto 70) & '1' & header_fifo_tdata(68 downto 0); -- Header tuser with SOP marker
                     reg_header              <= x"02" & header_fifo_tdata(79 downto 70) & '0' & header_fifo_tdata(68 downto 0); 
                  end if;
                  --m_axis_payload_tuser(87 downto 0)    <= header_fifo_tdata(87 downto 70) & '1' & header_fifo_tdata(68 downto 0); -- Header tuser with SOP marker
                  --reg_header              <= header_fifo_tdata(87 downto 70) & '0' & header_fifo_tdata(68 downto 0); 
                  m_axis_payload_tdata(255 downto 0)    <= payload_fifo_tdata(255 downto 0);
                  m_axis_payload_tlast    <= payload_fifo_tlast;
                  m_axis_payload_tvalid   <= '1';
                  if payload_fifo_tlast = '0' then
                     out_state            <= READ_PAYLOAD_STATE;
                     m_axis_payload_tkeep <= x"00FF";
                  else
                     payload_fifo_tready  <= '0'; 
                     if (int_abort_busy = '0') then
                        out_state <= RESET_STATE;
                     else
                        out_state <= ABORT_STATE;
                     end if;  
                     case keep_sum(2 downto 0) is
                        when "000" =>
                           m_axis_payload_tkeep <= x"00FF";
                        when "001" =>
                           m_axis_payload_tkeep <= x"0001";
                        when "010" =>
                           m_axis_payload_tkeep <= x"0003";
                        when "011" =>
                           m_axis_payload_tkeep <= x"0007";
                        when "100" =>
                           m_axis_payload_tkeep <= x"000F";
                        when "101" =>
                           m_axis_payload_tkeep <= x"001F";
                        when "110" =>
                           m_axis_payload_tkeep <= x"003F";
                        when "111" =>
                           m_axis_payload_tkeep <= x"007F";
                        when others =>
                           m_axis_payload_tkeep <= x"00FF";
                     end case; 
                  end if;   
            when READ_PAYLOAD_STATE =>
               m_axis_payload_tuser(87 downto 0)     <= reg_header; -- Header tuser with SOP marker
               m_axis_payload_tdata(255 downto 0)    <= payload_fifo_tdata(255 downto 0);
               m_axis_payload_tlast     <= payload_fifo_tlast;
               m_axis_payload_tvalid    <= '1';
               if payload_fifo_tlast = '0' then
                  out_state <= READ_PAYLOAD_STATE;
                  m_axis_payload_tkeep <= x"00FF";
               else
                  payload_fifo_tready   <= '0'; 
                  if (int_abort_busy = '0') then
                     out_state <= RESET_STATE;
                  else
                     out_state <= ABORT_STATE;
                  end if;   
                  case reg_keep_sum(2 downto 0) is
                     when "000" =>
                        m_axis_payload_tkeep <= x"00FF";
                     when "001" =>
                        m_axis_payload_tkeep <= x"0001";
                     when "010" =>
                        m_axis_payload_tkeep <= x"0003";
                     when "011" =>
                        m_axis_payload_tkeep <= x"0007";
                     when "100" =>
                        m_axis_payload_tkeep <= x"000F";
                     when "101" =>
                        m_axis_payload_tkeep <= x"001F";
                     when "110" =>
                        m_axis_payload_tkeep <= x"003F";
                     when "111" =>
                        m_axis_payload_tkeep <= x"007F";
                     when others =>
                        m_axis_payload_tkeep <= x"00FF";
                  end case;                                                                                                      
               end if;
--            when ABORT_STATE =>
--               if (header_fifo_tvalid = '1') or (payload_fifo_tvalid = '1')  or (t4_in_sm_abort_safe  = '0') then 
--                  header_fifo_tready    <= '1'; 
--                  payload_fifo_tready   <= '1'; 
--                  out_state           <= ABORT_STATE;
--               else
--                  out_state           <= RESET_STATE;
--               end if;    
--               m_axis_payload_tvalid  <= '0';  
            when ABORT_STATE =>
                  if (t4_in_sm_abort_safe  = '0') then 
                     out_state           <= ABORT_STATE;
                  else
                     out_state           <= ABORT_STATE1;
                  end if;    
                  m_axis_payload_tvalid  <= '0';
                  header_fifo_tready     <= '0'; 
                  payload_fifo_tready    <= '0'; 
            when ABORT_STATE1 =>
               abort_fifo_flush    <= '1';
               out_state           <= ABORT_STATE2;
            when ABORT_STATE2 =>
               out_state           <= ABORT_STATE3;
            when ABORT_STATE3 =>
               out_state           <= ABORT_STATE4;
            when ABORT_STATE4 =>
               out_sm_abort_safe   <= '1';
               abort_fifo_flush    <= '0';
               if (int_abort_busy = '1') then
                  out_state           <= ABORT_STATE4;
               else
                  out_state        <= RESET_STATE;
               end if;                                   
            when others =>
               out_state <= RESET_STATE;
         end case;
      end if;
   end if;
end process;

m_axis_payload_tdata(511 downto 256) <= (others => '0'); 

end generate gen_lt_out;

m_axis_payload_tuser(95 downto 88)    <= (others => '0'); 
         
              
end Behavioral;
