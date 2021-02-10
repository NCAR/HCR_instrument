// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
// Date        : Mon May  8 09:04:49 2017
// Host        : Mike-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/pentek/ip/2017.1/wip/px_10ge_udp_tx/px_10ge_udp_tx.srcs/sources_1/ip/px_10ge_udp_tx_checksum_adder/px_10ge_udp_tx_checksum_adder_stub.v
// Design      : px_10ge_udp_tx_checksum_adder
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "c_addsub_v12_0_10,Vivado 2017.1" *)
module px_10ge_udp_tx_checksum_adder(A, B, C_IN, C_OUT, S)
/* synthesis syn_black_box black_box_pad_pin="A[15:0],B[15:0],C_IN,C_OUT,S[15:0]" */;
  input [15:0]A;
  input [15:0]B;
  input C_IN;
  output C_OUT;
  output [15:0]S;
endmodule
