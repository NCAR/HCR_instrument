----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/11/2017 01:07:04 PM
-- Design Name: 
-- Module Name: tb1 - Behavioral
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
use std.textio.all;

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

entity tb_px_8ch_channelizer_ddc is
generic (
   clk_freq : real  := 200.0;  -- MHz must have decimal point
   data_freq : real := 26.0; -- MHz  must have decimal point
   tuning_freq_0 : real := 25.0; -- MHz must have decimal point
   tuning_freq_1 : real := 25.0; -- MHz must have decimal point
   tuning_freq_2 : real := 25.0; -- MHz must have decimal point
   tuning_freq_3 : real := 25.0; -- MHz must have decimal point
   tuning_freq_4 : real := 25.0; -- MHz must have decimal point
   tuning_freq_5 : real := 25.0; -- MHz must have decimal point
   tuning_freq_6 : real := 25.0; -- MHz must have decimal point
   tuning_freq_7 : real := 25.0; -- MHz must have decimal point
   enable_mask : std_logic_vector(7 downto 0) := x"FF"; -- Set each bit to '1' to enable a channel
   decimation : integer := 2 --2,3,4,7,8,11
);
end tb_px_8ch_channelizer_ddc;

architecture Behavioral of tb_px_8ch_channelizer_ddc is

component px_8ch_channelizer_ddc
generic(
   first_chan : integer := 0 -- 0-248 -- Use only multiples of 8 
);
port (
----------------------------------------------------------------------------
-- AXI4-Lite Control/Status Interface
----------------------------------------------------------------------------
s_axi_csr_aclk      : in  std_logic;
s_axi_csr_aresetn   : in  std_logic;
s_axi_csr_awaddr    : in  std_logic_vector(15 downto 0);
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
s_axi_csr_araddr    : in  std_logic_vector(15 downto 0);
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
axis_aclk          : in  std_logic;
axis_aresetn       : in  std_logic;
-- tuser[63:0]    = timestamp[63:0]
-- tuser[71:64]   = Gate Positions  (in this case only 64 is required)
-- tuser[79:72]   = Sync Positions  (in this case only 72 is required)    
-- tuser[87:80]   = PPS  Positions  (in this case only 80 is required)
-- tuser[91:88]   = Samples/Cycle -- 1
-- tuser[92]      = IQ of first sample in data 0 = I, 1 = Q  -- 0
-- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit  -- 1
-- tuser[95]      = Data Type 0 = Real 1 = I/Q  -- 0
-- tuser[103:96]  = channel[7:0] 
-- tuser[127:104] = Reserved 

s_axis_pdti_tdata  : in  std_logic_vector(15 downto 0); 
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
-- tuser[127:112] = Reserved  (111:104 = saturate marker) 
-- 8-Channel multiplexed stream
-- Packed 16-bit mode 
   -- [31:16] = Q [15:0] = I
-- Unpacked 24-bit mode
   -- (t) [31:8]   = I
   -- (t+1) [31:8] = Q   
-- Each 24-bit value in upper 24 bits of 32 bits
m_axis_pdti_tdata  : out std_logic_vector(31 downto 0);  
m_axis_pdti_tuser  : out std_logic_vector(127 downto 0);
m_axis_pdti_tvalid : out std_logic;
       
sat                : out std_logic_vector(7 downto 0)  
);
end component px_8ch_channelizer_ddc;

COMPONENT tb_sinewave
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_phase_tvalid : IN STD_LOGIC;
    s_axis_phase_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT;

type dec2_coef is array (0 to ((28*2)-1)) of integer; 
type dec3_coef is array (0 to ((28*3)-1)) of integer; 
type dec4_coef is array (0 to ((28*4)-1)) of integer; 
type dec7_coef is array (0 to ((28*7)-1)) of integer; 
type dec8_coef is array (0 to ((28*8)-1)) of integer; 
type dec11_coef is array (0 to ((28*11)-1)) of integer; 

----------------------------------------------------------------------------
 -- Input
----------------------------------------------------------------------------
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
signal s_axis_pdti_tdata  : std_logic_vector(15 downto 0) := (others => '0'); 
signal s_axis_pdti_tuser  : std_logic_vector(127 downto 0) := (others => '0'); -- IQ, 16-bit, 1 sample/cycle  
signal s_axis_pdti_tvalid : std_logic := '0'; -- must be always valid
signal axis_aclk          : std_logic := '0';
signal axis_aresetn       : std_logic := '0';

signal s_axi_csr_aclk      : std_logic := '0';
signal s_axi_csr_aresetn   : std_logic := '0';
signal s_axi_csr_awaddr    : std_logic_vector(15 downto 0) := (others => '0');
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
signal s_axi_csr_araddr    : std_logic_vector(15 downto 0) := (others => '0');
signal s_axi_csr_arprot    : std_logic_vector(2 downto 0) := (others => '0');
signal s_axi_csr_arvalid   : std_logic := '0';
signal s_axi_csr_arready   : std_logic := '0';
signal s_axi_csr_rdata     : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_csr_rresp     : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_csr_rvalid    : std_logic := '0';
signal s_axi_csr_rready    : std_logic := '0';

signal irq                       : std_logic := '0';

signal m_axis_pdti_tdata         : std_logic_vector(31 downto 0) := (others => '0');  
signal m_axis_pdti_tuser         : std_logic_vector(127 downto 0) := (others => '0');
signal m_axis_pdti_tvalid        : std_logic := '0';
signal m_axis_pdti_tlast         : std_logic := '0'; -- end of channel mux marker

type ph_real is array (0 to 7) of real;
type ph_stdlogic is array (0 to 7) of std_logic_vector(31 downto 0);

constant clkperiod : time := ((1.0/clk_freq)/2.0) * 1 us;
constant sine_ph : real := (data_freq/clk_freq) * 4294967296.0;
constant sine_ph_incr : std_logic_vector(31 downto 0) := conv_std_logic_vector(integer(sine_ph), 32);
constant tph: ph_real := (((tuning_freq_0/clk_freq) * 4294967296.0),
                          ((tuning_freq_1/clk_freq) * 4294967296.0),
                          ((tuning_freq_2/clk_freq) * 4294967296.0),
                          ((tuning_freq_3/clk_freq) * 4294967296.0),
                          ((tuning_freq_4/clk_freq) * 4294967296.0),
                          ((tuning_freq_5/clk_freq) * 4294967296.0),
                          ((tuning_freq_6/clk_freq) * 4294967296.0),
                          ((tuning_freq_7/clk_freq) * 4294967296.0));
constant tune_ph_incr : ph_stdlogic := ((conv_std_logic_vector(integer(tph(0)), 32)),
                                        (conv_std_logic_vector(integer(tph(1)), 32)),
                                        (conv_std_logic_vector(integer(tph(2)), 32)),
                                        (conv_std_logic_vector(integer(tph(3)), 32)),
                                        (conv_std_logic_vector(integer(tph(4)), 32)),
                                        (conv_std_logic_vector(integer(tph(5)), 32)),
                                        (conv_std_logic_vector(integer(tph(6)), 32)),
                                        (conv_std_logic_vector(integer(tph(7)), 32)));
                                                                       
-- Register Addresses
constant SECT1_CTRL_REGISTER :std_logic_vector(15 downto 0) := x"0004";
constant SECT2_CTRL_REGISTER :std_logic_vector(15 downto 0) := x"4004";
constant FREQ_TABLE  :std_logic_vector(15 downto 0) := x"4800";
constant FIR_CONTROL_REGISTER:std_logic_vector(15 downto 0) := x"8000";
constant FIR_COEF_LOAD_REGISTER:std_logic_vector(15 downto 0) := x"8004";
constant FIR_GAIN0_REGISTER:std_logic_vector(15 downto 0) := x"8008";
constant FIR_INT_ENABLE_REGISTER:std_logic_vector(15 downto 0) := x"801C";

-- Gain Calc
constant gain                : integer := (5461)/decimation;

-- Coefficient Sets
constant dec2coef : dec2_coef := (
-5,
-41,
-115,
-119,
74,
260,
3,
-486,
-223,
768,
667,
-1056,
-1423,
1262,
2584,
-1253,
-4254,
836,
6568,
285,
-9779,
-2643,
14541,
7557,
-23149,
-20346,
50695,
131070,
131070,
50695,
-20346,
-23149,
7557,
14541,
-2643,
-9779,
285,
6568,
836,
-4254,
-1253,
2584,
1262,
-1423,
-1056,
667,
768,
-223,
-486,
3,
260,
74,
-119,
-115,
-41,
-5
);


constant dec3coef : dec3_coef := (
-4,
-24,
-71,
-135,
-165,
-100,
73,
256,
274,
21,
-377,
-575,
-269,
447,
1000,
745,
-373,
-1522,
-1522,
34,
2075,
2664,
726,
-2550,
-4227,
-2109,
2779,
6273,
4404,
-2509,
-8920,
-8130,
1306,
12518,
14550,
1854,
-18385,
-28294,
-11175,
34740,
91463,
130456,
130456,
91463,
34740,
-11175,
-28294,
-18385,
1854,
14550,
12518,
1306,
-8130,
-8920,
-2509,
4404,
6273,
2779,
-2109,
-4227,
-2550,
726,
2664,
2075,
34,
-1522,
-1522,
-373,
745,
1000,
447,
-269,
-575,
-377,
21,
274,
256,
73,
-100,
-165,
-135,
-71,
-24,
-4
);

constant dec4coef : dec4_coef := (
-2,
-8,
-24,
-51,
-87,
-119,
-125,
-85,
6,
126,
223,
233,
114,
-116,
-364,
-490,
-375,
-2,
495,
859,
833,
311,
-544,
-1322,
-1540,
-914,
411,
1834,
2539,
1932,
48,
-2309,
-3862,
-3513,
-1029,
2615,
5541,
5871,
2830,
-2552,
-7645,
-9394,
-5995,
1773,
10410,
15046,
11872,
537,
-14753,
-26249,
-25632,
-7797,
26244,
68799,
107781,
131048,
131048,
107781,
68799,
26244,
-7797,
-25632,
-26249,
-14753,
537,
11872,
15046,
10410,
1773,
-5995,
-9394,
-7645,
-2552,
2830,
5871,
5541,
2615,
-1029,
-3513,
-3862,
-2309,
48,
1932,
2539,
1834,
411,
-914,
-1540,
-1322,
-544,
311,
833,
859,
495,
-2,
-375,
-490,
-364,
-116,
114,
233,
223,
126,
6,
-85,
-125,
-119,
-87,
-51,
-24,
-8,
-2
); 

constant dec7coef : dec7_coef := (
-5,
-11,
-22,
-38,
-58,
-81,
-105,
-124,
-135,
-131,
-107,
-61,
6,
92,
187,
279,
352,
392,
385,
322,
205,
42,
-146,
-333,
-484,
-569,
-560,
-446,
-228,
70,
408,
730,
977,
1092,
1034,
788,
371,
-168,
-747,
-1269,
-1632,
-1749,
-1565,
-1075,
-328,
575,
1490,
2253,
2706,
2731,
2269,
1346,
73,
-1362,
-2716,
-3738,
-4202,
-3961,
-2978,
-1345,
716,
2881,
4770,
6010,
6303,
5489,
3590,
825,
-2406,
-5571,
-8091,
-9435,
-9221,
-7300,
-3813,
806,
5866,
10510,
13846,
15094,
13736,
9635,
3111,
-5049,
-13659,
-21263,
-26319,
-27420,
-23504,
-14041,
847,
20344,
42995,
66849,
89677,
109232,
123522,
131064,
131064,
123522,
109232,
89677,
66849,
42995,
20344,
847,
-14041,
-23504,
-27420,
-26319,
-21263,
-13659,
-5049,
3111,
9635,
13736,
15094,
13846,
10510,
5866,
806,
-3813,
-7300,
-9221,
-9435,
-8091,
-5571,
-2406,
825,
3590,
5489,
6303,
6010,
4770,
2881,
716,
-1345,
-2978,
-3961,
-4202,
-3738,
-2716,
-1362,
73,
1346,
2269,
2731,
2706,
2253,
1490,
575,
-328,
-1075,
-1565,
-1749,
-1632,
-1269,
-747,
-168,
371,
788,
1034,
1092,
977,
730,
408,
70,
-228,
-446,
-560,
-569,
-484,
-333,
-146,
42,
205,
322,
385,
392,
352,
279,
187,
92,
6,
-61,
-107,
-131,
-135,
-124,
-105,
-81,
-58,
-38,
-22,
-11,
-5
);

constant dec8coef : dec8_coef := (
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

constant dec11coef : dec11_coef := (
-1,
-2,
-3,
-6,
-9,
-14,
-20,
-28,
-37,
-48,
-60,
-73,
-86,
-99,
-110,
-119,
-123,
-124,
-118,
-106,
-87,
-61,
-28,
10,
52,
96,
138,
177,
209,
230,
238,
230,
206,
163,
104,
30,
-55,
-147,
-240,
-326,
-399,
-452,
-478,
-473,
-432,
-356,
-245,
-104,
61,
238,
418,
585,
727,
831,
883,
876,
803,
664,
461,
205,
-92,
-410,
-728,
-1022,
-1267,
-1441,
-1523,
-1499,
-1361,
-1109,
-752,
-307,
200,
735,
1262,
1739,
2127,
2387,
2490,
2415,
2152,
1707,
1096,
354,
-474,
-1333,
-2160,
-2889,
-3459,
-3813,
-3907,
-3714,
-3227,
-2458,
-1445,
-245,
1064,
2394,
3643,
4713,
5507,
5945,
5967,
5540,
4660,
3361,
1709,
-198,
-2237,
-4262,
-6119,
-7656,
-8731,
-9228,
-9062,
-8194,
-6634,
-4442,
-1733,
1331,
4551,
7696,
10523,
12794,
14288,
14823,
14271,
12572,
9742,
5880,
1171,
-4125,
-9678,
-15108,
-20001,
-23933,
-26500,
-27335,
-26141,
-22707,
-16930,
-8822,
1479,
13713,
27504,
42379,
57786,
73122,
87761,
101087,
112530,
121588,
127861,
131070,
131070,
127861,
121588,
112530,
101087,
87761,
73122,
57786,
42379,
27504,
13713,
1479,
-8822,
-16930,
-22707,
-26141,
-27335,
-26500,
-23933,
-20001,
-15108,
-9678,
-4125,
1171,
5880,
9742,
12572,
14271,
14823,
14288,
12794,
10523,
7696,
4551,
1331,
-1733,
-4442,
-6634,
-8194,
-9062,
-9228,
-8731,
-7656,
-6119,
-4262,
-2237,
-198,
1709,
3361,
4660,
5540,
5967,
5945,
5507,
4713,
3643,
2394,
1064,
-245,
-1445,
-2458,
-3227,
-3714,
-3907,
-3813,
-3459,
-2889,
-2160,
-1333,
-474,
354,
1096,
1707,
2152,
2415,
2490,
2387,
2127,
1739,
1262,
735,
200,
-307,
-752,
-1109,
-1361,
-1499,
-1523,
-1441,
-1267,
-1022,
-728,
-410,
-92,
205,
461,
664,
803,
876,
883,
831,
727,
585,
418,
238,
61,
-104,
-245,
-356,
-432,
-473,
-478,
-452,
-399,
-326,
-240,
-147,
-55,
30,
104,
163,
206,
230,
238,
230,
209,
177,
138,
96,
52,
10,
-28,
-61,
-87,
-106,
-118,
-124,
-123,
-119,
-110,
-99,
-86,
-73,
-60,
-48,
-37,
-28,
-20,
-14,
-9,
-6,
-3,
-2,
-1
);


begin

--------------------------------------------------------------------------------
-- Generate Clocks
--------------------------------------------------------------------------------

-- CSR Clock = 250MHz
process
begin
    loop
        s_axi_csr_aclk <= not s_axi_csr_aclk;
        wait for 2 ns;
    end loop;
end process;

-- ACLK Clock
process
begin
    loop
        axis_aclk <= not axis_aclk;
        wait for clkperiod;
    end loop;
end process;

process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      if s_axis_pdti_tvalid = '1' then
         s_axis_pdti_tuser(63 downto 0) <= s_axis_pdti_tuser(63 downto 0) + 1;
      end if;
   end if;
end process;   


tb_sine : tb_sinewave
  PORT MAP (
    aclk => axis_aclk,
    s_axis_phase_tvalid => '1',
    s_axis_phase_tdata => sine_ph_incr,
    m_axis_data_tvalid => s_axis_pdti_tvalid, 
    m_axis_data_tdata => s_axis_pdti_tdata
);

uut: px_8ch_channelizer_ddc
generic map(
    first_chan => 0  -- must be 0 or multiple of eight
)
port map (
 ----------------------------------------------------------------------------
 -- Input
 ----------------------------------------------------------------------------
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
 s_axis_pdti_tdata    => s_axis_pdti_tdata,     
 s_axis_pdti_tuser    => s_axis_pdti_tuser,     
 s_axis_pdti_tvalid   => s_axis_pdti_tvalid,    
 axis_aclk            => axis_aclk,             
 axis_aresetn         => axis_aresetn,          
-----------------------------------------------------------------------------
 -- Output Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
 -----------------------------------------------------------------------------
 -- tuser[63:0]    = timestamp[63:0]
 -- tuser[71:64]   = Gate Positions  (in this case only 64 is required)
 -- tuser[79:72]   = Sync Positions  (in this case only 72 is required)    
 -- tuser[87:80]   = PPS  Positions  (in this case only 80 is required)
 -- tuser[91:88]   = Samples/Cycle -- 1
 -- tuser[92]      = IQ of first sample in data 0 = I, 1 = Q  -- 0
 -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit  -- 2
 -- tuser[95]      = Data Type 0 = Real 1 = I/Q -- 1
 -- tuser[103:96]  = channel[7:0]
 -- tuser[127:112] = Reserved  (111:104 = saturate marker) 
 -- 8-Channel multiplexed stream
 -- Packed 16-bit mode 
    -- [31:16] = Q [15:0] = I
 -- Unpacked 24-bit mode
    -- (t) [31:8]   = I
    -- (t+1) [31:8] = Q   
 -- Each 24-bit value in upper 24 bits of 32 bits
 m_axis_pdti_tdata   => m_axis_pdti_tdata,  
 m_axis_pdti_tuser   => m_axis_pdti_tuser,  
 m_axis_pdti_tvalid  => m_axis_pdti_tvalid, 
 ----------------------------------------------------------------------------
 -- AXI4-Lite Control/Status Interface
 ----------------------------------------------------------------------------
 s_axi_csr_aclk      => s_axi_csr_aclk,    
 s_axi_csr_aresetn   => s_axi_csr_aresetn, 
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
 irq                 => irq  
);


test_process: process
variable c_time : time    := 0 ns;
variable d_time : time    := 0 ns;
variable x      : integer := 5;
variable bram_addr : std_logic_vector(15 downto 0) := x"0000";
begin
   wait for 400 ns;
   wait until rising_edge(s_axi_csr_aclk);
   --gate <= '0';
   s_axi_csr_aresetn <= '1';
   axis_aresetn <= '1';
   wait for 40 ns;
   c_time := now;
   -----------------------------------------------------------------------------
   -- Set up Control Registers
   -----------------------------------------------------------------------------
      assert false
      report "Writing to Sect1 Control Register. Start Time = " & time'image(now) 
      severity NOTE;
      px_axi_lite_writer(SECT1_CTRL_REGISTER,x"00000001", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      d_time := now - c_time; 
      assert false
      report "Finished Writing to Sect1 Control Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE; 

      report "Writing to Sect2 Control Register. Start Time = " & time'image(now) 
      severity NOTE;
      px_axi_lite_writer(SECT2_CTRL_REGISTER,x"000000FF", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      d_time := now - c_time; 
      assert false
      report "Finished Writing to Sect2 Control Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE; 
      
      c_time := now; 
      assert false
      report "Writing to Frequency Table. Start Time = " & time'image(now) 
      severity NOTE;  
      for i in 0 to 7 loop
         px_axi_lite_writer(FREQ_TABLE+(i*4),tune_ph_incr(i), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      end loop;
      d_time := now - c_time; 
      assert false
      report "Finished Writing to Frequency Table CH0. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE; 
   -----------------------------------------------------------------------------
   -- Set up FIR Registers
   -----------------------------------------------------------------------------
      assert false
      report "Writing to FIR Control Register. Start Time = " & time'image(now) 
      severity NOTE;
      px_axi_lite_writer(FIR_CONTROL_REGISTER, (x"0001" & enable_mask & conv_std_logic_vector(decimation-1,8)), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      d_time := now - c_time; 
      assert false
      report "Finished Writing to FIR Control Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE; 
      
      c_time := now;   
      assert false
      report "Writing to Gain Registers. Start Time = " & time'image(now) 
      severity NOTE;
      for i in 0 to 3 loop
         px_axi_lite_writer(FIR_GAIN0_REGISTER+(i*4),(conv_std_logic_vector(gain,16) & conv_std_logic_vector(gain,16)), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      end loop;
      d_time := now - c_time; 
      assert false
      report "Finished Writing to Gain Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE; 
      
      assert false
      report "Writing to FIR Interrupt Enable Register. Start Time = " & time'image(now) 
      severity NOTE;
      px_axi_lite_writer(FIR_INT_ENABLE_REGISTER, x"000000FF", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      d_time := now - c_time; 
      assert false
      report "Finished Writing to FIR Interrupt Enable Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE; 

   -----------------------------------------------------------------------------
   -- Set up FIR Coefficient RAM
   -----------------------------------------------------------------------------
   c_time := now;   
   assert false
   report "Writing to Coefficients RAM. Start Time = " & time'image(now) 
   severity NOTE;
   for i in 0 to ((decimation*14)-1) loop
      bram_addr := x"A000" + conv_std_logic_vector(i*4,16);
      if (decimation = 8) then
      px_axi_lite_writer(bram_addr,conv_std_logic_vector(dec8coef(i), 32), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      elsif (decimation = 11) then
      px_axi_lite_writer(bram_addr,conv_std_logic_vector(dec11coef(i), 32), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      elsif (decimation = 7) then
      px_axi_lite_writer(bram_addr,conv_std_logic_vector(dec7coef(i), 32), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      elsif (decimation = 4) then
      px_axi_lite_writer(bram_addr,conv_std_logic_vector(dec4coef(i), 32), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      elsif (decimation = 3) then
      px_axi_lite_writer(bram_addr,conv_std_logic_vector(dec3coef(i), 32), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      else
      px_axi_lite_writer(bram_addr,conv_std_logic_vector(dec2coef(i), 32), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);      
      end if;
      --px_axi_lite_writer(bram_addr,conv_std_logic_vector(i, 32), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);      
   end loop;
   d_time := now - c_time; 
   assert false
   report "Finished Writing to Coefficients RAM. End Time = " & time'image(now) 
   severity NOTE;
   assert false
   report "Total Time = " & time'image(d_time) 
   severity NOTE; 
   -----------------------------------------------------------------------------
   -- Load Coefficients to Filter
   -----------------------------------------------------------------------------
   c_time := now;   
   assert false
   report "Toggling Filter Coefficient Load. Start Time = " & time'image(now) 
   severity NOTE;
   px_axi_lite_writer(FIR_COEF_LOAD_REGISTER,x"00000001", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
   wait for 1 us;
   px_axi_lite_writer(FIR_COEF_LOAD_REGISTER,x"00000000", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
   d_time := now - c_time; 
   assert false
   report "Finished Toggling Filter Coefficient Load. End Time = " & time'image(now) 
   severity NOTE;
   assert false
   report "Total Time = " & time'image(d_time) 
   severity NOTE;    
   
   
         
   wait for 7 us;
       
   wait for 100 ns;  
   wait until rising_edge(axis_aclk);
   --gate <= '1';  
   --s_axis_pdti_tdata(15 downto 0) <= x"4000";
   s_axis_pdti_tuser(64) <= '1';
   s_axis_pdti_tuser(72) <= '1';
   wait until rising_edge(axis_aclk);
   --s_axis_pdti_tdata(15 downto 0) <= x"0000";
   s_axis_pdti_tuser(72) <= '0';
    wait for 7 us;
   
   -- turn off SYNC Enables 
   assert false
   report "Writing to Sect1 Control Register. Start Time = " & time'image(now) 
   severity NOTE;
   px_axi_lite_writer(SECT1_CTRL_REGISTER,x"00000000", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
   d_time := now - c_time; 
   assert false
   report "Finished Writing to Sect1 Control Register. End Time = " & time'image(now) 
   severity NOTE;
   assert false
   report "Total Time = " & time'image(d_time) 
   severity NOTE; 
   
   report "Writing to Sect2 Control Register. Start Time = " & time'image(now) 
   severity NOTE;
   px_axi_lite_writer(SECT2_CTRL_REGISTER,x"00000000", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
   d_time := now - c_time; 
   assert false
   report "Finished Writing to Sect2 Control Register. End Time = " & time'image(now) 
   severity NOTE;
   assert false
   report "Total Time = " & time'image(d_time) 
   severity NOTE;  
   
   assert false
   report "Writing to FIR Control Register. Start Time = " & time'image(now) 
   severity NOTE;
   px_axi_lite_writer(FIR_CONTROL_REGISTER, (x"0000" & enable_mask & conv_std_logic_vector(decimation-1,8)), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
   d_time := now - c_time; 
   assert false
   report "Finished Writing to FIR Control Register. End Time = " & time'image(now) 
   severity NOTE;
   assert false
   report "Total Time = " & time'image(d_time) 
   severity NOTE; 
        
   wait until rising_edge(axis_aclk);
   --s_axis_pdti_tdata(15 downto 0) <= x"4000";
   s_axis_pdti_tuser(72) <= '1'; -- sync pulse
   wait until rising_edge(axis_aclk);
   --s_axis_pdti_tdata(15 downto 0) <= x"0000";
   s_axis_pdti_tuser(72) <= '0';
   wait for 100 us;
   wait;
   
   assert false
   report "Test Complete, Not A Failure." 
   severity FAILURE;
end process;  

end Behavioral;
