// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  8 19:04:12 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_axis_pwr_meter/px_axis_pwr_meter.srcs/sources_1/ip/px_pwr_meter_dsp48_isqr/px_pwr_meter_dsp48_isqr_sim_netlist.v
// Design      : px_pwr_meter_dsp48_isqr
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_pwr_meter_dsp48_isqr,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_pwr_meter_dsp48_isqr
   (CLK,
    A,
    B,
    PCOUT,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:pcout_intf:carrycascout_intf:carryout_intf:bcout_intf:acout_intf:concat_intf:d_intf:c_intf:b_intf:a_intf:bcin_intf:acin_intf:pcin_intf:carryin_intf:carrycascin_intf:sel_intf, ASSOCIATED_RESET SCLR:SCLRD:SCLRA:SCLRB:SCLRCONCAT:SCLRC:SCLRM:SCLRP:SCLRSEL, ASSOCIATED_CLKEN CE:CED:CED1:CED2:CED3:CEA:CEA1:CEA2:CEA3:CEA4:CEB:CEB1:CEB2:CEB3:CEB4:CECONCAT:CECONCAT3:CECONCAT4:CECONCAT5:CEC:CEC1:CEC2:CEC3:CEC4:CEC5:CEM:CEP:CESEL:CESEL1:CESEL2:CESEL3:CESEL4:CESEL5, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [15:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcout_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME pcout_intf, LAYERED_METADATA undef" *) output [47:0]PCOUT;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [31:0]P;

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
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_pwr_meter_dsp48_isqr_xbip_dsp48_macro_v3_0_17 U0
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
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_17" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_pwr_meter_dsp48_isqr_xbip_dsp48_macro_v3_0_17
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
  wire CARRYCASCIN;
  wire CARRYCASCOUT;
  wire CARRYIN;
  wire CARRYOUT;
  wire CLK;
  wire [31:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;

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
  px_pwr_meter_dsp48_isqr_xbip_dsp48_macro_v3_0_17_viv i_synth
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
        .CE(1'b0),
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
pb0R6NYRQ4Z0RswQF7SOfQYCAxgr6dxZrUHOEP8Lz/h6fWQnGi6m+iMcztCRyyEG3TVC+o9+yRFR
l0v9+/F9ADl3uyMatukEJjABFsOK67YpFJ5gtXyPS/1ggQJ1SYKThhf6osxUER9XeDVtCG5/SpxY
1Nmkypc75Xi1oobqJeWdMqARPjkdvFamJzHmjtMirVORMItA0TpcQG0OPYZUTKHaX4nIopkyHfnq
P/oqvjKAU8qFSNObRbsWxsCemKp9PTzGod/LgKm5nOIoDRo6mQYKgDvqtQcWxIoLNSNpDnH0vlj9
Xqc/Aw09Xb4iwfS6uBfzTqeCx4WTcu8kWtR54g==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
SllChyJFUNIQ3DCEjO9dGiIw2G+aVZC+e4yLCAAL5uMCSmUSiFjknoGIwZZrP12gt0bb6GF4/W+Y
f2oG9kkL9AQaITOueBiQnBlUhoZe9CTtEzpdMrrt1062YuRJtv4zZEwloUzv59xRMcZYoQscgZDh
bALvlDlou2Qhrz4HFFVJpdqPT2LXQSB6XuiDXrcPCHrH4kEKRMyKZqafDj2LIujks4MbqPHcvKPt
iBDva8uVX28/wJtsC8z2A2/teHwvFE3jz3KiFfqTYiRG50B1D5Uzb1hs1SRcB9OUBzpMaqJxFyy4
WMr0xhj6Kx9FvA3LyXdvmbIHf5JIgsIvS/jOMA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 30864)
`pragma protect data_block
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
CcgsYwxexivz1XkFiX1ugh49uDmJ/AuxfcCa
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
