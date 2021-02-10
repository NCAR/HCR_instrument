// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
// Date        : Fri Jan 13 14:58:35 2017
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2016.4/pentek/ip/px_axis_intfir32_1/px_axis_intfir32_1.srcs/sources_1/ip/px_axis_intfir32_sr16/px_axis_intfir32_sr16_sim_netlist.v
// Design      : px_axis_intfir32_sr16
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_axis_intfir32_sr16,c_shift_ram_v12_0_10,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_shift_ram_v12_0_10,Vivado 2016.4" *) 
(* NotValidForBitStream *)
module px_axis_intfir32_sr16
   (A,
    D,
    CLK,
    CE,
    Q);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) input [4:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 d_intf DATA" *) input [15:0]D;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) input CE;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) output [15:0]Q;

  wire [4:0]A;
  wire CE;
  wire CLK;
  wire [15:0]D;
  wire [15:0]Q;

  (* C_AINIT_VAL = "0000000000000000" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_SINIT_VAL = "0000000000000000" *) 
  (* C_SYNC_ENABLE = "0" *) 
  (* C_SYNC_PRIORITY = "1" *) 
  (* C_WIDTH = "16" *) 
  (* c_addr_width = "5" *) 
  (* c_default_data = "0000000000000000" *) 
  (* c_depth = "32" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_a = "1" *) 
  (* c_mem_init_file = "no_coe_file_loaded" *) 
  (* c_opt_goal = "0" *) 
  (* c_parser_type = "0" *) 
  (* c_read_mif = "0" *) 
  (* c_reg_last_bit = "1" *) 
  (* c_shift_type = "1" *) 
  (* c_verbosity = "0" *) 
  (* c_xdevicefamily = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_axis_intfir32_sr16_c_shift_ram_v12_0_10 U0
       (.A(A),
        .CE(CE),
        .CLK(CLK),
        .D(D),
        .Q(Q),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule

(* C_ADDR_WIDTH = "5" *) (* C_AINIT_VAL = "0000000000000000" *) (* C_DEFAULT_DATA = "0000000000000000" *) 
(* C_DEPTH = "32" *) (* C_ELABORATION_DIR = "./" *) (* C_HAS_A = "1" *) 
(* C_HAS_CE = "1" *) (* C_HAS_SCLR = "0" *) (* C_HAS_SINIT = "0" *) 
(* C_HAS_SSET = "0" *) (* C_MEM_INIT_FILE = "no_coe_file_loaded" *) (* C_OPT_GOAL = "0" *) 
(* C_PARSER_TYPE = "0" *) (* C_READ_MIF = "0" *) (* C_REG_LAST_BIT = "1" *) 
(* C_SHIFT_TYPE = "1" *) (* C_SINIT_VAL = "0000000000000000" *) (* C_SYNC_ENABLE = "0" *) 
(* C_SYNC_PRIORITY = "1" *) (* C_VERBOSITY = "0" *) (* C_WIDTH = "16" *) 
(* C_XDEVICEFAMILY = "kintexu" *) (* ORIG_REF_NAME = "c_shift_ram_v12_0_10" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_axis_intfir32_sr16_c_shift_ram_v12_0_10
   (A,
    D,
    CLK,
    CE,
    SCLR,
    SSET,
    SINIT,
    Q);
  input [4:0]A;
  input [15:0]D;
  input CLK;
  input CE;
  input SCLR;
  input SSET;
  input SINIT;
  output [15:0]Q;

  wire [4:0]A;
  wire CE;
  wire CLK;
  wire [15:0]D;
  wire [15:0]Q;

  (* C_AINIT_VAL = "0000000000000000" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_SINIT_VAL = "0000000000000000" *) 
  (* C_SYNC_ENABLE = "0" *) 
  (* C_SYNC_PRIORITY = "1" *) 
  (* C_WIDTH = "16" *) 
  (* c_addr_width = "5" *) 
  (* c_default_data = "0000000000000000" *) 
  (* c_depth = "32" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_a = "1" *) 
  (* c_mem_init_file = "no_coe_file_loaded" *) 
  (* c_opt_goal = "0" *) 
  (* c_parser_type = "0" *) 
  (* c_read_mif = "0" *) 
  (* c_reg_last_bit = "1" *) 
  (* c_shift_type = "1" *) 
  (* c_verbosity = "0" *) 
  (* c_xdevicefamily = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_axis_intfir32_sr16_c_shift_ram_v12_0_10_viv i_synth
       (.A(A),
        .CE(CE),
        .CLK(CLK),
        .D(D),
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
X+NoVXPHIraXWFULCInEXiJ+pqLMjPtPC1w/2l2xsUfnjPzPo/psw9DovSbyFGLGdst7FGOFF2S2
NrL9kw+eKQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
iWZJTy1/Fzg2LYQkI+q8i7nRtpyp7Ftqx8NVy9VtbNYIycEDG5r9SWUzhBJ6YF18THbOP++qx24C
tmEiz6phF/1RdrzPmN/r7kIzuTzpHrQYmD6NfJGq4dVHSm/WyuRehZmwwbLrJu/bWaW1CGiWQgSO
9rfVi8DdP92hHgKhvTQ=

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
Tfrp7CMZPS+UeMMY6iMrTGBNIJm4SQtPzzQEYNt4QyUuiQBpxFNaOew50jE0LzKNQ7QZf63Wmso3
M/YjKigltWLp0T6bgvYl+60O71zvBvZkvvmHKyHj59qLUQf7iAYIhf8eqYcn+lNUufkOUMpSNM6G
eJMzbUwYGnKMwteCX1Q=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
CbrWD1EVz56EoudeDmq8/j8AasQ/a1CO5TU8Ikgh6CbOh2T6wrhjPml7XOM93lVJxGdVjB/OJD96
LJ5VVcEgDOrK7rWB3tzp+S3FWdDwym1zSHhX8lHsr2jDWNJkO1AL11KYe+p29QsaIjHcP7eSm1KC
SjbY0Y9SoegcoCBEepoIq+Mx7McIXb3tstVhJv6YJEF7vGOo18Gn066olTDNVAisqOSMFssr2Xhx
N4qCk8FmVCGs4fbEPdbMvGJ7rpzCQSFKW1oYoKQp6qGIwY5HxKEbyso9Kt+2POMkHBpjx7NXxCQX
cfq53YA1XqfGYKsgOxaCOPqRZ892trMXLwUh7g==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
cBcJtexTmJgEloSnkG6+esMZPngeXeJ5OtKFZawii5/TIa9cyxy1vgVN1UCCgzbYViuK3wgfPyVX
X4S4/ctvLRmJFv2SfccUesoV9WQ3E+pVS55ZIS/jiZnyqgfBYBO6iCcYulR9jalwk6aIGdjoAu9W
syYPVagBmRNZEN7WGL70uVkB548NjwmwzaajEJzMoZ3ekksatwjnivR3K2NA8tcaXG7oiU1zN4Cw
ymFXFhWAp3Au1IK1BaryFCH+sSgMDfJtuAS4m4qTrkpTRi2GojysbswrXhKundT4HgfIpUpecI7v
0+AuGeH7D9YzbWiD6dlCf+d/e2OFp0HL/fqh4w==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinx_2016_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
O1WPrZPpQkAV3TG4RUYFRXWwRMOW2/0614SsdK1pFv3dQYnnHADK2Fbg1fR8YoME4pdMgFEwCTum
LKOFgi7a02R+KN2E1S0X4VANBfWlc3v7/bHwgkkuwaGWMS8MB9111SPbVuregA59Btd7MNpdmk5s
QnWDR6DvB4shBRqFPz5seBhDj43WuwrJlryS8k6eerR18lhKX55UUbfE1afjF9WhkkpvFDJsYG0p
3fkHNQPpn0bgbawfQ9TKXjX1Qal9shyONjuUyuTuETQD6D6IgsbG8ALYTfZBVMj67nDeYMIdEXfz
fUeynaXNutQS9OLPvvW1HJ/f//3GEia4oOpx1g==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
X2i+Jp+ucKv+OUGSOfM0H9BbskrL4iWfvAj5G1mskGk/hFYMU+NUf8EHnGVwJX8EWo1B0dkZgQic
oNIyoTKZ4PkTen1CEFHZf+PwKds2cVVaxGigz7OdpKdrFVZGrlMfkGrnUOXe0XCZtqpeHJ+aVtUF
f26YLZlQFbMKVZlNtrL6mZ/EUubsssY11tFPql725oeVvMhuJopLBicp10OvK9uG4q1NvrE5pjSS
1TPB78Knwq8L//nLTRf7BpToRvhm2CvHnnODqnCXsPwRB3KETopIWic/t+0cPvh1n9nYhZPbDGik
5AFbqkeYp3CaE7Nf+L7iWnc7RNRCn0PUdQ5Myw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
BHtfd9im5M1P3L/RYw9yIaKOecFJtNnR/Sxqi5yK509G52GEMqQ3Q7VhiCuSZ4b3G94NQ539ayGC
4wekOka7JFoDbi/SIZiWTQqrW8jvMP7Jok03zOseozhQwultLcAe90WbxUeZpja8z/4o+HAsiFLP
Pu4mTHw6VugKZoFFShuV0h/tM/LcE8/bDhf4nHVLyDLJCR/YMfzpODazxhstYUHFz6CcnohZK3XJ
FqQFJRwyZHB1Ome9/bRKSbndlmVpNYsEWcWpPOhZW5znoNtwj/a8D+D8glReunQuY+k1i30f92bw
CSDEuWk/X8Se2XanwAWDvCoItF5Eo02I/jcQeA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 21232)
`pragma protect data_block
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
m3nG6SwrQne7fFfsHoOcShRvJrKKJbo4UsNa6Q==
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
