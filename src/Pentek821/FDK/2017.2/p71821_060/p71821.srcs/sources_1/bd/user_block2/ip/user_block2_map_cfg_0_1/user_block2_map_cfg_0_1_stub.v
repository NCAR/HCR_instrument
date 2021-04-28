// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
// Date        : Fri Apr 16 23:21:39 2021
// Host        : wind running 64-bit unknown
// Command     : write_verilog -force -mode synth_stub
//               /home/karboski/git/HCR_instrument/src/Pentek821/FDK/2017.2/p71821_060/p71821.srcs/sources_1/bd/user_block2/ip/user_block2_map_cfg_0_1/user_block2_map_cfg_0_1_stub.v
// Design      : user_block2_map_cfg_0_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "top_user_block2_map_cfg_0_1,Vivado 2017.2" *)
module user_block2_map_cfg_0_1(aclk, aresetn, s_axis_tvalid, s_axis_tready, 
  s_axis_tdata, s_axis_tuser, m_axis_tvalid, m_axis_tready, m_axis_tdata)
/* synthesis syn_black_box black_box_pad_pin="aclk,aresetn,s_axis_tvalid,s_axis_tready,s_axis_tdata[31:0],s_axis_tuser[127:0],m_axis_tvalid,m_axis_tready,m_axis_tdata[7:0]" */;
  input aclk;
  input aresetn;
  input s_axis_tvalid;
  output s_axis_tready;
  input [31:0]s_axis_tdata;
  input [127:0]s_axis_tuser;
  output m_axis_tvalid;
  input m_axis_tready;
  output [7:0]m_axis_tdata;
endmodule
