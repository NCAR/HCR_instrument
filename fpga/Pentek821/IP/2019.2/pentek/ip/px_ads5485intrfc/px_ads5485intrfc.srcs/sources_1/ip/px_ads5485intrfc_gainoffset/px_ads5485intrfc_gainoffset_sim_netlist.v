// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  8 09:30:55 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_ads5485intrfc/px_ads5485intrfc.srcs/sources_1/ip/px_ads5485intrfc_gainoffset/px_ads5485intrfc_gainoffset_sim_netlist.v
// Design      : px_ads5485intrfc_gainoffset
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_ads5485intrfc_gainoffset,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_ads5485intrfc_gainoffset
   (CLK,
    A,
    B,
    D,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:pcout_intf:carrycascout_intf:carryout_intf:bcout_intf:acout_intf:concat_intf:d_intf:c_intf:b_intf:a_intf:bcin_intf:acin_intf:pcin_intf:carryin_intf:carrycascin_intf:sel_intf, ASSOCIATED_RESET SCLR:SCLRD:SCLRA:SCLRB:SCLRCONCAT:SCLRC:SCLRM:SCLRP:SCLRSEL, ASSOCIATED_CLKEN CE:CED:CED1:CED2:CED3:CEA:CEA1:CEA2:CEA3:CEA4:CEB:CEB1:CEB2:CEB3:CEB4:CECONCAT:CECONCAT3:CECONCAT4:CECONCAT5:CEC:CEC1:CEC2:CEC3:CEC4:CEC5:CEM:CEP:CESEL:CESEL1:CESEL2:CESEL3:CESEL4:CESEL5, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [15:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [16:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 d_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME d_intf, LAYERED_METADATA undef" *) input [15:0]D;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [17:0]P;

  wire [15:0]A;
  wire [16:0]B;
  wire CLK;
  wire [15:0]D;
  wire [17:0]P;
  wire NLW_U0_CARRYCASCOUT_UNCONNECTED;
  wire NLW_U0_CARRYOUT_UNCONNECTED;
  wire [29:0]NLW_U0_ACOUT_UNCONNECTED;
  wire [17:0]NLW_U0_BCOUT_UNCONNECTED;
  wire [47:0]NLW_U0_PCOUT_UNCONNECTED;

  (* C_A_WIDTH = "16" *) 
  (* C_B_WIDTH = "17" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_D_WIDTH = "16" *) 
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
  (* C_OPMODES = "110000010000010100001000" *) 
  (* C_P_LSB = "15" *) 
  (* C_P_MSB = "32" *) 
  (* C_REG_CONFIG = "00000000000011010011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_ads5485intrfc_gainoffset_xbip_dsp48_macro_v3_0_17 U0
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

(* C_A_WIDTH = "16" *) (* C_B_WIDTH = "17" *) (* C_CONCAT_WIDTH = "48" *) 
(* C_CONSTANT_1 = "1" *) (* C_C_WIDTH = "48" *) (* C_D_WIDTH = "16" *) 
(* C_HAS_A = "1" *) (* C_HAS_ACIN = "0" *) (* C_HAS_ACOUT = "0" *) 
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
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "110000010000010100001000" *) (* C_P_LSB = "15" *) 
(* C_P_MSB = "32" *) (* C_REG_CONFIG = "00000000000011010011000001000100" *) (* C_SEL_WIDTH = "0" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_17" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_ads5485intrfc_gainoffset_xbip_dsp48_macro_v3_0_17
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
  input [15:0]A;
  input [16:0]B;
  input [47:0]C;
  input [15:0]D;
  input [47:0]CONCAT;
  output [29:0]ACOUT;
  output [17:0]BCOUT;
  output CARRYOUT;
  output CARRYCASCOUT;
  output [47:0]PCOUT;
  output [17:0]P;
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

  wire [15:0]A;
  wire [29:0]ACIN;
  wire [29:0]ACOUT;
  wire [16:0]B;
  wire [17:0]BCIN;
  wire [17:0]BCOUT;
  wire CARRYCASCIN;
  wire CARRYCASCOUT;
  wire CARRYIN;
  wire CARRYOUT;
  wire CLK;
  wire [15:0]D;
  wire [17:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;

  (* C_A_WIDTH = "16" *) 
  (* C_B_WIDTH = "17" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_D_WIDTH = "16" *) 
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
  (* C_OPMODES = "110000010000010100001000" *) 
  (* C_P_LSB = "15" *) 
  (* C_P_MSB = "32" *) 
  (* C_REG_CONFIG = "00000000000011010011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_ads5485intrfc_gainoffset_xbip_dsp48_macro_v3_0_17_viv i_synth
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
NlAYarG1MtwkXvrDspxkRhklh+cfhmdVLBOSzwTiDuL2XgvTf7ELRv+k+2y6mr2cMg0SdFiDiERD
cG7E0JhD4iaaHBZyP+RVKjN8yS4shKqM2RKqfCv0l8f8Xmp4n6T+cRkMXtQNN50EF+pdwPkThQTC
SVbXMc9k+gfi9zxyGtV6tcLbTnmHLnuG24ZYLBm61T+xRf2psqipnEyN0sfaucIbhLzOm2KEHhK9
CTcUjLUMhzUpA/sd++zNW5aOj1iBTyVZZ54AYn7i32EQz4BTQWjT+uvz8izpTPo52HaTV7ZTfe04
Ne1rAM3QLQNUVZK3u+B3UO5J7d3ztR5XO4lN+A==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
z9uWj/WgfJGsNzGjeHpxq4lFC3PsGujepjnibrqpw9Wc1Dbm/iqSNGlg+LWbquYYD3iNVYoa1S/i
rLuxa9pR3xC1/neh3Xt0V7GK0IcDVEQF+RnLAvhFJA7NnTaT6OxTeN6kTN08Z/btO5aQkm8ileVV
5uWp3IgzkSMD35ixcartN9vHG+xoxVXwyEGIb+TvAsZH7iDVSduY86CuC8U3sLnSGbBabZNZLhpI
/jG5MhAcAFClCFle+NafLvDkuAxK7SqjcIKgR2txpaSbc/2xQIe7xaUgvNPjwXub2Ka7DXeR1t8f
KRCwcH0IMvo1B50rrdW88aZC+bP05rPOCdSTuA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 31744)
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
