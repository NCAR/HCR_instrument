----------------------------------------------------------------------------------
-- Control/Status Registers for Pentek DAC38J84 DAC Interface
----------------------------------------------------------------------------------
-- px_dac38j84intrfc_csr.vhd
--
-- Target Device: Kintex UltraScale
--
-- Pentek Inc.
-- One Park Way, Upper Saddle River, NJ 07458
-- (201)818-5900
-- www.pentek.com
--
-- Copyright Pentek, Inc. 2016
--
-- Revision:
-- Revision 0.01 - File Created


-- Additional Comments: 
--  

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
----------------------------------------------------------------------------------

-- Memory Map
-- 0x00 - Control 1
-- 0x04 - Interrupt Enables
-- 0x08 - Interrupt Status
-- 0x0C - Interrupt Flags

-- Control 1
-- Bit [0]     - DAC Reset
-- Bit [1]     - DAC Sleep Mode
-- Bit [2]     - DAC TX Enable

-- Interrupts
-- Bit [0]     - DAC0 Alarm

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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_dac38j84intrfc_csr is
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
   s_axi_csr_aclk         : in  std_logic;
   s_axi_csr_aresetn      : in  std_logic;
   s_axi_csr_awaddr       : in  std_logic_vector(6 downto 0); -- only [5:0] used
   s_axi_csr_awprot       : in  std_logic_vector(2 downto 0);
   s_axi_csr_awvalid      : in  std_logic;
   s_axi_csr_awready      : out std_logic;
   s_axi_csr_wdata        : in  std_logic_vector(31 downto 0);
   s_axi_csr_wstrb        : in  std_logic_vector(3 downto 0);
   s_axi_csr_wvalid       : in  std_logic;
   s_axi_csr_wready       : out std_logic;
   s_axi_csr_bresp        : out std_logic_vector(1 downto 0);
   s_axi_csr_bvalid       : out std_logic;
   s_axi_csr_bready       : in  std_logic;
   s_axi_csr_araddr       : in  std_logic_vector(6 downto 0);  -- only [5:0] used
   s_axi_csr_arprot       : in  std_logic_vector(2 downto 0);
   s_axi_csr_arvalid      : in  std_logic;
   s_axi_csr_arready      : out std_logic;
   s_axi_csr_rdata        : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp        : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid       : out std_logic;
   s_axi_csr_rready       : in  std_logic;
    
   irq                   : out std_logic; -- interrupt
   ----------------------------------------------------------------------------
   -- Control Outputs
   ----------------------------------------------------------------------------
   dac_txena               : out std_logic;
   dac_sleep               : out std_logic;
   dac_resetb              : out std_logic;
   ----------------------------------------------------------------------------
   -- Status Inputs
   ----------------------------------------------------------------------------
   dac_alarm               : in  std_logic
);
end  px_dac38j84intrfc_csr;

architecture Behavioral of px_dac38j84intrfc_csr is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

COMPONENT px_axil_csr_dac38j84
  PORT (
    s_axi_csr_aclk          : IN  STD_LOGIC;
    s_axi_csr_aresetn       : IN  STD_LOGIC;
    s_axi_csr_awaddr        : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
    s_axi_csr_awprot        : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_csr_awvalid       : IN  STD_LOGIC;
    s_axi_csr_awready       : OUT STD_LOGIC;
    s_axi_csr_wdata         : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_csr_wstrb         : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_csr_wvalid        : IN  STD_LOGIC;
    s_axi_csr_wready        : OUT STD_LOGIC;
    s_axi_csr_bresp         : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_csr_bvalid        : OUT STD_LOGIC;
    s_axi_csr_bready        : IN  STD_LOGIC;
    s_axi_csr_araddr        : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
    s_axi_csr_arprot        : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_csr_arvalid       : IN  STD_LOGIC;
    s_axi_csr_arready       : OUT STD_LOGIC;
    s_axi_csr_rdata         : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_csr_rresp         : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_csr_rvalid        : OUT STD_LOGIC;
    s_axi_csr_rready        : IN  STD_LOGIC;
    reg0_init_val           : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl0_out                : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    intrpt_src_in           : IN  STD_LOGIC_VECTOR(0 DOWNTO 0);
    irq                     : OUT STD_LOGIC
  );
END COMPONENT;
---------------------------------------------------------------------------------
-- Constants
---------------------------------------------------------------------------------

constant CNTL_REG0_INIT_VAL: std_logic_vector(31 downto 0) := x"00000000";

---------------------------------------------------------------------------------
-- Signals
---------------------------------------------------------------------------------
 
signal cntl_reg0           : std_logic_vector(31 downto 0) := CNTL_REG0_INIT_VAL;
signal int_src_stat        : std_logic :=  '0';
signal dac_txen_int        : std_logic := '0';
signal dac_sleep_int       : std_logic := '0';
signal dac_reset_int       : std_logic := '0';

---------------------------------------------------------------------------------

begin

csr_inst: px_axil_csr_dac38j84
  port map (
    s_axi_csr_aclk      => s_axi_csr_aclk,
    s_axi_csr_aresetn   => s_axi_csr_aresetn,
    s_axi_csr_awaddr    => s_axi_csr_awaddr,
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
    s_axi_csr_araddr    => s_axi_csr_araddr,
    s_axi_csr_arprot    => s_axi_csr_arprot,
    s_axi_csr_arvalid   => s_axi_csr_arvalid,
    s_axi_csr_arready   => s_axi_csr_arready,
    s_axi_csr_rdata     => s_axi_csr_rdata,
    s_axi_csr_rresp     => s_axi_csr_rresp,
    s_axi_csr_rvalid    => s_axi_csr_rvalid,
    s_axi_csr_rready    => s_axi_csr_rready,
    reg0_init_val       => CNTL_REG0_INIT_VAL,
    ctl0_out            => cntl_reg0,
    intrpt_src_in(0)    => int_src_stat,
    irq                 => irq
  );

--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------
-- Control 1
-- Bit [0]     - DAC Reset
-- Bit [1]     - DAC Sleep Mode
-- Bit [2]     - DAC TX Enable

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
       dac_reset_int   <= (cntl_reg0(0) or (not s_axi_csr_aresetn));
       dac_sleep_int   <= cntl_reg0(1);
       dac_txen_int    <= cntl_reg0(2);
	end if;
end process;

dac_txena    <= dac_txen_int;
dac_sleep    <= dac_sleep_int;
dac_resetb   <= not dac_reset_int;


--------------------------------------------------------------------------------
-- Interrupt Source
--------------------------------------------------------------------------------
-- Interrupt
-- Bit [0]     - DAC0 Alarm

int_src_stat <= dac_alarm;
                    
end Behavioral;