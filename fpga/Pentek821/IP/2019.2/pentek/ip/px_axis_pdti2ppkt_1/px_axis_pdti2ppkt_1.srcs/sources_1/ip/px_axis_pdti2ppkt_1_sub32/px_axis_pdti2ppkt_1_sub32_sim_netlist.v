// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  8 17:57:17 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_axis_pdti2ppkt_1/px_axis_pdti2ppkt_1.srcs/sources_1/ip/px_axis_pdti2ppkt_1_sub32/px_axis_pdti2ppkt_1_sub32_sim_netlist.v
// Design      : px_axis_pdti2ppkt_1_sub32
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_axis_pdti2ppkt_1_sub32,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_axis_pdti2ppkt_1_sub32
   (CLK,
    C,
    CONCAT,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:pcout_intf:carrycascout_intf:carryout_intf:bcout_intf:acout_intf:concat_intf:d_intf:c_intf:b_intf:a_intf:bcin_intf:acin_intf:pcin_intf:carryin_intf:carrycascin_intf:sel_intf, ASSOCIATED_RESET SCLR:SCLRD:SCLRA:SCLRB:SCLRCONCAT:SCLRC:SCLRM:SCLRP:SCLRSEL, ASSOCIATED_CLKEN CE:CED:CED1:CED2:CED3:CEA:CEA1:CEA2:CEA3:CEA4:CEB:CEB1:CEB2:CEB3:CEB4:CECONCAT:CECONCAT3:CECONCAT4:CECONCAT5:CEC:CEC1:CEC2:CEC3:CEC4:CEC5:CEM:CEP:CESEL:CESEL1:CESEL2:CESEL3:CESEL4:CESEL5, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 c_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME c_intf, LAYERED_METADATA undef" *) input [31:0]C;
  (* x_interface_info = "xilinx.com:signal:data:1.0 concat_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME concat_intf, LAYERED_METADATA undef" *) input [31:0]CONCAT;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [32:0]P;

  wire [31:0]C;
  wire CLK;
  wire [31:0]CONCAT;
  wire [32:0]P;
  wire NLW_U0_CARRYCASCOUT_UNCONNECTED;
  wire NLW_U0_CARRYOUT_UNCONNECTED;
  wire [29:0]NLW_U0_ACOUT_UNCONNECTED;
  wire [17:0]NLW_U0_BCOUT_UNCONNECTED;
  wire [47:0]NLW_U0_PCOUT_UNCONNECTED;

  (* C_A_WIDTH = "18" *) 
  (* C_B_WIDTH = "18" *) 
  (* C_CONCAT_WIDTH = "32" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "32" *) 
  (* C_D_WIDTH = "18" *) 
  (* C_HAS_A = "0" *) 
  (* C_HAS_ACIN = "0" *) 
  (* C_HAS_ACOUT = "0" *) 
  (* C_HAS_B = "0" *) 
  (* C_HAS_BCIN = "0" *) 
  (* C_HAS_BCOUT = "0" *) 
  (* C_HAS_C = "1" *) 
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
  (* C_HAS_CONCAT = "1" *) 
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
  (* C_LATENCY = "96" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "000001100011001100000000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "32" *) 
  (* C_REG_CONFIG = "00000000000000000000000000000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_axis_pdti2ppkt_1_sub32_xbip_dsp48_macro_v3_0_17 U0
       (.A({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACOUT(NLW_U0_ACOUT_UNCONNECTED[29:0]),
        .B({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCOUT(NLW_U0_BCOUT_UNCONNECTED[17:0]),
        .C(C),
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
        .CONCAT(CONCAT),
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

(* C_A_WIDTH = "18" *) (* C_B_WIDTH = "18" *) (* C_CONCAT_WIDTH = "32" *) 
(* C_CONSTANT_1 = "1" *) (* C_C_WIDTH = "32" *) (* C_D_WIDTH = "18" *) 
(* C_HAS_A = "0" *) (* C_HAS_ACIN = "0" *) (* C_HAS_ACOUT = "0" *) 
(* C_HAS_B = "0" *) (* C_HAS_BCIN = "0" *) (* C_HAS_BCOUT = "0" *) 
(* C_HAS_C = "1" *) (* C_HAS_CARRYCASCIN = "0" *) (* C_HAS_CARRYCASCOUT = "0" *) 
(* C_HAS_CARRYIN = "0" *) (* C_HAS_CARRYOUT = "0" *) (* C_HAS_CE = "0" *) 
(* C_HAS_CEA = "0" *) (* C_HAS_CEB = "0" *) (* C_HAS_CEC = "0" *) 
(* C_HAS_CECONCAT = "0" *) (* C_HAS_CED = "0" *) (* C_HAS_CEM = "0" *) 
(* C_HAS_CEP = "0" *) (* C_HAS_CESEL = "0" *) (* C_HAS_CONCAT = "1" *) 
(* C_HAS_D = "0" *) (* C_HAS_INDEP_CE = "0" *) (* C_HAS_INDEP_SCLR = "0" *) 
(* C_HAS_PCIN = "0" *) (* C_HAS_PCOUT = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SCLRA = "0" *) (* C_HAS_SCLRB = "0" *) (* C_HAS_SCLRC = "0" *) 
(* C_HAS_SCLRCONCAT = "0" *) (* C_HAS_SCLRD = "0" *) (* C_HAS_SCLRM = "0" *) 
(* C_HAS_SCLRP = "0" *) (* C_HAS_SCLRSEL = "0" *) (* C_LATENCY = "96" *) 
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "000001100011001100000000" *) (* C_P_LSB = "0" *) 
(* C_P_MSB = "32" *) (* C_REG_CONFIG = "00000000000000000000000000000100" *) (* C_SEL_WIDTH = "0" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_17" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_axis_pdti2ppkt_1_sub32_xbip_dsp48_macro_v3_0_17
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
  input [31:0]C;
  input [17:0]D;
  input [31:0]CONCAT;
  output [29:0]ACOUT;
  output [17:0]BCOUT;
  output CARRYOUT;
  output CARRYCASCOUT;
  output [47:0]PCOUT;
  output [32:0]P;
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
  wire [17:0]BCIN;
  wire [17:0]BCOUT;
  wire [31:0]C;
  wire CARRYCASCIN;
  wire CARRYCASCOUT;
  wire CARRYOUT;
  wire CLK;
  wire [31:0]CONCAT;
  wire [32:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;

  (* C_A_WIDTH = "18" *) 
  (* C_B_WIDTH = "18" *) 
  (* C_CONCAT_WIDTH = "32" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "32" *) 
  (* C_D_WIDTH = "18" *) 
  (* C_HAS_A = "0" *) 
  (* C_HAS_ACIN = "0" *) 
  (* C_HAS_ACOUT = "0" *) 
  (* C_HAS_B = "0" *) 
  (* C_HAS_BCIN = "0" *) 
  (* C_HAS_BCOUT = "0" *) 
  (* C_HAS_C = "1" *) 
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
  (* C_HAS_CONCAT = "1" *) 
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
  (* C_LATENCY = "96" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "000001100011001100000000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "32" *) 
  (* C_REG_CONFIG = "00000000000000000000000000000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_axis_pdti2ppkt_1_sub32_xbip_dsp48_macro_v3_0_17_viv i_synth
       (.A({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACIN(ACIN),
        .ACOUT(ACOUT),
        .B({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCIN(BCIN),
        .BCOUT(BCOUT),
        .C(C),
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
        .CONCAT(CONCAT),
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
k6ImJ0L1RBkeNn9lNlJldm0xi+J8qubiC+2hvxjat4zVJHXGoclGmbramVo7baDI1bK8yuXTDQmy
jvmSFcY1blvzzZPEx7+FYXIpix4BtweUISP/2rs0YrVsJ7/ED5oa1OK6/Qi89FpgGEC+Rfpj+yck
SrCvWk0/99Fop1U3qRzswtqabidIB3GePgtdMncUCf3KdVhU7zw55pbXG8IIkWhkchjEce2/o9HO
XTyVf6gx1o4EJPjT0A660d8a4pyLNqURdiL0KhPXeualMImuYV5PyrDlAePUNU+E6M/sjIlcxNAz
xzyxnt57iuDULtxRmS+O16Fap6U8Z8bybizd7g==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
CR8zb9MNSUSPfoI3d40tmgkDRwxjpsFqIhgQ3zSJrp7BuO2/qy60GY7rjrObXzoOm3MWx0ncbnOU
AhwTiqW2B52VyiS5D4/V1BxhKGYzC6FnaY5NZgPVg72NTLiWfDkc51bykCLHW0r3WRUqZUe/BhQT
84L8zJeJroUJIQcXVf+n48hsr9mSEcq5eKBmZTSGlJ3a/3zPMq7q7LyJxV32Iko141gp7QJnF7hK
lwA7994zheeqySlnkNlLc3RyIEObQ8Dq3dV8wEzZ5PCHH7VKwGGo00h2QRbMDPWbyitGIpAy0zJy
90GPlh9FoPb5n5adM0IhORKOb9UzYFDnVYFzew==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 10192)
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
