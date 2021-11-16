# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  set pcie_channel [ipgui::add_param $IPINST -name "pcie_channel" -parent ${Page_0}]
  set_property tooltip {PCIe Channe Numberl} ${pcie_channel}


}

proc update_PARAM_VALUE.pcie_channel { PARAM_VALUE.pcie_channel } {
	# Procedure called to update pcie_channel when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.pcie_channel { PARAM_VALUE.pcie_channel } {
	# Procedure called to validate pcie_channel
	return true
}


proc update_MODELPARAM_VALUE.pcie_channel { MODELPARAM_VALUE.pcie_channel PARAM_VALUE.pcie_channel } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.pcie_channel}] ${MODELPARAM_VALUE.pcie_channel}
}

