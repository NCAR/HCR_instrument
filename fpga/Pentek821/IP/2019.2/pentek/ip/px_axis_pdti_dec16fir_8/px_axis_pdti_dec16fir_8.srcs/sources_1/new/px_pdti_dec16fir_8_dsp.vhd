----------------------------------------------------------------------------------
-- Company:  Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 04/16/2018 10:13:57 AM
-- Design Name: 
-- Module Name: px_pdti_dec16fir_8_dsp - Behavioral
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
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;
use std.textio.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity px_pdti_dec16fir_8_dsp is
generic(
    in1_regs: integer := 1;
    use_in1_casc_in:boolean := false;
    in1_casc_out_regs: integer := 1;
    num_fraction_bits: integer := 2;
    use_det: boolean := false;
    use_pcin : boolean := false
);
port (
clk         : in  std_logic;
ce          : in  std_logic;
in1         : in  std_logic_vector(15 downto 0);
in1_casc_in : in  std_logic_vector(29 downto 0);
in2         : in  std_logic_vector(15 downto 0);
in1_casc_out: out std_logic_vector(29 downto 0);
c_in        : in  std_logic_vector(47 downto 0);
pc_in       : in  std_logic_vector(47 downto 0);
pc_out      : out std_logic_vector(47 downto 0);
coef        : in  std_logic_vector(17 downto 0);
pout        : out std_logic_vector(47 downto 0);
detout      : out std_logic    
);
end px_pdti_dec16fir_8_dsp;

architecture Behavioral of px_pdti_dec16fir_8_dsp is

--------------------------------------------------------------------------------
-- Functions
--------------------------------------------------------------------------------

function detect_sel(l: boolean) return string is
begin
    if l then
       return "PATDET";
    else
       return "NO_PATDET";
    end if;
end function detect_sel;

function in_sel(l: boolean) return string is
begin
    if l then
       return "CASCADE";
    else
       return "DIRECT";
    end if;
end function in_sel;

function inmode_sel(l:integer) return std_logic_vector is
begin
    if l = 1 then
       return "10101"; --A1
    else 
       return "10100"; --A2
    end if;
end function inmode_sel;

function opmode_sel(l:boolean) return std_logic_vector is
begin
    if l = true then
       return  "110010101"; -- PCIN
    else 
       return  "110000101"; -- Zero
    end if;
end function opmode_sel;

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

constant A_INPUT: string := in_sel(use_in1_casc_in);
constant USE_PATTERN_DETECT: string := detect_sel(use_det);
constant d_lsbs: std_logic_vector(num_fraction_bits-2 downto 0) := (others => '1');
constant d_msbs: std_logic_vector(47 downto num_fraction_bits-1) := (others => '0');
constant dp: std_logic_vector(47 downto 0) := d_msbs & d_lsbs;
constant m_lsbs: std_logic_vector(num_fraction_bits-1 downto 0) := (others => '0');
constant m_msbs: std_logic_vector(47 downto num_fraction_bits) := (others => '1');
constant mp: std_logic_vector(47 downto 0) := m_msbs & m_lsbs;
constant zeros: std_logic_vector(47 downto 0) := (others => '0');
constant inmode : std_logic_vector(4 downto 0) := inmode_sel(in1_regs);
constant opmode : std_logic_vector(8 downto 0) := opmode_sel(use_pcin);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal acin: std_logic_vector(29 downto 0) := (others => '0');
signal acout: std_logic_vector(29 downto 0) := (others => '0');
signal a: std_logic_vector(29 downto 0) := (others => '0');
signal d: std_logic_vector(26 downto 0) := (others => '0');

begin


DSP48E2_inst : DSP48E2
   generic map (
      -- Feature Control Attributes: Data Path Selection
      AMULTSEL => "AD",                   -- Selects A input to multiplier (A, AD)
      A_INPUT => A_INPUT,               -- Selects A input source, "DIRECT" (A port) or "CASCADE" (ACIN port)
      BMULTSEL => "B",                   -- Selects B input to multiplier (AD, B)
      B_INPUT => "DIRECT",               -- Selects B input source, "DIRECT" (B port) or "CASCADE" (BCIN port)
      PREADDINSEL => "A",                -- Selects input to pre-adder (A, B)
      RND => X"000000000000",            -- Rounding Constant
      USE_MULT => "MULTIPLY",            -- Select multiplier usage (DYNAMIC, MULTIPLY, NONE)
      USE_SIMD => "ONE48",               -- SIMD selection (FOUR12, ONE48, TWO24)
      USE_WIDEXOR => "FALSE",            -- Use the Wide XOR function (FALSE, TRUE)
      XORSIMD => "XOR24_48_96",          -- Mode of operation for the Wide XOR (XOR12, XOR24_48_96)
      -- Pattern Detector Attributes: Pattern Detection Configuration
      AUTORESET_PATDET => "NO_RESET",    -- NO_RESET, RESET_MATCH, RESET_NOT_MATCH
      AUTORESET_PRIORITY => "RESET",     -- Priority of AUTORESET vs. CEP (CEP, RESET).
      MASK => mp,           -- 48-bit mask value for pattern detect (1=ignore)
      PATTERN => dp,        -- 48-bit pattern match for pattern detect
      SEL_MASK => "MASK",                -- C, MASK, ROUNDING_MODE1, ROUNDING_MODE2
      SEL_PATTERN => "PATTERN",          -- Select pattern value (C, PATTERN)
      USE_PATTERN_DETECT => USE_PATTERN_DETECT, -- Enable pattern detect (NO_PATDET, PATDET)
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
      ACASCREG => in1_casc_out_regs,                     -- Number of pipeline stages between A/ACIN and ACOUT (0-2)
      ADREG => 1,                        -- Pipeline stages for pre-adder (0-1)
      ALUMODEREG => 1,                   -- Pipeline stages for ALUMODE (0-1)
      AREG => in1_regs,                  -- Pipeline stages for A (0-2)
      BCASCREG => 1,                     -- Number of pipeline stages between B/BCIN and BCOUT (0-2)
      BREG => 1,                         -- Pipeline stages for B (0-2)
      CARRYINREG => 1,                   -- Pipeline stages for CARRYIN (0-1)
      CARRYINSELREG => 1,                -- Pipeline stages for CARRYINSEL (0-1)
      CREG => 1,                         -- Pipeline stages for C (0-1)
      DREG => 1,                         -- Pipeline stages for D (0-1)
      INMODEREG => 1,                    -- Pipeline stages for INMODE (0-1)
      MREG => 1,                         -- Multiplier pipeline stages (0-1)
      OPMODEREG => 1,                    -- Pipeline stages for OPMODE (0-1)
      PREG => 1                          -- Number of pipeline stages for P (0-1)
   )
   port map (
      -- Cascade outputs: Cascade Ports
      ACOUT => acout,                   -- 30-bit output: A port cascade
      BCOUT => open,                   -- 18-bit output: B cascade
      CARRYCASCOUT => open,     -- 1-bit output: Cascade carry
      MULTSIGNOUT => open,       -- 1-bit output: Multiplier sign cascade
      PCOUT => pc_out,                   -- 48-bit output: Cascade output
      -- Control outputs: Control Inputs/Status Bits
      OVERFLOW => open,             -- 1-bit output: Overflow in add/acc
      PATTERNBDETECT => open, -- 1-bit output: Pattern bar detect
      PATTERNDETECT => detout,   -- 1-bit output: Pattern detect
      UNDERFLOW => open,           -- 1-bit output: Underflow in add/acc
      -- Data outputs: Data Ports
      CARRYOUT => open,             -- 4-bit output: Carry
      P => pout,                           -- 48-bit output: Primary data
      XOROUT => open,                 -- 8-bit output: XOR data
      -- Cascade inputs: Cascade Ports
      ACIN => acin,                     -- 30-bit input: A cascade data
      BCIN => zeros(17 downto 0),                     -- 18-bit input: B cascade
      CARRYCASCIN => '0',       -- 1-bit input: Cascade carry
      MULTSIGNIN => '0',         -- 1-bit input: Multiplier sign cascade
      PCIN => pc_in,                     -- 48-bit input: P cascade
      -- Control inputs: Control Inputs/Status Bits
      ALUMODE => "0000",               -- 4-bit input: ALU control
      CARRYINSEL => "000",         -- 3-bit input: Carry select
      CLK => clk,                       -- 1-bit input: Clock
      INMODE => inmode,                 -- 5-bit input: INMODE control
      OPMODE => opmode,                 -- 9-bit input: Operation mode
      -- Data inputs: Data Ports
      A => a,                           -- 30-bit input: A data
      B => coef,                           -- 18-bit input: B data
      C => c_in,                           -- 48-bit input: C data
      CARRYIN => '0',               -- 1-bit input: Carry-in
      D => d,                           -- 27-bit input: D data
      -- Reset/Clock Enable inputs: Reset/Clock Enable Inputs
      CEA1 => ce,                     -- 1-bit input: Clock enable for 1st stage AREG
      CEA2 => ce,                     -- 1-bit input: Clock enable for 2nd stage AREG
      CEAD => ce,                     -- 1-bit input: Clock enable for ADREG
      CEALUMODE => '1',           -- 1-bit input: Clock enable for ALUMODE
      CEB1 => '1',                     -- 1-bit input: Clock enable for 1st stage BREG
      CEB2 => '1',                     -- 1-bit input: Clock enable for 2nd stage BREG
      CEC => ce,                       -- 1-bit input: Clock enable for CREG
      CECARRYIN => '1',           -- 1-bit input: Clock enable for CARRYINREG
      CECTRL => '1',                 -- 1-bit input: Clock enable for OPMODEREG and CARRYINSELREG
      CED => ce,                       -- 1-bit input: Clock enable for DREG
      CEINMODE => '1',             -- 1-bit input: Clock enable for INMODEREG
      CEM => ce,                       -- 1-bit input: Clock enable for MREG
      CEP => ce,                       -- 1-bit input: Clock enable for PREG
      RSTA => '0',                     -- 1-bit input: Reset for AREG
      RSTALLCARRYIN => '0',   -- 1-bit input: Reset for CARRYINREG
      RSTALUMODE => '0',         -- 1-bit input: Reset for ALUMODEREG
      RSTB => '0',                     -- 1-bit input: Reset for BREG
      RSTC => '0',                     -- 1-bit input: Reset for CREG
      RSTCTRL => '0',               -- 1-bit input: Reset for OPMODEREG and CARRYINSELREG
      RSTD => '0',                     -- 1-bit input: Reset for DREG and ADREG
      RSTINMODE => '0',           -- 1-bit input: Reset for INMODEREG
      RSTM => '0',                     -- 1-bit input: Reset for MREG
      RSTP => '0'                      -- 1-bit input: Reset for PREG
   );

a            <= zeros(29 downto 0) when (use_in1_casc_in = true) else std_logic_vector(resize(signed(in1),30));
d            <= std_logic_vector(resize(signed(in2),27));
acin         <= zeros(29 downto 0) when (use_in1_casc_in = false) else in1_casc_in;
in1_casc_out <= acout;


end Behavioral;
