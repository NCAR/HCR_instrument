// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
// Date        : Mon Apr 26 16:12:18 2021
// Host        : wind running 64-bit unknown
// Command     : write_verilog -force -mode funcsim
//               /home/karboski/git/HCR_instrument/src/Pentek821/FDK/2017.2/p71821_060/p71821.srcs/sources_1/bd/user_block2/ip/user_block2_position_encoder_0_0/user_block2_position_encoder_0_0_sim_netlist.v
// Design      : user_block2_position_encoder_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "user_block2_position_encoder_0_0,position_encoder,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "position_encoder,Vivado 2017.2" *) 
(* NotValidForBitStream *)
module user_block2_position_encoder_0_0
   (aclk,
    aresetn,
    ctl_reg,
    ROT_A,
    ROT_B,
    TILT_A,
    TILT_B,
    AZ_MOSI,
    AZ_SCK,
    AZ_SSEL,
    EL_MOSI,
    EL_SCK,
    EL_SSEL,
    pos_enc_0,
    pos_enc_1);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 aclk CLK" *) input aclk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 aresetn RST" *) input aresetn;
  input [31:0]ctl_reg;
  input ROT_A;
  input ROT_B;
  input TILT_A;
  input TILT_B;
  input AZ_MOSI;
  input AZ_SCK;
  input AZ_SSEL;
  input EL_MOSI;
  input EL_SCK;
  input EL_SSEL;
  output [31:0]pos_enc_0;
  output [31:0]pos_enc_1;

  wire \<const0> ;
  wire AZ_MOSI;
  wire AZ_SCK;
  wire AZ_SSEL;
  wire EL_MOSI;
  wire EL_SCK;
  wire EL_SSEL;
  wire ROT_A;
  wire ROT_B;
  wire TILT_A;
  wire TILT_B;
  wire aclk;
  wire aresetn;
  wire [31:0]ctl_reg;
  wire [18:0]\^pos_enc_0 ;
  wire [18:0]\^pos_enc_1 ;

  assign pos_enc_0[31] = \<const0> ;
  assign pos_enc_0[30] = \<const0> ;
  assign pos_enc_0[29] = \<const0> ;
  assign pos_enc_0[28] = \<const0> ;
  assign pos_enc_0[27] = \<const0> ;
  assign pos_enc_0[26] = \<const0> ;
  assign pos_enc_0[25] = \<const0> ;
  assign pos_enc_0[24] = \<const0> ;
  assign pos_enc_0[23] = \<const0> ;
  assign pos_enc_0[22] = \<const0> ;
  assign pos_enc_0[21] = \<const0> ;
  assign pos_enc_0[20] = \<const0> ;
  assign pos_enc_0[19] = \<const0> ;
  assign pos_enc_0[18:0] = \^pos_enc_0 [18:0];
  assign pos_enc_1[31] = \<const0> ;
  assign pos_enc_1[30] = \<const0> ;
  assign pos_enc_1[29] = \<const0> ;
  assign pos_enc_1[28] = \<const0> ;
  assign pos_enc_1[27] = \<const0> ;
  assign pos_enc_1[26] = \<const0> ;
  assign pos_enc_1[25] = \<const0> ;
  assign pos_enc_1[24] = \<const0> ;
  assign pos_enc_1[23] = \<const0> ;
  assign pos_enc_1[22] = \<const0> ;
  assign pos_enc_1[21] = \<const0> ;
  assign pos_enc_1[20] = \<const0> ;
  assign pos_enc_1[19] = \<const0> ;
  assign pos_enc_1[18:0] = \^pos_enc_1 [18:0];
  GND GND
       (.G(\<const0> ));
  user_block2_position_encoder_0_0_position_encoder U0
       (.AZ_MOSI(AZ_MOSI),
        .AZ_SCK(AZ_SCK),
        .AZ_SSEL(AZ_SSEL),
        .EL_MOSI(EL_MOSI),
        .EL_SCK(EL_SCK),
        .EL_SSEL(EL_SSEL),
        .ROT_A(ROT_A),
        .ROT_B(ROT_B),
        .TILT_A(TILT_A),
        .TILT_B(TILT_B),
        .aclk(aclk),
        .aresetn(aresetn),
        .ctl_reg(ctl_reg[1:0]),
        .pos_enc_0(\^pos_enc_0 ),
        .pos_enc_1(\^pos_enc_1 ));
endmodule

(* ORIG_REF_NAME = "QUAD2BIN" *) 
module user_block2_position_encoder_0_0_QUAD2BIN
   (pos_enc_0,
    pos_enc_1,
    \pos_enc_0[15] ,
    \pos_enc_0[14] ,
    \pos_enc_0[13] ,
    \pos_enc_0[12] ,
    \pos_enc_0[11] ,
    \pos_enc_0[10] ,
    \pos_enc_0[9] ,
    \pos_enc_0[8] ,
    \pos_enc_0[7] ,
    \pos_enc_0[6] ,
    \pos_enc_0[5] ,
    \pos_enc_0[4] ,
    \pos_enc_0[3] ,
    pos_enc_0_2__s_port_,
    pos_enc_0_1__s_port_,
    pos_enc_0_0__s_port_,
    \pos_enc_1[15] ,
    \pos_enc_1[14] ,
    \pos_enc_1[13] ,
    \pos_enc_1[12] ,
    \pos_enc_1[11] ,
    \pos_enc_1[10] ,
    \pos_enc_1[9] ,
    \pos_enc_1[8] ,
    \pos_enc_1[7] ,
    \pos_enc_1[6] ,
    \pos_enc_1[5] ,
    \pos_enc_1[4] ,
    \pos_enc_1[3] ,
    pos_enc_1_2__s_port_,
    pos_enc_1_1__s_port_,
    pos_enc_1_0__s_port_,
    aclk,
    aresetn,
    ctl_reg,
    ROT_A,
    ROT_B,
    TILT_B,
    TILT_A);
  output [2:0]pos_enc_0;
  output [2:0]pos_enc_1;
  output \pos_enc_0[15] ;
  output \pos_enc_0[14] ;
  output \pos_enc_0[13] ;
  output \pos_enc_0[12] ;
  output \pos_enc_0[11] ;
  output \pos_enc_0[10] ;
  output \pos_enc_0[9] ;
  output \pos_enc_0[8] ;
  output \pos_enc_0[7] ;
  output \pos_enc_0[6] ;
  output \pos_enc_0[5] ;
  output \pos_enc_0[4] ;
  output \pos_enc_0[3] ;
  output pos_enc_0_2__s_port_;
  output pos_enc_0_1__s_port_;
  output pos_enc_0_0__s_port_;
  output \pos_enc_1[15] ;
  output \pos_enc_1[14] ;
  output \pos_enc_1[13] ;
  output \pos_enc_1[12] ;
  output \pos_enc_1[11] ;
  output \pos_enc_1[10] ;
  output \pos_enc_1[9] ;
  output \pos_enc_1[8] ;
  output \pos_enc_1[7] ;
  output \pos_enc_1[6] ;
  output \pos_enc_1[5] ;
  output \pos_enc_1[4] ;
  output \pos_enc_1[3] ;
  output pos_enc_1_2__s_port_;
  output pos_enc_1_1__s_port_;
  output pos_enc_1_0__s_port_;
  input aclk;
  input aresetn;
  input [1:0]ctl_reg;
  input ROT_A;
  input ROT_B;
  input TILT_B;
  input TILT_A;

  wire FF4_n_1;
  wire FF4_n_10;
  wire FF4_n_11;
  wire FF4_n_12;
  wire FF4_n_13;
  wire FF4_n_14;
  wire FF4_n_15;
  wire FF4_n_16;
  wire FF4_n_17;
  wire FF4_n_18;
  wire FF4_n_2;
  wire FF4_n_3;
  wire FF4_n_4;
  wire FF4_n_5;
  wire FF4_n_6;
  wire FF4_n_7;
  wire FF4_n_8;
  wire FF4_n_9;
  wire ROT_A;
  wire ROT_B;
  wire \ROT_POS_reg_n_0_[16] ;
  wire \ROT_POS_reg_n_0_[17] ;
  wire \ROT_POS_reg_n_0_[18] ;
  wire TILT_A;
  wire TILT_B;
  wire \TILT_POS_reg_n_0_[16] ;
  wire \TILT_POS_reg_n_0_[17] ;
  wire \TILT_POS_reg_n_0_[18] ;
  wire aclk;
  wire aresetn;
  wire [1:0]ctl_reg;
  wire i__carry__0_i_1_n_0;
  wire i__carry__0_i_2_n_0;
  wire i__carry__0_i_3_n_0;
  wire i__carry__0_i_4_n_0;
  wire i__carry__0_i_5_n_0;
  wire i__carry__0_i_6_n_0;
  wire i__carry__0_i_7_n_0;
  wire i__carry__0_i_8_n_0;
  wire i__carry__1_i_1_n_0;
  wire i__carry__1_i_2_n_0;
  wire i__carry_i_1_n_0;
  wire i__carry_i_2_n_0;
  wire i__carry_i_3_n_0;
  wire i__carry_i_4_n_0;
  wire i__carry_i_5_n_0;
  wire i__carry_i_6_n_0;
  wire i__carry_i_7_n_0;
  wire i__carry_i_8_n_0;
  wire minusOp_carry__0_i_1_n_0;
  wire minusOp_carry__0_i_2_n_0;
  wire minusOp_carry__0_i_3_n_0;
  wire minusOp_carry__0_i_4_n_0;
  wire minusOp_carry__0_i_5_n_0;
  wire minusOp_carry__0_i_6_n_0;
  wire minusOp_carry__0_i_7_n_0;
  wire minusOp_carry__0_i_8_n_0;
  wire minusOp_carry__0_n_0;
  wire minusOp_carry__0_n_1;
  wire minusOp_carry__0_n_10;
  wire minusOp_carry__0_n_11;
  wire minusOp_carry__0_n_12;
  wire minusOp_carry__0_n_13;
  wire minusOp_carry__0_n_14;
  wire minusOp_carry__0_n_15;
  wire minusOp_carry__0_n_2;
  wire minusOp_carry__0_n_3;
  wire minusOp_carry__0_n_5;
  wire minusOp_carry__0_n_6;
  wire minusOp_carry__0_n_7;
  wire minusOp_carry__0_n_8;
  wire minusOp_carry__0_n_9;
  wire minusOp_carry__1_i_1_n_0;
  wire minusOp_carry__1_i_2_n_0;
  wire minusOp_carry__1_n_14;
  wire minusOp_carry__1_n_15;
  wire minusOp_carry__1_n_7;
  wire minusOp_carry_i_1_n_0;
  wire minusOp_carry_i_2_n_0;
  wire minusOp_carry_i_3_n_0;
  wire minusOp_carry_i_4_n_0;
  wire minusOp_carry_i_5_n_0;
  wire minusOp_carry_i_6_n_0;
  wire minusOp_carry_i_7_n_0;
  wire minusOp_carry_i_8_n_0;
  wire minusOp_carry_n_0;
  wire minusOp_carry_n_1;
  wire minusOp_carry_n_10;
  wire minusOp_carry_n_11;
  wire minusOp_carry_n_12;
  wire minusOp_carry_n_13;
  wire minusOp_carry_n_14;
  wire minusOp_carry_n_15;
  wire minusOp_carry_n_2;
  wire minusOp_carry_n_3;
  wire minusOp_carry_n_5;
  wire minusOp_carry_n_6;
  wire minusOp_carry_n_7;
  wire minusOp_carry_n_8;
  wire minusOp_carry_n_9;
  wire \minusOp_inferred__0/i__carry__0_n_0 ;
  wire \minusOp_inferred__0/i__carry__0_n_1 ;
  wire \minusOp_inferred__0/i__carry__0_n_10 ;
  wire \minusOp_inferred__0/i__carry__0_n_11 ;
  wire \minusOp_inferred__0/i__carry__0_n_12 ;
  wire \minusOp_inferred__0/i__carry__0_n_13 ;
  wire \minusOp_inferred__0/i__carry__0_n_14 ;
  wire \minusOp_inferred__0/i__carry__0_n_15 ;
  wire \minusOp_inferred__0/i__carry__0_n_2 ;
  wire \minusOp_inferred__0/i__carry__0_n_3 ;
  wire \minusOp_inferred__0/i__carry__0_n_5 ;
  wire \minusOp_inferred__0/i__carry__0_n_6 ;
  wire \minusOp_inferred__0/i__carry__0_n_7 ;
  wire \minusOp_inferred__0/i__carry__0_n_8 ;
  wire \minusOp_inferred__0/i__carry__0_n_9 ;
  wire \minusOp_inferred__0/i__carry__1_n_14 ;
  wire \minusOp_inferred__0/i__carry__1_n_15 ;
  wire \minusOp_inferred__0/i__carry__1_n_7 ;
  wire \minusOp_inferred__0/i__carry_n_0 ;
  wire \minusOp_inferred__0/i__carry_n_1 ;
  wire \minusOp_inferred__0/i__carry_n_10 ;
  wire \minusOp_inferred__0/i__carry_n_11 ;
  wire \minusOp_inferred__0/i__carry_n_12 ;
  wire \minusOp_inferred__0/i__carry_n_13 ;
  wire \minusOp_inferred__0/i__carry_n_14 ;
  wire \minusOp_inferred__0/i__carry_n_15 ;
  wire \minusOp_inferred__0/i__carry_n_2 ;
  wire \minusOp_inferred__0/i__carry_n_3 ;
  wire \minusOp_inferred__0/i__carry_n_5 ;
  wire \minusOp_inferred__0/i__carry_n_6 ;
  wire \minusOp_inferred__0/i__carry_n_7 ;
  wire \minusOp_inferred__0/i__carry_n_8 ;
  wire \minusOp_inferred__0/i__carry_n_9 ;
  wire [18:0]p_0_in;
  wire [2:0]pos_enc_0;
  wire \pos_enc_0[10] ;
  wire \pos_enc_0[11] ;
  wire \pos_enc_0[12] ;
  wire \pos_enc_0[13] ;
  wire \pos_enc_0[14] ;
  wire \pos_enc_0[15] ;
  wire \pos_enc_0[3] ;
  wire \pos_enc_0[4] ;
  wire \pos_enc_0[5] ;
  wire \pos_enc_0[6] ;
  wire \pos_enc_0[7] ;
  wire \pos_enc_0[8] ;
  wire \pos_enc_0[9] ;
  wire pos_enc_0_0__s_net_1;
  wire pos_enc_0_1__s_net_1;
  wire pos_enc_0_2__s_net_1;
  wire [2:0]pos_enc_1;
  wire \pos_enc_1[10] ;
  wire \pos_enc_1[11] ;
  wire \pos_enc_1[12] ;
  wire \pos_enc_1[13] ;
  wire \pos_enc_1[14] ;
  wire \pos_enc_1[15] ;
  wire \pos_enc_1[3] ;
  wire \pos_enc_1[4] ;
  wire \pos_enc_1[5] ;
  wire \pos_enc_1[6] ;
  wire \pos_enc_1[7] ;
  wire \pos_enc_1[8] ;
  wire \pos_enc_1[9] ;
  wire pos_enc_1_0__s_net_1;
  wire pos_enc_1_1__s_net_1;
  wire pos_enc_1_2__s_net_1;
  wire rot_a_d1;
  wire rot_a_d2;
  wire rot_a_d3;
  wire rot_a_d4;
  wire rot_a_filt;
  wire rot_a_filt_d1;
  wire rot_b_d1;
  wire rot_b_d2;
  wire rot_b_d3;
  wire rot_b_d4;
  wire rot_b_filt;
  wire rot_b_filt_d1;
  wire rot_count_enable;
  wire [18:0]rot_encoder_cnt;
  wire rot_encoder_cnt0;
  wire \rot_encoder_cnt[16]_i_10_n_0 ;
  wire \rot_encoder_cnt[16]_i_3_n_0 ;
  wire \rot_encoder_cnt[16]_i_4_n_0 ;
  wire \rot_encoder_cnt[16]_i_5_n_0 ;
  wire \rot_encoder_cnt[16]_i_6_n_0 ;
  wire \rot_encoder_cnt[16]_i_7_n_0 ;
  wire \rot_encoder_cnt[16]_i_8_n_0 ;
  wire \rot_encoder_cnt[16]_i_9_n_0 ;
  wire \rot_encoder_cnt[18]_i_10_n_0 ;
  wire \rot_encoder_cnt[18]_i_11_n_0 ;
  wire \rot_encoder_cnt[18]_i_12_n_0 ;
  wire \rot_encoder_cnt[18]_i_13_n_0 ;
  wire \rot_encoder_cnt[18]_i_14_n_0 ;
  wire \rot_encoder_cnt[18]_i_15_n_0 ;
  wire \rot_encoder_cnt[18]_i_16_n_0 ;
  wire \rot_encoder_cnt[18]_i_17_n_0 ;
  wire \rot_encoder_cnt[18]_i_18_n_0 ;
  wire \rot_encoder_cnt[18]_i_5_n_0 ;
  wire \rot_encoder_cnt[18]_i_6_n_0 ;
  wire \rot_encoder_cnt[18]_i_7_n_0 ;
  wire \rot_encoder_cnt[18]_i_8_n_0 ;
  wire \rot_encoder_cnt[18]_i_9_n_0 ;
  wire \rot_encoder_cnt[8]_i_10_n_0 ;
  wire \rot_encoder_cnt[8]_i_3_n_0 ;
  wire \rot_encoder_cnt[8]_i_4_n_0 ;
  wire \rot_encoder_cnt[8]_i_5_n_0 ;
  wire \rot_encoder_cnt[8]_i_6_n_0 ;
  wire \rot_encoder_cnt[8]_i_7_n_0 ;
  wire \rot_encoder_cnt[8]_i_8_n_0 ;
  wire \rot_encoder_cnt[8]_i_9_n_0 ;
  wire \rot_encoder_cnt_reg[16]_i_2_n_0 ;
  wire \rot_encoder_cnt_reg[16]_i_2_n_1 ;
  wire \rot_encoder_cnt_reg[16]_i_2_n_10 ;
  wire \rot_encoder_cnt_reg[16]_i_2_n_11 ;
  wire \rot_encoder_cnt_reg[16]_i_2_n_12 ;
  wire \rot_encoder_cnt_reg[16]_i_2_n_13 ;
  wire \rot_encoder_cnt_reg[16]_i_2_n_14 ;
  wire \rot_encoder_cnt_reg[16]_i_2_n_15 ;
  wire \rot_encoder_cnt_reg[16]_i_2_n_2 ;
  wire \rot_encoder_cnt_reg[16]_i_2_n_3 ;
  wire \rot_encoder_cnt_reg[16]_i_2_n_5 ;
  wire \rot_encoder_cnt_reg[16]_i_2_n_6 ;
  wire \rot_encoder_cnt_reg[16]_i_2_n_7 ;
  wire \rot_encoder_cnt_reg[16]_i_2_n_8 ;
  wire \rot_encoder_cnt_reg[16]_i_2_n_9 ;
  wire \rot_encoder_cnt_reg[18]_i_4_n_14 ;
  wire \rot_encoder_cnt_reg[18]_i_4_n_15 ;
  wire \rot_encoder_cnt_reg[18]_i_4_n_7 ;
  wire \rot_encoder_cnt_reg[8]_i_2_n_0 ;
  wire \rot_encoder_cnt_reg[8]_i_2_n_1 ;
  wire \rot_encoder_cnt_reg[8]_i_2_n_10 ;
  wire \rot_encoder_cnt_reg[8]_i_2_n_11 ;
  wire \rot_encoder_cnt_reg[8]_i_2_n_12 ;
  wire \rot_encoder_cnt_reg[8]_i_2_n_13 ;
  wire \rot_encoder_cnt_reg[8]_i_2_n_14 ;
  wire \rot_encoder_cnt_reg[8]_i_2_n_15 ;
  wire \rot_encoder_cnt_reg[8]_i_2_n_2 ;
  wire \rot_encoder_cnt_reg[8]_i_2_n_3 ;
  wire \rot_encoder_cnt_reg[8]_i_2_n_5 ;
  wire \rot_encoder_cnt_reg[8]_i_2_n_6 ;
  wire \rot_encoder_cnt_reg[8]_i_2_n_7 ;
  wire \rot_encoder_cnt_reg[8]_i_2_n_8 ;
  wire \rot_encoder_cnt_reg[8]_i_2_n_9 ;
  wire tilt_a_d1;
  wire tilt_a_d2;
  wire tilt_a_d3;
  wire tilt_a_d4;
  wire tilt_a_filt;
  wire tilt_a_filt_d1;
  wire tilt_b_d1;
  wire tilt_b_d2;
  wire tilt_b_d3;
  wire tilt_b_d4;
  wire tilt_b_filt;
  wire tilt_b_filt_d1;
  wire tilt_count_enable;
  wire [18:0]tilt_encoder_cnt;
  wire tilt_encoder_cnt0;
  wire \tilt_encoder_cnt[0]_i_1_n_0 ;
  wire \tilt_encoder_cnt[16]_i_10_n_0 ;
  wire \tilt_encoder_cnt[16]_i_3_n_0 ;
  wire \tilt_encoder_cnt[16]_i_4_n_0 ;
  wire \tilt_encoder_cnt[16]_i_5_n_0 ;
  wire \tilt_encoder_cnt[16]_i_6_n_0 ;
  wire \tilt_encoder_cnt[16]_i_7_n_0 ;
  wire \tilt_encoder_cnt[16]_i_8_n_0 ;
  wire \tilt_encoder_cnt[16]_i_9_n_0 ;
  wire \tilt_encoder_cnt[18]_i_10_n_0 ;
  wire \tilt_encoder_cnt[18]_i_11_n_0 ;
  wire \tilt_encoder_cnt[18]_i_12_n_0 ;
  wire \tilt_encoder_cnt[18]_i_13_n_0 ;
  wire \tilt_encoder_cnt[18]_i_14_n_0 ;
  wire \tilt_encoder_cnt[18]_i_15_n_0 ;
  wire \tilt_encoder_cnt[18]_i_7_n_0 ;
  wire \tilt_encoder_cnt[18]_i_8_n_0 ;
  wire \tilt_encoder_cnt[18]_i_9_n_0 ;
  wire \tilt_encoder_cnt[8]_i_10_n_0 ;
  wire \tilt_encoder_cnt[8]_i_3_n_0 ;
  wire \tilt_encoder_cnt[8]_i_4_n_0 ;
  wire \tilt_encoder_cnt[8]_i_5_n_0 ;
  wire \tilt_encoder_cnt[8]_i_6_n_0 ;
  wire \tilt_encoder_cnt[8]_i_7_n_0 ;
  wire \tilt_encoder_cnt[8]_i_8_n_0 ;
  wire \tilt_encoder_cnt[8]_i_9_n_0 ;
  wire \tilt_encoder_cnt_reg[16]_i_2_n_0 ;
  wire \tilt_encoder_cnt_reg[16]_i_2_n_1 ;
  wire \tilt_encoder_cnt_reg[16]_i_2_n_10 ;
  wire \tilt_encoder_cnt_reg[16]_i_2_n_11 ;
  wire \tilt_encoder_cnt_reg[16]_i_2_n_12 ;
  wire \tilt_encoder_cnt_reg[16]_i_2_n_13 ;
  wire \tilt_encoder_cnt_reg[16]_i_2_n_14 ;
  wire \tilt_encoder_cnt_reg[16]_i_2_n_15 ;
  wire \tilt_encoder_cnt_reg[16]_i_2_n_2 ;
  wire \tilt_encoder_cnt_reg[16]_i_2_n_3 ;
  wire \tilt_encoder_cnt_reg[16]_i_2_n_5 ;
  wire \tilt_encoder_cnt_reg[16]_i_2_n_6 ;
  wire \tilt_encoder_cnt_reg[16]_i_2_n_7 ;
  wire \tilt_encoder_cnt_reg[16]_i_2_n_8 ;
  wire \tilt_encoder_cnt_reg[16]_i_2_n_9 ;
  wire \tilt_encoder_cnt_reg[18]_i_5_n_14 ;
  wire \tilt_encoder_cnt_reg[18]_i_5_n_15 ;
  wire \tilt_encoder_cnt_reg[18]_i_5_n_7 ;
  wire \tilt_encoder_cnt_reg[8]_i_2_n_0 ;
  wire \tilt_encoder_cnt_reg[8]_i_2_n_1 ;
  wire \tilt_encoder_cnt_reg[8]_i_2_n_10 ;
  wire \tilt_encoder_cnt_reg[8]_i_2_n_11 ;
  wire \tilt_encoder_cnt_reg[8]_i_2_n_12 ;
  wire \tilt_encoder_cnt_reg[8]_i_2_n_13 ;
  wire \tilt_encoder_cnt_reg[8]_i_2_n_14 ;
  wire \tilt_encoder_cnt_reg[8]_i_2_n_15 ;
  wire \tilt_encoder_cnt_reg[8]_i_2_n_2 ;
  wire \tilt_encoder_cnt_reg[8]_i_2_n_3 ;
  wire \tilt_encoder_cnt_reg[8]_i_2_n_5 ;
  wire \tilt_encoder_cnt_reg[8]_i_2_n_6 ;
  wire \tilt_encoder_cnt_reg[8]_i_2_n_7 ;
  wire \tilt_encoder_cnt_reg[8]_i_2_n_8 ;
  wire \tilt_encoder_cnt_reg[8]_i_2_n_9 ;
  wire tilt_z_d1;
  wire tilt_z_d2;
  wire tilt_z_d3;
  wire tilt_z_d4;
  wire [3:3]NLW_minusOp_carry_CO_UNCONNECTED;
  wire [3:3]NLW_minusOp_carry__0_CO_UNCONNECTED;
  wire [7:1]NLW_minusOp_carry__1_CO_UNCONNECTED;
  wire [7:2]NLW_minusOp_carry__1_DI_UNCONNECTED;
  wire [7:2]NLW_minusOp_carry__1_O_UNCONNECTED;
  wire [7:2]NLW_minusOp_carry__1_S_UNCONNECTED;
  wire [3:3]\NLW_minusOp_inferred__0/i__carry_CO_UNCONNECTED ;
  wire [3:3]\NLW_minusOp_inferred__0/i__carry__0_CO_UNCONNECTED ;
  wire [7:1]\NLW_minusOp_inferred__0/i__carry__1_CO_UNCONNECTED ;
  wire [7:2]\NLW_minusOp_inferred__0/i__carry__1_DI_UNCONNECTED ;
  wire [7:2]\NLW_minusOp_inferred__0/i__carry__1_O_UNCONNECTED ;
  wire [7:2]\NLW_minusOp_inferred__0/i__carry__1_S_UNCONNECTED ;
  wire [3:3]\NLW_rot_encoder_cnt_reg[16]_i_2_CO_UNCONNECTED ;
  wire [7:1]\NLW_rot_encoder_cnt_reg[18]_i_4_CO_UNCONNECTED ;
  wire [7:2]\NLW_rot_encoder_cnt_reg[18]_i_4_DI_UNCONNECTED ;
  wire [7:2]\NLW_rot_encoder_cnt_reg[18]_i_4_O_UNCONNECTED ;
  wire [7:2]\NLW_rot_encoder_cnt_reg[18]_i_4_S_UNCONNECTED ;
  wire [3:3]\NLW_rot_encoder_cnt_reg[8]_i_2_CO_UNCONNECTED ;
  wire [3:3]\NLW_tilt_encoder_cnt_reg[16]_i_2_CO_UNCONNECTED ;
  wire [7:1]\NLW_tilt_encoder_cnt_reg[18]_i_5_CO_UNCONNECTED ;
  wire [7:2]\NLW_tilt_encoder_cnt_reg[18]_i_5_DI_UNCONNECTED ;
  wire [7:2]\NLW_tilt_encoder_cnt_reg[18]_i_5_O_UNCONNECTED ;
  wire [7:2]\NLW_tilt_encoder_cnt_reg[18]_i_5_S_UNCONNECTED ;
  wire [3:3]\NLW_tilt_encoder_cnt_reg[8]_i_2_CO_UNCONNECTED ;

  assign pos_enc_0_0__s_port_ = pos_enc_0_0__s_net_1;
  assign pos_enc_0_1__s_port_ = pos_enc_0_1__s_net_1;
  assign pos_enc_0_2__s_port_ = pos_enc_0_2__s_net_1;
  assign pos_enc_1_0__s_port_ = pos_enc_1_0__s_net_1;
  assign pos_enc_1_1__s_port_ = pos_enc_1_1__s_net_1;
  assign pos_enc_1_2__s_port_ = pos_enc_1_2__s_net_1;
  user_block2_position_encoder_0_0_quad2bin_jkff FF1
       (.D(p_0_in),
        .E(rot_count_enable),
        .O({\rot_encoder_cnt_reg[8]_i_2_n_8 ,\rot_encoder_cnt_reg[8]_i_2_n_9 ,\rot_encoder_cnt_reg[8]_i_2_n_10 ,\rot_encoder_cnt_reg[8]_i_2_n_11 ,\rot_encoder_cnt_reg[8]_i_2_n_12 ,\rot_encoder_cnt_reg[8]_i_2_n_13 ,\rot_encoder_cnt_reg[8]_i_2_n_14 ,\rot_encoder_cnt_reg[8]_i_2_n_15 }),
        .Q(rot_encoder_cnt[0]),
        .aclk(aclk),
        .aresetn(aresetn),
        .rot_a_d2(rot_a_d2),
        .rot_a_d3(rot_a_d3),
        .rot_a_d4(rot_a_d4),
        .rot_a_filt(rot_a_filt),
        .rot_a_filt_d1(rot_a_filt_d1),
        .rot_b_filt(rot_b_filt),
        .rot_b_filt_d1(rot_b_filt_d1),
        .\rot_encoder_cnt_reg[0] ({minusOp_carry_n_8,minusOp_carry_n_9,minusOp_carry_n_10,minusOp_carry_n_11,minusOp_carry_n_12,minusOp_carry_n_13,minusOp_carry_n_14,minusOp_carry_n_15}),
        .\rot_encoder_cnt_reg[0]_0 ({\rot_encoder_cnt_reg[16]_i_2_n_8 ,\rot_encoder_cnt_reg[16]_i_2_n_9 ,\rot_encoder_cnt_reg[16]_i_2_n_10 ,\rot_encoder_cnt_reg[16]_i_2_n_11 ,\rot_encoder_cnt_reg[16]_i_2_n_12 ,\rot_encoder_cnt_reg[16]_i_2_n_13 ,\rot_encoder_cnt_reg[16]_i_2_n_14 ,\rot_encoder_cnt_reg[16]_i_2_n_15 }),
        .\rot_encoder_cnt_reg[15] (\rot_encoder_cnt[18]_i_5_n_0 ),
        .\rot_encoder_cnt_reg[16] ({minusOp_carry__0_n_8,minusOp_carry__0_n_9,minusOp_carry__0_n_10,minusOp_carry__0_n_11,minusOp_carry__0_n_12,minusOp_carry__0_n_13,minusOp_carry__0_n_14,minusOp_carry__0_n_15}),
        .\rot_encoder_cnt_reg[17] (\rot_encoder_cnt[18]_i_6_n_0 ),
        .\rot_encoder_cnt_reg[17]_0 ({minusOp_carry__1_n_14,minusOp_carry__1_n_15}),
        .\rot_encoder_cnt_reg[18] ({\rot_encoder_cnt_reg[18]_i_4_n_14 ,\rot_encoder_cnt_reg[18]_i_4_n_15 }));
  user_block2_position_encoder_0_0_quad2bin_jkff_1 FF2
       (.aclk(aclk),
        .aresetn(aresetn),
        .rot_b_d2(rot_b_d2),
        .rot_b_d3(rot_b_d3),
        .rot_b_d4(rot_b_d4),
        .rot_b_filt(rot_b_filt));
  user_block2_position_encoder_0_0_quad2bin_jkff_2 FF3
       (.SR(rot_encoder_cnt0),
        .aclk(aclk),
        .aresetn(aresetn),
        .tilt_z_d2(tilt_z_d2),
        .tilt_z_d3(tilt_z_d3),
        .tilt_z_d4(tilt_z_d4));
  user_block2_position_encoder_0_0_quad2bin_jkff_3 FF4
       (.D({FF4_n_1,FF4_n_2,FF4_n_3,FF4_n_4,FF4_n_5,FF4_n_6,FF4_n_7,FF4_n_8,FF4_n_9,FF4_n_10,FF4_n_11,FF4_n_12,FF4_n_13,FF4_n_14,FF4_n_15,FF4_n_16,FF4_n_17,FF4_n_18}),
        .O({\minusOp_inferred__0/i__carry__1_n_14 ,\minusOp_inferred__0/i__carry__1_n_15 }),
        .aclk(aclk),
        .aresetn(aresetn),
        .tilt_a_d2(tilt_a_d2),
        .tilt_a_d3(tilt_a_d3),
        .tilt_a_d4(tilt_a_d4),
        .tilt_a_filt(tilt_a_filt),
        .tilt_b_filt_d1(tilt_b_filt_d1),
        .\tilt_encoder_cnt_reg[0] ({\tilt_encoder_cnt_reg[16]_i_2_n_8 ,\tilt_encoder_cnt_reg[16]_i_2_n_9 ,\tilt_encoder_cnt_reg[16]_i_2_n_10 ,\tilt_encoder_cnt_reg[16]_i_2_n_11 ,\tilt_encoder_cnt_reg[16]_i_2_n_12 ,\tilt_encoder_cnt_reg[16]_i_2_n_13 ,\tilt_encoder_cnt_reg[16]_i_2_n_14 ,\tilt_encoder_cnt_reg[16]_i_2_n_15 }),
        .\tilt_encoder_cnt_reg[0]_0 ({\tilt_encoder_cnt_reg[8]_i_2_n_8 ,\tilt_encoder_cnt_reg[8]_i_2_n_9 ,\tilt_encoder_cnt_reg[8]_i_2_n_10 ,\tilt_encoder_cnt_reg[8]_i_2_n_11 ,\tilt_encoder_cnt_reg[8]_i_2_n_12 ,\tilt_encoder_cnt_reg[8]_i_2_n_13 ,\tilt_encoder_cnt_reg[8]_i_2_n_14 ,\tilt_encoder_cnt_reg[8]_i_2_n_15 }),
        .\tilt_encoder_cnt_reg[0]_1 ({\minusOp_inferred__0/i__carry_n_8 ,\minusOp_inferred__0/i__carry_n_9 ,\minusOp_inferred__0/i__carry_n_10 ,\minusOp_inferred__0/i__carry_n_11 ,\minusOp_inferred__0/i__carry_n_12 ,\minusOp_inferred__0/i__carry_n_13 ,\minusOp_inferred__0/i__carry_n_14 ,\minusOp_inferred__0/i__carry_n_15 }),
        .\tilt_encoder_cnt_reg[16] ({\minusOp_inferred__0/i__carry__0_n_8 ,\minusOp_inferred__0/i__carry__0_n_9 ,\minusOp_inferred__0/i__carry__0_n_10 ,\minusOp_inferred__0/i__carry__0_n_11 ,\minusOp_inferred__0/i__carry__0_n_12 ,\minusOp_inferred__0/i__carry__0_n_13 ,\minusOp_inferred__0/i__carry__0_n_14 ,\minusOp_inferred__0/i__carry__0_n_15 }),
        .\tilt_encoder_cnt_reg[17] (\tilt_encoder_cnt[18]_i_15_n_0 ),
        .\tilt_encoder_cnt_reg[17]_0 (\tilt_encoder_cnt[18]_i_9_n_0 ),
        .\tilt_encoder_cnt_reg[18] ({\tilt_encoder_cnt_reg[18]_i_5_n_14 ,\tilt_encoder_cnt_reg[18]_i_5_n_15 }),
        .\tilt_encoder_cnt_reg[3] (\tilt_encoder_cnt[18]_i_13_n_0 ),
        .\tilt_encoder_cnt_reg[3]_0 (\tilt_encoder_cnt[18]_i_7_n_0 ),
        .\tilt_encoder_cnt_reg[7] (\tilt_encoder_cnt[18]_i_14_n_0 ),
        .\tilt_encoder_cnt_reg[7]_0 (\tilt_encoder_cnt[18]_i_8_n_0 ),
        .\tilt_encoder_cnt_reg[8] (\tilt_encoder_cnt[18]_i_10_n_0 ));
  user_block2_position_encoder_0_0_quad2bin_jkff_4 FF5
       (.E(tilt_count_enable),
        .aclk(aclk),
        .aresetn(aresetn),
        .tilt_a_filt(tilt_a_filt),
        .tilt_a_filt_d1(tilt_a_filt_d1),
        .tilt_b_d2(tilt_b_d2),
        .tilt_b_d3(tilt_b_d3),
        .tilt_b_d4(tilt_b_d4),
        .tilt_b_filt(tilt_b_filt),
        .tilt_b_filt_d1(tilt_b_filt_d1));
  user_block2_position_encoder_0_0_quad2bin_jkff_5 FF6
       (.SR(tilt_encoder_cnt0),
        .aclk(aclk),
        .aresetn(aresetn),
        .tilt_z_d2(tilt_z_d2),
        .tilt_z_d3(tilt_z_d3),
        .tilt_z_d4(tilt_z_d4));
  FDCE \ROT_POS_reg[0] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_encoder_cnt[0]),
        .Q(pos_enc_0_0__s_net_1));
  FDCE \ROT_POS_reg[10] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_encoder_cnt[10]),
        .Q(\pos_enc_0[10] ));
  FDCE \ROT_POS_reg[11] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_encoder_cnt[11]),
        .Q(\pos_enc_0[11] ));
  FDCE \ROT_POS_reg[12] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_encoder_cnt[12]),
        .Q(\pos_enc_0[12] ));
  FDCE \ROT_POS_reg[13] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_encoder_cnt[13]),
        .Q(\pos_enc_0[13] ));
  FDCE \ROT_POS_reg[14] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_encoder_cnt[14]),
        .Q(\pos_enc_0[14] ));
  FDCE \ROT_POS_reg[15] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_encoder_cnt[15]),
        .Q(\pos_enc_0[15] ));
  FDCE \ROT_POS_reg[16] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_encoder_cnt[16]),
        .Q(\ROT_POS_reg_n_0_[16] ));
  FDCE \ROT_POS_reg[17] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_encoder_cnt[17]),
        .Q(\ROT_POS_reg_n_0_[17] ));
  FDCE \ROT_POS_reg[18] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_encoder_cnt[18]),
        .Q(\ROT_POS_reg_n_0_[18] ));
  FDCE \ROT_POS_reg[1] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_encoder_cnt[1]),
        .Q(pos_enc_0_1__s_net_1));
  FDCE \ROT_POS_reg[2] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_encoder_cnt[2]),
        .Q(pos_enc_0_2__s_net_1));
  FDCE \ROT_POS_reg[3] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_encoder_cnt[3]),
        .Q(\pos_enc_0[3] ));
  FDCE \ROT_POS_reg[4] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_encoder_cnt[4]),
        .Q(\pos_enc_0[4] ));
  FDCE \ROT_POS_reg[5] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_encoder_cnt[5]),
        .Q(\pos_enc_0[5] ));
  FDCE \ROT_POS_reg[6] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_encoder_cnt[6]),
        .Q(\pos_enc_0[6] ));
  FDCE \ROT_POS_reg[7] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_encoder_cnt[7]),
        .Q(\pos_enc_0[7] ));
  FDCE \ROT_POS_reg[8] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_encoder_cnt[8]),
        .Q(\pos_enc_0[8] ));
  FDCE \ROT_POS_reg[9] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_encoder_cnt[9]),
        .Q(\pos_enc_0[9] ));
  FDCE \TILT_POS_reg[0] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_encoder_cnt[0]),
        .Q(pos_enc_1_0__s_net_1));
  FDCE \TILT_POS_reg[10] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_encoder_cnt[10]),
        .Q(\pos_enc_1[10] ));
  FDCE \TILT_POS_reg[11] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_encoder_cnt[11]),
        .Q(\pos_enc_1[11] ));
  FDCE \TILT_POS_reg[12] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_encoder_cnt[12]),
        .Q(\pos_enc_1[12] ));
  FDCE \TILT_POS_reg[13] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_encoder_cnt[13]),
        .Q(\pos_enc_1[13] ));
  FDCE \TILT_POS_reg[14] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_encoder_cnt[14]),
        .Q(\pos_enc_1[14] ));
  FDCE \TILT_POS_reg[15] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_encoder_cnt[15]),
        .Q(\pos_enc_1[15] ));
  FDCE \TILT_POS_reg[16] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_encoder_cnt[16]),
        .Q(\TILT_POS_reg_n_0_[16] ));
  FDCE \TILT_POS_reg[17] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_encoder_cnt[17]),
        .Q(\TILT_POS_reg_n_0_[17] ));
  FDCE \TILT_POS_reg[18] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_encoder_cnt[18]),
        .Q(\TILT_POS_reg_n_0_[18] ));
  FDCE \TILT_POS_reg[1] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_encoder_cnt[1]),
        .Q(pos_enc_1_1__s_net_1));
  FDCE \TILT_POS_reg[2] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_encoder_cnt[2]),
        .Q(pos_enc_1_2__s_net_1));
  FDCE \TILT_POS_reg[3] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_encoder_cnt[3]),
        .Q(\pos_enc_1[3] ));
  FDCE \TILT_POS_reg[4] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_encoder_cnt[4]),
        .Q(\pos_enc_1[4] ));
  FDCE \TILT_POS_reg[5] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_encoder_cnt[5]),
        .Q(\pos_enc_1[5] ));
  FDCE \TILT_POS_reg[6] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_encoder_cnt[6]),
        .Q(\pos_enc_1[6] ));
  FDCE \TILT_POS_reg[7] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_encoder_cnt[7]),
        .Q(\pos_enc_1[7] ));
  FDCE \TILT_POS_reg[8] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_encoder_cnt[8]),
        .Q(\pos_enc_1[8] ));
  FDCE \TILT_POS_reg[9] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_encoder_cnt[9]),
        .Q(\pos_enc_1[9] ));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__0_i_1
       (.I0(tilt_encoder_cnt[16]),
        .O(i__carry__0_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__0_i_2
       (.I0(tilt_encoder_cnt[15]),
        .O(i__carry__0_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__0_i_3
       (.I0(tilt_encoder_cnt[14]),
        .O(i__carry__0_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__0_i_4
       (.I0(tilt_encoder_cnt[13]),
        .O(i__carry__0_i_4_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__0_i_5
       (.I0(tilt_encoder_cnt[12]),
        .O(i__carry__0_i_5_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__0_i_6
       (.I0(tilt_encoder_cnt[11]),
        .O(i__carry__0_i_6_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__0_i_7
       (.I0(tilt_encoder_cnt[10]),
        .O(i__carry__0_i_7_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__0_i_8
       (.I0(tilt_encoder_cnt[9]),
        .O(i__carry__0_i_8_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__1_i_1
       (.I0(tilt_encoder_cnt[18]),
        .O(i__carry__1_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__1_i_2
       (.I0(tilt_encoder_cnt[17]),
        .O(i__carry__1_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_1
       (.I0(tilt_encoder_cnt[8]),
        .O(i__carry_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_2
       (.I0(tilt_encoder_cnt[7]),
        .O(i__carry_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_3
       (.I0(tilt_encoder_cnt[6]),
        .O(i__carry_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_4
       (.I0(tilt_encoder_cnt[5]),
        .O(i__carry_i_4_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_5
       (.I0(tilt_encoder_cnt[4]),
        .O(i__carry_i_5_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_6
       (.I0(tilt_encoder_cnt[3]),
        .O(i__carry_i_6_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_7
       (.I0(tilt_encoder_cnt[2]),
        .O(i__carry_i_7_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_8
       (.I0(tilt_encoder_cnt[1]),
        .O(i__carry_i_8_n_0));
  CARRY8 minusOp_carry
       (.CI(rot_encoder_cnt[0]),
        .CI_TOP(1'b0),
        .CO({minusOp_carry_n_0,minusOp_carry_n_1,minusOp_carry_n_2,minusOp_carry_n_3,NLW_minusOp_carry_CO_UNCONNECTED[3],minusOp_carry_n_5,minusOp_carry_n_6,minusOp_carry_n_7}),
        .DI(rot_encoder_cnt[8:1]),
        .O({minusOp_carry_n_8,minusOp_carry_n_9,minusOp_carry_n_10,minusOp_carry_n_11,minusOp_carry_n_12,minusOp_carry_n_13,minusOp_carry_n_14,minusOp_carry_n_15}),
        .S({minusOp_carry_i_1_n_0,minusOp_carry_i_2_n_0,minusOp_carry_i_3_n_0,minusOp_carry_i_4_n_0,minusOp_carry_i_5_n_0,minusOp_carry_i_6_n_0,minusOp_carry_i_7_n_0,minusOp_carry_i_8_n_0}));
  CARRY8 minusOp_carry__0
       (.CI(minusOp_carry_n_0),
        .CI_TOP(1'b0),
        .CO({minusOp_carry__0_n_0,minusOp_carry__0_n_1,minusOp_carry__0_n_2,minusOp_carry__0_n_3,NLW_minusOp_carry__0_CO_UNCONNECTED[3],minusOp_carry__0_n_5,minusOp_carry__0_n_6,minusOp_carry__0_n_7}),
        .DI(rot_encoder_cnt[16:9]),
        .O({minusOp_carry__0_n_8,minusOp_carry__0_n_9,minusOp_carry__0_n_10,minusOp_carry__0_n_11,minusOp_carry__0_n_12,minusOp_carry__0_n_13,minusOp_carry__0_n_14,minusOp_carry__0_n_15}),
        .S({minusOp_carry__0_i_1_n_0,minusOp_carry__0_i_2_n_0,minusOp_carry__0_i_3_n_0,minusOp_carry__0_i_4_n_0,minusOp_carry__0_i_5_n_0,minusOp_carry__0_i_6_n_0,minusOp_carry__0_i_7_n_0,minusOp_carry__0_i_8_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__0_i_1
       (.I0(rot_encoder_cnt[16]),
        .O(minusOp_carry__0_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__0_i_2
       (.I0(rot_encoder_cnt[15]),
        .O(minusOp_carry__0_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__0_i_3
       (.I0(rot_encoder_cnt[14]),
        .O(minusOp_carry__0_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__0_i_4
       (.I0(rot_encoder_cnt[13]),
        .O(minusOp_carry__0_i_4_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__0_i_5
       (.I0(rot_encoder_cnt[12]),
        .O(minusOp_carry__0_i_5_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__0_i_6
       (.I0(rot_encoder_cnt[11]),
        .O(minusOp_carry__0_i_6_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__0_i_7
       (.I0(rot_encoder_cnt[10]),
        .O(minusOp_carry__0_i_7_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__0_i_8
       (.I0(rot_encoder_cnt[9]),
        .O(minusOp_carry__0_i_8_n_0));
  CARRY8 minusOp_carry__1
       (.CI(minusOp_carry__0_n_0),
        .CI_TOP(1'b0),
        .CO({NLW_minusOp_carry__1_CO_UNCONNECTED[7:1],minusOp_carry__1_n_7}),
        .DI({NLW_minusOp_carry__1_DI_UNCONNECTED[7:2],1'b0,rot_encoder_cnt[17]}),
        .O({NLW_minusOp_carry__1_O_UNCONNECTED[7:2],minusOp_carry__1_n_14,minusOp_carry__1_n_15}),
        .S({NLW_minusOp_carry__1_S_UNCONNECTED[7:2],minusOp_carry__1_i_1_n_0,minusOp_carry__1_i_2_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__1_i_1
       (.I0(rot_encoder_cnt[18]),
        .O(minusOp_carry__1_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__1_i_2
       (.I0(rot_encoder_cnt[17]),
        .O(minusOp_carry__1_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry_i_1
       (.I0(rot_encoder_cnt[8]),
        .O(minusOp_carry_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry_i_2
       (.I0(rot_encoder_cnt[7]),
        .O(minusOp_carry_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry_i_3
       (.I0(rot_encoder_cnt[6]),
        .O(minusOp_carry_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry_i_4
       (.I0(rot_encoder_cnt[5]),
        .O(minusOp_carry_i_4_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry_i_5
       (.I0(rot_encoder_cnt[4]),
        .O(minusOp_carry_i_5_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry_i_6
       (.I0(rot_encoder_cnt[3]),
        .O(minusOp_carry_i_6_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry_i_7
       (.I0(rot_encoder_cnt[2]),
        .O(minusOp_carry_i_7_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry_i_8
       (.I0(rot_encoder_cnt[1]),
        .O(minusOp_carry_i_8_n_0));
  CARRY8 \minusOp_inferred__0/i__carry 
       (.CI(tilt_encoder_cnt[0]),
        .CI_TOP(1'b0),
        .CO({\minusOp_inferred__0/i__carry_n_0 ,\minusOp_inferred__0/i__carry_n_1 ,\minusOp_inferred__0/i__carry_n_2 ,\minusOp_inferred__0/i__carry_n_3 ,\NLW_minusOp_inferred__0/i__carry_CO_UNCONNECTED [3],\minusOp_inferred__0/i__carry_n_5 ,\minusOp_inferred__0/i__carry_n_6 ,\minusOp_inferred__0/i__carry_n_7 }),
        .DI(tilt_encoder_cnt[8:1]),
        .O({\minusOp_inferred__0/i__carry_n_8 ,\minusOp_inferred__0/i__carry_n_9 ,\minusOp_inferred__0/i__carry_n_10 ,\minusOp_inferred__0/i__carry_n_11 ,\minusOp_inferred__0/i__carry_n_12 ,\minusOp_inferred__0/i__carry_n_13 ,\minusOp_inferred__0/i__carry_n_14 ,\minusOp_inferred__0/i__carry_n_15 }),
        .S({i__carry_i_1_n_0,i__carry_i_2_n_0,i__carry_i_3_n_0,i__carry_i_4_n_0,i__carry_i_5_n_0,i__carry_i_6_n_0,i__carry_i_7_n_0,i__carry_i_8_n_0}));
  CARRY8 \minusOp_inferred__0/i__carry__0 
       (.CI(\minusOp_inferred__0/i__carry_n_0 ),
        .CI_TOP(1'b0),
        .CO({\minusOp_inferred__0/i__carry__0_n_0 ,\minusOp_inferred__0/i__carry__0_n_1 ,\minusOp_inferred__0/i__carry__0_n_2 ,\minusOp_inferred__0/i__carry__0_n_3 ,\NLW_minusOp_inferred__0/i__carry__0_CO_UNCONNECTED [3],\minusOp_inferred__0/i__carry__0_n_5 ,\minusOp_inferred__0/i__carry__0_n_6 ,\minusOp_inferred__0/i__carry__0_n_7 }),
        .DI(tilt_encoder_cnt[16:9]),
        .O({\minusOp_inferred__0/i__carry__0_n_8 ,\minusOp_inferred__0/i__carry__0_n_9 ,\minusOp_inferred__0/i__carry__0_n_10 ,\minusOp_inferred__0/i__carry__0_n_11 ,\minusOp_inferred__0/i__carry__0_n_12 ,\minusOp_inferred__0/i__carry__0_n_13 ,\minusOp_inferred__0/i__carry__0_n_14 ,\minusOp_inferred__0/i__carry__0_n_15 }),
        .S({i__carry__0_i_1_n_0,i__carry__0_i_2_n_0,i__carry__0_i_3_n_0,i__carry__0_i_4_n_0,i__carry__0_i_5_n_0,i__carry__0_i_6_n_0,i__carry__0_i_7_n_0,i__carry__0_i_8_n_0}));
  CARRY8 \minusOp_inferred__0/i__carry__1 
       (.CI(\minusOp_inferred__0/i__carry__0_n_0 ),
        .CI_TOP(1'b0),
        .CO({\NLW_minusOp_inferred__0/i__carry__1_CO_UNCONNECTED [7:1],\minusOp_inferred__0/i__carry__1_n_7 }),
        .DI({\NLW_minusOp_inferred__0/i__carry__1_DI_UNCONNECTED [7:2],1'b0,tilt_encoder_cnt[17]}),
        .O({\NLW_minusOp_inferred__0/i__carry__1_O_UNCONNECTED [7:2],\minusOp_inferred__0/i__carry__1_n_14 ,\minusOp_inferred__0/i__carry__1_n_15 }),
        .S({\NLW_minusOp_inferred__0/i__carry__1_S_UNCONNECTED [7:2],i__carry__1_i_1_n_0,i__carry__1_i_2_n_0}));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pos_enc_0[16]_INST_0 
       (.I0(\ROT_POS_reg_n_0_[16] ),
        .I1(ctl_reg[0]),
        .O(pos_enc_0[0]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pos_enc_0[17]_INST_0 
       (.I0(\ROT_POS_reg_n_0_[17] ),
        .I1(ctl_reg[0]),
        .O(pos_enc_0[1]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pos_enc_0[18]_INST_0 
       (.I0(\ROT_POS_reg_n_0_[18] ),
        .I1(ctl_reg[0]),
        .O(pos_enc_0[2]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pos_enc_1[16]_INST_0 
       (.I0(\TILT_POS_reg_n_0_[16] ),
        .I1(ctl_reg[0]),
        .O(pos_enc_1[0]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pos_enc_1[17]_INST_0 
       (.I0(\TILT_POS_reg_n_0_[17] ),
        .I1(ctl_reg[0]),
        .O(pos_enc_1[1]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \pos_enc_1[18]_INST_0 
       (.I0(\TILT_POS_reg_n_0_[18] ),
        .I1(ctl_reg[0]),
        .O(pos_enc_1[2]));
  FDCE rot_a_d1_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(ROT_A),
        .Q(rot_a_d1));
  FDCE rot_a_d2_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_a_d1),
        .Q(rot_a_d2));
  FDCE rot_a_d3_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_a_d2),
        .Q(rot_a_d3));
  FDCE rot_a_d4_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_a_d3),
        .Q(rot_a_d4));
  FDCE rot_a_filt_d1_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_a_filt),
        .Q(rot_a_filt_d1));
  FDCE rot_b_d1_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(ROT_B),
        .Q(rot_b_d1));
  FDCE rot_b_d2_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_b_d1),
        .Q(rot_b_d2));
  FDCE rot_b_d3_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_b_d2),
        .Q(rot_b_d3));
  FDCE rot_b_d4_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_b_d3),
        .Q(rot_b_d4));
  FDCE rot_b_filt_d1_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(rot_b_filt),
        .Q(rot_b_filt_d1));
  LUT1 #(
    .INIT(2'h2)) 
    \rot_encoder_cnt[16]_i_10 
       (.I0(rot_encoder_cnt[9]),
        .O(\rot_encoder_cnt[16]_i_10_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \rot_encoder_cnt[16]_i_3 
       (.I0(rot_encoder_cnt[16]),
        .O(\rot_encoder_cnt[16]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \rot_encoder_cnt[16]_i_4 
       (.I0(rot_encoder_cnt[15]),
        .O(\rot_encoder_cnt[16]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \rot_encoder_cnt[16]_i_5 
       (.I0(rot_encoder_cnt[14]),
        .O(\rot_encoder_cnt[16]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \rot_encoder_cnt[16]_i_6 
       (.I0(rot_encoder_cnt[13]),
        .O(\rot_encoder_cnt[16]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \rot_encoder_cnt[16]_i_7 
       (.I0(rot_encoder_cnt[12]),
        .O(\rot_encoder_cnt[16]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \rot_encoder_cnt[16]_i_8 
       (.I0(rot_encoder_cnt[11]),
        .O(\rot_encoder_cnt[16]_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \rot_encoder_cnt[16]_i_9 
       (.I0(rot_encoder_cnt[10]),
        .O(\rot_encoder_cnt[16]_i_9_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'hFFF7)) 
    \rot_encoder_cnt[18]_i_10 
       (.I0(rot_encoder_cnt[5]),
        .I1(rot_encoder_cnt[4]),
        .I2(rot_encoder_cnt[7]),
        .I3(rot_encoder_cnt[16]),
        .O(\rot_encoder_cnt[18]_i_10_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \rot_encoder_cnt[18]_i_11 
       (.I0(rot_encoder_cnt[10]),
        .I1(rot_encoder_cnt[8]),
        .I2(rot_encoder_cnt[14]),
        .I3(rot_encoder_cnt[13]),
        .O(\rot_encoder_cnt[18]_i_11_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h7FFF)) 
    \rot_encoder_cnt[18]_i_12 
       (.I0(rot_encoder_cnt[0]),
        .I1(rot_encoder_cnt[6]),
        .I2(rot_encoder_cnt[2]),
        .I3(rot_encoder_cnt[1]),
        .O(\rot_encoder_cnt[18]_i_12_n_0 ));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \rot_encoder_cnt[18]_i_13 
       (.I0(rot_encoder_cnt[11]),
        .I1(rot_encoder_cnt[12]),
        .I2(rot_encoder_cnt[9]),
        .I3(rot_encoder_cnt[3]),
        .O(\rot_encoder_cnt[18]_i_13_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \rot_encoder_cnt[18]_i_14 
       (.I0(rot_encoder_cnt[17]),
        .I1(rot_encoder_cnt[16]),
        .I2(rot_encoder_cnt[18]),
        .O(\rot_encoder_cnt[18]_i_14_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \rot_encoder_cnt[18]_i_15 
       (.I0(rot_encoder_cnt[6]),
        .I1(rot_encoder_cnt[7]),
        .I2(rot_encoder_cnt[4]),
        .I3(rot_encoder_cnt[5]),
        .O(\rot_encoder_cnt[18]_i_15_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \rot_encoder_cnt[18]_i_16 
       (.I0(rot_encoder_cnt[2]),
        .I1(rot_encoder_cnt[3]),
        .I2(rot_encoder_cnt[0]),
        .I3(rot_encoder_cnt[1]),
        .O(\rot_encoder_cnt[18]_i_16_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \rot_encoder_cnt[18]_i_17 
       (.I0(rot_encoder_cnt[14]),
        .I1(rot_encoder_cnt[15]),
        .I2(rot_encoder_cnt[12]),
        .I3(rot_encoder_cnt[13]),
        .O(\rot_encoder_cnt[18]_i_17_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \rot_encoder_cnt[18]_i_18 
       (.I0(rot_encoder_cnt[10]),
        .I1(rot_encoder_cnt[11]),
        .I2(rot_encoder_cnt[8]),
        .I3(rot_encoder_cnt[9]),
        .O(\rot_encoder_cnt[18]_i_18_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \rot_encoder_cnt[18]_i_5 
       (.I0(\rot_encoder_cnt[18]_i_9_n_0 ),
        .I1(\rot_encoder_cnt[18]_i_10_n_0 ),
        .I2(\rot_encoder_cnt[18]_i_11_n_0 ),
        .I3(\rot_encoder_cnt[18]_i_12_n_0 ),
        .I4(\rot_encoder_cnt[18]_i_13_n_0 ),
        .O(\rot_encoder_cnt[18]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h00000001)) 
    \rot_encoder_cnt[18]_i_6 
       (.I0(\rot_encoder_cnt[18]_i_14_n_0 ),
        .I1(\rot_encoder_cnt[18]_i_15_n_0 ),
        .I2(\rot_encoder_cnt[18]_i_16_n_0 ),
        .I3(\rot_encoder_cnt[18]_i_17_n_0 ),
        .I4(\rot_encoder_cnt[18]_i_18_n_0 ),
        .O(\rot_encoder_cnt[18]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \rot_encoder_cnt[18]_i_7 
       (.I0(rot_encoder_cnt[18]),
        .O(\rot_encoder_cnt[18]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \rot_encoder_cnt[18]_i_8 
       (.I0(rot_encoder_cnt[17]),
        .O(\rot_encoder_cnt[18]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hBF)) 
    \rot_encoder_cnt[18]_i_9 
       (.I0(rot_encoder_cnt[15]),
        .I1(rot_encoder_cnt[18]),
        .I2(rot_encoder_cnt[17]),
        .O(\rot_encoder_cnt[18]_i_9_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \rot_encoder_cnt[8]_i_10 
       (.I0(rot_encoder_cnt[1]),
        .O(\rot_encoder_cnt[8]_i_10_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \rot_encoder_cnt[8]_i_3 
       (.I0(rot_encoder_cnt[8]),
        .O(\rot_encoder_cnt[8]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \rot_encoder_cnt[8]_i_4 
       (.I0(rot_encoder_cnt[7]),
        .O(\rot_encoder_cnt[8]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \rot_encoder_cnt[8]_i_5 
       (.I0(rot_encoder_cnt[6]),
        .O(\rot_encoder_cnt[8]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \rot_encoder_cnt[8]_i_6 
       (.I0(rot_encoder_cnt[5]),
        .O(\rot_encoder_cnt[8]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \rot_encoder_cnt[8]_i_7 
       (.I0(rot_encoder_cnt[4]),
        .O(\rot_encoder_cnt[8]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \rot_encoder_cnt[8]_i_8 
       (.I0(rot_encoder_cnt[3]),
        .O(\rot_encoder_cnt[8]_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \rot_encoder_cnt[8]_i_9 
       (.I0(rot_encoder_cnt[2]),
        .O(\rot_encoder_cnt[8]_i_9_n_0 ));
  FDRE \rot_encoder_cnt_reg[0] 
       (.C(aclk),
        .CE(rot_count_enable),
        .D(p_0_in[0]),
        .Q(rot_encoder_cnt[0]),
        .R(rot_encoder_cnt0));
  FDRE \rot_encoder_cnt_reg[10] 
       (.C(aclk),
        .CE(rot_count_enable),
        .D(p_0_in[10]),
        .Q(rot_encoder_cnt[10]),
        .R(rot_encoder_cnt0));
  FDRE \rot_encoder_cnt_reg[11] 
       (.C(aclk),
        .CE(rot_count_enable),
        .D(p_0_in[11]),
        .Q(rot_encoder_cnt[11]),
        .R(rot_encoder_cnt0));
  FDRE \rot_encoder_cnt_reg[12] 
       (.C(aclk),
        .CE(rot_count_enable),
        .D(p_0_in[12]),
        .Q(rot_encoder_cnt[12]),
        .R(rot_encoder_cnt0));
  FDRE \rot_encoder_cnt_reg[13] 
       (.C(aclk),
        .CE(rot_count_enable),
        .D(p_0_in[13]),
        .Q(rot_encoder_cnt[13]),
        .R(rot_encoder_cnt0));
  FDRE \rot_encoder_cnt_reg[14] 
       (.C(aclk),
        .CE(rot_count_enable),
        .D(p_0_in[14]),
        .Q(rot_encoder_cnt[14]),
        .R(rot_encoder_cnt0));
  FDRE \rot_encoder_cnt_reg[15] 
       (.C(aclk),
        .CE(rot_count_enable),
        .D(p_0_in[15]),
        .Q(rot_encoder_cnt[15]),
        .R(rot_encoder_cnt0));
  FDRE \rot_encoder_cnt_reg[16] 
       (.C(aclk),
        .CE(rot_count_enable),
        .D(p_0_in[16]),
        .Q(rot_encoder_cnt[16]),
        .R(rot_encoder_cnt0));
  CARRY8 \rot_encoder_cnt_reg[16]_i_2 
       (.CI(\rot_encoder_cnt_reg[8]_i_2_n_0 ),
        .CI_TOP(1'b0),
        .CO({\rot_encoder_cnt_reg[16]_i_2_n_0 ,\rot_encoder_cnt_reg[16]_i_2_n_1 ,\rot_encoder_cnt_reg[16]_i_2_n_2 ,\rot_encoder_cnt_reg[16]_i_2_n_3 ,\NLW_rot_encoder_cnt_reg[16]_i_2_CO_UNCONNECTED [3],\rot_encoder_cnt_reg[16]_i_2_n_5 ,\rot_encoder_cnt_reg[16]_i_2_n_6 ,\rot_encoder_cnt_reg[16]_i_2_n_7 }),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .O({\rot_encoder_cnt_reg[16]_i_2_n_8 ,\rot_encoder_cnt_reg[16]_i_2_n_9 ,\rot_encoder_cnt_reg[16]_i_2_n_10 ,\rot_encoder_cnt_reg[16]_i_2_n_11 ,\rot_encoder_cnt_reg[16]_i_2_n_12 ,\rot_encoder_cnt_reg[16]_i_2_n_13 ,\rot_encoder_cnt_reg[16]_i_2_n_14 ,\rot_encoder_cnt_reg[16]_i_2_n_15 }),
        .S({\rot_encoder_cnt[16]_i_3_n_0 ,\rot_encoder_cnt[16]_i_4_n_0 ,\rot_encoder_cnt[16]_i_5_n_0 ,\rot_encoder_cnt[16]_i_6_n_0 ,\rot_encoder_cnt[16]_i_7_n_0 ,\rot_encoder_cnt[16]_i_8_n_0 ,\rot_encoder_cnt[16]_i_9_n_0 ,\rot_encoder_cnt[16]_i_10_n_0 }));
  FDRE \rot_encoder_cnt_reg[17] 
       (.C(aclk),
        .CE(rot_count_enable),
        .D(p_0_in[17]),
        .Q(rot_encoder_cnt[17]),
        .R(rot_encoder_cnt0));
  FDRE \rot_encoder_cnt_reg[18] 
       (.C(aclk),
        .CE(rot_count_enable),
        .D(p_0_in[18]),
        .Q(rot_encoder_cnt[18]),
        .R(rot_encoder_cnt0));
  CARRY8 \rot_encoder_cnt_reg[18]_i_4 
       (.CI(\rot_encoder_cnt_reg[16]_i_2_n_0 ),
        .CI_TOP(1'b0),
        .CO({\NLW_rot_encoder_cnt_reg[18]_i_4_CO_UNCONNECTED [7:1],\rot_encoder_cnt_reg[18]_i_4_n_7 }),
        .DI({\NLW_rot_encoder_cnt_reg[18]_i_4_DI_UNCONNECTED [7:2],1'b0,1'b0}),
        .O({\NLW_rot_encoder_cnt_reg[18]_i_4_O_UNCONNECTED [7:2],\rot_encoder_cnt_reg[18]_i_4_n_14 ,\rot_encoder_cnt_reg[18]_i_4_n_15 }),
        .S({\NLW_rot_encoder_cnt_reg[18]_i_4_S_UNCONNECTED [7:2],\rot_encoder_cnt[18]_i_7_n_0 ,\rot_encoder_cnt[18]_i_8_n_0 }));
  FDRE \rot_encoder_cnt_reg[1] 
       (.C(aclk),
        .CE(rot_count_enable),
        .D(p_0_in[1]),
        .Q(rot_encoder_cnt[1]),
        .R(rot_encoder_cnt0));
  FDRE \rot_encoder_cnt_reg[2] 
       (.C(aclk),
        .CE(rot_count_enable),
        .D(p_0_in[2]),
        .Q(rot_encoder_cnt[2]),
        .R(rot_encoder_cnt0));
  FDRE \rot_encoder_cnt_reg[3] 
       (.C(aclk),
        .CE(rot_count_enable),
        .D(p_0_in[3]),
        .Q(rot_encoder_cnt[3]),
        .R(rot_encoder_cnt0));
  FDRE \rot_encoder_cnt_reg[4] 
       (.C(aclk),
        .CE(rot_count_enable),
        .D(p_0_in[4]),
        .Q(rot_encoder_cnt[4]),
        .R(rot_encoder_cnt0));
  FDRE \rot_encoder_cnt_reg[5] 
       (.C(aclk),
        .CE(rot_count_enable),
        .D(p_0_in[5]),
        .Q(rot_encoder_cnt[5]),
        .R(rot_encoder_cnt0));
  FDRE \rot_encoder_cnt_reg[6] 
       (.C(aclk),
        .CE(rot_count_enable),
        .D(p_0_in[6]),
        .Q(rot_encoder_cnt[6]),
        .R(rot_encoder_cnt0));
  FDRE \rot_encoder_cnt_reg[7] 
       (.C(aclk),
        .CE(rot_count_enable),
        .D(p_0_in[7]),
        .Q(rot_encoder_cnt[7]),
        .R(rot_encoder_cnt0));
  FDRE \rot_encoder_cnt_reg[8] 
       (.C(aclk),
        .CE(rot_count_enable),
        .D(p_0_in[8]),
        .Q(rot_encoder_cnt[8]),
        .R(rot_encoder_cnt0));
  CARRY8 \rot_encoder_cnt_reg[8]_i_2 
       (.CI(rot_encoder_cnt[0]),
        .CI_TOP(1'b0),
        .CO({\rot_encoder_cnt_reg[8]_i_2_n_0 ,\rot_encoder_cnt_reg[8]_i_2_n_1 ,\rot_encoder_cnt_reg[8]_i_2_n_2 ,\rot_encoder_cnt_reg[8]_i_2_n_3 ,\NLW_rot_encoder_cnt_reg[8]_i_2_CO_UNCONNECTED [3],\rot_encoder_cnt_reg[8]_i_2_n_5 ,\rot_encoder_cnt_reg[8]_i_2_n_6 ,\rot_encoder_cnt_reg[8]_i_2_n_7 }),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .O({\rot_encoder_cnt_reg[8]_i_2_n_8 ,\rot_encoder_cnt_reg[8]_i_2_n_9 ,\rot_encoder_cnt_reg[8]_i_2_n_10 ,\rot_encoder_cnt_reg[8]_i_2_n_11 ,\rot_encoder_cnt_reg[8]_i_2_n_12 ,\rot_encoder_cnt_reg[8]_i_2_n_13 ,\rot_encoder_cnt_reg[8]_i_2_n_14 ,\rot_encoder_cnt_reg[8]_i_2_n_15 }),
        .S({\rot_encoder_cnt[8]_i_3_n_0 ,\rot_encoder_cnt[8]_i_4_n_0 ,\rot_encoder_cnt[8]_i_5_n_0 ,\rot_encoder_cnt[8]_i_6_n_0 ,\rot_encoder_cnt[8]_i_7_n_0 ,\rot_encoder_cnt[8]_i_8_n_0 ,\rot_encoder_cnt[8]_i_9_n_0 ,\rot_encoder_cnt[8]_i_10_n_0 }));
  FDRE \rot_encoder_cnt_reg[9] 
       (.C(aclk),
        .CE(rot_count_enable),
        .D(p_0_in[9]),
        .Q(rot_encoder_cnt[9]),
        .R(rot_encoder_cnt0));
  FDCE rot_z_d1_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(ctl_reg[1]),
        .Q(tilt_z_d1));
  FDCE rot_z_d2_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_z_d1),
        .Q(tilt_z_d2));
  FDCE rot_z_d3_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_z_d2),
        .Q(tilt_z_d3));
  FDCE rot_z_d4_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_z_d3),
        .Q(tilt_z_d4));
  FDCE tilt_a_d1_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(TILT_A),
        .Q(tilt_a_d1));
  FDCE tilt_a_d2_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_a_d1),
        .Q(tilt_a_d2));
  FDCE tilt_a_d3_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_a_d2),
        .Q(tilt_a_d3));
  FDCE tilt_a_d4_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_a_d3),
        .Q(tilt_a_d4));
  FDCE tilt_a_filt_d1_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_a_filt),
        .Q(tilt_a_filt_d1));
  FDCE tilt_b_d1_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(TILT_B),
        .Q(tilt_b_d1));
  FDCE tilt_b_d2_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_b_d1),
        .Q(tilt_b_d2));
  FDCE tilt_b_d3_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_b_d2),
        .Q(tilt_b_d3));
  FDCE tilt_b_d4_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_b_d3),
        .Q(tilt_b_d4));
  FDCE tilt_b_filt_d1_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(tilt_b_filt),
        .Q(tilt_b_filt_d1));
  LUT1 #(
    .INIT(2'h1)) 
    \tilt_encoder_cnt[0]_i_1 
       (.I0(tilt_encoder_cnt[0]),
        .O(\tilt_encoder_cnt[0]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \tilt_encoder_cnt[16]_i_10 
       (.I0(tilt_encoder_cnt[9]),
        .O(\tilt_encoder_cnt[16]_i_10_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \tilt_encoder_cnt[16]_i_3 
       (.I0(tilt_encoder_cnt[16]),
        .O(\tilt_encoder_cnt[16]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \tilt_encoder_cnt[16]_i_4 
       (.I0(tilt_encoder_cnt[15]),
        .O(\tilt_encoder_cnt[16]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \tilt_encoder_cnt[16]_i_5 
       (.I0(tilt_encoder_cnt[14]),
        .O(\tilt_encoder_cnt[16]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \tilt_encoder_cnt[16]_i_6 
       (.I0(tilt_encoder_cnt[13]),
        .O(\tilt_encoder_cnt[16]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \tilt_encoder_cnt[16]_i_7 
       (.I0(tilt_encoder_cnt[12]),
        .O(\tilt_encoder_cnt[16]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \tilt_encoder_cnt[16]_i_8 
       (.I0(tilt_encoder_cnt[11]),
        .O(\tilt_encoder_cnt[16]_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \tilt_encoder_cnt[16]_i_9 
       (.I0(tilt_encoder_cnt[10]),
        .O(\tilt_encoder_cnt[16]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \tilt_encoder_cnt[18]_i_10 
       (.I0(tilt_encoder_cnt[8]),
        .I1(tilt_encoder_cnt[13]),
        .I2(tilt_encoder_cnt[15]),
        .I3(tilt_encoder_cnt[11]),
        .I4(tilt_encoder_cnt[10]),
        .O(\tilt_encoder_cnt[18]_i_10_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \tilt_encoder_cnt[18]_i_11 
       (.I0(tilt_encoder_cnt[18]),
        .O(\tilt_encoder_cnt[18]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \tilt_encoder_cnt[18]_i_12 
       (.I0(tilt_encoder_cnt[17]),
        .O(\tilt_encoder_cnt[18]_i_12_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h7FFF)) 
    \tilt_encoder_cnt[18]_i_13 
       (.I0(tilt_encoder_cnt[3]),
        .I1(tilt_encoder_cnt[2]),
        .I2(tilt_encoder_cnt[5]),
        .I3(tilt_encoder_cnt[4]),
        .O(\tilt_encoder_cnt[18]_i_13_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h7FFF)) 
    \tilt_encoder_cnt[18]_i_14 
       (.I0(tilt_encoder_cnt[7]),
        .I1(tilt_encoder_cnt[6]),
        .I2(tilt_encoder_cnt[12]),
        .I3(tilt_encoder_cnt[9]),
        .O(\tilt_encoder_cnt[18]_i_14_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \tilt_encoder_cnt[18]_i_15 
       (.I0(tilt_encoder_cnt[17]),
        .I1(tilt_encoder_cnt[18]),
        .I2(tilt_encoder_cnt[14]),
        .I3(tilt_encoder_cnt[16]),
        .I4(tilt_encoder_cnt[1]),
        .I5(tilt_encoder_cnt[0]),
        .O(\tilt_encoder_cnt[18]_i_15_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \tilt_encoder_cnt[18]_i_7 
       (.I0(tilt_encoder_cnt[3]),
        .I1(tilt_encoder_cnt[2]),
        .I2(tilt_encoder_cnt[5]),
        .I3(tilt_encoder_cnt[4]),
        .O(\tilt_encoder_cnt[18]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \tilt_encoder_cnt[18]_i_8 
       (.I0(tilt_encoder_cnt[7]),
        .I1(tilt_encoder_cnt[6]),
        .I2(tilt_encoder_cnt[12]),
        .I3(tilt_encoder_cnt[9]),
        .O(\tilt_encoder_cnt[18]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \tilt_encoder_cnt[18]_i_9 
       (.I0(tilt_encoder_cnt[17]),
        .I1(tilt_encoder_cnt[18]),
        .I2(tilt_encoder_cnt[14]),
        .I3(tilt_encoder_cnt[16]),
        .I4(tilt_encoder_cnt[1]),
        .I5(tilt_encoder_cnt[0]),
        .O(\tilt_encoder_cnt[18]_i_9_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \tilt_encoder_cnt[8]_i_10 
       (.I0(tilt_encoder_cnt[1]),
        .O(\tilt_encoder_cnt[8]_i_10_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \tilt_encoder_cnt[8]_i_3 
       (.I0(tilt_encoder_cnt[8]),
        .O(\tilt_encoder_cnt[8]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \tilt_encoder_cnt[8]_i_4 
       (.I0(tilt_encoder_cnt[7]),
        .O(\tilt_encoder_cnt[8]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \tilt_encoder_cnt[8]_i_5 
       (.I0(tilt_encoder_cnt[6]),
        .O(\tilt_encoder_cnt[8]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \tilt_encoder_cnt[8]_i_6 
       (.I0(tilt_encoder_cnt[5]),
        .O(\tilt_encoder_cnt[8]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \tilt_encoder_cnt[8]_i_7 
       (.I0(tilt_encoder_cnt[4]),
        .O(\tilt_encoder_cnt[8]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \tilt_encoder_cnt[8]_i_8 
       (.I0(tilt_encoder_cnt[3]),
        .O(\tilt_encoder_cnt[8]_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \tilt_encoder_cnt[8]_i_9 
       (.I0(tilt_encoder_cnt[2]),
        .O(\tilt_encoder_cnt[8]_i_9_n_0 ));
  FDRE \tilt_encoder_cnt_reg[0] 
       (.C(aclk),
        .CE(tilt_count_enable),
        .D(\tilt_encoder_cnt[0]_i_1_n_0 ),
        .Q(tilt_encoder_cnt[0]),
        .R(tilt_encoder_cnt0));
  FDRE \tilt_encoder_cnt_reg[10] 
       (.C(aclk),
        .CE(tilt_count_enable),
        .D(FF4_n_9),
        .Q(tilt_encoder_cnt[10]),
        .R(tilt_encoder_cnt0));
  FDRE \tilt_encoder_cnt_reg[11] 
       (.C(aclk),
        .CE(tilt_count_enable),
        .D(FF4_n_8),
        .Q(tilt_encoder_cnt[11]),
        .R(tilt_encoder_cnt0));
  FDRE \tilt_encoder_cnt_reg[12] 
       (.C(aclk),
        .CE(tilt_count_enable),
        .D(FF4_n_7),
        .Q(tilt_encoder_cnt[12]),
        .R(tilt_encoder_cnt0));
  FDRE \tilt_encoder_cnt_reg[13] 
       (.C(aclk),
        .CE(tilt_count_enable),
        .D(FF4_n_6),
        .Q(tilt_encoder_cnt[13]),
        .R(tilt_encoder_cnt0));
  FDRE \tilt_encoder_cnt_reg[14] 
       (.C(aclk),
        .CE(tilt_count_enable),
        .D(FF4_n_5),
        .Q(tilt_encoder_cnt[14]),
        .R(tilt_encoder_cnt0));
  FDRE \tilt_encoder_cnt_reg[15] 
       (.C(aclk),
        .CE(tilt_count_enable),
        .D(FF4_n_4),
        .Q(tilt_encoder_cnt[15]),
        .R(tilt_encoder_cnt0));
  FDRE \tilt_encoder_cnt_reg[16] 
       (.C(aclk),
        .CE(tilt_count_enable),
        .D(FF4_n_3),
        .Q(tilt_encoder_cnt[16]),
        .R(tilt_encoder_cnt0));
  CARRY8 \tilt_encoder_cnt_reg[16]_i_2 
       (.CI(\tilt_encoder_cnt_reg[8]_i_2_n_0 ),
        .CI_TOP(1'b0),
        .CO({\tilt_encoder_cnt_reg[16]_i_2_n_0 ,\tilt_encoder_cnt_reg[16]_i_2_n_1 ,\tilt_encoder_cnt_reg[16]_i_2_n_2 ,\tilt_encoder_cnt_reg[16]_i_2_n_3 ,\NLW_tilt_encoder_cnt_reg[16]_i_2_CO_UNCONNECTED [3],\tilt_encoder_cnt_reg[16]_i_2_n_5 ,\tilt_encoder_cnt_reg[16]_i_2_n_6 ,\tilt_encoder_cnt_reg[16]_i_2_n_7 }),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .O({\tilt_encoder_cnt_reg[16]_i_2_n_8 ,\tilt_encoder_cnt_reg[16]_i_2_n_9 ,\tilt_encoder_cnt_reg[16]_i_2_n_10 ,\tilt_encoder_cnt_reg[16]_i_2_n_11 ,\tilt_encoder_cnt_reg[16]_i_2_n_12 ,\tilt_encoder_cnt_reg[16]_i_2_n_13 ,\tilt_encoder_cnt_reg[16]_i_2_n_14 ,\tilt_encoder_cnt_reg[16]_i_2_n_15 }),
        .S({\tilt_encoder_cnt[16]_i_3_n_0 ,\tilt_encoder_cnt[16]_i_4_n_0 ,\tilt_encoder_cnt[16]_i_5_n_0 ,\tilt_encoder_cnt[16]_i_6_n_0 ,\tilt_encoder_cnt[16]_i_7_n_0 ,\tilt_encoder_cnt[16]_i_8_n_0 ,\tilt_encoder_cnt[16]_i_9_n_0 ,\tilt_encoder_cnt[16]_i_10_n_0 }));
  FDRE \tilt_encoder_cnt_reg[17] 
       (.C(aclk),
        .CE(tilt_count_enable),
        .D(FF4_n_2),
        .Q(tilt_encoder_cnt[17]),
        .R(tilt_encoder_cnt0));
  FDRE \tilt_encoder_cnt_reg[18] 
       (.C(aclk),
        .CE(tilt_count_enable),
        .D(FF4_n_1),
        .Q(tilt_encoder_cnt[18]),
        .R(tilt_encoder_cnt0));
  CARRY8 \tilt_encoder_cnt_reg[18]_i_5 
       (.CI(\tilt_encoder_cnt_reg[16]_i_2_n_0 ),
        .CI_TOP(1'b0),
        .CO({\NLW_tilt_encoder_cnt_reg[18]_i_5_CO_UNCONNECTED [7:1],\tilt_encoder_cnt_reg[18]_i_5_n_7 }),
        .DI({\NLW_tilt_encoder_cnt_reg[18]_i_5_DI_UNCONNECTED [7:2],1'b0,1'b0}),
        .O({\NLW_tilt_encoder_cnt_reg[18]_i_5_O_UNCONNECTED [7:2],\tilt_encoder_cnt_reg[18]_i_5_n_14 ,\tilt_encoder_cnt_reg[18]_i_5_n_15 }),
        .S({\NLW_tilt_encoder_cnt_reg[18]_i_5_S_UNCONNECTED [7:2],\tilt_encoder_cnt[18]_i_11_n_0 ,\tilt_encoder_cnt[18]_i_12_n_0 }));
  FDRE \tilt_encoder_cnt_reg[1] 
       (.C(aclk),
        .CE(tilt_count_enable),
        .D(FF4_n_18),
        .Q(tilt_encoder_cnt[1]),
        .R(tilt_encoder_cnt0));
  FDRE \tilt_encoder_cnt_reg[2] 
       (.C(aclk),
        .CE(tilt_count_enable),
        .D(FF4_n_17),
        .Q(tilt_encoder_cnt[2]),
        .R(tilt_encoder_cnt0));
  FDRE \tilt_encoder_cnt_reg[3] 
       (.C(aclk),
        .CE(tilt_count_enable),
        .D(FF4_n_16),
        .Q(tilt_encoder_cnt[3]),
        .R(tilt_encoder_cnt0));
  FDRE \tilt_encoder_cnt_reg[4] 
       (.C(aclk),
        .CE(tilt_count_enable),
        .D(FF4_n_15),
        .Q(tilt_encoder_cnt[4]),
        .R(tilt_encoder_cnt0));
  FDRE \tilt_encoder_cnt_reg[5] 
       (.C(aclk),
        .CE(tilt_count_enable),
        .D(FF4_n_14),
        .Q(tilt_encoder_cnt[5]),
        .R(tilt_encoder_cnt0));
  FDRE \tilt_encoder_cnt_reg[6] 
       (.C(aclk),
        .CE(tilt_count_enable),
        .D(FF4_n_13),
        .Q(tilt_encoder_cnt[6]),
        .R(tilt_encoder_cnt0));
  FDRE \tilt_encoder_cnt_reg[7] 
       (.C(aclk),
        .CE(tilt_count_enable),
        .D(FF4_n_12),
        .Q(tilt_encoder_cnt[7]),
        .R(tilt_encoder_cnt0));
  FDRE \tilt_encoder_cnt_reg[8] 
       (.C(aclk),
        .CE(tilt_count_enable),
        .D(FF4_n_11),
        .Q(tilt_encoder_cnt[8]),
        .R(tilt_encoder_cnt0));
  CARRY8 \tilt_encoder_cnt_reg[8]_i_2 
       (.CI(tilt_encoder_cnt[0]),
        .CI_TOP(1'b0),
        .CO({\tilt_encoder_cnt_reg[8]_i_2_n_0 ,\tilt_encoder_cnt_reg[8]_i_2_n_1 ,\tilt_encoder_cnt_reg[8]_i_2_n_2 ,\tilt_encoder_cnt_reg[8]_i_2_n_3 ,\NLW_tilt_encoder_cnt_reg[8]_i_2_CO_UNCONNECTED [3],\tilt_encoder_cnt_reg[8]_i_2_n_5 ,\tilt_encoder_cnt_reg[8]_i_2_n_6 ,\tilt_encoder_cnt_reg[8]_i_2_n_7 }),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .O({\tilt_encoder_cnt_reg[8]_i_2_n_8 ,\tilt_encoder_cnt_reg[8]_i_2_n_9 ,\tilt_encoder_cnt_reg[8]_i_2_n_10 ,\tilt_encoder_cnt_reg[8]_i_2_n_11 ,\tilt_encoder_cnt_reg[8]_i_2_n_12 ,\tilt_encoder_cnt_reg[8]_i_2_n_13 ,\tilt_encoder_cnt_reg[8]_i_2_n_14 ,\tilt_encoder_cnt_reg[8]_i_2_n_15 }),
        .S({\tilt_encoder_cnt[8]_i_3_n_0 ,\tilt_encoder_cnt[8]_i_4_n_0 ,\tilt_encoder_cnt[8]_i_5_n_0 ,\tilt_encoder_cnt[8]_i_6_n_0 ,\tilt_encoder_cnt[8]_i_7_n_0 ,\tilt_encoder_cnt[8]_i_8_n_0 ,\tilt_encoder_cnt[8]_i_9_n_0 ,\tilt_encoder_cnt[8]_i_10_n_0 }));
  FDRE \tilt_encoder_cnt_reg[9] 
       (.C(aclk),
        .CE(tilt_count_enable),
        .D(FF4_n_10),
        .Q(tilt_encoder_cnt[9]),
        .R(tilt_encoder_cnt0));
endmodule

(* ORIG_REF_NAME = "position_encoder" *) 
module user_block2_position_encoder_0_0_position_encoder
   (pos_enc_0,
    pos_enc_1,
    ctl_reg,
    aclk,
    aresetn,
    ROT_A,
    ROT_B,
    TILT_B,
    TILT_A,
    AZ_SCK,
    AZ_SSEL,
    EL_SCK,
    EL_SSEL,
    AZ_MOSI,
    EL_MOSI);
  output [18:0]pos_enc_0;
  output [18:0]pos_enc_1;
  input [1:0]ctl_reg;
  input aclk;
  input aresetn;
  input ROT_A;
  input ROT_B;
  input TILT_B;
  input TILT_A;
  input AZ_SCK;
  input AZ_SSEL;
  input EL_SCK;
  input EL_SSEL;
  input AZ_MOSI;
  input EL_MOSI;

  wire AZ_MOSI;
  wire AZ_SCK;
  wire AZ_SSEL;
  wire EL_MOSI;
  wire EL_SCK;
  wire EL_SSEL;
  wire Q2B_n_10;
  wire Q2B_n_11;
  wire Q2B_n_12;
  wire Q2B_n_13;
  wire Q2B_n_14;
  wire Q2B_n_15;
  wire Q2B_n_16;
  wire Q2B_n_17;
  wire Q2B_n_18;
  wire Q2B_n_19;
  wire Q2B_n_20;
  wire Q2B_n_21;
  wire Q2B_n_22;
  wire Q2B_n_23;
  wire Q2B_n_24;
  wire Q2B_n_25;
  wire Q2B_n_26;
  wire Q2B_n_27;
  wire Q2B_n_28;
  wire Q2B_n_29;
  wire Q2B_n_30;
  wire Q2B_n_31;
  wire Q2B_n_32;
  wire Q2B_n_33;
  wire Q2B_n_34;
  wire Q2B_n_35;
  wire Q2B_n_36;
  wire Q2B_n_37;
  wire Q2B_n_6;
  wire Q2B_n_7;
  wire Q2B_n_8;
  wire Q2B_n_9;
  wire ROT_A;
  wire ROT_B;
  wire S2B_n_0;
  wire S2B_n_1;
  wire S2B_n_10;
  wire S2B_n_11;
  wire S2B_n_12;
  wire S2B_n_13;
  wire S2B_n_14;
  wire S2B_n_15;
  wire S2B_n_16;
  wire S2B_n_17;
  wire S2B_n_18;
  wire S2B_n_19;
  wire S2B_n_2;
  wire S2B_n_20;
  wire S2B_n_21;
  wire S2B_n_22;
  wire S2B_n_23;
  wire S2B_n_24;
  wire S2B_n_25;
  wire S2B_n_26;
  wire S2B_n_27;
  wire S2B_n_28;
  wire S2B_n_29;
  wire S2B_n_3;
  wire S2B_n_30;
  wire S2B_n_31;
  wire S2B_n_4;
  wire S2B_n_5;
  wire S2B_n_6;
  wire S2B_n_7;
  wire S2B_n_8;
  wire S2B_n_9;
  wire TILT_A;
  wire TILT_B;
  wire aclk;
  wire aresetn;
  wire [1:0]ctl_reg;
  wire [18:0]pos_enc_0;
  wire [18:0]pos_enc_1;

  user_block2_position_encoder_0_0_QUAD2BIN Q2B
       (.ROT_A(ROT_A),
        .ROT_B(ROT_B),
        .TILT_A(TILT_A),
        .TILT_B(TILT_B),
        .aclk(aclk),
        .aresetn(aresetn),
        .ctl_reg(ctl_reg),
        .pos_enc_0(pos_enc_0[18:16]),
        .\pos_enc_0[10] (Q2B_n_11),
        .\pos_enc_0[11] (Q2B_n_10),
        .\pos_enc_0[12] (Q2B_n_9),
        .\pos_enc_0[13] (Q2B_n_8),
        .\pos_enc_0[14] (Q2B_n_7),
        .\pos_enc_0[15] (Q2B_n_6),
        .\pos_enc_0[3] (Q2B_n_18),
        .\pos_enc_0[4] (Q2B_n_17),
        .\pos_enc_0[5] (Q2B_n_16),
        .\pos_enc_0[6] (Q2B_n_15),
        .\pos_enc_0[7] (Q2B_n_14),
        .\pos_enc_0[8] (Q2B_n_13),
        .\pos_enc_0[9] (Q2B_n_12),
        .pos_enc_0_0__s_port_(Q2B_n_21),
        .pos_enc_0_1__s_port_(Q2B_n_20),
        .pos_enc_0_2__s_port_(Q2B_n_19),
        .pos_enc_1(pos_enc_1[18:16]),
        .\pos_enc_1[10] (Q2B_n_27),
        .\pos_enc_1[11] (Q2B_n_26),
        .\pos_enc_1[12] (Q2B_n_25),
        .\pos_enc_1[13] (Q2B_n_24),
        .\pos_enc_1[14] (Q2B_n_23),
        .\pos_enc_1[15] (Q2B_n_22),
        .\pos_enc_1[3] (Q2B_n_34),
        .\pos_enc_1[4] (Q2B_n_33),
        .\pos_enc_1[5] (Q2B_n_32),
        .\pos_enc_1[6] (Q2B_n_31),
        .\pos_enc_1[7] (Q2B_n_30),
        .\pos_enc_1[8] (Q2B_n_29),
        .\pos_enc_1[9] (Q2B_n_28),
        .pos_enc_1_0__s_port_(Q2B_n_37),
        .pos_enc_1_1__s_port_(Q2B_n_36),
        .pos_enc_1_2__s_port_(Q2B_n_35));
  user_block2_position_encoder_0_0_ser2bin S2B
       (.AZ_MOSI(AZ_MOSI),
        .AZ_SCK(AZ_SCK),
        .AZ_SSEL(AZ_SSEL),
        .EL_MOSI(EL_MOSI),
        .EL_SCK(EL_SCK),
        .EL_SSEL(EL_SSEL),
        .aclk(aclk),
        .aresetn(aresetn),
        .\pos_enc_0[0] (S2B_n_15),
        .\pos_enc_0[10] (S2B_n_5),
        .\pos_enc_0[11] (S2B_n_4),
        .\pos_enc_0[12] (S2B_n_3),
        .\pos_enc_0[13] (S2B_n_2),
        .\pos_enc_0[14] (S2B_n_1),
        .\pos_enc_0[15] (S2B_n_0),
        .\pos_enc_0[1] (S2B_n_14),
        .\pos_enc_0[2] (S2B_n_13),
        .\pos_enc_0[3] (S2B_n_12),
        .\pos_enc_0[4] (S2B_n_11),
        .\pos_enc_0[5] (S2B_n_10),
        .\pos_enc_0[6] (S2B_n_9),
        .\pos_enc_0[7] (S2B_n_8),
        .\pos_enc_0[8] (S2B_n_7),
        .\pos_enc_0[9] (S2B_n_6),
        .\pos_enc_1[0] (S2B_n_31),
        .\pos_enc_1[10] (S2B_n_21),
        .\pos_enc_1[11] (S2B_n_20),
        .\pos_enc_1[12] (S2B_n_19),
        .\pos_enc_1[13] (S2B_n_18),
        .\pos_enc_1[14] (S2B_n_17),
        .\pos_enc_1[15] (S2B_n_16),
        .\pos_enc_1[1] (S2B_n_30),
        .\pos_enc_1[2] (S2B_n_29),
        .\pos_enc_1[3] (S2B_n_28),
        .\pos_enc_1[4] (S2B_n_27),
        .\pos_enc_1[5] (S2B_n_26),
        .\pos_enc_1[6] (S2B_n_25),
        .\pos_enc_1[7] (S2B_n_24),
        .\pos_enc_1[8] (S2B_n_23),
        .\pos_enc_1[9] (S2B_n_22));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_0[0]_INST_0 
       (.I0(S2B_n_15),
        .I1(Q2B_n_21),
        .I2(ctl_reg[0]),
        .O(pos_enc_0[0]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_0[10]_INST_0 
       (.I0(S2B_n_5),
        .I1(Q2B_n_11),
        .I2(ctl_reg[0]),
        .O(pos_enc_0[10]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_0[11]_INST_0 
       (.I0(S2B_n_4),
        .I1(Q2B_n_10),
        .I2(ctl_reg[0]),
        .O(pos_enc_0[11]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_0[12]_INST_0 
       (.I0(S2B_n_3),
        .I1(Q2B_n_9),
        .I2(ctl_reg[0]),
        .O(pos_enc_0[12]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_0[13]_INST_0 
       (.I0(S2B_n_2),
        .I1(Q2B_n_8),
        .I2(ctl_reg[0]),
        .O(pos_enc_0[13]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_0[14]_INST_0 
       (.I0(S2B_n_1),
        .I1(Q2B_n_7),
        .I2(ctl_reg[0]),
        .O(pos_enc_0[14]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_0[15]_INST_0 
       (.I0(S2B_n_0),
        .I1(Q2B_n_6),
        .I2(ctl_reg[0]),
        .O(pos_enc_0[15]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_0[1]_INST_0 
       (.I0(S2B_n_14),
        .I1(Q2B_n_20),
        .I2(ctl_reg[0]),
        .O(pos_enc_0[1]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_0[2]_INST_0 
       (.I0(S2B_n_13),
        .I1(Q2B_n_19),
        .I2(ctl_reg[0]),
        .O(pos_enc_0[2]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_0[3]_INST_0 
       (.I0(S2B_n_12),
        .I1(Q2B_n_18),
        .I2(ctl_reg[0]),
        .O(pos_enc_0[3]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_0[4]_INST_0 
       (.I0(S2B_n_11),
        .I1(Q2B_n_17),
        .I2(ctl_reg[0]),
        .O(pos_enc_0[4]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_0[5]_INST_0 
       (.I0(S2B_n_10),
        .I1(Q2B_n_16),
        .I2(ctl_reg[0]),
        .O(pos_enc_0[5]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_0[6]_INST_0 
       (.I0(S2B_n_9),
        .I1(Q2B_n_15),
        .I2(ctl_reg[0]),
        .O(pos_enc_0[6]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_0[7]_INST_0 
       (.I0(S2B_n_8),
        .I1(Q2B_n_14),
        .I2(ctl_reg[0]),
        .O(pos_enc_0[7]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_0[8]_INST_0 
       (.I0(S2B_n_7),
        .I1(Q2B_n_13),
        .I2(ctl_reg[0]),
        .O(pos_enc_0[8]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_0[9]_INST_0 
       (.I0(S2B_n_6),
        .I1(Q2B_n_12),
        .I2(ctl_reg[0]),
        .O(pos_enc_0[9]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_1[0]_INST_0 
       (.I0(S2B_n_31),
        .I1(Q2B_n_37),
        .I2(ctl_reg[0]),
        .O(pos_enc_1[0]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_1[10]_INST_0 
       (.I0(S2B_n_21),
        .I1(Q2B_n_27),
        .I2(ctl_reg[0]),
        .O(pos_enc_1[10]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_1[11]_INST_0 
       (.I0(S2B_n_20),
        .I1(Q2B_n_26),
        .I2(ctl_reg[0]),
        .O(pos_enc_1[11]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_1[12]_INST_0 
       (.I0(S2B_n_19),
        .I1(Q2B_n_25),
        .I2(ctl_reg[0]),
        .O(pos_enc_1[12]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_1[13]_INST_0 
       (.I0(S2B_n_18),
        .I1(Q2B_n_24),
        .I2(ctl_reg[0]),
        .O(pos_enc_1[13]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_1[14]_INST_0 
       (.I0(S2B_n_17),
        .I1(Q2B_n_23),
        .I2(ctl_reg[0]),
        .O(pos_enc_1[14]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_1[15]_INST_0 
       (.I0(S2B_n_16),
        .I1(Q2B_n_22),
        .I2(ctl_reg[0]),
        .O(pos_enc_1[15]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_1[1]_INST_0 
       (.I0(S2B_n_30),
        .I1(Q2B_n_36),
        .I2(ctl_reg[0]),
        .O(pos_enc_1[1]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_1[2]_INST_0 
       (.I0(S2B_n_29),
        .I1(Q2B_n_35),
        .I2(ctl_reg[0]),
        .O(pos_enc_1[2]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_1[3]_INST_0 
       (.I0(S2B_n_28),
        .I1(Q2B_n_34),
        .I2(ctl_reg[0]),
        .O(pos_enc_1[3]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_1[4]_INST_0 
       (.I0(S2B_n_27),
        .I1(Q2B_n_33),
        .I2(ctl_reg[0]),
        .O(pos_enc_1[4]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_1[5]_INST_0 
       (.I0(S2B_n_26),
        .I1(Q2B_n_32),
        .I2(ctl_reg[0]),
        .O(pos_enc_1[5]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_1[6]_INST_0 
       (.I0(S2B_n_25),
        .I1(Q2B_n_31),
        .I2(ctl_reg[0]),
        .O(pos_enc_1[6]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_1[7]_INST_0 
       (.I0(S2B_n_24),
        .I1(Q2B_n_30),
        .I2(ctl_reg[0]),
        .O(pos_enc_1[7]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_1[8]_INST_0 
       (.I0(S2B_n_23),
        .I1(Q2B_n_29),
        .I2(ctl_reg[0]),
        .O(pos_enc_1[8]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pos_enc_1[9]_INST_0 
       (.I0(S2B_n_22),
        .I1(Q2B_n_28),
        .I2(ctl_reg[0]),
        .O(pos_enc_1[9]));
endmodule

(* ORIG_REF_NAME = "quad2bin_jkff" *) 
module user_block2_position_encoder_0_0_quad2bin_jkff
   (rot_a_filt,
    D,
    E,
    aclk,
    aresetn,
    rot_a_d2,
    rot_a_d4,
    rot_a_d3,
    \rot_encoder_cnt_reg[15] ,
    \rot_encoder_cnt_reg[17] ,
    Q,
    rot_b_filt_d1,
    O,
    \rot_encoder_cnt_reg[0] ,
    \rot_encoder_cnt_reg[0]_0 ,
    \rot_encoder_cnt_reg[16] ,
    \rot_encoder_cnt_reg[18] ,
    \rot_encoder_cnt_reg[17]_0 ,
    rot_a_filt_d1,
    rot_b_filt);
  output rot_a_filt;
  output [18:0]D;
  output [0:0]E;
  input aclk;
  input aresetn;
  input rot_a_d2;
  input rot_a_d4;
  input rot_a_d3;
  input \rot_encoder_cnt_reg[15] ;
  input \rot_encoder_cnt_reg[17] ;
  input [0:0]Q;
  input rot_b_filt_d1;
  input [7:0]O;
  input [7:0]\rot_encoder_cnt_reg[0] ;
  input [7:0]\rot_encoder_cnt_reg[0]_0 ;
  input [7:0]\rot_encoder_cnt_reg[16] ;
  input [1:0]\rot_encoder_cnt_reg[18] ;
  input [1:0]\rot_encoder_cnt_reg[17]_0 ;
  input rot_a_filt_d1;
  input rot_b_filt;

  wire [18:0]D;
  wire [0:0]E;
  wire [7:0]O;
  wire [0:0]Q;
  wire Qi_i_1_n_0;
  wire aclk;
  wire aresetn;
  wire rot_a_d2;
  wire rot_a_d3;
  wire rot_a_d4;
  wire rot_a_filt;
  wire rot_a_filt_d1;
  wire rot_b_filt;
  wire rot_b_filt_d1;
  wire [7:0]\rot_encoder_cnt_reg[0] ;
  wire [7:0]\rot_encoder_cnt_reg[0]_0 ;
  wire \rot_encoder_cnt_reg[15] ;
  wire [7:0]\rot_encoder_cnt_reg[16] ;
  wire \rot_encoder_cnt_reg[17] ;
  wire [1:0]\rot_encoder_cnt_reg[17]_0 ;
  wire [1:0]\rot_encoder_cnt_reg[18] ;

  LUT4 #(
    .INIT(16'hFE80)) 
    Qi_i_1
       (.I0(rot_a_d2),
        .I1(rot_a_d4),
        .I2(rot_a_d3),
        .I3(rot_a_filt),
        .O(Qi_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    Qi_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(Qi_i_1_n_0),
        .Q(rot_a_filt));
  LUT5 #(
    .INIT(32'hCF0A0ACF)) 
    \rot_encoder_cnt[0]_i_1 
       (.I0(\rot_encoder_cnt_reg[15] ),
        .I1(\rot_encoder_cnt_reg[17] ),
        .I2(Q),
        .I3(rot_b_filt_d1),
        .I4(rot_a_filt),
        .O(D[0]));
  LUT6 #(
    .INIT(64'h00F08888888800F0)) 
    \rot_encoder_cnt[10]_i_1 
       (.I0(\rot_encoder_cnt_reg[0]_0 [1]),
        .I1(\rot_encoder_cnt_reg[15] ),
        .I2(\rot_encoder_cnt_reg[16] [1]),
        .I3(\rot_encoder_cnt_reg[17] ),
        .I4(rot_b_filt_d1),
        .I5(rot_a_filt),
        .O(D[10]));
  LUT6 #(
    .INIT(64'hFFF088888888FFF0)) 
    \rot_encoder_cnt[11]_i_1 
       (.I0(\rot_encoder_cnt_reg[0]_0 [2]),
        .I1(\rot_encoder_cnt_reg[15] ),
        .I2(\rot_encoder_cnt_reg[16] [2]),
        .I3(\rot_encoder_cnt_reg[17] ),
        .I4(rot_b_filt_d1),
        .I5(rot_a_filt),
        .O(D[11]));
  LUT6 #(
    .INIT(64'hFFF088888888FFF0)) 
    \rot_encoder_cnt[12]_i_1 
       (.I0(\rot_encoder_cnt_reg[0]_0 [3]),
        .I1(\rot_encoder_cnt_reg[15] ),
        .I2(\rot_encoder_cnt_reg[16] [3]),
        .I3(\rot_encoder_cnt_reg[17] ),
        .I4(rot_b_filt_d1),
        .I5(rot_a_filt),
        .O(D[12]));
  LUT6 #(
    .INIT(64'h00F08888888800F0)) 
    \rot_encoder_cnt[13]_i_1 
       (.I0(\rot_encoder_cnt_reg[0]_0 [4]),
        .I1(\rot_encoder_cnt_reg[15] ),
        .I2(\rot_encoder_cnt_reg[16] [4]),
        .I3(\rot_encoder_cnt_reg[17] ),
        .I4(rot_b_filt_d1),
        .I5(rot_a_filt),
        .O(D[13]));
  LUT6 #(
    .INIT(64'h00F08888888800F0)) 
    \rot_encoder_cnt[14]_i_1 
       (.I0(\rot_encoder_cnt_reg[0]_0 [5]),
        .I1(\rot_encoder_cnt_reg[15] ),
        .I2(\rot_encoder_cnt_reg[16] [5]),
        .I3(\rot_encoder_cnt_reg[17] ),
        .I4(rot_b_filt_d1),
        .I5(rot_a_filt),
        .O(D[14]));
  LUT6 #(
    .INIT(64'h00F08888888800F0)) 
    \rot_encoder_cnt[15]_i_1 
       (.I0(\rot_encoder_cnt_reg[0]_0 [6]),
        .I1(\rot_encoder_cnt_reg[15] ),
        .I2(\rot_encoder_cnt_reg[16] [6]),
        .I3(\rot_encoder_cnt_reg[17] ),
        .I4(rot_b_filt_d1),
        .I5(rot_a_filt),
        .O(D[15]));
  LUT6 #(
    .INIT(64'h00F08888888800F0)) 
    \rot_encoder_cnt[16]_i_1 
       (.I0(\rot_encoder_cnt_reg[0]_0 [7]),
        .I1(\rot_encoder_cnt_reg[15] ),
        .I2(\rot_encoder_cnt_reg[16] [7]),
        .I3(\rot_encoder_cnt_reg[17] ),
        .I4(rot_b_filt_d1),
        .I5(rot_a_filt),
        .O(D[16]));
  LUT6 #(
    .INIT(64'hFFF088888888FFF0)) 
    \rot_encoder_cnt[17]_i_1 
       (.I0(\rot_encoder_cnt_reg[18] [0]),
        .I1(\rot_encoder_cnt_reg[15] ),
        .I2(\rot_encoder_cnt_reg[17]_0 [0]),
        .I3(\rot_encoder_cnt_reg[17] ),
        .I4(rot_b_filt_d1),
        .I5(rot_a_filt),
        .O(D[17]));
  LUT4 #(
    .INIT(16'h6996)) 
    \rot_encoder_cnt[18]_i_2 
       (.I0(rot_a_filt),
        .I1(rot_b_filt_d1),
        .I2(rot_a_filt_d1),
        .I3(rot_b_filt),
        .O(E));
  LUT6 #(
    .INIT(64'hFFF088888888FFF0)) 
    \rot_encoder_cnt[18]_i_3 
       (.I0(\rot_encoder_cnt_reg[18] [1]),
        .I1(\rot_encoder_cnt_reg[15] ),
        .I2(\rot_encoder_cnt_reg[17]_0 [1]),
        .I3(\rot_encoder_cnt_reg[17] ),
        .I4(rot_b_filt_d1),
        .I5(rot_a_filt),
        .O(D[18]));
  LUT6 #(
    .INIT(64'hFFF088888888FFF0)) 
    \rot_encoder_cnt[1]_i_1 
       (.I0(O[0]),
        .I1(\rot_encoder_cnt_reg[15] ),
        .I2(\rot_encoder_cnt_reg[0] [0]),
        .I3(\rot_encoder_cnt_reg[17] ),
        .I4(rot_b_filt_d1),
        .I5(rot_a_filt),
        .O(D[1]));
  LUT6 #(
    .INIT(64'hFFF088888888FFF0)) 
    \rot_encoder_cnt[2]_i_1 
       (.I0(O[1]),
        .I1(\rot_encoder_cnt_reg[15] ),
        .I2(\rot_encoder_cnt_reg[0] [1]),
        .I3(\rot_encoder_cnt_reg[17] ),
        .I4(rot_b_filt_d1),
        .I5(rot_a_filt),
        .O(D[2]));
  LUT6 #(
    .INIT(64'hFFF088888888FFF0)) 
    \rot_encoder_cnt[3]_i_1 
       (.I0(O[2]),
        .I1(\rot_encoder_cnt_reg[15] ),
        .I2(\rot_encoder_cnt_reg[0] [2]),
        .I3(\rot_encoder_cnt_reg[17] ),
        .I4(rot_b_filt_d1),
        .I5(rot_a_filt),
        .O(D[3]));
  LUT6 #(
    .INIT(64'hFFF088888888FFF0)) 
    \rot_encoder_cnt[4]_i_1 
       (.I0(O[3]),
        .I1(\rot_encoder_cnt_reg[15] ),
        .I2(\rot_encoder_cnt_reg[0] [3]),
        .I3(\rot_encoder_cnt_reg[17] ),
        .I4(rot_b_filt_d1),
        .I5(rot_a_filt),
        .O(D[4]));
  LUT6 #(
    .INIT(64'hFFF088888888FFF0)) 
    \rot_encoder_cnt[5]_i_1 
       (.I0(O[4]),
        .I1(\rot_encoder_cnt_reg[15] ),
        .I2(\rot_encoder_cnt_reg[0] [4]),
        .I3(\rot_encoder_cnt_reg[17] ),
        .I4(rot_b_filt_d1),
        .I5(rot_a_filt),
        .O(D[5]));
  LUT6 #(
    .INIT(64'hFFF088888888FFF0)) 
    \rot_encoder_cnt[6]_i_1 
       (.I0(O[5]),
        .I1(\rot_encoder_cnt_reg[15] ),
        .I2(\rot_encoder_cnt_reg[0] [5]),
        .I3(\rot_encoder_cnt_reg[17] ),
        .I4(rot_b_filt_d1),
        .I5(rot_a_filt),
        .O(D[6]));
  LUT6 #(
    .INIT(64'h00F08888888800F0)) 
    \rot_encoder_cnt[7]_i_1 
       (.I0(O[6]),
        .I1(\rot_encoder_cnt_reg[15] ),
        .I2(\rot_encoder_cnt_reg[0] [6]),
        .I3(\rot_encoder_cnt_reg[17] ),
        .I4(rot_b_filt_d1),
        .I5(rot_a_filt),
        .O(D[7]));
  LUT6 #(
    .INIT(64'h00F08888888800F0)) 
    \rot_encoder_cnt[8]_i_1 
       (.I0(O[7]),
        .I1(\rot_encoder_cnt_reg[15] ),
        .I2(\rot_encoder_cnt_reg[0] [7]),
        .I3(\rot_encoder_cnt_reg[17] ),
        .I4(rot_b_filt_d1),
        .I5(rot_a_filt),
        .O(D[8]));
  LUT6 #(
    .INIT(64'hFFF088888888FFF0)) 
    \rot_encoder_cnt[9]_i_1 
       (.I0(\rot_encoder_cnt_reg[0]_0 [0]),
        .I1(\rot_encoder_cnt_reg[15] ),
        .I2(\rot_encoder_cnt_reg[16] [0]),
        .I3(\rot_encoder_cnt_reg[17] ),
        .I4(rot_b_filt_d1),
        .I5(rot_a_filt),
        .O(D[9]));
endmodule

(* ORIG_REF_NAME = "quad2bin_jkff" *) 
module user_block2_position_encoder_0_0_quad2bin_jkff_1
   (rot_b_filt,
    aclk,
    aresetn,
    rot_b_d2,
    rot_b_d4,
    rot_b_d3);
  output rot_b_filt;
  input aclk;
  input aresetn;
  input rot_b_d2;
  input rot_b_d4;
  input rot_b_d3;

  wire Qi_i_1__0_n_0;
  wire aclk;
  wire aresetn;
  wire rot_b_d2;
  wire rot_b_d3;
  wire rot_b_d4;
  wire rot_b_filt;

  LUT4 #(
    .INIT(16'hFE80)) 
    Qi_i_1__0
       (.I0(rot_b_d2),
        .I1(rot_b_d4),
        .I2(rot_b_d3),
        .I3(rot_b_filt),
        .O(Qi_i_1__0_n_0));
  FDCE #(
    .INIT(1'b0)) 
    Qi_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(Qi_i_1__0_n_0),
        .Q(rot_b_filt));
endmodule

(* ORIG_REF_NAME = "quad2bin_jkff" *) 
module user_block2_position_encoder_0_0_quad2bin_jkff_2
   (SR,
    aclk,
    aresetn,
    tilt_z_d2,
    tilt_z_d4,
    tilt_z_d3);
  output [0:0]SR;
  input aclk;
  input aresetn;
  input tilt_z_d2;
  input tilt_z_d4;
  input tilt_z_d3;

  wire Qi_i_1__1_n_0;
  wire [0:0]SR;
  wire aclk;
  wire aresetn;
  wire rot_z_filt;
  wire tilt_z_d2;
  wire tilt_z_d3;
  wire tilt_z_d4;

  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hFE80)) 
    Qi_i_1__1
       (.I0(tilt_z_d2),
        .I1(tilt_z_d4),
        .I2(tilt_z_d3),
        .I3(rot_z_filt),
        .O(Qi_i_1__1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    Qi_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(Qi_i_1__1_n_0),
        .Q(rot_z_filt));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \rot_encoder_cnt[18]_i_1 
       (.I0(aresetn),
        .I1(rot_z_filt),
        .O(SR));
endmodule

(* ORIG_REF_NAME = "quad2bin_jkff" *) 
module user_block2_position_encoder_0_0_quad2bin_jkff_3
   (tilt_a_filt,
    D,
    aclk,
    aresetn,
    \tilt_encoder_cnt_reg[3] ,
    \tilt_encoder_cnt_reg[7] ,
    \tilt_encoder_cnt_reg[17] ,
    \tilt_encoder_cnt_reg[8] ,
    tilt_b_filt_d1,
    tilt_a_d2,
    tilt_a_d3,
    tilt_a_d4,
    O,
    \tilt_encoder_cnt_reg[18] ,
    \tilt_encoder_cnt_reg[16] ,
    \tilt_encoder_cnt_reg[0] ,
    \tilt_encoder_cnt_reg[0]_0 ,
    \tilt_encoder_cnt_reg[0]_1 ,
    \tilt_encoder_cnt_reg[3]_0 ,
    \tilt_encoder_cnt_reg[7]_0 ,
    \tilt_encoder_cnt_reg[17]_0 );
  output tilt_a_filt;
  output [17:0]D;
  input aclk;
  input aresetn;
  input \tilt_encoder_cnt_reg[3] ;
  input \tilt_encoder_cnt_reg[7] ;
  input \tilt_encoder_cnt_reg[17] ;
  input \tilt_encoder_cnt_reg[8] ;
  input tilt_b_filt_d1;
  input tilt_a_d2;
  input tilt_a_d3;
  input tilt_a_d4;
  input [1:0]O;
  input [1:0]\tilt_encoder_cnt_reg[18] ;
  input [7:0]\tilt_encoder_cnt_reg[16] ;
  input [7:0]\tilt_encoder_cnt_reg[0] ;
  input [7:0]\tilt_encoder_cnt_reg[0]_0 ;
  input [7:0]\tilt_encoder_cnt_reg[0]_1 ;
  input \tilt_encoder_cnt_reg[3]_0 ;
  input \tilt_encoder_cnt_reg[7]_0 ;
  input \tilt_encoder_cnt_reg[17]_0 ;

  wire [17:0]D;
  wire [1:0]O;
  wire Qi_i_1__2_n_0;
  wire aclk;
  wire aresetn;
  wire tilt_a_d2;
  wire tilt_a_d3;
  wire tilt_a_d4;
  wire tilt_a_filt;
  wire tilt_b_filt_d1;
  wire \tilt_encoder_cnt[15]_i_2_n_0 ;
  wire \tilt_encoder_cnt[18]_i_4_n_0 ;
  wire \tilt_encoder_cnt[18]_i_6_n_0 ;
  wire [7:0]\tilt_encoder_cnt_reg[0] ;
  wire [7:0]\tilt_encoder_cnt_reg[0]_0 ;
  wire [7:0]\tilt_encoder_cnt_reg[0]_1 ;
  wire [7:0]\tilt_encoder_cnt_reg[16] ;
  wire \tilt_encoder_cnt_reg[17] ;
  wire \tilt_encoder_cnt_reg[17]_0 ;
  wire [1:0]\tilt_encoder_cnt_reg[18] ;
  wire \tilt_encoder_cnt_reg[3] ;
  wire \tilt_encoder_cnt_reg[3]_0 ;
  wire \tilt_encoder_cnt_reg[7] ;
  wire \tilt_encoder_cnt_reg[7]_0 ;
  wire \tilt_encoder_cnt_reg[8] ;

  LUT4 #(
    .INIT(16'hFE80)) 
    Qi_i_1__2
       (.I0(tilt_a_d2),
        .I1(tilt_a_d3),
        .I2(tilt_a_d4),
        .I3(tilt_a_filt),
        .O(Qi_i_1__2_n_0));
  FDCE #(
    .INIT(1'b0)) 
    Qi_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(Qi_i_1__2_n_0),
        .Q(tilt_a_filt));
  LUT4 #(
    .INIT(16'hF888)) 
    \tilt_encoder_cnt[10]_i_1 
       (.I0(\tilt_encoder_cnt_reg[0] [1]),
        .I1(\tilt_encoder_cnt[18]_i_6_n_0 ),
        .I2(\tilt_encoder_cnt_reg[16] [1]),
        .I3(\tilt_encoder_cnt[15]_i_2_n_0 ),
        .O(D[9]));
  LUT4 #(
    .INIT(16'hF888)) 
    \tilt_encoder_cnt[11]_i_1 
       (.I0(\tilt_encoder_cnt_reg[0] [2]),
        .I1(\tilt_encoder_cnt[18]_i_6_n_0 ),
        .I2(\tilt_encoder_cnt_reg[16] [2]),
        .I3(\tilt_encoder_cnt[15]_i_2_n_0 ),
        .O(D[10]));
  LUT6 #(
    .INIT(64'hFFFFEBAAEBAAEBAA)) 
    \tilt_encoder_cnt[12]_i_1 
       (.I0(\tilt_encoder_cnt[18]_i_4_n_0 ),
        .I1(tilt_a_filt),
        .I2(tilt_b_filt_d1),
        .I3(\tilt_encoder_cnt_reg[16] [3]),
        .I4(\tilt_encoder_cnt_reg[0] [3]),
        .I5(\tilt_encoder_cnt[18]_i_6_n_0 ),
        .O(D[11]));
  LUT4 #(
    .INIT(16'hF888)) 
    \tilt_encoder_cnt[13]_i_1 
       (.I0(\tilt_encoder_cnt_reg[0] [4]),
        .I1(\tilt_encoder_cnt[18]_i_6_n_0 ),
        .I2(\tilt_encoder_cnt_reg[16] [4]),
        .I3(\tilt_encoder_cnt[15]_i_2_n_0 ),
        .O(D[12]));
  LUT6 #(
    .INIT(64'hFFFFEBAAEBAAEBAA)) 
    \tilt_encoder_cnt[14]_i_1 
       (.I0(\tilt_encoder_cnt[18]_i_4_n_0 ),
        .I1(tilt_a_filt),
        .I2(tilt_b_filt_d1),
        .I3(\tilt_encoder_cnt_reg[16] [5]),
        .I4(\tilt_encoder_cnt_reg[0] [5]),
        .I5(\tilt_encoder_cnt[18]_i_6_n_0 ),
        .O(D[13]));
  LUT4 #(
    .INIT(16'hF888)) 
    \tilt_encoder_cnt[15]_i_1 
       (.I0(\tilt_encoder_cnt_reg[0] [6]),
        .I1(\tilt_encoder_cnt[18]_i_6_n_0 ),
        .I2(\tilt_encoder_cnt_reg[16] [6]),
        .I3(\tilt_encoder_cnt[15]_i_2_n_0 ),
        .O(D[14]));
  LUT6 #(
    .INIT(64'hFFFE00000000FFFE)) 
    \tilt_encoder_cnt[15]_i_2 
       (.I0(\tilt_encoder_cnt_reg[3]_0 ),
        .I1(\tilt_encoder_cnt_reg[7]_0 ),
        .I2(\tilt_encoder_cnt_reg[17]_0 ),
        .I3(\tilt_encoder_cnt_reg[8] ),
        .I4(tilt_a_filt),
        .I5(tilt_b_filt_d1),
        .O(\tilt_encoder_cnt[15]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFEBAAEBAAEBAA)) 
    \tilt_encoder_cnt[16]_i_1 
       (.I0(\tilt_encoder_cnt[18]_i_4_n_0 ),
        .I1(tilt_a_filt),
        .I2(tilt_b_filt_d1),
        .I3(\tilt_encoder_cnt_reg[16] [7]),
        .I4(\tilt_encoder_cnt_reg[0] [7]),
        .I5(\tilt_encoder_cnt[18]_i_6_n_0 ),
        .O(D[15]));
  LUT6 #(
    .INIT(64'hFFFFEBAAEBAAEBAA)) 
    \tilt_encoder_cnt[17]_i_1 
       (.I0(\tilt_encoder_cnt[18]_i_4_n_0 ),
        .I1(tilt_a_filt),
        .I2(tilt_b_filt_d1),
        .I3(O[0]),
        .I4(\tilt_encoder_cnt_reg[18] [0]),
        .I5(\tilt_encoder_cnt[18]_i_6_n_0 ),
        .O(D[16]));
  LUT6 #(
    .INIT(64'hFFFFEBAAEBAAEBAA)) 
    \tilt_encoder_cnt[18]_i_3 
       (.I0(\tilt_encoder_cnt[18]_i_4_n_0 ),
        .I1(tilt_a_filt),
        .I2(tilt_b_filt_d1),
        .I3(O[1]),
        .I4(\tilt_encoder_cnt_reg[18] [1]),
        .I5(\tilt_encoder_cnt[18]_i_6_n_0 ),
        .O(D[17]));
  LUT6 #(
    .INIT(64'h0000000000000009)) 
    \tilt_encoder_cnt[18]_i_4 
       (.I0(tilt_a_filt),
        .I1(tilt_b_filt_d1),
        .I2(\tilt_encoder_cnt_reg[3]_0 ),
        .I3(\tilt_encoder_cnt_reg[7]_0 ),
        .I4(\tilt_encoder_cnt_reg[17]_0 ),
        .I5(\tilt_encoder_cnt_reg[8] ),
        .O(\tilt_encoder_cnt[18]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000FFFEFFFE0000)) 
    \tilt_encoder_cnt[18]_i_6 
       (.I0(\tilt_encoder_cnt_reg[3] ),
        .I1(\tilt_encoder_cnt_reg[7] ),
        .I2(\tilt_encoder_cnt_reg[17] ),
        .I3(\tilt_encoder_cnt_reg[8] ),
        .I4(tilt_a_filt),
        .I5(tilt_b_filt_d1),
        .O(\tilt_encoder_cnt[18]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFEBAAEBAAEBAA)) 
    \tilt_encoder_cnt[1]_i_1 
       (.I0(\tilt_encoder_cnt[18]_i_4_n_0 ),
        .I1(tilt_a_filt),
        .I2(tilt_b_filt_d1),
        .I3(\tilt_encoder_cnt_reg[0]_1 [0]),
        .I4(\tilt_encoder_cnt_reg[0]_0 [0]),
        .I5(\tilt_encoder_cnt[18]_i_6_n_0 ),
        .O(D[0]));
  LUT6 #(
    .INIT(64'hFFFFEBAAEBAAEBAA)) 
    \tilt_encoder_cnt[2]_i_1 
       (.I0(\tilt_encoder_cnt[18]_i_4_n_0 ),
        .I1(tilt_a_filt),
        .I2(tilt_b_filt_d1),
        .I3(\tilt_encoder_cnt_reg[0]_1 [1]),
        .I4(\tilt_encoder_cnt_reg[0]_0 [1]),
        .I5(\tilt_encoder_cnt[18]_i_6_n_0 ),
        .O(D[1]));
  LUT6 #(
    .INIT(64'hFFFFEBAAEBAAEBAA)) 
    \tilt_encoder_cnt[3]_i_1 
       (.I0(\tilt_encoder_cnt[18]_i_4_n_0 ),
        .I1(tilt_a_filt),
        .I2(tilt_b_filt_d1),
        .I3(\tilt_encoder_cnt_reg[0]_1 [2]),
        .I4(\tilt_encoder_cnt_reg[0]_0 [2]),
        .I5(\tilt_encoder_cnt[18]_i_6_n_0 ),
        .O(D[2]));
  LUT6 #(
    .INIT(64'hFFFFEBAAEBAAEBAA)) 
    \tilt_encoder_cnt[4]_i_1 
       (.I0(\tilt_encoder_cnt[18]_i_4_n_0 ),
        .I1(tilt_a_filt),
        .I2(tilt_b_filt_d1),
        .I3(\tilt_encoder_cnt_reg[0]_1 [3]),
        .I4(\tilt_encoder_cnt_reg[0]_0 [3]),
        .I5(\tilt_encoder_cnt[18]_i_6_n_0 ),
        .O(D[3]));
  LUT6 #(
    .INIT(64'hFFFFEBAAEBAAEBAA)) 
    \tilt_encoder_cnt[5]_i_1 
       (.I0(\tilt_encoder_cnt[18]_i_4_n_0 ),
        .I1(tilt_a_filt),
        .I2(tilt_b_filt_d1),
        .I3(\tilt_encoder_cnt_reg[0]_1 [4]),
        .I4(\tilt_encoder_cnt_reg[0]_0 [4]),
        .I5(\tilt_encoder_cnt[18]_i_6_n_0 ),
        .O(D[4]));
  LUT6 #(
    .INIT(64'hFFFFEBAAEBAAEBAA)) 
    \tilt_encoder_cnt[6]_i_1 
       (.I0(\tilt_encoder_cnt[18]_i_4_n_0 ),
        .I1(tilt_a_filt),
        .I2(tilt_b_filt_d1),
        .I3(\tilt_encoder_cnt_reg[0]_1 [5]),
        .I4(\tilt_encoder_cnt_reg[0]_0 [5]),
        .I5(\tilt_encoder_cnt[18]_i_6_n_0 ),
        .O(D[5]));
  LUT6 #(
    .INIT(64'hFFFFEBAAEBAAEBAA)) 
    \tilt_encoder_cnt[7]_i_1 
       (.I0(\tilt_encoder_cnt[18]_i_4_n_0 ),
        .I1(tilt_a_filt),
        .I2(tilt_b_filt_d1),
        .I3(\tilt_encoder_cnt_reg[0]_1 [6]),
        .I4(\tilt_encoder_cnt_reg[0]_0 [6]),
        .I5(\tilt_encoder_cnt[18]_i_6_n_0 ),
        .O(D[6]));
  LUT4 #(
    .INIT(16'hF888)) 
    \tilt_encoder_cnt[8]_i_1 
       (.I0(\tilt_encoder_cnt_reg[0]_0 [7]),
        .I1(\tilt_encoder_cnt[18]_i_6_n_0 ),
        .I2(\tilt_encoder_cnt_reg[0]_1 [7]),
        .I3(\tilt_encoder_cnt[15]_i_2_n_0 ),
        .O(D[7]));
  LUT6 #(
    .INIT(64'hFFFFEBAAEBAAEBAA)) 
    \tilt_encoder_cnt[9]_i_1 
       (.I0(\tilt_encoder_cnt[18]_i_4_n_0 ),
        .I1(tilt_a_filt),
        .I2(tilt_b_filt_d1),
        .I3(\tilt_encoder_cnt_reg[16] [0]),
        .I4(\tilt_encoder_cnt_reg[0] [0]),
        .I5(\tilt_encoder_cnt[18]_i_6_n_0 ),
        .O(D[8]));
endmodule

(* ORIG_REF_NAME = "quad2bin_jkff" *) 
module user_block2_position_encoder_0_0_quad2bin_jkff_4
   (tilt_b_filt,
    E,
    aclk,
    aresetn,
    tilt_b_d2,
    tilt_b_d3,
    tilt_b_d4,
    tilt_a_filt_d1,
    tilt_a_filt,
    tilt_b_filt_d1);
  output tilt_b_filt;
  output [0:0]E;
  input aclk;
  input aresetn;
  input tilt_b_d2;
  input tilt_b_d3;
  input tilt_b_d4;
  input tilt_a_filt_d1;
  input tilt_a_filt;
  input tilt_b_filt_d1;

  wire [0:0]E;
  wire Qi_i_1__3_n_0;
  wire aclk;
  wire aresetn;
  wire tilt_a_filt;
  wire tilt_a_filt_d1;
  wire tilt_b_d2;
  wire tilt_b_d3;
  wire tilt_b_d4;
  wire tilt_b_filt;
  wire tilt_b_filt_d1;

  LUT4 #(
    .INIT(16'hFE80)) 
    Qi_i_1__3
       (.I0(tilt_b_d2),
        .I1(tilt_b_d3),
        .I2(tilt_b_d4),
        .I3(tilt_b_filt),
        .O(Qi_i_1__3_n_0));
  FDCE #(
    .INIT(1'b0)) 
    Qi_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(Qi_i_1__3_n_0),
        .Q(tilt_b_filt));
  LUT4 #(
    .INIT(16'h6996)) 
    \tilt_encoder_cnt[18]_i_2 
       (.I0(tilt_b_filt),
        .I1(tilt_a_filt_d1),
        .I2(tilt_a_filt),
        .I3(tilt_b_filt_d1),
        .O(E));
endmodule

(* ORIG_REF_NAME = "quad2bin_jkff" *) 
module user_block2_position_encoder_0_0_quad2bin_jkff_5
   (SR,
    aclk,
    aresetn,
    tilt_z_d2,
    tilt_z_d4,
    tilt_z_d3);
  output [0:0]SR;
  input aclk;
  input aresetn;
  input tilt_z_d2;
  input tilt_z_d4;
  input tilt_z_d3;

  wire Qi_i_1__4_n_0;
  wire [0:0]SR;
  wire aclk;
  wire aresetn;
  wire tilt_z_d2;
  wire tilt_z_d3;
  wire tilt_z_d4;
  wire tilt_z_filt;

  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hFE80)) 
    Qi_i_1__4
       (.I0(tilt_z_d2),
        .I1(tilt_z_d4),
        .I2(tilt_z_d3),
        .I3(tilt_z_filt),
        .O(Qi_i_1__4_n_0));
  FDCE #(
    .INIT(1'b0)) 
    Qi_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(Qi_i_1__4_n_0),
        .Q(tilt_z_filt));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \tilt_encoder_cnt[18]_i_1 
       (.I0(aresetn),
        .I1(tilt_z_filt),
        .O(SR));
endmodule

(* ORIG_REF_NAME = "ser2bin" *) 
module user_block2_position_encoder_0_0_ser2bin
   (\pos_enc_0[15] ,
    \pos_enc_0[14] ,
    \pos_enc_0[13] ,
    \pos_enc_0[12] ,
    \pos_enc_0[11] ,
    \pos_enc_0[10] ,
    \pos_enc_0[9] ,
    \pos_enc_0[8] ,
    \pos_enc_0[7] ,
    \pos_enc_0[6] ,
    \pos_enc_0[5] ,
    \pos_enc_0[4] ,
    \pos_enc_0[3] ,
    \pos_enc_0[2] ,
    \pos_enc_0[1] ,
    \pos_enc_0[0] ,
    \pos_enc_1[15] ,
    \pos_enc_1[14] ,
    \pos_enc_1[13] ,
    \pos_enc_1[12] ,
    \pos_enc_1[11] ,
    \pos_enc_1[10] ,
    \pos_enc_1[9] ,
    \pos_enc_1[8] ,
    \pos_enc_1[7] ,
    \pos_enc_1[6] ,
    \pos_enc_1[5] ,
    \pos_enc_1[4] ,
    \pos_enc_1[3] ,
    \pos_enc_1[2] ,
    \pos_enc_1[1] ,
    \pos_enc_1[0] ,
    aclk,
    AZ_SCK,
    EL_SCK,
    AZ_SSEL,
    EL_SSEL,
    AZ_MOSI,
    aresetn,
    EL_MOSI);
  output \pos_enc_0[15] ;
  output \pos_enc_0[14] ;
  output \pos_enc_0[13] ;
  output \pos_enc_0[12] ;
  output \pos_enc_0[11] ;
  output \pos_enc_0[10] ;
  output \pos_enc_0[9] ;
  output \pos_enc_0[8] ;
  output \pos_enc_0[7] ;
  output \pos_enc_0[6] ;
  output \pos_enc_0[5] ;
  output \pos_enc_0[4] ;
  output \pos_enc_0[3] ;
  output \pos_enc_0[2] ;
  output \pos_enc_0[1] ;
  output \pos_enc_0[0] ;
  output \pos_enc_1[15] ;
  output \pos_enc_1[14] ;
  output \pos_enc_1[13] ;
  output \pos_enc_1[12] ;
  output \pos_enc_1[11] ;
  output \pos_enc_1[10] ;
  output \pos_enc_1[9] ;
  output \pos_enc_1[8] ;
  output \pos_enc_1[7] ;
  output \pos_enc_1[6] ;
  output \pos_enc_1[5] ;
  output \pos_enc_1[4] ;
  output \pos_enc_1[3] ;
  output \pos_enc_1[2] ;
  output \pos_enc_1[1] ;
  output \pos_enc_1[0] ;
  input aclk;
  input AZ_SCK;
  input EL_SCK;
  input AZ_SSEL;
  input EL_SSEL;
  input AZ_MOSI;
  input aresetn;
  input EL_MOSI;

  wire AZ_MOSI;
  wire AZ_SCK;
  wire AZ_SSEL;
  wire EL_MOSI;
  wire EL_SCK;
  wire EL_SSEL;
  wire EL_spi_n_0;
  wire EL_spi_n_1;
  wire EL_spi_n_10;
  wire EL_spi_n_11;
  wire EL_spi_n_12;
  wire EL_spi_n_13;
  wire EL_spi_n_14;
  wire EL_spi_n_15;
  wire EL_spi_n_16;
  wire EL_spi_n_2;
  wire EL_spi_n_3;
  wire EL_spi_n_4;
  wire EL_spi_n_5;
  wire EL_spi_n_6;
  wire EL_spi_n_7;
  wire EL_spi_n_8;
  wire EL_spi_n_9;
  wire aclk;
  wire aresetn;
  wire [15:0]az_temp;
  wire [15:0]do_buffer_reg;
  wire do_valid_o_reg;
  wire [15:0]el_temp;
  wire \pos_enc_0[0] ;
  wire \pos_enc_0[10] ;
  wire \pos_enc_0[11] ;
  wire \pos_enc_0[12] ;
  wire \pos_enc_0[13] ;
  wire \pos_enc_0[14] ;
  wire \pos_enc_0[15] ;
  wire \pos_enc_0[1] ;
  wire \pos_enc_0[2] ;
  wire \pos_enc_0[3] ;
  wire \pos_enc_0[4] ;
  wire \pos_enc_0[5] ;
  wire \pos_enc_0[6] ;
  wire \pos_enc_0[7] ;
  wire \pos_enc_0[8] ;
  wire \pos_enc_0[9] ;
  wire \pos_enc_1[0] ;
  wire \pos_enc_1[10] ;
  wire \pos_enc_1[11] ;
  wire \pos_enc_1[12] ;
  wire \pos_enc_1[13] ;
  wire \pos_enc_1[14] ;
  wire \pos_enc_1[15] ;
  wire \pos_enc_1[1] ;
  wire \pos_enc_1[2] ;
  wire \pos_enc_1[3] ;
  wire \pos_enc_1[4] ;
  wire \pos_enc_1[5] ;
  wire \pos_enc_1[6] ;
  wire \pos_enc_1[7] ;
  wire \pos_enc_1[8] ;
  wire \pos_enc_1[9] ;

  FDCE \AZ_POS_reg[0] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(az_temp[0]),
        .Q(\pos_enc_0[0] ));
  FDCE \AZ_POS_reg[10] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(az_temp[10]),
        .Q(\pos_enc_0[10] ));
  FDCE \AZ_POS_reg[11] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(az_temp[11]),
        .Q(\pos_enc_0[11] ));
  FDCE \AZ_POS_reg[12] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(az_temp[12]),
        .Q(\pos_enc_0[12] ));
  FDCE \AZ_POS_reg[13] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(az_temp[13]),
        .Q(\pos_enc_0[13] ));
  FDCE \AZ_POS_reg[14] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(az_temp[14]),
        .Q(\pos_enc_0[14] ));
  FDCE \AZ_POS_reg[15] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(az_temp[15]),
        .Q(\pos_enc_0[15] ));
  FDCE \AZ_POS_reg[1] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(az_temp[1]),
        .Q(\pos_enc_0[1] ));
  FDCE \AZ_POS_reg[2] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(az_temp[2]),
        .Q(\pos_enc_0[2] ));
  FDCE \AZ_POS_reg[3] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(az_temp[3]),
        .Q(\pos_enc_0[3] ));
  FDCE \AZ_POS_reg[4] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(az_temp[4]),
        .Q(\pos_enc_0[4] ));
  FDCE \AZ_POS_reg[5] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(az_temp[5]),
        .Q(\pos_enc_0[5] ));
  FDCE \AZ_POS_reg[6] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(az_temp[6]),
        .Q(\pos_enc_0[6] ));
  FDCE \AZ_POS_reg[7] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(az_temp[7]),
        .Q(\pos_enc_0[7] ));
  FDCE \AZ_POS_reg[8] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(az_temp[8]),
        .Q(\pos_enc_0[8] ));
  FDCE \AZ_POS_reg[9] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(az_temp[9]),
        .Q(\pos_enc_0[9] ));
  user_block2_position_encoder_0_0_ser2bin_spi AZ_spi
       (.AZ_MOSI(AZ_MOSI),
        .AZ_SCK(AZ_SCK),
        .AZ_SSEL(AZ_SSEL),
        .E(do_valid_o_reg),
        .Q(do_buffer_reg),
        .aclk(aclk));
  FDCE \EL_POS_reg[0] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(el_temp[0]),
        .Q(\pos_enc_1[0] ));
  FDCE \EL_POS_reg[10] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(el_temp[10]),
        .Q(\pos_enc_1[10] ));
  FDCE \EL_POS_reg[11] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(el_temp[11]),
        .Q(\pos_enc_1[11] ));
  FDCE \EL_POS_reg[12] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(el_temp[12]),
        .Q(\pos_enc_1[12] ));
  FDCE \EL_POS_reg[13] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(el_temp[13]),
        .Q(\pos_enc_1[13] ));
  FDCE \EL_POS_reg[14] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(el_temp[14]),
        .Q(\pos_enc_1[14] ));
  FDCE \EL_POS_reg[15] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(el_temp[15]),
        .Q(\pos_enc_1[15] ));
  FDCE \EL_POS_reg[1] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(el_temp[1]),
        .Q(\pos_enc_1[1] ));
  FDCE \EL_POS_reg[2] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(el_temp[2]),
        .Q(\pos_enc_1[2] ));
  FDCE \EL_POS_reg[3] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(el_temp[3]),
        .Q(\pos_enc_1[3] ));
  FDCE \EL_POS_reg[4] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(el_temp[4]),
        .Q(\pos_enc_1[4] ));
  FDCE \EL_POS_reg[5] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(el_temp[5]),
        .Q(\pos_enc_1[5] ));
  FDCE \EL_POS_reg[6] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(el_temp[6]),
        .Q(\pos_enc_1[6] ));
  FDCE \EL_POS_reg[7] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(el_temp[7]),
        .Q(\pos_enc_1[7] ));
  FDCE \EL_POS_reg[8] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(el_temp[8]),
        .Q(\pos_enc_1[8] ));
  FDCE \EL_POS_reg[9] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(aresetn),
        .D(el_temp[9]),
        .Q(\pos_enc_1[9] ));
  user_block2_position_encoder_0_0_ser2bin_spi_0 EL_spi
       (.E(EL_spi_n_0),
        .EL_MOSI(EL_MOSI),
        .EL_SCK(EL_SCK),
        .EL_SSEL(EL_SSEL),
        .Q({EL_spi_n_1,EL_spi_n_2,EL_spi_n_3,EL_spi_n_4,EL_spi_n_5,EL_spi_n_6,EL_spi_n_7,EL_spi_n_8,EL_spi_n_9,EL_spi_n_10,EL_spi_n_11,EL_spi_n_12,EL_spi_n_13,EL_spi_n_14,EL_spi_n_15,EL_spi_n_16}),
        .aclk(aclk));
  FDCE \az_temp_reg[0] 
       (.C(aclk),
        .CE(do_valid_o_reg),
        .CLR(aresetn),
        .D(do_buffer_reg[0]),
        .Q(az_temp[0]));
  FDCE \az_temp_reg[10] 
       (.C(aclk),
        .CE(do_valid_o_reg),
        .CLR(aresetn),
        .D(do_buffer_reg[10]),
        .Q(az_temp[10]));
  FDCE \az_temp_reg[11] 
       (.C(aclk),
        .CE(do_valid_o_reg),
        .CLR(aresetn),
        .D(do_buffer_reg[11]),
        .Q(az_temp[11]));
  FDCE \az_temp_reg[12] 
       (.C(aclk),
        .CE(do_valid_o_reg),
        .CLR(aresetn),
        .D(do_buffer_reg[12]),
        .Q(az_temp[12]));
  FDCE \az_temp_reg[13] 
       (.C(aclk),
        .CE(do_valid_o_reg),
        .CLR(aresetn),
        .D(do_buffer_reg[13]),
        .Q(az_temp[13]));
  FDCE \az_temp_reg[14] 
       (.C(aclk),
        .CE(do_valid_o_reg),
        .CLR(aresetn),
        .D(do_buffer_reg[14]),
        .Q(az_temp[14]));
  FDCE \az_temp_reg[15] 
       (.C(aclk),
        .CE(do_valid_o_reg),
        .CLR(aresetn),
        .D(do_buffer_reg[15]),
        .Q(az_temp[15]));
  FDCE \az_temp_reg[1] 
       (.C(aclk),
        .CE(do_valid_o_reg),
        .CLR(aresetn),
        .D(do_buffer_reg[1]),
        .Q(az_temp[1]));
  FDCE \az_temp_reg[2] 
       (.C(aclk),
        .CE(do_valid_o_reg),
        .CLR(aresetn),
        .D(do_buffer_reg[2]),
        .Q(az_temp[2]));
  FDCE \az_temp_reg[3] 
       (.C(aclk),
        .CE(do_valid_o_reg),
        .CLR(aresetn),
        .D(do_buffer_reg[3]),
        .Q(az_temp[3]));
  FDCE \az_temp_reg[4] 
       (.C(aclk),
        .CE(do_valid_o_reg),
        .CLR(aresetn),
        .D(do_buffer_reg[4]),
        .Q(az_temp[4]));
  FDCE \az_temp_reg[5] 
       (.C(aclk),
        .CE(do_valid_o_reg),
        .CLR(aresetn),
        .D(do_buffer_reg[5]),
        .Q(az_temp[5]));
  FDCE \az_temp_reg[6] 
       (.C(aclk),
        .CE(do_valid_o_reg),
        .CLR(aresetn),
        .D(do_buffer_reg[6]),
        .Q(az_temp[6]));
  FDCE \az_temp_reg[7] 
       (.C(aclk),
        .CE(do_valid_o_reg),
        .CLR(aresetn),
        .D(do_buffer_reg[7]),
        .Q(az_temp[7]));
  FDCE \az_temp_reg[8] 
       (.C(aclk),
        .CE(do_valid_o_reg),
        .CLR(aresetn),
        .D(do_buffer_reg[8]),
        .Q(az_temp[8]));
  FDCE \az_temp_reg[9] 
       (.C(aclk),
        .CE(do_valid_o_reg),
        .CLR(aresetn),
        .D(do_buffer_reg[9]),
        .Q(az_temp[9]));
  FDCE \el_temp_reg[0] 
       (.C(aclk),
        .CE(EL_spi_n_0),
        .CLR(aresetn),
        .D(EL_spi_n_16),
        .Q(el_temp[0]));
  FDCE \el_temp_reg[10] 
       (.C(aclk),
        .CE(EL_spi_n_0),
        .CLR(aresetn),
        .D(EL_spi_n_6),
        .Q(el_temp[10]));
  FDCE \el_temp_reg[11] 
       (.C(aclk),
        .CE(EL_spi_n_0),
        .CLR(aresetn),
        .D(EL_spi_n_5),
        .Q(el_temp[11]));
  FDCE \el_temp_reg[12] 
       (.C(aclk),
        .CE(EL_spi_n_0),
        .CLR(aresetn),
        .D(EL_spi_n_4),
        .Q(el_temp[12]));
  FDCE \el_temp_reg[13] 
       (.C(aclk),
        .CE(EL_spi_n_0),
        .CLR(aresetn),
        .D(EL_spi_n_3),
        .Q(el_temp[13]));
  FDCE \el_temp_reg[14] 
       (.C(aclk),
        .CE(EL_spi_n_0),
        .CLR(aresetn),
        .D(EL_spi_n_2),
        .Q(el_temp[14]));
  FDCE \el_temp_reg[15] 
       (.C(aclk),
        .CE(EL_spi_n_0),
        .CLR(aresetn),
        .D(EL_spi_n_1),
        .Q(el_temp[15]));
  FDCE \el_temp_reg[1] 
       (.C(aclk),
        .CE(EL_spi_n_0),
        .CLR(aresetn),
        .D(EL_spi_n_15),
        .Q(el_temp[1]));
  FDCE \el_temp_reg[2] 
       (.C(aclk),
        .CE(EL_spi_n_0),
        .CLR(aresetn),
        .D(EL_spi_n_14),
        .Q(el_temp[2]));
  FDCE \el_temp_reg[3] 
       (.C(aclk),
        .CE(EL_spi_n_0),
        .CLR(aresetn),
        .D(EL_spi_n_13),
        .Q(el_temp[3]));
  FDCE \el_temp_reg[4] 
       (.C(aclk),
        .CE(EL_spi_n_0),
        .CLR(aresetn),
        .D(EL_spi_n_12),
        .Q(el_temp[4]));
  FDCE \el_temp_reg[5] 
       (.C(aclk),
        .CE(EL_spi_n_0),
        .CLR(aresetn),
        .D(EL_spi_n_11),
        .Q(el_temp[5]));
  FDCE \el_temp_reg[6] 
       (.C(aclk),
        .CE(EL_spi_n_0),
        .CLR(aresetn),
        .D(EL_spi_n_10),
        .Q(el_temp[6]));
  FDCE \el_temp_reg[7] 
       (.C(aclk),
        .CE(EL_spi_n_0),
        .CLR(aresetn),
        .D(EL_spi_n_9),
        .Q(el_temp[7]));
  FDCE \el_temp_reg[8] 
       (.C(aclk),
        .CE(EL_spi_n_0),
        .CLR(aresetn),
        .D(EL_spi_n_8),
        .Q(el_temp[8]));
  FDCE \el_temp_reg[9] 
       (.C(aclk),
        .CE(EL_spi_n_0),
        .CLR(aresetn),
        .D(EL_spi_n_7),
        .Q(el_temp[9]));
endmodule

(* ORIG_REF_NAME = "ser2bin_spi" *) 
module user_block2_position_encoder_0_0_ser2bin_spi
   (E,
    Q,
    aclk,
    AZ_SCK,
    AZ_SSEL,
    AZ_MOSI);
  output [0:0]E;
  output [15:0]Q;
  input aclk;
  input AZ_SCK;
  input AZ_SSEL;
  input AZ_MOSI;

  wire AZ_MOSI;
  wire AZ_SCK;
  wire AZ_SSEL;
  wire [0:0]E;
  wire [15:0]Q;
  wire aclk;
  wire [15:1]do_buffer_next;
  wire \do_buffer_reg[15]_i_1_n_0 ;
  wire do_transfer_reg;
  wire do_transfer_reg_i_1_n_0;
  wire do_valid_A;
  wire do_valid_B;
  wire do_valid_C;
  wire do_valid_D;
  wire do_valid_next;
  wire [14:0]sh_next;
  wire \sh_reg[14]_i_2_n_0 ;
  wire \sh_reg[14]_i_3_n_0 ;
  wire [4:4]state_next;
  wire [4:0]state_reg;
  wire \state_reg[0]_i_1_n_0 ;
  wire \state_reg[1]_i_1_n_0 ;
  wire \state_reg[2]_i_1_n_0 ;
  wire \state_reg[3]_i_1_n_0 ;

  LUT5 #(
    .INIT(32'h00000002)) 
    \do_buffer_reg[15]_i_1 
       (.I0(state_reg[1]),
        .I1(state_reg[2]),
        .I2(state_reg[0]),
        .I3(state_reg[3]),
        .I4(state_reg[4]),
        .O(\do_buffer_reg[15]_i_1_n_0 ));
  FDRE \do_buffer_reg_reg[0] 
       (.C(AZ_SCK),
        .CE(\do_buffer_reg[15]_i_1_n_0 ),
        .D(AZ_MOSI),
        .Q(Q[0]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[10] 
       (.C(AZ_SCK),
        .CE(\do_buffer_reg[15]_i_1_n_0 ),
        .D(do_buffer_next[10]),
        .Q(Q[10]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[11] 
       (.C(AZ_SCK),
        .CE(\do_buffer_reg[15]_i_1_n_0 ),
        .D(do_buffer_next[11]),
        .Q(Q[11]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[12] 
       (.C(AZ_SCK),
        .CE(\do_buffer_reg[15]_i_1_n_0 ),
        .D(do_buffer_next[12]),
        .Q(Q[12]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[13] 
       (.C(AZ_SCK),
        .CE(\do_buffer_reg[15]_i_1_n_0 ),
        .D(do_buffer_next[13]),
        .Q(Q[13]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[14] 
       (.C(AZ_SCK),
        .CE(\do_buffer_reg[15]_i_1_n_0 ),
        .D(do_buffer_next[14]),
        .Q(Q[14]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[15] 
       (.C(AZ_SCK),
        .CE(\do_buffer_reg[15]_i_1_n_0 ),
        .D(do_buffer_next[15]),
        .Q(Q[15]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[1] 
       (.C(AZ_SCK),
        .CE(\do_buffer_reg[15]_i_1_n_0 ),
        .D(do_buffer_next[1]),
        .Q(Q[1]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[2] 
       (.C(AZ_SCK),
        .CE(\do_buffer_reg[15]_i_1_n_0 ),
        .D(do_buffer_next[2]),
        .Q(Q[2]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[3] 
       (.C(AZ_SCK),
        .CE(\do_buffer_reg[15]_i_1_n_0 ),
        .D(do_buffer_next[3]),
        .Q(Q[3]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[4] 
       (.C(AZ_SCK),
        .CE(\do_buffer_reg[15]_i_1_n_0 ),
        .D(do_buffer_next[4]),
        .Q(Q[4]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[5] 
       (.C(AZ_SCK),
        .CE(\do_buffer_reg[15]_i_1_n_0 ),
        .D(do_buffer_next[5]),
        .Q(Q[5]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[6] 
       (.C(AZ_SCK),
        .CE(\do_buffer_reg[15]_i_1_n_0 ),
        .D(do_buffer_next[6]),
        .Q(Q[6]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[7] 
       (.C(AZ_SCK),
        .CE(\do_buffer_reg[15]_i_1_n_0 ),
        .D(do_buffer_next[7]),
        .Q(Q[7]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[8] 
       (.C(AZ_SCK),
        .CE(\do_buffer_reg[15]_i_1_n_0 ),
        .D(do_buffer_next[8]),
        .Q(Q[8]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[9] 
       (.C(AZ_SCK),
        .CE(\do_buffer_reg[15]_i_1_n_0 ),
        .D(do_buffer_next[9]),
        .Q(Q[9]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hAAAABFBE00000004)) 
    do_transfer_reg_i_1
       (.I0(state_reg[4]),
        .I1(state_reg[1]),
        .I2(state_reg[2]),
        .I3(state_reg[0]),
        .I4(state_reg[3]),
        .I5(do_transfer_reg),
        .O(do_transfer_reg_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    do_transfer_reg_reg
       (.C(AZ_SCK),
        .CE(1'b1),
        .D(do_transfer_reg_i_1_n_0),
        .Q(do_transfer_reg),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    do_valid_A_reg
       (.C(aclk),
        .CE(1'b1),
        .D(do_transfer_reg),
        .Q(do_valid_A),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    do_valid_B_reg
       (.C(aclk),
        .CE(1'b1),
        .D(do_valid_A),
        .Q(do_valid_B),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    do_valid_C_reg
       (.C(aclk),
        .CE(1'b1),
        .D(do_valid_B),
        .Q(do_valid_C),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    do_valid_D_reg
       (.C(aclk),
        .CE(1'b1),
        .D(do_valid_C),
        .Q(do_valid_D),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h40)) 
    do_valid_next0
       (.I0(do_valid_D),
        .I1(do_valid_A),
        .I2(do_valid_B),
        .O(do_valid_next));
  FDRE #(
    .INIT(1'b0)) 
    do_valid_o_reg_reg
       (.C(aclk),
        .CE(1'b1),
        .D(do_valid_next),
        .Q(E),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hF0F1FFFFF0E00000)) 
    \sh_reg[0]_i_1 
       (.I0(state_reg[3]),
        .I1(\sh_reg[14]_i_3_n_0 ),
        .I2(do_buffer_next[1]),
        .I3(\sh_reg[14]_i_2_n_0 ),
        .I4(state_reg[4]),
        .I5(AZ_MOSI),
        .O(sh_next[0]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[10]_i_1 
       (.I0(do_buffer_next[11]),
        .I1(\sh_reg[14]_i_2_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3_n_0 ),
        .I5(do_buffer_next[10]),
        .O(sh_next[10]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[11]_i_1 
       (.I0(do_buffer_next[12]),
        .I1(\sh_reg[14]_i_2_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3_n_0 ),
        .I5(do_buffer_next[11]),
        .O(sh_next[11]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[12]_i_1 
       (.I0(do_buffer_next[13]),
        .I1(\sh_reg[14]_i_2_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3_n_0 ),
        .I5(do_buffer_next[12]),
        .O(sh_next[12]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[13]_i_1 
       (.I0(do_buffer_next[14]),
        .I1(\sh_reg[14]_i_2_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3_n_0 ),
        .I5(do_buffer_next[13]),
        .O(sh_next[13]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[14]_i_1 
       (.I0(do_buffer_next[15]),
        .I1(\sh_reg[14]_i_2_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3_n_0 ),
        .I5(do_buffer_next[14]),
        .O(sh_next[14]));
  LUT3 #(
    .INIT(8'hBA)) 
    \sh_reg[14]_i_2 
       (.I0(state_reg[2]),
        .I1(state_reg[1]),
        .I2(state_reg[0]),
        .O(\sh_reg[14]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \sh_reg[14]_i_3 
       (.I0(state_reg[1]),
        .I1(state_reg[2]),
        .O(\sh_reg[14]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[1]_i_1 
       (.I0(do_buffer_next[2]),
        .I1(\sh_reg[14]_i_2_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3_n_0 ),
        .I5(do_buffer_next[1]),
        .O(sh_next[1]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[2]_i_1 
       (.I0(do_buffer_next[3]),
        .I1(\sh_reg[14]_i_2_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3_n_0 ),
        .I5(do_buffer_next[2]),
        .O(sh_next[2]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[3]_i_1 
       (.I0(do_buffer_next[4]),
        .I1(\sh_reg[14]_i_2_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3_n_0 ),
        .I5(do_buffer_next[3]),
        .O(sh_next[3]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[4]_i_1 
       (.I0(do_buffer_next[5]),
        .I1(\sh_reg[14]_i_2_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3_n_0 ),
        .I5(do_buffer_next[4]),
        .O(sh_next[4]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[5]_i_1 
       (.I0(do_buffer_next[6]),
        .I1(\sh_reg[14]_i_2_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3_n_0 ),
        .I5(do_buffer_next[5]),
        .O(sh_next[5]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[6]_i_1 
       (.I0(do_buffer_next[7]),
        .I1(\sh_reg[14]_i_2_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3_n_0 ),
        .I5(do_buffer_next[6]),
        .O(sh_next[6]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[7]_i_1 
       (.I0(do_buffer_next[8]),
        .I1(\sh_reg[14]_i_2_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3_n_0 ),
        .I5(do_buffer_next[7]),
        .O(sh_next[7]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[8]_i_1 
       (.I0(do_buffer_next[9]),
        .I1(\sh_reg[14]_i_2_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3_n_0 ),
        .I5(do_buffer_next[8]),
        .O(sh_next[8]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[9]_i_1 
       (.I0(do_buffer_next[10]),
        .I1(\sh_reg[14]_i_2_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3_n_0 ),
        .I5(do_buffer_next[9]),
        .O(sh_next[9]));
  FDRE \sh_reg_reg[0] 
       (.C(AZ_SCK),
        .CE(1'b1),
        .D(sh_next[0]),
        .Q(do_buffer_next[1]),
        .R(1'b0));
  FDRE \sh_reg_reg[10] 
       (.C(AZ_SCK),
        .CE(1'b1),
        .D(sh_next[10]),
        .Q(do_buffer_next[11]),
        .R(1'b0));
  FDRE \sh_reg_reg[11] 
       (.C(AZ_SCK),
        .CE(1'b1),
        .D(sh_next[11]),
        .Q(do_buffer_next[12]),
        .R(1'b0));
  FDRE \sh_reg_reg[12] 
       (.C(AZ_SCK),
        .CE(1'b1),
        .D(sh_next[12]),
        .Q(do_buffer_next[13]),
        .R(1'b0));
  FDRE \sh_reg_reg[13] 
       (.C(AZ_SCK),
        .CE(1'b1),
        .D(sh_next[13]),
        .Q(do_buffer_next[14]),
        .R(1'b0));
  FDRE \sh_reg_reg[14] 
       (.C(AZ_SCK),
        .CE(1'b1),
        .D(sh_next[14]),
        .Q(do_buffer_next[15]),
        .R(1'b0));
  FDRE \sh_reg_reg[1] 
       (.C(AZ_SCK),
        .CE(1'b1),
        .D(sh_next[1]),
        .Q(do_buffer_next[2]),
        .R(1'b0));
  FDRE \sh_reg_reg[2] 
       (.C(AZ_SCK),
        .CE(1'b1),
        .D(sh_next[2]),
        .Q(do_buffer_next[3]),
        .R(1'b0));
  FDRE \sh_reg_reg[3] 
       (.C(AZ_SCK),
        .CE(1'b1),
        .D(sh_next[3]),
        .Q(do_buffer_next[4]),
        .R(1'b0));
  FDRE \sh_reg_reg[4] 
       (.C(AZ_SCK),
        .CE(1'b1),
        .D(sh_next[4]),
        .Q(do_buffer_next[5]),
        .R(1'b0));
  FDRE \sh_reg_reg[5] 
       (.C(AZ_SCK),
        .CE(1'b1),
        .D(sh_next[5]),
        .Q(do_buffer_next[6]),
        .R(1'b0));
  FDRE \sh_reg_reg[6] 
       (.C(AZ_SCK),
        .CE(1'b1),
        .D(sh_next[6]),
        .Q(do_buffer_next[7]),
        .R(1'b0));
  FDRE \sh_reg_reg[7] 
       (.C(AZ_SCK),
        .CE(1'b1),
        .D(sh_next[7]),
        .Q(do_buffer_next[8]),
        .R(1'b0));
  FDRE \sh_reg_reg[8] 
       (.C(AZ_SCK),
        .CE(1'b1),
        .D(sh_next[8]),
        .Q(do_buffer_next[9]),
        .R(1'b0));
  FDRE \sh_reg_reg[9] 
       (.C(AZ_SCK),
        .CE(1'b1),
        .D(sh_next[9]),
        .Q(do_buffer_next[10]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'h00005556)) 
    \state_reg[0]_i_1 
       (.I0(state_reg[4]),
        .I1(state_reg[3]),
        .I2(state_reg[1]),
        .I3(state_reg[2]),
        .I4(state_reg[0]),
        .O(\state_reg[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'h55000056)) 
    \state_reg[1]_i_1 
       (.I0(state_reg[4]),
        .I1(state_reg[3]),
        .I2(state_reg[2]),
        .I3(state_reg[1]),
        .I4(state_reg[0]),
        .O(\state_reg[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'h50505006)) 
    \state_reg[2]_i_1 
       (.I0(state_reg[4]),
        .I1(state_reg[3]),
        .I2(state_reg[2]),
        .I3(state_reg[0]),
        .I4(state_reg[1]),
        .O(\state_reg[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'h44444442)) 
    \state_reg[3]_i_1 
       (.I0(state_reg[4]),
        .I1(state_reg[3]),
        .I2(state_reg[1]),
        .I3(state_reg[0]),
        .I4(state_reg[2]),
        .O(\state_reg[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \state_reg[4]_i_1 
       (.I0(state_reg[4]),
        .I1(state_reg[2]),
        .I2(state_reg[1]),
        .I3(state_reg[3]),
        .O(state_next));
  FDCE #(
    .INIT(1'b0)) 
    \state_reg_reg[0] 
       (.C(AZ_SCK),
        .CE(1'b1),
        .CLR(AZ_SSEL),
        .D(\state_reg[0]_i_1_n_0 ),
        .Q(state_reg[0]));
  FDCE #(
    .INIT(1'b0)) 
    \state_reg_reg[1] 
       (.C(AZ_SCK),
        .CE(1'b1),
        .CLR(AZ_SSEL),
        .D(\state_reg[1]_i_1_n_0 ),
        .Q(state_reg[1]));
  FDCE #(
    .INIT(1'b0)) 
    \state_reg_reg[2] 
       (.C(AZ_SCK),
        .CE(1'b1),
        .CLR(AZ_SSEL),
        .D(\state_reg[2]_i_1_n_0 ),
        .Q(state_reg[2]));
  FDCE #(
    .INIT(1'b0)) 
    \state_reg_reg[3] 
       (.C(AZ_SCK),
        .CE(1'b1),
        .CLR(AZ_SSEL),
        .D(\state_reg[3]_i_1_n_0 ),
        .Q(state_reg[3]));
  FDCE #(
    .INIT(1'b0)) 
    \state_reg_reg[4] 
       (.C(AZ_SCK),
        .CE(1'b1),
        .CLR(AZ_SSEL),
        .D(state_next),
        .Q(state_reg[4]));
endmodule

(* ORIG_REF_NAME = "ser2bin_spi" *) 
module user_block2_position_encoder_0_0_ser2bin_spi_0
   (E,
    Q,
    aclk,
    EL_SCK,
    EL_SSEL,
    EL_MOSI);
  output [0:0]E;
  output [15:0]Q;
  input aclk;
  input EL_SCK;
  input EL_SSEL;
  input EL_MOSI;

  wire [0:0]E;
  wire EL_MOSI;
  wire EL_SCK;
  wire EL_SSEL;
  wire [15:0]Q;
  wire aclk;
  wire [15:1]do_buffer_next__0;
  wire \do_buffer_reg[15]_i_1__0_n_0 ;
  wire do_transfer_reg_i_1__0_n_0;
  wire do_transfer_reg_reg_n_0;
  wire do_valid_A;
  wire do_valid_B;
  wire do_valid_C_reg_n_0;
  wire do_valid_D;
  wire do_valid_next;
  wire [14:0]sh_next;
  wire \sh_reg[14]_i_2__0_n_0 ;
  wire \sh_reg[14]_i_3__0_n_0 ;
  wire [4:4]state_next;
  wire [4:0]state_reg;
  wire \state_reg[0]_i_1__0_n_0 ;
  wire \state_reg[1]_i_1__0_n_0 ;
  wire \state_reg[2]_i_1__0_n_0 ;
  wire \state_reg[3]_i_1__0_n_0 ;

  LUT5 #(
    .INIT(32'h00000002)) 
    \do_buffer_reg[15]_i_1__0 
       (.I0(state_reg[1]),
        .I1(state_reg[2]),
        .I2(state_reg[0]),
        .I3(state_reg[3]),
        .I4(state_reg[4]),
        .O(\do_buffer_reg[15]_i_1__0_n_0 ));
  FDRE \do_buffer_reg_reg[0] 
       (.C(EL_SCK),
        .CE(\do_buffer_reg[15]_i_1__0_n_0 ),
        .D(EL_MOSI),
        .Q(Q[0]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[10] 
       (.C(EL_SCK),
        .CE(\do_buffer_reg[15]_i_1__0_n_0 ),
        .D(do_buffer_next__0[10]),
        .Q(Q[10]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[11] 
       (.C(EL_SCK),
        .CE(\do_buffer_reg[15]_i_1__0_n_0 ),
        .D(do_buffer_next__0[11]),
        .Q(Q[11]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[12] 
       (.C(EL_SCK),
        .CE(\do_buffer_reg[15]_i_1__0_n_0 ),
        .D(do_buffer_next__0[12]),
        .Q(Q[12]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[13] 
       (.C(EL_SCK),
        .CE(\do_buffer_reg[15]_i_1__0_n_0 ),
        .D(do_buffer_next__0[13]),
        .Q(Q[13]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[14] 
       (.C(EL_SCK),
        .CE(\do_buffer_reg[15]_i_1__0_n_0 ),
        .D(do_buffer_next__0[14]),
        .Q(Q[14]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[15] 
       (.C(EL_SCK),
        .CE(\do_buffer_reg[15]_i_1__0_n_0 ),
        .D(do_buffer_next__0[15]),
        .Q(Q[15]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[1] 
       (.C(EL_SCK),
        .CE(\do_buffer_reg[15]_i_1__0_n_0 ),
        .D(do_buffer_next__0[1]),
        .Q(Q[1]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[2] 
       (.C(EL_SCK),
        .CE(\do_buffer_reg[15]_i_1__0_n_0 ),
        .D(do_buffer_next__0[2]),
        .Q(Q[2]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[3] 
       (.C(EL_SCK),
        .CE(\do_buffer_reg[15]_i_1__0_n_0 ),
        .D(do_buffer_next__0[3]),
        .Q(Q[3]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[4] 
       (.C(EL_SCK),
        .CE(\do_buffer_reg[15]_i_1__0_n_0 ),
        .D(do_buffer_next__0[4]),
        .Q(Q[4]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[5] 
       (.C(EL_SCK),
        .CE(\do_buffer_reg[15]_i_1__0_n_0 ),
        .D(do_buffer_next__0[5]),
        .Q(Q[5]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[6] 
       (.C(EL_SCK),
        .CE(\do_buffer_reg[15]_i_1__0_n_0 ),
        .D(do_buffer_next__0[6]),
        .Q(Q[6]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[7] 
       (.C(EL_SCK),
        .CE(\do_buffer_reg[15]_i_1__0_n_0 ),
        .D(do_buffer_next__0[7]),
        .Q(Q[7]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[8] 
       (.C(EL_SCK),
        .CE(\do_buffer_reg[15]_i_1__0_n_0 ),
        .D(do_buffer_next__0[8]),
        .Q(Q[8]),
        .R(1'b0));
  FDRE \do_buffer_reg_reg[9] 
       (.C(EL_SCK),
        .CE(\do_buffer_reg[15]_i_1__0_n_0 ),
        .D(do_buffer_next__0[9]),
        .Q(Q[9]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hAAAABFBE00000004)) 
    do_transfer_reg_i_1__0
       (.I0(state_reg[4]),
        .I1(state_reg[1]),
        .I2(state_reg[2]),
        .I3(state_reg[0]),
        .I4(state_reg[3]),
        .I5(do_transfer_reg_reg_n_0),
        .O(do_transfer_reg_i_1__0_n_0));
  FDRE #(
    .INIT(1'b0)) 
    do_transfer_reg_reg
       (.C(EL_SCK),
        .CE(1'b1),
        .D(do_transfer_reg_i_1__0_n_0),
        .Q(do_transfer_reg_reg_n_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    do_valid_A_reg
       (.C(aclk),
        .CE(1'b1),
        .D(do_transfer_reg_reg_n_0),
        .Q(do_valid_A),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    do_valid_B_reg
       (.C(aclk),
        .CE(1'b1),
        .D(do_valid_A),
        .Q(do_valid_B),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    do_valid_C_reg
       (.C(aclk),
        .CE(1'b1),
        .D(do_valid_B),
        .Q(do_valid_C_reg_n_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    do_valid_D_reg
       (.C(aclk),
        .CE(1'b1),
        .D(do_valid_C_reg_n_0),
        .Q(do_valid_D),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h40)) 
    do_valid_next0
       (.I0(do_valid_D),
        .I1(do_valid_A),
        .I2(do_valid_B),
        .O(do_valid_next));
  FDRE #(
    .INIT(1'b0)) 
    do_valid_o_reg_reg
       (.C(aclk),
        .CE(1'b1),
        .D(do_valid_next),
        .Q(E),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hF0F1FFFFF0E00000)) 
    \sh_reg[0]_i_1__0 
       (.I0(state_reg[3]),
        .I1(\sh_reg[14]_i_3__0_n_0 ),
        .I2(do_buffer_next__0[1]),
        .I3(\sh_reg[14]_i_2__0_n_0 ),
        .I4(state_reg[4]),
        .I5(EL_MOSI),
        .O(sh_next[0]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[10]_i_1__0 
       (.I0(do_buffer_next__0[11]),
        .I1(\sh_reg[14]_i_2__0_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3__0_n_0 ),
        .I5(do_buffer_next__0[10]),
        .O(sh_next[10]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[11]_i_1__0 
       (.I0(do_buffer_next__0[12]),
        .I1(\sh_reg[14]_i_2__0_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3__0_n_0 ),
        .I5(do_buffer_next__0[11]),
        .O(sh_next[11]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[12]_i_1__0 
       (.I0(do_buffer_next__0[13]),
        .I1(\sh_reg[14]_i_2__0_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3__0_n_0 ),
        .I5(do_buffer_next__0[12]),
        .O(sh_next[12]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[13]_i_1__0 
       (.I0(do_buffer_next__0[14]),
        .I1(\sh_reg[14]_i_2__0_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3__0_n_0 ),
        .I5(do_buffer_next__0[13]),
        .O(sh_next[13]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[14]_i_1__0 
       (.I0(do_buffer_next__0[15]),
        .I1(\sh_reg[14]_i_2__0_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3__0_n_0 ),
        .I5(do_buffer_next__0[14]),
        .O(sh_next[14]));
  LUT3 #(
    .INIT(8'hBA)) 
    \sh_reg[14]_i_2__0 
       (.I0(state_reg[2]),
        .I1(state_reg[1]),
        .I2(state_reg[0]),
        .O(\sh_reg[14]_i_2__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \sh_reg[14]_i_3__0 
       (.I0(state_reg[1]),
        .I1(state_reg[2]),
        .O(\sh_reg[14]_i_3__0_n_0 ));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[1]_i_1__0 
       (.I0(do_buffer_next__0[2]),
        .I1(\sh_reg[14]_i_2__0_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3__0_n_0 ),
        .I5(do_buffer_next__0[1]),
        .O(sh_next[1]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[2]_i_1__0 
       (.I0(do_buffer_next__0[3]),
        .I1(\sh_reg[14]_i_2__0_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3__0_n_0 ),
        .I5(do_buffer_next__0[2]),
        .O(sh_next[2]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[3]_i_1__0 
       (.I0(do_buffer_next__0[4]),
        .I1(\sh_reg[14]_i_2__0_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3__0_n_0 ),
        .I5(do_buffer_next__0[3]),
        .O(sh_next[3]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[4]_i_1__0 
       (.I0(do_buffer_next__0[5]),
        .I1(\sh_reg[14]_i_2__0_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3__0_n_0 ),
        .I5(do_buffer_next__0[4]),
        .O(sh_next[4]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[5]_i_1__0 
       (.I0(do_buffer_next__0[6]),
        .I1(\sh_reg[14]_i_2__0_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3__0_n_0 ),
        .I5(do_buffer_next__0[5]),
        .O(sh_next[5]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[6]_i_1__0 
       (.I0(do_buffer_next__0[7]),
        .I1(\sh_reg[14]_i_2__0_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3__0_n_0 ),
        .I5(do_buffer_next__0[6]),
        .O(sh_next[6]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[7]_i_1__0 
       (.I0(do_buffer_next__0[8]),
        .I1(\sh_reg[14]_i_2__0_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3__0_n_0 ),
        .I5(do_buffer_next__0[7]),
        .O(sh_next[7]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[8]_i_1__0 
       (.I0(do_buffer_next__0[9]),
        .I1(\sh_reg[14]_i_2__0_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3__0_n_0 ),
        .I5(do_buffer_next__0[8]),
        .O(sh_next[8]));
  LUT6 #(
    .INIT(64'hAFAFAFB0A0A0A080)) 
    \sh_reg[9]_i_1__0 
       (.I0(do_buffer_next__0[10]),
        .I1(\sh_reg[14]_i_2__0_n_0 ),
        .I2(state_reg[4]),
        .I3(state_reg[3]),
        .I4(\sh_reg[14]_i_3__0_n_0 ),
        .I5(do_buffer_next__0[9]),
        .O(sh_next[9]));
  FDRE \sh_reg_reg[0] 
       (.C(EL_SCK),
        .CE(1'b1),
        .D(sh_next[0]),
        .Q(do_buffer_next__0[1]),
        .R(1'b0));
  FDRE \sh_reg_reg[10] 
       (.C(EL_SCK),
        .CE(1'b1),
        .D(sh_next[10]),
        .Q(do_buffer_next__0[11]),
        .R(1'b0));
  FDRE \sh_reg_reg[11] 
       (.C(EL_SCK),
        .CE(1'b1),
        .D(sh_next[11]),
        .Q(do_buffer_next__0[12]),
        .R(1'b0));
  FDRE \sh_reg_reg[12] 
       (.C(EL_SCK),
        .CE(1'b1),
        .D(sh_next[12]),
        .Q(do_buffer_next__0[13]),
        .R(1'b0));
  FDRE \sh_reg_reg[13] 
       (.C(EL_SCK),
        .CE(1'b1),
        .D(sh_next[13]),
        .Q(do_buffer_next__0[14]),
        .R(1'b0));
  FDRE \sh_reg_reg[14] 
       (.C(EL_SCK),
        .CE(1'b1),
        .D(sh_next[14]),
        .Q(do_buffer_next__0[15]),
        .R(1'b0));
  FDRE \sh_reg_reg[1] 
       (.C(EL_SCK),
        .CE(1'b1),
        .D(sh_next[1]),
        .Q(do_buffer_next__0[2]),
        .R(1'b0));
  FDRE \sh_reg_reg[2] 
       (.C(EL_SCK),
        .CE(1'b1),
        .D(sh_next[2]),
        .Q(do_buffer_next__0[3]),
        .R(1'b0));
  FDRE \sh_reg_reg[3] 
       (.C(EL_SCK),
        .CE(1'b1),
        .D(sh_next[3]),
        .Q(do_buffer_next__0[4]),
        .R(1'b0));
  FDRE \sh_reg_reg[4] 
       (.C(EL_SCK),
        .CE(1'b1),
        .D(sh_next[4]),
        .Q(do_buffer_next__0[5]),
        .R(1'b0));
  FDRE \sh_reg_reg[5] 
       (.C(EL_SCK),
        .CE(1'b1),
        .D(sh_next[5]),
        .Q(do_buffer_next__0[6]),
        .R(1'b0));
  FDRE \sh_reg_reg[6] 
       (.C(EL_SCK),
        .CE(1'b1),
        .D(sh_next[6]),
        .Q(do_buffer_next__0[7]),
        .R(1'b0));
  FDRE \sh_reg_reg[7] 
       (.C(EL_SCK),
        .CE(1'b1),
        .D(sh_next[7]),
        .Q(do_buffer_next__0[8]),
        .R(1'b0));
  FDRE \sh_reg_reg[8] 
       (.C(EL_SCK),
        .CE(1'b1),
        .D(sh_next[8]),
        .Q(do_buffer_next__0[9]),
        .R(1'b0));
  FDRE \sh_reg_reg[9] 
       (.C(EL_SCK),
        .CE(1'b1),
        .D(sh_next[9]),
        .Q(do_buffer_next__0[10]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT5 #(
    .INIT(32'h00005556)) 
    \state_reg[0]_i_1__0 
       (.I0(state_reg[4]),
        .I1(state_reg[3]),
        .I2(state_reg[1]),
        .I3(state_reg[2]),
        .I4(state_reg[0]),
        .O(\state_reg[0]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT5 #(
    .INIT(32'h55000056)) 
    \state_reg[1]_i_1__0 
       (.I0(state_reg[4]),
        .I1(state_reg[3]),
        .I2(state_reg[2]),
        .I3(state_reg[1]),
        .I4(state_reg[0]),
        .O(\state_reg[1]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT5 #(
    .INIT(32'h50505006)) 
    \state_reg[2]_i_1__0 
       (.I0(state_reg[4]),
        .I1(state_reg[3]),
        .I2(state_reg[2]),
        .I3(state_reg[0]),
        .I4(state_reg[1]),
        .O(\state_reg[2]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT5 #(
    .INIT(32'h44444442)) 
    \state_reg[3]_i_1__0 
       (.I0(state_reg[4]),
        .I1(state_reg[3]),
        .I2(state_reg[1]),
        .I3(state_reg[0]),
        .I4(state_reg[2]),
        .O(\state_reg[3]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \state_reg[4]_i_1__0 
       (.I0(state_reg[4]),
        .I1(state_reg[2]),
        .I2(state_reg[1]),
        .I3(state_reg[3]),
        .O(state_next));
  FDCE #(
    .INIT(1'b0)) 
    \state_reg_reg[0] 
       (.C(EL_SCK),
        .CE(1'b1),
        .CLR(EL_SSEL),
        .D(\state_reg[0]_i_1__0_n_0 ),
        .Q(state_reg[0]));
  FDCE #(
    .INIT(1'b0)) 
    \state_reg_reg[1] 
       (.C(EL_SCK),
        .CE(1'b1),
        .CLR(EL_SSEL),
        .D(\state_reg[1]_i_1__0_n_0 ),
        .Q(state_reg[1]));
  FDCE #(
    .INIT(1'b0)) 
    \state_reg_reg[2] 
       (.C(EL_SCK),
        .CE(1'b1),
        .CLR(EL_SSEL),
        .D(\state_reg[2]_i_1__0_n_0 ),
        .Q(state_reg[2]));
  FDCE #(
    .INIT(1'b0)) 
    \state_reg_reg[3] 
       (.C(EL_SCK),
        .CE(1'b1),
        .CLR(EL_SSEL),
        .D(\state_reg[3]_i_1__0_n_0 ),
        .Q(state_reg[3]));
  FDCE #(
    .INIT(1'b0)) 
    \state_reg_reg[4] 
       (.C(EL_SCK),
        .CE(1'b1),
        .CLR(EL_SSEL),
        .D(state_next),
        .Q(state_reg[4]));
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
