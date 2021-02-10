// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
// Date        : Mon May  8 09:04:49 2017
// Host        : Mike-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/pentek/ip/2017.1/wip/px_10ge_udp_tx/px_10ge_udp_tx.srcs/sources_1/ip/px_10ge_udp_tx_checksum_adder/px_10ge_udp_tx_checksum_adder_sim_netlist.v
// Design      : px_10ge_udp_tx_checksum_adder
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_10ge_udp_tx_checksum_adder,c_addsub_v12_0_10,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_addsub_v12_0_10,Vivado 2017.1" *) 
(* NotValidForBitStream *)
module px_10ge_udp_tx_checksum_adder
   (A,
    B,
    C_IN,
    C_OUT,
    S);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) input [15:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 c_in_intf DATA" *) input C_IN;
  (* x_interface_info = "xilinx.com:signal:data:1.0 c_out_intf DATA" *) output C_OUT;
  (* x_interface_info = "xilinx.com:signal:data:1.0 s_intf DATA" *) output [15:0]S;

  wire [15:0]A;
  wire [15:0]B;
  wire C_IN;
  wire C_OUT;
  wire [15:0]S;

  (* C_BORROW_LOW = "1" *) 
  (* C_CE_OVERRIDES_BYPASS = "1" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* c_a_type = "1" *) 
  (* c_a_width = "16" *) 
  (* c_add_mode = "0" *) 
  (* c_ainit_val = "0" *) 
  (* c_b_constant = "0" *) 
  (* c_b_type = "1" *) 
  (* c_b_value = "0000000000000000" *) 
  (* c_b_width = "16" *) 
  (* c_bypass_low = "0" *) 
  (* c_has_bypass = "0" *) 
  (* c_has_c_in = "1" *) 
  (* c_has_c_out = "1" *) 
  (* c_has_ce = "0" *) 
  (* c_has_sclr = "0" *) 
  (* c_has_sinit = "0" *) 
  (* c_has_sset = "0" *) 
  (* c_latency = "0" *) 
  (* c_out_width = "16" *) 
  (* c_sinit_val = "0" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_10ge_udp_tx_checksum_adder_c_addsub_v12_0_10 U0
       (.A(A),
        .ADD(1'b1),
        .B(B),
        .BYPASS(1'b0),
        .CE(1'b1),
        .CLK(1'b0),
        .C_IN(C_IN),
        .C_OUT(C_OUT),
        .S(S),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule

(* C_ADD_MODE = "0" *) (* C_AINIT_VAL = "0" *) (* C_A_TYPE = "1" *) 
(* C_A_WIDTH = "16" *) (* C_BORROW_LOW = "1" *) (* C_BYPASS_LOW = "0" *) 
(* C_B_CONSTANT = "0" *) (* C_B_TYPE = "1" *) (* C_B_VALUE = "0000000000000000" *) 
(* C_B_WIDTH = "16" *) (* C_CE_OVERRIDES_BYPASS = "1" *) (* C_CE_OVERRIDES_SCLR = "0" *) 
(* C_HAS_BYPASS = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_C_IN = "1" *) 
(* C_HAS_C_OUT = "1" *) (* C_HAS_SCLR = "0" *) (* C_HAS_SINIT = "0" *) 
(* C_HAS_SSET = "0" *) (* C_IMPLEMENTATION = "0" *) (* C_LATENCY = "0" *) 
(* C_OUT_WIDTH = "16" *) (* C_SCLR_OVERRIDES_SSET = "1" *) (* C_SINIT_VAL = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) (* ORIG_REF_NAME = "c_addsub_v12_0_10" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module px_10ge_udp_tx_checksum_adder_c_addsub_v12_0_10
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
  input [15:0]A;
  input [15:0]B;
  input CLK;
  input ADD;
  input C_IN;
  input CE;
  input BYPASS;
  input SCLR;
  input SSET;
  input SINIT;
  output C_OUT;
  output [15:0]S;

  wire [15:0]A;
  wire [15:0]B;
  wire C_IN;
  wire C_OUT;
  wire [15:0]S;

  (* C_BORROW_LOW = "1" *) 
  (* C_CE_OVERRIDES_BYPASS = "1" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* c_a_type = "1" *) 
  (* c_a_width = "16" *) 
  (* c_add_mode = "0" *) 
  (* c_ainit_val = "0" *) 
  (* c_b_constant = "0" *) 
  (* c_b_type = "1" *) 
  (* c_b_value = "0000000000000000" *) 
  (* c_b_width = "16" *) 
  (* c_bypass_low = "0" *) 
  (* c_has_bypass = "0" *) 
  (* c_has_c_in = "1" *) 
  (* c_has_c_out = "1" *) 
  (* c_has_ce = "0" *) 
  (* c_has_sclr = "0" *) 
  (* c_has_sinit = "0" *) 
  (* c_has_sset = "0" *) 
  (* c_latency = "0" *) 
  (* c_out_width = "16" *) 
  (* c_sinit_val = "0" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_10ge_udp_tx_checksum_adder_c_addsub_v12_0_10_viv xst_addsub
       (.A(A),
        .ADD(1'b0),
        .B(B),
        .BYPASS(1'b0),
        .CE(1'b0),
        .CLK(1'b0),
        .C_IN(C_IN),
        .C_OUT(C_OUT),
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
ZxTZQ0UsS9HXL+cye8KhDHq6JjsRKdBbt7/23hG3Xv4lTOl0WgHvvGUXhuq0kWEjqS5VCl4O7cYh
glsyN2zZsA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
D0MQ3ley4npGPCDj0uKNvxx120GglLBAwtK6OmuXlvAVN0AR4gZjPv9jfdRnj/KJCxgkNVaqUWhg
Egx0h1ObNRySsfchKqdWJxVp84ELTdz8SOdcwsqw3WYcma/EKO0xmVG+Dj5kh3SGzvvfDaBktFb4
bK3AFZY/+Kz6WaLMycE=

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
Ib/FxVN0ZG+ayfRlBompcRYBpl17xB6BG0jS3s3PNdG6pBxEZq6Py/W4j+7qAMV4uf9WBeBuwU2q
HYo5rMUEYE6wZf9jBnW23+A53JEyx5cXbckxSK688vZaeemF9wCkbeVwfHM8QNbLc51/qzlRZboH
l7C4B2YP6+l44fhzNYY=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ws6JMsAbE3g94lwYREcMoC/8x4NmofYlfb9uHUEoOTvERSt6NSyR1yiG91nsEU3XfNhOQ7b/Wo+P
aa5UrHOplosBwW9O/BOPM9kStFRQfGsf8m20FxpwLUQdlNgNMPZvmEcAaEc+pN3iwPyX09CoU7cW
ox6RnElk1MI4OWVFf77mW8j6e1VlWO+Vc8LKoTynKGAP5hC4BYHQd27IInXzGdz1oVD4Bam4x0/H
sYLHZCISnOa94Q3CL6ay9xgNR41rtS98WTAttjEyFf8ILmaeESW6M4dGV3+EcdfBNzrTTc1nF75N
HxzYnCBLVG6X9yHlNRAwFRouHTyObDyWadNJzQ==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
jKxqwTVbU6wQlQsyUl5EyNEaloyZKqOqnKP/oSoo8BbsW9jgw2GEmYOdPZbHNARjlp9P52Yzd3cJ
LczzuDU2cV2yn10WPFG38hLnucATA1ff0e8/mPzfxBEbAOPlzTkUFRukOc0zmo/tLK6cZvcaoRPu
DUI30FqzbS3M/o8XdN6yN2QOFivgXW0Xh8ycmXVtjktsm6ElnG31EW/2LkwLAyVftpL7G7j6nMnt
e+d+eKFIoGrxVI+7fida/LT0yaOYHWQh3rAG4GvE+2lORv2wy78727ZIirWNnQu8oy5qQcf7LAqd
e4MLtleFAxEV9eZP09SJZUSUNMj8waYaAU3w8A==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinx_2016_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
w06/xQMdplxMd/DX9rImvuDEyUujJNZ5bclIgCUEQ3II7s7VZNfFQwqshU6852btDf1ThZcwb360
Io2jAnYs7UKM/nRMb56sYLBX4Y1+ufAYkpkHIcZcRICnnnvtYZ47grVBHrUfGA/xC7v/201YnNS0
c/L8l8Caa3RS8dR3ZckJnLnQOdimwEUdrhOFCxXNaVvcB1qFzyeB0qRxY/SqYktIcK0cf245rT6J
ycbkjnMIhAqvfqKdgoqIvgkkVe5grJuoukmw5uvFNcNJJ4EbH5xxoUZnl8pXhFueD3O6JeklVONo
/UZlkoZ7Ymk1otUl6y3wzaGnG8SCVGGtrmKfXQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
OPpJZFo+i29L8eVb2XaN96x9sR25MHtYrtmyIrrLmW8MoTYeQY8D8HatXgQ9gqRWhVEkH1gJeA84
2poCNbLRblNYPVtxU1jvcYov2eIl8sUHgnotrrbyQHC723MGiLmI7i4wZ2b5W2h5tZ9S/okD6UXd
Fex/fvcizTx1bkF4xlNPM4H7AD4F+3ylVpks2GJ3Jcx9xWHRzSQ7EIYJb1edJF/FmwRAmD1KPVGM
4IyLpVPxELKKYJPnuDQr0Ity8xislOO62bjp/KzRUYZyWQcCWffhh0xFCUI+Ls6oQXnVyvbbx8fJ
HFPJGrUodhaoNyq4b5QL44SgM7JZ5jjfEuiTpw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
2jtkmR9ZIwcP/RaL7aEUn8UATGOn31GRkM2d2+qgFh+84Homd9jKI59UXvzo2cx7QMrqb1yWHN7W
wjlqdR0pW4noPeEkTUEnf8jGKzN8uCh7z9rQ0CH8uJH5MuVKfsW+ip/9Xb2eHQiO99oBPn2o+BYn
WK8NQccEFssFoEj3pzno8GBX64o6R8eUoaIusbx0nb2yOfsAf8zsLUASKVJOsGoD9V0xAI3A9tGv
048sjDev7UTh7JQwVJ4bOryo3qF9u1bOM/AaXOXnOUELcpp7XZfnKSbSY/ZPW+nCI1t8olob+ZiN
1ijGY5kOCum7h0GsllhpE2IB0QROaPV3Yd7hSw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 8960)
`pragma protect data_block
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
s5LZd7EWDXU4Z6w=
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
