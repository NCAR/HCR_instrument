//
// hcr_metadata_injector.cpp
//    Author: Adam Karboski <karboski@ucar.edu>
//
// Copyright (c) 2021 University Corporation for Atmospheric Research
// All rights reserved.

#include "hcr_metadata_injector.h"

// Injects pulse metadata into the PDTI bus bus
void hcr_metadata_injector(
		hls::stream<pdti_64>& i_data,
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

	uint8_t decimation_value = 1;
	bool in_a_pulse = 0;
	bool in_a_xfer_bundle = 0;
	bool break_after_pulse = 0;
	uint32_t num_samples = 0;
	uint32_t sample_counter = 0;
	uint8_t decimation_counter = 0;
	uint64_t pulse_sequence_counter = 0;
	bool terminate = 0;
	bool previous_gate_bit = 0;
	pdti_64 data_word;
	pdti_64 cached_data_word;

	// Loop forever
	pulse_loop : while(!terminate)
	{

		// Each iteration of this pipelined loop handles one sample. To keep the ii low,
		// the loop only handles 'normal' samples. If it detects the start of the pulse,
		// it bails out to the outer loop so that handle_header can be called.
		sample_loop : while(true)
		{
		#pragma HLS pipeline ii=3

			assert_readable(i_data) >> data_word;

			//If this is the start of the pulse, bail out and call handle_header.
			//Pulse start is determined by edge-detecting the gate.
			if(data_word.user[PDTI_GATE] && !previous_gate_bit) break;

			handle_regular_sample :
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

				bool dec_keep = (decimation_counter == decimation_value);

				//Write the word, omitting ungated samples inside a pulse bundle
				if((in_a_pulse && dec_keep) || !in_a_xfer_bundle)
				{
					pdti_64 output_data_word = data_word;
					cached_data_word.user[PDTI_GATE] = in_a_pulse;
					cached_data_word.user[PDTI_SYNC] = 0;
					output_data_word.user[PDTI_GATE] = in_a_pulse;
					output_data_word.user[PDTI_SYNC] = 0;
					if(sample_counter & 1)
					{
						//Write pairs of samples at a time since they take up 1.5 output words
						write_pair(o_data, cached_data_word, output_data_word);
					}
					cached_data_word = output_data_word;
					decimation_counter = 1;
				}
				else
				{
					decimation_counter++;
				}

				if(dec_keep) sample_counter++;

				previous_gate_bit = data_word.user[PDTI_GATE];
			}
		}

		//If we bailed out of sample_loop, then we need to handle
		//the special case of the first sample of a pulse.
		terminate = handle_header(
				pulse_metadata,
				data_word,
				in_a_pulse,
				in_a_xfer_bundle,
				break_after_pulse,
				num_samples,
				sample_counter,
				decimation_value,
				decimation_counter,
				pulse_sequence_counter,
				previous_gate_bit,
				o_data,
				*pos_enc_0,
				*pos_enc_1,
				*flags
			);

		//Cache the first sample
		cached_data_word = data_word;
	}
}

bool handle_header(
		hls::stream<pulse_exec_definition>& pulse_metadata,
		pdti_64 data_word,
		bool& in_a_pulse,
		bool& in_a_xfer_bundle,
		bool& break_after_pulse,
		uint32_t& num_samples,
		uint32_t& sample_counter,
		uint8_t& decimation_value,
		uint8_t& decimation_counter,
		uint64_t& pulse_sequence_counter,
		bool& previous_gate_bit,
		hls::stream<pdti_32>& o_data,
		uint32_t pos_enc_0,
		uint32_t pos_enc_1,
		uint16_t flags
	)
{

	std::cout << "Reading pulse... ";

	//Read the pulse definition
	pulse_exec_definition pulse_info = assert_readable(pulse_metadata).read();
	std::cout << "T" << pulse_info.terminate << " ";
	if(pulse_info.terminate) return true;

	//If pentek didn't give us enough samples, add them now
	pad : for(uint32_t x=sample_counter; x<num_samples; ++x)
	{
		#pragma HLS pipeline ii=3
		pdti_64 pad_sample = data_word;
		pad_sample.data = 0x7474747475757575;
		pad_sample.user[PDTI_GATE] = 1;
		pad_sample.user[PDTI_SYNC] = 0;
		write_pair(o_data, pad_sample, pad_sample);
	}

	//If collecting continuously, we need to add a "break sample"
	//so the DMA engine knows where to end the transfer.
	if(pulse_info.first_pulse_in_xfer)
	{
		pdti_64 spacer_sample = data_word;
		spacer_sample.data = 0x9797979798989898;
		spacer_sample.user[PDTI_GATE] = 0;
		spacer_sample.user[PDTI_SYNC] = 0;
		write_pair(o_data, spacer_sample, spacer_sample);
	}

	//Update flags
	in_a_pulse = 1;
	in_a_xfer_bundle = 1;
	previous_gate_bit = 1;
	break_after_pulse = pulse_info.last_pulse_in_xfer;
	num_samples = pulse_info.num_samples;
	decimation_value = pulse_info.post_decimation;

	ap_uint<32> ext_flags = flags;
	ext_flags[16] = pulse_info.first_pulse_in_block;
	ext_flags[17] = pulse_info.last_pulse_in_block;
	ext_flags[18] = pulse_info.first_pulse_in_xfer;
	ext_flags[19] = pulse_info.last_pulse_in_xfer;

	std::cout << "blockFL: " << ext_flags[16] << ext_flags[17]
		   << "  xferFL: " << ext_flags[18] << ext_flags[19] << "\n";

	uint32_t header[16];
	#pragma HLS ARRAY_PARTITION variable=header complete
	header[0] = 0xba5eba11;
	header[1] = ext_flags;
	header[2] = pos_enc_0;
	header[3] = pos_enc_1;
	header[4] = pulse_info.sequence_index;
	header[5] = pulse_info.num_samples;
	header[6] = pulse_info.def.prt[0];
	header[7] = pulse_info.phase_sample;
	header[8] = pulse_sequence_counter & 0xFFFFFFFFull;
	header[9] = (pulse_sequence_counter >> 32) & 0xFFFFFFFFull;
	header[10] = 0;
	header[11] = 0;
	header[12] = 0;
	header[13] = 0;
	header[14] = 0;
	header[15] = 0;

	//Write the pulse header
	write_header : for(uint32_t x=0; x<16; ++x)
	{
		#pragma HLS pipeline ii=1
		pdti_32 header_word = copy_meta(data_word);
		header_word.data = header[x];
		header_word.user[PDTI_GATE] = 1;
		header_word.user[PDTI_SYNC] = 1;
		o_data << header_word;
	}

	// Update counts
	sample_counter = 1;
	decimation_counter = 1;
	pulse_sequence_counter ++;

	return false;
}

