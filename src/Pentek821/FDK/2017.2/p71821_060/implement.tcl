
#Runs implementation through bitstream and copy
#You can call the script as soon as you kick off synthesis,
#Or wait and set up debug first. If you set up debug, save synth_1 but don't close it (saves time)

wait_on_run synth_1

#This ltx doesn't have the signals renamed to junk, like the one output in implementation
if { [get_designs -quiet synth_1] ne "synth_1" } {
    open_run synth_1
}
implement_debug_core
write_debug_probes -force [get_property directory [get_projects]]/debug.ltx

#Initialize run
reset_run impl_1

#Run implementation
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1


