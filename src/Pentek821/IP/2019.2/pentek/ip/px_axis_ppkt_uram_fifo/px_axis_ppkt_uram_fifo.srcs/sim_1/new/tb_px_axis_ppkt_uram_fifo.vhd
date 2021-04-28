----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2018 10:22:52 AM
-- Design Name: 
-- Module Name: tb_px_axis_ppkt_uram_fifo - Behavioral
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

entity tb_px_axis_ppkt_uram_fifo is
generic (
    data_width_bytes : integer := 2;
    fifo_depth: integer range 512 to 65536:= 2048 
);
end tb_px_axis_ppkt_uram_fifo;

architecture Behavioral of tb_px_axis_ppkt_uram_fifo is

component px_axis_ppkt_uram_fifo
generic (
    has_in_tready     : boolean := false; -- has input tready (overrun is disabled if input flow control is present)
    has_in_reset      : boolean := true;
    data_width_bytes  : integer range 2 to 64 := 32; -- Number of uram fifo data bytes
    fifo_depth: integer range 512 to 65536 := 2048; -- fifo depth
    has_fifo_ovfl_led: boolean := true
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
   irq                   : out std_logic;

   axis_aclk                 : in  std_logic;
   axis_aresetn              : in  std_logic; 
   -----------------------------------------------------------------------------
   -- AXI-S PPKT FIFO Input Stream
   -----------------------------------------------------------------------------    
   s_axis_ppkt_tvalid    : in  std_logic;
   s_axis_ppkt_tready    : out std_logic;
   -- Earliest byte in lower byte 
   s_axis_ppkt_tdata     : in  std_logic_vector((data_width_bytes*8)-1 downto 0);
   -- tuser[63:0]    = timestamp[63:0]  
   -- tuser[64]      = SOP   
   -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
   -- tuser[67]      = Data Type 0 = Real 1 = I/Q
   -- tuser[75:68]   = channel[7:0]
   -- tuser[79:76]   = user[3:0] These bits only valid only with tlast   
   s_axis_ppkt_tuser     : in  std_logic_vector(79 downto 0);
   s_axis_ppkt_tkeep     : in  std_logic_vector((data_width_bytes/2)-1 downto 0); -- One per 16-bit word (Note this is not standard 1 per byte)
   s_axis_ppkt_tlast     : in  std_logic; -- end of packet
   -----------------------------------------------------------------------------
   -- AXI-S PPKT FIFO Output Stream
   -----------------------------------------------------------------------------  
   m_axis_ppkt_tvalid    : out std_logic;
   m_axis_ppkt_tready    : in  std_logic;
   -- Earliest byte in lower byte 
   m_axis_ppkt_tdata     : out std_logic_vector((data_width_bytes*8)-1 downto 0);
   -- tuser[63:0]    = timestamp[63:0]  
   -- tuser[64]      = SOP   
   -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
   -- tuser[67]      = Data Type 0 = Real 1 = I/Q
   -- tuser[75:68]   = channel[7:0]
   -- tuser[79:76]   = user[3:0] These bits only valid only with tlast   
   m_axis_ppkt_tuser     : out std_logic_vector(79 downto 0);
   m_axis_ppkt_tkeep     : out std_logic_vector((data_width_bytes/2)-1 downto 0); -- One per 16-bit word (Note this is not standard 1 per byte)
   m_axis_ppkt_tlast     : out std_logic; -- end of packet
   -----------------------------------------------------------------------------
   -- FIFO External Signals
   -----------------------------------------------------------------------------
   fifo_resetn           : in  std_logic; -- synchronous to axis_aclk
   fifo_ovfl_led         : out std_logic  -- active high indication of FIFO overflow (only when no input tready flow control)
   );
end component;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal s_axi_csr_aclk        : std_logic := '0';
signal s_axi_csr_aresetn     : std_logic := '0';
signal s_axi_csr_awaddr      : std_logic_vector(6 downto 0) := (others => '0');
signal s_axi_csr_awprot      : std_logic_vector(2 downto 0) := (others => '0'); -- not used
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
signal irq                   : std_logic := '0';
signal axis_aclk             : std_logic := '0';
signal axis_aresetn          : std_logic := '0';
signal s_axis_ppkt_tvalid    : std_logic := '0';
signal s_axis_ppkt_tready    : std_logic := '0';
signal s_axis_ppkt_tdata     : std_logic_vector((data_width_bytes*8)-1 downto 0) := (others => '0');
signal s_axis_ppkt_tuser     : std_logic_vector(79 downto 0) := (others => '0');
signal s_axis_ppkt_tkeep     : std_logic_vector((data_width_bytes/2)-1 downto 0) := (others => '1'); -- One per 16-bit word (Note this is not standard 1 per byte)
signal s_axis_ppkt_tlast     : std_logic := '0'; -- end of packet
signal m_axis_ppkt_tvalid    : std_logic := '0';
signal m_axis_ppkt_tready    : std_logic := '0';
signal m_axis_ppkt_tdata     : std_logic_vector((data_width_bytes*8)-1 downto 0) := (others => '0');
signal m_axis_ppkt_tuser     : std_logic_vector(79 downto 0);
signal m_axis_ppkt_tkeep     : std_logic_vector((data_width_bytes/2)-1 downto 0) := (others => '0'); -- One per 16-bit word (Note this is not standard 1 per byte)
signal m_axis_ppkt_tlast     : std_logic := '0'; -- end of packet
signal fifo_resetn           : std_logic := '1'; -- synchronous to axis_aclk
signal fifo_ovfl_led         : std_logic := '0';  -- active high indication of FIFO overflow (only when no input tready flow control)



begin

uut: px_axis_ppkt_uram_fifo
generic map(
    has_in_tready    => true, -- has input tready (overrun is disabled if input flow control is present)
    has_in_reset     => true,
    data_width_bytes => data_width_bytes, -- Number of uram data bytes (must be a valid size that the URAM can be configured for)
    fifo_depth       => fifo_depth, -- Number of uram address bits (must be a valid size that the URAM can be configured for)
    has_fifo_ovfl_led=> true
)
port map ( 
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
--------------------------------------------------------------------------------
   s_axi_csr_aclk        => s_axi_csr_aclk,      
   s_axi_csr_aresetn     => s_axi_csr_aresetn ,  
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
   irq                   => irq,                 

   axis_aclk             => axis_aclk,   
   axis_aresetn          => axis_aresetn,
   -----------------------------------------------------------------------------
   -- AXI-S PPKT FIFO Input Stream
   -----------------------------------------------------------------------------    
   s_axis_ppkt_tvalid    => s_axis_ppkt_tvalid,
   s_axis_ppkt_tready    => s_axis_ppkt_tready,
   -- Earliest byte in lower byte 
   s_axis_ppkt_tdata     => s_axis_ppkt_tdata, 
   -- tuser[63:0]    = timestamp[63:0]  
   -- tuser[64]      = SOP   
   -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
   -- tuser[67]      = Data Type 0 = Real 1 = I/Q
   -- tuser[75:68]   = channel[7:0]
   -- tuser[79:76]   = user[3:0] These bits only valid only with tlast   
   s_axis_ppkt_tuser     => s_axis_ppkt_tuser,
   s_axis_ppkt_tkeep     => s_axis_ppkt_tkeep,
   s_axis_ppkt_tlast     => s_axis_ppkt_tlast,
   -----------------------------------------------------------------------------
   -- AXI-S PPKT FIFO Output Stream
   -----------------------------------------------------------------------------  
   m_axis_ppkt_tvalid    => m_axis_ppkt_tvalid,
   m_axis_ppkt_tready    => m_axis_ppkt_tready,
   -- Earliest byte in lower byte 
   m_axis_ppkt_tdata     => m_axis_ppkt_tdata,
   -- tuser[63:0]    = timestamp[63:0]  
   -- tuser[64]      = SOP   
   -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
   -- tuser[67]      = Data Type 0 = Real 1 = I/Q
   -- tuser[75:68]   = channel[7:0]
   -- tuser[79:76]   = user[3:0] These bits only valid only with tlast   
   m_axis_ppkt_tuser     => m_axis_ppkt_tuser,
   m_axis_ppkt_tkeep     => m_axis_ppkt_tkeep,
   m_axis_ppkt_tlast     => m_axis_ppkt_tlast,
   -----------------------------------------------------------------------------
   -- FIFO External Signals
   -----------------------------------------------------------------------------
   fifo_resetn           => fifo_resetn,   -- synchronous to axis_aclk
   fifo_ovfl_led         => fifo_ovfl_led  -- active high indication of FIFO overflow (only when no input tready flow control)
   );

process
begin
    loop
        wait for 1 ns;
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
variable i : integer := 0;
begin
    wait for 100 ns;
    s_axi_csr_aresetn <= '1';
    wait until rising_edge(axis_aclk);
    axis_aresetn <= '1';
    s_axis_ppkt_tdata  <= (others => '0');
    --m_axis_ppkt_tready <= '1';
    while i < 300 loop
        wait until rising_edge(axis_aclk);
        s_axis_ppkt_tvalid <= '1'; 
        if s_axis_ppkt_tready = '1' then
            s_axis_ppkt_tdata  <= s_axis_ppkt_tdata + 1;
        end if;
        if i = 100 then
           s_axis_ppkt_tlast <= '1'; 
        else
           s_axis_ppkt_tlast <= '0'; 
        end if;
        i := i + 1;
    end loop;
    wait until rising_edge(axis_aclk);
    s_axis_ppkt_tvalid <= '0'; 
    wait for 100 ns;
    wait until rising_edge(axis_aclk);
    m_axis_ppkt_tready <= '1';
    wait;    
end process;
 

end Behavioral;
