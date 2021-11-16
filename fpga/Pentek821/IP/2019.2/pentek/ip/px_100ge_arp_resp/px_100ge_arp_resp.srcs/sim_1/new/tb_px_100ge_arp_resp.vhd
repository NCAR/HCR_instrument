----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/19/2019 02:41:42 PM
-- Design Name: 
-- Module Name: tb_px_100ge_arp_resp - Behavioral
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


entity tb_px_100ge_arp_resp is

end tb_px_100ge_arp_resp;

architecture Behavioral of tb_px_100ge_arp_resp is

component px_100ge_arp_resp 
port (
   --------------------------------------------------------------------------------
   -- AXI LITE Slave Interface  
   --------------------------------------------------------------------------------
   s_axi_csr_aclk        : in  std_logic;
   s_axi_csr_aresetn     : in  std_logic;
   s_axi_csr_awaddr      : in  std_logic_vector(6 downto 0);
   s_axi_csr_awprot      : in  std_logic_vector(2 downto 0); 
   s_axi_csr_awvalid     : in  std_logic;
   s_axi_csr_awready     : out std_logic;
   s_axi_csr_wdata       : in  std_logic_vector(31 downto 0);
   s_axi_csr_wstrb       : in  std_logic_vector(3 downto 0); 
   s_axi_csr_wvalid      : in  std_logic;
   s_axi_csr_wready      : out std_logic;
   s_axi_csr_bresp       : out std_logic_vector(1 downto 0);
   s_axi_csr_bvalid      : out std_logic;
   s_axi_csr_bready      : in  std_logic;
   s_axi_csr_araddr      : in  std_logic_vector(6 downto 0);
   s_axi_csr_arprot      : in  std_logic_vector(2 downto 0);
   s_axi_csr_arvalid     : in  std_logic;
   s_axi_csr_arready     : out std_logic;
   s_axi_csr_rdata       : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp       : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid      : out std_logic;
   s_axi_csr_rready      : in  std_logic;
   
   irq                   : out std_logic;
   ---------------------------------------------------------------------------------
   -- 100GE Core AXI-S RX bus
   ---------------------------------------------------------------------------------
   s_axis_aresetn        : in  std_logic;
   s_axis_aclk           : in  std_logic;
   s_axis_tvalid         : in  std_logic;
   s_axis_tdata          : in  std_logic_vector(511 downto 0); 
   s_axis_tuser          : in  std_logic_vector(0 downto 0);
   s_axis_tkeep          : in  std_logic_vector(63 downto 0);
   s_axis_tlast          : in  std_logic; -- end of packet
   ----------------------------------------------------------------------------------
   -- 100GE Core AXI-S RX bus (ARP Response)
   ----------------------------------------------------------------------------------
   m_axis_arp_tvalid     : out std_logic;
   m_axis_arp_tready     : in  std_logic;
   m_axis_arp_tdata      : out std_logic_vector(511 downto 0); 
   m_axis_arp_tuser      : out std_logic_vector(0 downto 0);
   m_axis_arp_tkeep      : out std_logic_vector(63 downto 0);
   m_axis_arp_tlast      : out std_logic; -- end of packet   
   ----------------------------------------------------------------------------------
   -- AXI-Stream Master  (pass-through from s_axis)
   ----------------------------------------------------------------------------------
   m_axis_tvalid         : out std_logic;
   m_axis_tdata          : out std_logic_vector(511 downto 0); 
   m_axis_tuser          : out std_logic_vector(0 downto 0);
   m_axis_tkeep          : out std_logic_vector(63 downto 0);
   m_axis_tlast          : out std_logic; -- end of packet
   ----------------------------------------------------------------------------------
   -- IP and MAC address outputs
   ----------------------------------------------------------------------------------
   ip_address            : out std_logic_vector(31 downto 0);
   mac_address           : out std_logic_vector(47 downto 0)
);
end component px_100ge_arp_resp;

signal s_axi_csr_aclk        : std_logic := '0';
signal s_axi_csr_aresetn     : std_logic := '0';
signal s_axi_csr_awaddr      : std_logic_vector(6 downto 0) := (others => '0');
signal s_axi_csr_awprot      : std_logic_vector(2 downto 0) := (others => '0'); 
signal s_axi_csr_awvalid     : std_logic := '0';
signal s_axi_csr_awready     : std_logic := '0';
signal s_axi_csr_wdata       : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_csr_wstrb       : std_logic_vector(3 downto 0) := (others => '0'); 
signal s_axi_csr_wvalid      : std_logic := '0';
signal s_axi_csr_wready      : std_logic := '0';
signal s_axi_csr_bresp       : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_csr_bvalid      : std_logic := '0';
signal s_axi_csr_bready      : std_logic := '0';
signal s_axi_csr_araddr      : std_logic_vector(6 downto 0) := (others => '0');
signal s_axi_csr_arprot      : std_logic_vector(2 downto 0) := (others => '0');
signal s_axi_csr_arvalid     : std_logic := '0';
signal s_axi_csr_arready     : std_logic := '0';
signal s_axi_csr_rdata       : std_logic_vector(31 downto 0) := (others => '0');
signal s_axi_csr_rresp       : std_logic_vector(1 downto 0) := (others => '0');
signal s_axi_csr_rvalid      : std_logic := '0';
signal s_axi_csr_rready      : std_logic := '0';

signal s_axis_aresetn        : std_logic := '0';
signal s_axis_aclk           : std_logic := '0';
signal s_axis_tvalid         : std_logic := '0';
signal s_axis_tdata          : std_logic_vector(511 downto 0) := (others => '0'); 
signal s_axis_tuser          : std_logic_vector(0 downto 0) := (others => '0');
signal s_axis_tkeep          : std_logic_vector(63 downto 0) := (others => '0');
signal s_axis_tlast          : std_logic := '0';

signal m_axis_arp_tvalid     : std_logic := '0';
signal m_axis_arp_tready     : std_logic := '0';
signal m_axis_arp_tdata      : std_logic_vector(511 downto 0) := (others => '0'); 
signal m_axis_arp_tuser      : std_logic_vector(0 downto 0) := (others => '0');
signal m_axis_arp_tkeep      : std_logic_vector(63 downto 0) := (others => '0');
signal m_axis_arp_tlast      : std_logic := '0'; 

signal m_axis_tvalid         : std_logic := '0';
signal m_axis_tdata          : std_logic_vector(511 downto 0) := (others => '0'); 
signal m_axis_tuser          : std_logic_vector(0 downto 0) := (others => '0');
signal m_axis_tkeep          : std_logic_vector(63 downto 0) := (others => '0');
signal m_axis_tlast          : std_logic := '0';

begin

uut: px_100ge_arp_resp 
port map(
   --------------------------------------------------------------------------------
   -- AXI LITE Slave Interface  
   --------------------------------------------------------------------------------
   s_axi_csr_aclk        => s_axi_csr_aclk   ,
   s_axi_csr_aresetn     => s_axi_csr_aresetn,
   s_axi_csr_awaddr      => s_axi_csr_awaddr ,
   s_axi_csr_awprot      => s_axi_csr_awprot ,
   s_axi_csr_awvalid     => s_axi_csr_awvalid,
   s_axi_csr_awready     => s_axi_csr_awready,
   s_axi_csr_wdata       => s_axi_csr_wdata  ,
   s_axi_csr_wstrb       => s_axi_csr_wstrb  ,
   s_axi_csr_wvalid      => s_axi_csr_wvalid ,
   s_axi_csr_wready      => s_axi_csr_wready ,
   s_axi_csr_bresp       => s_axi_csr_bresp  ,
   s_axi_csr_bvalid      => s_axi_csr_bvalid ,
   s_axi_csr_bready      => s_axi_csr_bready ,
   s_axi_csr_araddr      => s_axi_csr_araddr ,
   s_axi_csr_arprot      => s_axi_csr_arprot ,
   s_axi_csr_arvalid     => s_axi_csr_arvalid,
   s_axi_csr_arready     => s_axi_csr_arready,
   s_axi_csr_rdata       => s_axi_csr_rdata  ,
   s_axi_csr_rresp       => s_axi_csr_rresp  ,
   s_axi_csr_rvalid      => s_axi_csr_rvalid ,
   s_axi_csr_rready      => s_axi_csr_rready ,
   
   irq                   => open,
   ---------------------------------------------------------------------------------
   -- 100GE Core AXI-S RX bus
   ---------------------------------------------------------------------------------
   s_axis_aresetn        => s_axis_aresetn,
   s_axis_aclk           => s_axis_aclk   ,
   s_axis_tvalid         => s_axis_tvalid ,
   s_axis_tdata          => s_axis_tdata  , 
   s_axis_tuser          => s_axis_tuser  ,
   s_axis_tkeep          => s_axis_tkeep  ,
   s_axis_tlast          => s_axis_tlast  ,
   ----------------------------------------------------------------------------------
   -- 100GE Core AXI-S RX bus (ARP Response)
   ----------------------------------------------------------------------------------
   m_axis_arp_tvalid     => m_axis_arp_tvalid  , 
   m_axis_arp_tready     => m_axis_arp_tready  ,
   m_axis_arp_tdata      => m_axis_arp_tdata   ,
   m_axis_arp_tuser      => m_axis_arp_tuser   ,
   m_axis_arp_tkeep      => m_axis_arp_tkeep   ,
   m_axis_arp_tlast      => m_axis_arp_tlast   ,
   ----------------------------------------------------------------------------------
   -- AXI-Stream Master  (pass-through from s_axis)
   ----------------------------------------------------------------------------------
   m_axis_tvalid         => m_axis_tvalid   ,
   m_axis_tdata          => m_axis_tdata    , 
   m_axis_tuser          => m_axis_tuser    ,
   m_axis_tkeep          => m_axis_tkeep    ,
   m_axis_tlast          => m_axis_tlast,
   ip_address            => open,
   mac_address           => open    
);

process
begin
loop
    wait for 1 ns;
    s_axis_aclk <= not s_axis_aclk;
end loop;
end process; 

-- CSR Clock = 250MHz
process
begin
    loop
        s_axi_csr_aclk <= not s_axi_csr_aclk;
        wait for 2 ns;
    end loop;
end process;
   

process
variable c_time : time    := 0 ns;
begin
wait for 400 ns;
   wait until rising_edge(s_axi_csr_aclk);
   s_axi_csr_aresetn <= '1';
   s_axis_aresetn    <= '1';
   wait for 40 ns;
   c_time := now;
   -----------------------------------------------------------------------------
   -- Write IP Address Control Register
   -----------------------------------------------------------------------------
   assert false
   report "Writing IP Address to Control Register. Start Time = " & time'image(now) 
   severity NOTE;
   px_axi_lite_writer("0000000",x"04030201", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
   -----------------------------------------------------------------------------
   -- Write MAC Address Control Register
   -----------------------------------------------------------------------------
   assert false
   report "Writing MAC Address to Control Registers. Start Time = " & time'image(now) 
   severity NOTE;
   px_axi_lite_writer("0000100",x"DDCCBBAA", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
   px_axi_lite_writer("0001000",x"0000FFEE", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
   -----------------------------------------------------------------------------
   -- Send ARP Request
   -----------------------------------------------------------------------------  
   wait for 400 ns; 
   wait until rising_edge(s_axis_aclk);
   s_axis_tdata(335 downto 0) <= x"01020304" & x"AABBCCDDEEFF" & x"05060708" & x"AAAAAAAAAAAA" & x"01000406000801000608" & x"AAAAAAAAAAAA" & x"FFFFFFFFFFFF";
   s_axis_tvalid <= '1';
   s_axis_tlast  <= '1';
   s_axis_tkeep(63 downto 0)  <= (others => '1');
   wait until rising_edge(s_axis_aclk);
   s_axis_tvalid <= '0';
   s_axis_tlast  <= '0';
   wait until rising_edge(s_axis_aclk);
   wait until rising_edge(s_axis_aclk);
   wait until rising_edge(s_axis_aclk);
   wait until rising_edge(s_axis_aclk);
   m_axis_arp_tready <= '1';
   -- Now we will send out an ARP Request
   -- Set up DEST IP Address for ARP Request Out
   px_axi_lite_writer("0001100",x"A5A5A5A5", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
   -- Pulse ARP RQST Start bit
   px_axi_lite_writer("0010000",x"00000001", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
   px_axi_lite_writer("0010000",x"00000000", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
   -----------------------------------------------------------------------------
   -- Send ARP Response back to uut
   -----------------------------------------------------------------------------  
   wait for 400 ns; 
   wait until rising_edge(s_axis_aclk);
   s_axis_tdata(335 downto 0) <= x"01020304" & x"AABBCCDDEEFF" & x"05060708" & x"AAAAAAAAAAAA" & x"02000406000801000608" & x"AAAAAAAAAAAA" & x"AABBCCDDEEFF";
   s_axis_tvalid <= '1';
   s_axis_tlast  <= '1';
   s_axis_tkeep(63 downto 0)  <= (others => '1');
   wait until rising_edge(s_axis_aclk);
   s_axis_tvalid <= '0';
   s_axis_tlast  <= '0';
   wait until rising_edge(s_axis_aclk);
   wait until rising_edge(s_axis_aclk);
   wait until rising_edge(s_axis_aclk);
   wait until rising_edge(s_axis_aclk);
   m_axis_arp_tready <= '1';
   wait;
end process;


end Behavioral;
