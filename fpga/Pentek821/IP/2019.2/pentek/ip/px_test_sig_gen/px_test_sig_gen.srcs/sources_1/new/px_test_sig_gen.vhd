----------------------------------------------------------------------------------
-- Pentek Test Signal Generator
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
 
-- Output tvalid is delayed 17 clock cycles from input s_axis_ptctl_tvalid

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

Library UNISIM;
use UNISIM.vcomponents.all;

-------------------------------------------------------------------------------
-- Main Entity
-------------------------------------------------------------------------------

entity px_test_sig_gen is
generic (
    -- Samples per clock cycle 1,2,4 or 8
    samples_per_cycle : integer range 1 to 8 := 1   
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
   -- Test Signal Output (AXI4-Stream Master) no back pressure
   -----------------------------------------------------------------------------
   m_axis_pd_testsig_tdata  : out std_logic_vector((samples_per_cycle*16)-1 downto 0);
   m_axis_pd_testsig_tvalid : out std_logic
);
end px_test_sig_gen;

architecture Behavioral of px_test_sig_gen is

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
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_ptctl:m_axis_pd_testsig, ASSOCIATED_RESET s_axis_aresetn";

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Control/Status Registers
component px_test_sig_gen_csr
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
-------------------------------------------------------------------------------
-- Interrupt Sources (synchronous to axis_aclk)
--------------------------------------------------------------------------------
    load_event            : in std_logic;
    load_armed            : in std_logic
);
end component;

-- DDS
-- 11 clock latency
-- Clock Enable
-- 16-bit output
-- 32-bit phase and frequency
component px_test_sig_gen_dds
  port (
    aclk                : in std_logic;
    aclken              : in std_logic;
    aresetn             : in std_logic;
    s_axis_phase_tvalid : in std_logic;
    s_axis_phase_tdata  : in std_logic_vector(63 downto 0);
    m_axis_data_tvalid  : out std_logic;
    m_axis_data_tdata   : out std_logic_vector(15 downto 0)
  );
end component;

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

type load_state_type is (
RESET_STATE,
WAIT_FOR_ARM,
ARMED_STATE
);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal load_state           : load_state_type;
signal t1_s_axis_aresetn    : std_logic := '0';                        
signal t1_arm_load          : std_logic := '0';                                      
signal arm_re               : std_logic := '0';                              
signal cntr_rst             : std_logic := '0';                         
signal arm_load             : std_logic := '0';         
signal arm_clr              : std_logic := '0';         
signal stay_armed           : std_logic := '0';         
signal load_mode            : std_logic_vector(2 downto 0) := (others => '0');   
signal freq_val             : std_logic_vector(31 downto 0) := (others => '0');
signal t2_pps_re            : std_logic := '0'; 
signal t2_pps_fe            : std_logic := '0'; 
signal t3_cntr_load         : std_logic := '0'; 
signal load_armed           : std_logic := '0';  
signal t2_sync_re           : std_logic := '0'; 
signal t2_sync_fe           : std_logic := '0'; 
signal t2_gate_re           : std_logic := '0'; 
signal t2_gate_fe           : std_logic := '0'; 
signal t1_s_axis_ptctl_tdata: std_logic_vector((samples_per_cycle*3)-1  downto 0) := (others => '0');
signal t1_s_axis_ptctl_tvalid : std_logic := '0';   
signal t2_s_axis_ptctl_tvalid : std_logic := '0'; 
signal t3_s_axis_ptctl_tvalid : std_logic := '0'; 
signal t4_s_axis_ptctl_tvalid : std_logic := '0'; 
signal t5_s_axis_ptctl_tvalid : std_logic := '0'; 
signal t6_s_axis_ptctl_tvalid : std_logic := '0';
signal t7_s_axis_ptctl_tvalid : std_logic := '0';
signal t8_s_axis_ptctl_tvalid : std_logic := '0';
signal t9_s_axis_ptctl_tvalid : std_logic := '0';
signal t10_s_axis_ptctl_tvalid: std_logic := '0';
signal t11_s_axis_ptctl_tvalid: std_logic := '0';
signal t12_s_axis_ptctl_tvalid: std_logic := '0';
signal t13_s_axis_ptctl_tvalid: std_logic := '0';
signal t14_s_axis_ptctl_tvalid: std_logic := '0';
signal t15_s_axis_ptctl_tvalid: std_logic := '0';
signal csr_irq               : std_logic := '0';   
signal t2_pps                : std_logic := '0';
signal t2_sync               : std_logic := '0';
signal t2_gate               : std_logic := '0';
signal pps_or                : std_logic := '0';
signal sync_or               : std_logic := '0';
signal gate_or               : std_logic := '0';
signal t7_ramp_m_axis_data_tdata : std_logic_vector((samples_per_cycle*16)-1 downto 0) := (others => '0');
signal t8_ramp_m_axis_data_tdata : std_logic_vector((samples_per_cycle*16)-1 downto 0) := (others => '0');
signal t9_ramp_m_axis_data_tdata : std_logic_vector((samples_per_cycle*16)-1 downto 0) := (others => '0'); 
signal t10_ramp_m_axis_data_tdata: std_logic_vector((samples_per_cycle*16)-1 downto 0) := (others => '0'); 
signal t11_ramp_m_axis_data_tdata: std_logic_vector((samples_per_cycle*16)-1 downto 0) := (others => '0'); 
signal t12_ramp_m_axis_data_tdata: std_logic_vector((samples_per_cycle*16)-1 downto 0) := (others => '0'); 
signal t13_ramp_m_axis_data_tdata: std_logic_vector((samples_per_cycle*16)-1 downto 0) := (others => '0'); 
signal t14_ramp_m_axis_data_tdata: std_logic_vector((samples_per_cycle*16)-1 downto 0) := (others => '0'); 
signal t15_ramp_m_axis_data_tdata: std_logic_vector((samples_per_cycle*16)-1 downto 0) := (others => '0'); 
signal t16_ramp_m_axis_data_tdata: std_logic_vector((samples_per_cycle*16)-1 downto 0) := (others => '0'); 
signal t17_ramp_m_axis_data_tdata: std_logic_vector((samples_per_cycle*16)-1 downto 0) := (others => '0'); 
signal t16_ramp_m_axis_data_tvalid: std_logic := '0';
signal output_sel            : std_logic := '0';
signal t5_dds_s_axis_phase_tdata: std_logic_vector((samples_per_cycle*64)-1 downto 0) := (others => '0'); 
signal t5_cntr_aresetn       : std_logic := '0';
signal t5_dds_aresetn        : std_logic := '0';
signal t4_cntr_load          : std_logic := '0';
signal t2_s_axis_aresetn     : std_logic := '0';
signal t3_s_axis_aresetn     : std_logic := '0';
signal t4_s_axis_aresetn     : std_logic := '0';
signal t4_dds_load_offset    : std_logic_vector(31 downto 0) := (others => '0');
signal t16_dds_m_axis_data_tvalid: std_logic_vector(samples_per_cycle-1 downto 0) := (others => '0');
signal t3_ramp_load_offset   : std_logic_vector(15 downto 0) := (others => '0');
signal t16_dds_m_axis_data_tdata: std_logic_vector((samples_per_cycle*16)-1 downto 0) := (others => '0');
signal t6_ramp_cntr          : std_logic_vector(15 downto 0) := (others => '0');
signal t2_gate_offset        : std_logic_vector(15 downto 0) := (others => '0');
signal t2_sync_offset        : std_logic_vector(15 downto 0) := (others => '0');
signal t2_pps_offset         : std_logic_vector(15 downto 0) := (others => '0');
signal t1_s_axi_csr_aresetn  : std_logic := '0';
--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

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
-- Functions
--------------------------------------------------------------------------------

function gen_phase_i_of_n(phase_in : std_logic_vector(31 downto 0); i : integer range 0 to 7) return std_logic_vector is
variable result : std_logic_vector(31 downto 0);
begin
case i is
   when 0 =>
      result := x"00000000";
   when 1 => 
      result := phase_in(31 downto 0);
   when 2 =>
      result := (phase_in(30 downto 0) & '0');
   when 3 =>
      result := ((phase_in(30 downto 0) & '0') + phase_in(31 downto 0));
   when 4 =>
      result := (phase_in(29 downto 0)  & "00");
   when 5 =>
      result := ((phase_in(29 downto 0) & "00") + phase_in(31 downto 0));
   when 6 =>
      result := ((phase_in(29 downto 0) & "00") + (phase_in(30 downto 0) & '0'));
   when 7 =>
      result := ((phase_in(28 downto 0) & "000") - phase_in(31 downto 0));
   when others =>
      result := x"00000000";
end case;
return result;			
end function gen_phase_i_of_n;

function find_first_ptctl_position (signal_in : std_logic_vector; w : integer) return integer is
variable result: integer := 0;
variable found : std_logic := '0';
variable indata : std_logic_vector(w-1 downto 0) := signal_in;
begin
result := w; -- if no set positions, return w
found := '0';
for i in 0 to (w-1) loop 
    if (indata(i) = '1') and (found = '0') then
        result := i; 
        found  := '1';
    end if;
end loop;
return result; 
end function find_first_ptctl_position;

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
csr_inst: px_test_sig_gen_csr
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
 -------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------
    load_event              => t3_cntr_load,
    load_armed              => load_armed  
);

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
        t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
        irq <= csr_irq;
   end if;
end process;

-------------------------------------------------------------------------------

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
       t1_s_axis_aresetn           <= s_axis_aresetn;           
       t1_s_axis_ptctl_tdata    <= s_axis_ptctl_tdata((samples_per_cycle*3)-1  downto 0); 
       t1_s_axis_ptctl_tvalid   <= s_axis_ptctl_tvalid;
       
       t1_arm_load                 <= arm_load;
       arm_re                      <= arm_load and not t1_arm_load;
   end if;
end process;

--------------------------------------------------------------------------------
-- DDS Cores
--------------------------------------------------------------------------------
process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
       t4_cntr_load <= t3_cntr_load;
       t2_s_axis_aresetn <= t1_s_axis_aresetn;
       t3_s_axis_aresetn <= t2_s_axis_aresetn;
       t4_s_axis_aresetn <= t3_s_axis_aresetn;
       t5_dds_aresetn <= not (cntr_rst or t3_cntr_load or t4_cntr_load or (not t3_s_axis_aresetn) or (not t4_s_axis_aresetn));
       if (t3_s_axis_aresetn = '0') or (cntr_rst = '1') then
          t4_dds_load_offset <= (others => '0');
       elsif t3_cntr_load = '1' then
          t4_dds_load_offset <= gen_phase_i_of_n(freq_val, conv_integer(t3_ramp_load_offset));
       end if;
    end if;
end process;


gen_dds: for i in 0 to (samples_per_cycle-1) generate

dds_inst : px_test_sig_gen_dds
port map (
    aclk                => s_axis_aclk,
    aclken              => t5_s_axis_ptctl_tvalid,
    aresetn             => t5_dds_aresetn,
    s_axis_phase_tvalid => '1',
    s_axis_phase_tdata  => t5_dds_s_axis_phase_tdata((63+(i*64)) downto (i*64)),
    m_axis_data_tvalid  => t16_dds_m_axis_data_tvalid(i),
    m_axis_data_tdata   => t16_dds_m_axis_data_tdata((15+(i*16)) downto (i*16))
  );



-- generate phase offsets
process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
       if (t3_s_axis_aresetn = '0') or (cntr_rst = '1') then
          t5_dds_s_axis_phase_tdata(63+(i*64) downto 32+(i*64)) <= x"00000000";
       elsif t4_cntr_load = '1' then
          t5_dds_s_axis_phase_tdata(63+(i*64) downto 32+(i*64)) <= gen_phase_i_of_n(freq_val, i) - t4_dds_load_offset;
       end if;
    end if;
end process;

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
       if (t3_s_axis_aresetn = '0') or (cntr_rst = '1') then
          t5_dds_s_axis_phase_tdata(31+(i*64) downto (i*64)) <= (others => '0');
       elsif t4_cntr_load = '1' then
          -- generate frequency (phase increment)
          case iwidth is
            when 1 =>
               t5_dds_s_axis_phase_tdata(31+(i*64) downto (i*64)) <= freq_val(31 downto 0);
            when 2 =>
               t5_dds_s_axis_phase_tdata(31+(i*64) downto (i*64)) <= freq_val(30 downto 0) & '0';
            when 4 =>
               t5_dds_s_axis_phase_tdata(31+(i*64) downto (i*64)) <= freq_val(29 downto 0) & "00";
            when 8 =>
               t5_dds_s_axis_phase_tdata(31+(i*64) downto (i*64)) <= freq_val(28 downto 0) & "000";
            when others =>
               t5_dds_s_axis_phase_tdata(31+(i*64) downto (i*64)) <= freq_val(31 downto 0);
          end case;
       end if;
    end if;
end process;
    
end generate;

--------------------------------------------------------------------------------
-- Ramp Counter
--------------------------------------------------------------------------------

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
       t5_cntr_aresetn <= not (cntr_rst or t3_cntr_load or t4_cntr_load or (not t3_s_axis_aresetn) or (not t4_s_axis_aresetn));
    end if;
end process;


process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
       if t5_cntr_aresetn = '0' then
         t6_ramp_cntr <= 0 - t3_ramp_load_offset; --x"0000";
       elsif t5_s_axis_ptctl_tvalid = '1' then
         t6_ramp_cntr <= t6_ramp_cntr + ramp_incr;
       end if;
    end if;
end process;

-- Generate the requires ramp offset counts
gen_ramps: for i in 0 to (samples_per_cycle-1) generate

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
       t7_ramp_m_axis_data_tdata((15+(i*16)) downto (i*16)) <= t6_ramp_cntr + i;
    end if;
end process;

end generate;

--------------------------------------------------------------------------------
-- Counter and DDS Load Control
--------------------------------------------------------------------------------
-- Load Mode
    -- 000 Always on Arm
    -- 001 Always on Arm
    -- 010 PPS rising edge
    -- 011 PPS falling edge
    -- 100 SYNC rising edge
    -- 101 SYNC falling edge
    -- 110 Gate rising_edge
    -- 111 Gate falling edge 

process(s_axis_aclk)
begin
  if rising_edge(s_axis_aclk) then
    if t1_s_axis_aresetn = '0' then
       load_armed  <= '0';
       t3_cntr_load   <= '0';
       load_state  <= RESET_STATE;
    else
        case load_state is
            when RESET_STATE =>
               if t1_s_axis_aresetn = '0' then
                 load_armed  <= '0';
                 t3_cntr_load   <= '0';
                 load_state  <= RESET_STATE;
               else  
                 load_state  <= WAIT_FOR_ARM;
               end if;
            when WAIT_FOR_ARM =>
                if ((arm_re = '1') or (load_armed = '1')) and (arm_clr = '0') then
                   load_state  <= ARMED_STATE;
                   load_armed  <= '1';
                else
                   load_state  <= WAIT_FOR_ARM;
                end if;
                t3_cntr_load <= '0';
            when ARMED_STATE =>
                if (arm_clr = '1') then -- clear ARM
                    load_state <= WAIT_FOR_ARM;
                    load_armed <= '0';
                else
                    -- Determine action based on load mode.
                    case load_mode is
                        when LOAD_ALWAYS_ON_ARM | LOAD_ALWAYS_ON_ARM2 =>
                            t3_cntr_load   <= '1';
                            t3_ramp_load_offset <= (others => '0');
                            load_state  <= WAIT_FOR_ARM;
                            load_armed  <= '0';
                        when LOAD_ON_PPS_RISING_EDGE =>
                            if (t2_pps_re = '1') then
                                t3_cntr_load   <= '1';
                                t3_ramp_load_offset <= t2_pps_offset;
                                load_state  <= WAIT_FOR_ARM;
                                if stay_armed = '0' then
                                    load_armed  <= '0';
                                end if;
                            else
                                load_state  <= ARMED_STATE;
                            end if;
                        when LOAD_ON_PPS_FALLING_EDGE =>
                            if (t2_pps_fe = '1') then
                                t3_cntr_load   <= '1';
                                t3_ramp_load_offset <= t2_pps_offset;
                                load_state  <= WAIT_FOR_ARM;
                                if stay_armed = '0' then
                                    load_armed  <= '0';
                                end if;
                            else
                                load_state  <= ARMED_STATE;
                            end if;                        
                        when LOAD_ON_SYNC_RISING_EDGE =>
                            if (t2_sync_re = '1') then
                                t3_cntr_load   <= '1';
                                t3_ramp_load_offset <= t2_sync_offset;
                                load_state  <= WAIT_FOR_ARM;
                                if stay_armed = '0' then
                                    load_armed  <= '0';
                                end if;
                            else
                                load_state  <= ARMED_STATE;
                            end if;
                        when LOAD_ON_SYNC_FALLING_EDGE =>
                            if (t2_sync_fe = '1') then
                                t3_cntr_load   <= '1';
                                t3_ramp_load_offset <= t2_sync_offset;
                                load_state  <= WAIT_FOR_ARM;
                                if stay_armed = '0' then
                                    load_armed  <= '0';
                                end if;
                            else
                                load_state  <= ARMED_STATE;
                            end if;                        
                        when LOAD_ON_GATE_RISING_EDGE =>
                            if (t2_gate_re = '1') then
                                t3_cntr_load   <= '1';
                                t3_ramp_load_offset <= t2_gate_offset;
                                load_state  <= WAIT_FOR_ARM;
                                if stay_armed = '0' then
                                    load_armed  <= '0';
                                end if;
                            else
                                load_state  <= ARMED_STATE;
                            end if;
                        when LOAD_ON_GATE_FALLING_EDGE =>
                            if (t2_gate_fe = '1') then
                                t3_cntr_load   <= '1';
                                t3_ramp_load_offset <= t2_gate_offset;
                                load_state  <= WAIT_FOR_ARM;
                                if stay_armed = '0' then
                                    load_armed  <= '0';
                                end if;
                            else
                                load_state  <= ARMED_STATE;
                            end if; 
                        when others =>
                            load_state <= RESET_STATE;
                    end case;    
                end if;
            when others =>
               load_state <= RESET_STATE;
         end case;
    end if;
  end if;  
end process;

--------------------------------------------------------------------------------
-- Compenstate for latencies
--------------------------------------------------------------------------------
-- tdata[n-1:0]       = Gate Positions
-- tdata[2n-1:n]      = Sync Positions   
-- tdata[3n-1:2n]     = PPS Positions  

process(t1_s_axis_ptctl_tdata)
begin
    case iwidth is
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
     end case;
end process;

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then     
       t2_s_axis_ptctl_tvalid   <= t1_s_axis_ptctl_tvalid;
       t3_s_axis_ptctl_tvalid   <= t2_s_axis_ptctl_tvalid;
       t4_s_axis_ptctl_tvalid   <= t3_s_axis_ptctl_tvalid;
       t5_s_axis_ptctl_tvalid   <= t4_s_axis_ptctl_tvalid;
       t6_s_axis_ptctl_tvalid   <= t5_s_axis_ptctl_tvalid;   
       t7_s_axis_ptctl_tvalid   <= t6_s_axis_ptctl_tvalid;   
       if t1_s_axis_aresetn = '0' then
          t2_pps_re      <= '0';
          t2_pps         <= '0';
          t2_pps_fe      <= '0';
          t2_sync_re     <= '0';
          t2_sync_fe     <= '0';
          t2_sync        <= '0'; 
          t2_gate_re     <= '0'; 
          t2_gate_fe     <= '0'; 
          t2_gate        <= '0'; 
          t2_pps_offset  <= (others => '0');
          t2_sync_offset <= (others => '0');
          t2_gate_offset <= (others => '0');
       elsif t1_s_axis_ptctl_tvalid = '1' then
          t2_pps_re      <= pps_or and not t2_pps;
          t2_pps         <= pps_or;
          t2_pps_fe      <= t2_pps and not pps_or; 
          t2_pps_offset  <= conv_std_logic_vector(find_first_ptctl_position( t1_s_axis_ptctl_tdata( (iwidth*3)-1 downto (iwidth*2)), iwidth),16);
          t2_sync_re     <= sync_or and not t2_sync;
          t2_sync_fe     <= t2_sync and not sync_or;
          t2_sync        <= sync_or;
          t2_sync_offset <= conv_std_logic_vector(find_first_ptctl_position( t1_s_axis_ptctl_tdata((iwidth*2)-1 downto iwidth), iwidth),16);
          t2_gate_re     <= gate_or and t2_gate;
          t2_gate_fe     <= t2_gate and not gate_or;
          t2_gate        <= gate_or;
          t2_gate_offset <= conv_std_logic_vector(find_first_ptctl_position( t1_s_axis_ptctl_tdata((iwidth-1) downto 0), iwidth),16);
       end if;
   end if;
end process;

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then 
     t8_ramp_m_axis_data_tdata  <= t7_ramp_m_axis_data_tdata;
     t9_ramp_m_axis_data_tdata  <= t8_ramp_m_axis_data_tdata;
     t10_ramp_m_axis_data_tdata <= t9_ramp_m_axis_data_tdata;
     t11_ramp_m_axis_data_tdata <= t10_ramp_m_axis_data_tdata;
     t12_ramp_m_axis_data_tdata <= t11_ramp_m_axis_data_tdata;
     t13_ramp_m_axis_data_tdata <= t12_ramp_m_axis_data_tdata;
     t14_ramp_m_axis_data_tdata <= t13_ramp_m_axis_data_tdata;
     t15_ramp_m_axis_data_tdata <= t14_ramp_m_axis_data_tdata;
     t16_ramp_m_axis_data_tdata <= t15_ramp_m_axis_data_tdata;
     t17_ramp_m_axis_data_tdata <= t16_ramp_m_axis_data_tdata;
     t8_s_axis_ptctl_tvalid  <= t7_s_axis_ptctl_tvalid;
     t9_s_axis_ptctl_tvalid  <= t8_s_axis_ptctl_tvalid; 
     t10_s_axis_ptctl_tvalid <= t9_s_axis_ptctl_tvalid; 
     t11_s_axis_ptctl_tvalid <= t10_s_axis_ptctl_tvalid; 
     t12_s_axis_ptctl_tvalid <= t11_s_axis_ptctl_tvalid; 
     t13_s_axis_ptctl_tvalid <= t12_s_axis_ptctl_tvalid;
     t14_s_axis_ptctl_tvalid <= t13_s_axis_ptctl_tvalid;
     t15_s_axis_ptctl_tvalid <= t14_s_axis_ptctl_tvalid;
     t16_ramp_m_axis_data_tvalid<= t15_s_axis_ptctl_tvalid;
    end if;
end process;
     
--------------------------------------------------------------------------------
-- Output Mux
--------------------------------------------------------------------------------

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then 
    if output_sel = '0' then -- ramp
       m_axis_pd_testsig_tdata <= t17_ramp_m_axis_data_tdata;
    else -- sine
       m_axis_pd_testsig_tdata <= t16_dds_m_axis_data_tdata; 
    end if;
    m_axis_pd_testsig_tvalid<= t16_ramp_m_axis_data_tvalid; 
   end if;
end process;
   
end Behavioral;
