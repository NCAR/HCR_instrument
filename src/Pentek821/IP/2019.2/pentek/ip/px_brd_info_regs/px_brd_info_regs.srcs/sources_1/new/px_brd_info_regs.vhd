----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2015 09:56:42 AM
-- Design Name: 
-- Module Name: px_brd_info_regs - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Board Info Status Registers & byte swap control reg
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_brd_info_regs is
generic(
   has_rev_info_in  : boolean := false;
   has_fpga_size_in : boolean := false;
   board_id         : std_logic_vector(15 downto 0) := x"7180";   -- Board Type (with Mezzanine modifier included) 
   fpga_code_id     : std_logic_vector(19 downto 0) := x"71800";  -- FPGA Code type
   fpga_size        : string := "060"; -- "025", "035", "040", "060" , "085", "095", "115"
   has_fpio_in      : boolean                       := true;      -- Has Front Panel IO ID input
   has_link_stat_in : boolean                       := true;      -- Has Link Status Inputs
   fpga_code_rev    : integer range 0 to 255        := 0;         -- 0 = REV A    
   date_month       : integer range 1 to 12         := 4;         -- April/27/2015 Month,Day,Year 
   date_day         : integer range 1 to 31         := 27;
   date_year        : integer range 0 to 99         := 15;
   user_word        : std_logic_vector(31 downto 0) := x"00000000"; -- User Word 
   has_user_led_out : boolean := true; -- Has User LED Drive output
   has_sys_mon_led  : boolean := true;
   has_irq_out      : boolean := true;
   has_sys_mon_irq  : boolean := true; 
   has_ext_temp_irq : boolean := true;
   has_i2c1_irq     : boolean := true;
   has_i2c2_irq     : boolean := true;
   has_user1_irq    : boolean := true;   
   has_user2_irq    : boolean := true;
   has_user3_irq    : boolean := true;
   has_user4_irq    : boolean := true;
   has_user5_irq    : boolean := true;
   has_user6_irq    : boolean := true; 
   has_user7_irq    : boolean := true; 
   has_user8_irq    : boolean := true                
);
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
   s_axi_csr_aclk      : in  std_logic;
   s_axi_csr_aresetn   : in  std_logic;
   s_axi_csr_awaddr    : in  std_logic_vector(5 downto 0);
   s_axi_csr_awprot    : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_awvalid   : in  std_logic;
   s_axi_csr_awready   : out std_logic;
   s_axi_csr_wdata     : in  std_logic_vector(31 downto 0);
   s_axi_csr_wstrb     : in  std_logic_vector(3 downto 0); -- not used
   s_axi_csr_wvalid    : in  std_logic;
   s_axi_csr_wready    : out std_logic;
   s_axi_csr_bresp     : out std_logic_vector(1 downto 0);
   s_axi_csr_bvalid    : out std_logic;
   s_axi_csr_bready    : in  std_logic;
   s_axi_csr_araddr    : in  std_logic_vector(5 downto 0);
   s_axi_csr_arprot    : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_arvalid   : in  std_logic;
   s_axi_csr_arready   : out std_logic;
   s_axi_csr_rdata     : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp     : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid    : out std_logic;
   s_axi_csr_rready    : in  std_logic;
   
   irq                 : out std_logic;
--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------
   rev                 : in std_logic_vector(7 downto 0); -- FPGA Code Revision Input (only used when has_rev_info_in = true)
   rev_date            : in std_logic_vector(23 downto 0);  -- Month,Day,Year hex representation of Date ex. 03/21/15 = x"032115"  
   size                : in std_logic_vector(11 downto 0); -- FPGA Size example: -- x"025", x"035", x"040", x"060" , x"085", x"095", x"115"
   
   fpio                : in std_logic_vector(3 downto 0); -- Front Panel I/O ID Input 
   -- PCIe Link Status
   --pcie_link_status_info[3:0]   =  cfg_negotiated_width
   --pcie_link_status_info[6:4]   =  cfg_current_speed
   --pcie_link_status_info[7]            =  '0'
   --pcie_link_status_info[10:8]  =  cfg_max_payload
   --pcie_link_status_info[11]           =  '0'
   --pcie_link_status_info[14:12] =  cfg_max_read_req
   --pcie_link_status_info[15]           =  '0'
   --pcie_link_status_info[19:16] =  msi_en
   --pcie_link_status_info[31:20] =  "000000000000"   
   pcie_link_status_info: in std_logic_vector(31 downto 0); -- Link Status Input
   -- SYSTEM MONITOR Alarms
   ot                  : in std_logic;
   user_temp_alarm     : in std_logic;
   vccint_alarm        : in std_logic;
   vccaux_alarm        : in std_logic;
   
   ext_temp_irq_n      : in std_logic; 
   sys_mon_irq         : in std_logic; 
   i2c1_irq            : in std_logic; 
   i2c2_irq            : in std_logic; 
   user1_irq           : in std_logic; 
   user2_irq           : in std_logic; 
   user3_irq           : in std_logic; 
   user4_irq           : in std_logic; 
   user5_irq           : in std_logic; 
   user6_irq           : in std_logic; 
   user7_irq           : in std_logic; 
   user8_irq           : in std_logic; 
--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------
   byte_swap           : out std_logic;
   user_led_n          : out std_logic;
   sys_mon_led_n       : out std_logic
);
end px_brd_info_regs;

architecture Behavioral of px_brd_info_regs is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of sys_mon_irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 sys_mon_irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of sys_mon_irq: SIGNAL is "SENSITIVITY LEVEL_HIGH";
ATTRIBUTE X_INTERFACE_INFO of i2c1_irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 i2c1_irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of i2c1_irq: SIGNAL is "SENSITIVITY EDGE_RISING";
ATTRIBUTE X_INTERFACE_INFO of i2c2_irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 i2c2_irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of i2c2_irq: SIGNAL is "SENSITIVITY EDGE_RISING";
ATTRIBUTE X_INTERFACE_INFO of user1_irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 user1_irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of user1_irq: SIGNAL is "SENSITIVITY EDGE_RISING";
ATTRIBUTE X_INTERFACE_INFO of user2_irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 user2_irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of user2_irq: SIGNAL is "SENSITIVITY EDGE_RISING";
ATTRIBUTE X_INTERFACE_INFO of user3_irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 user3_irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of user3_irq: SIGNAL is "SENSITIVITY EDGE_RISING";
ATTRIBUTE X_INTERFACE_INFO of user4_irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 user4_irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of user4_irq: SIGNAL is "SENSITIVITY EDGE_RISING";
ATTRIBUTE X_INTERFACE_INFO of user5_irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 user5_irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of user5_irq: SIGNAL is "SENSITIVITY EDGE_RISING";
ATTRIBUTE X_INTERFACE_INFO of user6_irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 user6_irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of user6_irq: SIGNAL is "SENSITIVITY EDGE_RISING";
ATTRIBUTE X_INTERFACE_INFO of user7_irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 user7_irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of user7_irq: SIGNAL is "SENSITIVITY EDGE_RISING";
ATTRIBUTE X_INTERFACE_INFO of user8_irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 user8_irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of user8_irq: SIGNAL is "SENSITIVITY EDGE_RISING";

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Control/Status Registers
-- 1 Control Register
-- 7 Status Registers
-- No Interrupt Registers
component px_axil_csr_info
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
    stat2_in : in std_logic_vector(31 downto 0);
    stat3_in : in std_logic_vector(31 downto 0);
    stat4_in : in std_logic_vector(31 downto 0);
    stat5_in : in std_logic_vector(31 downto 0);
    stat6_in : in std_logic_vector(31 downto 0);
    intrpt_src_in : in std_logic_vector(11 downto 0);
    irq : out std_logic
  );
end component;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal ctl0_out     : std_logic_vector(31 downto 0) := x"00000000";
signal ctl1_out     : std_logic_vector(31 downto 0) := x"00000000";
signal ctl2_out     : std_logic_vector(31 downto 0) := x"00000000";
signal stat0_in     : std_logic_vector(31 downto 0) := x"00000000";
signal stat1_in     : std_logic_vector(31 downto 0) := x"00000000";
signal stat2_in     : std_logic_vector(31 downto 0) := x"00000000";
signal stat3_in     : std_logic_vector(31 downto 0) := x"00000000";
signal stat4_in     : std_logic_vector(31 downto 0) := x"00000000";
signal stat5_in     : std_logic_vector(31 downto 0) := x"00000000";
signal stat6_in     : std_logic_vector(31 downto 0) := x"00000000";
signal month        : std_logic_vector(7 downto 0)  := x"00";
signal day          : std_logic_vector(7 downto 0)  := x"00";
signal year         : std_logic_vector(7 downto 0)  := x"00";
signal intrpt_src_in: std_logic_vector(11 downto 0) := x"000";
signal awaddr       : std_logic_vector(6 downto 0)  := "0000000";
signal araddr       : std_logic_vector(6 downto 0)  := "0000000";
signal p_byte_swap  : std_logic                     := '0'; 
signal fpga_size_num: std_logic_vector(11 downto 0) := x"000";
signal rev_num      : std_logic_vector(31 downto 0) := x"00000000";
signal t1_rev_date  : std_logic_vector(23 downto 0) := x"000000";
signal t1_rev       : std_logic_vector(7 downto 0)  := x"00";
signal t1_s_axi_csr_aresetn: std_logic              := '0'; 
--------------------------------------------------------------------------------

begin

awaddr <= '0' & s_axi_csr_awaddr;
araddr <= '0' & s_axi_csr_araddr;

csr_inst : px_axil_csr_info
port map (
    s_axi_csr_aclk      => s_axi_csr_aclk,
    s_axi_csr_aresetn   => t1_s_axi_csr_aresetn,
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
    reg0_init_val       => x"00000000",
    reg1_init_val       => x"00000000",
    reg2_init_val       => x"00000000",
    ctl0_out            => ctl0_out,
    ctl1_out            => ctl1_out,
    ctl2_out            => ctl2_out,
    stat0_in            => stat0_in,
    stat1_in            => stat1_in,
    stat2_in            => stat2_in,
    stat3_in            => stat3_in,
    stat4_in            => stat4_in,
    stat5_in            => stat5_in,
    stat6_in            => stat6_in,
    intrpt_src_in       => intrpt_src_in,
    irq                 => irq
  );

gen_int_rev: if (has_rev_info_in = false) generate
  
month    <= (conv_std_logic_vector(date_month, 8)) when (date_month < 10) else ((conv_std_logic_vector(date_month/10, 4)) & (conv_std_logic_vector((date_month - ((date_month/10)*10)), 4)));
day      <= (conv_std_logic_vector(date_day  , 8)) when (date_day   < 10) else ((conv_std_logic_vector(date_day  /10, 4)) & (conv_std_logic_vector((date_day   - ((date_day  /10)*10)), 4)));
year     <= (conv_std_logic_vector(date_year , 8)) when (date_year  < 10) else ((conv_std_logic_vector(date_year /10, 4)) & (conv_std_logic_vector((date_year  - ((date_year /10)*10)), 4)));
rev_num  <= conv_std_logic_vector(fpga_code_rev, 32);

end generate;

gen_ext_rev: if (has_rev_info_in = true) generate

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then  
        t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
        t1_rev_date <= rev_date;
        t1_rev      <= rev;
        month       <= t1_rev_date(23 downto 16);
        day         <= t1_rev_date(15 downto 8);
        year        <= t1_rev_date(7 downto 0);
        rev_num(7 downto 0)  <= t1_rev;
    end if;
end process;

rev_num(31 downto 8)  <= x"000000"; 

end generate;

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
       if (ctl0_out = x"00000000") then
          p_byte_swap <= '0';
       else
          p_byte_swap <= '1';
       end if;
       byte_swap <= p_byte_swap;
    end if;
end process;

fpga_size_num <= size   when (has_fpga_size_in = true) else
                 x"025" when fpga_size = "025" else
                 x"035" when fpga_size = "035" else
                 x"040" when fpga_size = "040" else
                 x"060" when fpga_size = "060" else
                 x"085" when fpga_size = "085" else
                 x"095" when fpga_size = "095" else
                 x"115" when fpga_size = "115" else
                 x"000";



stat0_in   <= x"000"     & board_id & x"0"; -- Board Type (with Mezzanine modifier included) 
stat1_in   <= x"000"     & fpga_code_id;    -- FPGA Code type 
stat2_in   <= rev_num;   -- FPGA Revision
stat3_in   <= x"00"      & month & day & year;  -- FPGA Code Date 
stat4_in   <= (x"0" & fpga_size_num & x"000" & fpio)   when (has_fpio_in = true)  else x"0" & fpga_size_num & x"0000"; -- Front Panel I/O ID
stat5_in   <= user_word;                    -- User Word
stat6_in   <= pcie_link_status_info when (has_link_stat_in = true) else x"00000000"; -- Link Status

intrpt_src_in <= user8_irq & user7_irq & user6_irq &user5_irq & user4_irq & user3_irq & user2_irq & user1_irq & i2c2_irq & i2c1_irq & sys_mon_irq & (not ext_temp_irq_n); 

user_led_n     <= not ctl1_out(0);
sys_mon_led_n  <= not ((vccaux_alarm and ctl2_out(3)) or (vccint_alarm and ctl2_out(2)) or (user_temp_alarm and ctl2_out(1)) or (ot and ctl2_out(0)));
  
end Behavioral;
