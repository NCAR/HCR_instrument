// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
// Date        : Fri Apr 16 23:22:48 2021
// Host        : wind running 64-bit unknown
// Command     : write_verilog -force -mode synth_stub
//               /home/karboski/git/HCR_instrument/src/Pentek821/FDK/2017.2/p71821_060/p71821.srcs/sources_1/bd/user_block2/ip/user_block2_px_axil_csr_0_0/user_block2_px_axil_csr_0_0_stub.v
// Design      : user_block2_px_axil_csr_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "px_axil_csr,Vivado 2017.2" *)
module user_block2_px_axil_csr_0_0(s_axi_csr_aclk, s_axi_csr_aresetn, 
  s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, 
  s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, 
  s_axi_csr_bvalid, s_axi_csr_bready, s_axi_csr_araddr, s_axi_csr_arprot, 
  s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, 
  s_axi_csr_rready, reg0_init_val, reg1_init_val, reg2_init_val, ctl0_out, ctl1_out, ctl2_out)
/* synthesis syn_black_box black_box_pad_pin="s_axi_csr_aclk,s_axi_csr_aresetn,s_axi_csr_awaddr[6:0],s_axi_csr_awprot[2:0],s_axi_csr_awvalid,s_axi_csr_awready,s_axi_csr_wdata[31:0],s_axi_csr_wstrb[3:0],s_axi_csr_wvalid,s_axi_csr_wready,s_axi_csr_bresp[1:0],s_axi_csr_bvalid,s_axi_csr_bready,s_axi_csr_araddr[6:0],s_axi_csr_arprot[2:0],s_axi_csr_arvalid,s_axi_csr_arready,s_axi_csr_rdata[31:0],s_axi_csr_rresp[1:0],s_axi_csr_rvalid,s_axi_csr_rready,reg0_init_val[31:0],reg1_init_val[31:0],reg2_init_val[31:0],ctl0_out[31:0],ctl1_out[31:0],ctl2_out[31:0]" */;
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
  output [31:0]ctl0_out;
  output [31:0]ctl1_out;
  output [31:0]ctl2_out;
endmodule
