// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
// Date        : Wed May 17 13:23:07 2017
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Pentek/IP/2017.1/wip/px_8ch_channelizer_ddc/px_8ch_channelizer_ddc.srcs/sources_1/ip/px_8chddcs3_accram/px_8chddcs3_accram_stub.v
// Design      : px_8chddcs3_accram
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_6,Vivado 2017.1" *)
module px_8chddcs3_accram(clka, wea, addra, dina, clkb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[2:0],dina[47:0],clkb,addrb[2:0],doutb[47:0]" */;
  input clka;
  input [0:0]wea;
  input [2:0]addra;
  input [47:0]dina;
  input clkb;
  input [2:0]addrb;
  output [47:0]doutb;
endmodule
