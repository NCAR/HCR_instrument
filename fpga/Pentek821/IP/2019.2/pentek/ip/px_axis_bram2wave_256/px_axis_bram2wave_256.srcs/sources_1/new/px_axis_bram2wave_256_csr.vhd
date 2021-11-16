----------------------------------------------------------------------------------
-- Control/Status Registers for Pentek Axi-Stream Data Stream Controller
----------------------------------------------------------------------------------
-- px_axis_bram2wave_256_csr.vhd
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
-- Revision 1.0  - File Created
-- Revision 2.0  - Added Linked List support

-- Additional Comments: 
--  

----------------------------------------------------------------------------------
-- Register Map
-- 0x00 Mode Control                    R/W   
-- 0x04 Trigger Clear                   R/W  
-- 0x08 BRAM Start Address              R/W
-- 0x0C BRAM End Address                R/W
-- 0x10 Status                          RO 
-- 0x14 Interrupt Enables               R/W  
-- 0x18 Status                          RO
-- 0x1C  
-- 0x20  
-- 0x24 Interrupt Enables               R/W   
-- 0x28 Interrupt Status Register       RO                     
-- 0x2C Interrupt Flag Register         R/Clr            

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
-- BRAM Start Address    Register
-- Bit [n:0]  -- BRAM Start Address
-- Trigger Clear Register
-- Bit [0] - Trigger Clear
-- Bit [1] - Disarm after trigger ends


-- Interrupts
-- Bit [0] Start of Acquisition
-- Bit [1] End of Acquisition
-- Bit [2] Waiting for Arm Rising Edge
-- Bit [3] Armed Rising Edge
-- Bit [4] Trig Start
-- Bit [5] 
-- Bit [6] 
-- Bit [7] Bad Trigger - trigger occured before acq. ended
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

entity px_axis_bram2wave_256_csr is
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
    local_gate_mode       : out std_logic; 
    local_gate            : out std_logic;
    bram_strt_address     : out std_logic_vector(31 downto 0);    
    bram_end_address      : out std_logic_vector(31 downto 0); 
    trig_delay            : out std_logic_vector(31 downto 0);
    trig_len              : out std_logic_vector(31 downto 0); 
    --------------------------------------------------------------------------------
    -- Status Inputs
    --------------------------------------------------------------------------------     
    waiting_arm           : in  std_logic;     
    armed                 : in  std_logic;
    active                : in  std_logic;
    mode                  : in  std_logic_vector(1 downto 0);
    data_mode             : in  std_logic_vector(1 downto 0);
     --------------------------------------------------------------------------------
    -- Interrupt Sources
    --------------------------------------------------------------------------------    
    acq_start             : in  std_logic;  
    acq_end               : in  std_logic;  
    waiting_arm_re        : in  std_logic;  
    armed_re              : in  std_logic;
    bad_trig              : in  std_logic;
    trig_start            : in  std_logic
);
end px_axis_bram2wave_256_csr;

architecture Behavioral of px_axis_bram2wave_256_csr is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------
-- Generic Control/Status Register Set
component px_axi_b2wf_csr
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
    ctl0_out : out std_logic_vector(31 downto 0);
    ctl1_out : out std_logic_vector(31 downto 0);
    ctl2_out : out std_logic_vector(31 downto 0);
    ctl3_out : out std_logic_vector(31 downto 0);
    ctl4_out : out std_logic_vector(31 downto 0);
    ctl5_out : out std_logic_vector(31 downto 0);
    stat0_in : in std_logic_vector(31 downto 0);
    stat1_in : in std_logic_vector(31 downto 0);
    stat2_in : in std_logic_vector(31 downto 0);
    intrpt_src_in : in std_logic_vector(8 downto 0);
    irq : out std_logic
  );
end component;

---------------------------------------------------------------------------------
-- Constants
---------------------------------------------------------------------------------

constant MODE_CNTL_REG_INIT_VAL     : std_logic_vector(31 downto 0) := x"002F0000";
constant CLEAR_REG_INIT_VAL         : std_logic_vector(31 downto 0) := x"00000000";


---------------------------------------------------------------------------------
-- Signals
---------------------------------------------------------------------------------
 
signal cntl_reg0            : std_logic_vector(31 downto 0) := MODE_CNTL_REG_INIT_VAL;
signal cntl_reg1            : std_logic_vector(31 downto 0) := CLEAR_REG_INIT_VAL;
signal cntl_reg2            : std_logic_vector(31 downto 0) := x"00000000"; 
signal cntl_reg3            : std_logic_vector(31 downto 0) := x"00000000"; 
signal cntl_reg4            : std_logic_vector(31 downto 0) := x"00000000";   
signal cntl_reg5            : std_logic_vector(31 downto 0) := x"00000000"; 
signal cntl_reg6            : std_logic_vector(31 downto 0) := x"00000000";   
signal stat_reg0            : std_logic_vector(31 downto 0) := (others => '0');
signal stat_reg1            : std_logic_vector(31 downto 0) := (others => '0');
signal int_src_stat         : std_logic_vector(8 downto 0)  := (others => '0');
signal t1_cntl_reg0_0       : std_logic:= '0';
signal awaddr               : std_logic_vector(6 downto 0)  := (others => '0');
signal araddr               : std_logic_vector(6 downto 0)  := (others => '0');
signal cntl_reg0x           : std_logic_vector(21 downto 0) := (others => '0');
signal cntl_reg2x           : std_logic_vector(31 downto 0) := x"00000000"; 
signal cntl_reg3x           : std_logic_vector(31 downto 0) := x"00000000";  
signal cntl_reg4x           : std_logic_vector(31 downto 0) := x"00000000";  
signal cntl_reg5x           : std_logic_vector(31 downto 0) := x"00000000";  
signal src_sends            : std_logic := '0';   
signal src_rcvs             : std_logic := '0'; 
signal dest_reqs            : std_logic := '0'; 
signal src_send0            : std_logic := '0';   
signal src_rcv0             : std_logic := '0'; 
signal dest_req0            : std_logic := '0'; 
signal src_send3            : std_logic := '0';   
signal src_rcv3             : std_logic := '0'; 
signal dest_req3            : std_logic := '0'; 
signal src_send2            : std_logic := '0';   
signal src_rcv2             : std_logic := '0'; 
signal dest_req2            : std_logic := '0';
signal src_send4            : std_logic := '0';   
signal src_rcv4             : std_logic := '0'; 
signal dest_req4            : std_logic := '0';
signal src_send5            : std_logic := '0';   
signal src_rcv5             : std_logic := '0'; 
signal dest_req5            : std_logic := '0';
signal lgatex               : std_logic := '0';
signal trig_armx            : std_logic := '0';
signal trigarm              : std_logic := '0';
signal trig_clearx          : std_logic := '0';
signal disarmx              : std_logic := '0';
signal armed_rex            : std_logic := '0';
signal waiting_arm_rex      : std_logic := '0';
signal acq_endx             : std_logic := '0';
signal acq_startx           : std_logic := '0';
signal stat_vctr            : std_logic_vector(6 downto 0)  := (others => '0');
signal stat_vctrx           : std_logic_vector(6 downto 0)  := (others => '0');
signal csr_areset           : std_logic := '0';
signal axis_areset          : std_logic := '0';
signal bad_trigx            : std_logic := '0';
signal trig_startx          : std_logic := '0';

---------------------------------------------------------------------------------

begin

awaddr <= '0' & s_axi_csr_awaddr;
araddr <= '0' & s_axi_csr_araddr;
csr_areset <= not s_axi_csr_aresetn;

csr_inst: px_axi_b2wf_csr
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
    reg3_init_val       => x"00000000",   
    reg4_init_val       => x"00000000",
    reg5_init_val       => x"00000100",
    ctl0_out            => cntl_reg0,
    ctl1_out            => cntl_reg1,
    ctl2_out            => cntl_reg2,
    ctl3_out            => cntl_reg3,
    ctl4_out            => cntl_reg4,
    ctl5_out            => cntl_reg5,
    stat0_in            => stat_reg0,
    stat1_in            => x"00000100",
    stat2_in            => x"00000100",
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
  WIDTH          => 22  -- integer; range: 1-1024
)
port map (
  src_clk  => s_axi_csr_aclk,
  src_in   => cntl_reg0(21 downto 0),
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


cntl2_xclk:  xpm_cdc_handshake
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
  src_in   => cntl_reg2,
  src_send => src_send2,
  src_rcv  => src_rcv2,
  dest_clk => axis_aclk,
  dest_req => dest_req2,
  dest_ack => dest_req2, 
  dest_out => cntl_reg2x
);
   
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     if (src_rcv2 = '1') then
       src_send2 <= '0';
     elsif (src_rcv2 = '0') and (src_send2 = '0') then
       src_send2 <= '1';
     end if;  
   end if;
end process;   

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

cntl4_xclk:  xpm_cdc_handshake
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
  src_in   => cntl_reg4,
  src_send => src_send4,
  src_rcv  => src_rcv4,
  dest_clk => axis_aclk,
  dest_req => dest_req4,
  dest_ack => dest_req4, 
  dest_out => cntl_reg4x
);
   
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     if (src_rcv4 = '1') then
       src_send4 <= '0';
     elsif (src_rcv4 = '0') and (src_send4 = '0') then
       src_send4 <= '1';
     end if;  
   end if;
end process;    

cntl5_xclk:  xpm_cdc_handshake
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
  src_in   => cntl_reg5,
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
       trig_clear          <= trig_clearx;
       bram_strt_address   <= cntl_reg2x(31 downto 0);
       bram_end_address    <= cntl_reg3x(31 downto 0);
       trig_delay          <= cntl_reg4x(31 downto 0);
       trig_len            <= cntl_reg5x(31 downto 0);
       disarm              <= disarmx;      
    end if;
end process;

--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------
stat_vctr <= data_mode & mode & active & armed & waiting_arm;

stat_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 3, -- integer; range: 2-10
  WIDTH          => 7 -- integer; range: 1-1024
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
 
--------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------

-- Interrupts
-- Bit [0] Start of Acquisition
-- Bit [1] End of Acquisition
-- Bit [2] Waiting for Arm Rising Edge
-- Bit [3] Armed Rising Edge
-- Bit [4] Trig Start
-- BIt [5] 
-- BIt [6] 
-- Bit [7] Bad Trigger - trigger occured before last acq. ended
-- Bit [8] 
int_src_stat <= '0' & bad_trigx & '0' & '0' & trig_startx & armed_rex & waiting_arm_rex & acq_endx & acq_startx;

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

                       
end Behavioral;