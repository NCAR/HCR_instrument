-- (c) Copyright 1995-2017 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: pentek.com:px_ip:px_axil_csr:1.0
-- IP Revision: 18

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY px_vita49_unpkt_px_axil_csr IS
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
    intrpt_src_in : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    irq : OUT STD_LOGIC
  );
END px_vita49_unpkt_px_axil_csr;

ARCHITECTURE px_vita49_unpkt_px_axil_csr_arch OF px_vita49_unpkt_px_axil_csr IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF px_vita49_unpkt_px_axil_csr_arch: ARCHITECTURE IS "yes";
  COMPONENT px_axil_csr IS
    GENERIC (
      num_ctl_regs : INTEGER;
      num_stat_regs : INTEGER;
      has_interrupt_regs : BOOLEAN;
      num_interrupt_src : INTEGER
    );
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
      reg4_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      reg5_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      reg6_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      reg7_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      ctl0_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      ctl1_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      ctl2_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      ctl3_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      ctl4_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      ctl5_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      ctl6_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      ctl7_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      stat0_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      stat1_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      stat2_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      stat3_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      stat4_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      stat5_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      stat6_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      stat7_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      intrpt_src_in : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      irq : OUT STD_LOGIC
    );
  END COMPONENT px_axil_csr;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF px_vita49_unpkt_px_axil_csr_arch: ARCHITECTURE IS "px_axil_csr,Vivado 2017.2";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF px_vita49_unpkt_px_axil_csr_arch : ARCHITECTURE IS "px_vita49_unpkt_px_axil_csr,px_axil_csr,{}";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_aclk: SIGNAL IS "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_aresetn: SIGNAL IS "xilinx.com:signal:reset:1.0 s_axi_csr_aresetn RST";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_awaddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr AWADDR";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_awprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr AWPROT";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_awvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr AWVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_awready: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr AWREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_wdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr WDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_wstrb: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr WSTRB";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_wvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr WVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_wready: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr WREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_bresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr BRESP";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_bvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr BVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_bready: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr BREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_araddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr ARADDR";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_arprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr ARPROT";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_arvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr ARVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_arready: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr ARREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_rdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr RDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_rresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr RRESP";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_rvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr RVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_rready: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr RREADY";
  ATTRIBUTE X_INTERFACE_INFO OF irq: SIGNAL IS "xilinx.com:signal:interrupt:1.0 irq INTERRUPT";
BEGIN
  U0 : px_axil_csr
    GENERIC MAP (
      num_ctl_regs => 1,
      num_stat_regs => 0,
      has_interrupt_regs => true,
      num_interrupt_src => 1
    )
    PORT MAP (
      s_axi_csr_aclk => s_axi_csr_aclk,
      s_axi_csr_aresetn => s_axi_csr_aresetn,
      s_axi_csr_awaddr => s_axi_csr_awaddr,
      s_axi_csr_awprot => s_axi_csr_awprot,
      s_axi_csr_awvalid => s_axi_csr_awvalid,
      s_axi_csr_awready => s_axi_csr_awready,
      s_axi_csr_wdata => s_axi_csr_wdata,
      s_axi_csr_wstrb => s_axi_csr_wstrb,
      s_axi_csr_wvalid => s_axi_csr_wvalid,
      s_axi_csr_wready => s_axi_csr_wready,
      s_axi_csr_bresp => s_axi_csr_bresp,
      s_axi_csr_bvalid => s_axi_csr_bvalid,
      s_axi_csr_bready => s_axi_csr_bready,
      s_axi_csr_araddr => s_axi_csr_araddr,
      s_axi_csr_arprot => s_axi_csr_arprot,
      s_axi_csr_arvalid => s_axi_csr_arvalid,
      s_axi_csr_arready => s_axi_csr_arready,
      s_axi_csr_rdata => s_axi_csr_rdata,
      s_axi_csr_rresp => s_axi_csr_rresp,
      s_axi_csr_rvalid => s_axi_csr_rvalid,
      s_axi_csr_rready => s_axi_csr_rready,
      reg0_init_val => reg0_init_val,
      reg1_init_val => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      reg2_init_val => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      reg3_init_val => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      reg4_init_val => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      reg5_init_val => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      reg6_init_val => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      reg7_init_val => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      ctl0_out => ctl0_out,
      stat0_in => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      stat1_in => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      stat2_in => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      stat3_in => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      stat4_in => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      stat5_in => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      stat6_in => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      stat7_in => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      intrpt_src_in => intrpt_src_in,
      irq => irq
    );
END px_vita49_unpkt_px_axil_csr_arch;
