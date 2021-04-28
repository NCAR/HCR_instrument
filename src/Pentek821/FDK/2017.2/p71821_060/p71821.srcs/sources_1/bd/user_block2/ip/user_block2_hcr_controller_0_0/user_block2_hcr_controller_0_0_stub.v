// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
// Date        : Mon Apr 26 16:13:24 2021
// Host        : wind running 64-bit unknown
// Command     : write_verilog -force -mode synth_stub
//               /home/karboski/git/HCR_instrument/src/Pentek821/FDK/2017.2/p71821_060/p71821.srcs/sources_1/bd/user_block2/ip/user_block2_hcr_controller_0_0/user_block2_hcr_controller_0_0_stub.v
// Design      : user_block2_hcr_controller_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "hcr_controller,Vivado 2017.2" *)
module user_block2_hcr_controller_0_0(pps_ce0, pps_we0, mt_pulse_V_ap_vld, 
  control_flags_V_ap_vld, filter_select_ch0_V_ap_vld, filter_select_ch1_V_ap_vld, 
  filter_select_ch2_V_ap_vld, s_axi_cfg_bus_AWADDR, s_axi_cfg_bus_AWVALID, 
  s_axi_cfg_bus_AWREADY, s_axi_cfg_bus_WDATA, s_axi_cfg_bus_WSTRB, s_axi_cfg_bus_WVALID, 
  s_axi_cfg_bus_WREADY, s_axi_cfg_bus_BRESP, s_axi_cfg_bus_BVALID, s_axi_cfg_bus_BREADY, 
  s_axi_cfg_bus_ARADDR, s_axi_cfg_bus_ARVALID, s_axi_cfg_bus_ARREADY, 
  s_axi_cfg_bus_RDATA, s_axi_cfg_bus_RRESP, s_axi_cfg_bus_RVALID, s_axi_cfg_bus_RREADY, 
  ap_clk, ap_rst_n, interrupt, coef_ch0_V_V_TVALID, coef_ch0_V_V_TREADY, coef_ch0_V_V_TDATA, 
  coef_ch1_V_V_TVALID, coef_ch1_V_V_TREADY, coef_ch1_V_V_TDATA, coef_ch2_V_V_TVALID, 
  coef_ch2_V_V_TREADY, coef_ch2_V_V_TDATA, mt_pulse_V, control_flags_V, 
  filter_select_ch0_V, filter_select_ch1_V, filter_select_ch2_V, 
  pulse_metadata_ch0_V_TVALID, pulse_metadata_ch0_V_TREADY, pulse_metadata_ch0_V_TDATA, 
  pulse_metadata_ch1_V_TVALID, pulse_metadata_ch1_V_TREADY, pulse_metadata_ch1_V_TDATA, 
  pulse_metadata_ch2_V_TVALID, pulse_metadata_ch2_V_TREADY, pulse_metadata_ch2_V_TDATA, 
  pps_address0, pps_d0, pps_q0)
/* synthesis syn_black_box black_box_pad_pin="pps_ce0,pps_we0,mt_pulse_V_ap_vld,control_flags_V_ap_vld,filter_select_ch0_V_ap_vld,filter_select_ch1_V_ap_vld,filter_select_ch2_V_ap_vld,s_axi_cfg_bus_AWADDR[12:0],s_axi_cfg_bus_AWVALID,s_axi_cfg_bus_AWREADY,s_axi_cfg_bus_WDATA[31:0],s_axi_cfg_bus_WSTRB[3:0],s_axi_cfg_bus_WVALID,s_axi_cfg_bus_WREADY,s_axi_cfg_bus_BRESP[1:0],s_axi_cfg_bus_BVALID,s_axi_cfg_bus_BREADY,s_axi_cfg_bus_ARADDR[12:0],s_axi_cfg_bus_ARVALID,s_axi_cfg_bus_ARREADY,s_axi_cfg_bus_RDATA[31:0],s_axi_cfg_bus_RRESP[1:0],s_axi_cfg_bus_RVALID,s_axi_cfg_bus_RREADY,ap_clk,ap_rst_n,interrupt,coef_ch0_V_V_TVALID,coef_ch0_V_V_TREADY,coef_ch0_V_V_TDATA[23:0],coef_ch1_V_V_TVALID,coef_ch1_V_V_TREADY,coef_ch1_V_V_TDATA[23:0],coef_ch2_V_V_TVALID,coef_ch2_V_V_TREADY,coef_ch2_V_V_TDATA[23:0],mt_pulse_V[7:0],control_flags_V[31:0],filter_select_ch0_V[1:0],filter_select_ch1_V[1:0],filter_select_ch2_V[1:0],pulse_metadata_ch0_V_TVALID,pulse_metadata_ch0_V_TREADY,pulse_metadata_ch0_V_TDATA[823:0],pulse_metadata_ch1_V_TVALID,pulse_metadata_ch1_V_TREADY,pulse_metadata_ch1_V_TDATA[823:0],pulse_metadata_ch2_V_TVALID,pulse_metadata_ch2_V_TREADY,pulse_metadata_ch2_V_TDATA[823:0],pps_address0[0:0],pps_d0[0:0],pps_q0[0:0]" */;
  output pps_ce0;
  output pps_we0;
  output mt_pulse_V_ap_vld;
  output control_flags_V_ap_vld;
  output filter_select_ch0_V_ap_vld;
  output filter_select_ch1_V_ap_vld;
  output filter_select_ch2_V_ap_vld;
  input [12:0]s_axi_cfg_bus_AWADDR;
  input s_axi_cfg_bus_AWVALID;
  output s_axi_cfg_bus_AWREADY;
  input [31:0]s_axi_cfg_bus_WDATA;
  input [3:0]s_axi_cfg_bus_WSTRB;
  input s_axi_cfg_bus_WVALID;
  output s_axi_cfg_bus_WREADY;
  output [1:0]s_axi_cfg_bus_BRESP;
  output s_axi_cfg_bus_BVALID;
  input s_axi_cfg_bus_BREADY;
  input [12:0]s_axi_cfg_bus_ARADDR;
  input s_axi_cfg_bus_ARVALID;
  output s_axi_cfg_bus_ARREADY;
  output [31:0]s_axi_cfg_bus_RDATA;
  output [1:0]s_axi_cfg_bus_RRESP;
  output s_axi_cfg_bus_RVALID;
  input s_axi_cfg_bus_RREADY;
  input ap_clk;
  input ap_rst_n;
  output interrupt;
  output coef_ch0_V_V_TVALID;
  input coef_ch0_V_V_TREADY;
  output [23:0]coef_ch0_V_V_TDATA;
  output coef_ch1_V_V_TVALID;
  input coef_ch1_V_V_TREADY;
  output [23:0]coef_ch1_V_V_TDATA;
  output coef_ch2_V_V_TVALID;
  input coef_ch2_V_V_TREADY;
  output [23:0]coef_ch2_V_V_TDATA;
  output [7:0]mt_pulse_V;
  output [31:0]control_flags_V;
  output [1:0]filter_select_ch0_V;
  output [1:0]filter_select_ch1_V;
  output [1:0]filter_select_ch2_V;
  output pulse_metadata_ch0_V_TVALID;
  input pulse_metadata_ch0_V_TREADY;
  output [823:0]pulse_metadata_ch0_V_TDATA;
  output pulse_metadata_ch1_V_TVALID;
  input pulse_metadata_ch1_V_TREADY;
  output [823:0]pulse_metadata_ch1_V_TDATA;
  output pulse_metadata_ch2_V_TVALID;
  input pulse_metadata_ch2_V_TREADY;
  output [823:0]pulse_metadata_ch2_V_TDATA;
  output [0:0]pps_address0;
  output [0:0]pps_d0;
  input [0:0]pps_q0;
endmodule
