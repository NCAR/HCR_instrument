----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 05/18/2015 12:31:55 PM
-- Design Name: 
-- Module Name: px_axis_thresh_det - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: AXI-S Unsigned Value Threshold Detector with Hysteresis
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- latency = 4 dvals
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

--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axis_thresh_det is
generic (
   data_width     : integer := 16;   -- Data Width
   default_thresh : integer := 8192; -- Default Threshold (0 to 4294967296)
   default_hyst   : integer := 128;  -- Hysteresis Amount Below Threshold (0 to 4294967296 but less than default_thresh)
   has_det_axis   : boolean := true; -- Has Detect AXI-S output
   has_irq_out    : boolean := true  -- Has Interrupt output   
);
port (
   ----------------------------------------------------------------------------
   -- AXI4-Lite Control/Status Interface
   ----------------------------------------------------------------------------
   s_axi_csr_aclk      : in  std_logic;
   s_axi_csr_aresetn   : in  std_logic;
   s_axi_csr_awaddr    : in  std_logic_vector(6 downto 0);
   s_axi_csr_awprot    : in  std_logic_vector(2 downto 0);
   s_axi_csr_awvalid   : in  std_logic;
   s_axi_csr_awready   : out std_logic;
   s_axi_csr_wdata     : in  std_logic_vector(31 downto 0);
   s_axi_csr_wstrb     : in  std_logic_vector(3 downto 0);
   s_axi_csr_wvalid    : in  std_logic;
   s_axi_csr_wready    : out std_logic;
   s_axi_csr_bresp     : out std_logic_vector(1 downto 0);
   s_axi_csr_bvalid    : out std_logic;
   s_axi_csr_bready    : in  std_logic;
   s_axi_csr_araddr    : in  std_logic_vector(6 downto 0);
   s_axi_csr_arprot    : in  std_logic_vector(2 downto 0);
   s_axi_csr_arvalid   : in  std_logic;
   s_axi_csr_arready   : out std_logic;
   s_axi_csr_rdata     : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp     : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid    : out std_logic;
   s_axi_csr_rready    : in  std_logic;
   
   irq                 : out std_logic;
   ----------------------------------------------------------------------------
   -- AXI-S Slave Input 
   ----------------------------------------------------------------------------
   axis_aclk          : in  std_logic;
   axis_aresetn       : in  std_logic;
   -- tdata = Unsigned Value 
   s_axis_tdata       : in  std_logic_vector(data_width-1 downto 0);
   s_axis_tvalid      : in  std_logic;
   ----------------------------------------------------------------------------
   -- AXI-S Master Output 
   ----------------------------------------------------------------------------
   -- tdata[0] = Detect   
   m_axis_detect_tdata   : out std_logic_vector(7 downto 0);
   m_axis_detect_tvalid  : out std_logic
);
end px_axis_thresh_det;

architecture Behavioral of px_axis_thresh_det is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis:m_axis_detect, ASSOCIATED_RESET axis_aresetn";

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Control/Status Registers
COMPONENT px_thresh_det_csr
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
    reg1_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    reg2_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl0_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl1_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl2_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat0_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    intrpt_src_in : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    irq : OUT STD_LOGIC
  );
END COMPONENT;

-- AXI Lite Clock Converter
COMPONENT px_thresh_det_axi_clk_conv
  PORT (
    s_axi_aclk : IN STD_LOGIC;
    s_axi_aresetn : IN STD_LOGIC;
    s_axi_awaddr : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    s_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_awvalid : IN STD_LOGIC;
    s_axi_awready : OUT STD_LOGIC;
    s_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_wvalid : IN STD_LOGIC;
    s_axi_wready : OUT STD_LOGIC;
    s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_bvalid : OUT STD_LOGIC;
    s_axi_bready : IN STD_LOGIC;
    s_axi_araddr : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    s_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_arvalid : IN STD_LOGIC;
    s_axi_arready : OUT STD_LOGIC;
    s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_rvalid : OUT STD_LOGIC;
    s_axi_rready : IN STD_LOGIC;
    m_axi_aclk : IN STD_LOGIC;
    m_axi_aresetn : IN STD_LOGIC;
    m_axi_awaddr : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
    m_axi_awprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    m_axi_awvalid : OUT STD_LOGIC;
    m_axi_awready : IN STD_LOGIC;
    m_axi_wdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axi_wstrb : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    m_axi_wvalid : OUT STD_LOGIC;
    m_axi_wready : IN STD_LOGIC;
    m_axi_bresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_bvalid : IN STD_LOGIC;
    m_axi_bready : OUT STD_LOGIC;
    m_axi_araddr : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
    m_axi_arprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    m_axi_arvalid : OUT STD_LOGIC;
    m_axi_arready : IN STD_LOGIC;
    m_axi_rdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axi_rresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_rvalid : IN STD_LOGIC;
    m_axi_rready : OUT STD_LOGIC
  );
END COMPONENT;

-- Clock Domain Crossing for level tranistios
COMPONENT px_thresh_det_lvl_trns_xclk
  PORT (
    in_clk : IN STD_LOGIC;
    in_sig : IN STD_LOGIC;
    out_sig : OUT STD_LOGIC;
    out_clk : IN STD_LOGIC
  );
END COMPONENT;


--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

type state_type is 
(
RESET_STATE,
GT_THRESH_STATE
);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal ctl0_out         : std_logic_vector(31 downto 0) := (others => '0');
signal ctl1_out         : std_logic_vector(31 downto 0) := (others => '0');
signal ctl2_out         : std_logic_vector(31 downto 0) := (others => '0');
signal ctl0_outx        : std_logic_vector(31 downto 0) := (others => '0');
signal ctl1_outx        : std_logic_vector(31 downto 0) := (others => '0');
signal ctl2_outx        : std_logic_vector(31 downto 0) := (others => '0');
signal stat0_in         : std_logic_vector(31 downto 0) := (others => '0');
signal intrpt_src_in    : std_logic_vector(1 downto 0) := (others => '0');
signal irqx             : std_logic := '0';
signal thresh_val       : std_logic_vector(data_width-1 downto 0) := (others => '0');
signal hyst             : std_logic_vector(data_width-1 downto 0) := (others => '0');
signal t1_thresh_val    : std_logic_vector(data_width-1 downto 0) := (others => '0');
signal hyst_val         : std_logic_vector(data_width-1 downto 0) := (others => '0');
signal t1_axis_aresetn  : std_logic := '0';
signal t1_s_axis_tdata  : std_logic_vector(data_width-1 downto 0) := (others => '0');
signal t1_s_axis_tvalid : std_logic := '0';
signal t2_s_axis_tvalid : std_logic := '0';
signal det              : std_logic := '0';
signal det_re           : std_logic := '0';
signal det_fe           : std_logic := '0';
signal t1_det           : std_logic := '0';
signal calc_rst_n       : std_logic := '0';
signal state            : state_type := RESET_STATE;
signal src_send02       : std_logic:= '0';
signal src_rcv02        : std_logic:= '0';
signal dest_req02       : std_logic:= '0';
signal cntrl02_vctr     : std_logic_vector(95 downto 0)  := (others => '0');
signal cntrlx02_vctr    : std_logic_vector(95 downto 0)  := (others => '0');
signal src_sends        : std_logic:= '0';
signal src_rcvs         : std_logic:= '0';
signal dest_reqs        : std_logic:= '0';
signal src_senda        : std_logic:= '0';
signal src_rcva         : std_logic:= '0';
signal dest_reqa        : std_logic:= '0';
signal t1_s_axi_csr_aresetn: std_logic:= '0';
--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

constant thresh_init : std_logic_vector(31 downto 0) := conv_std_logic_vector(default_thresh, 32);
constant hyst_init   : std_logic_vector(31 downto 0) := conv_std_logic_vector(default_hyst, 32);

--------------------------------------------------------------------------------

begin

--------------------------------------------------------------------------------
-- Threshold Detection with Hysteresis
--------------------------------------------------------------------------------
-- Detect goes true when data input is greater than threshold.
-- It stays true unless the input falls below (threshold - hyst).
process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      if (calc_rst_n = '0') then
         state <= RESET_STATE;
         det   <= '0';
      else
         if (t1_s_axis_tvalid = '1') then 
            case state is
               when RESET_STATE =>
                  if (t1_axis_aresetn = '0') then
                     state <= RESET_STATE;
                     det   <= '0';
                  elsif (('0' & t1_s_axis_tdata) > ('0' & t1_thresh_val)) then
                     state <= GT_THRESH_STATE;
                     det   <= '1';   
                  end if;   
               when GT_THRESH_STATE =>
                  if (('0' & t1_s_axis_tdata) < ('0' & hyst_val)) then
                     state <= RESET_STATE;
                     det   <= '0';
                  else
                     state <= GT_THRESH_STATE;    
                  end if;
               when others =>
                  state <= RESET_STATE;
            end case;      
         end if;   
      end if;
   end if;
end process;

-- Output
process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      t1_axis_aresetn  <= axis_aresetn;
      t1_s_axis_tvalid <= s_axis_tvalid;
      t1_s_axis_tdata  <= s_axis_tdata; 
      t2_s_axis_tvalid <= t1_s_axis_tvalid;
      if (calc_rst_n = '0') then
          m_axis_detect_tdata(0) <= det;
          m_axis_detect_tvalid   <= '0'; 
      else
          m_axis_detect_tdata(0) <= det;
          m_axis_detect_tvalid   <= t2_s_axis_tvalid;
      end if;
   end if;
end process; 

m_axis_detect_tdata(7 downto 1) <= "0000000";

process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      t1_thresh_val <= thresh_val;
      hyst_val      <= thresh_val - hyst;
   end if;
end process;     

process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      if (calc_rst_n = '0') then
          det_re <= '0';
          det_fe <= '0';
          t1_det <= '0';
      else
          det_re <= det and not t1_det;
          det_fe <= t1_det and not det;
          t1_det <= det;
      end if;
   end if;
end process; 

--------------------------------------------------------------------------------
-- Control/Status Registers
--------------------------------------------------------------------------------

-- 0x00 - Control Register
-- 0x04 - Threshold
-- 0x08 - Hysteresis
-- 0x0C - Detect
-- 0x10 - Interrupt Enables
-- 0x14 - Interrupt Status
-- 0x18 - Interrupt Flags

-- Control Register 0 Bit Definitions
-- bit [0]   - Reset

-- Detect = 0x0c bit 0 

-- Interrupt Bit positions: 
-- [0] = Detected Rising Edge
-- [1] = Detected Falling Edge 

-- So that status, control and interrupt signals are synchronous with the data
-- stream clock, the entire control register block runs on the data stream clock.
csr : px_thresh_det_csr
  PORT MAP (
    s_axi_csr_aclk      => s_axi_csr_aclk,
    s_axi_csr_aresetn   => t1_s_axi_csr_aresetn,
    s_axi_csr_awaddr    => s_axi_csr_awaddr,
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
    s_axi_csr_araddr    => s_axi_csr_araddr,
    s_axi_csr_arprot    => s_axi_csr_arprot,
    s_axi_csr_arvalid   => s_axi_csr_arvalid,
    s_axi_csr_arready   => s_axi_csr_arready,
    s_axi_csr_rdata     => s_axi_csr_rdata,
    s_axi_csr_rresp     => s_axi_csr_rresp,
    s_axi_csr_rvalid    => s_axi_csr_rvalid,
    s_axi_csr_rready    => s_axi_csr_rready,
    reg0_init_val       => x"00000000",
    reg1_init_val       => thresh_init,
    reg2_init_val       => hyst_init,
    ctl0_out            => ctl0_out,
    ctl1_out            => ctl1_out,
    ctl2_out            => ctl2_out,
    stat0_in            => stat0_in,
    intrpt_src_in       => intrpt_src_in,
    irq                 => irqx
  );
  

cntrl02_vctr <= ctl2_out & ctl1_out & ctl0_out;

cntl02_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 4, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 4, -- integer; range: 2-10
  WIDTH          => 96  -- integer; range: 1-1024
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

ctl0_outx <= cntrlx02_vctr(31 downto 0);
ctl1_outx <= cntrlx02_vctr(63 downto 32);
ctl2_outx <= cntrlx02_vctr(95 downto 64);
   
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
     if (src_rcv02 = '1') then
       src_send02 <= '0';
     elsif (src_rcv02 = '0') and (src_send02 = '0') then
       src_send02 <= '1';
     end if;  
   end if;
end process;   

thresh_val <= ctl1_outx(data_width-1 downto 0); 
hyst       <= ctl2_outx(data_width-1 downto 0); 
 

stat0_in(31 DOWNTO 1) <= (OTHERS => '0'); 

det_xclk:  xpm_cdc_handshake
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
  src_in(0)  => det,
  src_send   => src_senda,
  src_rcv    => src_rcva,
  dest_clk   => s_axi_csr_aclk,
  dest_req   => dest_reqa,
  dest_ack   => dest_reqa, 
  dest_out(0)=> stat0_in(0)
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
  
process(axis_aclk)
begin
    if rising_edge(axis_aclk) then
        if (t1_axis_aresetn = '0') then
           calc_rst_n <= '0';
        else
           calc_rst_n <= not ctl0_outx(0);
        end if;    
    end if;
end process;  

re_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 0, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_aclk,
    src_rst    => '0',  -- optional; required when RST_USED = 1
    src_pulse  => det_re,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => intrpt_src_in(0)
);

fe_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 0, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => axis_aclk,
    src_rst    => '0',  -- optional; required when RST_USED = 1
    src_pulse  => det_fe,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => intrpt_src_in(1)
);

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     irq <= irqx;
   end if;
end process;   

end Behavioral;
