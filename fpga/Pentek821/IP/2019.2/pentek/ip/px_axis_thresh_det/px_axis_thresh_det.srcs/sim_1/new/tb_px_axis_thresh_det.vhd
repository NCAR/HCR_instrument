----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/18/2015 03:37:30 PM
-- Design Name: 
-- Module Name: tb_px_axis_thresh_det - Behavioral
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
use ieee.math_real.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

use ieee.numeric_std.ALL;
use work.px_utility_pkg.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_px_axis_thresh_det is
generic (
   data_width     : integer := 16;   -- Data Width
   thresh         : integer := 8192; -- Default Threshold (0 to 4294967296)
   hyst           : integer := 128;  -- Hysteresis Amount Below Threshold (0 to 4294967296 but less than default_thresh)
   en_re_irq      : boolean := true; -- Enable Detection Rising Edge interrupt
   en_fe_irq      : boolean := true; -- Enable Detection Falling Edge interrupt
   max_cnt        : integer := 10000 -- Max Count in test up/down counter
);
end tb_px_axis_thresh_det;

architecture Behavioral of tb_px_axis_thresh_det is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

component px_axis_thresh_det 
generic (
   data_width     : integer := 16;   -- Data Width
   default_thresh : integer := 8192; -- Default Threshold (0 to 4294967296)
   default_hyst   : integer := 128;  -- Hysteresis Amount Below Threshold (0 to 4294967296 but less than default_thresh)
   has_det_axis   : boolean := true; -- Has Detect AXI-S output
   has_irq_out    : boolean := true  -- Has Interrupt output   
);
port (
   ----------------------------------------------------------------------------
   -- AXI4-Lite Control/Status Interface
   ----------------------------------------------------------------------------
   s_axi_csr_aclk      : in  std_logic;
   s_axi_csr_aresetn   : in  std_logic;
   s_axi_csr_awaddr    : in  std_logic_vector(6 downto 0);
   s_axi_csr_awprot    : in  std_logic_vector(2 downto 0);
   s_axi_csr_awvalid   : in  std_logic;
   s_axi_csr_awready   : out std_logic;
   s_axi_csr_wdata     : in  std_logic_vector(31 downto 0);
   s_axi_csr_wstrb     : in  std_logic_vector(3 downto 0);
   s_axi_csr_wvalid    : in  std_logic;
   s_axi_csr_wready    : out std_logic;
   s_axi_csr_bresp     : out std_logic_vector(1 downto 0);
   s_axi_csr_bvalid    : out std_logic;
   s_axi_csr_bready    : in  std_logic;
   s_axi_csr_araddr    : in  std_logic_vector(6 downto 0);
   s_axi_csr_arprot    : in  std_logic_vector(2 downto 0);
   s_axi_csr_arvalid   : in  std_logic;
   s_axi_csr_arready   : out std_logic;
   s_axi_csr_rdata     : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp     : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid    : out std_logic;
   s_axi_csr_rready    : in  std_logic;
   
   irq                 : out std_logic;
   ----------------------------------------------------------------------------
   -- AXI-S Slave Input 
   ----------------------------------------------------------------------------
   axis_aclk          : in  std_logic;
   axis_aresetn       : in  std_logic;
   -- tdata = Unsigned Value 
   s_axis_tdata       : in  std_logic_vector(data_width-1 downto 0);
   s_axis_tvalid      : in  std_logic;
   ----------------------------------------------------------------------------
   -- AXI-S Master Output 
   ----------------------------------------------------------------------------
   -- tdata[0] = Detect   
   m_axis_detect_tdata   : out std_logic_vector(7 downto 0);
   m_axis_detect_tvalid  : out std_logic
);
end component;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal axis_aclk          : std_logic := '0';
signal axis_aresetn       : std_logic := '0';
signal s_axis_tdata       : std_logic_vector(data_width-1 downto 0):= (others => '0');
signal s_axis_tvalid      : std_logic := '0';
signal m_axis_detect_tdata: std_logic_vector(7 downto 0):= (others => '0');
signal m_axis_detect_tvalid: std_logic := '0';
signal s_axi_csr_aclk     : std_logic := '0';
signal s_axi_csr_aresetn  : std_logic := '0';
signal s_axi_csr_awaddr   : std_logic_vector(6 downto 0):= (others => '0');
signal s_axi_csr_awprot   : std_logic_vector(2 downto 0):= (others => '0');
signal s_axi_csr_awvalid  : std_logic := '0';
signal s_axi_csr_awready  : std_logic := '0';
signal s_axi_csr_wdata    : std_logic_vector(31 downto 0):= (others => '0');
signal s_axi_csr_wstrb    : std_logic_vector(3 downto 0):= (others => '0');
signal s_axi_csr_wvalid   : std_logic := '0';
signal s_axi_csr_wready   : std_logic := '0';
signal s_axi_csr_bresp    : std_logic_vector(1 downto 0):= (others => '0');
signal s_axi_csr_bvalid   : std_logic := '0';
signal s_axi_csr_bready   : std_logic := '0';
signal s_axi_csr_araddr   : std_logic_vector(6 downto 0):= (others => '0');
signal s_axi_csr_arprot   : std_logic_vector(2 downto 0):= (others => '0');
signal s_axi_csr_arvalid  : std_logic := '0';
signal s_axi_csr_arready  : std_logic := '0';
signal s_axi_csr_rdata    : std_logic_vector(31 downto 0):= (others => '0');
signal s_axi_csr_rresp    : std_logic_vector(1 downto 0):= (others => '0');
signal s_axi_csr_rvalid   : std_logic := '0';
signal s_axi_csr_rready   : std_logic := '0';
signal irq                : std_logic := '0';
signal dn                 : std_logic := '0';
signal int_en             : std_logic_vector(31 downto 0):= x"00000000";
 
--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------
constant CNTL_REG_ADDR    : std_logic_vector(7 downto 0) := x"00"; 
constant THRESH_REG_ADDR  : std_logic_vector(7 downto 0) := x"04"; 
constant HYST_REG_ADDR    : std_logic_vector(7 downto 0) := x"08"; 
constant STAT_REG_ADDR    : std_logic_vector(7 downto 0) := x"0C"; 
constant IRQ_EN_REG_ADDR  : std_logic_vector(7 downto 0) := x"10"; 
constant IRQ_STAT_REG_ADDR: std_logic_vector(7 downto 0) := x"14"; 
constant IRQ_FLAG_REG_ADDR: std_logic_vector(7 downto 0) := x"18"; 

constant hyst_val         : std_logic_vector(31 downto 0):= conv_std_logic_vector(hyst, 32);
constant thresh_val       : std_logic_vector(31 downto 0):= conv_std_logic_vector(thresh, 32);
--------------------------------------------------------------------------------


begin


uut: px_axis_thresh_det 
generic map (
   data_width     => data_width,     -- Data Width
   default_thresh => 8192, -- Default Threshold (0 to 4294967296)
   default_hyst   => 128,   -- Hysteresis Amount Below Threshold (0 to 4294967296 but less than default_thresh)
   has_det_axis   => true, -- Has Detect AXI-S output
   has_irq_out    => true  -- Has Interrupt output   
)
port map(
   ----------------------------------------------------------------------------
   -- AXI4-Lite Control/Status Interface
   ----------------------------------------------------------------------------
   s_axi_csr_aclk      => s_axi_csr_aclk,   
   s_axi_csr_aresetn   => s_axi_csr_aresetn,
   s_axi_csr_awaddr    => s_axi_csr_awaddr, 
   s_axi_csr_awprot    => s_axi_csr_awprot, 
   s_axi_csr_awvalid   => s_axi_csr_awvalid,
   s_axi_csr_awready   => s_axi_csr_awready,
   s_axi_csr_wdata     => s_axi_csr_wdata,  
   s_axi_csr_wstrb     => s_axi_csr_wstrb,  
   s_axi_csr_wvalid    => s_axi_csr_wvalid, 
   s_axi_csr_wready    => s_axi_csr_wready, 
   s_axi_csr_bresp     => s_axi_csr_bresp,  
   s_axi_csr_bvalid    => s_axi_csr_bvalid, 
   s_axi_csr_bready    => s_axi_csr_bready, 
   s_axi_csr_araddr    => s_axi_csr_araddr, 
   s_axi_csr_arprot    => s_axi_csr_arprot, 
   s_axi_csr_arvalid   => s_axi_csr_arvalid,
   s_axi_csr_arready   => s_axi_csr_arready,
   s_axi_csr_rdata     => s_axi_csr_rdata,  
   s_axi_csr_rresp     => s_axi_csr_rresp, 
   s_axi_csr_rvalid    => s_axi_csr_rvalid,
   s_axi_csr_rready    => s_axi_csr_rready, 
   
   irq                 => irq, 
   ----------------------------------------------------------------------------
   -- AXI-S Slave Input 
   ----------------------------------------------------------------------------
   axis_aclk           => axis_aclk,   
   axis_aresetn        => axis_aresetn,
   -- tdata = Unsigned Value 
   s_axis_tdata        => s_axis_tdata,  
   s_axis_tvalid       => s_axis_tvalid, 
   ----------------------------------------------------------------------------
   -- AXI-S Master Output 
   ----------------------------------------------------------------------------
   -- tdata[0] = Detect   
   m_axis_detect_tdata  => m_axis_detect_tdata, 
   m_axis_detect_tvalid => m_axis_detect_tvalid
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
        wait for 2.0 ns;
        s_axi_csr_aclk <= not s_axi_csr_aclk;
    end loop;    
end process;


process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      if axis_aresetn = '0' then
         s_axis_tdata <= (others => '0');
         dn <= '0';
      elsif s_axis_tvalid = '1' then
         if s_axis_tdata = max_cnt then 
            dn <= '1';
         elsif  s_axis_tdata = 0 then
            dn <= '0';
         end if;  
         if ((dn = '0') and (s_axis_tdata /= max_cnt)) or (s_axis_tdata = 0) then
            s_axis_tdata <= s_axis_tdata + 1;
         else
            s_axis_tdata <= s_axis_tdata - 1;
         end if;   
      end if;
   end if;
end process;

int_en(0) <= '1' when (en_re_irq = true) else '0'; 
int_en(1) <= '1' when (en_fe_irq = true) else '0'; 
   
stim_proc: process
begin
    wait for 400 ns;
    wait until rising_edge(s_axi_csr_aclk);
    s_axi_csr_aresetn <= '1';
    axis_aresetn    <= '1';
    wait until rising_edge(s_axi_csr_aclk);
    wait until rising_edge(s_axi_csr_aclk);
    wait until rising_edge(s_axi_csr_aclk);
    wait until rising_edge(s_axi_csr_aclk);
    assert false
    report "Writing to Threshold Value Register." 
    severity NOTE;
    px_axi_lite_writer(THRESH_REG_ADDR(6 downto 0), thresh_val, s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    assert false
    report "Writing to Hysteresis Value Register." 
    severity NOTE;
    px_axi_lite_writer(HYST_REG_ADDR(6 downto 0), hyst_val, s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    assert false
    report "Clearing Interrupt Flag." 
    severity NOTE;
    px_axi_lite_writer(IRQ_FLAG_REG_ADDR(6 downto 0) ,x"00000003", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);    
    assert false
    report "Enabling Interrupts." 
    severity NOTE;
    px_axi_lite_writer(IRQ_EN_REG_ADDR(6 downto 0) ,int_en, s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);    
    assert false
    report "Writing Reset to Control Register." 
    severity NOTE;
    px_axi_lite_writer(CNTL_REG_ADDR(6 downto 0) ,x"00000001", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);    
    px_axi_lite_writer(CNTL_REG_ADDR(6 downto 0) ,x"00000000", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);    
    wait until rising_edge(axis_aclk);
    s_axis_tvalid <= '1'; 
    wait;
end process;

end Behavioral;
