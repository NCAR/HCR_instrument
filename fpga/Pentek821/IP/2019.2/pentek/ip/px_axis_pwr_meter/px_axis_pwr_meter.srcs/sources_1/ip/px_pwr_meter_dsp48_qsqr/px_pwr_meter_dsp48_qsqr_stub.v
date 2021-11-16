// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  8 19:04:29 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Pentek/IP/2019.1/pentek/ip/px_axis_pwr_meter/px_axis_pwr_meter.srcs/sources_1/ip/px_pwr_meter_dsp48_qsqr/px_pwr_meter_dsp48_qsqr_stub.v
// Design      : px_pwr_meter_dsp48_qsqr
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *)
module px_pwr_meter_dsp48_qsqr(CLK, PCIN, A, B, P)
/* synthesis syn_black_box black_box_pad_pin="CLK,PCIN[47:0],A[15:0],B[15:0],P[47:0]" */;
  input CLK;
  input [47:0]PCIN;
  input [15:0]A;
  input [15:0]B;
  output [47:0]P;
endmodule
