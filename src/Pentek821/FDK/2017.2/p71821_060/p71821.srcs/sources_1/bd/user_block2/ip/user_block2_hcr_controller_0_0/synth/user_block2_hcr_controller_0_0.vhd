-- (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
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

-- IP VLNV: NCAR:EOL:hcr_controller:1.0
-- IP Revision: 2104232021

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY user_block2_hcr_controller_0_0 IS
  PORT (
    pps_ce0 : OUT STD_LOGIC;
    pps_we0 : OUT STD_LOGIC;
    mt_pulse_V_ap_vld : OUT STD_LOGIC;
    control_flags_V_ap_vld : OUT STD_LOGIC;
    filter_select_ch0_V_ap_vld : OUT STD_LOGIC;
    filter_select_ch1_V_ap_vld : OUT STD_LOGIC;
    filter_select_ch2_V_ap_vld : OUT STD_LOGIC;
    s_axi_cfg_bus_AWADDR : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
    s_axi_cfg_bus_AWVALID : IN STD_LOGIC;
    s_axi_cfg_bus_AWREADY : OUT STD_LOGIC;
    s_axi_cfg_bus_WDATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_cfg_bus_WSTRB : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_cfg_bus_WVALID : IN STD_LOGIC;
    s_axi_cfg_bus_WREADY : OUT STD_LOGIC;
    s_axi_cfg_bus_BRESP : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_cfg_bus_BVALID : OUT STD_LOGIC;
    s_axi_cfg_bus_BREADY : IN STD_LOGIC;
    s_axi_cfg_bus_ARADDR : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
    s_axi_cfg_bus_ARVALID : IN STD_LOGIC;
    s_axi_cfg_bus_ARREADY : OUT STD_LOGIC;
    s_axi_cfg_bus_RDATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_cfg_bus_RRESP : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_cfg_bus_RVALID : OUT STD_LOGIC;
    s_axi_cfg_bus_RREADY : IN STD_LOGIC;
    ap_clk : IN STD_LOGIC;
    ap_rst_n : IN STD_LOGIC;
    interrupt : OUT STD_LOGIC;
    coef_ch0_V_V_TVALID : OUT STD_LOGIC;
    coef_ch0_V_V_TREADY : IN STD_LOGIC;
    coef_ch0_V_V_TDATA : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
    coef_ch1_V_V_TVALID : OUT STD_LOGIC;
    coef_ch1_V_V_TREADY : IN STD_LOGIC;
    coef_ch1_V_V_TDATA : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
    coef_ch2_V_V_TVALID : OUT STD_LOGIC;
    coef_ch2_V_V_TREADY : IN STD_LOGIC;
    coef_ch2_V_V_TDATA : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
    mt_pulse_V : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    control_flags_V : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    filter_select_ch0_V : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    filter_select_ch1_V : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    filter_select_ch2_V : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    pulse_metadata_ch0_V_TVALID : OUT STD_LOGIC;
    pulse_metadata_ch0_V_TREADY : IN STD_LOGIC;
    pulse_metadata_ch0_V_TDATA : OUT STD_LOGIC_VECTOR(823 DOWNTO 0);
    pulse_metadata_ch1_V_TVALID : OUT STD_LOGIC;
    pulse_metadata_ch1_V_TREADY : IN STD_LOGIC;
    pulse_metadata_ch1_V_TDATA : OUT STD_LOGIC_VECTOR(823 DOWNTO 0);
    pulse_metadata_ch2_V_TVALID : OUT STD_LOGIC;
    pulse_metadata_ch2_V_TREADY : IN STD_LOGIC;
    pulse_metadata_ch2_V_TDATA : OUT STD_LOGIC_VECTOR(823 DOWNTO 0);
    pps_address0 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    pps_d0 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    pps_q0 : IN STD_LOGIC_VECTOR(0 DOWNTO 0)
  );
END user_block2_hcr_controller_0_0;

ARCHITECTURE user_block2_hcr_controller_0_0_arch OF user_block2_hcr_controller_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF user_block2_hcr_controller_0_0_arch: ARCHITECTURE IS "yes";
  COMPONENT hcr_controller IS
    GENERIC (
      C_S_AXI_CFG_BUS_ADDR_WIDTH : INTEGER;
      C_S_AXI_CFG_BUS_DATA_WIDTH : INTEGER
    );
    PORT (
      pps_ce0 : OUT STD_LOGIC;
      pps_we0 : OUT STD_LOGIC;
      mt_pulse_V_ap_vld : OUT STD_LOGIC;
      control_flags_V_ap_vld : OUT STD_LOGIC;
      filter_select_ch0_V_ap_vld : OUT STD_LOGIC;
      filter_select_ch1_V_ap_vld : OUT STD_LOGIC;
      filter_select_ch2_V_ap_vld : OUT STD_LOGIC;
      s_axi_cfg_bus_AWADDR : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
      s_axi_cfg_bus_AWVALID : IN STD_LOGIC;
      s_axi_cfg_bus_AWREADY : OUT STD_LOGIC;
      s_axi_cfg_bus_WDATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      s_axi_cfg_bus_WSTRB : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      s_axi_cfg_bus_WVALID : IN STD_LOGIC;
      s_axi_cfg_bus_WREADY : OUT STD_LOGIC;
      s_axi_cfg_bus_BRESP : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      s_axi_cfg_bus_BVALID : OUT STD_LOGIC;
      s_axi_cfg_bus_BREADY : IN STD_LOGIC;
      s_axi_cfg_bus_ARADDR : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
      s_axi_cfg_bus_ARVALID : IN STD_LOGIC;
      s_axi_cfg_bus_ARREADY : OUT STD_LOGIC;
      s_axi_cfg_bus_RDATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      s_axi_cfg_bus_RRESP : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      s_axi_cfg_bus_RVALID : OUT STD_LOGIC;
      s_axi_cfg_bus_RREADY : IN STD_LOGIC;
      ap_clk : IN STD_LOGIC;
      ap_rst_n : IN STD_LOGIC;
      interrupt : OUT STD_LOGIC;
      coef_ch0_V_V_TVALID : OUT STD_LOGIC;
      coef_ch0_V_V_TREADY : IN STD_LOGIC;
      coef_ch0_V_V_TDATA : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
      coef_ch1_V_V_TVALID : OUT STD_LOGIC;
      coef_ch1_V_V_TREADY : IN STD_LOGIC;
      coef_ch1_V_V_TDATA : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
      coef_ch2_V_V_TVALID : OUT STD_LOGIC;
      coef_ch2_V_V_TREADY : IN STD_LOGIC;
      coef_ch2_V_V_TDATA : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
      mt_pulse_V : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      control_flags_V : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      filter_select_ch0_V : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      filter_select_ch1_V : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      filter_select_ch2_V : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      pulse_metadata_ch0_V_TVALID : OUT STD_LOGIC;
      pulse_metadata_ch0_V_TREADY : IN STD_LOGIC;
      pulse_metadata_ch0_V_TDATA : OUT STD_LOGIC_VECTOR(823 DOWNTO 0);
      pulse_metadata_ch1_V_TVALID : OUT STD_LOGIC;
      pulse_metadata_ch1_V_TREADY : IN STD_LOGIC;
      pulse_metadata_ch1_V_TDATA : OUT STD_LOGIC_VECTOR(823 DOWNTO 0);
      pulse_metadata_ch2_V_TVALID : OUT STD_LOGIC;
      pulse_metadata_ch2_V_TREADY : IN STD_LOGIC;
      pulse_metadata_ch2_V_TDATA : OUT STD_LOGIC_VECTOR(823 DOWNTO 0);
      pps_address0 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      pps_d0 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      pps_q0 : IN STD_LOGIC_VECTOR(0 DOWNTO 0)
    );
  END COMPONENT hcr_controller;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF user_block2_hcr_controller_0_0_arch: ARCHITECTURE IS "hcr_controller,Vivado 2017.2";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF user_block2_hcr_controller_0_0_arch : ARCHITECTURE IS "user_block2_hcr_controller_0_0,hcr_controller,{}";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_cfg_bus_AWADDR: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_cfg_bus AWADDR";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_cfg_bus_AWVALID: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_cfg_bus AWVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_cfg_bus_AWREADY: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_cfg_bus AWREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_cfg_bus_WDATA: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_cfg_bus WDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_cfg_bus_WSTRB: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_cfg_bus WSTRB";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_cfg_bus_WVALID: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_cfg_bus WVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_cfg_bus_WREADY: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_cfg_bus WREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_cfg_bus_BRESP: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_cfg_bus BRESP";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_cfg_bus_BVALID: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_cfg_bus BVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_cfg_bus_BREADY: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_cfg_bus BREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_cfg_bus_ARADDR: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_cfg_bus ARADDR";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_cfg_bus_ARVALID: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_cfg_bus ARVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_cfg_bus_ARREADY: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_cfg_bus ARREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_cfg_bus_RDATA: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_cfg_bus RDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_cfg_bus_RRESP: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_cfg_bus RRESP";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_cfg_bus_RVALID: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_cfg_bus RVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_cfg_bus_RREADY: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_cfg_bus RREADY";
  ATTRIBUTE X_INTERFACE_INFO OF ap_clk: SIGNAL IS "xilinx.com:signal:clock:1.0 ap_clk CLK";
  ATTRIBUTE X_INTERFACE_INFO OF ap_rst_n: SIGNAL IS "xilinx.com:signal:reset:1.0 ap_rst_n RST";
  ATTRIBUTE X_INTERFACE_INFO OF interrupt: SIGNAL IS "xilinx.com:signal:interrupt:1.0 interrupt INTERRUPT";
  ATTRIBUTE X_INTERFACE_INFO OF coef_ch0_V_V_TVALID: SIGNAL IS "xilinx.com:interface:axis:1.0 coef_ch0_V_V TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF coef_ch0_V_V_TREADY: SIGNAL IS "xilinx.com:interface:axis:1.0 coef_ch0_V_V TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF coef_ch0_V_V_TDATA: SIGNAL IS "xilinx.com:interface:axis:1.0 coef_ch0_V_V TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF coef_ch1_V_V_TVALID: SIGNAL IS "xilinx.com:interface:axis:1.0 coef_ch1_V_V TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF coef_ch1_V_V_TREADY: SIGNAL IS "xilinx.com:interface:axis:1.0 coef_ch1_V_V TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF coef_ch1_V_V_TDATA: SIGNAL IS "xilinx.com:interface:axis:1.0 coef_ch1_V_V TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF coef_ch2_V_V_TVALID: SIGNAL IS "xilinx.com:interface:axis:1.0 coef_ch2_V_V TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF coef_ch2_V_V_TREADY: SIGNAL IS "xilinx.com:interface:axis:1.0 coef_ch2_V_V TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF coef_ch2_V_V_TDATA: SIGNAL IS "xilinx.com:interface:axis:1.0 coef_ch2_V_V TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF mt_pulse_V: SIGNAL IS "xilinx.com:signal:data:1.0 mt_pulse_V DATA";
  ATTRIBUTE X_INTERFACE_INFO OF control_flags_V: SIGNAL IS "xilinx.com:signal:data:1.0 control_flags_V DATA";
  ATTRIBUTE X_INTERFACE_INFO OF filter_select_ch0_V: SIGNAL IS "xilinx.com:signal:data:1.0 filter_select_ch0_V DATA";
  ATTRIBUTE X_INTERFACE_INFO OF filter_select_ch1_V: SIGNAL IS "xilinx.com:signal:data:1.0 filter_select_ch1_V DATA";
  ATTRIBUTE X_INTERFACE_INFO OF filter_select_ch2_V: SIGNAL IS "xilinx.com:signal:data:1.0 filter_select_ch2_V DATA";
  ATTRIBUTE X_INTERFACE_INFO OF pulse_metadata_ch0_V_TVALID: SIGNAL IS "xilinx.com:interface:axis:1.0 pulse_metadata_ch0_V TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF pulse_metadata_ch0_V_TREADY: SIGNAL IS "xilinx.com:interface:axis:1.0 pulse_metadata_ch0_V TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF pulse_metadata_ch0_V_TDATA: SIGNAL IS "xilinx.com:interface:axis:1.0 pulse_metadata_ch0_V TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF pulse_metadata_ch1_V_TVALID: SIGNAL IS "xilinx.com:interface:axis:1.0 pulse_metadata_ch1_V TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF pulse_metadata_ch1_V_TREADY: SIGNAL IS "xilinx.com:interface:axis:1.0 pulse_metadata_ch1_V TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF pulse_metadata_ch1_V_TDATA: SIGNAL IS "xilinx.com:interface:axis:1.0 pulse_metadata_ch1_V TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF pulse_metadata_ch2_V_TVALID: SIGNAL IS "xilinx.com:interface:axis:1.0 pulse_metadata_ch2_V TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF pulse_metadata_ch2_V_TREADY: SIGNAL IS "xilinx.com:interface:axis:1.0 pulse_metadata_ch2_V TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF pulse_metadata_ch2_V_TDATA: SIGNAL IS "xilinx.com:interface:axis:1.0 pulse_metadata_ch2_V TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF pps_address0: SIGNAL IS "xilinx.com:signal:data:1.0 pps_address0 DATA";
  ATTRIBUTE X_INTERFACE_INFO OF pps_d0: SIGNAL IS "xilinx.com:signal:data:1.0 pps_d0 DATA";
  ATTRIBUTE X_INTERFACE_INFO OF pps_q0: SIGNAL IS "xilinx.com:signal:data:1.0 pps_q0 DATA";
BEGIN
  U0 : hcr_controller
    GENERIC MAP (
      C_S_AXI_CFG_BUS_ADDR_WIDTH => 13,
      C_S_AXI_CFG_BUS_DATA_WIDTH => 32
    )
    PORT MAP (
      pps_ce0 => pps_ce0,
      pps_we0 => pps_we0,
      mt_pulse_V_ap_vld => mt_pulse_V_ap_vld,
      control_flags_V_ap_vld => control_flags_V_ap_vld,
      filter_select_ch0_V_ap_vld => filter_select_ch0_V_ap_vld,
      filter_select_ch1_V_ap_vld => filter_select_ch1_V_ap_vld,
      filter_select_ch2_V_ap_vld => filter_select_ch2_V_ap_vld,
      s_axi_cfg_bus_AWADDR => s_axi_cfg_bus_AWADDR,
      s_axi_cfg_bus_AWVALID => s_axi_cfg_bus_AWVALID,
      s_axi_cfg_bus_AWREADY => s_axi_cfg_bus_AWREADY,
      s_axi_cfg_bus_WDATA => s_axi_cfg_bus_WDATA,
      s_axi_cfg_bus_WSTRB => s_axi_cfg_bus_WSTRB,
      s_axi_cfg_bus_WVALID => s_axi_cfg_bus_WVALID,
      s_axi_cfg_bus_WREADY => s_axi_cfg_bus_WREADY,
      s_axi_cfg_bus_BRESP => s_axi_cfg_bus_BRESP,
      s_axi_cfg_bus_BVALID => s_axi_cfg_bus_BVALID,
      s_axi_cfg_bus_BREADY => s_axi_cfg_bus_BREADY,
      s_axi_cfg_bus_ARADDR => s_axi_cfg_bus_ARADDR,
      s_axi_cfg_bus_ARVALID => s_axi_cfg_bus_ARVALID,
      s_axi_cfg_bus_ARREADY => s_axi_cfg_bus_ARREADY,
      s_axi_cfg_bus_RDATA => s_axi_cfg_bus_RDATA,
      s_axi_cfg_bus_RRESP => s_axi_cfg_bus_RRESP,
      s_axi_cfg_bus_RVALID => s_axi_cfg_bus_RVALID,
      s_axi_cfg_bus_RREADY => s_axi_cfg_bus_RREADY,
      ap_clk => ap_clk,
      ap_rst_n => ap_rst_n,
      interrupt => interrupt,
      coef_ch0_V_V_TVALID => coef_ch0_V_V_TVALID,
      coef_ch0_V_V_TREADY => coef_ch0_V_V_TREADY,
      coef_ch0_V_V_TDATA => coef_ch0_V_V_TDATA,
      coef_ch1_V_V_TVALID => coef_ch1_V_V_TVALID,
      coef_ch1_V_V_TREADY => coef_ch1_V_V_TREADY,
      coef_ch1_V_V_TDATA => coef_ch1_V_V_TDATA,
      coef_ch2_V_V_TVALID => coef_ch2_V_V_TVALID,
      coef_ch2_V_V_TREADY => coef_ch2_V_V_TREADY,
      coef_ch2_V_V_TDATA => coef_ch2_V_V_TDATA,
      mt_pulse_V => mt_pulse_V,
      control_flags_V => control_flags_V,
      filter_select_ch0_V => filter_select_ch0_V,
      filter_select_ch1_V => filter_select_ch1_V,
      filter_select_ch2_V => filter_select_ch2_V,
      pulse_metadata_ch0_V_TVALID => pulse_metadata_ch0_V_TVALID,
      pulse_metadata_ch0_V_TREADY => pulse_metadata_ch0_V_TREADY,
      pulse_metadata_ch0_V_TDATA => pulse_metadata_ch0_V_TDATA,
      pulse_metadata_ch1_V_TVALID => pulse_metadata_ch1_V_TVALID,
      pulse_metadata_ch1_V_TREADY => pulse_metadata_ch1_V_TREADY,
      pulse_metadata_ch1_V_TDATA => pulse_metadata_ch1_V_TDATA,
      pulse_metadata_ch2_V_TVALID => pulse_metadata_ch2_V_TVALID,
      pulse_metadata_ch2_V_TREADY => pulse_metadata_ch2_V_TREADY,
      pulse_metadata_ch2_V_TDATA => pulse_metadata_ch2_V_TDATA,
      pps_address0 => pps_address0,
      pps_d0 => pps_d0,
      pps_q0 => pps_q0
    );
END user_block2_hcr_controller_0_0_arch;
