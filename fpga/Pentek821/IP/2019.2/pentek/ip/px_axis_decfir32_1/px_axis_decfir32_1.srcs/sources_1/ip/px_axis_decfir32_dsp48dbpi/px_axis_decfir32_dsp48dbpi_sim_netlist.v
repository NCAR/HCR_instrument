// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  8 10:33:25 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_axis_decfir32_1/px_axis_decfir32_1.srcs/sources_1/ip/px_axis_decfir32_dsp48dbpi/px_axis_decfir32_dsp48dbpi_sim_netlist.v
// Design      : px_axis_decfir32_dsp48dbpi
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_axis_decfir32_dsp48dbpi,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_axis_decfir32_dsp48dbpi
   (CLK,
    CE,
    PCIN,
    B,
    D,
    PCOUT,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:pcout_intf:carrycascout_intf:carryout_intf:bcout_intf:acout_intf:concat_intf:d_intf:c_intf:b_intf:a_intf:bcin_intf:acin_intf:pcin_intf:carryin_intf:carrycascin_intf:sel_intf, ASSOCIATED_RESET SCLR:SCLRD:SCLRA:SCLRB:SCLRCONCAT:SCLRC:SCLRM:SCLRP:SCLRSEL, ASSOCIATED_CLKEN CE:CED:CED1:CED2:CED3:CEA:CEA1:CEA2:CEA3:CEA4:CEB:CEB1:CEB2:CEB3:CEB4:CECONCAT:CECONCAT3:CECONCAT4:CECONCAT5:CEC:CEC1:CEC2:CEC3:CEC4:CEC5:CEM:CEP:CESEL:CESEL1:CESEL2:CESEL3:CESEL4:CESEL5, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_LOW" *) input CE;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcin_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME pcin_intf, LAYERED_METADATA undef" *) input [47:0]PCIN;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 d_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME d_intf, LAYERED_METADATA undef" *) input [23:0]D;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcout_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME pcout_intf, LAYERED_METADATA undef" *) output [47:0]PCOUT;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [47:0]P;

  wire [15:0]B;
  wire CE;
  wire CLK;
  wire [23:0]D;
  wire [47:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;
  wire NLW_U0_CARRYCASCOUT_UNCONNECTED;
  wire NLW_U0_CARRYOUT_UNCONNECTED;
  wire [29:0]NLW_U0_ACOUT_UNCONNECTED;
  wire [17:0]NLW_U0_BCOUT_UNCONNECTED;

  (* C_A_WIDTH = "24" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_D_WIDTH = "24" *) 
  (* C_HAS_A = "0" *) 
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
  (* C_HAS_PCIN = "1" *) 
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
  (* C_OPMODES = "000000000001010100011100" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000001010011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_axis_decfir32_dsp48dbpi_xbip_dsp48_macro_v3_0_17 U0
       (.A({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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

(* C_A_WIDTH = "24" *) (* C_B_WIDTH = "16" *) (* C_CONCAT_WIDTH = "48" *) 
(* C_CONSTANT_1 = "1" *) (* C_C_WIDTH = "48" *) (* C_D_WIDTH = "24" *) 
(* C_HAS_A = "0" *) (* C_HAS_ACIN = "0" *) (* C_HAS_ACOUT = "0" *) 
(* C_HAS_B = "1" *) (* C_HAS_BCIN = "0" *) (* C_HAS_BCOUT = "0" *) 
(* C_HAS_C = "0" *) (* C_HAS_CARRYCASCIN = "0" *) (* C_HAS_CARRYCASCOUT = "0" *) 
(* C_HAS_CARRYIN = "0" *) (* C_HAS_CARRYOUT = "0" *) (* C_HAS_CE = "1" *) 
(* C_HAS_CEA = "0" *) (* C_HAS_CEB = "0" *) (* C_HAS_CEC = "0" *) 
(* C_HAS_CECONCAT = "0" *) (* C_HAS_CED = "0" *) (* C_HAS_CEM = "0" *) 
(* C_HAS_CEP = "0" *) (* C_HAS_CESEL = "0" *) (* C_HAS_CONCAT = "0" *) 
(* C_HAS_D = "1" *) (* C_HAS_INDEP_CE = "0" *) (* C_HAS_INDEP_SCLR = "0" *) 
(* C_HAS_PCIN = "1" *) (* C_HAS_PCOUT = "1" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SCLRA = "0" *) (* C_HAS_SCLRB = "0" *) (* C_HAS_SCLRC = "0" *) 
(* C_HAS_SCLRCONCAT = "0" *) (* C_HAS_SCLRD = "0" *) (* C_HAS_SCLRM = "0" *) 
(* C_HAS_SCLRP = "0" *) (* C_HAS_SCLRSEL = "0" *) (* C_LATENCY = "-1" *) 
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "000000000001010100011100" *) (* C_P_LSB = "0" *) 
(* C_P_MSB = "47" *) (* C_REG_CONFIG = "00000000000001010011000001000100" *) (* C_SEL_WIDTH = "0" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_17" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_axis_decfir32_dsp48dbpi_xbip_dsp48_macro_v3_0_17
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
  input [23:0]A;
  input [15:0]B;
  input [47:0]C;
  input [23:0]D;
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
  wire [15:0]B;
  wire [17:0]BCIN;
  wire [17:0]BCOUT;
  wire CARRYCASCIN;
  wire CARRYCASCOUT;
  wire CARRYIN;
  wire CARRYOUT;
  wire CE;
  wire CLK;
  wire [23:0]D;
  wire [47:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;

  (* C_A_WIDTH = "24" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_D_WIDTH = "24" *) 
  (* C_HAS_A = "0" *) 
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
  (* C_HAS_PCIN = "1" *) 
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
  (* C_OPMODES = "000000000001010100011100" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000001010011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_axis_decfir32_dsp48dbpi_xbip_dsp48_macro_v3_0_17_viv i_synth
       (.A({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
LsjSfqblIujP3xdQm7BgtxGexA6uCgYHWcZl2A3dBHfLEUkB58aoWU9i+RrgNNUwrFuZgI4oMU+b
LSB3ECcvZtly6G5bXE7cz8C6gqvN8kf826kcV4tJlGrbfJHJ1zm3w1oemK/Y317RP6StWjSZhgYu
Yno+hnPtIfNmrcATuI+uie7IJ+6HVJGAYS1STyEyb8xqr/aggxppnFrm5l8jIZG5JMA7NZeya/fc
c/G6eO0hX7Qwd3VV6uWSF+CCgXDHqm8cCSd8CmV+jaFJbN2OqCf5K7Ot/Uyafmm9adQq6qS3cvoa
o58QWJtWfe+FU2J1v8JguXkCZYyK0xrxfaci4w==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
N5NgnGEAfMjFb1PSOFFBpm/3NDqL2qn+3VQFqluDxEIgA4hY+JrN5IsLG2qIcY3d8WEGN0wqMKd2
nmotHSn1sxTmJN1CRQtijvEysrqU6K36bK5l1GcDarMiJXID7AG28piwz1HrtZBMFa8JEqTnZIJJ
hLn5UO3l39kIOzNq9mVceP90hjAdaKTKGTafp0Hl4GGGsydJeCbmXTBC+D5jbju7vB4K/j/A+RNB
KSgB1wVGotBDxVWAwFCf0LyV/HU3Irrf60uI7VyiCIGllJ+k9s9GESZFVI5UHENKEHB8dJ2WgBli
OIvVlyzkpM6rgp2imbY4f3ujVaH4nhZPzQkqzw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 30304)
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
