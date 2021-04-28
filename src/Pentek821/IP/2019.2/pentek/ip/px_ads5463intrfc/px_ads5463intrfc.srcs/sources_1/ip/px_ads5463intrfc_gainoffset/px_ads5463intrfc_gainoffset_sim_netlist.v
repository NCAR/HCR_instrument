// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  8 09:28:54 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_ads5463intrfc/px_ads5463intrfc.srcs/sources_1/ip/px_ads5463intrfc_gainoffset/px_ads5463intrfc_gainoffset_sim_netlist.v
// Design      : px_ads5463intrfc_gainoffset
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_ads5463intrfc_gainoffset,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_ads5463intrfc_gainoffset
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
  px_ads5463intrfc_gainoffset_xbip_dsp48_macro_v3_0_17 U0
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
module px_ads5463intrfc_gainoffset_xbip_dsp48_macro_v3_0_17
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
  px_ads5463intrfc_gainoffset_xbip_dsp48_macro_v3_0_17_viv i_synth
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
o33/53WqecoPD70NiWyw/hZEV1dq8aqdqdyM6EwqKoosk4M+7xdr9lwdl1fd9nu8mrsYTVkEDqgR
F1/5tgNodxVmhv4ghYxpvmXAZtOh1TrMjqKCPEoub4YHp69nyJqglju596ccPsttTvwjNiDXZ94E
070A6wXxS2H42iPy59l+zk0w2v+/an18LKQHcqEI8L7ElY9842XEKrXS4J9lQRgObgmymjqs2OfB
U0emjCjK6mYl97EYnc2cRPbjkxupc7VCY1VnmvJQ6/tz7GSBUTNXoeNmjxADCejJFAVcfmH4OPTQ
wccV58VK+dOWzQ6qY1Mn5oFdIo7UlCGvuWhLSg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
B+OaYeBVycgJVsNvVEuSs9NBMJCmXwiMu1uMqs3l7haJGVnanjIt8K+BYbCVXZMqeqAVMezGCfPM
sNsKRTV4e84NVP70fPxrIYHXXNlHO8Lf0Ed6g877vo2tZ6R6JzZcmlQpxJDplyDi/z6fBIJ8JUxx
nXA6k+xXj+HU+d15oEAPS7e+mQ0pok9HkxnF5B6cGiU71/m7bWgx089pocttFCx3R/j2+29M1/MI
thJOegjK3e2Xp7q3Pv3GDkpdcka+fo0Ou54AyUqug5ynL4tvokO8LeOnXGdSsn+PtvxA0K+u+t3d
40o1dR+XsLu6yj0VU69d1kMXckznhJr+AD9jLg==

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
