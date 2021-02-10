// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2.1 (win64) Build 1957588 Wed Aug  9 16:32:24 MDT 2017
// Date        : Mon Oct 23 15:07:52 2017
// Host        : Mike-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/pentek/ip/2017.2/wip/px_10ge_udp_rx/px_10ge_udp_rx.srcs/sources_1/ip/px_10ge_udp_rx_px_bus_sync/px_10ge_udp_rx_px_bus_sync_stub.v
// Design      : px_10ge_udp_rx_px_bus_sync
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "px_xpm_cdc_bus_sync,Vivado 2017.2.1" *)
module px_10ge_udp_rx_px_bus_sync(src_clk, src_in, dest_clk, dest_out)
/* synthesis syn_black_box black_box_pad_pin="src_clk,src_in[31:0],dest_clk,dest_out[31:0]" */;
  input src_clk;
  input [31:0]src_in;
  input dest_clk;
  output [31:0]dest_out;
endmodule
