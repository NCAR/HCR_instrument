#!/bin/env python
#
# Simple Python script to extract from a CFRadial netCDF file the specified 
# radar parameter at the specified gate for all times in the file. A number of
# other variables are also extracted. The output is CSV text with one row
# per time in the netCDF file, and containing the variables:
#
# time, <selected var>, beam rotation angle, beam tilt angle, azimuth, elevation
#
# This is the form accepted by the MATLAB/Octave plotting program.

import calendar
from dateutil import parser as dateParser
import numpy
import sys
import os
from netCDF4 import Dataset

if len(sys.argv) < 4:
    sys.exit("Usage: %s <CFRadial_filename> <dbmVar> <gate>" % sys.argv[0])

# Make sure the requested file exists
ncName = sys.argv[1]
if not os.path.exists(ncName):
    sys.exit("File %s does not exist" % ncName)
    
# Get var name
varName = sys.argv[2]

# Parse the gate number 
gateNum = None
try:
    gateNum = int(sys.argv[3])
except ValueError:
    sys.exit("Bad gate number '%s'" % sys.argv[3])

# Open the netCDF file
dataset = Dataset(ncName, 'r')

# Extract the start time string and turn it into an integer time stamp in
# seconds since 1970-01-01 00:00:00 UTC
startString = ""
for char in dataset.variables['time_coverage_start'][:]:
    if not char is numpy.ma.masked:
        startString += char
        
startTime = calendar.timegm(dateParser.parse(startString).utctimetuple())
time = dataset.variables['time'][:]
time += startTime
rot = dataset.variables['rotation'][:]
tilt = dataset.variables['tilt'][:]
az = dataset.variables['azimuth'][:]
el = dataset.variables['elevation'][:]
dbmValues = dataset.variables[varName][:, gateNum]
 
for n in range(len(dbmValues)):
    print("%s,%s,%s,%s,%s,%s" % (time[n], dbmValues[n], rot[n], tilt[n], az[n], el[n]))