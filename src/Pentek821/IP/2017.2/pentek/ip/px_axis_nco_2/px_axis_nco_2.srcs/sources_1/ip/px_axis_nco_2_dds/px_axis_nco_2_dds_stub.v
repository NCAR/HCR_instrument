// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
// Date        : Tue Dec 27 12:26:48 2016
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Pentek/IP/2016.4/wip/px_axis_nco_2/px_axis_nco_2.srcs/sources_1/ip/px_axis_nco_2_dds/px_axis_nco_2_dds_stub.v
// Design      : px_axis_nco_2_dds
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku040-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dds_compiler_v6_0_13,Vivado 2016.4" *)
module px_axis_nco_2_dds(aclk, aclken, aresetn, s_axis_phase_tvalid, 
  s_axis_phase_tdata, m_axis_data_tvalid, m_axis_data_tdata)
/* synthesis syn_black_box black_box_pad_pin="aclk,aclken,aresetn,s_axis_phase_tvalid,s_axis_phase_tdata[63:0],m_axis_data_tvalid,m_axis_data_tdata[47:0]" */;
  input aclk;
  input aclken;
  input aresetn;
  input s_axis_phase_tvalid;
  input [63:0]s_axis_phase_tdata;
  output m_axis_data_tvalid;
  output [47:0]m_axis_data_tdata;
endmodule
