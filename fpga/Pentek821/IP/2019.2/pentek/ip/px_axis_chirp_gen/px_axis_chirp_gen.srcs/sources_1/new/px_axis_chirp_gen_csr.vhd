----------------------------------------------------------------------------------
-- Control/Status Registers for Pentek Chirp Generator
----------------------------------------------------------------------------------
-- ptk_axis_chirp_gen_csr.vhd
--
-- Target Device: Kintex UltraScale
--
-- Pentek Inc.
-- One Park Way, Upper Saddle River, NJ 07458
-- (201)818-5900
-- www.pentek.com
--
-- Copyright Pentek, Inc. 2017
--
-- Revision:
-- Revision 0.01 - File Created


-- Additional Comments: 
--  

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
----------------------------------------------------------------------------------

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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;
Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axis_chirp_gen_csr is
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
end  px_axis_chirp_gen_csr;

architecture Behavioral of px_axis_chirp_gen_csr is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Generic Control/Status Register Set
component px_axil_csr_chrpg
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
    ctl0_out : out std_logic_vector(31 downto 0);
    ctl1_out : out std_logic_vector(31 downto 0);
    ctl2_out : out std_logic_vector(31 downto 0);
    ctl3_out : out std_logic_vector(31 downto 0);
    ctl4_out : out std_logic_vector(31 downto 0);
    intrpt_src_in : in std_logic_vector(2 downto 0);
    irq : out std_logic
  );
end component;

---------------------------------------------------------------------------------
-- Constants
---------------------------------------------------------------------------------
-- 0x00 Mode Control
-- 0x04 Frequency Value
-- 0x08 Phase Offset
-- 0x0C Frequency ramp rate
-- 0x10 Pulse Width
-- 0x14 Interrupt Enables
-- 0x18 Interrupt Status Register
-- 0x1C Interrupt Flag Register 

constant MODE_CNTL_REG_INIT_VAL           : std_logic_vector(31 downto 0) := x"04001000";
constant FREQ_REG_INIT_VAL                : std_logic_vector(31 downto 0) := x"00000000";

---------------------------------------------------------------------------------
-- Signals
---------------------------------------------------------------------------------
 
signal cntl_reg0            : std_logic_vector(31 downto 0) := MODE_CNTL_REG_INIT_VAL;
signal cntl_reg1            : std_logic_vector(31 downto 0) := FREQ_REG_INIT_VAL;
signal cntl_reg2            : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg3            : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg4            : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg0x           : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg1x           : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg2x           : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg3x           : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg4x           : std_logic_vector(31 downto 0) := (others => '0');
signal int_src_stat         : std_logic_vector(2 downto 0)  := (others => '0');
signal t1_cntl_reg0_1       : std_logic:= '0';
signal awaddr               : std_logic_vector(6 downto 0)  := (others => '0');
signal araddr               : std_logic_vector(6 downto 0)  := (others => '0');
signal src_send01           : std_logic:= '0';
signal src_rcv01            : std_logic:= '0';
signal dest_req01           : std_logic:= '0';
signal cntrl01_vctr         : std_logic_vector(159 downto 0)  := (others => '0');
signal cntrlx01_vctr        : std_logic_vector(159 downto 0)  := (others => '0');
signal src_sends            : std_logic:= '0';
signal src_rcvs             : std_logic:= '0';
signal dest_reqs            : std_logic:= '0';
signal src_senda            : std_logic:= '0';
signal src_rcva             : std_logic:= '0';
signal dest_reqa            : std_logic:= '0';
signal trig_eventsx         : std_logic:= '0';
signal trig_eventex         : std_logic:= '0';
signal trig_armedx          : std_logic:= '0';
signal arm_load_p           : std_logic:= '0';
signal s_axi_csr_areset     : std_logic:= '0';
signal calc_start           : std_logic:= '0';
signal t1_calc_start        : std_logic:= '0';
signal calc_start_re        : std_logic:= '0';
signal axis_rst             : std_logic:= '0';
---------------------------------------------------------------------------------

begin

awaddr <= "00" & s_axi_csr_awaddr;
araddr <= "00" & s_axi_csr_araddr;

csr_inst: px_axil_csr_chrpg
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
    reg1_init_val       => FREQ_REG_INIT_VAL,     
    reg2_init_val       => x"00000000",
    reg3_init_val       => x"00000000", 
    reg4_init_val       => x"00000000",        
    ctl0_out            => cntl_reg0,
    ctl1_out            => cntl_reg1,
    ctl2_out            => cntl_reg2,
    ctl3_out            => cntl_reg3,
    ctl4_out            => cntl_reg4,
    intrpt_src_in       => int_src_stat,
    irq                 => irq
  );

--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------

-- Control
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

cntrl01_vctr <= cntl_reg4 & cntl_reg3 & cntl_reg2 & cntl_reg1 & cntl_reg0;

cntl01_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 3, -- integer; range: 2-10
  WIDTH          => 160 -- integer; range: 1-1024
)
port map (

  src_clk  => s_axi_csr_aclk,
  src_in   => cntrl01_vctr ,
  src_send => src_send01,
  src_rcv  => src_rcv01,
  dest_clk => axis_aclk,
  dest_req => dest_req01,
  dest_ack => dest_req01, 
  dest_out => cntrlx01_vctr
);

cntl_reg0x <= cntrlx01_vctr(31 downto 0);
cntl_reg1x <= cntrlx01_vctr(63 downto 32);
cntl_reg2x <= cntrlx01_vctr(95 downto 64);
cntl_reg3x <= cntrlx01_vctr(127 downto 96);
cntl_reg4x <= cntrlx01_vctr(159 downto 128);
   
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     s_axi_csr_areset <= not s_axi_csr_aresetn;
     if (src_rcv01 = '1') then
       src_send01 <= '0';
     elsif (src_rcv01 = '0') and (src_send01 = '0') then
       src_send01 <= '1';
     end if;  
   end if;
end process;   

process(axis_aclk)
begin
    if rising_edge(axis_aclk) then
       reg_rst             <= cntl_reg0x(0); 
       arm_clr             <= cntl_reg0x(2);
       stay_armed          <= cntl_reg0x(3);
       trig_sig_sel        <= cntl_reg0x(5 downto 4);
       gate_mode           <= cntl_reg0x(6);
       up_mode             <= cntl_reg0x(7);
       trig_clr            <= cntl_reg0x(8);
       calc_start          <= cntl_reg0x(9);
       gain                <= cntl_reg0x(31 downto 16);
       start_frq_incr      <= cntl_reg1x;
       phase_offset        <= cntl_reg2x;
       rate                <= cntl_reg3x;
       pulse_width         <= cntl_reg4x;
    end if;
end process;

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
       arm_load_p          <= cntl_reg0(1) and not t1_cntl_reg0_1;
       t1_cntl_reg0_1      <= cntl_reg0(1);
       t1_calc_start       <= calc_start;
       calc_start_re       <= calc_start and not t1_calc_start;
    end if;
end process;

calc_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => s_axi_csr_aclk,
    src_rst    => s_axi_csr_areset,  -- optional; required when RST_USED = 1
    src_pulse  => calc_start_re,
    dest_clk   => axis_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => calc_strt
);

arm_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => s_axi_csr_aclk,
    src_rst    => s_axi_csr_areset,  -- optional; required when RST_USED = 1
    src_pulse  => arm_load_p,
    dest_clk   => axis_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => arm
);

--------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------

-- Interrupts
-- Bit [0] Trig Armed
-- Bit [1] Trig Start Event
-- Bit [2] Trig End Event

tes_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_aclk,
    src_rst    => axis_rst,  -- optional; required when RST_USED = 1
    src_pulse  => trig_start_event,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => trig_eventsx
);

tee_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_aclk,
    src_rst    => axis_rst,  -- optional; required when RST_USED = 1
    src_pulse  => trig_end_event,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => trig_eventex
);

la_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_aclk,
    src_rst    => axis_rst,  -- optional; required when RST_USED = 1
    src_pulse  => trig_armed,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => trig_armedx
);

int_src_stat <= trig_eventex & trig_eventsx & trig_armedx;

rst_cdc_inst: xpm_cdc_async_rst
  generic map (

    -- Common module parameters
     DEST_SYNC_FF    => 2, -- integer; range: 2-10
     INIT_SYNC_FF    => 0, -- integer; 0=disable simulation init values, 1=enable simulation init values
     RST_ACTIVE_HIGH => 1  -- integer; 0=active low reset, 1=active high reset
  )
  port map (
     src_arst  => s_axi_csr_areset,
     dest_clk  => axis_aclk,
     dest_arst => axis_rst
  );



                    
end Behavioral;