// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
// Date        : Fri May 19 11:25:18 2017
// Host        : Rich-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Pentek/IP/2017.1/wip/px_8ch_channelizer_ddc/px_8ch_channelizer_ddc.srcs/sources_1/ip/px_8chddcs4_fmtrmem/px_8chddcs4_fmtrmem_sim_netlist.v
// Design      : px_8chddcs4_fmtrmem
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1517-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_8chddcs4_fmtrmem,dist_mem_gen_v8_0_11,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "dist_mem_gen_v8_0_11,Vivado 2017.1" *) 
(* NotValidForBitStream *)
module px_8chddcs4_fmtrmem
   (a,
    d,
    dpra,
    clk,
    we,
    qdpo);
  input [3:0]a;
  input [177:0]d;
  input [3:0]dpra;
  input clk;
  input we;
  output [177:0]qdpo;

  wire [3:0]a;
  wire clk;
  wire [177:0]d;
  wire [3:0]dpra;
  wire [177:0]qdpo;
  wire we;
  wire [177:0]NLW_U0_dpo_UNCONNECTED;
  wire [177:0]NLW_U0_qspo_UNCONNECTED;
  wire [177:0]NLW_U0_spo_UNCONNECTED;

  (* C_FAMILY = "kintexu" *) 
  (* C_HAS_CLK = "1" *) 
  (* C_HAS_D = "1" *) 
  (* C_HAS_DPO = "0" *) 
  (* C_HAS_DPRA = "1" *) 
  (* C_HAS_QDPO = "1" *) 
  (* C_HAS_QDPO_CE = "0" *) 
  (* C_HAS_QDPO_CLK = "0" *) 
  (* C_HAS_QDPO_RST = "0" *) 
  (* C_HAS_QDPO_SRST = "0" *) 
  (* C_HAS_QSPO = "0" *) 
  (* C_HAS_QSPO_RST = "0" *) 
  (* C_HAS_QSPO_SRST = "0" *) 
  (* C_HAS_SPO = "0" *) 
  (* C_HAS_WE = "1" *) 
  (* C_MEM_TYPE = "4" *) 
  (* C_REG_DPRA_INPUT = "1" *) 
  (* c_addr_width = "4" *) 
  (* c_default_data = "0" *) 
  (* c_depth = "16" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_i_ce = "0" *) 
  (* c_has_qspo_ce = "0" *) 
  (* c_mem_init_file = "no_coe_file_loaded" *) 
  (* c_parser_type = "1" *) 
  (* c_pipeline_stages = "0" *) 
  (* c_qce_joined = "0" *) 
  (* c_qualify_we = "0" *) 
  (* c_read_mif = "0" *) 
  (* c_reg_a_d_inputs = "1" *) 
  (* c_sync_enable = "1" *) 
  (* c_width = "178" *) 
  px_8chddcs4_fmtrmem_dist_mem_gen_v8_0_11 U0
       (.a(a),
        .clk(clk),
        .d(d),
        .dpo(NLW_U0_dpo_UNCONNECTED[177:0]),
        .dpra(dpra),
        .i_ce(1'b1),
        .qdpo(qdpo),
        .qdpo_ce(1'b1),
        .qdpo_clk(1'b0),
        .qdpo_rst(1'b0),
        .qdpo_srst(1'b0),
        .qspo(NLW_U0_qspo_UNCONNECTED[177:0]),
        .qspo_ce(1'b1),
        .qspo_rst(1'b0),
        .qspo_srst(1'b0),
        .spo(NLW_U0_spo_UNCONNECTED[177:0]),
        .we(we));
endmodule

(* C_ADDR_WIDTH = "4" *) (* C_DEFAULT_DATA = "0" *) (* C_DEPTH = "16" *) 
(* C_ELABORATION_DIR = "./" *) (* C_FAMILY = "kintexu" *) (* C_HAS_CLK = "1" *) 
(* C_HAS_D = "1" *) (* C_HAS_DPO = "0" *) (* C_HAS_DPRA = "1" *) 
(* C_HAS_I_CE = "0" *) (* C_HAS_QDPO = "1" *) (* C_HAS_QDPO_CE = "0" *) 
(* C_HAS_QDPO_CLK = "0" *) (* C_HAS_QDPO_RST = "0" *) (* C_HAS_QDPO_SRST = "0" *) 
(* C_HAS_QSPO = "0" *) (* C_HAS_QSPO_CE = "0" *) (* C_HAS_QSPO_RST = "0" *) 
(* C_HAS_QSPO_SRST = "0" *) (* C_HAS_SPO = "0" *) (* C_HAS_WE = "1" *) 
(* C_MEM_INIT_FILE = "no_coe_file_loaded" *) (* C_MEM_TYPE = "4" *) (* C_PARSER_TYPE = "1" *) 
(* C_PIPELINE_STAGES = "0" *) (* C_QCE_JOINED = "0" *) (* C_QUALIFY_WE = "0" *) 
(* C_READ_MIF = "0" *) (* C_REG_A_D_INPUTS = "1" *) (* C_REG_DPRA_INPUT = "1" *) 
(* C_SYNC_ENABLE = "1" *) (* C_WIDTH = "178" *) (* ORIG_REF_NAME = "dist_mem_gen_v8_0_11" *) 
module px_8chddcs4_fmtrmem_dist_mem_gen_v8_0_11
   (a,
    d,
    dpra,
    clk,
    we,
    i_ce,
    qspo_ce,
    qdpo_ce,
    qdpo_clk,
    qspo_rst,
    qdpo_rst,
    qspo_srst,
    qdpo_srst,
    spo,
    dpo,
    qspo,
    qdpo);
  input [3:0]a;
  input [177:0]d;
  input [3:0]dpra;
  input clk;
  input we;
  input i_ce;
  input qspo_ce;
  input qdpo_ce;
  input qdpo_clk;
  input qspo_rst;
  input qdpo_rst;
  input qspo_srst;
  input qdpo_srst;
  output [177:0]spo;
  output [177:0]dpo;
  output [177:0]qspo;
  output [177:0]qdpo;

  wire \<const0> ;
  wire [3:0]a;
  wire clk;
  wire [177:0]d;
  wire [3:0]dpra;
  wire [177:0]qdpo;
  wire we;

  assign dpo[177] = \<const0> ;
  assign dpo[176] = \<const0> ;
  assign dpo[175] = \<const0> ;
  assign dpo[174] = \<const0> ;
  assign dpo[173] = \<const0> ;
  assign dpo[172] = \<const0> ;
  assign dpo[171] = \<const0> ;
  assign dpo[170] = \<const0> ;
  assign dpo[169] = \<const0> ;
  assign dpo[168] = \<const0> ;
  assign dpo[167] = \<const0> ;
  assign dpo[166] = \<const0> ;
  assign dpo[165] = \<const0> ;
  assign dpo[164] = \<const0> ;
  assign dpo[163] = \<const0> ;
  assign dpo[162] = \<const0> ;
  assign dpo[161] = \<const0> ;
  assign dpo[160] = \<const0> ;
  assign dpo[159] = \<const0> ;
  assign dpo[158] = \<const0> ;
  assign dpo[157] = \<const0> ;
  assign dpo[156] = \<const0> ;
  assign dpo[155] = \<const0> ;
  assign dpo[154] = \<const0> ;
  assign dpo[153] = \<const0> ;
  assign dpo[152] = \<const0> ;
  assign dpo[151] = \<const0> ;
  assign dpo[150] = \<const0> ;
  assign dpo[149] = \<const0> ;
  assign dpo[148] = \<const0> ;
  assign dpo[147] = \<const0> ;
  assign dpo[146] = \<const0> ;
  assign dpo[145] = \<const0> ;
  assign dpo[144] = \<const0> ;
  assign dpo[143] = \<const0> ;
  assign dpo[142] = \<const0> ;
  assign dpo[141] = \<const0> ;
  assign dpo[140] = \<const0> ;
  assign dpo[139] = \<const0> ;
  assign dpo[138] = \<const0> ;
  assign dpo[137] = \<const0> ;
  assign dpo[136] = \<const0> ;
  assign dpo[135] = \<const0> ;
  assign dpo[134] = \<const0> ;
  assign dpo[133] = \<const0> ;
  assign dpo[132] = \<const0> ;
  assign dpo[131] = \<const0> ;
  assign dpo[130] = \<const0> ;
  assign dpo[129] = \<const0> ;
  assign dpo[128] = \<const0> ;
  assign dpo[127] = \<const0> ;
  assign dpo[126] = \<const0> ;
  assign dpo[125] = \<const0> ;
  assign dpo[124] = \<const0> ;
  assign dpo[123] = \<const0> ;
  assign dpo[122] = \<const0> ;
  assign dpo[121] = \<const0> ;
  assign dpo[120] = \<const0> ;
  assign dpo[119] = \<const0> ;
  assign dpo[118] = \<const0> ;
  assign dpo[117] = \<const0> ;
  assign dpo[116] = \<const0> ;
  assign dpo[115] = \<const0> ;
  assign dpo[114] = \<const0> ;
  assign dpo[113] = \<const0> ;
  assign dpo[112] = \<const0> ;
  assign dpo[111] = \<const0> ;
  assign dpo[110] = \<const0> ;
  assign dpo[109] = \<const0> ;
  assign dpo[108] = \<const0> ;
  assign dpo[107] = \<const0> ;
  assign dpo[106] = \<const0> ;
  assign dpo[105] = \<const0> ;
  assign dpo[104] = \<const0> ;
  assign dpo[103] = \<const0> ;
  assign dpo[102] = \<const0> ;
  assign dpo[101] = \<const0> ;
  assign dpo[100] = \<const0> ;
  assign dpo[99] = \<const0> ;
  assign dpo[98] = \<const0> ;
  assign dpo[97] = \<const0> ;
  assign dpo[96] = \<const0> ;
  assign dpo[95] = \<const0> ;
  assign dpo[94] = \<const0> ;
  assign dpo[93] = \<const0> ;
  assign dpo[92] = \<const0> ;
  assign dpo[91] = \<const0> ;
  assign dpo[90] = \<const0> ;
  assign dpo[89] = \<const0> ;
  assign dpo[88] = \<const0> ;
  assign dpo[87] = \<const0> ;
  assign dpo[86] = \<const0> ;
  assign dpo[85] = \<const0> ;
  assign dpo[84] = \<const0> ;
  assign dpo[83] = \<const0> ;
  assign dpo[82] = \<const0> ;
  assign dpo[81] = \<const0> ;
  assign dpo[80] = \<const0> ;
  assign dpo[79] = \<const0> ;
  assign dpo[78] = \<const0> ;
  assign dpo[77] = \<const0> ;
  assign dpo[76] = \<const0> ;
  assign dpo[75] = \<const0> ;
  assign dpo[74] = \<const0> ;
  assign dpo[73] = \<const0> ;
  assign dpo[72] = \<const0> ;
  assign dpo[71] = \<const0> ;
  assign dpo[70] = \<const0> ;
  assign dpo[69] = \<const0> ;
  assign dpo[68] = \<const0> ;
  assign dpo[67] = \<const0> ;
  assign dpo[66] = \<const0> ;
  assign dpo[65] = \<const0> ;
  assign dpo[64] = \<const0> ;
  assign dpo[63] = \<const0> ;
  assign dpo[62] = \<const0> ;
  assign dpo[61] = \<const0> ;
  assign dpo[60] = \<const0> ;
  assign dpo[59] = \<const0> ;
  assign dpo[58] = \<const0> ;
  assign dpo[57] = \<const0> ;
  assign dpo[56] = \<const0> ;
  assign dpo[55] = \<const0> ;
  assign dpo[54] = \<const0> ;
  assign dpo[53] = \<const0> ;
  assign dpo[52] = \<const0> ;
  assign dpo[51] = \<const0> ;
  assign dpo[50] = \<const0> ;
  assign dpo[49] = \<const0> ;
  assign dpo[48] = \<const0> ;
  assign dpo[47] = \<const0> ;
  assign dpo[46] = \<const0> ;
  assign dpo[45] = \<const0> ;
  assign dpo[44] = \<const0> ;
  assign dpo[43] = \<const0> ;
  assign dpo[42] = \<const0> ;
  assign dpo[41] = \<const0> ;
  assign dpo[40] = \<const0> ;
  assign dpo[39] = \<const0> ;
  assign dpo[38] = \<const0> ;
  assign dpo[37] = \<const0> ;
  assign dpo[36] = \<const0> ;
  assign dpo[35] = \<const0> ;
  assign dpo[34] = \<const0> ;
  assign dpo[33] = \<const0> ;
  assign dpo[32] = \<const0> ;
  assign dpo[31] = \<const0> ;
  assign dpo[30] = \<const0> ;
  assign dpo[29] = \<const0> ;
  assign dpo[28] = \<const0> ;
  assign dpo[27] = \<const0> ;
  assign dpo[26] = \<const0> ;
  assign dpo[25] = \<const0> ;
  assign dpo[24] = \<const0> ;
  assign dpo[23] = \<const0> ;
  assign dpo[22] = \<const0> ;
  assign dpo[21] = \<const0> ;
  assign dpo[20] = \<const0> ;
  assign dpo[19] = \<const0> ;
  assign dpo[18] = \<const0> ;
  assign dpo[17] = \<const0> ;
  assign dpo[16] = \<const0> ;
  assign dpo[15] = \<const0> ;
  assign dpo[14] = \<const0> ;
  assign dpo[13] = \<const0> ;
  assign dpo[12] = \<const0> ;
  assign dpo[11] = \<const0> ;
  assign dpo[10] = \<const0> ;
  assign dpo[9] = \<const0> ;
  assign dpo[8] = \<const0> ;
  assign dpo[7] = \<const0> ;
  assign dpo[6] = \<const0> ;
  assign dpo[5] = \<const0> ;
  assign dpo[4] = \<const0> ;
  assign dpo[3] = \<const0> ;
  assign dpo[2] = \<const0> ;
  assign dpo[1] = \<const0> ;
  assign dpo[0] = \<const0> ;
  assign qspo[177] = \<const0> ;
  assign qspo[176] = \<const0> ;
  assign qspo[175] = \<const0> ;
  assign qspo[174] = \<const0> ;
  assign qspo[173] = \<const0> ;
  assign qspo[172] = \<const0> ;
  assign qspo[171] = \<const0> ;
  assign qspo[170] = \<const0> ;
  assign qspo[169] = \<const0> ;
  assign qspo[168] = \<const0> ;
  assign qspo[167] = \<const0> ;
  assign qspo[166] = \<const0> ;
  assign qspo[165] = \<const0> ;
  assign qspo[164] = \<const0> ;
  assign qspo[163] = \<const0> ;
  assign qspo[162] = \<const0> ;
  assign qspo[161] = \<const0> ;
  assign qspo[160] = \<const0> ;
  assign qspo[159] = \<const0> ;
  assign qspo[158] = \<const0> ;
  assign qspo[157] = \<const0> ;
  assign qspo[156] = \<const0> ;
  assign qspo[155] = \<const0> ;
  assign qspo[154] = \<const0> ;
  assign qspo[153] = \<const0> ;
  assign qspo[152] = \<const0> ;
  assign qspo[151] = \<const0> ;
  assign qspo[150] = \<const0> ;
  assign qspo[149] = \<const0> ;
  assign qspo[148] = \<const0> ;
  assign qspo[147] = \<const0> ;
  assign qspo[146] = \<const0> ;
  assign qspo[145] = \<const0> ;
  assign qspo[144] = \<const0> ;
  assign qspo[143] = \<const0> ;
  assign qspo[142] = \<const0> ;
  assign qspo[141] = \<const0> ;
  assign qspo[140] = \<const0> ;
  assign qspo[139] = \<const0> ;
  assign qspo[138] = \<const0> ;
  assign qspo[137] = \<const0> ;
  assign qspo[136] = \<const0> ;
  assign qspo[135] = \<const0> ;
  assign qspo[134] = \<const0> ;
  assign qspo[133] = \<const0> ;
  assign qspo[132] = \<const0> ;
  assign qspo[131] = \<const0> ;
  assign qspo[130] = \<const0> ;
  assign qspo[129] = \<const0> ;
  assign qspo[128] = \<const0> ;
  assign qspo[127] = \<const0> ;
  assign qspo[126] = \<const0> ;
  assign qspo[125] = \<const0> ;
  assign qspo[124] = \<const0> ;
  assign qspo[123] = \<const0> ;
  assign qspo[122] = \<const0> ;
  assign qspo[121] = \<const0> ;
  assign qspo[120] = \<const0> ;
  assign qspo[119] = \<const0> ;
  assign qspo[118] = \<const0> ;
  assign qspo[117] = \<const0> ;
  assign qspo[116] = \<const0> ;
  assign qspo[115] = \<const0> ;
  assign qspo[114] = \<const0> ;
  assign qspo[113] = \<const0> ;
  assign qspo[112] = \<const0> ;
  assign qspo[111] = \<const0> ;
  assign qspo[110] = \<const0> ;
  assign qspo[109] = \<const0> ;
  assign qspo[108] = \<const0> ;
  assign qspo[107] = \<const0> ;
  assign qspo[106] = \<const0> ;
  assign qspo[105] = \<const0> ;
  assign qspo[104] = \<const0> ;
  assign qspo[103] = \<const0> ;
  assign qspo[102] = \<const0> ;
  assign qspo[101] = \<const0> ;
  assign qspo[100] = \<const0> ;
  assign qspo[99] = \<const0> ;
  assign qspo[98] = \<const0> ;
  assign qspo[97] = \<const0> ;
  assign qspo[96] = \<const0> ;
  assign qspo[95] = \<const0> ;
  assign qspo[94] = \<const0> ;
  assign qspo[93] = \<const0> ;
  assign qspo[92] = \<const0> ;
  assign qspo[91] = \<const0> ;
  assign qspo[90] = \<const0> ;
  assign qspo[89] = \<const0> ;
  assign qspo[88] = \<const0> ;
  assign qspo[87] = \<const0> ;
  assign qspo[86] = \<const0> ;
  assign qspo[85] = \<const0> ;
  assign qspo[84] = \<const0> ;
  assign qspo[83] = \<const0> ;
  assign qspo[82] = \<const0> ;
  assign qspo[81] = \<const0> ;
  assign qspo[80] = \<const0> ;
  assign qspo[79] = \<const0> ;
  assign qspo[78] = \<const0> ;
  assign qspo[77] = \<const0> ;
  assign qspo[76] = \<const0> ;
  assign qspo[75] = \<const0> ;
  assign qspo[74] = \<const0> ;
  assign qspo[73] = \<const0> ;
  assign qspo[72] = \<const0> ;
  assign qspo[71] = \<const0> ;
  assign qspo[70] = \<const0> ;
  assign qspo[69] = \<const0> ;
  assign qspo[68] = \<const0> ;
  assign qspo[67] = \<const0> ;
  assign qspo[66] = \<const0> ;
  assign qspo[65] = \<const0> ;
  assign qspo[64] = \<const0> ;
  assign qspo[63] = \<const0> ;
  assign qspo[62] = \<const0> ;
  assign qspo[61] = \<const0> ;
  assign qspo[60] = \<const0> ;
  assign qspo[59] = \<const0> ;
  assign qspo[58] = \<const0> ;
  assign qspo[57] = \<const0> ;
  assign qspo[56] = \<const0> ;
  assign qspo[55] = \<const0> ;
  assign qspo[54] = \<const0> ;
  assign qspo[53] = \<const0> ;
  assign qspo[52] = \<const0> ;
  assign qspo[51] = \<const0> ;
  assign qspo[50] = \<const0> ;
  assign qspo[49] = \<const0> ;
  assign qspo[48] = \<const0> ;
  assign qspo[47] = \<const0> ;
  assign qspo[46] = \<const0> ;
  assign qspo[45] = \<const0> ;
  assign qspo[44] = \<const0> ;
  assign qspo[43] = \<const0> ;
  assign qspo[42] = \<const0> ;
  assign qspo[41] = \<const0> ;
  assign qspo[40] = \<const0> ;
  assign qspo[39] = \<const0> ;
  assign qspo[38] = \<const0> ;
  assign qspo[37] = \<const0> ;
  assign qspo[36] = \<const0> ;
  assign qspo[35] = \<const0> ;
  assign qspo[34] = \<const0> ;
  assign qspo[33] = \<const0> ;
  assign qspo[32] = \<const0> ;
  assign qspo[31] = \<const0> ;
  assign qspo[30] = \<const0> ;
  assign qspo[29] = \<const0> ;
  assign qspo[28] = \<const0> ;
  assign qspo[27] = \<const0> ;
  assign qspo[26] = \<const0> ;
  assign qspo[25] = \<const0> ;
  assign qspo[24] = \<const0> ;
  assign qspo[23] = \<const0> ;
  assign qspo[22] = \<const0> ;
  assign qspo[21] = \<const0> ;
  assign qspo[20] = \<const0> ;
  assign qspo[19] = \<const0> ;
  assign qspo[18] = \<const0> ;
  assign qspo[17] = \<const0> ;
  assign qspo[16] = \<const0> ;
  assign qspo[15] = \<const0> ;
  assign qspo[14] = \<const0> ;
  assign qspo[13] = \<const0> ;
  assign qspo[12] = \<const0> ;
  assign qspo[11] = \<const0> ;
  assign qspo[10] = \<const0> ;
  assign qspo[9] = \<const0> ;
  assign qspo[8] = \<const0> ;
  assign qspo[7] = \<const0> ;
  assign qspo[6] = \<const0> ;
  assign qspo[5] = \<const0> ;
  assign qspo[4] = \<const0> ;
  assign qspo[3] = \<const0> ;
  assign qspo[2] = \<const0> ;
  assign qspo[1] = \<const0> ;
  assign qspo[0] = \<const0> ;
  assign spo[177] = \<const0> ;
  assign spo[176] = \<const0> ;
  assign spo[175] = \<const0> ;
  assign spo[174] = \<const0> ;
  assign spo[173] = \<const0> ;
  assign spo[172] = \<const0> ;
  assign spo[171] = \<const0> ;
  assign spo[170] = \<const0> ;
  assign spo[169] = \<const0> ;
  assign spo[168] = \<const0> ;
  assign spo[167] = \<const0> ;
  assign spo[166] = \<const0> ;
  assign spo[165] = \<const0> ;
  assign spo[164] = \<const0> ;
  assign spo[163] = \<const0> ;
  assign spo[162] = \<const0> ;
  assign spo[161] = \<const0> ;
  assign spo[160] = \<const0> ;
  assign spo[159] = \<const0> ;
  assign spo[158] = \<const0> ;
  assign spo[157] = \<const0> ;
  assign spo[156] = \<const0> ;
  assign spo[155] = \<const0> ;
  assign spo[154] = \<const0> ;
  assign spo[153] = \<const0> ;
  assign spo[152] = \<const0> ;
  assign spo[151] = \<const0> ;
  assign spo[150] = \<const0> ;
  assign spo[149] = \<const0> ;
  assign spo[148] = \<const0> ;
  assign spo[147] = \<const0> ;
  assign spo[146] = \<const0> ;
  assign spo[145] = \<const0> ;
  assign spo[144] = \<const0> ;
  assign spo[143] = \<const0> ;
  assign spo[142] = \<const0> ;
  assign spo[141] = \<const0> ;
  assign spo[140] = \<const0> ;
  assign spo[139] = \<const0> ;
  assign spo[138] = \<const0> ;
  assign spo[137] = \<const0> ;
  assign spo[136] = \<const0> ;
  assign spo[135] = \<const0> ;
  assign spo[134] = \<const0> ;
  assign spo[133] = \<const0> ;
  assign spo[132] = \<const0> ;
  assign spo[131] = \<const0> ;
  assign spo[130] = \<const0> ;
  assign spo[129] = \<const0> ;
  assign spo[128] = \<const0> ;
  assign spo[127] = \<const0> ;
  assign spo[126] = \<const0> ;
  assign spo[125] = \<const0> ;
  assign spo[124] = \<const0> ;
  assign spo[123] = \<const0> ;
  assign spo[122] = \<const0> ;
  assign spo[121] = \<const0> ;
  assign spo[120] = \<const0> ;
  assign spo[119] = \<const0> ;
  assign spo[118] = \<const0> ;
  assign spo[117] = \<const0> ;
  assign spo[116] = \<const0> ;
  assign spo[115] = \<const0> ;
  assign spo[114] = \<const0> ;
  assign spo[113] = \<const0> ;
  assign spo[112] = \<const0> ;
  assign spo[111] = \<const0> ;
  assign spo[110] = \<const0> ;
  assign spo[109] = \<const0> ;
  assign spo[108] = \<const0> ;
  assign spo[107] = \<const0> ;
  assign spo[106] = \<const0> ;
  assign spo[105] = \<const0> ;
  assign spo[104] = \<const0> ;
  assign spo[103] = \<const0> ;
  assign spo[102] = \<const0> ;
  assign spo[101] = \<const0> ;
  assign spo[100] = \<const0> ;
  assign spo[99] = \<const0> ;
  assign spo[98] = \<const0> ;
  assign spo[97] = \<const0> ;
  assign spo[96] = \<const0> ;
  assign spo[95] = \<const0> ;
  assign spo[94] = \<const0> ;
  assign spo[93] = \<const0> ;
  assign spo[92] = \<const0> ;
  assign spo[91] = \<const0> ;
  assign spo[90] = \<const0> ;
  assign spo[89] = \<const0> ;
  assign spo[88] = \<const0> ;
  assign spo[87] = \<const0> ;
  assign spo[86] = \<const0> ;
  assign spo[85] = \<const0> ;
  assign spo[84] = \<const0> ;
  assign spo[83] = \<const0> ;
  assign spo[82] = \<const0> ;
  assign spo[81] = \<const0> ;
  assign spo[80] = \<const0> ;
  assign spo[79] = \<const0> ;
  assign spo[78] = \<const0> ;
  assign spo[77] = \<const0> ;
  assign spo[76] = \<const0> ;
  assign spo[75] = \<const0> ;
  assign spo[74] = \<const0> ;
  assign spo[73] = \<const0> ;
  assign spo[72] = \<const0> ;
  assign spo[71] = \<const0> ;
  assign spo[70] = \<const0> ;
  assign spo[69] = \<const0> ;
  assign spo[68] = \<const0> ;
  assign spo[67] = \<const0> ;
  assign spo[66] = \<const0> ;
  assign spo[65] = \<const0> ;
  assign spo[64] = \<const0> ;
  assign spo[63] = \<const0> ;
  assign spo[62] = \<const0> ;
  assign spo[61] = \<const0> ;
  assign spo[60] = \<const0> ;
  assign spo[59] = \<const0> ;
  assign spo[58] = \<const0> ;
  assign spo[57] = \<const0> ;
  assign spo[56] = \<const0> ;
  assign spo[55] = \<const0> ;
  assign spo[54] = \<const0> ;
  assign spo[53] = \<const0> ;
  assign spo[52] = \<const0> ;
  assign spo[51] = \<const0> ;
  assign spo[50] = \<const0> ;
  assign spo[49] = \<const0> ;
  assign spo[48] = \<const0> ;
  assign spo[47] = \<const0> ;
  assign spo[46] = \<const0> ;
  assign spo[45] = \<const0> ;
  assign spo[44] = \<const0> ;
  assign spo[43] = \<const0> ;
  assign spo[42] = \<const0> ;
  assign spo[41] = \<const0> ;
  assign spo[40] = \<const0> ;
  assign spo[39] = \<const0> ;
  assign spo[38] = \<const0> ;
  assign spo[37] = \<const0> ;
  assign spo[36] = \<const0> ;
  assign spo[35] = \<const0> ;
  assign spo[34] = \<const0> ;
  assign spo[33] = \<const0> ;
  assign spo[32] = \<const0> ;
  assign spo[31] = \<const0> ;
  assign spo[30] = \<const0> ;
  assign spo[29] = \<const0> ;
  assign spo[28] = \<const0> ;
  assign spo[27] = \<const0> ;
  assign spo[26] = \<const0> ;
  assign spo[25] = \<const0> ;
  assign spo[24] = \<const0> ;
  assign spo[23] = \<const0> ;
  assign spo[22] = \<const0> ;
  assign spo[21] = \<const0> ;
  assign spo[20] = \<const0> ;
  assign spo[19] = \<const0> ;
  assign spo[18] = \<const0> ;
  assign spo[17] = \<const0> ;
  assign spo[16] = \<const0> ;
  assign spo[15] = \<const0> ;
  assign spo[14] = \<const0> ;
  assign spo[13] = \<const0> ;
  assign spo[12] = \<const0> ;
  assign spo[11] = \<const0> ;
  assign spo[10] = \<const0> ;
  assign spo[9] = \<const0> ;
  assign spo[8] = \<const0> ;
  assign spo[7] = \<const0> ;
  assign spo[6] = \<const0> ;
  assign spo[5] = \<const0> ;
  assign spo[4] = \<const0> ;
  assign spo[3] = \<const0> ;
  assign spo[2] = \<const0> ;
  assign spo[1] = \<const0> ;
  assign spo[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  px_8chddcs4_fmtrmem_dist_mem_gen_v8_0_11_synth \synth_options.dist_mem_inst 
       (.a(a),
        .clk(clk),
        .d(d),
        .dpra(dpra),
        .qdpo(qdpo),
        .we(we));
endmodule

(* ORIG_REF_NAME = "dist_mem_gen_v8_0_11_synth" *) 
module px_8chddcs4_fmtrmem_dist_mem_gen_v8_0_11_synth
   (qdpo,
    a,
    clk,
    d,
    dpra,
    we);
  output [177:0]qdpo;
  input [3:0]a;
  input clk;
  input [177:0]d;
  input [3:0]dpra;
  input we;

  wire [3:0]a;
  wire clk;
  wire [177:0]d;
  wire [3:0]dpra;
  wire [177:0]qdpo;
  wire we;

  px_8chddcs4_fmtrmem_sdpram \gen_sdp_ram.sdpram_inst 
       (.a(a),
        .clk(clk),
        .d(d),
        .dpra(dpra),
        .qdpo(qdpo),
        .we(we));
endmodule

(* ORIG_REF_NAME = "sdpram" *) 
module px_8chddcs4_fmtrmem_sdpram
   (qdpo,
    a,
    clk,
    d,
    dpra,
    we);
  output [177:0]qdpo;
  input [3:0]a;
  input clk;
  input [177:0]d;
  input [3:0]dpra;
  input we;

  wire [3:0]a;
  wire [3:0]a_reg;
  wire clk;
  wire [177:0]d;
  wire [177:0]d_reg;
  wire [3:0]dpra;
  (* RTL_KEEP = "true" *) wire [177:0]qsdpo_int;
  wire [177:0]sdpo_int;
  wire [3:0]sdpra_reg;
  wire we;
  wire we_reg;
  wire [1:0]NLW_ram_reg_0_15_0_5_DOH_UNCONNECTED;
  wire [1:0]NLW_ram_reg_0_15_12_17_DOH_UNCONNECTED;
  wire [1:0]NLW_ram_reg_0_15_18_23_DOH_UNCONNECTED;
  wire [1:0]NLW_ram_reg_0_15_24_29_DOH_UNCONNECTED;
  wire [1:0]NLW_ram_reg_0_15_30_35_DOH_UNCONNECTED;
  wire [1:0]NLW_ram_reg_0_15_36_41_DOH_UNCONNECTED;
  wire [1:0]NLW_ram_reg_0_15_42_47_DOH_UNCONNECTED;
  wire [1:0]NLW_ram_reg_0_15_48_53_DOH_UNCONNECTED;
  wire [1:0]NLW_ram_reg_0_15_54_59_DOH_UNCONNECTED;
  wire [1:0]NLW_ram_reg_0_15_60_65_DOH_UNCONNECTED;
  wire [1:0]NLW_ram_reg_0_15_66_71_DOH_UNCONNECTED;
  wire [1:0]NLW_ram_reg_0_15_6_11_DOH_UNCONNECTED;
  wire [1:0]NLW_ram_reg_0_15_72_77_DOF_UNCONNECTED;
  wire [1:0]NLW_ram_reg_0_15_72_77_DOG_UNCONNECTED;
  wire [1:0]NLW_ram_reg_0_15_72_77_DOH_UNCONNECTED;

  assign qdpo[177:0] = qsdpo_int;
  FDRE #(
    .INIT(1'b0)) 
    \a_reg_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(a[0]),
        .Q(a_reg[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \a_reg_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(a[1]),
        .Q(a_reg[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \a_reg_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(a[2]),
        .Q(a_reg[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \a_reg_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .D(a[3]),
        .Q(a_reg[3]),
        .R(1'b0));
  FDRE \d_reg_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(d[0]),
        .Q(d_reg[0]),
        .R(1'b0));
  FDRE \d_reg_reg[100] 
       (.C(clk),
        .CE(1'b1),
        .D(d[100]),
        .Q(d_reg[100]),
        .R(1'b0));
  FDRE \d_reg_reg[101] 
       (.C(clk),
        .CE(1'b1),
        .D(d[101]),
        .Q(d_reg[101]),
        .R(1'b0));
  FDRE \d_reg_reg[102] 
       (.C(clk),
        .CE(1'b1),
        .D(d[102]),
        .Q(d_reg[102]),
        .R(1'b0));
  FDRE \d_reg_reg[103] 
       (.C(clk),
        .CE(1'b1),
        .D(d[103]),
        .Q(d_reg[103]),
        .R(1'b0));
  FDRE \d_reg_reg[104] 
       (.C(clk),
        .CE(1'b1),
        .D(d[104]),
        .Q(d_reg[104]),
        .R(1'b0));
  FDRE \d_reg_reg[105] 
       (.C(clk),
        .CE(1'b1),
        .D(d[105]),
        .Q(d_reg[105]),
        .R(1'b0));
  FDRE \d_reg_reg[106] 
       (.C(clk),
        .CE(1'b1),
        .D(d[106]),
        .Q(d_reg[106]),
        .R(1'b0));
  FDRE \d_reg_reg[107] 
       (.C(clk),
        .CE(1'b1),
        .D(d[107]),
        .Q(d_reg[107]),
        .R(1'b0));
  FDRE \d_reg_reg[108] 
       (.C(clk),
        .CE(1'b1),
        .D(d[108]),
        .Q(d_reg[108]),
        .R(1'b0));
  FDRE \d_reg_reg[109] 
       (.C(clk),
        .CE(1'b1),
        .D(d[109]),
        .Q(d_reg[109]),
        .R(1'b0));
  FDRE \d_reg_reg[10] 
       (.C(clk),
        .CE(1'b1),
        .D(d[10]),
        .Q(d_reg[10]),
        .R(1'b0));
  FDRE \d_reg_reg[110] 
       (.C(clk),
        .CE(1'b1),
        .D(d[110]),
        .Q(d_reg[110]),
        .R(1'b0));
  FDRE \d_reg_reg[111] 
       (.C(clk),
        .CE(1'b1),
        .D(d[111]),
        .Q(d_reg[111]),
        .R(1'b0));
  FDRE \d_reg_reg[112] 
       (.C(clk),
        .CE(1'b1),
        .D(d[112]),
        .Q(d_reg[112]),
        .R(1'b0));
  FDRE \d_reg_reg[113] 
       (.C(clk),
        .CE(1'b1),
        .D(d[113]),
        .Q(d_reg[113]),
        .R(1'b0));
  FDRE \d_reg_reg[114] 
       (.C(clk),
        .CE(1'b1),
        .D(d[114]),
        .Q(d_reg[114]),
        .R(1'b0));
  FDRE \d_reg_reg[115] 
       (.C(clk),
        .CE(1'b1),
        .D(d[115]),
        .Q(d_reg[115]),
        .R(1'b0));
  FDRE \d_reg_reg[116] 
       (.C(clk),
        .CE(1'b1),
        .D(d[116]),
        .Q(d_reg[116]),
        .R(1'b0));
  FDRE \d_reg_reg[117] 
       (.C(clk),
        .CE(1'b1),
        .D(d[117]),
        .Q(d_reg[117]),
        .R(1'b0));
  FDRE \d_reg_reg[118] 
       (.C(clk),
        .CE(1'b1),
        .D(d[118]),
        .Q(d_reg[118]),
        .R(1'b0));
  FDRE \d_reg_reg[119] 
       (.C(clk),
        .CE(1'b1),
        .D(d[119]),
        .Q(d_reg[119]),
        .R(1'b0));
  FDRE \d_reg_reg[11] 
       (.C(clk),
        .CE(1'b1),
        .D(d[11]),
        .Q(d_reg[11]),
        .R(1'b0));
  FDRE \d_reg_reg[120] 
       (.C(clk),
        .CE(1'b1),
        .D(d[120]),
        .Q(d_reg[120]),
        .R(1'b0));
  FDRE \d_reg_reg[121] 
       (.C(clk),
        .CE(1'b1),
        .D(d[121]),
        .Q(d_reg[121]),
        .R(1'b0));
  FDRE \d_reg_reg[122] 
       (.C(clk),
        .CE(1'b1),
        .D(d[122]),
        .Q(d_reg[122]),
        .R(1'b0));
  FDRE \d_reg_reg[123] 
       (.C(clk),
        .CE(1'b1),
        .D(d[123]),
        .Q(d_reg[123]),
        .R(1'b0));
  FDRE \d_reg_reg[124] 
       (.C(clk),
        .CE(1'b1),
        .D(d[124]),
        .Q(d_reg[124]),
        .R(1'b0));
  FDRE \d_reg_reg[125] 
       (.C(clk),
        .CE(1'b1),
        .D(d[125]),
        .Q(d_reg[125]),
        .R(1'b0));
  FDRE \d_reg_reg[126] 
       (.C(clk),
        .CE(1'b1),
        .D(d[126]),
        .Q(d_reg[126]),
        .R(1'b0));
  FDRE \d_reg_reg[127] 
       (.C(clk),
        .CE(1'b1),
        .D(d[127]),
        .Q(d_reg[127]),
        .R(1'b0));
  FDRE \d_reg_reg[128] 
       (.C(clk),
        .CE(1'b1),
        .D(d[128]),
        .Q(d_reg[128]),
        .R(1'b0));
  FDRE \d_reg_reg[129] 
       (.C(clk),
        .CE(1'b1),
        .D(d[129]),
        .Q(d_reg[129]),
        .R(1'b0));
  FDRE \d_reg_reg[12] 
       (.C(clk),
        .CE(1'b1),
        .D(d[12]),
        .Q(d_reg[12]),
        .R(1'b0));
  FDRE \d_reg_reg[130] 
       (.C(clk),
        .CE(1'b1),
        .D(d[130]),
        .Q(d_reg[130]),
        .R(1'b0));
  FDRE \d_reg_reg[131] 
       (.C(clk),
        .CE(1'b1),
        .D(d[131]),
        .Q(d_reg[131]),
        .R(1'b0));
  FDRE \d_reg_reg[132] 
       (.C(clk),
        .CE(1'b1),
        .D(d[132]),
        .Q(d_reg[132]),
        .R(1'b0));
  FDRE \d_reg_reg[133] 
       (.C(clk),
        .CE(1'b1),
        .D(d[133]),
        .Q(d_reg[133]),
        .R(1'b0));
  FDRE \d_reg_reg[134] 
       (.C(clk),
        .CE(1'b1),
        .D(d[134]),
        .Q(d_reg[134]),
        .R(1'b0));
  FDRE \d_reg_reg[135] 
       (.C(clk),
        .CE(1'b1),
        .D(d[135]),
        .Q(d_reg[135]),
        .R(1'b0));
  FDRE \d_reg_reg[136] 
       (.C(clk),
        .CE(1'b1),
        .D(d[136]),
        .Q(d_reg[136]),
        .R(1'b0));
  FDRE \d_reg_reg[137] 
       (.C(clk),
        .CE(1'b1),
        .D(d[137]),
        .Q(d_reg[137]),
        .R(1'b0));
  FDRE \d_reg_reg[138] 
       (.C(clk),
        .CE(1'b1),
        .D(d[138]),
        .Q(d_reg[138]),
        .R(1'b0));
  FDRE \d_reg_reg[139] 
       (.C(clk),
        .CE(1'b1),
        .D(d[139]),
        .Q(d_reg[139]),
        .R(1'b0));
  FDRE \d_reg_reg[13] 
       (.C(clk),
        .CE(1'b1),
        .D(d[13]),
        .Q(d_reg[13]),
        .R(1'b0));
  FDRE \d_reg_reg[140] 
       (.C(clk),
        .CE(1'b1),
        .D(d[140]),
        .Q(d_reg[140]),
        .R(1'b0));
  FDRE \d_reg_reg[141] 
       (.C(clk),
        .CE(1'b1),
        .D(d[141]),
        .Q(d_reg[141]),
        .R(1'b0));
  FDRE \d_reg_reg[142] 
       (.C(clk),
        .CE(1'b1),
        .D(d[142]),
        .Q(d_reg[142]),
        .R(1'b0));
  FDRE \d_reg_reg[143] 
       (.C(clk),
        .CE(1'b1),
        .D(d[143]),
        .Q(d_reg[143]),
        .R(1'b0));
  FDRE \d_reg_reg[144] 
       (.C(clk),
        .CE(1'b1),
        .D(d[144]),
        .Q(d_reg[144]),
        .R(1'b0));
  FDRE \d_reg_reg[145] 
       (.C(clk),
        .CE(1'b1),
        .D(d[145]),
        .Q(d_reg[145]),
        .R(1'b0));
  FDRE \d_reg_reg[146] 
       (.C(clk),
        .CE(1'b1),
        .D(d[146]),
        .Q(d_reg[146]),
        .R(1'b0));
  FDRE \d_reg_reg[147] 
       (.C(clk),
        .CE(1'b1),
        .D(d[147]),
        .Q(d_reg[147]),
        .R(1'b0));
  FDRE \d_reg_reg[148] 
       (.C(clk),
        .CE(1'b1),
        .D(d[148]),
        .Q(d_reg[148]),
        .R(1'b0));
  FDRE \d_reg_reg[149] 
       (.C(clk),
        .CE(1'b1),
        .D(d[149]),
        .Q(d_reg[149]),
        .R(1'b0));
  FDRE \d_reg_reg[14] 
       (.C(clk),
        .CE(1'b1),
        .D(d[14]),
        .Q(d_reg[14]),
        .R(1'b0));
  FDRE \d_reg_reg[150] 
       (.C(clk),
        .CE(1'b1),
        .D(d[150]),
        .Q(d_reg[150]),
        .R(1'b0));
  FDRE \d_reg_reg[151] 
       (.C(clk),
        .CE(1'b1),
        .D(d[151]),
        .Q(d_reg[151]),
        .R(1'b0));
  FDRE \d_reg_reg[152] 
       (.C(clk),
        .CE(1'b1),
        .D(d[152]),
        .Q(d_reg[152]),
        .R(1'b0));
  FDRE \d_reg_reg[153] 
       (.C(clk),
        .CE(1'b1),
        .D(d[153]),
        .Q(d_reg[153]),
        .R(1'b0));
  FDRE \d_reg_reg[154] 
       (.C(clk),
        .CE(1'b1),
        .D(d[154]),
        .Q(d_reg[154]),
        .R(1'b0));
  FDRE \d_reg_reg[155] 
       (.C(clk),
        .CE(1'b1),
        .D(d[155]),
        .Q(d_reg[155]),
        .R(1'b0));
  FDRE \d_reg_reg[156] 
       (.C(clk),
        .CE(1'b1),
        .D(d[156]),
        .Q(d_reg[156]),
        .R(1'b0));
  FDRE \d_reg_reg[157] 
       (.C(clk),
        .CE(1'b1),
        .D(d[157]),
        .Q(d_reg[157]),
        .R(1'b0));
  FDRE \d_reg_reg[158] 
       (.C(clk),
        .CE(1'b1),
        .D(d[158]),
        .Q(d_reg[158]),
        .R(1'b0));
  FDRE \d_reg_reg[159] 
       (.C(clk),
        .CE(1'b1),
        .D(d[159]),
        .Q(d_reg[159]),
        .R(1'b0));
  FDRE \d_reg_reg[15] 
       (.C(clk),
        .CE(1'b1),
        .D(d[15]),
        .Q(d_reg[15]),
        .R(1'b0));
  FDRE \d_reg_reg[160] 
       (.C(clk),
        .CE(1'b1),
        .D(d[160]),
        .Q(d_reg[160]),
        .R(1'b0));
  FDRE \d_reg_reg[161] 
       (.C(clk),
        .CE(1'b1),
        .D(d[161]),
        .Q(d_reg[161]),
        .R(1'b0));
  FDRE \d_reg_reg[162] 
       (.C(clk),
        .CE(1'b1),
        .D(d[162]),
        .Q(d_reg[162]),
        .R(1'b0));
  FDRE \d_reg_reg[163] 
       (.C(clk),
        .CE(1'b1),
        .D(d[163]),
        .Q(d_reg[163]),
        .R(1'b0));
  FDRE \d_reg_reg[164] 
       (.C(clk),
        .CE(1'b1),
        .D(d[164]),
        .Q(d_reg[164]),
        .R(1'b0));
  FDRE \d_reg_reg[165] 
       (.C(clk),
        .CE(1'b1),
        .D(d[165]),
        .Q(d_reg[165]),
        .R(1'b0));
  FDRE \d_reg_reg[166] 
       (.C(clk),
        .CE(1'b1),
        .D(d[166]),
        .Q(d_reg[166]),
        .R(1'b0));
  FDRE \d_reg_reg[167] 
       (.C(clk),
        .CE(1'b1),
        .D(d[167]),
        .Q(d_reg[167]),
        .R(1'b0));
  FDRE \d_reg_reg[168] 
       (.C(clk),
        .CE(1'b1),
        .D(d[168]),
        .Q(d_reg[168]),
        .R(1'b0));
  FDRE \d_reg_reg[169] 
       (.C(clk),
        .CE(1'b1),
        .D(d[169]),
        .Q(d_reg[169]),
        .R(1'b0));
  FDRE \d_reg_reg[16] 
       (.C(clk),
        .CE(1'b1),
        .D(d[16]),
        .Q(d_reg[16]),
        .R(1'b0));
  FDRE \d_reg_reg[170] 
       (.C(clk),
        .CE(1'b1),
        .D(d[170]),
        .Q(d_reg[170]),
        .R(1'b0));
  FDRE \d_reg_reg[171] 
       (.C(clk),
        .CE(1'b1),
        .D(d[171]),
        .Q(d_reg[171]),
        .R(1'b0));
  FDRE \d_reg_reg[172] 
       (.C(clk),
        .CE(1'b1),
        .D(d[172]),
        .Q(d_reg[172]),
        .R(1'b0));
  FDRE \d_reg_reg[173] 
       (.C(clk),
        .CE(1'b1),
        .D(d[173]),
        .Q(d_reg[173]),
        .R(1'b0));
  FDRE \d_reg_reg[174] 
       (.C(clk),
        .CE(1'b1),
        .D(d[174]),
        .Q(d_reg[174]),
        .R(1'b0));
  FDRE \d_reg_reg[175] 
       (.C(clk),
        .CE(1'b1),
        .D(d[175]),
        .Q(d_reg[175]),
        .R(1'b0));
  FDRE \d_reg_reg[176] 
       (.C(clk),
        .CE(1'b1),
        .D(d[176]),
        .Q(d_reg[176]),
        .R(1'b0));
  FDRE \d_reg_reg[177] 
       (.C(clk),
        .CE(1'b1),
        .D(d[177]),
        .Q(d_reg[177]),
        .R(1'b0));
  FDRE \d_reg_reg[17] 
       (.C(clk),
        .CE(1'b1),
        .D(d[17]),
        .Q(d_reg[17]),
        .R(1'b0));
  FDRE \d_reg_reg[18] 
       (.C(clk),
        .CE(1'b1),
        .D(d[18]),
        .Q(d_reg[18]),
        .R(1'b0));
  FDRE \d_reg_reg[19] 
       (.C(clk),
        .CE(1'b1),
        .D(d[19]),
        .Q(d_reg[19]),
        .R(1'b0));
  FDRE \d_reg_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(d[1]),
        .Q(d_reg[1]),
        .R(1'b0));
  FDRE \d_reg_reg[20] 
       (.C(clk),
        .CE(1'b1),
        .D(d[20]),
        .Q(d_reg[20]),
        .R(1'b0));
  FDRE \d_reg_reg[21] 
       (.C(clk),
        .CE(1'b1),
        .D(d[21]),
        .Q(d_reg[21]),
        .R(1'b0));
  FDRE \d_reg_reg[22] 
       (.C(clk),
        .CE(1'b1),
        .D(d[22]),
        .Q(d_reg[22]),
        .R(1'b0));
  FDRE \d_reg_reg[23] 
       (.C(clk),
        .CE(1'b1),
        .D(d[23]),
        .Q(d_reg[23]),
        .R(1'b0));
  FDRE \d_reg_reg[24] 
       (.C(clk),
        .CE(1'b1),
        .D(d[24]),
        .Q(d_reg[24]),
        .R(1'b0));
  FDRE \d_reg_reg[25] 
       (.C(clk),
        .CE(1'b1),
        .D(d[25]),
        .Q(d_reg[25]),
        .R(1'b0));
  FDRE \d_reg_reg[26] 
       (.C(clk),
        .CE(1'b1),
        .D(d[26]),
        .Q(d_reg[26]),
        .R(1'b0));
  FDRE \d_reg_reg[27] 
       (.C(clk),
        .CE(1'b1),
        .D(d[27]),
        .Q(d_reg[27]),
        .R(1'b0));
  FDRE \d_reg_reg[28] 
       (.C(clk),
        .CE(1'b1),
        .D(d[28]),
        .Q(d_reg[28]),
        .R(1'b0));
  FDRE \d_reg_reg[29] 
       (.C(clk),
        .CE(1'b1),
        .D(d[29]),
        .Q(d_reg[29]),
        .R(1'b0));
  FDRE \d_reg_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(d[2]),
        .Q(d_reg[2]),
        .R(1'b0));
  FDRE \d_reg_reg[30] 
       (.C(clk),
        .CE(1'b1),
        .D(d[30]),
        .Q(d_reg[30]),
        .R(1'b0));
  FDRE \d_reg_reg[31] 
       (.C(clk),
        .CE(1'b1),
        .D(d[31]),
        .Q(d_reg[31]),
        .R(1'b0));
  FDRE \d_reg_reg[32] 
       (.C(clk),
        .CE(1'b1),
        .D(d[32]),
        .Q(d_reg[32]),
        .R(1'b0));
  FDRE \d_reg_reg[33] 
       (.C(clk),
        .CE(1'b1),
        .D(d[33]),
        .Q(d_reg[33]),
        .R(1'b0));
  FDRE \d_reg_reg[34] 
       (.C(clk),
        .CE(1'b1),
        .D(d[34]),
        .Q(d_reg[34]),
        .R(1'b0));
  FDRE \d_reg_reg[35] 
       (.C(clk),
        .CE(1'b1),
        .D(d[35]),
        .Q(d_reg[35]),
        .R(1'b0));
  FDRE \d_reg_reg[36] 
       (.C(clk),
        .CE(1'b1),
        .D(d[36]),
        .Q(d_reg[36]),
        .R(1'b0));
  FDRE \d_reg_reg[37] 
       (.C(clk),
        .CE(1'b1),
        .D(d[37]),
        .Q(d_reg[37]),
        .R(1'b0));
  FDRE \d_reg_reg[38] 
       (.C(clk),
        .CE(1'b1),
        .D(d[38]),
        .Q(d_reg[38]),
        .R(1'b0));
  FDRE \d_reg_reg[39] 
       (.C(clk),
        .CE(1'b1),
        .D(d[39]),
        .Q(d_reg[39]),
        .R(1'b0));
  FDRE \d_reg_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .D(d[3]),
        .Q(d_reg[3]),
        .R(1'b0));
  FDRE \d_reg_reg[40] 
       (.C(clk),
        .CE(1'b1),
        .D(d[40]),
        .Q(d_reg[40]),
        .R(1'b0));
  FDRE \d_reg_reg[41] 
       (.C(clk),
        .CE(1'b1),
        .D(d[41]),
        .Q(d_reg[41]),
        .R(1'b0));
  FDRE \d_reg_reg[42] 
       (.C(clk),
        .CE(1'b1),
        .D(d[42]),
        .Q(d_reg[42]),
        .R(1'b0));
  FDRE \d_reg_reg[43] 
       (.C(clk),
        .CE(1'b1),
        .D(d[43]),
        .Q(d_reg[43]),
        .R(1'b0));
  FDRE \d_reg_reg[44] 
       (.C(clk),
        .CE(1'b1),
        .D(d[44]),
        .Q(d_reg[44]),
        .R(1'b0));
  FDRE \d_reg_reg[45] 
       (.C(clk),
        .CE(1'b1),
        .D(d[45]),
        .Q(d_reg[45]),
        .R(1'b0));
  FDRE \d_reg_reg[46] 
       (.C(clk),
        .CE(1'b1),
        .D(d[46]),
        .Q(d_reg[46]),
        .R(1'b0));
  FDRE \d_reg_reg[47] 
       (.C(clk),
        .CE(1'b1),
        .D(d[47]),
        .Q(d_reg[47]),
        .R(1'b0));
  FDRE \d_reg_reg[48] 
       (.C(clk),
        .CE(1'b1),
        .D(d[48]),
        .Q(d_reg[48]),
        .R(1'b0));
  FDRE \d_reg_reg[49] 
       (.C(clk),
        .CE(1'b1),
        .D(d[49]),
        .Q(d_reg[49]),
        .R(1'b0));
  FDRE \d_reg_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .D(d[4]),
        .Q(d_reg[4]),
        .R(1'b0));
  FDRE \d_reg_reg[50] 
       (.C(clk),
        .CE(1'b1),
        .D(d[50]),
        .Q(d_reg[50]),
        .R(1'b0));
  FDRE \d_reg_reg[51] 
       (.C(clk),
        .CE(1'b1),
        .D(d[51]),
        .Q(d_reg[51]),
        .R(1'b0));
  FDRE \d_reg_reg[52] 
       (.C(clk),
        .CE(1'b1),
        .D(d[52]),
        .Q(d_reg[52]),
        .R(1'b0));
  FDRE \d_reg_reg[53] 
       (.C(clk),
        .CE(1'b1),
        .D(d[53]),
        .Q(d_reg[53]),
        .R(1'b0));
  FDRE \d_reg_reg[54] 
       (.C(clk),
        .CE(1'b1),
        .D(d[54]),
        .Q(d_reg[54]),
        .R(1'b0));
  FDRE \d_reg_reg[55] 
       (.C(clk),
        .CE(1'b1),
        .D(d[55]),
        .Q(d_reg[55]),
        .R(1'b0));
  FDRE \d_reg_reg[56] 
       (.C(clk),
        .CE(1'b1),
        .D(d[56]),
        .Q(d_reg[56]),
        .R(1'b0));
  FDRE \d_reg_reg[57] 
       (.C(clk),
        .CE(1'b1),
        .D(d[57]),
        .Q(d_reg[57]),
        .R(1'b0));
  FDRE \d_reg_reg[58] 
       (.C(clk),
        .CE(1'b1),
        .D(d[58]),
        .Q(d_reg[58]),
        .R(1'b0));
  FDRE \d_reg_reg[59] 
       (.C(clk),
        .CE(1'b1),
        .D(d[59]),
        .Q(d_reg[59]),
        .R(1'b0));
  FDRE \d_reg_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .D(d[5]),
        .Q(d_reg[5]),
        .R(1'b0));
  FDRE \d_reg_reg[60] 
       (.C(clk),
        .CE(1'b1),
        .D(d[60]),
        .Q(d_reg[60]),
        .R(1'b0));
  FDRE \d_reg_reg[61] 
       (.C(clk),
        .CE(1'b1),
        .D(d[61]),
        .Q(d_reg[61]),
        .R(1'b0));
  FDRE \d_reg_reg[62] 
       (.C(clk),
        .CE(1'b1),
        .D(d[62]),
        .Q(d_reg[62]),
        .R(1'b0));
  FDRE \d_reg_reg[63] 
       (.C(clk),
        .CE(1'b1),
        .D(d[63]),
        .Q(d_reg[63]),
        .R(1'b0));
  FDRE \d_reg_reg[64] 
       (.C(clk),
        .CE(1'b1),
        .D(d[64]),
        .Q(d_reg[64]),
        .R(1'b0));
  FDRE \d_reg_reg[65] 
       (.C(clk),
        .CE(1'b1),
        .D(d[65]),
        .Q(d_reg[65]),
        .R(1'b0));
  FDRE \d_reg_reg[66] 
       (.C(clk),
        .CE(1'b1),
        .D(d[66]),
        .Q(d_reg[66]),
        .R(1'b0));
  FDRE \d_reg_reg[67] 
       (.C(clk),
        .CE(1'b1),
        .D(d[67]),
        .Q(d_reg[67]),
        .R(1'b0));
  FDRE \d_reg_reg[68] 
       (.C(clk),
        .CE(1'b1),
        .D(d[68]),
        .Q(d_reg[68]),
        .R(1'b0));
  FDRE \d_reg_reg[69] 
       (.C(clk),
        .CE(1'b1),
        .D(d[69]),
        .Q(d_reg[69]),
        .R(1'b0));
  FDRE \d_reg_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .D(d[6]),
        .Q(d_reg[6]),
        .R(1'b0));
  FDRE \d_reg_reg[70] 
       (.C(clk),
        .CE(1'b1),
        .D(d[70]),
        .Q(d_reg[70]),
        .R(1'b0));
  FDRE \d_reg_reg[71] 
       (.C(clk),
        .CE(1'b1),
        .D(d[71]),
        .Q(d_reg[71]),
        .R(1'b0));
  FDRE \d_reg_reg[72] 
       (.C(clk),
        .CE(1'b1),
        .D(d[72]),
        .Q(d_reg[72]),
        .R(1'b0));
  FDRE \d_reg_reg[73] 
       (.C(clk),
        .CE(1'b1),
        .D(d[73]),
        .Q(d_reg[73]),
        .R(1'b0));
  FDRE \d_reg_reg[74] 
       (.C(clk),
        .CE(1'b1),
        .D(d[74]),
        .Q(d_reg[74]),
        .R(1'b0));
  FDRE \d_reg_reg[75] 
       (.C(clk),
        .CE(1'b1),
        .D(d[75]),
        .Q(d_reg[75]),
        .R(1'b0));
  FDRE \d_reg_reg[76] 
       (.C(clk),
        .CE(1'b1),
        .D(d[76]),
        .Q(d_reg[76]),
        .R(1'b0));
  FDRE \d_reg_reg[77] 
       (.C(clk),
        .CE(1'b1),
        .D(d[77]),
        .Q(d_reg[77]),
        .R(1'b0));
  FDRE \d_reg_reg[78] 
       (.C(clk),
        .CE(1'b1),
        .D(d[78]),
        .Q(d_reg[78]),
        .R(1'b0));
  FDRE \d_reg_reg[79] 
       (.C(clk),
        .CE(1'b1),
        .D(d[79]),
        .Q(d_reg[79]),
        .R(1'b0));
  FDRE \d_reg_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .D(d[7]),
        .Q(d_reg[7]),
        .R(1'b0));
  FDRE \d_reg_reg[80] 
       (.C(clk),
        .CE(1'b1),
        .D(d[80]),
        .Q(d_reg[80]),
        .R(1'b0));
  FDRE \d_reg_reg[81] 
       (.C(clk),
        .CE(1'b1),
        .D(d[81]),
        .Q(d_reg[81]),
        .R(1'b0));
  FDRE \d_reg_reg[82] 
       (.C(clk),
        .CE(1'b1),
        .D(d[82]),
        .Q(d_reg[82]),
        .R(1'b0));
  FDRE \d_reg_reg[83] 
       (.C(clk),
        .CE(1'b1),
        .D(d[83]),
        .Q(d_reg[83]),
        .R(1'b0));
  FDRE \d_reg_reg[84] 
       (.C(clk),
        .CE(1'b1),
        .D(d[84]),
        .Q(d_reg[84]),
        .R(1'b0));
  FDRE \d_reg_reg[85] 
       (.C(clk),
        .CE(1'b1),
        .D(d[85]),
        .Q(d_reg[85]),
        .R(1'b0));
  FDRE \d_reg_reg[86] 
       (.C(clk),
        .CE(1'b1),
        .D(d[86]),
        .Q(d_reg[86]),
        .R(1'b0));
  FDRE \d_reg_reg[87] 
       (.C(clk),
        .CE(1'b1),
        .D(d[87]),
        .Q(d_reg[87]),
        .R(1'b0));
  FDRE \d_reg_reg[88] 
       (.C(clk),
        .CE(1'b1),
        .D(d[88]),
        .Q(d_reg[88]),
        .R(1'b0));
  FDRE \d_reg_reg[89] 
       (.C(clk),
        .CE(1'b1),
        .D(d[89]),
        .Q(d_reg[89]),
        .R(1'b0));
  FDRE \d_reg_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .D(d[8]),
        .Q(d_reg[8]),
        .R(1'b0));
  FDRE \d_reg_reg[90] 
       (.C(clk),
        .CE(1'b1),
        .D(d[90]),
        .Q(d_reg[90]),
        .R(1'b0));
  FDRE \d_reg_reg[91] 
       (.C(clk),
        .CE(1'b1),
        .D(d[91]),
        .Q(d_reg[91]),
        .R(1'b0));
  FDRE \d_reg_reg[92] 
       (.C(clk),
        .CE(1'b1),
        .D(d[92]),
        .Q(d_reg[92]),
        .R(1'b0));
  FDRE \d_reg_reg[93] 
       (.C(clk),
        .CE(1'b1),
        .D(d[93]),
        .Q(d_reg[93]),
        .R(1'b0));
  FDRE \d_reg_reg[94] 
       (.C(clk),
        .CE(1'b1),
        .D(d[94]),
        .Q(d_reg[94]),
        .R(1'b0));
  FDRE \d_reg_reg[95] 
       (.C(clk),
        .CE(1'b1),
        .D(d[95]),
        .Q(d_reg[95]),
        .R(1'b0));
  FDRE \d_reg_reg[96] 
       (.C(clk),
        .CE(1'b1),
        .D(d[96]),
        .Q(d_reg[96]),
        .R(1'b0));
  FDRE \d_reg_reg[97] 
       (.C(clk),
        .CE(1'b1),
        .D(d[97]),
        .Q(d_reg[97]),
        .R(1'b0));
  FDRE \d_reg_reg[98] 
       (.C(clk),
        .CE(1'b1),
        .D(d[98]),
        .Q(d_reg[98]),
        .R(1'b0));
  FDRE \d_reg_reg[99] 
       (.C(clk),
        .CE(1'b1),
        .D(d[99]),
        .Q(d_reg[99]),
        .R(1'b0));
  FDRE \d_reg_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .D(d[9]),
        .Q(d_reg[9]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[0]),
        .Q(qsdpo_int[0]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[100] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[100]),
        .Q(qsdpo_int[100]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[101] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[101]),
        .Q(qsdpo_int[101]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[102] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[102]),
        .Q(qsdpo_int[102]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[103] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[103]),
        .Q(qsdpo_int[103]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[104] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[104]),
        .Q(qsdpo_int[104]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[105] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[105]),
        .Q(qsdpo_int[105]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[106] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[106]),
        .Q(qsdpo_int[106]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[107] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[107]),
        .Q(qsdpo_int[107]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[108] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[108]),
        .Q(qsdpo_int[108]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[109] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[109]),
        .Q(qsdpo_int[109]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[10] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[10]),
        .Q(qsdpo_int[10]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[110] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[110]),
        .Q(qsdpo_int[110]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[111] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[111]),
        .Q(qsdpo_int[111]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[112] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[112]),
        .Q(qsdpo_int[112]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[113] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[113]),
        .Q(qsdpo_int[113]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[114] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[114]),
        .Q(qsdpo_int[114]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[115] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[115]),
        .Q(qsdpo_int[115]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[116] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[116]),
        .Q(qsdpo_int[116]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[117] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[117]),
        .Q(qsdpo_int[117]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[118] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[118]),
        .Q(qsdpo_int[118]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[119] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[119]),
        .Q(qsdpo_int[119]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[11] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[11]),
        .Q(qsdpo_int[11]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[120] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[120]),
        .Q(qsdpo_int[120]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[121] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[121]),
        .Q(qsdpo_int[121]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[122] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[122]),
        .Q(qsdpo_int[122]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[123] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[123]),
        .Q(qsdpo_int[123]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[124] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[124]),
        .Q(qsdpo_int[124]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[125] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[125]),
        .Q(qsdpo_int[125]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[126] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[126]),
        .Q(qsdpo_int[126]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[127] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[127]),
        .Q(qsdpo_int[127]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[128] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[128]),
        .Q(qsdpo_int[128]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[129] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[129]),
        .Q(qsdpo_int[129]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[12] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[12]),
        .Q(qsdpo_int[12]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[130] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[130]),
        .Q(qsdpo_int[130]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[131] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[131]),
        .Q(qsdpo_int[131]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[132] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[132]),
        .Q(qsdpo_int[132]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[133] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[133]),
        .Q(qsdpo_int[133]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[134] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[134]),
        .Q(qsdpo_int[134]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[135] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[135]),
        .Q(qsdpo_int[135]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[136] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[136]),
        .Q(qsdpo_int[136]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[137] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[137]),
        .Q(qsdpo_int[137]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[138] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[138]),
        .Q(qsdpo_int[138]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[139] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[139]),
        .Q(qsdpo_int[139]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[13] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[13]),
        .Q(qsdpo_int[13]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[140] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[140]),
        .Q(qsdpo_int[140]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[141] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[141]),
        .Q(qsdpo_int[141]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[142] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[142]),
        .Q(qsdpo_int[142]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[143] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[143]),
        .Q(qsdpo_int[143]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[144] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[144]),
        .Q(qsdpo_int[144]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[145] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[145]),
        .Q(qsdpo_int[145]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[146] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[146]),
        .Q(qsdpo_int[146]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[147] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[147]),
        .Q(qsdpo_int[147]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[148] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[148]),
        .Q(qsdpo_int[148]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[149] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[149]),
        .Q(qsdpo_int[149]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[14] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[14]),
        .Q(qsdpo_int[14]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[150] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[150]),
        .Q(qsdpo_int[150]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[151] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[151]),
        .Q(qsdpo_int[151]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[152] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[152]),
        .Q(qsdpo_int[152]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[153] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[153]),
        .Q(qsdpo_int[153]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[154] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[154]),
        .Q(qsdpo_int[154]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[155] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[155]),
        .Q(qsdpo_int[155]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[156] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[156]),
        .Q(qsdpo_int[156]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[157] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[157]),
        .Q(qsdpo_int[157]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[158] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[158]),
        .Q(qsdpo_int[158]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[159] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[159]),
        .Q(qsdpo_int[159]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[15] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[15]),
        .Q(qsdpo_int[15]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[160] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[160]),
        .Q(qsdpo_int[160]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[161] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[161]),
        .Q(qsdpo_int[161]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[162] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[162]),
        .Q(qsdpo_int[162]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[163] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[163]),
        .Q(qsdpo_int[163]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[164] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[164]),
        .Q(qsdpo_int[164]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[165] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[165]),
        .Q(qsdpo_int[165]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[166] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[166]),
        .Q(qsdpo_int[166]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[167] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[167]),
        .Q(qsdpo_int[167]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[168] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[168]),
        .Q(qsdpo_int[168]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[169] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[169]),
        .Q(qsdpo_int[169]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[16] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[16]),
        .Q(qsdpo_int[16]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[170] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[170]),
        .Q(qsdpo_int[170]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[171] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[171]),
        .Q(qsdpo_int[171]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[172] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[172]),
        .Q(qsdpo_int[172]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[173] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[173]),
        .Q(qsdpo_int[173]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[174] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[174]),
        .Q(qsdpo_int[174]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[175] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[175]),
        .Q(qsdpo_int[175]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[176] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[176]),
        .Q(qsdpo_int[176]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[177] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[177]),
        .Q(qsdpo_int[177]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[17] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[17]),
        .Q(qsdpo_int[17]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[18] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[18]),
        .Q(qsdpo_int[18]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[19] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[19]),
        .Q(qsdpo_int[19]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[1]),
        .Q(qsdpo_int[1]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[20] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[20]),
        .Q(qsdpo_int[20]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[21] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[21]),
        .Q(qsdpo_int[21]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[22] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[22]),
        .Q(qsdpo_int[22]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[23] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[23]),
        .Q(qsdpo_int[23]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[24] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[24]),
        .Q(qsdpo_int[24]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[25] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[25]),
        .Q(qsdpo_int[25]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[26] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[26]),
        .Q(qsdpo_int[26]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[27] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[27]),
        .Q(qsdpo_int[27]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[28] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[28]),
        .Q(qsdpo_int[28]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[29] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[29]),
        .Q(qsdpo_int[29]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[2]),
        .Q(qsdpo_int[2]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[30] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[30]),
        .Q(qsdpo_int[30]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[31] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[31]),
        .Q(qsdpo_int[31]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[32] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[32]),
        .Q(qsdpo_int[32]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[33] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[33]),
        .Q(qsdpo_int[33]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[34] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[34]),
        .Q(qsdpo_int[34]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[35] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[35]),
        .Q(qsdpo_int[35]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[36] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[36]),
        .Q(qsdpo_int[36]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[37] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[37]),
        .Q(qsdpo_int[37]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[38] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[38]),
        .Q(qsdpo_int[38]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[39] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[39]),
        .Q(qsdpo_int[39]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[3]),
        .Q(qsdpo_int[3]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[40] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[40]),
        .Q(qsdpo_int[40]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[41] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[41]),
        .Q(qsdpo_int[41]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[42] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[42]),
        .Q(qsdpo_int[42]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[43] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[43]),
        .Q(qsdpo_int[43]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[44] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[44]),
        .Q(qsdpo_int[44]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[45] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[45]),
        .Q(qsdpo_int[45]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[46] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[46]),
        .Q(qsdpo_int[46]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[47] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[47]),
        .Q(qsdpo_int[47]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[48] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[48]),
        .Q(qsdpo_int[48]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[49] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[49]),
        .Q(qsdpo_int[49]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[4]),
        .Q(qsdpo_int[4]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[50] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[50]),
        .Q(qsdpo_int[50]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[51] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[51]),
        .Q(qsdpo_int[51]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[52] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[52]),
        .Q(qsdpo_int[52]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[53] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[53]),
        .Q(qsdpo_int[53]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[54] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[54]),
        .Q(qsdpo_int[54]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[55] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[55]),
        .Q(qsdpo_int[55]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[56] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[56]),
        .Q(qsdpo_int[56]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[57] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[57]),
        .Q(qsdpo_int[57]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[58] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[58]),
        .Q(qsdpo_int[58]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[59] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[59]),
        .Q(qsdpo_int[59]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[5]),
        .Q(qsdpo_int[5]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[60] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[60]),
        .Q(qsdpo_int[60]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[61] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[61]),
        .Q(qsdpo_int[61]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[62] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[62]),
        .Q(qsdpo_int[62]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[63] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[63]),
        .Q(qsdpo_int[63]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[64] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[64]),
        .Q(qsdpo_int[64]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[65] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[65]),
        .Q(qsdpo_int[65]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[66] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[66]),
        .Q(qsdpo_int[66]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[67] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[67]),
        .Q(qsdpo_int[67]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[68] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[68]),
        .Q(qsdpo_int[68]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[69] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[69]),
        .Q(qsdpo_int[69]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[6]),
        .Q(qsdpo_int[6]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[70] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[70]),
        .Q(qsdpo_int[70]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[71] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[71]),
        .Q(qsdpo_int[71]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[72] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[72]),
        .Q(qsdpo_int[72]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[73] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[73]),
        .Q(qsdpo_int[73]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[74] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[74]),
        .Q(qsdpo_int[74]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[75] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[75]),
        .Q(qsdpo_int[75]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[76] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[76]),
        .Q(qsdpo_int[76]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[77] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[77]),
        .Q(qsdpo_int[77]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[78] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[78]),
        .Q(qsdpo_int[78]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[79] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[79]),
        .Q(qsdpo_int[79]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[7]),
        .Q(qsdpo_int[7]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[80] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[80]),
        .Q(qsdpo_int[80]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[81] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[81]),
        .Q(qsdpo_int[81]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[82] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[82]),
        .Q(qsdpo_int[82]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[83] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[83]),
        .Q(qsdpo_int[83]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[84] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[84]),
        .Q(qsdpo_int[84]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[85] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[85]),
        .Q(qsdpo_int[85]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[86] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[86]),
        .Q(qsdpo_int[86]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[87] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[87]),
        .Q(qsdpo_int[87]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[88] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[88]),
        .Q(qsdpo_int[88]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[89] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[89]),
        .Q(qsdpo_int[89]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[8]),
        .Q(qsdpo_int[8]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[90] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[90]),
        .Q(qsdpo_int[90]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[91] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[91]),
        .Q(qsdpo_int[91]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[92] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[92]),
        .Q(qsdpo_int[92]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[93] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[93]),
        .Q(qsdpo_int[93]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[94] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[94]),
        .Q(qsdpo_int[94]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[95] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[95]),
        .Q(qsdpo_int[95]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[96] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[96]),
        .Q(qsdpo_int[96]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[97] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[97]),
        .Q(qsdpo_int[97]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[98] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[98]),
        .Q(qsdpo_int[98]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[99] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[99]),
        .Q(qsdpo_int[99]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[9]),
        .Q(qsdpo_int[9]),
        .R(1'b0));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M16 #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000),
    .INIT_E(64'h0000000000000000),
    .INIT_F(64'h0000000000000000),
    .INIT_G(64'h0000000000000000),
    .INIT_H(64'h0000000000000000)) 
    ram_reg_0_15_0_5
       (.ADDRA({1'b0,sdpra_reg}),
        .ADDRB({1'b0,sdpra_reg}),
        .ADDRC({1'b0,sdpra_reg}),
        .ADDRD({1'b0,sdpra_reg}),
        .ADDRE({1'b0,sdpra_reg}),
        .ADDRF({1'b0,sdpra_reg}),
        .ADDRG({1'b0,sdpra_reg}),
        .ADDRH({1'b0,a_reg}),
        .DIA(d_reg[1:0]),
        .DIB(d_reg[3:2]),
        .DIC(d_reg[5:4]),
        .DID(d_reg[7:6]),
        .DIE(d_reg[9:8]),
        .DIF(d_reg[11:10]),
        .DIG(d_reg[13:12]),
        .DIH({1'b0,1'b0}),
        .DOA(sdpo_int[1:0]),
        .DOB(sdpo_int[3:2]),
        .DOC(sdpo_int[5:4]),
        .DOD(sdpo_int[7:6]),
        .DOE(sdpo_int[9:8]),
        .DOF(sdpo_int[11:10]),
        .DOG(sdpo_int[13:12]),
        .DOH(NLW_ram_reg_0_15_0_5_DOH_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(we_reg));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M16 #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000),
    .INIT_E(64'h0000000000000000),
    .INIT_F(64'h0000000000000000),
    .INIT_G(64'h0000000000000000),
    .INIT_H(64'h0000000000000000)) 
    ram_reg_0_15_12_17
       (.ADDRA({1'b0,sdpra_reg}),
        .ADDRB({1'b0,sdpra_reg}),
        .ADDRC({1'b0,sdpra_reg}),
        .ADDRD({1'b0,sdpra_reg}),
        .ADDRE({1'b0,sdpra_reg}),
        .ADDRF({1'b0,sdpra_reg}),
        .ADDRG({1'b0,sdpra_reg}),
        .ADDRH({1'b0,a_reg}),
        .DIA(d_reg[29:28]),
        .DIB(d_reg[31:30]),
        .DIC(d_reg[33:32]),
        .DID(d_reg[35:34]),
        .DIE(d_reg[37:36]),
        .DIF(d_reg[39:38]),
        .DIG(d_reg[41:40]),
        .DIH({1'b0,1'b0}),
        .DOA(sdpo_int[29:28]),
        .DOB(sdpo_int[31:30]),
        .DOC(sdpo_int[33:32]),
        .DOD(sdpo_int[35:34]),
        .DOE(sdpo_int[37:36]),
        .DOF(sdpo_int[39:38]),
        .DOG(sdpo_int[41:40]),
        .DOH(NLW_ram_reg_0_15_12_17_DOH_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(we_reg));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M16 #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000),
    .INIT_E(64'h0000000000000000),
    .INIT_F(64'h0000000000000000),
    .INIT_G(64'h0000000000000000),
    .INIT_H(64'h0000000000000000)) 
    ram_reg_0_15_18_23
       (.ADDRA({1'b0,sdpra_reg}),
        .ADDRB({1'b0,sdpra_reg}),
        .ADDRC({1'b0,sdpra_reg}),
        .ADDRD({1'b0,sdpra_reg}),
        .ADDRE({1'b0,sdpra_reg}),
        .ADDRF({1'b0,sdpra_reg}),
        .ADDRG({1'b0,sdpra_reg}),
        .ADDRH({1'b0,a_reg}),
        .DIA(d_reg[43:42]),
        .DIB(d_reg[45:44]),
        .DIC(d_reg[47:46]),
        .DID(d_reg[49:48]),
        .DIE(d_reg[51:50]),
        .DIF(d_reg[53:52]),
        .DIG(d_reg[55:54]),
        .DIH({1'b0,1'b0}),
        .DOA(sdpo_int[43:42]),
        .DOB(sdpo_int[45:44]),
        .DOC(sdpo_int[47:46]),
        .DOD(sdpo_int[49:48]),
        .DOE(sdpo_int[51:50]),
        .DOF(sdpo_int[53:52]),
        .DOG(sdpo_int[55:54]),
        .DOH(NLW_ram_reg_0_15_18_23_DOH_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(we_reg));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M16 #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000),
    .INIT_E(64'h0000000000000000),
    .INIT_F(64'h0000000000000000),
    .INIT_G(64'h0000000000000000),
    .INIT_H(64'h0000000000000000)) 
    ram_reg_0_15_24_29
       (.ADDRA({1'b0,sdpra_reg}),
        .ADDRB({1'b0,sdpra_reg}),
        .ADDRC({1'b0,sdpra_reg}),
        .ADDRD({1'b0,sdpra_reg}),
        .ADDRE({1'b0,sdpra_reg}),
        .ADDRF({1'b0,sdpra_reg}),
        .ADDRG({1'b0,sdpra_reg}),
        .ADDRH({1'b0,a_reg}),
        .DIA(d_reg[57:56]),
        .DIB(d_reg[59:58]),
        .DIC(d_reg[61:60]),
        .DID(d_reg[63:62]),
        .DIE(d_reg[65:64]),
        .DIF(d_reg[67:66]),
        .DIG(d_reg[69:68]),
        .DIH({1'b0,1'b0}),
        .DOA(sdpo_int[57:56]),
        .DOB(sdpo_int[59:58]),
        .DOC(sdpo_int[61:60]),
        .DOD(sdpo_int[63:62]),
        .DOE(sdpo_int[65:64]),
        .DOF(sdpo_int[67:66]),
        .DOG(sdpo_int[69:68]),
        .DOH(NLW_ram_reg_0_15_24_29_DOH_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(we_reg));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M16 #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000),
    .INIT_E(64'h0000000000000000),
    .INIT_F(64'h0000000000000000),
    .INIT_G(64'h0000000000000000),
    .INIT_H(64'h0000000000000000)) 
    ram_reg_0_15_30_35
       (.ADDRA({1'b0,sdpra_reg}),
        .ADDRB({1'b0,sdpra_reg}),
        .ADDRC({1'b0,sdpra_reg}),
        .ADDRD({1'b0,sdpra_reg}),
        .ADDRE({1'b0,sdpra_reg}),
        .ADDRF({1'b0,sdpra_reg}),
        .ADDRG({1'b0,sdpra_reg}),
        .ADDRH({1'b0,a_reg}),
        .DIA(d_reg[71:70]),
        .DIB(d_reg[73:72]),
        .DIC(d_reg[75:74]),
        .DID(d_reg[77:76]),
        .DIE(d_reg[79:78]),
        .DIF(d_reg[81:80]),
        .DIG(d_reg[83:82]),
        .DIH({1'b0,1'b0}),
        .DOA(sdpo_int[71:70]),
        .DOB(sdpo_int[73:72]),
        .DOC(sdpo_int[75:74]),
        .DOD(sdpo_int[77:76]),
        .DOE(sdpo_int[79:78]),
        .DOF(sdpo_int[81:80]),
        .DOG(sdpo_int[83:82]),
        .DOH(NLW_ram_reg_0_15_30_35_DOH_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(we_reg));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M16 #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000),
    .INIT_E(64'h0000000000000000),
    .INIT_F(64'h0000000000000000),
    .INIT_G(64'h0000000000000000),
    .INIT_H(64'h0000000000000000)) 
    ram_reg_0_15_36_41
       (.ADDRA({1'b0,sdpra_reg}),
        .ADDRB({1'b0,sdpra_reg}),
        .ADDRC({1'b0,sdpra_reg}),
        .ADDRD({1'b0,sdpra_reg}),
        .ADDRE({1'b0,sdpra_reg}),
        .ADDRF({1'b0,sdpra_reg}),
        .ADDRG({1'b0,sdpra_reg}),
        .ADDRH({1'b0,a_reg}),
        .DIA(d_reg[85:84]),
        .DIB(d_reg[87:86]),
        .DIC(d_reg[89:88]),
        .DID(d_reg[91:90]),
        .DIE(d_reg[93:92]),
        .DIF(d_reg[95:94]),
        .DIG(d_reg[97:96]),
        .DIH({1'b0,1'b0}),
        .DOA(sdpo_int[85:84]),
        .DOB(sdpo_int[87:86]),
        .DOC(sdpo_int[89:88]),
        .DOD(sdpo_int[91:90]),
        .DOE(sdpo_int[93:92]),
        .DOF(sdpo_int[95:94]),
        .DOG(sdpo_int[97:96]),
        .DOH(NLW_ram_reg_0_15_36_41_DOH_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(we_reg));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M16 #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000),
    .INIT_E(64'h0000000000000000),
    .INIT_F(64'h0000000000000000),
    .INIT_G(64'h0000000000000000),
    .INIT_H(64'h0000000000000000)) 
    ram_reg_0_15_42_47
       (.ADDRA({1'b0,sdpra_reg}),
        .ADDRB({1'b0,sdpra_reg}),
        .ADDRC({1'b0,sdpra_reg}),
        .ADDRD({1'b0,sdpra_reg}),
        .ADDRE({1'b0,sdpra_reg}),
        .ADDRF({1'b0,sdpra_reg}),
        .ADDRG({1'b0,sdpra_reg}),
        .ADDRH({1'b0,a_reg}),
        .DIA(d_reg[99:98]),
        .DIB(d_reg[101:100]),
        .DIC(d_reg[103:102]),
        .DID(d_reg[105:104]),
        .DIE(d_reg[107:106]),
        .DIF(d_reg[109:108]),
        .DIG(d_reg[111:110]),
        .DIH({1'b0,1'b0}),
        .DOA(sdpo_int[99:98]),
        .DOB(sdpo_int[101:100]),
        .DOC(sdpo_int[103:102]),
        .DOD(sdpo_int[105:104]),
        .DOE(sdpo_int[107:106]),
        .DOF(sdpo_int[109:108]),
        .DOG(sdpo_int[111:110]),
        .DOH(NLW_ram_reg_0_15_42_47_DOH_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(we_reg));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M16 #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000),
    .INIT_E(64'h0000000000000000),
    .INIT_F(64'h0000000000000000),
    .INIT_G(64'h0000000000000000),
    .INIT_H(64'h0000000000000000)) 
    ram_reg_0_15_48_53
       (.ADDRA({1'b0,sdpra_reg}),
        .ADDRB({1'b0,sdpra_reg}),
        .ADDRC({1'b0,sdpra_reg}),
        .ADDRD({1'b0,sdpra_reg}),
        .ADDRE({1'b0,sdpra_reg}),
        .ADDRF({1'b0,sdpra_reg}),
        .ADDRG({1'b0,sdpra_reg}),
        .ADDRH({1'b0,a_reg}),
        .DIA(d_reg[113:112]),
        .DIB(d_reg[115:114]),
        .DIC(d_reg[117:116]),
        .DID(d_reg[119:118]),
        .DIE(d_reg[121:120]),
        .DIF(d_reg[123:122]),
        .DIG(d_reg[125:124]),
        .DIH({1'b0,1'b0}),
        .DOA(sdpo_int[113:112]),
        .DOB(sdpo_int[115:114]),
        .DOC(sdpo_int[117:116]),
        .DOD(sdpo_int[119:118]),
        .DOE(sdpo_int[121:120]),
        .DOF(sdpo_int[123:122]),
        .DOG(sdpo_int[125:124]),
        .DOH(NLW_ram_reg_0_15_48_53_DOH_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(we_reg));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M16 #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000),
    .INIT_E(64'h0000000000000000),
    .INIT_F(64'h0000000000000000),
    .INIT_G(64'h0000000000000000),
    .INIT_H(64'h0000000000000000)) 
    ram_reg_0_15_54_59
       (.ADDRA({1'b0,sdpra_reg}),
        .ADDRB({1'b0,sdpra_reg}),
        .ADDRC({1'b0,sdpra_reg}),
        .ADDRD({1'b0,sdpra_reg}),
        .ADDRE({1'b0,sdpra_reg}),
        .ADDRF({1'b0,sdpra_reg}),
        .ADDRG({1'b0,sdpra_reg}),
        .ADDRH({1'b0,a_reg}),
        .DIA(d_reg[127:126]),
        .DIB(d_reg[129:128]),
        .DIC(d_reg[131:130]),
        .DID(d_reg[133:132]),
        .DIE(d_reg[135:134]),
        .DIF(d_reg[137:136]),
        .DIG(d_reg[139:138]),
        .DIH({1'b0,1'b0}),
        .DOA(sdpo_int[127:126]),
        .DOB(sdpo_int[129:128]),
        .DOC(sdpo_int[131:130]),
        .DOD(sdpo_int[133:132]),
        .DOE(sdpo_int[135:134]),
        .DOF(sdpo_int[137:136]),
        .DOG(sdpo_int[139:138]),
        .DOH(NLW_ram_reg_0_15_54_59_DOH_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(we_reg));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M16 #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000),
    .INIT_E(64'h0000000000000000),
    .INIT_F(64'h0000000000000000),
    .INIT_G(64'h0000000000000000),
    .INIT_H(64'h0000000000000000)) 
    ram_reg_0_15_60_65
       (.ADDRA({1'b0,sdpra_reg}),
        .ADDRB({1'b0,sdpra_reg}),
        .ADDRC({1'b0,sdpra_reg}),
        .ADDRD({1'b0,sdpra_reg}),
        .ADDRE({1'b0,sdpra_reg}),
        .ADDRF({1'b0,sdpra_reg}),
        .ADDRG({1'b0,sdpra_reg}),
        .ADDRH({1'b0,a_reg}),
        .DIA(d_reg[141:140]),
        .DIB(d_reg[143:142]),
        .DIC(d_reg[145:144]),
        .DID(d_reg[147:146]),
        .DIE(d_reg[149:148]),
        .DIF(d_reg[151:150]),
        .DIG(d_reg[153:152]),
        .DIH({1'b0,1'b0}),
        .DOA(sdpo_int[141:140]),
        .DOB(sdpo_int[143:142]),
        .DOC(sdpo_int[145:144]),
        .DOD(sdpo_int[147:146]),
        .DOE(sdpo_int[149:148]),
        .DOF(sdpo_int[151:150]),
        .DOG(sdpo_int[153:152]),
        .DOH(NLW_ram_reg_0_15_60_65_DOH_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(we_reg));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M16 #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000),
    .INIT_E(64'h0000000000000000),
    .INIT_F(64'h0000000000000000),
    .INIT_G(64'h0000000000000000),
    .INIT_H(64'h0000000000000000)) 
    ram_reg_0_15_66_71
       (.ADDRA({1'b0,sdpra_reg}),
        .ADDRB({1'b0,sdpra_reg}),
        .ADDRC({1'b0,sdpra_reg}),
        .ADDRD({1'b0,sdpra_reg}),
        .ADDRE({1'b0,sdpra_reg}),
        .ADDRF({1'b0,sdpra_reg}),
        .ADDRG({1'b0,sdpra_reg}),
        .ADDRH({1'b0,a_reg}),
        .DIA(d_reg[155:154]),
        .DIB(d_reg[157:156]),
        .DIC(d_reg[159:158]),
        .DID(d_reg[161:160]),
        .DIE(d_reg[163:162]),
        .DIF(d_reg[165:164]),
        .DIG(d_reg[167:166]),
        .DIH({1'b0,1'b0}),
        .DOA(sdpo_int[155:154]),
        .DOB(sdpo_int[157:156]),
        .DOC(sdpo_int[159:158]),
        .DOD(sdpo_int[161:160]),
        .DOE(sdpo_int[163:162]),
        .DOF(sdpo_int[165:164]),
        .DOG(sdpo_int[167:166]),
        .DOH(NLW_ram_reg_0_15_66_71_DOH_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(we_reg));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M16 #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000),
    .INIT_E(64'h0000000000000000),
    .INIT_F(64'h0000000000000000),
    .INIT_G(64'h0000000000000000),
    .INIT_H(64'h0000000000000000)) 
    ram_reg_0_15_6_11
       (.ADDRA({1'b0,sdpra_reg}),
        .ADDRB({1'b0,sdpra_reg}),
        .ADDRC({1'b0,sdpra_reg}),
        .ADDRD({1'b0,sdpra_reg}),
        .ADDRE({1'b0,sdpra_reg}),
        .ADDRF({1'b0,sdpra_reg}),
        .ADDRG({1'b0,sdpra_reg}),
        .ADDRH({1'b0,a_reg}),
        .DIA(d_reg[15:14]),
        .DIB(d_reg[17:16]),
        .DIC(d_reg[19:18]),
        .DID(d_reg[21:20]),
        .DIE(d_reg[23:22]),
        .DIF(d_reg[25:24]),
        .DIG(d_reg[27:26]),
        .DIH({1'b0,1'b0}),
        .DOA(sdpo_int[15:14]),
        .DOB(sdpo_int[17:16]),
        .DOC(sdpo_int[19:18]),
        .DOD(sdpo_int[21:20]),
        .DOE(sdpo_int[23:22]),
        .DOF(sdpo_int[25:24]),
        .DOG(sdpo_int[27:26]),
        .DOH(NLW_ram_reg_0_15_6_11_DOH_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(we_reg));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M16 #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000),
    .INIT_E(64'h0000000000000000),
    .INIT_F(64'h0000000000000000),
    .INIT_G(64'h0000000000000000),
    .INIT_H(64'h0000000000000000)) 
    ram_reg_0_15_72_77
       (.ADDRA({1'b0,sdpra_reg}),
        .ADDRB({1'b0,sdpra_reg}),
        .ADDRC({1'b0,sdpra_reg}),
        .ADDRD({1'b0,sdpra_reg}),
        .ADDRE({1'b0,sdpra_reg}),
        .ADDRF({1'b0,sdpra_reg}),
        .ADDRG({1'b0,sdpra_reg}),
        .ADDRH({1'b0,a_reg}),
        .DIA(d_reg[169:168]),
        .DIB(d_reg[171:170]),
        .DIC(d_reg[173:172]),
        .DID(d_reg[175:174]),
        .DIE(d_reg[177:176]),
        .DIF({1'b0,1'b0}),
        .DIG({1'b0,1'b0}),
        .DIH({1'b0,1'b0}),
        .DOA(sdpo_int[169:168]),
        .DOB(sdpo_int[171:170]),
        .DOC(sdpo_int[173:172]),
        .DOD(sdpo_int[175:174]),
        .DOE(sdpo_int[177:176]),
        .DOF(NLW_ram_reg_0_15_72_77_DOF_UNCONNECTED[1:0]),
        .DOG(NLW_ram_reg_0_15_72_77_DOG_UNCONNECTED[1:0]),
        .DOH(NLW_ram_reg_0_15_72_77_DOH_UNCONNECTED[1:0]),
        .WCLK(clk),
        .WE(we_reg));
  FDRE #(
    .INIT(1'b0)) 
    \sdpra_reg_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(dpra[0]),
        .Q(sdpra_reg[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdpra_reg_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(dpra[1]),
        .Q(sdpra_reg[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdpra_reg_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(dpra[2]),
        .Q(sdpra_reg[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdpra_reg_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .D(dpra[3]),
        .Q(sdpra_reg[3]),
        .R(1'b0));
  FDRE we_reg_reg
       (.C(clk),
        .CE(1'b1),
        .D(we),
        .Q(we_reg),
        .R(1'b0));
endmodule
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
