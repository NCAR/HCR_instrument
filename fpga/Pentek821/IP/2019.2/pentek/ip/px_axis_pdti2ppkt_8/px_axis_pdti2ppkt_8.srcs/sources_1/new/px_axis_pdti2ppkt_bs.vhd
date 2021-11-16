----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 05/17/2016 01:43:26 PM
-- Design Name: 
-- Module Name: px_axis_pdti2ppkt_bs - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision ---- - 8/29/19 Added wc_sync_enable - This signal allows the SYNC A signal 
--                         to reset the width converter. When operating in 8-bit mode 
--                         the data flow control core creates 8-bit samples out of the 
--                         incoming stream of 16-bit samples. Resetting this width 
--                         converter using the SYNC signal ensures that the width 
--                         conversion is started simultaneously across different 
--                         channels or boards.  Also gated t2_gate with t3_trig_hold
--                         to prevent data discontinuities.


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

--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axis_pdti2ppkt_bs is
port (
  aclk               : in  std_logic;
  aresetn            : in  std_logic;
  
  s_axis_pdti_tdata  : in  std_logic_vector(127 downto 0);  
  s_axis_pdti_tuser  : in  std_logic_vector(127 downto 0);
  s_axis_pdti_tvalid : in  std_logic;
  
  t3_trig_hold       : in  std_logic;
  m_axis_pdti_tdata  : out std_logic_vector(127 downto 0);  
  m_axis_pdti_tuser  : out std_logic_vector(127 downto 0);
  m_axis_pdti_tvalid : out std_logic
);
end px_axis_pdti2ppkt_bs;

architecture Behavioral of px_axis_pdti2ppkt_bs is

signal t1_tvalid  :  std_logic := '0'; 
signal t1_in_tdata:  std_logic_vector(127 downto 0) := (others => '0'); 
signal t1_in_tuser:  std_logic_vector(127 downto 0) := (others => '0'); 
signal t2_tvalid  :  std_logic := '0'; 
signal t2_in_tdata:  std_logic_vector(127 downto 0) := (others => '0'); 
signal t2_in_tuser:  std_logic_vector(127 downto 0) := (others => '0'); 
signal t3_in_tdata:  std_logic_vector(127 downto 0) := (others => '0'); 
signal t3_in_tuser:  std_logic_vector(127 downto 0) := (others => '0'); 
signal t4_in_tuser:  std_logic_vector(127 downto 0) := (others => '0'); 
signal t3_bshift  :  std_logic_vector(2 downto 0) := (others => '0'); 
signal  gate_on   :  std_logic := '0';
signal t2_gate    :  std_logic_vector(7 downto 0) := (others => '0');
signal t1_aresetn :  std_logic := '0';
signal t1_des_ctl :  std_logic := '0';
signal t1_data_type:  std_logic := '0';
signal t4_mux_tdata:  std_logic_vector(127 downto 0) := (others => '0'); 
signal t4_mux_tuser:  std_logic_vector(127 downto 0) := (others => '0');
 
begin

t2_gate <= t2_in_tuser(71 downto 64) when t3_trig_hold = '0' else (others => '0');

process(aclk)
begin
    if rising_edge(aclk) then
        t1_aresetn  <= aresetn;
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
          gate_on   <= '0';
          t3_bshift <= "000";
        elsif t1_tvalid = '1' then
            if gate_on = '0' then
                if t2_gate = x"00" then
                    --t3_bshift  <= "000";
                    gate_on    <= '0';
                elsif t2_gate(0) = '1' then
                     t3_bshift <= "000";
                     gate_on   <= '1';
                elsif t2_gate(1) = '1' then
                     t3_bshift <= "001";
                     gate_on   <= '1';
                elsif t2_gate(2) = '1' then
                     t3_bshift <= "010";
                     gate_on   <= '1';
                elsif t2_gate(3) = '1' then
                     t3_bshift <= "011";
                     gate_on   <= '1';     
                elsif t2_gate(4) = '1' then
                     t3_bshift <= "100";
                     gate_on   <= '1';
                elsif t2_gate(5) = '1' then
                     t3_bshift <= "101";
                     gate_on   <= '1';
                elsif t2_gate(6) = '1' then
                     t3_bshift <= "110";
                     gate_on   <= '1';
                elsif t2_gate(7) = '1' then
                     t3_bshift <= "111";
                     gate_on   <= '1';                                                                                                 
                end if; 
            elsif (t2_gate /= x"FF") then  
                gate_on <= '0';            
            end if;
        end if;                
    end if;                          
end process;

process(aclk)
begin
    if rising_edge(aclk) then
        if t1_tvalid = '1' then
           case t3_bshift is
               when "000" =>  -- No Shift
                   t4_mux_tdata               <= t3_in_tdata;
                   t4_mux_tuser(71 downto 64) <= t3_in_tuser(71 downto 64);
                   t4_mux_tuser(79 downto 72) <= t3_in_tuser(79 downto 72);
                   t4_mux_tuser(87 downto 80) <= t3_in_tuser(87 downto 80);
               when "001" => -- Shift 1
                   t4_mux_tdata <= t2_in_tdata(15 downto 0) & t3_in_tdata(127 downto 16);
                   t4_mux_tuser(71 downto 64) <= t2_in_tuser(64) & t3_in_tuser(71 downto 65);
                   t4_mux_tuser(79 downto 72) <= t2_in_tuser(72) & t3_in_tuser(79 downto 73);
                   t4_mux_tuser(87 downto 80) <= t2_in_tuser(80) & t3_in_tuser(87 downto 81);
               when "010" => -- Shift 2 
                   t4_mux_tdata <= t2_in_tdata(31 downto 0) & t3_in_tdata(127 downto 32);
                   t4_mux_tuser(71 downto 64) <= t2_in_tuser(65 downto 64) & t3_in_tuser(71 downto 66);
                   t4_mux_tuser(79 downto 72) <= t2_in_tuser(73 downto 72) & t3_in_tuser(79 downto 74);
                   t4_mux_tuser(87 downto 80) <= t2_in_tuser(81 downto 80) & t3_in_tuser(87 downto 82);
               when "011" => -- Shift 3 
                   t4_mux_tdata <= t2_in_tdata(47 downto 0) & t3_in_tdata(127 downto 48);
                   t4_mux_tuser(71 downto 64) <= t2_in_tuser(66 downto 64) & t3_in_tuser(71 downto 67);
                   t4_mux_tuser(79 downto 72) <= t2_in_tuser(74 downto 72) & t3_in_tuser(79 downto 75);
                   t4_mux_tuser(87 downto 80) <= t2_in_tuser(82 downto 80) & t3_in_tuser(87 downto 83);
               when "100" => -- Shift 4 
                   t4_mux_tdata <= t2_in_tdata(63 downto 0) & t3_in_tdata(127 downto 64);
                   t4_mux_tuser(71 downto 64) <= t2_in_tuser(67 downto 64) & t3_in_tuser(71 downto 68);
                   t4_mux_tuser(79 downto 72) <= t2_in_tuser(75 downto 72) & t3_in_tuser(79 downto 76);
                   t4_mux_tuser(87 downto 80) <= t2_in_tuser(83 downto 80) & t3_in_tuser(87 downto 84);
               when "101" => -- Shift 5 
                   t4_mux_tdata <= t2_in_tdata(79 downto 0) & t3_in_tdata(127 downto 80);
                   t4_mux_tuser(71 downto 64) <= t2_in_tuser(68 downto 64) & t3_in_tuser(71 downto 69);
                   t4_mux_tuser(79 downto 72) <= t2_in_tuser(76 downto 72) & t3_in_tuser(79 downto 77);
                   t4_mux_tuser(87 downto 80) <= t2_in_tuser(84 downto 80) & t3_in_tuser(87 downto 85);
               when "110" =>  -- Shift 6  
                   t4_mux_tdata <= t2_in_tdata(95 downto 0) & t3_in_tdata(127 downto 96);
                   t4_mux_tuser(71 downto 64) <= t2_in_tuser(69 downto 64) & t3_in_tuser(71 downto 70);
                   t4_mux_tuser(79 downto 72) <= t2_in_tuser(77 downto 72) & t3_in_tuser(79 downto 78);
                   t4_mux_tuser(87 downto 80) <= t2_in_tuser(85 downto 80) & t3_in_tuser(87 downto 86);
               when "111" =>  -- Shift 7  
                   t4_mux_tdata <= t2_in_tdata(111 downto 0) & t3_in_tdata(127 downto 112);
                   t4_mux_tuser(71 downto 64) <= t2_in_tuser(70 downto 64) & t3_in_tuser(71);
                   t4_mux_tuser(79 downto 72) <= t2_in_tuser(78 downto 72) & t3_in_tuser(79);
                   t4_mux_tuser(87 downto 80) <= t2_in_tuser(86 downto 80) & t3_in_tuser(87);                            
               when others =>
                   t4_mux_tdata <= t2_in_tdata(111 downto 0) & t3_in_tdata(127 downto 112);
                   t4_mux_tuser(71 downto 64) <= t2_in_tuser(70 downto 64) & t3_in_tuser(71);
                   t4_mux_tuser(79 downto 72) <= t2_in_tuser(78 downto 72) & t3_in_tuser(79);
                   t4_mux_tuser(87 downto 80) <= t2_in_tuser(86 downto 80) & t3_in_tuser(87);   
           end case;
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
