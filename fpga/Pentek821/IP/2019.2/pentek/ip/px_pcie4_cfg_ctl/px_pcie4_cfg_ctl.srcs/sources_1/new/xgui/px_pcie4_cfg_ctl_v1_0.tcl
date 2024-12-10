# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "pci_ep_dsn" -parent ${Page_0}


}

proc update_PARAM_VALUE.pci_ep_dsn { PARAM_VALUE.pci_ep_dsn } {
	# Procedure called to update pci_ep_dsn when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.pci_ep_dsn { PARAM_VALUE.pci_ep_dsn } {
	# Procedure called to validate pci_ep_dsn
	return true
}


proc update_MODELPARAM_VALUE.pci_ep_dsn { MODELPARAM_VALUE.pci_ep_dsn PARAM_VALUE.pci_ep_dsn } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.pci_ep_dsn}] ${MODELPARAM_VALUE.pci_ep_dsn}
}

