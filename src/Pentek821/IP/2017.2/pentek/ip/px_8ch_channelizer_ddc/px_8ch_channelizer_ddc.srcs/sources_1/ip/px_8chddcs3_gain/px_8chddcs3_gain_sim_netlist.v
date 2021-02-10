// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
// Date        : Tue May 16 08:57:49 2017
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top px_8chddcs3_gain -prefix
//               px_8chddcs3_gain_ px_8chddcs3_gain_sim_netlist.v
// Design      : px_8chddcs3_gain
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_8chddcs3_gain,mult_gen_v12_0_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_12,Vivado 2017.1" *) 
(* NotValidForBitStream *)
module px_8chddcs3_gain
   (CLK,
    A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) input [42:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) output [58:0]P;

  wire [42:0]A;
  wire [15:0]B;
  wire CLK;
  wire [58:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "43" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "4" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "58" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_8chddcs3_gain_mult_gen_v12_0_12 U0
       (.A(A),
        .B(B),
        .CE(1'b1),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule

(* C_A_TYPE = "0" *) (* C_A_WIDTH = "43" *) (* C_B_TYPE = "1" *) 
(* C_B_VALUE = "10000001" *) (* C_B_WIDTH = "16" *) (* C_CCM_IMP = "0" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_LATENCY = "4" *) (* C_MODEL_TYPE = "0" *) 
(* C_MULT_TYPE = "1" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "58" *) 
(* C_OUT_LOW = "0" *) (* C_ROUND_OUTPUT = "0" *) (* C_ROUND_PT = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_8chddcs3_gain_mult_gen_v12_0_12
   (CLK,
    A,
    B,
    CE,
    SCLR,
    ZERO_DETECT,
    P,
    PCASC);
  input CLK;
  input [42:0]A;
  input [15:0]B;
  input CE;
  input SCLR;
  output [1:0]ZERO_DETECT;
  output [58:0]P;
  output [47:0]PCASC;

  wire \<const0> ;
  wire [42:0]A;
  wire [15:0]B;
  wire CLK;
  wire [58:0]P;
  wire [47:0]PCASC;
  wire [1:0]NLW_i_mult_ZERO_DETECT_UNCONNECTED;

  assign ZERO_DETECT[1] = \<const0> ;
  assign ZERO_DETECT[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "43" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "4" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "58" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_8chddcs3_gain_mult_gen_v12_0_12_viv i_mult
       (.A(A),
        .B(B),
        .CE(1'b0),
        .CLK(CLK),
        .P(P),
        .PCASC(PCASC),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_i_mult_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
hYn4T1Tz8lmB8loeGYuHmgEJp5TdMkRKn5tdK0Pxo3wkkBR/aG2es4RXT0Kx9IkGgy2jVWVPoeKB
usRl+M6Pxw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
cZOTsELKZdXMGraSgAw9rgqxvSLbW0aT2lTeYBbmmRdIiILVX40Q3XF89sXvrmWq2q7dAJSXvpsX
1JIpxbCUMi40Nuru7hdg9WkNNMs1Q8UJCou9g/GNLxJnh56Wx2JqOiplBqlgeaLjd0T16sGmIYm4
kTNGsNPOASR/dWaldsE=

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
o6ehD67QiTZFs1auOjL5nkbDEbn3neiXmbyTqqoQKK+v0TaPL6hSxGHE/Fz3NtmR3RIza9+Y9rVH
Je7RNuyq8vsgofAGK5Qpf28P/9kF6eDh0JgLJHOonk7lnG+gufS3pMHIfioCEe/2wyoIxzbwUPNl
TCIJtbzDvWpcCIKBgiQ=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
cASOe3RHelXhU6s/jEEqAnadTjmj4ihjbMuYb8YjKT8lAROht6xaHEt/3WXUlUPXIpDwtJlexClV
csQVUSlNShzZmxBI5epxH/HJqLhQYwkRDFK2BUAagxn++cS1iWJGlow9Gha0EU+PfllVje3OWy4O
LbiqHgQlEG6sIGo0ZCj6KPC87SBAytHtAiVRpovpGAxLS/DLeXSJaavSSwOc7nmWFDaNEi9dJS9i
qixZxDI5QNaDp3uaBFLzKqo9oSPgNj1mYKRZp6XL0ganfqQCHh/snCyymi+o0DC5vSM/+RtCZHXA
A1u3UsiXv/IfegAneXJ/yU2Rpj4P9iaLKgmtjQ==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kAlIhoAHksCGo5mF85FXcP0dM1NExLuDn6ZkyfgoWH09b5qcw8bLJnQMlkLvdLRrczznUPKBLrRR
nUHSMi9UTzRZ0rrnazgGnHFEV1vyoRgDQDOpkZbrkgl/VynbkoMBhCQXYT59yyHhqjI6WeIYVipR
zyn+NdmUB+/GwlsSYygywX31rotvUxb4RZmCqg+UCemw+N0tS43QuIzJuG1JM+3+SVbU3LuVcClf
rOwWqAFHsOXBSrXNoPX6QeNlYUKy8gcjiaQqPSrbrSJWdgvqshdNnvLWuzkREOLY43TCoAFwM8p5
73h2VUHmwffIqzCELbp3Tee5sQXgMbvJ+Mbfpg==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinx_2016_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
CFQ8408huN9E8h2/r246qkePkogHtf4rd5gf8GO4NiUzetOQ2my8cbvxYBjZy3yQSw0/LrN95Drj
cc3uAe9r+wOvBQ3aM7AKnKpRkAvmqyCRt8lkW5NRi37udLv8jQJ5gVByTJ76KIn8s2kfj/iHou8+
VyK641fcvp2Fk/dmC13HALsHzGvO1m9Kg3zHT1aJxtdh2FDGLhOy/TtcAEbSWUhNkclp4pw4r97T
urhhIiarPZZDEkAXG1Ezi9I9ebmvdHMRRa/e9P95Xg7vwS04EHfmVTpFKF7UHncoI46I8za8vjyZ
8MCKLS5zKbgCU1OCJ9lQ6mJX1roD79pJrnKYpw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
eNbZStu9wukxF0Dp/ZnJnVUViAYvqcQgZ08cqxh/PVi23BMRwxOUZmO2eyiPM/i6Pbly7jWbElHF
o73+n6Glbfw2uYjSppa8bOIVUw/s9gF1sJI0kWIwrb3IAD7lzWcqUAyExDkUaogjRHWIOuiOKQhx
F2bADEWY5pcO0om8WAqz3I5UPOk2deFf0KFtj2iWSRsqjddChI+PSWdIekwiflWG1VT7ckgrBL7p
AIpy/mjYd/Cnxnky3AtwQAvAiU5DLetinzeD/0MqhOPqOEnPCAXulaB6QtakU4kU+ogkjs1je/5r
MucPIMIp0CKZ9gdTHs3mBZM04/fYLWEHMSzN6A==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
PmvHLcPOH9rG5rf1zF+MW5SE8v3VRpAgLUScYwUWGAVgyAbi+rq89k2oKtezuMPQ/s9vz9hNUo7l
1EfDvwSQJY+yyQ/ymCz234rkUuQE5M1GL6VAuh9IZvN1mQK6cGwWaLFM7XMv8Rl4Rw1D2xUj13do
bJ28JBQFWtJP6AAKIUDQ0tFSR5epAd1F3ysO0p41BMPdnVazEwN4g3LAFRZ3+qa8qOk2Z91IIwvd
2J3s/r0pfErTx9di+WS2sNRaSPzl853vPpJruzf8Mtnqj+yFL/imud2/D4+dQaB6zzSPGfzWBEvE
/ZYWNDKmO7+7phhiABqfFliFgTFo5/x+BgOc6g==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 15616)
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
