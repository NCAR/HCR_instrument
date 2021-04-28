----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 02/24/2015 12:18:14 PM
-- Design Name: 
-- Module Name: px_pwron_rst - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Power On Reset
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

----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_pwron_rst is
generic(
    rst_clk_cycles : integer := 256;
    has_rst_input  : boolean := true;
    has_rst_output : boolean := true;
    has_rst_n_output : boolean := true    
);
port ( 
    clk       : in  std_logic;
    rst_in_n  : in  std_logic;
    rst_out_n : out std_logic := '1';
    rst_out   : out std_logic := '0' 
    );
end px_pwron_rst;

architecture Behavioral of px_pwron_rst is

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of clk: SIGNAL is "xilinx.com:signal:clock:1.0 clk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of clk: SIGNAL is "ASSOCIATED_RESET rst_in_n:rst_out_n:rst_out";

ATTRIBUTE X_INTERFACE_INFO of rst_in_n: SIGNAL is "xilinx.com:signal:reset:1.0 rst_in_n RST";
ATTRIBUTE X_INTERFACE_PARAMETER of rst_in_n: SIGNAL is "POLARITY ACTIVE_LOW";
ATTRIBUTE X_INTERFACE_INFO of rst_out_n: SIGNAL is "xilinx.com:signal:reset:1.0 rst_out_n RST";
ATTRIBUTE X_INTERFACE_PARAMETER of rst_out_n: SIGNAL is "POLARITY ACTIVE_LOW";
ATTRIBUTE X_INTERFACE_INFO of rst_out: SIGNAL is "xilinx.com:signal:reset:1.0 rst_out RST";
ATTRIBUTE X_INTERFACE_PARAMETER of rst_out: SIGNAL is "POLARITY ACTIVE_HIGH";


signal rst_cntr   : integer := 0;
signal rst_in_n_i : std_logic := '0';
 
begin

gen_rst: if (has_rst_input = true) generate
   rst_in_n_i <= rst_in_n;
end generate;

gen_no_rst: if (has_rst_input = false) generate
   rst_in_n_i <= '1';
end generate;

process(clk, rst_in_n_i)
begin
    if (rst_in_n_i = '0') then
       rst_cntr  <= 0; 
       rst_out_n <= '0';         
       rst_out   <= '1';         
    elsif rising_edge(clk) then
       if (rst_cntr /= rst_clk_cycles-1) then
          rst_cntr  <= rst_cntr + 1;
          rst_out_n <= '0';
          rst_out   <= '1';
       else
          rst_out_n <= '1';
          rst_out   <= '0';
       end if;
    end if;
end process;

end Behavioral;
