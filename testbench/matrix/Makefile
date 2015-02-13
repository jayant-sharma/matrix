
TOPLEVEL = dac
PWD=$(shell pwd)
COCOTB=/home/jayant/devel/cocotb
SRC=$(PWD)/../../hdl

VERILOG_SOURCES =  $(SRC)/dac.v $(SRC)/tb.v
MODULE=test_dac #cocotb,test_discovery,test_external,test_regression
EXTRA_ARGS=-I ../../include -I ../../hdl
SIM_ARGS=-lxt2
      
include $(COCOTB)/makefiles/Makefile.inc
include $(COCOTB)/makefiles/Makefile.sim