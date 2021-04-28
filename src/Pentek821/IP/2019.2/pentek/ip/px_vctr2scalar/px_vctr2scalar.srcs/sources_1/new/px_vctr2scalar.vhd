----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 02/07/2015 10:23:45 AM
-- Design Name: 
-- Module Name: px_vctr2_scalar - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: One bit vector to scalar
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

entity px_vctr2scalar is
generic (
   synchronize      : boolean := false; -- synchronize input to clk or delay
   num_sync_ff      : integer := 2;     -- number of synchronization flip-flops or delays (0 is invalid)
   has_srst         : boolean := false; -- Only has effect when synchronize = true  
   val_at_rst_low   : boolean := true;  -- Value at reset. Only has effect when synchronize = true and has_srst = true
   srst_active_high : boolean := false;  -- Only has effect when synchronize = true and has_srst = true
   invert           : boolean := false  -- invert output
);
port (
   input_vector   : in  std_logic_vector (0 downto 0);
   output_scalar  : out std_logic;
   clk            : in  std_logic;
   srst           : in  std_logic
);
end px_vctr2scalar;

architecture Behavioral of px_vctr2scalar is

signal in_scalar: std_logic := '0';
signal rst_x    : std_logic := '0';
signal rst      : std_logic := '0';
signal ff_dly   : std_logic_vector(num_sync_ff-1 downto 0) := (others => '0');
 
begin

in_scalar <= input_vector(0) when (invert = false) else (not input_vector(0));

gen_no_sync: if (synchronize = false) generate   
output_scalar <= in_scalar;
end generate gen_no_sync;

gen_sync: if (synchronize = true) generate

rst_x <= srst when (srst_active_high = true) else not srst;
rst   <= rst_x when  (has_srst = true) else '0';

gen_1ff: if (num_sync_ff = 1) generate
process(clk)
begin
   if rising_edge(clk) then
      if (rst = '1') then
         if (val_at_rst_low = true) then
            ff_dly(0) <= '0';
         else
            ff_dly(0) <= '1';
         end if;   
      else
         ff_dly(0) <= in_scalar;
      end if;
   end if;
end process;
end generate;

gen_xff: if (num_sync_ff > 1) generate 
process(clk)
begin
   if rising_edge(clk) then
      if (rst = '1') then
         if (val_at_rst_low = true) then
            ff_dly <= (others => '0');
         else
            ff_dly <= (others => '1');
         end if;   
      else
         ff_dly(num_sync_ff-1 downto 0) <= ff_dly(num_sync_ff-2 downto 0) & in_scalar;
      end if;
   end if;
end process;
end generate;

output_scalar <= ff_dly(num_sync_ff-1);
  
 
end generate gen_sync;

end Behavioral;
