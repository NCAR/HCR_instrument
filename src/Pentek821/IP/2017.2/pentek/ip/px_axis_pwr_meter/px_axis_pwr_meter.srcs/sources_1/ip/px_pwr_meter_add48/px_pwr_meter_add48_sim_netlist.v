// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
// Date        : Tue Nov 01 21:27:58 2016
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Xilinx/Vivado/2016.3/data/ip/pentek/ip/px_axis_pwr_meter/px_axis_pwr_meter.srcs/sources_1/ip/px_pwr_meter_add48/px_pwr_meter_add48_sim_netlist.v
// Design      : px_pwr_meter_add48
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_pwr_meter_add48,c_addsub_v12_0_10,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_addsub_v12_0_10,Vivado 2016.3" *) 
(* NotValidForBitStream *)
module px_pwr_meter_add48
   (A,
    B,
    CLK,
    SCLR,
    S);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) input [46:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) input [46:0]B;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclr_intf RST" *) input SCLR;
  (* x_interface_info = "xilinx.com:signal:data:1.0 s_intf DATA" *) output [46:0]S;

  wire [46:0]A;
  wire [46:0]B;
  wire CLK;
  wire [46:0]S;
  wire SCLR;
  wire NLW_U0_C_OUT_UNCONNECTED;

  (* C_ADD_MODE = "0" *) 
  (* C_AINIT_VAL = "0" *) 
  (* C_A_TYPE = "1" *) 
  (* C_A_WIDTH = "47" *) 
  (* C_BORROW_LOW = "1" *) 
  (* C_BYPASS_LOW = "0" *) 
  (* C_B_CONSTANT = "0" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "00000000000000000000000000000000000000000000000" *) 
  (* C_B_WIDTH = "47" *) 
  (* C_CE_OVERRIDES_BYPASS = "1" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_BYPASS = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_C_IN = "0" *) 
  (* C_HAS_C_OUT = "0" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "1" *) 
  (* C_LATENCY = "2" *) 
  (* C_OUT_WIDTH = "47" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_pwr_meter_add48_c_addsub_v12_0_10 U0
       (.A(A),
        .ADD(1'b1),
        .B(B),
        .BYPASS(1'b0),
        .CE(1'b1),
        .CLK(CLK),
        .C_IN(1'b0),
        .C_OUT(NLW_U0_C_OUT_UNCONNECTED),
        .S(S),
        .SCLR(SCLR),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule

(* C_ADD_MODE = "0" *) (* C_AINIT_VAL = "0" *) (* C_A_TYPE = "1" *) 
(* C_A_WIDTH = "47" *) (* C_BORROW_LOW = "1" *) (* C_BYPASS_LOW = "0" *) 
(* C_B_CONSTANT = "0" *) (* C_B_TYPE = "1" *) (* C_B_VALUE = "00000000000000000000000000000000000000000000000" *) 
(* C_B_WIDTH = "47" *) (* C_CE_OVERRIDES_BYPASS = "1" *) (* C_CE_OVERRIDES_SCLR = "0" *) 
(* C_HAS_BYPASS = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_C_IN = "0" *) 
(* C_HAS_C_OUT = "0" *) (* C_HAS_SCLR = "1" *) (* C_HAS_SINIT = "0" *) 
(* C_HAS_SSET = "0" *) (* C_IMPLEMENTATION = "1" *) (* C_LATENCY = "2" *) 
(* C_OUT_WIDTH = "47" *) (* C_SCLR_OVERRIDES_SSET = "1" *) (* C_SINIT_VAL = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) (* ORIG_REF_NAME = "c_addsub_v12_0_10" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module px_pwr_meter_add48_c_addsub_v12_0_10
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
  input [46:0]A;
  input [46:0]B;
  input CLK;
  input ADD;
  input C_IN;
  input CE;
  input BYPASS;
  input SCLR;
  input SSET;
  input SINIT;
  output C_OUT;
  output [46:0]S;

  wire \<const0> ;
  wire [46:0]A;
  wire ADD;
  wire [46:0]B;
  wire CLK;
  wire [46:0]S;
  wire SCLR;
  wire NLW_xst_addsub_C_OUT_UNCONNECTED;

  assign C_OUT = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_ADD_MODE = "0" *) 
  (* C_AINIT_VAL = "0" *) 
  (* C_A_TYPE = "1" *) 
  (* C_A_WIDTH = "47" *) 
  (* C_BORROW_LOW = "1" *) 
  (* C_BYPASS_LOW = "0" *) 
  (* C_B_CONSTANT = "0" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "00000000000000000000000000000000000000000000000" *) 
  (* C_B_WIDTH = "47" *) 
  (* C_CE_OVERRIDES_BYPASS = "1" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_BYPASS = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_C_IN = "0" *) 
  (* C_HAS_C_OUT = "0" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "1" *) 
  (* C_LATENCY = "2" *) 
  (* C_OUT_WIDTH = "47" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_pwr_meter_add48_c_addsub_v12_0_10_viv xst_addsub
       (.A(A),
        .ADD(ADD),
        .B(B),
        .BYPASS(1'b0),
        .CE(1'b0),
        .CLK(CLK),
        .C_IN(1'b0),
        .C_OUT(NLW_xst_addsub_C_OUT_UNCONNECTED),
        .S(S),
        .SCLR(SCLR),
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
h33+iWfqDn7l5C4zQ1b4xXtjmS+IEN0ahJ6d/YqoRlAvuEyKQBlJY4vsICcqYzS9ktKjdstxdL8m
wxQbohKbfPDDJ4u6ZQvLSngKtzhrIWCNgvtxsEHQqv5pFcJ/q55CoabIPNdRAUMNqOq8dvHX7i9S
0XsUM0tT5gFrcxmeReh8pEThe4DsNFJWuzbo9BKKARAa+6py9DV1og1BSSBicq/ipE2SXMTFfX34
ubSyiqkmEnzkxbrCMBs9tvqvEvYhprCOF0XXantsxy75ZoBjo1gkNDpuYp79LdP2+j0o2ZsZcKKC
vBpS+Cj9+sv66yU9t51/fc1dV9Hc/9EvTQVGTw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
QfcOmBdQvSk0Vbn8TVss7i7fy+VsQ2jP2OUnOcX2+hHFT+hsivVXr29rAiN7Mg5ZZI4yzoqcn21p
KnMjHf7OOksxoe/f97H7solPxigisSWPx0M9kFk4De2P8EjYyFr5xIimb/UjB+O1OHRz6fukEUko
nK0O27Ob6XYNfTiOfOz7kAjuRbSsTAIGQYFdu9B4s2Lcqonpw5PD+2ZyQmXL+Kdsgk80WYrTLMZa
DvXFi+LVGzr2JofTfxZ3lYz7ZbqN6Z1vS+XAYNOxKm1oSlZg5dJxLKeXBnzkCcOSao2N9KAHIAOa
pdoD9RRsAn+lxReq72PPJxtvL3+YEe/ERmCN1g==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 11632)
`pragma protect data_block
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
mDE4Zw==
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
