----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/31/2016 10:21:34 AM
-- Design Name: 
-- Module Name: px_axis_pdti2ppkt_16_8bit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Output only top 8 bits of each 16-bit sample in 8 sample per cycle stream
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

entity px_axis_pdti2ppkt_16_8bit is
port (
  aclk               : in  std_logic;
  aresetn            : in  std_logic;
    
  s_axis_pdti_tdata  : in  std_logic_vector(255 downto 0);  
  s_axis_pdti_tuser  : in  std_logic_vector(127 downto 0);
  s_axis_pdti_tvalid : in  std_logic;

  m_axis_pdti_tdata  : out std_logic_vector(255 downto 0);  
  m_axis_pdti_tuser  : out std_logic_vector(127 downto 0);
  m_axis_pdti_tvalid : out std_logic;
  
  mode_8bit          : in  std_logic
 );
end px_axis_pdti2ppkt_16_8bit;

architecture Behavioral of px_axis_pdti2ppkt_16_8bit is

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal tdata_8bit   : std_logic_vector(127 downto 0) := (others => '0');
signal t1_mode_8bit : std_logic := '0';
signal wcnv_tdata   : std_logic_vector(255 downto 0) := (others => '0');
signal wcnv_tuser   : std_logic_vector(255 downto 0) := (others => '0');
signal wcnv_tvalid  : std_logic := '0';



--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------
-- 64-bit to 128-bit Width Converter
COMPONENT px_axis_pdti2ppkt_16_wc
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    s_axis_tuser : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(255 DOWNTO 0);
    m_axis_tuser : OUT STD_LOGIC_VECTOR(255 DOWNTO 0)
  );
END COMPONENT;

--------------------------------------------------------------------------------

begin
              
tdata_8bit <= s_axis_pdti_tdata(255 downto 248) & s_axis_pdti_tdata(239 downto 232) & s_axis_pdti_tdata(223 downto 216) & s_axis_pdti_tdata(207 downto 200) &
              s_axis_pdti_tdata(191 downto 184) & s_axis_pdti_tdata(175 downto 168) & s_axis_pdti_tdata(159 downto 152) & s_axis_pdti_tdata(143 downto 136) &
              s_axis_pdti_tdata(127 downto 120) & s_axis_pdti_tdata(111 downto 104) & s_axis_pdti_tdata(95 downto 88) & s_axis_pdti_tdata(79 downto 72) &
              s_axis_pdti_tdata(63 downto 56) & s_axis_pdti_tdata(47 downto 40) & s_axis_pdti_tdata(31 downto 24) & s_axis_pdti_tdata(15 downto 8);

wc_inst : px_axis_pdti2ppkt_16_wc
port map (
   aclk           => aclk,
   aresetn        => aresetn,
   s_axis_tvalid  => s_axis_pdti_tvalid,
   s_axis_tready  => open,
   s_axis_tdata   => tdata_8bit,
   s_axis_tuser   => s_axis_pdti_tuser,
   m_axis_tvalid  => wcnv_tvalid,
   m_axis_tready  => '1',
   m_axis_tdata   => wcnv_tdata,
   m_axis_tuser   => wcnv_tuser
  );

process(aclk)
begin
   if rising_edge(aclk) then
      t1_mode_8bit <= mode_8bit;
      if t1_mode_8bit = '1' then
         m_axis_pdti_tdata  <= wcnv_tdata;
         m_axis_pdti_tuser(63 downto 0)  <= wcnv_tuser(63 downto 0);
         m_axis_pdti_tuser(71 downto 64) <= wcnv_tuser(198) & wcnv_tuser(196) & wcnv_tuser(194) & wcnv_tuser(192) & wcnv_tuser(70) & wcnv_tuser(68) & wcnv_tuser(66) & wcnv_tuser(64);
         m_axis_pdti_tuser(79 downto 72) <= wcnv_tuser(206) & wcnv_tuser(204) & wcnv_tuser(202) & wcnv_tuser(200) & wcnv_tuser(78) & wcnv_tuser(76) & wcnv_tuser(74) & wcnv_tuser(72);
         m_axis_pdti_tuser(87 downto 80) <= wcnv_tuser(214) & wcnv_tuser(212) & wcnv_tuser(210) & wcnv_tuser(208) & wcnv_tuser(86) & wcnv_tuser(84) & wcnv_tuser(82) & wcnv_tuser(80); 
         m_axis_pdti_tuser(92 downto 88) <= '0' & x"F";
         m_axis_pdti_tuser(95 downto 93) <= "000";
         m_axis_pdti_tuser(127 downto 96)<= wcnv_tuser(127 downto 96);  
         m_axis_pdti_tvalid <= wcnv_tvalid;  
      else
         m_axis_pdti_tdata  <= s_axis_pdti_tdata;
         m_axis_pdti_tuser  <= s_axis_pdti_tuser;
         m_axis_pdti_tvalid <= s_axis_pdti_tvalid;
      end if;
   end if;
end process;

end Behavioral;
