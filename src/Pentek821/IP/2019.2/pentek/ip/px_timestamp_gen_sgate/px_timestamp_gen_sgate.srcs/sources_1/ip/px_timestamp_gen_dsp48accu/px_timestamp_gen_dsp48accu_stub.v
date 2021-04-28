// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sun Jun  9 09:10:30 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Pentek/IP/2019.1/pentek/ip/px_timestamp_gen_sgate/px_timestamp_gen_sgate.srcs/sources_1/ip/px_timestamp_gen_dsp48accu/px_timestamp_gen_dsp48accu_stub.v
// Design      : px_timestamp_gen_dsp48accu
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *)
module px_timestamp_gen_dsp48accu(CLK, SEL, CARRYCASCIN, C, P, CEP, SCLRP)
/* synthesis syn_black_box black_box_pad_pin="CLK,SEL[0:0],CARRYCASCIN,C[15:0],P[15:0],CEP,SCLRP" */;
  input CLK;
  input [0:0]SEL;
  input CARRYCASCIN;
  input [15:0]C;
  output [15:0]P;
  input CEP;
  input SCLRP;
endmodule
