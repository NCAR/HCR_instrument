//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
//Date        : Thu Aug 20 16:15:02 2020
//Host        : DESKTOP-AI6ONV9 running 64-bit major release  (build 9200)
//Command     : generate_target dataio_intrfc_wrapper.bd
//Design      : dataio_intrfc_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module dataio_intrfc_wrapper
   (adc0_d0_1_n,
    adc0_d0_1_p,
    adc0_d10_11_n,
    adc0_d10_11_p,
    adc0_d12_13_n,
    adc0_d12_13_p,
    adc0_d14_15_n,
    adc0_d14_15_p,
    adc0_d2_3_n,
    adc0_d2_3_p,
    adc0_d4_5_n,
    adc0_d4_5_p,
    adc0_d6_7_n,
    adc0_d6_7_p,
    adc0_d8_9_n,
    adc0_d8_9_p,
    adc0_fifo_full_stat,
    adc0_ovld_led_n,
    adc0_pdwnf,
    adc1_d0_1_n,
    adc1_d0_1_p,
    adc1_d10_11_n,
    adc1_d10_11_p,
    adc1_d12_13_n,
    adc1_d12_13_p,
    adc1_d14_15_n,
    adc1_d14_15_p,
    adc1_d2_3_n,
    adc1_d2_3_p,
    adc1_d4_5_n,
    adc1_d4_5_p,
    adc1_d6_7_n,
    adc1_d6_7_p,
    adc1_d8_9_n,
    adc1_d8_9_p,
    adc1_fifo_full_stat,
    adc1_ovld_led_n,
    adc1_pdwnf,
    adc2_d0_1_n,
    adc2_d0_1_p,
    adc2_d10_11_n,
    adc2_d10_11_p,
    adc2_d12_13_n,
    adc2_d12_13_p,
    adc2_d14_15_n,
    adc2_d14_15_p,
    adc2_d2_3_n,
    adc2_d2_3_p,
    adc2_d4_5_n,
    adc2_d4_5_p,
    adc2_d6_7_n,
    adc2_d6_7_p,
    adc2_d8_9_n,
    adc2_d8_9_p,
    adc2_fifo_full_stat,
    adc2_ovld_led_n,
    adc2_pdwnf,
    adc_dither,
    cdc_cntl_cdc_clk,
    cdc_cntl_cdc_dat,
    cdc_cntl_cdc_le,
    cdc_cntl_cdc_rst_n,
    cdc_cntl_cdc_stat_lock,
    cdc_cntl_cdc_stat_ref,
    cdc_cntl_cdc_stat_vcxo,
    cdc_sync_rst_in_n,
    cdc_sync_rst_in_p,
    cdc_sync_rst_out,
    clk_det_led_n,
    clk_mux_sel,
    clka_glbl_clk_n,
    clka_glbl_clk_p,
    clka_master_n,
    clkb_glbl_clk_n,
    clkb_glbl_clk_p,
    clkb_master_n,
    dac_da,
    dac_db,
    dac_lock,
    dac_realtime_lost_stat,
    dac_realtimelost_led_n,
    dac_reset_n,
    dac_sclk,
    dac_sdenb,
    dac_sdi,
    dac_sdo,
    dac_sync,
    dac_tx_en,
    dataio_irq,
    gate_trig_ttl_in,
    gatea_in_n,
    gatea_in_p,
    gatea_out_n,
    gatea_out_p,
    gateb_in_n,
    gateb_in_p,
    gateb_out_n,
    gateb_out_p,
    m_axis_adc_ch0_pdti_tdata,
    m_axis_adc_ch0_pdti_tuser,
    m_axis_adc_ch0_pdti_tvalid,
    m_axis_adc_ch1_pdti_tdata,
    m_axis_adc_ch1_pdti_tuser,
    m_axis_adc_ch1_pdti_tvalid,
    m_axis_adc_ch2_pdti_tdata,
    m_axis_adc_ch2_pdti_tuser,
    m_axis_adc_ch2_pdti_tvalid,
    m_axis_adc_pdti_aclk,
    m_axis_adc_pdti_aresetn,
    m_axis_dac_pctl_tdata,
    m_axis_dac_pctl_tvalid,
    master_led_n,
    pps_det_led_n,
    refclk,
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
    s_axis_dac_pdti_aclk,
    s_axis_dac_pdti_aresetn,
    s_axis_dac_pdti_tdata,
    s_axis_dac_pdti_tuser,
    s_axis_dac_pdti_tvalid,
    sbusa_master_n,
    sbusb_master_n,
    sync_pps_ttl_in,
    synca_pps_in_n,
    synca_pps_in_p,
    synca_pps_out_n,
    synca_pps_out_p,
    syncb_pps_in_n,
    syncb_pps_in_p,
    syncb_pps_out_n,
    syncb_pps_out_p,
    timestamp_irq,
    vcxo_en,
    vcxo_sel_n);
  input adc0_d0_1_n;
  input adc0_d0_1_p;
  input adc0_d10_11_n;
  input adc0_d10_11_p;
  input adc0_d12_13_n;
  input adc0_d12_13_p;
  input adc0_d14_15_n;
  input adc0_d14_15_p;
  input adc0_d2_3_n;
  input adc0_d2_3_p;
  input adc0_d4_5_n;
  input adc0_d4_5_p;
  input adc0_d6_7_n;
  input adc0_d6_7_p;
  input adc0_d8_9_n;
  input adc0_d8_9_p;
  input adc0_fifo_full_stat;
  output adc0_ovld_led_n;
  output adc0_pdwnf;
  input adc1_d0_1_n;
  input adc1_d0_1_p;
  input adc1_d10_11_n;
  input adc1_d10_11_p;
  input adc1_d12_13_n;
  input adc1_d12_13_p;
  input adc1_d14_15_n;
  input adc1_d14_15_p;
  input adc1_d2_3_n;
  input adc1_d2_3_p;
  input adc1_d4_5_n;
  input adc1_d4_5_p;
  input adc1_d6_7_n;
  input adc1_d6_7_p;
  input adc1_d8_9_n;
  input adc1_d8_9_p;
  input adc1_fifo_full_stat;
  output adc1_ovld_led_n;
  output adc1_pdwnf;
  input adc2_d0_1_n;
  input adc2_d0_1_p;
  input adc2_d10_11_n;
  input adc2_d10_11_p;
  input adc2_d12_13_n;
  input adc2_d12_13_p;
  input adc2_d14_15_n;
  input adc2_d14_15_p;
  input adc2_d2_3_n;
  input adc2_d2_3_p;
  input adc2_d4_5_n;
  input adc2_d4_5_p;
  input adc2_d6_7_n;
  input adc2_d6_7_p;
  input adc2_d8_9_n;
  input adc2_d8_9_p;
  input adc2_fifo_full_stat;
  output adc2_ovld_led_n;
  output adc2_pdwnf;
  output adc_dither;
  output cdc_cntl_cdc_clk;
  output cdc_cntl_cdc_dat;
  output cdc_cntl_cdc_le;
  output cdc_cntl_cdc_rst_n;
  input cdc_cntl_cdc_stat_lock;
  input cdc_cntl_cdc_stat_ref;
  input cdc_cntl_cdc_stat_vcxo;
  input cdc_sync_rst_in_n;
  input cdc_sync_rst_in_p;
  output cdc_sync_rst_out;
  output clk_det_led_n;
  output [1:0]clk_mux_sel;
  input clka_glbl_clk_n;
  input clka_glbl_clk_p;
  output clka_master_n;
  input clkb_glbl_clk_n;
  input clkb_glbl_clk_p;
  output clkb_master_n;
  output [15:0]dac_da;
  output [15:0]dac_db;
  input dac_lock;
  input dac_realtime_lost_stat;
  output [0:0]dac_realtimelost_led_n;
  output dac_reset_n;
  output dac_sclk;
  output dac_sdenb;
  output dac_sdi;
  input dac_sdo;
  output dac_sync;
  output dac_tx_en;
  output [0:0]dataio_irq;
  input gate_trig_ttl_in;
  input gatea_in_n;
  input gatea_in_p;
  output gatea_out_n;
  output gatea_out_p;
  input gateb_in_n;
  input gateb_in_p;
  output gateb_out_n;
  output gateb_out_p;
  output [15:0]m_axis_adc_ch0_pdti_tdata;
  output [127:0]m_axis_adc_ch0_pdti_tuser;
  output m_axis_adc_ch0_pdti_tvalid;
  output [15:0]m_axis_adc_ch1_pdti_tdata;
  output [127:0]m_axis_adc_ch1_pdti_tuser;
  output m_axis_adc_ch1_pdti_tvalid;
  output [15:0]m_axis_adc_ch2_pdti_tdata;
  output [127:0]m_axis_adc_ch2_pdti_tuser;
  output m_axis_adc_ch2_pdti_tvalid;
  output m_axis_adc_pdti_aclk;
  output m_axis_adc_pdti_aresetn;
  output [7:0]m_axis_dac_pctl_tdata;
  output [0:0]m_axis_dac_pctl_tvalid;
  output master_led_n;
  output pps_det_led_n;
  input refclk;
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
  output s_axis_dac_pdti_aclk;
  output s_axis_dac_pdti_aresetn;
  input [31:0]s_axis_dac_pdti_tdata;
  input [127:0]s_axis_dac_pdti_tuser;
  input s_axis_dac_pdti_tvalid;
  output sbusa_master_n;
  output sbusb_master_n;
  input sync_pps_ttl_in;
  input synca_pps_in_n;
  input synca_pps_in_p;
  output synca_pps_out_n;
  output synca_pps_out_p;
  input syncb_pps_in_n;
  input syncb_pps_in_p;
  output syncb_pps_out_n;
  output syncb_pps_out_p;
  output timestamp_irq;
  output vcxo_en;
  output vcxo_sel_n;

  wire adc0_d0_1_n;
  wire adc0_d0_1_p;
  wire adc0_d10_11_n;
  wire adc0_d10_11_p;
  wire adc0_d12_13_n;
  wire adc0_d12_13_p;
  wire adc0_d14_15_n;
  wire adc0_d14_15_p;
  wire adc0_d2_3_n;
  wire adc0_d2_3_p;
  wire adc0_d4_5_n;
  wire adc0_d4_5_p;
  wire adc0_d6_7_n;
  wire adc0_d6_7_p;
  wire adc0_d8_9_n;
  wire adc0_d8_9_p;
  wire adc0_fifo_full_stat;
  wire adc0_ovld_led_n;
  wire adc0_pdwnf;
  wire adc1_d0_1_n;
  wire adc1_d0_1_p;
  wire adc1_d10_11_n;
  wire adc1_d10_11_p;
  wire adc1_d12_13_n;
  wire adc1_d12_13_p;
  wire adc1_d14_15_n;
  wire adc1_d14_15_p;
  wire adc1_d2_3_n;
  wire adc1_d2_3_p;
  wire adc1_d4_5_n;
  wire adc1_d4_5_p;
  wire adc1_d6_7_n;
  wire adc1_d6_7_p;
  wire adc1_d8_9_n;
  wire adc1_d8_9_p;
  wire adc1_fifo_full_stat;
  wire adc1_ovld_led_n;
  wire adc1_pdwnf;
  wire adc2_d0_1_n;
  wire adc2_d0_1_p;
  wire adc2_d10_11_n;
  wire adc2_d10_11_p;
  wire adc2_d12_13_n;
  wire adc2_d12_13_p;
  wire adc2_d14_15_n;
  wire adc2_d14_15_p;
  wire adc2_d2_3_n;
  wire adc2_d2_3_p;
  wire adc2_d4_5_n;
  wire adc2_d4_5_p;
  wire adc2_d6_7_n;
  wire adc2_d6_7_p;
  wire adc2_d8_9_n;
  wire adc2_d8_9_p;
  wire adc2_fifo_full_stat;
  wire adc2_ovld_led_n;
  wire adc2_pdwnf;
  wire adc_dither;
  wire cdc_cntl_cdc_clk;
  wire cdc_cntl_cdc_dat;
  wire cdc_cntl_cdc_le;
  wire cdc_cntl_cdc_rst_n;
  wire cdc_cntl_cdc_stat_lock;
  wire cdc_cntl_cdc_stat_ref;
  wire cdc_cntl_cdc_stat_vcxo;
  wire cdc_sync_rst_in_n;
  wire cdc_sync_rst_in_p;
  wire cdc_sync_rst_out;
  wire clk_det_led_n;
  wire [1:0]clk_mux_sel;
  wire clka_glbl_clk_n;
  wire clka_glbl_clk_p;
  wire clka_master_n;
  wire clkb_glbl_clk_n;
  wire clkb_glbl_clk_p;
  wire clkb_master_n;
  wire [15:0]dac_da;
  wire [15:0]dac_db;
  wire dac_lock;
  wire dac_realtime_lost_stat;
  wire [0:0]dac_realtimelost_led_n;
  wire dac_reset_n;
  wire dac_sclk;
  wire dac_sdenb;
  wire dac_sdi;
  wire dac_sdo;
  wire dac_sync;
  wire dac_tx_en;
  wire [0:0]dataio_irq;
  wire gate_trig_ttl_in;
  wire gatea_in_n;
  wire gatea_in_p;
  wire gatea_out_n;
  wire gatea_out_p;
  wire gateb_in_n;
  wire gateb_in_p;
  wire gateb_out_n;
  wire gateb_out_p;
  wire [15:0]m_axis_adc_ch0_pdti_tdata;
  wire [127:0]m_axis_adc_ch0_pdti_tuser;
  wire m_axis_adc_ch0_pdti_tvalid;
  wire [15:0]m_axis_adc_ch1_pdti_tdata;
  wire [127:0]m_axis_adc_ch1_pdti_tuser;
  wire m_axis_adc_ch1_pdti_tvalid;
  wire [15:0]m_axis_adc_ch2_pdti_tdata;
  wire [127:0]m_axis_adc_ch2_pdti_tuser;
  wire m_axis_adc_ch2_pdti_tvalid;
  wire m_axis_adc_pdti_aclk;
  wire m_axis_adc_pdti_aresetn;
  wire [7:0]m_axis_dac_pctl_tdata;
  wire [0:0]m_axis_dac_pctl_tvalid;
  wire master_led_n;
  wire pps_det_led_n;
  wire refclk;
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
  wire s_axis_dac_pdti_aclk;
  wire s_axis_dac_pdti_aresetn;
  wire [31:0]s_axis_dac_pdti_tdata;
  wire [127:0]s_axis_dac_pdti_tuser;
  wire s_axis_dac_pdti_tvalid;
  wire sbusa_master_n;
  wire sbusb_master_n;
  wire sync_pps_ttl_in;
  wire synca_pps_in_n;
  wire synca_pps_in_p;
  wire synca_pps_out_n;
  wire synca_pps_out_p;
  wire syncb_pps_in_n;
  wire syncb_pps_in_p;
  wire syncb_pps_out_n;
  wire syncb_pps_out_p;
  wire timestamp_irq;
  wire vcxo_en;
  wire vcxo_sel_n;

  dataio_intrfc dataio_intrfc_i
       (.adc0_d0_1_n(adc0_d0_1_n),
        .adc0_d0_1_p(adc0_d0_1_p),
        .adc0_d10_11_n(adc0_d10_11_n),
        .adc0_d10_11_p(adc0_d10_11_p),
        .adc0_d12_13_n(adc0_d12_13_n),
        .adc0_d12_13_p(adc0_d12_13_p),
        .adc0_d14_15_n(adc0_d14_15_n),
        .adc0_d14_15_p(adc0_d14_15_p),
        .adc0_d2_3_n(adc0_d2_3_n),
        .adc0_d2_3_p(adc0_d2_3_p),
        .adc0_d4_5_n(adc0_d4_5_n),
        .adc0_d4_5_p(adc0_d4_5_p),
        .adc0_d6_7_n(adc0_d6_7_n),
        .adc0_d6_7_p(adc0_d6_7_p),
        .adc0_d8_9_n(adc0_d8_9_n),
        .adc0_d8_9_p(adc0_d8_9_p),
        .adc0_fifo_full_stat(adc0_fifo_full_stat),
        .adc0_ovld_led_n(adc0_ovld_led_n),
        .adc0_pdwnf(adc0_pdwnf),
        .adc1_d0_1_n(adc1_d0_1_n),
        .adc1_d0_1_p(adc1_d0_1_p),
        .adc1_d10_11_n(adc1_d10_11_n),
        .adc1_d10_11_p(adc1_d10_11_p),
        .adc1_d12_13_n(adc1_d12_13_n),
        .adc1_d12_13_p(adc1_d12_13_p),
        .adc1_d14_15_n(adc1_d14_15_n),
        .adc1_d14_15_p(adc1_d14_15_p),
        .adc1_d2_3_n(adc1_d2_3_n),
        .adc1_d2_3_p(adc1_d2_3_p),
        .adc1_d4_5_n(adc1_d4_5_n),
        .adc1_d4_5_p(adc1_d4_5_p),
        .adc1_d6_7_n(adc1_d6_7_n),
        .adc1_d6_7_p(adc1_d6_7_p),
        .adc1_d8_9_n(adc1_d8_9_n),
        .adc1_d8_9_p(adc1_d8_9_p),
        .adc1_fifo_full_stat(adc1_fifo_full_stat),
        .adc1_ovld_led_n(adc1_ovld_led_n),
        .adc1_pdwnf(adc1_pdwnf),
        .adc2_d0_1_n(adc2_d0_1_n),
        .adc2_d0_1_p(adc2_d0_1_p),
        .adc2_d10_11_n(adc2_d10_11_n),
        .adc2_d10_11_p(adc2_d10_11_p),
        .adc2_d12_13_n(adc2_d12_13_n),
        .adc2_d12_13_p(adc2_d12_13_p),
        .adc2_d14_15_n(adc2_d14_15_n),
        .adc2_d14_15_p(adc2_d14_15_p),
        .adc2_d2_3_n(adc2_d2_3_n),
        .adc2_d2_3_p(adc2_d2_3_p),
        .adc2_d4_5_n(adc2_d4_5_n),
        .adc2_d4_5_p(adc2_d4_5_p),
        .adc2_d6_7_n(adc2_d6_7_n),
        .adc2_d6_7_p(adc2_d6_7_p),
        .adc2_d8_9_n(adc2_d8_9_n),
        .adc2_d8_9_p(adc2_d8_9_p),
        .adc2_fifo_full_stat(adc2_fifo_full_stat),
        .adc2_ovld_led_n(adc2_ovld_led_n),
        .adc2_pdwnf(adc2_pdwnf),
        .adc_dither(adc_dither),
        .cdc_cntl_cdc_clk(cdc_cntl_cdc_clk),
        .cdc_cntl_cdc_dat(cdc_cntl_cdc_dat),
        .cdc_cntl_cdc_le(cdc_cntl_cdc_le),
        .cdc_cntl_cdc_rst_n(cdc_cntl_cdc_rst_n),
        .cdc_cntl_cdc_stat_lock(cdc_cntl_cdc_stat_lock),
        .cdc_cntl_cdc_stat_ref(cdc_cntl_cdc_stat_ref),
        .cdc_cntl_cdc_stat_vcxo(cdc_cntl_cdc_stat_vcxo),
        .cdc_sync_rst_in_n(cdc_sync_rst_in_n),
        .cdc_sync_rst_in_p(cdc_sync_rst_in_p),
        .cdc_sync_rst_out(cdc_sync_rst_out),
        .clk_det_led_n(clk_det_led_n),
        .clk_mux_sel(clk_mux_sel),
        .clka_glbl_clk_n(clka_glbl_clk_n),
        .clka_glbl_clk_p(clka_glbl_clk_p),
        .clka_master_n(clka_master_n),
        .clkb_glbl_clk_n(clkb_glbl_clk_n),
        .clkb_glbl_clk_p(clkb_glbl_clk_p),
        .clkb_master_n(clkb_master_n),
        .dac_da(dac_da),
        .dac_db(dac_db),
        .dac_lock(dac_lock),
        .dac_realtime_lost_stat(dac_realtime_lost_stat),
        .dac_realtimelost_led_n(dac_realtimelost_led_n),
        .dac_reset_n(dac_reset_n),
        .dac_sclk(dac_sclk),
        .dac_sdenb(dac_sdenb),
        .dac_sdi(dac_sdi),
        .dac_sdo(dac_sdo),
        .dac_sync(dac_sync),
        .dac_tx_en(dac_tx_en),
        .dataio_irq(dataio_irq),
        .gate_trig_ttl_in(gate_trig_ttl_in),
        .gatea_in_n(gatea_in_n),
        .gatea_in_p(gatea_in_p),
        .gatea_out_n(gatea_out_n),
        .gatea_out_p(gatea_out_p),
        .gateb_in_n(gateb_in_n),
        .gateb_in_p(gateb_in_p),
        .gateb_out_n(gateb_out_n),
        .gateb_out_p(gateb_out_p),
        .m_axis_adc_ch0_pdti_tdata(m_axis_adc_ch0_pdti_tdata),
        .m_axis_adc_ch0_pdti_tuser(m_axis_adc_ch0_pdti_tuser),
        .m_axis_adc_ch0_pdti_tvalid(m_axis_adc_ch0_pdti_tvalid),
        .m_axis_adc_ch1_pdti_tdata(m_axis_adc_ch1_pdti_tdata),
        .m_axis_adc_ch1_pdti_tuser(m_axis_adc_ch1_pdti_tuser),
        .m_axis_adc_ch1_pdti_tvalid(m_axis_adc_ch1_pdti_tvalid),
        .m_axis_adc_ch2_pdti_tdata(m_axis_adc_ch2_pdti_tdata),
        .m_axis_adc_ch2_pdti_tuser(m_axis_adc_ch2_pdti_tuser),
        .m_axis_adc_ch2_pdti_tvalid(m_axis_adc_ch2_pdti_tvalid),
        .m_axis_adc_pdti_aclk(m_axis_adc_pdti_aclk),
        .m_axis_adc_pdti_aresetn(m_axis_adc_pdti_aresetn),
        .m_axis_dac_pctl_tdata(m_axis_dac_pctl_tdata),
        .m_axis_dac_pctl_tvalid(m_axis_dac_pctl_tvalid),
        .master_led_n(master_led_n),
        .pps_det_led_n(pps_det_led_n),
        .refclk(refclk),
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
        .s_axis_dac_pdti_aclk(s_axis_dac_pdti_aclk),
        .s_axis_dac_pdti_aresetn(s_axis_dac_pdti_aresetn),
        .s_axis_dac_pdti_tdata(s_axis_dac_pdti_tdata),
        .s_axis_dac_pdti_tuser(s_axis_dac_pdti_tuser),
        .s_axis_dac_pdti_tvalid(s_axis_dac_pdti_tvalid),
        .sbusa_master_n(sbusa_master_n),
        .sbusb_master_n(sbusb_master_n),
        .sync_pps_ttl_in(sync_pps_ttl_in),
        .synca_pps_in_n(synca_pps_in_n),
        .synca_pps_in_p(synca_pps_in_p),
        .synca_pps_out_n(synca_pps_out_n),
        .synca_pps_out_p(synca_pps_out_p),
        .syncb_pps_in_n(syncb_pps_in_n),
        .syncb_pps_in_p(syncb_pps_in_p),
        .syncb_pps_out_n(syncb_pps_out_n),
        .syncb_pps_out_p(syncb_pps_out_p),
        .timestamp_irq(timestamp_irq),
        .vcxo_en(vcxo_en),
        .vcxo_sel_n(vcxo_sel_n));
endmodule
