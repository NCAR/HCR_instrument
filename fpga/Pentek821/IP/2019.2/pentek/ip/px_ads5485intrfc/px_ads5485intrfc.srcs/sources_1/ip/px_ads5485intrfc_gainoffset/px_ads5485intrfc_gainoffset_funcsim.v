// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.1 (win64) Build 1215546 Mon Apr 27 19:22:08 MDT 2015
// Date        : Fri May 01 21:05:29 2015
// Host        : Igor running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim
//               E:/px_ip/px_ads5485intrfc/px_ads5485intrfc.srcs/sources_1/ip/px_ads5485intrfc_gainoffset/px_ads5485intrfc_gainoffset_funcsim.v
// Design      : px_ads5485intrfc_gainoffset
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e-es2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_ads5485intrfc_gainoffset,xbip_dsp48_macro_v3_0,{}" *) (* core_generation_info = "px_ads5485intrfc_gainoffset,xbip_dsp48_macro_v3_0,{x_ipProduct=Vivado 2015.1,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=xbip_dsp48_macro,x_ipVersion=3.0,x_ipCoreRevision=8,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED,C_VERBOSITY=0,C_MODEL_TYPE=0,C_XDEVICEFAMILY=kintexu,C_HAS_CE=0,C_HAS_INDEP_CE=0,C_HAS_CED=0,C_HAS_CEA=0,C_HAS_CEB=0,C_HAS_CEC=0,C_HAS_CECONCAT=0,C_HAS_CEM=0,C_HAS_CEP=0,C_HAS_CESEL=0,C_HAS_SCLR=0,C_HAS_INDEP_SCLR=0,C_HAS_SCLRD=0,C_HAS_SCLRA=0,C_HAS_SCLRB=0,C_HAS_SCLRC=0,C_HAS_SCLRM=0,C_HAS_SCLRP=0,C_HAS_SCLRCONCAT=0,C_HAS_SCLRSEL=0,C_HAS_CARRYCASCIN=0,C_HAS_CARRYIN=0,C_HAS_ACIN=0,C_HAS_BCIN=0,C_HAS_PCIN=0,C_HAS_A=1,C_HAS_B=1,C_HAS_D=1,C_HAS_CONCAT=0,C_HAS_C=0,C_A_WIDTH=16,C_B_WIDTH=17,C_C_WIDTH=48,C_D_WIDTH=16,C_CONCAT_WIDTH=48,C_P_MSB=32,C_P_LSB=15,C_SEL_WIDTH=0,C_HAS_ACOUT=0,C_HAS_BCOUT=0,C_HAS_CARRYCASCOUT=0,C_HAS_CARRYOUT=0,C_HAS_PCOUT=0,C_CONSTANT_1=1,C_LATENCY=-1,C_OPMODES=110000010000010100001000,C_REG_CONFIG=00000000000011010011000001000100,C_TEST_CORE=0}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* x_core_info = "xbip_dsp48_macro_v3_0,Vivado 2015.1" *) 
(* NotValidForBitStream *)
module px_ads5485intrfc_gainoffset
   (CLK,
    A,
    B,
    D,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) input [15:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) input [16:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 d_intf DATA" *) input [15:0]D;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) output [17:0]P;

  wire [15:0]A;
  wire [16:0]B;
  wire CLK;
  wire [15:0]D;
  wire [17:0]P;
  wire NLW_U0_CARRYCASCOUT_UNCONNECTED;
  wire NLW_U0_CARRYOUT_UNCONNECTED;
  wire [29:0]NLW_U0_ACOUT_UNCONNECTED;
  wire [17:0]NLW_U0_BCOUT_UNCONNECTED;
  wire [47:0]NLW_U0_PCOUT_UNCONNECTED;

  (* C_A_WIDTH = "16" *) 
  (* C_B_WIDTH = "17" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_D_WIDTH = "16" *) 
  (* C_HAS_A = "1" *) 
  (* C_HAS_ACIN = "0" *) 
  (* C_HAS_ACOUT = "0" *) 
  (* C_HAS_B = "1" *) 
  (* C_HAS_BCIN = "0" *) 
  (* C_HAS_BCOUT = "0" *) 
  (* C_HAS_C = "0" *) 
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
  (* C_HAS_CONCAT = "0" *) 
  (* C_HAS_D = "1" *) 
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
  (* C_LATENCY = "-1" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "110000010000010100001000" *) 
  (* C_P_LSB = "15" *) 
  (* C_P_MSB = "32" *) 
  (* C_REG_CONFIG = "00000000000011010011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* DONT_TOUCH *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_ads5485intrfc_gainoffset_xbip_dsp48_macro_v3_0 U0
       (.A(A),
        .ACIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACOUT(NLW_U0_ACOUT_UNCONNECTED[29:0]),
        .B(B),
        .BCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCOUT(NLW_U0_BCOUT_UNCONNECTED[17:0]),
        .C({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
        .CONCAT({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .D(D),
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

(* C_A_WIDTH = "16" *) (* C_B_WIDTH = "17" *) (* C_CONCAT_WIDTH = "48" *) 
(* C_CONSTANT_1 = "1" *) (* C_C_WIDTH = "48" *) (* C_D_WIDTH = "16" *) 
(* C_HAS_A = "1" *) (* C_HAS_ACIN = "0" *) (* C_HAS_ACOUT = "0" *) 
(* C_HAS_B = "1" *) (* C_HAS_BCIN = "0" *) (* C_HAS_BCOUT = "0" *) 
(* C_HAS_C = "0" *) (* C_HAS_CARRYCASCIN = "0" *) (* C_HAS_CARRYCASCOUT = "0" *) 
(* C_HAS_CARRYIN = "0" *) (* C_HAS_CARRYOUT = "0" *) (* C_HAS_CE = "0" *) 
(* C_HAS_CEA = "0" *) (* C_HAS_CEB = "0" *) (* C_HAS_CEC = "0" *) 
(* C_HAS_CECONCAT = "0" *) (* C_HAS_CED = "0" *) (* C_HAS_CEM = "0" *) 
(* C_HAS_CEP = "0" *) (* C_HAS_CESEL = "0" *) (* C_HAS_CONCAT = "0" *) 
(* C_HAS_D = "1" *) (* C_HAS_INDEP_CE = "0" *) (* C_HAS_INDEP_SCLR = "0" *) 
(* C_HAS_PCIN = "0" *) (* C_HAS_PCOUT = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SCLRA = "0" *) (* C_HAS_SCLRB = "0" *) (* C_HAS_SCLRC = "0" *) 
(* C_HAS_SCLRCONCAT = "0" *) (* C_HAS_SCLRD = "0" *) (* C_HAS_SCLRM = "0" *) 
(* C_HAS_SCLRP = "0" *) (* C_HAS_SCLRSEL = "0" *) (* C_LATENCY = "-1" *) 
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "110000010000010100001000" *) (* C_P_LSB = "15" *) 
(* C_P_MSB = "32" *) (* C_REG_CONFIG = "00000000000011010011000001000100" *) (* C_SEL_WIDTH = "0" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_ads5485intrfc_gainoffset_xbip_dsp48_macro_v3_0
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
  input [15:0]A;
  input [16:0]B;
  input [47:0]C;
  input [15:0]D;
  input [47:0]CONCAT;
  output [29:0]ACOUT;
  output [17:0]BCOUT;
  output CARRYOUT;
  output CARRYCASCOUT;
  output [47:0]PCOUT;
  output [17:0]P;
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

  wire [15:0]A;
  wire [29:0]ACIN;
  wire [29:0]ACOUT;
  wire [16:0]B;
  wire [17:0]BCIN;
  wire [17:0]BCOUT;
  wire [47:0]C;
  wire CARRYCASCIN;
  wire CARRYCASCOUT;
  wire CARRYIN;
  wire CARRYOUT;
  wire CE;
  wire CEA;
  wire CEA1;
  wire CEA2;
  wire CEA3;
  wire CEA4;
  wire CEB;
  wire CEB1;
  wire CEB2;
  wire CEB3;
  wire CEB4;
  wire CEC;
  wire CEC1;
  wire CEC2;
  wire CEC3;
  wire CEC4;
  wire CEC5;
  wire CECONCAT;
  wire CECONCAT3;
  wire CECONCAT4;
  wire CECONCAT5;
  wire CED;
  wire CED1;
  wire CED2;
  wire CED3;
  wire CEM;
  wire CEP;
  wire CESEL;
  wire CESEL1;
  wire CESEL2;
  wire CESEL3;
  wire CESEL4;
  wire CESEL5;
  wire CLK;
  wire [47:0]CONCAT;
  wire [15:0]D;
  wire [17:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;
  wire SCLR;
  wire SCLRA;
  wire SCLRB;
  wire SCLRC;
  wire SCLRCONCAT;
  wire SCLRD;
  wire SCLRM;
  wire SCLRP;
  wire SCLRSEL;
  wire [0:0]SEL;

  (* C_A_WIDTH = "16" *) 
  (* C_B_WIDTH = "17" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_D_WIDTH = "16" *) 
  (* C_HAS_A = "1" *) 
  (* C_HAS_ACIN = "0" *) 
  (* C_HAS_ACOUT = "0" *) 
  (* C_HAS_B = "1" *) 
  (* C_HAS_BCIN = "0" *) 
  (* C_HAS_BCOUT = "0" *) 
  (* C_HAS_C = "0" *) 
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
  (* C_HAS_CONCAT = "0" *) 
  (* C_HAS_D = "1" *) 
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
  (* C_LATENCY = "-1" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "110000010000010100001000" *) 
  (* C_P_LSB = "15" *) 
  (* C_P_MSB = "32" *) 
  (* C_REG_CONFIG = "00000000000011010011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_ads5485intrfc_gainoffset_xbip_dsp48_macro_v3_0_viv i_synth
       (.A(A),
        .ACIN(ACIN),
        .ACOUT(ACOUT),
        .B(B),
        .BCIN(BCIN),
        .BCOUT(BCOUT),
        .C(C),
        .CARRYCASCIN(CARRYCASCIN),
        .CARRYCASCOUT(CARRYCASCOUT),
        .CARRYIN(CARRYIN),
        .CARRYOUT(CARRYOUT),
        .CE(CE),
        .CEA(CEA),
        .CEA1(CEA1),
        .CEA2(CEA2),
        .CEA3(CEA3),
        .CEA4(CEA4),
        .CEB(CEB),
        .CEB1(CEB1),
        .CEB2(CEB2),
        .CEB3(CEB3),
        .CEB4(CEB4),
        .CEC(CEC),
        .CEC1(CEC1),
        .CEC2(CEC2),
        .CEC3(CEC3),
        .CEC4(CEC4),
        .CEC5(CEC5),
        .CECONCAT(CECONCAT),
        .CECONCAT3(CECONCAT3),
        .CECONCAT4(CECONCAT4),
        .CECONCAT5(CECONCAT5),
        .CED(CED),
        .CED1(CED1),
        .CED2(CED2),
        .CED3(CED3),
        .CEM(CEM),
        .CEP(CEP),
        .CESEL(CESEL),
        .CESEL1(CESEL1),
        .CESEL2(CESEL2),
        .CESEL3(CESEL3),
        .CESEL4(CESEL4),
        .CESEL5(CESEL5),
        .CLK(CLK),
        .CONCAT(CONCAT),
        .D(D),
        .P(P),
        .PCIN(PCIN),
        .PCOUT(PCOUT),
        .SCLR(SCLR),
        .SCLRA(SCLRA),
        .SCLRB(SCLRB),
        .SCLRC(SCLRC),
        .SCLRCONCAT(SCLRCONCAT),
        .SCLRD(SCLRD),
        .SCLRM(SCLRM),
        .SCLRP(SCLRP),
        .SCLRSEL(SCLRSEL),
        .SEL(SEL));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2014"
`pragma protect key_keyowner = "Cadence Design Systems.", key_keyname= "cds_rsa_key", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 64)
`pragma protect key_block
Dusvt8lOCTBYLD6aZ9rZ9OrcV7BbXCTn7s1oB9SC8go2or+dLZ/qs87n5S33gIbMR/jN458Bym2p
0u/ay5350w==


`pragma protect key_keyowner = "Mentor Graphics Corporation", key_keyname= "MGC-VERIF-SIM-RSA-1", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 128)
`pragma protect key_block
eu6EUsjU198BiNeW0bH+myzrxufoK/pElFPzPnVb015NYOe3xXmCj8xvILKKeAG0SpPFRUx2pqTW
a1IigshoB7AW7+t21welh5wQamd7pe6nl5O9MYP9l7fz2e4JAuULSOfIWCgJxYjfv7artu4Yw/58
wV27haRRErOSV24nSqo=


`pragma protect key_keyowner = "Xilinx", key_keyname= "xilinx_2014_03", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
iocYGkOtuPLdXUXHsb8N+kb1RxEOWBMLFlVmPCPeppmv0aLka6/PmDZl7EFXtvP+a8E/aY4uNuYL
Xq046/MHimV32hJT+ZqHhLIIYOeY08O8bZ6pPzB7C1TJS5XXQMg+C+N6zk/vNcK5OwYEd/t7MAIB
c0u3Eyr4DoxxqbO4IXmj7pUVk8c3xG3IN5MAnt6TK3++M4h3tOtTkPVg+CA17CVM5rgEpvFzWLQA
gLw30pODFZqsl2sXj4BaTLePCAT2uL58OErj21AkB+SYwaAXcycH62+wrbkIr9CpxB3RoVfPhENX
r2cFY4Vrxk3KT17jdDSAX3huCBHas3CA1LffCA==


`pragma protect key_keyowner = "Synopsys", key_keyname= "SNPS-VCS-RSA-1", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 128)
`pragma protect key_block
mmVFqNf2dfmoyTKbUcoZXU5oY1j2ySXt9GB9Xlv+ipAqxK0AOS+0wwWJu7WiNVu+pGLKAlG+L7eI
AGEpsYLYl/6C7pZWJmkJb2VxK3YW+K7nI2JeJZgnX4FB7jdASgF0eEZ+LDxREr9RZMn66/RcJDRN
2lZr2SvdWQCNy+rDfLs=


`pragma protect key_keyowner = "Aldec", key_keyname= "ALDEC08_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
QceRhNZ8HVfE0sOpbqfzHUWEgG0HoSccb8Rm8+9T1TF7oG5vyFPO5qWzbRUV7JbaOaU29RHM+7qB
qecw7Tx4/K+UIs+NBlLz6f4gE13Jrmbj0aXFAIRsMQ91qxQqW5+Db+08FPat7FgUNfjFaa8R9F2k
hmilClfRL584b5FHK2Vbba9RJ+gryOrAKqVoWDJTnmtESp2mWwFl9VDmMUx35Aiq/Fsybs8Nb8yI
PGWhsfoTldjrtGdwoor7W/duzNCSAxUbN9asCFWd+xXsFRAT4Tf1w0cAJL7cJERfGjytHYvy5Oq3
kEWTDDLxaFKwhmcPNXqWCDSrYO8bSTN/eJ3KBA==


`pragma protect key_keyowner = "Mentor Graphics Corporation", key_keyname= "MGC-PREC-RSA", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
RbzdUBrltm3yJ0+6fG1Absw5ZSX6n7Bk6OzhkIPOvefL4hEwMljBk4xpDjIHuuS4sFsIArSD18af
DocSB4/5Z1wwTgJAMdrNIsf4Xpmd3s5ZrtVK4UKAiNAEauEsaiv94kXqinwVDp+Tj+g3e2YOJQH+
D/+oUk7bkvHNq021bJXbC5/GNyuectvvLu4ncBbWlf/FY80uAzaCRcMF0Culx969r1Z8gpPW1/6G
fANaMgZ+jsGzfhXzPr7nU0Ur8nh9IPHcOPUuo49erosMMmgZT1RjxV08/EAxIATjWnta7yYcqlf9
0ubm1l/c+ydRtg190ea3/DVKT6Btt89fs8Y00Q==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
oBFaSOcsnHOx7hhiip02akq55YhMm7Fldury2/N47ZxOHekat+6huuyMsETR/Re8Pbct9ZrqNTUQ
37/R3eENKwfAp4xwk3fGdY4iM4Bpc0ulZ8iZsSp1Unc4zLmxOHINPwAltC/mfIeGMA3HwNEiIktt
CgDsEIZO2BVicOGeHt04kvxQxa8Qlr9rkkcqLFgv9xaA/ZQOEf9FrvqQ9rcpc3xTF8nUYmNnVRhK
ftzs20MMubfgSfaF46ht+9AcuGUsrqJaNwaleWzIws96XIKnUpxO9Fk/ONvNqh9h8cfBmwJyLNzd
agHr8/IfCuUbn+ys9WQqt7DMkZjO6+HE3NNTZA==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 9264)
`pragma protect data_block
QQIYGyK5sMkmGmB9zcaSbF1ivjspwLgq0I4+EIvcuck4B/6tUgu26JMliWnR+ZoIHIvjLc3rLZXL
de/HGHnlNxBuFB73MrQdC1K2kV651bCNMuxCdN4x0OZWuSBBHXhBso9aViNuozyHdUsT9YyL/H0t
uXItcWOYB+Spf426cDlq3eVxE2GTyXlqpSMtoKqwcmHXLqKQ+ZmBbf21rUcExVRcM/vZV1BOc9I9
ZRpOHmOJxHAhFyAFNKdNXkWgR4Ok4QohVfzYVzcEdgFWIozV+F9C3AEi6CwwhGE+zvtQVYmnuN8O
mA3XI0mGLS/tREAu7I5iYO4i9L8nl6lL6Qld2STT4J7g5wv8BxebJ0zAUu/0Jmu0hmRXff3YV2eB
Her41g07zhhyz2+ElMOsSHxEknU/GAOdjmEFxMOKZhxrUMAZ490aje/rLJtMYK4v8GHGdpbnolr5
C/TGLnAiY2Cs3MlK42rjTC4sfJCVJZw1GBLw7WfVObZc+UDoyiV+MIGxH5NSMOAw52L8miprxxGg
K8Fze/uvPl/ljDT0K4tApdJahE8WZbdXLXBBKAzzJefsdjp+qM9tTsoUHvVq3CGaOr0841jggB8d
74PFjzF1wmpYjIM2gafMYRudb/z+rbrKl+xnPLsjvO7e6PBMNCtSiTtj2Jj/4Wwctk+WnUwO47vr
JzJvq9SNA00cw6NmU0Ab1i4QaSaroz+F5bpPXUxbCZyTCrAWLkqzIRVU+UNFQ2nXItTzUU+NFe7s
uVU8grcTTPaxSIEa2h1dGAkSiLgQ3UNVqn1cVhYvZYzNPcwGDZUDpeP1ucRSYG0R3wMEBlq/i1Hv
e995Yt6F2gr3EQ2DqYm58zhPRc7xSzsVavzee5O8hakOSiX3g+w+SAUnH0fKgbZ2OJKud9y8qXhI
9+lzP3JWGFa9TzQo31+4PWZWsXAQEfM7WnWqHrmMrwuTcvUWaacdsakguiUQVwvws/xYqQJpWzEy
0O5LncZVLyJulBhZ0oNqfuRmiW3NHD3tNIdesbS6K9wTAIJwS7BjM+PiRdN8fFmUey4/fCAxyUq+
etFxPGU7kxT9gTAQBWq0d4p5luVYZiNgupUgIjlJKWPIkAgoTzjxxt8u0lOzXBAjisqeGzApFlqb
8my+JWO7U6LFOc0DmK5BkwHo5S8kZSiKzhTI/kfVj3Z6i2H78JVpcHKhVgEJoAs8cEockinH/WCo
y4LKNuOWqHTq5G+lYkOmU12BLT/i7DnDQPwq0oi89NnEitrQtsd9/d8RVghjJxW+O+4EU0ERQ2yc
wOxA0aFqIq6m+TD8OJC9tfgr0QUnc3WYvYYLb1uOa45I7JyN6wMXoz/YDjgAomCCL5D58AZU53su
vfL3szQAoN/m3c20GfKJezZEaB/F5pmMIcdfLXiNo53AknCHG9SJZKiHGZ40C2Zl7wR8K4Gx98dd
3FTPakHysa4bRAVyqH3hmzhd7FhQZKmSn1kaka+PYo0IZCiOX4sePm25y8/TU/wBz9TlJmNF6CsU
F62aeKExgXwMbYjAoXzoGE2mU1rEA6n1BYpkQQBlMQ3ogWBFjsGVH5OourM+kGoL49YPK2r1JPSA
iYMcJ4DKCI+Y6OcynC6b+TI5GvzJMHKGfgwu03jlcZhCzhLmcei/oZ94CrjCF6MrUazkFan5aYLy
wsq8ahOhCy2CYgy+oAQcWS0ECvz71XrZ1P7azr7SoQbaQcjYkxWkrIURvH+Rf/8aanociJeJumFv
wU8ELag3mAI4oRTrlx1VrzxN5JqLWpggCwgmGa7wogCDhx/Npqlq4DJw1p9ZjR2/9UdGSK1yGMKf
XNyKWow5dJ5IGodQxB5JhovfKJi6MvDcELLPKH3EOlwkH2GxrM3A6dpDSrtaMKFLhuXEG9MC2wD7
ZdPzFexVJECYSEN4YMkXX62uKWrTwsO0xNrQ7EHPq5eslCtlJ3GO/UoaUIQ+EJcNdqUVWK3zKNmw
X23/n/MQq6uhbp6ITsBx467di4oF6PXlRmxjZMME2txRRRwmvVUNQXTkhDnRE1cV4nKWqvgl+jsk
A7iiXCMAfnpzHwjxNucmdMLJSl0a1sBqf+St4E11s+Hx2yfh73Hazi7OuqHdxxs5w8wsUvtraj2e
TFQO3IKdpuWjagBQTCz7Uv7Mkup8gUNJtdKmd30p37NtwcUhuTNJeWVP6ClwKHo2lbywJwZZYPGn
D5GdWc+2s0r/yT4MmOD1szNwbP/ikLgdFNNn0fOwJGoKB0uhd2mGiLrTRNCmXMfX7zUfFUHl/DrC
PakM/dP8CLXvIxV1q2cJ+v47t/jqmsUJDYRxVkM5+G/zAldgdrOLRJlUatctlRrotCkoS4JwxBiB
/nzlnYZdQIWuid44RvOE16331HwdK+uqvoG/BZ6KWv+mdzvIAtE6Y6+um5mbOmgZiEKmND1t7UeA
IPG9oJ/VrpvhniNa7eB7mrTDRU44zNvzVIatY+dVqubrCuogLXU7jAsw8v6YXbZLj46s6r00tbPz
KYbYJTcRQt1rSkh4H1N4VG7Xhx8DD4h0NhtNBMf7K83Zhk+V+OD/Nmi8UbBnwmFvQL5REQIX7xbX
52Nub/oFQy1hWYU0Nu36bfo0XrRsi6TqJ2qUYNk2XIYNbuJ3/kuQd7UXY97Itz5yAbAxjA8obEle
sl/9HCx3x2mVSFW8UZvj6b6OwythcYsbAnbb0kcDm2YADOcexJprl9RUE/3fXPoKpq8JWvmFGiOn
D6/Ep1qhA7OBQ0/htwfwYKuWqG1h2mTQfDfz+xGxzxchAhoflm1U/VZ6v1b/s8sl+1JOW8APjuh/
DQbsakhqAYg2l+njq9svY956C0AhOSNurv2I02hKlXr++QQzrKLAuIOzrEw4Oygk4KukYds2tAqD
Zu8eKwdkHbViVqGCaV51U7xeKuNuFTsMVX6SHaVsxwKka0jcTb//CqLX+gAq4fFeKTCenVs3CQft
rcee4t7QMmF/Kpp62w7dNkRa/gT7ejmUl3a1YI+vET5x+ZA0zUTeWrwqN1ORNU+tSLm3EbnodTsd
OMI0jJjtcWONaJzgIFOdG05xJ29pwQHEzMQ//IqDfQ2T/wjtFshwOMgdHBuix6byX31NkePb+KfG
kSy9569PKJORM8g0U3JqT7Zvp2UspSHHybNwXs8tkD92+oVuTLwZk7UIKoLu4CgJ3cUt2kokSz8J
27eEcFswLKpxBNvdJ20yie5lb5FIGbpKO1ipSBulwcTIP75wLr9VcPTuegWJHWDuJXlKxy+7Van9
tDRFdR2eeNXZxKFLVph1FdVGh2Bh0wc4qT+vXeNldhmaetY+hUb+Zp6z7pyHztqmNVY4BE6ko8ut
60rre4S8ntPtiRlHbwlKUYi9tpu40urtLz/fbrhFs3LBg08sqtuZ0ylR8A9uzUthRsvkswWOS4KY
TZ/VDJpCBzdUNKlQGyULCSTSAhucdrtGtwWW7eLDnTW2POuKHu9/gwDJsu4rc1pIQzJ1Q/wr9T9i
mY4Ns7WMSD5Jse13rMNq5IBuwZ9NTq2pJ2g7woflVQCbDFSojwcynkg+1Pd2NC5oPclZ3PG8zlo0
3n8wK0lnhDxMDTHLROVL+ujx3cjOrv6JNEKzDHoKnQO0eh7xoYXlZVLspVlExqiw56wUDiXGqJ8E
pVWXAmYniJeOBW7g3EJsdnUev2YT5GTAEwveHIBva1Dh1TzVdcY8ZJzgibDMQXCNpl7rN9xKo1bw
+4A3eYR13ZYpM0oWqSMHMRvHflhQuwHK1otXkTJ1nPE1qVW3uRJiwXurufudITo8MEFn2MHKjlwy
kSmdcwPwZaZD2uPe0LUUgcYB+5JWqpNhxpK9itBEafQQkH6ysC6yOopG9FQzKHz8ZFOA7g818jUT
FqUPmz/QRj5M1WWWyj2zaUmloZq/qZl0++HHuM1JbERP2gW9YnfnF0marPdKVeR5zRi6BIrSsmAB
zXQGdHqpG5iPTwWl4NHeFFsnaaz7h0upDPkAPM3kj6NcdRdEtyuGNlgjmn3/5Z3dipw3wlLCx0yw
KN7uC7thSJiSyClsf4hLDZhzqe8TSpqAQAKGfCA/XEThzqzmCF7yUqAdzsIbSmZ0eN3oCrLy04eG
/BC7IFGTuStd8X5Fk1MyE9WtjOOpbMels8Pt6vKPW9IIRLcxmqVn40MPTINoEE5gkNK/qvT5nWTV
wq6hjq4cvdBp1D5abLKRoasepcZ/x/OnMok+DLr0RPtdV3HYBRfQKqAKKVdslacaUzWoWjMzqZPu
w66mpYgEOltnTUkLg4qT1u3bt2T2V5Q1qYbV62VL3+OPOOP5Kp12NG6vYPZRb9TeILxlWPFR4MJL
TTs+8FpR2VcPGqvAZevMO4KGOkgUQMGUvWFt6L97gZ4YHsthicpMT+aj8U3mDcqtPXxDXXU0/37B
qGMMt2I9xRPw1DhwLilVhTQQqB+lfwx7O13ki3fGIFqYOVf33GUa1BucRngPz3QGvLcJXmwpUj1K
ol7GVQbIVzxopWa5KoVXLXTtsV+2KUF2nv+kjQS080DPFK9afPc4xdPIuyvBmDmM+VPA5kBgwRaL
QsfHoQPpc66P2S3GY4bCYIoTqki+Y/x26LBHJ0angeWsuI8Y8D1TdZCT+LeaVma9HFo1El9Z372U
cvn9ujm2ve+7Xao+HT1jKcjy+H+36pfp1NZbvIovqVcifRH62MS2aJv+ZqbNuEJNRSlyO2wfuh0V
oRWW4ntpCD6Hc/qfROaenDp5jKDN6xIA3wgkBVwp9A06zAgcAL8cC6dy22oN3oCIZXMgC7k5LVEQ
LgrXaFe5AzGti6XwTf5U8zdixRVgNuu0jxti0d+gXJt7Xp0d4p7pRdeX5tErMfob7Uqs0G0xR0cX
5BoIh1YLzV/Pg5VET9nwC70l14CXaHFR39dg2r2BEMFRVIP/AShGclWo8/ujImcvTU3BGGbPgdov
fkDhLbvkiNJQxVQyAs2LDMf2/mYvAzGRD/DoOb1RuVb8Tb2laIk89w7FCgExXHkGtB/2BNYpdiKL
7GN4i/4g9+Egm8nHPbPCqXhvam26oD+BuANeMVaPKrtaH6ZlYnR5wBcDi3zOr1OaMc3D2wHs8EO9
ZzyAoBUMunAh+HmN/eCuGNkcTZjRuEum5MuvcRuZ7xj2SeCG9Pu2vlvizvvtRywlbTBLm+hgRfHf
ZCDKLvjmL/aguGB/nj7Xz2/ITxHmrBS4+ofdbvfQeDjHyqRA2OOk6BfUpukj/k0kxCzqJOw9RogF
/2MJQmSnUCW7qy2DRgWUJ8IfWDvcgnAQTAggZ+uVbiO2LPULd+sDn/MR3IVW/3CPMy/qOxiYh95M
xu2gYTihk3ru0KG5niI+34/ClHQcVy/QsKKv3Bjangupv6vU/ivSuTVH2DwgJOuntjIfeEndxvBi
8XpTcYNoUE5VyUTbneJRL0kBPQee8bwR+91zLQq+SPMDOqwXYcmPit99dCaZF35ycfyZ5GRfHqJB
DDFbeAwawHkbTSjlVmtvXJp0B5bYQeGzHBOvWWBBMIpRmCxRrlzGOQ6uV//RafXOJ+sPPAnQO+nk
/8OeLHQTJ6DK2cXgk1jq+PAJ/fRONxfr6guuzaGQIiIjZl+zaA/sa3Yp8xXIUCl9SfH9thOyVRHH
oM8z5JHuzJGczDmsLr/SyFHi9SCA8KbZkwWTFf3tyWRqG5/B+NSfDkBdnIHx6Z6rmV/iTJiWvG5b
cSHYNVMhR+xAQreOaCTbwz4ZKzQZQ6BPxOo98vdi95HlizCw3t8p1otTF1caZJ0ZZakRM5w2V88Q
Ygec30f3rlyON0A9a8Pp2jwmqlCgCSoabIbDxjzwBxcEpukjXj71MuQMktTx8vXSDMlkGn/bRxWY
F7XWSokKFGgTe6AOF9DFGpWCxth31DYo6fSgz/XeG8TKggoShaGxBRow25rQMj/Ee3tTC4hNa6i+
X+MZf28RgBRj88kwTlbSnogkPCX2kFB9RfXlNK7YyoEU73WuneeVZXkh+/B1T9eoeTy1V0JCArf+
R7cwH6w+cpMocI6Juplq7L4H9UH73NwpssInFDIjdNsRnvmYQ3XBqfxSJ5Lwc35zg/iISQOITwPu
mYVwaO0TGGiH3D2jWmJMReOSAXPnURu7LSJ+jnmErkoE7yVslBo1Lsrk+daQJAMknjAh6vItgISz
ToMfcneztSMtrsZIVSxOsg+EbCXxGuG5OE8V8d/Dd7gXRyilJZobeik/IqbAABLli5IebSAKz40r
e/rgSDuvFAvBcmC6jxpkSEV+Fzg3oCI/Cdj/F1EpAPXpsIujoAOJog+UyjTkThyOUImmSX5jxNPo
IqZcFCGjF613uMMPySKzV9l3U9DO0kv2riypu1SNMqZLe6TEJwil7lTMNUi/hXL4O6+7ldR/efAk
Ncw7eaJL3KbGw950ZWQIjYeXkRi4k5N+iIWNM4b32YW0nYza+IVxjCAXJjC5QSAYMnMpV5bH8pqe
aFmMeZz0jfbBHG3xdO9D8JXNxtlk6T3Suwtb2xXuXbAnqUcVoJDQjtZpDz6+wfukMk+PHWZabjWf
zkMZFpRt9kZPVyVpmCfm1+9q4LPgbVtEG1sqS4pnAeoxGr3iFbQWMtF+XXX6n1N5pOs4hMh9U0qA
uQfAomKsOb8LaUfXYUL/gMLaiv00nn7iTRTiSl8HDnTzSHwCsC7M8jEVnhYoCWBqW2k9Gd3bUyGK
ocT++riPcfA9N2Eqxpr8TDQRcZHhLCtHevZwJPlG6uCIrwOPBdeSQnfkQrHeU1nNA/zb/LC4xwrO
IA7gZcQWbISevetaWZLddwEaKZ5hrRh/r6kGmfXkGZ/FGYZEqpP6Rv2wWGRveDpAQpjJHEy6TCmV
OfFIhm1U8tQgyQyKUYwgjlJpc+AACdmWiOxGy1hHAZoDgWuJP8iquyLUrL1tGKfAniCqJJsTAjzx
fic1CsxsrBQ+oFKtunfytDIz93qqGzYLyAyzXe23odh72BQSmAzX8TgygBGDGjs3IBx7h4fSCL80
p7EczXZos8zbux240JdzZ80I+WHzvNd4codLUgprYQGxhWgLQU8gX1qRs4xbRWCfOThjWNlCn43m
R2+fFFK3jozMgwmqKLTDOWnVSTvw9VnePSx1SOThH2eRk4kVQiv4/ZyBVI7YaAL/R7etRlnWaoT9
+3IfFZJRg1Qb5nbEw6s7bqFDAAW4rDtn8WGwcb/I7BbXFXXvLirBSEhw8+eZ3j+orZRtdpeXOuym
TLePmu77BB0Eod7OXqoV2psAYfvDmJ+dR/7VOxerejxqAg4XbfOBoLWXsc6EpoiWR4TcdYkUIUU2
ZPwUyNKpHQciMMKwOuOiCHoXR2uBudx5bMxaLX2PWL3OqaG+WHSR8b11hRJBUEsLTeFPmE6DTOLa
YZ8K6hr68q26klWJN8jCfrLWmkGZVxJeKuhAqMu4yU1bbEearbOTt4Cw4FbFid2brCXdXHG/WbVC
u88eGPItEUBj7A3nIuPRGpb5N/HO5zQSZJ/xFg3wXIBO/DuI8IEml5kqZzcmTH/ZeNOxarG7RQeu
2wIscrYHjT60kVb39AupckH4vMryb5s89U/leXfMDX+7d2aHDfA3sn2oNfEFgvJE4qAg/waJr14h
sL36S8RabGaGGDnSYHnaKs2aTO7MTrXSzVy6W4aysQMqWaSwVsd5vxiUW6XZwAVFRnYsBryCla5m
SBLuWx6tAR9ra/wEzhaLWslBnWI5r0ANPWDwLeEK8v8tWkdFzIxQ1Ivvx6YaU5FhqYIf4eFPErWW
5MBFwKi0FdgndXNUbDESxryvdfGbr1EF26JEK6U3y41KdYTbKYVNloXECAHHGPj7IfKk60N8+qx9
4Q407hp01yxrANdbsNeMg8fdmmLjITJmOICppppvF3aWWQNnvNmyag0HkNy0y08b9/baATcZI/c3
QA3XfZXCTa8Io57O8GdsZgYTtxxwAPH6FRJmjF4HEFruEJKDe8OYh2dOoNGrw4L1NJTxJ7wfSr87
0tse2A0+VQ/KZp2fWTdM4LBNmum7OdOKV7ap1gxFio1W+e3Jj0t6n60T24my7nMSQ18w+ZAoewni
iKwU3cHURZ/MRHAApQuVROKBgOQAbN1B1In4o/MeYWsfwRulSpTK9T1siiT+hivbE0qhp6/PaBYH
fAAszGTvIESpwiM5uSEuNLtQO+7IDtu2YxAsqY0Ovj5f0CgUDtbrr3/gnrGhsRYnfaWnckm9N+o5
SwSFxspHmiiaeA5bx6Z5LFo+6+jCF14blLW1oLtWaM76HHKsD+obrEEYXzi7r9js8eQXuaFEmi6+
+DnAkbmBv844M+L1u0lz6MPtdO2zfERtmsPI20UrerUlNvzzaNg5cDgvwrHBVfUXXHnl3GnkQLf1
gQB68FRtYkWk/j4HzP3GlIXfBbiihFXTIGdbvYsIcW6Cu/7R8n7WuG7p6ejGIBClCVRiMSYjTefx
8Pk0lKwkXT5pgxR0ROdhFjEnEgH/r+5VHM54pTX7u9ch92g8WpBmoheYSv2m0V+HwzshQvb3NyUb
yKWnhXcRZmNephY09V5ggP3Ul7pB6HrvzT1lp9W47I9up5XEHXFzSkMCyGB1BmKNzHNNMXDjYtpc
dB4BJ5llmYWFx7fTwf05wX/2Slj+B6BrsTH3MBJRdT3YMz+7CzYHhgu+BWFxGpSIofRvDtqvQMcW
pzuQYopwSxJdko+ZByCDwDTHYG+bJ3Voau71I6462tZC0FzN+MBgCwi8y+2rXdFwroCTeo1NpYvF
wLik9Q7SC2etoLyYr0m2rC8xVE0dcyVKHi45ZQORk7fOlJbYUKiPtmJGNx9sV9yPomoW/7MohuFJ
bYDtd+y9EJ82dMVxMbgx2WjW+nFlJOR38OggRGB9FDq4q4sWJa8AzlxhM7LDk6wQOKMJjM0nZsR5
MRHBPwLL3vdLVpIfNrSIGhPNSkx50awHzS2Y249Ww+VAGN/dOG1AFupHxRrtStfJtcIaH5Adm5Af
TABiLBNxIO7zjvY2PWxZjhj2qDDNF1ELsRzT1HSn2iPma3IBECfWDzXd/Un1ALdk0fVBFvG/Fgg/
1fQqEmboY//INBBJWkUCuyUSkKpcKlsCgSEo2ktEXpFl2qY3JNAb15sCEdsAZHb9STUgHp0VyOAd
5zPJZ/K8SJVE1NBGZXuKeOQfUH0zLFDEZUMaZcldN+UWbvbaGcjhuVpftsySNGHHY46LXi48HRT6
pNTWv4pXQsboPpmrP8Q1okRcRg7OnXrvqkVZGm3PUMnjDmpAPFtMgfIPg0jnibf9AswNXjs+UhAH
J+InB38GfrSpwX+714pjGDS72J6b/0NHzQ7+Ye2i8R2+PvFWKqETolGDx5Od+WmroAkHWrtn+Chn
7U4BUhYckQlvrLMSdivsuH3ei2rudKkDaxmS8/+VjKQaoOW+KGM8i7TKkaVK/S2GvFXPe0Lw14l/
z2jxtw/EJstovIxtXCIUC0uWZ8uNHp/diVVikV4K1Zz2VsvqpNMjI4yhLm1O0/HTHY33NpE7BPl5
iVFQwby+/LvbBvxdORoJRP102xmxoEmVZySOCPc5qXDaUEvunFPL4SjWVXro4z806WpTw96Wl5sC
m1If2bNRMyLNIbavfgJKEamK4Z9Klqz2W5+LtTWmIARMtauBsfpxgoo6fDjApW8aIGS/B/aE7MV5
BOzCpl+xzK/yDuHxPWayqGd6H0rRaQM3A70Ib01IcZ0WwpIAnax72w9oQnf+MPY76OP5yJiMPoYF
bEzrMv6vDWvlGd/2nI2iOiuPiLVLNp8xQqsVUeA6X1W9hvN9Me4+hYXLV6rwwraat5saOgQHPnGY
Tw6osF20daRemvIHi1ITNs7T9nhNB0sly9fNcCDRLkp2oHug5W6xp09Dj6c3pvuLvQjVRlYW3Hhs
FwbcYef6NQHjHsbI7/GLFhtGUzLg4bPhb0s1++023AKpOvZgpOhFfyfmwsrz6/rWTJTOh6Vtz/h3
5EF5fEylocviEW/O8RjRRY3C9x9s7Fx4MbLrrVxddnFe1isRpuZVuFyJRgJBEic0IgADwflBh1iB
ml7ERDGqb3z/4K6koxJGmBBJBBdI2Qdxw8QBfmzKi3EaWbcrfwcGaCADVkWI13eOFlpfJNTn4EcI
BWuEsfgmQ0gDZlrfPhVSQoNrbypHJw1GiIJQQe6Gftn/A2CW9RVmsx2UTcV94g+Usi2+CaBR/HCc
Z4dRuE1iBbUWMxif5v5KaXzPPzjb+Ju3DWbO+hJeoP6ZRIXCbEZbW/3F3gXRzkOgtsoASSK+uqfF
Mk0h9t00g9QuLrhizHWjwH7el5x9/ZjWA4UQaR3DP0cupIkZ545ZlMHd8gpl1mztDzNFBj9dwOKc
+3sLAN/NmSKySWDiHxX+YH7nFb2fc7m4Qwynyg06IeGD7wkKEBKSPwNhZ2eQ1FozfgfEX1GGa9UE
wAat3uATRYyDohZPovaQNrXCx/OzFqSrZAYkYuaNnq+NGN3/R+5dKjVhrV1HtW7d6EEEGfw4YOAD
reKWHjBS5giJeSVfpU7G7xoHuoKhXsrUHmNaLmACWT0v1WUI63ZA8EigHaSzal9x53mQU0i9/enD
ai8exIWUzdphIduAmwQEX8m6NleiravIZPm5ommyGpBcMNPYGkpbdLCuLlF0JJxHS3hWMuBljNCh
yhbmVPL35xoiUENSaS/F5+BsUlqdB6Nxe+cT1wr3jQoK8OemNHKXl3UdqxzN2l/ozttgdLdDiW9Y
Cn0BoWCTlE/hkYz79gNDqS2Ces7N9VXXA5S2dqlGZFzMkl8IWU8E8/cMgcTrFbZmR6Gnli/hVCTB
NEuYuzxuXrw2xq8lBCy4JlCCqr9bgV5bqjDwUfDj5DUfvB0NaZNyJXWILuCE8y7LvlsW8qeQxW2y
KthWdvVX7mphGKf/oxeENvN1BgqIKowyZ/5bXAH7PlUGbQ5f+n2S1KStIPS8CqVK1ZRHNv0eWdn7
tYwtgeSMo6aeThtI6MgRJmgb11Xy29qQZMfDJpMF5DCJ0kyXw6PyCnx10XofLs8eQ5yDdTor+m46
l67BWJtlzfevu41wFAiwRxs3cx4BC2h3bbhUfXs42wP85j0R0OiIzqDHyfAvOhVL3ZUrmNyG3K/v
ahm92M4G9JY0kOqbllsJsWE0qln/JZ3MuJoURpNWrssIAGOl4r37a+D13jQz6aSmmbOIbH6isYM5
+JF5rgn5K6YX0+p48BVzhh4o7X8hL8L1VjFp62TMr7PscK1n9iiqt/r2Ydu2Nzj2XtgLmpL7tcH6
CB83YXJU+MLQiop7lhppoJ0vGzHgUy1odj6N/pHTOClrmOjE6dks6xWceU/oZ0Gb2JiBga6qxOwJ
m7/9Cq5E4gp8/vT0CI1TfQUeZaCrh4qRCCMS9dGlwbmu3MIGV/ss/oNxvzBV28IecpIDbYyGsmBw
Dzph6+zCObxOIMx2QeoeCwMsczszJaQPBG/kZp4DsoxVkfZ7tO6Bj/dbeIznul5VTTUHbYJIqkg5
Srru4zoLPK9LKpGgsFzxbZ4HYWNeH+Yl8+1WahLGwivyQz+BdHx3fGQSjuPGeRV/3WLCfJlMZYlx
VtrqVRHAomoa1R9ttfi2pWgS5GRIf2TqBtFN6jG1fFWt9JJRaHX4aWO+/7avNYUVflvzvTafgEb8
6uwCdfxeCoBRe1o04nbeMsLfzfNLIrTsrnMfznMPiE8RAZM4pgvURXtSC/C38gdAOs2y2hsPzF45
siNxVGTDVVh0n29ml2RZeEaYw84DPteuhG6EfSAzrciLNKY7D65/UVRFue0gbegRiqResJBl/2qY
HJwOfatokH9bNaNI+rpTW6uHn/yz1NcQKUyFuAwL378BtSHZmqL7zliPbZeVooVIX8FcISDFcFwl
h6iXOGnBVjPzUnVU0HvjoyuAxnUdK9A0Dkgl+tXJmkekDD2TTq23TARJ1B0f1b0wTNnRL+K87CNQ
Z6ieL5SsarsDvi+slnPowrHoGVC57OV/oZB0H/OoB68wCUB4sL6vdmfHObtpkl5FtWkUBRt27VuF
9Hrw/lVkfabEwuWv3WWrSF3BZZQ1kVSYby6FLc9OyhlJg6KHtHZvr7CAv0nZCkQh7iHKodZ/iSw8
+X2ccuX9+N6YF7ZpxOuMoSF0S/gmv5PHxCtjgSJ7RKMP0VX+pcyOtYtj8HNW6aHeELlpnFr9O8Gv
+HxhIaE2Y4LApjmBZCP+4aKxVFyD/oktDHAYVYaCPmOKnNTixL/YK3wueYo6f5752SLV+xiKkjxg
j0cOEOUX4ys8yacmEIyaxw7cnH1cLN+gicr3w2uOMZbyVkeLH9s2MIsY36P7ZJb0IRk+gnFREwZH
jApn6uUIm848LzYS4PELteceArcxbazKrkbWq4Ca
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2014"
`pragma protect key_keyowner = "Cadence Design Systems.", key_keyname= "cds_rsa_key", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 64)
`pragma protect key_block
Dusvt8lOCTBYLD6aZ9rZ9OrcV7BbXCTn7s1oB9SC8go2or+dLZ/qs87n5S33gIbMR/jN458Bym2p
0u/ay5350w==


`pragma protect key_keyowner = "Mentor Graphics Corporation", key_keyname= "MGC-VERIF-SIM-RSA-1", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 128)
`pragma protect key_block
eu6EUsjU198BiNeW0bH+myzrxufoK/pElFPzPnVb015NYOe3xXmCj8xvILKKeAG0SpPFRUx2pqTW
a1IigshoB7AW7+t21welh5wQamd7pe6nl5O9MYP9l7fz2e4JAuULSOfIWCgJxYjfv7artu4Yw/58
wV27haRRErOSV24nSqo=


`pragma protect key_keyowner = "Xilinx", key_keyname= "xilinx_2014_03", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
iocYGkOtuPLdXUXHsb8N+kb1RxEOWBMLFlVmPCPeppmv0aLka6/PmDZl7EFXtvP+a8E/aY4uNuYL
Xq046/MHimV32hJT+ZqHhLIIYOeY08O8bZ6pPzB7C1TJS5XXQMg+C+N6zk/vNcK5OwYEd/t7MAIB
c0u3Eyr4DoxxqbO4IXmj7pUVk8c3xG3IN5MAnt6TK3++M4h3tOtTkPVg+CA17CVM5rgEpvFzWLQA
gLw30pODFZqsl2sXj4BaTLePCAT2uL58OErj21AkB+SYwaAXcycH62+wrbkIr9CpxB3RoVfPhENX
r2cFY4Vrxk3KT17jdDSAX3huCBHas3CA1LffCA==


`pragma protect key_keyowner = "Synopsys", key_keyname= "SNPS-VCS-RSA-1", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 128)
`pragma protect key_block
mmVFqNf2dfmoyTKbUcoZXU5oY1j2ySXt9GB9Xlv+ipAqxK0AOS+0wwWJu7WiNVu+pGLKAlG+L7eI
AGEpsYLYl/6C7pZWJmkJb2VxK3YW+K7nI2JeJZgnX4FB7jdASgF0eEZ+LDxREr9RZMn66/RcJDRN
2lZr2SvdWQCNy+rDfLs=


`pragma protect key_keyowner = "Aldec", key_keyname= "ALDEC08_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
QceRhNZ8HVfE0sOpbqfzHUWEgG0HoSccb8Rm8+9T1TF7oG5vyFPO5qWzbRUV7JbaOaU29RHM+7qB
qecw7Tx4/K+UIs+NBlLz6f4gE13Jrmbj0aXFAIRsMQ91qxQqW5+Db+08FPat7FgUNfjFaa8R9F2k
hmilClfRL584b5FHK2Vbba9RJ+gryOrAKqVoWDJTnmtESp2mWwFl9VDmMUx35Aiq/Fsybs8Nb8yI
PGWhsfoTldjrtGdwoor7W/duzNCSAxUbN9asCFWd+xXsFRAT4Tf1w0cAJL7cJERfGjytHYvy5Oq3
kEWTDDLxaFKwhmcPNXqWCDSrYO8bSTN/eJ3KBA==


`pragma protect key_keyowner = "Mentor Graphics Corporation", key_keyname= "MGC-PREC-RSA", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
RbzdUBrltm3yJ0+6fG1Absw5ZSX6n7Bk6OzhkIPOvefL4hEwMljBk4xpDjIHuuS4sFsIArSD18af
DocSB4/5Z1wwTgJAMdrNIsf4Xpmd3s5ZrtVK4UKAiNAEauEsaiv94kXqinwVDp+Tj+g3e2YOJQH+
D/+oUk7bkvHNq021bJXbC5/GNyuectvvLu4ncBbWlf/FY80uAzaCRcMF0Culx969r1Z8gpPW1/6G
fANaMgZ+jsGzfhXzPr7nU0Ur8nh9IPHcOPUuo49erosMMmgZT1RjxV08/EAxIATjWnta7yYcqlf9
0ubm1l/c+ydRtg190ea3/DVKT6Btt89fs8Y00Q==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
oBFaSOcsnHOx7hhiip02akq55YhMm7Fldury2/N47ZxOHekat+6huuyMsETR/Re8Pbct9ZrqNTUQ
37/R3eENKwfAp4xwk3fGdY4iM4Bpc0ulZ8iZsSp1Unc4zLmxOHINPwAltC/mfIeGMA3HwNEiIktt
CgDsEIZO2BVicOGeHt04kvxQxa8Qlr9rkkcqLFgv9xaA/ZQOEf9FrvqQ9rcpc3xTF8nUYmNnVRhK
ftzs20MMubfgSfaF46ht+9AcuGUsrqJaNwaleWzIws96XIKnUpxO9Fk/ONvNqh9h8cfBmwJyLNzd
agHr8/IfCuUbn+ys9WQqt7DMkZjO6+HE3NNTZA==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 5920)
`pragma protect data_block
QQIYGyK5sMkmGmB9zcaSbF1ivjspwLgq0I4+EIvcucmB7jA8LJUzpFMf2obvhjZGEdwZLnP+kZQv
HDcLCDEQjWNqhGgopyfR6wnYcrldY/Ur1sqFDlQ8auhJY8AyxfTlo1g6GoJ54qq5VM3KRTWjon1U
3uVNDbiYtceCikMbJsIGJPygfs0gVNL10dtE1vj/aDk3GeYHB7AKJWi3WK4BftVeACuAHXN8eSsG
yAMYqMqhtlDwlvoC1L8Kvgcp0CkJCAQXJQWoqJQgP0Sh13M2j9KhMODnuSgkg6+xQnZDGICmGMLK
YRu4wjAs5Jy0q9Rhg66Aso4vNetvV6+KNyE7ROqj8zUBWtL5O/LeHgl3lR2/X8pjEvMl59mr8DWY
osexZl19SPjfLL+cEiFYmk+eGlt9pQBQI3egUyqJQpy8dqAUVOWXHzgMs3qrIwPAdqt5jlg+YErI
3ap7ELnTbw8l9aTAR1CuZ5VnPa3ypb92g7cykcsAd/lXcogoSUReoqg+JCfHD9CChTz3MhyslKwJ
MHvyDxhcJYNKt1WtM045vKLlMFNX651ZqsqY8idMu2B6a8pPw/9Ny18DZ1qV/cDMJqbSlb2yqVT8
SpWLPvjuB5c1KORdyiH4xgdY2Jm+vgHkYwUZQ//ujsPVJ8bNCVfVp/iW3UgYQuCQ/nQ/0QS93Vyg
O7/zb2guP/91lkbMpuBQ8835I3TLuZshBlbgRHAqL5n4YRKj+aNWAvd9KPtm5/StlwnKVrbBgchw
8w+b99IBBBWiDZI4QZFbc5WZVLgGKPbJrMp0fyxnF2GwJgrVtdjy3ZjYeHNpr+Oc4IZBbuSGBKyZ
E6fpL7qzfO5sMpa5EsJmFpA8bA74pW6sE8y1p2JogSvp2sHuQYVtPJ/DJzim6cykRE81hqkINa/D
ExIYZpwKmMFNQfj2yOBCP0ZR+1/oBJj8gNQvDVT5e5zRoaW9X0jXFPHjlSxTNYcldets9GVH4yoU
6SJz5TNXeo8rTcuGtBL+HHaavncIRBYcAxEuEvESvh5ZQZqOanMZYqVuNiC25q6Y8uCBTMEWUFew
Q/+b+ofQDg0KTzpXyu3VsiZdafB9Wg4IHGO9qs6UVAklp1FO0nd54NPNUf6mqNYP0tyK5MK/cxgg
tOgwqIzSyV2kwOgj4us2SYaqzAyMNJxCrNutvuSWpJJM7FBowhODW6Lo5w4XVR+xEntU7EpEwIKB
oqwmTPb3M0/NQLaR6tIo1QWGZGd16S9SbpZzHzqnL+3W387CrGvzYwyLkGSOj3cqohzqSxG2OQeU
Ech3GFKLaFh1xNyMrsDNCGXzBo+kTFkmLfNr8D3feK8zqMIPrjXLX5lyIzH42bstDsM/JXj2f8WY
BF76aJplAYWY+j/F++FZbtjXNYsM7F5/hC+n3N+V66cMs0FtyU9RsZ/d98cmQMK/RN5+AM1USXKY
kwOfYO8CbSNaWTTS2DetmCmJCwnbzSFl3nfLIgd+HszVvptaYG/QBz7mHv97l4agUyRYT0qMYvno
guY6XrmigvlMbqWXumZgUSG3GVX/OXMeN7yrwDrpkoucG9p42DVSafDxPzoCFX3OgliYkmDLYYMt
r45hvjviwkOD2rX7nn0Xvxdx6oci0L+AzRt2qz8GoOxjQKvnP8GXyRjZgrrJSLs5fu5QL4FUaJYR
ymoDrbiXHyIJ2rLQG0XCpz/FBMO6OPeZiIqw/63O1o0XaJyVT9/iAJd2B5V25xdC4Gy5I4I/KKL/
8BwNYeySbLZVywR/pWtEQliODv5lSSHbQNtz9EXFQxOemzs81lp6uHJIWWaJYNO8+Z3ah60j9A/J
PY48UiEsjSaznUFy8jfEngfrkItXj66w9e3d+cAyaIB3HC7nSWauiFGLyFWnEzrduKUfWSdw5yxF
6vRaMCDhTOt8eQ5AdnCcBSZNkT8MtjeTj+IlBCVFmPwMobWxZOglCp6a1+N9+rpxrJ3TtbJEyhoK
r4+mi/MAjv5tojlazC/KXha5ixyVCf7gtaBJHX/GH3PibQbOAk7UAXMZFfimvywytNbYSVZo95ny
srfdwEiQH1LcYqnKWMkr/CaxJlkFCxURRLQ+S7L8VT58IYrBjFwKDOQby6dWRKN8E9Cm6RKTx8E/
cP3wZdjUB9+IBArXl0elgU57qhBbJQKR2tcI0lxEbQAngfBKsPN3xqjsJ557yFq9pTtovMiiGFUN
YZrRa/BYaHHYXv7xXurSWHOjcxbCOahs+XXgavp3BP0C4Rv0LRt0nw/zGDtazoZusjAxmyTdoq65
Mbqzu8bnrJeyaPgYleT5NtdnCbJZHTlPTreg87Qz1lQj/plBiNecCr4JKO+xrnyarAhorMrXoD4m
t/XloSVNLth3oPht7pS+qxMVR3Cu7xEjk7znsQCrbQ89vMuzA8xJ35QPXl291QjnA6SKuyjSDDDU
XL6SSpCl8GUYoBT1LUZc2fiqzCgpJD1COrE2PTL7ZVsAxf54pmmWXbhi5PUyBJZ6vrAhhSaxk7QA
lXwjO5+cgzbxvLZjF/IizdmM4EnfguF4AJQVtz4WfZsWvqF1/zYklsUvC7JZCP+Zac0wRvbsAuVL
S8QxElRwHRqtDJwgIu50uU96rtVsSEpAgj2NPIDhw0eP1MW/svYRxThePteUu3tnQUNTZPLA2LnC
RRMMMcVaP1Y3oDoB8Ysl5C+OqQnTmeGozCdbRjwl87ENZMT+6JGFE+CTNlCwLyxJzfwnM9WVJVIj
IXFPJkAv1SUAAqiMyb3s82iHuWy65467+/T7AwjRn6BGOoH1kdAOwUYSKipuHged2lGRs5/1pE3R
OpvpjeNdnVKOupance2lvpo0Fj+1GsKYVgbKlQG2ifr5mapoIqEGL9vsO579nAcWCe2yHrHKxXtb
8fi1DaEWTNAPVIp37gF+UvBF1HxALcjvqv8fgdXe4nDCt554+eMG5ofvfgUfUi3d+2k09nK5F7hr
N/44lmpxuhCloVh/kdiHb6uoi66J8omvnZYr8twSQRGpGP+EpCbSCehFqWBvpGMXQYyukm2N23Dw
MvVeqGtpQ+wO38gl/Xem5T2TR9ckdO8AC+Wf2deshlhjTIwDSlmCIWxx062/y+M+AtO4x2MS75K3
PnInrdqYNX0MWMc14Pt10fM620YQlSTQaKDQ5he+O5H8zl4sIPVdLSmnweWmmC3WRTm96CS1EjEC
KfvvePux8aYm41rF5o8gEpaT9tiCeqC6Evq+gBm8doQa4JwF/4ojxTuLkCNJTDbhv/VsE2dRE9Nl
t8TD00+Wv5QyfTkkhiYZokPYQHNUEzQbVgmsruyz5ue9yw3MG02bkdKoGxQ0Ev4tbo+zp6HMb+MX
4++CniB86zaNURMNFkev9nIzomgI2683+mzmBEBUK6JdmElesquGgALKKteOJ7utMx59bv1i+fWm
cIclZmSjN5MYUkOW9o1ejRNVtvWCybFtHhiBq/OCj/OnYyftx5Rni5GNrC9re0EhI1jWbJEyCqmo
DXqegxJaVOcZ8IaKeo+8sBFziMoKuSVTFyikORdp9IvFIrV0bclEWbCi/htyfOsZ7ihcXhQtAsKg
xd53wWcOw6TLf8oulBi52V1yO/ol8sqcymdXBgNBKMXb/r3hgb2TfHpNOvHJyLF4+qltvB7Jip2d
/glsQpZNu3NGmCpGLKFDGlw3HeXpaDzWtDMqxeaOAvoLgyUw5ThGGsZ4pMSEOXQD+TVb5GqLTg+h
+/tWKEjfrCiqew4nXNT7L2xcuZ7QKAjN86NXmVq80uSPU/uNsLKLhhOFD2lCTbw9OZ4WBv3szKbh
/wknuZMv8wKJ31LsaaNOz+8oPwl7ss0R7CpLrLC2mkK7QrDXtgP7fZHT0MQL+n1ig+DHtGV8A8Sl
66uVWz79xYUVSoPIo+R0+gvvFaNBdfdhMQBgcpoCOmiTnEFwfLNCk2TuWFSoh6TcDTmbYpmKw5UD
3brULaezA0XEzt6a9DHkM0fNVGD/DLsB50RKQvYJfB3Yq0bm0WSxvtxqBV6tKuHSSM7RqvZzr0UY
T9CW/FAcK9B5A1TaUnvoOVEAPJSEH8MXgVEort5aZ6+pIiuPZDVMd4iYzuW2rfDqx+nr5Ayl30sx
J/b4LD1yWZrrfJLR5gf/pZhcSJT1FBCF4xSJMht8ABpvPWwM1TRm+PEkowYpaLt3vP8UcPMUaH2O
Ibx9WlS7JAXydBDKiC+0GVwQhCkkiYd59wakC6wONI1b9ovbb1t/+UEGo57teo+I4z+8pgpEdxRH
YXEnZlNIMVv/2pKtV98MTS+7xdUC5zXTRC68W8APAdQ8zOFmPt3cGCyuebtUJ/9jDGMpnl31i/SH
xnCivdoz5CDx58OtdjOwIpQ5Sphon3TBcqI4Lt1dunTqoLP0SgNsnzvXhopP813I68UAvAzYSWvG
oK9Rd7kkMNmTRox3O/G+iyEBQfrptwdJqY4JdLfinfmalgq67mTTth4kUHohk9XGhgWD/sgUsVxS
rkZiXfJVv7GkXo6xJg1qTiMXArYt2t6xSq33bTi1vk4MprcrMtpV2zqEZiMrf3BSoQHADrNG8x0F
RgAdx7n04Gd51pf6uMhAeOGAvAu5Hs1psuEuW7EDIyfhlpB4FE1TImWiZ/9BfNBhxlJSz3XMAqBu
8aWwQ7uzToC65rYoTMrk/NL06EItdxmT/qF4xYXNheEgo4qfpphszUMY3mioP8TfWCdYe7Bfrq2+
wHXmXmmM31/lyIm5d16bM5gOYzBcHR6HCI/JbWzOuzsMK9XS9QvzcCc1bEf/JkUpYRlV/PDBNj2J
RKu8S8bd4k3lP5rhUUOYIjuqkTcIP3ApC4OA7Q9iGVQ/hlBs3u/EVDKv0xL/aTB7WqSUhat5z4Bx
aXoFSZbzrHM498iJI+0Uzjvwui8/EzSjwwNsYhiQDSMZOuVp93ZgR6c0o0Vp503fWQcsY6vkHDcJ
4XcMeaJ8ZTGiS6yikk74v4KJGbKTsnQ96U21qX6/SN9NoMl9PQkaOoHi2BCVTt9+dU+Z/vCL01mK
lBp9cJTf4ILUwgZg9mlNVMJ6Myg/XlBYJtJ/rIOsQ/lPD6bJVAG/uzw1yYLwAx/kN3SPNLUlIm09
upqqY+JpAyN6fvNuw2/d0Ca3LdAooGjt1QJgGPbAKoWQnKqkO1v7gLVSVPJhrGSSrQFeQ943YwKZ
n8IFwWa51hQ+ZsaSB1BWnYNtmtI4Lmf9JyEueH8U7Dd15G1BnmTi+xkFL3ruaCgCiCn3DdX3lZho
iZINT+Y/uAEqbrXgZGKxSlZvvQj/Kd3ItuOHWDGiuN7+Usp6vpISzZsP+AvQHSNQGOkMWXLqZfKA
zd+2E8so38RATDIgAC41VySLEIOkRywJ3rdUQIl4/7KbBcGx2ywhWa6ZdbGak61ld9H+P1TPE0Hs
JfY/SKAh/zNPRTArLaH5TgbahAGus9mvuA5+UH3CNLKgES1+TzI2Ih4yjtLGtZsrPCDoCRbRDpYV
59g8SNlY8tyLTTW7jLP0H6zEkAzDGn6E0a7A1so02p0/dkOh1rNs3GhWj3/7GJ+LZs+Ixm9VFWQB
/Y9h4qEJJ7JFTHCWRWXAZIL8tRKyeSEmrBFLlSqWRKVDkTY6oLm/KBm+aQmESfW4X+u3f/0oMZj0
VIMgJJXI0L6l/1VhIph+1tjpsVxiRVpSsKWLxJ4cW+06R0daHmAacTdtxNOagKJP5lpVglEKcMBC
MrWzr4U47Lqas0hJMbgRpCGkX0LkkKAHC/r1YVJrElZvSqk94thwyNqyn0+h3yCODw8UxVvQmll1
Bsq6BmJRmA17ngiBmu2m/zEwXmG3KCKr/NnVXfxvphjsASbr/PDcg2v4487wfpTO6QSmr60oKWaL
qmb4vfgeMe6TVIJiCp6kTPpeAoJEyLqK95/tdHTraBrSJW8F68pGkBASkiczWUUCEFn3QyN6en/R
zS7EjYIMHTVHo+XgUj+y4nY5k7/NT4cHVI/nuYc4F9pRLv6tft13Rxqi+0a3MJDM+D7DXU2rxeZN
BA3y4E2bva63jEkNX01PG3QknDb23KvKuk/OfGEUDM4OwVrmj4G0XqINatn+lqrf4K32aWSxGaee
1O4zRNR/zdLu2ykzPIfAUEJUPI3XNF6xxL0iJhW2FCVjmESgqLWPkLZXebhx1DliZdih3J1Jsk6c
Ph/Dm9IEqARFejajEe/MOZdwOO9ziDyylVsHm9B4CQ+jtsapBth9QJG65lwUw5KRnfHuUNphAvE/
KPxR/AAbvSDlzrVog5snaymMk5pBDED4JHcyLF0RC5jeTf5q43qUM8lv+gXbDNoAFwDQYpns5fq/
VNfn9twffg9TV+ot/5s0Ur2Z9hwNubA2v3WCL5PxgX5eh07SlhX1xnjodmllCeW5HJIGGeXOB5hB
FgTBfR1Qdneqkb2bFSJfpR0xgbG6PzVD/AjsPDPXLs1rMvJBimF5hoNTcBmK/tHb/cuPGHYxPrHa
V8yqLJaoSHphsnaZLFAoE5tTUkx9dORMFXySL3E3Ily625cCpAF7/oX+vRRXlm350sDmDJgAMS/k
MvlIvkLQdLqXzemr/hcqDe2N6Cg+3T0/g/fCqbgg0Z+k6750ZS827Z9ODQvmrGEhc7ILmUMmXwIV
IjaUbbwT35Y5Bism5SLoCcs796CvUglL/K6vuF7ogt7JqdfNe8QQRAgbDpnN1P+BiokQAwWjbWiN
59Qq225fmiMPMY0eysTVqGYiFg/uaX6kJc/xmPHNflPyadkR+WHQjI5yDMEcTB+lM6qE82K1LD7S
Zg7sz6kLyppIzoC9abPlIkwCPDuj7isyH2XUI6ln8WTsJgotDEr3jmKgPGx851Bttc+tTsm2N8Ko
Cv+6SgWE47YN/e6ns9ivbh7x6jDE70yItiAVyunkPWwsPEt+btKLBJE1m2MV5tO5kEMkQLAqtOTg
GPbk+HblLkZRa01TeTW0wrYOVXN9Z9b1OG+wC/SOHqJBuqb70viOBw5x2gr5drv3gVPj3b3YPImu
gNCfFAvKMdPtPpJaj6Ecn/cVW8GdnRF2VXFCE0mP+sn6VkC3T3doSKK9qngS6yFGBqc7bdkuGBkl
gMhlVTutxSjviwU5kAjqZOrtkMP8bps/jIDOk1787A2AxUuhSJWCr16SPmh3z02KtgP8BoC/pwJB
omy0yP5VcoKSl9q/kNLXeyEk8d2yZlJyrLtKVxFApLVFNHrUBY2q8QCGrsnizYPa6Kb9wGYbIkdT
wZq2wiPbcfV9bf44Cyiv0gKimK6fgauIm7Jd6N4oAbeQSv49Vgmlv98CviwqIl5KS8sVC98eDpHH
2RFtWZjqHlG4yHOtESRLBJ8+0oGB3MDBHJ/YWX9f9tIpLl6Rjc2vVN4gu2Ak5UYT1cXYK2SHS1Ad
lllLnbbFeFPVDBGxssRys9CXEaZWSFGEkeGWrZMIOS64oo69AF3sA38e/SrC4t4O7PTezBtJdDGo
tszgG1sA/LB7B7Hmv53j8nljeW6DW5+rw2FxlYfUZW4JfXP9zqIsG0K1fKxlwyHG7LZ4IGGKQe2v
5Lj2egapG5XVEJon9oAsSzyRvgui/RzzOIO/x5DFZoaDP2SqCNIKUbuiQYSBl/YGD3G+EJwel24s
keqyGUXqPBeg0Tss2AvuKetRfv78UgMwvskcGxR0a/CjHc0uFvbPDSI1oB/hTxqbwKTY6bmbgazJ
mq+SYlhBwQ11e+yCzAXn1lEAvmk5J21FHpjkaG2XlU5oJ/JDMGUnb90Eb52XuCkl7coMbB8t/jlF
SI5zcLFS/o7GkhjMoMX7VnDMG3R6IpSCKyqIJu0mxSZRtsnMRkmi4kkxE38AVaFFk29TN+yNOeg8
b1/W/qNDkdGLKEvATgy4IZcslGd+ZA30B5zhpc7bt+F0u3qm8RXNN6m17WU9WBazeQ==
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2014"
`pragma protect key_keyowner = "Cadence Design Systems.", key_keyname= "cds_rsa_key", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 64)
`pragma protect key_block
Dusvt8lOCTBYLD6aZ9rZ9OrcV7BbXCTn7s1oB9SC8go2or+dLZ/qs87n5S33gIbMR/jN458Bym2p
0u/ay5350w==


`pragma protect key_keyowner = "Mentor Graphics Corporation", key_keyname= "MGC-VERIF-SIM-RSA-1", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 128)
`pragma protect key_block
eu6EUsjU198BiNeW0bH+myzrxufoK/pElFPzPnVb015NYOe3xXmCj8xvILKKeAG0SpPFRUx2pqTW
a1IigshoB7AW7+t21welh5wQamd7pe6nl5O9MYP9l7fz2e4JAuULSOfIWCgJxYjfv7artu4Yw/58
wV27haRRErOSV24nSqo=


`pragma protect key_keyowner = "Xilinx", key_keyname= "xilinx_2014_03", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
iocYGkOtuPLdXUXHsb8N+kb1RxEOWBMLFlVmPCPeppmv0aLka6/PmDZl7EFXtvP+a8E/aY4uNuYL
Xq046/MHimV32hJT+ZqHhLIIYOeY08O8bZ6pPzB7C1TJS5XXQMg+C+N6zk/vNcK5OwYEd/t7MAIB
c0u3Eyr4DoxxqbO4IXmj7pUVk8c3xG3IN5MAnt6TK3++M4h3tOtTkPVg+CA17CVM5rgEpvFzWLQA
gLw30pODFZqsl2sXj4BaTLePCAT2uL58OErj21AkB+SYwaAXcycH62+wrbkIr9CpxB3RoVfPhENX
r2cFY4Vrxk3KT17jdDSAX3huCBHas3CA1LffCA==


`pragma protect key_keyowner = "Synopsys", key_keyname= "SNPS-VCS-RSA-1", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 128)
`pragma protect key_block
mmVFqNf2dfmoyTKbUcoZXU5oY1j2ySXt9GB9Xlv+ipAqxK0AOS+0wwWJu7WiNVu+pGLKAlG+L7eI
AGEpsYLYl/6C7pZWJmkJb2VxK3YW+K7nI2JeJZgnX4FB7jdASgF0eEZ+LDxREr9RZMn66/RcJDRN
2lZr2SvdWQCNy+rDfLs=


`pragma protect key_keyowner = "Aldec", key_keyname= "ALDEC08_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
QceRhNZ8HVfE0sOpbqfzHUWEgG0HoSccb8Rm8+9T1TF7oG5vyFPO5qWzbRUV7JbaOaU29RHM+7qB
qecw7Tx4/K+UIs+NBlLz6f4gE13Jrmbj0aXFAIRsMQ91qxQqW5+Db+08FPat7FgUNfjFaa8R9F2k
hmilClfRL584b5FHK2Vbba9RJ+gryOrAKqVoWDJTnmtESp2mWwFl9VDmMUx35Aiq/Fsybs8Nb8yI
PGWhsfoTldjrtGdwoor7W/duzNCSAxUbN9asCFWd+xXsFRAT4Tf1w0cAJL7cJERfGjytHYvy5Oq3
kEWTDDLxaFKwhmcPNXqWCDSrYO8bSTN/eJ3KBA==


`pragma protect key_keyowner = "Mentor Graphics Corporation", key_keyname= "MGC-PREC-RSA", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
RbzdUBrltm3yJ0+6fG1Absw5ZSX6n7Bk6OzhkIPOvefL4hEwMljBk4xpDjIHuuS4sFsIArSD18af
DocSB4/5Z1wwTgJAMdrNIsf4Xpmd3s5ZrtVK4UKAiNAEauEsaiv94kXqinwVDp+Tj+g3e2YOJQH+
D/+oUk7bkvHNq021bJXbC5/GNyuectvvLu4ncBbWlf/FY80uAzaCRcMF0Culx969r1Z8gpPW1/6G
fANaMgZ+jsGzfhXzPr7nU0Ur8nh9IPHcOPUuo49erosMMmgZT1RjxV08/EAxIATjWnta7yYcqlf9
0ubm1l/c+ydRtg190ea3/DVKT6Btt89fs8Y00Q==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
oBFaSOcsnHOx7hhiip02akq55YhMm7Fldury2/N47ZxOHekat+6huuyMsETR/Re8Pbct9ZrqNTUQ
37/R3eENKwfAp4xwk3fGdY4iM4Bpc0ulZ8iZsSp1Unc4zLmxOHINPwAltC/mfIeGMA3HwNEiIktt
CgDsEIZO2BVicOGeHt04kvxQxa8Qlr9rkkcqLFgv9xaA/ZQOEf9FrvqQ9rcpc3xTF8nUYmNnVRhK
ftzs20MMubfgSfaF46ht+9AcuGUsrqJaNwaleWzIws96XIKnUpxO9Fk/ONvNqh9h8cfBmwJyLNzd
agHr8/IfCuUbn+ys9WQqt7DMkZjO6+HE3NNTZA==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 19600)
`pragma protect data_block
QQIYGyK5sMkmGmB9zcaSbF1ivjspwLgq0I4+EIvcucl6defu4HfMhKB9VAbJyKebCbfRqKVNwKgU
J42+CRjhOlod7/E4q0kf95qdFgQsMDE/AYZFbeSzWzGXCZzGwayfGZuviYq+V8Xl6xp/X4ykTozO
j+i6yB7kWaW4Zhu5ledm7AXmfbzK2/n42KHIO4RBem6jX0BkWfRLhgr41zTxie3cbO9gP0dP6uzV
JBesvTb6H+nIlqQqqSePBvHQ/47cEv0wMhyLfRsHVLKD5ZbxZo9WZjjyAoQFkjkhOSmfb41lkbl9
PQYwkskfibk69XJ6d2PUh4bUXB044SeUDTkxQGWvh1u9yZWhQfJahUsIL7iYnLoMKFZXI6nyZlzg
fe3+knO5D1RJ+AAKKleJO1cfnvfAIdKisex1nOS/lz98cjtKtay6LkZ6YQIjdzpBYerflj0809f1
l+5crjYR9S0yqlFZwvVcGgiQzcLj7m5ajNbTYBRc4eFcXvyGXcGu2MY9V96UIqyZG2OveoyRkvdf
PunvTnmfPz4EmqfnSsry7i2cRWSUzOb64wQKIYpUy/zjYlJBRXnafehGMV02d8DsI3SZX8nT+OCE
1gNdi4RqiTIOYjp2YcU5jqO6aO/mntXh2j/bW/NIu0CyBgILGpooh35/N4B5499QNBt87urNCA53
yN94QhONV96fwICfnNQK9uwmCHnLAw82hEjIE9POObhhxZEt8XV3G/CHf6LC2uoxzofstyxIiV42
wbNLIgkFHIqGTC20clCX3d1IocwkKH9QwB5VzATGtdklRn6eJ3gGkPBU5WMkERZNRtmmzUDdWpbB
WUtqmU8adcNITDrJRouCWJ+E89viwykVJEfVEI+nKYePVkpX7srP+EhVmhT7h3p8wFzphs2kv4vB
+GLRDxaCFyyk+G6ho124bcAw2opxcRX7jJN4MndA3YMJmTfORPZjsitKBtxnanmQMxx5yLB7wdv/
Um1Qd56MXNl3G5Z3KwbeANIpRhVq+RHiiebo/e4Eylj8GQXIYk1W5cWpyMLFwzTLX3JorD6u/JbD
9qlI6RsOG3lLo8T1DCkDpV5933+W7M2ckD1NRnaeDx20wVI16C+D8VK5fH+KwxvOJw1vx+cdpK1v
7/mQgYOP7DnCFdXldNft0ZNQWc39lrO+8+PAmv6CXrdZWR6aUnWm5k3oUTiKH5VvvR6oPE80fkeB
9Q/qHVK36wIArQWMmb18LHCm7cQg7yTi9HWFgmpk7O5UC26IlVMnoWlTGDzNnQAjciWSY87ODB5r
I0AGGAH0H7jAfmV9p9qNeI/Bh3PlbntwVis3/ZKhBilUQ3O2HiGuxVEmATLvq8oytYotAf2rTFVB
kr67DLvewH2D/Kcg+LOL9LGZwiMt3ps1rHE8ZsYnBYRZCyyXK2sNAc3jOla/kA6gbvl6lEJPZYEn
wQO1CRb0QNKjOE4ObqSDxqBN8uXNemSv3xNNO223OJzXQd0MAme01TFHctrmRxY4YnoWQkJ5Mjyy
3rATMCVNeiXAj2BKRB+KQQg3gNizdgrU6Pi2GfAW1eK8Nn7yvRJ1kSBlI5HuvwvInCjk+rxjnUZE
U6njyc9i1zmsBEAnovsEn1vTxh04d7yrhLLnzeztd2BdK9mUlObG1z+fClz7pKRWcOkO4Ia/sUly
ZEbD7J8MQSokBOrE3igeOZyC3itJIER9KDiIpyJtFUPpL2GmO9zuYNX+tcsuIcCcjNLR3mRn1jDf
pr6hv1ydIao7+ADZbNcBfhXrnt5h/F4/Xu3/8Wcj2bl0qsAHNfQDlvIOKpW4+NpN4AJVf6QypvnD
b+1C5FrNIf4KXdh8H+sB3G377UgzJ6Ml1hOyQq+yDB3EeQ4EkZAPu09KDarEhtnNMydBRF1UhlTn
Ji5L1+UN8ASKS9bQVto/werevDr2i5P5tOng3SpsqWL13cNV2HeFZ8V3Dn53NpuMXJG0Ni95KMwU
zsWRnil1+5cOqyIrxFSZa1NJhOoan59yhL5ZYllPwC9NClGy3MJ6zoUQXQPMO+hunmXnpPMuoiJ3
+igWej4I5N+SRKb14pItphg5aStb0jZBu+vmKK8g+1WTJno4m/YTkrx/w4Rdnef+8HuZ5OIN+LB9
BNDcd8wW+05Msc4XGpEwl2JWBgAtC5YrWzxHFKFEfbkhYCIMQV1fOHDAsg3m1yFT40aviEhuUh45
x53wELVSvf1GMijBPUfVOe4kSUWfO2MlL1CTOaI5zotq3rRSfGkVDNdEsrm7mHy2t92XaXSQwu8i
3VhamSIG1lwUbmSERW+sjVqsr4rD4bCA2/CNQwxM1rcI3zJw35Mm4i/8g5gA4KIjJZ7A08yag7Lk
6KsN5JuWbv5eBrMiXLZO3pbA3un+XSJ0uR7MZKmRdGG3lDCJrIMC2KuiVnRmIPLPH0szU/1/dlNC
roiZ1El5FTV8/GmQc9V8rrYFCGhX7rcLukU1QMvb/TkNEYPqiN38s2+UxCMwlcK/+3YdQLpae+iY
iX5H2GK4BgmQPb65lB2Ro1RoFx9UGvC4ZfwxrBlvSPsvObrHFRaP+xrAGKpP08qc34Xj8ZbDhPwz
ZLL/L37TypOjM2h959uYLGzO0YaNwSstzEZ/L2tN07bHzVx17rejsFXdQYBXFTuqlpHBj+cQucI/
AlTuXdP9LOdxIGlTro+kzgL0ZMP87o+JREqBqCkQ3YOhS5D+5osRaSXZYD3yLdo2yQYyjJva8n1g
maoJsJq6Cov5pqMNt+y0NVUy/dM1p/Wkv7zOuQ+M6BhFr0fn4+PrlKB2vJz4a8FNnAlLL0Tg/6ms
R7CpIPq3Om1/n0a80iRKTK8vi3qd3yEKyQIRY42CKiz8Vi0DS+vpD/iDTUHFn+NoQTWAVmAQ0ItR
iwsSTMoCQEfFgPY2sNTcyUzWtYqJWrKz6QgDThOyRXTh1JaNKrpwAwFU8UYfMozQGaVHTeIb/Z01
9E0Gmkle8Q0J3xkoTVJUydkVXjX6f8MVDqctC9WtDvdrWBGYjEohJSmARFlqoZ1/iF5e3bzipQVq
/Y8+0JNTrm0pHUSt85nklCXZiK30ruiw9HkFBHpSLIx7l8PIlK+WmxvuCiD0hnZnkh15x5y5XbcP
/yDTBkh6oUiteg/fmc3he9IC/Y2+aZxMy1zTqy3iFxSZAzUeFZD/cS/1X74rvjuRhT8DjH3NV1Mf
ocFhZYUUwWj3Fa5DXKY+g4je5nnjqxsIo2fposYl3/5fxKasMYU2GZrgQhI+qwVCzI8lGjLQeyia
8vT3FzArIrcYv2lPkL96F+xvYFXzPVyDxLTjtHUBPwsg6X9ZUDYdBuNFDY9sH0JeylU/xTQyAuEL
70gu+VInsjFk0yEbk2079tcNht9TY6otIWZ+YpHEgWV9Xta/6RFGEgQlilQX7CPhUSVKl3/xukjQ
NFPo3BjgsXRhR0DVuvJlFpYhZ5bdPB3ZPIabhN5zmVb/QIrg08iOZUukjp+JBsY5c/R3s7yYhDAX
rKYHjKVrMYt4nxRov9Xn0WHCitxKDFWzQJpvei3R2/j9jWr9lOCkE9BR34Py9ol8wyElJWwEN2xx
VKt2lSdfu7B2No2aokljL2QVOoOGBYZQUcRSBibOBpIhzqAWNK9K3L7qtLESrCty9/7UXQ0ZkU/A
By9oSDCXiTecnAN7Ghor5+YsG8e3EF5WQC+wXP2+VTthd088F4NLjgDJg5C12Xcg53McbGfd8SJu
MBkTYspBU9BF0TWAFTFOiU7F1/6ElzQXUWamS2LT5ZYcErVJXlocykMbYSanyxAsZf5+X2udEUuO
sT6YL2uTTEdGr7yx4Dtr1b1mSNlCbzbAH17cL18+QoJjU0CWpc4vXTX4Tbs5bXQtMGwSt22XpX/n
XwGDupRtrSi3oXMzB3p+CstFy8X27q0351TDIMN7NoAZavK5QgiJhfXq26KpIi8zD6ko3W3PzBnb
p14pYrDk8OFUGy3tClm7l11m699FwqapInhH/r9hZ7+Swz9q2kFr/2QQyc7m5iRhpxrvWyibMyv6
iwQSWrC7kYFS5SydoIr3SnWnTecq7nGY0x/4c0jb+CHTIf769kIg2c+tg0MBcAtmAbgGRruNrvcC
38L8DXpj/G2rL7ZuOdMxrCQaRD6e+TWIwpEK1ikh1WXKzxQ1MESy9tb76Jbdy6lquGBRqhWDy+Lw
Cdxg2jG+IL5I5alTYxLosVnaDKLByDxtKwqBPdjSJ3mYZH2C8fLwuTbiZdBiHY5lFlZOeuVtgVgr
iqJ9pj6TU/5+9cMWOY7dK8kJmFKt/nC4HL29g6UEwf8j/iudz6hvJ8djch1Lt4HisvFFO7ficKzz
7IEt3iLgE8QUMtdpKFzNvgf76nQiursS71gcNTXpTqg4kTf2yDIcSgqdBjnDc91qEVWy/+BKji9l
RIogbxuevGEaiI5daIqCb8Vf7Wcp+ZqJ9Hwth/tskh4hGE+P6wUey/Bdknqjvmj5XLUkoxGFGed5
8oHxNvP+RRbDzWyVE6N8tVi6U+7Wfn2iLye80nZEIQqip7MIMDK9TKkNihr0rVZF7VoiqFycZD0M
VetDmDxqjDTicR+fRPYc21iCWBMjpmjBg9AqtFwtMiViGC/DmH7f2Kug358L/O0s+qprU1GpM/8o
d4cK4qVALijHq5HmWjTHKI5aL36lPpwq4aLXsprqHYVACIDeYtHb+y3r1tJbU20Daz90+jVRzNgZ
IqFVqzt5mERRTXgqqCEdxUnjTxQ1nVr8e2SLeNxuwEsoxh6jxgvBKijDimfzqG0GV7jNykB+jipr
zfhJlv0ASWriakHb3A24zQLmCBCxP1Yy0X4QGvkdU8eS5kItgLw7NZxXgwZLbz+9Y5TuNXMspiHu
LppbP30/QKx0DV3CipowpTKYsfaNRlSKohSAQ9h7sHwdurILzkEb56Z/lO57R64HCeWjteiSx6Xn
wRkPYFEeOBh5HvkJZ6FQZaFnMKm4ifqTS8FtxCRtJh5DPJ98JElFZ8bfd1T8ZeXXuu4RlVKrMzTx
PbbWyly1kpNQgQ0ldCuNTR0IyWEKPo0eSHZfuPsd5mQ3eyePLzrY9YBQSiHvCsXSapbOX7BP1m3O
EE/4iIZOhebr8n9hfZItk+KbiVAk8ahpyQoaeAPb+GpCyhL4KUX6HVMceZ8u4tcykiVAJkj8YBSt
RHoZR3jingHGt5poOdRhk5bUW7s6v4TNYdV/7UDDogNS2sYSIhyf/x/kxA85BEYdW2LcDoB/pOOg
Et3cFlQlvaafNY62b+NJbmRJqYWBovfheiC/PydibedwDawl1E2q26a+be2jUYjb14IDq4sfYqxY
4PGaxte8pacER0aum1NTQ1k0gfY+rcclWJyKjmB9lvZV3Uak28t2AVF7ZFtm60kCUJ0aEkC2Xi9c
gH78OnzvP6VU8miGz2qtx+5Wycijo0V3aYtenwvknYHQgowtQHFtWE4/t+6Vi6PFGB7iejJLAS9E
KddaKMLrivoho0NGweB8vRYJM1dZw8Dd4LvIfsqUFlat701Sc4FtcLeP6tkzYsGGoOM/Z+M4tSBa
dQ/GItJrPVMYYs4JL6RNZ/0beUBvQiTVBON3z95TrdbvcV30WLpyRQmdqgaT/5KTFBFijTjlkEjH
J9kB1qyAsT5cUcLRYqMoOdl4uO8kh8ooCCRD73wjpOHXvkjKC0jLsaPd0K+AppBRuxm69EkeF7Bb
oVWtPabW6Ww2Hyl2Rpmk7cB027lNcNw7IGfNgsd2YCQU1tJkUgy87XyijgwpSuoATjganZETAkfI
Y5U1WcjPVlKI/tEM3IDEUcPDRzOGyCoGFLYVdmgBE7Z9UsiJIF5a6YwsQiUBi3r/0K9LvSdMTtVS
8FR1j7XruUk1ykI05XSengSb+PGY6mgYianONUPoRlP6QERSSjES034f8QKADOAonoGkf40JaLkp
8Wj+j/11ulq7UYHIdn1EmP/0VUVj3IzlDp2GQe7nJi1lmeglaFubZ0yh4/HGeRERfQg34ZJufsMt
pnIv//dPt/TXOHfxOp9tUXtoU5vfIAkfAlUDrCfxgNkjspAOwJJKgV/gXrsJd17jlKbgjJVWqk5A
Pg4S0k9+3nebvK1DwkOdarZRqC53X7Yuh6A8RGHXnpXAQ4dykQ1JQOvAdG54djhriQ4vMRteZDbl
l+qE29LbMDSzsAFWYf+wKjcXz0gyHNsBrvwKgcQpma5umhlL5rDfC7tiyKxEHPWrvgnaB2U2raeC
95+dsX2vJWWNLZQIavZ/UjxRRwFk49h8VIqugq45c/QbquB2rD3zSQqKkLCzAG0mfRZzz9VAGbwJ
AD9zZi7LwgFtf3uNlM66+H0F+AcuHR1W16uUHHhIgeL3It9DrFp1CskugrLwfwQVOcwYhwsPxjG8
uDFkTKUxCxQvh3mfGf48D0YR2gbo3s4apEma5CAKQb6ZZhPwSDg9qH3uDqp7jVmQDF1bJ/nFEMDr
j8ERK97xOyzyE7o624/8x/WAUuFI+Gg16KkASr/YxCRYB+uHyQCQz+wBhLztFDE6j/aH+CoglSwm
etmayG8QfHkcIUuhV4fV/M8VrsKLezkX8ResPzJeYIxqlzr2zT4YqTqRNpgutMTR4oFLzjDXdbDA
7tELDt5WH4sHTQmTpku0CMddc/uHoQ2lHE2wx5ijpuS4PsO5YoIJjrpdB799Q8/CV/fnMT7T+Y/7
Ow47bCWTLgaRSm+jus27ltDwaDFI7rnJ81BaIHwAbQLcMieMS+DktWLSDzyFIb/6r8cUUFsevDAI
0YILpIkYyIF4Q1RQeB25Yzr4crqd5BFbJpAv8z1D2Ae6yV+tRBYVuckg8Yx/EdjL8HIAMeg5tWj9
C3lNRANvc4dAc1hMRRwpqBqW1CCLVvihiTDU9Exmpv2DSK+2XYs7EpZBEifEXQrt58/+2SMTLnMI
/7k12KUFOTeJMjlI1d5sYnZFz06dgzsx4LOueolS44CKkiUvoGtrpzMNZ1bDbROD0nHxmj2m2XJl
5dSk1tgnBcqMGTlHPLumnB90ZWELzLh91SYbDZFR6+pwVHYU1N1ng1ua1nB7P0f31yF1kkrNyROc
snLc7nSKIQp3uDP6LRYPPykJcBt3YmSkKQx3ef5D3Kb2AN1CjYaArOfzOG3TuBh/8s4U4VGRD+2/
tjwywdN4LkTfIBZCgTtuxNGCfECYVc66lTtuWZrX0k1w/zOQxitH9ZumBHU9cFGxIofh6YGYHoZz
/elwO5N0Vo1MtU168qq3ZBQPMDLsvoIjdxpWav7SRcSKjwo2eHfBFpLvI5bmiX1ZLOchJepxuyBW
44tA2JQJSdH3MenXg+7M4/3yo0r/Tptm/G/VFgjMdsOt+wsMJPZEX/A+XfBYAhBWec5AgtglIe+u
LKOj8VHL0BHwtmrILHeTTdPGKG/slMcOrmPxjNMQFihD4OTBXqCAf3lUw70NYKA50zusxfLYtmQe
2leY0BLzJtikSLLIa6SjQXP/gYXi2yMlAk1hKcZiXVNi3x2zgUQ3dMRebXNraSxW/U1T61FLq5/+
HuFwzxCV/vF0gvvL/rkHG59LDheHV3imXyYd2taqm+l0drV+K0ZBNGfWpiVl+vqLpftiN6T+gfGR
44FBz20tRL/nmQcPDcLgT1du/W/0GYr3AI3Mla0/D5Qi9L4K+NUsdYyix17CqKg/6HclxVCU5oHq
gUnMITENkWhwLJahXqnaxA8Amynzx7XMu6uSYaE8XllWhXHuNIuWW3IOd8AHqvdAC9zp7eGt3dii
TqORVBCDyU3GDW400GSAjF0VIkZsNCw8RPbYVGTRUkqpaz7WCCt/YhgXNyNjtTzjLSHw/rIVwP4C
GwBhLwt9jCPAZj8/Eq7lmwayuUMGafbqYS/Q8E3BB+OjDB+LUTzg2cIEeGOy6Hv+/rv+A8bHMe8J
NbJPx0vLF/uQEvdQ9yiJdkgFb3gwRyxhFRaYccINFrPB3xcDHsVTsFDcpxH7et4f+6bRC8MxyPH/
NRu0RC+ORtPWDwy/lR44cgT+dxX67qEY+XbQCXLO+cS+i2xaJjHXuhA8ICNrRoAt8dgqkKNxwxmV
AGWNklajqiGH1pTDGyGE6e7K6eCKGXj3FT5XxaFQnZ9pUc6WUxXmUDjDJelTfzOvmUIczGKOV1kI
50NThLy6ocoi4F9NBJOY9npZLQuc+9B9EL9fFES3pZKxO6aS4kJR2xh/oWs4BsRc/ppV9sIPrRjF
DDnsoo14EOwbljAzGg79ORAzvclh8rF9j1ZrqW3u4l3/psmHlEpkBzIZleIbep8KMz9JCjHPzwrv
xDfz33S8ItV1wcLcQtzIOoomIneyf/Rw2gNw18f9az7C4/9d753hQ/35ldaBsSy6HcaxGZBUPSuA
uNTLIYkrdNtJwtoJwDFiSbTFfo2xr0ZTCQdT0V/QV6+TK0J9sS38XZIj/rVVECsajNumuho+zrxG
tJZkHJn/+yFA8/WTYEMBVEugh3ZgtbdT7l+CuQ8KVbWIIbrZ1Jet++gymmdy01bl9+5py7xcnh8k
VvkJAuy3iGKnMWZk/jb/adv2G0G0soE2OUJqjcEIJgVI0kbzmGQT4FrpZHEL1zWoLZ9N27Lv5JYz
QTCtXr3Mth0aEXPRw4fpA6DwheK/AeKV+VM7X8l0LQuPlhRX0f3V0rRKrRg8ErZ3HgKKd/4h4EY3
LPMcjrvJ3xNRytlJnILWMMnxZmIbV/fLE93PLVtJq/5b6wuMDNCGIgpAn3ufnaB/PdVouifAHxBP
I3T34p6dThg10Gt1mdToTjCjCrj3Mfck4NTaVIgSJvjknOg1yY52umFXTCUCWgH1fpJPS2e4VTkJ
2V7Aa5y1f4kNFYG/KTuIk0HCy9AXBHeyQrA3ax6aC9Cfjsa7NYYDCKceBaLKZzTM7okEvnDCqu1i
3rGx5WTqkWvbDR2DAmuppcjwJuQb4gSXY6UGrctke84VUxEKH/oyhzxpcyjmmOY+z7FuobfU+T8y
CqNptHRQfdVSVbhIxPba3rrgk//SHmjzti6qm3HJHe70iWpTGR72JudXYsffiJXS/xpPySht/UCk
o2KAGlwY16G4stuPjViHXOskJCC2EgwJNeFqhiNP/7oXH+J8F00l4F0LUv/fMiCPT5HzyJjsBM8v
+PtAmWm/1NBZ5eM8lzpPjM5Q0dQyX3dF1NwTZnp9KR4+qbedtzCt8YJn0iuovkioiSts0xjLJs+G
WN9rkYjUXNsp+Mo8SYeh6OmHIdT1rDMmeCB4NDku19QViDmDIdTLXoOpe3l3WBXtfHB+En6YlQN9
MP2mQYL6/va4CawtidIvg6+PD67ZpBcy6Lkhcfthf8NEHYOYBp5/4pHN0sJYTsJcsavoINxC9plx
AIfv/AOt57IxvxX4rcPEC7tydgebtoSt6G/FOpanQh8QzJjeaIU3JomUk8VvVuJ4GE+krw3vYn14
XWS6WBM/G/Yw+bpnZYwsB66IKz2jMQdQlTL9oHz58tsd/CgiIVC77PxW3vFae5SsNVVK3PH3cyGq
KP42SSp12VoE3689xm+/Kgf07CorIpGdjVcx2KTnUs2BAHVWsn2lI8cRVMlyN4arCn9B+8abhYpr
vE14jS+j/wWiCggAXLmhhqvtCk/Lnjj7BfIDhfwrrJnec1JPGGb7FOYpe6/UBWzxGTMgPsgnFWkz
6Gqy3t1XgxTLY2gr3bosHvTnmN0pNhW2nBN9L5J2ZBu9J2AXD0MhWseMLaTst85KTlgqfOhMvl+k
Y8Z1xm3bfcAZ7BvZaMU/d/yk3mRUzq3XMkNbu8d3h+pBYtC1PFIBCt6UjqX1dYp4McjaG7gwUpGP
PXQ9ATKF02F49IJJxq9IBQz5RRRJAw8ScXymrC+IQV39x4WRLk/ObijCYIoivJ8iJianHWDOFU3z
m1rIsGhBwPTGxeyseXe8P72FQ+ruvQWjokqicxysZmfiXdop9BvizPZr0Bszxfij+Gtz1y99Eflp
FN9rqCPlNooyy+zTg2i6trHZh7IlxoTsYVuIeH43snTmJf2EiwscbJZe/MmfgXc4KU4XV291ebgX
crTJLHaD54WECXWVPUBbzXiGrdPI4LmIFPetywXHpdwgesfxdNTrdUvtRRnhdFPD6jBVBaVB0PoU
S//NtNDintJtgxtNBhChcQv8fbj91PmU67xULb0Tv3tQWkLxQj/rZj5HqLdX8JiZ9SAGe2AXtGDW
UopPJys+ywqIqFUV53aaHg6DYsk77a4iI10M5Pju4ZAaiH3yXHb59nW/pi+6MmkHiqtPdox91yps
Ei88Z9qwS0faWQFAbUBM6vSRjF4ps+Jf5dSmeOEPHYdktHy7SBRtdOX9TOIQtFVjpXAY2lH3FdzA
Ie7CQAXdoFaplKYWwQwF2F11PuBGd8u4gThZVgGEF2+Q6TCGStCUY6fSvs16ezNv9yqAWDh0yvvt
tCfJTo3dq/fiatSiuYdzO7dDOCDPKAG9WA414mzA9qxZCHwOoR5fTFfGl4P533mQrMJpXtG2B0Z6
u5zvAz23N69SdeIDKhbxmtmZVYbzXEl4IbM7/jHig27B7Nmxfuq39K/piAiMltsLSuPkanDsvDE1
InHoGSWUhDpAPB0PV6/eAWhlcHbu6ouxeu7kq296XiwZYDMnzGcwSfshDtZ+eJRjSKTNFhbPXRbM
pDf31wPgFqwsFWbUs/sE/a6cYtha1si4a922pGy4DgvhWfEX2JkEVxOulQPoVIPNNBtsz0VcTNi/
Jyeci53dUHaUeZr1heXelzBX/OxmLzVbkH5Wn7yuHvQ/43Ud1ubBAj73B0+Ih3AiviH59uOe08tP
zIO4z2uEshy9eZL4WZkExD09zODxUsKmcT+grA3tIHCYIA7IXXrVuj89hFv9nFBJ2N8UE+C09CA/
xCG0AD4Ny4P/LJb83d81w8tpDJJzLvK2hF4Ywyiy4O7cQxi/iYyex0nfxyQrgISwOA5R3l3fQQXE
T09Ghh42TNMkma2tXSr3MlFnh/pFtM1+rRN7vJSQnFPEWmQi8CXCY5DwqXPMxRFsZq37D5BP+kpM
B1hbc8OfOvTCIk3tceWsoaNI3ZVv72zM/NHs5BgPHOyl3q+qhvBmsOSN6YPo7b00Nwys5k/pZ7n4
+EFeoncXsJAs8nz1PCodhw9lTgceQOVJbrym7xQCJ8BDdS/LsfEbDhkBv0OXsIzH2v9rsYzWi96J
XoZ+rfiwZdEcCwrS6x4000SGp5gZ+01Ux4l4VfjsbMBuqgRGbIxQ0flJACsg8SyvZjdNsiGpRgrs
v8WfSxdVOP550Q4bLXvYX2x6kzvzVshdruc10PPtSp4cN1EenwLMu1aKaqw7S/Y6yzkfxzoS8msL
xMhGh5u47Gh3yU0J8YeiAwxz9PqNPkATTLAGTD6pXce4LaOzFTMAQwWKYbYYwMeFRUTqnRnWKr45
2cikj9UkYDi8OTjwCNr0ZBdPCVdFCSLDEaf8R2JQQRVuR9C+cz10PiMjH8fR3HJZE+6N0SDLabx4
IGwDwAmQesZNanH03rN44rAcx2bKHnTl2vwruOL0tIRXi4CyZY40AAHBj/wu+GXXrvNr0S2u6MJB
gcytBZXbBFeS3s9lj6IVEovV3wZJAhrukROxyxUUuN/Qb7YFYgVsq8a/H3mZ8+w0sOTcGiPAAyQL
cqFxKe7v5+iculiq3CBUqmisqHf0BDAjwcmARer4vkkHf1BFrtAeBWyQNxdhq55k640cBHU6TOa4
etD4wD8u5a39v66Ot4XK6ifYZj/tRJlMcoUlyX/5K8puYOTXIy325TMqCkw7vgHKNH+e1sW/YK0V
qLh9/N6j78kx1jKRs2dvqy57yxBHVZdP73GWDBZ3EvouQtQE1K6+ENzc7zDQysFRYNgI+SRKZIGI
uC4S+AXd7iisyf4jNSP/S3trIpPiKiP40y+ogBmbzNb2S0QEZ4owLkz2z4VaPxlaRREvUVfYsKL4
I2uHmQDjjBmRbINY5bSHCjXLYIA/XkIPwRoumnmwo6jj0Rw6+lnJMjEnagWOUGQTYtZjzIiS42uj
WjJxIsnsnB7GzxqVZ47n9NAEDwcgVj2imL7iHt+ADd4eLX6gp4e3xBIcFsCUm+Eud5E0XzGgT2L4
/ZsCCR5nfYA+wlCby3YJ1f2hRyRIq1X7Tq2aIuR+SY7LK2Xk037i/UR7kS7cGN3LdB+39QpjUz5b
Zq37QGetEsS46f7ZfmzPtx6CID41cT3rXmGtaXLekrVOwtFnUSyQ4puJDeLhVMgWCmsq8JJUTu/b
GGaad5rjyHiewXUEPOxyyxuY3uzGtjFEyLr5Yo4QTRkNV/BQ9wxJ3k4lV0fUK5WJQCFqjVi/+jsZ
Uib/o9pxskQY8NRgKjyLX9tHGQ/ex1WTz3rZcVFFEdFMLFieLr3fEQICWGPz1WT7ZFmP1faq01p8
+QmPuYgCAroc1onzQY0wVTnBFRpWEHv8/qYSW8MLX04YNIHVomJS0pMFyDrmHabCSbwny7bxPONU
7OqbDWJnb5Eu0dPf4PtaPG4oF90ji8r2xNZUrFvv+wnWitxTdM2Qdvi5fcr+ipNlqxCPEbEo2i2A
KsEy4ig8gs841UrbhlSM7ktISYZHKvT+s5Qm3d+hf7pG1QtwG9r4wUvtBw58aytq4R/rNOymYQ5j
eP4FysHeWRauTF8F8uRwYvVQsNe+VB+bs7XQw8yzbS2fJujSkPVXpsIA+IRJWYzj1JwWSYBvX2Rj
H+RCtDoXS4e0cH64r6ZAdET/RZhrmXFrds6mCin8Jh7JyMdlaBg1Bj1+vzsf82XctCS/yhCynsAe
V3fbjSBcZb8etjNVfmQvrEX7LZVJHWfJW8FxvjuOlq8f0bXXiUf3md8xUROOFkwIf16MCoHHz+em
2wugO4gW+7swjz5es0m8Fj5tJOZQizmhlQ8Q3GUTeI4+X2LH9UoZaQb3pRfadG8dSvUnR3CpPjjy
NzhkB9fNeZtCAjCPrEvQS/3uT4639TmoxwSxNJamOdi1guRtsQj/i+BolxO/wSGnOK0nBgTxizwh
OZbBNyt2h9z0Dk8/mZoqnDIcH/6BXXtvN9c7zErFGbDwIFeGFJKjNdqXSQajFDrB4BCbsev1FCF0
NXpxfpJvEC9fRfiv96l3A9KCUUO3g5Jj0IE8GJxZW6JOQyh82NsQAyAOb1qh31kdf02zp8Vt2bXe
it0Fqw3RMF4jPFZBJExG4Zw9GSELROh3C0f9y5rKl7ckf/0edOb3DmsSxFnILd8WGD+3UlM20/kk
/77ydidGoBZ0B0/7U+mb2uCnQDRwH/DHLqZB1ZB9AdgE05aYcZI//LJ+aNYoA1lSQRSt6B8XgWNN
Vix816ga2UROwPehA/WRa8elgPOLGpsikYguvCgL4Ih+9oz3UKaj/XDBdidaO5jz5wxxTY5XCksz
LZHXmkocUh1o3WB4fikYMMyzwK4skcIiKPHlAOMzK/JDIkn12crc1BIYl2foTfVgEOm/aQkYu7mc
pyIT8Kegen5mKbrw3y4Io4DUkThc+OPXd2RQyBh3p9yA69YLS49ddaNjekssDQO1nrrRvm4GcZPn
7SzFkJC6ZX4a3CQ3eI9+1RoH5bwoxenlTkzz2wNsTzxg23yyT5Fqed7yir3nmBSWSfHrW7x72THP
/+ktlcrCyh81VzL1CGRBHUaqGNO5FeNmwvwSoWxdrHhsU2Eb9/akjK7K+kouO1A7qzjyUHuSp93m
CMon5ZzTp2oB1AjLqNaDqlsljvrTCxuO5bysIoAsnDJXAapiEE0TRS/Vfh+sLM3WcHocrlXb8lD/
sZy4l99igP6x59fGqJL5/DXeREuxNcAslgIyg88YsCDTrKcHasGUqKPbE51Gq9PfirCNOhJnbTsI
5WiqlEDRjNjNNyWh6NQw8nPWo5fP0jGjmbEQX1um+82Ratup4lmNmM7PuRrkj0nAMb/cQsbJio/V
PyVWUhsJ7uluRMFYOd5Gv7JcedVQ/Eq/HvdSXcteqaBKUwCZtTh/Go8q3nBRbJPfB8HjuECkxiTi
8FgeuWDZ+Rx/M2bpUrCa9a8S+yoXmN35579kMB76tUDdFMAD34uHNG8j3pkmvdrzqPL6A9nyOVeU
5uIZeQqFgeddbf5D3hw/yZENWcfoKgTlUD2IeMX8nn2m92w/EjONnTpB0oU2mFhZXvXEPtiHj6Xe
MuSr7CxDH5lmpgx2RbeEIpkGVJBIlzwvYsEpkre/o4pGzxNMJN+kAphLV8WsqTMEwuxBRlTn9eF6
96SBlMp5Q6nSck2TKOM/CKVMjKSmism01mTe9oh65WLlWK96ZILA07X7tSJwYQfNQVcfZgnjcwUP
GgyTyKPB1vIFTQ5yDoM4zc7rwJF4kfdIX/s3ZgSk+cYTcali1oy4pg3592Gki/FlqxTElLDBaS/V
HL7QUt9PdTmECO4D1ahxzrhJX27wcsTWj4vkgSeYzVZ7FSp+AJz4ioKMU5v7QkmswJQupjNZw/bM
vQILXDVB0hp+Quz3IxzBXAQ4oqOhh7MwpxJ/iRVJEavGwg6oOD/b5t7hsBKJXzg9cD1fNqP0WUvO
J0bcFOkAxgd/h4Bd231hNCguxHJf0Vnb7SysHesk5aoRJ4TCaYXwPj9qP7YSImjCiCIcu6bIA3zI
8xGySQa0DwAYd8wTMMsniRm4riF37Ionkf7dg3KYWrKaokuJE19kuBdAjJaGwzjVJhxlgvfrTuvL
gxWpvTfGFf/HaTfun70m50xcL79ey8DFnUDVT8R0cUhxfbyl2Ldtgjmsz1t5cYts4i+VmD1/44g9
C52poQhqcFU7fvvLsAYWkRh1Vu1J5yo6HuY3NPDpJSNJf1GOfvJU4hzNezHB0V5uYgoToWr6OUyr
YuftDGEX59aESCLqsTYN3lmyeWTYR8GK68EpIwUuXghmxug2IJehLrwVMHWowGjllt3/4By5HpCU
XjUdiKYTZbZqs30xgrn0GMi1UeaP6N55mkVQ/lrv5Qm4lgsoY6tEMex8Pyl4kgO2gb2/kq0BobTa
iS8SxGg5pHiddlCvt1Vt+NbvxPpBkCaQp8z/0D1YpQrqWEdGuqqT7GDmFAZyYJboJXFUDK/wJmhI
o2kTACzRgnLA4Y3BwGRkE0fjb8PlGS9bZbhp+15nwAvYbWwz4ayw1nMySeyJWmJP0iwfRPqyZtAi
R+MZaxv3GKRj4u0kaVQxoF6OhvlReuyqNVY07xowN17L2PoIZssJO4swA4hMbzg8xDZN+CzJFNvX
vzmhNsTC/y5tN3bl0XyAXzXwF2UtF4RGv4D2a43kS8o9cSZiM39E/Q5f6NdFxqIolF/SbF0UxZRu
/NRp3Ir86B+9UVTa8VKD1VG7GoXn+hXh6HmE6qjUcnFMEMK+1IlhrIJz4Rid4//gCHDcrlSb95rG
ScTi7szFhvgTCw0Z5Sz4dgmPKOWhQHoqosJ1mq6TD2pBSgVv90D1ff6y89nXrHrVSd4bLkU+Z/In
+kcp/s5mP7lsTmuDVQ7X7qWmb+lCn4jVX0RDxOJ5uqzSziuece9BVcg6Xok8EBqzTvSHC5UhrySe
4q/qjuig+izf59CL1jXBi5NnRFxJ42y6ljQewsQgzWpvuDSlZbZ8fV29R5KBh3YjBn7LHaBQ8SWU
lEk3WX4h3teMwunPX01lpk5GPr2DsQvkXVx9xclHA+rvbDFn/ljIq1RAjXx6bY2vxz9DjsIgXh0r
b+JNfEjo7GJOWZREHfG3XYsj2ysVKPalG/TRKSqkw/wSIYvQq4mKLO/RSrcH3t56UpvW01ebOEVv
vCAs/g3s3vZbwUREQS1ksg8Zpo5mMEIHGcropOa0bTHF0WAhtDyj09hVEQj5CsxPktCTVBJFbMBq
pRP8v6/u8MOhfEKIIylAhFnukl5LdPbLG2ISHx4ERZFy5E5+CkwMFA++LgOfjdYu3ag7CcNHrpOy
AdxhW5oFhYGF7LTRYA86OZGYcx/6i05nYthmgFY1Uu1fPqPoF5nm+Ao70osS1dGyKOeX2gKE/kIh
Fry6ww/u6KuIL5sA7hnC8biuPeFha0xMTAqRPM1rxuGo5DFt6ZoMgrHBRCBBzpx2ybwPvx+uOqgC
x9ifWq1MvG+sJQ9H4o9Kk3OFdRzyEMDJ7X91gyMNCETxvUt2wHSHkrDjSc7aFpd57GEhhTWYyIoM
WJXqGf14hYK8qLppQS9nvggrvPRDUjEF4vjIlUoB0I4gabYqQAy4xQm92uKdcqickn0969GOH+Do
jgBUsYRJC7rq5POabXJAbS8JDXx2v7Djo2bNKTamIncKykf1Nc1a5oesUfPPY9eilS0S20lgXFLT
JPSESW0rWkiAu7ryBDH4+Kg6R4xMjhrIK86L+jwP/jxypaKPPBiaAAzte/JZKnhC7WqwBEqcnp0/
GcHBDfaKjzGxw1qWkbavhilKToAt5bB4IYts0xcjJM6yTc/uNMujTyj+mXPpxSw6IFWpw0mergNW
OQKm6lIeU6ElalnKh8Ih93fSt6REC/Tm+bV9vIi/3vZzIhUpWAoFAouDFWQSHiZMJ76RAZKt9F1I
jy2vrHAdllM2wYzc5mBG6XLrepcwrT31IgG+2L7/4ad+cUleGwGnNWdmbKOAdihfkX5aJKNKSAHr
FFK4hua7x+rKPaYMS10KXmMwDT/w8VuwbQrwkqrXFS9sflioFbZ5W8R98b7cH5FqcIBnu6Qcig6s
68Afx3U+dsk6C+Ew0qU1//ZgoevewJq7mfksluCg55906tgEEXnrQG+SpSeh6f7WTemXZQlcL+Ub
9TCfX+s8AfyJGy9ZTOVwdn/uyHxMFtUtP0Yk+KT4yEAlN4PsxOf9YRdxPSJaQICxKi8+lPclzimt
fHj8O2aU8hhBkEu23RV4eVytrsZ0nWV2f4XPgo00y0r8Z46NwtbiIIxz+/lU7j5hK/f5KNv2IVbJ
MkbuFEaQzsuZQ+s3d3EwZqvk5fepG+GVGSI4nm3O0QphcGNSSTQzPhclduy1U+fxj0I0PeLk7jSM
ST99464NHTrq8gyIhqoPTYoLdohR3s48bNOUbvD4+lDuCjcNj0jzqVkwoK48XSEUQGRh+upZD7yL
kpawJl1VWKhs+4FrboEAf3mBlKwM83rAkGSTqFSN23wR2ydjmhu1gNgVzpJ20Xe7mktEyPThWjQi
oRpuZ7gQh/ACwRJT46o8RppT4IlLWNfizeKPj3gtWAKJxdGJnuuvLS1OwbZWNnlQILOHANMK32IS
gpm4Azz8+zX+RDEZl22iEG/rGAqeWpGqF1D+I7lZFrICnTyniFig3GxQFRjJaCX3D8/TqEkYQ0Vk
9l+T3K64zcF+AyuDEped70Akcj5+UzoI18BBa/BffJPnZnihZ7y5Ls8hMC2p8hn7zAxBNw6nSCyi
un+n1XWYqmOHCLdVrPHaiLZTqmoijFUYqJCkkf+LN96kxX2Q33fJSWXA/LgiSMLGx+gk51JuucFI
h9AjrakpC7mB5fdojXlPSe1FMABdOOKiimDJTzCmxitWvKtMbWyN6iX847U+CacdqaJ4tB//MF3J
Aq1/IWKSQTdwlBCyJJvShSCEp4G9woJxOH2w4iaGKx0n0ntS7FycEpSdS/2iYF0ZpHzZ659E/dcU
5vPzzWQ0ZgYEFR8HjP3bY9OXcPx4/jcYOzchHdAgO3u9W/m2fQMe4+uLMa/OWKI8m0umHdzmJwMz
sQ2vn+PrG1CJULiiDPFpiDufXi91SnFG/T6NijdUJuss7dDYO2/ey17QTtEZ/4WKhUSr8JMDK7j/
ohUGkcxjyP81O7VLmxXBBagFVrDga1oaAxc6DDTVZu1mjA9x2ih4oi4TfvlqrgAm69/3qFy3Crhn
cQ6xbZtKqYnHz8cW5ffWXYXRCdRkenCFVkZd1W4kE0GcE6FjEeFz9tha6IBLW54lloHtSZ+w7kfT
A2jQ4FYBvr9s6qJtfhlphNNfGt9zdrMaCVyCoIkHs9bbLP/osPvx058dvSMp8XBMdUYyulaK+Dhr
Byh3uJZalPK6ybhSEXi7Nn54vUpnLKVmqILpovflPcZXUzVUnyXbf5ppsoptiLvyy3/fccnWoTCc
Qhqoj47DrJrkbSVTWVa6oM+Huw+dM3r5CdPn5qILeJlEt9gfAjkbu72jwJEwXmhAxcl7MMoNO65F
X2RRQSDCAxXfbguf/BU+4XSCB9NfsLEgxqPA0Q4oKlKZKI7SBvHAOTYTulT9YbxYGl3X0vx+kHor
x1Mxo08ozIJ3do+Uh8x+urWA1HDaUZuJ3CoV0FFNW3sbqBfD1PBMnWFHFJyMfcY/CxRceyEB5Qxq
xBtadT4NxSJUy5cdvs4Xms6nM1AsKBfWqPnSPnMEtbbwE9iEtMzLpngkx3Geym0MtRFn1YJuxMsA
jLdGrBb2WQFpPIjJr8T4LWoBh9TLFfB2aOR+OGaWmwKof3DbFK+S5Prf4Z2bzJ2XBRUavAGAtwzX
QNKk6NBwgycalq+RL1pUMpwDg9EjX7ibygvPhgokJhG56QsO/Lvqa0awyRn8zXuAhmYNUi8OLRPb
/KzFvz2ixhFCaeLFvfxooTUAZgDjI8q3Xuw0O+njRze1ObnazPHHbF5Y7VX3gXy2bswDxrVAuYAe
Xa0ySNFrHUBdOkH1QR4inLcHAHI5HHIYgrfpDuzfHUO9YjPQIx2InrMg9oj5TAE5YJMqsZXgtFAp
txLBvOP4HE2oxH1q7S7QHLPNWLDrREjMETLZ+3alCqCxBm/i+YssXYaL9ZME5WDWsWAMUBLjXbry
1QcyBOo3afn0jT2EBAB+untdLCKCnRmXEEZbF7F23n6qGH/MvxqMj4lllFKj7hJuvesL3ev4FtTD
k7FHVxOtYlCc9lofmOnX3Dj+mcd+bD87d5FvOX9FkKW2xcYIOThXIp15/PiTy1mQ2OhT0t57fEbN
Ekdsshg+U9nqFsI2q35YEWOwUYmcG9naA4sWcGCLzj3XD/axrAHODfvsU1N47ZB1znhybHOnNOsf
7/fma7r+a+5ZEcql71JyURunxcrG+23HCNAzcJankaT5vlu9SKUzzXjRT22iiy8p5Cmc3S+fdCzE
d/5XZOuqOxuLoRPF4kZkvVsM8INw9z9/KPw4Ik9oC+Ibxe30iAx2TWJ7gCmQGD64TOeo3HN/zdCQ
FxfsZi+a/oXcqcca8GY7u8n8xZNxzCBd7KUZ7vIF3jIKw80AagNrkBY4hhXUTYyuqVR3HTtdeyXl
30JGteLk/PDLUgLrgWZA2emPGIVcIMC9CsWcZ3cmTdhNls5YPO3AUSAqCtox7n3ogyVtfCLJzVvx
Y3hcXSuKH5mH53voCGCCZT7vgRZQ9MY1+Ve+lX8VMPHWjPDpWJdwRzhks3s2IzJ8m8EpaN1iCMDu
q+uVRKKz89WoEX/pjq1+4oZf2s5eoOKmV9FNAjnTtgckdXSTA+oqomQ64BdUHylE+dtJX7/6FYui
wVLeONeNCxo0rViFwRQw/AIVM/M/uWbcQtJFTWZyYRp6ICffeG/y2TaiWqUdlRoRqVLNu7EwsNMO
4lFcWQxFJrq8Av6O55lz/hq7YhggmXFdk5eWXjEPSIrTDssXDJXSHK33bCkRIW4bPscdX2MiyNUU
EUstQXHniUMjwpDQNAQNm9SL+wlUMU9FGlH3sQpbmHhH/9tfzxI/I+JGJLTgi6iPHI5nTPPoh2Dq
0z79kx5+rWqbYxO9bZztFOttTuDXAYCzI/B+WfM2HIYt+fNTm8oE95RqKunzmRbrpqahQDMMRZke
+gmhcnZBPsNucvqGbzqi5MBo3Mv/DRetzbb8ihK4EPFqxB7EgsJp31nz3h+Fh+U7ccETHh8FWoWx
D68kekjBK8TlF7iJkcSvMquGUwFlX9eE9ofj5vL3iVeXSBxp4mP5BuwMBg5hXMHE+lxj/Pp+EDCw
RpHqw10Y9/2iOqXQe5Ch3y3bvbUqbGRDoARHGxtO9Uv6iK8RI9aErbqKExzh1x1s18ez5iva+vHV
4WeD290tkQuFYyCdS4zuQKy3F7pf72XzDJGoRK15ntTeQMyRbRIgXt+AKpGJ0T9YNrvY2rqtdYj4
vtbirKdqiPyy/+yD0AfHaspUi7wZVPiQXbtu1dAwc/dzRI9xfnT7IApoCvk8GgQ8NUfEApn/vz8n
ZU6xnPkLZ9zV61QP8as1l2RKe+zi3SgBQwHwiVNkuJNT4gemwezcWMr/0hYxvljmoaQtaP0tVQus
gnXxgZUdp2kZlnrNUN7NAA8Wy0oI2KpUUuSIEv/w3t6VhZyxHy/xpj2owBi3tii5tertniRwfs/0
pVQmgo2FXNXlw6pfwsujjzqqabmdaYR7GjfzrgXsjO+g5oGpM90PzrzWMLMvuWzthJV7frl4cp3H
C0DdaSxBPXJDuNpL+m35m+7LdHRsGgC9WapqDVjFkUUXx7m4CZ9h3VJdCLNtMtzS34Z4IrtqpkC4
hG4RNr49QR2upeEXK7ignhsZRQYaBFX3qZD9woDqipdOkSrQkRvzJynOdGwsMwI5mWfOL7Q75hs1
ZHrpexDmdCg2iH85z7FIR0bp16X1OVq7KmaVYnIEcccmuxm3D9okREDZB7kybX0JQ4YQHokX9FmX
WThFq5srwCIZbfQl6vWQDRI01wvlK3bneyHdMw3w1kNfV6yiuARI3ryS/oUXv9U+i/ngGKr90x6p
KTbr1MIdSz3R0T/s5aO5CYHfpRIoX+PqnZ+jrrLGcZI9K/IvhAsnqqCGRb4wcAlLtuX6IclAen0G
qoM7ltpel5BXjFtwTmMamuYd67eGBk0r6n3LjTzbwkJWJdczy4Oe3qUdzfDHKRjaaP9zN3dJ/4sr
WKU+O2GYvFh+C3OT4I2Rruj00E1sCs9qdbSorpBQ6GnuIljsiBJ3WuPCNQPktr2JMW3Pd7IoFkvQ
ZiDFVrhZK3ws2hyznMxRqG+YxxEcWlLHAI6eiL1D3xo3HsZQcbcb9WtgRycB5mlJx/NSQfmV3ouR
ednrz37/GbvVYOoRgtlAjfN5erVk3p7lIeRu1Ak/J+VezM4FL7u3mY3mFeqxjZOA+easIkcpHHc6
4KAicXAUdk22JSa+jFwBAmuckIQUJqNRWLGNVLMhZXSLba6WI4KCInBPJWOPI7WRNhTLjZFWOLL8
V23LLxdv/jIuSWKyFtmAZOxYEY6qKq/WOAyeDzGNiTTb+ismpES3BcBFaf9DWalRT+ZMQDd7vN11
N4wfEcltCydBMrfQdgljNX8wT7X0Y24DtuJ/PPY9+cXtmtr9cfufIdEU+w7aE/EvGpAmGVVNnoTK
788EGkAvN4rNWyd6+rKD228o0rMgOxcppEEqcdjc+cd+nrWtPiRW75xvRmshrgTgPl9HLZgKdO58
Z5tWzQLnErUG+n7HprKAK2SDEGb3tVcs83h7JBwfKFSRcM+Zb0ccNW7uQs1/hWq1sHhNn4sRewfE
9upuV1Kkxk7GuCyfHNs8NMY6CMta1zoQ5U1ShiWmBOtzdqrPTDF+hmf3qfY5WQ+njXIVkL9+Wp/n
B71YYMIfOhPJN86diyajtMTXSbToDT7zd4xhWasI3LYZMHmJcCwB8CA0dfUE2bntIp9TSn7oqlDY
9ZJrulYJxqCo1vkz/2ke2syfy63zIFjMi9XyrIyJNbgBuwhoYQkGpjJJ1SLGDgLHam7hvWoIuRXn
yvKeuJDEIzDG9cVj0S92Z3eY4VHAGb9q45XssHkEAByky2m8amPSDEHL5gYR0umkoxx/vhs97wmm
BaeLX2JfPIJxem+rKMFpdKHJIh38F/SSpm5JgY0029060iVbxmT8iUzJVj1vOSnuPJIxXXOSO+tj
9Tj/i/eYvbqKkgZGLkvFl36489NapLtYT9ONp2aRwnm9cciJgGE7AablDRaUE1TKIozeVTZQbkUX
6wZ1BwDFF6Y1ah0PNE8eosIvxZHxDrx49jTToFVM7vWk2otmJs0ah2SiM9lVJ2MBnwBLTVnT8dHV
aC/F0f5PqITio8nvq1/sKOvLfxCTxvmr4DVcwaq+n6VPuf4MamijQpFo3ahBXceNY5WVsv5gpO4G
fwju9hYdpOhi5B+VafjrFuu7/8f5BlwCac3lzMMeIBn443CD35xhQdvwOUVRYoKUHoyiJK56S33L
LJEe7lMi6TU0Cui4VKD1PKpHvTHp4vdxVZrZAjyBkZHuB0OGJf36vnva7XEx085bF1QAwu6gp0GK
dV3XbFQ6uilJxkXisJ9FMJy1QO78Sv70oRpypAgbEC3Z1u1NyJWhhwds6kUM4+GomZpMHtaff4QO
I9K8qdkbdtdsIKvplICMulQt5rB5rA0ZvExm8yjMLvzadvTnyo3F+j6cMDFxXY/tVvYEVbXnVcn7
t//UOEXGcFgYA4SjnqyPUWbc+BtJYGi625raWc93nUEt1x2zCs5vN8Oqvn0T8OkoDk6i6xQCSZWs
IHqfXPjD2VNcCQ1TvZPb7Kd1dfM9D1L25OObvzstg2t/YlaURA7xzWcnNvTYzndvFHz/VVDoIv/i
uPzulwFpHWzHwTLsaxUv6W/zstl3slK/UCn9QC1rlRgWt37Oe1dHnBAhV5sJyp8FtPpnUiHvnDAN
V6e71nDIORM7q9O5hSKzKF9EYjFg7nfImEgbxd3v+IDvctCjzeZzsdOnTYjK6WooPlVzIYQ656fG
H8kcsC4AQrgi+aEUJDUvZrFSy35hbVIlEcE3GRI+FLbq2nk3vwySP72iF/dgH/Gcx9NuxuvUcQLo
e5yCF5XLIcKcrs1Pm6XKz/Nip/B4n2WTFV/HzV7k25XghdyggCHsr59MA0dKe4mcyRNhM8vHgF8l
grolQbvIU9lxwT7lQqSvs3IctAlbKCpd8B9CLk4yzLxTTr0DliEpPetPOnNLwJPCh4d9+6LPryin
4QxQNKDcwZGWl55Y+JlepNgUwIoRZDTSGs7mZYCUZcIFJt5ZV1q5SIq8h6jnj0KyeRF0xH+qPHtz
2zZeVr4tKcdml4Lgom4gfOW12MhUFNYN9HL1nZba3J7ebyBC3WKPHoLphgduuow+GtmZTK3KAPpp
M460To/9qsvPLnaiL6maD8vY0Zno2EXwC6RIQgFT+kHfN97UvrdseXT9pjHo7jQMiZumSn/eT35v
0jllcu9UAgbvxn2OpAzlkq9cHCo+Vq5JrbKzu0pZUZNmABsNuLP1EU5t50iHvluL1kj1DSGtzqx2
QzcqspD2fOCM4+ItJ6P0847fnCRTpNettwIN96R03UhwMpOEfR8eyHyn1FpeGpRhL0VrssA62Kxk
z9Qc3ClbiN6EKiPIPPFSvwBv1RezHAUV3mLs64s1vZdBgQQKDn85/WtAeN3MEG2GrXzGOK0aVwda
0hyK4VuMDIRuh1f7tFyYpDblN5z16d4dIMQ+btAmgaiLk5UGCQoapVnvVZEhFfNpvebJFXtniTHx
2LObWbasjOxM1QjyNMbziuJipGhJp2T8msMWfYwtcILxGAQOu+s7nm/Ntfkn58W5TWXr9RlXnotK
XhY8kyKgDpx5nDYJKB5Jiuk86HVw4vd5A4Y5eOPqXONCtCRhIPQ5XfDFqKTIb2LGTgGQO1F6nPXH
dE5j7hxMYrMxiQijJpAYrOfslrWPjM1sxWIeIqZMp0oHpUrnKUxy92QCKGUI6k3JgqDVUphg3iOW
kPSX3AJ0Jq6PvvhPPqmaPQ8UNx9seLnMB/IO3bs7k5kGUh3yiLp8UugS2GmfLUSeYe+b8xn3pBns
UjhH6vcM5S8oAVz9hEI0Z38OMNMBcyWUuAEHlTi8jHXG/VsTDIexeVCoeLGLzQMfcFOGULkWphbO
/Kdb4AQzyMCb+CZyT6HjpLbRLSdCmfynx5olZUbtaAvT/R3is9yBJ0F4o3Du4XnEsH9scfBPtxha
ceQ2WfFPg2cC0Hu4VFsUbIKnEKN+bpm0S66u4JKnIaJas+kCVsv0juWVF+vyfxCZarexjNMKdvsS
UiZXKcx6MGyKBmTzUB0nN4DGYs11gpzMAL1caNmwaaOxodXJVfbPaATqQZvgytFYqXk7PxTVmMgl
Q+UiddBltC/HQfEMgsmY1OLYRr0Z98z7DHbwK6SVvtyJHpalrt/55yZRq7NkxUdYV0+y4Y7hhFVp
havZB6nykrlLg3uT8BaQjN0ZgyDgD7eIr1S8mkEJsweujdu+Dq9TqIkwqaaqfPkajprlRh1t7o/l
At6Ox/SgdihrHJA3/aJro6FKX+AdUGM/NnXkkmfETI2qwJsTGsagM0GjZGLFBUSQYsbhBAWey0iZ
MxNNgV0xLe6dbwYFBBsgcgx14Dga5gR/YQKNCAJ/SYYq3mamEosce+AfrQHUkPn4It4G5Q11jAAG
qPsOjxhHGl5AOLuXbe0nsEUhgtyMXDJccQpLlRX294Xuo9l/JVKy5I0cp5Ox5vx2RCrPQVqxv40h
NQos+Pmhal/RXd2G+JAUO3q5F2gB6UXkyL5QKlFB6SHOjIigMTHq7Lm9TA8x7eOmbMKqDptiYs4G
Pd9sIgNFCgMP62nMPpVmcKw79ZaQQ9S2aKRHhSNgFmfmqnemvIRH7fwZsselKR42Fz3wQbhS5yzz
I0m1ESi61D6mts3RzdjcQ4rg9pFR4X8eGlCKSQb8PkrFA1aS4BEMnS4Kd8cU/jLDpWvdBdAxANvL
52rb+8P6h62lhXEllLZM3Nsco6/YD3lEX0xg+Hs2K6DbzYClDszF4BlWIsheE1dyg16YysOt++kG
URlGknxZQKRA8T/+yF0i4JLzkbFj9CfB7RmewJgfZvWah/9ZA7dJMNZy2jvghdeYEpR0Myx+XPKx
fYRgAHs4MoxXT2V61v4D6bz5kBoqsdf5Ss+Yv7nDC+TbVk/QadYALYgG2HtOV99h084vOiS+j+1X
H926OMqvcj2C2+u/ziLaMHmYevC4zaTrovgm5azcnJ5uVwGxkwhXXSTKsaTqGo4hyRTFmLnJvIq4
WKM8h8uOfVdKe4jaWcVv/DaIGNpXOYQDVkZhuaJAbEjDDPf5pH6fG9Lu8azeJrKSXM3DzBvH7SEP
cus/xk7+c7tdwMOAugAHKFXAB+CfbckUx4uf0F370F5734ndxcdz4hkCWNbMPAS0X5SdD9Dqtu1r
RSssOg1ekZmNr88YTj3tDKwdXkC7W06JoVXzc9C985B04MJn3a4IPm8OdqcYv0ZWTbZKfVSMfdtG
lCnqvu+Tq/Hf+tmMgT0mr0ZWXFc8+NqgIPOIHolpKLoW7iWAMziXlbZ6yDdOgHHXLWVfuTZwQyRe
ebe8/xBJV8kv29r+cuLmlMTOfk60/qZtxDM7NsReFx8KH5IU4sZ262mP4n3kFeBbI5DbBww1UW8Z
5bAj74H4wdYua5YPkNepRzstDV0ogD3N2ZZxiYfIL9DCqHj4YVEgiYgcE7gFC/oTSIfBlSbOaG/P
eqa9NX5KRsE5LWzCFJej0Nk4jjUqRbcUf8xW9nGkNr+eDM4nFyPhNS9eRIiWLJFgqCjtZ1U999ko
TqkexDezbtotMoZhlMqkG0RMDjAovXdBAndt0V3KMCI9DThzKeOWq0eEgaU2IT7nN3hmvdlyJ8Ym
grtQUu3zMBlUPUkAsxoq7d0GOa9DMhdMxLwA+C5vdzyhYoygXBZ9pU9DH3kS927QeWrhdJAtXUEr
pkR4lPa0xSkiXcD1fsifjhxZk8DkhwRMayg+abSotvNp0O00cbGAdueSdqYhz/xc7RCLi28QZ7/u
PleSrUzYPlMpapaENmKu0eODCytRSthBSyVE9uBE95113h/iXQEqit2RbBRxq0u6rktFwL105nfT
8s00bTNrupmJiPti6uulr5OG+W363GA/TB6uJlknlJUHIAniMVmaQlnm2iPRqzT0+EA4mIsHJa5o
H/5PUutF+IdfY8j74VCLNI1DuilAUjA5H1tZ1Km8dTGgs46sp+HVizAb/DN09Ndp9Qh7vNGk7Chy
uJmyvbwUPnkVklJfqeBjTuMWxn/7+1cJlBPBcT6R7HRd9wbFpW6k0VHi+5iGpbZ73gVYBvdUl0Sk
YvvwHOFiDEezfQ4LVEB9i85KOrq2PiNx34UgqRCf+/X8dMkbQdVjlCCMcp9wGw5spRvKKstMx3tr
5nucL+dzVw/N5t2IW2/Mk74e+bp72e3R/xm8c2UZPlOq4sKnAzmnCzpXxBxEw15qHq/L2Nh/LQhD
EmN21bMMpKyFZVJZYBAx1uShPHcDr4QvcgtTYGuuqfs5vC0zFZ89mRcyoB1rWiZiFQ==
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
