// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
// Date        : Fri Apr 16 23:23:01 2021
// Host        : wind running 64-bit unknown
// Command     : write_verilog -force -mode synth_stub
//               /home/karboski/git/HCR_instrument/src/Pentek821/FDK/2017.2/p71821_060/p71821.srcs/sources_1/bd/user_block2/ip/user_block2_irq_placeholder_0/user_block2_irq_placeholder_0_stub.v
// Design      : user_block2_irq_placeholder_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "xlconstant_v1_1_3_xlconstant,Vivado 2017.2" *)
module user_block2_irq_placeholder_0(dout)
/* synthesis syn_black_box black_box_pad_pin="dout[1:0]" */;
  output [1:0]dout;
endmodule
