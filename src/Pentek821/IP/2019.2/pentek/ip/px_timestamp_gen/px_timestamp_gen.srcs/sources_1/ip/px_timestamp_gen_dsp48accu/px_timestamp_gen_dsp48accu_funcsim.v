// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.1 (win64) Build 1215546 Mon Apr 27 19:22:08 MDT 2015
// Date        : Sat May 02 00:04:23 2015
// Host        : Igor running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim
//               E:/px_ip/px_timestamp_gen/px_timestamp_gen.srcs/sources_1/ip/px_timestamp_gen_dsp48accu/px_timestamp_gen_dsp48accu_funcsim.v
// Design      : px_timestamp_gen_dsp48accu
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e-es2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_timestamp_gen_dsp48accu,xbip_dsp48_macro_v3_0,{}" *) (* core_generation_info = "px_timestamp_gen_dsp48accu,xbip_dsp48_macro_v3_0,{x_ipProduct=Vivado 2015.1,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=xbip_dsp48_macro,x_ipVersion=3.0,x_ipCoreRevision=8,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED,C_VERBOSITY=0,C_MODEL_TYPE=0,C_XDEVICEFAMILY=kintexu,C_HAS_CE=1,C_HAS_INDEP_CE=2,C_HAS_CED=0,C_HAS_CEA=0,C_HAS_CEB=0,C_HAS_CEC=0,C_HAS_CECONCAT=0,C_HAS_CEM=0,C_HAS_CEP=1,C_HAS_CESEL=0,C_HAS_SCLR=1,C_HAS_INDEP_SCLR=1,C_HAS_SCLRD=0,C_HAS_SCLRA=0,C_HAS_SCLRB=0,C_HAS_SCLRC=0,C_HAS_SCLRM=0,C_HAS_SCLRP=1,C_HAS_SCLRCONCAT=0,C_HAS_SCLRSEL=0,C_HAS_CARRYCASCIN=1,C_HAS_CARRYIN=0,C_HAS_ACIN=0,C_HAS_BCIN=0,C_HAS_PCIN=0,C_HAS_A=0,C_HAS_B=0,C_HAS_D=0,C_HAS_CONCAT=0,C_HAS_C=1,C_A_WIDTH=18,C_B_WIDTH=18,C_C_WIDTH=16,C_D_WIDTH=18,C_CONCAT_WIDTH=48,C_P_MSB=47,C_P_LSB=32,C_SEL_WIDTH=1,C_HAS_ACOUT=0,C_HAS_BCOUT=0,C_HAS_CARRYCASCOUT=0,C_HAS_CARRYOUT=0,C_HAS_PCOUT=0,C_CONSTANT_1=1,C_LATENCY=120,C_OPMODES=010000000010000000000000_010001100011000000000000,C_REG_CONFIG=00000000000000000000100110100100,C_TEST_CORE=0}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* x_core_info = "xbip_dsp48_macro_v3_0,Vivado 2015.1" *) 
(* NotValidForBitStream *)
module px_timestamp_gen_dsp48accu
   (CLK,
    SEL,
    CARRYCASCIN,
    C,
    P,
    CEP,
    SCLRP);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 sel_intf DATA" *) input [0:0]SEL;
  (* x_interface_info = "xilinx.com:signal:data:1.0 carrycascin_intf DATA" *) input CARRYCASCIN;
  (* x_interface_info = "xilinx.com:signal:data:1.0 c_intf DATA" *) input [15:0]C;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) output [15:0]P;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 cep_intf CE" *) input CEP;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclrp_intf RST" *) input SCLRP;

  wire [15:0]C;
  wire CARRYCASCIN;
  wire CEP;
  wire CLK;
  wire [15:0]P;
  wire SCLRP;
  wire [0:0]SEL;
  wire NLW_U0_CARRYCASCOUT_UNCONNECTED;
  wire NLW_U0_CARRYOUT_UNCONNECTED;
  wire [29:0]NLW_U0_ACOUT_UNCONNECTED;
  wire [17:0]NLW_U0_BCOUT_UNCONNECTED;
  wire [47:0]NLW_U0_PCOUT_UNCONNECTED;

  (* C_A_WIDTH = "18" *) 
  (* C_B_WIDTH = "18" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "16" *) 
  (* C_D_WIDTH = "18" *) 
  (* C_HAS_A = "0" *) 
  (* C_HAS_ACIN = "0" *) 
  (* C_HAS_ACOUT = "0" *) 
  (* C_HAS_B = "0" *) 
  (* C_HAS_BCIN = "0" *) 
  (* C_HAS_BCOUT = "0" *) 
  (* C_HAS_C = "1" *) 
  (* C_HAS_CARRYCASCIN = "1" *) 
  (* C_HAS_CARRYCASCOUT = "0" *) 
  (* C_HAS_CARRYIN = "0" *) 
  (* C_HAS_CARRYOUT = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_CEA = "0" *) 
  (* C_HAS_CEB = "0" *) 
  (* C_HAS_CEC = "0" *) 
  (* C_HAS_CECONCAT = "0" *) 
  (* C_HAS_CED = "0" *) 
  (* C_HAS_CEM = "0" *) 
  (* C_HAS_CEP = "1" *) 
  (* C_HAS_CESEL = "0" *) 
  (* C_HAS_CONCAT = "0" *) 
  (* C_HAS_D = "0" *) 
  (* C_HAS_INDEP_CE = "2" *) 
  (* C_HAS_INDEP_SCLR = "1" *) 
  (* C_HAS_PCIN = "0" *) 
  (* C_HAS_PCOUT = "0" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SCLRA = "0" *) 
  (* C_HAS_SCLRB = "0" *) 
  (* C_HAS_SCLRC = "0" *) 
  (* C_HAS_SCLRCONCAT = "0" *) 
  (* C_HAS_SCLRD = "0" *) 
  (* C_HAS_SCLRM = "0" *) 
  (* C_HAS_SCLRP = "1" *) 
  (* C_HAS_SCLRSEL = "0" *) 
  (* C_LATENCY = "120" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "010000000010000000000000,010001100011000000000000" *) 
  (* C_P_LSB = "32" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000000000000100110100100" *) 
  (* C_SEL_WIDTH = "1" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* DONT_TOUCH *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_timestamp_gen_dsp48accu_xbip_dsp48_macro_v3_0 U0
       (.A({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACOUT(NLW_U0_ACOUT_UNCONNECTED[29:0]),
        .B({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCOUT(NLW_U0_BCOUT_UNCONNECTED[17:0]),
        .C(C),
        .CARRYCASCIN(CARRYCASCIN),
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
        .CEP(CEP),
        .CESEL(1'b1),
        .CESEL1(1'b1),
        .CESEL2(1'b1),
        .CESEL3(1'b1),
        .CESEL4(1'b1),
        .CESEL5(1'b1),
        .CLK(CLK),
        .CONCAT({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
        .SCLRP(SCLRP),
        .SCLRSEL(1'b0),
        .SEL(SEL));
endmodule

(* C_A_WIDTH = "18" *) (* C_B_WIDTH = "18" *) (* C_CONCAT_WIDTH = "48" *) 
(* C_CONSTANT_1 = "1" *) (* C_C_WIDTH = "16" *) (* C_D_WIDTH = "18" *) 
(* C_HAS_A = "0" *) (* C_HAS_ACIN = "0" *) (* C_HAS_ACOUT = "0" *) 
(* C_HAS_B = "0" *) (* C_HAS_BCIN = "0" *) (* C_HAS_BCOUT = "0" *) 
(* C_HAS_C = "1" *) (* C_HAS_CARRYCASCIN = "1" *) (* C_HAS_CARRYCASCOUT = "0" *) 
(* C_HAS_CARRYIN = "0" *) (* C_HAS_CARRYOUT = "0" *) (* C_HAS_CE = "1" *) 
(* C_HAS_CEA = "0" *) (* C_HAS_CEB = "0" *) (* C_HAS_CEC = "0" *) 
(* C_HAS_CECONCAT = "0" *) (* C_HAS_CED = "0" *) (* C_HAS_CEM = "0" *) 
(* C_HAS_CEP = "1" *) (* C_HAS_CESEL = "0" *) (* C_HAS_CONCAT = "0" *) 
(* C_HAS_D = "0" *) (* C_HAS_INDEP_CE = "2" *) (* C_HAS_INDEP_SCLR = "1" *) 
(* C_HAS_PCIN = "0" *) (* C_HAS_PCOUT = "0" *) (* C_HAS_SCLR = "1" *) 
(* C_HAS_SCLRA = "0" *) (* C_HAS_SCLRB = "0" *) (* C_HAS_SCLRC = "0" *) 
(* C_HAS_SCLRCONCAT = "0" *) (* C_HAS_SCLRD = "0" *) (* C_HAS_SCLRM = "0" *) 
(* C_HAS_SCLRP = "1" *) (* C_HAS_SCLRSEL = "0" *) (* C_LATENCY = "120" *) 
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "010000000010000000000000,010001100011000000000000" *) (* C_P_LSB = "32" *) 
(* C_P_MSB = "47" *) (* C_REG_CONFIG = "00000000000000000000100110100100" *) (* C_SEL_WIDTH = "1" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_timestamp_gen_dsp48accu_xbip_dsp48_macro_v3_0
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
  input [15:0]C;
  input [17:0]D;
  input [47:0]CONCAT;
  output [29:0]ACOUT;
  output [17:0]BCOUT;
  output CARRYOUT;
  output CARRYCASCOUT;
  output [47:0]PCOUT;
  output [15:0]P;
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
  wire [15:0]C;
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
  wire [17:0]D;
  wire [15:0]P;
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
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "16" *) 
  (* C_D_WIDTH = "18" *) 
  (* C_HAS_A = "0" *) 
  (* C_HAS_ACIN = "0" *) 
  (* C_HAS_ACOUT = "0" *) 
  (* C_HAS_B = "0" *) 
  (* C_HAS_BCIN = "0" *) 
  (* C_HAS_BCOUT = "0" *) 
  (* C_HAS_C = "1" *) 
  (* C_HAS_CARRYCASCIN = "1" *) 
  (* C_HAS_CARRYCASCOUT = "0" *) 
  (* C_HAS_CARRYIN = "0" *) 
  (* C_HAS_CARRYOUT = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_CEA = "0" *) 
  (* C_HAS_CEB = "0" *) 
  (* C_HAS_CEC = "0" *) 
  (* C_HAS_CECONCAT = "0" *) 
  (* C_HAS_CED = "0" *) 
  (* C_HAS_CEM = "0" *) 
  (* C_HAS_CEP = "1" *) 
  (* C_HAS_CESEL = "0" *) 
  (* C_HAS_CONCAT = "0" *) 
  (* C_HAS_D = "0" *) 
  (* C_HAS_INDEP_CE = "2" *) 
  (* C_HAS_INDEP_SCLR = "1" *) 
  (* C_HAS_PCIN = "0" *) 
  (* C_HAS_PCOUT = "0" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SCLRA = "0" *) 
  (* C_HAS_SCLRB = "0" *) 
  (* C_HAS_SCLRC = "0" *) 
  (* C_HAS_SCLRCONCAT = "0" *) 
  (* C_HAS_SCLRD = "0" *) 
  (* C_HAS_SCLRM = "0" *) 
  (* C_HAS_SCLRP = "1" *) 
  (* C_HAS_SCLRSEL = "0" *) 
  (* C_LATENCY = "120" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "010000000010000000000000,010001100011000000000000" *) 
  (* C_P_LSB = "32" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000000000000100110100100" *) 
  (* C_SEL_WIDTH = "1" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_timestamp_gen_dsp48accu_xbip_dsp48_macro_v3_0_viv i_synth
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
dM+sWK/qDENjm/pTs3fxbVlu+3Nksvk5t0Lt4tzprCwvAJzWiGRFf0Yps7Lrbba9co4aHzQ4vvKh
k7u8ZkjZALvDme+aNS3ZMje/B0d1USV6IF7lY0rMdk24WY1dgLKLso4Aa4b0Q/G2ztHLeH51rNck
HocYsbZFSxRvY2bstNZMN0BDzor4Jb1GIJf3gNUAKtKnWFZMrSybgdkHZ3DBxSQcxAsuC57fvs0l
KAiLbKrMC+SvSYRcShdMgKXG6lUCiuoLdlaFG0DsuEE0OH24z7irLruBx9VzY5W0Pf5qFA94j7k/
VVZi2Psf0rZ4LsPZYXWddnp7ZhrT9T5Qk5921g==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
w/41t90qdLMcpG81GkrPxIJ6kw7F57QRkBgd8KQdXbSMMboA1WkmYvfBt8W6w54laKyDPHMieApQ
ffp4zkl+yHpnD8ebgjDLWHvL1nvFnAKZMtxa7O8UMGrSV+7CFgLm9NzqGnw0V2ZMdVeN3EY8y2Cq
m+R8GGdjxsuaINT5/mGyXIwXyk2mPxc4KbDudh+Mb8NDdayheA+d9UwLkX4TpsOI4gBxg/1Izfr4
6KzCZ4RHTTQ/b8RwPFK3OOb13Z0WF5GMTrDPfIJZocAM4PAl+kP7BttAE7/z0mcC621o+GED/0Yd
pdF5eD0cUy3JFtm5s1EFGwLA/z0DvV1tOAak6A==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 6416)
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
dM+sWK/qDENjm/pTs3fxbVlu+3Nksvk5t0Lt4tzprCwvAJzWiGRFf0Yps7Lrbba9co4aHzQ4vvKh
k7u8ZkjZALvDme+aNS3ZMje/B0d1USV6IF7lY0rMdk24WY1dgLKLso4Aa4b0Q/G2ztHLeH51rNck
HocYsbZFSxRvY2bstNZMN0BDzor4Jb1GIJf3gNUAKtKnWFZMrSybgdkHZ3DBxSQcxAsuC57fvs0l
KAiLbKrMC+SvSYRcShdMgKXG6lUCiuoLdlaFG0DsuEE0OH24z7irLruBx9VzY5W0Pf5qFA94j7k/
VVZi2Psf0rZ4LsPZYXWddnp7ZhrT9T5Qk5921g==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
w/41t90qdLMcpG81GkrPxIJ6kw7F57QRkBgd8KQdXbSMMboA1WkmYvfBt8W6w54laKyDPHMieApQ
ffp4zkl+yHpnD8ebgjDLWHvL1nvFnAKZMtxa7O8UMGrSV+7CFgLm9NzqGnw0V2ZMdVeN3EY8y2Cq
m+R8GGdjxsuaINT5/mGyXIwXyk2mPxc4KbDudh+Mb8NDdayheA+d9UwLkX4TpsOI4gBxg/1Izfr4
6KzCZ4RHTTQ/b8RwPFK3OOb13Z0WF5GMTrDPfIJZocAM4PAl+kP7BttAE7/z0mcC621o+GED/0Yd
pdF5eD0cUy3JFtm5s1EFGwLA/z0DvV1tOAak6A==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 6080)
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
dM+sWK/qDENjm/pTs3fxbVlu+3Nksvk5t0Lt4tzprCwvAJzWiGRFf0Yps7Lrbba9co4aHzQ4vvKh
k7u8ZkjZALvDme+aNS3ZMje/B0d1USV6IF7lY0rMdk24WY1dgLKLso4Aa4b0Q/G2ztHLeH51rNck
HocYsbZFSxRvY2bstNZMN0BDzor4Jb1GIJf3gNUAKtKnWFZMrSybgdkHZ3DBxSQcxAsuC57fvs0l
KAiLbKrMC+SvSYRcShdMgKXG6lUCiuoLdlaFG0DsuEE0OH24z7irLruBx9VzY5W0Pf5qFA94j7k/
VVZi2Psf0rZ4LsPZYXWddnp7ZhrT9T5Qk5921g==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
w/41t90qdLMcpG81GkrPxIJ6kw7F57QRkBgd8KQdXbSMMboA1WkmYvfBt8W6w54laKyDPHMieApQ
ffp4zkl+yHpnD8ebgjDLWHvL1nvFnAKZMtxa7O8UMGrSV+7CFgLm9NzqGnw0V2ZMdVeN3EY8y2Cq
m+R8GGdjxsuaINT5/mGyXIwXyk2mPxc4KbDudh+Mb8NDdayheA+d9UwLkX4TpsOI4gBxg/1Izfr4
6KzCZ4RHTTQ/b8RwPFK3OOb13Z0WF5GMTrDPfIJZocAM4PAl+kP7BttAE7/z0mcC621o+GED/0Yd
pdF5eD0cUy3JFtm5s1EFGwLA/z0DvV1tOAak6A==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 14304)
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
