----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 01/23/2017 11:33:16 AM
-- Design Name: 
-- Module Name: px_adc5463intrfc - Behavioral
-- Project Name: 
-- Target Devices: Kintex UltraScale
-- Tool Versions: 
-- Description:  ads5463 Interface
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:

-- Requires external IDELAYCTRL(s)

-- Memory Map
-- 0x00 - Control 1
-- 0x04 - Control 2
-- 0x08 - Gain/Offset Trim 
-- 0x0C - Status
-- 0x10 - Reserved
-- 0x14 - Interrupt Enables
-- 0x18 - Interrupt Status
-- 0x1C - Interrupt Flags

-- IMPORTANT!!! This core assumes the sample clock is divided by 2 outside of the core. 

----------------------------------------------------------------------------------

-- (c) Copyright 2017 Pentek, Inc. All rights reserved.
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
Library UNISIM;
use UNISIM.vcomponents.all;

entity px_ads5463intrfc is
generic (
   iodelay_grp_0       : string := "IODELAY_GRP";
   iodelay_grp_1       : string := "IODELAY_GRP";
   iodelay_grp_2       : string := "IODELAY_GRP";
   iodelay_grp_3       : string := "IODELAY_GRP";
   iodelay_grp_4       : string := "IODELAY_GRP";
   iodelay_grp_5       : string := "IODELAY_GRP";
   iodelay_grp_6       : string := "IODELAY_GRP";
   iodelay_grp_7       : string := "IODELAY_GRP";
   iodelay_grp_8       : string := "IODELAY_GRP";
   iodelay_grp_9       : string := "IODELAY_GRP";
   iodelay_grp_10      : string := "IODELAY_GRP";
   iodelay_grp_11      : string := "IODELAY_GRP";
   iodelay_grp_12      : string := "IODELAY_GRP";
   iodelay_grp_13      : string := "IODELAY_GRP";   
   initial_tap_delay   : integer := 0;
   initial_gain_percent: integer := 100;
   initial_offset_counts : integer := 0;
   initial_2scomp      : boolean := true;
   initial_pdwnf       : boolean := false;
   initial_led_select  : integer range 0 to 3 := 0;
   differential_term   : string := "TERM_100"; -- "TERM_100" or "TERM_NONE"
   ibuf_low_pwr        : boolean := false;
   has_ext_led_src     : boolean := true;
   idelaycntrl_refclk_freq: integer := 200; -- in MHz
   initial_ovld_thresh : integer := 16;  -- counts from full scale
   led_pulse_stretch   : integer range 0 to 65535:= 65535 -- counts to pulse stretch LED
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
-------------------------------------------------------------------------------
-- ads5463 ADC Intput
-------------------------------------------------------------------------------
-- (LVDS)
   dp                       : in  std_logic_vector(13 downto 0);
   dn                       : in  std_logic_vector(13 downto 0);
   ovr_p                    : in  std_logic; -- overrun
   ovr_n                    : in  std_logic; -- overrun   
   sample_clk               : in  std_logic; -- Sample Clock input (1/2 Sample Rate)
   -- Sample Clock must be divided by two outside of this module
-------------------------------------------------------------------------------
-- Control Outputs
-------------------------------------------------------------------------------   
   pdwnf                    : out std_logic; -- power down
   ovld_led_n               : out std_logic; -- overload LED drive
   ext_led_src              : in  std_logic; -- optional external LED source input  
-------------------------------------------------------------------------------
-- Status Outputs
-------------------------------------------------------------------------------   
   adc_ovrld                : out std_logic;
   go_trim_ovrld            : out std_logic;
-------------------------------------------------------------------------------
-- Output
-------------------------------------------------------------------------------
   m_axis_dataio_tdata      : out std_logic_vector(31 downto 0); -- data(t1),data(t0) 
   m_axis_dataio_tvalid     : out std_logic
);
end px_ads5463intrfc;

architecture Behavioral of px_ads5463intrfc is

-------------------------------------------------------------------------------
-- Components
-------------------------------------------------------------------------------
-- B*(A+D) Rounded symetrically
-- B17 should be '0' to have a 16 bit unsigned multiplication factor
-- Latency = 4

component px_ads5463intrfc_gainoffset
port (
    clk : in std_logic;
    a : in std_logic_vector(15 downto 0);
    b : in std_logic_vector(16 downto 0);
    d : in std_logic_vector(15 downto 0);
    p : out std_logic_vector(17 downto 0)
  );
end component;

   
-- Control/Status Registers
component px_ads5463intrfc_csr
generic(
    initial_tap_delay   : integer := 0;
    initial_gain        : std_logic_vector(15 downto 0) := x"8000";  
    initial_offset      : std_logic_vector(15 downto 0) := x"0000";  
    initial_2scomp      : boolean := true; 
    initial_led_select  : integer range 0 to 3 := 0;
    initial_ovld_thresh : integer := 16;
    initial_pdwnf       : boolean := false
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
--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------    
    tap_delay             : out std_logic_vector(8 downto 0);
    int_delay             : out std_logic_vector(1 downto 0);
    twoscomp              : out std_logic;
    gain                  : out std_logic_vector(15 downto 0); 
    offset                : out std_logic_vector(15 downto 0); 
    ovld_thresh_cnt       : out std_logic_vector(15 downto 0);            
    led_sel               : out std_logic_vector(1 downto 0);
    pdwnf                 : out std_logic;
    dly_ld_ctl            : out std_logic;
-------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------
    adc_overload          : in  std_logic;
    go_overload           : in  std_logic
);
end component;

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------

constant cnst_initial_gain  : std_logic_vector(15 downto 0) := conv_std_logic_vector(integer((real(initial_gain_percent)/100.0) * 32768.0), 16);
constant cnst_initial_offset: std_logic_vector(15 downto 0) := conv_std_logic_vector(initial_offset_counts, 16);

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

-- Assign the IODELAY components to the IODELAY CONTROL group.
attribute IODELAY_GROUP: string;
attribute IODELAY_GROUP of IDELAYE3_inst0: label is iodelay_grp_0;
attribute IODELAY_GROUP of IDELAYE3_inst1: label is iodelay_grp_1;
attribute IODELAY_GROUP of IDELAYE3_inst2: label is iodelay_grp_2;
attribute IODELAY_GROUP of IDELAYE3_inst3: label is iodelay_grp_3;
attribute IODELAY_GROUP of IDELAYE3_inst4: label is iodelay_grp_4;
attribute IODELAY_GROUP of IDELAYE3_inst5: label is iodelay_grp_5;
attribute IODELAY_GROUP of IDELAYE3_inst6: label is iodelay_grp_6;
attribute IODELAY_GROUP of IDELAYE3_inst7: label is iodelay_grp_7;
attribute IODELAY_GROUP of IDELAYE3_inst8: label is iodelay_grp_8;
attribute IODELAY_GROUP of IDELAYE3_inst9: label is iodelay_grp_9;
attribute IODELAY_GROUP of IDELAYE3_inst10: label is iodelay_grp_10;
attribute IODELAY_GROUP of IDELAYE3_inst11: label is iodelay_grp_11;
attribute IODELAY_GROUP of IDELAYE3_inst12: label is iodelay_grp_12;
attribute IODELAY_GROUP of IDELAYE3_inst13: label is iodelay_grp_13;

attribute DIFF_TERM_ADV: string; 
attribute DIFF_TERM_ADV of dp     : signal is differential_term;


ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of sample_clk: SIGNAL is "xilinx.com:signal:clock:1.0 sample_clk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of sample_clk: SIGNAL is "ASSOCIATED_BUSIF m_axis_dataio";
ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------

constant refclk_freq : real := real(idelaycntrl_refclk_freq);

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal ibuf_data        : std_logic_vector(13 downto 0) := (others => '0');
signal idelay_data      : std_logic_vector(13 downto 0) := (others => '0');
signal t1_intrlv_data   : std_logic_vector(27 downto 0) := (others => '0');
signal q1_data          : std_logic_vector(13 downto 0) := (others => '0');
signal q2_data          : std_logic_vector(13 downto 0) := (others => '0');
signal t1_q1_data       : std_logic_vector(13 downto 0) := (others => '0');
signal t1_q2_data       : std_logic_vector(13 downto 0) := (others => '0');
signal ld_cntr          : std_logic_vector(5 downto 0) := "000000";
signal dly_ld           : std_logic := '0';
signal tap_delay        : std_logic_vector(8 downto 0) := (others => '0');
signal int_delay        : std_logic_vector(1 downto 0) := (others => '0');
signal sample_clk_n     : std_logic := '0';
signal a0_data_in       : std_logic_vector(15 downto 0) := (others => '0');
signal a1_data_in       : std_logic_vector(15 downto 0) := (others => '0');
signal b_data_in        : std_logic_vector(16 downto 0) := (others => '0');
signal d_data_in        : std_logic_vector(15 downto 0) := (others => '0');
signal t5_data0_go      : std_logic_vector(17 downto 0) := (others => '0');
signal t5_data1_go      : std_logic_vector(17 downto 0) := (others => '0');
signal t6_sat0_data      : std_logic_vector(15 downto 0) := (others => '0');
signal t7_sat0_data      : std_logic_vector(15 downto 0) := (others => '0');
signal t8_sat0_data      : std_logic_vector(15 downto 0) := (others => '0');
signal t9_sat0_data      : std_logic_vector(15 downto 0) := (others => '0');
signal t6_sat1_data      : std_logic_vector(15 downto 0) := (others => '0');
signal t7_sat1_data      : std_logic_vector(15 downto 0) := (others => '0');
signal t8_sat1_data      : std_logic_vector(15 downto 0) := (others => '0');
signal t9_sat1_data      : std_logic_vector(15 downto 0) := (others => '0');
signal ovld_thresh_p    : std_logic_vector(15 downto 0) := (others => '0');
signal ovld_thresh_n    : std_logic_vector(15 downto 0) := (others => '0');
signal go_ovld0_sub     : std_logic_vector(16 downto 0) := (others => '0');
signal go_ovld1_sub     : std_logic_vector(16 downto 0) := (others => '0');
signal adc_overload     : std_logic := '0';
signal go_overload      : std_logic := '0';
signal adc_overloadx    : std_logic := '0';
signal go_overloadx     : std_logic := '0';
signal led_lite         : std_logic := '0';
signal pls_strch_cntr   : std_logic_vector(15 downto 0) := (others => '0');
signal gain             : std_logic_vector(15 downto 0) := (others => '0');
signal offset           : std_logic_vector(15 downto 0) := (others => '0');
signal ovld_thresh_cnt  : std_logic_vector(15 downto 0) := (others => '0');
signal led_sel          : std_logic_vector(1 downto 0) := (others => '0'); 
signal twoscomp         : std_logic := '0';
signal en_vtc           : std_logic := '0';
signal dly_ld_ctl_re    : std_logic := '0';
signal t1_dly_ld_ctl    : std_logic := '0';
signal dly_ld_ctl       : std_logic := '0';
signal gainx            : std_logic_vector(15 downto 0) := (others => '0');
signal offsetx          : std_logic_vector(15 downto 0) := (others => '0');
signal ovld_thresh_cntx : std_logic_vector(15 downto 0) := (others => '0');
signal int_delayx       : std_logic_vector(1 downto 0) := (others => '0');
signal led_selx         : std_logic_vector(1 downto 0) := (others => '0');
signal ctl_x            : std_logic_vector(52 downto 0) := (others => '0');
signal ctl              : std_logic_vector(52 downto 0) := (others => '0');
signal src_rcva         : std_logic := '0';
signal src_senda        : std_logic := '0';
signal dest_reqa        : std_logic := '0';
signal twoscompx        : std_logic := '0';
signal t1_s_axi_csr_aresetn: std_logic := '0';
signal ibuf_ovr         : std_logic := '0';
signal idelay_ovr       : std_logic := '0';
signal q1_ovr           : std_logic := '0';
signal q2_ovr           : std_logic := '0';
signal t1_ovr           : std_logic := '0';	

------------------------------------------------------------------------------

begin

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
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
      if (t1_s_axi_csr_aresetn = '0') or (dly_ld_ctl_re = '1') then
         ld_cntr <= "000000";
      elsif (ld_cntr /= "111111") then       
         ld_cntr <= ld_cntr + 1;
      end if;   
      if ld_cntr = "100000" then
        dly_ld <= '1';
      else
        dly_ld <= '0';
      end if;
      if ld_cntr = "111111" then
        en_vtc <= '1';
      else
        en_vtc <= '0';
      end if;
   end if;
end process;

-------------------------------------------------------------------------------
-- Input Differential LVDS Buffers
-------------------------------------------------------------------------------
gen_ibufds: for i in 0 to 13 generate

data_IBUFDS_inst0 : IBUFDS
generic map (
   IBUF_LOW_PWR   => ibuf_low_pwr,
   IOSTANDARD     => "LVDS"
)
port map (
   I  => dp(i), 
   IB => dn(i), 
   O  => ibuf_data(i)
);

end generate gen_ibufds;

ovr_IBUFDS_inst : IBUFDS
generic map (
   IBUF_LOW_PWR   => ibuf_low_pwr,
   IOSTANDARD     => "LVDS"
)
port map (
   I  => ovr_p, 
   IB => ovr_n, 
   O  => ibuf_ovr
);


--------------------------------------------------------------------------------
-- Tap Delays
--------------------------------------------------------------------------------

-- These tap delays are used to adjust the input setup/hold in relation to the clock
IDELAYE3_inst0 : IDELAYE3
   generic map (
      CASCADE => "NONE",         -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",    -- Units of the DELAY_VALUE (COUNT, TIME)
      DELAY_SRC => "IDATAIN",    -- Delay input (DATAIN, IDATAIN)
      DELAY_TYPE => "VAR_LOAD",     -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,          -- Input delay value setting
      IS_CLK_INVERTED => '0',    -- Optional inversion for CLK
      IS_RST_INVERTED => '0',    -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq, -- IDELAYCTRL clock input frequency in MHz (200.0-2400.0)
      UPDATE_MODE => "ASYNC"     -- Determines when updates to the delay will take effect (ASYNC, MANUAL, SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to ODELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => idelay_data(0),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_data(0),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
IDELAYE3_inst1 : IDELAYE3
      generic map (
         CASCADE => "NONE",         -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
         DELAY_FORMAT => "TIME",    -- Units of the DELAY_VALUE (COUNT, TIME)
         DELAY_SRC => "IDATAIN",    -- Delay input (DATAIN, IDATAIN)
         DELAY_TYPE => "VAR_LOAD",     -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
         DELAY_VALUE => 0,          -- Input delay value setting
         IS_CLK_INVERTED => '0',    -- Optional inversion for CLK
         IS_RST_INVERTED => '0',    -- Optional inversion for RST
         REFCLK_FREQUENCY => refclk_freq, -- IDELAYCTRL clock input frequency in MHz (200.0-2400.0)
         UPDATE_MODE => "ASYNC"     -- Determines when updates to the delay will take effect (ASYNC, MANUAL, SYNC)
      )
      port map (
         CASC_OUT => open,       -- 1-bit output: Cascade delay output to ODELAY input cascade
         CNTVALUEOUT => open, -- 9-bit output: Counter value output
         DATAOUT => idelay_data(1),         -- 1-bit output: Delayed data output
         CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
         CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
         CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
         CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
         CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
         DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
         EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
         IDATAIN => ibuf_data(1),         -- 1-bit input: Data input from the logic
         INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
         LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
         RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
      );

IDELAYE3_inst2 : IDELAYE3
   generic map (
      CASCADE => "NONE",         -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",    -- Units of the DELAY_VALUE (COUNT, TIME)
      DELAY_SRC => "IDATAIN",    -- Delay input (DATAIN, IDATAIN)
      DELAY_TYPE => "VAR_LOAD",     -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,          -- Input delay value setting
      IS_CLK_INVERTED => '0',    -- Optional inversion for CLK
      IS_RST_INVERTED => '0',    -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq, -- IDELAYCTRL clock input frequency in MHz (200.0-2400.0)
      UPDATE_MODE => "ASYNC"     -- Determines when updates to the delay will take effect (ASYNC, MANUAL, SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to ODELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => idelay_data(2),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_data(2),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

IDELAYE3_inst3 : IDELAYE3
   generic map (
      CASCADE => "NONE",         -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",    -- Units of the DELAY_VALUE (COUNT, TIME)
      DELAY_SRC => "IDATAIN",    -- Delay input (DATAIN, IDATAIN)
      DELAY_TYPE => "VAR_LOAD",     -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,          -- Input delay value setting
      IS_CLK_INVERTED => '0',    -- Optional inversion for CLK
      IS_RST_INVERTED => '0',    -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq, -- IDELAYCTRL clock input frequency in MHz (200.0-2400.0)
      UPDATE_MODE => "ASYNC"     -- Determines when updates to the delay will take effect (ASYNC, MANUAL, SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to ODELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => idelay_data(3),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_data(3),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

IDELAYE3_inst4 : IDELAYE3
   generic map (
      CASCADE => "NONE",         -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",    -- Units of the DELAY_VALUE (COUNT, TIME)
      DELAY_SRC => "IDATAIN",    -- Delay input (DATAIN, IDATAIN)
      DELAY_TYPE => "VAR_LOAD",     -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,          -- Input delay value setting
      IS_CLK_INVERTED => '0',    -- Optional inversion for CLK
      IS_RST_INVERTED => '0',    -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq, -- IDELAYCTRL clock input frequency in MHz (200.0-2400.0)
      UPDATE_MODE => "ASYNC"     -- Determines when updates to the delay will take effect (ASYNC, MANUAL, SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to ODELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => idelay_data(4),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_data(4),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

IDELAYE3_inst5 : IDELAYE3
   generic map (
      CASCADE => "NONE",         -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",    -- Units of the DELAY_VALUE (COUNT, TIME)
      DELAY_SRC => "IDATAIN",    -- Delay input (DATAIN, IDATAIN)
      DELAY_TYPE => "VAR_LOAD",     -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,          -- Input delay value setting
      IS_CLK_INVERTED => '0',    -- Optional inversion for CLK
      IS_RST_INVERTED => '0',    -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq, -- IDELAYCTRL clock input frequency in MHz (200.0-2400.0)
      UPDATE_MODE => "ASYNC"     -- Determines when updates to the delay will take effect (ASYNC, MANUAL, SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to ODELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => idelay_data(5),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_data(5),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

IDELAYE3_inst6 : IDELAYE3
   generic map (
      CASCADE => "NONE",         -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",    -- Units of the DELAY_VALUE (COUNT, TIME)
      DELAY_SRC => "IDATAIN",    -- Delay input (DATAIN, IDATAIN)
      DELAY_TYPE => "VAR_LOAD",     -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,          -- Input delay value setting
      IS_CLK_INVERTED => '0',    -- Optional inversion for CLK
      IS_RST_INVERTED => '0',    -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq, -- IDELAYCTRL clock input frequency in MHz (200.0-2400.0)
      UPDATE_MODE => "ASYNC"     -- Determines when updates to the delay will take effect (ASYNC, MANUAL, SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to ODELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => idelay_data(6),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_data(6),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

IDELAYE3_inst7 : IDELAYE3
   generic map (
      CASCADE => "NONE",         -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "TIME",    -- Units of the DELAY_VALUE (COUNT, TIME)
      DELAY_SRC => "IDATAIN",    -- Delay input (DATAIN, IDATAIN)
      DELAY_TYPE => "VAR_LOAD",     -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,          -- Input delay value setting
      IS_CLK_INVERTED => '0',    -- Optional inversion for CLK
      IS_RST_INVERTED => '0',    -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq, -- IDELAYCTRL clock input frequency in MHz (200.0-2400.0)
      UPDATE_MODE => "ASYNC"     -- Determines when updates to the delay will take effect (ASYNC, MANUAL, SYNC)
   )
   port map (
      CASC_OUT => open,       -- 1-bit output: Cascade delay output to ODELAY input cascade
      CNTVALUEOUT => open, -- 9-bit output: Counter value output
      DATAOUT => idelay_data(7),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_data(7),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
IDELAYE3_inst8 : IDELAYE3
generic map (
   CASCADE => "NONE",         -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
   DELAY_FORMAT => "TIME",    -- Units of the DELAY_VALUE (COUNT, TIME)
   DELAY_SRC => "IDATAIN",    -- Delay input (DATAIN, IDATAIN)
   DELAY_TYPE => "VAR_LOAD",     -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
   DELAY_VALUE => 0,          -- Input delay value setting
   IS_CLK_INVERTED => '0',    -- Optional inversion for CLK
   IS_RST_INVERTED => '0',    -- Optional inversion for RST
   REFCLK_FREQUENCY => refclk_freq, -- IDELAYCTRL clock input frequency in MHz (200.0-2400.0)
   UPDATE_MODE => "ASYNC"     -- Determines when updates to the delay will take effect (ASYNC, MANUAL, SYNC)
)
port map (
   CASC_OUT => open,       -- 1-bit output: Cascade delay output to ODELAY input cascade
   CNTVALUEOUT => open, -- 9-bit output: Counter value output
   DATAOUT => idelay_data(8),         -- 1-bit output: Delayed data output
   CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
   CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
   CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
   CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
   CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
   DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
   EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
   IDATAIN => ibuf_data(8),         -- 1-bit input: Data input from the logic
   INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
   LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
   RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
);   

IDELAYE3_inst9 : IDELAYE3
generic map (
   CASCADE => "NONE",         -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
   DELAY_FORMAT => "TIME",    -- Units of the DELAY_VALUE (COUNT, TIME)
   DELAY_SRC => "IDATAIN",    -- Delay input (DATAIN, IDATAIN)
   DELAY_TYPE => "VAR_LOAD",     -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
   DELAY_VALUE => 0,          -- Input delay value setting
   IS_CLK_INVERTED => '0',    -- Optional inversion for CLK
   IS_RST_INVERTED => '0',    -- Optional inversion for RST
   REFCLK_FREQUENCY => refclk_freq, -- IDELAYCTRL clock input frequency in MHz (200.0-2400.0)
   UPDATE_MODE => "ASYNC"     -- Determines when updates to the delay will take effect (ASYNC, MANUAL, SYNC)
)
port map (
   CASC_OUT => open,       -- 1-bit output: Cascade delay output to ODELAY input cascade
   CNTVALUEOUT => open, -- 9-bit output: Counter value output
   DATAOUT => idelay_data(9),         -- 1-bit output: Delayed data output
   CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
   CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
   CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
   CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
   CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
   DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
   EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
   IDATAIN => ibuf_data(9),         -- 1-bit input: Data input from the logic
   INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
   LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
   RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
);

IDELAYE3_inst10 : IDELAYE3
generic map (
   CASCADE => "NONE",         -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
   DELAY_FORMAT => "TIME",    -- Units of the DELAY_VALUE (COUNT, TIME)
   DELAY_SRC => "IDATAIN",    -- Delay input (DATAIN, IDATAIN)
   DELAY_TYPE => "VAR_LOAD",     -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
   DELAY_VALUE => 0,          -- Input delay value setting
   IS_CLK_INVERTED => '0',    -- Optional inversion for CLK
   IS_RST_INVERTED => '0',    -- Optional inversion for RST
   REFCLK_FREQUENCY => refclk_freq, -- IDELAYCTRL clock input frequency in MHz (200.0-2400.0)
   UPDATE_MODE => "ASYNC"     -- Determines when updates to the delay will take effect (ASYNC, MANUAL, SYNC)
)
port map (
   CASC_OUT => open,       -- 1-bit output: Cascade delay output to ODELAY input cascade
   CNTVALUEOUT => open, -- 9-bit output: Counter value output
   DATAOUT => idelay_data(10),         -- 1-bit output: Delayed data output
   CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
   CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
   CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
   CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
   CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
   DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
   EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
   IDATAIN => ibuf_data(10),         -- 1-bit input: Data input from the logic
   INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
   LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
   RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
);

IDELAYE3_inst11 : IDELAYE3
generic map (
   CASCADE => "NONE",         -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
   DELAY_FORMAT => "TIME",    -- Units of the DELAY_VALUE (COUNT, TIME)
   DELAY_SRC => "IDATAIN",    -- Delay input (DATAIN, IDATAIN)
   DELAY_TYPE => "VAR_LOAD",     -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
   DELAY_VALUE => 0,          -- Input delay value setting
   IS_CLK_INVERTED => '0',    -- Optional inversion for CLK
   IS_RST_INVERTED => '0',    -- Optional inversion for RST
   REFCLK_FREQUENCY => refclk_freq, -- IDELAYCTRL clock input frequency in MHz (200.0-2400.0)
   UPDATE_MODE => "ASYNC"     -- Determines when updates to the delay will take effect (ASYNC, MANUAL, SYNC)
)
port map (
   CASC_OUT => open,       -- 1-bit output: Cascade delay output to ODELAY input cascade
   CNTVALUEOUT => open, -- 9-bit output: Counter value output
   DATAOUT => idelay_data(11),         -- 1-bit output: Delayed data output
   CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
   CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
   CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
   CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
   CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
   DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
   EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
   IDATAIN => ibuf_data(11),         -- 1-bit input: Data input from the logic
   INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
   LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
   RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
);
   
IDELAYE3_inst12 : IDELAYE3
generic map (
   CASCADE => "NONE",         -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
   DELAY_FORMAT => "TIME",    -- Units of the DELAY_VALUE (COUNT, TIME)
   DELAY_SRC => "IDATAIN",    -- Delay input (DATAIN, IDATAIN)
   DELAY_TYPE => "VAR_LOAD",     -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
   DELAY_VALUE => 0,          -- Input delay value setting
   IS_CLK_INVERTED => '0',    -- Optional inversion for CLK
   IS_RST_INVERTED => '0',    -- Optional inversion for RST
   REFCLK_FREQUENCY => refclk_freq, -- IDELAYCTRL clock input frequency in MHz (200.0-2400.0)
   UPDATE_MODE => "ASYNC"     -- Determines when updates to the delay will take effect (ASYNC, MANUAL, SYNC)
)
port map (
   CASC_OUT => open,       -- 1-bit output: Cascade delay output to ODELAY input cascade
   CNTVALUEOUT => open, -- 9-bit output: Counter value output
   DATAOUT => idelay_data(12),         -- 1-bit output: Delayed data output
   CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
   CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
   CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
   CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
   CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
   DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
   EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
   IDATAIN => ibuf_data(12),         -- 1-bit input: Data input from the logic
   INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
   LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
   RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
);   
      
IDELAYE3_inst13 : IDELAYE3
generic map (
   CASCADE => "NONE",         -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
   DELAY_FORMAT => "TIME",    -- Units of the DELAY_VALUE (COUNT, TIME)
   DELAY_SRC => "IDATAIN",    -- Delay input (DATAIN, IDATAIN)
   DELAY_TYPE => "VAR_LOAD",     -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
   DELAY_VALUE => 0,          -- Input delay value setting
   IS_CLK_INVERTED => '0',    -- Optional inversion for CLK
   IS_RST_INVERTED => '0',    -- Optional inversion for RST
   REFCLK_FREQUENCY => refclk_freq, -- IDELAYCTRL clock input frequency in MHz (200.0-2400.0)
   UPDATE_MODE => "ASYNC"     -- Determines when updates to the delay will take effect (ASYNC, MANUAL, SYNC)
)
port map (
   CASC_OUT => open,       -- 1-bit output: Cascade delay output to ODELAY input cascade
   CNTVALUEOUT => open, -- 9-bit output: Counter value output
   DATAOUT => idelay_data(13),         -- 1-bit output: Delayed data output
   CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
   CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
   CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
   CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
   CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
   DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
   EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
   IDATAIN => ibuf_data(13),         -- 1-bit input: Data input from the logic
   INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
   LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
   RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
);      

ovr_IDELAYE3_inst : IDELAYE3
generic map (
   CASCADE => "NONE",         -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
   DELAY_FORMAT => "TIME",    -- Units of the DELAY_VALUE (COUNT, TIME)
   DELAY_SRC => "IDATAIN",    -- Delay input (DATAIN, IDATAIN)
   DELAY_TYPE => "VAR_LOAD",     -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
   DELAY_VALUE => 0,          -- Input delay value setting
   IS_CLK_INVERTED => '0',    -- Optional inversion for CLK
   IS_RST_INVERTED => '0',    -- Optional inversion for RST
   REFCLK_FREQUENCY => refclk_freq, -- IDELAYCTRL clock input frequency in MHz (200.0-2400.0)
   UPDATE_MODE => "ASYNC"     -- Determines when updates to the delay will take effect (ASYNC, MANUAL, SYNC)
)
port map (
   CASC_OUT => open,       -- 1-bit output: Cascade delay output to ODELAY input cascade
   CNTVALUEOUT => open, -- 9-bit output: Counter value output
   DATAOUT => idelay_ovr,         -- 1-bit output: Delayed data output
   CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
   CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
   CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
   CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
   CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
   DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
   EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
   IDATAIN => ibuf_ovr,         -- 1-bit input: Data input from the logic
   INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
   LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
   RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
);   
-------------------------------------------------------------------------------
-- Input Pin Registers
-------------------------------------------------------------------------------

sample_clk_n <= not sample_clk ;

gen_iddr16: for i in 0 to 13 generate
     
IDDR16_inst : IDDRE1 
generic map (
   DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
   IS_C_INVERTED => '0'   -- Optional inversion for C
   )
port map (
   Q1    => q1_data(i),
   Q2    => q2_data(i),
   C     => sample_clk,
   CB    => sample_clk_n,
   D     => idelay_data(i),
   R     => '0'
);
      
end generate gen_iddr16;

ovr_IDDR16_inst : IDDRE1 
generic map (
   DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
   IS_C_INVERTED => '0'   -- Optional inversion for C
   )
port map (
   Q1    => q1_ovr,
   Q2    => q2_ovr,
   C     => sample_clk,
   CB    => sample_clk_n,
   D     => idelay_ovr,
   R     => '0'
);

-------------------------------------------------------------------------------
-- Interleave the data bits in the correct order
-------------------------------------------------------------------------------

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      t1_q1_data     <= q1_data;
      t1_q2_data     <= q2_data;
      t1_intrlv_data <= (twoscomp xor t1_q2_data(13))  & t1_q2_data(12 downto 0) &
                        (twoscomp xor t1_q1_data(13))  & t1_q1_data(12 downto 0);
      t1_ovr          <= q1_ovr or q2_ovr;
   end if;
end process;

-------------------------------------------------------------------------------
-- Gain and Offset Trim
-------------------------------------------------------------------------------

-- GAIN: 16-bit unsigned number 
-- Bit 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0
--     5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
--     1.0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

-- OFFSET: 16-bit signed two's complement number
-- Bit 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0
--     5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
--     S
-- Range -32768 to +32767

-- DATA_OUT = Symetric Round((DATA_IN + OFFSET)* GAIN)

-- Latency = 4 clock cycles.

a0_data_in <= t1_intrlv_data(13 downto 0)  & "00";
a1_data_in <= t1_intrlv_data(27 downto 14) & "00";
b_data_in  <= '0' & gain;
d_data_in  <= offset; 

gainoffset0_inst : px_ads5463intrfc_gainoffset
port map (
    clk => sample_clk,
    a   => a0_data_in,
    b   => b_data_in,
    d   => d_data_in,
    p   => t5_data0_go
  );
  
gainoffset1_inst : px_ads5463intrfc_gainoffset
  port map (
      clk => sample_clk,
      a   => a1_data_in,
      b   => b_data_in,
      d   => d_data_in,
      p   => t5_data1_go
    );  
   
-------------------------------------------------------------------------------
-- Saturation to a 16-bit signed value
-------------------------------------------------------------------------------

process(sample_clk)
begin
   if rising_edge(sample_clk) then
     if (t5_data0_go(17 downto 15) = "000") or (t5_data0_go(17 downto 15) = "111") then
        t6_sat0_data <= t5_data0_go(15 downto 0);
     elsif t5_data0_go(17) = '1' then
        t6_sat0_data <= x"8000";
     else
        t6_sat0_data <= x"7FFF";
     end if;
     if (t5_data1_go(17 downto 15) = "000") or (t5_data1_go(17 downto 15) = "111") then
        t6_sat1_data <= t5_data1_go(15 downto 0);
     elsif t5_data1_go(17) = '1' then
        t6_sat1_data <= x"8000";
     else
        t6_sat1_data <= x"7FFF";
     end if;
   end if;
end process;

-------------------------------------------------------------------------------
-- Varaiable Data Delay
-------------------------------------------------------------------------------

process(sample_clk)
begin
   if rising_edge(sample_clk) then
        t7_sat0_data <= t6_sat0_data;
        t8_sat0_data <= t7_sat0_data;
        t9_sat0_data <= t8_sat0_data; 
        t7_sat1_data <= t6_sat1_data;
        t8_sat1_data <= t7_sat1_data;
        t9_sat1_data <= t8_sat1_data; 
        case int_delay is
            when "00" =>
              m_axis_dataio_tdata <= t6_sat1_data & t6_sat0_data; 
            when "01" =>
              m_axis_dataio_tdata <= t7_sat1_data & t7_sat0_data; 
            when "10" =>
              m_axis_dataio_tdata <= t8_sat1_data & t8_sat0_data; 
            when "11" =>
              m_axis_dataio_tdata <= t9_sat1_data & t9_sat0_data; 
            when others =>
              m_axis_dataio_tdata <= t9_sat1_data & t9_sat0_data; 
        end case;     
    end if;
end process;

m_axis_dataio_tvalid <= '1'; 
    
-------------------------------------------------------------------------------
-- Overload Detection
-------------------------------------------------------------------------------

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      if t6_sat0_data(15) = '0' then -- positive input
        go_ovld0_sub <= ('0' & ovld_thresh_p) - ('0' & t6_sat0_data);
      else -- negative input
        go_ovld0_sub <= ('0' & t6_sat0_data) - ('0' & ovld_thresh_n);
      end if;  
      if t6_sat1_data(15) = '0' then -- positive input
        go_ovld1_sub <= ('0' & ovld_thresh_p) - ('0' & t6_sat1_data);
      else -- negative input
        go_ovld1_sub <= ('0' & t6_sat1_data) - ('0' & ovld_thresh_n);
      end if;  
      go_overload  <= go_ovld0_sub(16) or go_ovld1_sub(16);   
      adc_overload <= t1_ovr;    -- raw data saturation
   end if;     
end process;

--------------------------------------------------------------------------------
-- LED Drive
--------------------------------------------------------------------------------

led_lite <= adc_overload when (led_sel = "00") else
            go_overload  when (led_sel = "01") else
            ext_led_src  when (led_sel = "10") else '0';

-- Pulse Stretcher keeps LED lit longer than overload so it is more visible.
process(sample_clk)
begin
   if rising_edge(sample_clk) then
      if led_lite = '1' then
         pls_strch_cntr    <= conv_std_logic_vector(led_pulse_stretch, 16);
      elsif pls_strch_cntr /= 0 then
         pls_strch_cntr    <= pls_strch_cntr - 1;
      end if;
    end if;
end process;

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      adc_ovrld     <= adc_overload;
      go_trim_ovrld <= go_overload;
      if (pls_strch_cntr = 0) or (led_sel = "11") then
         ovld_led_n <= '1'; -- Overload LED Drive (active low)
      else
         ovld_led_n <= '0';
      end if;
    end if;
end process;

--------------------------------------------------------------------------------
-- Control/Status Registers
--------------------------------------------------------------------------------
csr_inst: px_ads5463intrfc_csr
generic map(
    initial_tap_delay   => initial_tap_delay,  
    initial_gain        => cnst_initial_gain,       
    initial_offset      => cnst_initial_offset,     
    initial_2scomp      => initial_2scomp,     
    initial_led_select  => initial_led_select,
    initial_ovld_thresh => initial_ovld_thresh,
    initial_pdwnf       => initial_pdwnf
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
--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------    
    tap_delay               => tap_delay,
    int_delay               => int_delayx, 
    twoscomp                => twoscompx,   
    gain                    => gainx,                 
    offset                  => offsetx, 
    ovld_thresh_cnt         => ovld_thresh_cntx,                
    led_sel                 => led_selx,
    pdwnf                   => pdwnf, -- power down
    dly_ld_ctl              => dly_ld_ctl, 
 -------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------
    adc_overload            => adc_overloadx,
    go_overload             => go_overloadx
);

--------------------------------------------------------------------------------
-- Clock Domain Crossing for Control Signals
--------------------------------------------------------------------------------
ctl_x <= twoscompx & led_selx & int_delayx & ovld_thresh_cntx & offsetx & gainx;

ctl_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 3, -- integer; range: 2-10
  WIDTH          => 53  -- integer; range: 1-1024
)
port map (
  src_clk    => s_axi_csr_aclk,
  src_in     => ctl_x,
  src_send   => src_senda,
  src_rcv    => src_rcva,
  dest_clk   => sample_clk,
  dest_req   => dest_reqa,
  dest_ack   => dest_reqa, 
  dest_out   => ctl
);

gain            <= ctl(15 downto 0);
offset          <= ctl(31 downto 16);
ovld_thresh_cnt <= ctl(47 downto 32);
int_delay       <= ctl(49 downto 48);
led_sel         <= ctl(51 downto 50);
twoscomp        <= ctl(52);

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     if (src_rcva = '1') then
       src_senda <= '0';
     elsif (src_rcva = '0') and (src_senda = '0') then
       src_senda <= '1';
     end if;  
   end if;
end process;   

--------------------------------------------------------------------------------
-- Clock Domain Crossing for Interrupt Status Signals
--------------------------------------------------------------------------------
stat1_xclk: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 3, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => sample_clk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => adc_overload,
     dest_clk => s_axi_csr_aclk,
     dest_out => adc_overloadx
  );
  
stat2_xclk: xpm_cdc_single
    generic map (
       DEST_SYNC_FF   => 3, -- integer; range: 2-10
       SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
       SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
    )
    port map (
       src_clk  => sample_clk,  -- optional; required when SRC_INPUT_REG = 1
       src_in   => go_overload,
       dest_clk => s_axi_csr_aclk,
       dest_out => go_overloadx
    );


end Behavioral;
