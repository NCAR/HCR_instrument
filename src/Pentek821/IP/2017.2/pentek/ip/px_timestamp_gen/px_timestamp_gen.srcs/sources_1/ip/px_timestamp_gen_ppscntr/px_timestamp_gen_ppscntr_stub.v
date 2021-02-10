// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
// Date        : Tue Nov 01 14:13:13 2016
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Xilinx/Vivado/2016.3/data/ip/pentek/ip/px_timestamp_gen/px_timestamp_gen.srcs/sources_1/ip/px_timestamp_gen_ppscntr/px_timestamp_gen_ppscntr_stub.v
// Design      : px_timestamp_gen_ppscntr
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "c_counter_binary_v12_0_10,Vivado 2016.3" *)
module px_timestamp_gen_ppscntr(CLK, CE, SCLR, LOAD, L, Q)
/* synthesis syn_black_box black_box_pad_pin="CLK,CE,SCLR,LOAD,L[31:0],Q[31:0]" */;
  input CLK;
  input CE;
  input SCLR;
  input LOAD;
  input [31:0]L;
  output [31:0]Q;
endmodule
