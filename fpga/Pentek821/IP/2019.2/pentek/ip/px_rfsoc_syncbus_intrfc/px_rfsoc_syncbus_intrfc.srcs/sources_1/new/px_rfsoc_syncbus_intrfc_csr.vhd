----------------------------------------------------------------------------------
-- Control/Status Registers for Pentek RFSOC Sync Bus Interface
----------------------------------------------------------------------------------
-- px_rfsoc_syncbus_intrfc_csr.vhd
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
-- Revision 0.01 - File Created


-- Additional Comments: 
--  

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
----------------------------------------------------------------------------------

-- Register Map
-- 0x00 Gate Receive Buffer Control
-- 0x04 Sync Receive Buffer Control
-- 0x08 Aux  Receive Buffer Control
-- 0x0C Source Select
-- 0x10 Gate Gen
-- 0x14 Sync Gen
-- 0x18 PPS Gen
-- 0x1C Sysref Gen
-- 0x20 Status Register
-- 0x24 Interrupt Enable Register
-- 0x28 Interrupt Status Register
-- 0x2C Interrupt Flag Register

-- Gate Receive Buffer Control
-- [8:0]   gate_tap_delay[8:0]
-- [9]     gate tap delay load
-- [13:12] gate_int_delay[1:0] 
-- [24:16] ttl_trig_tap_delay[8:0]
-- [25]    trig tap delay load
-- [29:28] ttl_trig_int_delay[1:0] 
-- Sync Receive Buffer Control
-- [8:0]   sync_tap_delay[8:0]
-- [9]     sync tap delay load
-- [13:12] sync_int_delay[1:0] 
-- Sysref Receive Buffer Control
-- [8:0]   sysref_tap_delay[8:0]
-- [9]     sysref tap delay load
-- [10]    sysref_sel
-- [13:12] sysref_int_delay[1:0] 
-- Source Control Register
-- [0]     reserved
-- [1]     reserved
-- [6:4]   gate_rcv_src[2:0] 
-- [10:8]  sync_rcv_src[2:0] 
-- [15:12] pps_rcv_src[3:0] 
-- [19:16] sysref_rcv_src[3:0]
-- [22:20] reserved      
-- [26:24] led_src[1:0]
-- Gate Generate    
-- [0]     gate_reg_gen    
-- Sync Generate      
-- [0]     sync_reg_gen    
-- PPS Generate      
-- [0]     pps_reg_gen
-- Sysref Generate      
-- [0]     sysref_reg_gen

----------------------------------------------------------------------------------

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
Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_rfsoc_syncbus_intrfc_csr is
generic (
   initial_gate_tap_delay         : integer range 0 to 511 := 0;
   initial_sync_tap_delay         : integer range 0 to 511 := 0;
   initial_ttl_trig_tap_delay     : integer range 0 to 511 := 0;
   initial_sysref_tap_delay       : integer range 0 to 511 := 0;
   initial_gate_int_delay         : integer range 0 to 3 := 0;
   initial_sync_int_delay         : integer range 0 to 3 := 0;    
   initial_ttl_trig_int_delay     : integer range 0 to 3 := 0;
   initial_sysref_int_delay       : integer range 0 to 3 := 0;  
   initial_led_src                : integer := 3
);
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    s_axi_csr_aclk         : in  std_logic;
    s_axi_csr_aresetn      : in  std_logic;
    s_axi_csr_awaddr       : in  std_logic_vector(5 downto 0); -- only [5:0] used
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
    s_axi_csr_araddr       : in  std_logic_vector(5 downto 0);  -- only [5:0] used
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
    led_src               : out std_logic_vector(1 downto 0);
    gate_tap_delay        : out std_logic_vector(8 downto 0);
    sync_tap_delay        : out std_logic_vector(8 downto 0);
    trig_ttl_tap_delay    : out std_logic_vector(8 downto 0);
    sysref_tap_delay      : out std_logic_vector(8 downto 0);
    gate_int_delay        : out std_logic_vector(1 downto 0);
    sync_int_delay        : out std_logic_vector(1 downto 0);
    trig_ttl_int_delay    : out std_logic_vector(1 downto 0);
    sysref_int_delay      : out std_logic_vector(1 downto 0);
    gate_rcv_src          : out std_logic_vector(2 downto 0);
    sync_rcv_src          : out std_logic_vector(2 downto 0);
    pps_rcv_src           : out std_logic_vector(3 downto 0);
    sysref_rcv_src        : out std_logic_vector(3 downto 0);
    gate_reg_gen          : out std_logic;
    sync_reg_gen          : out std_logic;
    pps_reg_gen           : out std_logic;
    sysref_reg_gen        : out std_logic;
    gate_dly_ld_ctl       : out std_logic;
    sync_dly_ld_ctl       : out std_logic;
    trig_dly_ld_ctl       : out std_logic;
    sysref_dly_ld_ctl     : out std_logic;
    sysref_sel            : out std_logic;
--------------------------------------------------------------------------------
-- Status Inputs (synchronous to axis_aclk)
--------------------------------------------------------------------------------                     
    selected_gate         : in std_logic;
    selected_sync         : in std_logic;
    selected_pps          : in std_logic;
    selected_sysref       : in std_logic;
    ttl_trig_pin          : in std_logic;
    ttl_pps_pin           : in std_logic;
    rtc_pps_pin           : in std_logic;
    sysref_pin            : in std_logic;
    diff_gate_pin         : in std_logic;
    diff_sync_pin         : in std_logic;
 -------------------------------------------------------------------------------
-- Interrupt Sources (synchronous to axis_aclk)
--------------------------------------------------------------------------------
    gate_re_event         : in std_logic;
    gate_fe_event         : in std_logic;
    sync_re_event         : in std_logic;
    sync_fe_event         : in std_logic;
    pps_re_event          : in std_logic;
    pps_fe_event          : in std_logic;
    sysref_re_event       : in std_logic;
    sysref_fe_event       : in std_logic
);
end px_rfsoc_syncbus_intrfc_csr;

architecture Behavioral of px_rfsoc_syncbus_intrfc_csr is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Generic Control/Status Register Set
component px_axil_csr_sb
  port (
    s_axi_csr_aclk : in std_logic;
    s_axi_csr_aresetn : in std_logic;
    s_axi_csr_awaddr : in std_logic_vector(6 downto 0);
    s_axi_csr_awprot : in std_logic_vector(2 downto 0);
    s_axi_csr_awvalid : in std_logic;
    s_axi_csr_awready : out std_logic;
    s_axi_csr_wdata : in std_logic_vector(31 downto 0);
    s_axi_csr_wstrb : in std_logic_vector(3 downto 0);
    s_axi_csr_wvalid : in std_logic;
    s_axi_csr_wready : out std_logic;
    s_axi_csr_bresp : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid : out std_logic;
    s_axi_csr_bready : in std_logic;
    s_axi_csr_araddr : in std_logic_vector(6 downto 0);
    s_axi_csr_arprot : in std_logic_vector(2 downto 0);
    s_axi_csr_arvalid : in std_logic;
    s_axi_csr_arready : out std_logic;
    s_axi_csr_rdata : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid : out std_logic;
    s_axi_csr_rready : in std_logic;
    reg0_init_val : in std_logic_vector(31 downto 0);
    reg1_init_val : in std_logic_vector(31 downto 0);
    reg2_init_val : in std_logic_vector(31 downto 0);
    reg3_init_val : in std_logic_vector(31 downto 0);
    reg4_init_val : in std_logic_vector(31 downto 0);
    reg5_init_val : in std_logic_vector(31 downto 0);
    reg6_init_val : in std_logic_vector(31 downto 0);
    reg7_init_val : in std_logic_vector(31 downto 0);
    ctl0_out : out std_logic_vector(31 downto 0);
    ctl1_out : out std_logic_vector(31 downto 0);
    ctl2_out : out std_logic_vector(31 downto 0);
    ctl3_out : out std_logic_vector(31 downto 0);
    ctl4_out : out std_logic_vector(31 downto 0);
    ctl5_out : out std_logic_vector(31 downto 0);
    ctl6_out : out std_logic_vector(31 downto 0);
    ctl7_out : out std_logic_vector(31 downto 0);
    stat0_in : in std_logic_vector(31 downto 0);
    intrpt_src_in : in std_logic_vector(7 downto 0);
    irq : out std_logic
  );
end component;

---------------------------------------------------------------------------------
-- Constants
---------------------------------------------------------------------------------

constant cntl_reg0_init_val: std_logic_vector(31 downto 0) := "00" & conv_std_logic_vector(initial_ttl_trig_int_delay, 2) &
                             "000" & conv_std_logic_vector(initial_ttl_trig_tap_delay, 9) & "00" &
                             conv_std_logic_vector(initial_gate_int_delay, 2) & "000" & conv_std_logic_vector(initial_gate_tap_delay, 9);

constant cntl_reg1_init_val: std_logic_vector(31 downto 0) := "00" & "00" & "000" & "000000000" & "00" &
                             conv_std_logic_vector(initial_sync_int_delay, 2) & "000" & conv_std_logic_vector(initial_sync_tap_delay, 9);
constant cntl_reg2_init_val: std_logic_vector(31 downto 0) := "00" & "00" & "000" & "000000000" & "00" &
                             conv_std_logic_vector(initial_sysref_int_delay, 2) & "000" & conv_std_logic_vector(initial_sysref_tap_delay, 9);
constant cntl_reg3_init_val: std_logic_vector(31 downto 0) := "000000" & conv_std_logic_vector(initial_led_src,2) & x"000000";

---------------------------------------------------------------------------------
-- Signals
---------------------------------------------------------------------------------
 
signal cntl_reg0            : std_logic_vector(31 downto 0) := cntl_reg0_init_val;
signal cntl_reg1            : std_logic_vector(31 downto 0) := cntl_reg1_init_val;
signal cntl_reg2            : std_logic_vector(31 downto 0) := cntl_reg2_init_val;
signal cntl_reg3            : std_logic_vector(31 downto 0) := cntl_reg3_init_val;
signal cntl_reg4            : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg5            : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg6            : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg7            : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg0x           : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg1x           : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg2x           : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg3x           : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg4x           : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg5x           : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg6x           : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg7x           : std_logic_vector(31 downto 0) := (others => '0');
signal stat_reg0            : std_logic_vector(31 downto 0) := (others => '0');
signal int_src_stat         : std_logic_vector(7 downto 0)  := (others => '0');
signal awaddr               : std_logic_vector(6 downto 0)  := (others => '0');
signal araddr               : std_logic_vector(6 downto 0)  := (others => '0');
signal src_send07           : std_logic:= '0';
signal src_rcv07            : std_logic:= '0';
signal dest_req07           : std_logic:= '0';
signal cntrl07_vctr         : std_logic_vector(255 downto 0)  := (others => '0');
signal cntrlx07_vctr        : std_logic_vector(255 downto 0)  := (others => '0');
signal src_sends            : std_logic:= '0';
signal src_rcvs             : std_logic:= '0';
signal dest_reqs            : std_logic:= '0';
signal stat_reg0x           : std_logic_vector(9 downto 0)  := (others => '0');
signal gate_re_eventx       : std_logic:= '0';
signal gate_fe_eventx       : std_logic:= '0';
signal sync_re_eventx       : std_logic:= '0';
signal sync_fe_eventx       : std_logic:= '0';
signal pps_re_eventx        : std_logic:= '0';
signal pps_fe_eventx        : std_logic:= '0';
signal sysref_re_eventx     : std_logic:= '0';
signal sysref_fe_eventx     : std_logic:= '0';
signal t1_s_axi_csr_aresetn : std_logic:= '0';
signal src_arst             : std_logic:= '0';
signal cdc_arst             : std_logic:= '0';
---------------------------------------------------------------------------------

begin

awaddr <= '0' & s_axi_csr_awaddr;
araddr <= '0' & s_axi_csr_araddr;

csr_inst: px_axil_csr_sb
  port map (
    s_axi_csr_aclk      => s_axi_csr_aclk,
    s_axi_csr_aresetn   => s_axi_csr_aresetn,
    s_axi_csr_awaddr    => awaddr,
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
    s_axi_csr_araddr    => araddr,
    s_axi_csr_arprot    => s_axi_csr_arprot,
    s_axi_csr_arvalid   => s_axi_csr_arvalid,
    s_axi_csr_arready   => s_axi_csr_arready,
    s_axi_csr_rdata     => s_axi_csr_rdata,
    s_axi_csr_rresp     => s_axi_csr_rresp,
    s_axi_csr_rvalid    => s_axi_csr_rvalid,
    s_axi_csr_rready    => s_axi_csr_rready,
    reg0_init_val       => cntl_reg0_init_val,
    reg1_init_val       => cntl_reg1_init_val,
    reg2_init_val       => cntl_reg2_init_val,
    reg3_init_val       => cntl_reg3_init_val,
    reg4_init_val       => x"00000000",       
    reg5_init_val       => x"00000000",       
    reg6_init_val       => x"00000000",  
    reg7_init_val       => x"00000000",          
    ctl0_out            => cntl_reg0,
    ctl1_out            => cntl_reg1,
    ctl2_out            => cntl_reg2,
    ctl3_out            => cntl_reg3,
    ctl4_out            => cntl_reg4,
    ctl5_out            => cntl_reg5,
    ctl6_out            => cntl_reg6,
    ctl7_out            => cntl_reg7,
    stat0_in            => stat_reg0,
    intrpt_src_in       => int_src_stat,
    irq                 => irq
  );

--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------
-- Register Map
-- 0x00 Gate Receive Buffer Control
-- 0x04 Sync Receive Buffer Control
-- 0x08 Aux  Receive Buffer Control
-- 0x0C Source Select
-- 0x10 Gate Gen
-- 0x14 Sync Gen
-- 0x18 PPS Gen
-- 0x1C Sysref Gen
-- 0x20 Status Register
-- 0x24 Interrupt Enable Register
-- 0x28 Interrupt Status Register
-- 0x2C Interrupt Flag Register

-- Gate Receive Buffer Control
-- [8:0]   gate_tap_delay[8:0]
-- [9]     gate tap delay load
-- [13:12] gate_int_delay[1:0] 
-- [24:16] ttl_trig_tap_delay[8:0]
-- [25]    trig tap delay load
-- [29:28] ttl_trig_int_delay[1:0] 
-- Sync Receive Buffer Control
-- [8:0]   sync_tap_delay[8:0]
-- [9]     sync tap delay load
-- [13:12] sync_int_delay[1:0] 
-- Sysref Receive Buffer Control
-- [8:0]   sysref_tap_delay[8:0]
-- [9]     sysref tap delay load
-- [10]    sysref_sel 0 = SYSREF IDELAY direct 1 = SYSREF MUX
-- [13:12] sysref_int_delay[1:0] 
-- Source Control Register
-- [0]     reserved
-- [1]     reserved
-- [6:4]   gate_rcv_src[2:0] 
-- [10:8]  sync_rcv_src[2:0] 
-- [15:12] pps_rcv_src[3:0] 
-- [19:16] sysref_rcv_src[3:0]
-- [22:20] reserved      
-- [26:24] led_src[1:0]
-- Gate Generate    
-- [0]     gate_reg_gen    
-- Sync Generate      
-- [0]     sync_reg_gen    
-- PPS Generate      
-- [0]     pps_reg_gen
-- Sysref Generate      
-- [0]     sysref_reg_gen
   
cntrl07_vctr <= cntl_reg7 & cntl_reg6 & cntl_reg5 & cntl_reg4 & cntl_reg3 & cntl_reg2 & cntl_reg1 & cntl_reg0;

cntl06_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 4, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 4, -- integer; range: 2-10
  WIDTH          => 256  -- integer; range: 1-1024
)
port map (

  src_clk  => s_axi_csr_aclk,
  src_in   => cntrl07_vctr ,
  src_send => src_send07,
  src_rcv  => src_rcv07,
  dest_clk => axis_aclk,
  dest_req => dest_req07,
  dest_ack => dest_req07, 
  dest_out => cntrlx07_vctr
);

cntl_reg0x <= cntrlx07_vctr(31 downto 0);
cntl_reg1x <= cntrlx07_vctr(63 downto 32);
cntl_reg2x <= cntrlx07_vctr(95 downto 64);
cntl_reg3x <= cntrlx07_vctr(127 downto 96);
cntl_reg4x <= cntrlx07_vctr(159 downto 128);
cntl_reg5x <= cntrlx07_vctr(191 downto 160);
cntl_reg6x <= cntrlx07_vctr(223 downto 192);
cntl_reg7x <= cntrlx07_vctr(255 downto 224);
   
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
     if (src_rcv07 = '1') then
       src_send07 <= '0';
     elsif (src_rcv07 = '0') and (src_send07 = '0') then
       src_send07 <= '1';
     end if;  
   end if;
end process;   

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      gate_tap_delay            <= cntl_reg0(8 downto 0); 
      trig_ttl_tap_delay        <= cntl_reg0(24 downto 16);
      sync_tap_delay            <= cntl_reg1(8 downto 0); 
      sysref_tap_delay          <= cntl_reg2(8 downto 0);
      gate_dly_ld_ctl           <= cntl_reg0(9); 
      trig_dly_ld_ctl           <= cntl_reg0(25); 
      sync_dly_ld_ctl           <= cntl_reg1(9); 
      sysref_dly_ld_ctl         <= cntl_reg2(9); 
   end if;
end process;  

process(axis_aclk)
begin
    if rising_edge(axis_aclk) then   
       gate_int_delay            <= cntl_reg0x(13 downto 12);
       trig_ttl_int_delay        <= cntl_reg0x(29 downto 28);
             
       sync_int_delay            <= cntl_reg1x(13 downto 12);
               
       sysref_int_delay          <= cntl_reg2x(13 downto 12);
       sysref_sel                <= cntl_reg2x(10);
        
       gate_rcv_src              <= cntl_reg3x(6 downto 4);    
       sync_rcv_src              <= cntl_reg3x(10 downto 8);  
       pps_rcv_src               <= cntl_reg3x(15 downto 12); 
       sysref_rcv_src            <= cntl_reg3x(19 downto 16);  
       led_src                   <= cntl_reg3x(25 downto 24); 
       
       gate_reg_gen              <= cntl_reg4x(0);  
       sync_reg_gen              <= cntl_reg5x(0);
       pps_reg_gen               <= cntl_reg6x(0);  
       sysref_reg_gen            <= cntl_reg7x(0);       
    end if;                       
end process;                      

--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------

stat_reg0x<= selected_pps &  
             selected_sync & 
             selected_gate &
             selected_sysref &
             rtc_pps_pin & 
             ttl_pps_pin &
             ttl_trig_pin &
             diff_sync_pin &
             diff_gate_pin &
             sysref_pin;

stat_xclk:  xpm_cdc_handshake
generic map (
  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 3, -- integer; range: 2-10
  WIDTH          => 10  -- integer; range: 1-1024
)
port map (
  src_clk  => axis_aclk,
  src_in   => stat_reg0x,
  src_send => src_sends,
  src_rcv  => src_rcvs,
  dest_clk => s_axi_csr_aclk,
  dest_req => dest_reqs,
  dest_ack => dest_reqs, 
  dest_out => stat_reg0(9 downto 0)
);

stat_reg0(31 downto 10) <= "00" & x"00000"; 
   
process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
     if (src_rcvs = '1') then
       src_sends <= '0';
     elsif (src_rcvs = '0') and (src_sends = '0') then
       src_sends <= '1';
     end if;  
   end if;
end process;   

--------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------

xpm_cdc_async_rst_inst : xpm_cdc_async_rst
   generic map (
      DEST_SYNC_FF => 3,    -- DECIMAL; range: 2-10
      INIT_SYNC_FF => 1,    -- DECIMAL; 0=disable simulation init values, 1=enable simulation init values
      RST_ACTIVE_HIGH => 1  -- DECIMAL; 0=active low reset, 1=active high reset
   )
   port map (
      dest_arst => cdc_arst, -- 1-bit output: src_arst asynchronous reset signal synchronized to destination
                              -- clock domain. This output is registered. NOTE: Signal asserts asynchronously
                              -- but deasserts synchronously to dest_clk. Width of the reset signal is at least
                              -- (DEST_SYNC_FF*dest_clk) period.

      dest_clk => axis_aclk,   -- 1-bit input: Destination clock.
      src_arst => src_arst    -- 1-bit input: Source asynchronous reset signal.
   );

src_arst <= not t1_s_axi_csr_aresetn;

gate_re_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_aclk,
    src_rst    => cdc_arst,  -- optional; required when RST_USED = 1
    src_pulse  => gate_re_event,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => gate_re_eventx
);

sync_re_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_aclk,
    src_rst    => cdc_arst,  -- optional; required when RST_USED = 1
    src_pulse  => sync_re_event,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => sync_re_eventx
);

pps_re_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_aclk,
    src_rst    => cdc_arst,  -- optional; required when RST_USED = 1
    src_pulse  => pps_re_event,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => pps_re_eventx
);

sysref_re_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_aclk,
    src_rst    => cdc_arst,  -- optional; required when RST_USED = 1
    src_pulse  => sysref_re_event,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => sysref_re_eventx
);

gate_fe_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_aclk,
    src_rst    => cdc_arst,  -- optional; required when RST_USED = 1
    src_pulse  => gate_fe_event,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => gate_fe_eventx
);

sync_fe_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_aclk,
    src_rst    => cdc_arst,  -- optional; required when RST_USED = 1
    src_pulse  => sync_fe_event,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => sync_fe_eventx
);

pps_fe_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_aclk,
    src_rst    => cdc_arst,  -- optional; required when RST_USED = 1
    src_pulse  => pps_fe_event,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => pps_fe_eventx
);

sysref_fe_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_aclk,
    src_rst    => cdc_arst,  -- optional; required when RST_USED = 1
    src_pulse  => sysref_fe_event,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => sysref_fe_eventx
);


int_src_stat <= sysref_fe_eventx & pps_fe_eventx & sync_fe_eventx & gate_fe_eventx &
                sysref_re_eventx & pps_re_eventx & sync_re_eventx & gate_re_eventx; 
               
end Behavioral;