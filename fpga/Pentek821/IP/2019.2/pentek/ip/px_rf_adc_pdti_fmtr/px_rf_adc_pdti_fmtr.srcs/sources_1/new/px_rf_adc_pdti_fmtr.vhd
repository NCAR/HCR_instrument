----------------------------------------------------------------------------------
-- Company: Pentek
-- Engineer: 
-- 
-- Create Date: 12/27/2017 08:27:03 AM
-- Design Name: 
-- Module Name: px_rf_adc_pdti_fmtr - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: RF Data Converter to Pentek PDTI AXIS Formatter
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
-- Register map
-- 0x0000 - Control Register
-- bit 1:0 - decimation select 00 = DEC1 (not supported) 01 = DEC2 10 = DEC4 11 = DEC8
-- bit 2   - ddc_mode 1 = I/Q 0 = real (only has effect in DEC1 mode)
-- bit 3 - reset select  0 = sync_rst 1 = SYNC
-- bit 4 - arm reset (armed on rising edge) (cleared automatically when SYNC or sync_rst is received)

-- s_axis_pdti_aclk must be 2x the m_axis_pdti_aclk

-- In Real mode, it expects 8 samples per cycle at 500MHz s_axis_pdti_aclk max.

-- In Dec2 I/Q mode, it expects 4 samples per cycle at 500MHz s_axis_pdti_aclk max.

-- In Dec4 I/Q mode, it expects 2 samples per cycle at 500MHz s_axis_pdti_aclk max.

-- In Dec8 I/Q mode, it expects 1 samples per cycle at 500MHz s_axis_pdti_aclk max.
 
 -- **** NOTE! DEC = DDC 1x is not supported

----------------------------------------------------------------------------------
-------------------------------------------------------------------------------

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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_rf_adc_pdti_fmtr is
generic (
   channel: integer := 0; -- 0 to 255
   has_in_tready : boolean := true
);
port (
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
--------------------------------------------------------------------------------
-- Input AXI-Stream   (s_axis_aclk)
--------------------------------------------------------------------------------
   s_axis_aclk              : in  std_logic;
   s_axis_aresetn           : in std_logic; -- reset   
   --I or Real
   s_axis_i_tdata           : in  std_logic_vector(127 downto 0);
   s_axis_i_tvalid          : in  std_logic;
   s_axis_i_tready          : out std_logic; -- always high
   --Q 
   s_axis_q_tdata           : in  std_logic_vector(127 downto 0);
   s_axis_q_tvalid          : in  std_logic;
   s_axis_q_tready          : out std_logic; -- always high
   
   -----------------------------------------------------------------------------
   -- Time Stamp Output (AXI4-Stream Master) no back pressure
   -----------------------------------------------------------------------------
   -- tuser[7:0]       = Gate Positions  
   -- tuser[15:8]      = Sync Positions      
   -- tuser[23:16]     = PPS Positions
   -- pts_tdata[63:0]  = timestamp[63:0] 
   -- (s_axis_aclk)
   s_axis_pts_tdata         : in std_logic_vector(63 downto 0);
   s_axis_pts_tuser         : in std_logic_vector(23 downto 0);
   s_axis_pts_tvalid        : in std_logic;
--------------------------------------------------------------------------------
-- Output AXI-Stream (Pentek PDTI Format)   (m_axis_aclk)
--------------------------------------------------------------------------------
   -- tuser[63:0]    = timestamp[63:0]
   -- tuser[71:64]   = Gate Positions  
   -- tuser[79:72]   = Sync Positions      
   -- tuser[87:80]   = PPS  Positions  
   -- tuser[91:88]   = Samples/Cycle
   -- tuser[92]      = IQ of first sample in data 0 = I, 1 = Q
   -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
   -- tuser[95]      = Data Type 0 = Real 1 = I/Q
   -- tuser[103:96]  = channel[7:0] 
   -- tuser[127:104] = Reserved 
   m_axis_pdti_aclk         : in  std_logic;
   m_axis_aresetn           : in std_logic; -- reset  
   m_axis_pdti_tdata        : out std_logic_vector(255 downto 0);
   m_axis_pdti_tuser        : out std_logic_vector(127 downto 0);
   m_axis_pdti_tvalid       : out std_logic;
   
   sync_rst                 : in std_logic; -- synchronous to s_axis_aclk
   
   sync_rst_gen_out_n       : out std_logic
);
end px_rf_adc_pdti_fmtr;

architecture Behavioral of px_rf_adc_pdti_fmtr is

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of s_axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_i:s_axis_q:s_axis_pts, ASSOCIATED_RESET s_axis_aresetn:sync_rst_gen_out_n";

ATTRIBUTE X_INTERFACE_INFO of m_axis_pdti_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 m_axis_pdti_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of m_axis_pdti_aclk: SIGNAL is "ASSOCIATED_BUSIF m_axis_pdti, ASSOCIATED_RESET m_axis_aresetn";

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

COMPONENT px_rf_adc_fmtr_csr
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
    ctl0_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

-- 2x Width Converter
COMPONENT px_rf_adc_fmtr_w_conv
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    s_axis_tuser : IN STD_LOGIC_VECTOR(95 DOWNTO 0);
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
    m_axis_tuser : OUT STD_LOGIC_VECTOR(191 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC
  );
END COMPONENT;

COMPONENT px_rf_adc_fmtr_clk_conv
  PORT (
    s_axis_aresetn : IN STD_LOGIC;
    m_axis_aresetn : IN STD_LOGIC;
    s_axis_aclk : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
    s_axis_tuser : IN STD_LOGIC_VECTOR(175 DOWNTO 0);
    m_axis_aclk : IN STD_LOGIC;
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
    m_axis_tuser : OUT STD_LOGIC_VECTOR(175 DOWNTO 0)
  );
END COMPONENT;

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

type sm_state_type is 
(
    RESET_STATE,
    PHASE1_STATE,
    PHASE2_STATE,
    PHASE3_STATE,
    PHASE4_STATE
);
--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal t1_s_axi_csr_aresetn  : std_logic := '0';
signal t1_s_axi_csr_areset  : std_logic := '0';
signal t1_s_axis_aresetn  : std_logic := '0';
signal t1_s_axis_areset  : std_logic := '0';
signal t2_s_axis_aresetn  : std_logic := '0';
signal ctl0_out : std_logic_vector(31 downto 0) := x"00000000";
signal ctl0_out_x : std_logic_vector(3 downto 0) := "0000";
signal ctl0_out_y : std_logic_vector(3 downto 0) := "0000";
signal arm_pls: std_logic := '0';
signal armed: std_logic := '0';
signal t1_s_axis_pts_tuser: std_logic_vector(23 downto 0) := x"000000";
signal t1_s_axis_pts_tvalid: std_logic := '0';
signal t1_sync_rst: std_logic := '0';
signal state: sm_state_type := RESET_STATE;
signal mux_valid: std_logic := '0';
signal mux_data : std_logic_vector(255 downto 0) := (others => '0');
signal t1_s_axis_iq_tdata : std_logic_vector(255 downto 0) :=  (others => '0');
signal t1_s_axis_pts_tdata: std_logic_vector(63 downto 0) :=  (others => '0');
signal t1_upsz_in_tuser: std_logic_vector(95 downto 0) :=  (others => '0');
signal upsz_out_tdata: std_logic_vector(511 downto 0) := (others => '0');
signal upsz_out_tuser: std_logic_vector(191 downto 0) := (others => '0');
signal upsz_out_tvalid: std_logic := '0';
signal upsz_tuser: std_logic_vector(175 downto 0) := (others => '0');
signal cc_axis_tvalid: std_logic := '0';
signal cc_axis_tdata: std_logic_vector(511 downto 0) := (others => '0');
signal cc_axis_tuser: std_logic_vector(175 downto 0) := (others => '0');
signal mux_tuser: std_logic_vector(103 downto 0) := (others => '0');
signal ddc_mode_y: std_logic := '0';
signal t1_m_axis_aresetn: std_logic := '0';
signal dec_y : std_logic_vector(1 downto 0) := "00";
--------------------------------------------------------------------------------

begin

s_axis_i_tready <= '1';
s_axis_q_tready <= '1';

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
   end if;
end process;  

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
      t1_s_axis_aresetn   <= s_axis_aresetn;
      t1_s_axis_iq_tdata  <= s_axis_q_tdata & s_axis_i_tdata;
      t1_s_axis_pts_tdata <= s_axis_pts_tdata;
      t1_s_axis_pts_tuser <= s_axis_pts_tuser;  
   end if;
end process; 

process(m_axis_pdti_aclk)
begin
   if rising_edge(m_axis_pdti_aclk) then
      t1_m_axis_aresetn   <= m_axis_aresetn;  
   end if;
end process; 

--------------------------------------------------------------------------------
-- 2x Width Converter for Real Mode
--------------------------------------------------------------------------------

t1_upsz_in_tuser <=  "00000000" & t1_s_axis_pts_tuser & t1_s_axis_pts_tdata;


upsz2x_inst : px_rf_adc_fmtr_w_conv
  PORT MAP (
    aclk           => s_axis_aclk,
    aresetn        => t2_s_axis_aresetn,
    s_axis_tdata   => t1_s_axis_iq_tdata,
    s_axis_tuser   => t1_upsz_in_tuser,
    s_axis_tvalid  => t1_s_axis_pts_tvalid,
    s_axis_tready  => open,
    m_axis_tdata   => upsz_out_tdata,
    m_axis_tuser   => upsz_out_tuser,
    m_axis_tvalid  => upsz_out_tvalid,
    m_axis_tready  => '1' 
  );

-- m_axis_tdata
-- Real Mode:  X7 X6 X5 X4 X3 X2 X1 X0 I7 I6 I5 I4 I3 I2 I1 I0 X7 X6 X5 X4 X3 X2 X1 X0 I7 I6 I5 I4 I3 I2 I1 I0
-- Dec 2 Mode: X3 X2 X1 X0 Q3 Q2 Q1 Q0 X3 X2 X1 X0 I3 I2 I1 I0 X3 X2 X1 X0 Q3 Q2 Q1 Q0 X3 X2 X1 X0 I3 I2 I1 I0
-- Dec 4 Mode: X5 X4 X3 X2 X1 X0 Q1 Q0 X5 X4 X3 X2 X1 X0 I1 I0 X5 X4 X3 X2 X1 X0 Q1 Q0 X5 X4 X3 X2 X1 X0 I1 I0
-- Dec 8 Mode: X X5 X4 X3 X2 X1 X0 Q0 X6 X5 X4 X3 X2 X1 X0 I0 X6 X5 X4 X3 X2 X1 X0 Q0 X6 X5 X4 X3 X2 X1 X0 I0

upsz_tuser  <= upsz_out_tuser(183 downto 96) & upsz_out_tuser(87 downto 0);

--------------------------------------------------------------------------------
-- Clock Converter
--------------------------------------------------------------------------------

clk_conv_inst : px_rf_adc_fmtr_clk_conv
  PORT MAP (
    s_axis_aresetn  => t2_s_axis_aresetn,
    m_axis_aresetn  => '1',
    s_axis_aclk     => s_axis_aclk,
    s_axis_tvalid   => upsz_out_tvalid,
    s_axis_tready   => open,
    s_axis_tdata    => upsz_out_tdata,
    s_axis_tuser    => upsz_tuser,
    m_axis_aclk     => m_axis_pdti_aclk,
    m_axis_tvalid   => cc_axis_tvalid,
    m_axis_tready   => '1',
    m_axis_tdata    => cc_axis_tdata,
    m_axis_tuser    => cc_axis_tuser
  );

--------------------------------------------------------------------------------
-- Control Registers
--------------------------------------------------------------------------------

csr_inst : px_rf_adc_fmtr_csr
  PORT MAP (
    s_axi_csr_aclk => s_axi_csr_aclk,
    s_axi_csr_aresetn => t1_s_axi_csr_aresetn,
    s_axi_csr_awaddr => s_axi_csr_awaddr(6 downto 0),
    s_axi_csr_awprot => s_axi_csr_awprot,
    s_axi_csr_awvalid => s_axi_csr_awvalid,
    s_axi_csr_awready => s_axi_csr_awready,
    s_axi_csr_wdata => s_axi_csr_wdata,
    s_axi_csr_wstrb => s_axi_csr_wstrb,
    s_axi_csr_wvalid => s_axi_csr_wvalid,
    s_axi_csr_wready => s_axi_csr_wready,
    s_axi_csr_bresp => s_axi_csr_bresp,
    s_axi_csr_bvalid => s_axi_csr_bvalid,
    s_axi_csr_bready => s_axi_csr_bready,
    s_axi_csr_araddr => s_axi_csr_araddr(6 downto 0),
    s_axi_csr_arprot => s_axi_csr_arprot,
    s_axi_csr_arvalid => s_axi_csr_arvalid,
    s_axi_csr_arready => s_axi_csr_arready,
    s_axi_csr_rdata => s_axi_csr_rdata,
    s_axi_csr_rresp => s_axi_csr_rresp,
    s_axi_csr_rvalid => s_axi_csr_rvalid,
    s_axi_csr_rready => s_axi_csr_rready,
    reg0_init_val => x"00000000",
    ctl0_out => ctl0_out
  );
  
cdc1_inst: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 2, -- integer; range: 2-10
    INIT_SYNC_FF   => 0, -- integer; 0=disable simulation init values, 1=enable simulation init values
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 4  -- integer; range: 1-1024
  )
  port map 
  (
    src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => ctl0_out(3 downto 0),
    dest_clk => s_axis_aclk,
    dest_out => ctl0_out_x
  );
  
 cdc2_inst: xpm_cdc_array_single
    generic map (
  
      -- Common module generics
      DEST_SYNC_FF   => 2, -- integer; range: 2-10
      INIT_SYNC_FF   => 0, -- integer; 0=disable simulation init values, 1=enable simulation init values
      SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
      SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
      WIDTH          => 4  -- integer; range: 1-1024
    )
    port map 
    (
      src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
      src_in   => ctl0_out(3 downto 0),
      dest_clk => m_axis_pdti_aclk,
      dest_out => ctl0_out_y
    ); 
  
cdc_pulse_inst: xpm_cdc_pulse
    generic map (
      -- Common module generics
      DEST_SYNC_FF   => 2, -- integer; range: 2-10
      INIT_SYNC_FF   => 0, -- integer; 0=disable simulation init values, 1=enable simulation init values
      REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
      RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
      SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
    )
    port map (
  
      src_clk    => s_axi_csr_aclk,
      src_rst    => t1_s_axi_csr_areset,   -- optional; required when RST_USED = 1
      src_pulse  => ctl0_out(4),
      dest_clk   => s_axis_aclk,
      dest_rst   => t1_s_axis_areset,  -- optional; required when RST_USED = 1
      dest_pulse => arm_pls
    );  

t1_s_axi_csr_areset <= not t1_s_axi_csr_aresetn;
t1_s_axis_areset    <= not t1_s_axis_aresetn; 


process(m_axis_pdti_aclk)
begin
   if rising_edge(m_axis_pdti_aclk) then
      ddc_mode_y<= ctl0_out_y(2);
      if ctl0_out_y(2) = '1' then
         dec_y   <= ctl0_out_y(1 downto 0);
      else
         dec_y   <= "00";
      end if;    
   end if;
end process;
   
--------------------------------------------------------------------------------
-- Reset Gen
--------------------------------------------------------------------------------  

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
      t1_s_axis_pts_tvalid<= s_axis_pts_tvalid;
      t1_sync_rst <= sync_rst;
      if ctl0_out_x(3) = '0' then  -- reset source select
         if arm_pls = '1' then
            armed <= '1';
         elsif (t1_s_axis_aresetn = '0') or (t1_sync_rst = '1') then
            armed <= '0';
         end if;
         t2_s_axis_aresetn <= not ((armed and t1_sync_rst) or (not t1_s_axis_aresetn));
      else
         if arm_pls = '1' then
            armed <= '1';
         elsif (t1_s_axis_aresetn = '0') or ((t1_s_axis_pts_tvalid = '1') and (t1_s_axis_pts_tuser(8) = '1')) then
            armed <= '0';
         end if;
         t2_s_axis_aresetn <= not((t1_s_axis_pts_tvalid and t1_s_axis_pts_tuser(8) and armed) or (not t1_s_axis_aresetn));
      end if;
      sync_rst_gen_out_n <= t2_s_axis_aresetn;   
   end if;
end process;   

--------------------------------------------------------------------------------
-- Packing State Machine
--------------------------------------------------------------------------------

process(m_axis_pdti_aclk)
begin
    if rising_edge(m_axis_pdti_aclk) then
        if (t1_m_axis_aresetn = '0') or (cc_axis_tvalid = '0') then
            state     <= RESET_STATE;
            mux_valid <= '0';        
        else
            case state is
                when RESET_STATE =>
                    if cc_axis_tvalid = '1' then
                       state     <= PHASE1_STATE;
                    end if;
                    mux_valid <= '0';
                when PHASE1_STATE =>
                    mux_tuser(63 downto 0) <= cc_axis_tuser(63 downto 0); 
                    mux_tuser(64)          <= cc_axis_tuser(64) or cc_axis_tuser(152); 
                    mux_tuser(72)          <= cc_axis_tuser(72) or cc_axis_tuser(160); 
                    mux_tuser(80)          <= cc_axis_tuser(80) or cc_axis_tuser(168); 
                    case dec_y is
                        when "00" => -- Dec = 1
                            mux_tuser(91 downto 88) <= "1111"; 
                            mux_tuser(92) <= '0';
                            mux_tuser(95 downto 93) <= "001"; 
                            mux_tuser(103 downto 96)<= conv_std_logic_vector(channel, 8);
                            mux_data <= cc_axis_tdata(383 downto 256) & cc_axis_tdata(127 downto 0);
                            state <= PHASE1_STATE;
                            mux_valid <= '1';
                        when "01" => -- Dec = 2  
                            mux_tuser(91 downto 88) <= "1000";
                            mux_tuser(92) <= '0';
                            mux_tuser(95 downto 93) <= "101";
                            mux_tuser(103 downto 96)<= conv_std_logic_vector(channel, 8); 
                            mux_data(15 downto 0)   <= cc_axis_tdata(15 downto 0);    --I0
                            mux_data(31 downto 16)  <= cc_axis_tdata(143 downto 128); --Q0
                            mux_data(47 downto 32)  <= cc_axis_tdata(31 downto 16);   --I1
                            mux_data(63 downto 48)  <= cc_axis_tdata(159 downto 144); --Q1
                            mux_data(79 downto 64)  <= cc_axis_tdata(47 downto 32);   --I2
                            mux_data(95 downto 80)  <= cc_axis_tdata(175 downto 160); --Q2
                            mux_data(111 downto 96) <= cc_axis_tdata(63 downto 48);   --I3
                            mux_data(127 downto 112)<= cc_axis_tdata(191 downto 176); --Q3  
                            
                            mux_data(143 downto 128)<= cc_axis_tdata(271 downto 256); --I4
                            mux_data(159 downto 144)<= cc_axis_tdata(399 downto 384); --Q4
                            mux_data(175 downto 160)<= cc_axis_tdata(287 downto 272); --I5
                            mux_data(191 downto 176)<= cc_axis_tdata(415 downto 400); --Q5
                            mux_data(207 downto 192)<= cc_axis_tdata(303 downto 288); --I6
                            mux_data(223 downto 208)<= cc_axis_tdata(431 downto 416); --Q6
                            mux_data(239 downto 224)<= cc_axis_tdata(319 downto 304); --I7
                            mux_data(255 downto 240)<= cc_axis_tdata(447 downto 432); --Q7  
                            state     <= PHASE1_STATE;                          
                            mux_valid <= '1'; 
                        when "10" => -- Dec = 4
                            mux_tuser(91 downto 88) <= "1000";
                            mux_tuser(92) <= '0';
                            mux_tuser(95 downto 93) <= "101";
                            mux_tuser(103 downto 96)<= conv_std_logic_vector(channel, 8); 
                            mux_data(15 downto 0)   <= cc_axis_tdata(15  downto 0);   --I0
                            mux_data(31 downto 16)  <= cc_axis_tdata(143 downto 128); --Q0
                            mux_data(47 downto 32)  <= cc_axis_tdata(31  downto 16);  --I1
                            mux_data(63 downto 48)  <= cc_axis_tdata(159 downto 144); --Q1
                            
                            mux_data(79 downto 64)  <= cc_axis_tdata(271 downto 256); --I2
                            mux_data(95 downto 80)  <= cc_axis_tdata(399 downto 384); --Q2
                            mux_data(111 downto 96) <= cc_axis_tdata(287 downto 272); --I3
                            mux_data(127 downto 112)<= cc_axis_tdata(415 downto 400); --Q3  
                            state     <= PHASE2_STATE;                          
                            mux_valid <= '0';                         
                        when "11" => -- Dec = 8
                            mux_tuser(91 downto 88) <= "1000";
                            mux_tuser(92) <= '0';
                            mux_tuser(95 downto 93) <= "101";
                            mux_tuser(103 downto 96)<= conv_std_logic_vector(channel, 8); 
                            mux_data(15 downto 0)   <= cc_axis_tdata(15 downto 0);    --I0
                            mux_data(31 downto 16)  <= cc_axis_tdata(143 downto 128); --Q0
                            
                            mux_data(47 downto 32)  <= cc_axis_tdata(271 downto 256); --I1
                            mux_data(63 downto 48)  <= cc_axis_tdata(399 downto 384); --Q1
                            state     <= PHASE2_STATE;                          
                            mux_valid <= '0';                          
                        when others =>
                            state     <= RESET_STATE;
                            mux_valid <= '0';
                    end case;    
                when PHASE2_STATE =>
                    mux_tuser(65)          <= cc_axis_tuser(64) or cc_axis_tuser(152);
                    mux_tuser(73)          <= cc_axis_tuser(72) or cc_axis_tuser(160);
                    mux_tuser(81)          <= cc_axis_tuser(80) or cc_axis_tuser(168);
                    case dec_y is
                        when "00" => -- Dec = 1
                            state     <= RESET_STATE;
                            mux_valid <= '0';
                        when "01" => -- Dec = 2  
                            state     <= RESET_STATE;
                            mux_valid <= '0';
                        when "10" => -- Dec = 4
                            mux_data(143 downto 128)<= cc_axis_tdata(15 downto 0);    --I4       
                            mux_data(159 downto 144)<= cc_axis_tdata(143 downto 128); --Q4    
                            mux_data(175 downto 160)<= cc_axis_tdata(31 downto 16);   --I5       
                            mux_data(191 downto 176)<= cc_axis_tdata(159 downto 144); --Q5 
                                
                            mux_data(207 downto 192)<= cc_axis_tdata(271 downto 256); --I6       
                            mux_data(223 downto 208)<= cc_axis_tdata(399 downto 384); --Q6     
                            mux_data(239 downto 224)<= cc_axis_tdata(287 downto 272); --I7       
                            mux_data(255 downto 240)<= cc_axis_tdata(415 downto 400); --Q7     
                            state     <= PHASE1_STATE;                          
                            mux_valid <= '1';                         
                        when "11" => -- Dec = 8
                            mux_data(79 downto 64)  <= cc_axis_tdata(15 downto 0);    --I2        
                            mux_data(95 downto 80)  <= cc_axis_tdata(143 downto 128); --Q2  
                               
                            mux_data(111 downto 96) <= cc_axis_tdata(271 downto 256); --I3        
                            mux_data(127 downto 112)<= cc_axis_tdata(399 downto 384); --Q3      
                            state     <= PHASE3_STATE;                          
                            mux_valid <= '0';                          
                        when others =>
                            state     <= RESET_STATE;
                            mux_valid <= '0';
                    end case;    
                when PHASE3_STATE =>
                    mux_tuser(66)          <= cc_axis_tuser(64) or cc_axis_tuser(152);
                    mux_tuser(74)          <= cc_axis_tuser(72) or cc_axis_tuser(160);
                    mux_tuser(82)          <= cc_axis_tuser(80) or cc_axis_tuser(168);
                    case dec_y is
                        when "00" => -- Dec = 1
                            state     <= RESET_STATE;
                            mux_valid <= '0';
                        when "01" => -- Dec = 2  
                            state     <= RESET_STATE;
                            mux_valid <= '0';
                        when "10" => -- Dec = 4
                            state     <= RESET_STATE;
                            mux_valid <= '0';                      
                        when "11" => -- Dec = 8
                            mux_data(143 downto 128)<= cc_axis_tdata(15 downto 0);    --I4        
                            mux_data(159 downto 144)<= cc_axis_tdata(143 downto 128); --Q4  
                               
                            mux_data(175 downto 160)<= cc_axis_tdata(271 downto 256); --I5        
                            mux_data(191 downto 176)<= cc_axis_tdata(399 downto 384); --Q5      
                            state     <= PHASE4_STATE;                          
                            mux_valid <= '0';                          
                        when others =>
                            state     <= RESET_STATE;
                            mux_valid <= '0';
                   end case;    
                when PHASE4_STATE =>
                    mux_tuser(67)          <= cc_axis_tuser(64) or cc_axis_tuser(152);
                    mux_tuser(75)          <= cc_axis_tuser(72) or cc_axis_tuser(160);
                    mux_tuser(83)          <= cc_axis_tuser(80) or cc_axis_tuser(168);
                    case dec_y is
                        when "00" => -- Dec = 1
                            state     <= RESET_STATE;
                            mux_valid <= '0';
                        when "01" => -- Dec = 2  
                            state     <= RESET_STATE;
                            mux_valid <= '0';
                        when "10" => -- Dec = 4
                            state     <= RESET_STATE;
                            mux_valid <= '0';                      
                        when "11" => -- Dec = 8
                            mux_data(207 downto 192)<= cc_axis_tdata(15 downto 0);    --I6           
                            mux_data(223 downto 208)<= cc_axis_tdata(143 downto 128); --Q6
                                    
                            mux_data(239 downto 224)<= cc_axis_tdata(271 downto 256); --I7           
                            mux_data(255 downto 240)<= cc_axis_tdata(399 downto 384); --Q7         
                            state     <= PHASE1_STATE;                          
                            mux_valid <= '1';                          
                        when others =>
                            state     <= RESET_STATE;
                            mux_valid <= '0';
                   end case;                  
                when others =>
                   state     <= RESET_STATE;
                   mux_valid <= '0';
            end case;    
        end if;
    end if;
end process;    

--------------------------------------------------------------------------------
-- Mode Selection
--------------------------------------------------------------------------------

process(m_axis_pdti_aclk)
begin
   if rising_edge(m_axis_pdti_aclk) then
      m_axis_pdti_tuser(103 downto 88)<= mux_tuser(103 downto 88); 
      m_axis_pdti_tuser(63 downto 0)  <= mux_tuser(63 downto 0); 
      if mux_tuser(67 downto 64) = "0000" then
         m_axis_pdti_tuser(71 downto 64)  <= "00000000"; 
      else
         m_axis_pdti_tuser(71 downto 64)  <= "11111111"; 
      end if;
      if mux_tuser(75 downto 72) = "0000" then
         m_axis_pdti_tuser(79 downto 72)  <= "00000000"; 
      else
         m_axis_pdti_tuser(79 downto 72)  <= "11111111"; 
      end if;
      if mux_tuser(83 downto 80) = "0000" then
         m_axis_pdti_tuser(87 downto 80)  <= "00000000"; 
      else
         m_axis_pdti_tuser(87 downto 80)  <= "11111111"; 
      end if;
      m_axis_pdti_tdata  <= mux_data;
      m_axis_pdti_tvalid <= mux_valid;
   end if;
end process;

m_axis_pdti_tuser(127 downto 104) <= (others => '0'); 

end Behavioral;
