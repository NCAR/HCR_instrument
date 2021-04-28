----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2015 04:48:33 PM
-- Design Name: 
-- Module Name: tb_px_axis_pwr_meter - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_px_axis_pwr_meter is
generic(
    tc         : real := 0.1; -- Time Constant - fraction 0.000015 to 1.0
    reset_mode : integer := 0 -- 0 = manual only, 1 = gate re, 2 = sync re, 3 = pps re  
);

end tb_px_axis_pwr_meter;

architecture Behavioral of tb_px_axis_pwr_meter is

component px_axis_pwr_meter
generic (
    calc_magnitude   : boolean := true; 
    has_axis_pwr_out : boolean := true;
    has_axis_mag_out : boolean := true  
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
    -- AXI-S Slave Input (Pentek PDTI Type)
    ----------------------------------------------------------------------------

    axis_aclk          : in  std_logic;
    axis_aresetn       : in  std_logic;
    
    -- Only compatible with PDTI format when data is complex and one sample per
    -- clock cycle.
    -- Tiomestamp information is not used by this core
    -- tdata[15:0]  = I[15:0]
    -- tdata[31:16] = Q[15:0]
    -- tuser[64]    = Gate  
    -- tuser[72]    = Sync      
    -- tuser[80]    = PPS 
    s_axis_pdti_tdata  : in  std_logic_vector(31 downto 0);
    s_axis_pdti_tuser  : in  std_logic_vector(127 downto 0);
    s_axis_pdti_tvalid : in  std_logic;
    ----------------------------------------------------------------------------
    -- AXI-S Master Power Output
    ----------------------------------------------------------------------------
    -- Power[31:0] = Unsigned number 
    m_axis_pwr_tdata   : out std_logic_vector(31 downto 0);
    m_axis_pwr_tvalid  : out std_logic;
    ----------------------------------------------------------------------------
    -- AXI-S Master Magnitude Output
    ----------------------------------------------------------------------------
    -- Magnitude[15:0] = Unsigned number 
    m_axis_mag_tdata   : out std_logic_vector(15 downto 0);
    m_axis_mag_tvalid  : out std_logic;
    
    rdy_out            : out std_logic 
    
);
end component;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal axis_aclk          : std_logic := '0';
signal axis_aresetn       : std_logic := '0';
signal s_axis_pdti_tdata  : std_logic_vector(31 downto 0):= (others => '0');
signal s_axis_pdti_tuser  : std_logic_vector(127 downto 0):= (others => '0');
signal s_axis_pdti_tvalid : std_logic := '0';
signal m_axis_pwr_tdata   : std_logic_vector(31 downto 0):= (others => '0');
signal m_axis_pwr_tvalid  : std_logic := '0';
signal m_axis_mag_tdata   : std_logic_vector(15 downto 0):= (others => '0');
signal m_axis_mag_tvalid  : std_logic := '0';
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
signal rdy_out            : std_logic := '0'; 

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------
constant k_real           : real :=  (tc * 65536.0);
constant k_coef           : std_logic_vector(31 downto 0):= conv_std_logic_vector((integer(k_real)), 32); 
constant CNTL_REG_ADDR    : std_logic_vector(7 downto 0) := x"00"; 
constant K_VALUE_REG_ADDR : std_logic_vector(7 downto 0) := x"04"; 
constant POWER_REG_ADDR   : std_logic_vector(7 downto 0) := x"08"; 
constant MAG_REG_ADDR     : std_logic_vector(7 downto 0) := x"0C"; 
constant IRQ_EN_REG_ADDR  : std_logic_vector(7 downto 0) := x"10"; 
constant IRQ_STAT_REG_ADDR: std_logic_vector(7 downto 0) := x"14"; 
constant IRQ_FLAG_REG_ADDR: std_logic_vector(7 downto 0) := x"18"; 

--------------------------------------------------------------------------------

begin

s_axis_pdti_tdata <= x"00008000";

uut: px_axis_pwr_meter
port map ( 
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
    -- AXI-S Slave Input (Pentek PDTI Type)
    ----------------------------------------------------------------------------
    
    axis_aclk           => axis_aclk,   
    axis_aresetn        => axis_aresetn,
    
    -- Only compatible with PDTI format when data is complex and one sample per
    -- clock cycle.
    -- Tiomestamp information is not used by this core
    -- tdata[15:0]  = I[15:0]
    -- tdata[31:16] = Q[15:0]
    -- tuser[64]    = Gate  
    -- tuser[72]    = Sync      
    -- tuser[80]    = PPS 
    s_axis_pdti_tdata   => s_axis_pdti_tdata,  
    s_axis_pdti_tuser   => s_axis_pdti_tuser,  
    s_axis_pdti_tvalid  => s_axis_pdti_tvalid, 
    ----------------------------------------------------------------------------
    -- AXI-S Master Power Output
    ----------------------------------------------------------------------------
    -- Power[31:0] = Unsigned number 
    m_axis_pwr_tdata    => m_axis_pwr_tdata, 
    m_axis_pwr_tvalid   => m_axis_pwr_tvalid,
    ----------------------------------------------------------------------------
    -- AXI-S Master Magnitude Output
    ----------------------------------------------------------------------------
    -- Magnitude[15:0] = Unsigned number 
    m_axis_mag_tdata    => m_axis_mag_tdata, 
    m_axis_mag_tvalid   => m_axis_mag_tvalid,  
       
    rdy_out             => rdy_out 
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
    report "Writing to K Value Register." 
    severity NOTE;
    px_axi_lite_writer(K_VALUE_REG_ADDR(6 downto 0) ,k_coef, s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
    assert false
    report "Clearing Interrupt Flag." 
    severity NOTE;
    px_axi_lite_writer(IRQ_FLAG_REG_ADDR(6 downto 0) ,x"00000001", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);    
    assert false
    report "Enabling Interrupt." 
    severity NOTE;
    px_axi_lite_writer(IRQ_EN_REG_ADDR(6 downto 0) ,x"00000001", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);    
    assert false
    report "Writing Calculation Reset to Control Register." 
    severity NOTE;
    px_axi_lite_writer(CNTL_REG_ADDR(6 downto 0) ,x"00000001", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);    
    px_axi_lite_writer(CNTL_REG_ADDR(6 downto 0) ,x"00000000", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);    
    wait until rising_edge(axis_aclk);
    s_axis_pdti_tvalid <= '1'; 
    wait until (rdy_out = '1');  
    px_axi_lite_reader(POWER_REG_ADDR(6 downto 0),x"00000000",'0', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
    assert false
    report "Power Reading = " & (px_std_logic_vector_to_hstring(s_axi_csr_rdata)) 
    severity NOTE;
    px_axi_lite_reader(MAG_REG_ADDR(6 downto 0),x"00000000",'0', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
    assert false
    report "Magnitude Reading = " & (px_std_logic_vector_to_hstring(s_axi_csr_rdata))      
    severity NOTE;
    wait for 200 ns;
    assert false
    report "Not a Failure, Test Complete."
    severity FAILURE; 
wait;
end process;

end Behavioral;
