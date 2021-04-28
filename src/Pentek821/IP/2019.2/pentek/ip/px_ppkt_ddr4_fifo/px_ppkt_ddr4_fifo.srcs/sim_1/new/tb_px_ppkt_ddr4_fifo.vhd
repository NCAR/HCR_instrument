----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/15/2016 02:59:03 PM
-- Design Name: 
-- Module Name: tb_px_ppkt_ddr4_fifo - Behavioral
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
use std.textio.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use ieee.numeric_std.ALL;
use work.px_utility_pkg.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_px_ppkt_ddr4_fifo is
generic (
    in_tdata_bytes   : integer := 16; -- number of input tdata bytes  2,4,8,16,32,64
    out_tdata_bytes  : integer := 32  -- number of output tdata bytes 32,64
);
end tb_px_ppkt_ddr4_fifo;

architecture Behavioral of tb_px_ppkt_ddr4_fifo is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

component px_ppkt_ddr4_fifo
generic (
    id : integer := 0; -- 0-255
    has_in_tready : boolean := true; -- has input tready  
    in_tdata_bytes   : integer := 4; -- number of input tdata bytes  2,4,8,16,32,64
    out_tdata_bytes  : integer := 32;  -- number of output tdata bytes 16,32,64
    default_strt_addr: std_logic_vector(31 downto 0) := x"00000000"; -- FIFO Start Address
    default_dw_size  : std_logic_vector(31 downto 0) := x"40000000" -- FIFO Size in 32-bit DWords
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
   -----------------------------------------------------------------------------
   -- AXI-S PPKT FIFO Input Stream
   -----------------------------------------------------------------------------
   axis_ppkt_aclk        : in  std_logic;
   axis_ppkt_aresetn     : in  std_logic; 
   s_axis_ppkt_tvalid    : in  std_logic;
   s_axis_ppkt_tready    : out std_logic;
   -- Earliest byte in lower byte 
   s_axis_ppkt_tdata     : in  std_logic_vector((in_tdata_bytes*8)-1 downto 0);
   -- tuser[63:0]    = timestamp[63:0]  
   -- tuser[64]      = SOP   
   -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
   -- tuser[67]      = Data Type 0 = Real 1 = I/Q
   -- tuser[75:68]   = channel[7:0]
   -- tuser[79:76]   = user[3:0] These bits only valid only with tlast   
   s_axis_ppkt_tuser     : in  std_logic_vector(79 downto 0);
   s_axis_ppkt_tkeep     : in  std_logic_vector((in_tdata_bytes/2)-1 downto 0); -- One per 16-bit word
   s_axis_ppkt_tlast     : in  std_logic; -- end of packet
   -----------------------------------------------------------------------------
   -- AXI-S PPKT FIFO Output Stream
   -----------------------------------------------------------------------------    
   m_axis_ppkt_tvalid    : out std_logic;
   m_axis_ppkt_tready    : in  std_logic;
   -- Earliest byte in lower byte 
   m_axis_ppkt_tdata     : out std_logic_vector((out_tdata_bytes*8)-1  downto 0);
   -- tuser[63:0]    = timestamp[63:0]  
   -- tuser[64]      = SOP   
   -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
   -- tuser[67]      = Data Type 0 = Real 1 = I/Q
   -- tuser[75:68]   = channel[7:0]
   -- tuser[79:76]   = user[3:0] These bits only valid only with tlast   
   m_axis_ppkt_tuser     : out std_logic_vector(79 downto 0);
   m_axis_ppkt_tkeep     : out std_logic_vector((out_tdata_bytes/2)-1  downto 0); -- One per 16-bit word
   m_axis_ppkt_tlast     : out std_logic; -- end of packet
   -----------------------------------------------------------------------------
   -- DDR4 Request Interface (AXI Stream)
   ----------------------------------------------------------------------------  
   axis_ddr_aclk         : in  std_logic;
   axis_ddr_aresetn      : in  std_logic;
   -- tuser[127:0]   = Request Header
   -- tuser[31:0]    = Address (Address must be aligned to the request size boundaries)
   -- tuser[34:32]   = Future Address Expansion
   -- tuser[35]      = Read = 1, Write = 0
   -- tuser[39:36]   = Reserved
   -- tuser[119:40]  = Byte Masks
   -- tuser[255:128] = Upper 128-bits of RAM Data 
   m_axis_rqst_tvalid    : out std_logic;
   m_axis_rqst_tready    : in  std_logic;   
   m_axis_rqst_tlast     : out std_logic;
   m_axis_rqst_tid       : out std_logic_vector(7 downto 0);
   m_axis_rqst_tdata     : out std_logic_vector(511 downto 0); 
   m_axis_rqst_tuser     : out std_logic_vector(255 downto 0);
   ----------------------------------------------------------------------------
   -- DDR4 Response Interface (AXI Stream)
   ----------------------------------------------------------------------------
   -- tuser[127:0] = Response Header
   -- tuser[31:0]  = Address (Address must be aligned to the request size boundaries)
   -- tuser[34:32] = Future Address Expansion
   -- tuser[39:36] = Reserved
   -- tuser[119:40]= Byte Masks 
   -- tuser[255:128] = Upper 128-bits of RAM Data 
   s_axis_rsp_tvalid     : in  std_logic;
   s_axis_rsp_tlast      : in  std_logic;
   s_axis_rsp_tid        : in  std_logic_vector(7 downto 0);
   s_axis_rsp_tdata      : in  std_logic_vector(511 downto 0); 
   s_axis_rsp_tuser      : in  std_logic_vector(255 downto 0);
   -----------------------------------------------------------------------------
   -- Misc.
   -----------------------------------------------------------------------------
   bypass_full_led_in      : in std_logic;  -- optional external fifo full signal input to use for bypass mode
   fifo_full_led           : out  std_logic -- active high indication of FIFO overflow
   );
end component px_ppkt_ddr4_fifo;

type mem_array is array (0 to 1023) of std_logic_vector(639 downto 0);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
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
signal   irq                   : std_logic := '0';
-----------------------------------------------------------------------------
-- AXI-S PPKT FIFO Input Stream
-----------------------------------------------------------------------------
signal axis_ppkt_aclk        : std_logic := '0';
signal axis_ppkt_aresetn     : std_logic := '0'; 
signal s_axis_ppkt_tvalid    : std_logic := '0';
signal s_axis_ppkt_tready    : std_logic := '0';
-- Earliest byte in lower byte 
signal s_axis_ppkt_tdata     : std_logic_vector((in_tdata_bytes*8)-1 downto 0) := (others => '0');
signal s_axis_ppkt_tuser     : std_logic_vector(79 downto 0) := (others => '0');
signal s_axis_ppkt_tkeep     : std_logic_vector((in_tdata_bytes/2)-1 downto 0) := (others => '0'); -- One per 16-bit word
signal s_axis_ppkt_tlast     : std_logic := '0'; -- end of packet
-----------------------------------------------------------------------------
-- AXI-S PPKT FIFO Output Stream
-----------------------------------------------------------------------------    
signal m_axis_ppkt_tvalid    : std_logic := '0';
signal m_axis_ppkt_tready    : std_logic := '0';
signal m_axis_ppkt_tdata     : std_logic_vector((out_tdata_bytes*8)-1 downto 0) := (others => '0');
signal m_axis_ppkt_tuser     : std_logic_vector(79 downto 0) := (others => '0');
signal m_axis_ppkt_tkeep     : std_logic_vector((out_tdata_bytes/2)-1 downto 0) := (others => '0'); -- One per 16-bit word
signal m_axis_ppkt_tlast     : std_logic := '0'; -- end of packet
-----------------------------------------------------------------------------
-- DDR4 Request Interface (AXI Stream)
----------------------------------------------------------------------------  
signal axis_ddr_aclk         : std_logic := '0';
signal axis_ddr_aresetn      : std_logic := '0';
signal m_axis_rqst_tvalid    : std_logic := '0';
signal m_axis_rqst_tready    : std_logic := '0';   
signal m_axis_rqst_tlast     : std_logic := '0';
signal m_axis_rqst_tid       : std_logic_vector(7 downto 0) := (others => '0');
signal m_axis_rqst_tdata     : std_logic_vector(511 downto 0) := (others => '0'); 
signal m_axis_rqst_tuser     : std_logic_vector(255 downto 0) := (others => '0');
----------------------------------------------------------------------------
-- DDR4 Response Interface (AXI Stream)
----------------------------------------------------------------------------
signal s_axis_rsp_tvalid     : std_logic := '0';
signal s_axis_rsp_tlast      : std_logic := '0';
signal s_axis_rsp_tid        : std_logic_vector(7 downto 0) := (others => '0');
signal s_axis_rsp_tdata      : std_logic_vector(511 downto 0) := (others => '0'); 
signal s_axis_rsp_tuser      : std_logic_vector(255 downto 0) := (others => '0');

-----------------------------------------------------------------------------
-- Misc.
-----------------------------------------------------------------------------
signal bypass_full_led_in    : std_logic := '0'; -- optional external fifo full signal input to use for bypass mode
signal fifo_full_led         : std_logic := '0'; -- active high indication of FIFO overflow

signal ddr4                  : mem_array;

constant FIFO_CNTL_REG  : std_logic_vector(6 downto 0)       := "0000000";
constant FIFO_STRT_REG  : std_logic_vector(6 downto 0)       := "0000100";
constant FIFO_SIZE_REG  : std_logic_vector(6 downto 0)       := "0001000";
constant FIFO_FLUSH_REG : std_logic_vector(6 downto 0)       := "0001100";
constant FIFO_SIZE : std_logic_vector(31 downto 0) := conv_std_logic_vector(16384, 32); -- Number of DWords (1023*64/4)
--------------------------------------------------------------------------------

begin

uut: px_ppkt_ddr4_fifo
generic map(
    id => 0, -- 0-255 
    has_in_tready => false,
    in_tdata_bytes   => in_tdata_bytes, -- number of input tdata bytes  2,4,8,16,32,64
    out_tdata_bytes  => out_tdata_bytes,  -- number of output tdata bytes 32,64
    default_strt_addr => x"00000000", -- FIFO Start Address
    default_dw_size => x"40000000" -- FIFO Size in 32-bit DWords
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
   irq                   => irq,                
   -----------------------------------------------------------------------------
   -- AXI-S PPKT FIFO Input Stream
   -----------------------------------------------------------------------------
   axis_ppkt_aclk        => axis_ppkt_aclk,           
   axis_ppkt_aresetn     => axis_ppkt_aresetn,       
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
   -- DDR4 Request Interface (AXI Stream)
   ----------------------------------------------------------------------------  
   axis_ddr_aclk     => axis_ddr_aclk,       
   axis_ddr_aresetn  => axis_ddr_aresetn,   
   -- tuser[127:0]   = Request Header
   -- tuser[31:0]    = Address (Address must be aligned to the request size boundaries)
   -- tuser[34:32]   = Future Address Expansion
   -- tuser[35]      = Read = 1, Write = 0
   -- tuser[39:36]   = Reserved
   -- tuser[119:40]  = Byte Masks
   -- tuser[255:128] = Upper 128-bits of RAM Data 
   m_axis_rqst_tvalid    => m_axis_rqst_tvalid,
   m_axis_rqst_tready    => m_axis_rqst_tready,
   m_axis_rqst_tlast     => m_axis_rqst_tlast, 
   m_axis_rqst_tid       => m_axis_rqst_tid,   
   m_axis_rqst_tdata     => m_axis_rqst_tdata, 
   m_axis_rqst_tuser     => m_axis_rqst_tuser, 
   ----------------------------------------------------------------------------
   -- DDR4 Response Interface (AXI Stream)
   ----------------------------------------------------------------------------
   -- tuser[127:0] = Response Header
   -- tuser[31:0]  = Address (Address must be aligned to the request size boundaries)
   -- tuser[34:32] = Future Address Expansion
   -- tuser[39:36] = Reserved
   -- tuser[119:40]= Byte Masks 
   -- tuser[255:128] = Upper 128-bits of RAM Data 
   s_axis_rsp_tvalid     => s_axis_rsp_tvalid,
   s_axis_rsp_tlast      => s_axis_rsp_tlast,  
   s_axis_rsp_tid        => s_axis_rsp_tid,    
   s_axis_rsp_tdata      => s_axis_rsp_tdata,  
   s_axis_rsp_tuser      => s_axis_rsp_tuser,
   
   bypass_full_led_in    => bypass_full_led_in,
   fifo_full_led         => fifo_full_led     
   );                   


--------------------------------------------------------------------------------
-- Generate Clocks
--------------------------------------------------------------------------------
process
begin
    loop
        wait for 1.67 ns;
        axis_ddr_aclk <= not axis_ddr_aclk;
    end loop;
end process; 

process
begin
    loop
        wait for 1.11 ns;
        axis_ppkt_aclk <= not axis_ppkt_aclk;
    end loop;
end process; 


process
begin
    loop
        wait for 2 ns;
        s_axi_csr_aclk <= not s_axi_csr_aclk;
    end loop;
end process;      


--------------------------------------------------------------------------------
-- Simulate Memory Storage
--------------------------------------------------------------------------------

process(axis_ddr_aclk)
begin
    if rising_edge(axis_ddr_aclk) then
        if ((m_axis_rqst_tready = '1') and (m_axis_rqst_tvalid = '1') and (m_axis_rqst_tuser(35) = '0')) then
            ddr4(conv_integer(m_axis_rqst_tuser(21 downto 6)))(639 downto 0) <= m_axis_rqst_tuser(255 downto 128) & m_axis_rqst_tdata; 
        end if; 
    end if;
end process;  

process(axis_ddr_aclk)
begin
    if rising_edge(axis_ddr_aclk) then
        if ((m_axis_rqst_tready = '1') and (m_axis_rqst_tvalid = '1') and (m_axis_rqst_tuser(35) = '1')) then
            s_axis_rsp_tdata                 <= ddr4(conv_integer(m_axis_rqst_tuser(21 downto 6)))(511 downto 0);
            s_axis_rsp_tuser(255 downto 128) <= ddr4(conv_integer(m_axis_rqst_tuser(21 downto 6)))(639 downto 512);
            s_axis_rsp_tuser(127 downto 0)   <= m_axis_rqst_tuser(127 downto 0); 
            s_axis_rsp_tlast                 <= m_axis_rqst_tlast;
            s_axis_rsp_tvalid                <= '1';
            s_axis_rsp_tid                   <= m_axis_rqst_tid;
        else
            s_axis_rsp_tvalid                <= '0';   
        end if; 
    end if;
end process;  

--------------------------------------------------------------------------------
-- Generate Input Stream
--------------------------------------------------------------------------------
stim: process
begin
    wait for 100 ns;
    wait until rising_edge(s_axi_csr_aclk);   
    s_axi_csr_aresetn <= '1';  
    wait until rising_edge(axis_ppkt_aclk);   
    wait until rising_edge(axis_ppkt_aclk); 
    axis_ppkt_aresetn <= '1';  
    wait until rising_edge(axis_ddr_aclk); 
    axis_ddr_aresetn    <= '1';
    wait until rising_edge(axis_ppkt_aclk);   
    wait until rising_edge(axis_ppkt_aclk);   
    wait until rising_edge(axis_ppkt_aclk);
    m_axis_ppkt_tready <= '1';
    -- Set FIFO Size
    px_axi_lite_writer( FIFO_SIZE_REG, FIFO_SIZE, s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    -- Set FIFO Output Read Disable (holds data in FIFO without allowing it to flow out the output)
    px_axi_lite_writer( FIFO_CNTL_REG, x"00002F01", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    wait until rising_edge(axis_ppkt_aclk);  
    s_axis_ppkt_tdata(15 downto 0)  <= x"FFFF";   
    -- Send data until it fills
 for i in 0 to 8000 loop
    wait until rising_edge(axis_ppkt_aclk);   
    m_axis_rqst_tready <= '1'; 
    s_axis_ppkt_tvalid <= '1';
    s_axis_ppkt_tdata(15 downto 0)  <= s_axis_ppkt_tdata(15 downto 0) + 1;
    s_axis_ppkt_tuser <= (others => '0');
    s_axis_ppkt_tkeep <= (others => '1');
    if (i = 8000) then
       s_axis_ppkt_tlast <= '1';
    else
       s_axis_ppkt_tlast <= '0';
    end if;
    --wait until rising_edge(axis_ppkt_aclk);
    --s_axis_ppkt_tvalid <= '0';
 end loop;   
    wait until rising_edge(axis_ppkt_aclk);   
    s_axis_ppkt_tvalid <= '0';
    for i in 0 to 64 loop
       wait until rising_edge(axis_ppkt_aclk); 
    end loop; 
    -- Set FIFO Output Read Enabled (release FIFO data to flow out the output)
    px_axi_lite_writer( FIFO_CNTL_REG, x"00002F00", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);  
    --wait for it to empty
    wait for 10000 ns;   
    wait until rising_edge(axis_ppkt_aclk);
    s_axis_ppkt_tdata(15 downto 0)  <= x"FFFF";
    wait until rising_edge(axis_ppkt_aclk);
    m_axis_ppkt_tready <= '0';
    -- Write Data to it again and let it fill up before testing FIFO Flush
    wait until rising_edge(axis_ppkt_aclk); 
    for i in 0 to 8000 loop
       wait until rising_edge(axis_ppkt_aclk);   
       m_axis_rqst_tready <= '1'; 
       s_axis_ppkt_tvalid <= '1';
       s_axis_ppkt_tdata(15 downto 0)  <= s_axis_ppkt_tdata(15 downto 0) + 1;
       s_axis_ppkt_tuser <= (others => '0');
       s_axis_ppkt_tkeep <= (others => '1');
       s_axis_ppkt_tlast <= '0';
--       if (i = 1002) then
--       -- FIFO Flush  
--       px_axi_lite_writer( FIFO_FLUSH_REG, x"00000001", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
--       for i in 0 to 10 loop
--          wait until rising_edge(s_axi_csr_aclk); 
--       end loop;  
--       px_axi_lite_writer( FIFO_FLUSH_REG, x"00000000", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
--       end if;
    end loop;   
    wait until rising_edge(axis_ppkt_aclk);   
    s_axis_ppkt_tvalid <= '0';
    for i in 0 to 64 loop
       wait until rising_edge(axis_ppkt_aclk); 
    end loop; 
    -- FIFO Flush  
    px_axi_lite_writer( FIFO_FLUSH_REG, x"00000001", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    for i in 0 to 10 loop
       wait until rising_edge(s_axi_csr_aclk); 
    end loop;  
    px_axi_lite_writer( FIFO_FLUSH_REG, x"00000000", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    wait until rising_edge(axis_ppkt_aclk);
    m_axis_ppkt_tready <= '1';
    wait until rising_edge(axis_ppkt_aclk); 
    for i in 0 to 64 loop
      wait until rising_edge(axis_ppkt_aclk); 
    end loop; 
    s_axis_ppkt_tdata(15 downto 0)  <= x"FFFF";
    -- Write data to the FIFO with output allowed
    for i in 0 to 8000 loop
       wait until rising_edge(axis_ppkt_aclk);   
       m_axis_rqst_tready <= '1'; 
       s_axis_ppkt_tvalid <= '1';
       s_axis_ppkt_tdata(15 downto 0)  <= s_axis_ppkt_tdata(15 downto 0) + 1;
       s_axis_ppkt_tuser <= (others => '0');
       s_axis_ppkt_tkeep <= (others => '1');
       s_axis_ppkt_tlast <= '0';
       --wait until rising_edge(axis_ppkt_aclk);
       --s_axis_ppkt_tvalid <= '0';
    end loop;   
    wait until rising_edge(axis_ppkt_aclk);   
    s_axis_ppkt_tvalid <= '0';
    for i in 0 to 64 loop
       wait until rising_edge(axis_ppkt_aclk); 
    end loop;  
    -- Bypass FIFO (Input directly from in to out)
    px_axi_lite_writer( FIFO_CNTL_REG, x"00002F02", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    for i in 0 to 64 loop
      wait until rising_edge(axis_ppkt_aclk); 
    end loop; 
    s_axis_ppkt_tdata(15 downto 0)  <= x"FFFF";
    for i in 0 to 8000 loop
       wait until rising_edge(axis_ppkt_aclk);   
       m_axis_rqst_tready <= '1'; 
       s_axis_ppkt_tvalid <= '1';
       s_axis_ppkt_tdata(15 downto 0)  <= s_axis_ppkt_tdata(15 downto 0) + 1;
       s_axis_ppkt_tuser <= (others => '0');
       s_axis_ppkt_tkeep <= (others => '1');
       s_axis_ppkt_tlast <= '0';
       --wait until rising_edge(axis_ppkt_aclk);
       --s_axis_ppkt_tvalid <= '0';
    end loop;   
    wait until rising_edge(axis_ppkt_aclk);   
    s_axis_ppkt_tvalid <= '0';  
    wait;      
end process;



end Behavioral;
