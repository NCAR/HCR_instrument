----------------------------------------------------------------------------------
-- Control/Status Registers for Pentek Axi-Stream Data Stream Controller
----------------------------------------------------------------------------------
-- px_axis_ddr2wave_1_csr.vhd
--
-- Target Device: Kintex UltraScale
--
-- Pentek Inc.
-- One Park Way, Upper Saddle River, NJ 07458
-- (201)818-5900
-- www.pentek.com
--
-- Copyright Pentek, Inc. 2016
--
-- Revision:
-- Revision 1.0  - File Created
-- Revision 2.0  - Added Linked List support

-- Additional Comments: 
--  

----------------------------------------------------------------------------------
-- Register Map
-- 0x00 Mode Control                    R/W   
-- 0x04 Trigger Clear                   R/W  
-- 0x08 Linked List Start Address Load  R/W
-- 0x0C Linked List Start Address       R/W
-- 0x10 FIFO Flush                      R/W
-- 0x14 Output Rate Div                 R/W
-- 0x18 Output Gate Delay               R/W
-- 0x1C                                 R/W
-- 0x20 Status                          RO
-- 0x24 Current Link/Next Link          RO 
-- 0x28 
-- 0x2C 
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
            --  "11" = Reserved 
--Bit [5:4] - data_mode_sel[1:0]
            -- "00" = Time Packed Real Data (I(t1),I(t0))
            -- "01" = Channel Packed I/Q Data or two channel Real (Q(0), I(0)) 
            -- "10" = Reserved
            -- "11" = Reserved
-- Bit [6]  -- local gate reg mode
-- Bit [7]  -- Local gate register bit 
-- Linked List Start Address Load  Register
-- Bit [0]  -- Load LL Start Address
-- Linked List Start Address Load  Register
-- Bit [5:0] -- LL Start Address 
-- Trigger Clear Register
-- Bit [0] - Trigger Clear
-- Bit [1] - Disarm after trigger ends
-- FIFO Flush Register
-- Bit [0] - FIFO Flush
-- Current Link/Next Link Register
-- [5:0] - Current Link
-- [21:16] - Next Link   

-- Interrupts
-- Bit [0] Start of Acquisition
-- Bit [1] End of Acquisition
-- Bit [2] Waiting for Arm Rising Edge
-- Bit [3] Armed Rising Edge
-- Bit [4] Trig Start
-- Bit [5] Link Start Interrupt
-- Bit [6] Link End Interrupt
-- Bit [7] Bad Trigger - trigger occured before acq. ended
-- Bit [8] Real Time Lost 
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

entity px_axis_ddr2wave_1_csr is
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    axis_aclk             : in  std_logic; -- AXI-Stream Clock for clock domain crossing
    
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
    -- Control Outputs
    --------------------------------------------------------------------------------    
    trig_clear            : out std_logic;
    trig_arm              : out std_logic;
    disarm                : out std_logic;
    mode_sel              : out std_logic_vector(1 downto 0);
    data_mode_sel         : out std_logic_vector(1 downto 0);
    stay_armed            : out std_logic;
    fifo_flush            : out std_logic;
    local_gate_mode       : out std_logic; 
    local_gate            : out std_logic; 
    rate_div              : out std_logic_vector(15 downto 0);
    output_gate_delay     : out std_logic_vector(7 downto 0);
    ll_start_address      : out std_logic_vector(5 downto 0); 
    ll_start              : out std_logic;
    rt_clr                : out std_logic;     
    --------------------------------------------------------------------------------
    -- Status Inputs
    --------------------------------------------------------------------------------     
    waiting_arm           : in  std_logic;     
    armed                 : in  std_logic;
    active                : in  std_logic;
    mode                  : in  std_logic_vector(1 downto 0);
    data_mode             : in  std_logic_vector(1 downto 0);
    current_link          : in  std_logic_vector(5 downto 0);
    next_link             : in  std_logic_vector(5 downto 0);
     --------------------------------------------------------------------------------
    -- Interrupt Sources
    --------------------------------------------------------------------------------    
    acq_start             : in  std_logic;  
    acq_end               : in  std_logic;  
    waiting_arm_re        : in  std_logic;  
    armed_re              : in  std_logic;
    real_time_lost        : in  std_logic;
    bad_trig              : in  std_logic;
    trig_start            : in  std_logic;
    le_int                : in  std_logic;    -- link end interrupt
    ls_int                : in  std_logic     -- link start interrupt   
);
end px_axis_ddr2wave_1_csr;

architecture Behavioral of px_axis_ddr2wave_1_csr is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------
-- Generic Control/Status Register Set
component px_axil_csr_d2wf_1
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
    intrpt_src_in : in std_logic_vector(8 downto 0);
    irq : out std_logic
  );
end component;

---------------------------------------------------------------------------------
-- Constants
---------------------------------------------------------------------------------

constant MODE_CNTL_REG_INIT_VAL     : std_logic_vector(31 downto 0) := x"00000000";
constant CLEAR_REG_INIT_VAL         : std_logic_vector(31 downto 0) := x"00000000";
constant LL_START_ADDRESS_INIT_VAL  : std_logic_vector(31 downto 0) := x"00000000";

---------------------------------------------------------------------------------
-- Signals
---------------------------------------------------------------------------------
 
signal cntl_reg0            : std_logic_vector(31 downto 0) := MODE_CNTL_REG_INIT_VAL;
signal cntl_reg1            : std_logic_vector(31 downto 0) := CLEAR_REG_INIT_VAL;
signal cntl_reg2            : std_logic_vector(31 downto 0) := x"00000000"; 
signal cntl_reg3            : std_logic_vector(31 downto 0) := LL_START_ADDRESS_INIT_VAL; 
signal cntl_reg4            : std_logic_vector(31 downto 0) := x"00000000";   
signal cntl_reg5            : std_logic_vector(31 downto 0) := x"00000000"; 
signal cntl_reg6            : std_logic_vector(31 downto 0) := x"00000000";   
signal stat_reg0            : std_logic_vector(31 downto 0) := (others => '0');
signal stat_reg1            : std_logic_vector(31 downto 0) := (others => '0');
signal int_src_stat         : std_logic_vector(8 downto 0)  := (others => '0');
signal t1_cntl_reg0_0       : std_logic:= '0';
signal awaddr               : std_logic_vector(6 downto 0)  := (others => '0');
signal araddr               : std_logic_vector(6 downto 0)  := (others => '0');
signal cntl_reg0x           : std_logic_vector(8 downto 0)  := ('0' & x"00"); 
signal cntl_reg2x           : std_logic_vector(31 downto 0) := x"00000000"; 
signal cntl_reg3x           : std_logic_vector(31 downto 0) := x"00000000";  
signal cntl_reg5x           : std_logic_vector(15 downto 0) := x"0000"; 
signal cntl_reg6x           : std_logic_vector(31 downto 0) := x"00000000";    
signal src_sends            : std_logic := '0';   
signal src_rcvs             : std_logic := '0'; 
signal dest_reqs            : std_logic := '0'; 
signal src_send0            : std_logic := '0';   
signal src_rcv0             : std_logic := '0'; 
signal dest_req0            : std_logic := '0'; 
signal src_send3            : std_logic := '0';   
signal src_rcv3             : std_logic := '0'; 
signal dest_req3            : std_logic := '0'; 
signal src_send5            : std_logic := '0';   
signal src_rcv5             : std_logic := '0'; 
signal dest_req5            : std_logic := '0';
signal src_send6            : std_logic := '0';   
signal src_rcv6             : std_logic := '0'; 
signal dest_req6            : std_logic := '0';  
signal lgatex               : std_logic := '0';
signal trig_armx            : std_logic := '0';
signal trigarm              : std_logic := '0';
signal trig_clearx          : std_logic := '0';
signal disarmx              : std_logic := '0';
signal real_time_lostx      : std_logic := '0';
signal armed_rex            : std_logic := '0';
signal waiting_arm_rex      : std_logic := '0';
signal acq_endx             : std_logic := '0';
signal acq_startx           : std_logic := '0';
signal stat_vctr            : std_logic_vector(18 downto 0)  := (others => '0');
signal stat_vctrx           : std_logic_vector(18 downto 0)  := (others => '0');
signal csr_areset           : std_logic := '0';
signal axis_areset          : std_logic := '0';
signal ll_startx            : std_logic := '0';
signal bad_trigx            : std_logic := '0';
signal trig_startx          : std_logic := '0';
signal le_intx              : std_logic := '0';
signal ls_intx              : std_logic := '0';
signal fflshx               : std_logic := '0';
---------------------------------------------------------------------------------

begin

awaddr <= '0' & s_axi_csr_awaddr;
araddr <= '0' & s_axi_csr_araddr;
csr_areset <= not s_axi_csr_aresetn;

csr_inst: px_axil_csr_d2wf_1
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
    reg2_init_val       => x"00000000",
    reg3_init_val       => LL_START_ADDRESS_INIT_VAL,   
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
    ctl7_out            => open,
    stat0_in            => stat_reg0,
    stat1_in            => stat_reg1,
    stat2_in            => x"00000000",
    stat3_in            => x"00000000",
    stat4_in            => x"00000000",
    intrpt_src_in       => int_src_stat,
    irq                 => irq
  );

--------------------------------------------------------------------------------
-- Cross Clock Domain Crossing of Control Signals
--------------------------------------------------------------------------------

cntl0_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 3, -- integer; range: 2-10
  WIDTH          => 9  -- integer; range: 1-1024
)
port map (

  src_clk  => s_axi_csr_aclk,
  src_in   => cntl_reg0(8 downto 0),
  src_send => src_send0,
  src_rcv  => src_rcv0,
  dest_clk => axis_aclk,
  dest_req => dest_req0,
  dest_ack => dest_req0, 
  dest_out => cntl_reg0x
);
   
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     if (src_rcv0 = '1') then
       src_send0 <= '0';
     elsif (src_rcv0 = '0') and (src_send0 = '0') then
       src_send0 <= '1';
     end if;  
   end if;
end process;   

cntl2_xclk: xpm_cdc_pulse
generic map (

  -- Common module generics
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
  RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
  SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
)
port map (
  src_clk    => s_axi_csr_aclk, 
  src_rst    => csr_areset,   -- optional; required when RST_USED = 1
  src_pulse  => cntl_reg2(0),
  dest_clk   => axis_aclk,
  dest_rst   => '0',  -- optional; required when RST_USED = 1
  dest_pulse => ll_startx
); 

cntl3_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 3, -- integer; range: 2-10
  WIDTH          => 32  -- integer; range: 1-1024
)
port map (

  src_clk  => s_axi_csr_aclk,
  src_in   => cntl_reg3,
  src_send => src_send3,
  src_rcv  => src_rcv3,
  dest_clk => axis_aclk,
  dest_req => dest_req3,
  dest_ack => dest_req3, 
  dest_out => cntl_reg3x
);
   
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     if (src_rcv3 = '1') then
       src_send3 <= '0';
     elsif (src_rcv3 = '0') and (src_send3 = '0') then
       src_send3 <= '1';
     end if;  
   end if;
end process;   

cntl4_xclk: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 3, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => cntl_reg4(0),
     dest_clk => axis_aclk,
     dest_out => fflshx
  );

cntl5_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 3, -- integer; range: 2-10
  WIDTH          => 16  -- integer; range: 1-1024
)
port map (

  src_clk  => s_axi_csr_aclk,
  src_in   => cntl_reg5(15 downto 0),
  src_send => src_send5,
  src_rcv  => src_rcv5,
  dest_clk => axis_aclk,
  dest_req => dest_req5,
  dest_ack => dest_req5, 
  dest_out => cntl_reg5x
);
   
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     if (src_rcv5 = '1') then
       src_send5 <= '0';
     elsif (src_rcv5 = '0') and (src_send5 = '0') then
       src_send5 <= '1';
     end if;  
   end if;
end process; 

cntl6_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 3, -- integer; range: 2-10
  WIDTH          => 8  -- integer; range: 1-1024
)
port map (

  src_clk  => s_axi_csr_aclk,
  src_in   => cntl_reg6(7 downto 0),
  src_send => src_send6,
  src_rcv  => src_rcv6,
  dest_clk => axis_aclk,
  dest_req => dest_req6,
  dest_ack => dest_req6, 
  dest_out => cntl_reg6x(7 downto 0)
);
   
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     if (src_rcv6 = '1') then
       src_send6 <= '0';
     elsif (src_rcv6 = '0') and (src_send6 = '0') then
       src_send6 <= '1';
     end if;  
   end if;
end process; 

lgate_cdc_inst: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 3, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => cntl_reg0(7),
     dest_clk => axis_aclk,
     dest_out => lgatex
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
  src_rst    => csr_areset,   -- optional; required when RST_USED = 1
  src_pulse  => trig_armx,
  dest_clk   => axis_aclk,
  dest_rst   => '0',  -- optional; required when RST_USED = 1
  dest_pulse => trigarm
);

clr_cdc_inst: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 3, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => cntl_reg1(0),
     dest_clk => axis_aclk,
     dest_out => trig_clearx
  );

dsrm_cdc_inst: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 3, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => cntl_reg1(1),
     dest_clk => axis_aclk,
     dest_out => disarmx
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
            --  "11" = Reserved 
--Bit [5:4] - data_mode_sel[1:0]
            -- "00" = Single Sample Real Data
            -- "01" = Packed I/Q Data or two channel Real
            -- "10" = Reserved
            -- "11" = Reserved
-- Bit [6]  -- local gate reg mode
-- Bit [7]  -- Local gate register bit  
-- Trigger Clear Register
-- Bit [0] - Trigger Clear
-- Bit [1] - Disarm after trigger ends
-- FIFO Flush Register
-- Bit [0] - FIFO Flush

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
      trig_armx           <= cntl_reg0(0) and not t1_cntl_reg0_0;  
      t1_cntl_reg0_0      <= cntl_reg0(0);
    end if;
end process;
    
process(axis_aclk)
begin
    if rising_edge(axis_aclk) then
       trig_arm            <= trigarm;  
       stay_armed          <= cntl_reg0x(1);
       mode_sel            <= cntl_reg0x(3 downto 2);
       data_mode_sel       <= cntl_reg0x(5 downto 4);
       local_gate_mode     <= cntl_reg0x(6);
       local_gate          <= lgatex; 
       ll_start            <= ll_startx;
       trig_clear          <= trig_clearx;
       fifo_flush          <= fflshx; 
       ll_start_address    <= cntl_reg3x(5 downto 0);
       disarm              <= disarmx;
       rate_div            <= cntl_reg5x(15 downto 0); 
       output_gate_delay   <= cntl_reg6x(7 downto 0); 
       rt_clr              <= cntl_reg0x(8);
    end if;
end process;

--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------
stat_vctr <= next_link & current_link & data_mode & mode & active & armed & waiting_arm;

stat_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 3, -- integer; range: 2-10
  WIDTH          => 19 -- integer; range: 1-1024
)
port map (

  src_clk  => axis_aclk,
  src_in   => stat_vctr,
  src_send => src_sends,
  src_rcv  => src_rcvs,
  dest_clk => s_axi_csr_aclk,
  dest_req => dest_reqs,
  dest_ack => dest_reqs, 
  dest_out => stat_vctrx
);
   
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

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     stat_reg0(6 downto 0) <= stat_vctrx(6 downto 0);
   end if;
end process; 

stat_reg0(31 downto 7) <= (others => '0'); 

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     stat_reg1(5 downto 0)   <= stat_vctrx(12 downto 7);  -- current link
     stat_reg1(21 downto 16) <= stat_vctrx(18 downto 13); -- next link
   end if;
end process; 

stat_reg0(31 downto 7) <= (others => '0');     

stat_reg1(15 downto 6) <= (others => '0'); 
stat_reg1(31 downto 22) <= (others => '0');
 
--------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------

-- Interrupts
-- Bit [0] Start of Acquisition
-- Bit [1] End of Acquisition
-- Bit [2] Waiting for Arm Rising Edge
-- Bit [3] Armed Rising Edge
-- Bit [4] Trig Start
-- BIt [5] Link Start Interrupt
-- BIt [6] Link End Interrupt
-- Bit [7] Bad Trigger - trigger occured before last acq. ended
-- Bit [8] Real Time Lost
int_src_stat <= real_time_lostx & bad_trigx & le_intx & ls_intx & trig_startx & armed_rex & waiting_arm_rex & acq_endx & acq_startx;

syncrst_inst: xpm_cdc_sync_rst
  generic map (

     -- Common module parameters
     DEST_SYNC_FF    => 3, -- integer; range: 2-10
     INIT            => 1, -- integer; 0=initialize synchronization registers to 0,
                           --          1=initialize synchronization registers to 1
     SIM_ASSERT_CHK  => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
     src_rst  => csr_areset,
     dest_clk => axis_aclk,
     dest_rst => axis_areset
  );

ias_cdc_inst: xpm_cdc_pulse
generic map (

  -- Common module generics
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
  RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
  SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
)
port map (
  src_clk    => axis_aclk, 
  src_rst    => axis_areset,   -- optional; required when RST_USED = 1
  src_pulse  => acq_start,
  dest_clk   => s_axi_csr_aclk,
  dest_rst   => '0',  -- optional; required when RST_USED = 1
  dest_pulse => acq_startx
);

iae_cdc_inst: xpm_cdc_pulse
generic map (

  -- Common module generics
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
  RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
  SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
)
port map (
  src_clk    => axis_aclk, 
  src_rst    => axis_areset,   -- optional; required when RST_USED = 1
  src_pulse  => acq_end,
  dest_clk   => s_axi_csr_aclk,
  dest_rst   => '0',  -- optional; required when RST_USED = 1
  dest_pulse => acq_endx
);

iwa_cdc_inst: xpm_cdc_pulse
generic map (

  -- Common module generics
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
  RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
  SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
)
port map (
  src_clk    => axis_aclk, 
  src_rst    => axis_areset,   -- optional; required when RST_USED = 1
  src_pulse  => waiting_arm_re,
  dest_clk   => s_axi_csr_aclk,
  dest_rst   => '0',  -- optional; required when RST_USED = 1
  dest_pulse => waiting_arm_rex
);
 
ia_cdc_inst: xpm_cdc_pulse
generic map (

  -- Common module generics
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
  RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
  SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
)
port map (
  src_clk    => axis_aclk, 
  src_rst    => axis_areset,   -- optional; required when RST_USED = 1
  src_pulse  => armed_re,
  dest_clk   => s_axi_csr_aclk,
  dest_rst   => '0',  -- optional; required when RST_USED = 1
  dest_pulse => armed_rex
); 

irt_cdc_inst: xpm_cdc_pulse
generic map (

  -- Common module generics
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
  RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
  SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
)
port map (
  src_clk    => axis_aclk, 
  src_rst    => axis_areset,   -- optional; required when RST_USED = 1
  src_pulse  => real_time_lost,
  dest_clk   => s_axi_csr_aclk,
  dest_rst   => '0',  -- optional; required when RST_USED = 1
  dest_pulse => real_time_lostx
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
  src_rst    => axis_areset,   -- optional; required when RST_USED = 1
  src_pulse  => bad_trig,
  dest_clk   => s_axi_csr_aclk,
  dest_rst   => '0',  -- optional; required when RST_USED = 1
  dest_pulse => bad_trigx
); 

ts_cdc_inst: xpm_cdc_pulse
generic map (

  -- Common module generics
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
  RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
  SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
)
port map (
  src_clk    => axis_aclk, 
  src_rst    => axis_areset,   -- optional; required when RST_USED = 1
  src_pulse  => trig_start,
  dest_clk   => s_axi_csr_aclk,
  dest_rst   => '0',  -- optional; required when RST_USED = 1
  dest_pulse => trig_startx
); 

le_cdc_inst: xpm_cdc_pulse
generic map (

  -- Common module generics
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
  RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
  SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
)
port map (
  src_clk    => axis_aclk, 
  src_rst    => axis_areset,   -- optional; required when RST_USED = 1
  src_pulse  => le_int,
  dest_clk   => s_axi_csr_aclk,
  dest_rst   => '0',  -- optional; required when RST_USED = 1
  dest_pulse => le_intx
); 

ls_cdc_inst: xpm_cdc_pulse
generic map (

  -- Common module generics
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
  RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
  SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
)
port map (
  src_clk    => axis_aclk, 
  src_rst    => axis_areset,   -- optional; required when RST_USED = 1
  src_pulse  => ls_int,
  dest_clk   => s_axi_csr_aclk,
  dest_rst   => '0',  -- optional; required when RST_USED = 1
  dest_pulse => ls_intx
); 
                       
end Behavioral;