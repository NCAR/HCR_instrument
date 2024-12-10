----------------------------------------------------------------------------------
-- Pentek AXI-Stream (PDTI Type) 16-bit Data Single or Dual Interpolating FIR  
----------------------------------------------------------------------------------
-- px_axis_intfir32_1.vhd
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

-- Additional Comments: 

-- IMPORTANT! tvalid interval must be equal to the overall interpolation value
-- of this stage and any following stages for the filter to operate correctly.
 
-- Interpolation 2 to 32
-- Number of Taps = 32*Interpolation
-- 24-bit Coefficients
-- Compatible with 16-bit PDTI AXI Streams 
-- latency = 48 + (15*Interpolation)
-- Load and Readback of Coefficents
-- Decimation of FIR can be synchronized to SYNC in PDTI tuser sideband stream
-- Adjustable Gain

-- Register Space
-- 0x000 = Interpolation Register  (Interpolation = INTERP_REG[4:0]+1)
-- [4:0] = INTERP
-- [31:16] = Output Rate Div  
-- If this Interpolator will be followed by additional interpolation stages
-- the output rate must be set to:
-- total interpolation of following stages -1
-- 0x004 = Gain Register (Gain = GAIN_REG[15:0] unsigned)
-- 0x008 = Control Register 
--    [0] = BYPASS_N  '0' = Bypass Filter, '1' = Enable Filter
--    [1] = SYNC ENABLE '0' = SYNC ignored, '1' = SYNC Resets Decimation Counter
-- 0x00C = Coefficient Load Register
--    [0] = COEF LOAD  -- Toggle to load coefficients into the Filter
-- 0x010 = Status Register
--    [0] = COEF LOAD IN PROGRESS   '1' = Coeffients are being loaded
--    [1] = COEF LOAD DONE          '1' = Coefficients are loaded  
-- Coefficient RAM Space
-- 0x1000 - 0x1FFF

-- Coefficients are written into RAM before loading into the FIR
-- Filter can be up to 32xInterpolation number of coefficients in length, symetrical
-- or non-symmetrical, odd or even length.
-- If using less than the maximum number of coeffiecients, pad first and last
-- unused coeffients with zeros, centering used coeffients.

-- The input TUSER sideband data is delayed to the output TUSER by the latency
-- of the filter, assuming a symetrical filter set. 
 
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

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

entity px_axis_intfir32_1 is
generic (
   num_chan : integer  := 2;  -- 1 or 2 (2 = iq) 
   out_res  : integer  := 16; -- 16 or 24
   bypass_in_lower : boolean := true -- Bypass data is in lower or upper 16 bits of output
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
   s_axis_pdti_tdata  : in  std_logic_vector((num_chan*16)-1 downto 0);  
   s_axis_pdti_tuser  : in  std_logic_vector(127 downto 0);
   s_axis_pdti_tvalid : in  std_logic; -- tvalid MUST be at the correct decimated rate spacing
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
   m_axis_pdti_tdata  : out std_logic_vector((num_chan*out_res)-1 downto 0);  
   m_axis_pdti_tuser  : out std_logic_vector(127 downto 0);
   m_axis_pdti_tvalid : out std_logic;
   
   sat                : out std_logic      

);
end px_axis_intfir32_1;

architecture Behavioral of px_axis_intfir32_1 is

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
ATTRIBUTE X_INTERFACE_PARAMETER of aclk: SIGNAL is "ASSOCIATED_BUSIF m_axis_pdti:s_axis_pdti, ASSOCIATED_RESET aresetn";

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------
-- RAM Based Shift Register
-- Delay = A+2
-- 128 wide
COMPONENT px_axis_intfir32_sr128
  PORT (
    A    : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    D    : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    CLK  : IN STD_LOGIC;
    CE   : IN STD_LOGIC;
    Q    : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
  );
END COMPONENT;

-- RAM Based Shift Register
-- Delay = A+2
-- 16 wide
COMPONENT px_axis_intfir32_sr16
  PORT (
    A    : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    D    : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    CLK  : IN STD_LOGIC;
    CE   : IN STD_LOGIC;
    Q    : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT;

-- DSP48 
-- D (24-bit)
-- B (16-bit)
-- D*B -> PCOUT
COMPONENT px_axis_intfir32_dsp48db
  PORT (
    CLK : IN STD_LOGIC;
    CE : IN STD_LOGIC;
    B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    D : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    PCOUT : OUT STD_LOGIC_VECTOR(47 DOWNTO 0);
    P : OUT STD_LOGIC_VECTOR(39 DOWNTO 0)
  );
END COMPONENT;

-- DSP48 
-- D (24-bit)
-- B (16-bit)
-- (D*B)+PCIN -> PCOUT
COMPONENT px_axis_intfir32_dsp48dbpi
  PORT (
    CLK : IN STD_LOGIC;
    CE : IN STD_LOGIC;
    B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    D : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    PCIN : IN STD_LOGIC_VECTOR(47 DOWNTO 0);
    PCOUT : OUT STD_LOGIC_VECTOR(47 DOWNTO 0);
    P : OUT STD_LOGIC_VECTOR(47 DOWNTO 0)
  );
END COMPONENT;

-- Distributed RAM
-- Simple Dual Port
-- 32x24
COMPONENT px_axis_intfir32_coefram
  PORT (
    a : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    d : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    dpra : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    clk : IN STD_LOGIC;
    we : IN STD_LOGIC;
    qdpo_ce : IN STD_LOGIC;
    qdpo_clk : IN STD_LOGIC;
    qdpo : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
  );
END COMPONENT;

-- Multiplier
-- DSP48
-- latency = 5
COMPONENT px_axis_intfir32_mult
  PORT (
    CLK : IN STD_LOGIC;
    A : IN STD_LOGIC_VECTOR(44 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    CE : IN STD_LOGIC;
    P : OUT STD_LOGIC_VECTOR(60 DOWNTO 0)
  );
END COMPONENT;

-- Control/Status Registers
-- 4 Control
-- 1 Status
-- Interrupt Regs
COMPONENT px_axis_intfir32l_csr
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
    intrpt_src_in : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    irq : OUT STD_LOGIC
  );
END COMPONENT;

COMPONENT px_axis_intfir32_mem
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    clkb : IN STD_LOGIC;
    web : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dinb : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

-- AXI_Lite Block RAM Controller
COMPONENT px_axis_intfir32_brctlr
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

-- AXI Crossbar
-- Port 0 0x0000
-- Port 1 0x1000
COMPONENT px_axis_intfir32_axi_xbar
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

COMPONENT px_axis_intfir32_dlyr
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    clkb : IN STD_LOGIC;
    enb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
  );
END COMPONENT;

-- Clock Domain Crossing
COMPONENT px_axis_intfir32_xclk
  PORT (
    in_clk : IN STD_LOGIC;
    in_sig : IN STD_LOGIC;
    out_sig : OUT STD_LOGIC;
    out_clk : IN STD_LOGIC
  );
END COMPONENT;

-- Symmetrical Round 51 to 24 bits
COMPONENT px_axis_intfir32_rnd24
  PORT (
    axis_aclk : IN STD_LOGIC;
    axis_aresetn : IN STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(50 DOWNTO 0);
    s_axis_tuser : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    s_axis_tvalid : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
    m_axis_tuser : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC
  );
END COMPONENT;

-- Symmetrical Round 51 to 16 bits
COMPONENT px_axis_intfir32_rnd16
  PORT (
    axis_aclk : IN STD_LOGIC;
    axis_aresetn : IN STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(50 DOWNTO 0);
    s_axis_tuser : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    s_axis_tvalid : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_tuser : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC
  );
END COMPONENT;

-- Saturate 61 to 51 bits
COMPONENT px_axis_intfir32_sat
  PORT (
    axis_aclk : IN STD_LOGIC;
    axis_aresetn : IN STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(60 DOWNTO 0);
    s_axis_tuser : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    s_axis_tvalid : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(50 DOWNTO 0);
    m_axis_tuser : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC;
    sat_out : OUT STD_LOGIC
  );
END COMPONENT;

-- Output Rate Smoothing FIFO
-- Distributed RAM
-- 32 deep
COMPONENT px_axis_intfir32_1_outfifo
  PORT (
    s_aclk : IN STD_LOGIC;
    s_aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    s_axis_tuser : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
    m_axis_tuser : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
  );
END COMPONENT;

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

type state_type is (
reset_state,
coef0_state,
coef1_state,
coef2_state,
coef3_state,
coef4_state,
coef5_state,
coef6_state,
coef7_state,
coef8_state,
coef9_state,
coef10_state,
coef11_state,
coef12_state,
coef13_state,
coef14_state,
coef15_state,
coef16_state,
coef17_state,
coef18_state,
coef19_state,
coef20_state,
coef21_state,
coef22_state,
coef23_state,
coef24_state,
coef25_state,
coef26_state,
coef27_state,
coef28_state,
coef29_state,
coef30_state,
coef31_state
);

type tap_vector is array (0 to 31) of std_logic_vector((num_chan*16)-1 downto 0);
type dsp_pc_vector is array (0 to 31) of std_logic_vector(47 downto 0);
type coef_vector is array (0 to 31) of std_logic_vector(23 downto 0);
type tuser_vector is array (0 to 17) of std_logic_vector(127 downto 0);
type int_cntr_vector is array (0 to 31) of std_logic_vector(4 downto 0);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal t1_s_axis_pdti_tdata : std_logic_vector((num_chan*16)-1 downto 0) := (others => '0'); 
signal t1_s_axis_pdti_tuser : std_logic_vector(127 downto 0) := (others => '0'); 
signal t1_s_axis_pdti_tvalid: std_logic := '0';
signal t2_s_axis_pdti_tdata : std_logic_vector((num_chan*16)-1 downto 0) := (others => '0'); 
signal t2_s_axis_pdti_tuser : std_logic_vector(127 downto 0) := (others => '0'); 
signal t1_aresetn: std_logic := '0';
signal sync_re: std_logic := '0';
signal dval_cntr: std_logic_vector(4 downto 0) := (others => '0');  
signal t1_intrp: std_logic_vector(4 downto 0) := (others => '0'); 
signal t2_dval_stretch: std_logic := '0';
signal t3_dval_stretch: std_logic := '0';
signal t4_dval_stretch: std_logic := '0';
signal tap                   : tap_vector;
signal t1_tap                : tap_vector;
signal coef                  : coef_vector;
signal comp_coef             : coef_vector;
signal tuser                 : tuser_vector;
signal int_cntrv             : int_cntr_vector;
signal dly_val               : std_logic_vector(4 downto 0) := "00000";
signal i_dsp_pcout           : dsp_pc_vector;
signal q_dsp_pcout           : dsp_pc_vector;
signal i_acc_out             : std_logic_vector(47 downto 0) := (others => '0');
signal q_acc_out             : std_logic_vector(47 downto 0) := (others => '0');
signal i_gain_out            : std_logic_vector(60 downto 0) := (others => '0');
signal q_gain_out            : std_logic_vector(60 downto 0) := (others => '0');
signal gain                  : std_logic_vector(15 downto 0) := (others => '0');
signal i_sat_out             : std_logic_vector(50 downto 0) := (others => '0');
signal q_sat_out             : std_logic_vector(50 downto 0) := (others => '0');
signal i_rnd_out             : std_logic_vector(out_res-1 downto 0) := (others => '0');
signal q_rnd_out             : std_logic_vector(out_res-1 downto 0) := (others => '0');
signal ld_dly_vctr           : std_logic_vector(36 downto 0) := (others => '0');
signal coef_wr_addr          : std_logic_vector(4 downto 0)  := (others => '0');
signal p1_coef_wr_addr       : std_logic_vector(4 downto 0)  := (others => '0');
signal ld_addr               : std_logic_vector(9 downto 0)  := (others => '0');
signal bram_coef             : std_logic_vector(31 downto 0) := (others => '0');
signal coef_we               : std_logic_vector(31 downto 0) := (others => '0');
signal p1_coef_we            : std_logic_vector(31 downto 0) := (others => '0');
signal ld                    : std_logic   := '0';
signal intrp                 : std_logic_vector(4 downto 0)  := (others => '0');
signal sync_en               : std_logic   := '0';
signal bypass_n              : std_logic   := '0';
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
signal bram_we               : std_logic_vector(3 downto 0) := (others => '0');
signal bram_addr             : std_logic_vector(9 downto 0) := (others => '0');
signal bram_wrdata           : std_logic_vector(31 downto 0) := (others => '0');
signal bram_rddata           : std_logic_vector(31 downto 0) := (others => '0');
signal g_ff                  : std_logic   := '0';
signal s_ff                  : std_logic   := '0';
signal p_ff                  : std_logic   := '0';
signal ld_active             : std_logic   := '0';
signal ld_done               : std_logic   := '0';
signal state                 : state_type  := reset_state;
signal sat_i                 : std_logic   := '0';
signal sat_q                 : std_logic   := '0';
signal ctl0_out              : std_logic_vector(31 downto 0) := (others => '0');
signal ctl1_out              : std_logic_vector(31 downto 0) := (others => '0');
signal ctl2_out              : std_logic_vector(31 downto 0) := (others => '0');
signal ctl3_out              : std_logic_vector(31 downto 0) := (others => '0');
signal stat0_in              : std_logic_vector(31 downto 0) := (others => '0');
signal ld_coef               : std_logic   := '0';
signal t1_ctl3_out           : std_logic   := '0';
signal acc_dval              : std_logic   := '0';
signal p1sat                 : std_logic   := '0';
signal p2sat                 : std_logic   := '0';
signal p3sat                 : std_logic   := '0'; 
signal intrpp1               : std_logic_vector(4 downto 0) := (others => '0');
signal intrpp1x15            : std_logic_vector(8 downto 0) := (others => '0');
signal tuser_dly_val         : std_logic_vector(9 downto 0) := (others => '0');
signal dly_w_addr            : std_logic_vector(9 downto 0) := (others => '0');
signal dly_r_addr            : std_logic_vector(9 downto 0) := (others => '0');
signal sat_int               : std_logic := '0';
signal multdvaldly           : std_logic_vector(4 downto 0) := (others => '0');
signal sat_tvalid            : std_logic := '0';
signal rnd_tvalid            : std_logic := '0';
signal rnd_tuser             : std_logic_vector(127 downto 0) := (others => '0');
signal sat_tuser             : std_logic_vector(127 downto 0) := (others => '0');
signal satx_tuser            : std_logic_vector(127 downto 0) := (others => '0');
signal out_rate_cntr         : std_logic_vector(15 downto 0)   := (others => '0');
signal fifoin_tdata          : std_logic_vector(63 downto 0)  := (others => '0');
signal fifoout_tuser         : std_logic_vector(127 downto 0) := (others => '0');
signal fifoout_tdata         : std_logic_vector(63 downto 0)  := (others => '0');
signal fifoout_tready        : std_logic := '0';
signal outfifo_rstn          : std_logic := '0';
signal outrate               : std_logic_vector(15 downto 0) := (others => '0');
signal t1_outrate            : std_logic_vector(15 downto 0) := (others => '0');
signal ctl                   : std_logic_vector(39 downto 0) := (others => '0');
signal ctl_rs                : std_logic_vector(39 downto 0) := (others => '0');
signal src_sendc             : std_logic := '0';
signal src_rcvc              : std_logic := '0';
signal dest_reqc             : std_logic := '0';
signal outfifo_rstn1         : std_logic := '0';
signal outfifo_rstn2         : std_logic := '0';
signal t1_rnd_tuser127       : std_logic := '0';
signal t2_rnd_tuser127       : std_logic := '0';
signal t1_s_axi_csr_aresetn  : std_logic := '0';
--------------------------------------------------------------------------------

begin

-- tvalid interval must be the overall interpolation value of this stage
-- and any following stages.
 
process(aclk)
begin
   if rising_edge(aclk) then
      t1_s_axis_pdti_tdata     <= s_axis_pdti_tdata;  
      t1_s_axis_pdti_tuser     <= s_axis_pdti_tuser;  
      t1_s_axis_pdti_tvalid    <= s_axis_pdti_tvalid; 
      t2_s_axis_pdti_tuser(126 downto 0) <= t1_s_axis_pdti_tuser(126 downto 0); 
      t2_s_axis_pdti_tuser(127)<= t1_s_axis_pdti_tvalid; 
      if (t1_s_axis_pdti_tvalid = '1') then
         t2_s_axis_pdti_tdata  <= t1_s_axis_pdti_tdata;  
      end if;
      sync_re                  <= s_axis_pdti_tuser(72) and (not t1_s_axis_pdti_tuser(72)); 
      t1_aresetn               <= aresetn;
   end if;
end process;

process(aclk)
begin
   if rising_edge(aclk) then
      if t1_s_axis_pdti_tvalid = '1' then
         dval_cntr <= "00000";
      elsif (dval_cntr /= t1_intrp) then
         dval_cntr <= dval_cntr + 1;
      end if;
      if (t1_s_axis_pdti_tvalid = '1') or (dval_cntr /= t1_intrp) or
         (dval_cntr = "00000") then
         t2_dval_stretch <= '1';
      else
         t2_dval_stretch <= '0';
      end if;
      dly_val      <= intrp - 1;
   end if;
end process;

tap(0)((num_chan*16)-1 downto 0) <= t2_s_axis_pdti_tdata;

process(aclk)
begin
   if rising_edge(aclk) then
      if t2_dval_stretch = '1' then
         t1_tap(0) <= tap(0);
      end if;    
   end if;
end process;

--------------------------------------------------------------------------------
-- Filter Taps
--------------------------------------------------------------------------------
-- 32 x Interpolation Taps

tap_gen: for i in 0 to 30 generate

tap_i_inst: px_axis_intfir32_sr16
port map (
    A    => dly_val,
    D    => t1_tap(i)(15 downto 0),
    CLK  => aclk,
    CE   => t2_dval_stretch,
    Q    => tap(i+1)(15 downto 0)
);

-- If IQ then generate taps for Q data
gen_q_tap: if (num_chan /= 1) generate

tap_q_inst: px_axis_intfir32_sr16
port map (
    A    => dly_val,
    D    => t1_tap(i)(31 downto 16),
    CLK  => aclk,
    CE   => t2_dval_stretch,
    Q    => tap(i+1)(31 downto 16)
);
end generate gen_q_tap;

process(aclk)
begin
   if rising_edge(aclk) then
      if t2_dval_stretch = '1' then
         t1_tap(i+1) <= tap(i+1);
      end if;    
   end if;
end process;

end generate tap_gen;

--------------------------------------------------------------------------------
-- Comp Delays
--------------------------------------------------------------------------------
-- Compensate for delays in DSP blocks in filter DSP chain
comp_coef(0) <= coef(0);

int_cntrv(0)(4 downto 0) <= dval_cntr;

gen_addr_cntr_dly: for i in 1 to 31 generate
process(aclk)
begin
   if rising_edge(aclk) then
      if t2_dval_stretch = '1' then
         int_cntrv(i)(4 downto 0) <= int_cntrv(i-1)(4 downto 0);
      end if;
   end if;   
end process;   
comp_coef(i) <= coef(i);   
end generate gen_addr_cntr_dly; 


--------------------------------------------------------------------------------
-- Tap DSP Blocks
--------------------------------------------------------------------------------

i_dsp0_inst: px_axis_intfir32_dsp48db
port map (
    CLK   => aclk,
    CE    => t2_dval_stretch,
    B     => t1_tap(0)(15 downto 0),
    D     => comp_coef(0)(23 downto 0),
    PCOUT => i_dsp_pcout(0),
    P     => open
  );

gen_q0dsp: if (num_chan /= 1) generate

q_dsp0_inst: px_axis_intfir32_dsp48db
port map (
    CLK   => aclk,
    CE    => t2_dval_stretch,
    B     => t1_tap(0)(31 downto 16),
    D     => comp_coef(0)(23 downto 0),
    PCOUT => q_dsp_pcout(0),
    P     => open
  );  

end generate gen_q0dsp;

dsp_gen: for i in 1 to 30 generate

i_dsp_inst: px_axis_intfir32_dsp48dbpi
port map (
    CLK   => aclk,
    CE    => t2_dval_stretch,
    B     => t1_tap(i)(15 downto 0),
    D     => comp_coef(i)(23 downto 0),
    PCIN  => i_dsp_pcout(i-1),
    PCOUT => i_dsp_pcout(i),
    P     => open
  );

gen_qdsp: if (num_chan /= 1) generate
  
q_dsp_inst: px_axis_intfir32_dsp48dbpi
  port map (
      CLK   => aclk,
      CE    => t2_dval_stretch,
      B     => t1_tap(i)(31 downto 16),
      D     => comp_coef(i)(23 downto 0),
      PCIN  => q_dsp_pcout(i-1),
      PCOUT => q_dsp_pcout(i),
      P     => open
    );

end generate gen_qdsp;    

end generate dsp_gen;

ilast_dsp_inst: px_axis_intfir32_dsp48dbpi
port map (
    CLK   => aclk,
    CE    => t2_dval_stretch,
    B     => t1_tap(31)(15 downto 0),
    D     => comp_coef(31)(23 downto 0),
    PCIN  => i_dsp_pcout(30),
    PCOUT => open,
    P     => i_dsp_pcout(31)
  );

gen_qdsplast: if (num_chan /= 1) generate
  
qlast_dsp_inst: px_axis_intfir32_dsp48dbpi
  port map (
      CLK   => aclk,
      CE    => t2_dval_stretch,
      B     => t1_tap(31)(31 downto 16),
      D     => comp_coef(31)(23 downto 0),
      PCIN  => q_dsp_pcout(30),
      PCOUT => open,
      P     => q_dsp_pcout(31)
    );

end generate gen_qdsplast; 

--------------------------------------------------------------------------------
-- Coefficient RAM
--------------------------------------------------------------------------------

coef_ram_gen: for i in 0 to 31 generate

coef_ram_inst : px_axis_intfir32_coefram
port map (
    a          => coef_wr_addr,
    d          => bram_coef(23 downto 0),
    dpra       => int_cntrv(i),
    clk        => s_axi_csr_aclk,
    we         => coef_we(i),
    qdpo_ce    => t2_dval_stretch,
    qdpo_clk   => aclk,
    qdpo       => coef(i)(23 downto 0)
  );

end generate coef_ram_gen;


--------------------------------------------------------------------------------
-- Filter Output Gain
--------------------------------------------------------------------------------
-- latency = 5
gain_i_inst : px_axis_intfir32_mult
port map (
    CLK => aclk,
    A   => i_dsp_pcout(31)(44 downto 0),
    B   => gain,
    CE  => '1',
    P   => i_gain_out
);

gen_qgain: if (num_chan /= 1) generate

gain_q_inst : px_axis_intfir32_mult
port map (
    CLK => aclk,
    A   => q_dsp_pcout(31)(44 downto 0),
    B   => gain,
    CE  => '1', 
    P   => q_gain_out
);

end generate gen_qgain;


-- Compensate for Multiplier latency = 5
process(aclk)
begin
   if rising_edge(aclk) then
      multdvaldly <= multdvaldly(3 downto 0) & t2_dval_stretch;
   end if;   
end process;   

comp_acc_tuser_inst: px_axis_intfir32_sr128
port map (
    A    => "00011",
    D    => tuser(16),
    CLK  => aclk,
    CE   => '1',
    Q    => tuser(17)
);  

--------------------------------------------------------------------------------
-- Filter Output Saturation and Rounding
--------------------------------------------------------------------------------

i_sat_inst: px_axis_intfir32_sat
port map (
  axis_aclk      => aclk,
  axis_aresetn   => '1',
  s_axis_tdata   => i_gain_out,
  s_axis_tuser   => tuser(17)(127 downto 0),
  s_axis_tvalid  => multdvaldly(4),
  m_axis_tdata   => i_sat_out,
  m_axis_tuser   => sat_tuser,
  m_axis_tvalid  => sat_tvalid,
  sat_out        => sat_i
);

gen_qsat: if (num_chan /= 1) generate

q_sat_inst: px_axis_intfir32_sat
port map (
  axis_aclk      => aclk,
  axis_aresetn   => '1',
  s_axis_tdata   => q_gain_out,
  s_axis_tuser   => x"00000000000000000000000000000000",
  s_axis_tvalid  => multdvaldly(4), 
  m_axis_tdata   => q_sat_out,
  m_axis_tuser   => open,
  m_axis_tvalid  => open,
  sat_out        => sat_q
);          
          
end generate gen_qsat;

gen_noqsat: if (num_chan = 1) generate
sat_q <= '0';
end generate gen_noqsat;

satx_tuser <= sat_tuser(127 downto 105) & (sat_i or sat_q) & sat_tuser(103 downto 0);

gen16rnd: if (out_res = 16) generate
-- Round Data down to 16 bits for Cascade
round_gen_i16: px_axis_intfir32_rnd16
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

gen_qrnd16: if (num_chan /= 1) generate

round_gen_q16: px_axis_intfir32_rnd16
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

end generate gen_qrnd16;

end generate gen16rnd;

gen24rnd: if (out_res = 24) generate
-- Round Data down to 24 bits for Cascade
          
round_gen_i24: px_axis_intfir32_rnd24
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

gen_qrnd24: if (num_chan /= 1) generate

round_gen_q24: px_axis_intfir32_rnd24
port map (
    axis_aclk     => aclk,
    axis_aresetn  => '1',
    s_axis_tdata  => q_sat_out,
    s_axis_tuser  => x"00000000000000000000000000000000",
    s_axis_tvalid => sat_tvalid, 
    m_axis_tdata  => q_rnd_out,
    m_axis_tuser  => open,
    m_axis_tvalid => open
   );


end generate gen_qrnd24;

end generate gen24rnd;

--------------------------------------------------------------------------------
-- Control/Status Registers
--------------------------------------------------------------------------------

axi_xbar_inst : px_axis_intfir32_axi_xbar
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

csr_inst : px_axis_intfir32l_csr
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
    reg0_init_val       => x"00010001",
    reg1_init_val       => x"00000800",
    reg2_init_val       => x"00000000",
    reg3_init_val       => x"00000000",
    ctl0_out            => ctl0_out,
    ctl1_out            => ctl1_out,
    ctl2_out            => ctl2_out,
    ctl3_out            => ctl3_out,
    stat0_in            => stat0_in,
    intrpt_src_in(0)    => sat_int,
    irq                 => irq
  );

ctl <= ctl0_out(31 downto 16) & '0' & ctl2_out(1 downto 0) & ctl1_out(15 downto 0) & ctl0_out(4 downto 0);

-- Controls Clock Domain Crossing
ctl_xclk:  xpm_cdc_handshake
generic map (
  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 3, -- integer; range: 2-10
  WIDTH          => 40  -- integer; range: 1-1024
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
      intrp   <= ctl_rs(4 downto 0);  -- Interpolation 1 = 2, 31 = 32
      gain    <= ctl_rs(20 downto 5); -- Gain value (unsigned)
      sync_en <= ctl_rs(22);
      bypass_n<= ctl_rs(21);
      outrate <= ctl_rs(39 downto 24); -- Output Rate 1 = 2, x"FFFF" = 65536
   end if;
end process;  

--process(aclk)
--begin
--   if rising_edge(aclk) then
--      intrp   <= ctl0_out(4 downto 0);  -- Interpolation 1 = 2, 31 = 32
--      gain    <= ctl1_out(15 downto 0); -- Gain value (unsigned)
--      sync_en <= ctl2_out(1);
--      bypass_n<= ctl2_out(0); 
--      outrate <= ctl0_out(31 downto 16); -- Output Rate 1 = 2, x"FFFF" = 65536
--   end if;
--end process;   

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      t1_ctl3_out <= ctl3_out(0);
      ld_coef     <= ctl3_out(0) and not t1_ctl3_out; 
   end if;
end process;

stat0_in <= "000000000000000000000000000000" & ld_done & ld_active;



--------------------------------------------------------------------------------
-- Coefficient RAM
--------------------------------------------------------------------------------

bram_ctlr_inst : px_axis_intfir32_brctlr
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


coef_bram_inst : px_axis_intfir32_mem
port map (
    clka    => s_axi_csr_aclk,
    wea     => bram_we,
    addra   => bram_addr,
    dina    => bram_wrdata,
    douta   => bram_rddata,
    clkb    => s_axi_csr_aclk,
    web     => "0000",
    addrb   => ld_addr,
    dinb    => x"00000000",
    doutb   => bram_coef
  );
  
--------------------------------------------------------------------------------
-- Coefficient loader
--------------------------------------------------------------------------------

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
      t1_intrp <= intrp;
      if (t1_s_axi_csr_aresetn = '0') then
         p1_coef_wr_addr <= "00000"; 
         p1_coef_we <= (others => '0');
         ld_addr <= (others => '0');
         state <= reset_state;
         ld_active <= '0';
         ld_done   <= '0';
      else    
         case state is
            when reset_state =>
               if (ld_coef = '1') then
                  state <= coef0_state;
                  p1_coef_we(0)   <= '1';
               else
                  p1_coef_wr_addr <= "00000"; 
                  p1_coef_we      <= (others => '0');
                  ld_addr         <= (others => '0');
                  state           <= reset_state;
               end if;
            when coef0_state =>
               ld_active <= '1';
               ld_done   <= '0';
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(0)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef1_state;
                  p1_coef_we(1)   <= '1';
               else
                  p1_coef_we(0)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef0_state;
               end if;
            when coef1_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(1)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef2_state;
                  p1_coef_we(2)   <= '1';
               else
                  p1_coef_we(1)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef1_state;
               end if;   
            when coef2_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(2)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef3_state;
                  p1_coef_we(3)   <= '1';
               else
                  p1_coef_we(2)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef2_state;
               end if;   
            when coef3_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(3)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef4_state;
                  p1_coef_we(4)   <= '1';
               else
                  p1_coef_we(3)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef3_state;
               end if;   
            when coef4_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(4)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef5_state;
                  p1_coef_we(5)   <= '1';
               else
                  p1_coef_we(4)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef4_state;
               end if;   
            when coef5_state =>
                  if (p1_coef_wr_addr = t1_intrp) then
                     p1_coef_wr_addr <= "00000";
                     p1_coef_we(5)   <= '0';
                     ld_addr         <= ld_addr + 1;
                     state           <= coef6_state;
                     p1_coef_we(6)   <= '1';
                  else
                     p1_coef_we(5)   <= '1';
                     p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                     ld_addr         <= ld_addr + 1;
                     state           <= coef5_state;
                  end if;   
            when coef6_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(6)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef7_state;
                  p1_coef_we(7)   <= '1';
               else
                  p1_coef_we(6)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef6_state;
               end if;                  
            when coef7_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(7)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef8_state;
                  p1_coef_we(8)   <= '1';
               else
                  p1_coef_we(7)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef7_state;
               end if;     
            when coef8_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(8)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef9_state;
                  p1_coef_we(9)   <= '1';
               else
                  p1_coef_we(8)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef8_state;
               end if;
            when coef9_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(9)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef10_state;
                  p1_coef_we(10)   <= '1';
               else
                  p1_coef_we(9)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef9_state;
               end if;   
            when coef10_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(10)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef11_state;
                  p1_coef_we(11)   <= '1';
               else
                  p1_coef_we(10)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef10_state;
               end if;   
            when coef11_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(11)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef12_state;
                  p1_coef_we(12)   <= '1';
               else
                  p1_coef_we(11)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef11_state;
               end if;   
            when coef12_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(12)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef13_state;
                  p1_coef_we(13)   <= '1';
               else
                  p1_coef_we(12)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef12_state;
               end if;   
            when coef13_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(13)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef14_state;
                  p1_coef_we(14)   <= '1';
               else
                  p1_coef_we(13)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef13_state;
               end if;                  
            when coef14_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(14)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef15_state;
                  p1_coef_we(15)   <= '1';
               else
                  p1_coef_we(14)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef14_state;
               end if; 
            when coef15_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(15)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef16_state;
                  p1_coef_we(16)   <= '1';
               else
                  p1_coef_we(15)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef15_state;
               end if;   
            when coef16_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(16)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef17_state;
                  p1_coef_we(17)   <= '1';
               else
                  p1_coef_we(16)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef16_state;
               end if;
            when coef17_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(17)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef18_state;
                  p1_coef_we(18)   <= '1';
               else
                  p1_coef_we(17)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef17_state;
               end if;   
            when coef18_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(18)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef19_state;
                  p1_coef_we(19)   <= '1';
               else
                  p1_coef_we(18)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef18_state;
               end if;   
            when coef19_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(19)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef20_state;
                  p1_coef_we(20)   <= '1';
               else
                  p1_coef_we(19)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef19_state;
               end if;   
            when coef20_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(20)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef21_state;
                  p1_coef_we(21)   <= '1';
               else
                  p1_coef_we(20)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef20_state;
               end if;   
            when coef21_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(21)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef22_state;
                  p1_coef_we(22)   <= '1';
               else
                  p1_coef_we(21)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef21_state;
               end if;   
            when coef22_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(22)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef23_state;
                  p1_coef_we(23)   <= '1';
               else
                  p1_coef_we(22)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef22_state;
               end if;                  
            when coef23_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(23)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef24_state;
                  p1_coef_we(24)   <= '1';
               else
                  p1_coef_we(23)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef23_state;
               end if;     
            when coef24_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(24)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef25_state;
                  p1_coef_we(25)   <= '1';
               else
                  p1_coef_we(24)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef24_state;
               end if;
            when coef25_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(25)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef26_state;
                  p1_coef_we(26)   <= '1';
               else
                  p1_coef_we(25)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef25_state;
               end if;   
            when coef26_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(26)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef27_state;
                  p1_coef_we(27)   <= '1';
               else
                  p1_coef_we(26)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef26_state;
               end if;   
            when coef27_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(27)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef28_state;
                  p1_coef_we(28)   <= '1';
               else
                  p1_coef_we(27)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef27_state;
               end if;   
            when coef28_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(28)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef29_state;
                  p1_coef_we(29)   <= '1';
               else
                  p1_coef_we(28)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef28_state;
               end if;   
            when coef29_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(29)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef30_state;
                  p1_coef_we(30)   <= '1';
               else
                  p1_coef_we(29)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef29_state;
               end if;                  
            when coef30_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(30)   <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= coef31_state;
                  p1_coef_we(31)   <= '1';
               else
                  p1_coef_we(30)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef30_state;
               end if; 
            when coef31_state =>
               if (p1_coef_wr_addr = t1_intrp) then
                  p1_coef_wr_addr <= "00000";
                  p1_coef_we(31)  <= '0';
                  ld_addr         <= ld_addr + 1;
                  state           <= reset_state;
                  ld_active       <= '0';
                  ld_done         <= '1';
               else
                  p1_coef_we(31)   <= '1';
                  p1_coef_wr_addr <= p1_coef_wr_addr + 1;
                  ld_addr         <= ld_addr + 1;
                  state           <= coef31_state;
               end if;
           when others =>
              state           <= reset_state;
         end case;               
      end if;   
      coef_we      <= p1_coef_we;
      coef_wr_addr <= p1_coef_wr_addr;
   end if;
end process;

--------------------------------------------------------------------------------
-- Delay tuser Stream to match the filter output delay
--------------------------------------------------------------------------------
-- Compensate for DSP48 latencies
-- Compenstate for Tap latency
-- Compensate for Accumulator latency

-- BRAM Delay
dlyr_inst : px_axis_intfir32_dlyr
  PORT MAP (
    clka => aclk,
    ena => t2_dval_stretch, 
    wea => "1",
    addra => dly_w_addr,
    dina => t2_s_axis_pdti_tuser,
    clkb => aclk,
    enb => t2_dval_stretch, 
    addrb => dly_r_addr,
    doutb => tuser(16)
  );

-- Calculate Delay
process(aclk)
begin
   if rising_edge(aclk) then
      intrpp1 <= t1_intrp + 1;
      --intrpp1x15 <= (intrpp1 & "0000") - ("0000" & intrpp1);
      intrpp1x15 <= (intrpp1 & "0000");
      tuser_dly_val <= ('0' & intrpp1x15) + 35;
      if (t1_aresetn = '0') then
         dly_r_addr <= "0000000000";
         dly_w_addr <= tuser_dly_val;
      elsif (t2_dval_stretch = '1') then
         dly_r_addr <= dly_r_addr + 1;
         dly_w_addr <= dly_r_addr + tuser_dly_val;
      end if;
   end if;  
end process;

--------------------------------------------------------------------------------
-- Output Rate Smoothing FIFO
-------------------------------------------------------------------------------- 

fifoin_2ch_gen: if (num_chan /= 1) generate

fifoin_2_24gen: if (out_res = 24) generate
   fifoin_tdata <= x"0000" & q_rnd_out & i_rnd_out;
end generate fifoin_2_24gen;

fifoin_2_16gen: if (out_res = 16) generate
   fifoin_tdata <= x"0000" & x"00" & q_rnd_out & x"00" & i_rnd_out;
end generate fifoin_2_16gen;

end generate fifoin_2ch_gen;

fifoin_1ch_gen: if (num_chan = 1) generate

fifoin_1_24gen: if (out_res = 24) generate
   fifoin_tdata <= x"0000" & x"0000" & i_rnd_out;
end generate fifoin_1_24gen;

fifoin_1_16gen: if (out_res = 16) generate
   fifoin_tdata <= x"0000" & x"000000" & i_rnd_out;
end generate fifoin_1_16gen;

end generate fifoin_1ch_gen;

-- Output Rate Smoothing FIFO
outfifo_inst : px_axis_intfir32_1_outfifo
port map (
    s_aclk        => aclk,
    s_aresetn     => outfifo_rstn,
    s_axis_tvalid => rnd_tvalid,
    s_axis_tready => open,
    s_axis_tdata  => fifoin_tdata,
    s_axis_tuser  => rnd_tuser,
    m_axis_tvalid => open,
    m_axis_tready => fifoout_tready,
    m_axis_tdata  => fifoout_tdata,
    m_axis_tuser  => fifoout_tuser
  );


outfifo_rstn1 <= '0' when (((sync_re = '1') and (sync_en = '1')) or (t1_aresetn = '0')) else '1';  

process(aclk)
begin
   if rising_edge(aclk) then
        outfifo_rstn2 <= outfifo_rstn1;
        outfifo_rstn <= outfifo_rstn1 and outfifo_rstn2;
   end if;
end process;     
--------------------------------------------------------------------------------
-- Output
--------------------------------------------------------------------------------

process(aclk)
begin
   if rising_edge(aclk) then
      if (bypass_n = '1') then -- DDC mode
         if (fifoout_tready = '1') then 
           sat                             <= fifoout_tuser(104);          
           m_axis_pdti_tuser(64 downto 0)  <= fifoout_tuser(64 downto 0);  
           m_axis_pdti_tuser(72)           <= fifoout_tuser(72);           
           m_axis_pdti_tuser(80)           <= fifoout_tuser(80);           
           m_axis_pdti_tuser(104 downto 88)<= fifoout_tuser(104 downto 88);
         end if;   
         m_axis_pdti_tvalid <= fifoout_tready;
      else -- bypass mode
         sat <= '0';
         m_axis_pdti_tuser(64 downto 0)  <= t1_s_axis_pdti_tuser(64 downto 0);
         m_axis_pdti_tuser(72)           <= t1_s_axis_pdti_tuser(72);
         m_axis_pdti_tuser(80)           <= t1_s_axis_pdti_tuser(80);
         m_axis_pdti_tuser(104 downto 88)<= t1_s_axis_pdti_tuser(104 downto 88);
         m_axis_pdti_tvalid   <= t1_s_axis_pdti_tvalid;
      end if;
   end if;
end process;   

m_axis_pdti_tuser(71 downto 65)   <= "0000000";
m_axis_pdti_tuser(79 downto 73)   <= "0000000";
m_axis_pdti_tuser(87 downto 81)   <= "0000000";
m_axis_pdti_tuser(127 downto 105) <= (others => '0');

gen_1ch_out_data: if (num_chan = 1) generate
gen16ionlyout: if (out_res = 16) generate
process(aclk)
begin
   if rising_edge(aclk) then
      if (bypass_n = '1') then -- DDC mode
         if (fifoout_tready = '1') then 
            m_axis_pdti_tdata  <= fifoout_tdata(15 downto 0); 
         end if;   
      else
         m_axis_pdti_tdata    <= t1_s_axis_pdti_tdata;
      end if;
   end if;
end process;  
end generate gen16ionlyout; 

gen24ionlyout: if (out_res = 24) generate
process(aclk)
begin
   if rising_edge(aclk) then
      if (bypass_n = '1') then -- DDC mode
         if (fifoout_tready = '1') then 
            m_axis_pdti_tdata  <= fifoout_tdata(23 downto 0); 
         end if;   
      else
         if (bypass_in_lower = true) then
            m_axis_pdti_tdata    <= x"00" & t1_s_axis_pdti_tdata;
         else
            m_axis_pdti_tdata    <= t1_s_axis_pdti_tdata & x"00";
         end if;   
      end if;
   end if;
end process; 
end generate gen24ionlyout; 

end generate gen_1ch_out_data;

gen_2ch_out_data: if (num_chan /= 1) generate

gen16iqout: if (out_res = 16) generate
process(aclk)
begin
   if rising_edge(aclk) then
      if (bypass_n = '1') then -- DDC mode
         if (fifoout_tready = '1') then 
            m_axis_pdti_tdata  <= fifoout_tdata(39 downto 24) & fifoout_tdata(15 downto 0); 
         end if;   
      else
         m_axis_pdti_tdata    <= t1_s_axis_pdti_tdata;
      end if;
   end if;
end process;   
end generate gen16iqout; 

gen24iqout: if (out_res = 24) generate
process(aclk)
begin
   if rising_edge(aclk) then
      if (bypass_n = '1') then -- DDC mode
         if (fifoout_tready = '1') then 
            m_axis_pdti_tdata  <= fifoout_tdata(47 downto 0); 
         end if;   
      else -- bypass mode
         if (bypass_in_lower = true) then
            m_axis_pdti_tdata    <= x"00" & t1_s_axis_pdti_tdata(31 downto 16) & x"00" & t1_s_axis_pdti_tdata(15 downto 0);
         else
            m_axis_pdti_tdata    <= t1_s_axis_pdti_tdata(31 downto 16) & x"00" & t1_s_axis_pdti_tdata(15 downto 0) & x"00" ;
         end if;   
      end if;
   end if;
end process;   
end generate gen24iqout;

end generate gen_2ch_out_data;


process(aclk)
begin
   if rising_edge(aclk) then
      if (bypass_n = '1') then -- DDC mode 
         if (fifoout_tready = '1') then 
            p1sat <=  fifoout_tuser(104); 
         end if;
      else
         p1sat <= '0';
      end if;
   end if;
end process;

satxclk_inst : px_axis_intfir32_xclk
  PORT MAP (
    in_clk  => aclk,
    in_sig  => p1sat,
    out_sig => sat_int,
    out_clk => s_axi_csr_aclk
  );

--------------------------------------------------------------------------------
-- Interpolation Counter
--------------------------------------------------------------------------------
-- Used to output data a smooth rate
-- If this Interpolator will be followed by additional interpolation stages
-- the output rate must be set to:
-- total interpolation of following stages -1

process(aclk)
begin
   if rising_edge(aclk) then
        t1_rnd_tuser127 <= rnd_tuser(127);
        t2_rnd_tuser127 <= t1_rnd_tuser127;
--      if ((sync_re = '1') and (sync_en = '1')) or (t1_aresetn = '0') then
--         out_rate_cntr <= x"0000";
--         fifoout_tready <= '0';
         if (out_rate_cntr >= t1_outrate) or (t2_rnd_tuser127 = '1')  then
            out_rate_cntr <= x"0000";
            fifoout_tready <= '1';
         else
            out_rate_cntr <= out_rate_cntr + 1;
            fifoout_tready <= '0';
         end if;
      --end if;
      t1_outrate <= outrate;
   end if;
end process;  

end Behavioral;
