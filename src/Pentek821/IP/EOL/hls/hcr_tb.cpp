//
// hcr_controller_tb.cpp
//    Author: Adam Karboski <karboski@ucar.edu>
//
// Copyright (c) 2021 University Corporation for Atmospheric Research
// All rights reserved.

#include "hcr_controller/hcr_controller.h"
#include "hcr_metadata_injector/hcr_metadata_injector.h"

int main()
{

	uint32_t cfg_pulse_sequence_start_index = 0;
	uint32_t cfg_pulse_sequence_length = 2;
	uint32_t cfg_num_pulses_to_execute = 24;
	uint32_t cfg_total_decimation = 16;
	uint32_t cfg_post_decimation = 2;
	uint32_t cfg_num_pulses_per_xfer = 3;
	uint32_t cfg_enabled_channel_vector = 7;
	pulse_definition cfg_pulse_sequence[N_PULSE_DEFS] {};
	bool sync_pulse = 1;
	volatile ap_uint<N_TIMERS> mt_pulse;
	volatile ap_uint<32> control_flags;
	volatile ap_uint<2> filter_select_ch0;
	volatile ap_uint<2> filter_select_ch1;
	volatile ap_uint<2> filter_select_ch2;
	hls::stream<pdti_32> i_data("tb.i_data");
	hls::stream<pdti_32> o_data("tb.o_data");
	hls::stream<pulse_exec_definition> pulse_metadata_ch0("tb.meta_ch0");
	hls::stream<pulse_exec_definition> pulse_metadata_ch1("tb.meta_ch1");
	hls::stream<pulse_exec_definition> pulse_metadata_ch2("tb.meta_ch2");
	int32_t cfg_filter_coefs_ch0[N_COEF_SETS][N_FILTER_TAPS] {};
	int32_t cfg_filter_coefs_ch1[N_COEF_SETS][N_FILTER_TAPS] {};
	int32_t cfg_filter_coefs_ch2[N_COEF_SETS][N_FILTER_TAPS] {};
	hls::stream<coef_t> coef_ch0;
	hls::stream<coef_t> coef_ch1;
	hls::stream<coef_t> coef_ch2;
	uint32_t pos_enc_0 = 0xDEADBEEF;
	uint32_t pos_enc_1 = 0xF00DCAFE;
	uint16_t flags = 1;

	cfg_pulse_sequence[0].num_pulses = 4;
	cfg_pulse_sequence[0].prt[0] = 128;
	cfg_pulse_sequence[0].block_post_time = 0;
	for(int t=0;t<N_TIMERS;++t)
	{
		cfg_pulse_sequence[0].timer_offset[t] = 0;
		cfg_pulse_sequence[0].timer_width[t] = 10000;
	}

	cfg_pulse_sequence[1].num_pulses = 2;
	cfg_pulse_sequence[1].prt[0] = 100;
	cfg_pulse_sequence[1].block_post_time = 10;
	for(int t=0;t<N_TIMERS;++t)
	{
		cfg_pulse_sequence[1].timer_offset[t] = N_TIMERS-t;
		cfg_pulse_sequence[1].timer_width[t] = 63;
	}

	pdti_32 adc_data;
	for(int x=0; x<cfg_num_pulses_to_execute+1; ++x)
	{

		for(int k=0; k<16;k++)
		{
			adc_data.data = 256*65536 + x*256 + k;
			adc_data.user++;
			adc_data.user[PDTI_SYNC] = (k==0);
			i_data << adc_data;
		}
	}

	//Add an extra sample to let the testbench finish
	adc_data.user++;
	adc_data.user[PDTI_SYNC] = 1;
	i_data << adc_data;

	for(int set=0; set<N_COEF_SETS; ++set)
	{
		for(int tap=0; tap<N_FILTER_TAPS; ++tap)
		{
			cfg_filter_coefs_ch0[set][tap] = set+tap+1;
			cfg_filter_coefs_ch1[set][tap] = set+tap+2;
			cfg_filter_coefs_ch2[set][tap] = set+tap+3;
		}
	}

	hcr_controller(
		cfg_pulse_sequence_start_index,
		cfg_pulse_sequence_length,
		&cfg_num_pulses_to_execute,
		cfg_total_decimation,
		cfg_post_decimation,
		cfg_num_pulses_per_xfer,
		cfg_enabled_channel_vector,
		cfg_pulse_sequence,
		cfg_filter_coefs_ch0,
		cfg_filter_coefs_ch1,
		cfg_filter_coefs_ch2,
		coef_ch0,
		coef_ch1,
		coef_ch2,
		&mt_pulse,
		&control_flags,
		&filter_select_ch0,
		&filter_select_ch1,
		&filter_select_ch2,
		pulse_metadata_ch0,
		pulse_metadata_ch1,
		pulse_metadata_ch2,
		&sync_pulse
	);

	pulse_exec_definition term;
	term.terminate = true;
	pulse_metadata_ch0 << term;

	hcr_metadata_injector(
		i_data,
		o_data,
		pulse_metadata_ch0,
		&pos_enc_0,
		&pos_enc_1,
		&flags
	);

	std::cout << "\n";
	while(!o_data.empty())
	{
		pdti_32 odata = o_data.read();
		std::cout << std::hex << "user: " << odata.user << " data: " << odata.data << "\n";
	}

	while(!coef_ch0.empty()) std::cout << coef_ch0.read() << " "; std::cout << "\n";
	while(!coef_ch1.empty()) std::cout << coef_ch1.read() << " "; std::cout << "\n";
	while(!coef_ch2.empty()) std::cout << coef_ch2.read() << " "; std::cout << "\n";

	while(!pulse_metadata_ch1.empty()) pulse_metadata_ch1.read();
	while(!pulse_metadata_ch2.empty()) pulse_metadata_ch2.read();
}
