// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.1 (win64) Build 1538259 Fri Apr  8 15:45:27 MDT 2016
// Date        : Thu May 05 15:21:53 2016
// Host        : Rich-PC running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               c:/Xilinx/Vivado/2016.1/data/ip/pentek/ip/px_dec8fir_48/px_dec8fir_48.srcs/sources_1/ip/fir_dec4_4i1o/fir_dec4_4i1o_stub.v
// Design      : fir_dec4_4i1o
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fir_compiler_v7_2_6,Vivado 2016.1" *)
module fir_dec4_4i1o(aclk, s_axis_data_tvalid, s_axis_data_tready, s_axis_data_tuser, s_axis_data_tdata, s_axis_config_tvalid, s_axis_config_tready, s_axis_config_tdata, m_axis_data_tvalid, m_axis_data_tuser, m_axis_data_tdata)
/* synthesis syn_black_box black_box_pad_pin="aclk,s_axis_data_tvalid,s_axis_data_tready,s_axis_data_tuser[127:0],s_axis_data_tdata[63:0],s_axis_config_tvalid,s_axis_config_tready,s_axis_config_tdata[7:0],m_axis_data_tvalid,m_axis_data_tuser[127:0],m_axis_data_tdata[15:0]" */;
  input aclk;
  input s_axis_data_tvalid;
  output s_axis_data_tready;
  input [127:0]s_axis_data_tuser;
  input [63:0]s_axis_data_tdata;
  input s_axis_config_tvalid;
  output s_axis_config_tready;
  input [7:0]s_axis_config_tdata;
  output m_axis_data_tvalid;
  output [127:0]m_axis_data_tuser;
  output [15:0]m_axis_data_tdata;
endmodule
