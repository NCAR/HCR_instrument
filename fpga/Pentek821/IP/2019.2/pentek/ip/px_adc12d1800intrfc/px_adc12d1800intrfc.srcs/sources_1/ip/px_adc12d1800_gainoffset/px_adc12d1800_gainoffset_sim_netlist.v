// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  8 09:19:51 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_adc12d1800intrfc/px_adc12d1800intrfc.srcs/sources_1/ip/px_adc12d1800_gainoffset/px_adc12d1800_gainoffset_sim_netlist.v
// Design      : px_adc12d1800_gainoffset
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_adc12d1800_gainoffset,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_adc12d1800_gainoffset
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
  px_adc12d1800_gainoffset_xbip_dsp48_macro_v3_0_17 U0
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
module px_adc12d1800_gainoffset_xbip_dsp48_macro_v3_0_17
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
  px_adc12d1800_gainoffset_xbip_dsp48_macro_v3_0_17_viv i_synth
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
nXWcNPO4FlB4h0IIcyZ7gYLfI0YIRzDO58kaiht+zfqnTaVuBY2EbcorR54u9OgTzGOqMDApP+bY
c3d2DMqUxA4+/y8DQMieKs9sI4PMT6seCk2PRfFIFtcPyVROX0pCSZoh1d2ESpMHZbPJuCZmij5V
MJpiazqpqb7qa7PP7vCjONNZ3RArjCE+psmrOJ5/TwfpWUV0mHgHPIK+7FpOQtIkHdrIrW5FlHmw
o2AdBGjDDCBMPbis6ctKvHbt/rBr8WNJr5SDu/114iB8yX9sdlbnaObd7i/k56v+U0RDp3T3d4Zd
V7cpdscE8QPdt19J6L5LRBE3r36JKr0jSVXoGw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
jg17zNThZoWYyK9iIByqnnYzL3AUdW3F97amc50bU+BQQOpMPOmBqcD+2dYEbtRDXHaXI/MiGhVU
StXaxazih07gIVVlAVZ3152olEY0X6JFUF5DQBM8iGjnk4LLnBlmXAfWvc1Dh5OLPSYGxwTAACwc
VkDkXHR0NyskOQrpzVQskgrh0gcIGGHJnKd+X3bRawYMKa+GQTNLYcm+fDjcfc+x+h1aTbXL5Uxm
tMRyaS6iyOo0GZHR463t9hwk0fk3eLh2askitOeA+PYvlxe78ynKT0i+FtQJi96yaBIuMuEz7Ihl
5gHQmWJ8pqxeWq3xKRhab0jTjED6BvKzfVEW8w==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 31696)
`pragma protect data_block
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
uzSRLQ==
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
