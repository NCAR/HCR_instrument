----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 02/05/2018 08:48:35 AM
-- Design Name: ox_rf_adc_cntl_stat.vhd
-- Module Name: px_rf_adc_cntl_stat - Behavioral
-- Project Name: 
-- Target Devices: Zynq Untrascale+ RFSOC
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 1.2 - Added control bit to select AXIS clock source (ADC CLKOUT or EXTERNAL AXIS CLK)
-- Revision 2.0 - Added the ability to have a maximum bus width of 1,2,4, or 8 samples per cycle and to have real only bus.
-- Additional Comments:
-- 
-- Register Map

-- 0x00 Cal Freeze Control
   -- Bit [0] - ADC0 cal freeze
   -- Bit [1] - ADC1 cal freeze
   -- Bit [2] - ADC2 cal freeze
   -- Bit [3] - ADC3 cal freeze
   -- Bit [4] - ADC4 cal freeze
   -- Bit [5] - ADC5 cal freeze
   -- Bit [6] - ADC6 cal freeze
   -- Bit [7] - ADC7 cal freeze
   -- Bit [8] - ADC0 auto cal freeze
   -- Bit [9] - ADC1 auto cal freeze
   -- Bit [10]- ADC2 auto cal freeze
   -- Bit [11]- ADC3 auto cal freeze 
   -- Bit [12]- ADC4 auto cal freeze
   -- Bit [13]- ADC5 auto cal freeze
   -- Bit [14]- ADC6 auto cal freeze
   -- Bit [15]- ADC7 auto cal freeze 
   -- Bit [16]    - ADC01 ddc_mode
   -- Bit [18:17] - ADC01 dec
   -- Bit [19]    - ADC23 ddc_mode
   -- Bit [21:20] - ADC23 dec
   -- Bit [22]    - ADC45 ddc_mode
   -- Bit [24:23] - ADC45 dec
   -- Bit [25]    - ADC67 ddc_mode
   -- Bit [27:26] - ADC67 dec
-- 0x04 PL Event Reg Pulse
   -- Bit [0] Pulse 
-- 0x08 PL Event Enables
   -- Bit [0] - adc0_01_pl_event
   -- Bit [1] - adc0_23_pl_event
   -- Bit [2] - adc1_01_pl_event
   -- Bit [3] - adc1_23_pl_event
   -- Bit [4] - adc2_01_pl_event
   -- Bit [5] - adc2_23_pl_event
   -- Bit [6] - adc3_01_pl_event
   -- Bit [7] - adc3_23_pl_event
   -- Bit [9:8] - Select Reg Pulse 00 = off 01 = Reg Pulse 10 = External Pulse 11 = SYNC 

-- 0x0C  ADC Clock Domain Control Register 
   -- Bit [0] - ADC Clock Domain Manual Reset
   -- Bit [1] - ADC AXIS Clock Source Select  0 = ADC CLKOUT  1 = EXTERNAL AXIS CLK INPUT
                    
-- 0x10 Cal Freeze Status
   -- Bit [0] - ADC0 01 cal freeze
   -- Bit [1] - ADC0 23 cal freeze
   -- Bit [2] - ADC1 01 cal freeze
   -- Bit [3] - ADC1 23 cal freeze
   -- Bit [4] - ADC2 01 cal freeze
   -- Bit [5] - ADC2 23 cal freeze
   -- Bit [6] - ADC3 01 cal freeze
   -- Bit [7] - ADC3 23 cal freeze
-- 0x14 tvalid Status
   -- Bit [0] - ADC0 tvalid
   -- Bit [1] - ADC1 tvalid
   -- Bit [2] - ADC2 tvalid
   -- Bit [3] - ADC3 tvalid
   -- Bit [4] - ADC4 tvalid
   -- Bit [5] - ADC5 tvalid
   -- Bit [6] - ADC6 tvalid
   -- Bit [7] - ADC7 tvalid
-- 0x18 Reserved
-- 0x1C Reserved   
-- 0x20 Interrupt Enables
   -- adc0_01_over_range
   -- adc0_01_over_threshold1
   -- adc0_01_over_threshold2
   -- adc0_01_over_voltage
   -- adc0_23_over_range
   -- adc0_23_over_threshold1
   -- adc0_23_over_threshold2
   -- adc0_23_over_voltage
   -- adc1_01_over_range
   -- adc1_01_over_threshold1
   -- adc1_01_over_threshold2
   -- adc1_01_over_voltage
   -- adc1_23_over_range
   -- adc1_23_over_threshold1
   -- adc1_23_over_threshold2
   -- adc1_23_over_voltage
   -- adc2_01_over_range
   -- adc2_01_over_threshold1
   -- adc2_01_over_threshold2
   -- adc2_01_over_voltage
   -- adc2_23_over_range
   -- adc2_23_over_threshold1
   -- adc2_23_over_threshold2
   -- adc2_23_over_voltage
   -- adc3_01_over_range
   -- adc3_01_over_threshold1
   -- adc3_01_over_threshold2
   -- adc3_01_over_voltage
   -- adc3_23_over_range
   -- adc3_23_over_threshold1
   -- adc3_23_over_threshold2
   -- adc3_23_over_voltage
-- 0x24 Interrupt Status
-- 0x28 Interrupt Flags

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
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
use ieee.numeric_std.ALL;
Library xpm;
use xpm.vcomponents.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_rf_adc_cntl_stat is
generic (
   inv_data : boolean := false;
   has_adc0 : boolean := true;
   has_adc1 : boolean := true;
   has_adc2 : boolean := true;
   has_adc3 : boolean := true;
   has_adc4 : boolean := true;
   has_adc5 : boolean := true;
   has_adc6 : boolean := true;
   has_adc7 : boolean := true;
   en_adc01_rts : boolean := true;
   en_adc23_rts : boolean := true;
   en_adc45_rts : boolean := true;
   en_adc67_rts : boolean := true;
   en_adc01_frz : boolean := true;
   en_adc23_frz : boolean := true;
   en_adc45_frz : boolean := true;
   en_adc67_frz : boolean := true;
   has_pl_event_in: boolean := true;
   en_adc0_thresh_outputs: boolean := true;
   en_adc1_thresh_outputs: boolean := true;
   en_adc2_thresh_outputs: boolean := true;
   en_adc3_thresh_outputs: boolean := true;
   en_adc4_thresh_outputs: boolean := true;
   en_adc5_thresh_outputs: boolean := true;
   en_adc6_thresh_outputs: boolean := true;
   en_adc7_thresh_outputs: boolean := true;
   max_samples_per_cycle: integer := 8; -- 1,2,4,or 8. For multi decimation support, set to 8. 
   real_only: boolean := false
);
port (
   adc_aclk                 : in  std_logic;
   s_axis_ptctl_tdata       : in  std_logic_vector(31 downto 0);
   s_axis_ptctl_tvalid      : in  std_logic;       
   pl_event_in              : in  std_logic; 
   ----------------------------------------------------------------------------
   -- Control/Status Registers (AXI4-LITE)
   ----------------------------------------------------------------------------
   -- associated with s_axi_csr_aclk
   s_axi_csr_aclk           : in  std_logic;
   s_axi_csr_aresetn        : in  std_logic;
   s_axi_csr_awaddr         : in  std_logic_vector(11 downto 0);
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
   s_axi_csr_araddr         : in  std_logic_vector(11 downto 0);
   s_axi_csr_arprot         : in  std_logic_vector(2 downto 0);
   s_axi_csr_arvalid        : in  std_logic;
   s_axi_csr_arready        : out std_logic;
   s_axi_csr_rdata          : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp          : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid         : out std_logic;
   s_axi_csr_rready         : in  std_logic;
   
   irq                      : out std_logic; -- Interrupt out
   -----------------------------------------------------------------------------
   -- ADC Channels In
   -----------------------------------------------------------------------------
   s_axis_adc0_i_tdata      : in std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   s_axis_adc0_i_tvalid     : in std_logic;
   s_axis_adc0_i_tready     : out std_logic;
   s_axis_adc0_q_tdata      : in std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   s_axis_adc0_q_tvalid     : in std_logic;
   s_axis_adc0_q_tready     : out std_logic;
   s_axis_adc1_i_tdata      : in std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   s_axis_adc1_i_tvalid     : in std_logic;
   s_axis_adc1_i_tready     : out std_logic;
   s_axis_adc1_q_tdata      : in std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   s_axis_adc1_q_tvalid     : in std_logic;
   s_axis_adc1_q_tready     : out std_logic;
   s_axis_adc2_i_tdata      : in std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   s_axis_adc2_i_tvalid     : in std_logic;
   s_axis_adc2_i_tready     : out std_logic;
   s_axis_adc2_q_tdata      : in std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   s_axis_adc2_q_tvalid     : in std_logic;
   s_axis_adc2_q_tready     : out std_logic;
   s_axis_adc3_i_tdata      : in std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   s_axis_adc3_i_tvalid     : in std_logic;
   s_axis_adc3_i_tready     : out std_logic;
   s_axis_adc3_q_tdata      : in std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   s_axis_adc3_q_tvalid     : in std_logic;
   s_axis_adc3_q_tready     : out std_logic;
   s_axis_adc4_i_tdata      : in std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   s_axis_adc4_i_tvalid     : in std_logic;
   s_axis_adc4_i_tready     : out std_logic;
   s_axis_adc4_q_tdata      : in std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   s_axis_adc4_q_tvalid     : in std_logic;
   s_axis_adc4_q_tready     : out std_logic;
   s_axis_adc5_i_tdata      : in std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   s_axis_adc5_i_tvalid     : in std_logic;
   s_axis_adc5_i_tready     : out std_logic;
   s_axis_adc5_q_tdata      : in std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   s_axis_adc5_q_tvalid     : in std_logic;
   s_axis_adc5_q_tready     : out std_logic;
   s_axis_adc6_i_tdata      : in std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   s_axis_adc6_i_tvalid     : in std_logic;
   s_axis_adc6_i_tready     : out std_logic;
   s_axis_adc6_q_tdata      : in std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   s_axis_adc6_q_tvalid     : in std_logic;
   s_axis_adc6_q_tready     : out std_logic;
   s_axis_adc7_i_tdata      : in std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   s_axis_adc7_i_tvalid     : in std_logic;
   s_axis_adc7_i_tready     : out std_logic;
   s_axis_adc7_q_tdata      : in std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   s_axis_adc7_q_tvalid     : in std_logic;
   s_axis_adc7_q_tready     : out std_logic;
   -----------------------------------------------------------------------------
   -- ADC Channels Out
   -----------------------------------------------------------------------------
   m_axis_adc0_i_tdata      : out std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   m_axis_adc0_i_tvalid     : out std_logic;
   m_axis_adc0_q_tdata      : out std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   m_axis_adc0_q_tvalid     : out std_logic;
   m_axis_adc1_i_tdata      : out std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   m_axis_adc1_i_tvalid     : out std_logic;
   m_axis_adc1_q_tdata      : out std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   m_axis_adc1_q_tvalid     : out std_logic;
   m_axis_adc2_i_tdata      : out std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   m_axis_adc2_i_tvalid     : out std_logic;
   m_axis_adc2_q_tdata      : out std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   m_axis_adc2_q_tvalid     : out std_logic;
   m_axis_adc3_i_tdata      : out std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   m_axis_adc3_i_tvalid     : out std_logic;
   m_axis_adc3_q_tdata      : out std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   m_axis_adc3_q_tvalid     : out std_logic;
   m_axis_adc4_i_tdata      : out std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   m_axis_adc4_i_tvalid     : out std_logic;
   m_axis_adc4_q_tdata      : out std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   m_axis_adc4_q_tvalid     : out std_logic;
   m_axis_adc5_i_tdata      : out std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   m_axis_adc5_i_tvalid     : out std_logic;
   m_axis_adc5_q_tdata      : out std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   m_axis_adc5_q_tvalid     : out std_logic;
   m_axis_adc6_i_tdata      : out std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   m_axis_adc6_i_tvalid     : out std_logic;
   m_axis_adc6_q_tdata      : out std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   m_axis_adc6_q_tvalid     : out std_logic;
   m_axis_adc7_i_tdata      : out std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   m_axis_adc7_i_tvalid     : out std_logic;
   m_axis_adc7_q_tdata      : out std_logic_vector((16*max_samples_per_cycle)-1 downto 0);
   m_axis_adc7_q_tvalid     : out std_logic;     
   -----------------------------------------------------------------------------
   -- Calibration Control/Status
   -----------------------------------------------------------------------------
   adc0_01_cal_frozen : in std_logic;
   adc0_01_int_cal_freeze : out std_logic;
   adc0_23_cal_frozen : in std_logic;
   adc0_23_int_cal_freeze : out std_logic;
   adc1_01_cal_frozen : in std_logic;
   adc1_01_int_cal_freeze : out std_logic;
   adc1_23_cal_frozen : in std_logic;
   adc1_23_int_cal_freeze : out std_logic;
   adc2_01_cal_frozen : in std_logic;
   adc2_01_int_cal_freeze : out std_logic;
   adc2_23_cal_frozen : in std_logic;
   adc2_23_int_cal_freeze : out std_logic;
   adc3_01_cal_frozen : in std_logic;
   adc3_01_int_cal_freeze : out std_logic;
   adc3_23_cal_frozen : in std_logic;
   adc3_23_int_cal_freeze : out std_logic;
   -----------------------------------------------------------------------------
   -- RTS
   -----------------------------------------------------------------------------
   -- ADC0
   adc00_pl_event : out std_logic;
   adc01_pl_event : out std_logic;
   adc0_01_over_range  : in std_logic;
   adc0_01_over_threshold1  : in std_logic;
   adc0_01_over_threshold2  : in std_logic;
   adc0_01_over_voltage   : in std_logic;
   adc02_pl_event : out std_logic;
   adc03_pl_event : out std_logic;
   adc0_23_over_range  : in std_logic;
   adc0_23_over_threshold1  : in std_logic;
   adc0_23_over_threshold2  : in std_logic;
   adc0_23_over_voltage   : in std_logic;
   -- ADC1
   adc10_pl_event : out std_logic;
   adc11_pl_event : out std_logic;
   adc1_01_over_range  : in std_logic;
   adc1_01_over_threshold1  : in std_logic;
   adc1_01_over_threshold2  : in std_logic;
   adc1_01_over_voltage   : in std_logic;
   adc12_pl_event : out std_logic;
   adc13_pl_event : out std_logic;
   adc1_23_over_range  : in std_logic;
   adc1_23_over_threshold1  : in std_logic;
   adc1_23_over_threshold2  : in std_logic;
   adc1_23_over_voltage   : in std_logic;
   -- ADC2
   adc20_pl_event : out std_logic;
   adc21_pl_event : out std_logic;
   adc2_01_over_range  : in std_logic;
   adc2_01_over_threshold1  : in std_logic;
   adc2_01_over_threshold2  : in std_logic;
   adc2_01_over_voltage   : in std_logic;
   adc22_pl_event : out std_logic;
   adc23_pl_event : out std_logic;
   adc2_23_over_range  : in std_logic;
   adc2_23_over_threshold1  : in std_logic;
   adc2_23_over_threshold2  : in std_logic;
   adc2_23_over_voltage   : in std_logic;
   -- ADC3
   adc30_pl_event : out std_logic;
   adc31_pl_event : out std_logic;
   adc3_01_over_range  : in std_logic;
   adc3_01_over_threshold1  : in std_logic;
   adc3_01_over_threshold2  : in std_logic;
   adc3_01_over_voltage   : in std_logic;
   adc32_pl_event : out std_logic;
   adc33_pl_event : out std_logic;
   adc3_23_over_range  : in std_logic;
   adc3_23_over_threshold1  : in std_logic;
   adc3_23_over_threshold2  : in std_logic;
   adc3_23_over_voltage   : in std_logic;
   ----------------------------------------------------
   -- Outputs
   ----------------------------------------------------
   adc0_01_over_range_out       : out std_logic;
   adc0_01_over_threshold1_out  : out std_logic;
   adc0_01_over_threshold2_out  : out std_logic;
   adc0_01_over_voltage_out     : out std_logic;
   adc0_23_over_range_out       : out std_logic;
   adc0_23_over_threshold1_out  : out std_logic;
   adc0_23_over_threshold2_out  : out std_logic;
   adc0_23_over_voltage_out     : out std_logic;
   adc1_01_over_range_out       : out std_logic;
   adc1_01_over_threshold1_out  : out std_logic;
   adc1_01_over_threshold2_out  : out std_logic;
   adc1_01_over_voltage_out     : out std_logic;
   adc1_23_over_range_out       : out std_logic;
   adc1_23_over_threshold1_out  : out std_logic;
   adc1_23_over_threshold2_out  : out std_logic;
   adc1_23_over_voltage_out     : out std_logic;
   adc2_01_over_range_out       : out std_logic;
   adc2_01_over_threshold1_out  : out std_logic;
   adc2_01_over_threshold2_out  : out std_logic;
   adc2_01_over_voltage_out     : out std_logic;
   adc2_23_over_range_out       : out std_logic;
   adc2_23_over_threshold1_out  : out std_logic;
   adc2_23_over_threshold2_out  : out std_logic;
   adc2_23_over_voltage_out     : out std_logic;
   adc3_01_over_range_out       : out std_logic;
   adc3_01_over_threshold1_out  : out std_logic;
   adc3_01_over_threshold2_out  : out std_logic;
   adc3_01_over_voltage_out     : out std_logic;
   adc3_23_over_range_out       : out std_logic;
   adc3_23_over_threshold1_out  : out std_logic;
   adc3_23_over_threshold2_out  : out std_logic;
   adc3_23_over_voltage_out     : out std_logic;
   pl_event_out                 : out std_logic;
   rf_adc_clk_domain_man_rstn   : out std_logic;
   mmcm_clk_src_sel             : out std_logic
   );
end px_rf_adc_cntl_stat;

architecture Behavioral of px_rf_adc_cntl_stat is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

COMPONENT px_rf_adc_cntl_stat_csr
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
    stat1_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat2_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat3_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    intrpt_src_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    irq : OUT STD_LOGIC
  );
END COMPONENT;

-- 8-bit CDC
COMPONENT px_rf_adc_cntl_stat_cdc8
  PORT (
    src_clk : IN STD_LOGIC;
    src_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    dest_clk : IN STD_LOGIC;
    dest_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
end component;

COMPONENT px_rf_adc_cntl_stat_cdcpls
  PORT (
    src_clk : IN STD_LOGIC;
    src_rst : IN STD_LOGIC;
    src_pulse : IN STD_LOGIC;
    dest_clk : IN STD_LOGIC;
    dest_rst : IN STD_LOGIC;
    dest_pulse : OUT STD_LOGIC
  );
END COMPONENT;

component adc_frz_calc 
    Generic (
        max_samples_per_cycle: integer := 8;
        real_only: boolean := false
    );
    Port ( clk       : in STD_LOGIC;
           rst_n     : in STD_LOGIC;
           adc_i     : in STD_LOGIC_VECTOR ((16*max_samples_per_cycle)-1 downto 0);
           adc_q     : in STD_LOGIC_VECTOR ((16*max_samples_per_cycle)-1 downto 0);
           adc_dval  : in STD_LOGIC;
           enable    : in STD_LOGIC;
           ddc_mode  : in STD_LOGIC;
           dec       : in STD_LOGIC_VECTOR (1 downto 0);
           freeze_manual: in STD_LOGIC;
           freeze    : out STD_LOGIC
           );
end component;

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTERRUPT";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of rf_adc_clk_domain_man_rstn: SIGNAL is "xilinx.com:signal:reset:1.0 rf_adc_clk_domain_man_rstn RST";
ATTRIBUTE X_INTERFACE_PARAMETER of rf_adc_clk_domain_man_rstn: SIGNAL is "POLARITY ACTIVE_LOW";

ATTRIBUTE X_INTERFACE_INFO of adc_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 adc_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of adc_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_ptctl:s_axis_adc0_i:s_axis_adc0_q:s_axis_adc1_i:s_axis_adc1_q:s_axis_adc2_i:s_axis_adc2_q:s_axis_adc3_i:s_axis_adc3_q:s_axis_adc4_i:s_axis_adc4_q:s_axis_adc5_i:s_axis_adc5_q:s_axis_adc6_i:s_axis_adc6_q:s_axis_adc7_i:s_axis_adc7_q:m_axis_adc0_i:m_axis_adc0_q:m_axis_adc1_i:m_axis_adc1_q:m_axis_adc2_i:m_axis_adc2_q:m_axis_adc3_i:m_axis_adc3_q:m_axis_adc4_i:m_axis_adc4_q:m_axis_adc5_i:m_axis_adc5_q:m_axis_adc6_i:m_axis_adc6_q:m_axis_adc7_i:m_axis_adc7_q, ASSOCIATED_RESET rf_adc_clk_domain_man_rstn";

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

type adc_vctr is array (0 to 7) of std_logic_vector((16*max_samples_per_cycle)-1 downto 0);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------
signal adc_i : adc_vctr;
signal adc_q : adc_vctr;
signal frz_stat : std_logic_vector(7 downto 0) := x"00";
signal x_frz_stat : std_logic_vector(7 downto 0) := x"00";
signal x_intrpt_src: std_logic_vector(31 downto 0) := x"00000000";
signal intrpt_src: std_logic_vector(31 downto 0) := x"00000000";
signal ctl0_out: std_logic_vector(31 downto 0) := x"00000000";
signal ctl1_out: std_logic_vector(31 downto 0) := x"00000000";
signal ctl2_out: std_logic_vector(31 downto 0) := x"00000000";
signal ctl3_out: std_logic_vector(31 downto 0) := x"00000000";
signal frz_cntl: std_logic_vector(7 downto 0) := x"00";
signal stat0_in: std_logic_vector(31 downto 0) := x"00000000";
signal t1_s_axi_csr_aresetn: std_logic:= '0';
signal s_axi_csr_areset: std_logic:= '0';
signal x_ctl2a: std_logic_vector(7 downto 0) := x"00";
signal x_ctl2b: std_logic_vector(7 downto 0) := x"00";
signal x_reg_pls: std_logic:= '0';
signal t1_pl_event: std_logic:= '0';
signal t1_s_axis_ptctl_tdata: std_logic_vector(31 downto 0) := x"00000000";
signal t2_sync: std_logic:= '0';
signal stat1_in: std_logic_vector(31 downto 0) := x"00000000";
signal adc_tvalidx: std_logic_vector(7 downto 0) := x"00";
signal arstn: std_logic:= '0';
signal adc_tvalid: std_logic_vector(7 downto 0) := (others => '0');
signal t1_axis_adc0_i_tdata      : std_logic_vector((16*max_samples_per_cycle)-1 downto 0);         
signal t1_axis_adc0_q_tdata      : std_logic_vector((16*max_samples_per_cycle)-1 downto 0);         
signal t1_axis_adc0_i_tvalid       : std_logic;  
signal t1_axis_adc0_q_tvalid       : std_logic;                               
signal t1_axis_adc1_i_tdata      : std_logic_vector((16*max_samples_per_cycle)-1 downto 0);         
signal t1_axis_adc1_q_tdata      : std_logic_vector((16*max_samples_per_cycle)-1 downto 0);         
signal t1_axis_adc1_i_tvalid       : std_logic;     
signal t1_axis_adc1_q_tvalid       : std_logic;                           
signal t1_axis_adc2_i_tdata      : std_logic_vector((16*max_samples_per_cycle)-1 downto 0);         
signal t1_axis_adc2_q_tdata      : std_logic_vector((16*max_samples_per_cycle)-1 downto 0);         
signal t1_axis_adc2_i_tvalid       : std_logic;    
signal t1_axis_adc2_q_tvalid       : std_logic;                             
signal t1_axis_adc3_i_tdata      : std_logic_vector((16*max_samples_per_cycle)-1 downto 0);         
signal t1_axis_adc3_q_tdata      : std_logic_vector((16*max_samples_per_cycle)-1 downto 0);         
signal t1_axis_adc3_i_tvalid       : std_logic;      
signal t1_axis_adc3_q_tvalid       : std_logic;                           
signal t1_axis_adc4_i_tdata      : std_logic_vector((16*max_samples_per_cycle)-1 downto 0);         
signal t1_axis_adc4_q_tdata      : std_logic_vector((16*max_samples_per_cycle)-1 downto 0);         
signal t1_axis_adc4_i_tvalid       : std_logic;    
signal t1_axis_adc4_q_tvalid       : std_logic;                             
signal t1_axis_adc5_i_tdata      : std_logic_vector((16*max_samples_per_cycle)-1 downto 0);         
signal t1_axis_adc5_q_tdata      : std_logic_vector((16*max_samples_per_cycle)-1 downto 0);         
signal t1_axis_adc5_i_tvalid       : std_logic;          
signal t1_axis_adc5_q_tvalid       : std_logic;                       
signal t1_axis_adc6_i_tdata      : std_logic_vector((16*max_samples_per_cycle)-1 downto 0);         
signal t1_axis_adc6_q_tdata      : std_logic_vector((16*max_samples_per_cycle)-1 downto 0);         
signal t1_axis_adc6_i_tvalid       : std_logic;    
signal t1_axis_adc6_q_tvalid       : std_logic;                           
signal t1_axis_adc7_i_tdata      : std_logic_vector((16*max_samples_per_cycle)-1 downto 0);         
signal t1_axis_adc7_q_tdata      : std_logic_vector((16*max_samples_per_cycle)-1 downto 0);         
signal t1_axis_adc7_i_tvalid       : std_logic := '0'; 
signal t1_axis_adc7_q_tvalid       : std_logic := '0';                             
signal freeze_manual             : std_logic_vector(7 downto 0) := x"00";
signal auto_freeze_en            : std_logic_vector(7 downto 0) := x"00";
signal ddc_mode                  : std_logic_vector(7 downto 0) := x"00"; 
signal dec                       : std_logic_vector(15 downto 0) := x"0000";
signal dmode                     : std_logic_vector(15 downto 0) := x"0000";
signal cval                      : std_logic_vector(23 downto 0) := x"000000";
signal ctl2a                     : std_logic_vector(7 downto 0) := x"00";
--------------------------------------------------------------------------------

begin

s_axis_adc0_i_tready <= '1';
s_axis_adc0_q_tready <= '1';
s_axis_adc1_i_tready <= '1';
s_axis_adc1_q_tready <= '1';
s_axis_adc2_i_tready <= '1';
s_axis_adc2_q_tready <= '1';
s_axis_adc3_i_tready <= '1';
s_axis_adc3_q_tready <= '1';
s_axis_adc4_i_tready <= '1';
s_axis_adc4_q_tready <= '1';
s_axis_adc5_i_tready <= '1';
s_axis_adc5_q_tready <= '1';
s_axis_adc6_i_tready <= '1';
s_axis_adc6_q_tready <= '1';
s_axis_adc7_i_tready <= '1';
s_axis_adc7_q_tready <= '1';

process(adc_aclk)
begin
   if rising_edge(adc_aclk) then
     t1_axis_adc0_i_tdata  <= s_axis_adc0_i_tdata ;
     t1_axis_adc0_q_tdata  <= s_axis_adc0_q_tdata ;
     t1_axis_adc0_i_tvalid <= s_axis_adc0_i_tvalid;
     t1_axis_adc0_q_tvalid <= s_axis_adc0_q_tvalid;
     t1_axis_adc1_i_tdata  <= s_axis_adc1_i_tdata ;
     t1_axis_adc1_q_tdata  <= s_axis_adc1_q_tdata ;
     t1_axis_adc1_i_tvalid <= s_axis_adc1_i_tvalid;
     t1_axis_adc1_q_tvalid <= s_axis_adc1_q_tvalid;
     t1_axis_adc2_i_tdata  <= s_axis_adc2_i_tdata ;
     t1_axis_adc2_q_tdata  <= s_axis_adc2_q_tdata ;
     t1_axis_adc2_i_tvalid <= s_axis_adc2_i_tvalid;
     t1_axis_adc2_q_tvalid <= s_axis_adc2_q_tvalid;
     t1_axis_adc3_i_tdata  <= s_axis_adc3_i_tdata ;
     t1_axis_adc3_q_tdata  <= s_axis_adc3_q_tdata ;
     t1_axis_adc3_i_tvalid <= s_axis_adc3_i_tvalid;
     t1_axis_adc3_q_tvalid <= s_axis_adc3_q_tvalid;
     t1_axis_adc4_i_tdata  <= s_axis_adc4_i_tdata ;
     t1_axis_adc4_q_tdata  <= s_axis_adc4_q_tdata ;
     t1_axis_adc4_i_tvalid <= s_axis_adc4_i_tvalid;
     t1_axis_adc4_q_tvalid <= s_axis_adc4_q_tvalid;
     t1_axis_adc5_i_tdata  <= s_axis_adc5_i_tdata ;
     t1_axis_adc5_q_tdata  <= s_axis_adc5_q_tdata ;
     t1_axis_adc5_i_tvalid <= s_axis_adc5_i_tvalid;
     t1_axis_adc5_q_tvalid <= s_axis_adc5_q_tvalid;
     t1_axis_adc6_i_tdata  <= s_axis_adc6_i_tdata ;
     t1_axis_adc6_q_tdata  <= s_axis_adc6_q_tdata ;
     t1_axis_adc6_i_tvalid <= s_axis_adc6_i_tvalid;
     t1_axis_adc6_q_tvalid <= s_axis_adc6_q_tvalid;
     t1_axis_adc7_i_tdata  <= s_axis_adc7_i_tdata ;
     t1_axis_adc7_q_tdata  <= s_axis_adc7_q_tdata ;
     t1_axis_adc7_i_tvalid <= s_axis_adc7_i_tvalid;
     t1_axis_adc7_q_tvalid <= s_axis_adc7_q_tvalid;
   end if;   
end process;

gen_norm: if (inv_data = false) generate
 
process(adc_aclk)
begin
   if rising_edge(adc_aclk) then
     m_axis_adc0_i_tdata  <= t1_axis_adc0_i_tdata ;
     m_axis_adc0_q_tdata  <= t1_axis_adc0_q_tdata ;
     m_axis_adc0_i_tvalid <= t1_axis_adc0_i_tvalid;
     m_axis_adc0_q_tvalid <= t1_axis_adc0_q_tvalid;
     m_axis_adc1_i_tdata  <= t1_axis_adc1_i_tdata ;
     m_axis_adc1_q_tdata  <= t1_axis_adc1_q_tdata ;
     m_axis_adc1_i_tvalid <= t1_axis_adc1_i_tvalid;
     m_axis_adc1_q_tvalid <= t1_axis_adc1_q_tvalid;
     m_axis_adc2_i_tdata  <= t1_axis_adc2_i_tdata ;
     m_axis_adc2_q_tdata  <= t1_axis_adc2_q_tdata ;
     m_axis_adc2_i_tvalid <= t1_axis_adc2_i_tvalid;
     m_axis_adc2_q_tvalid <= t1_axis_adc2_q_tvalid;
     m_axis_adc3_i_tdata  <= t1_axis_adc3_i_tdata ;
     m_axis_adc3_q_tdata  <= t1_axis_adc3_q_tdata ;
     m_axis_adc3_i_tvalid <= t1_axis_adc3_i_tvalid;
     m_axis_adc3_q_tvalid <= t1_axis_adc3_q_tvalid;
     m_axis_adc4_i_tdata  <= t1_axis_adc4_i_tdata ;
     m_axis_adc4_q_tdata  <= t1_axis_adc4_q_tdata ;
     m_axis_adc4_i_tvalid <= t1_axis_adc4_i_tvalid;
     m_axis_adc4_q_tvalid <= t1_axis_adc4_q_tvalid;
     m_axis_adc5_i_tdata  <= t1_axis_adc5_i_tdata ;
     m_axis_adc5_q_tdata  <= t1_axis_adc5_q_tdata ;
     m_axis_adc5_i_tvalid <= t1_axis_adc5_i_tvalid;
     m_axis_adc5_q_tvalid <= t1_axis_adc5_q_tvalid;
     m_axis_adc6_i_tdata  <= t1_axis_adc6_i_tdata ;
     m_axis_adc6_q_tdata  <= t1_axis_adc6_q_tdata ;
     m_axis_adc6_i_tvalid <= t1_axis_adc6_i_tvalid;
     m_axis_adc6_q_tvalid <= t1_axis_adc6_q_tvalid;
     m_axis_adc7_i_tdata  <= t1_axis_adc7_i_tdata ;
     m_axis_adc7_q_tdata  <= t1_axis_adc7_q_tdata ;
     m_axis_adc7_i_tvalid <= t1_axis_adc7_i_tvalid;
     m_axis_adc7_q_tvalid <= t1_axis_adc7_q_tvalid;
   end if;   
end process;
end generate;

gen_inv: if (inv_data = true) generate

process(adc_aclk)
begin
   if rising_edge(adc_aclk) then
     m_axis_adc0_i_tvalid <= t1_axis_adc0_i_tvalid;
     m_axis_adc0_q_tvalid <= t1_axis_adc0_q_tvalid;
     m_axis_adc1_i_tvalid <= t1_axis_adc1_i_tvalid;
     m_axis_adc1_q_tvalid <= t1_axis_adc1_q_tvalid;
     m_axis_adc2_i_tvalid <= t1_axis_adc2_i_tvalid;
     m_axis_adc2_q_tvalid <= t1_axis_adc2_q_tvalid;
     m_axis_adc3_i_tvalid <= t1_axis_adc3_i_tvalid;
     m_axis_adc3_q_tvalid <= t1_axis_adc3_q_tvalid;
     m_axis_adc4_i_tvalid <= t1_axis_adc4_i_tvalid;
     m_axis_adc4_q_tvalid <= t1_axis_adc4_q_tvalid;
     m_axis_adc5_i_tvalid <= t1_axis_adc5_i_tvalid;
     m_axis_adc5_q_tvalid <= t1_axis_adc5_q_tvalid;
     m_axis_adc6_i_tvalid <= t1_axis_adc6_i_tvalid;
     m_axis_adc6_q_tvalid <= t1_axis_adc6_q_tvalid;
     m_axis_adc7_i_tvalid <= t1_axis_adc7_i_tvalid;
     m_axis_adc7_q_tvalid <= t1_axis_adc7_q_tvalid;
   end if;   
end process;

gen_inv_dat: for i in 0 to 127 generate
process(adc_aclk)
begin
   if rising_edge(adc_aclk) then
        m_axis_adc0_i_tdata(i)  <= not t1_axis_adc0_i_tdata(i);
        m_axis_adc0_q_tdata(i)  <= not t1_axis_adc0_q_tdata(i);
        m_axis_adc1_i_tdata(i)  <= not t1_axis_adc1_i_tdata(i);
        m_axis_adc1_q_tdata(i)  <= not t1_axis_adc1_q_tdata(i);
        m_axis_adc2_i_tdata(i)  <= not t1_axis_adc2_i_tdata(i);
        m_axis_adc2_q_tdata(i)  <= not t1_axis_adc2_q_tdata(i);
        m_axis_adc3_i_tdata(i)  <= not t1_axis_adc3_i_tdata(i);
        m_axis_adc3_q_tdata(i)  <= not t1_axis_adc3_q_tdata(i);
        m_axis_adc4_i_tdata(i)  <= not t1_axis_adc4_i_tdata(i);
        m_axis_adc4_q_tdata(i)  <= not t1_axis_adc4_q_tdata(i);
        m_axis_adc5_i_tdata(i)  <= not t1_axis_adc5_i_tdata(i);
        m_axis_adc5_q_tdata(i)  <= not t1_axis_adc5_q_tdata(i);
        m_axis_adc6_i_tdata(i)  <= not t1_axis_adc6_i_tdata(i);
        m_axis_adc6_q_tdata(i)  <= not t1_axis_adc6_q_tdata(i);
        m_axis_adc7_i_tdata(i)  <= not t1_axis_adc7_i_tdata(i);
        m_axis_adc7_q_tdata(i)  <= not t1_axis_adc7_q_tdata(i);
   end if;   
end process;
     
end generate;

end generate;
  
adc_i(0)((16*max_samples_per_cycle)-1 downto 0) <= t1_axis_adc0_i_tdata ;
adc_q(0)((16*max_samples_per_cycle)-1 downto 0) <= t1_axis_adc0_q_tdata ;
adc_i(1)((16*max_samples_per_cycle)-1 downto 0) <= t1_axis_adc1_i_tdata ;
adc_q(1)((16*max_samples_per_cycle)-1 downto 0) <= t1_axis_adc1_q_tdata ;
adc_i(2)((16*max_samples_per_cycle)-1 downto 0) <= t1_axis_adc2_i_tdata ;
adc_q(2)((16*max_samples_per_cycle)-1 downto 0) <= t1_axis_adc2_q_tdata ;
adc_i(3)((16*max_samples_per_cycle)-1 downto 0) <= t1_axis_adc3_i_tdata ;
adc_q(3)((16*max_samples_per_cycle)-1 downto 0) <= t1_axis_adc3_q_tdata ;
adc_i(4)((16*max_samples_per_cycle)-1 downto 0) <= t1_axis_adc4_i_tdata ;
adc_q(4)((16*max_samples_per_cycle)-1 downto 0) <= t1_axis_adc4_q_tdata ;
adc_i(5)((16*max_samples_per_cycle)-1 downto 0) <= t1_axis_adc5_i_tdata ;
adc_q(5)((16*max_samples_per_cycle)-1 downto 0) <= t1_axis_adc5_q_tdata ;
adc_i(6)((16*max_samples_per_cycle)-1 downto 0) <= t1_axis_adc6_i_tdata ;
adc_q(6)((16*max_samples_per_cycle)-1 downto 0) <= t1_axis_adc6_q_tdata ;
adc_i(7)((16*max_samples_per_cycle)-1 downto 0) <= t1_axis_adc7_i_tdata ;
adc_q(7)((16*max_samples_per_cycle)-1 downto 0) <= t1_axis_adc7_q_tdata ;


csr_inst : px_rf_adc_cntl_stat_csr
  PORT MAP (
    s_axi_csr_aclk      => s_axi_csr_aclk,
    s_axi_csr_aresetn   => s_axi_csr_aresetn,
    s_axi_csr_awaddr    => s_axi_csr_awaddr(6 downto 0),
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
    s_axi_csr_araddr    => s_axi_csr_araddr(6 downto 0),
    s_axi_csr_arprot    => s_axi_csr_arprot,
    s_axi_csr_arvalid   => s_axi_csr_arvalid,
    s_axi_csr_arready   => s_axi_csr_arready,
    s_axi_csr_rdata     => s_axi_csr_rdata,
    s_axi_csr_rresp     => s_axi_csr_rresp,
    s_axi_csr_rvalid    => s_axi_csr_rvalid,
    s_axi_csr_rready    => s_axi_csr_rready,
    reg0_init_val       => x"0000FF00",
    reg1_init_val       => x"00000000",
    reg2_init_val       => x"186A0000",
    reg3_init_val       => x"00000000",
    ctl0_out            => ctl0_out,
    ctl1_out            => ctl1_out,
    ctl2_out            => ctl2_out,
    ctl3_out            => ctl3_out,
    stat0_in            => stat0_in,
    stat1_in            => stat1_in,
    stat2_in            => x"00000000",
    stat3_in            => x"00000000",
    intrpt_src_in       => x_intrpt_src,
    irq                 => irq
  );

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     mmcm_clk_src_sel <= ctl3_out(1);
   end if;
end process;

stat0_in <= x"000000" & x_frz_stat;
frz_stat <=  adc3_23_cal_frozen & adc3_01_cal_frozen & adc2_23_cal_frozen & adc2_01_cal_frozen &
             adc1_23_cal_frozen & adc1_01_cal_frozen & adc0_23_cal_frozen & adc0_01_cal_frozen;
 
frz_stat_cdc_inst : px_rf_adc_cntl_stat_cdc8
  PORT MAP (
    src_clk    => adc_aclk,
    src_in     => frz_stat,
    dest_clk   => s_axi_csr_aclk,
    dest_out   => x_frz_stat
  );

frz_cntl_cdc_inst : px_rf_adc_cntl_stat_cdc8
  PORT MAP (
    src_clk    => s_axi_csr_aclk,
    src_in     => ctl0_out(7 downto 0),
    dest_clk   => adc_aclk,
    dest_out   => freeze_manual
  );
  
frz_auto_cdc_inst : px_rf_adc_cntl_stat_cdc8
    PORT MAP (
      src_clk    => s_axi_csr_aclk,
      src_in     => ctl0_out(15 downto 8),
      dest_clk   => adc_aclk,
      dest_out   => auto_freeze_en
    );
    
frz_ddcm0_cdc_inst : px_rf_adc_cntl_stat_cdc8
    PORT MAP (
      src_clk    => s_axi_csr_aclk,
      src_in     => ctl0_out(23 downto 16),
      dest_clk   => adc_aclk,
      dest_out   => dmode(7 downto 0)
   );

frz_ddcm1_cdc_inst : px_rf_adc_cntl_stat_cdc8
   PORT MAP (
      src_clk    => s_axi_csr_aclk,
      src_in     => ctl0_out(31 downto 24),
      dest_clk   => adc_aclk,
      dest_out   => dmode(15 downto 8)
   );
   
cyc1_cdc_inst : px_rf_adc_cntl_stat_cdc8
   PORT MAP (
      src_clk    => s_axi_csr_aclk,
      src_in     => ctl2_out(19 downto 12),
      dest_clk   => adc_aclk,
      dest_out   => cval(7 downto 0)
   );
   
cyc2_cdc_inst : px_rf_adc_cntl_stat_cdc8
   PORT MAP (
      src_clk    => s_axi_csr_aclk,
      src_in     => ctl2_out(27 downto 20),
      dest_clk   => adc_aclk,
      dest_out   => cval(15 downto 8)
   );

ctl2a <= "0000" & ctl2_out(31 downto 28);

cyc3_cdc_inst : px_rf_adc_cntl_stat_cdc8
   PORT MAP (
      src_clk    => s_axi_csr_aclk,
      src_in     => ctl2a,
      dest_clk   => adc_aclk,
      dest_out   => cval(23 downto 16)
   );
   
  
adc0_01_int_cal_freeze <= frz_cntl(0);
adc0_23_int_cal_freeze <= frz_cntl(1);
adc1_01_int_cal_freeze <= frz_cntl(2);
adc1_23_int_cal_freeze <= frz_cntl(3);
adc2_01_int_cal_freeze <= frz_cntl(4);
adc2_23_int_cal_freeze <= frz_cntl(5);
adc3_01_int_cal_freeze <= frz_cntl(6);
adc3_23_int_cal_freeze <= frz_cntl(7);

intrpt_src(0)  <=  adc0_01_over_range;
intrpt_src(1)  <=  adc0_01_over_threshold1;
intrpt_src(2)  <=  adc0_01_over_threshold2;
intrpt_src(3)  <=  adc0_01_over_voltage;
intrpt_src(4)  <=  adc0_23_over_range;
intrpt_src(5)  <=  adc0_23_over_threshold1;
intrpt_src(6)  <=  adc0_23_over_threshold2;
intrpt_src(7)  <=  adc0_23_over_voltage;
intrpt_src(8)  <=  adc1_01_over_range;
intrpt_src(9)  <=  adc1_01_over_threshold1;
intrpt_src(10) <=  adc1_01_over_threshold2;
intrpt_src(11) <=  adc1_01_over_voltage;
intrpt_src(12) <=  adc1_23_over_range;
intrpt_src(13) <=  adc1_23_over_threshold1;
intrpt_src(14) <=  adc1_23_over_threshold2;
intrpt_src(15) <=  adc1_23_over_voltage;
intrpt_src(16) <=  adc2_01_over_range;
intrpt_src(17) <=  adc2_01_over_threshold1;
intrpt_src(18) <=  adc2_01_over_threshold2;
intrpt_src(19) <=  adc2_01_over_voltage;
intrpt_src(20) <=  adc2_23_over_range;
intrpt_src(21) <=  adc2_23_over_threshold1;
intrpt_src(22) <=  adc2_23_over_threshold2;
intrpt_src(23) <=  adc2_23_over_voltage;
intrpt_src(24) <=  adc3_01_over_range;
intrpt_src(25) <=  adc3_01_over_threshold1;
intrpt_src(26) <=  adc3_01_over_threshold2;
intrpt_src(27) <=  adc3_01_over_voltage;
intrpt_src(28) <=  adc3_23_over_range;
intrpt_src(29) <=  adc3_23_over_threshold1;
intrpt_src(30) <=  adc3_23_over_threshold2;
intrpt_src(31) <=  adc3_23_over_voltage;

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
      s_axi_csr_areset <= not t1_s_axi_csr_aresetn;
      stat1_in(7 downto 0) <= adc_tvalidx;
   end if;   
end process;

stat1_in(31 downto 8) <= x"000000";

gen_in_pls: for i in 0 to 31 generate

cdc_pls_inst : px_rf_adc_cntl_stat_cdcpls
  PORT MAP (
    src_clk    => adc_aclk,
    src_rst    => '0',
    src_pulse  => intrpt_src(i),
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => s_axi_csr_areset,
    dest_pulse => x_intrpt_src(i)
  );

end generate;

pl_pls_cdc_inst : px_rf_adc_cntl_stat_cdc8
  PORT MAP (
    src_clk    => s_axi_csr_aclk,
    src_in     => ctl2_out(7 downto 0),
    dest_clk   => adc_aclk,
    dest_out   => x_ctl2a
  );
  
pl_plss_cdc_inst : px_rf_adc_cntl_stat_cdc8
    PORT MAP (
      src_clk    => s_axi_csr_aclk,
      src_in     => ctl2_out(15 downto 8),
      dest_clk   => adc_aclk,
      dest_out   => x_ctl2b
    );
    
cdc_pl_pls_inst : px_rf_adc_cntl_stat_cdcpls
  PORT MAP (
    src_clk    =>  s_axi_csr_aclk,
    src_rst    => s_axi_csr_areset,
    src_pulse  => ctl1_out(0),
    dest_clk   => adc_aclk,
    dest_rst   => '0',
    dest_pulse => x_reg_pls
  );

adc_tvalid <= t1_axis_adc7_i_tvalid & t1_axis_adc6_i_tvalid & t1_axis_adc5_i_tvalid & t1_axis_adc4_i_tvalid & t1_axis_adc3_i_tvalid & t1_axis_adc2_i_tvalid & t1_axis_adc1_i_tvalid & t1_axis_adc0_i_tvalid;
  
tvalid_cdc_inst : px_rf_adc_cntl_stat_cdc8
    PORT MAP (
      src_clk    => adc_aclk,
      src_in     => adc_tvalid,
      dest_clk   => s_axi_csr_aclk,
      dest_out   => adc_tvalidx
    );
    
process(adc_aclk)
begin
   if rising_edge(adc_aclk) then
      t1_pl_event           <= pl_event_in;
      t1_s_axis_ptctl_tdata <= s_axis_ptctl_tdata;
      if (t1_s_axis_ptctl_tdata(15 downto 8) = x"00") then
         t2_sync  <= '0';
      else
         t2_sync  <= '1';
      end if;
      case x_ctl2b(1 downto 0) is
        when "00" => 
           adc00_pl_event <= '0';
           adc01_pl_event <= '0';
           adc02_pl_event <= '0';
           adc03_pl_event <= '0';
           adc10_pl_event <= '0';
           adc11_pl_event <= '0';
           adc12_pl_event <= '0';
           adc13_pl_event <= '0';
           adc20_pl_event <= '0';
           adc21_pl_event <= '0';
           adc22_pl_event <= '0';
           adc23_pl_event <= '0';
           adc30_pl_event <= '0';
           adc31_pl_event <= '0';
           adc32_pl_event <= '0';
           adc33_pl_event <= '0';
           pl_event_out  <= '0';         
        when "01" =>  -- register pulse
            adc00_pl_event <= (x_reg_pls and x_ctl2a(0));
            adc01_pl_event <= (x_reg_pls and x_ctl2a(0));
            adc02_pl_event <= (x_reg_pls and x_ctl2a(1));
            adc03_pl_event <= (x_reg_pls and x_ctl2a(1));
            adc10_pl_event <= (x_reg_pls and x_ctl2a(2));
            adc11_pl_event <= (x_reg_pls and x_ctl2a(2));
            adc12_pl_event <= (x_reg_pls and x_ctl2a(3));
            adc13_pl_event <= (x_reg_pls and x_ctl2a(3));
            adc20_pl_event <= (x_reg_pls and x_ctl2a(4));
            adc21_pl_event <= (x_reg_pls and x_ctl2a(4));
            adc22_pl_event <= (x_reg_pls and x_ctl2a(5));
            adc23_pl_event <= (x_reg_pls and x_ctl2a(5));
            adc30_pl_event <= (x_reg_pls and x_ctl2a(6));
            adc31_pl_event <= (x_reg_pls and x_ctl2a(6));
            adc32_pl_event <= (x_reg_pls and x_ctl2a(7));
            adc33_pl_event <= (x_reg_pls and x_ctl2a(7));
            pl_event_out  <= x_reg_pls; 
        when "10" =>  -- External PL_EVENT  (could be SYSREF)            
            adc00_pl_event <= (t1_pl_event and x_ctl2a(0));
            adc01_pl_event <= (t1_pl_event and x_ctl2a(0));
            adc02_pl_event <= (t1_pl_event and x_ctl2a(1));
            adc03_pl_event <= (t1_pl_event and x_ctl2a(1));
            adc10_pl_event <= (t1_pl_event and x_ctl2a(2));
            adc11_pl_event <= (t1_pl_event and x_ctl2a(2));
            adc12_pl_event <= (t1_pl_event and x_ctl2a(3));
            adc13_pl_event <= (t1_pl_event and x_ctl2a(3));
            adc20_pl_event <= (t1_pl_event and x_ctl2a(4));
            adc21_pl_event <= (t1_pl_event and x_ctl2a(4));
            adc22_pl_event <= (t1_pl_event and x_ctl2a(5));
            adc23_pl_event <= (t1_pl_event and x_ctl2a(5));
            adc30_pl_event <= (t1_pl_event and x_ctl2a(6));
            adc31_pl_event <= (t1_pl_event and x_ctl2a(6));
            adc32_pl_event <= (t1_pl_event and x_ctl2a(7));
            adc33_pl_event <= (t1_pl_event and x_ctl2a(7));  
            pl_event_out   <= t1_pl_event;           
        when "11" =>  -- SYNC from AXIS_PTCTL 
            adc00_pl_event <= (t2_sync and x_ctl2a(0));
            adc01_pl_event <= (t2_sync and x_ctl2a(0));
            adc02_pl_event <= (t2_sync and x_ctl2a(1));
            adc03_pl_event <= (t2_sync and x_ctl2a(1));
            adc10_pl_event <= (t2_sync and x_ctl2a(2));
            adc11_pl_event <= (t2_sync and x_ctl2a(2));
            adc12_pl_event <= (t2_sync and x_ctl2a(3));
            adc13_pl_event <= (t2_sync and x_ctl2a(3));
            adc20_pl_event <= (t2_sync and x_ctl2a(4));
            adc21_pl_event <= (t2_sync and x_ctl2a(4));
            adc22_pl_event <= (t2_sync and x_ctl2a(5));
            adc23_pl_event <= (t2_sync and x_ctl2a(5));
            adc30_pl_event <= (t2_sync and x_ctl2a(6));
            adc31_pl_event <= (t2_sync and x_ctl2a(6));
            adc32_pl_event <= (t2_sync and x_ctl2a(7));  
            adc33_pl_event <= (t2_sync and x_ctl2a(7));  
            pl_event_out   <= t2_sync;                     
        when others =>
            adc00_pl_event <= (t2_sync and x_ctl2a(0));
            adc01_pl_event <= (t2_sync and x_ctl2a(0));
            adc02_pl_event <= (t2_sync and x_ctl2a(1));
            adc03_pl_event <= (t2_sync and x_ctl2a(1));
            adc10_pl_event <= (t2_sync and x_ctl2a(2));
            adc11_pl_event <= (t2_sync and x_ctl2a(2));
            adc12_pl_event <= (t2_sync and x_ctl2a(3));
            adc13_pl_event <= (t2_sync and x_ctl2a(3));
            adc20_pl_event <= (t2_sync and x_ctl2a(4));
            adc21_pl_event <= (t2_sync and x_ctl2a(4));
            adc22_pl_event <= (t2_sync and x_ctl2a(5));
            adc23_pl_event <= (t2_sync and x_ctl2a(5));
            adc30_pl_event <= (t2_sync and x_ctl2a(6));
            adc31_pl_event <= (t2_sync and x_ctl2a(6));
            adc32_pl_event <= (t2_sync and x_ctl2a(7));  
            adc33_pl_event <= (t2_sync and x_ctl2a(7));  
            pl_event_out   <= t2_sync;   
      end case;  
   end if;
end process;

adc0_01_over_range_out      <= adc0_01_over_range;      
adc0_01_over_threshold1_out <= adc0_01_over_threshold1;
adc0_01_over_threshold2_out <= adc0_01_over_threshold2;
adc0_01_over_voltage_out    <= adc0_01_over_voltage;   
adc0_23_over_range_out      <= adc0_23_over_range;    
adc0_23_over_threshold1_out <= adc0_23_over_threshold1;
adc0_23_over_threshold2_out <= adc0_23_over_threshold2;
adc0_23_over_voltage_out    <= adc0_23_over_voltage; 
adc1_01_over_range_out      <= adc1_01_over_range;  
adc1_01_over_threshold1_out <= adc1_01_over_threshold1;
adc1_01_over_threshold2_out <= adc1_01_over_threshold2;
adc1_01_over_voltage_out    <= adc1_01_over_voltage;  
adc1_23_over_range_out      <= adc1_23_over_range;     
adc1_23_over_threshold1_out <= adc1_23_over_threshold1;
adc1_23_over_threshold2_out <= adc1_23_over_threshold2;
adc1_23_over_voltage_out    <= adc1_23_over_voltage;  
adc2_01_over_range_out      <= adc2_01_over_range;     
adc2_01_over_threshold1_out <= adc2_01_over_threshold1;
adc2_01_over_threshold2_out <= adc2_01_over_threshold2;
adc2_01_over_voltage_out    <= adc2_01_over_voltage;   
adc2_23_over_range_out      <= adc2_23_over_range;     
adc2_23_over_threshold1_out <= adc2_23_over_threshold1;
adc2_23_over_threshold2_out <= adc2_23_over_threshold2; 
adc2_23_over_voltage_out    <= adc2_23_over_voltage;  
adc3_01_over_range_out      <= adc3_01_over_range;    
adc3_01_over_threshold1_out <= adc3_01_over_threshold1;
adc3_01_over_threshold2_out <= adc3_01_over_threshold2;
adc3_01_over_voltage_out    <= adc3_01_over_voltage;  
adc3_23_over_range_out      <= adc3_23_over_range;    
adc3_23_over_threshold1_out <= adc3_23_over_threshold1;
adc3_23_over_threshold2_out <= adc3_23_over_threshold2;
adc3_23_over_voltage_out    <= adc3_23_over_voltage;  

   xpm_cdc_async_rst_inst : xpm_cdc_async_rst
   generic map (
      DEST_SYNC_FF => 3,    -- DECIMAL; range: 2-10
      INIT_SYNC_FF => 1,    -- DECIMAL; 0=disable simulation init values, 1=enable simulation init values
      RST_ACTIVE_HIGH => 0  -- DECIMAL; 0=active low reset, 1=active high reset
   )
   port map (
      dest_arst => rf_adc_clk_domain_man_rstn, -- 1-bit output: src_arst asynchronous reset signal synchronized to destination
                              -- clock domain. This output is registered. NOTE: Signal asserts asynchronously
                              -- but deasserts synchronously to dest_clk. Width of the reset signal is at least
                              -- (DEST_SYNC_FF*dest_clk) period.
      dest_clk => adc_aclk,   -- 1-bit input: Destination clock.
      src_arst => arstn     -- 1-bit input: Source asynchronous reset signal.
   );

arstn <= not ctl3_out(0);

--------------------------------------------------------------------------------
-- Freeze Control
--------------------------------------------------------------------------------

ddc_mode(0) <= dmode(0);
ddc_mode(2) <= dmode(3);
ddc_mode(4) <= dmode(6);
ddc_mode(6) <= dmode(9);
ddc_mode(1) <= dmode(0);
ddc_mode(3) <= dmode(3);
ddc_mode(5) <= dmode(6);
ddc_mode(7) <= dmode(9);
dec(1 downto 0)   <= dmode(2 downto 1);
dec(3 downto 2)   <= dmode(2 downto 1);
dec(5 downto 4)   <= dmode(5 downto 4);
dec(7 downto 6)   <= dmode(5 downto 4);
dec(9 downto 8)   <= dmode(8 downto 7);
dec(11 downto 10) <= dmode(8 downto 7);
dec(13 downto 12) <= dmode(11 downto 10);
dec(15 downto 14) <= dmode(11 downto 10);

gen_frz_ctl: for i in 0 to 7 generate

adc_frz_calc_inst: adc_frz_calc
 generic map (
        max_samples_per_cycle => max_samples_per_cycle,
        real_only => real_only
    )
 port map ( 
   clk            => adc_aclk,
   rst_n          => '1',
   freeze_manual  => freeze_manual(i),
   adc_i          => adc_i(i),
   adc_q          => adc_q(i),
   adc_dval       => adc_tvalid(i),
   enable         => auto_freeze_en(i),
   ddc_mode       => ddc_mode(i),
   dec            => dec((i*2)+1 downto (i*2)),
   freeze         => frz_cntl(i)
  );

end generate;
      
end Behavioral;
