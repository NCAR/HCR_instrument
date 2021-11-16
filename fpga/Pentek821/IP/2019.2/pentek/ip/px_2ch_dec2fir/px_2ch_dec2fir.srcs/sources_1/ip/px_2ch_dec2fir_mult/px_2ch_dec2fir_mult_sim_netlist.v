// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  8 08:50:24 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_2ch_dec2fir/px_2ch_dec2fir.srcs/sources_1/ip/px_2ch_dec2fir_mult/px_2ch_dec2fir_mult_sim_netlist.v
// Design      : px_2ch_dec2fir_mult
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_2ch_dec2fir_mult,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_2ch_dec2fir_mult
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
  px_2ch_dec2fir_mult_xbip_dsp48_macro_v3_0_17 U0
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
module px_2ch_dec2fir_mult_xbip_dsp48_macro_v3_0_17
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
  px_2ch_dec2fir_mult_xbip_dsp48_macro_v3_0_17_viv i_synth
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
cvXTbJpIsjaXgGpun7G3bPRjH3iA5i+kM6fwIO4TgNZx8rm5aB5T6z/9Gn3LBAZ5pROEg5QIfRCM
lXPY99WlofuO0HWV6KKdDtTphITdFWuPLTHwNUFsBmG5GMYoCQBd8d3sBiZ8A6r3srKmluNUjWPL
CBURqiQ0DuhgMNhyx8yssNVjX6puEYRor8NjtE9b7UyeWV74lEHJn/QLDHEWOAYoJcUa6oy2ZUAQ
3M4WTAQNKX8H2r5/pN9E31YoEFkmU7DSSj8gsnNGaaVEmJn7Gjb2mqwIlPU4n+5wkoHmmSvirgHa
Ynn1D5/keHPNtXtLcL5SOGtFIwLf9eFNIjrYkQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
aid8ZSCdFtH4E/n6ThjjUAp9lA9jdx8ocu0pKYbkEIAuFFZigVp9B5AppscHNbGLHirSQrlbLu6Y
f5IcDbLFAO+yzCUhRqfWYH6r1szxK2Rjhn3sRnM09I3QkL9JOCFGQGfoj2k0D7HoAFyZjUkXnbi3
83I9QNJdVPFRdmyK3afmrhKeVD1byG69puWM2hpGc7BLCqjSi7rS98pq4JneFR6qxApLBzd2ixDz
EwSOTdw5WwzUlQF4+gsfrWlgJmHu/Lr0rqPN3ESrP3nUy4Qpwd7Cn12EYDjG1yk/J8NvPZhyMOkj
nIqkctHZvW7FXbgleSvZ92O2//Dx7ih2uGhHlg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 30272)
`pragma protect data_block
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
yQvxCKA=
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
