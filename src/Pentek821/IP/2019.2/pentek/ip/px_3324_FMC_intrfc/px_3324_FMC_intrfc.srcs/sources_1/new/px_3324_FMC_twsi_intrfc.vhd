-------------------------------------------------------------------------------
-- ************************************************************************* --
-- ****        TWSI Bus to Local Bus Interface Module for 3324x         **** --
-- ************************************************************************* --
-------------------------------------------------------------------------------
--  Copyright (c) 2018 Pentek, Inc.  All rights reserved.
-------------------------------------------------------------------------------
-- Title        : FPGA, TWSI Bus to Local Bus Interface Module
-- Project      : 3324x
-------------------------------------------------------------------------------
---------  Technical Support for Pentek's GateFlow FPGA Design Kits   ---------
-------------------------------------------------------------------------------
--        Technical support for Pentek's GateFlow FPGA Design Kits is        --
--   available via e-mail (fpgasupport@pentek.com) or by phone (201-818-5900 --
--            ext. 238, 9 AM to 5 PM US Eastern time.) Names or              --
--  initials contained within the source code are part of our revision       --
--   control regime.  Please do not try to use these references to pursue    --
--                            technical support                              --
-------------------------------------------------------------------------------
-- Filename     : px_3324_FMC_twsi_intrfc.vhd
-- Author       : 
-- Created      : 06/25/2018
-- Last Modified: $Date: 3/17/17 1:14p $Author: MarcLee $
--                Pentek, Inc.
--                One Park Way
--                Upper Saddle River, NJ  07458
--                (201) 818-5900
--                www.pentek.com
-------------------------------------------------------------------------------
-- ******************************* Change Log ****************************** --
-- $History: px_3324_FMC_twsi_intrfc.vhd $
--
--
-------------------------------------------------------------------------------
-- Description: 
-- This module is a TWSI bus master controller and interface to the PCIe local
-- bus.
-- It provides the parallel to serial and serial to parallel conversion,
-- header construction, and interrupts.
-- Up to 16 bytes may be read or written at a time. 

-------------------------------------------------------------------------------
-- Libraries
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

-------------------------------------------------------------------------------
-- Main Entity
-------------------------------------------------------------------------------

entity twsi_local_bus_intrfc is
port (
   CLK            : in  std_logic; -- PCIe Clock 250MHz
   RST_N          : in  std_logic; -- Power on reset
   ----------------------------------------------------------------------------
   -- TWSI Port
   ----------------------------------------------------------------------------
   SDA            : inout std_logic;
   SCL            : inout std_logic;
   ----------------------------------------------------------------------------
   -- Controls
   ----------------------------------------------------------------------------
   ENABLE         : in  std_logic; -- Port Enable
   ADDR           : in  std_logic_vector(6 downto 0); -- TWSI t1_address
   STRT_PLS       : in  std_logic; -- Start Transfer pulse
   R_W_N          : in  std_logic; -- Data direction (0 = write, 1 = read)
   -- (# of bytes-1) to transfer
   NUM_BYTES      : in  std_logic_vector(3 downto 0); 
   ----------------------------------------------------------------------------
   -- Data Read/Write Bus
   ----------------------------------------------------------------------------
   FIFO_WR        : in  std_logic; -- Write for data into the FIFO
   FIFO_RD        : in  std_logic; -- Read for data out of FIFO
   WR_DATA        : in  std_logic_vector(7 downto 0); -- Data to be transmitted
   RD_DATA        : out std_logic_vector(7 downto 0); -- Data received
   ----------------------------------------------------------------------------
   -- Status
   ----------------------------------------------------------------------------
   -- Number of data bytes available to read in the FIFO
   RD_FIFO_CNT    : out std_logic_vector(4 downto 0);
   RD_FIFO_FULL   : out std_logic; -- RX Full
   RD_FIFO_EMPTY  : out std_logic; -- RX Empty
   -- Number of data bytes ready to be transmitted
   WR_FIFO_CNT    : out std_logic_vector(4 downto 0);
   WR_FIFO_FULL   : out std_logic; -- TX Full
   WR_FIFO_EMPTY  : out std_logic; -- TX Empty
   BUSY_OUT       : out std_logic; -- busy, transfer in process
   TRNS_DONE_INT  : out std_logic; -- Interrupt pulse when transfer is done
   NO_ACK_INT     : out std_logic  -- No acknowledge interrupt
);
end twsi_local_bus_intrfc;

architecture Behavioral of twsi_local_bus_intrfc is

-------------------------------------------------------------------------------
-- Components
-------------------------------------------------------------------------------

-- FIFO
-- FIFO Generator v6.1
-- FWFT
-- 8 wide
-- 16 deep
-- Distributed RAM
component px_3324_FMC_intrfc_twsi_fifo
port (
   clk         : in std_logic;
   rst         : in std_logic;
   din         : in std_logic_VECTOR(7 downto 0);
   wr_en       : in std_logic;
   rd_en       : in std_logic;
   dout        : out std_logic_VECTOR(7 downto 0);
   full        : out std_logic;
   empty       : out std_logic;
   data_count  : out std_logic_VECTOR(4 downto 0)
);
end component;

-------------------------------------------------------------------------------
-- Types
-------------------------------------------------------------------------------

type state_mach_states is (
   reset_state,
   begin_state,  
   en_twsi_intrfc_state,
   wait_for_rqst,
   start_cycle, -- Start State
   header_cycle1a,-- Header MSB bit 7
   header_cycle1b,-- Header MSB bit 7
   header_cycle2a,-- Header MSB bit 6
   header_cycle2b,-- Header MSB bit 6
   header_cycle3a,-- Header MSB bit 5
   header_cycle3b,-- Header MSB bit 5
   header_cycle4a,-- Header MSB bit 4
   header_cycle4b,-- Header MSB bit 4
   header_cycle5a,-- Header MSB bit 3
   header_cycle5b,-- Header MSB bit 3
   header_cycle6a,-- Header MSB bit 2
   header_cycle6b,-- Header MSB bit 2
   header_cycle7a,-- Header MSB bit 1
   header_cycle7b,-- Header MSB bit 1
   header_wr_bit_cycle1, -- write command bit
   header_wr_bit_cycle2, -- write command bit
   header_rd_bit_cycle1, -- read command bit
   header_rd_bit_cycle2, -- read command bit
   header_ack_cycle1, -- Header ACK cycle
   header_ack_cycle2, -- Header ACK cycle
   tx_cycle1a, -- Tx Data bit 7
   tx_cycle1b, -- Tx Data bit 7
   tx_cycle2a, -- Tx Data bit 6
   tx_cycle2b, -- Tx Data bit 6
   tx_cycle3a, -- Tx Data bit 5
   tx_cycle3b, -- Tx Data bit 5
   tx_cycle4a, -- Tx Data bit 4
   tx_cycle4b, -- Tx Data bit 4
   tx_cycle5a, -- Tx Data bit 3
   tx_cycle5b, -- Tx Data bit 3
   tx_cycle6a, -- Tx Data bit 2
   tx_cycle6b, -- Tx Data bit 2
   tx_cycle7a, -- Tx Data bit 1
   tx_cycle7b, -- Tx Data bit 1
   tx_cycle8a, -- Tx Data bit 0
   tx_cycle8b, -- Tx Data bit 0
   tx_ack_cycle1, -- Tx Ack Cycle
   tx_ack_cycle2, -- Tx Ack Cycle
   tx_tst_last_cycle, -- test if last word
   tx_finished_cycle, -- Tx finished Cycle
   tx_stop_cycle, -- Tx Stop bit cycle
   rx_cycle1a, -- Rx Data bit 7
   rx_cycle1b, -- Rx Data bit 7
   rx_cycle2a, -- Rx Data bit 6
   rx_cycle2b, -- Rx Data bit 6
   rx_cycle3a, -- Rx Data bit 5
   rx_cycle3b, -- Rx Data bit 5
   rx_cycle4a, -- Rx Data bit 4
   rx_cycle4b, -- Rx Data bit 4
   rx_cycle5a, -- Rx Data bit 3
   rx_cycle5b, -- Rx Data bit 3
   rx_cycle6a, -- Rx Data bit 2
   rx_cycle6b, -- Rx Data bit 2
   rx_cycle7a, -- Rx Data bit 1
   rx_cycle7b, -- Rx Data bit 1
   rx_cycle8a, -- Rx Data bit 0
   rx_cycle8b, -- Rx Data bit 0
   rx_ack_cycle1, -- Rx Ack Cycle
   rx_ack_cycle2, -- Rx Ack Cycle
   rx_no_ack_cycle2, -- Rx No Ack Cycle
   rx_finish_cycle, -- Rx finished Cycle
   rx_stop_cycle  -- Rx Stop bit cycle
);

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal next_state : state_mach_states;
signal clk_cntr : std_logic_vector(10 downto 0);
signal sm_ce : std_logic;
signal clkout_ce : std_logic;
signal strt_reg : std_logic;
signal t1_r_w_n : std_logic;
signal busy : std_logic;
signal int_sda : std_logic;
signal int_scl : std_logic;
signal wr_data_fifo_rd : std_logic;
signal shift_in : std_logic;
signal rd_data_fifo_wr : std_logic;
signal no_ack : std_logic;
signal trns_done : std_logic;
signal tx_full : std_logic;
signal tx_empty : std_logic;
signal tx_data_count: std_logic_vector(4 downto 0);
signal rx_full : std_logic;
signal rx_empty : std_logic;
signal rx_data_count: std_logic_vector(4 downto 0);
signal tx_fifo_rd : std_logic;
signal rx_fifo_wr : std_logic;
signal t1_num_bytes: std_logic_vector(3 downto 0);
signal trns_cntr: std_logic_vector(3 downto 0);
signal last_word : std_logic;
signal sda_in: std_logic;
signal scl_in: std_logic;
signal t1_addr: std_logic_vector(6 downto 0);
signal oe_n :std_logic;
signal sda_oe :std_logic;
signal scl_oe :std_logic;
signal tx_fifo_dout: std_logic_vector(7 downto 0);
signal rx_fifo_dout: std_logic_vector(7 downto 0);
signal t1_int_sda: std_logic;
signal rx_sr: std_logic_vector(7 downto 0);
signal rst: std_logic;
signal t1_fifo_wr: std_logic;
signal t1_fifo_rd: std_logic;
signal t1_wr_data: std_logic_vector(7 downto 0);
signal t1_strt_pls: std_logic;
signal t2_strt_pls: std_logic;
signal t1_trns_done: std_logic;
signal zero : std_logic;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

begin

process(CLK, RST_N)
begin
   if (RST_N = '0') then
      clk_cntr       <= "00000000000";
      sm_ce          <= '0';
      clkout_ce      <= '0';
      BUSY_OUT       <= '0';
      NO_ACK_INT     <= '0';
      TRNS_DONE_INT  <= '0';
      WR_FIFO_FULL   <= '0';
      WR_FIFO_EMPTY  <= '0';
      WR_FIFO_CNT    <= "00000";
      RD_FIFO_FULL   <= '0';
      RD_FIFO_EMPTY  <= '0';
      RD_FIFO_CNT    <= "00000";
      strt_reg       <= '0';
      t1_r_w_n       <= '0';
      t1_num_bytes   <= (others => '0');
      t1_addr        <= (others => '0');
      trns_cntr      <= (others => '0');
      last_word      <= '0';
      t1_strt_pls    <= '0';
      t2_strt_pls    <= '0';
      t1_trns_done   <= '0';

   elsif rising_edge(CLK) then
      -- create a 80Khz and a 160khz clock enable
      clk_cntr <= clk_cntr + 1;
--      if (clk_cntr = "11111111111") then
--         sm_ce    <= '1';
--      else
--         sm_ce    <= '0';
--      end if;
--      if (clk_cntr = "01111111111") then
--         clkout_ce    <= '1';
--      else
--         clkout_ce    <= '0';
--      end if;


      if (clk_cntr(9 downto 0) = "1111111111") then
         sm_ce    <= '1';
      else
         sm_ce    <= '0';
      end if;
      if (clk_cntr(9 downto 0) = "0111111111") then
         clkout_ce    <= '1';
      else
         clkout_ce    <= '0';
      end if;

      t1_strt_pls <= STRT_PLS;
      t2_strt_pls <= t1_strt_pls;
      -- stretch write and read pulses
      if (t1_strt_pls = '1') and (t2_strt_pls = '0') then
         strt_reg <= '1';
      elsif busy = '1' then
         strt_reg <= '0';
      end if;

      t1_num_bytes <= NUM_BYTES;
      t1_addr      <= ADDR;

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
 
      BUSY_OUT       <= busy or strt_reg;
      NO_ACK_INT     <= no_ack;
      t1_trns_done   <= trns_done;
      TRNS_DONE_INT  <= t1_trns_done and not trns_done;
      WR_FIFO_FULL   <= tx_full;
      WR_FIFO_EMPTY  <= tx_empty;
      WR_FIFO_CNT    <= tx_data_count;
      RD_FIFO_FULL   <= rx_full;
      RD_FIFO_EMPTY  <= rx_empty;
      RD_FIFO_CNT    <= rx_data_count;

      if strt_reg = '1' then
         t1_r_w_n <= R_W_N; -- latch data direction
      end if;
   end if;
end process;

-------------------------------------------------------------------------------
-- TWSI Port Controller State Machine
-------------------------------------------------------------------------------
process(CLK, RST_N, ENABLE)
begin
   if (RST_N = '0') or (ENABLE = '0') then
      next_state <= reset_state;
      oe_n <= '1';
      busy <= '0';
      int_sda  <= '1';
      int_scl  <= '1';
      wr_data_fifo_rd <= '0';
      shift_in <= '0';
      rd_data_fifo_wr <= '0';
      no_ack   <= '0';
      trns_done <= '0';
   elsif rising_edge(CLK) then
      if (sm_ce = '1') then
         case next_state is
            -- Reset State
            when reset_state =>
               next_state  <= begin_state;
               oe_n <= '1';
               busy <= '0';
               int_sda  <= '1';
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            -- Begin State
            when begin_state => 
               next_state  <= en_twsi_intrfc_state;
               oe_n <= '1';
               busy <= '0';
               int_sda  <= '1';
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            -- Enable the TWSI interface
            when en_twsi_intrfc_state =>
               next_state  <= wait_for_rqst;
               oe_n <= '0';
               busy <= '0';
               int_sda  <= '1';
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            -- Wait for a request
            when wait_for_rqst =>
               if strt_reg = '1' then
                  next_state  <= start_cycle;
               else
                  next_state  <= wait_for_rqst;
               end if;
               oe_n <= '0';
               busy <= '0';
               int_sda  <= '1';
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            -------------------------------------------------------------------
            -- Transmit Header
            -------------------------------------------------------------------
            when start_cycle  => -- Start State
               --next_state  <= header_cycle1a;
               oe_n <= '0';
               busy <= '1';
               int_sda <= '0';
               int_scl <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
               if scl_in = '1' then
                  next_state  <= header_cycle1a;
               else
                  next_state  <= start_cycle;
               end if;
            when header_cycle1a => -- Header MSB bit 7
               next_state  <= header_cycle1b;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= t1_addr(6);
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when header_cycle1b =>
               --next_state  <= header_cycle2a;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= t1_addr(6);
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
               if scl_in = '1' then
                  next_state  <= header_cycle2a;
               else
                  next_state  <= header_cycle1b;
               end if;
            when header_cycle2a => -- Header bit 6
               next_state  <= header_cycle2b;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= t1_addr(5);
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when header_cycle2b =>
               --next_state  <= header_cycle3a;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= t1_addr(5);
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
               if scl_in = '1' then
                  next_state  <= header_cycle3a;
               else
                  next_state  <= header_cycle2b;
               end if;
            when header_cycle3a => -- Header bit 5
               next_state  <= header_cycle3b;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= t1_addr(4);
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when header_cycle3b =>
               --next_state  <= header_cycle4a;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= t1_addr(4);
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
               if scl_in = '1' then
                  next_state  <= header_cycle4a;
               else
                  next_state  <= header_cycle3b;
               end if;
            when header_cycle4a => -- Header bit 4
               next_state  <= header_cycle4b;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= t1_addr(3);
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when header_cycle4b =>
               --next_state  <= header_cycle5a;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= t1_addr(3);
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
               if scl_in = '1' then
                  next_state  <= header_cycle5a;
               else
                  next_state  <= header_cycle4b;
               end if;
            when header_cycle5a => -- Header bit 3
               next_state  <= header_cycle5b;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= t1_addr(2);
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when header_cycle5b =>
               --next_state  <= header_cycle6a;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= t1_addr(2);
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
               if scl_in = '1' then
                  next_state  <= header_cycle6a;
               else
                  next_state  <= header_cycle5b;
               end if;
            when header_cycle6a => -- Header bit 2
               next_state  <= header_cycle6b;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= t1_addr(1);
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when header_cycle6b =>
               --next_state  <= header_cycle7a;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= t1_addr(1);
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
               if scl_in = '1' then
                  next_state  <= header_cycle7a;
               else
                  next_state  <= header_cycle6b;
               end if;
            when header_cycle7a => -- Header bit 1
               next_state  <= header_cycle7b;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= t1_addr(0);
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when header_cycle7b =>
               if scl_in = '1' then
                  if (t1_r_w_n = '0') then
                     next_state  <= header_wr_bit_cycle1; -- Write command bit
                  else
                     next_state  <= header_rd_bit_cycle1; -- Read command bit
                  end if;
               else
                  next_state  <= header_cycle7b;
               end if;
--               if (t1_r_w_n = '0') then
--                  next_state  <= header_wr_bit_cycle1; -- Write command bit
--               else
--                  next_state  <= header_rd_bit_cycle1; -- Read command bit
--               end if;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= t1_addr(0);
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when header_wr_bit_cycle1 => -- Write Command '0'
               next_state  <= header_wr_bit_cycle2;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '0';
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when header_rd_bit_cycle1 => -- Read Command '1'
               next_state  <= header_rd_bit_cycle2;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when header_wr_bit_cycle2 => -- Write Command '0'
               --next_state  <= header_ack_cycle1;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '0';
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
               if scl_in = '1' then
                  next_state  <= header_ack_cycle1;
               else
                  next_state  <= header_wr_bit_cycle2;
               end if;
            when header_rd_bit_cycle2 => -- Read Command '1'
               --next_state  <= header_ack_cycle1;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
               if scl_in = '1' then
                  next_state  <= header_ack_cycle1;
               else
                  next_state  <= header_rd_bit_cycle2;
               end if;
            when header_ack_cycle1 => -- ACK
               next_state  <= header_ack_cycle2;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when header_ack_cycle2 => 
               if scl_in = '1' then
                  if (t1_r_w_n = '0') then
                     next_state  <= tx_cycle1a; -- Write Data
                  else
                     next_state  <= rx_cycle1a; -- Read Data
                  end if;
               else
                  next_state  <= header_ack_cycle2;
               end if;               
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= sda_in;
               trns_done <= '0';
            -------------------------------------------------------------------
            -- Data TX
            -------------------------------------------------------------------
            when tx_cycle1a => -- Data MSB bit 7
               next_state  <= tx_cycle1b;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= tx_fifo_dout(7);
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when tx_cycle1b => 
               --next_state  <= tx_cycle2a;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= tx_fifo_dout(7);
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
               if scl_in = '1' then
                  next_state  <= tx_cycle2a;
               else
                  next_state  <= tx_cycle1b;
               end if;
            when tx_cycle2a => -- Data bit 6
               next_state  <= tx_cycle2b;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= tx_fifo_dout(6);
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when tx_cycle2b => 
               --next_state  <= tx_cycle3a;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= tx_fifo_dout(6);
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
               if scl_in = '1' then
                  next_state  <= tx_cycle3a;
               else
                  next_state  <= tx_cycle2b;
               end if;
            when tx_cycle3a => -- Data bit 5
               next_state  <= tx_cycle3b;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= tx_fifo_dout(5);
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when tx_cycle3b => 
               --next_state  <= tx_cycle4a;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= tx_fifo_dout(5);
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
               if scl_in = '1' then
                  next_state  <= tx_cycle4a;
               else
                  next_state  <= tx_cycle3b;
               end if;
            when tx_cycle4a => -- Data bit 4
               next_state  <= tx_cycle4b;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= tx_fifo_dout(4);
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when tx_cycle4b => 
               --next_state  <= tx_cycle5a;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= tx_fifo_dout(4);
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
               if scl_in = '1' then
                  next_state  <= tx_cycle5a;
               else
                  next_state  <= tx_cycle4b;
               end if;
            when tx_cycle5a => -- Data bit 3
               next_state  <= tx_cycle5b;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= tx_fifo_dout(3);
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when tx_cycle5b => 
               --next_state  <= tx_cycle6a;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= tx_fifo_dout(3);
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
               if scl_in = '1' then
                  next_state  <= tx_cycle6a;
               else
                  next_state  <= tx_cycle5b;
               end if;
            when tx_cycle6a => -- Data bit 2
               next_state  <= tx_cycle6b;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= tx_fifo_dout(2);
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when tx_cycle6b => 
               --next_state  <= tx_cycle7a;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= tx_fifo_dout(2);
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
               if scl_in = '1' then
                  next_state  <= tx_cycle7a;
               else
                  next_state  <= tx_cycle6b;
               end if;
            when tx_cycle7a => -- Data bit 1
               next_state  <= tx_cycle7b;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= tx_fifo_dout(1);
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when tx_cycle7b => 
               --next_state  <= tx_cycle8a;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= tx_fifo_dout(1);
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
               if scl_in = '1' then
                  next_state  <= tx_cycle8a;
               else
                  next_state  <= tx_cycle7b;
               end if;
            when tx_cycle8a => -- Data bit 0
               next_state  <= tx_cycle8b;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= tx_fifo_dout(0);
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when tx_cycle8b =>
               --next_state  <= tx_ack_cycle1;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= tx_fifo_dout(0);
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
               if scl_in = '1' then
                  next_state  <= tx_ack_cycle1;
               else
                  next_state  <= tx_cycle8b;
               end if;
            when tx_ack_cycle1 => -- ACK
               next_state  <= tx_ack_cycle2;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when tx_ack_cycle2 =>
               --next_state  <= tx_tst_last_cycle;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '1';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';           
               trns_done <= '0';
               if scl_in = '1' then
                  next_state  <= tx_tst_last_cycle;
                  no_ack   <= sda_in;
                  wr_data_fifo_rd <= '1';
               else
                  next_state  <= tx_ack_cycle2;
                  no_ack   <= '0';
                  wr_data_fifo_rd <= '0';
               end if;
            when tx_tst_last_cycle => -- test if last word
               if last_word = '1' then
                  --next_state  <= tx_finished_cycle;
                  if scl_in = '1' then
                     next_state  <= tx_finished_cycle;
                  else
                     next_state  <= tx_tst_last_cycle;
                  end if;
                  oe_n <= '0';
                  busy <= '1';
                  int_sda  <= '1';
                  int_scl  <= '1';
                  wr_data_fifo_rd <= '0';
                  shift_in <= '0';
                  rd_data_fifo_wr <= '0';
                  no_ack   <= '0';
                  trns_done <= '0';
               else
                  --next_state  <= tx_cycle1a;
                  if scl_in = '1' then
                     next_state  <= tx_cycle1a;
                  else
                     next_state  <= tx_tst_last_cycle;
                  end if;
                  oe_n <= '0';
                  busy <= '1';
                  int_sda  <= '1';
                  int_scl  <= '1';
                  wr_data_fifo_rd <= '0';
                  shift_in <= '0';
                  rd_data_fifo_wr <= '0';
                  no_ack   <= '0';
                  trns_done <= '0';
               end if;
            when tx_finished_cycle =>
               next_state  <= tx_stop_cycle;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '0';
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when tx_stop_cycle =>  -- Transmit Stop cycle
               --next_state  <= wait_for_rqst;
               if scl_in = '1' then
                  next_state  <= wait_for_rqst;
               else
                  next_state  <= tx_stop_cycle;
               end if;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '1';
            -------------------------------------------------------------------
            -- Receive Data
            -------------------------------------------------------------------
            when rx_cycle1a => -- Data MSB bit 7
               next_state  <= rx_cycle1b;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when rx_cycle1b => 
               --next_state  <= rx_cycle2a;
               if scl_in = '1' then
                  next_state  <= rx_cycle2a;
                  shift_in <= '1';
               else
                  next_state  <= rx_cycle1b;
                  shift_in <= '0';
               end if;               
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when rx_cycle2a => -- Data bit 6
               next_state  <= rx_cycle2b;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when rx_cycle2b =>
               --next_state  <= rx_cycle3a;
               if scl_in = '1' then
                  next_state  <= rx_cycle3a;
                  shift_in <= '1';
               else
                  next_state  <= rx_cycle2b;
                  shift_in <= '0';
               end if;  
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               --shift_in <= '1';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when rx_cycle3a => -- Data bit 5
               next_state  <= rx_cycle3b;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when rx_cycle3b =>
               --next_state  <= rx_cycle4a;
               if scl_in = '1' then
                  next_state  <= rx_cycle4a;
                  shift_in <= '1';
               else
                  next_state  <= rx_cycle3b;
                  shift_in <= '0';
               end if;  
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               --shift_in <= '1';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when rx_cycle4a => -- Data bit 4
               next_state  <= rx_cycle4b;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when rx_cycle4b =>
               --next_state  <= rx_cycle5a;
               if scl_in = '1' then
                  next_state  <= rx_cycle5a;
                  shift_in <= '1';
               else
                  next_state  <= rx_cycle4b;
                  shift_in <= '0';
               end if;  
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               --shift_in <= '1';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when rx_cycle5a => -- Data bit 3
               next_state  <= rx_cycle5b;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when rx_cycle5b =>
               --next_state  <= rx_cycle6a;
               if scl_in = '1' then
                  next_state  <= rx_cycle6a;
                  shift_in <= '1';
               else
                  next_state  <= rx_cycle5b;
                  shift_in <= '0';
               end if;  
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               --shift_in <= '1';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when rx_cycle6a => -- Data bit 2
               next_state  <= rx_cycle6b;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when rx_cycle6b =>
               --next_state  <= rx_cycle7a;
               if scl_in = '1' then
                  next_state  <= rx_cycle7a;
                  shift_in <= '1';
               else
                  next_state  <= rx_cycle6b;
                  shift_in <= '0';
               end if;  
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               --shift_in <= '1';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when rx_cycle7a => -- Data bit 1
               next_state  <= rx_cycle7b;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when rx_cycle7b =>
               --next_state  <= rx_cycle8a;
               if scl_in = '1' then
                  next_state  <= rx_cycle8a;
                  shift_in <= '1';
               else
                  next_state  <= rx_cycle7b;
                  shift_in <= '0';
               end if;  
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               --shift_in <= '1';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when rx_cycle8a => -- Data bit 0
               next_state  <= rx_cycle8b;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when rx_cycle8b =>
               --next_state  <= rx_ack_cycle1;
               if scl_in = '1' then
                  next_state  <= rx_ack_cycle1;
                  shift_in <= '1';
               else
                  next_state  <= rx_cycle8b;
                  shift_in <= '0';
               end if;  
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               --shift_in <= '1';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when rx_ack_cycle1 => -- ACK
               if last_word = '1' then -- don't ACK
                  next_state  <= rx_no_ack_cycle2;
                  oe_n <= '0';
                  busy <= '1';
                  int_sda  <= '1';
                  int_scl  <= '0';
                  wr_data_fifo_rd <= '0';
                  shift_in <= '0';
                  no_ack   <= '0';
                  trns_done <= '0';
               else -- ACK
                  next_state  <= rx_ack_cycle2;
                  oe_n <= '0';
                  busy <= '1';
                  int_sda  <= '0';
                  int_scl  <= '0';
                  wr_data_fifo_rd <= '0';
                  shift_in <= '0';
                  no_ack   <= '0';
                  trns_done <= '0';
               end if;
               rd_data_fifo_wr <= '1';
            when rx_no_ack_cycle2 => -- don't ACK
               --next_state  <= rx_finish_cycle;
               if scl_in = '1' then
                  next_state  <= rx_finish_cycle;
               else
                  next_state  <= rx_no_ack_cycle2;
               end if;                 
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when rx_ack_cycle2 => -- ACK
               --next_state  <= rx_cycle1a;
               if scl_in = '1' then
                  next_state  <= rx_cycle1a;
               else
                  next_state  <= rx_ack_cycle2;
               end if;  
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '0';
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when rx_finish_cycle => 
               next_state  <= rx_stop_cycle;
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '0';
               int_scl  <= '0';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
            when rx_stop_cycle =>  -- Receive Stop cycle
               --next_state  <= wait_for_rqst;
               if scl_in = '1' then
                  next_state  <= wait_for_rqst;
                  trns_done <= '1';
               else
                  next_state  <= rx_stop_cycle;
                  trns_done <= '0';
               end if;                 
               oe_n <= '0';
               busy <= '1';
               int_sda  <= '1';
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               --trns_done <= '1';
            when others =>
               next_state  <= reset_state;
               next_state  <= wait_for_rqst;
               oe_n <= '0';
               busy <= '0';
               int_sda  <= '1';
               int_scl  <= '1';
               wr_data_fifo_rd <= '0';
               shift_in <= '0';
               rd_data_fifo_wr <= '0';
               no_ack   <= '0';
               trns_done <= '0';
         end case;
      end if;
   end if;
end process;

-- Tristate Data Output when transmitting a logic '1' or reading.

-- Vivado cannot handle inferred tristate logic in a lower level source file: see AR#46743,
-- so the tristate I/O must be instantiated.
-- Original logic:
-- SDA <= '0' when ((t1_int_sda = '0') and (oe_n = '0')) else 'Z';
-- sda_in <= SDA;
-- SCL <= '0' when ((int_scl = '0') and (oe_n = '0')) else 'Z';
-- New logic:
sda_oe <= '0' when ((t1_int_sda = '0') and (oe_n = '0')) else '1';
scl_oe <= '0' when ((int_scl = '0') and (oe_n = '0')) else '1';
zero <= '0';

SDA_IOBUF_inst : IOBUF
   port map (
      O => sda_in,  -- 1-bit output: Buffer output
      I => zero,    -- 1-bit input: Buffer input
      IO => SDA,    -- 1-bit inout: Buffer inout (connect directly to top-level port)
      T => sda_oe   -- 1-bit input: 3-state enable input (1 = Tristated, 0 = Drive)
   );

SCL_IOBUF_inst : IOBUF
   port map (
      O => scl_in,  -- 1-bit output: Buffer output
      I => zero,    -- 1-bit input: Buffer input
      IO => SCL,     -- 1-bit inout: Buffer inout (connect directly to top-level port)
      T => scl_oe   -- 1-bit input: 3-state enable input (1 = Tristated, 0 = Drive)
   );

process(CLK)
begin
   if (RST_N = '0') then
      t1_int_sda <= '0';
      rx_sr <= (others => '0');
   elsif rising_edge(CLK) then
      if (clkout_ce= '1') then -- shift data output by 1/4 clock cycle
         t1_int_sda <= int_sda;
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

rst <= not RST_N;

process(CLK)
begin
   if (RST_N = '0') then
      t1_fifo_wr <= '0';
      t1_fifo_rd <= '0';
      t1_wr_data <= (others => '0');
      RD_DATA    <= (others => '0');
   elsif rising_edge(CLK) then
      t1_fifo_wr <= FIFO_WR;
      t1_fifo_rd <= FIFO_RD;
      t1_wr_data <= WR_DATA;
      RD_DATA    <= rx_fifo_dout;
   end if;
end process;

tx_fifo_rd <= wr_data_fifo_rd and sm_ce;
rx_fifo_wr <= rd_data_fifo_wr and sm_ce;

tx_px_3324_FMC_intrfc_twsi_fifo_inst : px_3324_FMC_intrfc_twsi_fifo
port map (
   clk         => CLK,
   rst         => rst,
   din         => t1_wr_data,
   wr_en       => t1_fifo_wr,
   rd_en       => tx_fifo_rd,
   dout        => tx_fifo_dout,
   full        => tx_full,
   empty       => tx_empty,
   data_count  => tx_data_count
);

rx_px_3324_FMC_intrfc_twsi_fifo_inst : px_3324_FMC_intrfc_twsi_fifo
port map (
   clk         => CLK,
   rst         => rst,
   din         => rx_sr,
   wr_en       => rx_fifo_wr,
   rd_en       => t1_fifo_rd,
   dout        => rx_fifo_dout,
   full        => rx_full,
   empty       => rx_empty,
   data_count  => rx_data_count
);


end Behavioral;

