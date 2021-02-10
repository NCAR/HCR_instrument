//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
//Date        : Fri Mar  2 10:58:24 2018
//Host        : eol-hawkeye running 64-bit major release  (build 9200)
//Command     : generate_target data_acq_wrapper.bd
//Design      : data_acq_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module data_acq_wrapper
   (adc0_fifo_full_stat,
    adc1_fifo_full_stat,
    adc2_fifo_full_stat,
    ddr4_ui_clk,
    m_axis_dac_pdti_tdata,
    m_axis_dac_pdti_tuser,
    m_axis_dac_pdti_tvalid,
    m_axis_ddr_rqst_tdata,
    m_axis_ddr_rqst_tid,
    m_axis_ddr_rqst_tlast,
    m_axis_ddr_rqst_tready,
    m_axis_ddr_rqst_tuser,
    m_axis_ddr_rqst_tvalid,
    m_axis_pcie_rq_tdata,
    m_axis_pcie_rq_tkeep,
    m_axis_pcie_rq_tlast,
    m_axis_pcie_rq_tready,
    m_axis_pcie_rq_tuser,
    m_axis_pcie_rq_tvalid,
    pcie_dma_irq,
    pdti2ppkt_irq,
    realtime_lost_stat,
    rq_shutdown_ok,
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
    s_axis_dac_pctl_tdata,
    s_axis_dac_pctl_tvalid,
    s_axis_dac_pdti_aclk,
    s_axis_dac_pdti_aresetn,
    s_axis_dma_pcie_cntl_tdata,
    s_axis_dma_pcie_cntl_tready,
    s_axis_dma_pcie_cntl_tvalid,
    s_axis_pcie_rc_tdata,
    s_axis_pcie_rc_tkeep,
    s_axis_pcie_rc_tlast,
    s_axis_pcie_rc_tready,
    s_axis_pcie_rc_tuser,
    s_axis_pcie_rc_tvalid,
    s_axis_wave_ddr_rsp_tdata,
    s_axis_wave_ddr_rsp_tid,
    s_axis_wave_ddr_rsp_tlast,
    s_axis_wave_ddr_rsp_tuser,
    s_axis_wave_ddr_rsp_tvalid,
    shutdown_rqst);
  output adc0_fifo_full_stat;
  output adc1_fifo_full_stat;
  output adc2_fifo_full_stat;
  input ddr4_ui_clk;
  output [31:0]m_axis_dac_pdti_tdata;
  output [127:0]m_axis_dac_pdti_tuser;
  output m_axis_dac_pdti_tvalid;
  output [511:0]m_axis_ddr_rqst_tdata;
  output [7:0]m_axis_ddr_rqst_tid;
  output [0:0]m_axis_ddr_rqst_tlast;
  input [0:0]m_axis_ddr_rqst_tready;
  output [255:0]m_axis_ddr_rqst_tuser;
  output [0:0]m_axis_ddr_rqst_tvalid;
  output [255:0]m_axis_pcie_rq_tdata;
  output [31:0]m_axis_pcie_rq_tkeep;
  output m_axis_pcie_rq_tlast;
  input m_axis_pcie_rq_tready;
  output [59:0]m_axis_pcie_rq_tuser;
  output m_axis_pcie_rq_tvalid;
  output [15:0]pcie_dma_irq;
  output [0:0]pdti2ppkt_irq;
  output realtime_lost_stat;
  output rq_shutdown_ok;
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
  input [31:0]s_axis_adc_ch0_pdti_tdata;
  input [127:0]s_axis_adc_ch0_pdti_tuser;
  input s_axis_adc_ch0_pdti_tvalid;
  input [31:0]s_axis_adc_ch1_pdti_tdata;
  input [127:0]s_axis_adc_ch1_pdti_tuser;
  input s_axis_adc_ch1_pdti_tvalid;
  input [31:0]s_axis_adc_ch2_pdti_tdata;
  input [127:0]s_axis_adc_ch2_pdti_tuser;
  input s_axis_adc_ch2_pdti_tvalid;
  input s_axis_adc_pdti_aclk;
  input s_axis_adc_pdti_aresetn;
  input [7:0]s_axis_dac_pctl_tdata;
  input s_axis_dac_pctl_tvalid;
  input s_axis_dac_pdti_aclk;
  input s_axis_dac_pdti_aresetn;
  input [7:0]s_axis_dma_pcie_cntl_tdata;
  output s_axis_dma_pcie_cntl_tready;
  input s_axis_dma_pcie_cntl_tvalid;
  input [255:0]s_axis_pcie_rc_tdata;
  input [31:0]s_axis_pcie_rc_tkeep;
  input s_axis_pcie_rc_tlast;
  output s_axis_pcie_rc_tready;
  input [74:0]s_axis_pcie_rc_tuser;
  input s_axis_pcie_rc_tvalid;
  input [511:0]s_axis_wave_ddr_rsp_tdata;
  input [7:0]s_axis_wave_ddr_rsp_tid;
  input s_axis_wave_ddr_rsp_tlast;
  input [255:0]s_axis_wave_ddr_rsp_tuser;
  input s_axis_wave_ddr_rsp_tvalid;
  input shutdown_rqst;

  wire adc0_fifo_full_stat;
  wire adc1_fifo_full_stat;
  wire adc2_fifo_full_stat;
  wire ddr4_ui_clk;
  wire [31:0]m_axis_dac_pdti_tdata;
  wire [127:0]m_axis_dac_pdti_tuser;
  wire m_axis_dac_pdti_tvalid;
  wire [511:0]m_axis_ddr_rqst_tdata;
  wire [7:0]m_axis_ddr_rqst_tid;
  wire [0:0]m_axis_ddr_rqst_tlast;
  wire [0:0]m_axis_ddr_rqst_tready;
  wire [255:0]m_axis_ddr_rqst_tuser;
  wire [0:0]m_axis_ddr_rqst_tvalid;
  wire [255:0]m_axis_pcie_rq_tdata;
  wire [31:0]m_axis_pcie_rq_tkeep;
  wire m_axis_pcie_rq_tlast;
  wire m_axis_pcie_rq_tready;
  wire [59:0]m_axis_pcie_rq_tuser;
  wire m_axis_pcie_rq_tvalid;
  wire [15:0]pcie_dma_irq;
  wire [0:0]pdti2ppkt_irq;
  wire realtime_lost_stat;
  wire rq_shutdown_ok;
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
  wire [31:0]s_axis_adc_ch0_pdti_tdata;
  wire [127:0]s_axis_adc_ch0_pdti_tuser;
  wire s_axis_adc_ch0_pdti_tvalid;
  wire [31:0]s_axis_adc_ch1_pdti_tdata;
  wire [127:0]s_axis_adc_ch1_pdti_tuser;
  wire s_axis_adc_ch1_pdti_tvalid;
  wire [31:0]s_axis_adc_ch2_pdti_tdata;
  wire [127:0]s_axis_adc_ch2_pdti_tuser;
  wire s_axis_adc_ch2_pdti_tvalid;
  wire s_axis_adc_pdti_aclk;
  wire s_axis_adc_pdti_aresetn;
  wire [7:0]s_axis_dac_pctl_tdata;
  wire s_axis_dac_pctl_tvalid;
  wire s_axis_dac_pdti_aclk;
  wire s_axis_dac_pdti_aresetn;
  wire [7:0]s_axis_dma_pcie_cntl_tdata;
  wire s_axis_dma_pcie_cntl_tready;
  wire s_axis_dma_pcie_cntl_tvalid;
  wire [255:0]s_axis_pcie_rc_tdata;
  wire [31:0]s_axis_pcie_rc_tkeep;
  wire s_axis_pcie_rc_tlast;
  wire s_axis_pcie_rc_tready;
  wire [74:0]s_axis_pcie_rc_tuser;
  wire s_axis_pcie_rc_tvalid;
  wire [511:0]s_axis_wave_ddr_rsp_tdata;
  wire [7:0]s_axis_wave_ddr_rsp_tid;
  wire s_axis_wave_ddr_rsp_tlast;
  wire [255:0]s_axis_wave_ddr_rsp_tuser;
  wire s_axis_wave_ddr_rsp_tvalid;
  wire shutdown_rqst;

  data_acq data_acq_i
       (.adc0_fifo_full_stat(adc0_fifo_full_stat),
        .adc1_fifo_full_stat(adc1_fifo_full_stat),
        .adc2_fifo_full_stat(adc2_fifo_full_stat),
        .ddr4_ui_clk(ddr4_ui_clk),
        .m_axis_dac_pdti_tdata(m_axis_dac_pdti_tdata),
        .m_axis_dac_pdti_tuser(m_axis_dac_pdti_tuser),
        .m_axis_dac_pdti_tvalid(m_axis_dac_pdti_tvalid),
        .m_axis_ddr_rqst_tdata(m_axis_ddr_rqst_tdata),
        .m_axis_ddr_rqst_tid(m_axis_ddr_rqst_tid),
        .m_axis_ddr_rqst_tlast(m_axis_ddr_rqst_tlast),
        .m_axis_ddr_rqst_tready(m_axis_ddr_rqst_tready),
        .m_axis_ddr_rqst_tuser(m_axis_ddr_rqst_tuser),
        .m_axis_ddr_rqst_tvalid(m_axis_ddr_rqst_tvalid),
        .m_axis_pcie_rq_tdata(m_axis_pcie_rq_tdata),
        .m_axis_pcie_rq_tkeep(m_axis_pcie_rq_tkeep),
        .m_axis_pcie_rq_tlast(m_axis_pcie_rq_tlast),
        .m_axis_pcie_rq_tready(m_axis_pcie_rq_tready),
        .m_axis_pcie_rq_tuser(m_axis_pcie_rq_tuser),
        .m_axis_pcie_rq_tvalid(m_axis_pcie_rq_tvalid),
        .pcie_dma_irq(pcie_dma_irq),
        .pdti2ppkt_irq(pdti2ppkt_irq),
        .realtime_lost_stat(realtime_lost_stat),
        .rq_shutdown_ok(rq_shutdown_ok),
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
        .s_axis_dac_pctl_tdata(s_axis_dac_pctl_tdata),
        .s_axis_dac_pctl_tvalid(s_axis_dac_pctl_tvalid),
        .s_axis_dac_pdti_aclk(s_axis_dac_pdti_aclk),
        .s_axis_dac_pdti_aresetn(s_axis_dac_pdti_aresetn),
        .s_axis_dma_pcie_cntl_tdata(s_axis_dma_pcie_cntl_tdata),
        .s_axis_dma_pcie_cntl_tready(s_axis_dma_pcie_cntl_tready),
        .s_axis_dma_pcie_cntl_tvalid(s_axis_dma_pcie_cntl_tvalid),
        .s_axis_pcie_rc_tdata(s_axis_pcie_rc_tdata),
        .s_axis_pcie_rc_tkeep(s_axis_pcie_rc_tkeep),
        .s_axis_pcie_rc_tlast(s_axis_pcie_rc_tlast),
        .s_axis_pcie_rc_tready(s_axis_pcie_rc_tready),
        .s_axis_pcie_rc_tuser(s_axis_pcie_rc_tuser),
        .s_axis_pcie_rc_tvalid(s_axis_pcie_rc_tvalid),
        .s_axis_wave_ddr_rsp_tdata(s_axis_wave_ddr_rsp_tdata),
        .s_axis_wave_ddr_rsp_tid(s_axis_wave_ddr_rsp_tid),
        .s_axis_wave_ddr_rsp_tlast(s_axis_wave_ddr_rsp_tlast),
        .s_axis_wave_ddr_rsp_tuser(s_axis_wave_ddr_rsp_tuser),
        .s_axis_wave_ddr_rsp_tvalid(s_axis_wave_ddr_rsp_tvalid),
        .shutdown_rqst(shutdown_rqst));
endmodule
