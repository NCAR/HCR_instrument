// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  8 08:55:45 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_2ch_dec2fir_2/px_2ch_dec2fir_2.srcs/sources_1/ip/px_2ch_dec2fir_2_mult/px_2ch_dec2fir_2_mult_sim_netlist.v
// Design      : px_2ch_dec2fir_2_mult
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_2ch_dec2fir_2_mult,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_2ch_dec2fir_2_mult
   (CLK,
    A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:pcout_intf:carrycascout_intf:carryout_intf:bcout_intf:acout_intf:concat_intf:d_intf:c_intf:b_intf:a_intf:bcin_intf:acin_intf:pcin_intf:carryin_intf:carrycascin_intf:sel_intf, ASSOCIATED_RESET SCLR:SCLRD:SCLRA:SCLRB:SCLRCONCAT:SCLRC:SCLRM:SCLRP:SCLRSEL, ASSOCIATED_CLKEN CE:CED:CED1:CED2:CED3:CEA:CEA1:CEA2:CEA3:CEA4:CEB:CEB1:CEB2:CEB3:CEB4:CECONCAT:CECONCAT3:CECONCAT4:CECONCAT5:CEC:CEC1:CEC2:CEC3:CEC4:CEC5:CEM:CEP:CESEL:CESEL1:CESEL2:CESEL3:CESEL4:CESEL5, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [26:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [42:0]P;

  wire [26:0]A;
  wire [15:0]B;
  wire CLK;
  wire [42:0]P;
  wire NLW_U0_CARRYCASCOUT_UNCONNECTED;
  wire NLW_U0_CARRYOUT_UNCONNECTED;
  wire [29:0]NLW_U0_ACOUT_UNCONNECTED;
  wire [17:0]NLW_U0_BCOUT_UNCONNECTED;
  wire [47:0]NLW_U0_PCOUT_UNCONNECTED;

  (* C_A_WIDTH = "27" *) 
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
  (* C_LATENCY = "-1" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "000100100000010100000000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "42" *) 
  (* C_REG_CONFIG = "00000000000011000011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_2ch_dec2fir_2_mult_xbip_dsp48_macro_v3_0_17 U0
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
        .SEL(1'b0));
endmodule

(* C_A_WIDTH = "27" *) (* C_B_WIDTH = "16" *) (* C_CONCAT_WIDTH = "48" *) 
(* C_CONSTANT_1 = "1" *) (* C_C_WIDTH = "48" *) (* C_D_WIDTH = "18" *) 
(* C_HAS_A = "1" *) (* C_HAS_ACIN = "0" *) (* C_HAS_ACOUT = "0" *) 
(* C_HAS_B = "1" *) (* C_HAS_BCIN = "0" *) (* C_HAS_BCOUT = "0" *) 
(* C_HAS_C = "0" *) (* C_HAS_CARRYCASCIN = "0" *) (* C_HAS_CARRYCASCOUT = "0" *) 
(* C_HAS_CARRYIN = "0" *) (* C_HAS_CARRYOUT = "0" *) (* C_HAS_CE = "0" *) 
(* C_HAS_CEA = "0" *) (* C_HAS_CEB = "0" *) (* C_HAS_CEC = "0" *) 
(* C_HAS_CECONCAT = "0" *) (* C_HAS_CED = "0" *) (* C_HAS_CEM = "0" *) 
(* C_HAS_CEP = "0" *) (* C_HAS_CESEL = "0" *) (* C_HAS_CONCAT = "0" *) 
(* C_HAS_D = "0" *) (* C_HAS_INDEP_CE = "0" *) (* C_HAS_INDEP_SCLR = "0" *) 
(* C_HAS_PCIN = "0" *) (* C_HAS_PCOUT = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SCLRA = "0" *) (* C_HAS_SCLRB = "0" *) (* C_HAS_SCLRC = "0" *) 
(* C_HAS_SCLRCONCAT = "0" *) (* C_HAS_SCLRD = "0" *) (* C_HAS_SCLRM = "0" *) 
(* C_HAS_SCLRP = "0" *) (* C_HAS_SCLRSEL = "0" *) (* C_LATENCY = "-1" *) 
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "000100100000010100000000" *) (* C_P_LSB = "0" *) 
(* C_P_MSB = "42" *) (* C_REG_CONFIG = "00000000000011000011000001000100" *) (* C_SEL_WIDTH = "0" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_17" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_2ch_dec2fir_2_mult_xbip_dsp48_macro_v3_0_17
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
  input [26:0]A;
  input [15:0]B;
  input [47:0]C;
  input [17:0]D;
  input [47:0]CONCAT;
  output [29:0]ACOUT;
  output [17:0]BCOUT;
  output CARRYOUT;
  output CARRYCASCOUT;
  output [47:0]PCOUT;
  output [42:0]P;
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

  wire [26:0]A;
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
  wire [42:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;

  (* C_A_WIDTH = "27" *) 
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
  (* C_LATENCY = "-1" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "000100100000010100000000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "42" *) 
  (* C_REG_CONFIG = "00000000000011000011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_2ch_dec2fir_2_mult_xbip_dsp48_macro_v3_0_17_viv i_synth
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
bt923V0SwELcsXgyXuMeBBP19E9vC6TYe5r85ElWRojc3hLmokrelig8g/yDCUQZgZ6sFOm+o2VA
j/JHOczJ4q+nH7m88pYCBV3kIR5JfNctd6kKJmrcdKN5fnzVWclaDicYYfS+AqHUxsie8ZNMnkkE
q4v/2etu5LvVBZTuiF9MCaAsbRvJY4L0cnfZWE6EsVl8jwsThgdgqWkf9xRTdbcAbr4wk2nt1PcH
aUEocas87g5a8eOfkslOC/txGYnxpOjRdiWVZ0pzPMSZkpnfHf7UWej1jPKgdREufY4qOUgwAKAy
5Cb90lKav+gJjraN8Dzv0DV/wWMN7+grrb6+4w==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
fkGHbzpp7VNRcdK5qJImbwuYU5/y6B76DjtnydjrK2WdZO7mdBF1dMspuVS8jT6eGRiR4DPBBffp
Et9so1u/6b7Hy+RuUq5FOu4ttqIouGvjF6UZJJo+WUdcCPbd7KjHv+s+HM/qUl5cF1hPSv25kC+W
JTbglMceNriX3+1R6XmpA0OJ2iIs0lhF9RVg7rgqm0NO+/3rw56aGliSfRIxKazf3NXo5iXxufb3
Cr7ctJMec8AUU26HbH3GlWK+/D66j7yzdpIeAvI1q5zmOj31m32CQjLAkpufexb+fNdwhhCIz93d
b6pK+wU04jVgxDlEdV49pAQAQ0ibjZ8XY5yP6Q==

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
