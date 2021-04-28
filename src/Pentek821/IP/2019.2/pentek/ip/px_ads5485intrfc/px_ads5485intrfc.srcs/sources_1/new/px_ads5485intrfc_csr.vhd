----------------------------------------------------------------------------------
-- Control/Status Registers for Pentek ADS5485 ADC Interface
----------------------------------------------------------------------------------
-- px_ads5485intrfc_csr.vhd
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

-- Memory Map
-- 0x00 - Control 1
-- 0x04 - Control 2
-- 0x08 - Offset/Gain Trim 
-- 0x0C - Reserved
-- 0x10 - Reserved
-- 0x14 - Interrupt Enables
-- 0x18 - Interrupt Status
-- 0x1C - Interrupt Flags

-- Control 1
--Bit [8:0]  - Tap Delay
--Bit [9]    - VTC Disable 

-- Control 2
--Bit [1:0] - Integer Clock Delay 
--Bit [2]   - Two's Comp 
--Bit [3]   - Dither
--Bit [4]   - Power Down
--Bit [6:5]- LED Source Select  00 = ADC OVLD 01 = G/O OVLD 10 = Ext Sig 11 = Disabled  
--Bit [31:16]- Overload Threshold Count

-- Control 2
--Bit [15:0] - Gain
--Bit [31:16]- Offset

-- Interrupts
-- Bit [0] ADC Overload
-- Bit [1] G/O Overload

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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_ads5485intrfc_csr is
generic(
    initial_tap_delay   : integer := 0;
    initial_gain        : std_logic_vector(15 downto 0) := x"8000";  
    initial_offset      : std_logic_vector(15 downto 0) := x"0000";  
    initial_2scomp      : boolean := true; 
    initial_led_select  : integer range 0 to 3 := 0;
    initial_ovld_thresh : integer := 16;
    initial_pdwnf       : boolean := false; 
    initial_dither      : boolean := false 
);
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    s_axi_csr_aclk         : in  std_logic;
    s_axi_csr_aresetn      : in  std_logic;
    s_axi_csr_awaddr       : in  std_logic_vector(6 downto 0); 
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
    s_axi_csr_araddr       : in  std_logic_vector(6 downto 0);  
    s_axi_csr_arprot       : in  std_logic_vector(2 downto 0);
    s_axi_csr_arvalid      : in  std_logic;
    s_axi_csr_arready      : out std_logic;
    s_axi_csr_rdata        : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp        : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid       : out std_logic;
    s_axi_csr_rready       : in  std_logic;
    
    irq                   : out std_logic; -- interrupt
--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------    
    tap_delay             : out std_logic_vector(8 downto 0);
    int_delay             : out std_logic_vector(1 downto 0);
    twoscomp              : out std_logic;
    gain                  : out std_logic_vector(15 downto 0); 
    offset                : out std_logic_vector(15 downto 0); 
    ovld_thresh_cnt       : out std_logic_vector(15 downto 0);            
    led_sel               : out std_logic_vector(1 downto 0); 
    pdwnf                 : out std_logic;
    dither                : out std_logic;
    --en_vtc                : out std_logic;
    dly_ld_ctl            : out std_logic;
-------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------
    adc_overload          : in  std_logic;
    go_overload           : in  std_logic
);
end  px_ads5485intrfc_csr;

architecture Behavioral of px_ads5485intrfc_csr is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Generic AXI-Lite Control/Status Register Set
component px_axil_csr_ads
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
    reg1_init_val : in std_logic_vector(31 downto 0);
    reg2_init_val : in std_logic_vector(31 downto 0);
    ctl0_out : out std_logic_vector(31 downto 0);
    ctl1_out : out std_logic_vector(31 downto 0);
    ctl2_out : out std_logic_vector(31 downto 0);
    stat0_in : in std_logic_vector(31 downto 0);
    stat1_in : in std_logic_vector(31 downto 0);
    intrpt_src_in : in std_logic_vector(1 downto 0);
    irq : out std_logic
  );
end component;


--------------------------------------------------------------------------------
-- Functions
--------------------------------------------------------------------------------

function To_Std_Logic(L: BOOLEAN) return std_logic is
begin
    if L then
       return('1');
    else
       return('0');
    end if;
end function To_Std_Logic;

---------------------------------------------------------------------------------
-- Constants
---------------------------------------------------------------------------------
--Bit [1:0] - Integer Clock Delay 
--Bit [2]   - Two's Comp 
--Bit [3]   - Dither
--Bit [4]   - Power Down
--Bit [6:5]- LED Source Select  00 = ADC OVLD 01 = G/O OVLD 10 = Ext Sig 11 = Disabled  
--Bit [31:16]- Overload Threshold Count

constant CNTL_REG0_INIT_VAL: std_logic_vector(31 downto 0) := x"00000" & "000" & conv_std_logic_vector(initial_tap_delay, 9);
constant CNTL_REG1_INIT_VAL: std_logic_vector(31 downto 0) := conv_std_logic_vector(initial_ovld_thresh, 16) & "000000000" & 
                                                              conv_std_logic_vector(initial_led_select,2) & To_Std_Logic(initial_pdwnf) & To_Std_Logic(initial_dither) &
                                                               To_Std_Logic(initial_2scomp) & "00";
constant CNTL_REG2_INIT_VAL: std_logic_vector(31 downto 0) := initial_offset & initial_gain; 

---------------------------------------------------------------------------------
-- Signals
---------------------------------------------------------------------------------
 
signal cntl_reg0            : std_logic_vector(31 downto 0) := CNTL_REG0_INIT_VAL;
signal cntl_reg1            : std_logic_vector(31 downto 0) := CNTL_REG1_INIT_VAL;
signal cntl_reg2            : std_logic_vector(31 downto 0) := CNTL_REG2_INIT_VAL;
signal int_src_stat         : std_logic_vector(1 downto 0)  := (others => '0');

---------------------------------------------------------------------------------

begin

csr_inst: px_axil_csr_ads
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
    reg1_init_val       => CNTL_REG1_INIT_VAL,
    reg2_init_val       => CNTL_REG2_INIT_VAL,
    ctl0_out            => cntl_reg0,
    ctl1_out            => cntl_reg1,
    ctl2_out            => cntl_reg2,
    stat0_in            => x"00000000",
    stat1_in            => x"00000000",
    intrpt_src_in       => int_src_stat,
    irq                 => irq
  );

--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------
--Bit [8:0]  - Tap Delay

--Bit [1:0] - Integer Clock Delay 
--Bit [2]   - Two's Comp 
--Bit [3]   - Dither
--Bit [4]   - Power Down
--Bit [6:5]- LED Source Select  00 = ADC OVLD 01 = G/O OVLD 10 = Ext Sig 11 = Disabled  
--Bit [31:16]- Overload Threshold Count

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
       tap_delay           <= cntl_reg0(8 downto 0); 
       int_delay           <= cntl_reg1(1 downto 0);
       twoscomp            <= cntl_reg1(2);
       dither              <= cntl_reg1(3);
       pdwnf               <= cntl_reg1(4);
       led_sel             <= cntl_reg1(6 downto 5);
       ovld_thresh_cnt     <= cntl_reg1(31 downto 16);
       gain                <= cntl_reg2(15 downto 0);
       offset              <= cntl_reg2(31 downto 16);
       dly_ld_ctl          <= cntl_reg0(9);
    end if;
end process;

--en_vtc <= not cntl_reg0(9);

--------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------

-- Interrupts

int_src_stat <= go_overload & adc_overload;

                    
end Behavioral;