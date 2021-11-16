-- (c) Copyright 1995-2018 Xilinx, Inc. All rights reserved.
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

-- IP VLNV: pentek.com:px_ip:px_axis_ppkt2ppld:1.0
-- IP Revision: 5

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb_px_axis_ppkt2ppld IS
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
    override_pkt_size_en : IN STD_LOGIC;
    override_pkt_size : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
    axis_aclk : IN STD_LOGIC;
    axis_aresetn : IN STD_LOGIC;
    fifo_rst_in_n : IN STD_LOGIC;
    s_axis_ppkt_tvalid : IN STD_LOGIC;
    s_axis_ppkt_tready : OUT STD_LOGIC;
    s_axis_ppkt_tdata : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
    s_axis_ppkt_tuser : IN STD_LOGIC_VECTOR(79 DOWNTO 0);
    s_axis_ppkt_tkeep : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_ppkt_tlast : IN STD_LOGIC;
    m_axis_pktfifo_aresetn : OUT STD_LOGIC;
    m_axis_pktfifo_tvalid : OUT STD_LOGIC;
    m_axis_pktfifo_tready : IN STD_LOGIC;
    m_axis_pktfifo_tdata : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
    m_axis_pktfifo_tuser : OUT STD_LOGIC_VECTOR(103 DOWNTO 0);
    m_axis_pktfifo_tkeep : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
    m_axis_pktfifo_tlast : OUT STD_LOGIC;
    s_axis_pktfifo_tvalid : IN STD_LOGIC;
    s_axis_pktfifo_tready : OUT STD_LOGIC;
    s_axis_pktfifo_tdata : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
    s_axis_pktfifo_tuser : IN STD_LOGIC_VECTOR(103 DOWNTO 0);
    s_axis_pktfifo_tkeep : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    s_axis_pktfifo_tlast : IN STD_LOGIC;
    m_axis_ppld_tvalid : OUT STD_LOGIC;
    m_axis_ppld_tready : IN STD_LOGIC;
    m_axis_ppld_tdata : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
    m_axis_ppld_tuser : OUT STD_LOGIC_VECTOR(103 DOWNTO 0);
    m_axis_ppld_tkeep : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
    m_axis_ppld_tlast : OUT STD_LOGIC
  );
END tb_px_axis_ppkt2ppld;

ARCHITECTURE tb_px_axis_ppkt2ppld_arch OF tb_px_axis_ppkt2ppld IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF tb_px_axis_ppkt2ppld_arch: ARCHITECTURE IS "yes";
  COMPONENT px_axis_ppkt2ppld IS
    GENERIC (
      word_width : INTEGER;
      default_packet_size : INTEGER;
      has_override : BOOLEAN;
      has_fifo_rst_in_n : BOOLEAN
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
      override_pkt_size_en : IN STD_LOGIC;
      override_pkt_size : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
      axis_aclk : IN STD_LOGIC;
      axis_aresetn : IN STD_LOGIC;
      fifo_rst_in_n : IN STD_LOGIC;
      s_axis_ppkt_tvalid : IN STD_LOGIC;
      s_axis_ppkt_tready : OUT STD_LOGIC;
      s_axis_ppkt_tdata : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
      s_axis_ppkt_tuser : IN STD_LOGIC_VECTOR(79 DOWNTO 0);
      s_axis_ppkt_tkeep : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      s_axis_ppkt_tlast : IN STD_LOGIC;
      m_axis_pktfifo_aresetn : OUT STD_LOGIC;
      m_axis_pktfifo_tvalid : OUT STD_LOGIC;
      m_axis_pktfifo_tready : IN STD_LOGIC;
      m_axis_pktfifo_tdata : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
      m_axis_pktfifo_tuser : OUT STD_LOGIC_VECTOR(103 DOWNTO 0);
      m_axis_pktfifo_tkeep : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
      m_axis_pktfifo_tlast : OUT STD_LOGIC;
      s_axis_pktfifo_tvalid : IN STD_LOGIC;
      s_axis_pktfifo_tready : OUT STD_LOGIC;
      s_axis_pktfifo_tdata : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
      s_axis_pktfifo_tuser : IN STD_LOGIC_VECTOR(103 DOWNTO 0);
      s_axis_pktfifo_tkeep : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
      s_axis_pktfifo_tlast : IN STD_LOGIC;
      m_axis_ppld_tvalid : OUT STD_LOGIC;
      m_axis_ppld_tready : IN STD_LOGIC;
      m_axis_ppld_tdata : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
      m_axis_ppld_tuser : OUT STD_LOGIC_VECTOR(103 DOWNTO 0);
      m_axis_ppld_tkeep : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
      m_axis_ppld_tlast : OUT STD_LOGIC
    );
  END COMPONENT px_axis_ppkt2ppld;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF tb_px_axis_ppkt2ppld_arch: ARCHITECTURE IS "px_axis_ppkt2ppld,Vivado 2018.2";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF tb_px_axis_ppkt2ppld_arch : ARCHITECTURE IS "tb_px_axis_ppkt2ppld,px_axis_ppkt2ppld,{}";
  ATTRIBUTE IP_DEFINITION_SOURCE : STRING;
  ATTRIBUTE IP_DEFINITION_SOURCE OF tb_px_axis_ppkt2ppld_arch: ARCHITECTURE IS "package_project";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_ppld_tlast: SIGNAL IS "xilinx.com:interface:axis:1.0 m_axis_ppld TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_ppld_tkeep: SIGNAL IS "xilinx.com:interface:axis:1.0 m_axis_ppld TKEEP";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_ppld_tuser: SIGNAL IS "xilinx.com:interface:axis:1.0 m_axis_ppld TUSER";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_ppld_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 m_axis_ppld TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_ppld_tready: SIGNAL IS "xilinx.com:interface:axis:1.0 m_axis_ppld TREADY";
  ATTRIBUTE X_INTERFACE_PARAMETER OF m_axis_ppld_tvalid: SIGNAL IS "XIL_INTERFACENAME m_axis_ppld, TDATA_NUM_BYTES 64, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 104, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_ppld_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 m_axis_ppld TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_pktfifo_tlast: SIGNAL IS "xilinx.com:interface:axis:1.0 s_axis_pktfifo TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_pktfifo_tkeep: SIGNAL IS "xilinx.com:interface:axis:1.0 s_axis_pktfifo TKEEP";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_pktfifo_tuser: SIGNAL IS "xilinx.com:interface:axis:1.0 s_axis_pktfifo TUSER";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_pktfifo_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 s_axis_pktfifo TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_pktfifo_tready: SIGNAL IS "xilinx.com:interface:axis:1.0 s_axis_pktfifo TREADY";
  ATTRIBUTE X_INTERFACE_PARAMETER OF s_axis_pktfifo_tvalid: SIGNAL IS "XIL_INTERFACENAME s_axis_pktfifo, TDATA_NUM_BYTES 64, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 104, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_pktfifo_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 s_axis_pktfifo TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_pktfifo_tlast: SIGNAL IS "xilinx.com:interface:axis:1.0 m_axis_pktfifo TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_pktfifo_tkeep: SIGNAL IS "xilinx.com:interface:axis:1.0 m_axis_pktfifo TKEEP";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_pktfifo_tuser: SIGNAL IS "xilinx.com:interface:axis:1.0 m_axis_pktfifo TUSER";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_pktfifo_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 m_axis_pktfifo TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_pktfifo_tready: SIGNAL IS "xilinx.com:interface:axis:1.0 m_axis_pktfifo TREADY";
  ATTRIBUTE X_INTERFACE_PARAMETER OF m_axis_pktfifo_tvalid: SIGNAL IS "XIL_INTERFACENAME m_axis_pktfifo, TDATA_NUM_BYTES 64, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 104, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_pktfifo_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 m_axis_pktfifo TVALID";
  ATTRIBUTE X_INTERFACE_PARAMETER OF m_axis_pktfifo_aresetn: SIGNAL IS "XIL_INTERFACENAME m_axis_pktfifo_aresetn, POLARITY ACTIVE_LOW";
  ATTRIBUTE X_INTERFACE_INFO OF m_axis_pktfifo_aresetn: SIGNAL IS "xilinx.com:signal:reset:1.0 m_axis_pktfifo_aresetn RST";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_ppkt_tlast: SIGNAL IS "xilinx.com:interface:axis:1.0 s_axis_ppkt TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_ppkt_tkeep: SIGNAL IS "xilinx.com:interface:axis:1.0 s_axis_ppkt TKEEP";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_ppkt_tuser: SIGNAL IS "xilinx.com:interface:axis:1.0 s_axis_ppkt TUSER";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_ppkt_tdata: SIGNAL IS "xilinx.com:interface:axis:1.0 s_axis_ppkt TDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_ppkt_tready: SIGNAL IS "xilinx.com:interface:axis:1.0 s_axis_ppkt TREADY";
  ATTRIBUTE X_INTERFACE_PARAMETER OF s_axis_ppkt_tvalid: SIGNAL IS "XIL_INTERFACENAME s_axis_ppkt, TDATA_NUM_BYTES 64, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 80, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef";
  ATTRIBUTE X_INTERFACE_INFO OF s_axis_ppkt_tvalid: SIGNAL IS "xilinx.com:interface:axis:1.0 s_axis_ppkt TVALID";
  ATTRIBUTE X_INTERFACE_PARAMETER OF fifo_rst_in_n: SIGNAL IS "XIL_INTERFACENAME fifo_rst_in_n, POLARITY ACTIVE_LOW";
  ATTRIBUTE X_INTERFACE_INFO OF fifo_rst_in_n: SIGNAL IS "xilinx.com:signal:reset:1.0 fifo_rst_in_n RST";
  ATTRIBUTE X_INTERFACE_PARAMETER OF axis_aresetn: SIGNAL IS "XIL_INTERFACENAME axis_aresetn, POLARITY ACTIVE_LOW";
  ATTRIBUTE X_INTERFACE_INFO OF axis_aresetn: SIGNAL IS "xilinx.com:signal:reset:1.0 axis_aresetn RST";
  ATTRIBUTE X_INTERFACE_PARAMETER OF axis_aclk: SIGNAL IS "XIL_INTERFACENAME axis_aclk, ASSOCIATED_RESET axis_aresetn:m_axis_pktfifo_aresetn:fifo_rst_in_n, ASSOCIATED_BUSIF s_axis_ppkt:m_axis_pktfifo:s_axis_pktfifo:m_axis_ppld, FREQ_HZ 100000000, PHASE 0.000";
  ATTRIBUTE X_INTERFACE_INFO OF axis_aclk: SIGNAL IS "xilinx.com:signal:clock:1.0 axis_aclk CLK";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_rready: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr RREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_rvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr RVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_rresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr RRESP";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_rdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr RDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_arready: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr ARREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_arvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr ARVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_arprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr ARPROT";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_araddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr ARADDR";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_bready: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr BREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_bvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr BVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_bresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr BRESP";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_wready: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr WREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_wvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr WVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_wstrb: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr WSTRB";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_wdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr WDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_awready: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr AWREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_awvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr AWVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_awprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr AWPROT";
  ATTRIBUTE X_INTERFACE_PARAMETER OF s_axi_csr_awaddr: SIGNAL IS "XIL_INTERFACENAME s_axi_csr, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 7, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.000, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WU" & 
"SER_BITS_PER_BYTE 0";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_awaddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 s_axi_csr AWADDR";
  ATTRIBUTE X_INTERFACE_PARAMETER OF s_axi_csr_aresetn: SIGNAL IS "XIL_INTERFACENAME s_axi_csr_aresetn, POLARITY ACTIVE_LOW";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_aresetn: SIGNAL IS "xilinx.com:signal:reset:1.0 s_axi_csr_aresetn RST";
  ATTRIBUTE X_INTERFACE_PARAMETER OF s_axi_csr_aclk: SIGNAL IS "XIL_INTERFACENAME s_axi_csr_aclk, ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn, FREQ_HZ 100000000, PHASE 0.000";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_csr_aclk: SIGNAL IS "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
BEGIN
  U0 : px_axis_ppkt2ppld
    GENERIC MAP (
      word_width => 32,
      default_packet_size => 256,
      has_override => true,
      has_fifo_rst_in_n => true
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
      override_pkt_size_en => override_pkt_size_en,
      override_pkt_size => override_pkt_size,
      axis_aclk => axis_aclk,
      axis_aresetn => axis_aresetn,
      fifo_rst_in_n => fifo_rst_in_n,
      s_axis_ppkt_tvalid => s_axis_ppkt_tvalid,
      s_axis_ppkt_tready => s_axis_ppkt_tready,
      s_axis_ppkt_tdata => s_axis_ppkt_tdata,
      s_axis_ppkt_tuser => s_axis_ppkt_tuser,
      s_axis_ppkt_tkeep => s_axis_ppkt_tkeep,
      s_axis_ppkt_tlast => s_axis_ppkt_tlast,
      m_axis_pktfifo_aresetn => m_axis_pktfifo_aresetn,
      m_axis_pktfifo_tvalid => m_axis_pktfifo_tvalid,
      m_axis_pktfifo_tready => m_axis_pktfifo_tready,
      m_axis_pktfifo_tdata => m_axis_pktfifo_tdata,
      m_axis_pktfifo_tuser => m_axis_pktfifo_tuser,
      m_axis_pktfifo_tkeep => m_axis_pktfifo_tkeep,
      m_axis_pktfifo_tlast => m_axis_pktfifo_tlast,
      s_axis_pktfifo_tvalid => s_axis_pktfifo_tvalid,
      s_axis_pktfifo_tready => s_axis_pktfifo_tready,
      s_axis_pktfifo_tdata => s_axis_pktfifo_tdata,
      s_axis_pktfifo_tuser => s_axis_pktfifo_tuser,
      s_axis_pktfifo_tkeep => s_axis_pktfifo_tkeep,
      s_axis_pktfifo_tlast => s_axis_pktfifo_tlast,
      m_axis_ppld_tvalid => m_axis_ppld_tvalid,
      m_axis_ppld_tready => m_axis_ppld_tready,
      m_axis_ppld_tdata => m_axis_ppld_tdata,
      m_axis_ppld_tuser => m_axis_ppld_tuser,
      m_axis_ppld_tkeep => m_axis_ppld_tkeep,
      m_axis_ppld_tlast => m_axis_ppld_tlast
    );
END tb_px_axis_ppkt2ppld_arch;
