----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/25/2018 08:23:26 AM
-- Design Name: 
-- Module Name: tb_axis_ppkt2ppld - Behavioral
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

entity tb_axis_ppkt2ppld is
--  Port ( );
end tb_axis_ppkt2ppld;

architecture Behavioral of tb_axis_ppkt2ppld is

component px_axis_ppkt2ppld
generic(
   word_width : integer range 1 to 64 := 16;
   default_packet_size: integer range 2 to 65536 := 256;
   has_override: boolean := false;
   has_fifo_rst_in_n: boolean := true
);
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
--------------------------------------------------------------------------------
   s_axi_csr_aclk        : in  std_logic;
   s_axi_csr_aresetn     : in  std_logic;
   s_axi_csr_awaddr      : in  std_logic_vector(6 downto 0);
   s_axi_csr_awprot      : in  std_logic_vector(2 downto 0); -- not used
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
   s_axi_csr_arprot      : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_arvalid     : in  std_logic;
   s_axi_csr_arready     : out std_logic;
   s_axi_csr_rdata       : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp       : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid      : out std_logic;
   s_axi_csr_rready      : in  std_logic;
   --------------------------------------------------------------------------------
   -- Packet Size Override  
   --------------------------------------------------------------------------------
   override_pkt_size_en  : in std_logic;
   override_pkt_size     : in std_logic_vector(16 downto 0);  -- packet length in bytes 
   ----------------------------------------------------------------------------
   axis_aclk             : in  std_logic;
   axis_aresetn          : in  std_logic; 
   -----------------------------------------------------------------------------
   -- FIFO Reset In
   -----------------------------------------------------------------------------
   -- synchronous witn axis_aclk
   fifo_rst_in_n         : in  std_logic;
   -----------------------------------------------------------------------------    
   s_axis_ppkt_tvalid    : in  std_logic;
   s_axis_ppkt_tready    : out std_logic;
   s_axis_ppkt_tdata     : in  std_logic_vector((word_width*16)-1 downto 0);
   -- tuser[63:0]    = timestamp[63:0]  
   -- tuser[64]      = SOP   
   -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
   -- tuser[67]      = Data Type 0 = Real 1 = I/Q
   -- tuser[75:68]   = channel[7:0]
   -- tuser[79:76]   = user[3:0] These bits only valid only with tlast   
   s_axis_ppkt_tuser     : in  std_logic_vector(79 downto 0);
   s_axis_ppkt_tkeep     : in  std_logic_vector(word_width-1 downto 0); -- One per 16-bit word (Note this is not standard 1 per byte)
   s_axis_ppkt_tlast     : in  std_logic; -- end of packet
   -----------------------------------------------------------------------------
   -- AXI-S to Packet type FIFO
   -----------------------------------------------------------------------------
   m_axis_pktfifo_aresetn: out std_logic;
   m_axis_pktfifo_tvalid : out std_logic;
   m_axis_pktfifo_tready : in  std_logic;
   m_axis_pktfifo_tdata  : out std_logic_vector((word_width*16)-1 downto 0); 
   m_axis_pktfifo_tuser  : out std_logic_vector(103 downto 0);
   m_axis_pktfifo_tkeep  : out std_logic_vector((word_width*2)-1 downto 0); -- One per byte
   m_axis_pktfifo_tlast  : out std_logic; -- end of packet
   -----------------------------------------------------------------------------
   -- AXI-S from Packet type FIFO
   -----------------------------------------------------------------------------  
   s_axis_pktfifo_tvalid : in  std_logic;
   s_axis_pktfifo_tready : out std_logic;
   s_axis_pktfifo_tdata  : in  std_logic_vector((word_width*16)-1 downto 0); 
   s_axis_pktfifo_tuser  : in  std_logic_vector(103 downto 0);
   s_axis_pktfifo_tkeep  : in  std_logic_vector((word_width*2)-1 downto 0); -- One per byte
   s_axis_pktfifo_tlast  : in  std_logic; -- end of packet    
   -----------------------------------------------------------------------------
   -- AXI-S PPLD Output Stream
   -----------------------------------------------------------------------------
   m_axis_ppld_tvalid    : out std_logic;
   m_axis_ppld_tready    : in  std_logic;
   m_axis_ppld_tdata     : out std_logic_vector((word_width*16)-1 downto 0);
   -- tuser[63:0]    = timestamp[63:0]  
   -- tuser[64]      = Start of Payload Packet   
   -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
   -- tuser[67]      = Data Type 0 = Real 1 = I/Q
   -- tuser[75:68]   = channel[7:0]
   -- tuser[79:76]   = Reserved
   -- tuser[96:80]   = Payload Size (bytes)
   -- tuser[103:97]  = Number Valid Bytes in cycle
   m_axis_ppld_tuser     : out std_logic_vector(103 downto 0);
   m_axis_ppld_tkeep     : out std_logic_vector((word_width*2)-1 downto 0); -- One per byte
   m_axis_ppld_tlast     : out std_logic -- End of Payload Packet    
);
end component px_axis_ppkt2ppld;

-- 256 deep Packet FIFO
COMPONENT tb_pkt_fifo
  PORT (
    s_aclk : IN STD_LOGIC;
    s_aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_tkeep : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axis_tlast : IN STD_LOGIC;
    s_axis_tuser : IN STD_LOGIC_VECTOR(103 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_tkeep : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    m_axis_tlast : OUT STD_LOGIC;
    m_axis_tuser : OUT STD_LOGIC_VECTOR(103 DOWNTO 0)
  );
END COMPONENT;

constant word_width : integer := 2;

--------------------------------------------------------------------------------
-- Signals 
--------------------------------------------------------------------------------
signal   s_axi_csr_aclk        : std_logic := '0';
signal   s_axi_csr_aresetn     : std_logic := '0';
signal   s_axi_csr_awaddr      : std_logic_vector(6 downto 0) := (others => '0');
signal   s_axi_csr_awprot      : std_logic_vector(2 downto 0) := (others => '0'); -- not used
signal   s_axi_csr_awvalid     : std_logic := '0';
signal   s_axi_csr_awready     : std_logic := '0';
signal   s_axi_csr_wdata       : std_logic_vector(31 downto 0) := (others => '0');
signal   s_axi_csr_wstrb       : std_logic_vector(3 downto 0) := (others => '0'); 
signal   s_axi_csr_wvalid      : std_logic := '0';
signal   s_axi_csr_wready      : std_logic := '0';
signal   s_axi_csr_bresp       : std_logic_vector(1 downto 0) := (others => '0');
signal   s_axi_csr_bvalid      : std_logic := '0';
signal   s_axi_csr_bready      : std_logic := '0';
signal   s_axi_csr_araddr      : std_logic_vector(6 downto 0) := (others => '0');
signal   s_axi_csr_arprot      : std_logic_vector(2 downto 0) := (others => '0'); -- not used
signal   s_axi_csr_arvalid     : std_logic := '0';
signal   s_axi_csr_arready     : std_logic := '0';
signal   s_axi_csr_rdata       : std_logic_vector(31 downto 0) := (others => '0');
signal   s_axi_csr_rresp       : std_logic_vector(1 downto 0) := (others => '0');
signal   s_axi_csr_rvalid      : std_logic := '0';
signal   s_axi_csr_rready      : std_logic := '0';
-- synchronous witn axis_aclk
signal   fifo_rst_in_n         : std_logic := '1';
signal   override_pkt_size_en  : std_logic := '0';
signal   override_pkt_size     : std_logic_vector(16 downto 0) := (others => '0');  -- packet length in bytes 

signal   axis_aclk             : std_logic := '0';
signal   axis_aresetn          : std_logic := '0'; 

signal   s_axis_ppkt_tvalid    : std_logic := '0';
signal   s_axis_ppkt_tready    : std_logic := '0';
signal   s_axis_ppkt_tdata     : std_logic_vector((word_width*16)-1 downto 0) := (others => '0');
signal   s_axis_ppkt_tuser     : std_logic_vector(79 downto 0) := (others => '0');
signal   s_axis_ppkt_tkeep     : std_logic_vector(word_width-1 downto 0) := (others => '0'); -- One per 16-bit word (Note this is not standard 1 per byte)
signal   s_axis_ppkt_tlast     : std_logic := '0'; -- end of packet

signal   m_axis_pktfifo_aresetn: std_logic := '0';
signal   m_axis_pktfifo_tvalid : std_logic := '0';
signal   m_axis_pktfifo_tready : std_logic := '0';
signal   m_axis_pktfifo_tdata  : std_logic_vector((word_width*16)-1 downto 0) := (others => '0'); 
signal   m_axis_pktfifo_tuser  : std_logic_vector(103 downto 0) := (others => '0');
signal   m_axis_pktfifo_tkeep  : std_logic_vector((word_width*2)-1 downto 0) := (others => '0'); -- One per byte
signal   m_axis_pktfifo_tlast  : std_logic := '0'; -- end of packet

signal   s_axis_pktfifo_tvalid : std_logic := '0';
signal   s_axis_pktfifo_tready : std_logic := '0';
signal   s_axis_pktfifo_tdata  : std_logic_vector((word_width*16)-1 downto 0) := (others => '0'); 
signal   s_axis_pktfifo_tuser  : std_logic_vector(103 downto 0) := (others => '0');
signal   s_axis_pktfifo_tkeep  : std_logic_vector((word_width*2)-1 downto 0) := (others => '0'); -- One per byte
signal   s_axis_pktfifo_tlast  : std_logic; -- end of packet    

signal   m_axis_ppld_tvalid    : std_logic := '0';
signal   m_axis_ppld_tready    : std_logic := '1';
signal   m_axis_ppld_tdata     : std_logic_vector((word_width*16)-1 downto 0) := (others => '0');
signal   m_axis_ppld_tuser     : std_logic_vector(103 downto 0) := (others => '0');
signal   m_axis_ppld_tkeep     : std_logic_vector((word_width*2)-1 downto 0) := (others => '0'); -- One per byte
signal   m_axis_ppld_tlast     : std_logic := '0'; -- End of Payload Packet    

begin

uut: px_axis_ppkt2ppld
generic map(
   word_width => 2,
   default_packet_size => 256
)
port map (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
--------------------------------------------------------------------------------
   s_axi_csr_aclk        => s_axi_csr_aclk,    
   s_axi_csr_aresetn     => s_axi_csr_aresetn, 
   s_axi_csr_awaddr      => s_axi_csr_awaddr,  
   s_axi_csr_awprot      => s_axi_csr_awprot,  
   s_axi_csr_awvalid     => s_axi_csr_awvalid, 
   s_axi_csr_awready     => s_axi_csr_awready, 
   s_axi_csr_wdata       => s_axi_csr_wdata,   
   s_axi_csr_wstrb       => s_axi_csr_wstrb,   
   s_axi_csr_wvalid      => s_axi_csr_wvalid, 
   s_axi_csr_wready      => s_axi_csr_wready,  
   s_axi_csr_bresp       => s_axi_csr_bresp,   
   s_axi_csr_bvalid      => s_axi_csr_bvalid,  
   s_axi_csr_bready      => s_axi_csr_bready,  
   s_axi_csr_araddr      => s_axi_csr_araddr,  
   s_axi_csr_arprot      => s_axi_csr_arprot,  
   s_axi_csr_arvalid     => s_axi_csr_arvalid, 
   s_axi_csr_arready     => s_axi_csr_arready, 
   s_axi_csr_rdata       => s_axi_csr_rdata,   
   s_axi_csr_rresp       => s_axi_csr_rresp,   
   s_axi_csr_rvalid      => s_axi_csr_rvalid,  
   s_axi_csr_rready      => s_axi_csr_rready,  
   ----------------------------------------------------------------------------
   axis_aclk             => axis_aclk,    
   axis_aresetn          => axis_aresetn,
   fifo_rst_in_n         => fifo_rst_in_n,        
   override_pkt_size_en  => override_pkt_size_en, 
   override_pkt_size     => override_pkt_size,    
   -----------------------------------------------------------------------------
   -- AXI-S PPKT Input Stream
   -----------------------------------------------------------------------------    
   s_axis_ppkt_tvalid    => s_axis_ppkt_tvalid,
   s_axis_ppkt_tready    => s_axis_ppkt_tready,
   s_axis_ppkt_tdata     => s_axis_ppkt_tdata, 
   s_axis_ppkt_tuser     => s_axis_ppkt_tuser,
   s_axis_ppkt_tkeep     => s_axis_ppkt_tkeep,
   s_axis_ppkt_tlast     => s_axis_ppkt_tlast,
   -----------------------------------------------------------------------------
   -- AXI-S to Packet type FIFO
   -----------------------------------------------------------------------------
   m_axis_pktfifo_aresetn=> m_axis_pktfifo_aresetn,
   m_axis_pktfifo_tvalid => m_axis_pktfifo_tvalid, 
   m_axis_pktfifo_tready => m_axis_pktfifo_tready, 
   m_axis_pktfifo_tdata  => m_axis_pktfifo_tdata,  
   m_axis_pktfifo_tuser  => m_axis_pktfifo_tuser,  
   m_axis_pktfifo_tkeep  => m_axis_pktfifo_tkeep,  
   m_axis_pktfifo_tlast  => m_axis_pktfifo_tlast,  
   -----------------------------------------------------------------------------
   -- AXI-S from Packet type FIFO
   -----------------------------------------------------------------------------  
   s_axis_pktfifo_tvalid => s_axis_pktfifo_tvalid,
   s_axis_pktfifo_tready => s_axis_pktfifo_tready,
   s_axis_pktfifo_tdata  => s_axis_pktfifo_tdata, 
   s_axis_pktfifo_tuser  => s_axis_pktfifo_tuser, 
   s_axis_pktfifo_tkeep  => s_axis_pktfifo_tkeep, 
   s_axis_pktfifo_tlast  => s_axis_pktfifo_tlast, 
   -----------------------------------------------------------------------------
   -- AXI-S PPLD Output Stream
   -----------------------------------------------------------------------------
   m_axis_ppld_tvalid    => m_axis_ppld_tvalid,
   m_axis_ppld_tready    => m_axis_ppld_tready,
   m_axis_ppld_tdata     => m_axis_ppld_tdata, 
   m_axis_ppld_tuser     => m_axis_ppld_tuser,
   m_axis_ppld_tkeep     => m_axis_ppld_tkeep,
   m_axis_ppld_tlast     => m_axis_ppld_tlast
);

pkt_fifo_inst: tb_pkt_fifo
  PORT MAP (
    s_aclk        => axis_aclk,
    s_aresetn     => m_axis_pktfifo_aresetn,
    s_axis_tvalid => m_axis_pktfifo_tvalid,
    s_axis_tready => m_axis_pktfifo_tready,
    s_axis_tdata  => m_axis_pktfifo_tdata,
    s_axis_tkeep  => m_axis_pktfifo_tkeep,
    s_axis_tlast  => m_axis_pktfifo_tlast,
    s_axis_tuser  => m_axis_pktfifo_tuser,
    m_axis_tvalid => s_axis_pktfifo_tvalid,
    m_axis_tready => s_axis_pktfifo_tready,
    m_axis_tdata  => s_axis_pktfifo_tdata,
    m_axis_tkeep  => s_axis_pktfifo_tkeep,
    m_axis_tlast  => s_axis_pktfifo_tlast,
    m_axis_tuser  => s_axis_pktfifo_tuser
  );

process
begin
   loop
      wait for 2.5 ns;
      axis_aclk <= not axis_aclk;
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
   wait for 100 ns;
   wait until rising_edge(axis_aclk);
   axis_aresetn <= '1';
   s_axi_csr_aresetn <= '1';
   wait for 20 ns;
   wait until rising_edge(axis_aclk);  
   s_axis_ppkt_tvalid <= '1';
   
   wait;   
   
end process;

process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      if (s_axis_ppkt_tvalid = '1') and (s_axis_ppkt_tready = '1') then
         s_axis_ppkt_tdata <= s_axis_ppkt_tdata + 1;
         if (s_axis_ppkt_tdata(11 downto 0) = x"0FD") then -- check input tlast case 
            s_axis_ppkt_tlast  <= '1';
            s_axis_ppkt_tkeep  <= "01";
         elsif (s_axis_ppkt_tdata(11 downto 0) = x"0FE") then -- check input tlast case 
             s_axis_ppkt_tlast  <= '1';
             s_axis_ppkt_tkeep  <= "11";        
         elsif (s_axis_ppkt_tdata(11 downto 0) = x"0FF") then -- check input tlast case 
             s_axis_ppkt_tlast  <= '1';
             s_axis_ppkt_tkeep  <= "01"; 
         else 
            s_axis_ppkt_tlast  <= '0';
            s_axis_ppkt_tkeep  <= "11";
         end if;    
      end if;   
   end if;
end process;   


end Behavioral;
