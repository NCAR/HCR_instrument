// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  8 19:04:29 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_axis_pwr_meter/px_axis_pwr_meter.srcs/sources_1/ip/px_pwr_meter_dsp48_qsqr/px_pwr_meter_dsp48_qsqr_sim_netlist.v
// Design      : px_pwr_meter_dsp48_qsqr
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_pwr_meter_dsp48_qsqr,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_pwr_meter_dsp48_qsqr
   (CLK,
    PCIN,
    A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:pcout_intf:carrycascout_intf:carryout_intf:bcout_intf:acout_intf:concat_intf:d_intf:c_intf:b_intf:a_intf:bcin_intf:acin_intf:pcin_intf:carryin_intf:carrycascin_intf:sel_intf, ASSOCIATED_RESET SCLR:SCLRD:SCLRA:SCLRB:SCLRCONCAT:SCLRC:SCLRM:SCLRP:SCLRSEL, ASSOCIATED_CLKEN CE:CED:CED1:CED2:CED3:CEA:CEA1:CEA2:CEA3:CEA4:CEB:CEB1:CEB2:CEB3:CEB4:CECONCAT:CECONCAT3:CECONCAT4:CECONCAT5:CEC:CEC1:CEC2:CEC3:CEC4:CEC5:CEM:CEP:CESEL:CESEL1:CESEL2:CESEL3:CESEL4:CESEL5, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcin_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME pcin_intf, LAYERED_METADATA undef" *) input [47:0]PCIN;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [15:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [47:0]P;

  wire [15:0]A;
  wire [15:0]B;
  wire CLK;
  wire [47:0]P;
  wire [47:0]PCIN;
  wire NLW_U0_CARRYCASCOUT_UNCONNECTED;
  wire NLW_U0_CARRYOUT_UNCONNECTED;
  wire [29:0]NLW_U0_ACOUT_UNCONNECTED;
  wire [17:0]NLW_U0_BCOUT_UNCONNECTED;
  wire [47:0]NLW_U0_PCOUT_UNCONNECTED;

  (* C_A_WIDTH = "16" *) 
  (* C_B_WIDTH = "16" *) 
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
  (* C_LATENCY = "-1" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "000000000001010100000000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000011000011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_pwr_meter_dsp48_qsqr_xbip_dsp48_macro_v3_0_17 U0
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
        .SEL(1'b0));
endmodule

(* C_A_WIDTH = "16" *) (* C_B_WIDTH = "16" *) (* C_CONCAT_WIDTH = "48" *) 
(* C_CONSTANT_1 = "1" *) (* C_C_WIDTH = "48" *) (* C_D_WIDTH = "18" *) 
(* C_HAS_A = "1" *) (* C_HAS_ACIN = "0" *) (* C_HAS_ACOUT = "0" *) 
(* C_HAS_B = "1" *) (* C_HAS_BCIN = "0" *) (* C_HAS_BCOUT = "0" *) 
(* C_HAS_C = "0" *) (* C_HAS_CARRYCASCIN = "0" *) (* C_HAS_CARRYCASCOUT = "0" *) 
(* C_HAS_CARRYIN = "0" *) (* C_HAS_CARRYOUT = "0" *) (* C_HAS_CE = "0" *) 
(* C_HAS_CEA = "0" *) (* C_HAS_CEB = "0" *) (* C_HAS_CEC = "0" *) 
(* C_HAS_CECONCAT = "0" *) (* C_HAS_CED = "0" *) (* C_HAS_CEM = "0" *) 
(* C_HAS_CEP = "0" *) (* C_HAS_CESEL = "0" *) (* C_HAS_CONCAT = "0" *) 
(* C_HAS_D = "0" *) (* C_HAS_INDEP_CE = "0" *) (* C_HAS_INDEP_SCLR = "0" *) 
(* C_HAS_PCIN = "1" *) (* C_HAS_PCOUT = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SCLRA = "0" *) (* C_HAS_SCLRB = "0" *) (* C_HAS_SCLRC = "0" *) 
(* C_HAS_SCLRCONCAT = "0" *) (* C_HAS_SCLRD = "0" *) (* C_HAS_SCLRM = "0" *) 
(* C_HAS_SCLRP = "0" *) (* C_HAS_SCLRSEL = "0" *) (* C_LATENCY = "-1" *) 
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "000000000001010100000000" *) (* C_P_LSB = "0" *) 
(* C_P_MSB = "47" *) (* C_REG_CONFIG = "00000000000011000011000001000100" *) (* C_SEL_WIDTH = "0" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_17" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_pwr_meter_dsp48_qsqr_xbip_dsp48_macro_v3_0_17
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
  input [15:0]B;
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

  wire [15:0]A;
  wire [29:0]ACIN;
  wire [29:0]ACOUT;
  wire [15:0]B;
  wire [17:0]BCIN;
  wire [17:0]BCOUT;
  wire CARRYCASCIN;
  wire CARRYCASCOUT;
  wire CARRYIN;
  wire CARRYOUT;
  wire CLK;
  wire [47:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;

  (* C_A_WIDTH = "16" *) 
  (* C_B_WIDTH = "16" *) 
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
  (* C_LATENCY = "-1" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "000000000001010100000000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000011000011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_pwr_meter_dsp48_qsqr_xbip_dsp48_macro_v3_0_17_viv i_synth
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
F4aG9rsOq6oKHwlt/p5/7RjK6bDcpRzkpS2cog2jBfxAj6mAeXwSvMQrceUAvmP/bdU/pQ6SXbWJ
LHwsvUnzpq2pofJCqZYn/4DWeE6F02MyEHfF/7YtcBUK+wHH5S0Mac+lNbStrd0DlupGShEp8j6H
yuZFV2sAMXzSMRsK2K2EE3wdVXjuDpo9poTULxL/2S3id8W+Ag9h293iWzSN3txCkf2wHgeOFZgJ
psxnA3lSMZ6ae4lqDPY9S/z6Iry6H6k6nhG50wLsEkp5pJ0n8Od3FLRjMuswrqSx6Bj114gqFzfT
Xj8oUsf99A9BP9pxQp8/G9huPbl0YmsQStYhQw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
By2VFHk2DZw0jlYBDa8BhBixTUz4MDddClW8BJuiA1j3B3xzxSrdlGbHxnqDm+rV5yJGIu8S+IRO
T/+xGq9rr4t74dN2jY35MtIjtG0vp8prAdSNXUMi3lrTgGA2p+vHxw9gzONo2Az461RYF8M/bxiY
21yBDTujlwgQOXp2TZJLdUTra3QwtVUmls7IeXtCk3HRmLaa5zBK5XdLcT6AEAbzt38+Djz5W8EO
vXfXq562B+qk5qbylAfQL3OFIpk8A7joQvegSeeXVwyOpyA0etQqjj/WptnYdAsNl5RGXFf1uJiU
S6xL+Siw0+xuRqq4+8RaBWTAQv9PIKKTskPA4w==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 30192)
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
