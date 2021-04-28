-- ============================================================================
-- Pentek Inc.
-- One Park Way
-- Upper Saddle River, NJ 07458

-- Author: Richard Kuenzler
-- Date: 6/03/05
-- File round_gen.vhd
-- ============================================================================
-- ============================================================================
-- Paramaterizable Round function.
-- REV A
-- ============================================================================
-- ============================================================================

-- Operates by inputting 2's compliment N number of input bits, and rounding 
-- to M output bits. Two types of rounding are supported:

-- Round to Nearest - Truncates N-M lowest bits and rounds to nearest M-bit
-- number. Fraction of .5 rounds up.

-- Round to Nearest Even - Truncates N-M lowest bits and rounds to nearest M-bit
-- number. Fraction of .5 rounds to nearest EVEN number (sometines up, sometimes
-- down). This method results in less DC error when rounding signals. 
 
-- If rounding causes an overflow, the output is saturated.


-- Latency either 2 or 3 (use 3 when speed is critical)

-- ============================================================================
-- Templates

--component round_gen
--    Generic(
--           in_data_width   : integer := 17;   -- Number of data bits for input
--           -- one less than input width
--           out_data_width  : integer := 16;   -- Number of data bits for output
--           rnd_type         : integer := 0;  -- 0 = Round to nearest (.5 rounds up)
                                             -- 1 = Round to nearest Even
                                             -- (.5 rounds to closest even number)
                                             -- 2 = Symetric Rounding (symetric
                                             --     around zero) larger, but better.
--           input_reg    : integer := 1     -- 1 Pipeline Latency = 3 (but faster)
--                                           -- 0 Pipeline Latency = 2 (but slower)
--          );
--
--    Port ( DATA_IN : in std_logic_vector(in_data_width-1 downto 0); -- Data input
--           DATA_OUT : out std_logic_vector(out_data_width-1 downto 0); -- Data Output
--           SAT_OUT : out std_logic; -- Saturation flag
--           CLK : in std_logic;      -- Clock
--           CE : in std_logic;       -- Clock Enable
--           ACLR : in std_logic      -- ASYNC Clear
--          );      
--end component;



--your_instance: round_gen
--    Generic Map
--          (
--           in_data_width   => 18,
--           out_data_width  => 16,
--           rnd_type        => 1,
--           input_reg       => 0
--          )
--
--    Port Map
--          ( 
--           DATA_IN         => DATA_IN, 
--           DATA_OUT        => DATA_OUT,
--           SAT_OUT         => SAT_OUT,
--           CLK             => CLK,
--           CE              => CE,
--           ACLR             => ACLR
--          );

-- ============================================================================

-- (c) Copyright 2016 Pentek, Inc. All rights reserved.
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
 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axis_nco_round_gen is
    Generic(
           in_data_width    : integer := 18;   -- Number of data bits for input
           out_data_width   : integer := 16;   -- Number of data bits for output
           rnd_type         : integer := 2;  -- 0 = Round to nearest (.5 rounds up)
                                             -- 1 = Round to nearest Even
                                             -- (.5 rounds to closest even number)
                                             -- 2 = Symetric Rounding (symetric
                                             --     around zero)
           input_reg    : integer := 1     -- 1 Pipeline Latency = 3 (but faster)
                                           -- 0 Pipeline Latency = 2 (but slower)
           );

    Port ( DATA_IN : in std_logic_vector(in_data_width-1 downto 0); -- Data input
           DATA_OUT : out std_logic_vector(out_data_width-1 downto 0); -- Data Output
           SAT_OUT : out std_logic; -- Saturation flag
           CLK : in std_logic;      -- Clock
           CE : in std_logic;       -- Clock Enable
           ACLR : in std_logic      -- Async Clear
         );      
end px_axis_nco_round_gen;

architecture Behavioral of px_axis_nco_round_gen is

signal dat : std_logic_vector(in_data_width-1 downto 0);
signal round_wrd : std_logic_vector(out_data_width downto 0);
signal round_wrd_sym : std_logic_vector(in_data_width downto 0);
signal sum : std_logic_vector(out_data_width downto 0);
signal sum_sym : std_logic_vector(in_data_width downto 0);
signal dec_half : std_logic;
signal zeros : std_logic_vector(in_data_width -1 downto 0);
signal carry : std_logic;

begin

zeros <= (others => '0');

no_reg_gen : if (input_reg = 0) generate

   dat <= DATA_IN;

end generate;

in_reg_gen : if (input_reg /= 0) generate

process(CLK, ACLR)
begin
   if ACLR = '1' then
      dat <= (others => '0');
   elsif CLK= '1' and CLK'event then
      if CE= '1' then
         dat <= DATA_IN;
      end if;
   end if;
end process;

end generate;

 -- =========================
rnd_wrd_upper01_gen : if ((rnd_type = 0) or (rnd_type = 1)) generate  
round_wrd(out_data_width downto 1) <= (others => '0');
end generate;

rnd_wrd_upper2_gen : if (rnd_type = 2) generate  
round_wrd_sym(in_data_width downto (in_data_width- out_data_width - 1)) <= (others => '0');
round_wrd_sym((in_data_width - out_data_width -2) downto 0) <= (others => '1');
carry <= not dat(in_data_width - 1);
end generate;

rnd_wrd_n_gen : if ((rnd_type = 0) or ((rnd_type = 1) and ((in_data_width - out_data_width)= 1))) generate
   round_wrd(0) <= dat((in_data_width - out_data_width) -1);
   carry <= '0';
end generate;

rnd_wrd_ne_gen : if ((rnd_type = 1) and ((in_data_width - out_data_width)> 1))  generate
   dec_half <= '1' when ( (dat(((in_data_width - out_data_width) -1)         )='1') and
                          (dat(((in_data_width - out_data_width) -2) downto 0)= zeros(((in_data_width - out_data_width) -2) downto 0))) else '0';
   round_wrd(0) <= '1' when (((dec_half = '1') and (dat((in_data_width - out_data_width))= '1' ))  or ((dec_half = '0') and (dat((in_data_width - out_data_width) -1)= '1' ))) else '0';
   carry <= '0';
end generate;



-- Sum to round   
rnd_sum_01_gen : if ((rnd_type = 0) or (rnd_type = 1)) generate
Process(CLK, ACLR)
begin
   if ACLR = '1' then
         sum <= (others => '0');
   elsif CLK= '1' and CLK'event then
      if CE= '1' then
         sum <= dat(in_data_width-1) & dat(in_data_width-1 downto ((in_data_width - out_data_width)) ) + round_wrd + carry;
      end if;
   end if;
end process;
end generate;

rnd_sum_2_gen : if (rnd_type = 2) generate
Process(CLK, ACLR)
begin
   if ACLR = '1' then
         sum_sym <= (others => '0');
   elsif CLK= '1' and CLK'event then
      if CE= '1' then
         sum_sym <= dat(in_data_width-1) & dat(in_data_width-1 downto 0) + round_wrd_sym + carry;
      end if;
   end if;
end process;
end generate;
-- ==========================
-- Test for Saturation
rnd_sat_01_gen : if ((rnd_type = 0) or (rnd_type = 1)) generate
Process(CLK, ACLR)
begin
   if ACLR = '1' then
      DATA_OUT <= (others => '0');
      SAT_OUT <=  '0';
   elsif CLK= '1' and CLK'event then
      if CE= '1' then
         if sum(out_data_width) = sum(out_data_width-1) then
            DATA_OUT <= sum(out_data_width-1 downto 0);
            SAT_OUT <= '0';
         else   -- saturate
            DATA_OUT(out_data_width-1) <= sum(out_data_width);
            if sum(out_data_width) = '0' then
               DATA_OUT(out_data_width-2 downto 0) <= (others => '1');
            else
               DATA_OUT(out_data_width-2 downto 0) <= (others => '0');
            end if;
            SAT_OUT <= '1';
         end if;
      end if;
   end if;
end process;
end generate;

rnd_sat_2_gen : if (rnd_type = 2) generate
Process(CLK, ACLR)
begin
   if ACLR = '1' then
      DATA_OUT <= (others => '0');
      SAT_OUT <=  '0';
   elsif CLK= '1' and CLK'event then
      if CE= '1' then
         if sum_sym(in_data_width) = sum_sym(in_data_width-1) then
            DATA_OUT <= sum_sym(in_data_width-1 downto (in_data_width- out_data_width));
            SAT_OUT <= '0';
         else   -- saturate
            DATA_OUT(out_data_width-1) <= sum_sym(in_data_width);
            if sum_sym(in_data_width) = '0' then
               DATA_OUT(out_data_width-2 downto 0) <= (others => '1');
            else
               DATA_OUT(out_data_width-2 downto 0) <= (others => '0');
            end if;
            SAT_OUT <= '1';
         end if;
      end if;
   end if;
end process;
end generate;



end Behavioral;
