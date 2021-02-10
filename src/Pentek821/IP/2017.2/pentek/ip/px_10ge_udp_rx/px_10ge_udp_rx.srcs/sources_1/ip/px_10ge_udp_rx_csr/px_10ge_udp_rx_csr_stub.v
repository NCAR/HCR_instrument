// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2.1 (win64) Build 1957588 Wed Aug  9 16:32:24 MDT 2017
// Date        : Mon Oct 23 15:07:53 2017
// Host        : Mike-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/pentek/ip/2017.2/wip/px_10ge_udp_rx/px_10ge_udp_rx.srcs/sources_1/ip/px_10ge_udp_rx_csr/px_10ge_udp_rx_csr_stub.v
// Design      : px_10ge_udp_rx_csr
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "px_axil_csr,Vivado 2017.2.1" *)
module px_10ge_udp_rx_csr(s_axi_csr_aclk, s_axi_csr_aresetn, 
  s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, 
  s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, 
  s_axi_csr_bvalid, s_axi_csr_bready, s_axi_csr_araddr, s_axi_csr_arprot, 
  s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, 
  s_axi_csr_rready, reg0_init_val, ctl0_out, stat0_in, stat1_in, stat2_in, stat3_in, stat4_in, 
  stat5_in, intrpt_src_in, irq)
/* synthesis syn_black_box black_box_pad_pin="s_axi_csr_aclk,s_axi_csr_aresetn,s_axi_csr_awaddr[6:0],s_axi_csr_awprot[2:0],s_axi_csr_awvalid,s_axi_csr_awready,s_axi_csr_wdata[31:0],s_axi_csr_wstrb[3:0],s_axi_csr_wvalid,s_axi_csr_wready,s_axi_csr_bresp[1:0],s_axi_csr_bvalid,s_axi_csr_bready,s_axi_csr_araddr[6:0],s_axi_csr_arprot[2:0],s_axi_csr_arvalid,s_axi_csr_arready,s_axi_csr_rdata[31:0],s_axi_csr_rresp[1:0],s_axi_csr_rvalid,s_axi_csr_rready,reg0_init_val[31:0],ctl0_out[31:0],stat0_in[31:0],stat1_in[31:0],stat2_in[31:0],stat3_in[31:0],stat4_in[31:0],stat5_in[31:0],intrpt_src_in[3:0],irq" */;
  input s_axi_csr_aclk;
  input s_axi_csr_aresetn;
  input [6:0]s_axi_csr_awaddr;
  input [2:0]s_axi_csr_awprot;
  input s_axi_csr_awvalid;
  output s_axi_csr_awready;
  input [31:0]s_axi_csr_wdata;
  input [3:0]s_axi_csr_wstrb;
  input s_axi_csr_wvalid;
  output s_axi_csr_wready;
  output [1:0]s_axi_csr_bresp;
  output s_axi_csr_bvalid;
  input s_axi_csr_bready;
  input [6:0]s_axi_csr_araddr;
  input [2:0]s_axi_csr_arprot;
  input s_axi_csr_arvalid;
  output s_axi_csr_arready;
  output [31:0]s_axi_csr_rdata;
  output [1:0]s_axi_csr_rresp;
  output s_axi_csr_rvalid;
  input s_axi_csr_rready;
  input [31:0]reg0_init_val;
  output [31:0]ctl0_out;
  input [31:0]stat0_in;
  input [31:0]stat1_in;
  input [31:0]stat2_in;
  input [31:0]stat3_in;
  input [31:0]stat4_in;
  input [31:0]stat5_in;
  input [3:0]intrpt_src_in;
  output irq;
endmodule
