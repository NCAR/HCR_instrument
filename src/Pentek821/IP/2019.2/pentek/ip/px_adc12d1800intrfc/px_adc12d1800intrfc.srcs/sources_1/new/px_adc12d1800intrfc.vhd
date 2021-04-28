----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 04/29/2016 08:37:16 AM
-- Design Name: 
-- Module Name: px_adc12d1800intrfc - Behavioral
-- Project Name: 
-- Target Devices: Kintex UltraScale
-- Tool Versions: 
-- Description:  T.I. ADC12d1800 ADC Interface
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
-- 0x08 - Offset/Gain Trim 
-- 0x0C - ADC Serial Control
-- 0x10 - ADC Serial Status
-- 0x14 - Interrupt Enables
-- 0x18 - Interrupt Status
-- 0x1C - Interrupt Flags

--------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------
-- Libraries
--------------------------------------------------------------------------------

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

entity px_adc12d1800intrfc is
generic (
   iodelay_grp         : string := "IODELAY_GRP";
   initial_tap_delay   : integer := 0;
   initial_gain_percent: integer := 100;
   initial_offset_counts : integer := 0;
   initial_2scomp      : boolean := true;
   initial_led_select  : integer range 0 to 3 := 0;
   ibuf_low_pwr        : boolean := false;
   has_ext_led_src     : boolean := true;
   idelaycntrl_refclk_freq: integer := 200; -- in MHz
   initial_ovld_thresh : integer := 16;  -- counts from full scale
   led_pulse_stretch   : integer range 0 to 65535:= 65535; -- counts to pulse stretch LED
   nondes_iq_swap      : boolean := true -- swap I/Q in nonDES mode 
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
-- ADS1800 ADC Intput
-------------------------------------------------------------------------------
-- (LVDS)  
   -- I Data from ADS1800
   adc_di_p                 : in std_logic_vector(11 downto 0);
   adc_di_n                 : in std_logic_vector(11 downto 0);
   -- I Data delayed from ADS1800
   adc_did_p                : in std_logic_vector(11 downto 0);
   adc_did_n                : in std_logic_vector(11 downto 0);
   -- Q Data from from ADS1800
   adc_dq_p                 : in std_logic_vector(11 downto 0);
   adc_dq_n                 : in std_logic_vector(11 downto 0);
   -- Q Data delayed from ADS1800
   adc_dqd_p                : in std_logic_vector(11 downto 0);
   adc_dqd_n                : in std_logic_vector(11 downto 0);
   -- ADC Overload Inputs
   adc_ovri_p               : in  std_logic;
   adc_ovri_n               : in  std_logic;  
   adc_ovrq_p               : in  std_logic;
   adc_ovrq_n               : in  std_logic;
   
   sample_clk               : in  std_logic; -- Sample Clock input (DIV 4) Max 400MHz
-------------------------------------------------------------------------------
-- Control Outputs
-------------------------------------------------------------------------------   
   ovld_led_n               : out std_logic; -- overload LED drive
   ext_led_src              : in  std_logic; -- optional external LED source input  
   
   -- ADC SPI Control Bus
   adc_spi_sclk             : out std_logic; -- SPI Bus Clock to the ADC
   adc_spi_sdi              : out std_logic; -- SPI Bus Data to the ADC
   adc_spi_sdenb            : out std_logic; -- SPI Bus Data to the ADC
   adc_spi_sdo              : in  std_logic; -- SPI Bus Data from the ADC 
   adc_spi_en_n             : out std_logic; -- SPI Bus Enable Output (Use to control T.S. Output Buffers)               
   --ADC 1800 control signals
   adc_cal_run              : in   std_logic;
   adc_cal                  : out  std_logic;
   adc_cal_dly              : out  std_logic;
   adc_ndm                  : out  std_logic;
   adc_des                  : out  std_logic;
   adc_fsr                  : out  std_logic;
   adc_tpm                  : out  std_logic;
   adc_ddr_ph               : out  std_logic;
   adc_scs                  : out  std_logic;
   adc_ece_n                : out  std_logic;

-------------------------------------------------------------------------------
-- Status Outputs
-------------------------------------------------------------------------------   
   adc_ovrld_a              : out std_logic;
   adc_ovrld_b              : out std_logic;
   go_trim_ovrld_a          : out std_logic;
   go_trim_ovrld_b          : out std_logic;
-------------------------------------------------------------------------------
-- Output
-------------------------------------------------------------------------------
   m_axis_pd_tdata        : out std_logic_vector(127 downto 0);
   m_axis_pd_tvalid       : out std_logic
);
end px_adc12d1800intrfc;

architecture Behavioral of px_adc12d1800intrfc is

-------------------------------------------------------------------------------
-- Components
-------------------------------------------------------------------------------
-- B*(A+D) Rounded symetrically
-- B17 should be '0' to have a 16 bit unsigned multiplication factor
-- Latency = 4

component px_adc12d1800_gainoffset
port (
    clk : in std_logic;
    a : in std_logic_vector(15 downto 0);
    b : in std_logic_vector(16 downto 0);
    d : in std_logic_vector(15 downto 0);
    p : out std_logic_vector(17 downto 0)
  );
end component;

   
-- Control/Status Registers
component px_adc12d1800intrfc_csr
generic(
    initial_tap_delay   : integer := 0;
    initial_gain        : std_logic_vector(15 downto 0) := x"8000";  
    initial_offset      : std_logic_vector(15 downto 0) := x"0000";  
    initial_2scomp      : boolean := true; 
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
    
   irq                    : out std_logic; -- interrupt
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
   hr_rst_en             : out std_logic;
   adc_des               : out std_logic; 
   adc_tpm               : out std_logic;
   adc_ddr_ph            : out std_logic;
   adc_ece_n             : out std_logic;
   adc_cal_init          : out std_logic;
   adc_spi_en_n          : out std_logic;
   dly_ld_ctl            : out std_logic;
   pdet_rst_n            : out std_logic;
   pdet_start_pls        : out std_logic;
   -- Serial Control Interface
   ser_wr_data           : out std_logic_vector(15 downto 0); 
   ser_addr              : out std_logic_vector(4 downto 0);  
   ser_wr_pls            : out std_logic;  
   ser_rd_pls            : out std_logic;  
   ser_rd_data           : in  std_logic_vector(15 downto 0);
   -- Status
   adc_cal_done          : in  std_logic;
   ser_sm_rdy            : in  std_logic;
-------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------
   adc_overload_a        : in  std_logic;
   go_overload_a         : in  std_logic;
   adc_overload_b        : in  std_logic;
   go_overload_b         : in  std_logic;
   pdet_error            : in  std_logic
);
end component;

component adc12d1800_serial_com
port (
   clk       : in  std_logic; 
   rst_n     : in  std_logic;
   data_in   : in  std_logic_vector(15 downto 0);
   addr      : in  std_logic_vector(4 downto 0);
   wr_pls    : in  std_logic;
   rd_pls    : in  std_logic;
   data_out  : out std_logic_vector(15 downto 0);
   sm_rdy    : out std_logic;
   -- adc serial signals
   adc_sdi   : out std_logic;
   adc_sdenb : out std_logic;
   adc_sclk  : out std_logic;
   adc_sdo   : in  std_logic
);
end component; 

component px_adc12d1800intrfc_pdet
port ( 
   i_data   : in  std_logic_vector(11 downto 0);
   q_data   : in  std_logic_vector(11 downto 0);
   id_data  : in  std_logic_vector(11 downto 0);
   qd_data  : in  std_logic_vector(11 downto 0);
   clk      : in  std_logic;
   rst_n    : in  std_logic;
   start_pls: in  std_logic;
   error_out: out std_logic 
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
attribute IODELAY_GROUP of IDELAYE3_i0_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_i1_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_i2_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_i3_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_i4_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_i5_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_i6_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_i7_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_i8_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_i9_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_i10_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_i11_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_id0_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_id1_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_id2_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_id3_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_id4_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_id5_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_id6_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_id7_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_id8_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_id9_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_id10_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_id11_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_q0_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_q1_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_q2_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_q3_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_q4_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_q5_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_q6_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_q7_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_q8_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_q9_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_q10_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_q11_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_qd0_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_qd1_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_qd2_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_qd3_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_qd4_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_qd5_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_qd6_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_qd7_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_qd8_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_qd9_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_qd10_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_qd11_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_ovri_inst: label is iodelay_grp;
attribute IODELAY_GROUP of IDELAYE3_ovrq_inst: label is iodelay_grp;

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";
ATTRIBUTE X_INTERFACE_INFO of sample_clk: SIGNAL is "xilinx.com:signal:clock:1.0 sample_clk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of sample_clk: SIGNAL is "ASSOCIATED_BUSIF m_axis_pd";

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------

constant refclk_freq : real := real(idelaycntrl_refclk_freq);

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal ibuf_di_data     : std_logic_vector(11 downto 0) := (others => '0');
signal ibuf_did_data    : std_logic_vector(11 downto 0) := (others => '0');
signal ibuf_dq_data     : std_logic_vector(11 downto 0) := (others => '0');
signal ibuf_dqd_data    : std_logic_vector(11 downto 0) := (others => '0');
signal idelay_di_data   : std_logic_vector(11 downto 0) := (others => '0');
signal idelay_did_data  : std_logic_vector(11 downto 0) := (others => '0');
signal idelay_dq_data   : std_logic_vector(11 downto 0) := (others => '0');
signal idelay_dqd_data  : std_logic_vector(11 downto 0) := (others => '0');
signal q1_di_data       : std_logic_vector(11 downto 0) := (others => '0');
signal q2_di_data       : std_logic_vector(11 downto 0) := (others => '0');
signal q1_did_data      : std_logic_vector(11 downto 0) := (others => '0');
signal q2_did_data      : std_logic_vector(11 downto 0) := (others => '0');
signal q1_dq_data       : std_logic_vector(11 downto 0) := (others => '0');
signal q2_dq_data       : std_logic_vector(11 downto 0) := (others => '0');
signal q1_dqd_data      : std_logic_vector(11 downto 0) := (others => '0');
signal q2_dqd_data      : std_logic_vector(11 downto 0) := (others => '0');
signal r1_q1_di_data    : std_logic_vector(11 downto 0) := (others => '0');
signal r1_q2_di_data    : std_logic_vector(11 downto 0) := (others => '0');
signal r1_q1_did_data   : std_logic_vector(11 downto 0) := (others => '0');
signal r1_q2_did_data   : std_logic_vector(11 downto 0) := (others => '0');
signal r1_q1_dq_data    : std_logic_vector(11 downto 0) := (others => '0');
signal r1_q2_dq_data    : std_logic_vector(11 downto 0) := (others => '0');
signal r1_q1_dqd_data   : std_logic_vector(11 downto 0) := (others => '0');
signal r1_q2_dqd_data   : std_logic_vector(11 downto 0) := (others => '0');
signal r2_q1_di_data    : std_logic_vector(15 downto 0) := (others => '0');
signal r2_q2_di_data    : std_logic_vector(15 downto 0) := (others => '0');
signal r2_q1_did_data   : std_logic_vector(15 downto 0) := (others => '0');
signal r2_q2_did_data   : std_logic_vector(15 downto 0) := (others => '0');
signal r2_q1_dq_data    : std_logic_vector(15 downto 0) := (others => '0');
signal r2_q2_dq_data    : std_logic_vector(15 downto 0) := (others => '0');
signal r2_q1_dqd_data   : std_logic_vector(15 downto 0) := (others => '0');
signal r2_q2_dqd_data   : std_logic_vector(15 downto 0) := (others => '0');
signal ibuf_ovri        : std_logic:= '0';
signal ibuf_ovrq        : std_logic:= '0';
signal idelay_ovri      : std_logic:= '0';
signal idelay_ovrq      : std_logic:= '0';
signal des_mode         : std_logic:= '0';
signal data_tdata       : std_logic_vector(127 downto 0) := (others => '0');
signal data_tvalid      : std_logic:= '0';
signal t4_go_tdata      : std_logic_vector(143 downto 0) := (others => '0');
signal t5_sat_tdata     : std_logic_vector(127 downto 0) := (others => '0');
signal t6_sat_tdata     : std_logic_vector(127 downto 0) := (others => '0');
signal q1_ovri          : std_logic:= '0';
signal q1_ovrq          : std_logic:= '0';
signal q2_ovri          : std_logic:= '0';
signal q2_ovrq          : std_logic:= '0';
signal r1_q1_ovri       : std_logic:= '0';
signal r1_q1_ovrq       : std_logic:= '0';
signal r1_q2_ovri       : std_logic:= '0';
signal r1_q2_ovrq       : std_logic:= '0';
signal r2_q1_ovri       : std_logic:= '0';
signal r2_q1_ovrq       : std_logic:= '0';
signal r2_q2_ovri       : std_logic:= '0';
signal r2_q2_ovrq       : std_logic:= '0';
signal go_ovld_sub_a0   : std_logic_vector(16 downto 0) := (others => '0');
signal go_ovld_sub_a1   : std_logic_vector(16 downto 0) := (others => '0');
signal go_ovld_sub_a2   : std_logic_vector(16 downto 0) := (others => '0');
signal go_ovld_sub_a3   : std_logic_vector(16 downto 0) := (others => '0');
signal go_ovld_sub_b0   : std_logic_vector(16 downto 0) := (others => '0');
signal go_ovld_sub_b1   : std_logic_vector(16 downto 0) := (others => '0');
signal go_ovld_sub_b2   : std_logic_vector(16 downto 0) := (others => '0');
signal go_ovld_sub_b3   : std_logic_vector(16 downto 0) := (others => '0');
signal a_ovr            : std_logic:= '0';
signal b_ovr            : std_logic:= '0';
signal t1_a_ovr         : std_logic:= '0';
signal t1_b_ovr         : std_logic:= '0';
signal t2_a_ovr         : std_logic:= '0';
signal t2_b_ovr         : std_logic:= '0';
signal t3_a_ovr         : std_logic:= '0';
signal t3_b_ovr         : std_logic:= '0';
signal t4_a_ovr         : std_logic:= '0';
signal t4_b_ovr         : std_logic:= '0';
signal t5_a_ovr         : std_logic:= '0';
signal t5_b_ovr         : std_logic:= '0';
signal adc_overload_a   : std_logic:= '0';
signal go_overload_a    : std_logic:= '0';
signal adc_overload_b   : std_logic:= '0';
signal go_overload_b    : std_logic:= '0';
signal adc_overload_ax  : std_logic:= '0';
signal go_overload_ax   : std_logic:= '0';
signal adc_overload_bx  : std_logic:= '0';
signal go_overload_bx   : std_logic:= '0';
signal t1_intrlv_data   : std_logic_vector(15 downto 0) := (others => '0');
signal ser_wr_data      : std_logic_vector(15 downto 0) := (others => '0');
signal ser_addr         : std_logic_vector(4 downto 0) := (others => '0');
signal ser_wr_pls       : std_logic:= '0';
signal ser_rd_pls       : std_logic:= '0';
signal ser_rd_data      : std_logic_vector(15 downto 0) := (others => '0');
signal ser_sm_rdy       : std_logic:= '0';
signal hr_rst_en        : std_logic:= '0';
signal adc_cal_init     : std_logic:= '0';
signal adc_cal_run_reg1 : std_logic:= '0'; 
signal adc_cal_run_reg2 : std_logic:= '0';    
signal s_axi_csr_aresetn_reg: std_logic:= '0';
signal adc_cal_init_reg : std_logic:= '0';    
signal adc_cal_done     : std_logic:= '0';
signal ld_cntr          : std_logic_vector(5 downto 0) := "000000";
signal dly_ld           : std_logic:= '0';
signal tap_delay        : std_logic_vector(8 downto 0) := (others => '0');
signal int_delay        : std_logic_vector(1 downto 0) := (others => '0');
signal sample_clk_n     : std_logic:= '0';
signal b_data_in        : std_logic_vector(16 downto 0) := (others => '0');
signal d_data_in        : std_logic_vector(15 downto 0) := (others => '0');
signal ovld_thresh_p    : std_logic_vector(15 downto 0) := (others => '0');
signal ovld_thresh_n    : std_logic_vector(15 downto 0) := (others => '0');
signal led_lite         : std_logic:= '0';
signal pls_strch_cntr   : std_logic_vector(15 downto 0) := (others => '0');
signal gain             : std_logic_vector(15 downto 0) := (others => '0');
signal offset           : std_logic_vector(15 downto 0) := (others => '0');
signal ovld_thresh_cnt  : std_logic_vector(15 downto 0) := (others => '0');
signal led_sel          : std_logic_vector(1 downto 0) := (others => '0'); 
signal twoscomp         : std_logic:= '0';
signal en_vtc           : std_logic:= '0';
signal adc_cal_low_start: std_logic:= '0';
signal adc_cal_high_start: std_logic:= '0';
signal adc_cal_counter  : std_logic_vector(10 downto 0) := (others => '0');
signal dly_ld_ctl_re    : std_logic:= '0';
signal t1_dly_ld_ctl    : std_logic:= '0';
signal dly_ld_ctl       : std_logic:= '0';
signal x_pdet_rst_n     : std_logic:= '0';    
signal x_pdet_start_pls : std_logic:= '0';   
signal x_pdet_error     : std_logic:= '0'; 
signal pdet_rst_n       : std_logic:= '0';    
signal pdet_start_pls   : std_logic:= '0';   
signal pdet_error       : std_logic:= '0';   
signal src_senda        : std_logic:= '0';
signal src_rcva         : std_logic:= '0';
signal dest_reqa        : std_logic:= '0'; 
signal gainx            : std_logic_vector(15 downto 0) := (others => '0');
signal offsetx          : std_logic_vector(15 downto 0) := (others => '0');
signal ovld_thresh_cntx : std_logic_vector(15 downto 0) := (others => '0');
signal int_delayx       : std_logic_vector(1 downto 0) := (others => '0');
signal led_selx         : std_logic_vector(1 downto 0) := (others => '0');
signal ctl_x            : std_logic_vector(52 downto 0) := (others => '0');
signal ctl              : std_logic_vector(52 downto 0) := (others => '0');
signal src_rcvc         : std_logic := '0';
signal src_sendc        : std_logic := '0';
signal dest_reqc        : std_logic := '0';
signal twoscompx        : std_logic := '0';
signal t1_s_axi_csr_aresetn: std_logic := '0';
------------------------------------------------------------------------------

begin

adc_fsr     <= '1'; -- Full Scale Range
adc_cal_dly <= '0';
adc_ndm     <= '0'; -- Demux Mode

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

gen_ibufds: for i in 0 to 11 generate

data_IBUFDS_i_inst : IBUFDS
generic map (
   IBUF_LOW_PWR   => ibuf_low_pwr,
   IOSTANDARD     => "LVDS"
)
port map (
   I  => adc_di_p(i), 
   IB => adc_di_n(i), 
   O  => ibuf_di_data(i)
);

data_IBUFDS_id_inst : IBUFDS
generic map (
   IBUF_LOW_PWR   => ibuf_low_pwr,
   IOSTANDARD     => "LVDS"
)
port map (
   I  => adc_did_p(i), 
   IB => adc_did_n(i), 
   O  => ibuf_did_data(i)
);

data_IBUFDS_q_inst : IBUFDS
generic map (
   IBUF_LOW_PWR   => ibuf_low_pwr,
   IOSTANDARD     => "LVDS"
)
port map (
   I  => adc_dq_p(i), 
   IB => adc_dq_n(i), 
   O  => ibuf_dq_data(i)
);

data_IBUFDS_qd_inst : IBUFDS
generic map (
   IBUF_LOW_PWR   => ibuf_low_pwr,
   IOSTANDARD     => "LVDS"
)
port map (
   I  => adc_dqd_p(i), 
   IB => adc_dqd_n(i), 
   O  => ibuf_dqd_data(i)
);

end generate gen_ibufds;

-- Overload Input Buffers
data_IBUFDS_ovi_inst : IBUFDS
generic map (
   IBUF_LOW_PWR   => ibuf_low_pwr,
   IOSTANDARD     => "LVDS"
)
port map (
   I  => adc_ovri_p, 
   IB => adc_ovri_n, 
   O  => ibuf_ovri
);

data_IBUFDS_ovq_inst : IBUFDS
generic map (
   IBUF_LOW_PWR   => ibuf_low_pwr,
   IOSTANDARD     => "LVDS"
)
port map (
   I  => adc_ovrq_p, 
   IB => adc_ovrq_n, 
   O  => ibuf_ovrq
);

--------------------------------------------------------------------------------
-- Tap Delays
--------------------------------------------------------------------------------

-- These tap delays are used to adjust the input setup/hold in relation to the clock

IDELAYE3_i0_inst : IDELAYE3
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
      DATAOUT => idelay_di_data(0),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_di_data(0),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
IDELAYE3_i1_inst : IDELAYE3
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
      DATAOUT => idelay_di_data(1),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_di_data(1),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );   
   
IDELAYE3_i2_inst : IDELAYE3
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
      DATAOUT => idelay_di_data(2),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_di_data(2),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
IDELAYE3_i3_inst : IDELAYE3
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
      DATAOUT => idelay_di_data(3),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_di_data(3),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   ); 
   
IDELAYE3_i4_inst : IDELAYE3
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
         DATAOUT => idelay_di_data(4),         -- 1-bit output: Delayed data output
         CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
         CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
         CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
         CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
         CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
         DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
         EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
         IDATAIN => ibuf_di_data(4),         -- 1-bit input: Data input from the logic
         INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
         LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
         RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
      );
      
IDELAYE3_i5_inst : IDELAYE3
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
      DATAOUT => idelay_di_data(5),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_di_data(5),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );   
   
IDELAYE3_i6_inst : IDELAYE3
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
      DATAOUT => idelay_di_data(6),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_di_data(6),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
IDELAYE3_i7_inst : IDELAYE3
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
      DATAOUT => idelay_di_data(7),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_di_data(7),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );   
      
IDELAYE3_i8_inst : IDELAYE3
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
      DATAOUT => idelay_di_data(8),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_di_data(8),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
IDELAYE3_i9_inst : IDELAYE3
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
      DATAOUT => idelay_di_data(9),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_di_data(9),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );   
   
IDELAYE3_i10_inst : IDELAYE3
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
      DATAOUT => idelay_di_data(10),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_di_data(10),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
IDELAYE3_i11_inst : IDELAYE3
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
      DATAOUT => idelay_di_data(11),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_di_data(11),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );        

IDELAYE3_id0_inst : IDELAYE3
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
      DATAOUT => idelay_did_data(0),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_did_data(0),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
IDELAYE3_id1_inst : IDELAYE3
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
      DATAOUT => idelay_did_data(1),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_did_data(1),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );   
   
IDELAYE3_id2_inst : IDELAYE3
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
      DATAOUT => idelay_did_data(2),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_did_data(2),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
IDELAYE3_id3_inst : IDELAYE3
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
      DATAOUT => idelay_did_data(3),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_did_data(3),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   ); 
   
IDELAYE3_id4_inst : IDELAYE3
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
         DATAOUT => idelay_did_data(4),         -- 1-bit output: Delayed data output
         CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
         CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
         CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
         CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
         CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
         DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
         EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
         IDATAIN => ibuf_did_data(4),         -- 1-bit input: Data input from the logic
         INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
         LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
         RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
      );
      
IDELAYE3_id5_inst : IDELAYE3
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
      DATAOUT => idelay_did_data(5),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_did_data(5),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );   
   
IDELAYE3_id6_inst : IDELAYE3
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
      DATAOUT => idelay_did_data(6),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_did_data(6),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
IDELAYE3_id7_inst : IDELAYE3
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
      DATAOUT => idelay_did_data(7),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_did_data(7),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );   
      
IDELAYE3_id8_inst : IDELAYE3
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
      DATAOUT => idelay_did_data(8),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_did_data(8),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
IDELAYE3_id9_inst : IDELAYE3
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
      DATAOUT => idelay_did_data(9),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_did_data(9),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );   
   
IDELAYE3_id10_inst : IDELAYE3
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
      DATAOUT => idelay_did_data(10),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_did_data(10),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
IDELAYE3_id11_inst : IDELAYE3
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
      DATAOUT => idelay_did_data(11),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_did_data(11),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );   


IDELAYE3_q0_inst : IDELAYE3
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
      DATAOUT => idelay_dq_data(0),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_dq_data(0),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
IDELAYE3_q1_inst : IDELAYE3
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
      DATAOUT => idelay_dq_data(1),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_dq_data(1),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );   
   
IDELAYE3_q2_inst : IDELAYE3
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
      DATAOUT => idelay_dq_data(2),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_dq_data(2),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
IDELAYE3_q3_inst : IDELAYE3
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
      DATAOUT => idelay_dq_data(3),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_dq_data(3),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   ); 
   
IDELAYE3_q4_inst : IDELAYE3
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
         DATAOUT => idelay_dq_data(4),         -- 1-bit output: Delayed data output
         CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
         CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
         CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
         CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
         CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
         DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
         EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
         IDATAIN => ibuf_dq_data(4),         -- 1-bit input: Data input from the logic
         INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
         LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
         RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
      );
      
IDELAYE3_q5_inst : IDELAYE3
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
      DATAOUT => idelay_dq_data(5),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_dq_data(5),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );   
   
IDELAYE3_q6_inst : IDELAYE3
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
      DATAOUT => idelay_dq_data(6),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_dq_data(6),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
IDELAYE3_q7_inst : IDELAYE3
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
      DATAOUT => idelay_dq_data(7),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_dq_data(7),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );   
      
IDELAYE3_q8_inst : IDELAYE3
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
      DATAOUT => idelay_dq_data(8),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_dq_data(8),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
IDELAYE3_q9_inst : IDELAYE3
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
      DATAOUT => idelay_dq_data(9),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_dq_data(9),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );   
   
IDELAYE3_q10_inst : IDELAYE3
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
      DATAOUT => idelay_dq_data(10),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_dq_data(10),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
IDELAYE3_q11_inst : IDELAYE3
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
      DATAOUT => idelay_dq_data(11),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_dq_data(11),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );        

IDELAYE3_qd0_inst : IDELAYE3
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
      DATAOUT => idelay_dqd_data(0),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_dqd_data(0),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
IDELAYE3_qd1_inst : IDELAYE3
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
      DATAOUT => idelay_dqd_data(1),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_dqd_data(1),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );   
   
IDELAYE3_qd2_inst : IDELAYE3
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
      DATAOUT => idelay_dqd_data(2),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_dqd_data(2),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
IDELAYE3_qd3_inst : IDELAYE3
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
      DATAOUT => idelay_dqd_data(3),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_dqd_data(3),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   ); 
   
IDELAYE3_qd4_inst : IDELAYE3
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
         DATAOUT => idelay_dqd_data(4),         -- 1-bit output: Delayed data output
         CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
         CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
         CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
         CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
         CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
         DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
         EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
         IDATAIN => ibuf_dqd_data(4),         -- 1-bit input: Data input from the logic
         INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
         LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
         RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
      );
      
IDELAYE3_qd5_inst : IDELAYE3
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
      DATAOUT => idelay_dqd_data(5),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_dqd_data(5),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );   
   
IDELAYE3_qd6_inst : IDELAYE3
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
      DATAOUT => idelay_dqd_data(6),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_dqd_data(6),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
IDELAYE3_qd7_inst : IDELAYE3
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
      DATAOUT => idelay_dqd_data(7),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_dqd_data(7),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );   
      
IDELAYE3_qd8_inst : IDELAYE3
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
      DATAOUT => idelay_dqd_data(8),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_dqd_data(8),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
IDELAYE3_qd9_inst : IDELAYE3
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
      DATAOUT => idelay_dqd_data(9),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_dqd_data(9),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );   
   
IDELAYE3_qd10_inst : IDELAYE3
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
      DATAOUT => idelay_dqd_data(10),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_dqd_data(10),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
   
IDELAYE3_qd11_inst : IDELAYE3
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
      DATAOUT => idelay_dqd_data(11),         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_dqd_data(11),         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   ); 


IDELAYE3_ovri_inst : IDELAYE3
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
      DATAOUT => idelay_ovri,         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_ovri,         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );         
   
IDELAYE3_ovrq_inst : IDELAYE3
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
      DATAOUT => idelay_ovrq,         -- 1-bit output: Delayed data output
      CASC_IN => '0',         -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0', -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',                   -- 1-bit input: Active high enable increment/decrement input
      CLK => s_axi_csr_aclk,                 -- 1-bit input: Clock input
      CNTVALUEIN => tap_delay,   -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => en_vtc,--'1',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => ibuf_ovrq,         -- 1-bit input: Data input from the logic
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LOAD => dly_ld,               -- 1-bit input: Load DELAY_VALUE input
      RST => '0'                  -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );     

-------------------------------------------------------------------------------
-- Data Bit DDR Registers
-------------------------------------------------------------------------------

sample_clk_n <= not sample_clk ;

gen_iddr: for i in 0 to 11 generate
     
IDDR_di_inst : IDDRE1 
generic map (
   DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
   IS_C_INVERTED => '0'   -- Optional inversion for C
   )
port map (
   Q1    => q1_di_data(i),
   Q2    => q2_di_data(i),
   C     => sample_clk,
   CB    => sample_clk_n,
   D     => idelay_di_data(i),
   R     => '0'
);

IDDR_did_inst : IDDRE1 
generic map (
   DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
   IS_C_INVERTED => '0'   -- Optional inversion for C
   )
port map (
   Q1    => q1_did_data(i),
   Q2    => q2_did_data(i),
   C     => sample_clk,
   CB    => sample_clk_n,
   D     => idelay_did_data(i),
   R     => '0'
);

IDDR_dq_inst : IDDRE1 
generic map (
   DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
   IS_C_INVERTED => '0'   -- Optional inversion for C
   )
port map (
   Q1    => q1_dq_data(i),
   Q2    => q2_dq_data(i),
   C     => sample_clk,
   CB    => sample_clk_n,
   D     => idelay_dq_data(i),
   R     => '0'
);

IDDR_dqd_inst : IDDRE1 
generic map (
   DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
   IS_C_INVERTED => '0'   -- Optional inversion for C
   )
port map (
   Q1    => q1_dqd_data(i),
   Q2    => q2_dqd_data(i),
   C     => sample_clk,
   CB    => sample_clk_n,
   D     => idelay_dqd_data(i),
   R     => '0'
);
      
end generate gen_iddr;

IDDR_ovri_inst : IDDRE1 
generic map (
   DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
   IS_C_INVERTED => '0'   -- Optional inversion for C
   )
port map (
   Q1    => q1_ovri,
   Q2    => q2_ovri,
   C     => sample_clk,
   CB    => sample_clk_n,
   D     => idelay_ovri,
   R     => '0'
);

IDDR_ovrq_inst : IDDRE1 
generic map (
   DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
   IS_C_INVERTED => '0'   -- Optional inversion for C
   )
port map (
   Q1    => q1_ovrq,
   Q2    => q2_ovrq,
   C     => sample_clk,
   CB    => sample_clk_n,
   D     => idelay_ovrq,
   R     => '0'
);

-------------------------------------------------------------------------------
-- Register internally
-------------------------------------------------------------------------------
process(sample_clk)
begin
   if rising_edge(sample_clk) then     
      r1_q1_di_data(10 downto 0)  <= q1_di_data(10 downto 0);
      r1_q1_di_data(11)           <= twoscomp xor q1_di_data(11);
      r1_q1_dq_data(10 downto 0)  <= q1_dq_data(10 downto 0);
      r1_q1_dq_data(11)           <= twoscomp xor q1_dq_data(11);
      r1_q1_did_data(10 downto 0) <= q1_did_data(10 downto 0);
      r1_q1_did_data(11)          <= twoscomp xor q1_did_data(11);
      r1_q1_dqd_data(10 downto 0) <= q1_dqd_data(10 downto 0);
      r1_q1_dqd_data(11)          <= twoscomp xor q1_dqd_data(11);
      
      r1_q2_di_data(10 downto 0)  <= q2_di_data(10 downto 0);
      r1_q2_di_data(11)           <= twoscomp xor q2_di_data(11);
      r1_q2_dq_data(10 downto 0)  <= q2_dq_data(10 downto 0);
      r1_q2_dq_data(11)           <= twoscomp xor q2_dq_data(11);
      r1_q2_did_data(10 downto 0) <= q2_did_data(10 downto 0);
      r1_q2_did_data(11)          <= twoscomp xor q2_did_data(11);
      r1_q2_dqd_data(10 downto 0) <= q2_dqd_data(10 downto 0);
      r1_q2_dqd_data(11)          <= twoscomp xor q2_dqd_data(11);
      
      r2_q1_di_data(15 downto 4)  <= r1_q1_di_data(11 downto 0);
      r2_q1_did_data(15 downto 4) <= r1_q1_did_data(11 downto 0);
      r2_q1_dq_data(15 downto 4)  <= r1_q1_dq_data(11 downto 0);
      r2_q1_dqd_data(15 downto 4) <= r1_q1_dqd_data(11 downto 0);
      
      r2_q2_di_data(15 downto 4)  <= r1_q2_di_data(11 downto 0);
      r2_q2_did_data(15 downto 4) <= r1_q2_did_data(11 downto 0);
      r2_q2_dq_data(15 downto 4)  <= r1_q2_dq_data(11 downto 0);
      r2_q2_dqd_data(15 downto 4) <= r1_q2_dqd_data(11 downto 0);
      
      r1_q1_ovri <= q1_ovri;
      r1_q1_ovrq <= q1_ovrq;
      r1_q2_ovri <= q2_ovri;
      r1_q2_ovrq <= q2_ovrq;
      
      r2_q1_ovri <= r1_q1_ovri;
      r2_q1_ovrq <= r1_q1_ovrq;
      r2_q2_ovri <= r1_q2_ovri;
      r2_q2_ovrq <= r1_q2_ovrq;

   end if;
end process;

gen_nondes_norm: if (nondes_iq_swap = false) generate
process(sample_clk)
begin
   if rising_edge(sample_clk) then  
      if des_mode = '1' then -- DES Mode 1 Channel/8 samples per clock
         data_tdata <= r2_q2_di_data & r2_q2_dq_data & r2_q2_did_data & r2_q2_dqd_data & r2_q1_di_data & r2_q1_dq_data & r2_q1_did_data & r2_q1_dqd_data; 
         a_ovr        <= r2_q2_ovrq or r2_q2_ovri or r2_q1_ovrq or r2_q1_ovri;
         b_ovr        <= r2_q2_ovrq or r2_q2_ovri or r2_q1_ovrq or r2_q1_ovri;      
      else -- Non-Des Mode 2 Channel/4 samples per clock each 
         data_tdata   <= r2_q2_dq_data & r2_q2_dqd_data & r2_q1_dq_data & r2_q1_dqd_data & r2_q2_di_data & r2_q2_did_data & r2_q1_di_data & r2_q1_did_data;
         a_ovr        <= r2_q2_ovri or r2_q1_ovri;
         b_ovr        <= r2_q2_ovrq or r2_q1_ovrq;
      end if;
   end if;
end process;

end generate;

gen_nondes_swap: if (nondes_iq_swap = true) generate
process(sample_clk)
begin
   if rising_edge(sample_clk) then  
      if des_mode = '1' then -- DES Mode 1 Channel/8 samples per clock
         data_tdata <= r2_q2_di_data & r2_q2_dq_data & r2_q2_did_data & r2_q2_dqd_data & r2_q1_di_data & r2_q1_dq_data & r2_q1_did_data & r2_q1_dqd_data; 
         a_ovr        <= r2_q2_ovrq or r2_q2_ovri or r2_q1_ovrq or r2_q1_ovri;
         b_ovr        <= r2_q2_ovrq or r2_q2_ovri or r2_q1_ovrq or r2_q1_ovri;      
      else -- Non-Des Mode 2 Channel/4 samples per clock each (IQ swapped)
         data_tdata   <= r2_q2_di_data & r2_q2_did_data & r2_q1_di_data & r2_q1_did_data & r2_q2_dq_data & r2_q2_dqd_data & r2_q1_dq_data & r2_q1_dqd_data;
         a_ovr        <= r2_q2_ovrq or r2_q1_ovrq;
         b_ovr        <= r2_q2_ovri or r2_q1_ovri;
      end if;
   end if;
end process;

end generate;

r2_q2_di_data(3 downto 0)  <= x"0"; 
r2_q2_did_data(3 downto 0) <= x"0"; 
r2_q2_dq_data(3 downto 0)  <= x"0"; 
r2_q2_dqd_data(3 downto 0) <= x"0"; 
                               
r2_q1_di_data(3 downto 0)  <= x"0"; 
r2_q1_did_data(3 downto 0) <= x"0"; 
r2_q1_dq_data(3 downto 0)  <= x"0"; 
r2_q1_dqd_data(3 downto 0) <= x"0"; 


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

b_data_in <= '0' & gain;
d_data_in <= offset; 

gen_go: for i in 0 to 7 generate

gainoffset_inst : px_adc12d1800_gainoffset
port map (
    clk => sample_clk,
    a   => data_tdata((16*i)+15 downto (16*i)),
    b   => b_data_in,
    d   => d_data_in,
    p   => t4_go_tdata((18*i)+17 downto (18*i))
  );

   
-------------------------------------------------------------------------------
-- Saturation to a 16-bit signed value
-------------------------------------------------------------------------------

process(sample_clk)
begin
   if rising_edge(sample_clk) then
     if (t4_go_tdata((18*i)+17 downto (18*i)+15) = "000") or (t4_go_tdata((18*i)+17 downto (18*i)+15) = "111") then
        t5_sat_tdata((16*i)+15 downto (16*i)) <= t4_go_tdata((18*i)+15 downto (18*i));
     elsif t4_go_tdata((18*i)+17) = '1' then
        t5_sat_tdata((16*i)+15 downto (16*i)) <= x"8000";
     else
        t5_sat_tdata((16*i)+15 downto (16*i)) <= x"7FFF";
     end if;
   end if;
end process;

end generate gen_go;  

-------------------------------------------------------------------------------
-- Varaiable Data Delay
-------------------------------------------------------------------------------

process(sample_clk)
begin
   if rising_edge(sample_clk) then
        t6_sat_tdata        <= t5_sat_tdata;
        t1_a_ovr <= a_ovr;
        t2_a_ovr <= t1_a_ovr;
        t3_a_ovr <= t2_a_ovr;
        t4_a_ovr <= t3_a_ovr;
        t5_a_ovr <= t4_a_ovr;
        t1_b_ovr <= b_ovr;
        t2_b_ovr <= t1_b_ovr;
        t3_b_ovr <= t2_b_ovr;
        t4_b_ovr <= t3_b_ovr;
        t5_b_ovr <= t4_b_ovr;
        case int_delay is
            when "00" =>
              m_axis_pd_tdata <= t5_sat_tdata(127 downto 0);
            when "01" =>
              m_axis_pd_tdata <= t5_sat_tdata(111 downto 0) & t6_sat_tdata(127 downto 112); 
            when "10" =>
              m_axis_pd_tdata <= t5_sat_tdata(95 downto 0) & t6_sat_tdata(127 downto 96); 
            when "11" =>
              m_axis_pd_tdata <= t5_sat_tdata(79 downto 0) & t6_sat_tdata(127 downto 80); 
            when others =>
              m_axis_pd_tdata <= t5_sat_tdata(63 downto 0) & t6_sat_tdata(127 downto 64); 
        end case;     
    end if;
end process;

m_axis_pd_tvalid  <= '1';
    
-------------------------------------------------------------------------------
-- Overload Detection
-------------------------------------------------------------------------------
process(sample_clk)
begin
   if rising_edge(sample_clk) then
      ovld_thresh_p <= x"7FFF" - ovld_thresh_cnt;
      ovld_thresh_n <= x"8000" + ovld_thresh_cnt;
      if  t5_sat_tdata((0*16)+15) = '0' then -- positive input
        go_ovld_sub_a0 <= ('0' & ovld_thresh_p) - ('0' & t5_sat_tdata((0*16)+15 downto (0*16)));
      else -- negative input
        go_ovld_sub_a0 <= ('0' & t5_sat_tdata((0*16)+15 downto (0*16))) - ('0' & ovld_thresh_n);
      end if;  
      if  t5_sat_tdata((1*16)+15) = '0' then -- positive input
        go_ovld_sub_a1 <= ('0' & ovld_thresh_p) - ('0' & t5_sat_tdata((1*16)+15 downto (1*16)));
      else -- negative input
        go_ovld_sub_a1 <= ('0' & t5_sat_tdata((1*16)+15 downto (1*16))) - ('0' & ovld_thresh_n);
      end if;  
      if  t5_sat_tdata((2*16)+15) = '0' then -- positive input
        go_ovld_sub_a2 <= ('0' & ovld_thresh_p) - ('0' & t5_sat_tdata((2*16)+15 downto (2*16)));
      else -- negative input
        go_ovld_sub_a2 <= ('0' & t5_sat_tdata((2*16)+15 downto (2*16))) - ('0' & ovld_thresh_n);
      end if;        
      if  t5_sat_tdata((3*16)+15) = '0' then -- positive input
        go_ovld_sub_a3 <= ('0' & ovld_thresh_p) - ('0' & t5_sat_tdata((3*16)+15 downto (3*16)));
      else -- negative input
        go_ovld_sub_a3 <= ('0' & t5_sat_tdata((3*16)+15 downto (3*16))) - ('0' & ovld_thresh_n);
      end if;     
      if  t5_sat_tdata((4*16)+15) = '0' then -- positive input
        go_ovld_sub_b0 <= ('0' & ovld_thresh_p) - ('0' & t5_sat_tdata((4*16)+15 downto (4*16)));
      else -- negative input
        go_ovld_sub_b0 <= ('0' & t5_sat_tdata((4*16)+15 downto (4*16))) - ('0' & ovld_thresh_n);
      end if;  
      if  t5_sat_tdata((5*16)+15) = '0' then -- positive input
        go_ovld_sub_b1 <= ('0' & ovld_thresh_p) - ('0' & t5_sat_tdata((5*16)+15 downto (5*16)));
      else -- negative input
        go_ovld_sub_b1 <= ('0' & t5_sat_tdata((5*16)+15 downto (5*16))) - ('0' & ovld_thresh_n);
      end if;  
      if  t5_sat_tdata((6*16)+15) = '0' then -- positive input
        go_ovld_sub_b2 <= ('0' & ovld_thresh_p) - ('0' & t5_sat_tdata((6*16)+15 downto (6*16)));
      else -- negative input
        go_ovld_sub_b2 <= ('0' & t5_sat_tdata((6*16)+15 downto (6*16))) - ('0' & ovld_thresh_n);
      end if;        
      if  t5_sat_tdata((7*16)+15) = '0' then -- positive input
        go_ovld_sub_b3 <= ('0' & ovld_thresh_p) - ('0' & t5_sat_tdata((7*16)+15 downto (7*16)));
      else -- negative input
        go_ovld_sub_b3 <= ('0' & t5_sat_tdata((7*16)+15 downto (7*16))) - ('0' & ovld_thresh_n);
      end if;      
   end if;     
end process;

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      adc_overload_a <= t5_a_ovr;    -- raw data saturation
      adc_overload_b <= t5_b_ovr;    -- raw data saturation
      go_overload_a  <= go_ovld_sub_a3(16) or go_ovld_sub_a2(16) or go_ovld_sub_a1(16) or go_ovld_sub_a0(16); 
      go_overload_b  <= go_ovld_sub_b3(16) or go_ovld_sub_b2(16) or go_ovld_sub_b1(16) or go_ovld_sub_b0(16); 
    end if;
end process;

--------------------------------------------------------------------------------
-- LED Drive
--------------------------------------------------------------------------------

led_lite <= (adc_overload_a or adc_overload_b) when (led_sel = "00") else
            (adc_overload_a or adc_overload_b or go_overload_a or go_overload_b)  when (led_sel = "01") else
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
csr_inst: px_adc12d1800intrfc_csr
generic map(
    initial_tap_delay   => initial_tap_delay,  
    initial_gain        => cnst_initial_gain,       
    initial_offset      => cnst_initial_offset,     
    initial_2scomp      => initial_2scomp,     
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
    twoscomp                => twoscompx,   
    gain                    => gainx,                 
    offset                  => offsetx, 
    ovld_thresh_cnt         => ovld_thresh_cntx,                
    led_sel                 => led_selx,
    adc_des                 => des_mode,      
    adc_tpm                 => adc_tpm,     
    adc_ddr_ph              => adc_ddr_ph,   
    adc_ece_n               => adc_ece_n,     
    adc_cal_init            => adc_cal_init,
    adc_spi_en_n            => adc_spi_en_n,
    dly_ld_ctl              => dly_ld_ctl, 
    pdet_rst_n              => pdet_rst_n,    
    pdet_start_pls          => pdet_start_pls,
    -- Serial Control Interface
    ser_wr_data             => ser_wr_data, 
    ser_addr                => ser_addr,    
    ser_wr_pls              => ser_wr_pls,  
    ser_rd_pls              => ser_rd_pls,  
    ser_rd_data             => ser_rd_data,
    -- Status 
    ser_sm_rdy              => ser_sm_rdy, 
    adc_cal_done            => adc_cal_done,
 -------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------
    adc_overload_a          => adc_overload_ax,
    adc_overload_b          => adc_overload_bx,
    go_overload_a           => go_overload_ax,
    go_overload_b           => go_overload_bx,
    pdet_error              => pdet_error 
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
  WIDTH          => 53 -- integer; range: 1-1024
)
port map (
  src_clk    => s_axi_csr_aclk,
  src_in     => ctl_x,
  src_send   => src_sendc,
  src_rcv    => src_rcvc,
  dest_clk   => sample_clk,
  dest_req   => dest_reqc,
  dest_ack   => dest_reqc, 
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
     if (src_rcvc = '1') then
       src_sendc <= '0';
     elsif (src_rcvc = '0') and (src_sendc = '0') then
       src_sendc <= '1';
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

adc_des <= des_mode;

process(s_axi_csr_aclk)
begin

    if rising_edge(s_axi_csr_aclk) then
        adc_cal_run_reg1      <= adc_cal_run; 
        adc_cal_run_reg2      <= adc_cal_run_reg1;
        s_axi_csr_aresetn_reg <= t1_s_axi_csr_aresetn;
        adc_cal_init_reg      <= adc_cal_init;

        if( t1_s_axi_csr_aresetn = '0') then
           adc_cal_done        <= '0';   
        -- Indicates that calibration is running, but not complete
        elsif(adc_cal_run_reg1 = '1' and adc_cal_run_reg2 = '0') then
            adc_cal_done <= '0';
        -- Indicates that calibration has completed                
        elsif(adc_cal_run_reg2 = '1' and adc_cal_run_reg1 = '0') then
            adc_cal_done <= '1';
        end if;
        
        if( t1_s_axi_csr_aresetn = '0') then
            adc_cal_low_start   <= '0';
            adc_cal_high_start  <= '0';
            adc_cal             <= '0';
        elsif ((s_axi_csr_aresetn_reg = '0' and t1_s_axi_csr_aresetn = '1') or
           (adc_cal_init_reg = '0' and adc_cal_init = '1')) then
            adc_cal_low_start  <= '1';
            adc_cal_high_start <= '0';
            adc_cal            <= '0';
        elsif (adc_cal_low_start = '1' and adc_cal_counter = 1300) then
            adc_cal_low_start  <= '0';
            adc_cal_high_start <= '1';
            adc_cal            <= '1';
        elsif (adc_cal_high_start = '1' and adc_cal_counter = 1300) then
            adc_cal_low_start  <= '0';
            adc_cal_high_start <= '0';
            adc_cal            <= '0'; 
        end if;
        
        if ( t1_s_axi_csr_aresetn = '0')  or (adc_cal_counter = 1300) then
           adc_cal_counter    <= (others => '0');
        elsif(adc_cal_low_start = '1' or adc_cal_high_start = '1') then
           adc_cal_counter <= adc_cal_counter + 1;
        else
           adc_cal_counter    <= (others => '0');
        end if;
    end if;
end process;

--------------------------------------------------------------------------------
-- ADC Serial Communication
--------------------------------------------------------------------------------
ser_com_inst: adc12d1800_serial_com
port map (
   clk      => s_axi_csr_aclk, 
   rst_n    => t1_s_axi_csr_aresetn,
   data_in  => ser_wr_data,
   addr     => ser_addr,
   wr_pls   => ser_wr_pls,
   rd_pls   => ser_rd_pls,
   data_out => ser_rd_data,
   sm_rdy   => ser_sm_rdy,
   adc_sdi  => adc_spi_sdi,
   adc_sdenb=> adc_spi_sdenb,
   adc_sclk => adc_spi_sclk,
   adc_sdo  => adc_spi_sdo
);

adc_scs <= not ser_sm_rdy;

--------------------------------------------------------------------------------
-- Tap Delay Calibration Test Pattern Detector
--------------------------------------------------------------------------------

pat_det_inst: px_adc12d1800intrfc_pdet
port map ( 
   i_data    => r2_q1_di_data(15 downto 4),
   q_data    => r2_q1_dq_data(15 downto 4),
   id_data   => r2_q1_did_data(15 downto 4),
   qd_data   => r2_q1_dqd_data(15 downto 4),
   clk       => sample_clk,
   rst_n     => x_pdet_rst_n,
   start_pls => x_pdet_start_pls,
   error_out => x_pdet_error
);

rst_cdc_inst: xpm_cdc_async_rst
generic map (

  -- Common module parameters
   DEST_SYNC_FF    => 4, -- integer; range: 2-10
   RST_ACTIVE_HIGH => 0  -- integer; 0=active low reset, 1=active high reset
)
port map (

   src_arst  => pdet_rst_n,
   dest_clk  => sample_clk,
   dest_arst => x_pdet_rst_n
);

strt_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 0, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => s_axi_csr_aclk,
    src_rst    => '0',  -- optional; required when RST_USED = 1
    src_pulse  => pdet_start_pls,
    dest_clk   => sample_clk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => x_pdet_start_pls
);

err_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 4, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 4, -- integer; range: 2-10
  WIDTH          => 1  -- integer; range: 1-1024
)
port map (
  src_clk    => sample_clk,
  src_in(0)  => x_pdet_error,
  src_send   => src_senda,
  src_rcv    => src_rcva,
  dest_clk   => s_axi_csr_aclk,
  dest_req   => dest_reqa,
  dest_ack   => dest_reqa, 
  dest_out(0)=> pdet_error
);

process(sample_clk)
begin
   if rising_edge(sample_clk) then
     if (src_rcva = '1') then
       src_senda <= '0';
     elsif (src_rcva = '0') and (src_senda = '0') then
       src_senda <= '1';
     end if;  
   end if;
end process;   

end Behavioral;
