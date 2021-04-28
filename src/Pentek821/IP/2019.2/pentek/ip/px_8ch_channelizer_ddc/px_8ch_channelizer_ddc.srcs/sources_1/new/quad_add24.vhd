----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:11:22 10/12/2007 
-- Design Name: 
-- Module Name:    quad_add24 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity quad_add24 is
    generic (
         add_cntr : std_logic := '0' 
         );
    Port ( A_IN : in  STD_LOGIC_VECTOR (23 downto 0);
           B_IN : in  STD_LOGIC_VECTOR (23 downto 0);
           C_IN : in  STD_LOGIC_VECTOR (23 downto 0);
           D_IN : in  STD_LOGIC_VECTOR (23 downto 0);
           CLK : in  STD_LOGIC;
           S_OUT : out  STD_LOGIC_VECTOR (23 downto 0));
end quad_add24;

architecture Behavioral of quad_add24 is


signal ab_sum:std_logic_vector(23 downto 0):= (others => '0');
signal cd_sum:std_logic_vector(23 downto 0):= (others => '0');


begin

process(CLK)
begin
    if rising_edge(CLK) then
      AB_SUM <= A_IN + B_IN;
      CD_SUM <= C_IN + D_IN;   
      if add_cntr = '0' then
        S_OUT <= AB_SUM + CD_SUM;
      else
        S_OUT <= AB_SUM - CD_SUM;
      end if; 
    end if;
end process;

            
end Behavioral;

