# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "num_ctl_regs" -parent ${Page_0}
  ipgui::add_param $IPINST -name "num_stat_regs" -parent ${Page_0}
  ipgui::add_static_text $IPINST -name "addr txt" -parent ${Page_0} -text {
If interrupt Registers are selected, that adds three registers
(Interrupt Enable Register, Interrupt Status Register, Interrupt Flag Register).
}
  ipgui::add_param $IPINST -name "has_interrupt_regs" -parent ${Page_0}
  ipgui::add_param $IPINST -name "num_interrupt_src" -parent ${Page_0}
  ipgui::add_static_text $IPINST -name "txt" -parent ${Page_0} -text {

Register Order is:

1) Control Registers (up to 8)

2) Status Registers (up to 8)

3) Interrupt Registers:

	Interrupt Enable Register

	Interrupt Status Register

	Interrupt Flag Register



If any register group is set to 0, then other groups move down in address space.

AXI-Lite Address width is a function of the number of registers configured.

The width is the (ceiling of the LOG2(number of total registers*4)).

For instance, 9 total registers will result in an address width of 6 [5:0]

The lower two bits are due to AXI-Lite addresses being byte addresses.}


}

proc update_PARAM_VALUE.has_interrupt_regs { PARAM_VALUE.has_interrupt_regs } {
	# Procedure called to update has_interrupt_regs when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_interrupt_regs { PARAM_VALUE.has_interrupt_regs } {
	# Procedure called to validate has_interrupt_regs
	return true
}

proc update_PARAM_VALUE.num_ctl_regs { PARAM_VALUE.num_ctl_regs } {
	# Procedure called to update num_ctl_regs when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.num_ctl_regs { PARAM_VALUE.num_ctl_regs } {
	# Procedure called to validate num_ctl_regs
	return true
}

proc update_PARAM_VALUE.num_interrupt_src { PARAM_VALUE.num_interrupt_src } {
	# Procedure called to update num_interrupt_src when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.num_interrupt_src { PARAM_VALUE.num_interrupt_src } {
	# Procedure called to validate num_interrupt_src
	return true
}

proc update_PARAM_VALUE.num_stat_regs { PARAM_VALUE.num_stat_regs } {
	# Procedure called to update num_stat_regs when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.num_stat_regs { PARAM_VALUE.num_stat_regs } {
	# Procedure called to validate num_stat_regs
	return true
}


proc update_MODELPARAM_VALUE.num_ctl_regs { MODELPARAM_VALUE.num_ctl_regs PARAM_VALUE.num_ctl_regs } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.num_ctl_regs}] ${MODELPARAM_VALUE.num_ctl_regs}
}

proc update_MODELPARAM_VALUE.num_stat_regs { MODELPARAM_VALUE.num_stat_regs PARAM_VALUE.num_stat_regs } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.num_stat_regs}] ${MODELPARAM_VALUE.num_stat_regs}
}

proc update_MODELPARAM_VALUE.has_interrupt_regs { MODELPARAM_VALUE.has_interrupt_regs PARAM_VALUE.has_interrupt_regs } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_interrupt_regs}] ${MODELPARAM_VALUE.has_interrupt_regs}
}

proc update_MODELPARAM_VALUE.num_interrupt_src { MODELPARAM_VALUE.num_interrupt_src PARAM_VALUE.num_interrupt_src } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.num_interrupt_src}] ${MODELPARAM_VALUE.num_interrupt_src}
}

