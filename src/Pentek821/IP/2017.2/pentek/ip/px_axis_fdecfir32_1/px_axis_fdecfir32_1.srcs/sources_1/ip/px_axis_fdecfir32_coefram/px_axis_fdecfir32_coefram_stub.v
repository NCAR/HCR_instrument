// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
// Date        : Wed Dec 28 22:47:54 2016
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Pentek/IP/2016.3/pentek/ip/px_axis_fdecfir32_1/px_axis_fdecfir32_1.srcs/sources_1/ip/px_axis_fdecfir32_coefram/px_axis_fdecfir32_coefram_stub.v
// Design      : px_axis_fdecfir32_coefram
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_11,Vivado 2016.3" *)
module px_axis_fdecfir32_coefram(a, d, dpra, clk, we, qdpo_ce, qdpo_clk, qdpo)
/* synthesis syn_black_box black_box_pad_pin="a[4:0],d[17:0],dpra[4:0],clk,we,qdpo_ce,qdpo_clk,qdpo[17:0]" */;
  input [4:0]a;
  input [17:0]d;
  input [4:0]dpra;
  input clk;
  input we;
  input qdpo_ce;
  input qdpo_clk;
  output [17:0]qdpo;
endmodule
