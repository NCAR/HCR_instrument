// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
// Date        : Mon Apr 26 16:12:18 2021
// Host        : wind running 64-bit unknown
// Command     : write_verilog -force -mode synth_stub
//               /home/karboski/git/HCR_instrument/src/Pentek821/FDK/2017.2/p71821_060/p71821.srcs/sources_1/bd/user_block2/ip/user_block2_position_encoder_0_0/user_block2_position_encoder_0_0_stub.v
// Design      : user_block2_position_encoder_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "position_encoder,Vivado 2017.2" *)
module user_block2_position_encoder_0_0(aclk, aresetn, ctl_reg, ROT_A, ROT_B, TILT_A, TILT_B, 
  AZ_MOSI, AZ_SCK, AZ_SSEL, EL_MOSI, EL_SCK, EL_SSEL, pos_enc_0, pos_enc_1)
/* synthesis syn_black_box black_box_pad_pin="aclk,aresetn,ctl_reg[31:0],ROT_A,ROT_B,TILT_A,TILT_B,AZ_MOSI,AZ_SCK,AZ_SSEL,EL_MOSI,EL_SCK,EL_SSEL,pos_enc_0[31:0],pos_enc_1[31:0]" */;
  input aclk;
  input aresetn;
  input [31:0]ctl_reg;
  input ROT_A;
  input ROT_B;
  input TILT_A;
  input TILT_B;
  input AZ_MOSI;
  input AZ_SCK;
  input AZ_SSEL;
  input EL_MOSI;
  input EL_SCK;
  input EL_SSEL;
  output [31:0]pos_enc_0;
  output [31:0]pos_enc_1;
endmodule
