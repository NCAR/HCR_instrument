----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2017 01:26:28 PM
-- Design Name: 
-- Module Name: px_clock_frq_cntr - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Clock Frequency Counter
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- Updates every second.  Using a 250MHz reference, the clk_in frequency is counted
-- for a 1 second period.  The frequency in Hz can be read in the frwquency counter register.
----------------------------------------------------------------------------------
-- Register Map
-- 0x00 Reset Register  
-- 0x04 Frequecy Counter

-- Reset Register 
-- [0]     Reset

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
Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
Library UNISIM;
use UNISIM.vcomponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_clock_frq_cntr is
generic(
    ref_freq_hz : integer := 250000000 
);
port (
----------------------------------------------------------------------------
-- Control/Status Registers (AXI4-LITE)
----------------------------------------------------------------------------
-- associated with s_axi_csr_aclk
   s_axi_csr_aclk           : in  std_logic;
   s_axi_csr_aresetn        : in  std_logic;
   s_axi_csr_awaddr         : in  std_logic_vector(11 downto 0);
   s_axi_csr_awprot         : in  std_logic_vector(2 downto 0);
   s_axi_csr_awvalid        : in  std_logic;
   s_axi_csr_awready        : out std_logic;
   s_axi_csr_wdata          : in  std_logic_vector(31 downto 0);
   s_axi_csr_wstrb          : in  std_logic_vector(3 downto 0);
   s_axi_csr_wvalid         : in  std_logic;
   s_axi_csr_wready         : out std_logic;
   s_axi_csr_bresp          : out std_logic_vector(1 downto 0);
   s_axi_csr_bvalid         : out std_logic;
   s_axi_csr_bready         : in  std_logic;
   s_axi_csr_araddr         : in  std_logic_vector(11 downto 0);
   s_axi_csr_arprot         : in  std_logic_vector(2 downto 0);
   s_axi_csr_arvalid        : in  std_logic;
   s_axi_csr_arready        : out std_logic;
   s_axi_csr_rdata          : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp          : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid         : out std_logic;
   s_axi_csr_rready         : in  std_logic;  
----------------------------------------------------------------------------
-- Clock Input 
----------------------------------------------------------------------------
   clk_in                   : in std_logic;
   resetn                   : in std_logic; -- associated with clk_in
----------------------------------------------------------------------------
-- Frequency Counter Ref Clock
----------------------------------------------------------------------------
   ref_clk                  : in std_logic   --  Reference Clock (use 200 to 250MHz)
 );
end px_clock_frq_cntr;

architecture Behavioral of px_clock_frq_cntr is

-------------------------------------------------------------------------------
-- Components
-------------------------------------------------------------------------------

COMPONENT px_clock_frq_cntr_csr
  PORT (
    s_axi_csr_aclk : IN STD_LOGIC;
    s_axi_csr_aresetn : IN STD_LOGIC;
    s_axi_csr_awaddr : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    s_axi_csr_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_csr_awvalid : IN STD_LOGIC;
    s_axi_csr_awready : OUT STD_LOGIC;
    s_axi_csr_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_csr_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_csr_wvalid : IN STD_LOGIC;
    s_axi_csr_wready : OUT STD_LOGIC;
    s_axi_csr_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_csr_bvalid : OUT STD_LOGIC;
    s_axi_csr_bready : IN STD_LOGIC;
    s_axi_csr_araddr : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    s_axi_csr_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_csr_arvalid : IN STD_LOGIC;
    s_axi_csr_arready : OUT STD_LOGIC;
    s_axi_csr_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_csr_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_csr_rvalid : OUT STD_LOGIC;
    s_axi_csr_rready : IN STD_LOGIC;
    reg0_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl0_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat0_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------
    
constant ref_freq_vctr : std_logic_vector(31 downto 0) := conv_std_logic_vector((ref_freq_hz-1), 32); 

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of clk_in: SIGNAL is "xilinx.com:signal:clock:1.0 clk_in CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of clk_in: SIGNAL is "ASSOCIATED_RESET resetn";

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal freq_cntr_rst_rr   : std_logic := '0';
signal freq_cntr_rst_r    : std_logic := '0';
signal freq_cntr          : std_logic_vector(31 downto 0) := x"00000000";
signal freq_cntr_rst      : std_logic := '0';
signal freq_latch         : std_logic_vector(31 downto 0) := x"00000000";
signal freq_period_cntr   : std_logic_vector(27 downto 0) := (others => '0');
signal src_send           : std_logic := '0';
signal src_rcv            : std_logic := '0';
signal dest_req           : std_logic := '0';
signal freq_x             : std_logic_vector(31 downto 0) := x"00000000";
signal freq_cntr_l        : std_logic_vector(31 downto 0) := x"00000000";
signal t1_s_axi_csr_aresetn: std_logic := '0';
signal t1_resetn          : std_logic := '0';
signal t1_reset           : std_logic := '0';
signal t1_resetn_ref      : std_logic := '0';
signal t1_reset_ref       : std_logic := '0';
signal rst_reg            : std_logic := '0';
signal ctl0_out           : std_logic_vector(31 downto 0) := x"00000000";

-------------------------------------------------------------------------------

begin

--------------------------------------------------------------------------------
-- Frequency Counter
--------------------------------------------------------------------------------

process(clk_in) 
begin 
   if rising_edge(clk_in) then
      t1_resetn <= not ((not resetn) or rst_reg);
      if ((freq_cntr_rst_r = '1') and (freq_cntr_rst_rr = '0')) or (t1_resetn = '0') then 
         freq_cntr   <= x"00000000";
      else
         freq_cntr  <= freq_cntr + 1;
      end if;
      if (freq_cntr_rst_r = '1') and (freq_cntr_rst_rr = '0') then 
         freq_cntr_l <= freq_cntr;
      end if;   
   end if;
end process;   

-- 1 second at Ref Clock Frequency

process(ref_clk) 
begin 
   if rising_edge(ref_clk) then
      if (t1_resetn_ref = '0') or (freq_cntr_rst = '1') then
        freq_period_cntr <= (others => '0');  
      else
        freq_period_cntr  <= freq_period_cntr + 1;
      end if;
      if (freq_period_cntr = ref_freq_vctr) then
      --if (freq_period_cntr = x"EE6B27F") then
         freq_cntr_rst <= '1';
      else
         freq_cntr_rst <= '0';
      end if;
   end if;
end process;   

--sync_rst_inst: xpm_cdc_sync_rst
--generic map (
--  DEST_SYNC_FF    => 2, -- integer; range: 2-10
--  INIT            => 1, -- integer; 0=initialize synchronization registers to 0,
--                        --          1=initialize synchronization registers to 1
--  SIM_ASSERT_CHK  => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
--)
--port map (
--     src_rst  => freq_cntr_rst,
--     dest_clk => clk_in,
--     dest_rst => freq_cntr_rst_r
--);


t1_reset     <= not t1_resetn;
t1_reset_ref <= not t1_resetn_ref; 

xpm_cdc_pulse_inst: xpm_cdc_pulse
generic map (

  -- Common module generics
  DEST_SYNC_FF   => 4, -- integer; range: 2-10
  REG_OUTPUT     => 0, -- integer; 0=disable registered output,   1=enable registered output
  RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
  SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages

)
port map (

  src_clk    => ref_clk,
  src_rst    => t1_reset_ref,   -- optional; required when RST_USED = 1
  src_pulse  => freq_cntr_rst,
  dest_clk   => clk_in,
  dest_rst   => t1_reset,  -- optional; required when RST_USED = 1
  dest_pulse => freq_cntr_rst_r
);

process(clk_in) 
begin 
   if rising_edge(clk_in) then
       freq_cntr_rst_rr  <= freq_cntr_rst_r;
   end if;
end process; 


csr_inst: px_clock_frq_cntr_csr
port map (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
-- Address Range - BASE + 0x00 -> BASE + 0x3F
--------------------------------------------------------------------------------
    s_axi_csr_aclk          => s_axi_csr_aclk,   
    s_axi_csr_aresetn       => t1_s_axi_csr_aresetn,
    s_axi_csr_awaddr        => s_axi_csr_awaddr(6 downto 0),  
    s_axi_csr_awprot        => s_axi_csr_awprot,  
    s_axi_csr_awvalid       => s_axi_csr_awvalid, 
    s_axi_csr_awready       => s_axi_csr_awready, 
    s_axi_csr_wdata         => s_axi_csr_wdata,   
    s_axi_csr_wstrb         => s_axi_csr_wstrb,   
    s_axi_csr_wvalid        => s_axi_csr_wvalid,  
    s_axi_csr_wready        => s_axi_csr_wready,  
    s_axi_csr_bresp         => s_axi_csr_bresp,   
    s_axi_csr_bvalid        => s_axi_csr_bvalid,  
    s_axi_csr_bready        => s_axi_csr_bready,  
    s_axi_csr_araddr        => s_axi_csr_araddr(6 downto 0),  
    s_axi_csr_arprot        => s_axi_csr_arprot,  
    s_axi_csr_arvalid       => s_axi_csr_arvalid, 
    s_axi_csr_arready       => s_axi_csr_arready, 
    s_axi_csr_rdata         => s_axi_csr_rdata,   
    s_axi_csr_rresp         => s_axi_csr_rresp,   
    s_axi_csr_rvalid        => s_axi_csr_rvalid,  
    s_axi_csr_rready        => s_axi_csr_rready,  
      
    reg0_init_val           => x"00000000",
    ctl0_out                => ctl0_out,
    stat0_in                => freq_latch
);


frq_xclk_inst :  xpm_cdc_handshake
    generic map (
      -- Common module generics
      DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
      DEST_SYNC_FF   => 4, -- integer; range: 2-10
      SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
      SRC_SYNC_FF    => 4, -- integer; range: 2-10
      WIDTH          => 32  -- integer; range: 1-1024
    )
    port map (
  
      src_clk  => clk_in,
      src_in   => freq_cntr_l,
      src_send => src_send,
      src_rcv  => src_rcv,
      dest_clk => s_axi_csr_aclk,
      dest_req => dest_req,
      dest_ack => dest_req, -- optional; required when DEST_EXT_HSK = 1
      dest_out => freq_x
   );
   
process(clk_in)
begin
   if rising_edge(clk_in) then
     if (src_rcv = '1') then
       src_send <= '0';
     elsif (src_rcv = '0') and (src_send = '0') then
       src_send <= '1';
     end if;  
   end if;
end process;   

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if (ctl0_out(0) = '1') then
         freq_latch <= (others => '0');
      elsif dest_req = '1' then
         freq_latch <= freq_x;
      end if;
      t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
   end if;
end process; 

sync_regrst_inst: xpm_cdc_sync_rst
generic map (
  DEST_SYNC_FF    => 3, -- integer; range: 2-10
  INIT            => 0, -- integer; 0=initialize synchronization registers to 0,
                        --          1=initialize synchronization registers to 1
  SIM_ASSERT_CHK  => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
)
port map (
     src_rst  => ctl0_out(0),
     dest_clk => clk_in,
     dest_rst => rst_reg
);  

sync_refrst_inst: xpm_cdc_sync_rst
generic map (
  DEST_SYNC_FF    => 3, -- integer; range: 2-10
  INIT            => 0, -- integer; 0=initialize synchronization registers to 0,
                        --          1=initialize synchronization registers to 1
  SIM_ASSERT_CHK  => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
)
port map (
     src_rst  => t1_resetn,
     dest_clk => ref_clk,
     dest_rst => t1_resetn_ref
);

end Behavioral;
