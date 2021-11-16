--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
--Date        : Thu May  4 14:10:06 2017
--Host        : Rich-PC running 64-bit major release  (build 9200)
--Command     : generate_target ddr4_intrfc.bd
--Design      : ddr4_intrfc
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ddr4_intrfc is
  port (
    ddr4_sys_rst : out STD_LOGIC;
    ddr4_ui_app_addr : out STD_LOGIC_VECTOR ( 28 downto 0 );
    ddr4_ui_app_cmd : out STD_LOGIC_VECTOR ( 2 downto 0 );
    ddr4_ui_app_en : out STD_LOGIC;
    ddr4_ui_app_hi_pri : out STD_LOGIC;
    ddr4_ui_app_rd_data : in STD_LOGIC_VECTOR ( 639 downto 0 );
    ddr4_ui_app_rd_data_end : in STD_LOGIC;
    ddr4_ui_app_rd_data_valid : in STD_LOGIC;
    ddr4_ui_app_rdy : in STD_LOGIC;
    ddr4_ui_app_wdf_data : out STD_LOGIC_VECTOR ( 639 downto 0 );
    ddr4_ui_app_wdf_end : out STD_LOGIC;
    ddr4_ui_app_wdf_mask : out STD_LOGIC_VECTOR ( 79 downto 0 );
    ddr4_ui_app_wdf_rdy : in STD_LOGIC;
    ddr4_ui_app_wdf_wren : out STD_LOGIC;
    ddr4_ui_clk : in STD_LOGIC;
    init_calib_complete : in STD_LOGIC;
    m_axis_dac_ddr_rsp_tdata : out STD_LOGIC_VECTOR ( 511 downto 0 );
    m_axis_dac_ddr_rsp_tid : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_dac_ddr_rsp_tlast : out STD_LOGIC;
    m_axis_dac_ddr_rsp_tuser : out STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_dac_ddr_rsp_tvalid : out STD_LOGIC;
    m_axis_pcie_ddr_rsp_tdata : out STD_LOGIC_VECTOR ( 511 downto 0 );
    m_axis_pcie_ddr_rsp_tid : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_pcie_ddr_rsp_tlast : out STD_LOGIC;
    m_axis_pcie_ddr_rsp_tready : in STD_LOGIC;
    m_axis_pcie_ddr_rsp_tuser : out STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_pcie_ddr_rsp_tvalid : out STD_LOGIC;
    s_axi_csr_aclk : in STD_LOGIC;
    s_axi_csr_araddr : in STD_LOGIC_VECTOR ( 6 downto 0 );
    s_axi_csr_aresetn : in STD_LOGIC;
    s_axi_csr_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_csr_arready : out STD_LOGIC;
    s_axi_csr_arvalid : in STD_LOGIC;
    s_axi_csr_awaddr : in STD_LOGIC_VECTOR ( 6 downto 0 );
    s_axi_csr_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_csr_awready : out STD_LOGIC;
    s_axi_csr_awvalid : in STD_LOGIC;
    s_axi_csr_bready : in STD_LOGIC;
    s_axi_csr_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_csr_bvalid : out STD_LOGIC;
    s_axi_csr_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_csr_rready : in STD_LOGIC;
    s_axi_csr_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_csr_rvalid : out STD_LOGIC;
    s_axi_csr_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_csr_wready : out STD_LOGIC;
    s_axi_csr_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_csr_wvalid : in STD_LOGIC;
    s_axis_aresetn : in STD_LOGIC;
    s_axis_dac_ddr_rqst_tdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
    s_axis_dac_ddr_rqst_tid : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_dac_ddr_rqst_tlast : in STD_LOGIC;
    s_axis_dac_ddr_rqst_tready : out STD_LOGIC;
    s_axis_dac_ddr_rqst_tuser : in STD_LOGIC_VECTOR ( 255 downto 0 );
    s_axis_dac_ddr_rqst_tvalid : in STD_LOGIC;
    s_axis_pcie_ddr_rqst_tdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
    s_axis_pcie_ddr_rqst_tid : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_pcie_ddr_rqst_tlast : in STD_LOGIC;
    s_axis_pcie_ddr_rqst_tready : out STD_LOGIC;
    s_axis_pcie_ddr_rqst_tuser : in STD_LOGIC_VECTOR ( 255 downto 0 );
    s_axis_pcie_ddr_rqst_tvalid : in STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of ddr4_intrfc : entity is "ddr4_intrfc,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=ddr4_intrfc,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=9,numReposBlks=9,numNonXlnxBlks=3,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_BD}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of ddr4_intrfc : entity is "ddr4_intrfc.hwdef";
end ddr4_intrfc;

architecture STRUCTURE of ddr4_intrfc is
  component ddr4_intrfc_axis_broadcaster_0_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_tvalid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_tdata : out STD_LOGIC_VECTOR ( 1023 downto 0 );
    m_axis_tlast : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_tid : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 511 downto 0 )
  );
  end component ddr4_intrfc_axis_broadcaster_0_0;
  component ddr4_intrfc_axis_clk_conv0_0 is
  port (
    s_axis_aresetn : in STD_LOGIC;
    m_axis_aresetn : in STD_LOGIC;
    s_axis_aclk : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_aclk : in STD_LOGIC;
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 511 downto 0 );
    m_axis_tlast : out STD_LOGIC;
    m_axis_tid : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 255 downto 0 )
  );
  end component ddr4_intrfc_axis_clk_conv0_0;
  component ddr4_intrfc_axis_clock_converter_0_0 is
  port (
    s_axis_aresetn : in STD_LOGIC;
    m_axis_aresetn : in STD_LOGIC;
    s_axis_aclk : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_aclk : in STD_LOGIC;
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 511 downto 0 );
    m_axis_tlast : out STD_LOGIC;
    m_axis_tid : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 255 downto 0 )
  );
  end component ddr4_intrfc_axis_clock_converter_0_0;
  component ddr4_intrfc_axis_switch_0_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_tready : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_tdata : in STD_LOGIC_VECTOR ( 1023 downto 0 );
    s_axis_tlast : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_tid : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 511 downto 0 );
    m_axis_tvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tdata : out STD_LOGIC_VECTOR ( 511 downto 0 );
    m_axis_tlast : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tid : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 255 downto 0 );
    s_req_suppress : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_decode_err : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  end component ddr4_intrfc_axis_switch_0_0;
  component ddr4_intrfc_filter_id_0_0 is
  port (
    axis_aclk : in STD_LOGIC;
    axis_aresetn : in STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 255 downto 0 );
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tlast : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tdata : out STD_LOGIC_VECTOR ( 511 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tlast : out STD_LOGIC;
    m_axis_tid : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  end component ddr4_intrfc_filter_id_0_0;
  component ddr4_intrfc_px_axis_filter_by_id_0_0 is
  port (
    axis_aclk : in STD_LOGIC;
    axis_aresetn : in STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 255 downto 0 );
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tlast : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tdata : out STD_LOGIC_VECTOR ( 511 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tlast : out STD_LOGIC;
    m_axis_tid : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  end component ddr4_intrfc_px_axis_filter_by_id_0_0;
  component ddr4_intrfc_px_axisrq2ddrctlr_0_0 is
  port (
    s_axi_csr_aclk : in STD_LOGIC;
    s_axi_csr_aresetn : in STD_LOGIC;
    s_axi_csr_awaddr : in STD_LOGIC_VECTOR ( 6 downto 0 );
    s_axi_csr_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_csr_awvalid : in STD_LOGIC;
    s_axi_csr_awready : out STD_LOGIC;
    s_axi_csr_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_csr_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_csr_wvalid : in STD_LOGIC;
    s_axi_csr_wready : out STD_LOGIC;
    s_axi_csr_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_csr_bvalid : out STD_LOGIC;
    s_axi_csr_bready : in STD_LOGIC;
    s_axi_csr_araddr : in STD_LOGIC_VECTOR ( 6 downto 0 );
    s_axi_csr_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_csr_arvalid : in STD_LOGIC;
    s_axi_csr_arready : out STD_LOGIC;
    s_axi_csr_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_csr_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_csr_rvalid : out STD_LOGIC;
    s_axi_csr_rready : in STD_LOGIC;
    ddr4_app_axis_aclk : in STD_LOGIC;
    s_axis_rqst_tvalid : in STD_LOGIC;
    s_axis_rqst_tready : out STD_LOGIC;
    s_axis_rqst_tlast : in STD_LOGIC;
    s_axis_rqst_tid : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_rqst_tdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
    s_axis_rqst_tuser : in STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_rsp_tvalid : out STD_LOGIC;
    m_axis_rsp_tlast : out STD_LOGIC;
    m_axis_rsp_tid : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_rsp_tdata : out STD_LOGIC_VECTOR ( 511 downto 0 );
    m_axis_rsp_tuser : out STD_LOGIC_VECTOR ( 255 downto 0 );
    ddr4_app_en : out STD_LOGIC;
    ddr4_app_hi_pri : out STD_LOGIC;
    ddr4_app_wdf_end : out STD_LOGIC;
    ddr4_app_wdf_wren : out STD_LOGIC;
    ddr4_app_rd_data_end : in STD_LOGIC;
    ddr4_app_rd_data_valid : in STD_LOGIC;
    ddr4_app_rdy : in STD_LOGIC;
    ddr4_app_wdf_rdy : in STD_LOGIC;
    ddr4_app_addr : out STD_LOGIC_VECTOR ( 28 downto 0 );
    ddr4_app_cmd : out STD_LOGIC_VECTOR ( 2 downto 0 );
    ddr4_app_wdf_data : out STD_LOGIC_VECTOR ( 639 downto 0 );
    ddr4_app_wdf_mask : out STD_LOGIC_VECTOR ( 79 downto 0 );
    ddr4_app_rd_data : in STD_LOGIC_VECTOR ( 639 downto 0 );
    init_calib_complete : in STD_LOGIC;
    ddr4_sys_rst : out STD_LOGIC
  );
  end component ddr4_intrfc_px_axisrq2ddrctlr_0_0;
  component ddr4_intrfc_rq_regslice_2_1 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 511 downto 0 );
    m_axis_tlast : out STD_LOGIC;
    m_axis_tid : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 255 downto 0 )
  );
  end component ddr4_intrfc_rq_regslice_2_1;
  component ddr4_intrfc_xlconstant_0_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  end component ddr4_intrfc_xlconstant_0_0;
  signal axis_clk_conv0_M_AXIS_TDATA : STD_LOGIC_VECTOR ( 511 downto 0 );
  signal axis_clk_conv0_M_AXIS_TID : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axis_clk_conv0_M_AXIS_TLAST : STD_LOGIC;
  signal axis_clk_conv0_M_AXIS_TREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axis_clk_conv0_M_AXIS_TUSER : STD_LOGIC_VECTOR ( 255 downto 0 );
  signal axis_clk_conv0_M_AXIS_TVALID : STD_LOGIC;
  signal axis_clk_conv1_M_AXIS_TDATA : STD_LOGIC_VECTOR ( 511 downto 0 );
  signal axis_clk_conv1_M_AXIS_TID : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axis_clk_conv1_M_AXIS_TLAST : STD_LOGIC;
  signal axis_clk_conv1_M_AXIS_TREADY : STD_LOGIC;
  signal axis_clk_conv1_M_AXIS_TUSER : STD_LOGIC_VECTOR ( 255 downto 0 );
  signal axis_clk_conv1_M_AXIS_TVALID : STD_LOGIC;
  signal axis_switch_0_M00_AXIS_TDATA : STD_LOGIC_VECTOR ( 511 downto 0 );
  signal axis_switch_0_M00_AXIS_TID : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axis_switch_0_M00_AXIS_TLAST : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axis_switch_0_M00_AXIS_TREADY : STD_LOGIC;
  signal axis_switch_0_M00_AXIS_TUSER : STD_LOGIC_VECTOR ( 255 downto 0 );
  signal axis_switch_0_M00_AXIS_TVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axisrq2ddrctlr_ddr4_app_addr : STD_LOGIC_VECTOR ( 28 downto 0 );
  signal axisrq2ddrctlr_ddr4_app_cmd : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axisrq2ddrctlr_ddr4_app_en : STD_LOGIC;
  signal axisrq2ddrctlr_ddr4_app_hi_pri : STD_LOGIC;
  signal axisrq2ddrctlr_ddr4_app_rd_data : STD_LOGIC_VECTOR ( 639 downto 0 );
  signal axisrq2ddrctlr_ddr4_app_rd_data_end : STD_LOGIC;
  signal axisrq2ddrctlr_ddr4_app_rd_data_valid : STD_LOGIC;
  signal axisrq2ddrctlr_ddr4_app_rdy : STD_LOGIC;
  signal axisrq2ddrctlr_ddr4_app_wdf_data : STD_LOGIC_VECTOR ( 639 downto 0 );
  signal axisrq2ddrctlr_ddr4_app_wdf_end : STD_LOGIC;
  signal axisrq2ddrctlr_ddr4_app_wdf_mask : STD_LOGIC_VECTOR ( 79 downto 0 );
  signal axisrq2ddrctlr_ddr4_app_wdf_rdy : STD_LOGIC;
  signal axisrq2ddrctlr_ddr4_app_wdf_wren : STD_LOGIC;
  signal axisrq2ddrctlr_ddr4_sys_rst : STD_LOGIC;
  signal axisrq2ddrctlr_m_axis_rsp_TDATA : STD_LOGIC_VECTOR ( 511 downto 0 );
  signal axisrq2ddrctlr_m_axis_rsp_TID : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axisrq2ddrctlr_m_axis_rsp_TLAST : STD_LOGIC;
  signal axisrq2ddrctlr_m_axis_rsp_TUSER : STD_LOGIC_VECTOR ( 255 downto 0 );
  signal axisrq2ddrctlr_m_axis_rsp_TVALID : STD_LOGIC;
  signal const_zero_dout : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ddr4_ui_clk_1 : STD_LOGIC;
  signal filter_id_0_m_axis_TDATA : STD_LOGIC_VECTOR ( 511 downto 0 );
  signal filter_id_0_m_axis_TID : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal filter_id_0_m_axis_TLAST : STD_LOGIC;
  signal filter_id_0_m_axis_TUSER : STD_LOGIC_VECTOR ( 255 downto 0 );
  signal filter_id_0_m_axis_TVALID : STD_LOGIC;
  signal filter_id_1_m_axis_TDATA : STD_LOGIC_VECTOR ( 511 downto 0 );
  signal filter_id_1_m_axis_TID : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal filter_id_1_m_axis_TLAST : STD_LOGIC;
  signal filter_id_1_m_axis_TUSER : STD_LOGIC_VECTOR ( 255 downto 0 );
  signal filter_id_1_m_axis_TVALID : STD_LOGIC;
  signal init_calib_complete_1 : STD_LOGIC;
  signal rq_regslice_1_M_AXIS_TDATA : STD_LOGIC_VECTOR ( 511 downto 0 );
  signal rq_regslice_1_M_AXIS_TID : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal rq_regslice_1_M_AXIS_TLAST : STD_LOGIC;
  signal rq_regslice_1_M_AXIS_TREADY : STD_LOGIC_VECTOR ( 1 to 1 );
  signal rq_regslice_1_M_AXIS_TUSER : STD_LOGIC_VECTOR ( 255 downto 0 );
  signal rq_regslice_1_M_AXIS_TVALID : STD_LOGIC;
  signal rsp_broadcast_M00_AXIS_TDATA : STD_LOGIC_VECTOR ( 511 downto 0 );
  signal rsp_broadcast_M00_AXIS_TID : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal rsp_broadcast_M00_AXIS_TLAST : STD_LOGIC_VECTOR ( 0 to 0 );
  signal rsp_broadcast_M00_AXIS_TUSER : STD_LOGIC_VECTOR ( 255 downto 0 );
  signal rsp_broadcast_M00_AXIS_TVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal rsp_broadcast_M01_AXIS_TDATA : STD_LOGIC_VECTOR ( 1023 downto 512 );
  signal rsp_broadcast_M01_AXIS_TID : STD_LOGIC_VECTOR ( 15 downto 8 );
  signal rsp_broadcast_M01_AXIS_TLAST : STD_LOGIC_VECTOR ( 1 to 1 );
  signal rsp_broadcast_M01_AXIS_TUSER : STD_LOGIC_VECTOR ( 511 downto 256 );
  signal rsp_broadcast_M01_AXIS_TVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal s_axi_csr_1_ARADDR : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal s_axi_csr_1_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s_axi_csr_1_ARREADY : STD_LOGIC;
  signal s_axi_csr_1_ARVALID : STD_LOGIC;
  signal s_axi_csr_1_AWADDR : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal s_axi_csr_1_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s_axi_csr_1_AWREADY : STD_LOGIC;
  signal s_axi_csr_1_AWVALID : STD_LOGIC;
  signal s_axi_csr_1_BREADY : STD_LOGIC;
  signal s_axi_csr_1_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s_axi_csr_1_BVALID : STD_LOGIC;
  signal s_axi_csr_1_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s_axi_csr_1_RREADY : STD_LOGIC;
  signal s_axi_csr_1_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s_axi_csr_1_RVALID : STD_LOGIC;
  signal s_axi_csr_1_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s_axi_csr_1_WREADY : STD_LOGIC;
  signal s_axi_csr_1_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s_axi_csr_1_WVALID : STD_LOGIC;
  signal s_axis_aclk_1 : STD_LOGIC;
  signal s_axis_aresetn_1 : STD_LOGIC;
  signal s_axis_aresetn_2 : STD_LOGIC;
  signal s_axis_dac_ddr_rqst_1_TDATA : STD_LOGIC_VECTOR ( 511 downto 0 );
  signal s_axis_dac_ddr_rqst_1_TID : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal s_axis_dac_ddr_rqst_1_TLAST : STD_LOGIC;
  signal s_axis_dac_ddr_rqst_1_TREADY : STD_LOGIC;
  signal s_axis_dac_ddr_rqst_1_TUSER : STD_LOGIC_VECTOR ( 255 downto 0 );
  signal s_axis_dac_ddr_rqst_1_TVALID : STD_LOGIC;
  signal s_axis_pcie_ddr_rqst_1_TDATA : STD_LOGIC_VECTOR ( 511 downto 0 );
  signal s_axis_pcie_ddr_rqst_1_TID : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal s_axis_pcie_ddr_rqst_1_TLAST : STD_LOGIC;
  signal s_axis_pcie_ddr_rqst_1_TREADY : STD_LOGIC;
  signal s_axis_pcie_ddr_rqst_1_TUSER : STD_LOGIC_VECTOR ( 255 downto 0 );
  signal s_axis_pcie_ddr_rqst_1_TVALID : STD_LOGIC;
  signal NLW_axis_arb_s_decode_err_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_axis_clk_conv1_s_axis_tready_UNCONNECTED : STD_LOGIC;
begin
  axis_clk_conv1_M_AXIS_TREADY <= m_axis_pcie_ddr_rsp_tready;
  axisrq2ddrctlr_ddr4_app_rd_data(639 downto 0) <= ddr4_ui_app_rd_data(639 downto 0);
  axisrq2ddrctlr_ddr4_app_rd_data_end <= ddr4_ui_app_rd_data_end;
  axisrq2ddrctlr_ddr4_app_rd_data_valid <= ddr4_ui_app_rd_data_valid;
  axisrq2ddrctlr_ddr4_app_rdy <= ddr4_ui_app_rdy;
  axisrq2ddrctlr_ddr4_app_wdf_rdy <= ddr4_ui_app_wdf_rdy;
  ddr4_sys_rst <= axisrq2ddrctlr_ddr4_sys_rst;
  ddr4_ui_app_addr(28 downto 0) <= axisrq2ddrctlr_ddr4_app_addr(28 downto 0);
  ddr4_ui_app_cmd(2 downto 0) <= axisrq2ddrctlr_ddr4_app_cmd(2 downto 0);
  ddr4_ui_app_en <= axisrq2ddrctlr_ddr4_app_en;
  ddr4_ui_app_hi_pri <= axisrq2ddrctlr_ddr4_app_hi_pri;
  ddr4_ui_app_wdf_data(639 downto 0) <= axisrq2ddrctlr_ddr4_app_wdf_data(639 downto 0);
  ddr4_ui_app_wdf_end <= axisrq2ddrctlr_ddr4_app_wdf_end;
  ddr4_ui_app_wdf_mask(79 downto 0) <= axisrq2ddrctlr_ddr4_app_wdf_mask(79 downto 0);
  ddr4_ui_app_wdf_wren <= axisrq2ddrctlr_ddr4_app_wdf_wren;
  ddr4_ui_clk_1 <= ddr4_ui_clk;
  init_calib_complete_1 <= init_calib_complete;
  m_axis_dac_ddr_rsp_tdata(511 downto 0) <= filter_id_1_m_axis_TDATA(511 downto 0);
  m_axis_dac_ddr_rsp_tid(7 downto 0) <= filter_id_1_m_axis_TID(7 downto 0);
  m_axis_dac_ddr_rsp_tlast <= filter_id_1_m_axis_TLAST;
  m_axis_dac_ddr_rsp_tuser(255 downto 0) <= filter_id_1_m_axis_TUSER(255 downto 0);
  m_axis_dac_ddr_rsp_tvalid <= filter_id_1_m_axis_TVALID;
  m_axis_pcie_ddr_rsp_tdata(511 downto 0) <= axis_clk_conv1_M_AXIS_TDATA(511 downto 0);
  m_axis_pcie_ddr_rsp_tid(7 downto 0) <= axis_clk_conv1_M_AXIS_TID(7 downto 0);
  m_axis_pcie_ddr_rsp_tlast <= axis_clk_conv1_M_AXIS_TLAST;
  m_axis_pcie_ddr_rsp_tuser(255 downto 0) <= axis_clk_conv1_M_AXIS_TUSER(255 downto 0);
  m_axis_pcie_ddr_rsp_tvalid <= axis_clk_conv1_M_AXIS_TVALID;
  s_axi_csr_1_ARADDR(6 downto 0) <= s_axi_csr_araddr(6 downto 0);
  s_axi_csr_1_ARPROT(2 downto 0) <= s_axi_csr_arprot(2 downto 0);
  s_axi_csr_1_ARVALID <= s_axi_csr_arvalid;
  s_axi_csr_1_AWADDR(6 downto 0) <= s_axi_csr_awaddr(6 downto 0);
  s_axi_csr_1_AWPROT(2 downto 0) <= s_axi_csr_awprot(2 downto 0);
  s_axi_csr_1_AWVALID <= s_axi_csr_awvalid;
  s_axi_csr_1_BREADY <= s_axi_csr_bready;
  s_axi_csr_1_RREADY <= s_axi_csr_rready;
  s_axi_csr_1_WDATA(31 downto 0) <= s_axi_csr_wdata(31 downto 0);
  s_axi_csr_1_WSTRB(3 downto 0) <= s_axi_csr_wstrb(3 downto 0);
  s_axi_csr_1_WVALID <= s_axi_csr_wvalid;
  s_axi_csr_arready <= s_axi_csr_1_ARREADY;
  s_axi_csr_awready <= s_axi_csr_1_AWREADY;
  s_axi_csr_bresp(1 downto 0) <= s_axi_csr_1_BRESP(1 downto 0);
  s_axi_csr_bvalid <= s_axi_csr_1_BVALID;
  s_axi_csr_rdata(31 downto 0) <= s_axi_csr_1_RDATA(31 downto 0);
  s_axi_csr_rresp(1 downto 0) <= s_axi_csr_1_RRESP(1 downto 0);
  s_axi_csr_rvalid <= s_axi_csr_1_RVALID;
  s_axi_csr_wready <= s_axi_csr_1_WREADY;
  s_axis_aclk_1 <= s_axi_csr_aclk;
  s_axis_aresetn_1 <= s_axi_csr_aresetn;
  s_axis_aresetn_2 <= s_axis_aresetn;
  s_axis_dac_ddr_rqst_1_TDATA(511 downto 0) <= s_axis_dac_ddr_rqst_tdata(511 downto 0);
  s_axis_dac_ddr_rqst_1_TID(7 downto 0) <= s_axis_dac_ddr_rqst_tid(7 downto 0);
  s_axis_dac_ddr_rqst_1_TLAST <= s_axis_dac_ddr_rqst_tlast;
  s_axis_dac_ddr_rqst_1_TUSER(255 downto 0) <= s_axis_dac_ddr_rqst_tuser(255 downto 0);
  s_axis_dac_ddr_rqst_1_TVALID <= s_axis_dac_ddr_rqst_tvalid;
  s_axis_dac_ddr_rqst_tready <= s_axis_dac_ddr_rqst_1_TREADY;
  s_axis_pcie_ddr_rqst_1_TDATA(511 downto 0) <= s_axis_pcie_ddr_rqst_tdata(511 downto 0);
  s_axis_pcie_ddr_rqst_1_TID(7 downto 0) <= s_axis_pcie_ddr_rqst_tid(7 downto 0);
  s_axis_pcie_ddr_rqst_1_TLAST <= s_axis_pcie_ddr_rqst_tlast;
  s_axis_pcie_ddr_rqst_1_TUSER(255 downto 0) <= s_axis_pcie_ddr_rqst_tuser(255 downto 0);
  s_axis_pcie_ddr_rqst_1_TVALID <= s_axis_pcie_ddr_rqst_tvalid;
  s_axis_pcie_ddr_rqst_tready <= s_axis_pcie_ddr_rqst_1_TREADY;
axis_arb: component ddr4_intrfc_axis_switch_0_0
     port map (
      aclk => ddr4_ui_clk_1,
      aresetn => s_axis_aresetn_2,
      m_axis_tdata(511 downto 0) => axis_switch_0_M00_AXIS_TDATA(511 downto 0),
      m_axis_tid(7 downto 0) => axis_switch_0_M00_AXIS_TID(7 downto 0),
      m_axis_tlast(0) => axis_switch_0_M00_AXIS_TLAST(0),
      m_axis_tready(0) => axis_switch_0_M00_AXIS_TREADY,
      m_axis_tuser(255 downto 0) => axis_switch_0_M00_AXIS_TUSER(255 downto 0),
      m_axis_tvalid(0) => axis_switch_0_M00_AXIS_TVALID(0),
      s_axis_tdata(1023 downto 512) => rq_regslice_1_M_AXIS_TDATA(511 downto 0),
      s_axis_tdata(511 downto 0) => axis_clk_conv0_M_AXIS_TDATA(511 downto 0),
      s_axis_tid(15 downto 8) => rq_regslice_1_M_AXIS_TID(7 downto 0),
      s_axis_tid(7 downto 0) => axis_clk_conv0_M_AXIS_TID(7 downto 0),
      s_axis_tlast(1) => rq_regslice_1_M_AXIS_TLAST,
      s_axis_tlast(0) => axis_clk_conv0_M_AXIS_TLAST,
      s_axis_tready(1) => rq_regslice_1_M_AXIS_TREADY(1),
      s_axis_tready(0) => axis_clk_conv0_M_AXIS_TREADY(0),
      s_axis_tuser(511 downto 256) => rq_regslice_1_M_AXIS_TUSER(255 downto 0),
      s_axis_tuser(255 downto 0) => axis_clk_conv0_M_AXIS_TUSER(255 downto 0),
      s_axis_tvalid(1) => rq_regslice_1_M_AXIS_TVALID,
      s_axis_tvalid(0) => axis_clk_conv0_M_AXIS_TVALID,
      s_decode_err(1 downto 0) => NLW_axis_arb_s_decode_err_UNCONNECTED(1 downto 0),
      s_req_suppress(1 downto 0) => const_zero_dout(1 downto 0)
    );
axis_clk_conv0: component ddr4_intrfc_axis_clock_converter_0_0
     port map (
      m_axis_aclk => ddr4_ui_clk_1,
      m_axis_aresetn => s_axis_aresetn_2,
      m_axis_tdata(511 downto 0) => axis_clk_conv0_M_AXIS_TDATA(511 downto 0),
      m_axis_tid(7 downto 0) => axis_clk_conv0_M_AXIS_TID(7 downto 0),
      m_axis_tlast => axis_clk_conv0_M_AXIS_TLAST,
      m_axis_tready => axis_clk_conv0_M_AXIS_TREADY(0),
      m_axis_tuser(255 downto 0) => axis_clk_conv0_M_AXIS_TUSER(255 downto 0),
      m_axis_tvalid => axis_clk_conv0_M_AXIS_TVALID,
      s_axis_aclk => s_axis_aclk_1,
      s_axis_aresetn => s_axis_aresetn_1,
      s_axis_tdata(511 downto 0) => s_axis_pcie_ddr_rqst_1_TDATA(511 downto 0),
      s_axis_tid(7 downto 0) => s_axis_pcie_ddr_rqst_1_TID(7 downto 0),
      s_axis_tlast => s_axis_pcie_ddr_rqst_1_TLAST,
      s_axis_tready => s_axis_pcie_ddr_rqst_1_TREADY,
      s_axis_tuser(255 downto 0) => s_axis_pcie_ddr_rqst_1_TUSER(255 downto 0),
      s_axis_tvalid => s_axis_pcie_ddr_rqst_1_TVALID
    );
axis_clk_conv1: component ddr4_intrfc_axis_clk_conv0_0
     port map (
      m_axis_aclk => s_axis_aclk_1,
      m_axis_aresetn => s_axis_aresetn_1,
      m_axis_tdata(511 downto 0) => axis_clk_conv1_M_AXIS_TDATA(511 downto 0),
      m_axis_tid(7 downto 0) => axis_clk_conv1_M_AXIS_TID(7 downto 0),
      m_axis_tlast => axis_clk_conv1_M_AXIS_TLAST,
      m_axis_tready => axis_clk_conv1_M_AXIS_TREADY,
      m_axis_tuser(255 downto 0) => axis_clk_conv1_M_AXIS_TUSER(255 downto 0),
      m_axis_tvalid => axis_clk_conv1_M_AXIS_TVALID,
      s_axis_aclk => ddr4_ui_clk_1,
      s_axis_aresetn => s_axis_aresetn_2,
      s_axis_tdata(511 downto 0) => filter_id_0_m_axis_TDATA(511 downto 0),
      s_axis_tid(7 downto 0) => filter_id_0_m_axis_TID(7 downto 0),
      s_axis_tlast => filter_id_0_m_axis_TLAST,
      s_axis_tready => NLW_axis_clk_conv1_s_axis_tready_UNCONNECTED,
      s_axis_tuser(255 downto 0) => filter_id_0_m_axis_TUSER(255 downto 0),
      s_axis_tvalid => filter_id_0_m_axis_TVALID
    );
axisrq2ddrctlr: component ddr4_intrfc_px_axisrq2ddrctlr_0_0
     port map (
      ddr4_app_addr(28 downto 0) => axisrq2ddrctlr_ddr4_app_addr(28 downto 0),
      ddr4_app_axis_aclk => ddr4_ui_clk_1,
      ddr4_app_cmd(2 downto 0) => axisrq2ddrctlr_ddr4_app_cmd(2 downto 0),
      ddr4_app_en => axisrq2ddrctlr_ddr4_app_en,
      ddr4_app_hi_pri => axisrq2ddrctlr_ddr4_app_hi_pri,
      ddr4_app_rd_data(639 downto 0) => axisrq2ddrctlr_ddr4_app_rd_data(639 downto 0),
      ddr4_app_rd_data_end => axisrq2ddrctlr_ddr4_app_rd_data_end,
      ddr4_app_rd_data_valid => axisrq2ddrctlr_ddr4_app_rd_data_valid,
      ddr4_app_rdy => axisrq2ddrctlr_ddr4_app_rdy,
      ddr4_app_wdf_data(639 downto 0) => axisrq2ddrctlr_ddr4_app_wdf_data(639 downto 0),
      ddr4_app_wdf_end => axisrq2ddrctlr_ddr4_app_wdf_end,
      ddr4_app_wdf_mask(79 downto 0) => axisrq2ddrctlr_ddr4_app_wdf_mask(79 downto 0),
      ddr4_app_wdf_rdy => axisrq2ddrctlr_ddr4_app_wdf_rdy,
      ddr4_app_wdf_wren => axisrq2ddrctlr_ddr4_app_wdf_wren,
      ddr4_sys_rst => axisrq2ddrctlr_ddr4_sys_rst,
      init_calib_complete => init_calib_complete_1,
      m_axis_rsp_tdata(511 downto 0) => axisrq2ddrctlr_m_axis_rsp_TDATA(511 downto 0),
      m_axis_rsp_tid(7 downto 0) => axisrq2ddrctlr_m_axis_rsp_TID(7 downto 0),
      m_axis_rsp_tlast => axisrq2ddrctlr_m_axis_rsp_TLAST,
      m_axis_rsp_tuser(255 downto 0) => axisrq2ddrctlr_m_axis_rsp_TUSER(255 downto 0),
      m_axis_rsp_tvalid => axisrq2ddrctlr_m_axis_rsp_TVALID,
      s_axi_csr_aclk => s_axis_aclk_1,
      s_axi_csr_araddr(6 downto 0) => s_axi_csr_1_ARADDR(6 downto 0),
      s_axi_csr_aresetn => s_axis_aresetn_1,
      s_axi_csr_arprot(2 downto 0) => s_axi_csr_1_ARPROT(2 downto 0),
      s_axi_csr_arready => s_axi_csr_1_ARREADY,
      s_axi_csr_arvalid => s_axi_csr_1_ARVALID,
      s_axi_csr_awaddr(6 downto 0) => s_axi_csr_1_AWADDR(6 downto 0),
      s_axi_csr_awprot(2 downto 0) => s_axi_csr_1_AWPROT(2 downto 0),
      s_axi_csr_awready => s_axi_csr_1_AWREADY,
      s_axi_csr_awvalid => s_axi_csr_1_AWVALID,
      s_axi_csr_bready => s_axi_csr_1_BREADY,
      s_axi_csr_bresp(1 downto 0) => s_axi_csr_1_BRESP(1 downto 0),
      s_axi_csr_bvalid => s_axi_csr_1_BVALID,
      s_axi_csr_rdata(31 downto 0) => s_axi_csr_1_RDATA(31 downto 0),
      s_axi_csr_rready => s_axi_csr_1_RREADY,
      s_axi_csr_rresp(1 downto 0) => s_axi_csr_1_RRESP(1 downto 0),
      s_axi_csr_rvalid => s_axi_csr_1_RVALID,
      s_axi_csr_wdata(31 downto 0) => s_axi_csr_1_WDATA(31 downto 0),
      s_axi_csr_wready => s_axi_csr_1_WREADY,
      s_axi_csr_wstrb(3 downto 0) => s_axi_csr_1_WSTRB(3 downto 0),
      s_axi_csr_wvalid => s_axi_csr_1_WVALID,
      s_axis_rqst_tdata(511 downto 0) => axis_switch_0_M00_AXIS_TDATA(511 downto 0),
      s_axis_rqst_tid(7 downto 0) => axis_switch_0_M00_AXIS_TID(7 downto 0),
      s_axis_rqst_tlast => axis_switch_0_M00_AXIS_TLAST(0),
      s_axis_rqst_tready => axis_switch_0_M00_AXIS_TREADY,
      s_axis_rqst_tuser(255 downto 0) => axis_switch_0_M00_AXIS_TUSER(255 downto 0),
      s_axis_rqst_tvalid => axis_switch_0_M00_AXIS_TVALID(0)
    );
const_zero: component ddr4_intrfc_xlconstant_0_0
     port map (
      dout(1 downto 0) => const_zero_dout(1 downto 0)
    );
filter_id_0: component ddr4_intrfc_px_axis_filter_by_id_0_0
     port map (
      axis_aclk => ddr4_ui_clk_1,
      axis_aresetn => s_axis_aresetn_2,
      m_axis_tdata(511 downto 0) => filter_id_0_m_axis_TDATA(511 downto 0),
      m_axis_tid(7 downto 0) => filter_id_0_m_axis_TID(7 downto 0),
      m_axis_tlast => filter_id_0_m_axis_TLAST,
      m_axis_tuser(255 downto 0) => filter_id_0_m_axis_TUSER(255 downto 0),
      m_axis_tvalid => filter_id_0_m_axis_TVALID,
      s_axis_tdata(511 downto 0) => rsp_broadcast_M00_AXIS_TDATA(511 downto 0),
      s_axis_tid(7 downto 0) => rsp_broadcast_M00_AXIS_TID(7 downto 0),
      s_axis_tlast => rsp_broadcast_M00_AXIS_TLAST(0),
      s_axis_tuser(255 downto 0) => rsp_broadcast_M00_AXIS_TUSER(255 downto 0),
      s_axis_tvalid => rsp_broadcast_M00_AXIS_TVALID(0)
    );
filter_id_1: component ddr4_intrfc_filter_id_0_0
     port map (
      axis_aclk => ddr4_ui_clk_1,
      axis_aresetn => s_axis_aresetn_2,
      m_axis_tdata(511 downto 0) => filter_id_1_m_axis_TDATA(511 downto 0),
      m_axis_tid(7 downto 0) => filter_id_1_m_axis_TID(7 downto 0),
      m_axis_tlast => filter_id_1_m_axis_TLAST,
      m_axis_tuser(255 downto 0) => filter_id_1_m_axis_TUSER(255 downto 0),
      m_axis_tvalid => filter_id_1_m_axis_TVALID,
      s_axis_tdata(511 downto 0) => rsp_broadcast_M01_AXIS_TDATA(1023 downto 512),
      s_axis_tid(7 downto 0) => rsp_broadcast_M01_AXIS_TID(15 downto 8),
      s_axis_tlast => rsp_broadcast_M01_AXIS_TLAST(1),
      s_axis_tuser(255 downto 0) => rsp_broadcast_M01_AXIS_TUSER(511 downto 256),
      s_axis_tvalid => rsp_broadcast_M01_AXIS_TVALID(1)
    );
rq_regslice_1: component ddr4_intrfc_rq_regslice_2_1
     port map (
      aclk => ddr4_ui_clk_1,
      aresetn => s_axis_aresetn_2,
      m_axis_tdata(511 downto 0) => rq_regslice_1_M_AXIS_TDATA(511 downto 0),
      m_axis_tid(7 downto 0) => rq_regslice_1_M_AXIS_TID(7 downto 0),
      m_axis_tlast => rq_regslice_1_M_AXIS_TLAST,
      m_axis_tready => rq_regslice_1_M_AXIS_TREADY(1),
      m_axis_tuser(255 downto 0) => rq_regslice_1_M_AXIS_TUSER(255 downto 0),
      m_axis_tvalid => rq_regslice_1_M_AXIS_TVALID,
      s_axis_tdata(511 downto 0) => s_axis_dac_ddr_rqst_1_TDATA(511 downto 0),
      s_axis_tid(7 downto 0) => s_axis_dac_ddr_rqst_1_TID(7 downto 0),
      s_axis_tlast => s_axis_dac_ddr_rqst_1_TLAST,
      s_axis_tready => s_axis_dac_ddr_rqst_1_TREADY,
      s_axis_tuser(255 downto 0) => s_axis_dac_ddr_rqst_1_TUSER(255 downto 0),
      s_axis_tvalid => s_axis_dac_ddr_rqst_1_TVALID
    );
rsp_broadcast: component ddr4_intrfc_axis_broadcaster_0_0
     port map (
      aclk => ddr4_ui_clk_1,
      aresetn => s_axis_aresetn_2,
      m_axis_tdata(1023 downto 512) => rsp_broadcast_M01_AXIS_TDATA(1023 downto 512),
      m_axis_tdata(511 downto 0) => rsp_broadcast_M00_AXIS_TDATA(511 downto 0),
      m_axis_tid(15 downto 8) => rsp_broadcast_M01_AXIS_TID(15 downto 8),
      m_axis_tid(7 downto 0) => rsp_broadcast_M00_AXIS_TID(7 downto 0),
      m_axis_tlast(1) => rsp_broadcast_M01_AXIS_TLAST(1),
      m_axis_tlast(0) => rsp_broadcast_M00_AXIS_TLAST(0),
      m_axis_tuser(511 downto 256) => rsp_broadcast_M01_AXIS_TUSER(511 downto 256),
      m_axis_tuser(255 downto 0) => rsp_broadcast_M00_AXIS_TUSER(255 downto 0),
      m_axis_tvalid(1) => rsp_broadcast_M01_AXIS_TVALID(1),
      m_axis_tvalid(0) => rsp_broadcast_M00_AXIS_TVALID(0),
      s_axis_tdata(511 downto 0) => axisrq2ddrctlr_m_axis_rsp_TDATA(511 downto 0),
      s_axis_tid(7 downto 0) => axisrq2ddrctlr_m_axis_rsp_TID(7 downto 0),
      s_axis_tlast => axisrq2ddrctlr_m_axis_rsp_TLAST,
      s_axis_tuser(255 downto 0) => axisrq2ddrctlr_m_axis_rsp_TUSER(255 downto 0),
      s_axis_tvalid => axisrq2ddrctlr_m_axis_rsp_TVALID
    );
end STRUCTURE;
