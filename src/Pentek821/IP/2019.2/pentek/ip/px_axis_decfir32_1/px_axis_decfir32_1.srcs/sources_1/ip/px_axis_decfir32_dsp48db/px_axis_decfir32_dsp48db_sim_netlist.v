// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  8 10:33:25 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_axis_decfir32_1/px_axis_decfir32_1.srcs/sources_1/ip/px_axis_decfir32_dsp48db/px_axis_decfir32_dsp48db_sim_netlist.v
// Design      : px_axis_decfir32_dsp48db
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_axis_decfir32_dsp48db,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_axis_decfir32_dsp48db
   (CLK,
    CE,
    B,
    D,
    PCOUT,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:pcout_intf:carrycascout_intf:carryout_intf:bcout_intf:acout_intf:concat_intf:d_intf:c_intf:b_intf:a_intf:bcin_intf:acin_intf:pcin_intf:carryin_intf:carrycascin_intf:sel_intf, ASSOCIATED_RESET SCLR:SCLRD:SCLRA:SCLRB:SCLRCONCAT:SCLRC:SCLRM:SCLRP:SCLRSEL, ASSOCIATED_CLKEN CE:CED:CED1:CED2:CED3:CEA:CEA1:CEA2:CEA3:CEA4:CEB:CEB1:CEB2:CEB3:CEB4:CECONCAT:CECONCAT3:CECONCAT4:CECONCAT5:CEC:CEC1:CEC2:CEC3:CEC4:CEC5:CEM:CEP:CESEL:CESEL1:CESEL2:CESEL3:CESEL4:CESEL5, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_LOW" *) input CE;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 d_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME d_intf, LAYERED_METADATA undef" *) input [23:0]D;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcout_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME pcout_intf, LAYERED_METADATA undef" *) output [47:0]PCOUT;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [39:0]P;

  wire [15:0]B;
  wire CE;
  wire CLK;
  wire [23:0]D;
  wire [39:0]P;
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
  (* C_OPMODES = "000100100000010100011100" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "39" *) 
  (* C_REG_CONFIG = "00000000000001010011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_axis_decfir32_dsp48db_xbip_dsp48_macro_v3_0_17 U0
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
(* C_HAS_PCIN = "0" *) (* C_HAS_PCOUT = "1" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SCLRA = "0" *) (* C_HAS_SCLRB = "0" *) (* C_HAS_SCLRC = "0" *) 
(* C_HAS_SCLRCONCAT = "0" *) (* C_HAS_SCLRD = "0" *) (* C_HAS_SCLRM = "0" *) 
(* C_HAS_SCLRP = "0" *) (* C_HAS_SCLRSEL = "0" *) (* C_LATENCY = "-1" *) 
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "000100100000010100011100" *) (* C_P_LSB = "0" *) 
(* C_P_MSB = "39" *) (* C_REG_CONFIG = "00000000000001010011000001000100" *) (* C_SEL_WIDTH = "0" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_17" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_axis_decfir32_dsp48db_xbip_dsp48_macro_v3_0_17
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
  output [39:0]P;
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
  wire [39:0]P;
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
  (* C_OPMODES = "000100100000010100011100" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "39" *) 
  (* C_REG_CONFIG = "00000000000001010011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_axis_decfir32_dsp48db_xbip_dsp48_macro_v3_0_17_viv i_synth
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
AObLD98tVWgHuRwEbfCjwkgEfdH+GW95wE5eTZhz34BLgnPGfUeCtwIuFeO40TWO1QrveFxS7r91
ux3avprIrzf/VZrYYzD6yTfa/xHa8egPT65mpDhKz3PfML8aT/Yart6d35sXnij9r+XBT/W5OW/d
y5wy8E8aiXeUwHiyrquu65sj/SjznFLK0HbBseyZe6M/5E3A/AAQD1QTAr2khMkHxxZpr6Mq6OIY
iXubrSp8qWL4pHRupr8aQGY0DJ3ON4gfFU0Q6rANkhuDEcUnYD1dmjB1mUjNtNr33eOzK4VEanJu
XfAgjgYdtTVtg8qepP8TAQu2CJb4vnrJjTRa4Q==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
SV/kKK2Q1843P/ocPEP8v5r8AfHisMtyFJXCUERB989tzI/dlvrvGfdoDn56dYWA2LG6cs0EJuUw
cVElYYPXVnafFGifxPSYElvlvQoOL/CD6Zv2ppWArRb31vYXiGynnu80NE5mECe/dyTPu8T2BKBQ
wds9Zl/m4ff0BVKel/IJoYLRlLjcu5Zhes2QJPQiKZoQwBdTXkhjT2uJlkR6RA+TLwvla9ASwXms
gcnW7ADl/9DVmzcDlOTxH9V0AtrOBvRYbH3gWJb8Sq4MOHt/uZrK1CB5QI8035QHIFw0+Xchbuf+
NwWkn4zqHMf6qgNQfZsSPchguZHpCpzQhd+Ogw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 30608)
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
