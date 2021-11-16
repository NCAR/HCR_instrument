----------------------------------------------------------------------------------
-- Control/Status Registers for Pentek Data Stream  to HMC DMA
----------------------------------------------------------------------------------
-- px_dma_timestamp_csr.vhd
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
--  

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
----------------------------------------------------------------------------------

-- Register Map
-- 0x00 Mode Control                    R/W   
-- 0x04 Sample Counter Init Value       R/W   
-- 0x08 PPS Counter Init Value          R/W
-- 0x0C Sample Counter Incr Value       R/W
-- 0x10 Sample Counter Value Read-back  RO 
-- 0x14 PPS Counter Value Read-back     RO 
-- 0x18 Interrupt Enables               R/W
-- 0x1C Interrupt Status Register       RO 
-- 0x20 Interrupt Flag Register         R/Clr

-- Control
--Bit [0] - Counter Reset
--Bit [1] - Arm Load 
--Bit [2] - Arm Clear 
--Bit [3] - PPS Mode
--Bit [4] - PPS Active Edge
--Bit [5] - PPS Count Enable
--Bit [6] - Counter Load En
--Bit [7] - Latch Readback
--Bit [10:8] - Counter Load Mode
    -- 000 Always on Arm
    -- 001 Always on Arm
    -- 010 PPS rising edge
    -- 011 PPS falling edge
    -- 100 SYNC rising edge
    -- 101 SYNC falling edge
    -- 110 Gate rising_edge
    -- 111 Gate falling edge 
--Bit [11] - Stay Armed

-- Interrupts
-- Bit [0] PPS rising edge
-- Bit [1] PPS falling edge
-- Bit [2] Sample Counter wrapped
-- Bit [3] PPS counter wrapped
-- Bit [4] Timestamp loaded

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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;
Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_timestamp_gen_sgate_csr is
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    s_axi_csr_aclk        : in  std_logic;
    s_axi_csr_aresetn     : in  std_logic;
    s_axi_csr_awaddr      : in  std_logic_vector(6 downto 0); -- only [5:0] used
    s_axi_csr_awprot      : in  std_logic_vector(2 downto 0);
    s_axi_csr_awvalid     : in  std_logic;
    s_axi_csr_awready     : out std_logic;
    s_axi_csr_wdata       : in  std_logic_vector(31 downto 0);
    s_axi_csr_wstrb       : in  std_logic_vector(3 downto 0);
    s_axi_csr_wvalid      : in  std_logic;
    s_axi_csr_wready      : out std_logic;
    s_axi_csr_bresp       : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid      : out std_logic;
    s_axi_csr_bready      : in  std_logic;
    s_axi_csr_araddr      : in  std_logic_vector(6 downto 0);  -- only [5:0] used
    s_axi_csr_arprot      : in  std_logic_vector(2 downto 0);
    s_axi_csr_arvalid     : in  std_logic;
    s_axi_csr_arready     : out std_logic;
    s_axi_csr_rdata       : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp       : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid      : out std_logic;
    s_axi_csr_rready      : in  std_logic;
    
    irq                   : out std_logic; -- interrupt
    --------------------------------------------------------------------------------
    axis_aclk             : in  std_logic; -- clock for controls and status
    --------------------------------------------------------------------------------
    -- Control Outputs (synchronous to axis_aclk)
    --------------------------------------------------------------------------------   
    pps_active_edge       : out std_logic;
    cntr_rst              : out std_logic;
    arm_load              : out std_logic;
    arm_clr               : out std_logic;
    stay_armed            : out std_logic;
    pps_mode              : out std_logic;
    pps_count_en          : out std_logic;
    count_load_mode       : out std_logic_vector(2 downto 0);
    count_load_en         : out std_logic;
    latch_readback        : out std_logic;
    sample_cntr_init_val  : out std_logic_vector(31 downto 0);
    pps_cntr_init_val     : out std_logic_vector(31 downto 0);
    sample_cntr_incr_val  : out std_logic_vector(31 downto 0);
--------------------------------------------------------------------------------
-- Status Inputs (synchronous to axis_aclk)
--------------------------------------------------------------------------------       	           
    sample_cnt            : in std_logic_vector(31 downto 0);
    pps_cnt               : in std_logic_vector(31 downto 0); 
 -------------------------------------------------------------------------------
-- Interrupt Sources (synchronous to axis_aclk)
--------------------------------------------------------------------------------
    pps_rising_edge_event : in std_logic;
    pps_falling_edge_event: in std_logic;
    sample_cntr_wrap_event: in std_logic;
    pps_cntr_wrap_event   : in std_logic;
    timestamp_load_event  : in std_logic;
    load_armed            : in std_logic  
);
end px_timestamp_gen_sgate_csr;

architecture Behavioral of px_timestamp_gen_sgate_csr is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Generic Control/Status Register Set
component px_axil_csr_ts
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
    ctl0_out : out std_logic_vector(31 downto 0);
    ctl1_out : out std_logic_vector(31 downto 0);
    ctl2_out : out std_logic_vector(31 downto 0);
    ctl3_out : out std_logic_vector(31 downto 0);
    stat0_in : in std_logic_vector(31 downto 0);
    stat1_in : in std_logic_vector(31 downto 0);
    intrpt_src_in : in std_logic_vector(5 downto 0);
    irq : out std_logic
  );
end component;

---------------------------------------------------------------------------------
-- Constants
---------------------------------------------------------------------------------
-- 0x00 Mode Control                    R/W   
-- 0x04 Sample Counter Init Value       R/W   
-- 0x08 PPS Counter Init Value          R/W
-- 0x0C Sample Counter Value Read-back  RO 
-- 0x10 PPS Counter Value Read-back     RO 
-- 0x14 Interrupt Enables               R/W
-- 0x18 Interrupt Status Register       RO 
-- 0x1C Interrupt Flag Register         R/Clr

constant MODE_CNTL_REG_INIT_VAL           : std_logic_vector(31 downto 0) := x"00000000";
constant SAMPLE_CNTR_REG_INIT_VAL         : std_logic_vector(31 downto 0) := x"00000000";
constant PPS_CNTR_REG_INIT_VAL            : std_logic_vector(31 downto 0) := x"00000000";
constant SAMPLE_CNTR_INCR_REG_INIT_VAL    : std_logic_vector(31 downto 0) := x"00000001";

---------------------------------------------------------------------------------
-- Signals
---------------------------------------------------------------------------------
 
signal cntl_reg0            : std_logic_vector(31 downto 0) := MODE_CNTL_REG_INIT_VAL;
signal cntl_reg1            : std_logic_vector(31 downto 0) := SAMPLE_CNTR_REG_INIT_VAL;
signal cntl_reg2            : std_logic_vector(31 downto 0) := PPS_CNTR_REG_INIT_VAL;
signal cntl_reg3            : std_logic_vector(31 downto 0) := SAMPLE_CNTR_INCR_REG_INIT_VAL;
signal cntl_reg0x           : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg1x           : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg2x           : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg3x           : std_logic_vector(31 downto 0) := (others => '0');
signal stat_reg0            : std_logic_vector(31 downto 0) := (others => '0');
signal stat_reg1            : std_logic_vector(31 downto 0) := (others => '0');
signal int_src_stat         : std_logic_vector(5 downto 0):= (others => '0');
signal t1_cntl_reg0_1       : std_logic:= '0';
signal awaddr               : std_logic_vector(6 downto 0):= (others => '0');
signal araddr               : std_logic_vector(6 downto 0):= (others => '0');
signal src_send02           : std_logic:= '0';
signal src_rcv02            : std_logic:= '0';
signal dest_req02           : std_logic:= '0';
signal cntrl02_vctr         : std_logic_vector(127 downto 0)  := (others => '0');
signal cntrlx02_vctr        : std_logic_vector(127 downto 0)  := (others => '0');
signal src_sends            : std_logic:= '0';
signal src_rcvs             : std_logic:= '0';
signal dest_reqs            : std_logic:= '0';
signal src_senda            : std_logic:= '0';
signal src_rcva             : std_logic:= '0';
signal dest_reqa            : std_logic:= '0';
signal gate_re_eventx       : std_logic:= '0';
signal gate_fe_eventx       : std_logic:= '0';
signal sync_re_eventx       : std_logic:= '0';
signal sync_fe_eventx       : std_logic:= '0';
signal pps_re_eventx        : std_logic:= '0';
signal pps_fe_eventx        : std_logic:= '0';
signal stat_regx            : std_logic_vector(63 downto 0) := (others => '0');
signal stat_reg             : std_logic_vector(63 downto 0) := (others => '0');
signal pps_rising_edge_eventx : std_logic:= '0';
signal pps_falling_edge_eventx: std_logic:= '0';
signal sample_cntr_wrap_eventx: std_logic:= '0';
signal pps_cntr_wrap_eventx   : std_logic:= '0';
signal timestamp_load_eventx  : std_logic:= '0';
signal load_armedx           : std_logic:= '0';  
signal arm_load_p           : std_logic:= '0';
---------------------------------------------------------------------------------

begin

awaddr  <= s_axi_csr_awaddr;
araddr  <= s_axi_csr_araddr;

csr_inst: px_axil_csr_ts
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
    reg0_init_val       => MODE_CNTL_REG_INIT_VAL,  
    reg1_init_val       => SAMPLE_CNTR_REG_INIT_VAL,
    reg2_init_val       => PPS_CNTR_REG_INIT_VAL,
    reg3_init_val       => SAMPLE_CNTR_INCR_REG_INIT_VAL,
    ctl0_out            => cntl_reg0,
    ctl1_out            => cntl_reg1,
    ctl2_out            => cntl_reg2,
    ctl3_out            => cntl_reg3,
    stat0_in            => stat_reg0,
    stat1_in            => stat_reg1,
    intrpt_src_in       => int_src_stat,
    irq                 => irq
  );

--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------

-- Control
--Bit [0] - Counter Reset
--Bit [1] - Arm Load 
--Bit [2] - Arm Clear 
--Bit [3] - PPS Mode
--Bit [4] - PPS Active Edge
--Bit [5] - PPS Count Enable
--Bit [6] - Counter Load En
--Bit [7] - Latch Readback
--Bit [10:8] - Counter Load Mode
    -- 000 Always on Arm
    -- 001 AUX pulse rising edge
    -- 010 PPS rising edge
    -- 011 PPS falling edge
    -- 100 SYNC rising edge
    -- 101 SYNC falling edge
    -- 110 Gate rising_edge
    -- 111 Gate falling edge 
--Bit [11] - Stay Armed

cntrl02_vctr <= cntl_reg3 & cntl_reg2 & cntl_reg1 & cntl_reg0;

cntl06_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 4, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 4, -- integer; range: 2-10
  WIDTH          => 128  -- integer; range: 1-1024
)
port map (

  src_clk  => s_axi_csr_aclk,
  src_in   => cntrl02_vctr ,
  src_send => src_send02,
  src_rcv  => src_rcv02,
  dest_clk => axis_aclk,
  dest_req => dest_req02,
  dest_ack => dest_req02, 
  dest_out => cntrlx02_vctr
);

cntl_reg0x <= cntrlx02_vctr(31 downto 0);
cntl_reg1x <= cntrlx02_vctr(63 downto 32);
cntl_reg2x <= cntrlx02_vctr(95 downto 64);
cntl_reg3x <= cntrlx02_vctr(127 downto 96);
   
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     if (src_rcv02 = '1') then
       src_send02 <= '0';
     elsif (src_rcv02 = '0') and (src_send02 = '0') then
       src_send02 <= '1';
     end if;  
   end if;
end process;   

process(axis_aclk)
begin
    if rising_edge(axis_aclk) then
       cntr_rst             <= cntl_reg0x(0); 
       --arm_load             <= cntl_reg0x(1) and not t1_cntl_reg0_1;
       arm_clr              <= cntl_reg0x(2);
       pps_mode             <= cntl_reg0x(3);
       pps_active_edge      <= cntl_reg0x(4);
       pps_count_en         <= cntl_reg0x(5);
       count_load_en        <= cntl_reg0x(6);
       latch_readback       <= cntl_reg0x(7);
       count_load_mode      <= cntl_reg0x(10 downto 8);
       stay_armed           <= cntl_reg0x(11);
       sample_cntr_init_val <= cntl_reg1x;
       pps_cntr_init_val    <= cntl_reg2x;
       sample_cntr_incr_val <= cntl_reg3x;
       --t1_cntl_reg0_1      <= cntl_reg0x(1);
    end if;
end process;

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
       arm_load_p          <= cntl_reg0(1) and not t1_cntl_reg0_1;
       t1_cntl_reg0_1      <= cntl_reg0(1);
    end if;
end process;

arm_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 0, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => s_axi_csr_aclk,
    src_rst    => '0',  -- optional; required when RST_USED = 1
    src_pulse  => arm_load_p,
    dest_clk   => axis_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => arm_load
);

--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------

stat_regx(31 downto 0)  <= sample_cnt;
stat_regx(63 downto 32) <= pps_cnt; 

stat_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 4, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 4, -- integer; range: 2-10
  WIDTH          => 64  -- integer; range: 1-1024
)
port map (

  src_clk  => axis_aclk,
  src_in   => stat_regx,
  src_send => src_sends,
  src_rcv  => src_rcvs,
  dest_clk => s_axi_csr_aclk,
  dest_req => dest_reqs,
  dest_ack => dest_reqs, 
  dest_out => stat_reg
);

stat_reg0 <= stat_reg(31 downto 0);
stat_reg1 <= stat_reg(63 downto 32);
   
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

-- Interrupts
-- Bit [0] PPS rising edge
-- Bit [1] PPS falling edge
-- Bit [2] Sample Counter wrapped
-- Bit [3] PPS counter wrapped
-- Bit [4] Timestamp loaded
-- Bit [5] Load Armed

pps_rising_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 0, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_aclk,
    src_rst    => '0',  -- optional; required when RST_USED = 1
    src_pulse  => pps_rising_edge_event,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => pps_rising_edge_eventx
);

pps_fall_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 0, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_aclk,
    src_rst    => '0',  -- optional; required when RST_USED = 1
    src_pulse  => pps_falling_edge_event,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => pps_falling_edge_eventx
);

s_cntr_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 0, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_aclk,
    src_rst    => '0',  -- optional; required when RST_USED = 1
    src_pulse  => sample_cntr_wrap_event,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => sample_cntr_wrap_eventx
);

p_cntr_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 0, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_aclk,
    src_rst    => '0',  -- optional; required when RST_USED = 1
    src_pulse  => pps_cntr_wrap_event,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => pps_cntr_wrap_eventx
);

tsl_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 0, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_aclk,
    src_rst    => '0',  -- optional; required when RST_USED = 1
    src_pulse  => timestamp_load_event,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => timestamp_load_eventx
);

la_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 4, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 4, -- integer; range: 2-10
  WIDTH          => 1  -- integer; range: 1-1024
)
port map (
  src_clk    => axis_aclk,
  src_in(0)  => load_armed,
  src_send   => src_senda,
  src_rcv    => src_rcva,
  dest_clk   => s_axi_csr_aclk,
  dest_req   => dest_reqa,
  dest_ack   => dest_reqa, 
  dest_out(0)=> load_armedx
);

process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
     if (src_rcva = '1') then
       src_senda <= '0';
     elsif (src_rcva = '0') and (src_senda = '0') then
       src_senda <= '1';
     end if;  
   end if;
end process;   

int_src_stat <= load_armedx & timestamp_load_eventx & pps_cntr_wrap_eventx &
                sample_cntr_wrap_eventx &  pps_falling_edge_eventx & pps_rising_edge_eventx;

                       
end Behavioral;