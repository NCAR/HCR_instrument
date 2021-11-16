----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/23/2018 02:46:58 PM
-- Design Name: 
-- Module Name: px_axis_ppkt2ppld - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Takes AXI-S PPKT type input stream and further divides it up into
-- a programmable length payload packets and adds the payload length (number bytes)
-- into the tuser field of the first word of the packet. The first word is also marked with SOP
-- in the tuser field. The number of valid bytes is also in the tuser field.

-- Output is presented in a Packet FIFO like manner, where tvalid is not asserted until
-- the entire packet is available.

-- A packet will end at the sooner of either the input tlast is reached or the desired
-- nominal packet length is reached.

-- This core reqires that its input stream supports flow control and requires an external
-- Packet Type AXI-S FIFO to be interfaced to it. 
-- The maximum packet size is the lesser of 64k bytes or the maximum size of the FIFO.  
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
-- Address Map
-- 0x00 Control
-- Control [16:0] = Payload Size in Bytes
-- Control [17]   = FIFO Flush
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

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

entity px_axis_ppkt2ppld is
generic(
   word_width : integer range 1 to 64 := 16;
   default_packet_size: integer range 2 to 65536 := 256;
   has_override: boolean := false;
   has_fifo_rst_in_n: boolean := true
);
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
--------------------------------------------------------------------------------
   s_axi_csr_aclk        : in  std_logic;
   s_axi_csr_aresetn     : in  std_logic;
   s_axi_csr_awaddr      : in  std_logic_vector(6 downto 0);
   s_axi_csr_awprot      : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_awvalid     : in  std_logic;
   s_axi_csr_awready     : out std_logic;
   s_axi_csr_wdata       : in  std_logic_vector(31 downto 0);
   s_axi_csr_wstrb       : in  std_logic_vector(3 downto 0); 
   s_axi_csr_wvalid      : in  std_logic;
   s_axi_csr_wready      : out std_logic;
   s_axi_csr_bresp       : out std_logic_vector(1 downto 0);
   s_axi_csr_bvalid      : out std_logic;
   s_axi_csr_bready      : in  std_logic;
   s_axi_csr_araddr      : in  std_logic_vector(6 downto 0);
   s_axi_csr_arprot      : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_arvalid     : in  std_logic;
   s_axi_csr_arready     : out std_logic;
   s_axi_csr_rdata       : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp       : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid      : out std_logic;
   s_axi_csr_rready      : in  std_logic;
--------------------------------------------------------------------------------
-- Packet Size Override  
--------------------------------------------------------------------------------
   -- synchronous with axis_aclk
   override_pkt_size_en  : in std_logic;
   override_pkt_size     : in std_logic_vector(16 downto 0);  -- packet length in bytes 
   ----------------------------------------------------------------------------
   axis_aclk             : in  std_logic;
   axis_aresetn          : in  std_logic; 
   -----------------------------------------------------------------------------
   -- FIFO Reset In
   -----------------------------------------------------------------------------
   -- synchronous witn axis_aclk
   fifo_rst_in_n         : in  std_logic;
   -----------------------------------------------------------------------------
   -- AXI-S PPKT Input Stream
   -----------------------------------------------------------------------------    
   s_axis_ppkt_tvalid    : in  std_logic;
   s_axis_ppkt_tready    : out std_logic;
   s_axis_ppkt_tdata     : in  std_logic_vector((word_width*16)-1 downto 0);
   -- tuser[63:0]    = timestamp[63:0]  
   -- tuser[64]      = SOP   
   -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
   -- tuser[67]      = Data Type 0 = Real 1 = I/Q
   -- tuser[75:68]   = channel[7:0]
   -- tuser[79:76]   = user[3:0] These bits only valid only with tlast   
   s_axis_ppkt_tuser     : in  std_logic_vector(79 downto 0);
   s_axis_ppkt_tkeep     : in  std_logic_vector(word_width-1 downto 0); -- One per 16-bit word (Note this is not standard 1 per byte)
   s_axis_ppkt_tlast     : in  std_logic; -- end of packet
   -----------------------------------------------------------------------------
   -- AXI-S to Packet type FIFO
   -----------------------------------------------------------------------------
   m_axis_pktfifo_aresetn: out std_logic;
   m_axis_pktfifo_tvalid : out std_logic;
   m_axis_pktfifo_tready : in  std_logic;
   m_axis_pktfifo_tdata  : out std_logic_vector((word_width*16)-1 downto 0); 
   m_axis_pktfifo_tuser  : out std_logic_vector(103 downto 0);
   m_axis_pktfifo_tkeep  : out std_logic_vector((word_width*2)-1 downto 0); -- One per byte
   m_axis_pktfifo_tlast  : out std_logic; -- end of packet
   -----------------------------------------------------------------------------
   -- AXI-S from Packet type FIFO
   -----------------------------------------------------------------------------  
   s_axis_pktfifo_tvalid : in  std_logic;
   s_axis_pktfifo_tready : out std_logic;
   s_axis_pktfifo_tdata  : in  std_logic_vector((word_width*16)-1 downto 0); 
   s_axis_pktfifo_tuser  : in  std_logic_vector(103 downto 0);
   s_axis_pktfifo_tkeep  : in  std_logic_vector((word_width*2)-1 downto 0); -- One per byte
   s_axis_pktfifo_tlast  : in  std_logic; -- end of packet    
   -----------------------------------------------------------------------------
   -- AXI-S PPLD Output Stream
   -----------------------------------------------------------------------------
   m_axis_ppld_tvalid    : out std_logic;
   m_axis_ppld_tready    : in  std_logic;
   m_axis_ppld_tdata     : out std_logic_vector((word_width*16)-1 downto 0);
   -- tuser[63:0]    = timestamp[63:0]  
   -- tuser[64]      = Start of Payload Packet   
   -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
   -- tuser[67]      = Data Type 0 = Real 1 = I/Q
   -- tuser[75:68]   = channel[7:0]
   -- tuser[78:76]   = Reserved
   -- tuser[79]      = Acq. End (Input PPKT had tlast)
   -- tuser[96:80]   = Payload Size (bytes)
   -- tuser[103:97]  = Number Valid Bytes in cycle
   m_axis_ppld_tuser     : out std_logic_vector(103 downto 0);
   m_axis_ppld_tkeep     : out std_logic_vector((word_width*2)-1 downto 0); -- One per byte
   m_axis_ppld_tlast     : out std_logic -- End of Payload Packet    
);
end px_axis_ppkt2ppld;

architecture Behavioral of px_axis_ppkt2ppld is

function tkeep_reduce(tkeep: std_logic_vector(word_width-1 downto 0)) return integer is
variable i: integer := 0;
variable count : integer := 0;
begin
   while (i < word_width) and (tkeep(i) = '1') loop
      count := count + 1;
      i := i + 1; 
   end loop;
   return count;
end tkeep_reduce;

function tkeep_expand(tkeep: std_logic_vector(word_width-1 downto 0)) return std_logic_vector is
variable i: integer := 0;
variable out_tkeep : std_logic_vector((word_width*2)-1 downto 0);
begin
   for i in 0 to (word_width-1) loop
      out_tkeep(2*i)     := tkeep(i);
      out_tkeep((2*i)+1) := tkeep(i);
   end loop;
   return out_tkeep;
end tkeep_expand;

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_ppkt:m_axis_pktfifo:s_axis_pktfifo:m_axis_ppld, ASSOCIATED_RESET axis_aresetn";

-------------------------------------------------------------------------------
-- Types
-------------------------------------------------------------------------------

type axi_state_type is
(
    RESET_STATE,
    WR_ADDR_DATA_STATE,
    WR_DATA_STATE,
    WR_ADDR2_STATE,
    WR_ADDR_STATE,
    WR_DATA2_STATE,
    WR_ADDR_DEC_STATE,
    WR_B_RSP_STATE,
    RD_ADDR_STATE,
    WAIT_RD_BS_STATE,
    WAIT_RDDATA_RDY_STATE
);
type in_state_type is
(
    RESET_STATE,
    FIRST_STATE,
    PLYD_STATE,
    WAIT_STATE
);

-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal payload_sizex    : std_logic_vector(16 downto 0)  :=  (others => '0');
signal axi_state        : axi_state_type := RESET_STATE;
signal payload_size_reg : std_logic_vector(19 downto 0)  := (others => '0');
signal rd_data          : std_logic_vector(19 downto 0)  := (others => '0');
signal w_data           : std_logic_vector(19 downto 0)  := (others => '0');
signal w_strb           : std_logic := '0';
signal src_senda        : std_logic:= '0';
signal src_rcva         : std_logic:= '0';
signal dest_reqa        : std_logic:= '0';
signal t1_s_axi_csr_aresetn: std_logic:= '0';
signal t1_axis_aresetn  : std_logic:= '0';
signal sm_tready        : std_logic:= '0';
signal in_count         : std_logic_vector(16 downto 0) := (others => '0');
signal in_state         : in_state_type := RESET_STATE;
signal fifo_flush_n     : std_logic := '0';
signal incr             : integer;
signal max_count_m1     : std_logic_vector(16 downto 0) := (others => '0');
signal count_latch      : std_logic := '0';
signal sop              : std_logic := '0';
signal payload_count    : std_logic_vector(16 downto 0) := (others => '0');
signal rst_n            : std_logic := '0';
signal count_fifo_afl   : std_logic := '0';
signal count_fifo_rst   : std_logic := '0';
signal count_fifo_full  : std_logic := '0';
signal count_fifo_read  : std_logic := '0';
signal count_fifo_empty : std_logic := '0';
signal t1_override_pkt_size_en: std_logic := '0';
signal t1_override_pkt_size: std_logic_vector(16 downto 0) := (others => '0');
signal size_reg: std_logic_vector(16 downto 0) := (others => '0');
signal size_regx: std_logic_vector(16 downto 0) := (others => '0');
signal t1_fifo_rst_in_n : std_logic := '0';
signal fifo_flush_r_n   : std_logic := '0';

begin


-------------------------------------------------------------------------------
-- AXI4-Lite Interface State Machine
-------------------------------------------------------------------------------
process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
        t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
        if t1_s_axi_csr_aresetn = '0' then
           axi_state           <= RESET_STATE;
           s_axi_csr_awready   <= '0'; 
           s_axi_csr_wready    <= '0';  
           s_axi_csr_arready   <= '0'; 
           s_axi_csr_rvalid    <= '0';  
           s_axi_csr_bvalid    <= '0';
           payload_size_reg(16 downto 0)  <= conv_std_logic_vector(default_packet_size,17);
           payload_size_reg(19 downto 17) <= "000"; 
        else 
           case axi_state is 
            when RESET_STATE =>
                if (t1_s_axi_csr_aresetn = '0') then
                    axi_state           <= RESET_STATE;
                    s_axi_csr_awready   <= '0';
                    s_axi_csr_wready    <= '0';
                    s_axi_csr_arready   <= '0'; 
                    s_axi_csr_rvalid    <= '0';  
                    s_axi_csr_bvalid    <= '0';
                    payload_size_reg(16 downto 0)  <= conv_std_logic_vector(default_packet_size,17);
                    payload_size_reg(19 downto 17) <= "000"; 
                elsif (s_axi_csr_awvalid = '1') then  
                    if (s_axi_csr_wvalid = '1') then
                        axi_state <=  WR_ADDR_DATA_STATE;
                    else
                        axi_state <=  WR_ADDR_STATE;
                    end if; 
                elsif (s_axi_csr_wvalid = '1') then
                    axi_state <=  WR_DATA_STATE;
                elsif (s_axi_csr_arvalid = '1') then
                    axi_state <=  RD_ADDR_STATE;
                else
                    axi_state <= RESET_STATE;
                end if;    
             when WR_ADDR_DATA_STATE =>
                s_axi_csr_wready  <= '1';
                s_axi_csr_awready <= '1';       
                w_strb            <= s_axi_csr_wstrb(0);
                w_data            <= s_axi_csr_wdata(19 downto 0);
                axi_state         <= WR_ADDR_DEC_STATE;
             when WR_DATA_STATE =>
                s_axi_csr_wready  <= '1';
                w_strb            <= s_axi_csr_wstrb(0);
                w_data            <= s_axi_csr_wdata(19 downto 0);
                axi_state         <= WR_ADDR2_STATE;
             when WR_ADDR2_STATE =>
                s_axi_csr_wready     <= '0';
                if (s_axi_csr_awvalid = '1') then      
                   axi_state  <= WR_ADDR_DEC_STATE;
                   s_axi_csr_awready <= '1';
                else
                   axi_state         <= WR_ADDR2_STATE;
                end if;  
             when WR_ADDR_STATE =>
                   s_axi_csr_awready <= '1';
                   axi_state     <= WR_DATA2_STATE;
             when WR_DATA2_STATE =>
                s_axi_csr_awready <= '0';
                if (s_axi_csr_wvalid = '1') then      
                   axi_state        <= WR_ADDR_DEC_STATE;
                   s_axi_csr_wready <= '1';
                   w_strb           <= s_axi_csr_wstrb(0);
                   w_data           <= s_axi_csr_wdata(19 downto 0);
                else
                   axi_state  <= WR_DATA2_STATE;
                end if;    
             when WR_ADDR_DEC_STATE =>
                s_axi_csr_wready  <= '0';
                s_axi_csr_awready <= '0';   
                if w_strb = '1' then
                  payload_size_reg           <= w_data(19 downto 0);
                end if;                   
                axi_state         <= WR_B_RSP_STATE;
                s_axi_csr_bresp   <= "00";
                s_axi_csr_bvalid  <= '1';     
            when  WR_B_RSP_STATE =>
                if s_axi_csr_bready = '1' then
                    s_axi_csr_bvalid <= '0';
                    axi_state <= RESET_STATE;
                else
                    axi_state <= WR_B_RSP_STATE;
                end if;    
            when  RD_ADDR_STATE =>
               s_axi_csr_arready <= '1';
               rd_data     <= payload_size_reg; 
               axi_state   <= WAIT_RD_BS_STATE;
            when WAIT_RD_BS_STATE =>
                s_axi_csr_arready <= '0';
                s_axi_csr_rdata(19 downto 0) <= rd_data;
                s_axi_csr_rvalid  <= '1'; 
                s_axi_csr_rresp   <= "00";
                axi_state         <= WAIT_RDDATA_RDY_STATE;              
            when WAIT_RDDATA_RDY_STATE =>   
                if s_axi_csr_rready = '1' then
                   s_axi_csr_rvalid <= '0';
                   axi_state        <= RESET_STATE;
                else
                   axi_state        <= WAIT_RDDATA_RDY_STATE;     
                end if;  
            when others =>
               axi_state <= RESET_STATE;
          end case;
       end if;
   end if;  
end process;

s_axi_csr_rdata(31 downto 20) <= x"000";

--------------------------------------------------------------------------------
-- Clock Boundary Crossing
--------------------------------------------------------------------------------

ctl_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 3, -- integer; range: 2-10
  WIDTH          => 17 -- integer; range: 1-1024
)
port map (
  src_clk    => s_axi_csr_aclk,
  src_in     => size_reg, --payload_size_reg(16 downto 0),
  src_send   => src_senda,
  src_rcv    => src_rcva,
  dest_clk   => axis_aclk,
  dest_req   => dest_reqa,
  dest_ack   => dest_reqa, 
  dest_out   => payload_sizex
);

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     if (src_rcva = '1') then
       src_senda <= '0';
     elsif (src_rcva = '0') and (src_senda = '0') then
       src_senda <= '1';
     end if;  
     size_reg <= payload_size_reg(16 downto 0);
   end if;
end process;

process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      t1_fifo_rst_in_n <= fifo_rst_in_n;
      fifo_flush_n <= fifo_flush_r_n and t1_fifo_rst_in_n;
      t1_override_pkt_size_en <= override_pkt_size_en;
      t1_override_pkt_size    <= override_pkt_size;
      if t1_override_pkt_size_en = '0' then
         size_regx <= payload_sizex;
      else
         size_regx <= t1_override_pkt_size;
      end if;
      max_count_m1 <= size_regx - (word_width*2); 
   end if;
end process;
   
incr <= (word_width*2) when (s_axis_ppkt_tlast = '0') else
        (tkeep_reduce(s_axis_ppkt_tkeep)*2);

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     rst_n <= not (payload_size_reg(17) or (not t1_s_axi_csr_aresetn));
   end if;
end process;
         
cdc_async_rst_inst: xpm_cdc_async_rst
generic map (
  -- Common module parameters
   DEST_SYNC_FF    => 3, -- integer; range: 2-10
   INIT_SYNC_FF    => 0, -- integer; 0=disable simulation init values, 1=enable simulation init values
   RST_ACTIVE_HIGH => 0  -- integer; 0=active low reset, 1=active high reset
)
port map (
   src_arst  => rst_n,
   dest_clk  => axis_aclk,
   dest_arst => fifo_flush_r_n
);

--------------------------------------------------------------------------------
-- Input State Machine
--------------------------------------------------------------------------------
process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      count_fifo_rst <= not (t1_axis_aresetn and fifo_flush_n);
      m_axis_pktfifo_aresetn <= t1_axis_aresetn and fifo_flush_n;
      t1_axis_aresetn <= axis_aresetn;
      if (t1_axis_aresetn = '0') or (fifo_flush_n = '0') then
         sm_tready <= '0';
         in_state <= RESET_STATE;
         in_count <= (others => '0');
         count_latch <= '0';
         sop      <= '1';
      else
         case in_state is
            when RESET_STATE =>
               if  (t1_axis_aresetn = '1') and (fifo_flush_n = '1') then
                  sm_tready <= '1';
                  in_state <= FIRST_STATE;
                  in_count <= (others => '0');
                  count_latch <= '0';
                  sop <= '1';
               end if;
            when FIRST_STATE =>  --
               if (s_axis_ppkt_tvalid = '1') and (m_axis_pktfifo_tready = '1') then
                  if (s_axis_ppkt_tlast = '1') or (in_count >= max_count_m1) then
                     in_state <= WAIT_STATE;
                     sm_tready <= '0';
                     count_latch <= '1';
                  else
                     in_state <= PLYD_STATE;
                  end if;
                  in_count <= in_count + incr;
                  sop      <= '0';
               end if;
            when PLYD_STATE  =>
              if (s_axis_ppkt_tvalid = '1') and (m_axis_pktfifo_tready = '1') then
                if (s_axis_ppkt_tlast = '1') or (in_count >= max_count_m1) then
                  in_state <= WAIT_STATE;
                  sm_tready <= '0';
                  count_latch <= '1';
               end if;
               in_count <= in_count + incr;
              end if; 
              sop      <= '0';
            when WAIT_STATE  =>
               count_latch <= '0';
               if (count_fifo_afl = '0') then
                  in_state <= FIRST_STATE;
                  sm_tready <= '1';
                  in_count <= (others => '0');
                  sop <= '1';
               end if;
            when others =>
               in_state <= RESET_STATE;
         end case;
      end if;
   end if;
end process;

count_fifo_inst : xpm_fifo_sync
  generic map (
    FIFO_MEMORY_TYPE         => "distributed",           --string; "auto", "block", "distributed", or "ultra" ;
    ECC_MODE                 => "no_ecc",         --string; "no_ecc" or "en_ecc";
    FIFO_WRITE_DEPTH         => 32,             --positive integer
    WRITE_DATA_WIDTH         => 17,               --positive integer
    WR_DATA_COUNT_WIDTH      => 5,               --positive integer
    PROG_FULL_THRESH         => 10,               --positive integer
    FULL_RESET_VALUE         => 0,                --positive integer; 0 or 1;
    USE_ADV_FEATURES         => "0008",           --string; "0000" to "1F1F";
    READ_MODE                => "fwft",            --string; "std" or "fwft";
    FIFO_READ_LATENCY        => 0,                --positive integer;
    READ_DATA_WIDTH          => 17,               --positive integer
    RD_DATA_COUNT_WIDTH      => 5,               --positive integer
    PROG_EMPTY_THRESH        => 10,               --positive integer
    DOUT_RESET_VALUE         => "0",              --string
    WAKEUP_TIME              => 0                 --positive integer; 0 or 2;
  )
  port map (
    rst              => count_fifo_rst,
    wr_clk           => axis_aclk,
    wr_en            => count_latch,
    din              => in_count,
    full             => count_fifo_full,
    overflow         => open,
    wr_rst_busy      => open,
    prog_full        => open,
    wr_data_count    => open,
    almost_full      => count_fifo_afl,
    wr_ack           => open,
    rd_en            => count_fifo_read,
    dout             => payload_count,
    empty            => count_fifo_empty,
    underflow        => open,
    rd_rst_busy      => open,
    prog_empty       => open,
    rd_data_count    => open,
    almost_empty     => open,
    data_valid       => open,
    sleep            => '0',
    injectsbiterr    => '0',
    injectdbiterr    => '0',
    sbiterr          => open,
    dbiterr          => open
  );

count_fifo_read <= m_axis_ppld_tready and s_axis_pktfifo_tvalid and s_axis_pktfifo_tuser(64) and (not count_fifo_empty);

s_axis_ppkt_tready                  <= sm_tready and s_axis_ppkt_tvalid and m_axis_pktfifo_tready;
m_axis_pktfifo_tvalid               <= sm_tready and s_axis_ppkt_tvalid and m_axis_pktfifo_tready;
m_axis_pktfifo_tuser(63 downto 0)   <= s_axis_ppkt_tuser(63 downto 0);
m_axis_pktfifo_tuser(64)            <= sop;
m_axis_pktfifo_tuser(78 downto 65)  <= s_axis_ppkt_tuser(78 downto 65);
m_axis_pktfifo_tuser(79)            <= s_axis_ppkt_tlast;
m_axis_pktfifo_tuser(96 downto 80)  <= (others => '0'); 
m_axis_pktfifo_tuser(103 downto 97) <= conv_std_logic_vector(incr,7);
m_axis_pktfifo_tkeep                <= tkeep_expand(s_axis_ppkt_tkeep);
m_axis_pktfifo_tdata                <= s_axis_ppkt_tdata;

process(s_axis_ppkt_tlast,in_count, max_count_m1)
begin
   if (in_count >= max_count_m1) then
      m_axis_pktfifo_tlast  <= '1';
   else
      m_axis_pktfifo_tlast  <= s_axis_ppkt_tlast;
   end if;
end process;   

m_axis_ppld_tvalid                  <= (not (count_fifo_empty and s_axis_pktfifo_tuser(64))) and s_axis_pktfifo_tvalid;
m_axis_ppld_tlast                   <= s_axis_pktfifo_tlast;
s_axis_pktfifo_tready               <= (not (count_fifo_empty and s_axis_pktfifo_tuser(64))) and m_axis_ppld_tready;
m_axis_ppld_tkeep                   <= s_axis_pktfifo_tkeep; 
m_axis_ppld_tdata                   <= s_axis_pktfifo_tdata; 
m_axis_ppld_tuser(79 downto 0)      <= s_axis_pktfifo_tuser(79 downto 0);
m_axis_ppld_tuser(96 downto 80)     <= "00000000000000000" when (s_axis_pktfifo_tuser(64) = '0') else payload_count;
m_axis_ppld_tuser(103 downto 97)    <= s_axis_pktfifo_tuser(103 downto 97);
 

end Behavioral;
