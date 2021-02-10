// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
// Date        : Tue Nov 01 21:28:27 2016
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Xilinx/Vivado/2016.3/data/ip/pentek/ip/px_axis_pwr_meter/px_axis_pwr_meter.srcs/sources_1/ip/px_pwr_meter_mult_k/px_pwr_meter_mult_k_sim_netlist.v
// Design      : px_pwr_meter_mult_k
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_pwr_meter_mult_k,mult_gen_v12_0_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_12,Vivado 2016.3" *) 
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
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_pwr_meter_mult_k_mult_gen_v12_0_12 U0
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
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) (* ORIG_REF_NAME = "mult_gen_v12_0_12" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module px_pwr_meter_mult_k_mult_gen_v12_0_12
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

  wire \<const0> ;
  wire [31:0]A;
  wire [16:0]B;
  wire CLK;
  wire [46:0]P;
  wire [47:0]PCASC;
  wire [1:0]NLW_i_mult_ZERO_DETECT_UNCONNECTED;

  assign ZERO_DETECT[1] = \<const0> ;
  assign ZERO_DETECT[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
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
  px_pwr_meter_mult_k_mult_gen_v12_0_12_viv i_mult
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
ptQ11ybvPhWFWTGrQo+7aGiIrH8JSyStYCUMOokDd+PPciOFrFMMChXZiWtXJpOf7mbM0kEZiv4j
8DmUfBzUqA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
h7OV9pYIwlKexYbVHsWdzIEKTz/iMtv4WoHaiiFghx8qJgOhdd3wDRYkR/B3E7hVYy2COcm5APup
qDYlt3IyeqL2N2RRoMmBVxAFJV6hCj9YEbUb0otyQAVPBaiI1FPjO5xFS/hWO1jK5vhJcsLkQea9
6DEIF8FtNNea1Mq/r2g=

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
yy9Y6935bfig13W64uvBPEigKN5XmZP8d556jHobEKImEuxxAt50ZM5SYJfQ1cgV5QpGyGKq18LA
Ie4kVwsXuT7UsN6x8vh4jEf9eSPrjCkgrPb99+DcdRsMyS00rDCx+sglhqDRhi5OxUEkR5awg1YX
vN35O9p+48WxNYR2UC8=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
LZ+Jei6Dhl0h8Ft9kcSvaV7R4LftS48PATOUDxiNHixlA4BISf+lTaHLokYqG/GSOnLHxh8j6OxI
CW5SQEIloeTqRLfWEkpRzf9BKkCQOnwQZDJUvuYvW7WYQ6oQjERuGCZQVnkgpor3EtMfWSZ8YsAx
azYt49bgzZfdUTCKUgeEVEMKVshHGMBIhvTs9KkcKPz8JGeMDL5oeYdFzdkVYjPP4aev0U6zPMBs
JZ9E/7nvtBBV2vKhLY7U3X7iTZ1ePFeESc78t32tjGtG0yeSiNZq81Tw6u3srMRLOBkZoVVnCxhr
9QuVk5MuIbODepMZeZdBdNAQI/tre1Gq0gszrw==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ngLIkvfW2Uts9POUsqaNJVpzIpWiCvRaKpZydG/SMwUuE3+JnTqAnNfvtZqO6SfqEzFsZu81jGwf
i3H8ALoDKBU2C9TYxmcx8GPDKo7Yp6Kvwm6+7rgm/u3Kwz3nqXCsy9/XYu++7beiX7e7DQVq3SpR
9U6+c/Hvxf1pFrCZZ5syxFGQMW6m7t5l1IO0A29eP4lBomyF+TQfc+IF8gSheDIJBglOjgfGNB6w
5Y8qVfUIS1UEnBiw/87uMLVmf6BpaHABhPRyfJCdqk8lnmkNqRYgn+04VHoeSBQK3RrLON/eSu0R
m8/U44v2OuxzhQtGethkZXEmkn07ZADBgPU1fA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinx_2016_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
T8B0w4NG7VzeSrv6OfcmA/Seybv/XseY7U8GEUORMIAwScQx2Z03UxA5e8Bhk/8hBThPu3c4qGXU
eoaU8I28PfmXT+H374KJfpPGeml3gk2eoTP/G4knHDpHTMJM8WdxRt8HBkMNrVGCTjNNJJiNL4x4
5MLjx5MIEs4FN84QBEtV7OaK2Db/KUAZVg9taAs96bhLMwoWhqovfFQMq44lVcgN45iFCZSvOMe9
YRTMUjxireq4/GqruP/WKQ3+VOBTyqfeHyw1WEd0W5Ihmbf/LsRlgkVDHAeb1ngltDXSSiOQpOC8
ZwXOYiOCNlJqGiE2Ffd8kQMyoibJpcoCKTzd6w==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
cJhPGza4HzPv3EX/h4zJ2oYUE+RRi384kwaC4TzqSJIGP8Xumu40jRk779b9c3U8oNRRKmv/Dsfs
w/6FLApe4CShNu6NkIp4hTIHZTCnDvUfGsZRATM1S3AMeqa52ep8i2HuY0is56vzil5GD5rMrEs5
KGhNHywDbdMUC5tgt3GMxOT3gYPc/OwVjWGk5N28YjbQr1FzIb5g56dUcPP3NAzmQKvLkBfdAJ+b
ZVWSBuvJwc0PnVKdO8gbHjh5eWGzrZHlOrh22Di1Q9jjF0/RTyn4ZBT802CSoN/0hl29+NGRbM31
qITXGh7vKMnWdUzT9b2fq0pryjJZz7zEGRNLAQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
hBn916L4mDrt31gET80kQgjSvkwk4ltEGkk0DtigcUmhvvuFh8MbVba3mlEL52IY2f8+yrp0q+Go
p5HnRPjGyyv5+M3d7GL/1yMItaI6XQWdxSvoa7VsEJxGnWCdGrQS5CKiSZKLf+dgwh9vJGfvBGi/
tXhPMSBJtMa9Wjf8DLahEWPYK0MVlmul4Kw+fGciNXnzBngMPBCA0U+Rz+Dpn0+m8gudsZkrfBCq
Ybfcpp5lyabt78bHkdub5gxAa9MTvgjmjqxWq5x+AF4/xXFumBC7pN+hqE3vfLrcqkphR9pyeCkm
xzwerF2X1g9YahklxDpxje+6wx8VxYN2or8D3Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 15312)
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
