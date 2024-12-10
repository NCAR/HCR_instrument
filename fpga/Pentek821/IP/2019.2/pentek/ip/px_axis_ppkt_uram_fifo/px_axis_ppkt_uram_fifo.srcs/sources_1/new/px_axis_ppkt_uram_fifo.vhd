----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 03/17/2018 09:04:55 AM
-- Design Name: 
-- Module Name: px_axis_ppkt_uram_fifo - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: UltraRam Virtual FIFO
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
-- 0x00 Control Register
-- 0x04 FIFO Count Status (Bytes)
-- 0x08 Peak FIFO Count Status (Bytes)
-- 0x0C FIFO Flags
-- 0x10 Interrupt Enables
-- 0x14 Interrupt Status
-- 0x18 Interrupt Flags

-- Control Register
-- [0] - FIFO Flush
-- [1] - Read Enable
-- [2] - Write Enable
-- FIFO Flags
-- [0] Empty
-- [1] Full
-- Interrupt Flag Register
-- [0] = Overrun
-- [1] = full

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

entity px_axis_ppkt_uram_fifo is
generic (
    has_in_tready     : boolean := false; -- has input tready (overrun is disabled if input flow control is present)
    has_in_reset      : boolean := true;
    data_width_bytes  : integer range 2 to 64 := 32; -- Number of uram fifo data bytes
    fifo_depth: integer range 512 to 65536 := 4096; -- fifo depth
    has_fifo_ovfl_led: boolean := true
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
   irq                   : out std_logic;

   axis_aclk             : in  std_logic;
   axis_aresetn          : in  std_logic; 
   -----------------------------------------------------------------------------
   -- AXI-S PPKT FIFO Input Stream
   -----------------------------------------------------------------------------    
   s_axis_ppkt_tvalid    : in  std_logic;
   s_axis_ppkt_tready    : out std_logic;
   -- Earliest byte in lower byte 
   s_axis_ppkt_tdata     : in  std_logic_vector((data_width_bytes*8)-1 downto 0);
   -- tuser[63:0]    = timestamp[63:0]  
   -- tuser[64]      = SOP   
   -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
   -- tuser[67]      = Data Type 0 = Real 1 = I/Q
   -- tuser[75:68]   = channel[7:0]
   -- tuser[79:76]   = user[3:0] These bits only valid only with tlast   
   s_axis_ppkt_tuser     : in  std_logic_vector(79 downto 0);
   s_axis_ppkt_tkeep     : in  std_logic_vector((data_width_bytes/2)-1 downto 0); -- One per 16-bit word (Note this is not standard 1 per byte)
   s_axis_ppkt_tlast     : in  std_logic; -- end of packet
   -----------------------------------------------------------------------------
   -- AXI-S PPKT FIFO Output Stream
   -----------------------------------------------------------------------------  
   m_axis_ppkt_tvalid    : out std_logic;
   m_axis_ppkt_tready    : in  std_logic;
   -- Earliest byte in lower byte 
   m_axis_ppkt_tdata     : out std_logic_vector((data_width_bytes*8)-1 downto 0);
   -- tuser[63:0]    = timestamp[63:0]  
   -- tuser[64]      = SOP   
   -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
   -- tuser[67]      = Data Type 0 = Real 1 = I/Q
   -- tuser[75:68]   = channel[7:0]
   -- tuser[79:76]   = user[3:0] These bits only valid only with tlast   
   m_axis_ppkt_tuser     : out std_logic_vector(79 downto 0);
   m_axis_ppkt_tkeep     : out std_logic_vector((data_width_bytes/2)-1 downto 0); -- One per 16-bit word (Note this is not standard 1 per byte)
   m_axis_ppkt_tlast     : out std_logic; -- end of packet
   -----------------------------------------------------------------------------
   -- FIFO External Signals
   -----------------------------------------------------------------------------
   fifo_resetn           : in  std_logic; -- synchronous to axis_aclk
   fifo_reset_out_n      : out std_logic; -- synchronous to axis_aclk  Output copy of internal FIFO reset
   fifo_ovfl_led         : out std_logic  -- active high indication of FIFO overflow (only when no input tready flow control)
   );
end px_axis_ppkt_uram_fifo;

architecture Behavioral of px_axis_ppkt_uram_fifo is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

COMPONENT px_axis_ppkt_uram_fifo_csr
  PORT (
    s_axi_csr_aclk : IN STD_LOGIC;
    s_axi_csr_aresetn : IN STD_LOGIC;
    s_axi_csr_awaddr : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    s_axi_csr_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_csr_awvalid : IN STD_LOGIC;
    s_axi_csr_awready : OUT STD_LOGIC;
    s_axi_csr_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_csr_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_csr_wvalid : IN STD_LOGIC;
    s_axi_csr_wready : OUT STD_LOGIC;
    s_axi_csr_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_csr_bvalid : OUT STD_LOGIC;
    s_axi_csr_bready : IN STD_LOGIC;
    s_axi_csr_araddr : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    s_axi_csr_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_csr_arvalid : IN STD_LOGIC;
    s_axi_csr_arready : OUT STD_LOGIC;
    s_axi_csr_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_csr_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_csr_rvalid : OUT STD_LOGIC;
    s_axi_csr_rready : IN STD_LOGIC;
    reg0_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl0_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat0_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat1_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat2_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    intrpt_src_in : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    irq : OUT STD_LOGIC
  );
END COMPONENT;

component xpm_fifo_axis
   generic (
      CDC_SYNC_STAGES : integer := 2;            -- DECIMAL
      CLOCKING_MODE  : string := "common_clock"; -- String
      ECC_MODE : string := "no_ecc";            -- String
      FIFO_DEPTH : integer := 2048;              -- DECIMAL
      FIFO_MEMORY_TYPE : string := "auto";      -- String
      PACKET_FIFO : string := "false";          -- String
      PROG_EMPTY_THRESH : integer := 5;          -- DECIMAL
      PROG_FULL_THRESH : integer := 7;           -- DECIMAL
      RD_DATA_COUNT_WIDTH : integer := 1;        -- DECIMAL
      RELATED_CLOCKS : integer := 0;             -- DECIMAL
      TDATA_WIDTH : integer := 32;               -- DECIMAL
      TDEST_WIDTH : integer := 1;                -- DECIMAL
      TID_WIDTH : integer := 1;                  -- DECIMAL
      TUSER_WIDTH : integer := 4;                -- DECIMAL
      USE_ADV_FEATURES : string := "1000";      -- String
      WR_DATA_COUNT_WIDTH :integer := 1         -- DECIMAL
   );
   port  (
      almost_empty_axis : out std_logic;   -- 1-bit output: Almost Empty : When asserted, this signal
                                                -- indicates that only one more read can be performed before
                                                -- the FIFO goes to empty.
      almost_full_axis : out std_logic;     -- 1-bit output: Almost Full: When asserted, this signal
                                                -- indicates that only one more write can be performed before
                                                -- the FIFO is full.
      dbiterr_axis : out std_logic;             -- 1-bit output: Double Bit Error- Indicates that the ECC
                                                -- decoder detected a double-bit error and data in the FIFO
                                                -- core is corrupted.
      m_axis_tdata : out std_logic_vector(TDATA_WIDTH-1 downto 0);             -- TDATA_WIDTH-bit output: TDATA: The primary payload that is
                                                -- used to provide the data that is passing across the
                                                -- interface. The width of the data payload is an integer
                                                -- number of bytes.
      m_axis_tdest : out std_logic_vector(TDEST_WIDTH-1 downto 0);              -- TDEST_WIDTH-bit output: TDEST: Provides routing information
                                                -- for the data stream.
      m_axis_tid  : out std_logic_vector(TID_WIDTH-1 downto 0);                 -- TID_WIDTH-bit output: TID: The data stream identifier that
                                                -- indicates different streams of data.
      m_axis_tkeep  : out std_logic_vector((TDATA_WIDTH/8)-1 downto 0);           -- TDATA_WIDTH-bit output: TKEEP: The byte qualifier that
                                                -- indicates whether the content of the associated byte of
                                                -- TDATA is processed as part of the data stream. Associated
                                                -- bytes that have the TKEEP byte qualifier deasserted are null
                                                -- bytes and can be removed from the data stream. For a 64-bit
                                                -- DATA, bit 0 corresponds to the least significant byte on
                                                -- DATA, and bit 7 corresponds to the most significant byte.
                                                -- For example: KEEP[0] = 1b, DATA[7:0] is not a NULL byte
                                                -- KEEP[7] = 0b, DATA[63:56] is a NULL byte .
      m_axis_tlast  : out std_logic;            -- 1-bit output: TLAST: Indicates the boundary of a packet.
      m_axis_tstrb  : out std_logic_vector((TDATA_WIDTH/8)-1 downto 0);            -- TDATA_WIDTH-bit output: TSTRB: The byte qualifier that
                                                -- indicates whether the content of the associated byte of
                                                -- TDATA is processed as a data byte or a position byte. For a
                                                -- 64-bit DATA, bit 0 corresponds to the least significant byte
                                                -- on DATA, and bit 0 corresponds to the least significant byte
                                                -- on DATA, and bit 7 corresponds to the most significant byte.
                                                -- For example: STROBE[0] = 1b, DATA[7:0] is valid STROBE[7] =
                                                -- 0b, DATA[63:56] is not valid .
      m_axis_tuser  : out std_logic_vector(TUSER_WIDTH-1 downto 0);             -- TUSER_WIDTH-bit output: TUSER: The user-defined sideband
                                                -- information that can be transmitted alongside the data
                                                -- stream.
      m_axis_tvalid  : out std_logic;         -- 1-bit output: TVALID: Indicates that the master is driving a
                                                -- valid transfer. A transfer takes place when both TVALID and
                                                -- TREADY are asserted .
      prog_empty_axis : out std_logic;       -- 1-bit output: Programmable Empty- This signal is asserted
                                                -- when the number of words in the FIFO is less than or equal
                                                -- to the programmable empty threshold value. It is de-asserted
                                                -- when the number of words in the FIFO exceeds the
                                                -- programmable empty threshold value.
      prog_full_axis : out std_logic;         -- 1-bit output: Programmable Full: This signal is asserted
                                                -- when the number of words in the FIFO is greater than or
                                                -- equal to the programmable full threshold value. It is
                                                -- de-asserted when the number of words in the FIFO is less
                                                -- than the programmable full threshold value.
      rd_data_count_axis : out std_logic_vector(RD_DATA_COUNT_WIDTH-1 downto 0);  -- RD_DATA_COUNT_WIDTH-bit output: Read Data Count- This bus
                                                -- indicates the number of words available for reading in the
                                                
                                                -- FIFO.
      s_axis_tready : out std_logic;            -- 1-bit output: TREADY: Indicates that the slave can accept a
                                                -- transfer in the current cycle.
      sbiterr_axis : out std_logic;            -- 1-bit output: Single Bit Error- Indicates that the ECC
                                                -- decoder detected and fixed a single-bit error.
      wr_data_count_axis : out std_logic_vector(WR_DATA_COUNT_WIDTH-1 downto 0); -- WR_DATA_COUNT_WIDTH-bit output: Write Data Count: This bus
                                                -- indicates the number of words written into the FIFO.
      injectdbiterr_axis : in std_logic;    -- 1-bit input: Double Bit Error Injection- Injects a double
                                                -- bit error if the ECC feature is used.
      injectsbiterr_axis : in std_logic; -- 1-bit input: Single Bit Error Injection- Injects a single
                                                -- bit error if the ECC feature is used.
      m_aclk : in std_logic;                       -- 1-bit input: Master Interface Clock: All signals on master
                                                -- interface are sampled on the rising edge of this clock.
      m_axis_tready : in std_logic;           -- 1-bit input: TREADY: Indicates that the slave can accept a
                                                -- transfer in the current cycle.
      s_aclk : in std_logic;                        -- 1-bit input: Slave Interface Clock: All signals on slave
                                                -- interface are sampled on the rising edge of this clock.
      s_aresetn : in std_logic;                  -- 1-bit input: Active low asynchronous reset.
      s_axis_tdata  : in std_logic_vector(TDATA_WIDTH-1 downto 0);             -- TDATA_WIDTH-bit input: TDATA: The primary payload that is
                                                -- used to provide the data that is passing across the
                                                -- interface. The width of the data payload is an integer
                                                -- number of bytes.
      s_axis_tdest : in std_logic_vector(TDEST_WIDTH-1 downto 0);             -- TDEST_WIDTH-bit input: TDEST: Provides routing information
                                                -- for the data stream.
      s_axis_tid : in std_logic_vector(TID_WIDTH-1 downto 0);                -- TID_WIDTH-bit input: TID: The data stream identifier that
                                                -- indicates different streams of data.
      s_axis_tkeep : in std_logic_vector((TDATA_WIDTH/8)-1 downto 0);             -- TDATA_WIDTH-bit input: TKEEP: The byte qualifier that
                                                -- indicates whether the content of the associated byte of
                                                -- TDATA is processed as part of the data stream. Associated
                                                -- bytes that have the TKEEP byte qualifier deasserted are null
                                                -- bytes and can be removed from the data stream. For a 64-bit
                                                -- DATA, bit 0 corresponds to the least significant byte on
                                                -- DATA, and bit 7 corresponds to the most significant byte.
                                                -- For example: KEEP[0] = 1b, DATA[7:0] is not a NULL byte
                                                -- KEEP[7] = 0b, DATA[63:56] is a NULL byte .
      s_axis_tlast : in std_logic;             -- 1-bit input: TLAST: Indicates the boundary of a packet.
      s_axis_tstrb : in std_logic_vector((TDATA_WIDTH/8)-1 downto 0);               -- TDATA_WIDTH-bit input: TSTRB: The byte qualifier that
                                                -- indicates whether the content of the associated byte of
                                                -- TDATA is processed as a data byte or a position byte. For a
                                                -- 64-bit DATA, bit 0 corresponds to the least significant byte
                                                -- on DATA, and bit 0 corresponds to the least significant byte
                                                -- on DATA, and bit 7 corresponds to the most significant byte.
                                                -- For example: STROBE[0] = 1b, DATA[7:0] is valid STROBE[7] =
                                                -- 0b, DATA[63:56] is not valid .
      s_axis_tuser : in std_logic_vector(TUSER_WIDTH-1 downto 0);           -- TUSER_WIDTH-bit input: TUSER: The user-defined sideband
                                                -- information that can be transmitted alongside the data
                                                -- stream.
      s_axis_tvalid : in std_logic           -- 1-bit input: TVALID: Indicates that the master is driving a
                                                -- valid transfer. A transfer takes place when both TVALID and
                                                -- TREADY are asserted .
   );
end component;

------------------------------------------------------------------------------
  -- Calculate the Log2 of a Unsigned Number
  ------------------------------------------------------------------------------
  function px_log2_unsigned ( x : natural ) return natural is
  variable temp : natural := x ;
  variable n : natural := 0 ;
  begin
      while temp > 1 loop
         temp := temp / 2 ;
         n := n + 1 ;
      end loop ;
      return n ;
   end function px_log2_unsigned ;
  
   -----------------------------------------------------------------------------------
   -- Log2 Rounded Up
   -- Combine the ceil and log2 functions.  ceil_log2(x) then gives the minimum number
   -- of bits required to represent 'x'.  ceil_log2(4) = 2, ceil_log2(5) = 3, etc.
   -----------------------------------------------------------------------------------
   -- Can be used to determine the number of bits required to represent a number
   function px_ceil_log2 (Arg : positive) return natural is
       variable RetVal:    natural;
   begin
       RetVal := px_log2_unsigned(Arg);
       if (Arg > (2**RetVal)) then
           return(RetVal + 1); -- RetVal is too small, so bump it up by 1 and return
       else
           return(RetVal); -- Just right
       end if;
   end function px_ceil_log2;

----------------------------------------------------------------------------------
-- Constants
----------------------------------------------------------------------------------

constant width_in_bits : integer := (data_width_bytes*8);
constant count_width: integer := px_ceil_log2(fifo_depth);
constant shft: integer := px_ceil_log2(data_width_bytes);

----------------------------------------------------------------------------------
-- Signals
----------------------------------------------------------------------------------
signal fifo_rstn        : std_logic := '0';  
signal rd_disable           : std_logic := '0'; 
signal ctl0_out             : std_logic_vector(31 downto 0)  := (others => '0');
signal stat0_in             : std_logic_vector(31 downto 0)  := (others => '0');
signal stat1_in             : std_logic_vector(31 downto 0)  := (others => '0');
signal stat2_in             : std_logic_vector(31 downto 0)  := (others => '0');
signal overrun              : std_logic := '0'; 
signal empty                : std_logic := '0';
signal wr_disable           : std_logic := '0';
signal flsh_n               : std_logic := '0';
signal flshx_n              : std_logic := '0';
signal ctlx                 : std_logic_vector(7 downto 0)  := (others => '0');
signal t1_fifo_resetn       : std_logic := '0';
signal cdc_rst              : std_logic := '0';
signal t1_overrun           : std_logic := '0';
signal t1_axis_aresetn      : std_logic := '0';
signal intrpt_src_in        : std_logic_vector(1 downto 0)  := (others => '0');
signal irqx                 : std_logic := '0';
signal t1_s_axi_csr_aresetn : std_logic := '0';
signal full                 : std_logic := '0';
signal rd_peak              : std_logic_vector(16 downto 0)  := (others => '0');
signal stat_regx            : std_logic_vector(35 downto 0)  := (others => '0');
signal src_sends            : std_logic := '0';
signal src_rcvs             : std_logic := '0';
signal dest_reqs            : std_logic := '0';
signal stat_reg_rs          : std_logic_vector(35 downto 0)  := (others => '0');
signal p_fifo_rstn          : std_logic := '0';
signal t2_axis_areset       : std_logic := '0';
signal fifo_rst             : std_logic := '0';
signal scnt                 : std_logic_vector(31 downto 0)  := (others => '0');
signal spk_cnt              : std_logic_vector(31 downto 0)  := (others => '0');
signal s_axis_tkeep         : std_logic_vector(data_width_bytes-1 downto 0);
signal m_axis_tkeep         : std_logic_vector(data_width_bytes-1 downto 0);
signal m_axis_tvalid        : std_logic := '0';
signal rd_data_count        : std_logic_vector(count_width-1 downto 0);
signal rd_data_count_rs     : std_logic_vector(16 downto 0);
signal s_axis_tready        : std_logic := '0';
signal m_axis_tready        : std_logic := '0';
signal s_axis_tvalid        : std_logic := '0';
signal fifo_rstn_v          : std_logic_vector(7 downto 0);
signal tstrb                : std_logic_vector(data_width_bytes-1 downto 0);
signal t1_fifo_rstn         : std_logic := '0';
-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_ppkt:m_axis_ppkt, ASSOCIATED_RESET axis_aresetn:fifo_resetn";

--------------------------------------------------------------------------------

begin


gen_tkeep: for i in 0 to ((data_width_bytes/2)-1) generate
   s_axis_tkeep(i*2)     <= s_axis_ppkt_tkeep(i);
   s_axis_tkeep((i*2)+1) <= s_axis_ppkt_tkeep(i); 
end generate;

tstrb <= (others => '0');

--------------------------------------------------------------------------------
-- Ultra RAM FIFO
--------------------------------------------------------------------------------

  xpm_fifo_axis_inst : xpm_fifo_axis
   generic map (
      CDC_SYNC_STAGES => 2,            -- DECIMAL
      CLOCKING_MODE => "common_clock", -- String
      ECC_MODE => "no_ecc",            -- String
      FIFO_DEPTH => fifo_depth,        -- DECIMAL
      FIFO_MEMORY_TYPE => "ultra",     -- String
      PACKET_FIFO => "false",          -- String
      PROG_EMPTY_THRESH => 5,          -- DECIMAL
      PROG_FULL_THRESH => 7,           -- DECIMAL
      RD_DATA_COUNT_WIDTH => count_width, -- DECIMAL
      RELATED_CLOCKS => 0,             -- DECIMAL
      TDATA_WIDTH => width_in_bits,    -- DECIMAL
      TDEST_WIDTH => 1,                -- DECIMAL
      TID_WIDTH => 1,                  -- DECIMAL
      TUSER_WIDTH => 80,               -- DECIMAL
      USE_ADV_FEATURES => "1400",      -- String
      WR_DATA_COUNT_WIDTH => count_width -- DECIMAL
   )
   port map (
      almost_empty_axis => open,   -- 1-bit output: Almost Empty : When asserted, this signal
                                                -- indicates that only one more read can be performed before
                                                -- the FIFO goes to empty.
      almost_full_axis => open,     -- 1-bit output: Almost Full: When asserted, this signal
                                                -- indicates that only one more write can be performed before
                                                -- the FIFO is full.
      dbiterr_axis => open,             -- 1-bit output: Double Bit Error- Indicates that the ECC
                                                -- decoder detected a double-bit error and data in the FIFO
                                                -- core is corrupted.
      m_axis_tdata => m_axis_ppkt_tdata,        -- TDATA_WIDTH-bit output: TDATA: The primary payload that is
                                                -- used to provide the data that is passing across the
                                                -- interface. The width of the data payload is an integer
                                                -- number of bytes.
      m_axis_tdest => open,             -- TDEST_WIDTH-bit output: TDEST: Provides routing information
                                                -- for the data stream.
      m_axis_tid => open,                 -- TID_WIDTH-bit output: TID: The data stream identifier that
                                                -- indicates different streams of data.
      m_axis_tkeep => m_axis_tkeep,             -- TDATA_WIDTH-bit output: TKEEP: The byte qualifier that
                                                -- indicates whether the content of the associated byte of
                                                -- TDATA is processed as part of the data stream. Associated
                                                -- bytes that have the TKEEP byte qualifier deasserted are null
                                                -- bytes and can be removed from the data stream. For a 64-bit
                                                -- DATA, bit 0 corresponds to the least significant byte on
                                                -- DATA, and bit 7 corresponds to the most significant byte.
                                                -- For example: KEEP[0] = 1b, DATA[7:0] is not a NULL byte
                                                -- KEEP[7] = 0b, DATA[63:56] is a NULL byte .
      m_axis_tlast => m_axis_ppkt_tlast,             -- 1-bit output: TLAST: Indicates the boundary of a packet.
      m_axis_tstrb => open,             -- TDATA_WIDTH-bit output: TSTRB: The byte qualifier that
                                                -- indicates whether the content of the associated byte of
                                                -- TDATA is processed as a data byte or a position byte. For a
                                                -- 64-bit DATA, bit 0 corresponds to the least significant byte
                                                -- on DATA, and bit 0 corresponds to the least significant byte
                                                -- on DATA, and bit 7 corresponds to the most significant byte.
                                                -- For example: STROBE[0] = 1b, DATA[7:0] is valid STROBE[7] =
                                                -- 0b, DATA[63:56] is not valid .
      m_axis_tuser => m_axis_ppkt_tuser,             -- TUSER_WIDTH-bit output: TUSER: The user-defined sideband
                                                -- information that can be transmitted alongside the data
                                                -- stream.
      m_axis_tvalid => m_axis_tvalid,           -- 1-bit output: TVALID: Indicates that the master is driving a
                                                -- valid transfer. A transfer takes place when both TVALID and
                                                -- TREADY are asserted .
      prog_empty_axis => open,       -- 1-bit output: Programmable Empty- This signal is asserted
                                                -- when the number of words in the FIFO is less than or equal
                                                -- to the programmable empty threshold value. It is de-asserted
                                                -- when the number of words in the FIFO exceeds the
                                                -- programmable empty threshold value.
      prog_full_axis => open,         -- 1-bit output: Programmable Full: This signal is asserted
                                                -- when the number of words in the FIFO is greater than or
                                                -- equal to the programmable full threshold value. It is
                                                -- de-asserted when the number of words in the FIFO is less
                                                -- than the programmable full threshold value.
      rd_data_count_axis => rd_data_count, -- RD_DATA_COUNT_WIDTH-bit output: Read Data Count- This bus
                                                -- indicates the number of words available for reading in the
                                                
                                                -- FIFO.
      s_axis_tready => s_axis_tready,           -- 1-bit output: TREADY: Indicates that the slave can accept a
                                                -- transfer in the current cycle.
      sbiterr_axis => open,             -- 1-bit output: Single Bit Error- Indicates that the ECC
                                                -- decoder detected and fixed a single-bit error.
      wr_data_count_axis => open, -- WR_DATA_COUNT_WIDTH-bit output: Write Data Count: This bus
                                                -- indicates the number of words written into the FIFO.
      injectdbiterr_axis => '0', -- 1-bit input: Double Bit Error Injection- Injects a double
                                                -- bit error if the ECC feature is used.
      injectsbiterr_axis => '0', -- 1-bit input: Single Bit Error Injection- Injects a single
                                                -- bit error if the ECC feature is used.
      m_aclk => axis_aclk,                         -- 1-bit input: Master Interface Clock: All signals on master
                                                -- interface are sampled on the rising edge of this clock.
      m_axis_tready => m_axis_tready,           -- 1-bit input: TREADY: Indicates that the slave can accept a
                                                -- transfer in the current cycle.
      s_aclk => axis_aclk,                         -- 1-bit input: Slave Interface Clock: All signals on slave
                                                -- interface are sampled on the rising edge of this clock.
      s_aresetn => fifo_rstn,                   -- 1-bit input: Active low asynchronous reset.
      s_axis_tdata => s_axis_ppkt_tdata,             -- TDATA_WIDTH-bit input: TDATA: The primary payload that is
                                                -- used to provide the data that is passing across the
                                                -- interface. The width of the data payload is an integer
                                                -- number of bytes.
      s_axis_tdest => "0",             -- TDEST_WIDTH-bit input: TDEST: Provides routing information
                                                -- for the data stream.
      s_axis_tid => "0",                 -- TID_WIDTH-bit input: TID: The data stream identifier that
                                                -- indicates different streams of data.
      s_axis_tkeep => s_axis_tkeep,             -- TDATA_WIDTH-bit input: TKEEP: The byte qualifier that
                                                -- indicates whether the content of the associated byte of
                                                -- TDATA is processed as part of the data stream. Associated
                                                -- bytes that have the TKEEP byte qualifier deasserted are null
                                                -- bytes and can be removed from the data stream. For a 64-bit
                                                -- DATA, bit 0 corresponds to the least significant byte on
                                                -- DATA, and bit 7 corresponds to the most significant byte.
                                                -- For example: KEEP[0] = 1b, DATA[7:0] is not a NULL byte
                                                -- KEEP[7] = 0b, DATA[63:56] is a NULL byte .
      s_axis_tlast => s_axis_ppkt_tlast,             -- 1-bit input: TLAST: Indicates the boundary of a packet.
      s_axis_tstrb => tstrb,             -- TDATA_WIDTH-bit input: TSTRB: The byte qualifier that
                                                -- indicates whether the content of the associated byte of
                                                -- TDATA is processed as a data byte or a position byte. For a
                                                -- 64-bit DATA, bit 0 corresponds to the least significant byte
                                                -- on DATA, and bit 0 corresponds to the least significant byte
                                                -- on DATA, and bit 7 corresponds to the most significant byte.
                                                -- For example: STROBE[0] = 1b, DATA[7:0] is valid STROBE[7] =
                                                -- 0b, DATA[63:56] is not valid .
      s_axis_tuser => s_axis_ppkt_tuser,             -- TUSER_WIDTH-bit input: TUSER: The user-defined sideband
                                                -- information that can be transmitted alongside the data
                                                -- stream.
      s_axis_tvalid => s_axis_tvalid            -- 1-bit input: TVALID: Indicates that the master is driving a
                                                -- valid transfer. A transfer takes place when both TVALID and
                                                -- TREADY are asserted .
   );


--------------------------------------------------------------------------------
-- Read/Write Control
--------------------------------------------------------------------------------
s_axis_ppkt_tready <= s_axis_tready and (not wr_disable) and fifo_rstn_v(1);
s_axis_tvalid      <= s_axis_ppkt_tvalid and (not wr_disable) and fifo_rstn_v(1);
m_axis_ppkt_tvalid <= m_axis_tvalid and not rd_disable;
m_axis_tready      <= m_axis_ppkt_tready and not rd_disable;

gen_out_tkeep: for i in 0 to ((data_width_bytes/2)-1) generate
   m_axis_ppkt_tkeep(i)     <= m_axis_tkeep(i*2);
end generate;

process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      fifo_reset_out_n <= fifo_rstn;
      t1_axis_aresetn <= axis_aresetn;
      t2_axis_areset  <= not t1_axis_aresetn;
   end if;
end process;

-- Overrun
process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
     if (has_in_tready = false) then
        overrun <= (not s_axis_tready) and fifo_rstn and s_axis_ppkt_tvalid;
     else
        overrun <= '0';
     end if;   
   end if;
end process;     

--------------------------------------------------------------------------------
-- Control/Status Registers
--------------------------------------------------------------------------------
csr_inst: px_axis_ppkt_uram_fifo_csr
  port map (
    s_axi_csr_aclk => s_axi_csr_aclk,
    s_axi_csr_aresetn => s_axi_csr_aresetn,
    s_axi_csr_awaddr => s_axi_csr_awaddr(6 downto 0),
    s_axi_csr_awprot => s_axi_csr_awprot,
    s_axi_csr_awvalid => s_axi_csr_awvalid,
    s_axi_csr_awready => s_axi_csr_awready,
    s_axi_csr_wdata => s_axi_csr_wdata,
    s_axi_csr_wstrb => s_axi_csr_wstrb,
    s_axi_csr_wvalid => s_axi_csr_wvalid,
    s_axi_csr_wready => s_axi_csr_wready,
    s_axi_csr_bresp => s_axi_csr_bresp,
    s_axi_csr_bvalid => s_axi_csr_bvalid,
    s_axi_csr_bready => s_axi_csr_bready,
    s_axi_csr_araddr => s_axi_csr_araddr(6 downto 0),
    s_axi_csr_arprot => s_axi_csr_arprot,
    s_axi_csr_arvalid => s_axi_csr_arvalid,
    s_axi_csr_arready => s_axi_csr_arready,
    s_axi_csr_rdata => s_axi_csr_rdata,
    s_axi_csr_rresp => s_axi_csr_rresp,
    s_axi_csr_rvalid => s_axi_csr_rvalid,
    s_axi_csr_rready => s_axi_csr_rready,
    reg0_init_val => x"00000000",
    ctl0_out => ctl0_out,
    stat0_in => stat0_in,
    stat1_in => stat1_in,
    stat2_in => stat2_in,
    intrpt_src_in => intrpt_src_in,
    irq => irqx
  );

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      irq <= irqx;
   end if;
end process;   
    
--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------              

ctl_cdc_inst: xpm_cdc_array_single
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    INIT_SYNC_FF   => 1, -- integer; 0=disable simulation init values, 1=enable simulation init values
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 8  -- integer; range: 1-1024
  )
  port map (
    src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => ctl0_out(7 downto 0),
    dest_clk => axis_aclk,
    dest_out => ctlx
  );

flsh_n <= not(ctl0_out(0) or (not t1_s_axi_csr_aresetn)); 

cdc_flsh_inst: xpm_cdc_async_rst
  generic map (
    -- Common module parameters
     DEST_SYNC_FF    => 3, -- integer; range: 2-10
     RST_ACTIVE_HIGH => 0  -- integer; 0=active low reset, 1=active high reset
  )
  port map (
     src_arst  => flsh_n,
     dest_clk  => axis_aclk,
     dest_arst => flshx_n
  );
    
process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      t1_fifo_resetn <= fifo_resetn;
      p_fifo_rstn <= flshx_n and t1_axis_aresetn and t1_fifo_resetn; 
      rd_disable<= ctlx(1);
      wr_disable<= ctlx(2);    
   end if;
end process;       

fifo_rstn <= p_fifo_rstn;
        
--------------------------------------------------------------------------------
-- Status 
--------------------------------------------------------------------------------

 ----------------------------------------------------------------------------------------------
-- Flags
----------------------------------------------------------------------------------------------
--Channel 0
process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      fifo_rstn_v <= fifo_rstn_v(6 downto 0) & fifo_rstn;
      if (fifo_rstn_v = "11111111") and  (fifo_rstn = '1')then
         full <= not s_axis_tready;
      else
         full <= '0';
      end if;
   end if;
end process;   

process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      if (fifo_rstn = '0') then
         empty <= '1'; 
      else
         empty <= not m_axis_tvalid; 
      end if;
   end if;
end process; 

rd_data_count_rs(count_width -1 downto 0) <= rd_data_count;
rd_data_count_rs(16 downto count_width) <= (others => '0');

-- Ch0 Total Count
process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      if (fifo_rstn = '0') then
         rd_peak <= (others => '0');
      elsif (('0' & rd_peak) < ('0' & rd_data_count_rs)) then
         rd_peak <= rd_data_count_rs;
      end if; 
   end if;
end process;

process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
     stat_regx <= rd_peak(16 downto 0) & full &  empty & rd_data_count_rs;
   end if;
end process;

ch0_stat_xclk:  xpm_cdc_handshake
generic map (
  -- Common module generics
  DEST_EXT_HSK   => 0, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 3, -- integer; range: 2-10
  WIDTH          => 36 -- integer; range: 1-1024
)
port map (
  src_clk  => axis_aclk,
  src_in   => stat_regx,
  src_send => src_sends,
  src_rcv  => src_rcvs,
  dest_clk => s_axi_csr_aclk,
  dest_req => dest_reqs,
  dest_ack => dest_reqs, 
  dest_out => stat_reg_rs
);
 
process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
     if (src_rcvs = '1') then
       src_sends <= '0';
     elsif (src_rcvs = '0') and (src_sends = '0') then
       src_sends <= '1';
     end if;  
   end if;
end process;   

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      t1_s_axi_csr_aresetn  <= s_axi_csr_aresetn;
      stat0_in <= scnt; -- Total Count
      stat1_in <= spk_cnt; -- Peak Count
      stat2_in(1 downto 0)  <= stat_reg_rs(18) & stat_reg_rs(17);
   end if;
end process;

scnt(shft-1 downto 0) <= (others => '0');
scnt(shft+16 downto shft) <= stat_reg_rs(16 downto 0);
scnt(31 downto shft+17) <= (others => '0');

spk_cnt(shft-1 downto 0) <= (others => '0');
spk_cnt(shft+16 downto shft) <= stat_reg_rs(35 downto 19);
spk_cnt(31 downto shft+17) <= (others => '0');

stat2_in(31 downto 2)  <= (others => '0'); 

ch0_overrun_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_aclk,
    src_rst    => cdc_rst,  -- optional; required when RST_USED = 1
    src_pulse  => overrun,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => intrpt_src_in(0)
);

ch0_full_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_aclk,
    src_rst    => cdc_rst,  -- optional; required when RST_USED = 1
    src_pulse  => full,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => intrpt_src_in(1)
);

process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      cdc_rst       <= not t1_axis_aresetn;
      t1_overrun    <= overrun;
      fifo_ovfl_led <= t1_overrun;
   end if;
end process;   


end Behavioral;
