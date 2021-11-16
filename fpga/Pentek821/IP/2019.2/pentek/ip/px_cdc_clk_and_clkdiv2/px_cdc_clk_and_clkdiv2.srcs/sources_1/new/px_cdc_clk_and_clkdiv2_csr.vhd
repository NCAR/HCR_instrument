----------------------------------------------------------------------------------
-- Control/Status Registers for Pentek CDCM7005 Clock Receiver (Divide by 2 Version)
----------------------------------------------------------------------------------
-- px_cdc_clk_and_clkdiv2_csr.vhd
--
-- Target Device: Kintex UltraScale
--
-- Pentek Inc.
-- One Park Way, Upper Saddle River, NJ 07458
-- (201)818-5900
-- www.pentek.com
--
-- Copyright Pentek, Inc. 2015
--
-- Revision:
-- Revision 0.01 - File Created


-- Additional Comments: 
--  

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
----------------------------------------------------------------------------------

-- Register Map
-- 0x00 Control
-- 0x04 Clock Status    
-- 0x08 Frequecy Counter
-- 0x0C Interrupt Enable Register
-- 0x10 Interrupt Status Register
-- 0x14 Interrupt Flag Register


-- Gate Receive Buffer Control
-- [0]     Clock Disable

----------------------------------------------------------------------------------

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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_cdc_clk_and_clkdiv2_csr is
generic(
   initial_led_src        : integer := 0 -- Initial LED Mode at Reset          
);
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    s_axi_csr_aclk        : in  std_logic;
    s_axi_csr_aresetn     : in  std_logic;
    s_axi_csr_awaddr      : in  std_logic_vector(4 downto 0); -- only [5:0] used
    s_axi_csr_awprot      : in  std_logic_vector(2 downto 0);
    s_axi_csr_awvalid     : in  std_logic;
    s_axi_csr_awready     : out std_logic;
    s_axi_csr_wdata       : in  std_logic_vector(31 downto 0);
    s_axi_csr_wstrb       : in  std_logic_vector(3 downto 0);
    s_axi_csr_wvalid      : in  std_logic;
    s_axi_csr_wready      : out std_logic;
    s_axi_csr_bresp       : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid      : out std_logic;
    s_axi_csr_bready      : in  std_logic;
    s_axi_csr_araddr      : in  std_logic_vector(4 downto 0);  -- only [5:0] used
    s_axi_csr_arprot      : in  std_logic_vector(2 downto 0);
    s_axi_csr_arvalid     : in  std_logic;
    s_axi_csr_arready     : out std_logic;
    s_axi_csr_rdata       : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp       : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid      : out std_logic;
    s_axi_csr_rready      : in  std_logic;
    
    irq                   : out std_logic; -- interrupt 
--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------    
    led_mode              : out std_logic_vector(1 downto 0);
    clock_disable         : out std_logic;
--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------                      
    clk_ok                : in  std_logic; 
    cdc_stat_vcxo         : in  std_logic;
    cdc_stat_ref          : in  std_logic;
    cdc_stat_lock         : in  std_logic;
    freq_cnt              : in  std_logic_vector(31 downto 0);
    sm_state              : in  std_logic_vector(2 downto 0)
);
end px_cdc_clk_and_clkdiv2_csr;

architecture Behavioral of px_cdc_clk_and_clkdiv2_csr is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Generic Control/Status Register Set
component px_axil_csr_cdc_div2
  port (
    s_axi_csr_aclk : in std_logic;
    s_axi_csr_aresetn : in std_logic;
    s_axi_csr_awaddr : in std_logic_vector(6 downto 0);
    s_axi_csr_awprot : in std_logic_vector(2 downto 0);
    s_axi_csr_awvalid : in std_logic;
    s_axi_csr_awready : out std_logic;
    s_axi_csr_wdata : in std_logic_vector(31 downto 0);
    s_axi_csr_wstrb : in std_logic_vector(3 downto 0);
    s_axi_csr_wvalid : in std_logic;
    s_axi_csr_wready : out std_logic;
    s_axi_csr_bresp : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid : out std_logic;
    s_axi_csr_bready : in std_logic;
    s_axi_csr_araddr : in std_logic_vector(6 downto 0);
    s_axi_csr_arprot : in std_logic_vector(2 downto 0);
    s_axi_csr_arvalid : in std_logic;
    s_axi_csr_arready : out std_logic;
    s_axi_csr_rdata : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid : out std_logic;
    s_axi_csr_rready : in std_logic;
    reg0_init_val : in std_logic_vector(31 downto 0);
    ctl0_out : out std_logic_vector(31 downto 0);
    stat0_in : in std_logic_vector(31 downto 0);
    stat1_in : in std_logic_vector(31 downto 0);
    intrpt_src_in : in std_logic_vector(3 downto 0);
    irq : out std_logic
  );
end component;

---------------------------------------------------------------------------------
-- Constants
---------------------------------------------------------------------------------

constant CNTL_REG_INIT_VAL                : std_logic_vector(31 downto 0) := x"000000" & "00" & conv_std_logic_vector(initial_led_src, 2) & x"0";

---------------------------------------------------------------------------------
-- Signals
---------------------------------------------------------------------------------
 
signal cntl_reg0            : std_logic_vector(31 downto 0) := CNTL_REG_INIT_VAL;
signal stat_reg0            : std_logic_vector(31 downto 0) := (others => '0');
signal stat_reg1            : std_logic_vector(31 downto 0) := (others => '0');
signal int_src_stat         : std_logic_vector(3 downto 0) := (others => '0');
signal awaddr               : std_logic_vector(6 downto 0) := (others => '0');
signal araddr               : std_logic_vector(6 downto 0) := (others => '0');

---------------------------------------------------------------------------------

begin

awaddr <= "00" & s_axi_csr_awaddr;
araddr <= "00" & s_axi_csr_araddr;

csr_inst: px_axil_csr_cdc_div2
  port map (
    s_axi_csr_aclk      => s_axi_csr_aclk,
    s_axi_csr_aresetn   => s_axi_csr_aresetn,
    s_axi_csr_awaddr    => awaddr,
    s_axi_csr_awprot    => s_axi_csr_awprot,
    s_axi_csr_awvalid   => s_axi_csr_awvalid,
    s_axi_csr_awready   => s_axi_csr_awready,
    s_axi_csr_wdata     => s_axi_csr_wdata,
    s_axi_csr_wstrb     => s_axi_csr_wstrb,
    s_axi_csr_wvalid    => s_axi_csr_wvalid,
    s_axi_csr_wready    => s_axi_csr_wready,
    s_axi_csr_bresp     => s_axi_csr_bresp,
    s_axi_csr_bvalid    => s_axi_csr_bvalid,
    s_axi_csr_bready    => s_axi_csr_bready,
    s_axi_csr_araddr    => araddr,
    s_axi_csr_arprot    => s_axi_csr_arprot,
    s_axi_csr_arvalid   => s_axi_csr_arvalid,
    s_axi_csr_arready   => s_axi_csr_arready,
    s_axi_csr_rdata     => s_axi_csr_rdata,
    s_axi_csr_rresp     => s_axi_csr_rresp,
    s_axi_csr_rvalid    => s_axi_csr_rvalid,
    s_axi_csr_rready    => s_axi_csr_rready,
    reg0_init_val       => CNTL_REG_INIT_VAL,
    ctl0_out            => cntl_reg0,
    stat0_in            => stat_reg0,
    stat1_in            => stat_reg1,
    intrpt_src_in       => int_src_stat,
    irq                 => irq
  );


--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------

-- Register Map
-- 0x00 Control
-- 0x04 Clock Status    
-- 0x08 Frequecy Counter
-- 0x0C Interrupt Enable Register
-- 0x10 Interrupt Status Register
-- 0x14 Interrupt Flag Register

-- Gate Receive Buffer Control
-- [0]     Clock Disable
-- [5:4]   LED Mode  00 = CLK_OK 01 = CLK_OK and vcxo_ok 10 = CLK_OK and vcxo_ok and ref_ok and lock


process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
       clock_disable       <= cntl_reg0(0); 
       led_mode            <= cntl_reg0(5 downto 4); 
    end if;
end process;

--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------

stat_reg0 <= x"0000" & "00000" & sm_state & "00" & '0' & '0' & cdc_stat_lock & cdc_stat_ref & cdc_stat_vcxo & clk_ok;

stat_reg1 <= freq_cnt; 

--------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------

-- Interrupts
-- Bit [0] Clock OK
-- Bit [1] Clock not OK
-- Bit [2] CDC Locked
-- Bit [3] CDC Lock lost

int_src_stat <= (not cdc_stat_lock) & cdc_stat_lock & (not clk_ok) & clk_ok;

                       
end Behavioral;