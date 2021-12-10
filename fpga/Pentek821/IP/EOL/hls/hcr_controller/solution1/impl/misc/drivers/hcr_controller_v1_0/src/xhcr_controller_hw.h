// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
// cfg_bus
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
// 0x0010 : Data signal of cfg_pulse_sequence_start_stop_indexes
//          bit 31~0 - cfg_pulse_sequence_start_stop_indexes[31:0] (Read/Write)
// 0x0014 : reserved
// 0x0018 : Data signal of cfg_num_pulses_to_execute
//          bit 31~0 - cfg_num_pulses_to_execute[31:0] (Read/Write)
// 0x001c : reserved
// 0x0020 : Data signal of cfg_total_decimation
//          bit 31~0 - cfg_total_decimation[31:0] (Read/Write)
// 0x0024 : reserved
// 0x0028 : Data signal of cfg_post_decimation
//          bit 31~0 - cfg_post_decimation[31:0] (Read/Write)
// 0x002c : reserved
// 0x0030 : Data signal of cfg_num_pulses_per_xfer
//          bit 31~0 - cfg_num_pulses_per_xfer[31:0] (Read/Write)
// 0x0034 : reserved
// 0x0038 : Data signal of cfg_enabled_channel_vector
//          bit 31~0 - cfg_enabled_channel_vector[31:0] (Read/Write)
// 0x003c : reserved
// 0x0040 : Data signal of cfg_watchdog
//          bit 31~0 - cfg_watchdog[31:0] (Read/Write)
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
// 0x037f : Memory 'cfg_pulse_sequence_polarization_mode' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_polarization_mode[n]
// 0x0380 ~
// 0x03ff : Memory 'cfg_pulse_sequence_filter_select_ch0' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_filter_select_ch0[n]
// 0x0400 ~
// 0x047f : Memory 'cfg_pulse_sequence_filter_select_ch1' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_filter_select_ch1[n]
// 0x0480 ~
// 0x04ff : Memory 'cfg_pulse_sequence_filter_select_ch2' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_filter_select_ch2[n]
// 0x0500 ~
// 0x057f : Memory 'cfg_pulse_sequence_timer_offset_0' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_0[n]
// 0x0580 ~
// 0x05ff : Memory 'cfg_pulse_sequence_timer_offset_1' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_1[n]
// 0x0600 ~
// 0x067f : Memory 'cfg_pulse_sequence_timer_offset_2' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_2[n]
// 0x0680 ~
// 0x06ff : Memory 'cfg_pulse_sequence_timer_offset_3' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_3[n]
// 0x0700 ~
// 0x077f : Memory 'cfg_pulse_sequence_timer_offset_4' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_4[n]
// 0x0780 ~
// 0x07ff : Memory 'cfg_pulse_sequence_timer_offset_5' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_5[n]
// 0x0800 ~
// 0x087f : Memory 'cfg_pulse_sequence_timer_offset_6' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_6[n]
// 0x0880 ~
// 0x08ff : Memory 'cfg_pulse_sequence_timer_offset_7' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_7[n]
// 0x0900 ~
// 0x097f : Memory 'cfg_pulse_sequence_timer_width_0' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_width_0[n]
// 0x0980 ~
// 0x09ff : Memory 'cfg_pulse_sequence_timer_width_1' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_width_1[n]
// 0x0a00 ~
// 0x0a7f : Memory 'cfg_pulse_sequence_timer_width_2' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_width_2[n]
// 0x0a80 ~
// 0x0aff : Memory 'cfg_pulse_sequence_timer_width_3' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_width_3[n]
// 0x0b00 ~
// 0x0b7f : Memory 'cfg_pulse_sequence_timer_width_4' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_width_4[n]
// 0x0b80 ~
// 0x0bff : Memory 'cfg_pulse_sequence_timer_width_5' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_width_5[n]
// 0x0c00 ~
// 0x0c7f : Memory 'cfg_pulse_sequence_timer_width_6' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_width_6[n]
// 0x0c80 ~
// 0x0cff : Memory 'cfg_pulse_sequence_timer_width_7' (32 * 32b)
//          Word n : bit [31:0] - cfg_pulse_sequence_timer_width_7[n]
// 0x1000 ~
// 0x17ff : Memory 'cfg_filter_coefs_ch0' (384 * 32b)
//          Word n : bit [31:0] - cfg_filter_coefs_ch0[n]
// 0x1800 ~
// 0x1fff : Memory 'cfg_filter_coefs_ch1' (384 * 32b)
//          Word n : bit [31:0] - cfg_filter_coefs_ch1[n]
// 0x2000 ~
// 0x27ff : Memory 'cfg_filter_coefs_ch2' (384 * 32b)
//          Word n : bit [31:0] - cfg_filter_coefs_ch2[n]
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XHCR_CONTROLLER_CFG_BUS_ADDR_AP_CTRL                                    0x0000
#define XHCR_CONTROLLER_CFG_BUS_ADDR_GIE                                        0x0004
#define XHCR_CONTROLLER_CFG_BUS_ADDR_IER                                        0x0008
#define XHCR_CONTROLLER_CFG_BUS_ADDR_ISR                                        0x000c
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_START_STOP_INDEXES_DATA 0x0010
#define XHCR_CONTROLLER_CFG_BUS_BITS_CFG_PULSE_SEQUENCE_START_STOP_INDEXES_DATA 32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_NUM_PULSES_TO_EXECUTE_DATA             0x0018
#define XHCR_CONTROLLER_CFG_BUS_BITS_CFG_NUM_PULSES_TO_EXECUTE_DATA             32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_TOTAL_DECIMATION_DATA                  0x0020
#define XHCR_CONTROLLER_CFG_BUS_BITS_CFG_TOTAL_DECIMATION_DATA                  32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_POST_DECIMATION_DATA                   0x0028
#define XHCR_CONTROLLER_CFG_BUS_BITS_CFG_POST_DECIMATION_DATA                   32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_NUM_PULSES_PER_XFER_DATA               0x0030
#define XHCR_CONTROLLER_CFG_BUS_BITS_CFG_NUM_PULSES_PER_XFER_DATA               32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_ENABLED_CHANNEL_VECTOR_DATA            0x0038
#define XHCR_CONTROLLER_CFG_BUS_BITS_CFG_ENABLED_CHANNEL_VECTOR_DATA            32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_WATCHDOG_DATA                          0x0040
#define XHCR_CONTROLLER_CFG_BUS_BITS_CFG_WATCHDOG_DATA                          32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_0_BASE              0x0080
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_0_HIGH              0x00ff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_PRT_0                  32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_PRT_0                  32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_1_BASE              0x0100
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_1_HIGH              0x017f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_PRT_1                  32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_PRT_1                  32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_BASE         0x0180
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_HIGH         0x01ff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_NUM_PULSES             32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_NUM_PULSES             32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_BASE    0x0200
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_HIGH    0x027f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME        32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME        32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_BASE      0x0280
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_HIGH      0x02ff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_CONTROL_FLAGS          32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_CONTROL_FLAGS          32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_BASE  0x0300
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_HIGH  0x037f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_POLARIZATION_MODE      32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_POLARIZATION_MODE      32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_BASE  0x0380
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_HIGH  0x03ff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0      32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0      32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_BASE  0x0400
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_HIGH  0x047f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1      32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1      32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_BASE  0x0480
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_HIGH  0x04ff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2      32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2      32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_BASE     0x0500
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_HIGH     0x057f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0         32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0         32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_BASE     0x0580
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_HIGH     0x05ff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1         32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1         32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_BASE     0x0600
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_HIGH     0x067f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2         32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2         32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_BASE     0x0680
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_HIGH     0x06ff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3         32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3         32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_BASE     0x0700
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_HIGH     0x077f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4         32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4         32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_BASE     0x0780
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_HIGH     0x07ff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5         32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5         32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_BASE     0x0800
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_HIGH     0x087f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6         32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6         32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_BASE     0x0880
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_HIGH     0x08ff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7         32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7         32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_BASE      0x0900
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_HIGH      0x097f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0          32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0          32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_BASE      0x0980
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_HIGH      0x09ff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1          32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1          32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_BASE      0x0a00
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_HIGH      0x0a7f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2          32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2          32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_BASE      0x0a80
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_HIGH      0x0aff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3          32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3          32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_BASE      0x0b00
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_HIGH      0x0b7f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4          32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4          32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_BASE      0x0b80
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_HIGH      0x0bff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5          32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5          32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_BASE      0x0c00
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_HIGH      0x0c7f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6          32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6          32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_BASE      0x0c80
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_HIGH      0x0cff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7          32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7          32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH0_BASE                  0x1000
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH0_HIGH                  0x17ff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_FILTER_COEFS_CH0                      32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_FILTER_COEFS_CH0                      384
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH1_BASE                  0x1800
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH1_HIGH                  0x1fff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_FILTER_COEFS_CH1                      32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_FILTER_COEFS_CH1                      384
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH2_BASE                  0x2000
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH2_HIGH                  0x27ff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_FILTER_COEFS_CH2                      32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_FILTER_COEFS_CH2                      384

