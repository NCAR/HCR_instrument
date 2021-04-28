----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 09/03/2018 07:44:25 AM
-- Design Name: 
-- Module Name: px_rfsoc_syncbus_intrfc_idelay - Behavioral
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
----------------------------------------------------------------------------------

-- (c) Copyright 2018 Pentek, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Pentek, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Pentek, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND PENTEK HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Pentek shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Pentek had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Pentek products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Pentek products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 

-------------------------------------------------------------------------------
-- Libraries
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;
Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
Library UNISIM;
use UNISIM.vcomponents.all;


entity px_rfsoc_syncbus_intrfc_idelay is
generic (
   refclk_freq                    : real := 500.0
);
port (
   data_in     : in  STD_LOGIC;
   data_out    : out STD_LOGIC;
   delay_val   : in  STD_LOGIC_VECTOR (8 downto 0);
   delay_load  : in  STD_LOGIC;
   clk         : in  STD_LOGIC;
   rst_n       : in  STD_LOGIC
   );
end px_rfsoc_syncbus_intrfc_idelay;

architecture Behavioral of px_rfsoc_syncbus_intrfc_idelay is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

component IDELAYE3
   generic (
      CASCADE : string := "NONE";         -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT: string :=  "COUNT";    -- Units of the DELAY_VALUE (COUNT, TIME)
      DELAY_SRC : string :=  "IDATAIN";    -- Delay input (DATAIN, IDATAIN)
      DELAY_TYPE : string := "VAR_LOAD";     -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE : integer := 0;          -- Input delay value setting
      IS_CLK_INVERTED : std_logic :=  '0';    -- Optional inversion for CLK
      IS_RST_INVERTED : std_logic :=  '0';    -- Optional inversion for RST
      REFCLK_FREQUENCY : real := 500.0; -- IDELAYCTRL clock input frequency in MHz (200.0-2400.0)
      UPDATE_MODE : string :=  "ASYNC";     -- Determines when updates to the delay will take effect (ASYNC, MANUAL, SYNC)
      SIM_DEVICE : string := "ULTRASCALE_PLUS" -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS, ULTRASCALE_PLUS_ES1,
                                        -- ULTRASCALE_PLUS_ES2)
   );
   port (
      CASC_OUT : out std_logic;       -- 1-bit output: Cascade delay output to ODELAY input cascade
      CNTVALUEOUT: out std_logic_vector(8 downto 0); -- 9-bit output: Counter value output
      DATAOUT : out std_logic;        -- 1-bit output: Delayed data output
      CASC_IN : in  std_logic;        -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN : in  std_logic; -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE : in  std_logic;                   -- 1-bit input: Active high enable increment/decrement input
      CLK: in std_logic;                  -- 1-bit input: Clock input
      CNTVALUEIN : in std_logic_vector(8 downto 0);    -- 9-bit input: Counter value input
      DATAIN : in std_logic;           -- 1-bit input: Data input from the IOBUF
      EN_VTC : in std_logic;           -- 1-bit input: Keep delay constant over VT
      IDATAIN : in std_logic;          -- 1-bit input: Data input from the logic
      INC : in std_logic;                  -- 1-bit input: Increment / Decrement tap delay input
      LOAD: in std_logic;               -- 1-bit input: Load DELAY_VALUE input
      RST : in std_logic               -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
end component;

---------------------------------------------------------------------------
-- Signals
---------------------------------------------------------------------------

signal delay_load_re : std_logic := '0';
signal t1_delay_load : std_logic := '0';
signal t1_delay_val : std_logic_vector(8 downto 0) := "000000000";
signal ld_cntr : std_logic_vector(4 downto 0) := "00000";
signal ld: std_logic := '0';

---------------------------------------------------------------------------

begin

process(clk)
begin
   if rising_edge(clk) then
      t1_delay_val <= delay_val;
      if (rst_n = '0') then 
         delay_load_re <= '0';
         t1_delay_load <= '0';
      else
         delay_load_re <= (not t1_delay_load) and delay_load;
         t1_delay_load <= delay_load;
      end if;   
      if (rst_n = '0') or (delay_load_re = '1') then
         ld_cntr <= "00000";
      elsif (ld_cntr /= "11111") then       
         ld_cntr <= ld_cntr + 1;
      end if;   
      if ld_cntr = "10000" then
        ld <= '1';
      else
        ld <= '0';
      end if;
   end if;
end process;

gate_idelaye3_inst : IDELAYE3
   generic map (
      CASCADE => "NONE",         -- Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      DELAY_FORMAT => "COUNT",   -- Units of the DELAY_VALUE (COUNT, TIME)
      DELAY_SRC => "IDATAIN",    -- Delay input (DATAIN, IDATAIN)
      DELAY_TYPE => "VAR_LOAD",  -- Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      DELAY_VALUE => 0,          -- Input delay value setting
      IS_CLK_INVERTED => '0',    -- Optional inversion for CLK
      IS_RST_INVERTED => '0',    -- Optional inversion for RST
      REFCLK_FREQUENCY => refclk_freq, -- IDELAYCTRL clock input frequency in MHz (200.0-2400.0)
      SIM_DEVICE => "ULTRASCALE_PLUS", -- Set the device version (ULTRASCALE, ULTRASCALE_PLUS, ULTRASCALE_PLUS_ES1,
                                 -- ULTRASCALE_PLUS_ES2)
      UPDATE_MODE => "ASYNC"     -- Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                 -- SYNC)
   )
   port map (
      CASC_OUT => open,        -- 1-bit output: Cascade delay output to ODELAY input cascade
      CNTVALUEOUT => open,     -- 9-bit output: Counter value output
      DATAOUT => data_out,     -- 1-bit output: Delayed data output
      CASC_IN => '0',          -- 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      CASC_RETURN => '0',      -- 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      CE => '0',               -- 1-bit input: Active high enable increment/decrement input
      CLK => clk,              -- 1-bit input: Clock input
      CNTVALUEIN => t1_delay_val, -- 9-bit input: Counter value input
      DATAIN => '0',           -- 1-bit input: Data input from the IOBUF
      EN_VTC => '0',           -- 1-bit input: Keep delay constant over VT
      IDATAIN => data_in,      -- 1-bit input: Data input from the logic
      INC => '0',              -- 1-bit input: Increment / Decrement tap delay input
      LOAD => ld,              -- 1-bit input: Load DELAY_VALUE input
      RST => '0'               -- 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );


end Behavioral;
