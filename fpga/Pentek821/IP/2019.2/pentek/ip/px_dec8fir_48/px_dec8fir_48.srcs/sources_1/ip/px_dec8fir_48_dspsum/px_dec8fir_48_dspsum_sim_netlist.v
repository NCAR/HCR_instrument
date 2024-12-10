// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sun Jun  9 07:09:42 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_dec8fir_48/px_dec8fir_48.srcs/sources_1/ip/px_dec8fir_48_dspsum/px_dec8fir_48_dspsum_sim_netlist.v
// Design      : px_dec8fir_48_dspsum
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_dec8fir_48_dspsum,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_dec8fir_48_dspsum
   (CLK,
    A,
    D,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:pcout_intf:carrycascout_intf:carryout_intf:bcout_intf:acout_intf:concat_intf:d_intf:c_intf:b_intf:a_intf:bcin_intf:acin_intf:pcin_intf:carryin_intf:carrycascin_intf:sel_intf, ASSOCIATED_RESET SCLR:SCLRD:SCLRA:SCLRB:SCLRCONCAT:SCLRC:SCLRM:SCLRP:SCLRSEL, ASSOCIATED_CLKEN CE:CED:CED1:CED2:CED3:CEA:CEA1:CEA2:CEA3:CEA4:CEB:CEB1:CEB2:CEB3:CEB4:CECONCAT:CECONCAT3:CECONCAT4:CECONCAT5:CEC:CEC1:CEC2:CEC3:CEC4:CEC5:CEM:CEP:CESEL:CESEL1:CESEL2:CESEL3:CESEL4:CESEL5, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [26:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 d_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME d_intf, LAYERED_METADATA undef" *) input [26:0]D;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [26:0]P;

  wire [26:0]A;
  wire CLK;
  wire [26:0]D;
  wire [26:0]P;
  wire NLW_U0_CARRYCASCOUT_UNCONNECTED;
  wire NLW_U0_CARRYOUT_UNCONNECTED;
  wire [29:0]NLW_U0_ACOUT_UNCONNECTED;
  wire [17:0]NLW_U0_BCOUT_UNCONNECTED;
  wire [47:0]NLW_U0_PCOUT_UNCONNECTED;

  (* C_A_WIDTH = "27" *) 
  (* C_B_WIDTH = "18" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_D_WIDTH = "27" *) 
  (* C_HAS_A = "1" *) 
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
  (* C_HAS_D = "1" *) 
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
  (* C_LATENCY = "128" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "110000010000010100001001" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "26" *) 
  (* C_REG_CONFIG = "00000000000010010010000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_dec8fir_48_dspsum_xbip_dsp48_macro_v3_0_17 U0
       (.A(A),
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
        .D(D),
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

(* C_A_WIDTH = "27" *) (* C_B_WIDTH = "18" *) (* C_CONCAT_WIDTH = "48" *) 
(* C_CONSTANT_1 = "1" *) (* C_C_WIDTH = "48" *) (* C_D_WIDTH = "27" *) 
(* C_HAS_A = "1" *) (* C_HAS_ACIN = "0" *) (* C_HAS_ACOUT = "0" *) 
(* C_HAS_B = "0" *) (* C_HAS_BCIN = "0" *) (* C_HAS_BCOUT = "0" *) 
(* C_HAS_C = "0" *) (* C_HAS_CARRYCASCIN = "0" *) (* C_HAS_CARRYCASCOUT = "0" *) 
(* C_HAS_CARRYIN = "0" *) (* C_HAS_CARRYOUT = "0" *) (* C_HAS_CE = "0" *) 
(* C_HAS_CEA = "0" *) (* C_HAS_CEB = "0" *) (* C_HAS_CEC = "0" *) 
(* C_HAS_CECONCAT = "0" *) (* C_HAS_CED = "0" *) (* C_HAS_CEM = "0" *) 
(* C_HAS_CEP = "0" *) (* C_HAS_CESEL = "0" *) (* C_HAS_CONCAT = "0" *) 
(* C_HAS_D = "1" *) (* C_HAS_INDEP_CE = "0" *) (* C_HAS_INDEP_SCLR = "0" *) 
(* C_HAS_PCIN = "0" *) (* C_HAS_PCOUT = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SCLRA = "0" *) (* C_HAS_SCLRB = "0" *) (* C_HAS_SCLRC = "0" *) 
(* C_HAS_SCLRCONCAT = "0" *) (* C_HAS_SCLRD = "0" *) (* C_HAS_SCLRM = "0" *) 
(* C_HAS_SCLRP = "0" *) (* C_HAS_SCLRSEL = "0" *) (* C_LATENCY = "128" *) 
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "110000010000010100001001" *) (* C_P_LSB = "0" *) 
(* C_P_MSB = "26" *) (* C_REG_CONFIG = "00000000000010010010000001000100" *) (* C_SEL_WIDTH = "0" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_17" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_dec8fir_48_dspsum_xbip_dsp48_macro_v3_0_17
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
  input [17:0]B;
  input [47:0]C;
  input [26:0]D;
  input [47:0]CONCAT;
  output [29:0]ACOUT;
  output [17:0]BCOUT;
  output CARRYOUT;
  output CARRYCASCOUT;
  output [47:0]PCOUT;
  output [26:0]P;
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
  wire [17:0]BCIN;
  wire [17:0]BCOUT;
  wire CARRYCASCIN;
  wire CARRYCASCOUT;
  wire CARRYOUT;
  wire CLK;
  wire [26:0]D;
  wire [26:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;

  (* C_A_WIDTH = "27" *) 
  (* C_B_WIDTH = "18" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_D_WIDTH = "27" *) 
  (* C_HAS_A = "1" *) 
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
  (* C_HAS_D = "1" *) 
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
  (* C_LATENCY = "128" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "110000010000010100001001" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "26" *) 
  (* C_REG_CONFIG = "00000000000010010010000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_dec8fir_48_dspsum_xbip_dsp48_macro_v3_0_17_viv i_synth
       (.A(A),
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
Fx6bn8WK8FNQ2BSKLawvZkEU0RIpTGGQZLErLtzlLtqMV4S0/qbF3w1ZUFrP6+fZA+WiwH8ehvS0
avKjzcm7/7YD0OJFJZn79TWJkmpClpTSj5TcqasDN+deXXpzPVT1XBxPHIpnUyJ3gdU87vcK52Zu
F0DaJGMox/XArrtwTq8GoOOzVfjmMrQyNNDhfADQrvV79auM1t2a4xtwva+//WhGRhSMTxbAKh/5
+aCreHtggK+v/c4U8rMMzMKMTzxmAcwkmxLHaGzg+1/1ZbhF+tgNUNSORIYt8vPlp6faf5IpyZtQ
KmKeXl2ouq/ZAx0AoKa+P01kQST7YOcsvr4vHA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
foljmnCQopl+p7FL65f3i6oA/L/ZTAZfaCjBgQHjLdxltl+VlA7YMXkO6XpbnlRP/+bEnnUDuzha
62vHr6bIQwr0Jq0SNjyrUwYnbzRIjZM29KkMbY9HwbfeQlO5Qchr09pgbhgNQeBJQ8okeOBzpv9q
n6W8Nb8Jb5BysvBOYboxIPGnIjMr+XKzMgwagYdojP39fnAfjnihoYDEm4XJtfqjXaUY9sOnheJf
6UEpXPP/wcC0FVWhlof65wUZyFmrEAQGtcghzXFXhQZAW85yx9uaW0q5VBSOZIt+h5jkALjxGGoy
dFoIykr8HtakyRCH0PJvPWI5LhH3Tpg2zfzDcQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 10224)
`pragma protect data_block
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
fH7hmj84N27/DBsx7jdUjp/pZfEU
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
