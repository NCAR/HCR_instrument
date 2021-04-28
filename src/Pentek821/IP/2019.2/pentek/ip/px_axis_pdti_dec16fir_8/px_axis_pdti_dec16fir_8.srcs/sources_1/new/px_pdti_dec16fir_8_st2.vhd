----------------------------------------------------------------------------------
-- Company:  Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 04/16/2018 12:15:19 PM
-- Design Name: 
-- Module Name: px_pdti_dec16fir_8_st3 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 19-tap Beta 9.9, Half Band
-- 
-- Dependencies: latency = 11 tvalid cycles
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Coefficients
-- 4.   0.  -384.   0.   3461.   0.  -16276.   0.   78733.   131072.   78733.   0.  -16276.   0.   3461.   0.  -384.   0.   4. 
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

entity px_pdti_dec16fir_8_st2 is
generic(
    num_fraction_bits: integer := 18
);
port (
clk       : in std_logic;
ce        : in std_logic;
d_tm3     : in std_logic_vector(15 downto 0);
d_tm2     : in std_logic_vector(15 downto 0);
d_tm1     : in std_logic_vector(15 downto 0);
d_t       : in std_logic_vector(15 downto 0);
dout_tm1  : out std_logic_vector(15 downto 0);
dout_t    : out std_logic_vector(15 downto 0) 
);
end px_pdti_dec16fir_8_st2;

architecture Behavioral of px_pdti_dec16fir_8_st2 is

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
signal t3_d_tm3_sl: std_logic_vector(47 downto 0) := (others => '0');
signal dspa1_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspa2_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspa3_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspa4_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspa5_p_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspa1_incasc_out: std_logic_vector(29 downto 0) := (others => '0');
signal dspa3_incasc_out: std_logic_vector(29 downto 0) := (others => '0');
signal dspa4_incasc_out: std_logic_vector(29 downto 0) := (others => '0');
signal t3_d_tm1_sl: std_logic_vector(47 downto 0) := (others => '0');
signal dspb1_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspb2_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspb3_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspb4_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspb5_p_out: std_logic_vector(47 downto 0) := (others => '0');
signal dspb1_incasc_out: std_logic_vector(29 downto 0) := (others => '0');
signal dspb3_incasc_out: std_logic_vector(29 downto 0) := (others => '0');
signal dspb4_incasc_out: std_logic_vector(29 downto 0) := (others => '0');
signal round_wrd_sym: std_logic_vector(in_data_width downto 0) := (others => '0');
signal carry_a5: std_logic := '0';
signal carry_b5: std_logic := '0';
signal sum_sym_a : std_logic_vector(in_data_width downto 0);
signal sum_sym_b : std_logic_vector(in_data_width downto 0);

attribute shreg_extract : string;
attribute shreg_extract of t3_d_tm1: signal is "true";
attribute shreg_extract of t3_d_tm3: signal is "true";
attribute shreg_extract of t3_d_t: signal is "true";
attribute shreg_extract of t3_d_tm2: signal is "true";

begin

round_wrd_sym(in_data_width downto (in_data_width- out_data_width - 1)) <= (others => '0');
round_wrd_sym((in_data_width - out_data_width -2) downto 0) <= (others => '1');
carry_a5 <= not dspa5_p_out(in_data_width - 1);
carry_b5 <= not dspb5_p_out(in_data_width - 1);

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
           sum_sym_a <= (dspa5_p_out(in_data_width-1) & dspa5_p_out(in_data_width-1 downto 0)) + round_wrd_sym + carry_a5;
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
           sum_sym_b <= (dspb5_p_out(in_data_width-1) & dspb5_p_out(in_data_width-1 downto 0)) + round_wrd_sym + carry_b5;
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
        end if;
    end if;
end process;   
 
-- Coefficients
-- 4.   0.  -384.   0.   3461.   0.  -16276.   0.   78733.   131072.   78733.   0.  -16276.   0.   3461.   0.  -384.   0.   4.

---------------------------------------------------------------------------------------------------------------------
-- t Phase
---------------------------------------------------------------------------------------------------------------------

t3_d_tm1_sl <= std_logic_vector(resize(signed(t3_d_tm1), 31)) & "00000000000000000"; -- Coefficient = 131072 shift left

dspa1: px_pdti_dec16fir_8_dsp
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
in1         => t1_d_t,
in1_casc_in => zeros(29 downto 0),
in2         => d_tm2,
in1_casc_out=> dspa1_incasc_out,
c_in        => t3_d_tm1_sl, 
pc_in       => zeros,
pc_out      => dspa1_pc_out,
coef        => conv_std_logic_vector(-16276,18),
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
in2         => d_tm2,
in1_casc_out=> open,
c_in        => zeros, 
pc_in       => dspa1_pc_out,
pc_out      => dspa2_pc_out,
coef        => conv_std_logic_vector(-384,18),
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
in1         => t2_d_tm2,
in1_casc_in => zeros(29 downto 0),
in2         => t3_d_t,
in1_casc_out=> dspa3_incasc_out,
c_in        => zeros, 
pc_in       => dspa2_pc_out,
pc_out      => dspa3_pc_out,
coef        => conv_std_logic_vector(78733,18),
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
in1_casc_out=> dspa4_incasc_out,
c_in        => zeros,
pc_in       => dspa3_pc_out,
pc_out      => dspa4_pc_out,
coef        => conv_std_logic_vector(3461,18),
pout        => open,
detout      => open
);

dspa5: px_pdti_dec16fir_8_dsp
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
in1_casc_in => dspa4_incasc_out,
in2         => t3_d_t,
in1_casc_out=> open,
c_in        => zeros, 
pc_in       => dspa4_pc_out,
pc_out      => open,
coef        => conv_std_logic_vector(4,18),
pout        => dspa5_p_out,
detout      => open
);

---------------------------------------------------------------------------------------------------------------------
-- t-1 Phase
---------------------------------------------------------------------------------------------------------------------
t3_d_tm3_sl <= std_logic_vector(resize(signed(t3_d_tm3), 31)) & "00000000000000000"; -- Coefficient = 131072 shift left

dspb1: px_pdti_dec16fir_8_dsp
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
in1         => t1_d_tm2,
in1_casc_in => zeros(29 downto 0),
in2         => t1_d_t,
in1_casc_out=> dspb1_incasc_out,
c_in        => t3_d_tm3_sl, 
pc_in       => zeros,
pc_out      => dspb1_pc_out,
coef        => conv_std_logic_vector(-16276,18),
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
in2         => t1_d_t,
in1_casc_out=> open,
c_in        => zeros, 
pc_in       => dspb1_pc_out,
pc_out      => dspb2_pc_out,
coef        => conv_std_logic_vector(-384,18),
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
in1         => t3_d_t,
in1_casc_in => zeros(29 downto 0),
in2         => t3_d_tm2,
in1_casc_out=> dspb3_incasc_out,
c_in        => zeros, 
pc_in       => dspb2_pc_out,
pc_out      => dspb3_pc_out,
coef        => conv_std_logic_vector(78733,18),
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
in1_casc_out=> dspb4_incasc_out,
c_in        => zeros,
pc_in       => dspb3_pc_out,
pc_out      => dspb4_pc_out,
coef        => conv_std_logic_vector(3461,18),
pout        => open,
detout      => open
);

dspb5: px_pdti_dec16fir_8_dsp
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
in1_casc_in => dspb4_incasc_out,
in2         => t3_d_tm2,
in1_casc_out=> open,
c_in        => zeros, 
pc_in       => dspb4_pc_out,
pc_out      => open,
coef        => conv_std_logic_vector(4,18),
pout        => dspb5_p_out,
detout      => open
);

end Behavioral;
