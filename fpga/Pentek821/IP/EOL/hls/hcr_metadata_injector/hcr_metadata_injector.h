//
// hcr_controller.h
//    Author: Adam Karboski <karboski@ucar.edu>
//
// Copyright (c) 2021 University Corporation for Atmospheric Research
// All rights reserved.

#ifndef __HCR_METADATA_INJ_H__
#define __HCR_METADATA_INJ_H__

#include "../hcr_hls_common.h"

void hcr_metadata_injector(
		hls::stream<pdti_64>& i_data,
		hls::stream<pdti_32>& o_data,
		hls::stream<pulse_exec_definition>& pulse_metadata,
		volatile uint32_t* pos_enc_0,
		volatile uint32_t* pos_enc_1,
		volatile uint16_t* flags
	);

bool handle_header(
		hls::stream<pulse_exec_definition>& pulse_metadata,
		pdti_64 data_word,
		bool& in_a_pulse,
		bool& in_a_pulse_group,
		bool& last_pulse,
		uint32_t& num_samples,
		uint32_t& sample_counter,
		uint8_t& decimation_value,
		uint8_t& decimation_counter,
		uint64_t& pulse_sequence_counter,
		bool& last_gate_bit,
		hls::stream<pdti_32>& o_data,
		uint32_t pos_enc_0,
		uint32_t pos_enc_1,
		uint16_t flags
	);

inline pdti_32 split(pdti_64 x, bool q)
{
#pragma HLS inline
	pdti_32 y;
	y.data = q ? x.data(63,32) : x.data(31,0);
	y.dest = x.dest;
	y.id = x.id;
	y.keep = q ? x.keep(7,4) : x.keep(3,0);
	y.last = x.last;
	y.strb = q ? x.strb(7,4) : x.strb(3,0);
	y.user = x.user;
	y.user[PDTI_IS_Q_SAMPLE] = q ? 1 : 0;
	y.user(PDTI_FORMAT+1,PDTI_FORMAT) = 3;
	return y;
};

inline void write_split(hls::stream<pdti_32>& o_data, pdti_64 x)
{
#pragma HLS inline
	o_data << split(x,false);
	o_data << split(x,true);
};

#endif // __HCR_METADATA_INJ_H__
