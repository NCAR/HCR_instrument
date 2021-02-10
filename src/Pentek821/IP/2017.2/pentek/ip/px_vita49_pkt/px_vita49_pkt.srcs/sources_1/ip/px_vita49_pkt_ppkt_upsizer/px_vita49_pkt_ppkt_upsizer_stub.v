// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2.1 (win64) Build 1957588 Wed Aug  9 16:32:24 MDT 2017
// Date        : Thu Oct 26 16:19:12 2017
// Host        : Mike-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/pentek/ip/2017.2/wip/px_vita49_pkt/px_vita49_pkt.srcs/sources_1/ip/px_vita49_pkt_ppkt_upsizer/px_vita49_pkt_ppkt_upsizer_stub.v
// Design      : px_vita49_pkt_ppkt_upsizer
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku035-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "px_ppkt_width_upsizer,Vivado 2017.2.1" *)
module px_vita49_pkt_ppkt_upsizer(aclk, aresetn, s_axis_ppkt_tvalid, 
  s_axis_ppkt_tready, s_axis_ppkt_tdata, s_axis_ppkt_tuser, s_axis_ppkt_tkeep, 
  s_axis_ppkt_tlast, m_axis_ppkt_tvalid, m_axis_ppkt_tready, m_axis_ppkt_tdata, 
  m_axis_ppkt_tuser, m_axis_ppkt_tkeep, m_axis_ppkt_tlast)
/* synthesis syn_black_box black_box_pad_pin="aclk,aresetn,s_axis_ppkt_tvalid,s_axis_ppkt_tready,s_axis_ppkt_tdata[31:0],s_axis_ppkt_tuser[79:0],s_axis_ppkt_tkeep[1:0],s_axis_ppkt_tlast,m_axis_ppkt_tvalid,m_axis_ppkt_tready,m_axis_ppkt_tdata[255:0],m_axis_ppkt_tuser[79:0],m_axis_ppkt_tkeep[15:0],m_axis_ppkt_tlast" */;
  input aclk;
  input aresetn;
  input s_axis_ppkt_tvalid;
  output s_axis_ppkt_tready;
  input [31:0]s_axis_ppkt_tdata;
  input [79:0]s_axis_ppkt_tuser;
  input [1:0]s_axis_ppkt_tkeep;
  input s_axis_ppkt_tlast;
  output m_axis_ppkt_tvalid;
  input m_axis_ppkt_tready;
  output [255:0]m_axis_ppkt_tdata;
  output [79:0]m_axis_ppkt_tuser;
  output [15:0]m_axis_ppkt_tkeep;
  output m_axis_ppkt_tlast;
endmodule
