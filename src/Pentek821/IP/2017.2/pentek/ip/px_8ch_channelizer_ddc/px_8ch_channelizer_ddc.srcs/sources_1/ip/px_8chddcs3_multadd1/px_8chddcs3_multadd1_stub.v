// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
// Date        : Wed May 17 12:31:42 2017
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Pentek/IP/2017.1/wip/px_8ch_channelizer_ddc/px_8ch_channelizer_ddc.srcs/sources_1/ip/px_8chddcs3_multadd1/px_8chddcs3_multadd1_stub.v
// Design      : px_8chddcs3_multadd1
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "xbip_dsp48_macro_v3_0_14,Vivado 2017.1" *)
module px_8chddcs3_multadd1(CLK, A, B, D, PCOUT, P)
/* synthesis syn_black_box black_box_pad_pin="CLK,A[17:0],B[17:0],D[17:0],PCOUT[47:0],P[35:0]" */;
  input CLK;
  input [17:0]A;
  input [17:0]B;
  input [17:0]D;
  output [47:0]PCOUT;
  output [35:0]P;
endmodule
