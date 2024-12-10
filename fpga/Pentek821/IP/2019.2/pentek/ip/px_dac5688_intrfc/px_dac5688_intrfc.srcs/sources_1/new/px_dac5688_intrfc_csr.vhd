----------------------------------------------------------------------------------
-- Control/Status Registers for Pentek DAC5688 DAC Interface
----------------------------------------------------------------------------------
-- px_dac5688_intrfc_csr.vhd
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
-------------------------------------------------------------------------------
----------------------------------------------------------------------------------

-- Memory Map
-- 0x00 - Control 1
-- 0x04 - Control 2
-- 0x08 - 
-- 0x0C - DAC Serial Control
-- 0x10 - DAC Serial Status
-- 0x14 - Interrupt Enables
-- 0x18 - Interrupt Status
-- 0x1C - Interrupt Flags

-- Control 1
--Bit [8:0]   - Tap Delay
--Bit [9]     - Tap Load

-- Control 2
--Bit [0]     - DAC Reset 
--Bit [1]     - TX ENABLE 
--Bit [2]     - SYNC Enable

-- DAC Serial Control
--Bit [0]     - Serial Access Request (toggle)
--Bit [1]     - Serial Read/Write 0 = Write 1 = Read   
--Bit [12:8]  - Serial Address
--Bit [23:16] - Serial Write Data

-- DAC Status
--Bit [0]     - Serial Access Done
--Bit [1]     - DAC Lock
--Bit [23:16] - Serial Read Data

-- Interrupts
-- Bit [4] Serial Access Done
-- Bit [5] DAC Lock

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
use IEEE.NUMERIC_STD.ALL;
Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_dac5688_intrfc_csr is
generic(
    initial_tap_delay   : integer := 0
);
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
   s_axi_csr_aclk         : in  std_logic;
   s_axi_csr_aresetn      : in  std_logic;
   s_axi_csr_awaddr       : in  std_logic_vector(6 downto 0); -- only [5:0] used
   s_axi_csr_awprot       : in  std_logic_vector(2 downto 0);
   s_axi_csr_awvalid      : in  std_logic;
   s_axi_csr_awready      : out std_logic;
   s_axi_csr_wdata        : in  std_logic_vector(31 downto 0);
   s_axi_csr_wstrb        : in  std_logic_vector(3 downto 0);
   s_axi_csr_wvalid       : in  std_logic;
   s_axi_csr_wready       : out std_logic;
   s_axi_csr_bresp        : out std_logic_vector(1 downto 0);
   s_axi_csr_bvalid       : out std_logic;
   s_axi_csr_bready       : in  std_logic;
   s_axi_csr_araddr       : in  std_logic_vector(6 downto 0);  -- only [5:0] used
   s_axi_csr_arprot       : in  std_logic_vector(2 downto 0);
   s_axi_csr_arvalid      : in  std_logic;
   s_axi_csr_arready      : out std_logic;
   s_axi_csr_rdata        : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp        : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid       : out std_logic;
   s_axi_csr_rready       : in  std_logic;
    
    irq                   : out std_logic; -- interrupt
    
   s_axis_aclk            : in  std_logic; 
--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------    
    tap_delay             : out std_logic_vector(8 downto 0);
    dly_ld_ctl            : out std_logic;
    txen                  : out std_logic;
    dac_resetn            : out std_logic;
    sync_en               : out std_logic;
    -- Serial Control Interface
    ser_wr_data           : out std_logic_vector(7 downto 0); 
    ser_addr              : out std_logic_vector(4 downto 0);  
    ser_wr_pls            : out std_logic;  
    ser_rd_pls            : out std_logic;  
    ser_rd_data           : in  std_logic_vector(7 downto 0);
-------------------------------------------------------------------------------
-- Status
-------------------------------------------------------------------------------    
    ser_sm_rdy            : in  std_logic;
-------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------
    dac_lock              : in  std_logic
);
end  px_dac5688_intrfc_csr;

architecture Behavioral of px_dac5688_intrfc_csr is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Generic AXI-Lite Control/Status Register Set
COMPONENT px_axil_csr_dac5688
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
    reg1_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    reg2_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    reg3_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl0_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl1_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl2_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl3_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat0_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    intrpt_src_in : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    irq : OUT STD_LOGIC
  );
END COMPONENT;

COMPONENT px_dac5688_intrfc_xclk
  PORT (
    in_clk : IN STD_LOGIC;
    in_sig : IN STD_LOGIC;
    out_sig : OUT STD_LOGIC;
    out_clk : IN STD_LOGIC
  );
END COMPONENT;

---------------------------------------------------------------------------------
-- Constants
---------------------------------------------------------------------------------

constant CNTL_REG0_INIT_VAL: std_logic_vector(31 downto 0) := x"00000" & "000" & conv_std_logic_vector(initial_tap_delay, 9);
constant CNTL_REG1_INIT_VAL: std_logic_vector(31 downto 0) := x"00000000";
constant CNTL_REG2_INIT_VAL: std_logic_vector(31 downto 0) := x"00000000"; 
constant CNTL_REG3_INIT_VAL: std_logic_vector(31 downto 0) := x"00000000";

---------------------------------------------------------------------------------
-- Signals
---------------------------------------------------------------------------------
 
signal cntl_reg0            : std_logic_vector(31 downto 0) := CNTL_REG0_INIT_VAL;
signal cntl_reg1            : std_logic_vector(31 downto 0) := CNTL_REG1_INIT_VAL;
signal cntl_reg2            : std_logic_vector(31 downto 0) := CNTL_REG2_INIT_VAL;
signal cntl_reg3            : std_logic_vector(31 downto 0) := CNTL_REG3_INIT_VAL;
signal int_src_stat         : std_logic_vector(5 downto 0)  := (others => '0');
signal stat0_in             : std_logic_vector(31 downto 0) := (others => '0');
signal t1_ser_access        : std_logic := '0';
signal t1_ser_sm_rdy        : std_logic := '0';
signal ser_sm_rdy_int       : std_logic := '0';
signal t1_dac_lock          : std_logic := '0';
signal cntl_reg1x           : std_logic_vector(1 downto 0) := (others => '0');
signal dac_resetnx          : std_logic := '0';
signal rs_dac_resetn        : std_logic := '0';
signal dac_lock_int         : std_logic := '0';
signal rs_dac_lock          : std_logic := '0';

---------------------------------------------------------------------------------

begin

csr_inst: px_axil_csr_dac5688
  port map (
    s_axi_csr_aclk      => s_axi_csr_aclk,
    s_axi_csr_aresetn   => s_axi_csr_aresetn,
    s_axi_csr_awaddr    => s_axi_csr_awaddr,
    s_axi_csr_awprot    => s_axi_csr_awprot,
    s_axi_csr_awvalid   => s_axi_csr_awvalid,
    s_axi_csr_awready   => s_axi_csr_awready,
    s_axi_csr_wdata     => s_axi_csr_wdata,
    s_axi_csr_wstrb     => s_axi_csr_wstrb,
    s_axi_csr_wvalid    => s_axi_csr_wvalid,
    s_axi_csr_wready    => s_axi_csr_wready,
    s_axi_csr_bresp     => s_axi_csr_bresp,
    s_axi_csr_bvalid    => s_axi_csr_bvalid,
    s_axi_csr_bready    => s_axi_csr_bready,
    s_axi_csr_araddr    => s_axi_csr_araddr,
    s_axi_csr_arprot    => s_axi_csr_arprot,
    s_axi_csr_arvalid   => s_axi_csr_arvalid,
    s_axi_csr_arready   => s_axi_csr_arready,
    s_axi_csr_rdata     => s_axi_csr_rdata,
    s_axi_csr_rresp     => s_axi_csr_rresp,
    s_axi_csr_rvalid    => s_axi_csr_rvalid,
    s_axi_csr_rready    => s_axi_csr_rready,
    reg0_init_val       => CNTL_REG0_INIT_VAL,
    reg1_init_val       => CNTL_REG1_INIT_VAL,
    reg2_init_val       => CNTL_REG2_INIT_VAL,
    reg3_init_val       => CNTL_REG3_INIT_VAL,
    ctl0_out            => cntl_reg0,
    ctl1_out            => cntl_reg1,
    ctl2_out            => cntl_reg2,
    ctl3_out            => cntl_reg3,
    stat0_in            => stat0_in,
    intrpt_src_in       => int_src_stat,
    irq                 => irq
  );

--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------
-- Control 1
--Bit [8:0]   - Tap Delay
--Bit [9]     - Tap load 

-- Control 2
--Bit [0]     - DAC Reset 
--Bit [1]     - TX ENABLE 
--Bit [2]     - SYNC Enable

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
       tap_delay           <= cntl_reg0(8 downto 0);
       dac_resetnx <= not(cntl_reg1(0) or (not s_axi_csr_aresetn));
       dly_ld_ctl          <= cntl_reg0(9);
    end if;
end process;

rst_cdc_inst: xpm_cdc_sync_rst
  generic map (
     -- Common module parameters
     DEST_SYNC_FF    => 3, -- integer; range: 2-10
     INIT            => 0, -- integer; 0=initialize synchronization registers to 0,
                           --          1=initialize synchronization registers to 1
     SIM_ASSERT_CHK  => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
     src_rst  => dac_resetnx,
     dest_clk => s_axis_aclk,
     dest_rst => rs_dac_resetn
  );

ctl_cdc_inst: xpm_cdc_array_single
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 2  -- integer; range: 1-1024
  )
  port map (
    src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => cntl_reg1(2 downto 1),
    dest_clk => s_axis_aclk,
    dest_out => cntl_reg1x
  );

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
       txen       <= cntl_reg1x(0);
       sync_en    <= cntl_reg1x(1);
       dac_resetn <= rs_dac_resetn;
    end if;
end process;


-- DAC Serial Control
--Bit [0]     - Serial Access Request (toggle)
--Bit [1]     - Serial Read/Write 0 = Write 1 = Read   
--Bit [12:8]  - Serial Address
--Bit [23:15] - Serial Write Data
process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
        ser_wr_data   <= cntl_reg3(23 downto 16);
        ser_addr      <= cntl_reg3(12 downto 8);
        t1_ser_access <= cntl_reg3(0);
        ser_wr_pls    <= cntl_reg3(0) and (not t1_ser_access) and (not cntl_reg3(1));
        ser_rd_pls    <= cntl_reg3(0) and (not t1_ser_access) and (cntl_reg3(1));
    end if;
end process;

--------------------------------------------------------------------------------
-- Status
--------------------------------------------------------------------------------
process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
       stat0_in(0)            <= ser_sm_rdy;
       stat0_in(31 downto 16) <= x"00" & ser_rd_data; 
       t1_ser_sm_rdy          <= ser_sm_rdy;
       ser_sm_rdy_int         <= ser_sm_rdy and not t1_ser_sm_rdy;
       stat0_in(1)            <= rs_dac_lock;
       dac_lock_int           <= rs_dac_lock and not stat0_in(1);
    end if;
end process;

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
       t1_dac_lock            <= dac_lock;
    end if;
end process;

stat_cdc_inst: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 3, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => s_axis_aclk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => t1_dac_lock,
     dest_clk => s_axi_csr_aclk,
     dest_out => rs_dac_lock
  );

stat0_in(15 downto 2) <= (others => '0');

--------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------

-- Interrupts

int_src_stat <= dac_lock_int & ser_sm_rdy_int & "0000";

                    
end Behavioral;