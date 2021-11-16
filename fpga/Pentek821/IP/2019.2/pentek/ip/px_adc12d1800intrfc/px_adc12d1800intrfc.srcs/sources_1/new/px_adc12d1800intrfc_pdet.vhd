----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 09/21/2016 08:26:57 AM
-- Design Name: 
-- Module Name: px_adc12d1800intrfc_pdet - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: ADC12D1800 Test Pattern Detector
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

-- (c) Copyright 2016 Pentek, Inc. All rights reserved.
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
use IEEE.STD_LOGIC_SIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_adc12d1800intrfc_pdet is
port ( 
   i_data   : in  std_logic_vector(11 downto 0);
   q_data   : in  std_logic_vector(11 downto 0);
   id_data  : in  std_logic_vector(11 downto 0);
   qd_data  : in  std_logic_vector(11 downto 0);
   clk      : in  std_logic;
   rst_n    : in  std_logic;
   start_pls: in  std_logic;
   error_out: out std_logic 
);
end px_adc12d1800intrfc_pdet;

architecture Behavioral of px_adc12d1800intrfc_pdet is

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

type state_type is (
   START_STATE,
   A1_STATE,
   B1_STATE,
   A2_STATE,
   B2_STATE,
   A3_STATE,
   AX_STATE,
   ERROR_STATE
);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal state : state_type := START_STATE;
signal started : std_logic := '0';
signal t1_i : std_logic_vector(11 downto 0) := (others => '0');
signal t1_q : std_logic_vector(11 downto 0) := (others => '0');
signal t1_id : std_logic_vector(11 downto 0) := (others => '0');
signal t1_qd : std_logic_vector(11 downto 0) := (others => '0');
signal t2_i_is_a : std_logic := '0';
signal t2_q_is_a : std_logic := '0';
signal t2_id_is_a : std_logic := '0';
signal t2_qd_is_a : std_logic := '0';
signal t2_i_is_b : std_logic := '0';
signal t2_q_is_b : std_logic := '0';
signal t2_id_is_b : std_logic := '0';
signal t2_qd_is_b : std_logic := '0';
signal t3_is_a : std_logic := '0';
signal t3_is_b : std_logic := '0';
signal t4_is_a : std_logic := '0';

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

-- Test Pattern Values
constant ia : std_logic_vector(11 downto 0) := x"010";
constant ib : std_logic_vector(11 downto 0) := x"FEF";
constant qa : std_logic_vector(11 downto 0) := x"008";
constant qb : std_logic_vector(11 downto 0) := x"FF7";
constant ida : std_logic_vector(11 downto 0) := x"004";
constant idb : std_logic_vector(11 downto 0) := x"FFB";
constant qda : std_logic_vector(11 downto 0) := x"000";
constant qdb : std_logic_vector(11 downto 0) := x"FFF";

--------------------------------------------------------------------------------

begin

--pattern ababaababaa...

process(clk)
begin
   if rising_edge(clk) then
      t1_i <= i_data;
      t1_q <= q_data;
      t1_id <= id_data;
      t1_qd <= qd_data;
      if (t1_i = ia) then
         t2_i_is_a <= '1';
      else
         t2_i_is_a <= '0';
      end if;    
      if (t1_q = qa) then
         t2_q_is_a <= '1';
      else
         t2_q_is_a <= '0';
      end if;
      if (t1_id = ida) then
         t2_id_is_a <= '1';
      else
         t2_id_is_a <= '0';
      end if;    
      if (t1_qd = qda) then
         t2_qd_is_a <= '1';
      else
         t2_qd_is_a <= '0';
      end if;   
      if (t1_i = ib) then
         t2_i_is_b <= '1';
      else
         t2_i_is_b <= '0';
      end if;    
      if (t1_q = qb) then
         t2_q_is_b <= '1';
      else
         t2_q_is_b <= '0';
      end if;
      if (t1_id = idb) then
         t2_id_is_b <= '1';
      else
         t2_id_is_b <= '0';
      end if;    
      if (t1_qd = qdb) then
         t2_qd_is_b <= '1';
      else
         t2_qd_is_b <= '0';
      end if;  
      t3_is_a <= t2_i_is_a and t2_q_is_a and t2_id_is_a and t2_qd_is_a;
      t3_is_b <= t2_i_is_b and t2_q_is_b and t2_id_is_b and t2_qd_is_b;
      t4_is_a <= t3_is_a;
   end if;
end process;   

process(clk)
begin
   if rising_edge(clk) then
      if rst_n = '0' then
         state     <= START_STATE;
         error_out <= '0';
         started   <= '0';
      else
         case state is
            when START_STATE =>
               error_out <= '0';
               if (start_pls = '1') or (started = '1') then
                  if (t3_is_a = '1') and (t4_is_a = '1') then -- Sync to pattern ababaababaa
                     state   <= A1_STATE;
                     started <= '0';
                  elsif (t3_is_a = '0') and (t3_is_b = '0') then -- not valid cal pattern data 
                     state   <= ERROR_STATE;
                  else   -- valid cal data but not synced to pattern yet
                     started <= '1';
                     state   <= START_STATE;
                  end if;
               else
                  state <= START_STATE;
               end if;
            when A1_STATE => 
               if start_pls = '1' then
                  started   <= '1';
                  state     <= START_STATE;
               elsif (t3_is_b = '1') then
                  state <= B1_STATE;
               else
                  state <= ERROR_STATE;
               end if;
            when B1_STATE =>
               if start_pls = '1' then
                  started   <= '1';
                  state     <= START_STATE;
               elsif (t3_is_a = '1') then
                  state <= A2_STATE;
               else
                  state <= ERROR_STATE;
               end if;            
            when A2_STATE =>
               if start_pls = '1' then
                  started   <= '1';
                  state     <= START_STATE;
               elsif (t3_is_b = '1') then
                  state <= B2_STATE;
               else
                  state <= ERROR_STATE;
               end if; 
            when B2_STATE =>
               if start_pls = '1' then
                  started   <= '1';
                  state     <= START_STATE;
               elsif (t3_is_a = '1') then
                  state <= A3_STATE;
               else
                  state <= ERROR_STATE;
               end if; 
            when A3_STATE =>
               if start_pls = '1' then
                  started   <= '1';
                  state     <= START_STATE;
               elsif (t3_is_a = '1') then
                  state <= A1_STATE;
               else
                  state <= ERROR_STATE;
               end if; 
            when ERROR_STATE =>
               if start_pls = '1' then
                  started   <= '1';
                  state     <= START_STATE;
                  error_out <= '0';
               else
                  started   <= '0';
                  state     <= ERROR_STATE;
                  error_out <= '1';
               end if;
            when others =>
               state    <= START_STATE;
         end case;
      end if; 
   end if;
end process;   


end Behavioral;
