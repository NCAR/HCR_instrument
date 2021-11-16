----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date:    11:31:59 06/22/2007 
-- Design Name: 
-- Module Name:    dual_cmplx_mult - Behavioral 
-- Project Name: 
-- Target Devices: Kintex Ultrascale
-- Tool versions: 
-- Description: 24-bit 1real,1complex in Dual Complex Multiplier
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
-- Two Products are summed into one
--    ADD_CNTRL = 0 : P1 + P2
--    ADD_CNTRL = 1 : P1 - P2

-- Latency = 5 (No input or Output Reg)
--           Add 1 to latency for the optional input registers 

-- Adapted to DSP40E2 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity dual_rc_mult is
    generic (
         reg_in  : std_logic := '0'; -- '1' = add input register
         add_cntrl_r : STD_LOGIC := '0';
         add_cntrl_i : STD_LOGIC := '0'  
         );
    port ( AR1_IN : in  STD_LOGIC_VECTOR (23 downto 0);
           BR1_IN : in  STD_LOGIC_VECTOR (17 downto 0);
           BI1_IN : in  STD_LOGIC_VECTOR (17 downto 0);
           AR2_IN : in  STD_LOGIC_VECTOR (23 downto 0);
           BR2_IN : in  STD_LOGIC_VECTOR (17 downto 0);
           BI2_IN : in  STD_LOGIC_VECTOR (17 downto 0);
           CLK : in  STD_LOGIC;
           PR_OUT : out  STD_LOGIC_VECTOR (23 downto 0);
           PI_OUT : out  STD_LOGIC_VECTOR (23 downto 0)
          );
end dual_rc_mult;

architecture Behavioral of dual_rc_mult is

-- ============================================================================
-- Signals
-- ============================================================================

signal ar1: std_logic_vector(23 downto 0);
signal br1: std_logic_vector(17 downto 0);
signal bi1: std_logic_vector(17 downto 0);
signal ar2: std_logic_vector(23 downto 0);
signal br2: std_logic_vector(17 downto 0);
signal bi2: std_logic_vector(17 downto 0);
signal ar1_sxt: std_logic_vector(29 downto 0);
signal ar2_sxt: std_logic_vector(29 downto 0);

signal pr1_pprod: std_logic_vector(47 downto 0);
signal pi1_pprod: std_logic_vector(47 downto 0);
signal pr2_prod: std_logic_vector(47 downto 0);
signal pi2_prod: std_logic_vector(47 downto 0);

signal pr2_pd: std_logic;
signal pi2_pd: std_logic;

signal zeros : std_logic_vector(29 downto 0);
 
constant pr2a_alumode : std_logic_vector(3 downto 0) := "00" & add_cntrl_r & add_cntrl_r; 
constant pi2a_alumode : std_logic_vector(3 downto 0) := "00" & add_cntrl_i & add_cntrl_i;

-- ============================================================================ 

begin

zeros <= (others => '0');

no_in_reg_gen: if (reg_in /= '1') generate

ar1 <= AR1_IN;
br1 <= BR1_IN;
bi1 <= BI1_IN;
ar2 <= AR2_IN;
br2 <= BR2_IN;
bi2 <= BI2_IN;

end generate;

in_reg_gen: if (reg_in = '1') generate

process(CLK)
begin
   if rising_edge(CLK) then
      ar1 <= AR1_IN;
      br1 <= BR1_IN;
      bi1 <= BI1_IN;
      ar2 <= AR2_IN;
      br2 <= BR2_IN;
      bi2 <= BI2_IN; 
   end if;
end process;
   
end generate;

ar1_sxt <= sxt(ar1, 30); 

ar2_sxt <= sxt(ar2, 30);

-- ----------------------------------------------------------------------------
-- P1 Real Output Equation
-- ----------------------------------------------------------------------------
   -- DSP48E2: DSP Function Block

DSP48E_pr1a_inst : DSP48E2
   generic map (
      -- Feature Control Attributes: Data Path Selection
      AMULTSEL => "A",                   -- Selects A input to multiplier (A, AD)
      A_INPUT => "DIRECT",               -- Selects A input source, "DIRECT" (A port) or "CASCADE" (ACIN port)
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
      MASK => X"3fffffffffff",           -- 48-bit mask value for pattern detect (1=ignore)
      PATTERN => X"000000000000",        -- 48-bit pattern match for pattern detect
      SEL_MASK => "MASK",                -- C, MASK, ROUNDING_MODE1, ROUNDING_MODE2
      SEL_PATTERN => "PATTERN",          -- Select pattern value (C, PATTERN)
      USE_PATTERN_DETECT => "NO_PATDET", -- Enable pattern detect (NO_PATDET, PATDET)
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
      ACASCREG => 1,                     -- Number of pipeline stages between A/ACIN and ACOUT (0-2)
      ADREG => 0,                        -- Pipeline stages for pre-adder (0-1)
      ALUMODEREG => 1,                   -- Pipeline stages for ALUMODE (0-1)
      AREG => 1,                         -- Pipeline stages for A (0-2)
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
      ACOUT => open,                   -- 30-bit output: A port cascade
      BCOUT => open,                   -- 18-bit output: B cascade
      CARRYCASCOUT => open,     -- 1-bit output: Cascade carry
      MULTSIGNOUT => open,       -- 1-bit output: Multiplier sign cascade
      PCOUT => pr1_pprod,                   -- 48-bit output: Cascade output
      -- Control outputs: Control Inputs/Status Bits
      OVERFLOW => open,             -- 1-bit output: Overflow in add/acc
      PATTERNBDETECT => open, -- 1-bit output: Pattern bar detect
      PATTERNDETECT => open,   -- 1-bit output: Pattern detect
      UNDERFLOW => open,           -- 1-bit output: Underflow in add/acc
      -- Data outputs: Data Ports
      CARRYOUT => open,             -- 4-bit output: Carry
      P => open,                           -- 48-bit output: Primary data
      XOROUT => open,                 -- 8-bit output: XOR data
      -- Cascade inputs: Cascade Ports
      ACIN => zeros,                     -- 30-bit input: A cascade data
      BCIN => zeros(17 downto 0),                     -- 18-bit input: B cascade
      CARRYCASCIN => '0',       -- 1-bit input: Cascade carry
      MULTSIGNIN => '0',         -- 1-bit input: Multiplier sign cascade
      PCIN => x"000000000000",                     -- 48-bit input: P cascade
      -- Control inputs: Control Inputs/Status Bits
      ALUMODE => "0000",               -- 4-bit input: ALU control
      CARRYINSEL => "000",         -- 3-bit input: Carry select
      CLK => CLK,                       -- 1-bit input: Clock
      INMODE => "00000",                 -- 5-bit input: INMODE control
      OPMODE => "000110101",                 -- 9-bit input: Operation mode
      -- Data inputs: Data Ports
      A => ar1_sxt,                           -- 30-bit input: A data
      B => br1,                           -- 18-bit input: B data
      C => x"00000000FFFF",             -- 48-bit input: C data
      CARRYIN => '1',               -- 1-bit input: Carry-in
      D => "000000000000000000000000000",                           -- 27-bit input: D data
      -- Reset/Clock Enable inputs: Reset/Clock Enable Inputs
      CEA1 => '1',                     -- 1-bit input: Clock enable for 1st stage AREG
      CEA2 => '1',                     -- 1-bit input: Clock enable for 2nd stage AREG
      CEAD => '0',                     -- 1-bit input: Clock enable for ADREG
      CEALUMODE => '1',           -- 1-bit input: Clock enable for ALUMODE
      CEB1 => '1',                     -- 1-bit input: Clock enable for 1st stage BREG
      CEB2 => '1',                     -- 1-bit input: Clock enable for 2nd stage BREG
      CEC => '1',                       -- 1-bit input: Clock enable for CREG
      CECARRYIN => '1',           -- 1-bit input: Clock enable for CARRYINREG
      CECTRL => '1',                 -- 1-bit input: Clock enable for OPMODEREG and CARRYINSELREG
      CED => '0',                       -- 1-bit input: Clock enable for DREG
      CEINMODE => '1',             -- 1-bit input: Clock enable for INMODEREG
      CEM => '1',                       -- 1-bit input: Clock enable for MREG
      CEP => '1',                       -- 1-bit input: Clock enable for PREG
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

-- ----------------------------------------------------------------------------
-- P2 Real Output Equation
-- ----------------------------------------------------------------------------
   -- DSP48E2: DSP Function Block
   
DSP48E_pr2a_inst : DSP48E2
   generic map (
      -- Feature Control Attributes: Data Path Selection
      AMULTSEL => "A",                   -- Selects A input to multiplier (A, AD)
      A_INPUT => "DIRECT",               -- Selects A input source, "DIRECT" (A port) or "CASCADE" (ACIN port)
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
      MASK => X"FFFFFFFC0000",           -- 48-bit mask value for pattern detect (1=ignore)
      PATTERN => X"000000020000",        -- 48-bit pattern match for pattern detect
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
      ACASCREG => 2,                     -- Number of pipeline stages between A/ACIN and ACOUT (0-2)
      ADREG => 0,                        -- Pipeline stages for pre-adder (0-1)
      ALUMODEREG => 1,                   -- Pipeline stages for ALUMODE (0-1)
      AREG => 2,                         -- Pipeline stages for A (0-2)
      BCASCREG => 2,                     -- Number of pipeline stages between B/BCIN and BCOUT (0-2)
      BREG => 2,                         -- Pipeline stages for B (0-2)
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
      ACOUT => open,                   -- 30-bit output: A port cascade
      BCOUT => open,                   -- 18-bit output: B cascade
      CARRYCASCOUT => open,     -- 1-bit output: Cascade carry
      MULTSIGNOUT => open,       -- 1-bit output: Multiplier sign cascade
      PCOUT => open,                   -- 48-bit output: Cascade output
      -- Control outputs: Control Inputs/Status Bits
      OVERFLOW => open,             -- 1-bit output: Overflow in add/acc
      PATTERNBDETECT => open, -- 1-bit output: Pattern bar detect
      PATTERNDETECT => pr2_pd,   -- 1-bit output: Pattern detect
      UNDERFLOW => open,           -- 1-bit output: Underflow in add/acc
      -- Data outputs: Data Ports
      CARRYOUT => open,             -- 4-bit output: Carry
      P => pr2_prod,                           -- 48-bit output: Primary data
      XOROUT => open,                 -- 8-bit output: XOR data
      -- Cascade inputs: Cascade Ports
      ACIN => zeros,                     -- 30-bit input: A cascade data
      BCIN => zeros(17 downto 0),                     -- 18-bit input: B cascade
      CARRYCASCIN => '0',       -- 1-bit input: Cascade carry
      MULTSIGNIN => '0',         -- 1-bit input: Multiplier sign cascade
      PCIN => pr1_pprod,                     -- 48-bit input: P cascade
      -- Control inputs: Control Inputs/Status Bits
      ALUMODE => pr2a_alumode,               -- 4-bit input: ALU control
      CARRYINSEL => "000",         -- 3-bit input: Carry select
      CLK => CLK,                       -- 1-bit input: Clock
      INMODE => "00000",                 -- 5-bit input: INMODE control
      OPMODE => "000010101",                 -- 9-bit input: Operation mode
      -- Data inputs: Data Ports
      A => ar2_sxt,                           -- 30-bit input: A data
      B => br2,                           -- 18-bit input: B data
      C => x"000000000000",             -- 48-bit input: C data
      CARRYIN => '0',               -- 1-bit input: Carry-in
      D => "000000000000000000000000000",                           -- 27-bit input: D data
      -- Reset/Clock Enable inputs: Reset/Clock Enable Inputs
      CEA1 => '1',                     -- 1-bit input: Clock enable for 1st stage AREG
      CEA2 => '1',                     -- 1-bit input: Clock enable for 2nd stage AREG
      CEAD => '0',                     -- 1-bit input: Clock enable for ADREG
      CEALUMODE => '1',           -- 1-bit input: Clock enable for ALUMODE
      CEB1 => '1',                     -- 1-bit input: Clock enable for 1st stage BREG
      CEB2 => '1',                     -- 1-bit input: Clock enable for 2nd stage BREG
      CEC => '1',                       -- 1-bit input: Clock enable for CREG
      CECARRYIN => '1',           -- 1-bit input: Clock enable for CARRYINREG
      CECTRL => '1',                 -- 1-bit input: Clock enable for OPMODEREG and CARRYINSELREG
      CED => '0',                       -- 1-bit input: Clock enable for DREG
      CEINMODE => '1',             -- 1-bit input: Clock enable for INMODEREG
      CEM => '1',                       -- 1-bit input: Clock enable for MREG
      CEP => '1',                       -- 1-bit input: Clock enable for PREG
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

-- Complete round operation 
process(CLK)
begin
   if rising_edge(CLK) then
      PR_OUT(23 downto 1)  <= pr2_prod(40 downto 18);
      PR_OUT(0)            <= not((not pr2_prod(17)) or pr2_pd);      
  end if;
end process;

-- ----------------------------------------------------------------------------
-- P1 Imaginary Output Equation
-- ----------------------------------------------------------------------------
   -- DSP48E2: DSP Function Block
DSP48E_pi1a_inst : DSP48E2
      generic map (
         -- Feature Control Attributes: Data Path Selection
         AMULTSEL => "A",                   -- Selects A input to multiplier (A, AD)
         A_INPUT => "DIRECT",               -- Selects A input source, "DIRECT" (A port) or "CASCADE" (ACIN port)
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
         MASK => X"3fffffffffff",           -- 48-bit mask value for pattern detect (1=ignore)
         PATTERN => X"000000000000",        -- 48-bit pattern match for pattern detect
         SEL_MASK => "MASK",                -- C, MASK, ROUNDING_MODE1, ROUNDING_MODE2
         SEL_PATTERN => "PATTERN",          -- Select pattern value (C, PATTERN)
         USE_PATTERN_DETECT => "NO_PATDET", -- Enable pattern detect (NO_PATDET, PATDET)
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
         ACASCREG => 1,                     -- Number of pipeline stages between A/ACIN and ACOUT (0-2)
         ADREG => 0,                        -- Pipeline stages for pre-adder (0-1)
         ALUMODEREG => 1,                   -- Pipeline stages for ALUMODE (0-1)
         AREG => 1,                         -- Pipeline stages for A (0-2)
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
         ACOUT => open,                   -- 30-bit output: A port cascade
         BCOUT => open,                   -- 18-bit output: B cascade
         CARRYCASCOUT => open,     -- 1-bit output: Cascade carry
         MULTSIGNOUT => open,       -- 1-bit output: Multiplier sign cascade
         PCOUT => pi1_pprod,                   -- 48-bit output: Cascade output
         -- Control outputs: Control Inputs/Status Bits
         OVERFLOW => open,             -- 1-bit output: Overflow in add/acc
         PATTERNBDETECT => open, -- 1-bit output: Pattern bar detect
         PATTERNDETECT => open,   -- 1-bit output: Pattern detect
         UNDERFLOW => open,           -- 1-bit output: Underflow in add/acc
         -- Data outputs: Data Ports
         CARRYOUT => open,             -- 4-bit output: Carry
         P => open,                           -- 48-bit output: Primary data
         XOROUT => open,                 -- 8-bit output: XOR data
         -- Cascade inputs: Cascade Ports
         ACIN => zeros,                     -- 30-bit input: A cascade data
         BCIN => zeros(17 downto 0),                     -- 18-bit input: B cascade
         CARRYCASCIN => '0',       -- 1-bit input: Cascade carry
         MULTSIGNIN => '0',         -- 1-bit input: Multiplier sign cascade
         PCIN => x"000000000000",                     -- 48-bit input: P cascade
         -- Control inputs: Control Inputs/Status Bits
         ALUMODE => "0000",               -- 4-bit input: ALU control
         CARRYINSEL => "000",         -- 3-bit input: Carry select
         CLK => CLK,                       -- 1-bit input: Clock
         INMODE => "00000",                 -- 5-bit input: INMODE control
         OPMODE => "000110101",                 -- 9-bit input: Operation mode
         -- Data inputs: Data Ports
         A => ar1_sxt,                           -- 30-bit input: A data
         B => bi1,                           -- 18-bit input: B data
         C => x"00000000FFFF",             -- 48-bit input: C data
         CARRYIN => '1',               -- 1-bit input: Carry-in
         D => "000000000000000000000000000",                           -- 27-bit input: D data
         -- Reset/Clock Enable inputs: Reset/Clock Enable Inputs
         CEA1 => '1',                     -- 1-bit input: Clock enable for 1st stage AREG
         CEA2 => '1',                     -- 1-bit input: Clock enable for 2nd stage AREG
         CEAD => '0',                     -- 1-bit input: Clock enable for ADREG
         CEALUMODE => '1',           -- 1-bit input: Clock enable for ALUMODE
         CEB1 => '1',                     -- 1-bit input: Clock enable for 1st stage BREG
         CEB2 => '1',                     -- 1-bit input: Clock enable for 2nd stage BREG
         CEC => '1',                       -- 1-bit input: Clock enable for CREG
         CECARRYIN => '1',           -- 1-bit input: Clock enable for CARRYINREG
         CECTRL => '1',                 -- 1-bit input: Clock enable for OPMODEREG and CARRYINSELREG
         CED => '0',                       -- 1-bit input: Clock enable for DREG
         CEINMODE => '1',             -- 1-bit input: Clock enable for INMODEREG
         CEM => '1',                       -- 1-bit input: Clock enable for MREG
         CEP => '1',                       -- 1-bit input: Clock enable for PREG
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

-- ----------------------------------------------------------------------------
-- P2 Imaginary Output Equation
-- ----------------------------------------------------------------------------
   -- DSP48E2: DSP Function Block
   
   DSP48E_pi2a_inst : DSP48E2
      generic map (
         -- Feature Control Attributes: Data Path Selection
         AMULTSEL => "A",                   -- Selects A input to multiplier (A, AD)
         A_INPUT => "DIRECT",               -- Selects A input source, "DIRECT" (A port) or "CASCADE" (ACIN port)
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
         MASK => X"FFFFFFFC0000",           -- 48-bit mask value for pattern detect (1=ignore)
         PATTERN => X"000000020000",        -- 48-bit pattern match for pattern detect
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
         ACASCREG => 2,                     -- Number of pipeline stages between A/ACIN and ACOUT (0-2)
         ADREG => 0,                        -- Pipeline stages for pre-adder (0-1)
         ALUMODEREG => 1,                   -- Pipeline stages for ALUMODE (0-1)
         AREG => 2,                         -- Pipeline stages for A (0-2)
         BCASCREG => 2,                     -- Number of pipeline stages between B/BCIN and BCOUT (0-2)
         BREG => 2,                         -- Pipeline stages for B (0-2)
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
         ACOUT => open,                   -- 30-bit output: A port cascade
         BCOUT => open,                   -- 18-bit output: B cascade
         CARRYCASCOUT => open,     -- 1-bit output: Cascade carry
         MULTSIGNOUT => open,       -- 1-bit output: Multiplier sign cascade
         PCOUT => open,                   -- 48-bit output: Cascade output
         -- Control outputs: Control Inputs/Status Bits
         OVERFLOW => open,             -- 1-bit output: Overflow in add/acc
         PATTERNBDETECT => open, -- 1-bit output: Pattern bar detect
         PATTERNDETECT => pi2_pd,   -- 1-bit output: Pattern detect
         UNDERFLOW => open,           -- 1-bit output: Underflow in add/acc
         -- Data outputs: Data Ports
         CARRYOUT => open,             -- 4-bit output: Carry
         P => pi2_prod,                           -- 48-bit output: Primary data
         XOROUT => open,                 -- 8-bit output: XOR data
         -- Cascade inputs: Cascade Ports
         ACIN => zeros,                     -- 30-bit input: A cascade data
         BCIN => zeros(17 downto 0),                     -- 18-bit input: B cascade
         CARRYCASCIN => '0',       -- 1-bit input: Cascade carry
         MULTSIGNIN => '0',         -- 1-bit input: Multiplier sign cascade
         PCIN => pi1_pprod,                     -- 48-bit input: P cascade
         -- Control inputs: Control Inputs/Status Bits
         ALUMODE => pi2a_alumode,               -- 4-bit input: ALU control
         CARRYINSEL => "000",         -- 3-bit input: Carry select
         CLK => CLK,                       -- 1-bit input: Clock
         INMODE => "00000",                 -- 5-bit input: INMODE control
         OPMODE => "000010101",                 -- 9-bit input: Operation mode
         -- Data inputs: Data Ports
         A => ar2_sxt,                           -- 30-bit input: A data
         B => bi2,                           -- 18-bit input: B data
         C => x"000000000000",             -- 48-bit input: C data
         CARRYIN => '0',               -- 1-bit input: Carry-in
         D => "000000000000000000000000000",                           -- 27-bit input: D data
         -- Reset/Clock Enable inputs: Reset/Clock Enable Inputs
         CEA1 => '1',                     -- 1-bit input: Clock enable for 1st stage AREG
         CEA2 => '1',                     -- 1-bit input: Clock enable for 2nd stage AREG
         CEAD => '0',                     -- 1-bit input: Clock enable for ADREG
         CEALUMODE => '1',           -- 1-bit input: Clock enable for ALUMODE
         CEB1 => '1',                     -- 1-bit input: Clock enable for 1st stage BREG
         CEB2 => '1',                     -- 1-bit input: Clock enable for 2nd stage BREG
         CEC => '1',                       -- 1-bit input: Clock enable for CREG
         CECARRYIN => '1',           -- 1-bit input: Clock enable for CARRYINREG
         CECTRL => '1',                 -- 1-bit input: Clock enable for OPMODEREG and CARRYINSELREG
         CED => '0',                       -- 1-bit input: Clock enable for DREG
         CEINMODE => '1',             -- 1-bit input: Clock enable for INMODEREG
         CEM => '1',                       -- 1-bit input: Clock enable for MREG
         CEP => '1',                       -- 1-bit input: Clock enable for PREG
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


-- Complete round operation 
process(CLK)
begin
   if rising_edge(CLK) then
      PI_OUT(23 downto 1)  <= pi2_prod(40 downto 18);
      PI_OUT(0)            <= not((not pi2_prod(17)) or pi2_pd);      
  end if;
end process;



end Behavioral;

