-------------------------------------------------------------------------------
-- ************** 8-Channel Channelizer DDC Section 1 Input Delays********** --
-- ************************* <in Kintex_Utrascale>  ************************ --
-------------------------------------------------------------------------------
--  Copyright (c) 2017 Pentek, Inc. All rights reserved.
-------------------------------------------------------------------------------
-- Title        : 8-Channel Channelizer DDC Section 1 Input Delays
-- Project      : Navigator
-------------------------------------------------------------------------------
---------  Technical Support for Pentek's GateFlow FPGA Design Kits   ---------
-------------------------------------------------------------------------------
--        Technical support for Pentek's GateFlow FPGA Design Kits is        --
--   available via e-mail (fpgasupport@pentek.com) or by phone (201-818-5900 --
--            ext. 238, 9 AM to 5 PM US Eastern time.) Names or              --
--  initials contained within the source code are part of our revision       --
--   control regime.  Please do not try to use these references to pursue    --
--                            technical support                              --
-------------------------------------------------------------------------------
-- Filename       : px_8ch_chan_ddc_indly.vhd>
-- Author         : 
-- Created        : 03/23/2017
-- Last Modified  : 05/09/2017
-- Vivado Version : 2017.1
-- Modified By    : 
--                  Pentek, Inc.
--                  One Park Way
--                  Upper Saddle River, NJ  07458
--                  (201) 818-5900
--                  www.pentek.com
-------------------------------------------------------------------------------
-- ******************************* Change Log ****************************** --
-- 3/23/2017 - Created
--
------------------------------------------------------------------------------
-- Description: 8-Channel Channelizer DDC Section 1 Input Delays

-- !!!!! Does not support AXI-S back-pressure !!!!!!
-- TVALID MUST BE ALWAYS ASSERTED. TVALID not supported. 
--------------------------------------------------------------------------------

-- (c) Copyright 2017 Pentek, Inc. All rights reserved.
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
LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;
Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_8chddcs1_indly is
port (
 ----------------------------------------------------------------------------
 -- Input
 ----------------------------------------------------------------------------
 s_axis_tdata     : in  std_logic_vector(15 downto 0); 
 s_axis_tvalid    : in  std_logic; -- Requires tvalid to be alway high 
 s_axis_tuser     : in  std_logic_vector(0 downto 0);  -- SYNC 
 axis_aclk        : in  std_logic;
 axis_aresetn     : in  std_logic;
 ----------------------------------------------------------------------------
 -- Output
 ----------------------------------------------------------------------------
 m_axis_tdata     : out std_logic_vector(127 downto 0); -- Phase h,g,f,e,d,c,b,a   
 m_axis_tuser     : out std_logic_vector(0 downto 0);  -- SYNC 
 m_axis_tvalid    : out std_logic 
);
end px_8chddcs1_indly;

architecture Behavioral of px_8chddcs1_indly is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------
-- Shift Register Delay 
component gen_lut_shr
   Generic (
         add_ff : std_logic := '0';
         delay_value: integer := 16;
         width : integer := 16
      );
    Port ( D_IN : in  STD_LOGIC_VECTOR ((width-1) downto 0);
           CLK : in  STD_LOGIC;
           CE : in  STD_LOGIC;
           D_OUT : out  STD_LOGIC_VECTOR ((width-1) downto 0));
end component;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------
signal t1_s_axis_tuser : std_logic_vector(0 downto 0) := (others => '0');
signal t2_s_axis_tuser : std_logic_vector(0 downto 0) := (others => '0');
signal sync_tuser : std_logic_vector(0 downto 0) := (others => '0');
signal a_tdata : std_logic_vector(15 downto 0) := (others => '0'); 
signal b_tdata : std_logic_vector(15 downto 0) := (others => '0'); 
signal c_tdata : std_logic_vector(15 downto 0) := (others => '0'); 
signal d_tdata : std_logic_vector(15 downto 0) := (others => '0'); 
signal e_tdata : std_logic_vector(15 downto 0) := (others => '0'); 
signal f_tdata : std_logic_vector(15 downto 0) := (others => '0'); 
signal g_tdata : std_logic_vector(15 downto 0) := (others => '0'); 
signal h_tdata : std_logic_vector(15 downto 0) := (others => '0');

--------------------------------------------------------------------------------
begin

process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      h_tdata         <= s_axis_tdata;
      t1_s_axis_tuser <= s_axis_tuser;
      t2_s_axis_tuser <= t1_s_axis_tuser;
   end if;
end process;

sync_tuser(0) <= t1_s_axis_tuser(0) and not t2_s_axis_tuser(0);

--------------------------------------------------------------------------------
-- Delays
--------------------------------------------------------------------------------

g_dly : gen_lut_shr
Generic map (
      add_ff => '1',
      delay_value => 8,
      width => 16
   )
Port map
   ( 
      D_IN  => h_tdata, 
      D_OUT => g_tdata,
      CLK   => axis_aclk,     
      CE    => '1'                
   );       

f_dly : gen_lut_shr
Generic map (
      add_ff => '1',
      delay_value => 8,
      width => 16
   )
Port map
   ( 
      D_IN  => g_tdata, 
      D_OUT => f_tdata,
      CLK   => axis_aclk,     
      CE    => '1'                
   );   
   
e_dly : gen_lut_shr
Generic map (
      add_ff => '1',
      delay_value => 8,
      width => 16
   )
Port map
   ( 
      D_IN  => f_tdata, 
      D_OUT => e_tdata,
      CLK   => axis_aclk,     
      CE    => '1'                
   );   
   
d_dly : gen_lut_shr
Generic map (
      add_ff => '1',
      delay_value => 8,
      width => 16
   )
Port map
   ( 
      D_IN  => e_tdata, 
      D_OUT => d_tdata,
      CLK   => axis_aclk,     
      CE    => '1'                
   );   

c_dly : gen_lut_shr
Generic map (
      add_ff => '1',
      delay_value => 8,
      width => 16
   )
Port map
   ( 
      D_IN  => d_tdata, 
      D_OUT => c_tdata,
      CLK   => axis_aclk,     
      CE    => '1'                
   ); 
   
b_dly : gen_lut_shr
Generic map (
      add_ff => '1',
      delay_value => 8,
      width => 16
   )
Port map
   ( 
      D_IN  => c_tdata, 
      D_OUT => b_tdata,
      CLK   => axis_aclk,     
      CE    => '1'                
   ); 

a_dly : gen_lut_shr
Generic map (
      add_ff => '1',
      delay_value => 8,
      width => 16
   )
Port map
   ( 
      D_IN  => b_tdata, 
      D_OUT => a_tdata,
      CLK   => axis_aclk,     
      CE    => '1'                
   ); 

m_axis_tdata  <= h_tdata & g_tdata & f_tdata & e_tdata & d_tdata & c_tdata & b_tdata & a_tdata;
m_axis_tuser  <= sync_tuser;
m_axis_tvalid <= '1';

end Behavioral;
