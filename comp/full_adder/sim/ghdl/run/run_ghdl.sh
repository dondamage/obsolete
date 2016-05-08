#!/bin/bash
#
# File: run_ghdl.sh
# Author: Andreas Mueller
# Date: 2016-03-22
#
# Description: Simulate the full_adder component with GHDL.
#

TOP_UNIT_NAME=full_adder_tb
TOP_UNIT_FILE=${TOP_UNIT_NAME}.vhd

SIM_DIR=../..
SIM_OUT_DIR=${SIM_DIR}/ghdl/out
SIM_RUN_DIR=${SIM_DIR}/ghdl/run
SIM_TMP_DIR=${SIM_DIR}/ghdl/tmp

RTL_DIR=${SIM_DIR}/../rtl
RTL_FILES=$(find ${RTL_DIR} -name *.[vV][hH][dD])
TEST_DIR=${SIM_DIR}/../test
TEST_SRC_DIR=${TEST_DIR}/src
TEST_SRC_FILES=$(find ${TEST_SRC_DIR} -name *.[vV][hH][dD])
TEST_BENCH=${TEST_DIR}/bench/${TOP_UNIT_FILE}

GHDL_OPT_STD="--std=08"
GHDL_OPT_IEEE="--ieee=standard"
GHDL_OPT_WORKDIR="--workdir=${SIM_OUT_DIR}"
GHDL_OPT_VCD="--vcd=sim.vcd"
GHDL_OPTS="${GHDL_OPT_STD} ${GHDL_OPT_IEEE} ${GHDL_OPT_WORKDIR} ${GHDL_OPT_VCD}"


# Uncomment the following lines for debugging.
#set -o verbose
#echo ${RTL_FILES}
#echo ${TEST_BENCH}


#echo "### Running design analysis."
#ghdl -a --std=${STD} --ieee=${IEEE} --workdir=${SIM_OUT_DIR} ${RTL_FILES} ${TEST_BENCH}

#echo "### Running design elaboration."
#ghdl -e --std=${STD} --ieee=${IEEE} --workdir=${SIM_OUT_DIR} ${TOP_UNIT_NAME}

#echo "### Running design simulation."
#ghdl -r --std=${STD} --ieee=${IEEE} --workdir=${SIM_OUT_DIR} ${TOP_UNIT_NAME}


echo "### Importing files into design."
ghdl -i ${GHDL_OPT_STD} ${GHDL_OPT_IEEE} ${GHDL_OPT_WORKDIR} ${RTL_FILES} ${TEST_BENCH}

echo "### Analyzing and elaborating design."
ghdl -m ${GHDL_OPT_STD} ${GHDL_OPT_IEEE} ${GHDL_OPT_WORKDIR} -o ${SIM_OUT_DIR}/${TOP_UNIT_NAME} ${TOP_UNIT_NAME}

echo "### Simulating design."
cd ../out
ghdl -r ${GHDL_OPT_WORKDIR} ${TOP_UNIT_NAME} ${GHDL_OPT_VCD}
cd ../run
