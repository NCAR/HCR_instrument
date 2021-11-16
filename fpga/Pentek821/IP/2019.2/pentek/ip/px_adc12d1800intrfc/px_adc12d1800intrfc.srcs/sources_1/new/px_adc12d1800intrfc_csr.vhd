----------------------------------------------------------------------------------
-- Control/Status Registers for Pentek ADS5485 ADC Interface
----------------------------------------------------------------------------------
-- ptk_ads5485_csr.vhd
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
----------------------------------------------------------------------------------

-- Memory Map
-- 0x00 - Control 1
-- 0x04 - Control 2
-- 0x08 - Offset/Gain Trim 
-- 0x0C - ADC Serial Control
-- 0x10 - ADC Serial Status
-- 0x14 - Interrupt Enables
-- 0x18 - Interrupt Status
-- 0x1C - Interrupt Flags

-- Control 1
--Bit [8:0]  - Tap Delay
--Bit [9]    - tap delay load
--Bit [10]   - adc_des             
--Bit [11]   - adc_tpm             
--Bit [12]   - adc_ddr_ph          
--Bit [13]   - adc_ece_n           
--Bit [14]   - adc_cal_init        
--Bit [15]   - adc_spi_en_n        
--Bit [16]   - Test Pattern Detect State Machine Start
--Bit [17]   - Test Pattern Detect State Machine Reset   

-- Control 2
--Bit [1:0]  - Integer Clock Delay 
--Bit [2]    - Two's Comp 
--Bit [3]    - hr_rst_en -- Half Rate Divider Reset Enable for Non_Des Mode
--Bit [4]    - Reserved
--Bit [6:5]  - LED Source Select  00 = ADC OVLD 01 = G/O OVLD 10 = Ext Sig 11 = Disabled  
--Bit [31:16]- Overload Threshold Count

-- Offset/Gain Trim 
--Bit [15:0] - Gain
--Bit [31:16]- Offset

-- ADC12D1800 ADC Serial Control
--Bit [0]     - Serial Access Request (toggle)
--Bit [1]     - Serial Read/Write 0 = Write 1 = Read   
--Bit [12:8]  - Serial Address
--Bit [31:15] - Serial Write Data

-- ADC12D1800 ADC Serial Status
--Bit [0] - Serial Access Done
--Bit [31:15] - Serial Read Data

-- Interrupts
-- Bit [0] ADC Overload A
-- Bit [1] G/O Overload A
-- Bit [2] ADC Overload B
-- Bit [3] G/O Overload B
-- Bit [4] Serial Access Done
-- Bit [5] ADC Cal Done
-- Bit [6] Test Pattern ERROR

----------------------------------------------------------------------------------

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

entity px_adc12d1800intrfc_csr is
generic(
    initial_tap_delay   : integer := 0;
    initial_gain        : std_logic_vector(15 downto 0) := x"8000";  
    initial_offset      : std_logic_vector(15 downto 0) := x"0000";  
    initial_2scomp      : boolean := true; 
    initial_led_select  : integer range 0 to 3 := 0;
    initial_ovld_thresh : integer := 16
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
    hr_rst_en             : out std_logic;
    adc_des               : out std_logic; 
    adc_tpm               : out std_logic;
    adc_ddr_ph            : out std_logic;
    adc_ece_n             : out std_logic;
    adc_cal_init          : out std_logic;
    adc_spi_en_n          : out std_logic;
    pdet_rst_n            : out std_logic;
    pdet_start_pls        : out std_logic;
--    en_vtc                : out std_logic;
    dly_ld_ctl            : out std_logic;
    -- Serial Control Interface
    ser_wr_data           : out std_logic_vector(15 downto 0); 
    ser_addr              : out std_logic_vector(4 downto 0);  
    ser_wr_pls            : out std_logic;  
    ser_rd_pls            : out std_logic;  
    ser_rd_data           : in  std_logic_vector(15 downto 0);
    -- Status
    adc_cal_done          : in  std_logic;
    ser_sm_rdy            : in  std_logic;
-------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------
    adc_overload_a        : in  std_logic;
    adc_overload_b        : in  std_logic;
    go_overload_a         : in  std_logic;
    go_overload_b         : in  std_logic;
    pdet_error            : in  std_logic
);
end  px_adc12d1800intrfc_csr;

architecture Behavioral of px_adc12d1800intrfc_csr is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Generic AXI-Lite Control/Status Register Set
COMPONENT px_axil_csr_adc12d1800
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
    reg1_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    reg2_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    reg3_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl0_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl1_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl2_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl3_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat0_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    intrpt_src_in : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    irq : OUT STD_LOGIC
  );
END COMPONENT;


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

constant CNTL_REG0_INIT_VAL: std_logic_vector(31 downto 0) := x"00008" & "010" & conv_std_logic_vector(initial_tap_delay, 9);
constant CNTL_REG1_INIT_VAL: std_logic_vector(31 downto 0) := conv_std_logic_vector(initial_ovld_thresh, 16) & "000000000" & 
                                                              conv_std_logic_vector(initial_led_select,2) & '0' & '0' &
                                                               To_Std_Logic(initial_2scomp) & "00";
constant CNTL_REG2_INIT_VAL: std_logic_vector(31 downto 0) := initial_offset & initial_gain; 
constant CNTL_REG3_INIT_VAL: std_logic_vector(31 downto 0) := (others => '0');

---------------------------------------------------------------------------------
-- Signals
---------------------------------------------------------------------------------
 
signal cntl_reg0            : std_logic_vector(31 downto 0) := CNTL_REG0_INIT_VAL;
signal cntl_reg1            : std_logic_vector(31 downto 0) := CNTL_REG1_INIT_VAL;
signal cntl_reg2            : std_logic_vector(31 downto 0) := CNTL_REG2_INIT_VAL;
signal cntl_reg3            : std_logic_vector(31 downto 0) := CNTL_REG3_INIT_VAL;
signal int_src_stat         : std_logic_vector(6 downto 0)  := (others => '0');
signal stat0_in             : std_logic_vector(31 downto 0) := (others => '0');
signal t1_ser_access        : std_logic := '0';
signal t1_ser_sm_rdy        : std_logic := '0';
signal ser_sm_rdy_int       : std_logic := '0';
signal t1_cntl_reg0_16      : std_logic := '0';
---------------------------------------------------------------------------------

begin

csr_inst: px_axil_csr_adc12d1800
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
    reg3_init_val       => CNTL_REG3_INIT_VAL,
    ctl0_out            => cntl_reg0,
    ctl1_out            => cntl_reg1,
    ctl2_out            => cntl_reg2,
    ctl3_out            => cntl_reg3,
    stat0_in            => stat0_in,
    intrpt_src_in       => int_src_stat,
    irq                 => irq
  );

--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------
-- Control 1
--Bit [8:0]  - Tap Delay
--Bit [9]    - VTC Disable
--Bit [10]   - adc_des             
--Bit [11]   - adc_tpm             
--Bit [12]   - adc_ddr_ph          
--Bit [13]   - adc_ece_n           
--Bit [14]   - adc_cal_init        
--Bit [15]   - adc_spi_en_n       
-- Control 2
--Bit [1:0] - Integer Clock Delay 
--Bit [2]   - Two's Comp 
--Bit [3]   - hr_rst_en
--Bit [4]   - 
--Bit [6:5]- LED Source Select  00 = ADC OVLD 01 = G/O OVLD 10 = Ext Sig 11 = Disabled  
--Bit [31:16]- Overload Threshold Count

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
       tap_delay           <= cntl_reg0(8 downto 0);
       adc_des             <= cntl_reg0(10);
       adc_tpm             <= cntl_reg0(11);
       adc_ddr_ph          <= cntl_reg0(12);
       adc_ece_n           <= cntl_reg0(13);
       adc_cal_init        <= cntl_reg0(14);
       adc_spi_en_n        <= cntl_reg0(15);
       int_delay           <= cntl_reg1(1 downto 0);
       twoscomp            <= cntl_reg1(2);
       hr_rst_en           <= cntl_reg1(3);
       led_sel             <= cntl_reg1(6 downto 5);
       ovld_thresh_cnt     <= cntl_reg1(31 downto 16);
       gain                <= cntl_reg2(15 downto 0);
       offset              <= cntl_reg2(31 downto 16);
       dly_ld_ctl          <= cntl_reg0(9);
       pdet_rst_n          <= not ((not s_axi_csr_aresetn) or cntl_reg0(17));
       pdet_start_pls      <= cntl_reg0(16) and not t1_cntl_reg0_16;
       t1_cntl_reg0_16     <= cntl_reg0(16);
    end if;
end process;

--en_vtc <= not cntl_reg0(9);

-- ADC12D1800 ADC Serial Control
--Bit [0]     - Serial Access Request (toggle)
--Bit [1]     - Serial Read/Write 0 = Write 1 = Read   
--Bit [12:8]  - Serial Address
--Bit [31:15] - Serial Write Data
process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
        ser_wr_data   <= cntl_reg3(31 downto 16);
        ser_addr      <= cntl_reg3(12 downto 8);
        t1_ser_access <= cntl_reg3(0);
        ser_wr_pls    <= cntl_reg3(0) and (not t1_ser_access) and (not cntl_reg3(1));
        ser_rd_pls    <= cntl_reg3(0) and (not t1_ser_access) and (cntl_reg3(1));
    end if;
end process;

--------------------------------------------------------------------------------
-- Status
--------------------------------------------------------------------------------
process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
       stat0_in(0)            <= ser_sm_rdy;
       stat0_in(31 downto 16) <= ser_rd_data; 
       t1_ser_sm_rdy          <= ser_sm_rdy;
       ser_sm_rdy_int         <= ser_sm_rdy and not t1_ser_sm_rdy;
       stat0_in(1)            <= adc_cal_done;
    end if;
end process;

stat0_in(15 downto 2) <= (others => '0');

--------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------

-- Interrupts

int_src_stat <= pdet_error & adc_cal_done & ser_sm_rdy_int & go_overload_b & go_overload_a & adc_overload_b & adc_overload_a;

                    
end Behavioral;