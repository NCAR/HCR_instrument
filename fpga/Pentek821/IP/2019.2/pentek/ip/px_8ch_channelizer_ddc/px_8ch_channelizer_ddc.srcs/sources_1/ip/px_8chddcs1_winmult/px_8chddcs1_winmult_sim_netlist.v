// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  8 09:03:17 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_8ch_channelizer_ddc/px_8ch_channelizer_ddc.srcs/sources_1/ip/px_8chddcs1_winmult/px_8chddcs1_winmult_sim_netlist.v
// Design      : px_8chddcs1_winmult
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_8chddcs1_winmult,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_8chddcs1_winmult
   (CLK,
    B,
    D,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:pcout_intf:carrycascout_intf:carryout_intf:bcout_intf:acout_intf:concat_intf:d_intf:c_intf:b_intf:a_intf:bcin_intf:acin_intf:pcin_intf:carryin_intf:carrycascin_intf:sel_intf, ASSOCIATED_RESET SCLR:SCLRD:SCLRA:SCLRB:SCLRCONCAT:SCLRC:SCLRM:SCLRP:SCLRSEL, ASSOCIATED_CLKEN CE:CED:CED1:CED2:CED3:CEA:CEA1:CEA2:CEA3:CEA4:CEB:CEB1:CEB2:CEB3:CEB4:CECONCAT:CECONCAT3:CECONCAT4:CECONCAT5:CEC:CEC1:CEC2:CEC3:CEC4:CEC5:CEM:CEP:CESEL:CESEL1:CESEL2:CESEL3:CESEL4:CESEL5, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 d_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME d_intf, LAYERED_METADATA undef" *) input [17:0]D;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [16:0]P;

  wire [15:0]B;
  wire CLK;
  wire [17:0]D;
  wire [16:0]P;
  wire NLW_U0_CARRYCASCOUT_UNCONNECTED;
  wire NLW_U0_CARRYOUT_UNCONNECTED;
  wire [29:0]NLW_U0_ACOUT_UNCONNECTED;
  wire [17:0]NLW_U0_BCOUT_UNCONNECTED;
  wire [47:0]NLW_U0_PCOUT_UNCONNECTED;

  (* C_A_WIDTH = "18" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_D_WIDTH = "18" *) 
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
  (* C_LATENCY = "-1" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "110000010000010100011100" *) 
  (* C_P_LSB = "17" *) 
  (* C_P_MSB = "33" *) 
  (* C_REG_CONFIG = "00000000000001010011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_8chddcs1_winmult_xbip_dsp48_macro_v3_0_17 U0
       (.A({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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

(* C_A_WIDTH = "18" *) (* C_B_WIDTH = "16" *) (* C_CONCAT_WIDTH = "48" *) 
(* C_CONSTANT_1 = "1" *) (* C_C_WIDTH = "48" *) (* C_D_WIDTH = "18" *) 
(* C_HAS_A = "0" *) (* C_HAS_ACIN = "0" *) (* C_HAS_ACOUT = "0" *) 
(* C_HAS_B = "1" *) (* C_HAS_BCIN = "0" *) (* C_HAS_BCOUT = "0" *) 
(* C_HAS_C = "0" *) (* C_HAS_CARRYCASCIN = "0" *) (* C_HAS_CARRYCASCOUT = "0" *) 
(* C_HAS_CARRYIN = "0" *) (* C_HAS_CARRYOUT = "0" *) (* C_HAS_CE = "0" *) 
(* C_HAS_CEA = "0" *) (* C_HAS_CEB = "0" *) (* C_HAS_CEC = "0" *) 
(* C_HAS_CECONCAT = "0" *) (* C_HAS_CED = "0" *) (* C_HAS_CEM = "0" *) 
(* C_HAS_CEP = "0" *) (* C_HAS_CESEL = "0" *) (* C_HAS_CONCAT = "0" *) 
(* C_HAS_D = "1" *) (* C_HAS_INDEP_CE = "0" *) (* C_HAS_INDEP_SCLR = "0" *) 
(* C_HAS_PCIN = "0" *) (* C_HAS_PCOUT = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SCLRA = "0" *) (* C_HAS_SCLRB = "0" *) (* C_HAS_SCLRC = "0" *) 
(* C_HAS_SCLRCONCAT = "0" *) (* C_HAS_SCLRD = "0" *) (* C_HAS_SCLRM = "0" *) 
(* C_HAS_SCLRP = "0" *) (* C_HAS_SCLRSEL = "0" *) (* C_LATENCY = "-1" *) 
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "110000010000010100011100" *) (* C_P_LSB = "17" *) 
(* C_P_MSB = "33" *) (* C_REG_CONFIG = "00000000000001010011000001000100" *) (* C_SEL_WIDTH = "0" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_17" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_8chddcs1_winmult_xbip_dsp48_macro_v3_0_17
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
  input [17:0]A;
  input [15:0]B;
  input [47:0]C;
  input [17:0]D;
  input [47:0]CONCAT;
  output [29:0]ACOUT;
  output [17:0]BCOUT;
  output CARRYOUT;
  output CARRYCASCOUT;
  output [47:0]PCOUT;
  output [16:0]P;
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
  wire CLK;
  wire [17:0]D;
  wire [16:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;

  (* C_A_WIDTH = "18" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_D_WIDTH = "18" *) 
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
  (* C_LATENCY = "-1" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "110000010000010100011100" *) 
  (* C_P_LSB = "17" *) 
  (* C_P_MSB = "33" *) 
  (* C_REG_CONFIG = "00000000000001010011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_8chddcs1_winmult_xbip_dsp48_macro_v3_0_17_viv i_synth
       (.A({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
iyHSaM6Ol5liY7rLJppCJ4e6aCLK5IUgGS13yl4cPXeNZxLr+r8QaHV5ZeHq71RmKI7nLrHlwb2v
AXNOoSSDkjC26bcV1+NcgTTgtLrbuDyle0/YNWtl2J4Fw8yKCs/3J1UTl8R1rhjLshUKE1OLJOmh
Pcb0dsblYKfUKqZtgSw77wh3dBOBBKB5w8pH2AE5VDtQEG/rZiD4u9cHT6OsSK1uy1fWSmWTV3LH
drlwuc5kj79+sjU/cJX2jKojjkIEQcDOaI6dIb7HVBnvMWvDbCnkGOKWWQJtwXh4GLQQFw+/a/bn
WYW4vvYIsFPtF1bZP6hPBSdyip3/dV4YUvtjFQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
OOj0kkpWxWA52LM0LdyQhNpYiYnBa09SQ2bozAxcP4fnA4FvPynT7NyufYhK4LFzldh+oJ0FffCx
U6K3rr/C3qpVXNDxfi4D95DHhuw6eeQviSPUy74EF1OiU5ciMlfg0PROHJrtnt8M090dd2+jMvFy
XedV7Xhh4tRPrtXSqZ+40f+7aS+ezI9ZDId0yvh3M/lK1pPT7p2tO8DdpXsR9LHl4Nei63szd8bd
uP7orCQXZMloMFL3MpBruxwbkr88c5mJUSapoCX6jXtoextlStMZctH/lOrnxwokZNQrAawyKeRj
wkMBY7JosG2tgPOm6P3XlKiOjaGYq62TPFtXkQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 31600)
`pragma protect data_block
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
bVbIkTs0/tJk0geByJdbwpCiPRNzcg==
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
