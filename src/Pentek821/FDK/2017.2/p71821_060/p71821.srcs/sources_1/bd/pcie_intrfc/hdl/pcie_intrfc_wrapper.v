//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
//Date        : Tue Aug 15 10:02:43 2017
//Host        : Rich-PC running 64-bit major release  (build 9200)
//Command     : generate_target pcie_intrfc_wrapper.bd
//Design      : pcie_intrfc_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module pcie_intrfc_wrapper
   (Vaux0_v_n,
    Vaux0_v_p,
    Vaux10_v_n,
    Vaux10_v_p,
    Vaux11_v_n,
    Vaux11_v_p,
    Vaux12_v_n,
    Vaux12_v_p,
    Vaux1_v_n,
    Vaux1_v_p,
    Vaux2_v_n,
    Vaux2_v_p,
    Vaux3_v_n,
    Vaux3_v_p,
    Vaux4_v_n,
    Vaux4_v_p,
    Vaux8_v_n,
    Vaux8_v_p,
    Vaux9_v_n,
    Vaux9_v_p,
    Vp_Vn_v_n,
    Vp_Vn_v_p,
    dataio_irq,
    dataiopkt_irq,
    dma_irq,
    dsp_irq,
    flash_a,
    flash_adv_b,
    flash_d_i,
    flash_d_o,
    flash_d_t,
    flash_fcs_b,
    flash_foe_b,
    flash_fwe_b,
    fpga_size,
    fpio_type,
    iic_port0_scl_io,
    iic_port0_sda_io,
    iic_port1_scl_io,
    iic_port1_sda_io,
    m_axi_acq_csr_araddr,
    m_axi_acq_csr_arprot,
    m_axi_acq_csr_arready,
    m_axi_acq_csr_arvalid,
    m_axi_acq_csr_awaddr,
    m_axi_acq_csr_awprot,
    m_axi_acq_csr_awready,
    m_axi_acq_csr_awvalid,
    m_axi_acq_csr_bready,
    m_axi_acq_csr_bresp,
    m_axi_acq_csr_bvalid,
    m_axi_acq_csr_rdata,
    m_axi_acq_csr_rready,
    m_axi_acq_csr_rresp,
    m_axi_acq_csr_rvalid,
    m_axi_acq_csr_wdata,
    m_axi_acq_csr_wready,
    m_axi_acq_csr_wstrb,
    m_axi_acq_csr_wvalid,
    m_axi_csr_aclk,
    m_axi_csr_aresetn,
    m_axi_dataio_csr_araddr,
    m_axi_dataio_csr_arprot,
    m_axi_dataio_csr_arready,
    m_axi_dataio_csr_arvalid,
    m_axi_dataio_csr_awaddr,
    m_axi_dataio_csr_awprot,
    m_axi_dataio_csr_awready,
    m_axi_dataio_csr_awvalid,
    m_axi_dataio_csr_bready,
    m_axi_dataio_csr_bresp,
    m_axi_dataio_csr_bvalid,
    m_axi_dataio_csr_rdata,
    m_axi_dataio_csr_rready,
    m_axi_dataio_csr_rresp,
    m_axi_dataio_csr_rvalid,
    m_axi_dataio_csr_wdata,
    m_axi_dataio_csr_wready,
    m_axi_dataio_csr_wstrb,
    m_axi_dataio_csr_wvalid,
    m_axi_ddr4_csr_araddr,
    m_axi_ddr4_csr_arprot,
    m_axi_ddr4_csr_arready,
    m_axi_ddr4_csr_arvalid,
    m_axi_ddr4_csr_awaddr,
    m_axi_ddr4_csr_awprot,
    m_axi_ddr4_csr_awready,
    m_axi_ddr4_csr_awvalid,
    m_axi_ddr4_csr_bready,
    m_axi_ddr4_csr_bresp,
    m_axi_ddr4_csr_bvalid,
    m_axi_ddr4_csr_rdata,
    m_axi_ddr4_csr_rready,
    m_axi_ddr4_csr_rresp,
    m_axi_ddr4_csr_rvalid,
    m_axi_ddr4_csr_wdata,
    m_axi_ddr4_csr_wready,
    m_axi_ddr4_csr_wstrb,
    m_axi_ddr4_csr_wvalid,
    m_axi_dsp_csr_araddr,
    m_axi_dsp_csr_arprot,
    m_axi_dsp_csr_arready,
    m_axi_dsp_csr_arvalid,
    m_axi_dsp_csr_awaddr,
    m_axi_dsp_csr_awprot,
    m_axi_dsp_csr_awready,
    m_axi_dsp_csr_awvalid,
    m_axi_dsp_csr_bready,
    m_axi_dsp_csr_bresp,
    m_axi_dsp_csr_bvalid,
    m_axi_dsp_csr_rdata,
    m_axi_dsp_csr_rready,
    m_axi_dsp_csr_rresp,
    m_axi_dsp_csr_rvalid,
    m_axi_dsp_csr_wdata,
    m_axi_dsp_csr_wready,
    m_axi_dsp_csr_wstrb,
    m_axi_dsp_csr_wvalid,
    m_axi_user1_csr_araddr,
    m_axi_user1_csr_arprot,
    m_axi_user1_csr_arready,
    m_axi_user1_csr_arvalid,
    m_axi_user1_csr_awaddr,
    m_axi_user1_csr_awprot,
    m_axi_user1_csr_awready,
    m_axi_user1_csr_awvalid,
    m_axi_user1_csr_bready,
    m_axi_user1_csr_bresp,
    m_axi_user1_csr_bvalid,
    m_axi_user1_csr_rdata,
    m_axi_user1_csr_rready,
    m_axi_user1_csr_rresp,
    m_axi_user1_csr_rvalid,
    m_axi_user1_csr_wdata,
    m_axi_user1_csr_wready,
    m_axi_user1_csr_wstrb,
    m_axi_user1_csr_wvalid,
    m_axi_user2_csr_araddr,
    m_axi_user2_csr_arprot,
    m_axi_user2_csr_arready,
    m_axi_user2_csr_arvalid,
    m_axi_user2_csr_awaddr,
    m_axi_user2_csr_awprot,
    m_axi_user2_csr_awready,
    m_axi_user2_csr_awvalid,
    m_axi_user2_csr_bready,
    m_axi_user2_csr_bresp,
    m_axi_user2_csr_bvalid,
    m_axi_user2_csr_rdata,
    m_axi_user2_csr_rready,
    m_axi_user2_csr_rresp,
    m_axi_user2_csr_rvalid,
    m_axi_user2_csr_wdata,
    m_axi_user2_csr_wready,
    m_axi_user2_csr_wstrb,
    m_axi_user2_csr_wvalid,
    m_axis_ddr_rqst_tdata,
    m_axis_ddr_rqst_tid,
    m_axis_ddr_rqst_tlast,
    m_axis_ddr_rqst_tready,
    m_axis_ddr_rqst_tuser,
    m_axis_ddr_rqst_tvalid,
    m_axis_dma_pcie_cntl_tdata,
    m_axis_dma_pcie_cntl_tvalid,
    m_axis_pcie_rc_tdata,
    m_axis_pcie_rc_tkeep,
    m_axis_pcie_rc_tlast,
    m_axis_pcie_rc_tready,
    m_axis_pcie_rc_tuser,
    m_axis_pcie_rc_tvalid,
    mga,
    pcie_lane_led0_n,
    pcie_lane_led1_n,
    pcie_link_up,
    pcie_link_up_led_n,
    pcie_mgt_rxn,
    pcie_mgt_rxp,
    pcie_mgt_txn,
    pcie_mgt_txp,
    pcie_perstn_in,
    rev,
    rev_date,
    rq_shutdown_ok,
    s_axis_ddr_rsp_tdata,
    s_axis_ddr_rsp_tid,
    s_axis_ddr_rsp_tlast,
    s_axis_ddr_rsp_tuser,
    s_axis_ddr_rsp_tvalid,
    s_axis_pcie_rq_tdata,
    s_axis_pcie_rq_tkeep,
    s_axis_pcie_rq_tlast,
    s_axis_pcie_rq_tready,
    s_axis_pcie_rq_tuser,
    s_axis_pcie_rq_tvalid,
    shutdown_rqst,
    startup_eos_in,
    sys_clk,
    sys_clk_gt,
    sys_mon_alarm,
    sys_mon_led_n,
    temp_irq_n,
    time_irq,
    user1_irq,
    user2_irq,
    user_led_n);
  input Vaux0_v_n;
  input Vaux0_v_p;
  input Vaux10_v_n;
  input Vaux10_v_p;
  input Vaux11_v_n;
  input Vaux11_v_p;
  input Vaux12_v_n;
  input Vaux12_v_p;
  input Vaux1_v_n;
  input Vaux1_v_p;
  input Vaux2_v_n;
  input Vaux2_v_p;
  input Vaux3_v_n;
  input Vaux3_v_p;
  input Vaux4_v_n;
  input Vaux4_v_p;
  input Vaux8_v_n;
  input Vaux8_v_p;
  input Vaux9_v_n;
  input Vaux9_v_p;
  input Vp_Vn_v_n;
  input Vp_Vn_v_p;
  input [0:0]dataio_irq;
  input [0:0]dataiopkt_irq;
  input [15:0]dma_irq;
  input [7:0]dsp_irq;
  output [25:0]flash_a;
  output flash_adv_b;
  input [15:0]flash_d_i;
  output [15:0]flash_d_o;
  output [15:0]flash_d_t;
  output flash_fcs_b;
  output flash_foe_b;
  output flash_fwe_b;
  input [11:0]fpga_size;
  input [3:0]fpio_type;
  inout iic_port0_scl_io;
  inout iic_port0_sda_io;
  inout iic_port1_scl_io;
  inout iic_port1_sda_io;
  output [25:0]m_axi_acq_csr_araddr;
  output [2:0]m_axi_acq_csr_arprot;
  input [0:0]m_axi_acq_csr_arready;
  output [0:0]m_axi_acq_csr_arvalid;
  output [25:0]m_axi_acq_csr_awaddr;
  output [2:0]m_axi_acq_csr_awprot;
  input [0:0]m_axi_acq_csr_awready;
  output [0:0]m_axi_acq_csr_awvalid;
  output [0:0]m_axi_acq_csr_bready;
  input [1:0]m_axi_acq_csr_bresp;
  input [0:0]m_axi_acq_csr_bvalid;
  input [31:0]m_axi_acq_csr_rdata;
  output [0:0]m_axi_acq_csr_rready;
  input [1:0]m_axi_acq_csr_rresp;
  input [0:0]m_axi_acq_csr_rvalid;
  output [31:0]m_axi_acq_csr_wdata;
  input [0:0]m_axi_acq_csr_wready;
  output [3:0]m_axi_acq_csr_wstrb;
  output [0:0]m_axi_acq_csr_wvalid;
  output m_axi_csr_aclk;
  output m_axi_csr_aresetn;
  output [25:0]m_axi_dataio_csr_araddr;
  output [2:0]m_axi_dataio_csr_arprot;
  input [0:0]m_axi_dataio_csr_arready;
  output [0:0]m_axi_dataio_csr_arvalid;
  output [25:0]m_axi_dataio_csr_awaddr;
  output [2:0]m_axi_dataio_csr_awprot;
  input [0:0]m_axi_dataio_csr_awready;
  output [0:0]m_axi_dataio_csr_awvalid;
  output [0:0]m_axi_dataio_csr_bready;
  input [1:0]m_axi_dataio_csr_bresp;
  input [0:0]m_axi_dataio_csr_bvalid;
  input [31:0]m_axi_dataio_csr_rdata;
  output [0:0]m_axi_dataio_csr_rready;
  input [1:0]m_axi_dataio_csr_rresp;
  input [0:0]m_axi_dataio_csr_rvalid;
  output [31:0]m_axi_dataio_csr_wdata;
  input [0:0]m_axi_dataio_csr_wready;
  output [3:0]m_axi_dataio_csr_wstrb;
  output [0:0]m_axi_dataio_csr_wvalid;
  output [25:0]m_axi_ddr4_csr_araddr;
  output [2:0]m_axi_ddr4_csr_arprot;
  input [0:0]m_axi_ddr4_csr_arready;
  output [0:0]m_axi_ddr4_csr_arvalid;
  output [25:0]m_axi_ddr4_csr_awaddr;
  output [2:0]m_axi_ddr4_csr_awprot;
  input [0:0]m_axi_ddr4_csr_awready;
  output [0:0]m_axi_ddr4_csr_awvalid;
  output [0:0]m_axi_ddr4_csr_bready;
  input [1:0]m_axi_ddr4_csr_bresp;
  input [0:0]m_axi_ddr4_csr_bvalid;
  input [31:0]m_axi_ddr4_csr_rdata;
  output [0:0]m_axi_ddr4_csr_rready;
  input [1:0]m_axi_ddr4_csr_rresp;
  input [0:0]m_axi_ddr4_csr_rvalid;
  output [31:0]m_axi_ddr4_csr_wdata;
  input [0:0]m_axi_ddr4_csr_wready;
  output [3:0]m_axi_ddr4_csr_wstrb;
  output [0:0]m_axi_ddr4_csr_wvalid;
  output [25:0]m_axi_dsp_csr_araddr;
  output [2:0]m_axi_dsp_csr_arprot;
  input [0:0]m_axi_dsp_csr_arready;
  output [0:0]m_axi_dsp_csr_arvalid;
  output [25:0]m_axi_dsp_csr_awaddr;
  output [2:0]m_axi_dsp_csr_awprot;
  input [0:0]m_axi_dsp_csr_awready;
  output [0:0]m_axi_dsp_csr_awvalid;
  output [0:0]m_axi_dsp_csr_bready;
  input [1:0]m_axi_dsp_csr_bresp;
  input [0:0]m_axi_dsp_csr_bvalid;
  input [31:0]m_axi_dsp_csr_rdata;
  output [0:0]m_axi_dsp_csr_rready;
  input [1:0]m_axi_dsp_csr_rresp;
  input [0:0]m_axi_dsp_csr_rvalid;
  output [31:0]m_axi_dsp_csr_wdata;
  input [0:0]m_axi_dsp_csr_wready;
  output [3:0]m_axi_dsp_csr_wstrb;
  output [0:0]m_axi_dsp_csr_wvalid;
  output [25:0]m_axi_user1_csr_araddr;
  output [2:0]m_axi_user1_csr_arprot;
  input [0:0]m_axi_user1_csr_arready;
  output [0:0]m_axi_user1_csr_arvalid;
  output [25:0]m_axi_user1_csr_awaddr;
  output [2:0]m_axi_user1_csr_awprot;
  input [0:0]m_axi_user1_csr_awready;
  output [0:0]m_axi_user1_csr_awvalid;
  output [0:0]m_axi_user1_csr_bready;
  input [1:0]m_axi_user1_csr_bresp;
  input [0:0]m_axi_user1_csr_bvalid;
  input [31:0]m_axi_user1_csr_rdata;
  output [0:0]m_axi_user1_csr_rready;
  input [1:0]m_axi_user1_csr_rresp;
  input [0:0]m_axi_user1_csr_rvalid;
  output [31:0]m_axi_user1_csr_wdata;
  input [0:0]m_axi_user1_csr_wready;
  output [3:0]m_axi_user1_csr_wstrb;
  output [0:0]m_axi_user1_csr_wvalid;
  output [25:0]m_axi_user2_csr_araddr;
  output [2:0]m_axi_user2_csr_arprot;
  input [0:0]m_axi_user2_csr_arready;
  output [0:0]m_axi_user2_csr_arvalid;
  output [25:0]m_axi_user2_csr_awaddr;
  output [2:0]m_axi_user2_csr_awprot;
  input [0:0]m_axi_user2_csr_awready;
  output [0:0]m_axi_user2_csr_awvalid;
  output [0:0]m_axi_user2_csr_bready;
  input [1:0]m_axi_user2_csr_bresp;
  input [0:0]m_axi_user2_csr_bvalid;
  input [31:0]m_axi_user2_csr_rdata;
  output [0:0]m_axi_user2_csr_rready;
  input [1:0]m_axi_user2_csr_rresp;
  input [0:0]m_axi_user2_csr_rvalid;
  output [31:0]m_axi_user2_csr_wdata;
  input [0:0]m_axi_user2_csr_wready;
  output [3:0]m_axi_user2_csr_wstrb;
  output [0:0]m_axi_user2_csr_wvalid;
  output [511:0]m_axis_ddr_rqst_tdata;
  output [7:0]m_axis_ddr_rqst_tid;
  output m_axis_ddr_rqst_tlast;
  input m_axis_ddr_rqst_tready;
  output [255:0]m_axis_ddr_rqst_tuser;
  output m_axis_ddr_rqst_tvalid;
  output [7:0]m_axis_dma_pcie_cntl_tdata;
  output m_axis_dma_pcie_cntl_tvalid;
  output [255:0]m_axis_pcie_rc_tdata;
  output [31:0]m_axis_pcie_rc_tkeep;
  output m_axis_pcie_rc_tlast;
  input m_axis_pcie_rc_tready;
  output [74:0]m_axis_pcie_rc_tuser;
  output m_axis_pcie_rc_tvalid;
  input [2:0]mga;
  output pcie_lane_led0_n;
  output pcie_lane_led1_n;
  output pcie_link_up;
  output pcie_link_up_led_n;
  input [7:0]pcie_mgt_rxn;
  input [7:0]pcie_mgt_rxp;
  output [7:0]pcie_mgt_txn;
  output [7:0]pcie_mgt_txp;
  input pcie_perstn_in;
  input [7:0]rev;
  input [23:0]rev_date;
  input rq_shutdown_ok;
  input [511:0]s_axis_ddr_rsp_tdata;
  input [7:0]s_axis_ddr_rsp_tid;
  input s_axis_ddr_rsp_tlast;
  input [255:0]s_axis_ddr_rsp_tuser;
  input s_axis_ddr_rsp_tvalid;
  input [255:0]s_axis_pcie_rq_tdata;
  input [31:0]s_axis_pcie_rq_tkeep;
  input s_axis_pcie_rq_tlast;
  output s_axis_pcie_rq_tready;
  input [59:0]s_axis_pcie_rq_tuser;
  input s_axis_pcie_rq_tvalid;
  output shutdown_rqst;
  input startup_eos_in;
  input sys_clk;
  input sys_clk_gt;
  output sys_mon_alarm;
  output sys_mon_led_n;
  input temp_irq_n;
  input time_irq;
  input [1:0]user1_irq;
  input [1:0]user2_irq;
  output user_led_n;

  wire Vaux0_v_n;
  wire Vaux0_v_p;
  wire Vaux10_v_n;
  wire Vaux10_v_p;
  wire Vaux11_v_n;
  wire Vaux11_v_p;
  wire Vaux12_v_n;
  wire Vaux12_v_p;
  wire Vaux1_v_n;
  wire Vaux1_v_p;
  wire Vaux2_v_n;
  wire Vaux2_v_p;
  wire Vaux3_v_n;
  wire Vaux3_v_p;
  wire Vaux4_v_n;
  wire Vaux4_v_p;
  wire Vaux8_v_n;
  wire Vaux8_v_p;
  wire Vaux9_v_n;
  wire Vaux9_v_p;
  wire Vp_Vn_v_n;
  wire Vp_Vn_v_p;
  wire [0:0]dataio_irq;
  wire [0:0]dataiopkt_irq;
  wire [15:0]dma_irq;
  wire [7:0]dsp_irq;
  wire [25:0]flash_a;
  wire flash_adv_b;
  wire [15:0]flash_d_i;
  wire [15:0]flash_d_o;
  wire [15:0]flash_d_t;
  wire flash_fcs_b;
  wire flash_foe_b;
  wire flash_fwe_b;
  wire [11:0]fpga_size;
  wire [3:0]fpio_type;
  wire iic_port0_scl_i;
  wire iic_port0_scl_io;
  wire iic_port0_scl_o;
  wire iic_port0_scl_t;
  wire iic_port0_sda_i;
  wire iic_port0_sda_io;
  wire iic_port0_sda_o;
  wire iic_port0_sda_t;
  wire iic_port1_scl_i;
  wire iic_port1_scl_io;
  wire iic_port1_scl_o;
  wire iic_port1_scl_t;
  wire iic_port1_sda_i;
  wire iic_port1_sda_io;
  wire iic_port1_sda_o;
  wire iic_port1_sda_t;
  wire [25:0]m_axi_acq_csr_araddr;
  wire [2:0]m_axi_acq_csr_arprot;
  wire [0:0]m_axi_acq_csr_arready;
  wire [0:0]m_axi_acq_csr_arvalid;
  wire [25:0]m_axi_acq_csr_awaddr;
  wire [2:0]m_axi_acq_csr_awprot;
  wire [0:0]m_axi_acq_csr_awready;
  wire [0:0]m_axi_acq_csr_awvalid;
  wire [0:0]m_axi_acq_csr_bready;
  wire [1:0]m_axi_acq_csr_bresp;
  wire [0:0]m_axi_acq_csr_bvalid;
  wire [31:0]m_axi_acq_csr_rdata;
  wire [0:0]m_axi_acq_csr_rready;
  wire [1:0]m_axi_acq_csr_rresp;
  wire [0:0]m_axi_acq_csr_rvalid;
  wire [31:0]m_axi_acq_csr_wdata;
  wire [0:0]m_axi_acq_csr_wready;
  wire [3:0]m_axi_acq_csr_wstrb;
  wire [0:0]m_axi_acq_csr_wvalid;
  wire m_axi_csr_aclk;
  wire m_axi_csr_aresetn;
  wire [25:0]m_axi_dataio_csr_araddr;
  wire [2:0]m_axi_dataio_csr_arprot;
  wire [0:0]m_axi_dataio_csr_arready;
  wire [0:0]m_axi_dataio_csr_arvalid;
  wire [25:0]m_axi_dataio_csr_awaddr;
  wire [2:0]m_axi_dataio_csr_awprot;
  wire [0:0]m_axi_dataio_csr_awready;
  wire [0:0]m_axi_dataio_csr_awvalid;
  wire [0:0]m_axi_dataio_csr_bready;
  wire [1:0]m_axi_dataio_csr_bresp;
  wire [0:0]m_axi_dataio_csr_bvalid;
  wire [31:0]m_axi_dataio_csr_rdata;
  wire [0:0]m_axi_dataio_csr_rready;
  wire [1:0]m_axi_dataio_csr_rresp;
  wire [0:0]m_axi_dataio_csr_rvalid;
  wire [31:0]m_axi_dataio_csr_wdata;
  wire [0:0]m_axi_dataio_csr_wready;
  wire [3:0]m_axi_dataio_csr_wstrb;
  wire [0:0]m_axi_dataio_csr_wvalid;
  wire [25:0]m_axi_ddr4_csr_araddr;
  wire [2:0]m_axi_ddr4_csr_arprot;
  wire [0:0]m_axi_ddr4_csr_arready;
  wire [0:0]m_axi_ddr4_csr_arvalid;
  wire [25:0]m_axi_ddr4_csr_awaddr;
  wire [2:0]m_axi_ddr4_csr_awprot;
  wire [0:0]m_axi_ddr4_csr_awready;
  wire [0:0]m_axi_ddr4_csr_awvalid;
  wire [0:0]m_axi_ddr4_csr_bready;
  wire [1:0]m_axi_ddr4_csr_bresp;
  wire [0:0]m_axi_ddr4_csr_bvalid;
  wire [31:0]m_axi_ddr4_csr_rdata;
  wire [0:0]m_axi_ddr4_csr_rready;
  wire [1:0]m_axi_ddr4_csr_rresp;
  wire [0:0]m_axi_ddr4_csr_rvalid;
  wire [31:0]m_axi_ddr4_csr_wdata;
  wire [0:0]m_axi_ddr4_csr_wready;
  wire [3:0]m_axi_ddr4_csr_wstrb;
  wire [0:0]m_axi_ddr4_csr_wvalid;
  wire [25:0]m_axi_dsp_csr_araddr;
  wire [2:0]m_axi_dsp_csr_arprot;
  wire [0:0]m_axi_dsp_csr_arready;
  wire [0:0]m_axi_dsp_csr_arvalid;
  wire [25:0]m_axi_dsp_csr_awaddr;
  wire [2:0]m_axi_dsp_csr_awprot;
  wire [0:0]m_axi_dsp_csr_awready;
  wire [0:0]m_axi_dsp_csr_awvalid;
  wire [0:0]m_axi_dsp_csr_bready;
  wire [1:0]m_axi_dsp_csr_bresp;
  wire [0:0]m_axi_dsp_csr_bvalid;
  wire [31:0]m_axi_dsp_csr_rdata;
  wire [0:0]m_axi_dsp_csr_rready;
  wire [1:0]m_axi_dsp_csr_rresp;
  wire [0:0]m_axi_dsp_csr_rvalid;
  wire [31:0]m_axi_dsp_csr_wdata;
  wire [0:0]m_axi_dsp_csr_wready;
  wire [3:0]m_axi_dsp_csr_wstrb;
  wire [0:0]m_axi_dsp_csr_wvalid;
  wire [25:0]m_axi_user1_csr_araddr;
  wire [2:0]m_axi_user1_csr_arprot;
  wire [0:0]m_axi_user1_csr_arready;
  wire [0:0]m_axi_user1_csr_arvalid;
  wire [25:0]m_axi_user1_csr_awaddr;
  wire [2:0]m_axi_user1_csr_awprot;
  wire [0:0]m_axi_user1_csr_awready;
  wire [0:0]m_axi_user1_csr_awvalid;
  wire [0:0]m_axi_user1_csr_bready;
  wire [1:0]m_axi_user1_csr_bresp;
  wire [0:0]m_axi_user1_csr_bvalid;
  wire [31:0]m_axi_user1_csr_rdata;
  wire [0:0]m_axi_user1_csr_rready;
  wire [1:0]m_axi_user1_csr_rresp;
  wire [0:0]m_axi_user1_csr_rvalid;
  wire [31:0]m_axi_user1_csr_wdata;
  wire [0:0]m_axi_user1_csr_wready;
  wire [3:0]m_axi_user1_csr_wstrb;
  wire [0:0]m_axi_user1_csr_wvalid;
  wire [25:0]m_axi_user2_csr_araddr;
  wire [2:0]m_axi_user2_csr_arprot;
  wire [0:0]m_axi_user2_csr_arready;
  wire [0:0]m_axi_user2_csr_arvalid;
  wire [25:0]m_axi_user2_csr_awaddr;
  wire [2:0]m_axi_user2_csr_awprot;
  wire [0:0]m_axi_user2_csr_awready;
  wire [0:0]m_axi_user2_csr_awvalid;
  wire [0:0]m_axi_user2_csr_bready;
  wire [1:0]m_axi_user2_csr_bresp;
  wire [0:0]m_axi_user2_csr_bvalid;
  wire [31:0]m_axi_user2_csr_rdata;
  wire [0:0]m_axi_user2_csr_rready;
  wire [1:0]m_axi_user2_csr_rresp;
  wire [0:0]m_axi_user2_csr_rvalid;
  wire [31:0]m_axi_user2_csr_wdata;
  wire [0:0]m_axi_user2_csr_wready;
  wire [3:0]m_axi_user2_csr_wstrb;
  wire [0:0]m_axi_user2_csr_wvalid;
  wire [511:0]m_axis_ddr_rqst_tdata;
  wire [7:0]m_axis_ddr_rqst_tid;
  wire m_axis_ddr_rqst_tlast;
  wire m_axis_ddr_rqst_tready;
  wire [255:0]m_axis_ddr_rqst_tuser;
  wire m_axis_ddr_rqst_tvalid;
  wire [7:0]m_axis_dma_pcie_cntl_tdata;
  wire m_axis_dma_pcie_cntl_tvalid;
  wire [255:0]m_axis_pcie_rc_tdata;
  wire [31:0]m_axis_pcie_rc_tkeep;
  wire m_axis_pcie_rc_tlast;
  wire m_axis_pcie_rc_tready;
  wire [74:0]m_axis_pcie_rc_tuser;
  wire m_axis_pcie_rc_tvalid;
  wire [2:0]mga;
  wire pcie_lane_led0_n;
  wire pcie_lane_led1_n;
  wire pcie_link_up;
  wire pcie_link_up_led_n;
  wire [7:0]pcie_mgt_rxn;
  wire [7:0]pcie_mgt_rxp;
  wire [7:0]pcie_mgt_txn;
  wire [7:0]pcie_mgt_txp;
  wire pcie_perstn_in;
  wire [7:0]rev;
  wire [23:0]rev_date;
  wire rq_shutdown_ok;
  wire [511:0]s_axis_ddr_rsp_tdata;
  wire [7:0]s_axis_ddr_rsp_tid;
  wire s_axis_ddr_rsp_tlast;
  wire [255:0]s_axis_ddr_rsp_tuser;
  wire s_axis_ddr_rsp_tvalid;
  wire [255:0]s_axis_pcie_rq_tdata;
  wire [31:0]s_axis_pcie_rq_tkeep;
  wire s_axis_pcie_rq_tlast;
  wire s_axis_pcie_rq_tready;
  wire [59:0]s_axis_pcie_rq_tuser;
  wire s_axis_pcie_rq_tvalid;
  wire shutdown_rqst;
  wire startup_eos_in;
  wire sys_clk;
  wire sys_clk_gt;
  wire sys_mon_alarm;
  wire sys_mon_led_n;
  wire temp_irq_n;
  wire time_irq;
  wire [1:0]user1_irq;
  wire [1:0]user2_irq;
  wire user_led_n;

  IOBUF iic_port0_scl_iobuf
       (.I(iic_port0_scl_o),
        .IO(iic_port0_scl_io),
        .O(iic_port0_scl_i),
        .T(iic_port0_scl_t));
  IOBUF iic_port0_sda_iobuf
       (.I(iic_port0_sda_o),
        .IO(iic_port0_sda_io),
        .O(iic_port0_sda_i),
        .T(iic_port0_sda_t));
  IOBUF iic_port1_scl_iobuf
       (.I(iic_port1_scl_o),
        .IO(iic_port1_scl_io),
        .O(iic_port1_scl_i),
        .T(iic_port1_scl_t));
  IOBUF iic_port1_sda_iobuf
       (.I(iic_port1_sda_o),
        .IO(iic_port1_sda_io),
        .O(iic_port1_sda_i),
        .T(iic_port1_sda_t));
  pcie_intrfc pcie_intrfc_i
       (.Vaux0_v_n(Vaux0_v_n),
        .Vaux0_v_p(Vaux0_v_p),
        .Vaux10_v_n(Vaux10_v_n),
        .Vaux10_v_p(Vaux10_v_p),
        .Vaux11_v_n(Vaux11_v_n),
        .Vaux11_v_p(Vaux11_v_p),
        .Vaux12_v_n(Vaux12_v_n),
        .Vaux12_v_p(Vaux12_v_p),
        .Vaux1_v_n(Vaux1_v_n),
        .Vaux1_v_p(Vaux1_v_p),
        .Vaux2_v_n(Vaux2_v_n),
        .Vaux2_v_p(Vaux2_v_p),
        .Vaux3_v_n(Vaux3_v_n),
        .Vaux3_v_p(Vaux3_v_p),
        .Vaux4_v_n(Vaux4_v_n),
        .Vaux4_v_p(Vaux4_v_p),
        .Vaux8_v_n(Vaux8_v_n),
        .Vaux8_v_p(Vaux8_v_p),
        .Vaux9_v_n(Vaux9_v_n),
        .Vaux9_v_p(Vaux9_v_p),
        .Vp_Vn_v_n(Vp_Vn_v_n),
        .Vp_Vn_v_p(Vp_Vn_v_p),
        .dataio_irq(dataio_irq),
        .dataiopkt_irq(dataiopkt_irq),
        .dma_irq(dma_irq),
        .dsp_irq(dsp_irq),
        .flash_a(flash_a),
        .flash_adv_b(flash_adv_b),
        .flash_d_i(flash_d_i),
        .flash_d_o(flash_d_o),
        .flash_d_t(flash_d_t),
        .flash_fcs_b(flash_fcs_b),
        .flash_foe_b(flash_foe_b),
        .flash_fwe_b(flash_fwe_b),
        .fpga_size(fpga_size),
        .fpio_type(fpio_type),
        .iic_port0_scl_i(iic_port0_scl_i),
        .iic_port0_scl_o(iic_port0_scl_o),
        .iic_port0_scl_t(iic_port0_scl_t),
        .iic_port0_sda_i(iic_port0_sda_i),
        .iic_port0_sda_o(iic_port0_sda_o),
        .iic_port0_sda_t(iic_port0_sda_t),
        .iic_port1_scl_i(iic_port1_scl_i),
        .iic_port1_scl_o(iic_port1_scl_o),
        .iic_port1_scl_t(iic_port1_scl_t),
        .iic_port1_sda_i(iic_port1_sda_i),
        .iic_port1_sda_o(iic_port1_sda_o),
        .iic_port1_sda_t(iic_port1_sda_t),
        .m_axi_acq_csr_araddr(m_axi_acq_csr_araddr),
        .m_axi_acq_csr_arprot(m_axi_acq_csr_arprot),
        .m_axi_acq_csr_arready(m_axi_acq_csr_arready),
        .m_axi_acq_csr_arvalid(m_axi_acq_csr_arvalid),
        .m_axi_acq_csr_awaddr(m_axi_acq_csr_awaddr),
        .m_axi_acq_csr_awprot(m_axi_acq_csr_awprot),
        .m_axi_acq_csr_awready(m_axi_acq_csr_awready),
        .m_axi_acq_csr_awvalid(m_axi_acq_csr_awvalid),
        .m_axi_acq_csr_bready(m_axi_acq_csr_bready),
        .m_axi_acq_csr_bresp(m_axi_acq_csr_bresp),
        .m_axi_acq_csr_bvalid(m_axi_acq_csr_bvalid),
        .m_axi_acq_csr_rdata(m_axi_acq_csr_rdata),
        .m_axi_acq_csr_rready(m_axi_acq_csr_rready),
        .m_axi_acq_csr_rresp(m_axi_acq_csr_rresp),
        .m_axi_acq_csr_rvalid(m_axi_acq_csr_rvalid),
        .m_axi_acq_csr_wdata(m_axi_acq_csr_wdata),
        .m_axi_acq_csr_wready(m_axi_acq_csr_wready),
        .m_axi_acq_csr_wstrb(m_axi_acq_csr_wstrb),
        .m_axi_acq_csr_wvalid(m_axi_acq_csr_wvalid),
        .m_axi_csr_aclk(m_axi_csr_aclk),
        .m_axi_csr_aresetn(m_axi_csr_aresetn),
        .m_axi_dataio_csr_araddr(m_axi_dataio_csr_araddr),
        .m_axi_dataio_csr_arprot(m_axi_dataio_csr_arprot),
        .m_axi_dataio_csr_arready(m_axi_dataio_csr_arready),
        .m_axi_dataio_csr_arvalid(m_axi_dataio_csr_arvalid),
        .m_axi_dataio_csr_awaddr(m_axi_dataio_csr_awaddr),
        .m_axi_dataio_csr_awprot(m_axi_dataio_csr_awprot),
        .m_axi_dataio_csr_awready(m_axi_dataio_csr_awready),
        .m_axi_dataio_csr_awvalid(m_axi_dataio_csr_awvalid),
        .m_axi_dataio_csr_bready(m_axi_dataio_csr_bready),
        .m_axi_dataio_csr_bresp(m_axi_dataio_csr_bresp),
        .m_axi_dataio_csr_bvalid(m_axi_dataio_csr_bvalid),
        .m_axi_dataio_csr_rdata(m_axi_dataio_csr_rdata),
        .m_axi_dataio_csr_rready(m_axi_dataio_csr_rready),
        .m_axi_dataio_csr_rresp(m_axi_dataio_csr_rresp),
        .m_axi_dataio_csr_rvalid(m_axi_dataio_csr_rvalid),
        .m_axi_dataio_csr_wdata(m_axi_dataio_csr_wdata),
        .m_axi_dataio_csr_wready(m_axi_dataio_csr_wready),
        .m_axi_dataio_csr_wstrb(m_axi_dataio_csr_wstrb),
        .m_axi_dataio_csr_wvalid(m_axi_dataio_csr_wvalid),
        .m_axi_ddr4_csr_araddr(m_axi_ddr4_csr_araddr),
        .m_axi_ddr4_csr_arprot(m_axi_ddr4_csr_arprot),
        .m_axi_ddr4_csr_arready(m_axi_ddr4_csr_arready),
        .m_axi_ddr4_csr_arvalid(m_axi_ddr4_csr_arvalid),
        .m_axi_ddr4_csr_awaddr(m_axi_ddr4_csr_awaddr),
        .m_axi_ddr4_csr_awprot(m_axi_ddr4_csr_awprot),
        .m_axi_ddr4_csr_awready(m_axi_ddr4_csr_awready),
        .m_axi_ddr4_csr_awvalid(m_axi_ddr4_csr_awvalid),
        .m_axi_ddr4_csr_bready(m_axi_ddr4_csr_bready),
        .m_axi_ddr4_csr_bresp(m_axi_ddr4_csr_bresp),
        .m_axi_ddr4_csr_bvalid(m_axi_ddr4_csr_bvalid),
        .m_axi_ddr4_csr_rdata(m_axi_ddr4_csr_rdata),
        .m_axi_ddr4_csr_rready(m_axi_ddr4_csr_rready),
        .m_axi_ddr4_csr_rresp(m_axi_ddr4_csr_rresp),
        .m_axi_ddr4_csr_rvalid(m_axi_ddr4_csr_rvalid),
        .m_axi_ddr4_csr_wdata(m_axi_ddr4_csr_wdata),
        .m_axi_ddr4_csr_wready(m_axi_ddr4_csr_wready),
        .m_axi_ddr4_csr_wstrb(m_axi_ddr4_csr_wstrb),
        .m_axi_ddr4_csr_wvalid(m_axi_ddr4_csr_wvalid),
        .m_axi_dsp_csr_araddr(m_axi_dsp_csr_araddr),
        .m_axi_dsp_csr_arprot(m_axi_dsp_csr_arprot),
        .m_axi_dsp_csr_arready(m_axi_dsp_csr_arready),
        .m_axi_dsp_csr_arvalid(m_axi_dsp_csr_arvalid),
        .m_axi_dsp_csr_awaddr(m_axi_dsp_csr_awaddr),
        .m_axi_dsp_csr_awprot(m_axi_dsp_csr_awprot),
        .m_axi_dsp_csr_awready(m_axi_dsp_csr_awready),
        .m_axi_dsp_csr_awvalid(m_axi_dsp_csr_awvalid),
        .m_axi_dsp_csr_bready(m_axi_dsp_csr_bready),
        .m_axi_dsp_csr_bresp(m_axi_dsp_csr_bresp),
        .m_axi_dsp_csr_bvalid(m_axi_dsp_csr_bvalid),
        .m_axi_dsp_csr_rdata(m_axi_dsp_csr_rdata),
        .m_axi_dsp_csr_rready(m_axi_dsp_csr_rready),
        .m_axi_dsp_csr_rresp(m_axi_dsp_csr_rresp),
        .m_axi_dsp_csr_rvalid(m_axi_dsp_csr_rvalid),
        .m_axi_dsp_csr_wdata(m_axi_dsp_csr_wdata),
        .m_axi_dsp_csr_wready(m_axi_dsp_csr_wready),
        .m_axi_dsp_csr_wstrb(m_axi_dsp_csr_wstrb),
        .m_axi_dsp_csr_wvalid(m_axi_dsp_csr_wvalid),
        .m_axi_user1_csr_araddr(m_axi_user1_csr_araddr),
        .m_axi_user1_csr_arprot(m_axi_user1_csr_arprot),
        .m_axi_user1_csr_arready(m_axi_user1_csr_arready),
        .m_axi_user1_csr_arvalid(m_axi_user1_csr_arvalid),
        .m_axi_user1_csr_awaddr(m_axi_user1_csr_awaddr),
        .m_axi_user1_csr_awprot(m_axi_user1_csr_awprot),
        .m_axi_user1_csr_awready(m_axi_user1_csr_awready),
        .m_axi_user1_csr_awvalid(m_axi_user1_csr_awvalid),
        .m_axi_user1_csr_bready(m_axi_user1_csr_bready),
        .m_axi_user1_csr_bresp(m_axi_user1_csr_bresp),
        .m_axi_user1_csr_bvalid(m_axi_user1_csr_bvalid),
        .m_axi_user1_csr_rdata(m_axi_user1_csr_rdata),
        .m_axi_user1_csr_rready(m_axi_user1_csr_rready),
        .m_axi_user1_csr_rresp(m_axi_user1_csr_rresp),
        .m_axi_user1_csr_rvalid(m_axi_user1_csr_rvalid),
        .m_axi_user1_csr_wdata(m_axi_user1_csr_wdata),
        .m_axi_user1_csr_wready(m_axi_user1_csr_wready),
        .m_axi_user1_csr_wstrb(m_axi_user1_csr_wstrb),
        .m_axi_user1_csr_wvalid(m_axi_user1_csr_wvalid),
        .m_axi_user2_csr_araddr(m_axi_user2_csr_araddr),
        .m_axi_user2_csr_arprot(m_axi_user2_csr_arprot),
        .m_axi_user2_csr_arready(m_axi_user2_csr_arready),
        .m_axi_user2_csr_arvalid(m_axi_user2_csr_arvalid),
        .m_axi_user2_csr_awaddr(m_axi_user2_csr_awaddr),
        .m_axi_user2_csr_awprot(m_axi_user2_csr_awprot),
        .m_axi_user2_csr_awready(m_axi_user2_csr_awready),
        .m_axi_user2_csr_awvalid(m_axi_user2_csr_awvalid),
        .m_axi_user2_csr_bready(m_axi_user2_csr_bready),
        .m_axi_user2_csr_bresp(m_axi_user2_csr_bresp),
        .m_axi_user2_csr_bvalid(m_axi_user2_csr_bvalid),
        .m_axi_user2_csr_rdata(m_axi_user2_csr_rdata),
        .m_axi_user2_csr_rready(m_axi_user2_csr_rready),
        .m_axi_user2_csr_rresp(m_axi_user2_csr_rresp),
        .m_axi_user2_csr_rvalid(m_axi_user2_csr_rvalid),
        .m_axi_user2_csr_wdata(m_axi_user2_csr_wdata),
        .m_axi_user2_csr_wready(m_axi_user2_csr_wready),
        .m_axi_user2_csr_wstrb(m_axi_user2_csr_wstrb),
        .m_axi_user2_csr_wvalid(m_axi_user2_csr_wvalid),
        .m_axis_ddr_rqst_tdata(m_axis_ddr_rqst_tdata),
        .m_axis_ddr_rqst_tid(m_axis_ddr_rqst_tid),
        .m_axis_ddr_rqst_tlast(m_axis_ddr_rqst_tlast),
        .m_axis_ddr_rqst_tready(m_axis_ddr_rqst_tready),
        .m_axis_ddr_rqst_tuser(m_axis_ddr_rqst_tuser),
        .m_axis_ddr_rqst_tvalid(m_axis_ddr_rqst_tvalid),
        .m_axis_dma_pcie_cntl_tdata(m_axis_dma_pcie_cntl_tdata),
        .m_axis_dma_pcie_cntl_tvalid(m_axis_dma_pcie_cntl_tvalid),
        .m_axis_pcie_rc_tdata(m_axis_pcie_rc_tdata),
        .m_axis_pcie_rc_tkeep(m_axis_pcie_rc_tkeep),
        .m_axis_pcie_rc_tlast(m_axis_pcie_rc_tlast),
        .m_axis_pcie_rc_tready(m_axis_pcie_rc_tready),
        .m_axis_pcie_rc_tuser(m_axis_pcie_rc_tuser),
        .m_axis_pcie_rc_tvalid(m_axis_pcie_rc_tvalid),
        .mga(mga),
        .pcie_lane_led0_n(pcie_lane_led0_n),
        .pcie_lane_led1_n(pcie_lane_led1_n),
        .pcie_link_up(pcie_link_up),
        .pcie_link_up_led_n(pcie_link_up_led_n),
        .pcie_mgt_rxn(pcie_mgt_rxn),
        .pcie_mgt_rxp(pcie_mgt_rxp),
        .pcie_mgt_txn(pcie_mgt_txn),
        .pcie_mgt_txp(pcie_mgt_txp),
        .pcie_perstn_in(pcie_perstn_in),
        .rev(rev),
        .rev_date(rev_date),
        .rq_shutdown_ok(rq_shutdown_ok),
        .s_axis_ddr_rsp_tdata(s_axis_ddr_rsp_tdata),
        .s_axis_ddr_rsp_tid(s_axis_ddr_rsp_tid),
        .s_axis_ddr_rsp_tlast(s_axis_ddr_rsp_tlast),
        .s_axis_ddr_rsp_tuser(s_axis_ddr_rsp_tuser),
        .s_axis_ddr_rsp_tvalid(s_axis_ddr_rsp_tvalid),
        .s_axis_pcie_rq_tdata(s_axis_pcie_rq_tdata),
        .s_axis_pcie_rq_tkeep(s_axis_pcie_rq_tkeep),
        .s_axis_pcie_rq_tlast(s_axis_pcie_rq_tlast),
        .s_axis_pcie_rq_tready(s_axis_pcie_rq_tready),
        .s_axis_pcie_rq_tuser(s_axis_pcie_rq_tuser),
        .s_axis_pcie_rq_tvalid(s_axis_pcie_rq_tvalid),
        .shutdown_rqst(shutdown_rqst),
        .startup_eos_in(startup_eos_in),
        .sys_clk(sys_clk),
        .sys_clk_gt(sys_clk_gt),
        .sys_mon_alarm(sys_mon_alarm),
        .sys_mon_led_n(sys_mon_led_n),
        .temp_irq_n(temp_irq_n),
        .time_irq(time_irq),
        .user1_irq(user1_irq),
        .user2_irq(user2_irq),
        .user_led_n(user_led_n));
endmodule
