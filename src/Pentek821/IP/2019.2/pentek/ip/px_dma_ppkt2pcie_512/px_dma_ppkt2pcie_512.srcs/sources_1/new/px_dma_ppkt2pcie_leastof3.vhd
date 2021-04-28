----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2016 08:18:31 AM
-- Design Name: 
-- Module Name: px_dma_ppkt2pcie_leastof4 - Behavioral
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

entity px_dma_ppkt2pcie_leastof3 is
    Port ( c : in STD_LOGIC_VECTOR (10 downto 0);
           d : in STD_LOGIC_VECTOR (10 downto 0);
           c_en : in std_logic;
           d_large : in STD_LOGIC;
           x : out STD_LOGIC_VECTOR (10 downto 0);
           index : out STD_LOGIC_VECTOR (1 downto 0)
           );
end px_dma_ppkt2pcie_leastof3;

architecture Behavioral of px_dma_ppkt2pcie_leastof3 is

--------------------------------------------------------------------------------
-- signals
--------------------------------------------------------------------------------

signal cgtb : std_logic := '0';
signal dgtb : std_logic := '0';
signal dgtc : std_logic := '0';
signal clt16: std_logic := '0';
signal dlt16: std_logic := '0';
signal concat: std_logic_vector(1 downto 0) := "00";

--------------------------------------------------------------------------------

begin


clt16 <= '1' when ((('0' & c) <= 16) and (c_en = '1')) else '0';
dlt16 <= '1' when ((('0' & d) <= 16) and  (d_large = '0')) else '0';
--d>c  
dgtc<= '1' when (('0' & d(4 downto 0)) > ('0' & c(4 downto 0))) else '0'; 
  
concat <= dlt16 & clt16;

process(concat,c,d,dgtc )
begin
   case concat is
      when "00" =>
         x <= "00000010000";
         index <= "01";
      when "01" =>
         x <= c;
         index <= "10";
      when "10" =>
         x <= d;
         index <= "11";
      when "11" =>
         if (dgtc = '1') then
            x <= c;
            index <= "10";
         else
            x <= d;
            index <= "11";
         end if; 
      when others =>
        x <= "00000010000";
        index <= "01";
   end case;
end process;



end Behavioral;
