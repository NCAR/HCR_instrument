----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/28/2015 11:36:03 AM
-- Design Name: 
-- Module Name: tb_cntr - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_cntr is
--  Port ( );
end tb_cntr;

architecture Behavioral of tb_cntr is

component ptk_axis_in_datastrm_cntl_dwncntr
port ( 
    clk     : in std_logic;
    sclr    : in std_logic;
    ce      : in std_logic;
    ld      : in std_logic; -- qualified by ce
    ld_val  : in std_logic_vector(31 downto 0);
    tc      : out std_logic;
    count   : out std_logic_vector(31 downto 0)  
);
end component;

signal    clk     : std_logic := '0';
signal    sclr    : std_logic := '0';
signal    ce      : std_logic := '0';
signal    ld      : std_logic := '0'; -- qualified by ce
signal    ld_val  : std_logic_vector(31 downto 0) := x"00000020";
signal    tc      :  std_logic;
signal    count   :  std_logic_vector(31 downto 0);  


begin
    
process
begin
 wait for 2 ns;
 clk <= not clk;
end process;

process
begin
    wait for 400 ns;
    wait until rising_edge(clk);
    wait for 0.5 ns;
    sclr <= '1';
    wait until rising_edge(clk);
    wait for 0.5 ns;
    sclr <= '0';
    wait for 40 ns;
    wait until rising_edge(clk);
    wait for 0.5 ns;
    ce <= '1';
    wait for 40 ns;
    wait until rising_edge(clk);
    wait for 0.5 ns;
    ld <= '1';
    wait until rising_edge(clk);
    wait for 0.5 ns;
    ld <= '0';
    ce <= '0';
    loop
        wait until rising_edge(clk);
        wait for 0.5 ns;
        wait until rising_edge(clk);
        wait for 0.5 ns;
        ce <= '1';        
        wait until rising_edge(clk);
        wait for 0.5 ns;
        ce <= '0';        
    end loop;
    wait;
end process;

uut: ptk_axis_in_datastrm_cntl_dwncntr
port map ( 
    clk     => clk,    
    sclr    => sclr,   
    ce      => ce,     
    ld      => ld,     
    ld_val  => ld_val, 
    tc      => tc,     
    count   => count  
);


end Behavioral;
