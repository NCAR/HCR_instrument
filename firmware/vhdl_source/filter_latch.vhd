----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:35:07 05/20/2008 
-- Design Name: 
-- Module Name:    Filter_Latch - Behavioral 
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

entity FILTER_LATCH is
    Port ( CLK : in  STD_LOGIC;
           STOP_IN : in  STD_LOGIC;
           STOP_OUT : out  STD_LOGIC);
end filter_latch;

architecture Behavioral of FILTER_LATCH is

begin

process (CLK)
begin
	if rising_edge(CLK) then 
		STOP_OUT <= STOP_IN;
	end if;
end process;

end Behavioral;

