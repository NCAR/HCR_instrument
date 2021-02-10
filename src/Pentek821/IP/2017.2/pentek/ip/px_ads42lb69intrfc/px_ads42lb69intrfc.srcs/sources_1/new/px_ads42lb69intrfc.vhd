----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/12/2016 04:18:48 PM
-- Design Name: 
-- Module Name: px_ads42lb69intrfc - Behavioral
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
-- 0x08 - Ch A Offset/Gain Trim 
-- 0x0C - Ch B Offset/Gain Trim 
-- 0x10 - ADC Serial Control
-- 0x14 - ADC Serial Status
-- 0x18 - Reserved
-- 0x1C - Reserved
-- 0x20 - Reserved
-- 0x24 - Interrupt Enables
-- 0x28 - Interrupt Status
-- 0x2C - Interrupt Flags
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
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity px_ads42lb69intrfc is
generic (
   iodelay_grp_a01      : string := "IODELAY_GRP";
   iodelay_grp_a23      : string := "IODELAY_GRP";
   iodelay_grp_a45      : string := "IODELAY_GRP";
   iodelay_grp_a67      : string := "IODELAY_GRP";
   iodelay_grp_a89      : string := "IODELAY_GRP";
   iodelay_grp_a1011    : string := "IODELAY_GRP";
   iodelay_grp_a1213    : string := "IODELAY_GRP";
   iodelay_grp_a1415    : string := "IODELAY_GRP";
   iodelay_grp_b01      : string := "IODELAY_GRP";
   iodelay_grp_b23      : string := "IODELAY_GRP";
   iodelay_grp_b45      : string := "IODELAY_GRP";
   iodelay_grp_b67      : string := "IODELAY_GRP";
   iodelay_grp_b89      : string := "IODELAY_GRP";
   iodelay_grp_b1011    : string := "IODELAY_GRP";
   iodelay_grp_b1213    : string := "IODELAY_GRP";
   iodelay_grp_b1415    : string := "IODELAY_GRP";
   initial_tap_delay    : integer := 0;
   initial_a_gain_percent: integer := 100;
   initial_a_offset_counts : integer := 0;
   initial_b_gain_percent: integer := 100;
   initial_b_offset_counts : integer := 0;
   initial_pdwnf_a       : boolean := false;
   initial_pdwnf_b       : boolean := false;
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
----------------------------------------------------------------------------
-- ADS42LB69 ADC Input
----------------------------------------------------------------------------
-- (LVDS)
   da0_p                   : in  std_logic; -- adc data p
   da0_n                   : in  std_logic; -- adc data n
   da2_p                   : in  std_logic; -- adc data p
   da2_n                   : in  std_logic; -- adc data n
   da4_p                   : in  std_logic; -- adc data p
   da4_n                   : in  std_logic; -- adc data n
   da6_p                   : in  std_logic; -- adc data p
   da6_n                   : in  std_logic; -- adc data n
   da8_p                   : in  std_logic; -- adc data p
   da8_n                   : in  std_logic; -- adc data n
   da10_p                  : in  std_logic; -- adc data p
   da10_n                  : in  std_logic; -- adc data n
   da12_p                  : in  std_logic; -- adc data p
   da12_n                  : in  std_logic; -- adc data n
   da14_p                  : in  std_logic; -- adc data p
   da14_n                  : in  std_logic; -- adc data n
   db0_p                   : in  std_logic; -- adc data p
   db0_n                   : in  std_logic; -- adc data n
   db2_p                   : in  std_logic; -- adc data p
   db2_n                   : in  std_logic; -- adc data n
   db4_p                   : in  std_logic; -- adc data p
   db4_n                   : in  std_logic; -- adc data n
   db6_p                   : in  std_logic; -- adc data p
   db6_n                   : in  std_logic; -- adc data n
   db8_p                   : in  std_logic; -- adc data p
   db8_n                   : in  std_logic; -- adc data n
   db10_p                  : in  std_logic; -- adc data p
   db10_n                  : in  std_logic; -- adc data n
   db12_p                  : in  std_logic; -- adc data p
   db12_n                  : in  std_logic; -- adc data n
   db14_p                  : in  std_logic; -- adc data p
   db14_n                  : in  std_logic; -- adc data n
   sample_clk              : in  std_logic; -- Sample Clock input
---------------------------------------------------------------------------- 
-- Control Outputs
----------------------------------------------------------------------------
   a_power_down             : out std_logic; --ADC A Power Down Control
   b_power_down             : out std_logic; --ADC B Power Down Control
   spi_miso                 : in  std_logic; --ADC SPI Bus SDOUT
   spi_sclk                 : out std_logic; --ADC SPI Bus SCLK
   spi_mosi                 : out std_logic; --ADC SPI Bus SDATA
   spi_sen                  : out std_logic; --ADC SPI Bus SEN
   
   adc_reset                : out std_logic; --ADC Reset  
   ovld_led_n               : out std_logic; -- overload LED drive
   clk_configured           : out std_logic; -- Clock output of ADC has been configured 
   ext_led_src              : in  std_logic; -- optional ext. LED source in   
----------------------------------------------------------------------------
-- Status Outputs
----------------------------------------------------------------------------
   adc_ovrld_a                : out std_logic;
   adc_ovrld_b                : out std_logic;
   go_trim_ovrld_a            : out std_logic;
   go_trim_ovrld_b            : out std_logic;
----------------------------------------------------------------------------
-- Output
----------------------------------------------------------------------------
   m_axis_cha_pd_tdata      : out std_logic_vector(15 downto 0); --CH A
   m_axis_cha_pd_tvalid     : out std_logic;
   m_axis_chb_pd_tdata      : out std_logic_vector(15 downto 0); --CH B
   m_axis_chb_pd_tvalid     : out std_logic

);

end px_ads42lb69intrfc;

architecture Behavioral of px_ads42lb69intrfc is

-------------------------------------------------------------------------------
-- Components
-------------------------------------------------------------------------------
-- B*(A+D) Rounded symetrically
-- B17 should be '0' to have a 16 bit unsigned multiplication factor
-- Latency = 4

component px_ads42lb69intrfc_gainoffset
port (
    clk : in std_logic;
    a : in std_logic_vector(15 downto 0);
    b : in std_logic_vector(16 downto 0);
    d : in std_logic_vector(15 downto 0);
    p : out std_logic_vector(17 downto 0)
  );
end component;

   
-- Control/Status Registers
component px_ads42lb69intrfc_csr
generic(
    initial_tap_delay   : integer := 0;
    initial_gain_a      : std_logic_vector(15 downto 0) := x"8000";  
    initial_offset_a    : std_logic_vector(15 downto 0) := x"0000";
    initial_gain_b      : std_logic_vector(15 downto 0) := x"8000";  
    initial_offset_b    : std_logic_vector(15 downto 0) := x"0000";  
    initial_pdwnf_a       : boolean := false; 
    initial_pdwnf_b       : boolean := false; 
    initial_led_select  : integer range 0 to 3 := 0;
    initial_ovld_thresh : integer := 16
);
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    s_axi_csr_aclk         : in  std_logic;
    s_axi_csr_aresetn      : in  std_logic;
    s_axi_csr_awaddr       : in  std_logic_vector(6 downto 0); 
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
    s_axi_csr_araddr       : in  std_logic_vector(6 downto 0);  
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
    gain_a                : out std_logic_vector(15 downto 0); 
    offset_a              : out std_logic_vector(15 downto 0);
    gain_b                : out std_logic_vector(15 downto 0); 
    offset_b              : out std_logic_vector(15 downto 0);
    ovld_thresh_cnt       : out std_logic_vector(15 downto 0);            
    led_sel               : out std_logic_vector(1 downto 0);
    pdwnf_a               : out std_logic;    
    pdwnf_b               : out std_logic;    
    adc_reset             : out std_logic;
    dly_ld_ctl            : out std_logic;
    clk_configured        : out std_logic;
    -- Serial Control Interface
    ser_wr_data           : out std_logic_vector(7 downto 0); 
    ser_addr              : out std_logic_vector(5 downto 0);  
    ser_wr_pls            : out std_logic;  
    ser_rd_pls            : out std_logic;  
    ser_rd_data           : in  std_logic_vector(7 downto 0);
    -- Status
    ser_sm_rdy            : in  std_logic;
-------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------
    adc_overload_a        : in  std_logic;
    adc_overload_b        : in  std_logic;
    go_overload_a         : in  std_logic;
    go_overload_b         : in  std_logic
);
end component;

component ads42lb69_serial_com
port (
   clk       : in  std_logic; 
   rst_n     : in  std_logic;
   data_in   : in  std_logic_vector(7 downto 0);
   addr      : in  std_logic_vector(5 downto 0);
   wr_pls    : in  std_logic;
   rd_pls    : in  std_logic;
   data_out  : out std_logic_vector(7 downto 0);
   sm_rdy    : out std_logic;
   -- adc serial signals
   adc_sdi   : out std_logic;
   adc_sdenb : out std_logic;
   adc_sclk  : out std_logic;
   adc_sdo   : in  std_logic
);
end component; 

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------

constant cnst_initial_gain_a  : std_logic_vector(15 downto 0) := conv_std_logic_vector(integer((real(initial_a_gain_percent)/100.0) * 32768.0), 16);
constant cnst_initial_offset_a: std_logic_vector(15 downto 0) := conv_std_logic_vector(initial_a_offset_counts, 16);
constant cnst_initial_gain_b  : std_logic_vector(15 downto 0) := conv_std_logic_vector(integer((real(initial_b_gain_percent)/100.0) * 32768.0), 16);
constant cnst_initial_offset_b: std_logic_vector(15 downto 0) := conv_std_logic_vector(initial_b_offset_counts, 16);
constant refclk_freq : real := real(idelaycntrl_refclk_freq);

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of sample_clk: SIGNAL is "xilinx.com:signal:clock:1.0 sample_clk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of sample_clk: SIGNAL is "ASSOCIATED_BUSIF m_axis_cha_pd:m_axis_chb_pd";
ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

-- Assign the IODELAY components to the IODELAY CONTROL group.
attribute IODELAY_GROUP: string;
attribute IODELAY_GROUP of IDELAYE3_inst_a0: label is iodelay_grp_a01;
attribute IODELAY_GROUP of IDELAYE3_inst_a1: label is iodelay_grp_a23;
attribute IODELAY_GROUP of IDELAYE3_inst_a2: label is iodelay_grp_a45;
attribute IODELAY_GROUP of IDELAYE3_inst_a3: label is iodelay_grp_a67;
attribute IODELAY_GROUP of IDELAYE3_inst_a4: label is iodelay_grp_a89;
attribute IODELAY_GROUP of IDELAYE3_inst_a5: label is iodelay_grp_a1011;
attribute IODELAY_GROUP of IDELAYE3_inst_a6: label is iodelay_grp_a1213;
attribute IODELAY_GROUP of IDELAYE3_inst_a7: label is iodelay_grp_a1415;
attribute IODELAY_GROUP of IDELAYE3_inst_b0: label is iodelay_grp_b01;
attribute IODELAY_GROUP of IDELAYE3_inst_b1: label is iodelay_grp_b23;
attribute IODELAY_GROUP of IDELAYE3_inst_b2: label is iodelay_grp_b45;
attribute IODELAY_GROUP of IDELAYE3_inst_b3: label is iodelay_grp_b67;
attribute IODELAY_GROUP of IDELAYE3_inst_b4: label is iodelay_grp_b89;
attribute IODELAY_GROUP of IDELAYE3_inst_b5: label is iodelay_grp_b1011;
attribute IODELAY_GROUP of IDELAYE3_inst_b6: label is iodelay_grp_b1213;
attribute IODELAY_GROUP of IDELAYE3_inst_b7: label is iodelay_grp_b1415;

attribute DIFF_TERM_ADV: string; 
attribute DIFF_TERM_ADV of da0_p   : signal is differential_term;
attribute DIFF_TERM_ADV of da0_n   : signal is differential_term;
attribute DIFF_TERM_ADV of da2_p   : signal is differential_term;
attribute DIFF_TERM_ADV of da2_n   : signal is differential_term;
attribute DIFF_TERM_ADV of da4_p   : signal is differential_term;
attribute DIFF_TERM_ADV of da4_n   : signal is differential_term;
attribute DIFF_TERM_ADV of da6_p   : signal is differential_term;
attribute DIFF_TERM_ADV of da6_n   : signal is differential_term;
attribute DIFF_TERM_ADV of da8_p   : signal is differential_term;
attribute DIFF_TERM_ADV of da8_n   : signal is differential_term;
attribute DIFF_TERM_ADV of da10_p : signal is differential_term;
attribute DIFF_TERM_ADV of da10_n : signal is differential_term;
attribute DIFF_TERM_ADV of da12_p : signal is differential_term;
attribute DIFF_TERM_ADV of da12_n : signal is differential_term;
attribute DIFF_TERM_ADV of da14_p : signal is differential_term;
attribute DIFF_TERM_ADV of da14_n : signal is differential_term;
attribute DIFF_TERM_ADV of db0_p   : signal is differential_term;
attribute DIFF_TERM_ADV of db0_n   : signal is differential_term;
attribute DIFF_TERM_ADV of db2_p   : signal is differential_term;
attribute DIFF_TERM_ADV of db2_n   : signal is differential_term;
attribute DIFF_TERM_ADV of db4_p   : signal is differential_term;
attribute DIFF_TERM_ADV of db4_n   : signal is differential_term;
attribute DIFF_TERM_ADV of db6_p   : signal is differential_term;
attribute DIFF_TERM_ADV of db6_n   : signal is differential_term;
attribute DIFF_TERM_ADV of db8_p   : signal is differential_term;
attribute DIFF_TERM_ADV of db8_n   : signal is differential_term;
attribute DIFF_TERM_ADV of db10_p : signal is differential_term;
attribute DIFF_TERM_ADV of db10_n : signal is differential_term;
attribute DIFF_TERM_ADV of db12_p : signal is differential_term;
attribute DIFF_TERM_ADV of db12_n : signal is differential_term;
attribute DIFF_TERM_ADV of db14_p : signal is differential_term;
attribute DIFF_TERM_ADV of db14_n : signal is differential_term;

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal ibuf_data_a      : std_logic_vector(7 downto 0) := (others => '0');
signal ibuf_data_b      : std_logic_vector(7 downto 0) := (others => '0');
signal idelay_data_a    : std_logic_vector(7 downto 0) := (others => '0');
signal idelay_data_b    : std_logic_vector(7 downto 0) := (others => '0');
signal t1_intrlv_data_a : std_logic_vector(15 downto 0) := (others => '0');
signal t1_intrlv_data_b : std_logic_vector(15 downto 0) := (others => '0');
signal q1_data_a        : std_logic_vector(7 downto 0) := (others => '0');
signal q1_data_b        : std_logic_vector(7 downto 0) := (others => '0');
signal q2_data_a        : std_logic_vector(7 downto 0) := (others => '0');
signal q2_data_b        : std_logic_vector(7 downto 0) := (others => '0');
signal t1_q1_data_a     : std_logic_vector(7 downto 0) := (others => '0');
signal t1_q1_data_b     : std_logic_vector(7 downto 0) := (others => '0');
signal t1_q2_data_a     : std_logic_vector(7 downto 0) := (others => '0');
signal t1_q2_data_b     : std_logic_vector(7 downto 0) := (others => '0');
signal ld_cntr          : std_logic_vector(5 downto 0) := "000000";
signal dly_ld           : std_logic := '0';
signal tap_delay        : std_logic_vector(8 downto 0) := (others => '0');
signal int_delay        : std_logic_vector(1 downto 0) := (others => '0');
signal sample_clk_n     : std_logic := '0';
signal data_in_a        : std_logic_vector(15 downto 0) := (others => '0');
signal data_in_b        : std_logic_vector(15 downto 0) := (others => '0');
signal b_data_in_a      : std_logic_vector(16 downto 0) := (others => '0');
signal b_data_in_b      : std_logic_vector(16 downto 0) := (others => '0');
signal d_data_in_a      : std_logic_vector(15 downto 0) := (others => '0');
signal d_data_in_b      : std_logic_vector(15 downto 0) := (others => '0');
signal t5_data_go_a     : std_logic_vector(17 downto 0) := (others => '0');
signal t5_data_go_b     : std_logic_vector(17 downto 0) := (others => '0');
signal t6_sat_data_a    : std_logic_vector(15 downto 0) := (others => '0');
signal t6_sat_data_b    : std_logic_vector(15 downto 0) := (others => '0');
signal t7_sat_data_a    : std_logic_vector(15 downto 0) := (others => '0');
signal t7_sat_data_b    : std_logic_vector(15 downto 0) := (others => '0');
signal t8_sat_data_a    : std_logic_vector(15 downto 0) := (others => '0');
signal t8_sat_data_b    : std_logic_vector(15 downto 0) := (others => '0');
signal t9_sat_data_a    : std_logic_vector(15 downto 0) := (others => '0');
signal t9_sat_data_b    : std_logic_vector(15 downto 0) := (others => '0');
signal ovld_thresh_p    : std_logic_vector(15 downto 0) := (others => '0');
signal ovld_thresh_n    : std_logic_vector(15 downto 0) := (others => '0');
signal ovld_sub_a       : std_logic_vector(16 downto 0) := (others => '0');
signal ovld_sub_b       : std_logic_vector(16 downto 0) := (others => '0');
signal go_ovld_sub_a    : std_logic_vector(16 downto 0) := (others => '0');
signal go_ovld_sub_b    : std_logic_vector(16 downto 0) := (others => '0');
signal adc_overload_a   : std_logic := '0';
signal adc_overload_b   : std_logic := '0';
signal go_overload_a    : std_logic := '0';
signal go_overload_b    : std_logic := '0';
signal adc_overload_ax   : std_logic := '0';
signal adc_overload_bx   : std_logic := '0';
signal go_overload_ax    : std_logic := '0';
signal go_overload_bx    : std_logic := '0';
signal led_lite         : std_logic := '0';
signal pls_strch_cntr   : std_logic_vector(15 downto 0) := (others => '0');
signal gain_a           : std_logic_vector(15 downto 0) := (others => '0');
signal gain_b           : std_logic_vector(15 downto 0) := (others => '0');
signal offset_a         : std_logic_vector(15 downto 0) := (others => '0');
signal offset_b         : std_logic_vector(15 downto 0) := (others => '0');
signal ovld_thresh_cnt  : std_logic_vector(15 downto 0) := (others => '0');
signal led_sel          : std_logic_vector(1 downto 0) := (others => '0'); 
signal en_vtc           : std_logic := '0';
signal ser_wr_data      : std_logic_vector(7 downto 0) := (others => '0'); 
signal ser_addr         : std_logic_vector(5 downto 0) := (others => '0');  
signal ser_wr_pls       : std_logic := '0';  
signal ser_rd_pls       : std_logic := '0';  
signal ser_rd_data      : std_logic_vector(7 downto 0) := (others => '0');
signal ser_sm_rdy       : std_logic := '0';
signal dly_ld_ctl_re    : std_logic := '0';
signal dly_ld_ctl       : std_logic := '0';
signal t1_dly_ld_ctl    : std_logic := '0';
signal gain_ax          : std_logic_vector(15 downto 0) := (others => '0');
signal gain_bx          : std_logic_vector(15 downto 0) := (others => '0');
signal offset_ax        : std_logic_vector(15 downto 0) := (others => '0');
signal offset_bx        : std_logic_vector(15 downto 0) := (others => '0');
signal ovld_thresh_cntx : std_logic_vector(15 downto 0) := (others => '0');
signal int_delayx       : std_logic_vector(1 downto 0) := (others => '0');
signal led_selx         : std_logic_vector(1 downto 0) := (others => '0');
signal ctl_x            : std_logic_vector(83 downto 0) := (others => '0');
signal ctl              : std_logic_vector(83 downto 0) := (others => '0');
signal src_rcva         : std_logic := '0';
signal src_senda        : std_logic := '0';
signal dest_reqa        : std_logic := '0';
signal t1_s_axi_csr_aresetn: std_logic := '0';

--------------------------------------------------------------------------------

begin


process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
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

data_IBUFDS_inst_a01 : IBUFDS
generic map (
   IBUF_LOW_PWR   => ibuf_low_pwr,
   IOSTANDARD     => "LVDS"
)
port map (
   I  => da0_p, 
   IB => da0_n, 
   O  => ibuf_data_a(0)
);

data_IBUFDS_inst_a23 : IBUFDS
generic map (
   IBUF_LOW_PWR   => ibuf_low_pwr,
   IOSTANDARD     => "LVDS"
)
port map (
   I  => da2_p, 
   IB => da2_n, 
   O  => ibuf_data_a(1)
);

data_IBUFDS_inst_a45 : IBUFDS
generic map ( 
   IBUF_LOW_PWR   => ibuf_low_pwr,
   IOSTANDARD     => "LVDS"
)
port map (
   I  => da4_p, 
   IB => da4_n, 
   O  => ibuf_data_a(2)
);

data_IBUFDS_inst_a67 : IBUFDS
generic map (
   IBUF_LOW_PWR   => ibuf_low_pwr,
   IOSTANDARD     => "LVDS"
)
port map (
   I  => da6_p, 
   IB => da6_n, 
   O  => ibuf_data_a(3)
);

data_IBUFDS_inst_a89 : IBUFDS
generic map (
   IBUF_LOW_PWR   => ibuf_low_pwr,
   IOSTANDARD     => "LVDS"
)
port map (
   I  => da8_p, 
   IB => da8_n, 
   O  => ibuf_data_a(4)
);

data_IBUFDS_inst_a1011 : IBUFDS
generic map (
   IBUF_LOW_PWR   => ibuf_low_pwr,
   IOSTANDARD     => "LVDS"
)
port map (
   I  => da10_p, 
   IB => da10_n, 
   O  => ibuf_data_a(5)
);

data_IBUFDS_inst_a1213 : IBUFDS
generic map (
   IBUF_LOW_PWR   => ibuf_low_pwr,
   IOSTANDARD     => "LVDS"
)
port map (
   I  => da12_p, 
   IB => da12_n, 
   O  => ibuf_data_a(6)
);

data_IBUFDS_inst_a1415 : IBUFDS
generic map (
   IBUF_LOW_PWR   => ibuf_low_pwr,
   IOSTANDARD     => "LVDS"
)
port map (
   I  => da14_p, 
   IB => da14_n, 
   O  => ibuf_data_a(7)
);

data_IBUFDS_inst_b01 : IBUFDS
generic map (
   IBUF_LOW_PWR   => ibuf_low_pwr,
   IOSTANDARD     => "LVDS"
)
port map (
   I  => db0_p, 
   IB => db0_n, 
   O  => ibuf_data_b(0)
);

data_IBUFDS_inst_b23 : IBUFDS
generic map (
   IBUF_LOW_PWR   => ibuf_low_pwr,
   IOSTANDARD     => "LVDS"
)
port map (
   I  => db2_p, 
   IB => db2_n, 
   O  => ibuf_data_b(1)
);

data_IBUFDS_inst_b45 : IBUFDS
generic map ( 
   IBUF_LOW_PWR   => ibuf_low_pwr,
   IOSTANDARD     => "LVDS"
)
port map (
   I  => db4_p, 
   IB => db4_n, 
   O  => ibuf_data_b(2)
);

data_IBUFDS_inst_b67 : IBUFDS
generic map (
   IBUF_LOW_PWR   => ibuf_low_pwr,
   IOSTANDARD     => "LVDS"
)
port map (
   I  => db6_p, 
   IB => db6_n, 
   O  => ibuf_data_b(3)
);

data_IBUFDS_inst_b89 : IBUFDS
generic map (
   IBUF_LOW_PWR   => ibuf_low_pwr,
   IOSTANDARD     => "LVDS"
)
port map (
   I  => db8_p, 
   IB => db8_n, 
   O  => ibuf_data_b(4)
);

data_IBUFDS_inst_b1011 : IBUFDS
generic map (
   IBUF_LOW_PWR   => ibuf_low_pwr,
   IOSTANDARD     => "LVDS"
)
port map (
   I  => db10_p, 
   IB => db10_n, 
   O  => ibuf_data_b(5)
);

data_IBUFDS_inst_b1213 : IBUFDS
generic map (
   IBUF_LOW_PWR   => ibuf_low_pwr,
   IOSTANDARD     => "LVDS"
)
port map (
   I  => db12_p, 
   IB => db12_n, 
   O  => ibuf_data_b(6)
);

data_IBUFDS_inst_b1415 : IBUFDS
generic map (
   IBUF_LOW_PWR   => ibuf_low_pwr,
   IOSTANDARD     => "LVDS"
)
port map (
   I  => db14_p, 
   IB => db14_n, 
   O  => ibuf_data_b(7)
);
--------------------------------------------------------------------------------
-- Tap Delays
--------------------------------------------------------------------------------

-- These tap delays are used to adjust the input setup/hold in relation to the clock
IDELAYE3_inst_a0 : IDELAYE3
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
      DATAOUT => idelay_data_a(0),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_data_a(0),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
IDELAYE3_inst_a1 : IDELAYE3
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
         DATAOUT => idelay_data_a(1),         -- 1-bit output: Delayed data output
         CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
         CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
         CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
         CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
         CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
         DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
         EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
         IDATAIN => ibuf_data_a(1),         -- 1-bit input: Data input from the logic
         INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
         LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
         RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
      );

IDELAYE3_inst_a2 : IDELAYE3
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
      DATAOUT => idelay_data_a(2),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_data_a(2),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

IDELAYE3_inst_a3 : IDELAYE3
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
      DATAOUT => idelay_data_a(3),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_data_a(3),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

IDELAYE3_inst_a4 : IDELAYE3
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
      DATAOUT => idelay_data_a(4),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_data_a(4),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

IDELAYE3_inst_a5 : IDELAYE3
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
      DATAOUT => idelay_data_a(5),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_data_a(5),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

IDELAYE3_inst_a6 : IDELAYE3
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
      DATAOUT => idelay_data_a(6),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_data_a(6),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );

IDELAYE3_inst_a7 : IDELAYE3
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
      DATAOUT => idelay_data_a(7),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_data_a(7),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
IDELAYE3_inst_b0 : IDELAYE3
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
      DATAOUT => idelay_data_b(0),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_data_b(0),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );      

IDELAYE3_inst_b1 : IDELAYE3
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
      DATAOUT => idelay_data_b(1),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_data_b(1),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );     

IDELAYE3_inst_b2 : IDELAYE3
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
      DATAOUT => idelay_data_b(2),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_data_b(2),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );     

IDELAYE3_inst_b3 : IDELAYE3
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
      DATAOUT => idelay_data_b(3),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_data_b(3),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   ); 

IDELAYE3_inst_b4 : IDELAYE3
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
      DATAOUT => idelay_data_b(4),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_data_b(4),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );   

IDELAYE3_inst_b5 : IDELAYE3
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
      DATAOUT => idelay_data_b(5),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_data_b(5),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );    

IDELAYE3_inst_b6 : IDELAYE3
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
      DATAOUT => idelay_data_b(6),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_data_b(6),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );    

IDELAYE3_inst_b7 : IDELAYE3
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
      DATAOUT => idelay_data_b(7),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_data_b(7),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );         

-------------------------------------------------------------------------------
-- Data Bit DDR Registers
-------------------------------------------------------------------------------
-- ADS42lb69 data is double data rate
-- Clock High Cycle = Bits 0,2,4,6,8,10,12,14
-- Clock Low Cycle  = Bits 1,3,5,7,9,11,13,15

sample_clk_n <= not sample_clk ;

gen_iddr16: for i in 0 to 7 generate
     
IDDR16_inst_a : IDDRE1 
generic map (
   DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
   IS_C_INVERTED => '0'   -- Optional inversion for C
   )
port map (
   Q1    => q1_data_a(i),
   Q2    => q2_data_a(i),
   C     => sample_clk,
   CB    => sample_clk_n,
   D     => idelay_data_a(i),
   R     => '0'
);
      
IDDR16_inst_b : IDDRE1 
generic map (
   DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
   IS_C_INVERTED => '0'   -- Optional inversion for C
   )
port map (
   Q1    => q1_data_b(i),
   Q2    => q2_data_b(i),
   C     => sample_clk,
   CB    => sample_clk_n,
   D     => idelay_data_b(i),
   R     => '0'
);
      
end generate gen_iddr16;

-------------------------------------------------------------------------------
-- Interleave the data bits in the correct order
-------------------------------------------------------------------------------

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      t1_q1_data_a  <= q1_data_a;
      t1_q2_data_a  <= q2_data_a;
      t1_q1_data_b  <= q1_data_b;
      t1_q2_data_b  <= q2_data_b;
      t1_intrlv_data_a <= t1_q2_data_a(7)  & t1_q1_data_a(7) & t1_q2_data_a(6) &
                     t1_q1_data_a(6) & t1_q2_data_a(5) & t1_q1_data_a(5) & t1_q2_data_a(4) &
                     t1_q1_data_a(4) & t1_q2_data_a(3) & t1_q1_data_a(3) & t1_q2_data_a(2) &
                     t1_q1_data_a(2) & t1_q2_data_a(1) & t1_q1_data_a(1) & t1_q2_data_a(0) &
                     t1_q1_data_a(0);
      t1_intrlv_data_b <= t1_q2_data_b(7)  & t1_q1_data_b(7) & t1_q2_data_b(6) &
                     t1_q1_data_b(6) & t1_q2_data_b(5) & t1_q1_data_b(5) & t1_q2_data_b(4) &
                     t1_q1_data_b(4) & t1_q2_data_b(3) & t1_q1_data_b(3) & t1_q2_data_b(2) &
                     t1_q1_data_b(2) & t1_q2_data_b(1) & t1_q1_data_b(1) & t1_q2_data_b(0) &
                     t1_q1_data_b(0);
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

--Channel A
data_in_a <= t1_intrlv_data_a;
b_data_in_a <= '0' & gain_a;
d_data_in_a <= offset_a; 

gainoffset_inst_a: px_ads42lb69intrfc_gainoffset
port map (
    clk => sample_clk,
    a   => data_in_a,
    b   => b_data_in_a,
    d   => d_data_in_a,
    p   => t5_data_go_a
  );

--Channel B
data_in_b <= t1_intrlv_data_b;
b_data_in_b <= '0' & gain_b;
d_data_in_b <= offset_b;

gainoffset_inst_b: px_ads42lb69intrfc_gainoffset
port map (
    clk => sample_clk,
    a   => data_in_b,
    b   => b_data_in_b,
    d   => d_data_in_b,
    p   => t5_data_go_b
  );

-------------------------------------------------------------------------------
-- Saturation to a 16-bit signed value
-------------------------------------------------------------------------------
--Channel A
process(sample_clk)
begin
   if rising_edge(sample_clk) then
     if (t5_data_go_a(17 downto 15) = "000") or (t5_data_go_a(17 downto 15) = "111") then
        t6_sat_data_a <= t5_data_go_a(15 downto 0);
     elsif t5_data_go_a(17) = '1' then
        t6_sat_data_a <= x"8000";
     else
        t6_sat_data_a <= x"7FFF";
     end if;
   end if;
end process;

--Channel B
process(sample_clk)
begin
   if rising_edge(sample_clk) then
     if (t5_data_go_b(17 downto 15) = "000") or (t5_data_go_b(17 downto 15) = "111") then
        t6_sat_data_b <= t5_data_go_b(15 downto 0);
     elsif t5_data_go_b(17) = '1' then
        t6_sat_data_b <= x"8000";
     else
        t6_sat_data_b <= x"7FFF";
     end if;
   end if;
end process;  

-------------------------------------------------------------------------------
-- Varaiable Data Delay
-------------------------------------------------------------------------------
process(sample_clk)
begin
   if rising_edge(sample_clk) then
        t7_sat_data_a <= t6_sat_data_a;
        t8_sat_data_a <= t7_sat_data_a;
        t9_sat_data_a <= t8_sat_data_a; 
        t7_sat_data_b <= t6_sat_data_b;
        t8_sat_data_b <= t7_sat_data_b;
        t9_sat_data_b <= t8_sat_data_b; 
        case int_delay is
            when "00" =>
              m_axis_cha_pd_tdata <= t6_sat_data_a; 
              m_axis_chb_pd_tdata <= t6_sat_data_b; 
            when "01" =>
              m_axis_cha_pd_tdata <= t7_sat_data_a; 
              m_axis_chb_pd_tdata <= t7_sat_data_b; 
            when "10" =>
              m_axis_cha_pd_tdata <= t8_sat_data_a; 
              m_axis_chb_pd_tdata <= t8_sat_data_b; 
            when "11" =>
              m_axis_cha_pd_tdata <= t9_sat_data_a; 
              m_axis_chb_pd_tdata <= t9_sat_data_b; 
            when others =>
              m_axis_cha_pd_tdata <= t9_sat_data_a; 
              m_axis_chb_pd_tdata <= t9_sat_data_b; 
        end case;     
    end if;
end process;

m_axis_cha_pd_tvalid <= '1'; 
m_axis_chb_pd_tvalid <= '1'; 

-------------------------------------------------------------------------------
-- Overload Detection
-------------------------------------------------------------------------------
-- Channel A
process(sample_clk)
begin
   if rising_edge(sample_clk) then
      ovld_thresh_p <= x"7FFF" - ovld_thresh_cnt;
      ovld_thresh_n <= x"8000" + ovld_thresh_cnt;
      if t1_intrlv_data_a(15) = '0' then -- positive input
        ovld_sub_a <= ('0' & ovld_thresh_p) - ('0' & t1_intrlv_data_a);
      else -- negative input
        ovld_sub_a <= ('0' & t1_intrlv_data_a) - ('0' & ovld_thresh_n);
      end if;  
   end if;     
end process;

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      if t6_sat_data_a(15) = '0' then -- positive input
        go_ovld_sub_a <= ('0' & ovld_thresh_p) - ('0' & t6_sat_data_a);
      else -- negative input
        go_ovld_sub_a <= ('0' & t6_sat_data_a) - ('0' & ovld_thresh_n);
      end if;  
   end if;     
end process;

adc_overload_a <= ovld_sub_a(16);    -- raw data saturation
go_overload_a  <= go_ovld_sub_a(16); -- raw data saturation

--Channel B
process(sample_clk)
begin
   if rising_edge(sample_clk) then
      ovld_thresh_p <= x"7FFF" - ovld_thresh_cnt;
      ovld_thresh_n <= x"8000" + ovld_thresh_cnt;
      if t1_intrlv_data_b(15) = '0' then -- positive input
        ovld_sub_b <= ('0' & ovld_thresh_p) - ('0' & t1_intrlv_data_b);
      else -- negative input
        ovld_sub_b <= ('0' & t1_intrlv_data_b) - ('0' & ovld_thresh_n);
      end if;  
   end if;     
end process;

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      if t6_sat_data_b(15) = '0' then -- positive input
        go_ovld_sub_b <= ('0' & ovld_thresh_p) - ('0' & t6_sat_data_b);
      else -- negative input
        go_ovld_sub_b <= ('0' & t6_sat_data_b) - ('0' & ovld_thresh_n);
      end if;  
   end if;     
end process;

adc_overload_b <= ovld_sub_b(16);    -- raw data saturation
go_overload_b  <= go_ovld_sub_b(16); -- raw data saturation

--------------------------------------------------------------------------------
-- LED Drive
--------------------------------------------------------------------------------

led_lite <= (adc_overload_a or adc_overload_b) when (led_sel = "00") else
            (go_overload_a or go_overload_b)  when (led_sel = "01") else
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
      adc_ovrld_a     <= adc_overload_a;
      adc_ovrld_b     <= adc_overload_b;
      go_trim_ovrld_a <= go_overload_a;
      go_trim_ovrld_b <= go_overload_b;
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
csr_inst: px_ads42lb69intrfc_csr
generic map(
    initial_tap_delay   => initial_tap_delay,  
    initial_gain_a      => cnst_initial_gain_a,       
    initial_gain_b      => cnst_initial_gain_b,       
    initial_offset_a    => cnst_initial_offset_a,     
    initial_offset_b    => cnst_initial_offset_b,     
    initial_pdwnf_a     => initial_pdwnf_a,     
    initial_pdwnf_b     => initial_pdwnf_b,     
    initial_led_select  => initial_led_select,
    initial_ovld_thresh => initial_ovld_thresh
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
    gain_a                  => gain_ax,                 
    gain_b                  => gain_bx,                 
    offset_a                => offset_ax, 
    offset_b                => offset_bx, 
    ovld_thresh_cnt         => ovld_thresh_cntx,                
    led_sel                 => led_selx,
    pdwnf_a                 => a_power_down, -- power down
    pdwnf_b                 => b_power_down, -- power down
    adc_reset               => adc_reset,
    dly_ld_ctl              => dly_ld_ctl,  
    clk_configured          => clk_configured,
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
    adc_overload_a            => adc_overload_ax,
    adc_overload_b            => adc_overload_bx,
    go_overload_a             => go_overload_ax,
    go_overload_b             => go_overload_bx
);

--------------------------------------------------------------------------------
-- Clock Domain Crossing for Control Signals
--------------------------------------------------------------------------------
ctl_x <= led_selx & int_delayx & ovld_thresh_cntx & offset_bx & offset_ax & gain_bx & gain_ax;

ctl_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 3, -- integer; range: 2-10
  WIDTH          => 84 -- integer; range: 1-1024
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

gain_a          <= ctl(15 downto 0);
gain_b          <= ctl(31 downto 16);
offset_a        <= ctl(47 downto 32);
offset_b        <= ctl(63 downto 48);
ovld_thresh_cnt <= ctl(79 downto 64);
int_delay       <= ctl(81 downto 80);
led_sel         <= ctl(83 downto 82);

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
     src_in   => adc_overload_a,
     dest_clk => s_axi_csr_aclk,
     dest_out => adc_overload_ax
  );
  
stat2_xclk: xpm_cdc_single
    generic map (
       DEST_SYNC_FF   => 3, -- integer; range: 2-10
       SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
       SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
    )
    port map (
       src_clk  => sample_clk,  -- optional; required when SRC_INPUT_REG = 1
       src_in   => go_overload_a,
       dest_clk => s_axi_csr_aclk,
       dest_out => go_overload_ax
    );
    
stat3_xclk: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 3, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => sample_clk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => adc_overload_b,
     dest_clk => s_axi_csr_aclk,
     dest_out => adc_overload_bx
  );
  
stat4_xclk: xpm_cdc_single
    generic map (
       DEST_SYNC_FF   => 3, -- integer; range: 2-10
       SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
       SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
    )
    port map (
       src_clk  => sample_clk,  -- optional; required when SRC_INPUT_REG = 1
       src_in   => go_overload_b,
       dest_clk => s_axi_csr_aclk,
       dest_out => go_overload_bx
    );

--------------------------------------------------------------------------------
-- ADC Serial Communication
--------------------------------------------------------------------------------
ser_com_inst: ads42lb69_serial_com
port map (
   clk       => s_axi_csr_aclk, 
   rst_n     => t1_s_axi_csr_aresetn,
   data_in   => ser_wr_data,
   addr      => ser_addr,
   wr_pls    => ser_wr_pls,
   rd_pls    => ser_rd_pls,
   data_out  => ser_rd_data,
   sm_rdy    => ser_sm_rdy,
   adc_sdi   => spi_mosi,
   adc_sdenb => spi_sen,
   adc_sclk  => spi_sclk,
   adc_sdo   => spi_miso
);

end Behavioral;

