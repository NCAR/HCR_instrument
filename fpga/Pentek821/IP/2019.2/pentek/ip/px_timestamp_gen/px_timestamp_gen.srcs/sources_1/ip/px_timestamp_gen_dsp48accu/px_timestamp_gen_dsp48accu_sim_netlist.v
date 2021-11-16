// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sun Jun  9 09:08:17 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_timestamp_gen/px_timestamp_gen.srcs/sources_1/ip/px_timestamp_gen_dsp48accu/px_timestamp_gen_dsp48accu_sim_netlist.v
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
UP7z1Kd90NH4ulFYQwzb4Frgdh/9JilKMTs7zecC98cC20zzFA7jZf2EAE0wPjIXvP2Ahps1Ic0j
ZDoIfKSHO8hnESgN8uMnuAFnzrvdBhSTSGOpW7jkfx1W+AymcEuDEK5WrIfKI3cUaeESqdS83skZ
akPjktemHYPmiws5l64TSMafQoylMlf5njf3aY5GQwJXiXdSCzteEmwbzJE9QHJLui1a0/o2PQ5+
LR9RYmcIzhfqqSeUblpih1zMw9W8T1/Vo9aK3Nf4bGkeoMWipAkkrcD9dtGHJJL0BivX63gCi70S
UoZqG9ZzNfOzo4g01u6cPWh0Od+X/viBdCsHkA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
sYyrAE2WqPaQQY3TCkVRGkRgn4HAp3iYmNVjCywA6vn/ps95FaSUE0dSyJgb/Dw6Sr4rgBwVl1gG
ncAMeXTEvWkoMOpFz3muiQI64RDJpg0E44wAKpiaiGnFNmqBxxkjaucv+d7C4mKMT0zpJxjKjv5i
nVEjF5eSyKzx04WlTHvFEp7T4SBK7UjFhEHjBghxa74ddpd5wrvkdIx3zac/EmcKNFJUgchx6wVc
pyU0x7uyrZyh+h/fYOVW61h4HkFtVGfuKPr9mutAO4eXThNqDF6iiwg3zucpSIaI/jxp/lbi8gsa
TbAdazfjBwUCW5ngMBhkKuW+7kERMqcSfZchYw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 26000)
`pragma protect data_block
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
+7VaPAczRPc=
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
