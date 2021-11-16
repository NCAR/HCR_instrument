// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  8 09:09:04 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_8ch_channelizer_ddc/px_8ch_channelizer_ddc.srcs/sources_1/ip/px_8chddcs3_multadd1/px_8chddcs3_multadd1_sim_netlist.v
// Design      : px_8chddcs3_multadd1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_8chddcs3_multadd1,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_8chddcs3_multadd1
   (CLK,
    A,
    B,
    D,
    PCOUT,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:pcout_intf:carrycascout_intf:carryout_intf:bcout_intf:acout_intf:concat_intf:d_intf:c_intf:b_intf:a_intf:bcin_intf:acin_intf:pcin_intf:carryin_intf:carrycascin_intf:sel_intf, ASSOCIATED_RESET SCLR:SCLRD:SCLRA:SCLRB:SCLRCONCAT:SCLRC:SCLRM:SCLRP:SCLRSEL, ASSOCIATED_CLKEN CE:CED:CED1:CED2:CED3:CEA:CEA1:CEA2:CEA3:CEA4:CEB:CEB1:CEB2:CEB3:CEB4:CECONCAT:CECONCAT3:CECONCAT4:CECONCAT5:CEC:CEC1:CEC2:CEC3:CEC4:CEC5:CEM:CEP:CESEL:CESEL1:CESEL2:CESEL3:CESEL4:CESEL5, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [17:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [17:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 d_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME d_intf, LAYERED_METADATA undef" *) input [17:0]D;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcout_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME pcout_intf, LAYERED_METADATA undef" *) output [47:0]PCOUT;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [35:0]P;

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
  px_8chddcs3_multadd1_xbip_dsp48_macro_v3_0_17 U0
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
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_17" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_8chddcs3_multadd1_xbip_dsp48_macro_v3_0_17
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
  px_8chddcs3_multadd1_xbip_dsp48_macro_v3_0_17_viv i_synth
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
hW1C5AGiZ0IPAlm2TLCMmhF/jaP4915KBnTuNdKgXj1xyHpkH7VSK2ss76zgeLoIAJ1y5QWsS5TU
qfniLy+iry0CL4KUfKRYAfaAEvdmcFmsy81QhQaP63jl+UuGG/c0W4mTnQCb8e1Lj/5vAF7fJRNl
vDvMdPbupGl7N+AfvHPXQE5FDs12J+PCWCpqxry5EL/cqihf7Qxx+QV5wJOd2aSNgeEGeoSPyonG
Isj8SZ6En0011QGxI2+P9Z2R30i/NTyzxfKRm0jekYuicNOTay4Iesc4XtPyxcX8jlm82wwtjMkR
e7DaVNeyE5EBaBTCWiXgidmTIeuyZmUwtwqYYQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
hbbb8kXiqfbAWUUvuZfid6tSjGqWGNqcfdO6mtaYKvUV4Vv6U+KlHfHauzKVL/yMXv4auy3kds/7
yafI9THNHtgPzdfZDBCuLwARkpZYcyGMGF1Kb872QnKbxOaXEwA2mWEvYsaIJ+frL4HKCfVUGaJG
hVE5oQrLg1moIFCjEXfhhCu6CtXNvC8/JMklDwdzZ64PIqcFDMOxabJLggEoxk5C8G+8/bbRwuVp
E7Kxn3sRsM+R7yKvnjlBcbCQGlwKY9aWil5gp/MtDyCXDhoNeji2Kc7OAlGOlMxw87QKMnz9/RPW
jpILGr6oIlIu8MFtns7ESAx+2Ud4oCyDh2Jb2w==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 30672)
`pragma protect data_block
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
+aAdqt9/
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
