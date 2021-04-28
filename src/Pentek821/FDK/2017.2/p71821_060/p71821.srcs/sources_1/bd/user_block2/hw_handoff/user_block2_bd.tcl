
################################################################
# This is a generated script based on design: user_block2
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2017.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source user_block2_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# position_encoder, enable_mux, enable_mux

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcku060-ffva1156-2-e
}


# CHANGE DESIGN NAME HERE
set design_name user_block2

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: fir
proc create_hier_cell_fir_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_fir_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 coef
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 i_data
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 o_data

  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: bcast, and set properties
  set bcast [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 bcast ]

  # Create instance: map_data, and set properties
  set map_data [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 map_data ]
  set_property -dict [ list \
CONFIG.M_HAS_TKEEP {0} \
CONFIG.M_HAS_TLAST {0} \
CONFIG.M_HAS_TREADY {1} \
CONFIG.M_HAS_TSTRB {0} \
CONFIG.M_TDATA_NUM_BYTES {4} \
CONFIG.M_TDEST_WIDTH {0} \
CONFIG.M_TID_WIDTH {0} \
CONFIG.M_TUSER_WIDTH {128} \
CONFIG.S_HAS_TKEEP {0} \
CONFIG.S_HAS_TLAST {0} \
CONFIG.S_HAS_TREADY {1} \
CONFIG.S_HAS_TSTRB {0} \
CONFIG.S_TDATA_NUM_BYTES {4} \
CONFIG.S_TDEST_WIDTH {0} \
CONFIG.S_TID_WIDTH {0} \
CONFIG.S_TUSER_WIDTH {128} \
CONFIG.TDATA_REMAP {tdata[31:0]} \
CONFIG.TUSER_REMAP {tuser[127:32],2'b0,tuser[29:0]} \
 ] $map_data

  # Create instance: map_fsel, and set properties
  set map_fsel [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 map_fsel ]
  set_property -dict [ list \
CONFIG.M_HAS_TKEEP {0} \
CONFIG.M_HAS_TLAST {0} \
CONFIG.M_HAS_TREADY {1} \
CONFIG.M_HAS_TSTRB {0} \
CONFIG.M_TDATA_NUM_BYTES {1} \
CONFIG.M_TDEST_WIDTH {0} \
CONFIG.M_TID_WIDTH {0} \
CONFIG.M_TUSER_WIDTH {0} \
CONFIG.S_HAS_TKEEP {0} \
CONFIG.S_HAS_TLAST {0} \
CONFIG.S_HAS_TREADY {1} \
CONFIG.S_HAS_TSTRB {0} \
CONFIG.S_TDATA_NUM_BYTES {4} \
CONFIG.S_TDEST_WIDTH {0} \
CONFIG.S_TID_WIDTH {0} \
CONFIG.S_TUSER_WIDTH {128} \
CONFIG.TDATA_REMAP {6'b0,tuser[31:30]} \
CONFIG.TUSER_REMAP {1'b0} \
 ] $map_fsel

  # Create instance: pulse_fir, and set properties
  set pulse_fir [ create_bd_cell -type ip -vlnv xilinx.com:ip:fir_compiler:7.2 pulse_fir ]
  set_property -dict [ list \
CONFIG.Blank_Output {false} \
CONFIG.CoefficientVector {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1} \
CONFIG.Coefficient_Fractional_Bits {22} \
CONFIG.Coefficient_Reload {true} \
CONFIG.Coefficient_Sets {4} \
CONFIG.Coefficient_Sign {Signed} \
CONFIG.Coefficient_Structure {Non_Symmetric} \
CONFIG.Coefficient_Width {24} \
CONFIG.ColumnConfig {48} \
CONFIG.DATA_Has_TLAST {Not_Required} \
CONFIG.DATA_TUSER_Width {128} \
CONFIG.Data_Fractional_Bits {15} \
CONFIG.Data_Width {16} \
CONFIG.DisplayReloadOrder {true} \
CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
CONFIG.Has_ARESETn {true} \
CONFIG.M_DATA_Has_TREADY {true} \
CONFIG.M_DATA_Has_TUSER {User_Field} \
CONFIG.Num_Reload_Slots {4} \
CONFIG.Number_Channels {1} \
CONFIG.Number_Paths {2} \
CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
CONFIG.Output_Width {24} \
CONFIG.Quantization {Quantize_Only} \
CONFIG.RateSpecification {Input_Sample_Period} \
CONFIG.Reset_Data_Vector {true} \
CONFIG.S_DATA_Has_FIFO {true} \
CONFIG.S_DATA_Has_TUSER {User_Field} \
CONFIG.SamplePeriod {1} \
CONFIG.Select_Pattern {All} \
 ] $pulse_fir

  # Create instance: trim_data, and set properties
  set trim_data [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 trim_data ]
  set_property -dict [ list \
CONFIG.M_TDATA_NUM_BYTES {4} \
CONFIG.S_TDATA_NUM_BYTES {6} \
CONFIG.TDATA_REMAP {tdata[39:24],tdata[15:0]} \
 ] $trim_data

  # Create interface connections
  connect_bd_intf_net -intf_net axis_broadcaster_0_M00_AXIS [get_bd_intf_pins bcast/M00_AXIS] [get_bd_intf_pins map_data/S_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M01_AXIS [get_bd_intf_pins bcast/M01_AXIS] [get_bd_intf_pins map_fsel/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins i_data] [get_bd_intf_pins bcast/S_AXIS]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS [get_bd_intf_pins map_fsel/M_AXIS] [get_bd_intf_pins pulse_fir/S_AXIS_CONFIG]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS2 [get_bd_intf_pins o_data] [get_bd_intf_pins trim_data/M_AXIS]
  connect_bd_intf_net -intf_net axis_subset_converter_1_M_AXIS [get_bd_intf_pins map_data/M_AXIS] [get_bd_intf_pins pulse_fir/S_AXIS_DATA]
  connect_bd_intf_net -intf_net coef_1 [get_bd_intf_pins coef] [get_bd_intf_pins pulse_fir/S_AXIS_RELOAD]
  connect_bd_intf_net -intf_net pulse_fir_0_M_AXIS_DATA [get_bd_intf_pins pulse_fir/M_AXIS_DATA] [get_bd_intf_pins trim_data/S_AXIS]

  # Create port connections
  connect_bd_net -net s_axis_adc_pdti_aclk_1 [get_bd_pins aclk] [get_bd_pins bcast/aclk] [get_bd_pins map_data/aclk] [get_bd_pins map_fsel/aclk] [get_bd_pins pulse_fir/aclk] [get_bd_pins trim_data/aclk]
  connect_bd_net -net s_axis_adc_pdti_aresetn_1 [get_bd_pins aresetn] [get_bd_pins bcast/aresetn] [get_bd_pins map_data/aresetn] [get_bd_pins map_fsel/aresetn] [get_bd_pins pulse_fir/aresetn] [get_bd_pins trim_data/aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: fir
proc create_hier_cell_fir_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_fir_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 coef
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 i_data
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 o_data

  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: bcast, and set properties
  set bcast [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 bcast ]

  # Create instance: map_data, and set properties
  set map_data [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 map_data ]
  set_property -dict [ list \
CONFIG.M_HAS_TKEEP {0} \
CONFIG.M_HAS_TLAST {0} \
CONFIG.M_HAS_TREADY {1} \
CONFIG.M_HAS_TSTRB {0} \
CONFIG.M_TDATA_NUM_BYTES {4} \
CONFIG.M_TDEST_WIDTH {0} \
CONFIG.M_TID_WIDTH {0} \
CONFIG.M_TUSER_WIDTH {128} \
CONFIG.S_HAS_TKEEP {0} \
CONFIG.S_HAS_TLAST {0} \
CONFIG.S_HAS_TREADY {1} \
CONFIG.S_HAS_TSTRB {0} \
CONFIG.S_TDATA_NUM_BYTES {4} \
CONFIG.S_TDEST_WIDTH {0} \
CONFIG.S_TID_WIDTH {0} \
CONFIG.S_TUSER_WIDTH {128} \
CONFIG.TDATA_REMAP {tdata[31:0]} \
CONFIG.TUSER_REMAP {tuser[127:32],2'b0,tuser[29:0]} \
 ] $map_data

  # Create instance: map_fsel, and set properties
  set map_fsel [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 map_fsel ]
  set_property -dict [ list \
CONFIG.M_HAS_TKEEP {0} \
CONFIG.M_HAS_TLAST {0} \
CONFIG.M_HAS_TREADY {1} \
CONFIG.M_HAS_TSTRB {0} \
CONFIG.M_TDATA_NUM_BYTES {1} \
CONFIG.M_TDEST_WIDTH {0} \
CONFIG.M_TID_WIDTH {0} \
CONFIG.M_TUSER_WIDTH {0} \
CONFIG.S_HAS_TKEEP {0} \
CONFIG.S_HAS_TLAST {0} \
CONFIG.S_HAS_TREADY {1} \
CONFIG.S_HAS_TSTRB {0} \
CONFIG.S_TDATA_NUM_BYTES {4} \
CONFIG.S_TDEST_WIDTH {0} \
CONFIG.S_TID_WIDTH {0} \
CONFIG.S_TUSER_WIDTH {128} \
CONFIG.TDATA_REMAP {6'b0,tuser[31:30]} \
CONFIG.TUSER_REMAP {1'b0} \
 ] $map_fsel

  # Create instance: pulse_fir, and set properties
  set pulse_fir [ create_bd_cell -type ip -vlnv xilinx.com:ip:fir_compiler:7.2 pulse_fir ]
  set_property -dict [ list \
CONFIG.Blank_Output {false} \
CONFIG.CoefficientVector {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1} \
CONFIG.Coefficient_Fractional_Bits {22} \
CONFIG.Coefficient_Reload {true} \
CONFIG.Coefficient_Sets {4} \
CONFIG.Coefficient_Sign {Signed} \
CONFIG.Coefficient_Structure {Non_Symmetric} \
CONFIG.Coefficient_Width {24} \
CONFIG.ColumnConfig {48} \
CONFIG.DATA_Has_TLAST {Not_Required} \
CONFIG.DATA_TUSER_Width {128} \
CONFIG.Data_Fractional_Bits {15} \
CONFIG.Data_Width {16} \
CONFIG.DisplayReloadOrder {true} \
CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
CONFIG.Has_ARESETn {true} \
CONFIG.M_DATA_Has_TREADY {true} \
CONFIG.M_DATA_Has_TUSER {User_Field} \
CONFIG.Num_Reload_Slots {4} \
CONFIG.Number_Channels {1} \
CONFIG.Number_Paths {2} \
CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
CONFIG.Output_Width {24} \
CONFIG.Quantization {Quantize_Only} \
CONFIG.RateSpecification {Input_Sample_Period} \
CONFIG.Reset_Data_Vector {true} \
CONFIG.S_DATA_Has_FIFO {true} \
CONFIG.S_DATA_Has_TUSER {User_Field} \
CONFIG.SamplePeriod {1} \
CONFIG.Select_Pattern {All} \
 ] $pulse_fir

  # Create instance: trim_data, and set properties
  set trim_data [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 trim_data ]
  set_property -dict [ list \
CONFIG.M_TDATA_NUM_BYTES {4} \
CONFIG.S_TDATA_NUM_BYTES {6} \
CONFIG.TDATA_REMAP {tdata[39:24],tdata[15:0]} \
 ] $trim_data

  # Create interface connections
  connect_bd_intf_net -intf_net axis_broadcaster_0_M00_AXIS [get_bd_intf_pins bcast/M00_AXIS] [get_bd_intf_pins map_data/S_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M01_AXIS [get_bd_intf_pins bcast/M01_AXIS] [get_bd_intf_pins map_fsel/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins i_data] [get_bd_intf_pins bcast/S_AXIS]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS [get_bd_intf_pins map_fsel/M_AXIS] [get_bd_intf_pins pulse_fir/S_AXIS_CONFIG]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS2 [get_bd_intf_pins o_data] [get_bd_intf_pins trim_data/M_AXIS]
  connect_bd_intf_net -intf_net axis_subset_converter_1_M_AXIS [get_bd_intf_pins map_data/M_AXIS] [get_bd_intf_pins pulse_fir/S_AXIS_DATA]
  connect_bd_intf_net -intf_net coef_1 [get_bd_intf_pins coef] [get_bd_intf_pins pulse_fir/S_AXIS_RELOAD]
  connect_bd_intf_net -intf_net pulse_fir_0_M_AXIS_DATA [get_bd_intf_pins pulse_fir/M_AXIS_DATA] [get_bd_intf_pins trim_data/S_AXIS]

  # Create port connections
  connect_bd_net -net s_axis_adc_pdti_aclk_1 [get_bd_pins aclk] [get_bd_pins bcast/aclk] [get_bd_pins map_data/aclk] [get_bd_pins map_fsel/aclk] [get_bd_pins pulse_fir/aclk] [get_bd_pins trim_data/aclk]
  connect_bd_net -net s_axis_adc_pdti_aresetn_1 [get_bd_pins aresetn] [get_bd_pins bcast/aresetn] [get_bd_pins map_data/aresetn] [get_bd_pins map_fsel/aresetn] [get_bd_pins pulse_fir/aresetn] [get_bd_pins trim_data/aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: fir
proc create_hier_cell_fir { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_fir() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 coef
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 i_data
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 o_data

  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: bcast, and set properties
  set bcast [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 bcast ]

  # Create instance: map_data, and set properties
  set map_data [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 map_data ]
  set_property -dict [ list \
CONFIG.M_HAS_TKEEP {0} \
CONFIG.M_HAS_TLAST {0} \
CONFIG.M_HAS_TREADY {1} \
CONFIG.M_HAS_TSTRB {0} \
CONFIG.M_TDATA_NUM_BYTES {4} \
CONFIG.M_TDEST_WIDTH {0} \
CONFIG.M_TID_WIDTH {0} \
CONFIG.M_TUSER_WIDTH {128} \
CONFIG.S_HAS_TKEEP {0} \
CONFIG.S_HAS_TLAST {0} \
CONFIG.S_HAS_TREADY {1} \
CONFIG.S_HAS_TSTRB {0} \
CONFIG.S_TDATA_NUM_BYTES {4} \
CONFIG.S_TDEST_WIDTH {0} \
CONFIG.S_TID_WIDTH {0} \
CONFIG.S_TUSER_WIDTH {128} \
CONFIG.TDATA_REMAP {tdata[31:0]} \
CONFIG.TUSER_REMAP {tuser[127:32],2'b0,tuser[29:0]} \
 ] $map_data

  # Create instance: map_fsel, and set properties
  set map_fsel [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 map_fsel ]
  set_property -dict [ list \
CONFIG.M_HAS_TKEEP {0} \
CONFIG.M_HAS_TLAST {0} \
CONFIG.M_HAS_TREADY {1} \
CONFIG.M_HAS_TSTRB {0} \
CONFIG.M_TDATA_NUM_BYTES {1} \
CONFIG.M_TDEST_WIDTH {0} \
CONFIG.M_TID_WIDTH {0} \
CONFIG.M_TUSER_WIDTH {0} \
CONFIG.S_HAS_TKEEP {0} \
CONFIG.S_HAS_TLAST {0} \
CONFIG.S_HAS_TREADY {1} \
CONFIG.S_HAS_TSTRB {0} \
CONFIG.S_TDATA_NUM_BYTES {4} \
CONFIG.S_TDEST_WIDTH {0} \
CONFIG.S_TID_WIDTH {0} \
CONFIG.S_TUSER_WIDTH {128} \
CONFIG.TDATA_REMAP {6'b0,tuser[31:30]} \
CONFIG.TUSER_REMAP {1'b0} \
 ] $map_fsel

  # Create instance: pulse_fir, and set properties
  set pulse_fir [ create_bd_cell -type ip -vlnv xilinx.com:ip:fir_compiler:7.2 pulse_fir ]
  set_property -dict [ list \
CONFIG.Blank_Output {false} \
CONFIG.CoefficientVector {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1} \
CONFIG.Coefficient_Fractional_Bits {22} \
CONFIG.Coefficient_Reload {true} \
CONFIG.Coefficient_Sets {4} \
CONFIG.Coefficient_Sign {Signed} \
CONFIG.Coefficient_Structure {Non_Symmetric} \
CONFIG.Coefficient_Width {24} \
CONFIG.ColumnConfig {48} \
CONFIG.DATA_Has_TLAST {Not_Required} \
CONFIG.DATA_TUSER_Width {128} \
CONFIG.Data_Fractional_Bits {15} \
CONFIG.Data_Width {16} \
CONFIG.DisplayReloadOrder {true} \
CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
CONFIG.Has_ARESETn {true} \
CONFIG.M_DATA_Has_TREADY {true} \
CONFIG.M_DATA_Has_TUSER {User_Field} \
CONFIG.Num_Reload_Slots {4} \
CONFIG.Number_Channels {1} \
CONFIG.Number_Paths {2} \
CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
CONFIG.Output_Width {24} \
CONFIG.Quantization {Quantize_Only} \
CONFIG.RateSpecification {Input_Sample_Period} \
CONFIG.Reset_Data_Vector {true} \
CONFIG.S_DATA_Has_FIFO {true} \
CONFIG.S_DATA_Has_TUSER {User_Field} \
CONFIG.SamplePeriod {1} \
CONFIG.Select_Pattern {All} \
 ] $pulse_fir

  # Create instance: trim_data, and set properties
  set trim_data [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 trim_data ]
  set_property -dict [ list \
CONFIG.M_TDATA_NUM_BYTES {4} \
CONFIG.S_TDATA_NUM_BYTES {6} \
CONFIG.TDATA_REMAP {tdata[39:24],tdata[15:0]} \
 ] $trim_data

  # Create interface connections
  connect_bd_intf_net -intf_net axis_broadcaster_0_M00_AXIS [get_bd_intf_pins bcast/M00_AXIS] [get_bd_intf_pins map_data/S_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M01_AXIS [get_bd_intf_pins bcast/M01_AXIS] [get_bd_intf_pins map_fsel/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins i_data] [get_bd_intf_pins bcast/S_AXIS]
  set_property -dict [ list \
HDL_ATTRIBUTE.DEBUG {true} \
 ] [get_bd_intf_nets axis_data_fifo_0_M_AXIS]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS [get_bd_intf_pins map_fsel/M_AXIS] [get_bd_intf_pins pulse_fir/S_AXIS_CONFIG]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS2 [get_bd_intf_pins o_data] [get_bd_intf_pins trim_data/M_AXIS]
  set_property -dict [ list \
HDL_ATTRIBUTE.DEBUG {true} \
 ] [get_bd_intf_nets axis_subset_converter_0_M_AXIS2]
  connect_bd_intf_net -intf_net axis_subset_converter_1_M_AXIS [get_bd_intf_pins map_data/M_AXIS] [get_bd_intf_pins pulse_fir/S_AXIS_DATA]
  connect_bd_intf_net -intf_net coef_1 [get_bd_intf_pins coef] [get_bd_intf_pins pulse_fir/S_AXIS_RELOAD]
  connect_bd_intf_net -intf_net pulse_fir_0_M_AXIS_DATA [get_bd_intf_pins pulse_fir/M_AXIS_DATA] [get_bd_intf_pins trim_data/S_AXIS]

  # Create port connections
  connect_bd_net -net s_axis_adc_pdti_aclk_1 [get_bd_pins aclk] [get_bd_pins bcast/aclk] [get_bd_pins map_data/aclk] [get_bd_pins map_fsel/aclk] [get_bd_pins pulse_fir/aclk] [get_bd_pins trim_data/aclk]
  connect_bd_net -net s_axis_adc_pdti_aresetn_1 [get_bd_pins aresetn] [get_bd_pins bcast/aresetn] [get_bd_pins map_data/aresetn] [get_bd_pins map_fsel/aresetn] [get_bd_pins pulse_fir/aresetn] [get_bd_pins trim_data/aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: dsp_ch2
proc create_hier_cell_dsp_ch2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_dsp_ch2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 coef
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 in_pdti
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 out_pdti
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 pulse_metadata

  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -from 15 -to 0 -type data flags
  create_bd_pin -dir I -from 31 -to 0 -type data pos_enc_0
  create_bd_pin -dir I -from 31 -to 0 -type data pos_enc_1

  # Create instance: fifo, and set properties
  set fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:1.1 fifo ]
  set_property -dict [ list \
CONFIG.FIFO_DEPTH {16} \
 ] $fifo

  # Create instance: fir
  create_hier_cell_fir_2 $hier_obj fir

  # Create instance: metadata_injector, and set properties
  set metadata_injector [ create_bd_cell -type ip -vlnv NCAR:EOL:hcr_metadata_injector:1.0 metadata_injector ]

  # Create instance: one, and set properties
  set one [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 one ]

  # Create instance: remove_unused_sigs, and set properties
  set remove_unused_sigs [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 remove_unused_sigs ]
  set_property -dict [ list \
CONFIG.M_HAS_TKEEP {0} \
CONFIG.M_HAS_TLAST {0} \
CONFIG.M_HAS_TREADY {0} \
CONFIG.M_HAS_TSTRB {0} \
CONFIG.M_TDEST_WIDTH {0} \
CONFIG.M_TID_WIDTH {0} \
 ] $remove_unused_sigs

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins pulse_metadata] [get_bd_intf_pins metadata_injector/pulse_metadata_V]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins fifo/M_AXIS] [get_bd_intf_pins fir/i_data]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS1 [get_bd_intf_pins out_pdti] [get_bd_intf_pins remove_unused_sigs/M_AXIS]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS2 [get_bd_intf_pins fir/o_data] [get_bd_intf_pins metadata_injector/i_data]
  connect_bd_intf_net -intf_net coef_1 [get_bd_intf_pins coef] [get_bd_intf_pins fir/coef]
  connect_bd_intf_net -intf_net metadata_injector_o_data [get_bd_intf_pins metadata_injector/o_data] [get_bd_intf_pins remove_unused_sigs/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_adc_ch0_pdti_1 [get_bd_intf_pins in_pdti] [get_bd_intf_pins fifo/S_AXIS]

  # Create port connections
  connect_bd_net -net flags_1 [get_bd_pins flags] [get_bd_pins metadata_injector/flags]
  connect_bd_net -net one_dout [get_bd_pins metadata_injector/ap_start] [get_bd_pins one/dout]
  connect_bd_net -net pos_enc_0_1 [get_bd_pins pos_enc_0] [get_bd_pins metadata_injector/pos_enc_0]
  connect_bd_net -net pos_enc_1_1 [get_bd_pins pos_enc_1] [get_bd_pins metadata_injector/pos_enc_1]
  connect_bd_net -net s_axis_adc_pdti_aclk_1 [get_bd_pins aclk] [get_bd_pins fifo/s_axis_aclk] [get_bd_pins fir/aclk] [get_bd_pins metadata_injector/ap_clk] [get_bd_pins remove_unused_sigs/aclk]
  connect_bd_net -net s_axis_adc_pdti_aresetn_1 [get_bd_pins aresetn] [get_bd_pins fifo/s_axis_aresetn] [get_bd_pins fir/aresetn] [get_bd_pins metadata_injector/ap_rst_n] [get_bd_pins remove_unused_sigs/aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: dsp_ch1
proc create_hier_cell_dsp_ch1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_dsp_ch1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 coef
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 in_pdti
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 out_pdti
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 pulse_metadata

  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -from 15 -to 0 -type data flags
  create_bd_pin -dir I -from 31 -to 0 -type data pos_enc_0
  create_bd_pin -dir I -from 31 -to 0 -type data pos_enc_1

  # Create instance: fifo, and set properties
  set fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:1.1 fifo ]
  set_property -dict [ list \
CONFIG.FIFO_DEPTH {16} \
 ] $fifo

  # Create instance: fir
  create_hier_cell_fir_1 $hier_obj fir

  # Create instance: metadata_injector, and set properties
  set metadata_injector [ create_bd_cell -type ip -vlnv NCAR:EOL:hcr_metadata_injector:1.0 metadata_injector ]

  # Create instance: one, and set properties
  set one [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 one ]

  # Create instance: remove_unused_sigs, and set properties
  set remove_unused_sigs [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 remove_unused_sigs ]
  set_property -dict [ list \
CONFIG.M_HAS_TKEEP {0} \
CONFIG.M_HAS_TLAST {0} \
CONFIG.M_HAS_TREADY {0} \
CONFIG.M_HAS_TSTRB {0} \
CONFIG.M_TDEST_WIDTH {0} \
CONFIG.M_TID_WIDTH {0} \
 ] $remove_unused_sigs

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins pulse_metadata] [get_bd_intf_pins metadata_injector/pulse_metadata_V]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins fifo/M_AXIS] [get_bd_intf_pins fir/i_data]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS1 [get_bd_intf_pins out_pdti] [get_bd_intf_pins remove_unused_sigs/M_AXIS]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS2 [get_bd_intf_pins fir/o_data] [get_bd_intf_pins metadata_injector/i_data]
  connect_bd_intf_net -intf_net coef_1 [get_bd_intf_pins coef] [get_bd_intf_pins fir/coef]
  connect_bd_intf_net -intf_net metadata_injector_o_data [get_bd_intf_pins metadata_injector/o_data] [get_bd_intf_pins remove_unused_sigs/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_adc_ch0_pdti_1 [get_bd_intf_pins in_pdti] [get_bd_intf_pins fifo/S_AXIS]

  # Create port connections
  connect_bd_net -net flags_1 [get_bd_pins flags] [get_bd_pins metadata_injector/flags]
  connect_bd_net -net one_dout [get_bd_pins metadata_injector/ap_start] [get_bd_pins one/dout]
  connect_bd_net -net pos_enc_0_1 [get_bd_pins pos_enc_0] [get_bd_pins metadata_injector/pos_enc_0]
  connect_bd_net -net pos_enc_1_1 [get_bd_pins pos_enc_1] [get_bd_pins metadata_injector/pos_enc_1]
  connect_bd_net -net s_axis_adc_pdti_aclk_1 [get_bd_pins aclk] [get_bd_pins fifo/s_axis_aclk] [get_bd_pins fir/aclk] [get_bd_pins metadata_injector/ap_clk] [get_bd_pins remove_unused_sigs/aclk]
  connect_bd_net -net s_axis_adc_pdti_aresetn_1 [get_bd_pins aresetn] [get_bd_pins fifo/s_axis_aresetn] [get_bd_pins fir/aresetn] [get_bd_pins metadata_injector/ap_rst_n] [get_bd_pins remove_unused_sigs/aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: dsp_ch0
proc create_hier_cell_dsp_ch0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_dsp_ch0() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 coef
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 in_pdti
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 out_pdti
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 pulse_metadata

  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -from 15 -to 0 -type data flags
  create_bd_pin -dir I -from 31 -to 0 -type data pos_enc_0
  create_bd_pin -dir I -from 31 -to 0 -type data pos_enc_1

  # Create instance: fifo, and set properties
  set fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:1.1 fifo ]
  set_property -dict [ list \
CONFIG.FIFO_DEPTH {16} \
 ] $fifo

  # Create instance: fir
  create_hier_cell_fir $hier_obj fir

  # Create instance: metadata_injector, and set properties
  set metadata_injector [ create_bd_cell -type ip -vlnv NCAR:EOL:hcr_metadata_injector:1.0 metadata_injector ]

  # Create instance: one, and set properties
  set one [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 one ]

  # Create instance: remove_unused_sigs, and set properties
  set remove_unused_sigs [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 remove_unused_sigs ]
  set_property -dict [ list \
CONFIG.M_HAS_TKEEP {0} \
CONFIG.M_HAS_TLAST {0} \
CONFIG.M_HAS_TREADY {0} \
CONFIG.M_HAS_TSTRB {0} \
CONFIG.M_TDEST_WIDTH {0} \
CONFIG.M_TID_WIDTH {0} \
 ] $remove_unused_sigs

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins pulse_metadata] [get_bd_intf_pins metadata_injector/pulse_metadata_V]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins fifo/M_AXIS] [get_bd_intf_pins fir/i_data]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS1 [get_bd_intf_pins out_pdti] [get_bd_intf_pins remove_unused_sigs/M_AXIS]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS2 [get_bd_intf_pins fir/o_data] [get_bd_intf_pins metadata_injector/i_data]
  connect_bd_intf_net -intf_net coef_1 [get_bd_intf_pins coef] [get_bd_intf_pins fir/coef]
  connect_bd_intf_net -intf_net metadata_injector_o_data [get_bd_intf_pins metadata_injector/o_data] [get_bd_intf_pins remove_unused_sigs/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_adc_ch0_pdti_1 [get_bd_intf_pins in_pdti] [get_bd_intf_pins fifo/S_AXIS]

  # Create port connections
  connect_bd_net -net flags_1 [get_bd_pins flags] [get_bd_pins metadata_injector/flags]
  connect_bd_net -net one_dout [get_bd_pins metadata_injector/ap_start] [get_bd_pins one/dout]
  connect_bd_net -net pos_enc_0_1 [get_bd_pins pos_enc_0] [get_bd_pins metadata_injector/pos_enc_0]
  connect_bd_net -net pos_enc_1_1 [get_bd_pins pos_enc_1] [get_bd_pins metadata_injector/pos_enc_1]
  connect_bd_net -net s_axis_adc_pdti_aclk_1 [get_bd_pins aclk] [get_bd_pins fifo/s_axis_aclk] [get_bd_pins fir/aclk] [get_bd_pins metadata_injector/ap_clk] [get_bd_pins remove_unused_sigs/aclk]
  connect_bd_net -net s_axis_adc_pdti_aresetn_1 [get_bd_pins aresetn] [get_bd_pins fifo/s_axis_aresetn] [get_bd_pins fir/aresetn] [get_bd_pins metadata_injector/ap_rst_n] [get_bd_pins remove_unused_sigs/aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: csr
proc create_hier_cell_csr { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_csr() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 adc_csr
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_csr

  # Create pins
  create_bd_pin -dir O adc_aresetn
  create_bd_pin -dir O controller_PPS
  create_bd_pin -dir O -from 31 -to 0 ctl2_out
  create_bd_pin -dir I i_controller_PPS
  create_bd_pin -dir I -type clk s_axi_csr_aclk
  create_bd_pin -dir I -type rst s_axi_csr_aresetn
  create_bd_pin -dir I -type clk s_axis_adc_pdti_aclk
  create_bd_pin -dir I -type rst s_axis_adc_pdti_aresetn

  # Create instance: axi_interc, and set properties
  set axi_interc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interc ]
  set_property -dict [ list \
CONFIG.M00_HAS_REGSLICE {3} \
CONFIG.M01_HAS_REGSLICE {3} \
CONFIG.M02_HAS_REGSLICE {3} \
CONFIG.M03_HAS_REGSLICE {3} \
CONFIG.M04_HAS_REGSLICE {3} \
CONFIG.NUM_MI {2} \
CONFIG.S00_HAS_REGSLICE {1} \
 ] $axi_interc

  # Create instance: general_purpose_reg_0, and set properties
  set general_purpose_reg_0 [ create_bd_cell -type ip -vlnv pentek.com:px_ip:px_axil_csr:1.0 general_purpose_reg_0 ]
  set_property -dict [ list \
CONFIG.has_interrupt_regs {false} \
CONFIG.num_ctl_regs {3} \
CONFIG.num_stat_regs {0} \
 ] $general_purpose_reg_0

  # Create instance: px_vctr2scalar_0, and set properties
  set px_vctr2scalar_0 [ create_bd_cell -type ip -vlnv pentek.com:px_ip:px_vctr2scalar:1.0 px_vctr2scalar_0 ]
  set_property -dict [ list \
CONFIG.invert {false} \
 ] $px_vctr2scalar_0

  # Create instance: px_vctr2scalar_1, and set properties
  set px_vctr2scalar_1 [ create_bd_cell -type ip -vlnv pentek.com:px_ip:px_vctr2scalar:1.0 px_vctr2scalar_1 ]
  set_property -dict [ list \
CONFIG.invert {false} \
 ] $px_vctr2scalar_1

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
CONFIG.C_OPERATION {or} \
CONFIG.C_SIZE {1} \
CONFIG.LOGO_FILE {data/sym_orgate.png} \
 ] $util_vector_logic_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
CONFIG.CONST_WIDTH {32} \
 ] $xlconstant_0

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]

  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1 ]

  # Create interface connections
  connect_bd_intf_net -intf_net axi_interc_M00_AXI [get_bd_intf_pins axi_interc/M00_AXI] [get_bd_intf_pins general_purpose_reg_0/s_axi_csr]
  connect_bd_intf_net -intf_net axi_interc_M01_AXI [get_bd_intf_pins adc_csr] [get_bd_intf_pins axi_interc/M01_AXI]
  connect_bd_intf_net -intf_net s_axi_csr_1 [get_bd_intf_pins s_axi_csr] [get_bd_intf_pins axi_interc/S00_AXI]

  # Create port connections
  connect_bd_net -net aresetn_1 [get_bd_pins adc_aresetn] [get_bd_pins px_vctr2scalar_0/output_scalar]
  connect_bd_net -net general_purpose_reg_0_ctl1_out [get_bd_pins general_purpose_reg_0/ctl1_out] [get_bd_pins xlslice_1/Din]
  connect_bd_net -net general_purpose_reg_0_ctl2_out [get_bd_pins ctl2_out] [get_bd_pins general_purpose_reg_0/ctl2_out]
  connect_bd_net -net i_controller_PPS_1 [get_bd_pins i_controller_PPS] [get_bd_pins util_vector_logic_0/Op2]
  connect_bd_net -net px_vctr2scalar_1_output_scalar [get_bd_pins controller_PPS] [get_bd_pins px_vctr2scalar_1/output_scalar]
  connect_bd_net -net reset_reg_0_ctl0_out [get_bd_pins general_purpose_reg_0/ctl0_out] [get_bd_pins xlslice_0/Din]
  connect_bd_net -net s_axi_csr_aclk_1 [get_bd_pins s_axi_csr_aclk] [get_bd_pins axi_interc/ACLK] [get_bd_pins axi_interc/S00_ACLK]
  connect_bd_net -net s_axi_csr_aresetn_1 [get_bd_pins s_axi_csr_aresetn] [get_bd_pins axi_interc/ARESETN] [get_bd_pins axi_interc/S00_ARESETN]
  connect_bd_net -net s_axis_adc_pdti_aclk_1 [get_bd_pins s_axis_adc_pdti_aclk] [get_bd_pins axi_interc/M00_ACLK] [get_bd_pins axi_interc/M01_ACLK] [get_bd_pins general_purpose_reg_0/s_axi_csr_aclk]
  connect_bd_net -net s_axis_adc_pdti_aresetn_1 [get_bd_pins s_axis_adc_pdti_aresetn] [get_bd_pins axi_interc/M00_ARESETN] [get_bd_pins axi_interc/M01_ARESETN] [get_bd_pins general_purpose_reg_0/s_axi_csr_aresetn]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins px_vctr2scalar_1/input_vector] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net xlconstant_0_dout_1 [get_bd_pins general_purpose_reg_0/reg0_init_val] [get_bd_pins general_purpose_reg_0/reg1_init_val] [get_bd_pins general_purpose_reg_0/reg2_init_val] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins px_vctr2scalar_0/input_vector] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins util_vector_logic_0/Op1] [get_bd_pins xlslice_1/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: controller
proc create_hier_cell_controller { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_controller() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 coef_ch0
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 coef_ch1
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 coef_ch2
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 pulse_metadata_ch0
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 pulse_metadata_ch1
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 pulse_metadata_ch2
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_cfg_bus

  # Create pins
  create_bd_pin -dir I -type clk adc_aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir O -from 31 -to 0 -type data control_flags
  create_bd_pin -dir I controller_PPS
  create_bd_pin -dir O -from 1 -to 0 -type data filter_select_ch0
  create_bd_pin -dir O -from 1 -to 0 -type data filter_select_ch1
  create_bd_pin -dir O -from 1 -to 0 -type data filter_select_ch2
  create_bd_pin -dir O -from 7 -to 0 -type data mt_pulse

  # Create instance: enable_mux_0, and set properties
  set block_name enable_mux
  set block_cell_name enable_mux_0
  if { [catch {set enable_mux_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $enable_mux_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
CONFIG.n {8} \
 ] $enable_mux_0

  # Create instance: enable_mux_1, and set properties
  set block_name enable_mux
  set block_cell_name enable_mux_1
  if { [catch {set enable_mux_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $enable_mux_1 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: hcr_controller_0, and set properties
  set hcr_controller_0 [ create_bd_cell -type ip -vlnv NCAR:EOL:hcr_controller:1.0 hcr_controller_0 ]

  # Create instance: validate_kludge_0, and set properties
  set validate_kludge_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 validate_kludge_0 ]

  # Create instance: validate_kludge_1, and set properties
  set validate_kludge_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 validate_kludge_1 ]

  # Create instance: validate_kludge_2, and set properties
  set validate_kludge_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 validate_kludge_2 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axi_cfg_bus] [get_bd_intf_pins hcr_controller_0/s_axi_cfg_bus]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS [get_bd_intf_pins coef_ch0] [get_bd_intf_pins validate_kludge_0/M_AXIS]
  connect_bd_intf_net -intf_net hcr_controller_0_coef_ch0_V_V [get_bd_intf_pins hcr_controller_0/coef_ch0_V_V] [get_bd_intf_pins validate_kludge_0/S_AXIS]
  connect_bd_intf_net -intf_net hcr_controller_0_coef_ch1_V_V [get_bd_intf_pins hcr_controller_0/coef_ch1_V_V] [get_bd_intf_pins validate_kludge_1/S_AXIS]
  connect_bd_intf_net -intf_net hcr_controller_0_coef_ch2_V_V [get_bd_intf_pins hcr_controller_0/coef_ch2_V_V] [get_bd_intf_pins validate_kludge_2/S_AXIS]
  connect_bd_intf_net -intf_net hcr_controller_0_pulse_metadata_ch0_V [get_bd_intf_pins pulse_metadata_ch0] [get_bd_intf_pins hcr_controller_0/pulse_metadata_ch0_V]
  connect_bd_intf_net -intf_net hcr_controller_0_pulse_metadata_ch2_V [get_bd_intf_pins pulse_metadata_ch2] [get_bd_intf_pins hcr_controller_0/pulse_metadata_ch2_V]
  connect_bd_intf_net -intf_net pulse_metadata_1 [get_bd_intf_pins pulse_metadata_ch1] [get_bd_intf_pins hcr_controller_0/pulse_metadata_ch1_V]
  connect_bd_intf_net -intf_net validate_kludge_1_M_AXIS [get_bd_intf_pins coef_ch1] [get_bd_intf_pins validate_kludge_1/M_AXIS]
  connect_bd_intf_net -intf_net validate_kludge_2_M_AXIS [get_bd_intf_pins coef_ch2] [get_bd_intf_pins validate_kludge_2/M_AXIS]

  # Create port connections
  connect_bd_net -net enable_mux_0_O [get_bd_pins mt_pulse] [get_bd_pins enable_mux_0/O]
  connect_bd_net -net enable_mux_1_O [get_bd_pins control_flags] [get_bd_pins enable_mux_1/O]
  connect_bd_net -net hcr_controller_0_control_flags_V [get_bd_pins enable_mux_1/I] [get_bd_pins hcr_controller_0/control_flags_V]
  connect_bd_net -net hcr_controller_0_control_flags_V_ap_vld [get_bd_pins enable_mux_1/EN] [get_bd_pins hcr_controller_0/control_flags_V_ap_vld]
  connect_bd_net -net hcr_controller_0_filter_select_ch0_V [get_bd_pins filter_select_ch0] [get_bd_pins hcr_controller_0/filter_select_ch0_V]
  connect_bd_net -net hcr_controller_0_filter_select_ch1_V [get_bd_pins filter_select_ch1] [get_bd_pins hcr_controller_0/filter_select_ch1_V]
  connect_bd_net -net hcr_controller_0_filter_select_ch2_V [get_bd_pins filter_select_ch2] [get_bd_pins hcr_controller_0/filter_select_ch2_V]
  connect_bd_net -net hcr_controller_0_mt_pulse_V [get_bd_pins enable_mux_0/I] [get_bd_pins hcr_controller_0/mt_pulse_V]
  connect_bd_net -net hcr_controller_0_mt_pulse_V_ap_vld [get_bd_pins enable_mux_0/EN] [get_bd_pins hcr_controller_0/mt_pulse_V_ap_vld]
  connect_bd_net -net reset_reg_aresetn [get_bd_pins aresetn] [get_bd_pins hcr_controller_0/ap_rst_n] [get_bd_pins validate_kludge_0/aresetn] [get_bd_pins validate_kludge_1/aresetn] [get_bd_pins validate_kludge_2/aresetn]
  connect_bd_net -net s_axis_adc_pdti_aclk_1 [get_bd_pins adc_aclk] [get_bd_pins hcr_controller_0/ap_clk] [get_bd_pins validate_kludge_0/aclk] [get_bd_pins validate_kludge_1/aclk] [get_bd_pins validate_kludge_2/aclk]
  connect_bd_net -net sync_pulse_1 [get_bd_pins controller_PPS] [get_bd_pins hcr_controller_0/pps_q0]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set m_axis_adc_ch0_pdti [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_adc_ch0_pdti ]
  set_property -dict [ list \
CONFIG.CLK_DOMAIN {user_block2_s_axis_adc_pdti_aclk} \
CONFIG.FREQ_HZ {200000000} \
 ] $m_axis_adc_ch0_pdti
  set m_axis_adc_ch1_pdti [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_adc_ch1_pdti ]
  set_property -dict [ list \
CONFIG.CLK_DOMAIN {user_block2_s_axis_adc_pdti_aclk} \
CONFIG.FREQ_HZ {200000000} \
 ] $m_axis_adc_ch1_pdti
  set m_axis_adc_ch2_pdti [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_adc_ch2_pdti ]
  set_property -dict [ list \
CONFIG.CLK_DOMAIN {user_block2_s_axis_adc_pdti_aclk} \
CONFIG.FREQ_HZ {200000000} \
 ] $m_axis_adc_ch2_pdti
  set m_axis_dac_pdti [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_dac_pdti ]
  set_property -dict [ list \
CONFIG.CLK_DOMAIN {user_block2_s_axis_dac_pdti_aclk} \
CONFIG.FREQ_HZ {250000000} \
 ] $m_axis_dac_pdti
  set s_axi_csr [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_csr ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {26} \
CONFIG.ARUSER_WIDTH {0} \
CONFIG.AWUSER_WIDTH {0} \
CONFIG.BUSER_WIDTH {0} \
CONFIG.DATA_WIDTH {32} \
CONFIG.HAS_BRESP {1} \
CONFIG.HAS_BURST {0} \
CONFIG.HAS_CACHE {0} \
CONFIG.HAS_LOCK {0} \
CONFIG.HAS_PROT {1} \
CONFIG.HAS_QOS {0} \
CONFIG.HAS_REGION {0} \
CONFIG.HAS_RRESP {1} \
CONFIG.HAS_WSTRB {1} \
CONFIG.ID_WIDTH {0} \
CONFIG.MAX_BURST_LENGTH {1} \
CONFIG.NUM_READ_OUTSTANDING {1} \
CONFIG.NUM_READ_THREADS {1} \
CONFIG.NUM_WRITE_OUTSTANDING {1} \
CONFIG.NUM_WRITE_THREADS {1} \
CONFIG.PROTOCOL {AXI4LITE} \
CONFIG.READ_WRITE_MODE {READ_WRITE} \
CONFIG.RUSER_BITS_PER_BYTE {0} \
CONFIG.RUSER_WIDTH {0} \
CONFIG.SUPPORTS_NARROW_BURST {0} \
CONFIG.WUSER_BITS_PER_BYTE {0} \
CONFIG.WUSER_WIDTH {0} \
 ] $s_axi_csr
  set s_axis_adc_ch0_pdti [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_adc_ch0_pdti ]
  set_property -dict [ list \
CONFIG.HAS_TKEEP {0} \
CONFIG.HAS_TLAST {0} \
CONFIG.HAS_TREADY {0} \
CONFIG.HAS_TSTRB {0} \
CONFIG.LAYERED_METADATA {undef} \
CONFIG.TDATA_NUM_BYTES {4} \
CONFIG.TDEST_WIDTH {0} \
CONFIG.TID_WIDTH {0} \
CONFIG.TUSER_WIDTH {128} \
 ] $s_axis_adc_ch0_pdti
  set s_axis_adc_ch1_pdti [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_adc_ch1_pdti ]
  set_property -dict [ list \
CONFIG.HAS_TKEEP {0} \
CONFIG.HAS_TLAST {0} \
CONFIG.HAS_TREADY {0} \
CONFIG.HAS_TSTRB {0} \
CONFIG.LAYERED_METADATA {undef} \
CONFIG.TDATA_NUM_BYTES {4} \
CONFIG.TDEST_WIDTH {0} \
CONFIG.TID_WIDTH {0} \
CONFIG.TUSER_WIDTH {128} \
 ] $s_axis_adc_ch1_pdti
  set s_axis_adc_ch2_pdti [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_adc_ch2_pdti ]
  set_property -dict [ list \
CONFIG.HAS_TKEEP {0} \
CONFIG.HAS_TLAST {0} \
CONFIG.HAS_TREADY {0} \
CONFIG.HAS_TSTRB {0} \
CONFIG.LAYERED_METADATA {undef} \
CONFIG.TDATA_NUM_BYTES {4} \
CONFIG.TDEST_WIDTH {0} \
CONFIG.TID_WIDTH {0} \
CONFIG.TUSER_WIDTH {128} \
 ] $s_axis_adc_ch2_pdti
  set s_axis_dac_pdti [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_dac_pdti ]
  set_property -dict [ list \
CONFIG.HAS_TKEEP {0} \
CONFIG.HAS_TLAST {0} \
CONFIG.HAS_TREADY {0} \
CONFIG.HAS_TSTRB {0} \
CONFIG.LAYERED_METADATA {undef} \
CONFIG.TDATA_NUM_BYTES {4} \
CONFIG.TDEST_WIDTH {0} \
CONFIG.TID_WIDTH {0} \
CONFIG.TUSER_WIDTH {128} \
 ] $s_axis_dac_pdti

  # Create ports
  set AZ_MOSI [ create_bd_port -dir I AZ_MOSI ]
  set AZ_SCK [ create_bd_port -dir I AZ_SCK ]
  set AZ_SSEL [ create_bd_port -dir I AZ_SSEL ]
  set EL_MOSI [ create_bd_port -dir I EL_MOSI ]
  set EL_SCK [ create_bd_port -dir I EL_SCK ]
  set EL_SSEL [ create_bd_port -dir I EL_SSEL ]
  set ROT_A [ create_bd_port -dir I ROT_A ]
  set ROT_B [ create_bd_port -dir I ROT_B ]
  set TILT_A [ create_bd_port -dir I TILT_A ]
  set TILT_B [ create_bd_port -dir I TILT_B ]
  set control_flags [ create_bd_port -dir O -from 31 -to 0 -type data control_flags ]
  set controller_PPS [ create_bd_port -dir I controller_PPS ]
  set filter_select_ch0 [ create_bd_port -dir O -from 1 -to 0 -type data filter_select_ch0 ]
  set filter_select_ch1 [ create_bd_port -dir O -from 1 -to 0 -type data filter_select_ch1 ]
  set filter_select_ch2 [ create_bd_port -dir O -from 1 -to 0 -type data filter_select_ch2 ]
  set mt_pulse [ create_bd_port -dir O -from 7 -to 0 -type data mt_pulse ]
  set s_axi_csr_aclk [ create_bd_port -dir I -type clk s_axi_csr_aclk ]
  set_property -dict [ list \
CONFIG.ASSOCIATED_BUSIF {s_axi_csr} \
CONFIG.ASSOCIATED_RESET {s_axi_csr_aresetn} \
CONFIG.FREQ_HZ {250000000} \
 ] $s_axi_csr_aclk
  set s_axi_csr_aresetn [ create_bd_port -dir I -type rst s_axi_csr_aresetn ]
  set s_axis_adc_pdti_aclk [ create_bd_port -dir I -type clk s_axis_adc_pdti_aclk ]
  set_property -dict [ list \
CONFIG.ASSOCIATED_BUSIF {s_axis_adc_ch1_pdti:s_axis_adc_ch2_pdti:m_axis_adc_ch0_pdti:m_axis_adc_ch1_pdti:m_axis_adc_ch2_pdti:s_axis_adc_ch0_pdti} \
CONFIG.ASSOCIATED_RESET {s_axis_adc_pdti_aresetn} \
CONFIG.CLK_DOMAIN {user_block2_s_axis_adc_pdti_aclk} \
CONFIG.FREQ_HZ {200000000} \
 ] $s_axis_adc_pdti_aclk
  set s_axis_adc_pdti_aresetn [ create_bd_port -dir I -type rst s_axis_adc_pdti_aresetn ]
  set s_axis_dac_pdti_aclk [ create_bd_port -dir I -type clk s_axis_dac_pdti_aclk ]
  set_property -dict [ list \
CONFIG.ASSOCIATED_BUSIF {s_axis_dac_pdti:m_axis_dac_pdti} \
CONFIG.ASSOCIATED_RESET {s_axis_dac_pdti_aresetn} \
CONFIG.CLK_DOMAIN {user_block2_s_axis_dac_pdti_aclk} \
CONFIG.FREQ_HZ {250000000} \
 ] $s_axis_dac_pdti_aclk
  set s_axis_dac_pdti_aresetn [ create_bd_port -dir I -type rst s_axis_dac_pdti_aresetn ]
  set status_flags [ create_bd_port -dir I -from 15 -to 0 -type data status_flags ]
  set_property -dict [ list \
CONFIG.LAYERED_METADATA {xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 32} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} integer {signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}}}} \
 ] $status_flags
  set user2_irq [ create_bd_port -dir O -from 1 -to 0 user2_irq ]

  # Create instance: axis_register_slice_0, and set properties
  set axis_register_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_0 ]

  # Create instance: controller
  create_hier_cell_controller [current_bd_instance .] controller

  # Create instance: csr
  create_hier_cell_csr [current_bd_instance .] csr

  # Create instance: dsp_ch0
  create_hier_cell_dsp_ch0 [current_bd_instance .] dsp_ch0

  # Create instance: dsp_ch1
  create_hier_cell_dsp_ch1 [current_bd_instance .] dsp_ch1

  # Create instance: dsp_ch2
  create_hier_cell_dsp_ch2 [current_bd_instance .] dsp_ch2

  # Create instance: irq_placeholder, and set properties
  set irq_placeholder [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 irq_placeholder ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
CONFIG.CONST_WIDTH {2} \
 ] $irq_placeholder

  # Create instance: position_encoder_0, and set properties
  set block_name position_encoder
  set block_cell_name position_encoder_0
  if { [catch {set position_encoder_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $position_encoder_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create interface connections
  connect_bd_intf_net -intf_net axi_interc_M01_AXI [get_bd_intf_pins controller/s_axi_cfg_bus] [get_bd_intf_pins csr/adc_csr]
  connect_bd_intf_net -intf_net axis_register_slice_0_M_AXIS [get_bd_intf_ports m_axis_dac_pdti] [get_bd_intf_pins axis_register_slice_0/M_AXIS]
  connect_bd_intf_net -intf_net coef_1 [get_bd_intf_pins controller/coef_ch1] [get_bd_intf_pins dsp_ch1/coef]
  connect_bd_intf_net -intf_net dsp_ch1_out_pdti [get_bd_intf_ports m_axis_adc_ch1_pdti] [get_bd_intf_pins dsp_ch1/out_pdti]
  connect_bd_intf_net -intf_net dsp_ch2_out_pdti [get_bd_intf_ports m_axis_adc_ch2_pdti] [get_bd_intf_pins dsp_ch2/out_pdti]
  connect_bd_intf_net -intf_net hcr_controller_0_coef_ch0_V_V [get_bd_intf_pins controller/coef_ch0] [get_bd_intf_pins dsp_ch0/coef]
  connect_bd_intf_net -intf_net hcr_controller_0_coef_ch2_V_V [get_bd_intf_pins controller/coef_ch2] [get_bd_intf_pins dsp_ch2/coef]
  connect_bd_intf_net -intf_net hcr_controller_0_pulse_metadata_ch0_V [get_bd_intf_pins controller/pulse_metadata_ch0] [get_bd_intf_pins dsp_ch0/pulse_metadata]
  connect_bd_intf_net -intf_net hcr_controller_0_pulse_metadata_ch2_V [get_bd_intf_pins controller/pulse_metadata_ch2] [get_bd_intf_pins dsp_ch2/pulse_metadata]
  connect_bd_intf_net -intf_net hcr_metadata_injector_0_o_data [get_bd_intf_ports m_axis_adc_ch0_pdti] [get_bd_intf_pins dsp_ch0/out_pdti]
  connect_bd_intf_net -intf_net pulse_metadata_1 [get_bd_intf_pins controller/pulse_metadata_ch1] [get_bd_intf_pins dsp_ch1/pulse_metadata]
  connect_bd_intf_net -intf_net s_axi_csr_1 [get_bd_intf_ports s_axi_csr] [get_bd_intf_pins csr/s_axi_csr]
  connect_bd_intf_net -intf_net s_axis_adc_ch0_pdti_1 [get_bd_intf_ports s_axis_adc_ch0_pdti] [get_bd_intf_pins dsp_ch0/in_pdti]
  connect_bd_intf_net -intf_net s_axis_adc_ch1_pdti_1 [get_bd_intf_ports s_axis_adc_ch1_pdti] [get_bd_intf_pins dsp_ch1/in_pdti]
  connect_bd_intf_net -intf_net s_axis_adc_ch2_pdti_1 [get_bd_intf_ports s_axis_adc_ch2_pdti] [get_bd_intf_pins dsp_ch2/in_pdti]
  connect_bd_intf_net -intf_net s_axis_dac_pdti_1 [get_bd_intf_ports s_axis_dac_pdti] [get_bd_intf_pins axis_register_slice_0/S_AXIS]

  # Create port connections
  connect_bd_net -net AZ_MOSI_1 [get_bd_ports AZ_MOSI] [get_bd_pins position_encoder_0/AZ_MOSI]
  connect_bd_net -net AZ_SCK_1 [get_bd_ports AZ_SCK] [get_bd_pins position_encoder_0/AZ_SCK]
  connect_bd_net -net AZ_SSEL_1 [get_bd_ports AZ_SSEL] [get_bd_pins position_encoder_0/AZ_SSEL]
  connect_bd_net -net EL_MOSI_1 [get_bd_ports EL_MOSI] [get_bd_pins position_encoder_0/EL_MOSI]
  connect_bd_net -net EL_SCK_1 [get_bd_ports EL_SCK] [get_bd_pins position_encoder_0/EL_SCK]
  connect_bd_net -net EL_SSEL_1 [get_bd_ports EL_SSEL] [get_bd_pins position_encoder_0/EL_SSEL]
  connect_bd_net -net ROT_A_1 [get_bd_ports ROT_A] [get_bd_pins position_encoder_0/ROT_A]
  connect_bd_net -net ROT_B_1 [get_bd_ports ROT_B] [get_bd_pins position_encoder_0/ROT_B]
  connect_bd_net -net TILT_A_1 [get_bd_ports TILT_A] [get_bd_pins position_encoder_0/TILT_A]
  connect_bd_net -net TILT_B_1 [get_bd_ports TILT_B] [get_bd_pins position_encoder_0/TILT_B]
  connect_bd_net -net adc_aresetn [get_bd_pins controller/aresetn] [get_bd_pins csr/adc_aresetn] [get_bd_pins dsp_ch0/aresetn] [get_bd_pins dsp_ch1/aresetn] [get_bd_pins dsp_ch2/aresetn] [get_bd_pins position_encoder_0/aresetn]
  connect_bd_net -net controller_PPS_1 [get_bd_pins controller/controller_PPS] [get_bd_pins csr/controller_PPS]
  connect_bd_net -net controller_PPS_2 [get_bd_ports controller_PPS] [get_bd_pins csr/i_controller_PPS]
  connect_bd_net -net csr_ctl2_out [get_bd_pins csr/ctl2_out] [get_bd_pins position_encoder_0/ctl_reg]
  connect_bd_net -net hcr_controller_0_control_flags [get_bd_ports control_flags] [get_bd_pins controller/control_flags]
  connect_bd_net -net hcr_controller_0_filter_select_ch0 [get_bd_ports filter_select_ch0] [get_bd_pins controller/filter_select_ch0]
  connect_bd_net -net hcr_controller_0_filter_select_ch1 [get_bd_ports filter_select_ch1] [get_bd_pins controller/filter_select_ch1]
  connect_bd_net -net hcr_controller_0_filter_select_ch2 [get_bd_ports filter_select_ch2] [get_bd_pins controller/filter_select_ch2]
  connect_bd_net -net hcr_controller_0_mt_pulse [get_bd_ports mt_pulse] [get_bd_pins controller/mt_pulse]
  connect_bd_net -net pos_enc_0_1 [get_bd_pins dsp_ch0/pos_enc_0] [get_bd_pins dsp_ch1/pos_enc_0] [get_bd_pins dsp_ch2/pos_enc_0] [get_bd_pins position_encoder_0/pos_enc_0]
  connect_bd_net -net pos_enc_1_1 [get_bd_pins dsp_ch0/pos_enc_1] [get_bd_pins dsp_ch1/pos_enc_1] [get_bd_pins dsp_ch2/pos_enc_1] [get_bd_pins position_encoder_0/pos_enc_1]
  connect_bd_net -net s_axi_csr_aclk_1 [get_bd_ports s_axi_csr_aclk] [get_bd_pins csr/s_axi_csr_aclk]
  connect_bd_net -net s_axi_csr_aresetn_1 [get_bd_ports s_axi_csr_aresetn] [get_bd_pins csr/s_axi_csr_aresetn]
  connect_bd_net -net s_axis_adc_pdti_aclk_1 [get_bd_ports s_axis_adc_pdti_aclk] [get_bd_pins controller/adc_aclk] [get_bd_pins csr/s_axis_adc_pdti_aclk] [get_bd_pins dsp_ch0/aclk] [get_bd_pins dsp_ch1/aclk] [get_bd_pins dsp_ch2/aclk] [get_bd_pins position_encoder_0/aclk]
  connect_bd_net -net s_axis_adc_pdti_aresetn_1 [get_bd_ports s_axis_adc_pdti_aresetn] [get_bd_pins csr/s_axis_adc_pdti_aresetn]
  connect_bd_net -net s_axis_dac_pdti_aclk_1 [get_bd_ports s_axis_dac_pdti_aclk] [get_bd_pins axis_register_slice_0/aclk]
  connect_bd_net -net s_axis_dac_pdti_aresetn_1 [get_bd_ports s_axis_dac_pdti_aresetn] [get_bd_pins axis_register_slice_0/aresetn]
  connect_bd_net -net status_flags [get_bd_ports status_flags] [get_bd_pins dsp_ch0/flags] [get_bd_pins dsp_ch1/flags] [get_bd_pins dsp_ch2/flags]
  connect_bd_net -net xlconstant_0_dout [get_bd_ports user2_irq] [get_bd_pins irq_placeholder/dout]

  # Create address segments
  create_bd_addr_seg -range 0x00040000 -offset 0x03900000 [get_bd_addr_spaces s_axi_csr] [get_bd_addr_segs controller/hcr_controller_0/s_axi_cfg_bus/Reg] SEG_hcr_controller_0_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0x03800000 [get_bd_addr_spaces s_axi_csr] [get_bd_addr_segs csr/general_purpose_reg_0/s_axi_csr/reg0] SEG_reset_reg_0_reg0


  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


