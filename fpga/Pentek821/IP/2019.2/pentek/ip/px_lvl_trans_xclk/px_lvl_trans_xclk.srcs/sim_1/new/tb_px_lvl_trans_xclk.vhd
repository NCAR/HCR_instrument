----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2015 03:52:59 PM
-- Design Name: 
-- Module Name: tb_px_lvl_trans_xclk - Behavioral
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
use std.textio.all;

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

entity tb_px_lvl_trans_xclk is
generic(
in_clk_period : time := 4 ns;
out_clk_period : time := 7 ns
);
--  Port ( );
end tb_px_lvl_trans_xclk;

architecture Behavioral of tb_px_lvl_trans_xclk is

--------------------------------------------------------------------------------
-- Component
--------------------------------------------------------------------------------
component px_lvl_trans_xclk
port ( 
    in_clk      : in  std_logic;
    in_sig      : in  std_logic;
    out_sig     : out std_logic;
    out_clk     : in  std_logic
);
end component;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal in_clk      : std_logic := '0';
signal in_sig      : std_logic := '0';
signal out_sig     : std_logic := '0';
signal out_clk     : std_logic := '0';

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------
constant in_clk_period_div2  :time := in_clk_period/2;
constant out_clk_period_div2 :time := out_clk_period/2;
--------------------------------------------------------------------------------

begin

uut: px_lvl_trans_xclk
port map ( 
    in_clk      => in_clk,    
    in_sig      => in_sig,     
    out_sig     => out_sig,   
    out_clk     => out_clk 
);


process
begin
    loop
        wait for in_clk_period_div2;
        in_clk <= not in_clk;
    end loop;
end process;


process
begin
    loop
        wait for out_clk_period_div2;
        out_clk <= not out_clk;
    end loop;
end process;

process
begin
    wait until rising_edge(in_clk);
    wait until rising_edge(in_clk);
    wait until rising_edge(in_clk);
    wait until rising_edge(in_clk);
    wait until rising_edge(in_clk);
    wait until rising_edge(in_clk);
    wait until rising_edge(in_clk);
    wait until rising_edge(in_clk);
    wait until rising_edge(in_clk);
    wait until rising_edge(in_clk);
    in_sig <= '1';
    wait until rising_edge(in_clk);
    in_sig <= '0';
    wait until rising_edge(in_clk);
    in_sig <= '1';
    wait until rising_edge(in_clk);
    in_sig <= '0';
    wait until rising_edge(in_clk);
    in_sig <= '1';
    wait until rising_edge(in_clk);
    in_sig <= '0';
    wait until rising_edge(in_clk);
    wait until rising_edge(in_clk);
    wait until rising_edge(in_clk);
    wait until rising_edge(in_clk);
    wait until rising_edge(in_clk);
    in_sig <= '1';   
    wait until rising_edge(in_clk);
    wait until rising_edge(in_clk);
    wait until rising_edge(in_clk);
    in_sig <= '0';
    wait until rising_edge(in_clk);
    wait until rising_edge(in_clk);
    wait until rising_edge(in_clk);
    wait until rising_edge(in_clk);
    wait until rising_edge(in_clk);
    wait until rising_edge(in_clk);
    wait until rising_edge(in_clk);
    wait until rising_edge(in_clk);
    wait until rising_edge(in_clk);
    wait until rising_edge(in_clk);
    assert false
    report "Test Complete, Not A Failure." 
    severity FAILURE;  
    wait;
end process;

end Behavioral;
