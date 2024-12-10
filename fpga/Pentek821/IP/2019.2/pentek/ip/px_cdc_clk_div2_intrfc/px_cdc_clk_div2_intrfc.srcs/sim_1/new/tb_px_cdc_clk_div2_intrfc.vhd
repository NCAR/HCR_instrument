----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/30/2016 12:28:50 PM
-- Design Name: 
-- Module Name: tb_px_cdc_clk_intrfc - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_px_cdc_clk_intrfc is
--  Port ( );
end tb_px_cdc_clk_intrfc;

architecture Behavioral of tb_px_cdc_clk_intrfc is

component px_cdc_clk_div2_intrfc
generic(
   differential_term        : string := "TERM_100"; -- "TERM_100" or "TERM_NONE"
   ibuf_low_pwr             : boolean := false;
   initial_led_mode         : integer := 0;
   invert_in_clk            : boolean := true 
);
port (
----------------------------------------------------------------------------
-- Control/Status Registers (AXI4-LITE)
----------------------------------------------------------------------------
-- associated with s_axi_csr_aclk
   s_axi_csr_aclk           : in  std_logic;
   s_axi_csr_aresetn        : in  std_logic;
   s_axi_csr_awaddr         : in  std_logic_vector(4 downto 0);
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
   s_axi_csr_araddr         : in  std_logic_vector(4 downto 0);
   s_axi_csr_arprot         : in  std_logic_vector(2 downto 0);
   s_axi_csr_arvalid        : in  std_logic;
   s_axi_csr_arready        : out std_logic;
   s_axi_csr_rdata          : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp          : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid         : out std_logic;
   s_axi_csr_rready         : in  std_logic;
    
   irq                      : out std_logic; -- Interrupt out (overload)
   
   ----------------------------------------------------------------------------
   -- Status Input Signals
   ----------------------------------------------------------------------------
   cdc_stat_vcxo            : in  std_logic;
   cdc_stat_ref             : in  std_logic;
   cdc_stat_lock            : in  std_logic;
----------------------------------------------------------------------------
-- Clock Input from CDCM7005
----------------------------------------------------------------------------
   clk_in_p                 : in std_logic;
   clk_in_n                 : in std_logic;   
----------------------------------------------------------------------------
-- Frequency Counter Ref Clock
----------------------------------------------------------------------------
   refclk                   : in std_logic;   -- 200MHz Reference Clock
----------------------------------------------------------------------------
-- Clock Output
----------------------------------------------------------------------------
   div2_sample_clk          : out std_logic;
-----------------------------------------------------------------------------
-- LED Drive
-----------------------------------------------------------------------------
   led_n                    : out std_logic;
   clk_good                 : out std_logic
 );
 end component;
 
signal s_axi_csr_aclk           : std_logic := '0';
signal s_axi_csr_aresetn        : std_logic := '0';
signal s_axi_csr_awaddr         : std_logic_vector(4 downto 0) := (others => '0');
signal s_axi_csr_awprot         : std_logic_vector(2 downto 0) := (others => '0');
signal s_axi_csr_awvalid        : std_logic := '0';
signal s_axi_csr_awready        : std_logic := '0';
signal s_axi_csr_wdata          : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_csr_wstrb          : std_logic_vector(3 downto 0) := (others => '0');
signal s_axi_csr_wvalid         : std_logic := '0';
signal s_axi_csr_wready         : std_logic := '0';
signal s_axi_csr_bresp          : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_csr_bvalid         : std_logic := '0';
signal s_axi_csr_bready         : std_logic := '0';
signal s_axi_csr_araddr         : std_logic_vector(4 downto 0) := (others => '0');
signal s_axi_csr_arprot         : std_logic_vector(2 downto 0) := (others => '0');
signal s_axi_csr_arvalid        : std_logic := '0';
signal s_axi_csr_arready        : std_logic := '0';
signal s_axi_csr_rdata          : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_csr_rresp          : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_csr_rvalid         : std_logic := '0';
signal s_axi_csr_rready         : std_logic := '0';
  
signal irq                      :  std_logic := '0'; -- Interrupt out (overload)
 
 ----------------------------------------------------------------------------
 -- Status Input Signals
 ----------------------------------------------------------------------------
signal  cdc_stat_vcxo            : std_logic := '0';
signal  cdc_stat_ref             : std_logic := '0';
signal  cdc_stat_lock            : std_logic := '0';
----------------------------------------------------------------------------
-- Clock Input from CDCM7005
----------------------------------------------------------------------------
signal  clk_in_p                 : std_logic := '0';
signal  clk_in_n                 : std_logic := '0';   
----------------------------------------------------------------------------
-- Frequency Counter Ref Clock
----------------------------------------------------------------------------
signal  refclk                   : std_logic := '0';   -- 200MHz Reference Clock
----------------------------------------------------------------------------
-- Clock Output
----------------------------------------------------------------------------
signal  div2_sample_clk          : std_logic := '0';
-----------------------------------------------------------------------------
-- LED Drive
-----------------------------------------------------------------------------
signal  led_n                    : std_logic := '0';
signal  clk_good                 : std_logic := '0';

begin

uut: px_cdc_clk_div2_intrfc
generic map (
   differential_term        => "TERM_100", -- "TERM_100" or "TERM_NONE"
   ibuf_low_pwr             => false,
   initial_led_mode         => 0
)
port map (
----------------------------------------------------------------------------
-- Control/Status Registers (AXI4-LITE)
----------------------------------------------------------------------------
-- associated with s_axi_csr_aclk
   s_axi_csr_aclk          =>s_axi_csr_aclk,           
   s_axi_csr_aresetn       =>s_axi_csr_aresetn,        
   s_axi_csr_awaddr        =>s_axi_csr_awaddr,         
   s_axi_csr_awprot        =>s_axi_csr_awprot,         
   s_axi_csr_awvalid       =>s_axi_csr_awvalid,        
   s_axi_csr_awready       =>s_axi_csr_awready,        
   s_axi_csr_wdata         =>s_axi_csr_wdata,          
   s_axi_csr_wstrb         =>s_axi_csr_wstrb,          
   s_axi_csr_wvalid        =>s_axi_csr_wvalid,         
   s_axi_csr_wready        =>s_axi_csr_wready,         
   s_axi_csr_bresp         =>s_axi_csr_bresp,          
   s_axi_csr_bvalid        =>s_axi_csr_bvalid,         
   s_axi_csr_bready        =>s_axi_csr_bready,         
   s_axi_csr_araddr        =>s_axi_csr_araddr,         
   s_axi_csr_arprot        =>s_axi_csr_arprot,         
   s_axi_csr_arvalid       =>s_axi_csr_arvalid,        
   s_axi_csr_arready       =>s_axi_csr_arready,        
   s_axi_csr_rdata         =>s_axi_csr_rdata,          
   s_axi_csr_rresp         =>s_axi_csr_rresp,          
   s_axi_csr_rvalid        =>s_axi_csr_rvalid,         
   s_axi_csr_rready        =>s_axi_csr_rready,         

   irq                     =>irq,   
            
   ----------------------------------------------------------------------------
   -- Status Input Signals
   ----------------------------------------------------------------------------
   cdc_stat_vcxo           => cdc_stat_vcxo, 
   cdc_stat_ref            => cdc_stat_ref,  
   cdc_stat_lock           => cdc_stat_lock, 
----------------------------------------------------------------------------
-- Clock Input from CDCM7005
----------------------------------------------------------------------------
   clk_in_p                => clk_in_p, 
   clk_in_n                => clk_in_n,    
----------------------------------------------------------------------------
-- Frequency Counter Ref Clock
----------------------------------------------------------------------------
   refclk                  => refclk, 
----------------------------------------------------------------------------
-- Clock Output
----------------------------------------------------------------------------
   div2_sample_clk         => div2_sample_clk,
-----------------------------------------------------------------------------
-- LED Drive
-----------------------------------------------------------------------------
   led_n                   => led_n,   
   clk_good                => clk_good
 );


process
begin
   loop
      wait for 2.5 ns;
      refclk <= not refclk;
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
   wait for 200 ns;
   s_axi_csr_aresetn <= '1';
   wait for 200 ns;
   for i in 0 to 400 loop
      wait for 2.5 ns;
      clk_in_p <= not clk_in_p;
   end loop;
   wait for 200 ns;
   for i in 0 to 100 loop
      wait for 50 ns;
      clk_in_p <= not clk_in_p;
   end loop;
   wait for 600 ns;
   for i in 0 to 1000 loop
      wait for 1.5 ns;
      clk_in_p <= not clk_in_p;
   end loop;
   wait;
end process;

clk_in_n <= not clk_in_p; 

end Behavioral;
