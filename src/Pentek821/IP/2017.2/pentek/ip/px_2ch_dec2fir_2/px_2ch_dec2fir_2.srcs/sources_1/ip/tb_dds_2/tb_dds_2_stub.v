// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
// Date        : Wed Jan 18 10:07:07 2017
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Pentek/IP/2016.4/wip/px_2ch_dec2fir_2/px_2ch_dec2fir_2.srcs/sources_1/ip/tb_dds_2/tb_dds_2_stub.v
// Design      : tb_dds_2
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dds_compiler_v6_0_13,Vivado 2016.4" *)
module tb_dds_2(aclk, aresetn, s_axis_phase_tvalid, 
  s_axis_phase_tdata, m_axis_data_tvalid, m_axis_data_tdata)
/* synthesis syn_black_box black_box_pad_pin="aclk,aresetn,s_axis_phase_tvalid,s_axis_phase_tdata[63:0],m_axis_data_tvalid,m_axis_data_tdata[31:0]" */;
  input aclk;
  input aresetn;
  input s_axis_phase_tvalid;
  input [63:0]s_axis_phase_tdata;
  output m_axis_data_tvalid;
  output [31:0]m_axis_data_tdata;
endmodule
