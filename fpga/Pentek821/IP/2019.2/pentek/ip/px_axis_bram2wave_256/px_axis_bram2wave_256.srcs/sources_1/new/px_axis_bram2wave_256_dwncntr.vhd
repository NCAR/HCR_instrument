----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 07/19/2018 10:50:33 AM
-- Design Name: 
-- Module Name: ptk_axis_bram2wave_dwncntr - Behavioral
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

-- (c) Copyright 2018 Pentek, Inc. All rights reserved.
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

--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity px_axis_bram2wave_256_dwncntr is
port ( 
    clk     : in  std_logic;
    sclr    : in  std_logic;
    ce      : in  std_logic;
    ld      : in  std_logic; -- qualified by ce
    ld_val  : in  std_logic_vector(31 downto 0);
    tc      : out std_logic;
    count   : out std_logic_vector(31 downto 0)  
);
end px_axis_bram2wave_256_dwncntr;

architecture Behavioral of px_axis_bram2wave_256_dwncntr is


--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal cntr_carryin : std_logic := '0';
signal cntr_opmode  : std_logic_vector(8 downto 0)  := (others => '0');
signal cntr_p       : std_logic_vector(47 downto 0) := (others => '0');
signal zerodet      : std_logic := '0';
signal cntr_c       : std_logic_vector(47 downto 0) := (others => '0'); 
signal cntr_ce      : std_logic := '0';
constant zeros      : std_logic_vector(47 downto 0) := (others => '0'); 

--------------------------------------------------------------------------------

begin


   -- DSP48E2: 48-bit Multi-Functional Arithmetic Block
   --          Virtex UltraScale
   -- Xilinx HDL Language Template, version 2014.4

   DSP48E2_inst : DSP48E2
   generic map (
      -- Feature Control Attributes: Data Path Selection
      AMULTSEL => "A",                   -- Selects A input to multiplier (A, AD)
      A_INPUT => "DIRECT",               -- Selects A input source, "DIRECT" (A port) or "CASCADE" (ACIN port)
      BMULTSEL => "B",                   -- Selects B input to multiplier (AD, B)
      B_INPUT => "DIRECT",               -- Selects B input source, "DIRECT" (B port) or "CASCADE" (BCIN port)
      PREADDINSEL => "A",                -- Selects input to preadder (A, B)
      RND => X"000000000000",            -- Rounding Constant
      USE_MULT => "NONE",            -- Select multiplier usage (DYNAMIC, MULTIPLY, NONE)
      USE_SIMD => "ONE48",               -- SIMD selection (FOUR12, ONE48, TWO24)
      USE_WIDEXOR => "FALSE",            -- Use the Wide XOR function (FALSE, TRUE)
      XORSIMD => "XOR24_48_96",          -- Mode of operation for the Wide XOR (XOR12, XOR24_48_96)
      -- Pattern Detector Attributes: Pattern Detection Configuration
      AUTORESET_PATDET => "NO_RESET",    -- NO_RESET, RESET_MATCH, RESET_NOT_MATCH
      AUTORESET_PRIORITY => "RESET",     -- Priority of AUTORESET vs.CEP (CEP, RESET).
      MASK => X"ffff00000000",           -- 48-bit mask value for pattern detect (1=ignore)
      PATTERN => X"000000000000",        -- 48-bit pattern match for pattern detect
      SEL_MASK => "MASK",                -- C, MASK, ROUNDING_MODE1, ROUNDING_MODE2
      SEL_PATTERN => "PATTERN",          -- Select pattern value (C, PATTERN)
      USE_PATTERN_DETECT => "PATDET", -- Enable pattern detect (NO_PATDET, PATDET)
      -- Programmable Inversion Attributes: Specifies built-in programmable inversion on specific pins
      IS_ALUMODE_INVERTED => "0000",     -- Optional inversion for ALUMODE
      IS_CARRYIN_INVERTED => '0',        -- Optional inversion for CARRYIN
      IS_CLK_INVERTED => '0',            -- Optional inversion for CLK
      IS_INMODE_INVERTED => "00000",     -- Optional inversion for INMODE
      IS_OPMODE_INVERTED => "000000000", -- Optional inversion for OPMODE
      IS_RSTALLCARRYIN_INVERTED => '0',  -- Optional inversion for RSTALLCARRYIN
      IS_RSTALUMODE_INVERTED => '0',     -- Optional inversion for RSTALUMODE
      IS_RSTA_INVERTED => '0',           -- Optional inversion for RSTA
      IS_RSTB_INVERTED => '0',           -- Optional inversion for RSTB
      IS_RSTCTRL_INVERTED => '0',        -- Optional inversion for RSTCTRL
      IS_RSTC_INVERTED => '0',           -- Optional inversion for RSTC
      IS_RSTD_INVERTED => '0',           -- Optional inversion for RSTD
      IS_RSTINMODE_INVERTED => '0',      -- Optional inversion for RSTINMODE
      IS_RSTM_INVERTED => '0',           -- Optional inversion for RSTM
      IS_RSTP_INVERTED => '0',           -- Optional inversion for RSTP
      -- Register Control Attributes: Pipeline Register Configuration
      ACASCREG => 0,                     -- Number of pipeline stages between A/ACIN and ACOUT (0-2)
      ADREG => 0,                        -- Pipeline stages for pre-adder (0-1)
      ALUMODEREG => 0,                   -- Pipeline stages for ALUMODE (0-1)
      AREG => 0,                         -- Pipeline stages for A (0-2)
      BCASCREG => 0,                     -- Number of pipeline stages between B/BCIN and BCOUT (0-2)
      BREG => 0,                         -- Pipeline stages for B (0-2)
      CARRYINREG => 0,                   -- Pipeline stages for CARRYIN (0-1)
      CARRYINSELREG => 0,                -- Pipeline stages for CARRYINSEL (0-1)
      CREG => 1,                         -- Pipeline stages for C (0-1)
      DREG => 0,                         -- Pipeline stages for D (0-1)
      INMODEREG => 0,                    -- Pipeline stages for INMODE (0-1)
      MREG => 0,                         -- Multiplier pipeline stages (0-1)
      OPMODEREG => 0,                    -- Pipeline stages for OPMODE (0-1)
      PREG => 1                          -- Number of pipeline stages for P (0-1)
   )
   port map (
      -- Cascade outputs: Cascade Ports
      ACOUT => open,                   -- 30-bit output: A port cascade
      BCOUT => open,                   -- 18-bit output: B cascade
      CARRYCASCOUT => open,     -- 1-bit output: Cascade carry
      MULTSIGNOUT => open,       -- 1-bit output: Multiplier sign cascade
      PCOUT => open,                   -- 48-bit output: Cascade output
      -- Control outputs: Control Inputs/Status Bits
      OVERFLOW => open,             -- 1-bit output: Overflow in add/acc
      PATTERNBDETECT => open, -- 1-bit output: Pattern bar detect
      PATTERNDETECT  => zerodet,   -- 1-bit output: Pattern detect
      UNDERFLOW => open,           -- 1-bit output: Underflow in add/acc
      -- Data outputs: Data Ports
      CARRYOUT => open,             -- 4-bit output: Carry
      P => cntr_p,                           -- 48-bit output: Primary data
      XOROUT => open,                 -- 8-bit output: XOR data
      -- Cascade inputs: Cascade Ports
      ACIN => zeros(29 downto 0),                     -- 30-bit input: A cascade data
      BCIN => zeros(17 downto 0),                     -- 18-bit input: B cascade
      CARRYCASCIN => '0',       -- 1-bit input: Cascade carry
      MULTSIGNIN => '0',         -- 1-bit input: Multiplier sign cascade
      PCIN => zeros(47 downto 0),                     -- 48-bit input: P cascade
      -- Control inputs: Control Inputs/Status Bits
      ALUMODE => x"3",               -- 4-bit input: ALU control
      CARRYINSEL => "000",         -- 3-bit input: Carry select
      CLK => clk,                       -- 1-bit input: Clock
      INMODE => "00000",                 -- 5-bit input: INMODE control
      OPMODE => cntr_opmode,                 -- 9-bit input: Operation mode
      -- Data inputs: Data Ports
      A => zeros(29 downto 0),                           -- 30-bit input: A data
      B => zeros(17 downto 0),                           -- 18-bit input: B data
      C => cntr_c,                           -- 48-bit input: C data
      CARRYIN => cntr_carryin,               -- 1-bit input: Carry-in
      D => zeros(26 downto 0),                           -- 27-bit input: D data
      -- Reset/Clock Enable inputs: Reset/Clock Enable Inputs
      CEA1 => '0',                     -- 1-bit input: Clock enable for 1st stage AREG
      CEA2 => '0',                     -- 1-bit input: Clock enable for 2nd stage AREG
      CEAD => '0',                     -- 1-bit input: Clock enable for ADREG
      CEALUMODE => '1',           -- 1-bit input: Clock enable for ALUMODE
      CEB1 => '0',                     -- 1-bit input: Clock enable for 1st stage BREG
      CEB2 => '0',                     -- 1-bit input: Clock enable for 2nd stage BREG
      CEC => '1',                       -- 1-bit input: Clock enable for CREG
      CECARRYIN => '0',           -- 1-bit input: Clock enable for CARRYINREG
      CECTRL => '0',                 -- 1-bit input: Clock enable for OPMODEREG and CARRYINSELREG
      CED => '0',                       -- 1-bit input: Clock enable for DREG
      CEINMODE => '0',             -- 1-bit input: Clock enable for INMODEREG
      CEM => '0',                       -- 1-bit input: Clock enable for MREG
      CEP => cntr_ce,                       -- 1-bit input: Clock enable for PREG
      RSTA => '0',                     -- 1-bit input: Reset for AREG
      RSTALLCARRYIN => '0',   -- 1-bit input: Reset for CARRYINREG
      RSTALUMODE => '0',         -- 1-bit input: Reset for ALUMODEREG
      RSTB => '0',                     -- 1-bit input: Reset for BREG
      RSTC => '0',                     -- 1-bit input: Reset for CREG
      RSTCTRL => '0',               -- 1-bit input: Reset for OPMODEREG and CARRYINSELREG
      RSTD => '0',                     -- 1-bit input: Reset for DREG and ADREG
      RSTINMODE => '0',           -- 1-bit input: Reset for INMODEREG
      RSTM => '0',                     -- 1-bit input: Reset for MREG
      RSTP => '0'                -- 1-bit input: Reset for PREG
   );

   -- End of DSP48E2_inst instantiation
					
cntr_c(31 downto 0) <= ld_val;
cntr_c(47 downto 32) <= x"0000";				
cntr_carryin <= '1' when ((zerodet = '0') and (ld = '0') and (sclr = '0')) else '0';  

cntr_opmode <= "000000000" when (sclr = '1') else
               "000100000" when (ld = '0') else "000110000";

count <= cntr_p(31 downto 0);
cntr_ce <= ce or (ld and ce) or sclr ;
tc    <= zerodet;


end Behavioral;
