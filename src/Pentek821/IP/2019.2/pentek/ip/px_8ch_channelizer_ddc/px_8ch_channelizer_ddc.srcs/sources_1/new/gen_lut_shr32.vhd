----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:56:22 09/10/2007 
-- Design Name: 
-- Module Name:    gen_lut_shr - Behavioral 
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
library UNISIM;
use UNISIM.VComponents.all;

entity gen_lut_shr32 is
   Generic (
         add_ff: std_logic := '0';
         delay_value: integer := 16; -- max is 32
         width : integer := 16
      );
    Port ( D_IN : in  STD_LOGIC_VECTOR ((width-1) downto 0);
           CLK : in  STD_LOGIC;
           CE : in  STD_LOGIC;
           D_OUT : out  STD_LOGIC_VECTOR ((width-1) downto 0));
end gen_lut_shr32;

architecture Behavioral of gen_lut_shr32 is

constant delay_cntrl_0: std_logic_vector(5 downto 0) := conv_std_logic_vector((delay_value-1), 6);
constant delay_cntrl_1: std_logic_vector(5 downto 0) := conv_std_logic_vector((delay_value-2), 6);

signal dout: std_logic_vector(width-1 downto 0);
 

begin

gen_1: if add_ff = '1' generate

gen_width: for i in 0 to (width-1) generate

SRLC32E_inst : SRLC32E
   generic map (
      INIT => X"00000000",
      IS_CLK_INVERTED => '0' 
      )
   port map (
      Q   => dout(i),        -- SRL data output
      Q31 => open,    -- SRL cascade output pin
      A => delay_cntrl_1(4 downto 0),        -- 5-bit shift depth select input
      CE => CE,      -- Clock enable input
      CLK => CLK,    -- Clock input
      D => D_IN(i)    -- SRL data input
   );

   
end generate;

process(CLK)
begin
   if rising_edge(CLK) then
      if CE = '1' then
          D_OUT <= dout;
      end if;
   end if;   
end process;     

end generate;

gen_0: if add_ff = '0' generate

gen_width: for i in 0 to (width-1) generate

SRLC32E_inst : SRLC32E
   generic map (
      INIT => X"00000000",
      IS_CLK_INVERTED => '0'
      ) 
   port map (
      Q   => dout(i),        -- SRL data output
      Q31 => open,    -- SRL cascade output pin
      A => delay_cntrl_0(4 downto 0),        -- 5-bit shift depth select input
      CE => CE,      -- Clock enable input
      CLK => CLK,    -- Clock input
      D => D_IN(i)    -- SRL data input
   );

D_OUT <= dout;

   
end generate;


end generate;

end Behavioral;

