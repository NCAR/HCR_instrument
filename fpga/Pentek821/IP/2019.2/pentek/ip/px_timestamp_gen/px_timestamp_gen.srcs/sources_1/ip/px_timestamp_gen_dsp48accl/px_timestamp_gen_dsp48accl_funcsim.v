// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.1 (win64) Build 1215546 Mon Apr 27 19:22:08 MDT 2015
// Date        : Sat May 02 00:04:23 2015
// Host        : Igor running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim
//               E:/px_ip/px_timestamp_gen/px_timestamp_gen.srcs/sources_1/ip/px_timestamp_gen_dsp48accl/px_timestamp_gen_dsp48accl_funcsim.v
// Design      : px_timestamp_gen_dsp48accl
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e-es2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_timestamp_gen_dsp48accl,xbip_dsp48_macro_v3_0,{}" *) (* core_generation_info = "px_timestamp_gen_dsp48accl,xbip_dsp48_macro_v3_0,{x_ipProduct=Vivado 2015.1,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=xbip_dsp48_macro,x_ipVersion=3.0,x_ipCoreRevision=8,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED,C_VERBOSITY=0,C_MODEL_TYPE=0,C_XDEVICEFAMILY=kintexu,C_HAS_CE=1,C_HAS_INDEP_CE=2,C_HAS_CED=0,C_HAS_CEA=0,C_HAS_CEB=0,C_HAS_CEC=0,C_HAS_CECONCAT=0,C_HAS_CEM=0,C_HAS_CEP=1,C_HAS_CESEL=0,C_HAS_SCLR=1,C_HAS_INDEP_SCLR=1,C_HAS_SCLRD=0,C_HAS_SCLRA=0,C_HAS_SCLRB=0,C_HAS_SCLRC=0,C_HAS_SCLRM=0,C_HAS_SCLRP=1,C_HAS_SCLRCONCAT=0,C_HAS_SCLRSEL=0,C_HAS_CARRYCASCIN=0,C_HAS_CARRYIN=0,C_HAS_ACIN=0,C_HAS_BCIN=0,C_HAS_PCIN=0,C_HAS_A=1,C_HAS_B=0,C_HAS_D=1,C_HAS_CONCAT=0,C_HAS_C=1,C_A_WIDTH=4,C_B_WIDTH=18,C_C_WIDTH=48,C_D_WIDTH=16,C_CONCAT_WIDTH=48,C_P_MSB=47,C_P_LSB=0,C_SEL_WIDTH=2,C_HAS_ACOUT=0,C_HAS_BCOUT=0,C_HAS_CARRYCASCOUT=1,C_HAS_CARRYOUT=0,C_HAS_PCOUT=0,C_CONSTANT_1=1,C_LATENCY=112,C_OPMODES=000100101000010100011101_000001100011010100000001_000001100000010100000001,C_REG_CONFIG=00000000000000000000000011100100,C_TEST_CORE=0}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* x_core_info = "xbip_dsp48_macro_v3_0,Vivado 2015.1" *) 
(* NotValidForBitStream *)
module px_timestamp_gen_dsp48accl
   (CLK,
    SEL,
    A,
    C,
    D,
    CARRYCASCOUT,
    P,
    CEP,
    SCLRP);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 sel_intf DATA" *) input [1:0]SEL;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) input [3:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 c_intf DATA" *) input [47:0]C;
  (* x_interface_info = "xilinx.com:signal:data:1.0 d_intf DATA" *) input [15:0]D;
  (* x_interface_info = "xilinx.com:signal:data:1.0 carrycascout_intf DATA" *) output CARRYCASCOUT;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) output [47:0]P;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 cep_intf CE" *) input CEP;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclrp_intf RST" *) input SCLRP;

  wire [3:0]A;
  wire [47:0]C;
  wire CARRYCASCOUT;
  wire CEP;
  wire CLK;
  wire [15:0]D;
  wire [47:0]P;
  wire SCLRP;
  wire [1:0]SEL;
  wire NLW_U0_CARRYOUT_UNCONNECTED;
  wire [29:0]NLW_U0_ACOUT_UNCONNECTED;
  wire [17:0]NLW_U0_BCOUT_UNCONNECTED;
  wire [47:0]NLW_U0_PCOUT_UNCONNECTED;

  (* C_A_WIDTH = "4" *) 
  (* C_B_WIDTH = "18" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_D_WIDTH = "16" *) 
  (* C_HAS_A = "1" *) 
  (* C_HAS_ACIN = "0" *) 
  (* C_HAS_ACOUT = "0" *) 
  (* C_HAS_B = "0" *) 
  (* C_HAS_BCIN = "0" *) 
  (* C_HAS_BCOUT = "0" *) 
  (* C_HAS_C = "1" *) 
  (* C_HAS_CARRYCASCIN = "0" *) 
  (* C_HAS_CARRYCASCOUT = "1" *) 
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
  (* C_HAS_D = "1" *) 
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
  (* C_LATENCY = "112" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "000100101000010100011101,000001100011010100000001,000001100000010100000001" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000000000000000011100100" *) 
  (* C_SEL_WIDTH = "2" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* DONT_TOUCH *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_timestamp_gen_dsp48accl_xbip_dsp48_macro_v3_0 U0
       (.A(A),
        .ACIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACOUT(NLW_U0_ACOUT_UNCONNECTED[29:0]),
        .B({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCOUT(NLW_U0_BCOUT_UNCONNECTED[17:0]),
        .C(C),
        .CARRYCASCIN(1'b0),
        .CARRYCASCOUT(CARRYCASCOUT),
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
        .SCLRP(SCLRP),
        .SCLRSEL(1'b0),
        .SEL(SEL));
endmodule

(* C_A_WIDTH = "4" *) (* C_B_WIDTH = "18" *) (* C_CONCAT_WIDTH = "48" *) 
(* C_CONSTANT_1 = "1" *) (* C_C_WIDTH = "48" *) (* C_D_WIDTH = "16" *) 
(* C_HAS_A = "1" *) (* C_HAS_ACIN = "0" *) (* C_HAS_ACOUT = "0" *) 
(* C_HAS_B = "0" *) (* C_HAS_BCIN = "0" *) (* C_HAS_BCOUT = "0" *) 
(* C_HAS_C = "1" *) (* C_HAS_CARRYCASCIN = "0" *) (* C_HAS_CARRYCASCOUT = "1" *) 
(* C_HAS_CARRYIN = "0" *) (* C_HAS_CARRYOUT = "0" *) (* C_HAS_CE = "1" *) 
(* C_HAS_CEA = "0" *) (* C_HAS_CEB = "0" *) (* C_HAS_CEC = "0" *) 
(* C_HAS_CECONCAT = "0" *) (* C_HAS_CED = "0" *) (* C_HAS_CEM = "0" *) 
(* C_HAS_CEP = "1" *) (* C_HAS_CESEL = "0" *) (* C_HAS_CONCAT = "0" *) 
(* C_HAS_D = "1" *) (* C_HAS_INDEP_CE = "2" *) (* C_HAS_INDEP_SCLR = "1" *) 
(* C_HAS_PCIN = "0" *) (* C_HAS_PCOUT = "0" *) (* C_HAS_SCLR = "1" *) 
(* C_HAS_SCLRA = "0" *) (* C_HAS_SCLRB = "0" *) (* C_HAS_SCLRC = "0" *) 
(* C_HAS_SCLRCONCAT = "0" *) (* C_HAS_SCLRD = "0" *) (* C_HAS_SCLRM = "0" *) 
(* C_HAS_SCLRP = "1" *) (* C_HAS_SCLRSEL = "0" *) (* C_LATENCY = "112" *) 
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "000100101000010100011101,000001100011010100000001,000001100000010100000001" *) (* C_P_LSB = "0" *) 
(* C_P_MSB = "47" *) (* C_REG_CONFIG = "00000000000000000000000011100100" *) (* C_SEL_WIDTH = "2" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_timestamp_gen_dsp48accl_xbip_dsp48_macro_v3_0
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
  input [1:0]SEL;
  input CARRYCASCIN;
  input CARRYIN;
  input [47:0]PCIN;
  input [29:0]ACIN;
  input [17:0]BCIN;
  input [3:0]A;
  input [17:0]B;
  input [47:0]C;
  input [15:0]D;
  input [47:0]CONCAT;
  output [29:0]ACOUT;
  output [17:0]BCOUT;
  output CARRYOUT;
  output CARRYCASCOUT;
  output [47:0]PCOUT;
  output [47:0]P;
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

  wire [3:0]A;
  wire [29:0]ACIN;
  wire [29:0]ACOUT;
  wire [17:0]B;
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
  wire [47:0]P;
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
  wire [1:0]SEL;

  (* C_A_WIDTH = "4" *) 
  (* C_B_WIDTH = "18" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_D_WIDTH = "16" *) 
  (* C_HAS_A = "1" *) 
  (* C_HAS_ACIN = "0" *) 
  (* C_HAS_ACOUT = "0" *) 
  (* C_HAS_B = "0" *) 
  (* C_HAS_BCIN = "0" *) 
  (* C_HAS_BCOUT = "0" *) 
  (* C_HAS_C = "1" *) 
  (* C_HAS_CARRYCASCIN = "0" *) 
  (* C_HAS_CARRYCASCOUT = "1" *) 
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
  (* C_HAS_D = "1" *) 
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
  (* C_LATENCY = "112" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "000100101000010100011101,000001100011010100000001,000001100000010100000001" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000000000000000011100100" *) 
  (* C_SEL_WIDTH = "2" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_timestamp_gen_dsp48accl_xbip_dsp48_macro_v3_0_viv i_synth
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
qyuv1Z7BAKHal0t0zdJeG4LFaRVGuGxRAS/BU6qwx+M02jepGu6yqeD4q3tYB2EW0fCXlo6zNz14
ldJgByzU//mD12A2hdffA/dVtUdXG9npe0MN2gRA2ItNBNqCMAPDjTPJSazTYmPHeN1plYGee8UG
aYrHHTsGhUeHYuPZpNEssMYtq+++spqFq3I8h7hxTZYcn4WTvvY6lDgNA5Ey1uFL/Wtc1jFDh49i
42jZ1XA3xmSAyLPFJiK2CUn936EJ6rUO4bqlfzDH3Zim+8G52JChZJnPXs9N2zegM06jajEXuFqD
PDFUdUXXt6Ek6F//JmeohIlhGHy2vjRwpQBgTw==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
fNhC/sRfGpdU9dHL3YKpFBuHiJwbiHUMBouwe3cwC3xYg8VFhDlyHHomy7ucNkTqf7z6izEBxXRY
kzWNCO9gPxMb4t+woab0ZlH8VkOB0hpeIXkSUI/RVltVKh8GiZXhlM3pK/sYrdoDiB5aSdWinHlR
6G1cbbL0ztnAPUloEdneSu7blioyj+u7pEkf2i7LgT5DQcpfcK08+3McbRWAUfYc1+4/OaXNl/nc
K8XtjZk7ljGqp5qFnM+riDBgPogddNVBJ0fSZ23JaZ8FOP9LQV8AAAbO5QaK15+AKR9jAi4brYOK
F90KWFGOXlcJpRUzx4mX/0yXIW7/zkdxyZmmTg==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 5952)
`pragma protect data_block
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
qhOtBhcgQxRN9B8iZjS7556bzsVyMZy9
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
qyuv1Z7BAKHal0t0zdJeG4LFaRVGuGxRAS/BU6qwx+M02jepGu6yqeD4q3tYB2EW0fCXlo6zNz14
ldJgByzU//mD12A2hdffA/dVtUdXG9npe0MN2gRA2ItNBNqCMAPDjTPJSazTYmPHeN1plYGee8UG
aYrHHTsGhUeHYuPZpNEssMYtq+++spqFq3I8h7hxTZYcn4WTvvY6lDgNA5Ey1uFL/Wtc1jFDh49i
42jZ1XA3xmSAyLPFJiK2CUn936EJ6rUO4bqlfzDH3Zim+8G52JChZJnPXs9N2zegM06jajEXuFqD
PDFUdUXXt6Ek6F//JmeohIlhGHy2vjRwpQBgTw==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
fNhC/sRfGpdU9dHL3YKpFBuHiJwbiHUMBouwe3cwC3xYg8VFhDlyHHomy7ucNkTqf7z6izEBxXRY
kzWNCO9gPxMb4t+woab0ZlH8VkOB0hpeIXkSUI/RVltVKh8GiZXhlM3pK/sYrdoDiB5aSdWinHlR
6G1cbbL0ztnAPUloEdneSu7blioyj+u7pEkf2i7LgT5DQcpfcK08+3McbRWAUfYc1+4/OaXNl/nc
K8XtjZk7ljGqp5qFnM+riDBgPogddNVBJ0fSZ23JaZ8FOP9LQV8AAAbO5QaK15+AKR9jAi4brYOK
F90KWFGOXlcJpRUzx4mX/0yXIW7/zkdxyZmmTg==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 5456)
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
