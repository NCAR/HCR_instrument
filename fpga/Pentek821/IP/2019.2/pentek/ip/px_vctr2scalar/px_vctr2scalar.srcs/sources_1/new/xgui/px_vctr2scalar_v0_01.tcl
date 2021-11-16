
# Loading additional proc with user specified bodies to compute parameter values.
source [file join [file dirname [file dirname [info script]]] gui/px_vctr2scalar_v0_01.gtcl]

# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_static_text $IPINST -name "summary_txt" -parent ${Page_0} -text {This module can be used to convert a one element vector to a scalar (std_logic) signal.

In addition, it can be used to re-synchronize the signal to a clock input.  If the signal is already

synchronous with clock, it can be used to create a delay.

}
  ipgui::add_param $IPINST -name "invert" -parent ${Page_0}
  #Adding Group
  set Synchronization [ipgui::add_group $IPINST -name "Synchronization" -parent ${Page_0}]
  set_property tooltip {Synchronization} ${Synchronization}
  ipgui::add_param $IPINST -name "synchronize" -parent ${Synchronization}
  ipgui::add_param $IPINST -name "num_sync_ff" -parent ${Synchronization}
  ipgui::add_param $IPINST -name "has_srst" -parent ${Synchronization}
  ipgui::add_param $IPINST -name "srst_active_high" -parent ${Synchronization}
  ipgui::add_param $IPINST -name "val_at_rst_low" -parent ${Synchronization}



}

proc update_PARAM_VALUE.has_srst { PARAM_VALUE.has_srst PARAM_VALUE.synchronize } {
	# Procedure called to update has_srst when any of the dependent parameters in the arguments change
	
	set has_srst ${PARAM_VALUE.has_srst}
	set synchronize ${PARAM_VALUE.synchronize}
	set values(synchronize) [get_property value $synchronize]
	if { [gen_USERPARAMETER_has_srst_ENABLEMENT $values(synchronize)] } {
		set_property enabled true $has_srst
	} else {
		set_property enabled false $has_srst
	}
}

proc validate_PARAM_VALUE.has_srst { PARAM_VALUE.has_srst } {
	# Procedure called to validate has_srst
	return true
}

proc update_PARAM_VALUE.num_sync_ff { PARAM_VALUE.num_sync_ff PARAM_VALUE.synchronize } {
	# Procedure called to update num_sync_ff when any of the dependent parameters in the arguments change
	
	set num_sync_ff ${PARAM_VALUE.num_sync_ff}
	set synchronize ${PARAM_VALUE.synchronize}
	set values(synchronize) [get_property value $synchronize]
	if { [gen_USERPARAMETER_num_sync_ff_ENABLEMENT $values(synchronize)] } {
		set_property enabled true $num_sync_ff
	} else {
		set_property enabled false $num_sync_ff
	}
}

proc validate_PARAM_VALUE.num_sync_ff { PARAM_VALUE.num_sync_ff } {
	# Procedure called to validate num_sync_ff
	return true
}

proc update_PARAM_VALUE.srst_active_high { PARAM_VALUE.srst_active_high PARAM_VALUE.has_srst PARAM_VALUE.synchronize } {
	# Procedure called to update srst_active_high when any of the dependent parameters in the arguments change
	
	set srst_active_high ${PARAM_VALUE.srst_active_high}
	set has_srst ${PARAM_VALUE.has_srst}
	set synchronize ${PARAM_VALUE.synchronize}
	set values(has_srst) [get_property value $has_srst]
	set values(synchronize) [get_property value $synchronize]
	if { [gen_USERPARAMETER_srst_active_high_ENABLEMENT $values(has_srst) $values(synchronize)] } {
		set_property enabled true $srst_active_high
	} else {
		set_property enabled false $srst_active_high
	}
}

proc validate_PARAM_VALUE.srst_active_high { PARAM_VALUE.srst_active_high } {
	# Procedure called to validate srst_active_high
	return true
}

proc update_PARAM_VALUE.val_at_rst_low { PARAM_VALUE.val_at_rst_low PARAM_VALUE.has_srst PARAM_VALUE.synchronize } {
	# Procedure called to update val_at_rst_low when any of the dependent parameters in the arguments change
	
	set val_at_rst_low ${PARAM_VALUE.val_at_rst_low}
	set has_srst ${PARAM_VALUE.has_srst}
	set synchronize ${PARAM_VALUE.synchronize}
	set values(has_srst) [get_property value $has_srst]
	set values(synchronize) [get_property value $synchronize]
	if { [gen_USERPARAMETER_val_at_rst_low_ENABLEMENT $values(has_srst) $values(synchronize)] } {
		set_property enabled true $val_at_rst_low
	} else {
		set_property enabled false $val_at_rst_low
	}
}

proc validate_PARAM_VALUE.val_at_rst_low { PARAM_VALUE.val_at_rst_low } {
	# Procedure called to validate val_at_rst_low
	return true
}

proc update_PARAM_VALUE.invert { PARAM_VALUE.invert } {
	# Procedure called to update invert when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.invert { PARAM_VALUE.invert } {
	# Procedure called to validate invert
	return true
}

proc update_PARAM_VALUE.synchronize { PARAM_VALUE.synchronize } {
	# Procedure called to update synchronize when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.synchronize { PARAM_VALUE.synchronize } {
	# Procedure called to validate synchronize
	return true
}


proc update_MODELPARAM_VALUE.synchronize { MODELPARAM_VALUE.synchronize PARAM_VALUE.synchronize } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.synchronize}] ${MODELPARAM_VALUE.synchronize}
}

proc update_MODELPARAM_VALUE.num_sync_ff { MODELPARAM_VALUE.num_sync_ff PARAM_VALUE.num_sync_ff } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.num_sync_ff}] ${MODELPARAM_VALUE.num_sync_ff}
}

proc update_MODELPARAM_VALUE.has_srst { MODELPARAM_VALUE.has_srst PARAM_VALUE.has_srst } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_srst}] ${MODELPARAM_VALUE.has_srst}
}

proc update_MODELPARAM_VALUE.val_at_rst_low { MODELPARAM_VALUE.val_at_rst_low PARAM_VALUE.val_at_rst_low } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.val_at_rst_low}] ${MODELPARAM_VALUE.val_at_rst_low}
}

proc update_MODELPARAM_VALUE.srst_active_high { MODELPARAM_VALUE.srst_active_high PARAM_VALUE.srst_active_high } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.srst_active_high}] ${MODELPARAM_VALUE.srst_active_high}
}

proc update_MODELPARAM_VALUE.invert { MODELPARAM_VALUE.invert PARAM_VALUE.invert } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.invert}] ${MODELPARAM_VALUE.invert}
}

