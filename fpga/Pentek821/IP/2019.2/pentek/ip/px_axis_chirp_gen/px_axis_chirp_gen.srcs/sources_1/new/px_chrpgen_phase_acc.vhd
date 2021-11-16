----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2017 11:08:16 AM
-- Design Name: 
-- Module Name: px_chrpgen_phase_acc - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Phase Accumulators for Chirp Generator
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Createdc
-- Additional Comments:
-- latency = 7 ce
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;

Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_chrpgen_phase_acc is
generic (
    samples_per_cycle : integer := 4 -- 1,2,4 or 8
);
port ( 
    clk : in STD_LOGIC;
    ce : in std_logic;
    gate: in std_logic;
    up : in std_logic;
    load : in std_logic;
    start : in std_logic_vector(31 downto 0); -- start phase incr
    offset: in std_logic_vector(31 downto 0); -- offset initial phase
    rate: in std_logic_vector(31 downto 0);
    calc_strt : in std_logic;
    phase0: out std_logic_vector(31 downto 0);
    phase1: out std_logic_vector(31 downto 0); -- not used for 1
    phase2: out std_logic_vector(31 downto 0); -- not used for 1 or 2
    phase3: out std_logic_vector(31 downto 0); -- not used for 1 or 2
    phase4: out std_logic_vector(31 downto 0); -- not used for 1 or 2
    phase5: out std_logic_vector(31 downto 0); -- not used for 1 or 2
    phase6: out std_logic_vector(31 downto 0); -- not used for 1 or 2
    phase7: out std_logic_vector(31 downto 0); -- not used for 1 or 2
    gate_out: out std_logic
    );
end px_chrpgen_phase_acc;

architecture Behavioral of px_chrpgen_phase_acc is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Accumulator 
-- latency = 2 
COMPONENT px_chrpgen_dsp48acc
  PORT (
    B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    CLK : IN STD_LOGIC;
    ADD : IN STD_LOGIC;
    CE : IN STD_LOGIC;
    BYPASS : IN STD_LOGIC;
    Q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

-- Mult Latency = 4
COMPONENT px_axis_chirp_gen_rmult
  PORT (
    CLK : IN STD_LOGIC;
    A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    P : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------
type vctr_type is array (0 to 15) of std_logic_vector(31 downto 0);
signal t1_start   : std_logic_vector(31 downto 0) := (others => '0');
signal t1_rate    : std_logic_vector(31 downto 0) := (others => '0');
signal t2_rate    : std_logic_vector(31 downto 0) := (others => '0');
signal t1_offset  : std_logic_vector(31 downto 0) := (others => '0');
signal t2_offset  : std_logic_vector(31 downto 0) := (others => '0');
signal t3_offset  : std_logic_vector(31 downto 0) := (others => '0');
signal t4_offset  : std_logic_vector(31 downto 0) := (others => '0');
signal t1_add     : std_logic := '0';
signal t2_add     : std_logic := '0';
signal t3_add     : std_logic := '0';
signal t4_add     : std_logic := '0';
signal t5_add     : std_logic := '0';
signal t2_rate16x : std_logic_vector(31 downto 0) := (others => '0');
signal t1_bypass  : std_logic := '0';
signal t2_bypass  : std_logic := '0';
signal t3_bypass  : std_logic := '0';
signal t4_bypass  : std_logic := '0';
signal t5_bypass  : std_logic := '0';
signal t2_rate4x  : std_logic_vector(31 downto 0) := (others => '0');
signal t2_offset1 : std_logic_vector(31 downto 0) := (others => '0');
signal t2_offset2 : std_logic_vector(31 downto 0) := (others => '0');
signal t2_offset3 : std_logic_vector(31 downto 0) := (others => '0');
signal t2_offset4 : std_logic_vector(31 downto 0) := (others => '0');
signal t2_offset5 : std_logic_vector(31 downto 0) := (others => '0');
signal t2_offset6 : std_logic_vector(31 downto 0) := (others => '0');
signal t2_offset7 : std_logic_vector(31 downto 0) := (others => '0');
signal t2_init0   : std_logic_vector(31 downto 0) := (others => '0');
signal t2_init1   : std_logic_vector(31 downto 0) := (others => '0');
signal t2_init2   : std_logic_vector(31 downto 0) := (others => '0');
signal t2_init3   : std_logic_vector(31 downto 0) := (others => '0');
signal t2_init4   : std_logic_vector(31 downto 0) := (others => '0');
signal t2_init5   : std_logic_vector(31 downto 0) := (others => '0');
signal t2_init6   : std_logic_vector(31 downto 0) := (others => '0');
signal t2_init7   : std_logic_vector(31 downto 0) := (others => '0');
signal t5_p0_accx_b: std_logic_vector(31 downto 0) := (others => '0');
signal t5_p1_accx_b: std_logic_vector(31 downto 0) := (others => '0');
signal t5_p2_accx_b: std_logic_vector(31 downto 0) := (others => '0');
signal t5_p3_accx_b: std_logic_vector(31 downto 0) := (others => '0');
signal t5_p4_accx_b: std_logic_vector(31 downto 0) := (others => '0');
signal t5_p5_accx_b: std_logic_vector(31 downto 0) := (others => '0');
signal t5_p6_accx_b: std_logic_vector(31 downto 0) := (others => '0');
signal t5_p7_accx_b: std_logic_vector(31 downto 0) := (others => '0');
signal t3_p0_accy_b: std_logic_vector(31 downto 0) := (others => '0');
signal t3_p1_accy_b: std_logic_vector(31 downto 0) := (others => '0');
signal t3_p2_accy_b: std_logic_vector(31 downto 0) := (others => '0');
signal t3_p3_accy_b: std_logic_vector(31 downto 0) := (others => '0');
signal t3_p4_accy_b: std_logic_vector(31 downto 0) := (others => '0');
signal t3_p5_accy_b: std_logic_vector(31 downto 0) := (others => '0');
signal t3_p6_accy_b: std_logic_vector(31 downto 0) := (others => '0');
signal t3_p7_accy_b: std_logic_vector(31 downto 0) := (others => '0');
signal p0_accy_q: std_logic_vector(31 downto 0) := (others => '0');
signal p1_accy_q: std_logic_vector(31 downto 0) := (others => '0');
signal p2_accy_q: std_logic_vector(31 downto 0) := (others => '0');
signal p3_accy_q: std_logic_vector(31 downto 0) := (others => '0');
signal p4_accy_q: std_logic_vector(31 downto 0) := (others => '0');
signal p5_accy_q: std_logic_vector(31 downto 0) := (others => '0');
signal p6_accy_q: std_logic_vector(31 downto 0) := (others => '0');
signal p7_accy_q: std_logic_vector(31 downto 0) := (others => '0');
signal t1_gate: std_logic := '0';
signal t2_gate: std_logic := '0';
signal t3_gate: std_logic := '0';
signal t4_gate: std_logic := '0';
signal t5_gate: std_logic := '0';
signal t6_gate: std_logic := '0';
signal start_r: std_logic_vector(31 downto 0) := (others => '0');
signal rate_r: std_logic_vector(31 downto 0) := (others => '0');
signal s_mf: std_logic_vector(6 downto 0) := (others => '0');
signal r_mf: std_logic_vector(6 downto 0) := (others => '0');
signal rom_out: std_logic_vector(15 downto 0) := (others => '0');
signal p_s: std_logic_vector(31 downto 0) := (others => '0');
signal p_r: std_logic_vector(31 downto 0) := (others => '0');
signal rom_addr: std_logic_vector(3 downto 0) := (others => '0');
signal calc: std_logic := '0';
signal t1_calc: std_logic := '0';
signal t2_calc: std_logic := '0';
signal t3_calc: std_logic := '0';
signal t4_calc: std_logic := '0';
signal t5_calc: std_logic := '0';
signal t6_calc: std_logic := '0';
signal t7_calc: std_logic := '0';
signal add_r: std_logic := '0';
signal t1_rom_addr: std_logic_vector(3 downto 0) := (others => '0');
signal t2_rom_addr: std_logic_vector(3 downto 0) := (others => '0');
signal t3_rom_addr: std_logic_vector(3 downto 0) := (others => '0');
signal t4_rom_addr: std_logic_vector(3 downto 0) := (others => '0');
signal t5_rom_addr: std_logic_vector(3 downto 0) := (others => '0');
signal t6_rom_addr: std_logic_vector(3 downto 0) := (others => '0');
signal t7_rom_addr: std_logic_vector(3 downto 0) := (others => '0');
signal offset_r: std_logic_vector(31 downto 0) := (others => '0');
signal t2_offset_r: std_logic_vector(31 downto 0) := (others => '0');
signal t7_calc_sum: std_logic_vector(31 downto 0) := (others => '0');
signal cal_vctr: vctr_type;
signal t2_rate64x: std_logic_vector(31 downto 0) := (others => '0');

begin

gen_calcs_1: if (samples_per_cycle = 1) generate

process(clk)
begin
    if rising_edge(clk) then
        if ce = '1' then
            t1_start   <= start;
            t1_offset  <= offset;
            t2_offset  <= t1_offset;
            t3_offset  <= t2_offset;
            t4_offset  <= t3_offset;
            t1_rate    <= rate;
            t1_add     <= up;
            t2_add     <= t1_add;
            t3_add     <= t2_add;
            t4_add     <= t3_add;
            t5_add     <= t4_add;
            t1_bypass  <= load;
            t2_bypass  <= t1_bypass;
            t3_bypass  <= t2_bypass;
            t4_bypass  <= t3_bypass;
            t5_bypass  <= t4_bypass;
            t1_gate    <= gate; 
            t2_gate    <= t1_gate;
            t3_gate    <= t2_gate;
            t4_gate    <= t3_gate;
            t5_gate    <= t4_gate;  
            t6_gate    <= t5_gate; 
            gate_out   <= t6_gate;        
            t2_rate    <= t1_rate;
            if t1_add = '1' then
                -- init 0
                t2_init0 <= t1_start;
            else
                -- init 0
                t2_init0 <= t1_start;   
            end if;  
            if t2_bypass = '1' then
                 -- init 0
                 t3_p0_accy_b <= t2_init0;
            elsif t2_gate = '1' then
                 t3_p0_accy_b <= t2_rate;
            else
                 t3_p0_accy_b <= x"00000000";
            end if; 
            if t4_bypass = '1' then
                 -- offset 0
                 t5_p0_accx_b <= t4_offset; --x"00000000";
            elsif t4_gate = '1' then
                 t5_p0_accx_b <= p0_accy_q;
            else
                 t5_p0_accx_b <= x"00000000";
            end if;   
        end if;      
    end if;
end process;

    
p0_accy : px_chrpgen_dsp48acc
  PORT MAP (
    B      => t3_p0_accy_b,
    CLK    => clk,
    ADD    => t3_add,
    CE     => ce,
    BYPASS => t3_bypass,
    Q      => p0_accy_q
  );

p0_accx : px_chrpgen_dsp48acc
  PORT MAP (
    B      => t5_p0_accx_b,
    CLK    => clk,
    ADD    => '1',
    CE     => ce,
    BYPASS => t5_bypass,
    Q      => phase0
  );

phase1 <= x"00000000"; 
phase2 <= x"00000000"; 
phase3 <= x"00000000"; 
phase4 <= x"00000000"; 
phase5 <= x"00000000"; 
phase6 <= x"00000000"; 
phase7 <= x"00000000"; 
 
end generate;

gen_calcs_2: if (samples_per_cycle = 2) generate

calc_mult1 : px_axis_chirp_gen_rmult
  PORT MAP (
    CLK => clk,
    A => start_r,
    B => s_mf,
    P => p_s
  );
calc_mult2 : px_axis_chirp_gen_rmult
  PORT MAP (
    CLK => clk,
    A => rate_r,
    B => r_mf,
    P => p_r
  );

process(clk)
begin
    if rising_edge(clk) then
      if calc_strt = '1' then
         rom_addr <= "0011";
         calc     <= '1';
         add_r    <= t1_add;
         start_r  <= t1_start;
         rate_r   <= t1_rate; 
         offset_r <= t1_offset;
      elsif (rom_addr /= "0000") then
         rom_addr <= rom_addr - 1;
      else
         calc <= '0';   
      end if;
    end if;
end process;

mf_rom_inst: xpm_memory_sprom
  generic map (

    -- Common module generics
    MEMORY_SIZE             => 64,            --positive integer
    MEMORY_PRIMITIVE        => "distributed",   --string; "auto", "distributed", or "block";
    MEMORY_INIT_FILE        => "none",          --string; "none" or "<filename>.mem" 
    MEMORY_INIT_PARAM       => "0,100,201,203", --string;
    USE_MEM_INIT            => 1,               --integer; 0,1
    WAKEUP_TIME             => "disable_sleep", --string; "disable_sleep" or "use_sleep_pin" 
    MESSAGE_CONTROL         => 0,               --integer; 0,1
    ECC_MODE                => "no_ecc",        --string; "no_ecc", "encode_only", "decode_only" or "both_encode_and_decode" 
    AUTO_SLEEP_TIME         => 0,               --Do not Change
    MEMORY_OPTIMIZATION     => "true",          --string; "true", "false" 
    -- Port A module generics
    READ_DATA_WIDTH_A       => 16,              --positive integer
    ADDR_WIDTH_A            => 3,               --positive integer
    READ_RESET_VALUE_A      => "0",             --string
    READ_LATENCY_A          => 2                --non-negative integer
  )
  port map (
    -- Common module ports
    sleep                   => '0',
    -- Port A module ports
    clka                    => clk,
    rsta                    => '0',
    ena                     => '1',
    regcea                  => '1',
    addra                   => rom_addr(2 downto 0),
    injectsbiterra          => '0',   --do not change
    injectdbiterra          => '0',   --do not change
    douta                   => rom_out,
    sbiterra                => open,  --do not change
    dbiterra                => open   --do not change
  );

s_mf <= rom_out(14 downto 8);
r_mf <= rom_out(6 downto 0);


process(clk)
begin
    if rising_edge(clk) then
        t1_calc <= calc;
        t2_calc <= t1_calc;
        t3_calc <= t2_calc;
        t4_calc <= t3_calc;
        t5_calc <= t4_calc;
        t6_calc <= t5_calc;
        t7_calc <= t6_calc;
        t1_rom_addr <= rom_addr;
        t2_rom_addr <= t1_rom_addr;
        t3_rom_addr <= t2_rom_addr;
        t4_rom_addr <= t3_rom_addr;
        t5_rom_addr <= t4_rom_addr;
        t6_rom_addr <= t5_rom_addr;
        t7_rom_addr <= t6_rom_addr;
    if add_r = '1' then
       t7_calc_sum <= p_s + p_r;
    else
       t7_calc_sum <= p_s - p_r;
    end if;   
    if t7_calc = '1' then
       cal_vctr(conv_integer(t7_rom_addr))(31 downto 0) <= t7_calc_sum;
    end if;
    t1_start   <= start;
    t1_offset  <= offset; 
    t1_rate    <= rate;
    t1_add     <= up;  
    t2_add     <= t1_add;
    t3_add     <= t2_add;        
        if ce = '1' then
         t1_bypass  <= load;
         t2_bypass  <= t1_bypass;
         t3_bypass  <= t2_bypass;
         t4_bypass  <= t3_bypass;
         t5_bypass  <= t4_bypass;
         t1_gate    <= gate; 
         t2_gate    <= t1_gate;
         t3_gate    <= t2_gate;
         t4_gate    <= t3_gate;
         t5_gate    <= t4_gate;  
         t6_gate    <= t5_gate; 
         gate_out   <= t6_gate;        
          t2_offset1 <= cal_vctr(1)(31 downto 0);
          t2_init0 <= cal_vctr(2)(31 downto 0);
          t2_init1 <= cal_vctr(3)(31 downto 0);
          t2_offset_r<= offset_r;
          t2_rate4x <= (rate_r(29 downto 0) & "00");
             if t2_bypass = '1' then
              -- init 0
              t3_p0_accy_b <= t2_init0;
              -- init 1
              t3_p1_accy_b <= t2_init1;
          elsif t2_gate = '1' then
              t3_p0_accy_b <= t2_rate4x;
              t3_p1_accy_b <= t2_rate4x;
          else
              t3_p0_accy_b <= x"00000000";
              t3_p1_accy_b <= x"00000000";
          end if; 
          if t4_bypass = '1' then
              -- offset 0
              t5_p0_accx_b <= t2_offset_r;
              -- offset 1
              t5_p1_accx_b <= t2_offset_r + t2_offset1;
          elsif t4_gate = '1' then
              t5_p0_accx_b <= p0_accy_q;
              t5_p1_accx_b <= p1_accy_q;
          else
              t5_p0_accx_b <= x"00000000";
              t5_p1_accx_b <= x"00000000";
          end if;   
        end if;      
    end if;
end process;

    
p0_accy : px_chrpgen_dsp48acc
  PORT MAP (
    B      => t3_p0_accy_b,
    CLK    => clk,
    ADD    => t3_add,
    CE     => ce,
    BYPASS => t3_bypass,
    Q      => p0_accy_q
  );

p0_accx : px_chrpgen_dsp48acc
  PORT MAP (
    B      => t5_p0_accx_b,
    CLK    => clk,
    ADD    => '1',
    CE     => ce,
    BYPASS => t5_bypass,
    Q      => phase0
  );
  
p1_accy : px_chrpgen_dsp48acc
    PORT MAP (
      B      => t3_p1_accy_b,
      CLK    => clk,
      ADD    => t3_add,
      CE     => ce,
      BYPASS => t3_bypass,
      Q      => p1_accy_q
    );
  
p1_accx : px_chrpgen_dsp48acc
    PORT MAP (
      B      => t5_p1_accx_b,
      CLK    => clk,
      ADD    => '1',
      CE     => ce,
      BYPASS => t5_bypass,
      Q      => phase1
    );
    
phase2 <= x"00000000"; 
phase3 <= x"00000000";     
phase4 <= x"00000000"; 
phase5 <= x"00000000";     
phase6 <= x"00000000"; 
phase7 <= x"00000000";        
end generate;


gen_calcs_4: if (samples_per_cycle = 4) generate

calc_mult1 : px_axis_chirp_gen_rmult
  PORT MAP (
    CLK => clk,
    A => start_r,
    B => s_mf,
    P => p_s
  );
calc_mult2 : px_axis_chirp_gen_rmult
  PORT MAP (
    CLK => clk,
    A => rate_r,
    B => r_mf,
    P => p_r
  );

process(clk)
begin
    if rising_edge(clk) then
      if calc_strt = '1' then
         rom_addr <= "0111";
         calc     <= '1';
         add_r    <= t1_add;
         start_r  <= t1_start;
         rate_r   <= t1_rate; 
         offset_r <= t1_offset;
      elsif (rom_addr /= "0000") then
         rom_addr <= rom_addr - 1;
      else
         calc <= '0';   
      end if;
    end if;
end process;

mf_rom_inst: xpm_memory_sprom
  generic map (

    -- Common module generics
    MEMORY_SIZE             => 128,            --positive integer
    MEMORY_PRIMITIVE        => "distributed",   --string; "auto", "distributed", or "block";
    MEMORY_INIT_FILE        => "none",          --string; "none" or "<filename>.mem" 
    MEMORY_INIT_PARAM       => "0,100,201,303,406,40A,40E,412", --string;
    USE_MEM_INIT            => 1,               --integer; 0,1
    WAKEUP_TIME             => "disable_sleep", --string; "disable_sleep" or "use_sleep_pin" 
    MESSAGE_CONTROL         => 0,               --integer; 0,1
    ECC_MODE                => "no_ecc",        --string; "no_ecc", "encode_only", "decode_only" or "both_encode_and_decode" 
    AUTO_SLEEP_TIME         => 0,               --Do not Change
    MEMORY_OPTIMIZATION     => "true",          --string; "true", "false" 
    -- Port A module generics
    READ_DATA_WIDTH_A       => 16,              --positive integer
    ADDR_WIDTH_A            => 3,               --positive integer
    READ_RESET_VALUE_A      => "0",             --string
    READ_LATENCY_A          => 2                --non-negative integer
  )
  port map (
    -- Common module ports
    sleep                   => '0',
    -- Port A module ports
    clka                    => clk,
    rsta                    => '0',
    ena                     => '1',
    regcea                  => '1',
    addra                   => rom_addr(2 downto 0),
    injectsbiterra          => '0',   --do not change
    injectdbiterra          => '0',   --do not change
    douta                   => rom_out,
    sbiterra                => open,  --do not change
    dbiterra                => open   --do not change
  );

s_mf <= rom_out(14 downto 8);
r_mf <= rom_out(6 downto 0);

process(clk)
begin
    if rising_edge(clk) then
        t1_calc <= calc;
        t2_calc <= t1_calc;
        t3_calc <= t2_calc;
        t4_calc <= t3_calc;
        t5_calc <= t4_calc;
        t6_calc <= t5_calc;
        t7_calc <= t6_calc;
        t1_rom_addr <= rom_addr;
        t2_rom_addr <= t1_rom_addr;
        t3_rom_addr <= t2_rom_addr;
        t4_rom_addr <= t3_rom_addr;
        t5_rom_addr <= t4_rom_addr;
        t6_rom_addr <= t5_rom_addr;
        t7_rom_addr <= t6_rom_addr;
    if add_r = '1' then
       t7_calc_sum <= p_s + p_r;
    else
       t7_calc_sum <= p_s - p_r;
    end if;   
    if t7_calc = '1' then
       cal_vctr(conv_integer(t7_rom_addr))(31 downto 0) <= t7_calc_sum;
    end if;
    t1_start   <= start;
    t1_offset  <= offset; 
    t1_rate    <= rate;
    t1_add     <= up;  
    t2_add     <= t1_add;
    t3_add     <= t2_add;        
        if ce = '1' then
         t1_bypass  <= load;
         t2_bypass  <= t1_bypass;
         t3_bypass  <= t2_bypass;
         t4_bypass  <= t3_bypass;
         t5_bypass  <= t4_bypass;
         t1_gate    <= gate; 
         t2_gate    <= t1_gate;
         t3_gate    <= t2_gate;
         t4_gate    <= t3_gate;
         t5_gate    <= t4_gate;  
         t6_gate    <= t5_gate; 
         gate_out   <= t6_gate;        
          t2_offset1 <= cal_vctr(1)(31 downto 0);
          t2_offset2 <= cal_vctr(2)(31 downto 0);
          t2_offset3 <= cal_vctr(3)(31 downto 0);
          t2_init0 <= cal_vctr(4)(31 downto 0);
          t2_init1 <= cal_vctr(5)(31 downto 0);
          t2_init2 <= cal_vctr(6)(31 downto 0);
          t2_init3 <= cal_vctr(7)(31 downto 0);
          t2_offset_r<= offset_r;
          t2_rate16x <= (rate_r(27 downto 0) & "0000");
             if t2_bypass = '1' then
              -- init 0
              t3_p0_accy_b <= t2_init0;
              -- init 1
              t3_p1_accy_b <= t2_init1;
              -- init 2
              t3_p2_accy_b <= t2_init2;
              -- init 3
              t3_p3_accy_b <= t2_init3;
          elsif t2_gate = '1' then
              t3_p0_accy_b <= t2_rate16x;
              t3_p1_accy_b <= t2_rate16x;
              t3_p2_accy_b <= t2_rate16x;
              t3_p3_accy_b <= t2_rate16x;
          else
              t3_p0_accy_b <= x"00000000";
              t3_p1_accy_b <= x"00000000";
              t3_p2_accy_b <= x"00000000";
              t3_p3_accy_b <= x"00000000";
          end if; 
          if t4_bypass = '1' then
              -- offset 0
              t5_p0_accx_b <= t2_offset_r;
              -- offset 1
              t5_p1_accx_b <= t2_offset_r + t2_offset1;
              -- offset 2
              t5_p2_accx_b <= t2_offset_r + t2_offset2;
              -- offset 3
              t5_p3_accx_b <= t2_offset_r + t2_offset3;
          elsif t4_gate = '1' then
              t5_p0_accx_b <= p0_accy_q;
              t5_p1_accx_b <= p1_accy_q;
              t5_p2_accx_b <= p2_accy_q;
              t5_p3_accx_b <= p3_accy_q;
          else
              t5_p0_accx_b <= x"00000000";
              t5_p1_accx_b <= x"00000000";
              t5_p2_accx_b <= x"00000000";
              t5_p3_accx_b <= x"00000000";
          end if;   
        end if;      
    end if;
end process;

    
p0_accy : px_chrpgen_dsp48acc
  PORT MAP (
    B      => t3_p0_accy_b,
    CLK    => clk,
    ADD    => t3_add,
    CE     => ce,
    BYPASS => t3_bypass,
    Q      => p0_accy_q
  );

p0_accx : px_chrpgen_dsp48acc
  PORT MAP (
    B      => t5_p0_accx_b,
    CLK    => clk,
    ADD    => '1',
    CE     => ce,
    BYPASS => t5_bypass,
    Q      => phase0
  );
  
p1_accy : px_chrpgen_dsp48acc
    PORT MAP (
      B      => t3_p1_accy_b,
      CLK    => clk,
      ADD    => t3_add,
      CE     => ce,
      BYPASS => t3_bypass,
      Q      => p1_accy_q
    );
  
p1_accx : px_chrpgen_dsp48acc
    PORT MAP (
      B      => t5_p1_accx_b,
      CLK    => clk,
      ADD    => '1',
      CE     => ce,
      BYPASS => t5_bypass,
      Q      => phase1
    );

p2_accy : px_chrpgen_dsp48acc
    PORT MAP (
      B      => t3_p2_accy_b,
      CLK    => clk,
      ADD    => t3_add,
      CE     => ce,
      BYPASS => t3_bypass,
      Q      => p2_accy_q
    );
  
p2_accx : px_chrpgen_dsp48acc
    PORT MAP (
      B      => t5_p2_accx_b,
      CLK    => clk,
      ADD    => '1',
      CE     => ce,
      BYPASS => t5_bypass,
      Q      => phase2
    );

p3_accy : px_chrpgen_dsp48acc
    PORT MAP (
      B      => t3_p3_accy_b,
      CLK    => clk,
      ADD    => t3_add,
      CE     => ce,
      BYPASS => t3_bypass,
      Q      => p3_accy_q
    );
  
p3_accx : px_chrpgen_dsp48acc
    PORT MAP (
      B      => t5_p3_accx_b,
      CLK    => clk,
      ADD    => '1',
      CE     => ce,
      BYPASS => t5_bypass,
      Q      => phase3
    );

phase4 <= x"00000000"; 
phase5 <= x"00000000";     
phase6 <= x"00000000"; 
phase7 <= x"00000000"; 
    
end generate;

gen_calcs_8: if (samples_per_cycle = 8) generate

calc_mult1 : px_axis_chirp_gen_rmult
  PORT MAP (
    CLK => clk,
    A => start_r,
    B => s_mf,
    P => p_s
  );
calc_mult2 : px_axis_chirp_gen_rmult
  PORT MAP (
    CLK => clk,
    A => rate_r,
    B => r_mf,
    P => p_r
  );

process(clk)
begin
    if rising_edge(clk) then
      if calc_strt = '1' then
         rom_addr <= "1111";
         calc     <= '1';
         add_r    <= t1_add;
         start_r  <= t1_start;
         rate_r   <= t1_rate; 
         offset_r <= t1_offset;
      elsif (rom_addr /= "0000") then
         rom_addr <= rom_addr - 1;
      else
         calc <= '0';   
      end if;
    end if;
end process;

mf_rom_inst: xpm_memory_sprom
  generic map (

    -- Common module generics
    MEMORY_SIZE             => 256,            --positive integer
    MEMORY_PRIMITIVE        => "distributed",   --string; "auto", "distributed", or "block";
    MEMORY_INIT_FILE        => "none",          --string; "none" or "<filename>.mem" 
    MEMORY_INIT_PARAM       => "0,100,201,303,406,50A,60F,715,81C,824,82C,834,83C,844,84C,854", --string;
    USE_MEM_INIT            => 1,               --integer; 0,1
    WAKEUP_TIME             => "disable_sleep", --string; "disable_sleep" or "use_sleep_pin" 
    MESSAGE_CONTROL         => 0,               --integer; 0,1
    ECC_MODE                => "no_ecc",        --string; "no_ecc", "encode_only", "decode_only" or "both_encode_and_decode" 
    AUTO_SLEEP_TIME         => 0,               --Do not Change
    MEMORY_OPTIMIZATION     => "true",          --string; "true", "false" 
    -- Port A module generics
    READ_DATA_WIDTH_A       => 16,              --positive integer
    ADDR_WIDTH_A            => 4,               --positive integer
    READ_RESET_VALUE_A      => "0",             --string
    READ_LATENCY_A          => 2                --non-negative integer
  )
  port map (
    -- Common module ports
    sleep                   => '0',
    -- Port A module ports
    clka                    => clk,
    rsta                    => '0',
    ena                     => '1',
    regcea                  => '1',
    addra                   => rom_addr,
    injectsbiterra          => '0',   --do not change
    injectdbiterra          => '0',   --do not change
    douta                   => rom_out,
    sbiterra                => open,  --do not change
    dbiterra                => open   --do not change
  );

s_mf <= rom_out(14 downto 8);
r_mf <= rom_out(6 downto 0);
     
process(clk)
begin
    if rising_edge(clk) then
        t1_calc <= calc;
        t2_calc <= t1_calc;
        t3_calc <= t2_calc;
        t4_calc <= t3_calc;
        t5_calc <= t4_calc;
        t6_calc <= t5_calc;
        t7_calc <= t6_calc;
        t1_rom_addr <= rom_addr;
        t2_rom_addr <= t1_rom_addr;
        t3_rom_addr <= t2_rom_addr;
        t4_rom_addr <= t3_rom_addr;
        t5_rom_addr <= t4_rom_addr;
        t6_rom_addr <= t5_rom_addr;
        t7_rom_addr <= t6_rom_addr;
        if add_r = '1' then
           t7_calc_sum <= p_s + p_r;
        else
           t7_calc_sum <= p_s - p_r;
        end if;   
        if t7_calc = '1' then
           cal_vctr(conv_integer(t7_rom_addr))(31 downto 0) <= t7_calc_sum;
        end if;
        t1_start   <= start;
        t1_offset  <= offset; 
        t1_rate    <= rate;
        t1_add     <= up;  
        t2_add     <= t1_add;
        t3_add     <= t2_add;        
        if ce = '1' then
            t1_bypass  <= load;
            t2_bypass  <= t1_bypass;
            t3_bypass  <= t2_bypass;
            t4_bypass  <= t3_bypass;
            t5_bypass  <= t4_bypass;
            t1_gate    <= gate; 
            t2_gate    <= t1_gate;
            t3_gate    <= t2_gate;
            t4_gate    <= t3_gate;
            t5_gate    <= t4_gate;  
            t6_gate    <= t5_gate; 
            gate_out   <= t6_gate;        
             t2_offset1 <= cal_vctr(1)(31 downto 0);
             t2_offset2 <= cal_vctr(2)(31 downto 0);
             t2_offset3 <= cal_vctr(3)(31 downto 0);
             t2_offset4 <= cal_vctr(4)(31 downto 0);
             t2_offset5 <= cal_vctr(5)(31 downto 0);
             t2_offset6 <= cal_vctr(6)(31 downto 0);
             t2_offset7 <= cal_vctr(7)(31 downto 0);
             t2_init0 <= cal_vctr(8)(31 downto 0);
             t2_init1 <= cal_vctr(9)(31 downto 0);
             t2_init2 <= cal_vctr(10)(31 downto 0);
             t2_init3 <= cal_vctr(11)(31 downto 0);
             t2_init4 <= cal_vctr(12)(31 downto 0);
             t2_init5 <= cal_vctr(13)(31 downto 0);
             t2_init6 <= cal_vctr(14)(31 downto 0);
             t2_init7 <= cal_vctr(15)(31 downto 0);
             t2_offset_r<= offset_r;
             t2_rate64x <= (rate_r(25 downto 0) & "000000");
             if t2_bypass = '1' then
                 -- init 0
                 t3_p0_accy_b <= t2_init0;
                 -- init 1
                 t3_p1_accy_b <= t2_init1;
                 -- init 2
                 t3_p2_accy_b <= t2_init2;
                 -- init 3
                 t3_p3_accy_b <= t2_init3;
                 -- init 0
                 t3_p4_accy_b <= t2_init4;
                 -- init 1
                 t3_p5_accy_b <= t2_init5;
                 -- init 2
                 t3_p6_accy_b <= t2_init6;
                 -- init 3
                 t3_p7_accy_b <= t2_init7;
             elsif t2_gate = '1' then
                 t3_p0_accy_b <= t2_rate64x;
                 t3_p1_accy_b <= t2_rate64x;
                 t3_p2_accy_b <= t2_rate64x;
                 t3_p3_accy_b <= t2_rate64x;
                 t3_p4_accy_b <= t2_rate64x;
                 t3_p5_accy_b <= t2_rate64x;
                 t3_p6_accy_b <= t2_rate64x;
                 t3_p7_accy_b <= t2_rate64x;
             else
                 t3_p0_accy_b <= x"00000000";
                 t3_p1_accy_b <= x"00000000";
                 t3_p2_accy_b <= x"00000000";
                 t3_p3_accy_b <= x"00000000";
                 t3_p4_accy_b <= x"00000000";
                 t3_p5_accy_b <= x"00000000";
                 t3_p6_accy_b <= x"00000000";
                 t3_p7_accy_b <= x"00000000";
             end if; 
             if t4_bypass = '1' then
                 -- offset 0
                 t5_p0_accx_b <= t2_offset_r;
                 -- offset 1
                 t5_p1_accx_b <= t2_offset_r + t2_offset1;
                 -- offset 2
                 t5_p2_accx_b <= t2_offset_r + t2_offset2;
                 -- offset 3
                 t5_p3_accx_b <= t2_offset_r + t2_offset3;
                 -- offset 0
                 t5_p4_accx_b <= t2_offset_r + t2_offset4;
                 -- offset 1
                 t5_p5_accx_b <= t2_offset_r + t2_offset5;
                 -- offset 2
                 t5_p6_accx_b <= t2_offset_r + t2_offset6;
                 -- offset 3
                 t5_p7_accx_b <= t2_offset_r + t2_offset7;
             elsif t4_gate = '1' then
                 t5_p0_accx_b <= p0_accy_q;
                 t5_p1_accx_b <= p1_accy_q;
                 t5_p2_accx_b <= p2_accy_q;
                 t5_p3_accx_b <= p3_accy_q;
                 t5_p4_accx_b <= p4_accy_q;
                 t5_p5_accx_b <= p5_accy_q;
                 t5_p6_accx_b <= p6_accy_q;
                 t5_p7_accx_b <= p7_accy_q;
             else
                 t5_p0_accx_b <= x"00000000";
                 t5_p1_accx_b <= x"00000000";
                 t5_p2_accx_b <= x"00000000";
                 t5_p3_accx_b <= x"00000000";
                 t5_p4_accx_b <= x"00000000";
                 t5_p5_accx_b <= x"00000000";
                 t5_p6_accx_b <= x"00000000";
                 t5_p7_accx_b <= x"00000000";
             end if;   
        end if;      
    end if;
end process;

    
p0_accy : px_chrpgen_dsp48acc
  PORT MAP (
    B      => t3_p0_accy_b,
    CLK    => clk,
    ADD    => t3_add,
    CE     => ce,
    BYPASS => t3_bypass,
    Q      => p0_accy_q
  );

p0_accx : px_chrpgen_dsp48acc
  PORT MAP (
    B      => t5_p0_accx_b,
    CLK    => clk,
    ADD    => '1',
    CE     => ce,
    BYPASS => t5_bypass,
    Q      => phase0
  );
  
p1_accy : px_chrpgen_dsp48acc
    PORT MAP (
      B      => t3_p1_accy_b,
      CLK    => clk,
      ADD    => t3_add,
      CE     => ce,
      BYPASS => t3_bypass,
      Q      => p1_accy_q
    );
  
p1_accx : px_chrpgen_dsp48acc
    PORT MAP (
      B      => t5_p1_accx_b,
      CLK    => clk,
      ADD    => '1',
      CE     => ce,
      BYPASS => t5_bypass,
      Q      => phase1
    );

p2_accy : px_chrpgen_dsp48acc
    PORT MAP (
      B      => t3_p2_accy_b,
      CLK    => clk,
      ADD    => t3_add,
      CE     => ce,
      BYPASS => t3_bypass,
      Q      => p2_accy_q
    );
  
p2_accx : px_chrpgen_dsp48acc
    PORT MAP (
      B      => t5_p2_accx_b,
      CLK    => clk,
      ADD    => '1',
      CE     => ce,
      BYPASS => t5_bypass,
      Q      => phase2
    );

p3_accy : px_chrpgen_dsp48acc
    PORT MAP (
      B      => t3_p3_accy_b,
      CLK    => clk,
      ADD    => t3_add,
      CE     => ce,
      BYPASS => t3_bypass,
      Q      => p3_accy_q
    );
  
p3_accx : px_chrpgen_dsp48acc
    PORT MAP (
      B      => t5_p3_accx_b,
      CLK    => clk,
      ADD    => '1',
      CE     => ce,
      BYPASS => t5_bypass,
      Q      => phase3
    );
    
p4_accy : px_chrpgen_dsp48acc
      PORT MAP (
        B      => t3_p4_accy_b,
        CLK    => clk,
        ADD    => t3_add,
        CE     => ce,
        BYPASS => t3_bypass,
        Q      => p4_accy_q
      );
    
    p4_accx : px_chrpgen_dsp48acc
      PORT MAP (
        B      => t5_p4_accx_b,
        CLK    => clk,
        ADD    => '1',
        CE     => ce,
        BYPASS => t5_bypass,
        Q      => phase4
      );
      
    p5_accy : px_chrpgen_dsp48acc
        PORT MAP (
          B      => t3_p5_accy_b,
          CLK    => clk,
          ADD    => t3_add,
          CE     => ce,
          BYPASS => t3_bypass,
          Q      => p5_accy_q
        );
      
    p5_accx : px_chrpgen_dsp48acc
        PORT MAP (
          B      => t5_p5_accx_b,
          CLK    => clk,
          ADD    => '1',
          CE     => ce,
          BYPASS => t5_bypass,
          Q      => phase5
        );
    
    p6_accy : px_chrpgen_dsp48acc
        PORT MAP (
          B      => t3_p6_accy_b,
          CLK    => clk,
          ADD    => t3_add,
          CE     => ce,
          BYPASS => t3_bypass,
          Q      => p6_accy_q
        );
      
    p6_accx : px_chrpgen_dsp48acc
        PORT MAP (
          B      => t5_p6_accx_b,
          CLK    => clk,
          ADD    => '1',
          CE     => ce,
          BYPASS => t5_bypass,
          Q      => phase6
        );
    
    p7_accy : px_chrpgen_dsp48acc
        PORT MAP (
          B      => t3_p7_accy_b,
          CLK    => clk,
          ADD    => t3_add,
          CE     => ce,
          BYPASS => t3_bypass,
          Q      => p7_accy_q
        );
      
    p7_accx : px_chrpgen_dsp48acc
        PORT MAP (
          B      => t5_p7_accx_b,
          CLK    => clk,
          ADD    => '1',
          CE     => ce,
          BYPASS => t5_bypass,
          Q      => phase7
        );
                
    
end generate;

end Behavioral;
