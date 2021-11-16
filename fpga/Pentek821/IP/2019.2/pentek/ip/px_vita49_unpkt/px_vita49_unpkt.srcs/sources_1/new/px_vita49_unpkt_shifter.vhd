----------------------------------------------------------------------------------
-- Company:  Pentek 
-- Engineer: Michael Fernandez
-- 
-- Create Date: 9/28/2017
-- Design Name: px_vita49_unpkt_shifter
-- Module Name: px_vita49_unpkt_shifter
-- Project Name: px_vita49_unpkt
-- Target Devices: Kintex Ultrascale
-- Tool Versions: Vivado 2017.2
-- Description: Shifts words with keep label of 0
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 

-- (Additional Info)

----------------------------------------------------------------------------------

-- (Technical Support for Pentek's GateFlow FPGA Design Kits)  
-- Technical support for Pentek's GateFlow FPGA Design Kits is available via e-mail 
-- (fpgasupport@pentek.com) or by phone (201-818-5900 ext. 238, 9 AM to 5 PM US 
-- Eastern time.) Names or initials contained within the source code are part of 
-- our revision control regime.  Please do not try to use these references to 
-- pursue technical support                              

-- (c) Copyright 2017 Pentek, Inc. All rights reserved.
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

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_TEXTIO.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use ieee.numeric_std.all;

entity px_vita49_unpkt_shifter is
  port (
    aclk          : in  std_logic;
    aresetn       : in  std_logic;
    aclken        : in  std_logic;
    keep_label    : in  std_logic_vector(7 downto 0);
    s_axis_tvalid : in  std_logic;
    s_axis_tready : out std_logic;
    s_axis_tdata  : in  std_logic_vector(255 downto 0);
    s_axis_tkeep  : in  std_logic_vector(31 downto 0);
    s_axis_tlast  : in  std_logic;
    m_axis_tvalid : out std_logic;
    m_axis_tready : in  std_logic;
    m_axis_tdata  : out std_logic_vector(255 downto 0);
    m_axis_tkeep  : out std_logic_vector(31 downto 0);
    m_axis_tlast  : out std_logic
    );
end px_vita49_unpkt_shifter;


architecture behavioral of px_vita49_unpkt_shifter is

  signal keep_label_p1    : std_logic_vector(7 downto 0);
  signal keep_label_p2    : std_logic_vector(7 downto 0);
  signal keep_label_p3    : std_logic_vector(7 downto 0);
  signal keep_label_p4    : std_logic_vector(7 downto 0);
  signal keep_label_p5    : std_logic_vector(7 downto 0);
  signal keep_label_p6    : std_logic_vector(7 downto 0);
  signal keep_label_p7    : std_logic_vector(7 downto 0);
  signal keep_label_p8    : std_logic_vector(7 downto 0);
  signal s_axis_tvalid_p1 : std_logic;
  signal s_axis_tvalid_p2 : std_logic;
  signal s_axis_tvalid_p3 : std_logic;
  signal s_axis_tvalid_p4 : std_logic;
  signal s_axis_tvalid_p5 : std_logic;
  signal s_axis_tvalid_p6 : std_logic;
  signal s_axis_tvalid_p7 : std_logic;
  signal s_axis_tvalid_p8 : std_logic;
  signal s_axis_tdata_p1  : std_logic_vector(255 downto 0);
  signal s_axis_tdata_p2  : std_logic_vector(255 downto 0);
  signal s_axis_tdata_p3  : std_logic_vector(255 downto 0);
  signal s_axis_tdata_p4  : std_logic_vector(255 downto 0);
  signal s_axis_tdata_p5  : std_logic_vector(255 downto 0);
  signal s_axis_tdata_p6  : std_logic_vector(255 downto 0);
  signal s_axis_tdata_p7  : std_logic_vector(255 downto 0);
  signal s_axis_tdata_p8  : std_logic_vector(255 downto 0);
  signal s_axis_tkeep_p1  : std_logic_vector(31 downto 0);
  signal s_axis_tkeep_p2  : std_logic_vector(31 downto 0);
  signal s_axis_tkeep_p3  : std_logic_vector(31 downto 0);
  signal s_axis_tkeep_p4  : std_logic_vector(31 downto 0);
  signal s_axis_tkeep_p5  : std_logic_vector(31 downto 0);
  signal s_axis_tkeep_p6  : std_logic_vector(31 downto 0);
  signal s_axis_tkeep_p7  : std_logic_vector(31 downto 0);
  signal s_axis_tkeep_p8  : std_logic_vector(31 downto 0);
  signal s_axis_tlast_p1  : std_logic;
  signal s_axis_tlast_p2  : std_logic;
  signal s_axis_tlast_p3  : std_logic;
  signal s_axis_tlast_p4  : std_logic;
  signal s_axis_tlast_p5  : std_logic;
  signal s_axis_tlast_p6  : std_logic;
  signal s_axis_tlast_p7  : std_logic;
  signal s_axis_tlast_p8  : std_logic;

begin

  shift_label_p1 : process(aclk, aresetn, aclken)
  begin
    if aresetn = '0' then
      keep_label_p1    <= (others => '0');
      s_axis_tvalid_p1 <= '0';
      s_axis_tlast_p1  <= '0';
      s_axis_tdata_p1  <= (others => '0');
      s_axis_tkeep_p1  <= (others => '0');
    elsif rising_edge(aclk) and aclken = '1' and m_axis_tready = '1' then
      if s_axis_tvalid = '1' then
        s_axis_tvalid_p1 <= s_axis_tvalid;
        s_axis_tlast_p1  <= s_axis_tlast;
        if keep_label(0) = '0' then
          keep_label_p1   <= "1" & keep_label(7 downto 1);
          s_axis_tdata_p1 <= x"00000000" & s_axis_tdata(255 downto 32);
          s_axis_tkeep_p1 <= x"0" & s_axis_tkeep(31 downto 4);
        elsif keep_label(1) = '0' then
          keep_label_p1   <= "1" & keep_label(7 downto 2) & keep_label(0);
          s_axis_tdata_p1 <= x"00000000" & s_axis_tdata(255 downto 64) & s_axis_tdata(31 downto 0);
          s_axis_tkeep_p1 <= x"0" & s_axis_tkeep(31 downto 8) & s_axis_tkeep(3 downto 0);
        elsif keep_label(2) = '0' then
          keep_label_p1   <= "1" & keep_label(7 downto 3) & keep_label(1 downto 0);
          s_axis_tdata_p1 <= x"00000000" & s_axis_tdata(255 downto 96) & s_axis_tdata(63 downto 0);
          s_axis_tkeep_p1 <= x"0" & s_axis_tkeep(31 downto 12) & s_axis_tkeep(7 downto 0);
        elsif keep_label(3) = '0' then
          keep_label_p1   <= "1" & keep_label(7 downto 4) & keep_label(2 downto 0);
          s_axis_tdata_p1 <= x"00000000" & s_axis_tdata(255 downto 128) & s_axis_tdata(95 downto 0);
          s_axis_tkeep_p1 <= x"0" & s_axis_tkeep(31 downto 16) & s_axis_tkeep(11 downto 0);
        elsif keep_label(4) = '0' then
          keep_label_p1   <= "1" & keep_label(7 downto 5) & keep_label(3 downto 0);
          s_axis_tdata_p1 <= x"00000000" & s_axis_tdata(255 downto 160) & s_axis_tdata(127 downto 0);
          s_axis_tkeep_p1 <= x"0" & s_axis_tkeep(31 downto 20) & s_axis_tkeep(15 downto 0);
        elsif keep_label(5) = '0' then
          keep_label_p1   <= "1" & keep_label(7 downto 6) & keep_label(4 downto 0);
          s_axis_tdata_p1 <= x"00000000" & s_axis_tdata(255 downto 192) & s_axis_tdata(159 downto 0);
          s_axis_tkeep_p1 <= x"0" & s_axis_tkeep(31 downto 24) & s_axis_tkeep(19 downto 0);
        elsif keep_label(6) = '0' then
          keep_label_p1   <= "1" & keep_label(7) & keep_label(5 downto 0);
          s_axis_tdata_p1 <= x"00000000" & s_axis_tdata(255 downto 224) & s_axis_tdata(191 downto 0);
          s_axis_tkeep_p1 <= x"0" & s_axis_tkeep(31 downto 28) & s_axis_tkeep(23 downto 0);
        elsif keep_label(7) = '0' then
          keep_label_p1   <= "1" & keep_label(6 downto 0);
          s_axis_tdata_p1 <= x"00000000" & s_axis_tdata(223 downto 0);
          s_axis_tkeep_p1 <= x"0" & s_axis_tkeep(27 downto 0);
        else
          keep_label_p1   <= keep_label;
          s_axis_tdata_p1 <= s_axis_tdata;
          s_axis_tkeep_p1 <= s_axis_tkeep;
        end if;
      else
        s_axis_tvalid_p1 <= s_axis_tvalid;
        s_axis_tlast_p1  <= s_axis_tlast;
        keep_label_p1    <= keep_label;
        s_axis_tdata_p1  <= s_axis_tdata;
        s_axis_tkeep_p1  <= s_axis_tkeep;
      end if;
    end if;
  end process;

  shift_label_p2 : process(aclk, aresetn, aclken)
  begin
    if aresetn = '0' then
      keep_label_p2    <= (others => '0');
      s_axis_tvalid_p2 <= '0';
      s_axis_tlast_p2  <= '0';
      s_axis_tdata_p2  <= (others => '0');
      s_axis_tkeep_p2  <= (others => '0');
    elsif rising_edge(aclk) and aclken = '1' and m_axis_tready = '1' then
      if s_axis_tvalid_p1 = '1' then
        s_axis_tvalid_p2 <= s_axis_tvalid_p1;
        s_axis_tlast_p2  <= s_axis_tlast_p1;
        if keep_label_p1(0) = '0' then
          keep_label_p2   <= "1" & keep_label_p1(7 downto 1);
          s_axis_tdata_p2 <= x"00000000" & s_axis_tdata_p1(255 downto 32);
          s_axis_tkeep_p2 <= x"0" & s_axis_tkeep_p1(31 downto 4);
        elsif keep_label_p1(1) = '0' then
          keep_label_p2   <= "1" & keep_label_p1(7 downto 2) & keep_label_p1(0);
          s_axis_tdata_p2 <= x"00000000" & s_axis_tdata_p1(255 downto 64) & s_axis_tdata_p1(31 downto 0);
          s_axis_tkeep_p2 <= x"0" & s_axis_tkeep_p1(31 downto 8) & s_axis_tkeep_p1(3 downto 0);
        elsif keep_label_p1(2) = '0' then
          keep_label_p2   <= "1" & keep_label_p1(7 downto 3) & keep_label_p1(1 downto 0);
          s_axis_tdata_p2 <= x"00000000" & s_axis_tdata_p1(255 downto 96) & s_axis_tdata_p1(63 downto 0);
          s_axis_tkeep_p2 <= x"0" & s_axis_tkeep_p1(31 downto 12) & s_axis_tkeep_p1(7 downto 0);
        elsif keep_label_p1(3) = '0' then
          keep_label_p2   <= "1" & keep_label_p1(7 downto 4) & keep_label_p1(2 downto 0);
          s_axis_tdata_p2 <= x"00000000" & s_axis_tdata_p1(255 downto 128) & s_axis_tdata_p1(95 downto 0);
          s_axis_tkeep_p2 <= x"0" & s_axis_tkeep_p1(31 downto 16) & s_axis_tkeep_p1(11 downto 0);
        elsif keep_label_p1(4) = '0' then
          keep_label_p2   <= "1" & keep_label_p1(7 downto 5) & keep_label_p1(3 downto 0);
          s_axis_tdata_p2 <= x"00000000" & s_axis_tdata_p1(255 downto 160) & s_axis_tdata_p1(127 downto 0);
          s_axis_tkeep_p2 <= x"0" & s_axis_tkeep_p1(31 downto 20) & s_axis_tkeep_p1(15 downto 0);
        elsif keep_label_p1(5) = '0' then
          keep_label_p2   <= "1" & keep_label_p1(7 downto 6) & keep_label_p1(4 downto 0);
          s_axis_tdata_p2 <= x"00000000" & s_axis_tdata_p1(255 downto 192) & s_axis_tdata_p1(159 downto 0);
          s_axis_tkeep_p2 <= x"0" & s_axis_tkeep_p1(31 downto 24) & s_axis_tkeep_p1(19 downto 0);
        elsif keep_label_p1(6) = '0' then
          keep_label_p2   <= "1" & keep_label_p1(7) & keep_label_p1(5 downto 0);
          s_axis_tdata_p2 <= x"00000000" & s_axis_tdata_p1(255 downto 224) & s_axis_tdata_p1(191 downto 0);
          s_axis_tkeep_p2 <= x"0" & s_axis_tkeep_p1(31 downto 28) & s_axis_tkeep_p1(23 downto 0);
        elsif keep_label_p1(7) = '0' then
          keep_label_p2   <= "1" & keep_label_p1(6 downto 0);
          s_axis_tdata_p2 <= x"00000000" & s_axis_tdata_p1(223 downto 0);
          s_axis_tkeep_p2 <= x"0" & s_axis_tkeep_p1(27 downto 0);
        else
          keep_label_p2   <= keep_label_p1;
          s_axis_tdata_p2 <= s_axis_tdata_p1;
          s_axis_tkeep_p2 <= s_axis_tkeep_p1;
        end if;
      else
        keep_label_p2    <= keep_label_p1;
        s_axis_tvalid_p2 <= s_axis_tvalid_p1;
        s_axis_tlast_p2  <= s_axis_tlast_p1;
        s_axis_tdata_p2  <= s_axis_tdata_p1;
        s_axis_tkeep_p2  <= s_axis_tkeep_p1;
      end if;
    end if;
  end process;

  shift_label_p3 : process(aclk, aresetn, aclken)
  begin
    if aresetn = '0' then
      keep_label_p3    <= (others => '0');
      s_axis_tvalid_p3 <= '0';
      s_axis_tlast_p3  <= '0';
      s_axis_tdata_p3  <= (others => '0');
      s_axis_tkeep_p3  <= (others => '0');
    elsif rising_edge(aclk) and aclken = '1' and m_axis_tready = '1' then
      if s_axis_tvalid_p2 = '1' then
        s_axis_tvalid_p3 <= s_axis_tvalid_p2;
        s_axis_tlast_p3  <= s_axis_tlast_p2;
        if keep_label_p2(0) = '0' then
          keep_label_p3   <= "1" & keep_label_p2(7 downto 1);
          s_axis_tdata_p3 <= x"00000000" & s_axis_tdata_p2(255 downto 32);
          s_axis_tkeep_p3 <= x"0" & s_axis_tkeep_p2(31 downto 4);
        elsif keep_label_p2(1) = '0' then
          keep_label_p3   <= "1" & keep_label_p2(7 downto 2) & keep_label_p2(0);
          s_axis_tdata_p3 <= x"00000000" & s_axis_tdata_p2(255 downto 64) & s_axis_tdata_p2(31 downto 0);
          s_axis_tkeep_p3 <= x"0" & s_axis_tkeep_p2(31 downto 8) & s_axis_tkeep_p2(3 downto 0);
        elsif keep_label_p2(2) = '0' then
          keep_label_p3   <= "1" & keep_label_p2(7 downto 3) & keep_label_p2(1 downto 0);
          s_axis_tdata_p3 <= x"00000000" & s_axis_tdata_p2(255 downto 96) & s_axis_tdata_p2(63 downto 0);
          s_axis_tkeep_p3 <= x"0" & s_axis_tkeep_p2(31 downto 12) & s_axis_tkeep_p2(7 downto 0);
        elsif keep_label_p2(3) = '0' then
          keep_label_p3   <= "1" & keep_label_p2(7 downto 4) & keep_label_p2(2 downto 0);
          s_axis_tdata_p3 <= x"00000000" & s_axis_tdata_p2(255 downto 128) & s_axis_tdata_p2(95 downto 0);
          s_axis_tkeep_p3 <= x"0" & s_axis_tkeep_p2(31 downto 16) & s_axis_tkeep_p2(11 downto 0);
        elsif keep_label_p2(4) = '0' then
          keep_label_p3   <= "1" & keep_label_p2(7 downto 5) & keep_label_p2(3 downto 0);
          s_axis_tdata_p3 <= x"00000000" & s_axis_tdata_p2(255 downto 160) & s_axis_tdata_p2(127 downto 0);
          s_axis_tkeep_p3 <= x"0" & s_axis_tkeep_p2(31 downto 20) & s_axis_tkeep_p2(15 downto 0);
        elsif keep_label_p2(5) = '0' then
          keep_label_p3   <= "1" & keep_label_p2(7 downto 6) & keep_label_p2(4 downto 0);
          s_axis_tdata_p3 <= x"00000000" & s_axis_tdata_p2(255 downto 192) & s_axis_tdata_p2(159 downto 0);
          s_axis_tkeep_p3 <= x"0" & s_axis_tkeep_p2(31 downto 24) & s_axis_tkeep_p2(19 downto 0);
        elsif keep_label_p2(6) = '0' then
          keep_label_p3   <= "1" & keep_label_p2(7) & keep_label_p2(5 downto 0);
          s_axis_tdata_p3 <= x"00000000" & s_axis_tdata_p2(255 downto 224) & s_axis_tdata_p2(191 downto 0);
          s_axis_tkeep_p3 <= x"0" & s_axis_tkeep_p2(31 downto 28) & s_axis_tkeep_p2(23 downto 0);
        elsif keep_label_p2(7) = '0' then
          keep_label_p3   <= "1" & keep_label_p2(6 downto 0);
          s_axis_tdata_p3 <= x"00000000" & s_axis_tdata_p2(223 downto 0);
          s_axis_tkeep_p3 <= x"0" & s_axis_tkeep_p2(27 downto 0);
        else
          keep_label_p3   <= keep_label_p2;
          s_axis_tdata_p3 <= s_axis_tdata_p2;
          s_axis_tkeep_p3 <= s_axis_tkeep_p2;
        end if;
      else
        keep_label_p3    <= keep_label_p2;
        s_axis_tvalid_p3 <= s_axis_tvalid_p2;
        s_axis_tlast_p3  <= s_axis_tlast_p2;
        s_axis_tdata_p3  <= s_axis_tdata_p2;
        s_axis_tkeep_p3  <= s_axis_tkeep_p2;
      end if;
    end if;
  end process;

  shift_label_p4 : process(aclk, aresetn, aclken)
  begin
    if aresetn = '0' then
      keep_label_p4    <= (others => '0');
      s_axis_tvalid_p4 <= '0';
      s_axis_tlast_p4  <= '0';
      s_axis_tdata_p4  <= (others => '0');
      s_axis_tkeep_p4  <= (others => '0');
    elsif rising_edge(aclk) and aclken = '1' and m_axis_tready = '1' then
      if s_axis_tvalid_p3 = '1' then
        s_axis_tvalid_p4 <= s_axis_tvalid_p3;
        s_axis_tlast_p4  <= s_axis_tlast_p3;
        if keep_label_p3(0) = '0' then
          keep_label_p4   <= "1" & keep_label_p3(7 downto 1);
          s_axis_tdata_p4 <= x"00000000" & s_axis_tdata_p3(255 downto 32);
          s_axis_tkeep_p4 <= x"0" & s_axis_tkeep_p3(31 downto 4);
        elsif keep_label_p3(1) = '0' then
          keep_label_p4   <= "1" & keep_label_p3(7 downto 2) & keep_label_p3(0);
          s_axis_tdata_p4 <= x"00000000" & s_axis_tdata_p3(255 downto 64) & s_axis_tdata_p3(31 downto 0);
          s_axis_tkeep_p4 <= x"0" & s_axis_tkeep_p3(31 downto 8) & s_axis_tkeep_p3(3 downto 0);
        elsif keep_label_p3(2) = '0' then
          keep_label_p4   <= "1" & keep_label_p3(7 downto 3) & keep_label_p3(1 downto 0);
          s_axis_tdata_p4 <= x"00000000" & s_axis_tdata_p3(255 downto 96) & s_axis_tdata_p3(63 downto 0);
          s_axis_tkeep_p4 <= x"0" & s_axis_tkeep_p3(31 downto 12) & s_axis_tkeep_p3(7 downto 0);
        elsif keep_label_p3(3) = '0' then
          keep_label_p4   <= "1" & keep_label_p3(7 downto 4) & keep_label_p3(2 downto 0);
          s_axis_tdata_p4 <= x"00000000" & s_axis_tdata_p3(255 downto 128) & s_axis_tdata_p3(95 downto 0);
          s_axis_tkeep_p4 <= x"0" & s_axis_tkeep_p3(31 downto 16) & s_axis_tkeep_p3(11 downto 0);
        elsif keep_label_p3(4) = '0' then
          keep_label_p4   <= "1" & keep_label_p3(7 downto 5) & keep_label_p3(3 downto 0);
          s_axis_tdata_p4 <= x"00000000" & s_axis_tdata_p3(255 downto 160) & s_axis_tdata_p3(127 downto 0);
          s_axis_tkeep_p4 <= x"0" & s_axis_tkeep_p3(31 downto 20) & s_axis_tkeep_p3(15 downto 0);
        elsif keep_label_p3(5) = '0' then
          keep_label_p4   <= "1" & keep_label_p3(7 downto 6) & keep_label_p3(4 downto 0);
          s_axis_tdata_p4 <= x"00000000" & s_axis_tdata_p3(255 downto 192) & s_axis_tdata_p3(159 downto 0);
          s_axis_tkeep_p4 <= x"0" & s_axis_tkeep_p3(31 downto 24) & s_axis_tkeep_p3(19 downto 0);
        elsif keep_label_p3(6) = '0' then
          keep_label_p4   <= "1" & keep_label_p3(7) & keep_label_p3(5 downto 0);
          s_axis_tdata_p4 <= x"00000000" & s_axis_tdata_p3(255 downto 224) & s_axis_tdata_p3(191 downto 0);
          s_axis_tkeep_p4 <= x"0" & s_axis_tkeep_p3(31 downto 28) & s_axis_tkeep_p3(23 downto 0);
        elsif keep_label_p3(7) = '0' then
          keep_label_p4   <= "1" & keep_label_p3(6 downto 0);
          s_axis_tdata_p4 <= x"00000000" & s_axis_tdata_p3(223 downto 0);
          s_axis_tkeep_p4 <= x"0" & s_axis_tkeep_p3(27 downto 0);
        else
          keep_label_p4   <= keep_label_p3;
          s_axis_tdata_p4 <= s_axis_tdata_p3;
          s_axis_tkeep_p4 <= s_axis_tkeep_p3;
        end if;
      else
        keep_label_p4    <= keep_label_p3;
        s_axis_tvalid_p4 <= s_axis_tvalid_p3;
        s_axis_tlast_p4  <= s_axis_tlast_p3;
        s_axis_tdata_p4  <= s_axis_tdata_p3;
        s_axis_tkeep_p4  <= s_axis_tkeep_p3;
      end if;
    end if;
  end process;

  shift_label_p5 : process(aclk, aresetn, aclken)
  begin
    if aresetn = '0' then
      keep_label_p5    <= (others => '0');
      s_axis_tvalid_p5 <= '0';
      s_axis_tlast_p5  <= '0';
      s_axis_tdata_p5  <= (others => '0');
      s_axis_tkeep_p5  <= (others => '0');
    elsif rising_edge(aclk) and aclken = '1' and m_axis_tready = '1' then
      if s_axis_tvalid_p4 = '1' then
        s_axis_tvalid_p5 <= s_axis_tvalid_p4;
        s_axis_tlast_p5  <= s_axis_tlast_p4;
        if keep_label_p4(0) = '0' then
          keep_label_p5   <= "1" & keep_label_p4(7 downto 1);
          s_axis_tdata_p5 <= x"00000000" & s_axis_tdata_p4(255 downto 32);
          s_axis_tkeep_p5 <= x"0" & s_axis_tkeep_p4(31 downto 4);
        elsif keep_label_p4(1) = '0' then
          keep_label_p5   <= "1" & keep_label_p4(7 downto 2) & keep_label_p4(0);
          s_axis_tdata_p5 <= x"00000000" & s_axis_tdata_p4(255 downto 64) & s_axis_tdata_p4(31 downto 0);
          s_axis_tkeep_p5 <= x"0" & s_axis_tkeep_p4(31 downto 8) & s_axis_tkeep_p4(3 downto 0);
        elsif keep_label_p4(2) = '0' then
          keep_label_p5   <= "1" & keep_label_p4(7 downto 3) & keep_label_p4(1 downto 0);
          s_axis_tdata_p5 <= x"00000000" & s_axis_tdata_p4(255 downto 96) & s_axis_tdata_p4(63 downto 0);
          s_axis_tkeep_p5 <= x"0" & s_axis_tkeep_p4(31 downto 12) & s_axis_tkeep_p4(7 downto 0);
        elsif keep_label_p4(3) = '0' then
          keep_label_p5   <= "1" & keep_label_p4(7 downto 4) & keep_label_p4(2 downto 0);
          s_axis_tdata_p5 <= x"00000000" & s_axis_tdata_p4(255 downto 128) & s_axis_tdata_p4(95 downto 0);
          s_axis_tkeep_p5 <= x"0" & s_axis_tkeep_p4(31 downto 16) & s_axis_tkeep_p4(11 downto 0);
        elsif keep_label_p4(4) = '0' then
          keep_label_p5   <= "1" & keep_label_p4(7 downto 5) & keep_label_p4(3 downto 0);
          s_axis_tdata_p5 <= x"00000000" & s_axis_tdata_p4(255 downto 160) & s_axis_tdata_p4(127 downto 0);
          s_axis_tkeep_p5 <= x"0" & s_axis_tkeep_p4(31 downto 20) & s_axis_tkeep_p4(15 downto 0);
        elsif keep_label_p4(5) = '0' then
          keep_label_p5   <= "1" & keep_label_p4(7 downto 6) & keep_label_p4(4 downto 0);
          s_axis_tdata_p5 <= x"00000000" & s_axis_tdata_p4(255 downto 192) & s_axis_tdata_p4(159 downto 0);
          s_axis_tkeep_p5 <= x"0" & s_axis_tkeep_p4(31 downto 24) & s_axis_tkeep_p4(19 downto 0);
        elsif keep_label_p4(6) = '0' then
          keep_label_p5   <= "1" & keep_label_p4(7) & keep_label_p4(5 downto 0);
          s_axis_tdata_p5 <= x"00000000" & s_axis_tdata_p4(255 downto 224) & s_axis_tdata_p4(191 downto 0);
          s_axis_tkeep_p5 <= x"0" & s_axis_tkeep_p4(31 downto 28) & s_axis_tkeep_p4(23 downto 0);
        elsif keep_label_p4(7) = '0' then
          keep_label_p5   <= "1" & keep_label_p4(6 downto 0);
          s_axis_tdata_p5 <= x"00000000" & s_axis_tdata_p4(223 downto 0);
          s_axis_tkeep_p5 <= x"0" & s_axis_tkeep_p4(27 downto 0);
        else
          keep_label_p5   <= keep_label_p4;
          s_axis_tdata_p5 <= s_axis_tdata_p4;
          s_axis_tkeep_p5 <= s_axis_tkeep_p4;
        end if;
      else
        keep_label_p5    <= keep_label_p4;
        s_axis_tvalid_p5 <= s_axis_tvalid_p4;
        s_axis_tlast_p5  <= s_axis_tlast_p4;
        s_axis_tdata_p5  <= s_axis_tdata_p4;
        s_axis_tkeep_p5  <= s_axis_tkeep_p4;
      end if;
    end if;
  end process;

  shift_label_p6 : process(aclk, aresetn, aclken)
  begin
    if aresetn = '0' then
      keep_label_p6    <= (others => '0');
      s_axis_tvalid_p6 <= '0';
      s_axis_tlast_p6  <= '0';
      s_axis_tdata_p6  <= (others => '0');
      s_axis_tkeep_p6  <= (others => '0');
    elsif rising_edge(aclk) and aclken = '1' and m_axis_tready = '1' then
      if s_axis_tvalid_p5 = '1' then
        s_axis_tvalid_p6 <= s_axis_tvalid_p5;
        s_axis_tlast_p6  <= s_axis_tlast_p5;
        if keep_label_p5(0) = '0' then
          keep_label_p6   <= "1" & keep_label_p5(7 downto 1);
          s_axis_tdata_p6 <= x"00000000" & s_axis_tdata_p5(255 downto 32);
          s_axis_tkeep_p6 <= x"0" & s_axis_tkeep_p5(31 downto 4);
        elsif keep_label_p5(1) = '0' then
          keep_label_p6   <= "1" & keep_label_p5(7 downto 2) & keep_label_p5(0);
          s_axis_tdata_p6 <= x"00000000" & s_axis_tdata_p5(255 downto 64) & s_axis_tdata_p5(31 downto 0);
          s_axis_tkeep_p6 <= x"0" & s_axis_tkeep_p5(31 downto 8) & s_axis_tkeep_p5(3 downto 0);
        elsif keep_label_p5(2) = '0' then
          keep_label_p6   <= "1" & keep_label_p5(7 downto 3) & keep_label_p5(1 downto 0);
          s_axis_tdata_p6 <= x"00000000" & s_axis_tdata_p5(255 downto 96) & s_axis_tdata_p5(63 downto 0);
          s_axis_tkeep_p6 <= x"0" & s_axis_tkeep_p5(31 downto 12) & s_axis_tkeep_p5(7 downto 0);
        elsif keep_label_p5(3) = '0' then
          keep_label_p6   <= "1" & keep_label_p5(7 downto 4) & keep_label_p5(2 downto 0);
          s_axis_tdata_p6 <= x"00000000" & s_axis_tdata_p5(255 downto 128) & s_axis_tdata_p5(95 downto 0);
          s_axis_tkeep_p6 <= x"0" & s_axis_tkeep_p5(31 downto 16) & s_axis_tkeep_p5(11 downto 0);
        elsif keep_label_p5(4) = '0' then
          keep_label_p6   <= "1" & keep_label_p5(7 downto 5) & keep_label_p5(3 downto 0);
          s_axis_tdata_p6 <= x"00000000" & s_axis_tdata_p5(255 downto 160) & s_axis_tdata_p5(127 downto 0);
          s_axis_tkeep_p6 <= x"0" & s_axis_tkeep_p5(31 downto 20) & s_axis_tkeep_p5(15 downto 0);
        elsif keep_label_p5(5) = '0' then
          keep_label_p6   <= "1" & keep_label_p5(7 downto 6) & keep_label_p5(4 downto 0);
          s_axis_tdata_p6 <= x"00000000" & s_axis_tdata_p5(255 downto 192) & s_axis_tdata_p5(159 downto 0);
          s_axis_tkeep_p6 <= x"0" & s_axis_tkeep_p5(31 downto 24) & s_axis_tkeep_p5(19 downto 0);
        elsif keep_label_p5(6) = '0' then
          keep_label_p6   <= "1" & keep_label_p5(7) & keep_label_p5(5 downto 0);
          s_axis_tdata_p6 <= x"00000000" & s_axis_tdata_p5(255 downto 224) & s_axis_tdata_p5(191 downto 0);
          s_axis_tkeep_p6 <= x"0" & s_axis_tkeep_p5(31 downto 28) & s_axis_tkeep_p5(23 downto 0);
        elsif keep_label_p5(7) = '0' then
          keep_label_p6   <= "1" & keep_label_p5(6 downto 0);
          s_axis_tdata_p6 <= x"00000000" & s_axis_tdata_p5(223 downto 0);
          s_axis_tkeep_p6 <= x"0" & s_axis_tkeep_p5(27 downto 0);
        else
          keep_label_p6   <= keep_label_p5;
          s_axis_tdata_p6 <= s_axis_tdata_p5;
          s_axis_tkeep_p6 <= s_axis_tkeep_p5;
        end if;
      else
        keep_label_p6    <= keep_label_p5;
        s_axis_tvalid_p6 <= s_axis_tvalid_p5;
        s_axis_tlast_p6  <= s_axis_tlast_p5;
        s_axis_tdata_p6  <= s_axis_tdata_p5;
        s_axis_tkeep_p6  <= s_axis_tkeep_p5;
      end if;
    end if;
  end process;

  shift_label_p7 : process(aclk, aresetn, aclken)
  begin
    if aresetn = '0' then
      keep_label_p7    <= (others => '0');
      s_axis_tvalid_p7 <= '0';
      s_axis_tlast_p7  <= '0';
      s_axis_tdata_p7  <= (others => '0');
      s_axis_tkeep_p7  <= (others => '0');
    elsif rising_edge(aclk) and aclken = '1' and m_axis_tready = '1' then
      if s_axis_tvalid_p6 = '1' then
        s_axis_tvalid_p7 <= s_axis_tvalid_p6;
        s_axis_tlast_p7  <= s_axis_tlast_p6;
        if keep_label_p6(0) = '0' then
          keep_label_p7   <= "1" & keep_label_p6(7 downto 1);
          s_axis_tdata_p7 <= x"00000000" & s_axis_tdata_p6(255 downto 32);
          s_axis_tkeep_p7 <= x"0" & s_axis_tkeep_p6(31 downto 4);
        elsif keep_label_p6(1) = '0' then
          keep_label_p7   <= "1" & keep_label_p6(7 downto 2) & keep_label_p6(0);
          s_axis_tdata_p7 <= x"00000000" & s_axis_tdata_p6(255 downto 64) & s_axis_tdata_p6(31 downto 0);
          s_axis_tkeep_p7 <= x"0" & s_axis_tkeep_p6(31 downto 8) & s_axis_tkeep_p6(3 downto 0);
        elsif keep_label_p6(2) = '0' then
          keep_label_p7   <= "1" & keep_label_p6(7 downto 3) & keep_label_p6(1 downto 0);
          s_axis_tdata_p7 <= x"00000000" & s_axis_tdata_p6(255 downto 96) & s_axis_tdata_p6(63 downto 0);
          s_axis_tkeep_p7 <= x"0" & s_axis_tkeep_p6(31 downto 12) & s_axis_tkeep_p6(7 downto 0);
        elsif keep_label_p6(3) = '0' then
          keep_label_p7   <= "1" & keep_label_p6(7 downto 4) & keep_label_p6(2 downto 0);
          s_axis_tdata_p7 <= x"00000000" & s_axis_tdata_p6(255 downto 128) & s_axis_tdata_p6(95 downto 0);
          s_axis_tkeep_p7 <= x"0" & s_axis_tkeep_p6(31 downto 16) & s_axis_tkeep_p6(11 downto 0);
        elsif keep_label_p6(4) = '0' then
          keep_label_p7   <= "1" & keep_label_p6(7 downto 5) & keep_label_p6(3 downto 0);
          s_axis_tdata_p7 <= x"00000000" & s_axis_tdata_p6(255 downto 160) & s_axis_tdata_p6(127 downto 0);
          s_axis_tkeep_p7 <= x"0" & s_axis_tkeep_p6(31 downto 20) & s_axis_tkeep_p6(15 downto 0);
        elsif keep_label_p6(5) = '0' then
          keep_label_p7   <= "1" & keep_label_p6(7 downto 6) & keep_label_p6(4 downto 0);
          s_axis_tdata_p7 <= x"00000000" & s_axis_tdata_p6(255 downto 192) & s_axis_tdata_p6(159 downto 0);
          s_axis_tkeep_p7 <= x"0" & s_axis_tkeep_p6(31 downto 24) & s_axis_tkeep_p6(19 downto 0);
        elsif keep_label_p6(6) = '0' then
          keep_label_p7   <= "1" & keep_label_p6(7) & keep_label_p6(5 downto 0);
          s_axis_tdata_p7 <= x"00000000" & s_axis_tdata_p6(255 downto 224) & s_axis_tdata_p6(191 downto 0);
          s_axis_tkeep_p7 <= x"0" & s_axis_tkeep_p6(31 downto 28) & s_axis_tkeep_p6(23 downto 0);
        elsif keep_label_p6(7) = '0' then
          keep_label_p7   <= "1" & keep_label_p6(6 downto 0);
          s_axis_tdata_p7 <= x"00000000" & s_axis_tdata_p6(223 downto 0);
          s_axis_tkeep_p7 <= x"0" & s_axis_tkeep_p6(27 downto 0);
        else
          keep_label_p7   <= keep_label_p6;
          s_axis_tdata_p7 <= s_axis_tdata_p6;
          s_axis_tkeep_p7 <= s_axis_tkeep_p6;
        end if;
      else
        keep_label_p7    <= keep_label_p6;
        s_axis_tvalid_p7 <= s_axis_tvalid_p6;
        s_axis_tlast_p7  <= s_axis_tlast_p6;
        s_axis_tdata_p7  <= s_axis_tdata_p6;
        s_axis_tkeep_p7  <= s_axis_tkeep_p6;
      end if;
    end if;
  end process;

  shift_label_p8 : process(aclk, aresetn, aclken)
  begin
    if aresetn = '0' then
      keep_label_p8    <= (others => '0');
      s_axis_tvalid_p8 <= '0';
      s_axis_tlast_p8  <= '0';
      s_axis_tdata_p8  <= (others => '0');
      s_axis_tkeep_p8  <= (others => '0');
    elsif rising_edge(aclk) and aclken = '1' and m_axis_tready = '1' then
      if s_axis_tvalid_p7 = '1' then
        s_axis_tvalid_p8 <= s_axis_tvalid_p7;
        s_axis_tlast_p8  <= s_axis_tlast_p7;
        if keep_label_p7(0) = '0' then
          keep_label_p8   <= "1" & keep_label_p7(7 downto 1);
          s_axis_tdata_p8 <= x"00000000" & s_axis_tdata_p7(255 downto 32);
          s_axis_tkeep_p8 <= x"0" & s_axis_tkeep_p7(31 downto 4);
        elsif keep_label_p7(1) = '0' then
          keep_label_p8   <= "1" & keep_label_p7(7 downto 2) & keep_label_p7(0);
          s_axis_tdata_p8 <= x"00000000" & s_axis_tdata_p7(255 downto 64) & s_axis_tdata_p7(31 downto 0);
          s_axis_tkeep_p8 <= x"0" & s_axis_tkeep_p7(31 downto 8) & s_axis_tkeep_p7(3 downto 0);
        elsif keep_label_p7(2) = '0' then
          keep_label_p8   <= "1" & keep_label_p7(7 downto 3) & keep_label_p7(1 downto 0);
          s_axis_tdata_p8 <= x"00000000" & s_axis_tdata_p7(255 downto 96) & s_axis_tdata_p7(63 downto 0);
          s_axis_tkeep_p8 <= x"0" & s_axis_tkeep_p7(31 downto 12) & s_axis_tkeep_p7(7 downto 0);
        elsif keep_label_p7(3) = '0' then
          keep_label_p8   <= "1" & keep_label_p7(7 downto 4) & keep_label_p7(2 downto 0);
          s_axis_tdata_p8 <= x"00000000" & s_axis_tdata_p7(255 downto 128) & s_axis_tdata_p7(95 downto 0);
          s_axis_tkeep_p8 <= x"0" & s_axis_tkeep_p7(31 downto 16) & s_axis_tkeep_p7(11 downto 0);
        elsif keep_label_p7(4) = '0' then
          keep_label_p8   <= "1" & keep_label_p7(7 downto 5) & keep_label_p7(3 downto 0);
          s_axis_tdata_p8 <= x"00000000" & s_axis_tdata_p7(255 downto 160) & s_axis_tdata_p7(127 downto 0);
          s_axis_tkeep_p8 <= x"0" & s_axis_tkeep_p7(31 downto 20) & s_axis_tkeep_p7(15 downto 0);
        elsif keep_label_p7(5) = '0' then
          keep_label_p8   <= "1" & keep_label_p7(7 downto 6) & keep_label_p7(4 downto 0);
          s_axis_tdata_p8 <= x"00000000" & s_axis_tdata_p7(255 downto 192) & s_axis_tdata_p7(159 downto 0);
          s_axis_tkeep_p8 <= x"0" & s_axis_tkeep_p7(31 downto 24) & s_axis_tkeep_p7(19 downto 0);
        elsif keep_label_p7(6) = '0' then
          keep_label_p8   <= "1" & keep_label_p7(7) & keep_label_p7(5 downto 0);
          s_axis_tdata_p8 <= x"00000000" & s_axis_tdata_p7(255 downto 224) & s_axis_tdata_p7(191 downto 0);
          s_axis_tkeep_p8 <= x"0" & s_axis_tkeep_p7(31 downto 28) & s_axis_tkeep_p7(23 downto 0);
        elsif keep_label_p7(7) = '0' then
          keep_label_p8   <= "1" & keep_label_p7(6 downto 0);
          s_axis_tdata_p8 <= x"00000000" & s_axis_tdata_p7(223 downto 0);
          s_axis_tkeep_p8 <= x"0" & s_axis_tkeep_p7(27 downto 0);
        else
          keep_label_p8   <= keep_label_p7;
          s_axis_tdata_p8 <= s_axis_tdata_p7;
          s_axis_tkeep_p8 <= s_axis_tkeep_p7;
        end if;
      else
        keep_label_p8    <= keep_label_p7;
        s_axis_tvalid_p8 <= s_axis_tvalid_p7;
        s_axis_tlast_p8  <= s_axis_tlast_p7;
        s_axis_tdata_p8  <= s_axis_tdata_p7;
        s_axis_tkeep_p8  <= s_axis_tkeep_p7;
      end if;
    end if;
  end process;

  s_axis_tready <= m_axis_tready;
  m_axis_tvalid <= s_axis_tvalid_p8 when s_axis_tkeep_p8 /= x"00000000"                                                               else '0';
  m_axis_tlast  <= '1'              when s_axis_tkeep_p8 /= x"FFFFFFFF" and s_axis_tkeep_p8 /= x"00000000" and s_axis_tvalid_p8 = '1' else '0';
  m_axis_tdata  <= s_axis_tdata_p8;
  m_axis_tkeep  <= s_axis_tkeep_p8;


end Behavioral;

