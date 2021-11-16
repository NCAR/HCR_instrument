//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
//Date        : Tue Aug 15 10:01:53 2017
//Host        : Rich-PC running 64-bit major release  (build 9200)
//Command     : generate_target user_block1_wrapper.bd
//Design      : user_block1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module user_block1_wrapper
   (m_axis_adc_ch0_pdti_tdata,
    m_axis_adc_ch0_pdti_tuser,
    m_axis_adc_ch0_pdti_tvalid,
    m_axis_adc_ch1_pdti_tdata,
    m_axis_adc_ch1_pdti_tuser,
    m_axis_adc_ch1_pdti_tvalid,
    m_axis_adc_ch2_pdti_tdata,
    m_axis_adc_ch2_pdti_tuser,
    m_axis_adc_ch2_pdti_tvalid,
    m_axis_dac_pdti_tdata,
    m_axis_dac_pdti_tuser,
    m_axis_dac_pdti_tvalid,
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
    s_axis_adc_ch0_pdti_tdata,
    s_axis_adc_ch0_pdti_tuser,
    s_axis_adc_ch0_pdti_tvalid,
    s_axis_adc_ch1_pdti_tdata,
    s_axis_adc_ch1_pdti_tuser,
    s_axis_adc_ch1_pdti_tvalid,
    s_axis_adc_ch2_pdti_tdata,
    s_axis_adc_ch2_pdti_tuser,
    s_axis_adc_ch2_pdti_tvalid,
    s_axis_adc_pdti_aclk,
    s_axis_adc_pdti_aresetn,
    s_axis_dac_pdti_aclk,
    s_axis_dac_pdti_aresetn,
    s_axis_dac_pdti_tdata,
    s_axis_dac_pdti_tuser,
    s_axis_dac_pdti_tvalid,
    user1_irq);
  output [15:0]m_axis_adc_ch0_pdti_tdata;
  output [127:0]m_axis_adc_ch0_pdti_tuser;
  output m_axis_adc_ch0_pdti_tvalid;
  output [15:0]m_axis_adc_ch1_pdti_tdata;
  output [127:0]m_axis_adc_ch1_pdti_tuser;
  output m_axis_adc_ch1_pdti_tvalid;
  output [15:0]m_axis_adc_ch2_pdti_tdata;
  output [127:0]m_axis_adc_ch2_pdti_tuser;
  output m_axis_adc_ch2_pdti_tvalid;
  output [31:0]m_axis_dac_pdti_tdata;
  output [127:0]m_axis_dac_pdti_tuser;
  output m_axis_dac_pdti_tvalid;
  input s_axi_csr_aclk;
  input [25:0]s_axi_csr_araddr;
  input s_axi_csr_aresetn;
  input [2:0]s_axi_csr_arprot;
  output s_axi_csr_arready;
  input s_axi_csr_arvalid;
  input [25:0]s_axi_csr_awaddr;
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
  input [15:0]s_axis_adc_ch0_pdti_tdata;
  input [127:0]s_axis_adc_ch0_pdti_tuser;
  input s_axis_adc_ch0_pdti_tvalid;
  input [15:0]s_axis_adc_ch1_pdti_tdata;
  input [127:0]s_axis_adc_ch1_pdti_tuser;
  input s_axis_adc_ch1_pdti_tvalid;
  input [15:0]s_axis_adc_ch2_pdti_tdata;
  input [127:0]s_axis_adc_ch2_pdti_tuser;
  input s_axis_adc_ch2_pdti_tvalid;
  input s_axis_adc_pdti_aclk;
  input s_axis_adc_pdti_aresetn;
  input s_axis_dac_pdti_aclk;
  input s_axis_dac_pdti_aresetn;
  input [31:0]s_axis_dac_pdti_tdata;
  input [127:0]s_axis_dac_pdti_tuser;
  input s_axis_dac_pdti_tvalid;
  output [1:0]user1_irq;

  wire [15:0]m_axis_adc_ch0_pdti_tdata;
  wire [127:0]m_axis_adc_ch0_pdti_tuser;
  wire m_axis_adc_ch0_pdti_tvalid;
  wire [15:0]m_axis_adc_ch1_pdti_tdata;
  wire [127:0]m_axis_adc_ch1_pdti_tuser;
  wire m_axis_adc_ch1_pdti_tvalid;
  wire [15:0]m_axis_adc_ch2_pdti_tdata;
  wire [127:0]m_axis_adc_ch2_pdti_tuser;
  wire m_axis_adc_ch2_pdti_tvalid;
  wire [31:0]m_axis_dac_pdti_tdata;
  wire [127:0]m_axis_dac_pdti_tuser;
  wire m_axis_dac_pdti_tvalid;
  wire s_axi_csr_aclk;
  wire [25:0]s_axi_csr_araddr;
  wire s_axi_csr_aresetn;
  wire [2:0]s_axi_csr_arprot;
  wire s_axi_csr_arready;
  wire s_axi_csr_arvalid;
  wire [25:0]s_axi_csr_awaddr;
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
  wire [15:0]s_axis_adc_ch0_pdti_tdata;
  wire [127:0]s_axis_adc_ch0_pdti_tuser;
  wire s_axis_adc_ch0_pdti_tvalid;
  wire [15:0]s_axis_adc_ch1_pdti_tdata;
  wire [127:0]s_axis_adc_ch1_pdti_tuser;
  wire s_axis_adc_ch1_pdti_tvalid;
  wire [15:0]s_axis_adc_ch2_pdti_tdata;
  wire [127:0]s_axis_adc_ch2_pdti_tuser;
  wire s_axis_adc_ch2_pdti_tvalid;
  wire s_axis_adc_pdti_aclk;
  wire s_axis_adc_pdti_aresetn;
  wire s_axis_dac_pdti_aclk;
  wire s_axis_dac_pdti_aresetn;
  wire [31:0]s_axis_dac_pdti_tdata;
  wire [127:0]s_axis_dac_pdti_tuser;
  wire s_axis_dac_pdti_tvalid;
  wire [1:0]user1_irq;

  user_block1 user_block1_i
       (.m_axis_adc_ch0_pdti_tdata(m_axis_adc_ch0_pdti_tdata),
        .m_axis_adc_ch0_pdti_tuser(m_axis_adc_ch0_pdti_tuser),
        .m_axis_adc_ch0_pdti_tvalid(m_axis_adc_ch0_pdti_tvalid),
        .m_axis_adc_ch1_pdti_tdata(m_axis_adc_ch1_pdti_tdata),
        .m_axis_adc_ch1_pdti_tuser(m_axis_adc_ch1_pdti_tuser),
        .m_axis_adc_ch1_pdti_tvalid(m_axis_adc_ch1_pdti_tvalid),
        .m_axis_adc_ch2_pdti_tdata(m_axis_adc_ch2_pdti_tdata),
        .m_axis_adc_ch2_pdti_tuser(m_axis_adc_ch2_pdti_tuser),
        .m_axis_adc_ch2_pdti_tvalid(m_axis_adc_ch2_pdti_tvalid),
        .m_axis_dac_pdti_tdata(m_axis_dac_pdti_tdata),
        .m_axis_dac_pdti_tuser(m_axis_dac_pdti_tuser),
        .m_axis_dac_pdti_tvalid(m_axis_dac_pdti_tvalid),
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
        .s_axis_adc_ch0_pdti_tdata(s_axis_adc_ch0_pdti_tdata),
        .s_axis_adc_ch0_pdti_tuser(s_axis_adc_ch0_pdti_tuser),
        .s_axis_adc_ch0_pdti_tvalid(s_axis_adc_ch0_pdti_tvalid),
        .s_axis_adc_ch1_pdti_tdata(s_axis_adc_ch1_pdti_tdata),
        .s_axis_adc_ch1_pdti_tuser(s_axis_adc_ch1_pdti_tuser),
        .s_axis_adc_ch1_pdti_tvalid(s_axis_adc_ch1_pdti_tvalid),
        .s_axis_adc_ch2_pdti_tdata(s_axis_adc_ch2_pdti_tdata),
        .s_axis_adc_ch2_pdti_tuser(s_axis_adc_ch2_pdti_tuser),
        .s_axis_adc_ch2_pdti_tvalid(s_axis_adc_ch2_pdti_tvalid),
        .s_axis_adc_pdti_aclk(s_axis_adc_pdti_aclk),
        .s_axis_adc_pdti_aresetn(s_axis_adc_pdti_aresetn),
        .s_axis_dac_pdti_aclk(s_axis_dac_pdti_aclk),
        .s_axis_dac_pdti_aresetn(s_axis_dac_pdti_aresetn),
        .s_axis_dac_pdti_tdata(s_axis_dac_pdti_tdata),
        .s_axis_dac_pdti_tuser(s_axis_dac_pdti_tuser),
        .s_axis_dac_pdti_tvalid(s_axis_dac_pdti_tvalid),
        .user1_irq(user1_irq));
endmodule
