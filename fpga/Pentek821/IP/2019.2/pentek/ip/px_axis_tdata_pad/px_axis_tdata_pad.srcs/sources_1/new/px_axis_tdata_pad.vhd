----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 05/12/2016 02:16:56 PM
-- Design Name: 
-- Module Name: px_axis_tdata_pad - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Pad AXI-S data with zeros
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axis_tdata_pad is
generic (
   in_data_width  : integer := 16;
   out_data_width : integer := 24;
   pad_type       : string  := "low0"; --"low0" = shift up and pad lower bits with '0'
                                       --"upper0" = pad upper bits with '0'
                                       --"upperx" = pad upper with sign extension
                                       --"iqlow0" = data is I/Q shift each up and pad lower bits with '0'
                                       --"iqupper0" = data is I/Q pad upper bits with '0'
                                       --"iqupperx" = data is I/Q pad upper with sign extension
   has_tready     : boolean := false;  -- When false, m_axis_tready has no effect (always ready)
   has_tuser      : boolean := false;  -- Has tuser streams 
   tuser_width    : integer := 1       -- Number of bits in tuser                                    
);
port ( 
   axis_aclk      : in  std_logic;                                   
   axis_aresetn   : in  std_logic; 
   -----------------------------------------------------------------------------
   -- Input AXI-S Slave
   -----------------------------------------------------------------------------                                  
   s_axis_tdata   : in  std_logic_vector (in_data_width-1 downto 0);
   s_axis_tuser   : in  std_logic_vector (tuser_width-1 downto 0); 
   s_axis_tvalid  : in  std_logic;
   s_axis_tready  : out std_logic;                                   
   -----------------------------------------------------------------------------
   -- Output AXI-S Master
   -----------------------------------------------------------------------------
   m_axis_tdata   : out std_logic_vector (out_data_width-1 downto 0);
   m_axis_tuser   : out std_logic_vector (tuser_width-1 downto 0); 
   m_axis_tvalid  : out std_logic;
   m_axis_tready  : in  std_logic                                  
);
end px_axis_tdata_pad;

architecture Behavioral of px_axis_tdata_pad is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis:m_axis, ASSOCIATED_RESET axis_aresetn";

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

constant delta : integer := out_data_width - in_data_width;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal pad : std_logic_vector(delta-1 downto 0) := (others => '0');
signal upad : std_logic_vector((delta/2)-1 downto 0) := (others => '0'); 
signal lpad : std_logic_vector((delta/2)-1 downto 0) := (others => '0');

begin

gen_low0: if (pad_type = "low0") generate

pad <= (others => '0');
m_axis_tdata <= s_axis_tdata & pad;

end generate gen_low0;

gen_upper0: if (pad_type = "upper0") generate

pad <= (others => '0');
m_axis_tdata <= pad & s_axis_tdata;

end generate gen_upper0;

gen_upperx: if (pad_type = "upperx") generate

pad <= (others => s_axis_tdata(in_data_width-1));
m_axis_tdata <= pad & s_axis_tdata;

end generate gen_upperx;

gen_iqlow0: if (pad_type = "iqlow0") generate

lpad <= (others => '0');
upad <= (others => '0');
m_axis_tdata <= s_axis_tdata(in_data_width-1 downto (in_data_width/2))  & upad & s_axis_tdata((in_data_width/2)-1 downto 0) & lpad;

end generate gen_iqlow0;

gen_iqupper0: if (pad_type = "iqupper0") generate

lpad <= (others => '0');
upad <= (others => '0');
m_axis_tdata <= upad & s_axis_tdata(in_data_width-1 downto (in_data_width/2)) & lpad & s_axis_tdata((in_data_width/2)-1 downto 0);

end generate gen_iqupper0;

gen_iqupperx: if (pad_type = "iqupperx") generate

lpad <= (others => s_axis_tdata(in_data_width/2-1));
upad <= (others => s_axis_tdata(in_data_width-1));
m_axis_tdata <= upad & s_axis_tdata(in_data_width-1 downto (in_data_width/2)) & lpad & s_axis_tdata((in_data_width/2)-1 downto 0);

end generate gen_iqupperx;

m_axis_tuser  <= s_axis_tuser;
m_axis_tvalid <= s_axis_tvalid;
s_axis_tready <= m_axis_tready;




end Behavioral;
