----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/10/2017 11:10:08 PM
-- Design Name: 
-- Module Name: tb_px_clock_frq_cntr - Behavioral
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

entity tb_px_clock_frq_cntr is
--  Port ( );
end tb_px_clock_frq_cntr;

architecture Behavioral of tb_px_clock_frq_cntr is

component px_clock_frq_cntr
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
----------------------------------------------------------------------------
-- Clock Input 
----------------------------------------------------------------------------
   clk_in                   : in std_logic;
   resetn                   : in std_logic; -- associated with clk_in
----------------------------------------------------------------------------
-- Frequency Counter Ref Clock
----------------------------------------------------------------------------
   ref_250mhz_clk           : in std_logic   -- 250MHz Reference Clock
 );
 end component;

signal  s_axi_csr_aclk           : std_logic := '0';
signal  s_axi_csr_aresetn        : std_logic := '0';
signal  s_axi_csr_awaddr         : std_logic_vector(11 downto 0) := (others => '0');
signal  s_axi_csr_awprot         : std_logic_vector(2 downto 0) := (others => '0');
signal  s_axi_csr_awvalid        : std_logic := '0';
signal  s_axi_csr_awready        : std_logic := '0';
signal  s_axi_csr_wdata          : std_logic_vector(31 downto 0) := (others => '0');
signal  s_axi_csr_wstrb          : std_logic_vector(3 downto 0) := (others => '0');
signal  s_axi_csr_wvalid         : std_logic := '0';
signal  s_axi_csr_wready         : std_logic := '0';
signal  s_axi_csr_bresp          : std_logic_vector(1 downto 0) := (others => '0');
signal  s_axi_csr_bvalid         : std_logic := '0';
signal  s_axi_csr_bready         : std_logic := '0';
signal  s_axi_csr_araddr         : std_logic_vector(11 downto 0) := (others => '0');
signal  s_axi_csr_arprot         : std_logic_vector(2 downto 0) := (others => '0');
signal  s_axi_csr_arvalid        : std_logic := '0';
signal  s_axi_csr_arready        : std_logic := '0';
signal  s_axi_csr_rdata          : std_logic_vector(31 downto 0) := (others => '0');
signal  s_axi_csr_rresp          : std_logic_vector(1 downto 0) := (others => '0');
signal  s_axi_csr_rvalid         : std_logic := '0';
signal  s_axi_csr_rready         : std_logic := '0';  
----------------------------------------------------------------------------
-- Clock Input 
----------------------------------------------------------------------------
signal  clk_in                   : std_logic := '0';
signal  resetn                   : std_logic := '0'; -- associated with clk_in
----------------------------------------------------------------------------
-- Frequency Counter Ref Clock
----------------------------------------------------------------------------
signal   ref_250mhz_clk           : std_logic := '0';   -- 250MHz Reference Clock

begin

uut: px_clock_frq_cntr
port map (
----------------------------------------------------------------------------
-- Control/Status Registers (AXI4-LITE)
----------------------------------------------------------------------------
-- associated with s_axi_csr_aclk
   s_axi_csr_aclk       =>   s_axi_csr_aclk      ,
   s_axi_csr_aresetn    =>   s_axi_csr_aresetn   ,
   s_axi_csr_awaddr     =>   s_axi_csr_awaddr    ,
   s_axi_csr_awprot     =>   s_axi_csr_awprot    ,
   s_axi_csr_awvalid    =>   s_axi_csr_awvalid   ,
   s_axi_csr_awready    =>   s_axi_csr_awready   ,
   s_axi_csr_wdata      =>   s_axi_csr_wdata     ,
   s_axi_csr_wstrb      =>   s_axi_csr_wstrb     ,
   s_axi_csr_wvalid     =>   s_axi_csr_wvalid    ,
   s_axi_csr_wready     =>   s_axi_csr_wready    ,
   s_axi_csr_bresp      =>   s_axi_csr_bresp     ,
   s_axi_csr_bvalid     =>   s_axi_csr_bvalid    ,
   s_axi_csr_bready     =>   s_axi_csr_bready    ,
   s_axi_csr_araddr     =>   s_axi_csr_araddr    ,
   s_axi_csr_arprot     =>   s_axi_csr_arprot    ,
   s_axi_csr_arvalid    =>   s_axi_csr_arvalid   ,
   s_axi_csr_arready    =>   s_axi_csr_arready   ,
   s_axi_csr_rdata      =>   s_axi_csr_rdata     ,
   s_axi_csr_rresp      =>   s_axi_csr_rresp     ,
   s_axi_csr_rvalid     =>   s_axi_csr_rvalid    ,
   s_axi_csr_rready     =>   s_axi_csr_rready    ,
----------------------------------------------------------------------------
-- Clock Input 
----------------------------------------------------------------------------
    clk_in              =>       clk_in,  
    resetn              =>       resetn,    -- associated with clk_in
----------------------------------------------------------------------------
-- Frequency Counter Ref Clock
----------------------------------------------------------------------------
    ref_250mhz_clk      =>       ref_250mhz_clk  -- 250MHz Reference Clock
 );

process
begin
   loop
      wait for 2 ns;
      ref_250mhz_clk <= not ref_250mhz_clk;
   end loop;
end process;

process
begin
   loop
      wait for 2 ns;
      s_axi_csr_aclk <= not s_axi_csr_aclk;
   end loop;
end process;

process
begin
   loop
      wait for 2 ns;
      clk_in <= not clk_in;
   end loop;
end process;

test_process: process
variable c_time : time    := 0 ns;
variable d_time : time    := 0 ns;
variable dat      : std_logic_vector(31 downto 0) := x"00000000";
begin
   wait for 100 ns;
   wait until rising_edge(s_axi_csr_aclk);
   s_axi_csr_aresetn <= '1';
   resetn <= '1';
   wait for 4000 ns;
   c_time := now;
   -----------------------------------------------------------------------------
   -- Set up Control Registers
   -----------------------------------------------------------------------------
      assert false
      report "Reading Freq Register. Start Time = " & time'image(now) 
      severity NOTE;
      px_axi_lite_reader(
          x"004",
          x"00000000",
         '0',
         '0',  
        s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
      d_time := now - c_time; 
      assert false
      report "Finished Reading Freq Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE; 
   wait for 10 us;
   assert false
   report "Test Complete, Not A Failure." 
   severity FAILURE;
end process;   

end Behavioral;
