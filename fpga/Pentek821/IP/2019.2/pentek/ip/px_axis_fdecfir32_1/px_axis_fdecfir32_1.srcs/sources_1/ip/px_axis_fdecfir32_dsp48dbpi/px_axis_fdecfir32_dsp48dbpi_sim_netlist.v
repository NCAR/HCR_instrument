// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  8 10:39:53 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_axis_fdecfir32_1/px_axis_fdecfir32_1.srcs/sources_1/ip/px_axis_fdecfir32_dsp48dbpi/px_axis_fdecfir32_dsp48dbpi_sim_netlist.v
// Design      : px_axis_fdecfir32_dsp48dbpi
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_axis_fdecfir32_dsp48dbpi,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_axis_fdecfir32_dsp48dbpi
   (CLK,
    CE,
    PCIN,
    A,
    B,
    D,
    PCOUT,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:pcout_intf:carrycascout_intf:carryout_intf:bcout_intf:acout_intf:concat_intf:d_intf:c_intf:b_intf:a_intf:bcin_intf:acin_intf:pcin_intf:carryin_intf:carrycascin_intf:sel_intf, ASSOCIATED_RESET SCLR:SCLRD:SCLRA:SCLRB:SCLRCONCAT:SCLRC:SCLRM:SCLRP:SCLRSEL, ASSOCIATED_CLKEN CE:CED:CED1:CED2:CED3:CEA:CEA1:CEA2:CEA3:CEA4:CEB:CEB1:CEB2:CEB3:CEB4:CECONCAT:CECONCAT3:CECONCAT4:CECONCAT5:CEC:CEC1:CEC2:CEC3:CEC4:CEC5:CEM:CEP:CESEL:CESEL1:CESEL2:CESEL3:CESEL4:CESEL5, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_LOW" *) input CE;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcin_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME pcin_intf, LAYERED_METADATA undef" *) input [47:0]PCIN;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [15:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [17:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 d_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME d_intf, LAYERED_METADATA undef" *) input [15:0]D;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcout_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME pcout_intf, LAYERED_METADATA undef" *) output [47:0]PCOUT;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [47:0]P;

  wire [15:0]A;
  wire [17:0]B;
  wire CE;
  wire CLK;
  wire [15:0]D;
  wire [47:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;
  wire NLW_U0_CARRYCASCOUT_UNCONNECTED;
  wire NLW_U0_CARRYOUT_UNCONNECTED;
  wire [29:0]NLW_U0_ACOUT_UNCONNECTED;
  wire [17:0]NLW_U0_BCOUT_UNCONNECTED;

  (* C_A_WIDTH = "16" *) 
  (* C_B_WIDTH = "18" *) 
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
  (* C_HAS_PCIN = "1" *) 
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
  (* C_OPMODES = "000000000001010100001000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000011010011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_axis_fdecfir32_dsp48dbpi_xbip_dsp48_macro_v3_0_17 U0
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

(* C_A_WIDTH = "16" *) (* C_B_WIDTH = "18" *) (* C_CONCAT_WIDTH = "48" *) 
(* C_CONSTANT_1 = "1" *) (* C_C_WIDTH = "48" *) (* C_D_WIDTH = "16" *) 
(* C_HAS_A = "1" *) (* C_HAS_ACIN = "0" *) (* C_HAS_ACOUT = "0" *) 
(* C_HAS_B = "1" *) (* C_HAS_BCIN = "0" *) (* C_HAS_BCOUT = "0" *) 
(* C_HAS_C = "0" *) (* C_HAS_CARRYCASCIN = "0" *) (* C_HAS_CARRYCASCOUT = "0" *) 
(* C_HAS_CARRYIN = "0" *) (* C_HAS_CARRYOUT = "0" *) (* C_HAS_CE = "1" *) 
(* C_HAS_CEA = "0" *) (* C_HAS_CEB = "0" *) (* C_HAS_CEC = "0" *) 
(* C_HAS_CECONCAT = "0" *) (* C_HAS_CED = "0" *) (* C_HAS_CEM = "0" *) 
(* C_HAS_CEP = "0" *) (* C_HAS_CESEL = "0" *) (* C_HAS_CONCAT = "0" *) 
(* C_HAS_D = "1" *) (* C_HAS_INDEP_CE = "0" *) (* C_HAS_INDEP_SCLR = "0" *) 
(* C_HAS_PCIN = "1" *) (* C_HAS_PCOUT = "1" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SCLRA = "0" *) (* C_HAS_SCLRB = "0" *) (* C_HAS_SCLRC = "0" *) 
(* C_HAS_SCLRCONCAT = "0" *) (* C_HAS_SCLRD = "0" *) (* C_HAS_SCLRM = "0" *) 
(* C_HAS_SCLRP = "0" *) (* C_HAS_SCLRSEL = "0" *) (* C_LATENCY = "-1" *) 
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "000000000001010100001000" *) (* C_P_LSB = "0" *) 
(* C_P_MSB = "47" *) (* C_REG_CONFIG = "00000000000011010011000001000100" *) (* C_SEL_WIDTH = "0" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_17" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_axis_fdecfir32_dsp48dbpi_xbip_dsp48_macro_v3_0_17
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
  input [17:0]B;
  input [47:0]C;
  input [15:0]D;
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
  wire [17:0]B;
  wire [17:0]BCIN;
  wire [17:0]BCOUT;
  wire CARRYCASCIN;
  wire CARRYCASCOUT;
  wire CARRYIN;
  wire CARRYOUT;
  wire CE;
  wire CLK;
  wire [15:0]D;
  wire [47:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;

  (* C_A_WIDTH = "16" *) 
  (* C_B_WIDTH = "18" *) 
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
  (* C_HAS_PCIN = "1" *) 
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
  (* C_OPMODES = "000000000001010100001000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000011010011000001000100" *) 
  (* C_SEL_WIDTH = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_axis_fdecfir32_dsp48dbpi_xbip_dsp48_macro_v3_0_17_viv i_synth
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
CQfSaxQBqSaqPMbE4ijfCda1CLrFkK/amIBIGFLAY4uR5GQ46nmjjv7r7pUXREnuVcOsyJT+dmgC
+TorfE1+5B4Exvw664Cx1HsvxbszmaEVjAwVqqfXGkaohvjFohxOPq3G3dFWGM5p0MhEyIoSXdA1
IO3RQp+faBXG8IpE76515sNZn5sh1OWBoacFH0iVeKeHXFfa+rSMdxqVtCbbjl1lKmpgnrO/1Q/A
NN7P3ssdmn06xzO7Y9YhX/9jxjNeW1Ms2MCzUUks70tuiWgeyM4QcJONrWQzFtw1g+OtOo8ssyRi
RG0KPOO4RtoBLbo//kwD+F4u2hYMfLL63c0/sQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kp+Xagd6BVhWwdJ4G2UEzO00qoPan+Usoll8bFY1D2ECy9cP3Rz84Dl0TWNCBuKMv1favNQZGVn7
cPT87bzgiIcdy3AEj7rO9JW1aowlJp6dj84y94UWD1SmO4qknCBpkeEJpZzC651bsiH4YHHSGi9G
D97rQA1q+d3tfBwo8NR68VcbnIxXvfoaycvN+dBkYQgIK84rFxIYHF3BHujSJoI1KyZflt62QrUK
xaMTObxXDMMKln8gtjK+jWvcpQ88yXd/ZthqiORPOToNZuc8o/np2uttQ03Tdpj4/cZNtCjK/AU1
vPNjQz5XycWjp6xCKd8IVogn4vPHZUzQ7J7O+A==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 30416)
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
