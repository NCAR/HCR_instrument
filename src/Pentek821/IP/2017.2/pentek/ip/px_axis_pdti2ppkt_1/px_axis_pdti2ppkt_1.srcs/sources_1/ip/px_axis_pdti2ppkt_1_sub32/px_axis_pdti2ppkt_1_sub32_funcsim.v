// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.1 (win64) Build 1215546 Mon Apr 27 19:22:08 MDT 2015
// Date        : Fri May 01 22:28:06 2015
// Host        : Igor running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim
//               E:/px_ip/px_axis_pdti2ppkt_1/px_axis_pdti2ppkt_1.srcs/sources_1/ip/px_axis_pdti2ppkt_1_sub32/px_axis_pdti2ppkt_1_sub32_funcsim.v
// Design      : px_axis_pdti2ppkt_1_sub32
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e-es2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_axis_pdti2ppkt_1_sub32,xbip_dsp48_macro_v3_0,{}" *) (* core_generation_info = "px_axis_pdti2ppkt_1_sub32,xbip_dsp48_macro_v3_0,{x_ipProduct=Vivado 2015.1,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=xbip_dsp48_macro,x_ipVersion=3.0,x_ipCoreRevision=8,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED,C_VERBOSITY=0,C_MODEL_TYPE=0,C_XDEVICEFAMILY=kintexu,C_HAS_CE=0,C_HAS_INDEP_CE=0,C_HAS_CED=0,C_HAS_CEA=0,C_HAS_CEB=0,C_HAS_CEC=0,C_HAS_CECONCAT=0,C_HAS_CEM=0,C_HAS_CEP=0,C_HAS_CESEL=0,C_HAS_SCLR=0,C_HAS_INDEP_SCLR=0,C_HAS_SCLRD=0,C_HAS_SCLRA=0,C_HAS_SCLRB=0,C_HAS_SCLRC=0,C_HAS_SCLRM=0,C_HAS_SCLRP=0,C_HAS_SCLRCONCAT=0,C_HAS_SCLRSEL=0,C_HAS_CARRYCASCIN=0,C_HAS_CARRYIN=0,C_HAS_ACIN=0,C_HAS_BCIN=0,C_HAS_PCIN=0,C_HAS_A=0,C_HAS_B=0,C_HAS_D=0,C_HAS_CONCAT=1,C_HAS_C=1,C_A_WIDTH=18,C_B_WIDTH=18,C_C_WIDTH=32,C_D_WIDTH=18,C_CONCAT_WIDTH=32,C_P_MSB=32,C_P_LSB=0,C_SEL_WIDTH=0,C_HAS_ACOUT=0,C_HAS_BCOUT=0,C_HAS_CARRYCASCOUT=0,C_HAS_CARRYOUT=0,C_HAS_PCOUT=0,C_CONSTANT_1=1,C_LATENCY=96,C_OPMODES=000001100011001100000000,C_REG_CONFIG=00000000000000000000000000000100,C_TEST_CORE=0}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* x_core_info = "xbip_dsp48_macro_v3_0,Vivado 2015.1" *) 
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
  (* DONT_TOUCH *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_axis_pdti2ppkt_1_sub32_xbip_dsp48_macro_v3_0 U0
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
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_axis_pdti2ppkt_1_sub32_xbip_dsp48_macro_v3_0
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

  wire [17:0]A;
  wire [29:0]ACIN;
  wire [29:0]ACOUT;
  wire [17:0]B;
  wire [17:0]BCIN;
  wire [17:0]BCOUT;
  wire [31:0]C;
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
  wire [31:0]CONCAT;
  wire [17:0]D;
  wire [32:0]P;
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
  px_axis_pdti2ppkt_1_sub32_xbip_dsp48_macro_v3_0_viv i_synth
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
U1AcMzL9c6wxxxH9zDIfuwZBEc1HOVYevpKYCMf79j26WGCkUMetEed4IvnARhZxHZ57eOEputR8
FySS6pkWbOXtz52/1WTlTy9A1KSuWE8LXqFuLDUeqDl5m5Vg1j1wboODXWm9d5aqX1LL0oUjeV+y
h4585OpSO9sH+9s7p0RoCkE+WWlqny+KvJKiYFBb3o2KDRPa2rnqqZZlomclNIIl+fuupbHgx0uH
67qkaS2BrQq2Cf9NkdobBiHAu8Ejj6IJdZoZ+fMwq2SAKxBbtXGRie76MLYZVPJLh7rbZwvluNWk
Y06jdB8os4cJ7nrtYYhYqLTp8Qud9CwBalnAgw==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
IS6szLKfMCX2iX51N+jmkbibpoWfycxd2lcXdLxPvoXNMaxDVrmZ68+fNHJel3ZmIP7qP1bvS9hn
0dtLnFnzYLWlAMoUrC03V0ud1ue7aQbGmzQuzdJLcR6+lS/hbmTDohTt2vy/2ahE1PpZZaiQUzfU
xJP3kUQwScJ4IXEQSHLyup/WHRdSpjDlT0CJEcRfWIttt3U8JaiPqOH0cXB/SuPDIlaNiVt+5Ztc
T7eLdWGzDjvtxmAzSyjRJz2s9eUC7TeFswnvDFo+bnbTbeUisethQuvPwcc/hnWmDxO5+oR1EFPN
2s5mfO5Zbj7BK4Qu2somV7K7AWhplNuQMY4cog==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 5616)
`pragma protect data_block
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
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
U1AcMzL9c6wxxxH9zDIfuwZBEc1HOVYevpKYCMf79j26WGCkUMetEed4IvnARhZxHZ57eOEputR8
FySS6pkWbOXtz52/1WTlTy9A1KSuWE8LXqFuLDUeqDl5m5Vg1j1wboODXWm9d5aqX1LL0oUjeV+y
h4585OpSO9sH+9s7p0RoCkE+WWlqny+KvJKiYFBb3o2KDRPa2rnqqZZlomclNIIl+fuupbHgx0uH
67qkaS2BrQq2Cf9NkdobBiHAu8Ejj6IJdZoZ+fMwq2SAKxBbtXGRie76MLYZVPJLh7rbZwvluNWk
Y06jdB8os4cJ7nrtYYhYqLTp8Qud9CwBalnAgw==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
IS6szLKfMCX2iX51N+jmkbibpoWfycxd2lcXdLxPvoXNMaxDVrmZ68+fNHJel3ZmIP7qP1bvS9hn
0dtLnFnzYLWlAMoUrC03V0ud1ue7aQbGmzQuzdJLcR6+lS/hbmTDohTt2vy/2ahE1PpZZaiQUzfU
xJP3kUQwScJ4IXEQSHLyup/WHRdSpjDlT0CJEcRfWIttt3U8JaiPqOH0cXB/SuPDIlaNiVt+5Ztc
T7eLdWGzDjvtxmAzSyjRJz2s9eUC7TeFswnvDFo+bnbTbeUisethQuvPwcc/hnWmDxO5+oR1EFPN
2s5mfO5Zbj7BK4Qu2somV7K7AWhplNuQMY4cog==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 5216)
`pragma protect data_block
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
AAgXdGmj7cwa1cF24vP3913grp5UXJA6r0xRM7g=
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
