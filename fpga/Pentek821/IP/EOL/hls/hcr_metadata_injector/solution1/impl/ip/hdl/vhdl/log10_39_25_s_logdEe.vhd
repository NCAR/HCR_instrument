-- ==============================================================
-- Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2 (64-bit)
-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity log10_39_25_s_logdEe_rom is 
    generic(
             DWIDTH     : integer := 22; 
             AWIDTH     : integer := 6; 
             MEM_SIZE    : integer := 64
    ); 
    port (
          addr0      : in std_logic_vector(AWIDTH-1 downto 0); 
          ce0       : in std_logic; 
          q0         : out std_logic_vector(DWIDTH-1 downto 0);
          clk       : in std_logic
    ); 
end entity; 


architecture rtl of log10_39_25_s_logdEe_rom is 

signal addr0_tmp : std_logic_vector(AWIDTH-1 downto 0); 
type mem_array is array (0 to MEM_SIZE-1) of std_logic_vector (DWIDTH-1 downto 0); 
signal mem : mem_array := (
    0 to 2=> "1111111110000000000111", 3 to 4=> "0000011110100000110011", 
    5 to 6=> "0001000000000101101110", 7 to 9=> "0001100010110011011111", 
    10 to 11=> "0010000110101111001111", 12 to 14=> "0010101011111110101000", 
    15 to 17=> "0011010010100111111110", 18 to 21=> "0011111010110010010110", 
    22 to 25=> "0100100100100101101010", 26 to 29=> "0101010000001010110110", 
    30 to 31=> "0101111101101100000010", 32 to 33=> "1011001111011100100101", 
    34 to 35=> "1011100111100010101011", 36 to 38=> "1100000000001101111011", 
    39 to 41=> "1100011001100000001100", 42 to 43=> "1100110011011011011010", 
    44 to 46=> "1101001110000001101111", 47 to 49=> "1101101001010101011110", 
    50 to 53=> "1110000101011001000110", 54 to 56=> "1110100010001111010011", 
    57 to 60=> "1110111111111011000001", 61 to 63=> "1111011110011111011110" );


begin 


memory_access_guard_0: process (addr0) 
begin
      addr0_tmp <= addr0;
--synthesis translate_off
      if (CONV_INTEGER(addr0) > mem_size-1) then
           addr0_tmp <= (others => '0');
      else 
           addr0_tmp <= addr0;
      end if;
--synthesis translate_on
end process;

p_rom_access: process (clk)  
begin 
    if (clk'event and clk = '1') then
        if (ce0 = '1') then 
            q0 <= mem(CONV_INTEGER(addr0_tmp)); 
        end if;
    end if;
end process;

end rtl;

Library IEEE;
use IEEE.std_logic_1164.all;

entity log10_39_25_s_logdEe is
    generic (
        DataWidth : INTEGER := 22;
        AddressRange : INTEGER := 64;
        AddressWidth : INTEGER := 6);
    port (
        reset : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR(AddressWidth - 1 DOWNTO 0);
        ce0 : IN STD_LOGIC;
        q0 : OUT STD_LOGIC_VECTOR(DataWidth - 1 DOWNTO 0));
end entity;

architecture arch of log10_39_25_s_logdEe is
    component log10_39_25_s_logdEe_rom is
        port (
            clk : IN STD_LOGIC;
            addr0 : IN STD_LOGIC_VECTOR;
            ce0 : IN STD_LOGIC;
            q0 : OUT STD_LOGIC_VECTOR);
    end component;



begin
    log10_39_25_s_logdEe_rom_U :  component log10_39_25_s_logdEe_rom
    port map (
        clk => clk,
        addr0 => address0,
        ce0 => ce0,
        q0 => q0);

end architecture;


