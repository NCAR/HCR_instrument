--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
--Date        : Tue Apr 27 02:40:37 2021
--Host        : wind running 64-bit unknown
--Command     : generate_target ddr4_intrfc_wrapper.bd
--Design      : ddr4_intrfc_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ddr4_intrfc_wrapper is
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
end ddr4_intrfc_wrapper;

architecture STRUCTURE of ddr4_intrfc_wrapper is
  component ddr4_intrfc is
  port (
    s_axi_csr_aclk : in STD_LOGIC;
    s_axi_csr_aresetn : in STD_LOGIC;
    ddr4_ui_clk : in STD_LOGIC;
    init_calib_complete : in STD_LOGIC;
    ddr4_sys_rst : out STD_LOGIC;
    s_axis_aresetn : in STD_LOGIC;
    m_axis_pcie_ddr_rsp_tvalid : out STD_LOGIC;
    m_axis_pcie_ddr_rsp_tready : in STD_LOGIC;
    m_axis_pcie_ddr_rsp_tdata : out STD_LOGIC_VECTOR ( 511 downto 0 );
    m_axis_pcie_ddr_rsp_tlast : out STD_LOGIC;
    m_axis_pcie_ddr_rsp_tid : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_pcie_ddr_rsp_tuser : out STD_LOGIC_VECTOR ( 255 downto 0 );
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
    s_axis_dac_ddr_rqst_tvalid : in STD_LOGIC;
    s_axis_dac_ddr_rqst_tready : out STD_LOGIC;
    s_axis_dac_ddr_rqst_tdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
    s_axis_dac_ddr_rqst_tlast : in STD_LOGIC;
    s_axis_dac_ddr_rqst_tid : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_dac_ddr_rqst_tuser : in STD_LOGIC_VECTOR ( 255 downto 0 );
    s_axis_pcie_ddr_rqst_tvalid : in STD_LOGIC;
    s_axis_pcie_ddr_rqst_tready : out STD_LOGIC;
    s_axis_pcie_ddr_rqst_tdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
    s_axis_pcie_ddr_rqst_tlast : in STD_LOGIC;
    s_axis_pcie_ddr_rqst_tid : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_pcie_ddr_rqst_tuser : in STD_LOGIC_VECTOR ( 255 downto 0 );
    ddr4_ui_app_en : out STD_LOGIC;
    ddr4_ui_app_hi_pri : out STD_LOGIC;
    ddr4_ui_app_wdf_end : out STD_LOGIC;
    ddr4_ui_app_wdf_wren : out STD_LOGIC;
    ddr4_ui_app_rd_data_end : in STD_LOGIC;
    ddr4_ui_app_rd_data_valid : in STD_LOGIC;
    ddr4_ui_app_rdy : in STD_LOGIC;
    ddr4_ui_app_wdf_rdy : in STD_LOGIC;
    ddr4_ui_app_addr : out STD_LOGIC_VECTOR ( 28 downto 0 );
    ddr4_ui_app_cmd : out STD_LOGIC_VECTOR ( 2 downto 0 );
    ddr4_ui_app_wdf_data : out STD_LOGIC_VECTOR ( 639 downto 0 );
    ddr4_ui_app_wdf_mask : out STD_LOGIC_VECTOR ( 79 downto 0 );
    ddr4_ui_app_rd_data : in STD_LOGIC_VECTOR ( 639 downto 0 );
    m_axis_dac_ddr_rsp_tid : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_dac_ddr_rsp_tdata : out STD_LOGIC_VECTOR ( 511 downto 0 );
    m_axis_dac_ddr_rsp_tlast : out STD_LOGIC;
    m_axis_dac_ddr_rsp_tuser : out STD_LOGIC_VECTOR ( 255 downto 0 );
    m_axis_dac_ddr_rsp_tvalid : out STD_LOGIC
  );
  end component ddr4_intrfc;
begin
ddr4_intrfc_i: component ddr4_intrfc
     port map (
      ddr4_sys_rst => ddr4_sys_rst,
      ddr4_ui_app_addr(28 downto 0) => ddr4_ui_app_addr(28 downto 0),
      ddr4_ui_app_cmd(2 downto 0) => ddr4_ui_app_cmd(2 downto 0),
      ddr4_ui_app_en => ddr4_ui_app_en,
      ddr4_ui_app_hi_pri => ddr4_ui_app_hi_pri,
      ddr4_ui_app_rd_data(639 downto 0) => ddr4_ui_app_rd_data(639 downto 0),
      ddr4_ui_app_rd_data_end => ddr4_ui_app_rd_data_end,
      ddr4_ui_app_rd_data_valid => ddr4_ui_app_rd_data_valid,
      ddr4_ui_app_rdy => ddr4_ui_app_rdy,
      ddr4_ui_app_wdf_data(639 downto 0) => ddr4_ui_app_wdf_data(639 downto 0),
      ddr4_ui_app_wdf_end => ddr4_ui_app_wdf_end,
      ddr4_ui_app_wdf_mask(79 downto 0) => ddr4_ui_app_wdf_mask(79 downto 0),
      ddr4_ui_app_wdf_rdy => ddr4_ui_app_wdf_rdy,
      ddr4_ui_app_wdf_wren => ddr4_ui_app_wdf_wren,
      ddr4_ui_clk => ddr4_ui_clk,
      init_calib_complete => init_calib_complete,
      m_axis_dac_ddr_rsp_tdata(511 downto 0) => m_axis_dac_ddr_rsp_tdata(511 downto 0),
      m_axis_dac_ddr_rsp_tid(7 downto 0) => m_axis_dac_ddr_rsp_tid(7 downto 0),
      m_axis_dac_ddr_rsp_tlast => m_axis_dac_ddr_rsp_tlast,
      m_axis_dac_ddr_rsp_tuser(255 downto 0) => m_axis_dac_ddr_rsp_tuser(255 downto 0),
      m_axis_dac_ddr_rsp_tvalid => m_axis_dac_ddr_rsp_tvalid,
      m_axis_pcie_ddr_rsp_tdata(511 downto 0) => m_axis_pcie_ddr_rsp_tdata(511 downto 0),
      m_axis_pcie_ddr_rsp_tid(7 downto 0) => m_axis_pcie_ddr_rsp_tid(7 downto 0),
      m_axis_pcie_ddr_rsp_tlast => m_axis_pcie_ddr_rsp_tlast,
      m_axis_pcie_ddr_rsp_tready => m_axis_pcie_ddr_rsp_tready,
      m_axis_pcie_ddr_rsp_tuser(255 downto 0) => m_axis_pcie_ddr_rsp_tuser(255 downto 0),
      m_axis_pcie_ddr_rsp_tvalid => m_axis_pcie_ddr_rsp_tvalid,
      s_axi_csr_aclk => s_axi_csr_aclk,
      s_axi_csr_araddr(6 downto 0) => s_axi_csr_araddr(6 downto 0),
      s_axi_csr_aresetn => s_axi_csr_aresetn,
      s_axi_csr_arprot(2 downto 0) => s_axi_csr_arprot(2 downto 0),
      s_axi_csr_arready => s_axi_csr_arready,
      s_axi_csr_arvalid => s_axi_csr_arvalid,
      s_axi_csr_awaddr(6 downto 0) => s_axi_csr_awaddr(6 downto 0),
      s_axi_csr_awprot(2 downto 0) => s_axi_csr_awprot(2 downto 0),
      s_axi_csr_awready => s_axi_csr_awready,
      s_axi_csr_awvalid => s_axi_csr_awvalid,
      s_axi_csr_bready => s_axi_csr_bready,
      s_axi_csr_bresp(1 downto 0) => s_axi_csr_bresp(1 downto 0),
      s_axi_csr_bvalid => s_axi_csr_bvalid,
      s_axi_csr_rdata(31 downto 0) => s_axi_csr_rdata(31 downto 0),
      s_axi_csr_rready => s_axi_csr_rready,
      s_axi_csr_rresp(1 downto 0) => s_axi_csr_rresp(1 downto 0),
      s_axi_csr_rvalid => s_axi_csr_rvalid,
      s_axi_csr_wdata(31 downto 0) => s_axi_csr_wdata(31 downto 0),
      s_axi_csr_wready => s_axi_csr_wready,
      s_axi_csr_wstrb(3 downto 0) => s_axi_csr_wstrb(3 downto 0),
      s_axi_csr_wvalid => s_axi_csr_wvalid,
      s_axis_aresetn => s_axis_aresetn,
      s_axis_dac_ddr_rqst_tdata(511 downto 0) => s_axis_dac_ddr_rqst_tdata(511 downto 0),
      s_axis_dac_ddr_rqst_tid(7 downto 0) => s_axis_dac_ddr_rqst_tid(7 downto 0),
      s_axis_dac_ddr_rqst_tlast => s_axis_dac_ddr_rqst_tlast,
      s_axis_dac_ddr_rqst_tready => s_axis_dac_ddr_rqst_tready,
      s_axis_dac_ddr_rqst_tuser(255 downto 0) => s_axis_dac_ddr_rqst_tuser(255 downto 0),
      s_axis_dac_ddr_rqst_tvalid => s_axis_dac_ddr_rqst_tvalid,
      s_axis_pcie_ddr_rqst_tdata(511 downto 0) => s_axis_pcie_ddr_rqst_tdata(511 downto 0),
      s_axis_pcie_ddr_rqst_tid(7 downto 0) => s_axis_pcie_ddr_rqst_tid(7 downto 0),
      s_axis_pcie_ddr_rqst_tlast => s_axis_pcie_ddr_rqst_tlast,
      s_axis_pcie_ddr_rqst_tready => s_axis_pcie_ddr_rqst_tready,
      s_axis_pcie_ddr_rqst_tuser(255 downto 0) => s_axis_pcie_ddr_rqst_tuser(255 downto 0),
      s_axis_pcie_ddr_rqst_tvalid => s_axis_pcie_ddr_rqst_tvalid
    );
end STRUCTURE;
