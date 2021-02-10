----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2016 12:39:46 PM
-- Design Name: 
-- Module Name: tb_px_2ch_dec2fir - Behavioral
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
--use std.textio.all;

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

entity tb_px_2ch_dec2fir is
generic (
   clk_freq : real := 450.0;  -- MHz
   data_freq : real := 1.0; -- MHz 
   out_res    : integer := 16;
   ddc_enable : std_logic := '1'
);
end tb_px_2ch_dec2fir;

architecture Behavioral of tb_px_2ch_dec2fir is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------
component px_2ch_dec2fir
generic (
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
    
    -- CH0(0) Q, CH0(0) I
    s_axis_pdti_tdata  : in  std_logic_vector(31 downto 0); 
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
    m_axis_pdti_tuser  : out std_logic_vector(127 downto 0); -- IQ, 16-bit, 1 sample/cycle
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
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

constant clkperiod : time := ((1.0/clk_freq)/2.0) * 1 us;
constant sine_ph : real := (data_freq/clk_freq) * 4294967296.0;
constant sine_ph_incr : std_logic_vector(31 downto 0) := conv_std_logic_vector(integer(sine_ph), 32);
constant GAIN_REGISTER       : std_logic_vector(12 downto 0) := "0000000000100";
constant CTL_REGISTER        : std_logic_vector(12 downto 0) := "0000000001000";
constant gain                : integer := 3500;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------
signal sat                   : std_logic := '0';
signal s_axi_csr_aclk        : std_logic := '0';
signal aclk                  : std_logic := '0';
signal aresetn               : std_logic := '0';
-- Q,I
signal   s_axis_pdti_tdata  : std_logic_vector(31 downto 0) := (others => '0'); 
signal   s_axis_pdti_tuser  : std_logic_vector(127 downto 0) := (others => '0'); -- IQ, 16-bit, 1 sample/cycle  
signal   s_axis_pdti_tvalid : std_logic := '0';
   -----------------------------------------------------------------------------
   -- Output Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------
   
-- Q,I
signal   m_axis_pdti_tdata  : std_logic_vector((2*out_res)-1 downto 0);  
signal   m_axis_pdti_tuser  : std_logic_vector(127 downto 0); -- IQ, 16-bit, 1 sample/cycle
signal   m_axis_pdti_tvalid : std_logic;

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
signal dvcntr              : std_logic_vector(7 downto 0) := (others => '0');
signal irq : std_logic;
--------------------------------------------------------------------------------

begin

uut: px_2ch_dec2fir
generic map(
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

   s_axis_pdti_tdata   => s_axis_pdti_tdata,  
   s_axis_pdti_tuser   => s_axis_pdti_tuser,  
   s_axis_pdti_tvalid  => s_axis_pdti_tvalid, 
   -----------------------------------------------------------------------------
   -- Output Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------

   m_axis_pdti_tdata  => m_axis_pdti_tdata, 
   m_axis_pdti_tuser  => m_axis_pdti_tuser, 
   m_axis_pdti_tvalid => m_axis_pdti_tvalid,
   
   sat                => sat   

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

process(aclk)
begin
   if rising_edge(aclk) then
      if s_axis_pdti_tvalid = '1' then
         s_axis_pdti_tuser(63 downto 0) <= s_axis_pdti_tuser(63 downto 0) + 1;
      end if;
   end if;
end process;   

process(aclk)
begin
   if rising_edge(aclk) then
   dvcntr <= dvcntr + 1;
   --s_axis_pdti_tvalid <=  dvcntr(1) and dvcntr(0);
   --s_axis_pdti_tvalid <= not s_axis_pdti_tvalid;
     s_axis_pdti_tvalid <= '1';
   end if;
end process;   

tst_sine : tb_dds
  PORT MAP (
    aclk => aclk,
    aresetn => aresetn,
    s_axis_phase_tvalid => s_axis_pdti_tvalid,
    s_axis_phase_tdata => sine_ph_incr,
    m_axis_data_tvalid => open,
    m_axis_data_tdata => s_axis_pdti_tdata(31 downto 0)
  );


test_process: process
variable c_time : time    := 0 ns;
variable d_time : time    := 0 ns;
variable x      : integer := 5;
variable bram_addr : std_logic_vector(12 downto 0) := ('0' & x"000");
begin
   wait for 400 ns;
   wait until rising_edge(s_axi_csr_aclk);
   --gate <= '0';
   s_axi_csr_aresetn <= '1';
   aresetn <= '1';
   wait for 40 ns;
   c_time := now;
   -----------------------------------------------------------------------------
   -- Set up Control Registers
   -----------------------------------------------------------------------------
 
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
--      px_axi_lite_writer("0000000001100",x"00000001", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
--      d_time := now - c_time; 
--      assert false
--      report "Toggle Start Coefficient Load. End Time = " & time'image(now) 
--      severity NOTE;
--      px_axi_lite_writer("0000000001100",x"00000000", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
--      d_time := now - c_time; 
--      assert false
--      report "Toggle Start Coefficient Load. End Time = " & time'image(now) 
--      severity NOTE;
      wait for 1 us;
--      px_axi_lite_writer("0000000001100",x"00000001", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
--            d_time := now - c_time; 
--            assert false
--            report "Toggle Start Coefficient Load. End Time = " & time'image(now) 
--            severity NOTE;      
      wait until rising_edge(aclk) and (s_axis_pdti_tvalid = '1');
      wait for 0.5 ns;
      --s_axis_pdti_tuser(72) <= '1';
      wait until rising_edge(aclk) and (s_axis_pdti_tvalid = '1');
      wait for 0.5 ns;
      s_axis_pdti_tuser(72) <= '1';
      --s_axis_pdti_tuser(72) <= '0';
      --s_axis_pdti_tdata(15 downto 0) <= x"7FFF";
      wait until rising_edge(aclk) and (s_axis_pdti_tvalid = '1');
      wait for 0.5 ns;
      --s_axis_pdti_tuser(72) <= '1';
      s_axis_pdti_tuser(72) <= '0';
      --s_axis_pdti_tdata(15 downto 0) <= x"0000"; 
      wait until rising_edge(aclk) and (s_axis_pdti_tvalid = '1');
      wait for 0.5 ns;
      s_axis_pdti_tuser(72) <= '0';
   wait for 7 us;
   --gate <= '1';  
   wait for 10 us;
   assert false
   report "Test Complete, Not A Failure." 
   severity FAILURE;
end process;  



end Behavioral;
