// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2.1 (win64) Build 1957588 Wed Aug  9 16:32:24 MDT 2017
// Date        : Thu Oct 26 16:20:11 2017
// Host        : Mike-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/pentek/ip/2017.2/wip/px_vita49_pkt/px_vita49_pkt.srcs/sources_1/ip/px_vita49_pkt_payload_fifo/px_vita49_pkt_payload_fifo_stub.v
// Design      : px_vita49_pkt_payload_fifo
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku035-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_1_4,Vivado 2017.2.1" *)
module px_vita49_pkt_payload_fifo(s_aclk, s_aresetn, s_axis_tvalid, 
  s_axis_tready, s_axis_tdata, s_axis_tkeep, s_axis_tlast, s_axis_tuser, m_axis_tvalid, 
  m_axis_tready, m_axis_tdata, m_axis_tkeep, m_axis_tlast, m_axis_tuser, axis_data_count)
/* synthesis syn_black_box black_box_pad_pin="s_aclk,s_aresetn,s_axis_tvalid,s_axis_tready,s_axis_tdata[255:0],s_axis_tkeep[31:0],s_axis_tlast,s_axis_tuser[79:0],m_axis_tvalid,m_axis_tready,m_axis_tdata[255:0],m_axis_tkeep[31:0],m_axis_tlast,m_axis_tuser[79:0],axis_data_count[12:0]" */;
  input s_aclk;
  input s_aresetn;
  input s_axis_tvalid;
  output s_axis_tready;
  input [255:0]s_axis_tdata;
  input [31:0]s_axis_tkeep;
  input s_axis_tlast;
  input [79:0]s_axis_tuser;
  output m_axis_tvalid;
  input m_axis_tready;
  output [255:0]m_axis_tdata;
  output [31:0]m_axis_tkeep;
  output m_axis_tlast;
  output [79:0]m_axis_tuser;
  output [12:0]axis_data_count;
endmodule
