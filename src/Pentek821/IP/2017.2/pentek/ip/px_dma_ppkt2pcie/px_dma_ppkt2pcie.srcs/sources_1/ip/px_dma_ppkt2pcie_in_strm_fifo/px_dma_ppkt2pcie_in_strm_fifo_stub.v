// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.4 (win64) Build 1412921 Wed Nov 18 09:43:45 MST 2015
// Date        : Fri Feb 05 10:20:01 2016
// Host        : Rich-PC running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               C:/Xilinx/Vivado/2015.4/data/ip/pentek/px_dma_ppkt2pcie/px_dma_ppkt2pcie.srcs/sources_1/ip/px_dma_ppkt2pcie_in_strm_fifo/px_dma_ppkt2pcie_in_strm_fifo_stub.v
// Design      : px_dma_ppkt2pcie_in_strm_fifo
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1517-2-e-es2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_0_1,Vivado 2015.4" *)
module px_dma_ppkt2pcie_in_strm_fifo(m_aclk, s_aclk, s_aresetn, s_axis_tvalid, s_axis_tready, s_axis_tdata, s_axis_tlast, s_axis_tuser, m_axis_tvalid, m_axis_tready, m_axis_tdata, m_axis_tlast, m_axis_tuser, axis_prog_full)
/* synthesis syn_black_box black_box_pad_pin="m_aclk,s_aclk,s_aresetn,s_axis_tvalid,s_axis_tready,s_axis_tdata[511:0],s_axis_tlast,s_axis_tuser[87:0],m_axis_tvalid,m_axis_tready,m_axis_tdata[511:0],m_axis_tlast,m_axis_tuser[87:0],axis_prog_full" */;
  input m_aclk;
  input s_aclk;
  input s_aresetn;
  input s_axis_tvalid;
  output s_axis_tready;
  input [511:0]s_axis_tdata;
  input s_axis_tlast;
  input [87:0]s_axis_tuser;
  output m_axis_tvalid;
  input m_axis_tready;
  output [511:0]m_axis_tdata;
  output m_axis_tlast;
  output [87:0]m_axis_tuser;
  output axis_prog_full;
endmodule
