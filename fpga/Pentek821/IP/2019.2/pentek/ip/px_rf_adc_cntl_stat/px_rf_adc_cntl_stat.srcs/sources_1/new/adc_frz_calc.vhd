----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/22/2018 06:38:57 PM
-- Design Name: 
-- Module Name: adc_frz_calc - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adc_frz_calc is
    Generic (
        max_samples_per_cycle: integer := 8;
        real_only: boolean
    );
    Port ( clk       : in STD_LOGIC;
           rst_n     : in STD_LOGIC;
           adc_i     : in STD_LOGIC_VECTOR ((16*max_samples_per_cycle)-1 downto 0);
           adc_q     : in STD_LOGIC_VECTOR ((16*max_samples_per_cycle)-1 downto 0);
           adc_dval  : in STD_LOGIC;
           enable    : in STD_LOGIC;
           ddc_mode  : in STD_LOGIC;
           dec       : in STD_LOGIC_VECTOR (1 downto 0);
           freeze_manual: in STD_LOGIC;
           freeze    : out STD_LOGIC
           );
end adc_frz_calc;

architecture Behavioral of adc_frz_calc is

COMPONENT px_rf_adc_acc_dsp48
  PORT (
    CLK : IN STD_LOGIC;
    SCLR : IN STD_LOGIC;
    C : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    CONCAT : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    P : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
  );
END COMPONENT;

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

type set_v24 is array (0 to 7) of std_logic_vector(23 downto 0);
type set_v26 is array (0 to 7) of std_logic_vector(25 downto 0);
type set_v12 is array (0 to 7) of std_logic_vector(11 downto 0);

constant count_cycles : std_logic_vector(14 downto 0) := conv_std_logic_vector(16383,15);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal t1_latch_en: std_logic := '0';
signal t2_latch_en: std_logic := '0';
signal t3_latch_en: std_logic := '0';
signal val_ff     : std_logic := '0';
signal latch_en : std_logic := '0';
signal freeze_rq: std_logic := '0';
signal count : std_logic_vector(14 downto 0) := (others => '0');
signal freeze_rmsi: std_logic_vector(7 downto 0) := (others => '0');
signal freeze_rmsq: std_logic_vector(7 downto 0) := (others => '0');
signal acci : set_v24;
signal accq : set_v24;
signal accompi : set_v12;
signal accompq : set_v12;
signal absvi : set_v12;
signal absvq : set_v12;
signal avg_absi : set_v26;
signal avg_absq : set_v26;
signal rmsi : set_v12;
signal rmsq : set_v12;
signal t1_man_freeze: std_logic := '0';
signal acci_psr:set_v24;
signal accq_psr:set_v24;
signal adc_i_div:set_v24;
signal adc_q_div:set_v24;
signal sclr : std_logic := '0';
begin

process(clk) 
begin 
   if rising_edge(clk) then
      t1_latch_en <= latch_en;
      t2_latch_en <= t1_latch_en;
      t3_latch_en <= t2_latch_en; 
      t1_man_freeze  <= freeze_manual;
      if adc_dval = '0' then
         val_ff <= '0';
      elsif t3_latch_en = '1' then
         val_ff <= '1';
      end if;
      if  ddc_mode = '0' then
         if freeze_rmsi /= "00000000" then
            freeze_rq <= enable and val_ff;
         else
            freeze_rq <= '0';
         end if;   
      else
         case dec is
            when "00" => -- dec = 1
               if (freeze_rmsi /= "00000000") or (freeze_rmsq /= "00000000") then
                  freeze_rq <= enable and val_ff;
               else
                  freeze_rq <= '0';
               end if;
            when "01" => -- dec = 2
               if (freeze_rmsi(3 downto 0) /= "0000") or (freeze_rmsq(3 downto 0) /= "0000") then
                  freeze_rq <= enable and val_ff;
               else
                  freeze_rq <= '0';
               end if;
            when "10" => -- dec = 4
               if (freeze_rmsi(1 downto 0) /= "00") or (freeze_rmsq(1 downto 0) /= "00") then
                  freeze_rq <= enable and val_ff;
               else
                  freeze_rq <= '0';
               end if;   
            when "11" => -- dec = 8
               freeze_rq <= (freeze_rmsi(0) or freeze_rmsq(0)) and enable and val_ff;      
            when others =>
               freeze_rq <= (freeze_rmsi(0) or freeze_rmsq(0)) and enable and val_ff;      
         end case; 
      end if;
      freeze <= freeze_rq or t1_man_freeze;  
   end if;
end process; 

process(clk) 
begin 
   if rising_edge(clk) then
      if (rst_n = '0') then 
         count <= count_cycles;
      else
         if (count = 0) then
            count <= count_cycles;
            latch_en <= '1';
         else
            count <= count -1;
            latch_en <= '0';
         end if;
      end if;   
   end if;
end process;   

gen_comp: for i in 0 to (max_samples_per_cycle-1) generate -- Create Freeze logic blocks for only the maximum number of samples per cycle
process(clk)
begin
   if rising_edge(clk) then
   --if rst_n = '0' then
   --   acci(i) <= x"000000";
   --else
   --   acci(i) <= sxt(adc_i((i*16)+15 downto ((i*16)+4)), 24) + acci(i) -  sxt(acci(i)(23 downto 12), 24);
   --end if;  
   accompi(i) <= adc_i((i*16)+15 downto ((i*16)+4)) - acci(i)(23 downto 12);
   if (accompi(i) < 0) then
      absvi(i) <= 0 - accompi(i);
   else
      absvi(i) <= accompi(i);
   end if; 
   if t1_latch_en = '1' then
      avg_absi(i) <= (others => '0');
      rmsi(i) <= avg_absi(i)(25 downto 14);
   else
      avg_absi(i) <= avg_absi(i) + sxt(absvi(i), 26);
   end if;
   if (('0' & rmsi(i)) < 25) then
      freeze_rmsi(i) <= '1';
   else
      freeze_rmsi(i) <= '0';   
   end if; 
   end if; 
end process;

sclr <= not rst_n;
acci_psr(i) <= sxt(acci(i)(23 downto 12), 24);
adc_i_div(i) <= sxt(adc_i((i*16)+15 downto ((i*16)+4)), 24);

-- A+P-C (C latency = 0) 
acci_acc : px_rf_adc_acc_dsp48
  PORT MAP (
    CLK => clk,
    SCLR => sclr,
    C => acci_psr(i),
    CONCAT => adc_i_div(i),
    P => acci(i)
  );

gen_q: if (real_only= false) generate 
process(clk)
begin
   if rising_edge(clk) then
   --if rst_n = '0' then
   --   accq(i) <= x"000000";
   --else
   --   accq(i) <= sxt(adc_q((i*16)+15 downto ((i*16)+4)), 24) + accq(i) -  sxt(accq(i)(23 downto 12), 24);
   --end if;  
   accompq(i) <= adc_q((i*16)+15 downto ((i*16)+4)) - accq(i)(23 downto 12);
   if (accompq(i) < 0) then
      absvq(i) <= 0 - accompq(i);
   else
      absvq(i) <= accompq(i);
   end if; 
   if t1_latch_en = '1' then
      avg_absq(i) <= (others => '0');
      rmsq(i) <= avg_absq(i)(25 downto 14);
   else
      avg_absq(i) <= avg_absq(i) + sxt(absvq(i), 26);
   end if;
   if (('0' & rmsq(i)) < 25) then
      freeze_rmsq(i) <= '1';
   else
      freeze_rmsq(i) <= '0';   
   end if; 
   end if; 
end process;

accq_psr(i) <= sxt(accq(i)(23 downto 12), 24);
adc_q_div(i) <= sxt(adc_q((i*16)+15 downto ((i*16)+4)), 24);

-- A+P-C  (C latency = 0)
accq_acc : px_rf_adc_acc_dsp48
  PORT MAP (
    CLK => clk,
    SCLR => sclr,
    C => accq_psr(i),
    CONCAT => adc_q_div(i),
    P => accq(i)
  );
end generate;

gen_no_q: if (real_only= true) generate

freeze_rmsq(i) <= '0';

end generate; 

end generate;

gen_zerotop4: if (max_samples_per_cycle = 4) generate

freeze_rmsi(7 downto 4) <= "0000";
freeze_rmsq(7 downto 4) <= "0000";

end generate; 

gen_zerotop6: if (max_samples_per_cycle = 2) generate

freeze_rmsi(7 downto 2) <= "000000";
freeze_rmsq(7 downto 2) <= "000000";

end generate;

gen_zerotop7: if (max_samples_per_cycle = 1) generate

freeze_rmsi(7 downto 1) <= "0000000";
freeze_rmsq(7 downto 1) <= "0000000";

end generate;  

end Behavioral;
