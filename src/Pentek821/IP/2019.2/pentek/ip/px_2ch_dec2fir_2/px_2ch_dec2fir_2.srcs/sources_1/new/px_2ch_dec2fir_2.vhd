----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 05/10/2016 10:09:23 AM
-- Design Name: 
-- Module Name: px_2ch_dec2fir_2 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Dual Channel AXI-Stream Fixed Decimation of 2 FIR Filter (2 Samples/Cycle Input)
-- 1 Sample/Cycle Output
-- Dependencies: 
-- 
-- Revision:
-- Revision 1.0 - File Created
-- Revision 1.2 - Fixed SYNC_EN bit
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
-- Register Space
-- 0x000 = Reserved
-- 0x004 = Gain Register (Gain Ch A = GAIN_REG[15:0] unsigned) (Gain Ch b = GAIN_REG[31:16] unsigned)
-- 0x008 = Control Register 
--    [0] = Sync_en
-- 0x00C = Coefficient Load Register
--    [0] = COEF LOAD  -- Toggle to load coefficients into the Filter
--    [1] = Loader State Machine Reset
-- 0x010 = Status Register
--    [0] = COEF LOAD IN PROGRESS   '1' = Coeffients are being loaded
--    [1] = COEF LOAD DONE          '1' = Coefficients are loaded  
-- Coefficient RAM Space
-- 0x1000 - 0x1FFF

--------------------------------------------------------------------------------

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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_2ch_dec2fir_2 is
generic (
   out_res  : integer  := 16 -- 16 or 24
);
port (
    ----------------------------------------------------------------------------
    -- AXI4-Lite Control/Status Interface
    ----------------------------------------------------------------------------
    s_axi_csr_aclk      : in  std_logic;
    s_axi_csr_aresetn   : in  std_logic;
    s_axi_csr_awaddr    : in  std_logic_vector(12 downto 0);
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
    s_axi_csr_araddr    : in  std_logic_vector(12 downto 0);
    s_axi_csr_arprot    : in  std_logic_vector(2 downto 0);
    s_axi_csr_arvalid   : in  std_logic;
    s_axi_csr_arready   : out std_logic;
    s_axi_csr_rdata     : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp     : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid    : out std_logic;
    s_axi_csr_rready    : in  std_logic;
    
    irq                 : out std_logic;
    -----------------------------------------------------------------------------
    -- Input Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
    -----------------------------------------------------------------------------
    -- Requires 16-bit data streams
    -- Single Sample per cycle
    aclk                : in  std_logic;
    aresetn             : in  std_logic;
    -- tuser[63:0]    = timestamp[63:0]
    -- tuser[71:64]   = Gate Positions  (in this case only 64 is required)
    -- tuser[79:72]   = Sync Positions  (in this case only 72 is required)    
    -- tuser[87:80]   = PPS  Positions  (in this case only 80 is required)
    -- tuser[91:88]   = Samples/Cycle
    -- tuser[92]      = IQ of first sample in data 0 = I, 1 = Q
    -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
    -- tuser[95]      = Data Type 0 = Real 1 = I/Q
    -- tuser[103:96]  = channel[7:0] 
    -- tuser[127:104] = Reserved 
    
    -- Q(t1), I(t1), Q(t0), I(t0)
    s_axis_pdti_tdata  : in  std_logic_vector(63 downto 0); 
    s_axis_pdti_tuser  : in  std_logic_vector(127 downto 0); -- IQ, 16-bit, 1 sample/cycle  
    s_axis_pdti_tvalid : in  std_logic;
    -----------------------------------------------------------------------------
    -- Output Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
    -----------------------------------------------------------------------------
    -- tuser[63:0]    = timestamp[63:0]
    -- tuser[71:64]   = Gate Positions  (in this case only 64 is required)
    -- tuser[79:72]   = Sync Positions  (in this case only 72 is required)    
    -- tuser[87:80]   = PPS  Positions  (in this case only 80 is required)
    -- tuser[91:88]   = Samples/Cycle
    -- tuser[92]      = IQ of first sample in data 0 = I, 1 = Q  
    -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
    -- tuser[95]      = Data Type 0 = Real 1 = I/Q
    -- tuser[103:96]  = channel[7:0] 
    -- tuser[127:105] = Reserved  (104 = saturate marker) 
    
    -- CH0(0) Q, CH0(0) I
    m_axis_pdti_tdata  : out std_logic_vector((2*out_res)-1 downto 0);  
    m_axis_pdti_tuser  : out std_logic_vector(127 downto 0); 
    m_axis_pdti_tvalid : out std_logic;
           
    sat                : out std_logic  
 );
end px_2ch_dec2fir_2;

architecture Behavioral of px_2ch_dec2fir_2 is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------
-- 2 Channel Dec=2 FIR (58 tap)
-- two samples/cycle input 
-- 1 sampl/cycle output
-- 27-bit output
-- latency = 65
COMPONENT px_2ch_dec2fir_2_fir
  PORT (
    aresetn : IN STD_LOGIC;
    aclk : IN STD_LOGIC;
    s_axis_data_tvalid : IN STD_LOGIC;
    s_axis_data_tready : OUT STD_LOGIC;
    s_axis_data_tdata : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tuser : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
    s_axis_config_tvalid : IN STD_LOGIC;
    s_axis_config_tready : OUT STD_LOGIC;
    s_axis_config_tdata : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    s_axis_reload_tvalid : IN STD_LOGIC;
    s_axis_reload_tready : OUT STD_LOGIC;
    s_axis_reload_tlast : IN STD_LOGIC;
    s_axis_reload_tdata : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    event_s_reload_tlast_missing : OUT STD_LOGIC;
    event_s_reload_tlast_unexpected : OUT STD_LOGIC
  );
END COMPONENT;

-- Multiplier
-- DSP48
-- latency = 4
COMPONENT px_2ch_dec2fir_2_mult
  PORT (
    CLK : IN STD_LOGIC;
    A : IN STD_LOGIC_VECTOR(26 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    P : OUT STD_LOGIC_VECTOR(42 DOWNTO 0)
  );
END COMPONENT;

-- Control/Status Registers
-- 4 Control
-- 1 Status
-- Interrupt Regs
COMPONENT px_2ch_dec2fir_2_csr
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
    reg3_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl0_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl1_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl2_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl3_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat0_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    intrpt_src_in : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    irq : OUT STD_LOGIC
  );
END COMPONENT;

-- Symmetrical Round 33 to 24 bits
COMPONENT px_2ch_dec2fir_2_rnd24
  PORT (
    axis_aclk : IN STD_LOGIC;
    axis_aresetn : IN STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(32 DOWNTO 0);
    s_axis_tuser : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    s_axis_tvalid : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
    m_axis_tuser : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC
  );
END COMPONENT;

-- Symmetrical Round 33 to 16 bits
COMPONENT px_2ch_dec2fir_2_rnd16
  PORT (
    axis_aclk : IN STD_LOGIC;
    axis_aresetn : IN STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(32 DOWNTO 0);
    s_axis_tuser : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    s_axis_tvalid : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_tuser : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC
  );
END COMPONENT;

-- Saturate 43 to 33 bits
COMPONENT px_2ch_dec2fir_2_sat
  PORT (
    axis_aclk : IN STD_LOGIC;
    axis_aresetn : IN STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(42 DOWNTO 0);
    s_axis_tuser : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    s_axis_tvalid : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(32 DOWNTO 0);
    m_axis_tuser : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC;
    sat_out : OUT STD_LOGIC
  );
END COMPONENT;

-- delay = 13
COMPONENT px_2ch_dec2fir_2_tuserdly
  PORT (
    D : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    CLK : IN STD_LOGIC;
    CE : IN STD_LOGIC;
    Q : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
  );
END COMPONENT;

-- delay = 66
COMPONENT px_2ch_dec2fir_2_tuserdly2
  PORT (
    D : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    CLK : IN STD_LOGIC;
    CE : IN STD_LOGIC;
    Q : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
  );
END COMPONENT;

-- AXI Crossbar
-- Port 0 0x0000
-- Port 1 0x1000
COMPONENT px_2chdec2fir_2_axi_xbar
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axi_awaddr : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
    s_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_awvalid : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_awready : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_wvalid : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_wready : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_bvalid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_bready : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_araddr : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
    s_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_arvalid : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_arready : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_rvalid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_rready : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axi_awaddr : OUT STD_LOGIC_VECTOR(25 DOWNTO 0);
    m_axi_awprot : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
    m_axi_awvalid : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_awready : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_wdata : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
    m_axi_wstrb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    m_axi_wvalid : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_wready : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_bresp : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    m_axi_bvalid : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_bready : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_araddr : OUT STD_LOGIC_VECTOR(25 DOWNTO 0);
    m_axi_arprot : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
    m_axi_arvalid : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_arready : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_rdata : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    m_axi_rresp : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    m_axi_rvalid : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_rready : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
  );
END COMPONENT;

-- AXI_Lite Block RAM Controller
COMPONENT px_2chdec2fir_2_brctlr
  PORT (
    s_axi_aclk : IN STD_LOGIC;
    s_axi_aresetn : IN STD_LOGIC;
    s_axi_awaddr : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
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
    s_axi_araddr : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    s_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_arvalid : IN STD_LOGIC;
    s_axi_arready : OUT STD_LOGIC;
    s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_rvalid : OUT STD_LOGIC;
    s_axi_rready : IN STD_LOGIC;
    bram_rst : OUT STD_LOGIC;
    bram_clk : OUT STD_LOGIC;
    bram_en : OUT STD_LOGIC;
    bram_we : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    bram_addr : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    bram_wrdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    bram_rddata : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

-- BRAM Dual Port
-- async clock
COMPONENT px_2chdec2fir_2_mem
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    clkb : IN STD_LOGIC;
    web : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    addrb : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    dinb : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

-- AXI-S FIFO
-- Packet FIFO
-- 512 deep
-- 32 wide
COMPONENT px_2chdec2fir_2_fifo
  PORT (
    m_aclk : IN STD_LOGIC;
    s_aclk : IN STD_LOGIC;
    s_aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_tlast : IN STD_LOGIC;
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_tlast : OUT STD_LOGIC
  );
END COMPONENT;

-- Barrel Shift based on sync positions
component px_2chdec2fir_2_bs
port (
  aclk               : in  std_logic;
  aresetn            : in  std_logic;
  sync_en            : in  std_logic;
  
  s_axis_pdti_tdata  : in  std_logic_vector(63 downto 0);  
  s_axis_pdti_tuser  : in  std_logic_vector(127 downto 0);
  s_axis_pdti_tvalid : in  std_logic;
  
  m_axis_pdti_tdata  : out std_logic_vector(63 downto 0);  
  m_axis_pdti_tuser  : out std_logic_vector(127 downto 0);
  m_axis_pdti_tvalid : out std_logic
);
end component;

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

type state_type is (
RESET_STATE,
START_LOAD_STATE,
LOADING_STATE,
FINISHED_STATE
);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal t1_bs_axis_pdti_tdata  : std_logic_vector(63 downto 0) := (others => '0');
signal t1_bs_axis_pdti_tuser  : std_logic_vector(127 downto 0) := (others => '0');
signal t1_bs_axis_pdti_tvalid : std_logic := '0';
signal bs_axis_pdti_tdata    : std_logic_vector(63 downto 0) := (others => '0');
signal bs_axis_pdti_tuser    : std_logic_vector(127 downto 0) := (others => '0');
signal bs_axis_pdti_tvalid   : std_logic := '0';
signal sync_re               : std_logic   := '0';
signal t1_aresetn            : std_logic   := '0';
signal i_gain_out            : std_logic_vector(42 downto 0) := (others => '0');
signal q_gain_out            : std_logic_vector(42 downto 0) := (others => '0');
signal gain                  : std_logic_vector(15 downto 0) := (others => '0');
signal i_sat_out             : std_logic_vector(32 downto 0) := (others => '0');
signal q_sat_out             : std_logic_vector(32 downto 0) := (others => '0');
signal i_rnd_out             : std_logic_vector(out_res-1 downto 0) := (others => '0');
signal q_rnd_out             : std_logic_vector(out_res-1 downto 0) := (others => '0');
signal sync_en               : std_logic   := '0';
signal sat_i                 : std_logic   := '0';
signal sat_q                 : std_logic   := '0';
signal ctl1_out              : std_logic_vector(31 downto 0) := (others => '0');
signal ctl2_out              : std_logic_vector(31 downto 0) := (others => '0');
signal ctl3_out              : std_logic_vector(31 downto 0) := (others => '0');
signal stat0_in              : std_logic_vector(31 downto 0) := (others => '0');
signal p1sat                 : std_logic   := '0';
signal p2sat                 : std_logic   := '0';
signal p3sat                 : std_logic   := '0'; 
signal sat_int               : std_logic := '0';
signal multdvaldly           : std_logic_vector(3 downto 0) := (others => '0');
signal sat_tvalid            : std_logic := '0';
signal rnd_tvalid            : std_logic := '0';
signal rnd_tuser             : std_logic_vector(127 downto 0) := (others => '0');
signal sat_tuser             : std_logic_vector(127 downto 0) := (others => '0');
signal satx_tuser            : std_logic_vector(127 downto 0) := (others => '0');
signal tuser_strch           : std_logic_vector(127 downto 0) := (others => '0');
signal fir_tvalid            : std_logic := '0';
signal fir_data_tvalid       : std_logic := '0';
signal fir_data_tuser        : std_logic_vector(0 downto 0) := (others => '0');
signal fir_data_tdata        : std_logic_vector(63 downto 0) := (others => '0');
signal t14_fir_data_tuser    : std_logic_vector(127 downto 0);
signal t15_fir_data_tuser    : std_logic_vector(127 downto 0); 
signal t16_fir_data_tuser    : std_logic_vector(127 downto 0); 
signal t17_fir_data_tuser    : std_logic_vector(127 downto 0);  
signal t18_fir_data_tuser    : std_logic_vector(127 downto 0); 
signal tuser_dly             : std_logic_vector(127 downto 0); 
signal tuser_dly1            : std_logic_vector(127 downto 0); 
signal t2_aresetn            : std_logic := '0';
signal t1_sync_re            : std_logic := '0';
signal fir_rst_n             : std_logic := '0';
signal xbar_axi_awaddr       : std_logic_vector(25 downto 0) := (others => '0');
signal xbar_axi_awprot       : std_logic_vector(5 downto 0) := (others => '0');
signal xbar_axi_awvalid      : std_logic_vector(1 downto 0) := (others => '0');
signal xbar_axi_awready      : std_logic_vector(1 downto 0) := (others => '0');
signal xbar_axi_wdata        : std_logic_vector(63 downto 0) := (others => '0');
signal xbar_axi_wstrb        : std_logic_vector(7 downto 0) := (others => '0');
signal xbar_axi_wvalid       : std_logic_vector(1 downto 0) := (others => '0');
signal xbar_axi_wready       : std_logic_vector(1 downto 0) := (others => '0');
signal xbar_axi_bresp        : std_logic_vector(3 downto 0) := (others => '0');
signal xbar_axi_bvalid       : std_logic_vector(1 downto 0) := (others => '0');
signal xbar_axi_bready       : std_logic_vector(1 downto 0) := (others => '0');
signal xbar_axi_araddr       : std_logic_vector(25 downto 0) := (others => '0');
signal xbar_axi_arprot       : std_logic_vector(5 downto 0) := (others => '0');
signal xbar_axi_arvalid      : std_logic_vector(1 downto 0) := (others => '0');
signal xbar_axi_arready      : std_logic_vector(1 downto 0) := (others => '0');
signal xbar_axi_rdata        : std_logic_vector(63 downto 0) := (others => '0');
signal xbar_axi_rresp        : std_logic_vector(3 downto 0) := (others => '0');
signal xbar_axi_rvalid       : std_logic_vector(1 downto 0) := (others => '0');
signal xbar_axi_rready       : std_logic_vector(1 downto 0) := (others => '0'); 
signal t1_ctl3_out           : std_logic := '0';
signal ld_coef               : std_logic := '0';
signal ld_active             : std_logic := '0';
signal ld_done               : std_logic := '0';
signal reload_tvalid         : std_logic := '0'; 
signal reload_tready         : std_logic := '0'; 
signal reload_tlast          : std_logic := '0'; 
signal reload_tdata          : std_logic_vector(31 downto 0) := (others => '0');   
signal event_s_reload_tlast_missing   : std_logic := '0'; 
signal event_s_reload_tlast_unexpected: std_logic := '0'; 
signal bram_we               : std_logic_vector(3 downto 0) := (others => '0');
signal bram_addr             : std_logic_vector(9 downto 0) := (others => '0');
signal bram_wrdata           : std_logic_vector(31 downto 0) := (others => '0');
signal bram_rddata           : std_logic_vector(31 downto 0) := (others => '0');
signal ld_addr               : std_logic_vector(8 downto 0)  := (others => '0');
signal x_reload_failed       : std_logic := '0';
signal reload_failed         : std_logic := '0';
signal bram_coef             : std_logic_vector(31 downto 0) := (others => '0');
signal coef_addr_cntr        : std_logic_vector(4 downto 0) := (others => '0');
signal ld_coef_addr_cntr     : std_logic := '0';
signal ldr_fifo_tvalid       : std_logic := '0';
signal ldr_fifo_tlast        : std_logic := '0';
signal t1_ldr_fifo_tvalid    : std_logic := '0';
signal t1_ldr_fifo_tlast     : std_logic := '0';
signal t2_ldr_fifo_tvalid    : std_logic := '0';
signal t2_ldr_fifo_tlast     : std_logic := '0';
signal state                 : state_type := RESET_STATE;
signal src_senda             : std_logic := '0';
signal src_rcva              : std_logic := '0';
signal dest_reqa             : std_logic := '0';
signal ld_rst                : std_logic := '0';
signal cfifo_rstn            : std_logic := '0';
signal t1_ld_done            : std_logic := '0';
signal t2_ld_done            : std_logic := '0';
signal t3_ld_done            : std_logic := '0';
signal t4_ld_done            : std_logic := '0';
signal t5_ld_done            : std_logic := '0';
signal t6_ld_done            : std_logic := '0';
signal t7_ld_done            : std_logic := '0';
signal load_finished         : std_logic := '0';
signal load_finishedx        : std_logic := '0';
signal src_sendc             : std_logic := '0';
signal src_rcvc              : std_logic := '0';
signal dest_reqc             : std_logic := '0';
signal ctl                   : std_logic_vector(17 downto 0) := (others => '0');
signal ctl_rs                : std_logic_vector(17 downto 0) := (others => '0');
signal t2_areset             : std_logic := '0';
signal t1_s_axi_csr_aresetn  : std_logic := '0';
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";
ATTRIBUTE X_INTERFACE_INFO of aclk: SIGNAL is "xilinx.com:signal:clock:1.0 aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_pdti:m_axis_pdti, ASSOCIATED_RESET aresetn";

begin

--------------------------------------------------------------------------------
-- Barrel Shift Based on SYNC Rising Edge Position
--------------------------------------------------------------------------------

bs_inst: px_2chdec2fir_2_bs
port map(
  aclk               => aclk,
  aresetn            => t1_aresetn,
  sync_en            => sync_en,
  
  s_axis_pdti_tdata  => s_axis_pdti_tdata,
  s_axis_pdti_tuser  => s_axis_pdti_tuser,
  s_axis_pdti_tvalid => s_axis_pdti_tvalid,
  
  m_axis_pdti_tdata  => bs_axis_pdti_tdata, 
  m_axis_pdti_tuser  => bs_axis_pdti_tuser,
  m_axis_pdti_tvalid => bs_axis_pdti_tvalid
);

process(aclk)
begin
   if rising_edge(aclk) then
      -- data order into filter must be Q1,I1,Q0,I0 
      --t1_bs_axis_pdti_tdata  <= bs_axis_pdti_tdata(63 downto 48) & bs_axis_pdti_tdata(31 downto 16) & bs_axis_pdti_tdata(47 downto 32) & bs_axis_pdti_tdata(15 downto 0); 
      t1_bs_axis_pdti_tdata  <= bs_axis_pdti_tdata;  
      t1_bs_axis_pdti_tuser  <= bs_axis_pdti_tuser;  
      t1_bs_axis_pdti_tvalid <= bs_axis_pdti_tvalid; 
      sync_re    <= bs_axis_pdti_tuser(72) and (not t1_bs_axis_pdti_tuser(72)); 
      t1_aresetn <= aresetn;
      t2_aresetn <= t1_aresetn;
      t1_sync_re <= sync_re;
      fir_rst_n  <= not (((sync_re or t1_sync_re) and sync_en) or (not t1_aresetn) or (not t2_aresetn) or ld_rst); 
   end if;
end process;



--------------------------------------------------------------------------------
-- Dec = 2 FIR
--------------------------------------------------------------------------------

fir_inst : px_2ch_dec2fir_2_fir
port map (
    aresetn                         => fir_rst_n, 
    aclk                            => aclk,
    s_axis_data_tvalid              => t1_bs_axis_pdti_tvalid,
    s_axis_data_tready              => open,
    s_axis_data_tdata               => t1_bs_axis_pdti_tdata,
    m_axis_data_tvalid              => fir_tvalid,
    m_axis_data_tuser               => fir_data_tuser,
    m_axis_data_tdata               => fir_data_tdata,
    s_axis_config_tvalid            => '1',
    s_axis_config_tready            => open,
    s_axis_config_tdata             => x"00",
    s_axis_reload_tvalid            => reload_tvalid,            
    s_axis_reload_tready            => reload_tready,            
    s_axis_reload_tlast             => reload_tlast,             
    s_axis_reload_tdata             => reload_tdata(23 downto 0),             
    event_s_reload_tlast_missing    => event_s_reload_tlast_missing,    
    event_s_reload_tlast_unexpected => event_s_reload_tlast_unexpected 
  ); 

fir_data_tvalid <= fir_tvalid; 

--------------------------------------------------------------------------------
-- Filter Output Gain
--------------------------------------------------------------------------------
-- latency = 4
gain_i_inst : px_2ch_dec2fir_2_mult
port map (
    CLK => aclk,
    A   => fir_data_tdata(26 downto 0),
    B   => gain,
    P   => i_gain_out
);

gain_q_inst : px_2ch_dec2fir_2_mult
port map (
    CLK => aclk,
    A   => fir_data_tdata(58 downto 32),
    B   => gain,
    P   => q_gain_out
);

-- Compensate for Multiplier latency = 4
process(aclk)
begin
   if rising_edge(aclk) then
      multdvaldly <= multdvaldly(2 downto 0) & fir_data_tvalid;
   end if;   
end process;   

tuser_strch(63 downto 0)     <= tuser_dly(63 downto 0);
tuser_strch(71 downto 66)    <= "000000";
tuser_strch(79 downto 74)    <= "000000";
tuser_strch(127 downto 82)   <= (others => '0');
tuser_strch(64)              <= tuser_dly(64) or tuser_dly(65); -- Gate
tuser_strch(72)              <= tuser_dly(72) or tuser_dly(73); -- Sync
tuser_strch(80)              <= tuser_dly(80) or tuser_dly(81); -- PPS

-- 13
-- delay = 28
tuserdly_inst : px_2ch_dec2fir_2_tuserdly
  PORT MAP (
    D   => t1_bs_axis_pdti_tuser,
    CLK => aclk,
    CE  => t1_bs_axis_pdti_tvalid,
    Q   => tuser_dly1
  );

-- 66
tuserdly2_inst : px_2ch_dec2fir_2_tuserdly2
    PORT MAP (
      D   => tuser_dly1,
      CLK => aclk,
      CE  => '1',
      Q   => tuser_dly
    );  

--------------------------------------------------------------------------------
-- Filter Output Saturation and Rounding
--------------------------------------------------------------------------------

i_sat_inst: px_2ch_dec2fir_2_sat
port map (
  axis_aclk      => aclk,
  axis_aresetn   => '1',
  s_axis_tdata   => i_gain_out,
  s_axis_tuser   => t18_fir_data_tuser(127 downto 0),
  s_axis_tvalid  => multdvaldly(3),
  m_axis_tdata   => i_sat_out,
  m_axis_tuser   => sat_tuser,
  m_axis_tvalid  => sat_tvalid,
  sat_out        => sat_i
);

q_sat_inst: px_2ch_dec2fir_2_sat
port map (
  axis_aclk      => aclk,
  axis_aresetn   => '1',
  s_axis_tdata   => q_gain_out,
  s_axis_tuser   => x"00000000000000000000000000000000",
  s_axis_tvalid  => multdvaldly(3), 
  m_axis_tdata   => q_sat_out,
  m_axis_tuser   => open,
  m_axis_tvalid  => open,
  sat_out        => sat_q
);          


satx_tuser <= sat_tuser(127 downto 105) & (sat_i or sat_q) & sat_tuser(103 downto 0);

gen16rnd: if (out_res = 16) generate
-- Round Data down to 16 bits for Cascade
round_gen_i16: px_2ch_dec2fir_2_rnd16
port map (
   axis_aclk     => aclk,
   axis_aresetn  => '1',
   s_axis_tdata  => i_sat_out,
   s_axis_tuser  => satx_tuser,
   s_axis_tvalid => sat_tvalid, 
   m_axis_tdata  => i_rnd_out,
   m_axis_tuser  => rnd_tuser,
   m_axis_tvalid => rnd_tvalid
);
round_gen_q16: px_2ch_dec2fir_2_rnd16
port map (
   axis_aclk     => aclk,
   axis_aresetn  => '1',
   s_axis_tdata  => q_sat_out,
   s_axis_tuser  => x"00000000000000000000000000000000",
   s_axis_tvalid => sat_tvalid, 
   m_axis_tdata  => q_rnd_out,
   m_axis_tuser   => open,
   m_axis_tvalid => open
);

end generate gen16rnd;

gen24rnd: if (out_res = 24) generate
-- Round Data down to 24 bits for Cascade
          
round_gen_i24: px_2ch_dec2fir_2_rnd24
port map (
   axis_aclk     => aclk,
   axis_aresetn  => '1',
   s_axis_tdata  => i_sat_out,
   s_axis_tuser  => sat_tuser,
   s_axis_tvalid => sat_tvalid, 
   m_axis_tdata  => i_rnd_out,
   m_axis_tuser  => rnd_tuser,
   m_axis_tvalid => rnd_tvalid
);

round_gen_q24: px_2ch_dec2fir_2_rnd24
port map (
    axis_aclk     => aclk,
    axis_aresetn  => '1',
    s_axis_tdata  => q_sat_out,
    s_axis_tuser  => x"00000000000000000000000000000000",
    s_axis_tvalid => sat_tvalid, 
    m_axis_tdata  => q_rnd_out,
    m_axis_tuser   => open,
    m_axis_tvalid => open
   );

end generate gen24rnd;

--------------------------------------------------------------------------------
-- AXI Crossbar
--------------------------------------------------------------------------------
  
axi_xbar_inst : px_2chdec2fir_2_axi_xbar
  port map (
      aclk             => s_axi_csr_aclk,
      aresetn          => t1_s_axi_csr_aresetn,
      s_axi_awaddr     => s_axi_csr_awaddr,
      s_axi_awprot     => s_axi_csr_awprot,
      s_axi_awvalid(0) => s_axi_csr_awvalid,
      s_axi_awready(0) => s_axi_csr_awready,
      s_axi_wdata      => s_axi_csr_wdata,
      s_axi_wstrb      => s_axi_csr_wstrb,
      s_axi_wvalid(0)  => s_axi_csr_wvalid,
      s_axi_wready(0)  => s_axi_csr_wready,
      s_axi_bresp      => s_axi_csr_bresp,
      s_axi_bvalid(0)  => s_axi_csr_bvalid,
      s_axi_bready(0)  => s_axi_csr_bready,
      s_axi_araddr     => s_axi_csr_araddr,
      s_axi_arprot     => s_axi_csr_arprot,
      s_axi_arvalid(0) => s_axi_csr_arvalid,
      s_axi_arready(0) => s_axi_csr_arready,
      s_axi_rdata      => s_axi_csr_rdata,
      s_axi_rresp      => s_axi_csr_rresp,
      s_axi_rvalid(0)  => s_axi_csr_rvalid,
      s_axi_rready(0)  => s_axi_csr_rready,
      m_axi_awaddr     => xbar_axi_awaddr,
      m_axi_awprot     => xbar_axi_awprot,
      m_axi_awvalid    => xbar_axi_awvalid,
      m_axi_awready    => xbar_axi_awready,
      m_axi_wdata      => xbar_axi_wdata,
      m_axi_wstrb      => xbar_axi_wstrb,
      m_axi_wvalid     => xbar_axi_wvalid,
      m_axi_wready     => xbar_axi_wready,
      m_axi_bresp      => xbar_axi_bresp,
      m_axi_bvalid     => xbar_axi_bvalid,
      m_axi_bready     => xbar_axi_bready,
      m_axi_araddr     => xbar_axi_araddr,
      m_axi_arprot     => xbar_axi_arprot,
      m_axi_arvalid    => xbar_axi_arvalid,
      m_axi_arready    => xbar_axi_arready,
      m_axi_rdata      => xbar_axi_rdata,
      m_axi_rresp      => xbar_axi_rresp,
      m_axi_rvalid     => xbar_axi_rvalid,
      m_axi_rready     => xbar_axi_rready
    );
  

--------------------------------------------------------------------------------
-- Coefficient RAM
--------------------------------------------------------------------------------

bram_ctlr_inst : px_2chdec2fir_2_brctlr
port map (
    s_axi_aclk    => s_axi_csr_aclk,
    s_axi_aresetn => t1_s_axi_csr_aresetn,
    s_axi_awaddr  => xbar_axi_awaddr(24 downto 13),
    s_axi_awprot  => xbar_axi_awprot(5 downto 3),
    s_axi_awvalid => xbar_axi_awvalid(1),
    s_axi_awready => xbar_axi_awready(1),
    s_axi_wdata   => xbar_axi_wdata(63 downto 32),
    s_axi_wstrb   => xbar_axi_wstrb(7 downto 4),
    s_axi_wvalid  => xbar_axi_wvalid(1),
    s_axi_wready  => xbar_axi_wready(1),
    s_axi_bresp   => xbar_axi_bresp(3 downto 2),
    s_axi_bvalid  => xbar_axi_bvalid(1),
    s_axi_bready  => xbar_axi_bready(1),
    s_axi_araddr  => xbar_axi_araddr(24 downto 13),
    s_axi_arprot  => xbar_axi_arprot(5 downto 3),
    s_axi_arvalid => xbar_axi_arvalid(1),
    s_axi_arready => xbar_axi_arready(1),
    s_axi_rdata   => xbar_axi_rdata(63 downto 32),
    s_axi_rresp   => xbar_axi_rresp(3 downto 2),
    s_axi_rvalid  => xbar_axi_rvalid(1),
    s_axi_rready  => xbar_axi_rready(1),
    bram_rst      => open,
    bram_clk      => open,
    bram_en       => open,
    bram_we       => bram_we,
    bram_addr     => bram_addr,
    bram_wrdata   => bram_wrdata,
    bram_rddata   => bram_rddata
  );


coef_bram_inst : px_2chdec2fir_2_mem
port map (
    clka    => s_axi_csr_aclk,
    wea     => bram_we,
    addra   => bram_addr(8 downto 0),
    dina    => bram_wrdata,
    douta   => bram_rddata,
    clkb    => s_axi_csr_aclk,
    web     => "0000",
    addrb   => ld_addr,
    dinb    => x"00000000",
    doutb   => bram_coef
  );

--------------------------------------------------------------------------------
-- Control/Status Registers
--------------------------------------------------------------------------------

csr_inst : px_2ch_dec2fir_2_csr
  PORT MAP (
    s_axi_csr_aclk      => s_axi_csr_aclk,
    s_axi_csr_aresetn   => t1_s_axi_csr_aresetn,
    s_axi_csr_awaddr    => xbar_axi_awaddr(6 downto 0),         
    s_axi_csr_awprot    => xbar_axi_awprot(2 downto 0),         
    s_axi_csr_awvalid   => xbar_axi_awvalid(0),                 
    s_axi_csr_awready   => xbar_axi_awready(0),                 
    s_axi_csr_wdata     => xbar_axi_wdata(31 downto 0),         
    s_axi_csr_wstrb     => xbar_axi_wstrb(3 downto 0),          
    s_axi_csr_wvalid    => xbar_axi_wvalid(0),                  
    s_axi_csr_wready    => xbar_axi_wready(0),                  
    s_axi_csr_bresp     => xbar_axi_bresp(1 downto 0),          
    s_axi_csr_bvalid    => xbar_axi_bvalid(0),                  
    s_axi_csr_bready    => xbar_axi_bready(0),                  
    s_axi_csr_araddr    => xbar_axi_araddr(6 downto 0),         
    s_axi_csr_arprot    => xbar_axi_arprot(2 downto 0),         
    s_axi_csr_arvalid   => xbar_axi_arvalid(0),                 
    s_axi_csr_arready   => xbar_axi_arready(0),                 
    s_axi_csr_rdata     => xbar_axi_rdata(31 downto 0),         
    s_axi_csr_rresp     => xbar_axi_rresp(1 downto 0),          
    s_axi_csr_rvalid    => xbar_axi_rvalid(0),                  
    s_axi_csr_rready    => xbar_axi_rready(0),                  
    reg0_init_val       => x"00000000",
    reg1_init_val       => x"00000DA0",
    reg2_init_val       => x"00000000",
    reg3_init_val       => x"00000000",
    ctl0_out            => open,
    ctl1_out            => ctl1_out,
    ctl2_out            => ctl2_out,
    ctl3_out            => ctl3_out,
    stat0_in            => stat0_in,
    intrpt_src_in(0)    => sat_int,
    intrpt_src_in(1)    => '0',
    intrpt_src_in(2)    => reload_failed,
    irq                 => irq
  );
  
ctl <= ctl2_out(1 downto 0) & ctl1_out(15 downto 0);
  
ctl_xclk:  xpm_cdc_handshake
generic map (
  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 3, -- integer; range: 2-10
  WIDTH          => 18  -- integer; range: 1-1024
)
port map (
  src_clk    => s_axi_csr_aclk,
  src_in     => ctl,
  src_send   => src_sendc,
  src_rcv    => src_rcvc,
  dest_clk   => aclk,
  dest_req   => dest_reqc,
  dest_ack   => dest_reqc, 
  dest_out   => ctl_rs
);
  
  process(s_axi_csr_aclk)
  begin
     if rising_edge(s_axi_csr_aclk) then
       if (src_rcvc = '1') then
         src_sendc <= '0';
       elsif (src_rcvc = '0') and (src_sendc = '0') then
         src_sendc <= '1';
       end if;  
     end if;
  end process; 
  
  process(aclk)
  begin
     if rising_edge(aclk) then
        gain    <= ctl_rs(15 downto 0); -- Gain value (unsigned)
        sync_en <= ctl_rs(16);
     end if;
  end process;  

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      t1_ctl3_out <= ctl3_out(0);
      ld_coef <= ctl3_out(0) and not t1_ctl3_out; 
   end if;
end process;

stat0_in <= "000000000000000000000000000000" & ld_done & ld_active;

process(aclk)
begin
    if rising_edge(aclk) then
    if (t1_bs_axis_pdti_tvalid = '1') then
        t14_fir_data_tuser <= tuser_dly;
    end if;
        t15_fir_data_tuser <= tuser_strch;
        t16_fir_data_tuser <= t15_fir_data_tuser;
        t17_fir_data_tuser <= t16_fir_data_tuser;
        t18_fir_data_tuser <= t17_fir_data_tuser;     
    end if;
end process;


process(aclk)
begin
    if rising_edge(aclk) then
      x_reload_failed <= event_s_reload_tlast_missing or event_s_reload_tlast_unexpected;
    end if;
end process; 

fail_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => aclk,
    src_rst    => t2_areset,  -- optional; required when RST_USED = 1
    src_pulse  => x_reload_failed,
    dest_clk   => s_axi_csr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => reload_failed
);
  
--------------------------------------------------------------------------------
-- Output
--------------------------------------------------------------------------------

process(aclk)
begin
   if rising_edge(aclk) then
     if (rnd_tvalid = '1') then
        sat                             <= rnd_tuser(104);
        m_axis_pdti_tuser(65 downto 0)  <= rnd_tuser(65 downto 0);
        m_axis_pdti_tuser(73 downto 72) <= rnd_tuser(73 downto 72);           
        m_axis_pdti_tuser(81 downto 80) <= rnd_tuser(81 downto 80);           
        m_axis_pdti_tuser(92 downto 88) <= rnd_tuser(92 downto 88); 
        m_axis_pdti_tuser(104 downto 95)<= rnd_tuser(104 downto 95); 
     end if;   
     m_axis_pdti_tvalid <= rnd_tvalid; 
   end if;
end process;   

m_axis_pdti_tuser(71 downto 66)   <= "000000";
m_axis_pdti_tuser(79 downto 74)   <= "000000";
m_axis_pdti_tuser(87 downto 82)   <= "000000";
m_axis_pdti_tuser(127 downto 105) <= (others => '0');

gen16iqout: if (out_res = 16) generate
process(aclk)
begin
   if rising_edge(aclk) then
      if (rnd_tvalid = '1') then
         m_axis_pdti_tdata  <= q_rnd_out & i_rnd_out;   
      end if;   
   end if;
end process;
m_axis_pdti_tuser(94 downto 93)  <= "01"; -- 16-bit  
end generate gen16iqout; 

gen24iqout: if (out_res = 24) generate
process(aclk)
begin
   if rising_edge(aclk) then
      if (rnd_tvalid = '1') then
         m_axis_pdti_tdata  <= q_rnd_out & i_rnd_out;   
      end if;   
   end if;
   m_axis_pdti_tuser(94 downto 93)  <= "10"; -- 24-bit
end process;   
end generate gen24iqout;


process(aclk)
begin
   if rising_edge(aclk) then
      if (rnd_tvalid = '1') then 
         p1sat <=  rnd_tuser(104);
      end if;
   end if;
end process;

sat_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 4, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 4, -- integer; range: 2-10
  WIDTH          => 1  -- integer; range: 1-1024
)
port map (
  src_clk    => aclk,
  src_in(0)  => p1sat,
  src_send   => src_senda,
  src_rcv    => src_rcva,
  dest_clk   => s_axi_csr_aclk,
  dest_req   => dest_reqa,
  dest_ack   => dest_reqa, 
  dest_out(0)=> sat_int
);

process(aclk)
begin
   if rising_edge(aclk) then
     if (src_rcva = '1') then
       src_senda <= '0';
     elsif (src_rcva = '0') and (src_senda = '0') then
       src_senda <= '1';
     end if;  
   end if;
end process;   


--------------------------------------------------------------------------------  
-- Coefficient Loading State Machine
--------------------------------------------------------------------------------
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
      if (t1_s_axi_csr_aresetn = '0') or (ld_coef_addr_cntr = '1') then
         coef_addr_cntr <= "00000";
      else
         coef_addr_cntr <= coef_addr_cntr + 1;
      end if;
   end if;      
end process;

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      cfifo_rstn <= not (ctl3_out(1) or not t1_s_axi_csr_aresetn);
      if (t1_s_axi_csr_aresetn = '0') then
         t1_ldr_fifo_tvalid <= '0'; 
         t1_ldr_fifo_tlast  <= '0'; 
         t2_ldr_fifo_tvalid <= '0'; 
         t2_ldr_fifo_tlast  <= '0';          
      else
         t1_ldr_fifo_tvalid <= ldr_fifo_tvalid; 
         t1_ldr_fifo_tlast  <= ldr_fifo_tlast;  
         t2_ldr_fifo_tvalid <= t1_ldr_fifo_tvalid; 
         t2_ldr_fifo_tlast  <= t1_ldr_fifo_tlast; 
      end if;
      if (t1_s_axi_csr_aresetn = '0') or (ctl3_out(1) = '1') then
         state              <= RESET_STATE;
         ldr_fifo_tvalid    <= '0'; 
         ldr_fifo_tlast     <= '0'; 
         ld_coef_addr_cntr  <= '1'; 
         ld_done            <= '1';
         ld_active          <= '0';
      else
         case state is 
            when RESET_STATE =>
               ldr_fifo_tvalid <= '0'; 
               ldr_fifo_tlast  <= '0'; 
               if ld_coef = '1' then
                  state              <= START_LOAD_STATE;
                  ld_coef_addr_cntr  <= '1'; 
                  ld_done            <= '0';
                  ld_active          <= '1';
               else
                  ld_coef_addr_cntr  <= '0';
                  state              <= RESET_STATE; 
                  ld_done            <= '1';
                  ld_active          <= '0';
               end if;          
            when START_LOAD_STATE =>
               ldr_fifo_tvalid    <= '1'; 
               ldr_fifo_tlast     <= '0'; 
               ld_coef_addr_cntr  <= '0';
               ld_addr            <= "0000" & coef_addr_cntr(4 downto 0);
               state              <= LOADING_STATE;
            when LOADING_STATE =>
               ld_addr            <= "0000" & coef_addr_cntr(4 downto 0);
               if (coef_addr_cntr = "11010") then
                  ldr_fifo_tlast  <= '1'; 
               end if;
               if (coef_addr_cntr = "11011") then
                  state           <= FINISHED_STATE;
                  ldr_fifo_tvalid <= '0'; 
                  ldr_fifo_tlast  <= '0'; 
               end if;
            when FINISHED_STATE =>
               if (load_finishedx = '1') then
                  state           <= RESET_STATE;
                  ld_done         <= '1';
                  ld_active       <= '0';
               end if;
            when others =>
               state      <= RESET_STATE;
         end case;   
      end if;
   end if;
end process;

fifo_inst : px_2chdec2fir_2_fifo
  PORT MAP (
    m_aclk        => aclk,
    s_aclk        => s_axi_csr_aclk,
    s_aresetn     => cfifo_rstn,
    s_axis_tvalid => t2_ldr_fifo_tvalid,
    s_axis_tready => open,
    s_axis_tdata  => bram_coef,
    s_axis_tlast  => t2_ldr_fifo_tlast,
    m_axis_tvalid => reload_tvalid,
    m_axis_tready => reload_tready,
    m_axis_tdata  => reload_tdata,
    m_axis_tlast  => reload_tlast
);

-- Determine when the coefficient load is complete    
l_cdc_inst: xpm_cdc_pulse
generic map (
  -- Common module generics
  DEST_SYNC_FF   => 4, -- integer; range: 2-10
  REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
  RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
  SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
)
port map (
  src_clk    => aclk,
  src_rst    => t2_areset,  -- optional; required when RST_USED = 1
  src_pulse  => load_finished,
  dest_clk   => s_axi_csr_aclk,
  dest_rst   => '0',  -- optional; required when RST_USED = 1
  dest_pulse => load_finishedx
);


process(aclk)
begin
   if rising_edge(aclk) then
     t2_areset      <=  not t1_aresetn;
     t1_ld_done     <= load_finished;
     t2_ld_done     <= t1_ld_done;
     t3_ld_done     <= t2_ld_done;
     t4_ld_done     <= t3_ld_done;
     t5_ld_done     <= t4_ld_done;
     t6_ld_done     <= t5_ld_done;
     t7_ld_done     <= t6_ld_done;
     ld_rst         <= ((t4_ld_done or t5_ld_done or t6_ld_done) and not t7_ld_done);
     load_finished  <= reload_tready and reload_tvalid and reload_tlast;
   end if;
end process;  

end Behavioral;
