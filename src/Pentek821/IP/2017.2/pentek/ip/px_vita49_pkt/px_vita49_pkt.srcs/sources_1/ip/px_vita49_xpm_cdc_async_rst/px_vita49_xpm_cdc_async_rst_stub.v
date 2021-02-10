// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2.1 (win64) Build 1957588 Wed Aug  9 16:32:24 MDT 2017
// Date        : Thu Oct 26 16:19:56 2017
// Host        : Mike-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/pentek/ip/2017.2/wip/px_vita49_pkt/px_vita49_pkt.srcs/sources_1/ip/px_vita49_xpm_cdc_async_rst/px_vita49_xpm_cdc_async_rst_stub.v
// Design      : px_vita49_xpm_cdc_async_rst
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku035-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "px_xpm_cdc_async_rst,Vivado 2017.2.1" *)
module px_vita49_xpm_cdc_async_rst(dest_clk, src_arst, dest_arst)
/* synthesis syn_black_box black_box_pad_pin="dest_clk,src_arst,dest_arst" */;
  input dest_clk;
  input src_arst;
  output dest_arst;
endmodule
