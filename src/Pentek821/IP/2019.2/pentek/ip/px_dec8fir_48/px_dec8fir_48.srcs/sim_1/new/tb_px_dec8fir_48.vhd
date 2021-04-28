----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2016 09:14:06 AM
-- Design Name: 
-- Module Name: tb_px_dec8fir_48 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use ieee.numeric_std.ALL;
use work.px_utility_pkg.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_px_dec8fir_48 is
generic (
   clk_freq : real := 450.0;  -- MHz
   data_freq : real := 1.0; -- MHz 
   des_mode : std_logic := '1' -- '1' = DES '0' = non-DES
);
end tb_px_dec8fir_48;

architecture Behavioral of tb_px_dec8fir_48 is

component px_dec8fir_48
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
   
   des_ctl            : in  std_logic;      -- DES = '1' = 1 chan 8 samples/cycle, '0' = 2 chan 4 samples/cycle input
   
   sat_a              : out std_logic;  
   sat_b              : out std_logic  
);
end component px_dec8fir_48;

COMPONENT stim_test_sig_48
  PORT (
    s_axi_csr_aclk : IN STD_LOGIC;
    s_axi_csr_aresetn : IN STD_LOGIC;
    s_axi_csr_awaddr : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
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
    s_axi_csr_araddr : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    s_axi_csr_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_csr_arvalid : IN STD_LOGIC;
    s_axi_csr_arready : OUT STD_LOGIC;
    s_axi_csr_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_csr_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_csr_rvalid : OUT STD_LOGIC;
    s_axi_csr_rready : IN STD_LOGIC;
    irq : OUT STD_LOGIC;
    s_axis_aclk : IN STD_LOGIC;
    s_axis_aresetn : IN STD_LOGIC;
    s_axis_ptctl_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_ptctl_tvalid : IN STD_LOGIC;
    m_axis_pd_testsig_tdata : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    m_axis_pd_testsig_tvalid : OUT STD_LOGIC;
    des_ctl : IN STD_LOGIC
  );
END COMPONENT;

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------
type coef_array is array (0 to 223) of integer;
constant clkperiod : time := ((1.0/clk_freq)/2.0) * 1 us;
constant sine_ph : real := (data_freq/clk_freq) * 4294967296.0;
constant sine_ph_incr : std_logic_vector(31 downto 0) := conv_std_logic_vector(integer(sine_ph), 32);
constant coef : coef_array := (
-1,
-3,
-6,
-11,
-18,
-29,
-42,
-59,
-76,
-94,
-110,
-121,
-125,
-118,
-99,
-66,
-21,
34,
94,
152,
201,
232,
238,
213,
154,
64,
-51,
-178,
-302,
-405,
-470,
-479,
-422,
-298,
-113,
117,
365,
598,
782,
881,
871,
735,
476,
114,
-312,
-752,
-1142,
-1421,
-1533,
-1440,
-1131,
-622,
39,
774,
1487,
2072,
2428,
2479,
2180,
1535,
597,
-532,
-1711,
-2775,
-3557,
-3913,
-3746,
-3023,
-1787,
-162,
1659,
3434,
4903,
5821,
5997,
5327,
3817,
1596,
-1091,
-3907,
-6460,
-8353,
-9243,
-8891,
-7210,
-4294,
-420,
3963,
8287,
11922,
14263,
14813,
13261,
9551,
3915,
-3117,
-10755,
-18009,
-23793,
-27038,
-26819,
-22473,
-13696,
-603,
16246,
35878,
56982,
78020,
97370,
113483,
125038,
131069,
131069,
125038,
113483,
97370,
78020,
56982,
35878,
16246,
-603,
-13696,
-22473,
-26819,
-27038,
-23793,
-18009,
-10755,
-3117,
3915,
9551,
13261,
14813,
14263,
11922,
8287,
3963,
-420,
-4294,
-7210,
-8891,
-9243,
-8353,
-6460,
-3907,
-1091,
1596,
3817,
5327,
5997,
5821,
4903,
3434,
1659,
-162,
-1787,
-3023,
-3746,
-3913,
-3557,
-2775,
-1711,
-532,
597,
1535,
2180,
2479,
2428,
2072,
1487,
774,
39,
-622,
-1131,
-1440,
-1533,
-1421,
-1142,
-752,
-312,
114,
476,
735,
871,
881,
782,
598,
365,
117,
-113,
-298,
-422,
-479,
-470,
-405,
-302,
-178,
-51,
64,
154,
213,
238,
232,
201,
152,
94,
34,
-21,
-66,
-99,
-118,
-125,
-121,
-110,
-94,
-76,
-59,
-42,
-29,
-18,
-11,
-6,
-3,
-1
);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------
signal s_axi_csr_aclk        : std_logic := '0';
signal   aclk                : std_logic := '0';
signal   aresetn             : std_logic := '0';
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
signal   s_axis_pdti_tdata  : std_logic_vector(255 downto 0) := (others => '0'); 
signal   s_axis_pdti_tuser  : std_logic_vector(127 downto 0) := (others => '0'); -- IQ, 16-bit, 4 or 8 sample/cycle  
signal   s_axis_pdti_tvalid : std_logic := '0';
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
signal   m_axis_pdti_tdata  : std_logic_vector(63 downto 0);  
signal   m_axis_pdti_tuser  : std_logic_vector(127 downto 0); -- IQ, 16-bit, 1 sample/cycle
signal   m_axis_pdti_tvalid : std_logic;
   
signal   des_ctl            : std_logic := '0';    

signal s_axi_csr_aresetn   : std_logic := '0';
signal s_axi_csr_awaddr    : std_logic_vector(4 downto 0) := (others => '0');
signal s_axi_csr_awprot    : std_logic_vector(2 downto 0) := (others => '0');
signal s_axi_csr_awvalid   : std_logic := '0';
signal s_axi_csr_awready   : std_logic := '0';
signal s_axi_csr_wdata     : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_csr_wstrb     : std_logic_vector(3 downto 0) := (others => '0');
signal s_axi_csr_wvalid    : std_logic := '0';
signal s_axi_csr_wready    : std_logic := '0';
signal s_axi_csr_bresp     : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_csr_bvalid    : std_logic := '0';
signal s_axi_csr_bready    : std_logic := '0';
signal s_axi_csr_araddr    : std_logic_vector(4 downto 0) := (others => '0');
signal s_axi_csr_arprot    : std_logic_vector(2 downto 0) := (others => '0');
signal s_axi_csr_arvalid   : std_logic := '0';
signal s_axi_csr_arready   : std_logic := '0';
signal s_axi_csr_rdata     : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_csr_rresp     : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_csr_rvalid    : std_logic := '0';
signal s_axi_csr_rready    : std_logic := '0';
signal   s_axis_ptctl_tdata : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
signal   s_axis_ptctl_tvalid : STD_LOGIC := '0';
signal   m_axis_pd_testsig_tdata: STD_LOGIC_VECTOR(127 DOWNTO 0) := (others => '0');
signal irq : std_logic;

signal s_axi_uut_csr_aresetn   : std_logic := '0';
signal s_axi_uut_csr_awaddr    : std_logic_vector(12 downto 0) := (others => '0');
signal s_axi_uut_csr_awprot    : std_logic_vector(2 downto 0) := (others => '0');
signal s_axi_uut_csr_awvalid   : std_logic := '0';
signal s_axi_uut_csr_awready   : std_logic := '0';
signal s_axi_uut_csr_wdata     : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_uut_csr_wstrb     : std_logic_vector(3 downto 0) := (others => '0');
signal s_axi_uut_csr_wvalid    : std_logic := '0';
signal s_axi_uut_csr_wready    : std_logic := '0';
signal s_axi_uut_csr_bresp     : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_uut_csr_bvalid    : std_logic := '0';
signal s_axi_uut_csr_bready    : std_logic := '0';
signal s_axi_uut_csr_araddr    : std_logic_vector(12 downto 0) := (others => '0');
signal s_axi_uut_csr_arprot    : std_logic_vector(2 downto 0) := (others => '0');
signal s_axi_uut_csr_arvalid   : std_logic := '0';
signal s_axi_uut_csr_arready   : std_logic := '0';
signal s_axi_uut_csr_rdata     : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_uut_csr_rresp     : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_uut_csr_rvalid    : std_logic := '0';
signal s_axi_uut_csr_rready    : std_logic := '0';
signal uut_irq                 : std_logic;
signal sat_a                   : std_logic;
signal sat_b                   : std_logic;
--------------------------------------------------------------------------------

begin

uut: px_dec8fir_48
port map ( 
   s_axi_csr_aclk => s_axi_csr_aclk,
   s_axi_csr_aresetn => s_axi_csr_aresetn,
   s_axi_csr_awaddr => s_axi_uut_csr_awaddr,
   s_axi_csr_awprot => s_axi_uut_csr_awprot,
   s_axi_csr_awvalid => s_axi_uut_csr_awvalid,
   s_axi_csr_awready => s_axi_uut_csr_awready,
   s_axi_csr_wdata => s_axi_uut_csr_wdata,
   s_axi_csr_wstrb => s_axi_uut_csr_wstrb,
   s_axi_csr_wvalid => s_axi_uut_csr_wvalid,
   s_axi_csr_wready => s_axi_uut_csr_wready,
   s_axi_csr_bresp => s_axi_uut_csr_bresp,
   s_axi_csr_bvalid => s_axi_uut_csr_bvalid,
   s_axi_csr_bready => s_axi_uut_csr_bready,
   s_axi_csr_araddr => s_axi_uut_csr_araddr,
   s_axi_csr_arprot => s_axi_uut_csr_arprot,
   s_axi_csr_arvalid => s_axi_uut_csr_arvalid,
   s_axi_csr_arready => s_axi_uut_csr_arready,
   s_axi_csr_rdata => s_axi_uut_csr_rdata,
   s_axi_csr_rresp => s_axi_uut_csr_rresp,
   s_axi_csr_rvalid => s_axi_uut_csr_rvalid,
   s_axi_csr_rready => s_axi_uut_csr_rready,
   irq => uut_irq ,
   -----------------------------------------------------------------------------
   -- Input Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------
   -- Requires 16-bit data streams
   -- Single Sample per cycle
   aclk                => aclk,
   aresetn             => aresetn,
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
   s_axis_pdti_tdata   => s_axis_pdti_tdata, 
   s_axis_pdti_tuser   => s_axis_pdti_tuser, -- IQ, 16-bit, 4 or 8 sample/cycle  
   s_axis_pdti_tvalid  => s_axis_pdti_tvalid,
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
   m_axis_pdti_tdata  => m_axis_pdti_tdata, 
   m_axis_pdti_tuser  => m_axis_pdti_tuser, -- IQ, 16-bit, 1 sample/cycle
   m_axis_pdti_tvalid => m_axis_pdti_tvalid,
   
   des_ctl            => des_mode,  
   sat_a      => sat_a,  
   sat_b      => sat_b  
);

--------------------------------------------------------------------------------
-- Generate Clocks
--------------------------------------------------------------------------------

-- ACLK Clock
process
begin
    loop
        wait for clkperiod;
        aclk <= not aclk;
        
    end loop;
end process;

-- CSR Clock = 250MHz
process
begin
    loop
        wait for 2 ns;
        s_axi_csr_aclk <= not s_axi_csr_aclk;
        
    end loop;
end process;

sig_gen : stim_test_sig_48
  PORT MAP (
    s_axi_csr_aclk => s_axi_csr_aclk,
    s_axi_csr_aresetn => s_axi_csr_aresetn,
    s_axi_csr_awaddr => s_axi_csr_awaddr,
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
    s_axi_csr_araddr => s_axi_csr_araddr,
    s_axi_csr_arprot => s_axi_csr_arprot,
    s_axi_csr_arvalid => s_axi_csr_arvalid,
    s_axi_csr_arready => s_axi_csr_arready,
    s_axi_csr_rdata => s_axi_csr_rdata,
    s_axi_csr_rresp => s_axi_csr_rresp,
    s_axi_csr_rvalid => s_axi_csr_rvalid,
    s_axi_csr_rready => s_axi_csr_rready,
    irq => irq ,
    s_axis_aclk => aclk,
    s_axis_aresetn => aresetn,
    s_axis_ptctl_tdata => s_axis_ptctl_tdata,
    s_axis_ptctl_tvalid => s_axis_ptctl_tvalid,
    m_axis_pd_testsig_tdata => m_axis_pd_testsig_tdata,
    m_axis_pd_testsig_tvalid => open,--s_axis_pdti_tvalid,
    des_ctl => des_mode
  );
  
s_axis_pdti_tvalid <= '1';
  
s_axis_pdti_tdata <= m_axis_pd_testsig_tdata(127 downto 112) & m_axis_pd_testsig_tdata(127 downto 112)&
                     m_axis_pd_testsig_tdata(111 downto 96) & m_axis_pd_testsig_tdata(111 downto 96)&
                     m_axis_pd_testsig_tdata(95 downto 80) & m_axis_pd_testsig_tdata(95 downto 80)&
                     m_axis_pd_testsig_tdata(79 downto 64) & m_axis_pd_testsig_tdata(79 downto 64)&
                     m_axis_pd_testsig_tdata(63 downto 48) & m_axis_pd_testsig_tdata(63 downto 48)&
                     m_axis_pd_testsig_tdata(47 downto 32) & m_axis_pd_testsig_tdata(47 downto 32)&
                     m_axis_pd_testsig_tdata(31 downto 16) & m_axis_pd_testsig_tdata(31 downto 16)&
                     m_axis_pd_testsig_tdata(15 downto 0) & m_axis_pd_testsig_tdata(15 downto 0); 
  
test_process: process
  variable c_time : time    := 0 ns;
  variable d_time : time    := 0 ns;
  variable x      : integer := 5;
  begin
     wait for 400 ns;
     wait until rising_edge(s_axi_csr_aclk);
     s_axi_csr_aresetn <= '1';
     aresetn <= '1';
     wait for 40 ns;
     c_time := now;
     -----------------------------------------------------------------------------
     -- Set up Control Registers
     -----------------------------------------------------------------------------
        assert false
        report "Setting up test signal frequency. Start Time = " & time'image(now) 
        severity NOTE;
        px_axi_lite_writer("00100",sine_ph_incr, s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
   
        d_time := now - c_time; 
        assert false
        report "Finished setting up test signal frequency. End Time = " & time'image(now) 
        severity NOTE;
        assert false
        report "Total Time = " & time'image(d_time) 
        severity NOTE; 
        
        wait for 200 ns;
        
        c_time := now;   
        assert false
        report "Writing test signal control Register. Start Time = " & time'image(now) 
        severity NOTE;
        px_axi_lite_writer("00000",x"00000082", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
        d_time := now - c_time; 
        assert false
        report "Finished test signal control Register. End Time = " & time'image(now) 
        severity NOTE;
        assert false
        report "Total Time = " & time'image(d_time) 
        severity NOTE; 
        
        wait for 100 ns;
        
        c_time := now;   
        assert false
        report "Writing test signal control Register. Start Time = " & time'image(now) 
        severity NOTE;
        px_axi_lite_writer("00000",x"00000080", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
        d_time := now - c_time; 
        assert false
        report "Finished test signal control Register. End Time = " & time'image(now) 
        severity NOTE;
        assert false
        report "Total Time = " & time'image(d_time) 
        severity NOTE; 
        
        wait for 100 ns;
        
        c_time := now;  
        assert false
        report "Writing Coef Values to Filter Coefs. Start Time = " & time'image(now) 
        severity NOTE;
        for i in 0 to 223 loop
            px_axi_lite_writer(("1000000000000" + conv_std_logic_vector((i*4),13)),(x"00"& "000000" & (conv_std_logic_vector(coef(i), 18))), s_axi_csr_aclk, s_axi_uut_csr_awaddr, s_axi_uut_csr_awprot, s_axi_uut_csr_awvalid, s_axi_uut_csr_awready, s_axi_uut_csr_wdata, s_axi_uut_csr_wstrb, s_axi_uut_csr_wvalid, s_axi_uut_csr_wready, s_axi_uut_csr_bresp, s_axi_uut_csr_bvalid, s_axi_uut_csr_bready);
        end loop;    
        c_time := now; 
        px_axi_lite_writer("0000000001100",x"00000001", s_axi_csr_aclk, s_axi_uut_csr_awaddr, s_axi_uut_csr_awprot, s_axi_uut_csr_awvalid, s_axi_uut_csr_awready, s_axi_uut_csr_wdata, s_axi_uut_csr_wstrb, s_axi_uut_csr_wvalid, s_axi_uut_csr_wready, s_axi_uut_csr_bresp, s_axi_uut_csr_bvalid, s_axi_uut_csr_bready);
        d_time := now - c_time; 
        assert false
        report "Toggle Start Coefficient Load. End Time = " & time'image(now) 
        severity NOTE;
        c_time := now; 
        px_axi_lite_writer("0000000001100",x"00000000", s_axi_csr_aclk, s_axi_uut_csr_awaddr, s_axi_uut_csr_awprot, s_axi_uut_csr_awvalid, s_axi_uut_csr_awready, s_axi_uut_csr_wdata, s_axi_uut_csr_wstrb, s_axi_uut_csr_wvalid, s_axi_uut_csr_wready, s_axi_uut_csr_bresp, s_axi_uut_csr_bvalid, s_axi_uut_csr_bready);
        d_time := now - c_time; 
        assert false
        report "Toggle Start Coefficient Load. End Time = " & time'image(now) 
        severity NOTE;
        wait for 3 us;
        c_time := now; 
        
        wait for 500 ns;
        wait until rising_edge(aclk);
        wait for 0.5 ns;
        --aresetn <= '0';        
        wait until rising_edge(aclk);
        wait for 0.5 ns;
        wait until rising_edge(aclk);
        wait for 0.5 ns;
        --aresetn <= '1';
        
        wait until rising_edge(aclk);
        wait for 0.5 ns;
        s_axis_ptctl_tvalid <= '1';
        wait for 1 us;
        wait until rising_edge(aclk);
        wait for 0.5 ns;
        s_axis_pdti_tuser(72) <= '1';
        --m_axis_pd_testsig_tdata(15 downto 0) <= x"7FFF";
        wait until rising_edge(aclk);
        wait for 0.5 ns;
        s_axis_pdti_tuser(72) <= '0';
        --m_axis_pd_testsig_tdata(15 downto 0) <= x"0000";
     wait for 7 us;
     wait for 10 us;
     assert false
     report "Test Complete, Not A Failure." 
     severity FAILURE;
  end process;  


end Behavioral;
