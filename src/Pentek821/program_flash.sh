#!/bin/bash

#argument: a folder containing a bitstream

../Navigator_xx821/BSP_2.4/util/flash_util/flash_util.out -b 1 -a -f $1/*.mcs

