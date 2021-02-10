// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Mon Aug 01 13:39:26 2016
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Xilinx/Vivado/2016.2/data/ip/pentek/ip/px_axis_decfir32_1/px_axis_decfir32_1.srcs/sources_1/ip/px_axis_decfir32_acc/px_axis_decfir32_acc_sim_netlist.v
// Design      : px_axis_decfir32_acc
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_axis_decfir32_acc,xbip_dsp48_macro_v3_0_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_12,Vivado 2016.1" *) 
(* NotValidForBitStream *)
module px_axis_decfir32_acc
   (CLK,
    CE,
    SEL,
    PCIN,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) input CE;
  (* x_interface_info = "xilinx.com:signal:data:1.0 sel_intf DATA" *) input [0:0]SEL;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcin_intf DATA" *) input [47:0]PCIN;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) output [47:0]P;

  wire CE;
  wire CLK;
  wire [47:0]P;
  wire [47:0]PCIN;
  wire [0:0]SEL;
  wire NLW_U0_CARRYCASCOUT_UNCONNECTED;
  wire NLW_U0_CARRYOUT_UNCONNECTED;
  wire [29:0]NLW_U0_ACOUT_UNCONNECTED;
  wire [17:0]NLW_U0_BCOUT_UNCONNECTED;
  wire [47:0]NLW_U0_PCOUT_UNCONNECTED;

  (* C_A_WIDTH = "18" *) 
  (* C_B_WIDTH = "18" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_D_WIDTH = "18" *) 
  (* C_HAS_A = "0" *) 
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
  (* C_HAS_D = "0" *) 
  (* C_HAS_INDEP_CE = "0" *) 
  (* C_HAS_INDEP_SCLR = "0" *) 
  (* C_HAS_PCIN = "1" *) 
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
  (* C_OPMODES = "000000000001001000000000,000000000001000000000000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000000000000000000100100" *) 
  (* C_SEL_WIDTH = "1" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* KEEP_HIERARCHY = "true" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_axis_decfir32_acc_xbip_dsp48_macro_v3_0_12 U0
       (.A({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
        .D({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .P(P),
        .PCIN(PCIN),
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
        .SEL(SEL));
endmodule

(* C_A_WIDTH = "18" *) (* C_B_WIDTH = "18" *) (* C_CONCAT_WIDTH = "48" *) 
(* C_CONSTANT_1 = "1" *) (* C_C_WIDTH = "48" *) (* C_D_WIDTH = "18" *) 
(* C_HAS_A = "0" *) (* C_HAS_ACIN = "0" *) (* C_HAS_ACOUT = "0" *) 
(* C_HAS_B = "0" *) (* C_HAS_BCIN = "0" *) (* C_HAS_BCOUT = "0" *) 
(* C_HAS_C = "0" *) (* C_HAS_CARRYCASCIN = "0" *) (* C_HAS_CARRYCASCOUT = "0" *) 
(* C_HAS_CARRYIN = "0" *) (* C_HAS_CARRYOUT = "0" *) (* C_HAS_CE = "1" *) 
(* C_HAS_CEA = "0" *) (* C_HAS_CEB = "0" *) (* C_HAS_CEC = "0" *) 
(* C_HAS_CECONCAT = "0" *) (* C_HAS_CED = "0" *) (* C_HAS_CEM = "0" *) 
(* C_HAS_CEP = "0" *) (* C_HAS_CESEL = "0" *) (* C_HAS_CONCAT = "0" *) 
(* C_HAS_D = "0" *) (* C_HAS_INDEP_CE = "0" *) (* C_HAS_INDEP_SCLR = "0" *) 
(* C_HAS_PCIN = "1" *) (* C_HAS_PCOUT = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SCLRA = "0" *) (* C_HAS_SCLRB = "0" *) (* C_HAS_SCLRC = "0" *) 
(* C_HAS_SCLRCONCAT = "0" *) (* C_HAS_SCLRD = "0" *) (* C_HAS_SCLRM = "0" *) 
(* C_HAS_SCLRP = "0" *) (* C_HAS_SCLRSEL = "0" *) (* C_LATENCY = "128" *) 
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "000000000001001000000000,000000000001000000000000" *) (* C_P_LSB = "0" *) 
(* C_P_MSB = "47" *) (* C_REG_CONFIG = "00000000000000000000000000100100" *) (* C_SEL_WIDTH = "1" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_12" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_axis_decfir32_acc_xbip_dsp48_macro_v3_0_12
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
  wire [47:0]C;
  wire CARRYCASCIN;
  wire CARRYCASCOUT;
  wire CARRYIN;
  wire CARRYOUT;
  wire CE;
  wire CEA;
  wire CEA1;
  wire CEA2;
  wire CEA3;
  wire CEA4;
  wire CEB;
  wire CEB1;
  wire CEB2;
  wire CEB3;
  wire CEB4;
  wire CEC;
  wire CEC1;
  wire CEC2;
  wire CEC3;
  wire CEC4;
  wire CEC5;
  wire CECONCAT;
  wire CECONCAT3;
  wire CECONCAT4;
  wire CECONCAT5;
  wire CED;
  wire CED1;
  wire CED2;
  wire CED3;
  wire CEM;
  wire CEP;
  wire CESEL;
  wire CESEL1;
  wire CESEL2;
  wire CESEL3;
  wire CESEL4;
  wire CESEL5;
  wire CLK;
  wire [47:0]CONCAT;
  wire [17:0]D;
  wire [47:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;
  wire SCLR;
  wire SCLRA;
  wire SCLRB;
  wire SCLRC;
  wire SCLRCONCAT;
  wire SCLRD;
  wire SCLRM;
  wire SCLRP;
  wire SCLRSEL;
  wire [0:0]SEL;

  (* C_A_WIDTH = "18" *) 
  (* C_B_WIDTH = "18" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_D_WIDTH = "18" *) 
  (* C_HAS_A = "0" *) 
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
  (* C_HAS_D = "0" *) 
  (* C_HAS_INDEP_CE = "0" *) 
  (* C_HAS_INDEP_SCLR = "0" *) 
  (* C_HAS_PCIN = "1" *) 
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
  (* C_OPMODES = "000000000001001000000000,000000000001000000000000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000000000000000000100100" *) 
  (* C_SEL_WIDTH = "1" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_axis_decfir32_acc_xbip_dsp48_macro_v3_0_12_viv i_synth
       (.A(A),
        .ACIN(ACIN),
        .ACOUT(ACOUT),
        .B(B),
        .BCIN(BCIN),
        .BCOUT(BCOUT),
        .C(C),
        .CARRYCASCIN(CARRYCASCIN),
        .CARRYCASCOUT(CARRYCASCOUT),
        .CARRYIN(CARRYIN),
        .CARRYOUT(CARRYOUT),
        .CE(CE),
        .CEA(CEA),
        .CEA1(CEA1),
        .CEA2(CEA2),
        .CEA3(CEA3),
        .CEA4(CEA4),
        .CEB(CEB),
        .CEB1(CEB1),
        .CEB2(CEB2),
        .CEB3(CEB3),
        .CEB4(CEB4),
        .CEC(CEC),
        .CEC1(CEC1),
        .CEC2(CEC2),
        .CEC3(CEC3),
        .CEC4(CEC4),
        .CEC5(CEC5),
        .CECONCAT(CECONCAT),
        .CECONCAT3(CECONCAT3),
        .CECONCAT4(CECONCAT4),
        .CECONCAT5(CECONCAT5),
        .CED(CED),
        .CED1(CED1),
        .CED2(CED2),
        .CED3(CED3),
        .CEM(CEM),
        .CEP(CEP),
        .CESEL(CESEL),
        .CESEL1(CESEL1),
        .CESEL2(CESEL2),
        .CESEL3(CESEL3),
        .CESEL4(CESEL4),
        .CESEL5(CESEL5),
        .CLK(CLK),
        .CONCAT(CONCAT),
        .D(D),
        .P(P),
        .PCIN(PCIN),
        .PCOUT(PCOUT),
        .SCLR(SCLR),
        .SCLRA(SCLRA),
        .SCLRB(SCLRB),
        .SCLRC(SCLRC),
        .SCLRCONCAT(SCLRCONCAT),
        .SCLRD(SCLRD),
        .SCLRM(SCLRM),
        .SCLRP(SCLRP),
        .SCLRSEL(SCLRSEL),
        .SEL(SEL));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2014"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
IuVM5cUtmUQKgTBX7HKDmAT1YvCAn3gPWTRIcJbentll9fNGh9qKWzclus07vxZbvEZH49G727Hp
K/1Dcy0Gjg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
pjFrFtabU6Ur8yA8axpBAS/6vABn0s5Akgw0WazBdmxD71+6StDGi/Bx4QL0BkkNNKkDFrDazxt3
IlNaTnzFw1zqKupSfp4yd1jSKCOFfeu3Qgm8mU7TtVTlYJBt32eKWxkirwexrxwAbEg2XW3T0Jek
Yn27OCdgcKdq94aZ08k=

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
mFBaaqTk6WujK6m41XGuotXsDplj3ilnvg4jovrY5HWjDlNf4lZI6BludVXW6DRreoxTQg2lx7qP
06IyzAzT6wbFa/rwHEtllH/B0yvuB4ZPW223Zp8AK64j61t7+tOuZX3qCDNRUleGw8KqS0WmUjmz
9a4cz/51klcPgO1miwM=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
q1x3d5RSu5KDehhgH7qcvqPLNq5cPlzirHId1/D5ljTL1hlPrGSgakTWd4ukrQFWKjS5CA1/gqbN
3w7XBYdSAtEjz7zhcIvAQqj0awdn++yJqRY9r4q77/tWPDo/dsx7Vi/CSjqcM2CpbdHSieE2Rn8t
T+FtAhbxFntvgt4F+XgzXXZWU3Q8NwmgHCnauQaiY9v1Jmh0j+AzrFymmW9bmMaAzylNmXG6qi1p
jrPRltaCAoUrnasCdszukKo+d+LvaCVLm6+diTsVRBT3vogtqBFDCW13sAouxJM+gvWyPxlTHPil
dt4Py1wP2Php8/2AQ0SAKkMskkajvR5QqiLmQw==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
FoVq1Zhjl4mDZCIqBHcehAw005mVLHybVZ9u4ZLn8BYCi/MhJPxgZecQYmqVZ8YBtv+U8tA3ZcIF
lExV/c+rp+VM2Q/j8GTBVFSz8yagdCv+2hP+jluejIPCxVsMiVIEqDpLsX1liRdbWzP2TmEOf7HB
gLvh6PIpzoSvS7uUPxfxTioSnXhDLzQhki7HRLDLB1SMZu6VdBEVoxcvOAKCZz3jd2rZHEqEFw9m
v3Ir5YbUyDuVxIUBezHIBgUws6aLHk9QRZ0vfrEfQwkaudLAcPGmjRqMf4frVvWPB6ZHEMlSqS3L
Oxmj2TotaCom0jcmktsDLCx6RNuvC63Lmhn4IQ==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinx_2016_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
b7aqdpotXnkMc4G/M9sdZ8HR6YofY7osQmQe9KNO0CqX4QxV4I0cZ1/m/dS4Tj5OtH2znt7R5Xrn
DXfQSD/hBpwaA87k8AKlhK/sA9/90l5N32YWIaT0qktjHwSJkNCWsF6N56H3mHWA/O+jPz/GYXmQ
WF6WSWMGZ5nYNw7mnYtCpTUJcdqYLvKhmwLBNnzvoXxfXi2ESD/A5OrxRi4XtQ99o0IRQ3oAU/IM
s0maZLuUWpeLZY2T8f0rGGgEGgjM6WqHeFsRNPfpeaxpTzqOxHz8RHi4t5VaVoLLQaNw9s70xOGb
L+VKDYcq2fsmW532WGSy9hqtkJrubwvPYIOTLQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
JwA3fpj2Gi8wovmATYpGfAZMNz+B9qBHxhfyKQLYPe6TMslYX+iMUPMStYHKUMhNjjLkxeE6sws9
/dX75P1PkxkvQrfExoJ6USpg+9t8U1RRZCiNhe5uyZonrz3MEzLboU190YuIXW8oTNFMZJtLr/Xl
nRhDJO9G/G91WEqs4nbEH7PRtCt1qfKrcUiPTYVQQjmz440qj6qqKjmI4Fld8Vl29ZJVOHKuhXgp
T0ZgfezZyrY6azVWgOoGEIIlwDkpdU6HdmIPCBSnIXmi2OdIHp95JIhaihzzdD8kUj/74jGOdEgZ
ONMGbw83sew5OMWIXb20tN0ZRZyx4rHaxa3aCQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
NJ/mnc6tACmyA/zOQxX86f7SUbDFeuo08BYhhP6hCafgutYXsnJ096pyXjqGb+0BTYAF0aAKioms
DpZH0kF5NT8KTnPsounwEJpM/20Q2YIf/XohJb+QGTAG74rnIHy8/FYZlAo9Y60oFr6zVtDsPaxz
10Lw3G8/FPmjE6iQ2tBR9JLV934hcy+7RbfpDMLfJmqaLwNYu3dT+Xmtj9XMuIgqL66G6rCDbMF9
qjslgcSV6RAEYi9bZPydBoxh9CFhxj9UzRkipiMc1kpffohXRSNXICgL5yUYc8ISX1lhCNpSltR0
sBvMupYXn+oTIlw/O70TJicw+v+EoQAlOKtQ7A==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 9792)
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

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
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
