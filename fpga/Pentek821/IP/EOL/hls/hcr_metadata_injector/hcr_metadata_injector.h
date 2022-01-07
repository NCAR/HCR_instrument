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

// Copy a pdti's metadata
inline pdti_32 copy_meta(pdti_64 x)
{
#pragma HLS inline
	pdti_32 y;
	y.data = 0;
	y.dest = x.dest;
	y.id = x.id;
	y.keep = x.keep;
	y.last = x.last;
	y.strb = x.strb;
	y.user = x.user;
	return y;
};

// Write 2 24-bit IQs into 3 32-bit words
inline void write_pair(hls::stream<pdti_32>& o, pdti_64 s1, pdti_64 s2)
{
#pragma HLS inline
	pdti_32 y = copy_meta(s1);
	ap_uint<24> I1 = s1.data(23,0);
	ap_uint<24> Q1 = s1.data(55,32);
	ap_uint<24> I2 = s2.data(23,0);
	ap_uint<24> Q2 = s2.data(55,32);
	y.data(23,0)  = I1;
	y.data(31,24) = Q1(7,0);
	o << y;
	y.data(15,0)  = Q1(23,8);
	y.data(31,16) = I2(15,0);
	o << y;
	y.data(7,0)   = I2(23,16);
	y.data(31,8)  = Q2;
	o << y;
}

// Create a pseudo-float output of the format
// [ 14 bit 2's comp Q][ 14 bit 2's comp I][4 bit exponent]
// To convert back to integers:
// int I = s << 14 >> 18 << (s & 15);
// int Q = s >> 18 << (s & 15);
inline pdti_32 squash(pdti_64 x)
{
#pragma HLS inline
	ap_int<32> I = x.data(31,0);
	ap_int<32> Q = x.data(63,32);

	// Get the least number of sign bits
	uint8_t signsI = (I<0) ? __builtin_clz(~I) : __builtin_clz(I);
	uint8_t signsQ = (Q<0) ? __builtin_clz(~Q) : __builtin_clz(Q);
	uint8_t signs = (signsI<signsQ) ? signsI : signsQ;

	// If the number is too large, compute the right shift
	uint8_t shift = (signs>19) ? 0 : (19-signs);

	// Round towards zero to prevent bias (important!)
	if(I<0) I += ((1<<shift)-1);
	if(Q<0) Q += ((1<<shift)-1);

	// Assign output
	pdti_32 y = copy_meta(x);
	y.data(3,0) = shift;
	y.data(17,4) = I >> shift;
	y.data(31,18) = Q >> shift;
	return y;
};

#endif // __HCR_METADATA_INJ_H__
