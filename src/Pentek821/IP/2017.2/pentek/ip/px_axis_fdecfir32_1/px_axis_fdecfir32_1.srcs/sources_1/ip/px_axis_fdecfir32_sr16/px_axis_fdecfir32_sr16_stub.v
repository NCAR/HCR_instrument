// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
// Date        : Wed Dec 28 22:47:55 2016
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Pentek/IP/2016.3/pentek/ip/px_axis_fdecfir32_1/px_axis_fdecfir32_1.srcs/sources_1/ip/px_axis_fdecfir32_sr16/px_axis_fdecfir32_sr16_stub.v
// Design      : px_axis_fdecfir32_sr16
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "c_shift_ram_v12_0_10,Vivado 2016.3" *)
module px_axis_fdecfir32_sr16(A, D, CLK, CE, Q)
/* synthesis syn_black_box black_box_pad_pin="A[4:0],D[15:0],CLK,CE,Q[15:0]" */;
  input [4:0]A;
  input [15:0]D;
  input CLK;
  input CE;
  output [15:0]Q;
endmodule
