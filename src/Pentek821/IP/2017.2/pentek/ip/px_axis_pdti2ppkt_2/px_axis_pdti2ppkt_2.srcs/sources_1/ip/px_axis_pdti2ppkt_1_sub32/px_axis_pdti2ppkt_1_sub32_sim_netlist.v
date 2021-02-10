// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
// Date        : Tue Nov 01 09:41:09 2016
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Xilinx/Vivado/2016.3/data/ip/pentek/ip/px_axis_pdti2ppkt_1/px_axis_pdti2ppkt_1.srcs/sources_1/ip/px_axis_pdti2ppkt_1_sub32/px_axis_pdti2ppkt_1_sub32_sim_netlist.v
// Design      : px_axis_pdti2ppkt_1_sub32
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_axis_pdti2ppkt_1_sub32,xbip_dsp48_macro_v3_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_13,Vivado 2016.3" *) 
(* NotValidForBitStream *)
module px_axis_pdti2ppkt_1_sub32
   (CLK,
    C,
    CONCAT,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 c_intf DATA" *) input [31:0]C;
  (* x_interface_info = "xilinx.com:signal:data:1.0 concat_intf DATA" *) input [31:0]CONCAT;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) output [32:0]P;

  wire [31:0]C;
  wire CLK;
  wire [31:0]CONCAT;
  wire [32:0]P;
  wire NLW_U0_CARRYCASCOUT_UNCONNECTED;
  wire NLW_U0_CARRYOUT_UNCONNECTED;
  wire [29:0]NLW_U0_ACOUT_UNCONNECTED;
  wire [17:0]NLW_U0_BCOUT_UNCONNECTED;
  wire [47:0]NLW_U0_PCOUT_UNCONNECTED;

  (* C_A_WIDTH = "18" *) 
  (* C_B_WIDTH = "18" *) 
  (* C_CONCAT_WIDTH = "32" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "32" *) 
  (* C_D_WIDTH = "18" *) 
  (* C_HAS_A = "0" *) 
  (* C_HAS_ACIN = "0" *) 
  (* C_HAS_ACOUT = "0" *) 
  (* C_HAS_B = "0" *) 
  (* C_HAS_BCIN = "0" *) 
  (* C_HAS_BCOUT = "0" *) 
  (* C_HAS_C = "1" *) 
  (* C_HAS_CARRYCASCIN = "0" *) 
  (* C_HAS_CARRYCASCOUT = "0" *) 
  (* C_HAS_CARRYIN = "0" *) 
  (* C_HAS_CARRYOUT = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_CEA = "0" *) 
  (* C_HAS_CEB = "0" *) 
  (* C_HAS_CEC = "0" *) 
  (* C_HAS_CECONCAT = "0" *) 
  (* C_HAS_CED = "0" *) 
  (* C_HAS_CEM = "0" *) 
  (* C_HAS_CEP = "0" *) 
  (* C_HAS_CESEL = "0" *) 
  (* C_HAS_CONCAT = "1" *) 
  (* C_HAS_D = "0" *) 
  (* C_HAS_INDEP_CE = "0" *) 
  (* C_HAS_INDEP_SCLR = "0" *) 
  (* C_HAS_PCIN = "0" *) 
  (* C_HAS_PCOUT = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SCLRA = "0" *) 
  (* C_HAS_SCLRB = "0" *) 
  (* C_HAS_SCLRC = "0" *) 
  (* C_HAS_SCLRCONCAT = "0" *) 
  (* C_HAS_SCLRD = "0" *) 
  (* C_HAS_SCLRM = "0" *) 
  (* C_HAS_SCLRP = "0" *) 
  (* C_HAS_SCLRSEL = "0" *) 
  (* C_LATENCY = "96" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "000001100011001100000000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "32" *) 
  (* C_REG_CONFIG = "00000000000000000000000000000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_axis_pdti2ppkt_1_sub32_xbip_dsp48_macro_v3_0_13 U0
       (.A({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACOUT(NLW_U0_ACOUT_UNCONNECTED[29:0]),
        .B({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCOUT(NLW_U0_BCOUT_UNCONNECTED[17:0]),
        .C(C),
        .CARRYCASCIN(1'b0),
        .CARRYCASCOUT(NLW_U0_CARRYCASCOUT_UNCONNECTED),
        .CARRYIN(1'b0),
        .CARRYOUT(NLW_U0_CARRYOUT_UNCONNECTED),
        .CE(1'b1),
        .CEA(1'b1),
        .CEA1(1'b1),
        .CEA2(1'b1),
        .CEA3(1'b1),
        .CEA4(1'b1),
        .CEB(1'b1),
        .CEB1(1'b1),
        .CEB2(1'b1),
        .CEB3(1'b1),
        .CEB4(1'b1),
        .CEC(1'b1),
        .CEC1(1'b1),
        .CEC2(1'b1),
        .CEC3(1'b1),
        .CEC4(1'b1),
        .CEC5(1'b1),
        .CECONCAT(1'b1),
        .CECONCAT3(1'b1),
        .CECONCAT4(1'b1),
        .CECONCAT5(1'b1),
        .CED(1'b1),
        .CED1(1'b1),
        .CED2(1'b1),
        .CED3(1'b1),
        .CEM(1'b1),
        .CEP(1'b1),
        .CESEL(1'b1),
        .CESEL1(1'b1),
        .CESEL2(1'b1),
        .CESEL3(1'b1),
        .CESEL4(1'b1),
        .CESEL5(1'b1),
        .CLK(CLK),
        .CONCAT(CONCAT),
        .D({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .P(P),
        .PCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCOUT(NLW_U0_PCOUT_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .SCLRA(1'b0),
        .SCLRB(1'b0),
        .SCLRC(1'b0),
        .SCLRCONCAT(1'b0),
        .SCLRD(1'b0),
        .SCLRM(1'b0),
        .SCLRP(1'b0),
        .SCLRSEL(1'b0),
        .SEL(1'b0));
endmodule

(* C_A_WIDTH = "18" *) (* C_B_WIDTH = "18" *) (* C_CONCAT_WIDTH = "32" *) 
(* C_CONSTANT_1 = "1" *) (* C_C_WIDTH = "32" *) (* C_D_WIDTH = "18" *) 
(* C_HAS_A = "0" *) (* C_HAS_ACIN = "0" *) (* C_HAS_ACOUT = "0" *) 
(* C_HAS_B = "0" *) (* C_HAS_BCIN = "0" *) (* C_HAS_BCOUT = "0" *) 
(* C_HAS_C = "1" *) (* C_HAS_CARRYCASCIN = "0" *) (* C_HAS_CARRYCASCOUT = "0" *) 
(* C_HAS_CARRYIN = "0" *) (* C_HAS_CARRYOUT = "0" *) (* C_HAS_CE = "0" *) 
(* C_HAS_CEA = "0" *) (* C_HAS_CEB = "0" *) (* C_HAS_CEC = "0" *) 
(* C_HAS_CECONCAT = "0" *) (* C_HAS_CED = "0" *) (* C_HAS_CEM = "0" *) 
(* C_HAS_CEP = "0" *) (* C_HAS_CESEL = "0" *) (* C_HAS_CONCAT = "1" *) 
(* C_HAS_D = "0" *) (* C_HAS_INDEP_CE = "0" *) (* C_HAS_INDEP_SCLR = "0" *) 
(* C_HAS_PCIN = "0" *) (* C_HAS_PCOUT = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SCLRA = "0" *) (* C_HAS_SCLRB = "0" *) (* C_HAS_SCLRC = "0" *) 
(* C_HAS_SCLRCONCAT = "0" *) (* C_HAS_SCLRD = "0" *) (* C_HAS_SCLRM = "0" *) 
(* C_HAS_SCLRP = "0" *) (* C_HAS_SCLRSEL = "0" *) (* C_LATENCY = "96" *) 
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "000001100011001100000000" *) (* C_P_LSB = "0" *) 
(* C_P_MSB = "32" *) (* C_REG_CONFIG = "00000000000000000000000000000100" *) (* C_SEL_WIDTH = "0" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_13" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_axis_pdti2ppkt_1_sub32_xbip_dsp48_macro_v3_0_13
   (CLK,
    CE,
    SCLR,
    SEL,
    CARRYCASCIN,
    CARRYIN,
    PCIN,
    ACIN,
    BCIN,
    A,
    B,
    C,
    D,
    CONCAT,
    ACOUT,
    BCOUT,
    CARRYOUT,
    CARRYCASCOUT,
    PCOUT,
    P,
    CED,
    CED1,
    CED2,
    CED3,
    CEA,
    CEA1,
    CEA2,
    CEA3,
    CEA4,
    CEB,
    CEB1,
    CEB2,
    CEB3,
    CEB4,
    CECONCAT,
    CECONCAT3,
    CECONCAT4,
    CECONCAT5,
    CEC,
    CEC1,
    CEC2,
    CEC3,
    CEC4,
    CEC5,
    CEM,
    CEP,
    CESEL,
    CESEL1,
    CESEL2,
    CESEL3,
    CESEL4,
    CESEL5,
    SCLRD,
    SCLRA,
    SCLRB,
    SCLRCONCAT,
    SCLRC,
    SCLRM,
    SCLRP,
    SCLRSEL);
  input CLK;
  input CE;
  input SCLR;
  input [0:0]SEL;
  input CARRYCASCIN;
  input CARRYIN;
  input [47:0]PCIN;
  input [29:0]ACIN;
  input [17:0]BCIN;
  input [17:0]A;
  input [17:0]B;
  input [31:0]C;
  input [17:0]D;
  input [31:0]CONCAT;
  output [29:0]ACOUT;
  output [17:0]BCOUT;
  output CARRYOUT;
  output CARRYCASCOUT;
  output [47:0]PCOUT;
  output [32:0]P;
  input CED;
  input CED1;
  input CED2;
  input CED3;
  input CEA;
  input CEA1;
  input CEA2;
  input CEA3;
  input CEA4;
  input CEB;
  input CEB1;
  input CEB2;
  input CEB3;
  input CEB4;
  input CECONCAT;
  input CECONCAT3;
  input CECONCAT4;
  input CECONCAT5;
  input CEC;
  input CEC1;
  input CEC2;
  input CEC3;
  input CEC4;
  input CEC5;
  input CEM;
  input CEP;
  input CESEL;
  input CESEL1;
  input CESEL2;
  input CESEL3;
  input CESEL4;
  input CESEL5;
  input SCLRD;
  input SCLRA;
  input SCLRB;
  input SCLRCONCAT;
  input SCLRC;
  input SCLRM;
  input SCLRP;
  input SCLRSEL;

  wire [29:0]ACIN;
  wire [29:0]ACOUT;
  wire [17:0]BCIN;
  wire [17:0]BCOUT;
  wire [31:0]C;
  wire CARRYCASCIN;
  wire CARRYCASCOUT;
  wire CARRYOUT;
  wire CLK;
  wire [31:0]CONCAT;
  wire [32:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;

  (* C_A_WIDTH = "18" *) 
  (* C_B_WIDTH = "18" *) 
  (* C_CONCAT_WIDTH = "32" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "32" *) 
  (* C_D_WIDTH = "18" *) 
  (* C_HAS_A = "0" *) 
  (* C_HAS_ACIN = "0" *) 
  (* C_HAS_ACOUT = "0" *) 
  (* C_HAS_B = "0" *) 
  (* C_HAS_BCIN = "0" *) 
  (* C_HAS_BCOUT = "0" *) 
  (* C_HAS_C = "1" *) 
  (* C_HAS_CARRYCASCIN = "0" *) 
  (* C_HAS_CARRYCASCOUT = "0" *) 
  (* C_HAS_CARRYIN = "0" *) 
  (* C_HAS_CARRYOUT = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_CEA = "0" *) 
  (* C_HAS_CEB = "0" *) 
  (* C_HAS_CEC = "0" *) 
  (* C_HAS_CECONCAT = "0" *) 
  (* C_HAS_CED = "0" *) 
  (* C_HAS_CEM = "0" *) 
  (* C_HAS_CEP = "0" *) 
  (* C_HAS_CESEL = "0" *) 
  (* C_HAS_CONCAT = "1" *) 
  (* C_HAS_D = "0" *) 
  (* C_HAS_INDEP_CE = "0" *) 
  (* C_HAS_INDEP_SCLR = "0" *) 
  (* C_HAS_PCIN = "0" *) 
  (* C_HAS_PCOUT = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SCLRA = "0" *) 
  (* C_HAS_SCLRB = "0" *) 
  (* C_HAS_SCLRC = "0" *) 
  (* C_HAS_SCLRCONCAT = "0" *) 
  (* C_HAS_SCLRD = "0" *) 
  (* C_HAS_SCLRM = "0" *) 
  (* C_HAS_SCLRP = "0" *) 
  (* C_HAS_SCLRSEL = "0" *) 
  (* C_LATENCY = "96" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "000001100011001100000000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "32" *) 
  (* C_REG_CONFIG = "00000000000000000000000000000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_axis_pdti2ppkt_1_sub32_xbip_dsp48_macro_v3_0_13_viv i_synth
       (.A({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACIN(ACIN),
        .ACOUT(ACOUT),
        .B({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCIN(BCIN),
        .BCOUT(BCOUT),
        .C(C),
        .CARRYCASCIN(CARRYCASCIN),
        .CARRYCASCOUT(CARRYCASCOUT),
        .CARRYIN(1'b0),
        .CARRYOUT(CARRYOUT),
        .CE(1'b0),
        .CEA(1'b0),
        .CEA1(1'b0),
        .CEA2(1'b0),
        .CEA3(1'b0),
        .CEA4(1'b0),
        .CEB(1'b0),
        .CEB1(1'b0),
        .CEB2(1'b0),
        .CEB3(1'b0),
        .CEB4(1'b0),
        .CEC(1'b0),
        .CEC1(1'b0),
        .CEC2(1'b0),
        .CEC3(1'b0),
        .CEC4(1'b0),
        .CEC5(1'b0),
        .CECONCAT(1'b0),
        .CECONCAT3(1'b0),
        .CECONCAT4(1'b0),
        .CECONCAT5(1'b0),
        .CED(1'b0),
        .CED1(1'b0),
        .CED2(1'b0),
        .CED3(1'b0),
        .CEM(1'b0),
        .CEP(1'b0),
        .CESEL(1'b0),
        .CESEL1(1'b0),
        .CESEL2(1'b0),
        .CESEL3(1'b0),
        .CESEL4(1'b0),
        .CESEL5(1'b0),
        .CLK(CLK),
        .CONCAT(CONCAT),
        .D({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .P(P),
        .PCIN(PCIN),
        .PCOUT(PCOUT),
        .SCLR(1'b0),
        .SCLRA(1'b0),
        .SCLRB(1'b0),
        .SCLRC(1'b0),
        .SCLRCONCAT(1'b0),
        .SCLRD(1'b0),
        .SCLRM(1'b0),
        .SCLRP(1'b0),
        .SCLRSEL(1'b0),
        .SEL(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
mJ+PLYjKLUXjMwYVEVUe0bjwKU4L557171yjEjJtGS7XYhYuTZ2EhxyPWOHTtB6rbJ7dNTpa4+GE
wBtjk1Yb2g==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
KhNdPJEFiKsVcA3vhRwZ9mjxzSg0HP3McYNBsHeYxhzKDeIbU0QGJU/JsE9IK78cwUVGGyv7nosv
ShgEKqDGjEHTs5bChGs9DwyTOj91l50JWJYfJ0B+1z22kPchk4Fqpe/dA9NdiloMAYWh/G80o2l4
8J0b+l7MrhDRQwCLjUg=

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
E/IWYvoiGjNzlk34mDFPjIvEGfsCMF5+MilbaIgK2K3aWG+Moimutsp4HT8zVy6YwSudB1axFp7L
Isza5I7Bq99mEc2S2PAqnH/GZlYJ57DmrrVV2SYLXCkWqUe9qyaX1CxVXQWNFS0VwSsIuT9qGQ5y
xKWC24LxF0GymDWhzPo=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QS2h/dgW5k9f+uPAGJgxFy52DUOQxnQ0E/v373wAdvAbJmE5aDq+hCiQpKjIy4GPR18nf0BhvZks
RspM6uNQT4RbJ0TuXkCg9Lpa0+6DHVRStYYifhXoayvXLRda/xPDCdRoWjyVDYwy31/VtVUUd4sk
WporoUtt67H4PtSQmJtPZpeIUrGdC+kxUF0hCSTPP0g74SGWqjJO6MYy2GpV1LkKC99zUdygglNt
NaN9lwF+nKe4Fg0FvdqhGv6N3nGeI1MJK6txjmhg954ucmXziIj4uwERSPXebVI8b/ZABz/VEbS9
VxBY/edTEMmjFBPAAyi4+nMCIBico/hk9209kA==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
pycQ2fLSVY13WgerGDIXIscwMlm8GzUI80lStjmrI+BFUJvWAeXjSGUMHboPoeLKC4wublBqYtsx
gt0DMJlDYdpjuptV0As8xM9hETwEA3wJtQZRmsnqGPE9m9JRCIQRD+xAicjW/zhztX16wJUIHtWx
l2WVqFeSzjUtrU/RogUILCxN0UcvYY8FdlRpjEF9WwNnZpz1vaFyrA2vYbE/Hb9Ir41wGK+zTWJs
gWEP3XuO3BPXTg4RaVK1UNC2cI/P8ovP1+2Ad8N5Sz/+dX+n/IZ0Q0TOE6fBmh8ZcbmwCxclw0jG
BQhscdUhX/wWXCxVGWwQX/CRuo+hYOuae1iNQg==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinx_2016_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
mAQF9E53i8C7OIv2LDuX8SwOm8wguKByZfIGIplx/BUXP38mOp3CAXU0i43ZSjzf9p5bNnYAdA9T
SVTvziFLfJqU2HwQw4kLAXCTqpx/Kc5kV2cMGlzTB0UKNnSnjZPWTIE2pcMOfN+GXN4XUZ+/sHtE
e+UuO9YRuFV1zYpwtLtHM7EokzmoZDakqLb0EVzJMYXit7Kx9S8d3AwEoC5UGon7KtaLY9OSTPuo
EjbktSML1hmkbUGLhPFpp38+uxx8nTBWs6GJuTksSZf3lOWi9N+mWAvgw3PPhyPT/3ERw30zvMHz
TtsPw5PGrfcFsOmvqIBfVP/KSHUFfNnS9SyhOA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
IXL8M+qoqwXU9XCMPc6A8pSVEDL7l/moh4wbJ6usNBAvAIH5+x7GrfXmjwdWar9w79MP0473x9on
OFdcZUhbjDEuHCmtAjYHsHDjHGKT2wFSUh5EZKH/z5UrYp0mr4NALY9EXLnYdzBakY4KAfvH0zsB
h4LNJ+A+FzEEYamcI+Diwkq6/WRoid9Alu734fGoWGGBreP6q29ueMOg69cGrEC07wqZOMlU4LCr
wNdw77KTfZdp1kDB1y7Yu4lhLOX0Siel5vrBZs03URFBtQwGhD5TXtJE9ExOrOrLQCDSjJxO9gjv
Sa+ZvebThMbAEkC+Z18sEV/YHkAJVsoiaRXGcg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
ASQK0bKCkVFCfim5iVsDqA8ofAV2ErgK4114/O3KNQ5Sxb2JeBoLvRnKgTZdaL7TI8h077fPMy6J
bwavWcGgvfvLSZtSL38f8sju8GpCVDjAt1I3ef39uBuFufnBkIo1t5a1O59qGa60ZOJo54teQwRP
8n6oDjQ2bAjYPJCN1opzIGXZKm0++ClA4OFgW3RgQ9SJOrnHVOWnOiSC4TPoHv46mumpY8pBEItd
9+RzHXd70O5nVceRB+DRDie19Xt6TEPH4HhDatDczrl/NFGoO7D2WcIbFyFGH/05pvbmk3wWBqQh
vxGvonD6pfC8nhrPDB+UQLYxeZHeNoez+YqE4Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 10192)
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
