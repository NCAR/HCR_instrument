# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_static_text $IPINST -name "LMX Desc" -parent ${Page_0} -text {SPI IP Core for Texas Instrument LMX2594 external

device

4-Wire Mode

7-bit address field

16-bit data field}


}


