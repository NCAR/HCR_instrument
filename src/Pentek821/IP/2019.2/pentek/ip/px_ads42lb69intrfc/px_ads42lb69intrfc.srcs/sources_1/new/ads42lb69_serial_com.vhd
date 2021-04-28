----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/13/2016 11:44:11 AM
-- Design Name: 
-- Module Name: ads42lb69_serial_com - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ads42lb69_serial_com is
port (
   clk       : in  std_logic; 
   rst_n     : in  std_logic;
   data_in   : in  std_logic_vector(7 downto 0);
   addr      : in  std_logic_vector(5 downto 0);
   wr_pls    : in  std_logic;
   rd_pls    : in  std_logic;
   data_out  : out std_logic_vector(7 downto 0);
   sm_rdy    : out std_logic;
   -- adc serial signals
   adc_sdi     : out std_logic;
   adc_sdenb   : out std_logic;
   adc_sclk    : out std_logic;
   adc_sdo     : in  std_logic
);
end ads42lb69_serial_com;

architecture Behavioral of ads42lb69_serial_com is

------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal ser_clk_cntr  : std_logic_vector(4 downto 0);
signal ser_sr_cntr   : std_logic_vector(4 downto 0);
signal sr_cntr_tc    : std_logic;
signal data_out_sr   : std_logic_vector(16 downto 0);
signal data_in_sr    : std_logic_vector(7 downto 0);
signal rd_strch      : std_logic;
signal wr_strch      : std_logic;
signal r_adc_sdi     : std_logic;
signal r_adc_sdenb   : std_logic;
signal r_adc_sclk    : std_logic;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

begin

-- Create a 7.8125MHz Serial data rate from the 250MHz PCIE clock
process(clk)
begin
   if rising_edge(clk) then
      if (rst_n = '0') then
         ser_clk_cntr <= "00000";
      else   
         ser_clk_cntr <= ser_clk_cntr + 1;
      end if;   
   end if;
end process;

-------------------------------------------------------------------------------
-- Shift Register Cycle Counter
-------------------------------------------------------------------------------
process(clk)
begin
   if rising_edge(clk) then
      if (rst_n = '0') then
         ser_sr_cntr <= "00000";  
      elsif (wr_pls = '1') then
         ser_sr_cntr <= "10001";
      elsif(rd_pls = '1') then 
         ser_sr_cntr <= "10001"; 
      elsif  (ser_sr_cntr /= "00000") and (ser_clk_cntr = "11111") then
         ser_sr_cntr <= ser_sr_cntr - 1;
      end if; 
      if (rst_n = '0') then
         sr_cntr_tc  <= '1';
      elsif (ser_clk_cntr = "11111") then
         if (ser_sr_cntr = "00000") then
            sr_cntr_tc  <= '1';
         else
            sr_cntr_tc  <= '0';
         end if;
      end if;
   end if;
end process;

-------------------------------------------------------------------------------
-- Data Output Shift Register
-------------------------------------------------------------------------------
process(clk)
begin
   if rising_edge(clk) then  
      if (rst_n = '0') then
         data_out_sr(16 downto 0) <= (others => '0');  
      elsif ((rd_pls = '1') or (wr_pls = '1')) then
         data_out_sr(16 downto 0) <= '1' & rd_pls & "0" & addr & data_in;
      elsif (sr_cntr_tc = '0') and (ser_clk_cntr = "11111") then
         data_out_sr(16 downto 0) <= data_out_sr(15 downto 0) & '0';
      end if;
   end if;
end process;

-- Generate Write Ready signal
process(clk)
begin   
   if rising_edge(clk) then
      if (rst_n = '0') then 
         wr_strch <= '0';
      elsif WR_PLS = '1' then
         wr_strch <= '1';
      elsif (ser_sr_cntr = "00000")  and (ser_clk_cntr = "00000") then
         wr_strch <= '0';
      end if;
      if (rst_n = '0') then 
         sm_rdy     <= '1'; 
      else   
         sm_rdy     <= not( wr_strch or rd_strch);
      end if;   
   end if;
end process;

-------------------------------------------------------------------------------
-- Data Input Shift Register
-------------------------------------------------------------------------------
process(clk)
begin
   if rising_edge(clk) then
      if (rst_n = '0') then
         data_in_sr(7 downto 0) <= (others => '0'); 
      elsif (sr_cntr_tc = '0') and (ser_clk_cntr = "11111") then
         data_in_sr(7 downto 0) <= data_in_sr(6 downto 0) & adc_sdo;
      end if;   
   end if; 
end process;

process(clk)
begin
   if rising_edge(clk) then
      if (rst_n = '0') then
         data_out <= (others => '0');
      elsif (ser_sr_cntr = "00000")  and (ser_clk_cntr = "00000") and
         (rd_strch = '1') then
         data_out <= data_in_sr;
      end if;
      if (rst_n = '0') then
         rd_strch <= '0';
      elsif rd_pls = '1' then
         rd_strch <= '1';
      elsif (ser_sr_cntr = "00000")  and (ser_clk_cntr = "00000") then
         rd_strch <= '0';
      end if;
   end if;
end process;

-------------------------------------------------------------------------------
-- Output Signals to DAC
-------------------------------------------------------------------------------
process(clk)
begin
   if rising_edge(clk) then  
      if (rst_n = '0') then
         r_adc_sdi   <= '1';
         r_adc_sdenb <= '1';
      else   
      r_adc_sdi   <= data_out_sr(15);
      r_adc_sdenb <= sr_cntr_tc;
      end if;
      if (rst_n = '0') then
         r_adc_sclk  <= '0';
      elsif (ser_clk_cntr(4) = '1') and (sr_cntr_tc = '0') and
         (ser_sr_cntr /= "00000") then
         r_adc_sclk <= '1';
      else
         r_adc_sclk <= '0';
      end if;
   end if;
end process;


adc_sdi   <= r_adc_sdi;  
adc_sdenb <= r_adc_sdenb;
adc_sclk  <= r_adc_sclk; 



end Behavioral;
