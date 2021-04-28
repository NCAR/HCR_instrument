// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
// Date        : Fri Apr 16 23:22:25 2021
// Host        : wind running 64-bit unknown
// Command     : write_verilog -force -mode synth_stub
//               /home/karboski/git/HCR_instrument/src/Pentek821/FDK/2017.2/p71821_060/p71821.srcs/sources_1/bd/user_block2/ip/user_block2_pulse_fir_0_1/user_block2_pulse_fir_0_1_stub.v
// Design      : user_block2_pulse_fir_0_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fir_compiler_v7_2_8,Vivado 2017.2" *)
module user_block2_pulse_fir_0_1(aresetn, aclk, s_axis_data_tvalid, 
  s_axis_data_tready, s_axis_data_tuser, s_axis_data_tdata, s_axis_config_tvalid, 
  s_axis_config_tready, s_axis_config_tdata, s_axis_reload_tvalid, s_axis_reload_tready, 
  s_axis_reload_tlast, s_axis_reload_tdata, m_axis_data_tvalid, m_axis_data_tready, 
  m_axis_data_tuser, m_axis_data_tdata, event_s_reload_tlast_missing, 
  event_s_reload_tlast_unexpected)
/* synthesis syn_black_box black_box_pad_pin="aresetn,aclk,s_axis_data_tvalid,s_axis_data_tready,s_axis_data_tuser[127:0],s_axis_data_tdata[31:0],s_axis_config_tvalid,s_axis_config_tready,s_axis_config_tdata[7:0],s_axis_reload_tvalid,s_axis_reload_tready,s_axis_reload_tlast,s_axis_reload_tdata[23:0],m_axis_data_tvalid,m_axis_data_tready,m_axis_data_tuser[127:0],m_axis_data_tdata[47:0],event_s_reload_tlast_missing,event_s_reload_tlast_unexpected" */;
  input aresetn;
  input aclk;
  input s_axis_data_tvalid;
  output s_axis_data_tready;
  input [127:0]s_axis_data_tuser;
  input [31:0]s_axis_data_tdata;
  input s_axis_config_tvalid;
  output s_axis_config_tready;
  input [7:0]s_axis_config_tdata;
  input s_axis_reload_tvalid;
  output s_axis_reload_tready;
  input s_axis_reload_tlast;
  input [23:0]s_axis_reload_tdata;
  output m_axis_data_tvalid;
  input m_axis_data_tready;
  output [127:0]m_axis_data_tuser;
  output [47:0]m_axis_data_tdata;
  output event_s_reload_tlast_missing;
  output event_s_reload_tlast_unexpected;
endmodule
