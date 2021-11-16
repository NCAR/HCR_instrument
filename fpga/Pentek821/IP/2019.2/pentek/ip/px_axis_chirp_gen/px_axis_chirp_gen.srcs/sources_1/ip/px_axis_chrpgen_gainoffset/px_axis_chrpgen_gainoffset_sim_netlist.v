// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  8 09:53:19 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_axis_chirp_gen/px_axis_chirp_gen.srcs/sources_1/ip/px_axis_chrpgen_gainoffset/px_axis_chrpgen_gainoffset_sim_netlist.v
// Design      : px_axis_chrpgen_gainoffset
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku11p-ffva1156-1-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_axis_chrpgen_gainoffset,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_axis_chrpgen_gainoffset
   (CLK,
    CE,
    A,
    B,
    D,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:pcout_intf:carrycascout_intf:carryout_intf:bcout_intf:acout_intf:concat_intf:d_intf:c_intf:b_intf:a_intf:bcin_intf:acin_intf:pcin_intf:carryin_intf:carrycascin_intf:sel_intf, ASSOCIATED_RESET SCLR:SCLRD:SCLRA:SCLRB:SCLRCONCAT:SCLRC:SCLRM:SCLRP:SCLRSEL, ASSOCIATED_CLKEN CE:CED:CED1:CED2:CED3:CEA:CEA1:CEA2:CEA3:CEA4:CEB:CEB1:CEB2:CEB3:CEB4:CECONCAT:CECONCAT3:CECONCAT4:CECONCAT5:CEC:CEC1:CEC2:CEC3:CEC4:CEC5:CEM:CEP:CESEL:CESEL1:CESEL2:CESEL3:CESEL4:CESEL5, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_LOW" *) input CE;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [15:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [16:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 d_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME d_intf, LAYERED_METADATA undef" *) input [15:0]D;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [17:0]P;

  wire [15:0]A;
  wire [16:0]B;
  wire CE;
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
  (* C_XDEVICEFAMILY = "kintexuplus" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_axis_chrpgen_gainoffset_xbip_dsp48_macro_v3_0_17 U0
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
(* C_HAS_CARRYIN = "0" *) (* C_HAS_CARRYOUT = "0" *) (* C_HAS_CE = "1" *) 
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
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexuplus" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_17" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_axis_chrpgen_gainoffset_xbip_dsp48_macro_v3_0_17
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
  wire CE;
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
  (* C_XDEVICEFAMILY = "kintexuplus" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_axis_chrpgen_gainoffset_xbip_dsp48_macro_v3_0_17_viv i_synth
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
        .CE(CE),
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
JOCNVX2IGczBZCV+7Bszm68Wmn7edDoqb9kvtRIOY06kaEe/woWP+iyFyMmRccMJsjRCi8fP3jEA
W2wjTEe3vfMZIl0Z1cDPTGhzwUU6rA3PbKpZ8yOLjTh3IMkX5j6RyuP+HMOw5kV4RtF9/CQKYhMl
p6UkwHJQOarKh6SxxeVUDWYtkY4MnOcZre2nVjW98XxFd7+ejTp0yFUlH9uhoCp80LEASOpqovn/
OnpLTF7SsO2iF2RztvgRO0zGObMjqoLF1EJ+u9M1SZs6ialnxrVPxSu4SBCPOzBRXKq9FKHZegVC
WwhxpvaYXRmXC4PUoVJmXKavEpU1WYaOT+G5BQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kk2wpdASK+v3xXVs81OCp+bfU2NROJp6MPUBMA6ZjjZNOJ1izkbp3xpMmUoSHkhCTCaLiiXwnZd9
Cu6WGZpuGBdBLIQxFlVad1ow1xRJqQHPIyLCHa7DRHbHLMR5J7HUjRRexuv5RcYUQD5amUWB+3hb
GFBSeGmnyZ0rWb9o27js9jVT8YYsGTK5A3wQ4OSU0OnisY9iH2Su8W/9nGDMtV2UTWf51dMKspSH
+V+Mijoh09R0T4n3jVhUt6kvoh9ZSNZL8/70pEOnN01AuNnbC/YXyNGmj4ocuyrE9RhskohOB0Q8
6YF5sRfcRDgzj0B9KA+ADW8w/Xw3fQQiyLXsRQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 31248)
`pragma protect data_block
+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
UoIbxzxbkW+iV8dZ
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
