
# Loading additional proc with user specified bodies to compute parameter values.
source [file join [file dirname [file dirname [info script]]] gui/p_axil_csr32_v0_01.gtcl]

# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  #Adding Group
  set Register_Type_Selection [ipgui::add_group $IPINST -name "Register Type Selection" -parent ${Page_0}]
  set_property tooltip {Register Type Selection} ${Register_Type_Selection}
  ipgui::add_static_text $IPINST -name "reg_txt" -parent ${Register_Type_Selection} -text {Each bit location defines the register type for the corresponding register 0-28.

(29-31 are interrupt registers so bits 31:28 have no effect.)

0 = Status Register, 1 = Control Register

}
  ipgui::add_param $IPINST -name "reg_type" -parent ${Register_Type_Selection}

  #Adding Group
  set Register_Disable [ipgui::add_group $IPINST -name "Register Disable" -parent ${Page_0}]
  set_property tooltip {Set bity to '1' to disable the corresponding register.} ${Register_Disable}
  ipgui::add_static_text $IPINST -name "dis_txt" -parent ${Register_Disable} -text {Setting a bit location to '1' will disable the corresponding register (0-28).

(29-31 are interrupt registers so bits 31:28 have no effect.)

}
  ipgui::add_param $IPINST -name "disable_reg" -parent ${Register_Disable}

  #Adding Group
  set Interrupt_Registers [ipgui::add_group $IPINST -name "Interrupt Registers" -parent ${Page_0}]
  set_property tooltip {Interrupt Registers} ${Interrupt_Registers}
  ipgui::add_param $IPINST -name "has_interrupt_regs" -parent ${Interrupt_Registers}
  ipgui::add_param $IPINST -name "num_interrupt_src" -parent ${Interrupt_Registers}



}

proc update_PARAM_VALUE.num_interrupt_src { PARAM_VALUE.num_interrupt_src PARAM_VALUE.has_interrupt_regs } {
	# Procedure called to update num_interrupt_src when any of the dependent parameters in the arguments change
	
	set num_interrupt_src ${PARAM_VALUE.num_interrupt_src}
	set has_interrupt_regs ${PARAM_VALUE.has_interrupt_regs}
	set values(has_interrupt_regs) [get_property value $has_interrupt_regs]
	if { [gen_USERPARAMETER_num_interrupt_src_ENABLEMENT $values(has_interrupt_regs)] } {
		set_property enabled true $num_interrupt_src
	} else {
		set_property enabled false $num_interrupt_src
	}
}

proc validate_PARAM_VALUE.num_interrupt_src { PARAM_VALUE.num_interrupt_src } {
	# Procedure called to validate num_interrupt_src
	return true
}

proc update_PARAM_VALUE.disable_reg { PARAM_VALUE.disable_reg } {
	# Procedure called to update disable_reg when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.disable_reg { PARAM_VALUE.disable_reg } {
	# Procedure called to validate disable_reg
	return true
}

proc update_PARAM_VALUE.has_interrupt_regs { PARAM_VALUE.has_interrupt_regs } {
	# Procedure called to update has_interrupt_regs when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_interrupt_regs { PARAM_VALUE.has_interrupt_regs } {
	# Procedure called to validate has_interrupt_regs
	return true
}

proc update_PARAM_VALUE.reg_type { PARAM_VALUE.reg_type } {
	# Procedure called to update reg_type when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.reg_type { PARAM_VALUE.reg_type } {
	# Procedure called to validate reg_type
	return true
}


proc update_MODELPARAM_VALUE.reg_type { MODELPARAM_VALUE.reg_type PARAM_VALUE.reg_type } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.reg_type}] ${MODELPARAM_VALUE.reg_type}
}

proc update_MODELPARAM_VALUE.disable_reg { MODELPARAM_VALUE.disable_reg PARAM_VALUE.disable_reg } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.disable_reg}] ${MODELPARAM_VALUE.disable_reg}
}

proc update_MODELPARAM_VALUE.has_interrupt_regs { MODELPARAM_VALUE.has_interrupt_regs PARAM_VALUE.has_interrupt_regs } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_interrupt_regs}] ${MODELPARAM_VALUE.has_interrupt_regs}
}

proc update_MODELPARAM_VALUE.num_interrupt_src { MODELPARAM_VALUE.num_interrupt_src PARAM_VALUE.num_interrupt_src } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.num_interrupt_src}] ${MODELPARAM_VALUE.num_interrupt_src}
}

