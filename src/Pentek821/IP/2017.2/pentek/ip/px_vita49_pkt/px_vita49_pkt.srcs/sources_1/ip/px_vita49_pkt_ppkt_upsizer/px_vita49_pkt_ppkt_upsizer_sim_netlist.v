// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2.1 (win64) Build 1957588 Wed Aug  9 16:32:24 MDT 2017
// Date        : Thu Oct 26 16:19:12 2017
// Host        : Mike-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/pentek/ip/2017.2/wip/px_vita49_pkt/px_vita49_pkt.srcs/sources_1/ip/px_vita49_pkt_ppkt_upsizer/px_vita49_pkt_ppkt_upsizer_sim_netlist.v
// Design      : px_vita49_pkt_ppkt_upsizer
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku035-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "px_vita49_pkt_ppkt_upsizer,px_ppkt_width_upsizer,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "px_ppkt_width_upsizer,Vivado 2017.2.1" *) 
(* NotValidForBitStream *)
module px_vita49_pkt_ppkt_upsizer
   (aclk,
    aresetn,
    s_axis_ppkt_tvalid,
    s_axis_ppkt_tready,
    s_axis_ppkt_tdata,
    s_axis_ppkt_tuser,
    s_axis_ppkt_tkeep,
    s_axis_ppkt_tlast,
    m_axis_ppkt_tvalid,
    m_axis_ppkt_tready,
    m_axis_ppkt_tdata,
    m_axis_ppkt_tuser,
    m_axis_ppkt_tkeep,
    m_axis_ppkt_tlast);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 aclk CLK" *) (* x_interface_parameter = "ASSOCIATED_BUSIF s_axis_ppkt:m_axis_ppkt, ASSOCIATED_RESET aresetn" *) input aclk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 aresetn RST" *) input aresetn;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 s_axis_ppkt TVALID" *) input s_axis_ppkt_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 s_axis_ppkt TREADY" *) output s_axis_ppkt_tready;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 s_axis_ppkt TDATA" *) input [31:0]s_axis_ppkt_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 s_axis_ppkt TUSER" *) input [79:0]s_axis_ppkt_tuser;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 s_axis_ppkt TKEEP" *) input [1:0]s_axis_ppkt_tkeep;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 s_axis_ppkt TLAST" *) input s_axis_ppkt_tlast;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_ppkt TVALID" *) output m_axis_ppkt_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_ppkt TREADY" *) input m_axis_ppkt_tready;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_ppkt TDATA" *) output [255:0]m_axis_ppkt_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_ppkt TUSER" *) output [79:0]m_axis_ppkt_tuser;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_ppkt TKEEP" *) output [15:0]m_axis_ppkt_tkeep;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis_ppkt TLAST" *) output m_axis_ppkt_tlast;

  wire aclk;
  wire aresetn;
  wire [255:0]m_axis_ppkt_tdata;
  wire [15:0]m_axis_ppkt_tkeep;
  wire m_axis_ppkt_tlast;
  wire m_axis_ppkt_tready;
  wire [79:0]m_axis_ppkt_tuser;
  wire m_axis_ppkt_tvalid;
  wire [31:0]s_axis_ppkt_tdata;
  wire [1:0]s_axis_ppkt_tkeep;
  wire s_axis_ppkt_tlast;
  wire s_axis_ppkt_tready;
  wire [79:0]s_axis_ppkt_tuser;
  wire s_axis_ppkt_tvalid;

  px_vita49_pkt_ppkt_upsizer_px_ppkt_width_upsizer U0
       (.D({s_axis_ppkt_tuser,s_axis_ppkt_tlast,s_axis_ppkt_tkeep,s_axis_ppkt_tdata}),
        .Q(s_axis_ppkt_tready),
        .aclk(aclk),
        .aresetn(aresetn),
        .m_axis_ppkt_tdata(m_axis_ppkt_tdata),
        .m_axis_ppkt_tkeep(m_axis_ppkt_tkeep),
        .m_axis_ppkt_tlast(m_axis_ppkt_tlast),
        .m_axis_ppkt_tready(m_axis_ppkt_tready),
        .m_axis_ppkt_tuser(m_axis_ppkt_tuser),
        .m_axis_ppkt_tvalid(m_axis_ppkt_tvalid),
        .s_axis_ppkt_tvalid(s_axis_ppkt_tvalid));
endmodule

(* ORIG_REF_NAME = "px_axis_dwidth_conv_axis_register_slice" *) 
module px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_conv_axis_register_slice
   (areset_r,
    Q,
    \r0_data_reg[31] ,
    \r0_keep_reg[2] ,
    S_AXIS_TLAST,
    \r0_user_reg[79] ,
    aclk,
    t1_aresetn_reg,
    s_axis_ppkt_tvalid,
    \state_reg[0] ,
    D);
  output areset_r;
  output [1:0]Q;
  output [31:0]\r0_data_reg[31] ;
  output [1:0]\r0_keep_reg[2] ;
  output S_AXIS_TLAST;
  output [79:0]\r0_user_reg[79] ;
  input aclk;
  input t1_aresetn_reg;
  input s_axis_ppkt_tvalid;
  input [0:0]\state_reg[0] ;
  input [114:0]D;

  wire [114:0]D;
  wire [1:0]Q;
  wire S_AXIS_TLAST;
  wire aclk;
  wire areset_r;
  wire areset_r_i_1_n_0;
  wire [31:0]\r0_data_reg[31] ;
  wire [1:0]\r0_keep_reg[2] ;
  wire [79:0]\r0_user_reg[79] ;
  wire s_axis_ppkt_tvalid;
  wire [0:0]\state_reg[0] ;
  wire t1_aresetn_reg;

  LUT1 #(
    .INIT(2'h1)) 
    areset_r_i_1
       (.I0(t1_aresetn_reg),
        .O(areset_r_i_1_n_0));
  FDRE areset_r_reg
       (.C(aclk),
        .CE(1'b1),
        .D(areset_r_i_1_n_0),
        .Q(areset_r),
        .R(1'b0));
  px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_conv_axisc_register_slice axisc_register_slice_0
       (.D(D),
        .Q(Q),
        .SR(areset_r),
        .S_AXIS_TLAST(S_AXIS_TLAST),
        .aclk(aclk),
        .\r0_data_reg[31] (\r0_data_reg[31] ),
        .\r0_keep_reg[2] (\r0_keep_reg[2] ),
        .\r0_user_reg[79] (\r0_user_reg[79] ),
        .s_axis_ppkt_tvalid(s_axis_ppkt_tvalid),
        .\state_reg[0] (\state_reg[0] ));
endmodule

(* ORIG_REF_NAME = "px_axis_dwidth_conv_axisc_register_slice" *) 
module px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_conv_axisc_register_slice
   (Q,
    \r0_data_reg[31] ,
    \r0_keep_reg[2] ,
    S_AXIS_TLAST,
    \r0_user_reg[79] ,
    SR,
    aclk,
    s_axis_ppkt_tvalid,
    \state_reg[0] ,
    D);
  output [1:0]Q;
  output [31:0]\r0_data_reg[31] ;
  output [1:0]\r0_keep_reg[2] ;
  output S_AXIS_TLAST;
  output [79:0]\r0_user_reg[79] ;
  input [0:0]SR;
  input aclk;
  input s_axis_ppkt_tvalid;
  input [0:0]\state_reg[0] ;
  input [114:0]D;

  wire [114:0]D;
  wire [1:0]Q;
  wire [0:0]SR;
  wire S_AXIS_TLAST;
  wire aclk;
  wire \gen_AB_reg_slice.sel_rd_i_1_n_0 ;
  wire \gen_AB_reg_slice.sel_wr_i_1_n_0 ;
  wire \gen_AB_reg_slice.state[1]_i_1_n_0 ;
  wire [116:0]payload_a;
  wire payload_a_1;
  wire [116:0]payload_b;
  wire payload_b_0;
  wire [31:0]\r0_data_reg[31] ;
  wire [1:0]\r0_keep_reg[2] ;
  wire [79:0]\r0_user_reg[79] ;
  wire s_axis_ppkt_tvalid;
  wire sel;
  wire sel_wr;
  wire [1:0]state;
  wire [0:0]\state_reg[0] ;

  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[224]_i_1 
       (.I0(payload_b[0]),
        .I1(payload_a[0]),
        .I2(sel),
        .O(\r0_data_reg[31] [0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[225]_i_1 
       (.I0(payload_b[1]),
        .I1(payload_a[1]),
        .I2(sel),
        .O(\r0_data_reg[31] [1]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[226]_i_1 
       (.I0(payload_b[2]),
        .I1(payload_a[2]),
        .I2(sel),
        .O(\r0_data_reg[31] [2]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[227]_i_1 
       (.I0(payload_b[3]),
        .I1(payload_a[3]),
        .I2(sel),
        .O(\r0_data_reg[31] [3]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[228]_i_1 
       (.I0(payload_b[4]),
        .I1(payload_a[4]),
        .I2(sel),
        .O(\r0_data_reg[31] [4]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[229]_i_1 
       (.I0(payload_b[5]),
        .I1(payload_a[5]),
        .I2(sel),
        .O(\r0_data_reg[31] [5]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[230]_i_1 
       (.I0(payload_b[6]),
        .I1(payload_a[6]),
        .I2(sel),
        .O(\r0_data_reg[31] [6]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[231]_i_1 
       (.I0(payload_b[7]),
        .I1(payload_a[7]),
        .I2(sel),
        .O(\r0_data_reg[31] [7]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[232]_i_1 
       (.I0(payload_b[8]),
        .I1(payload_a[8]),
        .I2(sel),
        .O(\r0_data_reg[31] [8]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[233]_i_1 
       (.I0(payload_b[9]),
        .I1(payload_a[9]),
        .I2(sel),
        .O(\r0_data_reg[31] [9]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[234]_i_1 
       (.I0(payload_b[10]),
        .I1(payload_a[10]),
        .I2(sel),
        .O(\r0_data_reg[31] [10]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[235]_i_1 
       (.I0(payload_b[11]),
        .I1(payload_a[11]),
        .I2(sel),
        .O(\r0_data_reg[31] [11]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[236]_i_1 
       (.I0(payload_b[12]),
        .I1(payload_a[12]),
        .I2(sel),
        .O(\r0_data_reg[31] [12]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[237]_i_1 
       (.I0(payload_b[13]),
        .I1(payload_a[13]),
        .I2(sel),
        .O(\r0_data_reg[31] [13]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[238]_i_1 
       (.I0(payload_b[14]),
        .I1(payload_a[14]),
        .I2(sel),
        .O(\r0_data_reg[31] [14]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[239]_i_1 
       (.I0(payload_b[15]),
        .I1(payload_a[15]),
        .I2(sel),
        .O(\r0_data_reg[31] [15]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[240]_i_1 
       (.I0(payload_b[16]),
        .I1(payload_a[16]),
        .I2(sel),
        .O(\r0_data_reg[31] [16]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[241]_i_1 
       (.I0(payload_b[17]),
        .I1(payload_a[17]),
        .I2(sel),
        .O(\r0_data_reg[31] [17]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[242]_i_1 
       (.I0(payload_b[18]),
        .I1(payload_a[18]),
        .I2(sel),
        .O(\r0_data_reg[31] [18]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[243]_i_1 
       (.I0(payload_b[19]),
        .I1(payload_a[19]),
        .I2(sel),
        .O(\r0_data_reg[31] [19]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[244]_i_1 
       (.I0(payload_b[20]),
        .I1(payload_a[20]),
        .I2(sel),
        .O(\r0_data_reg[31] [20]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[245]_i_1 
       (.I0(payload_b[21]),
        .I1(payload_a[21]),
        .I2(sel),
        .O(\r0_data_reg[31] [21]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[246]_i_1 
       (.I0(payload_b[22]),
        .I1(payload_a[22]),
        .I2(sel),
        .O(\r0_data_reg[31] [22]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[247]_i_1 
       (.I0(payload_b[23]),
        .I1(payload_a[23]),
        .I2(sel),
        .O(\r0_data_reg[31] [23]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[248]_i_1 
       (.I0(payload_b[24]),
        .I1(payload_a[24]),
        .I2(sel),
        .O(\r0_data_reg[31] [24]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[249]_i_1 
       (.I0(payload_b[25]),
        .I1(payload_a[25]),
        .I2(sel),
        .O(\r0_data_reg[31] [25]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[250]_i_1 
       (.I0(payload_b[26]),
        .I1(payload_a[26]),
        .I2(sel),
        .O(\r0_data_reg[31] [26]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[251]_i_1 
       (.I0(payload_b[27]),
        .I1(payload_a[27]),
        .I2(sel),
        .O(\r0_data_reg[31] [27]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[252]_i_1 
       (.I0(payload_b[28]),
        .I1(payload_a[28]),
        .I2(sel),
        .O(\r0_data_reg[31] [28]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[253]_i_1 
       (.I0(payload_b[29]),
        .I1(payload_a[29]),
        .I2(sel),
        .O(\r0_data_reg[31] [29]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[254]_i_1 
       (.I0(payload_b[30]),
        .I1(payload_a[30]),
        .I2(sel),
        .O(\r0_data_reg[31] [30]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_data[255]_i_2 
       (.I0(payload_b[31]),
        .I1(payload_a[31]),
        .I2(sel),
        .O(\r0_data_reg[31] [31]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_keep[28]_i_1 
       (.I0(payload_b[32]),
        .I1(payload_a[32]),
        .I2(sel),
        .O(\r0_keep_reg[2] [0]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \acc_keep[30]_i_2 
       (.I0(payload_b[34]),
        .I1(payload_a[34]),
        .I2(sel),
        .O(\r0_keep_reg[2] [1]));
  LUT3 #(
    .INIT(8'h0D)) 
    \gen_AB_reg_slice.payload_a[116]_i_1 
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(sel_wr),
        .O(payload_a_1));
  FDRE \gen_AB_reg_slice.payload_a_reg[0] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[0]),
        .Q(payload_a[0]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[100] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[98]),
        .Q(payload_a[100]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[101] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[99]),
        .Q(payload_a[101]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[102] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[100]),
        .Q(payload_a[102]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[103] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[101]),
        .Q(payload_a[103]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[104] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[102]),
        .Q(payload_a[104]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[105] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[103]),
        .Q(payload_a[105]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[106] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[104]),
        .Q(payload_a[106]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[107] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[105]),
        .Q(payload_a[107]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[108] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[106]),
        .Q(payload_a[108]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[109] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[107]),
        .Q(payload_a[109]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[10] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[10]),
        .Q(payload_a[10]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[110] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[108]),
        .Q(payload_a[110]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[111] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[109]),
        .Q(payload_a[111]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[112] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[110]),
        .Q(payload_a[112]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[113] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[111]),
        .Q(payload_a[113]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[114] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[112]),
        .Q(payload_a[114]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[115] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[113]),
        .Q(payload_a[115]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[116] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[114]),
        .Q(payload_a[116]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[11] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[11]),
        .Q(payload_a[11]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[12] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[12]),
        .Q(payload_a[12]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[13] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[13]),
        .Q(payload_a[13]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[14] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[14]),
        .Q(payload_a[14]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[15] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[15]),
        .Q(payload_a[15]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[16] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[16]),
        .Q(payload_a[16]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[17] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[17]),
        .Q(payload_a[17]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[18] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[18]),
        .Q(payload_a[18]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[19] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[19]),
        .Q(payload_a[19]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[1] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[1]),
        .Q(payload_a[1]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[20] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[20]),
        .Q(payload_a[20]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[21] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[21]),
        .Q(payload_a[21]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[22] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[22]),
        .Q(payload_a[22]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[23] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[23]),
        .Q(payload_a[23]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[24] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[24]),
        .Q(payload_a[24]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[25] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[25]),
        .Q(payload_a[25]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[26] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[26]),
        .Q(payload_a[26]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[27] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[27]),
        .Q(payload_a[27]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[28] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[28]),
        .Q(payload_a[28]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[29] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[29]),
        .Q(payload_a[29]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[2] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[2]),
        .Q(payload_a[2]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[30] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[30]),
        .Q(payload_a[30]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[31] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[31]),
        .Q(payload_a[31]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[32] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[32]),
        .Q(payload_a[32]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[34] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[33]),
        .Q(payload_a[34]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[36] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[34]),
        .Q(payload_a[36]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[37] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[35]),
        .Q(payload_a[37]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[38] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[36]),
        .Q(payload_a[38]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[39] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[37]),
        .Q(payload_a[39]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[3] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[3]),
        .Q(payload_a[3]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[40] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[38]),
        .Q(payload_a[40]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[41] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[39]),
        .Q(payload_a[41]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[42] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[40]),
        .Q(payload_a[42]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[43] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[41]),
        .Q(payload_a[43]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[44] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[42]),
        .Q(payload_a[44]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[45] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[43]),
        .Q(payload_a[45]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[46] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[44]),
        .Q(payload_a[46]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[47] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[45]),
        .Q(payload_a[47]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[48] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[46]),
        .Q(payload_a[48]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[49] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[47]),
        .Q(payload_a[49]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[4] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[4]),
        .Q(payload_a[4]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[50] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[48]),
        .Q(payload_a[50]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[51] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[49]),
        .Q(payload_a[51]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[52] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[50]),
        .Q(payload_a[52]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[53] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[51]),
        .Q(payload_a[53]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[54] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[52]),
        .Q(payload_a[54]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[55] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[53]),
        .Q(payload_a[55]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[56] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[54]),
        .Q(payload_a[56]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[57] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[55]),
        .Q(payload_a[57]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[58] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[56]),
        .Q(payload_a[58]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[59] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[57]),
        .Q(payload_a[59]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[5] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[5]),
        .Q(payload_a[5]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[60] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[58]),
        .Q(payload_a[60]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[61] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[59]),
        .Q(payload_a[61]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[62] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[60]),
        .Q(payload_a[62]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[63] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[61]),
        .Q(payload_a[63]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[64] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[62]),
        .Q(payload_a[64]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[65] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[63]),
        .Q(payload_a[65]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[66] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[64]),
        .Q(payload_a[66]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[67] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[65]),
        .Q(payload_a[67]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[68] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[66]),
        .Q(payload_a[68]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[69] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[67]),
        .Q(payload_a[69]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[6] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[6]),
        .Q(payload_a[6]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[70] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[68]),
        .Q(payload_a[70]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[71] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[69]),
        .Q(payload_a[71]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[72] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[70]),
        .Q(payload_a[72]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[73] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[71]),
        .Q(payload_a[73]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[74] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[72]),
        .Q(payload_a[74]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[75] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[73]),
        .Q(payload_a[75]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[76] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[74]),
        .Q(payload_a[76]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[77] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[75]),
        .Q(payload_a[77]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[78] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[76]),
        .Q(payload_a[78]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[79] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[77]),
        .Q(payload_a[79]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[7] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[7]),
        .Q(payload_a[7]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[80] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[78]),
        .Q(payload_a[80]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[81] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[79]),
        .Q(payload_a[81]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[82] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[80]),
        .Q(payload_a[82]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[83] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[81]),
        .Q(payload_a[83]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[84] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[82]),
        .Q(payload_a[84]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[85] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[83]),
        .Q(payload_a[85]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[86] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[84]),
        .Q(payload_a[86]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[87] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[85]),
        .Q(payload_a[87]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[88] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[86]),
        .Q(payload_a[88]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[89] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[87]),
        .Q(payload_a[89]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[8] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[8]),
        .Q(payload_a[8]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[90] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[88]),
        .Q(payload_a[90]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[91] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[89]),
        .Q(payload_a[91]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[92] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[90]),
        .Q(payload_a[92]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[93] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[91]),
        .Q(payload_a[93]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[94] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[92]),
        .Q(payload_a[94]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[95] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[93]),
        .Q(payload_a[95]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[96] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[94]),
        .Q(payload_a[96]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[97] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[95]),
        .Q(payload_a[97]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[98] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[96]),
        .Q(payload_a[98]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[99] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[97]),
        .Q(payload_a[99]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_a_reg[9] 
       (.C(aclk),
        .CE(payload_a_1),
        .D(D[9]),
        .Q(payload_a[9]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hD0)) 
    \gen_AB_reg_slice.payload_b[116]_i_1 
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(sel_wr),
        .O(payload_b_0));
  FDRE \gen_AB_reg_slice.payload_b_reg[0] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[0]),
        .Q(payload_b[0]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[100] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[98]),
        .Q(payload_b[100]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[101] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[99]),
        .Q(payload_b[101]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[102] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[100]),
        .Q(payload_b[102]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[103] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[101]),
        .Q(payload_b[103]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[104] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[102]),
        .Q(payload_b[104]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[105] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[103]),
        .Q(payload_b[105]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[106] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[104]),
        .Q(payload_b[106]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[107] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[105]),
        .Q(payload_b[107]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[108] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[106]),
        .Q(payload_b[108]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[109] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[107]),
        .Q(payload_b[109]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[10] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[10]),
        .Q(payload_b[10]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[110] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[108]),
        .Q(payload_b[110]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[111] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[109]),
        .Q(payload_b[111]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[112] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[110]),
        .Q(payload_b[112]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[113] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[111]),
        .Q(payload_b[113]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[114] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[112]),
        .Q(payload_b[114]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[115] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[113]),
        .Q(payload_b[115]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[116] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[114]),
        .Q(payload_b[116]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[11] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[11]),
        .Q(payload_b[11]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[12] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[12]),
        .Q(payload_b[12]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[13] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[13]),
        .Q(payload_b[13]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[14] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[14]),
        .Q(payload_b[14]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[15] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[15]),
        .Q(payload_b[15]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[16] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[16]),
        .Q(payload_b[16]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[17] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[17]),
        .Q(payload_b[17]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[18] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[18]),
        .Q(payload_b[18]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[19] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[19]),
        .Q(payload_b[19]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[1] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[1]),
        .Q(payload_b[1]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[20] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[20]),
        .Q(payload_b[20]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[21] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[21]),
        .Q(payload_b[21]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[22] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[22]),
        .Q(payload_b[22]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[23] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[23]),
        .Q(payload_b[23]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[24] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[24]),
        .Q(payload_b[24]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[25] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[25]),
        .Q(payload_b[25]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[26] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[26]),
        .Q(payload_b[26]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[27] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[27]),
        .Q(payload_b[27]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[28] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[28]),
        .Q(payload_b[28]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[29] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[29]),
        .Q(payload_b[29]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[2] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[2]),
        .Q(payload_b[2]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[30] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[30]),
        .Q(payload_b[30]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[31] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[31]),
        .Q(payload_b[31]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[32] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[32]),
        .Q(payload_b[32]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[34] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[33]),
        .Q(payload_b[34]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[36] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[34]),
        .Q(payload_b[36]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[37] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[35]),
        .Q(payload_b[37]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[38] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[36]),
        .Q(payload_b[38]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[39] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[37]),
        .Q(payload_b[39]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[3] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[3]),
        .Q(payload_b[3]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[40] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[38]),
        .Q(payload_b[40]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[41] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[39]),
        .Q(payload_b[41]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[42] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[40]),
        .Q(payload_b[42]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[43] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[41]),
        .Q(payload_b[43]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[44] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[42]),
        .Q(payload_b[44]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[45] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[43]),
        .Q(payload_b[45]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[46] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[44]),
        .Q(payload_b[46]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[47] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[45]),
        .Q(payload_b[47]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[48] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[46]),
        .Q(payload_b[48]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[49] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[47]),
        .Q(payload_b[49]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[4] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[4]),
        .Q(payload_b[4]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[50] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[48]),
        .Q(payload_b[50]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[51] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[49]),
        .Q(payload_b[51]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[52] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[50]),
        .Q(payload_b[52]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[53] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[51]),
        .Q(payload_b[53]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[54] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[52]),
        .Q(payload_b[54]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[55] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[53]),
        .Q(payload_b[55]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[56] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[54]),
        .Q(payload_b[56]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[57] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[55]),
        .Q(payload_b[57]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[58] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[56]),
        .Q(payload_b[58]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[59] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[57]),
        .Q(payload_b[59]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[5] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[5]),
        .Q(payload_b[5]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[60] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[58]),
        .Q(payload_b[60]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[61] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[59]),
        .Q(payload_b[61]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[62] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[60]),
        .Q(payload_b[62]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[63] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[61]),
        .Q(payload_b[63]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[64] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[62]),
        .Q(payload_b[64]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[65] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[63]),
        .Q(payload_b[65]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[66] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[64]),
        .Q(payload_b[66]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[67] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[65]),
        .Q(payload_b[67]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[68] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[66]),
        .Q(payload_b[68]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[69] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[67]),
        .Q(payload_b[69]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[6] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[6]),
        .Q(payload_b[6]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[70] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[68]),
        .Q(payload_b[70]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[71] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[69]),
        .Q(payload_b[71]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[72] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[70]),
        .Q(payload_b[72]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[73] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[71]),
        .Q(payload_b[73]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[74] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[72]),
        .Q(payload_b[74]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[75] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[73]),
        .Q(payload_b[75]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[76] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[74]),
        .Q(payload_b[76]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[77] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[75]),
        .Q(payload_b[77]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[78] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[76]),
        .Q(payload_b[78]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[79] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[77]),
        .Q(payload_b[79]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[7] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[7]),
        .Q(payload_b[7]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[80] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[78]),
        .Q(payload_b[80]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[81] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[79]),
        .Q(payload_b[81]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[82] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[80]),
        .Q(payload_b[82]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[83] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[81]),
        .Q(payload_b[83]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[84] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[82]),
        .Q(payload_b[84]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[85] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[83]),
        .Q(payload_b[85]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[86] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[84]),
        .Q(payload_b[86]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[87] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[85]),
        .Q(payload_b[87]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[88] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[86]),
        .Q(payload_b[88]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[89] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[87]),
        .Q(payload_b[89]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[8] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[8]),
        .Q(payload_b[8]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[90] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[88]),
        .Q(payload_b[90]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[91] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[89]),
        .Q(payload_b[91]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[92] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[90]),
        .Q(payload_b[92]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[93] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[91]),
        .Q(payload_b[93]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[94] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[92]),
        .Q(payload_b[94]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[95] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[93]),
        .Q(payload_b[95]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[96] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[94]),
        .Q(payload_b[96]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[97] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[95]),
        .Q(payload_b[97]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[98] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[96]),
        .Q(payload_b[98]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[99] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[97]),
        .Q(payload_b[99]),
        .R(1'b0));
  FDRE \gen_AB_reg_slice.payload_b_reg[9] 
       (.C(aclk),
        .CE(payload_b_0),
        .D(D[9]),
        .Q(payload_b[9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \gen_AB_reg_slice.sel_rd_i_1 
       (.I0(\state_reg[0] ),
        .I1(Q[0]),
        .I2(sel),
        .O(\gen_AB_reg_slice.sel_rd_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_AB_reg_slice.sel_rd_reg 
       (.C(aclk),
        .CE(1'b1),
        .D(\gen_AB_reg_slice.sel_rd_i_1_n_0 ),
        .Q(sel),
        .R(SR));
  LUT3 #(
    .INIT(8'h78)) 
    \gen_AB_reg_slice.sel_wr_i_1 
       (.I0(Q[1]),
        .I1(s_axis_ppkt_tvalid),
        .I2(sel_wr),
        .O(\gen_AB_reg_slice.sel_wr_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_AB_reg_slice.sel_wr_reg 
       (.C(aclk),
        .CE(1'b1),
        .D(\gen_AB_reg_slice.sel_wr_i_1_n_0 ),
        .Q(sel_wr),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h7088)) 
    \gen_AB_reg_slice.state[0]_i_1 
       (.I0(\state_reg[0] ),
        .I1(Q[0]),
        .I2(s_axis_ppkt_tvalid),
        .I3(Q[1]),
        .O(state[0]));
  LUT4 #(
    .INIT(16'h78BB)) 
    \gen_AB_reg_slice.state[1]_i_1 
       (.I0(\state_reg[0] ),
        .I1(Q[0]),
        .I2(s_axis_ppkt_tvalid),
        .I3(Q[1]),
        .O(\gen_AB_reg_slice.state[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hBCBB)) 
    \gen_AB_reg_slice.state[1]_i_2 
       (.I0(\state_reg[0] ),
        .I1(Q[0]),
        .I2(s_axis_ppkt_tvalid),
        .I3(Q[1]),
        .O(state[1]));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \gen_AB_reg_slice.state_reg[0] 
       (.C(aclk),
        .CE(\gen_AB_reg_slice.state[1]_i_1_n_0 ),
        .D(state[0]),
        .Q(Q[0]),
        .R(SR));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \gen_AB_reg_slice.state_reg[1] 
       (.C(aclk),
        .CE(\gen_AB_reg_slice.state[1]_i_1_n_0 ),
        .D(state[1]),
        .Q(Q[1]),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    r0_last_i_1
       (.I0(payload_b[36]),
        .I1(payload_a[36]),
        .I2(sel),
        .O(S_AXIS_TLAST));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[0]_i_1 
       (.I0(payload_b[37]),
        .I1(payload_a[37]),
        .I2(sel),
        .O(\r0_user_reg[79] [0]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[10]_i_1 
       (.I0(payload_b[47]),
        .I1(payload_a[47]),
        .I2(sel),
        .O(\r0_user_reg[79] [10]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[11]_i_1 
       (.I0(payload_b[48]),
        .I1(payload_a[48]),
        .I2(sel),
        .O(\r0_user_reg[79] [11]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[12]_i_1 
       (.I0(payload_b[49]),
        .I1(payload_a[49]),
        .I2(sel),
        .O(\r0_user_reg[79] [12]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[13]_i_1 
       (.I0(payload_b[50]),
        .I1(payload_a[50]),
        .I2(sel),
        .O(\r0_user_reg[79] [13]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[14]_i_1 
       (.I0(payload_b[51]),
        .I1(payload_a[51]),
        .I2(sel),
        .O(\r0_user_reg[79] [14]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[15]_i_1 
       (.I0(payload_b[52]),
        .I1(payload_a[52]),
        .I2(sel),
        .O(\r0_user_reg[79] [15]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[16]_i_1 
       (.I0(payload_b[53]),
        .I1(payload_a[53]),
        .I2(sel),
        .O(\r0_user_reg[79] [16]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[17]_i_1 
       (.I0(payload_b[54]),
        .I1(payload_a[54]),
        .I2(sel),
        .O(\r0_user_reg[79] [17]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[18]_i_1 
       (.I0(payload_b[55]),
        .I1(payload_a[55]),
        .I2(sel),
        .O(\r0_user_reg[79] [18]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[19]_i_1 
       (.I0(payload_b[56]),
        .I1(payload_a[56]),
        .I2(sel),
        .O(\r0_user_reg[79] [19]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[1]_i_1 
       (.I0(payload_b[38]),
        .I1(payload_a[38]),
        .I2(sel),
        .O(\r0_user_reg[79] [1]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[20]_i_1 
       (.I0(payload_b[57]),
        .I1(payload_a[57]),
        .I2(sel),
        .O(\r0_user_reg[79] [20]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[21]_i_1 
       (.I0(payload_b[58]),
        .I1(payload_a[58]),
        .I2(sel),
        .O(\r0_user_reg[79] [21]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[22]_i_1 
       (.I0(payload_b[59]),
        .I1(payload_a[59]),
        .I2(sel),
        .O(\r0_user_reg[79] [22]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[23]_i_1 
       (.I0(payload_b[60]),
        .I1(payload_a[60]),
        .I2(sel),
        .O(\r0_user_reg[79] [23]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[24]_i_1 
       (.I0(payload_b[61]),
        .I1(payload_a[61]),
        .I2(sel),
        .O(\r0_user_reg[79] [24]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[25]_i_1 
       (.I0(payload_b[62]),
        .I1(payload_a[62]),
        .I2(sel),
        .O(\r0_user_reg[79] [25]));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[26]_i_1 
       (.I0(payload_b[63]),
        .I1(payload_a[63]),
        .I2(sel),
        .O(\r0_user_reg[79] [26]));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[27]_i_1 
       (.I0(payload_b[64]),
        .I1(payload_a[64]),
        .I2(sel),
        .O(\r0_user_reg[79] [27]));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[28]_i_1 
       (.I0(payload_b[65]),
        .I1(payload_a[65]),
        .I2(sel),
        .O(\r0_user_reg[79] [28]));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[29]_i_1 
       (.I0(payload_b[66]),
        .I1(payload_a[66]),
        .I2(sel),
        .O(\r0_user_reg[79] [29]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[2]_i_1 
       (.I0(payload_b[39]),
        .I1(payload_a[39]),
        .I2(sel),
        .O(\r0_user_reg[79] [2]));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[30]_i_1 
       (.I0(payload_b[67]),
        .I1(payload_a[67]),
        .I2(sel),
        .O(\r0_user_reg[79] [30]));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[31]_i_1 
       (.I0(payload_b[68]),
        .I1(payload_a[68]),
        .I2(sel),
        .O(\r0_user_reg[79] [31]));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[32]_i_1 
       (.I0(payload_b[69]),
        .I1(payload_a[69]),
        .I2(sel),
        .O(\r0_user_reg[79] [32]));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[33]_i_1 
       (.I0(payload_b[70]),
        .I1(payload_a[70]),
        .I2(sel),
        .O(\r0_user_reg[79] [33]));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[34]_i_1 
       (.I0(payload_b[71]),
        .I1(payload_a[71]),
        .I2(sel),
        .O(\r0_user_reg[79] [34]));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[35]_i_1 
       (.I0(payload_b[72]),
        .I1(payload_a[72]),
        .I2(sel),
        .O(\r0_user_reg[79] [35]));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[36]_i_1 
       (.I0(payload_b[73]),
        .I1(payload_a[73]),
        .I2(sel),
        .O(\r0_user_reg[79] [36]));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[37]_i_1 
       (.I0(payload_b[74]),
        .I1(payload_a[74]),
        .I2(sel),
        .O(\r0_user_reg[79] [37]));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[38]_i_1 
       (.I0(payload_b[75]),
        .I1(payload_a[75]),
        .I2(sel),
        .O(\r0_user_reg[79] [38]));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[39]_i_1 
       (.I0(payload_b[76]),
        .I1(payload_a[76]),
        .I2(sel),
        .O(\r0_user_reg[79] [39]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[3]_i_1 
       (.I0(payload_b[40]),
        .I1(payload_a[40]),
        .I2(sel),
        .O(\r0_user_reg[79] [3]));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[40]_i_1 
       (.I0(payload_b[77]),
        .I1(payload_a[77]),
        .I2(sel),
        .O(\r0_user_reg[79] [40]));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[41]_i_1 
       (.I0(payload_b[78]),
        .I1(payload_a[78]),
        .I2(sel),
        .O(\r0_user_reg[79] [41]));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[42]_i_1 
       (.I0(payload_b[79]),
        .I1(payload_a[79]),
        .I2(sel),
        .O(\r0_user_reg[79] [42]));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[43]_i_1 
       (.I0(payload_b[80]),
        .I1(payload_a[80]),
        .I2(sel),
        .O(\r0_user_reg[79] [43]));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[44]_i_1 
       (.I0(payload_b[81]),
        .I1(payload_a[81]),
        .I2(sel),
        .O(\r0_user_reg[79] [44]));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[45]_i_1 
       (.I0(payload_b[82]),
        .I1(payload_a[82]),
        .I2(sel),
        .O(\r0_user_reg[79] [45]));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[46]_i_1 
       (.I0(payload_b[83]),
        .I1(payload_a[83]),
        .I2(sel),
        .O(\r0_user_reg[79] [46]));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[47]_i_1 
       (.I0(payload_b[84]),
        .I1(payload_a[84]),
        .I2(sel),
        .O(\r0_user_reg[79] [47]));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[48]_i_1 
       (.I0(payload_b[85]),
        .I1(payload_a[85]),
        .I2(sel),
        .O(\r0_user_reg[79] [48]));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[49]_i_1 
       (.I0(payload_b[86]),
        .I1(payload_a[86]),
        .I2(sel),
        .O(\r0_user_reg[79] [49]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[4]_i_1 
       (.I0(payload_b[41]),
        .I1(payload_a[41]),
        .I2(sel),
        .O(\r0_user_reg[79] [4]));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[50]_i_1 
       (.I0(payload_b[87]),
        .I1(payload_a[87]),
        .I2(sel),
        .O(\r0_user_reg[79] [50]));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[51]_i_1 
       (.I0(payload_b[88]),
        .I1(payload_a[88]),
        .I2(sel),
        .O(\r0_user_reg[79] [51]));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[52]_i_1 
       (.I0(payload_b[89]),
        .I1(payload_a[89]),
        .I2(sel),
        .O(\r0_user_reg[79] [52]));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[53]_i_1 
       (.I0(payload_b[90]),
        .I1(payload_a[90]),
        .I2(sel),
        .O(\r0_user_reg[79] [53]));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[54]_i_1 
       (.I0(payload_b[91]),
        .I1(payload_a[91]),
        .I2(sel),
        .O(\r0_user_reg[79] [54]));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[55]_i_1 
       (.I0(payload_b[92]),
        .I1(payload_a[92]),
        .I2(sel),
        .O(\r0_user_reg[79] [55]));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[56]_i_1 
       (.I0(payload_b[93]),
        .I1(payload_a[93]),
        .I2(sel),
        .O(\r0_user_reg[79] [56]));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[57]_i_1 
       (.I0(payload_b[94]),
        .I1(payload_a[94]),
        .I2(sel),
        .O(\r0_user_reg[79] [57]));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[58]_i_1 
       (.I0(payload_b[95]),
        .I1(payload_a[95]),
        .I2(sel),
        .O(\r0_user_reg[79] [58]));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[59]_i_1 
       (.I0(payload_b[96]),
        .I1(payload_a[96]),
        .I2(sel),
        .O(\r0_user_reg[79] [59]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[5]_i_1 
       (.I0(payload_b[42]),
        .I1(payload_a[42]),
        .I2(sel),
        .O(\r0_user_reg[79] [5]));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[60]_i_1 
       (.I0(payload_b[97]),
        .I1(payload_a[97]),
        .I2(sel),
        .O(\r0_user_reg[79] [60]));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[61]_i_1 
       (.I0(payload_b[98]),
        .I1(payload_a[98]),
        .I2(sel),
        .O(\r0_user_reg[79] [61]));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[62]_i_1 
       (.I0(payload_b[99]),
        .I1(payload_a[99]),
        .I2(sel),
        .O(\r0_user_reg[79] [62]));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[63]_i_1 
       (.I0(payload_b[100]),
        .I1(payload_a[100]),
        .I2(sel),
        .O(\r0_user_reg[79] [63]));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[64]_i_1 
       (.I0(payload_b[101]),
        .I1(payload_a[101]),
        .I2(sel),
        .O(\r0_user_reg[79] [64]));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[65]_i_1 
       (.I0(payload_b[102]),
        .I1(payload_a[102]),
        .I2(sel),
        .O(\r0_user_reg[79] [65]));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[66]_i_1 
       (.I0(payload_b[103]),
        .I1(payload_a[103]),
        .I2(sel),
        .O(\r0_user_reg[79] [66]));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[67]_i_1 
       (.I0(payload_b[104]),
        .I1(payload_a[104]),
        .I2(sel),
        .O(\r0_user_reg[79] [67]));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[68]_i_1 
       (.I0(payload_b[105]),
        .I1(payload_a[105]),
        .I2(sel),
        .O(\r0_user_reg[79] [68]));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[69]_i_1 
       (.I0(payload_b[106]),
        .I1(payload_a[106]),
        .I2(sel),
        .O(\r0_user_reg[79] [69]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[6]_i_1 
       (.I0(payload_b[43]),
        .I1(payload_a[43]),
        .I2(sel),
        .O(\r0_user_reg[79] [6]));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[70]_i_1 
       (.I0(payload_b[107]),
        .I1(payload_a[107]),
        .I2(sel),
        .O(\r0_user_reg[79] [70]));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[71]_i_1 
       (.I0(payload_b[108]),
        .I1(payload_a[108]),
        .I2(sel),
        .O(\r0_user_reg[79] [71]));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[72]_i_1 
       (.I0(payload_b[109]),
        .I1(payload_a[109]),
        .I2(sel),
        .O(\r0_user_reg[79] [72]));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[73]_i_1 
       (.I0(payload_b[110]),
        .I1(payload_a[110]),
        .I2(sel),
        .O(\r0_user_reg[79] [73]));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[74]_i_1 
       (.I0(payload_b[111]),
        .I1(payload_a[111]),
        .I2(sel),
        .O(\r0_user_reg[79] [74]));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[75]_i_1 
       (.I0(payload_b[112]),
        .I1(payload_a[112]),
        .I2(sel),
        .O(\r0_user_reg[79] [75]));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[76]_i_1 
       (.I0(payload_b[113]),
        .I1(payload_a[113]),
        .I2(sel),
        .O(\r0_user_reg[79] [76]));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[77]_i_1 
       (.I0(payload_b[114]),
        .I1(payload_a[114]),
        .I2(sel),
        .O(\r0_user_reg[79] [77]));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[78]_i_1 
       (.I0(payload_b[115]),
        .I1(payload_a[115]),
        .I2(sel),
        .O(\r0_user_reg[79] [78]));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[79]_i_1 
       (.I0(payload_b[116]),
        .I1(payload_a[116]),
        .I2(sel),
        .O(\r0_user_reg[79] [79]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[7]_i_1 
       (.I0(payload_b[44]),
        .I1(payload_a[44]),
        .I2(sel),
        .O(\r0_user_reg[79] [7]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[8]_i_1 
       (.I0(payload_b[45]),
        .I1(payload_a[45]),
        .I2(sel),
        .O(\r0_user_reg[79] [8]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \r0_user[9]_i_1 
       (.I0(payload_b[46]),
        .I1(payload_a[46]),
        .I2(sel),
        .O(\r0_user_reg[79] [9]));
endmodule

(* ORIG_REF_NAME = "px_axis_dwidth_conv_axisc_upsizer" *) 
module px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_conv_axisc_upsizer
   (Q,
    m_axis_ppkt_tlast,
    m_axis_ppkt_tdata,
    m_axis_ppkt_tkeep,
    m_axis_ppkt_tuser,
    S_AXIS_TLAST,
    aclk,
    m_axis_ppkt_tready,
    \gen_AB_reg_slice.state_reg[0] ,
    areset_r,
    D,
    \gen_AB_reg_slice.payload_b_reg[34] ,
    \gen_AB_reg_slice.payload_b_reg[116] );
  output [1:0]Q;
  output m_axis_ppkt_tlast;
  output [255:0]m_axis_ppkt_tdata;
  output [15:0]m_axis_ppkt_tkeep;
  output [79:0]m_axis_ppkt_tuser;
  input S_AXIS_TLAST;
  input aclk;
  input m_axis_ppkt_tready;
  input [0:0]\gen_AB_reg_slice.state_reg[0] ;
  input areset_r;
  input [31:0]D;
  input [1:0]\gen_AB_reg_slice.payload_b_reg[34] ;
  input [79:0]\gen_AB_reg_slice.payload_b_reg[116] ;

  wire [31:0]D;
  wire \FSM_onehot_state[0]_i_1_n_0 ;
  wire \FSM_onehot_state[0]_i_2_n_0 ;
  wire \FSM_onehot_state[0]_i_3_n_0 ;
  wire \FSM_onehot_state[0]_i_4_n_0 ;
  wire \FSM_onehot_state[2]_i_1_n_0 ;
  wire \FSM_onehot_state[2]_i_2_n_0 ;
  wire \FSM_onehot_state[2]_i_3_n_0 ;
  wire \FSM_onehot_state[3]_i_1_n_0 ;
  wire \FSM_onehot_state[3]_i_3_n_0 ;
  wire \FSM_onehot_state[3]_i_4_n_0 ;
  wire \FSM_onehot_state[4]_i_1_n_0 ;
  wire \FSM_onehot_state[4]_i_2_n_0 ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[0] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[1] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[2] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[4] ;
  wire [1:0]Q;
  wire S_AXIS_TLAST;
  wire \acc_data[255]_i_1_n_0 ;
  wire acc_last_i_1_n_0;
  wire [5:0]acc_reg_en;
  wire acc_strb;
  wire aclk;
  wire areset_r;
  wire [79:0]\gen_AB_reg_slice.payload_b_reg[116] ;
  wire [1:0]\gen_AB_reg_slice.payload_b_reg[34] ;
  wire [0:0]\gen_AB_reg_slice.state_reg[0] ;
  wire \gen_data_accumulator[6].acc_data[223]_i_1_n_0 ;
  wire [255:0]m_axis_ppkt_tdata;
  wire [15:0]m_axis_ppkt_tkeep;
  wire m_axis_ppkt_tlast;
  wire m_axis_ppkt_tready;
  wire [79:0]m_axis_ppkt_tuser;
  (* RTL_KEEP = "yes" *) wire p_0_in4_in;
  wire [6:6]p_1_in;
  wire p_1_in2_in;
  wire [31:0]r0_data;
  wire [2:0]r0_keep;
  wire r0_last_reg_n_0;
  wire \r0_reg_sel_reg_n_0_[0] ;
  wire \r0_reg_sel_reg_n_0_[1] ;
  wire \r0_reg_sel_reg_n_0_[2] ;
  wire \r0_reg_sel_reg_n_0_[3] ;
  wire \r0_reg_sel_reg_n_0_[4] ;
  wire \r0_reg_sel_reg_n_0_[5] ;
  wire \r0_reg_sel_reg_n_0_[6] ;
  wire [79:0]r0_user;
  wire [2:0]state;
  wire state1;
  wire \state[1]_i_2_n_0 ;
  wire \state[2]_i_2_n_0 ;
  wire \state[2]_i_3_n_0 ;
  wire \state_reg_n_0_[2] ;

  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFF10)) 
    \FSM_onehot_state[0]_i_1 
       (.I0(state1),
        .I1(\gen_AB_reg_slice.state_reg[0] ),
        .I2(\FSM_onehot_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_state[0]_i_2_n_0 ),
        .I4(\FSM_onehot_state[0]_i_3_n_0 ),
        .I5(\FSM_onehot_state[0]_i_4_n_0 ),
        .O(\FSM_onehot_state[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF0001)) 
    \FSM_onehot_state[0]_i_2 
       (.I0(\FSM_onehot_state_reg_n_0_[2] ),
        .I1(\FSM_onehot_state_reg_n_0_[4] ),
        .I2(p_0_in4_in),
        .I3(\FSM_onehot_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_state_reg_n_0_[1] ),
        .O(\FSM_onehot_state[0]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00020000)) 
    \FSM_onehot_state[0]_i_3 
       (.I0(m_axis_ppkt_tready),
        .I1(\gen_AB_reg_slice.state_reg[0] ),
        .I2(\FSM_onehot_state_reg_n_0_[0] ),
        .I3(p_0_in4_in),
        .I4(\FSM_onehot_state_reg_n_0_[2] ),
        .O(\FSM_onehot_state[0]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h0100)) 
    \FSM_onehot_state[0]_i_4 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(\gen_AB_reg_slice.state_reg[0] ),
        .I2(r0_last_reg_n_0),
        .I3(p_0_in4_in),
        .O(\FSM_onehot_state[0]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h0000FFF8)) 
    \FSM_onehot_state[2]_i_1 
       (.I0(state1),
        .I1(\FSM_onehot_state_reg_n_0_[0] ),
        .I2(\FSM_onehot_state[2]_i_2_n_0 ),
        .I3(\FSM_onehot_state[2]_i_3_n_0 ),
        .I4(\FSM_onehot_state_reg_n_0_[1] ),
        .O(\FSM_onehot_state[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0055540000000000)) 
    \FSM_onehot_state[2]_i_2 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(p_1_in2_in),
        .I2(\r0_reg_sel_reg_n_0_[6] ),
        .I3(\gen_AB_reg_slice.state_reg[0] ),
        .I4(r0_last_reg_n_0),
        .I5(p_0_in4_in),
        .O(\FSM_onehot_state[2]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00010000)) 
    \FSM_onehot_state[2]_i_3 
       (.I0(m_axis_ppkt_tready),
        .I1(\gen_AB_reg_slice.state_reg[0] ),
        .I2(\FSM_onehot_state_reg_n_0_[0] ),
        .I3(p_0_in4_in),
        .I4(\FSM_onehot_state_reg_n_0_[2] ),
        .O(\FSM_onehot_state[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h000000002222FFF0)) 
    \FSM_onehot_state[3]_i_1 
       (.I0(\gen_AB_reg_slice.state_reg[0] ),
        .I1(state1),
        .I2(\FSM_onehot_state[3]_i_3_n_0 ),
        .I3(\FSM_onehot_state[3]_i_4_n_0 ),
        .I4(\FSM_onehot_state_reg_n_0_[0] ),
        .I5(\FSM_onehot_state_reg_n_0_[1] ),
        .O(\FSM_onehot_state[3]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hEA00)) 
    \FSM_onehot_state[3]_i_2 
       (.I0(p_1_in2_in),
        .I1(p_0_in4_in),
        .I2(\r0_reg_sel_reg_n_0_[6] ),
        .I3(\gen_AB_reg_slice.state_reg[0] ),
        .O(state1));
  LUT5 #(
    .INIT(32'h0000AC00)) 
    \FSM_onehot_state[3]_i_3 
       (.I0(\gen_AB_reg_slice.state_reg[0] ),
        .I1(\FSM_onehot_state_reg_n_0_[4] ),
        .I2(\FSM_onehot_state_reg_n_0_[2] ),
        .I3(m_axis_ppkt_tready),
        .I4(p_0_in4_in),
        .O(\FSM_onehot_state[3]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00000200)) 
    \FSM_onehot_state[3]_i_4 
       (.I0(\gen_AB_reg_slice.state_reg[0] ),
        .I1(r0_last_reg_n_0),
        .I2(p_1_in2_in),
        .I3(p_0_in4_in),
        .I4(\r0_reg_sel_reg_n_0_[6] ),
        .O(\FSM_onehot_state[3]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'h10)) 
    \FSM_onehot_state[4]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[1] ),
        .I1(\FSM_onehot_state_reg_n_0_[0] ),
        .I2(\FSM_onehot_state[4]_i_2_n_0 ),
        .O(\FSM_onehot_state[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFF54001000540010)) 
    \FSM_onehot_state[4]_i_2 
       (.I0(m_axis_ppkt_tready),
        .I1(\FSM_onehot_state_reg_n_0_[2] ),
        .I2(\FSM_onehot_state_reg_n_0_[4] ),
        .I3(p_0_in4_in),
        .I4(\gen_AB_reg_slice.state_reg[0] ),
        .I5(r0_last_reg_n_0),
        .O(\FSM_onehot_state[4]_i_2_n_0 ));
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[0] 
       (.C(aclk),
        .CE(1'b1),
        .D(\FSM_onehot_state[0]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[0] ),
        .R(areset_r));
  (* KEEP = "yes" *) 
  FDSE #(
    .INIT(1'b1)) 
    \FSM_onehot_state_reg[1] 
       (.C(aclk),
        .CE(1'b1),
        .D(1'b0),
        .Q(\FSM_onehot_state_reg_n_0_[1] ),
        .S(areset_r));
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[2] 
       (.C(aclk),
        .CE(1'b1),
        .D(\FSM_onehot_state[2]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[2] ),
        .R(areset_r));
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[3] 
       (.C(aclk),
        .CE(1'b1),
        .D(\FSM_onehot_state[3]_i_1_n_0 ),
        .Q(p_0_in4_in),
        .R(areset_r));
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[4] 
       (.C(aclk),
        .CE(1'b1),
        .D(\FSM_onehot_state[4]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[4] ),
        .R(areset_r));
  LUT2 #(
    .INIT(4'hE)) 
    \acc_data[255]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(p_0_in4_in),
        .O(\acc_data[255]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \acc_data[31]_i_1 
       (.I0(p_0_in4_in),
        .I1(\r0_reg_sel_reg_n_0_[0] ),
        .O(acc_reg_en[0]));
  FDRE \acc_data_reg[0] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[0]),
        .Q(m_axis_ppkt_tdata[0]),
        .R(1'b0));
  FDRE \acc_data_reg[10] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[10]),
        .Q(m_axis_ppkt_tdata[10]),
        .R(1'b0));
  FDRE \acc_data_reg[11] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[11]),
        .Q(m_axis_ppkt_tdata[11]),
        .R(1'b0));
  FDRE \acc_data_reg[12] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[12]),
        .Q(m_axis_ppkt_tdata[12]),
        .R(1'b0));
  FDRE \acc_data_reg[13] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[13]),
        .Q(m_axis_ppkt_tdata[13]),
        .R(1'b0));
  FDRE \acc_data_reg[14] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[14]),
        .Q(m_axis_ppkt_tdata[14]),
        .R(1'b0));
  FDRE \acc_data_reg[15] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[15]),
        .Q(m_axis_ppkt_tdata[15]),
        .R(1'b0));
  FDRE \acc_data_reg[16] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[16]),
        .Q(m_axis_ppkt_tdata[16]),
        .R(1'b0));
  FDRE \acc_data_reg[17] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[17]),
        .Q(m_axis_ppkt_tdata[17]),
        .R(1'b0));
  FDRE \acc_data_reg[18] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[18]),
        .Q(m_axis_ppkt_tdata[18]),
        .R(1'b0));
  FDRE \acc_data_reg[19] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[19]),
        .Q(m_axis_ppkt_tdata[19]),
        .R(1'b0));
  FDRE \acc_data_reg[1] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[1]),
        .Q(m_axis_ppkt_tdata[1]),
        .R(1'b0));
  FDRE \acc_data_reg[20] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[20]),
        .Q(m_axis_ppkt_tdata[20]),
        .R(1'b0));
  FDRE \acc_data_reg[21] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[21]),
        .Q(m_axis_ppkt_tdata[21]),
        .R(1'b0));
  FDRE \acc_data_reg[224] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[0]),
        .Q(m_axis_ppkt_tdata[224]),
        .R(1'b0));
  FDRE \acc_data_reg[225] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[1]),
        .Q(m_axis_ppkt_tdata[225]),
        .R(1'b0));
  FDRE \acc_data_reg[226] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[2]),
        .Q(m_axis_ppkt_tdata[226]),
        .R(1'b0));
  FDRE \acc_data_reg[227] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[3]),
        .Q(m_axis_ppkt_tdata[227]),
        .R(1'b0));
  FDRE \acc_data_reg[228] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[4]),
        .Q(m_axis_ppkt_tdata[228]),
        .R(1'b0));
  FDRE \acc_data_reg[229] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[5]),
        .Q(m_axis_ppkt_tdata[229]),
        .R(1'b0));
  FDRE \acc_data_reg[22] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[22]),
        .Q(m_axis_ppkt_tdata[22]),
        .R(1'b0));
  FDRE \acc_data_reg[230] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[6]),
        .Q(m_axis_ppkt_tdata[230]),
        .R(1'b0));
  FDRE \acc_data_reg[231] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[7]),
        .Q(m_axis_ppkt_tdata[231]),
        .R(1'b0));
  FDRE \acc_data_reg[232] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[8]),
        .Q(m_axis_ppkt_tdata[232]),
        .R(1'b0));
  FDRE \acc_data_reg[233] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[9]),
        .Q(m_axis_ppkt_tdata[233]),
        .R(1'b0));
  FDRE \acc_data_reg[234] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[10]),
        .Q(m_axis_ppkt_tdata[234]),
        .R(1'b0));
  FDRE \acc_data_reg[235] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[11]),
        .Q(m_axis_ppkt_tdata[235]),
        .R(1'b0));
  FDRE \acc_data_reg[236] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[12]),
        .Q(m_axis_ppkt_tdata[236]),
        .R(1'b0));
  FDRE \acc_data_reg[237] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[13]),
        .Q(m_axis_ppkt_tdata[237]),
        .R(1'b0));
  FDRE \acc_data_reg[238] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[14]),
        .Q(m_axis_ppkt_tdata[238]),
        .R(1'b0));
  FDRE \acc_data_reg[239] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[15]),
        .Q(m_axis_ppkt_tdata[239]),
        .R(1'b0));
  FDRE \acc_data_reg[23] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[23]),
        .Q(m_axis_ppkt_tdata[23]),
        .R(1'b0));
  FDRE \acc_data_reg[240] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[16]),
        .Q(m_axis_ppkt_tdata[240]),
        .R(1'b0));
  FDRE \acc_data_reg[241] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[17]),
        .Q(m_axis_ppkt_tdata[241]),
        .R(1'b0));
  FDRE \acc_data_reg[242] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[18]),
        .Q(m_axis_ppkt_tdata[242]),
        .R(1'b0));
  FDRE \acc_data_reg[243] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[19]),
        .Q(m_axis_ppkt_tdata[243]),
        .R(1'b0));
  FDRE \acc_data_reg[244] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[20]),
        .Q(m_axis_ppkt_tdata[244]),
        .R(1'b0));
  FDRE \acc_data_reg[245] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[21]),
        .Q(m_axis_ppkt_tdata[245]),
        .R(1'b0));
  FDRE \acc_data_reg[246] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[22]),
        .Q(m_axis_ppkt_tdata[246]),
        .R(1'b0));
  FDRE \acc_data_reg[247] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[23]),
        .Q(m_axis_ppkt_tdata[247]),
        .R(1'b0));
  FDRE \acc_data_reg[248] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[24]),
        .Q(m_axis_ppkt_tdata[248]),
        .R(1'b0));
  FDRE \acc_data_reg[249] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[25]),
        .Q(m_axis_ppkt_tdata[249]),
        .R(1'b0));
  FDRE \acc_data_reg[24] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[24]),
        .Q(m_axis_ppkt_tdata[24]),
        .R(1'b0));
  FDRE \acc_data_reg[250] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[26]),
        .Q(m_axis_ppkt_tdata[250]),
        .R(1'b0));
  FDRE \acc_data_reg[251] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[27]),
        .Q(m_axis_ppkt_tdata[251]),
        .R(1'b0));
  FDRE \acc_data_reg[252] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[28]),
        .Q(m_axis_ppkt_tdata[252]),
        .R(1'b0));
  FDRE \acc_data_reg[253] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[29]),
        .Q(m_axis_ppkt_tdata[253]),
        .R(1'b0));
  FDRE \acc_data_reg[254] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[30]),
        .Q(m_axis_ppkt_tdata[254]),
        .R(1'b0));
  FDRE \acc_data_reg[255] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(D[31]),
        .Q(m_axis_ppkt_tdata[255]),
        .R(1'b0));
  FDRE \acc_data_reg[25] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[25]),
        .Q(m_axis_ppkt_tdata[25]),
        .R(1'b0));
  FDRE \acc_data_reg[26] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[26]),
        .Q(m_axis_ppkt_tdata[26]),
        .R(1'b0));
  FDRE \acc_data_reg[27] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[27]),
        .Q(m_axis_ppkt_tdata[27]),
        .R(1'b0));
  FDRE \acc_data_reg[28] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[28]),
        .Q(m_axis_ppkt_tdata[28]),
        .R(1'b0));
  FDRE \acc_data_reg[29] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[29]),
        .Q(m_axis_ppkt_tdata[29]),
        .R(1'b0));
  FDRE \acc_data_reg[2] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[2]),
        .Q(m_axis_ppkt_tdata[2]),
        .R(1'b0));
  FDRE \acc_data_reg[30] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[30]),
        .Q(m_axis_ppkt_tdata[30]),
        .R(1'b0));
  FDRE \acc_data_reg[31] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[31]),
        .Q(m_axis_ppkt_tdata[31]),
        .R(1'b0));
  FDRE \acc_data_reg[3] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[3]),
        .Q(m_axis_ppkt_tdata[3]),
        .R(1'b0));
  FDRE \acc_data_reg[4] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[4]),
        .Q(m_axis_ppkt_tdata[4]),
        .R(1'b0));
  FDRE \acc_data_reg[5] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[5]),
        .Q(m_axis_ppkt_tdata[5]),
        .R(1'b0));
  FDRE \acc_data_reg[6] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[6]),
        .Q(m_axis_ppkt_tdata[6]),
        .R(1'b0));
  FDRE \acc_data_reg[7] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[7]),
        .Q(m_axis_ppkt_tdata[7]),
        .R(1'b0));
  FDRE \acc_data_reg[8] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[8]),
        .Q(m_axis_ppkt_tdata[8]),
        .R(1'b0));
  FDRE \acc_data_reg[9] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_data[9]),
        .Q(m_axis_ppkt_tdata[9]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hE0)) 
    \acc_keep[30]_i_1 
       (.I0(r0_last_reg_n_0),
        .I1(\r0_reg_sel_reg_n_0_[0] ),
        .I2(p_0_in4_in),
        .O(acc_strb));
  FDRE \acc_keep_reg[0] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_keep[0]),
        .Q(m_axis_ppkt_tkeep[0]),
        .R(1'b0));
  FDRE \acc_keep_reg[28] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(\gen_AB_reg_slice.payload_b_reg[34] [0]),
        .Q(m_axis_ppkt_tkeep[14]),
        .R(acc_strb));
  FDRE \acc_keep_reg[2] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_keep[2]),
        .Q(m_axis_ppkt_tkeep[1]),
        .R(1'b0));
  FDRE \acc_keep_reg[30] 
       (.C(aclk),
        .CE(\acc_data[255]_i_1_n_0 ),
        .D(\gen_AB_reg_slice.payload_b_reg[34] [1]),
        .Q(m_axis_ppkt_tkeep[15]),
        .R(acc_strb));
  LUT6 #(
    .INIT(64'hAAAAAAFCAAAAAACC)) 
    acc_last_i_1
       (.I0(m_axis_ppkt_tlast),
        .I1(S_AXIS_TLAST),
        .I2(r0_last_reg_n_0),
        .I3(\FSM_onehot_state_reg_n_0_[4] ),
        .I4(\FSM_onehot_state_reg_n_0_[2] ),
        .I5(p_0_in4_in),
        .O(acc_last_i_1_n_0));
  FDRE acc_last_reg
       (.C(aclk),
        .CE(1'b1),
        .D(acc_last_i_1_n_0),
        .Q(m_axis_ppkt_tlast),
        .R(1'b0));
  FDRE \acc_user_reg[0] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[0]),
        .Q(m_axis_ppkt_tuser[0]),
        .R(1'b0));
  FDRE \acc_user_reg[10] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[10]),
        .Q(m_axis_ppkt_tuser[10]),
        .R(1'b0));
  FDRE \acc_user_reg[11] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[11]),
        .Q(m_axis_ppkt_tuser[11]),
        .R(1'b0));
  FDRE \acc_user_reg[12] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[12]),
        .Q(m_axis_ppkt_tuser[12]),
        .R(1'b0));
  FDRE \acc_user_reg[13] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[13]),
        .Q(m_axis_ppkt_tuser[13]),
        .R(1'b0));
  FDRE \acc_user_reg[14] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[14]),
        .Q(m_axis_ppkt_tuser[14]),
        .R(1'b0));
  FDRE \acc_user_reg[15] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[15]),
        .Q(m_axis_ppkt_tuser[15]),
        .R(1'b0));
  FDRE \acc_user_reg[16] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[16]),
        .Q(m_axis_ppkt_tuser[16]),
        .R(1'b0));
  FDRE \acc_user_reg[17] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[17]),
        .Q(m_axis_ppkt_tuser[17]),
        .R(1'b0));
  FDRE \acc_user_reg[18] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[18]),
        .Q(m_axis_ppkt_tuser[18]),
        .R(1'b0));
  FDRE \acc_user_reg[19] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[19]),
        .Q(m_axis_ppkt_tuser[19]),
        .R(1'b0));
  FDRE \acc_user_reg[1] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[1]),
        .Q(m_axis_ppkt_tuser[1]),
        .R(1'b0));
  FDRE \acc_user_reg[20] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[20]),
        .Q(m_axis_ppkt_tuser[20]),
        .R(1'b0));
  FDRE \acc_user_reg[21] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[21]),
        .Q(m_axis_ppkt_tuser[21]),
        .R(1'b0));
  FDRE \acc_user_reg[22] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[22]),
        .Q(m_axis_ppkt_tuser[22]),
        .R(1'b0));
  FDRE \acc_user_reg[23] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[23]),
        .Q(m_axis_ppkt_tuser[23]),
        .R(1'b0));
  FDRE \acc_user_reg[24] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[24]),
        .Q(m_axis_ppkt_tuser[24]),
        .R(1'b0));
  FDRE \acc_user_reg[25] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[25]),
        .Q(m_axis_ppkt_tuser[25]),
        .R(1'b0));
  FDRE \acc_user_reg[26] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[26]),
        .Q(m_axis_ppkt_tuser[26]),
        .R(1'b0));
  FDRE \acc_user_reg[27] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[27]),
        .Q(m_axis_ppkt_tuser[27]),
        .R(1'b0));
  FDRE \acc_user_reg[28] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[28]),
        .Q(m_axis_ppkt_tuser[28]),
        .R(1'b0));
  FDRE \acc_user_reg[29] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[29]),
        .Q(m_axis_ppkt_tuser[29]),
        .R(1'b0));
  FDRE \acc_user_reg[2] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[2]),
        .Q(m_axis_ppkt_tuser[2]),
        .R(1'b0));
  FDRE \acc_user_reg[30] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[30]),
        .Q(m_axis_ppkt_tuser[30]),
        .R(1'b0));
  FDRE \acc_user_reg[31] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[31]),
        .Q(m_axis_ppkt_tuser[31]),
        .R(1'b0));
  FDRE \acc_user_reg[32] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[32]),
        .Q(m_axis_ppkt_tuser[32]),
        .R(1'b0));
  FDRE \acc_user_reg[33] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[33]),
        .Q(m_axis_ppkt_tuser[33]),
        .R(1'b0));
  FDRE \acc_user_reg[34] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[34]),
        .Q(m_axis_ppkt_tuser[34]),
        .R(1'b0));
  FDRE \acc_user_reg[35] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[35]),
        .Q(m_axis_ppkt_tuser[35]),
        .R(1'b0));
  FDRE \acc_user_reg[36] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[36]),
        .Q(m_axis_ppkt_tuser[36]),
        .R(1'b0));
  FDRE \acc_user_reg[37] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[37]),
        .Q(m_axis_ppkt_tuser[37]),
        .R(1'b0));
  FDRE \acc_user_reg[38] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[38]),
        .Q(m_axis_ppkt_tuser[38]),
        .R(1'b0));
  FDRE \acc_user_reg[39] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[39]),
        .Q(m_axis_ppkt_tuser[39]),
        .R(1'b0));
  FDRE \acc_user_reg[3] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[3]),
        .Q(m_axis_ppkt_tuser[3]),
        .R(1'b0));
  FDRE \acc_user_reg[40] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[40]),
        .Q(m_axis_ppkt_tuser[40]),
        .R(1'b0));
  FDRE \acc_user_reg[41] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[41]),
        .Q(m_axis_ppkt_tuser[41]),
        .R(1'b0));
  FDRE \acc_user_reg[42] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[42]),
        .Q(m_axis_ppkt_tuser[42]),
        .R(1'b0));
  FDRE \acc_user_reg[43] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[43]),
        .Q(m_axis_ppkt_tuser[43]),
        .R(1'b0));
  FDRE \acc_user_reg[44] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[44]),
        .Q(m_axis_ppkt_tuser[44]),
        .R(1'b0));
  FDRE \acc_user_reg[45] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[45]),
        .Q(m_axis_ppkt_tuser[45]),
        .R(1'b0));
  FDRE \acc_user_reg[46] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[46]),
        .Q(m_axis_ppkt_tuser[46]),
        .R(1'b0));
  FDRE \acc_user_reg[47] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[47]),
        .Q(m_axis_ppkt_tuser[47]),
        .R(1'b0));
  FDRE \acc_user_reg[48] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[48]),
        .Q(m_axis_ppkt_tuser[48]),
        .R(1'b0));
  FDRE \acc_user_reg[49] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[49]),
        .Q(m_axis_ppkt_tuser[49]),
        .R(1'b0));
  FDRE \acc_user_reg[4] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[4]),
        .Q(m_axis_ppkt_tuser[4]),
        .R(1'b0));
  FDRE \acc_user_reg[50] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[50]),
        .Q(m_axis_ppkt_tuser[50]),
        .R(1'b0));
  FDRE \acc_user_reg[51] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[51]),
        .Q(m_axis_ppkt_tuser[51]),
        .R(1'b0));
  FDRE \acc_user_reg[52] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[52]),
        .Q(m_axis_ppkt_tuser[52]),
        .R(1'b0));
  FDRE \acc_user_reg[53] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[53]),
        .Q(m_axis_ppkt_tuser[53]),
        .R(1'b0));
  FDRE \acc_user_reg[54] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[54]),
        .Q(m_axis_ppkt_tuser[54]),
        .R(1'b0));
  FDRE \acc_user_reg[55] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[55]),
        .Q(m_axis_ppkt_tuser[55]),
        .R(1'b0));
  FDRE \acc_user_reg[56] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[56]),
        .Q(m_axis_ppkt_tuser[56]),
        .R(1'b0));
  FDRE \acc_user_reg[57] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[57]),
        .Q(m_axis_ppkt_tuser[57]),
        .R(1'b0));
  FDRE \acc_user_reg[58] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[58]),
        .Q(m_axis_ppkt_tuser[58]),
        .R(1'b0));
  FDRE \acc_user_reg[59] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[59]),
        .Q(m_axis_ppkt_tuser[59]),
        .R(1'b0));
  FDRE \acc_user_reg[5] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[5]),
        .Q(m_axis_ppkt_tuser[5]),
        .R(1'b0));
  FDRE \acc_user_reg[60] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[60]),
        .Q(m_axis_ppkt_tuser[60]),
        .R(1'b0));
  FDRE \acc_user_reg[61] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[61]),
        .Q(m_axis_ppkt_tuser[61]),
        .R(1'b0));
  FDRE \acc_user_reg[62] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[62]),
        .Q(m_axis_ppkt_tuser[62]),
        .R(1'b0));
  FDRE \acc_user_reg[63] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[63]),
        .Q(m_axis_ppkt_tuser[63]),
        .R(1'b0));
  FDRE \acc_user_reg[64] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[64]),
        .Q(m_axis_ppkt_tuser[64]),
        .R(1'b0));
  FDRE \acc_user_reg[65] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[65]),
        .Q(m_axis_ppkt_tuser[65]),
        .R(1'b0));
  FDRE \acc_user_reg[66] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[66]),
        .Q(m_axis_ppkt_tuser[66]),
        .R(1'b0));
  FDRE \acc_user_reg[67] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[67]),
        .Q(m_axis_ppkt_tuser[67]),
        .R(1'b0));
  FDRE \acc_user_reg[68] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[68]),
        .Q(m_axis_ppkt_tuser[68]),
        .R(1'b0));
  FDRE \acc_user_reg[69] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[69]),
        .Q(m_axis_ppkt_tuser[69]),
        .R(1'b0));
  FDRE \acc_user_reg[6] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[6]),
        .Q(m_axis_ppkt_tuser[6]),
        .R(1'b0));
  FDRE \acc_user_reg[70] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[70]),
        .Q(m_axis_ppkt_tuser[70]),
        .R(1'b0));
  FDRE \acc_user_reg[71] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[71]),
        .Q(m_axis_ppkt_tuser[71]),
        .R(1'b0));
  FDRE \acc_user_reg[72] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[72]),
        .Q(m_axis_ppkt_tuser[72]),
        .R(1'b0));
  FDRE \acc_user_reg[73] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[73]),
        .Q(m_axis_ppkt_tuser[73]),
        .R(1'b0));
  FDRE \acc_user_reg[74] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[74]),
        .Q(m_axis_ppkt_tuser[74]),
        .R(1'b0));
  FDRE \acc_user_reg[75] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[75]),
        .Q(m_axis_ppkt_tuser[75]),
        .R(1'b0));
  FDRE \acc_user_reg[76] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[76]),
        .Q(m_axis_ppkt_tuser[76]),
        .R(1'b0));
  FDRE \acc_user_reg[77] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[77]),
        .Q(m_axis_ppkt_tuser[77]),
        .R(1'b0));
  FDRE \acc_user_reg[78] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[78]),
        .Q(m_axis_ppkt_tuser[78]),
        .R(1'b0));
  FDRE \acc_user_reg[79] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[79]),
        .Q(m_axis_ppkt_tuser[79]),
        .R(1'b0));
  FDRE \acc_user_reg[7] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[7]),
        .Q(m_axis_ppkt_tuser[7]),
        .R(1'b0));
  FDRE \acc_user_reg[8] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[8]),
        .Q(m_axis_ppkt_tuser[8]),
        .R(1'b0));
  FDRE \acc_user_reg[9] 
       (.C(aclk),
        .CE(acc_reg_en[0]),
        .D(r0_user[9]),
        .Q(m_axis_ppkt_tuser[9]),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h8)) 
    \gen_data_accumulator[1].acc_data[63]_i_1 
       (.I0(p_0_in4_in),
        .I1(\r0_reg_sel_reg_n_0_[1] ),
        .O(acc_reg_en[1]));
  FDRE \gen_data_accumulator[1].acc_data_reg[32] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[0]),
        .Q(m_axis_ppkt_tdata[32]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[33] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[1]),
        .Q(m_axis_ppkt_tdata[33]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[34] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[2]),
        .Q(m_axis_ppkt_tdata[34]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[35] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[3]),
        .Q(m_axis_ppkt_tdata[35]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[36] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[4]),
        .Q(m_axis_ppkt_tdata[36]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[37] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[5]),
        .Q(m_axis_ppkt_tdata[37]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[38] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[6]),
        .Q(m_axis_ppkt_tdata[38]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[39] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[7]),
        .Q(m_axis_ppkt_tdata[39]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[40] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[8]),
        .Q(m_axis_ppkt_tdata[40]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[41] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[9]),
        .Q(m_axis_ppkt_tdata[41]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[42] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[10]),
        .Q(m_axis_ppkt_tdata[42]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[43] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[11]),
        .Q(m_axis_ppkt_tdata[43]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[44] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[12]),
        .Q(m_axis_ppkt_tdata[44]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[45] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[13]),
        .Q(m_axis_ppkt_tdata[45]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[46] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[14]),
        .Q(m_axis_ppkt_tdata[46]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[47] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[15]),
        .Q(m_axis_ppkt_tdata[47]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[48] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[16]),
        .Q(m_axis_ppkt_tdata[48]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[49] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[17]),
        .Q(m_axis_ppkt_tdata[49]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[50] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[18]),
        .Q(m_axis_ppkt_tdata[50]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[51] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[19]),
        .Q(m_axis_ppkt_tdata[51]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[52] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[20]),
        .Q(m_axis_ppkt_tdata[52]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[53] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[21]),
        .Q(m_axis_ppkt_tdata[53]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[54] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[22]),
        .Q(m_axis_ppkt_tdata[54]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[55] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[23]),
        .Q(m_axis_ppkt_tdata[55]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[56] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[24]),
        .Q(m_axis_ppkt_tdata[56]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[57] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[25]),
        .Q(m_axis_ppkt_tdata[57]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[58] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[26]),
        .Q(m_axis_ppkt_tdata[58]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[59] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[27]),
        .Q(m_axis_ppkt_tdata[59]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[60] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[28]),
        .Q(m_axis_ppkt_tdata[60]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[61] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[29]),
        .Q(m_axis_ppkt_tdata[61]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[62] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[30]),
        .Q(m_axis_ppkt_tdata[62]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_data_reg[63] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_data[31]),
        .Q(m_axis_ppkt_tdata[63]),
        .R(1'b0));
  FDRE \gen_data_accumulator[1].acc_keep_reg[4] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_keep[0]),
        .Q(m_axis_ppkt_tkeep[2]),
        .R(acc_reg_en[0]));
  FDRE \gen_data_accumulator[1].acc_keep_reg[6] 
       (.C(aclk),
        .CE(acc_reg_en[1]),
        .D(r0_keep[2]),
        .Q(m_axis_ppkt_tkeep[3]),
        .R(acc_reg_en[0]));
  LUT2 #(
    .INIT(4'h8)) 
    \gen_data_accumulator[2].acc_data[95]_i_1 
       (.I0(p_0_in4_in),
        .I1(\r0_reg_sel_reg_n_0_[2] ),
        .O(acc_reg_en[2]));
  FDRE \gen_data_accumulator[2].acc_data_reg[64] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[0]),
        .Q(m_axis_ppkt_tdata[64]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[65] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[1]),
        .Q(m_axis_ppkt_tdata[65]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[66] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[2]),
        .Q(m_axis_ppkt_tdata[66]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[67] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[3]),
        .Q(m_axis_ppkt_tdata[67]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[68] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[4]),
        .Q(m_axis_ppkt_tdata[68]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[69] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[5]),
        .Q(m_axis_ppkt_tdata[69]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[70] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[6]),
        .Q(m_axis_ppkt_tdata[70]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[71] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[7]),
        .Q(m_axis_ppkt_tdata[71]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[72] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[8]),
        .Q(m_axis_ppkt_tdata[72]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[73] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[9]),
        .Q(m_axis_ppkt_tdata[73]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[74] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[10]),
        .Q(m_axis_ppkt_tdata[74]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[75] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[11]),
        .Q(m_axis_ppkt_tdata[75]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[76] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[12]),
        .Q(m_axis_ppkt_tdata[76]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[77] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[13]),
        .Q(m_axis_ppkt_tdata[77]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[78] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[14]),
        .Q(m_axis_ppkt_tdata[78]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[79] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[15]),
        .Q(m_axis_ppkt_tdata[79]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[80] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[16]),
        .Q(m_axis_ppkt_tdata[80]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[81] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[17]),
        .Q(m_axis_ppkt_tdata[81]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[82] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[18]),
        .Q(m_axis_ppkt_tdata[82]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[83] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[19]),
        .Q(m_axis_ppkt_tdata[83]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[84] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[20]),
        .Q(m_axis_ppkt_tdata[84]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[85] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[21]),
        .Q(m_axis_ppkt_tdata[85]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[86] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[22]),
        .Q(m_axis_ppkt_tdata[86]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[87] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[23]),
        .Q(m_axis_ppkt_tdata[87]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[88] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[24]),
        .Q(m_axis_ppkt_tdata[88]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[89] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[25]),
        .Q(m_axis_ppkt_tdata[89]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[90] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[26]),
        .Q(m_axis_ppkt_tdata[90]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[91] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[27]),
        .Q(m_axis_ppkt_tdata[91]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[92] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[28]),
        .Q(m_axis_ppkt_tdata[92]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[93] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[29]),
        .Q(m_axis_ppkt_tdata[93]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[94] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[30]),
        .Q(m_axis_ppkt_tdata[94]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_data_reg[95] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_data[31]),
        .Q(m_axis_ppkt_tdata[95]),
        .R(1'b0));
  FDRE \gen_data_accumulator[2].acc_keep_reg[10] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_keep[2]),
        .Q(m_axis_ppkt_tkeep[5]),
        .R(acc_reg_en[0]));
  FDRE \gen_data_accumulator[2].acc_keep_reg[8] 
       (.C(aclk),
        .CE(acc_reg_en[2]),
        .D(r0_keep[0]),
        .Q(m_axis_ppkt_tkeep[4]),
        .R(acc_reg_en[0]));
  LUT2 #(
    .INIT(4'h8)) 
    \gen_data_accumulator[3].acc_data[127]_i_1 
       (.I0(p_0_in4_in),
        .I1(\r0_reg_sel_reg_n_0_[3] ),
        .O(acc_reg_en[3]));
  FDRE \gen_data_accumulator[3].acc_data_reg[100] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[4]),
        .Q(m_axis_ppkt_tdata[100]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[101] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[5]),
        .Q(m_axis_ppkt_tdata[101]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[102] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[6]),
        .Q(m_axis_ppkt_tdata[102]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[103] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[7]),
        .Q(m_axis_ppkt_tdata[103]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[104] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[8]),
        .Q(m_axis_ppkt_tdata[104]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[105] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[9]),
        .Q(m_axis_ppkt_tdata[105]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[106] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[10]),
        .Q(m_axis_ppkt_tdata[106]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[107] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[11]),
        .Q(m_axis_ppkt_tdata[107]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[108] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[12]),
        .Q(m_axis_ppkt_tdata[108]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[109] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[13]),
        .Q(m_axis_ppkt_tdata[109]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[110] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[14]),
        .Q(m_axis_ppkt_tdata[110]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[111] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[15]),
        .Q(m_axis_ppkt_tdata[111]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[112] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[16]),
        .Q(m_axis_ppkt_tdata[112]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[113] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[17]),
        .Q(m_axis_ppkt_tdata[113]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[114] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[18]),
        .Q(m_axis_ppkt_tdata[114]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[115] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[19]),
        .Q(m_axis_ppkt_tdata[115]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[116] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[20]),
        .Q(m_axis_ppkt_tdata[116]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[117] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[21]),
        .Q(m_axis_ppkt_tdata[117]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[118] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[22]),
        .Q(m_axis_ppkt_tdata[118]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[119] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[23]),
        .Q(m_axis_ppkt_tdata[119]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[120] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[24]),
        .Q(m_axis_ppkt_tdata[120]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[121] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[25]),
        .Q(m_axis_ppkt_tdata[121]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[122] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[26]),
        .Q(m_axis_ppkt_tdata[122]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[123] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[27]),
        .Q(m_axis_ppkt_tdata[123]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[124] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[28]),
        .Q(m_axis_ppkt_tdata[124]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[125] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[29]),
        .Q(m_axis_ppkt_tdata[125]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[126] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[30]),
        .Q(m_axis_ppkt_tdata[126]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[127] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[31]),
        .Q(m_axis_ppkt_tdata[127]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[96] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[0]),
        .Q(m_axis_ppkt_tdata[96]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[97] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[1]),
        .Q(m_axis_ppkt_tdata[97]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[98] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[2]),
        .Q(m_axis_ppkt_tdata[98]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_data_reg[99] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_data[3]),
        .Q(m_axis_ppkt_tdata[99]),
        .R(1'b0));
  FDRE \gen_data_accumulator[3].acc_keep_reg[12] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_keep[0]),
        .Q(m_axis_ppkt_tkeep[6]),
        .R(acc_reg_en[0]));
  FDRE \gen_data_accumulator[3].acc_keep_reg[14] 
       (.C(aclk),
        .CE(acc_reg_en[3]),
        .D(r0_keep[2]),
        .Q(m_axis_ppkt_tkeep[7]),
        .R(acc_reg_en[0]));
  LUT2 #(
    .INIT(4'h8)) 
    \gen_data_accumulator[4].acc_data[159]_i_1 
       (.I0(p_0_in4_in),
        .I1(\r0_reg_sel_reg_n_0_[4] ),
        .O(acc_reg_en[4]));
  FDRE \gen_data_accumulator[4].acc_data_reg[128] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[0]),
        .Q(m_axis_ppkt_tdata[128]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[129] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[1]),
        .Q(m_axis_ppkt_tdata[129]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[130] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[2]),
        .Q(m_axis_ppkt_tdata[130]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[131] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[3]),
        .Q(m_axis_ppkt_tdata[131]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[132] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[4]),
        .Q(m_axis_ppkt_tdata[132]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[133] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[5]),
        .Q(m_axis_ppkt_tdata[133]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[134] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[6]),
        .Q(m_axis_ppkt_tdata[134]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[135] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[7]),
        .Q(m_axis_ppkt_tdata[135]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[136] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[8]),
        .Q(m_axis_ppkt_tdata[136]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[137] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[9]),
        .Q(m_axis_ppkt_tdata[137]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[138] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[10]),
        .Q(m_axis_ppkt_tdata[138]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[139] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[11]),
        .Q(m_axis_ppkt_tdata[139]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[140] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[12]),
        .Q(m_axis_ppkt_tdata[140]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[141] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[13]),
        .Q(m_axis_ppkt_tdata[141]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[142] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[14]),
        .Q(m_axis_ppkt_tdata[142]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[143] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[15]),
        .Q(m_axis_ppkt_tdata[143]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[144] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[16]),
        .Q(m_axis_ppkt_tdata[144]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[145] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[17]),
        .Q(m_axis_ppkt_tdata[145]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[146] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[18]),
        .Q(m_axis_ppkt_tdata[146]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[147] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[19]),
        .Q(m_axis_ppkt_tdata[147]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[148] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[20]),
        .Q(m_axis_ppkt_tdata[148]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[149] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[21]),
        .Q(m_axis_ppkt_tdata[149]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[150] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[22]),
        .Q(m_axis_ppkt_tdata[150]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[151] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[23]),
        .Q(m_axis_ppkt_tdata[151]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[152] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[24]),
        .Q(m_axis_ppkt_tdata[152]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[153] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[25]),
        .Q(m_axis_ppkt_tdata[153]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[154] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[26]),
        .Q(m_axis_ppkt_tdata[154]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[155] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[27]),
        .Q(m_axis_ppkt_tdata[155]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[156] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[28]),
        .Q(m_axis_ppkt_tdata[156]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[157] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[29]),
        .Q(m_axis_ppkt_tdata[157]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[158] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[30]),
        .Q(m_axis_ppkt_tdata[158]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_data_reg[159] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_data[31]),
        .Q(m_axis_ppkt_tdata[159]),
        .R(1'b0));
  FDRE \gen_data_accumulator[4].acc_keep_reg[16] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_keep[0]),
        .Q(m_axis_ppkt_tkeep[8]),
        .R(acc_reg_en[0]));
  FDRE \gen_data_accumulator[4].acc_keep_reg[18] 
       (.C(aclk),
        .CE(acc_reg_en[4]),
        .D(r0_keep[2]),
        .Q(m_axis_ppkt_tkeep[9]),
        .R(acc_reg_en[0]));
  LUT2 #(
    .INIT(4'h8)) 
    \gen_data_accumulator[5].acc_data[191]_i_1 
       (.I0(p_0_in4_in),
        .I1(\r0_reg_sel_reg_n_0_[5] ),
        .O(acc_reg_en[5]));
  FDRE \gen_data_accumulator[5].acc_data_reg[160] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[0]),
        .Q(m_axis_ppkt_tdata[160]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[161] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[1]),
        .Q(m_axis_ppkt_tdata[161]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[162] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[2]),
        .Q(m_axis_ppkt_tdata[162]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[163] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[3]),
        .Q(m_axis_ppkt_tdata[163]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[164] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[4]),
        .Q(m_axis_ppkt_tdata[164]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[165] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[5]),
        .Q(m_axis_ppkt_tdata[165]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[166] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[6]),
        .Q(m_axis_ppkt_tdata[166]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[167] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[7]),
        .Q(m_axis_ppkt_tdata[167]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[168] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[8]),
        .Q(m_axis_ppkt_tdata[168]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[169] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[9]),
        .Q(m_axis_ppkt_tdata[169]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[170] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[10]),
        .Q(m_axis_ppkt_tdata[170]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[171] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[11]),
        .Q(m_axis_ppkt_tdata[171]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[172] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[12]),
        .Q(m_axis_ppkt_tdata[172]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[173] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[13]),
        .Q(m_axis_ppkt_tdata[173]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[174] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[14]),
        .Q(m_axis_ppkt_tdata[174]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[175] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[15]),
        .Q(m_axis_ppkt_tdata[175]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[176] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[16]),
        .Q(m_axis_ppkt_tdata[176]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[177] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[17]),
        .Q(m_axis_ppkt_tdata[177]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[178] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[18]),
        .Q(m_axis_ppkt_tdata[178]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[179] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[19]),
        .Q(m_axis_ppkt_tdata[179]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[180] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[20]),
        .Q(m_axis_ppkt_tdata[180]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[181] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[21]),
        .Q(m_axis_ppkt_tdata[181]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[182] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[22]),
        .Q(m_axis_ppkt_tdata[182]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[183] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[23]),
        .Q(m_axis_ppkt_tdata[183]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[184] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[24]),
        .Q(m_axis_ppkt_tdata[184]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[185] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[25]),
        .Q(m_axis_ppkt_tdata[185]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[186] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[26]),
        .Q(m_axis_ppkt_tdata[186]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[187] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[27]),
        .Q(m_axis_ppkt_tdata[187]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[188] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[28]),
        .Q(m_axis_ppkt_tdata[188]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[189] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[29]),
        .Q(m_axis_ppkt_tdata[189]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[190] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[30]),
        .Q(m_axis_ppkt_tdata[190]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_data_reg[191] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_data[31]),
        .Q(m_axis_ppkt_tdata[191]),
        .R(1'b0));
  FDRE \gen_data_accumulator[5].acc_keep_reg[20] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_keep[0]),
        .Q(m_axis_ppkt_tkeep[10]),
        .R(acc_reg_en[0]));
  FDRE \gen_data_accumulator[5].acc_keep_reg[22] 
       (.C(aclk),
        .CE(acc_reg_en[5]),
        .D(r0_keep[2]),
        .Q(m_axis_ppkt_tkeep[11]),
        .R(acc_reg_en[0]));
  LUT2 #(
    .INIT(4'h8)) 
    \gen_data_accumulator[6].acc_data[223]_i_1 
       (.I0(p_0_in4_in),
        .I1(\r0_reg_sel_reg_n_0_[6] ),
        .O(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ));
  FDRE \gen_data_accumulator[6].acc_data_reg[192] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[0]),
        .Q(m_axis_ppkt_tdata[192]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[193] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[1]),
        .Q(m_axis_ppkt_tdata[193]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[194] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[2]),
        .Q(m_axis_ppkt_tdata[194]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[195] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[3]),
        .Q(m_axis_ppkt_tdata[195]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[196] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[4]),
        .Q(m_axis_ppkt_tdata[196]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[197] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[5]),
        .Q(m_axis_ppkt_tdata[197]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[198] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[6]),
        .Q(m_axis_ppkt_tdata[198]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[199] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[7]),
        .Q(m_axis_ppkt_tdata[199]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[200] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[8]),
        .Q(m_axis_ppkt_tdata[200]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[201] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[9]),
        .Q(m_axis_ppkt_tdata[201]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[202] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[10]),
        .Q(m_axis_ppkt_tdata[202]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[203] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[11]),
        .Q(m_axis_ppkt_tdata[203]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[204] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[12]),
        .Q(m_axis_ppkt_tdata[204]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[205] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[13]),
        .Q(m_axis_ppkt_tdata[205]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[206] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[14]),
        .Q(m_axis_ppkt_tdata[206]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[207] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[15]),
        .Q(m_axis_ppkt_tdata[207]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[208] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[16]),
        .Q(m_axis_ppkt_tdata[208]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[209] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[17]),
        .Q(m_axis_ppkt_tdata[209]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[210] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[18]),
        .Q(m_axis_ppkt_tdata[210]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[211] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[19]),
        .Q(m_axis_ppkt_tdata[211]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[212] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[20]),
        .Q(m_axis_ppkt_tdata[212]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[213] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[21]),
        .Q(m_axis_ppkt_tdata[213]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[214] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[22]),
        .Q(m_axis_ppkt_tdata[214]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[215] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[23]),
        .Q(m_axis_ppkt_tdata[215]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[216] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[24]),
        .Q(m_axis_ppkt_tdata[216]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[217] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[25]),
        .Q(m_axis_ppkt_tdata[217]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[218] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[26]),
        .Q(m_axis_ppkt_tdata[218]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[219] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[27]),
        .Q(m_axis_ppkt_tdata[219]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[220] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[28]),
        .Q(m_axis_ppkt_tdata[220]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[221] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[29]),
        .Q(m_axis_ppkt_tdata[221]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[222] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[30]),
        .Q(m_axis_ppkt_tdata[222]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_data_reg[223] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_data[31]),
        .Q(m_axis_ppkt_tdata[223]),
        .R(1'b0));
  FDRE \gen_data_accumulator[6].acc_keep_reg[24] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_keep[0]),
        .Q(m_axis_ppkt_tkeep[12]),
        .R(acc_reg_en[0]));
  FDRE \gen_data_accumulator[6].acc_keep_reg[26] 
       (.C(aclk),
        .CE(\gen_data_accumulator[6].acc_data[223]_i_1_n_0 ),
        .D(r0_keep[2]),
        .Q(m_axis_ppkt_tkeep[13]),
        .R(acc_reg_en[0]));
  FDRE \r0_data_reg[0] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[0]),
        .Q(r0_data[0]),
        .R(1'b0));
  FDRE \r0_data_reg[10] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[10]),
        .Q(r0_data[10]),
        .R(1'b0));
  FDRE \r0_data_reg[11] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[11]),
        .Q(r0_data[11]),
        .R(1'b0));
  FDRE \r0_data_reg[12] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[12]),
        .Q(r0_data[12]),
        .R(1'b0));
  FDRE \r0_data_reg[13] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[13]),
        .Q(r0_data[13]),
        .R(1'b0));
  FDRE \r0_data_reg[14] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[14]),
        .Q(r0_data[14]),
        .R(1'b0));
  FDRE \r0_data_reg[15] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[15]),
        .Q(r0_data[15]),
        .R(1'b0));
  FDRE \r0_data_reg[16] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[16]),
        .Q(r0_data[16]),
        .R(1'b0));
  FDRE \r0_data_reg[17] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[17]),
        .Q(r0_data[17]),
        .R(1'b0));
  FDRE \r0_data_reg[18] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[18]),
        .Q(r0_data[18]),
        .R(1'b0));
  FDRE \r0_data_reg[19] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[19]),
        .Q(r0_data[19]),
        .R(1'b0));
  FDRE \r0_data_reg[1] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[1]),
        .Q(r0_data[1]),
        .R(1'b0));
  FDRE \r0_data_reg[20] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[20]),
        .Q(r0_data[20]),
        .R(1'b0));
  FDRE \r0_data_reg[21] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[21]),
        .Q(r0_data[21]),
        .R(1'b0));
  FDRE \r0_data_reg[22] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[22]),
        .Q(r0_data[22]),
        .R(1'b0));
  FDRE \r0_data_reg[23] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[23]),
        .Q(r0_data[23]),
        .R(1'b0));
  FDRE \r0_data_reg[24] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[24]),
        .Q(r0_data[24]),
        .R(1'b0));
  FDRE \r0_data_reg[25] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[25]),
        .Q(r0_data[25]),
        .R(1'b0));
  FDRE \r0_data_reg[26] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[26]),
        .Q(r0_data[26]),
        .R(1'b0));
  FDRE \r0_data_reg[27] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[27]),
        .Q(r0_data[27]),
        .R(1'b0));
  FDRE \r0_data_reg[28] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[28]),
        .Q(r0_data[28]),
        .R(1'b0));
  FDRE \r0_data_reg[29] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[29]),
        .Q(r0_data[29]),
        .R(1'b0));
  FDRE \r0_data_reg[2] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[2]),
        .Q(r0_data[2]),
        .R(1'b0));
  FDRE \r0_data_reg[30] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[30]),
        .Q(r0_data[30]),
        .R(1'b0));
  FDRE \r0_data_reg[31] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[31]),
        .Q(r0_data[31]),
        .R(1'b0));
  FDRE \r0_data_reg[3] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[3]),
        .Q(r0_data[3]),
        .R(1'b0));
  FDRE \r0_data_reg[4] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[4]),
        .Q(r0_data[4]),
        .R(1'b0));
  FDRE \r0_data_reg[5] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[5]),
        .Q(r0_data[5]),
        .R(1'b0));
  FDRE \r0_data_reg[6] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[6]),
        .Q(r0_data[6]),
        .R(1'b0));
  FDRE \r0_data_reg[7] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[7]),
        .Q(r0_data[7]),
        .R(1'b0));
  FDRE \r0_data_reg[8] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[8]),
        .Q(r0_data[8]),
        .R(1'b0));
  FDRE \r0_data_reg[9] 
       (.C(aclk),
        .CE(Q[0]),
        .D(D[9]),
        .Q(r0_data[9]),
        .R(1'b0));
  FDRE \r0_keep_reg[0] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[34] [0]),
        .Q(r0_keep[0]),
        .R(1'b0));
  FDRE \r0_keep_reg[2] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[34] [1]),
        .Q(r0_keep[2]),
        .R(1'b0));
  FDRE r0_last_reg
       (.C(aclk),
        .CE(Q[0]),
        .D(S_AXIS_TLAST),
        .Q(r0_last_reg_n_0),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hF8)) 
    \r0_reg_sel[7]_i_1 
       (.I0(Q[1]),
        .I1(m_axis_ppkt_tready),
        .I2(areset_r),
        .O(p_1_in));
  FDSE \r0_reg_sel_reg[0] 
       (.C(aclk),
        .CE(p_0_in4_in),
        .D(1'b0),
        .Q(\r0_reg_sel_reg_n_0_[0] ),
        .S(p_1_in));
  FDRE \r0_reg_sel_reg[1] 
       (.C(aclk),
        .CE(p_0_in4_in),
        .D(\r0_reg_sel_reg_n_0_[0] ),
        .Q(\r0_reg_sel_reg_n_0_[1] ),
        .R(p_1_in));
  FDRE \r0_reg_sel_reg[2] 
       (.C(aclk),
        .CE(p_0_in4_in),
        .D(\r0_reg_sel_reg_n_0_[1] ),
        .Q(\r0_reg_sel_reg_n_0_[2] ),
        .R(p_1_in));
  FDRE \r0_reg_sel_reg[3] 
       (.C(aclk),
        .CE(p_0_in4_in),
        .D(\r0_reg_sel_reg_n_0_[2] ),
        .Q(\r0_reg_sel_reg_n_0_[3] ),
        .R(p_1_in));
  FDRE \r0_reg_sel_reg[4] 
       (.C(aclk),
        .CE(p_0_in4_in),
        .D(\r0_reg_sel_reg_n_0_[3] ),
        .Q(\r0_reg_sel_reg_n_0_[4] ),
        .R(p_1_in));
  FDRE \r0_reg_sel_reg[5] 
       (.C(aclk),
        .CE(p_0_in4_in),
        .D(\r0_reg_sel_reg_n_0_[4] ),
        .Q(\r0_reg_sel_reg_n_0_[5] ),
        .R(p_1_in));
  FDRE \r0_reg_sel_reg[6] 
       (.C(aclk),
        .CE(p_0_in4_in),
        .D(\r0_reg_sel_reg_n_0_[5] ),
        .Q(\r0_reg_sel_reg_n_0_[6] ),
        .R(p_1_in));
  FDRE \r0_reg_sel_reg[7] 
       (.C(aclk),
        .CE(p_0_in4_in),
        .D(\r0_reg_sel_reg_n_0_[6] ),
        .Q(p_1_in2_in),
        .R(p_1_in));
  FDRE \r0_user_reg[0] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [0]),
        .Q(r0_user[0]),
        .R(1'b0));
  FDRE \r0_user_reg[10] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [10]),
        .Q(r0_user[10]),
        .R(1'b0));
  FDRE \r0_user_reg[11] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [11]),
        .Q(r0_user[11]),
        .R(1'b0));
  FDRE \r0_user_reg[12] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [12]),
        .Q(r0_user[12]),
        .R(1'b0));
  FDRE \r0_user_reg[13] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [13]),
        .Q(r0_user[13]),
        .R(1'b0));
  FDRE \r0_user_reg[14] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [14]),
        .Q(r0_user[14]),
        .R(1'b0));
  FDRE \r0_user_reg[15] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [15]),
        .Q(r0_user[15]),
        .R(1'b0));
  FDRE \r0_user_reg[16] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [16]),
        .Q(r0_user[16]),
        .R(1'b0));
  FDRE \r0_user_reg[17] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [17]),
        .Q(r0_user[17]),
        .R(1'b0));
  FDRE \r0_user_reg[18] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [18]),
        .Q(r0_user[18]),
        .R(1'b0));
  FDRE \r0_user_reg[19] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [19]),
        .Q(r0_user[19]),
        .R(1'b0));
  FDRE \r0_user_reg[1] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [1]),
        .Q(r0_user[1]),
        .R(1'b0));
  FDRE \r0_user_reg[20] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [20]),
        .Q(r0_user[20]),
        .R(1'b0));
  FDRE \r0_user_reg[21] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [21]),
        .Q(r0_user[21]),
        .R(1'b0));
  FDRE \r0_user_reg[22] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [22]),
        .Q(r0_user[22]),
        .R(1'b0));
  FDRE \r0_user_reg[23] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [23]),
        .Q(r0_user[23]),
        .R(1'b0));
  FDRE \r0_user_reg[24] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [24]),
        .Q(r0_user[24]),
        .R(1'b0));
  FDRE \r0_user_reg[25] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [25]),
        .Q(r0_user[25]),
        .R(1'b0));
  FDRE \r0_user_reg[26] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [26]),
        .Q(r0_user[26]),
        .R(1'b0));
  FDRE \r0_user_reg[27] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [27]),
        .Q(r0_user[27]),
        .R(1'b0));
  FDRE \r0_user_reg[28] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [28]),
        .Q(r0_user[28]),
        .R(1'b0));
  FDRE \r0_user_reg[29] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [29]),
        .Q(r0_user[29]),
        .R(1'b0));
  FDRE \r0_user_reg[2] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [2]),
        .Q(r0_user[2]),
        .R(1'b0));
  FDRE \r0_user_reg[30] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [30]),
        .Q(r0_user[30]),
        .R(1'b0));
  FDRE \r0_user_reg[31] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [31]),
        .Q(r0_user[31]),
        .R(1'b0));
  FDRE \r0_user_reg[32] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [32]),
        .Q(r0_user[32]),
        .R(1'b0));
  FDRE \r0_user_reg[33] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [33]),
        .Q(r0_user[33]),
        .R(1'b0));
  FDRE \r0_user_reg[34] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [34]),
        .Q(r0_user[34]),
        .R(1'b0));
  FDRE \r0_user_reg[35] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [35]),
        .Q(r0_user[35]),
        .R(1'b0));
  FDRE \r0_user_reg[36] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [36]),
        .Q(r0_user[36]),
        .R(1'b0));
  FDRE \r0_user_reg[37] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [37]),
        .Q(r0_user[37]),
        .R(1'b0));
  FDRE \r0_user_reg[38] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [38]),
        .Q(r0_user[38]),
        .R(1'b0));
  FDRE \r0_user_reg[39] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [39]),
        .Q(r0_user[39]),
        .R(1'b0));
  FDRE \r0_user_reg[3] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [3]),
        .Q(r0_user[3]),
        .R(1'b0));
  FDRE \r0_user_reg[40] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [40]),
        .Q(r0_user[40]),
        .R(1'b0));
  FDRE \r0_user_reg[41] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [41]),
        .Q(r0_user[41]),
        .R(1'b0));
  FDRE \r0_user_reg[42] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [42]),
        .Q(r0_user[42]),
        .R(1'b0));
  FDRE \r0_user_reg[43] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [43]),
        .Q(r0_user[43]),
        .R(1'b0));
  FDRE \r0_user_reg[44] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [44]),
        .Q(r0_user[44]),
        .R(1'b0));
  FDRE \r0_user_reg[45] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [45]),
        .Q(r0_user[45]),
        .R(1'b0));
  FDRE \r0_user_reg[46] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [46]),
        .Q(r0_user[46]),
        .R(1'b0));
  FDRE \r0_user_reg[47] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [47]),
        .Q(r0_user[47]),
        .R(1'b0));
  FDRE \r0_user_reg[48] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [48]),
        .Q(r0_user[48]),
        .R(1'b0));
  FDRE \r0_user_reg[49] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [49]),
        .Q(r0_user[49]),
        .R(1'b0));
  FDRE \r0_user_reg[4] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [4]),
        .Q(r0_user[4]),
        .R(1'b0));
  FDRE \r0_user_reg[50] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [50]),
        .Q(r0_user[50]),
        .R(1'b0));
  FDRE \r0_user_reg[51] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [51]),
        .Q(r0_user[51]),
        .R(1'b0));
  FDRE \r0_user_reg[52] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [52]),
        .Q(r0_user[52]),
        .R(1'b0));
  FDRE \r0_user_reg[53] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [53]),
        .Q(r0_user[53]),
        .R(1'b0));
  FDRE \r0_user_reg[54] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [54]),
        .Q(r0_user[54]),
        .R(1'b0));
  FDRE \r0_user_reg[55] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [55]),
        .Q(r0_user[55]),
        .R(1'b0));
  FDRE \r0_user_reg[56] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [56]),
        .Q(r0_user[56]),
        .R(1'b0));
  FDRE \r0_user_reg[57] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [57]),
        .Q(r0_user[57]),
        .R(1'b0));
  FDRE \r0_user_reg[58] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [58]),
        .Q(r0_user[58]),
        .R(1'b0));
  FDRE \r0_user_reg[59] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [59]),
        .Q(r0_user[59]),
        .R(1'b0));
  FDRE \r0_user_reg[5] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [5]),
        .Q(r0_user[5]),
        .R(1'b0));
  FDRE \r0_user_reg[60] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [60]),
        .Q(r0_user[60]),
        .R(1'b0));
  FDRE \r0_user_reg[61] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [61]),
        .Q(r0_user[61]),
        .R(1'b0));
  FDRE \r0_user_reg[62] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [62]),
        .Q(r0_user[62]),
        .R(1'b0));
  FDRE \r0_user_reg[63] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [63]),
        .Q(r0_user[63]),
        .R(1'b0));
  FDRE \r0_user_reg[64] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [64]),
        .Q(r0_user[64]),
        .R(1'b0));
  FDRE \r0_user_reg[65] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [65]),
        .Q(r0_user[65]),
        .R(1'b0));
  FDRE \r0_user_reg[66] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [66]),
        .Q(r0_user[66]),
        .R(1'b0));
  FDRE \r0_user_reg[67] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [67]),
        .Q(r0_user[67]),
        .R(1'b0));
  FDRE \r0_user_reg[68] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [68]),
        .Q(r0_user[68]),
        .R(1'b0));
  FDRE \r0_user_reg[69] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [69]),
        .Q(r0_user[69]),
        .R(1'b0));
  FDRE \r0_user_reg[6] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [6]),
        .Q(r0_user[6]),
        .R(1'b0));
  FDRE \r0_user_reg[70] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [70]),
        .Q(r0_user[70]),
        .R(1'b0));
  FDRE \r0_user_reg[71] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [71]),
        .Q(r0_user[71]),
        .R(1'b0));
  FDRE \r0_user_reg[72] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [72]),
        .Q(r0_user[72]),
        .R(1'b0));
  FDRE \r0_user_reg[73] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [73]),
        .Q(r0_user[73]),
        .R(1'b0));
  FDRE \r0_user_reg[74] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [74]),
        .Q(r0_user[74]),
        .R(1'b0));
  FDRE \r0_user_reg[75] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [75]),
        .Q(r0_user[75]),
        .R(1'b0));
  FDRE \r0_user_reg[76] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [76]),
        .Q(r0_user[76]),
        .R(1'b0));
  FDRE \r0_user_reg[77] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [77]),
        .Q(r0_user[77]),
        .R(1'b0));
  FDRE \r0_user_reg[78] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [78]),
        .Q(r0_user[78]),
        .R(1'b0));
  FDRE \r0_user_reg[79] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [79]),
        .Q(r0_user[79]),
        .R(1'b0));
  FDRE \r0_user_reg[7] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [7]),
        .Q(r0_user[7]),
        .R(1'b0));
  FDRE \r0_user_reg[8] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [8]),
        .Q(r0_user[8]),
        .R(1'b0));
  FDRE \r0_user_reg[9] 
       (.C(aclk),
        .CE(Q[0]),
        .D(\gen_AB_reg_slice.payload_b_reg[116] [9]),
        .Q(r0_user[9]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFCFCFFFC77FFFFFF)) 
    \state[0]_i_1 
       (.I0(r0_last_reg_n_0),
        .I1(\state_reg_n_0_[2] ),
        .I2(m_axis_ppkt_tready),
        .I3(Q[0]),
        .I4(\gen_AB_reg_slice.state_reg[0] ),
        .I5(Q[1]),
        .O(state[0]));
  LUT6 #(
    .INIT(64'h000FBFBF000F8080)) 
    \state[1]_i_1 
       (.I0(Q[0]),
        .I1(r0_last_reg_n_0),
        .I2(\state_reg_n_0_[2] ),
        .I3(m_axis_ppkt_tready),
        .I4(Q[1]),
        .I5(\state[1]_i_2_n_0 ),
        .O(state[1]));
  LUT5 #(
    .INIT(32'hAA800000)) 
    \state[1]_i_2 
       (.I0(Q[0]),
        .I1(\r0_reg_sel_reg_n_0_[6] ),
        .I2(p_0_in4_in),
        .I3(p_1_in2_in),
        .I4(\gen_AB_reg_slice.state_reg[0] ),
        .O(\state[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0300777703000000)) 
    \state[2]_i_1 
       (.I0(r0_last_reg_n_0),
        .I1(\state_reg_n_0_[2] ),
        .I2(\state[2]_i_2_n_0 ),
        .I3(m_axis_ppkt_tready),
        .I4(Q[1]),
        .I5(\state[2]_i_3_n_0 ),
        .O(state[2]));
  LUT2 #(
    .INIT(4'h2)) 
    \state[2]_i_2 
       (.I0(Q[0]),
        .I1(\gen_AB_reg_slice.state_reg[0] ),
        .O(\state[2]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h002A0000)) 
    \state[2]_i_3 
       (.I0(Q[0]),
        .I1(p_0_in4_in),
        .I2(\r0_reg_sel_reg_n_0_[6] ),
        .I3(p_1_in2_in),
        .I4(\gen_AB_reg_slice.state_reg[0] ),
        .O(\state[2]_i_3_n_0 ));
  FDRE \state_reg[0] 
       (.C(aclk),
        .CE(1'b1),
        .D(state[0]),
        .Q(Q[0]),
        .R(areset_r));
  FDRE \state_reg[1] 
       (.C(aclk),
        .CE(1'b1),
        .D(state[1]),
        .Q(Q[1]),
        .R(areset_r));
  FDRE \state_reg[2] 
       (.C(aclk),
        .CE(1'b1),
        .D(state[2]),
        .Q(\state_reg_n_0_[2] ),
        .R(areset_r));
endmodule

(* ORIG_REF_NAME = "px_axis_dwidth_upconv" *) 
module px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_upconv
   (m_axis_ppkt_tlast,
    Q,
    m_axis_ppkt_tvalid,
    m_axis_ppkt_tdata,
    m_axis_ppkt_tkeep,
    m_axis_ppkt_tuser,
    aclk,
    t1_aresetn_reg,
    s_axis_ppkt_tvalid,
    D,
    m_axis_ppkt_tready);
  output m_axis_ppkt_tlast;
  output [0:0]Q;
  output [0:0]m_axis_ppkt_tvalid;
  output [255:0]m_axis_ppkt_tdata;
  output [15:0]m_axis_ppkt_tkeep;
  output [79:0]m_axis_ppkt_tuser;
  input aclk;
  input t1_aresetn_reg;
  input s_axis_ppkt_tvalid;
  input [114:0]D;
  input m_axis_ppkt_tready;

  wire [114:0]D;
  wire [0:0]Q;
  wire [2:0]S_AXIS_TKEEP;
  wire S_AXIS_TLAST;
  wire [79:0]S_AXIS_TUSER;
  wire aclk;
  wire areset_r;
  wire axis_register_slice_0_n_10;
  wire axis_register_slice_0_n_11;
  wire axis_register_slice_0_n_12;
  wire axis_register_slice_0_n_13;
  wire axis_register_slice_0_n_14;
  wire axis_register_slice_0_n_15;
  wire axis_register_slice_0_n_16;
  wire axis_register_slice_0_n_17;
  wire axis_register_slice_0_n_18;
  wire axis_register_slice_0_n_19;
  wire axis_register_slice_0_n_20;
  wire axis_register_slice_0_n_21;
  wire axis_register_slice_0_n_22;
  wire axis_register_slice_0_n_23;
  wire axis_register_slice_0_n_24;
  wire axis_register_slice_0_n_25;
  wire axis_register_slice_0_n_26;
  wire axis_register_slice_0_n_27;
  wire axis_register_slice_0_n_28;
  wire axis_register_slice_0_n_29;
  wire axis_register_slice_0_n_3;
  wire axis_register_slice_0_n_30;
  wire axis_register_slice_0_n_31;
  wire axis_register_slice_0_n_32;
  wire axis_register_slice_0_n_33;
  wire axis_register_slice_0_n_34;
  wire axis_register_slice_0_n_4;
  wire axis_register_slice_0_n_5;
  wire axis_register_slice_0_n_6;
  wire axis_register_slice_0_n_7;
  wire axis_register_slice_0_n_8;
  wire axis_register_slice_0_n_9;
  wire d1_ready;
  wire d1_valid;
  wire [255:0]m_axis_ppkt_tdata;
  wire [15:0]m_axis_ppkt_tkeep;
  wire m_axis_ppkt_tlast;
  wire m_axis_ppkt_tready;
  wire [79:0]m_axis_ppkt_tuser;
  wire [0:0]m_axis_ppkt_tvalid;
  wire s_axis_ppkt_tvalid;
  wire t1_aresetn_reg;

  px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_conv_axis_register_slice axis_register_slice_0
       (.D(D),
        .Q({Q,d1_valid}),
        .S_AXIS_TLAST(S_AXIS_TLAST),
        .aclk(aclk),
        .areset_r(areset_r),
        .\r0_data_reg[31] ({axis_register_slice_0_n_3,axis_register_slice_0_n_4,axis_register_slice_0_n_5,axis_register_slice_0_n_6,axis_register_slice_0_n_7,axis_register_slice_0_n_8,axis_register_slice_0_n_9,axis_register_slice_0_n_10,axis_register_slice_0_n_11,axis_register_slice_0_n_12,axis_register_slice_0_n_13,axis_register_slice_0_n_14,axis_register_slice_0_n_15,axis_register_slice_0_n_16,axis_register_slice_0_n_17,axis_register_slice_0_n_18,axis_register_slice_0_n_19,axis_register_slice_0_n_20,axis_register_slice_0_n_21,axis_register_slice_0_n_22,axis_register_slice_0_n_23,axis_register_slice_0_n_24,axis_register_slice_0_n_25,axis_register_slice_0_n_26,axis_register_slice_0_n_27,axis_register_slice_0_n_28,axis_register_slice_0_n_29,axis_register_slice_0_n_30,axis_register_slice_0_n_31,axis_register_slice_0_n_32,axis_register_slice_0_n_33,axis_register_slice_0_n_34}),
        .\r0_keep_reg[2] ({S_AXIS_TKEEP[2],S_AXIS_TKEEP[0]}),
        .\r0_user_reg[79] (S_AXIS_TUSER),
        .s_axis_ppkt_tvalid(s_axis_ppkt_tvalid),
        .\state_reg[0] (d1_ready),
        .t1_aresetn_reg(t1_aresetn_reg));
  px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_conv_axisc_upsizer \gen_upsizer_conversion.axisc_upsizer_0 
       (.D({axis_register_slice_0_n_3,axis_register_slice_0_n_4,axis_register_slice_0_n_5,axis_register_slice_0_n_6,axis_register_slice_0_n_7,axis_register_slice_0_n_8,axis_register_slice_0_n_9,axis_register_slice_0_n_10,axis_register_slice_0_n_11,axis_register_slice_0_n_12,axis_register_slice_0_n_13,axis_register_slice_0_n_14,axis_register_slice_0_n_15,axis_register_slice_0_n_16,axis_register_slice_0_n_17,axis_register_slice_0_n_18,axis_register_slice_0_n_19,axis_register_slice_0_n_20,axis_register_slice_0_n_21,axis_register_slice_0_n_22,axis_register_slice_0_n_23,axis_register_slice_0_n_24,axis_register_slice_0_n_25,axis_register_slice_0_n_26,axis_register_slice_0_n_27,axis_register_slice_0_n_28,axis_register_slice_0_n_29,axis_register_slice_0_n_30,axis_register_slice_0_n_31,axis_register_slice_0_n_32,axis_register_slice_0_n_33,axis_register_slice_0_n_34}),
        .Q({m_axis_ppkt_tvalid,d1_ready}),
        .S_AXIS_TLAST(S_AXIS_TLAST),
        .aclk(aclk),
        .areset_r(areset_r),
        .\gen_AB_reg_slice.payload_b_reg[116] (S_AXIS_TUSER),
        .\gen_AB_reg_slice.payload_b_reg[34] ({S_AXIS_TKEEP[2],S_AXIS_TKEEP[0]}),
        .\gen_AB_reg_slice.state_reg[0] (d1_valid),
        .m_axis_ppkt_tdata(m_axis_ppkt_tdata),
        .m_axis_ppkt_tkeep(m_axis_ppkt_tkeep),
        .m_axis_ppkt_tlast(m_axis_ppkt_tlast),
        .m_axis_ppkt_tready(m_axis_ppkt_tready),
        .m_axis_ppkt_tuser(m_axis_ppkt_tuser));
endmodule

(* ORIG_REF_NAME = "px_ppkt_width_upsizer" *) 
module px_vita49_pkt_ppkt_upsizer_px_ppkt_width_upsizer
   (Q,
    m_axis_ppkt_tvalid,
    m_axis_ppkt_tdata,
    m_axis_ppkt_tkeep,
    m_axis_ppkt_tuser,
    m_axis_ppkt_tlast,
    aclk,
    m_axis_ppkt_tready,
    aresetn,
    D,
    s_axis_ppkt_tvalid);
  output [0:0]Q;
  output [0:0]m_axis_ppkt_tvalid;
  output [255:0]m_axis_ppkt_tdata;
  output [15:0]m_axis_ppkt_tkeep;
  output [79:0]m_axis_ppkt_tuser;
  output m_axis_ppkt_tlast;
  input aclk;
  input m_axis_ppkt_tready;
  input aresetn;
  input [114:0]D;
  input s_axis_ppkt_tvalid;

  wire [114:0]D;
  wire [0:0]Q;
  wire aclk;
  wire aresetn;
  wire [255:0]m_axis_ppkt_tdata;
  wire [15:0]m_axis_ppkt_tkeep;
  wire m_axis_ppkt_tlast;
  wire m_axis_ppkt_tready;
  wire [79:0]m_axis_ppkt_tuser;
  wire [0:0]m_axis_ppkt_tvalid;
  wire s_axis_ppkt_tvalid;
  wire t1_aresetn_reg_n_0;

  FDRE #(
    .INIT(1'b0)) 
    t1_aresetn_reg
       (.C(aclk),
        .CE(1'b1),
        .D(aresetn),
        .Q(t1_aresetn_reg_n_0),
        .R(1'b0));
  px_vita49_pkt_ppkt_upsizer_px_axis_dwidth_upconv widthconv_inst
       (.D(D),
        .Q(Q),
        .aclk(aclk),
        .m_axis_ppkt_tdata(m_axis_ppkt_tdata),
        .m_axis_ppkt_tkeep(m_axis_ppkt_tkeep),
        .m_axis_ppkt_tlast(m_axis_ppkt_tlast),
        .m_axis_ppkt_tready(m_axis_ppkt_tready),
        .m_axis_ppkt_tuser(m_axis_ppkt_tuser),
        .m_axis_ppkt_tvalid(m_axis_ppkt_tvalid),
        .s_axis_ppkt_tvalid(s_axis_ppkt_tvalid),
        .t1_aresetn_reg(t1_aresetn_reg_n_0));
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
