// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  8 10:39:46 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_axis_fdecfir32_1/px_axis_fdecfir32_1.srcs/sources_1/ip/px_axis_fdecfir32_dsp48db/px_axis_fdecfir32_dsp48db_sim_netlist.v
// Design      : px_axis_fdecfir32_dsp48db
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_axis_fdecfir32_dsp48db,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_axis_fdecfir32_dsp48db
   (CLK,
    CE,
    A,
    B,
    D,
    PCOUT,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:pcout_intf:carrycascout_intf:carryout_intf:bcout_intf:acout_intf:concat_intf:d_intf:c_intf:b_intf:a_intf:bcin_intf:acin_intf:pcin_intf:carryin_intf:carrycascin_intf:sel_intf, ASSOCIATED_RESET SCLR:SCLRD:SCLRA:SCLRB:SCLRCONCAT:SCLRC:SCLRM:SCLRP:SCLRSEL, ASSOCIATED_CLKEN CE:CED:CED1:CED2:CED3:CEA:CEA1:CEA2:CEA3:CEA4:CEB:CEB1:CEB2:CEB3:CEB4:CECONCAT:CECONCAT3:CECONCAT4:CECONCAT5:CEC:CEC1:CEC2:CEC3:CEC4:CEC5:CEM:CEP:CESEL:CESEL1:CESEL2:CESEL3:CESEL4:CESEL5, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_LOW" *) input CE;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [15:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [17:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 d_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME d_intf, LAYERED_METADATA undef" *) input [15:0]D;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcout_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME pcout_intf, LAYERED_METADATA undef" *) output [47:0]PCOUT;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [33:0]P;

  wire [15:0]A;
  wire [17:0]B;
  wire CE;
  wire CLK;
  wire [15:0]D;
  wire [33:0]P;
  wire [47:0]PCOUT;
  wire NLW_U0_CARRYCASCOUT_UNCONNECTED;
  wire NLW_U0_CARRYOUT_UNCONNECTED;
  wire [29:0]NLW_U0_ACOUT_UNCONNECTED;
  wire [17:0]NLW_U0_BCOUT_UNCONNECTED;

  (* C_A_WIDTH = "16" *) 
  (* C_B_WIDTH = "18" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_D_WIDTH = "16" *) 
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
  (* C_HAS_D = "1" *) 
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
  (* C_OPMODES = "000100100000010100001000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "33" *) 
  (* C_REG_CONFIG = "00000000000011010011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_axis_fdecfir32_dsp48db_xbip_dsp48_macro_v3_0_17 U0
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
        .D(D),
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

(* C_A_WIDTH = "16" *) (* C_B_WIDTH = "18" *) (* C_CONCAT_WIDTH = "48" *) 
(* C_CONSTANT_1 = "1" *) (* C_C_WIDTH = "48" *) (* C_D_WIDTH = "16" *) 
(* C_HAS_A = "1" *) (* C_HAS_ACIN = "0" *) (* C_HAS_ACOUT = "0" *) 
(* C_HAS_B = "1" *) (* C_HAS_BCIN = "0" *) (* C_HAS_BCOUT = "0" *) 
(* C_HAS_C = "0" *) (* C_HAS_CARRYCASCIN = "0" *) (* C_HAS_CARRYCASCOUT = "0" *) 
(* C_HAS_CARRYIN = "0" *) (* C_HAS_CARRYOUT = "0" *) (* C_HAS_CE = "1" *) 
(* C_HAS_CEA = "0" *) (* C_HAS_CEB = "0" *) (* C_HAS_CEC = "0" *) 
(* C_HAS_CECONCAT = "0" *) (* C_HAS_CED = "0" *) (* C_HAS_CEM = "0" *) 
(* C_HAS_CEP = "0" *) (* C_HAS_CESEL = "0" *) (* C_HAS_CONCAT = "0" *) 
(* C_HAS_D = "1" *) (* C_HAS_INDEP_CE = "0" *) (* C_HAS_INDEP_SCLR = "0" *) 
(* C_HAS_PCIN = "0" *) (* C_HAS_PCOUT = "1" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SCLRA = "0" *) (* C_HAS_SCLRB = "0" *) (* C_HAS_SCLRC = "0" *) 
(* C_HAS_SCLRCONCAT = "0" *) (* C_HAS_SCLRD = "0" *) (* C_HAS_SCLRM = "0" *) 
(* C_HAS_SCLRP = "0" *) (* C_HAS_SCLRSEL = "0" *) (* C_LATENCY = "-1" *) 
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "000100100000010100001000" *) (* C_P_LSB = "0" *) 
(* C_P_MSB = "33" *) (* C_REG_CONFIG = "00000000000011010011000001000100" *) (* C_SEL_WIDTH = "0" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_17" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_axis_fdecfir32_dsp48db_xbip_dsp48_macro_v3_0_17
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
  input [15:0]D;
  input [47:0]CONCAT;
  output [29:0]ACOUT;
  output [17:0]BCOUT;
  output CARRYOUT;
  output CARRYCASCOUT;
  output [47:0]PCOUT;
  output [33:0]P;
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
  wire [15:0]D;
  wire [33:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;

  (* C_A_WIDTH = "16" *) 
  (* C_B_WIDTH = "18" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_D_WIDTH = "16" *) 
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
  (* C_HAS_D = "1" *) 
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
  (* C_OPMODES = "000100100000010100001000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "33" *) 
  (* C_REG_CONFIG = "00000000000011010011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_axis_fdecfir32_dsp48db_xbip_dsp48_macro_v3_0_17_viv i_synth
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
        .D(D),
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
VJWePgYYwW8tKPMnpWC4Hm4z7WX4n3eW1kktVPh+U2GG/ql8whwYCNmtbUoTPuoqi4C9xm/PCeCJ
GEV7WkVCNBxz6UHNFvCTnF8oGb8VZHcLvvO32LXVXJr7d+Ge3scj/ZVLEcC0tsJXQxKcOKWuDAKR
3W0C48/Q/COU4bC4tzwpwPGKtrKXRAz1ni49L6ZNbNL6VHzPnYoalQb8F5XhxfHH1xpf4Oop1ma3
373P5Cqb2PPJbJ5TiBY0kfr/Bty4xTuF5PcxOWX04YYq/rdg/PVG0tei+mtxejlQLoVW5xRC6VG8
lfOVx2OtmxqTsDagx5nfV0573vBcv3E/WcV/5A==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
UsbsqF+ZaCUEpniTk8TfZA5K/TSEMs76NIhNEpfzrhiBadh0x2hFTm2RucJiT3Ib8fDUKLxkXfUl
BxXoHyiSSX5eEKwt+xPJcPcG8eyOSS9feZecmINQOeL6kRtfVroEwKYsZn5zL5h0sWW8XvyGp8qO
CmUC4RiWsoatTMO5QQLhReQQE0+tSHkuTezECwdy7vf+qKfdP+rz6f5LT1D+7g6g9Q+heDcCux84
8O71QVeupMG41dxBZ8lxQTJBrpQLKTb0OYg+4XPza8y6HQJXkySCWR1ON/KiZZoHPmw4CXtQ3Dxt
Ba1cqMkNvmuACoAlD2RoQFdPv1/M4ePHB/LWbA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 30976)
`pragma protect data_block
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
rJS7cYjdcAJyK5H1sA5B3wEEv3hB2fb++Q==
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
