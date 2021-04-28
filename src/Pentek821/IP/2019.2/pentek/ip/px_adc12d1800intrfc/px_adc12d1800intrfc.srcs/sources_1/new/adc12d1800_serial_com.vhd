-------------------------------------------------------------------------------
-- ******* Serial Communication Module for ADC12D1800                        --
-------------------------------------------------------------------------------
--  Copyright (c) 2011 Pentek, Inc.  All rights reserved.
-------------------------------------------------------------------------------
-- Title        : ADC Serial Communication Module
-- Project      : 
-------------------------------------------------------------------------------
-- Filename     : 
-- Author       : 
-- Created      : 06/03/2009
-- Last Modified: 05/12/2011
-- Modified by  : 
--                Pentek, Inc.
--                One Park Way
--                Upper Saddle River, NJ  07458
--                (201) 818-5900
--                www.pentek.com
-------------------------------------------------------------------------------
-- ******************************* Change Log ****************************** --
-- 03/24/2009: Created
-- 05/08/2010: Initial Release.
-- 01/13/2011: Renamed and repurposed for use as the ADC SPI interface.
-- 5/12/2011:  Modified in order to account for 16 bit SPI interface on
--             71640 ADC chip.
-------------------------------------------------------------------------------
-- Description:

-- This module provides serial communication to the DAC5688.

-- Repurposed to provides serial communication to the ADS5400.
-------------------------------------------------------------------------------

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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-------------------------------------------------------------------------------
-- Main Entity
-------------------------------------------------------------------------------

entity adc12d1800_serial_com is
port (
   clk       : in  std_logic; 
   rst_n     : in  std_logic;
   data_in   : in  std_logic_vector(15 downto 0);
   addr      : in  std_logic_vector(4 downto 0);
   wr_pls    : in  std_logic;
   rd_pls    : in  std_logic;
   data_out  : out std_logic_vector(15 downto 0);
   sm_rdy    : out std_logic;
   -- adc serial signals
   adc_sdi   : out std_logic;
   adc_sdenb : out std_logic;
   adc_sclk  : out std_logic;
   adc_sdo   : in  std_logic
);
end adc12d1800_serial_com;

architecture Behavioral of adc12d1800_serial_com is

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal ser_clk_cntr  : std_logic_vector(4 downto 0);
signal ser_sr_cntr   : std_logic_vector(4 downto 0);
signal sr_cntr_tc    : std_logic;
signal data_out_sr   : std_logic_vector(24 downto 0);
signal data_in_sr    : std_logic_vector(15 downto 0);
signal rd_strch      : std_logic;
signal wr_strch      : std_logic;
signal r_adc_sdi     : std_logic;
signal r_adc_sdenb   : std_logic;
signal r_adc_sclk    : std_logic;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

begin

-- Create a 7.8125MHz Serial data rate from the 250MHz PCIE clock
process(clk)
begin
   if rising_edge(clk) then
      if (rst_n = '0') then
         ser_clk_cntr <= "00000";
      else   
         ser_clk_cntr <= ser_clk_cntr + 1;
      end if;   
   end if;
end process;

-------------------------------------------------------------------------------
-- Shift Register Cycle Counter
-------------------------------------------------------------------------------
process(clk)
begin
   if rising_edge(clk) then
      if (rst_n = '0') then
         ser_sr_cntr <= "00000";  
      elsif (wr_pls = '1') then
         ser_sr_cntr <= "11001";
      elsif(rd_pls = '1') then 
         ser_sr_cntr <= "11001"; 
      elsif  (ser_sr_cntr /= "00000") and (ser_clk_cntr = "11111") then
         ser_sr_cntr <= ser_sr_cntr - 1;
      end if; 
      if (rst_n = '0') then
         sr_cntr_tc  <= '1';
      elsif (ser_clk_cntr = "11111") then
         if (ser_sr_cntr = "00000") then
            sr_cntr_tc  <= '1';
         else
            sr_cntr_tc  <= '0';
         end if;
      end if;
   end if;
end process;

-------------------------------------------------------------------------------
-- Data Output Shift Register
-------------------------------------------------------------------------------
process(clk)
begin
   if rising_edge(clk) then  
      if (rst_n = '0') then
         data_out_sr(24 downto 0) <= (others => '0');  
      elsif ((rd_pls = '1') or (wr_pls = '1')) then
         data_out_sr(24 downto 0) <= '1' & rd_pls & "10" & addr(3 downto 0) & '0' & data_in;
      elsif (sr_cntr_tc = '0') and (ser_clk_cntr = "11111") then
         data_out_sr(24 downto 0) <= data_out_sr(23 downto 0) & '0';
      end if;
   end if;
end process;

-- Generate Write Ready signal
process(clk)
begin   
   if rising_edge(clk) then
      if (rst_n = '0') then 
         wr_strch <= '0';
      elsif WR_PLS = '1' then
         wr_strch <= '1';
      elsif (ser_sr_cntr = "00000")  and (ser_clk_cntr = "00000") then
         wr_strch <= '0';
      end if;
      if (rst_n = '0') then 
         sm_rdy     <= '1'; 
      else   
         sm_rdy     <= not( wr_strch or rd_strch);
      end if;   
   end if;
end process;

-------------------------------------------------------------------------------
-- Data Input Shift Register
-------------------------------------------------------------------------------
process(clk)
begin
   if rising_edge(clk) then
      if (rst_n = '0') then
         data_in_sr(15 downto 0) <= (others => '0'); 
      elsif (sr_cntr_tc = '0') and (ser_clk_cntr = "11111") then
         data_in_sr(15 downto 0) <= data_in_sr(14 downto 0) & adc_sdo;
      end if;   
   end if; 
end process;

process(clk)
begin
   if rising_edge(clk) then
      if (rst_n = '0') then
         data_out <= (others => '0');
      elsif (ser_sr_cntr = "00000")  and (ser_clk_cntr = "00000") and
         (rd_strch = '1') then
         data_out <= data_in_sr;
      end if;
      if (rst_n = '0') then
         rd_strch <= '0';
      elsif rd_pls = '1' then
         rd_strch <= '1';
      elsif (ser_sr_cntr = "00000")  and (ser_clk_cntr = "00000") then
         rd_strch <= '0';
      end if;
   end if;
end process;

-------------------------------------------------------------------------------
-- Output Signals to DAC
-------------------------------------------------------------------------------
process(clk)
begin
   if rising_edge(clk) then  
      if (rst_n = '0') then
         r_adc_sdi   <= '1';
         r_adc_sdenb <= '1';
      else   
      r_adc_sdi   <= data_out_sr(23);
      r_adc_sdenb <= sr_cntr_tc;
      end if;
      if (rst_n = '0') then
         r_adc_sclk  <= '0';
      elsif (ser_clk_cntr(4) = '1') and (sr_cntr_tc = '0') and
         (ser_sr_cntr /= "00000") then
         r_adc_sclk <= '1';
      else
         r_adc_sclk <= '0';
      end if;
   end if;
end process;


adc_sdi   <= r_adc_sdi;  
adc_sdenb <= r_adc_sdenb;
adc_sclk  <= r_adc_sclk; 


end Behavioral;

