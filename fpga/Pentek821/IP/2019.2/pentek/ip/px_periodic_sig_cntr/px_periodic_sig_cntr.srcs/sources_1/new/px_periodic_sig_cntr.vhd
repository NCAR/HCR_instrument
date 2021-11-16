----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/21/2018 11:18:36 AM
-- Design Name: 
-- Module Name: px_periodic_sig_cntr - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Periodic Signal Counter.  This core counts clock cycles from between rising edges
--              of the signal
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:

----------------------------------------------------------------------------------
-- Register Map
-- 0x00 Reset Register  
-- 0x04 Period Count

-- Reset Register 
-- [0]     Reset

----------------------------------------------------------------------------------

-- (c) Copyright 2018 Pentek, Inc. All rights reserved.
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

entity px_periodic_sig_cntr is
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
   
   irq                      : out std_logic;
----------------------------------------------------------------------------
-- Signal Input 
----------------------------------------------------------------------------
   signal_in                : in std_logic;
----------------------------------------------------------------------------
-- Frequency Counter Ref Clock
----------------------------------------------------------------------------
   clk_in                   : in std_logic   --  Clock that signal_in is synchronous to.
 );
end px_periodic_sig_cntr;
 
architecture Behavioral of px_periodic_sig_cntr is

-------------------------------------------------------------------------------
-- Components
-------------------------------------------------------------------------------

COMPONENT px_periodic_sig_cntr_csr
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
    stat0_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    intrpt_src_in : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    irq : OUT STD_LOGIC
  );
END COMPONENT;

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of clk_in: SIGNAL is "xilinx.com:signal:clock:1.0 clk_in CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of clk_in: SIGNAL is "ASSOCIATED_RESET resetn";

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTERRUPT";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal period_cntr        : std_logic_vector(31 downto 0) := x"00000000";
signal t2_re              : std_logic := '0';
signal t1_signal_in       : std_logic := '0';
signal t2_signal_in       : std_logic := '0';
signal period_latch       : std_logic_vector(31 downto 0) := x"00000000";
signal src_send           : std_logic := '0';
signal src_rcv            : std_logic := '0';
signal dest_req           : std_logic := '0';
signal period_x           : std_logic_vector(31 downto 0) := x"00000000";
signal period_cntr_l      : std_logic_vector(31 downto 0) := x"00000000";
signal t1_s_axi_csr_aresetn: std_logic := '0';
signal rst_reg            : std_logic := '0';
signal ctl0_out           : std_logic_vector(31 downto 0) := x"00000000";
signal rst                : std_logic := '0';
signal send_ff            : std_logic := '0';
signal irqx               : std_logic := '0';
signal cnt_ok             : std_logic := '0';

-------------------------------------------------------------------------------

begin

--------------------------------------------------------------------------------
-- Period Counter
--------------------------------------------------------------------------------

process(clk_in) 
begin 
   if rising_edge(clk_in) then
      t2_re         <= t1_signal_in and not t2_signal_in;
      t2_signal_in  <= t1_signal_in;
      t1_signal_in  <= signal_in;
      if  (rst_reg = '1') then
         cnt_ok <= '0';
      elsif (t2_re = '1') then
         cnt_ok <= '1';
      end if;   
      if (rst_reg = '1') or (t2_re = '1') then 
         period_cntr   <= x"00000000";
      elsif (cnt_ok = '1') then
         period_cntr   <= period_cntr + 1;
      end if;
      if (t2_re = '1') then 
         period_cntr_l <= period_cntr + 1;
      end if;
      if (rst_reg = '1')  then
         send_ff <= '0';   
      elsif (t2_re = '1') and (cnt_ok = '1') then
         send_ff <= '1';
      elsif (src_send = '1') then
         send_ff <= '0';
      end if;   
   end if; 
end process; 

csr_inst: px_periodic_sig_cntr_csr
port map (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
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
    stat0_in                => period_x,
    intrpt_src_in(0)        => dest_req,
    irq                     => irqx
);

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      irq <= irqx;
   end if;
end process;   

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
      src_in   => period_cntr_l,
      src_send => src_send,
      src_rcv  => src_rcv,
      dest_clk => s_axi_csr_aclk,
      dest_req => dest_req,
      dest_ack => dest_req, -- optional; required when DEST_EXT_HSK = 1
      dest_out => period_x
   );
   
process(clk_in)
begin
   if rising_edge(clk_in) then
     if (src_rcv = '1') then
       src_send <= '0';
     elsif (src_rcv = '0') and (src_send = '0') and (send_ff = '1') then
       src_send <= '1';
     end if;  
   end if;
end process;   

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
      rst <= ctl0_out(0) or not t1_s_axi_csr_aresetn;
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
     src_rst  => rst,
     dest_clk => clk_in,
     dest_rst => rst_reg
);  


end Behavioral;
