----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 05/17/2016 01:43:26 PM
-- Design Name: 
-- Module Name: px_axis_pdti2ppkt_2_bs - Behavioral
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
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- (c) Copyright 2015 Pentek, Inc. All rights reserved.
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_2chdec2fir_2_bs is
port (
  aclk               : in  std_logic;
  aresetn            : in  std_logic;
  sync_en            : in  std_logic;
  
  s_axis_pdti_tdata  : in  std_logic_vector(63 downto 0);  
  s_axis_pdti_tuser  : in  std_logic_vector(127 downto 0);
  s_axis_pdti_tvalid : in  std_logic;
  
  m_axis_pdti_tdata  : out std_logic_vector(63 downto 0);  
  m_axis_pdti_tuser  : out std_logic_vector(127 downto 0);
  m_axis_pdti_tvalid : out std_logic
);
end px_2chdec2fir_2_bs;

architecture Behavioral of px_2chdec2fir_2_bs is

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal t1_tvalid   :  std_logic := '0'; 
signal t1_in_tdata :  std_logic_vector(63 downto 0) := (others => '0'); 
signal t1_in_tuser :  std_logic_vector(127 downto 0) := (others => '0'); 
signal t2_tvalid   :  std_logic := '0'; 
signal t2_in_tdata :  std_logic_vector(63 downto 0) := (others => '0'); 
signal t2_in_tuser :  std_logic_vector(127 downto 0) := (others => '0'); 
signal t3_in_tdata :  std_logic_vector(63 downto 0) := (others => '0'); 
signal t3_in_tuser :  std_logic_vector(127 downto 0) := (others => '0'); 
signal t4_in_tuser :  std_logic_vector(127 downto 0) := (others => '0'); 
signal t3_bshift   :  std_logic := '0'; 
signal sync_on     :  std_logic := '0';
signal t2_sync     :  std_logic_vector(1 downto 0) := (others => '0');
signal t1_aresetn  :  std_logic := '0';
signal t1_sync_en  :  std_logic := '0';
signal t4_mux_tdata:  std_logic_vector(63 downto 0) := (others => '0'); 
signal t4_mux_tuser:  std_logic_vector(127 downto 0) := (others => '0');

--------------------------------------------------------------------------------
 
begin

t2_sync <= t2_in_tuser(73 downto 72);

process(aclk)
begin
    if rising_edge(aclk) then
        t1_aresetn  <= aresetn;
        t1_sync_en  <= sync_en;
        t1_tvalid   <= s_axis_pdti_tvalid;
        t2_tvalid   <= t1_tvalid; 
        t1_in_tdata <= s_axis_pdti_tdata;
        t1_in_tuser <= s_axis_pdti_tuser;
        if t1_tvalid = '1' then
            t2_in_tdata <= t1_in_tdata;  
            t2_in_tuser <= t1_in_tuser;
            t3_in_tdata <= t2_in_tdata;  
            t3_in_tuser <= t2_in_tuser;
            t4_in_tuser <= t3_in_tuser;
        end if;     
        if t1_aresetn = '0' then
          sync_on   <= '0';
          t3_bshift <= '0';
        elsif t1_tvalid = '1' then
            if t1_sync_en = '1' then -- Sync Enabled
                if sync_on = '0' then
                    case t2_sync is
                        when "00" => 
                            t3_bshift <= '0';
                        when "01" | "11" =>
                            t3_bshift <= '0';
                            sync_on   <= '1';
                        when "10" =>
                            t3_bshift <= '1';
                            sync_on   <= '1';
                        when others =>
                            t3_bshift <= '0';
                    end case; 
                elsif (t2_sync /= "11") then  
                    sync_on <= '0';            
                end if;
            else 
               sync_on   <= '0'; -- Sync is disabled, but hold barrel shift
            end if;    
        end if;                
    end if;                          
end process;

process(aclk)
begin
    if rising_edge(aclk) then
        if t1_tvalid = '1' then
           if  (t3_bshift = '0') then
              t4_mux_tdata <= t3_in_tdata;
              t4_mux_tuser(71 downto 64) <= t3_in_tuser(71 downto 64);
              t4_mux_tuser(79 downto 72) <= t3_in_tuser(79 downto 72);
              t4_mux_tuser(87 downto 80) <= t3_in_tuser(87 downto 80);
           else
              t4_mux_tdata <= t2_in_tdata(31 downto 0) & t3_in_tdata(63 downto 32);
              t4_mux_tuser(71 downto 64) <= "000000" & t2_in_tuser(64) & t3_in_tuser(65);
              t4_mux_tuser(79 downto 72) <= "000000" & t2_in_tuser(72) & t3_in_tuser(73);
              t4_mux_tuser(87 downto 80) <= "000000" & t2_in_tuser(80) & t3_in_tuser(81);
           end if;
        end if;   
   end if;         
end process;

t4_mux_tuser(63 downto 0)   <= t4_in_tuser(63 downto 0);
t4_mux_tuser(127 downto 88) <= t4_in_tuser(127 downto 88);

process(aclk)
begin
    if rising_edge(aclk) then
        m_axis_pdti_tdata  <= t4_mux_tdata;
        m_axis_pdti_tuser  <= t4_mux_tuser;
        m_axis_pdti_tvalid <= t2_tvalid;
    end if;
end process;    

end Behavioral;
