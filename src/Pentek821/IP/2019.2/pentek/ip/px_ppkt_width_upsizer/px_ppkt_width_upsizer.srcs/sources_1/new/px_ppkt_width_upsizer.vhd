----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/06/2016 10:14:59 AM
-- Design Name: 
-- Module Name: px_ppkt_width_upsizer - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: AXI-S Pentek PPKT Type Stream Up-Sizer to 256-bit data bus
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 1.00 - File Created
-- Revision 2.00 - 5/4/2018 Added the ability to change output width and increased maximum width to 32 Words
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

entity px_ppkt_width_upsizer is
generic (
    WORD_WIDTH : integer := 8; -- must be 1,2,4,8,16 (number of 16-bit words)
    OUT_WORD_WIDTH : integer := 16  -- must be greater than WORD_WIDTH and 2,4,8,16,or 32
);
port (
    ----------------------------------------------------------------------------
    -- Input - Variable Width
    ----------------------------------------------------------------------------
    aclk                 : in  std_logic;
    aresetn              : in  std_logic;
    s_axis_ppkt_tvalid   : in  std_logic;
    s_axis_ppkt_tready   : out std_logic;
    s_axis_ppkt_tdata    : in  std_logic_vector((WORD_WIDTH*16)-1 downto 0);
    -- tuser[63:0]    = timestamp[63:0]  
    -- tuser[64]      = SOP   
    -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
    -- tuser[67]      = Data Type 0 = Real 1 = I/Q
    -- tuser[75:68]   = channel[7:0] 
    -- tuser[79:76]   = user[3:0] 
    s_axis_ppkt_tuser    : in  std_logic_vector(79 downto 0);
    s_axis_ppkt_tkeep    : in  std_logic_vector(WORD_WIDTH-1 downto 0); -- One per 16-bit word
    s_axis_ppkt_tlast    : in  std_logic;
    ----------------------------------------------------------------------------
    -- Output 256 wide
    ----------------------------------------------------------------------------
    m_axis_ppkt_tvalid   : out std_logic;
    m_axis_ppkt_tready   : in  std_logic;
    m_axis_ppkt_tdata    : out std_logic_vector((OUT_WORD_WIDTH*16)-1 downto 0);
    -- tuser[63:0]    = timestamp[63:0]  
    -- tuser[64]      = SOP   
    -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 24-bit 3 = 32-bit
    -- tuser[67]      = Data Type 0 = Real 1 = I/Q
    -- tuser[75:68]   = channel[7:0]  
    -- tuser[79:76]   = user
    m_axis_ppkt_tuser    : out std_logic_vector(79 downto 0);
    m_axis_ppkt_tkeep    : out std_logic_vector(OUT_WORD_WIDTH-1 downto 0); -- One per 16-bit word
    m_axis_ppkt_tlast    : out std_logic
  );
end px_ppkt_width_upsizer;

architecture Behavioral of px_ppkt_width_upsizer is

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of aclk: SIGNAL is "xilinx.com:signal:clock:1.0 aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_ppkt:m_axis_ppkt, ASSOCIATED_RESET aresetn";

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Xilinx Core Code extracted to allow variable width
component px_axis_dwidth_upconv
generic (
     C_FAMILY : string := "kintexu";
     C_S_AXIS_TDATA_WIDTH : integer := (WORD_WIDTH*16);
     C_S_AXIS_TUSER_WIDTH : integer := 128;
     C_M_AXIS_TDATA_WIDTH : integer := 256;
     C_M_AXIS_TUSER_WIDTH : integer := (256/(WORD_WIDTH*16));
     C_AXIS_SIGNAL_SET : std_logic_vector := "00000000000000000000000000010011"
  ); 
port (
    aclk          : in std_logic;
    aresetn       : in std_logic;
    aclken        : in std_logic;
    s_axis_tvalid : in std_logic;
    s_axis_tid    : in std_logic_vector(0 downto 0);
    s_axis_tdest  : in std_logic_vector(0 downto 0);
    s_axis_tkeep  : in std_logic_vector(C_S_AXIS_TDATA_WIDTH/8-1 downto 0);
    s_axis_tstrb  : in std_logic_vector(C_S_AXIS_TDATA_WIDTH/8-1 downto 0); 
    s_axis_tready : out std_logic;
    s_axis_tdata  : in std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
    s_axis_tlast  : in std_logic;
    s_axis_tuser  : in std_logic_vector(C_S_AXIS_TUSER_WIDTH-1 downto 0); 
    m_axis_tid    : out std_logic_vector(0 downto 0);
    m_axis_tvalid : out std_logic;
    m_axis_tready : in std_logic;
    m_axis_tdata  : out std_logic_vector(C_M_AXIS_TDATA_WIDTH-1 downto 0);
    m_axis_tlast  : out std_logic;
    m_axis_tkeep  : out std_logic_vector((C_M_AXIS_TDATA_WIDTH/8)-1 downto 0);
    m_axis_tstrb  : out std_logic_vector((C_M_AXIS_TDATA_WIDTH/8)-1 downto 0);
    m_axis_tdest  : out std_logic_vector(0 downto 0);
    m_axis_tuser  : out std_logic_vector(C_M_AXIS_TUSER_WIDTH-1 downto 0)
  );
end component;

--------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------- 
 
constant mult_fctr : integer := OUT_WORD_WIDTH/WORD_WIDTH;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal tkeep: std_logic_vector((WORD_WIDTH*2)-1 downto 0)  := (others => '0');
signal mtkeep : std_logic_vector((OUT_WORD_WIDTH*2)-1 downto 0)  := (others => '0');
signal mtuser : std_logic_vector((mult_fctr*128)-1  downto 0) := (others => '0');
signal tuser  : std_logic_vector(127 downto 0) := (others => '0');
signal t1_aresetn: std_logic := '0';
---------------------------------------------------------------------------------

begin

process(aclk)
begin
    if rising_edge(aclk) then
        t1_aresetn <= aresetn;
    end if;
end process;    

tuser(79 downto 0) <= s_axis_ppkt_tuser;
tuser(127 downto 80) <= (others => '0');

gen_in_tkeep: for i in 0 to (WORD_WIDTH-1) generate 
    tkeep(i*2)     <= s_axis_ppkt_tkeep(i);
    tkeep((i*2)+1) <= s_axis_ppkt_tkeep(i);  
end generate;

widthconv_inst: px_axis_dwidth_upconv
generic map (
     C_FAMILY => "kintexu",
     C_S_AXIS_TDATA_WIDTH => (WORD_WIDTH*16),
     C_M_AXIS_TDATA_WIDTH => (OUT_WORD_WIDTH*16),
     C_S_AXIS_TUSER_WIDTH => 128,
     C_M_AXIS_TUSER_WIDTH => (128*OUT_WORD_WIDTH/WORD_WIDTH),
     C_AXIS_SIGNAL_SET    => "00000000000000000000000010011011"
  ) 
port map (
    aclk          => aclk,
    aresetn       => t1_aresetn,
    aclken        => '1',
    s_axis_tvalid => s_axis_ppkt_tvalid,
    s_axis_tready => s_axis_ppkt_tready,
    s_axis_tdata  => s_axis_ppkt_tdata,
    s_axis_tlast  => s_axis_ppkt_tlast,
    s_axis_tid    => "0", 
    s_axis_tkeep  => tkeep, 
    s_axis_tstrb  => tkeep,   
    s_axis_tdest  => "0", 
    s_axis_tuser  => tuser,    
    m_axis_tvalid => m_axis_ppkt_tvalid,
    m_axis_tready => m_axis_ppkt_tready,
    m_axis_tdata  => m_axis_ppkt_tdata,
    m_axis_tlast  => m_axis_ppkt_tlast,
    m_axis_tid    => open,
    m_axis_tkeep  => mtkeep,
    m_axis_tstrb  => open, 
    m_axis_tdest  => open,
    m_axis_tuser  => mtuser
  );

m_axis_ppkt_tuser(79 downto 0) <= mtuser(79 downto 0);
  
gen_out_tkeep: for i in 0 to (OUT_WORD_WIDTH-1) generate 
    m_axis_ppkt_tkeep(i) <= mtkeep(i*2); 
end generate;


end Behavioral;
