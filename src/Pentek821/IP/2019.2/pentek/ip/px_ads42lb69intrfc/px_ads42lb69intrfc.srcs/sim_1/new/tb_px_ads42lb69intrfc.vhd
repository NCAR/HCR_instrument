----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/14/2016 09:30:22 AM
-- Design Name: 
-- Module Name: tb_px_ads42lb69intrfc - Behavioral
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
use work.px_utility_pkg.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_px_ads42lb69intrfc is
generic (
   iodelay_grp_a01      : string := "IODELAY_GRP";
   iodelay_grp_a23      : string := "IODELAY_GRP";
   iodelay_grp_a45      : string := "IODELAY_GRP";
   iodelay_grp_a67      : string := "IODELAY_GRP";
   iodelay_grp_a89      : string := "IODELAY_GRP";
   iodelay_grp_a1011    : string := "IODELAY_GRP";
   iodelay_grp_a1213    : string := "IODELAY_GRP";
   iodelay_grp_a1415    : string := "IODELAY_GRP";
   iodelay_grp_b01      : string := "IODELAY_GRP";
   iodelay_grp_b23      : string := "IODELAY_GRP";
   iodelay_grp_b45      : string := "IODELAY_GRP";
   iodelay_grp_b67      : string := "IODELAY_GRP";
   iodelay_grp_b89      : string := "IODELAY_GRP";
   iodelay_grp_b1011    : string := "IODELAY_GRP";
   iodelay_grp_b1213    : string := "IODELAY_GRP";
   iodelay_grp_b1415    : string := "IODELAY_GRP";
   initial_tap_delay    : integer := 0;
   initial_a_gain_percent: integer := 100;
   initial_a_offset_counts : integer := 0;
   initial_b_gain_percent: integer := 100;
   initial_b_offset_counts : integer := 0;
   initial_pdwnf_a       : boolean := false;
   initial_pdwnf_b       : boolean := false;
   initial_led_select  : integer range 0 to 3 := 0;
   differential_term   : string := "TERM_100"; -- "TERM_100" or "TERM_NONE"
   ibuf_low_pwr        : boolean := false;
   has_ext_led_src     : boolean := true;
   idelaycntrl_refclk_freq: integer := 200; -- in MHz
   initial_ovld_thresh : integer := 16;  -- counts from full scale
   led_pulse_stretch   : integer range 0 to 65535:= 65535 -- counts to pulse stretch LED
);   
end tb_px_ads42lb69intrfc;

architecture Behavioral of tb_px_ads42lb69intrfc is

component px_ads42lb69intrfc is
generic (
   iodelay_grp_a01      : string := "IODELAY_GRP";
   iodelay_grp_a23      : string := "IODELAY_GRP";
   iodelay_grp_a45      : string := "IODELAY_GRP";
   iodelay_grp_a67      : string := "IODELAY_GRP";
   iodelay_grp_a89      : string := "IODELAY_GRP";
   iodelay_grp_a1011    : string := "IODELAY_GRP";
   iodelay_grp_a1213    : string := "IODELAY_GRP";
   iodelay_grp_a1415    : string := "IODELAY_GRP";
   iodelay_grp_b01      : string := "IODELAY_GRP";
   iodelay_grp_b23      : string := "IODELAY_GRP";
   iodelay_grp_b45      : string := "IODELAY_GRP";
   iodelay_grp_b67      : string := "IODELAY_GRP";
   iodelay_grp_b89      : string := "IODELAY_GRP";
   iodelay_grp_b1011    : string := "IODELAY_GRP";
   iodelay_grp_b1213    : string := "IODELAY_GRP";
   iodelay_grp_b1415    : string := "IODELAY_GRP";
   initial_tap_delay    : integer := 0;
   initial_a_gain_percent: integer := 100;
   initial_a_offset_counts : integer := 0;
   initial_b_gain_percent: integer := 100;
   initial_b_offset_counts : integer := 0;
   initial_pdwnf_a       : boolean := false;
   initial_pdwnf_b       : boolean := false;
   initial_led_select  : integer range 0 to 3 := 0;
   differential_term   : string := "TERM_100"; -- "TERM_100" or "TERM_NONE"
   ibuf_low_pwr        : boolean := false;
   has_ext_led_src     : boolean := true;
   idelaycntrl_refclk_freq: integer := 200; -- in MHz
   initial_ovld_thresh : integer := 16;  -- counts from full scale
   led_pulse_stretch   : integer range 0 to 65535:= 65535 -- counts to pulse stretch LED
);   
port ( 
----------------------------------------------------------------------------
-- Control/Status Registers (AXI4-LITE)
----------------------------------------------------------------------------
-- associated with s_axi_csr_aclk
   s_axi_csr_aclk           : in  std_logic;
   s_axi_csr_aresetn        : in  std_logic;
   s_axi_csr_awaddr         : in  std_logic_vector(6 downto 0);
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
   s_axi_csr_araddr         : in  std_logic_vector(6 downto 0);
   s_axi_csr_arprot         : in  std_logic_vector(2 downto 0);
   s_axi_csr_arvalid        : in  std_logic;
   s_axi_csr_arready        : out std_logic;
   s_axi_csr_rdata          : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp          : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid         : out std_logic;
   s_axi_csr_rready         : in  std_logic;
    
   irq                      : out std_logic; -- Interrupt out (overload)
----------------------------------------------------------------------------
-- ADS42LB69 ADC Input
----------------------------------------------------------------------------
-- (LVDS)
   da0_p                   : in  std_logic; -- adc data p
   da0_n                   : in  std_logic; -- adc data n
   da2_p                   : in  std_logic; -- adc data p
   da2_n                   : in  std_logic; -- adc data n
   da4_p                   : in  std_logic; -- adc data p
   da4_n                   : in  std_logic; -- adc data n
   da6_p                   : in  std_logic; -- adc data p
   da6_n                   : in  std_logic; -- adc data n
   da8_p                   : in  std_logic; -- adc data p
   da8_n                   : in  std_logic; -- adc data n
   da10_p                  : in  std_logic; -- adc data p
   da10_n                  : in  std_logic; -- adc data n
   da12_p                  : in  std_logic; -- adc data p
   da12_n                  : in  std_logic; -- adc data n
   da14_p                  : in  std_logic; -- adc data p
   da14_n                  : in  std_logic; -- adc data n
   db0_p                   : in  std_logic; -- adc data p
   db0_n                   : in  std_logic; -- adc data n
   db2_p                   : in  std_logic; -- adc data p
   db2_n                   : in  std_logic; -- adc data n
   db4_p                   : in  std_logic; -- adc data p
   db4_n                   : in  std_logic; -- adc data n
   db6_p                   : in  std_logic; -- adc data p
   db6_n                   : in  std_logic; -- adc data n
   db8_p                   : in  std_logic; -- adc data p
   db8_n                   : in  std_logic; -- adc data n
   db10_p                  : in  std_logic; -- adc data p
   db10_n                  : in  std_logic; -- adc data n
   db12_p                  : in  std_logic; -- adc data p
   db12_n                  : in  std_logic; -- adc data n
   db14_p                  : in  std_logic; -- adc data p
   db14_n                  : in  std_logic; -- adc data n
   sample_clk              : in  std_logic; -- Sample Clock input
---------------------------------------------------------------------------- Control Outputs
----------------------------------------------------------------------------
   a_power_down             : out std_logic; --ADC A Power Down Control
   b_power_down             : out std_logic; --ADC B Power Down Control
   spi_miso                 : in  std_logic; --ADC SPI Bus SDOUT
   spi_sclk                 : out std_logic; --ADC SPI Bus SCLK
   spi_mosi                 : out std_logic; --ADC SPI Bus SDATA
   spi_sen                  : out std_logic; --ADC SPI Bus SEN
   
   adc_reset                : out std_logic; --ADC Reset  
   ovld_led_n               : out std_logic; -- overload LED drive
   ext_led_src              : in  std_logic; -- optional ext. LED source in  
----------------------------------------------------------------------------
-- Status Outputs
----------------------------------------------------------------------------
   adc_ovrld_a                : out std_logic;
   adc_ovrld_b                : out std_logic;
   go_trim_ovrld_a            : out std_logic;
   go_trim_ovrld_b            : out std_logic;
----------------------------------------------------------------------------
-- Output
----------------------------------------------------------------------------
   m_axis_cha_pd_tdata      : out std_logic_vector(15 downto 0); --CH A
   m_axis_cha_pd_tvalid     : out std_logic;
   m_axis_chb_pd_tdata      : out std_logic_vector(15 downto 0); --CH B
   m_axis_chb_pd_tvalid     : out std_logic

);

end component;

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------
constant CONTROL_REGISTER_1  : std_logic_vector(6 downto 0) := "000" & x"0";
constant CONTROL_REGISTER_2  : std_logic_vector(6 downto 0) := "000" & x"4";
constant CHA_GO_REGISTER     : std_logic_vector(6 downto 0) := "000" & x"8";
constant CHB_GO_REGISTER     : std_logic_vector(6 downto 0) := "000" & x"C";
constant ADC_SERIAL_CONTROL_REG     : std_logic_vector(6 downto 0) := "001" & x"0";
constant ADC_SERIAL_STATUS_REG      : std_logic_vector(6 downto 0) := "001" & x"4";

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------
----------------------------------------------------------------------------
-- Control/Status Registers (AXI4-LITE)
----------------------------------------------------------------------------
-- associated with s_axi_csr_aclk
signal   s_axi_csr_aclk           :  std_logic := '0';
signal   s_axi_csr_aresetn        :  std_logic := '0';
signal   s_axi_csr_awaddr         :  std_logic_vector(6 downto 0) := (others => '0');
signal   s_axi_csr_awprot         :  std_logic_vector(2 downto 0) := (others => '0');
signal   s_axi_csr_awvalid        :  std_logic := '0';
signal   s_axi_csr_awready        :  std_logic := '0';
signal   s_axi_csr_wdata          :  std_logic_vector(31 downto 0) := (others => '0');
signal   s_axi_csr_wstrb          :  std_logic_vector(3 downto 0) := (others => '0');
signal   s_axi_csr_wvalid         :  std_logic := '0';
signal   s_axi_csr_wready         :  std_logic := '0';
signal   s_axi_csr_bresp          :  std_logic_vector(1 downto 0) := "00";
signal   s_axi_csr_bvalid         :  std_logic := '0';
signal   s_axi_csr_bready         :  std_logic := '0';
signal   s_axi_csr_araddr         :  std_logic_vector(6 downto 0) := (others => '0');
signal   s_axi_csr_arprot         :  std_logic_vector(2 downto 0) := (others => '0');
signal   s_axi_csr_arvalid        :  std_logic := '0';
signal   s_axi_csr_arready        :  std_logic := '0';
signal   s_axi_csr_rdata          :  std_logic_vector(31 downto 0) := (others => '0');
signal   s_axi_csr_rresp          :  std_logic_vector(1 downto 0) := "00";
signal   s_axi_csr_rvalid         :  std_logic := '0';
signal   s_axi_csr_rready         :  std_logic := '0';
    
signal   irq                      :  std_logic := '0'; -- Interrupt (overload)
----------------------------------------------------------------------------
-- ADS42LB69 ADC Input
----------------------------------------------------------------------------
-- (LVDS)
signal   da0_p                   :  std_logic := '0'; -- adc data p
signal   da0_n                   :  std_logic := '1'; -- adc data n
signal   da2_p                   :  std_logic := '0'; -- adc data p
signal   da2_n                   :  std_logic := '1'; -- adc data n
signal   da4_p                   :  std_logic := '0'; -- adc data p
signal   da4_n                   :  std_logic := '1'; -- adc data n
signal   da6_p                   :  std_logic := '0'; -- adc data p
signal   da6_n                   :  std_logic := '1'; -- adc data n
signal   da8_p                   :  std_logic := '0'; -- adc data p
signal   da8_n                   :  std_logic := '1'; -- adc data n
signal   da10_p                  :  std_logic := '0'; -- adc data p
signal   da10_n                  :  std_logic := '1'; -- adc data n
signal   da12_p                  :  std_logic := '0'; -- adc data p
signal   da12_n                  :  std_logic := '1'; -- adc data n
signal   da14_p                  :  std_logic := '0'; -- adc data p
signal   da14_n                  :  std_logic := '1'; -- adc data n
signal   db0_p                   :  std_logic := '0'; -- adc data p
signal   db0_n                   :  std_logic := '1'; -- adc data n
signal   db2_p                   :  std_logic := '0'; -- adc data p
signal   db2_n                   :  std_logic := '1'; -- adc data n
signal   db4_p                   :  std_logic := '0'; -- adc data p
signal   db4_n                   :  std_logic := '1'; -- adc data n
signal   db6_p                   :  std_logic := '0'; -- adc data p
signal   db6_n                   :  std_logic := '1'; -- adc data n
signal   db8_p                   :  std_logic := '0'; -- adc data p
signal   db8_n                   :  std_logic := '1'; -- adc data n
signal   db10_p                  :  std_logic := '0'; -- adc data p
signal   db10_n                  :  std_logic := '1'; -- adc data n
signal   db12_p                  :  std_logic := '0'; -- adc data p
signal   db12_n                  :  std_logic := '1'; -- adc data n
signal   db14_p                  :  std_logic := '0'; -- adc data p
signal   db14_n                  :  std_logic := '1'; -- adc data n
signal   sample_clk              :  std_logic := '0'; -- Sample Clock 
---------------------------------------------------------------------------- 
----------------------------------------------------------------------------
signal   a_power_down             : std_logic := '0'; --ADC A Power Down Control
signal   b_power_down             : std_logic := '0'; --ADC B Power Down Control
signal   spi_miso                 : std_logic := '0'; --ADC SPI Bus SDOUT
signal   spi_sclk                 : std_logic := '0'; --ADC SPI Bus SCLK
signal   spi_mosi                 : std_logic := '0'; --ADC SPI Bus SDATA
signal   spi_sen                  : std_logic := '1'; --ADC SPI Bus SEN
   
signal   adc_reset                : std_logic := '0'; --ADC Reset  
signal   ovld_led_n               : std_logic := '0'; -- overload LED drive
signal   ext_led_src              : std_logic := '0'; -- optional ext. LED source in  
----------------------------------------------------------------------------
-- Status Outputs
----------------------------------------------------------------------------
signal   adc_ovrld_a                : std_logic := '0';
signal   adc_ovrld_b                : std_logic := '0';
signal   go_trim_ovrld_a            : std_logic := '0';
signal   go_trim_ovrld_b            : std_logic := '0';
----------------------------------------------------------------------------
-- Output
----------------------------------------------------------------------------
signal   m_axis_cha_pd_tdata      : std_logic_vector(15 downto 0) := (others => '0'); --CH A
signal   m_axis_cha_pd_tvalid     : std_logic := '0';
signal   m_axis_chb_pd_tdata      : std_logic_vector(15 downto 0) := (others => '0'); --CH B
signal   m_axis_chb_pd_tvalid     : std_logic := '0';
----------------------------------------------------------------------------
-- Test Bench Signals
----------------------------------------------------------------------------
signal   adc_cntr                 : std_logic_vector(15 downto 0) := (others => '0'); --CH A
signal   adc_cntr_inc             : std_logic := '0';
signal   adc_d_p                  : std_logic_vector (7 downto 0) := (others => '0');
signal   adc_d_n                  : std_logic_vector (7 downto 0) := (others => '0');


begin

uut: px_ads42lb69intrfc
generic map(
   iodelay_grp_a01      => iodelay_grp_a01,
   iodelay_grp_a23      => iodelay_grp_a23,
   iodelay_grp_a45      => iodelay_grp_a45,
   iodelay_grp_a67      => iodelay_grp_a67,
   iodelay_grp_a89      => iodelay_grp_a89,
   iodelay_grp_a1011    => iodelay_grp_a1011,
   iodelay_grp_a1213    => iodelay_grp_a1213,
   iodelay_grp_a1415    => iodelay_grp_a1415,
   iodelay_grp_b01      => iodelay_grp_b01,
   iodelay_grp_b23      => iodelay_grp_b23,
   iodelay_grp_b45      => iodelay_grp_b45,
   iodelay_grp_b67      => iodelay_grp_b67,
   iodelay_grp_b89      => iodelay_grp_b89,
   iodelay_grp_b1011    => iodelay_grp_b1011,
   iodelay_grp_b1213    => iodelay_grp_b1213,
   iodelay_grp_b1415    => iodelay_grp_b1415,
   initial_tap_delay    => initial_tap_delay,
   initial_a_gain_percent   => initial_a_gain_percent,
   initial_a_offset_counts  => initial_a_offset_counts,
   initial_b_gain_percent   => initial_b_gain_percent,
   initial_b_offset_counts  => initial_b_offset_counts,
   initial_pdwnf_a          => initial_pdwnf_a,
   initial_pdwnf_b          => initial_pdwnf_b,
   initial_led_select       => initial_led_select,
   differential_term        => differential_term,-- "TERM_100" or "TERM_NONE"
   ibuf_low_pwr             => ibuf_low_pwr,
   has_ext_led_src          => has_ext_led_src,
   idelaycntrl_refclk_freq  => idelaycntrl_refclk_freq, -- in MHz
   initial_ovld_thresh      => initial_ovld_thresh,  -- counts from full scale
   led_pulse_stretch        => led_pulse_stretch -- counts to pulse stretch LED
)  
port map( 
----------------------------------------------------------------------------
-- Control/Status Registers (AXI4-LITE)
----------------------------------------------------------------------------
-- associated with s_axi_csr_aclk
   s_axi_csr_aclk           => s_axi_csr_aclk,
   s_axi_csr_aresetn        => s_axi_csr_aresetn,
   s_axi_csr_awaddr         => s_axi_csr_awaddr,
   s_axi_csr_awprot         => s_axi_csr_awprot,
   s_axi_csr_awvalid        => s_axi_csr_awvalid,
   s_axi_csr_awready        => s_axi_csr_awready,
   s_axi_csr_wdata          => s_axi_csr_wdata,
   s_axi_csr_wstrb          => s_axi_csr_wstrb,
   s_axi_csr_wvalid         => s_axi_csr_wvalid,
   s_axi_csr_wready         => s_axi_csr_wready,
   s_axi_csr_bresp          => s_axi_csr_bresp,
   s_axi_csr_bvalid         => s_axi_csr_bvalid,
   s_axi_csr_bready         => s_axi_csr_bready,
   s_axi_csr_araddr         => s_axi_csr_araddr,
   s_axi_csr_arprot         => s_axi_csr_arprot,
   s_axi_csr_arvalid        => s_axi_csr_arvalid,
   s_axi_csr_arready        => s_axi_csr_arready,
   s_axi_csr_rdata          => s_axi_csr_rdata,
   s_axi_csr_rresp          => s_axi_csr_rresp,
   s_axi_csr_rvalid         => s_axi_csr_rvalid,
   s_axi_csr_rready         => s_axi_csr_rready,
    
   irq                      => irq, -- Interrupt out (overload)
----------------------------------------------------------------------------
-- ADS42LB69 ADC Input
----------------------------------------------------------------------------
-- (LVDS)
   da0_p                   => da0_p, -- adc data p
   da0_n                   => da0_n, -- adc data n
   da2_p                   => da2_p, -- adc data p
   da2_n                   => da2_n, -- adc data n
   da4_p                   => da4_p, -- adc data p
   da4_n                   => da4_n, -- adc data n
   da6_p                   => da6_p, -- adc data p
   da6_n                   => da6_n, -- adc data n
   da8_p                   => da8_p, -- adc data p
   da8_n                   => da8_n, -- adc data n
   da10_p                  => da10_p, -- adc data p
   da10_n                  => da10_n, -- adc data n
   da12_p                  => da12_p, -- adc data p
   da12_n                  => da12_n, -- adc data n
   da14_p                  => da14_p, -- adc data p
   da14_n                  => da14_n, -- adc data n
   db0_p                   => db0_p, -- adc data p
   db0_n                   => db0_n, -- adc data n
   db2_p                   => db2_p, -- adc data p
   db2_n                   => db2_n, -- adc data n
   db4_p                   => db4_p, -- adc data p
   db4_n                   => db4_n, -- adc data n
   db6_p                   => db6_p, -- adc data p
   db6_n                   => db6_n, -- adc data n
   db8_p                   => db8_p, -- adc data p
   db8_n                   => db8_n, -- adc data n
   db10_p                  => db10_p, -- adc data p
   db10_n                  => db10_n, -- adc data n
   db12_p                  => db12_p, -- adc data p
   db12_n                  => db12_n, -- adc data n
   db14_p                  => db14_p, -- adc data p
   db14_n                  => db14_n, -- adc data n
   sample_clk              => sample_clk, -- Sample Clock input
---------------------------------------------------------------------------- Control Outputs
----------------------------------------------------------------------------
   a_power_down             => a_power_down, --ADC A Power Down Control
   b_power_down             => b_power_down, --ADC B Power Down Control
   spi_miso                 => spi_miso, --ADC SPI Bus SDOUT
   spi_sclk                 => spi_sclk, --ADC SPI Bus SCLK
   spi_mosi                 => spi_mosi, --ADC SPI Bus SDATA
   spi_sen                  => spi_sen, --ADC SPI Bus SEN
   
   adc_reset                => adc_reset, --ADC Reset  
   ovld_led_n               => ovld_led_n, -- overload LED drive
   ext_led_src              => ext_led_src, -- optional ext. LED source in  
----------------------------------------------------------------------------
-- Status Outputs
----------------------------------------------------------------------------
   adc_ovrld_a              => adc_ovrld_a,
   adc_ovrld_b              => adc_ovrld_b,
   go_trim_ovrld_a          => go_trim_ovrld_a,
   go_trim_ovrld_b          => go_trim_ovrld_b,
----------------------------------------------------------------------------
-- Output
----------------------------------------------------------------------------
   m_axis_cha_pd_tdata      => m_axis_cha_pd_tdata, --CH A
   m_axis_cha_pd_tvalid     => m_axis_cha_pd_tvalid,
   m_axis_chb_pd_tdata      => m_axis_chb_pd_tdata, --CH B
   m_axis_chb_pd_tvalid     => m_axis_chb_pd_tvalid

);

-------------------------------------------------------------------------------
-- Create the Clock Signals
-------------------------------------------------------------------------------
process
begin
    loop
        s_axi_csr_aclk <= not s_axi_csr_aclk;
        wait for 2 ns;
    end loop;
end process;

process
begin
    loop
        sample_clk <= not sample_clk;
        wait for 2 ns;
    end loop;
end process;

-------------------------------------------------------------------------------
-- Create a ramp to use as ADC data
-------------------------------------------------------------------------------
process(sample_clk)
begin
   if rising_edge(sample_clk) then
      if adc_cntr_inc = '1' then
         adc_cntr <= adc_cntr + 1;
      end if;
   end if;
end process;

-------------------------------------------------------------------------------
-- Format this ramp data to look like ADC unsigned double data rate LVDS data
------------------------------------------------------------------------------- 

adc_d_p <= (adc_cntr(14) & adc_cntr(12) & adc_cntr(10) & adc_cntr(8)  &
            adc_cntr(6)  & adc_cntr(4)  & adc_cntr(2)  & adc_cntr(0))
            when (sample_clk = '1') else
            (adc_cntr(15) & adc_cntr(13) & adc_cntr(11) & adc_cntr(9)  &
             adc_cntr(7)  & adc_cntr(5)  & adc_cntr(3)  & adc_cntr(1));
            
adc_d_n <= ((not adc_cntr(14)) & (not adc_cntr(12)) & (not adc_cntr (10)) & (not adc_cntr(8))  & 
            (not adc_cntr(6))  & (not adc_cntr(4))  & (not adc_cntr(2))  & (not adc_cntr(0)))
            when (sample_clk = '1') else
           ((not adc_cntr(15)) & (not adc_cntr(13)) & (not adc_cntr(11)) & (not adc_cntr(9))  &
            (not adc_cntr(7))  & (not adc_cntr(5))  & (not adc_cntr(3))  & (not adc_cntr(1)));
            
-- Channel A
da0_p <= adc_d_p(0);
da0_n <= adc_d_n(0);
da2_p <= adc_d_p(1);
da2_n <= adc_d_n(1);
da4_p <= adc_d_p(2);
da4_n <= adc_d_n(2);
da6_p <= adc_d_p(3);
da6_n <= adc_d_n(3);
da8_p <= adc_d_p(4);
da8_n <= adc_d_n(4);
da10_p <= adc_d_p(5);
da10_n <= adc_d_n(5);
da12_p <= adc_d_p(6);
da12_n <= adc_d_n(6);
da14_p <= adc_d_p(7);
da14_n <= adc_d_n(7);

-- Channel B
db0_p <= adc_d_p(0);
db0_n <= adc_d_n(0);
db2_p <= adc_d_p(1);
db2_n <= adc_d_n(1);
db4_p <= adc_d_p(2);
db4_n <= adc_d_n(2);
db6_p <= adc_d_p(3);
db6_n <= adc_d_n(3);
db8_p <= adc_d_p(4);
db8_n <= adc_d_n(4);
db10_p <= adc_d_p(5);
db10_n <= adc_d_n(5);
db12_p <= adc_d_p(6);
db12_n <= adc_d_n(6);
db14_p <= adc_d_p(7);
db14_n <= adc_d_n(7);

test_process: process
variable c_time : time    := 0 ns;
variable d_time : time    := 0 ns;
begin
   wait for 400 ns;
   wait until rising_edge(s_axi_csr_aclk);
   s_axi_csr_aresetn <= '1';
   wait for 40 ns;
   c_time := now;
   -----------------------------------------------------------------------------
   -- Set up Control Registers
   -----------------------------------------------------------------------------
        assert false
        report "Writing to ADC Serial Control Register. Toggle Serial Access Bit. Start time =" & time'image(now)
        severity NOTE;
        px_axi_lite_writer(ADC_SERIAL_CONTROL_REG, x"00800601", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);           
        px_axi_lite_writer(ADC_SERIAL_CONTROL_REG, x"00800600", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);           
        
        d_time := now - c_time;   
        assert false
        report "Finished writing to the ADC Serial Interface Control Register. Start Time = " & time'image(now)
        Severity NOTE;
        
        wait for 10ns;
        wait until rising_edge(sample_clk);
        adc_cntr_inc <= '1';
        wait for 5us;
        assert false
        report "Test Complete, Not a Failure."
        severity NOTE;
end process;

                  
end Behavioral;
