----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 02/24/2016 10:54:19 AM
-- Design Name: 
-- Module Name: px_axis_compose - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Compose and AXI bus from its component signals
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

entity px_axis_compose is
generic (
   tdata_width : integer := 16;
   tuser_width : integer := 16;
   has_tuser   : boolean := false;
   has_tready  : boolean := false;
   has_tlast   : boolean := false 
);
port ( 
   aclk : in STD_LOGIC;
   aresetn : in STD_LOGIC;
   s_axis_tdata : in STD_LOGIC_VECTOR (tdata_width-1 downto 0);
   s_axis_tuser : in STD_LOGIC_VECTOR (tuser_width-1 downto 0);
   s_axis_tvalid : in STD_LOGIC;
   s_axis_tready : out STD_LOGIC;
   s_axis_tlast : in STD_LOGIC;
   m_axis_tdata : out STD_LOGIC_VECTOR (tdata_width-1 downto 0);
   m_axis_tuser : out STD_LOGIC_VECTOR (tuser_width-1 downto 0);
   m_axis_tvalid : out STD_LOGIC;
   m_axis_tready : in STD_LOGIC;
   m_axis_tlast : out STD_LOGIC
  );
end px_axis_compose;

architecture Behavioral of px_axis_compose is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of aclk: SIGNAL is "xilinx.com:signal:clock:1.0 aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of aclk: SIGNAL is "ASSOCIATED_BUSIF m_axis, ASSOCIATED_RESET aresetn";

begin

m_axis_tdata   <= s_axis_tdata; 
m_axis_tuser   <= s_axis_tuser; 
m_axis_tvalid  <= s_axis_tvalid;
s_axis_tready  <= m_axis_tready;
m_axis_tlast   <= s_axis_tlast; 

end Behavioral;
