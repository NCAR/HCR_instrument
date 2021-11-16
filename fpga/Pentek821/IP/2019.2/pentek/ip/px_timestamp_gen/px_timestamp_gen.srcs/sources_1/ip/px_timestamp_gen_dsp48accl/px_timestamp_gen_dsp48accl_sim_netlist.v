// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sun Jun  9 09:08:17 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_timestamp_gen/px_timestamp_gen.srcs/sources_1/ip/px_timestamp_gen_dsp48accl/px_timestamp_gen_dsp48accl_sim_netlist.v
// Design      : px_timestamp_gen_dsp48accl
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_timestamp_gen_dsp48accl,xbip_dsp48_macro_v3_0_17,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "xbip_dsp48_macro_v3_0_17,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module px_timestamp_gen_dsp48accl
   (CLK,
    SEL,
    C,
    CARRYCASCOUT,
    P,
    CEP,
    SCLRP);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:pcout_intf:carrycascout_intf:carryout_intf:bcout_intf:acout_intf:concat_intf:d_intf:c_intf:b_intf:a_intf:bcin_intf:acin_intf:pcin_intf:carryin_intf:carrycascin_intf:sel_intf, ASSOCIATED_RESET SCLR:SCLRD:SCLRA:SCLRB:SCLRCONCAT:SCLRC:SCLRM:SCLRP:SCLRSEL, ASSOCIATED_CLKEN CE:CED:CED1:CED2:CED3:CEA:CEA1:CEA2:CEA3:CEA4:CEB:CEB1:CEB2:CEB3:CEB4:CECONCAT:CECONCAT3:CECONCAT4:CECONCAT5:CEC:CEC1:CEC2:CEC3:CEC4:CEC5:CEM:CEP:CESEL:CESEL1:CESEL2:CESEL3:CESEL4:CESEL5, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 sel_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME sel_intf, LAYERED_METADATA undef" *) input [0:0]SEL;
  (* x_interface_info = "xilinx.com:signal:data:1.0 c_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME c_intf, LAYERED_METADATA undef" *) input [47:0]C;
  (* x_interface_info = "xilinx.com:signal:data:1.0 carrycascout_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME carrycascout_intf, LAYERED_METADATA undef" *) output CARRYCASCOUT;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [47:0]P;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 cep_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME cep_intf, POLARITY ACTIVE_LOW" *) input CEP;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclrp_intf RST" *) (* x_interface_parameter = "XIL_INTERFACENAME sclrp_intf, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input SCLRP;

  wire [47:0]C;
  wire CARRYCASCOUT;
  wire CEP;
  wire CLK;
  wire [47:0]P;
  wire SCLRP;
  wire [0:0]SEL;
  wire NLW_U0_CARRYOUT_UNCONNECTED;
  wire [29:0]NLW_U0_ACOUT_UNCONNECTED;
  wire [17:0]NLW_U0_BCOUT_UNCONNECTED;
  wire [47:0]NLW_U0_PCOUT_UNCONNECTED;

  (* C_A_WIDTH = "18" *) 
  (* C_B_WIDTH = "18" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_D_WIDTH = "18" *) 
  (* C_HAS_A = "0" *) 
  (* C_HAS_ACIN = "0" *) 
  (* C_HAS_ACOUT = "0" *) 
  (* C_HAS_B = "0" *) 
  (* C_HAS_BCIN = "0" *) 
  (* C_HAS_BCOUT = "0" *) 
  (* C_HAS_C = "1" *) 
  (* C_HAS_CARRYCASCIN = "0" *) 
  (* C_HAS_CARRYCASCOUT = "1" *) 
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
  (* C_LATENCY = "128" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "000000000010110000000000,000000011000000000000000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000000000000000010100100" *) 
  (* C_SEL_WIDTH = "1" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_timestamp_gen_dsp48accl_xbip_dsp48_macro_v3_0_17 U0
       (.A({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACOUT(NLW_U0_ACOUT_UNCONNECTED[29:0]),
        .B({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCOUT(NLW_U0_BCOUT_UNCONNECTED[17:0]),
        .C(C),
        .CARRYCASCIN(1'b0),
        .CARRYCASCOUT(CARRYCASCOUT),
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
(* C_CONSTANT_1 = "1" *) (* C_C_WIDTH = "48" *) (* C_D_WIDTH = "18" *) 
(* C_HAS_A = "0" *) (* C_HAS_ACIN = "0" *) (* C_HAS_ACOUT = "0" *) 
(* C_HAS_B = "0" *) (* C_HAS_BCIN = "0" *) (* C_HAS_BCOUT = "0" *) 
(* C_HAS_C = "1" *) (* C_HAS_CARRYCASCIN = "0" *) (* C_HAS_CARRYCASCOUT = "1" *) 
(* C_HAS_CARRYIN = "0" *) (* C_HAS_CARRYOUT = "0" *) (* C_HAS_CE = "1" *) 
(* C_HAS_CEA = "0" *) (* C_HAS_CEB = "0" *) (* C_HAS_CEC = "0" *) 
(* C_HAS_CECONCAT = "0" *) (* C_HAS_CED = "0" *) (* C_HAS_CEM = "0" *) 
(* C_HAS_CEP = "1" *) (* C_HAS_CESEL = "0" *) (* C_HAS_CONCAT = "0" *) 
(* C_HAS_D = "0" *) (* C_HAS_INDEP_CE = "2" *) (* C_HAS_INDEP_SCLR = "1" *) 
(* C_HAS_PCIN = "0" *) (* C_HAS_PCOUT = "0" *) (* C_HAS_SCLR = "1" *) 
(* C_HAS_SCLRA = "0" *) (* C_HAS_SCLRB = "0" *) (* C_HAS_SCLRC = "0" *) 
(* C_HAS_SCLRCONCAT = "0" *) (* C_HAS_SCLRD = "0" *) (* C_HAS_SCLRM = "0" *) 
(* C_HAS_SCLRP = "1" *) (* C_HAS_SCLRSEL = "0" *) (* C_LATENCY = "128" *) 
(* C_MODEL_TYPE = "0" *) (* C_OPMODES = "000000000010110000000000,000000011000000000000000" *) (* C_P_LSB = "0" *) 
(* C_P_MSB = "47" *) (* C_REG_CONFIG = "00000000000000000000000010100100" *) (* C_SEL_WIDTH = "1" *) 
(* C_TEST_CORE = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintexu" *) 
(* ORIG_REF_NAME = "xbip_dsp48_macro_v3_0_17" *) (* downgradeipidentifiedwarnings = "yes" *) 
module px_timestamp_gen_dsp48accl_xbip_dsp48_macro_v3_0_17
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

  wire [29:0]ACIN;
  wire [29:0]ACOUT;
  wire [17:0]BCIN;
  wire [17:0]BCOUT;
  wire [47:0]C;
  wire CARRYCASCIN;
  wire CARRYCASCOUT;
  wire CARRYOUT;
  wire CEP;
  wire CLK;
  wire [47:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;
  wire SCLRP;
  wire [0:0]SEL;

  (* C_A_WIDTH = "18" *) 
  (* C_B_WIDTH = "18" *) 
  (* C_CONCAT_WIDTH = "48" *) 
  (* C_CONSTANT_1 = "1" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_D_WIDTH = "18" *) 
  (* C_HAS_A = "0" *) 
  (* C_HAS_ACIN = "0" *) 
  (* C_HAS_ACOUT = "0" *) 
  (* C_HAS_B = "0" *) 
  (* C_HAS_BCIN = "0" *) 
  (* C_HAS_BCOUT = "0" *) 
  (* C_HAS_C = "1" *) 
  (* C_HAS_CARRYCASCIN = "0" *) 
  (* C_HAS_CARRYCASCOUT = "1" *) 
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
  (* C_LATENCY = "128" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_OPMODES = "000000000010110000000000,000000011000000000000000" *) 
  (* C_P_LSB = "0" *) 
  (* C_P_MSB = "47" *) 
  (* C_REG_CONFIG = "00000000000000000000000010100100" *) 
  (* C_SEL_WIDTH = "1" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintexu" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  px_timestamp_gen_dsp48accl_xbip_dsp48_macro_v3_0_17_viv i_synth
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
m/k8P0tYakTsVZsGcWNG/e/SzW5wPm5KRQZ0axu727yjJxTesvAGBu1x6wVLKkQaJTm1DOh+eXbW
NVdesV2cS4to1OA271MeiiuJLZ//PqEOJ5UigzCG2jTkqtQ4Ccb07E3x1FyuiLnyvaMYc7ENTXue
hW2DwObDiRa2eFGqpfTYJemTLMmmpTUE7snHc6Jqy9q/MWz9fyG+N3fTR/wHC7wixGDdeGSMa5LX
JPIkuctNpK0Qh+xkDOpraKmKtZqcQfLzPQa1FLRvln3IZw7ovQv/pYjG3psHkNOL7eXmvhctpacc
xHzqpi9tA3uDO0aQ5Emhis32ZAKqo/wIybDFVw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ENLm/VrLe3Mdoxuj1Hj9EGlhoKp9BBxg2WPa+eWMrpdXX3rdbYpl+PetzHmXbTA1PBDhiWxl9LFX
aj/RoYHK501kySXLiyhrHxRLjGLvU15Hs5HjMDX61szev50tPWX40rVZThBJwLXQHejv4Q9PKxme
MTYQDjktsxhPcOWz88wx3lmZJPOJCmAlSQj5oe4aI1a9pAMSWAy6skOgW8GGuVtHzuI6pF+bLXp9
436eHhyTtFmmhR2XYtJz677bqZv2yXYT3Ja8cSCY7yAAu2DfuezrRbDw8A+Z5CrzangXCrOG+EDS
wAWfhhUSRN5dvaTMyMU705doR/Sam+7gm5iNRg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 9808)
`pragma protect data_block
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
EoI+mw==
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
