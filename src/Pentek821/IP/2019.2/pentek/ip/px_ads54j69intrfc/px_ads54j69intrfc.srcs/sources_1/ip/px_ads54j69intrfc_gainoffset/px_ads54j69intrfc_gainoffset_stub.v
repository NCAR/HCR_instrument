// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Tue Jun 11 12:35:30 2019
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Pentek/IP/2019.1/pentek/ip/px_ads54j69intrfc/px_ads54j69intrfc.srcs/sources_1/ip/px_ads54j69intrfc_gainoffset/px_ads54j69intrfc_gainoffset_stub.v
// Design      : px_ads54j69intrfc_gainoffset
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *)
module px_ads54j69intrfc_gainoffset(CLK, A, B, D, P)
/* synthesis syn_black_box black_box_pad_pin="CLK,A[15:0],B[16:0],D[15:0],P[17:0]" */;
  input CLK;
  input [15:0]A;
  input [16:0]B;
  input [15:0]D;
  output [17:0]P;
endmodule