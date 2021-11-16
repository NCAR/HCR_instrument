----------------------------------------------------------------------------------
-- Company:  Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 04/16/2018 12:15:19 PM
-- Design Name: 
-- Module Name: px_pdti_dec16fir_8_st1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 15-tap Beta 9.5, Half Band
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: latency = 9 tvalid cycles
--
-- Coefficients
-- -7.   0.   1160.   0.  -11719.   0.   76099.   131072.   76099.   0.  -11719.   0.   1160.   0.  -7. 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.conv_std_logic_vector;
use IEEE.STD_LOGIC_SIGNED.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_pdti_dec16fir_8_st1 is
generic(
    num_fraction_bits: integer := 18
);
port (
clk       : in std_logic;
ce        : in std_logic;
d_tm7     : in std_logic_vector(15 downto 0);
d_tm6     : in std_logic_vector(15 downto 0);
d_tm5     : in std_logic_vector(15 downto 0);
d_tm4     : in std_logic_vector(15 downto 0);
d_tm3     : in std_logic_vector(15 downto 0);
d_tm2     : in std_logic_vector(15 downto 0);
d_tm1     : in std_logic_vector(15 downto 0);
d_t       : in std_logic_vector(15 downto 0);
dout_tm3  : out std_logic_vector(15 downto 0);
dout_tm2  : out std_logic_vector(15 downto 0);
dout_tm1  : out std_logic_vector(15 downto 0);
dout_t    : out std_logic_vector(15 downto 0) 
);
end px_pdti_dec16fir_8_st1;

architecture Behavioral of px_pdti_dec16fir_8_st1 is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

component px_pdti_dec16fir_8_dsp
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
end component;

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

constant zeros: std_logic_vector(47 downto 0) := (others => '0');
constant in_data_width: integer:= num_fraction_bits+16;
constant out_data_width: integer:= 16;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal t1_d_t: std_logic_vector(15 downto 0) := (others => '0');
signal t2_d_t: std_logic_vector(15 downto 0) := (others => '0');
signal t3_d_t: std_logic_vector(15 downto 0) := (others => '0');
signal t1_d_tm1: std_logic_vector(15 downto 0) := (others => '0');
signal t2_d_tm1: std_logic_vector(15 downto 0) := (others => '0');
signal t3_d_tm1: std_logic_vector(15 downto 0) := (others => '0');
signal t1_d_tm2: std_logic_vector(15 downto 0) := (others => '0');
signal t2_d_tm2: std_logic_vector(15 downto 0) := (others => '0');
signal t3_d_tm2: std_logic_vector(15 downto 0) := (others => '0');
signal t1_d_tm3: std_logic_vector(15 downto 0) := (others => '0');
signal t2_d_tm3: std_logic_vector(15 downto 0) := (others => '0');
signal t3_d_tm3: std_logic_vector(15 downto 0) := (others => '0');
signal t1_d_tm4: std_logic_vector(15 downto 0) := (others => '0');
signal t2_d_tm4: std_logic_vector(15 downto 0) := (others => '0');
signal t3_d_tm4: std_logic_vector(15 downto 0) := (others => '0');
signal t1_d_tm5: std_logic_vector(15 downto 0) := (others => '0');
signal t2_d_tm5: std_logic_vector(15 downto 0) := (others => '0');
signal t3_d_tm5: std_logic_vector(15 downto 0) := (others => '0');
signal t1_d_tm6: std_logic_vector(15 downto 0) := (others => '0');
signal t2_d_tm6: std_logic_vector(15 downto 0) := (others => '0');
signal t3_d_tm6: std_logic_vector(15 downto 0) := (others => '0');
signal t1_d_tm7: std_logic_vector(15 downto 0) := (others => '0');
signal t2_d_tm7: std_logic_vector(15 downto 0) := (others => '0');

signal dspa1_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspa2_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspa3_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspa4_p_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspa1_incasc_out: std_logic_vector(29 downto 0) := (others => '0');
signal dspa3_incasc_out: std_logic_vector(29 downto 0) := (others => '0');

signal dspb1_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspb2_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspb3_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspb4_p_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspb1_incasc_out: std_logic_vector(29 downto 0) := (others => '0');
signal dspb3_incasc_out: std_logic_vector(29 downto 0) := (others => '0');

signal dspc1_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspc2_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspc3_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspc4_p_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspc1_incasc_out: std_logic_vector(29 downto 0) := (others => '0');
signal dspc3_incasc_out: std_logic_vector(29 downto 0) := (others => '0');

signal dspd1_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspd2_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspd3_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspd4_p_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspd1_incasc_out: std_logic_vector(29 downto 0) := (others => '0');
signal dspd3_incasc_out: std_logic_vector(29 downto 0) := (others => '0');

signal round_wrd_sym: std_logic_vector(in_data_width downto 0) := (others => '0');
signal carry_a4: std_logic := '0';
signal carry_b4: std_logic := '0';
signal carry_c4: std_logic := '0';
signal carry_d4: std_logic := '0';

signal sum_sym_a : std_logic_vector(in_data_width downto 0);
signal sum_sym_b : std_logic_vector(in_data_width downto 0);
signal sum_sym_c : std_logic_vector(in_data_width downto 0);
signal sum_sym_d : std_logic_vector(in_data_width downto 0);

signal t2_d_tm7_sl: std_logic_vector(47 downto 0) := (others => '0');
signal t3_d_tm1_sl: std_logic_vector(47 downto 0) := (others => '0');
signal t3_d_tm3_sl: std_logic_vector(47 downto 0) := (others => '0');
signal t3_d_tm5_sl: std_logic_vector(47 downto 0) := (others => '0');

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

attribute shreg_extract : string;
attribute shreg_extract of t3_d_tm1: signal is "true";
attribute shreg_extract of t3_d_tm3: signal is "true";
attribute shreg_extract of t3_d_tm5: signal is "true";
attribute shreg_extract of t2_d_tm7: signal is "true";
attribute shreg_extract of t3_d_tm2: signal is "true";
attribute shreg_extract of t3_d_tm6: signal is "true";

begin

round_wrd_sym(in_data_width downto (in_data_width- out_data_width - 1)) <= (others => '0');
round_wrd_sym((in_data_width - out_data_width -2) downto 0) <= (others => '1');
carry_a4 <= not dspa4_p_out(in_data_width - 1);
carry_b4 <= not dspb4_p_out(in_data_width - 1);
carry_c4 <= not dspc4_p_out(in_data_width - 1);
carry_d4 <= not dspd4_p_out(in_data_width - 1);

process(clk)
begin
    if rising_edge(clk) then
        if ce = '1' then
           t1_d_t    <= d_t;
           t2_d_t    <= t1_d_t;
           t3_d_t    <= t2_d_t;
           t1_d_tm1  <= d_tm1;
           t2_d_tm1  <= t1_d_tm1;
           t3_d_tm1  <= t2_d_tm1;
           t1_d_tm2  <= d_tm2;
           t2_d_tm2  <= t1_d_tm2;
           t3_d_tm2  <= t2_d_tm2;
           t1_d_tm3  <= d_tm3;
           t2_d_tm3  <= t1_d_tm3;
           t3_d_tm3  <= t2_d_tm3;
           t1_d_tm4  <= d_tm4;
           t2_d_tm4  <= t1_d_tm4;
           t3_d_tm4  <= t2_d_tm4;
           t1_d_tm5  <= d_tm5;
           t2_d_tm5  <= t1_d_tm5;
           t3_d_tm5  <= t2_d_tm5;
           t1_d_tm6  <= d_tm6;
           t2_d_tm6  <= t1_d_tm6;
           t3_d_tm6  <= t2_d_tm6;
           t1_d_tm7  <= d_tm7;
           t2_d_tm7  <= t1_d_tm7;
           sum_sym_a <= (dspa4_p_out(in_data_width-1) & dspa4_p_out(in_data_width-1 downto 0)) + round_wrd_sym + carry_a4;
           if sum_sym_a(in_data_width) = sum_sym_a(in_data_width-1) then
              dout_t <= sum_sym_a(in_data_width-1 downto (in_data_width- out_data_width));
           else   -- saturate
              dout_t(out_data_width-1) <= sum_sym_a(in_data_width);
              if sum_sym_a(in_data_width) = '0' then
                 dout_t(out_data_width-2 downto 0) <= (others => '1');
              else
                 dout_t(out_data_width-2 downto 0) <= (others => '0');
              end if;
           end if;
           sum_sym_b <= (dspb4_p_out(in_data_width-1) & dspb4_p_out(in_data_width-1 downto 0)) + round_wrd_sym + carry_b4;
           if sum_sym_b(in_data_width) = sum_sym_b(in_data_width-1) then
              dout_tm1 <= sum_sym_b(in_data_width-1 downto (in_data_width- out_data_width));
           else   -- saturate
              dout_tm1(out_data_width-1) <= sum_sym_b(in_data_width);
              if sum_sym_b(in_data_width) = '0' then
                 dout_tm1(out_data_width-2 downto 0) <= (others => '1');
              else
                 dout_tm1(out_data_width-2 downto 0) <= (others => '0');
              end if;
           end if;
           sum_sym_c <= (dspc4_p_out(in_data_width-1) & dspc4_p_out(in_data_width-1 downto 0)) + round_wrd_sym + carry_c4;
           if sum_sym_c(in_data_width) = sum_sym_c(in_data_width-1) then
              dout_tm2 <= sum_sym_c(in_data_width-1 downto (in_data_width- out_data_width));
           else   -- saturate
              dout_tm2(out_data_width-1) <= sum_sym_c(in_data_width);
              if sum_sym_c(in_data_width) = '0' then
                 dout_tm2(out_data_width-2 downto 0) <= (others => '1');
              else
                 dout_tm2(out_data_width-2 downto 0) <= (others => '0');
              end if;
           end if;
           sum_sym_d <= (dspd4_p_out(in_data_width-1) & dspd4_p_out(in_data_width-1 downto 0)) + round_wrd_sym + carry_d4;
           if sum_sym_d(in_data_width) = sum_sym_d(in_data_width-1) then
              dout_tm3 <= sum_sym_d(in_data_width-1 downto (in_data_width- out_data_width));
           else   -- saturate
              dout_tm3(out_data_width-1) <= sum_sym_d(in_data_width);
              if sum_sym_d(in_data_width) = '0' then
                 dout_tm3(out_data_width-2 downto 0) <= (others => '1');
              else
                 dout_tm3(out_data_width-2 downto 0) <= (others => '0');
              end if;
           end if;
        end if;
    end if;
end process;   
 
-- Coefficients
-- -7.   0.   1160.   0.  -11719.   0.   76099.   131072.   76099.   0.  -11719.   0.   1160.   0.  -7.


---------------------------------------------------------------------------------------------------------------------
-- t Phase
---------------------------------------------------------------------------------------------------------------------

t2_d_tm7_sl <= std_logic_vector(resize(signed(t2_d_tm7), 31)) & "00000000000000000"; -- Coefficient = 131072 shift left

dspa1: px_pdti_dec16fir_8_dsp
generic map(
    in1_regs=> 1,
    use_in1_casc_in=> false,
    in1_casc_out_regs=> 1,
    num_fraction_bits=> num_fraction_bits,
    use_det=> false,
    use_pcin=> false
)
port map(
clk         => clk,
ce          => ce,
in1         => d_tm4,
in1_casc_in => zeros(29 downto 0),
in2         => t1_d_tm2,
in1_casc_out=> dspa1_incasc_out,
c_in        => t2_d_tm7_sl, 
pc_in       => zeros,
pc_out      => dspa1_pc_out,
coef        => conv_std_logic_vector(-11719,18),
pout        => open,
detout      => open
);

dspa2: px_pdti_dec16fir_8_dsp
generic map(
    in1_regs=> 2,
    use_in1_casc_in=> true,
    in1_casc_out_regs=> 2,
    num_fraction_bits=> num_fraction_bits,
    use_det=> false,
    use_pcin=> true
)
port map(
clk         => clk,
ce          => ce,
in1         => zeros(15 downto 0),
in1_casc_in => dspa1_incasc_out,
in2         => t1_d_tm2,
in1_casc_out=> open,
c_in        => zeros, 
pc_in       => dspa1_pc_out,
pc_out      => dspa2_pc_out,
coef        => conv_std_logic_vector(1160,18),
pout        => open,
detout      => open
);

dspa3: px_pdti_dec16fir_8_dsp
generic map(
    in1_regs=> 2,
    use_in1_casc_in=> false,
    in1_casc_out_regs=> 2,
    num_fraction_bits=> num_fraction_bits,
    use_det=> false,
    use_pcin=> true
)
port map(
clk         => clk,
ce          => ce,
in1         => t1_d_tm6,
in1_casc_in => zeros(29 downto 0),
in2         => t3_d_t,
in1_casc_out=> dspa3_incasc_out,
c_in        => zeros, 
pc_in       => dspa2_pc_out,
pc_out      => dspa3_pc_out,
coef        => conv_std_logic_vector(76099,18),
pout        => open,
detout      => open
);

dspa4: px_pdti_dec16fir_8_dsp
generic map(
    in1_regs=> 2,
    use_in1_casc_in=> true,
    in1_casc_out_regs=> 2,
    num_fraction_bits=> num_fraction_bits,
    use_det=> false,
    use_pcin=> true
)
port map(
clk         => clk,
ce          => ce,
in1         => zeros(15 downto 0),
in1_casc_in => dspa3_incasc_out,
in2         => t3_d_t,
in1_casc_out=> open,
c_in        => zeros,
pc_in       => dspa3_pc_out,
pc_out      => open,
coef        => conv_std_logic_vector(7,18),
pout        => dspa4_p_out,
detout      => open
);

---------------------------------------------------------------------------------------------------------------------
-- t-1 Phase
---------------------------------------------------------------------------------------------------------------------
t3_d_tm1_sl <= std_logic_vector(resize(signed(t3_d_tm1), 31)) & "00000000000000000"; -- Coefficient = 131072 shift left

dspb1: px_pdti_dec16fir_8_dsp
generic map(
    in1_regs=> 1,
    use_in1_casc_in=> false,
    in1_casc_out_regs=> 1,
    num_fraction_bits=> num_fraction_bits,
    use_det=> false,
    use_pcin=> false
)
port map(
clk         => clk,
ce          => ce,
in1         => d_tm6,
in1_casc_in => zeros(29 downto 0),
in2         => t1_d_tm4,
in1_casc_out=> dspb1_incasc_out,
c_in        => t3_d_tm1_sl, 
pc_in       => zeros,
pc_out      => dspb1_pc_out,
coef        => conv_std_logic_vector(-11719,18),
pout        => open,
detout      => open
);

dspb2: px_pdti_dec16fir_8_dsp
generic map(
    in1_regs=> 2,
    use_in1_casc_in=> true,
    in1_casc_out_regs=> 2,
    num_fraction_bits=> num_fraction_bits,
    use_det=> false,
    use_pcin=> true
)
port map(
clk         => clk,
ce          => ce,
in1         => zeros(15 downto 0),
in1_casc_in => dspb1_incasc_out,
in2         => t1_d_tm4,
in1_casc_out=> open,
c_in        => zeros, 
pc_in       => dspb1_pc_out,
pc_out      => dspb2_pc_out,
coef        => conv_std_logic_vector(1160,18),
pout        => open,
detout      => open
);

dspb3: px_pdti_dec16fir_8_dsp
generic map(
    in1_regs=> 2,
    use_in1_casc_in=> false,
    in1_casc_out_regs=> 2,
    num_fraction_bits=> num_fraction_bits,
    use_det=> false,
    use_pcin=> true
)
port map(
clk         => clk,
ce          => ce,
in1         => t2_d_t, --// t3_d_t
in1_casc_in => zeros(29 downto 0),
in2         => t3_d_tm2,
in1_casc_out=> dspb3_incasc_out,
c_in        => zeros, 
pc_in       => dspb2_pc_out,
pc_out      => dspb3_pc_out,
coef        => conv_std_logic_vector(76099,18),
pout        => open,
detout      => open
);

dspb4: px_pdti_dec16fir_8_dsp
generic map(
    in1_regs=> 2,
    use_in1_casc_in=> true,
    in1_casc_out_regs=> 2,
    num_fraction_bits=> num_fraction_bits,
    use_det=> false,
    use_pcin=> true
)
port map(
clk         => clk,
ce          => ce,
in1         => zeros(15 downto 0),
in1_casc_in => dspb3_incasc_out,
in2         => t3_d_tm2,
in1_casc_out=> open,
c_in        => zeros,
pc_in       => dspb3_pc_out,
pc_out      => open,
coef        => conv_std_logic_vector(7,18),
pout        => dspb4_p_out,
detout      => open
);

---------------------------------------------------------------------------------------------------------------------
-- t-2 Phase
---------------------------------------------------------------------------------------------------------------------

t3_d_tm3_sl <= std_logic_vector(resize(signed(t3_d_tm3), 31)) & "00000000000000000"; -- Coefficient = 131072 shift left

dspc1: px_pdti_dec16fir_8_dsp
generic map(
    in1_regs=> 2,
    use_in1_casc_in=> false,
    in1_casc_out_regs=> 2,
    num_fraction_bits=> num_fraction_bits,
    use_det=> false,
    use_pcin=> false
)
port map(
clk         => clk,
ce          => ce,
in1         => d_t,
in1_casc_in => zeros(29 downto 0),
in2         => t1_d_tm6,
in1_casc_out=> dspc1_incasc_out,
c_in        => t3_d_tm3_sl, 
pc_in       => zeros,
pc_out      => dspc1_pc_out,
coef        => conv_std_logic_vector(-11719,18),
pout        => open,
detout      => open
);

dspc2: px_pdti_dec16fir_8_dsp
generic map(
    in1_regs=> 2,
    use_in1_casc_in=> true,
    in1_casc_out_regs=> 2,
    num_fraction_bits=> num_fraction_bits,
    use_det=> false,
    use_pcin=> true
)
port map(
clk         => clk,
ce          => ce,
in1         => zeros(15 downto 0),
in1_casc_in => dspc1_incasc_out,
in2         => t1_d_tm6,
in1_casc_out=> open,
c_in        => zeros, 
pc_in       => dspc1_pc_out,
pc_out      => dspc2_pc_out,
coef        => conv_std_logic_vector(1160,18),
pout        => open,
detout      => open
);

dspc3: px_pdti_dec16fir_8_dsp
generic map(
    in1_regs=> 2,
    use_in1_casc_in=> false,
    in1_casc_out_regs=> 2,
    num_fraction_bits=> num_fraction_bits,
    use_det=> false,
    use_pcin=> true
)
port map(
clk         => clk,
ce          => ce,
in1         => t2_d_tm2,--t1_d_tm2,
in1_casc_in => zeros(29 downto 0),
in2         => t3_d_tm4,
in1_casc_out=> dspc3_incasc_out,
c_in        => zeros, 
pc_in       => dspc2_pc_out,
pc_out      => dspc3_pc_out,
coef        => conv_std_logic_vector(76099,18),
pout        => open,
detout      => open
);

dspc4: px_pdti_dec16fir_8_dsp
generic map(
    in1_regs=> 2,
    use_in1_casc_in=> true,
    in1_casc_out_regs=> 2,
    num_fraction_bits=> num_fraction_bits,
    use_det=> false,
    use_pcin=> true
)
port map(
clk         => clk,
ce          => ce,
in1         => zeros(15 downto 0),
in1_casc_in => dspc3_incasc_out,
in2         => t3_d_tm4,
in1_casc_out=> open,
c_in        => zeros,
pc_in       => dspc3_pc_out,
pc_out      => open,
coef        => conv_std_logic_vector(7,18),
pout        => dspc4_p_out,
detout      => open
);

---------------------------------------------------------------------------------------------------------------------
-- t-3 Phase
---------------------------------------------------------------------------------------------------------------------
t3_d_tm5_sl <= std_logic_vector(resize(signed(t3_d_tm5), 31)) & "00000000000000000"; -- Coefficient = 131072 shift left

dspd1: px_pdti_dec16fir_8_dsp
generic map(
    in1_regs=> 2,
    use_in1_casc_in=> false,
    in1_casc_out_regs=> 2,
    num_fraction_bits=> num_fraction_bits,
    use_det=> false,
    use_pcin=> false
)
port map(
clk         => clk,
ce          => ce,
in1         => d_tm2,
in1_casc_in => zeros(29 downto 0),
in2         => t2_d_t,
in1_casc_out=> dspd1_incasc_out,
c_in        => t3_d_tm5_sl, 
pc_in       => zeros,
pc_out      => dspd1_pc_out,
coef        => conv_std_logic_vector(-11719,18),
pout        => open,
detout      => open
);

dspd2: px_pdti_dec16fir_8_dsp
generic map(
    in1_regs=> 2,
    use_in1_casc_in=> true,
    in1_casc_out_regs=> 2,
    num_fraction_bits=> num_fraction_bits,
    use_det=> false,
    use_pcin=> true
)
port map(
clk         => clk,
ce          => ce,
in1         => zeros(15 downto 0),
in1_casc_in => dspd1_incasc_out,
in2         => t2_d_t,
in1_casc_out=> open,
c_in        => zeros, 
pc_in       => dspd1_pc_out,
pc_out      => dspd2_pc_out,
coef        => conv_std_logic_vector(1160,18),
pout        => open,
detout      => open
);

dspd3: px_pdti_dec16fir_8_dsp
generic map(
    in1_regs=> 2,
    use_in1_casc_in=> false,
    in1_casc_out_regs=> 2,
    num_fraction_bits=> num_fraction_bits,
    use_det=> false,
    use_pcin=> true
)
port map(
clk         => clk,
ce          => ce,
in1         => t2_d_tm4,
in1_casc_in => zeros(29 downto 0),
in2         => t3_d_tm6,
in1_casc_out=> dspd3_incasc_out,
c_in        => zeros, 
pc_in       => dspd2_pc_out,
pc_out      => dspd3_pc_out,
coef        => conv_std_logic_vector(76099,18),
pout        => open,
detout      => open
);

dspd4: px_pdti_dec16fir_8_dsp
generic map(
    in1_regs=> 2,
    use_in1_casc_in=> true,
    in1_casc_out_regs=> 2,
    num_fraction_bits=> num_fraction_bits,
    use_det=> false,
    use_pcin=> true
)
port map(
clk         => clk,
ce          => ce,
in1         => zeros(15 downto 0),
in1_casc_in => dspd3_incasc_out,
in2         => t3_d_tm6,
in1_casc_out=> open,
c_in        => zeros,
pc_in       => dspd3_pc_out,
pc_out      => open,
coef        => conv_std_logic_vector(7,18),
pout        => dspd4_p_out,
detout      => open
);

end Behavioral;
