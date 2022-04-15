//
// hcr_controller.h
//    Author: Adam Karboski <karboski@ucar.edu>
//
// Copyright (c) 2021 University Corporation for Atmospheric Research
// All rights reserved.

#ifndef __HCR_HLS_COMMON_H__
#define __HCR_HLS_COMMON_H__

#include "ap_int.h"
#include <hls_stream.h>
#include <iostream>
#include <ap_axi_sdata.h>
#include <stdint.h>

// tdata [n-1:0] = Data Samples
// tuser [63:0] = Timestamp [63:0]
// tuser [71:64] = Gate Positions
// tuser [79:72] = Sync Positions
// tuser [87:80] = PPS Positions
// tuser [91:88] = Samples/Cycle (1,2,4,8,16)
// tuser [92] = Is Q Sample
// tuser [94:93] = Data Format 0 = 8-bit, 1= 16 bit, 2 = 24-bit, 3 = 32-bit
// tuser [95] = Data Type 0 = Real 1 = I/Q
// tuser [103:96] = Channel [7:0]
// tuser [127:104] = Reserved
typedef ap_axiu<32,128,1,1> pdti_32;
typedef ap_axiu<64,128,1,1> pdti_64;
const int PDTI_GATE = 64;
const int PDTI_SYNC = 72;
const int PDTI_PPS = 80;
const int PDTI_NUM_SAMPLES = 88;
const int PDTI_IS_Q_SAMPLE = 92;
const int PDTI_FORMAT = 93;
const int PDTI_IS_IQ_FORMAT = 95;
const int PDTI_CHANNEL = 96;

//Radar scheduler parameters
const int N_PULSE_DEFS = 32;
const int N_TIMERS = 8;
const int N_PRTS = 2;
//Converts ADC channel number to multi-timer number
const int CHANNEL_TO_MT[3] = {1,2,3};

const int POL_MODE_V = 0;
const int POL_MODE_H = 1;
const int POL_MODE_HHVV = 2;

// An array of this structure defines the radar schedule.
// Each entry specifies a group of pulses. The pulses are identical, except for PRT which can
// cycle through up to four values. After the pulses are executed, the scheduler moves
// to the next entry in the array. After the final entry the scheduler may optionally loop back to the first.
// Example schedule:          Execute 100 pulses of with PRT 5000, then
//                            execute 120 pulses of with PRT 4000,4100 then repeat.
struct pulse_definition
{
	uint32_t prt[N_PRTS];                 // Pulse repetition time(s) in cycles. Set unused PRTs to 0
	uint32_t num_pulses;                  // Generate this many pulses
	uint32_t block_post_time;             // Time at the end of the group of pulses, in cycles
	uint32_t control_flags;               // Set the CONTROL_FLAGS output to this value
	uint32_t polarization_mode;           // Polarization mode
	uint32_t filter_select_ch0;           // Select this filter for ADC channel 0
	uint32_t filter_select_ch1;           // Select this filter for ADC channel 1
	uint32_t filter_select_ch2;           // Select this filter for ADC channel 2
	uint32_t phase_table_begin;           // First index into the phase coding table
	uint32_t phase_table_end;             // Last index into the phase coding table
	uint32_t timer_offset[N_TIMERS];      // First, wait this many cycles before setting MT_PULSE[n]
	uint32_t timer_width[N_TIMERS];       // Then, wait this many cycles before clearing MT_PULSE[n]
};

//Same struct with some extra execution info
struct pulse_exec_definition
{
	pulse_definition def;
	uint8_t sequence_index;
	uint32_t num_samples;
	uint8_t post_decimation;
	uint32_t phase_sample;
	bool first_pulse_in_block;
	bool last_pulse_in_block;
	bool first_pulse_in_xfer;
	bool last_pulse_in_xfer;
	bool terminate;
};

//Launch the debugger if the code tries to read an empty queue
#define assert_readable(a) __assert_readable(a, __FILE__, __LINE__)
template<typename T> inline hls::stream<T>& __assert_readable(hls::stream<T>& a, const char* f, int l)
{
	#ifndef __SYNTHESIS__
		if (a.empty())
		{
			a.read(); //Prints name of queue
			std::cout << "ERROR: " << f << ":" << l << ": Reading empty queue!\n";
			std::cout.flush();
			__builtin_trap();
		}
	#endif

	return a;
}

#endif // __HCR_HLS_COMMON_H__
