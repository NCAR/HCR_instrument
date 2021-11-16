----------------------------------------------------------------------------------
-- Pentek Chirp Generator
----------------------------------------------------------------------------------
-- px_axis_chirp_gen.vhd
--
-- Target Device: Kintex UltraScale
--
-- Pentek Inc.
-- One Park Way, Upper Saddle River, NJ 07458
-- (201)818-5900
-- www.pentek.com
--
-- Copyright Pentek, Inc. 2018
--
-- Revision:
-- Revision 1.00 - File Created
-- Revision 1.1 - Fixed Tig Hold Mode (pulse length = 0)

-- Additional Comments: 
-- Generates a programmable chirp. 
 
-- Output latency is 29 s_axis_ptctl_tvalid qualified clock cycles

-- 0x00 Mode Control
-- 0x04 Frequency Value
-- 0x08 Phase Offset
-- 0x0C Frequency ramp rate
-- 0x10 Pulse Width
-- 0x14 Interrupt Enables
-- 0x18 Interrupt Status Register
-- 0x1C Interrupt Flag Register 


-- Mode Control
--Bit [0]   - Reset
--Bit [1]   - Arm Load 
--Bit [2]   - Arm Clear 
--Bit [3]   - Stay Armed
--Bit [5:4] - trig_sig_sel
--Bit [6]   - gate_mode
--Bit [7]   - up_mode
--Bit [8]   - trig clr
--Bit [9]   - calc start
--Bit [31:16] - Gain

-- Init Frequency Value - Start Phase Increment
-- Frequency = ((sample rate (Hz)*(Init Freq Value[31:0]))/ 2^32
 
-- Frequency Ramp Rate - Rate of change per sample period of the phase increment 
-- Frequency Ramp Rate (Hz/cycle) =  ((sample rate (Hz) * (Frequency Ramp Rate[31:0])) / 2^32

-- Phase Offset - Initial Phase offset
-- Phase Offset (radians) = (2*PI* PhaseOffset[31:0])/ 2^32 

-- Pulse Width - Length of triggered pulse in samples
-- length in clock cycles = Pulse Width[31:0]/samples per cycle (Must be multiple of samples per cycle or it will be rounded down)
-- If Pulse width is set to 0x00000000 then Hold mode and trigger continues indefinately until cleared.
 

-- Gates in Gate Mode or Triggers in Trigger mode are ignored unless armed.
-- Arming will disarm automatically after one trigger is STAY ARMED is not set

-- Interrupts
-- Bit [0] Trig Armed Event
-- Bit [1] Trig Start Event
-- Bit [2] Trig End Event

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

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

Library UNISIM;
use UNISIM.vcomponents.all;

-------------------------------------------------------------------------------
-- Main Entity
-------------------------------------------------------------------------------

entity px_axis_chirp_gen is
generic (
    -- Samples per clock cycle 1,2,4,8
    samples_per_cycle : integer range 1 to 8 := 8;
    interleave_output : boolean := true
);
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
   s_axis_aclk              : in  std_logic; -- Timestamp clock (usually data sample clock
   s_axis_aresetn           : in  std_logic; -- reset   
   s_axis_ptctl_tdata    : in  std_logic_vector(((((samples_per_cycle*3)+8)/8)*8)-1  downto 0);
   s_axis_ptctl_tvalid   : in  std_logic;
   -----------------------------------------------------------------------------
   -- Chirp Signal Output (AXI4-Stream Master) no back pressure
   -----------------------------------------------------------------------------
   m_axis_pd_tdata       : out std_logic_vector((samples_per_cycle*32)-1 downto 0);
   m_axis_pd_tvalid      : out std_logic;
   
   m_axis_pd_i_tdata     : out std_logic_vector((samples_per_cycle*16)-1 downto 0);
   m_axis_pd_i_tvalid    : out std_logic;
   
   m_axis_pd_q_tdata     : out std_logic_vector((samples_per_cycle*16)-1 downto 0);
   m_axis_pd_q_tvalid    : out std_logic
);
end px_axis_chirp_gen;

architecture Behavioral of px_axis_chirp_gen is

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTERRUPT";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of s_axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_ptctl:m_axis_pd:m_axis_pd_i:m_axis_pd_q, ASSOCIATED_RESET s_axis_aresetn";

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Control/Status Registers
component px_axis_chirp_gen_csr
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
--------------------------------------------------------------------------------
    s_axi_csr_aclk         : in  std_logic;
    s_axi_csr_aresetn      : in  std_logic;
    s_axi_csr_awaddr       : in  std_logic_vector(4 downto 0); 
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
    s_axi_csr_araddr       : in  std_logic_vector(4 downto 0); 
    s_axi_csr_arprot       : in  std_logic_vector(2 downto 0);
    s_axi_csr_arvalid      : in  std_logic;
    s_axi_csr_arready      : out std_logic;
    s_axi_csr_rdata        : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp        : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid       : out std_logic;
    s_axi_csr_rready       : in  std_logic;
    
    irq                    : out std_logic; -- interrupt
    --------------------------------------------------------------------------------
    axis_aclk              : in  std_logic; -- clock for controls and status
    --------------------------------------------------------------------------------
    -- Control Outputs (synchronous to axis_aclk)
    --------------------------------------------------------------------------------   
    reg_rst                 : out std_logic;
    arm                     : out std_logic;
    stay_armed              : out std_logic;  
    arm_clr                 : out std_logic;                 
    gate_mode               : out std_logic;
    trig_clr                : out std_logic;
    pulse_width             : out std_logic_vector(31 downto 0); 
    gain                    : out std_logic_vector(15 downto 0);                
    start_frq_incr          : out std_logic_vector(31 downto 0);
    phase_offset            : out std_logic_vector(31 downto 0);
    rate                    : out std_logic_vector(31 downto 0);
    up_mode                 : out std_logic; 
    trig_sig_sel            : out std_logic_vector(1 downto 0);
    calc_strt               : out std_logic;
-------------------------------------------------------------------------------
-- Interrupt Sources (synchronous to axis_aclk)
--------------------------------------------------------------------------------
    trig_start_event        : in std_logic;
    trig_end_event          : in std_logic;
    trig_armed              : in std_logic
);
end component;

-- Chirp generation
component px_chirp_gen_chrpgen
generic (
    samples_per_cycle : integer := 4 -- 1,2 or 4
);
port ( 
    clk     : in STD_LOGIC;
    rstn    : in std_logic;
    ce      : in std_logic;
    gate    : in std_logic;
    up      : in std_logic;
    load    : in std_logic;
    start   : in std_logic_vector(31 downto 0);
    offset: in std_logic_vector(31 downto 0); -- offset initial phase
    rate    : in std_logic_vector(31 downto 0);
    calc_strt               : in std_logic;
    i0      : out std_logic_vector(15 downto 0);
    q0      : out std_logic_vector(15 downto 0);
    i1      : out std_logic_vector(15 downto 0);
    q1      : out std_logic_vector(15 downto 0);
    i2      : out std_logic_vector(15 downto 0);
    q2      : out std_logic_vector(15 downto 0);
    i3      : out std_logic_vector(15 downto 0);
    q3      : out std_logic_vector(15 downto 0);
    i4      : out std_logic_vector(15 downto 0);
    q4      : out std_logic_vector(15 downto 0);
    i5      : out std_logic_vector(15 downto 0);
    q5      : out std_logic_vector(15 downto 0);
    i6      : out std_logic_vector(15 downto 0);
    q6      : out std_logic_vector(15 downto 0);
    i7      : out std_logic_vector(15 downto 0);
    q7      : out std_logic_vector(15 downto 0);
    ce_out  : out std_logic;
    gate_out: out std_logic
    );
end component px_chirp_gen_chrpgen;


-- Pulse Gen
component px_chirp_gen_plsgen
generic (
    samples_per_cycle : integer := 4
);
port ( 
    clk         : in std_logic;
    rstn        : in std_logic;
    trig_clr    : in std_logic;
    trig_in     : in std_logic;
    gate_in     : in std_logic;
    gate_mode   : in std_logic;
    pulse_width : in std_logic_vector(31 downto 0);
    ce          : in std_logic;
    gate_out    : out std_logic;
    gate_out_re : out std_logic;
    gate_in_fe  : out std_logic
);
end component px_chirp_gen_plsgen;

-- B*(A+D) Rounded symetrically
-- B17 should be '0' to have a 16 bit unsigned multiplication factor
-- Latency = 4
COMPONENT px_axis_chrpgen_gainoffset
  PORT (
    CLK : IN STD_LOGIC;
    CE: IN STD_LOGIC;
    A : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
    D : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    P : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
  );
END COMPONENT;

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

type trig_state_type is (
RESET_STATE,
WAIT_FOR_ARM,
ARMED_STATE
);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal trig_state           : trig_state_type;
signal t1_s_axis_aresetn    : std_logic := '0';        
signal t2_s_axis_aresetn    : std_logic := '0';                 
signal t1_arm               : std_logic := '0';                                      
signal arm_re               : std_logic := '0';                                                  
signal arm                  : std_logic := '0';         
signal arm_clr              : std_logic := '0';      
signal trig_clr             : std_logic := '0';    
signal stay_armed           : std_logic := '0';         
signal trig_armed           : std_logic := '0';  
signal t1_s_axis_ptctl_tdata: std_logic_vector((samples_per_cycle*3)-1  downto 0) := (others => '0');
signal t1_s_axis_ptctl_tvalid : std_logic := '0';   
signal csr_irq               : std_logic := '0';   
signal pps_or                : std_logic := '0';
signal sync_or               : std_logic := '0';
signal gate_or               : std_logic := '0';
signal t3_s_axis_aresetn     : std_logic := '0';
signal t1_s_axi_csr_aresetn  : std_logic := '0';
signal gate_in_fe            : std_logic := '0';
signal trig_sig_sel          : std_logic_vector(1 downto 0) := (others => '0');
signal plsgen_gate_in        : std_logic := '0';
signal gate_mode             : std_logic := '0';
signal pulse_width           : std_logic_vector(31 downto 0) := (others => '0');
signal plsgen_gate_out       : std_logic := '0';
signal plsgen_gate_out_re    : std_logic := '0';
signal up_mode               : std_logic := '0';
signal start_frq_incr        : std_logic_vector(31 downto 0) := (others => '0');
signal rate                  : std_logic_vector(31 downto 0) := (others => '0');
signal chrp_i0               : std_logic_vector(15 downto 0) := (others => '0');
signal chrp_q0               : std_logic_vector(15 downto 0) := (others => '0');
signal chrp_i1               : std_logic_vector(15 downto 0) := (others => '0');
signal chrp_q1               : std_logic_vector(15 downto 0) := (others => '0');
signal chrp_i2               : std_logic_vector(15 downto 0) := (others => '0');
signal chrp_q2               : std_logic_vector(15 downto 0) := (others => '0');
signal chrp_i3               : std_logic_vector(15 downto 0) := (others => '0');
signal chrp_q3               : std_logic_vector(15 downto 0) := (others => '0');
signal chrp_i4               : std_logic_vector(15 downto 0) := (others => '0');
signal chrp_q4               : std_logic_vector(15 downto 0) := (others => '0');
signal chrp_i5               : std_logic_vector(15 downto 0) := (others => '0');
signal chrp_q5               : std_logic_vector(15 downto 0) := (others => '0');
signal chrp_i6               : std_logic_vector(15 downto 0) := (others => '0');
signal chrp_q6               : std_logic_vector(15 downto 0) := (others => '0');
signal chrp_i7               : std_logic_vector(15 downto 0) := (others => '0');
signal chrp_q7               : std_logic_vector(15 downto 0) := (others => '0');
signal chrp_ce               : std_logic := '0';
signal chrpgen_gate_out      : std_logic := '0';
signal t1_chrpgen_gate_out   : std_logic := '0';
signal chrpgen_gate_out_re   : std_logic := '0';
signal chrpgen_gate_out_fe   : std_logic := '0';
signal gain                  : std_logic_vector(15 downto 0) := (others => '0');      
signal phase_offset          : std_logic_vector(31 downto 0) := (others => '0');
signal b_data_in        : std_logic_vector(16 downto 0) := (others => '0');
signal d_data_in        : std_logic_vector(15 downto 0) := (others => '0');
signal t4_go_i0         : std_logic_vector(17 downto 0) := (others => '0');
signal t4_go_q0         : std_logic_vector(17 downto 0) := (others => '0');  
signal t4_go_i1         : std_logic_vector(17 downto 0) := (others => '0');
signal t4_go_q1         : std_logic_vector(17 downto 0) := (others => '0'); 
signal t4_go_i2         : std_logic_vector(17 downto 0) := (others => '0');
signal t4_go_q2         : std_logic_vector(17 downto 0) := (others => '0'); 
signal t4_go_i3         : std_logic_vector(17 downto 0) := (others => '0');
signal t4_go_q3         : std_logic_vector(17 downto 0) := (others => '0'); 
signal t4_go_i4         : std_logic_vector(17 downto 0) := (others => '0');
signal t4_go_q4         : std_logic_vector(17 downto 0) := (others => '0');  
signal t4_go_i5         : std_logic_vector(17 downto 0) := (others => '0');
signal t4_go_q5         : std_logic_vector(17 downto 0) := (others => '0'); 
signal t4_go_i6         : std_logic_vector(17 downto 0) := (others => '0');
signal t4_go_q6         : std_logic_vector(17 downto 0) := (others => '0'); 
signal t4_go_i7         : std_logic_vector(17 downto 0) := (others => '0');
signal t4_go_q7         : std_logic_vector(17 downto 0) := (others => '0'); 
signal t5_sat_i0        : std_logic_vector(15 downto 0) := (others => '0');
signal t5_sat_q0        : std_logic_vector(15 downto 0) := (others => '0');
signal t5_sat_i1        : std_logic_vector(15 downto 0) := (others => '0');
signal t5_sat_q1        : std_logic_vector(15 downto 0) := (others => '0');
signal t5_sat_i2        : std_logic_vector(15 downto 0) := (others => '0');
signal t5_sat_q2        : std_logic_vector(15 downto 0) := (others => '0');
signal t5_sat_i3        : std_logic_vector(15 downto 0) := (others => '0');
signal t5_sat_q3        : std_logic_vector(15 downto 0) := (others => '0');
signal t5_sat_i4        : std_logic_vector(15 downto 0) := (others => '0');
signal t5_sat_q4        : std_logic_vector(15 downto 0) := (others => '0');
signal t5_sat_i5        : std_logic_vector(15 downto 0) := (others => '0');
signal t5_sat_q5        : std_logic_vector(15 downto 0) := (others => '0');
signal t5_sat_i6        : std_logic_vector(15 downto 0) := (others => '0');
signal t5_sat_q6        : std_logic_vector(15 downto 0) := (others => '0');
signal t5_sat_i7        : std_logic_vector(15 downto 0) := (others => '0');
signal t5_sat_q7        : std_logic_vector(15 downto 0) := (others => '0');
signal reg_rst          : std_logic := '0';
signal t2_rstn          : std_logic := '0';
signal calc_strt        : std_logic := '0';

ATTRIBUTE MAX_FANOUT : string;
ATTRIBUTE MAX_FANOUT of t1_s_axis_ptctl_tvalid  : signal is "400";

--------------------------------------------------------------------------------

begin

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then     
       t1_s_axis_ptctl_tvalid   <= s_axis_ptctl_tvalid;
       t1_s_axis_ptctl_tdata    <= s_axis_ptctl_tdata((samples_per_cycle*3)-1  downto 0); 
       t1_s_axis_aresetn        <= s_axis_aresetn;
       t2_s_axis_aresetn        <= t1_s_axis_aresetn; 
       t3_s_axis_aresetn        <= not (not t1_s_axis_aresetn) or (not t2_s_axis_aresetn);   
   end if;
end process;
       
--------------------------------------------------------------------------------
-- OR gates
--------------------------------------------------------------------------------
-- tdata[n-1:0]       = Gate Positions
-- tdata[2n-1:n]      = Sync Positions   
-- tdata[3n-1:2n]     = PPS Positions  

process(t1_s_axis_ptctl_tdata)
begin
    case samples_per_cycle is
        when 1 => 
          gate_or <= t1_s_axis_ptctl_tdata(0);
          sync_or <= t1_s_axis_ptctl_tdata(1);   
          pps_or  <= t1_s_axis_ptctl_tdata(2);     
        when 2 => 
          gate_or <= t1_s_axis_ptctl_tdata(0) or t1_s_axis_ptctl_tdata(1);
          sync_or <= t1_s_axis_ptctl_tdata(2) or t1_s_axis_ptctl_tdata(3);
          pps_or  <= t1_s_axis_ptctl_tdata(4) or t1_s_axis_ptctl_tdata(5);
        when 4 => 
          gate_or <= t1_s_axis_ptctl_tdata(0) or t1_s_axis_ptctl_tdata(1) or 
                     t1_s_axis_ptctl_tdata(2) or t1_s_axis_ptctl_tdata(3);
          sync_or <= t1_s_axis_ptctl_tdata(4) or t1_s_axis_ptctl_tdata(5) or 
                     t1_s_axis_ptctl_tdata(6) or t1_s_axis_ptctl_tdata(7);
          pps_or  <= t1_s_axis_ptctl_tdata(8) or t1_s_axis_ptctl_tdata(9) or 
                     t1_s_axis_ptctl_tdata(10) or t1_s_axis_ptctl_tdata(11);   
        when 8 => 
          gate_or <= t1_s_axis_ptctl_tdata(0) or t1_s_axis_ptctl_tdata(1) or 
                     t1_s_axis_ptctl_tdata(2) or t1_s_axis_ptctl_tdata(3) or
                     t1_s_axis_ptctl_tdata(4) or t1_s_axis_ptctl_tdata(5) or 
                     t1_s_axis_ptctl_tdata(6) or t1_s_axis_ptctl_tdata(7);     
          sync_or <= t1_s_axis_ptctl_tdata(8) or t1_s_axis_ptctl_tdata(9) or 
                     t1_s_axis_ptctl_tdata(10) or t1_s_axis_ptctl_tdata(11) or
                     t1_s_axis_ptctl_tdata(12) or t1_s_axis_ptctl_tdata(13) or 
                     t1_s_axis_ptctl_tdata(14) or t1_s_axis_ptctl_tdata(15);                     
          pps_or  <= t1_s_axis_ptctl_tdata(16) or t1_s_axis_ptctl_tdata(17) or 
                     t1_s_axis_ptctl_tdata(18) or t1_s_axis_ptctl_tdata(19) or 
                     t1_s_axis_ptctl_tdata(20) or t1_s_axis_ptctl_tdata(21) or 
                     t1_s_axis_ptctl_tdata(22) or t1_s_axis_ptctl_tdata(23);                                       
        when others =>
          gate_or <= t1_s_axis_ptctl_tdata(0) or t1_s_axis_ptctl_tdata(1) or 
                   t1_s_axis_ptctl_tdata(2) or t1_s_axis_ptctl_tdata(3);
          sync_or <= t1_s_axis_ptctl_tdata(4) or t1_s_axis_ptctl_tdata(5) or 
                   t1_s_axis_ptctl_tdata(6) or t1_s_axis_ptctl_tdata(7);
          pps_or  <= t1_s_axis_ptctl_tdata(8) or t1_s_axis_ptctl_tdata(9) or 
                   t1_s_axis_ptctl_tdata(10) or t1_s_axis_ptctl_tdata(11);   
     end case;
end process;

-- Latency = 1
process(s_axis_aclk)
begin
  if rising_edge(s_axis_aclk) then
    if t1_s_axis_ptctl_tvalid = '1' then
        if trig_armed = '1' then
            case trig_sig_sel is
                when "00" => -- gate
                    plsgen_gate_in <= gate_or;
                when "01" => -- sync
                    plsgen_gate_in <= sync_or;
                when "10" | "11" => -- pps
                    plsgen_gate_in <= pps_or;
                when others =>
                    plsgen_gate_in <= pps_or;
            end case;       
        else
            plsgen_gate_in <= '0';
        end if;
    end if;    
  end if;
end process;  

--------------------------------------------------------------------------------
-- Pulse Generation
--------------------------------------------------------------------------------
-- latency = 4 tvalid
plsgen_inst: px_chirp_gen_plsgen
generic map (
    samples_per_cycle => samples_per_cycle
)
port map ( 
    clk         => s_axis_aclk,
    rstn        => t2_rstn,
    trig_clr    => trig_clr,
    trig_in     => plsgen_gate_in,
    gate_in     => plsgen_gate_in,
    gate_mode   => gate_mode,
    pulse_width => pulse_width,
    ce          => t1_s_axis_ptctl_tvalid,
    gate_out    => plsgen_gate_out,
    gate_out_re => plsgen_gate_out_re,   
    gate_in_fe  => gate_in_fe
);

--------------------------------------------------------------------------------
-- Chirp Generation
--------------------------------------------------------------------------------
-- latency = 19 tvalid
chrpgen_inst: px_chirp_gen_chrpgen
generic map (
    samples_per_cycle => samples_per_cycle -- 1,2 or 4
)
port map( 
    clk     => s_axis_aclk,
    rstn    => t2_rstn,
    ce      => t1_s_axis_ptctl_tvalid,
    gate    => plsgen_gate_out,
    up      => up_mode,
    load    => plsgen_gate_out_re, 
    start   => start_frq_incr,
    offset  => phase_offset,
    rate    => rate,
    calc_strt  => calc_strt,
    i0      => chrp_i0,
    q0      => chrp_q0,
    i1      => chrp_i1,
    q1      => chrp_q1,
    i2      => chrp_i2,
    q2      => chrp_q2,
    i3      => chrp_i3,
    q3      => chrp_q3,
    i4      => chrp_i4,
    q4      => chrp_q4,
    i5      => chrp_i5,
    q5      => chrp_q5,
    i6      => chrp_i6,
    q6      => chrp_q6,
    i7      => chrp_i7,
    q7      => chrp_q7,
    ce_out  => chrp_ce,
    gate_out=> chrpgen_gate_out
    );

process(s_axis_aclk)
begin
  if rising_edge(s_axis_aclk) then
     t1_chrpgen_gate_out <= chrpgen_gate_out;
     chrpgen_gate_out_re <= chrpgen_gate_out and not t1_chrpgen_gate_out;
     chrpgen_gate_out_fe <= t1_chrpgen_gate_out and not chrpgen_gate_out;
  end if;
end process;

--------------------------------------------------------------------------------
-- Gain
--------------------------------------------------------------------------------

-- GAIN: 16-bit unsigned number 
-- Bit 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0
--     5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
--     1.0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

-- DATA_OUT = Symetric Round((DATA_IN + OFFSET)* GAIN)

-- Latency = 4 ce.

b_data_in <= '0' & gain;
d_data_in <= x"0000"; 

gain_i0_inst : px_axis_chrpgen_gainoffset
port map (
    clk => s_axis_aclk,
    ce  => chrp_ce,
    a   => chrp_i0,
    b   => b_data_in,
    d   => d_data_in,
    p   => t4_go_i0
  );
  
gain_q0_inst : px_axis_chrpgen_gainoffset
port map (
    clk => s_axis_aclk,
    ce  => chrp_ce,
    a   => chrp_q0,
    b   => b_data_in,
    d   => d_data_in,
    p   => t4_go_q0
);
  
process(s_axis_aclk)
  begin
     if rising_edge(s_axis_aclk) then
       if chrp_ce = '1' then
       if (t4_go_i0(17 downto 15) = "000") or (t4_go_i0(17 downto 15) = "111") then
          t5_sat_i0(15 downto 0) <=  t4_go_i0(15 downto 0);
       elsif t4_go_i0(17) = '1' then
          t5_sat_i0(15 downto 0) <= x"8000";
       else
          t5_sat_i0(15 downto 0) <= x"7FFF";
       end if;
       if (t4_go_q0(17 downto 15) = "000") or (t4_go_q0(17 downto 15) = "111") then
          t5_sat_q0(15 downto 0) <=  t4_go_q0(15 downto 0);
       elsif t4_go_q0(17) = '1' then
          t5_sat_q0(15 downto 0) <= x"8000";
       else
          t5_sat_q0(15 downto 0) <= x"7FFF";
       end if;
       end if;
     end if;
  end process;  

gen_2ph_gain: if (samples_per_cycle /= 1) generate 

gain_i1_inst : px_axis_chrpgen_gainoffset
port map (
    clk => s_axis_aclk,
    ce  => chrp_ce,
    a   => chrp_i1,
    b   => b_data_in,
    d   => d_data_in,
    p   => t4_go_i1
  );
  
gain_q1_inst : px_axis_chrpgen_gainoffset
port map (
    clk => s_axis_aclk,
    ce  => chrp_ce,
    a   => chrp_q1,
    b   => b_data_in,
    d   => d_data_in,
    p   => t4_go_q1
  );
    
process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
     if chrp_ce = '1' then
     if (t4_go_i1(17 downto 15) = "000") or (t4_go_i1(17 downto 15) = "111") then
        t5_sat_i1(15 downto 0) <=  t4_go_i1(15 downto 0);
     elsif t4_go_i1(17) = '1' then
        t5_sat_i1(15 downto 0) <= x"8000";
     else
        t5_sat_i1(15 downto 0) <= x"7FFF";
     end if;
     if (t4_go_q1(17 downto 15) = "000") or (t4_go_q1(17 downto 15) = "111") then
        t5_sat_q1(15 downto 0) <=  t4_go_q1(15 downto 0);
     elsif t4_go_q1(17) = '1' then
        t5_sat_q1(15 downto 0) <= x"8000";
     else
        t5_sat_q1(15 downto 0) <= x"7FFF";
     end if;
     end if;
   end if;
end process;  

end generate;   

gen_4ph_gain: if ((samples_per_cycle = 4) or (samples_per_cycle = 8)) generate 

gain_i2_inst : px_axis_chrpgen_gainoffset
port map (
    clk => s_axis_aclk,
    ce  => chrp_ce,
    a   => chrp_i2,
    b   => b_data_in,
    d   => d_data_in,
    p   => t4_go_i2
  );
  
gain_q2_inst : px_axis_chrpgen_gainoffset
  port map (
      clk => s_axis_aclk,
      ce  => chrp_ce,      
      a   => chrp_q2,
      b   => b_data_in,
      d   => d_data_in,
      p   => t4_go_q2
    );

gain_i3_inst : px_axis_chrpgen_gainoffset
port map (
    clk => s_axis_aclk,
    ce  => chrp_ce,
    a   => chrp_i3,
    b   => b_data_in,
    d   => d_data_in,
    p   => t4_go_i3
  );
  
gain_q3_inst : px_axis_chrpgen_gainoffset
port map (
    clk => s_axis_aclk,
    ce  => chrp_ce,
    a   => chrp_q3,
    b   => b_data_in,
    d   => d_data_in,
    p   => t4_go_q3
  );
    
process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
    if chrp_ce = '1' then
     if (t4_go_i2(17 downto 15) = "000") or (t4_go_i2(17 downto 15) = "111") then
        t5_sat_i2(15 downto 0) <=  t4_go_i2(15 downto 0);
     elsif t4_go_i2(17) = '1' then
        t5_sat_i2(15 downto 0) <= x"8000";
     else
        t5_sat_i2(15 downto 0) <= x"7FFF";
     end if;
     if (t4_go_q2(17 downto 15) = "000") or (t4_go_q2(17 downto 15) = "111") then
        t5_sat_q2(15 downto 0) <=  t4_go_q2(15 downto 0);
     elsif t4_go_q2(17) = '1' then
        t5_sat_q2(15 downto 0) <= x"8000";
     else
        t5_sat_q2(15 downto 0) <= x"7FFF";
     end if;
     
     if (t4_go_i3(17 downto 15) = "000") or (t4_go_i3(17 downto 15) = "111") then
        t5_sat_i3(15 downto 0) <=  t4_go_i3(15 downto 0);
     elsif t4_go_i3(17) = '1' then
        t5_sat_i3(15 downto 0) <= x"8000";
     else
        t5_sat_i3(15 downto 0) <= x"7FFF";
     end if;
     if (t4_go_q3(17 downto 15) = "000") or (t4_go_q3(17 downto 15) = "111") then
        t5_sat_q3(15 downto 0) <=  t4_go_q3(15 downto 0);
     elsif t4_go_q3(17) = '1' then
        t5_sat_q3(15 downto 0) <= x"8000";
     else
        t5_sat_q3(15 downto 0) <= x"7FFF";
     end if;
     end if;
   end if;
end process;  

end generate; 

gen_8ph_gain: if (samples_per_cycle = 8) generate 

gain_i4_inst : px_axis_chrpgen_gainoffset
port map (
    clk => s_axis_aclk,
    ce  => chrp_ce,
    a   => chrp_i4,
    b   => b_data_in,
    d   => d_data_in,
    p   => t4_go_i4
  );
  
gain_q4_inst : px_axis_chrpgen_gainoffset
  port map (
      clk => s_axis_aclk,
      ce  => chrp_ce,      
      a   => chrp_q4,
      b   => b_data_in,
      d   => d_data_in,
      p   => t4_go_q4
    );

gain_i5_inst : px_axis_chrpgen_gainoffset
port map (
    clk => s_axis_aclk,
    ce  => chrp_ce,
    a   => chrp_i5,
    b   => b_data_in,
    d   => d_data_in,
    p   => t4_go_i5
  );
  
gain_q5_inst : px_axis_chrpgen_gainoffset
port map (
    clk => s_axis_aclk,
    ce  => chrp_ce,
    a   => chrp_q5,
    b   => b_data_in,
    d   => d_data_in,
    p   => t4_go_q5
  );
  
gain_i6_inst : px_axis_chrpgen_gainoffset
  port map (
      clk => s_axis_aclk,
      ce  => chrp_ce,
      a   => chrp_i6,
      b   => b_data_in,
      d   => d_data_in,
      p   => t4_go_i6
    );
    
  gain_q6_inst : px_axis_chrpgen_gainoffset
    port map (
        clk => s_axis_aclk,
        ce  => chrp_ce,      
        a   => chrp_q6,
        b   => b_data_in,
        d   => d_data_in,
        p   => t4_go_q6
      );
  
  gain_i7_inst : px_axis_chrpgen_gainoffset
  port map (
      clk => s_axis_aclk,
      ce  => chrp_ce,
      a   => chrp_i7,
      b   => b_data_in,
      d   => d_data_in,
      p   => t4_go_i7
    );
    
  gain_q7_inst : px_axis_chrpgen_gainoffset
  port map (
      clk => s_axis_aclk,
      ce  => chrp_ce,
      a   => chrp_q7,
      b   => b_data_in,
      d   => d_data_in,
      p   => t4_go_q7
    );
    
process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
    if chrp_ce = '1' then
     if (t4_go_i4(17 downto 15) = "000") or (t4_go_i4(17 downto 15) = "111") then
        t5_sat_i4(15 downto 0) <=  t4_go_i4(15 downto 0);
     elsif t4_go_i4(17) = '1' then
        t5_sat_i4(15 downto 0) <= x"8000";
     else
        t5_sat_i4(15 downto 0) <= x"7FFF";
     end if;
     if (t4_go_q4(17 downto 15) = "000") or (t4_go_q4(17 downto 15) = "111") then
        t5_sat_q4(15 downto 0) <=  t4_go_q4(15 downto 0);
     elsif t4_go_q4(17) = '1' then
        t5_sat_q4(15 downto 0) <= x"8000";
     else
        t5_sat_q4(15 downto 0) <= x"7FFF";
     end if;
     
     if (t4_go_i5(17 downto 15) = "000") or (t4_go_i5(17 downto 15) = "111") then
        t5_sat_i5(15 downto 0) <=  t4_go_i5(15 downto 0);
     elsif t4_go_i5(17) = '1' then
        t5_sat_i5(15 downto 0) <= x"8000";
     else
        t5_sat_i5(15 downto 0) <= x"7FFF";
     end if;
     if (t4_go_q5(17 downto 15) = "000") or (t4_go_q5(17 downto 15) = "111") then
        t5_sat_q5(15 downto 0) <=  t4_go_q5(15 downto 0);
     elsif t4_go_q5(17) = '1' then
        t5_sat_q5(15 downto 0) <= x"8000";
     else
        t5_sat_q5(15 downto 0) <= x"7FFF";
     end if;
     
     if (t4_go_i6(17 downto 15) = "000") or (t4_go_i6(17 downto 15) = "111") then
        t5_sat_i6(15 downto 0) <=  t4_go_i6(15 downto 0);
     elsif t4_go_i6(17) = '1' then
        t5_sat_i6(15 downto 0) <= x"8000";
     else
        t5_sat_i6(15 downto 0) <= x"7FFF";
     end if;
     if (t4_go_q6(17 downto 15) = "000") or (t4_go_q6(17 downto 15) = "111") then
        t5_sat_q6(15 downto 0) <=  t4_go_q6(15 downto 0);
     elsif t4_go_q4(17) = '1' then
        t5_sat_q6(15 downto 0) <= x"8000";
     else
        t5_sat_q6(15 downto 0) <= x"7FFF";
     end if;
     
     if (t4_go_i7(17 downto 15) = "000") or (t4_go_i7(17 downto 15) = "111") then
        t5_sat_i7(15 downto 0) <=  t4_go_i7(15 downto 0);
     elsif t4_go_i7(17) = '1' then
        t5_sat_i7(15 downto 0) <= x"8000";
     else
        t5_sat_i7(15 downto 0) <= x"7FFF";
     end if;
     if (t4_go_q7(17 downto 15) = "000") or (t4_go_q7(17 downto 15) = "111") then
        t5_sat_q7(15 downto 0) <=  t4_go_q7(15 downto 0);
     elsif t4_go_q7(17) = '1' then
        t5_sat_q7(15 downto 0) <= x"8000";
     else
        t5_sat_q7(15 downto 0) <= x"7FFF";
     end if;
     
     end if;
   end if;
end process;  

end generate; 

--------------------------------------------------------------------------------
-- Compensate for 5 cycle delay
--------------------------------------------------------------------------------

     
--------------------------------------------------------------------------------
-- Trigger Arming Control
--------------------------------------------------------------------------------

process(s_axis_aclk)
begin
  if rising_edge(s_axis_aclk) then
    arm_re <= arm and not t1_arm; 
    t2_rstn <= not((not t1_s_axis_aresetn) or (not t2_s_axis_aresetn) or reg_rst);
    if (t2_rstn = '0')  then
       trig_armed  <= '0';
       trig_state  <= RESET_STATE;
    else
        case trig_state is
            when RESET_STATE =>
               if t1_s_axis_aresetn = '0' then
                 trig_armed  <= '0';
                 trig_state  <= RESET_STATE;
               else  
                 trig_state  <= WAIT_FOR_ARM;
               end if;
            when WAIT_FOR_ARM =>
                if (arm_re = '1') and (arm_clr = '0') then
                   trig_state  <= ARMED_STATE;
                   trig_armed  <= '1';
                end if;
            when ARMED_STATE =>
                if (arm_clr = '1') or ((gate_in_fe = '1') and (stay_armed = '0')) then -- clear ARM
                    trig_state <= WAIT_FOR_ARM;
                    trig_armed <= '0'; 
                end if;
            when others =>
               trig_state <= RESET_STATE;
         end case;
    end if;
  end if;  
end process;

--------------------------------------------------------------------------------
-- Control/Status Registers
--------------------------------------------------------------------------------

-- 0x00 Mode Control
-- 0x04 Frequency Value
-- 0x08 Phase Offset
-- 0x0C Frequency ramp rate
-- 0x10 Pulse Width
-- 0x14 Interrupt Enables
-- 0x18 Interrupt Status Register
-- 0x1C Interrupt Flag Register 

-- Control registers operate in Sample clock Domain
csr_inst: px_axis_chirp_gen_csr
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
    reg_rst                 => reg_rst,
    arm                     => arm, 
    stay_armed              => stay_armed,   
    arm_clr                 => arm_clr,                 
    gate_mode               => gate_mode,
    pulse_width             => pulse_width, 
    trig_clr                => trig_clr,
    gain                    => gain,                
    start_frq_incr          => start_frq_incr,   
    phase_offset            => phase_offset,
    rate                    => rate,
    up_mode                 => up_mode, 
    trig_sig_sel            => trig_sig_sel, 
    calc_strt               => calc_strt, 
 -------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------
    trig_start_event        => chrpgen_gate_out_re,
    trig_end_event          => chrpgen_gate_out_fe,
    trig_armed              => trig_armed  
);

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
        t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
        irq <= csr_irq;
   end if;
end process;

--------------------------------------------------------------------------------
-- Final Output
--------------------------------------------------------------------------------
m_axis_pd_tdata(15 downto 0)  <= t5_sat_i0;
m_axis_pd_tdata(31 downto 16) <= t5_sat_q0;

m_axis_pd_i_tdata(15 downto 0) <= t5_sat_i0;
m_axis_pd_q_tdata(15 downto 0) <= t5_sat_q0;


gen_out2: if (samples_per_cycle /= 1) generate

m_axis_pd_tdata(47 downto 32) <= t5_sat_i1;
m_axis_pd_tdata(63 downto 48) <= t5_sat_q1;

m_axis_pd_i_tdata(31 downto 16) <= t5_sat_i1;
m_axis_pd_q_tdata(31 downto 16) <= t5_sat_q1;

end generate;

gen_out4: if ((samples_per_cycle = 4) or (samples_per_cycle = 8)) generate

m_axis_pd_tdata(79 downto 64)  <= t5_sat_i2;
m_axis_pd_tdata(95 downto 80) <= t5_sat_q2;

m_axis_pd_tdata(111 downto 96)  <= t5_sat_i3;
m_axis_pd_tdata(127 downto 112) <= t5_sat_q3;

m_axis_pd_i_tdata(47 downto 32) <= t5_sat_i2;
m_axis_pd_q_tdata(47 downto 32) <= t5_sat_q2;

m_axis_pd_i_tdata(63 downto 48) <= t5_sat_i3;
m_axis_pd_q_tdata(63 downto 48) <= t5_sat_q3;

end generate;

gen_out8: if (samples_per_cycle = 8) generate

m_axis_pd_tdata(143 downto 128) <= t5_sat_i4;
m_axis_pd_tdata(159 downto 144) <= t5_sat_q4;

m_axis_pd_tdata(175 downto 160) <= t5_sat_i5;
m_axis_pd_tdata(191 downto 176) <= t5_sat_q5;

m_axis_pd_tdata(207 downto 192) <= t5_sat_i6;
m_axis_pd_tdata(223 downto 208) <= t5_sat_q6;

m_axis_pd_tdata(239 downto 224) <= t5_sat_i7;
m_axis_pd_tdata(255 downto 240) <= t5_sat_q7;

m_axis_pd_i_tdata(79 downto 64) <= t5_sat_i4;
m_axis_pd_q_tdata(79 downto 64) <= t5_sat_q4;

m_axis_pd_i_tdata(95 downto 80) <= t5_sat_i5;
m_axis_pd_q_tdata(95 downto 80) <= t5_sat_q5;

m_axis_pd_i_tdata(111 downto 96) <= t5_sat_i6;
m_axis_pd_q_tdata(111 downto 96) <= t5_sat_q6;

m_axis_pd_i_tdata(127 downto 112) <= t5_sat_i7;
m_axis_pd_q_tdata(127 downto 112) <= t5_sat_q7;

end generate;


m_axis_pd_tvalid   <= chrp_ce;
m_axis_pd_i_tvalid <= chrp_ce;
m_axis_pd_q_tvalid <= chrp_ce;
   
end Behavioral;
