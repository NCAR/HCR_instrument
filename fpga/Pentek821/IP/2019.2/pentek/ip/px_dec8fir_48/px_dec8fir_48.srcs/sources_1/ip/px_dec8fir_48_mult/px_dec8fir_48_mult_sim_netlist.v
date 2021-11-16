// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sun Jun  9 07:10:54 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_dec8fir_48/px_dec8fir_48.srcs/sources_1/ip/px_dec8fir_48_mult/px_dec8fir_48_mult_sim_netlist.v
// Design      : px_dec8fir_48_mult
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_dec8fir_48_mult,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_dec8fir_48_mult
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
  px_dec8fir_48_mult_xbip_dsp48_macro_v3_0_17 U0
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
module px_dec8fir_48_mult_xbip_dsp48_macro_v3_0_17
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
  px_dec8fir_48_mult_xbip_dsp48_macro_v3_0_17_viv i_synth
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
aDR0xrVZVSSYyYPgWeyLfWonBv0OB9uOBwABEgJ3yLrOzTt1Sz6k1S5M/cSFWPUw+mF0SBqi5sAB
v/lM4btA8ubvh4qPo2BZMBoB8VNKLXaMjW6MRcVtN99M6FmBeEX12wybnj1YsenlTpCBBM5evgqk
VkD+z3kp3JzmvW4JWskzeQ1xmPtVWjEYWEYPNZBoFlzLj+4G++mvX6fRgVQCSOq874l/D+vFz9ox
tHEtDAHB7F61ibjHVG4mdzjdJEc5uPiag2T6nolTC8FQopMb4ok8I9dbV5F5ZvL0gZqC7scffeb+
bqXEnQHE3NIhb0HKiCIiTtB3SPgeGF6ICutNFA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
TPmzjNxsXtrYzwu0jHCH37v6uNQHAkIqrZhl6KwOidYpUKe3zQc3BZAchcIWVN5NhCRt+dS5HlGu
cYnlRMPDmAQF5AWd8wvmSTUJNYwstzQshlB8He5DAcey4Qc2sET9QwBp5dO/6QjiCtfWPM4kfNDg
Sq/RC5+dFe3eWztfvLjLEGrtWOQ56W2z+QOLTSjIXN3irIxFdn/eX3E96aDgVOOyJWXT9y7MSV9S
xNQPIGp3n5qlv3ZibQeW/C9Z+AvsVJb1mlD1T5+Fc2DPcNOER45LUFxGj9ZCP03CQ7nG3nDMKh/+
7lUbHnQV3AlAJoxmrZnweIKJd4XeK2ojiNzTuA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 30256)
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
