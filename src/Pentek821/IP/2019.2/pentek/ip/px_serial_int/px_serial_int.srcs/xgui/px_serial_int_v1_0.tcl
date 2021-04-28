# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  set data_reg_width [ipgui::add_param $IPINST -name "data_reg_width" -parent ${Page_0}]
  set_property tooltip {SPI Register Data Width} ${data_reg_width}
  set addr_reg_width [ipgui::add_param $IPINST -name "addr_reg_width" -parent ${Page_0}]
  set_property tooltip {SPI Register Address Width} ${addr_reg_width}
  ipgui::add_static_text $IPINST -name "BusType" -parent ${Page_0} -text {

BusType

0 = 3-Wire SPI configuation

1 = 4-Wire SPI configuation}
  set bustype_3wire_4wire [ipgui::add_param $IPINST -name "bustype_3wire_4wire" -parent ${Page_0}]
  set_property tooltip {Bus Type, 3-wire or 4-wire} ${bustype_3wire_4wire}
  ipgui::add_static_text $IPINST -name "Read Write Polarity" -parent ${Page_0} -text {



The read/write polarity on SDI bus line

0 - Read is '1', Write is '0'

1 - Read is '0', Write is '1'}
  set RD_WR_POL [ipgui::add_param $IPINST -name "RD_WR_POL" -parent ${Page_0}]
  set_property tooltip {SPI Read/Write-Bit Polarity} ${RD_WR_POL}


}

proc update_PARAM_VALUE.RD_WR_POL { PARAM_VALUE.RD_WR_POL } {
	# Procedure called to update RD_WR_POL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.RD_WR_POL { PARAM_VALUE.RD_WR_POL } {
	# Procedure called to validate RD_WR_POL
	return true
}

proc update_PARAM_VALUE.addr_reg_width { PARAM_VALUE.addr_reg_width } {
	# Procedure called to update addr_reg_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.addr_reg_width { PARAM_VALUE.addr_reg_width } {
	# Procedure called to validate addr_reg_width
	return true
}

proc update_PARAM_VALUE.bustype_3wire_4wire { PARAM_VALUE.bustype_3wire_4wire } {
	# Procedure called to update bustype_3wire_4wire when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.bustype_3wire_4wire { PARAM_VALUE.bustype_3wire_4wire } {
	# Procedure called to validate bustype_3wire_4wire
	return true
}

proc update_PARAM_VALUE.data_reg_width { PARAM_VALUE.data_reg_width } {
	# Procedure called to update data_reg_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.data_reg_width { PARAM_VALUE.data_reg_width } {
	# Procedure called to validate data_reg_width
	return true
}


proc update_MODELPARAM_VALUE.data_reg_width { MODELPARAM_VALUE.data_reg_width PARAM_VALUE.data_reg_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.data_reg_width}] ${MODELPARAM_VALUE.data_reg_width}
}

proc update_MODELPARAM_VALUE.addr_reg_width { MODELPARAM_VALUE.addr_reg_width PARAM_VALUE.addr_reg_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.addr_reg_width}] ${MODELPARAM_VALUE.addr_reg_width}
}

proc update_MODELPARAM_VALUE.bustype_3wire_4wire { MODELPARAM_VALUE.bustype_3wire_4wire PARAM_VALUE.bustype_3wire_4wire } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.bustype_3wire_4wire}] ${MODELPARAM_VALUE.bustype_3wire_4wire}
}

proc update_MODELPARAM_VALUE.RD_WR_POL { MODELPARAM_VALUE.RD_WR_POL PARAM_VALUE.RD_WR_POL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.RD_WR_POL}] ${MODELPARAM_VALUE.RD_WR_POL}
}

