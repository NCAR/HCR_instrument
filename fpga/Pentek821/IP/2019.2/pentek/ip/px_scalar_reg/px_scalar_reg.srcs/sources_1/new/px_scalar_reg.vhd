----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 12/12/2019 10:37:32 AM
-- Design Name: 
-- Module Name: px_scalar_reg - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Simple Flip-Flop register with optional CE and sync resetn
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_scalar_reg is
generic( 
    has_ce : boolean := false;
    has_srstn: boolean := false
    );    
port ( 
    d       : in  STD_LOGIC;
    clk     : in  STD_LOGIC;
    q       : out STD_LOGIC;
    ce      : in  STD_LOGIC;
    srstn   : in  STD_LOGIC
    );
end px_scalar_reg;

architecture Behavioral of px_scalar_reg is

begin

process(clk)
begin
    if rising_edge(clk) then
        if (has_srstn = true) and (srstn = '0') then
            q <= '0';
        elsif ((has_ce = true) and (ce = '1')) or (has_ce = false) then
            q <= d;
        end if;
    end if;
end process;    


end Behavioral;
