# Current date, time, and seconds since epoch
# 0 = 4-digit year
# 1 = 2-digit year
# 2 = 2-digit month
# 3 = 2-digit day
# 4 = 2-digit hour
# 5 = 2-digit minute
# 6 = 2-digit second
# 7 = Epoch (seconds since 1970-01-01_00:00:00)
# Array index                                            0  1  2  3  4  5  6  7
set datetime_arr [clock format [clock seconds] -format {%Y %y %m %d %H %M %S %s}]
 
# Get the datecode in the yy-mm-dd-HH format
set rev_date [lindex $datetime_arr 1][lindex $datetime_arr 2][lindex $datetime_arr 3]
set rev [lindex $datetime_arr 4]

# Show this in the log
puts REV_DATE=$rev_date
puts REV=$rev
 
# Set the generics
set_property generic "rev_date=24'h$rev_date rev=8'h$rev" [current_fileset]

set fp [open "ver_tmp.txt" w+]
puts $fp "$rev_date\n$rev"
close $fp

