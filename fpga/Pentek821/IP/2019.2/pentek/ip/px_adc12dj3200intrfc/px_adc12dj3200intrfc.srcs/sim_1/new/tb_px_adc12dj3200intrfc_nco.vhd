----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/04/2017 10:42:05 AM
-- Design Name: 
-- Module Name: tb_px_adc12dj3200intrfc_nco - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_px_adc12dj3200intrfc_nco is
--  Port ( );
end tb_px_adc12dj3200intrfc_nco;

architecture Behavioral of tb_px_adc12dj3200intrfc_nco is

constant adc_sample_clk_half_p  : time := 1.25 ns;

signal adc_sample_clk           : std_logic := '0';
                                
signal nco_src                  : std_logic := '1';
signal nco_soft_sel             : std_logic_vector(1 downto 0)  := "00";
signal nco_cntrl_rst            : std_logic := '1';
signal nco_cntrl_en             : std_logic := '0';
signal nco_cntrl_start          : std_logic := '0';
signal nco_sel_auto_cntrs       : std_logic_vector(31 downto 0) := x"02020202";
signal nco_auto_cntr_incr_src   : std_logic_vector(1 downto 0)  := "00";

signal s_axis_timecntl_tvalid   : std_logic := '0';
signal s_axis_timecntl_tdata    : std_logic_vector(31 downto 0) := X"00000000";

signal adc_nco_out              : std_logic_vector(1 downto 0) := "00";

signal gate                     : std_logic := '0';

component px_adc12dj3200intrfc_nco 
port 
(
    adc_sample_clk           : in std_logic;
                             
    nco_src                  : in std_logic;
    nco_soft_sel             : in std_logic_vector(1 downto 0);
    nco_cntrl_rst            : in std_logic;
    nco_cntrl_en             : in std_logic;
    nco_cntrl_start          : in std_logic;
    nco_auto_cntr_incr_src   : in std_logic_vector(1 downto 0);
    nco_sel_auto_cntrs       : in std_logic_vector(31 downto 0);
    
    s_axis_timecntl_tvalid   : in std_logic;
    s_axis_timecntl_tdata    : in std_logic_vector(31 downto 0);

    adc_nco_out              : out std_logic_vector(1 downto 0)
);

end component;


begin

adc_sample_clk <= not adc_sample_clk after adc_sample_clk_half_p;

nco_cntrl_rst   <= '0' after 100 us;
nco_cntrl_start <= '1' after 200 us;
nco_cntrl_en    <= '1' after 300 us;

 

nco_soft_sel <= nco_soft_sel + 1 after 10 us;

gate        <= (not gate) after 1 us;

s_axis_timecntl_tdata(0) <= gate; 

dut: px_adc12dj3200intrfc_nco 
port map
(
    adc_sample_clk         => adc_sample_clk,        
                            
    nco_src                => nco_src,           
    nco_soft_sel           => nco_soft_sel,
    nco_cntrl_rst          => nco_cntrl_rst,          
    nco_cntrl_en           => nco_cntrl_en,       
    nco_cntrl_start        => nco_cntrl_start,
    nco_auto_cntr_incr_src => nco_auto_cntr_incr_src,
    nco_sel_auto_cntrs     => nco_sel_auto_cntrs,    
                            
    s_axis_timecntl_tvalid => s_axis_timecntl_tvalid,
    s_axis_timecntl_tdata  => s_axis_timecntl_tdata, 
                            
    adc_nco_out            => adc_nco_out               
);


    


end Behavioral;