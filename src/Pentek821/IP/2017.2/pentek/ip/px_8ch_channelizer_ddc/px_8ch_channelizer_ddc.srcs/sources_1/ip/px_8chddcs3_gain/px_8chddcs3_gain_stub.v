// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
// Date        : Tue May 16 08:57:49 2017
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top px_8chddcs3_gain -prefix
//               px_8chddcs3_gain_ px_8chddcs3_gain_stub.v
// Design      : px_8chddcs3_gain
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "mult_gen_v12_0_12,Vivado 2017.1" *)
module px_8chddcs3_gain(CLK, A, B, P)
/* synthesis syn_black_box black_box_pad_pin="CLK,A[42:0],B[15:0],P[58:0]" */;
  input CLK;
  input [42:0]A;
  input [15:0]B;
  output [58:0]P;
endmodule
