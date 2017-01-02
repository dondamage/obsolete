#!/bin/bash
#
# File: run_syn.sh
# Author: Andreas Mueller
# Date: 2016-03-23
#
# Description: Synthesize the generic_ocram component with Xilinx Vivado.
#

TOP_UNIT_NAME=generic_ocram
TOP_UNIT_FILE=${TOP_UNIT_NAME}.vhd

SYN_DIR=../..
SYN_OUT_DIR=${SYN_DIR}/vivado/out
SYN_RUN_DIR=${SYN_DIR}/vivado/run
SYN_TMP_DIR=${SYN_DIR}/vivado/tmp

RTL_DIR=${SIM_DIR}/../rtl
RTL_FILES=$(find ${RTL_DIR} -name *.[vV][hH][dD])


# Uncomment the following lines for debugging.
#set -o verbose
#echo ${RTL_FILES}
