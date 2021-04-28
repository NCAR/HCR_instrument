// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.1 (win64) Build 1215546 Mon Apr 27 19:22:08 MDT 2015
// Date        : Sat May 16 16:24:23 2015
// Host        : Igor running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim
//               E:/px_ip/px_axis_pwr_meter/px_axis_pwr_meter.srcs/sources_1/ip/px_pwr_meter_dsp48_isqr/px_pwr_meter_dsp48_isqr_funcsim.v
// Design      : px_pwr_meter_dsp48_isqr
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_pwr_meter_dsp48_isqr,xbip_dsp48_macro_v3_0,{}" *) (* core_generation_info = "px_pwr_meter_dsp48_isqr,xbip_dsp48_macro_v3_0,{x_ipProduct=Vivado 2015.1,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=xbip_dsp48_macro,x_ipVersion=3.0,x_ipCoreRevision=8,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED,C_VERBOSITY=0,C_MODEL_TYPE=0,C_XDEVICEFAMILY=kintexu,C_HAS_CE=0,C_HAS_INDEP_CE=0,C_HAS_CED=0,C_HAS_CEA=0,C_HAS_CEB=0,C_HAS_CEC=0,C_HAS_CECONCAT=0,C_HAS_CEM=0,C_HAS_CEP=0,C_HAS_CESEL=0,C_HAS_SCLR=0,C_HAS_INDEP_SCLR=0,C_HAS_SCLRD=0,C_HAS_SCLRA=0,C_HAS_SCLRB=0,C_HAS_SCLRC=0,C_HAS_SCLRM=0,C_HAS_SCLRP=0,C_HAS_SCLRCONCAT=0,C_HAS_SCLRSEL=0,C_HAS_CARRYCASCIN=0,C_HAS_CARRYIN=0,C_HAS_ACIN=0,C_HAS_BCIN=0,C_HAS_PCIN=0,C_HAS_A=1,C_HAS_B=1,C_HAS_D=0,C_HAS_CONCAT=0,C_HAS_C=0,C_A_WIDTH=16,C_B_WIDTH=16,C_C_WIDTH=48,C_D_WIDTH=18,C_CONCAT_WIDTH=48,C_P_MSB=31,C_P_LSB=0,C_SEL_WIDTH=0,C_HAS_ACOUT=0,C_HAS_BCOUT=0,C_HAS_CARRYCASCOUT=0,C_HAS_CARRYOUT=0,C_HAS_PCOUT=1,C_CONSTANT_1=1,C_LATENCY=-1,C_OPMODES=000100100000010100000000,C_REG_CONFIG=00000000000011000011000001000100,C_TEST_CORE=0}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* x_core_info = "xbip_dsp48_macro_v3_0,Vivado 2015.1" *) 
(* NotValidForBitStream *)
module px_pwr_meter_dsp48_isqr
   (CLK,
    A,
    B,
    PCOUT,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) input [15:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcout_intf DATA" *) output [47:0]PCOUT;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) output [31:0]P;

  wire [15:0]A;
  wire [15:0]B;
  wire CLK;
  wire [31:0]P;
  wire [47:0]PCOUT;
  wire NLW_U0_CARRYCASCOUT_UNCONNECTED;
  wire NLW_U0_CARRYOUT_UNCONNECTED;
  wire [29:0]NLW_U0_ACOUT_UNCONNECTED;
  wire [17:0]NLW_U0_BCOUT_UNCONNECTED;

  (* C_A_WIDTH = "16" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_D_WIDTH = "18" *) 
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
  (* C_HAS_D = "0" *) 
  (* C_HAS_INDEP_CE = "0" *) 
  (* C_HAS_INDEP_SCLR = "0" *) 
  (* C_HAS_PCIN = "0" *) 
  (* C_HAS_PCOUT = "1" *) 
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
  (* C_OPMODES = "000100100000010100000000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "31" *) 
  (* C_REG_CONFIG = "00000000000011000011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* DONT_TOUCH *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_pwr_meter_dsp48_isqr_xbip_dsp48_macro_v3_0 U0
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
        .D({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .P(P),
        .PCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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

(* C_A_WIDTH = "16" *) (* C_B_WIDTH = "16" *) (* C_CONCAT_WIDTH = "48" *) 
(* C_CONSTANT_1 = "1" *) (* C_C_WIDTH = "48" *) (* C_D_WIDTH = "18" *) 
(* C_HAS_A = "1" *) (* C_HAS_ACIN = "0" *) (* C_HAS_ACOUT = "0" *) 
(* C_HAS_B = "1" *) (* C_HAS_BCIN = "0" *) (* C_HAS_BCOUT = "0" *) 
(* C_HAS_C = "0" *) (* C_HAS_CARRYCASCIN = "0" *) (* C_HAS_CARRYCASCOUT = "0" *) 
(* C_HAS_CARRYIN = "0" *) (* C_HAS_CARRYOUT = "0" *) (* C_HAS_CE = "0" *) 
(* C_HAS_CEA = "0" *) (* C_HAS_CEB = "0" *) (* C_HAS_CEC = "0" *) 
(* C_HAS_CECONCAT = "0" *) (* C_HAS_CED = "0" *) (* C_HAS_CEM = "0" *) 
(* C_HAS_CEP = "0" *) (* C_HAS_CESEL = "0" *) (* C_HAS_CONCAT = "0" *) 
(* C_HAS_D = "0" *) (* C_HAS_INDEP_CE = "0" *) (* C_HAS_INDEP_SCLR = "0" *) 
(* C_HAS_PCIN = "0" *) (* C_HAS_PCOUT = "1" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SCLRA = "0" *) (* C_HAS_SCLRB = "0" *) (* C_HAS_SCLRC = "0" *) 
(* C_HAS_SCLRCONCAT = "0" *) (* C_HAS_SCLRD = "0" *) (* C_HAS_SCLRM = "0" *) 
(* C_HAS_SCLRP = "0" *) (* C_HAS_SCLRSEL = "0" *) (* C_LATENCY = "-1" *) 
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "000100100000010100000000" *) (* C_P_LSB = "0" *) 
(* C_P_MSB = "31" *) (* C_REG_CONFIG = "00000000000011000011000001000100" *) (* C_SEL_WIDTH = "0" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_pwr_meter_dsp48_isqr_xbip_dsp48_macro_v3_0
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
  input [15:0]B;
  input [47:0]C;
  input [17:0]D;
  input [47:0]CONCAT;
  output [29:0]ACOUT;
  output [17:0]BCOUT;
  output CARRYOUT;
  output CARRYCASCOUT;
  output [47:0]PCOUT;
  output [31:0]P;
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
  wire [15:0]B;
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
  wire [17:0]D;
  wire [31:0]P;
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
  (* C_B_WIDTH = "16" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_D_WIDTH = "18" *) 
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
  (* C_HAS_D = "0" *) 
  (* C_HAS_INDEP_CE = "0" *) 
  (* C_HAS_INDEP_SCLR = "0" *) 
  (* C_HAS_PCIN = "0" *) 
  (* C_HAS_PCOUT = "1" *) 
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
  (* C_OPMODES = "000100100000010100000000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "31" *) 
  (* C_REG_CONFIG = "00000000000011000011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_pwr_meter_dsp48_isqr_xbip_dsp48_macro_v3_0_viv i_synth
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
nac0rDOwb0RJ6/uuAFdmMsEm45nwf1yjlfQhMh5W6ssjAVOVbeQDI+oqBMag3jtFs3KpakSLO8Jh
1b1IKwWPUP8El+fB418h8Knfe3yQsrL5GXqnKyEllInRYCdcTAjkz69WUZjkObuiGylhyk8RWAzI
/qFCq0eWLeYIx+SEmbLdYB2UMng/DwsHGhV9en4f5YeLsKA495M6OFMqAgPSwKwj5ZpfmSZ5yVnw
sC9O6/Lv0/Vcrmw3wOfgKVX6okCO9moLwIwLywaxyvdSFpVZwCiF3bRRsQ478trXpErP/FlkxaIF
9lLNc0glXzffRx3biczluNpW+UFvUgxgPxh16Q==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
JYcE2cEFn4Q8xU0vAOljAu31C6Ci4x3KzsleMiJ9IfM2SPrvi9ZUzpR1vKZE54nmv4K4UPP8R8d1
nGj9WbvuDoITNRFhJ+ubBmMNCQLpRvCd21/XXM+zkNu/DB1XhSgrKuHwTebp2RFwSQ5/E30cXXrX
4tyhGgAAWMPxv9LHu8cB3UE+EgLf5arseQzhLZAjxrKfGgiWAh1pN8VGqh8kgL46G7QlA6aMwKHw
XlPi1mYTh3j5ASzJVCEfwlN7IBKJEqlcSJ7amsRvBdF6jHwZnHLvqZkw/o81o8qynYAvVZ+hK/q+
mbCzYOx6xPEpLedtbHXexR1/HA69glCKjvBr8g==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 6752)
`pragma protect data_block
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
Mb3Xh/iwx+Y3UHdV1aD2gDl4HajhZBinzoM=
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
nac0rDOwb0RJ6/uuAFdmMsEm45nwf1yjlfQhMh5W6ssjAVOVbeQDI+oqBMag3jtFs3KpakSLO8Jh
1b1IKwWPUP8El+fB418h8Knfe3yQsrL5GXqnKyEllInRYCdcTAjkz69WUZjkObuiGylhyk8RWAzI
/qFCq0eWLeYIx+SEmbLdYB2UMng/DwsHGhV9en4f5YeLsKA495M6OFMqAgPSwKwj5ZpfmSZ5yVnw
sC9O6/Lv0/Vcrmw3wOfgKVX6okCO9moLwIwLywaxyvdSFpVZwCiF3bRRsQ478trXpErP/FlkxaIF
9lLNc0glXzffRx3biczluNpW+UFvUgxgPxh16Q==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
JYcE2cEFn4Q8xU0vAOljAu31C6Ci4x3KzsleMiJ9IfM2SPrvi9ZUzpR1vKZE54nmv4K4UPP8R8d1
nGj9WbvuDoITNRFhJ+ubBmMNCQLpRvCd21/XXM+zkNu/DB1XhSgrKuHwTebp2RFwSQ5/E30cXXrX
4tyhGgAAWMPxv9LHu8cB3UE+EgLf5arseQzhLZAjxrKfGgiWAh1pN8VGqh8kgL46G7QlA6aMwKHw
XlPi1mYTh3j5ASzJVCEfwlN7IBKJEqlcSJ7amsRvBdF6jHwZnHLvqZkw/o81o8qynYAvVZ+hK/q+
mbCzYOx6xPEpLedtbHXexR1/HA69glCKjvBr8g==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 5344)
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
nac0rDOwb0RJ6/uuAFdmMsEm45nwf1yjlfQhMh5W6ssjAVOVbeQDI+oqBMag3jtFs3KpakSLO8Jh
1b1IKwWPUP8El+fB418h8Knfe3yQsrL5GXqnKyEllInRYCdcTAjkz69WUZjkObuiGylhyk8RWAzI
/qFCq0eWLeYIx+SEmbLdYB2UMng/DwsHGhV9en4f5YeLsKA495M6OFMqAgPSwKwj5ZpfmSZ5yVnw
sC9O6/Lv0/Vcrmw3wOfgKVX6okCO9moLwIwLywaxyvdSFpVZwCiF3bRRsQ478trXpErP/FlkxaIF
9lLNc0glXzffRx3biczluNpW+UFvUgxgPxh16Q==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
JYcE2cEFn4Q8xU0vAOljAu31C6Ci4x3KzsleMiJ9IfM2SPrvi9ZUzpR1vKZE54nmv4K4UPP8R8d1
nGj9WbvuDoITNRFhJ+ubBmMNCQLpRvCd21/XXM+zkNu/DB1XhSgrKuHwTebp2RFwSQ5/E30cXXrX
4tyhGgAAWMPxv9LHu8cB3UE+EgLf5arseQzhLZAjxrKfGgiWAh1pN8VGqh8kgL46G7QlA6aMwKHw
XlPi1mYTh3j5ASzJVCEfwlN7IBKJEqlcSJ7amsRvBdF6jHwZnHLvqZkw/o81o8qynYAvVZ+hK/q+
mbCzYOx6xPEpLedtbHXexR1/HA69glCKjvBr8g==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 19584)
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
