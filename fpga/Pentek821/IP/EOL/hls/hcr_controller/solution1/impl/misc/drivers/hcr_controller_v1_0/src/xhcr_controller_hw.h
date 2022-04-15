// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
// cfg_bus
// 0x00000 : Control signals
//           bit 0  - ap_start (Read/Write/COH)
//           bit 1  - ap_done (Read/COR)
//           bit 2  - ap_idle (Read)
//           bit 3  - ap_ready (Read)
//           bit 7  - auto_restart (Read/Write)
//           others - reserved
// 0x00004 : Global Interrupt Enable Register
//           bit 0  - Global Interrupt Enable (Read/Write)
//           others - reserved
// 0x00008 : IP Interrupt Enable Register (Read/Write)
//           bit 0  - Channel 0 (ap_done)
//           bit 1  - Channel 1 (ap_ready)
//           others - reserved
// 0x0000c : IP Interrupt Status Register (Read/TOW)
//           bit 0  - Channel 0 (ap_done)
//           bit 1  - Channel 1 (ap_ready)
//           others - reserved
// 0x00010 : Data signal of cfg_pulse_sequence_start_stop_indexes
//           bit 31~0 - cfg_pulse_sequence_start_stop_indexes[31:0] (Read/Write)
// 0x00014 : reserved
// 0x00018 : Data signal of cfg_num_pulses_to_execute
//           bit 31~0 - cfg_num_pulses_to_execute[31:0] (Read/Write)
// 0x0001c : reserved
// 0x00020 : Data signal of cfg_total_decimation
//           bit 31~0 - cfg_total_decimation[31:0] (Read/Write)
// 0x00024 : reserved
// 0x00028 : Data signal of cfg_post_decimation
//           bit 31~0 - cfg_post_decimation[31:0] (Read/Write)
// 0x0002c : reserved
// 0x00030 : Data signal of cfg_num_pulses_per_xfer
//           bit 31~0 - cfg_num_pulses_per_xfer[31:0] (Read/Write)
// 0x00034 : reserved
// 0x00038 : Data signal of cfg_enabled_channel_vector
//           bit 31~0 - cfg_enabled_channel_vector[31:0] (Read/Write)
// 0x0003c : reserved
// 0x00040 : Data signal of cfg_watchdog
//           bit 31~0 - cfg_watchdog[31:0] (Read/Write)
// 0x00044 : reserved
// 0x00080 ~
// 0x000ff : Memory 'cfg_pulse_sequence_prt_0' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_prt_0[n]
// 0x00100 ~
// 0x0017f : Memory 'cfg_pulse_sequence_prt_1' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_prt_1[n]
// 0x00180 ~
// 0x001ff : Memory 'cfg_pulse_sequence_num_pulses' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_num_pulses[n]
// 0x00200 ~
// 0x0027f : Memory 'cfg_pulse_sequence_block_post_time' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_block_post_time[n]
// 0x00280 ~
// 0x002ff : Memory 'cfg_pulse_sequence_control_flags' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_control_flags[n]
// 0x00300 ~
// 0x0037f : Memory 'cfg_pulse_sequence_polarization_mode' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_polarization_mode[n]
// 0x00380 ~
// 0x003ff : Memory 'cfg_pulse_sequence_filter_select_ch0' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_filter_select_ch0[n]
// 0x00400 ~
// 0x0047f : Memory 'cfg_pulse_sequence_filter_select_ch1' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_filter_select_ch1[n]
// 0x00480 ~
// 0x004ff : Memory 'cfg_pulse_sequence_filter_select_ch2' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_filter_select_ch2[n]
// 0x00500 ~
// 0x0057f : Memory 'cfg_pulse_sequence_phase_table_begin' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_phase_table_begin[n]
// 0x00580 ~
// 0x005ff : Memory 'cfg_pulse_sequence_phase_table_end' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_phase_table_end[n]
// 0x00600 ~
// 0x0067f : Memory 'cfg_pulse_sequence_timer_offset_0' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_0[n]
// 0x00680 ~
// 0x006ff : Memory 'cfg_pulse_sequence_timer_offset_1' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_1[n]
// 0x00700 ~
// 0x0077f : Memory 'cfg_pulse_sequence_timer_offset_2' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_2[n]
// 0x00780 ~
// 0x007ff : Memory 'cfg_pulse_sequence_timer_offset_3' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_3[n]
// 0x00800 ~
// 0x0087f : Memory 'cfg_pulse_sequence_timer_offset_4' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_4[n]
// 0x00880 ~
// 0x008ff : Memory 'cfg_pulse_sequence_timer_offset_5' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_5[n]
// 0x00900 ~
// 0x0097f : Memory 'cfg_pulse_sequence_timer_offset_6' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_6[n]
// 0x00980 ~
// 0x009ff : Memory 'cfg_pulse_sequence_timer_offset_7' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_7[n]
// 0x00a00 ~
// 0x00a7f : Memory 'cfg_pulse_sequence_timer_width_0' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_timer_width_0[n]
// 0x00a80 ~
// 0x00aff : Memory 'cfg_pulse_sequence_timer_width_1' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_timer_width_1[n]
// 0x00b00 ~
// 0x00b7f : Memory 'cfg_pulse_sequence_timer_width_2' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_timer_width_2[n]
// 0x00b80 ~
// 0x00bff : Memory 'cfg_pulse_sequence_timer_width_3' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_timer_width_3[n]
// 0x00c00 ~
// 0x00c7f : Memory 'cfg_pulse_sequence_timer_width_4' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_timer_width_4[n]
// 0x00c80 ~
// 0x00cff : Memory 'cfg_pulse_sequence_timer_width_5' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_timer_width_5[n]
// 0x00d00 ~
// 0x00d7f : Memory 'cfg_pulse_sequence_timer_width_6' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_timer_width_6[n]
// 0x00d80 ~
// 0x00dff : Memory 'cfg_pulse_sequence_timer_width_7' (32 * 32b)
//           Word n : bit [31:0] - cfg_pulse_sequence_timer_width_7[n]
// 0x01000 ~
// 0x017ff : Memory 'cfg_filter_coefs_ch0' (384 * 32b)
//           Word n : bit [31:0] - cfg_filter_coefs_ch0[n]
// 0x01800 ~
// 0x01fff : Memory 'cfg_filter_coefs_ch1' (384 * 32b)
//           Word n : bit [31:0] - cfg_filter_coefs_ch1[n]
// 0x02000 ~
// 0x027ff : Memory 'cfg_filter_coefs_ch2' (384 * 32b)
//           Word n : bit [31:0] - cfg_filter_coefs_ch2[n]
// 0x40000 ~
// 0x7ffff : Memory 'cfg_phase_samples' (65536 * 32b)
//           Word n : bit [31:0] - cfg_phase_samples[n]
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XHCR_CONTROLLER_CFG_BUS_ADDR_AP_CTRL                                    0x00000
#define XHCR_CONTROLLER_CFG_BUS_ADDR_GIE                                        0x00004
#define XHCR_CONTROLLER_CFG_BUS_ADDR_IER                                        0x00008
#define XHCR_CONTROLLER_CFG_BUS_ADDR_ISR                                        0x0000c
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_START_STOP_INDEXES_DATA 0x00010
#define XHCR_CONTROLLER_CFG_BUS_BITS_CFG_PULSE_SEQUENCE_START_STOP_INDEXES_DATA 32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_NUM_PULSES_TO_EXECUTE_DATA             0x00018
#define XHCR_CONTROLLER_CFG_BUS_BITS_CFG_NUM_PULSES_TO_EXECUTE_DATA             32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_TOTAL_DECIMATION_DATA                  0x00020
#define XHCR_CONTROLLER_CFG_BUS_BITS_CFG_TOTAL_DECIMATION_DATA                  32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_POST_DECIMATION_DATA                   0x00028
#define XHCR_CONTROLLER_CFG_BUS_BITS_CFG_POST_DECIMATION_DATA                   32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_NUM_PULSES_PER_XFER_DATA               0x00030
#define XHCR_CONTROLLER_CFG_BUS_BITS_CFG_NUM_PULSES_PER_XFER_DATA               32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_ENABLED_CHANNEL_VECTOR_DATA            0x00038
#define XHCR_CONTROLLER_CFG_BUS_BITS_CFG_ENABLED_CHANNEL_VECTOR_DATA            32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_WATCHDOG_DATA                          0x00040
#define XHCR_CONTROLLER_CFG_BUS_BITS_CFG_WATCHDOG_DATA                          32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_0_BASE              0x00080
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_0_HIGH              0x000ff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_PRT_0                  32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_PRT_0                  32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_1_BASE              0x00100
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PRT_1_HIGH              0x0017f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_PRT_1                  32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_PRT_1                  32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_BASE         0x00180
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_HIGH         0x001ff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_NUM_PULSES             32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_NUM_PULSES             32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_BASE    0x00200
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_HIGH    0x0027f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME        32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME        32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_BASE      0x00280
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_HIGH      0x002ff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_CONTROL_FLAGS          32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_CONTROL_FLAGS          32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_BASE  0x00300
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_HIGH  0x0037f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_POLARIZATION_MODE      32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_POLARIZATION_MODE      32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_BASE  0x00380
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_HIGH  0x003ff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0      32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0      32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_BASE  0x00400
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_HIGH  0x0047f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1      32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1      32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_BASE  0x00480
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_HIGH  0x004ff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2      32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2      32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN_BASE  0x00500
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN_HIGH  0x0057f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN      32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN      32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_END_BASE    0x00580
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_END_HIGH    0x005ff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_PHASE_TABLE_END        32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_PHASE_TABLE_END        32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_BASE     0x00600
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_HIGH     0x0067f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0         32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0         32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_BASE     0x00680
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_HIGH     0x006ff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1         32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1         32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_BASE     0x00700
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_HIGH     0x0077f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2         32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2         32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_BASE     0x00780
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_HIGH     0x007ff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3         32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3         32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_BASE     0x00800
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_HIGH     0x0087f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4         32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4         32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_BASE     0x00880
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_HIGH     0x008ff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5         32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5         32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_BASE     0x00900
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_HIGH     0x0097f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6         32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6         32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_BASE     0x00980
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_HIGH     0x009ff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7         32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7         32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_BASE      0x00a00
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_HIGH      0x00a7f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0          32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0          32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_BASE      0x00a80
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_HIGH      0x00aff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1          32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1          32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_BASE      0x00b00
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_HIGH      0x00b7f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2          32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2          32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_BASE      0x00b80
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_HIGH      0x00bff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3          32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3          32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_BASE      0x00c00
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_HIGH      0x00c7f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4          32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4          32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_BASE      0x00c80
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_HIGH      0x00cff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5          32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5          32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_BASE      0x00d00
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_HIGH      0x00d7f
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6          32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6          32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_BASE      0x00d80
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_HIGH      0x00dff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7          32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7          32
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH0_BASE                  0x01000
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH0_HIGH                  0x017ff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_FILTER_COEFS_CH0                      32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_FILTER_COEFS_CH0                      384
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH1_BASE                  0x01800
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH1_HIGH                  0x01fff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_FILTER_COEFS_CH1                      32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_FILTER_COEFS_CH1                      384
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH2_BASE                  0x02000
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_FILTER_COEFS_CH2_HIGH                  0x027ff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_FILTER_COEFS_CH2                      32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_FILTER_COEFS_CH2                      384
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PHASE_SAMPLES_BASE                     0x40000
#define XHCR_CONTROLLER_CFG_BUS_ADDR_CFG_PHASE_SAMPLES_HIGH                     0x7ffff
#define XHCR_CONTROLLER_CFG_BUS_WIDTH_CFG_PHASE_SAMPLES                         32
#define XHCR_CONTROLLER_CFG_BUS_DEPTH_CFG_PHASE_SAMPLES                         65536

