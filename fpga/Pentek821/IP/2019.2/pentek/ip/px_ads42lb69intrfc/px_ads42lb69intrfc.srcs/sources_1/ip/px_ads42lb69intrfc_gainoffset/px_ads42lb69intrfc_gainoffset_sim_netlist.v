// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  8 09:25:20 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_ads42lb69intrfc/px_ads42lb69intrfc.srcs/sources_1/ip/px_ads42lb69intrfc_gainoffset/px_ads42lb69intrfc_gainoffset_sim_netlist.v
// Design      : px_ads42lb69intrfc_gainoffset
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_ads42lb69intrfc_gainoffset,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_ads42lb69intrfc_gainoffset
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
  px_ads42lb69intrfc_gainoffset_xbip_dsp48_macro_v3_0_17 U0
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
module px_ads42lb69intrfc_gainoffset_xbip_dsp48_macro_v3_0_17
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
  px_ads42lb69intrfc_gainoffset_xbip_dsp48_macro_v3_0_17_viv i_synth
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
KClsiuYzf8uIpLlBqHfbHK4EM2+9e7wIH0NqUaVRmCzBbVGODuf/rz0IxVn6EorHeF8qOZT+f835
4TwAzdhK8qR87YH5lVn5VxCi8r9HvaCUSHHQohGC18uq+AYYNDcX+qIyNBW8WdfVplX8bpFoFwty
9j2wc1QcRZ9qeJ4ikTWcIpEy7kdzm2h7ue4JvfJ3nQP53QpHeH+CbchlTI+PxYnuMKp+y3lCEOD8
A2LLQRpV71SwwXhKvjC0tCLcDv9mRQHT3jleapjwqqzWG2w1DBxwBjKsZfjsAMS880+VX6rtx+SX
JSKXPDdj6QOQi4oMWlqUF8YK2Rdzh3KRnI+2Tg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Q+ey/GLh4rDVagNdB/LsMMULZd3WIeLdZZHajMmgpn4vGmNl/cpvXX+ri+a7kAYAwepBGBWvjBE1
AEJcRK438o5UES1Ghw/F9ROZT5s8Cec7WPx9BhKb6Fwb4+584DohyXDIUi+KIQdcT+Uw97OADgck
o/+COEeGuUxkNqjzAdouzUEE43zJGw6UuInY7JIxyd0G+FYj63qF9Tgn11i/NsPCT2rN6tuE00Ys
0knClC2Mumsw3asJmu7sbGaPr1Err8n8GZFi1fFABZY9ROWKSKSVnkt2c25rSKkDNdVMvMn6nhSF
DrkTK/Lf4cjmLe9yNut8JNmED43x1c6z1s1wxQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 31776)
`pragma protect data_block
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
rsJSOO41TD8SYBujMs4UzVYjWW0QTEK6+RoK
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
