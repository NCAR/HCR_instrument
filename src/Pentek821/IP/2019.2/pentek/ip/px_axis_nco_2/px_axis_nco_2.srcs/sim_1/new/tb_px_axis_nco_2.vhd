----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/18/2016 01:24:55 PM
-- Design Name: 
-- Module Name: tb_px_axis_nco_1 - Behavioral
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

entity tb_px_axis_nco_2 is
generic (
   num_bits : integer  := 18; -- 16 to 20
   clk_freq : real := 250.0;  -- MHz (must have decimal point (1/2 of sample clock)
   out_freq : real := 25.0 -- MHz (must have decimal point  
);
end tb_px_axis_nco_2;

architecture Behavioral of tb_px_axis_nco_2 is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------
component px_axis_nco_2 is
generic (
   num_bits : integer  := 18 -- 16 to 20
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
   -----------------------------------------------------------------------------
   -- Input Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------
   -- Requires 16-bit data streams
 
   -- Only s_axis_pdti_tvalid and s_axis_pdti_tuser(72) (SYNC) are used
   aclk                : in  std_logic;
   aresetn             : in  std_logic;
   -- tuser[63:0]    = timestamp[63:0]
   -- tuser[71:64]   = Gate Positions  (in this case only 64 is required)
   -- tuser[79:72]   = Sync Positions  (in this case only 72 is required)    
   -- tuser[87:80]   = PPS  Positions  (in this case only 80 is required)
   -- tuser[91:88]   = Samples/Cycle
   -- tuser[92]      = IQ of first sample in data 0 = I, 1 = Q
   -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
   -- tuser[95]      = Data Type 0 = Real 1 = I/Q
   -- tuser[103:96]  = channel[7:0] 
   -- tuser[127:104] = Reserved 
   s_axis_pdti_tdata  : in  std_logic_vector(31 downto 0);  
   s_axis_pdti_tuser  : in  std_logic_vector(127 downto 0);
   s_axis_pdti_tvalid : in  std_logic;
   -----------------------------------------------------------------------------
   -- Output Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------
   -- I is in lower portion of word
   -- I = Cosine, Q = -Sine
   -- tdata = Q,I
   m_axis_pd_tdata     : out std_logic_vector((2*((((num_bits+7)/8)*8)*2))-1 downto 0);  
   m_axis_pd_tvalid    : out std_logic     
);
end component px_axis_nco_2;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

   ----------------------------------------------------------------------------
   -- AXI4-Lite Control/Status Interface
   ----------------------------------------------------------------------------
signal s_axi_csr_aclk      : std_logic := '0';
signal s_axi_csr_aresetn   : std_logic := '0';
signal s_axi_csr_awaddr    : std_logic_vector(6 downto 0) := (others => '0');
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
signal s_axi_csr_araddr    : std_logic_vector(6 downto 0) := (others => '0');
signal s_axi_csr_arprot    : std_logic_vector(2 downto 0) := (others => '0');
signal s_axi_csr_arvalid   : std_logic := '0';
signal s_axi_csr_arready   : std_logic := '0';
signal s_axi_csr_rdata     : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_csr_rresp     : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_csr_rvalid    : std_logic := '0';
signal s_axi_csr_rready    : std_logic := '0';
   -----------------------------------------------------------------------------
   -- Input Timing Event Stream (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------
   -- Requires 16-bit data streams
   -- Dual 4 or single 8 Sample per cycle
signal s_axis_pdti_tdata   : std_logic_vector(31 downto 0) := (others => '0'); 
signal s_axis_pdti_tuser   : std_logic_vector(127 downto 0) := (others => '0');
signal s_axis_pdti_tvalid  : std_logic := '1';
signal aclk                : std_logic := '0';
signal aresetn             : std_logic := '0';
   -----------------------------------------------------------------------------
   -- Output Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------
   -- If greater than 16, value is sign extended to 24 bits
   -- I is in lower portion of word
   -- I = Cosine, Q = -Sine
   -- tdata = Q,I
signal m_axis_pd_tdata     : std_logic_vector((2*((((num_bits+7)/8)*8)*2))-1 downto 0) := (others => '0');  
signal m_axis_pd_tvalid    : std_logic := '0';     

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------



constant clkperiod : time := (1.0/clk_freq) * 1 us;
constant freq_ratio : real := (out_freq/(clk_freq*2.0));
constant freq : real := ((2147483648.0 * freq_ratio) * 2.0);
constant freq_int : integer := integer(freq);

--------------------------------------------------------------------------------

begin

-- generate clocks

-- ACLK Clock
process
begin
    loop
        aclk <= not aclk;
        wait for clkperiod/2;
    end loop;
end process;

process
begin
   loop
      s_axi_csr_aclk <= not s_axi_csr_aclk;
      wait for 2 ns;
   end loop;
end process;

uut: px_axis_nco_2
generic map (
   num_bits => num_bits -- 16 to 20
)
port map( 
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
   -- Input Timing Event Stream (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------
   -- Requires 16-bit data streams
   -- Single Sample per cycle
   aclk                => aclk,   
   aresetn             => aresetn,
   s_axis_pdti_tdata   => s_axis_pdti_tdata, 
   s_axis_pdti_tuser   => s_axis_pdti_tuser, 
   s_axis_pdti_tvalid  => s_axis_pdti_tvalid,
   -----------------------------------------------------------------------------
   -- Output Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
   -----------------------------------------------------------------------------
   -- If greater than 16, value is sign extended to 24 bits
   -- I is in lower portion of word
   -- I = Cosine, Q = -Sine
   -- tdata = Q,I
   m_axis_pd_tdata      => m_axis_pd_tdata, 
   m_axis_pd_tvalid     => m_axis_pd_tvalid
);

test_process: process
variable c_time : time    := 0 ns;
variable d_time : time    := 0 ns;
variable dat      : std_logic_vector(31 downto 0) := x"00000000";
begin
   wait for 100 ns;
   wait until rising_edge(s_axi_csr_aclk);
   s_axi_csr_aresetn <= '1';
   aresetn <= '1';
   wait for 40 ns;
   c_time := now;
   -----------------------------------------------------------------------------
   -- Set up Control Registers
   -----------------------------------------------------------------------------
      assert false
      report "Writing to Control Register.  Setting for Sync Load and reset.  Start Time = " & time'image(now) 
      severity NOTE;
      px_axi_lite_writer("0001000",x"00000003", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      d_time := now - c_time; 
      assert false
      report "Finished Writing to Control Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Writing to Frequency Register.  Start Time = " & time'image(now) 
      severity NOTE;
      px_axi_lite_writer("0000000",conv_std_logic_vector(freq_int,32), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      d_time := now - c_time; 
      assert false
      report "Finished Writing to Frequency Register. End Time = " & time'image(now) 
      severity NOTE;
      report "Writing to Offset Register.  Start Time = " & time'image(now) 
      severity NOTE;
      px_axi_lite_writer("0000100",x"00000000", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      d_time := now - c_time; 
      assert false
      report "Finished Writing to Offset Register. End Time = " & time'image(now) 
      severity NOTE;
      wait for 200 ns;
      wait until rising_edge(aclk); -- Sync and load NCO
      wait for 1 ns;
      s_axis_pdti_tuser(72) <= '1';
      wait until rising_edge(aclk);
      wait for 1 ns;
      s_axis_pdti_tuser(72) <= '0';
      wait for 10.45 us;
      wait until rising_edge(aclk); -- Resync NCO again
      wait for 1 ns;
      s_axis_pdti_tuser(73) <= '1';
      wait until rising_edge(aclk);
      wait for 1 ns;
      s_axis_pdti_tuser(73) <= '0';
      
   wait for 10 us;
   assert false
   report "Test Complete, Not A Failure." 
   severity FAILURE;
end process;   


end Behavioral;
