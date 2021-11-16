// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Tue Jun 11 12:35:30 2019
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_ads54j69intrfc/px_ads54j69intrfc.srcs/sources_1/ip/px_ads54j69intrfc_gainoffset/px_ads54j69intrfc_gainoffset_sim_netlist.v
// Design      : px_ads54j69intrfc_gainoffset
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_ads54j69intrfc_gainoffset,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_ads54j69intrfc_gainoffset
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
  px_ads54j69intrfc_gainoffset_xbip_dsp48_macro_v3_0_17 U0
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
module px_ads54j69intrfc_gainoffset_xbip_dsp48_macro_v3_0_17
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
  px_ads54j69intrfc_gainoffset_xbip_dsp48_macro_v3_0_17_viv i_synth
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
N0hHCtAyYq59XbOGP1Ar+qm0pRLzObBVE5m/0FZM0mL0Y9TPETkI+RgZUnE6rUCT5B//WEoyNda1
jE0VLP0c2AKUusHDwLDDuUvONOFKEiPdGi1VM5Ex6/CB3tTmDvSrbQ3a83PP/f6kQyUp6JXSCmzC
KoWnmbOepo/VUVPE1FvkgS9Lm1/G5QQkiSVYNhrqxYRTi9CfDg/uWVhweS7K2a3bA28uokikZ0Km
05qPcFwwjjo+bEy9u3oPMC/oz+mzCLgJR4sQJ0yRR4OzCBGXCMeQNrPvOSTvPg9f44NBvv0PYi+9
9JdRVYdpbHzKrdR3R/ClNHwBag/bDP0H85kyiw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
b0EXgQPNLL3wWVgJhJyATNdTOqJx8nMJhhLH3xQwAKvMq3HsF+nr/v8MLP2Pt21wV8OTYNW82kY3
DJiQHt0X5AF5Ztz5s/WUj4BU8x66SIaybsop4xQN1SLLfL6Oigy8t1gSOiWkHIN1Hwxog+IQWEXJ
on8e2QNhrmdNOSNbkzSqRK+1Bfly95hbwvK2n5iD2T3ttMhdS+ogvaZv/VD+DV0ZI0Ws9nj9USRI
GC+etqclJhZ0IALBBK0mKyKSrKXjQSqtnpo62MeqzHkUjuh+ecNDjs3tuKRCrZLHNJmUDszSJE8S
c82CHNBi+Y/z454k79L2gsWl56jpw3lbCRQipw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 31760)
`pragma protect data_block
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
WTsIOKpj8/dyvVw=
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
