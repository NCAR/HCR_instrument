
# Loading additional proc with user specified bodies to compute parameter values.
source [file join [file dirname [file dirname [info script]]] gui/px_brd_info_regs_v0_01.gtcl]

# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  #Adding Group
  set Information [ipgui::add_group $IPINST -name "Information" -parent ${Page_0}]
  set_property tooltip {Information} ${Information}
  ipgui::add_param $IPINST -name "board_id" -parent ${Information}
  ipgui::add_param $IPINST -name "fpga_code_id" -parent ${Information}
  ipgui::add_param $IPINST -name "has_fpga_size_in" -parent ${Information}
  ipgui::add_param $IPINST -name "fpga_size" -parent ${Information} -widget comboBox
  ipgui::add_param $IPINST -name "has_fpio_in" -parent ${Information}
  ipgui::add_param $IPINST -name "user_word" -parent ${Information}

  #Adding Group
  set Code_Revision_Date [ipgui::add_group $IPINST -name "Code Revision Date" -parent ${Page_0}]
  ipgui::add_param $IPINST -name "has_rev_info_in" -parent ${Code_Revision_Date}
  ipgui::add_static_text $IPINST -name "txt" -parent ${Code_Revision_Date} -text {When Checked, the value below are not used.

Instead, Rev input signal values are used.}
  ipgui::add_param $IPINST -name "fpga_code_rev" -parent ${Code_Revision_Date}
  ipgui::add_param $IPINST -name "date_month" -parent ${Code_Revision_Date}
  ipgui::add_param $IPINST -name "date_day" -parent ${Code_Revision_Date}
  ipgui::add_param $IPINST -name "date_year" -parent ${Code_Revision_Date}

  #Adding Group
  set PCIe_Link_Info [ipgui::add_group $IPINST -name "PCIe Link Info" -parent ${Page_0}]
  set_property tooltip {PCIe Link Info} ${PCIe_Link_Info}
  ipgui::add_param $IPINST -name "has_link_stat_in" -parent ${PCIe_Link_Info}

  #Adding Group
  set LEDs [ipgui::add_group $IPINST -name "LEDs" -parent ${Page_0}]
  ipgui::add_param $IPINST -name "has_user_led_out" -parent ${LEDs}
  ipgui::add_param $IPINST -name "has_sys_mon_led" -parent ${LEDs}

  #Adding Group
  set Interrupts [ipgui::add_group $IPINST -name "Interrupts" -parent ${Page_0}]
  ipgui::add_param $IPINST -name "has_irq_out" -parent ${Interrupts}
  ipgui::add_param $IPINST -name "has_ext_temp_irq" -parent ${Interrupts}
  ipgui::add_param $IPINST -name "has_sys_mon_irq" -parent ${Interrupts}
  ipgui::add_param $IPINST -name "has_i2c1_irq" -parent ${Interrupts}
  ipgui::add_param $IPINST -name "has_i2c2_irq" -parent ${Interrupts}
  ipgui::add_param $IPINST -name "has_user1_irq" -parent ${Interrupts}
  ipgui::add_param $IPINST -name "has_user2_irq" -parent ${Interrupts}
  ipgui::add_param $IPINST -name "has_user3_irq" -parent ${Interrupts}
  ipgui::add_param $IPINST -name "has_user4_irq" -parent ${Interrupts}
  ipgui::add_param $IPINST -name "has_user5_irq" -parent ${Interrupts}
  ipgui::add_param $IPINST -name "has_user6_irq" -parent ${Interrupts}
  ipgui::add_param $IPINST -name "has_user7_irq" -parent ${Interrupts}
  ipgui::add_param $IPINST -name "has_user8_irq" -parent ${Interrupts}



}

proc update_PARAM_VALUE.date_day { PARAM_VALUE.date_day PARAM_VALUE.has_rev_info_in } {
	# Procedure called to update date_day when any of the dependent parameters in the arguments change
	
	set date_day ${PARAM_VALUE.date_day}
	set has_rev_info_in ${PARAM_VALUE.has_rev_info_in}
	set values(has_rev_info_in) [get_property value $has_rev_info_in]
	if { [gen_USERPARAMETER_date_day_ENABLEMENT $values(has_rev_info_in)] } {
		set_property enabled true $date_day
	} else {
		set_property enabled false $date_day
	}
}

proc validate_PARAM_VALUE.date_day { PARAM_VALUE.date_day } {
	# Procedure called to validate date_day
	return true
}

proc update_PARAM_VALUE.date_month { PARAM_VALUE.date_month PARAM_VALUE.has_rev_info_in } {
	# Procedure called to update date_month when any of the dependent parameters in the arguments change
	
	set date_month ${PARAM_VALUE.date_month}
	set has_rev_info_in ${PARAM_VALUE.has_rev_info_in}
	set values(has_rev_info_in) [get_property value $has_rev_info_in]
	if { [gen_USERPARAMETER_date_month_ENABLEMENT $values(has_rev_info_in)] } {
		set_property enabled true $date_month
	} else {
		set_property enabled false $date_month
	}
}

proc validate_PARAM_VALUE.date_month { PARAM_VALUE.date_month } {
	# Procedure called to validate date_month
	return true
}

proc update_PARAM_VALUE.date_year { PARAM_VALUE.date_year PARAM_VALUE.has_rev_info_in } {
	# Procedure called to update date_year when any of the dependent parameters in the arguments change
	
	set date_year ${PARAM_VALUE.date_year}
	set has_rev_info_in ${PARAM_VALUE.has_rev_info_in}
	set values(has_rev_info_in) [get_property value $has_rev_info_in]
	if { [gen_USERPARAMETER_date_year_ENABLEMENT $values(has_rev_info_in)] } {
		set_property enabled true $date_year
	} else {
		set_property enabled false $date_year
	}
}

proc validate_PARAM_VALUE.date_year { PARAM_VALUE.date_year } {
	# Procedure called to validate date_year
	return true
}

proc update_PARAM_VALUE.fpga_code_rev { PARAM_VALUE.fpga_code_rev PARAM_VALUE.has_rev_info_in } {
	# Procedure called to update fpga_code_rev when any of the dependent parameters in the arguments change
	
	set fpga_code_rev ${PARAM_VALUE.fpga_code_rev}
	set has_rev_info_in ${PARAM_VALUE.has_rev_info_in}
	set values(has_rev_info_in) [get_property value $has_rev_info_in]
	if { [gen_USERPARAMETER_fpga_code_rev_ENABLEMENT $values(has_rev_info_in)] } {
		set_property enabled true $fpga_code_rev
	} else {
		set_property enabled false $fpga_code_rev
	}
}

proc validate_PARAM_VALUE.fpga_code_rev { PARAM_VALUE.fpga_code_rev } {
	# Procedure called to validate fpga_code_rev
	return true
}

proc update_PARAM_VALUE.board_id { PARAM_VALUE.board_id } {
	# Procedure called to update board_id when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.board_id { PARAM_VALUE.board_id } {
	# Procedure called to validate board_id
	return true
}

proc update_PARAM_VALUE.fpga_code_id { PARAM_VALUE.fpga_code_id } {
	# Procedure called to update fpga_code_id when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.fpga_code_id { PARAM_VALUE.fpga_code_id } {
	# Procedure called to validate fpga_code_id
	return true
}

proc update_PARAM_VALUE.fpga_size { PARAM_VALUE.fpga_size } {
	# Procedure called to update fpga_size when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.fpga_size { PARAM_VALUE.fpga_size } {
	# Procedure called to validate fpga_size
	return true
}

proc update_PARAM_VALUE.has_ext_temp_irq { PARAM_VALUE.has_ext_temp_irq } {
	# Procedure called to update has_ext_temp_irq when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_ext_temp_irq { PARAM_VALUE.has_ext_temp_irq } {
	# Procedure called to validate has_ext_temp_irq
	return true
}

proc update_PARAM_VALUE.has_fpga_size_in { PARAM_VALUE.has_fpga_size_in } {
	# Procedure called to update has_fpga_size_in when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_fpga_size_in { PARAM_VALUE.has_fpga_size_in } {
	# Procedure called to validate has_fpga_size_in
	return true
}

proc update_PARAM_VALUE.has_fpio_in { PARAM_VALUE.has_fpio_in } {
	# Procedure called to update has_fpio_in when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_fpio_in { PARAM_VALUE.has_fpio_in } {
	# Procedure called to validate has_fpio_in
	return true
}

proc update_PARAM_VALUE.has_i2c1_irq { PARAM_VALUE.has_i2c1_irq } {
	# Procedure called to update has_i2c1_irq when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_i2c1_irq { PARAM_VALUE.has_i2c1_irq } {
	# Procedure called to validate has_i2c1_irq
	return true
}

proc update_PARAM_VALUE.has_i2c2_irq { PARAM_VALUE.has_i2c2_irq } {
	# Procedure called to update has_i2c2_irq when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_i2c2_irq { PARAM_VALUE.has_i2c2_irq } {
	# Procedure called to validate has_i2c2_irq
	return true
}

proc update_PARAM_VALUE.has_irq_out { PARAM_VALUE.has_irq_out } {
	# Procedure called to update has_irq_out when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_irq_out { PARAM_VALUE.has_irq_out } {
	# Procedure called to validate has_irq_out
	return true
}

proc update_PARAM_VALUE.has_link_stat_in { PARAM_VALUE.has_link_stat_in } {
	# Procedure called to update has_link_stat_in when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_link_stat_in { PARAM_VALUE.has_link_stat_in } {
	# Procedure called to validate has_link_stat_in
	return true
}

proc update_PARAM_VALUE.has_rev_info_in { PARAM_VALUE.has_rev_info_in } {
	# Procedure called to update has_rev_info_in when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_rev_info_in { PARAM_VALUE.has_rev_info_in } {
	# Procedure called to validate has_rev_info_in
	return true
}

proc update_PARAM_VALUE.has_sys_mon_irq { PARAM_VALUE.has_sys_mon_irq } {
	# Procedure called to update has_sys_mon_irq when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_sys_mon_irq { PARAM_VALUE.has_sys_mon_irq } {
	# Procedure called to validate has_sys_mon_irq
	return true
}

proc update_PARAM_VALUE.has_sys_mon_led { PARAM_VALUE.has_sys_mon_led } {
	# Procedure called to update has_sys_mon_led when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_sys_mon_led { PARAM_VALUE.has_sys_mon_led } {
	# Procedure called to validate has_sys_mon_led
	return true
}

proc update_PARAM_VALUE.has_user1_irq { PARAM_VALUE.has_user1_irq } {
	# Procedure called to update has_user1_irq when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_user1_irq { PARAM_VALUE.has_user1_irq } {
	# Procedure called to validate has_user1_irq
	return true
}

proc update_PARAM_VALUE.has_user2_irq { PARAM_VALUE.has_user2_irq } {
	# Procedure called to update has_user2_irq when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_user2_irq { PARAM_VALUE.has_user2_irq } {
	# Procedure called to validate has_user2_irq
	return true
}

proc update_PARAM_VALUE.has_user3_irq { PARAM_VALUE.has_user3_irq } {
	# Procedure called to update has_user3_irq when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_user3_irq { PARAM_VALUE.has_user3_irq } {
	# Procedure called to validate has_user3_irq
	return true
}

proc update_PARAM_VALUE.has_user4_irq { PARAM_VALUE.has_user4_irq } {
	# Procedure called to update has_user4_irq when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_user4_irq { PARAM_VALUE.has_user4_irq } {
	# Procedure called to validate has_user4_irq
	return true
}

proc update_PARAM_VALUE.has_user5_irq { PARAM_VALUE.has_user5_irq } {
	# Procedure called to update has_user5_irq when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_user5_irq { PARAM_VALUE.has_user5_irq } {
	# Procedure called to validate has_user5_irq
	return true
}

proc update_PARAM_VALUE.has_user6_irq { PARAM_VALUE.has_user6_irq } {
	# Procedure called to update has_user6_irq when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_user6_irq { PARAM_VALUE.has_user6_irq } {
	# Procedure called to validate has_user6_irq
	return true
}

proc update_PARAM_VALUE.has_user7_irq { PARAM_VALUE.has_user7_irq } {
	# Procedure called to update has_user7_irq when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_user7_irq { PARAM_VALUE.has_user7_irq } {
	# Procedure called to validate has_user7_irq
	return true
}

proc update_PARAM_VALUE.has_user8_irq { PARAM_VALUE.has_user8_irq } {
	# Procedure called to update has_user8_irq when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_user8_irq { PARAM_VALUE.has_user8_irq } {
	# Procedure called to validate has_user8_irq
	return true
}

proc update_PARAM_VALUE.has_user_led_out { PARAM_VALUE.has_user_led_out } {
	# Procedure called to update has_user_led_out when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_user_led_out { PARAM_VALUE.has_user_led_out } {
	# Procedure called to validate has_user_led_out
	return true
}

proc update_PARAM_VALUE.user_word { PARAM_VALUE.user_word } {
	# Procedure called to update user_word when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.user_word { PARAM_VALUE.user_word } {
	# Procedure called to validate user_word
	return true
}


proc update_MODELPARAM_VALUE.has_rev_info_in { MODELPARAM_VALUE.has_rev_info_in PARAM_VALUE.has_rev_info_in } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_rev_info_in}] ${MODELPARAM_VALUE.has_rev_info_in}
}

proc update_MODELPARAM_VALUE.board_id { MODELPARAM_VALUE.board_id PARAM_VALUE.board_id } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.board_id}] ${MODELPARAM_VALUE.board_id}
}

proc update_MODELPARAM_VALUE.fpga_code_id { MODELPARAM_VALUE.fpga_code_id PARAM_VALUE.fpga_code_id } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.fpga_code_id}] ${MODELPARAM_VALUE.fpga_code_id}
}

proc update_MODELPARAM_VALUE.fpga_size { MODELPARAM_VALUE.fpga_size PARAM_VALUE.fpga_size } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.fpga_size}] ${MODELPARAM_VALUE.fpga_size}
}

proc update_MODELPARAM_VALUE.has_fpio_in { MODELPARAM_VALUE.has_fpio_in PARAM_VALUE.has_fpio_in } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_fpio_in}] ${MODELPARAM_VALUE.has_fpio_in}
}

proc update_MODELPARAM_VALUE.has_link_stat_in { MODELPARAM_VALUE.has_link_stat_in PARAM_VALUE.has_link_stat_in } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_link_stat_in}] ${MODELPARAM_VALUE.has_link_stat_in}
}

proc update_MODELPARAM_VALUE.fpga_code_rev { MODELPARAM_VALUE.fpga_code_rev PARAM_VALUE.fpga_code_rev } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.fpga_code_rev}] ${MODELPARAM_VALUE.fpga_code_rev}
}

proc update_MODELPARAM_VALUE.date_month { MODELPARAM_VALUE.date_month PARAM_VALUE.date_month } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.date_month}] ${MODELPARAM_VALUE.date_month}
}

proc update_MODELPARAM_VALUE.date_day { MODELPARAM_VALUE.date_day PARAM_VALUE.date_day } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.date_day}] ${MODELPARAM_VALUE.date_day}
}

proc update_MODELPARAM_VALUE.date_year { MODELPARAM_VALUE.date_year PARAM_VALUE.date_year } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.date_year}] ${MODELPARAM_VALUE.date_year}
}

proc update_MODELPARAM_VALUE.user_word { MODELPARAM_VALUE.user_word PARAM_VALUE.user_word } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.user_word}] ${MODELPARAM_VALUE.user_word}
}

proc update_MODELPARAM_VALUE.has_user_led_out { MODELPARAM_VALUE.has_user_led_out PARAM_VALUE.has_user_led_out } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_user_led_out}] ${MODELPARAM_VALUE.has_user_led_out}
}

proc update_MODELPARAM_VALUE.has_sys_mon_led { MODELPARAM_VALUE.has_sys_mon_led PARAM_VALUE.has_sys_mon_led } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_sys_mon_led}] ${MODELPARAM_VALUE.has_sys_mon_led}
}

proc update_MODELPARAM_VALUE.has_irq_out { MODELPARAM_VALUE.has_irq_out PARAM_VALUE.has_irq_out } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_irq_out}] ${MODELPARAM_VALUE.has_irq_out}
}

proc update_MODELPARAM_VALUE.has_sys_mon_irq { MODELPARAM_VALUE.has_sys_mon_irq PARAM_VALUE.has_sys_mon_irq } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_sys_mon_irq}] ${MODELPARAM_VALUE.has_sys_mon_irq}
}

proc update_MODELPARAM_VALUE.has_ext_temp_irq { MODELPARAM_VALUE.has_ext_temp_irq PARAM_VALUE.has_ext_temp_irq } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_ext_temp_irq}] ${MODELPARAM_VALUE.has_ext_temp_irq}
}

proc update_MODELPARAM_VALUE.has_i2c1_irq { MODELPARAM_VALUE.has_i2c1_irq PARAM_VALUE.has_i2c1_irq } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_i2c1_irq}] ${MODELPARAM_VALUE.has_i2c1_irq}
}

proc update_MODELPARAM_VALUE.has_i2c2_irq { MODELPARAM_VALUE.has_i2c2_irq PARAM_VALUE.has_i2c2_irq } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_i2c2_irq}] ${MODELPARAM_VALUE.has_i2c2_irq}
}

proc update_MODELPARAM_VALUE.has_user1_irq { MODELPARAM_VALUE.has_user1_irq PARAM_VALUE.has_user1_irq } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_user1_irq}] ${MODELPARAM_VALUE.has_user1_irq}
}

proc update_MODELPARAM_VALUE.has_user2_irq { MODELPARAM_VALUE.has_user2_irq PARAM_VALUE.has_user2_irq } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_user2_irq}] ${MODELPARAM_VALUE.has_user2_irq}
}

proc update_MODELPARAM_VALUE.has_user3_irq { MODELPARAM_VALUE.has_user3_irq PARAM_VALUE.has_user3_irq } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_user3_irq}] ${MODELPARAM_VALUE.has_user3_irq}
}

proc update_MODELPARAM_VALUE.has_user4_irq { MODELPARAM_VALUE.has_user4_irq PARAM_VALUE.has_user4_irq } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_user4_irq}] ${MODELPARAM_VALUE.has_user4_irq}
}

proc update_MODELPARAM_VALUE.has_user5_irq { MODELPARAM_VALUE.has_user5_irq PARAM_VALUE.has_user5_irq } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_user5_irq}] ${MODELPARAM_VALUE.has_user5_irq}
}

proc update_MODELPARAM_VALUE.has_user6_irq { MODELPARAM_VALUE.has_user6_irq PARAM_VALUE.has_user6_irq } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_user6_irq}] ${MODELPARAM_VALUE.has_user6_irq}
}

proc update_MODELPARAM_VALUE.has_user7_irq { MODELPARAM_VALUE.has_user7_irq PARAM_VALUE.has_user7_irq } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_user7_irq}] ${MODELPARAM_VALUE.has_user7_irq}
}

proc update_MODELPARAM_VALUE.has_user8_irq { MODELPARAM_VALUE.has_user8_irq PARAM_VALUE.has_user8_irq } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_user8_irq}] ${MODELPARAM_VALUE.has_user8_irq}
}

proc update_MODELPARAM_VALUE.has_fpga_size_in { MODELPARAM_VALUE.has_fpga_size_in PARAM_VALUE.has_fpga_size_in } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_fpga_size_in}] ${MODELPARAM_VALUE.has_fpga_size_in}
}

