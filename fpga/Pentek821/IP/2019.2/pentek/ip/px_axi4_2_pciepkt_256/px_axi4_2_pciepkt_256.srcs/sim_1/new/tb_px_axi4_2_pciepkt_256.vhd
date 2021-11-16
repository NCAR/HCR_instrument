----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/17/2019 02:51:03 PM
-- Design Name: 
-- Module Name: tb_px_axi4_2_pciepkt - Behavioral
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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_px_axi4_2_pciepkt_256 is
generic(
channel_id_width            : integer range 1 to 16 := 2; 
data_axi_addr_width         : integer range 7 to 64 := 64
);
end tb_px_axi4_2_pciepkt_256;

architecture Behavioral of tb_px_axi4_2_pciepkt_256 is

component px_axi4_2_pciepkt_256
generic(
channel_id_width            : integer range 1 to 16 := 5; -- 0-6 (must be unique)
data_axi_addr_width         : integer range 7 to 64 := 64
);
port (
   aclk                     : in  std_logic; 
   -- associated with aclk
   aresetn                  : in  std_logic;
   ----------------------------------------------------------------------------
   -- Input Data Bus (AXI-4 Slave)
   ----------------------------------------------------------------------------  
   s_axi_mm2s_awid          : in  std_logic_vector(channel_id_width-1 downto 0);        
   s_axi_mm2s_awaddr        : in  std_logic_vector(data_axi_addr_width-1 downto 0);       
   s_axi_mm2s_awlen         : in  std_logic_vector(7 downto 0);        
   s_axi_mm2s_awsize        : in  std_logic_vector(2 downto 0);        
   s_axi_mm2s_awburst       : in  std_logic_vector(1 downto 0);        
   s_axi_mm2s_awprot        : in  std_logic_vector(2 downto 0);        
   s_axi_mm2s_awcache       : in  std_logic_vector(3 downto 0);        
   s_axi_mm2s_awuser        : in  std_logic_vector(3 downto 0);        
   s_axi_mm2s_awvalid       : in  std_logic;                           
   s_axi_mm2s_awready       : out std_logic;                            
   s_axi_mm2s_wdata         : in  std_logic_vector(255 downto 0);      
   s_axi_mm2s_wstrb         : in  std_logic_vector(31 downto 0);       
   s_axi_mm2s_wlast         : in  std_logic;                           
   s_axi_mm2s_wvalid        : in  std_logic;                           
   s_axi_mm2s_wready        : out std_logic;                            
   s_axi_mm2s_bresp         : out std_logic_vector(1 downto 0);         
   s_axi_mm2s_bvalid        : out std_logic;                            
   s_axi_mm2s_bready        : in  std_logic;   
   s_axi_mm2s_bid           : out std_logic_vector(channel_id_width-1 downto 0);                   
   ----------------------------------------------------------------------------
   -- Output PCIe Packet Data Stream (AXI-Stream Stream Master)
   ----------------------------------------------------------------------------  
   m_axis_pcie_rq_tvalid         : out std_logic;
   m_axis_pcie_rq_tready         : in  std_logic;
   m_axis_pcie_rq_tdata          : out std_logic_vector(255 downto 0);
   m_axis_pcie_rq_tkeep          : out std_logic_vector(31 downto 0);    
   m_axis_pcie_rq_tuser          : out std_logic_vector(59 downto 0);
   m_axis_pcie_rq_tlast          : out std_logic -- end of packet
   -----------------------------------------------------------------------------
     );
end component px_axi4_2_pciepkt_256;

signal aclk                     : std_logic := '0'; 
signal aresetn                  : std_logic := '0';
signal s_axi_mm2s_awid          : std_logic_vector(channel_id_width-1 downto 0) := (others => '1');        
signal s_axi_mm2s_awaddr        : std_logic_vector(data_axi_addr_width-1 downto 0) := (others => '0');       
signal s_axi_mm2s_awlen         : std_logic_vector(7 downto 0) := (others => '0');        
signal s_axi_mm2s_awsize        : std_logic_vector(2 downto 0) := "110";        
signal s_axi_mm2s_awburst       : std_logic_vector(1 downto 0) := "01";        
signal s_axi_mm2s_awprot        : std_logic_vector(2 downto 0) := (others => '0');        
signal s_axi_mm2s_awcache       : std_logic_vector(3 downto 0) := (others => '0');        
signal s_axi_mm2s_awuser        : std_logic_vector(3 downto 0) := (others => '0');        
signal s_axi_mm2s_awvalid       : std_logic := '0';                           
signal s_axi_mm2s_awready       : std_logic := '0';                            
signal s_axi_mm2s_wdata         : std_logic_vector(255 downto 0) := (others => '0');      
signal s_axi_mm2s_wstrb         : std_logic_vector(31 downto 0) := (others => '0');       
signal s_axi_mm2s_wlast         : std_logic := '0';                           
signal s_axi_mm2s_wvalid        : std_logic := '0';                           
signal s_axi_mm2s_wready        : std_logic := '0';                            
signal s_axi_mm2s_bresp         : std_logic_vector(1 downto 0) := (others => '0');         
signal s_axi_mm2s_bvalid        : std_logic := '0';                            
signal s_axi_mm2s_bready        : std_logic := '1';   
signal s_axi_mm2s_bid           : std_logic_vector(channel_id_width-1 downto 0) := (others => '0');                   
signal m_axis_pcie_rq_tvalid    : std_logic := '0';
signal m_axis_pcie_rq_tready    : std_logic := '1';
signal m_axis_pcie_rq_tdata     : std_logic_vector(255 downto 0) := (others => '0');
signal m_axis_pcie_rq_tkeep     : std_logic_vector(31 downto 0) := (others => '0');    
signal m_axis_pcie_rq_tuser     : std_logic_vector(59 downto 0) := (others => '0');
signal m_axis_pcie_rq_tlast     : std_logic := '0'; -- end of packet

begin


uut: px_axi4_2_pciepkt_256
generic map (
channel_id_width            => 2, 
data_axi_addr_width         => 64
)
port map(
   aclk          => aclk,           
   aresetn       => aresetn,           
   ----------------------------------------------------------------------------
   -- Input Data Bus (AXI-4 Slave)
   ----------------------------------------------------------------------------  
   s_axi_mm2s_awid          => s_axi_mm2s_awid  ,
   s_axi_mm2s_awaddr        => s_axi_mm2s_awaddr, 
   s_axi_mm2s_awlen         => s_axi_mm2s_awlen ,
   s_axi_mm2s_awsize        => s_axi_mm2s_awsize,
   s_axi_mm2s_awburst       => s_axi_mm2s_awburst,
   s_axi_mm2s_awprot        => s_axi_mm2s_awprot,
   s_axi_mm2s_awcache       => s_axi_mm2s_awcache,
   s_axi_mm2s_awuser        => s_axi_mm2s_awuser,
   s_axi_mm2s_awvalid       => s_axi_mm2s_awvalid,
   s_axi_mm2s_awready       => s_axi_mm2s_awready,
   s_axi_mm2s_wdata         => s_axi_mm2s_wdata ,
   s_axi_mm2s_wstrb         => s_axi_mm2s_wstrb ,
   s_axi_mm2s_wlast         => s_axi_mm2s_wlast ,
   s_axi_mm2s_wvalid        => s_axi_mm2s_wvalid,
   s_axi_mm2s_wready        => s_axi_mm2s_wready,
   s_axi_mm2s_bresp         => s_axi_mm2s_bresp ,
   s_axi_mm2s_bvalid        => s_axi_mm2s_bvalid,
   s_axi_mm2s_bready        => s_axi_mm2s_bready,
   s_axi_mm2s_bid           => s_axi_mm2s_bid   ,          
   ----------------------------------------------------------------------------
   -- Output PCIe Packet Data Stream (AXI-Stream Stream Master)
   ----------------------------------------------------------------------------  
   m_axis_pcie_rq_tvalid    => m_axis_pcie_rq_tvalid,
   m_axis_pcie_rq_tready    => m_axis_pcie_rq_tready,
   m_axis_pcie_rq_tdata     => m_axis_pcie_rq_tdata ,
   m_axis_pcie_rq_tkeep     => m_axis_pcie_rq_tkeep ,
   m_axis_pcie_rq_tuser     => m_axis_pcie_rq_tuser ,
   m_axis_pcie_rq_tlast     => m_axis_pcie_rq_tlast 
   -----------------------------------------------------------------------------
     );
     
process
begin
    loop
        wait for 2 ns;
        aclk <= not aclk;
    end loop;    
end process;


process
begin
    wait for 100 ns;
    wait until rising_edge(aclk);
    aresetn <= '1';
    wait for 100 ns;
    wait until rising_edge(aclk);
    s_axi_mm2s_awaddr <= x"1000000000000000";
    s_axi_mm2s_awvalid <= '1';
    s_axi_mm2s_awlen  <= x"03";
    if s_axi_mm2s_awready = '1' then
       wait until rising_edge(aclk);
    end if;
    while s_axi_mm2s_awready = '0' loop
        wait until rising_edge(aclk);
    end loop;
    
    s_axi_mm2s_awvalid <= '0';
    for i in 0 to 3 loop
       s_axi_mm2s_wdata <= conv_std_logic_vector(i, 256);
       s_axi_mm2s_wvalid <= '1'; 
       if (i = 3) then
          s_axi_mm2s_wlast <= '1';
          s_axi_mm2s_wstrb <= x"0000000F";
       else
          s_axi_mm2s_wlast <= '0';
          s_axi_mm2s_wstrb <= x"FFFFFFFF";
       end if;
       if s_axi_mm2s_wready = '1' then
         wait until rising_edge(aclk);
       end if;
       while s_axi_mm2s_wready = '0' loop
            wait until rising_edge(aclk);
       end loop;
    end loop;
    s_axi_mm2s_wvalid <= '0';
    wait until rising_edge(aclk);
    s_axi_mm2s_awaddr <= x"2000000000000000";
    s_axi_mm2s_awvalid <= '1';
    s_axi_mm2s_awlen  <= x"02";
    if s_axi_mm2s_awready = '1' then
       wait until rising_edge(aclk);
    end if;
    while s_axi_mm2s_awready = '0' loop
        wait until rising_edge(aclk);
    end loop;
    s_axi_mm2s_awvalid <= '0';
    for i in 0 to 2 loop
       s_axi_mm2s_wdata <= conv_std_logic_vector(i, 256);
       s_axi_mm2s_wvalid <= '1'; 
       if (i = 2) then
          s_axi_mm2s_wlast <= '1';
          s_axi_mm2s_wstrb <= x"000000FF";
       else
          s_axi_mm2s_wlast <= '0';
          s_axi_mm2s_wstrb <= x"FFFFFFFF";
       end if;
       if s_axi_mm2s_wready = '1' then
          wait until rising_edge(aclk);
       end if;
       while s_axi_mm2s_wready = '0' loop
            wait until rising_edge(aclk);
       end loop;
       wait until rising_edge(aclk);
    end loop;
    s_axi_mm2s_wvalid <= '0';
    wait until rising_edge(aclk);
    s_axi_mm2s_awaddr <= x"3000000000000000";
    s_axi_mm2s_awvalid <= '1';
    s_axi_mm2s_awlen  <= x"00";
    if s_axi_mm2s_awready = '1' then
       wait until rising_edge(aclk);
    end if;
    while s_axi_mm2s_awready = '0' loop
        wait until rising_edge(aclk);
    end loop;
    wait until rising_edge(aclk);
    s_axi_mm2s_awvalid <= '0';
    s_axi_mm2s_wdata <= conv_std_logic_vector(1023, 256);
    s_axi_mm2s_wvalid <= '1'; 
    s_axi_mm2s_wlast <= '1';
    s_axi_mm2s_wstrb <= x"0000000F";
    if s_axi_mm2s_wready = '1' then
       wait until rising_edge(aclk);
    end if;
    while s_axi_mm2s_wready = '0' loop
       wait until rising_edge(aclk);
    end loop;
    wait until rising_edge(aclk);
    s_axi_mm2s_wvalid <= '0';
    wait; 
    
end process;

end Behavioral;
