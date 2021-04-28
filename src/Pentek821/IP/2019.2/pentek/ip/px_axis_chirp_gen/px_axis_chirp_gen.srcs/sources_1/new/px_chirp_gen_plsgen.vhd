----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/14/2017 01:10:49 PM
-- Design Name: 
-- Module Name: px_chirp_gen_plsgen - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Pulse Generation for Chirp Generator
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 1.1 - Fixed Trig Hold Mode (length = 0)
-- Additional Comments:
-- latency = 4 ce
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_chirp_gen_plsgen is
generic (
    samples_per_cycle : integer := 4
);
port ( 
    clk         : in std_logic;
    rstn        : in std_logic;
    trig_clr    : in std_logic;
    trig_in     : in std_logic;
    gate_in     : in std_logic;
    gate_mode   : in std_logic;
    pulse_width : in std_logic_vector(31 downto 0);
    ce          : in std_logic;
    gate_out    : out std_logic;
    gate_out_re : out std_logic;
    gate_in_fe  : out std_logic
);
end px_chirp_gen_plsgen;

architecture Behavioral of px_chirp_gen_plsgen is

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal t1_trig_clr : std_logic := '0';
signal t2_trig_clr : std_logic := '0';
signal t1_gate_mode: std_logic := '0';
signal t2_gate_mode: std_logic := '0';
signal t3_gate_mode: std_logic := '0';
signal t2_trig_ld: std_logic := '0';
signal t1_gate_in: std_logic := '0';
signal t2_gate_in: std_logic := '0';
signal t3_gate_in: std_logic := '0';
signal t4_gate_in: std_logic := '0';
signal t1_trig_in: std_logic := '0';
signal t2_trig_re: std_logic := '0';
signal trig_cntr : std_logic_vector(31 downto 0) := x"00000000";
signal t3_trig_gate: std_logic := '0';
signal t4_trig_gate: std_logic := '0';
signal t1_pulse_width_val: std_logic_vector(31 downto 0) := x"00000000";
signal t2_pulse_width_val: std_logic_vector(31 downto 0) := x"00000000";

begin

gen_pw1: if (samples_per_cycle = 1) generate
process(clk)
begin
    if rising_edge(clk) then
        if ce = '1' then
            t1_pulse_width_val <= pulse_width(31 downto 0);
        end if;
    end if;    
end process;         
end generate;

gen_pw2: if (samples_per_cycle = 2) generate
process(clk)
begin
    if rising_edge(clk) then
        if ce = '1' then
            t1_pulse_width_val <= '0' & pulse_width(31 downto 1); 
        end if;
    end if;    
end process;  
   
end generate;

gen_pw4: if (samples_per_cycle = 4) generate
process(clk)
begin
    if rising_edge(clk) then
        if ce = '1' then
            t1_pulse_width_val <= "00" & pulse_width(31 downto 2); 
        end if;
    end if;    
end process;  
   
end generate;

gen_pw8: if (samples_per_cycle = 8) generate
process(clk)
begin
    if rising_edge(clk) then
        if ce = '1' then
            t1_pulse_width_val <= "000" & pulse_width(31 downto 3); 
        end if;
    end if;    
end process;  
   
end generate;

process(clk)
begin
    if rising_edge(clk) then
        if ce = '1' then
            t2_pulse_width_val <= t1_pulse_width_val;
            t1_trig_in   <= trig_in and not gate_mode;
            t2_trig_re   <= (trig_in and not gate_mode) and not t1_trig_in; 
            t1_trig_clr  <= trig_clr;
            t2_trig_clr  <= t1_trig_clr;
            t1_gate_mode <= gate_mode;
            t2_gate_mode <= t1_gate_mode;
            t3_gate_mode <= t2_gate_mode;
            t1_gate_in   <= gate_in;
            t2_gate_in   <= t1_gate_in;
            t3_gate_in   <= t2_gate_in;
            if gate_mode = '0' then
                gate_in_fe <= t1_trig_in and not trig_in; 
            else
                gate_in_fe <= t1_gate_in and not gate_in; 
            end if;
            if (t2_trig_clr = '1') or (rstn = '0') then
                trig_cntr <= x"00000000";
            elsif (t2_trig_re = '1') then
                trig_cntr <= t2_pulse_width_val;
            elsif (trig_cntr /= x"00000000")then
                trig_cntr <= trig_cntr - 1;   
            end if;
            if (t2_pulse_width_val = x"00000000") then
               if (t2_trig_clr = '1') or (rstn = '0') then
                   t3_trig_gate <= '0';
               --elsif (t2_trig_ld = '1') then
               elsif (t2_trig_re = '1') then
                   t3_trig_gate <= not t2_gate_mode;
               end if;    
            else
                if (trig_cntr =  x"00000000") or (rstn = '0') then
                    t3_trig_gate <= '0'; 
                else
                    t3_trig_gate <= not t2_gate_mode;
                end if;    
            end if;    
            if (t3_gate_mode = '1') then
                gate_out <= t3_gate_in;
                gate_out_re <= t3_gate_in and not t4_gate_in;
            else
                gate_out <= t3_trig_gate;
                gate_out_re <= t3_trig_gate and not t4_trig_gate;
            end if;
            t4_gate_in <= t3_gate_in;
            t4_trig_gate <= t3_trig_gate;
         end if;
    end if;
end process;    


end Behavioral;
