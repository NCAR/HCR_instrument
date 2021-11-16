#Get the kickoff date/time register values, created in presynth.tcl
set fp [open "../synth_1/ver_tmp.txt" r]
gets $fp ODATE
gets $fp OTIME
close $fp

#Create output names.
#First two fields are the synthesis time registers
#The last field is the bitstream kickoff time.
set RUNDIR [file normalize .]
set OUID [clock format [file mtime $RUNDIR/p71821.bit] -format %d%H%M]
set ONAME hcrdrx_20${ODATE}_${OTIME}_${OUID}
set ODIR /h/eol/karboski/builds/hcr_p71821/${ONAME}

#Write the flash file
write_cfgmem -format mcs -interface bpix16 -size 32 -loadbit "up 0x00000000 $RUNDIR/p71821.bit" -checksum -force -file $RUNDIR/p71821.mcs

puts "Copying build to $ODIR"

#Copy the output
file mkdir $ODIR
file copy $RUNDIR/p71821.bit $ODIR/$ONAME.bit
file copy $RUNDIR/p71821.mcs $ODIR/$ONAME.mcs
file copy $RUNDIR/p71821.msk $ODIR/$ONAME.msk
file copy $RUNDIR/p71821_utilization_placed.rpt $ODIR/${ONAME}_util.rpt
file copy $RUNDIR/p71821_timing_summary_routed.rpt $ODIR/${ONAME}_time.rpt
if { [file exists "$RUNDIR/p71821.ltx"] == 1} {               
    file copy $RUNDIR/p71821.ltx $ODIR/debug_nets_1.ltx
}
if { [file exists "../../debug.ltx"] == 1} {               
    file copy ../../debug.ltx $ODIR/debug_nets_2.ltx
}

puts "Copy complete"
