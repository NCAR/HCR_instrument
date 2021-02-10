// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
// Date        : Thu Nov 10 13:17:45 2016
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Nav/IP/2016.3/pentek/ip/px_test_sig_gen_48/px_test_sig_gen_48.srcs/sources_1/ip/px_test_sig_gen48_dds/px_test_sig_gen48_dds_stub.v
// Design      : px_test_sig_gen48_dds
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dds_compiler_v6_0_13,Vivado 2016.3" *)
module px_test_sig_gen48_dds(aclk, aclken, aresetn, s_axis_phase_tvalid, 
  s_axis_phase_tdata, m_axis_data_tvalid, m_axis_data_tdata)
/* synthesis syn_black_box black_box_pad_pin="aclk,aclken,aresetn,s_axis_phase_tvalid,s_axis_phase_tdata[63:0],m_axis_data_tvalid,m_axis_data_tdata[15:0]" */;
  input aclk;
  input aclken;
  input aresetn;
  input s_axis_phase_tvalid;
  input [63:0]s_axis_phase_tdata;
  output m_axis_data_tvalid;
  output [15:0]m_axis_data_tdata;
endmodule
