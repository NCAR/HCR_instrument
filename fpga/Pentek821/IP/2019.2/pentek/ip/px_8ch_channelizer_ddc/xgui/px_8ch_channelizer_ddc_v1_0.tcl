# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "first_chan" -parent ${Page_0}
  ipgui::add_static_text $IPINST -name "txt1" -parent ${Page_0} -text {Number of the first channel of the eight output channels.  
The channel numbers, starting with the specified first 
channel numbers appear in the tuser of the output 
AXI-Stream.  First Channel Number must be 0 or a
 multiple of 8 between 0 and 248.}


}

proc update_PARAM_VALUE.first_chan { PARAM_VALUE.first_chan } {
	# Procedure called to update first_chan when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.first_chan { PARAM_VALUE.first_chan } {
	# Procedure called to validate first_chan
	return true
}


proc update_MODELPARAM_VALUE.first_chan { MODELPARAM_VALUE.first_chan PARAM_VALUE.first_chan } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.first_chan}] ${MODELPARAM_VALUE.first_chan}
}

