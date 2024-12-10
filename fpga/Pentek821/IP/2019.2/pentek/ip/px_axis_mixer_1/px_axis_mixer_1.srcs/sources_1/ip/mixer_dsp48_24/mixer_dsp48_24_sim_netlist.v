// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  8 11:01:41 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_axis_mixer_1/px_axis_mixer_1.srcs/sources_1/ip/mixer_dsp48_24/mixer_dsp48_24_sim_netlist.v
// Design      : mixer_dsp48_24
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mixer_dsp48_24,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module mixer_dsp48_24
   (CLK,
    CE,
    SCLR,
    A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:pcout_intf:carrycascout_intf:carryout_intf:bcout_intf:acout_intf:concat_intf:d_intf:c_intf:b_intf:a_intf:bcin_intf:acin_intf:pcin_intf:carryin_intf:carrycascin_intf:sel_intf, ASSOCIATED_RESET SCLR:SCLRD:SCLRA:SCLRB:SCLRCONCAT:SCLRC:SCLRM:SCLRP:SCLRSEL, ASSOCIATED_CLKEN CE:CED:CED1:CED2:CED3:CEA:CEA1:CEA2:CEA3:CEA4:CEB:CEB1:CEB2:CEB3:CEB4:CECONCAT:CECONCAT3:CECONCAT4:CECONCAT5:CEC:CEC1:CEC2:CEC3:CEC4:CEC5:CEM:CEP:CESEL:CESEL1:CESEL2:CESEL3:CESEL4:CESEL5, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_LOW" *) input CE;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclr_intf RST" *) (* x_interface_parameter = "XIL_INTERFACENAME sclr_intf, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input SCLR;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [15:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [17:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [24:0]P;

  wire [15:0]A;
  wire [17:0]B;
  wire CE;
  wire CLK;
  wire [24:0]P;
  wire SCLR;
  wire NLW_U0_CARRYCASCOUT_UNCONNECTED;
  wire NLW_U0_CARRYOUT_UNCONNECTED;
  wire [29:0]NLW_U0_ACOUT_UNCONNECTED;
  wire [17:0]NLW_U0_BCOUT_UNCONNECTED;
  wire [47:0]NLW_U0_PCOUT_UNCONNECTED;

  (* C_A_WIDTH = "16" *) 
  (* C_B_WIDTH = "18" *) 
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
  (* C_HAS_CE = "1" *) 
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
  (* C_HAS_PCOUT = "0" *) 
  (* C_HAS_SCLR = "1" *) 
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
  (* C_OPMODES = "110000010000010100000000" *) 
  (* C_P_LSB = "9" *) 
  (* C_P_MSB = "33" *) 
  (* C_REG_CONFIG = "00000000000011000011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  mixer_dsp48_24_xbip_dsp48_macro_v3_0_17 U0
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
        .CE(CE),
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
        .PCOUT(NLW_U0_PCOUT_UNCONNECTED[47:0]),
        .SCLR(SCLR),
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

(* C_A_WIDTH = "16" *) (* C_B_WIDTH = "18" *) (* C_CONCAT_WIDTH = "48" *) 
(* C_CONSTANT_1 = "1" *) (* C_C_WIDTH = "48" *) (* C_D_WIDTH = "18" *) 
(* C_HAS_A = "1" *) (* C_HAS_ACIN = "0" *) (* C_HAS_ACOUT = "0" *) 
(* C_HAS_B = "1" *) (* C_HAS_BCIN = "0" *) (* C_HAS_BCOUT = "0" *) 
(* C_HAS_C = "0" *) (* C_HAS_CARRYCASCIN = "0" *) (* C_HAS_CARRYCASCOUT = "0" *) 
(* C_HAS_CARRYIN = "0" *) (* C_HAS_CARRYOUT = "0" *) (* C_HAS_CE = "1" *) 
(* C_HAS_CEA = "0" *) (* C_HAS_CEB = "0" *) (* C_HAS_CEC = "0" *) 
(* C_HAS_CECONCAT = "0" *) (* C_HAS_CED = "0" *) (* C_HAS_CEM = "0" *) 
(* C_HAS_CEP = "0" *) (* C_HAS_CESEL = "0" *) (* C_HAS_CONCAT = "0" *) 
(* C_HAS_D = "0" *) (* C_HAS_INDEP_CE = "0" *) (* C_HAS_INDEP_SCLR = "0" *) 
(* C_HAS_PCIN = "0" *) (* C_HAS_PCOUT = "0" *) (* C_HAS_SCLR = "1" *) 
(* C_HAS_SCLRA = "0" *) (* C_HAS_SCLRB = "0" *) (* C_HAS_SCLRC = "0" *) 
(* C_HAS_SCLRCONCAT = "0" *) (* C_HAS_SCLRD = "0" *) (* C_HAS_SCLRM = "0" *) 
(* C_HAS_SCLRP = "0" *) (* C_HAS_SCLRSEL = "0" *) (* C_LATENCY = "-1" *) 
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "110000010000010100000000" *) (* C_P_LSB = "9" *) 
(* C_P_MSB = "33" *) (* C_REG_CONFIG = "00000000000011000011000001000100" *) (* C_SEL_WIDTH = "0" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_17" *) (* downgradeipidentifiedwarnings = "yes" *) 
module mixer_dsp48_24_xbip_dsp48_macro_v3_0_17
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
  input [17:0]B;
  input [47:0]C;
  input [17:0]D;
  input [47:0]CONCAT;
  output [29:0]ACOUT;
  output [17:0]BCOUT;
  output CARRYOUT;
  output CARRYCASCOUT;
  output [47:0]PCOUT;
  output [24:0]P;
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
  wire [17:0]B;
  wire [17:0]BCIN;
  wire [17:0]BCOUT;
  wire CARRYCASCIN;
  wire CARRYCASCOUT;
  wire CARRYIN;
  wire CARRYOUT;
  wire CE;
  wire CLK;
  wire [24:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;
  wire SCLR;

  (* C_A_WIDTH = "16" *) 
  (* C_B_WIDTH = "18" *) 
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
  (* C_HAS_CE = "1" *) 
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
  (* C_HAS_PCOUT = "0" *) 
  (* C_HAS_SCLR = "1" *) 
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
  (* C_OPMODES = "110000010000010100000000" *) 
  (* C_P_LSB = "9" *) 
  (* C_P_MSB = "33" *) 
  (* C_REG_CONFIG = "00000000000011000011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  mixer_dsp48_24_xbip_dsp48_macro_v3_0_17_viv i_synth
       (.A(A),
        .ACIN(ACIN),
        .ACOUT(ACOUT),
        .B(B),
        .BCIN(BCIN),
        .BCOUT(BCOUT),
        .C({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CARRYCASCIN(CARRYCASCIN),
        .CARRYCASCOUT(CARRYCASCOUT),
        .CARRYIN(CARRYIN),
        .CARRYOUT(CARRYOUT),
        .CE(CE),
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
        .CONCAT({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .D({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .P(P),
        .PCIN(PCIN),
        .PCOUT(PCOUT),
        .SCLR(SCLR),
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
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2019.1"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
nDT0FFr3kgAnVEb2awIM3BnKUBc7yihoXB0vfPof9ml3qiHsywja1jzpI0JL5TCkL5Vim5+pfP8I
0LoVeSlLdw==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
leuQs1hhDH9+hOOQlz+rNh7VdTud8SM3XjvAtbigjfVXcA5aNVJUbTOxuEGUipSwD4xg6vAQhUNU
DDOXTaF36Kfc7A+qxERpwYqe3DoxX4tLp0gmxRsyUkB1xGkORCW/PFoyj32u2V5IiZ/5p/7rUXhw
gZ2aWWBj+bTQrQ0xwb8=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ypbhn2W+iOZPt4pWarhni35O4FaP/76+bnxHXqRCMcOP8Qjoaah4eM0O2O/m3jnsQelmsTpYhA2O
6tnq7o+aOSa1Yrf7o8mke23hE7jOca1t8DqUxIHD+bvTrSeXLaRubFyUjUy/O8kNjDSJ9GZKD86P
xtVU6jm1cp3nuuD/pAPERRV13+MWckBp6glo9OlCWgTV/FM2zC9q5vLom2BOuzWz9mFFpmhKyNgj
NXhV/3gG/f16RvoR/hUdtXEPEc4WmUePjU8eT8LCLc5DHf/pDJM5vO0ier7HAAtAwPkXcxSHQK4X
NNBGzw3GV+MN9Y0abcvzkNo7bm0Vl9iCaMXOzQ==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
hKfQEFSkz1+iUXEzpGZQXnEjl6Xu87VajUqqo6psFiQuSetWUEZHKUb5bIenWv9GpqyX444Y8Wf+
YkDM3axnFIfLHDX0RU410ylCx1Ip9IHSAk/Az7yTYCh2qTkhycA2wAVMaINYlXvVv9gDSWvLvNAl
tKInavD4D14joDZL1OhOHMaaei622MQt+uJwNXP0U+ojMJTJghCc7YYo3BY2IKwaf1EUWVcyPhTl
zQJ/4gRsDsVR8J8YdIEEMybZHxhCxL+O6pkLMTcpEctoRiYD7aDJB0koeBrsYHMGER2PRsbfFLAN
GZCnHjADfCfMNgsJkVG7gRGAaLFQEESPI1yW8g==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2019_02", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
mStClLzet5qWZ6xyWOxCXWIOJpxoFFAdb87C9h5/A+BwbXHdFkDYgyR/p4SRYfWVFP/21toTRpVF
O+BaFDbl/7bhGaiRAKqHROKAtxH+qra0evZ/fNCG0uKKLBgIA+UiAAhU1zOKKDZMhv1jO7hRKWrj
3IhG8tmDOu6h/LgZOSq0ED00GorsA5SHgXHrJxCBpHjqx16nuMDK2VhXKA6fCY/Oz9QNBgEUR9Y0
FAvuWLz0+64BreNMt0Rh/FCRZv2iSPVahsTncHAhtAn9zu45vFTlrav1Vzgfik3DX8jlByPmSRtj
ao57HQCyXxC6S7mRoStDfY1FM3Vrgaa8Q9FQOg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
OKqfJevTlfXHMYcxqeiJOSMVoQ7uWRORRRovYWsq7xdU598tCXUmOJS8I0GcbIZ1ZJF7En/DUT3U
uHy4fImCnIlBhvb7tWeR64l8fA3NDf8TROs4UwwkaPKveLah/9vvHfSCqRl67y9S8LmCfGhf2riD
6U2l/21Qoh+y8n47hl8=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Hi65SSdBb27dkJQDyd0+ZUNHbJLTAPzntdwe6ND6gJJ93P/dmDIUtF2b1aGBky/6BsQZtkDi3XwM
xSpVlqUGnD0kWJFMfPQmSPynrZNLwgVPNB5o11haxVQZeMAOaRssP/m6WQ8dbuvAlCFcCu0q3DNf
6J6u0ISFJdKhGtxCoA4/S7eo2RXifv4f6bOrFvV+a10IkfZyKTVSi6jZruHcQVkg4mIDrd+TzUAw
/4YzGJ7WnzR1bjSdkzfIhcQkpgTDS+xshM0qRGBZu6P/zt/CRfWCGSGomapBi9ef1unBpMHn5nOi
ieiu2r//R53Rf1hwP2iXI/RY9ng1nM2uuySTBw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
HuKPQh5QHlpAK/mBReYeRz43ye0adV4BHwjExmPZpyFTMpFYLxywdomddbmq0mWjfARDbdg3L6c6
u92krUnu2M7wUWAXUP5HAWrQww968RCY3eLsUCVMgqh7rQtZ8jN0e4apzR5QcgTOFbEgSnWclO70
eODTemPgOL5G/Jlwzd+92rv2W+JCAdIkWnqwIk83V6SxiIZa/v/yPp4FIpvWXRMV+zJjKmXlBEl1
+C/wGMyf80+OfANJTeM7XRnLevS5F88LD/1jgmwgY3drnJJUP1iyQkaGR7vHkKWGbFBKJUsDqHph
TyCZ1VZwt5leKziH+12mYqSEejAChBoSBQuUyg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
4meuLRWZxfjmSjvFLwUQp/yUwu2ettyPykjQcEquVf7HmZSIqcQ+Mv0UW+W4NDw3XuARnkwIVuAN
KYYwc0E2uiF1Z8SuMcBskLHe1zLppx1P0i2cprTGU58LuNVH3LuoSBeIKI7p2skKXhNvmdkmZT+c
4e53OhvX0F7MPknFvly1PSD/Rim2QEP6WBiwg71tvL7jr/hQuAzKe16RbKQLrO7g9BMmaJip5xED
iUdOtqvZSLebGY5j6X00yFJ0N5oaEg6JA0Yxomd4jfRReyi9KOQesedX/ZF4brYVBxLI8awfsHoi
+nbrA4tnHxItS/JOklf7lvNhLg1EU65oes4Aog==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 31360)
`pragma protect data_block
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
3GNUFjcn/t6aFA==
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
