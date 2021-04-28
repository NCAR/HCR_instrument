----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/07/2015 10:23:45 AM
-- Design Name: 
-- Module Name: px_scalar2vctr - Behavioral
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

-- (c) Copyright 2015 Pentek, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Pentek, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Pentek, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND PENTEK HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Pentek shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Pentek had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Pentek products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Pentek products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
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

entity px_scalar2vctr is
generic(
    number_inputs : integer range 1 to 32 := 32 
);
port (
   input0   : in std_logic;
   input1   : in std_logic;
   input2   : in std_logic;
   input3   : in std_logic;
   input4   : in std_logic;
   input5   : in std_logic;
   input6   : in std_logic;
   input7   : in std_logic;
   input8   : in std_logic;
   input9   : in std_logic;
   input10  : in std_logic;
   input11  : in std_logic;
   input12  : in std_logic;
   input13  : in std_logic;
   input14  : in std_logic;
   input15  : in std_logic;
   input16  : in std_logic;
   input17  : in std_logic;
   input18  : in std_logic;
   input19  : in std_logic;
   input20  : in std_logic;
   input21  : in std_logic;
   input22  : in std_logic;
   input23  : in std_logic;
   input24  : in std_logic;
   input25  : in std_logic;
   input26  : in std_logic;
   input27  : in std_logic;
   input28  : in std_logic;
   input29  : in std_logic;
   input30  : in std_logic;
   input31  : in std_logic;
   output_vector   : out std_logic_vector ( number_inputs-1 downto 0)
);
end px_scalar2vctr;

architecture Behavioral of px_scalar2vctr is

signal concat : std_logic_vector(31 downto 0);

begin

concat(0)  <= input0;  
gen1: if (number_inputs > 1) generate
concat(1)  <= input1;
end generate; 
gen2: if (number_inputs > 2) generate
concat(2)  <= input2;
end generate; 
gen3: if (number_inputs > 3) generate
concat(3)  <= input3;
end generate; 
gen4: if (number_inputs > 4) generate
concat(4)  <= input4;
end generate; 
gen5: if (number_inputs > 5) generate
concat(5)  <= input5;
end generate; 
gen6: if (number_inputs > 6) generate
concat(6)  <= input6;
end generate; 
gen7: if (number_inputs > 7) generate
concat(7)  <= input7;
end generate; 
gen8: if (number_inputs > 8) generate
concat(8)  <= input8;
end generate; 
gen9: if (number_inputs > 9) generate
concat(9)  <= input9;
end generate; 
gen10: if (number_inputs > 10) generate
concat(10)  <= input10;
end generate; 
gen11: if (number_inputs > 11) generate
concat(11)  <= input11;
end generate; 
gen12: if (number_inputs > 12) generate
concat(12)  <= input12;
end generate; 
gen13: if (number_inputs > 13) generate
concat(13)  <= input13;
end generate; 
gen14: if (number_inputs > 14) generate
concat(14)  <= input14;
end generate; 
gen15: if (number_inputs > 15) generate
concat(15)  <= input15;
end generate; 
gen16: if (number_inputs > 16) generate
concat(16)  <= input16;
end generate; 
gen17: if (number_inputs > 17) generate
concat(17)  <= input17;
end generate; 
gen18: if (number_inputs > 18) generate
concat(18)  <= input18;
end generate; 
gen19: if (number_inputs > 19) generate
concat(19)  <= input19;
end generate; 
gen20: if (number_inputs > 20) generate
concat(20)  <= input20;
end generate; 
gen21: if (number_inputs > 21) generate
concat(21)  <= input21;
end generate; 
gen22: if (number_inputs > 22) generate
concat(22)  <= input22;
end generate; 
gen23: if (number_inputs > 23) generate
concat(23)  <= input23;
end generate; 
gen24: if (number_inputs > 24) generate
concat(24)  <= input24;
end generate; 
gen25: if (number_inputs > 25) generate
concat(25)  <= input25;
end generate; 
gen26: if (number_inputs > 26) generate
concat(26)  <= input26;
end generate; 
gen27: if (number_inputs > 27) generate
concat(27)  <= input27;
end generate; 
gen28: if (number_inputs > 28) generate
concat(28)  <= input28;
end generate; 
gen29: if (number_inputs > 29) generate
concat(29)  <= input29;
end generate; 
gen30: if (number_inputs > 30) generate
concat(30)  <= input30;
end generate; 
gen31: if (number_inputs > 31) generate
concat(31)  <= input31;
end generate; 

output_vector( number_inputs-1 downto 0) <= concat( number_inputs-1 downto 0);


end Behavioral;
