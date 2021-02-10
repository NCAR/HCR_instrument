//
// hcr_controller.h
//    Author: Adam Karboski <karboski@ucar.edu>
//
// Copyright (c) 2021 University Corporation for Atmospheric Research
// All rights reserved.

#ifndef __HCR_CONTROLLER_H__
#define __HCR_CONTROLLER_H__

#include "../hcr_hls_common.h"

const int N_COEF_SETS = 4;
const int N_FILTER_TAPS = 48;

typedef ap_int<24> coef_t;

// Schedules pulses for the HCR radar
void hcr_controller(
		uint8_t cfg_pulse_sequence_start_index,
		uint8_t cfg_pulse_sequence_length,
		volatile uint32_t* cfg_num_pulses_to_execute,
		uint32_t cfg_decimation,
		pulse_definition cfg_pulse_sequence[N_PULSE_DEFS],
		int32_t cfg_filter_coefs_ch0[N_COEF_SETS][N_FILTER_TAPS],
		int32_t cfg_filter_coefs_ch1[N_COEF_SETS][N_FILTER_TAPS],
		int32_t cfg_filter_coefs_ch2[N_COEF_SETS][N_FILTER_TAPS],
		hls::stream<coef_t>& coef_ch0,
		hls::stream<coef_t>& coef_ch1,
		hls::stream<coef_t>& coef_ch2,
		volatile ap_uint<N_TIMERS>* mt_pulse,   // MultiTimer outputs
		volatile ap_uint<32>* control_flags,    // Control word for the pulse
		volatile ap_uint<2>* filter_select_ch0, // Selects RX FIR
		volatile ap_uint<2>* filter_select_ch1,
		volatile ap_uint<2>* filter_select_ch2,
		hls::stream<pulse_exec_definition>& pulse_metadata_ch0,
		hls::stream<pulse_exec_definition>& pulse_metadata_ch1,
		hls::stream<pulse_exec_definition>& pulse_metadata_ch2,
		volatile bool pps[2] //Not a real memory - ignore control signals
	);

// Generates a stream of pulses to execute
void scheduler_parser(
		uint32_t cfg_pulse_sequence_start_index,
		uint32_t cfg_pulse_sequence_length,
		volatile uint32_t* cfg_num_pulses_to_execute,
		uint32_t cfg_decimation,
		pulse_definition cfg_pulse_sequence[N_PULSE_DEFS],
		int32_t cfg_filter_coefs_ch0[N_COEF_SETS][N_FILTER_TAPS],
		int32_t cfg_filter_coefs_ch1[N_COEF_SETS][N_FILTER_TAPS],
		int32_t cfg_filter_coefs_ch2[N_COEF_SETS][N_FILTER_TAPS],
		hls::stream<coef_t>& coef_ch0,
		hls::stream<coef_t>& coef_ch1,
		hls::stream<coef_t>& coef_ch2,
		hls::stream<pulse_exec_definition>& pulse_queue_0,
		hls::stream<pulse_exec_definition>& pulse_queue_1,
		hls::stream<pulse_exec_definition>& pulse_queue_2,
		hls::stream<pulse_exec_definition>& pulse_queue_s
	);

// Executes the pulses with cycle-exact timing
void scheduler_cycle_exact(
		volatile bool pps[2],
		hls::stream<pulse_exec_definition>& pulse_queue,
		volatile ap_uint<N_TIMERS>* mt_pulse,
		volatile ap_uint<32>* control_flags,
		volatile ap_uint<2>* filter_select_ch0,
		volatile ap_uint<2>* filter_select_ch1,
		volatile ap_uint<2>* filter_select_ch2
	);

void output_fifo(
		hls::stream<pulse_exec_definition>& in,
		hls::stream<pulse_exec_definition>& out
	);

#endif // __HCR_CONTROLLER_H__
