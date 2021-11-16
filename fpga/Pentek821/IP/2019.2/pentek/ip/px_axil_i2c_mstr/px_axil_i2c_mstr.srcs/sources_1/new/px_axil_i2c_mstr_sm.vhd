----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 04/18/2015 12:36:26 PM
-- Design Name: 
-- Module Name: px_axil_i2c_sm - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: State Machine for px_axil_i2c_mstr 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axil_i2c_mstr_sm is
port (
   -----------------------------------------------------------------------------
   -- Control/Status
   -----------------------------------------------------------------------------
   clk_division   : in  std_logic_vector(9 downto 0); -- clk/output rate*4
   enable         : in  std_logic;  -- Enable I2C Port  
   strt_pls       : in  std_logic;  -- Start Pulse
   addr           : in  std_logic_vector(6 downto 0); --I2C Address
   restart_mode   : in  std_logic;  -- Restart Mode
   r_w_n          : in  std_logic; -- Data direction (0 = write, 1 = read)
   num_bytes      : in  std_logic_vector(3 downto 0);    -- (# of bytes-1) to transfer
   fifo_flush     : in  std_logic; -- FIFO Flush
   trns_done_int  : out std_logic; -- Transaction Dome (One clock Pulse)
   no_ack_int     : out std_logic; -- No Acknoledgement
   busy_out       : out std_logic; -- Transaction in progress
   -- Number of data bytes available to read in the FIFO
   rd_fifo_cnt    : out std_logic_vector(4 downto 0);
   rd_fifo_full   : out std_logic; -- RX Full
   rd_fifo_empty  : out std_logic; -- RX Empty
   -- Number of data bytes ready to be transmitted
   wr_fifo_cnt    : out std_logic_vector(4 downto 0);
   wr_fifo_full   : out std_logic; -- TX Full
   wr_fifo_empty  : out std_logic; -- TX Empty
   --------------------------------------------------------------------------------
   -- AXI LITE Slave Interface  
   -- DWORD Addressing
   -- FIFO Read/Write Interface
   --------------------------------------------------------------------------------
   s_axi_csr_aclk      : in  std_logic;  -- Clock for whole module (250 MHz)
   s_axi_csr_aresetn   : in  std_logic;
   s_axi_csr_awaddr    : in  std_logic_vector(2 downto 0);
   s_axi_csr_awprot    : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_awvalid   : in  std_logic;
   s_axi_csr_awready   : out std_logic;
   s_axi_csr_wdata     : in  std_logic_vector(31 downto 0);
   s_axi_csr_wstrb     : in  std_logic_vector(3 downto 0); -- not used
   s_axi_csr_wvalid    : in  std_logic;
   s_axi_csr_wready    : out std_logic;
   s_axi_csr_bresp     : out std_logic_vector(1 downto 0);
   s_axi_csr_bvalid    : out std_logic;
   s_axi_csr_bready    : in  std_logic;
   s_axi_csr_araddr    : in  std_logic_vector(2 downto 0);
   s_axi_csr_arprot    : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_arvalid   : in  std_logic;
   s_axi_csr_arready   : out std_logic;
   s_axi_csr_rdata     : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp     : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid    : out std_logic;
   s_axi_csr_rready    : in  std_logic;
   -----------------------------------------------------------------------------
   -- I2C Signals
   -----------------------------------------------------------------------------
   oe_n           : out std_logic;
   scl_in         : in  std_logic;
   scl_out        : out std_logic;
   sda_in         : in  std_logic;
   sda_out        : out std_logic
   
);
end px_axil_i2c_mstr_sm;

architecture Behavioral of px_axil_i2c_mstr_sm is

-------------------------------------------------------------------------------
-- Components
-------------------------------------------------------------------------------

-- FIFO
-- FWFT
-- 8 wide
-- 16 deep
-- Distributed RAM
COMPONENT px_i2c_fifo
  PORT (
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    data_count : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
  );
END COMPONENT;

-- AXI-Lite to Native FIFO
-- FIFO Latency = 0
-- 8-bit FIFO interface
COMPONENT px_i2c_axil_nativefifo_ctlr
  PORT (
    s_axi_aclk : IN STD_LOGIC;
    s_axi_aresetn : IN STD_LOGIC;
    s_axi_awaddr : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
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
    s_axi_araddr : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_arvalid : IN STD_LOGIC;
    s_axi_arready : OUT STD_LOGIC;
    s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_rvalid : OUT STD_LOGIC;
    s_axi_rready : IN STD_LOGIC;
    fifo_rst : OUT STD_LOGIC;
    fifo_clk : OUT STD_LOGIC;
    fifo_wr_en : OUT STD_LOGIC;
    fifo_din : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    fifo_full : IN STD_LOGIC;
    fifo_rd_en : OUT STD_LOGIC;
    fifo_dout : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    fifo_empty : IN STD_LOGIC
  );
END COMPONENT;

-------------------------------------------------------------------------------
-- Types
-------------------------------------------------------------------------------

type state_mach_states is (
   reset_state,
   begin_state,  
   en_twsi_intrfc_state,
   wait_for_rqst,
   start_cycle, -- Start State
   start_cycle_a,
   header_cycle1a,-- Header MSB bit 7
   header_cycle1b,-- Header bit 7
   header_cycle1c,-- Header bit 7
   header_cycle2a,-- Header bit 6
   header_cycle2b,-- Header bit 6
   header_cycle2c,-- Header bit 6
   header_cycle3a,-- Header bit 5
   header_cycle3b,-- Header bit 5
   header_cycle3c,-- Header bit 5
   header_cycle4a,-- Header bit 4
   header_cycle4b,-- Header bit 4
   header_cycle4c,-- Header bit 4
   header_cycle5a,-- Header bit 3
   header_cycle5b,-- Header bit 3
   header_cycle5c,-- Header bit 3
   header_cycle6a,-- Header bit 2
   header_cycle6b,-- Header bit 2
   header_cycle6c,-- Header bit 2
   header_cycle7a,-- Header bit 1
   header_cycle7b,-- Header bit 1
   header_cycle7c,-- Header bit 1
   header_wr_bit_cycle1, -- write command bit
   header_wr_bit_cycle1a, -- write command bit
   header_wr_bit_cycle2, -- write command bit
   header_rd_bit_cycle1, -- read command bit
   header_rd_bit_cycle1a, -- read command bit
   header_rd_bit_cycle2, -- read command bit
   header_ack_cycle1, -- Header ACK cycle
   header_ack_cycle1a, -- Header ACK cycle
   header_ack_cycle2, -- Header ACK cycle
   tx_cycle1a, -- Tx Data bit 7
   tx_cycle1b, -- Tx Data bit 7
   tx_cycle1c, -- Tx Data bit 7
   tx_cycle2a, -- Tx Data bit 6
   tx_cycle2b, -- Tx Data bit 6
   tx_cycle2c, -- Tx Data bit 6
   tx_cycle3a, -- Tx Data bit 5
   tx_cycle3b, -- Tx Data bit 5
   tx_cycle3c, -- Tx Data bit 5
   tx_cycle4a, -- Tx Data bit 4
   tx_cycle4b, -- Tx Data bit 4
   tx_cycle4c, -- Tx Data bit 4
   tx_cycle5a, -- Tx Data bit 3
   tx_cycle5b, -- Tx Data bit 3
   tx_cycle5c, -- Tx Data bit 3
   tx_cycle6a, -- Tx Data bit 2
   tx_cycle6b, -- Tx Data bit 2
   tx_cycle6c, -- Tx Data bit 2
   tx_cycle7a, -- Tx Data bit 1
   tx_cycle7b, -- Tx Data bit 1
   tx_cycle7c, -- Tx Data bit 1
   tx_cycle8a, -- Tx Data bit 0
   tx_cycle8b, -- Tx Data bit 0
   tx_cycle8c, -- Tx Data bit 0
   tx_ack_cycle1, -- Tx Ack Cycle
   tx_ack_cycle1a, -- Tx Ack Cycle
   tx_ack_cycle2, -- Tx Ack Cycle
   tx_tst_last_cycle, -- test if last word
   tx_finished_cycle, -- Tx finished Cycle
   tx_finished_cycle_a, -- Tx finished Cycle
   tx_stop_cycle, -- Tx Stop bit cycle
   rx_cycle1a, -- Rx Data bit 7
   rx_cycle1b, -- Rx Data bit 7
   rx_cycle1c, -- Rx Data bit 7
   rx_cycle2a, -- Rx Data bit 6
   rx_cycle2b, -- Rx Data bit 6
   rx_cycle2c, -- Rx Data bit 6
   rx_cycle3a, -- Rx Data bit 5
   rx_cycle3b, -- Rx Data bit 5
   rx_cycle3c, -- Rx Data bit 5
   rx_cycle4a, -- Rx Data bit 4
   rx_cycle4b, -- Rx Data bit 4
   rx_cycle4c, -- Rx Data bit 4
   rx_cycle5a, -- Rx Data bit 3
   rx_cycle5b, -- Rx Data bit 3
   rx_cycle5c, -- Rx Data bit 3
   rx_cycle6a, -- Rx Data bit 2
   rx_cycle6b, -- Rx Data bit 2
   rx_cycle6c, -- Rx Data bit 2
   rx_cycle7a, -- Rx Data bit 1
   rx_cycle7b, -- Rx Data bit 1
   rx_cycle7c, -- Rx Data bit 1
   rx_cycle8a, -- Rx Data bit 0
   rx_cycle8b, -- Rx Data bit 0
   rx_cycle8c, -- Rx Data bit 0
   rx_ack_cycle1, -- Rx Ack Cycle
   rx_ack_cycle1a, -- Rx Ack Cycle
   rx_ack_cycle2, -- Rx Ack Cycle
   rx_no_ack_cycle1a, -- Rx No Ack Cycle
   rx_no_ack_cycle2, -- Rx No Ack Cycle
   rx_finish_cycle, -- Rx finished Cycle
   rx_finish_cycle_a, -- Rx finished Cycle
   rx_stop_cycle  -- Rx Stop bit cycle
);

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal state            : state_mach_states;
signal clk_cntr         : std_logic_vector(11 downto 0) := x"000";
signal rate_div         : std_logic_vector(11 downto 0) := x"000";
signal sm_ce            : std_logic := '0';
signal clkout_ce        : std_logic := '0';
signal strt_reg         : std_logic := '0';
signal t1_r_w_n         : std_logic := '0';
signal busy             : std_logic := '0';
signal int_sda_out      : std_logic := '0';
signal wr_data_fifo_rd  : std_logic := '0';
signal shift_in         : std_logic := '0';
signal rd_data_fifo_wr  : std_logic := '0';
signal no_ack           : std_logic := '0';
signal trns_done        : std_logic := '0';
signal tx_full          : std_logic := '0';
signal tx_empty         : std_logic := '0';
signal tx_data_count    : std_logic_vector(4 downto 0) := "00000";
signal rx_full          : std_logic := '0';
signal rx_empty         : std_logic := '0';
signal rx_data_count    : std_logic_vector(4 downto 0) := "00000";
signal tx_fifo_rd       : std_logic := '0';
signal rx_fifo_wr       : std_logic := '0';
signal t1_num_bytes     : std_logic_vector(3 downto 0) := "0000";
signal trns_cntr        : std_logic_vector(3 downto 0) := "0000";
signal last_word        : std_logic := '0';
signal t1_addr          : std_logic_vector(6 downto 0) := "0000000";
signal tx_fifo_dout     : std_logic_vector(7 downto 0) := x"00";
signal rx_fifo_dout     : std_logic_vector(7 downto 0) := x"00";
signal rx_sr            : std_logic_vector(7 downto 0) := x"00";
signal fifo_rst         : std_logic := '0';
signal fifo_wr          : std_logic;
signal fifo_rd          : std_logic;
signal wr_data          : std_logic_vector(7 downto 0);
signal rd_data          : std_logic_vector(7 downto 0);
signal t1_strt_pls      : std_logic := '0';
signal t2_strt_pls      : std_logic := '0';
signal t1_trns_done     : std_logic := '0';
signal t1_restart_mode  : std_logic := '0';
signal t1_fifo_flush    : std_logic := '0'; 
signal fifo_rst_or      : std_logic := '0'; 

--------------------------------------------------------------------------------


begin
--------------------------------------------------------------------------------
-- AXI-Lite to Native FIFO Interface
--------------------------------------------------------------------------------

fifo_ctlr_inst: px_i2c_axil_nativefifo_ctlr
port map (
    s_axi_aclk    => s_axi_csr_aclk,
    s_axi_aresetn => s_axi_csr_aresetn,
    s_axi_awaddr  => s_axi_csr_awaddr,
    s_axi_awprot  => s_axi_csr_awprot,
    s_axi_awvalid => s_axi_csr_awvalid,
    s_axi_awready => s_axi_csr_awready,
    s_axi_wdata   => s_axi_csr_wdata,
    s_axi_wstrb   => s_axi_csr_wstrb,
    s_axi_wvalid  => s_axi_csr_wvalid,
    s_axi_wready  => s_axi_csr_wready,
    s_axi_bresp   => s_axi_csr_bresp,
    s_axi_bvalid  => s_axi_csr_bvalid,
    s_axi_bready  => s_axi_csr_bready,
    s_axi_araddr  => s_axi_csr_araddr,
    s_axi_arprot  => s_axi_csr_arprot,
    s_axi_arvalid => s_axi_csr_arvalid,
    s_axi_arready => s_axi_csr_arready,
    s_axi_rdata   => s_axi_csr_rdata,
    s_axi_rresp   => s_axi_csr_rresp,
    s_axi_rvalid  => s_axi_csr_rvalid,
    s_axi_rready  => s_axi_csr_rready,
    fifo_rst      => fifo_rst,
    fifo_clk      => open,
    fifo_wr_en    => fifo_wr,
    fifo_din      => wr_data,
    fifo_rd_en    => fifo_rd,
    fifo_dout     => rd_data,
    fifo_full     => tx_full,
    fifo_empty    => rx_empty
  );

--------------------------------------------------------------------------------
-- Rate Dividers
--------------------------------------------------------------------------------

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
      rate_div <= ("00" & clk_division) -1;
      if (s_axi_csr_aresetn = '0') then
         clk_cntr       <= x"000";
         sm_ce          <= '0';
         clkout_ce      <= '0';
      else   
         -- create clock enables1
         if (conv_integer('0' & clk_cntr(11 downto 0)) = conv_integer('0' & rate_div)) then
            sm_ce    <= '1';
            clk_cntr <= x"000";
         else
            sm_ce    <= '0';
            clk_cntr <= clk_cntr + 1;
         end if;
         if (conv_integer('0' & clk_cntr(11 downto 0) & '0') = conv_integer('0' & rate_div)) or 
            (conv_integer('0' & clk_cntr(11 downto 0)) = conv_integer('0' & rate_div)) then
            clkout_ce    <= '1';
         else
            clkout_ce    <= '0';
         end if;
      end if;   
   end if;
end process;

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if (s_axi_csr_aresetn = '0') then
         busy_out       <= '0';
         no_ack_int     <= '0';
         trns_done_int  <= '0';
         wr_fifo_full   <= '0';
         wr_fifo_empty  <= '0';
         wr_fifo_cnt    <= "00000";
         rd_fifo_full   <= '0';
         rd_fifo_empty  <= '0';
         rd_fifo_cnt    <= "00000";
         strt_reg       <= '0';
         t1_r_w_n       <= '0';
         t1_num_bytes   <= (others => '0');
         t1_addr        <= (others => '0');
         trns_cntr      <= (others => '0');
         last_word      <= '0';
         t1_restart_mode <= '0';
         t1_fifo_flush  <= '1';
      else
         t1_fifo_flush  <= fifo_flush;
         t1_restart_mode <= restart_mode;
         t1_strt_pls    <= strt_pls;
         t2_strt_pls  <= t1_strt_pls;
         if (t1_strt_pls = '1') and (t2_strt_pls = '0') then
            strt_reg    <= '1';
         elsif busy = '1' then
            strt_reg    <= '0';
         end if;
         t1_num_bytes   <= num_bytes;
         t1_addr        <= addr;
         -- Count data bytes transferred
         if (strt_reg = '1') then
            trns_cntr <= t1_num_bytes;
         elsif ((tx_fifo_rd = '1') or (rx_fifo_wr = '1')) and (sm_ce = '1') then
            trns_cntr <= trns_cntr - 1;
         end if;
         -- signal when last word to be transferred is reached
         if (trns_cntr = "0000") then
            last_word <= '1';
         else
            last_word <= '0';
         end if;
         busy_out       <= busy or strt_reg;
         no_ack_int     <= no_ack;
         t1_trns_done   <= trns_done;
         wr_fifo_full   <= tx_full;
         wr_fifo_empty  <= tx_empty;
         wr_fifo_cnt    <= tx_data_count;
         rd_fifo_full   <= rx_full;
         rd_fifo_empty  <= rx_empty;
         rd_fifo_cnt    <= rx_data_count;
         t1_trns_done   <=  trns_done;
         trns_done_int  <= t1_trns_done and not trns_done;
         if strt_reg = '1' then
            t1_r_w_n    <= r_w_n; -- latch data direction
         end if;
       end if;  
   end if;
end process;

-------------------------------------------------------------------------------
-- I2C Port Controller State Machine
-------------------------------------------------------------------------------
process(s_axi_csr_aclk)
begin 
if rising_edge(s_axi_csr_aclk) then
      if (s_axi_csr_aresetn = '0') or (enable  = '0') then
         state            <= reset_state;
         oe_n             <= '1';
         busy             <= '0';
         int_sda_out      <= '1';
         scl_out          <= '1';
         wr_data_fifo_rd  <= '0';
         shift_in         <= '0';
         rd_data_fifo_wr  <= '0';
         no_ack           <= '0';
         trns_done        <= '0';
      elsif ( sm_ce  = '1') then
         case  state  is
            -- Reset State
            when reset_state =>
               state           <= begin_state;
               oe_n            <= '1';
               busy            <= '0';
               int_sda_out     <= '1';
               scl_out         <= '1';
               wr_data_fifo_rd <= '0';
               shift_in        <= '0';
               rd_data_fifo_wr <= '0';
               no_ack          <= '0';
               trns_done       <= '0';
            -- Begin State
            when begin_state => 
               state           <= en_twsi_intrfc_state;
               trns_done       <= '0';
               int_sda_out     <= '1';
               scl_out         <= '1';
               oe_n            <= '1';
            -- Enable the I2C interface
            when en_twsi_intrfc_state =>
               state           <= wait_for_rqst;
               oe_n            <= '0';
            -- Wait for a request
            when wait_for_rqst =>
               if (strt_reg  = '1') then
                  state        <= start_cycle;
               else
                  state        <= wait_for_rqst;
               end if;
               trns_done       <= '0';
               busy            <= '0';
            -------------------------------------------------------------------
            -- Transmit Header
            -------------------------------------------------------------------
            when start_cycle  => -- Start State
               busy            <= '1';
               int_sda_out     <= '0';
               state           <= start_cycle_a;
            when start_cycle_a  => -- Start State
               if  scl_in  = '1' then
                  state        <= header_cycle1a;
               else
                  state        <= start_cycle_a;
               end if;
            when header_cycle1a => -- Header MSB bit 7
               state           <= header_cycle1b;
               int_sda_out     <= t1_addr (6);
               scl_out         <= '0';
            when header_cycle1b => 
               state           <= header_cycle1c;
            when header_cycle1c =>
               scl_out          <= '1';
               if  scl_in  = '1' then
                  state        <= header_cycle2a;
               else
                  state        <= header_cycle1c;
               end if;
            when header_cycle2a => -- Header MSB bit 6
               state           <= header_cycle2b;
               int_sda_out     <= t1_addr (5);
               scl_out         <= '0';
            when header_cycle2b => 
               state           <= header_cycle2c;
            when header_cycle2c =>
               scl_out         <= '1';
               if  scl_in  = '1' then
                  state        <= header_cycle3a;
               else
                  state        <= header_cycle2c;
               end if;   
            when header_cycle3a => -- Header MSB bit 5
               state           <= header_cycle3b;
               int_sda_out     <= t1_addr (4);
               scl_out         <= '0';
            when header_cycle3b => 
               state           <= header_cycle3c;
            when header_cycle3c =>
               scl_out         <= '1';
               if  scl_in  = '1' then
                  state        <= header_cycle4a;
               else
                  state        <= header_cycle3c;
               end if;                
            when header_cycle4a => -- Header MSB bit 4
               state           <= header_cycle4b;
               int_sda_out     <= t1_addr (3);
               scl_out         <= '0';
            when header_cycle4b => 
               state           <= header_cycle4c;
            when header_cycle4c =>
               scl_out         <= '1';
               if  scl_in  = '1' then
                  state        <= header_cycle5a;
               else
                  state        <= header_cycle4c;
               end if;
            when header_cycle5a => -- Header MSB bit 3
               state           <= header_cycle5b;
               int_sda_out     <= t1_addr (2);
               scl_out         <= '0';
            when header_cycle5b => 
               state           <= header_cycle5c;
            when header_cycle5c =>
               scl_out         <= '1';
               if  scl_in  = '1' then
                  state        <= header_cycle6a;
               else
                  state        <= header_cycle5c;
               end if;
            when header_cycle6a => -- Header MSB bit 2
               state           <= header_cycle6b;
               int_sda_out     <= t1_addr (1);
               scl_out         <= '0';
            when header_cycle6b => 
               state           <= header_cycle6c;
            when header_cycle6c =>
               scl_out         <= '1';
               if  scl_in  = '1' then
                  state        <= header_cycle7a;
               else
                  state        <= header_cycle6c;
               end if;
            when header_cycle7a => -- Header MSB bit 1
               state           <= header_cycle7b;
               int_sda_out     <= t1_addr (0);
               scl_out         <= '0';
            when header_cycle7b => 
               state           <= header_cycle7c;
            when header_cycle7c =>
               scl_out         <= '1';
               if  scl_in  = '1' then
                  if (t1_r_w_n  = '0') then
                     state     <= header_wr_bit_cycle1; -- Write command bit
                  else
                     state     <= header_rd_bit_cycle1; -- Read command bit
                  end if;
               else
                  state        <= header_cycle7c;
               end if;   
            when header_wr_bit_cycle1 => -- Write Command '0'
               state            <= header_wr_bit_cycle1a;
               int_sda_out      <= '0';
               scl_out          <= '0';
            when header_wr_bit_cycle1a => 
               state            <= header_wr_bit_cycle2;
            when header_wr_bit_cycle2 => 
               scl_out          <= '1';
               if  scl_in  = '1' then
                  state         <= header_ack_cycle1;
               else
                  state         <= header_wr_bit_cycle2;
               end if;   
            when header_rd_bit_cycle1 => -- Read Command '1'
               state            <= header_rd_bit_cycle1a;
               int_sda_out      <= '1';
               scl_out          <= '0';
            when header_rd_bit_cycle1a => 
               state            <= header_rd_bit_cycle2;
            when header_rd_bit_cycle2 => 
               scl_out          <= '1';
               if  scl_in  = '1' then
                  state         <= header_ack_cycle1;
               else
                  state         <= header_rd_bit_cycle2;
               end if;                
            when header_ack_cycle1 => -- ACK
               state            <= header_ack_cycle1a;
               int_sda_out      <= '1';
               scl_out          <= '0';
            when header_ack_cycle1a => 
               state            <= header_ack_cycle2;
            when header_ack_cycle2 => 
               if  scl_in   = '1' then
                  if (t1_r_w_n  = '0') then
                     state      <= tx_cycle1a; -- Write Data
                  else
                     state      <= rx_cycle1a; -- Read Data
                  end if;
               else
                  state         <= header_ack_cycle2;
               end if;               
               scl_out          <= '1';
               no_ack           <=  sda_in ;
            -------------------------------------------------------------------
            -- Data TX
            -------------------------------------------------------------------
            when tx_cycle1a => -- Data MSB bit 7
               state            <= tx_cycle1b;
               int_sda_out      <= tx_fifo_dout (7);
               scl_out          <= '0';
               no_ack           <= '0';
            when tx_cycle1b => 
               state            <= tx_cycle1c;
            when tx_cycle1c => 
               scl_out          <= '1';
               if  scl_in  = '1' then
                   state        <= tx_cycle2a;
               else
                   state        <= tx_cycle1c;
               end if;
            when tx_cycle2a => -- Data MSB bit 6
               state            <= tx_cycle2b;
               int_sda_out      <= tx_fifo_dout (6);
               scl_out          <= '0';
            when tx_cycle2b => 
               state            <= tx_cycle2c;
            when tx_cycle2c => 
               scl_out          <= '1';
               if  scl_in  = '1' then
                  state         <= tx_cycle3a;
               else
                  state         <= tx_cycle2c;
               end if;               
            when tx_cycle3a => -- Data MSB bit 5
               state            <= tx_cycle3b;
               int_sda_out      <= tx_fifo_dout (5);
               scl_out          <= '0';
            when tx_cycle3b => 
               state            <= tx_cycle3c;
            when tx_cycle3c => 
               scl_out          <= '1';
               if  scl_in  = '1' then
                  state         <= tx_cycle4a;
               else
                  state         <= tx_cycle3c;
               end if;               
            when tx_cycle4a => -- Data MSB bit 4
               state            <= tx_cycle4b;
               int_sda_out      <= tx_fifo_dout (4);
               scl_out          <= '0';
            when tx_cycle4b => 
               state            <= tx_cycle4c;
            when tx_cycle4c => 
               scl_out          <= '1';
               if  scl_in  = '1' then
                  state         <= tx_cycle5a;
               else
                  state         <= tx_cycle4c;
               end if;               
            when tx_cycle5a => -- Data MSB bit 3
               state            <= tx_cycle5b;
               int_sda_out      <= tx_fifo_dout (3);
               scl_out          <= '0';
            when tx_cycle5b => 
                state           <= tx_cycle5c;
            when tx_cycle5c => 
               scl_out          <= '1';
               if  scl_in  = '1' then
                  state         <= tx_cycle6a;
               else
                  state         <= tx_cycle5c;
               end if;                
            when tx_cycle6a => -- Data MSB bit 2
               state            <= tx_cycle6b;
               int_sda_out      <= tx_fifo_dout (2);
               scl_out          <= '0';
            when tx_cycle6b => 
               state            <= tx_cycle6c;
            when tx_cycle6c => 
               scl_out          <= '1';
               if  scl_in  = '1' then
                  state         <= tx_cycle7a;
               else
                  state         <= tx_cycle6c;
               end if;                
            when tx_cycle7a => -- Data MSB bit 1
               state            <= tx_cycle7b;
               int_sda_out      <= tx_fifo_dout (1);
               scl_out          <= '0';
            when tx_cycle7b => 
               state            <= tx_cycle7c;
            when tx_cycle7c => 
               scl_out          <= '1';
               if  scl_in  = '1' then
                  state         <= tx_cycle8a;
               else
                  state         <= tx_cycle7c;
               end if;                 
            when tx_cycle8a => -- Data MSB bit 0
               state            <= tx_cycle8b;
               int_sda_out      <= tx_fifo_dout (0);
               scl_out          <= '0';
            when tx_cycle8b => 
               state            <= tx_cycle8c;
            when tx_cycle8c => 
               scl_out          <= '1';
               if  scl_in  = '1' then
                  state         <= tx_ack_cycle1;
               else
                  state         <= tx_cycle8c;
               end if;                 
            when tx_ack_cycle1 => -- ACK
               state             <= tx_ack_cycle1a;
               int_sda_out       <= '1';
               scl_out           <= '0';
            when tx_ack_cycle1a => 
               state             <= tx_ack_cycle2;
            when tx_ack_cycle2 =>
               scl_out           <= '1';
               if  scl_in  = '1' then
                  state           <= tx_tst_last_cycle;
                  no_ack          <=  sda_in ;
                  wr_data_fifo_rd <= '1';
               else
                  state           <= tx_ack_cycle2;
                  no_ack          <= '0';
                  wr_data_fifo_rd <= '0';
               end if;
            when tx_tst_last_cycle => -- test if last word
               if last_word  = '1' then
                  if  scl_in  = '1' then
                    state       <= tx_finished_cycle;
                  else
                    state       <= tx_tst_last_cycle;
                  end if;
               else
                  if  scl_in  = '1' then
                     state      <= tx_cycle1a;
                  else
                     state      <= tx_tst_last_cycle;
                  end if;
               end if;
               wr_data_fifo_rd  <= '0';
               no_ack           <= '0';
            when tx_finished_cycle =>
               state            <= tx_finished_cycle_a;
               if t1_restart_mode = '0' then
                 int_sda_out      <= '0'; -- normal stop mode
               else
                 int_sda_out      <= '1'; -- allow restart mode
               end if;  
               --int_sda_out      <= '0';
               scl_out          <= '0';
            when tx_finished_cycle_a =>
               state            <= tx_stop_cycle;
            when tx_stop_cycle =>  -- Transmit Stop cycle
               if  scl_in  = '1' then
                  state         <= wait_for_rqst;
               else
                  state         <= tx_stop_cycle;
               end if;
               int_sda_out      <= '1';
               scl_out          <= '1';
               trns_done        <= '1';
            -------------------------------------------------------------------
            -- Receive Data
            -------------------------------------------------------------------
            when rx_cycle1a => -- Data MSB bit 7
               state            <= rx_cycle1b;
               int_sda_out      <= '1';
               scl_out          <= '0';
               shift_in         <= '0';
               no_ack           <= '0';
            when rx_cycle1b => 
                state           <= rx_cycle1c;   
            when rx_cycle1c => 
               if  scl_in  = '1' then
                   state        <= rx_cycle2a;
                  shift_in            <= '1';
               else
                   state        <= rx_cycle1c;
                  shift_in            <= '0';
               end if;               
                scl_out         <= '1';
            when rx_cycle2a => -- Data bit 6
               state            <= rx_cycle2b;
               int_sda_out         <= '1';
               scl_out          <= '0';
               shift_in         <= '0';               
            when rx_cycle2b => 
                state           <= rx_cycle2c;   
            when rx_cycle2c => 
               if  scl_in  = '1' then
                   state        <= rx_cycle3a;
                  shift_in      <= '1';
               else
                   state        <= rx_cycle2c;
                  shift_in      <= '0';
               end if;               
                scl_out         <= '1';   
            when rx_cycle3a => -- Data bit 5
               state            <= rx_cycle3b;
               int_sda_out      <= '1';
               scl_out          <= '0';
               shift_in         <= '0';
            when rx_cycle3b => 
               state            <= rx_cycle3c;   
            when rx_cycle3c => 
               if  scl_in  = '1' then
                   state        <= rx_cycle4a;
                  shift_in      <= '1';
               else
                   state        <= rx_cycle3c;
                  shift_in      <= '0';
               end if;               
               scl_out          <= '1';                 
            when rx_cycle4a => -- Data bit 4
               state            <= rx_cycle4b;
               int_sda_out      <= '1';
               scl_out          <= '0';
               shift_in         <= '0';
            when rx_cycle4b => 
               state            <= rx_cycle4c;   
            when rx_cycle4c => 
               if  scl_in  = '1' then
                  state         <= rx_cycle5a;
                  shift_in      <= '1';
               else
                  state         <= rx_cycle4c;
                  shift_in      <= '0';
               end if;               
               scl_out          <= '1';      
            when rx_cycle5a => -- Data bit 3
               state            <= rx_cycle5b;
               int_sda_out      <= '1';
               scl_out          <= '0';
               shift_in         <= '0';
            when rx_cycle5b => 
               state            <= rx_cycle5c;   
            when rx_cycle5c => 
               if  scl_in  = '1' then
                  state         <= rx_cycle6a;
                  shift_in      <= '1';
               else
                  state         <= rx_cycle5c;
                  shift_in      <= '0';
               end if;               
               scl_out          <= '1';      
            when rx_cycle6a => -- Data bit 2
               state            <= rx_cycle6b;
               int_sda_out      <= '1';
               scl_out          <= '0';
               shift_in         <= '0';
            when rx_cycle6b => 
               state            <= rx_cycle6c;   
            when rx_cycle6c => 
               if  scl_in  = '1' then
                  state         <= rx_cycle7a;
                  shift_in      <= '1';
               else
                  state         <= rx_cycle6c;
                  shift_in      <= '0';
               end if;               
               scl_out          <= '1';      
            when rx_cycle7a => -- Data bit 1
               state            <= rx_cycle7b;
               int_sda_out      <= '1';
               scl_out          <= '0';
               shift_in         <= '0';
            when rx_cycle7b => 
               state            <= rx_cycle7c;   
            when rx_cycle7c => 
               if  scl_in  = '1' then
                  state         <= rx_cycle8a;
                  shift_in      <= '1';
               else
                  state         <= rx_cycle7c;
                  shift_in      <= '0';
               end if;               
               scl_out          <= '1';      
            when rx_cycle8a => -- Data bit 0
               state            <= rx_cycle8b;
               int_sda_out      <= '1';
               scl_out          <= '0';
               shift_in         <= '0';
            when rx_cycle8b => 
               state            <= rx_cycle8c;   
            when rx_cycle8c => 
               if  scl_in  = '1' then
                  state         <= rx_ack_cycle1;
                  shift_in      <= '1';
               else
                  state         <= rx_cycle8c;
                  shift_in      <= '0';
               end if;               
               scl_out          <= '1';      
            when rx_ack_cycle1 => -- ACK
               if last_word  = '1' then -- don't ACK
                  state         <= rx_no_ack_cycle1a;
                  int_sda_out   <= '1';
                  scl_out       <= '0';
               else -- ACK
                  state         <= rx_ack_cycle1a;
                  int_sda_out   <= '0';
                  scl_out       <= '0';
               end if;
               rd_data_fifo_wr  <= '1';
               shift_in         <= '0';
            when rx_no_ack_cycle1a =>
               state            <= rx_no_ack_cycle2;
               rd_data_fifo_wr  <= '0';
            when rx_ack_cycle1a =>
               state            <= rx_ack_cycle2;
               rd_data_fifo_wr  <= '0';
            when rx_no_ack_cycle2 => -- don't ACK
               if  scl_in  = '1' then
                  state         <= rx_finish_cycle;
               else
                  state         <= rx_no_ack_cycle2;
               end if;           
               int_sda_out      <= '1';
               scl_out          <= '1';      
            when rx_ack_cycle2 => -- ACK
               if  scl_in  = '1' then
                  state         <= rx_cycle1a;
               else
                  state         <= rx_ack_cycle2;
               end if;  
               int_sda_out      <= '0';
               scl_out          <= '1'; 
            when rx_finish_cycle => 
               state            <= rx_finish_cycle_a ;
               if t1_restart_mode = '0' then
                 int_sda_out      <= '0'; -- normal stop mode
               else
                 int_sda_out      <= '1'; -- allow restart mode
               end if;  
               --int_sda_out      <= '0';
               scl_out          <= '0';
            when rx_finish_cycle_a => 
               state            <= rx_stop_cycle;
            when rx_stop_cycle =>  -- Receive Stop cycle
               if  scl_in  = '1' then
                  state         <= wait_for_rqst;
                  trns_done     <= '1';
               else
                  state         <= rx_stop_cycle;
                  trns_done     <= '0';
               end if;                 
               int_sda_out      <= '1';
               scl_out          <= '1'; 
            when others =>
               state            <= reset_state;
         end case;
      end if;
   end if;
end process;

-- Input Data Shift Register
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if (clkout_ce= '1') then -- shift data output by 1/4 clock cycle
         sda_out <= int_sda_out;
      end if;
      -- Input Shift Register
      if (sm_ce= '1') and (shift_in = '1') then
         rx_sr <= rx_sr(6 downto 0) & sda_in;
      end if;
   end if;
end process;

-------------------------------------------------------------------------------
-- Transmit and Receive FIFOs
-------------------------------------------------------------------------------


tx_fifo_rd <= wr_data_fifo_rd and sm_ce;
rx_fifo_wr <= rd_data_fifo_wr and sm_ce;

fifo_rst_or <= t1_fifo_flush or fifo_rst;

tx_fifo_inst : px_i2c_fifo
port map (
   clk         => s_axi_csr_aclk,
   rst         => fifo_rst_or,
   din         => wr_data,
   wr_en       => fifo_wr,
   rd_en       => tx_fifo_rd,
   dout        => tx_fifo_dout,
   full        => tx_full,
   empty       => tx_empty,
   data_count  => tx_data_count
);

rx_fifo_inst : px_i2c_fifo
port map (
   clk         => s_axi_csr_aclk,
   rst         => fifo_rst_or,
   din         => rx_sr,
   wr_en       => rx_fifo_wr,
   rd_en       => fifo_rd,
   dout        => rd_data,
   full        => rx_full,
   empty       => rx_empty,
   data_count  => rx_data_count
);


end Behavioral;
