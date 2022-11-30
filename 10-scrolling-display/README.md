## scrolling display

scrolling 7-segment display

### objectives

The objective of this laboratory exercise is for you to learn how to use modular design in VHDL to display a scrolling phrase up to 16 characters long on the 4 7-segment displays on the Basys 3 board.

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

the counter will have 4 connections to the display driver.  The following is it's archiecture that demonstrates this fact.

```vhdl
begin
process (clock, clean_n)
begin
architecture Behavioral of counter is
signal counter_signal:std_logic_vector(3 downto 0) := "0000";
if clean_n = '0' then
counter_signal <= (others => '0');
else if (clock'event and clock = '1') then
if load_n = '0' then
counter_signal <= initial_value;
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

the test will be conducted by ensuring



