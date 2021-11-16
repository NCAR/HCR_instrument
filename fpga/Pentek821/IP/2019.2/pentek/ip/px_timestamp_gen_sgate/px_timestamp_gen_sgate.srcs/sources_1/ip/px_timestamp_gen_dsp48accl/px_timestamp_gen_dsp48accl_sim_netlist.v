// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sun Jun  9 09:10:30 2019
// Host        : Igor2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Pentek/IP/2019.1/pentek/ip/px_timestamp_gen_sgate/px_timestamp_gen_sgate.srcs/sources_1/ip/px_timestamp_gen_dsp48accl/px_timestamp_gen_dsp48accl_sim_netlist.v
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
MRBtaLplzNCHzsHfHSqi0HyevzpqlhspofIKXgQUz8Z4/7UnBePEqKttu82rhJ5TXabDdqNew8Ef
mPOoxEwYzFptlVTcFIPGOF+GwQCLtd6CC6tEFoi7umWA7Gx/QoqyIVkGG0kCAHBBE6kRSbz4sd3C
xECwZUNdKPgqZzWNmCWBkygrPxPrd5M21u9cj6TTi1iBGOsFGaYb8QLbPI+5XkXUzYdVmWJcFDX9
Q3HFI/MmtMwvv3ijNj46ops4J1hxWnaxTzUARSxewqshUC9aAKZMtp5JuGqzaBz6r8gSzZvJMblG
f4dLeN/ePimCRA67ZJMVd4N9yO1WD4O2BOVIWg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
RyiNenbHYgy4h9D90GXEA8k78XV1nEwSOdefCwXe6JWOHIewgepTkho4AwdC+2weN+4bC+flRXq+
sCImWUKqEp57MjAM3V7cW6b4xWaX72xqVNmrF5xchcR1A8GDXnF/gkcSoG2JbK/CjBqbDIA65mHf
2OKzivDt22rLUGJcBIReFJ3GqsD6pV5HRrH/V9vmAzpnib4pAao9Q+c13V3HKl/OizP6v351u7KT
MHPN66jHFfL8cuJEvrLvr+lzoJeXWwGsDKBS86TT7lmRudYqvzi7as2l83XpO3W59KZREeMyLZRa
Tt41KD4ZH1wKAvTChBdjpbiunfD8/GmZN602aA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 9808)
`pragma protect data_block
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
OB1KwA==
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
