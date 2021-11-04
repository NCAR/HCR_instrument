library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity px_8chddcs3_multadd1 is
   port ( A_IN             : in    std_logic_vector (18 downto 0); 
          B_IN             : in    std_logic_vector (17 downto 0); 
          CLK              : in    std_logic; 
          C_IN             : in    std_logic_vector (47 downto 0); 
          PCOUT_OUT        : out   std_logic_vector (47 downto 0); 
          P_OUT            : out   std_logic_vector (47 downto 0));
end px_8chddcs3_multadd1;

architecture BEHAVIORAL of px_8chddcs3_multadd1 is
   signal GND_ALUMODE      : std_logic;
   signal GND_BUS_3        : std_logic_vector (2 downto 0);
   signal GND_BUS_18       : std_logic_vector (17 downto 0);
   signal GND_BUS_30       : std_logic_vector (29 downto 0);
   signal GND_BUS_48       : std_logic_vector (47 downto 0);
   signal GND_OPMODE       : std_logic;
   signal VCC_OPMODE       : std_logic;
begin
   GND_ALUMODE <= '0';
   GND_BUS_3(2 downto 0) <= "000";
   GND_BUS_18(17 downto 0) <= "000000000000000000";
   GND_BUS_30(29 downto 0) <= "000000000000000000000000000000";
   GND_BUS_48(47 downto 0) <= 
         "000000000000000000000000000000000000000000000000";
   GND_OPMODE <= '0';
   VCC_OPMODE <= '1';

  DSP48E2_inst : DSP48E2
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
         ADREG => 1,                        -- Pipeline stages for pre-adder (0-1)
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
         PCOUT => PCOUT_OUT,                   -- 48-bit output: Cascade output
         -- Control outputs: Control Inputs/Status Bits
         OVERFLOW => open,             -- 1-bit output: Overflow in add/acc
         PATTERNBDETECT => open, -- 1-bit output: Pattern bar detect
         PATTERNDETECT => open,   -- 1-bit output: Pattern detect
         UNDERFLOW => open,           -- 1-bit output: Underflow in add/acc
         -- Data outputs: Data Ports
         CARRYOUT => open,             -- 4-bit output: Carry
         P(47 downto 0)=>P_OUT(47 downto 0),    -- 48-bit output: Primary data
         XOROUT => open,                 -- 8-bit output: XOR data
         -- Cascade inputs: Cascade Ports
         ACIN(29 downto 0)=>GND_BUS_30(29 downto 0),
         BCIN(29 downto 0)=>GND_BUS_30(29 downto 0),
         CARRYCASCIN=>GND_ALUMODE,      -- 1-bit input: Cascade carry
         MULTSIGNIN => '0',         -- 1-bit input: Multiplier sign cascade
         PCIN(47 downto 0)=>GND_BUS_48(47 downto 0),                   -- 48-bit input: P cascade
         -- Control inputs: Control Inputs/Status Bits
         -- 4-bit input: ALU control
         ALUMODE(3)=>GND_ALUMODE,
         ALUMODE(2)=>GND_ALUMODE,
         ALUMODE(1)=>GND_ALUMODE,
         ALUMODE(0)=>GND_ALUMODE,
         CARRYINSEL(2 downto 0)=>GND_BUS_3(2 downto 0),
         CLK => CLK,                       -- 1-bit input: Clock
         INMODE => "00000",                 -- 5-bit input: INMODE control
         OPMODE(8)=>GND_OPMODE,
         OPMODE(7)=>GND_OPMODE,
         OPMODE(6)=>GND_OPMODE,
         OPMODE(5)=>VCC_OPMODE,
         OPMODE(4)=>VCC_OPMODE,
         OPMODE(3)=>GND_OPMODE,
         OPMODE(2)=>VCC_OPMODE,
         OPMODE(1)=>GND_OPMODE,
         OPMODE(0)=>VCC_OPMODE,              -- 9-bit input: Operation mode
         -- Data inputs: Data Ports
         A(29)=>A_IN(18),
         A(28)=>A_IN(18),
         A(27)=>A_IN(18),
         A(26)=>A_IN(18),
         A(25)=>A_IN(18),
         A(24)=>A_IN(18),
         A(23)=>A_IN(18),
         A(22)=>A_IN(18),
         A(21)=>A_IN(18),
         A(20)=>A_IN(18),
         A(19)=>A_IN(18),
         A(18 downto 0)=>A_IN(18 downto 0),
         B(17 downto 0)=>B_IN(17 downto 0),
         C(47 downto 0)=>C_IN(47 downto 0),
         CARRYIN=>GND_ALUMODE,              -- 1-bit input: Carry-in
         D =>GND_BUS_30(26 downto 0),                           -- 27-bit input: D data
         -- Reset/Clock Enable inputs: Reset/Clock Enable Inputs
         CEA1 => '1',                     -- 1-bit input: Clock enable for 1st stage AREG
         CEA2 => '1',                     -- 1-bit input: Clock enable for 2nd stage AREG
         CEAD => '1',                     -- 1-bit input: Clock enable for ADREG
         CEALUMODE => CEALUMODE,           -- 1-bit input: Clock enable for ALUMODE
         CEB1 => '1',                     -- 1-bit input: Clock enable for 1st stage BREG
         CEB2 => '1',                     -- 1-bit input: Clock enable for 2nd stage BREG
         CEC => '1',                       -- 1-bit input: Clock enable for CREG
         CECARRYIN => CECARRYIN,           -- 1-bit input: Clock enable for CARRYINREG
         CECTRL => CECTRL,                 -- 1-bit input: Clock enable for OPMODEREG and CARRYINSELREG
         CED => '1',                       -- 1-bit input: Clock enable for DREG
         CEINMODE => CEINMODE,             -- 1-bit input: Clock enable for INMODEREG
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
   
end BEHAVIORAL;


