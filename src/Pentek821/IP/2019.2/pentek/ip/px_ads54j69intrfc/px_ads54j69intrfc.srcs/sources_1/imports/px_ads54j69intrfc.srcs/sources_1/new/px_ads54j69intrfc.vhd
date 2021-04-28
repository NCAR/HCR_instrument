----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/29/2018 04:18:48 PM
-- Design Name: 
-- Module Name: px_ads54j69intrfc - Behavioral
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

-- Memory Map
-- 0x00 - Control
-- 0x04 - Ch A Offset/Gain Trim 
-- 0x08 - Ch B Offset/Gain Trim 
-- 0x0C - ADC Serial Control
-- 0x10 - ADC Serial Status
-- 0x14 - Reserved
-- 0x18 - Reserved
-- 0x1C - Reserved
-- 0x20 - Interrupt Enables
-- 0x24 - Interrupt Status
-- 0x28 - Interrupt Flags
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
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity px_ads54j69intrfc is
generic (
   initial_a_gain_percent  : integer := 100;
   initial_a_offset_counts : integer := 0;
   initial_b_gain_percent  : integer := 100;
   initial_b_offset_counts : integer := 0;
   initial_pdwnf           : boolean := false;
   initial_led_select      : integer range 0 to 3 := 0;
   has_ext_led_src         : boolean := true;
   initial_ovld_thresh     : integer := 16;  -- counts from full scale
   led_pulse_stretch       : integer range 0 to 65535:= 65535 -- counts to pulse stretch LED
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
-- ADS54j69 ADC Input (output from JESD Core)
----------------------------------------------------------------------------
   s_axis_rx_aclk           : in std_logic; -- 125MHz for 500MHz sample rate
   s_axis_rx_tdata          : in std_logic_vector(127 downto 0);
   s_axis_rx_tvalid         : in std_logic;
   
   rx_syncb                 : in std_logic;
   sample_clk               : in std_logic; -- 250MHz for 500MHz sample rate

---------------------------------------------------------------------------- 
-- Control Outputs
----------------------------------------------------------------------------
   power_down               : out std_logic; -- ADC Power Down Control
   
   adc_reset                : out std_logic; -- ADC Reset  
   ovld_led_n               : out std_logic; -- overload LED drive
   ext_led_src0             : in  std_logic; -- optional ext. LED source in   
   ext_led_src1             : in  std_logic; -- optional ext. LED source in   
----------------------------------------------------------------------------
-- Output
----------------------------------------------------------------------------
   m_axis_cha_pd_tdata      : out std_logic_vector(31 downto 0); --CH A
   m_axis_cha_pd_tvalid     : out std_logic;
   m_axis_chb_pd_tdata      : out std_logic_vector(31 downto 0); --CH B
   m_axis_chb_pd_tvalid     : out std_logic

);

end px_ads54j69intrfc;

architecture Behavioral of px_ads54j69intrfc is

-------------------------------------------------------------------------------
-- Components
-------------------------------------------------------------------------------
-- B*(A+D) Rounded symetrically
-- B17 should be '0' to have a 16 bit unsigned multiplication factor
-- Latency = 4

component px_ads54j69intrfc_gainoffset
port (
    clk : in std_logic;
    a : in std_logic_vector(15 downto 0);
    b : in std_logic_vector(16 downto 0);
    d : in std_logic_vector(15 downto 0);
    p : out std_logic_vector(17 downto 0)
  );
end component;

component data_width_converter is
port (
  M_AXIS_0_tvalid : out STD_LOGIC;
  M_AXIS_0_tready : in STD_LOGIC;
  M_AXIS_0_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
  S_AXIS_0_tvalid : in STD_LOGIC;
  S_AXIS_0_tready : out STD_LOGIC;
  S_AXIS_0_tdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
  s_axis_aresetn_0 : in STD_LOGIC;
  m_axis_aresetn_0 : in STD_LOGIC;
  m_axis_aclk_0 : in STD_LOGIC;
  s_axis_aclk_0 : in STD_LOGIC
);
end component; 
   
-- Control/Status Registers
component px_ads54j69intrfc_csr
generic(
    initial_gain_a      : std_logic_vector(15 downto 0) := x"8000";  
    initial_offset_a    : std_logic_vector(15 downto 0) := x"0000";
    initial_gain_b      : std_logic_vector(15 downto 0) := x"8000";  
    initial_offset_b    : std_logic_vector(15 downto 0) := x"0000";  
    initial_pdwnf       : boolean := false; 
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
    gain_a                : out std_logic_vector(15 downto 0); 
    offset_a              : out std_logic_vector(15 downto 0);
    gain_b                : out std_logic_vector(15 downto 0); 
    offset_b              : out std_logic_vector(15 downto 0);
    ovld_thresh_cnt       : out std_logic_vector(15 downto 0);            
    led_sel               : out std_logic_vector(1 downto 0);
    pdwnf                 : out std_logic;    
    adc_reset             : out std_logic;

-------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------
    adc_overload_a        : in  std_logic;
    adc_overload_b        : in  std_logic;
    go_overload_a         : in  std_logic;
    go_overload_b         : in  std_logic
);
end component;

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------

constant cnst_initial_gain_a  : std_logic_vector(15 downto 0) := conv_std_logic_vector(integer((real(initial_a_gain_percent)/100.0) * 32768.0), 16);
constant cnst_initial_offset_a: std_logic_vector(15 downto 0) := conv_std_logic_vector(initial_a_offset_counts, 16);
constant cnst_initial_gain_b  : std_logic_vector(15 downto 0) := conv_std_logic_vector(integer((real(initial_b_gain_percent)/100.0) * 32768.0), 16);
constant cnst_initial_offset_b: std_logic_vector(15 downto 0) := conv_std_logic_vector(initial_b_offset_counts, 16);

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTERRUPT";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of sample_clk: SIGNAL is "xilinx.com:signal:clock:1.0 sample_clk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of sample_clk: SIGNAL is "ASSOCIATED_BUSIF m_axis_cha_pd:m_axis_chb_pd";
ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of s_axis_rx_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axis_rx_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_rx_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_rx";

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal b_data_in_a              : std_logic_vector(16 downto 0) := (others => '0');
signal b_data_in_b              : std_logic_vector(16 downto 0) := (others => '0');
signal d_data_in_a              : std_logic_vector(15 downto 0) := (others => '0');
signal d_data_in_b              : std_logic_vector(15 downto 0) := (others => '0');
signal t5_data_go_adc_a_upr     : std_logic_vector(17 downto 0) := (others => '0');
signal t5_data_go_adc_a_lwr     : std_logic_vector(17 downto 0) := (others => '0');
signal t5_data_go_adc_b_upr     : std_logic_vector(17 downto 0) := (others => '0');
signal t5_data_go_adc_b_lwr     : std_logic_vector(17 downto 0) := (others => '0');
signal t6_sat_data_a_upr        : std_logic_vector(15 downto 0) := (others => '0');
signal t6_sat_data_a_lwr        : std_logic_vector(15 downto 0) := (others => '0');
signal t6_sat_data_b_upr        : std_logic_vector(15 downto 0) := (others => '0');
signal t6_sat_data_b_lwr        : std_logic_vector(15 downto 0) := (others => '0');
signal t7_sat_data_a_upr        : std_logic_vector(15 downto 0) := (others => '0');
signal t7_sat_data_a_lwr        : std_logic_vector(15 downto 0) := (others => '0');
signal t7_sat_data_b_upr        : std_logic_vector(15 downto 0) := (others => '0');
signal t7_sat_data_b_lwr        : std_logic_vector(15 downto 0) := (others => '0');
signal t8_sat_data_a_upr        : std_logic_vector(15 downto 0) := (others => '0');
signal t8_sat_data_a_lwr        : std_logic_vector(15 downto 0) := (others => '0');
signal t8_sat_data_b_upr        : std_logic_vector(15 downto 0) := (others => '0');
signal t8_sat_data_b_lwr        : std_logic_vector(15 downto 0) := (others => '0');
signal t9_sat_data_a_upr        : std_logic_vector(15 downto 0) := (others => '0');
signal t9_sat_data_a_lwr        : std_logic_vector(15 downto 0) := (others => '0');
signal t9_sat_data_b_upr        : std_logic_vector(15 downto 0) := (others => '0');
signal t9_sat_data_b_lwr        : std_logic_vector(15 downto 0) := (others => '0');
signal ovld_thresh_p            : std_logic_vector(15 downto 0) := (others => '0');
signal ovld_thresh_n            : std_logic_vector(15 downto 0) := (others => '0');
signal ovld_sub_a_upr           : std_logic_vector(16 downto 0) := (others => '0');
signal ovld_sub_a_lwr           : std_logic_vector(16 downto 0) := (others => '0');
signal ovld_sub_b_upr           : std_logic_vector(16 downto 0) := (others => '0');
signal ovld_sub_b_lwr           : std_logic_vector(16 downto 0) := (others => '0');
signal go_ovld_sub_a_upr        : std_logic_vector(16 downto 0) := (others => '0');
signal go_ovld_sub_a_lwr        : std_logic_vector(16 downto 0) := (others => '0');
signal go_ovld_sub_b_upr        : std_logic_vector(16 downto 0) := (others => '0');
signal go_ovld_sub_b_lwr        : std_logic_vector(16 downto 0) := (others => '0');
signal adc_overload_a_upr       : std_logic := '0';
signal adc_overload_a_lwr       : std_logic := '0';
signal adc_overload_b_upr       : std_logic := '0';
signal adc_overload_b_lwr       : std_logic := '0';
signal go_overload_a_upr        : std_logic := '0';
signal go_overload_a_lwr        : std_logic := '0';
signal go_overload_b_upr        : std_logic := '0';
signal go_overload_b_lwr        : std_logic := '0';
signal adc_overload_ax          : std_logic := '0';
signal adc_overload_bx          : std_logic := '0';
signal go_overload_ax           : std_logic := '0';
signal go_overload_bx           : std_logic := '0';
signal led_lite                 : std_logic := '0';
signal pls_strch_cntr           : std_logic_vector(15 downto 0) := (others => '0');
signal gain_a                   : std_logic_vector(15 downto 0) := (others => '0');
signal gain_b                   : std_logic_vector(15 downto 0) := (others => '0');
signal offset_a                 : std_logic_vector(15 downto 0) := (others => '0');
signal offset_b                 : std_logic_vector(15 downto 0) := (others => '0');
signal ovld_thresh_cnt          : std_logic_vector(15 downto 0) := (others => '0');
signal led_sel                  : std_logic_vector(1 downto 0) := (others => '0'); 
signal gain_ax                  : std_logic_vector(15 downto 0) := (others => '0');
signal gain_bx                  : std_logic_vector(15 downto 0) := (others => '0');
signal offset_ax                : std_logic_vector(15 downto 0) := (others => '0');
signal offset_bx                : std_logic_vector(15 downto 0) := (others => '0');
signal ovld_thresh_cntx         : std_logic_vector(15 downto 0) := (others => '0');
signal int_delay                : std_logic_vector(1 downto 0) := (others => '0');
signal int_delayx               : std_logic_vector(1 downto 0) := (others => '0');
signal led_selx                 : std_logic_vector(1 downto 0) := (others => '0');
signal ctl_x                    : std_logic_vector(83 downto 0) := (others => '0');
signal ctl                      : std_logic_vector(83 downto 0) := (others => '0');
signal src_rcva                 : std_logic := '0';
signal src_senda                : std_logic := '0';
signal dest_reqa                : std_logic := '0';
signal t1_s_axi_csr_aresetn     : std_logic := '0';

signal s_axis_rx_tvalid_reg1    : std_logic;
signal s_axis_rx_tvalid_reg2    : std_logic;

signal adc_a_data               : std_logic_vector(63 downto 0) := (others => '0');
signal adc_b_data               : std_logic_vector(63 downto 0) := (others => '0');

signal dwidth_conv_in_data      : std_logic_vector(127 downto 0) := (others => '0');

signal dwidth_conv_in_data_reg1 : std_logic_vector(127 downto 0) := (others => '0');
signal dwidth_conv_in_data_reg2 : std_logic_vector(127 downto 0) := (others => '0');

signal adc_a_data_upr_dr        : std_logic_vector(15 downto 0) := (others => '0');
signal adc_a_data_lwr_dr        : std_logic_vector(15 downto 0) := (others => '0');
signal adc_b_data_upr_dr        : std_logic_vector(15 downto 0) := (others => '0');
signal adc_b_data_lwr_dr        : std_logic_vector(15 downto 0) := (others => '0');

signal t1_data_in_adc_a_upr     : std_logic_vector(15 downto 0) := (others => '0');
signal t1_data_in_adc_a_lwr     : std_logic_vector(15 downto 0) := (others => '0');
signal t1_data_in_adc_b_upr     : std_logic_vector(15 downto 0) := (others => '0');
signal t1_data_in_adc_b_lwr     : std_logic_vector(15 downto 0) := (others => '0');

signal dwidth_conv_out_data     : std_logic_vector(63 downto 0) := (others => '0');

signal adc_overload_a           : std_logic;
signal adc_overload_b           : std_logic;
signal go_overload_a            : std_logic;
signal go_overload_b            : std_logic;

--------------------------------------------------------------------------------

begin


process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
   end if;
end process;

--------------------------------------------------------------------------------
-- Data Reordering for compatibility to selected JESD Data Modes
--------------------------------------------------------------------------------

-- ADC Mode = 4222 or 4421

adc_a_data(15 downto 0)  <= s_axis_rx_tdata(39 downto 32)  & s_axis_rx_tdata(47 downto 40);
adc_a_data(31 downto 16) <= s_axis_rx_tdata(7 downto 0  )  & s_axis_rx_tdata(15 downto 8 );
adc_a_data(47 downto 32) <= s_axis_rx_tdata(55 downto 48)  & s_axis_rx_tdata(63 downto 56);
adc_a_data(63 downto 48) <= s_axis_rx_tdata(23 downto 16)  & s_axis_rx_tdata(31 downto 24);

adc_b_data(15 downto 0)  <= s_axis_rx_tdata(103 downto 96) & s_axis_rx_tdata(111 downto 104);
adc_b_data(31 downto 16) <= s_axis_rx_tdata(71 downto 64 ) & s_axis_rx_tdata(79  downto 72 );
adc_b_data(47 downto 32) <= s_axis_rx_tdata(119 downto 112)& s_axis_rx_tdata(127 downto 120);
adc_b_data(63 downto 48) <= s_axis_rx_tdata(87 downto 80 ) & s_axis_rx_tdata(95 downto 88);

dwidth_conv_in_data(127 downto 0) <= adc_b_data(31 downto 0) & adc_a_data(31 downto 0) & adc_b_data(63 downto 32) & adc_a_data(63 downto 32);

process(s_axis_rx_aclk) begin
    if(rising_edge(s_axis_rx_aclk)) then
        s_axis_rx_tvalid_reg1 <= s_axis_rx_tvalid;
        s_axis_rx_tvalid_reg2 <= s_axis_rx_tvalid_reg1; 
    
        dwidth_conv_in_data_reg1   <= dwidth_conv_in_data;
        dwidth_conv_in_data_reg2   <= dwidth_conv_in_data_reg1;
    
    end if;
end process;

data_width_converter_i: component data_width_converter
     port map (
      M_AXIS_0_tdata(63 downto 0) => dwidth_conv_out_data,
      M_AXIS_0_tready => rx_syncb,
      M_AXIS_0_tvalid => open,
      S_AXIS_0_tdata(127 downto 0) => dwidth_conv_in_data_reg2,
      S_AXIS_0_tready => open,
      S_AXIS_0_tvalid => s_axis_rx_tvalid_reg2,
      m_axis_aclk_0 => sample_clk,
      m_axis_aresetn_0 => rx_syncb,
      s_axis_aclk_0 => s_axis_rx_aclk,
      s_axis_aresetn_0 => rx_syncb
    );
	
adc_a_data_upr_dr <= dwidth_conv_out_data(31 downto 16);
adc_a_data_lwr_dr  <= dwidth_conv_out_data(15 downto 0);

adc_b_data_upr_dr <= dwidth_conv_out_data(63 downto 48);
adc_b_data_lwr_dr  <= dwidth_conv_out_data(47 downto 32);

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
t1_data_in_adc_a_upr <= adc_a_data_upr_dr;
t1_data_in_adc_a_lwr <= adc_a_data_lwr_dr;
b_data_in_a <= '0' & gain_a;
d_data_in_a <= offset_a; 

--  Upper samples
gainoffset_adc1_upr_inst : px_ads54j69intrfc_gainoffset
port map (
    clk => sample_clk,
    a   => t1_data_in_adc_a_upr,
    b   => b_data_in_a,
    d   => d_data_in_a,
    p   => t5_data_go_adc_a_upr
  );

--  Lower samples
gainoffset_adc1_lwr_inst : px_ads54j69intrfc_gainoffset
port map (
    clk => sample_clk,
    a   => t1_data_in_adc_a_lwr,
    b   => b_data_in_a,
    d   => d_data_in_a,
    p   => t5_data_go_adc_a_lwr
  );

--Channel B
t1_data_in_adc_b_upr <= adc_b_data_upr_dr;
t1_data_in_adc_b_lwr <= adc_b_data_lwr_dr;
b_data_in_b <= '0' & gain_b;
d_data_in_b <= offset_b; 

--  Upper samples
gainoffset_b_upr_inst : px_ads54j69intrfc_gainoffset
port map (
    clk => sample_clk,
    a   => t1_data_in_adc_b_upr,
    b   => b_data_in_b,
    d   => d_data_in_b,
    p   => t5_data_go_adc_b_upr
  );

--  Lower samples
gainoffset_b_lwr_inst : px_ads54j69intrfc_gainoffset
port map (
    clk => sample_clk,
    a   => t1_data_in_adc_b_lwr,
    b   => b_data_in_b,
    d   => d_data_in_b,
    p   => t5_data_go_adc_b_lwr
  );


-------------------------------------------------------------------------------
-- Saturation to 16-bit signed values
-------------------------------------------------------------------------------
--Channel A
--  Upper samples
process(sample_clk)
begin
   if rising_edge(sample_clk) then
     if (t5_data_go_adc_a_upr(17 downto 15) = "000") or (t5_data_go_adc_a_upr(17 downto 15) = "111") then
        t6_sat_data_a_upr <= t5_data_go_adc_a_upr(15 downto 0);
     elsif t5_data_go_adc_a_upr(17) = '1' then
        t6_sat_data_a_upr <= x"8000";
     else
        t6_sat_data_a_upr <= x"7FFF";
     end if;
   end if;
end process;

--  Lower samples
process(sample_clk)
begin
   if rising_edge(sample_clk) then
     if (t5_data_go_adc_a_lwr(17 downto 15) = "000") or (t5_data_go_adc_a_lwr(17 downto 15) = "111") then
        t6_sat_data_a_lwr <= t5_data_go_adc_a_lwr(15 downto 0);
     elsif t5_data_go_adc_a_lwr(17) = '1' then
        t6_sat_data_a_lwr <= x"8000";
     else
        t6_sat_data_a_lwr <= x"7FFF";
     end if;
   end if;
end process;

--Channel B
--  Upper samples
process(sample_clk)
begin
   if rising_edge(sample_clk) then
     if (t5_data_go_adc_b_upr(17 downto 15) = "000") or (t5_data_go_adc_b_upr(17 downto 15) = "111") then
        t6_sat_data_b_upr <= t5_data_go_adc_b_upr(15 downto 0);
     elsif t5_data_go_adc_b_upr(17) = '1' then
        t6_sat_data_b_upr <= x"8000";
     else
        t6_sat_data_b_upr <= x"7FFF";
     end if;
   end if;
end process;

--  Lower samples
process(sample_clk)
begin
   if rising_edge(sample_clk) then
     if (t5_data_go_adc_b_lwr(17 downto 15) = "000") or (t5_data_go_adc_b_lwr(17 downto 15) = "111") then
        t6_sat_data_b_lwr <= t5_data_go_adc_b_lwr(15 downto 0);
     elsif t5_data_go_adc_b_lwr(17) = '1' then
        t6_sat_data_b_lwr <= x"8000";
     else
        t6_sat_data_b_lwr <= x"7FFF";
     end if;
   end if;
end process;

-------------------------------------------------------------------------------
-- Varaiable Data Delay
-------------------------------------------------------------------------------
process(sample_clk)
begin
   if rising_edge(sample_clk) then
        t7_sat_data_a_upr <= t6_sat_data_a_upr;
        t7_sat_data_a_lwr <= t6_sat_data_a_lwr;
        t8_sat_data_a_upr <= t7_sat_data_a_upr;
        t8_sat_data_a_lwr <= t7_sat_data_a_lwr;
        t9_sat_data_a_upr <= t8_sat_data_a_upr; 
        t9_sat_data_a_lwr <= t8_sat_data_a_lwr; 
        t7_sat_data_b_upr <= t6_sat_data_b_upr;
        t7_sat_data_b_lwr <= t6_sat_data_b_lwr;
        t8_sat_data_b_upr <= t7_sat_data_b_upr;
        t8_sat_data_b_lwr <= t7_sat_data_b_lwr;
        t9_sat_data_b_upr <= t8_sat_data_b_upr; 
        t9_sat_data_b_lwr <= t8_sat_data_b_lwr; 
        case int_delay is
            when "00" =>
              m_axis_cha_pd_tdata(31 downto 16) <= t6_sat_data_a_upr; 
              m_axis_cha_pd_tdata(15 downto 0) <= t6_sat_data_a_lwr; 
              m_axis_chb_pd_tdata(31 downto 16) <= t6_sat_data_b_upr; 
              m_axis_chb_pd_tdata(15 downto 0) <= t6_sat_data_b_lwr; 
            when "01" =>
              m_axis_cha_pd_tdata(31 downto 16) <= t7_sat_data_a_upr; 
              m_axis_cha_pd_tdata(15 downto 0) <= t7_sat_data_a_lwr; 
              m_axis_chb_pd_tdata(31 downto 16) <= t7_sat_data_b_upr; 
              m_axis_chb_pd_tdata(15 downto 0) <= t7_sat_data_b_lwr; 
            when "10" =>
              m_axis_cha_pd_tdata(31 downto 16) <= t8_sat_data_a_upr; 
              m_axis_cha_pd_tdata(15 downto 0) <= t8_sat_data_a_lwr; 
              m_axis_chb_pd_tdata(31 downto 16) <= t8_sat_data_b_upr; 
              m_axis_chb_pd_tdata(15 downto 0) <= t8_sat_data_b_lwr; 
            when "11" =>
              m_axis_cha_pd_tdata(31 downto 16) <= t9_sat_data_a_upr; 
              m_axis_cha_pd_tdata(15 downto 0) <= t9_sat_data_a_lwr; 
              m_axis_chb_pd_tdata(31 downto 16) <= t9_sat_data_b_upr; 
              m_axis_chb_pd_tdata(15 downto 0) <= t9_sat_data_b_lwr; 
            when others =>
              m_axis_cha_pd_tdata(31 downto 16) <= t9_sat_data_a_upr; 
              m_axis_cha_pd_tdata(15 downto 0) <= t9_sat_data_a_lwr; 
              m_axis_chb_pd_tdata(31 downto 16) <= t9_sat_data_b_upr; 
              m_axis_chb_pd_tdata(15 downto 0) <= t9_sat_data_b_lwr; 
        end case;     
    end if;
end process;

m_axis_cha_pd_tvalid <= '1'; 
m_axis_chb_pd_tvalid <= '1'; 

-------------------------------------------------------------------------------
-- Overload Detection
-------------------------------------------------------------------------------

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      ovld_thresh_p <= x"7FFF" - ovld_thresh_cnt;
      ovld_thresh_n <= x"8000" + ovld_thresh_cnt;
   end if;     
end process;


-- Channel A
--  Upper samples
process(sample_clk)
begin
   if rising_edge(sample_clk) then
      if t1_data_in_adc_a_upr(15) = '0' then -- positive input
        ovld_sub_a_upr <= ('0' & ovld_thresh_p) - ('0' & t1_data_in_adc_a_upr);
      else -- negative input
        ovld_sub_a_upr <= ('0' & t1_data_in_adc_a_upr) - ('0' & ovld_thresh_n);
      end if;  
   end if;     
end process;

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      if t6_sat_data_a_upr(15) = '0' then -- positive input
        go_ovld_sub_a_upr <= ('0' & ovld_thresh_p) - ('0' & t6_sat_data_a_upr);
      else -- negative input
        go_ovld_sub_a_upr <= ('0' & t6_sat_data_a_upr) - ('0' & ovld_thresh_n);
      end if;  
   end if;     
end process;

adc_overload_a_upr <= ovld_sub_a_upr(16);    -- raw data saturation
go_overload_a_upr  <= go_ovld_sub_a_upr(16); -- raw data saturation

--  Odd samples
process(sample_clk)
begin
   if rising_edge(sample_clk) then
      if t1_data_in_adc_a_lwr(15) = '0' then -- positive input
        ovld_sub_a_lwr <= ('0' & ovld_thresh_p) - ('0' & t1_data_in_adc_a_lwr);
      else -- negative input
        ovld_sub_a_lwr <= ('0' & t1_data_in_adc_a_lwr) - ('0' & ovld_thresh_n);
      end if;  
   end if;     
end process;

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      if t6_sat_data_a_lwr(15) = '0' then -- positive input
        go_ovld_sub_a_lwr <= ('0' & ovld_thresh_p) - ('0' & t6_sat_data_a_lwr);
      else -- negative input
        go_ovld_sub_a_lwr <= ('0' & t6_sat_data_a_lwr) - ('0' & ovld_thresh_n);
      end if;  
   end if;     
end process;

adc_overload_a_lwr <= ovld_sub_a_lwr(16);    -- raw data saturation
go_overload_a_lwr  <= go_ovld_sub_a_lwr(16); -- raw data saturation

--Channel B
--  Upper samples
process(sample_clk)
begin
   if rising_edge(sample_clk) then
      if t1_data_in_adc_b_upr(15) = '0' then -- positive input
        ovld_sub_b_upr <= ('0' & ovld_thresh_p) - ('0' & t1_data_in_adc_b_upr);
      else -- negative input
        ovld_sub_b_upr <= ('0' & t1_data_in_adc_b_upr) - ('0' & ovld_thresh_n);
      end if;  
   end if;     
end process;

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      if t6_sat_data_b_upr(15) = '0' then -- positive input
        go_ovld_sub_b_upr <= ('0' & ovld_thresh_p) - ('0' & t6_sat_data_b_upr);
      else -- negative input
        go_ovld_sub_b_upr <= ('0' & t6_sat_data_b_upr) - ('0' & ovld_thresh_n);
      end if;  
   end if;     
end process;

adc_overload_b_upr <= ovld_sub_b_upr(16);    -- raw data saturation
go_overload_b_upr  <= go_ovld_sub_b_upr(16); -- raw data saturation

--  Odd samples
process(sample_clk)
begin
   if rising_edge(sample_clk) then
      if t1_data_in_adc_b_lwr(15) = '0' then -- positive input
        ovld_sub_b_lwr <= ('0' & ovld_thresh_p) - ('0' & t1_data_in_adc_b_lwr);
      else -- negative input
        ovld_sub_b_lwr <= ('0' & t1_data_in_adc_b_lwr) - ('0' & ovld_thresh_n);
      end if;  
   end if;     
end process;

process(sample_clk)
begin
   if rising_edge(sample_clk) then
      if t6_sat_data_b_lwr(15) = '0' then -- positive input
        go_ovld_sub_b_lwr <= ('0' & ovld_thresh_p) - ('0' & t6_sat_data_b_lwr);
      else -- negative input
        go_ovld_sub_b_lwr <= ('0' & t6_sat_data_b_lwr) - ('0' & ovld_thresh_n);
      end if;  
   end if;     
end process;

adc_overload_b_lwr <= ovld_sub_b_lwr(16);    -- raw data saturation
go_overload_b_lwr  <= go_ovld_sub_b_lwr(16); -- raw data saturation

adc_overload_a      <= (adc_overload_a_upr or adc_overload_a_lwr);
adc_overload_b      <= (adc_overload_b_upr or adc_overload_b_lwr);
go_overload_a  <= (go_overload_a_upr or go_overload_a_lwr);
go_overload_b  <= (go_overload_b_upr or go_overload_b_lwr);

--------------------------------------------------------------------------------
-- LED Drive
--------------------------------------------------------------------------------

led_lite <= (adc_overload_a_upr or adc_overload_a_lwr or adc_overload_b_upr or adc_overload_b_lwr) when (led_sel = "00") else
            (go_overload_a_upr or go_overload_a_lwr or go_overload_b_upr or go_overload_b_lwr)  when (led_sel = "01") else
            (ext_led_src0 or ext_led_src1)  when (led_sel = "10") else '0';

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
csr_inst: px_ads54j69intrfc_csr
generic map(
    initial_gain_a      => cnst_initial_gain_a,       
    initial_gain_b      => cnst_initial_gain_b,       
    initial_offset_a    => cnst_initial_offset_a,     
    initial_offset_b    => cnst_initial_offset_b,     
    initial_pdwnf       => initial_pdwnf,     
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
    gain_a                  => gain_ax,                 
    gain_b                  => gain_bx,                 
    offset_a                => offset_ax, 
    offset_b                => offset_bx, 
    ovld_thresh_cnt         => ovld_thresh_cntx,                
    led_sel                 => led_selx,
    pdwnf                   => power_down, -- power down
    adc_reset               => adc_reset,

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

end Behavioral;

