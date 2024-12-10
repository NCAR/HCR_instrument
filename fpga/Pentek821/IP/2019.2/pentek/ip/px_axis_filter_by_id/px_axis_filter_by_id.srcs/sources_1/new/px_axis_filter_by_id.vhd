----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 11/17/2016 12:41:37 PM
-- Design Name: 
-- Module Name: px_axis_filter_by_id - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Filter AXI-S by tid value
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- This core has no tready support so flow control is not supported.
-- If timing issues occur, place a register slice on either side of this core.
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axis_filter_by_id is
generic(
    id_filter_val : integer := 0; -- ID value to let pass
    has_tuser  : boolean := true;
    has_tlast  : boolean := true;
    has_tkeep  : boolean := true;
    tid_size   : integer := 8; 
    tdata_bytes: integer := 4; -- number of bytes  
    tuser_size : integer := 32  
);
port (
    axis_aclk    : in  std_logic;
    axis_aresetn : in  std_logic;
    s_axis_tdata : in  std_logic_vector((tdata_bytes*8)-1 downto 0);
    s_axis_tuser : in  std_logic_vector(tuser_size-1 downto 0);
    s_axis_tvalid: in  std_logic;
    s_axis_tkeep : in  std_logic_vector(tdata_bytes-1 downto 0);
    s_axis_tlast : in  std_logic;
    s_axis_tid   : in  std_logic_vector(tid_size -1 downto 0);
    m_axis_tdata : out std_logic_vector((tdata_bytes*8)-1 downto 0);
    m_axis_tuser : out std_logic_vector(tuser_size-1 downto 0);
    m_axis_tvalid: out std_logic;
    m_axis_tkeep : out std_logic_vector(tdata_bytes-1 downto 0);
    m_axis_tlast : out std_logic;
    m_axis_tid   : out std_logic_vector(tid_size -1 downto 0)    
);
end px_axis_filter_by_id;

architecture Behavioral of px_axis_filter_by_id is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis:m_axis, ASSOCIATED_RESET axis_aresetn";


begin

process(axis_aclk)
begin
    if rising_edge(axis_aclk) then
        m_axis_tdata   <= s_axis_tdata; 
        m_axis_tuser   <= s_axis_tuser; 
        if (conv_integer(s_axis_tid) = id_filter_val) then
            m_axis_tvalid  <= s_axis_tvalid;
        else 
            m_axis_tvalid  <= '0';
        end if;
        m_axis_tkeep   <= s_axis_tkeep; 
        m_axis_tlast   <= s_axis_tlast; 
        m_axis_tid     <= s_axis_tid;
    end if;
end process;

end Behavioral;