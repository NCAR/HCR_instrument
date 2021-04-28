// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
// Date        : Mon Apr 26 22:24:52 2021
// Host        : wind running 64-bit unknown
// Command     : write_verilog -force -mode funcsim
//               /home/karboski/git/HCR_instrument/src/Pentek821/FDK/2017.2/p71821_060/p71821.srcs/sources_1/bd/user_block2/ip/user_block2_axis_register_slice_0_0/user_block2_axis_register_slice_0_0_sim_netlist.v
// Design      : user_block2_axis_register_slice_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "user_block2_axis_register_slice_0_0,axis_register_slice_v1_1_13_axis_register_slice,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* X_CORE_INFO = "axis_register_slice_v1_1_13_axis_register_slice,Vivado 2017.2" *) 
(* NotValidForBitStream *)
module user_block2_axis_register_slice_0_0
   (aclk,
    aresetn,
    s_axis_tvalid,
    s_axis_tdata,
    s_axis_tuser,
    m_axis_tvalid,
    m_axis_tdata,
    m_axis_tuser);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLKIF CLK" *) input aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RSTIF RST" *) input aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TVALID" *) input s_axis_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TDATA" *) input [31:0]s_axis_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TUSER" *) input [127:0]s_axis_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TVALID" *) output m_axis_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TDATA" *) output [31:0]m_axis_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TUSER" *) output [127:0]m_axis_tuser;

  wire aclk;
  wire aresetn;
  wire [31:0]m_axis_tdata;
  wire [127:0]m_axis_tuser;
  wire m_axis_tvalid;
  wire [31:0]s_axis_tdata;
  wire [127:0]s_axis_tuser;
  wire s_axis_tvalid;
  wire NLW_inst_m_axis_tlast_UNCONNECTED;
  wire NLW_inst_s_axis_tready_UNCONNECTED;
  wire [0:0]NLW_inst_m_axis_tdest_UNCONNECTED;
  wire [0:0]NLW_inst_m_axis_tid_UNCONNECTED;
  wire [3:0]NLW_inst_m_axis_tkeep_UNCONNECTED;
  wire [3:0]NLW_inst_m_axis_tstrb_UNCONNECTED;

  (* C_AXIS_SIGNAL_SET = "32'b00000000000000000000000010000010" *) 
  (* C_AXIS_TDATA_WIDTH = "32" *) 
  (* C_AXIS_TDEST_WIDTH = "1" *) 
  (* C_AXIS_TID_WIDTH = "1" *) 
  (* C_AXIS_TUSER_WIDTH = "128" *) 
  (* C_FAMILY = "kintexu" *) 
  (* C_REG_CONFIG = "1" *) 
  (* DowngradeIPIdentifiedWarnings = "yes" *) 
  (* G_INDX_SS_TDATA = "1" *) 
  (* G_INDX_SS_TDEST = "6" *) 
  (* G_INDX_SS_TID = "5" *) 
  (* G_INDX_SS_TKEEP = "3" *) 
  (* G_INDX_SS_TLAST = "4" *) 
  (* G_INDX_SS_TREADY = "0" *) 
  (* G_INDX_SS_TSTRB = "2" *) 
  (* G_INDX_SS_TUSER = "7" *) 
  (* G_MASK_SS_TDATA = "2" *) 
  (* G_MASK_SS_TDEST = "64" *) 
  (* G_MASK_SS_TID = "32" *) 
  (* G_MASK_SS_TKEEP = "8" *) 
  (* G_MASK_SS_TLAST = "16" *) 
  (* G_MASK_SS_TREADY = "1" *) 
  (* G_MASK_SS_TSTRB = "4" *) 
  (* G_MASK_SS_TUSER = "128" *) 
  (* G_TASK_SEVERITY_ERR = "2" *) 
  (* G_TASK_SEVERITY_INFO = "0" *) 
  (* G_TASK_SEVERITY_WARNING = "1" *) 
  (* P_TPAYLOAD_WIDTH = "160" *) 
  user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice inst
       (.aclk(aclk),
        .aclken(1'b1),
        .aresetn(aresetn),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tdest(NLW_inst_m_axis_tdest_UNCONNECTED[0]),
        .m_axis_tid(NLW_inst_m_axis_tid_UNCONNECTED[0]),
        .m_axis_tkeep(NLW_inst_m_axis_tkeep_UNCONNECTED[3:0]),
        .m_axis_tlast(NLW_inst_m_axis_tlast_UNCONNECTED),
        .m_axis_tready(1'b1),
        .m_axis_tstrb(NLW_inst_m_axis_tstrb_UNCONNECTED[3:0]),
        .m_axis_tuser(m_axis_tuser),
        .m_axis_tvalid(m_axis_tvalid),
        .s_axis_tdata(s_axis_tdata),
        .s_axis_tdest(1'b0),
        .s_axis_tid(1'b0),
        .s_axis_tkeep({1'b1,1'b1,1'b1,1'b1}),
        .s_axis_tlast(1'b1),
        .s_axis_tready(NLW_inst_s_axis_tready_UNCONNECTED),
        .s_axis_tstrb({1'b1,1'b1,1'b1,1'b1}),
        .s_axis_tuser(s_axis_tuser),
        .s_axis_tvalid(s_axis_tvalid));
endmodule

(* C_AXIS_SIGNAL_SET = "32'b00000000000000000000000010000010" *) (* C_AXIS_TDATA_WIDTH = "32" *) (* C_AXIS_TDEST_WIDTH = "1" *) 
(* C_AXIS_TID_WIDTH = "1" *) (* C_AXIS_TUSER_WIDTH = "128" *) (* C_FAMILY = "kintexu" *) 
(* C_REG_CONFIG = "1" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* G_INDX_SS_TDATA = "1" *) 
(* G_INDX_SS_TDEST = "6" *) (* G_INDX_SS_TID = "5" *) (* G_INDX_SS_TKEEP = "3" *) 
(* G_INDX_SS_TLAST = "4" *) (* G_INDX_SS_TREADY = "0" *) (* G_INDX_SS_TSTRB = "2" *) 
(* G_INDX_SS_TUSER = "7" *) (* G_MASK_SS_TDATA = "2" *) (* G_MASK_SS_TDEST = "64" *) 
(* G_MASK_SS_TID = "32" *) (* G_MASK_SS_TKEEP = "8" *) (* G_MASK_SS_TLAST = "16" *) 
(* G_MASK_SS_TREADY = "1" *) (* G_MASK_SS_TSTRB = "4" *) (* G_MASK_SS_TUSER = "128" *) 
(* G_TASK_SEVERITY_ERR = "2" *) (* G_TASK_SEVERITY_INFO = "0" *) (* G_TASK_SEVERITY_WARNING = "1" *) 
(* ORIG_REF_NAME = "axis_register_slice_v1_1_13_axis_register_slice" *) (* P_TPAYLOAD_WIDTH = "160" *) 
module user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axis_register_slice
   (aclk,
    aresetn,
    aclken,
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tdata,
    s_axis_tstrb,
    s_axis_tkeep,
    s_axis_tlast,
    s_axis_tid,
    s_axis_tdest,
    s_axis_tuser,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tdata,
    m_axis_tstrb,
    m_axis_tkeep,
    m_axis_tlast,
    m_axis_tid,
    m_axis_tdest,
    m_axis_tuser);
  input aclk;
  input aresetn;
  input aclken;
  input s_axis_tvalid;
  output s_axis_tready;
  input [31:0]s_axis_tdata;
  input [3:0]s_axis_tstrb;
  input [3:0]s_axis_tkeep;
  input s_axis_tlast;
  input [0:0]s_axis_tid;
  input [0:0]s_axis_tdest;
  input [127:0]s_axis_tuser;
  output m_axis_tvalid;
  input m_axis_tready;
  output [31:0]m_axis_tdata;
  output [3:0]m_axis_tstrb;
  output [3:0]m_axis_tkeep;
  output m_axis_tlast;
  output [0:0]m_axis_tid;
  output [0:0]m_axis_tdest;
  output [127:0]m_axis_tuser;

  wire \<const0> ;
  wire \<const1> ;
  wire aclk;
  wire aclken;
  wire [31:0]m_axis_tdata;
  wire [127:0]m_axis_tuser;
  wire m_axis_tvalid;
  wire [31:0]s_axis_tdata;
  wire [127:0]s_axis_tuser;
  wire s_axis_tvalid;

  assign m_axis_tdest[0] = \<const0> ;
  assign m_axis_tid[0] = \<const0> ;
  assign m_axis_tkeep[3] = \<const1> ;
  assign m_axis_tkeep[2] = \<const1> ;
  assign m_axis_tkeep[1] = \<const1> ;
  assign m_axis_tkeep[0] = \<const1> ;
  assign m_axis_tlast = \<const0> ;
  assign m_axis_tstrb[3] = \<const0> ;
  assign m_axis_tstrb[2] = \<const0> ;
  assign m_axis_tstrb[1] = \<const0> ;
  assign m_axis_tstrb[0] = \<const0> ;
  assign s_axis_tready = \<const1> ;
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axisc_register_slice axisc_register_slice_0
       (.D({s_axis_tuser,s_axis_tdata}),
        .Q({m_axis_tuser,m_axis_tdata}),
        .aclk(aclk),
        .aclken(aclken),
        .m_axis_tvalid(m_axis_tvalid),
        .s_axis_tvalid(s_axis_tvalid));
endmodule

(* ORIG_REF_NAME = "axis_register_slice_v1_1_13_axisc_register_slice" *) 
module user_block2_axis_register_slice_0_0_axis_register_slice_v1_1_13_axisc_register_slice
   (Q,
    m_axis_tvalid,
    aclken,
    D,
    aclk,
    s_axis_tvalid);
  output [159:0]Q;
  output m_axis_tvalid;
  input aclken;
  input [159:0]D;
  input aclk;
  input s_axis_tvalid;

  wire [159:0]D;
  wire [159:0]Q;
  wire aclk;
  wire aclken;
  wire m_axis_tvalid;
  wire s_axis_tvalid;

  FDRE \NO_READY.m_valid_r_reg 
       (.C(aclk),
        .CE(aclken),
        .D(s_axis_tvalid),
        .Q(m_axis_tvalid),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[0] 
       (.C(aclk),
        .CE(aclken),
        .D(D[0]),
        .Q(Q[0]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[100] 
       (.C(aclk),
        .CE(aclken),
        .D(D[100]),
        .Q(Q[100]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[101] 
       (.C(aclk),
        .CE(aclken),
        .D(D[101]),
        .Q(Q[101]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[102] 
       (.C(aclk),
        .CE(aclken),
        .D(D[102]),
        .Q(Q[102]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[103] 
       (.C(aclk),
        .CE(aclken),
        .D(D[103]),
        .Q(Q[103]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[104] 
       (.C(aclk),
        .CE(aclken),
        .D(D[104]),
        .Q(Q[104]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[105] 
       (.C(aclk),
        .CE(aclken),
        .D(D[105]),
        .Q(Q[105]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[106] 
       (.C(aclk),
        .CE(aclken),
        .D(D[106]),
        .Q(Q[106]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[107] 
       (.C(aclk),
        .CE(aclken),
        .D(D[107]),
        .Q(Q[107]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[108] 
       (.C(aclk),
        .CE(aclken),
        .D(D[108]),
        .Q(Q[108]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[109] 
       (.C(aclk),
        .CE(aclken),
        .D(D[109]),
        .Q(Q[109]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[10] 
       (.C(aclk),
        .CE(aclken),
        .D(D[10]),
        .Q(Q[10]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[110] 
       (.C(aclk),
        .CE(aclken),
        .D(D[110]),
        .Q(Q[110]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[111] 
       (.C(aclk),
        .CE(aclken),
        .D(D[111]),
        .Q(Q[111]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[112] 
       (.C(aclk),
        .CE(aclken),
        .D(D[112]),
        .Q(Q[112]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[113] 
       (.C(aclk),
        .CE(aclken),
        .D(D[113]),
        .Q(Q[113]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[114] 
       (.C(aclk),
        .CE(aclken),
        .D(D[114]),
        .Q(Q[114]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[115] 
       (.C(aclk),
        .CE(aclken),
        .D(D[115]),
        .Q(Q[115]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[116] 
       (.C(aclk),
        .CE(aclken),
        .D(D[116]),
        .Q(Q[116]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[117] 
       (.C(aclk),
        .CE(aclken),
        .D(D[117]),
        .Q(Q[117]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[118] 
       (.C(aclk),
        .CE(aclken),
        .D(D[118]),
        .Q(Q[118]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[119] 
       (.C(aclk),
        .CE(aclken),
        .D(D[119]),
        .Q(Q[119]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[11] 
       (.C(aclk),
        .CE(aclken),
        .D(D[11]),
        .Q(Q[11]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[120] 
       (.C(aclk),
        .CE(aclken),
        .D(D[120]),
        .Q(Q[120]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[121] 
       (.C(aclk),
        .CE(aclken),
        .D(D[121]),
        .Q(Q[121]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[122] 
       (.C(aclk),
        .CE(aclken),
        .D(D[122]),
        .Q(Q[122]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[123] 
       (.C(aclk),
        .CE(aclken),
        .D(D[123]),
        .Q(Q[123]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[124] 
       (.C(aclk),
        .CE(aclken),
        .D(D[124]),
        .Q(Q[124]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[125] 
       (.C(aclk),
        .CE(aclken),
        .D(D[125]),
        .Q(Q[125]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[126] 
       (.C(aclk),
        .CE(aclken),
        .D(D[126]),
        .Q(Q[126]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[127] 
       (.C(aclk),
        .CE(aclken),
        .D(D[127]),
        .Q(Q[127]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[128] 
       (.C(aclk),
        .CE(aclken),
        .D(D[128]),
        .Q(Q[128]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[129] 
       (.C(aclk),
        .CE(aclken),
        .D(D[129]),
        .Q(Q[129]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[12] 
       (.C(aclk),
        .CE(aclken),
        .D(D[12]),
        .Q(Q[12]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[130] 
       (.C(aclk),
        .CE(aclken),
        .D(D[130]),
        .Q(Q[130]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[131] 
       (.C(aclk),
        .CE(aclken),
        .D(D[131]),
        .Q(Q[131]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[132] 
       (.C(aclk),
        .CE(aclken),
        .D(D[132]),
        .Q(Q[132]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[133] 
       (.C(aclk),
        .CE(aclken),
        .D(D[133]),
        .Q(Q[133]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[134] 
       (.C(aclk),
        .CE(aclken),
        .D(D[134]),
        .Q(Q[134]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[135] 
       (.C(aclk),
        .CE(aclken),
        .D(D[135]),
        .Q(Q[135]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[136] 
       (.C(aclk),
        .CE(aclken),
        .D(D[136]),
        .Q(Q[136]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[137] 
       (.C(aclk),
        .CE(aclken),
        .D(D[137]),
        .Q(Q[137]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[138] 
       (.C(aclk),
        .CE(aclken),
        .D(D[138]),
        .Q(Q[138]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[139] 
       (.C(aclk),
        .CE(aclken),
        .D(D[139]),
        .Q(Q[139]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[13] 
       (.C(aclk),
        .CE(aclken),
        .D(D[13]),
        .Q(Q[13]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[140] 
       (.C(aclk),
        .CE(aclken),
        .D(D[140]),
        .Q(Q[140]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[141] 
       (.C(aclk),
        .CE(aclken),
        .D(D[141]),
        .Q(Q[141]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[142] 
       (.C(aclk),
        .CE(aclken),
        .D(D[142]),
        .Q(Q[142]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[143] 
       (.C(aclk),
        .CE(aclken),
        .D(D[143]),
        .Q(Q[143]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[144] 
       (.C(aclk),
        .CE(aclken),
        .D(D[144]),
        .Q(Q[144]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[145] 
       (.C(aclk),
        .CE(aclken),
        .D(D[145]),
        .Q(Q[145]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[146] 
       (.C(aclk),
        .CE(aclken),
        .D(D[146]),
        .Q(Q[146]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[147] 
       (.C(aclk),
        .CE(aclken),
        .D(D[147]),
        .Q(Q[147]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[148] 
       (.C(aclk),
        .CE(aclken),
        .D(D[148]),
        .Q(Q[148]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[149] 
       (.C(aclk),
        .CE(aclken),
        .D(D[149]),
        .Q(Q[149]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[14] 
       (.C(aclk),
        .CE(aclken),
        .D(D[14]),
        .Q(Q[14]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[150] 
       (.C(aclk),
        .CE(aclken),
        .D(D[150]),
        .Q(Q[150]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[151] 
       (.C(aclk),
        .CE(aclken),
        .D(D[151]),
        .Q(Q[151]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[152] 
       (.C(aclk),
        .CE(aclken),
        .D(D[152]),
        .Q(Q[152]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[153] 
       (.C(aclk),
        .CE(aclken),
        .D(D[153]),
        .Q(Q[153]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[154] 
       (.C(aclk),
        .CE(aclken),
        .D(D[154]),
        .Q(Q[154]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[155] 
       (.C(aclk),
        .CE(aclken),
        .D(D[155]),
        .Q(Q[155]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[156] 
       (.C(aclk),
        .CE(aclken),
        .D(D[156]),
        .Q(Q[156]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[157] 
       (.C(aclk),
        .CE(aclken),
        .D(D[157]),
        .Q(Q[157]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[158] 
       (.C(aclk),
        .CE(aclken),
        .D(D[158]),
        .Q(Q[158]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[159] 
       (.C(aclk),
        .CE(aclken),
        .D(D[159]),
        .Q(Q[159]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[15] 
       (.C(aclk),
        .CE(aclken),
        .D(D[15]),
        .Q(Q[15]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[16] 
       (.C(aclk),
        .CE(aclken),
        .D(D[16]),
        .Q(Q[16]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[17] 
       (.C(aclk),
        .CE(aclken),
        .D(D[17]),
        .Q(Q[17]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[18] 
       (.C(aclk),
        .CE(aclken),
        .D(D[18]),
        .Q(Q[18]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[19] 
       (.C(aclk),
        .CE(aclken),
        .D(D[19]),
        .Q(Q[19]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[1] 
       (.C(aclk),
        .CE(aclken),
        .D(D[1]),
        .Q(Q[1]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[20] 
       (.C(aclk),
        .CE(aclken),
        .D(D[20]),
        .Q(Q[20]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[21] 
       (.C(aclk),
        .CE(aclken),
        .D(D[21]),
        .Q(Q[21]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[22] 
       (.C(aclk),
        .CE(aclken),
        .D(D[22]),
        .Q(Q[22]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[23] 
       (.C(aclk),
        .CE(aclken),
        .D(D[23]),
        .Q(Q[23]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[24] 
       (.C(aclk),
        .CE(aclken),
        .D(D[24]),
        .Q(Q[24]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[25] 
       (.C(aclk),
        .CE(aclken),
        .D(D[25]),
        .Q(Q[25]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[26] 
       (.C(aclk),
        .CE(aclken),
        .D(D[26]),
        .Q(Q[26]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[27] 
       (.C(aclk),
        .CE(aclken),
        .D(D[27]),
        .Q(Q[27]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[28] 
       (.C(aclk),
        .CE(aclken),
        .D(D[28]),
        .Q(Q[28]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[29] 
       (.C(aclk),
        .CE(aclken),
        .D(D[29]),
        .Q(Q[29]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[2] 
       (.C(aclk),
        .CE(aclken),
        .D(D[2]),
        .Q(Q[2]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[30] 
       (.C(aclk),
        .CE(aclken),
        .D(D[30]),
        .Q(Q[30]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[31] 
       (.C(aclk),
        .CE(aclken),
        .D(D[31]),
        .Q(Q[31]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[32] 
       (.C(aclk),
        .CE(aclken),
        .D(D[32]),
        .Q(Q[32]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[33] 
       (.C(aclk),
        .CE(aclken),
        .D(D[33]),
        .Q(Q[33]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[34] 
       (.C(aclk),
        .CE(aclken),
        .D(D[34]),
        .Q(Q[34]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[35] 
       (.C(aclk),
        .CE(aclken),
        .D(D[35]),
        .Q(Q[35]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[36] 
       (.C(aclk),
        .CE(aclken),
        .D(D[36]),
        .Q(Q[36]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[37] 
       (.C(aclk),
        .CE(aclken),
        .D(D[37]),
        .Q(Q[37]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[38] 
       (.C(aclk),
        .CE(aclken),
        .D(D[38]),
        .Q(Q[38]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[39] 
       (.C(aclk),
        .CE(aclken),
        .D(D[39]),
        .Q(Q[39]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[3] 
       (.C(aclk),
        .CE(aclken),
        .D(D[3]),
        .Q(Q[3]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[40] 
       (.C(aclk),
        .CE(aclken),
        .D(D[40]),
        .Q(Q[40]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[41] 
       (.C(aclk),
        .CE(aclken),
        .D(D[41]),
        .Q(Q[41]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[42] 
       (.C(aclk),
        .CE(aclken),
        .D(D[42]),
        .Q(Q[42]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[43] 
       (.C(aclk),
        .CE(aclken),
        .D(D[43]),
        .Q(Q[43]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[44] 
       (.C(aclk),
        .CE(aclken),
        .D(D[44]),
        .Q(Q[44]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[45] 
       (.C(aclk),
        .CE(aclken),
        .D(D[45]),
        .Q(Q[45]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[46] 
       (.C(aclk),
        .CE(aclken),
        .D(D[46]),
        .Q(Q[46]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[47] 
       (.C(aclk),
        .CE(aclken),
        .D(D[47]),
        .Q(Q[47]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[48] 
       (.C(aclk),
        .CE(aclken),
        .D(D[48]),
        .Q(Q[48]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[49] 
       (.C(aclk),
        .CE(aclken),
        .D(D[49]),
        .Q(Q[49]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[4] 
       (.C(aclk),
        .CE(aclken),
        .D(D[4]),
        .Q(Q[4]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[50] 
       (.C(aclk),
        .CE(aclken),
        .D(D[50]),
        .Q(Q[50]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[51] 
       (.C(aclk),
        .CE(aclken),
        .D(D[51]),
        .Q(Q[51]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[52] 
       (.C(aclk),
        .CE(aclken),
        .D(D[52]),
        .Q(Q[52]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[53] 
       (.C(aclk),
        .CE(aclken),
        .D(D[53]),
        .Q(Q[53]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[54] 
       (.C(aclk),
        .CE(aclken),
        .D(D[54]),
        .Q(Q[54]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[55] 
       (.C(aclk),
        .CE(aclken),
        .D(D[55]),
        .Q(Q[55]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[56] 
       (.C(aclk),
        .CE(aclken),
        .D(D[56]),
        .Q(Q[56]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[57] 
       (.C(aclk),
        .CE(aclken),
        .D(D[57]),
        .Q(Q[57]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[58] 
       (.C(aclk),
        .CE(aclken),
        .D(D[58]),
        .Q(Q[58]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[59] 
       (.C(aclk),
        .CE(aclken),
        .D(D[59]),
        .Q(Q[59]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[5] 
       (.C(aclk),
        .CE(aclken),
        .D(D[5]),
        .Q(Q[5]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[60] 
       (.C(aclk),
        .CE(aclken),
        .D(D[60]),
        .Q(Q[60]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[61] 
       (.C(aclk),
        .CE(aclken),
        .D(D[61]),
        .Q(Q[61]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[62] 
       (.C(aclk),
        .CE(aclken),
        .D(D[62]),
        .Q(Q[62]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[63] 
       (.C(aclk),
        .CE(aclken),
        .D(D[63]),
        .Q(Q[63]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[64] 
       (.C(aclk),
        .CE(aclken),
        .D(D[64]),
        .Q(Q[64]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[65] 
       (.C(aclk),
        .CE(aclken),
        .D(D[65]),
        .Q(Q[65]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[66] 
       (.C(aclk),
        .CE(aclken),
        .D(D[66]),
        .Q(Q[66]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[67] 
       (.C(aclk),
        .CE(aclken),
        .D(D[67]),
        .Q(Q[67]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[68] 
       (.C(aclk),
        .CE(aclken),
        .D(D[68]),
        .Q(Q[68]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[69] 
       (.C(aclk),
        .CE(aclken),
        .D(D[69]),
        .Q(Q[69]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[6] 
       (.C(aclk),
        .CE(aclken),
        .D(D[6]),
        .Q(Q[6]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[70] 
       (.C(aclk),
        .CE(aclken),
        .D(D[70]),
        .Q(Q[70]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[71] 
       (.C(aclk),
        .CE(aclken),
        .D(D[71]),
        .Q(Q[71]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[72] 
       (.C(aclk),
        .CE(aclken),
        .D(D[72]),
        .Q(Q[72]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[73] 
       (.C(aclk),
        .CE(aclken),
        .D(D[73]),
        .Q(Q[73]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[74] 
       (.C(aclk),
        .CE(aclken),
        .D(D[74]),
        .Q(Q[74]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[75] 
       (.C(aclk),
        .CE(aclken),
        .D(D[75]),
        .Q(Q[75]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[76] 
       (.C(aclk),
        .CE(aclken),
        .D(D[76]),
        .Q(Q[76]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[77] 
       (.C(aclk),
        .CE(aclken),
        .D(D[77]),
        .Q(Q[77]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[78] 
       (.C(aclk),
        .CE(aclken),
        .D(D[78]),
        .Q(Q[78]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[79] 
       (.C(aclk),
        .CE(aclken),
        .D(D[79]),
        .Q(Q[79]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[7] 
       (.C(aclk),
        .CE(aclken),
        .D(D[7]),
        .Q(Q[7]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[80] 
       (.C(aclk),
        .CE(aclken),
        .D(D[80]),
        .Q(Q[80]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[81] 
       (.C(aclk),
        .CE(aclken),
        .D(D[81]),
        .Q(Q[81]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[82] 
       (.C(aclk),
        .CE(aclken),
        .D(D[82]),
        .Q(Q[82]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[83] 
       (.C(aclk),
        .CE(aclken),
        .D(D[83]),
        .Q(Q[83]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[84] 
       (.C(aclk),
        .CE(aclken),
        .D(D[84]),
        .Q(Q[84]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[85] 
       (.C(aclk),
        .CE(aclken),
        .D(D[85]),
        .Q(Q[85]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[86] 
       (.C(aclk),
        .CE(aclken),
        .D(D[86]),
        .Q(Q[86]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[87] 
       (.C(aclk),
        .CE(aclken),
        .D(D[87]),
        .Q(Q[87]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[88] 
       (.C(aclk),
        .CE(aclken),
        .D(D[88]),
        .Q(Q[88]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[89] 
       (.C(aclk),
        .CE(aclken),
        .D(D[89]),
        .Q(Q[89]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[8] 
       (.C(aclk),
        .CE(aclken),
        .D(D[8]),
        .Q(Q[8]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[90] 
       (.C(aclk),
        .CE(aclken),
        .D(D[90]),
        .Q(Q[90]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[91] 
       (.C(aclk),
        .CE(aclken),
        .D(D[91]),
        .Q(Q[91]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[92] 
       (.C(aclk),
        .CE(aclken),
        .D(D[92]),
        .Q(Q[92]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[93] 
       (.C(aclk),
        .CE(aclken),
        .D(D[93]),
        .Q(Q[93]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[94] 
       (.C(aclk),
        .CE(aclken),
        .D(D[94]),
        .Q(Q[94]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[95] 
       (.C(aclk),
        .CE(aclken),
        .D(D[95]),
        .Q(Q[95]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[96] 
       (.C(aclk),
        .CE(aclken),
        .D(D[96]),
        .Q(Q[96]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[97] 
       (.C(aclk),
        .CE(aclken),
        .D(D[97]),
        .Q(Q[97]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[98] 
       (.C(aclk),
        .CE(aclken),
        .D(D[98]),
        .Q(Q[98]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[99] 
       (.C(aclk),
        .CE(aclken),
        .D(D[99]),
        .Q(Q[99]),
        .R(1'b0));
  FDRE \NO_READY.storage_data1_reg[9] 
       (.C(aclk),
        .CE(aclken),
        .D(D[9]),
        .Q(Q[9]),
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
