# Register File
## Overview

This module implements a 16-register file with 32-bit registers using a bit-sliced design.

## Specifications

* Number of registers: 16
* Register width: 32 bits

## Architecture

The register file is implemented using:

* A 4-to-16 decoder for write selection 
* 16-to-1 multiplexers for read selection
* Bit-sliced structure (32 parallel 1-bit datapaths)

## Components

### Decoder

* Input: 4-bit register index
* Output: 16-bit one-hot write enable
* Used to select which register is written

### Multiplexer (16-to-1)

* Selects one bit from 16 registers
* Replicated 32 times to form a 32-bit read port
