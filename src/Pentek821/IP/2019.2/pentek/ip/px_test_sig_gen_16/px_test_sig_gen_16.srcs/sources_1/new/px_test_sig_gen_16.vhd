----------------------------------------------------------------------------------
-- Pentek Test Signal Generator for 4/8 Sample/Cycle Data Streams
----------------------------------------------------------------------------------
-- px_test_sig_gen.vhd
--
-- Target Device: Kintex UltraScale
--
-- Pentek Inc.
-- One Park Way, Upper Saddle River, NJ 07458
-- (201)818-5900
-- www.pentek.com
--
-- Copyright Pentek, Inc. 2015
--
-- Revision:
-- Revision 0.01 - File Created


-- Additional Comments: 
-- Generates a programmable sinewave frequency or ramp that can be synchronously reset by timing events. 
 
-- Output tvalid is delayed 18 clock cycles from input s_axis_ptctl_tvalid

-- Register Map
-- 0x00 Mode Control                    R/W   
-- 0x04 Sinewave Frequency Value        R/W   
-- 0x08 Reserved                        R/W
-- 0x0C Reserved                        RO 
-- 0x10 Reserved                        RO 
-- 0x14 Interrupt Enables               R/W
-- 0x18 Interrupt Status Register       RO 
-- 0x1C Interrupt Flag Register         R/Clr


-- Control
--Bit [0]   - Counter Reset
--Bit [1]   - Arm Load 
--Bit [2]   - Arm Clear 
--Bit [3]   - Stay Armed
--Bit [6:4] - Load_mode
    -- 000 Always on Arm
    -- 001 Always on Arm
    -- 010 PPS rising edge
    -- 011 PPS falling edge
    -- 100 SYNC rising edge
    -- 101 SYNC falling edge
    -- 110 Gate rising_edge
    -- 111 Gate falling edge 
--Bit [7]   - Output Select

-- Interrupts
-- Bit [0] Load Armed Event
-- Bit [1] Load Event

-------------------------------------------------------------------------------
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;

Library UNISIM;
use UNISIM.vcomponents.all;

-------------------------------------------------------------------------------
-- Main Entity
-------------------------------------------------------------------------------

entity px_test_sig_gen_16 is
port (
   ----------------------------------------------------------------------------
   -- Control/Status Registers (AXI4-LITE)
   ----------------------------------------------------------------------------
   -- associated with s_axi_csr_aclk
   s_axi_csr_aclk           : in  std_logic;
   s_axi_csr_aresetn        : in  std_logic;
   s_axi_csr_awaddr         : in  std_logic_vector(4 downto 0);
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
   s_axi_csr_araddr         : in  std_logic_vector(4 downto 0);
   s_axi_csr_arprot         : in  std_logic_vector(2 downto 0);
   s_axi_csr_arvalid        : in  std_logic;
   s_axi_csr_arready        : out std_logic;
   s_axi_csr_rdata          : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp          : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid         : out std_logic;
   s_axi_csr_rready         : in  std_logic;
   
   irq                      : out std_logic; -- Interrupt out
   -----------------------------------------------------------------------------
   -- Timing Events (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------
   -- tdata[n-1:0]       = Gate Positions
   -- tdata[2n-1:n]      = Sync Positions   
   -- tdata[3n-1:2n]     = PPS Positions  
   s_axis_aclk           : in  std_logic; -- Timestamp clock (usually data sample clock
   s_axis_aresetn        : in  std_logic; -- reset   
   s_axis_ptctl_tdata    : in  std_logic_vector(((((8*3)+8)/8)*8)-1  downto 0);
   s_axis_ptctl_tvalid   : in  std_logic;
   -----------------------------------------------------------------------------
   -- Test Signal Output (AXI4-Stream Master) no back pressure
   -----------------------------------------------------------------------------
   m_axis_pd_testsig_tdata  : out std_logic_vector((16*16)-1 downto 0);
   m_axis_pd_testsig_tvalid : out std_logic
);
end px_test_sig_gen_16;

architecture Behavioral of px_test_sig_gen_16 is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

component px_test_sig_gen_mod
generic (
    -- Samples per clock cycle 4 or 8
    samples_per_cycle : integer range 8 to 16 := 16   
);
port (
--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------    
   cntr_rst                 : in  std_logic;
   arm_load                 : in  std_logic;
   stay_armed               : in  std_logic;
   arm_clr                  : in  std_logic;
   load_mode                : in  std_logic_vector(2 downto 0);
   output_sel               : in  std_logic;
   freq_val                 : in  std_logic_vector(31 downto 0);
   rate_div                 : in  std_logic_vector(15 downto 0);
   hs                       : in  std_logic;  
--------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------
   load_event               : out std_logic;
   load_armed_out           : out std_logic;                                     
   -----------------------------------------------------------------------------
   -- Timing Events (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------
   -- tdata[n-1:0]       = Gate Positions
   -- tdata[2n-1:n]      = Sync Positions   
   -- tdata[3n-1:2n]     = PPS Positions  
   s_axis_aclk              : in  std_logic; -- Timestamp clock (usually data sample clock
   s_axis_aresetn           : in  std_logic; -- reset   
   s_axis_ptctl_tdata       : in  std_logic_vector(31 downto 0);
   s_axis_ptctl_tvalid      : in  std_logic;
   -----------------------------------------------------------------------------
   -- Test Signal Output (AXI4-Stream Master) no back pressure
   -----------------------------------------------------------------------------
   m_axis_pd_testsig_tdata  : out std_logic_vector((samples_per_cycle*16)-1 downto 0);
   m_axis_pd_testsig_tvalid : out std_logic
);
end component;

-- Control/Status Registers
component px_test_sig_gen_16_csr
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    s_axi_csr_aclk         : in  std_logic;
    s_axi_csr_aresetn      : in  std_logic;
    s_axi_csr_awaddr       : in  std_logic_vector(4 downto 0); -- only [5:0] used
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
    s_axi_csr_araddr       : in  std_logic_vector(4 downto 0);  -- only [5:0] used
    s_axi_csr_arprot       : in  std_logic_vector(2 downto 0);
    s_axi_csr_arvalid      : in  std_logic;
    s_axi_csr_arready      : out std_logic;
    s_axi_csr_rdata        : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp        : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid       : out std_logic;
    s_axi_csr_rready       : in  std_logic;
    
    irq                   : out std_logic; -- interrupt
    --------------------------------------------------------------------------------
    axis_aclk             : in  std_logic; -- clock for controls and status
    --------------------------------------------------------------------------------
    -- Control Outputs (synchronous to axis_aclk)
    --------------------------------------------------------------------------------        
    cntr_rst              : out std_logic;
    arm_load              : out std_logic;
    stay_armed            : out std_logic;
    arm_clr               : out std_logic;
    load_mode             : out std_logic_vector(2 downto 0);
    output_sel            : out std_logic;
    freq_val              : out std_logic_vector(31 downto 0);
    rate_div              : out std_logic_vector(15 downto 0);
    hs                    : out  std_logic;  
-------------------------------------------------------------------------------
-- Interrupt Sources (synchronous to axis_aclk)
--------------------------------------------------------------------------------
    load_event            : in std_logic;
    load_armed            : in std_logic
);
end component;

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------
constant samples_per_cycle        : integer := 16;
constant ramp_incr :std_logic_vector(15 downto 0) := conv_std_logic_vector(samples_per_cycle,16);

constant iwidth: integer := samples_per_cycle;

constant LOAD_ALWAYS_ON_ARM       : std_logic_vector(2 downto 0) := "000";
constant LOAD_ALWAYS_ON_ARM2      : std_logic_vector(2 downto 0) := "001";
constant LOAD_ON_PPS_RISING_EDGE  : std_logic_vector(2 downto 0) := "010";
constant LOAD_ON_PPS_FALLING_EDGE : std_logic_vector(2 downto 0) := "011";
constant LOAD_ON_SYNC_RISING_EDGE : std_logic_vector(2 downto 0) := "100";
constant LOAD_ON_SYNC_FALLING_EDGE: std_logic_vector(2 downto 0) := "101";
constant LOAD_ON_GATE_RISING_EDGE : std_logic_vector(2 downto 0) := "110";
constant LOAD_ON_GATE_FALLING_EDGE: std_logic_vector(2 downto 0) := "111";


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTERRUPT";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of s_axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_ptctl:m_axis_pd_testsig, ASSOCIATED_RESET s_axis_aresetn";
--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal axis_pd_16_testsig_tdata  : std_logic_vector((16*16)-1 downto 0):= (others => '0');
signal axis_pd_16_testsig_tvalid : std_logic:= '0';
signal t3_cntr_load         : std_logic:= '0';
signal load_armed           : std_logic:= '0';
signal xor_csr_irq           : std_logic:= '0';
signal csr_irq               : std_logic:= '0';  
signal t1_csr_irq            : std_logic:= '0';
signal frst                  : std_logic:= '0';
signal xirq                  : std_logic:= '0';
signal xempty                : std_logic:= '0';
signal load_event_16         : std_logic:= '0';
signal load_armed_16         : std_logic:= '0';
signal t1_des_ctl            : std_logic:= '0';
signal cntr_rst              : std_logic:= '0';
signal arm_load              : std_logic:= '0';
signal stay_armed            : std_logic:= '0';
signal arm_clr               : std_logic:= '0';
signal load_mode             : std_logic_vector(2 downto 0):= (others => '0');
signal output_sel            : std_logic:= '0';
signal freq_val              : std_logic_vector(31 downto 0):= (others => '0');
signal rate_div              : std_logic_vector(15 downto 0) := (others => '0');
signal t1_s_axi_csr_aresetn  : std_logic:= '0';
signal hs                    : std_logic := '0';
--------------------------------------------------------------------------------

begin

--------------------------------------------------------------------------------
-- Control/Status Registers
--------------------------------------------------------------------------------

-- 0x00 Mode Control
-- 0x04 Frequency Value
-- 0x08 Reserved
-- 0x0C Interrupt Enables
-- 0x10 Reserved
-- 0x14 Reserved
-- 0x18 Interrupt Status Register
-- 0x1C Interrupt Flag Register 

-- Control registers operate in Sample clock Domain
csr_inst: px_test_sig_gen_16_csr
port map (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    axis_aclk               => s_axis_aclk,  
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
    
    irq                     => csr_irq,           
--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------    
    cntr_rst                => cntr_rst,
    arm_load                => arm_load, 
    stay_armed              => stay_armed,   
    arm_clr                 => arm_clr,                 
    load_mode               => load_mode, 
    output_sel              => output_sel,                
    freq_val                => freq_val,
    rate_div                => rate_div, 
    hs                      => hs,
 -------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------
    load_event              => t3_cntr_load,
    load_armed              => load_armed  
);

t3_cntr_load <= load_event_16;
load_armed   <= load_armed_16;

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
        irq <= csr_irq;
        t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
   end if;
end process;

--------------------------------------------------------------------------------
-- Test Signal Modules
--------------------------------------------------------------------------------
gen16: px_test_sig_gen_mod
generic map(
    -- Samples per clock cycle 4 or 8
    samples_per_cycle => 16   
)
port map(
--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------    
   cntr_rst                 => cntr_rst,   
   arm_load                 => arm_load,   
   stay_armed               => stay_armed, 
   arm_clr                  => arm_clr,    
   load_mode                => load_mode,  
   output_sel               => output_sel, 
   freq_val                 => freq_val,
   rate_div                 => rate_div,  
   hs                       => hs, 
--------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------
   load_event               => load_event_16,
   load_armed_out           => load_armed_16,                                  
   -----------------------------------------------------------------------------
   -- Timing Events (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------
   -- tdata[n-1:0]       = Gate Positions
   -- tdata[2n-1:n]      = Sync Positions   
   -- tdata[3n-1:2n]     = PPS Positions  
   s_axis_aclk              => s_axis_aclk,
   s_axis_aresetn           => s_axis_aresetn,
   s_axis_ptctl_tdata       => s_axis_ptctl_tdata,
   s_axis_ptctl_tvalid      => s_axis_ptctl_tvalid,
   -----------------------------------------------------------------------------
   -- Test Signal Output (AXI4-Stream Master) no back pressure
   -----------------------------------------------------------------------------
   m_axis_pd_testsig_tdata  => axis_pd_16_testsig_tdata,
   m_axis_pd_testsig_tvalid => axis_pd_16_testsig_tvalid
);

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
        m_axis_pd_testsig_tdata  <= axis_pd_16_testsig_tdata; 
        m_axis_pd_testsig_tvalid <= axis_pd_16_testsig_tvalid;
   end if;
end process;

   
end Behavioral;
