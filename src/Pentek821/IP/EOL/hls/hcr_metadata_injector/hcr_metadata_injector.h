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
		hls::stream<pdti_32>& i_data,
		hls::stream<pdti_32>& o_data,
		hls::stream<pulse_exec_definition>& pulse_metadata,
		volatile uint32_t* pos_enc_0,
		volatile uint32_t* pos_enc_1,
		volatile uint16_t* flags
	);

bool handle_header(
		hls::stream<pulse_exec_definition>& pulse_metadata,
		pdti_32 data_word,
		bool& in_a_pulse,
		bool& in_a_pulse_group,
		bool& last_pulse,
		uint32_t& num_samples,
		uint32_t& sample_counter,
		hls::stream<pdti_32>& o_data,
		uint32_t pos_enc_0,
		uint32_t pos_enc_1,
		uint16_t flags
	);

#endif // __HCR_METADATA_INJ_H__
