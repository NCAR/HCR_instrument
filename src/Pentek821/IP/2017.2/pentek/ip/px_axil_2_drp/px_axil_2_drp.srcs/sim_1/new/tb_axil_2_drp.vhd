----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/28/2017 12:31:47 PM
-- Design Name: 
-- Module Name: tb_axil_2_drp - Behavioral
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

entity tb_axil_2_drp is
generic (
   axi_addr_bits : integer := 12; -- up to 32
   drp_bytes     : integer := 2;  -- 2 or 4
   drp_addr_bits : integer := 10  -- up to 30
);
end tb_axil_2_drp;

architecture Behavioral of tb_axil_2_drp is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

component px_axil_2_drp
generic (
   axi_addr_bits : integer := 12; -- up to 32
   drp_bytes     : integer := 2;  -- 2 or 4
   drp_addr_bits : integer := 10  -- up to 30
);
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
--------------------------------------------------------------------------------
    s_axi_aclk      : in  std_logic;
    s_axi_aresetn   : in  std_logic;
    s_axi_awaddr    : in  std_logic_vector(axi_addr_bits-1 downto 0); -- byte address
    s_axi_awprot    : in  std_logic_vector(2 downto 0); -- not used
    s_axi_awvalid   : in  std_logic;
    s_axi_awready   : out std_logic;
    s_axi_wdata     : in  std_logic_vector(31 downto 0);
    s_axi_wstrb     : in  std_logic_vector(3 downto 0); -- not used
    s_axi_wvalid    : in  std_logic;
    s_axi_wready    : out std_logic;
    s_axi_bresp     : out std_logic_vector(1 downto 0);
    s_axi_bvalid    : out std_logic;
    s_axi_bready    : in  std_logic;
    s_axi_araddr    : in  std_logic_vector(11 downto 0);
    s_axi_arprot    : in  std_logic_vector(2 downto 0); -- not used
    s_axi_arvalid   : in  std_logic;
    s_axi_arready   : out std_logic;
    s_axi_rdata     : out std_logic_vector(31 downto 0);
    s_axi_rresp     : out std_logic_vector(1 downto 0);
    s_axi_rvalid    : out std_logic;
    s_axi_rready    : in  std_logic;
--------------------------------------------------------------------------------
-- DRP Port 
--------------------------------------------------------------------------------   
    drpclk          : in  std_logic;
    drpaddr         : out std_logic_vector(drp_addr_bits-1 downto 0);
    drpdi           : out std_logic_vector((drp_bytes*8)-1 downto 0);
    drpen           : out std_logic;
    drpwe           : out std_logic;
    drpdo           : in  std_logic_vector((drp_bytes*8)-1 downto 0);
    drprdy          : in  std_logic 
);
end component px_axil_2_drp;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
--------------------------------------------------------------------------------
signal s_axi_aclk      : std_logic := '0';
signal s_axi_aresetn   : std_logic := '0';
signal s_axi_awaddr    : std_logic_vector(axi_addr_bits-1 downto 0) := (others => '0'); -- byte address
signal s_axi_awprot    : std_logic_vector(2 downto 0) := (others => '0'); -- not used
signal s_axi_awvalid   : std_logic := '0';
signal s_axi_awready   : std_logic := '0';
signal s_axi_wdata     : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_wstrb     : std_logic_vector(3 downto 0) := (others => '0'); -- not used
signal s_axi_wvalid    : std_logic := '0';
signal s_axi_wready    : std_logic := '0';
signal s_axi_bresp     : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_bvalid    : std_logic := '0';
signal s_axi_bready    : std_logic := '0';
signal s_axi_araddr    : std_logic_vector(11 downto 0) := (others => '0');
signal s_axi_arprot    : std_logic_vector(2 downto 0) := (others => '0'); -- not used
signal s_axi_arvalid   : std_logic := '0';
signal s_axi_arready   : std_logic := '0';
signal s_axi_rdata     : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_rresp     : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_rvalid    : std_logic := '0';
signal s_axi_rready    : std_logic := '0';
--------------------------------------------------------------------------------
-- DRP Port 
--------------------------------------------------------------------------------   
signal drpclk          : std_logic := '0';
signal drpaddr         : std_logic_vector(drp_addr_bits-1 downto 0) := (others => '0');
signal drpdi           : std_logic_vector((drp_bytes*8)-1 downto 0) := (others => '0');
signal drpen           : std_logic := '0';
signal drpwe           : std_logic := '0';
signal drpdo           : std_logic_vector((drp_bytes*8)-1 downto 0) := (others => '0');
signal drprdy          : std_logic := '0'; 

--------------------------------------------------------------------------------

begin

uut: px_axil_2_drp
generic map (
   axi_addr_bits => axi_addr_bits, -- up to 32
   drp_bytes     => drp_bytes, -- 2 or 4
   drp_addr_bits => drp_addr_bits  -- up to 30
)
port map(
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
--------------------------------------------------------------------------------
    s_axi_aclk      => s_axi_aclk,     
    s_axi_aresetn   => s_axi_aresetn,  
    s_axi_awaddr    => s_axi_awaddr,   
    s_axi_awprot    => s_axi_awprot,   
    s_axi_awvalid   => s_axi_awvalid,  
    s_axi_awready   => s_axi_awready,  
    s_axi_wdata     => s_axi_wdata,    
    s_axi_wstrb     => s_axi_wstrb,    
    s_axi_wvalid    => s_axi_wvalid,   
    s_axi_wready    => s_axi_wready,   
    s_axi_bresp     => s_axi_bresp,    
    s_axi_bvalid    => s_axi_bvalid,   
    s_axi_bready    => s_axi_bready,   
    s_axi_araddr    => s_axi_araddr,   
    s_axi_arprot    => s_axi_arprot,   
    s_axi_arvalid   => s_axi_arvalid,  
    s_axi_arready   => s_axi_arready,  
    s_axi_rdata     => s_axi_rdata,    
    s_axi_rresp     => s_axi_rresp,    
    s_axi_rvalid    => s_axi_rvalid,   
    s_axi_rready    => s_axi_rready,   
--------------------------------------------------------------------------------
-- DRP Port 
--------------------------------------------------------------------------------   
    drpclk          => drpclk,  
    drpaddr         => drpaddr, 
    drpdi           => drpdi,   
    drpen           => drpen,   
    drpwe           => drpwe,   
    drpdo           => drpdo,   
    drprdy          => drprdy  
);


process
begin
   loop
      wait for 2 ns;
      s_axi_aclk <= not s_axi_aclk;
   end loop;
end process;

process
begin
   loop
      wait for 10 ns;
      drpclk <= not drpclk;
   end loop;
end process;

--------------------------------------------------------------------------------
-- DRP port sim
--------------------------------------------------------------------------------

drp_proc: process
begin
   drprdy <= '0';
   loop
   while (drpen = '0') loop
      wait until rising_edge(drpclk);
   end loop;   
   wait until rising_edge(drpclk);
   wait until rising_edge(drpclk);
   drprdy <= '1';
   drpdo  <= conv_std_logic_vector(conv_integer(drpaddr),drp_bytes*8);
   if (drpwe = '1') then
      if drpdi((drp_bytes*8)-1 downto 0) = conv_std_logic_vector(conv_integer(drpaddr),drp_bytes*8) then
         assert false
         report "Write Value is: x" &  (px_std_logic_vector_to_hstring(drpdi)) & " Should be: x" &  (px_std_logic_vector_to_hstring(conv_std_logic_vector(conv_integer(drpaddr),drp_bytes*8)))
         severity NOTE;
      else
         assert false
         report "Write Failure.  Write Value is: x" &  (px_std_logic_vector_to_hstring(drpdi)) & " Should be: x" &  (px_std_logic_vector_to_hstring(conv_std_logic_vector(conv_integer(drpaddr),drp_bytes*8)))
         severity FAILURE;
      end if;   
   end if;
   wait until rising_edge(drpclk);
   drprdy <= '0';
   wait until rising_edge(drpclk);
   end loop;
end process;

--------------------------------------------------------------------------------
-- AXI-Lite port sim
--------------------------------------------------------------------------------
axil_proc: process
begin
   wait for 200 ns;
   s_axi_aresetn <= '1';
   wait for 100 ns;
   for i in 0 to 31 loop
      px_axi_lite_writer( conv_std_logic_vector(i*4, axi_addr_bits),conv_std_logic_vector(i, 32) , s_axi_aclk, s_axi_awaddr, s_axi_awprot, s_axi_awvalid, s_axi_awready, s_axi_wdata, s_axi_wstrb, s_axi_wvalid, s_axi_wready, s_axi_bresp, s_axi_bvalid, s_axi_bready);
   end loop;
   for i in 0 to 31 loop
      px_axi_lite_reader( conv_std_logic_vector(i*4, axi_addr_bits), conv_std_logic_vector(i, 32), '1', '1', s_axi_aclk, s_axi_araddr, s_axi_arprot, s_axi_arvalid, s_axi_arready, s_axi_rdata, s_axi_rresp, s_axi_rvalid, s_axi_rready);
   end loop;
   wait for 100 ns;
   assert false
   report "Test Complete. Not a Failure."
   severity FAILURE;
end process;
   
end Behavioral;
