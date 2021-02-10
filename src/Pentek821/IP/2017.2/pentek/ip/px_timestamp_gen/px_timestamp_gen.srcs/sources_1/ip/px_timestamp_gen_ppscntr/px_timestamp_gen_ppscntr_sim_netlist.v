// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
// Date        : Tue Nov 01 14:13:13 2016
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Xilinx/Vivado/2016.3/data/ip/pentek/ip/px_timestamp_gen/px_timestamp_gen.srcs/sources_1/ip/px_timestamp_gen_ppscntr/px_timestamp_gen_ppscntr_sim_netlist.v
// Design      : px_timestamp_gen_ppscntr
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_timestamp_gen_ppscntr,c_counter_binary_v12_0_10,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_counter_binary_v12_0_10,Vivado 2016.3" *) 
(* NotValidForBitStream *)
module px_timestamp_gen_ppscntr
   (CLK,
    CE,
    SCLR,
    LOAD,
    L,
    Q);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) input CE;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclr_intf RST" *) input SCLR;
  (* x_interface_info = "xilinx.com:signal:data:1.0 load_intf DATA" *) input LOAD;
  (* x_interface_info = "xilinx.com:signal:data:1.0 l_intf DATA" *) input [31:0]L;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) output [31:0]Q;

  wire CE;
  wire CLK;
  wire [31:0]L;
  wire LOAD;
  wire [31:0]Q;
  wire SCLR;
  wire NLW_U0_THRESH0_UNCONNECTED;

  (* C_AINIT_VAL = "0" *) 
  (* C_CE_OVERRIDES_SYNC = "0" *) 
  (* C_COUNT_BY = "1" *) 
  (* C_COUNT_MODE = "0" *) 
  (* C_COUNT_TO = "1" *) 
  (* C_FB_LATENCY = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_LOAD = "1" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_HAS_THRESH0 = "0" *) 
  (* C_IMPLEMENTATION = "1" *) 
  (* C_LATENCY = "1" *) 
  (* C_LOAD_LOW = "0" *) 
  (* C_RESTRICT_COUNT = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_THRESH0_VALUE = "1" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_WIDTH = "32" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_timestamp_gen_ppscntr_c_counter_binary_v12_0_10 U0
       (.CE(CE),
        .CLK(CLK),
        .L(L),
        .LOAD(LOAD),
        .Q(Q),
        .SCLR(SCLR),
        .SINIT(1'b0),
        .SSET(1'b0),
        .THRESH0(NLW_U0_THRESH0_UNCONNECTED),
        .UP(1'b1));
endmodule

(* C_AINIT_VAL = "0" *) (* C_CE_OVERRIDES_SYNC = "0" *) (* C_COUNT_BY = "1" *) 
(* C_COUNT_MODE = "0" *) (* C_COUNT_TO = "1" *) (* C_FB_LATENCY = "0" *) 
(* C_HAS_CE = "1" *) (* C_HAS_LOAD = "1" *) (* C_HAS_SCLR = "1" *) 
(* C_HAS_SINIT = "0" *) (* C_HAS_SSET = "0" *) (* C_HAS_THRESH0 = "0" *) 
(* C_IMPLEMENTATION = "1" *) (* C_LATENCY = "1" *) (* C_LOAD_LOW = "0" *) 
(* C_RESTRICT_COUNT = "0" *) (* C_SCLR_OVERRIDES_SSET = "1" *) (* C_SINIT_VAL = "0" *) 
(* C_THRESH0_VALUE = "1" *) (* C_VERBOSITY = "0" *) (* C_WIDTH = "32" *) 
(* C_XDEVICEFAMILY = "kintexu" *) (* ORIG_REF_NAME = "c_counter_binary_v12_0_10" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_timestamp_gen_ppscntr_c_counter_binary_v12_0_10
   (CLK,
    CE,
    SCLR,
    SSET,
    SINIT,
    UP,
    LOAD,
    L,
    THRESH0,
    Q);
  input CLK;
  input CE;
  input SCLR;
  input SSET;
  input SINIT;
  input UP;
  input LOAD;
  input [31:0]L;
  output THRESH0;
  output [31:0]Q;

  wire \<const1> ;
  wire CE;
  wire CLK;
  wire [31:0]L;
  wire LOAD;
  wire [31:0]Q;
  wire SCLR;
  wire NLW_i_synth_THRESH0_UNCONNECTED;

  assign THRESH0 = \<const1> ;
  VCC VCC
       (.P(\<const1> ));
  (* C_AINIT_VAL = "0" *) 
  (* C_CE_OVERRIDES_SYNC = "0" *) 
  (* C_COUNT_BY = "1" *) 
  (* C_COUNT_MODE = "0" *) 
  (* C_COUNT_TO = "1" *) 
  (* C_FB_LATENCY = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_LOAD = "1" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_HAS_THRESH0 = "0" *) 
  (* C_IMPLEMENTATION = "1" *) 
  (* C_LATENCY = "1" *) 
  (* C_LOAD_LOW = "0" *) 
  (* C_RESTRICT_COUNT = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_THRESH0_VALUE = "1" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_WIDTH = "32" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_timestamp_gen_ppscntr_c_counter_binary_v12_0_10_viv i_synth
       (.CE(CE),
        .CLK(CLK),
        .L(L),
        .LOAD(LOAD),
        .Q(Q),
        .SCLR(SCLR),
        .SINIT(1'b0),
        .SSET(1'b0),
        .THRESH0(NLW_i_synth_THRESH0_UNCONNECTED),
        .UP(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
PRBNg3KyY1TR8yWZsnJnzzW/dEsrSEDfE+1c6Hou7GiQUi2ny3LJr10cVebRXHTs9QGvYYRTSSn8
Gyz5sNLHnA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
jp7GnVDs4XPGehBIKJsokm3xWBjOSlzqHCc4XQDu66HQLxD0ZCDJtK/0K8Il8OrKOoC65joOn1l3
Jor/QFU/jgbh9u8Cb2WE++syJa27o9YGvAlnaQpkj+0+N0NSqwnZUTbmC2/vBRF90ejN3z0SxSuf
7ogM20Bk3ecQGlrM6Fk=

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
C6JMRfgIV+Sc/HUYaNdQ7GIkz8COMQi8XUszLwYumZyMji0WWhDsAmhdfX5HH8cQ2yEACYyrTdP/
TPkP6isgOtKu5yx2FXkdBxlX4T/RYb8TFzYCouDdbbojP0Ri3EnQY6Os7fU6/Kh0RGbHNIurolFP
ynqKAqHwVx1foWG/fGE=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Bfx6ABSTmJJG+apj7DJxhWrxKS3DSF5eBFzSfEJkgmzGC4adPP0+EtlS/8cA3WS05a9ZnMSU//dD
6Xa665Pgb6piwHZmJXNDVJXTPEU3BZXO0hD4lShd7QESdtDBIjPVNllsAMr5ICT9aeAuRZ4712CL
OsJBlMyyKq44NbiGgoZsrvYB3AOby14WleukeyrHVRqOVOJbPwg9fW0vsTdksfdW/S6AUHeuZNZw
FQzUlxYpG1/ulxKJRSWGF2rVs8INdMkWKU0mQNfz8Fbu9kCy5+qtyDgko+t+9b0QOndyALYwiMoX
plKql5/d/127rmaQfARfQyiN2GF83TwGN+q8SA==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
uN7qo9Y7BtnOroN3nCx9a5nDr+AspFVYFgtL9vAD/836ZRiS2NZlcBzHW7l/qr+zJHZIwdEJdB4g
XTacuGx6jN9qRGwxsjd3FKG3v3ezqTrcg3ShQaxbt4rb1UWdD0rGM6JHU9UjV1v4FGjdDtrez7nV
yf8TbYVAIjeVuwTKz5QV7v+K5d3durINdZF1N3Te+ED6whBD4ikRKDsUQ1uT+omn+AEaJruouIng
kBII4smDkPDmW5SZwbcgCZanAN4z/r3pZdBTsYLi1WIMAt49n8T0NBr5BQX7Pwecdwn5uJ1uQo5u
PtrPHwF/NzhF6ki63bIUN1am+XxZ5abQxhzT+w==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinx_2016_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
fxhZ+v8RjZpp04TYOWBrq4+/hxS3PdHwNldw733sowphaSpIOkexyA/fRFpFYgYAcOEJQVdGxlwj
L4vfVCeW2SSHwtR7VGPSbEIqenEpmN/BMJKkAqphU3QYmDdQQXwymCL5qvIaORVfIz1XLVnp5y+3
MOyNHjSIDozEwPBkzIs1+o3qqXij8+OqX3X3AFlhB2Ase2TBfPeBFWKpS/1dOAq1BfuotrmuCum6
+UTctjS5n2x+OZZxOe4vA73VwVVKsh8ptEGksrnhLVJ9Qp2EfA7FXAksUYeGRo3dHvFOeIvvledQ
eavcoTOBjEwcPZkek4i2nhhzqQQJ/0ZEfxZcnQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
lkGTGIRS5TKkrfdQVEe6rSMQqeLpt/1t+MzWpHRCqwPKBKoWap0rwfGmq2qCs9peG+sZK9pU83q4
1R09v+AYnc5TTPqpCax0p8uBXIktgKotShQLfMpi3/dIHeIGODiYPNN/FGpkZ5O0bGC0ioIjHSE5
JvmTuwM1OqOPFvCNrEdXOqRlejQeIr4xlX6LZQOUsQdmuYsUU8KIzd0meaJwudfEhv+zCIzMIgtd
8nXPZZAbzIOSxGUAKJG5wdomLOZV63SN3yeLxoJabJmywH77qQ/DZsGTROY/RMb7MUC9rzb6BbIc
Ir1cM8spGUzrm3briaR2hkvPpHHZJMiTgNSTgg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
b17aIbD7Wc3DCwPi9ybUDLAr14bmgCZt94HOuNmb+dJ5LJXRRDXXcU7XGdDb66C9n6kLDYwnhWfe
JBBXJf07M32EQiY07LhuL0oQJICvhKdwV77M85YEZd1aEsgOr/35H1U8OZijE6mMm1iAtyQ0rZnA
QfnqcihcV+FQ6MeSoRSWyIpBtMxh245ZoGzuoH8iOGA9Yi0O8SDzWHORInoEyAZHNrXR1gEoVJOm
ozeUTgnQgBSkFk6xcNkg0r1qizZ6w2j4frtVo/AxfxPdoGatHSJv3sDGCHQaD+Ydc6fBUdAaEyhw
PTSvMvvN6At+XncMe4ccc8/T4/kvV8tN6fq1OA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 11392)
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
