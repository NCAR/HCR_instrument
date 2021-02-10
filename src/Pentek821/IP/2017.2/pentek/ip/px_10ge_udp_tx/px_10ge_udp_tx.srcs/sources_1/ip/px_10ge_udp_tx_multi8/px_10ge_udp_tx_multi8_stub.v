// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
// Date        : Mon May  8 09:05:27 2017
// Host        : Mike-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top px_10ge_udp_tx_multi8 -prefix
//               px_10ge_udp_tx_multi8_ px_10ge_udp_tx_multi8_stub.v
// Design      : px_10ge_udp_tx_multi8
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "mult_gen_v12_0_12,Vivado 2017.1" *)
module px_10ge_udp_tx_multi8(A, P)
/* synthesis syn_black_box black_box_pad_pin="A[15:0],P[15:0]" */;
  input [15:0]A;
  output [15:0]P;
endmodule
