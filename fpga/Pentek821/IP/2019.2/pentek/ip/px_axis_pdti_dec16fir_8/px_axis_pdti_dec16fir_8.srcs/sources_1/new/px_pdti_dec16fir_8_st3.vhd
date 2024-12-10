----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 04/16/2018 12:15:19 PM
-- Design Name: 
-- Module Name: px_pdti_dec16fir_8_st3 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Latency = 13 tvalid cycles 
-- Coefficients:
-- 0.   20.   0.  -215.   0.   1025.   0.  -3362.   0.   8938.   0.  -22317.   0.
-- 81446.   131072.   81446.   0.  -22317.   0.   8938.   0.  -3362.   0.   1025.
-- 0.  -215.   0.   20.   0.

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

entity px_pdti_dec16fir_8_st3 is
generic(
    num_fraction_bits: integer := 18
);
port (
clk    : in std_logic;
ce     : in std_logic;
d_t    : in std_logic_vector(15 downto 0);
d_tm1  : in std_logic_vector(15 downto 0);
dout_t : out std_logic_vector(15 downto 0) 
);
end px_pdti_dec16fir_8_st3;

architecture Behavioral of px_pdti_dec16fir_8_st3 is

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

signal dsp1_incasc_out: std_logic_vector(29 downto 0) := (others => '0');
signal t1_d_t: std_logic_vector(15 downto 0) := (others => '0');
signal t2_d_t: std_logic_vector(15 downto 0) := (others => '0');
signal t3_d_t: std_logic_vector(15 downto 0) := (others => '0');
signal dsp1_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal t3_d_t_sl: std_logic_vector(47 downto 0) := (others => '0');
signal dsp2_incasc_out: std_logic_vector(29 downto 0) := (others => '0');
signal dsp2_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dsp3_incasc_out: std_logic_vector(29 downto 0) := (others => '0');
signal dsp3_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dsp4_incasc_out: std_logic_vector(29 downto 0) := (others => '0');
signal dsp4_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dsp5_incasc_out: std_logic_vector(29 downto 0) := (others => '0');
signal dsp5_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dsp6_incasc_out: std_logic_vector(29 downto 0) := (others => '0');
signal dsp6_pc_out: std_logic_vector(47 downto 0) := (others => '0');
signal dsp7_p_out: std_logic_vector(47 downto 0) := (others => '0');
signal round_wrd_sym: std_logic_vector(in_data_width downto 0) := (others => '0');
signal carry: std_logic := '0';
signal sum_sym : std_logic_vector(in_data_width downto 0);

begin

round_wrd_sym(in_data_width downto (in_data_width- out_data_width - 1)) <= (others => '0');
round_wrd_sym((in_data_width - out_data_width -2) downto 0) <= (others => '1');
carry <= not dsp7_p_out(in_data_width - 1);

process(clk)
begin
    if rising_edge(clk) then
        if ce = '1' then
           t1_d_t <= d_t;
           t2_d_t <= t1_d_t;
           t3_d_t <= t2_d_t;
           sum_sym <= (dsp7_p_out(in_data_width-1) & dsp7_p_out(in_data_width-1 downto 0)) + round_wrd_sym + carry;
           if sum_sym(in_data_width) = sum_sym(in_data_width-1) then
              dout_t <= sum_sym(in_data_width-1 downto (in_data_width- out_data_width));
           else   -- saturate
              dout_t(out_data_width-1) <= sum_sym(in_data_width);
              if sum_sym(in_data_width) = '0' then
                 dout_t(out_data_width-2 downto 0) <= (others => '1');
              else
                 dout_t(out_data_width-2 downto 0) <= (others => '0');
              end if;
           end if;
        end if;
    end if;
end process;    

t3_d_t_sl <= std_logic_vector(resize(signed(t3_d_t), 31)) & "00000000000000000"; -- Coefficient = 131072 shift left

dsp1: px_pdti_dec16fir_8_dsp
generic map(
    in1_regs=> 2,
    use_in1_casc_in=> false,
    in1_casc_out_regs=> 1,
    num_fraction_bits=> num_fraction_bits,
    use_det=> false,
    use_pcin=> false
)
port map(
clk         => clk,
ce          => ce,
in1         => d_tm1,
in1_casc_in => zeros(29 downto 0),
in2         => d_tm1,
in1_casc_out=> dsp1_incasc_out,
c_in        => t3_d_t_sl, 
pc_in       => zeros,
pc_out      => dsp1_pc_out,
coef        => conv_std_logic_vector(81446,18),
pout        => open,
detout      => open
);

dsp2: px_pdti_dec16fir_8_dsp
generic map(
    in1_regs=> 2,
    use_in1_casc_in=> true,
    in1_casc_out_regs=> 1,
    num_fraction_bits=> num_fraction_bits,
    use_det=> false,
    use_pcin=> true
)
port map(
clk         => clk,
ce          => ce,
in1         => zeros(15 downto 0),
in1_casc_in => dsp1_incasc_out,
in2         => d_tm1,
in1_casc_out=> dsp2_incasc_out,
c_in        => zeros, 
pc_in       => dsp1_pc_out,
pc_out      => dsp2_pc_out,
coef        => conv_std_logic_vector(-22317,18),
pout        => open,
detout      => open
);

dsp3: px_pdti_dec16fir_8_dsp
generic map(
    in1_regs=> 2,
    use_in1_casc_in=> true,
    in1_casc_out_regs=> 1,
    num_fraction_bits=> num_fraction_bits,
    use_det=> false,
    use_pcin=> true
)
port map(
clk         => clk,
ce          => ce,
in1         => zeros(15 downto 0),
in1_casc_in => dsp2_incasc_out,
in2         => d_tm1,
in1_casc_out=> dsp3_incasc_out,
c_in        => zeros, 
pc_in       => dsp2_pc_out,
pc_out      => dsp3_pc_out,
coef        => conv_std_logic_vector(8938,18),
pout        => open,
detout      => open
);

dsp4: px_pdti_dec16fir_8_dsp
generic map(
    in1_regs=> 2,
    use_in1_casc_in=> true,
    in1_casc_out_regs=> 1,
    num_fraction_bits=> num_fraction_bits,
    use_det=> false,
    use_pcin=> true
)
port map(
clk         => clk,
ce          => ce,
in1         => zeros(15 downto 0),
in1_casc_in => dsp3_incasc_out,
in2         => d_tm1,
in1_casc_out=> dsp4_incasc_out,
c_in        => zeros, 
pc_in       => dsp3_pc_out,
pc_out      => dsp4_pc_out,
coef        => conv_std_logic_vector(-3362,18),
pout        => open,
detout      => open
);

dsp5: px_pdti_dec16fir_8_dsp
generic map(
    in1_regs=> 2,
    use_in1_casc_in=> true,
    in1_casc_out_regs=> 1,
    num_fraction_bits=> num_fraction_bits,
    use_det=> false,
    use_pcin=> true
)
port map(
clk         => clk,
ce          => ce,
in1         => zeros(15 downto 0),
in1_casc_in => dsp4_incasc_out,
in2         => d_tm1,
in1_casc_out=> dsp5_incasc_out,
c_in        => zeros, 
pc_in       => dsp4_pc_out,
pc_out      => dsp5_pc_out,
coef        => conv_std_logic_vector(1025,18),
pout        => open,
detout      => open
);

dsp6: px_pdti_dec16fir_8_dsp
generic map(
    in1_regs=> 2,
    use_in1_casc_in=> true,
    in1_casc_out_regs=> 1,
    num_fraction_bits=> num_fraction_bits,
    use_det=> false,
    use_pcin=> true
)
port map(
clk         => clk,
ce          => ce,
in1         => zeros(15 downto 0),
in1_casc_in => dsp5_incasc_out,
in2         => d_tm1,
in1_casc_out=> dsp6_incasc_out,
c_in        => zeros, 
pc_in       => dsp5_pc_out,
pc_out      => dsp6_pc_out,
coef        => conv_std_logic_vector(-215,18),
pout        => open,
detout      => open
);

dsp7: px_pdti_dec16fir_8_dsp
generic map(
    in1_regs=> 2,
    use_in1_casc_in=> true,
    in1_casc_out_regs=> 1,
    num_fraction_bits=> num_fraction_bits,
    use_det=> false,
    use_pcin=> true
)
port map(
clk         => clk,
ce          => ce,
in1         => zeros(15 downto 0),
in1_casc_in => dsp6_incasc_out,
in2         => d_tm1,
in1_casc_out=> open,
c_in        => zeros, 
pc_in       => dsp6_pc_out,
pc_out      => open,
coef        => conv_std_logic_vector(20,18),
pout        => dsp7_p_out,
detout      => open
);

end Behavioral;
