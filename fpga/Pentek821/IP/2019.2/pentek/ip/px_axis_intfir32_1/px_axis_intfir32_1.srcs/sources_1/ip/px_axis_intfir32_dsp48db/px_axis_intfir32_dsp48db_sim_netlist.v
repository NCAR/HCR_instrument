// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  8 10:46:03 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_axis_intfir32_1/px_axis_intfir32_1.srcs/sources_1/ip/px_axis_intfir32_dsp48db/px_axis_intfir32_dsp48db_sim_netlist.v
// Design      : px_axis_intfir32_dsp48db
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_axis_intfir32_dsp48db,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_axis_intfir32_dsp48db
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
  px_axis_intfir32_dsp48db_xbip_dsp48_macro_v3_0_17 U0
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
module px_axis_intfir32_dsp48db_xbip_dsp48_macro_v3_0_17
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
  px_axis_intfir32_dsp48db_xbip_dsp48_macro_v3_0_17_viv i_synth
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
AL3fnP2tP5oUaGbqb1ZLFeL6QzhR1md/JY9h93Bsvp94LPO55upjM4p0q0S06vfa9KCjxzyECHlt
tVIZo8QiNeDfkvGQXGGvDlOsI3Sj7mBNPwtfmx+giFAwfnNgC6KgwFHzAYEz3A6GE7znYIJHYOLj
jA1RM1WCW0Nf7cg6oB53kqn4TJ3vlpajkBraxW3b14ssX9Qm/1KtxY0WHDidcZniw16DKcdOPAqs
NdGwZcdaxQU/RSkn0TTZdluX57RJpeRnTqe3kg5q93t5EsM50aYvkF2waDaCIvAfpco4wPmDic1x
3/6XVYb/m9yWpwuVrCQaUnpbxdYtgs1Xq1DRlQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ZJnplwVxTTsl83FwECYJBjARE5db+cZp1pgPyUJFvVOM0sRaG/NxTSw5bM1HmGtMe7sW5c1vuans
PxpLUBj3PdC4o34/fznKz0Ssm/k5xQr+uU91pkFWa2gfUGGjvvwBXwKhq5h7d0r0xUqlrwBRtfFb
7HSNkidHqMrww1YlUSO/+RTgln02vRGDgv8EGcokEildcbOB+Ld5Oj0Q1KC8kGVXH1pO3cqi8vy7
8A0hoFv0CRAyBDVSJeAPb7CYdwvsx94En9nbCRH+aXV/Z6TGBOf5NYWW3XsI8w5Wmkls5WEqvr0q
HefI5YJ16UhlBsbN2YmUcP2TM/UzWJGYDdkS5g==

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
