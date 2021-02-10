// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
// Date        : Tue Nov 01 21:27:57 2016
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Xilinx/Vivado/2016.3/data/ip/pentek/ip/px_axis_pwr_meter/px_axis_pwr_meter.srcs/sources_1/ip/px_pwr_meter_accum/px_pwr_meter_accum_stub.v
// Design      : px_pwr_meter_accum
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "c_accum_v12_0_10,Vivado 2016.3" *)
module px_pwr_meter_accum(B, CLK, CE, BYPASS, Q)
/* synthesis syn_black_box black_box_pad_pin="B[32:0],CLK,CE,BYPASS,Q[35:0]" */;
  input [32:0]B;
  input CLK;
  input CE;
  input BYPASS;
  output [35:0]Q;
endmodule
