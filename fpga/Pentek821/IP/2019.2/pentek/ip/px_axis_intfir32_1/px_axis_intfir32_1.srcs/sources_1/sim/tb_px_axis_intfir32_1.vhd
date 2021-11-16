----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/27/2016 10:05:45 AM
-- Design Name: 
-- Module Name: tb_px_axis_intfir32_1 - Behavioral
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

-------------------------------------------------------------------------------
-- Libraries
-------------------------------------------------------------------------------
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

entity tb_px_axis_intfir32_1 is
generic (
   clk_freq : real := 200.0;  -- MHz
   data_freq : real := 8.0; -- MHz 
   num_chan   : integer := 2;
   out_res    : integer := 16;
   interpolation : integer := 4; -- 2 or 4
   in_rate_reduce : integer := 1; -- Input Rate is divided by this factor*interpolation 
   ddc_enable : std_logic := '1'  
);
end tb_px_axis_intfir32_1;

architecture Behavioral of tb_px_axis_intfir32_1 is

component px_axis_intfir32_1 
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

   -----------------------------------------------------------------------------
   -- Input Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------
   aclk                : in  std_logic;
   aresetn             : in  std_logic;
   -- tuser[63:0]    = timestamp[63:0]
   -- tuser[71:64]   = Gate Positions  (in this case only 64 is required)
   -- tuser[79:72]   = Sync Positions  (in this case only 72 is required)    
   -- tuser[87:80]   = PPS  Positions  (in this case only 80 is required)
   -- tuser[92:88]   = Samples/Cycle
   -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
   -- tuser[95]      = Data Type 0 = Real 1 = I/Q
   -- tuser[103:96]  = channel[7:0] 
   -- tuser[127:104] = Reserved 
   -- tdata[15:0]    = real = Real , IQ = I
   -- tdata[31:16]   = real = Duplicate Real or 0 , IQ = Q
   s_axis_pdti_tdata  : in  std_logic_vector(31 downto 0);  
   s_axis_pdti_tuser  : in  std_logic_vector(127 downto 0);
   s_axis_pdti_tvalid : in  std_logic;
   -----------------------------------------------------------------------------
   -- Output Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------
   -- tuser[63:0]    = timestamp[63:0]
   -- tuser[71:64]   = Gate Positions  (in this case only 64 is required)
   -- tuser[79:72]   = Sync Positions  (in this case only 72 is required)    
   -- tuser[87:80]   = PPS  Positions  (in this case only 80 is required)
   -- tuser[92:88]   = Samples/Cycle
   -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
   -- tuser[95]      = Data Type 0 = Real 1 = I/Q
   -- tuser[103:96]  = channel[7:0] 
   -- tuser[127:104] = Reserved 
   -- tdata[15:0]    = real = Real , IQ = I
   -- tdata[31:16]   = real = Duplicate Real or 0 , IQ = Q
   m_axis_pdti_tdata  : out std_logic_vector(31 downto 0);  
   m_axis_pdti_tuser  : out std_logic_vector(127 downto 0);
   m_axis_pdti_tvalid : out std_logic;
   
   sat                : out std_logic      

);
end component;

COMPONENT tb_dds
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_phase_tvalid : IN STD_LOGIC;
    s_axis_phase_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT;

type int2_coef is array (0 to ((32*2)-1)) of integer; 
type int4_coef is array (0 to ((32*4)-1)) of integer; 

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------



constant clkperiod : time := ((1.0/clk_freq)/2.0) * 1 us;
constant sine_ph : real := (data_freq/clk_freq) * 4294967296.0;
constant sine_ph_incr : std_logic_vector(31 downto 0) := conv_std_logic_vector(integer(sine_ph), 32);
constant INTERP_REGISTER     : std_logic_vector(12 downto 0) := '0' & x"000";
constant GAIN_REGISTER       : std_logic_vector(12 downto 0) := '0' & x"004";
constant CTL_REGISTER        : std_logic_vector(12 downto 0) := '0' & x"008";
constant LOAD_REGISTER       : std_logic_vector(12 downto 0) := '0' & x"00C";
constant gain                : integer := 3500;
constant int2coef : int2_coef := (
0,
0,
0,
0,
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
-5,
0,
0,
0,
0
);

constant int4coef : int4_coef := (
0,
0,
0,
0,
0,
0,
0,
0,
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
-2,
0,
0,
0,
0,
0,
0,
0,
0

); 


--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------
----------------------------------------------------------------------------
-- AXI4-Lite Control/Status Interface
----------------------------------------------------------------------------
signal s_axi_csr_aclk      : std_logic := '0';
signal s_axi_csr_aresetn   : std_logic := '0';
signal s_axi_csr_awaddr    : std_logic_vector(12 downto 0) := (others => '0');
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
signal s_axi_csr_araddr    : std_logic_vector(12 downto 0) := (others => '0');
signal s_axi_csr_arprot    : std_logic_vector(2 downto 0) := (others => '0');
signal s_axi_csr_arvalid   : std_logic := '0';
signal s_axi_csr_arready   : std_logic := '0';
signal s_axi_csr_rdata     : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_csr_rresp     : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_csr_rvalid    : std_logic := '0';
signal s_axi_csr_rready    : std_logic := '0';

-----------------------------------------------------------------------------
-- Input Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
-----------------------------------------------------------------------------
signal aclk                : std_logic := '0';
signal aresetn             : std_logic := '0';
-- tuser[63:0]    = timestamp[63:0]
-- tuser[71:64]   = Gate Positions  (in this case only 64 is required)
-- tuser[79:72]   = Sync Positions  (in this case only 72 is required)    
-- tuser[87:80]   = PPS  Positions  (in this case only 80 is required)
-- tuser[92:88]   = Samples/Cycle
-- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
-- tuser[95]      = Data Type 0 = Real 1 = I/Q
-- tuser[103:96]  = channel[7:0] 
-- tuser[127:104] = Reserved 
-- tdata[15:0]    = real = Real , IQ = I
-- tdata[31:16]   = real = Duplicate Real or 0 , IQ = Q
signal s_axis_pdti_tdata  : std_logic_vector(31 downto 0) := x"00000000";  
signal s_axis_pdti_tuser  : std_logic_vector(127 downto 0) := (others => '0');
signal s_axis_pdti_tvalid : std_logic := '1';
signal pdti_tvalid : std_logic := '1';
-----------------------------------------------------------------------------
-- Output Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
-----------------------------------------------------------------------------
-- tuser[63:0]    = timestamp[63:0]
-- tuser[71:64]   = Gate Positions  (in this case only 64 is required)
-- tuser[79:72]   = Sync Positions  (in this case only 72 is required)    
-- tuser[87:80]   = PPS  Positions  (in this case only 80 is required)
-- tuser[92:88]   = Samples/Cycle
-- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
-- tuser[95]      = Data Type 0 = Real 1 = I/Q
-- tuser[103:96]  = channel[7:0] 
-- tuser[127:104] = Reserved 
-- tdata[15:0]    = real = Real , IQ = I
-- tdata[31:16]   = real = Duplicate Real or 0 , IQ = Q
signal m_axis_pdti_tdata  : std_logic_vector(31 downto 0) := (others => '0');  
signal m_axis_pdti_tuser  : std_logic_vector(127 downto 0) := (others => '0');
signal m_axis_pdti_tvalid : std_logic := '0';

signal sat                : std_logic := '0';      
signal gate               : std_logic := '0';
signal valid              : std_logic := '0';
signal valid_cntr         : integer := 0;
--------------------------------------------------------------------------------

begin
valid <= gate and m_axis_pdti_tvalid;

uut: px_axis_intfir32_1
generic map(
num_chan => num_chan,
out_res => out_res,
bypass_in_lower => true
)
port map ( 
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

   -----------------------------------------------------------------------------
   -- Input Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------
   aclk                => aclk,   
   aresetn             => aresetn,
   -- tuser[63:0]    = timestamp[63:0]
   -- tuser[71:64]   = Gate Positions  (in this case only 64 is required)
   -- tuser[79:72]   = Sync Positions  (in this case only 72 is required)    
   -- tuser[87:80]   = PPS  Positions  (in this case only 80 is required)
   -- tuser[92:88]   = Samples/Cycle
   -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
   -- tuser[95]      = Data Type 0 = Real 1 = I/Q
   -- tuser[103:96]  = channel[7:0] 
   -- tuser[127:104] = Reserved 
   -- tdata[15:0]    = real = Real , IQ = I
   -- tdata[31:16]   = real = Duplicate Real or 0 , IQ = Q
   s_axis_pdti_tdata   => s_axis_pdti_tdata,  
   s_axis_pdti_tuser   => s_axis_pdti_tuser,  
   s_axis_pdti_tvalid  => s_axis_pdti_tvalid, 
   -----------------------------------------------------------------------------
   -- Output Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------
   -- tuser[63:0]    = timestamp[63:0]
   -- tuser[71:64]   = Gate Positions  (in this case only 64 is required)
   -- tuser[79:72]   = Sync Positions  (in this case only 72 is required)    
   -- tuser[87:80]   = PPS  Positions  (in this case only 80 is required)
   -- tuser[92:88]   = Samples/Cycle
   -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
   -- tuser[95]      = Data Type 0 = Real 1 = I/Q
   -- tuser[103:96]  = channel[7:0] 
   -- tuser[127:104] = Reserved 
   -- tdata[15:0]    = real = Real , IQ = I
   -- tdata[31:16]   = real = Duplicate Real or 0 , IQ = Q
   m_axis_pdti_tdata  => m_axis_pdti_tdata, 
   m_axis_pdti_tuser  => m_axis_pdti_tuser, 
   m_axis_pdti_tvalid => m_axis_pdti_tvalid,
   
   sat                => sat   

);

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
        aclk <= not aclk;
        wait for clkperiod;
    end loop;
end process;

process(aclk)
begin
   if rising_edge(aclk) then
     if valid_cntr = 0 then
        pdti_tvalid <= '1';
     else
        pdti_tvalid <= '0';
     end if;   
     if (valid_cntr = ((interpolation*in_rate_reduce)-1)) then
        valid_cntr <= 0;
     else
        valid_cntr <= valid_cntr + 1;
     end if;   
     --pdti_tvalid <= valid_cntr(0) and valid_cntr(1) and valid_cntr(2);
   end if;
end process;   

process(aclk)
begin
   if rising_edge(aclk) then
      if s_axis_pdti_tvalid = '1' then
         s_axis_pdti_tuser(63 downto 0) <= s_axis_pdti_tuser(63 downto 0) + 1;
      end if;
   end if;
end process;   

tst_sine : tb_dds
  PORT MAP (
    aclk                => aclk,
    aresetn             => aresetn,
    s_axis_phase_tvalid => pdti_tvalid,
    s_axis_phase_tdata  => sine_ph_incr,
    m_axis_data_tvalid  => s_axis_pdti_tvalid,
    m_axis_data_tdata   => s_axis_pdti_tdata(15 downto 0)
  );

test_process: process
variable c_time : time    := 0 ns;
variable d_time : time    := 0 ns;
variable x      : integer := 5;
variable bram_addr : std_logic_vector(12 downto 0) := ('0' & x"000");
begin
   wait for 400 ns;
   wait until rising_edge(s_axi_csr_aclk);
   gate <= '0';
   s_axi_csr_aresetn <= '1';
   aresetn <= '1';
   wait for 40 ns;
   c_time := now;
   -----------------------------------------------------------------------------
   -- Set up Control Registers
   -----------------------------------------------------------------------------
      assert false
      report "Writing to Interpolation Register. Start Time = " & time'image(now) 
      severity NOTE;
      px_axi_lite_writer(INTERP_REGISTER,(conv_std_logic_vector(in_rate_reduce-1,16) & conv_std_logic_vector(interpolation-1,16)), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      --px_axi_lite_writer(INTERP_REGISTER,(conv_std_logic_vector(interpolation-1,32)), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);


      d_time := now - c_time; 
      assert false
      report "Finished Writing to Interpolation Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE; 
      
      c_time := now;   
      assert false
      report "Writing to Gain Register. Start Time = " & time'image(now) 
      severity NOTE;
      px_axi_lite_writer(GAIN_REGISTER,conv_std_logic_vector(gain,32), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      d_time := now - c_time; 
      assert false
      report "Finished Writing to Gain Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE; 
       
      c_time := now;
      assert false
      report "Writing to Control Register. Start Time = " & time'image(now) 
      severity NOTE;
      px_axi_lite_writer(CTL_REGISTER,("0000000000000000000000000000000" & ddc_enable), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      d_time := now - c_time; 
      assert false
      report "Finished Writing to Control Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;       
      
   
      c_time := now; 
      assert false
      report "Reading Back and Verifying Interpolation Register. Start Time = " & time'image(now) 
      severity NOTE;    
      px_axi_lite_reader(INTERP_REGISTER, (conv_std_logic_vector(in_rate_reduce-1,16) & conv_std_logic_vector(interpolation-1,16)),'1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
      --px_axi_lite_reader(INTERP_REGISTER, (conv_std_logic_vector(interpolation-1,32)),'1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
      d_time := now - c_time; 
      assert false
      report "Finished Reading and verifying the Interpolation Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;  
  
      c_time := now; 
      assert false
      report "Reading Back and Verifying Gain Register. Start Time = " & time'image(now) 
      severity NOTE;    
      px_axi_lite_reader(GAIN_REGISTER, conv_std_logic_vector(gain,32),'1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready); 
      d_time := now - c_time; 
      assert false
      report "Finished Reading and verifying the Gain Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE; 
      
      c_time := now; 
      assert false
      report "Reading Back and Verifying Control Register. Start Time = " & time'image(now) 
      severity NOTE;    
      px_axi_lite_reader(CTL_REGISTER,("0000000000000000000000000000000" & ddc_enable),'1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready); 
      d_time := now - c_time; 
      assert false
      report "Finished Reading and verifying the Control Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;    
      
   -----------------------------------------------------------------------------
   -- Set up Coefficient RAM
   -----------------------------------------------------------------------------
   c_time := now;   
   assert false
   report "Writing to Coefficients RAM. Start Time = " & time'image(now) 
   severity NOTE;
   for i in 0 to ((interpolation*32)-1) loop
      bram_addr := ('1' & x"000") + conv_std_logic_vector(i*4,13);
      if (interpolation = 4) then
      px_axi_lite_writer(bram_addr,conv_std_logic_vector(int4coef(i)*64, 32), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      else
      px_axi_lite_writer(bram_addr,conv_std_logic_vector(int2coef(i)*64, 32), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);      
      end if;
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
   px_axi_lite_writer(LOAD_REGISTER,x"00000001", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
   px_axi_lite_writer(LOAD_REGISTER,x"00000000", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
   d_time := now - c_time; 
   assert false
   report "Finished Toggling Filter Coefficient Load. End Time = " & time'image(now) 
   severity NOTE;
   assert false
   report "Total Time = " & time'image(d_time) 
   severity NOTE; 
   
   wait for 7 us;
   wait until (s_axis_pdti_tvalid = '1');
   s_axis_pdti_tuser(64) <= '1'; 
   s_axis_pdti_tdata(31 downto 16) <= x"7FFF";
   gate <= '1';  
   wait until rising_edge(aclk);
   s_axis_pdti_tuser(64) <= '0'; 
   s_axis_pdti_tdata(31 downto 16) <= x"0000";
   wait for 10 us;
   assert false
   report "Test Complete, Not A Failure." 
   severity FAILURE;
end process;  

end Behavioral;
