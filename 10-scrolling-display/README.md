## scrolling 7-segment display

**table of contents**

1.  [objectives](#objectives)
2.  [prerequisites](#prerequisites)
3.  [block diagram](#block-diagram)
4.  [components in design](#components)
	1.  [source 1 `clock-divider.vhd`](#source-1-clock-dividervhd)
	2.  [source 2 `counter.vhd`](#source-2-countervhd)\
	3.  [source 3 - 6 `display-driver-3-6.vhd`](#source-3---6-display-driver-3-6vhd)
	4.  [source 7 `LEDdisplay.vhd`](#source-7-LEDDisplayvhd)
	5.  [source 8 `toplevel.vhd`](#source-8-toplevelvhd)
	6.  [`toplevel.xdc`](#toplevelxdc)
	7.  [report](#report)

### objectives

The objective of this laboratory exercise is to learn how to use modular design in VHDL to display a scrolling phrase up to 16 characters long on the 4 7-segment displays on the Basys 3 board.

### prerequisites

1.  what components will be used in completing this lab?

`clock_divider.vhd`
`counter.vhd`
`display_driver_1.vhd`
`display_driver_2.vhd`
`display_driver_3.vhd`
`display_driver_4.vhd`
`LEDdisplay.vhd`
`toplevel.vhd`
`toplevel.xcd`

2.  how many connections (signals) will connect the counter to the display driver?

The counter will have 4 signals connecting to each of the display drivers, the variable for the signals is a vector of length 4. 

`signal counter_signal: STD_LOGIC_VECTOR(3 downto 0);`

```vhdl
signal counter_signal : STD_LOGIC_VECTOR(3 downto 0) := "0000";

begin

process (clock, clear_n)

begin
	if clear_n = '0' then
		counter_signal <= (others => '0');
	
	elsif (clock'event and clock = '1') then
		if load_n = '0' then
			counter_signal <= counter_signal + 1;
		else
			if enable = '1' then
				counter_signal <= counter_signal + 1;
			else
				counter_signal <= counter_signal;
			end if;
		end if;
	end if;
end process;

counter_output <= counter_signal;

end Behavioral;
```

3.  how will we test the result of this lab?

The result of this lab will be tested by using the Basys 3 board and the Xilinx Vivado software. The Basys 3 board will be used to display the scrolling phrase on the 4 7-segment displays. The Xilinx Vivado software will be used to simulate the scrolling phrase on the 4 7-segment displays.  I will display my name or any creative phrase similar to the example below.


```
---E
--EE
-EEC
EECS
ECS-
CS--
S--E
--EE
-EEC
EECS
ECS-
CS--
S--E
--EE
-EEC
EECS
```

## block-diagram

![block-diagram](./assets/block-diagram.png)

## components

### source 1 `clock-divider.vhd`

This component is responsible to take the on-board 450MHz clock input and divide it so that the period of the resulting clock is about 1 second.  We will call this new clock as `message_clk`.  This will control how fast or slow your message will scroll on the 4 7-segment displays.  You can test this component by hooking it up to an LED (say LD0) and make sure it blinks every 1 second or so).

[clock-divider](./src/clock_divider.vhd)
```vhdl
entity clock_divider is
	Port (  clk		: in STD_LOGIC;
		message_clk	: out STD_LOGIC);
end clock_divider;

architecture Behavioral of clock_divider is

-- create a signal called "count" (26 bit vector), that is signal declaration.
-- look at the code snippet below which is the counter that depends on clock signal

signal count : STD_LOGIC_VECTOR(25 downto 0)

begin

process(clk)
begin
	if (clk'event and clk = '1') then
		count <= count + 1;
	end if;
end process;

message_clk <= count(24);

end Behavioral;

```

### source 2 `counter.vhd`

I will then design a 4-bit counter that runs at the rate of `message_clk` which is the output of the clock divider, that is now the clock input of the counter).  The output will be a 4-bit vector called `counter_output`.  The counter also has extra inputs:  `enable`, `initial_value`, `clear_n`, `load_n`.

[counter.vhd](./src/counter.vhd)
```vhdl
entity counter is
	Port (  enable 		: in STD_LOGIC;

		-- initial_value is a 4-bit signal that contains an initial value to be 
		-- loaded into the counter
		load_n		: in STD_LOGIC;
		counter_output  : out STD_LOGIC_VECTOR(3 downto 0));
end counter;

architecture Behavioral of counter is

signal counter_signal : STD_LOGIC_VECTOR(3 downto 0) := "0000";

begin

process (clock, clear_n)

begin

	-- if clean_n is '0', (_n = negative logic, on = '0')
	if clear_n = '0' then
		-- then counter resets to zero "0000"
		counter_signal <= (others => '0');
	
	elsif (clock'event and clock = '1') then
		if load_n = '0' then
			counter_signal <= counter_signal + 1;
		else
			-- if enable is on (positive logic, on = '1)
			if enable = '1' then
				-- then the counter increments its value with time
				counter_signal <= counter_signal + 1;
			-- if enable is off (negative logic, off = '0')
			else
				-- then else it remains at the same value
				counter_signal <= counter_signal;
			end if;
		end if;
	end if;
end process;

counter_output <= counter_signal;

end Behavioral;
```

### source 3 `display_driver_1.vhd`

Next are the 4 display drivers:
`display_driver_1.vhd`
`display_driver_2.vhd`
`display_driver_3.vhd`
`display_driver_4.vhd`

Use 'when' statements 
