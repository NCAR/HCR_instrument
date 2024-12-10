// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sun Jun  9 09:10:30 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_timestamp_gen_sgate/px_timestamp_gen_sgate.srcs/sources_1/ip/px_timestamp_gen_dsp48accu/px_timestamp_gen_dsp48accu_sim_netlist.v
// Design      : px_timestamp_gen_dsp48accu
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_timestamp_gen_dsp48accu,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_timestamp_gen_dsp48accu
   (CLK,
    SEL,
    CARRYCASCIN,
    C,
    P,
    CEP,
    SCLRP);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:pcout_intf:carrycascout_intf:carryout_intf:bcout_intf:acout_intf:concat_intf:d_intf:c_intf:b_intf:a_intf:bcin_intf:acin_intf:pcin_intf:carryin_intf:carrycascin_intf:sel_intf, ASSOCIATED_RESET SCLR:SCLRD:SCLRA:SCLRB:SCLRCONCAT:SCLRC:SCLRM:SCLRP:SCLRSEL, ASSOCIATED_CLKEN CE:CED:CED1:CED2:CED3:CEA:CEA1:CEA2:CEA3:CEA4:CEB:CEB1:CEB2:CEB3:CEB4:CECONCAT:CECONCAT3:CECONCAT4:CECONCAT5:CEC:CEC1:CEC2:CEC3:CEC4:CEC5:CEM:CEP:CESEL:CESEL1:CESEL2:CESEL3:CESEL4:CESEL5, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 sel_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME sel_intf, LAYERED_METADATA undef" *) input [0:0]SEL;
  (* x_interface_info = "xilinx.com:signal:data:1.0 carrycascin_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME carrycascin_intf, LAYERED_METADATA undef" *) input CARRYCASCIN;
  (* x_interface_info = "xilinx.com:signal:data:1.0 c_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME c_intf, LAYERED_METADATA undef" *) input [15:0]C;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [15:0]P;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 cep_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME cep_intf, POLARITY ACTIVE_LOW" *) input CEP;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclrp_intf RST" *) (* x_interface_parameter = "XIL_INTERFACENAME sclrp_intf, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input SCLRP;

  wire [15:0]C;
  wire CARRYCASCIN;
  wire CEP;
  wire CLK;
  wire [15:0]P;
  wire SCLRP;
  wire [0:0]SEL;
  wire NLW_U0_CARRYCASCOUT_UNCONNECTED;
  wire NLW_U0_CARRYOUT_UNCONNECTED;
  wire [29:0]NLW_U0_ACOUT_UNCONNECTED;
  wire [17:0]NLW_U0_BCOUT_UNCONNECTED;
  wire [47:0]NLW_U0_PCOUT_UNCONNECTED;

  (* C_A_WIDTH = "18" *) 
  (* C_B_WIDTH = "18" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "16" *) 
  (* C_D_WIDTH = "18" *) 
  (* C_HAS_A = "0" *) 
  (* C_HAS_ACIN = "0" *) 
  (* C_HAS_ACOUT = "0" *) 
  (* C_HAS_B = "0" *) 
  (* C_HAS_BCIN = "0" *) 
  (* C_HAS_BCOUT = "0" *) 
  (* C_HAS_C = "1" *) 
  (* C_HAS_CARRYCASCIN = "1" *) 
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
  (* C_HAS_CEP = "1" *) 
  (* C_HAS_CESEL = "0" *) 
  (* C_HAS_CONCAT = "0" *) 
  (* C_HAS_D = "0" *) 
  (* C_HAS_INDEP_CE = "2" *) 
  (* C_HAS_INDEP_SCLR = "1" *) 
  (* C_HAS_PCIN = "0" *) 
  (* C_HAS_PCOUT = "0" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SCLRA = "0" *) 
  (* C_HAS_SCLRB = "0" *) 
  (* C_HAS_SCLRC = "0" *) 
  (* C_HAS_SCLRCONCAT = "0" *) 
  (* C_HAS_SCLRD = "0" *) 
  (* C_HAS_SCLRM = "0" *) 
  (* C_HAS_SCLRP = "1" *) 
  (* C_HAS_SCLRSEL = "0" *) 
  (* C_LATENCY = "120" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "010000000010000000000000,000000011000000000000000" *) 
  (* C_P_LSB = "32" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000000000000100110100100" *) 
  (* C_SEL_WIDTH = "1" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_timestamp_gen_dsp48accu_xbip_dsp48_macro_v3_0_17 U0
       (.A({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACOUT(NLW_U0_ACOUT_UNCONNECTED[29:0]),
        .B({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCOUT(NLW_U0_BCOUT_UNCONNECTED[17:0]),
        .C(C),
        .CARRYCASCIN(CARRYCASCIN),
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
        .CEP(CEP),
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
        .PCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCOUT(NLW_U0_PCOUT_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .SCLRA(1'b0),
        .SCLRB(1'b0),
        .SCLRC(1'b0),
        .SCLRCONCAT(1'b0),
        .SCLRD(1'b0),
        .SCLRM(1'b0),
        .SCLRP(SCLRP),
        .SCLRSEL(1'b0),
        .SEL(SEL));
endmodule

(* C_A_WIDTH = "18" *) (* C_B_WIDTH = "18" *) (* C_CONCAT_WIDTH = "48" *) 
(* C_CONSTANT_1 = "1" *) (* C_C_WIDTH = "16" *) (* C_D_WIDTH = "18" *) 
(* C_HAS_A = "0" *) (* C_HAS_ACIN = "0" *) (* C_HAS_ACOUT = "0" *) 
(* C_HAS_B = "0" *) (* C_HAS_BCIN = "0" *) (* C_HAS_BCOUT = "0" *) 
(* C_HAS_C = "1" *) (* C_HAS_CARRYCASCIN = "1" *) (* C_HAS_CARRYCASCOUT = "0" *) 
(* C_HAS_CARRYIN = "0" *) (* C_HAS_CARRYOUT = "0" *) (* C_HAS_CE = "1" *) 
(* C_HAS_CEA = "0" *) (* C_HAS_CEB = "0" *) (* C_HAS_CEC = "0" *) 
(* C_HAS_CECONCAT = "0" *) (* C_HAS_CED = "0" *) (* C_HAS_CEM = "0" *) 
(* C_HAS_CEP = "1" *) (* C_HAS_CESEL = "0" *) (* C_HAS_CONCAT = "0" *) 
(* C_HAS_D = "0" *) (* C_HAS_INDEP_CE = "2" *) (* C_HAS_INDEP_SCLR = "1" *) 
(* C_HAS_PCIN = "0" *) (* C_HAS_PCOUT = "0" *) (* C_HAS_SCLR = "1" *) 
(* C_HAS_SCLRA = "0" *) (* C_HAS_SCLRB = "0" *) (* C_HAS_SCLRC = "0" *) 
(* C_HAS_SCLRCONCAT = "0" *) (* C_HAS_SCLRD = "0" *) (* C_HAS_SCLRM = "0" *) 
(* C_HAS_SCLRP = "1" *) (* C_HAS_SCLRSEL = "0" *) (* C_LATENCY = "120" *) 
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "010000000010000000000000,000000011000000000000000" *) (* C_P_LSB = "32" *) 
(* C_P_MSB = "47" *) (* C_REG_CONFIG = "00000000000000000000100110100100" *) (* C_SEL_WIDTH = "1" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_17" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_timestamp_gen_dsp48accu_xbip_dsp48_macro_v3_0_17
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
  input [15:0]C;
  input [17:0]D;
  input [47:0]CONCAT;
  output [29:0]ACOUT;
  output [17:0]BCOUT;
  output CARRYOUT;
  output CARRYCASCOUT;
  output [47:0]PCOUT;
  output [15:0]P;
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

  wire [29:0]ACIN;
  wire [29:0]ACOUT;
  wire [17:0]BCIN;
  wire [17:0]BCOUT;
  wire [15:0]C;
  wire CARRYCASCIN;
  wire CARRYCASCOUT;
  wire CARRYOUT;
  wire CEP;
  wire CLK;
  wire [15:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;
  wire SCLRP;
  wire [0:0]SEL;

  (* C_A_WIDTH = "18" *) 
  (* C_B_WIDTH = "18" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "16" *) 
  (* C_D_WIDTH = "18" *) 
  (* C_HAS_A = "0" *) 
  (* C_HAS_ACIN = "0" *) 
  (* C_HAS_ACOUT = "0" *) 
  (* C_HAS_B = "0" *) 
  (* C_HAS_BCIN = "0" *) 
  (* C_HAS_BCOUT = "0" *) 
  (* C_HAS_C = "1" *) 
  (* C_HAS_CARRYCASCIN = "1" *) 
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
  (* C_HAS_CEP = "1" *) 
  (* C_HAS_CESEL = "0" *) 
  (* C_HAS_CONCAT = "0" *) 
  (* C_HAS_D = "0" *) 
  (* C_HAS_INDEP_CE = "2" *) 
  (* C_HAS_INDEP_SCLR = "1" *) 
  (* C_HAS_PCIN = "0" *) 
  (* C_HAS_PCOUT = "0" *) 
  (* C_HAS_SCLR = "1" *) 
  (* C_HAS_SCLRA = "0" *) 
  (* C_HAS_SCLRB = "0" *) 
  (* C_HAS_SCLRC = "0" *) 
  (* C_HAS_SCLRCONCAT = "0" *) 
  (* C_HAS_SCLRD = "0" *) 
  (* C_HAS_SCLRM = "0" *) 
  (* C_HAS_SCLRP = "1" *) 
  (* C_HAS_SCLRSEL = "0" *) 
  (* C_LATENCY = "120" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "010000000010000000000000,000000011000000000000000" *) 
  (* C_P_LSB = "32" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000000000000100110100100" *) 
  (* C_SEL_WIDTH = "1" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_timestamp_gen_dsp48accu_xbip_dsp48_macro_v3_0_17_viv i_synth
       (.A({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACIN(ACIN),
        .ACOUT(ACOUT),
        .B({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCIN(BCIN),
        .BCOUT(BCOUT),
        .C(C),
        .CARRYCASCIN(CARRYCASCIN),
        .CARRYCASCOUT(CARRYCASCOUT),
        .CARRYIN(1'b0),
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
        .CEP(CEP),
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
        .SCLRP(SCLRP),
        .SCLRSEL(1'b0),
        .SEL(SEL));
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
o1mgyCJQ39F3jn47aXeq7CEI5NyLOLkAyu7hrS1nkyl6td9Y8Z860jHQZ8kWLfEbJI2HYIlHADSD
R1jBuEcQjmQZf50KMs061feQI03wRS2yjKoJdfYIfffKpeeX6lZkuzTk3hxi/IlS5bKKF+6/2Xnv
3P4FwdUmVth1gEWNcaXJtHGyFD9mEX1TLeD68+kqMynBf4IOlJYD01FIKdWkzVmVoRIVxKR2tl68
LOzNIfZQtjdYjLh1JLXC5zNvCHkZsGiKru+bbQzYyusJWMVrSeTZJZWhuJYAQ4c97ZYhhMeSt7f7
5fRg6BbF9V4cSDy1J82ngv+J/nOOB/inMkrppA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
4Z9c33VyltB18NNV695tJ/4k85horD8u2fnW4ohTg9iauoi6pT4C34wU2eE8h/R4LksIaGNATd5g
VCEtTLjFkSFC1MLwtENB5dk0UEA7UJDhbZN+zUaZvv9FkFlI51gFp4G+yNVO7bMd7uHgTkihNYRo
3dN2l0tidSXIG9GNhN2jaq/7L5+2goXh1xLXnOz48a8baBAvWGQ9S0HgwJtQcBEDA3ziMLjmI+3v
75iRtb9echxuKxToyRnRUo1wtUw7IcdQYEkVqUzN7UnquL1/GLJ3xPaIOaQ5WT18B6p6Uqdz5P9s
jUhqNHBfSOlmejliJQCB39n3jhCSj+BrGG93oA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 26000)
`pragma protect data_block
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
QnHf5F4wgFo=
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
