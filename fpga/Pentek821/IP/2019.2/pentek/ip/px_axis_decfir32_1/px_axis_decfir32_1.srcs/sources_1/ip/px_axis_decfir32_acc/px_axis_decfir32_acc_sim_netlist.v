// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  8 10:33:32 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_axis_decfir32_1/px_axis_decfir32_1.srcs/sources_1/ip/px_axis_decfir32_acc/px_axis_decfir32_acc_sim_netlist.v
// Design      : px_axis_decfir32_acc
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_axis_decfir32_acc,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_axis_decfir32_acc
   (CLK,
    CE,
    SEL,
    PCIN,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:pcout_intf:carrycascout_intf:carryout_intf:bcout_intf:acout_intf:concat_intf:d_intf:c_intf:b_intf:a_intf:bcin_intf:acin_intf:pcin_intf:carryin_intf:carrycascin_intf:sel_intf, ASSOCIATED_RESET SCLR:SCLRD:SCLRA:SCLRB:SCLRCONCAT:SCLRC:SCLRM:SCLRP:SCLRSEL, ASSOCIATED_CLKEN CE:CED:CED1:CED2:CED3:CEA:CEA1:CEA2:CEA3:CEA4:CEB:CEB1:CEB2:CEB3:CEB4:CECONCAT:CECONCAT3:CECONCAT4:CECONCAT5:CEC:CEC1:CEC2:CEC3:CEC4:CEC5:CEM:CEP:CESEL:CESEL1:CESEL2:CESEL3:CESEL4:CESEL5, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_LOW" *) input CE;
  (* x_interface_info = "xilinx.com:signal:data:1.0 sel_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME sel_intf, LAYERED_METADATA undef" *) input [0:0]SEL;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcin_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME pcin_intf, LAYERED_METADATA undef" *) input [47:0]PCIN;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [47:0]P;

  wire CE;
  wire CLK;
  wire [47:0]P;
  wire [47:0]PCIN;
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
  (* C_C_WIDTH = "48" *) 
  (* C_D_WIDTH = "18" *) 
  (* C_HAS_A = "0" *) 
  (* C_HAS_ACIN = "0" *) 
  (* C_HAS_ACOUT = "0" *) 
  (* C_HAS_B = "0" *) 
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
  (* C_LATENCY = "128" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "000000000001001000000000,000000000001000000000000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000000000000000000100100" *) 
  (* C_SEL_WIDTH = "1" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_axis_decfir32_acc_xbip_dsp48_macro_v3_0_17 U0
       (.A({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACOUT(NLW_U0_ACOUT_UNCONNECTED[29:0]),
        .B({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
        .SEL(SEL));
endmodule

(* C_A_WIDTH = "18" *) (* C_B_WIDTH = "18" *) (* C_CONCAT_WIDTH = "48" *) 
(* C_CONSTANT_1 = "1" *) (* C_C_WIDTH = "48" *) (* C_D_WIDTH = "18" *) 
(* C_HAS_A = "0" *) (* C_HAS_ACIN = "0" *) (* C_HAS_ACOUT = "0" *) 
(* C_HAS_B = "0" *) (* C_HAS_BCIN = "0" *) (* C_HAS_BCOUT = "0" *) 
(* C_HAS_C = "0" *) (* C_HAS_CARRYCASCIN = "0" *) (* C_HAS_CARRYCASCOUT = "0" *) 
(* C_HAS_CARRYIN = "0" *) (* C_HAS_CARRYOUT = "0" *) (* C_HAS_CE = "1" *) 
(* C_HAS_CEA = "0" *) (* C_HAS_CEB = "0" *) (* C_HAS_CEC = "0" *) 
(* C_HAS_CECONCAT = "0" *) (* C_HAS_CED = "0" *) (* C_HAS_CEM = "0" *) 
(* C_HAS_CEP = "0" *) (* C_HAS_CESEL = "0" *) (* C_HAS_CONCAT = "0" *) 
(* C_HAS_D = "0" *) (* C_HAS_INDEP_CE = "0" *) (* C_HAS_INDEP_SCLR = "0" *) 
(* C_HAS_PCIN = "1" *) (* C_HAS_PCOUT = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SCLRA = "0" *) (* C_HAS_SCLRB = "0" *) (* C_HAS_SCLRC = "0" *) 
(* C_HAS_SCLRCONCAT = "0" *) (* C_HAS_SCLRD = "0" *) (* C_HAS_SCLRM = "0" *) 
(* C_HAS_SCLRP = "0" *) (* C_HAS_SCLRSEL = "0" *) (* C_LATENCY = "128" *) 
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "000000000001001000000000,000000000001000000000000" *) (* C_P_LSB = "0" *) 
(* C_P_MSB = "47" *) (* C_REG_CONFIG = "00000000000000000000000000100100" *) (* C_SEL_WIDTH = "1" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_17" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_axis_decfir32_acc_xbip_dsp48_macro_v3_0_17
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

  wire [29:0]ACIN;
  wire [29:0]ACOUT;
  wire [17:0]BCIN;
  wire [17:0]BCOUT;
  wire CARRYCASCIN;
  wire CARRYCASCOUT;
  wire CARRYOUT;
  wire CE;
  wire CLK;
  wire [47:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;
  wire [0:0]SEL;

  (* C_A_WIDTH = "18" *) 
  (* C_B_WIDTH = "18" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_D_WIDTH = "18" *) 
  (* C_HAS_A = "0" *) 
  (* C_HAS_ACIN = "0" *) 
  (* C_HAS_ACOUT = "0" *) 
  (* C_HAS_B = "0" *) 
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
  (* C_LATENCY = "128" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "000000000001001000000000,000000000001000000000000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000000000000000000100100" *) 
  (* C_SEL_WIDTH = "1" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_axis_decfir32_acc_xbip_dsp48_macro_v3_0_17_viv i_synth
       (.A({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACIN(ACIN),
        .ACOUT(ACOUT),
        .B({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCIN(BCIN),
        .BCOUT(BCOUT),
        .C({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CARRYCASCIN(CARRYCASCIN),
        .CARRYCASCOUT(CARRYCASCOUT),
        .CARRYIN(1'b0),
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
        .SCLR(1'b0),
        .SCLRA(1'b0),
        .SCLRB(1'b0),
        .SCLRC(1'b0),
        .SCLRCONCAT(1'b0),
        .SCLRD(1'b0),
        .SCLRM(1'b0),
        .SCLRP(1'b0),
        .SCLRSEL(1'b0),
        .SEL(SEL));
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
X+i28i0BS2kppR4O1eM76nsleTQOFvAEuwRMTcVyLJdi/x/FRwsR0RZfcfSZlpiRoq62oUa7o7HC
OPH6ltj2lSfgS+Ct0b79ae4Ha8jUffFLf3RaYS/h4M51OLWOrcJw8oeeVuMlw0P7LJfUOzUz1R47
XAYEaeVZEUlqcnYTb95DpaIco8nD7iLC+Ek0uCFEzeXpJENSSwFi1W5NxODeGCygPPxvmREd5L3i
mGhaunVsYBilxj7yETxnnVndOY/+0iKlAPdEHy71PSm2fxAbUFnO/EP91rTCQd08wYbVIcbJXbDa
VEXO7ED8PLbj2L/mVY6FLa2lSvau5ABuJWn/oQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
EmkRQs3/pRGaIm15lrxlcpZ0g8uKqVVfVtHIwSaUVGRpMb5Ur93ZAURs3cijiEZ1c8E2FozRaeSJ
abCsnFkuyd+mD3ny5Td0o7cnFIlkuNy9cbHdvb3Mp4yD0h9FNQ1zJVmC6d4PGI+LIKUBwuO4YbBO
iVwjtZtaWKskzTIvULp+cy9xqly9JYj/WjcymL3l3KAS9pciDeVYs14Md4djvcVuK7+nKxQnRDj2
MxNDxoUv/+VZPZLKrxXQMvXcswTxULJuhVk5mp/JKVUfZ+cj5MkfofdDop6tVUOIZ4y3UDN9Ggot
jH+Gsa78V4LZZAKVt3cvSJzeyfnEXxvSZPq9KQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 9792)
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
