# digital-logic-design

## latches, flip-flops, registers

**table of contents**

1.  [objective](#objective)
2.  [discussion](#discussion)
3.  [tasks](#tasks)
	1.  [preconditions](#preconditions)
	2.  [step 1 diagram](#step-1-diagram)
	3.  [step 2 RSLatch](#step-2-rslatch)
	4.  [step 3 gated D latch](#step-3-gated-d-latch)
	5.  [step 4 master slave D flip-flop](#step-4-master-slave-d-flip-flop)
4.  [report](#report)


## objective

the objective of this program is to investigate latches, flip-flops, and registers.

## discussion

**latches**

Latches are circuits that store sigle bits.  One basic type of latch is the `RS-latch` which has two inputs, labeled _Set_ and _Reset_.  These two inputs, which are typically labeled `S` and `R`, provide a means for changing the state `Q` of the circuit.  

- When `R = 0` and `S = 0`, the latch maintains its existing state.  

- When `R = 0` and `S = 1` the latch is siad to be in the _Set_ state.  In this case, the circuit output is `1`.

- When `R = 1` and `S = 0` the latch is said to be in the _Reset_ state.  In this case, the circuit output is `0`.

- When `R = 1` and `S = 1` the circuit is said to be in an _undefined_ or _illegal_ state for the RS-latch.  In this case the circuit output is `0`.

**flip-flop**

A flip-flop is the basic sequential circuit element that stores one bit.  A flip-flop changes its output state at the edge of a controlling clock signal.

- When a set of `n` flip-flops is used to store `n` bits of information, we refer to these flip-flops as registers.  A common clock is used to each flip-flop in a **register**.

## tasks

Step-wise refinement tasks in order to complete this program.

### preconditions

The following are questions that address the major precondition for this program.

**1.  What is the purpose of a latch?**

	The purpose of a latch is to store a single bit of information, and to change that information when a signal is applied to the latch.

**2.  How many flip-flops are required to implement a 16-bit register?**

	`n` flip-flips are required to implement a `n`-bit register, thus 16 flip-flops are required to implement a 16-bit register.

**3.  What is the purpose of the `VHDL ATTRIBUTE` statement in the code snippet shown on the following** [figure 1 - gated `RS-latch` circuit](#figure-1---gated-rs-latch)

**4.  How will we test the functionality of the gated D latch in this lab?**

**5.  Suppose you are given a 100-MHz signal, how will you generate a 50-MHz and 25-MHz clock signal?**

### signal frequency

<p align="center">
	<img src="./assets/freq.gif" width="200" align="center" />
</p>

megahertz (106 Hz, MHz) is a unit of frequency equal to one million hertz (1,000,000 Hz).  The symbol for megahertz is MHz.  The symbol for hertz is Hz.

Frequency is the number of occurrences of a repeating event per unit of time.[1] It is also occasionally referred to as temporal frequency to emphasize the contrast to spatial frequency, and ordinary frequency to emphasize the contrast to angular frequency. Frequency is expressed in units of hertz (Hz) which is equivalent to one (event) per second.

Sometimes the adjectival form "per second" was omitted, so that "megacycles" (Mc) was used as an abbreviation of "megacycles per second" (that is, megahertz (MHz)).

In computers, most central processing units (CPU) are labeled in terms of their clock rate expressed in megahertz (106 Hz)

In computing, the clock rate or clock speed typically refers to the frequency at which the clock generator of a processor can generate pulses, which are used to synchronize the operations of its components,[1] and is used as an indicator of the processor's speed. It is measured in the SI unit of frequency hertz (Hz).

The clock rate of the first generation of computers was measured in hertz or kilohertz (kHz), the first personal computers (PCs) to arrive throughout the 1970s and 1980s had clock rates measured in megahertz (MHz), and in the 21st century the speed of modern CPUs is commonly advertised in gigahertz (GHz). This metric is most useful when comparing processors within the same family, holding constant other features that may affect performance.


**orders of magnitude of clock rates**

| order of magnitude | clock rate |
|:------------------:|:----------:|
| 10^0               | 1 Hz       |
| 10^3               | 1 kHz      |
| 10^6               | 1 MHz      |
| 10^9               | 1 GHz      |

- 1 Hz is the frequency of a clock that ticks once every second.
- 1 MHz is the frequency of a clock that ticks once every millionth of a second.

Given a 100-MHz signal, we can generate a 50-MHz and 25-MHz clock signal by dividing the 100-MHz signal by 2 and 4, respectively.

$$ 100 \text{MHz} = \frac{100 \text{MHz}}{2} = 50 \text{MHz} $$

$$ 100 \text{MHz} = \frac{100 \text{MHz}}{4} = 25 \text{MHz} $$

## step 1 diagram

### figure 1 - gated `RS-latch` circuit

<p align="center">
	<img src="./assets/diagram-rs-latch.png" />
</p>

Xilinx FPGAs include flip-flops that are available for implementing a users' circuit.  Later in this README there will be an explaination on how to make use of these flip-flops.  However initially, the following will show how storage elements can be created in a FPGA without using its dedicated flip-flops.

The following figure depicts a **gated RS latch circuit**.  

A style of VHDL code that uses logic expressions to describe this circuit is given in the code snippet below.  If this latch is implemented in a FPGA that has 4-input look-up tables (LUTs), then the only one lookup table is needed.


`RS-latch` circuit inputs and outputs

| input R | input S | output Q |       state of latch       |
|:-------:|:-------:|:--------:|:--------------------------:|
|    0    |    0    |    0     |  maintain existing state   |
|    0    |    1    |    1     |           Set state	    |
|    1    |    0    |    0     |          Reset state	    |
|    1    |    1    |    0     | undefined or illegal state |



```vhdl
-- A gated RS latch described the hard way
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY RSLatch IS
    PORT ( Clk, R, S : IN STD_LOGIC;
           Q         : OUT STD_LOGIC);

END RSLatch ;

ARCHITECTURE Structural OF RSLatch IS

	SIGNAL R_g, S_g, Qa, Qb : STD_LOGIC ;

	ATTRIBUTE keep : boolean;
	
	ATTRIBUTE keep of R_g, S_g, Qa, Qb : SIGNAL IS true;

BEGIN
	R_g <= R AND Clk;
  	
	S_g <= S AND Clk;
  	
	Qa  <= NOT (R_g OR Qb);
  	
	Qb  <= NOT (S_g OR Qa);
  	
	Q   <= Qa;

END Structural;

```

Although the latch can be correctly realized in one 4-input LUT (lookup tables), this implementation does not allow its interal signals, such as `R_g` adn `S_g` to be observed, because they are not provided as outputs from the LUT.  In order to preserve these internal signals in the implemented circuit, it is necessary to include a _compiler directive_ in the code.  In the VHDL code above the directive keep is included by using a `VHDL ATTRIBUTE` statement; it instructs the compiler to use separate logic elements for each of the signals `R_g`, `S_g`, `Qa`, and `Qb`.  

Compiling the code produces the circuit four `4-LUTs` depicted below the diagram in 

[figure 1 - gated `RS-latch` circuit and 4-LUTs](#figure-1---gated-rs-latch-circuit-and-4-luts)

<p align="center">
	<img src="./assets/rs-latch-LUT.png" />
</p>

## step 2 RSLatch

creating a new Vivado project for the RS latch circuit as follows

1.  new project for the RS latch on the H:// drive

2.  generate a VHDL file with the code shown above and include it in the project

3.  add a testbench source file to the project (see below for the RSLatch testbench

4.  run simulation

5.  click on zoom fit icon in simulation results window to view entire result in one screen

```vhdl
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY RSLatch_tb IS 
END RSLatch_tb;
 
ARCHITECTURE behavior OF RSLatch_tb IS

COMPONENT RSLatch
       PORT(Clk,R,S : IN STD_LOGIC;
                  Q : OUT STD_LOGIC);
END COMPONENT RSLatch;
 
signal S : std_logic := '0';
signal R : std_logic := '0';
signal Clk : std_logic := '0';
signal Q : std_logic;

constant clk_period : time := 10 ns;

BEGIN

uut: RSLatch PORT MAP (Clk => Clk,
                           R=>R,
                           S=>S,
                           Q=>Q);       

-- Clock process definitions( clock with 50% duty cycle is generated here.
clk_process :process
  begin
   clk <= '0';
   wait for clk_period/2;
   clk <= '1';
   wait for clk_period/2;
  end process;
  
rslatch_proc :process
  begin
 s <= '0';
 r <= '1';
 wait for 20ns;  
 s <= '1'; 
 r <= '0';
 wait for 20ns;  
 s <= '0'; 
 r <= '0';
 wait for 20ns;
 s <= '1'; 
 r <= '1';
 wait for 20ns;
  end process;
END;
```

**simulation results**

<p align="center">
	<img src="./assets/01-waveform.png" />
</p>

<p align="center">
	<img src="./assets/00-waveform.png" />
</p>

## step 3 gated D latch

the following figure shows the circuit for a gated D latch.  This will be used to as the implementation for the latch on the Basys3 board 

<p align="center">
	<img src="./assets/diagram-d-latch.png" />
</p>

```vhdl
set_property seversity {Warning} [get_drc_checks LUTLP-1]
```

```
.
├── 01-into-FPGA-programming-in-vivado
│   ├── README.md
│   ├── assets
│   │   ├── lab01-1.jpg
│   │   ├── lab01-2.jpg
│   │   ├── lab01-3.jpg
│   │   ├── lab01-4.jpg
│   │   ├── lab01-5.jpg
│   │   ├── lab01-6.jpg
│   │   └── lab01-7.jpg
│   ├── project_1.xpr
│   ├── vivado.jou
│   ├── vivado.log
│   ├── vivado_pid23744.str
│   └── vivado_pid23924.str
├── 02-vhdl
│   └── lab02
│       ├── Basys3_Master.txt
│       ├── Intro_VHDL.pdf
│       ├── and_not_gate.xdc
│       ├── and_not_gate.xdc 2
│       ├── bergen_lab2.vhd
│       ├── output.txt
│       └── view.png
├── 03-nuclear-control-circuit
│   ├── README.md
│   ├── and_or_gate.xdc
│   ├── main.vhd
│   ├── morgan-bergen-lab03-report.pdf
│   └── prelab03.pdf
├── 04-prototype-board
│   ├── info.md
│   └── lab04
│       ├── info
│       └── report
│           ├── assets
│           │   ├── lab04-5.HEIC
│           │   └── lab04-6.HEIC
│           └── final
├── 05-sop-expression
│   └── prelab05.pdf
├── 06-design-7-segment-display
│   ├── README.md
│   ├── Screenshot (1).png
│   ├── SevenSeg.vhd
│   ├── constraints.xdc
│   ├── lab
│   └── prelab-quiz
│       ├── prelab06.pages
│       └── prelab06.pdf
├── 07-intro-structural-vhdl
│   ├── EECS_140_modular_VHDL_Tutorial.pdf
│   ├── Introduction_to_Vivado.pdf
│   ├── README.md
│   ├── lab
│   │   ├── Untitled.pages
│   │   ├── assets
│   │   │   ├── Screenshot (1).png
│   │   │   ├── Screenshot (2).png
│   │   │   ├── Screenshot (3).png
│   │   │   ├── Screenshot (4).png
│   │   │   └── Screenshot (5).png
│   │   ├── file.pages
│   │   ├── lab07.pages
│   │   ├── lab07.pdf
│   │   ├── lab07.txt
│   │   ├── my_xor6_gate.xdc
│   │   └── xor6v_gate.xdc
│   └── prelab
│       └── prelab07.pdf
├── 08-four-bit-adder
│   ├── 4_bit_adder.xdc
│   ├── Capture.PNG
│   ├── Capture0.PNG
│   ├── Capture1.PNG
│   ├── Capture2.PNG
│   ├── bit_full_adder.vhd
│   ├── constraints.xdc
│   ├── lab08.pages
│   ├── lab08.pdf
│   ├── led_display.vhd
│   ├── prelab.txt
│   ├── prelab08.pages
│   ├── prelab08.pdf
│   └── toplevel.vhd~5d6c3a30818be48b0b9a8eb45bf0c0994312a765
├── 09-arithmetic-logic-unit
│   ├── assets
│   │   ├── lab09.pdf
│   │   └── prelab09.pdf
│   └── src
│       └── Lab_9
│           ├── Alvarado_Lab
│           │   ├── Alvarado_Lab.ip_user_files
│           │   └── Alvarado_Lab.sim
│           └── Alvarado_Lab_9
│               ├── Alvarado_Lab_9.cache
│               │   ├── compile_simlib
│               │   │   ├── activehdl
│               │   │   ├── ies
│               │   │   ├── modelsim
│               │   │   ├── questa
│               │   │   ├── riviera
│               │   │   ├── vcs
│               │   │   └── xcelium
│               │   └── ip
│               │       └── 2019.2
│               ├── Alvarado_Lab_9.hw
│               │   └── hw_1
│               │       └── wave
│               ├── Alvarado_Lab_9.ip_user_files
│               ├── Alvarado_Lab_9.runs
│               │   └── impl_1
│               └── Alvarado_Lab_9.sim
├── 10-scrolling-display
│   ├── README.md
│   ├── assets
│   │   ├── 00-scroll.png
│   │   ├── 01-scroll.png
│   │   ├── 02-scroll.png
│   │   ├── 03-scroll.png
│   │   ├── block-diagram.png
│   │   ├── code
│   │   │   ├── 00-clock_divider.png
│   │   │   ├── 00-counter.png
│   │   │   ├── 00-display_driver_1.png
│   │   │   ├── 00-display_driver_2.png
│   │   │   ├── 00-display_driver_3.png
│   │   │   ├── 00-display_driver_4.png
│   │   │   ├── 00-leddisplay.png
│   │   │   ├── 00-toplevel-constraints.png
│   │   │   ├── 00-toplevel.png
│   │   │   ├── 01-leddisplay.png
│   │   │   ├── 01-toplevel.png
│   │   │   ├── 02-leddisplay.png
│   │   │   ├── 02-toplevel.png
│   │   │   └── 03-leddisplay.png
│   │   ├── evaluation.png
│   │   ├── final.png
│   │   ├── lab10.pdf
│   │   ├── outline.pdf
│   │   └── prelab10.pdf
│   └── src
│       ├── LEDdisplay.vhd
│       ├── clock_divider.vhd
│       ├── counter.vhd
│       ├── display_driver_1.vhd
│       ├── display_driver_2.vhd
│       ├── display_driver_3.vhd
│       ├── display_driver_4.vhd
│       └── toplevel.vhd
├── 11-encoder-decoder
│   ├── README.md
│   ├── assets
│   │   ├── decoder.png
│   │   ├── encoder-decoder-uniform.png
│   │   ├── encoder-decoder.png
│   │   ├── encoder.png
│   │   ├── lab11.pages
│   │   ├── lab11.pdf
│   │   ├── outline.pdf
│   │   ├── truth-table-0.jpg
│   │   ├── truth-table-1.jpg
│   │   └── truth-table.png
│   └── src
│       ├── decoder.vhd
│       ├── decoder.xdc
│       ├── encoder.vhd
│       └── encoder.xdc
├── 12-latches-flipflops
│   ├── README.md
│   ├── assets
│   │   ├── 00-waveform.png
│   │   ├── 01-waveform.png
│   │   ├── diagram-d-latch.png
│   │   ├── diagram-rs-latch.png
│   │   ├── freq.gif
│   │   ├── lab12.pages
│   │   ├── outline.pdf
│   │   ├── prelab12.pdf
│   │   └── rs-latch-LUT.png
│   └── src
│       └── latch.vhd
├── README.md
└── info
    ├── README.md
    ├── notes
    │   ├── 00-demorgans-theorem
    │   │   └── README.md
    │   └── 01-circuit-diagram-universal-gates
    │       └── README.md
    └── syllabus.pdf

60 directories, 131 files
```

[home](https://resilinets.org/eecs_140_lab.html#Lab_9:_Arithmetic_Logic_Unit)

All material in this repo will cover the VHDL and CAD tools. Additional topics will include Boolean algebra, combinational logic circuits, minimization techniques, AND, OR, NOT, NAND, NOR gates, implementation of sequential circuits, and synthesis techniques of logic circuits using VHDL. The lab deliverables will consist of simple gate implementations and digital systems such as a simple processor.

Dr. McNaughton is the professor for this course.

<img src="https://user-images.githubusercontent.com/65584733/186497780-c5679577-0472-40c6-a35f-ca7a49abaac4.jpeg" width=50% height=50%>



