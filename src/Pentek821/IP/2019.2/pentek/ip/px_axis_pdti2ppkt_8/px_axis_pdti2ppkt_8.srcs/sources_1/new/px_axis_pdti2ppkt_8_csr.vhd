----------------------------------------------------------------------------------
-- Control/Status Registers for Pentek Axi-Stream Data Stream Controller
----------------------------------------------------------------------------------
-- ptk_axis_pdti2ppkt_8_csr.vhd
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
-- Revision 1.00 - File Created
-- Revision 1.10 - 4/20/17 Fixed Retrigger behavior and added BAD_TRIG Interrupt source
-- Revision ---- - 8/29/19 Added wc_sync_enable - This signal allows the SYNC A signal 
--                         to reset the width converter. When operating in 8-bit mode 
--                         the data flow control core creates 8-bit samples out of the 
--                         incoming stream of 16-bit samples. Resetting this width 
--                         converter using the SYNC signal ensures that the width 
--                         conversion is started simultaneously across different 
--                         channels or boards.   Also gated t2_gate with t3_trig_hold
--                         to prevent data discontinuities.


-- Additional Comments: 
--  

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
----------------------------------------------------------------------------------

-- Register Map
-- 0x00 Mode Control                    R/W   
-- 0x04 Trigger Clear                   R/W  
-- 0x08 Trigger Delay Value             R/W
-- 0x0C Trigger Length Value            R/W
-- 0x10 TimeStamp Start (Lower)         R/W
-- 0x14 TimeStamp Start (Upper)         R/W
-- 0x18 TimeStamp End   (Lower)         R/W
-- 0x1C TimeStamp End   (Upper)         R/W
-- 0x20 Status                          RO 
-- 0x34 Interrupt Enables               R/W
-- 0x38 Interrupt Status Register       RO 
-- 0x3C Interrupt Flag Register         R/Clr

-- Mode Control Register
--Bit [0]   - trig_arm
--Bit [1]   - stay_armed
--Bit [3:2] - mode_sel[1:0]
            --  "00" = Gate Mode
            --  "01" = Trig Mode
            --  "10" = Trig Hold Mode
            --  "11" = Timestamp Mode 
--Bit [5:4] - data_mode_sel[1:0]
            -- "00" = Single Sample Real Data
            -- "01" = Packed I/Q Data
            -- "10" = Packed Real Data
            -- "11" = Unpacked I/Q
-- Bit 6    -- local gate reg mode
-- Bit 7    -- Local gate register bit  
-- Bit 8    -- Width converter sync enable
-- Trigger Clear Register
-- Bit [0] - Trigger Clear
-- Bit [1] - Disarm after trigger ends

----------------------------------------------------------------------------------

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
Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axis_pdti2ppkt_8_csr is
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    s_axi_csr_aclk        : in  std_logic;
    s_axi_csr_aresetn     : in  std_logic;
    s_axi_csr_awaddr      : in  std_logic_vector(5 downto 0); -- only [5:0] used
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
    s_axi_csr_araddr      : in  std_logic_vector(5 downto 0);  -- only [5:0] used
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
    trig_clear            : out std_logic;
    trig_arm              : out std_logic;
    disarm                : out std_logic;
    mode_sel              : out std_logic_vector(1 downto 0);
    data_mode_sel         : out std_logic_vector(1 downto 0);
    stay_armed            : out std_logic;
    trig_dly              : out std_logic_vector(31 downto 0);
    trig_len              : out std_logic_vector(31 downto 0);
    strt_ts_ldw           : out std_logic_vector(31 downto 0);
    strt_ts_udw           : out std_logic_vector(31 downto 0);  
    end_ts_ldw            : out std_logic_vector(31 downto 0);
    end_ts_udw            : out std_logic_vector(31 downto 0);
    local_gate_mode       : out std_logic; 
    local_gate            : out std_logic; 
    wc_sync_en            : out std_logic;
    --------------------------------------------------------------------------------
    -- Status Inputs (synchronous to axis_aclk)
    --------------------------------------------------------------------------------     
    waiting_arm           : in  std_logic;     
    armed                 : in  std_logic;
    active                : in  std_logic;
    mode                  : in  std_logic_vector(1 downto 0);
    data_mode             : in  std_logic_vector(1 downto 0);
     --------------------------------------------------------------------------------
    -- Interrupt Sources (synchronous to axis_aclk)
    --------------------------------------------------------------------------------    
    acq_start             : in  std_logic;  
    acq_end               : in  std_logic;  
    waiting_arm_re        : in  std_logic;  
    armed_re              : in  std_logic;
    bad_trig              : in  std_logic 
);
end px_axis_pdti2ppkt_8_csr;

architecture Behavioral of px_axis_pdti2ppkt_8_csr is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------
-- Generic Control/Status Register Set
component px_axil_csr_flw_8
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
    stat1_in : in std_logic_vector(31 downto 0);
    stat2_in : in std_logic_vector(31 downto 0);
    stat3_in : in std_logic_vector(31 downto 0);
    stat4_in : in std_logic_vector(31 downto 0);
    intrpt_src_in : in std_logic_vector(4 downto 0);
    irq : out std_logic
  );
end component;

---------------------------------------------------------------------------------
-- Constants
---------------------------------------------------------------------------------

constant MODE_CNTL_REG_INIT_VAL     : std_logic_vector(31 downto 0) := x"00000000";
constant CLEAR_REG_INIT_VAL         : std_logic_vector(31 downto 0) := x"00000000";
constant TRIG_DLY_REG_INIT_VAL      : std_logic_vector(31 downto 0) := x"00000000";
constant TRIG_LENGTH_REG_INIT_VAL   : std_logic_vector(31 downto 0) := x"00000010";
constant TS_STRT_L_REG_INIT_VAL     : std_logic_vector(31 downto 0) := x"00000000";
constant TS_STRT_U_REG_INIT_VAL     : std_logic_vector(31 downto 0) := x"00000000";
constant TS_END_L_REG_INIT_VAL      : std_logic_vector(31 downto 0) := x"00000010";
constant TS_END_U_REG_INIT_VAL      : std_logic_vector(31 downto 0) := x"00000000";

---------------------------------------------------------------------------------
-- Signals
---------------------------------------------------------------------------------
 
signal cntl_reg0            : std_logic_vector(31 downto 0) := MODE_CNTL_REG_INIT_VAL;
signal cntl_reg1            : std_logic_vector(31 downto 0) := CLEAR_REG_INIT_VAL;
signal cntl_reg2            : std_logic_vector(31 downto 0) := TRIG_DLY_REG_INIT_VAL; 
signal cntl_reg3            : std_logic_vector(31 downto 0) := TRIG_LENGTH_REG_INIT_VAL; 
signal cntl_reg4            : std_logic_vector(31 downto 0) := TS_STRT_L_REG_INIT_VAL;   
signal cntl_reg5            : std_logic_vector(31 downto 0) := TS_STRT_U_REG_INIT_VAL;   
signal cntl_reg6            : std_logic_vector(31 downto 0) := TS_END_L_REG_INIT_VAL;    
signal cntl_reg7            : std_logic_vector(31 downto 0) := TS_END_U_REG_INIT_VAL;
signal stat_reg0            : std_logic_vector(31 downto 0) := (others => '0');
signal int_src_stat         : std_logic_vector(4 downto 0)  := (others => '0');
signal t1_cntl_reg0_0       : std_logic:= '0';
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
signal stat_reg0x           : std_logic_vector(6 downto 0)  := (others => '0');
signal armed_rex            : std_logic:= '0';
signal waiting_arm_rex      : std_logic:= '0'; 
signal acq_endx             : std_logic:= '0';
signal acq_startx           : std_logic:= '0';
signal trig_arm_p           : std_logic:= '0';
signal rs_axi_csr_areset    : std_logic := '0';
signal s_axi_csr_areset     : std_logic := '0';
signal bad_trigx            : std_logic := '0';
---------------------------------------------------------------------------------

begin

awaddr <= '0' & s_axi_csr_awaddr;
araddr <= '0' & s_axi_csr_araddr;

csr_inst: px_axil_csr_flw_8
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
    reg1_init_val       => CLEAR_REG_INIT_VAL,     
    reg2_init_val       => TRIG_DLY_REG_INIT_VAL,
    reg3_init_val       => TRIG_LENGTH_REG_INIT_VAL,   
    reg4_init_val       => TS_STRT_L_REG_INIT_VAL,     
    reg5_init_val       => TS_STRT_U_REG_INIT_VAL,     
    reg6_init_val       => TS_END_L_REG_INIT_VAL,      
    reg7_init_val       => TS_END_U_REG_INIT_VAL,        
    ctl0_out            => cntl_reg0,
    ctl1_out            => cntl_reg1,
    ctl2_out            => cntl_reg2,
    ctl3_out            => cntl_reg3,
    ctl4_out            => cntl_reg4,
    ctl5_out            => cntl_reg5,
    ctl6_out            => cntl_reg6,
    ctl7_out            => cntl_reg7,
    stat0_in            => stat_reg0,
    stat1_in            => x"00000000",
    stat2_in            => x"00000000",
    stat3_in            => x"00000000",
    stat4_in            => x"00000000",
    intrpt_src_in       => int_src_stat,
    irq                 => irq
  );

--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------

-- Mode Control Register
--Bit [0]   - trig_arm
--Bit [1]   - stay_armed
--Bit [3:2] - mode_sel[1:0]
            --  "00" = Gate Mode
            --  "01" = Trig Mode
            --  "10" = Trig Hold Mode
            --  "11" = Timestamp Mode 
--Bit [5:4] - data_mode_sel[1:0]
            -- "00" = Single Sample Real Data
            -- "01" = Packed I/Q Data
            -- "10" = Packed Real Data
            -- "11" = Unpacked I/Q
-- Bit 6    -- local gate reg mode
-- Bit 7    -- Local gate register bit            
-- Bit 8    -- Multi-board sync enable
-- Trigger Clear Register
-- Bit [0] - Trigger Clear

cntrl07_vctr <= cntl_reg7 & cntl_reg6 & cntl_reg5 & cntl_reg4 & cntl_reg3 & cntl_reg2 & cntl_reg1 & cntl_reg0;

cntl07_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 3, -- integer; range: 2-10
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
   
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
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
       trig_arm_p          <= cntl_reg0(0) and not t1_cntl_reg0_0;
       t1_cntl_reg0_0      <= cntl_reg0(0);
    end if;
end process;

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
    src_rst    => rs_axi_csr_areset,  -- optional; required when RST_USED = 1
    src_pulse  => trig_arm_p,
    dest_clk   => axis_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => trig_arm
);

stay_armed          <= cntrlx07_vctr(1);
mode_sel            <= cntrlx07_vctr(3 downto 2);
data_mode_sel       <= cntrlx07_vctr(5 downto 4);    
local_gate_mode     <= cntrlx07_vctr(6);
local_gate          <= cntrlx07_vctr(7);
wc_sync_en          <= cntrlx07_vctr(8);
trig_clear          <= cntrlx07_vctr(32);
disarm              <= cntrlx07_vctr(33);
trig_dly            <= cntrlx07_vctr(95 downto 64)  ;
trig_len            <= cntrlx07_vctr(127 downto 96) ;
strt_ts_ldw         <= cntrlx07_vctr(159 downto 128);
strt_ts_udw         <= cntrlx07_vctr(191 downto 160);                         
end_ts_ldw          <= cntrlx07_vctr(223 downto 192);
end_ts_udw          <= cntrlx07_vctr(255 downto 224);

--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------
stat_reg0x <= data_mode & mode & active & armed & waiting_arm;

stat_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 3, -- integer; range: 2-10
  WIDTH          => 7  -- integer; range: 1-1024
)
port map (

  src_clk  => axis_aclk,
  src_in   => stat_reg0x,
  src_send => src_sends,
  src_rcv  => src_rcvs,
  dest_clk => s_axi_csr_aclk,
  dest_req => dest_reqs,
  dest_ack => dest_reqs, 
  dest_out => stat_reg0(6 downto 0)
);

stat_reg0(31 downto 7) <= x"000000" & '0'; 
   
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
-- Bit [0] Start of Acquisition
-- Bit [1] End of Acquisition
-- Bit [2] Waiting for Arm Rising Edge
-- Bit [3] Armed Rising Edge

acq_start_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_aclk,
    src_rst    => rs_axi_csr_areset,  -- optional; required when RST_USED = 1
    src_pulse  => acq_start,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => acq_startx
);

acq_end_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_aclk,
    src_rst    => rs_axi_csr_areset,  -- optional; required when RST_USED = 1
    src_pulse  => acq_end,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => acq_endx
);

w_arm_re_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_aclk,
    src_rst    => rs_axi_csr_areset,  -- optional; required when RST_USED = 1
    src_pulse  => waiting_arm_re,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => waiting_arm_rex
);

armed_re_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_aclk,
    src_rst    => rs_axi_csr_areset,  -- optional; required when RST_USED = 1
    src_pulse  => armed_re,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => armed_rex
);

bt_cdc_inst: xpm_cdc_pulse
generic map (

  -- Common module generics
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
  RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
  SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
)
port map (
  src_clk    => axis_aclk, 
  src_rst    => rs_axi_csr_areset,   -- optional; required when RST_USED = 1
  src_pulse  => bad_trig,
  dest_clk   => s_axi_csr_aclk,
  dest_rst   => '0',  -- optional; required when RST_USED = 1
  dest_pulse => bad_trigx
); 

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
        s_axi_csr_areset <= not s_axi_csr_aresetn;
    end if;
end process;     

int_cdc_rst_inst: xpm_cdc_sync_rst
  generic map (

     -- Common module parameters
     DEST_SYNC_FF    => 3, -- integer; range: 2-10
     INIT            => 1, -- integer; 0=initialize synchronization registers to 0,
                           --          1=initialize synchronization registers to 1
     SIM_ASSERT_CHK  => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
     src_rst  => s_axi_csr_areset,
     dest_clk => axis_aclk,
     dest_rst => rs_axi_csr_areset
  );

int_src_stat <= bad_trigx & armed_rex & waiting_arm_rex & acq_endx & acq_startx;

                       
end Behavioral;