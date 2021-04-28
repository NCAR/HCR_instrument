----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 07/26/2016 10:23:09 AM
-- Design Name: 
-- Module Name: px_dac5688_intrfc - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
-- Requires external IDELAYCTRL(s)

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
--Bit [9]     - VTC Disable 

-- Control 2
--Bit [0]     - DAC Reset 
--Bit [1]     - TX ENABLE 
--Bit [2]     - SYNC Enable

-- DAC Serial Control
--Bit [0]     - Serial Access Request (toggle)
--Bit [1]     - Serial Read/Write 0 = Write 1 = Read   
--Bit [12:8]  - Serial Address
--Bit [23:16] - Serial Write Data

-- DAC Serial Status
--Bit [0]     - Serial Access Done
--Bit [23:16] - Serial Read Data

-- Interrupts
-- Bit [4] Serial Access Done
-- Bit [5] DAC Lock

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
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
Library xpm;
use xpm.vcomponents.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity px_dac5688_intrfc is
generic (
   iodelay_grp         : string := "IODELAY_GRP";
   initial_tap_delay   : integer := 0;
   idelaycntrl_refclk_freq: integer := 200 -- in MHz
);
port (
   ----------------------------------------------------------------------------
   -- Control/Status Registers (AXI4-LITE)
   ----------------------------------------------------------------------------
   -- associated with s_axi_csr_aclk
   s_axi_csr_aclk           : in  std_logic;
   s_axi_csr_aresetn        : in  std_logic;
   s_axi_csr_awaddr         : in  std_logic_vector(6 downto 0);
   s_axi_csr_awprot         : in  std_logic_vector(2 downto 0);
   s_axi_csr_awvalid        : in  std_logic;
   s_axi_csr_awready        : out std_logic;
   s_axi_csr_wdata          : in  std_logic_vector(31 downto 0);
   s_axi_csr_wstrb          : in  std_logic_vector(3 downto 0);
   s_axi_csr_wvalid         : in  std_logic;
   s_axi_csr_wready         : out std_logic;
   s_axi_csr_bresp          : out std_logic_vector(1 downto 0);
   s_axi_csr_bvalid         : out std_logic;
   s_axi_csr_bready         : in  std_logic;
   s_axi_csr_araddr         : in  std_logic_vector(6 downto 0);
   s_axi_csr_arprot         : in  std_logic_vector(2 downto 0);
   s_axi_csr_arvalid        : in  std_logic;
   s_axi_csr_arready        : out std_logic;
   s_axi_csr_rdata          : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp          : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid         : out std_logic;
   s_axi_csr_rready         : in  std_logic;
    
   irq                      : out std_logic; -- Interrupt out (overload)
   ----------------------------------------------------------------------------
   -- DAC5688 Dual DAC
   ----------------------------------------------------------------------------
   -- Data to the DAC5688
   dac_da                  : out std_logic_vector(15 downto 0); -- DAC Data A
   dac_db                  : out std_logic_vector(15 downto 0); -- DAC Data B
   -- DAC SPI Control Bus
   dac_sclk                : out std_logic; -- SPI Bus Clock to the DAC
   dac_sdi                 : out std_logic; -- SPI Bus Data to the DAC
   dac_sdo                 : in  std_logic; -- SPI Bus Data from the DAC
   dac_sdenb               : out std_logic; -- SPI Bus Data to the DAC
   -- DAC Control/Status Signals
   dac_lock                : in std_logic;  -- PLL Lock Status from the DAC
   dac_tx_en               : out std_logic; -- transmit enable
   dac_sync                : out std_logic; -- DAC Sync
   dac_reset_n             : out std_logic; -- Reset to the DAC
   -------------------------------------------------------------------------------
   -- Output
   -------------------------------------------------------------------------------
   -- No back pressure supported
   -- Constant output flow
   
   -- tuser[63:0]    = timestamp[63:0] -- all zero not supported here
   -- tuser[71:64]   = Gate Positions  -- Only [64] is used here
   -- tuser[79:72]   = Sync Positions  -- Only [72] is used here    
   -- tuser[87:80]   = PPS Positions   -- Only [80] is used here
   -- tuser[92:88]   = Samples/Cycle   
   -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3=32 bit
   -- tuser[95]      = Data Type 0 = Real 1 = I/Q
   -- tuser[103:96]  = channel[7:0] 
   -- tuser[127:104] = Reserved 
   s_axis_aclk             : in  std_logic; -- Sample Clock input
   s_axis_pdti_tdata       : in  std_logic_vector(31 downto 0);
   s_axis_pdti_tuser       : in  std_logic_vector(127 downto 0);
   s_axis_pdti_tvalid      : in  std_logic  
);
end px_dac5688_intrfc;

architecture Behavioral of px_dac5688_intrfc is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------
-- Generic AXI-Lite Control/Status Register Set
-- Control/Status Registers
component px_dac5688_intrfc_csr
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
end component;

component dac5688_serial_com
port (
   clk       : in  std_logic; 
   rst_n     : in  std_logic;
   data_in   : in  std_logic_vector(7 downto 0);
   addr      : in  std_logic_vector(4 downto 0);
   wr_pls    : in  std_logic;
   rd_pls    : in  std_logic;
   data_out  : out std_logic_vector(7 downto 0);
   sm_rdy    : out std_logic;
   -- DAC serial signals
   dac_sdi   : out std_logic;
   dac_sdenb : out std_logic;
   dac_sclk  : out std_logic;
   dac_sdo   : in  std_logic
);
end component; 

COMPONENT px_dac5688_intrfc_tdfifo
  PORT (
    rst : IN STD_LOGIC;
    wr_clk : IN STD_LOGIC;
    rd_clk : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC
  );
END COMPONENT;

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------

constant refclk_freq : real := real(idelaycntrl_refclk_freq);

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of s_axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_pdti";

-- Assign the IODELAY components to the IODELAY CONTROL group.
attribute IODELAY_GROUP: string;
attribute IODELAY_GROUP of ODELAYE3_a0_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_a1_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_a2_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_a3_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_a4_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_a5_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_a6_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_a7_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_a8_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_a9_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_a10_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_a11_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_a12_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_a13_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_a14_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_a15_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_b0_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_b1_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_b2_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_b3_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_b4_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_b5_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_b6_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_b7_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_b8_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_b9_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_b10_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_b11_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_b12_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_b13_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_b14_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_b15_inst: label is iodelay_grp;
attribute IODELAY_GROUP of ODELAYE3_sync_inst: label is iodelay_grp;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal en_vtc             : std_logic := '0';
signal dly_ld             : std_logic := '0';
signal ld_cntr            : std_logic_vector(5 downto 0) := "000000";
signal t1_axis_pdti_tdata : std_logic_vector(31 downto 0) := (others => '0');
signal t1_axis_pdti_tuser : std_logic := '0';
signal ser_wr_data        : std_logic_vector(7 downto 0) := (others => '0');
signal ser_addr           : std_logic_vector(4 downto 0) := (others => '0');
signal ser_wr_pls         : std_logic := '0';
signal ser_rd_pls         : std_logic := '0';
signal ser_rd_data        : std_logic_vector(7 downto 0) := (others => '0');
signal ser_sm_rdy         : std_logic := '0';
signal t2_data_a          : std_logic_vector(15 downto 0) := (others => '0');
signal t2_data_b          : std_logic_vector(15 downto 0) := (others => '0');
signal txen               : std_logic := '0';
signal tap_delay          : std_logic_vector(8 downto 0) := (others => '0');
signal sync_en            : std_logic := '0';
signal t2_sync            : std_logic := '0';
signal t3_sync            : std_logic := '0';
signal t1_s_axi_csr_aresetn: std_logic := '0';
signal t2_s_axi_csr_aresetn: std_logic := '0';
signal t3_s_axi_csr_aresetn: std_logic := '0';
signal t4_s_axi_csr_aresetn: std_logic := '0';
signal t5_s_axi_csr_aresetn: std_logic := '0';
signal dly_ld_ctl_re      : std_logic := '0';
signal t1_dly_ld_ctl      : std_logic := '0';
signal dly_ld_ctl         : std_logic := '0';
signal ctl_dly_ld         : std_logic := '0';
signal ctl_en_vtc         : std_logic := '0';
signal ctl_tap_delay      : std_logic_vector(8 downto 0) := (others => '0');
signal td_wr_en           : std_logic := '0';
signal td_rd_en           : std_logic := '0';
signal td_din             : std_logic_vector(10 downto 0) := (others => '0');
signal td_dout            : std_logic_vector(10 downto 0) := (others => '0');
signal td_empty           : std_logic := '0';
signal td_rst             : std_logic := '0';
--------------------------------------------------------------------------------

begin

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
      t2_s_axi_csr_aresetn <= t1_s_axi_csr_aresetn;
      t3_s_axi_csr_aresetn <= t2_s_axi_csr_aresetn;
      t4_s_axi_csr_aresetn <= t3_s_axi_csr_aresetn;
      t5_s_axi_csr_aresetn <= t4_s_axi_csr_aresetn;
   end if;
end process;   

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if (t1_s_axi_csr_aresetn = '0') then 
         dly_ld_ctl_re <= '0';
         t1_dly_ld_ctl <= '0';
      else
         dly_ld_ctl_re <= (not t1_dly_ld_ctl) and dly_ld_ctl;
         t1_dly_ld_ctl <= dly_ld_ctl;
      end if;   
      if (t5_s_axi_csr_aresetn = '0') or (dly_ld_ctl_re = '1') then
         ld_cntr <= "000000";
      elsif (ld_cntr /= "111111") then       
         ld_cntr <= ld_cntr + 1;
      end if;   
      if ld_cntr = "100000" then
        ctl_dly_ld <= '1';
      else
        ctl_dly_ld <= '0';
      end if;
      if ld_cntr = "111111" then
        ctl_en_vtc <= '1';
      else
        ctl_en_vtc <= '0';
      end if;
   end if;
end process;

td_rst <= not t1_s_axi_csr_aresetn;

td_wr_en <= '0' when ((ld_cntr = "000000") or (ld_cntr = "111111")) else '1';
td_din <= ctl_dly_ld & ctl_en_vtc & ctl_tap_delay;

tdfifo_inst : px_dac5688_intrfc_tdfifo
  PORT MAP (
    rst => td_rst,
    wr_clk => s_axi_csr_aclk,
    rd_clk => s_axis_aclk,
    din => td_din,
    wr_en => td_wr_en,
    rd_en => td_rd_en,
    dout => td_dout,
    full => open,
    empty => td_empty
  );

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
    td_rd_en  <= not td_empty;
    dly_ld    <= td_dout(10) and not td_empty;
    en_vtc    <= td_dout(9) or td_empty;
    tap_delay <= td_dout(8 downto 0);
   end if;
end process;    
 
-------------------------------------------------------------------------------

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
      t1_axis_pdti_tdata <= s_axis_pdti_tdata;
      t1_axis_pdti_tuser <= s_axis_pdti_tuser(72); --SYNC
   end if;
end process;

-------------------------------------------------------------------------------
-- Output Pin Registers
-------------------------------------------------------------------------------
data_a_ff: process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
      t2_data_a  <= t1_axis_pdti_tdata(15 downto 0);
   end if;
end process;

data_b_ff: process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
      t2_data_b  <= t1_axis_pdti_tdata(31 downto 16);
   end if;
end process;

txen_ff: process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
      dac_tx_en      <= txen;
   end if;
end process;

sync_ff: process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
      t2_sync       <= t1_axis_pdti_tuser and sync_en;
   end if;
end process;

-------------------------------------------------------------------------------
-- Output Variable Delays
-------------------------------------------------------------------------------

ODELAYE3_a0_inst : ODELAYE3
   generic map (
      CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
      DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,           -- Output delay tap setting
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
      SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
      UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  -- SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => dac_da(0),         -- 1-bit output: Delayed data from ODATAIN input port
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axis_aclk,               -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
      INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
      LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
      ODATAIN => t2_data_a(0),         -- 1-bit input: Data input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

ODELAYE3_a1_inst : ODELAYE3
   generic map (
      CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
      DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,           -- Output delay tap setting
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
      SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
      UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  -- SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => dac_da(1),         -- 1-bit output: Delayed data from ODATAIN input port
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axis_aclk,               -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
      INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
      LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
      ODATAIN => t2_data_a(1),         -- 1-bit input: Data input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

ODELAYE3_a2_inst : ODELAYE3
   generic map (
      CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
      DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,           -- Output delay tap setting
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
      SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
      UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  -- SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => dac_da(2),         -- 1-bit output: Delayed data from ODATAIN input port
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axis_aclk,               -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
      INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
      LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
      ODATAIN => t2_data_a(2),         -- 1-bit input: Data input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
ODELAYE3_a3_inst : ODELAYE3
      generic map (
         CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
         DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
         DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
         DELAY_VALUE => 0,           -- Output delay tap setting
         IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
         IS_RST_INVERTED => '0',     -- Optional inversion for RST
         REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
         SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
         UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                     -- SYNC)
      )
      port map (
         CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
         CNTVALUEOUT => open, -- 9-bit output: Counter value output
         DATAOUT => dac_da(3),         -- 1-bit output: Delayed data from ODATAIN input port
         CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
         CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
         CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
         CLK => s_axis_aclk,               -- 1-bit input: Clock input
         CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
         EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
         INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
         LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
         ODATAIN => t2_data_a(3),         -- 1-bit input: Data input
         RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
      );
      
ODELAYE3_a4_inst : ODELAYE3
         generic map (
            CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
            DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
            DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
            DELAY_VALUE => 0,           -- Output delay tap setting
            IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
            IS_RST_INVERTED => '0',     -- Optional inversion for RST
            REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
            SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
            UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                        -- SYNC)
         )
         port map (
            CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
            CNTVALUEOUT => open, -- 9-bit output: Counter value output
            DATAOUT => dac_da(4),         -- 1-bit output: Delayed data from ODATAIN input port
            CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
            CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
            CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
            CLK => s_axis_aclk,               -- 1-bit input: Clock input
            CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
            EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
            INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
            LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
            ODATAIN => t2_data_a(4),         -- 1-bit input: Data input
            RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
         );
      
ODELAYE3_a5_inst : ODELAYE3
   generic map (
      CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
      DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,           -- Output delay tap setting
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
      SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
      UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  -- SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => dac_da(5),         -- 1-bit output: Delayed data from ODATAIN input port
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axis_aclk,               -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
      INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
      LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
      ODATAIN => t2_data_a(5),         -- 1-bit input: Data input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

ODELAYE3_a6_inst : ODELAYE3
   generic map (
      CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
      DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,           -- Output delay tap setting
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
      SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
      UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  -- SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => dac_da(6),         -- 1-bit output: Delayed data from ODATAIN input port
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axis_aclk,               -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
      INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
      LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
      ODATAIN => t2_data_a(6),         -- 1-bit input: Data input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
ODELAYE3_a7_inst : ODELAYE3
      generic map (
         CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
         DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
         DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
         DELAY_VALUE => 0,           -- Output delay tap setting
         IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
         IS_RST_INVERTED => '0',     -- Optional inversion for RST
         REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
         SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
         UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                     -- SYNC)
      )
      port map (
         CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
         CNTVALUEOUT => open, -- 9-bit output: Counter value output
         DATAOUT => dac_da(7),         -- 1-bit output: Delayed data from ODATAIN input port
         CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
         CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
         CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
         CLK => s_axis_aclk,               -- 1-bit input: Clock input
         CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
         EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
         INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
         LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
         ODATAIN => t2_data_a(7),         -- 1-bit input: Data input
         RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
      );

ODELAYE3_a8_inst : ODELAYE3
   generic map (
      CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
      DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,           -- Output delay tap setting
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
      SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
      UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  -- SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => dac_da(8),         -- 1-bit output: Delayed data from ODATAIN input port
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axis_aclk,               -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
      INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
      LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
      ODATAIN => t2_data_a(8),         -- 1-bit input: Data input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

ODELAYE3_a9_inst : ODELAYE3
   generic map (
      CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
      DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,           -- Output delay tap setting
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
      SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
      UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  -- SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => dac_da(9),         -- 1-bit output: Delayed data from ODATAIN input port
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axis_aclk,               -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
      INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
      LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
      ODATAIN => t2_data_a(9),         -- 1-bit input: Data input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

ODELAYE3_a10_inst : ODELAYE3
   generic map (
      CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
      DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,           -- Output delay tap setting
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
      SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
      UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  -- SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => dac_da(10),         -- 1-bit output: Delayed data from ODATAIN input port
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axis_aclk,               -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
      INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
      LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
      ODATAIN => t2_data_a(10),         -- 1-bit input: Data input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
ODELAYE3_a11_inst : ODELAYE3
      generic map (
         CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
         DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
         DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
         DELAY_VALUE => 0,           -- Output delay tap setting
         IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
         IS_RST_INVERTED => '0',     -- Optional inversion for RST
         REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
         SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
         UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                     -- SYNC)
      )
      port map (
         CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
         CNTVALUEOUT => open, -- 9-bit output: Counter value output
         DATAOUT => dac_da(11),         -- 1-bit output: Delayed data from ODATAIN input port
         CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
         CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
         CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
         CLK => s_axis_aclk,               -- 1-bit input: Clock input
         CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
         EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
         INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
         LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
         ODATAIN => t2_data_a(11),         -- 1-bit input: Data input
         RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
      );

ODELAYE3_a12_inst : ODELAYE3
   generic map (
      CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
      DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,           -- Output delay tap setting
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
      SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
      UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  -- SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => dac_da(12),         -- 1-bit output: Delayed data from ODATAIN input port
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axis_aclk,               -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
      INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
      LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
      ODATAIN => t2_data_a(12),         -- 1-bit input: Data input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

ODELAYE3_a13_inst : ODELAYE3
   generic map (
      CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
      DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,           -- Output delay tap setting
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
      SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
      UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  -- SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => dac_da(13),         -- 1-bit output: Delayed data from ODATAIN input port
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axis_aclk,               -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
      INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
      LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
      ODATAIN => t2_data_a(13),         -- 1-bit input: Data input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

ODELAYE3_a14_inst : ODELAYE3
   generic map (
      CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
      DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,           -- Output delay tap setting
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
      SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
      UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  -- SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => dac_da(14),         -- 1-bit output: Delayed data from ODATAIN input port
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axis_aclk,               -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
      INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
      LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
      ODATAIN => t2_data_a(14),         -- 1-bit input: Data input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
ODELAYE3_a15_inst : ODELAYE3
      generic map (
         CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
         DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
         DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
         DELAY_VALUE => 0,           -- Output delay tap setting
         IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
         IS_RST_INVERTED => '0',     -- Optional inversion for RST
         REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
         SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
         UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                     -- SYNC)
      )
      port map (
         CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
         CNTVALUEOUT => open, -- 9-bit output: Counter value output
         DATAOUT => dac_da(15),         -- 1-bit output: Delayed data from ODATAIN input port
         CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
         CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
         CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
         CLK => s_axis_aclk,               -- 1-bit input: Clock input
         CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
         EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
         INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
         LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
         ODATAIN => t2_data_a(15),         -- 1-bit input: Data input
         RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
      );
      
---------------------

ODELAYE3_b0_inst : ODELAYE3
   generic map (
      CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
      DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,           -- Output delay tap setting
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
      SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
      UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  -- SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => dac_db(0),         -- 1-bit output: Delayed data from ODATAIN input port
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axis_aclk,               -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
      INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
      LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
      ODATAIN => t2_data_b(0),         -- 1-bit input: Data input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

ODELAYE3_b1_inst : ODELAYE3
   generic map (
      CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
      DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,           -- Output delay tap setting
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
      SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
      UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  -- SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => dac_db(1),         -- 1-bit output: Delayed data from ODATAIN input port
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axis_aclk,               -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
      INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
      LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
      ODATAIN => t2_data_b(1),         -- 1-bit input: Data input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

ODELAYE3_b2_inst : ODELAYE3
   generic map (
      CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
      DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,           -- Output delay tap setting
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
      SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
      UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  -- SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => dac_db(2),         -- 1-bit output: Delayed data from ODATAIN input port
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axis_aclk,               -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
      INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
      LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
      ODATAIN => t2_data_b(2),         -- 1-bit input: Data input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
ODELAYE3_b3_inst : ODELAYE3
      generic map (
         CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
         DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
         DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
         DELAY_VALUE => 0,           -- Output delay tap setting
         IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
         IS_RST_INVERTED => '0',     -- Optional inversion for RST
         REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
         SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
         UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                     -- SYNC)
      )
      port map (
         CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
         CNTVALUEOUT => open, -- 9-bit output: Counter value output
         DATAOUT => dac_db(3),         -- 1-bit output: Delayed data from ODATAIN input port
         CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
         CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
         CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
         CLK => s_axis_aclk,               -- 1-bit input: Clock input
         CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
         EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
         INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
         LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
         ODATAIN => t2_data_b(3),         -- 1-bit input: Data input
         RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
      );
      
ODELAYE3_b4_inst : ODELAYE3
         generic map (
            CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
            DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
            DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
            DELAY_VALUE => 0,           -- Output delay tap setting
            IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
            IS_RST_INVERTED => '0',     -- Optional inversion for RST
            REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
            SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
            UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                        -- SYNC)
         )
         port map (
            CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
            CNTVALUEOUT => open, -- 9-bit output: Counter value output
            DATAOUT => dac_db(4),         -- 1-bit output: Delayed data from ODATAIN input port
            CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
            CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
            CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
            CLK => s_axis_aclk,               -- 1-bit input: Clock input
            CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
            EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
            INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
            LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
            ODATAIN => t2_data_b(4),         -- 1-bit input: Data input
            RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
         );
      
ODELAYE3_b5_inst : ODELAYE3
   generic map (
      CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
      DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,           -- Output delay tap setting
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
      SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
      UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  -- SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => dac_db(5),         -- 1-bit output: Delayed data from ODATAIN input port
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axis_aclk,               -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
      INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
      LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
      ODATAIN => t2_data_b(5),         -- 1-bit input: Data input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

ODELAYE3_b6_inst : ODELAYE3
   generic map (
      CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
      DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,           -- Output delay tap setting
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
      SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
      UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  -- SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => dac_db(6),         -- 1-bit output: Delayed data from ODATAIN input port
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axis_aclk,               -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
      INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
      LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
      ODATAIN => t2_data_b(6),         -- 1-bit input: Data input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
ODELAYE3_b7_inst : ODELAYE3
      generic map (
         CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
         DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
         DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
         DELAY_VALUE => 0,           -- Output delay tap setting
         IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
         IS_RST_INVERTED => '0',     -- Optional inversion for RST
         REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
         SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
         UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                     -- SYNC)
      )
      port map (
         CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
         CNTVALUEOUT => open, -- 9-bit output: Counter value output
         DATAOUT => dac_db(7),         -- 1-bit output: Delayed data from ODATAIN input port
         CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
         CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
         CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
         CLK => s_axis_aclk,               -- 1-bit input: Clock input
         CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
         EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
         INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
         LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
         ODATAIN => t2_data_b(7),         -- 1-bit input: Data input
         RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
      );

ODELAYE3_b8_inst : ODELAYE3
   generic map (
      CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
      DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,           -- Output delay tap setting
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
      SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
      UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  -- SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => dac_db(8),         -- 1-bit output: Delayed data from ODATAIN input port
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axis_aclk,               -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
      INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
      LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
      ODATAIN => t2_data_b(8),         -- 1-bit input: Data input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

ODELAYE3_b9_inst : ODELAYE3
   generic map (
      CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
      DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,           -- Output delay tap setting
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
      SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
      UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  -- SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => dac_db(9),         -- 1-bit output: Delayed data from ODATAIN input port
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axis_aclk,               -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
      INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
      LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
      ODATAIN => t2_data_b(9),         -- 1-bit input: Data input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

ODELAYE3_b10_inst : ODELAYE3
   generic map (
      CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
      DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,           -- Output delay tap setting
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
      SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
      UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  -- SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => dac_db(10),         -- 1-bit output: Delayed data from ODATAIN input port
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axis_aclk,               -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
      INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
      LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
      ODATAIN => t2_data_b(10),         -- 1-bit input: Data input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
ODELAYE3_b11_inst : ODELAYE3
      generic map (
         CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
         DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
         DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
         DELAY_VALUE => 0,           -- Output delay tap setting
         IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
         IS_RST_INVERTED => '0',     -- Optional inversion for RST
         REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
         SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
         UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                     -- SYNC)
      )
      port map (
         CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
         CNTVALUEOUT => open, -- 9-bit output: Counter value output
         DATAOUT => dac_db(11),         -- 1-bit output: Delayed data from ODATAIN input port
         CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
         CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
         CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
         CLK => s_axis_aclk,               -- 1-bit input: Clock input
         CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
         EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
         INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
         LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
         ODATAIN => t2_data_b(11),         -- 1-bit input: Data input
         RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
      );

ODELAYE3_b12_inst : ODELAYE3
   generic map (
      CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
      DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,           -- Output delay tap setting
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
      SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
      UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  -- SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => dac_db(12),         -- 1-bit output: Delayed data from ODATAIN input port
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axis_aclk,               -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
      INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
      LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
      ODATAIN => t2_data_b(12),         -- 1-bit input: Data input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

ODELAYE3_b13_inst : ODELAYE3
   generic map (
      CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
      DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,           -- Output delay tap setting
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
      SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
      UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  -- SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => dac_db(13),         -- 1-bit output: Delayed data from ODATAIN input port
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axis_aclk,               -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
      INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
      LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
      ODATAIN => t2_data_b(13),         -- 1-bit input: Data input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

ODELAYE3_b14_inst : ODELAYE3
   generic map (
      CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
      DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,           -- Output delay tap setting
      IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
      IS_RST_INVERTED => '0',     -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
      SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
      UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  -- SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => dac_db(14),         -- 1-bit output: Delayed data from ODATAIN input port
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axis_aclk,               -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
      INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
      LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
      ODATAIN => t2_data_b(14),         -- 1-bit input: Data input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
ODELAYE3_b15_inst : ODELAYE3
      generic map (
         CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
         DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
         DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
         DELAY_VALUE => 0,           -- Output delay tap setting
         IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
         IS_RST_INVERTED => '0',     -- Optional inversion for RST
         REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
         SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
         UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                     -- SYNC)
      )
      port map (
         CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
         CNTVALUEOUT => open, -- 9-bit output: Counter value output
         DATAOUT => dac_db(15),         -- 1-bit output: Delayed data from ODATAIN input port
         CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
         CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
         CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
         CLK => s_axis_aclk,               -- 1-bit input: Clock input
         CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
         EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
         INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
         LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
         ODATAIN => t2_data_b(15),         -- 1-bit input: Data input
         RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
      );
      
ODELAYE3_sync_inst : ODELAYE3
            generic map (
               CASCADE => "NONE",          -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
               DELAY_FORMAT => "TIME",     -- (COUNT, TIME)
               DELAY_TYPE => "VAR_LOAD",      -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
               DELAY_VALUE => 0,           -- Output delay tap setting
               IS_CLK_INVERTED => '0',     -- Optional inversion for CLK
               IS_RST_INVERTED => '0',     -- Optional inversion for RST
               REFCLK_FREQUENCY => refclk_freq,  -- IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
               SIM_DEVICE => "ULTRASCALE", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
               UPDATE_MODE => "ASYNC"      -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                           -- SYNC)
            )
            port map (
               CASC_OUT => open,       -- 1-bit output: Cascade delay output to IDELAY input cascade
               CNTVALUEOUT => open, -- 9-bit output: Counter value output
               DATAOUT => dac_sync,         -- 1-bit output: Delayed data from ODATAIN input port
               CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
               CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
               CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
               CLK => s_axis_aclk,               -- 1-bit input: Clock input
               CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
               EN_VTC => en_vtc,           -- 1-bit input: Keep delay constant over VT
               INC => '0',                 -- 1-bit input: Increment/Decrement tap delay input
               LOAD => dly_ld,             -- 1-bit input: Load DELAY_VALUE input
               ODATAIN => t2_sync,        -- 1-bit input: Data input
               RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
            );


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Control/Status Registers
--------------------------------------------------------------------------------
csr_inst: px_dac5688_intrfc_csr
generic map(
    initial_tap_delay   => initial_tap_delay
)
port map (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
-- Address Range - BASE + 0x00 -> BASE + 0x3F
--------------------------------------------------------------------------------
    s_axi_csr_aclk          => s_axi_csr_aclk,   
    s_axi_csr_aresetn       => t1_s_axi_csr_aresetn,
    s_axi_csr_awaddr        => s_axi_csr_awaddr,  
    s_axi_csr_awprot        => s_axi_csr_awprot,  
    s_axi_csr_awvalid       => s_axi_csr_awvalid, 
    s_axi_csr_awready       => s_axi_csr_awready, 
    s_axi_csr_wdata         => s_axi_csr_wdata,   
    s_axi_csr_wstrb         => s_axi_csr_wstrb,   
    s_axi_csr_wvalid        => s_axi_csr_wvalid,  
    s_axi_csr_wready        => s_axi_csr_wready,  
    s_axi_csr_bresp         => s_axi_csr_bresp,   
    s_axi_csr_bvalid        => s_axi_csr_bvalid,  
    s_axi_csr_bready        => s_axi_csr_bready,  
    s_axi_csr_araddr        => s_axi_csr_araddr,  
    s_axi_csr_arprot        => s_axi_csr_arprot,  
    s_axi_csr_arvalid       => s_axi_csr_arvalid, 
    s_axi_csr_arready       => s_axi_csr_arready, 
    s_axi_csr_rdata         => s_axi_csr_rdata,   
    s_axi_csr_rresp         => s_axi_csr_rresp,   
    s_axi_csr_rvalid        => s_axi_csr_rvalid,  
    s_axi_csr_rready        => s_axi_csr_rready,  
    
    irq                     => irq,    
    
    s_axis_aclk             => s_axis_aclk, -- DAC Sample Clock       
--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------    
    tap_delay               => ctl_tap_delay,
    dly_ld_ctl              => dly_ld_ctl,  
    txen                    => txen,      
    dac_resetn              => dac_reset_n,
    sync_en                 => sync_en,
    -- Serial Control Interface
    ser_wr_data             => ser_wr_data, 
    ser_addr                => ser_addr,    
    ser_wr_pls              => ser_wr_pls,  
    ser_rd_pls              => ser_rd_pls,  
    ser_rd_data             => ser_rd_data,
    -- Status 
    ser_sm_rdy              => ser_sm_rdy, 
 -------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------
    dac_lock                => dac_lock
);

--------------------------------------------------------------------------------
-- DAC Serial Communication
--------------------------------------------------------------------------------
ser_com_inst: dac5688_serial_com
port map (
   clk      => s_axi_csr_aclk, 
   rst_n    => t1_s_axi_csr_aresetn,
   data_in  => ser_wr_data,
   addr     => ser_addr,
   wr_pls   => ser_wr_pls,
   rd_pls   => ser_rd_pls,
   data_out => ser_rd_data,
   sm_rdy   => ser_sm_rdy,
   dac_sdi  => dac_sdi,
   dac_sdenb=> dac_sdenb,
   dac_sclk => dac_sclk,
   dac_sdo  => dac_sdo
);


end Behavioral;
