// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
// Date        : Tue Nov 01 21:27:58 2016
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Xilinx/Vivado/2016.3/data/ip/pentek/ip/px_axis_pwr_meter/px_axis_pwr_meter.srcs/sources_1/ip/px_pwr_meter_1mk_sub/px_pwr_meter_1mk_sub_sim_netlist.v
// Design      : px_pwr_meter_1mk_sub
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_pwr_meter_1mk_sub,c_addsub_v12_0_10,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_addsub_v12_0_10,Vivado 2016.3" *) 
(* NotValidForBitStream *)
module px_pwr_meter_1mk_sub
   (A,
    B,
    CLK,
    S);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) input [16:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) input [16:0]B;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 s_intf DATA" *) output [16:0]S;

  wire [16:0]A;
  wire [16:0]B;
  wire CLK;
  wire [16:0]S;
  wire NLW_U0_C_OUT_UNCONNECTED;

  (* C_ADD_MODE = "1" *) 
  (* C_AINIT_VAL = "0" *) 
  (* C_A_TYPE = "1" *) 
  (* C_A_WIDTH = "17" *) 
  (* C_BORROW_LOW = "1" *) 
  (* C_BYPASS_LOW = "0" *) 
  (* C_B_CONSTANT = "0" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "00000000000000000" *) 
  (* C_B_WIDTH = "17" *) 
  (* C_CE_OVERRIDES_BYPASS = "1" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_BYPASS = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_C_IN = "0" *) 
  (* C_HAS_C_OUT = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "1" *) 
  (* C_LATENCY = "2" *) 
  (* C_OUT_WIDTH = "17" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_pwr_meter_1mk_sub_c_addsub_v12_0_10 U0
       (.A(A),
        .ADD(1'b1),
        .B(B),
        .BYPASS(1'b0),
        .CE(1'b1),
        .CLK(CLK),
        .C_IN(1'b0),
        .C_OUT(NLW_U0_C_OUT_UNCONNECTED),
        .S(S),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule

(* C_ADD_MODE = "1" *) (* C_AINIT_VAL = "0" *) (* C_A_TYPE = "1" *) 
(* C_A_WIDTH = "17" *) (* C_BORROW_LOW = "1" *) (* C_BYPASS_LOW = "0" *) 
(* C_B_CONSTANT = "0" *) (* C_B_TYPE = "1" *) (* C_B_VALUE = "00000000000000000" *) 
(* C_B_WIDTH = "17" *) (* C_CE_OVERRIDES_BYPASS = "1" *) (* C_CE_OVERRIDES_SCLR = "0" *) 
(* C_HAS_BYPASS = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_C_IN = "0" *) 
(* C_HAS_C_OUT = "0" *) (* C_HAS_SCLR = "0" *) (* C_HAS_SINIT = "0" *) 
(* C_HAS_SSET = "0" *) (* C_IMPLEMENTATION = "1" *) (* C_LATENCY = "2" *) 
(* C_OUT_WIDTH = "17" *) (* C_SCLR_OVERRIDES_SSET = "1" *) (* C_SINIT_VAL = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) (* ORIG_REF_NAME = "c_addsub_v12_0_10" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module px_pwr_meter_1mk_sub_c_addsub_v12_0_10
   (A,
    B,
    CLK,
    ADD,
    C_IN,
    CE,
    BYPASS,
    SCLR,
    SSET,
    SINIT,
    C_OUT,
    S);
  input [16:0]A;
  input [16:0]B;
  input CLK;
  input ADD;
  input C_IN;
  input CE;
  input BYPASS;
  input SCLR;
  input SSET;
  input SINIT;
  output C_OUT;
  output [16:0]S;

  wire \<const0> ;
  wire [16:0]A;
  wire ADD;
  wire [16:0]B;
  wire CLK;
  wire [16:0]S;
  wire NLW_xst_addsub_C_OUT_UNCONNECTED;

  assign C_OUT = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_ADD_MODE = "1" *) 
  (* C_AINIT_VAL = "0" *) 
  (* C_A_TYPE = "1" *) 
  (* C_A_WIDTH = "17" *) 
  (* C_BORROW_LOW = "1" *) 
  (* C_BYPASS_LOW = "0" *) 
  (* C_B_CONSTANT = "0" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "00000000000000000" *) 
  (* C_B_WIDTH = "17" *) 
  (* C_CE_OVERRIDES_BYPASS = "1" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_BYPASS = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_C_IN = "0" *) 
  (* C_HAS_C_OUT = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "1" *) 
  (* C_LATENCY = "2" *) 
  (* C_OUT_WIDTH = "17" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_pwr_meter_1mk_sub_c_addsub_v12_0_10_viv xst_addsub
       (.A(A),
        .ADD(ADD),
        .B(B),
        .BYPASS(1'b0),
        .CE(1'b0),
        .CLK(CLK),
        .C_IN(1'b0),
        .C_OUT(NLW_xst_addsub_C_OUT_UNCONNECTED),
        .S(S),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
EgsHeoOxdUxsX5gIKiaj0rabVidhYZrAC1ccO7uW1WWUY+5F26NMKfuRo2RbzpHAhKg6YWmehafX
vTPGaJRKHw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
Z34YzyhCkqWVBd+wfHLLkUW/H60lDZ7DBcaAzQK4qK/8LgoJdsH6DZ43BtKjfZhNz/T8CrFXpTq4
lXACmrJsvh8DNPmvB7LaQhnP9Q1UWB/2BUP3fAUHMA2d2pKOqEj3XF5pbikvIPiyQENN7Kn513bC
CvwAQIx2bzxkiYX1MZc=

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
SSMUY5NrZw2M/7w7U4gsSjNRmWfRCxfALTKD8+8C1h91c8RWo9X4x7A5m9YG0Pa491k6Lxf7I0eD
goajxjfLKNI+buWpvfZlHEcU7678iPGqz4g94c5n80sa3TKcwpV6f+p7C93Rto4JgUHSigA3gLBN
DzpD+6xOS6P2mkrRsQs=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Tbb//X7l5IJljgHR/Q0swC7OpOr9LwQv6rxLgPXOMJNm5TebIkTTeQKZBlg96/x0gqqgFX19ZASr
qWxh3YL/aoYejZTUMHYF7ktggRgHydykFFfRo8xGrq33bJ1LOeuIQOZyZjZTB9zCoo8CMX8wCtcA
0ovBA4GCY5VFNLy/1whSrZs8R7CLSdrlxUJTTCXjF0f+Tf8OyjSS2VGyZfJbmSNnFJJuItoBbUO0
6qdcZfL3eQrA6y/AWPiFhGILWhBAvVGEahvuOHYDa8S1IUccHMOxQJtq0Y1UqRNB/qNmlHUKL/iH
IEr89vPUXnsfHTV4I+xFieSKz2LwzLXsAys4Yw==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kfJNFYIhzZvlPwb4KI2aCH6Fx40tZkxF1Q5EfJSPdq2JohdV53Dn2x9HbgUIqvISu5UuFwT8R+oV
/B66+AOKivg+iSCvhh+HSv/oQNtgHeIG5xMgV8d3jXD9G4abV/g3jySuWrjXT9Z0IqvTQjqmKOR2
9nVDANRSJiSyM0Y275L4ylvrdjL8Yim0M/e9k+N+kNYfcQAzQYd/lfTmcdkn74/0qt030HQ2LxSy
A+NwqYXBuB4VkkCPvigd/s63XQNHxeHfRZs7q0iWos8Jgu9uI1zA6ZN4O4Cts2V9BF+SRqJdzrLy
1t5mzK/i0gmdsb8ds3y4b3AMet8PeT7w9sZc/A==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinx_2016_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
MzDVqgEdc7DZdlm2cItrUQlry/9kVuVoApPpWX7zga11t+tLgAqain8Fhjl9Q1hFV6Rwv6WUUyOW
dL6uK1Pj4Tc0mqHyEMvAW2tHA/QcK0pphBofEd8Sd2oRBJ0l+XghTz/o5eIVzoxDF0h6fERIgAw6
PZK1iaI5d5osnKGqaJVhxQWf/M3XiOn9jCOGskyvtqNiiXNki/oAWPJNgm3Hb599C3ugMxNKGT5x
H76UXyZbcrmrFSkYz6XydewUEOb2eruDdZtf4QmJWyJ+WqAHgjSB7kcn3UfysW1iW59u7oxSpMgU
oLKWKFtXGSzN2+DVJ91qu7hIDmX5Q2X//JK4Cg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
ICrf1/A4UMaTrE+eaib8CdWKeZdCduWwN/fdYnA8PPiYpcX6n0qdKOWYKCsVvySfb+yFMdq27N+P
YydhF7WEYReqieG7lbwxlXCgRNfRZa3zBbSCxwV48Al0gL2dYynyCsvLLw+TRhIIRsBIfN2GLRKH
SY6ufzYhEJmWE+FoNsA4FW3nJk8Q9I0l33k15vHXQpbH8vO/rxOYL0O3YvqjtkSZ+s28M3jQcNfN
l/ljHlnFEwYUmvGw6Xp39KsuIzz6JAcf3MFLC9no9vf37r3l1KsjBX16ZI3OO8GZ9WKjems2uwGX
Ef26VFltL4l9jPWh+aLC88akYJES4PbWnxDlqg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
VH9F1YWxLQsRXAyfKNwXa2cNZn5SlFKFBBJhoAcVMhzvVGqqrgK1W+tkXc/QWxYoeC9967z8EOZm
oX/bCKVUddFSqjIFZSymui4UdDt5kJZd9Ilbecmj2Ba6tJ1WcZz/OHeSnEqqpo9CJNlLo6ij4UW1
J8job3UJHTlhocqU4IS/840ocLz4iMdB39CgvSUqV7wNxHu7cAVe194UUgRmuOJZEXZchpbGWH/k
mISdI7eCBReVbB/937u9zfFYo57dnakwM6HLEpsMZ3qoo7ohWt2av4yyS6pNAWFIA8M7QZWE11Ud
9KrLScNijnurFTHZfk06DcjiKy1PGFZFuMsmYA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 12656)
`pragma protect data_block
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
EFg=
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
