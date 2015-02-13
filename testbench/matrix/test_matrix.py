
import random
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge, ReadOnly
from cocotb.result import TestFailure, ReturnValue

@cocotb.coroutine
def rst_dac(dut):
    """This coroutine performs a reset"""
    yield RisingEdge(dut.clk)                  # Synchronise to the read clock
    dut.rst = 1
    dut.conv = 0
    dut.dac_in = 0  
    yield RisingEdge(dut.clk)                  # Synchronise to the read clock
    dut.rst = 0
    yield RisingEdge(dut.clk)                  # Synchronise to the read clock
    
@cocotb.coroutine
def conv_dac(dut, value):
    """This coroutine performs a DAC conversion"""
    yield RisingEdge(dut.clk)                  # Synchronise to the read clock
    dut.rst = 0
    dut.conv = 1
    dut.dac_in = 65 #value                        # Drive the values
    yield RisingEdge(dut.clk)                  # Wait 1 clock cycle
#    yield ReadOnly()                           # Wait until all events have executed for this timestep
    raise ReturnValue(int(dut.dac_out.value))  # Read back the value

@cocotb.test()
def test_dac(dut):
    """Try converting digital data"""
    SIG = {}
    # Read the parameters back from the DUT to set up our model
    resolution = dut.RES.value.integer
    dut.log.info("Found %d bit resolution DAC" % (resolution))
    # Set up independent read/write clocks
    cocotb.fork(Clock(dut.clk, 10).start())
    
    yield rst_dac(dut)
    
    for cycle in xrange(4):
        yield RisingEdge(dut.clk)
        
    dut.log.info("Writing in random values")
    for i in xrange(20):
        SIG[i] = int(random.getrandbits(resolution))
        analog = yield conv_dac(dut, SIG[i])
        dut.log.info("%d   %d" % (analog, SIG[i]))
        
    dut.log.info("Conversion done")