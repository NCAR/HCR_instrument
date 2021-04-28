// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
// Date        : Tue Apr 27 22:17:20 2021
// Host        : wind running 64-bit unknown
// Command     : write_verilog -force -mode funcsim
//               /home/karboski/git/HCR_instrument/src/Pentek821/FDK/2017.2/p71821_060/p71821.srcs/sources_1/bd/user_block2/ip/user_block2_hcr_metadata_injector_0_0/user_block2_hcr_metadata_injector_0_0_sim_netlist.v
// Design      : user_block2_hcr_metadata_injector_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku060-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "user_block2_hcr_metadata_injector_0_0,hcr_metadata_injector,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "hcr_metadata_injector,Vivado 2017.2" *) 
(* NotValidForBitStream *)
module user_block2_hcr_metadata_injector_0_0
   (ap_clk,
    ap_rst_n,
    ap_start,
    ap_done,
    ap_idle,
    ap_ready,
    i_data_TVALID,
    i_data_TREADY,
    i_data_TDATA,
    i_data_TDEST,
    i_data_TKEEP,
    i_data_TSTRB,
    i_data_TUSER,
    i_data_TLAST,
    i_data_TID,
    o_data_TVALID,
    o_data_TREADY,
    o_data_TDATA,
    o_data_TDEST,
    o_data_TKEEP,
    o_data_TSTRB,
    o_data_TUSER,
    o_data_TLAST,
    o_data_TID,
    pulse_metadata_V_TVALID,
    pulse_metadata_V_TREADY,
    pulse_metadata_V_TDATA,
    pos_enc_0,
    pos_enc_1,
    flags);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 ap_clk CLK" *) input ap_clk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *) input ap_rst_n;
  (* x_interface_info = "xilinx.com:interface:acc_handshake:1.0 ap_ctrl start" *) input ap_start;
  (* x_interface_info = "xilinx.com:interface:acc_handshake:1.0 ap_ctrl done" *) output ap_done;
  (* x_interface_info = "xilinx.com:interface:acc_handshake:1.0 ap_ctrl idle" *) output ap_idle;
  (* x_interface_info = "xilinx.com:interface:acc_handshake:1.0 ap_ctrl ready" *) output ap_ready;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 i_data TVALID" *) input i_data_TVALID;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 i_data TREADY" *) output i_data_TREADY;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 i_data TDATA" *) input [31:0]i_data_TDATA;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 i_data TDEST" *) input [0:0]i_data_TDEST;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 i_data TKEEP" *) input [3:0]i_data_TKEEP;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 i_data TSTRB" *) input [3:0]i_data_TSTRB;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 i_data TUSER" *) input [127:0]i_data_TUSER;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 i_data TLAST" *) input [0:0]i_data_TLAST;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 i_data TID" *) input [0:0]i_data_TID;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 o_data TVALID" *) output o_data_TVALID;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 o_data TREADY" *) input o_data_TREADY;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 o_data TDATA" *) output [31:0]o_data_TDATA;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 o_data TDEST" *) output [0:0]o_data_TDEST;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 o_data TKEEP" *) output [3:0]o_data_TKEEP;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 o_data TSTRB" *) output [3:0]o_data_TSTRB;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 o_data TUSER" *) output [127:0]o_data_TUSER;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 o_data TLAST" *) output [0:0]o_data_TLAST;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 o_data TID" *) output [0:0]o_data_TID;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 pulse_metadata_V TVALID" *) input pulse_metadata_V_TVALID;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 pulse_metadata_V TREADY" *) output pulse_metadata_V_TREADY;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 pulse_metadata_V TDATA" *) input [823:0]pulse_metadata_V_TDATA;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pos_enc_0 DATA" *) input [31:0]pos_enc_0;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pos_enc_1 DATA" *) input [31:0]pos_enc_1;
  (* x_interface_info = "xilinx.com:signal:data:1.0 flags DATA" *) input [15:0]flags;

  wire ap_clk;
  wire ap_done;
  wire ap_idle;
  wire ap_ready;
  wire ap_rst_n;
  wire ap_start;
  wire [15:0]flags;
  wire [31:0]i_data_TDATA;
  wire [0:0]i_data_TDEST;
  wire [0:0]i_data_TID;
  wire [3:0]i_data_TKEEP;
  wire [0:0]i_data_TLAST;
  wire i_data_TREADY;
  wire [3:0]i_data_TSTRB;
  wire [127:0]i_data_TUSER;
  wire i_data_TVALID;
  wire [31:0]o_data_TDATA;
  wire [0:0]o_data_TDEST;
  wire [0:0]o_data_TID;
  wire [3:0]o_data_TKEEP;
  wire [0:0]o_data_TLAST;
  wire o_data_TREADY;
  wire [3:0]o_data_TSTRB;
  wire [127:0]o_data_TUSER;
  wire o_data_TVALID;
  wire [31:0]pos_enc_0;
  wire [31:0]pos_enc_1;
  wire [823:0]pulse_metadata_V_TDATA;
  wire pulse_metadata_V_TREADY;
  wire pulse_metadata_V_TVALID;

  user_block2_hcr_metadata_injector_0_0_hcr_metadata_injector U0
       (.ap_clk(ap_clk),
        .ap_done(ap_done),
        .ap_idle(ap_idle),
        .ap_ready(ap_ready),
        .ap_rst_n(ap_rst_n),
        .ap_start(ap_start),
        .flags(flags),
        .i_data_TDATA(i_data_TDATA),
        .i_data_TDEST(i_data_TDEST),
        .i_data_TID(i_data_TID),
        .i_data_TKEEP(i_data_TKEEP),
        .i_data_TLAST(i_data_TLAST),
        .i_data_TREADY(i_data_TREADY),
        .i_data_TSTRB(i_data_TSTRB),
        .i_data_TUSER(i_data_TUSER),
        .i_data_TVALID(i_data_TVALID),
        .o_data_TDATA(o_data_TDATA),
        .o_data_TDEST(o_data_TDEST),
        .o_data_TID(o_data_TID),
        .o_data_TKEEP(o_data_TKEEP),
        .o_data_TLAST(o_data_TLAST),
        .o_data_TREADY(o_data_TREADY),
        .o_data_TSTRB(o_data_TSTRB),
        .o_data_TUSER(o_data_TUSER),
        .o_data_TVALID(o_data_TVALID),
        .pos_enc_0(pos_enc_0),
        .pos_enc_1(pos_enc_1),
        .pulse_metadata_V_TDATA(pulse_metadata_V_TDATA),
        .pulse_metadata_V_TREADY(pulse_metadata_V_TREADY),
        .pulse_metadata_V_TVALID(pulse_metadata_V_TVALID));
endmodule

(* ORIG_REF_NAME = "handle_header" *) 
module user_block2_hcr_metadata_injector_0_0_handle_header
   (\o_data_V_data_V_1_state_reg[0] ,
    \decimation_value_fu_102_reg[0] ,
    \o_data_V_keep_V_1_state_reg[0] ,
    \o_data_V_strb_V_1_state_reg[0] ,
    \o_data_V_user_V_1_state_reg[0] ,
    \o_data_V_last_V_1_state_reg[0] ,
    \o_data_V_id_V_1_state_reg[0] ,
    \o_data_V_dest_V_1_state_reg[0] ,
    \pulse_metadata_V_0_state_reg[0] ,
    \o_data_V_user_V_1_payload_A_reg[72] ,
    \o_data_V_data_V_1_payload_B_reg[31] ,
    \sample_counter_fu_94_reg[31] ,
    E,
    \in_a_xfer_bundle_fu_90_reg[0] ,
    \in_a_pulse_fu_86_reg[0] ,
    \ap_CS_fsm_reg[4]_0 ,
    num_samples_fu_110,
    \decimation_counter_fu_98_reg[0] ,
    \decimation_counter_fu_98_reg[7] ,
    ap_rst,
    \o_data_V_data_V_1_state_reg[1] ,
    \o_data_V_keep_V_1_state_reg[1] ,
    \o_data_V_strb_V_1_state_reg[1] ,
    \o_data_V_user_V_1_state_reg[1] ,
    \o_data_V_last_V_1_state_reg[1] ,
    \o_data_V_id_V_1_state_reg[1] ,
    \o_data_V_dest_V_1_state_reg[1] ,
    o_data_V_dest_V_1_sel_wr_reg,
    o_data_V_id_V_1_sel_wr_reg,
    o_data_V_last_V_1_sel_wr_reg,
    o_data_V_user_V_1_sel_wr_reg,
    o_data_V_strb_V_1_sel_wr_reg,
    o_data_V_keep_V_1_sel_wr_reg,
    o_data_V_data_V_1_sel_wr_reg,
    \decimation_value_fu_102_reg[7] ,
    \pulse_metadata_V_0_state_reg[1] ,
    pulse_metadata_V_0_sel_rd_reg,
    ap_reg_grp_handle_header_fu_175_ap_start_reg,
    in_a_xfer_bundle_fu_90,
    ap_return_6,
    ap_return_4,
    ap_return_3,
    ap_rst_n,
    o_data_TREADY,
    o_data_V_data_V_1_ack_in,
    \o_data_V_data_V_1_state_reg[0]_0 ,
    D,
    ap_NS_fsm1115_out,
    o_data_V_keep_V_1_ack_in,
    \o_data_V_keep_V_1_state_reg[0]_0 ,
    o_data_V_strb_V_1_ack_in,
    \o_data_V_strb_V_1_state_reg[0]_0 ,
    o_data_V_user_V_1_ack_in,
    \o_data_V_user_V_1_state_reg[0]_0 ,
    o_data_V_last_V_1_ack_in,
    \o_data_V_last_V_1_state_reg[0]_0 ,
    o_data_V_id_V_1_ack_in,
    \o_data_V_id_V_1_state_reg[0]_0 ,
    o_data_TREADY43_in,
    \o_data_V_dest_V_1_state_reg[0]_0 ,
    ap_reg_grp_handle_header_fu_175_ap_start_reg_0,
    pulse_metadata_V_TVALID,
    \pulse_metadata_V_0_state_reg[1]_0 ,
    \pulse_metadata_V_0_state_reg[0]_0 ,
    \in_a_pulse_fu_86_reg[0]_0 ,
    CO,
    o_data_V_data_V_1_data_in1,
    Q,
    \i_data_V_data_V_0_payload_A_reg[31] ,
    i_data_V_data_V_0_sel,
    \ap_CS_fsm_reg[4]_1 ,
    tmp_2_fu_295_p3,
    brmerge_fu_387_p2,
    \i_data_V_data_V_0_state_reg[0] ,
    \tmp_2_reg_618_reg[0] ,
    \i_data_V_data_V_0_payload_B_reg[28] ,
    \tmp_data_V_reg_577_reg[31] ,
    \sample_counter_fu_94_reg[0] ,
    ap_start,
    dec_keep_reg_667,
    in_a_xfer_bundle_3_reg_657,
    in_a_pulse_2_reg_662,
    sample_counter_1_fu_430_p2,
    ap_done,
    p_222_in,
    o_data_V_data_V_1_vld_in1,
    \decimation_counter_fu_98_reg[6] ,
    \decimation_counter_fu_98_reg[6]_0 ,
    \decimation_counter_fu_98_reg[5] ,
    \decimation_counter_fu_98_reg[4] ,
    \decimation_counter_fu_98_reg[3] ,
    \decimation_counter_fu_98_reg[2] ,
    \decimation_counter_fu_98_reg[0]_0 ,
    \decimation_counter_fu_98_reg[0]_1 ,
    brmerge_reg_672,
    o_data_V_dest_V_1_sel_wr,
    o_data_V_id_V_1_sel_wr,
    o_data_V_last_V_1_sel_wr,
    o_data_V_user_V_1_sel_wr,
    o_data_V_strb_V_1_sel_wr,
    o_data_V_keep_V_1_sel_wr,
    o_data_V_data_V_1_sel_wr,
    \sample_counter_load_1_reg_632_reg[31] ,
    \pulse_metadata_V_0_payload_B_reg[820] ,
    \pulse_metadata_V_0_payload_A_reg[820] ,
    pulse_metadata_V_0_sel,
    \i_data_V_user_V_0_payload_B_reg[72] ,
    \i_data_V_user_V_0_payload_A_reg[72] ,
    i_data_V_user_V_0_sel,
    ap_clk,
    \flags_read_reg_691_reg[15] ,
    \decimation_counter_l_reg_637_reg[7] ,
    in_a_xfer_bundle_loa_reg_627,
    in_a_pulse_load_reg_622,
    break_after_pulse_lo_reg_647,
    \num_samples_load_reg_652_reg[31] ,
    \pos_enc_1_read_reg_686_reg[31] ,
    \pos_enc_0_read_reg_681_reg[31] ,
    \decimation_value_loa_reg_642_reg[7] );
  output \o_data_V_data_V_1_state_reg[0] ;
  output \decimation_value_fu_102_reg[0] ;
  output \o_data_V_keep_V_1_state_reg[0] ;
  output \o_data_V_strb_V_1_state_reg[0] ;
  output \o_data_V_user_V_1_state_reg[0] ;
  output \o_data_V_last_V_1_state_reg[0] ;
  output \o_data_V_id_V_1_state_reg[0] ;
  output \o_data_V_dest_V_1_state_reg[0] ;
  output \pulse_metadata_V_0_state_reg[0] ;
  output [1:0]\o_data_V_user_V_1_payload_A_reg[72] ;
  output [31:0]\o_data_V_data_V_1_payload_B_reg[31] ;
  output [31:0]\sample_counter_fu_94_reg[31] ;
  output [0:0]E;
  output \in_a_xfer_bundle_fu_90_reg[0] ;
  output \in_a_pulse_fu_86_reg[0] ;
  output [2:0]\ap_CS_fsm_reg[4]_0 ;
  output num_samples_fu_110;
  output [0:0]\decimation_counter_fu_98_reg[0] ;
  output [7:0]\decimation_counter_fu_98_reg[7] ;
  output ap_rst;
  output \o_data_V_data_V_1_state_reg[1] ;
  output \o_data_V_keep_V_1_state_reg[1] ;
  output \o_data_V_strb_V_1_state_reg[1] ;
  output \o_data_V_user_V_1_state_reg[1] ;
  output \o_data_V_last_V_1_state_reg[1] ;
  output \o_data_V_id_V_1_state_reg[1] ;
  output \o_data_V_dest_V_1_state_reg[1] ;
  output o_data_V_dest_V_1_sel_wr_reg;
  output o_data_V_id_V_1_sel_wr_reg;
  output o_data_V_last_V_1_sel_wr_reg;
  output o_data_V_user_V_1_sel_wr_reg;
  output o_data_V_strb_V_1_sel_wr_reg;
  output o_data_V_keep_V_1_sel_wr_reg;
  output o_data_V_data_V_1_sel_wr_reg;
  output \decimation_value_fu_102_reg[7] ;
  output \pulse_metadata_V_0_state_reg[1] ;
  output pulse_metadata_V_0_sel_rd_reg;
  output ap_reg_grp_handle_header_fu_175_ap_start_reg;
  output in_a_xfer_bundle_fu_90;
  output [31:0]ap_return_6;
  output [6:0]ap_return_4;
  output ap_return_3;
  input ap_rst_n;
  input o_data_TREADY;
  input o_data_V_data_V_1_ack_in;
  input \o_data_V_data_V_1_state_reg[0]_0 ;
  input [0:0]D;
  input ap_NS_fsm1115_out;
  input o_data_V_keep_V_1_ack_in;
  input \o_data_V_keep_V_1_state_reg[0]_0 ;
  input o_data_V_strb_V_1_ack_in;
  input \o_data_V_strb_V_1_state_reg[0]_0 ;
  input o_data_V_user_V_1_ack_in;
  input \o_data_V_user_V_1_state_reg[0]_0 ;
  input o_data_V_last_V_1_ack_in;
  input \o_data_V_last_V_1_state_reg[0]_0 ;
  input o_data_V_id_V_1_ack_in;
  input \o_data_V_id_V_1_state_reg[0]_0 ;
  input o_data_TREADY43_in;
  input \o_data_V_dest_V_1_state_reg[0]_0 ;
  input ap_reg_grp_handle_header_fu_175_ap_start_reg_0;
  input pulse_metadata_V_TVALID;
  input \pulse_metadata_V_0_state_reg[1]_0 ;
  input \pulse_metadata_V_0_state_reg[0]_0 ;
  input \in_a_pulse_fu_86_reg[0]_0 ;
  input [0:0]CO;
  input o_data_V_data_V_1_data_in1;
  input [23:0]Q;
  input [23:0]\i_data_V_data_V_0_payload_A_reg[31] ;
  input i_data_V_data_V_0_sel;
  input [3:0]\ap_CS_fsm_reg[4]_1 ;
  input tmp_2_fu_295_p3;
  input brmerge_fu_387_p2;
  input \i_data_V_data_V_0_state_reg[0] ;
  input \tmp_2_reg_618_reg[0] ;
  input [7:0]\i_data_V_data_V_0_payload_B_reg[28] ;
  input [31:0]\tmp_data_V_reg_577_reg[31] ;
  input [0:0]\sample_counter_fu_94_reg[0] ;
  input ap_start;
  input dec_keep_reg_667;
  input in_a_xfer_bundle_3_reg_657;
  input in_a_pulse_2_reg_662;
  input [30:0]sample_counter_1_fu_430_p2;
  input ap_done;
  input p_222_in;
  input o_data_V_data_V_1_vld_in1;
  input \decimation_counter_fu_98_reg[6] ;
  input \decimation_counter_fu_98_reg[6]_0 ;
  input \decimation_counter_fu_98_reg[5] ;
  input \decimation_counter_fu_98_reg[4] ;
  input \decimation_counter_fu_98_reg[3] ;
  input \decimation_counter_fu_98_reg[2] ;
  input \decimation_counter_fu_98_reg[0]_0 ;
  input \decimation_counter_fu_98_reg[0]_1 ;
  input brmerge_reg_672;
  input o_data_V_dest_V_1_sel_wr;
  input o_data_V_id_V_1_sel_wr;
  input o_data_V_last_V_1_sel_wr;
  input o_data_V_user_V_1_sel_wr;
  input o_data_V_strb_V_1_sel_wr;
  input o_data_V_keep_V_1_sel_wr;
  input o_data_V_data_V_1_sel_wr;
  input [31:0]\sample_counter_load_1_reg_632_reg[31] ;
  input [84:0]\pulse_metadata_V_0_payload_B_reg[820] ;
  input [84:0]\pulse_metadata_V_0_payload_A_reg[820] ;
  input pulse_metadata_V_0_sel;
  input [0:0]\i_data_V_user_V_0_payload_B_reg[72] ;
  input [0:0]\i_data_V_user_V_0_payload_A_reg[72] ;
  input i_data_V_user_V_0_sel;
  input ap_clk;
  input [15:0]\flags_read_reg_691_reg[15] ;
  input [7:0]\decimation_counter_l_reg_637_reg[7] ;
  input in_a_xfer_bundle_loa_reg_627;
  input in_a_pulse_load_reg_622;
  input break_after_pulse_lo_reg_647;
  input [31:0]\num_samples_load_reg_652_reg[31] ;
  input [31:0]\pos_enc_1_read_reg_686_reg[31] ;
  input [31:0]\pos_enc_0_read_reg_681_reg[31] ;
  input [7:0]\decimation_value_loa_reg_642_reg[7] ;

  wire [0:0]CO;
  wire [0:0]D;
  wire [0:0]E;
  wire [23:0]Q;
  wire \ap_CS_fsm[1]_i_2_n_0 ;
  wire \ap_CS_fsm[1]_i_3_n_0 ;
  wire \ap_CS_fsm[4]_i_2_n_0 ;
  wire ap_CS_fsm_pp0_stage0;
  wire ap_CS_fsm_pp1_stage0;
  wire [2:0]\ap_CS_fsm_reg[4]_0 ;
  wire [3:0]\ap_CS_fsm_reg[4]_1 ;
  wire \ap_CS_fsm_reg_n_0_[0] ;
  wire ap_CS_fsm_state4;
  wire ap_CS_fsm_state7;
  wire [4:0]ap_NS_fsm;
  wire ap_NS_fsm1115_out;
  wire ap_NS_fsm129_out;
  wire ap_NS_fsm3;
  wire ap_clk;
  wire ap_condition_pp1_exit_iter0_state5;
  wire ap_done;
  wire ap_enable_reg_pp0_iter0;
  wire ap_enable_reg_pp0_iter0_i_10_n_0;
  wire ap_enable_reg_pp0_iter0_i_11_n_0;
  wire ap_enable_reg_pp0_iter0_i_12_n_0;
  wire ap_enable_reg_pp0_iter0_i_13_n_0;
  wire ap_enable_reg_pp0_iter0_i_14_n_0;
  wire ap_enable_reg_pp0_iter0_i_15_n_0;
  wire ap_enable_reg_pp0_iter0_i_16_n_0;
  wire ap_enable_reg_pp0_iter0_i_17_n_0;
  wire ap_enable_reg_pp0_iter0_i_18_n_0;
  wire ap_enable_reg_pp0_iter0_i_19_n_0;
  wire ap_enable_reg_pp0_iter0_i_1_n_0;
  wire ap_enable_reg_pp0_iter0_i_20_n_0;
  wire ap_enable_reg_pp0_iter0_i_21_n_0;
  wire ap_enable_reg_pp0_iter0_i_22_n_0;
  wire ap_enable_reg_pp0_iter0_i_23_n_0;
  wire ap_enable_reg_pp0_iter0_i_24_n_0;
  wire ap_enable_reg_pp0_iter0_i_25_n_0;
  wire ap_enable_reg_pp0_iter0_i_26_n_0;
  wire ap_enable_reg_pp0_iter0_i_27_n_0;
  wire ap_enable_reg_pp0_iter0_i_28_n_0;
  wire ap_enable_reg_pp0_iter0_i_29_n_0;
  wire ap_enable_reg_pp0_iter0_i_2_n_0;
  wire ap_enable_reg_pp0_iter0_i_30_n_0;
  wire ap_enable_reg_pp0_iter0_i_31_n_0;
  wire ap_enable_reg_pp0_iter0_i_32_n_0;
  wire ap_enable_reg_pp0_iter0_i_33_n_0;
  wire ap_enable_reg_pp0_iter0_i_34_n_0;
  wire ap_enable_reg_pp0_iter0_i_35_n_0;
  wire ap_enable_reg_pp0_iter0_i_36_n_0;
  wire ap_enable_reg_pp0_iter0_i_37_n_0;
  wire ap_enable_reg_pp0_iter0_i_3_n_0;
  wire ap_enable_reg_pp0_iter0_i_6_n_0;
  wire ap_enable_reg_pp0_iter0_i_7_n_0;
  wire ap_enable_reg_pp0_iter0_i_8_n_0;
  wire ap_enable_reg_pp0_iter0_i_9_n_0;
  wire ap_enable_reg_pp0_iter0_reg_i_4_n_1;
  wire ap_enable_reg_pp0_iter0_reg_i_4_n_2;
  wire ap_enable_reg_pp0_iter0_reg_i_4_n_3;
  wire ap_enable_reg_pp0_iter0_reg_i_4_n_5;
  wire ap_enable_reg_pp0_iter0_reg_i_4_n_6;
  wire ap_enable_reg_pp0_iter0_reg_i_4_n_7;
  wire ap_enable_reg_pp0_iter0_reg_i_5_n_0;
  wire ap_enable_reg_pp0_iter0_reg_i_5_n_1;
  wire ap_enable_reg_pp0_iter0_reg_i_5_n_2;
  wire ap_enable_reg_pp0_iter0_reg_i_5_n_3;
  wire ap_enable_reg_pp0_iter0_reg_i_5_n_5;
  wire ap_enable_reg_pp0_iter0_reg_i_5_n_6;
  wire ap_enable_reg_pp0_iter0_reg_i_5_n_7;
  wire ap_enable_reg_pp0_iter1_i_1_n_0;
  wire ap_enable_reg_pp0_iter1_reg_n_0;
  wire ap_enable_reg_pp1_iter0;
  wire ap_enable_reg_pp1_iter0_i_1_n_0;
  wire ap_enable_reg_pp1_iter0_i_2_n_0;
  wire ap_enable_reg_pp1_iter1_i_1_n_0;
  wire ap_enable_reg_pp1_iter1_reg_n_0;
  wire ap_reg_grp_handle_header_fu_175_ap_start_reg;
  wire ap_reg_grp_handle_header_fu_175_ap_start_reg_0;
  wire ap_reg_ioackin_o_data_TREADY338_out;
  wire ap_reg_ioackin_o_data_TREADY_i_1_n_0;
  wire ap_reg_ioackin_o_data_TREADY_i_2_n_0;
  wire ap_reg_ioackin_o_data_TREADY_i_3_n_0;
  wire ap_reg_ioackin_o_data_TREADY_i_4_n_0;
  wire ap_reg_ioackin_o_data_TREADY_reg_n_0;
  wire ap_return_0_preg;
  wire \ap_return_0_preg[0]_i_1_n_0 ;
  wire ap_return_1_preg;
  wire ap_return_2_preg;
  wire ap_return_3;
  wire ap_return_3_preg;
  wire [6:0]ap_return_4;
  wire [7:0]ap_return_4_preg;
  wire \ap_return_4_preg[7]_i_1_n_0 ;
  wire [7:0]ap_return_5;
  wire [7:0]ap_return_5_preg;
  wire \ap_return_5_preg[1]_i_1_n_0 ;
  wire \ap_return_5_preg[2]_i_1_n_0 ;
  wire \ap_return_5_preg[3]_i_1_n_0 ;
  wire \ap_return_5_preg[4]_i_1_n_0 ;
  wire \ap_return_5_preg[5]_i_1_n_0 ;
  wire \ap_return_5_preg[6]_i_1_n_0 ;
  wire \ap_return_5_preg[7]_i_1_n_0 ;
  wire [31:0]ap_return_6;
  wire [31:0]ap_return_6_preg;
  wire [31:0]ap_return_7_preg;
  wire \ap_return_7_preg[10]_i_1_n_0 ;
  wire \ap_return_7_preg[11]_i_1_n_0 ;
  wire \ap_return_7_preg[12]_i_1_n_0 ;
  wire \ap_return_7_preg[13]_i_1_n_0 ;
  wire \ap_return_7_preg[14]_i_1_n_0 ;
  wire \ap_return_7_preg[15]_i_1_n_0 ;
  wire \ap_return_7_preg[16]_i_1_n_0 ;
  wire \ap_return_7_preg[17]_i_1_n_0 ;
  wire \ap_return_7_preg[18]_i_1_n_0 ;
  wire \ap_return_7_preg[19]_i_1_n_0 ;
  wire \ap_return_7_preg[1]_i_1_n_0 ;
  wire \ap_return_7_preg[20]_i_1_n_0 ;
  wire \ap_return_7_preg[21]_i_1_n_0 ;
  wire \ap_return_7_preg[22]_i_1_n_0 ;
  wire \ap_return_7_preg[23]_i_1_n_0 ;
  wire \ap_return_7_preg[24]_i_1_n_0 ;
  wire \ap_return_7_preg[25]_i_1_n_0 ;
  wire \ap_return_7_preg[26]_i_1_n_0 ;
  wire \ap_return_7_preg[27]_i_1_n_0 ;
  wire \ap_return_7_preg[28]_i_1_n_0 ;
  wire \ap_return_7_preg[29]_i_1_n_0 ;
  wire \ap_return_7_preg[2]_i_1_n_0 ;
  wire \ap_return_7_preg[30]_i_1_n_0 ;
  wire \ap_return_7_preg[31]_i_1_n_0 ;
  wire \ap_return_7_preg[3]_i_1_n_0 ;
  wire \ap_return_7_preg[4]_i_1_n_0 ;
  wire \ap_return_7_preg[5]_i_1_n_0 ;
  wire \ap_return_7_preg[6]_i_1_n_0 ;
  wire \ap_return_7_preg[7]_i_1_n_0 ;
  wire \ap_return_7_preg[8]_i_1_n_0 ;
  wire \ap_return_7_preg[9]_i_1_n_0 ;
  wire ap_rst;
  wire ap_rst_n;
  wire ap_start;
  wire break_after_pulse_lo_reg_647;
  wire break_after_pulse_wr_phi_fu_329_p4;
  wire break_after_pulse_wr_reg_326;
  wire \break_after_pulse_wr_reg_326[0]_i_1_n_0 ;
  wire brmerge_fu_387_p2;
  wire brmerge_reg_672;
  wire dec_keep_reg_667;
  wire [0:0]\decimation_counter_fu_98_reg[0] ;
  wire \decimation_counter_fu_98_reg[0]_0 ;
  wire \decimation_counter_fu_98_reg[0]_1 ;
  wire \decimation_counter_fu_98_reg[2] ;
  wire \decimation_counter_fu_98_reg[3] ;
  wire \decimation_counter_fu_98_reg[4] ;
  wire \decimation_counter_fu_98_reg[5] ;
  wire \decimation_counter_fu_98_reg[6] ;
  wire \decimation_counter_fu_98_reg[6]_0 ;
  wire [7:0]\decimation_counter_fu_98_reg[7] ;
  wire [7:0]\decimation_counter_l_reg_637_reg[7] ;
  wire [0:0]decimation_counter_w_phi_fu_319_p4;
  wire [7:0]decimation_counter_w_reg_316;
  wire [7:0]decimation_value_0_n_reg_732;
  wire \decimation_value_fu_102[7]_i_4_n_0 ;
  wire \decimation_value_fu_102_reg[0] ;
  wire \decimation_value_fu_102_reg[7] ;
  wire [7:0]\decimation_value_loa_reg_642_reg[7] ;
  wire [7:0]decimation_value_wri_phi_fu_310_p4;
  wire [7:0]decimation_value_wri_reg_307;
  wire \decimation_value_wri_reg_307[0]_i_1_n_0 ;
  wire \decimation_value_wri_reg_307[1]_i_1_n_0 ;
  wire \decimation_value_wri_reg_307[2]_i_1_n_0 ;
  wire \decimation_value_wri_reg_307[3]_i_1_n_0 ;
  wire \decimation_value_wri_reg_307[4]_i_1_n_0 ;
  wire \decimation_value_wri_reg_307[5]_i_1_n_0 ;
  wire \decimation_value_wri_reg_307[6]_i_1_n_0 ;
  wire \decimation_value_wri_reg_307[7]_i_2_n_0 ;
  wire [15:0]\flags_read_reg_691_reg[15] ;
  wire grp_handle_header_fu_175_ap_return_0;
  wire [31:0]grp_handle_header_fu_175_o_data_TDATA;
  wire [72:72]grp_handle_header_fu_175_o_data_TUSER;
  wire grp_handle_header_fu_175_pulse_metadata_V_TREADY;
  wire [7:0]header_4_reg_742;
  wire [31:0]header_5_reg_726;
  wire [31:0]header_6_reg_747;
  wire [23:0]\i_data_V_data_V_0_payload_A_reg[31] ;
  wire [7:0]\i_data_V_data_V_0_payload_B_reg[28] ;
  wire i_data_V_data_V_0_sel;
  wire \i_data_V_data_V_0_state_reg[0] ;
  wire [0:0]\i_data_V_user_V_0_payload_A_reg[72] ;
  wire [0:0]\i_data_V_user_V_0_payload_B_reg[72] ;
  wire i_data_V_user_V_0_sel;
  wire in_a_pulse_2_reg_662;
  wire \in_a_pulse_fu_86_reg[0] ;
  wire \in_a_pulse_fu_86_reg[0]_0 ;
  wire in_a_pulse_load_reg_622;
  wire in_a_pulse_write_ass_fu_548_p2;
  wire in_a_xfer_bundle_3_reg_657;
  wire in_a_xfer_bundle_fu_90;
  wire \in_a_xfer_bundle_fu_90_reg[0] ;
  wire in_a_xfer_bundle_loa_reg_627;
  wire in_a_xfer_bundle_wri_fu_553_p2;
  wire [31:0]mux_2_0;
  wire [7:0]mux_2_1;
  wire num_samples_fu_110;
  wire [31:0]\num_samples_load_reg_652_reg[31] ;
  wire [31:0]num_samples_write_as_phi_fu_338_p4;
  wire num_samples_write_as_reg_335;
  wire \num_samples_write_as_reg_335[0]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[10]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[11]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[12]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[13]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[14]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[15]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[16]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[17]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[18]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[19]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[1]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[20]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[21]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[22]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[23]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[24]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[25]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[26]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[27]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[28]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[29]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[2]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[30]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[31]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[3]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[4]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[5]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[6]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[7]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[8]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335[9]_i_1_n_0 ;
  wire \num_samples_write_as_reg_335_reg_n_0_[0] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[10] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[11] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[12] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[13] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[14] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[15] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[16] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[17] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[18] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[19] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[1] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[20] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[21] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[22] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[23] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[24] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[25] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[26] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[27] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[28] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[29] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[2] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[30] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[31] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[3] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[4] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[5] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[6] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[7] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[8] ;
  wire \num_samples_write_as_reg_335_reg_n_0_[9] ;
  wire o_data_TREADY;
  wire o_data_TREADY43_in;
  wire o_data_V_data_V_1_ack_in;
  wire o_data_V_data_V_1_data_in1;
  wire \o_data_V_data_V_1_payload_A[28]_i_2_n_0 ;
  wire [31:0]\o_data_V_data_V_1_payload_B_reg[31] ;
  wire o_data_V_data_V_1_sel_wr;
  wire o_data_V_data_V_1_sel_wr_reg;
  wire \o_data_V_data_V_1_state_reg[0] ;
  wire \o_data_V_data_V_1_state_reg[0]_0 ;
  wire \o_data_V_data_V_1_state_reg[1] ;
  wire o_data_V_data_V_1_vld_in;
  wire o_data_V_data_V_1_vld_in1;
  wire o_data_V_data_V_1_vld_in17_in;
  wire o_data_V_dest_V_1_sel_wr;
  wire o_data_V_dest_V_1_sel_wr_reg;
  wire \o_data_V_dest_V_1_state_reg[0] ;
  wire \o_data_V_dest_V_1_state_reg[0]_0 ;
  wire \o_data_V_dest_V_1_state_reg[1] ;
  wire o_data_V_id_V_1_ack_in;
  wire o_data_V_id_V_1_sel_wr;
  wire o_data_V_id_V_1_sel_wr_reg;
  wire \o_data_V_id_V_1_state_reg[0] ;
  wire \o_data_V_id_V_1_state_reg[0]_0 ;
  wire \o_data_V_id_V_1_state_reg[1] ;
  wire o_data_V_keep_V_1_ack_in;
  wire o_data_V_keep_V_1_sel_wr;
  wire o_data_V_keep_V_1_sel_wr_reg;
  wire \o_data_V_keep_V_1_state_reg[0] ;
  wire \o_data_V_keep_V_1_state_reg[0]_0 ;
  wire \o_data_V_keep_V_1_state_reg[1] ;
  wire o_data_V_last_V_1_ack_in;
  wire o_data_V_last_V_1_sel_wr;
  wire o_data_V_last_V_1_sel_wr_reg;
  wire \o_data_V_last_V_1_state_reg[0] ;
  wire \o_data_V_last_V_1_state_reg[0]_0 ;
  wire \o_data_V_last_V_1_state_reg[1] ;
  wire o_data_V_strb_V_1_ack_in;
  wire o_data_V_strb_V_1_sel_wr;
  wire o_data_V_strb_V_1_sel_wr_reg;
  wire \o_data_V_strb_V_1_state_reg[0] ;
  wire \o_data_V_strb_V_1_state_reg[0]_0 ;
  wire \o_data_V_strb_V_1_state_reg[1] ;
  wire o_data_V_user_V_1_ack_in;
  wire [1:0]\o_data_V_user_V_1_payload_A_reg[72] ;
  wire o_data_V_user_V_1_sel_wr;
  wire o_data_V_user_V_1_sel_wr_reg;
  wire \o_data_V_user_V_1_state_reg[0] ;
  wire \o_data_V_user_V_1_state_reg[0]_0 ;
  wire \o_data_V_user_V_1_state_reg[1] ;
  wire p_106_in;
  wire p_222_in;
  wire [18:0]p_Result_5_reg_737;
  wire \p_Result_5_reg_737[18]_i_1_n_0 ;
  wire p_s_reg_366;
  wire \p_s_reg_366[0]_i_1_n_0 ;
  wire [31:0]\pos_enc_0_read_reg_681_reg[31] ;
  wire [31:0]\pos_enc_1_read_reg_686_reg[31] ;
  wire [84:0]\pulse_metadata_V_0_payload_A_reg[820] ;
  wire [84:0]\pulse_metadata_V_0_payload_B_reg[820] ;
  wire pulse_metadata_V_0_sel;
  wire pulse_metadata_V_0_sel_rd_reg;
  wire \pulse_metadata_V_0_state_reg[0] ;
  wire \pulse_metadata_V_0_state_reg[0]_0 ;
  wire \pulse_metadata_V_0_state_reg[1] ;
  wire \pulse_metadata_V_0_state_reg[1]_0 ;
  wire pulse_metadata_V_TVALID;
  wire \pulse_metadata_V_rea_reg_694[0]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[10]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[11]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[12]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[13]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[14]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[15]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[16]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[17]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[18]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[19]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[1]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[20]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[21]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[22]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[23]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[24]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[25]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[26]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[27]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[28]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[29]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[2]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[30]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[31]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[3]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[4]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[5]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[6]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[768]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[769]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[770]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[771]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[772]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[773]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[774]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[775]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[776]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[777]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[778]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[779]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[780]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[781]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[782]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[783]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[784]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[785]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[786]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[787]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[788]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[789]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[790]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[791]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[792]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[793]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[794]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[795]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[796]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[797]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[798]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[799]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[7]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[800]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[801]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[802]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[803]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[804]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[805]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[806]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[807]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[808]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[809]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[810]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[811]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[812]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[813]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[814]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[815]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[816]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[817]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[818]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[819]_i_2_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[8]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694[9]_i_1_n_0 ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[0] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[10] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[11] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[12] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[13] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[14] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[15] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[16] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[17] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[18] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[19] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[1] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[20] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[21] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[22] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[23] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[24] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[25] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[26] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[27] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[28] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[29] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[2] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[30] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[31] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[3] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[4] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[5] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[6] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[768] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[769] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[770] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[771] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[772] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[773] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[774] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[775] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[776] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[777] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[778] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[779] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[780] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[781] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[782] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[783] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[784] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[785] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[786] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[787] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[788] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[789] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[790] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[791] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[792] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[793] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[794] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[795] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[796] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[797] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[798] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[799] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[7] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[800] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[801] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[802] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[803] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[804] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[805] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[806] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[807] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[808] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[809] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[810] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[811] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[812] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[813] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[814] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[815] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[816] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[817] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[819] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[8] ;
  wire \pulse_metadata_V_rea_reg_694_reg_n_0_[9] ;
  wire [30:0]sample_counter_1_fu_430_p2;
  wire \sample_counter_fu_94[31]_i_3_n_0 ;
  wire [0:0]\sample_counter_fu_94_reg[0] ;
  wire [31:0]\sample_counter_fu_94_reg[31] ;
  wire [31:0]\sample_counter_load_1_reg_632_reg[31] ;
  wire [0:0]sample_counter_write_phi_fu_359_p4;
  wire [31:0]sample_counter_write_reg_356;
  wire tmp_12_reg_721;
  wire \tmp_1_reg_752[0]_i_1_n_0 ;
  wire \tmp_1_reg_752_reg_n_0_[0] ;
  wire tmp_2_fu_295_p3;
  wire \tmp_2_reg_618_reg[0] ;
  wire tmp_7_fu_406_p2;
  wire tmp_7_reg_709;
  wire \tmp_7_reg_709[0]_i_1_n_0 ;
  wire tmp_9_fu_417_p3;
  wire [31:0]tmp_data_V_1_fu_521_p10;
  wire [31:0]tmp_data_V_1_reg_761;
  wire \tmp_data_V_1_reg_761[31]_i_1_n_0 ;
  wire \tmp_data_V_1_reg_761[31]_i_3_n_0 ;
  wire [31:0]\tmp_data_V_reg_577_reg[31] ;
  wire \tmp_reg_705[0]_i_1_n_0 ;
  wire \tmp_reg_705_reg_n_0_[0] ;
  wire write_flag3_reg_344;
  wire \x1_reg_287[0]_i_10_n_0 ;
  wire \x1_reg_287[0]_i_11_n_0 ;
  wire \x1_reg_287[0]_i_1_n_0 ;
  wire \x1_reg_287[0]_i_3_n_0 ;
  wire \x1_reg_287[0]_i_4_n_0 ;
  wire \x1_reg_287[0]_i_5_n_0 ;
  wire \x1_reg_287[0]_i_6_n_0 ;
  wire \x1_reg_287[0]_i_7_n_0 ;
  wire \x1_reg_287[0]_i_8_n_0 ;
  wire \x1_reg_287[0]_i_9_n_0 ;
  wire \x1_reg_287[16]_i_2_n_0 ;
  wire \x1_reg_287[16]_i_3_n_0 ;
  wire \x1_reg_287[16]_i_4_n_0 ;
  wire \x1_reg_287[16]_i_5_n_0 ;
  wire \x1_reg_287[16]_i_6_n_0 ;
  wire \x1_reg_287[16]_i_7_n_0 ;
  wire \x1_reg_287[16]_i_8_n_0 ;
  wire \x1_reg_287[16]_i_9_n_0 ;
  wire \x1_reg_287[24]_i_2_n_0 ;
  wire \x1_reg_287[24]_i_3_n_0 ;
  wire \x1_reg_287[24]_i_4_n_0 ;
  wire \x1_reg_287[24]_i_5_n_0 ;
  wire \x1_reg_287[24]_i_6_n_0 ;
  wire \x1_reg_287[24]_i_7_n_0 ;
  wire \x1_reg_287[24]_i_8_n_0 ;
  wire \x1_reg_287[24]_i_9_n_0 ;
  wire \x1_reg_287[8]_i_2_n_0 ;
  wire \x1_reg_287[8]_i_3_n_0 ;
  wire \x1_reg_287[8]_i_4_n_0 ;
  wire \x1_reg_287[8]_i_5_n_0 ;
  wire \x1_reg_287[8]_i_6_n_0 ;
  wire \x1_reg_287[8]_i_7_n_0 ;
  wire \x1_reg_287[8]_i_8_n_0 ;
  wire \x1_reg_287[8]_i_9_n_0 ;
  wire [31:0]x1_reg_287_reg;
  wire \x1_reg_287_reg[0]_i_2_n_0 ;
  wire \x1_reg_287_reg[0]_i_2_n_1 ;
  wire \x1_reg_287_reg[0]_i_2_n_10 ;
  wire \x1_reg_287_reg[0]_i_2_n_11 ;
  wire \x1_reg_287_reg[0]_i_2_n_12 ;
  wire \x1_reg_287_reg[0]_i_2_n_13 ;
  wire \x1_reg_287_reg[0]_i_2_n_14 ;
  wire \x1_reg_287_reg[0]_i_2_n_15 ;
  wire \x1_reg_287_reg[0]_i_2_n_2 ;
  wire \x1_reg_287_reg[0]_i_2_n_3 ;
  wire \x1_reg_287_reg[0]_i_2_n_5 ;
  wire \x1_reg_287_reg[0]_i_2_n_6 ;
  wire \x1_reg_287_reg[0]_i_2_n_7 ;
  wire \x1_reg_287_reg[0]_i_2_n_8 ;
  wire \x1_reg_287_reg[0]_i_2_n_9 ;
  wire \x1_reg_287_reg[16]_i_1_n_0 ;
  wire \x1_reg_287_reg[16]_i_1_n_1 ;
  wire \x1_reg_287_reg[16]_i_1_n_10 ;
  wire \x1_reg_287_reg[16]_i_1_n_11 ;
  wire \x1_reg_287_reg[16]_i_1_n_12 ;
  wire \x1_reg_287_reg[16]_i_1_n_13 ;
  wire \x1_reg_287_reg[16]_i_1_n_14 ;
  wire \x1_reg_287_reg[16]_i_1_n_15 ;
  wire \x1_reg_287_reg[16]_i_1_n_2 ;
  wire \x1_reg_287_reg[16]_i_1_n_3 ;
  wire \x1_reg_287_reg[16]_i_1_n_5 ;
  wire \x1_reg_287_reg[16]_i_1_n_6 ;
  wire \x1_reg_287_reg[16]_i_1_n_7 ;
  wire \x1_reg_287_reg[16]_i_1_n_8 ;
  wire \x1_reg_287_reg[16]_i_1_n_9 ;
  wire \x1_reg_287_reg[24]_i_1_n_1 ;
  wire \x1_reg_287_reg[24]_i_1_n_10 ;
  wire \x1_reg_287_reg[24]_i_1_n_11 ;
  wire \x1_reg_287_reg[24]_i_1_n_12 ;
  wire \x1_reg_287_reg[24]_i_1_n_13 ;
  wire \x1_reg_287_reg[24]_i_1_n_14 ;
  wire \x1_reg_287_reg[24]_i_1_n_15 ;
  wire \x1_reg_287_reg[24]_i_1_n_2 ;
  wire \x1_reg_287_reg[24]_i_1_n_3 ;
  wire \x1_reg_287_reg[24]_i_1_n_5 ;
  wire \x1_reg_287_reg[24]_i_1_n_6 ;
  wire \x1_reg_287_reg[24]_i_1_n_7 ;
  wire \x1_reg_287_reg[24]_i_1_n_8 ;
  wire \x1_reg_287_reg[24]_i_1_n_9 ;
  wire \x1_reg_287_reg[8]_i_1_n_0 ;
  wire \x1_reg_287_reg[8]_i_1_n_1 ;
  wire \x1_reg_287_reg[8]_i_1_n_10 ;
  wire \x1_reg_287_reg[8]_i_1_n_11 ;
  wire \x1_reg_287_reg[8]_i_1_n_12 ;
  wire \x1_reg_287_reg[8]_i_1_n_13 ;
  wire \x1_reg_287_reg[8]_i_1_n_14 ;
  wire \x1_reg_287_reg[8]_i_1_n_15 ;
  wire \x1_reg_287_reg[8]_i_1_n_2 ;
  wire \x1_reg_287_reg[8]_i_1_n_3 ;
  wire \x1_reg_287_reg[8]_i_1_n_5 ;
  wire \x1_reg_287_reg[8]_i_1_n_6 ;
  wire \x1_reg_287_reg[8]_i_1_n_7 ;
  wire \x1_reg_287_reg[8]_i_1_n_8 ;
  wire \x1_reg_287_reg[8]_i_1_n_9 ;
  wire \x2_reg_296[0]_i_1_n_0 ;
  wire \x2_reg_296[3]_i_1_n_0 ;
  wire \x2_reg_296[3]_i_2_n_0 ;
  wire \x2_reg_296[3]_i_4_n_0 ;
  wire [3:0]x2_reg_296_reg__0;
  wire [3:1]x_1_fu_511_p2;
  wire [3:3]NLW_ap_enable_reg_pp0_iter0_reg_i_4_CO_UNCONNECTED;
  wire [7:0]NLW_ap_enable_reg_pp0_iter0_reg_i_4_O_UNCONNECTED;
  wire [3:3]NLW_ap_enable_reg_pp0_iter0_reg_i_5_CO_UNCONNECTED;
  wire [7:0]NLW_ap_enable_reg_pp0_iter0_reg_i_5_O_UNCONNECTED;
  wire [3:3]\NLW_x1_reg_287_reg[0]_i_2_CO_UNCONNECTED ;
  wire [3:3]\NLW_x1_reg_287_reg[16]_i_1_CO_UNCONNECTED ;
  wire [7:3]\NLW_x1_reg_287_reg[24]_i_1_CO_UNCONNECTED ;
  wire [3:3]\NLW_x1_reg_287_reg[8]_i_1_CO_UNCONNECTED ;

  LUT5 #(
    .INIT(32'hFF101010)) 
    \ap_CS_fsm[0]_i_1 
       (.I0(ap_NS_fsm129_out),
        .I1(ap_enable_reg_pp0_iter0_i_2_n_0),
        .I2(\ap_CS_fsm_reg_n_0_[0] ),
        .I3(\ap_return_4_preg[7]_i_1_n_0 ),
        .I4(ap_CS_fsm_state7),
        .O(ap_NS_fsm[0]));
  LUT6 #(
    .INIT(64'hFFFFF8FF88888888)) 
    \ap_CS_fsm[1]_i_1 
       (.I0(ap_enable_reg_pp0_iter0_i_2_n_0),
        .I1(\ap_CS_fsm_reg_n_0_[0] ),
        .I2(tmp_7_fu_406_p2),
        .I3(ap_enable_reg_pp0_iter0),
        .I4(ap_enable_reg_pp0_iter0_i_3_n_0),
        .I5(ap_CS_fsm_pp0_stage0),
        .O(ap_NS_fsm[1]));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT4 #(
    .INIT(16'hF888)) 
    \ap_CS_fsm[1]_i_1__0 
       (.I0(\ap_CS_fsm_reg[4]_1 [0]),
        .I1(ap_start),
        .I2(\ap_CS_fsm[1]_i_2_n_0 ),
        .I3(\ap_CS_fsm_reg[4]_1 [2]),
        .O(\ap_CS_fsm_reg[4]_0 [0]));
  LUT6 #(
    .INIT(64'hA200A2AAAAAAAAAA)) 
    \ap_CS_fsm[1]_i_2 
       (.I0(\ap_CS_fsm[1]_i_3_n_0 ),
        .I1(p_s_reg_366),
        .I2(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I3(\ap_return_4_preg[7]_i_1_n_0 ),
        .I4(ap_return_0_preg),
        .I5(\tmp_2_reg_618_reg[0] ),
        .O(\ap_CS_fsm[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \ap_CS_fsm[1]_i_3 
       (.I0(ap_NS_fsm3),
        .I1(\ap_CS_fsm_reg[4]_1 [2]),
        .O(\ap_CS_fsm[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0400FFFF04000400)) 
    \ap_CS_fsm[2]_i_1 
       (.I0(tmp_7_fu_406_p2),
        .I1(ap_enable_reg_pp0_iter0),
        .I2(ap_enable_reg_pp0_iter0_i_3_n_0),
        .I3(ap_CS_fsm_pp0_stage0),
        .I4(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .I5(ap_CS_fsm_state4),
        .O(ap_NS_fsm[2]));
  LUT5 #(
    .INIT(32'h8FFF8888)) 
    \ap_CS_fsm[3]_i_1 
       (.I0(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .I1(ap_CS_fsm_state4),
        .I2(ap_enable_reg_pp1_iter0_i_2_n_0),
        .I3(ap_enable_reg_pp1_iter0),
        .I4(ap_CS_fsm_pp1_stage0),
        .O(ap_NS_fsm[3]));
  LUT4 #(
    .INIT(16'h8F88)) 
    \ap_CS_fsm[3]_i_1__0 
       (.I0(p_222_in),
        .I1(\ap_CS_fsm_reg[4]_1 [1]),
        .I2(ap_NS_fsm3),
        .I3(\ap_CS_fsm_reg[4]_1 [2]),
        .O(\ap_CS_fsm_reg[4]_0 [1]));
  LUT6 #(
    .INIT(64'hFFAEAEAEAEAEAEAE)) 
    \ap_CS_fsm[4]_i_1 
       (.I0(\ap_CS_fsm[4]_i_2_n_0 ),
        .I1(ap_CS_fsm_state7),
        .I2(\ap_return_4_preg[7]_i_1_n_0 ),
        .I3(ap_CS_fsm_pp1_stage0),
        .I4(ap_enable_reg_pp1_iter0),
        .I5(ap_enable_reg_pp1_iter0_i_2_n_0),
        .O(ap_NS_fsm[4]));
  LUT6 #(
    .INIT(64'h8000FFFF80008000)) 
    \ap_CS_fsm[4]_i_1__0 
       (.I0(\tmp_2_reg_618_reg[0] ),
        .I1(grp_handle_header_fu_175_ap_return_0),
        .I2(ap_NS_fsm3),
        .I3(\ap_CS_fsm_reg[4]_1 [2]),
        .I4(ap_done),
        .I5(\ap_CS_fsm_reg[4]_1 [3]),
        .O(\ap_CS_fsm_reg[4]_0 [2]));
  LUT6 #(
    .INIT(64'h8080800000800000)) 
    \ap_CS_fsm[4]_i_2 
       (.I0(\pulse_metadata_V_0_state_reg[0]_0 ),
        .I1(ap_reg_grp_handle_header_fu_175_ap_start_reg_0),
        .I2(\ap_CS_fsm_reg_n_0_[0] ),
        .I3(pulse_metadata_V_0_sel),
        .I4(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I5(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .O(\ap_CS_fsm[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h8AFF8A00)) 
    \ap_CS_fsm[4]_i_2__0 
       (.I0(p_s_reg_366),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .I3(\ap_return_4_preg[7]_i_1_n_0 ),
        .I4(ap_return_0_preg),
        .O(grp_handle_header_fu_175_ap_return_0));
  LUT6 #(
    .INIT(64'hF4F4FFFFF4F400FF)) 
    \ap_CS_fsm[4]_i_3 
       (.I0(ap_reg_grp_handle_header_fu_175_ap_start_reg_0),
        .I1(\ap_CS_fsm_reg_n_0_[0] ),
        .I2(\ap_return_4_preg[7]_i_1_n_0 ),
        .I3(brmerge_reg_672),
        .I4(\tmp_2_reg_618_reg[0] ),
        .I5(o_data_V_data_V_1_ack_in),
        .O(ap_NS_fsm3));
  (* FSM_ENCODING = "none" *) 
  FDSE #(
    .INIT(1'b1)) 
    \ap_CS_fsm_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_NS_fsm[0]),
        .Q(\ap_CS_fsm_reg_n_0_[0] ),
        .S(ap_rst));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_NS_fsm[1]),
        .Q(ap_CS_fsm_pp0_stage0),
        .R(ap_rst));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[2] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_NS_fsm[2]),
        .Q(ap_CS_fsm_state4),
        .R(ap_rst));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[3] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_NS_fsm[3]),
        .Q(ap_CS_fsm_pp1_stage0),
        .R(ap_rst));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[4] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_NS_fsm[4]),
        .Q(ap_CS_fsm_state7),
        .R(ap_rst));
  LUT6 #(
    .INIT(64'hE0E0E0E0E000E0E0)) 
    ap_enable_reg_pp0_iter0_i_1
       (.I0(ap_enable_reg_pp0_iter0),
        .I1(ap_enable_reg_pp0_iter0_i_2_n_0),
        .I2(ap_rst_n),
        .I3(ap_enable_reg_pp0_iter0_i_3_n_0),
        .I4(ap_CS_fsm_pp0_stage0),
        .I5(tmp_7_fu_406_p2),
        .O(ap_enable_reg_pp0_iter0_i_1_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    ap_enable_reg_pp0_iter0_i_10
       (.I0(\num_samples_load_reg_652_reg[31] [22]),
        .I1(x1_reg_287_reg[22]),
        .I2(x1_reg_287_reg[23]),
        .I3(\num_samples_load_reg_652_reg[31] [23]),
        .O(ap_enable_reg_pp0_iter0_i_10_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    ap_enable_reg_pp0_iter0_i_11
       (.I0(\num_samples_load_reg_652_reg[31] [20]),
        .I1(x1_reg_287_reg[20]),
        .I2(x1_reg_287_reg[21]),
        .I3(\num_samples_load_reg_652_reg[31] [21]),
        .O(ap_enable_reg_pp0_iter0_i_11_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    ap_enable_reg_pp0_iter0_i_12
       (.I0(\num_samples_load_reg_652_reg[31] [18]),
        .I1(x1_reg_287_reg[18]),
        .I2(x1_reg_287_reg[19]),
        .I3(\num_samples_load_reg_652_reg[31] [19]),
        .O(ap_enable_reg_pp0_iter0_i_12_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    ap_enable_reg_pp0_iter0_i_13
       (.I0(\num_samples_load_reg_652_reg[31] [16]),
        .I1(x1_reg_287_reg[16]),
        .I2(x1_reg_287_reg[17]),
        .I3(\num_samples_load_reg_652_reg[31] [17]),
        .O(ap_enable_reg_pp0_iter0_i_13_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ap_enable_reg_pp0_iter0_i_14
       (.I0(\num_samples_load_reg_652_reg[31] [30]),
        .I1(x1_reg_287_reg[30]),
        .I2(\num_samples_load_reg_652_reg[31] [31]),
        .I3(x1_reg_287_reg[31]),
        .O(ap_enable_reg_pp0_iter0_i_14_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ap_enable_reg_pp0_iter0_i_15
       (.I0(\num_samples_load_reg_652_reg[31] [28]),
        .I1(x1_reg_287_reg[28]),
        .I2(\num_samples_load_reg_652_reg[31] [29]),
        .I3(x1_reg_287_reg[29]),
        .O(ap_enable_reg_pp0_iter0_i_15_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ap_enable_reg_pp0_iter0_i_16
       (.I0(\num_samples_load_reg_652_reg[31] [26]),
        .I1(x1_reg_287_reg[26]),
        .I2(\num_samples_load_reg_652_reg[31] [27]),
        .I3(x1_reg_287_reg[27]),
        .O(ap_enable_reg_pp0_iter0_i_16_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ap_enable_reg_pp0_iter0_i_17
       (.I0(\num_samples_load_reg_652_reg[31] [24]),
        .I1(x1_reg_287_reg[24]),
        .I2(\num_samples_load_reg_652_reg[31] [25]),
        .I3(x1_reg_287_reg[25]),
        .O(ap_enable_reg_pp0_iter0_i_17_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ap_enable_reg_pp0_iter0_i_18
       (.I0(\num_samples_load_reg_652_reg[31] [22]),
        .I1(x1_reg_287_reg[22]),
        .I2(\num_samples_load_reg_652_reg[31] [23]),
        .I3(x1_reg_287_reg[23]),
        .O(ap_enable_reg_pp0_iter0_i_18_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ap_enable_reg_pp0_iter0_i_19
       (.I0(\num_samples_load_reg_652_reg[31] [20]),
        .I1(x1_reg_287_reg[20]),
        .I2(\num_samples_load_reg_652_reg[31] [21]),
        .I3(x1_reg_287_reg[21]),
        .O(ap_enable_reg_pp0_iter0_i_19_n_0));
  LUT6 #(
    .INIT(64'h0000008080008080)) 
    ap_enable_reg_pp0_iter0_i_2
       (.I0(\pulse_metadata_V_0_state_reg[0]_0 ),
        .I1(ap_reg_grp_handle_header_fu_175_ap_start_reg_0),
        .I2(\ap_CS_fsm_reg_n_0_[0] ),
        .I3(pulse_metadata_V_0_sel),
        .I4(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I5(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .O(ap_enable_reg_pp0_iter0_i_2_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ap_enable_reg_pp0_iter0_i_20
       (.I0(\num_samples_load_reg_652_reg[31] [18]),
        .I1(x1_reg_287_reg[18]),
        .I2(\num_samples_load_reg_652_reg[31] [19]),
        .I3(x1_reg_287_reg[19]),
        .O(ap_enable_reg_pp0_iter0_i_20_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ap_enable_reg_pp0_iter0_i_21
       (.I0(\num_samples_load_reg_652_reg[31] [16]),
        .I1(x1_reg_287_reg[16]),
        .I2(\num_samples_load_reg_652_reg[31] [17]),
        .I3(x1_reg_287_reg[17]),
        .O(ap_enable_reg_pp0_iter0_i_21_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    ap_enable_reg_pp0_iter0_i_22
       (.I0(\num_samples_load_reg_652_reg[31] [14]),
        .I1(x1_reg_287_reg[14]),
        .I2(x1_reg_287_reg[15]),
        .I3(\num_samples_load_reg_652_reg[31] [15]),
        .O(ap_enable_reg_pp0_iter0_i_22_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    ap_enable_reg_pp0_iter0_i_23
       (.I0(\num_samples_load_reg_652_reg[31] [12]),
        .I1(x1_reg_287_reg[12]),
        .I2(x1_reg_287_reg[13]),
        .I3(\num_samples_load_reg_652_reg[31] [13]),
        .O(ap_enable_reg_pp0_iter0_i_23_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    ap_enable_reg_pp0_iter0_i_24
       (.I0(\num_samples_load_reg_652_reg[31] [10]),
        .I1(x1_reg_287_reg[10]),
        .I2(x1_reg_287_reg[11]),
        .I3(\num_samples_load_reg_652_reg[31] [11]),
        .O(ap_enable_reg_pp0_iter0_i_24_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    ap_enable_reg_pp0_iter0_i_25
       (.I0(\num_samples_load_reg_652_reg[31] [8]),
        .I1(x1_reg_287_reg[8]),
        .I2(x1_reg_287_reg[9]),
        .I3(\num_samples_load_reg_652_reg[31] [9]),
        .O(ap_enable_reg_pp0_iter0_i_25_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    ap_enable_reg_pp0_iter0_i_26
       (.I0(\num_samples_load_reg_652_reg[31] [6]),
        .I1(x1_reg_287_reg[6]),
        .I2(x1_reg_287_reg[7]),
        .I3(\num_samples_load_reg_652_reg[31] [7]),
        .O(ap_enable_reg_pp0_iter0_i_26_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    ap_enable_reg_pp0_iter0_i_27
       (.I0(\num_samples_load_reg_652_reg[31] [4]),
        .I1(x1_reg_287_reg[4]),
        .I2(x1_reg_287_reg[5]),
        .I3(\num_samples_load_reg_652_reg[31] [5]),
        .O(ap_enable_reg_pp0_iter0_i_27_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    ap_enable_reg_pp0_iter0_i_28
       (.I0(\num_samples_load_reg_652_reg[31] [2]),
        .I1(x1_reg_287_reg[2]),
        .I2(x1_reg_287_reg[3]),
        .I3(\num_samples_load_reg_652_reg[31] [3]),
        .O(ap_enable_reg_pp0_iter0_i_28_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    ap_enable_reg_pp0_iter0_i_29
       (.I0(\num_samples_load_reg_652_reg[31] [0]),
        .I1(x1_reg_287_reg[0]),
        .I2(x1_reg_287_reg[1]),
        .I3(\num_samples_load_reg_652_reg[31] [1]),
        .O(ap_enable_reg_pp0_iter0_i_29_n_0));
  LUT4 #(
    .INIT(16'h0008)) 
    ap_enable_reg_pp0_iter0_i_3
       (.I0(tmp_7_reg_709),
        .I1(ap_enable_reg_pp0_iter1_reg_n_0),
        .I2(o_data_TREADY43_in),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .O(ap_enable_reg_pp0_iter0_i_3_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ap_enable_reg_pp0_iter0_i_30
       (.I0(\num_samples_load_reg_652_reg[31] [14]),
        .I1(x1_reg_287_reg[14]),
        .I2(\num_samples_load_reg_652_reg[31] [15]),
        .I3(x1_reg_287_reg[15]),
        .O(ap_enable_reg_pp0_iter0_i_30_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ap_enable_reg_pp0_iter0_i_31
       (.I0(\num_samples_load_reg_652_reg[31] [12]),
        .I1(x1_reg_287_reg[12]),
        .I2(\num_samples_load_reg_652_reg[31] [13]),
        .I3(x1_reg_287_reg[13]),
        .O(ap_enable_reg_pp0_iter0_i_31_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ap_enable_reg_pp0_iter0_i_32
       (.I0(\num_samples_load_reg_652_reg[31] [10]),
        .I1(x1_reg_287_reg[10]),
        .I2(\num_samples_load_reg_652_reg[31] [11]),
        .I3(x1_reg_287_reg[11]),
        .O(ap_enable_reg_pp0_iter0_i_32_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ap_enable_reg_pp0_iter0_i_33
       (.I0(\num_samples_load_reg_652_reg[31] [8]),
        .I1(x1_reg_287_reg[8]),
        .I2(\num_samples_load_reg_652_reg[31] [9]),
        .I3(x1_reg_287_reg[9]),
        .O(ap_enable_reg_pp0_iter0_i_33_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ap_enable_reg_pp0_iter0_i_34
       (.I0(\num_samples_load_reg_652_reg[31] [6]),
        .I1(x1_reg_287_reg[6]),
        .I2(\num_samples_load_reg_652_reg[31] [7]),
        .I3(x1_reg_287_reg[7]),
        .O(ap_enable_reg_pp0_iter0_i_34_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ap_enable_reg_pp0_iter0_i_35
       (.I0(\num_samples_load_reg_652_reg[31] [4]),
        .I1(x1_reg_287_reg[4]),
        .I2(\num_samples_load_reg_652_reg[31] [5]),
        .I3(x1_reg_287_reg[5]),
        .O(ap_enable_reg_pp0_iter0_i_35_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ap_enable_reg_pp0_iter0_i_36
       (.I0(\num_samples_load_reg_652_reg[31] [2]),
        .I1(x1_reg_287_reg[2]),
        .I2(\num_samples_load_reg_652_reg[31] [3]),
        .I3(x1_reg_287_reg[3]),
        .O(ap_enable_reg_pp0_iter0_i_36_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ap_enable_reg_pp0_iter0_i_37
       (.I0(\num_samples_load_reg_652_reg[31] [0]),
        .I1(x1_reg_287_reg[0]),
        .I2(\num_samples_load_reg_652_reg[31] [1]),
        .I3(x1_reg_287_reg[1]),
        .O(ap_enable_reg_pp0_iter0_i_37_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    ap_enable_reg_pp0_iter0_i_6
       (.I0(\num_samples_load_reg_652_reg[31] [30]),
        .I1(x1_reg_287_reg[30]),
        .I2(x1_reg_287_reg[31]),
        .I3(\num_samples_load_reg_652_reg[31] [31]),
        .O(ap_enable_reg_pp0_iter0_i_6_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    ap_enable_reg_pp0_iter0_i_7
       (.I0(\num_samples_load_reg_652_reg[31] [28]),
        .I1(x1_reg_287_reg[28]),
        .I2(x1_reg_287_reg[29]),
        .I3(\num_samples_load_reg_652_reg[31] [29]),
        .O(ap_enable_reg_pp0_iter0_i_7_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    ap_enable_reg_pp0_iter0_i_8
       (.I0(\num_samples_load_reg_652_reg[31] [26]),
        .I1(x1_reg_287_reg[26]),
        .I2(x1_reg_287_reg[27]),
        .I3(\num_samples_load_reg_652_reg[31] [27]),
        .O(ap_enable_reg_pp0_iter0_i_8_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    ap_enable_reg_pp0_iter0_i_9
       (.I0(\num_samples_load_reg_652_reg[31] [24]),
        .I1(x1_reg_287_reg[24]),
        .I2(x1_reg_287_reg[25]),
        .I3(\num_samples_load_reg_652_reg[31] [25]),
        .O(ap_enable_reg_pp0_iter0_i_9_n_0));
  FDRE #(
    .INIT(1'b0)) 
    ap_enable_reg_pp0_iter0_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_enable_reg_pp0_iter0_i_1_n_0),
        .Q(ap_enable_reg_pp0_iter0),
        .R(1'b0));
  CARRY8 ap_enable_reg_pp0_iter0_reg_i_4
       (.CI(ap_enable_reg_pp0_iter0_reg_i_5_n_0),
        .CI_TOP(1'b0),
        .CO({tmp_7_fu_406_p2,ap_enable_reg_pp0_iter0_reg_i_4_n_1,ap_enable_reg_pp0_iter0_reg_i_4_n_2,ap_enable_reg_pp0_iter0_reg_i_4_n_3,NLW_ap_enable_reg_pp0_iter0_reg_i_4_CO_UNCONNECTED[3],ap_enable_reg_pp0_iter0_reg_i_4_n_5,ap_enable_reg_pp0_iter0_reg_i_4_n_6,ap_enable_reg_pp0_iter0_reg_i_4_n_7}),
        .DI({ap_enable_reg_pp0_iter0_i_6_n_0,ap_enable_reg_pp0_iter0_i_7_n_0,ap_enable_reg_pp0_iter0_i_8_n_0,ap_enable_reg_pp0_iter0_i_9_n_0,ap_enable_reg_pp0_iter0_i_10_n_0,ap_enable_reg_pp0_iter0_i_11_n_0,ap_enable_reg_pp0_iter0_i_12_n_0,ap_enable_reg_pp0_iter0_i_13_n_0}),
        .O(NLW_ap_enable_reg_pp0_iter0_reg_i_4_O_UNCONNECTED[7:0]),
        .S({ap_enable_reg_pp0_iter0_i_14_n_0,ap_enable_reg_pp0_iter0_i_15_n_0,ap_enable_reg_pp0_iter0_i_16_n_0,ap_enable_reg_pp0_iter0_i_17_n_0,ap_enable_reg_pp0_iter0_i_18_n_0,ap_enable_reg_pp0_iter0_i_19_n_0,ap_enable_reg_pp0_iter0_i_20_n_0,ap_enable_reg_pp0_iter0_i_21_n_0}));
  CARRY8 ap_enable_reg_pp0_iter0_reg_i_5
       (.CI(1'b0),
        .CI_TOP(1'b0),
        .CO({ap_enable_reg_pp0_iter0_reg_i_5_n_0,ap_enable_reg_pp0_iter0_reg_i_5_n_1,ap_enable_reg_pp0_iter0_reg_i_5_n_2,ap_enable_reg_pp0_iter0_reg_i_5_n_3,NLW_ap_enable_reg_pp0_iter0_reg_i_5_CO_UNCONNECTED[3],ap_enable_reg_pp0_iter0_reg_i_5_n_5,ap_enable_reg_pp0_iter0_reg_i_5_n_6,ap_enable_reg_pp0_iter0_reg_i_5_n_7}),
        .DI({ap_enable_reg_pp0_iter0_i_22_n_0,ap_enable_reg_pp0_iter0_i_23_n_0,ap_enable_reg_pp0_iter0_i_24_n_0,ap_enable_reg_pp0_iter0_i_25_n_0,ap_enable_reg_pp0_iter0_i_26_n_0,ap_enable_reg_pp0_iter0_i_27_n_0,ap_enable_reg_pp0_iter0_i_28_n_0,ap_enable_reg_pp0_iter0_i_29_n_0}),
        .O(NLW_ap_enable_reg_pp0_iter0_reg_i_5_O_UNCONNECTED[7:0]),
        .S({ap_enable_reg_pp0_iter0_i_30_n_0,ap_enable_reg_pp0_iter0_i_31_n_0,ap_enable_reg_pp0_iter0_i_32_n_0,ap_enable_reg_pp0_iter0_i_33_n_0,ap_enable_reg_pp0_iter0_i_34_n_0,ap_enable_reg_pp0_iter0_i_35_n_0,ap_enable_reg_pp0_iter0_i_36_n_0,ap_enable_reg_pp0_iter0_i_37_n_0}));
  LUT6 #(
    .INIT(64'h0000A000C0C0A000)) 
    ap_enable_reg_pp0_iter1_i_1
       (.I0(ap_enable_reg_pp0_iter0),
        .I1(ap_enable_reg_pp0_iter1_reg_n_0),
        .I2(ap_rst_n),
        .I3(tmp_7_fu_406_p2),
        .I4(ap_enable_reg_pp0_iter0_i_3_n_0),
        .I5(ap_enable_reg_pp0_iter0_i_2_n_0),
        .O(ap_enable_reg_pp0_iter1_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    ap_enable_reg_pp0_iter1_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_enable_reg_pp0_iter1_i_1_n_0),
        .Q(ap_enable_reg_pp0_iter1_reg_n_0),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h00E0E0E0)) 
    ap_enable_reg_pp1_iter0_i_1
       (.I0(ap_enable_reg_pp1_iter0),
        .I1(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .I2(ap_rst_n),
        .I3(ap_enable_reg_pp1_iter0_i_2_n_0),
        .I4(ap_CS_fsm_pp1_stage0),
        .O(ap_enable_reg_pp1_iter0_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h00000004)) 
    ap_enable_reg_pp1_iter0_i_2
       (.I0(x2_reg_296_reg__0[1]),
        .I1(x2_reg_296_reg__0[3]),
        .I2(x2_reg_296_reg__0[2]),
        .I3(x2_reg_296_reg__0[0]),
        .I4(\tmp_data_V_1_reg_761[31]_i_3_n_0 ),
        .O(ap_enable_reg_pp1_iter0_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    ap_enable_reg_pp1_iter0_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_enable_reg_pp1_iter0_i_1_n_0),
        .Q(ap_enable_reg_pp1_iter0),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h000000A0C0C000A0)) 
    ap_enable_reg_pp1_iter1_i_1
       (.I0(ap_enable_reg_pp1_iter0),
        .I1(ap_enable_reg_pp1_iter1_reg_n_0),
        .I2(ap_rst_n),
        .I3(ap_condition_pp1_exit_iter0_state5),
        .I4(\tmp_data_V_1_reg_761[31]_i_3_n_0 ),
        .I5(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .O(ap_enable_reg_pp1_iter1_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h0010)) 
    ap_enable_reg_pp1_iter1_i_2
       (.I0(x2_reg_296_reg__0[0]),
        .I1(x2_reg_296_reg__0[2]),
        .I2(x2_reg_296_reg__0[3]),
        .I3(x2_reg_296_reg__0[1]),
        .O(ap_condition_pp1_exit_iter0_state5));
  FDRE #(
    .INIT(1'b0)) 
    ap_enable_reg_pp1_iter1_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_enable_reg_pp1_iter1_i_1_n_0),
        .Q(ap_enable_reg_pp1_iter1_reg_n_0),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h88A0FFFF88A088A0)) 
    ap_reg_grp_handle_header_fu_175_ap_start_i_1
       (.I0(p_222_in),
        .I1(\i_data_V_user_V_0_payload_B_reg[72] ),
        .I2(\i_data_V_user_V_0_payload_A_reg[72] ),
        .I3(i_data_V_user_V_0_sel),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_reg_grp_handle_header_fu_175_ap_start_reg_0),
        .O(ap_reg_grp_handle_header_fu_175_ap_start_reg));
  LUT6 #(
    .INIT(64'h000000000000EA00)) 
    ap_reg_ioackin_o_data_TREADY_i_1
       (.I0(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I1(o_data_TREADY43_in),
        .I2(ap_reg_ioackin_o_data_TREADY_i_2_n_0),
        .I3(ap_rst_n),
        .I4(ap_reg_ioackin_o_data_TREADY_i_3_n_0),
        .I5(ap_reg_ioackin_o_data_TREADY_i_4_n_0),
        .O(ap_reg_ioackin_o_data_TREADY_i_1_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFEEEEEEE)) 
    ap_reg_ioackin_o_data_TREADY_i_2
       (.I0(ap_reg_ioackin_o_data_TREADY338_out),
        .I1(grp_handle_header_fu_175_o_data_TUSER),
        .I2(tmp_7_reg_709),
        .I3(ap_enable_reg_pp0_iter1_reg_n_0),
        .I4(ap_CS_fsm_pp0_stage0),
        .I5(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .O(ap_reg_ioackin_o_data_TREADY_i_2_n_0));
  LUT6 #(
    .INIT(64'hF4F4F40044444400)) 
    ap_reg_ioackin_o_data_TREADY_i_3
       (.I0(\tmp_reg_705_reg_n_0_[0] ),
        .I1(ap_CS_fsm_state7),
        .I2(tmp_9_fu_417_p3),
        .I3(o_data_TREADY43_in),
        .I4(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I5(ap_CS_fsm_state4),
        .O(ap_reg_ioackin_o_data_TREADY_i_3_n_0));
  LUT6 #(
    .INIT(64'h4F44444444444444)) 
    ap_reg_ioackin_o_data_TREADY_i_4
       (.I0(\tmp_data_V_1_reg_761[31]_i_3_n_0 ),
        .I1(grp_handle_header_fu_175_o_data_TUSER),
        .I2(ap_enable_reg_pp0_iter0_i_3_n_0),
        .I3(tmp_7_reg_709),
        .I4(ap_enable_reg_pp0_iter1_reg_n_0),
        .I5(ap_CS_fsm_pp0_stage0),
        .O(ap_reg_ioackin_o_data_TREADY_i_4_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    ap_reg_ioackin_o_data_TREADY_i_5
       (.I0(ap_CS_fsm_state4),
        .I1(tmp_9_fu_417_p3),
        .O(ap_reg_ioackin_o_data_TREADY338_out));
  FDRE #(
    .INIT(1'b0)) 
    ap_reg_ioackin_o_data_TREADY_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_reg_ioackin_o_data_TREADY_i_1_n_0),
        .Q(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_0_preg[0]_i_1 
       (.I0(p_s_reg_366),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_0_preg[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_0_preg_reg[0] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_0_preg[0]_i_1_n_0 ),
        .Q(ap_return_0_preg),
        .R(ap_rst));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT4 #(
    .INIT(16'hFFAE)) 
    \ap_return_1_preg[0]_i_1 
       (.I0(write_flag3_reg_344),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(in_a_pulse_load_reg_622),
        .O(in_a_pulse_write_ass_fu_548_p2));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_1_preg_reg[0] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(in_a_pulse_write_ass_fu_548_p2),
        .Q(ap_return_1_preg),
        .R(ap_rst));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT4 #(
    .INIT(16'hFFAE)) 
    \ap_return_2_preg[0]_i_1 
       (.I0(write_flag3_reg_344),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(in_a_xfer_bundle_loa_reg_627),
        .O(in_a_xfer_bundle_wri_fu_553_p2));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_2_preg_reg[0] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(in_a_xfer_bundle_wri_fu_553_p2),
        .Q(ap_return_2_preg),
        .R(ap_rst));
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_3_preg[0]_i_1 
       (.I0(tmp_12_reg_721),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(break_after_pulse_wr_reg_326),
        .O(break_after_pulse_wr_phi_fu_329_p4));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_3_preg_reg[0] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(break_after_pulse_wr_phi_fu_329_p4),
        .Q(ap_return_3_preg),
        .R(ap_rst));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_4_preg[0]_i_1 
       (.I0(decimation_value_0_n_reg_732[0]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(decimation_value_wri_reg_307[0]),
        .O(decimation_value_wri_phi_fu_310_p4[0]));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_4_preg[1]_i_1 
       (.I0(decimation_value_0_n_reg_732[1]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(decimation_value_wri_reg_307[1]),
        .O(decimation_value_wri_phi_fu_310_p4[1]));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_4_preg[2]_i_1 
       (.I0(decimation_value_0_n_reg_732[2]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(decimation_value_wri_reg_307[2]),
        .O(decimation_value_wri_phi_fu_310_p4[2]));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_4_preg[3]_i_1 
       (.I0(decimation_value_0_n_reg_732[3]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(decimation_value_wri_reg_307[3]),
        .O(decimation_value_wri_phi_fu_310_p4[3]));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_4_preg[4]_i_1 
       (.I0(decimation_value_0_n_reg_732[4]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(decimation_value_wri_reg_307[4]),
        .O(decimation_value_wri_phi_fu_310_p4[4]));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_4_preg[5]_i_1 
       (.I0(decimation_value_0_n_reg_732[5]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(decimation_value_wri_reg_307[5]),
        .O(decimation_value_wri_phi_fu_310_p4[5]));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_4_preg[6]_i_1 
       (.I0(decimation_value_0_n_reg_732[6]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(decimation_value_wri_reg_307[6]),
        .O(decimation_value_wri_phi_fu_310_p4[6]));
  LUT4 #(
    .INIT(16'hAAA8)) 
    \ap_return_4_preg[7]_i_1 
       (.I0(ap_CS_fsm_state7),
        .I1(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I2(o_data_TREADY43_in),
        .I3(\tmp_reg_705_reg_n_0_[0] ),
        .O(\ap_return_4_preg[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_4_preg[7]_i_2 
       (.I0(decimation_value_0_n_reg_732[7]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(decimation_value_wri_reg_307[7]),
        .O(decimation_value_wri_phi_fu_310_p4[7]));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_4_preg_reg[0] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(decimation_value_wri_phi_fu_310_p4[0]),
        .Q(ap_return_4_preg[0]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_4_preg_reg[1] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(decimation_value_wri_phi_fu_310_p4[1]),
        .Q(ap_return_4_preg[1]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_4_preg_reg[2] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(decimation_value_wri_phi_fu_310_p4[2]),
        .Q(ap_return_4_preg[2]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_4_preg_reg[3] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(decimation_value_wri_phi_fu_310_p4[3]),
        .Q(ap_return_4_preg[3]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_4_preg_reg[4] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(decimation_value_wri_phi_fu_310_p4[4]),
        .Q(ap_return_4_preg[4]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_4_preg_reg[5] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(decimation_value_wri_phi_fu_310_p4[5]),
        .Q(ap_return_4_preg[5]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_4_preg_reg[6] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(decimation_value_wri_phi_fu_310_p4[6]),
        .Q(ap_return_4_preg[6]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_4_preg_reg[7] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(decimation_value_wri_phi_fu_310_p4[7]),
        .Q(ap_return_4_preg[7]),
        .R(ap_rst));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT3 #(
    .INIT(8'hF4)) 
    \ap_return_5_preg[0]_i_1 
       (.I0(\tmp_reg_705_reg_n_0_[0] ),
        .I1(ap_CS_fsm_state7),
        .I2(decimation_counter_w_reg_316[0]),
        .O(decimation_counter_w_phi_fu_319_p4));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_5_preg[1]_i_1 
       (.I0(decimation_counter_w_reg_316[1]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_5_preg[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_5_preg[2]_i_1 
       (.I0(decimation_counter_w_reg_316[2]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_5_preg[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_5_preg[3]_i_1 
       (.I0(decimation_counter_w_reg_316[3]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_5_preg[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_5_preg[4]_i_1 
       (.I0(decimation_counter_w_reg_316[4]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_5_preg[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_5_preg[5]_i_1 
       (.I0(decimation_counter_w_reg_316[5]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_5_preg[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_5_preg[6]_i_1 
       (.I0(decimation_counter_w_reg_316[6]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_5_preg[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_5_preg[7]_i_1 
       (.I0(decimation_counter_w_reg_316[7]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_5_preg[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_5_preg_reg[0] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(decimation_counter_w_phi_fu_319_p4),
        .Q(ap_return_5_preg[0]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_5_preg_reg[1] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_5_preg[1]_i_1_n_0 ),
        .Q(ap_return_5_preg[1]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_5_preg_reg[2] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_5_preg[2]_i_1_n_0 ),
        .Q(ap_return_5_preg[2]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_5_preg_reg[3] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_5_preg[3]_i_1_n_0 ),
        .Q(ap_return_5_preg[3]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_5_preg_reg[4] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_5_preg[4]_i_1_n_0 ),
        .Q(ap_return_5_preg[4]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_5_preg_reg[5] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_5_preg[5]_i_1_n_0 ),
        .Q(ap_return_5_preg[5]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_5_preg_reg[6] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_5_preg[6]_i_1_n_0 ),
        .Q(ap_return_5_preg[6]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_5_preg_reg[7] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_5_preg[7]_i_1_n_0 ),
        .Q(ap_return_5_preg[7]),
        .R(ap_rst));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[0]_i_1 
       (.I0(header_5_reg_726[0]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[0] ),
        .O(num_samples_write_as_phi_fu_338_p4[0]));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[10]_i_1 
       (.I0(header_5_reg_726[10]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[10] ),
        .O(num_samples_write_as_phi_fu_338_p4[10]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[11]_i_1 
       (.I0(header_5_reg_726[11]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[11] ),
        .O(num_samples_write_as_phi_fu_338_p4[11]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[12]_i_1 
       (.I0(header_5_reg_726[12]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[12] ),
        .O(num_samples_write_as_phi_fu_338_p4[12]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[13]_i_1 
       (.I0(header_5_reg_726[13]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[13] ),
        .O(num_samples_write_as_phi_fu_338_p4[13]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[14]_i_1 
       (.I0(header_5_reg_726[14]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[14] ),
        .O(num_samples_write_as_phi_fu_338_p4[14]));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[15]_i_1 
       (.I0(header_5_reg_726[15]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[15] ),
        .O(num_samples_write_as_phi_fu_338_p4[15]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[16]_i_1 
       (.I0(header_5_reg_726[16]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[16] ),
        .O(num_samples_write_as_phi_fu_338_p4[16]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[17]_i_1 
       (.I0(header_5_reg_726[17]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[17] ),
        .O(num_samples_write_as_phi_fu_338_p4[17]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[18]_i_1 
       (.I0(header_5_reg_726[18]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[18] ),
        .O(num_samples_write_as_phi_fu_338_p4[18]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[19]_i_1 
       (.I0(header_5_reg_726[19]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[19] ),
        .O(num_samples_write_as_phi_fu_338_p4[19]));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[1]_i_1 
       (.I0(header_5_reg_726[1]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[1] ),
        .O(num_samples_write_as_phi_fu_338_p4[1]));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[20]_i_1 
       (.I0(header_5_reg_726[20]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[20] ),
        .O(num_samples_write_as_phi_fu_338_p4[20]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[21]_i_1 
       (.I0(header_5_reg_726[21]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[21] ),
        .O(num_samples_write_as_phi_fu_338_p4[21]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[22]_i_1 
       (.I0(header_5_reg_726[22]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[22] ),
        .O(num_samples_write_as_phi_fu_338_p4[22]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[23]_i_1 
       (.I0(header_5_reg_726[23]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[23] ),
        .O(num_samples_write_as_phi_fu_338_p4[23]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[24]_i_1 
       (.I0(header_5_reg_726[24]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[24] ),
        .O(num_samples_write_as_phi_fu_338_p4[24]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[25]_i_1 
       (.I0(header_5_reg_726[25]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[25] ),
        .O(num_samples_write_as_phi_fu_338_p4[25]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[26]_i_1 
       (.I0(header_5_reg_726[26]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[26] ),
        .O(num_samples_write_as_phi_fu_338_p4[26]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[27]_i_1 
       (.I0(header_5_reg_726[27]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[27] ),
        .O(num_samples_write_as_phi_fu_338_p4[27]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[28]_i_1 
       (.I0(header_5_reg_726[28]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[28] ),
        .O(num_samples_write_as_phi_fu_338_p4[28]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[29]_i_1 
       (.I0(header_5_reg_726[29]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[29] ),
        .O(num_samples_write_as_phi_fu_338_p4[29]));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[2]_i_1 
       (.I0(header_5_reg_726[2]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[2] ),
        .O(num_samples_write_as_phi_fu_338_p4[2]));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[30]_i_1 
       (.I0(header_5_reg_726[30]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[30] ),
        .O(num_samples_write_as_phi_fu_338_p4[30]));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[31]_i_1 
       (.I0(header_5_reg_726[31]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[31] ),
        .O(num_samples_write_as_phi_fu_338_p4[31]));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[3]_i_1 
       (.I0(header_5_reg_726[3]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[3] ),
        .O(num_samples_write_as_phi_fu_338_p4[3]));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[4]_i_1 
       (.I0(header_5_reg_726[4]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[4] ),
        .O(num_samples_write_as_phi_fu_338_p4[4]));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[5]_i_1 
       (.I0(header_5_reg_726[5]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[5] ),
        .O(num_samples_write_as_phi_fu_338_p4[5]));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[6]_i_1 
       (.I0(header_5_reg_726[6]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[6] ),
        .O(num_samples_write_as_phi_fu_338_p4[6]));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[7]_i_1 
       (.I0(header_5_reg_726[7]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[7] ),
        .O(num_samples_write_as_phi_fu_338_p4[7]));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[8]_i_1 
       (.I0(header_5_reg_726[8]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[8] ),
        .O(num_samples_write_as_phi_fu_338_p4[8]));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \ap_return_6_preg[9]_i_1 
       (.I0(header_5_reg_726[9]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[9] ),
        .O(num_samples_write_as_phi_fu_338_p4[9]));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[0] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[0]),
        .Q(ap_return_6_preg[0]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[10] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[10]),
        .Q(ap_return_6_preg[10]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[11] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[11]),
        .Q(ap_return_6_preg[11]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[12] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[12]),
        .Q(ap_return_6_preg[12]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[13] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[13]),
        .Q(ap_return_6_preg[13]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[14] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[14]),
        .Q(ap_return_6_preg[14]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[15] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[15]),
        .Q(ap_return_6_preg[15]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[16] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[16]),
        .Q(ap_return_6_preg[16]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[17] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[17]),
        .Q(ap_return_6_preg[17]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[18] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[18]),
        .Q(ap_return_6_preg[18]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[19] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[19]),
        .Q(ap_return_6_preg[19]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[1] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[1]),
        .Q(ap_return_6_preg[1]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[20] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[20]),
        .Q(ap_return_6_preg[20]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[21] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[21]),
        .Q(ap_return_6_preg[21]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[22] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[22]),
        .Q(ap_return_6_preg[22]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[23] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[23]),
        .Q(ap_return_6_preg[23]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[24] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[24]),
        .Q(ap_return_6_preg[24]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[25] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[25]),
        .Q(ap_return_6_preg[25]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[26] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[26]),
        .Q(ap_return_6_preg[26]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[27] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[27]),
        .Q(ap_return_6_preg[27]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[28] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[28]),
        .Q(ap_return_6_preg[28]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[29] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[29]),
        .Q(ap_return_6_preg[29]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[2] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[2]),
        .Q(ap_return_6_preg[2]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[30] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[30]),
        .Q(ap_return_6_preg[30]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[31] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[31]),
        .Q(ap_return_6_preg[31]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[3] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[3]),
        .Q(ap_return_6_preg[3]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[4] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[4]),
        .Q(ap_return_6_preg[4]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[5] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[5]),
        .Q(ap_return_6_preg[5]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[6] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[6]),
        .Q(ap_return_6_preg[6]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[7] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[7]),
        .Q(ap_return_6_preg[7]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[8] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[8]),
        .Q(ap_return_6_preg[8]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_6_preg_reg[9] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(num_samples_write_as_phi_fu_338_p4[9]),
        .Q(ap_return_6_preg[9]),
        .R(ap_rst));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT3 #(
    .INIT(8'hF4)) 
    \ap_return_7_preg[0]_i_1 
       (.I0(\tmp_reg_705_reg_n_0_[0] ),
        .I1(ap_CS_fsm_state7),
        .I2(sample_counter_write_reg_356[0]),
        .O(sample_counter_write_phi_fu_359_p4));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[10]_i_1 
       (.I0(sample_counter_write_reg_356[10]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[11]_i_1 
       (.I0(sample_counter_write_reg_356[11]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[12]_i_1 
       (.I0(sample_counter_write_reg_356[12]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[13]_i_1 
       (.I0(sample_counter_write_reg_356[13]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[14]_i_1 
       (.I0(sample_counter_write_reg_356[14]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[15]_i_1 
       (.I0(sample_counter_write_reg_356[15]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[16]_i_1 
       (.I0(sample_counter_write_reg_356[16]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[17]_i_1 
       (.I0(sample_counter_write_reg_356[17]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[18]_i_1 
       (.I0(sample_counter_write_reg_356[18]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[19]_i_1 
       (.I0(sample_counter_write_reg_356[19]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[1]_i_1 
       (.I0(sample_counter_write_reg_356[1]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[20]_i_1 
       (.I0(sample_counter_write_reg_356[20]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[21]_i_1 
       (.I0(sample_counter_write_reg_356[21]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[22]_i_1 
       (.I0(sample_counter_write_reg_356[22]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[22]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[23]_i_1 
       (.I0(sample_counter_write_reg_356[23]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[24]_i_1 
       (.I0(sample_counter_write_reg_356[24]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[25]_i_1 
       (.I0(sample_counter_write_reg_356[25]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[26]_i_1 
       (.I0(sample_counter_write_reg_356[26]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[27]_i_1 
       (.I0(sample_counter_write_reg_356[27]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[28]_i_1 
       (.I0(sample_counter_write_reg_356[28]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[29]_i_1 
       (.I0(sample_counter_write_reg_356[29]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[2]_i_1 
       (.I0(sample_counter_write_reg_356[2]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[30]_i_1 
       (.I0(sample_counter_write_reg_356[30]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[30]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[31]_i_1 
       (.I0(sample_counter_write_reg_356[31]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[3]_i_1 
       (.I0(sample_counter_write_reg_356[3]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[4]_i_1 
       (.I0(sample_counter_write_reg_356[4]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[5]_i_1 
       (.I0(sample_counter_write_reg_356[5]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[6]_i_1 
       (.I0(sample_counter_write_reg_356[6]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[7]_i_1 
       (.I0(sample_counter_write_reg_356[7]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[8]_i_1 
       (.I0(sample_counter_write_reg_356[8]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    \ap_return_7_preg[9]_i_1 
       (.I0(sample_counter_write_reg_356[9]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .O(\ap_return_7_preg[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[0] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(sample_counter_write_phi_fu_359_p4),
        .Q(ap_return_7_preg[0]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[10] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[10]_i_1_n_0 ),
        .Q(ap_return_7_preg[10]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[11] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[11]_i_1_n_0 ),
        .Q(ap_return_7_preg[11]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[12] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[12]_i_1_n_0 ),
        .Q(ap_return_7_preg[12]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[13] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[13]_i_1_n_0 ),
        .Q(ap_return_7_preg[13]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[14] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[14]_i_1_n_0 ),
        .Q(ap_return_7_preg[14]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[15] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[15]_i_1_n_0 ),
        .Q(ap_return_7_preg[15]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[16] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[16]_i_1_n_0 ),
        .Q(ap_return_7_preg[16]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[17] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[17]_i_1_n_0 ),
        .Q(ap_return_7_preg[17]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[18] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[18]_i_1_n_0 ),
        .Q(ap_return_7_preg[18]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[19] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[19]_i_1_n_0 ),
        .Q(ap_return_7_preg[19]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[1] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[1]_i_1_n_0 ),
        .Q(ap_return_7_preg[1]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[20] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[20]_i_1_n_0 ),
        .Q(ap_return_7_preg[20]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[21] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[21]_i_1_n_0 ),
        .Q(ap_return_7_preg[21]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[22] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[22]_i_1_n_0 ),
        .Q(ap_return_7_preg[22]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[23] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[23]_i_1_n_0 ),
        .Q(ap_return_7_preg[23]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[24] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[24]_i_1_n_0 ),
        .Q(ap_return_7_preg[24]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[25] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[25]_i_1_n_0 ),
        .Q(ap_return_7_preg[25]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[26] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[26]_i_1_n_0 ),
        .Q(ap_return_7_preg[26]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[27] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[27]_i_1_n_0 ),
        .Q(ap_return_7_preg[27]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[28] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[28]_i_1_n_0 ),
        .Q(ap_return_7_preg[28]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[29] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[29]_i_1_n_0 ),
        .Q(ap_return_7_preg[29]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[2] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[2]_i_1_n_0 ),
        .Q(ap_return_7_preg[2]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[30] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[30]_i_1_n_0 ),
        .Q(ap_return_7_preg[30]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[31] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[31]_i_1_n_0 ),
        .Q(ap_return_7_preg[31]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[3] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[3]_i_1_n_0 ),
        .Q(ap_return_7_preg[3]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[4] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[4]_i_1_n_0 ),
        .Q(ap_return_7_preg[4]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[5] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[5]_i_1_n_0 ),
        .Q(ap_return_7_preg[5]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[6] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[6]_i_1_n_0 ),
        .Q(ap_return_7_preg[6]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[7] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[7]_i_1_n_0 ),
        .Q(ap_return_7_preg[7]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[8] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[8]_i_1_n_0 ),
        .Q(ap_return_7_preg[8]),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \ap_return_7_preg_reg[9] 
       (.C(ap_clk),
        .CE(\ap_return_4_preg[7]_i_1_n_0 ),
        .D(\ap_return_7_preg[9]_i_1_n_0 ),
        .Q(ap_return_7_preg[9]),
        .R(ap_rst));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \break_after_pulse_fu_106[0]_i_1 
       (.I0(tmp_12_reg_721),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(break_after_pulse_wr_reg_326),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_3_preg),
        .O(ap_return_3));
  LUT6 #(
    .INIT(64'hFFFFBBBF00008880)) 
    \break_after_pulse_wr_reg_326[0]_i_1 
       (.I0(tmp_12_reg_721),
        .I1(ap_CS_fsm_state7),
        .I2(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I3(o_data_TREADY43_in),
        .I4(\tmp_reg_705_reg_n_0_[0] ),
        .I5(break_after_pulse_lo_reg_647),
        .O(\break_after_pulse_wr_reg_326[0]_i_1_n_0 ));
  FDRE \break_after_pulse_wr_reg_326_reg[0] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\break_after_pulse_wr_reg_326[0]_i_1_n_0 ),
        .Q(break_after_pulse_wr_reg_326),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hF4FFF400)) 
    \decimation_counter_fu_98[0]_i_3 
       (.I0(\tmp_reg_705_reg_n_0_[0] ),
        .I1(ap_CS_fsm_state7),
        .I2(decimation_counter_w_reg_316[0]),
        .I3(\ap_return_4_preg[7]_i_1_n_0 ),
        .I4(ap_return_5_preg[0]),
        .O(ap_return_5[0]));
  LUT5 #(
    .INIT(32'h8AFF8A00)) 
    \decimation_counter_fu_98[1]_i_3 
       (.I0(decimation_counter_w_reg_316[1]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .I3(\ap_return_4_preg[7]_i_1_n_0 ),
        .I4(ap_return_5_preg[1]),
        .O(ap_return_5[1]));
  LUT5 #(
    .INIT(32'h8AFF8A00)) 
    \decimation_counter_fu_98[2]_i_3 
       (.I0(decimation_counter_w_reg_316[2]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .I3(\ap_return_4_preg[7]_i_1_n_0 ),
        .I4(ap_return_5_preg[2]),
        .O(ap_return_5[2]));
  LUT5 #(
    .INIT(32'h8AFF8A00)) 
    \decimation_counter_fu_98[3]_i_3 
       (.I0(decimation_counter_w_reg_316[3]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .I3(\ap_return_4_preg[7]_i_1_n_0 ),
        .I4(ap_return_5_preg[3]),
        .O(ap_return_5[3]));
  LUT5 #(
    .INIT(32'h8AFF8A00)) 
    \decimation_counter_fu_98[4]_i_3 
       (.I0(decimation_counter_w_reg_316[4]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .I3(\ap_return_4_preg[7]_i_1_n_0 ),
        .I4(ap_return_5_preg[4]),
        .O(ap_return_5[4]));
  LUT5 #(
    .INIT(32'h8AFF8A00)) 
    \decimation_counter_fu_98[5]_i_3 
       (.I0(decimation_counter_w_reg_316[5]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .I3(\ap_return_4_preg[7]_i_1_n_0 ),
        .I4(ap_return_5_preg[5]),
        .O(ap_return_5[5]));
  LUT5 #(
    .INIT(32'h8AFF8A00)) 
    \decimation_counter_fu_98[6]_i_3 
       (.I0(decimation_counter_w_reg_316[6]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .I3(\ap_return_4_preg[7]_i_1_n_0 ),
        .I4(ap_return_5_preg[6]),
        .O(ap_return_5[6]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFAABA)) 
    \decimation_counter_fu_98[7]_i_1 
       (.I0(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I1(brmerge_fu_387_p2),
        .I2(p_222_in),
        .I3(tmp_2_fu_295_p3),
        .I4(ap_NS_fsm1115_out),
        .I5(o_data_V_data_V_1_vld_in1),
        .O(\decimation_counter_fu_98_reg[0] ));
  LUT5 #(
    .INIT(32'h8AFF8A00)) 
    \decimation_counter_fu_98[7]_i_5 
       (.I0(decimation_counter_w_reg_316[7]),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .I2(ap_CS_fsm_state7),
        .I3(\ap_return_4_preg[7]_i_1_n_0 ),
        .I4(ap_return_5_preg[7]),
        .O(ap_return_5[7]));
  MUXF7 \decimation_counter_fu_98_reg[0]_i_1 
       (.I0(\decimation_counter_fu_98_reg[0]_1 ),
        .I1(ap_return_5[0]),
        .O(\decimation_counter_fu_98_reg[7] [0]),
        .S(\decimation_value_fu_102[7]_i_4_n_0 ));
  MUXF7 \decimation_counter_fu_98_reg[1]_i_1 
       (.I0(\decimation_counter_fu_98_reg[0]_0 ),
        .I1(ap_return_5[1]),
        .O(\decimation_counter_fu_98_reg[7] [1]),
        .S(\decimation_value_fu_102[7]_i_4_n_0 ));
  MUXF7 \decimation_counter_fu_98_reg[2]_i_1 
       (.I0(\decimation_counter_fu_98_reg[2] ),
        .I1(ap_return_5[2]),
        .O(\decimation_counter_fu_98_reg[7] [2]),
        .S(\decimation_value_fu_102[7]_i_4_n_0 ));
  MUXF7 \decimation_counter_fu_98_reg[3]_i_1 
       (.I0(\decimation_counter_fu_98_reg[3] ),
        .I1(ap_return_5[3]),
        .O(\decimation_counter_fu_98_reg[7] [3]),
        .S(\decimation_value_fu_102[7]_i_4_n_0 ));
  MUXF7 \decimation_counter_fu_98_reg[4]_i_1 
       (.I0(\decimation_counter_fu_98_reg[4] ),
        .I1(ap_return_5[4]),
        .O(\decimation_counter_fu_98_reg[7] [4]),
        .S(\decimation_value_fu_102[7]_i_4_n_0 ));
  MUXF7 \decimation_counter_fu_98_reg[5]_i_1 
       (.I0(\decimation_counter_fu_98_reg[5] ),
        .I1(ap_return_5[5]),
        .O(\decimation_counter_fu_98_reg[7] [5]),
        .S(\decimation_value_fu_102[7]_i_4_n_0 ));
  MUXF7 \decimation_counter_fu_98_reg[6]_i_1 
       (.I0(\decimation_counter_fu_98_reg[6]_0 ),
        .I1(ap_return_5[6]),
        .O(\decimation_counter_fu_98_reg[7] [6]),
        .S(\decimation_value_fu_102[7]_i_4_n_0 ));
  MUXF7 \decimation_counter_fu_98_reg[7]_i_2 
       (.I0(\decimation_counter_fu_98_reg[6] ),
        .I1(ap_return_5[7]),
        .O(\decimation_counter_fu_98_reg[7] [7]),
        .S(\decimation_value_fu_102[7]_i_4_n_0 ));
  FDSE \decimation_counter_w_reg_316_reg[0] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\decimation_counter_l_reg_637_reg[7] [0]),
        .Q(decimation_counter_w_reg_316[0]),
        .S(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \decimation_counter_w_reg_316_reg[1] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\decimation_counter_l_reg_637_reg[7] [1]),
        .Q(decimation_counter_w_reg_316[1]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \decimation_counter_w_reg_316_reg[2] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\decimation_counter_l_reg_637_reg[7] [2]),
        .Q(decimation_counter_w_reg_316[2]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \decimation_counter_w_reg_316_reg[3] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\decimation_counter_l_reg_637_reg[7] [3]),
        .Q(decimation_counter_w_reg_316[3]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \decimation_counter_w_reg_316_reg[4] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\decimation_counter_l_reg_637_reg[7] [4]),
        .Q(decimation_counter_w_reg_316[4]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \decimation_counter_w_reg_316_reg[5] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\decimation_counter_l_reg_637_reg[7] [5]),
        .Q(decimation_counter_w_reg_316[5]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \decimation_counter_w_reg_316_reg[6] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\decimation_counter_l_reg_637_reg[7] [6]),
        .Q(decimation_counter_w_reg_316[6]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \decimation_counter_w_reg_316_reg[7] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\decimation_counter_l_reg_637_reg[7] [7]),
        .Q(decimation_counter_w_reg_316[7]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \decimation_value_0_n_reg_732_reg[0] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[808] ),
        .Q(decimation_value_0_n_reg_732[0]),
        .R(1'b0));
  FDRE \decimation_value_0_n_reg_732_reg[1] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[809] ),
        .Q(decimation_value_0_n_reg_732[1]),
        .R(1'b0));
  FDRE \decimation_value_0_n_reg_732_reg[2] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[810] ),
        .Q(decimation_value_0_n_reg_732[2]),
        .R(1'b0));
  FDRE \decimation_value_0_n_reg_732_reg[3] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[811] ),
        .Q(decimation_value_0_n_reg_732[3]),
        .R(1'b0));
  FDRE \decimation_value_0_n_reg_732_reg[4] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[812] ),
        .Q(decimation_value_0_n_reg_732[4]),
        .R(1'b0));
  FDRE \decimation_value_0_n_reg_732_reg[5] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[813] ),
        .Q(decimation_value_0_n_reg_732[5]),
        .R(1'b0));
  FDRE \decimation_value_0_n_reg_732_reg[6] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[814] ),
        .Q(decimation_value_0_n_reg_732[6]),
        .R(1'b0));
  FDRE \decimation_value_0_n_reg_732_reg[7] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[815] ),
        .Q(decimation_value_0_n_reg_732[7]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFC0CFFFFFC0CAAAA)) 
    \decimation_value_fu_102[0]_i_1 
       (.I0(D),
        .I1(ap_return_4_preg[0]),
        .I2(\ap_return_4_preg[7]_i_1_n_0 ),
        .I3(decimation_value_wri_phi_fu_310_p4[0]),
        .I4(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I5(ap_NS_fsm1115_out),
        .O(\decimation_value_fu_102_reg[0] ));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \decimation_value_fu_102[1]_i_1 
       (.I0(decimation_value_0_n_reg_732[1]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(decimation_value_wri_reg_307[1]),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_4_preg[1]),
        .O(ap_return_4[0]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \decimation_value_fu_102[2]_i_1 
       (.I0(decimation_value_0_n_reg_732[2]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(decimation_value_wri_reg_307[2]),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_4_preg[2]),
        .O(ap_return_4[1]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \decimation_value_fu_102[3]_i_1 
       (.I0(decimation_value_0_n_reg_732[3]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(decimation_value_wri_reg_307[3]),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_4_preg[3]),
        .O(ap_return_4[2]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \decimation_value_fu_102[4]_i_1 
       (.I0(decimation_value_0_n_reg_732[4]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(decimation_value_wri_reg_307[4]),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_4_preg[4]),
        .O(ap_return_4[3]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \decimation_value_fu_102[5]_i_1 
       (.I0(decimation_value_0_n_reg_732[5]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(decimation_value_wri_reg_307[5]),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_4_preg[5]),
        .O(ap_return_4[4]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \decimation_value_fu_102[6]_i_1 
       (.I0(decimation_value_0_n_reg_732[6]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(decimation_value_wri_reg_307[6]),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_4_preg[6]),
        .O(ap_return_4[5]));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \decimation_value_fu_102[7]_i_1 
       (.I0(\ap_CS_fsm_reg[4]_1 [0]),
        .I1(ap_start),
        .I2(\decimation_value_fu_102[7]_i_4_n_0 ),
        .O(\decimation_value_fu_102_reg[7] ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hEA)) 
    \decimation_value_fu_102[7]_i_2 
       (.I0(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I1(ap_start),
        .I2(\ap_CS_fsm_reg[4]_1 [0]),
        .O(num_samples_fu_110));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \decimation_value_fu_102[7]_i_3 
       (.I0(decimation_value_0_n_reg_732[7]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(decimation_value_wri_reg_307[7]),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_4_preg[7]),
        .O(ap_return_4[6]));
  LUT6 #(
    .INIT(64'h0202A202A2A2A2A2)) 
    \decimation_value_fu_102[7]_i_4 
       (.I0(p_106_in),
        .I1(ap_return_0_preg),
        .I2(\ap_return_4_preg[7]_i_1_n_0 ),
        .I3(ap_CS_fsm_state7),
        .I4(\tmp_reg_705_reg_n_0_[0] ),
        .I5(p_s_reg_366),
        .O(\decimation_value_fu_102[7]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'h80)) 
    \decimation_value_fu_102[7]_i_5 
       (.I0(\tmp_2_reg_618_reg[0] ),
        .I1(\ap_CS_fsm_reg[4]_1 [2]),
        .I2(ap_NS_fsm3),
        .O(p_106_in));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \decimation_value_wri_reg_307[0]_i_1 
       (.I0(decimation_value_0_n_reg_732[0]),
        .I1(\decimation_value_loa_reg_642_reg[7] [0]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\decimation_value_wri_reg_307[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \decimation_value_wri_reg_307[1]_i_1 
       (.I0(decimation_value_0_n_reg_732[1]),
        .I1(\decimation_value_loa_reg_642_reg[7] [1]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\decimation_value_wri_reg_307[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \decimation_value_wri_reg_307[2]_i_1 
       (.I0(decimation_value_0_n_reg_732[2]),
        .I1(\decimation_value_loa_reg_642_reg[7] [2]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\decimation_value_wri_reg_307[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \decimation_value_wri_reg_307[3]_i_1 
       (.I0(decimation_value_0_n_reg_732[3]),
        .I1(\decimation_value_loa_reg_642_reg[7] [3]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\decimation_value_wri_reg_307[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \decimation_value_wri_reg_307[4]_i_1 
       (.I0(decimation_value_0_n_reg_732[4]),
        .I1(\decimation_value_loa_reg_642_reg[7] [4]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\decimation_value_wri_reg_307[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \decimation_value_wri_reg_307[5]_i_1 
       (.I0(decimation_value_0_n_reg_732[5]),
        .I1(\decimation_value_loa_reg_642_reg[7] [5]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\decimation_value_wri_reg_307[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \decimation_value_wri_reg_307[6]_i_1 
       (.I0(decimation_value_0_n_reg_732[6]),
        .I1(\decimation_value_loa_reg_642_reg[7] [6]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\decimation_value_wri_reg_307[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hEAEAEEAA)) 
    \decimation_value_wri_reg_307[7]_i_1 
       (.I0(\p_s_reg_366[0]_i_1_n_0 ),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(pulse_metadata_V_0_sel),
        .O(num_samples_write_as_reg_335));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \decimation_value_wri_reg_307[7]_i_2 
       (.I0(decimation_value_0_n_reg_732[7]),
        .I1(\decimation_value_loa_reg_642_reg[7] [7]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\decimation_value_wri_reg_307[7]_i_2_n_0 ));
  FDRE \decimation_value_wri_reg_307_reg[0] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\decimation_value_wri_reg_307[0]_i_1_n_0 ),
        .Q(decimation_value_wri_reg_307[0]),
        .R(1'b0));
  FDRE \decimation_value_wri_reg_307_reg[1] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\decimation_value_wri_reg_307[1]_i_1_n_0 ),
        .Q(decimation_value_wri_reg_307[1]),
        .R(1'b0));
  FDRE \decimation_value_wri_reg_307_reg[2] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\decimation_value_wri_reg_307[2]_i_1_n_0 ),
        .Q(decimation_value_wri_reg_307[2]),
        .R(1'b0));
  FDRE \decimation_value_wri_reg_307_reg[3] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\decimation_value_wri_reg_307[3]_i_1_n_0 ),
        .Q(decimation_value_wri_reg_307[3]),
        .R(1'b0));
  FDRE \decimation_value_wri_reg_307_reg[4] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\decimation_value_wri_reg_307[4]_i_1_n_0 ),
        .Q(decimation_value_wri_reg_307[4]),
        .R(1'b0));
  FDRE \decimation_value_wri_reg_307_reg[5] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\decimation_value_wri_reg_307[5]_i_1_n_0 ),
        .Q(decimation_value_wri_reg_307[5]),
        .R(1'b0));
  FDRE \decimation_value_wri_reg_307_reg[6] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\decimation_value_wri_reg_307[6]_i_1_n_0 ),
        .Q(decimation_value_wri_reg_307[6]),
        .R(1'b0));
  FDRE \decimation_value_wri_reg_307_reg[7] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\decimation_value_wri_reg_307[7]_i_2_n_0 ),
        .Q(decimation_value_wri_reg_307[7]),
        .R(1'b0));
  FDRE \header_4_reg_742_reg[0] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[768] ),
        .Q(header_4_reg_742[0]),
        .R(1'b0));
  FDRE \header_4_reg_742_reg[1] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[769] ),
        .Q(header_4_reg_742[1]),
        .R(1'b0));
  FDRE \header_4_reg_742_reg[2] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[770] ),
        .Q(header_4_reg_742[2]),
        .R(1'b0));
  FDRE \header_4_reg_742_reg[3] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[771] ),
        .Q(header_4_reg_742[3]),
        .R(1'b0));
  FDRE \header_4_reg_742_reg[4] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[772] ),
        .Q(header_4_reg_742[4]),
        .R(1'b0));
  FDRE \header_4_reg_742_reg[5] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[773] ),
        .Q(header_4_reg_742[5]),
        .R(1'b0));
  FDRE \header_4_reg_742_reg[6] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[774] ),
        .Q(header_4_reg_742[6]),
        .R(1'b0));
  FDRE \header_4_reg_742_reg[7] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[775] ),
        .Q(header_4_reg_742[7]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[0] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[776] ),
        .Q(header_5_reg_726[0]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[10] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[786] ),
        .Q(header_5_reg_726[10]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[11] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[787] ),
        .Q(header_5_reg_726[11]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[12] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[788] ),
        .Q(header_5_reg_726[12]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[13] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[789] ),
        .Q(header_5_reg_726[13]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[14] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[790] ),
        .Q(header_5_reg_726[14]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[15] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[791] ),
        .Q(header_5_reg_726[15]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[16] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[792] ),
        .Q(header_5_reg_726[16]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[17] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[793] ),
        .Q(header_5_reg_726[17]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[18] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[794] ),
        .Q(header_5_reg_726[18]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[19] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[795] ),
        .Q(header_5_reg_726[19]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[1] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[777] ),
        .Q(header_5_reg_726[1]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[20] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[796] ),
        .Q(header_5_reg_726[20]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[21] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[797] ),
        .Q(header_5_reg_726[21]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[22] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[798] ),
        .Q(header_5_reg_726[22]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[23] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[799] ),
        .Q(header_5_reg_726[23]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[24] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[800] ),
        .Q(header_5_reg_726[24]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[25] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[801] ),
        .Q(header_5_reg_726[25]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[26] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[802] ),
        .Q(header_5_reg_726[26]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[27] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[803] ),
        .Q(header_5_reg_726[27]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[28] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[804] ),
        .Q(header_5_reg_726[28]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[29] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[805] ),
        .Q(header_5_reg_726[29]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[2] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[778] ),
        .Q(header_5_reg_726[2]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[30] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[806] ),
        .Q(header_5_reg_726[30]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[31] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[807] ),
        .Q(header_5_reg_726[31]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[3] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[779] ),
        .Q(header_5_reg_726[3]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[4] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[780] ),
        .Q(header_5_reg_726[4]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[5] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[781] ),
        .Q(header_5_reg_726[5]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[6] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[782] ),
        .Q(header_5_reg_726[6]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[7] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[783] ),
        .Q(header_5_reg_726[7]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[8] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[784] ),
        .Q(header_5_reg_726[8]),
        .R(1'b0));
  FDRE \header_5_reg_726_reg[9] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[785] ),
        .Q(header_5_reg_726[9]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[0] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[0] ),
        .Q(header_6_reg_747[0]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[10] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[10] ),
        .Q(header_6_reg_747[10]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[11] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[11] ),
        .Q(header_6_reg_747[11]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[12] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[12] ),
        .Q(header_6_reg_747[12]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[13] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[13] ),
        .Q(header_6_reg_747[13]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[14] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[14] ),
        .Q(header_6_reg_747[14]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[15] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[15] ),
        .Q(header_6_reg_747[15]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[16] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[16] ),
        .Q(header_6_reg_747[16]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[17] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[17] ),
        .Q(header_6_reg_747[17]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[18] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[18] ),
        .Q(header_6_reg_747[18]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[19] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[19] ),
        .Q(header_6_reg_747[19]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[1] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[1] ),
        .Q(header_6_reg_747[1]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[20] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[20] ),
        .Q(header_6_reg_747[20]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[21] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[21] ),
        .Q(header_6_reg_747[21]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[22] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[22] ),
        .Q(header_6_reg_747[22]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[23] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[23] ),
        .Q(header_6_reg_747[23]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[24] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[24] ),
        .Q(header_6_reg_747[24]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[25] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[25] ),
        .Q(header_6_reg_747[25]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[26] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[26] ),
        .Q(header_6_reg_747[26]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[27] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[27] ),
        .Q(header_6_reg_747[27]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[28] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[28] ),
        .Q(header_6_reg_747[28]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[29] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[29] ),
        .Q(header_6_reg_747[29]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[2] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[2] ),
        .Q(header_6_reg_747[2]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[30] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[30] ),
        .Q(header_6_reg_747[30]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[31] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[31] ),
        .Q(header_6_reg_747[31]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[3] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[3] ),
        .Q(header_6_reg_747[3]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[4] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[4] ),
        .Q(header_6_reg_747[4]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[5] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[5] ),
        .Q(header_6_reg_747[5]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[6] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[6] ),
        .Q(header_6_reg_747[6]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[7] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[7] ),
        .Q(header_6_reg_747[7]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[8] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[8] ),
        .Q(header_6_reg_747[8]),
        .R(1'b0));
  FDRE \header_6_reg_747_reg[9] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[9] ),
        .Q(header_6_reg_747[9]),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    \i_data_V_dest_V_0_state[1]_i_1 
       (.I0(ap_rst_n),
        .O(ap_rst));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \in_a_pulse_fu_86[0]_i_1 
       (.I0(in_a_pulse_write_ass_fu_548_p2),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_1_preg),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(in_a_pulse_2_reg_662),
        .I5(\sample_counter_fu_94[31]_i_3_n_0 ),
        .O(\in_a_pulse_fu_86_reg[0] ));
  LUT6 #(
    .INIT(64'hFFFFFF08FF08FF08)) 
    \in_a_xfer_bundle_fu_90[0]_i_1 
       (.I0(\ap_CS_fsm_reg[4]_1 [2]),
        .I1(ap_NS_fsm3),
        .I2(\tmp_2_reg_618_reg[0] ),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\ap_CS_fsm_reg[4]_1 [0]),
        .I5(ap_start),
        .O(in_a_xfer_bundle_fu_90));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \in_a_xfer_bundle_fu_90[0]_i_2 
       (.I0(in_a_xfer_bundle_wri_fu_553_p2),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_2_preg),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(in_a_xfer_bundle_3_reg_657),
        .I5(\sample_counter_fu_94[31]_i_3_n_0 ),
        .O(\in_a_xfer_bundle_fu_90_reg[0] ));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[0]_i_1 
       (.I0(header_5_reg_726[0]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[0] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[0]),
        .O(ap_return_6[0]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[10]_i_1 
       (.I0(header_5_reg_726[10]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[10] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[10]),
        .O(ap_return_6[10]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[11]_i_1 
       (.I0(header_5_reg_726[11]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[11] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[11]),
        .O(ap_return_6[11]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[12]_i_1 
       (.I0(header_5_reg_726[12]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[12] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[12]),
        .O(ap_return_6[12]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[13]_i_1 
       (.I0(header_5_reg_726[13]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[13] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[13]),
        .O(ap_return_6[13]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[14]_i_1 
       (.I0(header_5_reg_726[14]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[14] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[14]),
        .O(ap_return_6[14]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[15]_i_1 
       (.I0(header_5_reg_726[15]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[15] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[15]),
        .O(ap_return_6[15]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[16]_i_1 
       (.I0(header_5_reg_726[16]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[16] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[16]),
        .O(ap_return_6[16]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[17]_i_1 
       (.I0(header_5_reg_726[17]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[17] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[17]),
        .O(ap_return_6[17]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[18]_i_1 
       (.I0(header_5_reg_726[18]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[18] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[18]),
        .O(ap_return_6[18]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[19]_i_1 
       (.I0(header_5_reg_726[19]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[19] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[19]),
        .O(ap_return_6[19]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[1]_i_1 
       (.I0(header_5_reg_726[1]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[1] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[1]),
        .O(ap_return_6[1]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[20]_i_1 
       (.I0(header_5_reg_726[20]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[20] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[20]),
        .O(ap_return_6[20]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[21]_i_1 
       (.I0(header_5_reg_726[21]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[21] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[21]),
        .O(ap_return_6[21]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[22]_i_1 
       (.I0(header_5_reg_726[22]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[22] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[22]),
        .O(ap_return_6[22]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[23]_i_1 
       (.I0(header_5_reg_726[23]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[23] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[23]),
        .O(ap_return_6[23]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[24]_i_1 
       (.I0(header_5_reg_726[24]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[24] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[24]),
        .O(ap_return_6[24]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[25]_i_1 
       (.I0(header_5_reg_726[25]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[25] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[25]),
        .O(ap_return_6[25]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[26]_i_1 
       (.I0(header_5_reg_726[26]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[26] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[26]),
        .O(ap_return_6[26]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[27]_i_1 
       (.I0(header_5_reg_726[27]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[27] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[27]),
        .O(ap_return_6[27]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[28]_i_1 
       (.I0(header_5_reg_726[28]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[28] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[28]),
        .O(ap_return_6[28]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[29]_i_1 
       (.I0(header_5_reg_726[29]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[29] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[29]),
        .O(ap_return_6[29]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[2]_i_1 
       (.I0(header_5_reg_726[2]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[2] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[2]),
        .O(ap_return_6[2]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[30]_i_1 
       (.I0(header_5_reg_726[30]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[30] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[30]),
        .O(ap_return_6[30]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[31]_i_1 
       (.I0(header_5_reg_726[31]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[31] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[31]),
        .O(ap_return_6[31]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[3]_i_1 
       (.I0(header_5_reg_726[3]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[3] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[3]),
        .O(ap_return_6[3]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[4]_i_1 
       (.I0(header_5_reg_726[4]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[4] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[4]),
        .O(ap_return_6[4]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[5]_i_1 
       (.I0(header_5_reg_726[5]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[5] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[5]),
        .O(ap_return_6[5]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[6]_i_1 
       (.I0(header_5_reg_726[6]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[6] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[6]),
        .O(ap_return_6[6]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[7]_i_1 
       (.I0(header_5_reg_726[7]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[7] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[7]),
        .O(ap_return_6[7]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[8]_i_1 
       (.I0(header_5_reg_726[8]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[8] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[8]),
        .O(ap_return_6[8]));
  LUT6 #(
    .INIT(64'hFB08FFFFFB080000)) 
    \num_samples_fu_110[9]_i_1 
       (.I0(header_5_reg_726[9]),
        .I1(ap_CS_fsm_state7),
        .I2(\tmp_reg_705_reg_n_0_[0] ),
        .I3(\num_samples_write_as_reg_335_reg_n_0_[9] ),
        .I4(\ap_return_4_preg[7]_i_1_n_0 ),
        .I5(ap_return_6_preg[9]),
        .O(ap_return_6[9]));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[0]_i_1 
       (.I0(header_5_reg_726[0]),
        .I1(\num_samples_load_reg_652_reg[31] [0]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[10]_i_1 
       (.I0(header_5_reg_726[10]),
        .I1(\num_samples_load_reg_652_reg[31] [10]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[11]_i_1 
       (.I0(header_5_reg_726[11]),
        .I1(\num_samples_load_reg_652_reg[31] [11]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[11]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[12]_i_1 
       (.I0(header_5_reg_726[12]),
        .I1(\num_samples_load_reg_652_reg[31] [12]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[13]_i_1 
       (.I0(header_5_reg_726[13]),
        .I1(\num_samples_load_reg_652_reg[31] [13]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[14]_i_1 
       (.I0(header_5_reg_726[14]),
        .I1(\num_samples_load_reg_652_reg[31] [14]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[15]_i_1 
       (.I0(header_5_reg_726[15]),
        .I1(\num_samples_load_reg_652_reg[31] [15]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[16]_i_1 
       (.I0(header_5_reg_726[16]),
        .I1(\num_samples_load_reg_652_reg[31] [16]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[16]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[17]_i_1 
       (.I0(header_5_reg_726[17]),
        .I1(\num_samples_load_reg_652_reg[31] [17]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[17]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[18]_i_1 
       (.I0(header_5_reg_726[18]),
        .I1(\num_samples_load_reg_652_reg[31] [18]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[18]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[19]_i_1 
       (.I0(header_5_reg_726[19]),
        .I1(\num_samples_load_reg_652_reg[31] [19]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[19]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[1]_i_1 
       (.I0(header_5_reg_726[1]),
        .I1(\num_samples_load_reg_652_reg[31] [1]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[20]_i_1 
       (.I0(header_5_reg_726[20]),
        .I1(\num_samples_load_reg_652_reg[31] [20]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[20]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[21]_i_1 
       (.I0(header_5_reg_726[21]),
        .I1(\num_samples_load_reg_652_reg[31] [21]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[21]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[22]_i_1 
       (.I0(header_5_reg_726[22]),
        .I1(\num_samples_load_reg_652_reg[31] [22]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[22]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[23]_i_1 
       (.I0(header_5_reg_726[23]),
        .I1(\num_samples_load_reg_652_reg[31] [23]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[23]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[24]_i_1 
       (.I0(header_5_reg_726[24]),
        .I1(\num_samples_load_reg_652_reg[31] [24]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[24]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[25]_i_1 
       (.I0(header_5_reg_726[25]),
        .I1(\num_samples_load_reg_652_reg[31] [25]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[25]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[26]_i_1 
       (.I0(header_5_reg_726[26]),
        .I1(\num_samples_load_reg_652_reg[31] [26]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[26]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[27]_i_1 
       (.I0(header_5_reg_726[27]),
        .I1(\num_samples_load_reg_652_reg[31] [27]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[27]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[28]_i_1 
       (.I0(header_5_reg_726[28]),
        .I1(\num_samples_load_reg_652_reg[31] [28]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[28]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[29]_i_1 
       (.I0(header_5_reg_726[29]),
        .I1(\num_samples_load_reg_652_reg[31] [29]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[29]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[2]_i_1 
       (.I0(header_5_reg_726[2]),
        .I1(\num_samples_load_reg_652_reg[31] [2]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[30]_i_1 
       (.I0(header_5_reg_726[30]),
        .I1(\num_samples_load_reg_652_reg[31] [30]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[30]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[31]_i_1 
       (.I0(header_5_reg_726[31]),
        .I1(\num_samples_load_reg_652_reg[31] [31]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[3]_i_1 
       (.I0(header_5_reg_726[3]),
        .I1(\num_samples_load_reg_652_reg[31] [3]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[4]_i_1 
       (.I0(header_5_reg_726[4]),
        .I1(\num_samples_load_reg_652_reg[31] [4]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[5]_i_1 
       (.I0(header_5_reg_726[5]),
        .I1(\num_samples_load_reg_652_reg[31] [5]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[6]_i_1 
       (.I0(header_5_reg_726[6]),
        .I1(\num_samples_load_reg_652_reg[31] [6]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[7]_i_1 
       (.I0(header_5_reg_726[7]),
        .I1(\num_samples_load_reg_652_reg[31] [7]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[8]_i_1 
       (.I0(header_5_reg_726[8]),
        .I1(\num_samples_load_reg_652_reg[31] [8]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCCCCCCCACACACCC)) 
    \num_samples_write_as_reg_335[9]_i_1 
       (.I0(header_5_reg_726[9]),
        .I1(\num_samples_load_reg_652_reg[31] [9]),
        .I2(ap_CS_fsm_state7),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I4(o_data_TREADY43_in),
        .I5(\tmp_reg_705_reg_n_0_[0] ),
        .O(\num_samples_write_as_reg_335[9]_i_1_n_0 ));
  FDRE \num_samples_write_as_reg_335_reg[0] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[0]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[10] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[10]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[10] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[11] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[11]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[11] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[12] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[12]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[12] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[13] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[13]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[13] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[14] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[14]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[14] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[15] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[15]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[15] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[16] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[16]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[16] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[17] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[17]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[17] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[18] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[18]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[18] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[19] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[19]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[19] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[1] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[1]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[20] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[20]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[20] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[21] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[21]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[21] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[22] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[22]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[22] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[23] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[23]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[23] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[24] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[24]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[24] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[25] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[25]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[25] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[26] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[26]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[26] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[27] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[27]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[27] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[28] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[28]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[28] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[29] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[29]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[29] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[2] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[2]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[30] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[30]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[30] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[31] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[31]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[31] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[3] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[3]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[4] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[4]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[5] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[5]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[5] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[6] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[6]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[6] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[7] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[7]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[7] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[8] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[8]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[8] ),
        .R(1'b0));
  FDRE \num_samples_write_as_reg_335_reg[9] 
       (.C(ap_clk),
        .CE(num_samples_write_as_reg_335),
        .D(\num_samples_write_as_reg_335[9]_i_1_n_0 ),
        .Q(\num_samples_write_as_reg_335_reg_n_0_[9] ),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hACACFF00)) 
    \o_data_V_data_V_1_payload_A[0]_i_1 
       (.I0(Q[0]),
        .I1(\i_data_V_data_V_0_payload_A_reg[31] [0]),
        .I2(i_data_V_data_V_0_sel),
        .I3(grp_handle_header_fu_175_o_data_TDATA[0]),
        .I4(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [0]));
  LUT6 #(
    .INIT(64'hB888B8BBB8BBB8BB)) 
    \o_data_V_data_V_1_payload_A[0]_i_2 
       (.I0(\tmp_data_V_reg_577_reg[31] [0]),
        .I1(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I2(tmp_data_V_1_reg_761[0]),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(tmp_9_fu_417_p3),
        .I5(ap_CS_fsm_state4),
        .O(grp_handle_header_fu_175_o_data_TDATA[0]));
  LUT5 #(
    .INIT(32'hACACFF00)) 
    \o_data_V_data_V_1_payload_A[10]_i_1 
       (.I0(Q[7]),
        .I1(\i_data_V_data_V_0_payload_A_reg[31] [7]),
        .I2(i_data_V_data_V_0_sel),
        .I3(grp_handle_header_fu_175_o_data_TDATA[10]),
        .I4(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [10]));
  LUT6 #(
    .INIT(64'hB888B8BBB8BBB8BB)) 
    \o_data_V_data_V_1_payload_A[10]_i_2 
       (.I0(\tmp_data_V_reg_577_reg[31] [10]),
        .I1(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I2(tmp_data_V_1_reg_761[10]),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(tmp_9_fu_417_p3),
        .I5(ap_CS_fsm_state4),
        .O(grp_handle_header_fu_175_o_data_TDATA[10]));
  LUT5 #(
    .INIT(32'hACACFF00)) 
    \o_data_V_data_V_1_payload_A[11]_i_1 
       (.I0(Q[8]),
        .I1(\i_data_V_data_V_0_payload_A_reg[31] [8]),
        .I2(i_data_V_data_V_0_sel),
        .I3(grp_handle_header_fu_175_o_data_TDATA[11]),
        .I4(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [11]));
  LUT6 #(
    .INIT(64'hB8BBB888B888B888)) 
    \o_data_V_data_V_1_payload_A[11]_i_2 
       (.I0(\tmp_data_V_reg_577_reg[31] [11]),
        .I1(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I2(tmp_data_V_1_reg_761[11]),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(ap_CS_fsm_state4),
        .I5(tmp_9_fu_417_p3),
        .O(grp_handle_header_fu_175_o_data_TDATA[11]));
  LUT6 #(
    .INIT(64'hAAAAAAAACFC0CFCF)) 
    \o_data_V_data_V_1_payload_A[12]_i_1 
       (.I0(\i_data_V_data_V_0_payload_B_reg[28] [3]),
        .I1(\tmp_data_V_reg_577_reg[31] [12]),
        .I2(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I3(tmp_data_V_1_reg_761[12]),
        .I4(grp_handle_header_fu_175_o_data_TUSER),
        .I5(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [12]));
  LUT5 #(
    .INIT(32'hACACFF00)) 
    \o_data_V_data_V_1_payload_A[13]_i_1 
       (.I0(Q[9]),
        .I1(\i_data_V_data_V_0_payload_A_reg[31] [9]),
        .I2(i_data_V_data_V_0_sel),
        .I3(grp_handle_header_fu_175_o_data_TDATA[13]),
        .I4(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [13]));
  LUT6 #(
    .INIT(64'hB888B8BBB8BBB8BB)) 
    \o_data_V_data_V_1_payload_A[13]_i_2 
       (.I0(\tmp_data_V_reg_577_reg[31] [13]),
        .I1(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I2(tmp_data_V_1_reg_761[13]),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(tmp_9_fu_417_p3),
        .I5(ap_CS_fsm_state4),
        .O(grp_handle_header_fu_175_o_data_TDATA[13]));
  LUT5 #(
    .INIT(32'hACACFF00)) 
    \o_data_V_data_V_1_payload_A[14]_i_1 
       (.I0(Q[10]),
        .I1(\i_data_V_data_V_0_payload_A_reg[31] [10]),
        .I2(i_data_V_data_V_0_sel),
        .I3(grp_handle_header_fu_175_o_data_TDATA[14]),
        .I4(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [14]));
  LUT6 #(
    .INIT(64'hB888B8BBB8BBB8BB)) 
    \o_data_V_data_V_1_payload_A[14]_i_2 
       (.I0(\tmp_data_V_reg_577_reg[31] [14]),
        .I1(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I2(tmp_data_V_1_reg_761[14]),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(tmp_9_fu_417_p3),
        .I5(ap_CS_fsm_state4),
        .O(grp_handle_header_fu_175_o_data_TDATA[14]));
  LUT5 #(
    .INIT(32'hACACFF00)) 
    \o_data_V_data_V_1_payload_A[15]_i_1 
       (.I0(Q[11]),
        .I1(\i_data_V_data_V_0_payload_A_reg[31] [11]),
        .I2(i_data_V_data_V_0_sel),
        .I3(grp_handle_header_fu_175_o_data_TDATA[15]),
        .I4(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [15]));
  LUT6 #(
    .INIT(64'hB8BBB888B888B888)) 
    \o_data_V_data_V_1_payload_A[15]_i_2 
       (.I0(\tmp_data_V_reg_577_reg[31] [15]),
        .I1(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I2(tmp_data_V_1_reg_761[15]),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(ap_CS_fsm_state4),
        .I5(tmp_9_fu_417_p3),
        .O(grp_handle_header_fu_175_o_data_TDATA[15]));
  LUT5 #(
    .INIT(32'hACACFF00)) 
    \o_data_V_data_V_1_payload_A[16]_i_1 
       (.I0(Q[12]),
        .I1(\i_data_V_data_V_0_payload_A_reg[31] [12]),
        .I2(i_data_V_data_V_0_sel),
        .I3(grp_handle_header_fu_175_o_data_TDATA[16]),
        .I4(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [16]));
  LUT6 #(
    .INIT(64'hB888B8BBB8BBB8BB)) 
    \o_data_V_data_V_1_payload_A[16]_i_2 
       (.I0(\tmp_data_V_reg_577_reg[31] [16]),
        .I1(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I2(tmp_data_V_1_reg_761[16]),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(tmp_9_fu_417_p3),
        .I5(ap_CS_fsm_state4),
        .O(grp_handle_header_fu_175_o_data_TDATA[16]));
  LUT6 #(
    .INIT(64'hAAAAAAAACFC0C0C0)) 
    \o_data_V_data_V_1_payload_A[17]_i_1 
       (.I0(\i_data_V_data_V_0_payload_B_reg[28] [4]),
        .I1(\tmp_data_V_reg_577_reg[31] [17]),
        .I2(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(tmp_data_V_1_reg_761[17]),
        .I5(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [17]));
  LUT5 #(
    .INIT(32'hACACFF00)) 
    \o_data_V_data_V_1_payload_A[18]_i_1 
       (.I0(Q[13]),
        .I1(\i_data_V_data_V_0_payload_A_reg[31] [13]),
        .I2(i_data_V_data_V_0_sel),
        .I3(grp_handle_header_fu_175_o_data_TDATA[18]),
        .I4(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [18]));
  LUT6 #(
    .INIT(64'hB888B8BBB8BBB8BB)) 
    \o_data_V_data_V_1_payload_A[18]_i_2 
       (.I0(\tmp_data_V_reg_577_reg[31] [18]),
        .I1(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I2(tmp_data_V_1_reg_761[18]),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(tmp_9_fu_417_p3),
        .I5(ap_CS_fsm_state4),
        .O(grp_handle_header_fu_175_o_data_TDATA[18]));
  LUT5 #(
    .INIT(32'hACACFF00)) 
    \o_data_V_data_V_1_payload_A[19]_i_1 
       (.I0(Q[14]),
        .I1(\i_data_V_data_V_0_payload_A_reg[31] [14]),
        .I2(i_data_V_data_V_0_sel),
        .I3(grp_handle_header_fu_175_o_data_TDATA[19]),
        .I4(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [19]));
  LUT6 #(
    .INIT(64'hB8BBB888B888B888)) 
    \o_data_V_data_V_1_payload_A[19]_i_2 
       (.I0(\tmp_data_V_reg_577_reg[31] [19]),
        .I1(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I2(tmp_data_V_1_reg_761[19]),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(ap_CS_fsm_state4),
        .I5(tmp_9_fu_417_p3),
        .O(grp_handle_header_fu_175_o_data_TDATA[19]));
  LUT6 #(
    .INIT(64'hAAAAAAAACFC0C0C0)) 
    \o_data_V_data_V_1_payload_A[1]_i_1 
       (.I0(\i_data_V_data_V_0_payload_B_reg[28] [0]),
        .I1(\tmp_data_V_reg_577_reg[31] [1]),
        .I2(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(tmp_data_V_1_reg_761[1]),
        .I5(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [1]));
  LUT6 #(
    .INIT(64'hAAAAAAAACFC0CFCF)) 
    \o_data_V_data_V_1_payload_A[20]_i_1 
       (.I0(\i_data_V_data_V_0_payload_B_reg[28] [5]),
        .I1(\tmp_data_V_reg_577_reg[31] [20]),
        .I2(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I3(tmp_data_V_1_reg_761[20]),
        .I4(grp_handle_header_fu_175_o_data_TUSER),
        .I5(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [20]));
  LUT5 #(
    .INIT(32'hACACFF00)) 
    \o_data_V_data_V_1_payload_A[21]_i_1 
       (.I0(Q[15]),
        .I1(\i_data_V_data_V_0_payload_A_reg[31] [15]),
        .I2(i_data_V_data_V_0_sel),
        .I3(grp_handle_header_fu_175_o_data_TDATA[21]),
        .I4(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [21]));
  LUT6 #(
    .INIT(64'hB888B8BBB8BBB8BB)) 
    \o_data_V_data_V_1_payload_A[21]_i_2 
       (.I0(\tmp_data_V_reg_577_reg[31] [21]),
        .I1(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I2(tmp_data_V_1_reg_761[21]),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(tmp_9_fu_417_p3),
        .I5(ap_CS_fsm_state4),
        .O(grp_handle_header_fu_175_o_data_TDATA[21]));
  LUT5 #(
    .INIT(32'hACACFF00)) 
    \o_data_V_data_V_1_payload_A[22]_i_1 
       (.I0(Q[16]),
        .I1(\i_data_V_data_V_0_payload_A_reg[31] [16]),
        .I2(i_data_V_data_V_0_sel),
        .I3(grp_handle_header_fu_175_o_data_TDATA[22]),
        .I4(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [22]));
  LUT6 #(
    .INIT(64'hB888B8BBB8BBB8BB)) 
    \o_data_V_data_V_1_payload_A[22]_i_2 
       (.I0(\tmp_data_V_reg_577_reg[31] [22]),
        .I1(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I2(tmp_data_V_1_reg_761[22]),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(tmp_9_fu_417_p3),
        .I5(ap_CS_fsm_state4),
        .O(grp_handle_header_fu_175_o_data_TDATA[22]));
  LUT5 #(
    .INIT(32'hACACFF00)) 
    \o_data_V_data_V_1_payload_A[23]_i_1 
       (.I0(Q[17]),
        .I1(\i_data_V_data_V_0_payload_A_reg[31] [17]),
        .I2(i_data_V_data_V_0_sel),
        .I3(grp_handle_header_fu_175_o_data_TDATA[23]),
        .I4(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [23]));
  LUT6 #(
    .INIT(64'hB8BBB888B888B888)) 
    \o_data_V_data_V_1_payload_A[23]_i_2 
       (.I0(\tmp_data_V_reg_577_reg[31] [23]),
        .I1(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I2(tmp_data_V_1_reg_761[23]),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(ap_CS_fsm_state4),
        .I5(tmp_9_fu_417_p3),
        .O(grp_handle_header_fu_175_o_data_TDATA[23]));
  LUT5 #(
    .INIT(32'hACACFF00)) 
    \o_data_V_data_V_1_payload_A[24]_i_1 
       (.I0(Q[18]),
        .I1(\i_data_V_data_V_0_payload_A_reg[31] [18]),
        .I2(i_data_V_data_V_0_sel),
        .I3(grp_handle_header_fu_175_o_data_TDATA[24]),
        .I4(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [24]));
  LUT6 #(
    .INIT(64'hB888B8BBB8BBB8BB)) 
    \o_data_V_data_V_1_payload_A[24]_i_2 
       (.I0(\tmp_data_V_reg_577_reg[31] [24]),
        .I1(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I2(tmp_data_V_1_reg_761[24]),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(tmp_9_fu_417_p3),
        .I5(ap_CS_fsm_state4),
        .O(grp_handle_header_fu_175_o_data_TDATA[24]));
  LUT6 #(
    .INIT(64'hAAAAAAAACFC0C0C0)) 
    \o_data_V_data_V_1_payload_A[25]_i_1 
       (.I0(\i_data_V_data_V_0_payload_B_reg[28] [6]),
        .I1(\tmp_data_V_reg_577_reg[31] [25]),
        .I2(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(tmp_data_V_1_reg_761[25]),
        .I5(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [25]));
  LUT5 #(
    .INIT(32'hACACFF00)) 
    \o_data_V_data_V_1_payload_A[26]_i_1 
       (.I0(Q[19]),
        .I1(\i_data_V_data_V_0_payload_A_reg[31] [19]),
        .I2(i_data_V_data_V_0_sel),
        .I3(grp_handle_header_fu_175_o_data_TDATA[26]),
        .I4(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [26]));
  LUT6 #(
    .INIT(64'hB888B8BBB8BBB8BB)) 
    \o_data_V_data_V_1_payload_A[26]_i_2 
       (.I0(\tmp_data_V_reg_577_reg[31] [26]),
        .I1(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I2(tmp_data_V_1_reg_761[26]),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(tmp_9_fu_417_p3),
        .I5(ap_CS_fsm_state4),
        .O(grp_handle_header_fu_175_o_data_TDATA[26]));
  LUT5 #(
    .INIT(32'hACACFF00)) 
    \o_data_V_data_V_1_payload_A[27]_i_1 
       (.I0(Q[20]),
        .I1(\i_data_V_data_V_0_payload_A_reg[31] [20]),
        .I2(i_data_V_data_V_0_sel),
        .I3(grp_handle_header_fu_175_o_data_TDATA[27]),
        .I4(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [27]));
  LUT6 #(
    .INIT(64'hB8BBB888B888B888)) 
    \o_data_V_data_V_1_payload_A[27]_i_2 
       (.I0(\tmp_data_V_reg_577_reg[31] [27]),
        .I1(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I2(tmp_data_V_1_reg_761[27]),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(ap_CS_fsm_state4),
        .I5(tmp_9_fu_417_p3),
        .O(grp_handle_header_fu_175_o_data_TDATA[27]));
  LUT6 #(
    .INIT(64'hAAAAAAAACFC0CFCF)) 
    \o_data_V_data_V_1_payload_A[28]_i_1 
       (.I0(\i_data_V_data_V_0_payload_B_reg[28] [7]),
        .I1(\tmp_data_V_reg_577_reg[31] [28]),
        .I2(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I3(tmp_data_V_1_reg_761[28]),
        .I4(grp_handle_header_fu_175_o_data_TUSER),
        .I5(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [28]));
  LUT2 #(
    .INIT(4'h2)) 
    \o_data_V_data_V_1_payload_A[28]_i_2 
       (.I0(ap_CS_fsm_state7),
        .I1(\tmp_reg_705_reg_n_0_[0] ),
        .O(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h40)) 
    \o_data_V_data_V_1_payload_A[28]_i_3 
       (.I0(\tmp_1_reg_752_reg_n_0_[0] ),
        .I1(ap_enable_reg_pp1_iter1_reg_n_0),
        .I2(ap_CS_fsm_pp1_stage0),
        .O(grp_handle_header_fu_175_o_data_TUSER));
  LUT5 #(
    .INIT(32'hACACFF00)) 
    \o_data_V_data_V_1_payload_A[29]_i_1 
       (.I0(Q[21]),
        .I1(\i_data_V_data_V_0_payload_A_reg[31] [21]),
        .I2(i_data_V_data_V_0_sel),
        .I3(grp_handle_header_fu_175_o_data_TDATA[29]),
        .I4(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [29]));
  LUT6 #(
    .INIT(64'hB888B8BBB8BBB8BB)) 
    \o_data_V_data_V_1_payload_A[29]_i_2 
       (.I0(\tmp_data_V_reg_577_reg[31] [29]),
        .I1(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I2(tmp_data_V_1_reg_761[29]),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(tmp_9_fu_417_p3),
        .I5(ap_CS_fsm_state4),
        .O(grp_handle_header_fu_175_o_data_TDATA[29]));
  LUT5 #(
    .INIT(32'hACACFF00)) 
    \o_data_V_data_V_1_payload_A[2]_i_1 
       (.I0(Q[1]),
        .I1(\i_data_V_data_V_0_payload_A_reg[31] [1]),
        .I2(i_data_V_data_V_0_sel),
        .I3(grp_handle_header_fu_175_o_data_TDATA[2]),
        .I4(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [2]));
  LUT6 #(
    .INIT(64'hB888B8BBB8BBB8BB)) 
    \o_data_V_data_V_1_payload_A[2]_i_2 
       (.I0(\tmp_data_V_reg_577_reg[31] [2]),
        .I1(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I2(tmp_data_V_1_reg_761[2]),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(tmp_9_fu_417_p3),
        .I5(ap_CS_fsm_state4),
        .O(grp_handle_header_fu_175_o_data_TDATA[2]));
  LUT5 #(
    .INIT(32'hACACFF00)) 
    \o_data_V_data_V_1_payload_A[30]_i_1 
       (.I0(Q[22]),
        .I1(\i_data_V_data_V_0_payload_A_reg[31] [22]),
        .I2(i_data_V_data_V_0_sel),
        .I3(grp_handle_header_fu_175_o_data_TDATA[30]),
        .I4(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [30]));
  LUT6 #(
    .INIT(64'hB888B8BBB8BBB8BB)) 
    \o_data_V_data_V_1_payload_A[30]_i_2 
       (.I0(\tmp_data_V_reg_577_reg[31] [30]),
        .I1(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I2(tmp_data_V_1_reg_761[30]),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(tmp_9_fu_417_p3),
        .I5(ap_CS_fsm_state4),
        .O(grp_handle_header_fu_175_o_data_TDATA[30]));
  LUT5 #(
    .INIT(32'hACACFF00)) 
    \o_data_V_data_V_1_payload_A[31]_i_2 
       (.I0(Q[23]),
        .I1(\i_data_V_data_V_0_payload_A_reg[31] [23]),
        .I2(i_data_V_data_V_0_sel),
        .I3(grp_handle_header_fu_175_o_data_TDATA[31]),
        .I4(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [31]));
  LUT6 #(
    .INIT(64'hB8BBB888B888B888)) 
    \o_data_V_data_V_1_payload_A[31]_i_3 
       (.I0(\tmp_data_V_reg_577_reg[31] [31]),
        .I1(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I2(tmp_data_V_1_reg_761[31]),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(ap_CS_fsm_state4),
        .I5(tmp_9_fu_417_p3),
        .O(grp_handle_header_fu_175_o_data_TDATA[31]));
  LUT5 #(
    .INIT(32'hACACFF00)) 
    \o_data_V_data_V_1_payload_A[3]_i_1 
       (.I0(Q[2]),
        .I1(\i_data_V_data_V_0_payload_A_reg[31] [2]),
        .I2(i_data_V_data_V_0_sel),
        .I3(grp_handle_header_fu_175_o_data_TDATA[3]),
        .I4(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [3]));
  LUT6 #(
    .INIT(64'hB8BBB888B888B888)) 
    \o_data_V_data_V_1_payload_A[3]_i_2 
       (.I0(\tmp_data_V_reg_577_reg[31] [3]),
        .I1(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I2(tmp_data_V_1_reg_761[3]),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(ap_CS_fsm_state4),
        .I5(tmp_9_fu_417_p3),
        .O(grp_handle_header_fu_175_o_data_TDATA[3]));
  LUT6 #(
    .INIT(64'hAAAAAAAACFC0CFCF)) 
    \o_data_V_data_V_1_payload_A[4]_i_1 
       (.I0(\i_data_V_data_V_0_payload_B_reg[28] [1]),
        .I1(\tmp_data_V_reg_577_reg[31] [4]),
        .I2(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I3(tmp_data_V_1_reg_761[4]),
        .I4(grp_handle_header_fu_175_o_data_TUSER),
        .I5(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [4]));
  LUT5 #(
    .INIT(32'hACACFF00)) 
    \o_data_V_data_V_1_payload_A[5]_i_1 
       (.I0(Q[3]),
        .I1(\i_data_V_data_V_0_payload_A_reg[31] [3]),
        .I2(i_data_V_data_V_0_sel),
        .I3(grp_handle_header_fu_175_o_data_TDATA[5]),
        .I4(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [5]));
  LUT6 #(
    .INIT(64'hB888B8BBB8BBB8BB)) 
    \o_data_V_data_V_1_payload_A[5]_i_2 
       (.I0(\tmp_data_V_reg_577_reg[31] [5]),
        .I1(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I2(tmp_data_V_1_reg_761[5]),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(tmp_9_fu_417_p3),
        .I5(ap_CS_fsm_state4),
        .O(grp_handle_header_fu_175_o_data_TDATA[5]));
  LUT5 #(
    .INIT(32'hACACFF00)) 
    \o_data_V_data_V_1_payload_A[6]_i_1 
       (.I0(Q[4]),
        .I1(\i_data_V_data_V_0_payload_A_reg[31] [4]),
        .I2(i_data_V_data_V_0_sel),
        .I3(grp_handle_header_fu_175_o_data_TDATA[6]),
        .I4(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [6]));
  LUT6 #(
    .INIT(64'hB888B8BBB8BBB8BB)) 
    \o_data_V_data_V_1_payload_A[6]_i_2 
       (.I0(\tmp_data_V_reg_577_reg[31] [6]),
        .I1(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I2(tmp_data_V_1_reg_761[6]),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(tmp_9_fu_417_p3),
        .I5(ap_CS_fsm_state4),
        .O(grp_handle_header_fu_175_o_data_TDATA[6]));
  LUT5 #(
    .INIT(32'hACACFF00)) 
    \o_data_V_data_V_1_payload_A[7]_i_1 
       (.I0(Q[5]),
        .I1(\i_data_V_data_V_0_payload_A_reg[31] [5]),
        .I2(i_data_V_data_V_0_sel),
        .I3(grp_handle_header_fu_175_o_data_TDATA[7]),
        .I4(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [7]));
  LUT6 #(
    .INIT(64'hB8BBB888B888B888)) 
    \o_data_V_data_V_1_payload_A[7]_i_2 
       (.I0(\tmp_data_V_reg_577_reg[31] [7]),
        .I1(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I2(tmp_data_V_1_reg_761[7]),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(ap_CS_fsm_state4),
        .I5(tmp_9_fu_417_p3),
        .O(grp_handle_header_fu_175_o_data_TDATA[7]));
  LUT5 #(
    .INIT(32'hACACFF00)) 
    \o_data_V_data_V_1_payload_A[8]_i_1 
       (.I0(Q[6]),
        .I1(\i_data_V_data_V_0_payload_A_reg[31] [6]),
        .I2(i_data_V_data_V_0_sel),
        .I3(grp_handle_header_fu_175_o_data_TDATA[8]),
        .I4(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [8]));
  LUT6 #(
    .INIT(64'hB888B8BBB8BBB8BB)) 
    \o_data_V_data_V_1_payload_A[8]_i_2 
       (.I0(\tmp_data_V_reg_577_reg[31] [8]),
        .I1(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I2(tmp_data_V_1_reg_761[8]),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(tmp_9_fu_417_p3),
        .I5(ap_CS_fsm_state4),
        .O(grp_handle_header_fu_175_o_data_TDATA[8]));
  LUT6 #(
    .INIT(64'hAAAAAAAACFC0C0C0)) 
    \o_data_V_data_V_1_payload_A[9]_i_1 
       (.I0(\i_data_V_data_V_0_payload_B_reg[28] [2]),
        .I1(\tmp_data_V_reg_577_reg[31] [9]),
        .I2(\o_data_V_data_V_1_payload_A[28]_i_2_n_0 ),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(tmp_data_V_1_reg_761[9]),
        .I5(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_data_V_1_payload_B_reg[31] [9]));
  LUT3 #(
    .INIT(8'h78)) 
    o_data_V_data_V_1_sel_wr_i_1
       (.I0(o_data_V_data_V_1_vld_in17_in),
        .I1(o_data_V_data_V_1_ack_in),
        .I2(o_data_V_data_V_1_sel_wr),
        .O(o_data_V_data_V_1_sel_wr_reg));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT5 #(
    .INIT(32'hA2AAA000)) 
    \o_data_V_data_V_1_state[0]_i_1 
       (.I0(ap_rst_n),
        .I1(o_data_TREADY),
        .I2(o_data_V_data_V_1_vld_in17_in),
        .I3(o_data_V_data_V_1_ack_in),
        .I4(\o_data_V_data_V_1_state_reg[0]_0 ),
        .O(\o_data_V_data_V_1_state_reg[0] ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'hF3FB)) 
    \o_data_V_data_V_1_state[1]_i_1 
       (.I0(o_data_V_data_V_1_ack_in),
        .I1(\o_data_V_data_V_1_state_reg[0]_0 ),
        .I2(o_data_TREADY),
        .I3(o_data_V_data_V_1_vld_in17_in),
        .O(\o_data_V_data_V_1_state_reg[1] ));
  LUT3 #(
    .INIT(8'h78)) 
    o_data_V_dest_V_1_sel_wr_i_1
       (.I0(o_data_V_data_V_1_vld_in17_in),
        .I1(o_data_TREADY43_in),
        .I2(o_data_V_dest_V_1_sel_wr),
        .O(o_data_V_dest_V_1_sel_wr_reg));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'hA2AAA000)) 
    \o_data_V_dest_V_1_state[0]_i_1 
       (.I0(ap_rst_n),
        .I1(o_data_TREADY),
        .I2(o_data_V_data_V_1_vld_in17_in),
        .I3(o_data_TREADY43_in),
        .I4(\o_data_V_dest_V_1_state_reg[0]_0 ),
        .O(\o_data_V_dest_V_1_state_reg[0] ));
  LUT6 #(
    .INIT(64'hFFFFFFFF20000000)) 
    \o_data_V_dest_V_1_state[0]_i_2 
       (.I0(\ap_CS_fsm_reg[4]_1 [1]),
        .I1(tmp_2_fu_295_p3),
        .I2(brmerge_fu_387_p2),
        .I3(\i_data_V_data_V_0_state_reg[0] ),
        .I4(o_data_V_data_V_1_ack_in),
        .I5(o_data_V_data_V_1_vld_in),
        .O(o_data_V_data_V_1_vld_in17_in));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT4 #(
    .INIT(16'h0800)) 
    \o_data_V_dest_V_1_state[0]_i_3 
       (.I0(\tmp_2_reg_618_reg[0] ),
        .I1(\ap_CS_fsm_reg[4]_1 [2]),
        .I2(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I3(ap_reg_ioackin_o_data_TREADY_i_2_n_0),
        .O(o_data_V_data_V_1_vld_in));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'hF3FB)) 
    \o_data_V_dest_V_1_state[1]_i_1 
       (.I0(o_data_TREADY43_in),
        .I1(\o_data_V_dest_V_1_state_reg[0]_0 ),
        .I2(o_data_TREADY),
        .I3(o_data_V_data_V_1_vld_in17_in),
        .O(\o_data_V_dest_V_1_state_reg[1] ));
  LUT3 #(
    .INIT(8'h78)) 
    o_data_V_id_V_1_sel_wr_i_1
       (.I0(o_data_V_data_V_1_vld_in17_in),
        .I1(o_data_V_id_V_1_ack_in),
        .I2(o_data_V_id_V_1_sel_wr),
        .O(o_data_V_id_V_1_sel_wr_reg));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'hA2AAA000)) 
    \o_data_V_id_V_1_state[0]_i_1 
       (.I0(ap_rst_n),
        .I1(o_data_TREADY),
        .I2(o_data_V_data_V_1_vld_in17_in),
        .I3(o_data_V_id_V_1_ack_in),
        .I4(\o_data_V_id_V_1_state_reg[0]_0 ),
        .O(\o_data_V_id_V_1_state_reg[0] ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'hF3FB)) 
    \o_data_V_id_V_1_state[1]_i_1 
       (.I0(o_data_V_id_V_1_ack_in),
        .I1(\o_data_V_id_V_1_state_reg[0]_0 ),
        .I2(o_data_TREADY),
        .I3(o_data_V_data_V_1_vld_in17_in),
        .O(\o_data_V_id_V_1_state_reg[1] ));
  LUT3 #(
    .INIT(8'h78)) 
    o_data_V_keep_V_1_sel_wr_i_1
       (.I0(o_data_V_data_V_1_vld_in17_in),
        .I1(o_data_V_keep_V_1_ack_in),
        .I2(o_data_V_keep_V_1_sel_wr),
        .O(o_data_V_keep_V_1_sel_wr_reg));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'hA2AAA000)) 
    \o_data_V_keep_V_1_state[0]_i_1 
       (.I0(ap_rst_n),
        .I1(o_data_TREADY),
        .I2(o_data_V_data_V_1_vld_in17_in),
        .I3(o_data_V_keep_V_1_ack_in),
        .I4(\o_data_V_keep_V_1_state_reg[0]_0 ),
        .O(\o_data_V_keep_V_1_state_reg[0] ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'hF3FB)) 
    \o_data_V_keep_V_1_state[1]_i_1 
       (.I0(o_data_V_keep_V_1_ack_in),
        .I1(\o_data_V_keep_V_1_state_reg[0]_0 ),
        .I2(o_data_TREADY),
        .I3(o_data_V_data_V_1_vld_in17_in),
        .O(\o_data_V_keep_V_1_state_reg[1] ));
  LUT3 #(
    .INIT(8'h78)) 
    o_data_V_last_V_1_sel_wr_i_1
       (.I0(o_data_V_data_V_1_vld_in17_in),
        .I1(o_data_V_last_V_1_ack_in),
        .I2(o_data_V_last_V_1_sel_wr),
        .O(o_data_V_last_V_1_sel_wr_reg));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'hA2AAA000)) 
    \o_data_V_last_V_1_state[0]_i_1 
       (.I0(ap_rst_n),
        .I1(o_data_TREADY),
        .I2(o_data_V_data_V_1_vld_in17_in),
        .I3(o_data_V_last_V_1_ack_in),
        .I4(\o_data_V_last_V_1_state_reg[0]_0 ),
        .O(\o_data_V_last_V_1_state_reg[0] ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'hF3FB)) 
    \o_data_V_last_V_1_state[1]_i_1 
       (.I0(o_data_V_last_V_1_ack_in),
        .I1(\o_data_V_last_V_1_state_reg[0]_0 ),
        .I2(o_data_TREADY),
        .I3(o_data_V_data_V_1_vld_in17_in),
        .O(\o_data_V_last_V_1_state_reg[1] ));
  LUT3 #(
    .INIT(8'h78)) 
    o_data_V_strb_V_1_sel_wr_i_1
       (.I0(o_data_V_data_V_1_vld_in17_in),
        .I1(o_data_V_strb_V_1_ack_in),
        .I2(o_data_V_strb_V_1_sel_wr),
        .O(o_data_V_strb_V_1_sel_wr_reg));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hA2AAA000)) 
    \o_data_V_strb_V_1_state[0]_i_1 
       (.I0(ap_rst_n),
        .I1(o_data_TREADY),
        .I2(o_data_V_data_V_1_vld_in17_in),
        .I3(o_data_V_strb_V_1_ack_in),
        .I4(\o_data_V_strb_V_1_state_reg[0]_0 ),
        .O(\o_data_V_strb_V_1_state_reg[0] ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hF3FB)) 
    \o_data_V_strb_V_1_state[1]_i_1 
       (.I0(o_data_V_strb_V_1_ack_in),
        .I1(\o_data_V_strb_V_1_state_reg[0]_0 ),
        .I2(o_data_TREADY),
        .I3(o_data_V_data_V_1_vld_in17_in),
        .O(\o_data_V_strb_V_1_state_reg[1] ));
  LUT6 #(
    .INIT(64'h2F202F2F2F2F2F2F)) 
    \o_data_V_user_V_1_payload_A[64]_i_1 
       (.I0(\in_a_pulse_fu_86_reg[0]_0 ),
        .I1(CO),
        .I2(o_data_V_data_V_1_data_in1),
        .I3(grp_handle_header_fu_175_o_data_TUSER),
        .I4(tmp_9_fu_417_p3),
        .I5(ap_CS_fsm_state4),
        .O(\o_data_V_user_V_1_payload_A_reg[72] [0]));
  LUT4 #(
    .INIT(16'h0008)) 
    \o_data_V_user_V_1_payload_A[72]_i_1 
       (.I0(ap_CS_fsm_pp1_stage0),
        .I1(ap_enable_reg_pp1_iter1_reg_n_0),
        .I2(\tmp_1_reg_752_reg_n_0_[0] ),
        .I3(o_data_V_data_V_1_data_in1),
        .O(\o_data_V_user_V_1_payload_A_reg[72] [1]));
  LUT3 #(
    .INIT(8'h78)) 
    o_data_V_user_V_1_sel_wr_i_1
       (.I0(o_data_V_data_V_1_vld_in17_in),
        .I1(o_data_V_user_V_1_ack_in),
        .I2(o_data_V_user_V_1_sel_wr),
        .O(o_data_V_user_V_1_sel_wr_reg));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT5 #(
    .INIT(32'hA2AAA000)) 
    \o_data_V_user_V_1_state[0]_i_1 
       (.I0(ap_rst_n),
        .I1(o_data_TREADY),
        .I2(o_data_V_data_V_1_vld_in17_in),
        .I3(o_data_V_user_V_1_ack_in),
        .I4(\o_data_V_user_V_1_state_reg[0]_0 ),
        .O(\o_data_V_user_V_1_state_reg[0] ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'hF3FB)) 
    \o_data_V_user_V_1_state[1]_i_1 
       (.I0(o_data_V_user_V_1_ack_in),
        .I1(\o_data_V_user_V_1_state_reg[0]_0 ),
        .I2(o_data_TREADY),
        .I3(o_data_V_data_V_1_vld_in17_in),
        .O(\o_data_V_user_V_1_state_reg[1] ));
  LUT4 #(
    .INIT(16'hA8AA)) 
    \p_Result_5_reg_737[18]_i_1 
       (.I0(ap_CS_fsm_state4),
        .I1(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I2(o_data_TREADY43_in),
        .I3(tmp_9_fu_417_p3),
        .O(\p_Result_5_reg_737[18]_i_1_n_0 ));
  FDRE \p_Result_5_reg_737_reg[0] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\flags_read_reg_691_reg[15] [0]),
        .Q(p_Result_5_reg_737[0]),
        .R(1'b0));
  FDRE \p_Result_5_reg_737_reg[10] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\flags_read_reg_691_reg[15] [10]),
        .Q(p_Result_5_reg_737[10]),
        .R(1'b0));
  FDRE \p_Result_5_reg_737_reg[11] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\flags_read_reg_691_reg[15] [11]),
        .Q(p_Result_5_reg_737[11]),
        .R(1'b0));
  FDRE \p_Result_5_reg_737_reg[12] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\flags_read_reg_691_reg[15] [12]),
        .Q(p_Result_5_reg_737[12]),
        .R(1'b0));
  FDRE \p_Result_5_reg_737_reg[13] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\flags_read_reg_691_reg[15] [13]),
        .Q(p_Result_5_reg_737[13]),
        .R(1'b0));
  FDRE \p_Result_5_reg_737_reg[14] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\flags_read_reg_691_reg[15] [14]),
        .Q(p_Result_5_reg_737[14]),
        .R(1'b0));
  FDRE \p_Result_5_reg_737_reg[15] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\flags_read_reg_691_reg[15] [15]),
        .Q(p_Result_5_reg_737[15]),
        .R(1'b0));
  FDRE \p_Result_5_reg_737_reg[16] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[816] ),
        .Q(p_Result_5_reg_737[16]),
        .R(1'b0));
  FDRE \p_Result_5_reg_737_reg[17] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[817] ),
        .Q(p_Result_5_reg_737[17]),
        .R(1'b0));
  FDRE \p_Result_5_reg_737_reg[18] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(tmp_9_fu_417_p3),
        .Q(p_Result_5_reg_737[18]),
        .R(1'b0));
  FDRE \p_Result_5_reg_737_reg[1] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\flags_read_reg_691_reg[15] [1]),
        .Q(p_Result_5_reg_737[1]),
        .R(1'b0));
  FDRE \p_Result_5_reg_737_reg[2] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\flags_read_reg_691_reg[15] [2]),
        .Q(p_Result_5_reg_737[2]),
        .R(1'b0));
  FDRE \p_Result_5_reg_737_reg[3] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\flags_read_reg_691_reg[15] [3]),
        .Q(p_Result_5_reg_737[3]),
        .R(1'b0));
  FDRE \p_Result_5_reg_737_reg[4] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\flags_read_reg_691_reg[15] [4]),
        .Q(p_Result_5_reg_737[4]),
        .R(1'b0));
  FDRE \p_Result_5_reg_737_reg[5] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\flags_read_reg_691_reg[15] [5]),
        .Q(p_Result_5_reg_737[5]),
        .R(1'b0));
  FDRE \p_Result_5_reg_737_reg[6] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\flags_read_reg_691_reg[15] [6]),
        .Q(p_Result_5_reg_737[6]),
        .R(1'b0));
  FDRE \p_Result_5_reg_737_reg[7] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\flags_read_reg_691_reg[15] [7]),
        .Q(p_Result_5_reg_737[7]),
        .R(1'b0));
  FDRE \p_Result_5_reg_737_reg[8] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\flags_read_reg_691_reg[15] [8]),
        .Q(p_Result_5_reg_737[8]),
        .R(1'b0));
  FDRE \p_Result_5_reg_737_reg[9] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\flags_read_reg_691_reg[15] [9]),
        .Q(p_Result_5_reg_737[9]),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h00A8)) 
    \p_s_reg_366[0]_i_1 
       (.I0(ap_CS_fsm_state7),
        .I1(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I2(o_data_TREADY43_in),
        .I3(\tmp_reg_705_reg_n_0_[0] ),
        .O(\p_s_reg_366[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE400000000000000)) 
    \p_s_reg_366[0]_i_2 
       (.I0(pulse_metadata_V_0_sel),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I2(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I3(\pulse_metadata_V_0_state_reg[0]_0 ),
        .I4(ap_reg_grp_handle_header_fu_175_ap_start_reg_0),
        .I5(\ap_CS_fsm_reg_n_0_[0] ),
        .O(ap_NS_fsm129_out));
  FDRE \p_s_reg_366_reg[0] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(ap_NS_fsm129_out),
        .Q(p_s_reg_366),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h7F80)) 
    pulse_metadata_V_0_sel_rd_i_1
       (.I0(\ap_CS_fsm_reg_n_0_[0] ),
        .I1(ap_reg_grp_handle_header_fu_175_ap_start_reg_0),
        .I2(\pulse_metadata_V_0_state_reg[0]_0 ),
        .I3(pulse_metadata_V_0_sel),
        .O(pulse_metadata_V_0_sel_rd_reg));
  LUT6 #(
    .INIT(64'hAA2AAAAAAA000000)) 
    \pulse_metadata_V_0_state[0]_i_1 
       (.I0(ap_rst_n),
        .I1(ap_reg_grp_handle_header_fu_175_ap_start_reg_0),
        .I2(\ap_CS_fsm_reg_n_0_[0] ),
        .I3(pulse_metadata_V_TVALID),
        .I4(\pulse_metadata_V_0_state_reg[1]_0 ),
        .I5(\pulse_metadata_V_0_state_reg[0]_0 ),
        .O(\pulse_metadata_V_0_state_reg[0] ));
  LUT5 #(
    .INIT(32'hF333FBBB)) 
    \pulse_metadata_V_0_state[1]_i_1 
       (.I0(\pulse_metadata_V_0_state_reg[1]_0 ),
        .I1(\pulse_metadata_V_0_state_reg[0]_0 ),
        .I2(ap_reg_grp_handle_header_fu_175_ap_start_reg_0),
        .I3(\ap_CS_fsm_reg_n_0_[0] ),
        .I4(pulse_metadata_V_TVALID),
        .O(\pulse_metadata_V_0_state_reg[1] ));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[0]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [0]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [0]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[10]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [10]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [10]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[11]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [11]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [11]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair64" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[12]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [12]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [12]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair64" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[13]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [13]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [13]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair65" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[14]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [14]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [14]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair65" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[15]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [15]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [15]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair66" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[16]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [16]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [16]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair66" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[17]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [17]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [17]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair67" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[18]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [18]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [18]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair67" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[19]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [19]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [19]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[1]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [1]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [1]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair68" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[20]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [20]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [20]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair68" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[21]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [21]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [21]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair69" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[22]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [22]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [22]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[22]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair69" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[23]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [23]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [23]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair70" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[24]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [24]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [24]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair70" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[25]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [25]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [25]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair71" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[26]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [26]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [26]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair71" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[27]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [27]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [27]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair72" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[28]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [28]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [28]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair72" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[29]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [29]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [29]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[2]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [2]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [2]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair73" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[30]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [30]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [30]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[30]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair73" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[31]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [31]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [31]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[3]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [3]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [3]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[4]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [4]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [4]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[5]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [5]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [5]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[6]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [6]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [6]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair74" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[768]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [32]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [32]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[768]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair74" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[769]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [33]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [33]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[769]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair75" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[770]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [34]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [34]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[770]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair75" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[771]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [35]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [35]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[771]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair76" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[772]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [36]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [36]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[772]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[773]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [37]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [37]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[773]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair76" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[774]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [38]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [38]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[774]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[775]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [39]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [39]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[775]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair77" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[776]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [40]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [40]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[776]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair78" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[777]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [41]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [41]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[777]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair78" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[778]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [42]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [42]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[778]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair79" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[779]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [43]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [43]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[779]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair79" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[780]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [44]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [44]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[780]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair80" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[781]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [45]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [45]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[781]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair80" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[782]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [46]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [46]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[782]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair81" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[783]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [47]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [47]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[783]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair81" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[784]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [48]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [48]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[784]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair82" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[785]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [49]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [49]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[785]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair82" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[786]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [50]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [50]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[786]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair83" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[787]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [51]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [51]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[787]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair83" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[788]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [52]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [52]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[788]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair84" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[789]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [53]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [53]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[789]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair84" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[790]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [54]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [54]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[790]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair85" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[791]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [55]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [55]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[791]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair85" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[792]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [56]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [56]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[792]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair86" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[793]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [57]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [57]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[793]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair86" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[794]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [58]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [58]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[794]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair87" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[795]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [59]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [59]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[795]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair87" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[796]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [60]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [60]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[796]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair77" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[797]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [61]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [61]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[797]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair88" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[798]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [62]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [62]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[798]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair88" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[799]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [63]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [63]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[799]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[7]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [7]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [7]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair89" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[800]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [64]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [64]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[800]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair90" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[801]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [65]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [65]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[801]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair90" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[802]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [66]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [66]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[802]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair91" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[803]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [67]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [67]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[803]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair91" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[804]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [68]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [68]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[804]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair92" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[805]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [69]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [69]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[805]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair92" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[806]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [70]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [70]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[806]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair93" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[807]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [71]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [71]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[807]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair93" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[808]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [72]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [72]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[808]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair89" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[809]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [73]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [73]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[809]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair94" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[810]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [74]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [74]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[810]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair94" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[811]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [75]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [75]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[811]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair95" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[812]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [76]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [76]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[812]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair96" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[813]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [77]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [77]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[813]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair96" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[814]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [78]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [78]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[814]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair95" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[815]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [79]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [79]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[815]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair97" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[816]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [80]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [80]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[816]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair97" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[817]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [81]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [81]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[817]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair98" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[818]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [82]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [82]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[818]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h80)) 
    \pulse_metadata_V_rea_reg_694[819]_i_1 
       (.I0(\ap_CS_fsm_reg_n_0_[0] ),
        .I1(ap_reg_grp_handle_header_fu_175_ap_start_reg_0),
        .I2(\pulse_metadata_V_0_state_reg[0]_0 ),
        .O(grp_handle_header_fu_175_pulse_metadata_V_TREADY));
  (* SOFT_HLUTNM = "soft_lutpair98" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[819]_i_2 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [83]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [83]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[819]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[8]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [8]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [8]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \pulse_metadata_V_rea_reg_694[9]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [9]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [9]),
        .I2(pulse_metadata_V_0_sel),
        .O(\pulse_metadata_V_rea_reg_694[9]_i_1_n_0 ));
  FDRE \pulse_metadata_V_rea_reg_694_reg[0] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[0]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[10] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[10]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[10] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[11] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[11]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[11] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[12] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[12]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[12] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[13] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[13]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[13] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[14] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[14]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[14] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[15] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[15]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[15] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[16] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[16]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[16] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[17] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[17]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[17] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[18] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[18]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[18] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[19] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[19]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[19] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[1] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[1]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[20] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[20]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[20] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[21] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[21]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[21] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[22] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[22]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[22] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[23] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[23]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[23] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[24] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[24]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[24] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[25] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[25]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[25] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[26] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[26]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[26] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[27] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[27]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[27] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[28] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[28]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[28] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[29] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[29]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[29] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[2] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[2]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[30] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[30]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[30] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[31] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[31]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[31] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[3] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[3]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[4] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[4]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[5] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[5]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[5] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[6] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[6]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[6] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[768] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[768]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[768] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[769] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[769]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[769] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[770] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[770]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[770] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[771] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[771]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[771] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[772] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[772]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[772] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[773] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[773]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[773] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[774] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[774]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[774] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[775] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[775]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[775] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[776] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[776]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[776] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[777] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[777]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[777] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[778] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[778]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[778] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[779] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[779]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[779] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[780] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[780]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[780] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[781] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[781]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[781] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[782] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[782]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[782] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[783] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[783]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[783] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[784] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[784]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[784] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[785] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[785]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[785] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[786] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[786]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[786] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[787] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[787]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[787] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[788] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[788]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[788] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[789] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[789]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[789] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[790] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[790]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[790] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[791] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[791]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[791] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[792] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[792]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[792] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[793] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[793]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[793] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[794] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[794]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[794] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[795] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[795]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[795] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[796] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[796]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[796] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[797] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[797]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[797] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[798] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[798]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[798] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[799] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[799]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[799] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[7] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[7]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[7] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[800] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[800]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[800] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[801] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[801]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[801] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[802] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[802]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[802] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[803] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[803]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[803] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[804] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[804]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[804] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[805] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[805]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[805] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[806] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[806]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[806] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[807] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[807]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[807] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[808] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[808]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[808] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[809] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[809]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[809] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[810] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[810]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[810] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[811] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[811]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[811] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[812] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[812]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[812] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[813] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[813]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[813] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[814] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[814]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[814] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[815] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[815]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[815] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[816] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[816]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[816] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[817] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[817]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[817] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[818] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[818]_i_1_n_0 ),
        .Q(tmp_9_fu_417_p3),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[819] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[819]_i_2_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[819] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[8] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[8]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[8] ),
        .R(1'b0));
  FDRE \pulse_metadata_V_rea_reg_694_reg[9] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\pulse_metadata_V_rea_reg_694[9]_i_1_n_0 ),
        .Q(\pulse_metadata_V_rea_reg_694_reg_n_0_[9] ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hB800B800B8FFB800)) 
    \sample_counter_fu_94[0]_i_1 
       (.I0(sample_counter_write_phi_fu_359_p4),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[0]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(\sample_counter_fu_94_reg[0] ),
        .O(\sample_counter_fu_94_reg[31] [0]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[10]_i_1 
       (.I0(\ap_return_7_preg[10]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[10]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[9]),
        .O(\sample_counter_fu_94_reg[31] [10]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[11]_i_1 
       (.I0(\ap_return_7_preg[11]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[11]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[10]),
        .O(\sample_counter_fu_94_reg[31] [11]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[12]_i_1 
       (.I0(\ap_return_7_preg[12]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[12]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[11]),
        .O(\sample_counter_fu_94_reg[31] [12]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[13]_i_1 
       (.I0(\ap_return_7_preg[13]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[13]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[12]),
        .O(\sample_counter_fu_94_reg[31] [13]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[14]_i_1 
       (.I0(\ap_return_7_preg[14]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[14]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[13]),
        .O(\sample_counter_fu_94_reg[31] [14]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[15]_i_1 
       (.I0(\ap_return_7_preg[15]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[15]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[14]),
        .O(\sample_counter_fu_94_reg[31] [15]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[16]_i_1 
       (.I0(\ap_return_7_preg[16]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[16]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[15]),
        .O(\sample_counter_fu_94_reg[31] [16]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[17]_i_1 
       (.I0(\ap_return_7_preg[17]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[17]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[16]),
        .O(\sample_counter_fu_94_reg[31] [17]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[18]_i_1 
       (.I0(\ap_return_7_preg[18]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[18]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[17]),
        .O(\sample_counter_fu_94_reg[31] [18]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[19]_i_1 
       (.I0(\ap_return_7_preg[19]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[19]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[18]),
        .O(\sample_counter_fu_94_reg[31] [19]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[1]_i_1 
       (.I0(\ap_return_7_preg[1]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[1]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[0]),
        .O(\sample_counter_fu_94_reg[31] [1]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[20]_i_1 
       (.I0(\ap_return_7_preg[20]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[20]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[19]),
        .O(\sample_counter_fu_94_reg[31] [20]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[21]_i_1 
       (.I0(\ap_return_7_preg[21]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[21]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[20]),
        .O(\sample_counter_fu_94_reg[31] [21]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[22]_i_1 
       (.I0(\ap_return_7_preg[22]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[22]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[21]),
        .O(\sample_counter_fu_94_reg[31] [22]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[23]_i_1 
       (.I0(\ap_return_7_preg[23]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[23]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[22]),
        .O(\sample_counter_fu_94_reg[31] [23]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[24]_i_1 
       (.I0(\ap_return_7_preg[24]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[24]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[23]),
        .O(\sample_counter_fu_94_reg[31] [24]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[25]_i_1 
       (.I0(\ap_return_7_preg[25]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[25]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[24]),
        .O(\sample_counter_fu_94_reg[31] [25]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[26]_i_1 
       (.I0(\ap_return_7_preg[26]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[26]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[25]),
        .O(\sample_counter_fu_94_reg[31] [26]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[27]_i_1 
       (.I0(\ap_return_7_preg[27]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[27]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[26]),
        .O(\sample_counter_fu_94_reg[31] [27]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[28]_i_1 
       (.I0(\ap_return_7_preg[28]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[28]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[27]),
        .O(\sample_counter_fu_94_reg[31] [28]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[29]_i_1 
       (.I0(\ap_return_7_preg[29]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[29]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[28]),
        .O(\sample_counter_fu_94_reg[31] [29]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[2]_i_1 
       (.I0(\ap_return_7_preg[2]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[2]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[1]),
        .O(\sample_counter_fu_94_reg[31] [2]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[30]_i_1 
       (.I0(\ap_return_7_preg[30]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[30]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[29]),
        .O(\sample_counter_fu_94_reg[31] [30]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'hFFEAAAEA)) 
    \sample_counter_fu_94[31]_i_1 
       (.I0(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I1(ap_start),
        .I2(\ap_CS_fsm_reg[4]_1 [0]),
        .I3(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I4(dec_keep_reg_667),
        .O(E));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[31]_i_2 
       (.I0(\ap_return_7_preg[31]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[31]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[30]),
        .O(\sample_counter_fu_94_reg[31] [31]));
  LUT3 #(
    .INIT(8'h08)) 
    \sample_counter_fu_94[31]_i_3 
       (.I0(\ap_CS_fsm_reg[4]_1 [2]),
        .I1(ap_NS_fsm3),
        .I2(\tmp_2_reg_618_reg[0] ),
        .O(\sample_counter_fu_94[31]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[3]_i_1 
       (.I0(\ap_return_7_preg[3]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[3]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[2]),
        .O(\sample_counter_fu_94_reg[31] [3]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[4]_i_1 
       (.I0(\ap_return_7_preg[4]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[4]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[3]),
        .O(\sample_counter_fu_94_reg[31] [4]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[5]_i_1 
       (.I0(\ap_return_7_preg[5]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[5]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[4]),
        .O(\sample_counter_fu_94_reg[31] [5]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[6]_i_1 
       (.I0(\ap_return_7_preg[6]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[6]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[5]),
        .O(\sample_counter_fu_94_reg[31] [6]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[7]_i_1 
       (.I0(\ap_return_7_preg[7]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[7]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[6]),
        .O(\sample_counter_fu_94_reg[31] [7]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[8]_i_1 
       (.I0(\ap_return_7_preg[8]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[8]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[7]),
        .O(\sample_counter_fu_94_reg[31] [8]));
  LUT6 #(
    .INIT(64'hB8FFB800B800B800)) 
    \sample_counter_fu_94[9]_i_1 
       (.I0(\ap_return_7_preg[9]_i_1_n_0 ),
        .I1(\ap_return_4_preg[7]_i_1_n_0 ),
        .I2(ap_return_7_preg[9]),
        .I3(\decimation_value_fu_102[7]_i_4_n_0 ),
        .I4(\sample_counter_fu_94[31]_i_3_n_0 ),
        .I5(sample_counter_1_fu_430_p2[8]),
        .O(\sample_counter_fu_94_reg[31] [9]));
  FDSE \sample_counter_write_reg_356_reg[0] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [0]),
        .Q(sample_counter_write_reg_356[0]),
        .S(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[10] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [10]),
        .Q(sample_counter_write_reg_356[10]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[11] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [11]),
        .Q(sample_counter_write_reg_356[11]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[12] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [12]),
        .Q(sample_counter_write_reg_356[12]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[13] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [13]),
        .Q(sample_counter_write_reg_356[13]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[14] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [14]),
        .Q(sample_counter_write_reg_356[14]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[15] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [15]),
        .Q(sample_counter_write_reg_356[15]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[16] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [16]),
        .Q(sample_counter_write_reg_356[16]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[17] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [17]),
        .Q(sample_counter_write_reg_356[17]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[18] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [18]),
        .Q(sample_counter_write_reg_356[18]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[19] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [19]),
        .Q(sample_counter_write_reg_356[19]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[1] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [1]),
        .Q(sample_counter_write_reg_356[1]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[20] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [20]),
        .Q(sample_counter_write_reg_356[20]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[21] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [21]),
        .Q(sample_counter_write_reg_356[21]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[22] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [22]),
        .Q(sample_counter_write_reg_356[22]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[23] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [23]),
        .Q(sample_counter_write_reg_356[23]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[24] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [24]),
        .Q(sample_counter_write_reg_356[24]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[25] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [25]),
        .Q(sample_counter_write_reg_356[25]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[26] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [26]),
        .Q(sample_counter_write_reg_356[26]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[27] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [27]),
        .Q(sample_counter_write_reg_356[27]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[28] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [28]),
        .Q(sample_counter_write_reg_356[28]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[29] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [29]),
        .Q(sample_counter_write_reg_356[29]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[2] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [2]),
        .Q(sample_counter_write_reg_356[2]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[30] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [30]),
        .Q(sample_counter_write_reg_356[30]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[31] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [31]),
        .Q(sample_counter_write_reg_356[31]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[3] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [3]),
        .Q(sample_counter_write_reg_356[3]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[4] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [4]),
        .Q(sample_counter_write_reg_356[4]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[5] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [5]),
        .Q(sample_counter_write_reg_356[5]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[6] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [6]),
        .Q(sample_counter_write_reg_356[6]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[7] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [7]),
        .Q(sample_counter_write_reg_356[7]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[8] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [8]),
        .Q(sample_counter_write_reg_356[8]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \sample_counter_write_reg_356_reg[9] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(\sample_counter_load_1_reg_632_reg[31] [9]),
        .Q(sample_counter_write_reg_356[9]),
        .R(\p_s_reg_366[0]_i_1_n_0 ));
  FDRE \tmp_12_reg_721_reg[0] 
       (.C(ap_clk),
        .CE(\p_Result_5_reg_737[18]_i_1_n_0 ),
        .D(\pulse_metadata_V_rea_reg_694_reg_n_0_[819] ),
        .Q(tmp_12_reg_721),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hBBBBBBBB88808888)) 
    \tmp_1_reg_752[0]_i_1 
       (.I0(ap_condition_pp1_exit_iter0_state5),
        .I1(ap_CS_fsm_pp1_stage0),
        .I2(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I3(o_data_TREADY43_in),
        .I4(ap_enable_reg_pp1_iter1_reg_n_0),
        .I5(\tmp_1_reg_752_reg_n_0_[0] ),
        .O(\tmp_1_reg_752[0]_i_1_n_0 ));
  FDRE \tmp_1_reg_752_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\tmp_1_reg_752[0]_i_1_n_0 ),
        .Q(\tmp_1_reg_752_reg_n_0_[0] ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hBBBFBBBB88888888)) 
    \tmp_7_reg_709[0]_i_1 
       (.I0(tmp_7_fu_406_p2),
        .I1(ap_CS_fsm_pp0_stage0),
        .I2(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I3(o_data_TREADY43_in),
        .I4(ap_enable_reg_pp0_iter1_reg_n_0),
        .I5(tmp_7_reg_709),
        .O(\tmp_7_reg_709[0]_i_1_n_0 ));
  FDRE \tmp_7_reg_709_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\tmp_7_reg_709[0]_i_1_n_0 ),
        .Q(tmp_7_reg_709),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hAFA0CFCF)) 
    \tmp_data_V_1_reg_761[0]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [0]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [0]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(p_Result_5_reg_737[0]),
        .I4(x2_reg_296_reg__0[0]),
        .O(mux_2_0[0]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \tmp_data_V_1_reg_761[0]_i_3 
       (.I0(header_6_reg_747[0]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(header_5_reg_726[0]),
        .I3(x2_reg_296_reg__0[0]),
        .I4(header_4_reg_742[0]),
        .O(mux_2_1[0]));
  LUT6 #(
    .INIT(64'h3808FFFF38080000)) 
    \tmp_data_V_1_reg_761[10]_i_1 
       (.I0(header_6_reg_747[10]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(header_5_reg_726[10]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(mux_2_0[10]),
        .O(tmp_data_V_1_fu_521_p10[10]));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \tmp_data_V_1_reg_761[10]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [10]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [10]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(x2_reg_296_reg__0[0]),
        .I4(p_Result_5_reg_737[10]),
        .O(mux_2_0[10]));
  LUT6 #(
    .INIT(64'h3808FFFF38080000)) 
    \tmp_data_V_1_reg_761[11]_i_1 
       (.I0(header_6_reg_747[11]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(header_5_reg_726[11]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(mux_2_0[11]),
        .O(tmp_data_V_1_fu_521_p10[11]));
  LUT5 #(
    .INIT(32'hAFA0CFCF)) 
    \tmp_data_V_1_reg_761[11]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [11]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [11]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(p_Result_5_reg_737[11]),
        .I4(x2_reg_296_reg__0[0]),
        .O(mux_2_0[11]));
  LUT6 #(
    .INIT(64'h3808FFFF38080000)) 
    \tmp_data_V_1_reg_761[12]_i_1 
       (.I0(header_6_reg_747[12]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(header_5_reg_726[12]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(mux_2_0[12]),
        .O(tmp_data_V_1_fu_521_p10[12]));
  LUT5 #(
    .INIT(32'hAFA0CFCF)) 
    \tmp_data_V_1_reg_761[12]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [12]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [12]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(p_Result_5_reg_737[12]),
        .I4(x2_reg_296_reg__0[0]),
        .O(mux_2_0[12]));
  LUT6 #(
    .INIT(64'h3808FFFF38080000)) 
    \tmp_data_V_1_reg_761[13]_i_1 
       (.I0(header_6_reg_747[13]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(header_5_reg_726[13]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(mux_2_0[13]),
        .O(tmp_data_V_1_fu_521_p10[13]));
  LUT5 #(
    .INIT(32'hAFA0CFCF)) 
    \tmp_data_V_1_reg_761[13]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [13]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [13]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(p_Result_5_reg_737[13]),
        .I4(x2_reg_296_reg__0[0]),
        .O(mux_2_0[13]));
  LUT6 #(
    .INIT(64'h3808FFFF38080000)) 
    \tmp_data_V_1_reg_761[14]_i_1 
       (.I0(header_6_reg_747[14]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(header_5_reg_726[14]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(mux_2_0[14]),
        .O(tmp_data_V_1_fu_521_p10[14]));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \tmp_data_V_1_reg_761[14]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [14]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [14]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(x2_reg_296_reg__0[0]),
        .I4(p_Result_5_reg_737[14]),
        .O(mux_2_0[14]));
  LUT6 #(
    .INIT(64'h3808FFFF38080000)) 
    \tmp_data_V_1_reg_761[15]_i_1 
       (.I0(header_6_reg_747[15]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(header_5_reg_726[15]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(mux_2_0[15]),
        .O(tmp_data_V_1_fu_521_p10[15]));
  LUT5 #(
    .INIT(32'hAFA0CFCF)) 
    \tmp_data_V_1_reg_761[15]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [15]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [15]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(p_Result_5_reg_737[15]),
        .I4(x2_reg_296_reg__0[0]),
        .O(mux_2_0[15]));
  LUT6 #(
    .INIT(64'h3808FFFF38080000)) 
    \tmp_data_V_1_reg_761[16]_i_1 
       (.I0(header_6_reg_747[16]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(header_5_reg_726[16]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(mux_2_0[16]),
        .O(tmp_data_V_1_fu_521_p10[16]));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \tmp_data_V_1_reg_761[16]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [16]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [16]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(x2_reg_296_reg__0[0]),
        .I4(p_Result_5_reg_737[16]),
        .O(mux_2_0[16]));
  LUT6 #(
    .INIT(64'h3808FFFF38080000)) 
    \tmp_data_V_1_reg_761[17]_i_1 
       (.I0(header_6_reg_747[17]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(header_5_reg_726[17]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(mux_2_0[17]),
        .O(tmp_data_V_1_fu_521_p10[17]));
  LUT5 #(
    .INIT(32'hAFA0CFCF)) 
    \tmp_data_V_1_reg_761[17]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [17]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [17]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(p_Result_5_reg_737[17]),
        .I4(x2_reg_296_reg__0[0]),
        .O(mux_2_0[17]));
  LUT6 #(
    .INIT(64'h3808FFFF38080000)) 
    \tmp_data_V_1_reg_761[18]_i_1 
       (.I0(header_6_reg_747[18]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(header_5_reg_726[18]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(mux_2_0[18]),
        .O(tmp_data_V_1_fu_521_p10[18]));
  LUT5 #(
    .INIT(32'hAFA0CFCF)) 
    \tmp_data_V_1_reg_761[18]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [18]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [18]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(p_Result_5_reg_737[18]),
        .I4(x2_reg_296_reg__0[0]),
        .O(mux_2_0[18]));
  LUT6 #(
    .INIT(64'h3808FFFF38080000)) 
    \tmp_data_V_1_reg_761[19]_i_1 
       (.I0(header_6_reg_747[19]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(header_5_reg_726[19]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(mux_2_0[19]),
        .O(tmp_data_V_1_fu_521_p10[19]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'hAFA0CFCF)) 
    \tmp_data_V_1_reg_761[19]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [19]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [19]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(tmp_12_reg_721),
        .I4(x2_reg_296_reg__0[0]),
        .O(mux_2_0[19]));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \tmp_data_V_1_reg_761[1]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [1]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [1]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(x2_reg_296_reg__0[0]),
        .I4(p_Result_5_reg_737[1]),
        .O(mux_2_0[1]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \tmp_data_V_1_reg_761[1]_i_3 
       (.I0(header_6_reg_747[1]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(header_5_reg_726[1]),
        .I3(x2_reg_296_reg__0[0]),
        .I4(header_4_reg_742[1]),
        .O(mux_2_1[1]));
  LUT6 #(
    .INIT(64'h3808FFFF38080000)) 
    \tmp_data_V_1_reg_761[20]_i_1 
       (.I0(header_6_reg_747[20]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(header_5_reg_726[20]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(mux_2_0[20]),
        .O(tmp_data_V_1_fu_521_p10[20]));
  LUT4 #(
    .INIT(16'hA0CF)) 
    \tmp_data_V_1_reg_761[20]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [20]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [20]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(x2_reg_296_reg__0[0]),
        .O(mux_2_0[20]));
  LUT6 #(
    .INIT(64'h3808FFFF38080000)) 
    \tmp_data_V_1_reg_761[21]_i_1 
       (.I0(header_6_reg_747[21]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(header_5_reg_726[21]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(mux_2_0[21]),
        .O(tmp_data_V_1_fu_521_p10[21]));
  LUT4 #(
    .INIT(16'hA808)) 
    \tmp_data_V_1_reg_761[21]_i_2 
       (.I0(x2_reg_296_reg__0[1]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [21]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(\pos_enc_1_read_reg_686_reg[31] [21]),
        .O(mux_2_0[21]));
  LUT6 #(
    .INIT(64'h3808FFFF38080000)) 
    \tmp_data_V_1_reg_761[22]_i_1 
       (.I0(header_6_reg_747[22]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(header_5_reg_726[22]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(mux_2_0[22]),
        .O(tmp_data_V_1_fu_521_p10[22]));
  LUT4 #(
    .INIT(16'hA0CF)) 
    \tmp_data_V_1_reg_761[22]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [22]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [22]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(x2_reg_296_reg__0[0]),
        .O(mux_2_0[22]));
  LUT6 #(
    .INIT(64'h3808FFFF38080000)) 
    \tmp_data_V_1_reg_761[23]_i_1 
       (.I0(header_6_reg_747[23]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(header_5_reg_726[23]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(mux_2_0[23]),
        .O(tmp_data_V_1_fu_521_p10[23]));
  LUT4 #(
    .INIT(16'hA808)) 
    \tmp_data_V_1_reg_761[23]_i_2 
       (.I0(x2_reg_296_reg__0[1]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [23]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(\pos_enc_1_read_reg_686_reg[31] [23]),
        .O(mux_2_0[23]));
  LUT6 #(
    .INIT(64'h3808FFFF38080000)) 
    \tmp_data_V_1_reg_761[24]_i_1 
       (.I0(header_6_reg_747[24]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(header_5_reg_726[24]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(mux_2_0[24]),
        .O(tmp_data_V_1_fu_521_p10[24]));
  LUT4 #(
    .INIT(16'hA808)) 
    \tmp_data_V_1_reg_761[24]_i_2 
       (.I0(x2_reg_296_reg__0[1]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [24]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(\pos_enc_1_read_reg_686_reg[31] [24]),
        .O(mux_2_0[24]));
  LUT6 #(
    .INIT(64'h3808FFFF38080000)) 
    \tmp_data_V_1_reg_761[25]_i_1 
       (.I0(header_6_reg_747[25]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(header_5_reg_726[25]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(mux_2_0[25]),
        .O(tmp_data_V_1_fu_521_p10[25]));
  LUT4 #(
    .INIT(16'hA0CF)) 
    \tmp_data_V_1_reg_761[25]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [25]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [25]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(x2_reg_296_reg__0[0]),
        .O(mux_2_0[25]));
  LUT6 #(
    .INIT(64'h3808FFFF38080000)) 
    \tmp_data_V_1_reg_761[26]_i_1 
       (.I0(header_6_reg_747[26]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(header_5_reg_726[26]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(mux_2_0[26]),
        .O(tmp_data_V_1_fu_521_p10[26]));
  LUT4 #(
    .INIT(16'hA808)) 
    \tmp_data_V_1_reg_761[26]_i_2 
       (.I0(x2_reg_296_reg__0[1]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [26]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(\pos_enc_1_read_reg_686_reg[31] [26]),
        .O(mux_2_0[26]));
  LUT6 #(
    .INIT(64'h3808FFFF38080000)) 
    \tmp_data_V_1_reg_761[27]_i_1 
       (.I0(header_6_reg_747[27]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(header_5_reg_726[27]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(mux_2_0[27]),
        .O(tmp_data_V_1_fu_521_p10[27]));
  LUT4 #(
    .INIT(16'hA0CF)) 
    \tmp_data_V_1_reg_761[27]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [27]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [27]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(x2_reg_296_reg__0[0]),
        .O(mux_2_0[27]));
  LUT6 #(
    .INIT(64'h3808FFFF38080000)) 
    \tmp_data_V_1_reg_761[28]_i_1 
       (.I0(header_6_reg_747[28]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(header_5_reg_726[28]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(mux_2_0[28]),
        .O(tmp_data_V_1_fu_521_p10[28]));
  LUT4 #(
    .INIT(16'hA0CF)) 
    \tmp_data_V_1_reg_761[28]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [28]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [28]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(x2_reg_296_reg__0[0]),
        .O(mux_2_0[28]));
  LUT6 #(
    .INIT(64'h3808FFFF38080000)) 
    \tmp_data_V_1_reg_761[29]_i_1 
       (.I0(header_6_reg_747[29]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(header_5_reg_726[29]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(mux_2_0[29]),
        .O(tmp_data_V_1_fu_521_p10[29]));
  LUT4 #(
    .INIT(16'hA0CF)) 
    \tmp_data_V_1_reg_761[29]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [29]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [29]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(x2_reg_296_reg__0[0]),
        .O(mux_2_0[29]));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \tmp_data_V_1_reg_761[2]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [2]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [2]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(x2_reg_296_reg__0[0]),
        .I4(p_Result_5_reg_737[2]),
        .O(mux_2_0[2]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \tmp_data_V_1_reg_761[2]_i_3 
       (.I0(header_6_reg_747[2]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(header_5_reg_726[2]),
        .I3(x2_reg_296_reg__0[0]),
        .I4(header_4_reg_742[2]),
        .O(mux_2_1[2]));
  LUT6 #(
    .INIT(64'h3808FFFF38080000)) 
    \tmp_data_V_1_reg_761[30]_i_1 
       (.I0(header_6_reg_747[30]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(header_5_reg_726[30]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(mux_2_0[30]),
        .O(tmp_data_V_1_fu_521_p10[30]));
  LUT4 #(
    .INIT(16'hA808)) 
    \tmp_data_V_1_reg_761[30]_i_2 
       (.I0(x2_reg_296_reg__0[1]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [30]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(\pos_enc_1_read_reg_686_reg[31] [30]),
        .O(mux_2_0[30]));
  LUT6 #(
    .INIT(64'h4444444444444044)) 
    \tmp_data_V_1_reg_761[31]_i_1 
       (.I0(\tmp_data_V_1_reg_761[31]_i_3_n_0 ),
        .I1(ap_CS_fsm_pp1_stage0),
        .I2(x2_reg_296_reg__0[1]),
        .I3(x2_reg_296_reg__0[3]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(x2_reg_296_reg__0[0]),
        .O(\tmp_data_V_1_reg_761[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h3808FFFF38080000)) 
    \tmp_data_V_1_reg_761[31]_i_2 
       (.I0(header_6_reg_747[31]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(header_5_reg_726[31]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(mux_2_0[31]),
        .O(tmp_data_V_1_fu_521_p10[31]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h0004)) 
    \tmp_data_V_1_reg_761[31]_i_3 
       (.I0(\tmp_1_reg_752_reg_n_0_[0] ),
        .I1(ap_enable_reg_pp1_iter1_reg_n_0),
        .I2(o_data_TREADY43_in),
        .I3(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .O(\tmp_data_V_1_reg_761[31]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT4 #(
    .INIT(16'hA0CF)) 
    \tmp_data_V_1_reg_761[31]_i_4 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [31]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [31]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(x2_reg_296_reg__0[0]),
        .O(mux_2_0[31]));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \tmp_data_V_1_reg_761[3]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [3]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [3]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(x2_reg_296_reg__0[0]),
        .I4(p_Result_5_reg_737[3]),
        .O(mux_2_0[3]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \tmp_data_V_1_reg_761[3]_i_3 
       (.I0(header_6_reg_747[3]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(header_5_reg_726[3]),
        .I3(x2_reg_296_reg__0[0]),
        .I4(header_4_reg_742[3]),
        .O(mux_2_1[3]));
  LUT5 #(
    .INIT(32'hAFA0CFCF)) 
    \tmp_data_V_1_reg_761[4]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [4]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [4]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(p_Result_5_reg_737[4]),
        .I4(x2_reg_296_reg__0[0]),
        .O(mux_2_0[4]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \tmp_data_V_1_reg_761[4]_i_3 
       (.I0(header_6_reg_747[4]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(header_5_reg_726[4]),
        .I3(x2_reg_296_reg__0[0]),
        .I4(header_4_reg_742[4]),
        .O(mux_2_1[4]));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \tmp_data_V_1_reg_761[5]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [5]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [5]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(x2_reg_296_reg__0[0]),
        .I4(p_Result_5_reg_737[5]),
        .O(mux_2_0[5]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \tmp_data_V_1_reg_761[5]_i_3 
       (.I0(header_6_reg_747[5]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(header_5_reg_726[5]),
        .I3(x2_reg_296_reg__0[0]),
        .I4(header_4_reg_742[5]),
        .O(mux_2_1[5]));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \tmp_data_V_1_reg_761[6]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [6]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [6]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(x2_reg_296_reg__0[0]),
        .I4(p_Result_5_reg_737[6]),
        .O(mux_2_0[6]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \tmp_data_V_1_reg_761[6]_i_3 
       (.I0(header_6_reg_747[6]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(header_5_reg_726[6]),
        .I3(x2_reg_296_reg__0[0]),
        .I4(header_4_reg_742[6]),
        .O(mux_2_1[6]));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \tmp_data_V_1_reg_761[7]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [7]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [7]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(x2_reg_296_reg__0[0]),
        .I4(p_Result_5_reg_737[7]),
        .O(mux_2_0[7]));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \tmp_data_V_1_reg_761[7]_i_3 
       (.I0(header_6_reg_747[7]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(header_5_reg_726[7]),
        .I3(x2_reg_296_reg__0[0]),
        .I4(header_4_reg_742[7]),
        .O(mux_2_1[7]));
  LUT6 #(
    .INIT(64'h3808FFFF38080000)) 
    \tmp_data_V_1_reg_761[8]_i_1 
       (.I0(header_6_reg_747[8]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(header_5_reg_726[8]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(mux_2_0[8]),
        .O(tmp_data_V_1_fu_521_p10[8]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \tmp_data_V_1_reg_761[8]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [8]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [8]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(x2_reg_296_reg__0[0]),
        .I4(p_Result_5_reg_737[8]),
        .O(mux_2_0[8]));
  LUT6 #(
    .INIT(64'h3808FFFF38080000)) 
    \tmp_data_V_1_reg_761[9]_i_1 
       (.I0(header_6_reg_747[9]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[0]),
        .I3(header_5_reg_726[9]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(mux_2_0[9]),
        .O(tmp_data_V_1_fu_521_p10[9]));
  LUT5 #(
    .INIT(32'hAFA0CFCF)) 
    \tmp_data_V_1_reg_761[9]_i_2 
       (.I0(\pos_enc_1_read_reg_686_reg[31] [9]),
        .I1(\pos_enc_0_read_reg_681_reg[31] [9]),
        .I2(x2_reg_296_reg__0[1]),
        .I3(p_Result_5_reg_737[9]),
        .I4(x2_reg_296_reg__0[0]),
        .O(mux_2_0[9]));
  FDRE \tmp_data_V_1_reg_761_reg[0] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[0]),
        .Q(tmp_data_V_1_reg_761[0]),
        .R(1'b0));
  MUXF7 \tmp_data_V_1_reg_761_reg[0]_i_1 
       (.I0(mux_2_0[0]),
        .I1(mux_2_1[0]),
        .O(tmp_data_V_1_fu_521_p10[0]),
        .S(x2_reg_296_reg__0[2]));
  FDRE \tmp_data_V_1_reg_761_reg[10] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[10]),
        .Q(tmp_data_V_1_reg_761[10]),
        .R(1'b0));
  FDRE \tmp_data_V_1_reg_761_reg[11] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[11]),
        .Q(tmp_data_V_1_reg_761[11]),
        .R(1'b0));
  FDRE \tmp_data_V_1_reg_761_reg[12] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[12]),
        .Q(tmp_data_V_1_reg_761[12]),
        .R(1'b0));
  FDRE \tmp_data_V_1_reg_761_reg[13] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[13]),
        .Q(tmp_data_V_1_reg_761[13]),
        .R(1'b0));
  FDRE \tmp_data_V_1_reg_761_reg[14] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[14]),
        .Q(tmp_data_V_1_reg_761[14]),
        .R(1'b0));
  FDRE \tmp_data_V_1_reg_761_reg[15] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[15]),
        .Q(tmp_data_V_1_reg_761[15]),
        .R(1'b0));
  FDRE \tmp_data_V_1_reg_761_reg[16] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[16]),
        .Q(tmp_data_V_1_reg_761[16]),
        .R(1'b0));
  FDRE \tmp_data_V_1_reg_761_reg[17] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[17]),
        .Q(tmp_data_V_1_reg_761[17]),
        .R(1'b0));
  FDRE \tmp_data_V_1_reg_761_reg[18] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[18]),
        .Q(tmp_data_V_1_reg_761[18]),
        .R(1'b0));
  FDRE \tmp_data_V_1_reg_761_reg[19] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[19]),
        .Q(tmp_data_V_1_reg_761[19]),
        .R(1'b0));
  FDRE \tmp_data_V_1_reg_761_reg[1] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[1]),
        .Q(tmp_data_V_1_reg_761[1]),
        .R(1'b0));
  MUXF7 \tmp_data_V_1_reg_761_reg[1]_i_1 
       (.I0(mux_2_0[1]),
        .I1(mux_2_1[1]),
        .O(tmp_data_V_1_fu_521_p10[1]),
        .S(x2_reg_296_reg__0[2]));
  FDRE \tmp_data_V_1_reg_761_reg[20] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[20]),
        .Q(tmp_data_V_1_reg_761[20]),
        .R(1'b0));
  FDRE \tmp_data_V_1_reg_761_reg[21] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[21]),
        .Q(tmp_data_V_1_reg_761[21]),
        .R(1'b0));
  FDRE \tmp_data_V_1_reg_761_reg[22] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[22]),
        .Q(tmp_data_V_1_reg_761[22]),
        .R(1'b0));
  FDRE \tmp_data_V_1_reg_761_reg[23] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[23]),
        .Q(tmp_data_V_1_reg_761[23]),
        .R(1'b0));
  FDRE \tmp_data_V_1_reg_761_reg[24] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[24]),
        .Q(tmp_data_V_1_reg_761[24]),
        .R(1'b0));
  FDRE \tmp_data_V_1_reg_761_reg[25] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[25]),
        .Q(tmp_data_V_1_reg_761[25]),
        .R(1'b0));
  FDRE \tmp_data_V_1_reg_761_reg[26] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[26]),
        .Q(tmp_data_V_1_reg_761[26]),
        .R(1'b0));
  FDRE \tmp_data_V_1_reg_761_reg[27] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[27]),
        .Q(tmp_data_V_1_reg_761[27]),
        .R(1'b0));
  FDRE \tmp_data_V_1_reg_761_reg[28] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[28]),
        .Q(tmp_data_V_1_reg_761[28]),
        .R(1'b0));
  FDRE \tmp_data_V_1_reg_761_reg[29] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[29]),
        .Q(tmp_data_V_1_reg_761[29]),
        .R(1'b0));
  FDRE \tmp_data_V_1_reg_761_reg[2] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[2]),
        .Q(tmp_data_V_1_reg_761[2]),
        .R(1'b0));
  MUXF7 \tmp_data_V_1_reg_761_reg[2]_i_1 
       (.I0(mux_2_0[2]),
        .I1(mux_2_1[2]),
        .O(tmp_data_V_1_fu_521_p10[2]),
        .S(x2_reg_296_reg__0[2]));
  FDRE \tmp_data_V_1_reg_761_reg[30] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[30]),
        .Q(tmp_data_V_1_reg_761[30]),
        .R(1'b0));
  FDRE \tmp_data_V_1_reg_761_reg[31] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[31]),
        .Q(tmp_data_V_1_reg_761[31]),
        .R(1'b0));
  FDRE \tmp_data_V_1_reg_761_reg[3] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[3]),
        .Q(tmp_data_V_1_reg_761[3]),
        .R(1'b0));
  MUXF7 \tmp_data_V_1_reg_761_reg[3]_i_1 
       (.I0(mux_2_0[3]),
        .I1(mux_2_1[3]),
        .O(tmp_data_V_1_fu_521_p10[3]),
        .S(x2_reg_296_reg__0[2]));
  FDRE \tmp_data_V_1_reg_761_reg[4] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[4]),
        .Q(tmp_data_V_1_reg_761[4]),
        .R(1'b0));
  MUXF7 \tmp_data_V_1_reg_761_reg[4]_i_1 
       (.I0(mux_2_0[4]),
        .I1(mux_2_1[4]),
        .O(tmp_data_V_1_fu_521_p10[4]),
        .S(x2_reg_296_reg__0[2]));
  FDRE \tmp_data_V_1_reg_761_reg[5] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[5]),
        .Q(tmp_data_V_1_reg_761[5]),
        .R(1'b0));
  MUXF7 \tmp_data_V_1_reg_761_reg[5]_i_1 
       (.I0(mux_2_0[5]),
        .I1(mux_2_1[5]),
        .O(tmp_data_V_1_fu_521_p10[5]),
        .S(x2_reg_296_reg__0[2]));
  FDRE \tmp_data_V_1_reg_761_reg[6] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[6]),
        .Q(tmp_data_V_1_reg_761[6]),
        .R(1'b0));
  MUXF7 \tmp_data_V_1_reg_761_reg[6]_i_1 
       (.I0(mux_2_0[6]),
        .I1(mux_2_1[6]),
        .O(tmp_data_V_1_fu_521_p10[6]),
        .S(x2_reg_296_reg__0[2]));
  FDRE \tmp_data_V_1_reg_761_reg[7] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[7]),
        .Q(tmp_data_V_1_reg_761[7]),
        .R(1'b0));
  MUXF7 \tmp_data_V_1_reg_761_reg[7]_i_1 
       (.I0(mux_2_0[7]),
        .I1(mux_2_1[7]),
        .O(tmp_data_V_1_fu_521_p10[7]),
        .S(x2_reg_296_reg__0[2]));
  FDRE \tmp_data_V_1_reg_761_reg[8] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[8]),
        .Q(tmp_data_V_1_reg_761[8]),
        .R(1'b0));
  FDRE \tmp_data_V_1_reg_761_reg[9] 
       (.C(ap_clk),
        .CE(\tmp_data_V_1_reg_761[31]_i_1_n_0 ),
        .D(tmp_data_V_1_fu_521_p10[9]),
        .Q(tmp_data_V_1_reg_761[9]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_reg_705[0]_i_1 
       (.I0(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I1(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I2(pulse_metadata_V_0_sel),
        .O(\tmp_reg_705[0]_i_1_n_0 ));
  FDRE \tmp_reg_705_reg[0] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .D(\tmp_reg_705[0]_i_1_n_0 ),
        .Q(\tmp_reg_705_reg_n_0_[0] ),
        .R(1'b0));
  FDSE \write_flag3_reg_344_reg[0] 
       (.C(ap_clk),
        .CE(ap_NS_fsm129_out),
        .D(1'b0),
        .Q(write_flag3_reg_344),
        .S(\p_s_reg_366[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAAAAEAAA)) 
    \x1_reg_287[0]_i_1 
       (.I0(ap_enable_reg_pp0_iter0_i_2_n_0),
        .I1(ap_enable_reg_pp0_iter0),
        .I2(tmp_7_fu_406_p2),
        .I3(ap_CS_fsm_pp0_stage0),
        .I4(ap_enable_reg_pp0_iter0_i_3_n_0),
        .O(\x1_reg_287[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[0]_i_10 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [1]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[1]),
        .O(\x1_reg_287[0]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h5C5C55CC55555555)) 
    \x1_reg_287[0]_i_11 
       (.I0(x1_reg_287_reg[0]),
        .I1(\sample_counter_load_1_reg_632_reg[31] [0]),
        .I2(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(pulse_metadata_V_0_sel),
        .I5(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .O(\x1_reg_287[0]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[0]_i_3 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [0]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[0]),
        .O(\x1_reg_287[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[0]_i_4 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [7]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[7]),
        .O(\x1_reg_287[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[0]_i_5 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [6]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[6]),
        .O(\x1_reg_287[0]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[0]_i_6 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [5]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[5]),
        .O(\x1_reg_287[0]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[0]_i_7 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [4]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[4]),
        .O(\x1_reg_287[0]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[0]_i_8 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [3]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[3]),
        .O(\x1_reg_287[0]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[0]_i_9 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [2]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[2]),
        .O(\x1_reg_287[0]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[16]_i_2 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [23]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[23]),
        .O(\x1_reg_287[16]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[16]_i_3 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [22]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[22]),
        .O(\x1_reg_287[16]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[16]_i_4 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [21]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[21]),
        .O(\x1_reg_287[16]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[16]_i_5 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [20]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[20]),
        .O(\x1_reg_287[16]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[16]_i_6 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [19]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[19]),
        .O(\x1_reg_287[16]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[16]_i_7 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [18]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[18]),
        .O(\x1_reg_287[16]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[16]_i_8 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [17]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[17]),
        .O(\x1_reg_287[16]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[16]_i_9 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [16]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[16]),
        .O(\x1_reg_287[16]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[24]_i_2 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [31]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[31]),
        .O(\x1_reg_287[24]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[24]_i_3 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [30]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[30]),
        .O(\x1_reg_287[24]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[24]_i_4 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [29]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[29]),
        .O(\x1_reg_287[24]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[24]_i_5 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [28]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[28]),
        .O(\x1_reg_287[24]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[24]_i_6 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [27]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[27]),
        .O(\x1_reg_287[24]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[24]_i_7 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [26]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[26]),
        .O(\x1_reg_287[24]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[24]_i_8 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [25]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[25]),
        .O(\x1_reg_287[24]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[24]_i_9 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [24]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[24]),
        .O(\x1_reg_287[24]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[8]_i_2 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [15]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[15]),
        .O(\x1_reg_287[8]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[8]_i_3 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [14]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[14]),
        .O(\x1_reg_287[8]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[8]_i_4 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [13]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[13]),
        .O(\x1_reg_287[8]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[8]_i_5 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [12]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[12]),
        .O(\x1_reg_287[8]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[8]_i_6 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [11]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[11]),
        .O(\x1_reg_287[8]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[8]_i_7 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [10]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[10]),
        .O(\x1_reg_287[8]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[8]_i_8 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [9]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[9]),
        .O(\x1_reg_287[8]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBBFBB00088088)) 
    \x1_reg_287[8]_i_9 
       (.I0(\sample_counter_load_1_reg_632_reg[31] [8]),
        .I1(grp_handle_header_fu_175_pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel),
        .I3(\pulse_metadata_V_0_payload_A_reg[820] [84]),
        .I4(\pulse_metadata_V_0_payload_B_reg[820] [84]),
        .I5(x1_reg_287_reg[8]),
        .O(\x1_reg_287[8]_i_9_n_0 ));
  FDRE \x1_reg_287_reg[0] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[0]_i_2_n_15 ),
        .Q(x1_reg_287_reg[0]),
        .R(1'b0));
  CARRY8 \x1_reg_287_reg[0]_i_2 
       (.CI(1'b0),
        .CI_TOP(1'b0),
        .CO({\x1_reg_287_reg[0]_i_2_n_0 ,\x1_reg_287_reg[0]_i_2_n_1 ,\x1_reg_287_reg[0]_i_2_n_2 ,\x1_reg_287_reg[0]_i_2_n_3 ,\NLW_x1_reg_287_reg[0]_i_2_CO_UNCONNECTED [3],\x1_reg_287_reg[0]_i_2_n_5 ,\x1_reg_287_reg[0]_i_2_n_6 ,\x1_reg_287_reg[0]_i_2_n_7 }),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,\x1_reg_287[0]_i_3_n_0 }),
        .O({\x1_reg_287_reg[0]_i_2_n_8 ,\x1_reg_287_reg[0]_i_2_n_9 ,\x1_reg_287_reg[0]_i_2_n_10 ,\x1_reg_287_reg[0]_i_2_n_11 ,\x1_reg_287_reg[0]_i_2_n_12 ,\x1_reg_287_reg[0]_i_2_n_13 ,\x1_reg_287_reg[0]_i_2_n_14 ,\x1_reg_287_reg[0]_i_2_n_15 }),
        .S({\x1_reg_287[0]_i_4_n_0 ,\x1_reg_287[0]_i_5_n_0 ,\x1_reg_287[0]_i_6_n_0 ,\x1_reg_287[0]_i_7_n_0 ,\x1_reg_287[0]_i_8_n_0 ,\x1_reg_287[0]_i_9_n_0 ,\x1_reg_287[0]_i_10_n_0 ,\x1_reg_287[0]_i_11_n_0 }));
  FDRE \x1_reg_287_reg[10] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[8]_i_1_n_13 ),
        .Q(x1_reg_287_reg[10]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[11] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[8]_i_1_n_12 ),
        .Q(x1_reg_287_reg[11]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[12] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[8]_i_1_n_11 ),
        .Q(x1_reg_287_reg[12]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[13] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[8]_i_1_n_10 ),
        .Q(x1_reg_287_reg[13]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[14] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[8]_i_1_n_9 ),
        .Q(x1_reg_287_reg[14]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[15] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[8]_i_1_n_8 ),
        .Q(x1_reg_287_reg[15]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[16] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[16]_i_1_n_15 ),
        .Q(x1_reg_287_reg[16]),
        .R(1'b0));
  CARRY8 \x1_reg_287_reg[16]_i_1 
       (.CI(\x1_reg_287_reg[8]_i_1_n_0 ),
        .CI_TOP(1'b0),
        .CO({\x1_reg_287_reg[16]_i_1_n_0 ,\x1_reg_287_reg[16]_i_1_n_1 ,\x1_reg_287_reg[16]_i_1_n_2 ,\x1_reg_287_reg[16]_i_1_n_3 ,\NLW_x1_reg_287_reg[16]_i_1_CO_UNCONNECTED [3],\x1_reg_287_reg[16]_i_1_n_5 ,\x1_reg_287_reg[16]_i_1_n_6 ,\x1_reg_287_reg[16]_i_1_n_7 }),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .O({\x1_reg_287_reg[16]_i_1_n_8 ,\x1_reg_287_reg[16]_i_1_n_9 ,\x1_reg_287_reg[16]_i_1_n_10 ,\x1_reg_287_reg[16]_i_1_n_11 ,\x1_reg_287_reg[16]_i_1_n_12 ,\x1_reg_287_reg[16]_i_1_n_13 ,\x1_reg_287_reg[16]_i_1_n_14 ,\x1_reg_287_reg[16]_i_1_n_15 }),
        .S({\x1_reg_287[16]_i_2_n_0 ,\x1_reg_287[16]_i_3_n_0 ,\x1_reg_287[16]_i_4_n_0 ,\x1_reg_287[16]_i_5_n_0 ,\x1_reg_287[16]_i_6_n_0 ,\x1_reg_287[16]_i_7_n_0 ,\x1_reg_287[16]_i_8_n_0 ,\x1_reg_287[16]_i_9_n_0 }));
  FDRE \x1_reg_287_reg[17] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[16]_i_1_n_14 ),
        .Q(x1_reg_287_reg[17]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[18] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[16]_i_1_n_13 ),
        .Q(x1_reg_287_reg[18]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[19] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[16]_i_1_n_12 ),
        .Q(x1_reg_287_reg[19]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[1] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[0]_i_2_n_14 ),
        .Q(x1_reg_287_reg[1]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[20] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[16]_i_1_n_11 ),
        .Q(x1_reg_287_reg[20]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[21] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[16]_i_1_n_10 ),
        .Q(x1_reg_287_reg[21]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[22] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[16]_i_1_n_9 ),
        .Q(x1_reg_287_reg[22]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[23] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[16]_i_1_n_8 ),
        .Q(x1_reg_287_reg[23]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[24] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[24]_i_1_n_15 ),
        .Q(x1_reg_287_reg[24]),
        .R(1'b0));
  CARRY8 \x1_reg_287_reg[24]_i_1 
       (.CI(\x1_reg_287_reg[16]_i_1_n_0 ),
        .CI_TOP(1'b0),
        .CO({\NLW_x1_reg_287_reg[24]_i_1_CO_UNCONNECTED [7],\x1_reg_287_reg[24]_i_1_n_1 ,\x1_reg_287_reg[24]_i_1_n_2 ,\x1_reg_287_reg[24]_i_1_n_3 ,\NLW_x1_reg_287_reg[24]_i_1_CO_UNCONNECTED [3],\x1_reg_287_reg[24]_i_1_n_5 ,\x1_reg_287_reg[24]_i_1_n_6 ,\x1_reg_287_reg[24]_i_1_n_7 }),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .O({\x1_reg_287_reg[24]_i_1_n_8 ,\x1_reg_287_reg[24]_i_1_n_9 ,\x1_reg_287_reg[24]_i_1_n_10 ,\x1_reg_287_reg[24]_i_1_n_11 ,\x1_reg_287_reg[24]_i_1_n_12 ,\x1_reg_287_reg[24]_i_1_n_13 ,\x1_reg_287_reg[24]_i_1_n_14 ,\x1_reg_287_reg[24]_i_1_n_15 }),
        .S({\x1_reg_287[24]_i_2_n_0 ,\x1_reg_287[24]_i_3_n_0 ,\x1_reg_287[24]_i_4_n_0 ,\x1_reg_287[24]_i_5_n_0 ,\x1_reg_287[24]_i_6_n_0 ,\x1_reg_287[24]_i_7_n_0 ,\x1_reg_287[24]_i_8_n_0 ,\x1_reg_287[24]_i_9_n_0 }));
  FDRE \x1_reg_287_reg[25] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[24]_i_1_n_14 ),
        .Q(x1_reg_287_reg[25]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[26] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[24]_i_1_n_13 ),
        .Q(x1_reg_287_reg[26]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[27] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[24]_i_1_n_12 ),
        .Q(x1_reg_287_reg[27]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[28] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[24]_i_1_n_11 ),
        .Q(x1_reg_287_reg[28]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[29] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[24]_i_1_n_10 ),
        .Q(x1_reg_287_reg[29]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[2] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[0]_i_2_n_13 ),
        .Q(x1_reg_287_reg[2]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[30] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[24]_i_1_n_9 ),
        .Q(x1_reg_287_reg[30]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[31] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[24]_i_1_n_8 ),
        .Q(x1_reg_287_reg[31]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[3] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[0]_i_2_n_12 ),
        .Q(x1_reg_287_reg[3]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[4] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[0]_i_2_n_11 ),
        .Q(x1_reg_287_reg[4]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[5] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[0]_i_2_n_10 ),
        .Q(x1_reg_287_reg[5]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[6] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[0]_i_2_n_9 ),
        .Q(x1_reg_287_reg[6]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[7] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[0]_i_2_n_8 ),
        .Q(x1_reg_287_reg[7]),
        .R(1'b0));
  FDRE \x1_reg_287_reg[8] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[8]_i_1_n_15 ),
        .Q(x1_reg_287_reg[8]),
        .R(1'b0));
  CARRY8 \x1_reg_287_reg[8]_i_1 
       (.CI(\x1_reg_287_reg[0]_i_2_n_0 ),
        .CI_TOP(1'b0),
        .CO({\x1_reg_287_reg[8]_i_1_n_0 ,\x1_reg_287_reg[8]_i_1_n_1 ,\x1_reg_287_reg[8]_i_1_n_2 ,\x1_reg_287_reg[8]_i_1_n_3 ,\NLW_x1_reg_287_reg[8]_i_1_CO_UNCONNECTED [3],\x1_reg_287_reg[8]_i_1_n_5 ,\x1_reg_287_reg[8]_i_1_n_6 ,\x1_reg_287_reg[8]_i_1_n_7 }),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .O({\x1_reg_287_reg[8]_i_1_n_8 ,\x1_reg_287_reg[8]_i_1_n_9 ,\x1_reg_287_reg[8]_i_1_n_10 ,\x1_reg_287_reg[8]_i_1_n_11 ,\x1_reg_287_reg[8]_i_1_n_12 ,\x1_reg_287_reg[8]_i_1_n_13 ,\x1_reg_287_reg[8]_i_1_n_14 ,\x1_reg_287_reg[8]_i_1_n_15 }),
        .S({\x1_reg_287[8]_i_2_n_0 ,\x1_reg_287[8]_i_3_n_0 ,\x1_reg_287[8]_i_4_n_0 ,\x1_reg_287[8]_i_5_n_0 ,\x1_reg_287[8]_i_6_n_0 ,\x1_reg_287[8]_i_7_n_0 ,\x1_reg_287[8]_i_8_n_0 ,\x1_reg_287[8]_i_9_n_0 }));
  FDRE \x1_reg_287_reg[9] 
       (.C(ap_clk),
        .CE(\x1_reg_287[0]_i_1_n_0 ),
        .D(\x1_reg_287_reg[8]_i_1_n_14 ),
        .Q(x1_reg_287_reg[9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \x2_reg_296[0]_i_1 
       (.I0(x2_reg_296_reg__0[0]),
        .O(\x2_reg_296[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \x2_reg_296[1]_i_1 
       (.I0(x2_reg_296_reg__0[0]),
        .I1(x2_reg_296_reg__0[1]),
        .O(x_1_fu_511_p2[1]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \x2_reg_296[2]_i_1 
       (.I0(x2_reg_296_reg__0[0]),
        .I1(x2_reg_296_reg__0[1]),
        .I2(x2_reg_296_reg__0[2]),
        .O(x_1_fu_511_p2[2]));
  LUT5 #(
    .INIT(32'h0000FD00)) 
    \x2_reg_296[3]_i_1 
       (.I0(tmp_9_fu_417_p3),
        .I1(o_data_TREADY43_in),
        .I2(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I3(ap_CS_fsm_state4),
        .I4(\x2_reg_296[3]_i_2_n_0 ),
        .O(\x2_reg_296[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h8888888888888088)) 
    \x2_reg_296[3]_i_2 
       (.I0(\x2_reg_296[3]_i_4_n_0 ),
        .I1(ap_enable_reg_pp1_iter0),
        .I2(x2_reg_296_reg__0[1]),
        .I3(x2_reg_296_reg__0[3]),
        .I4(x2_reg_296_reg__0[2]),
        .I5(x2_reg_296_reg__0[0]),
        .O(\x2_reg_296[3]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h7F80)) 
    \x2_reg_296[3]_i_3 
       (.I0(x2_reg_296_reg__0[1]),
        .I1(x2_reg_296_reg__0[0]),
        .I2(x2_reg_296_reg__0[2]),
        .I3(x2_reg_296_reg__0[3]),
        .O(x_1_fu_511_p2[3]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'hAAAAA8AA)) 
    \x2_reg_296[3]_i_4 
       (.I0(ap_CS_fsm_pp1_stage0),
        .I1(ap_reg_ioackin_o_data_TREADY_reg_n_0),
        .I2(o_data_TREADY43_in),
        .I3(ap_enable_reg_pp1_iter1_reg_n_0),
        .I4(\tmp_1_reg_752_reg_n_0_[0] ),
        .O(\x2_reg_296[3]_i_4_n_0 ));
  FDRE \x2_reg_296_reg[0] 
       (.C(ap_clk),
        .CE(\x2_reg_296[3]_i_2_n_0 ),
        .D(\x2_reg_296[0]_i_1_n_0 ),
        .Q(x2_reg_296_reg__0[0]),
        .R(\x2_reg_296[3]_i_1_n_0 ));
  FDRE \x2_reg_296_reg[1] 
       (.C(ap_clk),
        .CE(\x2_reg_296[3]_i_2_n_0 ),
        .D(x_1_fu_511_p2[1]),
        .Q(x2_reg_296_reg__0[1]),
        .R(\x2_reg_296[3]_i_1_n_0 ));
  FDRE \x2_reg_296_reg[2] 
       (.C(ap_clk),
        .CE(\x2_reg_296[3]_i_2_n_0 ),
        .D(x_1_fu_511_p2[2]),
        .Q(x2_reg_296_reg__0[2]),
        .R(\x2_reg_296[3]_i_1_n_0 ));
  FDRE \x2_reg_296_reg[3] 
       (.C(ap_clk),
        .CE(\x2_reg_296[3]_i_2_n_0 ),
        .D(x_1_fu_511_p2[3]),
        .Q(x2_reg_296_reg__0[3]),
        .R(\x2_reg_296[3]_i_1_n_0 ));
endmodule

(* ORIG_REF_NAME = "hcr_metadata_injector" *) 
module user_block2_hcr_metadata_injector_0_0_hcr_metadata_injector
   (ap_clk,
    ap_rst_n,
    ap_start,
    ap_done,
    ap_idle,
    ap_ready,
    i_data_TDATA,
    i_data_TVALID,
    i_data_TREADY,
    i_data_TKEEP,
    i_data_TSTRB,
    i_data_TUSER,
    i_data_TLAST,
    i_data_TID,
    i_data_TDEST,
    o_data_TDATA,
    o_data_TVALID,
    o_data_TREADY,
    o_data_TKEEP,
    o_data_TSTRB,
    o_data_TUSER,
    o_data_TLAST,
    o_data_TID,
    o_data_TDEST,
    pulse_metadata_V_TDATA,
    pulse_metadata_V_TVALID,
    pulse_metadata_V_TREADY,
    pos_enc_0,
    pos_enc_1,
    flags);
  input ap_clk;
  input ap_rst_n;
  input ap_start;
  output ap_done;
  output ap_idle;
  output ap_ready;
  input [31:0]i_data_TDATA;
  input i_data_TVALID;
  output i_data_TREADY;
  input [3:0]i_data_TKEEP;
  input [3:0]i_data_TSTRB;
  input [127:0]i_data_TUSER;
  input [0:0]i_data_TLAST;
  input [0:0]i_data_TID;
  input [0:0]i_data_TDEST;
  output [31:0]o_data_TDATA;
  output o_data_TVALID;
  input o_data_TREADY;
  output [3:0]o_data_TKEEP;
  output [3:0]o_data_TSTRB;
  output [127:0]o_data_TUSER;
  output [0:0]o_data_TLAST;
  output [0:0]o_data_TID;
  output [0:0]o_data_TDEST;
  input [823:0]pulse_metadata_V_TDATA;
  input pulse_metadata_V_TVALID;
  output pulse_metadata_V_TREADY;
  input [31:0]pos_enc_0;
  input [31:0]pos_enc_1;
  input [15:0]flags;

  wire \ap_CS_fsm_reg_n_0_[0] ;
  wire \ap_CS_fsm_reg_n_0_[1] ;
  wire ap_CS_fsm_state3;
  wire ap_CS_fsm_state4;
  wire ap_CS_fsm_state5;
  wire [4:0]ap_NS_fsm;
  wire ap_NS_fsm1115_out;
  wire ap_clk;
  wire ap_done;
  wire ap_idle;
  wire ap_ready_INST_0_i_1_n_0;
  wire ap_reg_grp_handle_header_fu_175_ap_start_reg_n_0;
  wire ap_return_3;
  wire [7:1]ap_return_4;
  wire [31:0]ap_return_6;
  wire ap_rst;
  wire ap_rst_n;
  wire ap_start;
  wire ap_start0;
  wire \break_after_pulse_fu_106_reg_n_0_[0] ;
  wire break_after_pulse_lo_reg_647;
  wire brmerge_fu_387_p2;
  wire brmerge_reg_672;
  wire \brmerge_reg_672[0]_i_10_n_0 ;
  wire \brmerge_reg_672[0]_i_11_n_0 ;
  wire \brmerge_reg_672[0]_i_12_n_0 ;
  wire \brmerge_reg_672[0]_i_13_n_0 ;
  wire \brmerge_reg_672[0]_i_14_n_0 ;
  wire \brmerge_reg_672[0]_i_15_n_0 ;
  wire \brmerge_reg_672[0]_i_1_n_0 ;
  wire \brmerge_reg_672[0]_i_5_n_0 ;
  wire \brmerge_reg_672[0]_i_6_n_0 ;
  wire \brmerge_reg_672[0]_i_7_n_0 ;
  wire \brmerge_reg_672[0]_i_8_n_0 ;
  wire \brmerge_reg_672[0]_i_9_n_0 ;
  wire \brmerge_reg_672_reg[0]_i_3_n_6 ;
  wire \brmerge_reg_672_reg[0]_i_3_n_7 ;
  wire \brmerge_reg_672_reg[0]_i_4_n_0 ;
  wire \brmerge_reg_672_reg[0]_i_4_n_1 ;
  wire \brmerge_reg_672_reg[0]_i_4_n_2 ;
  wire \brmerge_reg_672_reg[0]_i_4_n_3 ;
  wire \brmerge_reg_672_reg[0]_i_4_n_5 ;
  wire \brmerge_reg_672_reg[0]_i_4_n_6 ;
  wire \brmerge_reg_672_reg[0]_i_4_n_7 ;
  wire dec_keep_fu_363_p2;
  wire dec_keep_reg_667;
  wire \dec_keep_reg_667[0]_i_2_n_0 ;
  wire \dec_keep_reg_667[0]_i_3_n_0 ;
  wire [7:7]decimation_counter_1_fu_393_p2;
  wire [7:0]decimation_counter_fu_98;
  wire \decimation_counter_fu_98[0]_i_2_n_0 ;
  wire \decimation_counter_fu_98[1]_i_2_n_0 ;
  wire \decimation_counter_fu_98[2]_i_2_n_0 ;
  wire \decimation_counter_fu_98[2]_i_4_n_0 ;
  wire \decimation_counter_fu_98[3]_i_2_n_0 ;
  wire \decimation_counter_fu_98[3]_i_4_n_0 ;
  wire \decimation_counter_fu_98[4]_i_2_n_0 ;
  wire \decimation_counter_fu_98[4]_i_4_n_0 ;
  wire \decimation_counter_fu_98[5]_i_2_n_0 ;
  wire \decimation_counter_fu_98[5]_i_4_n_0 ;
  wire \decimation_counter_fu_98[6]_i_2_n_0 ;
  wire \decimation_counter_fu_98[6]_i_4_n_0 ;
  wire \decimation_counter_fu_98[7]_i_4_n_0 ;
  wire [7:0]decimation_counter_l_reg_637;
  wire [7:0]decimation_value_fu_102;
  wire [7:0]decimation_value_loa_reg_642;
  wire [15:0]flags;
  wire \flags_read_reg_691_reg_n_0_[0] ;
  wire \flags_read_reg_691_reg_n_0_[10] ;
  wire \flags_read_reg_691_reg_n_0_[11] ;
  wire \flags_read_reg_691_reg_n_0_[12] ;
  wire \flags_read_reg_691_reg_n_0_[13] ;
  wire \flags_read_reg_691_reg_n_0_[14] ;
  wire \flags_read_reg_691_reg_n_0_[15] ;
  wire \flags_read_reg_691_reg_n_0_[1] ;
  wire \flags_read_reg_691_reg_n_0_[2] ;
  wire \flags_read_reg_691_reg_n_0_[3] ;
  wire \flags_read_reg_691_reg_n_0_[4] ;
  wire \flags_read_reg_691_reg_n_0_[5] ;
  wire \flags_read_reg_691_reg_n_0_[6] ;
  wire \flags_read_reg_691_reg_n_0_[7] ;
  wire \flags_read_reg_691_reg_n_0_[8] ;
  wire \flags_read_reg_691_reg_n_0_[9] ;
  wire grp_handle_header_fu_175_n_0;
  wire grp_handle_header_fu_175_n_1;
  wire grp_handle_header_fu_175_n_100;
  wire grp_handle_header_fu_175_n_101;
  wire grp_handle_header_fu_175_n_102;
  wire grp_handle_header_fu_175_n_103;
  wire grp_handle_header_fu_175_n_104;
  wire grp_handle_header_fu_175_n_105;
  wire grp_handle_header_fu_175_n_106;
  wire grp_handle_header_fu_175_n_107;
  wire grp_handle_header_fu_175_n_108;
  wire grp_handle_header_fu_175_n_109;
  wire grp_handle_header_fu_175_n_2;
  wire grp_handle_header_fu_175_n_3;
  wire grp_handle_header_fu_175_n_4;
  wire grp_handle_header_fu_175_n_43;
  wire grp_handle_header_fu_175_n_44;
  wire grp_handle_header_fu_175_n_45;
  wire grp_handle_header_fu_175_n_46;
  wire grp_handle_header_fu_175_n_47;
  wire grp_handle_header_fu_175_n_48;
  wire grp_handle_header_fu_175_n_49;
  wire grp_handle_header_fu_175_n_5;
  wire grp_handle_header_fu_175_n_50;
  wire grp_handle_header_fu_175_n_51;
  wire grp_handle_header_fu_175_n_52;
  wire grp_handle_header_fu_175_n_53;
  wire grp_handle_header_fu_175_n_54;
  wire grp_handle_header_fu_175_n_55;
  wire grp_handle_header_fu_175_n_56;
  wire grp_handle_header_fu_175_n_57;
  wire grp_handle_header_fu_175_n_58;
  wire grp_handle_header_fu_175_n_59;
  wire grp_handle_header_fu_175_n_6;
  wire grp_handle_header_fu_175_n_60;
  wire grp_handle_header_fu_175_n_61;
  wire grp_handle_header_fu_175_n_62;
  wire grp_handle_header_fu_175_n_63;
  wire grp_handle_header_fu_175_n_64;
  wire grp_handle_header_fu_175_n_65;
  wire grp_handle_header_fu_175_n_66;
  wire grp_handle_header_fu_175_n_67;
  wire grp_handle_header_fu_175_n_68;
  wire grp_handle_header_fu_175_n_69;
  wire grp_handle_header_fu_175_n_7;
  wire grp_handle_header_fu_175_n_70;
  wire grp_handle_header_fu_175_n_71;
  wire grp_handle_header_fu_175_n_72;
  wire grp_handle_header_fu_175_n_73;
  wire grp_handle_header_fu_175_n_74;
  wire grp_handle_header_fu_175_n_75;
  wire grp_handle_header_fu_175_n_76;
  wire grp_handle_header_fu_175_n_77;
  wire grp_handle_header_fu_175_n_8;
  wire grp_handle_header_fu_175_n_82;
  wire grp_handle_header_fu_175_n_9;
  wire grp_handle_header_fu_175_n_92;
  wire grp_handle_header_fu_175_n_93;
  wire grp_handle_header_fu_175_n_94;
  wire grp_handle_header_fu_175_n_95;
  wire grp_handle_header_fu_175_n_96;
  wire grp_handle_header_fu_175_n_97;
  wire grp_handle_header_fu_175_n_98;
  wire grp_handle_header_fu_175_n_99;
  wire [31:0]i_data_TDATA;
  wire [0:0]i_data_TDEST;
  wire [0:0]i_data_TID;
  wire [3:0]i_data_TKEEP;
  wire [0:0]i_data_TLAST;
  wire i_data_TREADY;
  wire [3:0]i_data_TSTRB;
  wire [127:0]i_data_TUSER;
  wire i_data_TVALID;
  wire i_data_V_data_V_0_ack_in;
  wire [31:0]i_data_V_data_V_0_data_out;
  wire i_data_V_data_V_0_load_B;
  wire [31:0]i_data_V_data_V_0_payload_A;
  wire \i_data_V_data_V_0_payload_A[31]_i_1_n_0 ;
  wire [31:0]i_data_V_data_V_0_payload_B;
  wire i_data_V_data_V_0_sel;
  wire i_data_V_data_V_0_sel_rd_i_1_n_0;
  wire i_data_V_data_V_0_sel_wr;
  wire i_data_V_data_V_0_sel_wr_i_1_n_0;
  wire \i_data_V_data_V_0_state[0]_i_1_n_0 ;
  wire \i_data_V_data_V_0_state[1]_i_1_n_0 ;
  wire \i_data_V_data_V_0_state_reg_n_0_[0] ;
  wire i_data_V_dest_V_0_data_out;
  wire i_data_V_dest_V_0_payload_A;
  wire \i_data_V_dest_V_0_payload_A[0]_i_1_n_0 ;
  wire i_data_V_dest_V_0_payload_B;
  wire \i_data_V_dest_V_0_payload_B[0]_i_1_n_0 ;
  wire i_data_V_dest_V_0_sel;
  wire i_data_V_dest_V_0_sel_rd_i_1_n_0;
  wire i_data_V_dest_V_0_sel_wr;
  wire i_data_V_dest_V_0_sel_wr_i_1_n_0;
  wire \i_data_V_dest_V_0_state[0]_i_1_n_0 ;
  wire \i_data_V_dest_V_0_state[1]_i_2_n_0 ;
  wire \i_data_V_dest_V_0_state_reg_n_0_[0] ;
  wire i_data_V_id_V_0_ack_in;
  wire i_data_V_id_V_0_data_out;
  wire i_data_V_id_V_0_payload_A;
  wire \i_data_V_id_V_0_payload_A[0]_i_1_n_0 ;
  wire i_data_V_id_V_0_payload_B;
  wire \i_data_V_id_V_0_payload_B[0]_i_1_n_0 ;
  wire i_data_V_id_V_0_sel;
  wire i_data_V_id_V_0_sel_rd_i_1_n_0;
  wire i_data_V_id_V_0_sel_wr;
  wire i_data_V_id_V_0_sel_wr_i_1_n_0;
  wire \i_data_V_id_V_0_state[0]_i_1_n_0 ;
  wire \i_data_V_id_V_0_state[1]_i_1_n_0 ;
  wire \i_data_V_id_V_0_state_reg_n_0_[0] ;
  wire i_data_V_keep_V_0_ack_in;
  wire [3:0]i_data_V_keep_V_0_data_out;
  wire i_data_V_keep_V_0_load_B;
  wire [3:0]i_data_V_keep_V_0_payload_A;
  wire \i_data_V_keep_V_0_payload_A[3]_i_1_n_0 ;
  wire [3:0]i_data_V_keep_V_0_payload_B;
  wire i_data_V_keep_V_0_sel;
  wire i_data_V_keep_V_0_sel_rd_i_1_n_0;
  wire i_data_V_keep_V_0_sel_wr;
  wire i_data_V_keep_V_0_sel_wr_i_1_n_0;
  wire \i_data_V_keep_V_0_state[0]_i_1_n_0 ;
  wire \i_data_V_keep_V_0_state[1]_i_1_n_0 ;
  wire \i_data_V_keep_V_0_state_reg_n_0_[0] ;
  wire i_data_V_last_V_0_ack_in;
  wire i_data_V_last_V_0_data_out;
  wire i_data_V_last_V_0_payload_A;
  wire \i_data_V_last_V_0_payload_A[0]_i_1_n_0 ;
  wire i_data_V_last_V_0_payload_B;
  wire \i_data_V_last_V_0_payload_B[0]_i_1_n_0 ;
  wire i_data_V_last_V_0_sel;
  wire i_data_V_last_V_0_sel_rd_i_1_n_0;
  wire i_data_V_last_V_0_sel_wr;
  wire i_data_V_last_V_0_sel_wr_i_1_n_0;
  wire \i_data_V_last_V_0_state[0]_i_1_n_0 ;
  wire \i_data_V_last_V_0_state[1]_i_1_n_0 ;
  wire \i_data_V_last_V_0_state_reg_n_0_[0] ;
  wire i_data_V_strb_V_0_ack_in;
  wire [3:0]i_data_V_strb_V_0_data_out;
  wire i_data_V_strb_V_0_load_B;
  wire [3:0]i_data_V_strb_V_0_payload_A;
  wire \i_data_V_strb_V_0_payload_A[3]_i_1_n_0 ;
  wire [3:0]i_data_V_strb_V_0_payload_B;
  wire i_data_V_strb_V_0_sel;
  wire i_data_V_strb_V_0_sel_rd_i_1_n_0;
  wire i_data_V_strb_V_0_sel_wr;
  wire i_data_V_strb_V_0_sel_wr_i_1_n_0;
  wire \i_data_V_strb_V_0_state[0]_i_1_n_0 ;
  wire \i_data_V_strb_V_0_state[1]_i_1_n_0 ;
  wire \i_data_V_strb_V_0_state_reg_n_0_[0] ;
  wire i_data_V_user_V_0_ack_in;
  wire i_data_V_user_V_0_load_B;
  wire [127:0]i_data_V_user_V_0_payload_A;
  wire \i_data_V_user_V_0_payload_A[127]_i_1_n_0 ;
  wire [127:0]i_data_V_user_V_0_payload_B;
  wire i_data_V_user_V_0_sel;
  wire i_data_V_user_V_0_sel_rd_i_1_n_0;
  wire i_data_V_user_V_0_sel_rd_reg_rep_n_0;
  wire i_data_V_user_V_0_sel_rd_rep_i_1_n_0;
  wire i_data_V_user_V_0_sel_wr;
  wire i_data_V_user_V_0_sel_wr_i_1_n_0;
  wire \i_data_V_user_V_0_state[0]_i_1_n_0 ;
  wire \i_data_V_user_V_0_state[1]_i_1_n_0 ;
  wire \i_data_V_user_V_0_state_reg_n_0_[0] ;
  wire in_a_pulse_2_reg_662;
  wire \in_a_pulse_2_reg_662[0]_i_1_n_0 ;
  wire \in_a_pulse_fu_86_reg_n_0_[0] ;
  wire in_a_pulse_load_reg_622;
  wire in_a_xfer_bundle_3_reg_657;
  wire \in_a_xfer_bundle_3_reg_657[0]_i_1_n_0 ;
  wire in_a_xfer_bundle_fu_90;
  wire \in_a_xfer_bundle_fu_90_reg_n_0_[0] ;
  wire in_a_xfer_bundle_loa_reg_627;
  wire num_samples_fu_110;
  wire \num_samples_fu_110_reg_n_0_[0] ;
  wire \num_samples_fu_110_reg_n_0_[10] ;
  wire \num_samples_fu_110_reg_n_0_[11] ;
  wire \num_samples_fu_110_reg_n_0_[12] ;
  wire \num_samples_fu_110_reg_n_0_[13] ;
  wire \num_samples_fu_110_reg_n_0_[14] ;
  wire \num_samples_fu_110_reg_n_0_[15] ;
  wire \num_samples_fu_110_reg_n_0_[16] ;
  wire \num_samples_fu_110_reg_n_0_[17] ;
  wire \num_samples_fu_110_reg_n_0_[18] ;
  wire \num_samples_fu_110_reg_n_0_[19] ;
  wire \num_samples_fu_110_reg_n_0_[1] ;
  wire \num_samples_fu_110_reg_n_0_[20] ;
  wire \num_samples_fu_110_reg_n_0_[21] ;
  wire \num_samples_fu_110_reg_n_0_[22] ;
  wire \num_samples_fu_110_reg_n_0_[23] ;
  wire \num_samples_fu_110_reg_n_0_[24] ;
  wire \num_samples_fu_110_reg_n_0_[25] ;
  wire \num_samples_fu_110_reg_n_0_[26] ;
  wire \num_samples_fu_110_reg_n_0_[27] ;
  wire \num_samples_fu_110_reg_n_0_[28] ;
  wire \num_samples_fu_110_reg_n_0_[29] ;
  wire \num_samples_fu_110_reg_n_0_[2] ;
  wire \num_samples_fu_110_reg_n_0_[30] ;
  wire \num_samples_fu_110_reg_n_0_[31] ;
  wire \num_samples_fu_110_reg_n_0_[3] ;
  wire \num_samples_fu_110_reg_n_0_[4] ;
  wire \num_samples_fu_110_reg_n_0_[5] ;
  wire \num_samples_fu_110_reg_n_0_[6] ;
  wire \num_samples_fu_110_reg_n_0_[7] ;
  wire \num_samples_fu_110_reg_n_0_[8] ;
  wire \num_samples_fu_110_reg_n_0_[9] ;
  wire [31:0]num_samples_load_reg_652;
  wire [31:0]o_data_TDATA;
  wire [0:0]o_data_TDEST;
  wire [0:0]o_data_TID;
  wire [3:0]o_data_TKEEP;
  wire [0:0]o_data_TLAST;
  wire o_data_TREADY;
  wire o_data_TREADY43_in;
  wire [3:0]o_data_TSTRB;
  wire [127:0]o_data_TUSER;
  wire o_data_TVALID;
  wire o_data_V_data_V_1_ack_in;
  wire [31:0]o_data_V_data_V_1_data_in;
  wire o_data_V_data_V_1_data_in1;
  wire o_data_V_data_V_1_load_B;
  wire [31:0]o_data_V_data_V_1_payload_A;
  wire \o_data_V_data_V_1_payload_A[31]_i_1_n_0 ;
  wire [31:0]o_data_V_data_V_1_payload_B;
  wire o_data_V_data_V_1_sel;
  wire o_data_V_data_V_1_sel_rd_i_1_n_0;
  wire o_data_V_data_V_1_sel_wr;
  wire \o_data_V_data_V_1_state_reg_n_0_[0] ;
  wire o_data_V_data_V_1_vld_in1;
  wire o_data_V_dest_V_1_payload_A;
  wire \o_data_V_dest_V_1_payload_A[0]_i_1_n_0 ;
  wire \o_data_V_dest_V_1_payload_A[0]_i_2_n_0 ;
  wire o_data_V_dest_V_1_payload_B;
  wire \o_data_V_dest_V_1_payload_B[0]_i_1_n_0 ;
  wire o_data_V_dest_V_1_sel;
  wire o_data_V_dest_V_1_sel_rd_i_1_n_0;
  wire o_data_V_dest_V_1_sel_wr;
  wire o_data_V_id_V_1_ack_in;
  wire o_data_V_id_V_1_payload_A;
  wire \o_data_V_id_V_1_payload_A[0]_i_1_n_0 ;
  wire \o_data_V_id_V_1_payload_A[0]_i_2_n_0 ;
  wire o_data_V_id_V_1_payload_B;
  wire \o_data_V_id_V_1_payload_B[0]_i_1_n_0 ;
  wire o_data_V_id_V_1_sel;
  wire o_data_V_id_V_1_sel_rd_i_1_n_0;
  wire o_data_V_id_V_1_sel_wr;
  wire \o_data_V_id_V_1_state_reg_n_0_[0] ;
  wire o_data_V_keep_V_1_ack_in;
  wire [3:0]o_data_V_keep_V_1_data_in;
  wire o_data_V_keep_V_1_load_B;
  wire [3:0]o_data_V_keep_V_1_payload_A;
  wire \o_data_V_keep_V_1_payload_A[3]_i_1_n_0 ;
  wire [3:0]o_data_V_keep_V_1_payload_B;
  wire o_data_V_keep_V_1_sel;
  wire o_data_V_keep_V_1_sel_rd_i_1_n_0;
  wire o_data_V_keep_V_1_sel_wr;
  wire \o_data_V_keep_V_1_state_reg_n_0_[0] ;
  wire o_data_V_last_V_1_ack_in;
  wire o_data_V_last_V_1_payload_A;
  wire \o_data_V_last_V_1_payload_A[0]_i_1_n_0 ;
  wire \o_data_V_last_V_1_payload_A[0]_i_2_n_0 ;
  wire o_data_V_last_V_1_payload_B;
  wire \o_data_V_last_V_1_payload_B[0]_i_1_n_0 ;
  wire o_data_V_last_V_1_sel;
  wire o_data_V_last_V_1_sel_rd_i_1_n_0;
  wire o_data_V_last_V_1_sel_wr;
  wire \o_data_V_last_V_1_state_reg_n_0_[0] ;
  wire o_data_V_strb_V_1_ack_in;
  wire [3:0]o_data_V_strb_V_1_data_in;
  wire o_data_V_strb_V_1_load_B;
  wire [3:0]o_data_V_strb_V_1_payload_A;
  wire \o_data_V_strb_V_1_payload_A[3]_i_1_n_0 ;
  wire [3:0]o_data_V_strb_V_1_payload_B;
  wire o_data_V_strb_V_1_sel;
  wire o_data_V_strb_V_1_sel_rd_i_1_n_0;
  wire o_data_V_strb_V_1_sel_wr;
  wire \o_data_V_strb_V_1_state_reg_n_0_[0] ;
  wire o_data_V_user_V_1_ack_in;
  wire [127:0]o_data_V_user_V_1_data_in;
  wire o_data_V_user_V_1_load_B;
  wire [127:0]o_data_V_user_V_1_payload_A;
  wire \o_data_V_user_V_1_payload_A[127]_i_1_n_0 ;
  wire [127:0]o_data_V_user_V_1_payload_B;
  wire o_data_V_user_V_1_sel;
  wire o_data_V_user_V_1_sel_rd_i_1_n_0;
  wire o_data_V_user_V_1_sel_wr;
  wire \o_data_V_user_V_1_state_reg_n_0_[0] ;
  wire [7:0]p_1_in;
  wire p_222_in;
  wire [31:0]pos_enc_0;
  wire \pos_enc_0_read_reg_681_reg_n_0_[0] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[10] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[11] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[12] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[13] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[14] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[15] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[16] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[17] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[18] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[19] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[1] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[20] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[21] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[22] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[23] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[24] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[25] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[26] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[27] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[28] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[29] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[2] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[30] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[31] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[3] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[4] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[5] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[6] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[7] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[8] ;
  wire \pos_enc_0_read_reg_681_reg_n_0_[9] ;
  wire [31:0]pos_enc_1;
  wire \pos_enc_1_read_reg_686_reg_n_0_[0] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[10] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[11] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[12] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[13] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[14] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[15] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[16] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[17] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[18] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[19] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[1] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[20] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[21] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[22] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[23] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[24] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[25] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[26] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[27] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[28] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[29] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[2] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[30] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[31] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[3] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[4] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[5] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[6] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[7] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[8] ;
  wire \pos_enc_1_read_reg_686_reg_n_0_[9] ;
  wire pulse_metadata_V_0_load_B;
  wire [820:0]pulse_metadata_V_0_payload_A;
  wire \pulse_metadata_V_0_payload_A[820]_i_1_n_0 ;
  wire [820:0]pulse_metadata_V_0_payload_B;
  wire pulse_metadata_V_0_sel;
  wire pulse_metadata_V_0_sel_wr;
  wire pulse_metadata_V_0_sel_wr_i_1_n_0;
  wire \pulse_metadata_V_0_state_reg_n_0_[0] ;
  wire [823:0]pulse_metadata_V_TDATA;
  wire pulse_metadata_V_TREADY;
  wire pulse_metadata_V_TVALID;
  wire [31:1]sample_counter_1_fu_430_p2;
  wire [31:0]sample_counter_fu_94;
  wire \sample_counter_fu_94[16]_i_10_n_0 ;
  wire \sample_counter_fu_94[16]_i_3_n_0 ;
  wire \sample_counter_fu_94[16]_i_4_n_0 ;
  wire \sample_counter_fu_94[16]_i_5_n_0 ;
  wire \sample_counter_fu_94[16]_i_6_n_0 ;
  wire \sample_counter_fu_94[16]_i_7_n_0 ;
  wire \sample_counter_fu_94[16]_i_8_n_0 ;
  wire \sample_counter_fu_94[16]_i_9_n_0 ;
  wire \sample_counter_fu_94[24]_i_10_n_0 ;
  wire \sample_counter_fu_94[24]_i_3_n_0 ;
  wire \sample_counter_fu_94[24]_i_4_n_0 ;
  wire \sample_counter_fu_94[24]_i_5_n_0 ;
  wire \sample_counter_fu_94[24]_i_6_n_0 ;
  wire \sample_counter_fu_94[24]_i_7_n_0 ;
  wire \sample_counter_fu_94[24]_i_8_n_0 ;
  wire \sample_counter_fu_94[24]_i_9_n_0 ;
  wire \sample_counter_fu_94[31]_i_10_n_0 ;
  wire \sample_counter_fu_94[31]_i_11_n_0 ;
  wire \sample_counter_fu_94[31]_i_5_n_0 ;
  wire \sample_counter_fu_94[31]_i_6_n_0 ;
  wire \sample_counter_fu_94[31]_i_7_n_0 ;
  wire \sample_counter_fu_94[31]_i_8_n_0 ;
  wire \sample_counter_fu_94[31]_i_9_n_0 ;
  wire \sample_counter_fu_94[8]_i_10_n_0 ;
  wire \sample_counter_fu_94[8]_i_3_n_0 ;
  wire \sample_counter_fu_94[8]_i_4_n_0 ;
  wire \sample_counter_fu_94[8]_i_5_n_0 ;
  wire \sample_counter_fu_94[8]_i_6_n_0 ;
  wire \sample_counter_fu_94[8]_i_7_n_0 ;
  wire \sample_counter_fu_94[8]_i_8_n_0 ;
  wire \sample_counter_fu_94[8]_i_9_n_0 ;
  wire \sample_counter_fu_94_reg[16]_i_2_n_0 ;
  wire \sample_counter_fu_94_reg[16]_i_2_n_1 ;
  wire \sample_counter_fu_94_reg[16]_i_2_n_2 ;
  wire \sample_counter_fu_94_reg[16]_i_2_n_3 ;
  wire \sample_counter_fu_94_reg[16]_i_2_n_5 ;
  wire \sample_counter_fu_94_reg[16]_i_2_n_6 ;
  wire \sample_counter_fu_94_reg[16]_i_2_n_7 ;
  wire \sample_counter_fu_94_reg[24]_i_2_n_0 ;
  wire \sample_counter_fu_94_reg[24]_i_2_n_1 ;
  wire \sample_counter_fu_94_reg[24]_i_2_n_2 ;
  wire \sample_counter_fu_94_reg[24]_i_2_n_3 ;
  wire \sample_counter_fu_94_reg[24]_i_2_n_5 ;
  wire \sample_counter_fu_94_reg[24]_i_2_n_6 ;
  wire \sample_counter_fu_94_reg[24]_i_2_n_7 ;
  wire \sample_counter_fu_94_reg[31]_i_4_n_2 ;
  wire \sample_counter_fu_94_reg[31]_i_4_n_3 ;
  wire \sample_counter_fu_94_reg[31]_i_4_n_5 ;
  wire \sample_counter_fu_94_reg[31]_i_4_n_6 ;
  wire \sample_counter_fu_94_reg[31]_i_4_n_7 ;
  wire \sample_counter_fu_94_reg[8]_i_2_n_0 ;
  wire \sample_counter_fu_94_reg[8]_i_2_n_1 ;
  wire \sample_counter_fu_94_reg[8]_i_2_n_2 ;
  wire \sample_counter_fu_94_reg[8]_i_2_n_3 ;
  wire \sample_counter_fu_94_reg[8]_i_2_n_5 ;
  wire \sample_counter_fu_94_reg[8]_i_2_n_6 ;
  wire \sample_counter_fu_94_reg[8]_i_2_n_7 ;
  wire [31:0]sample_counter_load_1_reg_632;
  wire tmp_1_fu_327_p2;
  wire tmp_2_fu_295_p3;
  wire \tmp_2_reg_618_reg_n_0_[0] ;
  wire [31:0]tmp_data_V_reg_577;
  wire tmp_dest_V_reg_612;
  wire tmp_id_V_reg_606;
  wire [3:0]tmp_keep_V_reg_583;
  wire tmp_last_V_reg_600;
  wire [3:0]tmp_strb_V_reg_589;
  wire [127:0]tmp_user_V_1_reg_595;
  wire \tmp_user_V_1_reg_595[0]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[100]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[101]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[102]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[103]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[104]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[105]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[106]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[107]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[108]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[109]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[10]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[110]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[111]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[112]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[113]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[114]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[115]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[116]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[117]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[118]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[119]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[11]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[120]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[121]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[122]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[123]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[124]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[125]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[126]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[127]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[12]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[13]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[14]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[15]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[16]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[17]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[18]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[19]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[1]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[20]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[21]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[22]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[23]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[24]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[25]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[26]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[27]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[28]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[29]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[2]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[30]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[31]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[32]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[33]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[34]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[35]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[36]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[37]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[38]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[39]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[3]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[40]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[41]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[42]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[43]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[44]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[45]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[46]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[47]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[48]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[49]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[4]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[50]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[51]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[52]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[53]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[54]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[55]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[56]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[57]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[58]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[59]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[5]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[60]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[61]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[62]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[63]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[65]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[66]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[67]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[68]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[69]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[6]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[70]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[71]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[73]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[74]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[75]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[76]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[77]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[78]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[79]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[7]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[80]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[81]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[82]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[83]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[84]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[85]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[86]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[87]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[88]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[89]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[8]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[90]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[91]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[92]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[93]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[94]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[95]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[96]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[97]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[98]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[99]_i_1_n_0 ;
  wire \tmp_user_V_1_reg_595[9]_i_1_n_0 ;
  wire [7:3]\NLW_brmerge_reg_672_reg[0]_i_3_CO_UNCONNECTED ;
  wire [7:3]\NLW_brmerge_reg_672_reg[0]_i_3_DI_UNCONNECTED ;
  wire [7:0]\NLW_brmerge_reg_672_reg[0]_i_3_O_UNCONNECTED ;
  wire [7:3]\NLW_brmerge_reg_672_reg[0]_i_3_S_UNCONNECTED ;
  wire [3:3]\NLW_brmerge_reg_672_reg[0]_i_4_CO_UNCONNECTED ;
  wire [7:0]\NLW_brmerge_reg_672_reg[0]_i_4_O_UNCONNECTED ;
  wire [3:3]\NLW_sample_counter_fu_94_reg[16]_i_2_CO_UNCONNECTED ;
  wire [3:3]\NLW_sample_counter_fu_94_reg[24]_i_2_CO_UNCONNECTED ;
  wire [7:3]\NLW_sample_counter_fu_94_reg[31]_i_4_CO_UNCONNECTED ;
  wire [7:7]\NLW_sample_counter_fu_94_reg[31]_i_4_DI_UNCONNECTED ;
  wire [7:7]\NLW_sample_counter_fu_94_reg[31]_i_4_O_UNCONNECTED ;
  wire [7:7]\NLW_sample_counter_fu_94_reg[31]_i_4_S_UNCONNECTED ;
  wire [3:3]\NLW_sample_counter_fu_94_reg[8]_i_2_CO_UNCONNECTED ;

  assign ap_ready = ap_done;
  (* SOFT_HLUTNM = "soft_lutpair109" *) 
  LUT4 #(
    .INIT(16'hF222)) 
    \ap_CS_fsm[0]_i_1__0 
       (.I0(\ap_CS_fsm_reg_n_0_[0] ),
        .I1(ap_start),
        .I2(ap_done),
        .I3(ap_CS_fsm_state5),
        .O(ap_NS_fsm[0]));
  LUT6 #(
    .INIT(64'hFFFFFFFF0020AAAA)) 
    \ap_CS_fsm[2]_i_1__0 
       (.I0(ap_CS_fsm_state3),
        .I1(tmp_2_fu_295_p3),
        .I2(brmerge_fu_387_p2),
        .I3(o_data_V_data_V_1_ack_in),
        .I4(\i_data_V_data_V_0_state_reg_n_0_[0] ),
        .I5(\ap_CS_fsm_reg_n_0_[1] ),
        .O(ap_NS_fsm[2]));
  (* FSM_ENCODING = "none" *) 
  FDSE #(
    .INIT(1'b1)) 
    \ap_CS_fsm_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_NS_fsm[0]),
        .Q(\ap_CS_fsm_reg_n_0_[0] ),
        .S(ap_rst));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_NS_fsm[1]),
        .Q(\ap_CS_fsm_reg_n_0_[1] ),
        .R(ap_rst));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[2] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_NS_fsm[2]),
        .Q(ap_CS_fsm_state3),
        .R(ap_rst));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[3] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_NS_fsm[3]),
        .Q(ap_CS_fsm_state4),
        .R(ap_rst));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[4] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_NS_fsm[4]),
        .Q(ap_CS_fsm_state5),
        .R(ap_rst));
  LUT2 #(
    .INIT(4'h2)) 
    ap_idle_INST_0
       (.I0(\ap_CS_fsm_reg_n_0_[0] ),
        .I1(ap_start),
        .O(ap_idle));
  LUT5 #(
    .INIT(32'h00008000)) 
    ap_ready_INST_0
       (.I0(o_data_V_strb_V_1_ack_in),
        .I1(o_data_V_user_V_1_ack_in),
        .I2(o_data_V_data_V_1_ack_in),
        .I3(o_data_V_keep_V_1_ack_in),
        .I4(ap_ready_INST_0_i_1_n_0),
        .O(ap_done));
  (* SOFT_HLUTNM = "soft_lutpair110" *) 
  LUT4 #(
    .INIT(16'h7FFF)) 
    ap_ready_INST_0_i_1
       (.I0(o_data_V_id_V_1_ack_in),
        .I1(o_data_V_last_V_1_ack_in),
        .I2(ap_CS_fsm_state5),
        .I3(o_data_TREADY43_in),
        .O(ap_ready_INST_0_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    ap_reg_grp_handle_header_fu_175_ap_start_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_109),
        .Q(ap_reg_grp_handle_header_fu_175_ap_start_reg_n_0),
        .R(ap_rst));
  FDRE \break_after_pulse_fu_106_reg[0] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_3),
        .Q(\break_after_pulse_fu_106_reg_n_0_[0] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \break_after_pulse_lo_reg_647_reg[0] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\break_after_pulse_fu_106_reg_n_0_[0] ),
        .Q(break_after_pulse_lo_reg_647),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h028A)) 
    \brmerge_reg_672[0]_i_1 
       (.I0(p_222_in),
        .I1(i_data_V_user_V_0_sel),
        .I2(i_data_V_user_V_0_payload_A[72]),
        .I3(i_data_V_user_V_0_payload_B[72]),
        .O(\brmerge_reg_672[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \brmerge_reg_672[0]_i_10 
       (.I0(sample_counter_fu_94[15]),
        .I1(\num_samples_fu_110_reg_n_0_[15] ),
        .I2(\num_samples_fu_110_reg_n_0_[17] ),
        .I3(sample_counter_fu_94[17]),
        .I4(\num_samples_fu_110_reg_n_0_[16] ),
        .I5(sample_counter_fu_94[16]),
        .O(\brmerge_reg_672[0]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \brmerge_reg_672[0]_i_11 
       (.I0(sample_counter_fu_94[12]),
        .I1(\num_samples_fu_110_reg_n_0_[12] ),
        .I2(\num_samples_fu_110_reg_n_0_[14] ),
        .I3(sample_counter_fu_94[14]),
        .I4(\num_samples_fu_110_reg_n_0_[13] ),
        .I5(sample_counter_fu_94[13]),
        .O(\brmerge_reg_672[0]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \brmerge_reg_672[0]_i_12 
       (.I0(sample_counter_fu_94[9]),
        .I1(\num_samples_fu_110_reg_n_0_[9] ),
        .I2(\num_samples_fu_110_reg_n_0_[11] ),
        .I3(sample_counter_fu_94[11]),
        .I4(\num_samples_fu_110_reg_n_0_[10] ),
        .I5(sample_counter_fu_94[10]),
        .O(\brmerge_reg_672[0]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \brmerge_reg_672[0]_i_13 
       (.I0(sample_counter_fu_94[6]),
        .I1(\num_samples_fu_110_reg_n_0_[6] ),
        .I2(\num_samples_fu_110_reg_n_0_[8] ),
        .I3(sample_counter_fu_94[8]),
        .I4(\num_samples_fu_110_reg_n_0_[7] ),
        .I5(sample_counter_fu_94[7]),
        .O(\brmerge_reg_672[0]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \brmerge_reg_672[0]_i_14 
       (.I0(sample_counter_fu_94[3]),
        .I1(\num_samples_fu_110_reg_n_0_[3] ),
        .I2(\num_samples_fu_110_reg_n_0_[5] ),
        .I3(sample_counter_fu_94[5]),
        .I4(\num_samples_fu_110_reg_n_0_[4] ),
        .I5(sample_counter_fu_94[4]),
        .O(\brmerge_reg_672[0]_i_14_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \brmerge_reg_672[0]_i_15 
       (.I0(sample_counter_fu_94[0]),
        .I1(\num_samples_fu_110_reg_n_0_[0] ),
        .I2(\num_samples_fu_110_reg_n_0_[2] ),
        .I3(sample_counter_fu_94[2]),
        .I4(\num_samples_fu_110_reg_n_0_[1] ),
        .I5(sample_counter_fu_94[1]),
        .O(\brmerge_reg_672[0]_i_15_n_0 ));
  LUT5 #(
    .INIT(32'hFDF55D55)) 
    \brmerge_reg_672[0]_i_2 
       (.I0(\in_a_xfer_bundle_fu_90_reg_n_0_[0] ),
        .I1(dec_keep_fu_363_p2),
        .I2(tmp_1_fu_327_p2),
        .I3(\in_a_pulse_fu_86_reg_n_0_[0] ),
        .I4(\break_after_pulse_fu_106_reg_n_0_[0] ),
        .O(brmerge_fu_387_p2));
  LUT4 #(
    .INIT(16'h9009)) 
    \brmerge_reg_672[0]_i_5 
       (.I0(sample_counter_fu_94[30]),
        .I1(\num_samples_fu_110_reg_n_0_[30] ),
        .I2(sample_counter_fu_94[31]),
        .I3(\num_samples_fu_110_reg_n_0_[31] ),
        .O(\brmerge_reg_672[0]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \brmerge_reg_672[0]_i_6 
       (.I0(sample_counter_fu_94[27]),
        .I1(\num_samples_fu_110_reg_n_0_[27] ),
        .I2(\num_samples_fu_110_reg_n_0_[29] ),
        .I3(sample_counter_fu_94[29]),
        .I4(\num_samples_fu_110_reg_n_0_[28] ),
        .I5(sample_counter_fu_94[28]),
        .O(\brmerge_reg_672[0]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \brmerge_reg_672[0]_i_7 
       (.I0(sample_counter_fu_94[24]),
        .I1(\num_samples_fu_110_reg_n_0_[24] ),
        .I2(\num_samples_fu_110_reg_n_0_[26] ),
        .I3(sample_counter_fu_94[26]),
        .I4(\num_samples_fu_110_reg_n_0_[25] ),
        .I5(sample_counter_fu_94[25]),
        .O(\brmerge_reg_672[0]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \brmerge_reg_672[0]_i_8 
       (.I0(sample_counter_fu_94[21]),
        .I1(\num_samples_fu_110_reg_n_0_[21] ),
        .I2(\num_samples_fu_110_reg_n_0_[23] ),
        .I3(sample_counter_fu_94[23]),
        .I4(\num_samples_fu_110_reg_n_0_[22] ),
        .I5(sample_counter_fu_94[22]),
        .O(\brmerge_reg_672[0]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \brmerge_reg_672[0]_i_9 
       (.I0(sample_counter_fu_94[18]),
        .I1(\num_samples_fu_110_reg_n_0_[18] ),
        .I2(\num_samples_fu_110_reg_n_0_[20] ),
        .I3(sample_counter_fu_94[20]),
        .I4(\num_samples_fu_110_reg_n_0_[19] ),
        .I5(sample_counter_fu_94[19]),
        .O(\brmerge_reg_672[0]_i_9_n_0 ));
  FDRE \brmerge_reg_672_reg[0] 
       (.C(ap_clk),
        .CE(\brmerge_reg_672[0]_i_1_n_0 ),
        .D(brmerge_fu_387_p2),
        .Q(brmerge_reg_672),
        .R(1'b0));
  CARRY8 \brmerge_reg_672_reg[0]_i_3 
       (.CI(\brmerge_reg_672_reg[0]_i_4_n_0 ),
        .CI_TOP(1'b0),
        .CO({\NLW_brmerge_reg_672_reg[0]_i_3_CO_UNCONNECTED [7:3],tmp_1_fu_327_p2,\brmerge_reg_672_reg[0]_i_3_n_6 ,\brmerge_reg_672_reg[0]_i_3_n_7 }),
        .DI({\NLW_brmerge_reg_672_reg[0]_i_3_DI_UNCONNECTED [7:3],1'b0,1'b0,1'b0}),
        .O(\NLW_brmerge_reg_672_reg[0]_i_3_O_UNCONNECTED [7:0]),
        .S({\NLW_brmerge_reg_672_reg[0]_i_3_S_UNCONNECTED [7:3],\brmerge_reg_672[0]_i_5_n_0 ,\brmerge_reg_672[0]_i_6_n_0 ,\brmerge_reg_672[0]_i_7_n_0 }));
  CARRY8 \brmerge_reg_672_reg[0]_i_4 
       (.CI(1'b1),
        .CI_TOP(1'b0),
        .CO({\brmerge_reg_672_reg[0]_i_4_n_0 ,\brmerge_reg_672_reg[0]_i_4_n_1 ,\brmerge_reg_672_reg[0]_i_4_n_2 ,\brmerge_reg_672_reg[0]_i_4_n_3 ,\NLW_brmerge_reg_672_reg[0]_i_4_CO_UNCONNECTED [3],\brmerge_reg_672_reg[0]_i_4_n_5 ,\brmerge_reg_672_reg[0]_i_4_n_6 ,\brmerge_reg_672_reg[0]_i_4_n_7 }),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_brmerge_reg_672_reg[0]_i_4_O_UNCONNECTED [7:0]),
        .S({\brmerge_reg_672[0]_i_8_n_0 ,\brmerge_reg_672[0]_i_9_n_0 ,\brmerge_reg_672[0]_i_10_n_0 ,\brmerge_reg_672[0]_i_11_n_0 ,\brmerge_reg_672[0]_i_12_n_0 ,\brmerge_reg_672[0]_i_13_n_0 ,\brmerge_reg_672[0]_i_14_n_0 ,\brmerge_reg_672[0]_i_15_n_0 }));
  LUT6 #(
    .INIT(64'h9009000000000000)) 
    \dec_keep_reg_667[0]_i_1 
       (.I0(decimation_value_fu_102[7]),
        .I1(decimation_counter_fu_98[7]),
        .I2(decimation_value_fu_102[6]),
        .I3(decimation_counter_fu_98[6]),
        .I4(\dec_keep_reg_667[0]_i_2_n_0 ),
        .I5(\dec_keep_reg_667[0]_i_3_n_0 ),
        .O(dec_keep_fu_363_p2));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \dec_keep_reg_667[0]_i_2 
       (.I0(decimation_counter_fu_98[3]),
        .I1(decimation_value_fu_102[3]),
        .I2(decimation_value_fu_102[5]),
        .I3(decimation_counter_fu_98[5]),
        .I4(decimation_value_fu_102[4]),
        .I5(decimation_counter_fu_98[4]),
        .O(\dec_keep_reg_667[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \dec_keep_reg_667[0]_i_3 
       (.I0(decimation_counter_fu_98[0]),
        .I1(decimation_value_fu_102[0]),
        .I2(decimation_value_fu_102[2]),
        .I3(decimation_counter_fu_98[2]),
        .I4(decimation_value_fu_102[1]),
        .I5(decimation_counter_fu_98[1]),
        .O(\dec_keep_reg_667[0]_i_3_n_0 ));
  FDRE \dec_keep_reg_667_reg[0] 
       (.C(ap_clk),
        .CE(\brmerge_reg_672[0]_i_1_n_0 ),
        .D(dec_keep_fu_363_p2),
        .Q(dec_keep_reg_667),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hAAAAABAA)) 
    \decimation_counter_fu_98[0]_i_2 
       (.I0(o_data_V_data_V_1_vld_in1),
        .I1(decimation_counter_fu_98[0]),
        .I2(tmp_2_fu_295_p3),
        .I3(p_222_in),
        .I4(brmerge_fu_387_p2),
        .O(\decimation_counter_fu_98[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000600)) 
    \decimation_counter_fu_98[1]_i_2 
       (.I0(decimation_counter_fu_98[0]),
        .I1(decimation_counter_fu_98[1]),
        .I2(tmp_2_fu_295_p3),
        .I3(p_222_in),
        .I4(brmerge_fu_387_p2),
        .I5(o_data_V_data_V_1_vld_in1),
        .O(\decimation_counter_fu_98[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000600)) 
    \decimation_counter_fu_98[2]_i_2 
       (.I0(\decimation_counter_fu_98[2]_i_4_n_0 ),
        .I1(decimation_counter_fu_98[2]),
        .I2(tmp_2_fu_295_p3),
        .I3(p_222_in),
        .I4(brmerge_fu_387_p2),
        .I5(o_data_V_data_V_1_vld_in1),
        .O(\decimation_counter_fu_98[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair112" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \decimation_counter_fu_98[2]_i_4 
       (.I0(decimation_counter_fu_98[1]),
        .I1(decimation_counter_fu_98[0]),
        .O(\decimation_counter_fu_98[2]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000600)) 
    \decimation_counter_fu_98[3]_i_2 
       (.I0(\decimation_counter_fu_98[3]_i_4_n_0 ),
        .I1(decimation_counter_fu_98[3]),
        .I2(tmp_2_fu_295_p3),
        .I3(p_222_in),
        .I4(brmerge_fu_387_p2),
        .I5(o_data_V_data_V_1_vld_in1),
        .O(\decimation_counter_fu_98[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair112" *) 
  LUT3 #(
    .INIT(8'h80)) 
    \decimation_counter_fu_98[3]_i_4 
       (.I0(decimation_counter_fu_98[2]),
        .I1(decimation_counter_fu_98[0]),
        .I2(decimation_counter_fu_98[1]),
        .O(\decimation_counter_fu_98[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000600)) 
    \decimation_counter_fu_98[4]_i_2 
       (.I0(\decimation_counter_fu_98[4]_i_4_n_0 ),
        .I1(decimation_counter_fu_98[4]),
        .I2(tmp_2_fu_295_p3),
        .I3(p_222_in),
        .I4(brmerge_fu_387_p2),
        .I5(o_data_V_data_V_1_vld_in1),
        .O(\decimation_counter_fu_98[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair108" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \decimation_counter_fu_98[4]_i_4 
       (.I0(decimation_counter_fu_98[3]),
        .I1(decimation_counter_fu_98[1]),
        .I2(decimation_counter_fu_98[0]),
        .I3(decimation_counter_fu_98[2]),
        .O(\decimation_counter_fu_98[4]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000600)) 
    \decimation_counter_fu_98[5]_i_2 
       (.I0(\decimation_counter_fu_98[5]_i_4_n_0 ),
        .I1(decimation_counter_fu_98[5]),
        .I2(tmp_2_fu_295_p3),
        .I3(p_222_in),
        .I4(brmerge_fu_387_p2),
        .I5(o_data_V_data_V_1_vld_in1),
        .O(\decimation_counter_fu_98[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair108" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \decimation_counter_fu_98[5]_i_4 
       (.I0(decimation_counter_fu_98[4]),
        .I1(decimation_counter_fu_98[2]),
        .I2(decimation_counter_fu_98[0]),
        .I3(decimation_counter_fu_98[1]),
        .I4(decimation_counter_fu_98[3]),
        .O(\decimation_counter_fu_98[5]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000600)) 
    \decimation_counter_fu_98[6]_i_2 
       (.I0(\decimation_counter_fu_98[6]_i_4_n_0 ),
        .I1(decimation_counter_fu_98[6]),
        .I2(tmp_2_fu_295_p3),
        .I3(p_222_in),
        .I4(brmerge_fu_387_p2),
        .I5(o_data_V_data_V_1_vld_in1),
        .O(\decimation_counter_fu_98[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \decimation_counter_fu_98[6]_i_4 
       (.I0(decimation_counter_fu_98[5]),
        .I1(decimation_counter_fu_98[3]),
        .I2(decimation_counter_fu_98[1]),
        .I3(decimation_counter_fu_98[0]),
        .I4(decimation_counter_fu_98[2]),
        .I5(decimation_counter_fu_98[4]),
        .O(\decimation_counter_fu_98[6]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00800000)) 
    \decimation_counter_fu_98[7]_i_3 
       (.I0(o_data_V_data_V_1_ack_in),
        .I1(\i_data_V_data_V_0_state_reg_n_0_[0] ),
        .I2(brmerge_fu_387_p2),
        .I3(tmp_2_fu_295_p3),
        .I4(ap_CS_fsm_state3),
        .O(o_data_V_data_V_1_vld_in1));
  LUT5 #(
    .INIT(32'h00000020)) 
    \decimation_counter_fu_98[7]_i_4 
       (.I0(decimation_counter_1_fu_393_p2),
        .I1(tmp_2_fu_295_p3),
        .I2(p_222_in),
        .I3(brmerge_fu_387_p2),
        .I4(o_data_V_data_V_1_vld_in1),
        .O(\decimation_counter_fu_98[7]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'h78)) 
    \decimation_counter_fu_98[7]_i_6 
       (.I0(\decimation_counter_fu_98[6]_i_4_n_0 ),
        .I1(decimation_counter_fu_98[6]),
        .I2(decimation_counter_fu_98[7]),
        .O(decimation_counter_1_fu_393_p2));
  FDRE \decimation_counter_fu_98_reg[0] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_82),
        .D(p_1_in[0]),
        .Q(decimation_counter_fu_98[0]),
        .R(1'b0));
  FDRE \decimation_counter_fu_98_reg[1] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_82),
        .D(p_1_in[1]),
        .Q(decimation_counter_fu_98[1]),
        .R(1'b0));
  FDRE \decimation_counter_fu_98_reg[2] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_82),
        .D(p_1_in[2]),
        .Q(decimation_counter_fu_98[2]),
        .R(1'b0));
  FDRE \decimation_counter_fu_98_reg[3] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_82),
        .D(p_1_in[3]),
        .Q(decimation_counter_fu_98[3]),
        .R(1'b0));
  FDRE \decimation_counter_fu_98_reg[4] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_82),
        .D(p_1_in[4]),
        .Q(decimation_counter_fu_98[4]),
        .R(1'b0));
  FDRE \decimation_counter_fu_98_reg[5] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_82),
        .D(p_1_in[5]),
        .Q(decimation_counter_fu_98[5]),
        .R(1'b0));
  FDRE \decimation_counter_fu_98_reg[6] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_82),
        .D(p_1_in[6]),
        .Q(decimation_counter_fu_98[6]),
        .R(1'b0));
  FDRE \decimation_counter_fu_98_reg[7] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_82),
        .D(p_1_in[7]),
        .Q(decimation_counter_fu_98[7]),
        .R(1'b0));
  FDRE \decimation_counter_l_reg_637_reg[0] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(decimation_counter_fu_98[0]),
        .Q(decimation_counter_l_reg_637[0]),
        .R(1'b0));
  FDRE \decimation_counter_l_reg_637_reg[1] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(decimation_counter_fu_98[1]),
        .Q(decimation_counter_l_reg_637[1]),
        .R(1'b0));
  FDRE \decimation_counter_l_reg_637_reg[2] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(decimation_counter_fu_98[2]),
        .Q(decimation_counter_l_reg_637[2]),
        .R(1'b0));
  FDRE \decimation_counter_l_reg_637_reg[3] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(decimation_counter_fu_98[3]),
        .Q(decimation_counter_l_reg_637[3]),
        .R(1'b0));
  FDRE \decimation_counter_l_reg_637_reg[4] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(decimation_counter_fu_98[4]),
        .Q(decimation_counter_l_reg_637[4]),
        .R(1'b0));
  FDRE \decimation_counter_l_reg_637_reg[5] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(decimation_counter_fu_98[5]),
        .Q(decimation_counter_l_reg_637[5]),
        .R(1'b0));
  FDRE \decimation_counter_l_reg_637_reg[6] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(decimation_counter_fu_98[6]),
        .Q(decimation_counter_l_reg_637[6]),
        .R(1'b0));
  FDRE \decimation_counter_l_reg_637_reg[7] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(decimation_counter_fu_98[7]),
        .Q(decimation_counter_l_reg_637[7]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair109" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \decimation_value_fu_102[0]_i_2 
       (.I0(\ap_CS_fsm_reg_n_0_[0] ),
        .I1(ap_start),
        .O(ap_NS_fsm1115_out));
  FDRE \decimation_value_fu_102_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_1),
        .Q(decimation_value_fu_102[0]),
        .R(1'b0));
  FDRE \decimation_value_fu_102_reg[1] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_4[1]),
        .Q(decimation_value_fu_102[1]),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \decimation_value_fu_102_reg[2] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_4[2]),
        .Q(decimation_value_fu_102[2]),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \decimation_value_fu_102_reg[3] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_4[3]),
        .Q(decimation_value_fu_102[3]),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \decimation_value_fu_102_reg[4] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_4[4]),
        .Q(decimation_value_fu_102[4]),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \decimation_value_fu_102_reg[5] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_4[5]),
        .Q(decimation_value_fu_102[5]),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \decimation_value_fu_102_reg[6] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_4[6]),
        .Q(decimation_value_fu_102[6]),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \decimation_value_fu_102_reg[7] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_4[7]),
        .Q(decimation_value_fu_102[7]),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \decimation_value_loa_reg_642_reg[0] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(decimation_value_fu_102[0]),
        .Q(decimation_value_loa_reg_642[0]),
        .R(1'b0));
  FDRE \decimation_value_loa_reg_642_reg[1] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(decimation_value_fu_102[1]),
        .Q(decimation_value_loa_reg_642[1]),
        .R(1'b0));
  FDRE \decimation_value_loa_reg_642_reg[2] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(decimation_value_fu_102[2]),
        .Q(decimation_value_loa_reg_642[2]),
        .R(1'b0));
  FDRE \decimation_value_loa_reg_642_reg[3] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(decimation_value_fu_102[3]),
        .Q(decimation_value_loa_reg_642[3]),
        .R(1'b0));
  FDRE \decimation_value_loa_reg_642_reg[4] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(decimation_value_fu_102[4]),
        .Q(decimation_value_loa_reg_642[4]),
        .R(1'b0));
  FDRE \decimation_value_loa_reg_642_reg[5] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(decimation_value_fu_102[5]),
        .Q(decimation_value_loa_reg_642[5]),
        .R(1'b0));
  FDRE \decimation_value_loa_reg_642_reg[6] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(decimation_value_fu_102[6]),
        .Q(decimation_value_loa_reg_642[6]),
        .R(1'b0));
  FDRE \decimation_value_loa_reg_642_reg[7] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(decimation_value_fu_102[7]),
        .Q(decimation_value_loa_reg_642[7]),
        .R(1'b0));
  FDRE \flags_read_reg_691_reg[0] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(flags[0]),
        .Q(\flags_read_reg_691_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \flags_read_reg_691_reg[10] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(flags[10]),
        .Q(\flags_read_reg_691_reg_n_0_[10] ),
        .R(1'b0));
  FDRE \flags_read_reg_691_reg[11] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(flags[11]),
        .Q(\flags_read_reg_691_reg_n_0_[11] ),
        .R(1'b0));
  FDRE \flags_read_reg_691_reg[12] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(flags[12]),
        .Q(\flags_read_reg_691_reg_n_0_[12] ),
        .R(1'b0));
  FDRE \flags_read_reg_691_reg[13] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(flags[13]),
        .Q(\flags_read_reg_691_reg_n_0_[13] ),
        .R(1'b0));
  FDRE \flags_read_reg_691_reg[14] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(flags[14]),
        .Q(\flags_read_reg_691_reg_n_0_[14] ),
        .R(1'b0));
  FDRE \flags_read_reg_691_reg[15] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(flags[15]),
        .Q(\flags_read_reg_691_reg_n_0_[15] ),
        .R(1'b0));
  FDRE \flags_read_reg_691_reg[1] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(flags[1]),
        .Q(\flags_read_reg_691_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \flags_read_reg_691_reg[2] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(flags[2]),
        .Q(\flags_read_reg_691_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \flags_read_reg_691_reg[3] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(flags[3]),
        .Q(\flags_read_reg_691_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \flags_read_reg_691_reg[4] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(flags[4]),
        .Q(\flags_read_reg_691_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \flags_read_reg_691_reg[5] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(flags[5]),
        .Q(\flags_read_reg_691_reg_n_0_[5] ),
        .R(1'b0));
  FDRE \flags_read_reg_691_reg[6] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(flags[6]),
        .Q(\flags_read_reg_691_reg_n_0_[6] ),
        .R(1'b0));
  FDRE \flags_read_reg_691_reg[7] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(flags[7]),
        .Q(\flags_read_reg_691_reg_n_0_[7] ),
        .R(1'b0));
  FDRE \flags_read_reg_691_reg[8] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(flags[8]),
        .Q(\flags_read_reg_691_reg_n_0_[8] ),
        .R(1'b0));
  FDRE \flags_read_reg_691_reg[9] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(flags[9]),
        .Q(\flags_read_reg_691_reg_n_0_[9] ),
        .R(1'b0));
  user_block2_hcr_metadata_injector_0_0_handle_header grp_handle_header_fu_175
       (.CO(tmp_1_fu_327_p2),
        .D(decimation_value_fu_102[0]),
        .E(grp_handle_header_fu_175_n_75),
        .Q({i_data_V_data_V_0_payload_B[31:29],i_data_V_data_V_0_payload_B[27:26],i_data_V_data_V_0_payload_B[24:21],i_data_V_data_V_0_payload_B[19:18],i_data_V_data_V_0_payload_B[16:13],i_data_V_data_V_0_payload_B[11:10],i_data_V_data_V_0_payload_B[8:5],i_data_V_data_V_0_payload_B[3:2],i_data_V_data_V_0_payload_B[0]}),
        .\ap_CS_fsm_reg[4]_0 ({ap_NS_fsm[4:3],ap_NS_fsm[1]}),
        .\ap_CS_fsm_reg[4]_1 ({ap_CS_fsm_state5,ap_CS_fsm_state4,ap_CS_fsm_state3,\ap_CS_fsm_reg_n_0_[0] }),
        .ap_NS_fsm1115_out(ap_NS_fsm1115_out),
        .ap_clk(ap_clk),
        .ap_done(ap_done),
        .ap_reg_grp_handle_header_fu_175_ap_start_reg(grp_handle_header_fu_175_n_109),
        .ap_reg_grp_handle_header_fu_175_ap_start_reg_0(ap_reg_grp_handle_header_fu_175_ap_start_reg_n_0),
        .ap_return_3(ap_return_3),
        .ap_return_4(ap_return_4),
        .ap_return_6(ap_return_6),
        .ap_rst(ap_rst),
        .ap_rst_n(ap_rst_n),
        .ap_start(ap_start),
        .break_after_pulse_lo_reg_647(break_after_pulse_lo_reg_647),
        .brmerge_fu_387_p2(brmerge_fu_387_p2),
        .brmerge_reg_672(brmerge_reg_672),
        .dec_keep_reg_667(dec_keep_reg_667),
        .\decimation_counter_fu_98_reg[0] (grp_handle_header_fu_175_n_82),
        .\decimation_counter_fu_98_reg[0]_0 (\decimation_counter_fu_98[1]_i_2_n_0 ),
        .\decimation_counter_fu_98_reg[0]_1 (\decimation_counter_fu_98[0]_i_2_n_0 ),
        .\decimation_counter_fu_98_reg[2] (\decimation_counter_fu_98[2]_i_2_n_0 ),
        .\decimation_counter_fu_98_reg[3] (\decimation_counter_fu_98[3]_i_2_n_0 ),
        .\decimation_counter_fu_98_reg[4] (\decimation_counter_fu_98[4]_i_2_n_0 ),
        .\decimation_counter_fu_98_reg[5] (\decimation_counter_fu_98[5]_i_2_n_0 ),
        .\decimation_counter_fu_98_reg[6] (\decimation_counter_fu_98[7]_i_4_n_0 ),
        .\decimation_counter_fu_98_reg[6]_0 (\decimation_counter_fu_98[6]_i_2_n_0 ),
        .\decimation_counter_fu_98_reg[7] (p_1_in),
        .\decimation_counter_l_reg_637_reg[7] (decimation_counter_l_reg_637),
        .\decimation_value_fu_102_reg[0] (grp_handle_header_fu_175_n_1),
        .\decimation_value_fu_102_reg[7] (grp_handle_header_fu_175_n_106),
        .\decimation_value_loa_reg_642_reg[7] (decimation_value_loa_reg_642),
        .\flags_read_reg_691_reg[15] ({\flags_read_reg_691_reg_n_0_[15] ,\flags_read_reg_691_reg_n_0_[14] ,\flags_read_reg_691_reg_n_0_[13] ,\flags_read_reg_691_reg_n_0_[12] ,\flags_read_reg_691_reg_n_0_[11] ,\flags_read_reg_691_reg_n_0_[10] ,\flags_read_reg_691_reg_n_0_[9] ,\flags_read_reg_691_reg_n_0_[8] ,\flags_read_reg_691_reg_n_0_[7] ,\flags_read_reg_691_reg_n_0_[6] ,\flags_read_reg_691_reg_n_0_[5] ,\flags_read_reg_691_reg_n_0_[4] ,\flags_read_reg_691_reg_n_0_[3] ,\flags_read_reg_691_reg_n_0_[2] ,\flags_read_reg_691_reg_n_0_[1] ,\flags_read_reg_691_reg_n_0_[0] }),
        .\i_data_V_data_V_0_payload_A_reg[31] ({i_data_V_data_V_0_payload_A[31:29],i_data_V_data_V_0_payload_A[27:26],i_data_V_data_V_0_payload_A[24:21],i_data_V_data_V_0_payload_A[19:18],i_data_V_data_V_0_payload_A[16:13],i_data_V_data_V_0_payload_A[11:10],i_data_V_data_V_0_payload_A[8:5],i_data_V_data_V_0_payload_A[3:2],i_data_V_data_V_0_payload_A[0]}),
        .\i_data_V_data_V_0_payload_B_reg[28] ({i_data_V_data_V_0_data_out[28],i_data_V_data_V_0_data_out[25],i_data_V_data_V_0_data_out[20],i_data_V_data_V_0_data_out[17],i_data_V_data_V_0_data_out[12],i_data_V_data_V_0_data_out[9],i_data_V_data_V_0_data_out[4],i_data_V_data_V_0_data_out[1]}),
        .i_data_V_data_V_0_sel(i_data_V_data_V_0_sel),
        .\i_data_V_data_V_0_state_reg[0] (\i_data_V_data_V_0_state_reg_n_0_[0] ),
        .\i_data_V_user_V_0_payload_A_reg[72] (i_data_V_user_V_0_payload_A[72]),
        .\i_data_V_user_V_0_payload_B_reg[72] (i_data_V_user_V_0_payload_B[72]),
        .i_data_V_user_V_0_sel(i_data_V_user_V_0_sel),
        .in_a_pulse_2_reg_662(in_a_pulse_2_reg_662),
        .\in_a_pulse_fu_86_reg[0] (grp_handle_header_fu_175_n_77),
        .\in_a_pulse_fu_86_reg[0]_0 (\in_a_pulse_fu_86_reg_n_0_[0] ),
        .in_a_pulse_load_reg_622(in_a_pulse_load_reg_622),
        .in_a_xfer_bundle_3_reg_657(in_a_xfer_bundle_3_reg_657),
        .in_a_xfer_bundle_fu_90(in_a_xfer_bundle_fu_90),
        .\in_a_xfer_bundle_fu_90_reg[0] (grp_handle_header_fu_175_n_76),
        .in_a_xfer_bundle_loa_reg_627(in_a_xfer_bundle_loa_reg_627),
        .num_samples_fu_110(num_samples_fu_110),
        .\num_samples_load_reg_652_reg[31] (num_samples_load_reg_652),
        .o_data_TREADY(o_data_TREADY),
        .o_data_TREADY43_in(o_data_TREADY43_in),
        .o_data_V_data_V_1_ack_in(o_data_V_data_V_1_ack_in),
        .o_data_V_data_V_1_data_in1(o_data_V_data_V_1_data_in1),
        .\o_data_V_data_V_1_payload_B_reg[31] (o_data_V_data_V_1_data_in),
        .o_data_V_data_V_1_sel_wr(o_data_V_data_V_1_sel_wr),
        .o_data_V_data_V_1_sel_wr_reg(grp_handle_header_fu_175_n_105),
        .\o_data_V_data_V_1_state_reg[0] (grp_handle_header_fu_175_n_0),
        .\o_data_V_data_V_1_state_reg[0]_0 (\o_data_V_data_V_1_state_reg_n_0_[0] ),
        .\o_data_V_data_V_1_state_reg[1] (grp_handle_header_fu_175_n_92),
        .o_data_V_data_V_1_vld_in1(o_data_V_data_V_1_vld_in1),
        .o_data_V_dest_V_1_sel_wr(o_data_V_dest_V_1_sel_wr),
        .o_data_V_dest_V_1_sel_wr_reg(grp_handle_header_fu_175_n_99),
        .\o_data_V_dest_V_1_state_reg[0] (grp_handle_header_fu_175_n_7),
        .\o_data_V_dest_V_1_state_reg[0]_0 (o_data_TVALID),
        .\o_data_V_dest_V_1_state_reg[1] (grp_handle_header_fu_175_n_98),
        .o_data_V_id_V_1_ack_in(o_data_V_id_V_1_ack_in),
        .o_data_V_id_V_1_sel_wr(o_data_V_id_V_1_sel_wr),
        .o_data_V_id_V_1_sel_wr_reg(grp_handle_header_fu_175_n_100),
        .\o_data_V_id_V_1_state_reg[0] (grp_handle_header_fu_175_n_6),
        .\o_data_V_id_V_1_state_reg[0]_0 (\o_data_V_id_V_1_state_reg_n_0_[0] ),
        .\o_data_V_id_V_1_state_reg[1] (grp_handle_header_fu_175_n_97),
        .o_data_V_keep_V_1_ack_in(o_data_V_keep_V_1_ack_in),
        .o_data_V_keep_V_1_sel_wr(o_data_V_keep_V_1_sel_wr),
        .o_data_V_keep_V_1_sel_wr_reg(grp_handle_header_fu_175_n_104),
        .\o_data_V_keep_V_1_state_reg[0] (grp_handle_header_fu_175_n_2),
        .\o_data_V_keep_V_1_state_reg[0]_0 (\o_data_V_keep_V_1_state_reg_n_0_[0] ),
        .\o_data_V_keep_V_1_state_reg[1] (grp_handle_header_fu_175_n_93),
        .o_data_V_last_V_1_ack_in(o_data_V_last_V_1_ack_in),
        .o_data_V_last_V_1_sel_wr(o_data_V_last_V_1_sel_wr),
        .o_data_V_last_V_1_sel_wr_reg(grp_handle_header_fu_175_n_101),
        .\o_data_V_last_V_1_state_reg[0] (grp_handle_header_fu_175_n_5),
        .\o_data_V_last_V_1_state_reg[0]_0 (\o_data_V_last_V_1_state_reg_n_0_[0] ),
        .\o_data_V_last_V_1_state_reg[1] (grp_handle_header_fu_175_n_96),
        .o_data_V_strb_V_1_ack_in(o_data_V_strb_V_1_ack_in),
        .o_data_V_strb_V_1_sel_wr(o_data_V_strb_V_1_sel_wr),
        .o_data_V_strb_V_1_sel_wr_reg(grp_handle_header_fu_175_n_103),
        .\o_data_V_strb_V_1_state_reg[0] (grp_handle_header_fu_175_n_3),
        .\o_data_V_strb_V_1_state_reg[0]_0 (\o_data_V_strb_V_1_state_reg_n_0_[0] ),
        .\o_data_V_strb_V_1_state_reg[1] (grp_handle_header_fu_175_n_94),
        .o_data_V_user_V_1_ack_in(o_data_V_user_V_1_ack_in),
        .\o_data_V_user_V_1_payload_A_reg[72] ({grp_handle_header_fu_175_n_9,o_data_V_user_V_1_data_in[64]}),
        .o_data_V_user_V_1_sel_wr(o_data_V_user_V_1_sel_wr),
        .o_data_V_user_V_1_sel_wr_reg(grp_handle_header_fu_175_n_102),
        .\o_data_V_user_V_1_state_reg[0] (grp_handle_header_fu_175_n_4),
        .\o_data_V_user_V_1_state_reg[0]_0 (\o_data_V_user_V_1_state_reg_n_0_[0] ),
        .\o_data_V_user_V_1_state_reg[1] (grp_handle_header_fu_175_n_95),
        .p_222_in(p_222_in),
        .\pos_enc_0_read_reg_681_reg[31] ({\pos_enc_0_read_reg_681_reg_n_0_[31] ,\pos_enc_0_read_reg_681_reg_n_0_[30] ,\pos_enc_0_read_reg_681_reg_n_0_[29] ,\pos_enc_0_read_reg_681_reg_n_0_[28] ,\pos_enc_0_read_reg_681_reg_n_0_[27] ,\pos_enc_0_read_reg_681_reg_n_0_[26] ,\pos_enc_0_read_reg_681_reg_n_0_[25] ,\pos_enc_0_read_reg_681_reg_n_0_[24] ,\pos_enc_0_read_reg_681_reg_n_0_[23] ,\pos_enc_0_read_reg_681_reg_n_0_[22] ,\pos_enc_0_read_reg_681_reg_n_0_[21] ,\pos_enc_0_read_reg_681_reg_n_0_[20] ,\pos_enc_0_read_reg_681_reg_n_0_[19] ,\pos_enc_0_read_reg_681_reg_n_0_[18] ,\pos_enc_0_read_reg_681_reg_n_0_[17] ,\pos_enc_0_read_reg_681_reg_n_0_[16] ,\pos_enc_0_read_reg_681_reg_n_0_[15] ,\pos_enc_0_read_reg_681_reg_n_0_[14] ,\pos_enc_0_read_reg_681_reg_n_0_[13] ,\pos_enc_0_read_reg_681_reg_n_0_[12] ,\pos_enc_0_read_reg_681_reg_n_0_[11] ,\pos_enc_0_read_reg_681_reg_n_0_[10] ,\pos_enc_0_read_reg_681_reg_n_0_[9] ,\pos_enc_0_read_reg_681_reg_n_0_[8] ,\pos_enc_0_read_reg_681_reg_n_0_[7] ,\pos_enc_0_read_reg_681_reg_n_0_[6] ,\pos_enc_0_read_reg_681_reg_n_0_[5] ,\pos_enc_0_read_reg_681_reg_n_0_[4] ,\pos_enc_0_read_reg_681_reg_n_0_[3] ,\pos_enc_0_read_reg_681_reg_n_0_[2] ,\pos_enc_0_read_reg_681_reg_n_0_[1] ,\pos_enc_0_read_reg_681_reg_n_0_[0] }),
        .\pos_enc_1_read_reg_686_reg[31] ({\pos_enc_1_read_reg_686_reg_n_0_[31] ,\pos_enc_1_read_reg_686_reg_n_0_[30] ,\pos_enc_1_read_reg_686_reg_n_0_[29] ,\pos_enc_1_read_reg_686_reg_n_0_[28] ,\pos_enc_1_read_reg_686_reg_n_0_[27] ,\pos_enc_1_read_reg_686_reg_n_0_[26] ,\pos_enc_1_read_reg_686_reg_n_0_[25] ,\pos_enc_1_read_reg_686_reg_n_0_[24] ,\pos_enc_1_read_reg_686_reg_n_0_[23] ,\pos_enc_1_read_reg_686_reg_n_0_[22] ,\pos_enc_1_read_reg_686_reg_n_0_[21] ,\pos_enc_1_read_reg_686_reg_n_0_[20] ,\pos_enc_1_read_reg_686_reg_n_0_[19] ,\pos_enc_1_read_reg_686_reg_n_0_[18] ,\pos_enc_1_read_reg_686_reg_n_0_[17] ,\pos_enc_1_read_reg_686_reg_n_0_[16] ,\pos_enc_1_read_reg_686_reg_n_0_[15] ,\pos_enc_1_read_reg_686_reg_n_0_[14] ,\pos_enc_1_read_reg_686_reg_n_0_[13] ,\pos_enc_1_read_reg_686_reg_n_0_[12] ,\pos_enc_1_read_reg_686_reg_n_0_[11] ,\pos_enc_1_read_reg_686_reg_n_0_[10] ,\pos_enc_1_read_reg_686_reg_n_0_[9] ,\pos_enc_1_read_reg_686_reg_n_0_[8] ,\pos_enc_1_read_reg_686_reg_n_0_[7] ,\pos_enc_1_read_reg_686_reg_n_0_[6] ,\pos_enc_1_read_reg_686_reg_n_0_[5] ,\pos_enc_1_read_reg_686_reg_n_0_[4] ,\pos_enc_1_read_reg_686_reg_n_0_[3] ,\pos_enc_1_read_reg_686_reg_n_0_[2] ,\pos_enc_1_read_reg_686_reg_n_0_[1] ,\pos_enc_1_read_reg_686_reg_n_0_[0] }),
        .\pulse_metadata_V_0_payload_A_reg[820] ({pulse_metadata_V_0_payload_A[820:768],pulse_metadata_V_0_payload_A[31:0]}),
        .\pulse_metadata_V_0_payload_B_reg[820] ({pulse_metadata_V_0_payload_B[820:768],pulse_metadata_V_0_payload_B[31:0]}),
        .pulse_metadata_V_0_sel(pulse_metadata_V_0_sel),
        .pulse_metadata_V_0_sel_rd_reg(grp_handle_header_fu_175_n_108),
        .\pulse_metadata_V_0_state_reg[0] (grp_handle_header_fu_175_n_8),
        .\pulse_metadata_V_0_state_reg[0]_0 (\pulse_metadata_V_0_state_reg_n_0_[0] ),
        .\pulse_metadata_V_0_state_reg[1] (grp_handle_header_fu_175_n_107),
        .\pulse_metadata_V_0_state_reg[1]_0 (pulse_metadata_V_TREADY),
        .pulse_metadata_V_TVALID(pulse_metadata_V_TVALID),
        .sample_counter_1_fu_430_p2(sample_counter_1_fu_430_p2),
        .\sample_counter_fu_94_reg[0] (sample_counter_fu_94[0]),
        .\sample_counter_fu_94_reg[31] ({grp_handle_header_fu_175_n_43,grp_handle_header_fu_175_n_44,grp_handle_header_fu_175_n_45,grp_handle_header_fu_175_n_46,grp_handle_header_fu_175_n_47,grp_handle_header_fu_175_n_48,grp_handle_header_fu_175_n_49,grp_handle_header_fu_175_n_50,grp_handle_header_fu_175_n_51,grp_handle_header_fu_175_n_52,grp_handle_header_fu_175_n_53,grp_handle_header_fu_175_n_54,grp_handle_header_fu_175_n_55,grp_handle_header_fu_175_n_56,grp_handle_header_fu_175_n_57,grp_handle_header_fu_175_n_58,grp_handle_header_fu_175_n_59,grp_handle_header_fu_175_n_60,grp_handle_header_fu_175_n_61,grp_handle_header_fu_175_n_62,grp_handle_header_fu_175_n_63,grp_handle_header_fu_175_n_64,grp_handle_header_fu_175_n_65,grp_handle_header_fu_175_n_66,grp_handle_header_fu_175_n_67,grp_handle_header_fu_175_n_68,grp_handle_header_fu_175_n_69,grp_handle_header_fu_175_n_70,grp_handle_header_fu_175_n_71,grp_handle_header_fu_175_n_72,grp_handle_header_fu_175_n_73,grp_handle_header_fu_175_n_74}),
        .\sample_counter_load_1_reg_632_reg[31] (sample_counter_load_1_reg_632),
        .tmp_2_fu_295_p3(tmp_2_fu_295_p3),
        .\tmp_2_reg_618_reg[0] (\tmp_2_reg_618_reg_n_0_[0] ),
        .\tmp_data_V_reg_577_reg[31] (tmp_data_V_reg_577));
  LUT3 #(
    .INIT(8'h0D)) 
    \i_data_V_data_V_0_payload_A[31]_i_1 
       (.I0(\i_data_V_data_V_0_state_reg_n_0_[0] ),
        .I1(i_data_V_data_V_0_ack_in),
        .I2(i_data_V_data_V_0_sel_wr),
        .O(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ));
  FDRE \i_data_V_data_V_0_payload_A_reg[0] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[0]),
        .Q(i_data_V_data_V_0_payload_A[0]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[10] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[10]),
        .Q(i_data_V_data_V_0_payload_A[10]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[11] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[11]),
        .Q(i_data_V_data_V_0_payload_A[11]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[12] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[12]),
        .Q(i_data_V_data_V_0_payload_A[12]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[13] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[13]),
        .Q(i_data_V_data_V_0_payload_A[13]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[14] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[14]),
        .Q(i_data_V_data_V_0_payload_A[14]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[15] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[15]),
        .Q(i_data_V_data_V_0_payload_A[15]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[16] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[16]),
        .Q(i_data_V_data_V_0_payload_A[16]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[17] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[17]),
        .Q(i_data_V_data_V_0_payload_A[17]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[18] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[18]),
        .Q(i_data_V_data_V_0_payload_A[18]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[19] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[19]),
        .Q(i_data_V_data_V_0_payload_A[19]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[1] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[1]),
        .Q(i_data_V_data_V_0_payload_A[1]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[20] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[20]),
        .Q(i_data_V_data_V_0_payload_A[20]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[21] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[21]),
        .Q(i_data_V_data_V_0_payload_A[21]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[22] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[22]),
        .Q(i_data_V_data_V_0_payload_A[22]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[23] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[23]),
        .Q(i_data_V_data_V_0_payload_A[23]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[24] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[24]),
        .Q(i_data_V_data_V_0_payload_A[24]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[25] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[25]),
        .Q(i_data_V_data_V_0_payload_A[25]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[26] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[26]),
        .Q(i_data_V_data_V_0_payload_A[26]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[27] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[27]),
        .Q(i_data_V_data_V_0_payload_A[27]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[28] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[28]),
        .Q(i_data_V_data_V_0_payload_A[28]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[29] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[29]),
        .Q(i_data_V_data_V_0_payload_A[29]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[2] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[2]),
        .Q(i_data_V_data_V_0_payload_A[2]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[30] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[30]),
        .Q(i_data_V_data_V_0_payload_A[30]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[31] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[31]),
        .Q(i_data_V_data_V_0_payload_A[31]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[3] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[3]),
        .Q(i_data_V_data_V_0_payload_A[3]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[4] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[4]),
        .Q(i_data_V_data_V_0_payload_A[4]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[5] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[5]),
        .Q(i_data_V_data_V_0_payload_A[5]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[6] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[6]),
        .Q(i_data_V_data_V_0_payload_A[6]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[7] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[7]),
        .Q(i_data_V_data_V_0_payload_A[7]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[8] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[8]),
        .Q(i_data_V_data_V_0_payload_A[8]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_A_reg[9] 
       (.C(ap_clk),
        .CE(\i_data_V_data_V_0_payload_A[31]_i_1_n_0 ),
        .D(i_data_TDATA[9]),
        .Q(i_data_V_data_V_0_payload_A[9]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hD0)) 
    \i_data_V_data_V_0_payload_B[31]_i_1 
       (.I0(\i_data_V_data_V_0_state_reg_n_0_[0] ),
        .I1(i_data_V_data_V_0_ack_in),
        .I2(i_data_V_data_V_0_sel_wr),
        .O(i_data_V_data_V_0_load_B));
  FDRE \i_data_V_data_V_0_payload_B_reg[0] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[0]),
        .Q(i_data_V_data_V_0_payload_B[0]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[10] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[10]),
        .Q(i_data_V_data_V_0_payload_B[10]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[11] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[11]),
        .Q(i_data_V_data_V_0_payload_B[11]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[12] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[12]),
        .Q(i_data_V_data_V_0_payload_B[12]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[13] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[13]),
        .Q(i_data_V_data_V_0_payload_B[13]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[14] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[14]),
        .Q(i_data_V_data_V_0_payload_B[14]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[15] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[15]),
        .Q(i_data_V_data_V_0_payload_B[15]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[16] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[16]),
        .Q(i_data_V_data_V_0_payload_B[16]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[17] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[17]),
        .Q(i_data_V_data_V_0_payload_B[17]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[18] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[18]),
        .Q(i_data_V_data_V_0_payload_B[18]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[19] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[19]),
        .Q(i_data_V_data_V_0_payload_B[19]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[1] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[1]),
        .Q(i_data_V_data_V_0_payload_B[1]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[20] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[20]),
        .Q(i_data_V_data_V_0_payload_B[20]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[21] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[21]),
        .Q(i_data_V_data_V_0_payload_B[21]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[22] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[22]),
        .Q(i_data_V_data_V_0_payload_B[22]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[23] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[23]),
        .Q(i_data_V_data_V_0_payload_B[23]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[24] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[24]),
        .Q(i_data_V_data_V_0_payload_B[24]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[25] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[25]),
        .Q(i_data_V_data_V_0_payload_B[25]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[26] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[26]),
        .Q(i_data_V_data_V_0_payload_B[26]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[27] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[27]),
        .Q(i_data_V_data_V_0_payload_B[27]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[28] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[28]),
        .Q(i_data_V_data_V_0_payload_B[28]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[29] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[29]),
        .Q(i_data_V_data_V_0_payload_B[29]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[2] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[2]),
        .Q(i_data_V_data_V_0_payload_B[2]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[30] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[30]),
        .Q(i_data_V_data_V_0_payload_B[30]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[31] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[31]),
        .Q(i_data_V_data_V_0_payload_B[31]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[3] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[3]),
        .Q(i_data_V_data_V_0_payload_B[3]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[4] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[4]),
        .Q(i_data_V_data_V_0_payload_B[4]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[5] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[5]),
        .Q(i_data_V_data_V_0_payload_B[5]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[6] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[6]),
        .Q(i_data_V_data_V_0_payload_B[6]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[7] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[7]),
        .Q(i_data_V_data_V_0_payload_B[7]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[8] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[8]),
        .Q(i_data_V_data_V_0_payload_B[8]),
        .R(1'b0));
  FDRE \i_data_V_data_V_0_payload_B_reg[9] 
       (.C(ap_clk),
        .CE(i_data_V_data_V_0_load_B),
        .D(i_data_TDATA[9]),
        .Q(i_data_V_data_V_0_payload_B[9]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h5575FFFFAA8A0000)) 
    i_data_V_data_V_0_sel_rd_i_1
       (.I0(ap_CS_fsm_state3),
        .I1(tmp_2_fu_295_p3),
        .I2(brmerge_fu_387_p2),
        .I3(o_data_V_data_V_1_ack_in),
        .I4(\i_data_V_data_V_0_state_reg_n_0_[0] ),
        .I5(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_sel_rd_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    i_data_V_data_V_0_sel_rd_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(i_data_V_data_V_0_sel_rd_i_1_n_0),
        .Q(i_data_V_data_V_0_sel),
        .R(ap_rst));
  (* SOFT_HLUTNM = "soft_lutpair155" *) 
  LUT3 #(
    .INIT(8'h78)) 
    i_data_V_data_V_0_sel_wr_i_1
       (.I0(i_data_TVALID),
        .I1(i_data_V_data_V_0_ack_in),
        .I2(i_data_V_data_V_0_sel_wr),
        .O(i_data_V_data_V_0_sel_wr_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    i_data_V_data_V_0_sel_wr_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(i_data_V_data_V_0_sel_wr_i_1_n_0),
        .Q(i_data_V_data_V_0_sel_wr),
        .R(ap_rst));
  LUT5 #(
    .INIT(32'hA2AAA000)) 
    \i_data_V_data_V_0_state[0]_i_1 
       (.I0(ap_rst_n),
        .I1(p_222_in),
        .I2(i_data_TVALID),
        .I3(i_data_V_data_V_0_ack_in),
        .I4(\i_data_V_data_V_0_state_reg_n_0_[0] ),
        .O(\i_data_V_data_V_0_state[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hF3FB)) 
    \i_data_V_data_V_0_state[1]_i_1 
       (.I0(i_data_V_data_V_0_ack_in),
        .I1(\i_data_V_data_V_0_state_reg_n_0_[0] ),
        .I2(p_222_in),
        .I3(i_data_TVALID),
        .O(\i_data_V_data_V_0_state[1]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \i_data_V_data_V_0_state_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\i_data_V_data_V_0_state[0]_i_1_n_0 ),
        .Q(\i_data_V_data_V_0_state_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \i_data_V_data_V_0_state_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\i_data_V_data_V_0_state[1]_i_1_n_0 ),
        .Q(i_data_V_data_V_0_ack_in),
        .R(ap_rst));
  LUT5 #(
    .INIT(32'hFFAE00A2)) 
    \i_data_V_dest_V_0_payload_A[0]_i_1 
       (.I0(i_data_TDEST),
        .I1(\i_data_V_dest_V_0_state_reg_n_0_[0] ),
        .I2(i_data_TREADY),
        .I3(i_data_V_dest_V_0_sel_wr),
        .I4(i_data_V_dest_V_0_payload_A),
        .O(\i_data_V_dest_V_0_payload_A[0]_i_1_n_0 ));
  FDRE \i_data_V_dest_V_0_payload_A_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\i_data_V_dest_V_0_payload_A[0]_i_1_n_0 ),
        .Q(i_data_V_dest_V_0_payload_A),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hAEFFA200)) 
    \i_data_V_dest_V_0_payload_B[0]_i_1 
       (.I0(i_data_TDEST),
        .I1(\i_data_V_dest_V_0_state_reg_n_0_[0] ),
        .I2(i_data_TREADY),
        .I3(i_data_V_dest_V_0_sel_wr),
        .I4(i_data_V_dest_V_0_payload_B),
        .O(\i_data_V_dest_V_0_payload_B[0]_i_1_n_0 ));
  FDRE \i_data_V_dest_V_0_payload_B_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\i_data_V_dest_V_0_payload_B[0]_i_1_n_0 ),
        .Q(i_data_V_dest_V_0_payload_B),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h78)) 
    i_data_V_dest_V_0_sel_rd_i_1
       (.I0(p_222_in),
        .I1(\i_data_V_dest_V_0_state_reg_n_0_[0] ),
        .I2(i_data_V_dest_V_0_sel),
        .O(i_data_V_dest_V_0_sel_rd_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    i_data_V_dest_V_0_sel_rd_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(i_data_V_dest_V_0_sel_rd_i_1_n_0),
        .Q(i_data_V_dest_V_0_sel),
        .R(ap_rst));
  (* SOFT_HLUTNM = "soft_lutpair155" *) 
  LUT3 #(
    .INIT(8'h78)) 
    i_data_V_dest_V_0_sel_wr_i_1
       (.I0(i_data_TVALID),
        .I1(i_data_TREADY),
        .I2(i_data_V_dest_V_0_sel_wr),
        .O(i_data_V_dest_V_0_sel_wr_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    i_data_V_dest_V_0_sel_wr_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(i_data_V_dest_V_0_sel_wr_i_1_n_0),
        .Q(i_data_V_dest_V_0_sel_wr),
        .R(ap_rst));
  LUT5 #(
    .INIT(32'hA2AAA000)) 
    \i_data_V_dest_V_0_state[0]_i_1 
       (.I0(ap_rst_n),
        .I1(p_222_in),
        .I2(i_data_TVALID),
        .I3(i_data_TREADY),
        .I4(\i_data_V_dest_V_0_state_reg_n_0_[0] ),
        .O(\i_data_V_dest_V_0_state[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hF3FB)) 
    \i_data_V_dest_V_0_state[1]_i_2 
       (.I0(i_data_TREADY),
        .I1(\i_data_V_dest_V_0_state_reg_n_0_[0] ),
        .I2(p_222_in),
        .I3(i_data_TVALID),
        .O(\i_data_V_dest_V_0_state[1]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \i_data_V_dest_V_0_state_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\i_data_V_dest_V_0_state[0]_i_1_n_0 ),
        .Q(\i_data_V_dest_V_0_state_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \i_data_V_dest_V_0_state_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\i_data_V_dest_V_0_state[1]_i_2_n_0 ),
        .Q(i_data_TREADY),
        .R(ap_rst));
  LUT5 #(
    .INIT(32'hFFAE00A2)) 
    \i_data_V_id_V_0_payload_A[0]_i_1 
       (.I0(i_data_TID),
        .I1(\i_data_V_id_V_0_state_reg_n_0_[0] ),
        .I2(i_data_V_id_V_0_ack_in),
        .I3(i_data_V_id_V_0_sel_wr),
        .I4(i_data_V_id_V_0_payload_A),
        .O(\i_data_V_id_V_0_payload_A[0]_i_1_n_0 ));
  FDRE \i_data_V_id_V_0_payload_A_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\i_data_V_id_V_0_payload_A[0]_i_1_n_0 ),
        .Q(i_data_V_id_V_0_payload_A),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hAEFFA200)) 
    \i_data_V_id_V_0_payload_B[0]_i_1 
       (.I0(i_data_TID),
        .I1(\i_data_V_id_V_0_state_reg_n_0_[0] ),
        .I2(i_data_V_id_V_0_ack_in),
        .I3(i_data_V_id_V_0_sel_wr),
        .I4(i_data_V_id_V_0_payload_B),
        .O(\i_data_V_id_V_0_payload_B[0]_i_1_n_0 ));
  FDRE \i_data_V_id_V_0_payload_B_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\i_data_V_id_V_0_payload_B[0]_i_1_n_0 ),
        .Q(i_data_V_id_V_0_payload_B),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h78)) 
    i_data_V_id_V_0_sel_rd_i_1
       (.I0(p_222_in),
        .I1(\i_data_V_id_V_0_state_reg_n_0_[0] ),
        .I2(i_data_V_id_V_0_sel),
        .O(i_data_V_id_V_0_sel_rd_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    i_data_V_id_V_0_sel_rd_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(i_data_V_id_V_0_sel_rd_i_1_n_0),
        .Q(i_data_V_id_V_0_sel),
        .R(ap_rst));
  (* SOFT_HLUTNM = "soft_lutpair120" *) 
  LUT3 #(
    .INIT(8'h78)) 
    i_data_V_id_V_0_sel_wr_i_1
       (.I0(i_data_TVALID),
        .I1(i_data_V_id_V_0_ack_in),
        .I2(i_data_V_id_V_0_sel_wr),
        .O(i_data_V_id_V_0_sel_wr_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    i_data_V_id_V_0_sel_wr_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(i_data_V_id_V_0_sel_wr_i_1_n_0),
        .Q(i_data_V_id_V_0_sel_wr),
        .R(ap_rst));
  LUT5 #(
    .INIT(32'hA2AAA000)) 
    \i_data_V_id_V_0_state[0]_i_1 
       (.I0(ap_rst_n),
        .I1(p_222_in),
        .I2(i_data_TVALID),
        .I3(i_data_V_id_V_0_ack_in),
        .I4(\i_data_V_id_V_0_state_reg_n_0_[0] ),
        .O(\i_data_V_id_V_0_state[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hF3FB)) 
    \i_data_V_id_V_0_state[1]_i_1 
       (.I0(i_data_V_id_V_0_ack_in),
        .I1(\i_data_V_id_V_0_state_reg_n_0_[0] ),
        .I2(p_222_in),
        .I3(i_data_TVALID),
        .O(\i_data_V_id_V_0_state[1]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \i_data_V_id_V_0_state_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\i_data_V_id_V_0_state[0]_i_1_n_0 ),
        .Q(\i_data_V_id_V_0_state_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \i_data_V_id_V_0_state_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\i_data_V_id_V_0_state[1]_i_1_n_0 ),
        .Q(i_data_V_id_V_0_ack_in),
        .R(ap_rst));
  LUT3 #(
    .INIT(8'h0D)) 
    \i_data_V_keep_V_0_payload_A[3]_i_1 
       (.I0(\i_data_V_keep_V_0_state_reg_n_0_[0] ),
        .I1(i_data_V_keep_V_0_ack_in),
        .I2(i_data_V_keep_V_0_sel_wr),
        .O(\i_data_V_keep_V_0_payload_A[3]_i_1_n_0 ));
  FDRE \i_data_V_keep_V_0_payload_A_reg[0] 
       (.C(ap_clk),
        .CE(\i_data_V_keep_V_0_payload_A[3]_i_1_n_0 ),
        .D(i_data_TKEEP[0]),
        .Q(i_data_V_keep_V_0_payload_A[0]),
        .R(1'b0));
  FDRE \i_data_V_keep_V_0_payload_A_reg[1] 
       (.C(ap_clk),
        .CE(\i_data_V_keep_V_0_payload_A[3]_i_1_n_0 ),
        .D(i_data_TKEEP[1]),
        .Q(i_data_V_keep_V_0_payload_A[1]),
        .R(1'b0));
  FDRE \i_data_V_keep_V_0_payload_A_reg[2] 
       (.C(ap_clk),
        .CE(\i_data_V_keep_V_0_payload_A[3]_i_1_n_0 ),
        .D(i_data_TKEEP[2]),
        .Q(i_data_V_keep_V_0_payload_A[2]),
        .R(1'b0));
  FDRE \i_data_V_keep_V_0_payload_A_reg[3] 
       (.C(ap_clk),
        .CE(\i_data_V_keep_V_0_payload_A[3]_i_1_n_0 ),
        .D(i_data_TKEEP[3]),
        .Q(i_data_V_keep_V_0_payload_A[3]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hA2)) 
    \i_data_V_keep_V_0_payload_B[3]_i_1 
       (.I0(i_data_V_keep_V_0_sel_wr),
        .I1(\i_data_V_keep_V_0_state_reg_n_0_[0] ),
        .I2(i_data_V_keep_V_0_ack_in),
        .O(i_data_V_keep_V_0_load_B));
  FDRE \i_data_V_keep_V_0_payload_B_reg[0] 
       (.C(ap_clk),
        .CE(i_data_V_keep_V_0_load_B),
        .D(i_data_TKEEP[0]),
        .Q(i_data_V_keep_V_0_payload_B[0]),
        .R(1'b0));
  FDRE \i_data_V_keep_V_0_payload_B_reg[1] 
       (.C(ap_clk),
        .CE(i_data_V_keep_V_0_load_B),
        .D(i_data_TKEEP[1]),
        .Q(i_data_V_keep_V_0_payload_B[1]),
        .R(1'b0));
  FDRE \i_data_V_keep_V_0_payload_B_reg[2] 
       (.C(ap_clk),
        .CE(i_data_V_keep_V_0_load_B),
        .D(i_data_TKEEP[2]),
        .Q(i_data_V_keep_V_0_payload_B[2]),
        .R(1'b0));
  FDRE \i_data_V_keep_V_0_payload_B_reg[3] 
       (.C(ap_clk),
        .CE(i_data_V_keep_V_0_load_B),
        .D(i_data_TKEEP[3]),
        .Q(i_data_V_keep_V_0_payload_B[3]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h78)) 
    i_data_V_keep_V_0_sel_rd_i_1
       (.I0(p_222_in),
        .I1(\i_data_V_keep_V_0_state_reg_n_0_[0] ),
        .I2(i_data_V_keep_V_0_sel),
        .O(i_data_V_keep_V_0_sel_rd_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    i_data_V_keep_V_0_sel_rd_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(i_data_V_keep_V_0_sel_rd_i_1_n_0),
        .Q(i_data_V_keep_V_0_sel),
        .R(ap_rst));
  (* SOFT_HLUTNM = "soft_lutpair198" *) 
  LUT3 #(
    .INIT(8'h78)) 
    i_data_V_keep_V_0_sel_wr_i_1
       (.I0(i_data_TVALID),
        .I1(i_data_V_keep_V_0_ack_in),
        .I2(i_data_V_keep_V_0_sel_wr),
        .O(i_data_V_keep_V_0_sel_wr_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    i_data_V_keep_V_0_sel_wr_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(i_data_V_keep_V_0_sel_wr_i_1_n_0),
        .Q(i_data_V_keep_V_0_sel_wr),
        .R(ap_rst));
  LUT5 #(
    .INIT(32'hA2AAA000)) 
    \i_data_V_keep_V_0_state[0]_i_1 
       (.I0(ap_rst_n),
        .I1(p_222_in),
        .I2(i_data_TVALID),
        .I3(i_data_V_keep_V_0_ack_in),
        .I4(\i_data_V_keep_V_0_state_reg_n_0_[0] ),
        .O(\i_data_V_keep_V_0_state[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hF3FB)) 
    \i_data_V_keep_V_0_state[1]_i_1 
       (.I0(i_data_V_keep_V_0_ack_in),
        .I1(\i_data_V_keep_V_0_state_reg_n_0_[0] ),
        .I2(p_222_in),
        .I3(i_data_TVALID),
        .O(\i_data_V_keep_V_0_state[1]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \i_data_V_keep_V_0_state_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\i_data_V_keep_V_0_state[0]_i_1_n_0 ),
        .Q(\i_data_V_keep_V_0_state_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \i_data_V_keep_V_0_state_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\i_data_V_keep_V_0_state[1]_i_1_n_0 ),
        .Q(i_data_V_keep_V_0_ack_in),
        .R(ap_rst));
  LUT5 #(
    .INIT(32'hFFAE00A2)) 
    \i_data_V_last_V_0_payload_A[0]_i_1 
       (.I0(i_data_TLAST),
        .I1(\i_data_V_last_V_0_state_reg_n_0_[0] ),
        .I2(i_data_V_last_V_0_ack_in),
        .I3(i_data_V_last_V_0_sel_wr),
        .I4(i_data_V_last_V_0_payload_A),
        .O(\i_data_V_last_V_0_payload_A[0]_i_1_n_0 ));
  FDRE \i_data_V_last_V_0_payload_A_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\i_data_V_last_V_0_payload_A[0]_i_1_n_0 ),
        .Q(i_data_V_last_V_0_payload_A),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hBBFB8808)) 
    \i_data_V_last_V_0_payload_B[0]_i_1 
       (.I0(i_data_TLAST),
        .I1(i_data_V_last_V_0_sel_wr),
        .I2(\i_data_V_last_V_0_state_reg_n_0_[0] ),
        .I3(i_data_V_last_V_0_ack_in),
        .I4(i_data_V_last_V_0_payload_B),
        .O(\i_data_V_last_V_0_payload_B[0]_i_1_n_0 ));
  FDRE \i_data_V_last_V_0_payload_B_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\i_data_V_last_V_0_payload_B[0]_i_1_n_0 ),
        .Q(i_data_V_last_V_0_payload_B),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h78)) 
    i_data_V_last_V_0_sel_rd_i_1
       (.I0(p_222_in),
        .I1(\i_data_V_last_V_0_state_reg_n_0_[0] ),
        .I2(i_data_V_last_V_0_sel),
        .O(i_data_V_last_V_0_sel_rd_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    i_data_V_last_V_0_sel_rd_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(i_data_V_last_V_0_sel_rd_i_1_n_0),
        .Q(i_data_V_last_V_0_sel),
        .R(ap_rst));
  LUT3 #(
    .INIT(8'h78)) 
    i_data_V_last_V_0_sel_wr_i_1
       (.I0(i_data_TVALID),
        .I1(i_data_V_last_V_0_ack_in),
        .I2(i_data_V_last_V_0_sel_wr),
        .O(i_data_V_last_V_0_sel_wr_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    i_data_V_last_V_0_sel_wr_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(i_data_V_last_V_0_sel_wr_i_1_n_0),
        .Q(i_data_V_last_V_0_sel_wr),
        .R(ap_rst));
  LUT5 #(
    .INIT(32'hA2AAA000)) 
    \i_data_V_last_V_0_state[0]_i_1 
       (.I0(ap_rst_n),
        .I1(p_222_in),
        .I2(i_data_TVALID),
        .I3(i_data_V_last_V_0_ack_in),
        .I4(\i_data_V_last_V_0_state_reg_n_0_[0] ),
        .O(\i_data_V_last_V_0_state[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hF3FB)) 
    \i_data_V_last_V_0_state[1]_i_1 
       (.I0(i_data_V_last_V_0_ack_in),
        .I1(\i_data_V_last_V_0_state_reg_n_0_[0] ),
        .I2(p_222_in),
        .I3(i_data_TVALID),
        .O(\i_data_V_last_V_0_state[1]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \i_data_V_last_V_0_state_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\i_data_V_last_V_0_state[0]_i_1_n_0 ),
        .Q(\i_data_V_last_V_0_state_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \i_data_V_last_V_0_state_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\i_data_V_last_V_0_state[1]_i_1_n_0 ),
        .Q(i_data_V_last_V_0_ack_in),
        .R(ap_rst));
  LUT3 #(
    .INIT(8'h0D)) 
    \i_data_V_strb_V_0_payload_A[3]_i_1 
       (.I0(\i_data_V_strb_V_0_state_reg_n_0_[0] ),
        .I1(i_data_V_strb_V_0_ack_in),
        .I2(i_data_V_strb_V_0_sel_wr),
        .O(\i_data_V_strb_V_0_payload_A[3]_i_1_n_0 ));
  FDRE \i_data_V_strb_V_0_payload_A_reg[0] 
       (.C(ap_clk),
        .CE(\i_data_V_strb_V_0_payload_A[3]_i_1_n_0 ),
        .D(i_data_TSTRB[0]),
        .Q(i_data_V_strb_V_0_payload_A[0]),
        .R(1'b0));
  FDRE \i_data_V_strb_V_0_payload_A_reg[1] 
       (.C(ap_clk),
        .CE(\i_data_V_strb_V_0_payload_A[3]_i_1_n_0 ),
        .D(i_data_TSTRB[1]),
        .Q(i_data_V_strb_V_0_payload_A[1]),
        .R(1'b0));
  FDRE \i_data_V_strb_V_0_payload_A_reg[2] 
       (.C(ap_clk),
        .CE(\i_data_V_strb_V_0_payload_A[3]_i_1_n_0 ),
        .D(i_data_TSTRB[2]),
        .Q(i_data_V_strb_V_0_payload_A[2]),
        .R(1'b0));
  FDRE \i_data_V_strb_V_0_payload_A_reg[3] 
       (.C(ap_clk),
        .CE(\i_data_V_strb_V_0_payload_A[3]_i_1_n_0 ),
        .D(i_data_TSTRB[3]),
        .Q(i_data_V_strb_V_0_payload_A[3]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hA2)) 
    \i_data_V_strb_V_0_payload_B[3]_i_1 
       (.I0(i_data_V_strb_V_0_sel_wr),
        .I1(\i_data_V_strb_V_0_state_reg_n_0_[0] ),
        .I2(i_data_V_strb_V_0_ack_in),
        .O(i_data_V_strb_V_0_load_B));
  FDRE \i_data_V_strb_V_0_payload_B_reg[0] 
       (.C(ap_clk),
        .CE(i_data_V_strb_V_0_load_B),
        .D(i_data_TSTRB[0]),
        .Q(i_data_V_strb_V_0_payload_B[0]),
        .R(1'b0));
  FDRE \i_data_V_strb_V_0_payload_B_reg[1] 
       (.C(ap_clk),
        .CE(i_data_V_strb_V_0_load_B),
        .D(i_data_TSTRB[1]),
        .Q(i_data_V_strb_V_0_payload_B[1]),
        .R(1'b0));
  FDRE \i_data_V_strb_V_0_payload_B_reg[2] 
       (.C(ap_clk),
        .CE(i_data_V_strb_V_0_load_B),
        .D(i_data_TSTRB[2]),
        .Q(i_data_V_strb_V_0_payload_B[2]),
        .R(1'b0));
  FDRE \i_data_V_strb_V_0_payload_B_reg[3] 
       (.C(ap_clk),
        .CE(i_data_V_strb_V_0_load_B),
        .D(i_data_TSTRB[3]),
        .Q(i_data_V_strb_V_0_payload_B[3]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h78)) 
    i_data_V_strb_V_0_sel_rd_i_1
       (.I0(p_222_in),
        .I1(\i_data_V_strb_V_0_state_reg_n_0_[0] ),
        .I2(i_data_V_strb_V_0_sel),
        .O(i_data_V_strb_V_0_sel_rd_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    i_data_V_strb_V_0_sel_rd_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(i_data_V_strb_V_0_sel_rd_i_1_n_0),
        .Q(i_data_V_strb_V_0_sel),
        .R(ap_rst));
  (* SOFT_HLUTNM = "soft_lutpair198" *) 
  LUT3 #(
    .INIT(8'h78)) 
    i_data_V_strb_V_0_sel_wr_i_1
       (.I0(i_data_TVALID),
        .I1(i_data_V_strb_V_0_ack_in),
        .I2(i_data_V_strb_V_0_sel_wr),
        .O(i_data_V_strb_V_0_sel_wr_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    i_data_V_strb_V_0_sel_wr_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(i_data_V_strb_V_0_sel_wr_i_1_n_0),
        .Q(i_data_V_strb_V_0_sel_wr),
        .R(ap_rst));
  LUT5 #(
    .INIT(32'hA2AAA000)) 
    \i_data_V_strb_V_0_state[0]_i_1 
       (.I0(ap_rst_n),
        .I1(p_222_in),
        .I2(i_data_TVALID),
        .I3(i_data_V_strb_V_0_ack_in),
        .I4(\i_data_V_strb_V_0_state_reg_n_0_[0] ),
        .O(\i_data_V_strb_V_0_state[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hF3FB)) 
    \i_data_V_strb_V_0_state[1]_i_1 
       (.I0(i_data_V_strb_V_0_ack_in),
        .I1(\i_data_V_strb_V_0_state_reg_n_0_[0] ),
        .I2(p_222_in),
        .I3(i_data_TVALID),
        .O(\i_data_V_strb_V_0_state[1]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \i_data_V_strb_V_0_state_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\i_data_V_strb_V_0_state[0]_i_1_n_0 ),
        .Q(\i_data_V_strb_V_0_state_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \i_data_V_strb_V_0_state_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\i_data_V_strb_V_0_state[1]_i_1_n_0 ),
        .Q(i_data_V_strb_V_0_ack_in),
        .R(ap_rst));
  LUT3 #(
    .INIT(8'h0D)) 
    \i_data_V_user_V_0_payload_A[127]_i_1 
       (.I0(\i_data_V_user_V_0_state_reg_n_0_[0] ),
        .I1(i_data_V_user_V_0_ack_in),
        .I2(i_data_V_user_V_0_sel_wr),
        .O(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ));
  FDRE \i_data_V_user_V_0_payload_A_reg[0] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[0]),
        .Q(i_data_V_user_V_0_payload_A[0]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[100] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[100]),
        .Q(i_data_V_user_V_0_payload_A[100]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[101] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[101]),
        .Q(i_data_V_user_V_0_payload_A[101]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[102] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[102]),
        .Q(i_data_V_user_V_0_payload_A[102]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[103] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[103]),
        .Q(i_data_V_user_V_0_payload_A[103]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[104] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[104]),
        .Q(i_data_V_user_V_0_payload_A[104]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[105] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[105]),
        .Q(i_data_V_user_V_0_payload_A[105]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[106] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[106]),
        .Q(i_data_V_user_V_0_payload_A[106]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[107] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[107]),
        .Q(i_data_V_user_V_0_payload_A[107]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[108] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[108]),
        .Q(i_data_V_user_V_0_payload_A[108]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[109] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[109]),
        .Q(i_data_V_user_V_0_payload_A[109]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[10] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[10]),
        .Q(i_data_V_user_V_0_payload_A[10]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[110] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[110]),
        .Q(i_data_V_user_V_0_payload_A[110]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[111] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[111]),
        .Q(i_data_V_user_V_0_payload_A[111]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[112] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[112]),
        .Q(i_data_V_user_V_0_payload_A[112]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[113] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[113]),
        .Q(i_data_V_user_V_0_payload_A[113]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[114] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[114]),
        .Q(i_data_V_user_V_0_payload_A[114]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[115] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[115]),
        .Q(i_data_V_user_V_0_payload_A[115]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[116] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[116]),
        .Q(i_data_V_user_V_0_payload_A[116]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[117] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[117]),
        .Q(i_data_V_user_V_0_payload_A[117]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[118] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[118]),
        .Q(i_data_V_user_V_0_payload_A[118]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[119] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[119]),
        .Q(i_data_V_user_V_0_payload_A[119]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[11] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[11]),
        .Q(i_data_V_user_V_0_payload_A[11]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[120] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[120]),
        .Q(i_data_V_user_V_0_payload_A[120]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[121] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[121]),
        .Q(i_data_V_user_V_0_payload_A[121]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[122] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[122]),
        .Q(i_data_V_user_V_0_payload_A[122]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[123] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[123]),
        .Q(i_data_V_user_V_0_payload_A[123]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[124] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[124]),
        .Q(i_data_V_user_V_0_payload_A[124]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[125] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[125]),
        .Q(i_data_V_user_V_0_payload_A[125]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[126] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[126]),
        .Q(i_data_V_user_V_0_payload_A[126]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[127] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[127]),
        .Q(i_data_V_user_V_0_payload_A[127]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[12] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[12]),
        .Q(i_data_V_user_V_0_payload_A[12]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[13] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[13]),
        .Q(i_data_V_user_V_0_payload_A[13]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[14] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[14]),
        .Q(i_data_V_user_V_0_payload_A[14]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[15] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[15]),
        .Q(i_data_V_user_V_0_payload_A[15]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[16] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[16]),
        .Q(i_data_V_user_V_0_payload_A[16]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[17] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[17]),
        .Q(i_data_V_user_V_0_payload_A[17]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[18] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[18]),
        .Q(i_data_V_user_V_0_payload_A[18]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[19] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[19]),
        .Q(i_data_V_user_V_0_payload_A[19]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[1] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[1]),
        .Q(i_data_V_user_V_0_payload_A[1]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[20] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[20]),
        .Q(i_data_V_user_V_0_payload_A[20]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[21] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[21]),
        .Q(i_data_V_user_V_0_payload_A[21]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[22] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[22]),
        .Q(i_data_V_user_V_0_payload_A[22]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[23] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[23]),
        .Q(i_data_V_user_V_0_payload_A[23]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[24] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[24]),
        .Q(i_data_V_user_V_0_payload_A[24]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[25] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[25]),
        .Q(i_data_V_user_V_0_payload_A[25]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[26] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[26]),
        .Q(i_data_V_user_V_0_payload_A[26]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[27] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[27]),
        .Q(i_data_V_user_V_0_payload_A[27]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[28] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[28]),
        .Q(i_data_V_user_V_0_payload_A[28]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[29] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[29]),
        .Q(i_data_V_user_V_0_payload_A[29]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[2] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[2]),
        .Q(i_data_V_user_V_0_payload_A[2]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[30] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[30]),
        .Q(i_data_V_user_V_0_payload_A[30]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[31] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[31]),
        .Q(i_data_V_user_V_0_payload_A[31]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[32] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[32]),
        .Q(i_data_V_user_V_0_payload_A[32]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[33] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[33]),
        .Q(i_data_V_user_V_0_payload_A[33]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[34] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[34]),
        .Q(i_data_V_user_V_0_payload_A[34]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[35] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[35]),
        .Q(i_data_V_user_V_0_payload_A[35]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[36] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[36]),
        .Q(i_data_V_user_V_0_payload_A[36]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[37] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[37]),
        .Q(i_data_V_user_V_0_payload_A[37]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[38] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[38]),
        .Q(i_data_V_user_V_0_payload_A[38]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[39] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[39]),
        .Q(i_data_V_user_V_0_payload_A[39]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[3] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[3]),
        .Q(i_data_V_user_V_0_payload_A[3]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[40] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[40]),
        .Q(i_data_V_user_V_0_payload_A[40]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[41] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[41]),
        .Q(i_data_V_user_V_0_payload_A[41]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[42] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[42]),
        .Q(i_data_V_user_V_0_payload_A[42]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[43] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[43]),
        .Q(i_data_V_user_V_0_payload_A[43]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[44] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[44]),
        .Q(i_data_V_user_V_0_payload_A[44]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[45] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[45]),
        .Q(i_data_V_user_V_0_payload_A[45]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[46] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[46]),
        .Q(i_data_V_user_V_0_payload_A[46]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[47] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[47]),
        .Q(i_data_V_user_V_0_payload_A[47]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[48] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[48]),
        .Q(i_data_V_user_V_0_payload_A[48]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[49] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[49]),
        .Q(i_data_V_user_V_0_payload_A[49]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[4] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[4]),
        .Q(i_data_V_user_V_0_payload_A[4]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[50] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[50]),
        .Q(i_data_V_user_V_0_payload_A[50]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[51] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[51]),
        .Q(i_data_V_user_V_0_payload_A[51]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[52] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[52]),
        .Q(i_data_V_user_V_0_payload_A[52]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[53] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[53]),
        .Q(i_data_V_user_V_0_payload_A[53]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[54] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[54]),
        .Q(i_data_V_user_V_0_payload_A[54]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[55] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[55]),
        .Q(i_data_V_user_V_0_payload_A[55]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[56] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[56]),
        .Q(i_data_V_user_V_0_payload_A[56]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[57] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[57]),
        .Q(i_data_V_user_V_0_payload_A[57]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[58] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[58]),
        .Q(i_data_V_user_V_0_payload_A[58]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[59] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[59]),
        .Q(i_data_V_user_V_0_payload_A[59]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[5] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[5]),
        .Q(i_data_V_user_V_0_payload_A[5]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[60] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[60]),
        .Q(i_data_V_user_V_0_payload_A[60]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[61] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[61]),
        .Q(i_data_V_user_V_0_payload_A[61]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[62] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[62]),
        .Q(i_data_V_user_V_0_payload_A[62]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[63] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[63]),
        .Q(i_data_V_user_V_0_payload_A[63]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[65] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[65]),
        .Q(i_data_V_user_V_0_payload_A[65]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[66] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[66]),
        .Q(i_data_V_user_V_0_payload_A[66]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[67] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[67]),
        .Q(i_data_V_user_V_0_payload_A[67]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[68] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[68]),
        .Q(i_data_V_user_V_0_payload_A[68]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[69] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[69]),
        .Q(i_data_V_user_V_0_payload_A[69]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[6] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[6]),
        .Q(i_data_V_user_V_0_payload_A[6]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[70] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[70]),
        .Q(i_data_V_user_V_0_payload_A[70]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[71] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[71]),
        .Q(i_data_V_user_V_0_payload_A[71]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[72] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[72]),
        .Q(i_data_V_user_V_0_payload_A[72]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[73] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[73]),
        .Q(i_data_V_user_V_0_payload_A[73]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[74] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[74]),
        .Q(i_data_V_user_V_0_payload_A[74]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[75] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[75]),
        .Q(i_data_V_user_V_0_payload_A[75]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[76] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[76]),
        .Q(i_data_V_user_V_0_payload_A[76]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[77] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[77]),
        .Q(i_data_V_user_V_0_payload_A[77]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[78] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[78]),
        .Q(i_data_V_user_V_0_payload_A[78]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[79] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[79]),
        .Q(i_data_V_user_V_0_payload_A[79]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[7] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[7]),
        .Q(i_data_V_user_V_0_payload_A[7]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[80] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[80]),
        .Q(i_data_V_user_V_0_payload_A[80]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[81] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[81]),
        .Q(i_data_V_user_V_0_payload_A[81]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[82] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[82]),
        .Q(i_data_V_user_V_0_payload_A[82]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[83] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[83]),
        .Q(i_data_V_user_V_0_payload_A[83]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[84] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[84]),
        .Q(i_data_V_user_V_0_payload_A[84]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[85] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[85]),
        .Q(i_data_V_user_V_0_payload_A[85]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[86] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[86]),
        .Q(i_data_V_user_V_0_payload_A[86]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[87] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[87]),
        .Q(i_data_V_user_V_0_payload_A[87]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[88] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[88]),
        .Q(i_data_V_user_V_0_payload_A[88]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[89] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[89]),
        .Q(i_data_V_user_V_0_payload_A[89]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[8] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[8]),
        .Q(i_data_V_user_V_0_payload_A[8]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[90] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[90]),
        .Q(i_data_V_user_V_0_payload_A[90]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[91] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[91]),
        .Q(i_data_V_user_V_0_payload_A[91]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[92] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[92]),
        .Q(i_data_V_user_V_0_payload_A[92]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[93] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[93]),
        .Q(i_data_V_user_V_0_payload_A[93]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[94] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[94]),
        .Q(i_data_V_user_V_0_payload_A[94]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[95] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[95]),
        .Q(i_data_V_user_V_0_payload_A[95]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[96] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[96]),
        .Q(i_data_V_user_V_0_payload_A[96]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[97] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[97]),
        .Q(i_data_V_user_V_0_payload_A[97]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[98] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[98]),
        .Q(i_data_V_user_V_0_payload_A[98]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[99] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[99]),
        .Q(i_data_V_user_V_0_payload_A[99]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_A_reg[9] 
       (.C(ap_clk),
        .CE(\i_data_V_user_V_0_payload_A[127]_i_1_n_0 ),
        .D(i_data_TUSER[9]),
        .Q(i_data_V_user_V_0_payload_A[9]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hA2)) 
    \i_data_V_user_V_0_payload_B[127]_i_1 
       (.I0(i_data_V_user_V_0_sel_wr),
        .I1(\i_data_V_user_V_0_state_reg_n_0_[0] ),
        .I2(i_data_V_user_V_0_ack_in),
        .O(i_data_V_user_V_0_load_B));
  FDRE \i_data_V_user_V_0_payload_B_reg[0] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[0]),
        .Q(i_data_V_user_V_0_payload_B[0]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[100] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[100]),
        .Q(i_data_V_user_V_0_payload_B[100]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[101] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[101]),
        .Q(i_data_V_user_V_0_payload_B[101]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[102] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[102]),
        .Q(i_data_V_user_V_0_payload_B[102]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[103] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[103]),
        .Q(i_data_V_user_V_0_payload_B[103]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[104] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[104]),
        .Q(i_data_V_user_V_0_payload_B[104]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[105] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[105]),
        .Q(i_data_V_user_V_0_payload_B[105]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[106] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[106]),
        .Q(i_data_V_user_V_0_payload_B[106]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[107] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[107]),
        .Q(i_data_V_user_V_0_payload_B[107]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[108] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[108]),
        .Q(i_data_V_user_V_0_payload_B[108]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[109] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[109]),
        .Q(i_data_V_user_V_0_payload_B[109]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[10] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[10]),
        .Q(i_data_V_user_V_0_payload_B[10]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[110] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[110]),
        .Q(i_data_V_user_V_0_payload_B[110]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[111] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[111]),
        .Q(i_data_V_user_V_0_payload_B[111]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[112] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[112]),
        .Q(i_data_V_user_V_0_payload_B[112]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[113] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[113]),
        .Q(i_data_V_user_V_0_payload_B[113]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[114] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[114]),
        .Q(i_data_V_user_V_0_payload_B[114]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[115] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[115]),
        .Q(i_data_V_user_V_0_payload_B[115]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[116] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[116]),
        .Q(i_data_V_user_V_0_payload_B[116]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[117] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[117]),
        .Q(i_data_V_user_V_0_payload_B[117]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[118] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[118]),
        .Q(i_data_V_user_V_0_payload_B[118]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[119] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[119]),
        .Q(i_data_V_user_V_0_payload_B[119]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[11] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[11]),
        .Q(i_data_V_user_V_0_payload_B[11]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[120] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[120]),
        .Q(i_data_V_user_V_0_payload_B[120]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[121] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[121]),
        .Q(i_data_V_user_V_0_payload_B[121]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[122] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[122]),
        .Q(i_data_V_user_V_0_payload_B[122]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[123] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[123]),
        .Q(i_data_V_user_V_0_payload_B[123]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[124] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[124]),
        .Q(i_data_V_user_V_0_payload_B[124]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[125] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[125]),
        .Q(i_data_V_user_V_0_payload_B[125]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[126] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[126]),
        .Q(i_data_V_user_V_0_payload_B[126]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[127] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[127]),
        .Q(i_data_V_user_V_0_payload_B[127]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[12] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[12]),
        .Q(i_data_V_user_V_0_payload_B[12]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[13] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[13]),
        .Q(i_data_V_user_V_0_payload_B[13]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[14] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[14]),
        .Q(i_data_V_user_V_0_payload_B[14]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[15] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[15]),
        .Q(i_data_V_user_V_0_payload_B[15]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[16] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[16]),
        .Q(i_data_V_user_V_0_payload_B[16]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[17] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[17]),
        .Q(i_data_V_user_V_0_payload_B[17]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[18] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[18]),
        .Q(i_data_V_user_V_0_payload_B[18]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[19] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[19]),
        .Q(i_data_V_user_V_0_payload_B[19]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[1] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[1]),
        .Q(i_data_V_user_V_0_payload_B[1]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[20] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[20]),
        .Q(i_data_V_user_V_0_payload_B[20]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[21] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[21]),
        .Q(i_data_V_user_V_0_payload_B[21]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[22] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[22]),
        .Q(i_data_V_user_V_0_payload_B[22]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[23] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[23]),
        .Q(i_data_V_user_V_0_payload_B[23]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[24] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[24]),
        .Q(i_data_V_user_V_0_payload_B[24]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[25] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[25]),
        .Q(i_data_V_user_V_0_payload_B[25]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[26] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[26]),
        .Q(i_data_V_user_V_0_payload_B[26]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[27] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[27]),
        .Q(i_data_V_user_V_0_payload_B[27]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[28] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[28]),
        .Q(i_data_V_user_V_0_payload_B[28]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[29] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[29]),
        .Q(i_data_V_user_V_0_payload_B[29]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[2] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[2]),
        .Q(i_data_V_user_V_0_payload_B[2]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[30] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[30]),
        .Q(i_data_V_user_V_0_payload_B[30]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[31] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[31]),
        .Q(i_data_V_user_V_0_payload_B[31]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[32] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[32]),
        .Q(i_data_V_user_V_0_payload_B[32]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[33] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[33]),
        .Q(i_data_V_user_V_0_payload_B[33]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[34] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[34]),
        .Q(i_data_V_user_V_0_payload_B[34]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[35] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[35]),
        .Q(i_data_V_user_V_0_payload_B[35]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[36] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[36]),
        .Q(i_data_V_user_V_0_payload_B[36]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[37] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[37]),
        .Q(i_data_V_user_V_0_payload_B[37]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[38] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[38]),
        .Q(i_data_V_user_V_0_payload_B[38]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[39] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[39]),
        .Q(i_data_V_user_V_0_payload_B[39]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[3] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[3]),
        .Q(i_data_V_user_V_0_payload_B[3]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[40] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[40]),
        .Q(i_data_V_user_V_0_payload_B[40]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[41] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[41]),
        .Q(i_data_V_user_V_0_payload_B[41]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[42] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[42]),
        .Q(i_data_V_user_V_0_payload_B[42]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[43] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[43]),
        .Q(i_data_V_user_V_0_payload_B[43]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[44] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[44]),
        .Q(i_data_V_user_V_0_payload_B[44]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[45] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[45]),
        .Q(i_data_V_user_V_0_payload_B[45]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[46] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[46]),
        .Q(i_data_V_user_V_0_payload_B[46]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[47] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[47]),
        .Q(i_data_V_user_V_0_payload_B[47]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[48] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[48]),
        .Q(i_data_V_user_V_0_payload_B[48]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[49] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[49]),
        .Q(i_data_V_user_V_0_payload_B[49]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[4] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[4]),
        .Q(i_data_V_user_V_0_payload_B[4]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[50] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[50]),
        .Q(i_data_V_user_V_0_payload_B[50]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[51] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[51]),
        .Q(i_data_V_user_V_0_payload_B[51]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[52] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[52]),
        .Q(i_data_V_user_V_0_payload_B[52]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[53] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[53]),
        .Q(i_data_V_user_V_0_payload_B[53]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[54] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[54]),
        .Q(i_data_V_user_V_0_payload_B[54]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[55] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[55]),
        .Q(i_data_V_user_V_0_payload_B[55]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[56] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[56]),
        .Q(i_data_V_user_V_0_payload_B[56]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[57] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[57]),
        .Q(i_data_V_user_V_0_payload_B[57]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[58] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[58]),
        .Q(i_data_V_user_V_0_payload_B[58]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[59] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[59]),
        .Q(i_data_V_user_V_0_payload_B[59]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[5] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[5]),
        .Q(i_data_V_user_V_0_payload_B[5]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[60] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[60]),
        .Q(i_data_V_user_V_0_payload_B[60]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[61] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[61]),
        .Q(i_data_V_user_V_0_payload_B[61]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[62] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[62]),
        .Q(i_data_V_user_V_0_payload_B[62]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[63] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[63]),
        .Q(i_data_V_user_V_0_payload_B[63]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[65] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[65]),
        .Q(i_data_V_user_V_0_payload_B[65]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[66] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[66]),
        .Q(i_data_V_user_V_0_payload_B[66]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[67] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[67]),
        .Q(i_data_V_user_V_0_payload_B[67]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[68] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[68]),
        .Q(i_data_V_user_V_0_payload_B[68]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[69] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[69]),
        .Q(i_data_V_user_V_0_payload_B[69]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[6] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[6]),
        .Q(i_data_V_user_V_0_payload_B[6]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[70] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[70]),
        .Q(i_data_V_user_V_0_payload_B[70]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[71] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[71]),
        .Q(i_data_V_user_V_0_payload_B[71]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[72] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[72]),
        .Q(i_data_V_user_V_0_payload_B[72]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[73] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[73]),
        .Q(i_data_V_user_V_0_payload_B[73]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[74] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[74]),
        .Q(i_data_V_user_V_0_payload_B[74]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[75] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[75]),
        .Q(i_data_V_user_V_0_payload_B[75]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[76] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[76]),
        .Q(i_data_V_user_V_0_payload_B[76]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[77] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[77]),
        .Q(i_data_V_user_V_0_payload_B[77]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[78] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[78]),
        .Q(i_data_V_user_V_0_payload_B[78]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[79] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[79]),
        .Q(i_data_V_user_V_0_payload_B[79]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[7] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[7]),
        .Q(i_data_V_user_V_0_payload_B[7]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[80] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[80]),
        .Q(i_data_V_user_V_0_payload_B[80]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[81] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[81]),
        .Q(i_data_V_user_V_0_payload_B[81]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[82] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[82]),
        .Q(i_data_V_user_V_0_payload_B[82]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[83] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[83]),
        .Q(i_data_V_user_V_0_payload_B[83]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[84] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[84]),
        .Q(i_data_V_user_V_0_payload_B[84]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[85] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[85]),
        .Q(i_data_V_user_V_0_payload_B[85]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[86] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[86]),
        .Q(i_data_V_user_V_0_payload_B[86]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[87] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[87]),
        .Q(i_data_V_user_V_0_payload_B[87]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[88] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[88]),
        .Q(i_data_V_user_V_0_payload_B[88]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[89] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[89]),
        .Q(i_data_V_user_V_0_payload_B[89]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[8] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[8]),
        .Q(i_data_V_user_V_0_payload_B[8]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[90] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[90]),
        .Q(i_data_V_user_V_0_payload_B[90]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[91] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[91]),
        .Q(i_data_V_user_V_0_payload_B[91]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[92] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[92]),
        .Q(i_data_V_user_V_0_payload_B[92]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[93] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[93]),
        .Q(i_data_V_user_V_0_payload_B[93]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[94] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[94]),
        .Q(i_data_V_user_V_0_payload_B[94]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[95] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[95]),
        .Q(i_data_V_user_V_0_payload_B[95]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[96] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[96]),
        .Q(i_data_V_user_V_0_payload_B[96]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[97] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[97]),
        .Q(i_data_V_user_V_0_payload_B[97]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[98] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[98]),
        .Q(i_data_V_user_V_0_payload_B[98]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[99] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[99]),
        .Q(i_data_V_user_V_0_payload_B[99]),
        .R(1'b0));
  FDRE \i_data_V_user_V_0_payload_B_reg[9] 
       (.C(ap_clk),
        .CE(i_data_V_user_V_0_load_B),
        .D(i_data_TUSER[9]),
        .Q(i_data_V_user_V_0_payload_B[9]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h78)) 
    i_data_V_user_V_0_sel_rd_i_1
       (.I0(p_222_in),
        .I1(\i_data_V_user_V_0_state_reg_n_0_[0] ),
        .I2(i_data_V_user_V_0_sel),
        .O(i_data_V_user_V_0_sel_rd_i_1_n_0));
  (* ORIG_CELL_NAME = "i_data_V_user_V_0_sel_rd_reg" *) 
  FDRE #(
    .INIT(1'b0)) 
    i_data_V_user_V_0_sel_rd_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(i_data_V_user_V_0_sel_rd_i_1_n_0),
        .Q(i_data_V_user_V_0_sel),
        .R(ap_rst));
  (* ORIG_CELL_NAME = "i_data_V_user_V_0_sel_rd_reg" *) 
  FDRE #(
    .INIT(1'b0)) 
    i_data_V_user_V_0_sel_rd_reg_rep
       (.C(ap_clk),
        .CE(1'b1),
        .D(i_data_V_user_V_0_sel_rd_rep_i_1_n_0),
        .Q(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .R(ap_rst));
  LUT3 #(
    .INIT(8'h78)) 
    i_data_V_user_V_0_sel_rd_rep_i_1
       (.I0(p_222_in),
        .I1(\i_data_V_user_V_0_state_reg_n_0_[0] ),
        .I2(i_data_V_user_V_0_sel),
        .O(i_data_V_user_V_0_sel_rd_rep_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair120" *) 
  LUT3 #(
    .INIT(8'h78)) 
    i_data_V_user_V_0_sel_wr_i_1
       (.I0(i_data_TVALID),
        .I1(i_data_V_user_V_0_ack_in),
        .I2(i_data_V_user_V_0_sel_wr),
        .O(i_data_V_user_V_0_sel_wr_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    i_data_V_user_V_0_sel_wr_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(i_data_V_user_V_0_sel_wr_i_1_n_0),
        .Q(i_data_V_user_V_0_sel_wr),
        .R(ap_rst));
  LUT5 #(
    .INIT(32'hA2AAA000)) 
    \i_data_V_user_V_0_state[0]_i_1 
       (.I0(ap_rst_n),
        .I1(p_222_in),
        .I2(i_data_TVALID),
        .I3(i_data_V_user_V_0_ack_in),
        .I4(\i_data_V_user_V_0_state_reg_n_0_[0] ),
        .O(\i_data_V_user_V_0_state[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hF3FB)) 
    \i_data_V_user_V_0_state[1]_i_1 
       (.I0(i_data_V_user_V_0_ack_in),
        .I1(\i_data_V_user_V_0_state_reg_n_0_[0] ),
        .I2(p_222_in),
        .I3(i_data_TVALID),
        .O(\i_data_V_user_V_0_state[1]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \i_data_V_user_V_0_state_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\i_data_V_user_V_0_state[0]_i_1_n_0 ),
        .Q(\i_data_V_user_V_0_state_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \i_data_V_user_V_0_state_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\i_data_V_user_V_0_state[1]_i_1_n_0 ),
        .Q(i_data_V_user_V_0_ack_in),
        .R(ap_rst));
  (* SOFT_HLUTNM = "soft_lutpair111" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \in_a_pulse_2_reg_662[0]_i_1 
       (.I0(\in_a_pulse_fu_86_reg_n_0_[0] ),
        .I1(tmp_1_fu_327_p2),
        .O(\in_a_pulse_2_reg_662[0]_i_1_n_0 ));
  FDRE \in_a_pulse_2_reg_662_reg[0] 
       (.C(ap_clk),
        .CE(\brmerge_reg_672[0]_i_1_n_0 ),
        .D(\in_a_pulse_2_reg_662[0]_i_1_n_0 ),
        .Q(in_a_pulse_2_reg_662),
        .R(1'b0));
  FDRE \in_a_pulse_fu_86_reg[0] 
       (.C(ap_clk),
        .CE(in_a_xfer_bundle_fu_90),
        .D(grp_handle_header_fu_175_n_77),
        .Q(\in_a_pulse_fu_86_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \in_a_pulse_load_reg_622_reg[0] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\in_a_pulse_fu_86_reg_n_0_[0] ),
        .Q(in_a_pulse_load_reg_622),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair111" *) 
  LUT3 #(
    .INIT(8'h2A)) 
    \in_a_xfer_bundle_3_reg_657[0]_i_1 
       (.I0(\in_a_xfer_bundle_fu_90_reg_n_0_[0] ),
        .I1(tmp_1_fu_327_p2),
        .I2(\break_after_pulse_fu_106_reg_n_0_[0] ),
        .O(\in_a_xfer_bundle_3_reg_657[0]_i_1_n_0 ));
  FDRE \in_a_xfer_bundle_3_reg_657_reg[0] 
       (.C(ap_clk),
        .CE(\brmerge_reg_672[0]_i_1_n_0 ),
        .D(\in_a_xfer_bundle_3_reg_657[0]_i_1_n_0 ),
        .Q(in_a_xfer_bundle_3_reg_657),
        .R(1'b0));
  FDRE \in_a_xfer_bundle_fu_90_reg[0] 
       (.C(ap_clk),
        .CE(in_a_xfer_bundle_fu_90),
        .D(grp_handle_header_fu_175_n_76),
        .Q(\in_a_xfer_bundle_fu_90_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \in_a_xfer_bundle_loa_reg_627_reg[0] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\in_a_xfer_bundle_fu_90_reg_n_0_[0] ),
        .Q(in_a_xfer_bundle_loa_reg_627),
        .R(1'b0));
  FDRE \num_samples_fu_110_reg[0] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[0]),
        .Q(\num_samples_fu_110_reg_n_0_[0] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[10] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[10]),
        .Q(\num_samples_fu_110_reg_n_0_[10] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[11] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[11]),
        .Q(\num_samples_fu_110_reg_n_0_[11] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[12] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[12]),
        .Q(\num_samples_fu_110_reg_n_0_[12] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[13] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[13]),
        .Q(\num_samples_fu_110_reg_n_0_[13] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[14] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[14]),
        .Q(\num_samples_fu_110_reg_n_0_[14] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[15] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[15]),
        .Q(\num_samples_fu_110_reg_n_0_[15] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[16] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[16]),
        .Q(\num_samples_fu_110_reg_n_0_[16] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[17] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[17]),
        .Q(\num_samples_fu_110_reg_n_0_[17] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[18] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[18]),
        .Q(\num_samples_fu_110_reg_n_0_[18] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[19] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[19]),
        .Q(\num_samples_fu_110_reg_n_0_[19] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[1] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[1]),
        .Q(\num_samples_fu_110_reg_n_0_[1] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[20] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[20]),
        .Q(\num_samples_fu_110_reg_n_0_[20] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[21] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[21]),
        .Q(\num_samples_fu_110_reg_n_0_[21] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[22] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[22]),
        .Q(\num_samples_fu_110_reg_n_0_[22] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[23] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[23]),
        .Q(\num_samples_fu_110_reg_n_0_[23] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[24] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[24]),
        .Q(\num_samples_fu_110_reg_n_0_[24] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[25] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[25]),
        .Q(\num_samples_fu_110_reg_n_0_[25] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[26] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[26]),
        .Q(\num_samples_fu_110_reg_n_0_[26] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[27] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[27]),
        .Q(\num_samples_fu_110_reg_n_0_[27] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[28] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[28]),
        .Q(\num_samples_fu_110_reg_n_0_[28] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[29] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[29]),
        .Q(\num_samples_fu_110_reg_n_0_[29] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[2] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[2]),
        .Q(\num_samples_fu_110_reg_n_0_[2] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[30] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[30]),
        .Q(\num_samples_fu_110_reg_n_0_[30] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[31] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[31]),
        .Q(\num_samples_fu_110_reg_n_0_[31] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[3] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[3]),
        .Q(\num_samples_fu_110_reg_n_0_[3] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[4] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[4]),
        .Q(\num_samples_fu_110_reg_n_0_[4] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[5] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[5]),
        .Q(\num_samples_fu_110_reg_n_0_[5] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[6] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[6]),
        .Q(\num_samples_fu_110_reg_n_0_[6] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[7] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[7]),
        .Q(\num_samples_fu_110_reg_n_0_[7] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[8] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[8]),
        .Q(\num_samples_fu_110_reg_n_0_[8] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_fu_110_reg[9] 
       (.C(ap_clk),
        .CE(num_samples_fu_110),
        .D(ap_return_6[9]),
        .Q(\num_samples_fu_110_reg_n_0_[9] ),
        .R(grp_handle_header_fu_175_n_106));
  FDRE \num_samples_load_reg_652_reg[0] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[0] ),
        .Q(num_samples_load_reg_652[0]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[10] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[10] ),
        .Q(num_samples_load_reg_652[10]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[11] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[11] ),
        .Q(num_samples_load_reg_652[11]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[12] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[12] ),
        .Q(num_samples_load_reg_652[12]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[13] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[13] ),
        .Q(num_samples_load_reg_652[13]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[14] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[14] ),
        .Q(num_samples_load_reg_652[14]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[15] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[15] ),
        .Q(num_samples_load_reg_652[15]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[16] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[16] ),
        .Q(num_samples_load_reg_652[16]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[17] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[17] ),
        .Q(num_samples_load_reg_652[17]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[18] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[18] ),
        .Q(num_samples_load_reg_652[18]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[19] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[19] ),
        .Q(num_samples_load_reg_652[19]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[1] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[1] ),
        .Q(num_samples_load_reg_652[1]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[20] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[20] ),
        .Q(num_samples_load_reg_652[20]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[21] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[21] ),
        .Q(num_samples_load_reg_652[21]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[22] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[22] ),
        .Q(num_samples_load_reg_652[22]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[23] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[23] ),
        .Q(num_samples_load_reg_652[23]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[24] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[24] ),
        .Q(num_samples_load_reg_652[24]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[25] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[25] ),
        .Q(num_samples_load_reg_652[25]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[26] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[26] ),
        .Q(num_samples_load_reg_652[26]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[27] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[27] ),
        .Q(num_samples_load_reg_652[27]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[28] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[28] ),
        .Q(num_samples_load_reg_652[28]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[29] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[29] ),
        .Q(num_samples_load_reg_652[29]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[2] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[2] ),
        .Q(num_samples_load_reg_652[2]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[30] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[30] ),
        .Q(num_samples_load_reg_652[30]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[31] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[31] ),
        .Q(num_samples_load_reg_652[31]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[3] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[3] ),
        .Q(num_samples_load_reg_652[3]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[4] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[4] ),
        .Q(num_samples_load_reg_652[4]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[5] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[5] ),
        .Q(num_samples_load_reg_652[5]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[6] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[6] ),
        .Q(num_samples_load_reg_652[6]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[7] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[7] ),
        .Q(num_samples_load_reg_652[7]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[8] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[8] ),
        .Q(num_samples_load_reg_652[8]),
        .R(1'b0));
  FDRE \num_samples_load_reg_652_reg[9] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\num_samples_fu_110_reg_n_0_[9] ),
        .Q(num_samples_load_reg_652[9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair200" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[0]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[0]),
        .I1(o_data_V_data_V_1_payload_A[0]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[0]));
  (* SOFT_HLUTNM = "soft_lutpair211" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[10]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[10]),
        .I1(o_data_V_data_V_1_payload_A[10]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[10]));
  (* SOFT_HLUTNM = "soft_lutpair212" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[11]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[11]),
        .I1(o_data_V_data_V_1_payload_A[11]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[11]));
  (* SOFT_HLUTNM = "soft_lutpair212" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[12]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[12]),
        .I1(o_data_V_data_V_1_payload_A[12]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[12]));
  (* SOFT_HLUTNM = "soft_lutpair213" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[13]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[13]),
        .I1(o_data_V_data_V_1_payload_A[13]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[13]));
  (* SOFT_HLUTNM = "soft_lutpair213" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[14]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[14]),
        .I1(o_data_V_data_V_1_payload_A[14]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[14]));
  (* SOFT_HLUTNM = "soft_lutpair214" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[15]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[15]),
        .I1(o_data_V_data_V_1_payload_A[15]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[15]));
  (* SOFT_HLUTNM = "soft_lutpair214" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[16]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[16]),
        .I1(o_data_V_data_V_1_payload_A[16]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[16]));
  (* SOFT_HLUTNM = "soft_lutpair215" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[17]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[17]),
        .I1(o_data_V_data_V_1_payload_A[17]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[17]));
  (* SOFT_HLUTNM = "soft_lutpair215" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[18]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[18]),
        .I1(o_data_V_data_V_1_payload_A[18]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[18]));
  (* SOFT_HLUTNM = "soft_lutpair216" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[19]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[19]),
        .I1(o_data_V_data_V_1_payload_A[19]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[19]));
  (* SOFT_HLUTNM = "soft_lutpair207" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[1]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[1]),
        .I1(o_data_V_data_V_1_payload_A[1]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[1]));
  (* SOFT_HLUTNM = "soft_lutpair216" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[20]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[20]),
        .I1(o_data_V_data_V_1_payload_A[20]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[20]));
  (* SOFT_HLUTNM = "soft_lutpair217" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[21]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[21]),
        .I1(o_data_V_data_V_1_payload_A[21]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[21]));
  (* SOFT_HLUTNM = "soft_lutpair217" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[22]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[22]),
        .I1(o_data_V_data_V_1_payload_A[22]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[22]));
  (* SOFT_HLUTNM = "soft_lutpair218" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[23]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[23]),
        .I1(o_data_V_data_V_1_payload_A[23]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[23]));
  (* SOFT_HLUTNM = "soft_lutpair218" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[24]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[24]),
        .I1(o_data_V_data_V_1_payload_A[24]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[24]));
  (* SOFT_HLUTNM = "soft_lutpair219" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[25]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[25]),
        .I1(o_data_V_data_V_1_payload_A[25]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[25]));
  (* SOFT_HLUTNM = "soft_lutpair200" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[26]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[26]),
        .I1(o_data_V_data_V_1_payload_A[26]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[26]));
  (* SOFT_HLUTNM = "soft_lutpair219" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[27]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[27]),
        .I1(o_data_V_data_V_1_payload_A[27]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[27]));
  (* SOFT_HLUTNM = "soft_lutpair221" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[28]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[28]),
        .I1(o_data_V_data_V_1_payload_A[28]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[28]));
  (* SOFT_HLUTNM = "soft_lutpair221" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[29]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[29]),
        .I1(o_data_V_data_V_1_payload_A[29]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[29]));
  (* SOFT_HLUTNM = "soft_lutpair207" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[2]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[2]),
        .I1(o_data_V_data_V_1_payload_A[2]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[2]));
  (* SOFT_HLUTNM = "soft_lutpair222" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[30]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[30]),
        .I1(o_data_V_data_V_1_payload_A[30]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[30]));
  (* SOFT_HLUTNM = "soft_lutpair222" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[31]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[31]),
        .I1(o_data_V_data_V_1_payload_A[31]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[31]));
  (* SOFT_HLUTNM = "soft_lutpair208" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[3]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[3]),
        .I1(o_data_V_data_V_1_payload_A[3]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[3]));
  (* SOFT_HLUTNM = "soft_lutpair208" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[4]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[4]),
        .I1(o_data_V_data_V_1_payload_A[4]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[4]));
  (* SOFT_HLUTNM = "soft_lutpair209" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[5]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[5]),
        .I1(o_data_V_data_V_1_payload_A[5]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[5]));
  (* SOFT_HLUTNM = "soft_lutpair209" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[6]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[6]),
        .I1(o_data_V_data_V_1_payload_A[6]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[6]));
  (* SOFT_HLUTNM = "soft_lutpair210" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[7]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[7]),
        .I1(o_data_V_data_V_1_payload_A[7]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[7]));
  (* SOFT_HLUTNM = "soft_lutpair210" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[8]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[8]),
        .I1(o_data_V_data_V_1_payload_A[8]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[8]));
  (* SOFT_HLUTNM = "soft_lutpair211" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TDATA[9]_INST_0 
       (.I0(o_data_V_data_V_1_payload_B[9]),
        .I1(o_data_V_data_V_1_payload_A[9]),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_TDATA[9]));
  LUT3 #(
    .INIT(8'hB8)) 
    \o_data_TDEST[0]_INST_0 
       (.I0(o_data_V_dest_V_1_payload_B),
        .I1(o_data_V_dest_V_1_sel),
        .I2(o_data_V_dest_V_1_payload_A),
        .O(o_data_TDEST));
  (* SOFT_HLUTNM = "soft_lutpair121" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \o_data_TID[0]_INST_0 
       (.I0(o_data_V_id_V_1_payload_B),
        .I1(o_data_V_id_V_1_sel),
        .I2(o_data_V_id_V_1_payload_A),
        .O(o_data_TID));
  (* SOFT_HLUTNM = "soft_lutpair203" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \o_data_TKEEP[0]_INST_0 
       (.I0(o_data_V_keep_V_1_payload_B[0]),
        .I1(o_data_V_keep_V_1_sel),
        .I2(o_data_V_keep_V_1_payload_A[0]),
        .O(o_data_TKEEP[0]));
  (* SOFT_HLUTNM = "soft_lutpair203" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \o_data_TKEEP[1]_INST_0 
       (.I0(o_data_V_keep_V_1_payload_B[1]),
        .I1(o_data_V_keep_V_1_sel),
        .I2(o_data_V_keep_V_1_payload_A[1]),
        .O(o_data_TKEEP[1]));
  (* SOFT_HLUTNM = "soft_lutpair204" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \o_data_TKEEP[2]_INST_0 
       (.I0(o_data_V_keep_V_1_payload_B[2]),
        .I1(o_data_V_keep_V_1_sel),
        .I2(o_data_V_keep_V_1_payload_A[2]),
        .O(o_data_TKEEP[2]));
  (* SOFT_HLUTNM = "soft_lutpair204" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \o_data_TKEEP[3]_INST_0 
       (.I0(o_data_V_keep_V_1_payload_B[3]),
        .I1(o_data_V_keep_V_1_sel),
        .I2(o_data_V_keep_V_1_payload_A[3]),
        .O(o_data_TKEEP[3]));
  (* SOFT_HLUTNM = "soft_lutpair122" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \o_data_TLAST[0]_INST_0 
       (.I0(o_data_V_last_V_1_payload_B),
        .I1(o_data_V_last_V_1_sel),
        .I2(o_data_V_last_V_1_payload_A),
        .O(o_data_TLAST));
  (* SOFT_HLUTNM = "soft_lutpair205" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \o_data_TSTRB[0]_INST_0 
       (.I0(o_data_V_strb_V_1_payload_B[0]),
        .I1(o_data_V_strb_V_1_sel),
        .I2(o_data_V_strb_V_1_payload_A[0]),
        .O(o_data_TSTRB[0]));
  (* SOFT_HLUTNM = "soft_lutpair205" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \o_data_TSTRB[1]_INST_0 
       (.I0(o_data_V_strb_V_1_payload_B[1]),
        .I1(o_data_V_strb_V_1_sel),
        .I2(o_data_V_strb_V_1_payload_A[1]),
        .O(o_data_TSTRB[1]));
  (* SOFT_HLUTNM = "soft_lutpair206" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \o_data_TSTRB[2]_INST_0 
       (.I0(o_data_V_strb_V_1_payload_B[2]),
        .I1(o_data_V_strb_V_1_sel),
        .I2(o_data_V_strb_V_1_payload_A[2]),
        .O(o_data_TSTRB[2]));
  (* SOFT_HLUTNM = "soft_lutpair206" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \o_data_TSTRB[3]_INST_0 
       (.I0(o_data_V_strb_V_1_payload_B[3]),
        .I1(o_data_V_strb_V_1_sel),
        .I2(o_data_V_strb_V_1_payload_A[3]),
        .O(o_data_TSTRB[3]));
  (* SOFT_HLUTNM = "soft_lutpair199" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[0]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[0]),
        .I1(o_data_V_user_V_1_payload_A[0]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[0]));
  (* SOFT_HLUTNM = "soft_lutpair271" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[100]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[100]),
        .I1(o_data_V_user_V_1_payload_A[100]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[100]));
  (* SOFT_HLUTNM = "soft_lutpair271" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[101]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[101]),
        .I1(o_data_V_user_V_1_payload_A[101]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[101]));
  (* SOFT_HLUTNM = "soft_lutpair272" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[102]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[102]),
        .I1(o_data_V_user_V_1_payload_A[102]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[102]));
  (* SOFT_HLUTNM = "soft_lutpair272" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[103]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[103]),
        .I1(o_data_V_user_V_1_payload_A[103]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[103]));
  (* SOFT_HLUTNM = "soft_lutpair273" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[104]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[104]),
        .I1(o_data_V_user_V_1_payload_A[104]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[104]));
  (* SOFT_HLUTNM = "soft_lutpair273" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[105]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[105]),
        .I1(o_data_V_user_V_1_payload_A[105]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[105]));
  (* SOFT_HLUTNM = "soft_lutpair274" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[106]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[106]),
        .I1(o_data_V_user_V_1_payload_A[106]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[106]));
  (* SOFT_HLUTNM = "soft_lutpair265" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[107]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[107]),
        .I1(o_data_V_user_V_1_payload_A[107]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[107]));
  (* SOFT_HLUTNM = "soft_lutpair269" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[108]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[108]),
        .I1(o_data_V_user_V_1_payload_A[108]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[108]));
  (* SOFT_HLUTNM = "soft_lutpair274" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[109]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[109]),
        .I1(o_data_V_user_V_1_payload_A[109]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[109]));
  (* SOFT_HLUTNM = "soft_lutpair226" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[10]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[10]),
        .I1(o_data_V_user_V_1_payload_A[10]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[10]));
  (* SOFT_HLUTNM = "soft_lutpair275" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[110]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[110]),
        .I1(o_data_V_user_V_1_payload_A[110]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[110]));
  (* SOFT_HLUTNM = "soft_lutpair275" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[111]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[111]),
        .I1(o_data_V_user_V_1_payload_A[111]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[111]));
  (* SOFT_HLUTNM = "soft_lutpair276" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[112]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[112]),
        .I1(o_data_V_user_V_1_payload_A[112]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[112]));
  (* SOFT_HLUTNM = "soft_lutpair277" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[113]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[113]),
        .I1(o_data_V_user_V_1_payload_A[113]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[113]));
  (* SOFT_HLUTNM = "soft_lutpair278" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[114]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[114]),
        .I1(o_data_V_user_V_1_payload_A[114]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[114]));
  (* SOFT_HLUTNM = "soft_lutpair278" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[115]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[115]),
        .I1(o_data_V_user_V_1_payload_A[115]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[115]));
  (* SOFT_HLUTNM = "soft_lutpair279" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[116]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[116]),
        .I1(o_data_V_user_V_1_payload_A[116]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[116]));
  (* SOFT_HLUTNM = "soft_lutpair276" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[117]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[117]),
        .I1(o_data_V_user_V_1_payload_A[117]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[117]));
  (* SOFT_HLUTNM = "soft_lutpair277" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[118]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[118]),
        .I1(o_data_V_user_V_1_payload_A[118]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[118]));
  (* SOFT_HLUTNM = "soft_lutpair279" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[119]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[119]),
        .I1(o_data_V_user_V_1_payload_A[119]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[119]));
  (* SOFT_HLUTNM = "soft_lutpair226" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[11]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[11]),
        .I1(o_data_V_user_V_1_payload_A[11]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[11]));
  (* SOFT_HLUTNM = "soft_lutpair280" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[120]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[120]),
        .I1(o_data_V_user_V_1_payload_A[120]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[120]));
  (* SOFT_HLUTNM = "soft_lutpair281" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[121]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[121]),
        .I1(o_data_V_user_V_1_payload_A[121]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[121]));
  (* SOFT_HLUTNM = "soft_lutpair280" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[122]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[122]),
        .I1(o_data_V_user_V_1_payload_A[122]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[122]));
  (* SOFT_HLUTNM = "soft_lutpair281" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[123]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[123]),
        .I1(o_data_V_user_V_1_payload_A[123]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[123]));
  (* SOFT_HLUTNM = "soft_lutpair282" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[124]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[124]),
        .I1(o_data_V_user_V_1_payload_A[124]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[124]));
  (* SOFT_HLUTNM = "soft_lutpair282" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[125]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[125]),
        .I1(o_data_V_user_V_1_payload_A[125]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[125]));
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[126]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[126]),
        .I1(o_data_V_user_V_1_payload_A[126]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[126]));
  (* SOFT_HLUTNM = "soft_lutpair266" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[127]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[127]),
        .I1(o_data_V_user_V_1_payload_A[127]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[127]));
  (* SOFT_HLUTNM = "soft_lutpair227" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[12]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[12]),
        .I1(o_data_V_user_V_1_payload_A[12]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[12]));
  (* SOFT_HLUTNM = "soft_lutpair227" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[13]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[13]),
        .I1(o_data_V_user_V_1_payload_A[13]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[13]));
  (* SOFT_HLUTNM = "soft_lutpair228" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[14]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[14]),
        .I1(o_data_V_user_V_1_payload_A[14]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[14]));
  (* SOFT_HLUTNM = "soft_lutpair228" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[15]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[15]),
        .I1(o_data_V_user_V_1_payload_A[15]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[15]));
  (* SOFT_HLUTNM = "soft_lutpair229" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[16]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[16]),
        .I1(o_data_V_user_V_1_payload_A[16]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[16]));
  (* SOFT_HLUTNM = "soft_lutpair229" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[17]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[17]),
        .I1(o_data_V_user_V_1_payload_A[17]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[17]));
  (* SOFT_HLUTNM = "soft_lutpair230" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[18]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[18]),
        .I1(o_data_V_user_V_1_payload_A[18]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[18]));
  (* SOFT_HLUTNM = "soft_lutpair230" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[19]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[19]),
        .I1(o_data_V_user_V_1_payload_A[19]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[19]));
  (* SOFT_HLUTNM = "soft_lutpair201" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[1]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[1]),
        .I1(o_data_V_user_V_1_payload_A[1]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[1]));
  (* SOFT_HLUTNM = "soft_lutpair231" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[20]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[20]),
        .I1(o_data_V_user_V_1_payload_A[20]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[20]));
  (* SOFT_HLUTNM = "soft_lutpair231" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[21]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[21]),
        .I1(o_data_V_user_V_1_payload_A[21]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[21]));
  (* SOFT_HLUTNM = "soft_lutpair232" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[22]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[22]),
        .I1(o_data_V_user_V_1_payload_A[22]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[22]));
  (* SOFT_HLUTNM = "soft_lutpair232" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[23]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[23]),
        .I1(o_data_V_user_V_1_payload_A[23]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[23]));
  (* SOFT_HLUTNM = "soft_lutpair233" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[24]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[24]),
        .I1(o_data_V_user_V_1_payload_A[24]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[24]));
  (* SOFT_HLUTNM = "soft_lutpair233" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[25]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[25]),
        .I1(o_data_V_user_V_1_payload_A[25]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[25]));
  (* SOFT_HLUTNM = "soft_lutpair234" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[26]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[26]),
        .I1(o_data_V_user_V_1_payload_A[26]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[26]));
  (* SOFT_HLUTNM = "soft_lutpair234" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[27]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[27]),
        .I1(o_data_V_user_V_1_payload_A[27]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[27]));
  (* SOFT_HLUTNM = "soft_lutpair235" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[28]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[28]),
        .I1(o_data_V_user_V_1_payload_A[28]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[28]));
  (* SOFT_HLUTNM = "soft_lutpair235" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[29]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[29]),
        .I1(o_data_V_user_V_1_payload_A[29]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[29]));
  (* SOFT_HLUTNM = "soft_lutpair202" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[2]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[2]),
        .I1(o_data_V_user_V_1_payload_A[2]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[2]));
  (* SOFT_HLUTNM = "soft_lutpair236" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[30]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[30]),
        .I1(o_data_V_user_V_1_payload_A[30]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[30]));
  (* SOFT_HLUTNM = "soft_lutpair236" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[31]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[31]),
        .I1(o_data_V_user_V_1_payload_A[31]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[31]));
  (* SOFT_HLUTNM = "soft_lutpair237" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[32]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[32]),
        .I1(o_data_V_user_V_1_payload_A[32]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[32]));
  (* SOFT_HLUTNM = "soft_lutpair237" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[33]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[33]),
        .I1(o_data_V_user_V_1_payload_A[33]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[33]));
  (* SOFT_HLUTNM = "soft_lutpair238" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[34]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[34]),
        .I1(o_data_V_user_V_1_payload_A[34]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[34]));
  (* SOFT_HLUTNM = "soft_lutpair238" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[35]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[35]),
        .I1(o_data_V_user_V_1_payload_A[35]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[35]));
  (* SOFT_HLUTNM = "soft_lutpair239" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[36]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[36]),
        .I1(o_data_V_user_V_1_payload_A[36]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[36]));
  (* SOFT_HLUTNM = "soft_lutpair239" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[37]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[37]),
        .I1(o_data_V_user_V_1_payload_A[37]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[37]));
  (* SOFT_HLUTNM = "soft_lutpair240" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[38]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[38]),
        .I1(o_data_V_user_V_1_payload_A[38]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[38]));
  (* SOFT_HLUTNM = "soft_lutpair240" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[39]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[39]),
        .I1(o_data_V_user_V_1_payload_A[39]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[39]));
  (* SOFT_HLUTNM = "soft_lutpair220" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[3]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[3]),
        .I1(o_data_V_user_V_1_payload_A[3]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[3]));
  (* SOFT_HLUTNM = "soft_lutpair241" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[40]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[40]),
        .I1(o_data_V_user_V_1_payload_A[40]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[40]));
  (* SOFT_HLUTNM = "soft_lutpair241" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[41]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[41]),
        .I1(o_data_V_user_V_1_payload_A[41]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[41]));
  (* SOFT_HLUTNM = "soft_lutpair201" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[42]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[42]),
        .I1(o_data_V_user_V_1_payload_A[42]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[42]));
  (* SOFT_HLUTNM = "soft_lutpair202" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[43]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[43]),
        .I1(o_data_V_user_V_1_payload_A[43]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[43]));
  (* SOFT_HLUTNM = "soft_lutpair220" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[44]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[44]),
        .I1(o_data_V_user_V_1_payload_A[44]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[44]));
  (* SOFT_HLUTNM = "soft_lutpair242" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[45]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[45]),
        .I1(o_data_V_user_V_1_payload_A[45]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[45]));
  (* SOFT_HLUTNM = "soft_lutpair243" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[46]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[46]),
        .I1(o_data_V_user_V_1_payload_A[46]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[46]));
  (* SOFT_HLUTNM = "soft_lutpair244" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[47]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[47]),
        .I1(o_data_V_user_V_1_payload_A[47]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[47]));
  (* SOFT_HLUTNM = "soft_lutpair245" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[48]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[48]),
        .I1(o_data_V_user_V_1_payload_A[48]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[48]));
  (* SOFT_HLUTNM = "soft_lutpair245" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[49]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[49]),
        .I1(o_data_V_user_V_1_payload_A[49]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[49]));
  (* SOFT_HLUTNM = "soft_lutpair223" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[4]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[4]),
        .I1(o_data_V_user_V_1_payload_A[4]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[4]));
  (* SOFT_HLUTNM = "soft_lutpair246" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[50]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[50]),
        .I1(o_data_V_user_V_1_payload_A[50]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[50]));
  (* SOFT_HLUTNM = "soft_lutpair246" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[51]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[51]),
        .I1(o_data_V_user_V_1_payload_A[51]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[51]));
  (* SOFT_HLUTNM = "soft_lutpair247" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[52]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[52]),
        .I1(o_data_V_user_V_1_payload_A[52]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[52]));
  (* SOFT_HLUTNM = "soft_lutpair247" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[53]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[53]),
        .I1(o_data_V_user_V_1_payload_A[53]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[53]));
  (* SOFT_HLUTNM = "soft_lutpair248" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[54]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[54]),
        .I1(o_data_V_user_V_1_payload_A[54]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[54]));
  (* SOFT_HLUTNM = "soft_lutpair248" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[55]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[55]),
        .I1(o_data_V_user_V_1_payload_A[55]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[55]));
  (* SOFT_HLUTNM = "soft_lutpair249" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[56]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[56]),
        .I1(o_data_V_user_V_1_payload_A[56]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[56]));
  (* SOFT_HLUTNM = "soft_lutpair249" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[57]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[57]),
        .I1(o_data_V_user_V_1_payload_A[57]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[57]));
  (* SOFT_HLUTNM = "soft_lutpair250" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[58]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[58]),
        .I1(o_data_V_user_V_1_payload_A[58]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[58]));
  (* SOFT_HLUTNM = "soft_lutpair250" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[59]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[59]),
        .I1(o_data_V_user_V_1_payload_A[59]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[59]));
  (* SOFT_HLUTNM = "soft_lutpair223" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[5]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[5]),
        .I1(o_data_V_user_V_1_payload_A[5]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[5]));
  (* SOFT_HLUTNM = "soft_lutpair251" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[60]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[60]),
        .I1(o_data_V_user_V_1_payload_A[60]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[60]));
  (* SOFT_HLUTNM = "soft_lutpair242" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[61]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[61]),
        .I1(o_data_V_user_V_1_payload_A[61]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[61]));
  (* SOFT_HLUTNM = "soft_lutpair251" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[62]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[62]),
        .I1(o_data_V_user_V_1_payload_A[62]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[62]));
  (* SOFT_HLUTNM = "soft_lutpair252" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[63]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[63]),
        .I1(o_data_V_user_V_1_payload_A[63]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[63]));
  (* SOFT_HLUTNM = "soft_lutpair253" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[64]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[64]),
        .I1(o_data_V_user_V_1_payload_A[64]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[64]));
  (* SOFT_HLUTNM = "soft_lutpair253" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[65]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[65]),
        .I1(o_data_V_user_V_1_payload_A[65]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[65]));
  (* SOFT_HLUTNM = "soft_lutpair254" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[66]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[66]),
        .I1(o_data_V_user_V_1_payload_A[66]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[66]));
  (* SOFT_HLUTNM = "soft_lutpair254" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[67]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[67]),
        .I1(o_data_V_user_V_1_payload_A[67]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[67]));
  (* SOFT_HLUTNM = "soft_lutpair255" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[68]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[68]),
        .I1(o_data_V_user_V_1_payload_A[68]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[68]));
  (* SOFT_HLUTNM = "soft_lutpair255" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[69]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[69]),
        .I1(o_data_V_user_V_1_payload_A[69]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[69]));
  (* SOFT_HLUTNM = "soft_lutpair224" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[6]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[6]),
        .I1(o_data_V_user_V_1_payload_A[6]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[6]));
  (* SOFT_HLUTNM = "soft_lutpair256" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[70]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[70]),
        .I1(o_data_V_user_V_1_payload_A[70]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[70]));
  (* SOFT_HLUTNM = "soft_lutpair256" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[71]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[71]),
        .I1(o_data_V_user_V_1_payload_A[71]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[71]));
  (* SOFT_HLUTNM = "soft_lutpair257" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[72]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[72]),
        .I1(o_data_V_user_V_1_payload_A[72]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[72]));
  (* SOFT_HLUTNM = "soft_lutpair257" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[73]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[73]),
        .I1(o_data_V_user_V_1_payload_A[73]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[73]));
  (* SOFT_HLUTNM = "soft_lutpair258" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[74]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[74]),
        .I1(o_data_V_user_V_1_payload_A[74]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[74]));
  (* SOFT_HLUTNM = "soft_lutpair258" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[75]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[75]),
        .I1(o_data_V_user_V_1_payload_A[75]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[75]));
  (* SOFT_HLUTNM = "soft_lutpair259" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[76]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[76]),
        .I1(o_data_V_user_V_1_payload_A[76]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[76]));
  (* SOFT_HLUTNM = "soft_lutpair259" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[77]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[77]),
        .I1(o_data_V_user_V_1_payload_A[77]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[77]));
  (* SOFT_HLUTNM = "soft_lutpair260" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[78]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[78]),
        .I1(o_data_V_user_V_1_payload_A[78]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[78]));
  (* SOFT_HLUTNM = "soft_lutpair260" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[79]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[79]),
        .I1(o_data_V_user_V_1_payload_A[79]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[79]));
  (* SOFT_HLUTNM = "soft_lutpair224" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[7]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[7]),
        .I1(o_data_V_user_V_1_payload_A[7]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[7]));
  (* SOFT_HLUTNM = "soft_lutpair261" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[80]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[80]),
        .I1(o_data_V_user_V_1_payload_A[80]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[80]));
  (* SOFT_HLUTNM = "soft_lutpair261" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[81]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[81]),
        .I1(o_data_V_user_V_1_payload_A[81]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[81]));
  (* SOFT_HLUTNM = "soft_lutpair262" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[82]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[82]),
        .I1(o_data_V_user_V_1_payload_A[82]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[82]));
  (* SOFT_HLUTNM = "soft_lutpair262" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[83]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[83]),
        .I1(o_data_V_user_V_1_payload_A[83]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[83]));
  (* SOFT_HLUTNM = "soft_lutpair263" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[84]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[84]),
        .I1(o_data_V_user_V_1_payload_A[84]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[84]));
  (* SOFT_HLUTNM = "soft_lutpair243" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[85]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[85]),
        .I1(o_data_V_user_V_1_payload_A[85]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[85]));
  (* SOFT_HLUTNM = "soft_lutpair244" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[86]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[86]),
        .I1(o_data_V_user_V_1_payload_A[86]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[86]));
  (* SOFT_HLUTNM = "soft_lutpair252" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[87]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[87]),
        .I1(o_data_V_user_V_1_payload_A[87]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[87]));
  (* SOFT_HLUTNM = "soft_lutpair263" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[88]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[88]),
        .I1(o_data_V_user_V_1_payload_A[88]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[88]));
  (* SOFT_HLUTNM = "soft_lutpair264" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[89]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[89]),
        .I1(o_data_V_user_V_1_payload_A[89]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[89]));
  (* SOFT_HLUTNM = "soft_lutpair225" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[8]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[8]),
        .I1(o_data_V_user_V_1_payload_A[8]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[8]));
  (* SOFT_HLUTNM = "soft_lutpair265" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[90]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[90]),
        .I1(o_data_V_user_V_1_payload_A[90]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[90]));
  (* SOFT_HLUTNM = "soft_lutpair266" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[91]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[91]),
        .I1(o_data_V_user_V_1_payload_A[91]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[91]));
  (* SOFT_HLUTNM = "soft_lutpair267" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[92]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[92]),
        .I1(o_data_V_user_V_1_payload_A[92]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[92]));
  (* SOFT_HLUTNM = "soft_lutpair267" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[93]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[93]),
        .I1(o_data_V_user_V_1_payload_A[93]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[93]));
  (* SOFT_HLUTNM = "soft_lutpair268" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[94]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[94]),
        .I1(o_data_V_user_V_1_payload_A[94]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[94]));
  (* SOFT_HLUTNM = "soft_lutpair264" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[95]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[95]),
        .I1(o_data_V_user_V_1_payload_A[95]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[95]));
  (* SOFT_HLUTNM = "soft_lutpair268" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[96]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[96]),
        .I1(o_data_V_user_V_1_payload_A[96]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[96]));
  (* SOFT_HLUTNM = "soft_lutpair269" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[97]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[97]),
        .I1(o_data_V_user_V_1_payload_A[97]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[97]));
  (* SOFT_HLUTNM = "soft_lutpair270" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[98]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[98]),
        .I1(o_data_V_user_V_1_payload_A[98]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[98]));
  (* SOFT_HLUTNM = "soft_lutpair270" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[99]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[99]),
        .I1(o_data_V_user_V_1_payload_A[99]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[99]));
  (* SOFT_HLUTNM = "soft_lutpair225" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \o_data_TUSER[9]_INST_0 
       (.I0(o_data_V_user_V_1_payload_B[9]),
        .I1(o_data_V_user_V_1_payload_A[9]),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_TUSER[9]));
  LUT3 #(
    .INIT(8'h0D)) 
    \o_data_V_data_V_1_payload_A[31]_i_1 
       (.I0(\o_data_V_data_V_1_state_reg_n_0_[0] ),
        .I1(o_data_V_data_V_1_ack_in),
        .I2(o_data_V_data_V_1_sel_wr),
        .O(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h028A000000000000)) 
    \o_data_V_data_V_1_payload_A[31]_i_4 
       (.I0(brmerge_fu_387_p2),
        .I1(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I2(i_data_V_user_V_0_payload_A[72]),
        .I3(i_data_V_user_V_0_payload_B[72]),
        .I4(ap_CS_fsm_state3),
        .I5(\i_data_V_data_V_0_state_reg_n_0_[0] ),
        .O(o_data_V_data_V_1_data_in1));
  FDRE \o_data_V_data_V_1_payload_A_reg[0] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[0]),
        .Q(o_data_V_data_V_1_payload_A[0]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[10] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[10]),
        .Q(o_data_V_data_V_1_payload_A[10]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[11] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[11]),
        .Q(o_data_V_data_V_1_payload_A[11]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[12] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[12]),
        .Q(o_data_V_data_V_1_payload_A[12]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[13] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[13]),
        .Q(o_data_V_data_V_1_payload_A[13]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[14] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[14]),
        .Q(o_data_V_data_V_1_payload_A[14]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[15] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[15]),
        .Q(o_data_V_data_V_1_payload_A[15]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[16] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[16]),
        .Q(o_data_V_data_V_1_payload_A[16]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[17] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[17]),
        .Q(o_data_V_data_V_1_payload_A[17]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[18] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[18]),
        .Q(o_data_V_data_V_1_payload_A[18]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[19] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[19]),
        .Q(o_data_V_data_V_1_payload_A[19]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[1] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[1]),
        .Q(o_data_V_data_V_1_payload_A[1]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[20] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[20]),
        .Q(o_data_V_data_V_1_payload_A[20]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[21] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[21]),
        .Q(o_data_V_data_V_1_payload_A[21]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[22] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[22]),
        .Q(o_data_V_data_V_1_payload_A[22]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[23] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[23]),
        .Q(o_data_V_data_V_1_payload_A[23]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[24] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[24]),
        .Q(o_data_V_data_V_1_payload_A[24]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[25] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[25]),
        .Q(o_data_V_data_V_1_payload_A[25]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[26] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[26]),
        .Q(o_data_V_data_V_1_payload_A[26]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[27] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[27]),
        .Q(o_data_V_data_V_1_payload_A[27]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[28] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[28]),
        .Q(o_data_V_data_V_1_payload_A[28]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[29] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[29]),
        .Q(o_data_V_data_V_1_payload_A[29]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[2] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[2]),
        .Q(o_data_V_data_V_1_payload_A[2]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[30] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[30]),
        .Q(o_data_V_data_V_1_payload_A[30]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[31] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[31]),
        .Q(o_data_V_data_V_1_payload_A[31]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[3] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[3]),
        .Q(o_data_V_data_V_1_payload_A[3]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[4] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[4]),
        .Q(o_data_V_data_V_1_payload_A[4]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[5] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[5]),
        .Q(o_data_V_data_V_1_payload_A[5]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[6] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[6]),
        .Q(o_data_V_data_V_1_payload_A[6]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[7] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[7]),
        .Q(o_data_V_data_V_1_payload_A[7]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[8] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[8]),
        .Q(o_data_V_data_V_1_payload_A[8]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_A_reg[9] 
       (.C(ap_clk),
        .CE(\o_data_V_data_V_1_payload_A[31]_i_1_n_0 ),
        .D(o_data_V_data_V_1_data_in[9]),
        .Q(o_data_V_data_V_1_payload_A[9]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hA2)) 
    \o_data_V_data_V_1_payload_B[31]_i_1 
       (.I0(o_data_V_data_V_1_sel_wr),
        .I1(\o_data_V_data_V_1_state_reg_n_0_[0] ),
        .I2(o_data_V_data_V_1_ack_in),
        .O(o_data_V_data_V_1_load_B));
  FDRE \o_data_V_data_V_1_payload_B_reg[0] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[0]),
        .Q(o_data_V_data_V_1_payload_B[0]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[10] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[10]),
        .Q(o_data_V_data_V_1_payload_B[10]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[11] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[11]),
        .Q(o_data_V_data_V_1_payload_B[11]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[12] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[12]),
        .Q(o_data_V_data_V_1_payload_B[12]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[13] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[13]),
        .Q(o_data_V_data_V_1_payload_B[13]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[14] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[14]),
        .Q(o_data_V_data_V_1_payload_B[14]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[15] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[15]),
        .Q(o_data_V_data_V_1_payload_B[15]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[16] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[16]),
        .Q(o_data_V_data_V_1_payload_B[16]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[17] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[17]),
        .Q(o_data_V_data_V_1_payload_B[17]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[18] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[18]),
        .Q(o_data_V_data_V_1_payload_B[18]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[19] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[19]),
        .Q(o_data_V_data_V_1_payload_B[19]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[1] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[1]),
        .Q(o_data_V_data_V_1_payload_B[1]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[20] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[20]),
        .Q(o_data_V_data_V_1_payload_B[20]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[21] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[21]),
        .Q(o_data_V_data_V_1_payload_B[21]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[22] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[22]),
        .Q(o_data_V_data_V_1_payload_B[22]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[23] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[23]),
        .Q(o_data_V_data_V_1_payload_B[23]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[24] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[24]),
        .Q(o_data_V_data_V_1_payload_B[24]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[25] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[25]),
        .Q(o_data_V_data_V_1_payload_B[25]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[26] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[26]),
        .Q(o_data_V_data_V_1_payload_B[26]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[27] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[27]),
        .Q(o_data_V_data_V_1_payload_B[27]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[28] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[28]),
        .Q(o_data_V_data_V_1_payload_B[28]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[29] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[29]),
        .Q(o_data_V_data_V_1_payload_B[29]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[2] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[2]),
        .Q(o_data_V_data_V_1_payload_B[2]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[30] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[30]),
        .Q(o_data_V_data_V_1_payload_B[30]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[31] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[31]),
        .Q(o_data_V_data_V_1_payload_B[31]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[3] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[3]),
        .Q(o_data_V_data_V_1_payload_B[3]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[4] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[4]),
        .Q(o_data_V_data_V_1_payload_B[4]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[5] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[5]),
        .Q(o_data_V_data_V_1_payload_B[5]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[6] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[6]),
        .Q(o_data_V_data_V_1_payload_B[6]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[7] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[7]),
        .Q(o_data_V_data_V_1_payload_B[7]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[8] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[8]),
        .Q(o_data_V_data_V_1_payload_B[8]),
        .R(1'b0));
  FDRE \o_data_V_data_V_1_payload_B_reg[9] 
       (.C(ap_clk),
        .CE(o_data_V_data_V_1_load_B),
        .D(o_data_V_data_V_1_data_in[9]),
        .Q(o_data_V_data_V_1_payload_B[9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair119" *) 
  LUT3 #(
    .INIT(8'h78)) 
    o_data_V_data_V_1_sel_rd_i_1
       (.I0(o_data_TREADY),
        .I1(\o_data_V_data_V_1_state_reg_n_0_[0] ),
        .I2(o_data_V_data_V_1_sel),
        .O(o_data_V_data_V_1_sel_rd_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    o_data_V_data_V_1_sel_rd_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(o_data_V_data_V_1_sel_rd_i_1_n_0),
        .Q(o_data_V_data_V_1_sel),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    o_data_V_data_V_1_sel_wr_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_105),
        .Q(o_data_V_data_V_1_sel_wr),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \o_data_V_data_V_1_state_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_0),
        .Q(\o_data_V_data_V_1_state_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \o_data_V_data_V_1_state_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_92),
        .Q(o_data_V_data_V_1_ack_in),
        .R(ap_rst));
  LUT6 #(
    .INIT(64'hFFFFFFB8000000B8)) 
    \o_data_V_dest_V_1_payload_A[0]_i_1 
       (.I0(i_data_V_dest_V_0_data_out),
        .I1(o_data_V_data_V_1_data_in1),
        .I2(tmp_dest_V_reg_612),
        .I3(\o_data_V_dest_V_1_payload_A[0]_i_2_n_0 ),
        .I4(o_data_V_dest_V_1_sel_wr),
        .I5(o_data_V_dest_V_1_payload_A),
        .O(\o_data_V_dest_V_1_payload_A[0]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \o_data_V_dest_V_1_payload_A[0]_i_2 
       (.I0(o_data_TVALID),
        .I1(o_data_TREADY43_in),
        .O(\o_data_V_dest_V_1_payload_A[0]_i_2_n_0 ));
  FDRE \o_data_V_dest_V_1_payload_A_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\o_data_V_dest_V_1_payload_A[0]_i_1_n_0 ),
        .Q(o_data_V_dest_V_1_payload_A),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFFB8FF0000B800)) 
    \o_data_V_dest_V_1_payload_B[0]_i_1 
       (.I0(i_data_V_dest_V_0_data_out),
        .I1(o_data_V_data_V_1_data_in1),
        .I2(tmp_dest_V_reg_612),
        .I3(o_data_V_dest_V_1_sel_wr),
        .I4(\o_data_V_dest_V_1_payload_A[0]_i_2_n_0 ),
        .I5(o_data_V_dest_V_1_payload_B),
        .O(\o_data_V_dest_V_1_payload_B[0]_i_1_n_0 ));
  FDRE \o_data_V_dest_V_1_payload_B_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\o_data_V_dest_V_1_payload_B[0]_i_1_n_0 ),
        .Q(o_data_V_dest_V_1_payload_B),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair119" *) 
  LUT3 #(
    .INIT(8'h78)) 
    o_data_V_dest_V_1_sel_rd_i_1
       (.I0(o_data_TREADY),
        .I1(o_data_TVALID),
        .I2(o_data_V_dest_V_1_sel),
        .O(o_data_V_dest_V_1_sel_rd_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    o_data_V_dest_V_1_sel_rd_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(o_data_V_dest_V_1_sel_rd_i_1_n_0),
        .Q(o_data_V_dest_V_1_sel),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    o_data_V_dest_V_1_sel_wr_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_99),
        .Q(o_data_V_dest_V_1_sel_wr),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \o_data_V_dest_V_1_state_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_7),
        .Q(o_data_TVALID),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \o_data_V_dest_V_1_state_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_98),
        .Q(o_data_TREADY43_in),
        .R(ap_rst));
  LUT6 #(
    .INIT(64'hFFFFFFB8000000B8)) 
    \o_data_V_id_V_1_payload_A[0]_i_1 
       (.I0(i_data_V_id_V_0_data_out),
        .I1(o_data_V_data_V_1_data_in1),
        .I2(tmp_id_V_reg_606),
        .I3(\o_data_V_id_V_1_payload_A[0]_i_2_n_0 ),
        .I4(o_data_V_id_V_1_sel_wr),
        .I5(o_data_V_id_V_1_payload_A),
        .O(\o_data_V_id_V_1_payload_A[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair110" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \o_data_V_id_V_1_payload_A[0]_i_2 
       (.I0(\o_data_V_id_V_1_state_reg_n_0_[0] ),
        .I1(o_data_V_id_V_1_ack_in),
        .O(\o_data_V_id_V_1_payload_A[0]_i_2_n_0 ));
  FDRE \o_data_V_id_V_1_payload_A_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\o_data_V_id_V_1_payload_A[0]_i_1_n_0 ),
        .Q(o_data_V_id_V_1_payload_A),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFFB8FF0000B800)) 
    \o_data_V_id_V_1_payload_B[0]_i_1 
       (.I0(i_data_V_id_V_0_data_out),
        .I1(o_data_V_data_V_1_data_in1),
        .I2(tmp_id_V_reg_606),
        .I3(o_data_V_id_V_1_sel_wr),
        .I4(\o_data_V_id_V_1_payload_A[0]_i_2_n_0 ),
        .I5(o_data_V_id_V_1_payload_B),
        .O(\o_data_V_id_V_1_payload_B[0]_i_1_n_0 ));
  FDRE \o_data_V_id_V_1_payload_B_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\o_data_V_id_V_1_payload_B[0]_i_1_n_0 ),
        .Q(o_data_V_id_V_1_payload_B),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair121" *) 
  LUT3 #(
    .INIT(8'h78)) 
    o_data_V_id_V_1_sel_rd_i_1
       (.I0(o_data_TREADY),
        .I1(\o_data_V_id_V_1_state_reg_n_0_[0] ),
        .I2(o_data_V_id_V_1_sel),
        .O(o_data_V_id_V_1_sel_rd_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    o_data_V_id_V_1_sel_rd_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(o_data_V_id_V_1_sel_rd_i_1_n_0),
        .Q(o_data_V_id_V_1_sel),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    o_data_V_id_V_1_sel_wr_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_100),
        .Q(o_data_V_id_V_1_sel_wr),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \o_data_V_id_V_1_state_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_6),
        .Q(\o_data_V_id_V_1_state_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \o_data_V_id_V_1_state_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_97),
        .Q(o_data_V_id_V_1_ack_in),
        .R(ap_rst));
  (* SOFT_HLUTNM = "soft_lutpair104" *) 
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \o_data_V_keep_V_1_payload_A[0]_i_1 
       (.I0(i_data_V_keep_V_0_payload_B[0]),
        .I1(i_data_V_keep_V_0_sel),
        .I2(i_data_V_keep_V_0_payload_A[0]),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_keep_V_reg_583[0]),
        .O(o_data_V_keep_V_1_data_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair105" *) 
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \o_data_V_keep_V_1_payload_A[1]_i_1 
       (.I0(i_data_V_keep_V_0_payload_B[1]),
        .I1(i_data_V_keep_V_0_sel),
        .I2(i_data_V_keep_V_0_payload_A[1]),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_keep_V_reg_583[1]),
        .O(o_data_V_keep_V_1_data_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair106" *) 
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \o_data_V_keep_V_1_payload_A[2]_i_1 
       (.I0(i_data_V_keep_V_0_payload_B[2]),
        .I1(i_data_V_keep_V_0_sel),
        .I2(i_data_V_keep_V_0_payload_A[2]),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_keep_V_reg_583[2]),
        .O(o_data_V_keep_V_1_data_in[2]));
  LUT3 #(
    .INIT(8'h0D)) 
    \o_data_V_keep_V_1_payload_A[3]_i_1 
       (.I0(\o_data_V_keep_V_1_state_reg_n_0_[0] ),
        .I1(o_data_V_keep_V_1_ack_in),
        .I2(o_data_V_keep_V_1_sel_wr),
        .O(\o_data_V_keep_V_1_payload_A[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair107" *) 
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \o_data_V_keep_V_1_payload_A[3]_i_2 
       (.I0(i_data_V_keep_V_0_payload_B[3]),
        .I1(i_data_V_keep_V_0_sel),
        .I2(i_data_V_keep_V_0_payload_A[3]),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_keep_V_reg_583[3]),
        .O(o_data_V_keep_V_1_data_in[3]));
  FDRE \o_data_V_keep_V_1_payload_A_reg[0] 
       (.C(ap_clk),
        .CE(\o_data_V_keep_V_1_payload_A[3]_i_1_n_0 ),
        .D(o_data_V_keep_V_1_data_in[0]),
        .Q(o_data_V_keep_V_1_payload_A[0]),
        .R(1'b0));
  FDRE \o_data_V_keep_V_1_payload_A_reg[1] 
       (.C(ap_clk),
        .CE(\o_data_V_keep_V_1_payload_A[3]_i_1_n_0 ),
        .D(o_data_V_keep_V_1_data_in[1]),
        .Q(o_data_V_keep_V_1_payload_A[1]),
        .R(1'b0));
  FDRE \o_data_V_keep_V_1_payload_A_reg[2] 
       (.C(ap_clk),
        .CE(\o_data_V_keep_V_1_payload_A[3]_i_1_n_0 ),
        .D(o_data_V_keep_V_1_data_in[2]),
        .Q(o_data_V_keep_V_1_payload_A[2]),
        .R(1'b0));
  FDRE \o_data_V_keep_V_1_payload_A_reg[3] 
       (.C(ap_clk),
        .CE(\o_data_V_keep_V_1_payload_A[3]_i_1_n_0 ),
        .D(o_data_V_keep_V_1_data_in[3]),
        .Q(o_data_V_keep_V_1_payload_A[3]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hA2)) 
    \o_data_V_keep_V_1_payload_B[3]_i_1 
       (.I0(o_data_V_keep_V_1_sel_wr),
        .I1(\o_data_V_keep_V_1_state_reg_n_0_[0] ),
        .I2(o_data_V_keep_V_1_ack_in),
        .O(o_data_V_keep_V_1_load_B));
  FDRE \o_data_V_keep_V_1_payload_B_reg[0] 
       (.C(ap_clk),
        .CE(o_data_V_keep_V_1_load_B),
        .D(o_data_V_keep_V_1_data_in[0]),
        .Q(o_data_V_keep_V_1_payload_B[0]),
        .R(1'b0));
  FDRE \o_data_V_keep_V_1_payload_B_reg[1] 
       (.C(ap_clk),
        .CE(o_data_V_keep_V_1_load_B),
        .D(o_data_V_keep_V_1_data_in[1]),
        .Q(o_data_V_keep_V_1_payload_B[1]),
        .R(1'b0));
  FDRE \o_data_V_keep_V_1_payload_B_reg[2] 
       (.C(ap_clk),
        .CE(o_data_V_keep_V_1_load_B),
        .D(o_data_V_keep_V_1_data_in[2]),
        .Q(o_data_V_keep_V_1_payload_B[2]),
        .R(1'b0));
  FDRE \o_data_V_keep_V_1_payload_B_reg[3] 
       (.C(ap_clk),
        .CE(o_data_V_keep_V_1_load_B),
        .D(o_data_V_keep_V_1_data_in[3]),
        .Q(o_data_V_keep_V_1_payload_B[3]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair197" *) 
  LUT3 #(
    .INIT(8'h78)) 
    o_data_V_keep_V_1_sel_rd_i_1
       (.I0(o_data_TREADY),
        .I1(\o_data_V_keep_V_1_state_reg_n_0_[0] ),
        .I2(o_data_V_keep_V_1_sel),
        .O(o_data_V_keep_V_1_sel_rd_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    o_data_V_keep_V_1_sel_rd_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(o_data_V_keep_V_1_sel_rd_i_1_n_0),
        .Q(o_data_V_keep_V_1_sel),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    o_data_V_keep_V_1_sel_wr_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_104),
        .Q(o_data_V_keep_V_1_sel_wr),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \o_data_V_keep_V_1_state_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_2),
        .Q(\o_data_V_keep_V_1_state_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \o_data_V_keep_V_1_state_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_93),
        .Q(o_data_V_keep_V_1_ack_in),
        .R(ap_rst));
  LUT6 #(
    .INIT(64'hFFFFFFB8000000B8)) 
    \o_data_V_last_V_1_payload_A[0]_i_1 
       (.I0(i_data_V_last_V_0_data_out),
        .I1(o_data_V_data_V_1_data_in1),
        .I2(tmp_last_V_reg_600),
        .I3(\o_data_V_last_V_1_payload_A[0]_i_2_n_0 ),
        .I4(o_data_V_last_V_1_sel_wr),
        .I5(o_data_V_last_V_1_payload_A),
        .O(\o_data_V_last_V_1_payload_A[0]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \o_data_V_last_V_1_payload_A[0]_i_2 
       (.I0(\o_data_V_last_V_1_state_reg_n_0_[0] ),
        .I1(o_data_V_last_V_1_ack_in),
        .O(\o_data_V_last_V_1_payload_A[0]_i_2_n_0 ));
  FDRE \o_data_V_last_V_1_payload_A_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\o_data_V_last_V_1_payload_A[0]_i_1_n_0 ),
        .Q(o_data_V_last_V_1_payload_A),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFB8FFFF00B80000)) 
    \o_data_V_last_V_1_payload_B[0]_i_1 
       (.I0(i_data_V_last_V_0_data_out),
        .I1(o_data_V_data_V_1_data_in1),
        .I2(tmp_last_V_reg_600),
        .I3(\o_data_V_last_V_1_payload_A[0]_i_2_n_0 ),
        .I4(o_data_V_last_V_1_sel_wr),
        .I5(o_data_V_last_V_1_payload_B),
        .O(\o_data_V_last_V_1_payload_B[0]_i_1_n_0 ));
  FDRE \o_data_V_last_V_1_payload_B_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\o_data_V_last_V_1_payload_B[0]_i_1_n_0 ),
        .Q(o_data_V_last_V_1_payload_B),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair122" *) 
  LUT3 #(
    .INIT(8'h78)) 
    o_data_V_last_V_1_sel_rd_i_1
       (.I0(o_data_TREADY),
        .I1(\o_data_V_last_V_1_state_reg_n_0_[0] ),
        .I2(o_data_V_last_V_1_sel),
        .O(o_data_V_last_V_1_sel_rd_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    o_data_V_last_V_1_sel_rd_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(o_data_V_last_V_1_sel_rd_i_1_n_0),
        .Q(o_data_V_last_V_1_sel),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    o_data_V_last_V_1_sel_wr_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_101),
        .Q(o_data_V_last_V_1_sel_wr),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \o_data_V_last_V_1_state_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_5),
        .Q(\o_data_V_last_V_1_state_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \o_data_V_last_V_1_state_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_96),
        .Q(o_data_V_last_V_1_ack_in),
        .R(ap_rst));
  (* SOFT_HLUTNM = "soft_lutpair100" *) 
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \o_data_V_strb_V_1_payload_A[0]_i_1 
       (.I0(i_data_V_strb_V_0_payload_B[0]),
        .I1(i_data_V_strb_V_0_sel),
        .I2(i_data_V_strb_V_0_payload_A[0]),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_strb_V_reg_589[0]),
        .O(o_data_V_strb_V_1_data_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair101" *) 
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \o_data_V_strb_V_1_payload_A[1]_i_1 
       (.I0(i_data_V_strb_V_0_payload_B[1]),
        .I1(i_data_V_strb_V_0_sel),
        .I2(i_data_V_strb_V_0_payload_A[1]),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_strb_V_reg_589[1]),
        .O(o_data_V_strb_V_1_data_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair102" *) 
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \o_data_V_strb_V_1_payload_A[2]_i_1 
       (.I0(i_data_V_strb_V_0_payload_B[2]),
        .I1(i_data_V_strb_V_0_sel),
        .I2(i_data_V_strb_V_0_payload_A[2]),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_strb_V_reg_589[2]),
        .O(o_data_V_strb_V_1_data_in[2]));
  LUT3 #(
    .INIT(8'h0D)) 
    \o_data_V_strb_V_1_payload_A[3]_i_1 
       (.I0(\o_data_V_strb_V_1_state_reg_n_0_[0] ),
        .I1(o_data_V_strb_V_1_ack_in),
        .I2(o_data_V_strb_V_1_sel_wr),
        .O(\o_data_V_strb_V_1_payload_A[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair103" *) 
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \o_data_V_strb_V_1_payload_A[3]_i_2 
       (.I0(i_data_V_strb_V_0_payload_B[3]),
        .I1(i_data_V_strb_V_0_sel),
        .I2(i_data_V_strb_V_0_payload_A[3]),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_strb_V_reg_589[3]),
        .O(o_data_V_strb_V_1_data_in[3]));
  FDRE \o_data_V_strb_V_1_payload_A_reg[0] 
       (.C(ap_clk),
        .CE(\o_data_V_strb_V_1_payload_A[3]_i_1_n_0 ),
        .D(o_data_V_strb_V_1_data_in[0]),
        .Q(o_data_V_strb_V_1_payload_A[0]),
        .R(1'b0));
  FDRE \o_data_V_strb_V_1_payload_A_reg[1] 
       (.C(ap_clk),
        .CE(\o_data_V_strb_V_1_payload_A[3]_i_1_n_0 ),
        .D(o_data_V_strb_V_1_data_in[1]),
        .Q(o_data_V_strb_V_1_payload_A[1]),
        .R(1'b0));
  FDRE \o_data_V_strb_V_1_payload_A_reg[2] 
       (.C(ap_clk),
        .CE(\o_data_V_strb_V_1_payload_A[3]_i_1_n_0 ),
        .D(o_data_V_strb_V_1_data_in[2]),
        .Q(o_data_V_strb_V_1_payload_A[2]),
        .R(1'b0));
  FDRE \o_data_V_strb_V_1_payload_A_reg[3] 
       (.C(ap_clk),
        .CE(\o_data_V_strb_V_1_payload_A[3]_i_1_n_0 ),
        .D(o_data_V_strb_V_1_data_in[3]),
        .Q(o_data_V_strb_V_1_payload_A[3]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hD0)) 
    \o_data_V_strb_V_1_payload_B[3]_i_1 
       (.I0(\o_data_V_strb_V_1_state_reg_n_0_[0] ),
        .I1(o_data_V_strb_V_1_ack_in),
        .I2(o_data_V_strb_V_1_sel_wr),
        .O(o_data_V_strb_V_1_load_B));
  FDRE \o_data_V_strb_V_1_payload_B_reg[0] 
       (.C(ap_clk),
        .CE(o_data_V_strb_V_1_load_B),
        .D(o_data_V_strb_V_1_data_in[0]),
        .Q(o_data_V_strb_V_1_payload_B[0]),
        .R(1'b0));
  FDRE \o_data_V_strb_V_1_payload_B_reg[1] 
       (.C(ap_clk),
        .CE(o_data_V_strb_V_1_load_B),
        .D(o_data_V_strb_V_1_data_in[1]),
        .Q(o_data_V_strb_V_1_payload_B[1]),
        .R(1'b0));
  FDRE \o_data_V_strb_V_1_payload_B_reg[2] 
       (.C(ap_clk),
        .CE(o_data_V_strb_V_1_load_B),
        .D(o_data_V_strb_V_1_data_in[2]),
        .Q(o_data_V_strb_V_1_payload_B[2]),
        .R(1'b0));
  FDRE \o_data_V_strb_V_1_payload_B_reg[3] 
       (.C(ap_clk),
        .CE(o_data_V_strb_V_1_load_B),
        .D(o_data_V_strb_V_1_data_in[3]),
        .Q(o_data_V_strb_V_1_payload_B[3]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair197" *) 
  LUT3 #(
    .INIT(8'h78)) 
    o_data_V_strb_V_1_sel_rd_i_1
       (.I0(o_data_TREADY),
        .I1(\o_data_V_strb_V_1_state_reg_n_0_[0] ),
        .I2(o_data_V_strb_V_1_sel),
        .O(o_data_V_strb_V_1_sel_rd_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    o_data_V_strb_V_1_sel_rd_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(o_data_V_strb_V_1_sel_rd_i_1_n_0),
        .Q(o_data_V_strb_V_1_sel),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    o_data_V_strb_V_1_sel_wr_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_103),
        .Q(o_data_V_strb_V_1_sel_wr),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \o_data_V_strb_V_1_state_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_3),
        .Q(\o_data_V_strb_V_1_state_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \o_data_V_strb_V_1_state_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_94),
        .Q(o_data_V_strb_V_1_ack_in),
        .R(ap_rst));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[0]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[0]),
        .I1(i_data_V_user_V_0_payload_A[0]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[0]),
        .O(o_data_V_user_V_1_data_in[0]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[100]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[100]),
        .I1(i_data_V_user_V_0_payload_A[100]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[100]),
        .O(o_data_V_user_V_1_data_in[100]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[101]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[101]),
        .I1(i_data_V_user_V_0_payload_A[101]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[101]),
        .O(o_data_V_user_V_1_data_in[101]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[102]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[102]),
        .I1(i_data_V_user_V_0_payload_A[102]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[102]),
        .O(o_data_V_user_V_1_data_in[102]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[103]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[103]),
        .I1(i_data_V_user_V_0_payload_A[103]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[103]),
        .O(o_data_V_user_V_1_data_in[103]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[104]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[104]),
        .I1(i_data_V_user_V_0_payload_A[104]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[104]),
        .O(o_data_V_user_V_1_data_in[104]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[105]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[105]),
        .I1(i_data_V_user_V_0_payload_A[105]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[105]),
        .O(o_data_V_user_V_1_data_in[105]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[106]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[106]),
        .I1(i_data_V_user_V_0_payload_A[106]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[106]),
        .O(o_data_V_user_V_1_data_in[106]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[107]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[107]),
        .I1(i_data_V_user_V_0_payload_A[107]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[107]),
        .O(o_data_V_user_V_1_data_in[107]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[108]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[108]),
        .I1(i_data_V_user_V_0_payload_A[108]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[108]),
        .O(o_data_V_user_V_1_data_in[108]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[109]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[109]),
        .I1(i_data_V_user_V_0_payload_A[109]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[109]),
        .O(o_data_V_user_V_1_data_in[109]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[10]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[10]),
        .I1(i_data_V_user_V_0_payload_A[10]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[10]),
        .O(o_data_V_user_V_1_data_in[10]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[110]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[110]),
        .I1(i_data_V_user_V_0_payload_A[110]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[110]),
        .O(o_data_V_user_V_1_data_in[110]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[111]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[111]),
        .I1(i_data_V_user_V_0_payload_A[111]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[111]),
        .O(o_data_V_user_V_1_data_in[111]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[112]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[112]),
        .I1(i_data_V_user_V_0_payload_A[112]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[112]),
        .O(o_data_V_user_V_1_data_in[112]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[113]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[113]),
        .I1(i_data_V_user_V_0_payload_A[113]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[113]),
        .O(o_data_V_user_V_1_data_in[113]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[114]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[114]),
        .I1(i_data_V_user_V_0_payload_A[114]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[114]),
        .O(o_data_V_user_V_1_data_in[114]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[115]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[115]),
        .I1(i_data_V_user_V_0_payload_A[115]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[115]),
        .O(o_data_V_user_V_1_data_in[115]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[116]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[116]),
        .I1(i_data_V_user_V_0_payload_A[116]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[116]),
        .O(o_data_V_user_V_1_data_in[116]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[117]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[117]),
        .I1(i_data_V_user_V_0_payload_A[117]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[117]),
        .O(o_data_V_user_V_1_data_in[117]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[118]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[118]),
        .I1(i_data_V_user_V_0_payload_A[118]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[118]),
        .O(o_data_V_user_V_1_data_in[118]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[119]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[119]),
        .I1(i_data_V_user_V_0_payload_A[119]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[119]),
        .O(o_data_V_user_V_1_data_in[119]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[11]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[11]),
        .I1(i_data_V_user_V_0_payload_A[11]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[11]),
        .O(o_data_V_user_V_1_data_in[11]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[120]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[120]),
        .I1(i_data_V_user_V_0_payload_A[120]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[120]),
        .O(o_data_V_user_V_1_data_in[120]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[121]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[121]),
        .I1(i_data_V_user_V_0_payload_A[121]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[121]),
        .O(o_data_V_user_V_1_data_in[121]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[122]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[122]),
        .I1(i_data_V_user_V_0_payload_A[122]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[122]),
        .O(o_data_V_user_V_1_data_in[122]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[123]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[123]),
        .I1(i_data_V_user_V_0_payload_A[123]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[123]),
        .O(o_data_V_user_V_1_data_in[123]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[124]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[124]),
        .I1(i_data_V_user_V_0_payload_A[124]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[124]),
        .O(o_data_V_user_V_1_data_in[124]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[125]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[125]),
        .I1(i_data_V_user_V_0_payload_A[125]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[125]),
        .O(o_data_V_user_V_1_data_in[125]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[126]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[126]),
        .I1(i_data_V_user_V_0_payload_A[126]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[126]),
        .O(o_data_V_user_V_1_data_in[126]));
  LUT3 #(
    .INIT(8'h0D)) 
    \o_data_V_user_V_1_payload_A[127]_i_1 
       (.I0(\o_data_V_user_V_1_state_reg_n_0_[0] ),
        .I1(o_data_V_user_V_1_ack_in),
        .I2(o_data_V_user_V_1_sel_wr),
        .O(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair99" *) 
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[127]_i_2 
       (.I0(i_data_V_user_V_0_payload_B[127]),
        .I1(i_data_V_user_V_0_payload_A[127]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[127]),
        .O(o_data_V_user_V_1_data_in[127]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[12]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[12]),
        .I1(i_data_V_user_V_0_payload_A[12]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[12]),
        .O(o_data_V_user_V_1_data_in[12]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[13]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[13]),
        .I1(i_data_V_user_V_0_payload_A[13]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[13]),
        .O(o_data_V_user_V_1_data_in[13]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[14]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[14]),
        .I1(i_data_V_user_V_0_payload_A[14]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[14]),
        .O(o_data_V_user_V_1_data_in[14]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[15]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[15]),
        .I1(i_data_V_user_V_0_payload_A[15]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[15]),
        .O(o_data_V_user_V_1_data_in[15]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[16]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[16]),
        .I1(i_data_V_user_V_0_payload_A[16]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[16]),
        .O(o_data_V_user_V_1_data_in[16]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[17]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[17]),
        .I1(i_data_V_user_V_0_payload_A[17]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[17]),
        .O(o_data_V_user_V_1_data_in[17]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[18]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[18]),
        .I1(i_data_V_user_V_0_payload_A[18]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[18]),
        .O(o_data_V_user_V_1_data_in[18]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[19]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[19]),
        .I1(i_data_V_user_V_0_payload_A[19]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[19]),
        .O(o_data_V_user_V_1_data_in[19]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[1]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[1]),
        .I1(i_data_V_user_V_0_payload_A[1]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[1]),
        .O(o_data_V_user_V_1_data_in[1]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[20]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[20]),
        .I1(i_data_V_user_V_0_payload_A[20]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[20]),
        .O(o_data_V_user_V_1_data_in[20]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[21]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[21]),
        .I1(i_data_V_user_V_0_payload_A[21]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[21]),
        .O(o_data_V_user_V_1_data_in[21]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[22]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[22]),
        .I1(i_data_V_user_V_0_payload_A[22]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[22]),
        .O(o_data_V_user_V_1_data_in[22]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[23]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[23]),
        .I1(i_data_V_user_V_0_payload_A[23]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[23]),
        .O(o_data_V_user_V_1_data_in[23]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[24]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[24]),
        .I1(i_data_V_user_V_0_payload_A[24]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[24]),
        .O(o_data_V_user_V_1_data_in[24]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[25]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[25]),
        .I1(i_data_V_user_V_0_payload_A[25]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[25]),
        .O(o_data_V_user_V_1_data_in[25]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[26]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[26]),
        .I1(i_data_V_user_V_0_payload_A[26]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[26]),
        .O(o_data_V_user_V_1_data_in[26]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[27]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[27]),
        .I1(i_data_V_user_V_0_payload_A[27]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[27]),
        .O(o_data_V_user_V_1_data_in[27]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[28]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[28]),
        .I1(i_data_V_user_V_0_payload_A[28]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[28]),
        .O(o_data_V_user_V_1_data_in[28]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[29]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[29]),
        .I1(i_data_V_user_V_0_payload_A[29]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[29]),
        .O(o_data_V_user_V_1_data_in[29]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[2]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[2]),
        .I1(i_data_V_user_V_0_payload_A[2]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[2]),
        .O(o_data_V_user_V_1_data_in[2]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[30]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[30]),
        .I1(i_data_V_user_V_0_payload_A[30]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[30]),
        .O(o_data_V_user_V_1_data_in[30]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[31]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[31]),
        .I1(i_data_V_user_V_0_payload_A[31]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[31]),
        .O(o_data_V_user_V_1_data_in[31]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[32]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[32]),
        .I1(i_data_V_user_V_0_payload_A[32]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[32]),
        .O(o_data_V_user_V_1_data_in[32]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[33]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[33]),
        .I1(i_data_V_user_V_0_payload_A[33]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[33]),
        .O(o_data_V_user_V_1_data_in[33]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[34]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[34]),
        .I1(i_data_V_user_V_0_payload_A[34]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[34]),
        .O(o_data_V_user_V_1_data_in[34]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[35]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[35]),
        .I1(i_data_V_user_V_0_payload_A[35]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[35]),
        .O(o_data_V_user_V_1_data_in[35]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[36]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[36]),
        .I1(i_data_V_user_V_0_payload_A[36]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[36]),
        .O(o_data_V_user_V_1_data_in[36]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[37]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[37]),
        .I1(i_data_V_user_V_0_payload_A[37]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[37]),
        .O(o_data_V_user_V_1_data_in[37]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[38]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[38]),
        .I1(i_data_V_user_V_0_payload_A[38]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[38]),
        .O(o_data_V_user_V_1_data_in[38]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[39]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[39]),
        .I1(i_data_V_user_V_0_payload_A[39]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[39]),
        .O(o_data_V_user_V_1_data_in[39]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[3]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[3]),
        .I1(i_data_V_user_V_0_payload_A[3]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[3]),
        .O(o_data_V_user_V_1_data_in[3]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[40]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[40]),
        .I1(i_data_V_user_V_0_payload_A[40]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[40]),
        .O(o_data_V_user_V_1_data_in[40]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[41]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[41]),
        .I1(i_data_V_user_V_0_payload_A[41]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[41]),
        .O(o_data_V_user_V_1_data_in[41]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[42]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[42]),
        .I1(i_data_V_user_V_0_payload_A[42]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[42]),
        .O(o_data_V_user_V_1_data_in[42]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[43]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[43]),
        .I1(i_data_V_user_V_0_payload_A[43]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[43]),
        .O(o_data_V_user_V_1_data_in[43]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[44]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[44]),
        .I1(i_data_V_user_V_0_payload_A[44]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[44]),
        .O(o_data_V_user_V_1_data_in[44]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[45]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[45]),
        .I1(i_data_V_user_V_0_payload_A[45]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[45]),
        .O(o_data_V_user_V_1_data_in[45]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[46]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[46]),
        .I1(i_data_V_user_V_0_payload_A[46]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[46]),
        .O(o_data_V_user_V_1_data_in[46]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[47]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[47]),
        .I1(i_data_V_user_V_0_payload_A[47]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[47]),
        .O(o_data_V_user_V_1_data_in[47]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[48]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[48]),
        .I1(i_data_V_user_V_0_payload_A[48]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[48]),
        .O(o_data_V_user_V_1_data_in[48]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[49]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[49]),
        .I1(i_data_V_user_V_0_payload_A[49]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[49]),
        .O(o_data_V_user_V_1_data_in[49]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[4]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[4]),
        .I1(i_data_V_user_V_0_payload_A[4]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[4]),
        .O(o_data_V_user_V_1_data_in[4]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[50]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[50]),
        .I1(i_data_V_user_V_0_payload_A[50]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[50]),
        .O(o_data_V_user_V_1_data_in[50]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[51]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[51]),
        .I1(i_data_V_user_V_0_payload_A[51]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[51]),
        .O(o_data_V_user_V_1_data_in[51]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[52]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[52]),
        .I1(i_data_V_user_V_0_payload_A[52]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[52]),
        .O(o_data_V_user_V_1_data_in[52]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[53]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[53]),
        .I1(i_data_V_user_V_0_payload_A[53]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[53]),
        .O(o_data_V_user_V_1_data_in[53]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[54]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[54]),
        .I1(i_data_V_user_V_0_payload_A[54]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[54]),
        .O(o_data_V_user_V_1_data_in[54]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[55]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[55]),
        .I1(i_data_V_user_V_0_payload_A[55]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[55]),
        .O(o_data_V_user_V_1_data_in[55]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[56]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[56]),
        .I1(i_data_V_user_V_0_payload_A[56]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[56]),
        .O(o_data_V_user_V_1_data_in[56]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[57]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[57]),
        .I1(i_data_V_user_V_0_payload_A[57]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[57]),
        .O(o_data_V_user_V_1_data_in[57]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[58]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[58]),
        .I1(i_data_V_user_V_0_payload_A[58]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[58]),
        .O(o_data_V_user_V_1_data_in[58]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[59]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[59]),
        .I1(i_data_V_user_V_0_payload_A[59]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[59]),
        .O(o_data_V_user_V_1_data_in[59]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[5]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[5]),
        .I1(i_data_V_user_V_0_payload_A[5]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[5]),
        .O(o_data_V_user_V_1_data_in[5]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[60]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[60]),
        .I1(i_data_V_user_V_0_payload_A[60]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[60]),
        .O(o_data_V_user_V_1_data_in[60]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[61]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[61]),
        .I1(i_data_V_user_V_0_payload_A[61]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[61]),
        .O(o_data_V_user_V_1_data_in[61]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[62]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[62]),
        .I1(i_data_V_user_V_0_payload_A[62]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[62]),
        .O(o_data_V_user_V_1_data_in[62]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[63]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[63]),
        .I1(i_data_V_user_V_0_payload_A[63]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[63]),
        .O(o_data_V_user_V_1_data_in[63]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[65]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[65]),
        .I1(i_data_V_user_V_0_payload_A[65]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[65]),
        .O(o_data_V_user_V_1_data_in[65]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[66]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[66]),
        .I1(i_data_V_user_V_0_payload_A[66]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[66]),
        .O(o_data_V_user_V_1_data_in[66]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[67]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[67]),
        .I1(i_data_V_user_V_0_payload_A[67]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[67]),
        .O(o_data_V_user_V_1_data_in[67]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[68]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[68]),
        .I1(i_data_V_user_V_0_payload_A[68]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[68]),
        .O(o_data_V_user_V_1_data_in[68]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[69]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[69]),
        .I1(i_data_V_user_V_0_payload_A[69]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[69]),
        .O(o_data_V_user_V_1_data_in[69]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[6]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[6]),
        .I1(i_data_V_user_V_0_payload_A[6]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[6]),
        .O(o_data_V_user_V_1_data_in[6]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[70]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[70]),
        .I1(i_data_V_user_V_0_payload_A[70]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[70]),
        .O(o_data_V_user_V_1_data_in[70]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[71]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[71]),
        .I1(i_data_V_user_V_0_payload_A[71]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[71]),
        .O(o_data_V_user_V_1_data_in[71]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[73]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[73]),
        .I1(i_data_V_user_V_0_payload_A[73]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[73]),
        .O(o_data_V_user_V_1_data_in[73]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[74]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[74]),
        .I1(i_data_V_user_V_0_payload_A[74]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[74]),
        .O(o_data_V_user_V_1_data_in[74]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[75]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[75]),
        .I1(i_data_V_user_V_0_payload_A[75]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[75]),
        .O(o_data_V_user_V_1_data_in[75]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[76]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[76]),
        .I1(i_data_V_user_V_0_payload_A[76]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[76]),
        .O(o_data_V_user_V_1_data_in[76]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[77]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[77]),
        .I1(i_data_V_user_V_0_payload_A[77]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[77]),
        .O(o_data_V_user_V_1_data_in[77]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[78]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[78]),
        .I1(i_data_V_user_V_0_payload_A[78]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[78]),
        .O(o_data_V_user_V_1_data_in[78]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[79]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[79]),
        .I1(i_data_V_user_V_0_payload_A[79]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[79]),
        .O(o_data_V_user_V_1_data_in[79]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[7]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[7]),
        .I1(i_data_V_user_V_0_payload_A[7]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[7]),
        .O(o_data_V_user_V_1_data_in[7]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[80]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[80]),
        .I1(i_data_V_user_V_0_payload_A[80]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[80]),
        .O(o_data_V_user_V_1_data_in[80]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[81]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[81]),
        .I1(i_data_V_user_V_0_payload_A[81]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[81]),
        .O(o_data_V_user_V_1_data_in[81]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[82]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[82]),
        .I1(i_data_V_user_V_0_payload_A[82]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[82]),
        .O(o_data_V_user_V_1_data_in[82]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[83]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[83]),
        .I1(i_data_V_user_V_0_payload_A[83]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[83]),
        .O(o_data_V_user_V_1_data_in[83]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[84]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[84]),
        .I1(i_data_V_user_V_0_payload_A[84]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[84]),
        .O(o_data_V_user_V_1_data_in[84]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[85]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[85]),
        .I1(i_data_V_user_V_0_payload_A[85]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[85]),
        .O(o_data_V_user_V_1_data_in[85]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[86]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[86]),
        .I1(i_data_V_user_V_0_payload_A[86]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[86]),
        .O(o_data_V_user_V_1_data_in[86]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[87]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[87]),
        .I1(i_data_V_user_V_0_payload_A[87]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[87]),
        .O(o_data_V_user_V_1_data_in[87]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[88]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[88]),
        .I1(i_data_V_user_V_0_payload_A[88]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[88]),
        .O(o_data_V_user_V_1_data_in[88]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[89]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[89]),
        .I1(i_data_V_user_V_0_payload_A[89]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[89]),
        .O(o_data_V_user_V_1_data_in[89]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[8]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[8]),
        .I1(i_data_V_user_V_0_payload_A[8]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[8]),
        .O(o_data_V_user_V_1_data_in[8]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[90]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[90]),
        .I1(i_data_V_user_V_0_payload_A[90]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[90]),
        .O(o_data_V_user_V_1_data_in[90]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[91]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[91]),
        .I1(i_data_V_user_V_0_payload_A[91]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[91]),
        .O(o_data_V_user_V_1_data_in[91]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[92]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[92]),
        .I1(i_data_V_user_V_0_payload_A[92]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[92]),
        .O(o_data_V_user_V_1_data_in[92]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[93]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[93]),
        .I1(i_data_V_user_V_0_payload_A[93]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[93]),
        .O(o_data_V_user_V_1_data_in[93]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[94]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[94]),
        .I1(i_data_V_user_V_0_payload_A[94]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[94]),
        .O(o_data_V_user_V_1_data_in[94]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[95]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[95]),
        .I1(i_data_V_user_V_0_payload_A[95]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[95]),
        .O(o_data_V_user_V_1_data_in[95]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[96]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[96]),
        .I1(i_data_V_user_V_0_payload_A[96]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[96]),
        .O(o_data_V_user_V_1_data_in[96]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[97]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[97]),
        .I1(i_data_V_user_V_0_payload_A[97]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[97]),
        .O(o_data_V_user_V_1_data_in[97]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[98]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[98]),
        .I1(i_data_V_user_V_0_payload_A[98]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[98]),
        .O(o_data_V_user_V_1_data_in[98]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[99]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[99]),
        .I1(i_data_V_user_V_0_payload_A[99]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[99]),
        .O(o_data_V_user_V_1_data_in[99]));
  LUT5 #(
    .INIT(32'hACFFAC00)) 
    \o_data_V_user_V_1_payload_A[9]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[9]),
        .I1(i_data_V_user_V_0_payload_A[9]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .I3(o_data_V_data_V_1_data_in1),
        .I4(tmp_user_V_1_reg_595[9]),
        .O(o_data_V_user_V_1_data_in[9]));
  FDRE \o_data_V_user_V_1_payload_A_reg[0] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[0]),
        .Q(o_data_V_user_V_1_payload_A[0]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[100] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[100]),
        .Q(o_data_V_user_V_1_payload_A[100]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[101] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[101]),
        .Q(o_data_V_user_V_1_payload_A[101]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[102] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[102]),
        .Q(o_data_V_user_V_1_payload_A[102]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[103] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[103]),
        .Q(o_data_V_user_V_1_payload_A[103]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[104] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[104]),
        .Q(o_data_V_user_V_1_payload_A[104]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[105] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[105]),
        .Q(o_data_V_user_V_1_payload_A[105]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[106] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[106]),
        .Q(o_data_V_user_V_1_payload_A[106]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[107] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[107]),
        .Q(o_data_V_user_V_1_payload_A[107]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[108] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[108]),
        .Q(o_data_V_user_V_1_payload_A[108]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[109] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[109]),
        .Q(o_data_V_user_V_1_payload_A[109]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[10] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[10]),
        .Q(o_data_V_user_V_1_payload_A[10]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[110] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[110]),
        .Q(o_data_V_user_V_1_payload_A[110]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[111] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[111]),
        .Q(o_data_V_user_V_1_payload_A[111]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[112] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[112]),
        .Q(o_data_V_user_V_1_payload_A[112]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[113] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[113]),
        .Q(o_data_V_user_V_1_payload_A[113]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[114] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[114]),
        .Q(o_data_V_user_V_1_payload_A[114]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[115] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[115]),
        .Q(o_data_V_user_V_1_payload_A[115]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[116] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[116]),
        .Q(o_data_V_user_V_1_payload_A[116]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[117] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[117]),
        .Q(o_data_V_user_V_1_payload_A[117]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[118] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[118]),
        .Q(o_data_V_user_V_1_payload_A[118]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[119] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[119]),
        .Q(o_data_V_user_V_1_payload_A[119]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[11] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[11]),
        .Q(o_data_V_user_V_1_payload_A[11]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[120] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[120]),
        .Q(o_data_V_user_V_1_payload_A[120]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[121] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[121]),
        .Q(o_data_V_user_V_1_payload_A[121]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[122] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[122]),
        .Q(o_data_V_user_V_1_payload_A[122]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[123] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[123]),
        .Q(o_data_V_user_V_1_payload_A[123]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[124] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[124]),
        .Q(o_data_V_user_V_1_payload_A[124]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[125] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[125]),
        .Q(o_data_V_user_V_1_payload_A[125]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[126] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[126]),
        .Q(o_data_V_user_V_1_payload_A[126]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[127] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[127]),
        .Q(o_data_V_user_V_1_payload_A[127]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[12] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[12]),
        .Q(o_data_V_user_V_1_payload_A[12]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[13] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[13]),
        .Q(o_data_V_user_V_1_payload_A[13]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[14] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[14]),
        .Q(o_data_V_user_V_1_payload_A[14]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[15] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[15]),
        .Q(o_data_V_user_V_1_payload_A[15]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[16] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[16]),
        .Q(o_data_V_user_V_1_payload_A[16]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[17] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[17]),
        .Q(o_data_V_user_V_1_payload_A[17]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[18] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[18]),
        .Q(o_data_V_user_V_1_payload_A[18]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[19] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[19]),
        .Q(o_data_V_user_V_1_payload_A[19]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[1] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[1]),
        .Q(o_data_V_user_V_1_payload_A[1]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[20] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[20]),
        .Q(o_data_V_user_V_1_payload_A[20]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[21] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[21]),
        .Q(o_data_V_user_V_1_payload_A[21]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[22] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[22]),
        .Q(o_data_V_user_V_1_payload_A[22]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[23] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[23]),
        .Q(o_data_V_user_V_1_payload_A[23]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[24] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[24]),
        .Q(o_data_V_user_V_1_payload_A[24]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[25] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[25]),
        .Q(o_data_V_user_V_1_payload_A[25]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[26] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[26]),
        .Q(o_data_V_user_V_1_payload_A[26]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[27] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[27]),
        .Q(o_data_V_user_V_1_payload_A[27]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[28] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[28]),
        .Q(o_data_V_user_V_1_payload_A[28]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[29] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[29]),
        .Q(o_data_V_user_V_1_payload_A[29]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[2] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[2]),
        .Q(o_data_V_user_V_1_payload_A[2]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[30] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[30]),
        .Q(o_data_V_user_V_1_payload_A[30]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[31] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[31]),
        .Q(o_data_V_user_V_1_payload_A[31]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[32] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[32]),
        .Q(o_data_V_user_V_1_payload_A[32]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[33] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[33]),
        .Q(o_data_V_user_V_1_payload_A[33]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[34] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[34]),
        .Q(o_data_V_user_V_1_payload_A[34]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[35] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[35]),
        .Q(o_data_V_user_V_1_payload_A[35]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[36] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[36]),
        .Q(o_data_V_user_V_1_payload_A[36]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[37] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[37]),
        .Q(o_data_V_user_V_1_payload_A[37]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[38] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[38]),
        .Q(o_data_V_user_V_1_payload_A[38]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[39] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[39]),
        .Q(o_data_V_user_V_1_payload_A[39]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[3] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[3]),
        .Q(o_data_V_user_V_1_payload_A[3]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[40] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[40]),
        .Q(o_data_V_user_V_1_payload_A[40]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[41] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[41]),
        .Q(o_data_V_user_V_1_payload_A[41]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[42] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[42]),
        .Q(o_data_V_user_V_1_payload_A[42]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[43] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[43]),
        .Q(o_data_V_user_V_1_payload_A[43]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[44] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[44]),
        .Q(o_data_V_user_V_1_payload_A[44]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[45] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[45]),
        .Q(o_data_V_user_V_1_payload_A[45]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[46] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[46]),
        .Q(o_data_V_user_V_1_payload_A[46]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[47] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[47]),
        .Q(o_data_V_user_V_1_payload_A[47]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[48] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[48]),
        .Q(o_data_V_user_V_1_payload_A[48]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[49] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[49]),
        .Q(o_data_V_user_V_1_payload_A[49]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[4] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[4]),
        .Q(o_data_V_user_V_1_payload_A[4]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[50] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[50]),
        .Q(o_data_V_user_V_1_payload_A[50]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[51] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[51]),
        .Q(o_data_V_user_V_1_payload_A[51]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[52] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[52]),
        .Q(o_data_V_user_V_1_payload_A[52]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[53] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[53]),
        .Q(o_data_V_user_V_1_payload_A[53]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[54] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[54]),
        .Q(o_data_V_user_V_1_payload_A[54]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[55] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[55]),
        .Q(o_data_V_user_V_1_payload_A[55]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[56] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[56]),
        .Q(o_data_V_user_V_1_payload_A[56]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[57] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[57]),
        .Q(o_data_V_user_V_1_payload_A[57]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[58] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[58]),
        .Q(o_data_V_user_V_1_payload_A[58]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[59] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[59]),
        .Q(o_data_V_user_V_1_payload_A[59]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[5] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[5]),
        .Q(o_data_V_user_V_1_payload_A[5]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[60] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[60]),
        .Q(o_data_V_user_V_1_payload_A[60]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[61] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[61]),
        .Q(o_data_V_user_V_1_payload_A[61]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[62] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[62]),
        .Q(o_data_V_user_V_1_payload_A[62]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[63] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[63]),
        .Q(o_data_V_user_V_1_payload_A[63]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[64] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[64]),
        .Q(o_data_V_user_V_1_payload_A[64]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[65] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[65]),
        .Q(o_data_V_user_V_1_payload_A[65]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[66] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[66]),
        .Q(o_data_V_user_V_1_payload_A[66]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[67] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[67]),
        .Q(o_data_V_user_V_1_payload_A[67]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[68] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[68]),
        .Q(o_data_V_user_V_1_payload_A[68]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[69] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[69]),
        .Q(o_data_V_user_V_1_payload_A[69]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[6] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[6]),
        .Q(o_data_V_user_V_1_payload_A[6]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[70] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[70]),
        .Q(o_data_V_user_V_1_payload_A[70]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[71] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[71]),
        .Q(o_data_V_user_V_1_payload_A[71]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[72] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(grp_handle_header_fu_175_n_9),
        .Q(o_data_V_user_V_1_payload_A[72]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[73] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[73]),
        .Q(o_data_V_user_V_1_payload_A[73]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[74] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[74]),
        .Q(o_data_V_user_V_1_payload_A[74]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[75] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[75]),
        .Q(o_data_V_user_V_1_payload_A[75]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[76] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[76]),
        .Q(o_data_V_user_V_1_payload_A[76]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[77] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[77]),
        .Q(o_data_V_user_V_1_payload_A[77]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[78] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[78]),
        .Q(o_data_V_user_V_1_payload_A[78]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[79] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[79]),
        .Q(o_data_V_user_V_1_payload_A[79]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[7] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[7]),
        .Q(o_data_V_user_V_1_payload_A[7]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[80] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[80]),
        .Q(o_data_V_user_V_1_payload_A[80]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[81] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[81]),
        .Q(o_data_V_user_V_1_payload_A[81]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[82] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[82]),
        .Q(o_data_V_user_V_1_payload_A[82]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[83] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[83]),
        .Q(o_data_V_user_V_1_payload_A[83]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[84] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[84]),
        .Q(o_data_V_user_V_1_payload_A[84]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[85] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[85]),
        .Q(o_data_V_user_V_1_payload_A[85]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[86] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[86]),
        .Q(o_data_V_user_V_1_payload_A[86]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[87] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[87]),
        .Q(o_data_V_user_V_1_payload_A[87]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[88] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[88]),
        .Q(o_data_V_user_V_1_payload_A[88]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[89] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[89]),
        .Q(o_data_V_user_V_1_payload_A[89]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[8] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[8]),
        .Q(o_data_V_user_V_1_payload_A[8]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[90] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[90]),
        .Q(o_data_V_user_V_1_payload_A[90]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[91] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[91]),
        .Q(o_data_V_user_V_1_payload_A[91]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[92] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[92]),
        .Q(o_data_V_user_V_1_payload_A[92]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[93] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[93]),
        .Q(o_data_V_user_V_1_payload_A[93]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[94] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[94]),
        .Q(o_data_V_user_V_1_payload_A[94]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[95] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[95]),
        .Q(o_data_V_user_V_1_payload_A[95]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[96] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[96]),
        .Q(o_data_V_user_V_1_payload_A[96]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[97] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[97]),
        .Q(o_data_V_user_V_1_payload_A[97]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[98] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[98]),
        .Q(o_data_V_user_V_1_payload_A[98]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[99] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[99]),
        .Q(o_data_V_user_V_1_payload_A[99]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_A_reg[9] 
       (.C(ap_clk),
        .CE(\o_data_V_user_V_1_payload_A[127]_i_1_n_0 ),
        .D(o_data_V_user_V_1_data_in[9]),
        .Q(o_data_V_user_V_1_payload_A[9]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hA2)) 
    \o_data_V_user_V_1_payload_B[127]_i_1 
       (.I0(o_data_V_user_V_1_sel_wr),
        .I1(\o_data_V_user_V_1_state_reg_n_0_[0] ),
        .I2(o_data_V_user_V_1_ack_in),
        .O(o_data_V_user_V_1_load_B));
  FDRE \o_data_V_user_V_1_payload_B_reg[0] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[0]),
        .Q(o_data_V_user_V_1_payload_B[0]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[100] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[100]),
        .Q(o_data_V_user_V_1_payload_B[100]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[101] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[101]),
        .Q(o_data_V_user_V_1_payload_B[101]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[102] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[102]),
        .Q(o_data_V_user_V_1_payload_B[102]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[103] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[103]),
        .Q(o_data_V_user_V_1_payload_B[103]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[104] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[104]),
        .Q(o_data_V_user_V_1_payload_B[104]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[105] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[105]),
        .Q(o_data_V_user_V_1_payload_B[105]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[106] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[106]),
        .Q(o_data_V_user_V_1_payload_B[106]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[107] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[107]),
        .Q(o_data_V_user_V_1_payload_B[107]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[108] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[108]),
        .Q(o_data_V_user_V_1_payload_B[108]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[109] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[109]),
        .Q(o_data_V_user_V_1_payload_B[109]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[10] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[10]),
        .Q(o_data_V_user_V_1_payload_B[10]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[110] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[110]),
        .Q(o_data_V_user_V_1_payload_B[110]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[111] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[111]),
        .Q(o_data_V_user_V_1_payload_B[111]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[112] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[112]),
        .Q(o_data_V_user_V_1_payload_B[112]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[113] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[113]),
        .Q(o_data_V_user_V_1_payload_B[113]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[114] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[114]),
        .Q(o_data_V_user_V_1_payload_B[114]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[115] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[115]),
        .Q(o_data_V_user_V_1_payload_B[115]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[116] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[116]),
        .Q(o_data_V_user_V_1_payload_B[116]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[117] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[117]),
        .Q(o_data_V_user_V_1_payload_B[117]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[118] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[118]),
        .Q(o_data_V_user_V_1_payload_B[118]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[119] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[119]),
        .Q(o_data_V_user_V_1_payload_B[119]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[11] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[11]),
        .Q(o_data_V_user_V_1_payload_B[11]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[120] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[120]),
        .Q(o_data_V_user_V_1_payload_B[120]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[121] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[121]),
        .Q(o_data_V_user_V_1_payload_B[121]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[122] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[122]),
        .Q(o_data_V_user_V_1_payload_B[122]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[123] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[123]),
        .Q(o_data_V_user_V_1_payload_B[123]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[124] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[124]),
        .Q(o_data_V_user_V_1_payload_B[124]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[125] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[125]),
        .Q(o_data_V_user_V_1_payload_B[125]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[126] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[126]),
        .Q(o_data_V_user_V_1_payload_B[126]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[127] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[127]),
        .Q(o_data_V_user_V_1_payload_B[127]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[12] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[12]),
        .Q(o_data_V_user_V_1_payload_B[12]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[13] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[13]),
        .Q(o_data_V_user_V_1_payload_B[13]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[14] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[14]),
        .Q(o_data_V_user_V_1_payload_B[14]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[15] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[15]),
        .Q(o_data_V_user_V_1_payload_B[15]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[16] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[16]),
        .Q(o_data_V_user_V_1_payload_B[16]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[17] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[17]),
        .Q(o_data_V_user_V_1_payload_B[17]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[18] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[18]),
        .Q(o_data_V_user_V_1_payload_B[18]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[19] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[19]),
        .Q(o_data_V_user_V_1_payload_B[19]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[1] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[1]),
        .Q(o_data_V_user_V_1_payload_B[1]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[20] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[20]),
        .Q(o_data_V_user_V_1_payload_B[20]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[21] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[21]),
        .Q(o_data_V_user_V_1_payload_B[21]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[22] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[22]),
        .Q(o_data_V_user_V_1_payload_B[22]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[23] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[23]),
        .Q(o_data_V_user_V_1_payload_B[23]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[24] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[24]),
        .Q(o_data_V_user_V_1_payload_B[24]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[25] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[25]),
        .Q(o_data_V_user_V_1_payload_B[25]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[26] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[26]),
        .Q(o_data_V_user_V_1_payload_B[26]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[27] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[27]),
        .Q(o_data_V_user_V_1_payload_B[27]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[28] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[28]),
        .Q(o_data_V_user_V_1_payload_B[28]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[29] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[29]),
        .Q(o_data_V_user_V_1_payload_B[29]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[2] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[2]),
        .Q(o_data_V_user_V_1_payload_B[2]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[30] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[30]),
        .Q(o_data_V_user_V_1_payload_B[30]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[31] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[31]),
        .Q(o_data_V_user_V_1_payload_B[31]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[32] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[32]),
        .Q(o_data_V_user_V_1_payload_B[32]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[33] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[33]),
        .Q(o_data_V_user_V_1_payload_B[33]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[34] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[34]),
        .Q(o_data_V_user_V_1_payload_B[34]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[35] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[35]),
        .Q(o_data_V_user_V_1_payload_B[35]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[36] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[36]),
        .Q(o_data_V_user_V_1_payload_B[36]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[37] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[37]),
        .Q(o_data_V_user_V_1_payload_B[37]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[38] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[38]),
        .Q(o_data_V_user_V_1_payload_B[38]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[39] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[39]),
        .Q(o_data_V_user_V_1_payload_B[39]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[3] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[3]),
        .Q(o_data_V_user_V_1_payload_B[3]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[40] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[40]),
        .Q(o_data_V_user_V_1_payload_B[40]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[41] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[41]),
        .Q(o_data_V_user_V_1_payload_B[41]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[42] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[42]),
        .Q(o_data_V_user_V_1_payload_B[42]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[43] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[43]),
        .Q(o_data_V_user_V_1_payload_B[43]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[44] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[44]),
        .Q(o_data_V_user_V_1_payload_B[44]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[45] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[45]),
        .Q(o_data_V_user_V_1_payload_B[45]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[46] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[46]),
        .Q(o_data_V_user_V_1_payload_B[46]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[47] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[47]),
        .Q(o_data_V_user_V_1_payload_B[47]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[48] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[48]),
        .Q(o_data_V_user_V_1_payload_B[48]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[49] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[49]),
        .Q(o_data_V_user_V_1_payload_B[49]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[4] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[4]),
        .Q(o_data_V_user_V_1_payload_B[4]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[50] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[50]),
        .Q(o_data_V_user_V_1_payload_B[50]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[51] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[51]),
        .Q(o_data_V_user_V_1_payload_B[51]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[52] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[52]),
        .Q(o_data_V_user_V_1_payload_B[52]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[53] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[53]),
        .Q(o_data_V_user_V_1_payload_B[53]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[54] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[54]),
        .Q(o_data_V_user_V_1_payload_B[54]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[55] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[55]),
        .Q(o_data_V_user_V_1_payload_B[55]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[56] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[56]),
        .Q(o_data_V_user_V_1_payload_B[56]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[57] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[57]),
        .Q(o_data_V_user_V_1_payload_B[57]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[58] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[58]),
        .Q(o_data_V_user_V_1_payload_B[58]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[59] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[59]),
        .Q(o_data_V_user_V_1_payload_B[59]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[5] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[5]),
        .Q(o_data_V_user_V_1_payload_B[5]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[60] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[60]),
        .Q(o_data_V_user_V_1_payload_B[60]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[61] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[61]),
        .Q(o_data_V_user_V_1_payload_B[61]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[62] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[62]),
        .Q(o_data_V_user_V_1_payload_B[62]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[63] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[63]),
        .Q(o_data_V_user_V_1_payload_B[63]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[64] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[64]),
        .Q(o_data_V_user_V_1_payload_B[64]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[65] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[65]),
        .Q(o_data_V_user_V_1_payload_B[65]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[66] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[66]),
        .Q(o_data_V_user_V_1_payload_B[66]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[67] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[67]),
        .Q(o_data_V_user_V_1_payload_B[67]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[68] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[68]),
        .Q(o_data_V_user_V_1_payload_B[68]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[69] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[69]),
        .Q(o_data_V_user_V_1_payload_B[69]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[6] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[6]),
        .Q(o_data_V_user_V_1_payload_B[6]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[70] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[70]),
        .Q(o_data_V_user_V_1_payload_B[70]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[71] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[71]),
        .Q(o_data_V_user_V_1_payload_B[71]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[72] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(grp_handle_header_fu_175_n_9),
        .Q(o_data_V_user_V_1_payload_B[72]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[73] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[73]),
        .Q(o_data_V_user_V_1_payload_B[73]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[74] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[74]),
        .Q(o_data_V_user_V_1_payload_B[74]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[75] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[75]),
        .Q(o_data_V_user_V_1_payload_B[75]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[76] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[76]),
        .Q(o_data_V_user_V_1_payload_B[76]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[77] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[77]),
        .Q(o_data_V_user_V_1_payload_B[77]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[78] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[78]),
        .Q(o_data_V_user_V_1_payload_B[78]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[79] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[79]),
        .Q(o_data_V_user_V_1_payload_B[79]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[7] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[7]),
        .Q(o_data_V_user_V_1_payload_B[7]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[80] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[80]),
        .Q(o_data_V_user_V_1_payload_B[80]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[81] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[81]),
        .Q(o_data_V_user_V_1_payload_B[81]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[82] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[82]),
        .Q(o_data_V_user_V_1_payload_B[82]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[83] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[83]),
        .Q(o_data_V_user_V_1_payload_B[83]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[84] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[84]),
        .Q(o_data_V_user_V_1_payload_B[84]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[85] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[85]),
        .Q(o_data_V_user_V_1_payload_B[85]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[86] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[86]),
        .Q(o_data_V_user_V_1_payload_B[86]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[87] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[87]),
        .Q(o_data_V_user_V_1_payload_B[87]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[88] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[88]),
        .Q(o_data_V_user_V_1_payload_B[88]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[89] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[89]),
        .Q(o_data_V_user_V_1_payload_B[89]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[8] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[8]),
        .Q(o_data_V_user_V_1_payload_B[8]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[90] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[90]),
        .Q(o_data_V_user_V_1_payload_B[90]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[91] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[91]),
        .Q(o_data_V_user_V_1_payload_B[91]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[92] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[92]),
        .Q(o_data_V_user_V_1_payload_B[92]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[93] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[93]),
        .Q(o_data_V_user_V_1_payload_B[93]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[94] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[94]),
        .Q(o_data_V_user_V_1_payload_B[94]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[95] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[95]),
        .Q(o_data_V_user_V_1_payload_B[95]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[96] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[96]),
        .Q(o_data_V_user_V_1_payload_B[96]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[97] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[97]),
        .Q(o_data_V_user_V_1_payload_B[97]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[98] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[98]),
        .Q(o_data_V_user_V_1_payload_B[98]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[99] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[99]),
        .Q(o_data_V_user_V_1_payload_B[99]),
        .R(1'b0));
  FDRE \o_data_V_user_V_1_payload_B_reg[9] 
       (.C(ap_clk),
        .CE(o_data_V_user_V_1_load_B),
        .D(o_data_V_user_V_1_data_in[9]),
        .Q(o_data_V_user_V_1_payload_B[9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair199" *) 
  LUT3 #(
    .INIT(8'h78)) 
    o_data_V_user_V_1_sel_rd_i_1
       (.I0(o_data_TREADY),
        .I1(\o_data_V_user_V_1_state_reg_n_0_[0] ),
        .I2(o_data_V_user_V_1_sel),
        .O(o_data_V_user_V_1_sel_rd_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    o_data_V_user_V_1_sel_rd_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(o_data_V_user_V_1_sel_rd_i_1_n_0),
        .Q(o_data_V_user_V_1_sel),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    o_data_V_user_V_1_sel_wr_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_102),
        .Q(o_data_V_user_V_1_sel_wr),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \o_data_V_user_V_1_state_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_4),
        .Q(\o_data_V_user_V_1_state_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \o_data_V_user_V_1_state_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_95),
        .Q(o_data_V_user_V_1_ack_in),
        .R(ap_rst));
  LUT4 #(
    .INIT(16'hE400)) 
    \pos_enc_0_read_reg_681[31]_i_1 
       (.I0(i_data_V_user_V_0_sel),
        .I1(i_data_V_user_V_0_payload_A[72]),
        .I2(i_data_V_user_V_0_payload_B[72]),
        .I3(p_222_in),
        .O(ap_start0));
  FDRE \pos_enc_0_read_reg_681_reg[0] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[0]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[10] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[10]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[10] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[11] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[11]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[11] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[12] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[12]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[12] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[13] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[13]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[13] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[14] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[14]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[14] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[15] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[15]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[15] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[16] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[16]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[16] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[17] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[17]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[17] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[18] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[18]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[18] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[19] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[19]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[19] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[1] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[1]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[20] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[20]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[20] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[21] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[21]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[21] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[22] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[22]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[22] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[23] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[23]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[23] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[24] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[24]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[24] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[25] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[25]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[25] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[26] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[26]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[26] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[27] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[27]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[27] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[28] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[28]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[28] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[29] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[29]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[29] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[2] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[2]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[30] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[30]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[30] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[31] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[31]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[31] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[3] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[3]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[4] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[4]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[5] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[5]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[5] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[6] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[6]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[6] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[7] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[7]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[7] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[8] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[8]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[8] ),
        .R(1'b0));
  FDRE \pos_enc_0_read_reg_681_reg[9] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_0[9]),
        .Q(\pos_enc_0_read_reg_681_reg_n_0_[9] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[0] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[0]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[10] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[10]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[10] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[11] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[11]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[11] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[12] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[12]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[12] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[13] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[13]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[13] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[14] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[14]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[14] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[15] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[15]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[15] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[16] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[16]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[16] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[17] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[17]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[17] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[18] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[18]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[18] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[19] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[19]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[19] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[1] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[1]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[20] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[20]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[20] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[21] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[21]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[21] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[22] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[22]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[22] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[23] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[23]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[23] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[24] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[24]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[24] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[25] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[25]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[25] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[26] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[26]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[26] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[27] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[27]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[27] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[28] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[28]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[28] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[29] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[29]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[29] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[2] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[2]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[30] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[30]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[30] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[31] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[31]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[31] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[3] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[3]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[4] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[4]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[5] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[5]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[5] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[6] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[6]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[6] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[7] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[7]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[7] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[8] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[8]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[8] ),
        .R(1'b0));
  FDRE \pos_enc_1_read_reg_686_reg[9] 
       (.C(ap_clk),
        .CE(ap_start0),
        .D(pos_enc_1[9]),
        .Q(\pos_enc_1_read_reg_686_reg_n_0_[9] ),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h0D)) 
    \pulse_metadata_V_0_payload_A[820]_i_1 
       (.I0(\pulse_metadata_V_0_state_reg_n_0_[0] ),
        .I1(pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel_wr),
        .O(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ));
  FDRE \pulse_metadata_V_0_payload_A_reg[0] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[0]),
        .Q(pulse_metadata_V_0_payload_A[0]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[10] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[10]),
        .Q(pulse_metadata_V_0_payload_A[10]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[11] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[11]),
        .Q(pulse_metadata_V_0_payload_A[11]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[12] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[12]),
        .Q(pulse_metadata_V_0_payload_A[12]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[13] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[13]),
        .Q(pulse_metadata_V_0_payload_A[13]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[14] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[14]),
        .Q(pulse_metadata_V_0_payload_A[14]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[15] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[15]),
        .Q(pulse_metadata_V_0_payload_A[15]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[16] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[16]),
        .Q(pulse_metadata_V_0_payload_A[16]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[17] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[17]),
        .Q(pulse_metadata_V_0_payload_A[17]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[18] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[18]),
        .Q(pulse_metadata_V_0_payload_A[18]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[19] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[19]),
        .Q(pulse_metadata_V_0_payload_A[19]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[1] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[1]),
        .Q(pulse_metadata_V_0_payload_A[1]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[20] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[20]),
        .Q(pulse_metadata_V_0_payload_A[20]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[21] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[21]),
        .Q(pulse_metadata_V_0_payload_A[21]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[22] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[22]),
        .Q(pulse_metadata_V_0_payload_A[22]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[23] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[23]),
        .Q(pulse_metadata_V_0_payload_A[23]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[24] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[24]),
        .Q(pulse_metadata_V_0_payload_A[24]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[25] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[25]),
        .Q(pulse_metadata_V_0_payload_A[25]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[26] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[26]),
        .Q(pulse_metadata_V_0_payload_A[26]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[27] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[27]),
        .Q(pulse_metadata_V_0_payload_A[27]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[28] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[28]),
        .Q(pulse_metadata_V_0_payload_A[28]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[29] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[29]),
        .Q(pulse_metadata_V_0_payload_A[29]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[2] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[2]),
        .Q(pulse_metadata_V_0_payload_A[2]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[30] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[30]),
        .Q(pulse_metadata_V_0_payload_A[30]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[31] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[31]),
        .Q(pulse_metadata_V_0_payload_A[31]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[3] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[3]),
        .Q(pulse_metadata_V_0_payload_A[3]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[4] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[4]),
        .Q(pulse_metadata_V_0_payload_A[4]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[5] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[5]),
        .Q(pulse_metadata_V_0_payload_A[5]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[6] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[6]),
        .Q(pulse_metadata_V_0_payload_A[6]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[768] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[768]),
        .Q(pulse_metadata_V_0_payload_A[768]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[769] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[769]),
        .Q(pulse_metadata_V_0_payload_A[769]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[770] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[770]),
        .Q(pulse_metadata_V_0_payload_A[770]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[771] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[771]),
        .Q(pulse_metadata_V_0_payload_A[771]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[772] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[772]),
        .Q(pulse_metadata_V_0_payload_A[772]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[773] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[773]),
        .Q(pulse_metadata_V_0_payload_A[773]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[774] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[774]),
        .Q(pulse_metadata_V_0_payload_A[774]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[775] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[775]),
        .Q(pulse_metadata_V_0_payload_A[775]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[776] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[776]),
        .Q(pulse_metadata_V_0_payload_A[776]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[777] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[777]),
        .Q(pulse_metadata_V_0_payload_A[777]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[778] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[778]),
        .Q(pulse_metadata_V_0_payload_A[778]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[779] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[779]),
        .Q(pulse_metadata_V_0_payload_A[779]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[780] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[780]),
        .Q(pulse_metadata_V_0_payload_A[780]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[781] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[781]),
        .Q(pulse_metadata_V_0_payload_A[781]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[782] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[782]),
        .Q(pulse_metadata_V_0_payload_A[782]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[783] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[783]),
        .Q(pulse_metadata_V_0_payload_A[783]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[784] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[784]),
        .Q(pulse_metadata_V_0_payload_A[784]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[785] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[785]),
        .Q(pulse_metadata_V_0_payload_A[785]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[786] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[786]),
        .Q(pulse_metadata_V_0_payload_A[786]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[787] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[787]),
        .Q(pulse_metadata_V_0_payload_A[787]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[788] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[788]),
        .Q(pulse_metadata_V_0_payload_A[788]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[789] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[789]),
        .Q(pulse_metadata_V_0_payload_A[789]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[790] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[790]),
        .Q(pulse_metadata_V_0_payload_A[790]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[791] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[791]),
        .Q(pulse_metadata_V_0_payload_A[791]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[792] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[792]),
        .Q(pulse_metadata_V_0_payload_A[792]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[793] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[793]),
        .Q(pulse_metadata_V_0_payload_A[793]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[794] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[794]),
        .Q(pulse_metadata_V_0_payload_A[794]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[795] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[795]),
        .Q(pulse_metadata_V_0_payload_A[795]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[796] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[796]),
        .Q(pulse_metadata_V_0_payload_A[796]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[797] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[797]),
        .Q(pulse_metadata_V_0_payload_A[797]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[798] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[798]),
        .Q(pulse_metadata_V_0_payload_A[798]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[799] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[799]),
        .Q(pulse_metadata_V_0_payload_A[799]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[7] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[7]),
        .Q(pulse_metadata_V_0_payload_A[7]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[800] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[800]),
        .Q(pulse_metadata_V_0_payload_A[800]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[801] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[801]),
        .Q(pulse_metadata_V_0_payload_A[801]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[802] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[802]),
        .Q(pulse_metadata_V_0_payload_A[802]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[803] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[803]),
        .Q(pulse_metadata_V_0_payload_A[803]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[804] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[804]),
        .Q(pulse_metadata_V_0_payload_A[804]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[805] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[805]),
        .Q(pulse_metadata_V_0_payload_A[805]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[806] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[806]),
        .Q(pulse_metadata_V_0_payload_A[806]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[807] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[807]),
        .Q(pulse_metadata_V_0_payload_A[807]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[808] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[808]),
        .Q(pulse_metadata_V_0_payload_A[808]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[809] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[809]),
        .Q(pulse_metadata_V_0_payload_A[809]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[810] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[810]),
        .Q(pulse_metadata_V_0_payload_A[810]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[811] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[811]),
        .Q(pulse_metadata_V_0_payload_A[811]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[812] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[812]),
        .Q(pulse_metadata_V_0_payload_A[812]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[813] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[813]),
        .Q(pulse_metadata_V_0_payload_A[813]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[814] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[814]),
        .Q(pulse_metadata_V_0_payload_A[814]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[815] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[815]),
        .Q(pulse_metadata_V_0_payload_A[815]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[816] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[816]),
        .Q(pulse_metadata_V_0_payload_A[816]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[817] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[817]),
        .Q(pulse_metadata_V_0_payload_A[817]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[818] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[818]),
        .Q(pulse_metadata_V_0_payload_A[818]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[819] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[819]),
        .Q(pulse_metadata_V_0_payload_A[819]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[820] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[820]),
        .Q(pulse_metadata_V_0_payload_A[820]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[8] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[8]),
        .Q(pulse_metadata_V_0_payload_A[8]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_A_reg[9] 
       (.C(ap_clk),
        .CE(\pulse_metadata_V_0_payload_A[820]_i_1_n_0 ),
        .D(pulse_metadata_V_TDATA[9]),
        .Q(pulse_metadata_V_0_payload_A[9]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hA2)) 
    \pulse_metadata_V_0_payload_B[820]_i_1 
       (.I0(pulse_metadata_V_0_sel_wr),
        .I1(\pulse_metadata_V_0_state_reg_n_0_[0] ),
        .I2(pulse_metadata_V_TREADY),
        .O(pulse_metadata_V_0_load_B));
  FDRE \pulse_metadata_V_0_payload_B_reg[0] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[0]),
        .Q(pulse_metadata_V_0_payload_B[0]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[10] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[10]),
        .Q(pulse_metadata_V_0_payload_B[10]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[11] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[11]),
        .Q(pulse_metadata_V_0_payload_B[11]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[12] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[12]),
        .Q(pulse_metadata_V_0_payload_B[12]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[13] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[13]),
        .Q(pulse_metadata_V_0_payload_B[13]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[14] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[14]),
        .Q(pulse_metadata_V_0_payload_B[14]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[15] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[15]),
        .Q(pulse_metadata_V_0_payload_B[15]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[16] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[16]),
        .Q(pulse_metadata_V_0_payload_B[16]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[17] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[17]),
        .Q(pulse_metadata_V_0_payload_B[17]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[18] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[18]),
        .Q(pulse_metadata_V_0_payload_B[18]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[19] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[19]),
        .Q(pulse_metadata_V_0_payload_B[19]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[1] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[1]),
        .Q(pulse_metadata_V_0_payload_B[1]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[20] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[20]),
        .Q(pulse_metadata_V_0_payload_B[20]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[21] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[21]),
        .Q(pulse_metadata_V_0_payload_B[21]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[22] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[22]),
        .Q(pulse_metadata_V_0_payload_B[22]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[23] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[23]),
        .Q(pulse_metadata_V_0_payload_B[23]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[24] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[24]),
        .Q(pulse_metadata_V_0_payload_B[24]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[25] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[25]),
        .Q(pulse_metadata_V_0_payload_B[25]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[26] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[26]),
        .Q(pulse_metadata_V_0_payload_B[26]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[27] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[27]),
        .Q(pulse_metadata_V_0_payload_B[27]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[28] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[28]),
        .Q(pulse_metadata_V_0_payload_B[28]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[29] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[29]),
        .Q(pulse_metadata_V_0_payload_B[29]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[2] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[2]),
        .Q(pulse_metadata_V_0_payload_B[2]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[30] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[30]),
        .Q(pulse_metadata_V_0_payload_B[30]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[31] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[31]),
        .Q(pulse_metadata_V_0_payload_B[31]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[3] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[3]),
        .Q(pulse_metadata_V_0_payload_B[3]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[4] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[4]),
        .Q(pulse_metadata_V_0_payload_B[4]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[5] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[5]),
        .Q(pulse_metadata_V_0_payload_B[5]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[6] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[6]),
        .Q(pulse_metadata_V_0_payload_B[6]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[768] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[768]),
        .Q(pulse_metadata_V_0_payload_B[768]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[769] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[769]),
        .Q(pulse_metadata_V_0_payload_B[769]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[770] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[770]),
        .Q(pulse_metadata_V_0_payload_B[770]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[771] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[771]),
        .Q(pulse_metadata_V_0_payload_B[771]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[772] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[772]),
        .Q(pulse_metadata_V_0_payload_B[772]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[773] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[773]),
        .Q(pulse_metadata_V_0_payload_B[773]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[774] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[774]),
        .Q(pulse_metadata_V_0_payload_B[774]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[775] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[775]),
        .Q(pulse_metadata_V_0_payload_B[775]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[776] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[776]),
        .Q(pulse_metadata_V_0_payload_B[776]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[777] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[777]),
        .Q(pulse_metadata_V_0_payload_B[777]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[778] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[778]),
        .Q(pulse_metadata_V_0_payload_B[778]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[779] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[779]),
        .Q(pulse_metadata_V_0_payload_B[779]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[780] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[780]),
        .Q(pulse_metadata_V_0_payload_B[780]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[781] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[781]),
        .Q(pulse_metadata_V_0_payload_B[781]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[782] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[782]),
        .Q(pulse_metadata_V_0_payload_B[782]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[783] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[783]),
        .Q(pulse_metadata_V_0_payload_B[783]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[784] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[784]),
        .Q(pulse_metadata_V_0_payload_B[784]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[785] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[785]),
        .Q(pulse_metadata_V_0_payload_B[785]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[786] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[786]),
        .Q(pulse_metadata_V_0_payload_B[786]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[787] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[787]),
        .Q(pulse_metadata_V_0_payload_B[787]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[788] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[788]),
        .Q(pulse_metadata_V_0_payload_B[788]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[789] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[789]),
        .Q(pulse_metadata_V_0_payload_B[789]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[790] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[790]),
        .Q(pulse_metadata_V_0_payload_B[790]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[791] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[791]),
        .Q(pulse_metadata_V_0_payload_B[791]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[792] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[792]),
        .Q(pulse_metadata_V_0_payload_B[792]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[793] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[793]),
        .Q(pulse_metadata_V_0_payload_B[793]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[794] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[794]),
        .Q(pulse_metadata_V_0_payload_B[794]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[795] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[795]),
        .Q(pulse_metadata_V_0_payload_B[795]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[796] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[796]),
        .Q(pulse_metadata_V_0_payload_B[796]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[797] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[797]),
        .Q(pulse_metadata_V_0_payload_B[797]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[798] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[798]),
        .Q(pulse_metadata_V_0_payload_B[798]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[799] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[799]),
        .Q(pulse_metadata_V_0_payload_B[799]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[7] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[7]),
        .Q(pulse_metadata_V_0_payload_B[7]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[800] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[800]),
        .Q(pulse_metadata_V_0_payload_B[800]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[801] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[801]),
        .Q(pulse_metadata_V_0_payload_B[801]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[802] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[802]),
        .Q(pulse_metadata_V_0_payload_B[802]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[803] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[803]),
        .Q(pulse_metadata_V_0_payload_B[803]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[804] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[804]),
        .Q(pulse_metadata_V_0_payload_B[804]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[805] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[805]),
        .Q(pulse_metadata_V_0_payload_B[805]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[806] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[806]),
        .Q(pulse_metadata_V_0_payload_B[806]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[807] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[807]),
        .Q(pulse_metadata_V_0_payload_B[807]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[808] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[808]),
        .Q(pulse_metadata_V_0_payload_B[808]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[809] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[809]),
        .Q(pulse_metadata_V_0_payload_B[809]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[810] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[810]),
        .Q(pulse_metadata_V_0_payload_B[810]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[811] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[811]),
        .Q(pulse_metadata_V_0_payload_B[811]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[812] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[812]),
        .Q(pulse_metadata_V_0_payload_B[812]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[813] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[813]),
        .Q(pulse_metadata_V_0_payload_B[813]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[814] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[814]),
        .Q(pulse_metadata_V_0_payload_B[814]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[815] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[815]),
        .Q(pulse_metadata_V_0_payload_B[815]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[816] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[816]),
        .Q(pulse_metadata_V_0_payload_B[816]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[817] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[817]),
        .Q(pulse_metadata_V_0_payload_B[817]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[818] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[818]),
        .Q(pulse_metadata_V_0_payload_B[818]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[819] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[819]),
        .Q(pulse_metadata_V_0_payload_B[819]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[820] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[820]),
        .Q(pulse_metadata_V_0_payload_B[820]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[8] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[8]),
        .Q(pulse_metadata_V_0_payload_B[8]),
        .R(1'b0));
  FDRE \pulse_metadata_V_0_payload_B_reg[9] 
       (.C(ap_clk),
        .CE(pulse_metadata_V_0_load_B),
        .D(pulse_metadata_V_TDATA[9]),
        .Q(pulse_metadata_V_0_payload_B[9]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    pulse_metadata_V_0_sel_rd_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_108),
        .Q(pulse_metadata_V_0_sel),
        .R(ap_rst));
  LUT3 #(
    .INIT(8'h78)) 
    pulse_metadata_V_0_sel_wr_i_1
       (.I0(pulse_metadata_V_TVALID),
        .I1(pulse_metadata_V_TREADY),
        .I2(pulse_metadata_V_0_sel_wr),
        .O(pulse_metadata_V_0_sel_wr_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    pulse_metadata_V_0_sel_wr_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(pulse_metadata_V_0_sel_wr_i_1_n_0),
        .Q(pulse_metadata_V_0_sel_wr),
        .R(ap_rst));
  FDRE #(
    .INIT(1'b0)) 
    \pulse_metadata_V_0_state_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_8),
        .Q(\pulse_metadata_V_0_state_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \pulse_metadata_V_0_state_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(grp_handle_header_fu_175_n_107),
        .Q(pulse_metadata_V_TREADY),
        .R(ap_rst));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[16]_i_10 
       (.I0(sample_counter_fu_94[9]),
        .O(\sample_counter_fu_94[16]_i_10_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[16]_i_3 
       (.I0(sample_counter_fu_94[16]),
        .O(\sample_counter_fu_94[16]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[16]_i_4 
       (.I0(sample_counter_fu_94[15]),
        .O(\sample_counter_fu_94[16]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[16]_i_5 
       (.I0(sample_counter_fu_94[14]),
        .O(\sample_counter_fu_94[16]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[16]_i_6 
       (.I0(sample_counter_fu_94[13]),
        .O(\sample_counter_fu_94[16]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[16]_i_7 
       (.I0(sample_counter_fu_94[12]),
        .O(\sample_counter_fu_94[16]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[16]_i_8 
       (.I0(sample_counter_fu_94[11]),
        .O(\sample_counter_fu_94[16]_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[16]_i_9 
       (.I0(sample_counter_fu_94[10]),
        .O(\sample_counter_fu_94[16]_i_9_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[24]_i_10 
       (.I0(sample_counter_fu_94[17]),
        .O(\sample_counter_fu_94[24]_i_10_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[24]_i_3 
       (.I0(sample_counter_fu_94[24]),
        .O(\sample_counter_fu_94[24]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[24]_i_4 
       (.I0(sample_counter_fu_94[23]),
        .O(\sample_counter_fu_94[24]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[24]_i_5 
       (.I0(sample_counter_fu_94[22]),
        .O(\sample_counter_fu_94[24]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[24]_i_6 
       (.I0(sample_counter_fu_94[21]),
        .O(\sample_counter_fu_94[24]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[24]_i_7 
       (.I0(sample_counter_fu_94[20]),
        .O(\sample_counter_fu_94[24]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[24]_i_8 
       (.I0(sample_counter_fu_94[19]),
        .O(\sample_counter_fu_94[24]_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[24]_i_9 
       (.I0(sample_counter_fu_94[18]),
        .O(\sample_counter_fu_94[24]_i_9_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[31]_i_10 
       (.I0(sample_counter_fu_94[26]),
        .O(\sample_counter_fu_94[31]_i_10_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[31]_i_11 
       (.I0(sample_counter_fu_94[25]),
        .O(\sample_counter_fu_94[31]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[31]_i_5 
       (.I0(sample_counter_fu_94[31]),
        .O(\sample_counter_fu_94[31]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[31]_i_6 
       (.I0(sample_counter_fu_94[30]),
        .O(\sample_counter_fu_94[31]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[31]_i_7 
       (.I0(sample_counter_fu_94[29]),
        .O(\sample_counter_fu_94[31]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[31]_i_8 
       (.I0(sample_counter_fu_94[28]),
        .O(\sample_counter_fu_94[31]_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[31]_i_9 
       (.I0(sample_counter_fu_94[27]),
        .O(\sample_counter_fu_94[31]_i_9_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[8]_i_10 
       (.I0(sample_counter_fu_94[1]),
        .O(\sample_counter_fu_94[8]_i_10_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[8]_i_3 
       (.I0(sample_counter_fu_94[8]),
        .O(\sample_counter_fu_94[8]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[8]_i_4 
       (.I0(sample_counter_fu_94[7]),
        .O(\sample_counter_fu_94[8]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[8]_i_5 
       (.I0(sample_counter_fu_94[6]),
        .O(\sample_counter_fu_94[8]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[8]_i_6 
       (.I0(sample_counter_fu_94[5]),
        .O(\sample_counter_fu_94[8]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[8]_i_7 
       (.I0(sample_counter_fu_94[4]),
        .O(\sample_counter_fu_94[8]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[8]_i_8 
       (.I0(sample_counter_fu_94[3]),
        .O(\sample_counter_fu_94[8]_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sample_counter_fu_94[8]_i_9 
       (.I0(sample_counter_fu_94[2]),
        .O(\sample_counter_fu_94[8]_i_9_n_0 ));
  FDRE \sample_counter_fu_94_reg[0] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_74),
        .Q(sample_counter_fu_94[0]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[10] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_64),
        .Q(sample_counter_fu_94[10]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[11] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_63),
        .Q(sample_counter_fu_94[11]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[12] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_62),
        .Q(sample_counter_fu_94[12]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[13] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_61),
        .Q(sample_counter_fu_94[13]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[14] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_60),
        .Q(sample_counter_fu_94[14]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[15] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_59),
        .Q(sample_counter_fu_94[15]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[16] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_58),
        .Q(sample_counter_fu_94[16]),
        .R(1'b0));
  CARRY8 \sample_counter_fu_94_reg[16]_i_2 
       (.CI(\sample_counter_fu_94_reg[8]_i_2_n_0 ),
        .CI_TOP(1'b0),
        .CO({\sample_counter_fu_94_reg[16]_i_2_n_0 ,\sample_counter_fu_94_reg[16]_i_2_n_1 ,\sample_counter_fu_94_reg[16]_i_2_n_2 ,\sample_counter_fu_94_reg[16]_i_2_n_3 ,\NLW_sample_counter_fu_94_reg[16]_i_2_CO_UNCONNECTED [3],\sample_counter_fu_94_reg[16]_i_2_n_5 ,\sample_counter_fu_94_reg[16]_i_2_n_6 ,\sample_counter_fu_94_reg[16]_i_2_n_7 }),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .O(sample_counter_1_fu_430_p2[16:9]),
        .S({\sample_counter_fu_94[16]_i_3_n_0 ,\sample_counter_fu_94[16]_i_4_n_0 ,\sample_counter_fu_94[16]_i_5_n_0 ,\sample_counter_fu_94[16]_i_6_n_0 ,\sample_counter_fu_94[16]_i_7_n_0 ,\sample_counter_fu_94[16]_i_8_n_0 ,\sample_counter_fu_94[16]_i_9_n_0 ,\sample_counter_fu_94[16]_i_10_n_0 }));
  FDRE \sample_counter_fu_94_reg[17] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_57),
        .Q(sample_counter_fu_94[17]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[18] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_56),
        .Q(sample_counter_fu_94[18]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[19] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_55),
        .Q(sample_counter_fu_94[19]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[1] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_73),
        .Q(sample_counter_fu_94[1]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[20] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_54),
        .Q(sample_counter_fu_94[20]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[21] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_53),
        .Q(sample_counter_fu_94[21]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[22] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_52),
        .Q(sample_counter_fu_94[22]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[23] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_51),
        .Q(sample_counter_fu_94[23]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[24] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_50),
        .Q(sample_counter_fu_94[24]),
        .R(1'b0));
  CARRY8 \sample_counter_fu_94_reg[24]_i_2 
       (.CI(\sample_counter_fu_94_reg[16]_i_2_n_0 ),
        .CI_TOP(1'b0),
        .CO({\sample_counter_fu_94_reg[24]_i_2_n_0 ,\sample_counter_fu_94_reg[24]_i_2_n_1 ,\sample_counter_fu_94_reg[24]_i_2_n_2 ,\sample_counter_fu_94_reg[24]_i_2_n_3 ,\NLW_sample_counter_fu_94_reg[24]_i_2_CO_UNCONNECTED [3],\sample_counter_fu_94_reg[24]_i_2_n_5 ,\sample_counter_fu_94_reg[24]_i_2_n_6 ,\sample_counter_fu_94_reg[24]_i_2_n_7 }),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .O(sample_counter_1_fu_430_p2[24:17]),
        .S({\sample_counter_fu_94[24]_i_3_n_0 ,\sample_counter_fu_94[24]_i_4_n_0 ,\sample_counter_fu_94[24]_i_5_n_0 ,\sample_counter_fu_94[24]_i_6_n_0 ,\sample_counter_fu_94[24]_i_7_n_0 ,\sample_counter_fu_94[24]_i_8_n_0 ,\sample_counter_fu_94[24]_i_9_n_0 ,\sample_counter_fu_94[24]_i_10_n_0 }));
  FDRE \sample_counter_fu_94_reg[25] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_49),
        .Q(sample_counter_fu_94[25]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[26] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_48),
        .Q(sample_counter_fu_94[26]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[27] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_47),
        .Q(sample_counter_fu_94[27]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[28] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_46),
        .Q(sample_counter_fu_94[28]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[29] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_45),
        .Q(sample_counter_fu_94[29]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[2] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_72),
        .Q(sample_counter_fu_94[2]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[30] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_44),
        .Q(sample_counter_fu_94[30]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[31] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_43),
        .Q(sample_counter_fu_94[31]),
        .R(1'b0));
  CARRY8 \sample_counter_fu_94_reg[31]_i_4 
       (.CI(\sample_counter_fu_94_reg[24]_i_2_n_0 ),
        .CI_TOP(1'b0),
        .CO({\NLW_sample_counter_fu_94_reg[31]_i_4_CO_UNCONNECTED [7:6],\sample_counter_fu_94_reg[31]_i_4_n_2 ,\sample_counter_fu_94_reg[31]_i_4_n_3 ,\NLW_sample_counter_fu_94_reg[31]_i_4_CO_UNCONNECTED [3],\sample_counter_fu_94_reg[31]_i_4_n_5 ,\sample_counter_fu_94_reg[31]_i_4_n_6 ,\sample_counter_fu_94_reg[31]_i_4_n_7 }),
        .DI({\NLW_sample_counter_fu_94_reg[31]_i_4_DI_UNCONNECTED [7],1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_sample_counter_fu_94_reg[31]_i_4_O_UNCONNECTED [7],sample_counter_1_fu_430_p2[31:25]}),
        .S({\NLW_sample_counter_fu_94_reg[31]_i_4_S_UNCONNECTED [7],\sample_counter_fu_94[31]_i_5_n_0 ,\sample_counter_fu_94[31]_i_6_n_0 ,\sample_counter_fu_94[31]_i_7_n_0 ,\sample_counter_fu_94[31]_i_8_n_0 ,\sample_counter_fu_94[31]_i_9_n_0 ,\sample_counter_fu_94[31]_i_10_n_0 ,\sample_counter_fu_94[31]_i_11_n_0 }));
  FDRE \sample_counter_fu_94_reg[3] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_71),
        .Q(sample_counter_fu_94[3]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[4] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_70),
        .Q(sample_counter_fu_94[4]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[5] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_69),
        .Q(sample_counter_fu_94[5]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[6] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_68),
        .Q(sample_counter_fu_94[6]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[7] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_67),
        .Q(sample_counter_fu_94[7]),
        .R(1'b0));
  FDRE \sample_counter_fu_94_reg[8] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_66),
        .Q(sample_counter_fu_94[8]),
        .R(1'b0));
  CARRY8 \sample_counter_fu_94_reg[8]_i_2 
       (.CI(sample_counter_fu_94[0]),
        .CI_TOP(1'b0),
        .CO({\sample_counter_fu_94_reg[8]_i_2_n_0 ,\sample_counter_fu_94_reg[8]_i_2_n_1 ,\sample_counter_fu_94_reg[8]_i_2_n_2 ,\sample_counter_fu_94_reg[8]_i_2_n_3 ,\NLW_sample_counter_fu_94_reg[8]_i_2_CO_UNCONNECTED [3],\sample_counter_fu_94_reg[8]_i_2_n_5 ,\sample_counter_fu_94_reg[8]_i_2_n_6 ,\sample_counter_fu_94_reg[8]_i_2_n_7 }),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .O(sample_counter_1_fu_430_p2[8:1]),
        .S({\sample_counter_fu_94[8]_i_3_n_0 ,\sample_counter_fu_94[8]_i_4_n_0 ,\sample_counter_fu_94[8]_i_5_n_0 ,\sample_counter_fu_94[8]_i_6_n_0 ,\sample_counter_fu_94[8]_i_7_n_0 ,\sample_counter_fu_94[8]_i_8_n_0 ,\sample_counter_fu_94[8]_i_9_n_0 ,\sample_counter_fu_94[8]_i_10_n_0 }));
  FDRE \sample_counter_fu_94_reg[9] 
       (.C(ap_clk),
        .CE(grp_handle_header_fu_175_n_75),
        .D(grp_handle_header_fu_175_n_65),
        .Q(sample_counter_fu_94[9]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[0] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[0]),
        .Q(sample_counter_load_1_reg_632[0]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[10] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[10]),
        .Q(sample_counter_load_1_reg_632[10]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[11] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[11]),
        .Q(sample_counter_load_1_reg_632[11]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[12] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[12]),
        .Q(sample_counter_load_1_reg_632[12]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[13] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[13]),
        .Q(sample_counter_load_1_reg_632[13]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[14] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[14]),
        .Q(sample_counter_load_1_reg_632[14]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[15] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[15]),
        .Q(sample_counter_load_1_reg_632[15]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[16] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[16]),
        .Q(sample_counter_load_1_reg_632[16]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[17] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[17]),
        .Q(sample_counter_load_1_reg_632[17]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[18] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[18]),
        .Q(sample_counter_load_1_reg_632[18]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[19] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[19]),
        .Q(sample_counter_load_1_reg_632[19]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[1] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[1]),
        .Q(sample_counter_load_1_reg_632[1]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[20] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[20]),
        .Q(sample_counter_load_1_reg_632[20]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[21] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[21]),
        .Q(sample_counter_load_1_reg_632[21]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[22] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[22]),
        .Q(sample_counter_load_1_reg_632[22]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[23] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[23]),
        .Q(sample_counter_load_1_reg_632[23]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[24] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[24]),
        .Q(sample_counter_load_1_reg_632[24]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[25] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[25]),
        .Q(sample_counter_load_1_reg_632[25]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[26] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[26]),
        .Q(sample_counter_load_1_reg_632[26]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[27] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[27]),
        .Q(sample_counter_load_1_reg_632[27]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[28] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[28]),
        .Q(sample_counter_load_1_reg_632[28]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[29] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[29]),
        .Q(sample_counter_load_1_reg_632[29]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[2] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[2]),
        .Q(sample_counter_load_1_reg_632[2]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[30] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[30]),
        .Q(sample_counter_load_1_reg_632[30]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[31] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[31]),
        .Q(sample_counter_load_1_reg_632[31]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[3] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[3]),
        .Q(sample_counter_load_1_reg_632[3]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[4] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[4]),
        .Q(sample_counter_load_1_reg_632[4]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[5] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[5]),
        .Q(sample_counter_load_1_reg_632[5]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[6] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[6]),
        .Q(sample_counter_load_1_reg_632[6]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[7] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[7]),
        .Q(sample_counter_load_1_reg_632[7]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[8] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[8]),
        .Q(sample_counter_load_1_reg_632[8]),
        .R(1'b0));
  FDRE \sample_counter_load_1_reg_632_reg[9] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(sample_counter_fu_94[9]),
        .Q(sample_counter_load_1_reg_632[9]),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hAA8A0000)) 
    \tmp_2_reg_618[0]_i_1 
       (.I0(ap_CS_fsm_state3),
        .I1(tmp_2_fu_295_p3),
        .I2(brmerge_fu_387_p2),
        .I3(o_data_V_data_V_1_ack_in),
        .I4(\i_data_V_data_V_0_state_reg_n_0_[0] ),
        .O(p_222_in));
  (* SOFT_HLUTNM = "soft_lutpair113" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_2_reg_618[0]_i_2 
       (.I0(i_data_V_user_V_0_payload_B[72]),
        .I1(i_data_V_user_V_0_payload_A[72]),
        .I2(i_data_V_user_V_0_sel),
        .O(tmp_2_fu_295_p3));
  FDRE \tmp_2_reg_618_reg[0] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(tmp_2_fu_295_p3),
        .Q(\tmp_2_reg_618_reg_n_0_[0] ),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair185" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[0]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[0]),
        .I1(i_data_V_data_V_0_payload_A[0]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[0]));
  (* SOFT_HLUTNM = "soft_lutpair188" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[10]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[10]),
        .I1(i_data_V_data_V_0_payload_A[10]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[10]));
  (* SOFT_HLUTNM = "soft_lutpair189" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[11]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[11]),
        .I1(i_data_V_data_V_0_payload_A[11]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[11]));
  (* SOFT_HLUTNM = "soft_lutpair115" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[12]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[12]),
        .I1(i_data_V_data_V_0_payload_A[12]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[12]));
  (* SOFT_HLUTNM = "soft_lutpair189" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[13]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[13]),
        .I1(i_data_V_data_V_0_payload_A[13]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[13]));
  (* SOFT_HLUTNM = "soft_lutpair190" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[14]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[14]),
        .I1(i_data_V_data_V_0_payload_A[14]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[14]));
  (* SOFT_HLUTNM = "soft_lutpair190" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[15]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[15]),
        .I1(i_data_V_data_V_0_payload_A[15]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[15]));
  (* SOFT_HLUTNM = "soft_lutpair191" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[16]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[16]),
        .I1(i_data_V_data_V_0_payload_A[16]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[16]));
  (* SOFT_HLUTNM = "soft_lutpair116" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[17]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[17]),
        .I1(i_data_V_data_V_0_payload_A[17]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[17]));
  (* SOFT_HLUTNM = "soft_lutpair191" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[18]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[18]),
        .I1(i_data_V_data_V_0_payload_A[18]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[18]));
  (* SOFT_HLUTNM = "soft_lutpair192" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[19]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[19]),
        .I1(i_data_V_data_V_0_payload_A[19]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[19]));
  (* SOFT_HLUTNM = "soft_lutpair114" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[1]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[1]),
        .I1(i_data_V_data_V_0_payload_A[1]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[1]));
  (* SOFT_HLUTNM = "soft_lutpair116" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[20]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[20]),
        .I1(i_data_V_data_V_0_payload_A[20]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[20]));
  (* SOFT_HLUTNM = "soft_lutpair192" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[21]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[21]),
        .I1(i_data_V_data_V_0_payload_A[21]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[21]));
  (* SOFT_HLUTNM = "soft_lutpair193" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[22]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[22]),
        .I1(i_data_V_data_V_0_payload_A[22]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[22]));
  (* SOFT_HLUTNM = "soft_lutpair193" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[23]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[23]),
        .I1(i_data_V_data_V_0_payload_A[23]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[23]));
  (* SOFT_HLUTNM = "soft_lutpair194" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[24]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[24]),
        .I1(i_data_V_data_V_0_payload_A[24]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[24]));
  (* SOFT_HLUTNM = "soft_lutpair117" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[25]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[25]),
        .I1(i_data_V_data_V_0_payload_A[25]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[25]));
  (* SOFT_HLUTNM = "soft_lutpair194" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[26]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[26]),
        .I1(i_data_V_data_V_0_payload_A[26]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[26]));
  (* SOFT_HLUTNM = "soft_lutpair195" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[27]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[27]),
        .I1(i_data_V_data_V_0_payload_A[27]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[27]));
  (* SOFT_HLUTNM = "soft_lutpair117" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[28]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[28]),
        .I1(i_data_V_data_V_0_payload_A[28]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[28]));
  (* SOFT_HLUTNM = "soft_lutpair195" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[29]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[29]),
        .I1(i_data_V_data_V_0_payload_A[29]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[29]));
  (* SOFT_HLUTNM = "soft_lutpair185" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[2]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[2]),
        .I1(i_data_V_data_V_0_payload_A[2]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[2]));
  (* SOFT_HLUTNM = "soft_lutpair196" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[30]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[30]),
        .I1(i_data_V_data_V_0_payload_A[30]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[30]));
  (* SOFT_HLUTNM = "soft_lutpair196" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[31]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[31]),
        .I1(i_data_V_data_V_0_payload_A[31]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[31]));
  (* SOFT_HLUTNM = "soft_lutpair186" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[3]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[3]),
        .I1(i_data_V_data_V_0_payload_A[3]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[3]));
  (* SOFT_HLUTNM = "soft_lutpair114" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[4]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[4]),
        .I1(i_data_V_data_V_0_payload_A[4]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[4]));
  (* SOFT_HLUTNM = "soft_lutpair186" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[5]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[5]),
        .I1(i_data_V_data_V_0_payload_A[5]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[5]));
  (* SOFT_HLUTNM = "soft_lutpair187" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[6]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[6]),
        .I1(i_data_V_data_V_0_payload_A[6]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[6]));
  (* SOFT_HLUTNM = "soft_lutpair187" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[7]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[7]),
        .I1(i_data_V_data_V_0_payload_A[7]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[7]));
  (* SOFT_HLUTNM = "soft_lutpair188" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[8]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[8]),
        .I1(i_data_V_data_V_0_payload_A[8]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[8]));
  (* SOFT_HLUTNM = "soft_lutpair115" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_data_V_reg_577[9]_i_1 
       (.I0(i_data_V_data_V_0_payload_B[9]),
        .I1(i_data_V_data_V_0_payload_A[9]),
        .I2(i_data_V_data_V_0_sel),
        .O(i_data_V_data_V_0_data_out[9]));
  FDRE \tmp_data_V_reg_577_reg[0] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[0]),
        .Q(tmp_data_V_reg_577[0]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[10] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[10]),
        .Q(tmp_data_V_reg_577[10]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[11] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[11]),
        .Q(tmp_data_V_reg_577[11]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[12] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[12]),
        .Q(tmp_data_V_reg_577[12]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[13] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[13]),
        .Q(tmp_data_V_reg_577[13]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[14] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[14]),
        .Q(tmp_data_V_reg_577[14]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[15] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[15]),
        .Q(tmp_data_V_reg_577[15]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[16] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[16]),
        .Q(tmp_data_V_reg_577[16]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[17] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[17]),
        .Q(tmp_data_V_reg_577[17]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[18] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[18]),
        .Q(tmp_data_V_reg_577[18]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[19] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[19]),
        .Q(tmp_data_V_reg_577[19]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[1] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[1]),
        .Q(tmp_data_V_reg_577[1]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[20] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[20]),
        .Q(tmp_data_V_reg_577[20]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[21] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[21]),
        .Q(tmp_data_V_reg_577[21]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[22] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[22]),
        .Q(tmp_data_V_reg_577[22]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[23] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[23]),
        .Q(tmp_data_V_reg_577[23]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[24] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[24]),
        .Q(tmp_data_V_reg_577[24]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[25] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[25]),
        .Q(tmp_data_V_reg_577[25]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[26] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[26]),
        .Q(tmp_data_V_reg_577[26]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[27] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[27]),
        .Q(tmp_data_V_reg_577[27]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[28] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[28]),
        .Q(tmp_data_V_reg_577[28]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[29] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[29]),
        .Q(tmp_data_V_reg_577[29]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[2] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[2]),
        .Q(tmp_data_V_reg_577[2]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[30] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[30]),
        .Q(tmp_data_V_reg_577[30]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[31] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[31]),
        .Q(tmp_data_V_reg_577[31]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[3] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[3]),
        .Q(tmp_data_V_reg_577[3]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[4] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[4]),
        .Q(tmp_data_V_reg_577[4]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[5] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[5]),
        .Q(tmp_data_V_reg_577[5]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[6] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[6]),
        .Q(tmp_data_V_reg_577[6]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[7] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[7]),
        .Q(tmp_data_V_reg_577[7]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[8] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[8]),
        .Q(tmp_data_V_reg_577[8]),
        .R(1'b0));
  FDRE \tmp_data_V_reg_577_reg[9] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_data_V_0_data_out[9]),
        .Q(tmp_data_V_reg_577[9]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hB8)) 
    \tmp_dest_V_reg_612[0]_i_1 
       (.I0(i_data_V_dest_V_0_payload_B),
        .I1(i_data_V_dest_V_0_sel),
        .I2(i_data_V_dest_V_0_payload_A),
        .O(i_data_V_dest_V_0_data_out));
  FDRE \tmp_dest_V_reg_612_reg[0] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_dest_V_0_data_out),
        .Q(tmp_dest_V_reg_612),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hB8)) 
    \tmp_id_V_reg_606[0]_i_1 
       (.I0(i_data_V_id_V_0_payload_B),
        .I1(i_data_V_id_V_0_sel),
        .I2(i_data_V_id_V_0_payload_A),
        .O(i_data_V_id_V_0_data_out));
  FDRE \tmp_id_V_reg_606_reg[0] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_id_V_0_data_out),
        .Q(tmp_id_V_reg_606),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair104" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \tmp_keep_V_reg_583[0]_i_1 
       (.I0(i_data_V_keep_V_0_payload_B[0]),
        .I1(i_data_V_keep_V_0_sel),
        .I2(i_data_V_keep_V_0_payload_A[0]),
        .O(i_data_V_keep_V_0_data_out[0]));
  (* SOFT_HLUTNM = "soft_lutpair105" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \tmp_keep_V_reg_583[1]_i_1 
       (.I0(i_data_V_keep_V_0_payload_B[1]),
        .I1(i_data_V_keep_V_0_sel),
        .I2(i_data_V_keep_V_0_payload_A[1]),
        .O(i_data_V_keep_V_0_data_out[1]));
  (* SOFT_HLUTNM = "soft_lutpair106" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \tmp_keep_V_reg_583[2]_i_1 
       (.I0(i_data_V_keep_V_0_payload_B[2]),
        .I1(i_data_V_keep_V_0_sel),
        .I2(i_data_V_keep_V_0_payload_A[2]),
        .O(i_data_V_keep_V_0_data_out[2]));
  (* SOFT_HLUTNM = "soft_lutpair107" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \tmp_keep_V_reg_583[3]_i_1 
       (.I0(i_data_V_keep_V_0_payload_B[3]),
        .I1(i_data_V_keep_V_0_sel),
        .I2(i_data_V_keep_V_0_payload_A[3]),
        .O(i_data_V_keep_V_0_data_out[3]));
  FDRE \tmp_keep_V_reg_583_reg[0] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_keep_V_0_data_out[0]),
        .Q(tmp_keep_V_reg_583[0]),
        .R(1'b0));
  FDRE \tmp_keep_V_reg_583_reg[1] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_keep_V_0_data_out[1]),
        .Q(tmp_keep_V_reg_583[1]),
        .R(1'b0));
  FDRE \tmp_keep_V_reg_583_reg[2] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_keep_V_0_data_out[2]),
        .Q(tmp_keep_V_reg_583[2]),
        .R(1'b0));
  FDRE \tmp_keep_V_reg_583_reg[3] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_keep_V_0_data_out[3]),
        .Q(tmp_keep_V_reg_583[3]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hB8)) 
    \tmp_last_V_reg_600[0]_i_1 
       (.I0(i_data_V_last_V_0_payload_B),
        .I1(i_data_V_last_V_0_sel),
        .I2(i_data_V_last_V_0_payload_A),
        .O(i_data_V_last_V_0_data_out));
  FDRE \tmp_last_V_reg_600_reg[0] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_last_V_0_data_out),
        .Q(tmp_last_V_reg_600),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair100" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \tmp_strb_V_reg_589[0]_i_1 
       (.I0(i_data_V_strb_V_0_payload_B[0]),
        .I1(i_data_V_strb_V_0_sel),
        .I2(i_data_V_strb_V_0_payload_A[0]),
        .O(i_data_V_strb_V_0_data_out[0]));
  (* SOFT_HLUTNM = "soft_lutpair101" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \tmp_strb_V_reg_589[1]_i_1 
       (.I0(i_data_V_strb_V_0_payload_B[1]),
        .I1(i_data_V_strb_V_0_sel),
        .I2(i_data_V_strb_V_0_payload_A[1]),
        .O(i_data_V_strb_V_0_data_out[1]));
  (* SOFT_HLUTNM = "soft_lutpair102" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \tmp_strb_V_reg_589[2]_i_1 
       (.I0(i_data_V_strb_V_0_payload_B[2]),
        .I1(i_data_V_strb_V_0_sel),
        .I2(i_data_V_strb_V_0_payload_A[2]),
        .O(i_data_V_strb_V_0_data_out[2]));
  (* SOFT_HLUTNM = "soft_lutpair103" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \tmp_strb_V_reg_589[3]_i_1 
       (.I0(i_data_V_strb_V_0_payload_B[3]),
        .I1(i_data_V_strb_V_0_sel),
        .I2(i_data_V_strb_V_0_payload_A[3]),
        .O(i_data_V_strb_V_0_data_out[3]));
  FDRE \tmp_strb_V_reg_589_reg[0] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_strb_V_0_data_out[0]),
        .Q(tmp_strb_V_reg_589[0]),
        .R(1'b0));
  FDRE \tmp_strb_V_reg_589_reg[1] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_strb_V_0_data_out[1]),
        .Q(tmp_strb_V_reg_589[1]),
        .R(1'b0));
  FDRE \tmp_strb_V_reg_589_reg[2] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_strb_V_0_data_out[2]),
        .Q(tmp_strb_V_reg_589[2]),
        .R(1'b0));
  FDRE \tmp_strb_V_reg_589_reg[3] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(i_data_V_strb_V_0_data_out[3]),
        .Q(tmp_strb_V_reg_589[3]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair113" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[0]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[0]),
        .I1(i_data_V_user_V_0_payload_A[0]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair171" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[100]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[100]),
        .I1(i_data_V_user_V_0_payload_A[100]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[100]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair172" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[101]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[101]),
        .I1(i_data_V_user_V_0_payload_A[101]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[101]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair172" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[102]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[102]),
        .I1(i_data_V_user_V_0_payload_A[102]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[102]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair173" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[103]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[103]),
        .I1(i_data_V_user_V_0_payload_A[103]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[103]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair173" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[104]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[104]),
        .I1(i_data_V_user_V_0_payload_A[104]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[104]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair174" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[105]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[105]),
        .I1(i_data_V_user_V_0_payload_A[105]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[105]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair174" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[106]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[106]),
        .I1(i_data_V_user_V_0_payload_A[106]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[106]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair175" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[107]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[107]),
        .I1(i_data_V_user_V_0_payload_A[107]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[107]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair175" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[108]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[108]),
        .I1(i_data_V_user_V_0_payload_A[108]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[108]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair176" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[109]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[109]),
        .I1(i_data_V_user_V_0_payload_A[109]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[109]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair127" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[10]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[10]),
        .I1(i_data_V_user_V_0_payload_A[10]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair176" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[110]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[110]),
        .I1(i_data_V_user_V_0_payload_A[110]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[110]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair177" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[111]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[111]),
        .I1(i_data_V_user_V_0_payload_A[111]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[111]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair177" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[112]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[112]),
        .I1(i_data_V_user_V_0_payload_A[112]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[112]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair178" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[113]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[113]),
        .I1(i_data_V_user_V_0_payload_A[113]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[113]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair178" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[114]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[114]),
        .I1(i_data_V_user_V_0_payload_A[114]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[114]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair179" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[115]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[115]),
        .I1(i_data_V_user_V_0_payload_A[115]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[115]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair179" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[116]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[116]),
        .I1(i_data_V_user_V_0_payload_A[116]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[116]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair180" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[117]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[117]),
        .I1(i_data_V_user_V_0_payload_A[117]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[117]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair180" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[118]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[118]),
        .I1(i_data_V_user_V_0_payload_A[118]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[118]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair181" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[119]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[119]),
        .I1(i_data_V_user_V_0_payload_A[119]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[119]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair127" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[11]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[11]),
        .I1(i_data_V_user_V_0_payload_A[11]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair181" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[120]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[120]),
        .I1(i_data_V_user_V_0_payload_A[120]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[120]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair182" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[121]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[121]),
        .I1(i_data_V_user_V_0_payload_A[121]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[121]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair182" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[122]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[122]),
        .I1(i_data_V_user_V_0_payload_A[122]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[122]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair183" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[123]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[123]),
        .I1(i_data_V_user_V_0_payload_A[123]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[123]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair183" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[124]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[124]),
        .I1(i_data_V_user_V_0_payload_A[124]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[124]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair184" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[125]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[125]),
        .I1(i_data_V_user_V_0_payload_A[125]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[125]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair184" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[126]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[126]),
        .I1(i_data_V_user_V_0_payload_A[126]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[126]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair99" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[127]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[127]),
        .I1(i_data_V_user_V_0_payload_A[127]),
        .I2(i_data_V_user_V_0_sel_rd_reg_rep_n_0),
        .O(\tmp_user_V_1_reg_595[127]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair128" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[12]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[12]),
        .I1(i_data_V_user_V_0_payload_A[12]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair128" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[13]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[13]),
        .I1(i_data_V_user_V_0_payload_A[13]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair129" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[14]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[14]),
        .I1(i_data_V_user_V_0_payload_A[14]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair129" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[15]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[15]),
        .I1(i_data_V_user_V_0_payload_A[15]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair130" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[16]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[16]),
        .I1(i_data_V_user_V_0_payload_A[16]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair130" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[17]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[17]),
        .I1(i_data_V_user_V_0_payload_A[17]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair131" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[18]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[18]),
        .I1(i_data_V_user_V_0_payload_A[18]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair131" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[19]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[19]),
        .I1(i_data_V_user_V_0_payload_A[19]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair118" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[1]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[1]),
        .I1(i_data_V_user_V_0_payload_A[1]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair132" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[20]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[20]),
        .I1(i_data_V_user_V_0_payload_A[20]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair132" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[21]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[21]),
        .I1(i_data_V_user_V_0_payload_A[21]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair133" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[22]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[22]),
        .I1(i_data_V_user_V_0_payload_A[22]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[22]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair133" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[23]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[23]),
        .I1(i_data_V_user_V_0_payload_A[23]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair134" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[24]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[24]),
        .I1(i_data_V_user_V_0_payload_A[24]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair134" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[25]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[25]),
        .I1(i_data_V_user_V_0_payload_A[25]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair135" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[26]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[26]),
        .I1(i_data_V_user_V_0_payload_A[26]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair135" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[27]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[27]),
        .I1(i_data_V_user_V_0_payload_A[27]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair136" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[28]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[28]),
        .I1(i_data_V_user_V_0_payload_A[28]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair136" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[29]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[29]),
        .I1(i_data_V_user_V_0_payload_A[29]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair123" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[2]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[2]),
        .I1(i_data_V_user_V_0_payload_A[2]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair137" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[30]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[30]),
        .I1(i_data_V_user_V_0_payload_A[30]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[30]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair137" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[31]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[31]),
        .I1(i_data_V_user_V_0_payload_A[31]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair138" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[32]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[32]),
        .I1(i_data_V_user_V_0_payload_A[32]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[32]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair138" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[33]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[33]),
        .I1(i_data_V_user_V_0_payload_A[33]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[33]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair139" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[34]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[34]),
        .I1(i_data_V_user_V_0_payload_A[34]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[34]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair139" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[35]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[35]),
        .I1(i_data_V_user_V_0_payload_A[35]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[35]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair140" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[36]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[36]),
        .I1(i_data_V_user_V_0_payload_A[36]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[36]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair140" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[37]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[37]),
        .I1(i_data_V_user_V_0_payload_A[37]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[37]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair141" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[38]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[38]),
        .I1(i_data_V_user_V_0_payload_A[38]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[38]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair141" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[39]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[39]),
        .I1(i_data_V_user_V_0_payload_A[39]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[39]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair123" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[3]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[3]),
        .I1(i_data_V_user_V_0_payload_A[3]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair142" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[40]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[40]),
        .I1(i_data_V_user_V_0_payload_A[40]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[40]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair142" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[41]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[41]),
        .I1(i_data_V_user_V_0_payload_A[41]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[41]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair143" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[42]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[42]),
        .I1(i_data_V_user_V_0_payload_A[42]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[42]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair143" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[43]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[43]),
        .I1(i_data_V_user_V_0_payload_A[43]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[43]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair144" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[44]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[44]),
        .I1(i_data_V_user_V_0_payload_A[44]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[44]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair144" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[45]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[45]),
        .I1(i_data_V_user_V_0_payload_A[45]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[45]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair145" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[46]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[46]),
        .I1(i_data_V_user_V_0_payload_A[46]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[46]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair145" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[47]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[47]),
        .I1(i_data_V_user_V_0_payload_A[47]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[47]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair146" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[48]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[48]),
        .I1(i_data_V_user_V_0_payload_A[48]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[48]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair146" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[49]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[49]),
        .I1(i_data_V_user_V_0_payload_A[49]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[49]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair124" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[4]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[4]),
        .I1(i_data_V_user_V_0_payload_A[4]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair147" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[50]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[50]),
        .I1(i_data_V_user_V_0_payload_A[50]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[50]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair147" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[51]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[51]),
        .I1(i_data_V_user_V_0_payload_A[51]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[51]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair148" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[52]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[52]),
        .I1(i_data_V_user_V_0_payload_A[52]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[52]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair148" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[53]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[53]),
        .I1(i_data_V_user_V_0_payload_A[53]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[53]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair149" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[54]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[54]),
        .I1(i_data_V_user_V_0_payload_A[54]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[54]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair149" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[55]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[55]),
        .I1(i_data_V_user_V_0_payload_A[55]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[55]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair150" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[56]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[56]),
        .I1(i_data_V_user_V_0_payload_A[56]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[56]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair150" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[57]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[57]),
        .I1(i_data_V_user_V_0_payload_A[57]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[57]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair151" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[58]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[58]),
        .I1(i_data_V_user_V_0_payload_A[58]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[58]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair151" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[59]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[59]),
        .I1(i_data_V_user_V_0_payload_A[59]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[59]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair124" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[5]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[5]),
        .I1(i_data_V_user_V_0_payload_A[5]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair152" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[60]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[60]),
        .I1(i_data_V_user_V_0_payload_A[60]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[60]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair152" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[61]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[61]),
        .I1(i_data_V_user_V_0_payload_A[61]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[61]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair153" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[62]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[62]),
        .I1(i_data_V_user_V_0_payload_A[62]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[62]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair153" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[63]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[63]),
        .I1(i_data_V_user_V_0_payload_A[63]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[63]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair154" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[65]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[65]),
        .I1(i_data_V_user_V_0_payload_A[65]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[65]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair118" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[66]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[66]),
        .I1(i_data_V_user_V_0_payload_A[66]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[66]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair154" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[67]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[67]),
        .I1(i_data_V_user_V_0_payload_A[67]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[67]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair156" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[68]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[68]),
        .I1(i_data_V_user_V_0_payload_A[68]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[68]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair156" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[69]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[69]),
        .I1(i_data_V_user_V_0_payload_A[69]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[69]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair125" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[6]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[6]),
        .I1(i_data_V_user_V_0_payload_A[6]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair157" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[70]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[70]),
        .I1(i_data_V_user_V_0_payload_A[70]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[70]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair157" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[71]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[71]),
        .I1(i_data_V_user_V_0_payload_A[71]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[71]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair158" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[73]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[73]),
        .I1(i_data_V_user_V_0_payload_A[73]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[73]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair158" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[74]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[74]),
        .I1(i_data_V_user_V_0_payload_A[74]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[74]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair159" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[75]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[75]),
        .I1(i_data_V_user_V_0_payload_A[75]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[75]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair159" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[76]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[76]),
        .I1(i_data_V_user_V_0_payload_A[76]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[76]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair160" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[77]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[77]),
        .I1(i_data_V_user_V_0_payload_A[77]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[77]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair160" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[78]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[78]),
        .I1(i_data_V_user_V_0_payload_A[78]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[78]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair161" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[79]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[79]),
        .I1(i_data_V_user_V_0_payload_A[79]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[79]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair125" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[7]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[7]),
        .I1(i_data_V_user_V_0_payload_A[7]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair161" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[80]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[80]),
        .I1(i_data_V_user_V_0_payload_A[80]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[80]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair162" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[81]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[81]),
        .I1(i_data_V_user_V_0_payload_A[81]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[81]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair162" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[82]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[82]),
        .I1(i_data_V_user_V_0_payload_A[82]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[82]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair163" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[83]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[83]),
        .I1(i_data_V_user_V_0_payload_A[83]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[83]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair163" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[84]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[84]),
        .I1(i_data_V_user_V_0_payload_A[84]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[84]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair164" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[85]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[85]),
        .I1(i_data_V_user_V_0_payload_A[85]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[85]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair164" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[86]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[86]),
        .I1(i_data_V_user_V_0_payload_A[86]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[86]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair165" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[87]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[87]),
        .I1(i_data_V_user_V_0_payload_A[87]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[87]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair165" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[88]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[88]),
        .I1(i_data_V_user_V_0_payload_A[88]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[88]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair166" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[89]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[89]),
        .I1(i_data_V_user_V_0_payload_A[89]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[89]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair126" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[8]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[8]),
        .I1(i_data_V_user_V_0_payload_A[8]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair166" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[90]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[90]),
        .I1(i_data_V_user_V_0_payload_A[90]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[90]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair167" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[91]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[91]),
        .I1(i_data_V_user_V_0_payload_A[91]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[91]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair167" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[92]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[92]),
        .I1(i_data_V_user_V_0_payload_A[92]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[92]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair168" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[93]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[93]),
        .I1(i_data_V_user_V_0_payload_A[93]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[93]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair168" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[94]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[94]),
        .I1(i_data_V_user_V_0_payload_A[94]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[94]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair169" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[95]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[95]),
        .I1(i_data_V_user_V_0_payload_A[95]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[95]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair169" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[96]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[96]),
        .I1(i_data_V_user_V_0_payload_A[96]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[96]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair170" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[97]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[97]),
        .I1(i_data_V_user_V_0_payload_A[97]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[97]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair170" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[98]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[98]),
        .I1(i_data_V_user_V_0_payload_A[98]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[98]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair171" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[99]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[99]),
        .I1(i_data_V_user_V_0_payload_A[99]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[99]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair126" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \tmp_user_V_1_reg_595[9]_i_1 
       (.I0(i_data_V_user_V_0_payload_B[9]),
        .I1(i_data_V_user_V_0_payload_A[9]),
        .I2(i_data_V_user_V_0_sel),
        .O(\tmp_user_V_1_reg_595[9]_i_1_n_0 ));
  FDRE \tmp_user_V_1_reg_595_reg[0] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[0]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[0]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[100] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[100]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[100]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[101] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[101]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[101]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[102] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[102]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[102]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[103] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[103]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[103]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[104] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[104]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[104]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[105] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[105]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[105]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[106] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[106]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[106]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[107] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[107]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[107]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[108] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[108]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[108]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[109] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[109]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[109]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[10] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[10]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[10]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[110] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[110]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[110]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[111] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[111]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[111]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[112] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[112]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[112]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[113] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[113]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[113]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[114] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[114]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[114]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[115] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[115]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[115]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[116] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[116]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[116]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[117] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[117]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[117]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[118] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[118]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[118]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[119] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[119]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[119]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[11] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[11]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[11]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[120] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[120]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[120]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[121] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[121]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[121]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[122] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[122]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[122]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[123] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[123]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[123]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[124] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[124]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[124]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[125] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[125]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[125]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[126] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[126]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[126]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[127] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[127]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[127]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[12] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[12]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[12]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[13] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[13]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[13]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[14] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[14]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[14]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[15] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[15]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[15]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[16] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[16]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[16]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[17] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[17]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[17]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[18] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[18]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[18]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[19] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[19]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[19]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[1] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[1]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[1]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[20] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[20]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[20]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[21] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[21]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[21]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[22] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[22]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[22]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[23] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[23]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[23]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[24] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[24]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[24]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[25] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[25]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[25]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[26] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[26]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[26]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[27] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[27]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[27]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[28] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[28]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[28]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[29] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[29]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[29]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[2] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[2]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[2]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[30] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[30]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[30]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[31] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[31]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[31]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[32] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[32]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[32]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[33] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[33]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[33]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[34] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[34]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[34]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[35] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[35]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[35]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[36] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[36]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[36]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[37] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[37]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[37]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[38] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[38]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[38]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[39] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[39]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[39]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[3] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[3]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[3]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[40] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[40]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[40]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[41] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[41]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[41]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[42] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[42]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[42]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[43] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[43]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[43]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[44] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[44]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[44]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[45] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[45]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[45]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[46] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[46]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[46]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[47] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[47]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[47]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[48] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[48]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[48]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[49] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[49]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[49]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[4] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[4]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[4]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[50] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[50]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[50]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[51] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[51]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[51]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[52] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[52]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[52]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[53] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[53]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[53]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[54] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[54]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[54]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[55] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[55]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[55]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[56] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[56]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[56]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[57] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[57]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[57]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[58] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[58]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[58]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[59] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[59]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[59]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[5] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[5]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[5]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[60] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[60]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[60]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[61] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[61]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[61]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[62] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[62]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[62]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[63] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[63]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[63]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[65] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[65]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[65]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[66] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[66]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[66]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[67] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[67]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[67]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[68] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[68]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[68]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[69] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[69]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[69]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[6] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[6]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[6]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[70] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[70]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[70]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[71] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[71]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[71]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[73] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[73]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[73]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[74] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[74]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[74]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[75] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[75]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[75]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[76] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[76]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[76]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[77] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[77]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[77]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[78] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[78]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[78]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[79] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[79]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[79]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[7] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[7]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[7]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[80] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[80]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[80]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[81] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[81]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[81]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[82] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[82]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[82]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[83] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[83]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[83]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[84] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[84]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[84]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[85] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[85]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[85]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[86] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[86]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[86]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[87] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[87]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[87]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[88] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[88]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[88]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[89] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[89]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[89]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[8] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[8]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[8]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[90] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[90]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[90]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[91] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[91]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[91]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[92] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[92]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[92]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[93] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[93]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[93]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[94] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[94]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[94]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[95] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[95]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[95]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[96] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[96]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[96]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[97] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[97]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[97]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[98] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[98]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[98]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[99] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[99]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[99]),
        .R(1'b0));
  FDRE \tmp_user_V_1_reg_595_reg[9] 
       (.C(ap_clk),
        .CE(p_222_in),
        .D(\tmp_user_V_1_reg_595[9]_i_1_n_0 ),
        .Q(tmp_user_V_1_reg_595[9]),
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
