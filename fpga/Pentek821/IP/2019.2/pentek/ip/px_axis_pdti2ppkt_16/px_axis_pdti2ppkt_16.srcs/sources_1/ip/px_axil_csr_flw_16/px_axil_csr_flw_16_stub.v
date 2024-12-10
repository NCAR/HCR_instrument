// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2700185 Thu Oct 24 18:46:05 MDT 2019
// Date        : Thu May  7 06:05:43 2020
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Pentek/IP/2019.2/pentek/ip/px_axis_pdti2ppkt_16/px_axis_pdti2ppkt_16.srcs/sources_1/ip/px_axil_csr_flw_16/px_axil_csr_flw_16_stub.v
// Design      : px_axil_csr_flw_16
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "px_axil_csr,Vivado 2019.2" *)
module px_axil_csr_flw_16(s_axi_csr_aclk, s_axi_csr_aresetn, 
  s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, 
  s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, 
  s_axi_csr_bvalid, s_axi_csr_bready, s_axi_csr_araddr, s_axi_csr_arprot, 
  s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, 
  s_axi_csr_rready, reg0_init_val, reg1_init_val, reg2_init_val, reg3_init_val, 
  reg4_init_val, reg5_init_val, reg6_init_val, reg7_init_val, ctl0_out, ctl1_out, ctl2_out, 
  ctl3_out, ctl4_out, ctl5_out, ctl6_out, ctl7_out, stat0_in, stat1_in, stat2_in, stat3_in, stat4_in, 
  intrpt_src_in, irq)
/* synthesis syn_black_box black_box_pad_pin="s_axi_csr_aclk,s_axi_csr_aresetn,s_axi_csr_awaddr[6:0],s_axi_csr_awprot[2:0],s_axi_csr_awvalid,s_axi_csr_awready,s_axi_csr_wdata[31:0],s_axi_csr_wstrb[3:0],s_axi_csr_wvalid,s_axi_csr_wready,s_axi_csr_bresp[1:0],s_axi_csr_bvalid,s_axi_csr_bready,s_axi_csr_araddr[6:0],s_axi_csr_arprot[2:0],s_axi_csr_arvalid,s_axi_csr_arready,s_axi_csr_rdata[31:0],s_axi_csr_rresp[1:0],s_axi_csr_rvalid,s_axi_csr_rready,reg0_init_val[31:0],reg1_init_val[31:0],reg2_init_val[31:0],reg3_init_val[31:0],reg4_init_val[31:0],reg5_init_val[31:0],reg6_init_val[31:0],reg7_init_val[31:0],ctl0_out[31:0],ctl1_out[31:0],ctl2_out[31:0],ctl3_out[31:0],ctl4_out[31:0],ctl5_out[31:0],ctl6_out[31:0],ctl7_out[31:0],stat0_in[31:0],stat1_in[31:0],stat2_in[31:0],stat3_in[31:0],stat4_in[31:0],intrpt_src_in[4:0],irq" */;
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
  input [31:0]reg1_init_val;
  input [31:0]reg2_init_val;
  input [31:0]reg3_init_val;
  input [31:0]reg4_init_val;
  input [31:0]reg5_init_val;
  input [31:0]reg6_init_val;
  input [31:0]reg7_init_val;
  output [31:0]ctl0_out;
  output [31:0]ctl1_out;
  output [31:0]ctl2_out;
  output [31:0]ctl3_out;
  output [31:0]ctl4_out;
  output [31:0]ctl5_out;
  output [31:0]ctl6_out;
  output [31:0]ctl7_out;
  input [31:0]stat0_in;
  input [31:0]stat1_in;
  input [31:0]stat2_in;
  input [31:0]stat3_in;
  input [31:0]stat4_in;
  input [4:0]intrpt_src_in;
  output irq;
endmodule
