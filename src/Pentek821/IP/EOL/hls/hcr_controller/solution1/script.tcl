############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
############################################################
open_project hcr_controller
set_top hcr_controller
add_files hcr_controller/hcr_controller.cpp
add_files -tb hcr_metadata_injector/hcr_metadata_injector.cpp
add_files -tb hcr_tb.cpp
open_solution "solution1"
set_part {xcku060-ffva1517-2-e}
create_clock -period 5 -name default
config_sdx -optimization_level none -target none
config_export -vivado_optimization_level 2
set_clock_uncertainty 2
#source "./hcr_controller/solution1/directives.tcl"
csim_design -clean -O -compiler clang
csynth_design
cosim_design -trace_level all -rtl vhdl
export_design -rtl vhdl -format ip_catalog -description "Controls the radar schedule" -vendor "NCAR" -library "EOL"