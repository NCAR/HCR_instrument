//
// hcr_controller.cpp
//    Author: Adam Karboski <karboski@ucar.edu>
//
// Copyright (c) 2021 University Corporation for Atmospheric Research
// All rights reserved.

#include "hcr_controller.h"

// Schedules pulses for the HCR radar
void hcr_controller(
		uint8_t cfg_pulse_sequence_start_index,
		uint8_t cfg_pulse_sequence_length,
		volatile uint32_t* cfg_num_pulses_to_execute,
		uint32_t cfg_decimation,
		uint32_t cfg_num_pulses_per_xfer,
		uint32_t cfg_enabled_channel_vector,
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
	)
{

	// AXI Config Ports
	#pragma HLS INTERFACE s_axilite bundle=cfg_bus port=return
	#pragma HLS INTERFACE s_axilite bundle=cfg_bus port=cfg_pulse_sequence_start_index
	#pragma HLS INTERFACE s_axilite bundle=cfg_bus port=cfg_pulse_sequence_length
	#pragma HLS INTERFACE s_axilite bundle=cfg_bus port=cfg_num_pulses_to_execute
	#pragma HLS INTERFACE s_axilite bundle=cfg_bus port=cfg_decimation
	#pragma HLS INTERFACE s_axilite bundle=cfg_bus port=cfg_num_pulses_per_xfer
	#pragma HLS INTERFACE s_axilite bundle=cfg_bus port=cfg_enabled_channel_vector
	#pragma HLS INTERFACE s_axilite bundle=cfg_bus port=cfg_pulse_sequence
	#pragma HLS ARRAY_PARTITION variable=cfg_pulse_sequence->prt complete
	#pragma HLS ARRAY_PARTITION variable=cfg_pulse_sequence->timer_offset complete
	#pragma HLS ARRAY_PARTITION variable=cfg_pulse_sequence->timer_width complete
	#pragma HLS INTERFACE s_axilite bundle=cfg_bus port=cfg_filter_coefs_ch0
	#pragma HLS INTERFACE s_axilite bundle=cfg_bus port=cfg_filter_coefs_ch1
	#pragma HLS INTERFACE s_axilite bundle=cfg_bus port=cfg_filter_coefs_ch2

	// Data ports
	#pragma HLS RESOURCE variable=pps core=RAM_1P //Less buggy than a plain volatile.
	#pragma HLS INTERFACE axis register both port=pulse_metadata_ch0
	#pragma HLS data_pack variable=pulse_metadata_ch0
	#pragma HLS INTERFACE axis register both port=pulse_metadata_ch1
	#pragma HLS data_pack variable=pulse_metadata_ch1
	#pragma HLS INTERFACE axis register both port=pulse_metadata_ch2
	#pragma HLS data_pack variable=pulse_metadata_ch2
	#pragma HLS INTERFACE axis register both port=coef_ch0
	#pragma HLS INTERFACE axis register both port=coef_ch1
	#pragma HLS INTERFACE axis register both port=coef_ch2

	// Pipe between the scheduler parser and the cycle-exact loop
	hls::stream<pulse_exec_definition> pulse_queue_scheduler;
	#pragma HLS stream depth=1 variable=pulse_queue_scheduler
	#pragma HLS data_pack variable=pulse_queue_scheduler

	// Pipe between the scheduler parser and the metadata inserter
	hls::stream<pulse_exec_definition> pulse_queue_ch0;
	#pragma HLS stream depth=16 variable=pulse_queue_ch0
	#pragma HLS data_pack variable=pulse_queue_ch0
	#pragma HLS RESOURCE core=FIFO_SRL variable=pulse_queue_ch0
	hls::stream<pulse_exec_definition> pulse_queue_ch1;
	#pragma HLS stream depth=16 variable=pulse_queue_ch1
	#pragma HLS data_pack variable=pulse_queue_ch1
	#pragma HLS RESOURCE core=FIFO_SRL variable=pulse_queue_ch1
	hls::stream<pulse_exec_definition> pulse_queue_ch2;
	#pragma HLS stream depth=16 variable=pulse_queue_ch2
	#pragma HLS data_pack variable=pulse_queue_ch2
	#pragma HLS RESOURCE core=FIFO_SRL variable=pulse_queue_ch2

	// The following two functions execute concurrently
	#pragma HLS dataflow

	scheduler_parser(
			cfg_pulse_sequence_start_index,
			cfg_pulse_sequence_length,
			cfg_num_pulses_to_execute,
			cfg_decimation,
			cfg_num_pulses_per_xfer,
			cfg_enabled_channel_vector,
			cfg_pulse_sequence,
			cfg_filter_coefs_ch0,
			cfg_filter_coefs_ch1,
			cfg_filter_coefs_ch2,
			coef_ch0,
			coef_ch1,
			coef_ch2,
			pulse_queue_ch0,
			pulse_queue_ch1,
			pulse_queue_ch2,
			pulse_queue_scheduler
		);

	scheduler_cycle_exact(
			pps,
			pulse_queue_scheduler,
			mt_pulse,
			control_flags,
			filter_select_ch0,
			filter_select_ch1,
			filter_select_ch2
		);

	output_fifo(pulse_queue_ch0, pulse_metadata_ch0);
	output_fifo(pulse_queue_ch1, pulse_metadata_ch1);
	output_fifo(pulse_queue_ch2, pulse_metadata_ch2);
};

// Generates a stream of pulses to execute
void scheduler_parser(
		uint32_t cfg_pulse_sequence_start_index,
		uint32_t cfg_pulse_sequence_length,
		volatile uint32_t* cfg_num_pulses_to_execute,
		uint32_t cfg_decimation,
		uint32_t cfg_num_pulses_per_xfer,
		ap_uint<3> cfg_enabled_channel_vector,
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
	)
{

	//Load the filter coefficients
	for(int set=0; set<N_COEF_SETS; ++set)
	{
		coef_ch0 << set;
		coef_ch1 << set;
		coef_ch2 << set;
		for(int coef=0; coef<N_FILTER_TAPS; coef++)
		{
			coef_ch0 << cfg_filter_coefs_ch0[set][N_FILTER_TAPS-1-coef];
			coef_ch1 << cfg_filter_coefs_ch1[set][N_FILTER_TAPS-1-coef];
			coef_ch2 << cfg_filter_coefs_ch2[set][N_FILTER_TAPS-1-coef];
		}
	}

	uint32_t num_pulses_scheduled = 0;
	uint32_t num_pulses_scheduled_this_xfer = 0;
	bool pulses_to_execute_reached = false;

	//Run until the specified number of pulses is hit
	while(true)
	{
		//Iterate through the pulse sequence table
		for(uint32_t seq_idx = 0; seq_idx < cfg_pulse_sequence_length; ++seq_idx )
		{
			//Retrieve the current definition in the pulse sequence
			pulse_definition pulse_definition = cfg_pulse_sequence[cfg_pulse_sequence_start_index + seq_idx];

			//Add the specified number of repetitions to the queue of pulses to execute
			uint8_t staggered_prt_index = 0;
			for(uint32_t pulse_rep = 0; pulse_rep < pulse_definition.num_pulses; ++pulse_rep)
			{
				pulse_exec_definition pulse;
				pulse.def = pulse_definition;
				pulse.terminate = false;
				pulse.sequence_index = cfg_pulse_sequence_start_index + seq_idx;
				pulse.first_pulse_in_block = (pulse_rep == 0);
				pulse.last_pulse_in_block = (pulse_rep == (pulse_definition.num_pulses-1));

				//Only execute the post time on the final pulse in the block
				if(!pulse.last_pulse_in_block)
					pulse.def.block_post_time = 0;

				//Select the correct staggered PRT
				pulse.def.prt[0] = pulse_definition.prt[staggered_prt_index];

		        // Number of data values. The total time is offset+width, unless truncated by the PRT
				uint32_t num_samples[3];
				for(int ch=0; ch<3; ch++)
				{
					#pragma HLS unroll
					const int mt = CHANNEL_TO_MT[ch];
					uint32_t totalTime = pulse.def.timer_offset[mt] + pulse.def.timer_width[mt];
					if(pulse.def.prt[0]<totalTime) totalTime = pulse.def.prt[0];
					uint32_t startTime = pulse.def.timer_offset[mt];
					uint32_t ns = (totalTime-startTime) / cfg_decimation;
					if(ns==0) ns=1;
					num_samples[ch] = ns;
				}

				//Check if done
				uint32_t pulses_to_execute = *cfg_num_pulses_to_execute;
				if(pulses_to_execute != 0 && num_pulses_scheduled >= pulses_to_execute)
				{
					pulses_to_execute_reached = true;
				}

				//Set the xfer start and end flags periodically
				pulse.first_pulse_in_xfer = (num_pulses_scheduled_this_xfer == 0);
				pulse.last_pulse_in_xfer = false;
				num_pulses_scheduled_this_xfer++;
				if(num_pulses_scheduled_this_xfer == cfg_num_pulses_per_xfer || pulses_to_execute_reached )
				{
					pulse.last_pulse_in_xfer = true;
					num_pulses_scheduled_this_xfer = 0;
				}

				//Send the pulse to the cycle-exact function, and to the metadata injectors
				pulse_queue_s << pulse;

				pulse.num_samples = num_samples[0];
				if (cfg_enabled_channel_vector[0]) pulse_queue_0 << pulse;

				pulse.num_samples = num_samples[1];
				if (cfg_enabled_channel_vector[1]) pulse_queue_1 << pulse;

				pulse.num_samples = num_samples[2];
				if (cfg_enabled_channel_vector[2]) pulse_queue_2 << pulse;

				num_pulses_scheduled++;

				if(pulses_to_execute_reached)
				{
					pulse_exec_definition term;
					term.terminate = true;
					pulse_queue_0 << term;
					pulse_queue_1 << term;
					pulse_queue_2 << term;
					pulse_queue_s << term;

					std::cout << "Scheduled " << num_pulses_scheduled << " pulses\n";
					return;
				}

				//Move to the next PRT, or back to 0 if at the end of the list
				staggered_prt_index++;
				if(staggered_prt_index==N_PRTS || pulse_definition.prt[staggered_prt_index]==0)
				{
					staggered_prt_index = 0;
				}
			}
		}
	}

};

// Executes the pulses with cycle-exact timing
void scheduler_cycle_exact(
		volatile bool pps[2],
		hls::stream<pulse_exec_definition>& pulse_queue,
		volatile ap_uint<N_TIMERS>* mt_pulse,
		volatile ap_uint<32>* control_flags,
		volatile ap_uint<2>* filter_select_ch0,
		volatile ap_uint<2>* filter_select_ch1,
		volatile ap_uint<2>* filter_select_ch2
	)
{

	pulse_exec_definition pulse;
	uint32_t prt_clock = 0;
	ap_uint<N_TIMERS> timer_vector;

	//Wait until the scheduler is configured
	bool got_pulse = false;
	wait_for_config : while(!got_pulse)
	{
		got_pulse = !pulse_queue.empty();
	};

	//Wait for a pulse per second
	bool got_pps = false;
	wait_for_pps : while(!got_pps)
	{
		#pragma HLS pipeline ii=1
		got_pps = *pps;
		pps++;
	};

	//This loop is evaluated every clock cycle
	run : while(true)
	{
		#pragma HLS pipeline ii=1

		//If it is the first cycle of the PRT, read the pulse parameters
		if(prt_clock == 0)
		{
			assert_readable(pulse_queue) >> pulse;
			prt_clock = 0;
			timer_vector = 0;
			if(pulse.terminate) break;
		}

		//Set the timer bits when their turn-on and turn-off times occur
		for(int t=0; t<N_TIMERS; ++t)
		{
			if(prt_clock == pulse.def.timer_offset[t]) timer_vector[t] = 1;
			if(prt_clock == pulse.def.timer_offset[t]+pulse.def.timer_width[t]) timer_vector[t] = 0;
		}

		//Latch the outputs
		{
			#pragma HLS protocol floating
			#pragma HLS latency min=0 max=0
			*mt_pulse = timer_vector;
			*control_flags = pulse.def.control_flags;
			*filter_select_ch0 = pulse.def.filter_select_ch0;
			*filter_select_ch1 = pulse.def.filter_select_ch1;
			*filter_select_ch2 = pulse.def.filter_select_ch2;
		}

		//Increment the cycle counter
		prt_clock++;

		//Check for the end of the pulse interval and clear the timer bits
		if(prt_clock == pulse.def.prt[0])
		{
			timer_vector = 0;
		}

		//At the end of the pulse interval, plus any applicable slack, tee up the next pulse
		if(prt_clock == pulse.def.prt[0]+pulse.def.block_post_time )
		{
			prt_clock = 0;
		}

	}
};

void output_fifo(
		hls::stream<pulse_exec_definition>& in,
		hls::stream<pulse_exec_definition>& out
	)
{
	while(true)
	{
		pulse_exec_definition pulse;
		assert_readable(in) >> pulse;
		if(pulse.terminate) break;
		out << pulse;
	}
}
