//
// hcr_metadata_injector.cpp
//    Author: Adam Karboski <karboski@ucar.edu>
//
// Copyright (c) 2021 University Corporation for Atmospheric Research
// All rights reserved.

#include "hcr_metadata_injector.h"

// Injects pulse metadata into the PDTI bus bus
void hcr_metadata_injector(
		hls::stream<pdti_32>& i_data,
		hls::stream<pdti_32>& o_data,
		hls::stream<pulse_exec_definition>& pulse_metadata,
		volatile uint32_t* pos_enc_0,
		volatile uint32_t* pos_enc_1,
		volatile uint16_t* flags
	)
{
	#pragma HLS INTERFACE axis register both port=i_data
	#pragma HLS INTERFACE axis register both port=o_data
	#pragma HLS INTERFACE axis register both port=pulse_metadata
	#pragma HLS data_pack variable=pulse_metadata
	#pragma HLS INTERFACE ap_none port=pos_enc_0
	#pragma HLS INTERFACE ap_none port=pos_enc_1
	#pragma HLS INTERFACE ap_none port=flags


	bool in_a_pulse = 0;
	bool in_a_xfer_bundle = 0;
	bool break_after_pulse = 0;
	uint32_t num_samples = 0;
	uint32_t sample_counter = 0;
	bool terminate = 0;

	pdti_32 data_word;

	//Note: This loop needs to have an iteration latency of 3 when
	//it doesn't call handle_header.
	sample_loop : while(!terminate)
	{

		assert_readable(i_data) >> data_word;

		bool sync_bit = data_word.user[PDTI_SYNC];

		//Handle the first sample of a pulse
		if(sync_bit)
		{
			terminate = handle_header(
					pulse_metadata,
					data_word,
					in_a_pulse,
					in_a_xfer_bundle,
					break_after_pulse,
					num_samples,
					sample_counter,
					o_data,
					*pos_enc_0,
					*pos_enc_1,
					*flags
				);
		}
		else
		{

			//Check if we are done with the pulse and/or group
			if (sample_counter == num_samples)
			{
				in_a_pulse = 0;
				if(break_after_pulse)
				{
					in_a_xfer_bundle = 0;
				}
			}

			//Write the word, omitting ungated samples inside a pulse bundle
			if(in_a_pulse || !in_a_xfer_bundle)
			{
				data_word.user[PDTI_GATE] = in_a_pulse;
				data_word.user[PDTI_SYNC] = 0;
				o_data << data_word;
			}

			sample_counter++;
		}
	}
}

bool handle_header(
		hls::stream<pulse_exec_definition>& pulse_metadata,
		pdti_32 data_word,
		bool& in_a_pulse,
		bool& in_a_xfer_bundle,
		bool& break_after_pulse,
		uint32_t& num_samples,
		uint32_t& sample_counter,
		hls::stream<pdti_32>& o_data,
		uint32_t pos_enc_0,
		uint32_t pos_enc_1,
		uint16_t flags
	)
{

	std::cout << "Reading pulse... ";

	//Read the pulse definition
	pulse_exec_definition pulse_info = assert_readable(pulse_metadata).read();
	if(pulse_info.terminate) return true;

	//If pentek didn't give us enough samples, add them now
	for(uint32_t x=sample_counter; x<num_samples; ++x)
	{
		#pragma HLS pipeline ii=1
		pdti_32 pad_sample = data_word;
		pad_sample.data = 0x75757575;
		pad_sample.user[PDTI_GATE] = 1;
		pad_sample.user[PDTI_SYNC] = 0;
		o_data << pad_sample;
	}

	//Update flags
	in_a_pulse = 1;
	in_a_xfer_bundle = 1;
	break_after_pulse = pulse_info.last_pulse_in_xfer;
	num_samples = pulse_info.num_samples;

	ap_uint<32> ext_flags = flags;
	ext_flags[16] = pulse_info.first_pulse_in_block;
	ext_flags[17] = pulse_info.last_pulse_in_block;
	ext_flags[18] = pulse_info.first_pulse_in_xfer;
	ext_flags[19] = pulse_info.last_pulse_in_xfer;

	std::cout << "blockFL: " << ext_flags[16] << ext_flags[17]
		   << "  xferFL: " << ext_flags[18] << ext_flags[19] << "\n";

	uint32_t header[8];
	#pragma HLS ARRAY_PARTITION variable=header complete
	header[0] = 0xba5eba11;
	header[1] = ext_flags;
	header[2] = pos_enc_0;
	header[3] = pos_enc_1;
	header[4] = pulse_info.sequence_index;
	header[5] = pulse_info.num_samples;
	header[6] = pulse_info.def.prt[0];
	header[7] = 0;

	//Write the pulse header
	write_header : for(uint32_t x=0; x<8; ++x)
	{
		#pragma HLS pipeline ii=1
		pdti_32 header_word = data_word;
		header_word.data = header[x];
		header_word.user[PDTI_GATE] = 1;
		header_word.user[PDTI_SYNC] = 1;
		o_data << header_word;
	}

	//Write the original word
	data_word.user[PDTI_GATE] = 1;
	data_word.user[PDTI_SYNC] = 0;
	o_data << data_word;
	sample_counter = 1;

	return false;
}
