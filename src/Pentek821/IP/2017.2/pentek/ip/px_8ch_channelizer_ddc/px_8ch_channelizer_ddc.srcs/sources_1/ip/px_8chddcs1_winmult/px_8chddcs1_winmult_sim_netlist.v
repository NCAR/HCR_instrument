// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
// Date        : Fri May 12 11:01:11 2017
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2017.1/wip/px_8ch_channelizer_ddc/px_8ch_channelizer_ddc.srcs/sources_1/ip/px_8chddcs1_winmult/px_8chddcs1_winmult_sim_netlist.v
// Design      : px_8chddcs1_winmult
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_8chddcs1_winmult,xbip_dsp48_macro_v3_0_14,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_14,Vivado 2017.1" *) 
(* NotValidForBitStream *)
module px_8chddcs1_winmult
   (CLK,
    B,
    D,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 d_intf DATA" *) input [17:0]D;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) output [16:0]P;

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
  px_8chddcs1_winmult_xbip_dsp48_macro_v3_0_14 U0
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
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_14" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_8chddcs1_winmult_xbip_dsp48_macro_v3_0_14
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
  px_8chddcs1_winmult_xbip_dsp48_macro_v3_0_14_viv i_synth
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
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
OMrdsrRpEttWODluC0AG3g/S5UKDr70bMwdgbqGF2RcL3xQFKYSyWp8fy2bHCB0EwAyCuxzOK/Q4
6r+SZfIUdA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
k2s7EWMhwIf9qGlEYH6Z9DmMZaK4vgWvIZZQxDcKCuHnkjHbD4/U7j76EMOamepLlmmJnKhUAdRO
dc+uAzJqa3NzMdAPJFre2fJTMQMEWzu/4dgityBiSUTOj+K+5pEFBnHCWSnQ5UzqFIY1yOb2/YZD
IG6YTCJbciIYaWhqK9s=

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
aILjgC2GmUyiU4AsUQ07DWXQjEHi3V5qONJrWxkXz62EwqxUiX7OkROoeH9DhNSRuL+w/JovcdHp
AnOkZd9mV20DGVARKPB0eQfKRK0AWUhYPWUtiiWeRu8Z+7BUxCklK5emK5hmSewVxkSJFo0so5mo
/3ixidv16V3WOQkjFJ0=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
f+rdl3qbw8Vh2sCsDZzrVbRhJv2vRjOjuOu9zad0VWeE/e0Kmt5X3+pZuwP1ihdaCNr0JAv3T12B
BeKSWuge5Jn1lRRnMDmqWo3VK/WtHWjPLg77Ld95Cw/UnVXF1nR8KwOwf1TsfRJJ90g2LFlsFCsO
htIB5UnYmtD/jtJQ7rqrR0vF5Ld08rcqInLs3GGqZDfE0y6HY1xbFDFdv2mHJmwV2wNo5H6ajr92
oLgFQJdGC14cOlecPHiyWr5oN06TlRrVu09xv57BRAuANqqr01cY4Hi1738LtV5zMIVnYvAgn7C1
n2jLIBA/dB+md2J//8MNc6k4rbbYTPpAbsJtvg==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
HIRSbdFYfaAF5GWQP4bTR1MpBjfvtA2Z+pbC6p3lNvvLlskzokTZ36tImVNUOW1pfCk899YaeKwq
TTiJDjb4JbOTrC9mCN1hx8O6tnLsEAYOGznzptkEtOSTHT9CyvXvtK11ZA5BmUsjolGm8yaYHIEo
UOS5B+SJRFWTGrho8hQ1WIDzGNytXdeuN+o4EUgHODMSlLFJSNdTZ0ne2PNM0dHMuiaGZQ9fsQo+
Y37J7Y+G9kPvZqUMJ9UyOGHZKySEPKY01qYx50ZsDjRXMKAI+B9AxUEB0IAl23nhNntbxobSir3F
rxd22+M0inY3utkXvyZJIFPfywY8ztrZOCDPlw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinx_2016_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ltl0Tbg4fzfpcs5GkvjMeLedXpUr19ejb9G7kWMD8rRS1iPgypVcWiB2sDOnc2uWRfwgbvUtcLc6
QKoNQ7c7VYrt28FZQhVBJuhX8D6ipRuXrRhdRnNcY4d2SovB/6tZxv2U9LOTtPhivmr5egDbBE6Y
E3IkK7PsH1klzQySamoislPGqjg/NSgSWMDtjcSofaE7bKNbmUozSGqkROvv4uMmWcGd0wXrSd/1
YYlP/rPsSMe+OTsGDGElMp3uovABUt2G5v2eUUr586WGPnynPC4UYifriLnU7cAuyNfM/OI+oOe4
BBF66x/+pBsG0h2FnbXpUvNTUnqAl+APQ8CA7Q==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
HuzyugejrpOGIULo4vQV/l6AO9lEg87eJ/7HWXgph0Qtv0TydJNHDu29SCxj2mKlYQWIQozJIgEk
W//iEZpva/XmFdKIA4f1m0aiEiz9gZx2z+PmR2cDq/M7T/kj8cb/nuTnlvOQdEKkJH8Dazl3gFZo
8Z7AUJJX7Am4CQb6Pf8iIs6/t9RqiBa2Gp0tAY6U9xgE4NmTFhfKvu0ThVtSvCxNY97r3o4vt3aA
LrmiXSI9Al7zWN2P2CYixVepzlCEb4NRVNu385hYqw3VTUObOqw6tQgsKJxCCJqQD0wU0qBZEm3e
OD28q7cNzAnVj3uq/IrxxIfGDtRRwZUohyGvnQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
GIq4m1GL1Y1dJlUbhZ0honBxpU3kvGvTe5yhu+Yttb562gFEq2T96xszeXBSNu0/JoeisLU3n2m+
OGBkPcXT0Nf0YAV21UipiVLJS1kXOQUdZpgYWhwVuejOn+ANkhL9h+SpHlhdmkh2ohYP56Lu9to9
JVOdhpT1T6AidTPvaSJIk6DtivJYO5SLvGwOt8r5laEVzot+uYOy84HYHznE4HnOrEYAIs/FJWoI
lJ7Rhr5gs0n2xY7sunuVePeV6IXIFpg40zsC8luYmMKWhXSRvplPYqKTWB9w422vmLYAnmZKxcKc
rOQ2CH2sSHMQTYg5IIBG4DXEIRJk9gsnQaVARQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 31936)
`pragma protect data_block
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
df/YWgxA2uiRlQ0PclbKCQ==
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
