-- ==============================================================
-- Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2 (64-bit)
-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity hcr_controller_cfg_bus_s_axi is
generic (
    C_S_AXI_ADDR_WIDTH    : INTEGER := 19;
    C_S_AXI_DATA_WIDTH    : INTEGER := 32);
port (
    ACLK                  :in   STD_LOGIC;
    ARESET                :in   STD_LOGIC;
    ACLK_EN               :in   STD_LOGIC;
    AWADDR                :in   STD_LOGIC_VECTOR(C_S_AXI_ADDR_WIDTH-1 downto 0);
    AWVALID               :in   STD_LOGIC;
    AWREADY               :out  STD_LOGIC;
    WDATA                 :in   STD_LOGIC_VECTOR(C_S_AXI_DATA_WIDTH-1 downto 0);
    WSTRB                 :in   STD_LOGIC_VECTOR(C_S_AXI_DATA_WIDTH/8-1 downto 0);
    WVALID                :in   STD_LOGIC;
    WREADY                :out  STD_LOGIC;
    BRESP                 :out  STD_LOGIC_VECTOR(1 downto 0);
    BVALID                :out  STD_LOGIC;
    BREADY                :in   STD_LOGIC;
    ARADDR                :in   STD_LOGIC_VECTOR(C_S_AXI_ADDR_WIDTH-1 downto 0);
    ARVALID               :in   STD_LOGIC;
    ARREADY               :out  STD_LOGIC;
    RDATA                 :out  STD_LOGIC_VECTOR(C_S_AXI_DATA_WIDTH-1 downto 0);
    RRESP                 :out  STD_LOGIC_VECTOR(1 downto 0);
    RVALID                :out  STD_LOGIC;
    RREADY                :in   STD_LOGIC;
    interrupt             :out  STD_LOGIC;
    ap_start              :out  STD_LOGIC;
    ap_done               :in   STD_LOGIC;
    ap_ready              :in   STD_LOGIC;
    ap_idle               :in   STD_LOGIC;
    cfg_pulse_sequence_start_stop_indexes :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_num_pulses_to_execute :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_total_decimation  :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_post_decimation   :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_num_pulses_per_xfer :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_enabled_channel_vector :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_watchdog          :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_use_mag_phase     :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_prt_0_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_prt_0_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_prt_0_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_prt_1_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_prt_1_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_prt_1_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_num_pulses_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_num_pulses_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_num_pulses_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_block_post_time_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_block_post_time_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_block_post_time_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_control_flags_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_control_flags_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_control_flags_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_polarization_mode_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_polarization_mode_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_polarization_mode_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_filter_select_ch0_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_filter_select_ch0_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_filter_select_ch0_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_filter_select_ch1_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_filter_select_ch1_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_filter_select_ch1_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_filter_select_ch2_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_filter_select_ch2_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_filter_select_ch2_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_phase_table_begin_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_phase_table_begin_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_phase_table_begin_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_phase_table_end_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_phase_table_end_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_phase_table_end_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_timer_offset_0_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_timer_offset_0_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_timer_offset_0_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_timer_offset_1_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_timer_offset_1_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_timer_offset_1_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_timer_offset_2_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_timer_offset_2_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_timer_offset_2_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_timer_offset_3_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_timer_offset_3_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_timer_offset_3_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_timer_offset_4_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_timer_offset_4_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_timer_offset_4_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_timer_offset_5_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_timer_offset_5_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_timer_offset_5_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_timer_offset_6_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_timer_offset_6_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_timer_offset_6_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_timer_offset_7_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_timer_offset_7_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_timer_offset_7_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_timer_width_0_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_timer_width_0_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_timer_width_0_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_timer_width_1_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_timer_width_1_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_timer_width_1_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_timer_width_2_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_timer_width_2_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_timer_width_2_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_timer_width_3_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_timer_width_3_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_timer_width_3_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_timer_width_4_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_timer_width_4_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_timer_width_4_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_timer_width_5_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_timer_width_5_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_timer_width_5_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_timer_width_6_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_timer_width_6_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_timer_width_6_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_pulse_sequence_timer_width_7_address0 :in   STD_LOGIC_VECTOR(4 downto 0);
    cfg_pulse_sequence_timer_width_7_ce0 :in   STD_LOGIC;
    cfg_pulse_sequence_timer_width_7_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_filter_coefs_ch0_address0 :in   STD_LOGIC_VECTOR(8 downto 0);
    cfg_filter_coefs_ch0_ce0 :in   STD_LOGIC;
    cfg_filter_coefs_ch0_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_filter_coefs_ch1_address0 :in   STD_LOGIC_VECTOR(8 downto 0);
    cfg_filter_coefs_ch1_ce0 :in   STD_LOGIC;
    cfg_filter_coefs_ch1_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_filter_coefs_ch2_address0 :in   STD_LOGIC_VECTOR(8 downto 0);
    cfg_filter_coefs_ch2_ce0 :in   STD_LOGIC;
    cfg_filter_coefs_ch2_q0 :out  STD_LOGIC_VECTOR(31 downto 0);
    cfg_phase_samples_address0 :in   STD_LOGIC_VECTOR(15 downto 0);
    cfg_phase_samples_ce0 :in   STD_LOGIC;
    cfg_phase_samples_q0  :out  STD_LOGIC_VECTOR(31 downto 0)
);
end entity hcr_controller_cfg_bus_s_axi;

-- ------------------------Address Info-------------------
-- 0x00000 : Control signals
--           bit 0  - ap_start (Read/Write/COH)
--           bit 1  - ap_done (Read/COR)
--           bit 2  - ap_idle (Read)
--           bit 3  - ap_ready (Read)
--           bit 7  - auto_restart (Read/Write)
--           others - reserved
-- 0x00004 : Global Interrupt Enable Register
--           bit 0  - Global Interrupt Enable (Read/Write)
--           others - reserved
-- 0x00008 : IP Interrupt Enable Register (Read/Write)
--           bit 0  - Channel 0 (ap_done)
--           bit 1  - Channel 1 (ap_ready)
--           others - reserved
-- 0x0000c : IP Interrupt Status Register (Read/TOW)
--           bit 0  - Channel 0 (ap_done)
--           bit 1  - Channel 1 (ap_ready)
--           others - reserved
-- 0x00010 : Data signal of cfg_pulse_sequence_start_stop_indexes
--           bit 31~0 - cfg_pulse_sequence_start_stop_indexes[31:0] (Read/Write)
-- 0x00014 : reserved
-- 0x00018 : Data signal of cfg_num_pulses_to_execute
--           bit 31~0 - cfg_num_pulses_to_execute[31:0] (Read/Write)
-- 0x0001c : reserved
-- 0x00020 : Data signal of cfg_total_decimation
--           bit 31~0 - cfg_total_decimation[31:0] (Read/Write)
-- 0x00024 : reserved
-- 0x00028 : Data signal of cfg_post_decimation
--           bit 31~0 - cfg_post_decimation[31:0] (Read/Write)
-- 0x0002c : reserved
-- 0x00030 : Data signal of cfg_num_pulses_per_xfer
--           bit 31~0 - cfg_num_pulses_per_xfer[31:0] (Read/Write)
-- 0x00034 : reserved
-- 0x00038 : Data signal of cfg_enabled_channel_vector
--           bit 31~0 - cfg_enabled_channel_vector[31:0] (Read/Write)
-- 0x0003c : reserved
-- 0x00040 : Data signal of cfg_watchdog
--           bit 31~0 - cfg_watchdog[31:0] (Read/Write)
-- 0x00044 : reserved
-- 0x00048 : Data signal of cfg_use_mag_phase
--           bit 31~0 - cfg_use_mag_phase[31:0] (Read/Write)
-- 0x0004c : reserved
-- 0x00080 ~
-- 0x000ff : Memory 'cfg_pulse_sequence_prt_0' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_prt_0[n]
-- 0x00100 ~
-- 0x0017f : Memory 'cfg_pulse_sequence_prt_1' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_prt_1[n]
-- 0x00180 ~
-- 0x001ff : Memory 'cfg_pulse_sequence_num_pulses' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_num_pulses[n]
-- 0x00200 ~
-- 0x0027f : Memory 'cfg_pulse_sequence_block_post_time' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_block_post_time[n]
-- 0x00280 ~
-- 0x002ff : Memory 'cfg_pulse_sequence_control_flags' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_control_flags[n]
-- 0x00300 ~
-- 0x0037f : Memory 'cfg_pulse_sequence_polarization_mode' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_polarization_mode[n]
-- 0x00380 ~
-- 0x003ff : Memory 'cfg_pulse_sequence_filter_select_ch0' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_filter_select_ch0[n]
-- 0x00400 ~
-- 0x0047f : Memory 'cfg_pulse_sequence_filter_select_ch1' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_filter_select_ch1[n]
-- 0x00480 ~
-- 0x004ff : Memory 'cfg_pulse_sequence_filter_select_ch2' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_filter_select_ch2[n]
-- 0x00500 ~
-- 0x0057f : Memory 'cfg_pulse_sequence_phase_table_begin' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_phase_table_begin[n]
-- 0x00580 ~
-- 0x005ff : Memory 'cfg_pulse_sequence_phase_table_end' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_phase_table_end[n]
-- 0x00600 ~
-- 0x0067f : Memory 'cfg_pulse_sequence_timer_offset_0' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_0[n]
-- 0x00680 ~
-- 0x006ff : Memory 'cfg_pulse_sequence_timer_offset_1' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_1[n]
-- 0x00700 ~
-- 0x0077f : Memory 'cfg_pulse_sequence_timer_offset_2' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_2[n]
-- 0x00780 ~
-- 0x007ff : Memory 'cfg_pulse_sequence_timer_offset_3' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_3[n]
-- 0x00800 ~
-- 0x0087f : Memory 'cfg_pulse_sequence_timer_offset_4' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_4[n]
-- 0x00880 ~
-- 0x008ff : Memory 'cfg_pulse_sequence_timer_offset_5' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_5[n]
-- 0x00900 ~
-- 0x0097f : Memory 'cfg_pulse_sequence_timer_offset_6' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_6[n]
-- 0x00980 ~
-- 0x009ff : Memory 'cfg_pulse_sequence_timer_offset_7' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_timer_offset_7[n]
-- 0x00a00 ~
-- 0x00a7f : Memory 'cfg_pulse_sequence_timer_width_0' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_timer_width_0[n]
-- 0x00a80 ~
-- 0x00aff : Memory 'cfg_pulse_sequence_timer_width_1' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_timer_width_1[n]
-- 0x00b00 ~
-- 0x00b7f : Memory 'cfg_pulse_sequence_timer_width_2' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_timer_width_2[n]
-- 0x00b80 ~
-- 0x00bff : Memory 'cfg_pulse_sequence_timer_width_3' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_timer_width_3[n]
-- 0x00c00 ~
-- 0x00c7f : Memory 'cfg_pulse_sequence_timer_width_4' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_timer_width_4[n]
-- 0x00c80 ~
-- 0x00cff : Memory 'cfg_pulse_sequence_timer_width_5' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_timer_width_5[n]
-- 0x00d00 ~
-- 0x00d7f : Memory 'cfg_pulse_sequence_timer_width_6' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_timer_width_6[n]
-- 0x00d80 ~
-- 0x00dff : Memory 'cfg_pulse_sequence_timer_width_7' (32 * 32b)
--           Word n : bit [31:0] - cfg_pulse_sequence_timer_width_7[n]
-- 0x01000 ~
-- 0x017ff : Memory 'cfg_filter_coefs_ch0' (384 * 32b)
--           Word n : bit [31:0] - cfg_filter_coefs_ch0[n]
-- 0x01800 ~
-- 0x01fff : Memory 'cfg_filter_coefs_ch1' (384 * 32b)
--           Word n : bit [31:0] - cfg_filter_coefs_ch1[n]
-- 0x02000 ~
-- 0x027ff : Memory 'cfg_filter_coefs_ch2' (384 * 32b)
--           Word n : bit [31:0] - cfg_filter_coefs_ch2[n]
-- 0x40000 ~
-- 0x7ffff : Memory 'cfg_phase_samples' (65536 * 32b)
--           Word n : bit [31:0] - cfg_phase_samples[n]
-- (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

architecture behave of hcr_controller_cfg_bus_s_axi is
    type states is (wridle, wrdata, wrresp, wrreset, rdidle, rddata, rdreset);  -- read and write fsm states
    signal wstate  : states := wrreset;
    signal rstate  : states := rdreset;
    signal wnext, rnext: states;
    constant ADDR_AP_CTRL                                      : INTEGER := 16#00000#;
    constant ADDR_GIE                                          : INTEGER := 16#00004#;
    constant ADDR_IER                                          : INTEGER := 16#00008#;
    constant ADDR_ISR                                          : INTEGER := 16#0000c#;
    constant ADDR_CFG_PULSE_SEQUENCE_START_STOP_INDEXES_DATA_0 : INTEGER := 16#00010#;
    constant ADDR_CFG_PULSE_SEQUENCE_START_STOP_INDEXES_CTRL   : INTEGER := 16#00014#;
    constant ADDR_CFG_NUM_PULSES_TO_EXECUTE_DATA_0             : INTEGER := 16#00018#;
    constant ADDR_CFG_NUM_PULSES_TO_EXECUTE_CTRL               : INTEGER := 16#0001c#;
    constant ADDR_CFG_TOTAL_DECIMATION_DATA_0                  : INTEGER := 16#00020#;
    constant ADDR_CFG_TOTAL_DECIMATION_CTRL                    : INTEGER := 16#00024#;
    constant ADDR_CFG_POST_DECIMATION_DATA_0                   : INTEGER := 16#00028#;
    constant ADDR_CFG_POST_DECIMATION_CTRL                     : INTEGER := 16#0002c#;
    constant ADDR_CFG_NUM_PULSES_PER_XFER_DATA_0               : INTEGER := 16#00030#;
    constant ADDR_CFG_NUM_PULSES_PER_XFER_CTRL                 : INTEGER := 16#00034#;
    constant ADDR_CFG_ENABLED_CHANNEL_VECTOR_DATA_0            : INTEGER := 16#00038#;
    constant ADDR_CFG_ENABLED_CHANNEL_VECTOR_CTRL              : INTEGER := 16#0003c#;
    constant ADDR_CFG_WATCHDOG_DATA_0                          : INTEGER := 16#00040#;
    constant ADDR_CFG_WATCHDOG_CTRL                            : INTEGER := 16#00044#;
    constant ADDR_CFG_USE_MAG_PHASE_DATA_0                     : INTEGER := 16#00048#;
    constant ADDR_CFG_USE_MAG_PHASE_CTRL                       : INTEGER := 16#0004c#;
    constant ADDR_CFG_PULSE_SEQUENCE_PRT_0_BASE                : INTEGER := 16#00080#;
    constant ADDR_CFG_PULSE_SEQUENCE_PRT_0_HIGH                : INTEGER := 16#000ff#;
    constant ADDR_CFG_PULSE_SEQUENCE_PRT_1_BASE                : INTEGER := 16#00100#;
    constant ADDR_CFG_PULSE_SEQUENCE_PRT_1_HIGH                : INTEGER := 16#0017f#;
    constant ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_BASE           : INTEGER := 16#00180#;
    constant ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_HIGH           : INTEGER := 16#001ff#;
    constant ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_BASE      : INTEGER := 16#00200#;
    constant ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_HIGH      : INTEGER := 16#0027f#;
    constant ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_BASE        : INTEGER := 16#00280#;
    constant ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_HIGH        : INTEGER := 16#002ff#;
    constant ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_BASE    : INTEGER := 16#00300#;
    constant ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_HIGH    : INTEGER := 16#0037f#;
    constant ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_BASE    : INTEGER := 16#00380#;
    constant ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_HIGH    : INTEGER := 16#003ff#;
    constant ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_BASE    : INTEGER := 16#00400#;
    constant ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_HIGH    : INTEGER := 16#0047f#;
    constant ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_BASE    : INTEGER := 16#00480#;
    constant ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_HIGH    : INTEGER := 16#004ff#;
    constant ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN_BASE    : INTEGER := 16#00500#;
    constant ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN_HIGH    : INTEGER := 16#0057f#;
    constant ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_END_BASE      : INTEGER := 16#00580#;
    constant ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_END_HIGH      : INTEGER := 16#005ff#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_BASE       : INTEGER := 16#00600#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_HIGH       : INTEGER := 16#0067f#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_BASE       : INTEGER := 16#00680#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_HIGH       : INTEGER := 16#006ff#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_BASE       : INTEGER := 16#00700#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_HIGH       : INTEGER := 16#0077f#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_BASE       : INTEGER := 16#00780#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_HIGH       : INTEGER := 16#007ff#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_BASE       : INTEGER := 16#00800#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_HIGH       : INTEGER := 16#0087f#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_BASE       : INTEGER := 16#00880#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_HIGH       : INTEGER := 16#008ff#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_BASE       : INTEGER := 16#00900#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_HIGH       : INTEGER := 16#0097f#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_BASE       : INTEGER := 16#00980#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_HIGH       : INTEGER := 16#009ff#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_BASE        : INTEGER := 16#00a00#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_HIGH        : INTEGER := 16#00a7f#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_BASE        : INTEGER := 16#00a80#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_HIGH        : INTEGER := 16#00aff#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_BASE        : INTEGER := 16#00b00#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_HIGH        : INTEGER := 16#00b7f#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_BASE        : INTEGER := 16#00b80#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_HIGH        : INTEGER := 16#00bff#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_BASE        : INTEGER := 16#00c00#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_HIGH        : INTEGER := 16#00c7f#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_BASE        : INTEGER := 16#00c80#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_HIGH        : INTEGER := 16#00cff#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_BASE        : INTEGER := 16#00d00#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_HIGH        : INTEGER := 16#00d7f#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_BASE        : INTEGER := 16#00d80#;
    constant ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_HIGH        : INTEGER := 16#00dff#;
    constant ADDR_CFG_FILTER_COEFS_CH0_BASE                    : INTEGER := 16#01000#;
    constant ADDR_CFG_FILTER_COEFS_CH0_HIGH                    : INTEGER := 16#017ff#;
    constant ADDR_CFG_FILTER_COEFS_CH1_BASE                    : INTEGER := 16#01800#;
    constant ADDR_CFG_FILTER_COEFS_CH1_HIGH                    : INTEGER := 16#01fff#;
    constant ADDR_CFG_FILTER_COEFS_CH2_BASE                    : INTEGER := 16#02000#;
    constant ADDR_CFG_FILTER_COEFS_CH2_HIGH                    : INTEGER := 16#027ff#;
    constant ADDR_CFG_PHASE_SAMPLES_BASE                       : INTEGER := 16#40000#;
    constant ADDR_CFG_PHASE_SAMPLES_HIGH                       : INTEGER := 16#7ffff#;
    constant ADDR_BITS         : INTEGER := 19;

    signal waddr               : UNSIGNED(ADDR_BITS-1 downto 0);
    signal wmask               : UNSIGNED(31 downto 0);
    signal aw_hs               : STD_LOGIC;
    signal w_hs                : STD_LOGIC;
    signal rdata_data          : UNSIGNED(31 downto 0);
    signal ar_hs               : STD_LOGIC;
    signal raddr               : UNSIGNED(ADDR_BITS-1 downto 0);
    signal AWREADY_t           : STD_LOGIC;
    signal WREADY_t            : STD_LOGIC;
    signal ARREADY_t           : STD_LOGIC;
    signal RVALID_t            : STD_LOGIC;
    -- internal registers
    signal int_ap_idle         : STD_LOGIC;
    signal int_ap_ready        : STD_LOGIC;
    signal int_ap_done         : STD_LOGIC := '0';
    signal int_ap_start        : STD_LOGIC := '0';
    signal int_auto_restart    : STD_LOGIC := '0';
    signal int_gie             : STD_LOGIC := '0';
    signal int_ier             : UNSIGNED(1 downto 0) := (others => '0');
    signal int_isr             : UNSIGNED(1 downto 0) := (others => '0');
    signal int_cfg_pulse_sequence_start_stop_indexes : UNSIGNED(31 downto 0) := (others => '0');
    signal int_cfg_num_pulses_to_execute : UNSIGNED(31 downto 0) := (others => '0');
    signal int_cfg_total_decimation : UNSIGNED(31 downto 0) := (others => '0');
    signal int_cfg_post_decimation : UNSIGNED(31 downto 0) := (others => '0');
    signal int_cfg_num_pulses_per_xfer : UNSIGNED(31 downto 0) := (others => '0');
    signal int_cfg_enabled_channel_vector : UNSIGNED(31 downto 0) := (others => '0');
    signal int_cfg_watchdog    : UNSIGNED(31 downto 0) := (others => '0');
    signal int_cfg_use_mag_phase : UNSIGNED(31 downto 0) := (others => '0');
    -- memory signals
    signal int_cfg_pulse_sequence_prt_0_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_prt_0_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_prt_0_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_prt_0_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_prt_0_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_prt_0_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_prt_0_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_prt_0_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_prt_0_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_prt_0_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_prt_0_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_prt_0_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_prt_0_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_prt_0_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_prt_1_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_prt_1_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_prt_1_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_prt_1_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_prt_1_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_prt_1_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_prt_1_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_prt_1_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_prt_1_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_prt_1_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_prt_1_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_prt_1_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_prt_1_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_prt_1_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_num_pulses_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_num_pulses_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_num_pulses_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_num_pulses_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_num_pulses_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_num_pulses_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_num_pulses_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_num_pulses_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_num_pulses_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_num_pulses_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_num_pulses_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_num_pulses_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_num_pulses_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_num_pulses_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_block_post_time_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_block_post_time_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_block_post_time_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_block_post_time_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_block_post_time_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_block_post_time_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_block_post_time_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_block_post_time_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_block_post_time_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_block_post_time_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_block_post_time_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_block_post_time_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_block_post_time_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_block_post_time_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_control_flags_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_control_flags_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_control_flags_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_control_flags_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_control_flags_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_control_flags_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_control_flags_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_control_flags_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_control_flags_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_control_flags_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_control_flags_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_control_flags_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_control_flags_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_control_flags_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_polarization_mode_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_polarization_mode_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_polarization_mode_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_polarization_mode_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_polarization_mode_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_polarization_mode_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_polarization_mode_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_polarization_mode_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_polarization_mode_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_polarization_mode_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_polarization_mode_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_polarization_mode_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_polarization_mode_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_polarization_mode_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_filter_select_ch0_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_filter_select_ch0_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_filter_select_ch0_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_filter_select_ch0_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_filter_select_ch0_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_filter_select_ch0_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_filter_select_ch0_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_filter_select_ch0_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_filter_select_ch0_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_filter_select_ch0_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_filter_select_ch0_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_filter_select_ch0_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_filter_select_ch0_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_filter_select_ch0_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_filter_select_ch1_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_filter_select_ch1_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_filter_select_ch1_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_filter_select_ch1_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_filter_select_ch1_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_filter_select_ch1_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_filter_select_ch1_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_filter_select_ch1_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_filter_select_ch1_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_filter_select_ch1_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_filter_select_ch1_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_filter_select_ch1_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_filter_select_ch1_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_filter_select_ch1_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_filter_select_ch2_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_filter_select_ch2_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_filter_select_ch2_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_filter_select_ch2_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_filter_select_ch2_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_filter_select_ch2_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_filter_select_ch2_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_filter_select_ch2_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_filter_select_ch2_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_filter_select_ch2_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_filter_select_ch2_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_filter_select_ch2_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_filter_select_ch2_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_filter_select_ch2_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_phase_table_begin_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_phase_table_begin_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_phase_table_begin_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_phase_table_begin_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_phase_table_begin_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_phase_table_begin_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_phase_table_begin_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_phase_table_begin_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_phase_table_begin_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_phase_table_begin_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_phase_table_begin_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_phase_table_begin_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_phase_table_begin_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_phase_table_begin_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_phase_table_end_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_phase_table_end_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_phase_table_end_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_phase_table_end_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_phase_table_end_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_phase_table_end_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_phase_table_end_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_phase_table_end_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_phase_table_end_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_phase_table_end_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_phase_table_end_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_phase_table_end_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_phase_table_end_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_phase_table_end_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_0_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_0_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_0_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_0_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_0_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_0_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_0_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_0_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_0_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_0_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_0_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_0_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_0_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_0_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_1_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_1_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_1_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_1_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_1_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_1_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_1_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_1_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_1_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_1_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_1_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_1_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_1_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_1_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_2_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_2_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_2_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_2_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_2_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_2_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_2_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_2_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_2_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_2_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_2_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_2_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_2_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_2_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_3_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_3_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_3_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_3_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_3_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_3_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_3_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_3_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_3_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_3_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_3_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_3_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_3_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_3_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_4_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_4_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_4_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_4_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_4_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_4_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_4_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_4_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_4_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_4_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_4_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_4_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_4_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_4_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_5_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_5_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_5_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_5_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_5_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_5_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_5_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_5_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_5_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_5_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_5_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_5_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_5_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_5_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_6_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_6_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_6_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_6_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_6_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_6_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_6_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_6_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_6_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_6_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_6_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_6_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_6_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_6_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_7_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_7_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_7_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_7_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_7_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_7_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_7_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_7_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_7_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_7_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_7_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_7_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_offset_7_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_offset_7_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_0_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_width_0_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_0_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_0_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_width_0_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_0_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_0_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_width_0_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_0_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_0_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_width_0_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_0_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_0_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_0_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_1_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_width_1_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_1_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_1_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_width_1_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_1_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_1_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_width_1_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_1_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_1_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_width_1_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_1_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_1_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_1_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_2_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_width_2_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_2_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_2_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_width_2_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_2_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_2_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_width_2_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_2_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_2_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_width_2_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_2_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_2_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_2_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_3_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_width_3_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_3_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_3_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_width_3_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_3_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_3_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_width_3_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_3_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_3_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_width_3_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_3_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_3_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_3_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_4_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_width_4_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_4_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_4_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_width_4_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_4_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_4_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_width_4_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_4_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_4_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_width_4_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_4_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_4_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_4_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_5_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_width_5_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_5_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_5_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_width_5_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_5_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_5_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_width_5_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_5_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_5_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_width_5_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_5_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_5_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_5_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_6_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_width_6_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_6_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_6_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_width_6_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_6_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_6_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_width_6_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_6_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_6_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_width_6_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_6_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_6_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_6_write : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_7_address0 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_width_7_ce0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_7_we0 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_7_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_width_7_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_7_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_7_address1 : UNSIGNED(4 downto 0);
    signal int_cfg_pulse_sequence_timer_width_7_ce1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_7_we1 : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_7_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_pulse_sequence_timer_width_7_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_7_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_pulse_sequence_timer_width_7_read : STD_LOGIC;
    signal int_cfg_pulse_sequence_timer_width_7_write : STD_LOGIC;
    signal int_cfg_filter_coefs_ch0_address0 : UNSIGNED(8 downto 0);
    signal int_cfg_filter_coefs_ch0_ce0 : STD_LOGIC;
    signal int_cfg_filter_coefs_ch0_we0 : STD_LOGIC;
    signal int_cfg_filter_coefs_ch0_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_filter_coefs_ch0_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_filter_coefs_ch0_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_filter_coefs_ch0_address1 : UNSIGNED(8 downto 0);
    signal int_cfg_filter_coefs_ch0_ce1 : STD_LOGIC;
    signal int_cfg_filter_coefs_ch0_we1 : STD_LOGIC;
    signal int_cfg_filter_coefs_ch0_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_filter_coefs_ch0_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_filter_coefs_ch0_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_filter_coefs_ch0_read : STD_LOGIC;
    signal int_cfg_filter_coefs_ch0_write : STD_LOGIC;
    signal int_cfg_filter_coefs_ch1_address0 : UNSIGNED(8 downto 0);
    signal int_cfg_filter_coefs_ch1_ce0 : STD_LOGIC;
    signal int_cfg_filter_coefs_ch1_we0 : STD_LOGIC;
    signal int_cfg_filter_coefs_ch1_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_filter_coefs_ch1_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_filter_coefs_ch1_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_filter_coefs_ch1_address1 : UNSIGNED(8 downto 0);
    signal int_cfg_filter_coefs_ch1_ce1 : STD_LOGIC;
    signal int_cfg_filter_coefs_ch1_we1 : STD_LOGIC;
    signal int_cfg_filter_coefs_ch1_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_filter_coefs_ch1_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_filter_coefs_ch1_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_filter_coefs_ch1_read : STD_LOGIC;
    signal int_cfg_filter_coefs_ch1_write : STD_LOGIC;
    signal int_cfg_filter_coefs_ch2_address0 : UNSIGNED(8 downto 0);
    signal int_cfg_filter_coefs_ch2_ce0 : STD_LOGIC;
    signal int_cfg_filter_coefs_ch2_we0 : STD_LOGIC;
    signal int_cfg_filter_coefs_ch2_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_filter_coefs_ch2_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_filter_coefs_ch2_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_filter_coefs_ch2_address1 : UNSIGNED(8 downto 0);
    signal int_cfg_filter_coefs_ch2_ce1 : STD_LOGIC;
    signal int_cfg_filter_coefs_ch2_we1 : STD_LOGIC;
    signal int_cfg_filter_coefs_ch2_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_filter_coefs_ch2_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_filter_coefs_ch2_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_filter_coefs_ch2_read : STD_LOGIC;
    signal int_cfg_filter_coefs_ch2_write : STD_LOGIC;
    signal int_cfg_phase_samples_address0 : UNSIGNED(15 downto 0);
    signal int_cfg_phase_samples_ce0 : STD_LOGIC;
    signal int_cfg_phase_samples_we0 : STD_LOGIC;
    signal int_cfg_phase_samples_be0 : UNSIGNED(3 downto 0);
    signal int_cfg_phase_samples_d0 : UNSIGNED(31 downto 0);
    signal int_cfg_phase_samples_q0 : UNSIGNED(31 downto 0);
    signal int_cfg_phase_samples_address1 : UNSIGNED(15 downto 0);
    signal int_cfg_phase_samples_ce1 : STD_LOGIC;
    signal int_cfg_phase_samples_we1 : STD_LOGIC;
    signal int_cfg_phase_samples_be1 : UNSIGNED(3 downto 0);
    signal int_cfg_phase_samples_d1 : UNSIGNED(31 downto 0);
    signal int_cfg_phase_samples_q1 : UNSIGNED(31 downto 0);
    signal int_cfg_phase_samples_read : STD_LOGIC;
    signal int_cfg_phase_samples_write : STD_LOGIC;

    component hcr_controller_cfg_bus_s_axi_ram is
        generic (
            BYTES   : INTEGER :=4;
            DEPTH   : INTEGER :=256;
            AWIDTH  : INTEGER :=8);
        port (
            clk0    : in  STD_LOGIC;
            address0: in  UNSIGNED(AWIDTH-1 downto 0);
            ce0     : in  STD_LOGIC;
            we0     : in  STD_LOGIC;
            be0     : in  UNSIGNED(BYTES-1 downto 0);
            d0      : in  UNSIGNED(BYTES*8-1 downto 0);
            q0      : out UNSIGNED(BYTES*8-1 downto 0);
            clk1    : in  STD_LOGIC;
            address1: in  UNSIGNED(AWIDTH-1 downto 0);
            ce1     : in  STD_LOGIC;
            we1     : in  STD_LOGIC;
            be1     : in  UNSIGNED(BYTES-1 downto 0);
            d1      : in  UNSIGNED(BYTES*8-1 downto 0);
            q1      : out UNSIGNED(BYTES*8-1 downto 0));
    end component hcr_controller_cfg_bus_s_axi_ram;

    function log2 (x : INTEGER) return INTEGER is
        variable n, m : INTEGER;
    begin
        n := 1;
        m := 2;
        while m < x loop
            n := n + 1;
            m := m * 2;
        end loop;
        return n;
    end function log2;

begin
-- ----------------------- Instantiation------------------
-- int_cfg_pulse_sequence_prt_0
int_cfg_pulse_sequence_prt_0 : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_prt_0_address0,
     ce0      => int_cfg_pulse_sequence_prt_0_ce0,
     we0      => int_cfg_pulse_sequence_prt_0_we0,
     be0      => int_cfg_pulse_sequence_prt_0_be0,
     d0       => int_cfg_pulse_sequence_prt_0_d0,
     q0       => int_cfg_pulse_sequence_prt_0_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_prt_0_address1,
     ce1      => int_cfg_pulse_sequence_prt_0_ce1,
     we1      => int_cfg_pulse_sequence_prt_0_we1,
     be1      => int_cfg_pulse_sequence_prt_0_be1,
     d1       => int_cfg_pulse_sequence_prt_0_d1,
     q1       => int_cfg_pulse_sequence_prt_0_q1);
-- int_cfg_pulse_sequence_prt_1
int_cfg_pulse_sequence_prt_1 : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_prt_1_address0,
     ce0      => int_cfg_pulse_sequence_prt_1_ce0,
     we0      => int_cfg_pulse_sequence_prt_1_we0,
     be0      => int_cfg_pulse_sequence_prt_1_be0,
     d0       => int_cfg_pulse_sequence_prt_1_d0,
     q0       => int_cfg_pulse_sequence_prt_1_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_prt_1_address1,
     ce1      => int_cfg_pulse_sequence_prt_1_ce1,
     we1      => int_cfg_pulse_sequence_prt_1_we1,
     be1      => int_cfg_pulse_sequence_prt_1_be1,
     d1       => int_cfg_pulse_sequence_prt_1_d1,
     q1       => int_cfg_pulse_sequence_prt_1_q1);
-- int_cfg_pulse_sequence_num_pulses
int_cfg_pulse_sequence_num_pulses : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_num_pulses_address0,
     ce0      => int_cfg_pulse_sequence_num_pulses_ce0,
     we0      => int_cfg_pulse_sequence_num_pulses_we0,
     be0      => int_cfg_pulse_sequence_num_pulses_be0,
     d0       => int_cfg_pulse_sequence_num_pulses_d0,
     q0       => int_cfg_pulse_sequence_num_pulses_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_num_pulses_address1,
     ce1      => int_cfg_pulse_sequence_num_pulses_ce1,
     we1      => int_cfg_pulse_sequence_num_pulses_we1,
     be1      => int_cfg_pulse_sequence_num_pulses_be1,
     d1       => int_cfg_pulse_sequence_num_pulses_d1,
     q1       => int_cfg_pulse_sequence_num_pulses_q1);
-- int_cfg_pulse_sequence_block_post_time
int_cfg_pulse_sequence_block_post_time : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_block_post_time_address0,
     ce0      => int_cfg_pulse_sequence_block_post_time_ce0,
     we0      => int_cfg_pulse_sequence_block_post_time_we0,
     be0      => int_cfg_pulse_sequence_block_post_time_be0,
     d0       => int_cfg_pulse_sequence_block_post_time_d0,
     q0       => int_cfg_pulse_sequence_block_post_time_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_block_post_time_address1,
     ce1      => int_cfg_pulse_sequence_block_post_time_ce1,
     we1      => int_cfg_pulse_sequence_block_post_time_we1,
     be1      => int_cfg_pulse_sequence_block_post_time_be1,
     d1       => int_cfg_pulse_sequence_block_post_time_d1,
     q1       => int_cfg_pulse_sequence_block_post_time_q1);
-- int_cfg_pulse_sequence_control_flags
int_cfg_pulse_sequence_control_flags : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_control_flags_address0,
     ce0      => int_cfg_pulse_sequence_control_flags_ce0,
     we0      => int_cfg_pulse_sequence_control_flags_we0,
     be0      => int_cfg_pulse_sequence_control_flags_be0,
     d0       => int_cfg_pulse_sequence_control_flags_d0,
     q0       => int_cfg_pulse_sequence_control_flags_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_control_flags_address1,
     ce1      => int_cfg_pulse_sequence_control_flags_ce1,
     we1      => int_cfg_pulse_sequence_control_flags_we1,
     be1      => int_cfg_pulse_sequence_control_flags_be1,
     d1       => int_cfg_pulse_sequence_control_flags_d1,
     q1       => int_cfg_pulse_sequence_control_flags_q1);
-- int_cfg_pulse_sequence_polarization_mode
int_cfg_pulse_sequence_polarization_mode : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_polarization_mode_address0,
     ce0      => int_cfg_pulse_sequence_polarization_mode_ce0,
     we0      => int_cfg_pulse_sequence_polarization_mode_we0,
     be0      => int_cfg_pulse_sequence_polarization_mode_be0,
     d0       => int_cfg_pulse_sequence_polarization_mode_d0,
     q0       => int_cfg_pulse_sequence_polarization_mode_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_polarization_mode_address1,
     ce1      => int_cfg_pulse_sequence_polarization_mode_ce1,
     we1      => int_cfg_pulse_sequence_polarization_mode_we1,
     be1      => int_cfg_pulse_sequence_polarization_mode_be1,
     d1       => int_cfg_pulse_sequence_polarization_mode_d1,
     q1       => int_cfg_pulse_sequence_polarization_mode_q1);
-- int_cfg_pulse_sequence_filter_select_ch0
int_cfg_pulse_sequence_filter_select_ch0 : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_filter_select_ch0_address0,
     ce0      => int_cfg_pulse_sequence_filter_select_ch0_ce0,
     we0      => int_cfg_pulse_sequence_filter_select_ch0_we0,
     be0      => int_cfg_pulse_sequence_filter_select_ch0_be0,
     d0       => int_cfg_pulse_sequence_filter_select_ch0_d0,
     q0       => int_cfg_pulse_sequence_filter_select_ch0_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_filter_select_ch0_address1,
     ce1      => int_cfg_pulse_sequence_filter_select_ch0_ce1,
     we1      => int_cfg_pulse_sequence_filter_select_ch0_we1,
     be1      => int_cfg_pulse_sequence_filter_select_ch0_be1,
     d1       => int_cfg_pulse_sequence_filter_select_ch0_d1,
     q1       => int_cfg_pulse_sequence_filter_select_ch0_q1);
-- int_cfg_pulse_sequence_filter_select_ch1
int_cfg_pulse_sequence_filter_select_ch1 : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_filter_select_ch1_address0,
     ce0      => int_cfg_pulse_sequence_filter_select_ch1_ce0,
     we0      => int_cfg_pulse_sequence_filter_select_ch1_we0,
     be0      => int_cfg_pulse_sequence_filter_select_ch1_be0,
     d0       => int_cfg_pulse_sequence_filter_select_ch1_d0,
     q0       => int_cfg_pulse_sequence_filter_select_ch1_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_filter_select_ch1_address1,
     ce1      => int_cfg_pulse_sequence_filter_select_ch1_ce1,
     we1      => int_cfg_pulse_sequence_filter_select_ch1_we1,
     be1      => int_cfg_pulse_sequence_filter_select_ch1_be1,
     d1       => int_cfg_pulse_sequence_filter_select_ch1_d1,
     q1       => int_cfg_pulse_sequence_filter_select_ch1_q1);
-- int_cfg_pulse_sequence_filter_select_ch2
int_cfg_pulse_sequence_filter_select_ch2 : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_filter_select_ch2_address0,
     ce0      => int_cfg_pulse_sequence_filter_select_ch2_ce0,
     we0      => int_cfg_pulse_sequence_filter_select_ch2_we0,
     be0      => int_cfg_pulse_sequence_filter_select_ch2_be0,
     d0       => int_cfg_pulse_sequence_filter_select_ch2_d0,
     q0       => int_cfg_pulse_sequence_filter_select_ch2_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_filter_select_ch2_address1,
     ce1      => int_cfg_pulse_sequence_filter_select_ch2_ce1,
     we1      => int_cfg_pulse_sequence_filter_select_ch2_we1,
     be1      => int_cfg_pulse_sequence_filter_select_ch2_be1,
     d1       => int_cfg_pulse_sequence_filter_select_ch2_d1,
     q1       => int_cfg_pulse_sequence_filter_select_ch2_q1);
-- int_cfg_pulse_sequence_phase_table_begin
int_cfg_pulse_sequence_phase_table_begin : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_phase_table_begin_address0,
     ce0      => int_cfg_pulse_sequence_phase_table_begin_ce0,
     we0      => int_cfg_pulse_sequence_phase_table_begin_we0,
     be0      => int_cfg_pulse_sequence_phase_table_begin_be0,
     d0       => int_cfg_pulse_sequence_phase_table_begin_d0,
     q0       => int_cfg_pulse_sequence_phase_table_begin_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_phase_table_begin_address1,
     ce1      => int_cfg_pulse_sequence_phase_table_begin_ce1,
     we1      => int_cfg_pulse_sequence_phase_table_begin_we1,
     be1      => int_cfg_pulse_sequence_phase_table_begin_be1,
     d1       => int_cfg_pulse_sequence_phase_table_begin_d1,
     q1       => int_cfg_pulse_sequence_phase_table_begin_q1);
-- int_cfg_pulse_sequence_phase_table_end
int_cfg_pulse_sequence_phase_table_end : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_phase_table_end_address0,
     ce0      => int_cfg_pulse_sequence_phase_table_end_ce0,
     we0      => int_cfg_pulse_sequence_phase_table_end_we0,
     be0      => int_cfg_pulse_sequence_phase_table_end_be0,
     d0       => int_cfg_pulse_sequence_phase_table_end_d0,
     q0       => int_cfg_pulse_sequence_phase_table_end_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_phase_table_end_address1,
     ce1      => int_cfg_pulse_sequence_phase_table_end_ce1,
     we1      => int_cfg_pulse_sequence_phase_table_end_we1,
     be1      => int_cfg_pulse_sequence_phase_table_end_be1,
     d1       => int_cfg_pulse_sequence_phase_table_end_d1,
     q1       => int_cfg_pulse_sequence_phase_table_end_q1);
-- int_cfg_pulse_sequence_timer_offset_0
int_cfg_pulse_sequence_timer_offset_0 : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_timer_offset_0_address0,
     ce0      => int_cfg_pulse_sequence_timer_offset_0_ce0,
     we0      => int_cfg_pulse_sequence_timer_offset_0_we0,
     be0      => int_cfg_pulse_sequence_timer_offset_0_be0,
     d0       => int_cfg_pulse_sequence_timer_offset_0_d0,
     q0       => int_cfg_pulse_sequence_timer_offset_0_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_timer_offset_0_address1,
     ce1      => int_cfg_pulse_sequence_timer_offset_0_ce1,
     we1      => int_cfg_pulse_sequence_timer_offset_0_we1,
     be1      => int_cfg_pulse_sequence_timer_offset_0_be1,
     d1       => int_cfg_pulse_sequence_timer_offset_0_d1,
     q1       => int_cfg_pulse_sequence_timer_offset_0_q1);
-- int_cfg_pulse_sequence_timer_offset_1
int_cfg_pulse_sequence_timer_offset_1 : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_timer_offset_1_address0,
     ce0      => int_cfg_pulse_sequence_timer_offset_1_ce0,
     we0      => int_cfg_pulse_sequence_timer_offset_1_we0,
     be0      => int_cfg_pulse_sequence_timer_offset_1_be0,
     d0       => int_cfg_pulse_sequence_timer_offset_1_d0,
     q0       => int_cfg_pulse_sequence_timer_offset_1_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_timer_offset_1_address1,
     ce1      => int_cfg_pulse_sequence_timer_offset_1_ce1,
     we1      => int_cfg_pulse_sequence_timer_offset_1_we1,
     be1      => int_cfg_pulse_sequence_timer_offset_1_be1,
     d1       => int_cfg_pulse_sequence_timer_offset_1_d1,
     q1       => int_cfg_pulse_sequence_timer_offset_1_q1);
-- int_cfg_pulse_sequence_timer_offset_2
int_cfg_pulse_sequence_timer_offset_2 : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_timer_offset_2_address0,
     ce0      => int_cfg_pulse_sequence_timer_offset_2_ce0,
     we0      => int_cfg_pulse_sequence_timer_offset_2_we0,
     be0      => int_cfg_pulse_sequence_timer_offset_2_be0,
     d0       => int_cfg_pulse_sequence_timer_offset_2_d0,
     q0       => int_cfg_pulse_sequence_timer_offset_2_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_timer_offset_2_address1,
     ce1      => int_cfg_pulse_sequence_timer_offset_2_ce1,
     we1      => int_cfg_pulse_sequence_timer_offset_2_we1,
     be1      => int_cfg_pulse_sequence_timer_offset_2_be1,
     d1       => int_cfg_pulse_sequence_timer_offset_2_d1,
     q1       => int_cfg_pulse_sequence_timer_offset_2_q1);
-- int_cfg_pulse_sequence_timer_offset_3
int_cfg_pulse_sequence_timer_offset_3 : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_timer_offset_3_address0,
     ce0      => int_cfg_pulse_sequence_timer_offset_3_ce0,
     we0      => int_cfg_pulse_sequence_timer_offset_3_we0,
     be0      => int_cfg_pulse_sequence_timer_offset_3_be0,
     d0       => int_cfg_pulse_sequence_timer_offset_3_d0,
     q0       => int_cfg_pulse_sequence_timer_offset_3_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_timer_offset_3_address1,
     ce1      => int_cfg_pulse_sequence_timer_offset_3_ce1,
     we1      => int_cfg_pulse_sequence_timer_offset_3_we1,
     be1      => int_cfg_pulse_sequence_timer_offset_3_be1,
     d1       => int_cfg_pulse_sequence_timer_offset_3_d1,
     q1       => int_cfg_pulse_sequence_timer_offset_3_q1);
-- int_cfg_pulse_sequence_timer_offset_4
int_cfg_pulse_sequence_timer_offset_4 : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_timer_offset_4_address0,
     ce0      => int_cfg_pulse_sequence_timer_offset_4_ce0,
     we0      => int_cfg_pulse_sequence_timer_offset_4_we0,
     be0      => int_cfg_pulse_sequence_timer_offset_4_be0,
     d0       => int_cfg_pulse_sequence_timer_offset_4_d0,
     q0       => int_cfg_pulse_sequence_timer_offset_4_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_timer_offset_4_address1,
     ce1      => int_cfg_pulse_sequence_timer_offset_4_ce1,
     we1      => int_cfg_pulse_sequence_timer_offset_4_we1,
     be1      => int_cfg_pulse_sequence_timer_offset_4_be1,
     d1       => int_cfg_pulse_sequence_timer_offset_4_d1,
     q1       => int_cfg_pulse_sequence_timer_offset_4_q1);
-- int_cfg_pulse_sequence_timer_offset_5
int_cfg_pulse_sequence_timer_offset_5 : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_timer_offset_5_address0,
     ce0      => int_cfg_pulse_sequence_timer_offset_5_ce0,
     we0      => int_cfg_pulse_sequence_timer_offset_5_we0,
     be0      => int_cfg_pulse_sequence_timer_offset_5_be0,
     d0       => int_cfg_pulse_sequence_timer_offset_5_d0,
     q0       => int_cfg_pulse_sequence_timer_offset_5_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_timer_offset_5_address1,
     ce1      => int_cfg_pulse_sequence_timer_offset_5_ce1,
     we1      => int_cfg_pulse_sequence_timer_offset_5_we1,
     be1      => int_cfg_pulse_sequence_timer_offset_5_be1,
     d1       => int_cfg_pulse_sequence_timer_offset_5_d1,
     q1       => int_cfg_pulse_sequence_timer_offset_5_q1);
-- int_cfg_pulse_sequence_timer_offset_6
int_cfg_pulse_sequence_timer_offset_6 : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_timer_offset_6_address0,
     ce0      => int_cfg_pulse_sequence_timer_offset_6_ce0,
     we0      => int_cfg_pulse_sequence_timer_offset_6_we0,
     be0      => int_cfg_pulse_sequence_timer_offset_6_be0,
     d0       => int_cfg_pulse_sequence_timer_offset_6_d0,
     q0       => int_cfg_pulse_sequence_timer_offset_6_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_timer_offset_6_address1,
     ce1      => int_cfg_pulse_sequence_timer_offset_6_ce1,
     we1      => int_cfg_pulse_sequence_timer_offset_6_we1,
     be1      => int_cfg_pulse_sequence_timer_offset_6_be1,
     d1       => int_cfg_pulse_sequence_timer_offset_6_d1,
     q1       => int_cfg_pulse_sequence_timer_offset_6_q1);
-- int_cfg_pulse_sequence_timer_offset_7
int_cfg_pulse_sequence_timer_offset_7 : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_timer_offset_7_address0,
     ce0      => int_cfg_pulse_sequence_timer_offset_7_ce0,
     we0      => int_cfg_pulse_sequence_timer_offset_7_we0,
     be0      => int_cfg_pulse_sequence_timer_offset_7_be0,
     d0       => int_cfg_pulse_sequence_timer_offset_7_d0,
     q0       => int_cfg_pulse_sequence_timer_offset_7_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_timer_offset_7_address1,
     ce1      => int_cfg_pulse_sequence_timer_offset_7_ce1,
     we1      => int_cfg_pulse_sequence_timer_offset_7_we1,
     be1      => int_cfg_pulse_sequence_timer_offset_7_be1,
     d1       => int_cfg_pulse_sequence_timer_offset_7_d1,
     q1       => int_cfg_pulse_sequence_timer_offset_7_q1);
-- int_cfg_pulse_sequence_timer_width_0
int_cfg_pulse_sequence_timer_width_0 : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_timer_width_0_address0,
     ce0      => int_cfg_pulse_sequence_timer_width_0_ce0,
     we0      => int_cfg_pulse_sequence_timer_width_0_we0,
     be0      => int_cfg_pulse_sequence_timer_width_0_be0,
     d0       => int_cfg_pulse_sequence_timer_width_0_d0,
     q0       => int_cfg_pulse_sequence_timer_width_0_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_timer_width_0_address1,
     ce1      => int_cfg_pulse_sequence_timer_width_0_ce1,
     we1      => int_cfg_pulse_sequence_timer_width_0_we1,
     be1      => int_cfg_pulse_sequence_timer_width_0_be1,
     d1       => int_cfg_pulse_sequence_timer_width_0_d1,
     q1       => int_cfg_pulse_sequence_timer_width_0_q1);
-- int_cfg_pulse_sequence_timer_width_1
int_cfg_pulse_sequence_timer_width_1 : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_timer_width_1_address0,
     ce0      => int_cfg_pulse_sequence_timer_width_1_ce0,
     we0      => int_cfg_pulse_sequence_timer_width_1_we0,
     be0      => int_cfg_pulse_sequence_timer_width_1_be0,
     d0       => int_cfg_pulse_sequence_timer_width_1_d0,
     q0       => int_cfg_pulse_sequence_timer_width_1_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_timer_width_1_address1,
     ce1      => int_cfg_pulse_sequence_timer_width_1_ce1,
     we1      => int_cfg_pulse_sequence_timer_width_1_we1,
     be1      => int_cfg_pulse_sequence_timer_width_1_be1,
     d1       => int_cfg_pulse_sequence_timer_width_1_d1,
     q1       => int_cfg_pulse_sequence_timer_width_1_q1);
-- int_cfg_pulse_sequence_timer_width_2
int_cfg_pulse_sequence_timer_width_2 : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_timer_width_2_address0,
     ce0      => int_cfg_pulse_sequence_timer_width_2_ce0,
     we0      => int_cfg_pulse_sequence_timer_width_2_we0,
     be0      => int_cfg_pulse_sequence_timer_width_2_be0,
     d0       => int_cfg_pulse_sequence_timer_width_2_d0,
     q0       => int_cfg_pulse_sequence_timer_width_2_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_timer_width_2_address1,
     ce1      => int_cfg_pulse_sequence_timer_width_2_ce1,
     we1      => int_cfg_pulse_sequence_timer_width_2_we1,
     be1      => int_cfg_pulse_sequence_timer_width_2_be1,
     d1       => int_cfg_pulse_sequence_timer_width_2_d1,
     q1       => int_cfg_pulse_sequence_timer_width_2_q1);
-- int_cfg_pulse_sequence_timer_width_3
int_cfg_pulse_sequence_timer_width_3 : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_timer_width_3_address0,
     ce0      => int_cfg_pulse_sequence_timer_width_3_ce0,
     we0      => int_cfg_pulse_sequence_timer_width_3_we0,
     be0      => int_cfg_pulse_sequence_timer_width_3_be0,
     d0       => int_cfg_pulse_sequence_timer_width_3_d0,
     q0       => int_cfg_pulse_sequence_timer_width_3_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_timer_width_3_address1,
     ce1      => int_cfg_pulse_sequence_timer_width_3_ce1,
     we1      => int_cfg_pulse_sequence_timer_width_3_we1,
     be1      => int_cfg_pulse_sequence_timer_width_3_be1,
     d1       => int_cfg_pulse_sequence_timer_width_3_d1,
     q1       => int_cfg_pulse_sequence_timer_width_3_q1);
-- int_cfg_pulse_sequence_timer_width_4
int_cfg_pulse_sequence_timer_width_4 : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_timer_width_4_address0,
     ce0      => int_cfg_pulse_sequence_timer_width_4_ce0,
     we0      => int_cfg_pulse_sequence_timer_width_4_we0,
     be0      => int_cfg_pulse_sequence_timer_width_4_be0,
     d0       => int_cfg_pulse_sequence_timer_width_4_d0,
     q0       => int_cfg_pulse_sequence_timer_width_4_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_timer_width_4_address1,
     ce1      => int_cfg_pulse_sequence_timer_width_4_ce1,
     we1      => int_cfg_pulse_sequence_timer_width_4_we1,
     be1      => int_cfg_pulse_sequence_timer_width_4_be1,
     d1       => int_cfg_pulse_sequence_timer_width_4_d1,
     q1       => int_cfg_pulse_sequence_timer_width_4_q1);
-- int_cfg_pulse_sequence_timer_width_5
int_cfg_pulse_sequence_timer_width_5 : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_timer_width_5_address0,
     ce0      => int_cfg_pulse_sequence_timer_width_5_ce0,
     we0      => int_cfg_pulse_sequence_timer_width_5_we0,
     be0      => int_cfg_pulse_sequence_timer_width_5_be0,
     d0       => int_cfg_pulse_sequence_timer_width_5_d0,
     q0       => int_cfg_pulse_sequence_timer_width_5_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_timer_width_5_address1,
     ce1      => int_cfg_pulse_sequence_timer_width_5_ce1,
     we1      => int_cfg_pulse_sequence_timer_width_5_we1,
     be1      => int_cfg_pulse_sequence_timer_width_5_be1,
     d1       => int_cfg_pulse_sequence_timer_width_5_d1,
     q1       => int_cfg_pulse_sequence_timer_width_5_q1);
-- int_cfg_pulse_sequence_timer_width_6
int_cfg_pulse_sequence_timer_width_6 : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_timer_width_6_address0,
     ce0      => int_cfg_pulse_sequence_timer_width_6_ce0,
     we0      => int_cfg_pulse_sequence_timer_width_6_we0,
     be0      => int_cfg_pulse_sequence_timer_width_6_be0,
     d0       => int_cfg_pulse_sequence_timer_width_6_d0,
     q0       => int_cfg_pulse_sequence_timer_width_6_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_timer_width_6_address1,
     ce1      => int_cfg_pulse_sequence_timer_width_6_ce1,
     we1      => int_cfg_pulse_sequence_timer_width_6_we1,
     be1      => int_cfg_pulse_sequence_timer_width_6_be1,
     d1       => int_cfg_pulse_sequence_timer_width_6_d1,
     q1       => int_cfg_pulse_sequence_timer_width_6_q1);
-- int_cfg_pulse_sequence_timer_width_7
int_cfg_pulse_sequence_timer_width_7 : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 32,
     AWIDTH   => log2(32))
port map (
     clk0     => ACLK,
     address0 => int_cfg_pulse_sequence_timer_width_7_address0,
     ce0      => int_cfg_pulse_sequence_timer_width_7_ce0,
     we0      => int_cfg_pulse_sequence_timer_width_7_we0,
     be0      => int_cfg_pulse_sequence_timer_width_7_be0,
     d0       => int_cfg_pulse_sequence_timer_width_7_d0,
     q0       => int_cfg_pulse_sequence_timer_width_7_q0,
     clk1     => ACLK,
     address1 => int_cfg_pulse_sequence_timer_width_7_address1,
     ce1      => int_cfg_pulse_sequence_timer_width_7_ce1,
     we1      => int_cfg_pulse_sequence_timer_width_7_we1,
     be1      => int_cfg_pulse_sequence_timer_width_7_be1,
     d1       => int_cfg_pulse_sequence_timer_width_7_d1,
     q1       => int_cfg_pulse_sequence_timer_width_7_q1);
-- int_cfg_filter_coefs_ch0
int_cfg_filter_coefs_ch0 : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 384,
     AWIDTH   => log2(384))
port map (
     clk0     => ACLK,
     address0 => int_cfg_filter_coefs_ch0_address0,
     ce0      => int_cfg_filter_coefs_ch0_ce0,
     we0      => int_cfg_filter_coefs_ch0_we0,
     be0      => int_cfg_filter_coefs_ch0_be0,
     d0       => int_cfg_filter_coefs_ch0_d0,
     q0       => int_cfg_filter_coefs_ch0_q0,
     clk1     => ACLK,
     address1 => int_cfg_filter_coefs_ch0_address1,
     ce1      => int_cfg_filter_coefs_ch0_ce1,
     we1      => int_cfg_filter_coefs_ch0_we1,
     be1      => int_cfg_filter_coefs_ch0_be1,
     d1       => int_cfg_filter_coefs_ch0_d1,
     q1       => int_cfg_filter_coefs_ch0_q1);
-- int_cfg_filter_coefs_ch1
int_cfg_filter_coefs_ch1 : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 384,
     AWIDTH   => log2(384))
port map (
     clk0     => ACLK,
     address0 => int_cfg_filter_coefs_ch1_address0,
     ce0      => int_cfg_filter_coefs_ch1_ce0,
     we0      => int_cfg_filter_coefs_ch1_we0,
     be0      => int_cfg_filter_coefs_ch1_be0,
     d0       => int_cfg_filter_coefs_ch1_d0,
     q0       => int_cfg_filter_coefs_ch1_q0,
     clk1     => ACLK,
     address1 => int_cfg_filter_coefs_ch1_address1,
     ce1      => int_cfg_filter_coefs_ch1_ce1,
     we1      => int_cfg_filter_coefs_ch1_we1,
     be1      => int_cfg_filter_coefs_ch1_be1,
     d1       => int_cfg_filter_coefs_ch1_d1,
     q1       => int_cfg_filter_coefs_ch1_q1);
-- int_cfg_filter_coefs_ch2
int_cfg_filter_coefs_ch2 : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 384,
     AWIDTH   => log2(384))
port map (
     clk0     => ACLK,
     address0 => int_cfg_filter_coefs_ch2_address0,
     ce0      => int_cfg_filter_coefs_ch2_ce0,
     we0      => int_cfg_filter_coefs_ch2_we0,
     be0      => int_cfg_filter_coefs_ch2_be0,
     d0       => int_cfg_filter_coefs_ch2_d0,
     q0       => int_cfg_filter_coefs_ch2_q0,
     clk1     => ACLK,
     address1 => int_cfg_filter_coefs_ch2_address1,
     ce1      => int_cfg_filter_coefs_ch2_ce1,
     we1      => int_cfg_filter_coefs_ch2_we1,
     be1      => int_cfg_filter_coefs_ch2_be1,
     d1       => int_cfg_filter_coefs_ch2_d1,
     q1       => int_cfg_filter_coefs_ch2_q1);
-- int_cfg_phase_samples
int_cfg_phase_samples : hcr_controller_cfg_bus_s_axi_ram
generic map (
     BYTES    => 4,
     DEPTH    => 65536,
     AWIDTH   => log2(65536))
port map (
     clk0     => ACLK,
     address0 => int_cfg_phase_samples_address0,
     ce0      => int_cfg_phase_samples_ce0,
     we0      => int_cfg_phase_samples_we0,
     be0      => int_cfg_phase_samples_be0,
     d0       => int_cfg_phase_samples_d0,
     q0       => int_cfg_phase_samples_q0,
     clk1     => ACLK,
     address1 => int_cfg_phase_samples_address1,
     ce1      => int_cfg_phase_samples_ce1,
     we1      => int_cfg_phase_samples_we1,
     be1      => int_cfg_phase_samples_be1,
     d1       => int_cfg_phase_samples_d1,
     q1       => int_cfg_phase_samples_q1);

-- ----------------------- AXI WRITE ---------------------
    AWREADY_t <=  '1' when wstate = wridle else '0';
    AWREADY   <=  AWREADY_t;
    WREADY_t  <=  '1' when wstate = wrdata else '0';
    WREADY    <=  WREADY_t;
    BRESP     <=  "00";  -- OKAY
    BVALID    <=  '1' when wstate = wrresp else '0';
    wmask     <=  (31 downto 24 => WSTRB(3), 23 downto 16 => WSTRB(2), 15 downto 8 => WSTRB(1), 7 downto 0 => WSTRB(0));
    aw_hs     <=  AWVALID and AWREADY_t;
    w_hs      <=  WVALID and WREADY_t;

    -- write FSM
    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                wstate <= wrreset;
            elsif (ACLK_EN = '1') then
                wstate <= wnext;
            end if;
        end if;
    end process;

    process (wstate, AWVALID, WVALID, BREADY)
    begin
        case (wstate) is
        when wridle =>
            if (AWVALID = '1') then
                wnext <= wrdata;
            else
                wnext <= wridle;
            end if;
        when wrdata =>
            if (WVALID = '1') then
                wnext <= wrresp;
            else
                wnext <= wrdata;
            end if;
        when wrresp =>
            if (BREADY = '1') then
                wnext <= wridle;
            else
                wnext <= wrresp;
            end if;
        when others =>
            wnext <= wridle;
        end case;
    end process;

    waddr_proc : process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (aw_hs = '1') then
                    waddr <= UNSIGNED(AWADDR(ADDR_BITS-1 downto 0));
                end if;
            end if;
        end if;
    end process;

-- ----------------------- AXI READ ----------------------
    ARREADY_t <= '1' when (rstate = rdidle) else '0';
    ARREADY <= ARREADY_t;
    RDATA   <= STD_LOGIC_VECTOR(rdata_data);
    RRESP   <= "00";  -- OKAY
    RVALID_t  <= '1' when (rstate = rddata) and (int_cfg_pulse_sequence_prt_0_read = '0') and (int_cfg_pulse_sequence_prt_1_read = '0') and (int_cfg_pulse_sequence_num_pulses_read = '0') and (int_cfg_pulse_sequence_block_post_time_read = '0') and (int_cfg_pulse_sequence_control_flags_read = '0') and (int_cfg_pulse_sequence_polarization_mode_read = '0') and (int_cfg_pulse_sequence_filter_select_ch0_read = '0') and (int_cfg_pulse_sequence_filter_select_ch1_read = '0') and (int_cfg_pulse_sequence_filter_select_ch2_read = '0') and (int_cfg_pulse_sequence_phase_table_begin_read = '0') and (int_cfg_pulse_sequence_phase_table_end_read = '0') and (int_cfg_pulse_sequence_timer_offset_0_read = '0') and (int_cfg_pulse_sequence_timer_offset_1_read = '0') and (int_cfg_pulse_sequence_timer_offset_2_read = '0') and (int_cfg_pulse_sequence_timer_offset_3_read = '0') and (int_cfg_pulse_sequence_timer_offset_4_read = '0') and (int_cfg_pulse_sequence_timer_offset_5_read = '0') and (int_cfg_pulse_sequence_timer_offset_6_read = '0') and (int_cfg_pulse_sequence_timer_offset_7_read = '0') and (int_cfg_pulse_sequence_timer_width_0_read = '0') and (int_cfg_pulse_sequence_timer_width_1_read = '0') and (int_cfg_pulse_sequence_timer_width_2_read = '0') and (int_cfg_pulse_sequence_timer_width_3_read = '0') and (int_cfg_pulse_sequence_timer_width_4_read = '0') and (int_cfg_pulse_sequence_timer_width_5_read = '0') and (int_cfg_pulse_sequence_timer_width_6_read = '0') and (int_cfg_pulse_sequence_timer_width_7_read = '0') and (int_cfg_filter_coefs_ch0_read = '0') and (int_cfg_filter_coefs_ch1_read = '0') and (int_cfg_filter_coefs_ch2_read = '0') and (int_cfg_phase_samples_read = '0') else '0';
    RVALID    <= RVALID_t;
    ar_hs   <= ARVALID and ARREADY_t;
    raddr   <= UNSIGNED(ARADDR(ADDR_BITS-1 downto 0));

    -- read FSM
    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                rstate <= rdreset;
            elsif (ACLK_EN = '1') then
                rstate <= rnext;
            end if;
        end if;
    end process;

    process (rstate, ARVALID, RREADY, RVALID_t)
    begin
        case (rstate) is
        when rdidle =>
            if (ARVALID = '1') then
                rnext <= rddata;
            else
                rnext <= rdidle;
            end if;
        when rddata =>
            if (RREADY = '1' and RVALID_t = '1') then
                rnext <= rdidle;
            else
                rnext <= rddata;
            end if;
        when others =>
            rnext <= rdidle;
        end case;
    end process;

    rdata_proc : process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (ar_hs = '1') then
                    case (TO_INTEGER(raddr)) is
                    when ADDR_AP_CTRL =>
                        rdata_data <= (7 => int_auto_restart, 3 => int_ap_ready, 2 => int_ap_idle, 1 => int_ap_done, 0 => int_ap_start, others => '0');
                    when ADDR_GIE =>
                        rdata_data <= (0 => int_gie, others => '0');
                    when ADDR_IER =>
                        rdata_data <= (1 => int_ier(1), 0 => int_ier(0), others => '0');
                    when ADDR_ISR =>
                        rdata_data <= (1 => int_isr(1), 0 => int_isr(0), others => '0');
                    when ADDR_CFG_PULSE_SEQUENCE_START_STOP_INDEXES_DATA_0 =>
                        rdata_data <= RESIZE(int_cfg_pulse_sequence_start_stop_indexes(31 downto 0), 32);
                    when ADDR_CFG_NUM_PULSES_TO_EXECUTE_DATA_0 =>
                        rdata_data <= RESIZE(int_cfg_num_pulses_to_execute(31 downto 0), 32);
                    when ADDR_CFG_TOTAL_DECIMATION_DATA_0 =>
                        rdata_data <= RESIZE(int_cfg_total_decimation(31 downto 0), 32);
                    when ADDR_CFG_POST_DECIMATION_DATA_0 =>
                        rdata_data <= RESIZE(int_cfg_post_decimation(31 downto 0), 32);
                    when ADDR_CFG_NUM_PULSES_PER_XFER_DATA_0 =>
                        rdata_data <= RESIZE(int_cfg_num_pulses_per_xfer(31 downto 0), 32);
                    when ADDR_CFG_ENABLED_CHANNEL_VECTOR_DATA_0 =>
                        rdata_data <= RESIZE(int_cfg_enabled_channel_vector(31 downto 0), 32);
                    when ADDR_CFG_WATCHDOG_DATA_0 =>
                        rdata_data <= RESIZE(int_cfg_watchdog(31 downto 0), 32);
                    when ADDR_CFG_USE_MAG_PHASE_DATA_0 =>
                        rdata_data <= RESIZE(int_cfg_use_mag_phase(31 downto 0), 32);
                    when others =>
                        rdata_data <= (others => '0');
                    end case;
                elsif (int_cfg_pulse_sequence_prt_0_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_prt_0_q1;
                elsif (int_cfg_pulse_sequence_prt_1_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_prt_1_q1;
                elsif (int_cfg_pulse_sequence_num_pulses_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_num_pulses_q1;
                elsif (int_cfg_pulse_sequence_block_post_time_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_block_post_time_q1;
                elsif (int_cfg_pulse_sequence_control_flags_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_control_flags_q1;
                elsif (int_cfg_pulse_sequence_polarization_mode_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_polarization_mode_q1;
                elsif (int_cfg_pulse_sequence_filter_select_ch0_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_filter_select_ch0_q1;
                elsif (int_cfg_pulse_sequence_filter_select_ch1_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_filter_select_ch1_q1;
                elsif (int_cfg_pulse_sequence_filter_select_ch2_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_filter_select_ch2_q1;
                elsif (int_cfg_pulse_sequence_phase_table_begin_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_phase_table_begin_q1;
                elsif (int_cfg_pulse_sequence_phase_table_end_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_phase_table_end_q1;
                elsif (int_cfg_pulse_sequence_timer_offset_0_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_timer_offset_0_q1;
                elsif (int_cfg_pulse_sequence_timer_offset_1_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_timer_offset_1_q1;
                elsif (int_cfg_pulse_sequence_timer_offset_2_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_timer_offset_2_q1;
                elsif (int_cfg_pulse_sequence_timer_offset_3_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_timer_offset_3_q1;
                elsif (int_cfg_pulse_sequence_timer_offset_4_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_timer_offset_4_q1;
                elsif (int_cfg_pulse_sequence_timer_offset_5_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_timer_offset_5_q1;
                elsif (int_cfg_pulse_sequence_timer_offset_6_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_timer_offset_6_q1;
                elsif (int_cfg_pulse_sequence_timer_offset_7_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_timer_offset_7_q1;
                elsif (int_cfg_pulse_sequence_timer_width_0_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_timer_width_0_q1;
                elsif (int_cfg_pulse_sequence_timer_width_1_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_timer_width_1_q1;
                elsif (int_cfg_pulse_sequence_timer_width_2_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_timer_width_2_q1;
                elsif (int_cfg_pulse_sequence_timer_width_3_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_timer_width_3_q1;
                elsif (int_cfg_pulse_sequence_timer_width_4_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_timer_width_4_q1;
                elsif (int_cfg_pulse_sequence_timer_width_5_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_timer_width_5_q1;
                elsif (int_cfg_pulse_sequence_timer_width_6_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_timer_width_6_q1;
                elsif (int_cfg_pulse_sequence_timer_width_7_read = '1') then
                    rdata_data <= int_cfg_pulse_sequence_timer_width_7_q1;
                elsif (int_cfg_filter_coefs_ch0_read = '1') then
                    rdata_data <= int_cfg_filter_coefs_ch0_q1;
                elsif (int_cfg_filter_coefs_ch1_read = '1') then
                    rdata_data <= int_cfg_filter_coefs_ch1_q1;
                elsif (int_cfg_filter_coefs_ch2_read = '1') then
                    rdata_data <= int_cfg_filter_coefs_ch2_q1;
                elsif (int_cfg_phase_samples_read = '1') then
                    rdata_data <= int_cfg_phase_samples_q1;
                end if;
            end if;
        end if;
    end process;

-- ----------------------- Register logic ----------------
    interrupt            <= int_gie and (int_isr(0) or int_isr(1));
    ap_start             <= int_ap_start;
    cfg_pulse_sequence_start_stop_indexes <= STD_LOGIC_VECTOR(int_cfg_pulse_sequence_start_stop_indexes);
    cfg_num_pulses_to_execute <= STD_LOGIC_VECTOR(int_cfg_num_pulses_to_execute);
    cfg_total_decimation <= STD_LOGIC_VECTOR(int_cfg_total_decimation);
    cfg_post_decimation  <= STD_LOGIC_VECTOR(int_cfg_post_decimation);
    cfg_num_pulses_per_xfer <= STD_LOGIC_VECTOR(int_cfg_num_pulses_per_xfer);
    cfg_enabled_channel_vector <= STD_LOGIC_VECTOR(int_cfg_enabled_channel_vector);
    cfg_watchdog         <= STD_LOGIC_VECTOR(int_cfg_watchdog);
    cfg_use_mag_phase    <= STD_LOGIC_VECTOR(int_cfg_use_mag_phase);

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_ap_start <= '0';
            elsif (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_AP_CTRL and WSTRB(0) = '1' and WDATA(0) = '1') then
                    int_ap_start <= '1';
                elsif (ap_ready = '1') then
                    int_ap_start <= int_auto_restart; -- clear on handshake/auto restart
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_ap_done <= '0';
            elsif (ACLK_EN = '1') then
                if (ap_done = '1') then
                    int_ap_done <= '1';
                elsif (ar_hs = '1' and raddr = ADDR_AP_CTRL) then
                    int_ap_done <= '0'; -- clear on read
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_ap_idle <= '0';
            elsif (ACLK_EN = '1') then
                if (true) then
                    int_ap_idle <= ap_idle;
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_ap_ready <= '0';
            elsif (ACLK_EN = '1') then
                if (true) then
                    int_ap_ready <= ap_ready;
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_auto_restart <= '0';
            elsif (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_AP_CTRL and WSTRB(0) = '1') then
                    int_auto_restart <= WDATA(7);
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_gie <= '0';
            elsif (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_GIE and WSTRB(0) = '1') then
                    int_gie <= WDATA(0);
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_ier <= "00";
            elsif (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_IER and WSTRB(0) = '1') then
                    int_ier <= UNSIGNED(WDATA(1 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_isr(0) <= '0';
            elsif (ACLK_EN = '1') then
                if (int_ier(0) = '1' and ap_done = '1') then
                    int_isr(0) <= '1';
                elsif (w_hs = '1' and waddr = ADDR_ISR and WSTRB(0) = '1') then
                    int_isr(0) <= int_isr(0) xor WDATA(0); -- toggle on write
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_isr(1) <= '0';
            elsif (ACLK_EN = '1') then
                if (int_ier(1) = '1' and ap_ready = '1') then
                    int_isr(1) <= '1';
                elsif (w_hs = '1' and waddr = ADDR_ISR and WSTRB(0) = '1') then
                    int_isr(1) <= int_isr(1) xor WDATA(1); -- toggle on write
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_CFG_PULSE_SEQUENCE_START_STOP_INDEXES_DATA_0) then
                    int_cfg_pulse_sequence_start_stop_indexes(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_cfg_pulse_sequence_start_stop_indexes(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_CFG_NUM_PULSES_TO_EXECUTE_DATA_0) then
                    int_cfg_num_pulses_to_execute(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_cfg_num_pulses_to_execute(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_CFG_TOTAL_DECIMATION_DATA_0) then
                    int_cfg_total_decimation(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_cfg_total_decimation(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_CFG_POST_DECIMATION_DATA_0) then
                    int_cfg_post_decimation(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_cfg_post_decimation(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_CFG_NUM_PULSES_PER_XFER_DATA_0) then
                    int_cfg_num_pulses_per_xfer(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_cfg_num_pulses_per_xfer(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_CFG_ENABLED_CHANNEL_VECTOR_DATA_0) then
                    int_cfg_enabled_channel_vector(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_cfg_enabled_channel_vector(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_CFG_WATCHDOG_DATA_0) then
                    int_cfg_watchdog(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_cfg_watchdog(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_CFG_USE_MAG_PHASE_DATA_0) then
                    int_cfg_use_mag_phase(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_cfg_use_mag_phase(31 downto 0));
                end if;
            end if;
        end if;
    end process;


-- ----------------------- Memory logic ------------------
    -- cfg_pulse_sequence_prt_0
    int_cfg_pulse_sequence_prt_0_address0 <= UNSIGNED(cfg_pulse_sequence_prt_0_address0);
    int_cfg_pulse_sequence_prt_0_ce0 <= cfg_pulse_sequence_prt_0_ce0;
    int_cfg_pulse_sequence_prt_0_we0 <= '0';
    int_cfg_pulse_sequence_prt_0_be0 <= (others => '0');
    int_cfg_pulse_sequence_prt_0_d0 <= (others => '0');
    cfg_pulse_sequence_prt_0_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_prt_0_q0, 32));
    int_cfg_pulse_sequence_prt_0_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_prt_0_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_prt_0_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_prt_0_we1 <= '1' when int_cfg_pulse_sequence_prt_0_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_prt_0_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_prt_0_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_prt_1
    int_cfg_pulse_sequence_prt_1_address0 <= UNSIGNED(cfg_pulse_sequence_prt_1_address0);
    int_cfg_pulse_sequence_prt_1_ce0 <= cfg_pulse_sequence_prt_1_ce0;
    int_cfg_pulse_sequence_prt_1_we0 <= '0';
    int_cfg_pulse_sequence_prt_1_be0 <= (others => '0');
    int_cfg_pulse_sequence_prt_1_d0 <= (others => '0');
    cfg_pulse_sequence_prt_1_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_prt_1_q0, 32));
    int_cfg_pulse_sequence_prt_1_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_prt_1_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_prt_1_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_prt_1_we1 <= '1' when int_cfg_pulse_sequence_prt_1_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_prt_1_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_prt_1_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_num_pulses
    int_cfg_pulse_sequence_num_pulses_address0 <= UNSIGNED(cfg_pulse_sequence_num_pulses_address0);
    int_cfg_pulse_sequence_num_pulses_ce0 <= cfg_pulse_sequence_num_pulses_ce0;
    int_cfg_pulse_sequence_num_pulses_we0 <= '0';
    int_cfg_pulse_sequence_num_pulses_be0 <= (others => '0');
    int_cfg_pulse_sequence_num_pulses_d0 <= (others => '0');
    cfg_pulse_sequence_num_pulses_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_num_pulses_q0, 32));
    int_cfg_pulse_sequence_num_pulses_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_num_pulses_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_num_pulses_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_num_pulses_we1 <= '1' when int_cfg_pulse_sequence_num_pulses_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_num_pulses_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_num_pulses_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_block_post_time
    int_cfg_pulse_sequence_block_post_time_address0 <= UNSIGNED(cfg_pulse_sequence_block_post_time_address0);
    int_cfg_pulse_sequence_block_post_time_ce0 <= cfg_pulse_sequence_block_post_time_ce0;
    int_cfg_pulse_sequence_block_post_time_we0 <= '0';
    int_cfg_pulse_sequence_block_post_time_be0 <= (others => '0');
    int_cfg_pulse_sequence_block_post_time_d0 <= (others => '0');
    cfg_pulse_sequence_block_post_time_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_block_post_time_q0, 32));
    int_cfg_pulse_sequence_block_post_time_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_block_post_time_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_block_post_time_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_block_post_time_we1 <= '1' when int_cfg_pulse_sequence_block_post_time_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_block_post_time_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_block_post_time_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_control_flags
    int_cfg_pulse_sequence_control_flags_address0 <= UNSIGNED(cfg_pulse_sequence_control_flags_address0);
    int_cfg_pulse_sequence_control_flags_ce0 <= cfg_pulse_sequence_control_flags_ce0;
    int_cfg_pulse_sequence_control_flags_we0 <= '0';
    int_cfg_pulse_sequence_control_flags_be0 <= (others => '0');
    int_cfg_pulse_sequence_control_flags_d0 <= (others => '0');
    cfg_pulse_sequence_control_flags_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_control_flags_q0, 32));
    int_cfg_pulse_sequence_control_flags_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_control_flags_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_control_flags_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_control_flags_we1 <= '1' when int_cfg_pulse_sequence_control_flags_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_control_flags_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_control_flags_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_polarization_mode
    int_cfg_pulse_sequence_polarization_mode_address0 <= UNSIGNED(cfg_pulse_sequence_polarization_mode_address0);
    int_cfg_pulse_sequence_polarization_mode_ce0 <= cfg_pulse_sequence_polarization_mode_ce0;
    int_cfg_pulse_sequence_polarization_mode_we0 <= '0';
    int_cfg_pulse_sequence_polarization_mode_be0 <= (others => '0');
    int_cfg_pulse_sequence_polarization_mode_d0 <= (others => '0');
    cfg_pulse_sequence_polarization_mode_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_polarization_mode_q0, 32));
    int_cfg_pulse_sequence_polarization_mode_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_polarization_mode_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_polarization_mode_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_polarization_mode_we1 <= '1' when int_cfg_pulse_sequence_polarization_mode_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_polarization_mode_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_polarization_mode_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_filter_select_ch0
    int_cfg_pulse_sequence_filter_select_ch0_address0 <= UNSIGNED(cfg_pulse_sequence_filter_select_ch0_address0);
    int_cfg_pulse_sequence_filter_select_ch0_ce0 <= cfg_pulse_sequence_filter_select_ch0_ce0;
    int_cfg_pulse_sequence_filter_select_ch0_we0 <= '0';
    int_cfg_pulse_sequence_filter_select_ch0_be0 <= (others => '0');
    int_cfg_pulse_sequence_filter_select_ch0_d0 <= (others => '0');
    cfg_pulse_sequence_filter_select_ch0_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_filter_select_ch0_q0, 32));
    int_cfg_pulse_sequence_filter_select_ch0_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_filter_select_ch0_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_filter_select_ch0_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_filter_select_ch0_we1 <= '1' when int_cfg_pulse_sequence_filter_select_ch0_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_filter_select_ch0_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_filter_select_ch0_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_filter_select_ch1
    int_cfg_pulse_sequence_filter_select_ch1_address0 <= UNSIGNED(cfg_pulse_sequence_filter_select_ch1_address0);
    int_cfg_pulse_sequence_filter_select_ch1_ce0 <= cfg_pulse_sequence_filter_select_ch1_ce0;
    int_cfg_pulse_sequence_filter_select_ch1_we0 <= '0';
    int_cfg_pulse_sequence_filter_select_ch1_be0 <= (others => '0');
    int_cfg_pulse_sequence_filter_select_ch1_d0 <= (others => '0');
    cfg_pulse_sequence_filter_select_ch1_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_filter_select_ch1_q0, 32));
    int_cfg_pulse_sequence_filter_select_ch1_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_filter_select_ch1_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_filter_select_ch1_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_filter_select_ch1_we1 <= '1' when int_cfg_pulse_sequence_filter_select_ch1_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_filter_select_ch1_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_filter_select_ch1_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_filter_select_ch2
    int_cfg_pulse_sequence_filter_select_ch2_address0 <= UNSIGNED(cfg_pulse_sequence_filter_select_ch2_address0);
    int_cfg_pulse_sequence_filter_select_ch2_ce0 <= cfg_pulse_sequence_filter_select_ch2_ce0;
    int_cfg_pulse_sequence_filter_select_ch2_we0 <= '0';
    int_cfg_pulse_sequence_filter_select_ch2_be0 <= (others => '0');
    int_cfg_pulse_sequence_filter_select_ch2_d0 <= (others => '0');
    cfg_pulse_sequence_filter_select_ch2_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_filter_select_ch2_q0, 32));
    int_cfg_pulse_sequence_filter_select_ch2_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_filter_select_ch2_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_filter_select_ch2_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_filter_select_ch2_we1 <= '1' when int_cfg_pulse_sequence_filter_select_ch2_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_filter_select_ch2_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_filter_select_ch2_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_phase_table_begin
    int_cfg_pulse_sequence_phase_table_begin_address0 <= UNSIGNED(cfg_pulse_sequence_phase_table_begin_address0);
    int_cfg_pulse_sequence_phase_table_begin_ce0 <= cfg_pulse_sequence_phase_table_begin_ce0;
    int_cfg_pulse_sequence_phase_table_begin_we0 <= '0';
    int_cfg_pulse_sequence_phase_table_begin_be0 <= (others => '0');
    int_cfg_pulse_sequence_phase_table_begin_d0 <= (others => '0');
    cfg_pulse_sequence_phase_table_begin_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_phase_table_begin_q0, 32));
    int_cfg_pulse_sequence_phase_table_begin_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_phase_table_begin_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_phase_table_begin_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_phase_table_begin_we1 <= '1' when int_cfg_pulse_sequence_phase_table_begin_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_phase_table_begin_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_phase_table_begin_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_phase_table_end
    int_cfg_pulse_sequence_phase_table_end_address0 <= UNSIGNED(cfg_pulse_sequence_phase_table_end_address0);
    int_cfg_pulse_sequence_phase_table_end_ce0 <= cfg_pulse_sequence_phase_table_end_ce0;
    int_cfg_pulse_sequence_phase_table_end_we0 <= '0';
    int_cfg_pulse_sequence_phase_table_end_be0 <= (others => '0');
    int_cfg_pulse_sequence_phase_table_end_d0 <= (others => '0');
    cfg_pulse_sequence_phase_table_end_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_phase_table_end_q0, 32));
    int_cfg_pulse_sequence_phase_table_end_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_phase_table_end_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_phase_table_end_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_phase_table_end_we1 <= '1' when int_cfg_pulse_sequence_phase_table_end_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_phase_table_end_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_phase_table_end_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_timer_offset_0
    int_cfg_pulse_sequence_timer_offset_0_address0 <= UNSIGNED(cfg_pulse_sequence_timer_offset_0_address0);
    int_cfg_pulse_sequence_timer_offset_0_ce0 <= cfg_pulse_sequence_timer_offset_0_ce0;
    int_cfg_pulse_sequence_timer_offset_0_we0 <= '0';
    int_cfg_pulse_sequence_timer_offset_0_be0 <= (others => '0');
    int_cfg_pulse_sequence_timer_offset_0_d0 <= (others => '0');
    cfg_pulse_sequence_timer_offset_0_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_timer_offset_0_q0, 32));
    int_cfg_pulse_sequence_timer_offset_0_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_timer_offset_0_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_timer_offset_0_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_timer_offset_0_we1 <= '1' when int_cfg_pulse_sequence_timer_offset_0_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_timer_offset_0_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_timer_offset_0_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_timer_offset_1
    int_cfg_pulse_sequence_timer_offset_1_address0 <= UNSIGNED(cfg_pulse_sequence_timer_offset_1_address0);
    int_cfg_pulse_sequence_timer_offset_1_ce0 <= cfg_pulse_sequence_timer_offset_1_ce0;
    int_cfg_pulse_sequence_timer_offset_1_we0 <= '0';
    int_cfg_pulse_sequence_timer_offset_1_be0 <= (others => '0');
    int_cfg_pulse_sequence_timer_offset_1_d0 <= (others => '0');
    cfg_pulse_sequence_timer_offset_1_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_timer_offset_1_q0, 32));
    int_cfg_pulse_sequence_timer_offset_1_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_timer_offset_1_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_timer_offset_1_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_timer_offset_1_we1 <= '1' when int_cfg_pulse_sequence_timer_offset_1_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_timer_offset_1_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_timer_offset_1_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_timer_offset_2
    int_cfg_pulse_sequence_timer_offset_2_address0 <= UNSIGNED(cfg_pulse_sequence_timer_offset_2_address0);
    int_cfg_pulse_sequence_timer_offset_2_ce0 <= cfg_pulse_sequence_timer_offset_2_ce0;
    int_cfg_pulse_sequence_timer_offset_2_we0 <= '0';
    int_cfg_pulse_sequence_timer_offset_2_be0 <= (others => '0');
    int_cfg_pulse_sequence_timer_offset_2_d0 <= (others => '0');
    cfg_pulse_sequence_timer_offset_2_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_timer_offset_2_q0, 32));
    int_cfg_pulse_sequence_timer_offset_2_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_timer_offset_2_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_timer_offset_2_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_timer_offset_2_we1 <= '1' when int_cfg_pulse_sequence_timer_offset_2_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_timer_offset_2_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_timer_offset_2_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_timer_offset_3
    int_cfg_pulse_sequence_timer_offset_3_address0 <= UNSIGNED(cfg_pulse_sequence_timer_offset_3_address0);
    int_cfg_pulse_sequence_timer_offset_3_ce0 <= cfg_pulse_sequence_timer_offset_3_ce0;
    int_cfg_pulse_sequence_timer_offset_3_we0 <= '0';
    int_cfg_pulse_sequence_timer_offset_3_be0 <= (others => '0');
    int_cfg_pulse_sequence_timer_offset_3_d0 <= (others => '0');
    cfg_pulse_sequence_timer_offset_3_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_timer_offset_3_q0, 32));
    int_cfg_pulse_sequence_timer_offset_3_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_timer_offset_3_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_timer_offset_3_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_timer_offset_3_we1 <= '1' when int_cfg_pulse_sequence_timer_offset_3_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_timer_offset_3_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_timer_offset_3_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_timer_offset_4
    int_cfg_pulse_sequence_timer_offset_4_address0 <= UNSIGNED(cfg_pulse_sequence_timer_offset_4_address0);
    int_cfg_pulse_sequence_timer_offset_4_ce0 <= cfg_pulse_sequence_timer_offset_4_ce0;
    int_cfg_pulse_sequence_timer_offset_4_we0 <= '0';
    int_cfg_pulse_sequence_timer_offset_4_be0 <= (others => '0');
    int_cfg_pulse_sequence_timer_offset_4_d0 <= (others => '0');
    cfg_pulse_sequence_timer_offset_4_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_timer_offset_4_q0, 32));
    int_cfg_pulse_sequence_timer_offset_4_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_timer_offset_4_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_timer_offset_4_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_timer_offset_4_we1 <= '1' when int_cfg_pulse_sequence_timer_offset_4_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_timer_offset_4_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_timer_offset_4_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_timer_offset_5
    int_cfg_pulse_sequence_timer_offset_5_address0 <= UNSIGNED(cfg_pulse_sequence_timer_offset_5_address0);
    int_cfg_pulse_sequence_timer_offset_5_ce0 <= cfg_pulse_sequence_timer_offset_5_ce0;
    int_cfg_pulse_sequence_timer_offset_5_we0 <= '0';
    int_cfg_pulse_sequence_timer_offset_5_be0 <= (others => '0');
    int_cfg_pulse_sequence_timer_offset_5_d0 <= (others => '0');
    cfg_pulse_sequence_timer_offset_5_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_timer_offset_5_q0, 32));
    int_cfg_pulse_sequence_timer_offset_5_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_timer_offset_5_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_timer_offset_5_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_timer_offset_5_we1 <= '1' when int_cfg_pulse_sequence_timer_offset_5_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_timer_offset_5_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_timer_offset_5_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_timer_offset_6
    int_cfg_pulse_sequence_timer_offset_6_address0 <= UNSIGNED(cfg_pulse_sequence_timer_offset_6_address0);
    int_cfg_pulse_sequence_timer_offset_6_ce0 <= cfg_pulse_sequence_timer_offset_6_ce0;
    int_cfg_pulse_sequence_timer_offset_6_we0 <= '0';
    int_cfg_pulse_sequence_timer_offset_6_be0 <= (others => '0');
    int_cfg_pulse_sequence_timer_offset_6_d0 <= (others => '0');
    cfg_pulse_sequence_timer_offset_6_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_timer_offset_6_q0, 32));
    int_cfg_pulse_sequence_timer_offset_6_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_timer_offset_6_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_timer_offset_6_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_timer_offset_6_we1 <= '1' when int_cfg_pulse_sequence_timer_offset_6_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_timer_offset_6_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_timer_offset_6_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_timer_offset_7
    int_cfg_pulse_sequence_timer_offset_7_address0 <= UNSIGNED(cfg_pulse_sequence_timer_offset_7_address0);
    int_cfg_pulse_sequence_timer_offset_7_ce0 <= cfg_pulse_sequence_timer_offset_7_ce0;
    int_cfg_pulse_sequence_timer_offset_7_we0 <= '0';
    int_cfg_pulse_sequence_timer_offset_7_be0 <= (others => '0');
    int_cfg_pulse_sequence_timer_offset_7_d0 <= (others => '0');
    cfg_pulse_sequence_timer_offset_7_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_timer_offset_7_q0, 32));
    int_cfg_pulse_sequence_timer_offset_7_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_timer_offset_7_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_timer_offset_7_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_timer_offset_7_we1 <= '1' when int_cfg_pulse_sequence_timer_offset_7_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_timer_offset_7_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_timer_offset_7_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_timer_width_0
    int_cfg_pulse_sequence_timer_width_0_address0 <= UNSIGNED(cfg_pulse_sequence_timer_width_0_address0);
    int_cfg_pulse_sequence_timer_width_0_ce0 <= cfg_pulse_sequence_timer_width_0_ce0;
    int_cfg_pulse_sequence_timer_width_0_we0 <= '0';
    int_cfg_pulse_sequence_timer_width_0_be0 <= (others => '0');
    int_cfg_pulse_sequence_timer_width_0_d0 <= (others => '0');
    cfg_pulse_sequence_timer_width_0_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_timer_width_0_q0, 32));
    int_cfg_pulse_sequence_timer_width_0_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_timer_width_0_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_timer_width_0_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_timer_width_0_we1 <= '1' when int_cfg_pulse_sequence_timer_width_0_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_timer_width_0_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_timer_width_0_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_timer_width_1
    int_cfg_pulse_sequence_timer_width_1_address0 <= UNSIGNED(cfg_pulse_sequence_timer_width_1_address0);
    int_cfg_pulse_sequence_timer_width_1_ce0 <= cfg_pulse_sequence_timer_width_1_ce0;
    int_cfg_pulse_sequence_timer_width_1_we0 <= '0';
    int_cfg_pulse_sequence_timer_width_1_be0 <= (others => '0');
    int_cfg_pulse_sequence_timer_width_1_d0 <= (others => '0');
    cfg_pulse_sequence_timer_width_1_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_timer_width_1_q0, 32));
    int_cfg_pulse_sequence_timer_width_1_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_timer_width_1_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_timer_width_1_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_timer_width_1_we1 <= '1' when int_cfg_pulse_sequence_timer_width_1_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_timer_width_1_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_timer_width_1_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_timer_width_2
    int_cfg_pulse_sequence_timer_width_2_address0 <= UNSIGNED(cfg_pulse_sequence_timer_width_2_address0);
    int_cfg_pulse_sequence_timer_width_2_ce0 <= cfg_pulse_sequence_timer_width_2_ce0;
    int_cfg_pulse_sequence_timer_width_2_we0 <= '0';
    int_cfg_pulse_sequence_timer_width_2_be0 <= (others => '0');
    int_cfg_pulse_sequence_timer_width_2_d0 <= (others => '0');
    cfg_pulse_sequence_timer_width_2_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_timer_width_2_q0, 32));
    int_cfg_pulse_sequence_timer_width_2_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_timer_width_2_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_timer_width_2_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_timer_width_2_we1 <= '1' when int_cfg_pulse_sequence_timer_width_2_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_timer_width_2_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_timer_width_2_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_timer_width_3
    int_cfg_pulse_sequence_timer_width_3_address0 <= UNSIGNED(cfg_pulse_sequence_timer_width_3_address0);
    int_cfg_pulse_sequence_timer_width_3_ce0 <= cfg_pulse_sequence_timer_width_3_ce0;
    int_cfg_pulse_sequence_timer_width_3_we0 <= '0';
    int_cfg_pulse_sequence_timer_width_3_be0 <= (others => '0');
    int_cfg_pulse_sequence_timer_width_3_d0 <= (others => '0');
    cfg_pulse_sequence_timer_width_3_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_timer_width_3_q0, 32));
    int_cfg_pulse_sequence_timer_width_3_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_timer_width_3_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_timer_width_3_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_timer_width_3_we1 <= '1' when int_cfg_pulse_sequence_timer_width_3_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_timer_width_3_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_timer_width_3_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_timer_width_4
    int_cfg_pulse_sequence_timer_width_4_address0 <= UNSIGNED(cfg_pulse_sequence_timer_width_4_address0);
    int_cfg_pulse_sequence_timer_width_4_ce0 <= cfg_pulse_sequence_timer_width_4_ce0;
    int_cfg_pulse_sequence_timer_width_4_we0 <= '0';
    int_cfg_pulse_sequence_timer_width_4_be0 <= (others => '0');
    int_cfg_pulse_sequence_timer_width_4_d0 <= (others => '0');
    cfg_pulse_sequence_timer_width_4_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_timer_width_4_q0, 32));
    int_cfg_pulse_sequence_timer_width_4_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_timer_width_4_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_timer_width_4_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_timer_width_4_we1 <= '1' when int_cfg_pulse_sequence_timer_width_4_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_timer_width_4_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_timer_width_4_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_timer_width_5
    int_cfg_pulse_sequence_timer_width_5_address0 <= UNSIGNED(cfg_pulse_sequence_timer_width_5_address0);
    int_cfg_pulse_sequence_timer_width_5_ce0 <= cfg_pulse_sequence_timer_width_5_ce0;
    int_cfg_pulse_sequence_timer_width_5_we0 <= '0';
    int_cfg_pulse_sequence_timer_width_5_be0 <= (others => '0');
    int_cfg_pulse_sequence_timer_width_5_d0 <= (others => '0');
    cfg_pulse_sequence_timer_width_5_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_timer_width_5_q0, 32));
    int_cfg_pulse_sequence_timer_width_5_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_timer_width_5_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_timer_width_5_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_timer_width_5_we1 <= '1' when int_cfg_pulse_sequence_timer_width_5_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_timer_width_5_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_timer_width_5_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_timer_width_6
    int_cfg_pulse_sequence_timer_width_6_address0 <= UNSIGNED(cfg_pulse_sequence_timer_width_6_address0);
    int_cfg_pulse_sequence_timer_width_6_ce0 <= cfg_pulse_sequence_timer_width_6_ce0;
    int_cfg_pulse_sequence_timer_width_6_we0 <= '0';
    int_cfg_pulse_sequence_timer_width_6_be0 <= (others => '0');
    int_cfg_pulse_sequence_timer_width_6_d0 <= (others => '0');
    cfg_pulse_sequence_timer_width_6_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_timer_width_6_q0, 32));
    int_cfg_pulse_sequence_timer_width_6_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_timer_width_6_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_timer_width_6_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_timer_width_6_we1 <= '1' when int_cfg_pulse_sequence_timer_width_6_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_timer_width_6_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_timer_width_6_d1 <= UNSIGNED(WDATA);
    -- cfg_pulse_sequence_timer_width_7
    int_cfg_pulse_sequence_timer_width_7_address0 <= UNSIGNED(cfg_pulse_sequence_timer_width_7_address0);
    int_cfg_pulse_sequence_timer_width_7_ce0 <= cfg_pulse_sequence_timer_width_7_ce0;
    int_cfg_pulse_sequence_timer_width_7_we0 <= '0';
    int_cfg_pulse_sequence_timer_width_7_be0 <= (others => '0');
    int_cfg_pulse_sequence_timer_width_7_d0 <= (others => '0');
    cfg_pulse_sequence_timer_width_7_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_pulse_sequence_timer_width_7_q0, 32));
    int_cfg_pulse_sequence_timer_width_7_address1 <= raddr(6 downto 2) when ar_hs = '1' else waddr(6 downto 2);
    int_cfg_pulse_sequence_timer_width_7_ce1 <= '1' when ar_hs = '1' or (int_cfg_pulse_sequence_timer_width_7_write = '1' and WVALID  = '1') else '0';
    int_cfg_pulse_sequence_timer_width_7_we1 <= '1' when int_cfg_pulse_sequence_timer_width_7_write = '1' and WVALID = '1' else '0';
    int_cfg_pulse_sequence_timer_width_7_be1 <= UNSIGNED(WSTRB);
    int_cfg_pulse_sequence_timer_width_7_d1 <= UNSIGNED(WDATA);
    -- cfg_filter_coefs_ch0
    int_cfg_filter_coefs_ch0_address0 <= UNSIGNED(cfg_filter_coefs_ch0_address0);
    int_cfg_filter_coefs_ch0_ce0 <= cfg_filter_coefs_ch0_ce0;
    int_cfg_filter_coefs_ch0_we0 <= '0';
    int_cfg_filter_coefs_ch0_be0 <= (others => '0');
    int_cfg_filter_coefs_ch0_d0 <= (others => '0');
    cfg_filter_coefs_ch0_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_filter_coefs_ch0_q0, 32));
    int_cfg_filter_coefs_ch0_address1 <= raddr(10 downto 2) when ar_hs = '1' else waddr(10 downto 2);
    int_cfg_filter_coefs_ch0_ce1 <= '1' when ar_hs = '1' or (int_cfg_filter_coefs_ch0_write = '1' and WVALID  = '1') else '0';
    int_cfg_filter_coefs_ch0_we1 <= '1' when int_cfg_filter_coefs_ch0_write = '1' and WVALID = '1' else '0';
    int_cfg_filter_coefs_ch0_be1 <= UNSIGNED(WSTRB);
    int_cfg_filter_coefs_ch0_d1 <= UNSIGNED(WDATA);
    -- cfg_filter_coefs_ch1
    int_cfg_filter_coefs_ch1_address0 <= UNSIGNED(cfg_filter_coefs_ch1_address0);
    int_cfg_filter_coefs_ch1_ce0 <= cfg_filter_coefs_ch1_ce0;
    int_cfg_filter_coefs_ch1_we0 <= '0';
    int_cfg_filter_coefs_ch1_be0 <= (others => '0');
    int_cfg_filter_coefs_ch1_d0 <= (others => '0');
    cfg_filter_coefs_ch1_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_filter_coefs_ch1_q0, 32));
    int_cfg_filter_coefs_ch1_address1 <= raddr(10 downto 2) when ar_hs = '1' else waddr(10 downto 2);
    int_cfg_filter_coefs_ch1_ce1 <= '1' when ar_hs = '1' or (int_cfg_filter_coefs_ch1_write = '1' and WVALID  = '1') else '0';
    int_cfg_filter_coefs_ch1_we1 <= '1' when int_cfg_filter_coefs_ch1_write = '1' and WVALID = '1' else '0';
    int_cfg_filter_coefs_ch1_be1 <= UNSIGNED(WSTRB);
    int_cfg_filter_coefs_ch1_d1 <= UNSIGNED(WDATA);
    -- cfg_filter_coefs_ch2
    int_cfg_filter_coefs_ch2_address0 <= UNSIGNED(cfg_filter_coefs_ch2_address0);
    int_cfg_filter_coefs_ch2_ce0 <= cfg_filter_coefs_ch2_ce0;
    int_cfg_filter_coefs_ch2_we0 <= '0';
    int_cfg_filter_coefs_ch2_be0 <= (others => '0');
    int_cfg_filter_coefs_ch2_d0 <= (others => '0');
    cfg_filter_coefs_ch2_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_filter_coefs_ch2_q0, 32));
    int_cfg_filter_coefs_ch2_address1 <= raddr(10 downto 2) when ar_hs = '1' else waddr(10 downto 2);
    int_cfg_filter_coefs_ch2_ce1 <= '1' when ar_hs = '1' or (int_cfg_filter_coefs_ch2_write = '1' and WVALID  = '1') else '0';
    int_cfg_filter_coefs_ch2_we1 <= '1' when int_cfg_filter_coefs_ch2_write = '1' and WVALID = '1' else '0';
    int_cfg_filter_coefs_ch2_be1 <= UNSIGNED(WSTRB);
    int_cfg_filter_coefs_ch2_d1 <= UNSIGNED(WDATA);
    -- cfg_phase_samples
    int_cfg_phase_samples_address0 <= UNSIGNED(cfg_phase_samples_address0);
    int_cfg_phase_samples_ce0 <= cfg_phase_samples_ce0;
    int_cfg_phase_samples_we0 <= '0';
    int_cfg_phase_samples_be0 <= (others => '0');
    int_cfg_phase_samples_d0 <= (others => '0');
    cfg_phase_samples_q0 <= STD_LOGIC_VECTOR(RESIZE(int_cfg_phase_samples_q0, 32));
    int_cfg_phase_samples_address1 <= raddr(17 downto 2) when ar_hs = '1' else waddr(17 downto 2);
    int_cfg_phase_samples_ce1 <= '1' when ar_hs = '1' or (int_cfg_phase_samples_write = '1' and WVALID  = '1') else '0';
    int_cfg_phase_samples_we1 <= '1' when int_cfg_phase_samples_write = '1' and WVALID = '1' else '0';
    int_cfg_phase_samples_be1 <= UNSIGNED(WSTRB);
    int_cfg_phase_samples_d1 <= UNSIGNED(WDATA);

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_prt_0_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_PRT_0_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_PRT_0_HIGH) then
                    int_cfg_pulse_sequence_prt_0_read <= '1';
                else
                    int_cfg_pulse_sequence_prt_0_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_prt_0_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_PRT_0_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_PRT_0_HIGH) then
                    int_cfg_pulse_sequence_prt_0_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_prt_0_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_prt_1_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_PRT_1_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_PRT_1_HIGH) then
                    int_cfg_pulse_sequence_prt_1_read <= '1';
                else
                    int_cfg_pulse_sequence_prt_1_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_prt_1_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_PRT_1_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_PRT_1_HIGH) then
                    int_cfg_pulse_sequence_prt_1_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_prt_1_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_num_pulses_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_HIGH) then
                    int_cfg_pulse_sequence_num_pulses_read <= '1';
                else
                    int_cfg_pulse_sequence_num_pulses_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_num_pulses_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_NUM_PULSES_HIGH) then
                    int_cfg_pulse_sequence_num_pulses_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_num_pulses_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_block_post_time_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_HIGH) then
                    int_cfg_pulse_sequence_block_post_time_read <= '1';
                else
                    int_cfg_pulse_sequence_block_post_time_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_block_post_time_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_BLOCK_POST_TIME_HIGH) then
                    int_cfg_pulse_sequence_block_post_time_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_block_post_time_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_control_flags_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_HIGH) then
                    int_cfg_pulse_sequence_control_flags_read <= '1';
                else
                    int_cfg_pulse_sequence_control_flags_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_control_flags_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_CONTROL_FLAGS_HIGH) then
                    int_cfg_pulse_sequence_control_flags_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_control_flags_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_polarization_mode_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_HIGH) then
                    int_cfg_pulse_sequence_polarization_mode_read <= '1';
                else
                    int_cfg_pulse_sequence_polarization_mode_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_polarization_mode_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_POLARIZATION_MODE_HIGH) then
                    int_cfg_pulse_sequence_polarization_mode_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_polarization_mode_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_filter_select_ch0_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_HIGH) then
                    int_cfg_pulse_sequence_filter_select_ch0_read <= '1';
                else
                    int_cfg_pulse_sequence_filter_select_ch0_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_filter_select_ch0_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH0_HIGH) then
                    int_cfg_pulse_sequence_filter_select_ch0_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_filter_select_ch0_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_filter_select_ch1_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_HIGH) then
                    int_cfg_pulse_sequence_filter_select_ch1_read <= '1';
                else
                    int_cfg_pulse_sequence_filter_select_ch1_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_filter_select_ch1_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH1_HIGH) then
                    int_cfg_pulse_sequence_filter_select_ch1_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_filter_select_ch1_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_filter_select_ch2_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_HIGH) then
                    int_cfg_pulse_sequence_filter_select_ch2_read <= '1';
                else
                    int_cfg_pulse_sequence_filter_select_ch2_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_filter_select_ch2_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_FILTER_SELECT_CH2_HIGH) then
                    int_cfg_pulse_sequence_filter_select_ch2_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_filter_select_ch2_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_phase_table_begin_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN_HIGH) then
                    int_cfg_pulse_sequence_phase_table_begin_read <= '1';
                else
                    int_cfg_pulse_sequence_phase_table_begin_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_phase_table_begin_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_BEGIN_HIGH) then
                    int_cfg_pulse_sequence_phase_table_begin_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_phase_table_begin_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_phase_table_end_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_END_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_END_HIGH) then
                    int_cfg_pulse_sequence_phase_table_end_read <= '1';
                else
                    int_cfg_pulse_sequence_phase_table_end_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_phase_table_end_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_END_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_PHASE_TABLE_END_HIGH) then
                    int_cfg_pulse_sequence_phase_table_end_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_phase_table_end_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_offset_0_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_HIGH) then
                    int_cfg_pulse_sequence_timer_offset_0_read <= '1';
                else
                    int_cfg_pulse_sequence_timer_offset_0_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_offset_0_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_0_HIGH) then
                    int_cfg_pulse_sequence_timer_offset_0_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_timer_offset_0_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_offset_1_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_HIGH) then
                    int_cfg_pulse_sequence_timer_offset_1_read <= '1';
                else
                    int_cfg_pulse_sequence_timer_offset_1_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_offset_1_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_1_HIGH) then
                    int_cfg_pulse_sequence_timer_offset_1_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_timer_offset_1_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_offset_2_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_HIGH) then
                    int_cfg_pulse_sequence_timer_offset_2_read <= '1';
                else
                    int_cfg_pulse_sequence_timer_offset_2_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_offset_2_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_2_HIGH) then
                    int_cfg_pulse_sequence_timer_offset_2_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_timer_offset_2_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_offset_3_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_HIGH) then
                    int_cfg_pulse_sequence_timer_offset_3_read <= '1';
                else
                    int_cfg_pulse_sequence_timer_offset_3_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_offset_3_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_3_HIGH) then
                    int_cfg_pulse_sequence_timer_offset_3_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_timer_offset_3_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_offset_4_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_HIGH) then
                    int_cfg_pulse_sequence_timer_offset_4_read <= '1';
                else
                    int_cfg_pulse_sequence_timer_offset_4_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_offset_4_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_4_HIGH) then
                    int_cfg_pulse_sequence_timer_offset_4_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_timer_offset_4_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_offset_5_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_HIGH) then
                    int_cfg_pulse_sequence_timer_offset_5_read <= '1';
                else
                    int_cfg_pulse_sequence_timer_offset_5_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_offset_5_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_5_HIGH) then
                    int_cfg_pulse_sequence_timer_offset_5_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_timer_offset_5_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_offset_6_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_HIGH) then
                    int_cfg_pulse_sequence_timer_offset_6_read <= '1';
                else
                    int_cfg_pulse_sequence_timer_offset_6_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_offset_6_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_6_HIGH) then
                    int_cfg_pulse_sequence_timer_offset_6_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_timer_offset_6_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_offset_7_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_HIGH) then
                    int_cfg_pulse_sequence_timer_offset_7_read <= '1';
                else
                    int_cfg_pulse_sequence_timer_offset_7_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_offset_7_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_TIMER_OFFSET_7_HIGH) then
                    int_cfg_pulse_sequence_timer_offset_7_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_timer_offset_7_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_width_0_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_HIGH) then
                    int_cfg_pulse_sequence_timer_width_0_read <= '1';
                else
                    int_cfg_pulse_sequence_timer_width_0_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_width_0_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_0_HIGH) then
                    int_cfg_pulse_sequence_timer_width_0_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_timer_width_0_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_width_1_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_HIGH) then
                    int_cfg_pulse_sequence_timer_width_1_read <= '1';
                else
                    int_cfg_pulse_sequence_timer_width_1_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_width_1_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_1_HIGH) then
                    int_cfg_pulse_sequence_timer_width_1_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_timer_width_1_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_width_2_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_HIGH) then
                    int_cfg_pulse_sequence_timer_width_2_read <= '1';
                else
                    int_cfg_pulse_sequence_timer_width_2_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_width_2_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_2_HIGH) then
                    int_cfg_pulse_sequence_timer_width_2_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_timer_width_2_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_width_3_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_HIGH) then
                    int_cfg_pulse_sequence_timer_width_3_read <= '1';
                else
                    int_cfg_pulse_sequence_timer_width_3_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_width_3_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_3_HIGH) then
                    int_cfg_pulse_sequence_timer_width_3_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_timer_width_3_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_width_4_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_HIGH) then
                    int_cfg_pulse_sequence_timer_width_4_read <= '1';
                else
                    int_cfg_pulse_sequence_timer_width_4_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_width_4_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_4_HIGH) then
                    int_cfg_pulse_sequence_timer_width_4_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_timer_width_4_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_width_5_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_HIGH) then
                    int_cfg_pulse_sequence_timer_width_5_read <= '1';
                else
                    int_cfg_pulse_sequence_timer_width_5_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_width_5_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_5_HIGH) then
                    int_cfg_pulse_sequence_timer_width_5_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_timer_width_5_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_width_6_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_HIGH) then
                    int_cfg_pulse_sequence_timer_width_6_read <= '1';
                else
                    int_cfg_pulse_sequence_timer_width_6_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_width_6_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_6_HIGH) then
                    int_cfg_pulse_sequence_timer_width_6_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_timer_width_6_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_width_7_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_BASE and raddr <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_HIGH) then
                    int_cfg_pulse_sequence_timer_width_7_read <= '1';
                else
                    int_cfg_pulse_sequence_timer_width_7_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_pulse_sequence_timer_width_7_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PULSE_SEQUENCE_TIMER_WIDTH_7_HIGH) then
                    int_cfg_pulse_sequence_timer_width_7_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_pulse_sequence_timer_width_7_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_filter_coefs_ch0_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_FILTER_COEFS_CH0_BASE and raddr <= ADDR_CFG_FILTER_COEFS_CH0_HIGH) then
                    int_cfg_filter_coefs_ch0_read <= '1';
                else
                    int_cfg_filter_coefs_ch0_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_filter_coefs_ch0_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_FILTER_COEFS_CH0_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_FILTER_COEFS_CH0_HIGH) then
                    int_cfg_filter_coefs_ch0_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_filter_coefs_ch0_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_filter_coefs_ch1_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_FILTER_COEFS_CH1_BASE and raddr <= ADDR_CFG_FILTER_COEFS_CH1_HIGH) then
                    int_cfg_filter_coefs_ch1_read <= '1';
                else
                    int_cfg_filter_coefs_ch1_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_filter_coefs_ch1_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_FILTER_COEFS_CH1_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_FILTER_COEFS_CH1_HIGH) then
                    int_cfg_filter_coefs_ch1_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_filter_coefs_ch1_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_filter_coefs_ch2_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_FILTER_COEFS_CH2_BASE and raddr <= ADDR_CFG_FILTER_COEFS_CH2_HIGH) then
                    int_cfg_filter_coefs_ch2_read <= '1';
                else
                    int_cfg_filter_coefs_ch2_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_filter_coefs_ch2_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_FILTER_COEFS_CH2_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_FILTER_COEFS_CH2_HIGH) then
                    int_cfg_filter_coefs_ch2_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_filter_coefs_ch2_write <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_phase_samples_read <= '0';
            elsif (ACLK_EN = '1') then
                if (ar_hs = '1' and raddr >= ADDR_CFG_PHASE_SAMPLES_BASE and raddr <= ADDR_CFG_PHASE_SAMPLES_HIGH) then
                    int_cfg_phase_samples_read <= '1';
                else
                    int_cfg_phase_samples_read <= '0';
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_cfg_phase_samples_write <= '0';
            elsif (ACLK_EN = '1') then
                if (aw_hs = '1' and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) >= ADDR_CFG_PHASE_SAMPLES_BASE and UNSIGNED(AWADDR(ADDR_BITS-1 downto 0)) <= ADDR_CFG_PHASE_SAMPLES_HIGH) then
                    int_cfg_phase_samples_write <= '1';
                elsif (WVALID = '1') then
                    int_cfg_phase_samples_write <= '0';
                end if;
            end if;
        end if;
    end process;


end architecture behave;

library IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity hcr_controller_cfg_bus_s_axi_ram is
    generic (
        BYTES   : INTEGER :=4;
        DEPTH   : INTEGER :=256;
        AWIDTH  : INTEGER :=8);
    port (
        clk0    : in  STD_LOGIC;
        address0: in  UNSIGNED(AWIDTH-1 downto 0);
        ce0     : in  STD_LOGIC;
        we0     : in  STD_LOGIC;
        be0     : in  UNSIGNED(BYTES-1 downto 0);
        d0      : in  UNSIGNED(BYTES*8-1 downto 0);
        q0      : out UNSIGNED(BYTES*8-1 downto 0);
        clk1    : in  STD_LOGIC;
        address1: in  UNSIGNED(AWIDTH-1 downto 0);
        ce1     : in  STD_LOGIC;
        we1     : in  STD_LOGIC;
        be1     : in  UNSIGNED(BYTES-1 downto 0);
        d1      : in  UNSIGNED(BYTES*8-1 downto 0);
        q1      : out UNSIGNED(BYTES*8-1 downto 0));

end entity hcr_controller_cfg_bus_s_axi_ram;

architecture behave of hcr_controller_cfg_bus_s_axi_ram is
    signal address0_tmp : UNSIGNED(AWIDTH-1 downto 0);
    signal address1_tmp : UNSIGNED(AWIDTH-1 downto 0);
    type RAM_T is array (0 to DEPTH - 1) of UNSIGNED(BYTES*8 - 1 downto 0);
    shared variable mem : RAM_T := (others => (others => '0'));
begin

    process (address0)
    begin
    address0_tmp <= address0;
    --synthesis translate_off
          if (address0 > DEPTH-1) then
              address0_tmp <= (others => '0');
          else
              address0_tmp <= address0;
          end if;
    --synthesis translate_on
    end process;

    process (address1)
    begin
    address1_tmp <= address1;
    --synthesis translate_off
          if (address1 > DEPTH-1) then
              address1_tmp <= (others => '0');
          else
              address1_tmp <= address1;
          end if;
    --synthesis translate_on
    end process;

    --read port 0
    process (clk0) begin
        if (clk0'event and clk0 = '1') then
            if (ce0 = '1') then
                q0 <= mem(to_integer(address0_tmp));
            end if;
        end if;
    end process;

    --read port 1
    process (clk1) begin
        if (clk1'event and clk1 = '1') then
            if (ce1 = '1') then
                q1 <= mem(to_integer(address1_tmp));
            end if;
        end if;
    end process;

    gen_write : for i in 0 to BYTES - 1 generate
    begin
        --write port 0
        process (clk0)
        begin
            if (clk0'event and clk0 = '1') then
                if (ce0 = '1' and we0 = '1' and be0(i) = '1') then
                    mem(to_integer(address0_tmp))(8*i+7 downto 8*i) := d0(8*i+7 downto 8*i);
                end if;
            end if;
        end process;

        --write port 1
        process (clk1)
        begin
            if (clk1'event and clk1 = '1') then
                if (ce1 = '1' and we1 = '1' and be1(i) = '1') then
                    mem(to_integer(address1_tmp))(8*i+7 downto 8*i) := d1(8*i+7 downto 8*i);
                end if;
            end if;
        end process;

    end generate;

end architecture behave;


