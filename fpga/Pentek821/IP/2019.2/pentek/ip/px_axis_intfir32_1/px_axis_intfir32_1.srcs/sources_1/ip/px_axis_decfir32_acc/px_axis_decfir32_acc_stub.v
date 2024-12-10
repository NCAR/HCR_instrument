// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Mon Aug 01 13:39:26 2016
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Xilinx/Vivado/2016.2/data/ip/pentek/ip/px_axis_decfir32_1/px_axis_decfir32_1.srcs/sources_1/ip/px_axis_decfir32_acc/px_axis_decfir32_acc_stub.v
// Design      : px_axis_decfir32_acc
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "xbip_dsp48_macro_v3_0_12,Vivado 2016.1" *)
module px_axis_decfir32_acc(CLK, CE, SEL, PCIN, P)
/* synthesis syn_black_box black_box_pad_pin="CLK,CE,SEL[0:0],PCIN[47:0],P[47:0]" */;
  input CLK;
  input CE;
  input [0:0]SEL;
  input [47:0]PCIN;
  output [47:0]P;
endmodule
