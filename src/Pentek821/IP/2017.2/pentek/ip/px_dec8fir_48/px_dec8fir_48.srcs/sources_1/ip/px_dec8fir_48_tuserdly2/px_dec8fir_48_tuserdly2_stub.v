// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
// Date        : Fri Nov 11 08:11:58 2016
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Nav/IP/2016.3/pentek/ip/px_dec8fir_48/px_dec8fir_48.srcs/sources_1/ip/px_dec8fir_48_tuserdly2/px_dec8fir_48_tuserdly2_stub.v
// Design      : px_dec8fir_48_tuserdly2
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "c_shift_ram_v12_0_10,Vivado 2016.3" *)
module px_dec8fir_48_tuserdly2(D, CLK, Q)
/* synthesis syn_black_box black_box_pad_pin="D[127:0],CLK,Q[127:0]" */;
  input [127:0]D;
  input CLK;
  output [127:0]Q;
endmodule
