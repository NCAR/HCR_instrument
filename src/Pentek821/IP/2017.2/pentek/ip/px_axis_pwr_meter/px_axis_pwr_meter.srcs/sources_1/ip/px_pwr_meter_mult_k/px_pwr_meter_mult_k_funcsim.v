// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.1 (win64) Build 1215546 Mon Apr 27 19:22:08 MDT 2015
// Date        : Sat May 16 15:35:18 2015
// Host        : Igor running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim
//               e:/px_ip/px_axis_pwr_meter/px_axis_pwr_meter.srcs/sources_1/ip/px_pwr_meter_mult_k/px_pwr_meter_mult_k_funcsim.v
// Design      : px_pwr_meter_mult_k
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_pwr_meter_mult_k,mult_gen_v12_0,{}" *) (* core_generation_info = "px_pwr_meter_mult_k,mult_gen_v12_0,{x_ipProduct=Vivado 2015.1,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=mult_gen,x_ipVersion=12.0,x_ipCoreRevision=7,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED,C_VERBOSITY=0,C_MODEL_TYPE=0,C_OPTIMIZE_GOAL=1,C_XDEVICEFAMILY=kintexu,C_HAS_CE=0,C_HAS_SCLR=0,C_LATENCY=4,C_A_WIDTH=32,C_A_TYPE=1,C_B_WIDTH=17,C_B_TYPE=1,C_OUT_HIGH=48,C_OUT_LOW=2,C_MULT_TYPE=1,C_CE_OVERRIDES_SCLR=0,C_CCM_IMP=0,C_B_VALUE=10000001,C_HAS_ZERO_DETECT=0,C_ROUND_OUTPUT=0,C_ROUND_PT=0}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* x_core_info = "mult_gen_v12_0,Vivado 2015.1" *) 
(* NotValidForBitStream *)
module px_pwr_meter_mult_k
   (CLK,
    A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) input [31:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) input [16:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) output [46:0]P;

  wire [31:0]A;
  wire [16:0]B;
  wire CLK;
  wire [46:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "1" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "17" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "4" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "48" *) 
  (* C_OUT_LOW = "2" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* DONT_TOUCH *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_pwr_meter_mult_k_mult_gen_v12_0 U0
       (.A(A),
        .B(B),
        .CE(1'b1),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule

(* C_A_TYPE = "1" *) (* C_A_WIDTH = "32" *) (* C_B_TYPE = "1" *) 
(* C_B_VALUE = "10000001" *) (* C_B_WIDTH = "17" *) (* C_CCM_IMP = "0" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_LATENCY = "4" *) (* C_MODEL_TYPE = "0" *) 
(* C_MULT_TYPE = "1" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "48" *) 
(* C_OUT_LOW = "2" *) (* C_ROUND_OUTPUT = "0" *) (* C_ROUND_PT = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) (* ORIG_REF_NAME = "mult_gen_v12_0" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module px_pwr_meter_mult_k_mult_gen_v12_0
   (CLK,
    A,
    B,
    CE,
    SCLR,
    ZERO_DETECT,
    P,
    PCASC);
  input CLK;
  input [31:0]A;
  input [16:0]B;
  input CE;
  input SCLR;
  output [1:0]ZERO_DETECT;
  output [46:0]P;
  output [47:0]PCASC;

  wire [31:0]A;
  wire [16:0]B;
  wire CE;
  wire CLK;
  wire [46:0]P;
  wire [47:0]PCASC;
  wire SCLR;
  wire [1:0]ZERO_DETECT;

  (* C_A_TYPE = "1" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "17" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "4" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "48" *) 
  (* C_OUT_LOW = "2" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_pwr_meter_mult_k_mult_gen_v12_0_viv i_mult
       (.A(A),
        .B(B),
        .CE(CE),
        .CLK(CLK),
        .P(P),
        .PCASC(PCASC),
        .SCLR(SCLR),
        .ZERO_DETECT(ZERO_DETECT));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2014"
`pragma protect key_keyowner = "Cadence Design Systems.", key_keyname= "cds_rsa_key", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 64)
`pragma protect key_block
FE74Lr97VmP2+Ez4rVovbpvB4Vynb7rIpzp8VfQztGnoDYQhPydTGw7yfEWSM5wxHTELmoJ2e0kg
nyVOAJOzGQ==


`pragma protect key_keyowner = "Mentor Graphics Corporation", key_keyname= "MGC-VERIF-SIM-RSA-1", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 128)
`pragma protect key_block
UnafVlLwmVqAgDqs5BDZxTsO5Qw7Nz7T9DxPoDF0yCGyYUDPhiDs1mqI3Qg4QkYIJp5yYFsGIAAO
pUYs/IY/A44uoTsDTNaGtZoBJ1v68kJEgigV/osFZXpEcDoqag3/4JvCEpkiquflbTFnocW307r8
0cE640p4GyvyHA08QzM=


`pragma protect key_keyowner = "Xilinx", key_keyname= "xilinx_2014_03", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
rfFLFKH82qRgMOK8+SSf05H2LmUnOQNDMOMMTrDokVNnoH3TrlXrFkRE/tLuqVI87gD38MoU0OsY
2vyjubJ+yK3fH69lUPsWYfAvtU2GYCn9lQxnDlilq3K9JTZOQlARVDCUJs7zKijxylKCQ9T4aeOy
qWSJQf7IY72ND0QmI4tbkWjY9UVdTMA0mNgfU1R3/x2b+5MxrvnivC5O40ApLlsTZJdrxk3CKVg9
w6j++2bBkF8pDTv4uJYJhQDDIIu6T25xOKZAldxd+F/YHif5qz+3kDBbZJwHloxlDIRuvoJ/Q10X
fAIvL1Bfmd7z81oSb2W1AQyE68hf98QRc+yt6g==


`pragma protect key_keyowner = "Synopsys", key_keyname= "SNPS-VCS-RSA-1", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 128)
`pragma protect key_block
K3+UOwlCwx3t7FyQuvXVOuOLSf79w8H29kYesB4t4ENU7w/cJ+3jINJp3g7+Mw/l3pow2eggqoBf
iR2wVOlrGRDgOMdP5om5gBbx5l7eLztB5Wu7TXxa4iclWrFOSPWLp1OuF5oKGeVz6IS+D0PiG82m
GJDW36qBP5Bj/b1u1ME=


`pragma protect key_keyowner = "Aldec", key_keyname= "ALDEC08_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
EXT8uDkmRcpwbfGuT5uQLCxfBwgkoXSHlzuXgPMCFUCzus9PnTSCzAm+w4+DWFCWCKofiwIYxjX+
VhvGm4jvvVmlHHmdFjkFfHf9tcT47/Qv+MNlvS1uDLyBUnKJFHfof6DVosv9docWZkjQVvvv54/h
+XjrqvpRF6uRIWJessijQgbJ5Riby6fuu5/Gao0iUQ2fUgTF8lCA3xgAXbv5+Cl5eccDmIQV/Bf+
5e2BleBP1Ac9mgOEQoT10lCrnCOifjRNdLGfLyIA4INjmFyVhYX2slSsAPtjU7fa3zGD5KNICn/M
bA66q2PSTKNLTr4xOU/9HIDRXVIaPzR1uLrkDg==


`pragma protect key_keyowner = "Mentor Graphics Corporation", key_keyname= "MGC-PREC-RSA", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
d719d+Qm0U3MvI+jUtQX5DepSzWVIPKu18gAO4fo4kRM1SaBxaRHjTvPHMDQFYlgBtYiFWL4v9oX
l9Tc4I+Qc1uU4ERajLHwqiAW76xx4WpLI7dJ3S8CSPNo3YFnLHMfgpxtJ5vn7GgFnIqKrLcFClhU
0UOBU9cgh5Mns0vWIp1bujZ1zNiBeil+gLa9YKTdkHfrSrbObcDpPBs7D0NgVnskpxf0KPRtp2N5
tbnig+KIfcta+2Nt467L6xJj3OMIOU7gqxIPYffQv9aaPfDneV0zcrOFlmV03eIWx6SUZXmTnz2t
VmANf9G+TkrOGFE1XjF28qCEytSZAX29YYr/xg==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
Pal4udkf5z2K1D+1oBqmTcx2Oztcekk/yjKEPUVrJli3x8+PTVsFv3SbNkG5+gmyTqFgklNGOWLe
HOZoN06HF22H1EpgJO62/kUTl9EVkESIufq1NWLUM32um7Y8/Kq7f80YBi1TeaqRLECoPjloONjt
jobe+J7okBNag29m2807VGo1TqBzn/1rjnj7fwxluFK6DGEuUvvtJYPtJ/E3xgLXrHVIC5sfq7oG
5mv0/Gy2mn7vlNU+c3QMlhKoeUen8m4z4DRhXo2nRtgSDyfGraD8vWqsXmg9A6ZlZkH2G9eOUV+p
BRhlHFh/JUqR7QK+T3LTf5VzOxJ8u1qoyTMTQw==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 20272)
`pragma protect data_block
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
`pragma protect end_protected
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

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
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
