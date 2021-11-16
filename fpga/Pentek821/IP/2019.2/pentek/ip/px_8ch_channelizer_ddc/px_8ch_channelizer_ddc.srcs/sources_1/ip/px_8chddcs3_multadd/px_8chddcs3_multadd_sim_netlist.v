// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  8 09:09:10 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_8ch_channelizer_ddc/px_8ch_channelizer_ddc.srcs/sources_1/ip/px_8chddcs3_multadd/px_8chddcs3_multadd_sim_netlist.v
// Design      : px_8chddcs3_multadd
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_8chddcs3_multadd,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_8chddcs3_multadd
   (CLK,
    PCIN,
    A,
    B,
    D,
    PCOUT,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:pcout_intf:carrycascout_intf:carryout_intf:bcout_intf:acout_intf:concat_intf:d_intf:c_intf:b_intf:a_intf:bcin_intf:acin_intf:pcin_intf:carryin_intf:carrycascin_intf:sel_intf, ASSOCIATED_RESET SCLR:SCLRD:SCLRA:SCLRB:SCLRCONCAT:SCLRC:SCLRM:SCLRP:SCLRSEL, ASSOCIATED_CLKEN CE:CED:CED1:CED2:CED3:CEA:CEA1:CEA2:CEA3:CEA4:CEB:CEB1:CEB2:CEB3:CEB4:CECONCAT:CECONCAT3:CECONCAT4:CECONCAT5:CEC:CEC1:CEC2:CEC3:CEC4:CEC5:CEM:CEP:CESEL:CESEL1:CESEL2:CESEL3:CESEL4:CESEL5, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcin_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME pcin_intf, LAYERED_METADATA undef" *) input [47:0]PCIN;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [17:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [17:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 d_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME d_intf, LAYERED_METADATA undef" *) input [17:0]D;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcout_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME pcout_intf, LAYERED_METADATA undef" *) output [47:0]PCOUT;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [47:0]P;

  wire [17:0]A;
  wire [17:0]B;
  wire CLK;
  wire [17:0]D;
  wire [47:0]P;
  wire [47:0]PCIN;
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
  px_8chddcs3_multadd_xbip_dsp48_macro_v3_0_17 U0
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
(* C_HAS_PCIN = "1" *) (* C_HAS_PCOUT = "1" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SCLRA = "0" *) (* C_HAS_SCLRB = "0" *) (* C_HAS_SCLRC = "0" *) 
(* C_HAS_SCLRCONCAT = "0" *) (* C_HAS_SCLRD = "0" *) (* C_HAS_SCLRM = "0" *) 
(* C_HAS_SCLRP = "0" *) (* C_HAS_SCLRSEL = "0" *) (* C_LATENCY = "-1" *) 
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "000000000001010100001000" *) (* C_P_LSB = "0" *) 
(* C_P_MSB = "47" *) (* C_REG_CONFIG = "00000000000011010011000001000100" *) (* C_SEL_WIDTH = "0" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_17" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_8chddcs3_multadd_xbip_dsp48_macro_v3_0_17
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
  wire [47:0]P;
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
  px_8chddcs3_multadd_xbip_dsp48_macro_v3_0_17_viv i_synth
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
lcL6TRWt4qMhT8URYK9OLKr+xf7f8R5PX/hMibY/6VHqDnN0JEFvhsBQ0CqEBZ1R/HyuKI0s02+C
ZIeRXCn+4p/TTGFcqzQzv+mLOQ0qjVQLVrfO0UPMlzP3uFPFcry5gZzV2DazH0TmOp2oZH/u4KwM
+gaEuUSFRXHKtpPwimAp6QYQkImrPxYDRsMAzbGlUJvhe1NnpwIHH1lIn6buDW5/Wi8y7FwA5yKX
l157x9DjK7Jzk+4K7nbT6oLGnZ1Ur9EMttNi5FRYRwcuH8QnchmVbFfPBDdrdJxs5uaA3fKVjkH8
ODFJhWgmsntwf62umtPieJ/3AU1406umPXJyZw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
hkihZF9yeB1yXC5fmDi5SisjsfxGEeOdonHBHivRh1LHzdpMBwkH9LQqorJ49YA8MVcTFDHJGkL4
VbPXPPZu5Ttkbco/gQ64uYecYpRdNUuWiAmOJzmp8neG50cyy4byRcqVAT0Awg+V7q6/+YbvJglz
WzwtWHfwZG1EyeJy6VaiTnaoBy06oVRRZi6u6N6+yhq4I7KPmFxyyKuJqBLGwZ+e+iTyPVSqPhnL
iFxzGdBOJ7A/XamXGly9LAZV4kOKvZQL0ZiGGTzVJhru+td0IkHUjsOEvhcCxR+kTdhlo32B3sAo
nRPgnuKqYe1kZaVTPj/7vKIJvEyA2W/1uZ9e5w==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 30144)
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
