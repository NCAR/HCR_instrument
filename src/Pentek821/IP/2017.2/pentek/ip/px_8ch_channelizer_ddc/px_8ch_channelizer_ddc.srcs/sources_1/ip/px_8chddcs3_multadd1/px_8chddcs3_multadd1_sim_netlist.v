// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
// Date        : Wed May 17 12:31:42 2017
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2017.1/wip/px_8ch_channelizer_ddc/px_8ch_channelizer_ddc.srcs/sources_1/ip/px_8chddcs3_multadd1/px_8chddcs3_multadd1_sim_netlist.v
// Design      : px_8chddcs3_multadd1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_8chddcs3_multadd1,xbip_dsp48_macro_v3_0_14,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_14,Vivado 2017.1" *) 
(* NotValidForBitStream *)
module px_8chddcs3_multadd1
   (CLK,
    A,
    B,
    D,
    PCOUT,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) input [17:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) input [17:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 d_intf DATA" *) input [17:0]D;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcout_intf DATA" *) output [47:0]PCOUT;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) output [35:0]P;

  wire [17:0]A;
  wire [17:0]B;
  wire CLK;
  wire [17:0]D;
  wire [35:0]P;
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
  (* C_OPMODES = "000100100000010100001000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "35" *) 
  (* C_REG_CONFIG = "00000000000011010011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_8chddcs3_multadd1_xbip_dsp48_macro_v3_0_14 U0
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
(* C_HAS_PCIN = "0" *) (* C_HAS_PCOUT = "1" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SCLRA = "0" *) (* C_HAS_SCLRB = "0" *) (* C_HAS_SCLRC = "0" *) 
(* C_HAS_SCLRCONCAT = "0" *) (* C_HAS_SCLRD = "0" *) (* C_HAS_SCLRM = "0" *) 
(* C_HAS_SCLRP = "0" *) (* C_HAS_SCLRSEL = "0" *) (* C_LATENCY = "-1" *) 
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "000100100000010100001000" *) (* C_P_LSB = "0" *) 
(* C_P_MSB = "35" *) (* C_REG_CONFIG = "00000000000011010011000001000100" *) (* C_SEL_WIDTH = "0" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_14" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_8chddcs3_multadd1_xbip_dsp48_macro_v3_0_14
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
  output [35:0]P;
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
  wire [35:0]P;
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
  (* C_OPMODES = "000100100000010100001000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "35" *) 
  (* C_REG_CONFIG = "00000000000011010011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_8chddcs3_multadd1_xbip_dsp48_macro_v3_0_14_viv i_synth
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
cO7Nv6+jmgxfcMFRQ4uFOEgkWjKil9a2cQGzY+EYdHE9In/L+81i289wwLUBQ/5qAe4LMGwED11+
/l+kRcEqHotXkspyrvItTvleZa7q0+YbYnY7qPkBZByMxk3WSoL+7S4rsDbdWTOxcHEyHZdeocJe
k8aSF7GWrLqAwgGUo+Tihe1TpMIpDKrrOdl77PfBY8SyaC199uVewoBBePSfHXh7ux7O5wjWaQVO
nuMMracPJ2scoTnnjYkMSEjPiv9nZhzNc3p22E4TowHipDcG6+lNTH+7HaseayKGVNg1oOIoOKqi
2nP5spabARQkaDtcAbUkdtGKHeg3NobQqwAamA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
hcRDCKDliQb+71D1/9sRC8YRph5sPJyz7bHwbjVT5/tRgF63TaJEnQUtl85T0ZUP2CmYBIjRIvex
US4ya7Z6fNhLtgfKEaifaeV1eycteBAK9+xrXjJ63kdQc+cW/j8/zdTX0d6daes2ldxdSVzdn5CC
fgI/zknV7vLo6T6oiRKDvkgWJEb5W2iwC6RzFmcMOjKLM1hKkagChxGwfNn23AK3ptdPrGZxJ9lm
h06viViRkOC/l5p4OAyO9q5MN5ymIOmY67eIZhWW7Fzf8YVXaoaR3eN6uJO75+MDmETedTRhcPuh
EFzEyd6CKImMx1Df5dnZjn9U3z4+sXwVmQoapw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 30832)
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
