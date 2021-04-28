----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 05/07/2015 02:46:14 PM
-- Design Name: 
-- Module Name: px_lvl_trans_xclk - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Passes a level transition across a clock domain boundary
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

entity px_lvl_trans_xclk is
port ( 
    in_clk      : in  std_logic;
    in_sig      : in  std_logic;
    out_sig     : out std_logic;
    out_clk     : in  std_logic
);
end px_lvl_trans_xclk;

architecture Behavioral of px_lvl_trans_xclk is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

component px_lvl_trans_xclk_async_fifo 
generic (
    DWIDTH  : integer := 1;
    ENTRIES : integer := 16
    );
port (
   -- interface for shift_in side
   si_clk      : in  std_logic;
   si_res_n    : in  std_logic;
   shift_in    : in  std_logic;
   d_in        : in  std_logic_vector(DWIDTH-1 downto 0);

   full        : out std_logic;
   almost_full : out std_logic;
   -- interface for shift_out side
   so_clk      : in  std_logic;
   so_res_n    : in  std_logic;
   shift_out   : in  std_logic;

   d_out       : out  std_logic_vector(DWIDTH-1 downto 0);
   empty       : out std_logic;
   almost_empty: out std_logic
);
end component;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal out_rst_n     : std_logic := '0'; 
signal in_rst_n      : std_logic := '0'; 
signal t1_in_rst_n   : std_logic := '0'; 
signal in_rst_fe     : std_logic := '0';
signal t1_in_sig     : std_logic := '0';    
signal t2_in_sig     : std_logic := '0';    
signal in_sig_event  : std_logic := '0';
signal t1_full       : std_logic := '0';
signal full          : std_logic := '0';
signal full_fe       : std_logic := '0'; 
signal empty         : std_logic := '0'; 
signal dout          : std_logic_vector(0 downto 0) := "0";
signal shift_out     : std_logic := '0';
signal in_rst_cntr   : std_logic_vector(1 downto 0) := "00";
signal out_rst_cntr  : std_logic_vector(1 downto 0) := "00";

--------------------------------------------------------------------------------

begin

process(in_clk)
begin
    if rising_edge(in_clk) then
        if in_rst_cntr /= "11" then
            in_rst_cntr <= in_rst_cntr + 1;
        end if;
        in_rst_n <= in_rst_cntr(0) and in_rst_cntr(1);
    end if;
end process;         

process(out_clk)
begin
    if rising_edge(out_clk) then
        if out_rst_cntr /= "11" then
            out_rst_cntr <= out_rst_cntr + 1;
        end if;
        out_rst_n <= out_rst_cntr(0) and out_rst_cntr(1);
    end if;
end process;  

process(in_clk)
begin
    if rising_edge(in_clk) then
        t1_in_rst_n   <= in_rst_n;
        in_rst_fe     <= (not t1_in_rst_n) and in_rst_n;  
        t1_in_sig     <= in_sig;
        t2_in_sig     <= t1_in_sig;
        t1_full       <= full;
        full_fe       <= (not full) and t1_full;
    end if;
end process;     

in_sig_event  <= ((t1_in_sig xor t2_in_sig) and t1_in_rst_n) or in_rst_fe or full_fe;

async_fifo_inst: px_lvl_trans_xclk_async_fifo 
generic map(
    DWIDTH  => 1,
    ENTRIES => 16
    )
port map (
   -- interface for shift_in side
   si_clk      => in_clk,
   si_res_n    => in_rst_n,
   shift_in    => in_sig_event,
   d_in(0)     => t1_in_sig,

   full        => full,
   almost_full => open,
   -- interface for shift_out side
   so_clk      => out_clk,
   so_res_n    => out_rst_n,
   shift_out   => shift_out,

   d_out       => dout,
   empty       => empty,
   almost_empty=> open
);


shift_out <= not empty;


process(out_clk)
begin
    if rising_edge(out_clk) then
        if (out_rst_n = '0') then
           out_sig       <= '0';
        elsif (empty = '0') then
           out_sig       <= dout(0);
        end if;     
    end if;
end process;     

end Behavioral;
