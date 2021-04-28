// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
// Date        : Tue Apr 27 22:17:19 2021
// Host        : wind running 64-bit unknown
// Command     : write_verilog -force -mode synth_stub
//               /home/karboski/git/HCR_instrument/src/Pentek821/FDK/2017.2/p71821_060/p71821.srcs/sources_1/bd/user_block2/ip/user_block2_hcr_metadata_injector_0_2/user_block2_hcr_metadata_injector_0_2_stub.v
// Design      : user_block2_hcr_metadata_injector_0_2
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "hcr_metadata_injector,Vivado 2017.2" *)
module user_block2_hcr_metadata_injector_0_2(ap_clk, ap_rst_n, ap_start, ap_done, ap_idle, 
  ap_ready, i_data_TVALID, i_data_TREADY, i_data_TDATA, i_data_TDEST, i_data_TKEEP, 
  i_data_TSTRB, i_data_TUSER, i_data_TLAST, i_data_TID, o_data_TVALID, o_data_TREADY, 
  o_data_TDATA, o_data_TDEST, o_data_TKEEP, o_data_TSTRB, o_data_TUSER, o_data_TLAST, 
  o_data_TID, pulse_metadata_V_TVALID, pulse_metadata_V_TREADY, pulse_metadata_V_TDATA, 
  pos_enc_0, pos_enc_1, flags)
/* synthesis syn_black_box black_box_pad_pin="ap_clk,ap_rst_n,ap_start,ap_done,ap_idle,ap_ready,i_data_TVALID,i_data_TREADY,i_data_TDATA[31:0],i_data_TDEST[0:0],i_data_TKEEP[3:0],i_data_TSTRB[3:0],i_data_TUSER[127:0],i_data_TLAST[0:0],i_data_TID[0:0],o_data_TVALID,o_data_TREADY,o_data_TDATA[31:0],o_data_TDEST[0:0],o_data_TKEEP[3:0],o_data_TSTRB[3:0],o_data_TUSER[127:0],o_data_TLAST[0:0],o_data_TID[0:0],pulse_metadata_V_TVALID,pulse_metadata_V_TREADY,pulse_metadata_V_TDATA[823:0],pos_enc_0[31:0],pos_enc_1[31:0],flags[15:0]" */;
  input ap_clk;
  input ap_rst_n;
  input ap_start;
  output ap_done;
  output ap_idle;
  output ap_ready;
  input i_data_TVALID;
  output i_data_TREADY;
  input [31:0]i_data_TDATA;
  input [0:0]i_data_TDEST;
  input [3:0]i_data_TKEEP;
  input [3:0]i_data_TSTRB;
  input [127:0]i_data_TUSER;
  input [0:0]i_data_TLAST;
  input [0:0]i_data_TID;
  output o_data_TVALID;
  input o_data_TREADY;
  output [31:0]o_data_TDATA;
  output [0:0]o_data_TDEST;
  output [3:0]o_data_TKEEP;
  output [3:0]o_data_TSTRB;
  output [127:0]o_data_TUSER;
  output [0:0]o_data_TLAST;
  output [0:0]o_data_TID;
  input pulse_metadata_V_TVALID;
  output pulse_metadata_V_TREADY;
  input [823:0]pulse_metadata_V_TDATA;
  input [31:0]pos_enc_0;
  input [31:0]pos_enc_1;
  input [15:0]flags;
endmodule
