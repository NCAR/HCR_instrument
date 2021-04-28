// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
// Date        : Tue Apr 27 22:17:07 2021
// Host        : wind running 64-bit unknown
// Command     : write_verilog -force -mode funcsim
//               /home/karboski/git/HCR_instrument/src/Pentek821/FDK/2017.2/p71821_060/p71821.srcs/sources_1/bd/user_block2/ip/user_block2_enable_mux_0_2/user_block2_enable_mux_0_2_sim_netlist.v
// Design      : user_block2_enable_mux_0_2
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "user_block2_enable_mux_0_2,enable_mux,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "enable_mux,Vivado 2017.2" *) 
(* NotValidForBitStream *)
module user_block2_enable_mux_0_2
   (EN,
    I,
    O);
  input EN;
  input [7:0]I;
  output [7:0]O;

  wire EN;
  wire [7:0]I;
  wire [7:0]O;

  LUT2 #(
    .INIT(4'h8)) 
    \O[0]_INST_0 
       (.I0(EN),
        .I1(I[0]),
        .O(O[0]));
  LUT2 #(
    .INIT(4'h8)) 
    \O[1]_INST_0 
       (.I0(EN),
        .I1(I[1]),
        .O(O[1]));
  LUT2 #(
    .INIT(4'h8)) 
    \O[2]_INST_0 
       (.I0(EN),
        .I1(I[2]),
        .O(O[2]));
  LUT2 #(
    .INIT(4'h8)) 
    \O[3]_INST_0 
       (.I0(EN),
        .I1(I[3]),
        .O(O[3]));
  LUT2 #(
    .INIT(4'h8)) 
    \O[4]_INST_0 
       (.I0(EN),
        .I1(I[4]),
        .O(O[4]));
  LUT2 #(
    .INIT(4'h8)) 
    \O[5]_INST_0 
       (.I0(EN),
        .I1(I[5]),
        .O(O[5]));
  LUT2 #(
    .INIT(4'h8)) 
    \O[6]_INST_0 
       (.I0(EN),
        .I1(I[6]),
        .O(O[6]));
  LUT2 #(
    .INIT(4'h8)) 
    \O[7]_INST_0 
       (.I0(EN),
        .I1(I[7]),
        .O(O[7]));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
