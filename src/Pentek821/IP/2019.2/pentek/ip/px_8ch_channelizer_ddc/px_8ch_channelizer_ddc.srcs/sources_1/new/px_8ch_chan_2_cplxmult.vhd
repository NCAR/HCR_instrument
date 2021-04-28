----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: Richard Kuenzler
-- 
-- Create Date:    11:31:59 06/22/2007 
-- Design Name: 
-- Module Name:    dual_cmplx_mult - Behavioral 
-- Project Name: 
-- Target Devices: Virtex-5
-- Tool versions: ISE 9.1.03
-- Description: 24-bit Dual Complex Multiplier
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
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity px_8ch_chan_2_cplxmult is
    generic (
         reg_in  : std_logic := '0'; -- '1' = add input register
         add_cntrl_r : STD_LOGIC := '0';
         add_cntrl_i : STD_LOGIC := '0';
         div2 : std_logic := '0' -- '0' = normal output -- '1' = shifted right 1
         );
    port ( 
           AR1_IN : in  STD_LOGIC_VECTOR (23 downto 0);
           AI1_IN : in  STD_LOGIC_VECTOR (23 downto 0);
           BR1_IN : in  STD_LOGIC_VECTOR (17 downto 0);
           BI1_IN : in  STD_LOGIC_VECTOR (17 downto 0);
           AR2_IN : in  STD_LOGIC_VECTOR (23 downto 0);
           AI2_IN : in  STD_LOGIC_VECTOR (23 downto 0);
           BR2_IN : in  STD_LOGIC_VECTOR (17 downto 0);
           BI2_IN : in  STD_LOGIC_VECTOR (17 downto 0);
           CLK : in  STD_LOGIC;
           PR_OUT : out  STD_LOGIC_VECTOR (23 downto 0);
           PI_OUT : out  STD_LOGIC_VECTOR (23 downto 0)
          );
end px_8ch_chan_2_cplxmult;

architecture Behavioral of px_8ch_chan_2_cplxmult is

-- ============================================================================
-- Signals
-- ============================================================================

signal ar1: std_logic_vector(23 downto 0);
signal br1: std_logic_vector(17 downto 0);
signal ai1: std_logic_vector(23 downto 0);
signal bi1: std_logic_vector(17 downto 0);
signal ar2: std_logic_vector(23 downto 0);
signal br2: std_logic_vector(17 downto 0);
signal ai2: std_logic_vector(23 downto 0);
signal bi2: std_logic_vector(17 downto 0);
signal t1_ar2: std_logic_vector(23 downto 0);
signal t1_br2: std_logic_vector(17 downto 0);
signal t1_ai2: std_logic_vector(23 downto 0);
signal t1_bi2: std_logic_vector(17 downto 0);
signal t2_br2: std_logic_vector(17 downto 0);
signal t2_ai2: std_logic_vector(23 downto 0);
signal t2_bi2: std_logic_vector(17 downto 0);
signal ar1_sxt: std_logic_vector(29 downto 0);
signal ai1_sxt: std_logic_vector(29 downto 0);
signal t1_ar2_sxt: std_logic_vector(29 downto 0);
signal t2_ai2_sxt: std_logic_vector(29 downto 0);

signal pr1_pprod: std_logic_vector(47 downto 0);
signal pr2_pprod: std_logic_vector(47 downto 0);
signal pi1_pprod: std_logic_vector(47 downto 0);
signal pi2_pprod: std_logic_vector(47 downto 0);
signal pr2_prod: std_logic_vector(47 downto 0);
signal pi2_prod: std_logic_vector(47 downto 0);

signal pr2_pd: std_logic;
signal pi2_pd: std_logic;

signal pr1_pcout: std_logic_vector(47 downto 0);
signal pi1_pcout: std_logic_vector(47 downto 0);

signal zeros : std_logic_vector(29 downto 0);
 
constant pr2a_alumode : std_logic_vector(3 downto 0) := "00" & add_cntrl_r & add_cntrl_r; 
constant pi2a_alumode : std_logic_vector(3 downto 0) := "00" & add_cntrl_i & add_cntrl_i;
constant pr2b_alumode : std_logic_vector(3 downto 0) := "00" & (not add_cntrl_r) & (not add_cntrl_r); 
constant pi2b_alumode : std_logic_vector(3 downto 0) := "00" & add_cntrl_i & add_cntrl_i;

constant mask_v    : std_logic_vector(47 downto 0):=  X"FFFFFFF" & '1' & (not div2) & "00" & X"0000";
constant pattern_v : std_logic_vector(47 downto 0):=  X"0000000" & '0' & div2 & (not div2) & '0' & X"0000"; 
constant mask    : bit_vector(47 downto 0):=  to_bitvector(mask_v);
constant pattern : bit_vector(47 downto 0):=  to_bitvector(pattern_v); 

-- ============================================================================ 

begin

zeros <= (others => '0');

no_in_reg_gen: if (reg_in /= '1') generate

ar1 <= AR1_IN;
ai1 <= AI1_IN;
br1 <= BR1_IN;
bi1 <= BI1_IN;
ar2 <= AR2_IN;
ai2 <= AI2_IN;
br2 <= BR2_IN;
bi2 <= BI2_IN;

end generate;

in_reg_gen: if (reg_in = '1') generate

process(CLK)
begin
   if rising_edge(CLK) then
      ar1 <= AR1_IN;
      ai1 <= AI1_IN;
      br1 <= BR1_IN;
      bi1 <= BI1_IN;
      ar2 <= AR2_IN;
      ai2 <= AI2_IN;
      br2 <= BR2_IN;
      bi2 <= BI2_IN; 
   end if;
end process;
   
end generate;


process(CLK)
begin
   if rising_edge(CLK) then
      t1_ar2 <= ar2;
      t1_ai2 <= ai2;
      t1_br2 <= br2;
      t1_bi2 <= bi2;
      t2_ai2 <= t1_ai2;
      t2_br2 <= t1_br2; 
      t2_bi2 <= t1_bi2;         
   end if;
end process;

ar1_sxt <= sxt(ar1, 30); 
ai1_sxt <= sxt(ai1, 30);

t1_ar2_sxt <= sxt(t1_ar2, 30);
t2_ai2_sxt <= sxt(t2_ai2, 30);

-- ----------------------------------------------------------------------------
-- P1 Real Output Equation
-- ----------------------------------------------------------------------------

   -- DSP48E: DSP Function Block
   --         Virtex-5
   -- Xilinx HDL Language Template, version 9.1.3i
   
   DSP48E_pr1a_inst : DSP48E
   generic map (
      ACASCREG => 1,       -- Number of pipeline registers between 
                           -- A/ACIN input and ACOUT output, 0, 1, or 2
      ALUMODEREG => 0,     -- Number of pipeline registers on ALUMODE input, 0 or 1
      AREG => 1,           -- Number of pipeline registers on the A input, 0, 1 or 2
      AUTORESET_PATTERN_DETECT => FALSE, -- Auto-reset upon pattern detect, TRUE or FALSE
      AUTORESET_PATTERN_DETECT_OPTINV => "MATCH", -- Reset if "MATCH" or "NOMATCH" 
      A_INPUT => "DIRECT", -- Selects A input used, "DIRECT" (A port) or "CASCADE" (ACIN port)
      BCASCREG => 1,       -- Number of pipeline registers between B/BCIN input and BCOUT output, 0, 1, or 2
      BREG => 1,           -- Number of pipeline registers on the B input, 0, 1 or 2
      B_INPUT => "DIRECT", -- Selects B input used, "DIRECT" (B port) or "CASCADE" (BCIN port)
      CARRYINREG => 0,     -- Number of pipeline registers for the CARRYIN input, 0 or 1
      CARRYINSELREG => 0,  -- Number of pipeline registers for the CARRYINSEL input, 0 or 1
      CREG => 1,           -- Number of pipeline registers on the C input, 0 or 1
      MASK => X"FFFFFFFC0000", -- 48-bit Mask value for pattern detect
      MREG => 1,           -- Number of multiplier pipeline registers, 0 or 1
      MULTCARRYINREG => 0, -- Number of pipeline registers for multiplier carry in bit, 0 or 1
      OPMODEREG => 0,      -- Number of pipeline registers on OPMODE input, 0 or 1
      PATTERN => X"000000020000", -- 48-bit Pattern match for pattern detect
      PREG => 1,           -- Number of pipeline registers on the P output, 0 or 1
      SEL_MASK => "MASK",  -- Select mask value between the "MASK" value or the value on the "C" port
      SEL_PATTERN => "PATTERN", -- Select pattern value between the "PATTERN" value or the value on the "C" port
      SEL_ROUNDING_MASK => "SEL_MASK", -- "SEL_MASK", "MODE1", "MODE2" 
      USE_MULT => "MULT_S", -- Select multiplier usage, "MULT" (MREG => 0), 
                            -- "MULT_S" (MREG => 1), "NONE" (not using multiplier)
      USE_PATTERN_DETECT => "NO_PATDET", -- Enable pattern detect, "PATDET", "NO_PATDET" 
      USE_SIMD => "ONE48") -- SIMD selection, "ONE48", "TWO24", "FOUR12" 
   port map (
      P => open,          -- 48-bit output
      PATTERNDETECT => open, --  1-bit active high pattern detect output
      PCOUT => pr1_pprod,  -- 48-bit cascade output
      A => ar1_sxt,  -- 30-bit A data input
      ACIN => zeros,
      BCIN => zeros(17 downto 0),
      CARRYCASCIN => '0',
      MULTSIGNIN => '0',
      PCIN => x"000000000000",
      ALUMODE => "0000", -- 4-bit ALU control input
      B => br1,    -- 18-bit B data input
      C => x"00000000FFFF",   -- 48-bit C data input
      CARRYIN => '1', -- 1-bit carry input signal
      CARRYINSEL => "000", -- 3-bit carry select input
      CEA1 => '1',      -- 1-bit active high clock enable input for 1st stage A registers
      CEA2 => '1',      -- 1-bit active high clock enable input for 2nd stage A registers
      CEALUMODE => '0', -- 1-bit active high clock enable input for ALUMODE registers
      CEB1 => '1',      -- 1-bit active high clock enable input for 1st stage B registers
      CEB2 => '1',      -- 1-bit active high clock enable input for 2nd stage B registers
      CEC => '1',      -- 1-bit active high clock enable input for C registers
      CECARRYIN => '0', -- 1-bit active high clock enable input for CARRYIN register
      CECTRL => '0', -- 1-bit active high clock enable input for OPMODE and carry registers
      CEM => '1',       -- 1-bit active high clock enable input for multiplier registers
      CEMULTCARRYIN => '0', -- 1-bit active high clock enable for multiplier carry in register
      CEP => '1',       -- 1-bit active high clock enable input for P registers
      CLK => CLK,       -- Clock input
      OPMODE => "0110101", -- 7-bit operation mode input
      RSTA => '0',     -- 1-bit reset input for A pipeline registers
      RSTALLCARRYIN => '0', -- 1-bit reset input for carry pipeline registers
      RSTALUMODE => '0', -- 1-bit reset input for ALUMODE pipeline registers
      RSTB => '0',     -- 1-bit reset input for B pipeline registers
      RSTC => '0',     -- 1-bit reset input for C pipeline registers
      RSTCTRL => '0', -- 1-bit reset input for OPMODE pipeline registers
      RSTM => '0', -- 1-bit reset input for multiplier registers
      RSTP => '0'  -- 1-bit reset input for P pipeline registers
);

-- End of DSP48E_inst instantiation

   -- DSP48E: DSP Function Block
   --         Virtex-5
   -- Xilinx HDL Language Template, version 9.1.3i
   
   DSP48E_pr1b_inst : DSP48E
   generic map (
      ACASCREG => 2,       -- Number of pipeline registers between 
                           -- A/ACIN input and ACOUT output, 0, 1, or 2
      ALUMODEREG => 0,     -- Number of pipeline registers on ALUMODE input, 0 or 1
      AREG => 2,           -- Number of pipeline registers on the A input, 0, 1 or 2
      AUTORESET_PATTERN_DETECT => FALSE, -- Auto-reset upon pattern detect, TRUE or FALSE
      AUTORESET_PATTERN_DETECT_OPTINV => "MATCH", -- Reset if "MATCH" or "NOMATCH" 
      A_INPUT => "DIRECT", -- Selects A input used, "DIRECT" (A port) or "CASCADE" (ACIN port)
      BCASCREG => 2,       -- Number of pipeline registers between B/BCIN input and BCOUT output, 0, 1, or 2
      BREG => 2,           -- Number of pipeline registers on the B input, 0, 1 or 2
      B_INPUT => "DIRECT", -- Selects B input used, "DIRECT" (B port) or "CASCADE" (BCIN port)
      CARRYINREG => 0,     -- Number of pipeline registers for the CARRYIN input, 0 or 1
      CARRYINSELREG => 0,  -- Number of pipeline registers for the CARRYINSEL input, 0 or 1
      CREG => 0,           -- Number of pipeline registers on the C input, 0 or 1
      MASK => X"FFFFFFFC0000", -- 48-bit Mask value for pattern detect
      MREG => 1,           -- Number of multiplier pipeline registers, 0 or 1
      MULTCARRYINREG => 0, -- Number of pipeline registers for multiplier carry in bit, 0 or 1
      OPMODEREG => 0,      -- Number of pipeline registers on OPMODE input, 0 or 1
      PATTERN => X"000000020000", -- 48-bit Pattern match for pattern detect
      PREG => 1,           -- Number of pipeline registers on the P output, 0 or 1
      SEL_MASK => "MASK",  -- Select mask value between the "MASK" value or the value on the "C" port
      SEL_PATTERN => "PATTERN", -- Select pattern value between the "PATTERN" value or the value on the "C" port
      SEL_ROUNDING_MASK => "SEL_MASK", -- "SEL_MASK", "MODE1", "MODE2" 
      USE_MULT => "MULT_S", -- Select multiplier usage, "MULT" (MREG => 0), 
                            -- "MULT_S" (MREG => 1), "NONE" (not using multiplier)
      USE_PATTERN_DETECT => "NO_PATDET", -- Enable pattern detect, "PATDET", "NO_PATDET" 
      USE_SIMD => "ONE48") -- SIMD selection, "ONE48", "TWO24", "FOUR12" 
   port map (
      P => open,          -- 48-bit output
      PATTERNDETECT => open, --  1-bit active high pattern detect output
      PCOUT => pr1_pcout,  -- 48-bit cascade output
      A => ai1_sxt,  -- 30-bit A data input
      ACIN => zeros,
      BCIN => zeros(17 downto 0),
      CARRYCASCIN => '0',
      MULTSIGNIN => '0',
      ALUMODE => "0011", -- 4-bit ALU control input
      B => bi1,    -- 18-bit B data input
      C => x"000000000000",   -- 48-bit C data input
      CARRYIN => '0', -- 1-bit carry input signal
      CARRYINSEL => "000", -- 3-bit carry select input
      CEA1 => '1',      -- 1-bit active high clock enable input for 1st stage A registers
      CEA2 => '1',      -- 1-bit active high clock enable input for 2nd stage A registers
      CEALUMODE => '0', -- 1-bit active high clock enable input for ALUMODE registers
      CEB1 => '1',      -- 1-bit active high clock enable input for 1st stage B registers
      CEB2 => '1',      -- 1-bit active high clock enable input for 2nd stage B registers
      CEC => '1',      -- 1-bit active high clock enable input for C registers
      CECARRYIN => '0', -- 1-bit active high clock enable input for CARRYIN register
      CECTRL => '0', -- 1-bit active high clock enable input for OPMODE and carry registers
      CEM => '1',       -- 1-bit active high clock enable input for multiplier registers
      CEMULTCARRYIN => '0', -- 1-bit active high clock enable for multiplier carry in register
      CEP => '1',       -- 1-bit active high clock enable input for P registers
      CLK => CLK,       -- Clock input
      PCIN => pr1_pprod,  -- 48-bit P cascade input 
      OPMODE => "0010101", -- 7-bit operation mode input
      RSTA => '0',     -- 1-bit reset input for A pipeline registers
      RSTALLCARRYIN => '0', -- 1-bit reset input for carry pipeline registers
      RSTALUMODE => '0', -- 1-bit reset input for ALUMODE pipeline registers
      RSTB => '0',     -- 1-bit reset input for B pipeline registers
      RSTC => '0',     -- 1-bit reset input for C pipeline registers
      RSTCTRL => '0', -- 1-bit reset input for OPMODE pipeline registers
      RSTM => '0', -- 1-bit reset input for multiplier registers
      RSTP => '0' -- 1-bit reset input for P pipeline registers
);


-- ----------------------------------------------------------------------------
-- P2 Real Output Equation
-- ----------------------------------------------------------------------------
   -- DSP48E: DSP Function Block
   --         Virtex-5
   -- Xilinx HDL Language Template, version 9.1.3i
   
   DSP48E_pr2a_inst : DSP48E
   generic map (
      ACASCREG => 2,       -- Number of pipeline registers between 
                           -- A/ACIN input and ACOUT output, 0, 1, or 2
      ALUMODEREG => 0,     -- Number of pipeline registers on ALUMODE input, 0 or 1
      AREG => 2,           -- Number of pipeline registers on the A input, 0, 1 or 2
      AUTORESET_PATTERN_DETECT => FALSE, -- Auto-reset upon pattern detect, TRUE or FALSE
      AUTORESET_PATTERN_DETECT_OPTINV => "MATCH", -- Reset if "MATCH" or "NOMATCH" 
      A_INPUT => "DIRECT", -- Selects A input used, "DIRECT" (A port) or "CASCADE" (ACIN port)
      BCASCREG => 2,       -- Number of pipeline registers between B/BCIN input and BCOUT output, 0, 1, or 2
      BREG => 2,           -- Number of pipeline registers on the B input, 0, 1 or 2
      B_INPUT => "DIRECT", -- Selects B input used, "DIRECT" (B port) or "CASCADE" (BCIN port)
      CARRYINREG => 0,     -- Number of pipeline registers for the CARRYIN input, 0 or 1
      CARRYINSELREG => 0,  -- Number of pipeline registers for the CARRYINSEL input, 0 or 1
      CREG => 0,           -- Number of pipeline registers on the C input, 0 or 1
      MASK => X"FFFFFFFC0000", -- 48-bit Mask value for pattern detect
      MREG => 1,           -- Number of multiplier pipeline registers, 0 or 1
      MULTCARRYINREG => 0, -- Number of pipeline registers for multiplier carry in bit, 0 or 1
      OPMODEREG => 0,      -- Number of pipeline registers on OPMODE input, 0 or 1
      PATTERN => X"000000020000", -- 48-bit Pattern match for pattern detect
      PREG => 1,           -- Number of pipeline registers on the P output, 0 or 1
      SEL_MASK => "MASK",  -- Select mask value between the "MASK" value or the value on the "C" port
      SEL_PATTERN => "PATTERN", -- Select pattern value between the "PATTERN" value or the value on the "C" port
      SEL_ROUNDING_MASK => "SEL_MASK", -- "SEL_MASK", "MODE1", "MODE2" 
      USE_MULT => "MULT_S", -- Select multiplier usage, "MULT" (MREG => 0), 
                            -- "MULT_S" (MREG => 1), "NONE" (not using multiplier)
      USE_PATTERN_DETECT => "NO_PATDET", -- Enable pattern detect, "PATDET", "NO_PATDET" 
      USE_SIMD => "ONE48") -- SIMD selection, "ONE48", "TWO24", "FOUR12" 
   port map (
      P => open,          -- 48-bit output
      PATTERNDETECT => open, --  1-bit active high pattern detect output
      PCOUT => pr2_pprod,  -- 48-bit cascade output
      A => t1_ar2_sxt,  -- 30-bit A data input
      ACIN => zeros,
      BCIN => zeros(17 downto 0),
      CARRYCASCIN => '0',
      MULTSIGNIN => '0',
      PCIN => pr1_pcout,
      ALUMODE => pr2a_alumode, -- 4-bit ALU control input
      B => t1_br2,    -- 18-bit B data input
      C => x"000000000000",   -- 48-bit C data input
      CARRYIN => '0', -- 1-bit carry input signal
      CARRYINSEL => "000", -- 3-bit carry select input
      CEA1 => '1',      -- 1-bit active high clock enable input for 1st stage A registers
      CEA2 => '1',      -- 1-bit active high clock enable input for 2nd stage A registers
      CEALUMODE => '0', -- 1-bit active high clock enable input for ALUMODE registers
      CEB1 => '1',      -- 1-bit active high clock enable input for 1st stage B registers
      CEB2 => '1',      -- 1-bit active high clock enable input for 2nd stage B registers
      CEC => '0',      -- 1-bit active high clock enable input for C registers
      CECARRYIN => '0', -- 1-bit active high clock enable input for CARRYIN register
      CECTRL => '0', -- 1-bit active high clock enable input for OPMODE and carry registers
      CEM => '1',       -- 1-bit active high clock enable input for multiplier registers
      CEMULTCARRYIN => '0', -- 1-bit active high clock enable for multiplier carry in register
      CEP => '1',       -- 1-bit active high clock enable input for P registers
      CLK => CLK,       -- Clock input
      OPMODE => "0010101", -- 7-bit operation mode input
      RSTA => '0',     -- 1-bit reset input for A pipeline registers
      RSTALLCARRYIN => '0', -- 1-bit reset input for carry pipeline registers
      RSTALUMODE => '0', -- 1-bit reset input for ALUMODE pipeline registers
      RSTB => '0',     -- 1-bit reset input for B pipeline registers
      RSTC => '0',     -- 1-bit reset input for C pipeline registers
      RSTCTRL => '0', -- 1-bit reset input for OPMODE pipeline registers
      RSTM => '0', -- 1-bit reset input for multiplier registers
      RSTP => '0'  -- 1-bit reset input for P pipeline registers
);

-- End of DSP48E_inst instantiation

   -- DSP48E: DSP Function Block
   --         Virtex-5
   -- Xilinx HDL Language Template, version 9.1.3i
   
   DSP48E_pr2b_inst : DSP48E
   generic map (
      ACASCREG => 2,       -- Number of pipeline registers between 
                           -- A/ACIN input and ACOUT output, 0, 1, or 2
      ALUMODEREG => 0,     -- Number of pipeline registers on ALUMODE input, 0 or 1
      AREG => 2,           -- Number of pipeline registers on the A input, 0, 1 or 2
      AUTORESET_PATTERN_DETECT => FALSE, -- Auto-reset upon pattern detect, TRUE or FALSE
      AUTORESET_PATTERN_DETECT_OPTINV => "MATCH", -- Reset if "MATCH" or "NOMATCH" 
      A_INPUT => "DIRECT", -- Selects A input used, "DIRECT" (A port) or "CASCADE" (ACIN port)
      BCASCREG => 2,       -- Number of pipeline registers between B/BCIN input and BCOUT output, 0, 1, or 2
      BREG => 2,           -- Number of pipeline registers on the B input, 0, 1 or 2
      B_INPUT => "DIRECT", -- Selects B input used, "DIRECT" (B port) or "CASCADE" (BCIN port)
      CARRYINREG => 0,     -- Number of pipeline registers for the CARRYIN input, 0 or 1
      CARRYINSELREG => 0,  -- Number of pipeline registers for the CARRYINSEL input, 0 or 1
      CREG => 0,           -- Number of pipeline registers on the C input, 0 or 1
      MASK => mask, --X"FFFFFFFC0000", -- 48-bit Mask value for pattern detect
      MREG => 1,           -- Number of multiplier pipeline registers, 0 or 1
      MULTCARRYINREG => 0, -- Number of pipeline registers for multiplier carry in bit, 0 or 1
      OPMODEREG => 0,      -- Number of pipeline registers on OPMODE input, 0 or 1
      PATTERN => pattern, --X"000000020000", -- 48-bit Pattern match for pattern detect
      PREG => 1,           -- Number of pipeline registers on the P output, 0 or 1
      SEL_MASK => "MASK",  -- Select mask value between the "MASK" value or the value on the "C" port
      SEL_PATTERN => "PATTERN", -- Select pattern value between the "PATTERN" value or the value on the "C" port
      SEL_ROUNDING_MASK => "SEL_MASK", -- "SEL_MASK", "MODE1", "MODE2" 
      USE_MULT => "MULT_S", -- Select multiplier usage, "MULT" (MREG => 0), 
                            -- "MULT_S" (MREG => 1), "NONE" (not using multiplier)
      USE_PATTERN_DETECT => "PATDET", -- Enable pattern detect, "PATDET", "NO_PATDET" 
      USE_SIMD => "ONE48") -- SIMD selection, "ONE48", "TWO24", "FOUR12" 
   port map (
      P => pr2_prod,          -- 48-bit output
      PATTERNDETECT => pr2_pd, --  1-bit active high pattern detect output
      PCOUT => open,  -- 48-bit cascade output
      A => t2_ai2_sxt,  -- 30-bit A data input
      ACIN => zeros,
      BCIN => zeros(17 downto 0),
      CARRYCASCIN => '0',
      MULTSIGNIN => '0',
      ALUMODE => pr2b_alumode, -- 4-bit ALU control input
      B => t2_bi2,    -- 18-bit B data input
      C => x"000000000000",   -- 48-bit C data input
      CARRYIN => '0', -- 1-bit carry input signal
      CARRYINSEL => "000", -- 3-bit carry select input
      CEA1 => '1',      -- 1-bit active high clock enable input for 1st stage A registers
      CEA2 => '1',      -- 1-bit active high clock enable input for 2nd stage A registers
      CEALUMODE => '0', -- 1-bit active high clock enable input for ALUMODE registers
      CEB1 => '1',      -- 1-bit active high clock enable input for 1st stage B registers
      CEB2 => '1',      -- 1-bit active high clock enable input for 2nd stage B registers
      CEC => '0',      -- 1-bit active high clock enable input for C registers
      CECARRYIN => '0', -- 1-bit active high clock enable input for CARRYIN register
      CECTRL => '0', -- 1-bit active high clock enable input for OPMODE and carry registers
      CEM => '1',       -- 1-bit active high clock enable input for multiplier registers
      CEMULTCARRYIN => '0', -- 1-bit active high clock enable for multiplier carry in register
      CEP => '1',       -- 1-bit active high clock enable input for P registers
      CLK => CLK,       -- Clock input
      PCIN => pr2_pprod,  -- 48-bit P cascade input 
      OPMODE => "0010101", -- 7-bit operation mode input
      RSTA => '0',     -- 1-bit reset input for A pipeline registers
      RSTALLCARRYIN => '0', -- 1-bit reset input for carry pipeline registers
      RSTALUMODE => '0', -- 1-bit reset input for ALUMODE pipeline registers
      RSTB => '0',     -- 1-bit reset input for B pipeline registers
      RSTC => '0',     -- 1-bit reset input for C pipeline registers
      RSTCTRL => '0', -- 1-bit reset input for OPMODE pipeline registers
      RSTM => '0', -- 1-bit reset input for multiplier registers
      RSTP => '0'  -- 1-bit reset input for P pipeline registers
);

-- End of DSP48E_inst instantiation

-- Complete round operation 
no_div2_gen_r: if div2 /= '1' generate

-- Complete round operation 
process(CLK)
begin
   if rising_edge(CLK) then
      PR_OUT(23 downto 1)  <= pr2_prod(40 downto 18);
      PR_OUT(0)            <= not((not pr2_prod(17)) or pr2_pd);   
  end if;
end process;

end generate;

div2_gen_r: if div2 = '1' generate

-- Complete round operation 
process(CLK)
begin
   if rising_edge(CLK) then
      PR_OUT(23 downto 1)  <= pr2_prod(41 downto 19);
      PR_OUT(0)            <= not((not pr2_prod(18)) or pr2_pd);   
  end if;
end process;

end generate;


-- ----------------------------------------------------------------------------
-- P1 Imaginary Output Equation
-- ----------------------------------------------------------------------------
   -- DSP48E: DSP Function Block
   --         Virtex-5
   -- Xilinx HDL Language Template, version 9.1.3i
   
   DSP48E_pi1a_inst : DSP48E
   generic map (
      ACASCREG => 1,       -- Number of pipeline registers between 
                           -- A/ACIN input and ACOUT output, 0, 1, or 2
      ALUMODEREG => 0,     -- Number of pipeline registers on ALUMODE input, 0 or 1
      AREG => 1,           -- Number of pipeline registers on the A input, 0, 1 or 2
      AUTORESET_PATTERN_DETECT => FALSE, -- Auto-reset upon pattern detect, TRUE or FALSE
      AUTORESET_PATTERN_DETECT_OPTINV => "MATCH", -- Reset if "MATCH" or "NOMATCH" 
      A_INPUT => "DIRECT", -- Selects A input used, "DIRECT" (A port) or "CASCADE" (ACIN port)
      BCASCREG => 1,       -- Number of pipeline registers between B/BCIN input and BCOUT output, 0, 1, or 2
      BREG => 1,           -- Number of pipeline registers on the B input, 0, 1 or 2
      B_INPUT => "DIRECT", -- Selects B input used, "DIRECT" (B port) or "CASCADE" (BCIN port)
      CARRYINREG => 0,     -- Number of pipeline registers for the CARRYIN input, 0 or 1
      CARRYINSELREG => 0,  -- Number of pipeline registers for the CARRYINSEL input, 0 or 1
      CREG => 1,           -- Number of pipeline registers on the C input, 0 or 1
      MASK => X"FFFFFFFC0000", -- 48-bit Mask value for pattern detect
      MREG => 1,           -- Number of multiplier pipeline registers, 0 or 1
      MULTCARRYINREG => 0, -- Number of pipeline registers for multiplier carry in bit, 0 or 1
      OPMODEREG => 0,      -- Number of pipeline registers on OPMODE input, 0 or 1
      PATTERN => X"000000020000", -- 48-bit Pattern match for pattern detect
      PREG => 1,           -- Number of pipeline registers on the P output, 0 or 1
      SEL_MASK => "MASK",  -- Select mask value between the "MASK" value or the value on the "C" port
      SEL_PATTERN => "PATTERN", -- Select pattern value between the "PATTERN" value or the value on the "C" port
      SEL_ROUNDING_MASK => "SEL_MASK", -- "SEL_MASK", "MODE1", "MODE2" 
      USE_MULT => "MULT_S", -- Select multiplier usage, "MULT" (MREG => 0), 
                            -- "MULT_S" (MREG => 1), "NONE" (not using multiplier)
      USE_PATTERN_DETECT => "NO_PATDET", -- Enable pattern detect, "PATDET", "NO_PATDET" 
      USE_SIMD => "ONE48") -- SIMD selection, "ONE48", "TWO24", "FOUR12" 
   port map (
      P => open,          -- 48-bit output
      PATTERNDETECT => open, --  1-bit active high pattern detect output
      PCOUT => pi1_pprod,  -- 48-bit cascade output
      A => ar1_sxt,  -- 30-bit A data input
      ACIN => zeros,
      BCIN => zeros(17 downto 0),
      CARRYCASCIN => '0',
      MULTSIGNIN => '0',
      PCIN => x"000000000000",
      ALUMODE => "0000", -- 4-bit ALU control input
      B => bi1,    -- 18-bit B data input
      C => x"00000000FFFF",   -- 48-bit C data input
      CARRYIN => '1', -- 1-bit carry input signal
      CARRYINSEL => "000", -- 3-bit carry select input
      CEA1 => '1',      -- 1-bit active high clock enable input for 1st stage A registers
      CEA2 => '1',      -- 1-bit active high clock enable input for 2nd stage A registers
      CEALUMODE => '0', -- 1-bit active high clock enable input for ALUMODE registers
      CEB1 => '1',      -- 1-bit active high clock enable input for 1st stage B registers
      CEB2 => '1',      -- 1-bit active high clock enable input for 2nd stage B registers
      CEC => '1',      -- 1-bit active high clock enable input for C registers
      CECARRYIN => '0', -- 1-bit active high clock enable input for CARRYIN register
      CECTRL => '0', -- 1-bit active high clock enable input for OPMODE and carry registers
      CEM => '1',       -- 1-bit active high clock enable input for multiplier registers
      CEMULTCARRYIN => '0', -- 1-bit active high clock enable for multiplier carry in register
      CEP => '1',       -- 1-bit active high clock enable input for P registers
      CLK => CLK,       -- Clock input
      OPMODE => "0110101", -- 7-bit operation mode input
      RSTA => '0',     -- 1-bit reset input for A pipeline registers
      RSTALLCARRYIN => '0', -- 1-bit reset input for carry pipeline registers
      RSTALUMODE => '0', -- 1-bit reset input for ALUMODE pipeline registers
      RSTB => '0',     -- 1-bit reset input for B pipeline registers
      RSTC => '0',     -- 1-bit reset input for C pipeline registers
      RSTCTRL => '0', -- 1-bit reset input for OPMODE pipeline registers
      RSTM => '0', -- 1-bit reset input for multiplier registers
      RSTP => '0'  -- 1-bit reset input for P pipeline registers
);

-- End of DSP48E_inst instantiation

   -- DSP48E: DSP Function Block
   --         Virtex-5
   -- Xilinx HDL Language Template, version 9.1.3i
   
   DSP48E_pi1b_inst : DSP48E
   generic map (
      ACASCREG => 2,       -- Number of pipeline registers between 
                           -- A/ACIN input and ACOUT output, 0, 1, or 2
      ALUMODEREG => 0,     -- Number of pipeline registers on ALUMODE input, 0 or 1
      AREG => 2,           -- Number of pipeline registers on the A input, 0, 1 or 2
      AUTORESET_PATTERN_DETECT => FALSE, -- Auto-reset upon pattern detect, TRUE or FALSE
      AUTORESET_PATTERN_DETECT_OPTINV => "MATCH", -- Reset if "MATCH" or "NOMATCH" 
      A_INPUT => "DIRECT", -- Selects A input used, "DIRECT" (A port) or "CASCADE" (ACIN port)
      BCASCREG => 2,       -- Number of pipeline registers between B/BCIN input and BCOUT output, 0, 1, or 2
      BREG => 2,           -- Number of pipeline registers on the B input, 0, 1 or 2
      B_INPUT => "DIRECT", -- Selects B input used, "DIRECT" (B port) or "CASCADE" (BCIN port)
      CARRYINREG => 0,     -- Number of pipeline registers for the CARRYIN input, 0 or 1
      CARRYINSELREG => 0,  -- Number of pipeline registers for the CARRYINSEL input, 0 or 1
      CREG => 0,           -- Number of pipeline registers on the C input, 0 or 1
      MASK => X"FFFFFFFC0000", -- 48-bit Mask value for pattern detect
      MREG => 1,           -- Number of multiplier pipeline registers, 0 or 1
      MULTCARRYINREG => 0, -- Number of pipeline registers for multiplier carry in bit, 0 or 1
      OPMODEREG => 0,      -- Number of pipeline registers on OPMODE input, 0 or 1
      PATTERN => X"000000020000", -- 48-bit Pattern match for pattern detect
      PREG => 1,           -- Number of pipeline registers on the P output, 0 or 1
      SEL_MASK => "MASK",  -- Select mask value between the "MASK" value or the value on the "C" port
      SEL_PATTERN => "PATTERN", -- Select pattern value between the "PATTERN" value or the value on the "C" port
      SEL_ROUNDING_MASK => "SEL_MASK", -- "SEL_MASK", "MODE1", "MODE2" 
      USE_MULT => "MULT_S", -- Select multiplier usage, "MULT" (MREG => 0), 
                            -- "MULT_S" (MREG => 1), "NONE" (not using multiplier)
      USE_PATTERN_DETECT => "NO_PATDET", -- Enable pattern detect, "PATDET", "NO_PATDET" 
      USE_SIMD => "ONE48") -- SIMD selection, "ONE48", "TWO24", "FOUR12" 
   port map (
      P => open,          -- 48-bit output
      PATTERNDETECT => open, --  1-bit active high pattern detect output
      PCOUT => pi1_pcout,  -- 48-bit cascade output
      A => ai1_sxt,  -- 30-bit A data input
      ACIN => zeros,
      BCIN => zeros(17 downto 0),
      CARRYCASCIN => '0',
      MULTSIGNIN => '0',
      ALUMODE => "0000", -- 4-bit ALU control input
      B => br1,    -- 18-bit B data input
      C => x"000000000000",   -- 48-bit C data input
      CARRYIN => '0', -- 1-bit carry input signal
      CARRYINSEL => "000", -- 3-bit carry select input
      CEA1 => '1',      -- 1-bit active high clock enable input for 1st stage A registers
      CEA2 => '1',      -- 1-bit active high clock enable input for 2nd stage A registers
      CEALUMODE => '0', -- 1-bit active high clock enable input for ALUMODE registers
      CEB1 => '1',      -- 1-bit active high clock enable input for 1st stage B registers
      CEB2 => '1',      -- 1-bit active high clock enable input for 2nd stage B registers
      CEC => '1',      -- 1-bit active high clock enable input for C registers
      CECARRYIN => '0', -- 1-bit active high clock enable input for CARRYIN register
      CECTRL => '0', -- 1-bit active high clock enable input for OPMODE and carry registers
      CEM => '1',       -- 1-bit active high clock enable input for multiplier registers
      CEMULTCARRYIN => '0', -- 1-bit active high clock enable for multiplier carry in register
      CEP => '1',       -- 1-bit active high clock enable input for P registers
      CLK => CLK,       -- Clock input
      PCIN => pi1_pprod,  -- 48-bit P cascade input 
      OPMODE => "0010101", -- 7-bit operation mode input
      RSTA => '0',     -- 1-bit reset input for A pipeline registers
      RSTALLCARRYIN => '0', -- 1-bit reset input for carry pipeline registers
      RSTALUMODE => '0', -- 1-bit reset input for ALUMODE pipeline registers
      RSTB => '0',     -- 1-bit reset input for B pipeline registers
      RSTC => '0',     -- 1-bit reset input for C pipeline registers
      RSTCTRL => '0', -- 1-bit reset input for OPMODE pipeline registers
      RSTM => '0', -- 1-bit reset input for multiplier registers
      RSTP => '0' -- 1-bit reset input for P pipeline registers
);


-- ----------------------------------------------------------------------------
-- P2 Imaginary Output Equation
-- ----------------------------------------------------------------------------
   -- DSP48E: DSP Function Block
   --         Virtex-5
   -- Xilinx HDL Language Template, version 9.1.3i
   
   DSP48E_pi2a_inst : DSP48E
   generic map (
      ACASCREG => 2,       -- Number of pipeline registers between 
                           -- A/ACIN input and ACOUT output, 0, 1, or 2
      ALUMODEREG => 0,     -- Number of pipeline registers on ALUMODE input, 0 or 1
      AREG => 2,           -- Number of pipeline registers on the A input, 0, 1 or 2
      AUTORESET_PATTERN_DETECT => FALSE, -- Auto-reset upon pattern detect, TRUE or FALSE
      AUTORESET_PATTERN_DETECT_OPTINV => "MATCH", -- Reset if "MATCH" or "NOMATCH" 
      A_INPUT => "DIRECT", -- Selects A input used, "DIRECT" (A port) or "CASCADE" (ACIN port)
      BCASCREG => 2,       -- Number of pipeline registers between B/BCIN input and BCOUT output, 0, 1, or 2
      BREG => 2,           -- Number of pipeline registers on the B input, 0, 1 or 2
      B_INPUT => "DIRECT", -- Selects B input used, "DIRECT" (B port) or "CASCADE" (BCIN port)
      CARRYINREG => 0,     -- Number of pipeline registers for the CARRYIN input, 0 or 1
      CARRYINSELREG => 0,  -- Number of pipeline registers for the CARRYINSEL input, 0 or 1
      CREG => 0,           -- Number of pipeline registers on the C input, 0 or 1
      MASK => X"FFFFFFFC0000", -- 48-bit Mask value for pattern detect
      MREG => 1,           -- Number of multiplier pipeline registers, 0 or 1
      MULTCARRYINREG => 0, -- Number of pipeline registers for multiplier carry in bit, 0 or 1
      OPMODEREG => 0,      -- Number of pipeline registers on OPMODE input, 0 or 1
      PATTERN => X"000000020000", -- 48-bit Pattern match for pattern detect
      PREG => 1,           -- Number of pipeline registers on the P output, 0 or 1
      SEL_MASK => "MASK",  -- Select mask value between the "MASK" value or the value on the "C" port
      SEL_PATTERN => "PATTERN", -- Select pattern value between the "PATTERN" value or the value on the "C" port
      SEL_ROUNDING_MASK => "SEL_MASK", -- "SEL_MASK", "MODE1", "MODE2" 
      USE_MULT => "MULT_S", -- Select multiplier usage, "MULT" (MREG => 0), 
                            -- "MULT_S" (MREG => 1), "NONE" (not using multiplier)
      USE_PATTERN_DETECT => "NO_PATDET", -- Enable pattern detect, "PATDET", "NO_PATDET" 
      USE_SIMD => "ONE48") -- SIMD selection, "ONE48", "TWO24", "FOUR12" 
   port map (
      P => open,          -- 48-bit output
      PATTERNDETECT => open, --  1-bit active high pattern detect output
      PCOUT => pi2_pprod,  -- 48-bit cascade output
      A => t1_ar2_sxt,  -- 30-bit A data input
      ACIN => zeros,
      BCIN => zeros(17 downto 0),
      CARRYCASCIN => '0',
      MULTSIGNIN => '0',
      PCIN => pi1_pcout,
      ALUMODE => pi2a_alumode, -- 4-bit ALU control input
      B => t1_bi2,    -- 18-bit B data input
      C => x"000000000000",   -- 48-bit C data input
      CARRYIN => '0', -- 1-bit carry input signal
      CARRYINSEL => "000", -- 3-bit carry select input
      CEA1 => '1',      -- 1-bit active high clock enable input for 1st stage A registers
      CEA2 => '1',      -- 1-bit active high clock enable input for 2nd stage A registers
      CEALUMODE => '0', -- 1-bit active high clock enable input for ALUMODE registers
      CEB1 => '1',      -- 1-bit active high clock enable input for 1st stage B registers
      CEB2 => '1',      -- 1-bit active high clock enable input for 2nd stage B registers
      CEC => '0',      -- 1-bit active high clock enable input for C registers
      CECARRYIN => '0', -- 1-bit active high clock enable input for CARRYIN register
      CECTRL => '0', -- 1-bit active high clock enable input for OPMODE and carry registers
      CEM => '1',       -- 1-bit active high clock enable input for multiplier registers
      CEMULTCARRYIN => '0', -- 1-bit active high clock enable for multiplier carry in register
      CEP => '1',       -- 1-bit active high clock enable input for P registers
      CLK => CLK,       -- Clock input
      OPMODE => "0010101", -- 7-bit operation mode input
      RSTA => '0',     -- 1-bit reset input for A pipeline registers
      RSTALLCARRYIN => '0', -- 1-bit reset input for carry pipeline registers
      RSTALUMODE => '0', -- 1-bit reset input for ALUMODE pipeline registers
      RSTB => '0',     -- 1-bit reset input for B pipeline registers
      RSTC => '0',     -- 1-bit reset input for C pipeline registers
      RSTCTRL => '0', -- 1-bit reset input for OPMODE pipeline registers
      RSTM => '0', -- 1-bit reset input for multiplier registers
      RSTP => '0'  -- 1-bit reset input for P pipeline registers
);

-- End of DSP48E_inst instantiation

   -- DSP48E: DSP Function Block
   --         Virtex-5
   -- Xilinx HDL Language Template, version 9.1.3i
   
   DSP48E_pi2b_inst : DSP48E
   generic map (
      ACASCREG => 2,       -- Number of pipeline registers between 
                           -- A/ACIN input and ACOUT output, 0, 1, or 2
      ALUMODEREG => 0,     -- Number of pipeline registers on ALUMODE input, 0 or 1
      AREG => 2,           -- Number of pipeline registers on the A input, 0, 1 or 2
      AUTORESET_PATTERN_DETECT => FALSE, -- Auto-reset upon pattern detect, TRUE or FALSE
      AUTORESET_PATTERN_DETECT_OPTINV => "MATCH", -- Reset if "MATCH" or "NOMATCH" 
      A_INPUT => "DIRECT", -- Selects A input used, "DIRECT" (A port) or "CASCADE" (ACIN port)
      BCASCREG => 2,       -- Number of pipeline registers between B/BCIN input and BCOUT output, 0, 1, or 2
      BREG => 2,           -- Number of pipeline registers on the B input, 0, 1 or 2
      B_INPUT => "DIRECT", -- Selects B input used, "DIRECT" (B port) or "CASCADE" (BCIN port)
      CARRYINREG => 0,     -- Number of pipeline registers for the CARRYIN input, 0 or 1
      CARRYINSELREG => 0,  -- Number of pipeline registers for the CARRYINSEL input, 0 or 1
      CREG => 0,           -- Number of pipeline registers on the C input, 0 or 1
      MASK => mask, --X"FFFFFFFC0000", -- 48-bit Mask value for pattern detect
      MREG => 1,           -- Number of multiplier pipeline registers, 0 or 1
      MULTCARRYINREG => 0, -- Number of pipeline registers for multiplier carry in bit, 0 or 1
      OPMODEREG => 0,      -- Number of pipeline registers on OPMODE input, 0 or 1
      PATTERN => pattern, --X"000000020000", -- 48-bit Pattern match for pattern detect
      PREG => 1,           -- Number of pipeline registers on the P output, 0 or 1
      SEL_MASK => "MASK",  -- Select mask value between the "MASK" value or the value on the "C" port
      SEL_PATTERN => "PATTERN", -- Select pattern value between the "PATTERN" value or the value on the "C" port
      SEL_ROUNDING_MASK => "SEL_MASK", -- "SEL_MASK", "MODE1", "MODE2" 
      USE_MULT => "MULT_S", -- Select multiplier usage, "MULT" (MREG => 0), 
                            -- "MULT_S" (MREG => 1), "NONE" (not using multiplier)
      USE_PATTERN_DETECT => "PATDET", -- Enable pattern detect, "PATDET", "NO_PATDET" 
      USE_SIMD => "ONE48") -- SIMD selection, "ONE48", "TWO24", "FOUR12" 
   port map (
      P => pi2_prod,          -- 48-bit output
      PATTERNDETECT => pi2_pd, --  1-bit active high pattern detect output
      PCOUT => open,  -- 48-bit cascade output
      A => t2_ai2_sxt,  -- 30-bit A data input
      ACIN => zeros,
      BCIN => zeros(17 downto 0),
      CARRYCASCIN => '0',
      MULTSIGNIN => '0',
      ALUMODE => pi2b_alumode, -- 4-bit ALU control input
      B => t2_br2,    -- 18-bit B data input
      C => x"000000000000",   -- 48-bit C data input
      CARRYIN => '0', -- 1-bit carry input signal
      CARRYINSEL => "000", -- 3-bit carry select input
      CEA1 => '1',      -- 1-bit active high clock enable input for 1st stage A registers
      CEA2 => '1',      -- 1-bit active high clock enable input for 2nd stage A registers
      CEALUMODE => '0', -- 1-bit active high clock enable input for ALUMODE registers
      CEB1 => '1',      -- 1-bit active high clock enable input for 1st stage B registers
      CEB2 => '1',      -- 1-bit active high clock enable input for 2nd stage B registers
      CEC => '0',      -- 1-bit active high clock enable input for C registers
      CECARRYIN => '0', -- 1-bit active high clock enable input for CARRYIN register
      CECTRL => '0', -- 1-bit active high clock enable input for OPMODE and carry registers
      CEM => '1',       -- 1-bit active high clock enable input for multiplier registers
      CEMULTCARRYIN => '0', -- 1-bit active high clock enable for multiplier carry in register
      CEP => '1',       -- 1-bit active high clock enable input for P registers
      CLK => CLK,       -- Clock input
      PCIN => pi2_pprod,  -- 48-bit P cascade input 
      OPMODE => "0010101", -- 7-bit operation mode input
      RSTA => '0',     -- 1-bit reset input for A pipeline registers
      RSTALLCARRYIN => '0', -- 1-bit reset input for carry pipeline registers
      RSTALUMODE => '0', -- 1-bit reset input for ALUMODE pipeline registers
      RSTB => '0',     -- 1-bit reset input for B pipeline registers
      RSTC => '0',     -- 1-bit reset input for C pipeline registers
      RSTCTRL => '0', -- 1-bit reset input for OPMODE pipeline registers
      RSTM => '0', -- 1-bit reset input for multiplier registers
      RSTP => '0'  -- 1-bit reset input for P pipeline registers
);

-- End of DSP48E_inst instantiation
no_div2_gen_i: if div2 /= '1' generate

-- Complete round operation 
process(CLK)
begin
   if rising_edge(CLK) then
      PI_OUT(23 downto 1)  <= pi2_prod(40 downto 18);
      PI_OUT(0)            <= not((not pi2_prod(17)) or pi2_pd);   
  end if;
end process;

end generate;

div2_gen_i: if div2 = '1' generate

-- Complete round operation 
process(CLK)
begin
   if rising_edge(CLK) then
      PI_OUT(23 downto 1)  <= pi2_prod(41 downto 19);
      PI_OUT(0)            <= not((not pi2_prod(18)) or pi2_pd);      
  end if;
end process;

end generate;

end Behavioral;

