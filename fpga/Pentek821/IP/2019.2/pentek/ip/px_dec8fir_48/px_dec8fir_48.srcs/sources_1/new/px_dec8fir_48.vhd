----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 05/05/2016 01:36:57 PM
-- Design Name: 
-- Module Name: px_dec8fir_48 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 4 or 8 Sample/cycle AXI-S Decimate By 8/4 FIR
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

-- Register Space
-- 0x000 = Reserved
-- 0x004 = Gain Register (Gain Ch A = GAIN_REG[15:0] unsigned) (Gain Ch b = GAIN_REG[31:16] unsigned)
-- 0x008 = Control Register 
--    [0] = Reserved
--    [1] = Reserved
-- 0x00C = Coefficient Load Register
--    [0] = COEF LOAD  -- Toggle to load coefficients into the Filter
--    [1] = Load State Machine Reset
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
use IEEE.NUMERIC_STD.ALL;
library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_dec8fir_48 is
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
   
   -- DES Mode m_axis_pdti_data = CH0(7) Q, CH0(7) I, CH0(6) Q, CH0(6) I, CH0(5) Q, CH0(5) I, CH0(4) Q, CH0(4) I, CH0(3) Q, CH0(3) I, CH0(2) Q, CH0(2) I, CH0(1) Q, CH0(1) I, CH0(0) Q, CH0(0) I
   -- Non-DES Mode m_axis_pdti_data = CH1(3) Q, CH1(3) I, CH1(2) Q, CH1(2) I, CH1(1) Q, CH1(1) I, CH1(0) Q, CH1(0) I, CH0(3) Q, CH0(3) I, CH0(2) Q, CH0(2) I, CH0(1) Q, CH0(1) I, CH0(0) Q, CH0(0) I
   s_axis_pdti_tdata  : in  std_logic_vector(255 downto 0); 
   s_axis_pdti_tuser  : in  std_logic_vector(127 downto 0); -- IQ, 16-bit, 4 or 8 sample/cycle  
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
   
   -- DES Mode m_axis_pdti_data = (Copy CH0 Q, CH0 I), CH0 Q, CH0 I
   -- Non-DES Mode m_axis_pdti_data = CH1 Q, CH1 I, CH0 Q, CH0 I
   m_axis_pdti_tdata  : out std_logic_vector(63 downto 0);  
   m_axis_pdti_tuser  : out std_logic_vector(127 downto 0); -- IQ, 16-bit, 1 sample/cycle
   m_axis_pdti_tvalid : out std_logic;
   
   des_ctl            : in  std_logic;    -- DES = '1' = 1 chan 8 samples/cycle, '0' = 2 chan 4 samples/cycle input  
   
   sat_a              : out std_logic;
   sat_b              : out std_logic  
);
end px_dec8fir_48;


architecture Behavioral of px_dec8fir_48 is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------
-- Decimating FIR Dec=4 4 parallel input samples
-- Reloadable coefficients
COMPONENT fir_dec4_4i1o_a
  PORT (
    aresetn : IN STD_LOGIC;
    aclk : IN STD_LOGIC;
    s_axis_data_tvalid : IN STD_LOGIC;
    s_axis_data_tready : OUT STD_LOGIC;
    s_axis_data_tuser : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    s_axis_data_tdata : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    s_axis_config_tvalid : IN STD_LOGIC;
    s_axis_config_tready : OUT STD_LOGIC;
    s_axis_config_tdata : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    s_axis_reload_tvalid : IN STD_LOGIC;
    s_axis_reload_tready : OUT STD_LOGIC;
    s_axis_reload_tlast : IN STD_LOGIC;
    s_axis_reload_tdata : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tuser : OUT STD_LOGIC_VECTOR(128 DOWNTO 0);
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    event_s_reload_tlast_missing : OUT STD_LOGIC;
    event_s_reload_tlast_unexpected : OUT STD_LOGIC
  );
END COMPONENT;

COMPONENT fir_dec4_4i1o_anu
  PORT (
    aresetn : IN STD_LOGIC;
    aclk : IN STD_LOGIC;
    s_axis_data_tvalid : IN STD_LOGIC;
    s_axis_data_tready : OUT STD_LOGIC;
    s_axis_data_tdata : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    s_axis_config_tvalid : IN STD_LOGIC;
    s_axis_config_tready : OUT STD_LOGIC;
    s_axis_config_tdata : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    s_axis_reload_tvalid : IN STD_LOGIC;
    s_axis_reload_tready : OUT STD_LOGIC;
    s_axis_reload_tlast : IN STD_LOGIC;
    s_axis_reload_tdata : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tuser : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    event_s_reload_tlast_missing : OUT STD_LOGIC;
    event_s_reload_tlast_unexpected : OUT STD_LOGIC
  );
END COMPONENT;

COMPONENT fir_dec4_4i1o_bnu
  PORT (
    aresetn : IN STD_LOGIC;
    aclk : IN STD_LOGIC;
    s_axis_data_tvalid : IN STD_LOGIC;
    s_axis_data_tready : OUT STD_LOGIC;
    s_axis_data_tdata : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    s_axis_config_tvalid : IN STD_LOGIC;
    s_axis_config_tready : OUT STD_LOGIC;
    s_axis_config_tdata : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    s_axis_reload_tvalid : IN STD_LOGIC;
    s_axis_reload_tready : OUT STD_LOGIC;
    s_axis_reload_tlast : IN STD_LOGIC;
    s_axis_reload_tdata : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tuser : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    event_s_reload_tlast_missing : OUT STD_LOGIC;
    event_s_reload_tlast_unexpected : OUT STD_LOGIC
  );
END COMPONENT;

-- Sum
-- DSP48
-- Latency = 2
COMPONENT px_dec8fir_48_dspsum
  PORT (
    A : IN STD_LOGIC_VECTOR(26 DOWNTO 0);
    D : IN STD_LOGIC_VECTOR(26 DOWNTO 0);
    CLK : IN STD_LOGIC;
    P : OUT STD_LOGIC_VECTOR(26 DOWNTO 0)
  );
END COMPONENT;

-- Multiplier
-- DSP48
-- latency = 4
COMPONENT px_dec8fir_48_mult
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
COMPONENT px_dec8fir_48_csr
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

-- Symmetrical Round 33 to 16 bits
COMPONENT px_dec8fir_48_rnd16
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
COMPONENT px_dec8fir_48_sat
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

-- BRAM Dual Port
-- async clock
COMPONENT px_dec8fir_48_mem
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

-- AXI Crossbar
-- Port 0 0x0000
-- Port 1 0x1000
COMPONENT px_dec8fir_48_axi_xbar
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

COMPONENT px_dec8fir_48_dlyr
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

-- fixed delay = 18
COMPONENT px_dec8fir_48_tuserdly
  PORT (
    D : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    CLK : IN STD_LOGIC;
    CE : IN STD_LOGIC;
    Q : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
  );
END COMPONENT;

-- delay = 8
COMPONENT px_dec8fir_48_tuserdly2
  PORT (
    D : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    CLK : IN STD_LOGIC;
    Q : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
  );
END COMPONENT;

-- AXI_Lite Block RAM Controller
COMPONENT px_dec8fir_48_brctlr
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

-- AXI-S FIFO
-- Packet FIFO
-- 512 deep
-- 32 wide
COMPONENT px_dec8fir_ld_fifo
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

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------
type state_type is (
RESET_STATE,
FIRAI_SELECT_STATE,
START_LOAD_AI_STATE,
LOADING_AI_STATE,
FIRAQ_SELECT_STATE,
START_LOAD_AQ_STATE,
LOADING_AQ_STATE,
FIRBI_SELECT_STATE,
START_LOAD_BI_STATE,
LOADING_BI_STATE,
FIRBQ_SELECT_STATE,
START_LOAD_BQ_STATE,
LOADING_BQ_STATE,
FINISHED_STATE
);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal axis_ai_pdti_tdata   : std_logic_vector(63 downto 0) := (others => '0');
signal axis_bi_pdti_tdata   : std_logic_vector(63 downto 0) := (others => '0');
signal axis_aq_pdti_tdata   : std_logic_vector(63 downto 0) := (others => '0');
signal axis_bq_pdti_tdata   : std_logic_vector(63 downto 0) := (others => '0');
signal axis_firai_tvalid    : std_logic := '0';  
signal t1_axis_firai_tvalid : std_logic := '0'; 
signal t2_axis_firai_tvalid : std_logic := '0'; 
signal t3_axis_firai_tvalid : std_logic := '0'; 
signal t4_axis_firai_tvalid : std_logic := '0'; 
signal axis_firai_tuser     : std_logic_vector(128 downto 0) := (others => '0');  
signal axis_firai_tdata     : std_logic_vector(31 downto 0) := (others => '0');    
signal axis_firaq_tdata     : std_logic_vector(31 downto 0) := (others => '0');
signal axis_firbi_tdata     : std_logic_vector(31 downto 0) := (others => '0');
signal axis_firbq_tdata     : std_logic_vector(31 downto 0) := (others => '0'); 
signal t1_axis_firai_tdata  : std_logic_vector(26 downto 0) := (others => '0');    
signal t1_axis_firaq_tdata  : std_logic_vector(26 downto 0) := (others => '0');
signal t1_axis_firbi_tdata  : std_logic_vector(26 downto 0) := (others => '0');
signal t1_axis_firbq_tdata  : std_logic_vector(26 downto 0) := (others => '0');  
signal t2_axis_firai_tdata  : std_logic_vector(26 downto 0) := (others => '0');    
signal t2_axis_firaq_tdata  : std_logic_vector(26 downto 0) := (others => '0');
signal t2_axis_firbi_tdata  : std_logic_vector(26 downto 0) := (others => '0');
signal t2_axis_firbq_tdata  : std_logic_vector(26 downto 0) := (others => '0');  
signal t3_axis_firai_tdata  : std_logic_vector(26 downto 0) := (others => '0');    
signal t3_axis_firaq_tdata  : std_logic_vector(26 downto 0) := (others => '0');
signal t3_axis_firbi_tdata  : std_logic_vector(26 downto 0) := (others => '0');
signal t3_axis_firbq_tdata  : std_logic_vector(26 downto 0) := (others => '0');  
signal t4_axis_firai_tdata  : std_logic_vector(26 downto 0) := (others => '0');    
signal t4_axis_firaq_tdata  : std_logic_vector(26 downto 0) := (others => '0');
signal t4_axis_firbi_tdata  : std_logic_vector(26 downto 0) := (others => '0');
signal t4_axis_firbq_tdata  : std_logic_vector(26 downto 0) := (others => '0');             
signal s_axis_config_tdata  : std_logic_vector(7 downto 0) := (others => '0');  
signal s_axis_config_tvalid : std_logic := '0';  
signal t1_des_ctl           : std_logic := '0';  
signal sum_abi_tdata        : std_logic_vector(26 downto 0) := (others => '0'); 
signal sum_abq_tdata        : std_logic_vector(26 downto 0) := (others => '0');
signal multdvaldly          : std_logic_vector(3 downto 0) := (others => '0'); 
signal t1_mode_mux_tuser    : std_logic_vector(127 downto 0) := (others => '0');
signal t2_mode_mux_tuser    : std_logic_vector(127 downto 0) := (others => '0');
signal t3_mode_mux_tuser    : std_logic_vector(127 downto 0) := (others => '0');
signal t4_mode_mux_tuser    : std_logic_vector(127 downto 0) := (others => '0');
signal mode_mux_ai_tdata    : std_logic_vector(26 downto 0) := (others => '0'); 
signal mode_mux_aq_tdata    : std_logic_vector(26 downto 0) := (others => '0'); 
signal mode_mux_bi_tdata    : std_logic_vector(26 downto 0) := (others => '0'); 
signal mode_mux_bq_tdata    : std_logic_vector(26 downto 0) := (others => '0'); 
signal mode_mux_gain_a      : std_logic_vector(15 downto 0) := (others => '0');  
signal mode_mux_gain_b      : std_logic_vector(15 downto 0) := (others => '0'); 
signal gain_a               : std_logic_vector(15 downto 0) := (others => '0');  
signal gain_b               : std_logic_vector(15 downto 0) := (others => '0'); 
signal mode_mux_tuser       : std_logic_vector(127 downto 0) := (others => '0');
signal mode_mux_tvalid      : std_logic := '0'; 
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
signal reload_ai_tvalid      : std_logic := '0'; 
signal reload_ai_tready      : std_logic := '0'; 
signal reload_ai_tlast       : std_logic := '0'; 
signal reload_ai_tdata       : std_logic_vector(31 downto 0) := (others => '0');   
signal reload_bi_tlast       : std_logic := '0'; 
signal reload_bi_tdata       : std_logic_vector(31 downto 0) := (others => '0');    
signal reload_aq_tlast       : std_logic := '0'; 
signal reload_aq_tdata       : std_logic_vector(31 downto 0) := (others => '0');    
signal reload_bq_tlast       : std_logic := '0'; 
signal reload_bq_tdata       : std_logic_vector(31 downto 0) := (others => '0');       
signal reload_bi_tvalid      : std_logic := '0'; 
signal reload_bi_tready      : std_logic := '0'; 
signal reload_aq_tvalid      : std_logic := '0'; 
signal reload_aq_tready      : std_logic := '0'; 
signal reload_bq_tvalid      : std_logic := '0'; 
signal reload_bq_tready      : std_logic := '0'; 
signal reload_ai_tvalidx     : std_logic := '0'; 
signal reload_ai_treadyx     : std_logic := '0'; 
signal reload_aq_tvalidx     : std_logic := '0'; 
signal reload_aq_treadyx     : std_logic := '0'; 
signal reload_bi_tvalidx     : std_logic := '0'; 
signal reload_bi_treadyx     : std_logic := '0'; 
signal reload_bq_tvalidx     : std_logic := '0'; 
signal reload_bq_treadyx     : std_logic := '0'; 
signal tuser_dly1            : std_logic_vector(127 downto 0) := (others => '0');
signal tuser_dly             : std_logic_vector(127 downto 0) := (others => '0');
signal ai_gain_out           : std_logic_vector(42 downto 0) := (others => '0');
signal aq_gain_out           : std_logic_vector(42 downto 0) := (others => '0');
signal bi_gain_out           : std_logic_vector(42 downto 0) := (others => '0');
signal bq_gain_out           : std_logic_vector(42 downto 0) := (others => '0');
signal ai_sat_out            : std_logic_vector(32 downto 0) := (others => '0');
signal aq_sat_out            : std_logic_vector(32 downto 0) := (others => '0');
signal bi_sat_out            : std_logic_vector(32 downto 0) := (others => '0');
signal bq_sat_out            : std_logic_vector(32 downto 0) := (others => '0');
signal sat_tuser             : std_logic_vector(127 downto 0) := (others => '0');
signal rnd_tuser             : std_logic_vector(127 downto 0) := (others => '0');
signal sat_tvalid            : std_logic := '0'; 
signal rnd_tvalid            : std_logic := '0'; 
signal sat_ai                : std_logic := '0'; 
signal sat_aq                : std_logic := '0'; 
signal sat_bi                : std_logic := '0'; 
signal sat_bq                : std_logic := '0'; 
signal satx_tuser            : std_logic_vector(127 downto 0) := (others => '0');
signal ai_rnd_out            : std_logic_vector(15 downto 0) := (others => '0');
signal aq_rnd_out            : std_logic_vector(15 downto 0) := (others => '0');
signal bi_rnd_out            : std_logic_vector(15 downto 0) := (others => '0');
signal bq_rnd_out            : std_logic_vector(15 downto 0) := (others => '0');
signal p1sata                : std_logic := '0'; 
signal p1satb                : std_logic := '0'; 
signal sat_inta              : std_logic := '0'; 
signal sat_intb              : std_logic := '0'; 
signal bram_we               : std_logic_vector(3 downto 0) := (others => '0');
signal bram_addr             : std_logic_vector(9 downto 0) := (others => '0');
signal bram_wrdata           : std_logic_vector(31 downto 0) := (others => '0');
signal bram_rddata           : std_logic_vector(31 downto 0) := (others => '0');
signal ld_addr               : std_logic_vector(8 downto 0)  := (others => '0');
signal bram_coef             : std_logic_vector(31 downto 0) := (others => '0');
signal ctl1_out              : std_logic_vector(31 downto 0) := (others => '0');
signal ctl3_out              : std_logic_vector(31 downto 0) := (others => '0');
signal stat0_in              : std_logic_vector(31 downto 0) := (others => '0');
signal t1_ctl3_out           : std_logic := '0';
signal ld_coef               : std_logic := '0';
signal ld_active             : std_logic := '0';
signal ld_done               : std_logic := '0';
signal state                 : state_type := RESET_STATE;
signal ldr_ai_fifo_tvalid    : std_logic := '0';
signal ldr_aq_fifo_tvalid    : std_logic := '0';
signal ldr_bi_fifo_tvalid    : std_logic := '0';
signal ldr_bq_fifo_tvalid    : std_logic := '0';
signal ldr_ai_fifo_tlast     : std_logic := '0';
signal ldr_aq_fifo_tlast     : std_logic := '0';
signal ldr_bi_fifo_tlast     : std_logic := '0';
signal ldr_bq_fifo_tlast     : std_logic := '0';
signal t1_ldr_ai_fifo_tvalid    : std_logic := '0';
signal t1_ldr_aq_fifo_tvalid    : std_logic := '0';
signal t1_ldr_bi_fifo_tvalid    : std_logic := '0';
signal t1_ldr_bq_fifo_tvalid    : std_logic := '0';
signal t1_ldr_ai_fifo_tlast     : std_logic := '0';
signal t1_ldr_aq_fifo_tlast     : std_logic := '0';
signal t1_ldr_bi_fifo_tlast     : std_logic := '0';
signal t1_ldr_bq_fifo_tlast     : std_logic := '0';
signal t2_ldr_ai_fifo_tvalid    : std_logic := '0';
signal t2_ldr_aq_fifo_tvalid    : std_logic := '0';
signal t2_ldr_bi_fifo_tvalid    : std_logic := '0';
signal t2_ldr_bq_fifo_tvalid    : std_logic := '0';
signal t2_ldr_ai_fifo_tlast     : std_logic := '0';
signal t2_ldr_aq_fifo_tlast     : std_logic := '0';
signal t2_ldr_bi_fifo_tlast     : std_logic := '0';
signal t2_ldr_bq_fifo_tlast     : std_logic := '0';
signal ld_coef_addr_cntr        : std_logic := '0';
signal coef_addr_cntr           : std_logic_vector(7 downto 0) := (others => '0');
signal fir_sel                  : std_logic := '0';
signal t1_fir_sel               : std_logic := '0';
signal t2_fir_sel               : std_logic := '0';
signal x_bram_coef              : std_logic_vector(31 downto 0) := (others => '0');
signal reload_ai_tlast_missing  : std_logic := '0';
signal reload_aq_tlast_missing  : std_logic := '0';
signal reload_bi_tlast_missing  : std_logic := '0';
signal reload_bq_tlast_missing  : std_logic := '0';
signal reload_ai_tlast_unexpected: std_logic := '0';
signal reload_aq_tlast_unexpected: std_logic := '0';
signal reload_bi_tlast_unexpected: std_logic := '0';
signal reload_bq_tlast_unexpected: std_logic := '0';
signal x_reload_failed          : std_logic := '0';
signal reload_failed            : std_logic := '0';
signal t1_ld_done               : std_logic := '0';
signal t2_ld_done               : std_logic := '0';
signal t3_ld_done               : std_logic := '0';
signal t4_ld_done               : std_logic := '0';
signal t5_ld_done               : std_logic := '0';
signal t6_ld_done               : std_logic := '0';
signal t7_ld_done               : std_logic := '0';
signal load_finished            : std_logic := '0';
signal load_finishedx           : std_logic := '0';
signal t1_aresetn               : std_logic := '0';
signal t2_aresetn               : std_logic := '0';
signal fir_rst_n                : std_logic := '0';
signal cfifo_rstn               : std_logic := '0';
signal src_sendc                : std_logic := '0';
signal src_rcvc                 : std_logic := '0';
signal dest_reqc                : std_logic := '0';
signal ctl_rs                   : std_logic_vector(31 downto 0) := (others => '0');
signal t1_s_axi_csr_aresetn     : std_logic := '0';

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

--------------------------------------------------------------------------------

begin

axis_ai_pdti_tdata <= s_axis_pdti_tdata(111 downto 96) & s_axis_pdti_tdata(79 downto 64) & s_axis_pdti_tdata(47 downto 32) & s_axis_pdti_tdata(15 downto 0);
axis_bi_pdti_tdata <= s_axis_pdti_tdata(239 downto 224) & s_axis_pdti_tdata(207 downto 192) & s_axis_pdti_tdata(175 downto 160) & s_axis_pdti_tdata(143 downto 128);
axis_aq_pdti_tdata <= s_axis_pdti_tdata(127 downto 112) & s_axis_pdti_tdata(95 downto 80) & s_axis_pdti_tdata(63 downto 48) & s_axis_pdti_tdata(31 downto 16);
axis_bq_pdti_tdata <= s_axis_pdti_tdata(255 downto 240) & s_axis_pdti_tdata(223 downto 208) & s_axis_pdti_tdata(191 downto 176) & s_axis_pdti_tdata(159 downto 144);

fir_ai : fir_dec4_4i1o_a
port map (
    aresetn => fir_rst_n,
    aclk                => aclk,
    s_axis_data_tvalid  => s_axis_pdti_tvalid,
    s_axis_data_tready  => open,
    s_axis_data_tuser   => s_axis_pdti_tuser,
    s_axis_data_tdata   => axis_ai_pdti_tdata,
    s_axis_config_tvalid=> s_axis_config_tvalid,
    s_axis_config_tready=> open,
    s_axis_config_tdata => s_axis_config_tdata,
    s_axis_reload_tvalid=> reload_ai_tvalid,
    s_axis_reload_tready=> reload_ai_tready,
    s_axis_reload_tlast => reload_ai_tlast,
    s_axis_reload_tdata => reload_ai_tdata(23 downto 0),
    m_axis_data_tvalid  => axis_firai_tvalid,
    m_axis_data_tuser   => axis_firai_tuser,
    m_axis_data_tdata   => axis_firai_tdata,
    event_s_reload_tlast_missing => reload_ai_tlast_missing,
    event_s_reload_tlast_unexpected => reload_ai_tlast_unexpected
  );

fir_bi : fir_dec4_4i1o_bnu
port map (
    aresetn => fir_rst_n,
    aclk                => aclk,
    s_axis_data_tvalid  => s_axis_pdti_tvalid,
    s_axis_data_tready  => open,
    s_axis_data_tdata   => axis_bi_pdti_tdata,
    s_axis_config_tvalid=> s_axis_config_tvalid,
    s_axis_config_tready=> open,
    s_axis_config_tdata => s_axis_config_tdata,
    s_axis_reload_tvalid=> reload_bi_tvalid, 
    s_axis_reload_tready=> reload_bi_tready, 
    s_axis_reload_tlast => reload_bi_tlast,  
    s_axis_reload_tdata => reload_bi_tdata(23 downto 0),  
    m_axis_data_tvalid  => open,
    m_axis_data_tuser   => open, 
    m_axis_data_tdata   => axis_firbi_tdata,
    event_s_reload_tlast_missing => reload_aq_tlast_missing,
    event_s_reload_tlast_unexpected => reload_aq_tlast_unexpected
  );
  
fir_aq : fir_dec4_4i1o_anu
port map (
    aresetn => fir_rst_n,
    aclk                => aclk,
    s_axis_data_tvalid  => s_axis_pdti_tvalid,
    s_axis_data_tready  => open,
    s_axis_data_tdata   => axis_aq_pdti_tdata,
    s_axis_config_tvalid=> s_axis_config_tvalid,
    s_axis_config_tready=> open,
    s_axis_config_tdata => s_axis_config_tdata,
    s_axis_reload_tvalid=> reload_aq_tvalid, 
    s_axis_reload_tready=> reload_aq_tready, 
    s_axis_reload_tlast => reload_aq_tlast,  
    s_axis_reload_tdata => reload_aq_tdata(23 downto 0),  
    m_axis_data_tvalid  => open,
    m_axis_data_tuser   => open, 
    m_axis_data_tdata   => axis_firaq_tdata,
    event_s_reload_tlast_missing => reload_bi_tlast_missing,
    event_s_reload_tlast_unexpected => reload_bi_tlast_unexpected
  );

fir_bq : fir_dec4_4i1o_bnu
port map (
    aresetn => fir_rst_n,
    aclk                => aclk,
    s_axis_data_tvalid  => s_axis_pdti_tvalid,
    s_axis_data_tready  => open,
    s_axis_data_tdata   => axis_bq_pdti_tdata,
    s_axis_config_tvalid=> s_axis_config_tvalid,
    s_axis_config_tready=> open,
    s_axis_config_tdata => s_axis_config_tdata,
    s_axis_reload_tvalid=> reload_bq_tvalid, 
    s_axis_reload_tready=> reload_bq_tready, 
    s_axis_reload_tlast => reload_bq_tlast,  
    s_axis_reload_tdata => reload_bq_tdata(23 downto 0),  
    m_axis_data_tvalid  => open,
    m_axis_data_tuser   => open, 
    m_axis_data_tdata   => axis_firbq_tdata,
    event_s_reload_tlast_missing => reload_bq_tlast_missing,
    event_s_reload_tlast_unexpected => reload_bq_tlast_unexpected
     );


process(aclk)
begin
    if rising_edge(aclk) then
      x_reload_failed <= reload_ai_tlast_missing or reload_aq_tlast_missing or reload_bi_tlast_missing or reload_bq_tlast_missing or 
      reload_ai_tlast_unexpected or reload_aq_tlast_unexpected or reload_bi_tlast_unexpected or reload_bq_tlast_unexpected;
      
      s_axis_config_tdata   <= "0000000" & t1_des_ctl;
      s_axis_config_tvalid  <= not s_axis_config_tvalid;
    end if;
end process;   

-- delay = 18
tuserdly_inst : px_dec8fir_48_tuserdly
  PORT MAP (
    D   => axis_firai_tuser(128 downto 1),
    CLK => aclk,
    CE  => axis_firai_tvalid,
    Q   => tuser_dly1
  );

-- delay 8  
tuserdly2_inst : px_dec8fir_48_tuserdly2
    PORT MAP (
      D   => tuser_dly1,
      CLK => aclk,
      Q   => tuser_dly
    );  
    
t4_mode_mux_tuser <= tuser_dly;    

--------------------------------------------------------------------------------
-- Des/Non-Des Mode 
-- Des Mode: sum two filter outputs
-- Non-Des Mode: Treat two filter outputs as sepaerate channels
--------------------------------------------------------------------------------
-- latency = 4
sum_i_inst : px_dec8fir_48_dspsum
  PORT MAP (
    A => axis_firai_tdata(26 downto 0),
    D => axis_firbi_tdata(26 downto 0),
    CLK => aclk,
    P => sum_abi_tdata
  );
  
sum_q_inst : px_dec8fir_48_dspsum
  PORT MAP (
    A => axis_firaq_tdata(26 downto 0),
    D => axis_firbq_tdata(26 downto 0),
    CLK => aclk,
    P => sum_abq_tdata
  );

-- Select 2 Chan Decimate by 4 or 1 Chan decimate by 8
process(aclk)
begin
    if rising_edge(aclk) then
        t1_des_ctl <= des_ctl;
        t1_axis_firai_tvalid <= axis_firai_tvalid;
        t2_axis_firai_tvalid <= t1_axis_firai_tvalid;
        t3_axis_firai_tvalid <= t2_axis_firai_tvalid;
        t4_axis_firai_tvalid <= t3_axis_firai_tvalid;
        t1_axis_firai_tdata <= axis_firai_tdata(26 downto 0);
        t1_axis_firaq_tdata <= axis_firaq_tdata(26 downto 0);
        t1_axis_firbi_tdata <= axis_firbi_tdata(26 downto 0);
        t1_axis_firbq_tdata <= axis_firbq_tdata(26 downto 0);
        t2_axis_firai_tdata <= t1_axis_firai_tdata;
        t2_axis_firaq_tdata <= t1_axis_firaq_tdata;
        t2_axis_firbi_tdata <= t1_axis_firbi_tdata;
        t2_axis_firbq_tdata <= t1_axis_firbq_tdata;
        t3_axis_firai_tdata <= t2_axis_firai_tdata;
        t3_axis_firaq_tdata <= t2_axis_firaq_tdata;
        t3_axis_firbi_tdata <= t2_axis_firbi_tdata;
        t3_axis_firbq_tdata <= t2_axis_firbq_tdata;
        t4_axis_firai_tdata <= t3_axis_firai_tdata;
        t4_axis_firaq_tdata <= t3_axis_firaq_tdata;
        t4_axis_firbi_tdata <= t3_axis_firbi_tdata;
        t4_axis_firbq_tdata <= t3_axis_firbq_tdata;
        if t1_des_ctl = '1' then
            -- DES mode -- use two copies of channel 
            mode_mux_ai_tdata <= sum_abi_tdata;
            mode_mux_aq_tdata <= sum_abq_tdata;
            mode_mux_bi_tdata <= sum_abi_tdata; 
            mode_mux_bq_tdata <= sum_abq_tdata;
            mode_mux_gain_a   <= gain_a;
            mode_mux_gain_b   <= gain_a;
        else
            -- Non-DES mode -- use 2 channels
            mode_mux_ai_tdata <= t4_axis_firai_tdata;
            mode_mux_aq_tdata <= t4_axis_firaq_tdata;
            mode_mux_bi_tdata <= t4_axis_firbi_tdata;
            mode_mux_bq_tdata <= t4_axis_firbq_tdata;
            mode_mux_gain_a   <= gain_a;
            mode_mux_gain_b   <= gain_b;
        end if;
        mode_mux_tvalid <= t4_axis_firai_tvalid;
    end if;
end process;
  
--------------------------------------------------------------------------------
-- Filter Output Gain
--------------------------------------------------------------------------------
-- latency = 4
gain_ai_inst : px_dec8fir_48_mult
port map (
    CLK => aclk,
    A   => mode_mux_ai_tdata,
    B   => mode_mux_gain_a,
    P   => ai_gain_out
);

gain_aq_inst : px_dec8fir_48_mult
port map (
    CLK => aclk,
    A   => mode_mux_aq_tdata,
    B   => mode_mux_gain_a,
    P   => aq_gain_out
);

gain_bi_inst : px_dec8fir_48_mult
port map (
    CLK => aclk,
    A   => mode_mux_bi_tdata,
    B   => mode_mux_gain_b,
    P   => bi_gain_out
);

gain_bq_inst : px_dec8fir_48_mult
port map (
    CLK => aclk,
    A   => mode_mux_bq_tdata,
    B   => mode_mux_gain_b,
    P   => bq_gain_out
);

-- Compensate for Multiplier latency = 4
process(aclk)
begin
   if rising_edge(aclk) then
      multdvaldly <= multdvaldly(2 downto 0) & mode_mux_tvalid;
   end if;   
end process;   

--------------------------------------------------------------------------------
-- Filter Output Saturation and Rounding
--------------------------------------------------------------------------------

ai_sat_inst: px_dec8fir_48_sat
port map (
  axis_aclk      => aclk,
  axis_aresetn   => '1',
  s_axis_tdata   => ai_gain_out,
  s_axis_tuser   => t4_mode_mux_tuser(127 downto 0),
  s_axis_tvalid  => multdvaldly(3),
  m_axis_tdata   => ai_sat_out,
  m_axis_tuser   => sat_tuser,
  m_axis_tvalid  => sat_tvalid,
  sat_out        => sat_ai
);

aq_sat_inst: px_dec8fir_48_sat
port map (
  axis_aclk      => aclk,
  axis_aresetn   => '1',
  s_axis_tdata   => aq_gain_out,
  s_axis_tuser   => x"00000000000000000000000000000000",
  s_axis_tvalid  => multdvaldly(3), 
  m_axis_tdata   => aq_sat_out,
  m_axis_tuser   => open,
  m_axis_tvalid  => open,
  sat_out        => sat_aq
);    

bi_sat_inst: px_dec8fir_48_sat
port map (
  axis_aclk      => aclk,
  axis_aresetn   => '1',
  s_axis_tdata   => bi_gain_out,
  s_axis_tuser   => x"00000000000000000000000000000000",
  s_axis_tvalid  => multdvaldly(3), 
  m_axis_tdata   => bi_sat_out,
  m_axis_tuser   => open,
  m_axis_tvalid  => open,
  sat_out        => sat_bi
);      

bq_sat_inst: px_dec8fir_48_sat
port map (
  axis_aclk      => aclk,
  axis_aresetn   => '1',
  s_axis_tdata   => bq_gain_out,
  s_axis_tuser   => x"00000000000000000000000000000000",
  s_axis_tvalid  => multdvaldly(3), 
  m_axis_tdata   => bq_sat_out,
  m_axis_tuser   => open,
  m_axis_tvalid  => open,
  sat_out        => sat_bq
);            


satx_tuser <= sat_tuser(127 downto 106) & (sat_bi or sat_bq) & (sat_ai or sat_aq) & sat_tuser(103 downto 0);

-- Round Data down to 16 bits for Cascade
round_gen_ai16: px_dec8fir_48_rnd16
port map (
   axis_aclk     => aclk,
   axis_aresetn  => '1',
   s_axis_tdata  => ai_sat_out,
   s_axis_tuser  => satx_tuser,
   s_axis_tvalid => sat_tvalid, 
   m_axis_tdata  => ai_rnd_out,
   m_axis_tuser  => rnd_tuser,
   m_axis_tvalid => rnd_tvalid
);
round_gen_aq16: px_dec8fir_48_rnd16
port map (
   axis_aclk     => aclk,
   axis_aresetn  => '1',
   s_axis_tdata  => aq_sat_out,
   s_axis_tuser  => x"00000000000000000000000000000000",
   s_axis_tvalid => sat_tvalid,
   m_axis_tdata  => aq_rnd_out,
   m_axis_tuser   => open,
   m_axis_tvalid => open
);

round_gen_bi16: px_dec8fir_48_rnd16
port map (
   axis_aclk     => aclk,
   axis_aresetn  => '1',
   s_axis_tdata  => bi_sat_out,
   s_axis_tuser  => x"00000000000000000000000000000000",
   s_axis_tvalid => sat_tvalid, 
   m_axis_tdata  => bi_rnd_out,
   m_axis_tuser  => open,
   m_axis_tvalid => open
);
round_gen_bq16: px_dec8fir_48_rnd16
port map (
   axis_aclk     => aclk,
   axis_aresetn  => '1',
   s_axis_tdata  => bq_sat_out,
   s_axis_tuser  => x"00000000000000000000000000000000",
   s_axis_tvalid => sat_tvalid, 
   m_axis_tdata  => bq_rnd_out,
   m_axis_tuser   => open,
   m_axis_tvalid => open
);

--------------------------------------------------------------------------------
-- Output
--------------------------------------------------------------------------------

process(aclk)
begin
   if rising_edge(aclk) then
     if (rnd_tvalid = '1') then
        if t1_des_ctl = '1' then
           sat_a                           <= rnd_tuser(104) or rnd_tuser(105);
           sat_b                           <= '0';
        else
           sat_a                           <= rnd_tuser(104);
           sat_b                           <= rnd_tuser(105);
        end if;   
        m_axis_pdti_tuser(64 downto 0)  <= rnd_tuser(64 downto 0);  
        m_axis_pdti_tuser(72)           <= rnd_tuser(72);           
        m_axis_pdti_tuser(80)           <= rnd_tuser(80);           
        m_axis_pdti_tuser(105 downto 96)<= rnd_tuser(105 downto 96); 
      end if;   
      m_axis_pdti_tvalid <= rnd_tvalid; 
   end if;
end process;   

m_axis_pdti_tuser(71 downto 65)   <= "0000000";
m_axis_pdti_tuser(79 downto 73)   <= "0000000";
m_axis_pdti_tuser(87 downto 81)   <= "0000000";
m_axis_pdti_tuser(91 downto 88)   <= "0001";
m_axis_pdti_tuser(92)             <= '0'; 
m_axis_pdti_tuser(94 downto 93)   <= "01";
m_axis_pdti_tuser(95)             <= '1';
m_axis_pdti_tuser(127 downto 106) <= (others => '0');


process(aclk)
begin
   if rising_edge(aclk) then
      if (rnd_tvalid = '1') then
         m_axis_pdti_tdata  <= bq_rnd_out & bi_rnd_out & aq_rnd_out & ai_rnd_out;   
      end if;   
   end if;
end process;   

process(aclk)
begin
   if rising_edge(aclk) then
      if (rnd_tvalid = '1') then 
         if t1_des_ctl = '1' then
            p1sata <=  rnd_tuser(104) or rnd_tuser(105);
            p1satb <=  '0';
         else
            p1sata <=  rnd_tuser(104);
            p1satb <=  rnd_tuser(105);         
         end if;
      end if;
   end if;
end process;

   
satxclka_inst: xpm_cdc_pulse
generic map (
  -- Common module generics
  DEST_SYNC_FF   => 4, -- integer; range: 2-10
  REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
  RST_USED       => 0, -- integer; 0=no reset, 1=implement reset
  SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
)
port map (
  src_clk    => aclk,
  src_rst    => '0',  -- optional; required when RST_USED = 1
  src_pulse  => p1sata,
  dest_clk   => s_axi_csr_aclk,
  dest_rst   => '0',  -- optional; required when RST_USED = 1
  dest_pulse => sat_inta
);    
   
satxclkb_inst: xpm_cdc_pulse
generic map (
  -- Common module generics
  DEST_SYNC_FF   => 4, -- integer; range: 2-10
  REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
  RST_USED       => 0, -- integer; 0=no reset, 1=implement reset
  SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
)
port map (
  src_clk    => aclk,
  src_rst    => '0',  -- optional; required when RST_USED = 1
  src_pulse  => p1satb,
  dest_clk   => s_axi_csr_aclk,
  dest_rst   => '0',  -- optional; required when RST_USED = 1
  dest_pulse => sat_intb
);  

rldfail_xclk_inst: xpm_cdc_pulse
generic map (
  -- Common module generics
  DEST_SYNC_FF   => 4, -- integer; range: 2-10
  REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
  RST_USED       => 0, -- integer; 0=no reset, 1=implement reset
  SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
)
port map (
  src_clk    => aclk,
  src_rst    => '0',  -- optional; required when RST_USED = 1
  src_pulse  => x_reload_failed,
  dest_clk   => s_axi_csr_aclk,
  dest_rst   => '0',  -- optional; required when RST_USED = 1
  dest_pulse => reload_failed
);      
    
--------------------------------------------------------------------------------
-- AXI Crossbar
--------------------------------------------------------------------------------
  
axi_xbar_inst : px_dec8fir_48_axi_xbar
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

bram_ctlr_inst : px_dec8fir_48_brctlr
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


coef_bram_inst : px_dec8fir_48_mem
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

csr_inst : px_dec8fir_48_csr
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
    reg1_init_val       => x"00000800",
    reg2_init_val       => x"00000000",
    reg3_init_val       => x"00000000",
    ctl0_out            => open,
    ctl1_out            => ctl1_out,
    ctl2_out            => open,
    ctl3_out            => ctl3_out,
    stat0_in            => stat0_in,
    intrpt_src_in(0)    => sat_inta,
    intrpt_src_in(1)    => sat_intb,
    intrpt_src_in(2)    => reload_failed,
    irq                 => irq
  );

  
ctl_xclk:  xpm_cdc_handshake
generic map (
  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 3, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 3, -- integer; range: 2-10
  WIDTH          => 32  -- integer; range: 1-1024
)
port map (
  src_clk    => s_axi_csr_aclk,
  src_in     => ctl1_out,
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
      gain_a    <= ctl_rs(15 downto 0); -- Gain value (unsigned)
      gain_b    <= ctl_rs(31 downto 16); -- Gain value (unsigned)
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

--------------------------------------------------------------------------------  
-- Coefficient Loading State Machine
--------------------------------------------------------------------------------
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if (t1_s_axi_csr_aresetn = '0') or (ld_coef_addr_cntr = '1') then
         coef_addr_cntr <= x"00";
      else
         coef_addr_cntr <= coef_addr_cntr + 1;
      end if;
   end if;      
end process;

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
      cfifo_rstn <= not (ctl3_out(1) or not t1_s_axi_csr_aresetn);
      if t1_s_axi_csr_aresetn = '0' then
         t1_ldr_ai_fifo_tvalid <= '0'; 
         t1_ldr_aq_fifo_tvalid <= '0'; 
         t1_ldr_bi_fifo_tvalid <= '0'; 
         t1_ldr_bq_fifo_tvalid <= '0'; 
         t1_ldr_ai_fifo_tlast  <= '0'; 
         t1_ldr_aq_fifo_tlast  <= '0'; 
         t1_ldr_bi_fifo_tlast  <= '0'; 
         t1_ldr_bq_fifo_tlast  <= '0'; 
         t2_ldr_ai_fifo_tvalid <= '0'; 
         t2_ldr_aq_fifo_tvalid <= '0'; 
         t2_ldr_bi_fifo_tvalid <= '0'; 
         t2_ldr_bq_fifo_tvalid <= '0'; 
         t2_ldr_ai_fifo_tlast  <= '0'; 
         t2_ldr_aq_fifo_tlast  <= '0'; 
         t2_ldr_bi_fifo_tlast  <= '0'; 
         t2_ldr_bq_fifo_tlast  <= '0';       
         t1_fir_sel            <= '0';  
         t2_fir_sel            <= '0';   
      else
         t1_ldr_ai_fifo_tvalid <= ldr_ai_fifo_tvalid; 
         t1_ldr_aq_fifo_tvalid <= ldr_aq_fifo_tvalid; 
         t1_ldr_bi_fifo_tvalid <= ldr_bi_fifo_tvalid; 
         t1_ldr_bq_fifo_tvalid <= ldr_bq_fifo_tvalid; 
         t1_ldr_ai_fifo_tlast  <= ldr_ai_fifo_tlast ; 
         t1_ldr_aq_fifo_tlast  <= ldr_aq_fifo_tlast ; 
         t1_ldr_bi_fifo_tlast  <= ldr_bi_fifo_tlast ; 
         t1_ldr_bq_fifo_tlast  <= ldr_bq_fifo_tlast ; 
         t2_ldr_ai_fifo_tvalid <= t1_ldr_ai_fifo_tvalid; 
         t2_ldr_aq_fifo_tvalid <= t1_ldr_aq_fifo_tvalid; 
         t2_ldr_bi_fifo_tvalid <= t1_ldr_bi_fifo_tvalid; 
         t2_ldr_bq_fifo_tvalid <= t1_ldr_bq_fifo_tvalid; 
         t2_ldr_ai_fifo_tlast  <= t1_ldr_ai_fifo_tlast ; 
         t2_ldr_aq_fifo_tlast  <= t1_ldr_aq_fifo_tlast ; 
         t2_ldr_bi_fifo_tlast  <= t1_ldr_bi_fifo_tlast ; 
         t2_ldr_bq_fifo_tlast  <= t1_ldr_bq_fifo_tlast ; 
         t1_fir_sel            <= fir_sel;
         t2_fir_sel            <= t1_fir_sel; 
      end if;
      if (t1_s_axi_csr_aresetn = '0') or (ctl3_out(1) = '1') then
         state <= reset_state;
         ldr_ai_fifo_tvalid <= '0'; 
         ldr_aq_fifo_tvalid <= '0'; 
         ldr_bi_fifo_tvalid <= '0'; 
         ldr_bq_fifo_tvalid <= '0'; 
         ldr_ai_fifo_tlast  <= '0'; 
         ldr_aq_fifo_tlast  <= '0'; 
         ldr_bi_fifo_tlast  <= '0'; 
         ldr_bq_fifo_tlast  <= '0'; 
         ld_coef_addr_cntr  <= '1'; 
         ld_done            <= '1';
         ld_active          <= '0';
         fir_sel            <= '0';
      else
         case state is 
            when RESET_STATE =>
               ldr_ai_fifo_tvalid <= '0'; 
               ldr_aq_fifo_tvalid <= '0'; 
               ldr_bi_fifo_tvalid <= '0'; 
               ldr_bq_fifo_tvalid <= '0'; 
               ldr_ai_fifo_tlast  <= '0'; 
               ldr_aq_fifo_tlast  <= '0'; 
               ldr_bi_fifo_tlast  <= '0'; 
               ldr_bq_fifo_tlast  <= '0'; 
               if ld_coef = '1' then
                  state <= FIRAI_SELECT_STATE;
                  ld_done    <= '0';
                  ld_active  <= '1';
               else
                  ld_coef_addr_cntr <= '0';
                  state <= RESET_STATE; 
                  ld_done    <= '1';
                  ld_active  <= '0';
               end if;          
            when FIRAI_SELECT_STATE =>
               ld_coef_addr_cntr  <= '1'; 
               ldr_ai_fifo_tvalid <= '1'; 
               ldr_ai_fifo_tlast  <= '0'; 
               fir_sel            <= '1';
               state <= START_LOAD_AI_STATE;
            when START_LOAD_AI_STATE =>
               fir_sel            <= '0';
               ld_coef_addr_cntr  <= '0';
               if (t1_des_ctl = '0') then
                  ld_addr <= "00" & coef_addr_cntr(6 downto 0);
               else
                  ld_addr <= '0' & coef_addr_cntr(6 downto 2) & '0' & coef_addr_cntr(1 downto 0);
               end if;   
               state <= LOADING_AI_STATE;
            when LOADING_AI_STATE =>
               if (t1_des_ctl = '0') then
                  ld_addr <= "00" & coef_addr_cntr(6 downto 0);
               else
                  ld_addr <= '0' & coef_addr_cntr(6 downto 2) & '0' & coef_addr_cntr(1 downto 0);
               end if;   
               if (coef_addr_cntr = x"6e") then
                  ldr_ai_fifo_tlast <= '1'; 
               end if;
               if (coef_addr_cntr = x"6f") then
                  state <= FIRAQ_SELECT_STATE;
                  ldr_ai_fifo_tvalid <= '0'; 
                  ldr_ai_fifo_tlast  <= '0'; 
               end if;
            when FIRAQ_SELECT_STATE =>
               ld_coef_addr_cntr  <= '1'; 
               ldr_aq_fifo_tvalid <= '1'; 
               ldr_aq_fifo_tlast  <= '0'; 
               fir_sel            <= '1';
               state <= START_LOAD_AQ_STATE;
            when START_LOAD_AQ_STATE =>
               fir_sel            <= '0';
               ld_coef_addr_cntr  <= '0';
               if (t1_des_ctl = '0') then
                  ld_addr <= "00" & coef_addr_cntr(6 downto 0);
               else
                  ld_addr <= '0' & coef_addr_cntr(6 downto 2) & '0' & coef_addr_cntr(1 downto 0);
               end if;   
               state <= LOADING_AQ_STATE;
            when LOADING_AQ_STATE =>
               if (t1_des_ctl = '0') then
                  ld_addr <= "00" & coef_addr_cntr(6 downto 0);
               else
                  ld_addr <= '0' & coef_addr_cntr(6 downto 2) & '0' & coef_addr_cntr(1 downto 0);
               end if;   
               if (coef_addr_cntr = x"6e") then
                  ldr_aq_fifo_tlast <= '1'; 
               end if;
               if (coef_addr_cntr = x"6f") then
                  state <= FIRBI_SELECT_STATE;
                  ldr_aq_fifo_tvalid <= '0'; 
                  ldr_aq_fifo_tlast  <= '0'; 
               end if;
           when FIRBI_SELECT_STATE =>
                  ld_coef_addr_cntr  <= '1'; 
                  ldr_bi_fifo_tvalid <= '1'; 
                  ldr_bi_fifo_tlast  <= '0'; 
                  fir_sel            <= '1';
                  state <= START_LOAD_BI_STATE;
            when START_LOAD_BI_STATE =>
                  fir_sel            <= '0';
                  ld_coef_addr_cntr  <= '0';
                  if (t1_des_ctl = '0') then
                     ld_addr <= "00" & coef_addr_cntr(6 downto 0);
                  else
                     ld_addr <= '0' & coef_addr_cntr(6 downto 2) & '1' & coef_addr_cntr(1 downto 0);
                  end if;  
                  state <= LOADING_BI_STATE;
            when LOADING_BI_STATE =>
               if (t1_des_ctl = '0') then
                  ld_addr <= "00" & coef_addr_cntr(6 downto 0);
               else
                  ld_addr <= '0' & coef_addr_cntr(6 downto 2) & '1' & coef_addr_cntr(1 downto 0);
               end if;  
               if (coef_addr_cntr = x"6e") then
                  ldr_bi_fifo_tlast <= '1'; 
               end if;
               if (coef_addr_cntr = x"6f") then
                  state <= FIRBQ_SELECT_STATE;
                  ldr_bi_fifo_tvalid <= '0'; 
                  ldr_bi_fifo_tlast  <= '0'; 
               end if;
            when FIRBQ_SELECT_STATE =>
               ld_coef_addr_cntr  <= '1'; 
               ldr_bq_fifo_tvalid <= '1'; 
               ldr_bq_fifo_tlast  <= '0'; 
               fir_sel            <= '1';
               state <= START_LOAD_BQ_STATE;
            when START_LOAD_BQ_STATE =>
               fir_sel            <= '0';
               ld_coef_addr_cntr  <= '0';
               if (t1_des_ctl = '0') then
                  ld_addr <= "00" & coef_addr_cntr(6 downto 0);
               else
                  ld_addr <= '0' & coef_addr_cntr(6 downto 2) & '1' & coef_addr_cntr(1 downto 0);
               end if;  
               state <= LOADING_BQ_STATE;
            when LOADING_BQ_STATE =>
               if (t1_des_ctl = '0') then
                  ld_addr <= "00" & coef_addr_cntr(6 downto 0);
               else
                  ld_addr <= '0' & coef_addr_cntr(6 downto 2) & '1' & coef_addr_cntr(1 downto 0);
               end if;  
               if (coef_addr_cntr = x"6e") then
                  ldr_bq_fifo_tlast <= '1'; 
               end if;
               if (coef_addr_cntr = x"6f") then
                  state <= FINISHED_STATE;
                  ldr_bq_fifo_tvalid <= '0'; 
                  ldr_bq_fifo_tlast  <= '0'; 
               end if;
            when FINISHED_STATE =>
               if (load_finishedx = '1') then
                  state <= RESET_STATE;
                  ld_done    <= '1';
                  ld_active  <= '0';
               end if;
            when others =>
               state <= RESET_STATE;
         end case;   
      end if;
   end if;
end process;

process(aclk)
begin
   if rising_edge(aclk) then
     t1_ld_done <= load_finished;
     t2_ld_done <= t1_ld_done;
     t3_ld_done <= t2_ld_done;
     t4_ld_done <= t3_ld_done;
     t5_ld_done <= t4_ld_done;
     t6_ld_done <= t5_ld_done;
     t7_ld_done <= t6_ld_done;
     t1_aresetn <= aresetn;
     t2_aresetn <= t1_aresetn;
     fir_rst_n  <= not ((not t2_aresetn) or ((t4_ld_done or t5_ld_done or t6_ld_done) and not t7_ld_done));
     load_finished <= reload_bq_tready and reload_bq_tvalid and reload_bq_tlast;
   end if;
end process;  


x_bram_coef <= bram_coef when (t2_fir_sel='0') else ("0000000000000000000000000000000" & t1_des_ctl);

ai_fifo_inst : px_dec8fir_ld_fifo
  PORT MAP (
    m_aclk        => aclk,
    s_aclk        => s_axi_csr_aclk,
    s_aresetn     => cfifo_rstn,
    s_axis_tvalid => t2_ldr_ai_fifo_tvalid,
    s_axis_tready => open,
    s_axis_tdata  => x_bram_coef,
    s_axis_tlast  => t2_ldr_ai_fifo_tlast,
    m_axis_tvalid => reload_ai_tvalid,
    m_axis_tready => reload_ai_tready,
    m_axis_tdata  => reload_ai_tdata,
    m_axis_tlast  => reload_ai_tlast
  );

  
aq_fifo_inst : px_dec8fir_ld_fifo
    PORT MAP (
      m_aclk        => aclk,
      s_aclk        => s_axi_csr_aclk,
      s_aresetn     => cfifo_rstn,
      s_axis_tvalid => t2_ldr_aq_fifo_tvalid,
      s_axis_tready => open,
      s_axis_tdata  => x_bram_coef,
      s_axis_tlast  => t2_ldr_aq_fifo_tlast,
      m_axis_tvalid => reload_aq_tvalid,
      m_axis_tready => reload_aq_tready,
      m_axis_tdata  => reload_aq_tdata,
      m_axis_tlast  => reload_aq_tlast
    );


bi_fifo_inst : px_dec8fir_ld_fifo
  PORT MAP (
    m_aclk        => aclk,
    s_aclk        => s_axi_csr_aclk,
    s_aresetn     => cfifo_rstn,
    s_axis_tvalid => t2_ldr_bi_fifo_tvalid,
    s_axis_tready => open,
    s_axis_tdata  => x_bram_coef,
    s_axis_tlast  => t2_ldr_bi_fifo_tlast,
    m_axis_tvalid => reload_bi_tvalid,
    m_axis_tready => reload_bi_tready,
    m_axis_tdata  => reload_bi_tdata,
    m_axis_tlast  => reload_bi_tlast
  );

  
bq_fifo_inst : px_dec8fir_ld_fifo
    PORT MAP (
      m_aclk        => aclk,
      s_aclk        => s_axi_csr_aclk,
      s_aresetn     => cfifo_rstn,
      s_axis_tvalid => t2_ldr_bq_fifo_tvalid,
      s_axis_tready => open,
      s_axis_tdata  => x_bram_coef,
      s_axis_tlast  => t2_ldr_bq_fifo_tlast,
      m_axis_tvalid => reload_bq_tvalid,
      m_axis_tready => reload_bq_tready,
      m_axis_tdata  => reload_bq_tdata,
      m_axis_tlast  => reload_bq_tlast
    );
    
   
    
-- Determine when the coefficient load is complete    
l_cdc_inst: xpm_cdc_pulse
generic map (
  -- Common module generics
  DEST_SYNC_FF   => 4, -- integer; range: 2-10
  REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
  RST_USED       => 0, -- integer; 0=no reset, 1=implement reset
  SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
)
port map (
  src_clk    => aclk,
  src_rst    => '0',  -- optional; required when RST_USED = 1
  src_pulse  => load_finished,
  dest_clk   => s_axi_csr_aclk,
  dest_rst   => '0',  -- optional; required when RST_USED = 1
  dest_pulse => load_finishedx
);

end Behavioral;
