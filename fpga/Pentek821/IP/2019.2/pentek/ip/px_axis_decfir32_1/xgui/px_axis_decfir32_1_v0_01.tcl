# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_static_text $IPINST -name "text_description" -parent ${Page_0} -text {Decimating FIR Filter

Decimation Range 2 to 32

AXI-Sream (PDTI) compatible Input and Output.

AXI-Lite Control/Status Register and Coefficient loading.

32xDecimation number of Taps.

 }
  set num_chan [ipgui::add_param $IPINST -name "num_chan" -parent ${Page_0} -widget comboBox]
  set_property tooltip {Number of Channels (1=Real, 2= IQ Complex)} ${num_chan}
  ipgui::add_static_text $IPINST -name "text1" -parent ${Page_0} -text {Choose 1 for 16-bit Real Data Stream.  Choose 2 for IQ Complex Data Stream.}


}

proc update_PARAM_VALUE.num_chan { PARAM_VALUE.num_chan } {
	# Procedure called to update num_chan when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.num_chan { PARAM_VALUE.num_chan } {
	# Procedure called to validate num_chan
	return true
}


proc update_MODELPARAM_VALUE.num_chan { MODELPARAM_VALUE.num_chan PARAM_VALUE.num_chan } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.num_chan}] ${MODELPARAM_VALUE.num_chan}
}
