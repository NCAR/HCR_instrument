// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
// Date        : Fri Jan 13 14:58:35 2017
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Pentek/IP/2016.4/pentek/ip/px_axis_intfir32_1/px_axis_intfir32_1.srcs/sources_1/ip/px_axis_intfir32_sr16/px_axis_intfir32_sr16_stub.v
// Design      : px_axis_intfir32_sr16
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "c_shift_ram_v12_0_10,Vivado 2016.4" *)
module px_axis_intfir32_sr16(A, D, CLK, CE, Q)
/* synthesis syn_black_box black_box_pad_pin="A[4:0],D[15:0],CLK,CE,Q[15:0]" */;
  input [4:0]A;
  input [15:0]D;
  input CLK;
  input CE;
  output [15:0]Q;
endmodule
