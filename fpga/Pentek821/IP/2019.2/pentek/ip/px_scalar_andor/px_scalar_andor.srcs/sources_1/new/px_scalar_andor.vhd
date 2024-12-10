----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 02/07/2015 11:10:58 AM
-- Design Name: 
-- Module Name: px_vctr_concat - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: OR of ANDs
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- Simple enable of two inputs and or of results. Generics provide the ability to invert inputs and outputs.
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
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_scalar_andor is
    Generic (
        a_inv    : boolean := false;
        a_en_inv : boolean := false;
        b_inv    : boolean := false;
        b_en_inv : boolean := false;
        o_inv    : boolean := false
    );
    Port ( a    : in STD_LOGIC;
           a_en : in STD_LOGIC;
           b    : in STD_LOGIC;
           b_en : in STD_LOGIC;
           o    : out STD_LOGIC
    );
end px_scalar_andor;


architecture Behavioral of px_scalar_andor is

function To_Std_Logic(L: BOOLEAN) return std_logic is
begin
    if L then
       return('1');
    else
       return('0');
    end if;
end function To_Std_Logic;

constant ainv   : std_logic := To_Std_Logic(a_inv);
constant binv   : std_logic := To_Std_Logic(b_inv);
constant aeninv : std_logic := To_Std_Logic(a_en_inv);
constant beninv : std_logic := To_Std_Logic(b_en_inv);
constant oinv   : std_logic := To_Std_Logic(o_inv);


begin

o <= oinv xor (((ainv xor a) and (aeninv xor a_en)) or ((binv xor b) and (beninv xor b_en)));

end Behavioral;
