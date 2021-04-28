----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/14/2016 09:30:22 AM
-- Design Name: 
-- Module Name: tb_px_ads54j69intrfc - Behavioral
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

entity tb_px_ads54j69intrfc is
generic (
   initial_a_gain_percent: integer := 100;
   initial_a_offset_counts : integer := 0;
   initial_b_gain_percent: integer := 100;
   initial_b_offset_counts : integer := 0;
   initial_pdwnf_a       : boolean := false;
   initial_pdwnf_b       : boolean := false;
   initial_led_select  : integer range 0 to 3 := 0;
   has_ext_led_src     : boolean := true;
   initial_ovld_thresh : integer := 16;  -- counts from full scale
   led_pulse_stretch   : integer range 0 to 65535:= 65535 -- counts to pulse stretch LED
);   
end tb_px_ads54j69intrfc;

architecture Behavioral of tb_px_ads54j69intrfc is

component px_ads54j69intrfc is
generic (
   initial_a_gain_percent: integer := 100;
   initial_a_offset_counts : integer := 0;
   initial_b_gain_percent: integer := 100;
   initial_b_offset_counts : integer := 0;
   initial_pdwnf_a       : boolean := false;
   initial_pdwnf_b       : boolean := false;
   initial_led_select  : integer range 0 to 3 := 0;
   has_ext_led_src     : boolean := true;
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
-- ADS54j69 ADC Input (output from JESD Core)
----------------------------------------------------------------------------
   s_axis_rx_aclk       : in std_logic; -- 125MHz for 500MHz sample rate
   s_axis_rx_tdata      : in std_logic_vector(127 downto 0);
   s_axis_rx_tvalid     : in std_logic;
   
   rx_syncb             : in std_logic;
   sample_clk           : in std_logic; -- 250MHz for 500MHz sample rate

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
   clk_configured           : out std_logic; -- Clock output of ADC has been configured 
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
   m_axis_cha_pd_tdata      : out std_logic_vector(31 downto 0); --CH A
   m_axis_cha_pd_tvalid     : out std_logic;
   m_axis_chb_pd_tdata      : out std_logic_vector(31 downto 0); --CH B
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
-- ADS54j69 ADC Input (output from JESD Core)
----------------------------------------------------------------------------
signal   s_axis_rx_aclk           :  std_logic := '0'; -- 125MHz for 500MHz sample rate
signal   s_axis_rx_tdata          :  std_logic_vector(127 downto 0) := (others => '0');
signal   s_axis_rx_tvalid         :  std_logic := '0';
   
signal   rx_syncb                 :  std_logic := '0';
signal   sample_clk               :  std_logic := '0'; -- 250MHz for 500MHz sample rate

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
signal   adc_ovrld_a              : std_logic := '0';
signal   adc_ovrld_b              : std_logic := '0';
signal   go_trim_ovrld_a          : std_logic := '0';
signal   go_trim_ovrld_b          : std_logic := '0';
----------------------------------------------------------------------------
-- Output
----------------------------------------------------------------------------
signal   m_axis_cha_pd_tdata      : std_logic_vector(31 downto 0) := (others => '0'); --CH A
signal   m_axis_cha_pd_tvalid     : std_logic := '0';
signal   m_axis_chb_pd_tdata      : std_logic_vector(31 downto 0) := (others => '0'); --CH B
signal   m_axis_chb_pd_tvalid     : std_logic := '0';

type data_int_array is array(0 to 1) of std_logic_vector(15 downto 0);
type lanes_array is array(0 to 3) of std_logic_vector(31 downto 0);

signal data_int_a : data_int_array;
signal data_int_b : data_int_array;
                                                                      
signal lanes    : lanes_array;

signal tb_rst                       : std_logic := '1';

signal s_axis_jesd_rx_pd_tvalid     : std_logic := '0';
signal s_axis_jesd_rx_pd_tvalid_reg : std_logic := '0';


begin


uut: px_ads54j69intrfc
generic map(
   initial_a_gain_percent   => initial_a_gain_percent,
   initial_a_offset_counts  => initial_a_offset_counts,
   initial_b_gain_percent   => initial_b_gain_percent,
   initial_b_offset_counts  => initial_b_offset_counts,
   initial_pdwnf_a          => initial_pdwnf_a,
   initial_pdwnf_b          => initial_pdwnf_b,
   initial_led_select       => initial_led_select,
   has_ext_led_src          => has_ext_led_src,
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
-- ADS54j69 ADC Input (output from JESD Core)
----------------------------------------------------------------------------
   s_axis_rx_aclk           => s_axis_rx_aclk,   
   s_axis_rx_tdata          => s_axis_rx_tdata,  
   s_axis_rx_tvalid         => s_axis_rx_tvalid ,
                               
   rx_syncb                 => rx_syncb,         
   sample_clk               => sample_clk,      
   
----------------------------------------------------------------------------
-- Control Outputs
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

process
begin
    loop
        s_axis_rx_aclk <= not s_axis_rx_aclk;
        wait for 4 ns;
    end loop;
end process;

-------------------------------------------------------------------------------
-- Create JESD core output data
------------------------------------------------------------------------------- 

tb_rst               <= '0' after 250 ns;
rx_syncb <= not tb_rst after 100 ns;
   
data_loop_chan: for i in 0 to 1 generate 
    process(tb_rst, s_axis_rx_aclk) begin
         
        if(tb_rst = '1') then
              data_int_a(i)                  <= std_logic_vector(to_unsigned(i, 16));
              data_int_b(i)                  <= std_logic_vector(to_unsigned(i+32768, 16));
              s_axis_jesd_rx_pd_tvalid     <= '0';
              s_axis_jesd_rx_pd_tvalid_reg <= '0';
        elsif(rising_edge(s_axis_rx_aclk)) then
             
             s_axis_jesd_rx_pd_tvalid     <= rx_syncb after 100 ns;
             s_axis_jesd_rx_pd_tvalid_reg <= s_axis_jesd_rx_pd_tvalid;
         
             if(s_axis_jesd_rx_pd_tvalid = '1') then
                 data_int_a(i)    <= data_int_a(i) + 1;
                 data_int_b(i)    <= data_int_b(i) + 1;
             end if;
        end if;
    end process;
end generate;

process(s_axis_jesd_rx_pd_tvalid, s_axis_rx_aclk) begin
    if(rising_edge(s_axis_rx_aclk)) then
        if( s_axis_jesd_rx_pd_tvalid = '1') then
            lanes(0) <= data_int_a(1)(7 downto 0) & data_int_a(1)(15 downto 8) & data_int_a(0)(7 downto 0) & data_int_a(0)(15 downto 8);
            lanes(1) <= data_int_a(1)(7 downto 0) & data_int_a(1)(15 downto 8) & data_int_a(0)(7 downto 0) & data_int_a(0)(15 downto 8);
			
			lanes(2) <= data_int_b(1)(7 downto 0) & data_int_b(1)(15 downto 8) & data_int_b(0)(7 downto 0) & data_int_b(0)(15 downto 8);
			lanes(3) <= data_int_b(1)(7 downto 0) & data_int_b(1)(15 downto 8) & data_int_b(0)(7 downto 0) & data_int_b(0)(15 downto 8);
        end if;
   end if;
end process;

s_axis_rx_tdata  <= lanes(3) & lanes(2) & lanes(1) & lanes(0);
s_axis_rx_tvalid <= s_axis_jesd_rx_pd_tvalid_reg;
			
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
        wait for 5us;
        assert false
        report "Test Complete, Not a Failure."
        severity NOTE;
end process;

                  
end Behavioral;
