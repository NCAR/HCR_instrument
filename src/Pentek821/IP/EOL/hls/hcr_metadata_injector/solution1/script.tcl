############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
############################################################
open_project hcr_metadata_injector
set_top hcr_metadata_injector
add_files hcr_metadata_injector/hcr_metadata_injector.cpp
add_files -tb hcr_controller/hcr_controller.cpp
add_files -tb hcr_tb.cpp
open_solution "solution1"
set_part {xcku060-ffva1156-2-e} -tool vivado
create_clock -period 4 -name default
set_clock_uncertainty 1
#source "./hcr_metadata_injector/solution1/directives.tcl"
csim_design -compiler clang
csynth_design
cosim_design -trace_level port -rtl vhdl
export_design -rtl vhdl -format ip_catalog -description "Adds metadata to a PDTI stream in front of each pulse" -vendor "NCAR" -library "EOL"
