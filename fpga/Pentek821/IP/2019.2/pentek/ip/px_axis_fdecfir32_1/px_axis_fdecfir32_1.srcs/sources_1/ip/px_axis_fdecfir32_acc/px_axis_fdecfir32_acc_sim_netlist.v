// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  8 10:39:53 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_axis_fdecfir32_1/px_axis_fdecfir32_1.srcs/sources_1/ip/px_axis_fdecfir32_acc/px_axis_fdecfir32_acc_sim_netlist.v
// Design      : px_axis_fdecfir32_acc
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_axis_fdecfir32_acc,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_axis_fdecfir32_acc
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
  px_axis_fdecfir32_acc_xbip_dsp48_macro_v3_0_17 U0
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
module px_axis_fdecfir32_acc_xbip_dsp48_macro_v3_0_17
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
  px_axis_fdecfir32_acc_xbip_dsp48_macro_v3_0_17_viv i_synth
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
b+OfOBS7fTLZpgNJylKAau9vwewLxpGnBn9aLp6qR5UEoGGXLoMOUQaDO6B7FZDZaIJZyJfl1KeZ
Q80xWZTFFc5AVOyQE45TFfruIMKlmraPjPoPPENtRjDZDaofkLf7k14qohOVQW62O+XJ2i/2m+9A
I9uwWbWiurB/V3Mr7ig/9MRhBTnlBAOMK/16Wo5cdQjm1ckyoSJkrL5absqX1WchjigZ3OwoI76/
M/FdC+AalMXP0M5Hx1I/uK1FOfYcg9Sdiesf8+KoCXINEVbEGoin5Ddf1pmsCSq5YSHOXG1cOWnO
lNd7by0mB0tzXPQ/i//bHPXmdLbqYCZbXxBOcQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
os0V5aM4v5AlbHH5APz+R7xKLQbhRkzmm5LwE2TTaOF4NZLiWJE7AeRmhsvM/QW7LmjJIeDKryMn
Y7TO80XlCyUfMmbezbQl6EG8Ysm3OsqnRmiwlnluML9jepYyXcJDxLBCRCzhzH7iORB2qgFtpyUQ
KA+besVmNzSbYNWYebM4ogj5355VZ0jR1yeaTErJEDqRTKyt8Y+4ogL5jwM0xSqB7DQla3kVNyOM
DS1ad2+LdSUY4zzHSubNa4cyhspj+ZZWUJpSu1U9T8+HIRqb+QoOdS4x/G0//shBkrYpDcm840+E
H/MH+zs3xECDHu9QlCEgPnvA6lxuXKnnto9Y8w==

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
