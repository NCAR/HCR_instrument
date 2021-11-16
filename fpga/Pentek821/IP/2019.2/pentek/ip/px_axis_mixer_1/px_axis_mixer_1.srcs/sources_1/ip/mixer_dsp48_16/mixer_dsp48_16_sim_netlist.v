// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  8 11:01:40 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_axis_mixer_1/px_axis_mixer_1.srcs/sources_1/ip/mixer_dsp48_16/mixer_dsp48_16_sim_netlist.v
// Design      : mixer_dsp48_16
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mixer_dsp48_16,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module mixer_dsp48_16
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
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [16:0]P;

  wire [15:0]A;
  wire [17:0]B;
  wire CE;
  wire CLK;
  wire [16:0]P;
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
  (* C_P_LSB = "17" *) 
  (* C_P_MSB = "33" *) 
  (* C_REG_CONFIG = "00000000000011000011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  mixer_dsp48_16_xbip_dsp48_macro_v3_0_17 U0
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
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "110000010000010100000000" *) (* C_P_LSB = "17" *) 
(* C_P_MSB = "33" *) (* C_REG_CONFIG = "00000000000011000011000001000100" *) (* C_SEL_WIDTH = "0" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_17" *) (* downgradeipidentifiedwarnings = "yes" *) 
module mixer_dsp48_16_xbip_dsp48_macro_v3_0_17
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
  output [16:0]P;
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
  wire [16:0]P;
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
  (* C_P_LSB = "17" *) 
  (* C_P_MSB = "33" *) 
  (* C_REG_CONFIG = "00000000000011000011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  mixer_dsp48_16_xbip_dsp48_macro_v3_0_17_viv i_synth
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
ffcT0EQ9sv8UsTectdhCRIPejAIPlvINBZWKtNtWqYwy9sQHJYs5iCabhmULi8QJ818/M4CLceyx
nlz9JijP2BGckxASLrF7taxGrSEuGOWp/PqXjJLQJHFmqAljaAlyzZLlYwCE2Zdio0DXSYUOZyX0
+7je0Pqq7gnrrAW8XYvG5FMW8ieZi3Axn+d2m7Ubtyl6i5O66j5K53CsKUVfff+tWGAA9LxehjC8
Fzjwh4e8s9KkFT4eDMmNK3NFP2XrNb1w+Qenkch9BdohfhMJARXVARFp39UCv5KXoPGm5BQCiX+Y
WfO88L7FxEF6jjGVObw5hzXmlQeaPWtAV8iQxg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
XCda2+5MPhPZkCMy228RypSpmBlErACUAt2hMm9Z+NPeGvOLMxjqcXIKcDQyDl6zBcanKendNPHk
ENPcsOHxDYmrl7d7ZTne4OwWmD68UPTrIWJvMyRUfteZl+MUUsndSivlXtkCkxzZQZPSyscMhN+Y
dJMPxYMQroKhIEsAL2jZIuFhG1flexlzJSWaxSO0I+lAf4lg8lTMz6ubGRYmKt4fyNhECyotASYB
dBzETYxxnAjsaJKIk8lJHUNmwywmOF6NwkO8Sx7P2fGHA3PADh4FmD4+/Kiq7DinD6n2faCPLV70
XjaJUhsUyKAKO2X7PCN65LgYP5QkdQ0DtYoLBA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 31376)
`pragma protect data_block
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
eE7C38Pxyl+SAKXh2NwlmTvtmaQx1zNOJVQ=
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
