//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
//Date        : Tue Aug 15 10:13:15 2017
//Host        : Rich-PC running 64-bit major release  (build 9200)
//Command     : generate_target ddr4_intrfc_wrapper.bd
//Design      : ddr4_intrfc_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module ddr4_intrfc_wrapper
   (ddr4_sys_rst,
    ddr4_ui_app_addr,
    ddr4_ui_app_cmd,
    ddr4_ui_app_en,
    ddr4_ui_app_hi_pri,
    ddr4_ui_app_rd_data,
    ddr4_ui_app_rd_data_end,
    ddr4_ui_app_rd_data_valid,
    ddr4_ui_app_rdy,
    ddr4_ui_app_wdf_data,
    ddr4_ui_app_wdf_end,
    ddr4_ui_app_wdf_mask,
    ddr4_ui_app_wdf_rdy,
    ddr4_ui_app_wdf_wren,
    ddr4_ui_clk,
    init_calib_complete,
    m_axis_dac_ddr_rsp_tdata,
    m_axis_dac_ddr_rsp_tid,
    m_axis_dac_ddr_rsp_tlast,
    m_axis_dac_ddr_rsp_tuser,
    m_axis_dac_ddr_rsp_tvalid,
    m_axis_pcie_ddr_rsp_tdata,
    m_axis_pcie_ddr_rsp_tid,
    m_axis_pcie_ddr_rsp_tlast,
    m_axis_pcie_ddr_rsp_tready,
    m_axis_pcie_ddr_rsp_tuser,
    m_axis_pcie_ddr_rsp_tvalid,
    s_axi_csr_aclk,
    s_axi_csr_araddr,
    s_axi_csr_aresetn,
    s_axi_csr_arprot,
    s_axi_csr_arready,
    s_axi_csr_arvalid,
    s_axi_csr_awaddr,
    s_axi_csr_awprot,
    s_axi_csr_awready,
    s_axi_csr_awvalid,
    s_axi_csr_bready,
    s_axi_csr_bresp,
    s_axi_csr_bvalid,
    s_axi_csr_rdata,
    s_axi_csr_rready,
    s_axi_csr_rresp,
    s_axi_csr_rvalid,
    s_axi_csr_wdata,
    s_axi_csr_wready,
    s_axi_csr_wstrb,
    s_axi_csr_wvalid,
    s_axis_aresetn,
    s_axis_dac_ddr_rqst_tdata,
    s_axis_dac_ddr_rqst_tid,
    s_axis_dac_ddr_rqst_tlast,
    s_axis_dac_ddr_rqst_tready,
    s_axis_dac_ddr_rqst_tuser,
    s_axis_dac_ddr_rqst_tvalid,
    s_axis_pcie_ddr_rqst_tdata,
    s_axis_pcie_ddr_rqst_tid,
    s_axis_pcie_ddr_rqst_tlast,
    s_axis_pcie_ddr_rqst_tready,
    s_axis_pcie_ddr_rqst_tuser,
    s_axis_pcie_ddr_rqst_tvalid);
  output ddr4_sys_rst;
  output [28:0]ddr4_ui_app_addr;
  output [2:0]ddr4_ui_app_cmd;
  output ddr4_ui_app_en;
  output ddr4_ui_app_hi_pri;
  input [639:0]ddr4_ui_app_rd_data;
  input ddr4_ui_app_rd_data_end;
  input ddr4_ui_app_rd_data_valid;
  input ddr4_ui_app_rdy;
  output [639:0]ddr4_ui_app_wdf_data;
  output ddr4_ui_app_wdf_end;
  output [79:0]ddr4_ui_app_wdf_mask;
  input ddr4_ui_app_wdf_rdy;
  output ddr4_ui_app_wdf_wren;
  input ddr4_ui_clk;
  input init_calib_complete;
  output [511:0]m_axis_dac_ddr_rsp_tdata;
  output [7:0]m_axis_dac_ddr_rsp_tid;
  output m_axis_dac_ddr_rsp_tlast;
  output [255:0]m_axis_dac_ddr_rsp_tuser;
  output m_axis_dac_ddr_rsp_tvalid;
  output [511:0]m_axis_pcie_ddr_rsp_tdata;
  output [7:0]m_axis_pcie_ddr_rsp_tid;
  output m_axis_pcie_ddr_rsp_tlast;
  input m_axis_pcie_ddr_rsp_tready;
  output [255:0]m_axis_pcie_ddr_rsp_tuser;
  output m_axis_pcie_ddr_rsp_tvalid;
  input s_axi_csr_aclk;
  input [6:0]s_axi_csr_araddr;
  input s_axi_csr_aresetn;
  input [2:0]s_axi_csr_arprot;
  output s_axi_csr_arready;
  input s_axi_csr_arvalid;
  input [6:0]s_axi_csr_awaddr;
  input [2:0]s_axi_csr_awprot;
  output s_axi_csr_awready;
  input s_axi_csr_awvalid;
  input s_axi_csr_bready;
  output [1:0]s_axi_csr_bresp;
  output s_axi_csr_bvalid;
  output [31:0]s_axi_csr_rdata;
  input s_axi_csr_rready;
  output [1:0]s_axi_csr_rresp;
  output s_axi_csr_rvalid;
  input [31:0]s_axi_csr_wdata;
  output s_axi_csr_wready;
  input [3:0]s_axi_csr_wstrb;
  input s_axi_csr_wvalid;
  input s_axis_aresetn;
  input [511:0]s_axis_dac_ddr_rqst_tdata;
  input [7:0]s_axis_dac_ddr_rqst_tid;
  input s_axis_dac_ddr_rqst_tlast;
  output s_axis_dac_ddr_rqst_tready;
  input [255:0]s_axis_dac_ddr_rqst_tuser;
  input s_axis_dac_ddr_rqst_tvalid;
  input [511:0]s_axis_pcie_ddr_rqst_tdata;
  input [7:0]s_axis_pcie_ddr_rqst_tid;
  input s_axis_pcie_ddr_rqst_tlast;
  output s_axis_pcie_ddr_rqst_tready;
  input [255:0]s_axis_pcie_ddr_rqst_tuser;
  input s_axis_pcie_ddr_rqst_tvalid;

  wire ddr4_sys_rst;
  wire [28:0]ddr4_ui_app_addr;
  wire [2:0]ddr4_ui_app_cmd;
  wire ddr4_ui_app_en;
  wire ddr4_ui_app_hi_pri;
  wire [639:0]ddr4_ui_app_rd_data;
  wire ddr4_ui_app_rd_data_end;
  wire ddr4_ui_app_rd_data_valid;
  wire ddr4_ui_app_rdy;
  wire [639:0]ddr4_ui_app_wdf_data;
  wire ddr4_ui_app_wdf_end;
  wire [79:0]ddr4_ui_app_wdf_mask;
  wire ddr4_ui_app_wdf_rdy;
  wire ddr4_ui_app_wdf_wren;
  wire ddr4_ui_clk;
  wire init_calib_complete;
  wire [511:0]m_axis_dac_ddr_rsp_tdata;
  wire [7:0]m_axis_dac_ddr_rsp_tid;
  wire m_axis_dac_ddr_rsp_tlast;
  wire [255:0]m_axis_dac_ddr_rsp_tuser;
  wire m_axis_dac_ddr_rsp_tvalid;
  wire [511:0]m_axis_pcie_ddr_rsp_tdata;
  wire [7:0]m_axis_pcie_ddr_rsp_tid;
  wire m_axis_pcie_ddr_rsp_tlast;
  wire m_axis_pcie_ddr_rsp_tready;
  wire [255:0]m_axis_pcie_ddr_rsp_tuser;
  wire m_axis_pcie_ddr_rsp_tvalid;
  wire s_axi_csr_aclk;
  wire [6:0]s_axi_csr_araddr;
  wire s_axi_csr_aresetn;
  wire [2:0]s_axi_csr_arprot;
  wire s_axi_csr_arready;
  wire s_axi_csr_arvalid;
  wire [6:0]s_axi_csr_awaddr;
  wire [2:0]s_axi_csr_awprot;
  wire s_axi_csr_awready;
  wire s_axi_csr_awvalid;
  wire s_axi_csr_bready;
  wire [1:0]s_axi_csr_bresp;
  wire s_axi_csr_bvalid;
  wire [31:0]s_axi_csr_rdata;
  wire s_axi_csr_rready;
  wire [1:0]s_axi_csr_rresp;
  wire s_axi_csr_rvalid;
  wire [31:0]s_axi_csr_wdata;
  wire s_axi_csr_wready;
  wire [3:0]s_axi_csr_wstrb;
  wire s_axi_csr_wvalid;
  wire s_axis_aresetn;
  wire [511:0]s_axis_dac_ddr_rqst_tdata;
  wire [7:0]s_axis_dac_ddr_rqst_tid;
  wire s_axis_dac_ddr_rqst_tlast;
  wire s_axis_dac_ddr_rqst_tready;
  wire [255:0]s_axis_dac_ddr_rqst_tuser;
  wire s_axis_dac_ddr_rqst_tvalid;
  wire [511:0]s_axis_pcie_ddr_rqst_tdata;
  wire [7:0]s_axis_pcie_ddr_rqst_tid;
  wire s_axis_pcie_ddr_rqst_tlast;
  wire s_axis_pcie_ddr_rqst_tready;
  wire [255:0]s_axis_pcie_ddr_rqst_tuser;
  wire s_axis_pcie_ddr_rqst_tvalid;

  ddr4_intrfc ddr4_intrfc_i
       (.ddr4_sys_rst(ddr4_sys_rst),
        .ddr4_ui_app_addr(ddr4_ui_app_addr),
        .ddr4_ui_app_cmd(ddr4_ui_app_cmd),
        .ddr4_ui_app_en(ddr4_ui_app_en),
        .ddr4_ui_app_hi_pri(ddr4_ui_app_hi_pri),
        .ddr4_ui_app_rd_data(ddr4_ui_app_rd_data),
        .ddr4_ui_app_rd_data_end(ddr4_ui_app_rd_data_end),
        .ddr4_ui_app_rd_data_valid(ddr4_ui_app_rd_data_valid),
        .ddr4_ui_app_rdy(ddr4_ui_app_rdy),
        .ddr4_ui_app_wdf_data(ddr4_ui_app_wdf_data),
        .ddr4_ui_app_wdf_end(ddr4_ui_app_wdf_end),
        .ddr4_ui_app_wdf_mask(ddr4_ui_app_wdf_mask),
        .ddr4_ui_app_wdf_rdy(ddr4_ui_app_wdf_rdy),
        .ddr4_ui_app_wdf_wren(ddr4_ui_app_wdf_wren),
        .ddr4_ui_clk(ddr4_ui_clk),
        .init_calib_complete(init_calib_complete),
        .m_axis_dac_ddr_rsp_tdata(m_axis_dac_ddr_rsp_tdata),
        .m_axis_dac_ddr_rsp_tid(m_axis_dac_ddr_rsp_tid),
        .m_axis_dac_ddr_rsp_tlast(m_axis_dac_ddr_rsp_tlast),
        .m_axis_dac_ddr_rsp_tuser(m_axis_dac_ddr_rsp_tuser),
        .m_axis_dac_ddr_rsp_tvalid(m_axis_dac_ddr_rsp_tvalid),
        .m_axis_pcie_ddr_rsp_tdata(m_axis_pcie_ddr_rsp_tdata),
        .m_axis_pcie_ddr_rsp_tid(m_axis_pcie_ddr_rsp_tid),
        .m_axis_pcie_ddr_rsp_tlast(m_axis_pcie_ddr_rsp_tlast),
        .m_axis_pcie_ddr_rsp_tready(m_axis_pcie_ddr_rsp_tready),
        .m_axis_pcie_ddr_rsp_tuser(m_axis_pcie_ddr_rsp_tuser),
        .m_axis_pcie_ddr_rsp_tvalid(m_axis_pcie_ddr_rsp_tvalid),
        .s_axi_csr_aclk(s_axi_csr_aclk),
        .s_axi_csr_araddr(s_axi_csr_araddr),
        .s_axi_csr_aresetn(s_axi_csr_aresetn),
        .s_axi_csr_arprot(s_axi_csr_arprot),
        .s_axi_csr_arready(s_axi_csr_arready),
        .s_axi_csr_arvalid(s_axi_csr_arvalid),
        .s_axi_csr_awaddr(s_axi_csr_awaddr),
        .s_axi_csr_awprot(s_axi_csr_awprot),
        .s_axi_csr_awready(s_axi_csr_awready),
        .s_axi_csr_awvalid(s_axi_csr_awvalid),
        .s_axi_csr_bready(s_axi_csr_bready),
        .s_axi_csr_bresp(s_axi_csr_bresp),
        .s_axi_csr_bvalid(s_axi_csr_bvalid),
        .s_axi_csr_rdata(s_axi_csr_rdata),
        .s_axi_csr_rready(s_axi_csr_rready),
        .s_axi_csr_rresp(s_axi_csr_rresp),
        .s_axi_csr_rvalid(s_axi_csr_rvalid),
        .s_axi_csr_wdata(s_axi_csr_wdata),
        .s_axi_csr_wready(s_axi_csr_wready),
        .s_axi_csr_wstrb(s_axi_csr_wstrb),
        .s_axi_csr_wvalid(s_axi_csr_wvalid),
        .s_axis_aresetn(s_axis_aresetn),
        .s_axis_dac_ddr_rqst_tdata(s_axis_dac_ddr_rqst_tdata),
        .s_axis_dac_ddr_rqst_tid(s_axis_dac_ddr_rqst_tid),
        .s_axis_dac_ddr_rqst_tlast(s_axis_dac_ddr_rqst_tlast),
        .s_axis_dac_ddr_rqst_tready(s_axis_dac_ddr_rqst_tready),
        .s_axis_dac_ddr_rqst_tuser(s_axis_dac_ddr_rqst_tuser),
        .s_axis_dac_ddr_rqst_tvalid(s_axis_dac_ddr_rqst_tvalid),
        .s_axis_pcie_ddr_rqst_tdata(s_axis_pcie_ddr_rqst_tdata),
        .s_axis_pcie_ddr_rqst_tid(s_axis_pcie_ddr_rqst_tid),
        .s_axis_pcie_ddr_rqst_tlast(s_axis_pcie_ddr_rqst_tlast),
        .s_axis_pcie_ddr_rqst_tready(s_axis_pcie_ddr_rqst_tready),
        .s_axis_pcie_ddr_rqst_tuser(s_axis_pcie_ddr_rqst_tuser),
        .s_axis_pcie_ddr_rqst_tvalid(s_axis_pcie_ddr_rqst_tvalid));
endmodule
