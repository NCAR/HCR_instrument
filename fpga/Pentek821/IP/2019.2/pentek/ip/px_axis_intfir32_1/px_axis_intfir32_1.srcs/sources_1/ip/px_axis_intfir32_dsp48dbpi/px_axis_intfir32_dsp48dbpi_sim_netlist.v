// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  8 10:46:09 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_axis_intfir32_1/px_axis_intfir32_1.srcs/sources_1/ip/px_axis_intfir32_dsp48dbpi/px_axis_intfir32_dsp48dbpi_sim_netlist.v
// Design      : px_axis_intfir32_dsp48dbpi
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_axis_intfir32_dsp48dbpi,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_axis_intfir32_dsp48dbpi
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
  px_axis_intfir32_dsp48dbpi_xbip_dsp48_macro_v3_0_17 U0
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
module px_axis_intfir32_dsp48dbpi_xbip_dsp48_macro_v3_0_17
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
  px_axis_intfir32_dsp48dbpi_xbip_dsp48_macro_v3_0_17_viv i_synth
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
bWn2foNV/gU16T0PnD0874rOpK752eRRz02dXlIvTMSDJ2XcWd9KEarqDxPZT4zA8dB6DwA/ZykJ
uQCdM13pYmnEMZ3Pj5uztEaqWvXH9SolYdyUFqv1PuYIioT+20grGRIEZzj2EYcULXSuCxIxPhx+
10RAheJcB5r6c6YQajlUS0GA0fuNliV0LKlIUIB8oWow6thB+J7tyHBxHR3VIdHGSES0xZABAS9N
81iSL9iRZOgbTJ5MsQSUzxcoyeZkDxr7U9m0IfWMfps1RNFyzi6m+QVQiksUHSExh23PmDmsShA8
4XFwroYxvKMGcS9ZfXkZPbLei6hEL1efZjq/ww==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
IUVPYZbOLFbAweIXNKgC0mvTc7lQ0lQCHbqYHnv/eo1Vls1wjSXSXd9nTHaNU0QusycySnXkIvdV
uW4+SWMmQYuXPwLKFrQjS5r1a9xaNufDbptGCEQdqZfbhjiKtMqRRw1TMvjXP6pFze6xXdqZjWz8
Hue0XPTfCXas5GUgsFOwCgtcapkZEJsgghE/Ouv2zLSRCKQzp2Z71wClVCXFjpkCSd7mwXibLWfq
ODIEbWz5vt8LGEgtthC10WPEyCW4dGEtdHy4GyZ1T+gsL18qfHALM4ZL8CYkcmWYv8iKwPTsbAwa
UpV5/ZFyZKPjpcRWlLaS9k4Q/hu/HdzLzXcqjg==

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
