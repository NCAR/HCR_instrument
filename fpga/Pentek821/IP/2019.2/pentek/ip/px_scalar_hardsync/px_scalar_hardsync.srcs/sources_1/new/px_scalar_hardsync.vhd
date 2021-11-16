----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 05/12/2015 10:34:04 AM
-- Design Name: 
-- Module Name: px_scalar_hardsync - Behavioral
-- Project Name: 
-- Target Devices: Kintex Ultrascale
-- Tool Versions: 
-- Description: HARD SYNC resynchronization FF stage (2 or 3 FF)
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

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity px_scalar_hardsync is
generic (
    INIT            : std_logic := '0';  -- Init Value '0' or '1'        
    IS_CLK_INVERTED : boolean := false;
    LATENCY         : integer := 2  -- 2 or 3
);
port (
    clk  : in  std_logic;
    din  : in  std_logic;
    dout : out std_logic
);
end px_scalar_hardsync;

architecture Behavioral of px_scalar_hardsync is

constant INIT_bit : bit := to_bit(INIT); 

begin

gen_clk_ninv: if (IS_CLK_INVERTED = false) generate

HARD_SYNC_inst : HARD_SYNC
   generic map (
      INIT            => INIT_bit,     -- Initial values, '0', '1'
      IS_CLK_INVERTED => '0',      -- Programmable inversion on CLK input
      LATENCY         => LATENCY   -- 2-3
   )
   port map (
      DOUT => dout, -- 1-bit output: Data
      CLK  => clk,  -- 1-bit input: Clock
      DIN  => din   -- 1-bit input: Data
   );

end generate;

gen_clk_inv: if (IS_CLK_INVERTED = true) generate

HARD_SYNC_inst : HARD_SYNC
   generic map (
      INIT            => INIT_bit,     -- Initial values, '0', '1'
      IS_CLK_INVERTED => '1',      -- Programmable inversion on CLK input
      LATENCY         => LATENCY   -- 2-3
   )
   port map (
      DOUT => dout, -- 1-bit output: Data
      CLK  => clk,  -- 1-bit input: Clock
      DIN  => din   -- 1-bit input: Data
   );

end generate;

end Behavioral;
