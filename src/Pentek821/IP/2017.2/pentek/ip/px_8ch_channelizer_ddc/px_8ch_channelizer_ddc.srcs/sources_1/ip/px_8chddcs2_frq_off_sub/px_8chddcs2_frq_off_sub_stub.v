// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
// Date        : Thu May 11 15:12:14 2017
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Pentek/IP/2017.1/wip/px_8ch_channelizer_ddc/px_8ch_channelizer_ddc.srcs/sources_1/ip/px_8chddcs2_frq_off_sub/px_8chddcs2_frq_off_sub_stub.v
// Design      : px_8chddcs2_frq_off_sub
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "c_addsub_v12_0_10,Vivado 2017.1" *)
module px_8chddcs2_frq_off_sub(A, B, CLK, C_IN, S)
/* synthesis syn_black_box black_box_pad_pin="A[31:0],B[31:0],CLK,C_IN,S[31:0]" */;
  input [31:0]A;
  input [31:0]B;
  input CLK;
  input C_IN;
  output [31:0]S;
endmodule
