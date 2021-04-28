----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2015 12:28:57 PM
-- Design Name: 
-- Module Name: tb_px_axis_pdti_adv - Behavioral
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
library UNISIM;
use UNISIM.VComponents.all;

Library UNIMACRO;
use UNIMACRO.vcomponents.all;

entity tb_px_axis_pdti_adv is
generic(
    delay_length      : integer := 8;
    dval_div_rate     : integer := 1  
);
end tb_px_axis_pdti_adv;

architecture Behavioral of tb_px_axis_pdti_adv is

constant delay_ctl_width   : integer := 10;
constant data_byte_width   : integer := 2;

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

component px_axis_pdti_adv 
generic (
    has_csr : boolean := true; -- Has register control
    data_byte_width   : integer := 2;  -- Width of input data stream in bytes 
    delay_ctl_width   : integer := 8   -- Width of Delay Control Input when CSR is not present  (1 to 16)
);
port (
    --------------------------------------------------------------------------------
    -- AXI LITE Slave Interface  (optional)
    -- DWORD Addressing
    --------------------------------------------------------------------------------
    s_axi_csr_aclk            : in  std_logic;
    s_axi_csr_aresetn         : in  std_logic;
    s_axi_csr_awaddr          : in  std_logic_vector(2 downto 0);
    s_axi_csr_awprot          : in  std_logic_vector(2 downto 0); -- not used
    s_axi_csr_awvalid         : in  std_logic;
    s_axi_csr_awready         : out std_logic;
    s_axi_csr_wdata           : in  std_logic_vector(31 downto 0);
    s_axi_csr_wstrb           : in  std_logic_vector(3 downto 0); -- not used
    s_axi_csr_wvalid          : in  std_logic;
    s_axi_csr_wready          : out std_logic;
    s_axi_csr_bresp           : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid          : out std_logic;
    s_axi_csr_bready          : in  std_logic;
    s_axi_csr_araddr          : in  std_logic_vector(2 downto 0);
    s_axi_csr_arprot          : in  std_logic_vector(2 downto 0); -- not used
    s_axi_csr_arvalid         : in  std_logic;
    s_axi_csr_arready         : out std_logic;
    s_axi_csr_rdata           : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp           : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid          : out std_logic;
    s_axi_csr_rready          : in  std_logic;
    -----------------------------------------------------------------------------
    -- Optional Control
    -----------------------------------------------------------------------------
    delay_ctl                 : in std_logic_vector(delay_ctl_width-1 downto 0);
    --------------------------------------------------------------------------------
    -- BRAM Interfaces
    --------------------------------------------------------------------------------
    -- Out to BRAM 
    bram_wrport_rst            : out std_logic;
    bram_wrport_clk            : out std_logic;
    bram_wrport_en             : out std_logic;
    bram_wrport_we             : out std_logic_vector(data_byte_width+15 downto 0);
    bram_wrport_addr           : out std_logic_vector(delay_ctl_width-1 downto 0);
    bram_wrport_wrdata         : out std_logic_vector(((data_byte_width*8)-1)+128 downto 0);
    -- From BRAM (expects a 2 cycle latency in BRAM) 
    bram_rdport_rst            : out std_logic;
    bram_rdport_clk            : out std_logic;
    bram_rdport_en             : out std_logic;
    bram_rdport_addr           : out std_logic_vector(delay_ctl_width-1 downto 0);  
    bram_rdport_rddata         : in  std_logic_vector(((data_byte_width*8)-1)+128 downto 0);
    -----------------------------------------------------------------------------
    -- AXI4- Stream Clock
    -----------------------------------------------------------------------------
    s_axis_aclk               : in  std_logic;
    s_axis_aresetn            : in  std_logic;
    -----------------------------------------------------------------------------
    -- Input Data Data/Time/Info Streams (AXI4-Stream Slave) no back pressure
    -----------------------------------------------------------------------------
    -- tuser[63:0]    = timestamp[63:0]
    -- tuser[71:64]   = Gate Positions  
    -- tuser[79:72]   = Sync Positions      
    -- tuser[87:80]   = PPS Positions
    -- tuser[92:88]   = Samples/Cycle
    -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
    -- tuser[95]      = Data Type 0 = Real 1 = I/Q
    -- tuser[103:96]  = channel[7:0] 
    -- tuser[127:104] = Reserved 
    -----------------------------------------------------------------------------
    s_axis_pdti_tdata     : in  std_logic_vector(((data_byte_width*8)-1) downto 0);
    s_axis_pdti_tuser     : in  std_logic_vector(127 downto 0);
    s_axis_pdti_tvalid    : in  std_logic;
    ----------------------------------------------------------------------------
    -- Output
    ----------------------------------------------------------------------------
    m_axis_pdti_tdata     : out std_logic_vector(((data_byte_width*8)-1) downto 0);
    m_axis_pdti_tuser     : out std_logic_vector(127 downto 0);
    m_axis_pdti_tvalid    : out std_logic    
);
end component;

-- Block RAM 64kx256
-- Latency = 2 (output reg)
COMPONENT tb_blk_ram
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    clkb : IN STD_LOGIC;
    enb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(255 DOWNTO 0)
  );
END COMPONENT;

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

constant DELAY_CONTROL : std_logic_vector(delay_ctl_width-1 downto 0) := conv_std_logic_vector((delay_length), delay_ctl_width);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

    --------------------------------------------------------------------------------
    -- AXI LITE Slave Interface  (optional)
    -- DWORD Addressing
    --------------------------------------------------------------------------------
signal    s_axi_csr_aclk            : std_logic := '0';
signal    s_axi_csr_aresetn         : std_logic := '0';
signal    s_axi_csr_awaddr          : std_logic_vector(2 downto 0) := (others => '0');
signal    s_axi_csr_awprot          : std_logic_vector(2 downto 0) := (others => '0'); -- not used
signal    s_axi_csr_awvalid         : std_logic := '0';
signal    s_axi_csr_awready         : std_logic := '0';
signal    s_axi_csr_wdata           : std_logic_vector(31 downto 0) := (others => '0');
signal    s_axi_csr_wstrb           : std_logic_vector(3 downto 0) := (others => '0'); -- not used
signal    s_axi_csr_wvalid          : std_logic := '0';
signal    s_axi_csr_wready          : std_logic := '0';
signal    s_axi_csr_bresp           : std_logic_vector(1 downto 0) := (others => '0');
signal    s_axi_csr_bvalid          : std_logic := '0';
signal    s_axi_csr_bready          : std_logic := '0';
signal    s_axi_csr_araddr          : std_logic_vector(2 downto 0) := (others => '0');
signal    s_axi_csr_arprot          : std_logic_vector(2 downto 0) := (others => '0'); -- not used
signal    s_axi_csr_arvalid         : std_logic := '0';
signal    s_axi_csr_arready         : std_logic := '0';
signal    s_axi_csr_rdata           : std_logic_vector(31 downto 0) := (others => '0');
signal    s_axi_csr_rresp           : std_logic_vector(1 downto 0) := (others => '0');
signal    s_axi_csr_rvalid          : std_logic := '0';
signal    s_axi_csr_rready          : std_logic := '0';
    -----------------------------------------------------------------------------
    -- Optional Control
    -----------------------------------------------------------------------------
signal    delay_ctl                 : std_logic_vector(delay_ctl_width-1 downto 0) := (others => '0');
    --------------------------------------------------------------------------------
    -- BRAM Interfaces
    --------------------------------------------------------------------------------
    -- Out to BRAM 
signal    bram_wrport_rst           : std_logic := '0';                                             
signal    bram_wrport_clk           : std_logic := '0';                                             
signal    bram_wrport_en            : std_logic := '0';                                             
signal    bram_wrport_we            : std_logic_vector(data_byte_width+15 downto 0) := (others => '0');
signal    wrport_we                 : std_logic_vector(31 downto 0) := (others => '0');             
signal    bram_wrport_addr          : std_logic_vector(delay_ctl_width-1 downto 0) := (others => '0');          
signal    bram_wrport_wrdata        : std_logic_vector(((data_byte_width*8)-1)+128 downto 0) := (others => '0');
    -- From BRAM (expects a 2 cycle latency in BRAM) 
signal    bram_rdport_rst           : std_logic := '0';                                             
signal    bram_rdport_clk           : std_logic := '0';                                             
signal    bram_rdport_en            : std_logic := '0';                                             
signal    bram_rdport_addr          : std_logic_vector(delay_ctl_width-1 downto 0) := (others => '0');            
signal    bram_rdport_rddata        : std_logic_vector(((data_byte_width*8)-1)+128 downto 0) := (others => '0');
    -----------------------------------------------------------------------------
    -- AXI4- Stream Clock
    -----------------------------------------------------------------------------
signal    s_axis_aclk               : std_logic := '0';
signal    s_axis_aresetn            : std_logic := '0';
    -----------------------------------------------------------------------------
    -- Input Data Data/Time/Info Streams (AXI4-Stream Slave) no back pressure
    -----------------------------------------------------------------------------
    -- tuser[63:0]    = timestamp[63:0]
    -- tuser[71:64]   = Gate Positions  
    -- tuser[79:72]   = Sync Positions      
    -- tuser[87:80]   = PPS Positions
    -- tuser[92:88]   = Samples/Cycle
    -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
    -- tuser[95]      = Data Type 0 = Real 1 = I/Q
    -- tuser[103:96]  = channel[7:0] 
    -- tuser[127:104] = Reserved 
    -----------------------------------------------------------------------------
signal    s_axis_pdti_tdata     : std_logic_vector(((data_byte_width*8)-1) downto 0) := (others => '0');
signal    s_axis_pdti_tuser     : std_logic_vector(127 downto 0) := (others => '0');
signal    s_axis_pdti_tvalid    : std_logic := '1';
    ----------------------------------------------------------------------------
    -- Output
    ----------------------------------------------------------------------------
signal    m_axis_pdti_tdata     : std_logic_vector(((data_byte_width*8)-1) downto 0) := (others => '0');
signal    m_axis_pdti_tuser     : std_logic_vector(127 downto 0) := (others => '0');
signal    m_axis_pdti_tvalid    : std_logic := '0';  

signal    wrport_addra          : std_logic_vector(9 downto 0):= (others => '0');  
signal    rdport_addrb          : std_logic_vector(9 downto 0):= (others => '0');      
signal    wrport_wrdata         : std_logic_vector(255 downto 0):= (others => '0'); 
signal    rdport_rddata         : std_logic_vector(255 downto 0):= (others => '0');
signal    dval_cntr             : integer := 0;
--------------------------------------------------------------------------------

begin


uut: px_axis_pdti_adv 
generic map (
    has_csr           => false, -- Has register control
    data_byte_width   => 2,     -- Width of input data stream in bytes 
    delay_ctl_width   => 10     -- Width of Delay Control Input when CSR is not present  (1 to 16)
)
port map (
    --------------------------------------------------------------------------------
    -- AXI LITE Slave Interface  (optional)
    -- DWORD Addressing
    --------------------------------------------------------------------------------
    s_axi_csr_aclk            => s_axi_csr_aclk,   
    s_axi_csr_aresetn         => s_axi_csr_aresetn,
    s_axi_csr_awaddr          => s_axi_csr_awaddr, 
    s_axi_csr_awprot          => s_axi_csr_awprot, 
    s_axi_csr_awvalid         => s_axi_csr_awvalid,
    s_axi_csr_awready         => s_axi_csr_awready,
    s_axi_csr_wdata           => s_axi_csr_wdata,  
    s_axi_csr_wstrb           => s_axi_csr_wstrb,  
    s_axi_csr_wvalid          => s_axi_csr_wvalid, 
    s_axi_csr_wready          => s_axi_csr_wready, 
    s_axi_csr_bresp           => s_axi_csr_bresp,  
    s_axi_csr_bvalid          => s_axi_csr_bvalid, 
    s_axi_csr_bready          => s_axi_csr_bready, 
    s_axi_csr_araddr          => s_axi_csr_araddr, 
    s_axi_csr_arprot          => s_axi_csr_arprot, 
    s_axi_csr_arvalid         => s_axi_csr_arvalid,
    s_axi_csr_arready         => s_axi_csr_arready,
    s_axi_csr_rdata           => s_axi_csr_rdata,  
    s_axi_csr_rresp           => s_axi_csr_rresp,  
    s_axi_csr_rvalid          => s_axi_csr_rvalid, 
    s_axi_csr_rready          => s_axi_csr_rready, 
    -----------------------------------------------------------------------------
    -- Optional Control
    -----------------------------------------------------------------------------
    delay_ctl                 => DELAY_CONTROL,
    --------------------------------------------------------------------------------
    -- BRAM Interfaces
    --------------------------------------------------------------------------------
    -- Out to BRAM 
    bram_wrport_rst           =>  bram_wrport_rst,   
    bram_wrport_clk           =>  bram_wrport_clk,   
    bram_wrport_en            =>  bram_wrport_en,    
    bram_wrport_we            =>  bram_wrport_we,    
    bram_wrport_addr          =>  bram_wrport_addr,  
    bram_wrport_wrdata        =>  bram_wrport_wrdata,
    -- From BRAM (expects a 2 cycle latency in BRAM) 
    bram_rdport_rst           =>  bram_rdport_rst,    
    bram_rdport_clk           =>  bram_rdport_clk,    
    bram_rdport_en            =>  bram_rdport_en,     
    bram_rdport_addr          =>  bram_rdport_addr,   
    bram_rdport_rddata        =>  bram_rdport_rddata, 
    -----------------------------------------------------------------------------
    -- AXI4- Stream Clock
    -----------------------------------------------------------------------------
    s_axis_aclk               => s_axis_aclk,   
    s_axis_aresetn            => s_axis_aresetn,
    -----------------------------------------------------------------------------
    -- Input Data Data/Time/Info Streams (AXI4-Stream Slave) no back pressure
    -----------------------------------------------------------------------------
    -- tuser[63:0]    = timestamp[63:0]
    -- tuser[71:64]   = Gate Positions  
    -- tuser[79:72]   = Sync Positions      
    -- tuser[87:80]   = PPS Positions
    -- tuser[92:88]   = Samples/Cycle
    -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
    -- tuser[95]      = Data Type 0 = Real 1 = I/Q
    -- tuser[103:96]  = channel[7:0] 
    -- tuser[127:104] = Reserved 
    -----------------------------------------------------------------------------
    s_axis_pdti_tdata         =>  s_axis_pdti_tdata, 
    s_axis_pdti_tuser         =>  s_axis_pdti_tuser, 
    s_axis_pdti_tvalid        =>  s_axis_pdti_tvalid,
    ----------------------------------------------------------------------------
    -- Output
    ----------------------------------------------------------------------------
    m_axis_pdti_tdata         =>  m_axis_pdti_tdata, 
    m_axis_pdti_tuser         =>  m_axis_pdti_tuser, 
    m_axis_pdti_tvalid        =>  m_axis_pdti_tvalid
);
        
wrport_addra <= conv_std_logic_vector(conv_integer(bram_wrport_addr), 10);  
rdport_addrb <= conv_std_logic_vector(conv_integer(bram_rdport_addr), 10);      
wrport_wrdata(((data_byte_width*8)-1)+128 downto 0) <= bram_wrport_wrdata;   
bram_rdport_rddata <= rdport_rddata(((data_byte_width*8)-1)+128 downto 0);
wrport_we <= x"FFFFFFFF" when (bram_wrport_we(0) = '1') else x"00000000"; 

-- Block RAM Test Memory        
tb_blk_ram_inst : tb_blk_ram
  PORT MAP (
    clka  => bram_wrport_clk,
    ena   => bram_wrport_en,
    wea   => wrport_we,
    addra => wrport_addra,
    dina  => wrport_wrdata,
    clkb  => bram_rdport_clk,
    enb   => bram_rdport_en,
    addrb => rdport_addrb,
    doutb => rdport_rddata
  );           
             
--------------------------------------------------------------------------------
-- Clock Generation
--------------------------------------------------------------------------------
-- AXI-S clock    
process
begin
    wait for 2.5 ns;
    s_axis_aclk <= not s_axis_aclk;
end process;

-- AXI-S clock    
process
begin
    wait for 2 ns;
    s_axi_csr_aclk <= not s_axi_csr_aclk;
end process;

--------------------------------------------------------------------------------
-- Test Stimulation
--------------------------------------------------------------------------------
process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
        if s_axis_aresetn = '0' then
           s_axis_pdti_tdata <= (others => '0');
        else
           if (dval_cntr = dval_div_rate-1) then 
              s_axis_pdti_tdata <= s_axis_pdti_tdata + 1;
              if s_axis_pdti_tdata = x"0000" then
                 s_axis_pdti_tuser(64) <= '1';
              else
                 s_axis_pdti_tuser(64) <= '0';
              end if;
           end if;   
        end if;
    end if;
end process;

process(s_axis_aclk)
begin
    if rising_edge(s_axis_aclk) then
        if s_axis_aresetn = '0' then
           s_axis_pdti_tvalid <= '0';
        else
           if (dval_cntr /= dval_div_rate-1) then
              dval_cntr <= dval_cntr + 1;
              s_axis_pdti_tvalid <= '0';
           else
              dval_cntr <= 0;
              s_axis_pdti_tvalid <= '1';
           end if; 
        end if;
    end if;
end process;


s_axis_pdti_tuser(15 downto 0) <= s_axis_pdti_tdata;

process
begin
wait for 400 ns;
wait until rising_edge(s_axi_csr_aclk);
s_axi_csr_aresetn <= '1';
wait until rising_edge(s_axis_aclk);
s_axis_aresetn    <= '1';
wait;
end process;


end Behavioral;
