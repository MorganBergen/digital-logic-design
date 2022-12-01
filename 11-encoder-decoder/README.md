# encoder and decoder

**table of contents**

1.  [objective](#objective)
2.  [discussion](#discussion)
3.  [tasks](#tasks)
	1. [step 1](#step-1)
	2. [step 2](#step-2)
	3. [step 3](#step-3)
	4. [step 4](#step-4)
4.  [report](#report)

## objective

This lab will comprise of decoder and encoder circuits.
Decoder circuits have n inputs and up to 2n outputs.
One output is associated with each possible binary input.
Encoders are the opposite of decoders.
Encoders have 2n inputs and n outputs.

The design and implementation of this program will be a 3-to-8 decoder and 8-to-3 encoder.

## discussion

**decoder**

A decoder can take the form of a multiple-input, multiple-output logic circuit that converts coded inputs into coded outputs, where the input and output codes are different e.g. n-to-2n, binary-coded decimal decoders.  Decoding is necessary in applications such as data multiplexing, 7-segment display, and memory address decoding.

**encoder**

Encoders are combinational logic circuits and they are exactly opposite of decoders.  They accept one or more inputs and generate a multibit output code.  An encoder has `m` input and `n` output lines.  Out of the `m` input lines only one is activated at a time and produces equivalent code on output `n` lines.  If a device output code has fewer bits than the input code has, the device is usually called an encoder.  The logic circuit of a 8-to-3 encoder and a 3-to-8 decoder is presented below.

**logic diagram of octal to binary encoder | logic diagram of 3:8 decoder**

![encoder-decoder](./assets/encoder-decoder.png)

![encoder-decoder-uniform](./assets/encoder-decoder-uniform.png)

## tasks

### step 1

**1.  write the truth table for 3-to-8 encoder shown in the figure above.**

|   **input(x)** | |  |  |  | |  |  |  |   **output(y)** |  |  |  |
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|    |**I7** | **I6** | **I5** | **I4** | **I3** | **I2** | **I1** | **I0** |    | **Y2** | **Y1** | **Y0** |
|    | 0  | 0  | 0  | 0  | 0  | 0  | 0  | 0  |    | 0  | 0  | 0  |
|    | 0  | 0  | 0  | 0  | 0  | 0  | 1  | 0  |    | 1  | 0  | 0  |
|    | 0  | 0  | 0  | 0  | 0  | 1  | 0  | 0  |    | 0  | 1  | 0  |
|    | 0  | 0  | 0  | 0  | 1  | 0  | 0  | 0  |    | 1  | 1  | 0  |
|    | 0  | 0  | 0  | 1  | 0  | 0  | 0  | 0  |    | 0  | 0  | 1  |
|    | 0  | 0  | 1  | 0  | 0  | 0  | 0  | 0  |    | 1  | 0  | 1  |
|    | 0  | 1  | 0  | 0  | 0  | 0  | 0  | 0  |    | 0  | 1  | 1  |
|    | 1  | 0  | 0  | 0  | 0  | 0  | 0  | 0  |    | 1  | 1  | 1  |

**2.  input(x) is a 8-bit vector**

**3.  output(y) is a 3-bit vector**

**4.  logical equations for the outputs are:**


$Y_{0} = I_{4} + I_{5} + I_{6} + I_{7}$

$Y_{1} = I_{2} + I_{3} + I_{6} + I_{7}$

$Y_{2} = I_{1} + I_{3} + I_{5} + I_{7}$

**5.  How do you verify the correctness of the design on the FPGA board?**

In order to verify the correctness of the design on the FPGA board you must test the design with different inputs and compare the outputs with the expected outputs.

### step 2

Next I will implement a vivado project for the 3-to-8 decoder circuit.

1.  create a new project for the decoder in my H:// drive

2.  generate a VHDL file for the above schematic provided and include it in the project
