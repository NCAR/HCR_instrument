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

entity gen_lut_shr is
   Generic (
         add_ff: std_logic := '0';
         delay_value: integer := 16; -- max is 16
         width : integer := 16
      );
    Port ( D_IN : in  STD_LOGIC_VECTOR ((width-1) downto 0);
           CLK : in  STD_LOGIC;
           CE : in  STD_LOGIC;
           D_OUT : out  STD_LOGIC_VECTOR ((width-1) downto 0));
end gen_lut_shr;

architecture Behavioral of gen_lut_shr is

constant delay_cntrl_0: std_logic_vector(4 downto 0) := conv_std_logic_vector((delay_value-1), 5);
constant delay_cntrl_1: std_logic_vector(4 downto 0) := conv_std_logic_vector((delay_value-2), 5);

signal dout: std_logic_vector(width-1 downto 0):= (others => '0');
 

begin

gen_1: if add_ff = '1' generate

gen_width: for i in 0 to (width-1) generate

 SRL16E_single_inst : SRL16E
   generic map (
      INIT => X"0000",        -- Initial contents of shift register
      IS_CLK_INVERTED => '0'  -- Optional inversion for CLK
   )
   port map (
      Q     => dout(i),     -- 1-bit output: SRL Data
      CE    => CE,   -- 1-bit input: Clock enable
      CLK   => CLK, -- 1-bit input: Clock
      D     => D_IN(i),     -- 1-bit input: SRL Data
      -- Depth Selection inputs: A0-A3 select SRL depth
      A0    => delay_cntrl_1(0),
      A1    => delay_cntrl_1(1),
      A2    => delay_cntrl_1(2),
      A3    => delay_cntrl_1(3) 
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


 SRL16E_single_inst : SRL16E
   generic map (
      INIT => X"0000",        -- Initial contents of shift register
      IS_CLK_INVERTED => '0'  -- Optional inversion for CLK
   )
   port map (
      Q     => dout(i),     -- 1-bit output: SRL Data
      CE    => CE,   -- 1-bit input: Clock enable
      CLK   => CLK, -- 1-bit input: Clock
      D     => D_IN(i),     -- 1-bit input: SRL Data
      -- Depth Selection inputs: A0-A3 select SRL depth
      A0    => delay_cntrl_0(0),
      A1    => delay_cntrl_0(1),
      A2    => delay_cntrl_0(2),
      A3    => delay_cntrl_0(3) 
   );
      
end generate;

D_OUT <= dout;

end generate;

end Behavioral;

