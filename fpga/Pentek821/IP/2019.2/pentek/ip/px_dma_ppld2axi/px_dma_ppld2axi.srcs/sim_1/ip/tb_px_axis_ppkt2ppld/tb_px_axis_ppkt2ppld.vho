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

-- The following code must appear in the VHDL architecture header.

------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
COMPONENT tb_px_axis_ppkt2ppld
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
END COMPONENT;
-- COMP_TAG_END ------ End COMPONENT Declaration ------------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
your_instance_name : tb_px_axis_ppkt2ppld
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
-- INST_TAG_END ------ End INSTANTIATION Template ---------

