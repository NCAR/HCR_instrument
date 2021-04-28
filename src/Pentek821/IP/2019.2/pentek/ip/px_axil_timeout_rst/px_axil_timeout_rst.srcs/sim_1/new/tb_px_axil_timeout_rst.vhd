----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/30/2016 03:36:42 PM
-- Design Name: 
-- Module Name: tb_px_axil_timeout_rst - Behavioral
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

entity tb_px_axil_timeout_rst is
--  Port ( );
end tb_px_axil_timeout_rst;

architecture Behavioral of tb_px_axil_timeout_rst is

component px_axil_timeout_rst 
generic (
   addr_bits     : integer := 12;
   timeout_count :integer := 2147483647
);
port ( 
----------------------------------------------------------------------------
-- Control/Status Registers (AXI4-LITE)
----------------------------------------------------------------------------
   axi_aclk             : in  std_logic;
   s_axi_aresetn        : in  std_logic;
   s_axi_awaddr         : in  std_logic_vector(addr_bits-1 downto 0);
   s_axi_awprot         : in  std_logic_vector(2 downto 0);
   s_axi_awvalid        : in  std_logic;
   s_axi_awready        : out std_logic;
   s_axi_wdata          : in  std_logic_vector(31 downto 0);
   s_axi_wstrb          : in  std_logic_vector(3 downto 0);
   s_axi_wvalid         : in  std_logic;
   s_axi_wready         : out std_logic;
   s_axi_bresp          : out std_logic_vector(1 downto 0);
   s_axi_bvalid         : out std_logic;
   s_axi_bready         : in  std_logic;
   s_axi_araddr         : in  std_logic_vector(addr_bits-1 downto 0);
   s_axi_arprot         : in  std_logic_vector(2 downto 0);
   s_axi_arvalid        : in  std_logic;
   s_axi_arready        : out std_logic;
   s_axi_rdata          : out std_logic_vector(31 downto 0);
   s_axi_rresp          : out std_logic_vector(1 downto 0);
   s_axi_rvalid         : out std_logic;
   s_axi_rready         : in  std_logic;

   m_axi_aresetn        : out std_logic;
   m_axi_awaddr         : out std_logic_vector(addr_bits-1 downto 0);
   m_axi_awprot         : out std_logic_vector(2 downto 0);
   m_axi_awvalid        : out std_logic;
   m_axi_awready        : in  std_logic;
   m_axi_wdata          : out std_logic_vector(31 downto 0);
   m_axi_wstrb          : out std_logic_vector(3 downto 0);
   m_axi_wvalid         : out std_logic;
   m_axi_wready         : in  std_logic;
   m_axi_bresp          : in  std_logic_vector(1 downto 0);
   m_axi_bvalid         : in  std_logic;
   m_axi_bready         : out std_logic;
   m_axi_araddr         : out std_logic_vector(addr_bits-1 downto 0);
   m_axi_arprot         : out std_logic_vector(2 downto 0);
   m_axi_arvalid        : out std_logic;
   m_axi_arready        : in  std_logic;
   m_axi_rdata          : in  std_logic_vector(31 downto 0);
   m_axi_rresp          : in  std_logic_vector(1 downto 0);
   m_axi_rvalid         : in  std_logic;
   m_axi_rready         : out std_logic

);
end component;

signal   axi_aclk             : std_logic := '0';
signal   s_axi_aresetn        : std_logic := '0';
signal   s_axi_awaddr         : std_logic_vector(11 downto 0) := (others => '0');
signal   s_axi_awprot         : std_logic_vector(2 downto 0) := (others => '0');
signal   s_axi_awvalid        : std_logic := '0';
signal   s_axi_awready        : std_logic := '0';
signal   s_axi_wdata          : std_logic_vector(31 downto 0) := (others => '0');
signal   s_axi_wstrb          : std_logic_vector(3 downto 0) := (others => '0');
signal   s_axi_wvalid         : std_logic := '0';
signal   s_axi_wready         : std_logic := '0';
signal   s_axi_bresp          : std_logic_vector(1 downto 0) := (others => '0');
signal   s_axi_bvalid         : std_logic := '0';
signal   s_axi_bready         : std_logic := '0';
signal   s_axi_araddr         : std_logic_vector(11 downto 0) := (others => '0');
signal   s_axi_arprot         : std_logic_vector(2 downto 0) := (others => '0');
signal   s_axi_arvalid        : std_logic := '0';
signal   s_axi_arready        : std_logic := '0';
signal   s_axi_rdata          : std_logic_vector(31 downto 0) := (others => '0');
signal   s_axi_rresp          : std_logic_vector(1 downto 0) := (others => '0');
signal   s_axi_rvalid         : std_logic := '0';
signal   s_axi_rready         : std_logic := '0';
signal   m_axi_aresetn        : std_logic := '0';
signal   m_axi_awaddr         : std_logic_vector(11 downto 0) := (others => '0');
signal   m_axi_awprot         : std_logic_vector(2 downto 0) := (others => '0');
signal   m_axi_awvalid        : std_logic := '0';
signal   m_axi_awready        : std_logic := '0';
signal   m_axi_wdata          : std_logic_vector(31 downto 0) := (others => '0');
signal   m_axi_wstrb          : std_logic_vector(3 downto 0) := (others => '0');
signal   m_axi_wvalid         : std_logic := '0';
signal   m_axi_wready         : std_logic := '0';
signal   m_axi_bresp          : std_logic_vector(1 downto 0) := (others => '0');
signal   m_axi_bvalid         : std_logic := '0';
signal   m_axi_bready         : std_logic := '0';
signal   m_axi_araddr         : std_logic_vector(11 downto 0) := (others => '0');
signal   m_axi_arprot         : std_logic_vector(2 downto 0) := (others => '0');
signal   m_axi_arvalid        : std_logic := '0';
signal   m_axi_arready        : std_logic := '0';
signal   m_axi_rdata          : std_logic_vector(31 downto 0) := (others => '0');
signal   m_axi_rresp          : std_logic_vector(1 downto 0) := (others => '0');
signal   m_axi_rvalid         : std_logic := '0';
signal   m_axi_rready         : std_logic := '0';

begin

uut: px_axil_timeout_rst 
generic map(
   addr_bits     => 12,
   timeout_count => 256
)
port map ( 
----------------------------------------------------------------------------
-- Control/Status Registers (AXI4-LITE)
----------------------------------------------------------------------------
   axi_aclk           => axi_aclk,            
   s_axi_aresetn      => s_axi_aresetn,       
   s_axi_awaddr       => s_axi_awaddr,        
   s_axi_awprot       => s_axi_awprot ,       
   s_axi_awvalid      => s_axi_awvalid,       
   s_axi_awready      => s_axi_awready,       
   s_axi_wdata        => s_axi_wdata,         
   s_axi_wstrb        => s_axi_wstrb,         
   s_axi_wvalid       => s_axi_wvalid,        
   s_axi_wready       => s_axi_wready,        
   s_axi_bresp        => s_axi_bresp,         
   s_axi_bvalid       => s_axi_bvalid,        
   s_axi_bready       => s_axi_bready,        
   s_axi_araddr       => s_axi_araddr,        
   s_axi_arprot       => s_axi_arprot,        
   s_axi_arvalid      => s_axi_arvalid,       
   s_axi_arready      => s_axi_arready,       
   s_axi_rdata        => s_axi_rdata,         
   s_axi_rresp        => s_axi_rresp,         
   s_axi_rvalid       => s_axi_rvalid,        
   s_axi_rready       => s_axi_rready,        

   m_axi_aresetn      => m_axi_aresetn,       
   m_axi_awaddr       => m_axi_awaddr,        
   m_axi_awprot       => m_axi_awprot,        
   m_axi_awvalid      => m_axi_awvalid,       
   m_axi_awready      => m_axi_awready,       
   m_axi_wdata        => m_axi_wdata,         
   m_axi_wstrb        => m_axi_wstrb,         
   m_axi_wvalid       => m_axi_wvalid,        
   m_axi_wready       => m_axi_wready,        
   m_axi_bresp        => m_axi_bresp,         
   m_axi_bvalid       => m_axi_bvalid,        
   m_axi_bready       => m_axi_bready,        
   m_axi_araddr       => m_axi_araddr,        
   m_axi_arprot       => m_axi_arprot,        
   m_axi_arvalid      => m_axi_arvalid,       
   m_axi_arready      => m_axi_arready,       
   m_axi_rdata        => m_axi_rdata,         
   m_axi_rresp        => m_axi_rresp,         
   m_axi_rvalid       => m_axi_rvalid,       
   m_axi_rready       => m_axi_rready        

);

process
begin
   loop
     wait for 2 ns;
     axi_aclk <= not axi_aclk; 
   end loop;
end process;

process
begin
     wait for 100 ns;
     wait until rising_edge(axi_aclk);
     s_axi_aresetn <= '1';
     wait for 100 ns;
     wait until rising_edge(axi_aclk);
     s_axi_awvalid <= '1';
     s_axi_wvalid <= '1';
     wait until rising_edge(axi_aclk);
     s_axi_awvalid <= '0';
     s_axi_wvalid <= '0';
     while (s_axi_bvalid = '0') loop
       wait until rising_edge(axi_aclk);
     end loop;
     wait for 100 ns;
     wait until rising_edge(axi_aclk);
     s_axi_bready <= '1';
     wait until rising_edge(axi_aclk);
     s_axi_bready <= '0';
   wait;
end process;

aw: process
begin
   loop
   wait until rising_edge(axi_aclk);
   while (m_axi_awvalid = '0') loop
      wait until rising_edge(axi_aclk);
   end loop;
   m_axi_awready <= '1';
   wait until rising_edge(axi_aclk);
   m_axi_awready <= '0';
   end loop;
end process;

w: process
begin
  loop
   wait until rising_edge(axi_aclk);
   while (m_axi_wvalid = '0') loop
      wait until rising_edge(axi_aclk);
   end loop;
   m_axi_wready <= '1';
   wait until rising_edge(axi_aclk);
   m_axi_wready <= '0';
   wait until rising_edge(axi_aclk);
   m_axi_bvalid <= '1';
   while (m_axi_bready = '0') loop
     wait until rising_edge(axi_aclk);
   end loop;
   wait until rising_edge(axi_aclk);
   m_axi_bvalid <= '0';
  end loop;
end process;

ar: process
begin
   loop
   wait until rising_edge(axi_aclk);
   while (m_axi_arvalid = '0') loop
      wait until rising_edge(axi_aclk);
   end loop;
   m_axi_arready <= '1';
   wait until rising_edge(axi_aclk);
   m_axi_arready <= '0';
   wait until rising_edge(axi_aclk);
   m_axi_rvalid <= '1';
   while (m_axi_rready = '0') loop
     wait until rising_edge(axi_aclk);
   end loop;
   wait until rising_edge(axi_aclk);
   m_axi_rvalid <= '0';
   end loop;
end process;


end Behavioral;
