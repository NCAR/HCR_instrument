//
// hcr_controller_tb.cpp
//    Author: Adam Karboski <karboski@ucar.edu>
//
// Copyright (c) 2021 University Corporation for Atmospheric Research
// All rights reserved.

#include "hcr_controller/hcr_controller.h"
#include "hcr_metadata_injector/hcr_metadata_injector.h"

//mag phase algo in double precision for comparison to fixed-point
void MPdouble(double I, double Q, int16_t& packedPower, int16_t& packedPhase)
{
	packedPower = -32768;
	packedPhase = 0;

	const float max = 10 * log10( pow(2.0, 47) );
	const float min = 10 * log10( pow(2.0, -1) );
	const float range = max - min;
	const float scale = 65535.0 / range;
	const float offset = (max + min) / 2;
	const float phasescale = 32767.0 / M_PI;

	double power = I*I+Q*Q;
	if (power != 0)
	{
		double logPower = 10*log10(power);
		packedPower = floor((logPower - offset) * scale + 0.5);
		double phase = floor(atan2(Q, I) * phasescale + 0.5);
		if (phase < -32767) packedPhase = -32767;
		else if (phase > 32767) packedPhase = 32767;
		else packedPhase = phase;
	}
}

int main()
{

	uint32_t start = 0, stop = 1;
	uint32_t cfg_pulse_sequence_start_stop_indexes = stop<<16 | start;
	uint32_t cfg_num_pulses_to_execute = 24;
	uint32_t cfg_total_decimation = 16;
	uint32_t cfg_post_decimation = 2;
	uint32_t cfg_num_pulses_per_xfer = 3;
	uint32_t cfg_enabled_channel_vector = 7;
	uint32_t cfg_watchdog = 1;
	uint32_t cfg_use_mag_phase = 1;
	pulse_definition cfg_pulse_sequence[N_PULSE_DEFS] {};
	bool pps = 1;
	volatile ap_uint<N_TIMERS> mt_pulse;
	volatile ap_uint<32> control_flags;
	volatile bool control_hvn;
	volatile ap_uint<3> filter_select_ch0;
	volatile ap_uint<3> filter_select_ch1;
	volatile ap_uint<3> filter_select_ch2;
	volatile ap_uint<32> phase_sample;
	hls::stream<pdti_64> i_data("tb.i_data");
	hls::stream<pdti_32> o_data("tb.o_data");
	hls::stream<pulse_exec_definition> pulse_metadata_ch0("tb.meta_ch0");
	hls::stream<pulse_exec_definition> pulse_metadata_ch1("tb.meta_ch1");
	hls::stream<pulse_exec_definition> pulse_metadata_ch2("tb.meta_ch2");
	int32_t cfg_filter_coefs_ch0[N_COEF_SETS][N_FILTER_TAPS] {};
	int32_t cfg_filter_coefs_ch1[N_COEF_SETS][N_FILTER_TAPS] {};
	int32_t cfg_filter_coefs_ch2[N_COEF_SETS][N_FILTER_TAPS] {};
	uint32_t cfg_phase_samples[N_PHASE_SAMPLES] {0xFA5E00, 0xFA5E01, 0xFA5E02, 0xFA5E03, 0xFA5E04, 0};
	hls::stream<coef_t> coef_ch0;
	hls::stream<coef_t> coef_ch1;
	hls::stream<coef_t> coef_ch2;
	uint32_t pos_enc_0 = 0xDEADBEEF;
	uint32_t pos_enc_1 = 0xF00DCAFE;
	uint16_t flags = 1;

	cfg_pulse_sequence[0].num_pulses = 4;
	cfg_pulse_sequence[0].prt[0] = 128;
	cfg_pulse_sequence[0].block_post_time = 0;
	cfg_pulse_sequence[0].polarization_mode = POL_MODE_H;
	cfg_pulse_sequence[0].phase_table_begin = 1;
	cfg_pulse_sequence[0].phase_table_end = 2;
	for(int t=0;t<N_TIMERS;++t)
	{
		cfg_pulse_sequence[0].timer_offset[t] = 0;
		cfg_pulse_sequence[0].timer_width[t] = 10000;
	}

	cfg_pulse_sequence[1].num_pulses = 2;
	cfg_pulse_sequence[1].prt[0] = 100;
	cfg_pulse_sequence[1].block_post_time = 10;
	cfg_pulse_sequence[1].polarization_mode = POL_MODE_HHVV;
	cfg_pulse_sequence[1].phase_table_begin = 0;
	cfg_pulse_sequence[1].phase_table_end = 0;
	for(int t=0;t<N_TIMERS;++t)
	{
		cfg_pulse_sequence[1].timer_offset[t] = N_TIMERS-t;
		cfg_pulse_sequence[1].timer_width[t] = 63;
	}

	pdti_64 adc_data;
	for(int x=0; x<cfg_num_pulses_to_execute+1; ++x)
	{

		for(uint64_t k=0; k<16;k++)
		{
			adc_data.data = (k<<32) + 256*65536 + x*256 + k;
			adc_data.user++;
			adc_data.user[PDTI_SYNC] = (k==0);
			adc_data.user[PDTI_GATE] = (k<15);
			i_data << adc_data;
		}
	}

	//Add an extra sample to let the testbench finish
	adc_data.user++;
	adc_data.user[PDTI_SYNC] = 1;
	adc_data.user[PDTI_GATE] = 1;
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
		&cfg_pulse_sequence_start_stop_indexes,
		&cfg_num_pulses_to_execute,
		cfg_total_decimation,
		cfg_post_decimation,
		cfg_num_pulses_per_xfer,
		cfg_enabled_channel_vector,
		&cfg_watchdog,
		cfg_use_mag_phase,
		cfg_pulse_sequence,
		cfg_filter_coefs_ch0,
		cfg_filter_coefs_ch1,
		cfg_filter_coefs_ch2,
		cfg_phase_samples,
		coef_ch0,
		coef_ch1,
		coef_ch2,
		&mt_pulse,
		&control_flags,
		&control_hvn,
		&filter_select_ch0,
		&filter_select_ch1,
		&filter_select_ch2,
		&phase_sample,
		pulse_metadata_ch0,
		pulse_metadata_ch1,
		pulse_metadata_ch2,
		&pps
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
	int numSamples = 0;
	bool fail = false;
//	while(!o_data.empty())
//	{
//		pdti_32 odata = o_data.read();
//		std::cout << std::hex << odata.user[PDTI_GATE] << ", " << odata.data << "\n";
//	}
	while(!o_data.empty())
	{
		pdti_32 odata = o_data.read();
		if (odata.user[64]) {
			if (odata.data != 0xba5eba11) { std::cout << "BAD HEADER!\n"; fail = true; break; }
			std::cout << "\n\nPulse: " << std::hex << odata.data;
			for(int x=1;x<16;x++) {
				if(o_data.empty()) { std::cout << "INCOMPLETE HEADER!\n"; fail = true; break; }
				pdti_32 odata = o_data.read();
				if (!odata.user[64]) { std::cout << "INCOMPLETE HEADER!\n"; fail = true; break; }
				std::cout << ", " << std::hex << odata.data;
				if (x==5) numSamples = odata.data;
			}
			std::cout << "\n";
#ifdef FMT_24_BIT
			ap_uint<96> accum;
			for(int x=0; x<(numSamples*3/2); x++) {
				if(o_data.empty()) { std::cout << "INCOMPLETE DATA!\n"; fail = true; break; }
				if (!odata.user[64]) { std::cout << "INCOMPLETE DATA!\n"; fail = true; break; }
				odata = o_data.read();
				if(odata.data == 0x75757575) { std::cout << "BAD DATA!\n"; fail = true; break; }
				//std::cout << std::hex << "user: " << odata.user << " data: " << odata.data << "\n";
				accum = accum >> 32;
				accum(95,64) = odata.data;
				if(x%3 == 2) {
					std::cout << std::hex << std::setw(12) << std::setfill('0')
						<< std::noshowbase << uint64_t(accum(47,0)) << "\n";
					std::cout << std::hex << std::setw(12) << std::setfill('0')
						<< std::noshowbase << uint64_t(accum(95,48)) << "\n";
				}
			}
#else
			for(int x=0; x<numSamples; ++x) {
				if(o_data.empty()) { std::cout << "INCOMPLETE DATA!\n"; fail = true; break; }
				if (!odata.user[64]) { std::cout << "INCOMPLETE DATA!\n"; fail = true; break; }
				odata = o_data.read();
				if(odata.data == 0x75757575) { std::cout << "BAD DATA!\n"; fail = true; break; }
				std::cout << std::hex << std::setw(8) << std::setfill('0')
						  << std::noshowbase << uint64_t(odata.data) << "\n";
			}
#endif
		}
		else {
			std::cout << "EOB ";
		}
	}

	while(!coef_ch0.empty()) std::cout << coef_ch0.read() << " "; std::cout << "\n";
	while(!coef_ch1.empty()) std::cout << coef_ch1.read() << " "; std::cout << "\n";
	while(!coef_ch2.empty()) std::cout << coef_ch2.read() << " "; std::cout << "\n";

	while(!pulse_metadata_ch1.empty()) pulse_metadata_ch1.read();
	while(!pulse_metadata_ch2.empty()) pulse_metadata_ch2.read();

	if(fail) return -1;

	std::cout << std::dec;

	// Test mag/phase packing algorithm
	pdti_64 xx;
	hls::stream<pdti_32> o;
	double maxErrorMag = 0;
	double sumErrorMag = 0;
	double maxErrorPhase = 0;
	double sumErrorPhase = 0;
	for(int x=0; x<1000; ++x)
	{
		int scaledown = rand() % 24;
		int I = (rand() & 0xFFFFFF) - 0x7FFFFF;
		int Q = (rand() & 0xFFFFFF) - 0x7FFFFF;
		I = I >> scaledown;
		Q = Q >> scaledown;
		xx.data = 0;
		xx.data(31,0) = I;
		xx.data(63,32) = Q;
		write_16M16P(o, xx);
		pdti_32 packed = o.read();
		int16_t packedMag = int16_t(packed.data(15,0));
		int16_t packedPhase = int16_t(packed.data(31,16));

		double PHASE_MULT = 180.0 / 32767.0;
		double DEG_TO_RAD = M_PI / 180.0;
		double powerDbm = packedMag * powerScale + powerOffset;
		double power = pow(10.0, powerDbm / 10.0);
		double phaseDeg = packedPhase * PHASE_MULT;
		double sinPhase = sin(phaseDeg * DEG_TO_RAD);
		double cosPhase = cos(phaseDeg * DEG_TO_RAD);
		double mag = sqrt(power);
		if (mag == 0.0) {
			mag = 1.0e-20;
		}
		double Io = mag * cosPhase;
		double Qo = mag * sinPhase;
//		std::cout << (I-Io)/I*100 << " " << (Q-Qo)/Q*100 << std::endl;
		int16_t m;
		int16_t p;
		MPdouble(I, Q, m, p);
//		std::cout << I << "," << Q << "," << packedMag-m << "," << packedPhase-p << "\n";
		maxErrorMag = std::max(maxErrorMag, abs(double(packedMag-m)));
		maxErrorPhase = std::max(maxErrorPhase, abs(double(packedPhase-p)));
		sumErrorMag += (packedMag-m);
		sumErrorPhase += (packedPhase-p);
	}
	std::cout << "\nMagPhase errors: " << maxErrorMag << " " << maxErrorPhase << " " << sumErrorMag/1000.0 << " " << sumErrorPhase/1000.0 << std::endl;

	if (maxErrorMag > 1 || maxErrorPhase >1) return -50;

//	// Bias test the squasher algorithm
//	std::cout << std::dec << "Bias test for squasher...";
//	pdti_64 xx;
//	for(int x=0; x<1048576; ++x)
//	{
//
//		xx.data = 0;
//		xx.data(31,0) = x;
//		xx.data(63,32) = (rand() & 0xFFFFFF) - 0x7FFFFF;
//		int s1 = squash(xx).data;
//		int I1 = s1 << 14 >> 18 << (s1&15);
//		int Q1 = s1 >> 18 << (s1&15);
//
//		xx.data(31,0) = -x;
//		int s2 = squash(xx).data;
//		int I2 = s2 << 14 >> 18 << (s2&15);
//		int Q2 = s2 >> 18 << (s2&15);
//		if(I1 != -I2 || Q1 != Q2) {
//			std::cout << x << ":" << I1 << " " << (-x) << ":" << I2 << " " << int(xx.data(63,32)) << ":" << Q1 << ":" << Q2 << std::endl;
//			return 1;
//		}
//	}
//	std::cout << " done.\n";

	return 0;
}
