# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_static_text $IPINST -name "LMK Desc" -parent ${Page_0} -text {SPI IP Core for Texas Instrument LMK04832 external

device

3-Wire Mode

12-bit address field plus W1 and W2 bit

8-bit data field}


}


