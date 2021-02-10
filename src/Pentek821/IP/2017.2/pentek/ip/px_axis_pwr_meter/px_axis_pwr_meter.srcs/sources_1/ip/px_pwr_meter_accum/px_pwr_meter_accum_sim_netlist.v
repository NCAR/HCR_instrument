// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
// Date        : Tue Nov 01 21:27:57 2016
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Xilinx/Vivado/2016.3/data/ip/pentek/ip/px_axis_pwr_meter/px_axis_pwr_meter.srcs/sources_1/ip/px_pwr_meter_accum/px_pwr_meter_accum_sim_netlist.v
// Design      : px_pwr_meter_accum
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_pwr_meter_accum,c_accum_v12_0_10,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_accum_v12_0_10,Vivado 2016.3" *) 
(* NotValidForBitStream *)
module px_pwr_meter_accum
   (B,
    CLK,
    CE,
    BYPASS,
    Q);
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) input [32:0]B;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) input CE;
  (* x_interface_info = "xilinx.com:signal:data:1.0 bypass_intf DATA" *) input BYPASS;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) output [35:0]Q;

  wire [32:0]B;
  wire BYPASS;
  wire CE;
  wire CLK;
  wire [35:0]Q;

  (* C_ADD_MODE = "0" *) 
  (* C_AINIT_VAL = "0" *) 
  (* C_BYPASS_LOW = "0" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_WIDTH = "33" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_BYPASS = "1" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_C_IN = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "1" *) 
  (* C_LATENCY = "2" *) 
  (* C_OUT_WIDTH = "36" *) 
  (* C_SCALE = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_pwr_meter_accum_c_accum_v12_0_10 U0
       (.ADD(1'b1),
        .B(B),
        .BYPASS(BYPASS),
        .CE(CE),
        .CLK(CLK),
        .C_IN(1'b0),
        .Q(Q),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule

(* C_ADD_MODE = "0" *) (* C_AINIT_VAL = "0" *) (* C_BYPASS_LOW = "0" *) 
(* C_B_TYPE = "1" *) (* C_B_WIDTH = "33" *) (* C_CE_OVERRIDES_SCLR = "0" *) 
(* C_HAS_BYPASS = "1" *) (* C_HAS_CE = "1" *) (* C_HAS_C_IN = "0" *) 
(* C_HAS_SCLR = "0" *) (* C_HAS_SINIT = "0" *) (* C_HAS_SSET = "0" *) 
(* C_IMPLEMENTATION = "1" *) (* C_LATENCY = "2" *) (* C_OUT_WIDTH = "36" *) 
(* C_SCALE = "0" *) (* C_SCLR_OVERRIDES_SSET = "1" *) (* C_SINIT_VAL = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) (* ORIG_REF_NAME = "c_accum_v12_0_10" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module px_pwr_meter_accum_c_accum_v12_0_10
   (B,
    CLK,
    ADD,
    C_IN,
    CE,
    BYPASS,
    SCLR,
    SSET,
    SINIT,
    Q);
  input [32:0]B;
  input CLK;
  input ADD;
  input C_IN;
  input CE;
  input BYPASS;
  input SCLR;
  input SSET;
  input SINIT;
  output [35:0]Q;

  wire [32:0]B;
  wire BYPASS;
  wire CE;
  wire CLK;
  wire [35:0]Q;

  (* C_ADD_MODE = "0" *) 
  (* C_AINIT_VAL = "0" *) 
  (* C_BYPASS_LOW = "0" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_WIDTH = "33" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_BYPASS = "1" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_C_IN = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "1" *) 
  (* C_LATENCY = "2" *) 
  (* C_OUT_WIDTH = "36" *) 
  (* C_SCALE = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_pwr_meter_accum_c_accum_v12_0_10_viv i_synth
       (.ADD(1'b0),
        .B(B),
        .BYPASS(BYPASS),
        .CE(CE),
        .CLK(CLK),
        .C_IN(1'b0),
        .Q(Q),
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
II0BrZ3kjUohLjSJ0EEqugZftwYeWzCwCFQcjlr7a4Rtvjq6XdaixZjxIevkBDA64+pnL/j1QHMM
qmtnzZjgyw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
JF2ELBIDKwKnHZ+Z25YTaCHeyUMDqTH0JUvDRmaSQup93HJ9PLDacs+vXBmhAEBS5Rq/GXYwqKK8
zDwOzuCO5Bm36EW4KpNNs8ddOQorso7F0sC7AAOx4/hbsiuBt86ghXZ/Tzic5BKWSpMp6U74q46L
axlLl+8qhkQHE1aXUjY=

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
mJdQzmwxHzlwAf6ZHHh+61VBeLE+ZqMyTPjraAeT8Q+unZ6SBaKzqs+6hEUCeJAyZ2XRVS+pA3ur
+WuQNqtD3T2oc5PHCrrlg6qVhLVj9eMFX9Xb9Pd0nUAXaxPMPK1YFzmSwsmJiP7gVmk7e98w08x5
HnCfH7nudcXLCcoKGUI=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ZBITBSqgo1Sw0oOCWj7EpK2Do3QH5oRkJj/lDo9h8how9NofKdEygo8CVatgmeE71t+3qrfHHQRK
6mfbX1l+EQP2RhQKISKYm7VFN7Iu/1E0X2iYiQIwtpZfNKlwcxXTKvGXbh63LukpXm7luD+xY7Xm
s8bF7RMTkHJ98TIrY+lEswQYoHC+/mhcxh6MHhz3Wu6azR547s/sTsGjSQ7h9Lb8ZWlP7L2EuK8D
RZ0DmCxx5Iavxh67DOozThDrAfyawh46cSa+/xNvAjpVGoq/QYaRX/UFPDc42B9vgPSrjo5IHmUE
S+woRBwuKkDBXzhh9h9DIpTxDZZTQ7/Daq4sdQ==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
IFtzD6WBvFeScuSWBKDPDpIneBsAqT5Cc4G5QWbwKmjHiuMNfDZtdezUAjlr3EM1TfLNPsQrVX++
bXTjNIOEO0JSnoYz7oNjmx8VbNooS04j4e4HcXxobxX/IgQy+E7ro+Ut3SgigpwgqQQtKb+PijHU
7AY2zThpLrlvr86F8FyloMB6RQXR7pwiUiIyNnN9w+jUUHK13GjEHW7H0ZT05GxZBzAnw2vRfXDS
Rn2hyZ8D148UoYoyyoeBJbHBiejk2C6JrXrLls3D0FNlI1N0ZU6Co6j0VhvUYbVr/vN94sYHh1Bg
LslmyRUSafkCe2MhBk0W7T9160OTtV1gjUzhyg==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinx_2016_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
FrNfiDHLt7tVrMm2DVoZyZnaRn2eEglTgCr9hGgKdAyiwq7sjdBkfbtmZuPms+q60LZYSgDITr4D
V0mgi8rSrxPweNLFheAHKV7VlnidiX7HsGjcWMlnyAK/E20xU65f4wGNfEPetFYng+logQHdYQiS
kgjp75VEeSzG5yWvmFPcOmu2uSQnOZcB7n1hP1O+PStf9yXMIbzZjBYjdaIehfpFWa+41E0DcaN5
4SX0B7bGcbWodGNL9tlhS5IbqpHA1fCG+SonWHfM3dNy7RRzIg2ph+NHECLKxRHfoJGv3JM+yMny
pw5419pnmwkJGfDUREsxjYRAo0frwJ53dVrJ4Q==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
RgvGpJCdSMipvTs5mERvVSuPxnhOV2B/+lyIs8ttVFXEmuNTGLcZ/V4aNylmV/pSDoyBLRM1u48W
worZbWuprMOVUffxg6yfQTRjRuoJe+TV4PwlapbxQXN0jo/eNwU1NwkTrsoAIRt38PTi8BC9pFPt
+OR8akkSC9FCLfhh/jcdyLcIM3UmYshJ/R29C4ElgjJ2cBAN9RokdJHHFXxX/L1NM1mSnoO1FEZ6
fgvuYiVyRFHSM9KecfbQquqlMc8ThZM5qU6Zsfv+CgkFQNygol7tZCrHe8I4fsyHroaL7m/WAlxh
pVhPv8skqaeeM7S+muxM65R/9RvUpfNAHYo4Cg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
TnL6rOtkETCw223gtId8lxYrh0LKUUqZo00QV5YLsmpdKXJbYLdIXkT3e0aLp1Dgc8eSTAPAuVxF
eZSr1SlL4baGICTjgZ+m0WQ9zbNX8jf9yVwZURoOZrRK0QrGkxtHpTVTSNiZlok4bM2z4nnItEXw
jJlIuITtMpyX9NOqHivYDYg3x5lft6Hig5nlFNPk/qcUxkFw9zheSMJ7z3rc6Fot0na9r0SQBTvV
obQuIFgjmILLpDdkS+3OXpgNyM91bCzks0lxRi9wJ1nzUQ4G1NxHYd3bZai+WRL7iic0zFiv7kyM
cC8gwaGaXbc4v+GcwtOb6C8KEkHpDOvUcqalng==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 11136)
`pragma protect data_block
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
QAY0vSc7jvYb+lzGbeK1Xy8xvRSc
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
