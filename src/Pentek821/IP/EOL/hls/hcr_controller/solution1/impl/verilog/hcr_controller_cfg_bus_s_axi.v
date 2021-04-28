// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1ns/1ps
module hcr_controller_cfg_bus_s_axi
#(parameter
    C_S_AXI_ADDR_WIDTH = 13,
    C_S_AXI_DATA_WIDTH = 32
)(
    input  wire                          ACLK,
    input  wire                          ARESET,
    input  wire                          ACLK_EN,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] AWADDR,
    input  wire                          AWVALID,
    output wire                          AWREADY,
    input  wire [C_S_AXI_DATA_WIDTH-1:0] WDATA,
    input  wire [C_S_AXI_DATA_WIDTH/8-1:0] WSTRB,
    input  wire                          WVALID,
    output wire                          WREADY,
    output wire [1:0]                    BRESP,
    output wire                          BVALID,
    input  wire                          BREADY,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] ARADDR,
    input  wire                          ARVALID,
    output wire                          ARREADY,
    output wire [C_S_AXI_DATA_WIDTH-1:0] RDATA,
    output wire [1:0]                    RRESP,
    output wire                          RVALID,
    input  wire                          RREADY,
    output wire                          interrupt,
    output wire                          ap_start,
    input  wire                          ap_done,
    input  wire                          ap_ready,
    input  wire                          ap_idle,
    output wire [7:0]                    cfg_pulse_sequence_start_index,
    output wire [7:0]                    cfg_pulse_sequence_length,
    output wire [31:0]                   cfg_num_pulses_to_execute,
    output wire [31:0]                   cfg_total_decimation,
    output wire [31:0]                   cfg_post_decimation,
    output wire [31:0]                   cfg_num_pulses_per_xfer,
    output wire [31:0]                   cfg_enabled_channel_vector,
    input  wire [4:0]                    cfg_pulse_sequence_prt_0_address0,
    input  wire                          cfg_pulse_sequence_prt_0_ce0,
    output wire [31:0]                   cfg_pulse_sequence_prt_0_q0,
    input  wire [4:0]                    cfg_pulse_sequence_prt_1_address0,
    input  wire                          cfg_pulse_sequence_prt_1_ce0,
    output wire [31:0]                   cfg_pulse_sequence_prt_1_q0,
    input  wire [4:0]                    cfg_pulse_sequence_num_pulses_address0,
    input  wire                          cfg_pulse_sequence_num_pulses_ce0,
    output wire [31:0]                   cfg_pulse_sequence_num_pulses_q0,
    input  wire [4:0]                    cfg_pulse_sequence_block_post_time_address0,
    input  wire                          cfg_pulse_sequence_block_post_time_ce0,
    output wire [31:0]                   cfg_pulse_sequence_block_post_time_q0,
    input  wire [4:0]                    cfg_pulse_sequence_control_flags_address0,
    input  wire                          cfg_pulse_sequence_control_flags_ce0,
    output wire [31:0]                   cfg_pulse_sequence_control_flags_q0,
    input  wire [4:0]                    cfg_pulse_sequence_filter_select_ch0_address0,
    input  wire                          cfg_pulse_sequence_filter_select_ch0_ce0,
    output wire [31:0]                   cfg_pulse_sequence_filter_select_ch0_q0,
    input  wire [4:0]                    cfg_pulse_sequence_filter_select_ch1_address0,
    input  wire                          cfg_pulse_sequence_filter_select_ch1_ce0,
    output wire [31:0]                   cfg_pulse_sequence_filter_select_ch1_q0,
    input  wire [4:0]                    cfg_pulse_sequence_filter_select_ch2_address0,
    input  wire                          cfg_pulse_sequence_filter_select_ch2_ce0,
    output wire [31:0]                   cfg_pulse_sequence_filter_select_ch2_q0,
    input  wire [4:0]                    cfg_pulse_sequence_timer_offset_0_address0,
    input  wire                          cfg_pulse_sequence_timer_offset_0_ce0,
    output wire [31:0]                   cfg_pulse_sequence_timer_offset_0_q0,
    input  wire [4:0]                    cfg_pulse_sequence_timer_offset_1_address0,
    input  wire                          cfg_pulse_sequence_timer_offset_1_ce0,
    output wire [31:0]                   cfg_pulse_sequence_timer_offset_1_q0,
    input  wire [4:0]                    cfg_pulse_sequence_timer_offset_2_address0,
    input  wire                          cfg_pulse_sequence_timer_offset_2_ce0,
    output wire [31:0]                   cfg_pulse_sequence_timer_offset_2_q0,
    input  wire [4:0]                    cfg_pulse_sequence_timer_offset_3_address0,
    input  wire                          cfg_pulse_sequence_timer_offset_3_ce0,
    output wire [31:0]                   cfg_pulse_sequence_timer_offset_3_q0,
    input  wire [4:0]                    cfg_pulse_sequence_timer_offset_4_address0,
    input  wire                          cfg_pulse_sequence_timer_offset_4_ce0,
    output wire [31:0]                   cfg_pulse_sequence_timer_offset_4_q0,
    input  wire [4:0]                    cfg_pulse_sequence_timer_offset_5_address0,
    input  wire                          cfg_pulse_sequence_timer_offset_5_ce0,
    output wire [31:0]                   cfg_pulse_sequence_timer_offset_5_q0,
    input  wire [4:0]                    cfg_pulse_sequence_timer_offset_6_address0,
    input  wire                          cfg_pulse_sequence_timer_offset_6_ce0,
    output wire [31:0]                   cfg_pulse_sequence_timer_offset_6_q0,
    input  wire [4:0]                    cfg_pulse_sequence_timer_offset_7_address0,
    input  wire                          cfg_pulse_sequence_timer_offset_7_ce0,
    output wire [31:0]                   cfg_pulse_sequence_timer_offset_7_q0,
    input  wire [4:0]                    cfg_pulse_sequence_timer_width_0_address0,
    input  wire                          cfg_pulse_sequence_timer_width_0_ce0,
    output wire [31:0]                   cfg_pulse_sequence_timer_width_0_q0,
    input  wire [4:0]                    cfg_pulse_sequence_timer_width_1_address0,
    input  wire                          cfg_pulse_sequence_timer_width_1_ce0,
    output wire [31:0]                   cfg_pulse_sequence_timer_width_1_q0,
    input  wire [4:0]                    cfg_pulse_sequence_timer_width_2_address0,
    input  wire                          cfg_pulse_sequence_timer_width_2_ce0,
    output wire [31:0]                   cfg_pulse_sequence_timer_width_2_q0,
    input  wire [4:0]                    cfg_pulse_sequence_timer_width_3_address0,
    input  wire                          cfg_pulse_sequence_timer_width_3_ce0,
    output wire [31:0]                   cfg_pulse_sequence_timer_width_3_q0,
    input  wire [4:0]                    cfg_pulse_sequence_timer_width_4_address0,
    input  wire                          cfg_pulse_sequence_timer_width_4_ce0,
    output wire [31:0]                   cfg_pulse_sequence_timer_width_4_q0,
    input  wire [4:0]                    cfg_pulse_sequence_timer_width_5_address0,
    input  wire                          cfg_pulse_sequence_timer_width_5_ce0,
    output wire [31:0]                   cfg_pulse_sequence_timer_width_5_q0,
    input  wire [4:0]                    cfg_pulse_sequence_timer_width_6_address0,
    input  wire                          cfg_pulse_sequence_timer_width_6_ce0,
    output wire [31:0]                   cfg_pulse_sequence_timer_width_6_q0,
    input  wire [4:0]                    cfg_pulse_sequence_timer_width_7_address0,
    input  wire                          cfg_pulse_sequence_timer_width_7_ce0,
    output wire [31:0]                   cfg_pulse_sequence_timer_width_7_q0,
    input  wire [7:0]                    cfg_filter_coefs_ch0_address0,
    input  wire                          cfg_filter_coefs_ch0_ce0,
    output wire [31:0]                   cfg_filter_coefs_ch0_q0,
    input  wire [7:0]                    cfg_filter_coefs_ch1_address0,
    input  wire                          cfg_filter_coefs_ch1_ce0,
    output wire [31:0]                   cfg_filter_coefs_ch1_q0,
    input  wire [7:0]                    cfg_filter_coefs_ch2_address0,
    input  wire                          cfg_filter_coefs_ch2_ce0,
    output wire [31:0]                   cfg_filter_coefs_ch2_q0
);
//------------------------Address Info-------------------
// 0x0000 : Control signals
//          bit 0  - ap_start (Read/Write/COH)
//          bit 1  - ap_done (Read/COR)
//          bit 2  - ap_idle (Read)
//          bit 3  - ap_ready (Read)
//          bit 7  - auto_restart (Read/Write)
//          others - reserved
// 0x0004 : Global Interrupt Enable Register
//          bit 0  - Global Interrupt Enable (Read/Write)
//          others - reserved
// 0x0008 : IP Interrupt Enable Register (Read/Write)
//          bit 0  - Channel 0 (ap_done)
//          bit 1  - Channel 1 (ap_ready)
//          others - reserved
// 0x000c : IP Interrupt Status Register (Read/TOW)
//          bit 0  - Channel 0 (ap_done)
//          bit 1  - Channel 1 (ap_ready)
//          others - reserved
// 0x0010 : Data signal of cfg_pulse_sequence_start_index
//          bit 7~0 - cfg_pulse_sequence_start_index[7:0] (Read/Write)
//          others  - reserved
// 0x0014 : reserved
// 0x0018 : Data signal of cfg_pulse_sequence_length
//          bit 7~0 - cfg_pulse_sequence_length[7:0] (Read/Write)
//          others  - reserved
// 0x001c : reserved
// 0x0020 : Data signal of cfg_num_pulses_to_execute
//          bit 31~0 - cfg_num_pulses_to_execute[31:0] (Read/Write)
// 0x0024 : reserved
// 0x0028 : Data signal of cfg_total_decimation
//          bit 31~0 - cfg_total_decimation[31:0] (Read/Write)
// 0x002c : reserved
// 0x0030 : Data signal of cfg_post_decimation
//          bit 31~0 - cfg_post_decimation[31:0] (Read/Write)
// 0x0034 : reserved
// 0x0038 : Data signal of cfg_num_pulses_per_xfer
//          bit 31~0 - cfg_num_pulses_per_xfer[31:0] (Read/Write)
// 0x003c : reserved
// 0x0040 : Data signal of cfg_enabled_channel_vector
//          bit 31~0 - cfg_enabled_channel_vector[31:0] (Read/Write)
// 0x0044 : reserved
// 0x0080 ~
// 0x00ff : Memory 'cfg_pulse_sequence_prt_0' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_prt_0[n]
// 0x0100 ~
// 0x017f : Memory 'cfg_pulse_sequence_prt_1' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_prt_1[n]
// 0x0180 ~
// 0x01ff : Memory 'cfg_pulse_sequence_num_pulses' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_num_pulses[n]
// 0x0200 ~
// 0x027f : Memory 'cfg_pulse_sequence_block_post_time' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_block_post_time[n]
// 0x0280 ~
// 0x02ff : Memory 'cfg_pulse_sequence_control_flags' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_control_flags[n]
// 0x0300 ~
// 0x037f : Memory 'cfg_pulse_sequence_filter_select_ch0' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_filter_select_ch0[n]
// 0x0380 ~
// 0x03ff : Memory 'cfg_pulse_sequence_filter_select_ch1' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_filter_select_ch1[n]
// 0x0400 ~
// 0x047f : Memory 'cfg_pulse_sequence_filter_select_ch2' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_filter_select_ch2[n]
// 0x0480 ~
// 0x04ff : Memory 'cfg_pulse_sequence_timer_offset_0' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_0[n]
// 0x0500 ~
// 0x057f : Memory 'cfg_pulse_sequence_timer_offset_1' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_1[n]
// 0x0580 ~
// 0x05ff : Memory 'cfg_pulse_sequence_timer_offset_2' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_2[n]
// 0x0600 ~
// 0x067f : Memory 'cfg_pulse_sequence_timer_offset_3' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_3[n]
// 0x0680 ~
// 0x06ff : Memory 'cfg_pulse_sequence_timer_offset_4' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_4[n]
// 0x0700 ~
// 0x077f : Memory 'cfg_pulse_sequence_timer_offset_5' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_5[n]
// 0x0780 ~
// 0x07ff : Memory 'cfg_pulse_sequence_timer_offset_6' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_6[n]
// 0x0800 ~
// 0x087f : Memory 'cfg_pulse_sequence_timer_offset_7' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_7[n]
// 0x0880 ~
// 0x08ff : Memory 'cfg_pulse_sequence_timer_width_0' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_width_0[n]
// 0x0900 ~
// 0x097f : Memory 'cfg_pulse_sequence_timer_width_1' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_width_1[n]
// 0x0980 ~
// 0x09ff : Memory 'cfg_pulse_sequence_timer_width_2' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_width_2[n]
// 0x0a00 ~
// 0x0a7f : Memory 'cfg_pulse_sequence_timer_width_3' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_width_3[n]
// 0x0a80 ~
// 0x0aff : Memory 'cfg_pulse_sequence_timer_width_4' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_width_4[n]
// 0x0b00 ~
// 0x0b7f : Memory 'cfg_pulse_sequence_timer_width_5' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_width_5[n]
// 0x0b80 ~
// 0x0bff : Memory 'cfg_pulse_sequence_timer_width_6' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_width_6[n]
// 0x0c00 ~
// 0x0c7f : Memory 'cfg_pulse_sequence_timer_width_7' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_width_7[n]
// 0x1000 ~
// 0x13ff : Memory 'cfg_filter_coefs_ch0' (192 * 32b)
//          Word n : bit [31:0] - cfg_filter_coefs_ch0[n]
// 0x1400 ~
// 0x17ff : Memory 'cfg_filter_coefs_ch1' (192 * 32b)
//          Word n : bit [31:0] - cfg_filter_coefs_ch1[n]
// 0x1800 ~
// 0x1bff : Memory 'cfg_filter_coefs_ch2' (192 * 32b)
//          Word n : bit [31:0] - cfg_filter_coefs_ch2[n]
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

//------------------------Parameter----------------------
localparam
    ADDR_AP_CTRL                                   = 13'h0000,
    ADDR_GIE                                       = 13'h0004,
    ADDR_IER                                       = 13'h0008,
    ADDR_ISR                                       = 13'h000c,
    ADDR_CFG_PULSE_SEQUENCE_START_INDEX_DATA_0     = 13'h0010,
    ADDR_CFG_PULSE_SEQUENCE_START_INDEX_CTRL       = 13'h0014,
    ADDR_CFG_PULSE_SEQUENCE_LENGTH_DATA_0          = 13'h0018,
    ADDR_CFG_PULSE_SEQUENCE_LENGTH_CTRL            = 13'h001c,
    ADDR_CFG_NUM_PULSES_TO_EXECUTE_DATA_0          = 13'h0020,
    ADDR_CFG_NUM_PULSES_TO_EXECUTE_CTRL            = 13'h0024,
    ADDR_CFG_TOTAL_DECIMATION_DATA_0               = 13'h0028,
    ADDR_CFG_TOTAL_DECIMATION_CTRL                 = 13'h002c,
    ADDR_CFG_POST_DECIMATION_DATA_0                = 13'h0030,
    ADDR_CFG_POST_DECIMATION_CTRL                  = 13'h0034,
    ADDR_CFG_NUM_PULSES_PER_XFER_DATA_0            = 13'h0038,
    ADDR_CFG_NUM_PULSES_PER_XFER_CTRL              = 13'h003c,
    ADDR_CFG_ENABLED_CHANNEL_VECTOR_DATA_0         = 13'h0040,
    ADDR_CFG_ENABLED_CHANNEL_VECTOR_CTRL           = 13'h0044,
    ADDR_CFG_PULSE_SEQUENCE_PRT_0_BASE             = 13'h0080,
    ADDR_CFG_PULSE_SEQUENCE_PRT_0_HIGH             = 13'h00ff,
    ADDR_CFG_PULSE_SEQUENCE_PRT_1_BASE             = 13'h0100,
    ADDR_CFG_PULSE_SEQUENCE_PRT_1_HIGH             = 13'h017f,
    ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_BASE        = 13'h0180,
    ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_HIGH        = 13'h01ff,
    ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_BASE   = 13'h0200,
    ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_HIGH   = 13'h027f,
    ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_BASE     = 13'h0280,
    ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_HIGH     = 13'h02ff,
    ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_BASE = 13'h0300,
    ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_HIGH = 13'h037f,
    ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_BASE = 13'h0380,
    ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_HIGH = 13'h03ff,
    ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_BASE = 13'h0400,
    ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_HIGH = 13'h047f,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_BASE    = 13'h0480,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_HIGH    = 13'h04ff,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_BASE    = 13'h0500,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_HIGH    = 13'h057f,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_BASE    = 13'h0580,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_HIGH    = 13'h05ff,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_BASE    = 13'h0600,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_HIGH    = 13'h067f,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_BASE    = 13'h0680,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_HIGH    = 13'h06ff,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_BASE    = 13'h0700,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_HIGH    = 13'h077f,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_BASE    = 13'h0780,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_HIGH    = 13'h07ff,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_BASE    = 13'h0800,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_HIGH    = 13'h087f,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_BASE     = 13'h0880,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_HIGH     = 13'h08ff,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_BASE     = 13'h0900,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_HIGH     = 13'h097f,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_BASE     = 13'h0980,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_HIGH     = 13'h09ff,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_BASE     = 13'h0a00,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_HIGH     = 13'h0a7f,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_BASE     = 13'h0a80,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_HIGH     = 13'h0aff,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_BASE     = 13'h0b00,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_HIGH     = 13'h0b7f,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_BASE     = 13'h0b80,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_HIGH     = 13'h0bff,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_BASE     = 13'h0c00,
    ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_HIGH     = 13'h0c7f,
    ADDR_CFG_FILTER_COEFS_CH0_BASE                 = 13'h1000,
    ADDR_CFG_FILTER_COEFS_CH0_HIGH                 = 13'h13ff,
    ADDR_CFG_FILTER_COEFS_CH1_BASE                 = 13'h1400,
    ADDR_CFG_FILTER_COEFS_CH1_HIGH                 = 13'h17ff,
    ADDR_CFG_FILTER_COEFS_CH2_BASE                 = 13'h1800,
    ADDR_CFG_FILTER_COEFS_CH2_HIGH                 = 13'h1bff,
    WRIDLE                                         = 2'd0,
    WRDATA                                         = 2'd1,
    WRRESP                                         = 2'd2,
    WRRESET                                        = 2'd3,
    RDIDLE                                         = 2'd0,
    RDDATA                                         = 2'd1,
    RDRESET                                        = 2'd2,
    ADDR_BITS         = 13;

//------------------------Local signal-------------------
    reg  [1:0]                    wstate = WRRESET;
    reg  [1:0]                    wnext;
    reg  [ADDR_BITS-1:0]          waddr;
    wire [31:0]                   wmask;
    wire                          aw_hs;
    wire                          w_hs;
    reg  [1:0]                    rstate = RDRESET;
    reg  [1:0]                    rnext;
    reg  [31:0]                   rdata;
    wire                          ar_hs;
    wire [ADDR_BITS-1:0]          raddr;
    // internal registers
    reg                           int_ap_idle;
    reg                           int_ap_ready;
    reg                           int_ap_done = 1'b0;
    reg                           int_ap_start = 1'b0;
    reg                           int_auto_restart = 1'b0;
    reg                           int_gie = 1'b0;
    reg  [1:0]                    int_ier = 2'b0;
    reg  [1:0]                    int_isr = 2'b0;
    reg  [7:0]                    int_cfg_pulse_sequence_start_index = 'b0;
    reg  [7:0]                    int_cfg_pulse_sequence_length = 'b0;
    reg  [31:0]                   int_cfg_num_pulses_to_execute = 'b0;
    reg  [31:0]                   int_cfg_total_decimation = 'b0;
    reg  [31:0]                   int_cfg_post_decimation = 'b0;
    reg  [31:0]                   int_cfg_num_pulses_per_xfer = 'b0;
    reg  [31:0]                   int_cfg_enabled_channel_vector = 'b0;
    // memory signals
    wire [4:0]                    int_cfg_pulse_sequence_prt_0_address0;
    wire                          int_cfg_pulse_sequence_prt_0_ce0;
    wire                          int_cfg_pulse_sequence_prt_0_we0;
    wire [3:0]                    int_cfg_pulse_sequence_prt_0_be0;
    wire [31:0]                   int_cfg_pulse_sequence_prt_0_d0;
    wire [31:0]                   int_cfg_pulse_sequence_prt_0_q0;
    wire [4:0]                    int_cfg_pulse_sequence_prt_0_address1;
    wire                          int_cfg_pulse_sequence_prt_0_ce1;
    wire                          int_cfg_pulse_sequence_prt_0_we1;
    wire [3:0]                    int_cfg_pulse_sequence_prt_0_be1;
    wire [31:0]                   int_cfg_pulse_sequence_prt_0_d1;
    wire [31:0]                   int_cfg_pulse_sequence_prt_0_q1;
    reg                           int_cfg_pulse_sequence_prt_0_read;
    reg                           int_cfg_pulse_sequence_prt_0_write;
    wire [4:0]                    int_cfg_pulse_sequence_prt_1_address0;
    wire                          int_cfg_pulse_sequence_prt_1_ce0;
    wire                          int_cfg_pulse_sequence_prt_1_we0;
    wire [3:0]                    int_cfg_pulse_sequence_prt_1_be0;
    wire [31:0]                   int_cfg_pulse_sequence_prt_1_d0;
    wire [31:0]                   int_cfg_pulse_sequence_prt_1_q0;
    wire [4:0]                    int_cfg_pulse_sequence_prt_1_address1;
    wire                          int_cfg_pulse_sequence_prt_1_ce1;
    wire                          int_cfg_pulse_sequence_prt_1_we1;
    wire [3:0]                    int_cfg_pulse_sequence_prt_1_be1;
    wire [31:0]                   int_cfg_pulse_sequence_prt_1_d1;
    wire [31:0]                   int_cfg_pulse_sequence_prt_1_q1;
    reg                           int_cfg_pulse_sequence_prt_1_read;
    reg                           int_cfg_pulse_sequence_prt_1_write;
    wire [4:0]                    int_cfg_pulse_sequence_num_pulses_address0;
    wire                          int_cfg_pulse_sequence_num_pulses_ce0;
    wire                          int_cfg_pulse_sequence_num_pulses_we0;
    wire [3:0]                    int_cfg_pulse_sequence_num_pulses_be0;
    wire [31:0]                   int_cfg_pulse_sequence_num_pulses_d0;
    wire [31:0]                   int_cfg_pulse_sequence_num_pulses_q0;
    wire [4:0]                    int_cfg_pulse_sequence_num_pulses_address1;
    wire                          int_cfg_pulse_sequence_num_pulses_ce1;
    wire                          int_cfg_pulse_sequence_num_pulses_we1;
    wire [3:0]                    int_cfg_pulse_sequence_num_pulses_be1;
    wire [31:0]                   int_cfg_pulse_sequence_num_pulses_d1;
    wire [31:0]                   int_cfg_pulse_sequence_num_pulses_q1;
    reg                           int_cfg_pulse_sequence_num_pulses_read;
    reg                           int_cfg_pulse_sequence_num_pulses_write;
    wire [4:0]                    int_cfg_pulse_sequence_block_post_time_address0;
    wire                          int_cfg_pulse_sequence_block_post_time_ce0;
    wire                          int_cfg_pulse_sequence_block_post_time_we0;
    wire [3:0]                    int_cfg_pulse_sequence_block_post_time_be0;
    wire [31:0]                   int_cfg_pulse_sequence_block_post_time_d0;
    wire [31:0]                   int_cfg_pulse_sequence_block_post_time_q0;
    wire [4:0]                    int_cfg_pulse_sequence_block_post_time_address1;
    wire                          int_cfg_pulse_sequence_block_post_time_ce1;
    wire                          int_cfg_pulse_sequence_block_post_time_we1;
    wire [3:0]                    int_cfg_pulse_sequence_block_post_time_be1;
    wire [31:0]                   int_cfg_pulse_sequence_block_post_time_d1;
    wire [31:0]                   int_cfg_pulse_sequence_block_post_time_q1;
    reg                           int_cfg_pulse_sequence_block_post_time_read;
    reg                           int_cfg_pulse_sequence_block_post_time_write;
    wire [4:0]                    int_cfg_pulse_sequence_control_flags_address0;
    wire                          int_cfg_pulse_sequence_control_flags_ce0;
    wire                          int_cfg_pulse_sequence_control_flags_we0;
    wire [3:0]                    int_cfg_pulse_sequence_control_flags_be0;
    wire [31:0]                   int_cfg_pulse_sequence_control_flags_d0;
    wire [31:0]                   int_cfg_pulse_sequence_control_flags_q0;
    wire [4:0]                    int_cfg_pulse_sequence_control_flags_address1;
    wire                          int_cfg_pulse_sequence_control_flags_ce1;
    wire                          int_cfg_pulse_sequence_control_flags_we1;
    wire [3:0]                    int_cfg_pulse_sequence_control_flags_be1;
    wire [31:0]                   int_cfg_pulse_sequence_control_flags_d1;
    wire [31:0]                   int_cfg_pulse_sequence_control_flags_q1;
    reg                           int_cfg_pulse_sequence_control_flags_read;
    reg                           int_cfg_pulse_sequence_control_flags_write;
    wire [4:0]                    int_cfg_pulse_sequence_filter_select_ch0_address0;
    wire                          int_cfg_pulse_sequence_filter_select_ch0_ce0;
    wire                          int_cfg_pulse_sequence_filter_select_ch0_we0;
    wire [3:0]                    int_cfg_pulse_sequence_filter_select_ch0_be0;
    wire [31:0]                   int_cfg_pulse_sequence_filter_select_ch0_d0;
    wire [31:0]                   int_cfg_pulse_sequence_filter_select_ch0_q0;
    wire [4:0]                    int_cfg_pulse_sequence_filter_select_ch0_address1;
    wire                          int_cfg_pulse_sequence_filter_select_ch0_ce1;
    wire                          int_cfg_pulse_sequence_filter_select_ch0_we1;
    wire [3:0]                    int_cfg_pulse_sequence_filter_select_ch0_be1;
    wire [31:0]                   int_cfg_pulse_sequence_filter_select_ch0_d1;
    wire [31:0]                   int_cfg_pulse_sequence_filter_select_ch0_q1;
    reg                           int_cfg_pulse_sequence_filter_select_ch0_read;
    reg                           int_cfg_pulse_sequence_filter_select_ch0_write;
    wire [4:0]                    int_cfg_pulse_sequence_filter_select_ch1_address0;
    wire                          int_cfg_pulse_sequence_filter_select_ch1_ce0;
    wire                          int_cfg_pulse_sequence_filter_select_ch1_we0;
    wire [3:0]                    int_cfg_pulse_sequence_filter_select_ch1_be0;
    wire [31:0]                   int_cfg_pulse_sequence_filter_select_ch1_d0;
    wire [31:0]                   int_cfg_pulse_sequence_filter_select_ch1_q0;
    wire [4:0]                    int_cfg_pulse_sequence_filter_select_ch1_address1;
    wire                          int_cfg_pulse_sequence_filter_select_ch1_ce1;
    wire                          int_cfg_pulse_sequence_filter_select_ch1_we1;
    wire [3:0]                    int_cfg_pulse_sequence_filter_select_ch1_be1;
    wire [31:0]                   int_cfg_pulse_sequence_filter_select_ch1_d1;
    wire [31:0]                   int_cfg_pulse_sequence_filter_select_ch1_q1;
    reg                           int_cfg_pulse_sequence_filter_select_ch1_read;
    reg                           int_cfg_pulse_sequence_filter_select_ch1_write;
    wire [4:0]                    int_cfg_pulse_sequence_filter_select_ch2_address0;
    wire                          int_cfg_pulse_sequence_filter_select_ch2_ce0;
    wire                          int_cfg_pulse_sequence_filter_select_ch2_we0;
    wire [3:0]                    int_cfg_pulse_sequence_filter_select_ch2_be0;
    wire [31:0]                   int_cfg_pulse_sequence_filter_select_ch2_d0;
    wire [31:0]                   int_cfg_pulse_sequence_filter_select_ch2_q0;
    wire [4:0]                    int_cfg_pulse_sequence_filter_select_ch2_address1;
    wire                          int_cfg_pulse_sequence_filter_select_ch2_ce1;
    wire                          int_cfg_pulse_sequence_filter_select_ch2_we1;
    wire [3:0]                    int_cfg_pulse_sequence_filter_select_ch2_be1;
    wire [31:0]                   int_cfg_pulse_sequence_filter_select_ch2_d1;
    wire [31:0]                   int_cfg_pulse_sequence_filter_select_ch2_q1;
    reg                           int_cfg_pulse_sequence_filter_select_ch2_read;
    reg                           int_cfg_pulse_sequence_filter_select_ch2_write;
    wire [4:0]                    int_cfg_pulse_sequence_timer_offset_0_address0;
    wire                          int_cfg_pulse_sequence_timer_offset_0_ce0;
    wire                          int_cfg_pulse_sequence_timer_offset_0_we0;
    wire [3:0]                    int_cfg_pulse_sequence_timer_offset_0_be0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_0_d0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_0_q0;
    wire [4:0]                    int_cfg_pulse_sequence_timer_offset_0_address1;
    wire                          int_cfg_pulse_sequence_timer_offset_0_ce1;
    wire                          int_cfg_pulse_sequence_timer_offset_0_we1;
    wire [3:0]                    int_cfg_pulse_sequence_timer_offset_0_be1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_0_d1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_0_q1;
    reg                           int_cfg_pulse_sequence_timer_offset_0_read;
    reg                           int_cfg_pulse_sequence_timer_offset_0_write;
    wire [4:0]                    int_cfg_pulse_sequence_timer_offset_1_address0;
    wire                          int_cfg_pulse_sequence_timer_offset_1_ce0;
    wire                          int_cfg_pulse_sequence_timer_offset_1_we0;
    wire [3:0]                    int_cfg_pulse_sequence_timer_offset_1_be0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_1_d0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_1_q0;
    wire [4:0]                    int_cfg_pulse_sequence_timer_offset_1_address1;
    wire                          int_cfg_pulse_sequence_timer_offset_1_ce1;
    wire                          int_cfg_pulse_sequence_timer_offset_1_we1;
    wire [3:0]                    int_cfg_pulse_sequence_timer_offset_1_be1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_1_d1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_1_q1;
    reg                           int_cfg_pulse_sequence_timer_offset_1_read;
    reg                           int_cfg_pulse_sequence_timer_offset_1_write;
    wire [4:0]                    int_cfg_pulse_sequence_timer_offset_2_address0;
    wire                          int_cfg_pulse_sequence_timer_offset_2_ce0;
    wire                          int_cfg_pulse_sequence_timer_offset_2_we0;
    wire [3:0]                    int_cfg_pulse_sequence_timer_offset_2_be0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_2_d0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_2_q0;
    wire [4:0]                    int_cfg_pulse_sequence_timer_offset_2_address1;
    wire                          int_cfg_pulse_sequence_timer_offset_2_ce1;
    wire                          int_cfg_pulse_sequence_timer_offset_2_we1;
    wire [3:0]                    int_cfg_pulse_sequence_timer_offset_2_be1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_2_d1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_2_q1;
    reg                           int_cfg_pulse_sequence_timer_offset_2_read;
    reg                           int_cfg_pulse_sequence_timer_offset_2_write;
    wire [4:0]                    int_cfg_pulse_sequence_timer_offset_3_address0;
    wire                          int_cfg_pulse_sequence_timer_offset_3_ce0;
    wire                          int_cfg_pulse_sequence_timer_offset_3_we0;
    wire [3:0]                    int_cfg_pulse_sequence_timer_offset_3_be0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_3_d0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_3_q0;
    wire [4:0]                    int_cfg_pulse_sequence_timer_offset_3_address1;
    wire                          int_cfg_pulse_sequence_timer_offset_3_ce1;
    wire                          int_cfg_pulse_sequence_timer_offset_3_we1;
    wire [3:0]                    int_cfg_pulse_sequence_timer_offset_3_be1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_3_d1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_3_q1;
    reg                           int_cfg_pulse_sequence_timer_offset_3_read;
    reg                           int_cfg_pulse_sequence_timer_offset_3_write;
    wire [4:0]                    int_cfg_pulse_sequence_timer_offset_4_address0;
    wire                          int_cfg_pulse_sequence_timer_offset_4_ce0;
    wire                          int_cfg_pulse_sequence_timer_offset_4_we0;
    wire [3:0]                    int_cfg_pulse_sequence_timer_offset_4_be0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_4_d0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_4_q0;
    wire [4:0]                    int_cfg_pulse_sequence_timer_offset_4_address1;
    wire                          int_cfg_pulse_sequence_timer_offset_4_ce1;
    wire                          int_cfg_pulse_sequence_timer_offset_4_we1;
    wire [3:0]                    int_cfg_pulse_sequence_timer_offset_4_be1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_4_d1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_4_q1;
    reg                           int_cfg_pulse_sequence_timer_offset_4_read;
    reg                           int_cfg_pulse_sequence_timer_offset_4_write;
    wire [4:0]                    int_cfg_pulse_sequence_timer_offset_5_address0;
    wire                          int_cfg_pulse_sequence_timer_offset_5_ce0;
    wire                          int_cfg_pulse_sequence_timer_offset_5_we0;
    wire [3:0]                    int_cfg_pulse_sequence_timer_offset_5_be0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_5_d0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_5_q0;
    wire [4:0]                    int_cfg_pulse_sequence_timer_offset_5_address1;
    wire                          int_cfg_pulse_sequence_timer_offset_5_ce1;
    wire                          int_cfg_pulse_sequence_timer_offset_5_we1;
    wire [3:0]                    int_cfg_pulse_sequence_timer_offset_5_be1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_5_d1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_5_q1;
    reg                           int_cfg_pulse_sequence_timer_offset_5_read;
    reg                           int_cfg_pulse_sequence_timer_offset_5_write;
    wire [4:0]                    int_cfg_pulse_sequence_timer_offset_6_address0;
    wire                          int_cfg_pulse_sequence_timer_offset_6_ce0;
    wire                          int_cfg_pulse_sequence_timer_offset_6_we0;
    wire [3:0]                    int_cfg_pulse_sequence_timer_offset_6_be0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_6_d0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_6_q0;
    wire [4:0]                    int_cfg_pulse_sequence_timer_offset_6_address1;
    wire                          int_cfg_pulse_sequence_timer_offset_6_ce1;
    wire                          int_cfg_pulse_sequence_timer_offset_6_we1;
    wire [3:0]                    int_cfg_pulse_sequence_timer_offset_6_be1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_6_d1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_6_q1;
    reg                           int_cfg_pulse_sequence_timer_offset_6_read;
    reg                           int_cfg_pulse_sequence_timer_offset_6_write;
    wire [4:0]                    int_cfg_pulse_sequence_timer_offset_7_address0;
    wire                          int_cfg_pulse_sequence_timer_offset_7_ce0;
    wire                          int_cfg_pulse_sequence_timer_offset_7_we0;
    wire [3:0]                    int_cfg_pulse_sequence_timer_offset_7_be0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_7_d0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_7_q0;
    wire [4:0]                    int_cfg_pulse_sequence_timer_offset_7_address1;
    wire                          int_cfg_pulse_sequence_timer_offset_7_ce1;
    wire                          int_cfg_pulse_sequence_timer_offset_7_we1;
    wire [3:0]                    int_cfg_pulse_sequence_timer_offset_7_be1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_7_d1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_offset_7_q1;
    reg                           int_cfg_pulse_sequence_timer_offset_7_read;
    reg                           int_cfg_pulse_sequence_timer_offset_7_write;
    wire [4:0]                    int_cfg_pulse_sequence_timer_width_0_address0;
    wire                          int_cfg_pulse_sequence_timer_width_0_ce0;
    wire                          int_cfg_pulse_sequence_timer_width_0_we0;
    wire [3:0]                    int_cfg_pulse_sequence_timer_width_0_be0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_0_d0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_0_q0;
    wire [4:0]                    int_cfg_pulse_sequence_timer_width_0_address1;
    wire                          int_cfg_pulse_sequence_timer_width_0_ce1;
    wire                          int_cfg_pulse_sequence_timer_width_0_we1;
    wire [3:0]                    int_cfg_pulse_sequence_timer_width_0_be1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_0_d1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_0_q1;
    reg                           int_cfg_pulse_sequence_timer_width_0_read;
    reg                           int_cfg_pulse_sequence_timer_width_0_write;
    wire [4:0]                    int_cfg_pulse_sequence_timer_width_1_address0;
    wire                          int_cfg_pulse_sequence_timer_width_1_ce0;
    wire                          int_cfg_pulse_sequence_timer_width_1_we0;
    wire [3:0]                    int_cfg_pulse_sequence_timer_width_1_be0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_1_d0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_1_q0;
    wire [4:0]                    int_cfg_pulse_sequence_timer_width_1_address1;
    wire                          int_cfg_pulse_sequence_timer_width_1_ce1;
    wire                          int_cfg_pulse_sequence_timer_width_1_we1;
    wire [3:0]                    int_cfg_pulse_sequence_timer_width_1_be1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_1_d1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_1_q1;
    reg                           int_cfg_pulse_sequence_timer_width_1_read;
    reg                           int_cfg_pulse_sequence_timer_width_1_write;
    wire [4:0]                    int_cfg_pulse_sequence_timer_width_2_address0;
    wire                          int_cfg_pulse_sequence_timer_width_2_ce0;
    wire                          int_cfg_pulse_sequence_timer_width_2_we0;
    wire [3:0]                    int_cfg_pulse_sequence_timer_width_2_be0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_2_d0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_2_q0;
    wire [4:0]                    int_cfg_pulse_sequence_timer_width_2_address1;
    wire                          int_cfg_pulse_sequence_timer_width_2_ce1;
    wire                          int_cfg_pulse_sequence_timer_width_2_we1;
    wire [3:0]                    int_cfg_pulse_sequence_timer_width_2_be1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_2_d1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_2_q1;
    reg                           int_cfg_pulse_sequence_timer_width_2_read;
    reg                           int_cfg_pulse_sequence_timer_width_2_write;
    wire [4:0]                    int_cfg_pulse_sequence_timer_width_3_address0;
    wire                          int_cfg_pulse_sequence_timer_width_3_ce0;
    wire                          int_cfg_pulse_sequence_timer_width_3_we0;
    wire [3:0]                    int_cfg_pulse_sequence_timer_width_3_be0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_3_d0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_3_q0;
    wire [4:0]                    int_cfg_pulse_sequence_timer_width_3_address1;
    wire                          int_cfg_pulse_sequence_timer_width_3_ce1;
    wire                          int_cfg_pulse_sequence_timer_width_3_we1;
    wire [3:0]                    int_cfg_pulse_sequence_timer_width_3_be1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_3_d1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_3_q1;
    reg                           int_cfg_pulse_sequence_timer_width_3_read;
    reg                           int_cfg_pulse_sequence_timer_width_3_write;
    wire [4:0]                    int_cfg_pulse_sequence_timer_width_4_address0;
    wire                          int_cfg_pulse_sequence_timer_width_4_ce0;
    wire                          int_cfg_pulse_sequence_timer_width_4_we0;
    wire [3:0]                    int_cfg_pulse_sequence_timer_width_4_be0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_4_d0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_4_q0;
    wire [4:0]                    int_cfg_pulse_sequence_timer_width_4_address1;
    wire                          int_cfg_pulse_sequence_timer_width_4_ce1;
    wire                          int_cfg_pulse_sequence_timer_width_4_we1;
    wire [3:0]                    int_cfg_pulse_sequence_timer_width_4_be1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_4_d1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_4_q1;
    reg                           int_cfg_pulse_sequence_timer_width_4_read;
    reg                           int_cfg_pulse_sequence_timer_width_4_write;
    wire [4:0]                    int_cfg_pulse_sequence_timer_width_5_address0;
    wire                          int_cfg_pulse_sequence_timer_width_5_ce0;
    wire                          int_cfg_pulse_sequence_timer_width_5_we0;
    wire [3:0]                    int_cfg_pulse_sequence_timer_width_5_be0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_5_d0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_5_q0;
    wire [4:0]                    int_cfg_pulse_sequence_timer_width_5_address1;
    wire                          int_cfg_pulse_sequence_timer_width_5_ce1;
    wire                          int_cfg_pulse_sequence_timer_width_5_we1;
    wire [3:0]                    int_cfg_pulse_sequence_timer_width_5_be1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_5_d1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_5_q1;
    reg                           int_cfg_pulse_sequence_timer_width_5_read;
    reg                           int_cfg_pulse_sequence_timer_width_5_write;
    wire [4:0]                    int_cfg_pulse_sequence_timer_width_6_address0;
    wire                          int_cfg_pulse_sequence_timer_width_6_ce0;
    wire                          int_cfg_pulse_sequence_timer_width_6_we0;
    wire [3:0]                    int_cfg_pulse_sequence_timer_width_6_be0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_6_d0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_6_q0;
    wire [4:0]                    int_cfg_pulse_sequence_timer_width_6_address1;
    wire                          int_cfg_pulse_sequence_timer_width_6_ce1;
    wire                          int_cfg_pulse_sequence_timer_width_6_we1;
    wire [3:0]                    int_cfg_pulse_sequence_timer_width_6_be1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_6_d1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_6_q1;
    reg                           int_cfg_pulse_sequence_timer_width_6_read;
    reg                           int_cfg_pulse_sequence_timer_width_6_write;
    wire [4:0]                    int_cfg_pulse_sequence_timer_width_7_address0;
    wire                          int_cfg_pulse_sequence_timer_width_7_ce0;
    wire                          int_cfg_pulse_sequence_timer_width_7_we0;
    wire [3:0]                    int_cfg_pulse_sequence_timer_width_7_be0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_7_d0;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_7_q0;
    wire [4:0]                    int_cfg_pulse_sequence_timer_width_7_address1;
    wire                          int_cfg_pulse_sequence_timer_width_7_ce1;
    wire                          int_cfg_pulse_sequence_timer_width_7_we1;
    wire [3:0]                    int_cfg_pulse_sequence_timer_width_7_be1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_7_d1;
    wire [31:0]                   int_cfg_pulse_sequence_timer_width_7_q1;
    reg                           int_cfg_pulse_sequence_timer_width_7_read;
    reg                           int_cfg_pulse_sequence_timer_width_7_write;
    wire [7:0]                    int_cfg_filter_coefs_ch0_address0;
    wire                          int_cfg_filter_coefs_ch0_ce0;
    wire                          int_cfg_filter_coefs_ch0_we0;
    wire [3:0]                    int_cfg_filter_coefs_ch0_be0;
    wire [31:0]                   int_cfg_filter_coefs_ch0_d0;
    wire [31:0]                   int_cfg_filter_coefs_ch0_q0;
    wire [7:0]                    int_cfg_filter_coefs_ch0_address1;
    wire                          int_cfg_filter_coefs_ch0_ce1;
    wire                          int_cfg_filter_coefs_ch0_we1;
    wire [3:0]                    int_cfg_filter_coefs_ch0_be1;
    wire [31:0]                   int_cfg_filter_coefs_ch0_d1;
    wire [31:0]                   int_cfg_filter_coefs_ch0_q1;
    reg                           int_cfg_filter_coefs_ch0_read;
    reg                           int_cfg_filter_coefs_ch0_write;
    wire [7:0]                    int_cfg_filter_coefs_ch1_address0;
    wire                          int_cfg_filter_coefs_ch1_ce0;
    wire                          int_cfg_filter_coefs_ch1_we0;
    wire [3:0]                    int_cfg_filter_coefs_ch1_be0;
    wire [31:0]                   int_cfg_filter_coefs_ch1_d0;
    wire [31:0]                   int_cfg_filter_coefs_ch1_q0;
    wire [7:0]                    int_cfg_filter_coefs_ch1_address1;
    wire                          int_cfg_filter_coefs_ch1_ce1;
    wire                          int_cfg_filter_coefs_ch1_we1;
    wire [3:0]                    int_cfg_filter_coefs_ch1_be1;
    wire [31:0]                   int_cfg_filter_coefs_ch1_d1;
    wire [31:0]                   int_cfg_filter_coefs_ch1_q1;
    reg                           int_cfg_filter_coefs_ch1_read;
    reg                           int_cfg_filter_coefs_ch1_write;
    wire [7:0]                    int_cfg_filter_coefs_ch2_address0;
    wire                          int_cfg_filter_coefs_ch2_ce0;
    wire                          int_cfg_filter_coefs_ch2_we0;
    wire [3:0]                    int_cfg_filter_coefs_ch2_be0;
    wire [31:0]                   int_cfg_filter_coefs_ch2_d0;
    wire [31:0]                   int_cfg_filter_coefs_ch2_q0;
    wire [7:0]                    int_cfg_filter_coefs_ch2_address1;
    wire                          int_cfg_filter_coefs_ch2_ce1;
    wire                          int_cfg_filter_coefs_ch2_we1;
    wire [3:0]                    int_cfg_filter_coefs_ch2_be1;
    wire [31:0]                   int_cfg_filter_coefs_ch2_d1;
    wire [31:0]                   int_cfg_filter_coefs_ch2_q1;
    reg                           int_cfg_filter_coefs_ch2_read;
    reg                           int_cfg_filter_coefs_ch2_write;

//------------------------Instantiation------------------
// int_cfg_pulse_sequence_prt_0
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_cfg_pulse_sequence_prt_0 (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_pulse_sequence_prt_0_address0 ),
    .ce0      ( int_cfg_pulse_sequence_prt_0_ce0 ),
    .we0      ( int_cfg_pulse_sequence_prt_0_we0 ),
    .be0      ( int_cfg_pulse_sequence_prt_0_be0 ),
    .d0       ( int_cfg_pulse_sequence_prt_0_d0 ),
    .q0       ( int_cfg_pulse_sequence_prt_0_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_pulse_sequence_prt_0_address1 ),
    .ce1      ( int_cfg_pulse_sequence_prt_0_ce1 ),
    .we1      ( int_cfg_pulse_sequence_prt_0_we1 ),
    .be1      ( int_cfg_pulse_sequence_prt_0_be1 ),
    .d1       ( int_cfg_pulse_sequence_prt_0_d1 ),
    .q1       ( int_cfg_pulse_sequence_prt_0_q1 )
);
// int_cfg_pulse_sequence_prt_1
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_cfg_pulse_sequence_prt_1 (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_pulse_sequence_prt_1_address0 ),
    .ce0      ( int_cfg_pulse_sequence_prt_1_ce0 ),
    .we0      ( int_cfg_pulse_sequence_prt_1_we0 ),
    .be0      ( int_cfg_pulse_sequence_prt_1_be0 ),
    .d0       ( int_cfg_pulse_sequence_prt_1_d0 ),
    .q0       ( int_cfg_pulse_sequence_prt_1_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_pulse_sequence_prt_1_address1 ),
    .ce1      ( int_cfg_pulse_sequence_prt_1_ce1 ),
    .we1      ( int_cfg_pulse_sequence_prt_1_we1 ),
    .be1      ( int_cfg_pulse_sequence_prt_1_be1 ),
    .d1       ( int_cfg_pulse_sequence_prt_1_d1 ),
    .q1       ( int_cfg_pulse_sequence_prt_1_q1 )
);
// int_cfg_pulse_sequence_num_pulses
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_cfg_pulse_sequence_num_pulses (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_pulse_sequence_num_pulses_address0 ),
    .ce0      ( int_cfg_pulse_sequence_num_pulses_ce0 ),
    .we0      ( int_cfg_pulse_sequence_num_pulses_we0 ),
    .be0      ( int_cfg_pulse_sequence_num_pulses_be0 ),
    .d0       ( int_cfg_pulse_sequence_num_pulses_d0 ),
    .q0       ( int_cfg_pulse_sequence_num_pulses_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_pulse_sequence_num_pulses_address1 ),
    .ce1      ( int_cfg_pulse_sequence_num_pulses_ce1 ),
    .we1      ( int_cfg_pulse_sequence_num_pulses_we1 ),
    .be1      ( int_cfg_pulse_sequence_num_pulses_be1 ),
    .d1       ( int_cfg_pulse_sequence_num_pulses_d1 ),
    .q1       ( int_cfg_pulse_sequence_num_pulses_q1 )
);
// int_cfg_pulse_sequence_block_post_time
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_cfg_pulse_sequence_block_post_time (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_pulse_sequence_block_post_time_address0 ),
    .ce0      ( int_cfg_pulse_sequence_block_post_time_ce0 ),
    .we0      ( int_cfg_pulse_sequence_block_post_time_we0 ),
    .be0      ( int_cfg_pulse_sequence_block_post_time_be0 ),
    .d0       ( int_cfg_pulse_sequence_block_post_time_d0 ),
    .q0       ( int_cfg_pulse_sequence_block_post_time_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_pulse_sequence_block_post_time_address1 ),
    .ce1      ( int_cfg_pulse_sequence_block_post_time_ce1 ),
    .we1      ( int_cfg_pulse_sequence_block_post_time_we1 ),
    .be1      ( int_cfg_pulse_sequence_block_post_time_be1 ),
    .d1       ( int_cfg_pulse_sequence_block_post_time_d1 ),
    .q1       ( int_cfg_pulse_sequence_block_post_time_q1 )
);
// int_cfg_pulse_sequence_control_flags
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_cfg_pulse_sequence_control_flags (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_pulse_sequence_control_flags_address0 ),
    .ce0      ( int_cfg_pulse_sequence_control_flags_ce0 ),
    .we0      ( int_cfg_pulse_sequence_control_flags_we0 ),
    .be0      ( int_cfg_pulse_sequence_control_flags_be0 ),
    .d0       ( int_cfg_pulse_sequence_control_flags_d0 ),
    .q0       ( int_cfg_pulse_sequence_control_flags_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_pulse_sequence_control_flags_address1 ),
    .ce1      ( int_cfg_pulse_sequence_control_flags_ce1 ),
    .we1      ( int_cfg_pulse_sequence_control_flags_we1 ),
    .be1      ( int_cfg_pulse_sequence_control_flags_be1 ),
    .d1       ( int_cfg_pulse_sequence_control_flags_d1 ),
    .q1       ( int_cfg_pulse_sequence_control_flags_q1 )
);
// int_cfg_pulse_sequence_filter_select_ch0
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_cfg_pulse_sequence_filter_select_ch0 (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_pulse_sequence_filter_select_ch0_address0 ),
    .ce0      ( int_cfg_pulse_sequence_filter_select_ch0_ce0 ),
    .we0      ( int_cfg_pulse_sequence_filter_select_ch0_we0 ),
    .be0      ( int_cfg_pulse_sequence_filter_select_ch0_be0 ),
    .d0       ( int_cfg_pulse_sequence_filter_select_ch0_d0 ),
    .q0       ( int_cfg_pulse_sequence_filter_select_ch0_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_pulse_sequence_filter_select_ch0_address1 ),
    .ce1      ( int_cfg_pulse_sequence_filter_select_ch0_ce1 ),
    .we1      ( int_cfg_pulse_sequence_filter_select_ch0_we1 ),
    .be1      ( int_cfg_pulse_sequence_filter_select_ch0_be1 ),
    .d1       ( int_cfg_pulse_sequence_filter_select_ch0_d1 ),
    .q1       ( int_cfg_pulse_sequence_filter_select_ch0_q1 )
);
// int_cfg_pulse_sequence_filter_select_ch1
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_cfg_pulse_sequence_filter_select_ch1 (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_pulse_sequence_filter_select_ch1_address0 ),
    .ce0      ( int_cfg_pulse_sequence_filter_select_ch1_ce0 ),
    .we0      ( int_cfg_pulse_sequence_filter_select_ch1_we0 ),
    .be0      ( int_cfg_pulse_sequence_filter_select_ch1_be0 ),
    .d0       ( int_cfg_pulse_sequence_filter_select_ch1_d0 ),
    .q0       ( int_cfg_pulse_sequence_filter_select_ch1_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_pulse_sequence_filter_select_ch1_address1 ),
    .ce1      ( int_cfg_pulse_sequence_filter_select_ch1_ce1 ),
    .we1      ( int_cfg_pulse_sequence_filter_select_ch1_we1 ),
    .be1      ( int_cfg_pulse_sequence_filter_select_ch1_be1 ),
    .d1       ( int_cfg_pulse_sequence_filter_select_ch1_d1 ),
    .q1       ( int_cfg_pulse_sequence_filter_select_ch1_q1 )
);
// int_cfg_pulse_sequence_filter_select_ch2
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_cfg_pulse_sequence_filter_select_ch2 (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_pulse_sequence_filter_select_ch2_address0 ),
    .ce0      ( int_cfg_pulse_sequence_filter_select_ch2_ce0 ),
    .we0      ( int_cfg_pulse_sequence_filter_select_ch2_we0 ),
    .be0      ( int_cfg_pulse_sequence_filter_select_ch2_be0 ),
    .d0       ( int_cfg_pulse_sequence_filter_select_ch2_d0 ),
    .q0       ( int_cfg_pulse_sequence_filter_select_ch2_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_pulse_sequence_filter_select_ch2_address1 ),
    .ce1      ( int_cfg_pulse_sequence_filter_select_ch2_ce1 ),
    .we1      ( int_cfg_pulse_sequence_filter_select_ch2_we1 ),
    .be1      ( int_cfg_pulse_sequence_filter_select_ch2_be1 ),
    .d1       ( int_cfg_pulse_sequence_filter_select_ch2_d1 ),
    .q1       ( int_cfg_pulse_sequence_filter_select_ch2_q1 )
);
// int_cfg_pulse_sequence_timer_offset_0
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_cfg_pulse_sequence_timer_offset_0 (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_pulse_sequence_timer_offset_0_address0 ),
    .ce0      ( int_cfg_pulse_sequence_timer_offset_0_ce0 ),
    .we0      ( int_cfg_pulse_sequence_timer_offset_0_we0 ),
    .be0      ( int_cfg_pulse_sequence_timer_offset_0_be0 ),
    .d0       ( int_cfg_pulse_sequence_timer_offset_0_d0 ),
    .q0       ( int_cfg_pulse_sequence_timer_offset_0_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_pulse_sequence_timer_offset_0_address1 ),
    .ce1      ( int_cfg_pulse_sequence_timer_offset_0_ce1 ),
    .we1      ( int_cfg_pulse_sequence_timer_offset_0_we1 ),
    .be1      ( int_cfg_pulse_sequence_timer_offset_0_be1 ),
    .d1       ( int_cfg_pulse_sequence_timer_offset_0_d1 ),
    .q1       ( int_cfg_pulse_sequence_timer_offset_0_q1 )
);
// int_cfg_pulse_sequence_timer_offset_1
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_cfg_pulse_sequence_timer_offset_1 (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_pulse_sequence_timer_offset_1_address0 ),
    .ce0      ( int_cfg_pulse_sequence_timer_offset_1_ce0 ),
    .we0      ( int_cfg_pulse_sequence_timer_offset_1_we0 ),
    .be0      ( int_cfg_pulse_sequence_timer_offset_1_be0 ),
    .d0       ( int_cfg_pulse_sequence_timer_offset_1_d0 ),
    .q0       ( int_cfg_pulse_sequence_timer_offset_1_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_pulse_sequence_timer_offset_1_address1 ),
    .ce1      ( int_cfg_pulse_sequence_timer_offset_1_ce1 ),
    .we1      ( int_cfg_pulse_sequence_timer_offset_1_we1 ),
    .be1      ( int_cfg_pulse_sequence_timer_offset_1_be1 ),
    .d1       ( int_cfg_pulse_sequence_timer_offset_1_d1 ),
    .q1       ( int_cfg_pulse_sequence_timer_offset_1_q1 )
);
// int_cfg_pulse_sequence_timer_offset_2
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_cfg_pulse_sequence_timer_offset_2 (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_pulse_sequence_timer_offset_2_address0 ),
    .ce0      ( int_cfg_pulse_sequence_timer_offset_2_ce0 ),
    .we0      ( int_cfg_pulse_sequence_timer_offset_2_we0 ),
    .be0      ( int_cfg_pulse_sequence_timer_offset_2_be0 ),
    .d0       ( int_cfg_pulse_sequence_timer_offset_2_d0 ),
    .q0       ( int_cfg_pulse_sequence_timer_offset_2_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_pulse_sequence_timer_offset_2_address1 ),
    .ce1      ( int_cfg_pulse_sequence_timer_offset_2_ce1 ),
    .we1      ( int_cfg_pulse_sequence_timer_offset_2_we1 ),
    .be1      ( int_cfg_pulse_sequence_timer_offset_2_be1 ),
    .d1       ( int_cfg_pulse_sequence_timer_offset_2_d1 ),
    .q1       ( int_cfg_pulse_sequence_timer_offset_2_q1 )
);
// int_cfg_pulse_sequence_timer_offset_3
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_cfg_pulse_sequence_timer_offset_3 (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_pulse_sequence_timer_offset_3_address0 ),
    .ce0      ( int_cfg_pulse_sequence_timer_offset_3_ce0 ),
    .we0      ( int_cfg_pulse_sequence_timer_offset_3_we0 ),
    .be0      ( int_cfg_pulse_sequence_timer_offset_3_be0 ),
    .d0       ( int_cfg_pulse_sequence_timer_offset_3_d0 ),
    .q0       ( int_cfg_pulse_sequence_timer_offset_3_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_pulse_sequence_timer_offset_3_address1 ),
    .ce1      ( int_cfg_pulse_sequence_timer_offset_3_ce1 ),
    .we1      ( int_cfg_pulse_sequence_timer_offset_3_we1 ),
    .be1      ( int_cfg_pulse_sequence_timer_offset_3_be1 ),
    .d1       ( int_cfg_pulse_sequence_timer_offset_3_d1 ),
    .q1       ( int_cfg_pulse_sequence_timer_offset_3_q1 )
);
// int_cfg_pulse_sequence_timer_offset_4
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_cfg_pulse_sequence_timer_offset_4 (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_pulse_sequence_timer_offset_4_address0 ),
    .ce0      ( int_cfg_pulse_sequence_timer_offset_4_ce0 ),
    .we0      ( int_cfg_pulse_sequence_timer_offset_4_we0 ),
    .be0      ( int_cfg_pulse_sequence_timer_offset_4_be0 ),
    .d0       ( int_cfg_pulse_sequence_timer_offset_4_d0 ),
    .q0       ( int_cfg_pulse_sequence_timer_offset_4_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_pulse_sequence_timer_offset_4_address1 ),
    .ce1      ( int_cfg_pulse_sequence_timer_offset_4_ce1 ),
    .we1      ( int_cfg_pulse_sequence_timer_offset_4_we1 ),
    .be1      ( int_cfg_pulse_sequence_timer_offset_4_be1 ),
    .d1       ( int_cfg_pulse_sequence_timer_offset_4_d1 ),
    .q1       ( int_cfg_pulse_sequence_timer_offset_4_q1 )
);
// int_cfg_pulse_sequence_timer_offset_5
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_cfg_pulse_sequence_timer_offset_5 (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_pulse_sequence_timer_offset_5_address0 ),
    .ce0      ( int_cfg_pulse_sequence_timer_offset_5_ce0 ),
    .we0      ( int_cfg_pulse_sequence_timer_offset_5_we0 ),
    .be0      ( int_cfg_pulse_sequence_timer_offset_5_be0 ),
    .d0       ( int_cfg_pulse_sequence_timer_offset_5_d0 ),
    .q0       ( int_cfg_pulse_sequence_timer_offset_5_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_pulse_sequence_timer_offset_5_address1 ),
    .ce1      ( int_cfg_pulse_sequence_timer_offset_5_ce1 ),
    .we1      ( int_cfg_pulse_sequence_timer_offset_5_we1 ),
    .be1      ( int_cfg_pulse_sequence_timer_offset_5_be1 ),
    .d1       ( int_cfg_pulse_sequence_timer_offset_5_d1 ),
    .q1       ( int_cfg_pulse_sequence_timer_offset_5_q1 )
);
// int_cfg_pulse_sequence_timer_offset_6
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_cfg_pulse_sequence_timer_offset_6 (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_pulse_sequence_timer_offset_6_address0 ),
    .ce0      ( int_cfg_pulse_sequence_timer_offset_6_ce0 ),
    .we0      ( int_cfg_pulse_sequence_timer_offset_6_we0 ),
    .be0      ( int_cfg_pulse_sequence_timer_offset_6_be0 ),
    .d0       ( int_cfg_pulse_sequence_timer_offset_6_d0 ),
    .q0       ( int_cfg_pulse_sequence_timer_offset_6_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_pulse_sequence_timer_offset_6_address1 ),
    .ce1      ( int_cfg_pulse_sequence_timer_offset_6_ce1 ),
    .we1      ( int_cfg_pulse_sequence_timer_offset_6_we1 ),
    .be1      ( int_cfg_pulse_sequence_timer_offset_6_be1 ),
    .d1       ( int_cfg_pulse_sequence_timer_offset_6_d1 ),
    .q1       ( int_cfg_pulse_sequence_timer_offset_6_q1 )
);
// int_cfg_pulse_sequence_timer_offset_7
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_cfg_pulse_sequence_timer_offset_7 (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_pulse_sequence_timer_offset_7_address0 ),
    .ce0      ( int_cfg_pulse_sequence_timer_offset_7_ce0 ),
    .we0      ( int_cfg_pulse_sequence_timer_offset_7_we0 ),
    .be0      ( int_cfg_pulse_sequence_timer_offset_7_be0 ),
    .d0       ( int_cfg_pulse_sequence_timer_offset_7_d0 ),
    .q0       ( int_cfg_pulse_sequence_timer_offset_7_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_pulse_sequence_timer_offset_7_address1 ),
    .ce1      ( int_cfg_pulse_sequence_timer_offset_7_ce1 ),
    .we1      ( int_cfg_pulse_sequence_timer_offset_7_we1 ),
    .be1      ( int_cfg_pulse_sequence_timer_offset_7_be1 ),
    .d1       ( int_cfg_pulse_sequence_timer_offset_7_d1 ),
    .q1       ( int_cfg_pulse_sequence_timer_offset_7_q1 )
);
// int_cfg_pulse_sequence_timer_width_0
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_cfg_pulse_sequence_timer_width_0 (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_pulse_sequence_timer_width_0_address0 ),
    .ce0      ( int_cfg_pulse_sequence_timer_width_0_ce0 ),
    .we0      ( int_cfg_pulse_sequence_timer_width_0_we0 ),
    .be0      ( int_cfg_pulse_sequence_timer_width_0_be0 ),
    .d0       ( int_cfg_pulse_sequence_timer_width_0_d0 ),
    .q0       ( int_cfg_pulse_sequence_timer_width_0_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_pulse_sequence_timer_width_0_address1 ),
    .ce1      ( int_cfg_pulse_sequence_timer_width_0_ce1 ),
    .we1      ( int_cfg_pulse_sequence_timer_width_0_we1 ),
    .be1      ( int_cfg_pulse_sequence_timer_width_0_be1 ),
    .d1       ( int_cfg_pulse_sequence_timer_width_0_d1 ),
    .q1       ( int_cfg_pulse_sequence_timer_width_0_q1 )
);
// int_cfg_pulse_sequence_timer_width_1
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_cfg_pulse_sequence_timer_width_1 (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_pulse_sequence_timer_width_1_address0 ),
    .ce0      ( int_cfg_pulse_sequence_timer_width_1_ce0 ),
    .we0      ( int_cfg_pulse_sequence_timer_width_1_we0 ),
    .be0      ( int_cfg_pulse_sequence_timer_width_1_be0 ),
    .d0       ( int_cfg_pulse_sequence_timer_width_1_d0 ),
    .q0       ( int_cfg_pulse_sequence_timer_width_1_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_pulse_sequence_timer_width_1_address1 ),
    .ce1      ( int_cfg_pulse_sequence_timer_width_1_ce1 ),
    .we1      ( int_cfg_pulse_sequence_timer_width_1_we1 ),
    .be1      ( int_cfg_pulse_sequence_timer_width_1_be1 ),
    .d1       ( int_cfg_pulse_sequence_timer_width_1_d1 ),
    .q1       ( int_cfg_pulse_sequence_timer_width_1_q1 )
);
// int_cfg_pulse_sequence_timer_width_2
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_cfg_pulse_sequence_timer_width_2 (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_pulse_sequence_timer_width_2_address0 ),
    .ce0      ( int_cfg_pulse_sequence_timer_width_2_ce0 ),
    .we0      ( int_cfg_pulse_sequence_timer_width_2_we0 ),
    .be0      ( int_cfg_pulse_sequence_timer_width_2_be0 ),
    .d0       ( int_cfg_pulse_sequence_timer_width_2_d0 ),
    .q0       ( int_cfg_pulse_sequence_timer_width_2_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_pulse_sequence_timer_width_2_address1 ),
    .ce1      ( int_cfg_pulse_sequence_timer_width_2_ce1 ),
    .we1      ( int_cfg_pulse_sequence_timer_width_2_we1 ),
    .be1      ( int_cfg_pulse_sequence_timer_width_2_be1 ),
    .d1       ( int_cfg_pulse_sequence_timer_width_2_d1 ),
    .q1       ( int_cfg_pulse_sequence_timer_width_2_q1 )
);
// int_cfg_pulse_sequence_timer_width_3
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_cfg_pulse_sequence_timer_width_3 (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_pulse_sequence_timer_width_3_address0 ),
    .ce0      ( int_cfg_pulse_sequence_timer_width_3_ce0 ),
    .we0      ( int_cfg_pulse_sequence_timer_width_3_we0 ),
    .be0      ( int_cfg_pulse_sequence_timer_width_3_be0 ),
    .d0       ( int_cfg_pulse_sequence_timer_width_3_d0 ),
    .q0       ( int_cfg_pulse_sequence_timer_width_3_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_pulse_sequence_timer_width_3_address1 ),
    .ce1      ( int_cfg_pulse_sequence_timer_width_3_ce1 ),
    .we1      ( int_cfg_pulse_sequence_timer_width_3_we1 ),
    .be1      ( int_cfg_pulse_sequence_timer_width_3_be1 ),
    .d1       ( int_cfg_pulse_sequence_timer_width_3_d1 ),
    .q1       ( int_cfg_pulse_sequence_timer_width_3_q1 )
);
// int_cfg_pulse_sequence_timer_width_4
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_cfg_pulse_sequence_timer_width_4 (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_pulse_sequence_timer_width_4_address0 ),
    .ce0      ( int_cfg_pulse_sequence_timer_width_4_ce0 ),
    .we0      ( int_cfg_pulse_sequence_timer_width_4_we0 ),
    .be0      ( int_cfg_pulse_sequence_timer_width_4_be0 ),
    .d0       ( int_cfg_pulse_sequence_timer_width_4_d0 ),
    .q0       ( int_cfg_pulse_sequence_timer_width_4_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_pulse_sequence_timer_width_4_address1 ),
    .ce1      ( int_cfg_pulse_sequence_timer_width_4_ce1 ),
    .we1      ( int_cfg_pulse_sequence_timer_width_4_we1 ),
    .be1      ( int_cfg_pulse_sequence_timer_width_4_be1 ),
    .d1       ( int_cfg_pulse_sequence_timer_width_4_d1 ),
    .q1       ( int_cfg_pulse_sequence_timer_width_4_q1 )
);
// int_cfg_pulse_sequence_timer_width_5
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_cfg_pulse_sequence_timer_width_5 (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_pulse_sequence_timer_width_5_address0 ),
    .ce0      ( int_cfg_pulse_sequence_timer_width_5_ce0 ),
    .we0      ( int_cfg_pulse_sequence_timer_width_5_we0 ),
    .be0      ( int_cfg_pulse_sequence_timer_width_5_be0 ),
    .d0       ( int_cfg_pulse_sequence_timer_width_5_d0 ),
    .q0       ( int_cfg_pulse_sequence_timer_width_5_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_pulse_sequence_timer_width_5_address1 ),
    .ce1      ( int_cfg_pulse_sequence_timer_width_5_ce1 ),
    .we1      ( int_cfg_pulse_sequence_timer_width_5_we1 ),
    .be1      ( int_cfg_pulse_sequence_timer_width_5_be1 ),
    .d1       ( int_cfg_pulse_sequence_timer_width_5_d1 ),
    .q1       ( int_cfg_pulse_sequence_timer_width_5_q1 )
);
// int_cfg_pulse_sequence_timer_width_6
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_cfg_pulse_sequence_timer_width_6 (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_pulse_sequence_timer_width_6_address0 ),
    .ce0      ( int_cfg_pulse_sequence_timer_width_6_ce0 ),
    .we0      ( int_cfg_pulse_sequence_timer_width_6_we0 ),
    .be0      ( int_cfg_pulse_sequence_timer_width_6_be0 ),
    .d0       ( int_cfg_pulse_sequence_timer_width_6_d0 ),
    .q0       ( int_cfg_pulse_sequence_timer_width_6_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_pulse_sequence_timer_width_6_address1 ),
    .ce1      ( int_cfg_pulse_sequence_timer_width_6_ce1 ),
    .we1      ( int_cfg_pulse_sequence_timer_width_6_we1 ),
    .be1      ( int_cfg_pulse_sequence_timer_width_6_be1 ),
    .d1       ( int_cfg_pulse_sequence_timer_width_6_d1 ),
    .q1       ( int_cfg_pulse_sequence_timer_width_6_q1 )
);
// int_cfg_pulse_sequence_timer_width_7
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 32 )
) int_cfg_pulse_sequence_timer_width_7 (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_pulse_sequence_timer_width_7_address0 ),
    .ce0      ( int_cfg_pulse_sequence_timer_width_7_ce0 ),
    .we0      ( int_cfg_pulse_sequence_timer_width_7_we0 ),
    .be0      ( int_cfg_pulse_sequence_timer_width_7_be0 ),
    .d0       ( int_cfg_pulse_sequence_timer_width_7_d0 ),
    .q0       ( int_cfg_pulse_sequence_timer_width_7_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_pulse_sequence_timer_width_7_address1 ),
    .ce1      ( int_cfg_pulse_sequence_timer_width_7_ce1 ),
    .we1      ( int_cfg_pulse_sequence_timer_width_7_we1 ),
    .be1      ( int_cfg_pulse_sequence_timer_width_7_be1 ),
    .d1       ( int_cfg_pulse_sequence_timer_width_7_d1 ),
    .q1       ( int_cfg_pulse_sequence_timer_width_7_q1 )
);
// int_cfg_filter_coefs_ch0
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 192 )
) int_cfg_filter_coefs_ch0 (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_filter_coefs_ch0_address0 ),
    .ce0      ( int_cfg_filter_coefs_ch0_ce0 ),
    .we0      ( int_cfg_filter_coefs_ch0_we0 ),
    .be0      ( int_cfg_filter_coefs_ch0_be0 ),
    .d0       ( int_cfg_filter_coefs_ch0_d0 ),
    .q0       ( int_cfg_filter_coefs_ch0_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_filter_coefs_ch0_address1 ),
    .ce1      ( int_cfg_filter_coefs_ch0_ce1 ),
    .we1      ( int_cfg_filter_coefs_ch0_we1 ),
    .be1      ( int_cfg_filter_coefs_ch0_be1 ),
    .d1       ( int_cfg_filter_coefs_ch0_d1 ),
    .q1       ( int_cfg_filter_coefs_ch0_q1 )
);
// int_cfg_filter_coefs_ch1
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 192 )
) int_cfg_filter_coefs_ch1 (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_filter_coefs_ch1_address0 ),
    .ce0      ( int_cfg_filter_coefs_ch1_ce0 ),
    .we0      ( int_cfg_filter_coefs_ch1_we0 ),
    .be0      ( int_cfg_filter_coefs_ch1_be0 ),
    .d0       ( int_cfg_filter_coefs_ch1_d0 ),
    .q0       ( int_cfg_filter_coefs_ch1_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_filter_coefs_ch1_address1 ),
    .ce1      ( int_cfg_filter_coefs_ch1_ce1 ),
    .we1      ( int_cfg_filter_coefs_ch1_we1 ),
    .be1      ( int_cfg_filter_coefs_ch1_be1 ),
    .d1       ( int_cfg_filter_coefs_ch1_d1 ),
    .q1       ( int_cfg_filter_coefs_ch1_q1 )
);
// int_cfg_filter_coefs_ch2
hcr_controller_cfg_bus_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 192 )
) int_cfg_filter_coefs_ch2 (
    .clk0     ( ACLK ),
    .address0 ( int_cfg_filter_coefs_ch2_address0 ),
    .ce0      ( int_cfg_filter_coefs_ch2_ce0 ),
    .we0      ( int_cfg_filter_coefs_ch2_we0 ),
    .be0      ( int_cfg_filter_coefs_ch2_be0 ),
    .d0       ( int_cfg_filter_coefs_ch2_d0 ),
    .q0       ( int_cfg_filter_coefs_ch2_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_cfg_filter_coefs_ch2_address1 ),
    .ce1      ( int_cfg_filter_coefs_ch2_ce1 ),
    .we1      ( int_cfg_filter_coefs_ch2_we1 ),
    .be1      ( int_cfg_filter_coefs_ch2_be1 ),
    .d1       ( int_cfg_filter_coefs_ch2_d1 ),
    .q1       ( int_cfg_filter_coefs_ch2_q1 )
);

//------------------------AXI write fsm------------------
assign AWREADY = (wstate == WRIDLE);
assign WREADY  = (wstate == WRDATA);
assign BRESP   = 2'b00;  // OKAY
assign BVALID  = (wstate == WRRESP);
assign wmask   = { {8{WSTRB[3]}}, {8{WSTRB[2]}}, {8{WSTRB[1]}}, {8{WSTRB[0]}} };
assign aw_hs   = AWVALID & AWREADY;
assign w_hs    = WVALID & WREADY;

// wstate
always @(posedge ACLK) begin
    if (ARESET)
        wstate <= WRRESET;
    else if (ACLK_EN)
        wstate <= wnext;
end

// wnext
always @(*) begin
    case (wstate)
        WRIDLE:
            if (AWVALID)
                wnext = WRDATA;
            else
                wnext = WRIDLE;
        WRDATA:
            if (WVALID)
                wnext = WRRESP;
            else
                wnext = WRDATA;
        WRRESP:
            if (BREADY)
                wnext = WRIDLE;
            else
                wnext = WRRESP;
        default:
            wnext = WRIDLE;
    endcase
end

// waddr
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (aw_hs)
            waddr <= AWADDR[ADDR_BITS-1:0];
    end
end

//------------------------AXI read fsm-------------------
assign ARREADY = (rstate == RDIDLE);
assign RDATA   = rdata;
assign RRESP   = 2'b00;  // OKAY
assign RVALID  = (rstate == RDDATA) & !int_cfg_pulse_sequence_prt_0_read & !int_cfg_pulse_sequence_prt_1_read & !int_cfg_pulse_sequence_num_pulses_read & !int_cfg_pulse_sequence_block_post_time_read & !int_cfg_pulse_sequence_control_flags_read & !int_cfg_pulse_sequence_filter_select_ch0_read & !int_cfg_pulse_sequence_filter_select_ch1_read & !int_cfg_pulse_sequence_filter_select_ch2_read & !int_cfg_pulse_sequence_timer_offset_0_read & !int_cfg_pulse_sequence_timer_offset_1_read & !int_cfg_pulse_sequence_timer_offset_2_read & !int_cfg_pulse_sequence_timer_offset_3_read & !int_cfg_pulse_sequence_timer_offset_4_read & !int_cfg_pulse_sequence_timer_offset_5_read & !int_cfg_pulse_sequence_timer_offset_6_read & !int_cfg_pulse_sequence_timer_offset_7_read & !int_cfg_pulse_sequence_timer_width_0_read & !int_cfg_pulse_sequence_timer_width_1_read & !int_cfg_pulse_sequence_timer_width_2_read & !int_cfg_pulse_sequence_timer_width_3_read & !int_cfg_pulse_sequence_timer_width_4_read & !int_cfg_pulse_sequence_timer_width_5_read & !int_cfg_pulse_sequence_timer_width_6_read & !int_cfg_pulse_sequence_timer_width_7_read & !int_cfg_filter_coefs_ch0_read & !int_cfg_filter_coefs_ch1_read & !int_cfg_filter_coefs_ch2_read;
assign ar_hs   = ARVALID & ARREADY;
assign raddr   = ARADDR[ADDR_BITS-1:0];

// rstate
always @(posedge ACLK) begin
    if (ARESET)
        rstate <= RDRESET;
    else if (ACLK_EN)
        rstate <= rnext;
end

// rnext
always @(*) begin
    case (rstate)
        RDIDLE:
            if (ARVALID)
                rnext = RDDATA;
            else
                rnext = RDIDLE;
        RDDATA:
            if (RREADY & RVALID)
                rnext = RDIDLE;
            else
                rnext = RDDATA;
        default:
            rnext = RDIDLE;
    endcase
end

// rdata
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (ar_hs) begin
            rdata <= 1'b0;
            case (raddr)
                ADDR_AP_CTRL: begin
                    rdata[0] <= int_ap_start;
                    rdata[1] <= int_ap_done;
                    rdata[2] <= int_ap_idle;
                    rdata[3] <= int_ap_ready;
                    rdata[7] <= int_auto_restart;
                end
                ADDR_GIE: begin
                    rdata <= int_gie;
                end
                ADDR_IER: begin
                    rdata <= int_ier;
                end
                ADDR_ISR: begin
                    rdata <= int_isr;
                end
                ADDR_CFG_PULSE_SEQUENCE_START_INDEX_DATA_0: begin
                    rdata <= int_cfg_pulse_sequence_start_index[7:0];
                end
                ADDR_CFG_PULSE_SEQUENCE_LENGTH_DATA_0: begin
                    rdata <= int_cfg_pulse_sequence_length[7:0];
                end
                ADDR_CFG_NUM_PULSES_TO_EXECUTE_DATA_0: begin
                    rdata <= int_cfg_num_pulses_to_execute[31:0];
                end
                ADDR_CFG_TOTAL_DECIMATION_DATA_0: begin
                    rdata <= int_cfg_total_decimation[31:0];
                end
                ADDR_CFG_POST_DECIMATION_DATA_0: begin
                    rdata <= int_cfg_post_decimation[31:0];
                end
                ADDR_CFG_NUM_PULSES_PER_XFER_DATA_0: begin
                    rdata <= int_cfg_num_pulses_per_xfer[31:0];
                end
                ADDR_CFG_ENABLED_CHANNEL_VECTOR_DATA_0: begin
                    rdata <= int_cfg_enabled_channel_vector[31:0];
                end
            endcase
        end
        else if (int_cfg_pulse_sequence_prt_0_read) begin
            rdata <= int_cfg_pulse_sequence_prt_0_q1;
        end
        else if (int_cfg_pulse_sequence_prt_1_read) begin
            rdata <= int_cfg_pulse_sequence_prt_1_q1;
        end
        else if (int_cfg_pulse_sequence_num_pulses_read) begin
            rdata <= int_cfg_pulse_sequence_num_pulses_q1;
        end
        else if (int_cfg_pulse_sequence_block_post_time_read) begin
            rdata <= int_cfg_pulse_sequence_block_post_time_q1;
        end
        else if (int_cfg_pulse_sequence_control_flags_read) begin
            rdata <= int_cfg_pulse_sequence_control_flags_q1;
        end
        else if (int_cfg_pulse_sequence_filter_select_ch0_read) begin
            rdata <= int_cfg_pulse_sequence_filter_select_ch0_q1;
        end
        else if (int_cfg_pulse_sequence_filter_select_ch1_read) begin
            rdata <= int_cfg_pulse_sequence_filter_select_ch1_q1;
        end
        else if (int_cfg_pulse_sequence_filter_select_ch2_read) begin
            rdata <= int_cfg_pulse_sequence_filter_select_ch2_q1;
        end
        else if (int_cfg_pulse_sequence_timer_offset_0_read) begin
            rdata <= int_cfg_pulse_sequence_timer_offset_0_q1;
        end
        else if (int_cfg_pulse_sequence_timer_offset_1_read) begin
            rdata <= int_cfg_pulse_sequence_timer_offset_1_q1;
        end
        else if (int_cfg_pulse_sequence_timer_offset_2_read) begin
            rdata <= int_cfg_pulse_sequence_timer_offset_2_q1;
        end
        else if (int_cfg_pulse_sequence_timer_offset_3_read) begin
            rdata <= int_cfg_pulse_sequence_timer_offset_3_q1;
        end
        else if (int_cfg_pulse_sequence_timer_offset_4_read) begin
            rdata <= int_cfg_pulse_sequence_timer_offset_4_q1;
        end
        else if (int_cfg_pulse_sequence_timer_offset_5_read) begin
            rdata <= int_cfg_pulse_sequence_timer_offset_5_q1;
        end
        else if (int_cfg_pulse_sequence_timer_offset_6_read) begin
            rdata <= int_cfg_pulse_sequence_timer_offset_6_q1;
        end
        else if (int_cfg_pulse_sequence_timer_offset_7_read) begin
            rdata <= int_cfg_pulse_sequence_timer_offset_7_q1;
        end
        else if (int_cfg_pulse_sequence_timer_width_0_read) begin
            rdata <= int_cfg_pulse_sequence_timer_width_0_q1;
        end
        else if (int_cfg_pulse_sequence_timer_width_1_read) begin
            rdata <= int_cfg_pulse_sequence_timer_width_1_q1;
        end
        else if (int_cfg_pulse_sequence_timer_width_2_read) begin
            rdata <= int_cfg_pulse_sequence_timer_width_2_q1;
        end
        else if (int_cfg_pulse_sequence_timer_width_3_read) begin
            rdata <= int_cfg_pulse_sequence_timer_width_3_q1;
        end
        else if (int_cfg_pulse_sequence_timer_width_4_read) begin
            rdata <= int_cfg_pulse_sequence_timer_width_4_q1;
        end
        else if (int_cfg_pulse_sequence_timer_width_5_read) begin
            rdata <= int_cfg_pulse_sequence_timer_width_5_q1;
        end
        else if (int_cfg_pulse_sequence_timer_width_6_read) begin
            rdata <= int_cfg_pulse_sequence_timer_width_6_q1;
        end
        else if (int_cfg_pulse_sequence_timer_width_7_read) begin
            rdata <= int_cfg_pulse_sequence_timer_width_7_q1;
        end
        else if (int_cfg_filter_coefs_ch0_read) begin
            rdata <= int_cfg_filter_coefs_ch0_q1;
        end
        else if (int_cfg_filter_coefs_ch1_read) begin
            rdata <= int_cfg_filter_coefs_ch1_q1;
        end
        else if (int_cfg_filter_coefs_ch2_read) begin
            rdata <= int_cfg_filter_coefs_ch2_q1;
        end
    end
end


//------------------------Register logic-----------------
assign interrupt                      = int_gie & (|int_isr);
assign ap_start                       = int_ap_start;
assign cfg_pulse_sequence_start_index = int_cfg_pulse_sequence_start_index;
assign cfg_pulse_sequence_length      = int_cfg_pulse_sequence_length;
assign cfg_num_pulses_to_execute      = int_cfg_num_pulses_to_execute;
assign cfg_total_decimation           = int_cfg_total_decimation;
assign cfg_post_decimation            = int_cfg_post_decimation;
assign cfg_num_pulses_per_xfer        = int_cfg_num_pulses_per_xfer;
assign cfg_enabled_channel_vector     = int_cfg_enabled_channel_vector;
// int_ap_start
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_start <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_AP_CTRL && WSTRB[0] && WDATA[0])
            int_ap_start <= 1'b1;
        else if (ap_ready)
            int_ap_start <= int_auto_restart; // clear on handshake/auto restart
    end
end

// int_ap_done
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_done <= 1'b0;
    else if (ACLK_EN) begin
        if (ap_done)
            int_ap_done <= 1'b1;
        else if (ar_hs && raddr == ADDR_AP_CTRL)
            int_ap_done <= 1'b0; // clear on read
    end
end

// int_ap_idle
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_idle <= 1'b0;
    else if (ACLK_EN) begin
            int_ap_idle <= ap_idle;
    end
end

// int_ap_ready
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_ready <= 1'b0;
    else if (ACLK_EN) begin
            int_ap_ready <= ap_ready;
    end
end

// int_auto_restart
always @(posedge ACLK) begin
    if (ARESET)
        int_auto_restart <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_AP_CTRL && WSTRB[0])
            int_auto_restart <=  WDATA[7];
    end
end

// int_gie
always @(posedge ACLK) begin
    if (ARESET)
        int_gie <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_GIE && WSTRB[0])
            int_gie <= WDATA[0];
    end
end

// int_ier
always @(posedge ACLK) begin
    if (ARESET)
        int_ier <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_IER && WSTRB[0])
            int_ier <= WDATA[1:0];
    end
end

// int_isr[0]
always @(posedge ACLK) begin
    if (ARESET)
        int_isr[0] <= 1'b0;
    else if (ACLK_EN) begin
        if (int_ier[0] & ap_done)
            int_isr[0] <= 1'b1;
        else if (w_hs && waddr == ADDR_ISR && WSTRB[0])
            int_isr[0] <= int_isr[0] ^ WDATA[0]; // toggle on write
    end
end

// int_isr[1]
always @(posedge ACLK) begin
    if (ARESET)
        int_isr[1] <= 1'b0;
    else if (ACLK_EN) begin
        if (int_ier[1] & ap_ready)
            int_isr[1] <= 1'b1;
        else if (w_hs && waddr == ADDR_ISR && WSTRB[0])
            int_isr[1] <= int_isr[1] ^ WDATA[1]; // toggle on write
    end
end

// int_cfg_pulse_sequence_start_index[7:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_start_index[7:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CFG_PULSE_SEQUENCE_START_INDEX_DATA_0)
            int_cfg_pulse_sequence_start_index[7:0] <= (WDATA[31:0] & wmask) | (int_cfg_pulse_sequence_start_index[7:0] & ~wmask);
    end
end

// int_cfg_pulse_sequence_length[7:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_length[7:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CFG_PULSE_SEQUENCE_LENGTH_DATA_0)
            int_cfg_pulse_sequence_length[7:0] <= (WDATA[31:0] & wmask) | (int_cfg_pulse_sequence_length[7:0] & ~wmask);
    end
end

// int_cfg_num_pulses_to_execute[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_num_pulses_to_execute[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CFG_NUM_PULSES_TO_EXECUTE_DATA_0)
            int_cfg_num_pulses_to_execute[31:0] <= (WDATA[31:0] & wmask) | (int_cfg_num_pulses_to_execute[31:0] & ~wmask);
    end
end

// int_cfg_total_decimation[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_total_decimation[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CFG_TOTAL_DECIMATION_DATA_0)
            int_cfg_total_decimation[31:0] <= (WDATA[31:0] & wmask) | (int_cfg_total_decimation[31:0] & ~wmask);
    end
end

// int_cfg_post_decimation[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_post_decimation[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CFG_POST_DECIMATION_DATA_0)
            int_cfg_post_decimation[31:0] <= (WDATA[31:0] & wmask) | (int_cfg_post_decimation[31:0] & ~wmask);
    end
end

// int_cfg_num_pulses_per_xfer[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_num_pulses_per_xfer[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CFG_NUM_PULSES_PER_XFER_DATA_0)
            int_cfg_num_pulses_per_xfer[31:0] <= (WDATA[31:0] & wmask) | (int_cfg_num_pulses_per_xfer[31:0] & ~wmask);
    end
end

// int_cfg_enabled_channel_vector[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_enabled_channel_vector[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_CFG_ENABLED_CHANNEL_VECTOR_DATA_0)
            int_cfg_enabled_channel_vector[31:0] <= (WDATA[31:0] & wmask) | (int_cfg_enabled_channel_vector[31:0] & ~wmask);
    end
end


//------------------------Memory logic-------------------
// cfg_pulse_sequence_prt_0
assign int_cfg_pulse_sequence_prt_0_address0             = cfg_pulse_sequence_prt_0_address0;
assign int_cfg_pulse_sequence_prt_0_ce0                  = cfg_pulse_sequence_prt_0_ce0;
assign int_cfg_pulse_sequence_prt_0_we0                  = 1'b0;
assign int_cfg_pulse_sequence_prt_0_be0                  = 1'b0;
assign int_cfg_pulse_sequence_prt_0_d0                   = 1'b0;
assign cfg_pulse_sequence_prt_0_q0                       = int_cfg_pulse_sequence_prt_0_q0;
assign int_cfg_pulse_sequence_prt_0_address1             = ar_hs? raddr[6:2] : waddr[6:2];
assign int_cfg_pulse_sequence_prt_0_ce1                  = ar_hs | (int_cfg_pulse_sequence_prt_0_write & WVALID);
assign int_cfg_pulse_sequence_prt_0_we1                  = int_cfg_pulse_sequence_prt_0_write & WVALID;
assign int_cfg_pulse_sequence_prt_0_be1                  = WSTRB;
assign int_cfg_pulse_sequence_prt_0_d1                   = WDATA;
// cfg_pulse_sequence_prt_1
assign int_cfg_pulse_sequence_prt_1_address0             = cfg_pulse_sequence_prt_1_address0;
assign int_cfg_pulse_sequence_prt_1_ce0                  = cfg_pulse_sequence_prt_1_ce0;
assign int_cfg_pulse_sequence_prt_1_we0                  = 1'b0;
assign int_cfg_pulse_sequence_prt_1_be0                  = 1'b0;
assign int_cfg_pulse_sequence_prt_1_d0                   = 1'b0;
assign cfg_pulse_sequence_prt_1_q0                       = int_cfg_pulse_sequence_prt_1_q0;
assign int_cfg_pulse_sequence_prt_1_address1             = ar_hs? raddr[6:2] : waddr[6:2];
assign int_cfg_pulse_sequence_prt_1_ce1                  = ar_hs | (int_cfg_pulse_sequence_prt_1_write & WVALID);
assign int_cfg_pulse_sequence_prt_1_we1                  = int_cfg_pulse_sequence_prt_1_write & WVALID;
assign int_cfg_pulse_sequence_prt_1_be1                  = WSTRB;
assign int_cfg_pulse_sequence_prt_1_d1                   = WDATA;
// cfg_pulse_sequence_num_pulses
assign int_cfg_pulse_sequence_num_pulses_address0        = cfg_pulse_sequence_num_pulses_address0;
assign int_cfg_pulse_sequence_num_pulses_ce0             = cfg_pulse_sequence_num_pulses_ce0;
assign int_cfg_pulse_sequence_num_pulses_we0             = 1'b0;
assign int_cfg_pulse_sequence_num_pulses_be0             = 1'b0;
assign int_cfg_pulse_sequence_num_pulses_d0              = 1'b0;
assign cfg_pulse_sequence_num_pulses_q0                  = int_cfg_pulse_sequence_num_pulses_q0;
assign int_cfg_pulse_sequence_num_pulses_address1        = ar_hs? raddr[6:2] : waddr[6:2];
assign int_cfg_pulse_sequence_num_pulses_ce1             = ar_hs | (int_cfg_pulse_sequence_num_pulses_write & WVALID);
assign int_cfg_pulse_sequence_num_pulses_we1             = int_cfg_pulse_sequence_num_pulses_write & WVALID;
assign int_cfg_pulse_sequence_num_pulses_be1             = WSTRB;
assign int_cfg_pulse_sequence_num_pulses_d1              = WDATA;
// cfg_pulse_sequence_block_post_time
assign int_cfg_pulse_sequence_block_post_time_address0   = cfg_pulse_sequence_block_post_time_address0;
assign int_cfg_pulse_sequence_block_post_time_ce0        = cfg_pulse_sequence_block_post_time_ce0;
assign int_cfg_pulse_sequence_block_post_time_we0        = 1'b0;
assign int_cfg_pulse_sequence_block_post_time_be0        = 1'b0;
assign int_cfg_pulse_sequence_block_post_time_d0         = 1'b0;
assign cfg_pulse_sequence_block_post_time_q0             = int_cfg_pulse_sequence_block_post_time_q0;
assign int_cfg_pulse_sequence_block_post_time_address1   = ar_hs? raddr[6:2] : waddr[6:2];
assign int_cfg_pulse_sequence_block_post_time_ce1        = ar_hs | (int_cfg_pulse_sequence_block_post_time_write & WVALID);
assign int_cfg_pulse_sequence_block_post_time_we1        = int_cfg_pulse_sequence_block_post_time_write & WVALID;
assign int_cfg_pulse_sequence_block_post_time_be1        = WSTRB;
assign int_cfg_pulse_sequence_block_post_time_d1         = WDATA;
// cfg_pulse_sequence_control_flags
assign int_cfg_pulse_sequence_control_flags_address0     = cfg_pulse_sequence_control_flags_address0;
assign int_cfg_pulse_sequence_control_flags_ce0          = cfg_pulse_sequence_control_flags_ce0;
assign int_cfg_pulse_sequence_control_flags_we0          = 1'b0;
assign int_cfg_pulse_sequence_control_flags_be0          = 1'b0;
assign int_cfg_pulse_sequence_control_flags_d0           = 1'b0;
assign cfg_pulse_sequence_control_flags_q0               = int_cfg_pulse_sequence_control_flags_q0;
assign int_cfg_pulse_sequence_control_flags_address1     = ar_hs? raddr[6:2] : waddr[6:2];
assign int_cfg_pulse_sequence_control_flags_ce1          = ar_hs | (int_cfg_pulse_sequence_control_flags_write & WVALID);
assign int_cfg_pulse_sequence_control_flags_we1          = int_cfg_pulse_sequence_control_flags_write & WVALID;
assign int_cfg_pulse_sequence_control_flags_be1          = WSTRB;
assign int_cfg_pulse_sequence_control_flags_d1           = WDATA;
// cfg_pulse_sequence_filter_select_ch0
assign int_cfg_pulse_sequence_filter_select_ch0_address0 = cfg_pulse_sequence_filter_select_ch0_address0;
assign int_cfg_pulse_sequence_filter_select_ch0_ce0      = cfg_pulse_sequence_filter_select_ch0_ce0;
assign int_cfg_pulse_sequence_filter_select_ch0_we0      = 1'b0;
assign int_cfg_pulse_sequence_filter_select_ch0_be0      = 1'b0;
assign int_cfg_pulse_sequence_filter_select_ch0_d0       = 1'b0;
assign cfg_pulse_sequence_filter_select_ch0_q0           = int_cfg_pulse_sequence_filter_select_ch0_q0;
assign int_cfg_pulse_sequence_filter_select_ch0_address1 = ar_hs? raddr[6:2] : waddr[6:2];
assign int_cfg_pulse_sequence_filter_select_ch0_ce1      = ar_hs | (int_cfg_pulse_sequence_filter_select_ch0_write & WVALID);
assign int_cfg_pulse_sequence_filter_select_ch0_we1      = int_cfg_pulse_sequence_filter_select_ch0_write & WVALID;
assign int_cfg_pulse_sequence_filter_select_ch0_be1      = WSTRB;
assign int_cfg_pulse_sequence_filter_select_ch0_d1       = WDATA;
// cfg_pulse_sequence_filter_select_ch1
assign int_cfg_pulse_sequence_filter_select_ch1_address0 = cfg_pulse_sequence_filter_select_ch1_address0;
assign int_cfg_pulse_sequence_filter_select_ch1_ce0      = cfg_pulse_sequence_filter_select_ch1_ce0;
assign int_cfg_pulse_sequence_filter_select_ch1_we0      = 1'b0;
assign int_cfg_pulse_sequence_filter_select_ch1_be0      = 1'b0;
assign int_cfg_pulse_sequence_filter_select_ch1_d0       = 1'b0;
assign cfg_pulse_sequence_filter_select_ch1_q0           = int_cfg_pulse_sequence_filter_select_ch1_q0;
assign int_cfg_pulse_sequence_filter_select_ch1_address1 = ar_hs? raddr[6:2] : waddr[6:2];
assign int_cfg_pulse_sequence_filter_select_ch1_ce1      = ar_hs | (int_cfg_pulse_sequence_filter_select_ch1_write & WVALID);
assign int_cfg_pulse_sequence_filter_select_ch1_we1      = int_cfg_pulse_sequence_filter_select_ch1_write & WVALID;
assign int_cfg_pulse_sequence_filter_select_ch1_be1      = WSTRB;
assign int_cfg_pulse_sequence_filter_select_ch1_d1       = WDATA;
// cfg_pulse_sequence_filter_select_ch2
assign int_cfg_pulse_sequence_filter_select_ch2_address0 = cfg_pulse_sequence_filter_select_ch2_address0;
assign int_cfg_pulse_sequence_filter_select_ch2_ce0      = cfg_pulse_sequence_filter_select_ch2_ce0;
assign int_cfg_pulse_sequence_filter_select_ch2_we0      = 1'b0;
assign int_cfg_pulse_sequence_filter_select_ch2_be0      = 1'b0;
assign int_cfg_pulse_sequence_filter_select_ch2_d0       = 1'b0;
assign cfg_pulse_sequence_filter_select_ch2_q0           = int_cfg_pulse_sequence_filter_select_ch2_q0;
assign int_cfg_pulse_sequence_filter_select_ch2_address1 = ar_hs? raddr[6:2] : waddr[6:2];
assign int_cfg_pulse_sequence_filter_select_ch2_ce1      = ar_hs | (int_cfg_pulse_sequence_filter_select_ch2_write & WVALID);
assign int_cfg_pulse_sequence_filter_select_ch2_we1      = int_cfg_pulse_sequence_filter_select_ch2_write & WVALID;
assign int_cfg_pulse_sequence_filter_select_ch2_be1      = WSTRB;
assign int_cfg_pulse_sequence_filter_select_ch2_d1       = WDATA;
// cfg_pulse_sequence_timer_offset_0
assign int_cfg_pulse_sequence_timer_offset_0_address0    = cfg_pulse_sequence_timer_offset_0_address0;
assign int_cfg_pulse_sequence_timer_offset_0_ce0         = cfg_pulse_sequence_timer_offset_0_ce0;
assign int_cfg_pulse_sequence_timer_offset_0_we0         = 1'b0;
assign int_cfg_pulse_sequence_timer_offset_0_be0         = 1'b0;
assign int_cfg_pulse_sequence_timer_offset_0_d0          = 1'b0;
assign cfg_pulse_sequence_timer_offset_0_q0              = int_cfg_pulse_sequence_timer_offset_0_q0;
assign int_cfg_pulse_sequence_timer_offset_0_address1    = ar_hs? raddr[6:2] : waddr[6:2];
assign int_cfg_pulse_sequence_timer_offset_0_ce1         = ar_hs | (int_cfg_pulse_sequence_timer_offset_0_write & WVALID);
assign int_cfg_pulse_sequence_timer_offset_0_we1         = int_cfg_pulse_sequence_timer_offset_0_write & WVALID;
assign int_cfg_pulse_sequence_timer_offset_0_be1         = WSTRB;
assign int_cfg_pulse_sequence_timer_offset_0_d1          = WDATA;
// cfg_pulse_sequence_timer_offset_1
assign int_cfg_pulse_sequence_timer_offset_1_address0    = cfg_pulse_sequence_timer_offset_1_address0;
assign int_cfg_pulse_sequence_timer_offset_1_ce0         = cfg_pulse_sequence_timer_offset_1_ce0;
assign int_cfg_pulse_sequence_timer_offset_1_we0         = 1'b0;
assign int_cfg_pulse_sequence_timer_offset_1_be0         = 1'b0;
assign int_cfg_pulse_sequence_timer_offset_1_d0          = 1'b0;
assign cfg_pulse_sequence_timer_offset_1_q0              = int_cfg_pulse_sequence_timer_offset_1_q0;
assign int_cfg_pulse_sequence_timer_offset_1_address1    = ar_hs? raddr[6:2] : waddr[6:2];
assign int_cfg_pulse_sequence_timer_offset_1_ce1         = ar_hs | (int_cfg_pulse_sequence_timer_offset_1_write & WVALID);
assign int_cfg_pulse_sequence_timer_offset_1_we1         = int_cfg_pulse_sequence_timer_offset_1_write & WVALID;
assign int_cfg_pulse_sequence_timer_offset_1_be1         = WSTRB;
assign int_cfg_pulse_sequence_timer_offset_1_d1          = WDATA;
// cfg_pulse_sequence_timer_offset_2
assign int_cfg_pulse_sequence_timer_offset_2_address0    = cfg_pulse_sequence_timer_offset_2_address0;
assign int_cfg_pulse_sequence_timer_offset_2_ce0         = cfg_pulse_sequence_timer_offset_2_ce0;
assign int_cfg_pulse_sequence_timer_offset_2_we0         = 1'b0;
assign int_cfg_pulse_sequence_timer_offset_2_be0         = 1'b0;
assign int_cfg_pulse_sequence_timer_offset_2_d0          = 1'b0;
assign cfg_pulse_sequence_timer_offset_2_q0              = int_cfg_pulse_sequence_timer_offset_2_q0;
assign int_cfg_pulse_sequence_timer_offset_2_address1    = ar_hs? raddr[6:2] : waddr[6:2];
assign int_cfg_pulse_sequence_timer_offset_2_ce1         = ar_hs | (int_cfg_pulse_sequence_timer_offset_2_write & WVALID);
assign int_cfg_pulse_sequence_timer_offset_2_we1         = int_cfg_pulse_sequence_timer_offset_2_write & WVALID;
assign int_cfg_pulse_sequence_timer_offset_2_be1         = WSTRB;
assign int_cfg_pulse_sequence_timer_offset_2_d1          = WDATA;
// cfg_pulse_sequence_timer_offset_3
assign int_cfg_pulse_sequence_timer_offset_3_address0    = cfg_pulse_sequence_timer_offset_3_address0;
assign int_cfg_pulse_sequence_timer_offset_3_ce0         = cfg_pulse_sequence_timer_offset_3_ce0;
assign int_cfg_pulse_sequence_timer_offset_3_we0         = 1'b0;
assign int_cfg_pulse_sequence_timer_offset_3_be0         = 1'b0;
assign int_cfg_pulse_sequence_timer_offset_3_d0          = 1'b0;
assign cfg_pulse_sequence_timer_offset_3_q0              = int_cfg_pulse_sequence_timer_offset_3_q0;
assign int_cfg_pulse_sequence_timer_offset_3_address1    = ar_hs? raddr[6:2] : waddr[6:2];
assign int_cfg_pulse_sequence_timer_offset_3_ce1         = ar_hs | (int_cfg_pulse_sequence_timer_offset_3_write & WVALID);
assign int_cfg_pulse_sequence_timer_offset_3_we1         = int_cfg_pulse_sequence_timer_offset_3_write & WVALID;
assign int_cfg_pulse_sequence_timer_offset_3_be1         = WSTRB;
assign int_cfg_pulse_sequence_timer_offset_3_d1          = WDATA;
// cfg_pulse_sequence_timer_offset_4
assign int_cfg_pulse_sequence_timer_offset_4_address0    = cfg_pulse_sequence_timer_offset_4_address0;
assign int_cfg_pulse_sequence_timer_offset_4_ce0         = cfg_pulse_sequence_timer_offset_4_ce0;
assign int_cfg_pulse_sequence_timer_offset_4_we0         = 1'b0;
assign int_cfg_pulse_sequence_timer_offset_4_be0         = 1'b0;
assign int_cfg_pulse_sequence_timer_offset_4_d0          = 1'b0;
assign cfg_pulse_sequence_timer_offset_4_q0              = int_cfg_pulse_sequence_timer_offset_4_q0;
assign int_cfg_pulse_sequence_timer_offset_4_address1    = ar_hs? raddr[6:2] : waddr[6:2];
assign int_cfg_pulse_sequence_timer_offset_4_ce1         = ar_hs | (int_cfg_pulse_sequence_timer_offset_4_write & WVALID);
assign int_cfg_pulse_sequence_timer_offset_4_we1         = int_cfg_pulse_sequence_timer_offset_4_write & WVALID;
assign int_cfg_pulse_sequence_timer_offset_4_be1         = WSTRB;
assign int_cfg_pulse_sequence_timer_offset_4_d1          = WDATA;
// cfg_pulse_sequence_timer_offset_5
assign int_cfg_pulse_sequence_timer_offset_5_address0    = cfg_pulse_sequence_timer_offset_5_address0;
assign int_cfg_pulse_sequence_timer_offset_5_ce0         = cfg_pulse_sequence_timer_offset_5_ce0;
assign int_cfg_pulse_sequence_timer_offset_5_we0         = 1'b0;
assign int_cfg_pulse_sequence_timer_offset_5_be0         = 1'b0;
assign int_cfg_pulse_sequence_timer_offset_5_d0          = 1'b0;
assign cfg_pulse_sequence_timer_offset_5_q0              = int_cfg_pulse_sequence_timer_offset_5_q0;
assign int_cfg_pulse_sequence_timer_offset_5_address1    = ar_hs? raddr[6:2] : waddr[6:2];
assign int_cfg_pulse_sequence_timer_offset_5_ce1         = ar_hs | (int_cfg_pulse_sequence_timer_offset_5_write & WVALID);
assign int_cfg_pulse_sequence_timer_offset_5_we1         = int_cfg_pulse_sequence_timer_offset_5_write & WVALID;
assign int_cfg_pulse_sequence_timer_offset_5_be1         = WSTRB;
assign int_cfg_pulse_sequence_timer_offset_5_d1          = WDATA;
// cfg_pulse_sequence_timer_offset_6
assign int_cfg_pulse_sequence_timer_offset_6_address0    = cfg_pulse_sequence_timer_offset_6_address0;
assign int_cfg_pulse_sequence_timer_offset_6_ce0         = cfg_pulse_sequence_timer_offset_6_ce0;
assign int_cfg_pulse_sequence_timer_offset_6_we0         = 1'b0;
assign int_cfg_pulse_sequence_timer_offset_6_be0         = 1'b0;
assign int_cfg_pulse_sequence_timer_offset_6_d0          = 1'b0;
assign cfg_pulse_sequence_timer_offset_6_q0              = int_cfg_pulse_sequence_timer_offset_6_q0;
assign int_cfg_pulse_sequence_timer_offset_6_address1    = ar_hs? raddr[6:2] : waddr[6:2];
assign int_cfg_pulse_sequence_timer_offset_6_ce1         = ar_hs | (int_cfg_pulse_sequence_timer_offset_6_write & WVALID);
assign int_cfg_pulse_sequence_timer_offset_6_we1         = int_cfg_pulse_sequence_timer_offset_6_write & WVALID;
assign int_cfg_pulse_sequence_timer_offset_6_be1         = WSTRB;
assign int_cfg_pulse_sequence_timer_offset_6_d1          = WDATA;
// cfg_pulse_sequence_timer_offset_7
assign int_cfg_pulse_sequence_timer_offset_7_address0    = cfg_pulse_sequence_timer_offset_7_address0;
assign int_cfg_pulse_sequence_timer_offset_7_ce0         = cfg_pulse_sequence_timer_offset_7_ce0;
assign int_cfg_pulse_sequence_timer_offset_7_we0         = 1'b0;
assign int_cfg_pulse_sequence_timer_offset_7_be0         = 1'b0;
assign int_cfg_pulse_sequence_timer_offset_7_d0          = 1'b0;
assign cfg_pulse_sequence_timer_offset_7_q0              = int_cfg_pulse_sequence_timer_offset_7_q0;
assign int_cfg_pulse_sequence_timer_offset_7_address1    = ar_hs? raddr[6:2] : waddr[6:2];
assign int_cfg_pulse_sequence_timer_offset_7_ce1         = ar_hs | (int_cfg_pulse_sequence_timer_offset_7_write & WVALID);
assign int_cfg_pulse_sequence_timer_offset_7_we1         = int_cfg_pulse_sequence_timer_offset_7_write & WVALID;
assign int_cfg_pulse_sequence_timer_offset_7_be1         = WSTRB;
assign int_cfg_pulse_sequence_timer_offset_7_d1          = WDATA;
// cfg_pulse_sequence_timer_width_0
assign int_cfg_pulse_sequence_timer_width_0_address0     = cfg_pulse_sequence_timer_width_0_address0;
assign int_cfg_pulse_sequence_timer_width_0_ce0          = cfg_pulse_sequence_timer_width_0_ce0;
assign int_cfg_pulse_sequence_timer_width_0_we0          = 1'b0;
assign int_cfg_pulse_sequence_timer_width_0_be0          = 1'b0;
assign int_cfg_pulse_sequence_timer_width_0_d0           = 1'b0;
assign cfg_pulse_sequence_timer_width_0_q0               = int_cfg_pulse_sequence_timer_width_0_q0;
assign int_cfg_pulse_sequence_timer_width_0_address1     = ar_hs? raddr[6:2] : waddr[6:2];
assign int_cfg_pulse_sequence_timer_width_0_ce1          = ar_hs | (int_cfg_pulse_sequence_timer_width_0_write & WVALID);
assign int_cfg_pulse_sequence_timer_width_0_we1          = int_cfg_pulse_sequence_timer_width_0_write & WVALID;
assign int_cfg_pulse_sequence_timer_width_0_be1          = WSTRB;
assign int_cfg_pulse_sequence_timer_width_0_d1           = WDATA;
// cfg_pulse_sequence_timer_width_1
assign int_cfg_pulse_sequence_timer_width_1_address0     = cfg_pulse_sequence_timer_width_1_address0;
assign int_cfg_pulse_sequence_timer_width_1_ce0          = cfg_pulse_sequence_timer_width_1_ce0;
assign int_cfg_pulse_sequence_timer_width_1_we0          = 1'b0;
assign int_cfg_pulse_sequence_timer_width_1_be0          = 1'b0;
assign int_cfg_pulse_sequence_timer_width_1_d0           = 1'b0;
assign cfg_pulse_sequence_timer_width_1_q0               = int_cfg_pulse_sequence_timer_width_1_q0;
assign int_cfg_pulse_sequence_timer_width_1_address1     = ar_hs? raddr[6:2] : waddr[6:2];
assign int_cfg_pulse_sequence_timer_width_1_ce1          = ar_hs | (int_cfg_pulse_sequence_timer_width_1_write & WVALID);
assign int_cfg_pulse_sequence_timer_width_1_we1          = int_cfg_pulse_sequence_timer_width_1_write & WVALID;
assign int_cfg_pulse_sequence_timer_width_1_be1          = WSTRB;
assign int_cfg_pulse_sequence_timer_width_1_d1           = WDATA;
// cfg_pulse_sequence_timer_width_2
assign int_cfg_pulse_sequence_timer_width_2_address0     = cfg_pulse_sequence_timer_width_2_address0;
assign int_cfg_pulse_sequence_timer_width_2_ce0          = cfg_pulse_sequence_timer_width_2_ce0;
assign int_cfg_pulse_sequence_timer_width_2_we0          = 1'b0;
assign int_cfg_pulse_sequence_timer_width_2_be0          = 1'b0;
assign int_cfg_pulse_sequence_timer_width_2_d0           = 1'b0;
assign cfg_pulse_sequence_timer_width_2_q0               = int_cfg_pulse_sequence_timer_width_2_q0;
assign int_cfg_pulse_sequence_timer_width_2_address1     = ar_hs? raddr[6:2] : waddr[6:2];
assign int_cfg_pulse_sequence_timer_width_2_ce1          = ar_hs | (int_cfg_pulse_sequence_timer_width_2_write & WVALID);
assign int_cfg_pulse_sequence_timer_width_2_we1          = int_cfg_pulse_sequence_timer_width_2_write & WVALID;
assign int_cfg_pulse_sequence_timer_width_2_be1          = WSTRB;
assign int_cfg_pulse_sequence_timer_width_2_d1           = WDATA;
// cfg_pulse_sequence_timer_width_3
assign int_cfg_pulse_sequence_timer_width_3_address0     = cfg_pulse_sequence_timer_width_3_address0;
assign int_cfg_pulse_sequence_timer_width_3_ce0          = cfg_pulse_sequence_timer_width_3_ce0;
assign int_cfg_pulse_sequence_timer_width_3_we0          = 1'b0;
assign int_cfg_pulse_sequence_timer_width_3_be0          = 1'b0;
assign int_cfg_pulse_sequence_timer_width_3_d0           = 1'b0;
assign cfg_pulse_sequence_timer_width_3_q0               = int_cfg_pulse_sequence_timer_width_3_q0;
assign int_cfg_pulse_sequence_timer_width_3_address1     = ar_hs? raddr[6:2] : waddr[6:2];
assign int_cfg_pulse_sequence_timer_width_3_ce1          = ar_hs | (int_cfg_pulse_sequence_timer_width_3_write & WVALID);
assign int_cfg_pulse_sequence_timer_width_3_we1          = int_cfg_pulse_sequence_timer_width_3_write & WVALID;
assign int_cfg_pulse_sequence_timer_width_3_be1          = WSTRB;
assign int_cfg_pulse_sequence_timer_width_3_d1           = WDATA;
// cfg_pulse_sequence_timer_width_4
assign int_cfg_pulse_sequence_timer_width_4_address0     = cfg_pulse_sequence_timer_width_4_address0;
assign int_cfg_pulse_sequence_timer_width_4_ce0          = cfg_pulse_sequence_timer_width_4_ce0;
assign int_cfg_pulse_sequence_timer_width_4_we0          = 1'b0;
assign int_cfg_pulse_sequence_timer_width_4_be0          = 1'b0;
assign int_cfg_pulse_sequence_timer_width_4_d0           = 1'b0;
assign cfg_pulse_sequence_timer_width_4_q0               = int_cfg_pulse_sequence_timer_width_4_q0;
assign int_cfg_pulse_sequence_timer_width_4_address1     = ar_hs? raddr[6:2] : waddr[6:2];
assign int_cfg_pulse_sequence_timer_width_4_ce1          = ar_hs | (int_cfg_pulse_sequence_timer_width_4_write & WVALID);
assign int_cfg_pulse_sequence_timer_width_4_we1          = int_cfg_pulse_sequence_timer_width_4_write & WVALID;
assign int_cfg_pulse_sequence_timer_width_4_be1          = WSTRB;
assign int_cfg_pulse_sequence_timer_width_4_d1           = WDATA;
// cfg_pulse_sequence_timer_width_5
assign int_cfg_pulse_sequence_timer_width_5_address0     = cfg_pulse_sequence_timer_width_5_address0;
assign int_cfg_pulse_sequence_timer_width_5_ce0          = cfg_pulse_sequence_timer_width_5_ce0;
assign int_cfg_pulse_sequence_timer_width_5_we0          = 1'b0;
assign int_cfg_pulse_sequence_timer_width_5_be0          = 1'b0;
assign int_cfg_pulse_sequence_timer_width_5_d0           = 1'b0;
assign cfg_pulse_sequence_timer_width_5_q0               = int_cfg_pulse_sequence_timer_width_5_q0;
assign int_cfg_pulse_sequence_timer_width_5_address1     = ar_hs? raddr[6:2] : waddr[6:2];
assign int_cfg_pulse_sequence_timer_width_5_ce1          = ar_hs | (int_cfg_pulse_sequence_timer_width_5_write & WVALID);
assign int_cfg_pulse_sequence_timer_width_5_we1          = int_cfg_pulse_sequence_timer_width_5_write & WVALID;
assign int_cfg_pulse_sequence_timer_width_5_be1          = WSTRB;
assign int_cfg_pulse_sequence_timer_width_5_d1           = WDATA;
// cfg_pulse_sequence_timer_width_6
assign int_cfg_pulse_sequence_timer_width_6_address0     = cfg_pulse_sequence_timer_width_6_address0;
assign int_cfg_pulse_sequence_timer_width_6_ce0          = cfg_pulse_sequence_timer_width_6_ce0;
assign int_cfg_pulse_sequence_timer_width_6_we0          = 1'b0;
assign int_cfg_pulse_sequence_timer_width_6_be0          = 1'b0;
assign int_cfg_pulse_sequence_timer_width_6_d0           = 1'b0;
assign cfg_pulse_sequence_timer_width_6_q0               = int_cfg_pulse_sequence_timer_width_6_q0;
assign int_cfg_pulse_sequence_timer_width_6_address1     = ar_hs? raddr[6:2] : waddr[6:2];
assign int_cfg_pulse_sequence_timer_width_6_ce1          = ar_hs | (int_cfg_pulse_sequence_timer_width_6_write & WVALID);
assign int_cfg_pulse_sequence_timer_width_6_we1          = int_cfg_pulse_sequence_timer_width_6_write & WVALID;
assign int_cfg_pulse_sequence_timer_width_6_be1          = WSTRB;
assign int_cfg_pulse_sequence_timer_width_6_d1           = WDATA;
// cfg_pulse_sequence_timer_width_7
assign int_cfg_pulse_sequence_timer_width_7_address0     = cfg_pulse_sequence_timer_width_7_address0;
assign int_cfg_pulse_sequence_timer_width_7_ce0          = cfg_pulse_sequence_timer_width_7_ce0;
assign int_cfg_pulse_sequence_timer_width_7_we0          = 1'b0;
assign int_cfg_pulse_sequence_timer_width_7_be0          = 1'b0;
assign int_cfg_pulse_sequence_timer_width_7_d0           = 1'b0;
assign cfg_pulse_sequence_timer_width_7_q0               = int_cfg_pulse_sequence_timer_width_7_q0;
assign int_cfg_pulse_sequence_timer_width_7_address1     = ar_hs? raddr[6:2] : waddr[6:2];
assign int_cfg_pulse_sequence_timer_width_7_ce1          = ar_hs | (int_cfg_pulse_sequence_timer_width_7_write & WVALID);
assign int_cfg_pulse_sequence_timer_width_7_we1          = int_cfg_pulse_sequence_timer_width_7_write & WVALID;
assign int_cfg_pulse_sequence_timer_width_7_be1          = WSTRB;
assign int_cfg_pulse_sequence_timer_width_7_d1           = WDATA;
// cfg_filter_coefs_ch0
assign int_cfg_filter_coefs_ch0_address0                 = cfg_filter_coefs_ch0_address0;
assign int_cfg_filter_coefs_ch0_ce0                      = cfg_filter_coefs_ch0_ce0;
assign int_cfg_filter_coefs_ch0_we0                      = 1'b0;
assign int_cfg_filter_coefs_ch0_be0                      = 1'b0;
assign int_cfg_filter_coefs_ch0_d0                       = 1'b0;
assign cfg_filter_coefs_ch0_q0                           = int_cfg_filter_coefs_ch0_q0;
assign int_cfg_filter_coefs_ch0_address1                 = ar_hs? raddr[9:2] : waddr[9:2];
assign int_cfg_filter_coefs_ch0_ce1                      = ar_hs | (int_cfg_filter_coefs_ch0_write & WVALID);
assign int_cfg_filter_coefs_ch0_we1                      = int_cfg_filter_coefs_ch0_write & WVALID;
assign int_cfg_filter_coefs_ch0_be1                      = WSTRB;
assign int_cfg_filter_coefs_ch0_d1                       = WDATA;
// cfg_filter_coefs_ch1
assign int_cfg_filter_coefs_ch1_address0                 = cfg_filter_coefs_ch1_address0;
assign int_cfg_filter_coefs_ch1_ce0                      = cfg_filter_coefs_ch1_ce0;
assign int_cfg_filter_coefs_ch1_we0                      = 1'b0;
assign int_cfg_filter_coefs_ch1_be0                      = 1'b0;
assign int_cfg_filter_coefs_ch1_d0                       = 1'b0;
assign cfg_filter_coefs_ch1_q0                           = int_cfg_filter_coefs_ch1_q0;
assign int_cfg_filter_coefs_ch1_address1                 = ar_hs? raddr[9:2] : waddr[9:2];
assign int_cfg_filter_coefs_ch1_ce1                      = ar_hs | (int_cfg_filter_coefs_ch1_write & WVALID);
assign int_cfg_filter_coefs_ch1_we1                      = int_cfg_filter_coefs_ch1_write & WVALID;
assign int_cfg_filter_coefs_ch1_be1                      = WSTRB;
assign int_cfg_filter_coefs_ch1_d1                       = WDATA;
// cfg_filter_coefs_ch2
assign int_cfg_filter_coefs_ch2_address0                 = cfg_filter_coefs_ch2_address0;
assign int_cfg_filter_coefs_ch2_ce0                      = cfg_filter_coefs_ch2_ce0;
assign int_cfg_filter_coefs_ch2_we0                      = 1'b0;
assign int_cfg_filter_coefs_ch2_be0                      = 1'b0;
assign int_cfg_filter_coefs_ch2_d0                       = 1'b0;
assign cfg_filter_coefs_ch2_q0                           = int_cfg_filter_coefs_ch2_q0;
assign int_cfg_filter_coefs_ch2_address1                 = ar_hs? raddr[9:2] : waddr[9:2];
assign int_cfg_filter_coefs_ch2_ce1                      = ar_hs | (int_cfg_filter_coefs_ch2_write & WVALID);
assign int_cfg_filter_coefs_ch2_we1                      = int_cfg_filter_coefs_ch2_write & WVALID;
assign int_cfg_filter_coefs_ch2_be1                      = WSTRB;
assign int_cfg_filter_coefs_ch2_d1                       = WDATA;
// int_cfg_pulse_sequence_prt_0_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_prt_0_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_PULSE_SEQUENCE_PRT_0_BASE && raddr <= ADDR_CFG_PULSE_SEQUENCE_PRT_0_HIGH)
            int_cfg_pulse_sequence_prt_0_read <= 1'b1;
        else
            int_cfg_pulse_sequence_prt_0_read <= 1'b0;
    end
end

// int_cfg_pulse_sequence_prt_0_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_prt_0_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_PULSE_SEQUENCE_PRT_0_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_PULSE_SEQUENCE_PRT_0_HIGH)
            int_cfg_pulse_sequence_prt_0_write <= 1'b1;
        else if (WVALID)
            int_cfg_pulse_sequence_prt_0_write <= 1'b0;
    end
end

// int_cfg_pulse_sequence_prt_1_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_prt_1_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_PULSE_SEQUENCE_PRT_1_BASE && raddr <= ADDR_CFG_PULSE_SEQUENCE_PRT_1_HIGH)
            int_cfg_pulse_sequence_prt_1_read <= 1'b1;
        else
            int_cfg_pulse_sequence_prt_1_read <= 1'b0;
    end
end

// int_cfg_pulse_sequence_prt_1_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_prt_1_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_PULSE_SEQUENCE_PRT_1_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_PULSE_SEQUENCE_PRT_1_HIGH)
            int_cfg_pulse_sequence_prt_1_write <= 1'b1;
        else if (WVALID)
            int_cfg_pulse_sequence_prt_1_write <= 1'b0;
    end
end

// int_cfg_pulse_sequence_num_pulses_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_num_pulses_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_BASE && raddr <= ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_HIGH)
            int_cfg_pulse_sequence_num_pulses_read <= 1'b1;
        else
            int_cfg_pulse_sequence_num_pulses_read <= 1'b0;
    end
end

// int_cfg_pulse_sequence_num_pulses_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_num_pulses_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_HIGH)
            int_cfg_pulse_sequence_num_pulses_write <= 1'b1;
        else if (WVALID)
            int_cfg_pulse_sequence_num_pulses_write <= 1'b0;
    end
end

// int_cfg_pulse_sequence_block_post_time_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_block_post_time_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_BASE && raddr <= ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_HIGH)
            int_cfg_pulse_sequence_block_post_time_read <= 1'b1;
        else
            int_cfg_pulse_sequence_block_post_time_read <= 1'b0;
    end
end

// int_cfg_pulse_sequence_block_post_time_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_block_post_time_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_HIGH)
            int_cfg_pulse_sequence_block_post_time_write <= 1'b1;
        else if (WVALID)
            int_cfg_pulse_sequence_block_post_time_write <= 1'b0;
    end
end

// int_cfg_pulse_sequence_control_flags_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_control_flags_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_BASE && raddr <= ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_HIGH)
            int_cfg_pulse_sequence_control_flags_read <= 1'b1;
        else
            int_cfg_pulse_sequence_control_flags_read <= 1'b0;
    end
end

// int_cfg_pulse_sequence_control_flags_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_control_flags_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_HIGH)
            int_cfg_pulse_sequence_control_flags_write <= 1'b1;
        else if (WVALID)
            int_cfg_pulse_sequence_control_flags_write <= 1'b0;
    end
end

// int_cfg_pulse_sequence_filter_select_ch0_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_filter_select_ch0_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_BASE && raddr <= ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_HIGH)
            int_cfg_pulse_sequence_filter_select_ch0_read <= 1'b1;
        else
            int_cfg_pulse_sequence_filter_select_ch0_read <= 1'b0;
    end
end

// int_cfg_pulse_sequence_filter_select_ch0_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_filter_select_ch0_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_HIGH)
            int_cfg_pulse_sequence_filter_select_ch0_write <= 1'b1;
        else if (WVALID)
            int_cfg_pulse_sequence_filter_select_ch0_write <= 1'b0;
    end
end

// int_cfg_pulse_sequence_filter_select_ch1_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_filter_select_ch1_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_BASE && raddr <= ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_HIGH)
            int_cfg_pulse_sequence_filter_select_ch1_read <= 1'b1;
        else
            int_cfg_pulse_sequence_filter_select_ch1_read <= 1'b0;
    end
end

// int_cfg_pulse_sequence_filter_select_ch1_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_filter_select_ch1_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_HIGH)
            int_cfg_pulse_sequence_filter_select_ch1_write <= 1'b1;
        else if (WVALID)
            int_cfg_pulse_sequence_filter_select_ch1_write <= 1'b0;
    end
end

// int_cfg_pulse_sequence_filter_select_ch2_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_filter_select_ch2_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_BASE && raddr <= ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_HIGH)
            int_cfg_pulse_sequence_filter_select_ch2_read <= 1'b1;
        else
            int_cfg_pulse_sequence_filter_select_ch2_read <= 1'b0;
    end
end

// int_cfg_pulse_sequence_filter_select_ch2_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_filter_select_ch2_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_HIGH)
            int_cfg_pulse_sequence_filter_select_ch2_write <= 1'b1;
        else if (WVALID)
            int_cfg_pulse_sequence_filter_select_ch2_write <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_offset_0_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_offset_0_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_BASE && raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_HIGH)
            int_cfg_pulse_sequence_timer_offset_0_read <= 1'b1;
        else
            int_cfg_pulse_sequence_timer_offset_0_read <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_offset_0_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_offset_0_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_HIGH)
            int_cfg_pulse_sequence_timer_offset_0_write <= 1'b1;
        else if (WVALID)
            int_cfg_pulse_sequence_timer_offset_0_write <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_offset_1_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_offset_1_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_BASE && raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_HIGH)
            int_cfg_pulse_sequence_timer_offset_1_read <= 1'b1;
        else
            int_cfg_pulse_sequence_timer_offset_1_read <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_offset_1_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_offset_1_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_HIGH)
            int_cfg_pulse_sequence_timer_offset_1_write <= 1'b1;
        else if (WVALID)
            int_cfg_pulse_sequence_timer_offset_1_write <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_offset_2_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_offset_2_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_BASE && raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_HIGH)
            int_cfg_pulse_sequence_timer_offset_2_read <= 1'b1;
        else
            int_cfg_pulse_sequence_timer_offset_2_read <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_offset_2_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_offset_2_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_HIGH)
            int_cfg_pulse_sequence_timer_offset_2_write <= 1'b1;
        else if (WVALID)
            int_cfg_pulse_sequence_timer_offset_2_write <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_offset_3_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_offset_3_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_BASE && raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_HIGH)
            int_cfg_pulse_sequence_timer_offset_3_read <= 1'b1;
        else
            int_cfg_pulse_sequence_timer_offset_3_read <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_offset_3_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_offset_3_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_HIGH)
            int_cfg_pulse_sequence_timer_offset_3_write <= 1'b1;
        else if (WVALID)
            int_cfg_pulse_sequence_timer_offset_3_write <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_offset_4_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_offset_4_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_BASE && raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_HIGH)
            int_cfg_pulse_sequence_timer_offset_4_read <= 1'b1;
        else
            int_cfg_pulse_sequence_timer_offset_4_read <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_offset_4_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_offset_4_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_HIGH)
            int_cfg_pulse_sequence_timer_offset_4_write <= 1'b1;
        else if (WVALID)
            int_cfg_pulse_sequence_timer_offset_4_write <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_offset_5_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_offset_5_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_BASE && raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_HIGH)
            int_cfg_pulse_sequence_timer_offset_5_read <= 1'b1;
        else
            int_cfg_pulse_sequence_timer_offset_5_read <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_offset_5_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_offset_5_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_HIGH)
            int_cfg_pulse_sequence_timer_offset_5_write <= 1'b1;
        else if (WVALID)
            int_cfg_pulse_sequence_timer_offset_5_write <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_offset_6_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_offset_6_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_BASE && raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_HIGH)
            int_cfg_pulse_sequence_timer_offset_6_read <= 1'b1;
        else
            int_cfg_pulse_sequence_timer_offset_6_read <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_offset_6_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_offset_6_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_HIGH)
            int_cfg_pulse_sequence_timer_offset_6_write <= 1'b1;
        else if (WVALID)
            int_cfg_pulse_sequence_timer_offset_6_write <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_offset_7_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_offset_7_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_BASE && raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_HIGH)
            int_cfg_pulse_sequence_timer_offset_7_read <= 1'b1;
        else
            int_cfg_pulse_sequence_timer_offset_7_read <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_offset_7_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_offset_7_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_HIGH)
            int_cfg_pulse_sequence_timer_offset_7_write <= 1'b1;
        else if (WVALID)
            int_cfg_pulse_sequence_timer_offset_7_write <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_width_0_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_width_0_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_BASE && raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_HIGH)
            int_cfg_pulse_sequence_timer_width_0_read <= 1'b1;
        else
            int_cfg_pulse_sequence_timer_width_0_read <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_width_0_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_width_0_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_HIGH)
            int_cfg_pulse_sequence_timer_width_0_write <= 1'b1;
        else if (WVALID)
            int_cfg_pulse_sequence_timer_width_0_write <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_width_1_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_width_1_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_BASE && raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_HIGH)
            int_cfg_pulse_sequence_timer_width_1_read <= 1'b1;
        else
            int_cfg_pulse_sequence_timer_width_1_read <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_width_1_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_width_1_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_HIGH)
            int_cfg_pulse_sequence_timer_width_1_write <= 1'b1;
        else if (WVALID)
            int_cfg_pulse_sequence_timer_width_1_write <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_width_2_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_width_2_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_BASE && raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_HIGH)
            int_cfg_pulse_sequence_timer_width_2_read <= 1'b1;
        else
            int_cfg_pulse_sequence_timer_width_2_read <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_width_2_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_width_2_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_HIGH)
            int_cfg_pulse_sequence_timer_width_2_write <= 1'b1;
        else if (WVALID)
            int_cfg_pulse_sequence_timer_width_2_write <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_width_3_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_width_3_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_BASE && raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_HIGH)
            int_cfg_pulse_sequence_timer_width_3_read <= 1'b1;
        else
            int_cfg_pulse_sequence_timer_width_3_read <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_width_3_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_width_3_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_HIGH)
            int_cfg_pulse_sequence_timer_width_3_write <= 1'b1;
        else if (WVALID)
            int_cfg_pulse_sequence_timer_width_3_write <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_width_4_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_width_4_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_BASE && raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_HIGH)
            int_cfg_pulse_sequence_timer_width_4_read <= 1'b1;
        else
            int_cfg_pulse_sequence_timer_width_4_read <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_width_4_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_width_4_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_HIGH)
            int_cfg_pulse_sequence_timer_width_4_write <= 1'b1;
        else if (WVALID)
            int_cfg_pulse_sequence_timer_width_4_write <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_width_5_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_width_5_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_BASE && raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_HIGH)
            int_cfg_pulse_sequence_timer_width_5_read <= 1'b1;
        else
            int_cfg_pulse_sequence_timer_width_5_read <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_width_5_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_width_5_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_HIGH)
            int_cfg_pulse_sequence_timer_width_5_write <= 1'b1;
        else if (WVALID)
            int_cfg_pulse_sequence_timer_width_5_write <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_width_6_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_width_6_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_BASE && raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_HIGH)
            int_cfg_pulse_sequence_timer_width_6_read <= 1'b1;
        else
            int_cfg_pulse_sequence_timer_width_6_read <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_width_6_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_width_6_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_HIGH)
            int_cfg_pulse_sequence_timer_width_6_write <= 1'b1;
        else if (WVALID)
            int_cfg_pulse_sequence_timer_width_6_write <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_width_7_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_width_7_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_BASE && raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_HIGH)
            int_cfg_pulse_sequence_timer_width_7_read <= 1'b1;
        else
            int_cfg_pulse_sequence_timer_width_7_read <= 1'b0;
    end
end

// int_cfg_pulse_sequence_timer_width_7_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_pulse_sequence_timer_width_7_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_HIGH)
            int_cfg_pulse_sequence_timer_width_7_write <= 1'b1;
        else if (WVALID)
            int_cfg_pulse_sequence_timer_width_7_write <= 1'b0;
    end
end

// int_cfg_filter_coefs_ch0_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_filter_coefs_ch0_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_FILTER_COEFS_CH0_BASE && raddr <= ADDR_CFG_FILTER_COEFS_CH0_HIGH)
            int_cfg_filter_coefs_ch0_read <= 1'b1;
        else
            int_cfg_filter_coefs_ch0_read <= 1'b0;
    end
end

// int_cfg_filter_coefs_ch0_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_filter_coefs_ch0_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_FILTER_COEFS_CH0_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_FILTER_COEFS_CH0_HIGH)
            int_cfg_filter_coefs_ch0_write <= 1'b1;
        else if (WVALID)
            int_cfg_filter_coefs_ch0_write <= 1'b0;
    end
end

// int_cfg_filter_coefs_ch1_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_filter_coefs_ch1_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_FILTER_COEFS_CH1_BASE && raddr <= ADDR_CFG_FILTER_COEFS_CH1_HIGH)
            int_cfg_filter_coefs_ch1_read <= 1'b1;
        else
            int_cfg_filter_coefs_ch1_read <= 1'b0;
    end
end

// int_cfg_filter_coefs_ch1_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_filter_coefs_ch1_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_FILTER_COEFS_CH1_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_FILTER_COEFS_CH1_HIGH)
            int_cfg_filter_coefs_ch1_write <= 1'b1;
        else if (WVALID)
            int_cfg_filter_coefs_ch1_write <= 1'b0;
    end
end

// int_cfg_filter_coefs_ch2_read
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_filter_coefs_ch2_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_CFG_FILTER_COEFS_CH2_BASE && raddr <= ADDR_CFG_FILTER_COEFS_CH2_HIGH)
            int_cfg_filter_coefs_ch2_read <= 1'b1;
        else
            int_cfg_filter_coefs_ch2_read <= 1'b0;
    end
end

// int_cfg_filter_coefs_ch2_write
always @(posedge ACLK) begin
    if (ARESET)
        int_cfg_filter_coefs_ch2_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_CFG_FILTER_COEFS_CH2_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_CFG_FILTER_COEFS_CH2_HIGH)
            int_cfg_filter_coefs_ch2_write <= 1'b1;
        else if (WVALID)
            int_cfg_filter_coefs_ch2_write <= 1'b0;
    end
end


endmodule


`timescale 1ns/1ps

module hcr_controller_cfg_bus_s_axi_ram
#(parameter
    BYTES  = 4,
    DEPTH  = 256,
    AWIDTH = log2(DEPTH)
) (
    input  wire               clk0,
    input  wire [AWIDTH-1:0]  address0,
    input  wire               ce0,
    input  wire               we0,
    input  wire [BYTES-1:0]   be0,
    input  wire [BYTES*8-1:0] d0,
    output reg  [BYTES*8-1:0] q0,
    input  wire               clk1,
    input  wire [AWIDTH-1:0]  address1,
    input  wire               ce1,
    input  wire               we1,
    input  wire [BYTES-1:0]   be1,
    input  wire [BYTES*8-1:0] d1,
    output reg  [BYTES*8-1:0] q1
);
//------------------------Local signal-------------------
reg  [BYTES*8-1:0] mem[0:DEPTH-1];
//------------------------Task and function--------------
function integer log2;
    input integer x;
    integer n, m;
begin
    n = 1;
    m = 2;
    while (m < x) begin
        n = n + 1;
        m = m * 2;
    end
    log2 = n;
end
endfunction
//------------------------Body---------------------------
// read port 0
always @(posedge clk0) begin
    if (ce0) q0 <= mem[address0];
end

// read port 1
always @(posedge clk1) begin
    if (ce1) q1 <= mem[address1];
end

genvar i;
generate
    for (i = 0; i < BYTES; i = i + 1) begin : gen_write
        // write port 0
        always @(posedge clk0) begin
            if (ce0 & we0 & be0[i]) begin
                mem[address0][8*i+7:8*i] <= d0[8*i+7:8*i];
            end
        end
        // write port 1
        always @(posedge clk1) begin
            if (ce1 & we1 & be1[i]) begin
                mem[address1][8*i+7:8*i] <= d1[8*i+7:8*i];
            end
        end
    end
endgenerate

endmodule

