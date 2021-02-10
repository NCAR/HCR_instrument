// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
// Date        : Wed May 17 12:31:42 2017
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2017.1/wip/px_8ch_channelizer_ddc/px_8ch_channelizer_ddc.srcs/sources_1/ip/px_8chddcs3_multadd/px_8chddcs3_multadd_sim_netlist.v
// Design      : px_8chddcs3_multadd
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_8chddcs3_multadd,xbip_dsp48_macro_v3_0_14,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_14,Vivado 2017.1" *) 
(* NotValidForBitStream *)
module px_8chddcs3_multadd
   (CLK,
    PCIN,
    A,
    B,
    D,
    PCOUT,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcin_intf DATA" *) input [47:0]PCIN;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) input [17:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) input [17:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 d_intf DATA" *) input [17:0]D;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcout_intf DATA" *) output [47:0]PCOUT;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) output [47:0]P;

  wire [17:0]A;
  wire [17:0]B;
  wire CLK;
  wire [17:0]D;
  wire [47:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;
  wire NLW_U0_CARRYCASCOUT_UNCONNECTED;
  wire NLW_U0_CARRYOUT_UNCONNECTED;
  wire [29:0]NLW_U0_ACOUT_UNCONNECTED;
  wire [17:0]NLW_U0_BCOUT_UNCONNECTED;

  (* C_A_WIDTH = "18" *) 
  (* C_B_WIDTH = "18" *) 
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
  (* C_OPMODES = "000000000001010100001000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000011010011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_8chddcs3_multadd_xbip_dsp48_macro_v3_0_14 U0
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

(* C_A_WIDTH = "18" *) (* C_B_WIDTH = "18" *) (* C_CONCAT_WIDTH = "48" *) 
(* C_CONSTANT_1 = "1" *) (* C_C_WIDTH = "48" *) (* C_D_WIDTH = "18" *) 
(* C_HAS_A = "1" *) (* C_HAS_ACIN = "0" *) (* C_HAS_ACOUT = "0" *) 
(* C_HAS_B = "1" *) (* C_HAS_BCIN = "0" *) (* C_HAS_BCOUT = "0" *) 
(* C_HAS_C = "0" *) (* C_HAS_CARRYCASCIN = "0" *) (* C_HAS_CARRYCASCOUT = "0" *) 
(* C_HAS_CARRYIN = "0" *) (* C_HAS_CARRYOUT = "0" *) (* C_HAS_CE = "0" *) 
(* C_HAS_CEA = "0" *) (* C_HAS_CEB = "0" *) (* C_HAS_CEC = "0" *) 
(* C_HAS_CECONCAT = "0" *) (* C_HAS_CED = "0" *) (* C_HAS_CEM = "0" *) 
(* C_HAS_CEP = "0" *) (* C_HAS_CESEL = "0" *) (* C_HAS_CONCAT = "0" *) 
(* C_HAS_D = "1" *) (* C_HAS_INDEP_CE = "0" *) (* C_HAS_INDEP_SCLR = "0" *) 
(* C_HAS_PCIN = "1" *) (* C_HAS_PCOUT = "1" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SCLRA = "0" *) (* C_HAS_SCLRB = "0" *) (* C_HAS_SCLRC = "0" *) 
(* C_HAS_SCLRCONCAT = "0" *) (* C_HAS_SCLRD = "0" *) (* C_HAS_SCLRM = "0" *) 
(* C_HAS_SCLRP = "0" *) (* C_HAS_SCLRSEL = "0" *) (* C_LATENCY = "-1" *) 
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "000000000001010100001000" *) (* C_P_LSB = "0" *) 
(* C_P_MSB = "47" *) (* C_REG_CONFIG = "00000000000011010011000001000100" *) (* C_SEL_WIDTH = "0" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_14" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_8chddcs3_multadd_xbip_dsp48_macro_v3_0_14
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
  input [17:0]B;
  input [47:0]C;
  input [17:0]D;
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

  wire [17:0]A;
  wire [29:0]ACIN;
  wire [29:0]ACOUT;
  wire [17:0]B;
  wire [17:0]BCIN;
  wire [17:0]BCOUT;
  wire CARRYCASCIN;
  wire CARRYCASCOUT;
  wire CARRYIN;
  wire CARRYOUT;
  wire CLK;
  wire [17:0]D;
  wire [47:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;

  (* C_A_WIDTH = "18" *) 
  (* C_B_WIDTH = "18" *) 
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
  (* C_OPMODES = "000000000001010100001000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000011010011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_8chddcs3_multadd_xbip_dsp48_macro_v3_0_14_viv i_synth
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
WlyojaJblNeGO1cssVKhxdCl/lLH+GY0ybSdrG/vDK2uzxsJogPwi/MjPqVzRAJSPXN1p1n55Pts
UPLsd5aecxuJvgDXT1Ff+7nnRw1FBCX/L0atBWbEHHxSP2nZIj2xeutPXF3PruiwnqrgAwX9UBjQ
cnnBcQUjnDdK76W0o4kI0M/727QqGyYuZsGh7IU+bI1U8uRGRy7KAlNymxzSq0hvzUJ+jFnDT8nj
lk+qblGlEfKxGqGiPm7mvhE6IMjfzX0YNF+/9Q60RUGpo+nRK1hWi0H3J9Z8Du9+aezNXvoF7PbL
P+V66Wlmo1NzHd8pjTAGAYtYDfgHOKIrVp2AFg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
Uvu2yw/sTPSBo3N44b5ashH6iBnHCc7/yI19tg4t6b9vnMKX0JTUgW4ofWeCYPUYjunPmppqrXs4
wWnmgPXagnsicvcZy2IJONvSrCfezcRwadrZJJh9mni7Q3exEfLqwAE0OJsFKbX+DhfKJlIpDi5g
dfZJGUJRezCx+9nTUND6dDnbFVepsX2BAFHY0LAxWAjIOBLS3aJqb3uGO5vDVvcPPWtefnxM54fj
xN7GRbfgFxliGprUF8wZ+6UiXNwM8DBA/RAftNQJfbih10oaEwQJKzetFDoC65PkyxdgE+cGoNW1
1oTfpIW1aWSbYWad/6mKwzLkE1CPCFmLjJfm0g==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 30320)
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
