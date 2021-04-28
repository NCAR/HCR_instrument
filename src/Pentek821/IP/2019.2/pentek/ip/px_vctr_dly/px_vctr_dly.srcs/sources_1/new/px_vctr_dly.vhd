----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 05/16/2015 11:32:29 AM
-- Design Name: 
-- Module Name: px_vctr_dly - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Vector Delay
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

--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_vctr_dly is
generic (
    width   : integer := 32;    -- Width of vector
    delay   : integer := 8;     -- delay value (1 or greater)
    has_ce  : boolean := false; -- Has Clock Enable
    has_rst : boolean := false  -- Has Reset  
);
port (
    clk  : in  std_logic;      
    rst_n: in  std_logic;      
    ce   : in  std_logic;
    din  : in  std_logic_vector (width-1 downto 0);
    dout : out std_logic_vector (width-1 downto 0)
);
end px_vctr_dly;

architecture Behavioral of px_vctr_dly is

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

constant zeros : std_logic_vector(width-1 downto 0) := (others => '0');

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

type vector_array is array (0 to delay-1) of std_logic_vector(width-1 downto 0);
type one_array is array (0 to 0) of std_logic_vector(width-1 downto 0);
--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal dly_array : vector_array;
signal int_ce    : std_logic := '0';
signal int_rst_n : std_logic := '0';
signal din_v     : one_array;

--------------------------------------------------------------------------------

begin

gen_has_rst: if (has_rst = true) generate
    int_rst_n <= rst_n;
end generate;

gen_has_norst: if (has_rst = false) generate
    int_rst_n <= '1';
end generate;

gen_has_ce: if (has_ce = true) generate
    int_ce <= ce;
end generate;

gen_has_noce: if (has_ce = false) generate
    int_ce <= '1';
end generate;

din_v(0)(width-1 downto 0) <=  din(width-1 downto 0); 

gen_gt1: if (delay > 1) generate
process(clk)
begin
    if rising_edge(clk) then
        if int_rst_n = '0' then
            dly_array(0 to delay-1) <= (others => zeros);
        elsif int_ce = '1' then
            dly_array(0 to delay-1) <= dly_array(1 to delay-1) & din_v(0);
        end if;
    end if;
end process;
end generate;

gen_eq1: if (delay = 1) generate
process(clk)
begin
    if rising_edge(clk) then
        if int_rst_n = '0' then
            dly_array(0) <= (others => '0');
        elsif int_ce = '1' then
            dly_array(0) <= din_v(0);
        end if;
    end if;
end process;
end generate;


dout(width-1 downto 0) <= dly_array(0)(width-1 downto 0);


end Behavioral;
