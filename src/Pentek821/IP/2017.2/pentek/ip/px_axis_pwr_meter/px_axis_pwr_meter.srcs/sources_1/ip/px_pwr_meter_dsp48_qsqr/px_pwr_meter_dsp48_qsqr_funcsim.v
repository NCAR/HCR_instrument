// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.1 (win64) Build 1215546 Mon Apr 27 19:22:08 MDT 2015
// Date        : Sat May 16 17:07:50 2015
// Host        : Igor running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim
//               e:/px_ip/px_axis_pwr_meter/px_axis_pwr_meter.srcs/sources_1/ip/px_pwr_meter_dsp48_qsqr/px_pwr_meter_dsp48_qsqr_funcsim.v
// Design      : px_pwr_meter_dsp48_qsqr
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_pwr_meter_dsp48_qsqr,xbip_dsp48_macro_v3_0,{}" *) (* core_generation_info = "px_pwr_meter_dsp48_qsqr,xbip_dsp48_macro_v3_0,{x_ipProduct=Vivado 2015.1,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=xbip_dsp48_macro,x_ipVersion=3.0,x_ipCoreRevision=8,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED,C_VERBOSITY=0,C_MODEL_TYPE=0,C_XDEVICEFAMILY=kintexu,C_HAS_CE=0,C_HAS_INDEP_CE=0,C_HAS_CED=0,C_HAS_CEA=0,C_HAS_CEB=0,C_HAS_CEC=0,C_HAS_CECONCAT=0,C_HAS_CEM=0,C_HAS_CEP=0,C_HAS_CESEL=0,C_HAS_SCLR=0,C_HAS_INDEP_SCLR=0,C_HAS_SCLRD=0,C_HAS_SCLRA=0,C_HAS_SCLRB=0,C_HAS_SCLRC=0,C_HAS_SCLRM=0,C_HAS_SCLRP=0,C_HAS_SCLRCONCAT=0,C_HAS_SCLRSEL=0,C_HAS_CARRYCASCIN=0,C_HAS_CARRYIN=0,C_HAS_ACIN=0,C_HAS_BCIN=0,C_HAS_PCIN=1,C_HAS_A=1,C_HAS_B=1,C_HAS_D=0,C_HAS_CONCAT=0,C_HAS_C=0,C_A_WIDTH=16,C_B_WIDTH=16,C_C_WIDTH=48,C_D_WIDTH=18,C_CONCAT_WIDTH=48,C_P_MSB=47,C_P_LSB=0,C_SEL_WIDTH=0,C_HAS_ACOUT=0,C_HAS_BCOUT=0,C_HAS_CARRYCASCOUT=0,C_HAS_CARRYOUT=0,C_HAS_PCOUT=0,C_CONSTANT_1=1,C_LATENCY=-1,C_OPMODES=000000000001010100000000,C_REG_CONFIG=00000000000011000011000001000100,C_TEST_CORE=0}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* x_core_info = "xbip_dsp48_macro_v3_0,Vivado 2015.1" *) 
(* NotValidForBitStream *)
module px_pwr_meter_dsp48_qsqr
   (CLK,
    PCIN,
    A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcin_intf DATA" *) input [47:0]PCIN;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) input [15:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) output [47:0]P;

  wire [15:0]A;
  wire [15:0]B;
  wire CLK;
  wire [47:0]P;
  wire [47:0]PCIN;
  wire NLW_U0_CARRYCASCOUT_UNCONNECTED;
  wire NLW_U0_CARRYOUT_UNCONNECTED;
  wire [29:0]NLW_U0_ACOUT_UNCONNECTED;
  wire [17:0]NLW_U0_BCOUT_UNCONNECTED;
  wire [47:0]NLW_U0_PCOUT_UNCONNECTED;

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
  (* C_HAS_PCIN = "1" *) 
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
  (* C_OPMODES = "000000000001010100000000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000011000011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* DONT_TOUCH *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_pwr_meter_dsp48_qsqr_xbip_dsp48_macro_v3_0 U0
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
        .PCIN(PCIN),
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
(* C_HAS_PCIN = "1" *) (* C_HAS_PCOUT = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SCLRA = "0" *) (* C_HAS_SCLRB = "0" *) (* C_HAS_SCLRC = "0" *) 
(* C_HAS_SCLRCONCAT = "0" *) (* C_HAS_SCLRD = "0" *) (* C_HAS_SCLRM = "0" *) 
(* C_HAS_SCLRP = "0" *) (* C_HAS_SCLRSEL = "0" *) (* C_LATENCY = "-1" *) 
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "000000000001010100000000" *) (* C_P_LSB = "0" *) 
(* C_P_MSB = "47" *) (* C_REG_CONFIG = "00000000000011000011000001000100" *) (* C_SEL_WIDTH = "0" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_pwr_meter_dsp48_qsqr_xbip_dsp48_macro_v3_0
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
  (* C_HAS_PCIN = "1" *) 
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
  (* C_OPMODES = "000000000001010100000000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000011000011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_pwr_meter_dsp48_qsqr_xbip_dsp48_macro_v3_0_viv i_synth
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
S+zbaN7YT6utXBR/KxZuoy6PFGYTVSd5paQ2Bu3jD7/XyDv5vMxzEPHg9M5JLnbESbncON70juM+
4C/U6YneGg7PbRWiiVUFE1tKVpH5rRUy6oSssNeYe//dBkQSBkhu0L9LIdpR6iAf4KtPXFqZvAPU
Q9GtFh2ldxbjOPt98M/rtMW5q7v3niJ+A4hyXh7arj0DYPz2MrIC9QJka4roL1OXT5KKc5lF7IwG
4LAuWWQ0AEi7VvUrsyIWodrfDojwKD00bGXaEjViAEDMmD3nCzL9IInu4K3rRGPLpU/dCo7AAxFa
M5BiNyil+oiP/l3Z38IuO+SDvwmJe/TtpOGShw==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
lA11vU8EuFsFIvntHXjRFyV/dKL6hqsuPbiW8GbhbgD1QJTecoUtnNuQpIK/4HQ+mvBQuui75cfz
ZskU6ELgPgauQz9tQWSDirGVLhYgq5Tb4dW92FFiqVpGiKRT+zzMisdPL4a3m+dxcpTFloygLsly
AYwnAZFF9/chyvcgBMgioKVO2ixSOvVsCj5cwApHxGfJzoPqJo3Tc3g9ct0qQS9nSwgca7rwHFsg
xBXSh3mUH+A97y1EnRcQOaD4zINGzXIL2rRb+2rJUOwJ98Bx3wd3PILIFaGIinMOZ6+NPqOUC5K+
p4rCmDT4rpX9nkKfYKxgzrPoo0hezKBBW5+4MQ==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 6752)
`pragma protect data_block
VBT/sIY4ZbvFmO7HPdqJlRM1cNde7bq0NK6FXLa38qHFTuc9Q6Nw78SxXN8ZkiN63H3sLq10SgrH
BoB4sTomT2WypdfeFBIqnTvyFilFIf3fAlzf96W01CjaMeo2/sXmO6GnE7R1NIDQeB7xHcXTXCXh
+M/uEuJMMfuZMu7ZROFCj7tTlbnRqzzFX1T6FnciG3YLsgUA8PmTVpEnsX+5YlDJO2y5tGVtVPOV
TpRQr11J3oProaOhChLwDRgdYQzAA/cv6iAg+e7txqsjZHEWtWc601aY82pI3XjaLgQzO3y4IxCO
AoNlSBAyLKLeO1mZyMj36l91lqBe/Mi8RtLJbpLxwTHubRFbabQPrJi1s9680YiJu/irm3HGQGFz
/x9oWjAOhNanmSnA/EZTHmHPOEARnFhiR/gehh6X36u+1wKZXe31C0ObAnqJvFFZ4/E7/v5EyXZl
ShzpCbBvS/mVYqR4ryEHEwOW+EKZqg78kCeGGF3JdYGA/JIDLdjBdHQnSR2E8sK8LI18XZc3kQET
KpKcKl7AaFoS1rmUZqxaBibG3XpiGNIIfDhUH3ajN3tNk+iHvUbLABnjmj0/l6jAMfNq9gJNf7x6
Txssb9OEwcdkk/N72YrOnmXzXuNO+IVXvfCTVh1HtQzs69KtCMw8a0/rphPUeSHFopKq4YQQ6e2V
+yuhvz7mheR7AqAUwI0VJ7akQzZmWPR6YqN2XASIZ+zml6HvrMSamJTxd7TRkvB8JX33XDmSimRF
LvRDSRh9GuPiwpDSfbSfdBnAaSvIuJnS0fIHMCFK5YwtVKEpGPqbf9gBMskegyII4pHG4kHe2ZIG
YhA7eAw5Zdy/lEUYSly4SwTv0qMx7+eFZXCY5q2EcuW3juyEQZSdSyvYo8yl1cL14WSzaWmLTzUt
/N1xyep587goDhxpZ8owInxuYIfKLw0BHRK+zk2fn+wcrnDlWvanlktREv9p/pnGCNoDrVgTqznK
S8GSzKMfnv2zGHqtlxMaJgFTIv6csEpRkxKwD8XrFAV51Xb0XSiIQ+u1oAdaPEdJSPHwaSCIg+0T
2YcM+LzJ0Onm/GXhwBlzWoxHHoAzW9YQnOb8bP4888Sn8+1djfSbVa9lUe0v8UjXSsj9+RBW31U0
8nWjFLmJ7gL4UTx4VB9aOeXRVOXsUqK0gag6CVn0w5PlaLEn2V/ZmXikaqqgQKU224IgzteHrxgA
J+Uecm+4lmx2bZKxgbgpXyPVu59JoChoQU1qTl2iziWsj7ZpcQdThVThaN4iyynlYbQAqt2fVd2N
sp6zX565dnJ+IkTC43WadCzb18yT+cb515LtBVVGcF8AhHOAb0V5/31a+jLkd6YpkKC4sntWmAoq
SkGGohJ485J5+hvtfSKugtlC1fam9hZRLDom+Z74wxNLbAKt5uVZ6IWB0A1aqjkiZ679GVOyzZKd
ffWF9P3XLS2pUjQvv/PfVskzae7s/2pzl6j9S2zDuGqDWBaQEN0ZZjBWfvFm4Fp5M+CcpAxQqYGX
XGziHt1ipmTtckQlwmYBQ5typ52lbdGs17v7f3yUzu5HbNTV1XDGvw7LjLsikeHuIcoH1n3/di0/
FFkiCvs9H5IKLBKheKhIWevc5+iBCScD4MlMqykFx53Iv0POz+4ebSSQUM1iMN4WrLXlQJiQZ6Fw
SMGDrKcU922yPbSyUtoekRFskbzevJVMyq21eyIHrVqsmdJrwoYFXoIET5XG0HvHIR5/ta1CwbOy
N1e8KvlSCYOKugAqPwOZA5Xo+wF74Kz/j14I/uelzjpzKUsBPAIhew8jtJG5/W1iZbLjqeeN5Fs8
uQ+cRVQh7Jj5bFdNVSyOelEy3mEl3OQBwTnOzAmy7Su5vNXIFfNwUzuaYgFq2VcPS/Q+7ig6JVLT
7NXfKDZ2pHhrrCi//GBKnh/VwkeAJQ6Z6vXmUFQsLD5sMw58GffPd0Qvu5AE1ePUeBXd1N2gQrzY
a96wE1kiFrgz558g6DYtkJMz/u79xG2B40W4p4listTpco5jGGbnSy9haa6jn1O033JwC6uvWjsp
fujJymZhAfT7PaYScsO5aw20o/5D3RV2d9FqVAPW9yFqbrPsAJ7bnztIUfBxynVUHjbHAm7VBFYt
+Tanx07j5OAktPJqG5MhxMtOQlHdnP6TlT3c/ys5e3XBKe/wQVukqFgB6w6dgohMLZAMpRUVcJQt
Boc9ctDougd9jfceQC9TObLDYPIg0pYYztbTRqzfKX2pkAshzQ3h1Ful++AEUAFAaOwebVEu6acC
NIHZ0ooK3dkII/Ob0Lj3CwWHOjESsUZbxm9EQPF24MUQYWgddfqwCuPSjOOYSw+2xvvI6EhixK0d
6bykpRFhWNKPdRVuAsBCrhT9lz/UgVaje/GnMdrl1BJ4b5TWQxss3p6yQ5lYzvfpFBjx0iUdXSGa
8OO4hZwICjUdoSp+uy7zw0Nb6KOfCTL3Yb9bcao0Ayjq+xdaPaLDjbwXIMgelcV/xpenYA7/F3ZY
/dgaSUv7q8+4+3kbJ4x2+Jq+YskPHADk/mf1DOfDsfNCD7U+ALRWkmq1Z4p2UHdr0uMw5YIYkZqU
/dp+1OstJvOCa/YQHqc62ctPGlccLmhtcmAt0khmxrDWg6SLtUqd0o6125yvjTokt/+AsfIWO524
Nt3srEVPZ7ZgxSFhrpRAn+h6t8wX3PepQyC2CQ7rzDNPYcaqUy6pqni8nPfg4T0QI0VTGLmuGc63
UVkcseF6vnSKGTXsc5EGsMQAQonnoVF8V6gn1pvIii2SyI/6vfWpy8h/SVt8lJBsegWLwpQPcjgG
/0l1J6u1c+QGzuzq+lTND0gZQIGNDCw4rTxCfHCl33SKK7mQQR785y5nsdHZOzYX8tEjZYjIFv98
K+Xa20exfedaD7QWiH/bWp6JtwFEyJ3dT837IzG0LL2KyOWcrgLEbPcLwOQa6cMgkadnMZAT6lNH
FIaqhmJyfAi7IeLL+gF4L0lYN8mQmxSmHiTwv5NFEEzatTMI6F8oC32upF+M8Xb3zOay9hOMqZJN
fbiAwe+VcAQ48dz0er7kmUNflSxuYT4JK2zR+26PZv3rQC2ozAVh6AS8WMahcsi3hVvT97uoLCds
IpG7255X2UEnrIOsXBRXP4OsTeHpqugZbVeeSVNHbTPOFL1cdQcxQz0QdVPGcOnodmDZTAXX/VQW
zS8b+sQa4rRRRPOLGK1GEyIFn53CK+4ny167P8AGboj0omCOi5kfvrFyK7D+meIaKEYVQZ+wE2W/
bjsZQkAHmWvgpOcPloiNHKXHoMZftswgEWwxRWeJ4eoZ1ZHwngLjCmPPGnR5TZbutSihSLzJu1ie
tNAFh/gradrZuHQhoXchomNaLDtIHYRnuzHPww5gKUPuAf0uMkJOM8uYai31waJdIDXBoXPoi+G9
yYJzMGOA5e3TrGOGKDuTeEnCkuEPAc/cmHDboWXXwmDRtAR5MF3xse9on4Jk/dWN2oUwO8IOwgZD
UElNQg5VkEWQ9HtAbb/xsAoCbJ13/FWCVCgfRD3pLHW6fVRulQinGoNAIVhuytNzNvtZkRM7E2SO
kfQZO54SFKxy5xqrsWd/uhoLyp+Xx4ePATebpDkGTGzZsLfT+JRvUozBG23yvsZxdM+YSo5xQcGn
491AyZ/m9XT6yoycudqJasnQEo9NViiPizZ7FUgdW5EXRkigvMYCaOnaMjn5reFkiJ+V7Qr2nDyM
E7Tz7PW4IGXpKLtYFDJIkHAHLbo4uJXGM1E5fD5/HbKS/l9iIPgKpNLF9e8MDnAK6dmq+9ioJ9LS
Ore6geO9qK76e+OBwjempuDDqTWMbuzb+tX1ZqejMCJnROM8NIt8O0UrLQ2aH3meHy4SdPGFnQ1B
YOrKFtnEwicgUBWc0CosBEy3+kwnoLFvRTnkL+XO8fMWO0I8Y+vkobqr83XArkpWZhndP2Zd58M4
7PGEhrAnIhS4jNcN6C8qD+QUTZvyTQwQqDD7Bk6Ga0iHpqmhGGAJGuoOhLr7ON0qEWpjlW3ql+lF
k7r6oX12w8rBYXtgwcVcHOaQfUYekcqr40M0KBz9zQjCbKk/JmNthYPWPC6O8LeXl8u57KoqE3Ra
HBpuMRQaEJityimcnE43L9Lgu0CoHLQsLdUlIx4d2Vg2PvAbeH7HIvlCKLJLHUpmuc2vJ+XuODp0
MtE7IrXySFiW7S6dzADVJrcOwOgrRZSyDVWUMD1JxNIL9GvzyA1PB+E2BMUG7Pnr9xH1f/CxJtOB
JPg3AbyjfA8WzOsQJQhdkki0mYcBtZxdwXeU8UMfgSPtZ8TQkwohcd+qmCcQzXFEGp3YVMLRcn4k
NQUCeOIbZKoIBfE837ARQlPLXL51PLlBhC+VCY3za/zvvGqbMkRiz7WlYtxC/04WdJcBmCaeiS7m
9qt1ROQZsgtFkxY3KbSolzgoY5P1sh6VXbw10uPE7uisaR/KUu2MYOsMs0nRiXfiQM6qExHUeBJf
jTqVp/3vBR+lWXVKA82da5QhjHzDjJkaFWynbpVyWOGs24IjLQkOA7idnP6TKvkYG6Ik9zo/EXBF
BdvAbt0VWUsLMxuHTG0Ob/HPd8+tA15fcYxN/dmqARnD2VFAQKRkJSxb2A5gl7JxFvI+g3Ea0MmL
9mtYSd2lQLOQuHrl6O3nnKNVzSibe9HXdqBYd9o4f4mVKlwhnoQAE7BnvSgD2darweLLvc5WkANS
KKiJKY654C/7ABGQK6dvD1LBkf3fbA481WQoNYbx5fJw2yeI0jlvLw8OFlhg75Q0c6pmeek1Vspq
5XZyLk0St9JK4mxzaiQiFLpPZy7jPAdS9va2R4QwgDTV0bsgLcc/9d/aB4SQRl9oPniCSrG9M6cR
vySw8s+U0+JXZEwjjIkN9N5XWXohdMvAjDZe3bMlMDAeo4xBioDa4HRfDM4NyuACaxdi88+mVYmg
2B8Fx+tQq8bObui+OadA8Ptv0VwYOUz3ZQ7tzoTSsRDtTjZd8Q32Bfr5DZUoiYWDsrshuRdriImk
TfuTQJWZ72Bv9exiIJFUgVL8Smnnd7bNlKflxNC/+CuY5BOCYC7CValYeO9tt/22OFNLri6cSAdM
6XSBrVAs7xy6Kcg3pL250jePhlLarooKkWfoQbafDnHx8wUvrbxgXE9Hoaso4UYWiDuJdncw3aLg
HQWEACauhCehNtVtxG1GBFawTnEXcgkn6SopAa0LRr5B5wfUFu5u8+F3vU7I1znjHmYDqvEdEJ20
GOS92LrYV4Dq3PYquDCTdRK04RgOJKGqTqCjj4TNAIWOE32PHKtcohMIAUZ33rWgSpOKKb9/bwqq
9sIxarLZik9OjRv4QKTtKMB6BBWNTy35rjEgGzmu9zHH+VF3Wk2La7NxGGCG8um4OeuPQoPkCPDF
cRDxqciKNFhhfKftb/mt4TG3AosbcPlq53ETNZHiJseYXbc22pgVJDTtKbZ77cM+O97iJKBmd1yo
moiO1n7og5sJVWb8021D75YmJ5eBh5ODl4Lf7pKdeDlUIXIN8gP18xdqvQQkEkrBWkjTS9TXx1Yq
xt3vhCJsjyDdC50rNU6t+8miBFn6E1SvXQSvxWqRMASkjOGsooajv8GpAF3wrxLfnv1kIQ2hU3Kp
Z0fRbTyzGivVcCsX3ihU3FAscd4c4jeyAGD99W65/ZefFg18xf2ZCJvMIb83VSMWhFPh/QeYtonC
D8cwz6o3+MYbGPi0jyKyfw8bJ61L6IHalW4C/tF8vWjERNtsLYIgcO+cYU3GUU0rbylsQCvEu9pH
K9H2vUYoviF+zpOw4D6NZF3LSCIvVceGW72fdKNFmBC9QLYuwfQD+qq6vzzi7OrF4wwbxs6SfLXi
oLSifWTyf0A4ezFi8eWFOwZUfTbdCTgj5RE4G/J2WF4gBua2DctI8wUSR1/MNvZ5XzJbCNnVsNuJ
vw06PKkoW8F2ew1qOGHMu5VYTYAM4BO2Q18aotteRWieqDRxxa6O2JBPB+BRj2MPaIV48Gd17NOi
zwJfwSs80Aqi6KQDQi19uiRrZGp0eBhX1dB8YQXIs5desfpxukERBFVPLN5UJWWhwqoSCUWkSMrz
eIZ26dDi8xpqbc79w6h9FE4TcT7xWgEel2EUNORw631Pj5XycwamS3jIJYk+2wVXUl5BPOfW65f3
zSkkNK6cL8yCSolKCLnegv5i/FQNg9VXP1v+wESH0MVMRUQw32lxdXySlhZ6pvD/XoeUtJEHDD/B
Ar6Ygjc9nHFfs36pZUkHkWV+Vn/07e69fEZblq0z6pbhc4DxME1j0gQztng1B5B+k5l2/X/WSXH5
rSCISctrz7oSf/tGoZX+JQDwj19Ii6IF8LrofBO5ObeftgbV77Amlew9KgwxvTb6TiAv3dADi0hT
t6QkEgsYWJMbZ6QuG+zouidaAVjiA+yXzrmC7HGzQJ4y60uKYKeFcRog7nOg1dwKqpNUT5k46eFX
AFigSVEFqAUmvEQoqOxvMWPvjYMuWlmOOKF2spP0O1P2cZ+F23s0000N3BD6hgfAVdyXw3/J/9Nw
hTtS+BmGELufZc3OxEgrkkfUmhmzhM66U/ZLnLrw9ebUZGx0LSJXm/RyO2uNpEry+xhIaBsbUiDZ
Vh2sGr2oIN751fTVKb9Hnj3CD42I+vL04uEOKaeFq4RTgDIo75usKyWJE3dGJ8HjsRYGHJnkYYp5
Wn9FWdztvYvckgyXj/ODqU91X3e13ku0eo/mUA8epPZHsjm6JrLWCUvcaszXZdiFcdU4yjdZWPy0
o3GwhmZSvq2Fh6pEiENQ4IDSZLBMXicYICFX1RT2vnGmlz701rHPihC49K5tSXp2VCkSD6aAN9fo
yebXcNoXM2vjUUtcmonnlX6vLh/CF8sUMRHVf5NiVBFBjbzDF/tIt3bm0KXKCGoxKKXNrn9Rvu0Y
QXgBqqc64xyykGIYxLFOSEp8TF7a5rPKlcJLvUDGlwnkaykntsBdJpl2eZiNk7txK/hRHTp12hL1
RFicX+CbdnlWmCiVAC8KKcWJCWcfdGA5qgeeWeb/nsN+JYnqr6hca2lIuqAICpzsmoI+EhfiKM75
fDeUMIVoEcDnexvclin6LrGeDp4Fo3VTMY8FAJwKEWLy+Ef90JPtiTw+GS1RSycHccmxEVmdKWVt
k8K2b420JyxpUWoLI63iaJD3nHFy8ousrTNngnLTCJsqtj6W8HyY2z4opIlQHyLBkNf1Lj5/njvo
WL43PJKrkGXX6cLyAaxrIBUINDbXCebHq5eBZoSwF0qN+RaqNGBQLWf73i2R6fZOswbU9eRP3Qw9
g6uvst6EreNQxDXQxXRZV/ghZX6LXI1XiqCEaPevV2yl0X5mM0umH2EYL0HZj39vwgZOizgqTH/M
/mHM0MOzwt0Uc/hpxPLnkbTHdCy4/Vs+vMbH7qkq8TeuGOgzc1isLL2ToVv3cdUCxJsv9xwz0Z0r
TkMHIfnTi+Ooc8stEPurxmVlclr0rTPH+Bw0mN1lCuuynzwgMGbp4SJavWKK45Wpsfn3BrceBP2V
roWO6nuqN4bNVGmmyeS5YyyGSOaQwpbf/ubOvcN0UJ0dt+lhmbqAN4Un/RJswBrR7P12gJLsoVaX
xW9k6ehqvpm8k/mPNvLLCaADaQwrniOqhu1KtGivzcDkCcZfBq7QZ+7VqjGE2Gw+BSp2Eskq8RKc
soZDe7QuAPNYBJUX+9xY8BdoYgx+BCCIqCvdaB+ZB8rxBX+zkcXl2f+uRoWUccdP2NIfIu29ii6/
NmPqux/KUIgm9DZCb1LkiZhM3FmgqNmDorRX90f5Fkb/BFGSE07nyRZWyncZQ23HBJ/cUdkpb+gB
E3AlERAKAXrj00gKIXGEun6VUqd7pLQGTRo21y29WePYy/6Phiaf5W5sCFN/3c1fl7Yx6PXD+NNX
FipA+9WVyEyFy5tWUXVgaQx7T/WaOiFDUHlOnRyzIuGKtUuInlKjDyGqAeHoT/AUxKwjByCV3+Tj
EKf1lwp/6gu6eOqEWGGO/wNfZYu1fVLqRhdRnj/SdSr/pVFEby1cubvIXsFSYO4hKf1izsvtgD56
owvNrL8cGcA/VxPdK7JFTl1ydaDmhbwafUH43Mza9rRSDCyOxX4sGuqw5jv1ReTOqZc0Bw1uF9lv
GsVJqMSG0Fg9ZXKv7XxTL745YlYxfBeG/+7sZH3sqNBcAqv2qhTRU3vfmeVLSPijGGLGSnMnKp9j
gmy4B7Y5ZbG88TnzNsOuqHwM8vemEXqRjQG9dvG6iu7Q+Y6h3FgLThynrXAlRWEcmJzrQ+uhtSIZ
TjYCVH31iVvTkEjwAywKwJcWySQimJcLJ3lqa7mbRhd9Gekd1g70GOnC0lPeUUIfSZnoOcPyWrTC
IGdeQ+RRs6nKMBwZ8z5K9Wz7MO8Bu9ndlKuMEOfiCsyMWmicRyHMX7AThMF/Lr7zRktdNes5A4OD
F5BwBhCHXjJKwH/+nJi8yzAYKWEz6ZFxcwOb6y7iUBE9aqlRxZoM5Co1oLv70yTQzt6kWyXK9ol2
IKBUC4xKSSrQJGvvNuqQjlj5X4kjVN22k+XRv1ajEdbtOWeZ2vEWbOp1+0MP5ZskcqcUCRAW9NzB
xSJv++/y9yB/9/IZDI2ozNfmB8cFKEpFnhwQFTst3X1qjEtqBfW20Hy83tITXyVzsmCWMic14Cek
YmWrBBnlrXeIxijoCaMPtidPABYeT9WG8KF0eEIkSihjCwQRULUd3mzuoaFmJMAMpasoC9V+x4Wr
YXjNCFWte501CinCUQQG1VMQ5g4PasP4xPqsdXNKwRMpOOE8Bn585aMJUMbtdEoK1HVFJhudG25I
U74WO/6Dy7O8eRPgWV0lSLJAqSr4FFMKE3spSpSgXLDLQ1rCd7Swnfy2yafBU7V3FNvUqHknlm1u
f2RjinWHsHrif/G+bf6kShiZnbQktAOeNTBMn+f2kZZMvSyPEYlrlWX9OVBNEpKkGfoI/wJp+5Q9
fL3QMTCLdvNHzIzSLLR6pEzglKQYcyTYrZ8=
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
S+zbaN7YT6utXBR/KxZuoy6PFGYTVSd5paQ2Bu3jD7/XyDv5vMxzEPHg9M5JLnbESbncON70juM+
4C/U6YneGg7PbRWiiVUFE1tKVpH5rRUy6oSssNeYe//dBkQSBkhu0L9LIdpR6iAf4KtPXFqZvAPU
Q9GtFh2ldxbjOPt98M/rtMW5q7v3niJ+A4hyXh7arj0DYPz2MrIC9QJka4roL1OXT5KKc5lF7IwG
4LAuWWQ0AEi7VvUrsyIWodrfDojwKD00bGXaEjViAEDMmD3nCzL9IInu4K3rRGPLpU/dCo7AAxFa
M5BiNyil+oiP/l3Z38IuO+SDvwmJe/TtpOGShw==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
lA11vU8EuFsFIvntHXjRFyV/dKL6hqsuPbiW8GbhbgD1QJTecoUtnNuQpIK/4HQ+mvBQuui75cfz
ZskU6ELgPgauQz9tQWSDirGVLhYgq5Tb4dW92FFiqVpGiKRT+zzMisdPL4a3m+dxcpTFloygLsly
AYwnAZFF9/chyvcgBMgioKVO2ixSOvVsCj5cwApHxGfJzoPqJo3Tc3g9ct0qQS9nSwgca7rwHFsg
xBXSh3mUH+A97y1EnRcQOaD4zINGzXIL2rRb+2rJUOwJ98Bx3wd3PILIFaGIinMOZ6+NPqOUC5K+
p4rCmDT4rpX9nkKfYKxgzrPoo0hezKBBW5+4MQ==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 4672)
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
S+zbaN7YT6utXBR/KxZuoy6PFGYTVSd5paQ2Bu3jD7/XyDv5vMxzEPHg9M5JLnbESbncON70juM+
4C/U6YneGg7PbRWiiVUFE1tKVpH5rRUy6oSssNeYe//dBkQSBkhu0L9LIdpR6iAf4KtPXFqZvAPU
Q9GtFh2ldxbjOPt98M/rtMW5q7v3niJ+A4hyXh7arj0DYPz2MrIC9QJka4roL1OXT5KKc5lF7IwG
4LAuWWQ0AEi7VvUrsyIWodrfDojwKD00bGXaEjViAEDMmD3nCzL9IInu4K3rRGPLpU/dCo7AAxFa
M5BiNyil+oiP/l3Z38IuO+SDvwmJe/TtpOGShw==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
lA11vU8EuFsFIvntHXjRFyV/dKL6hqsuPbiW8GbhbgD1QJTecoUtnNuQpIK/4HQ+mvBQuui75cfz
ZskU6ELgPgauQz9tQWSDirGVLhYgq5Tb4dW92FFiqVpGiKRT+zzMisdPL4a3m+dxcpTFloygLsly
AYwnAZFF9/chyvcgBMgioKVO2ixSOvVsCj5cwApHxGfJzoPqJo3Tc3g9ct0qQS9nSwgca7rwHFsg
xBXSh3mUH+A97y1EnRcQOaD4zINGzXIL2rRb+2rJUOwJ98Bx3wd3PILIFaGIinMOZ6+NPqOUC5K+
p4rCmDT4rpX9nkKfYKxgzrPoo0hezKBBW5+4MQ==


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
