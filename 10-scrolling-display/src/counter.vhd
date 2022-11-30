-- module name	counter.vhd
-- engineer	morgan bergen
-- design date	tues nov 29

-- description
-- You will then design a 4-bit counter that runs at the rate of message_clk (the output of the clock divider is now the clock input of the counter). The output will be a 4-bit vector called counter_output. The counter also has extra inputs: enable, initial_value, clear_n, and load_n.
-- If enable is on (positive logic, On = '1'), the counter increments its value with time, else it remains at the same value. When clear_n is '0' (_n = negative logic, On = '0'), the counter resets to zero "0000"
-- initial_value is a 4-bit signal that contains an initial value to be loaded into the counter (std_logic_vector)
-- load_n (negative logic) loads the initial_value input signal into the counter
-- counter_output is the 4-bit counter output (std_logic_vector)


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter is
	Port (  enable 		: in STD_LOGIC;
		initial_value 	: in STD_LOGIC_VECTOR(3 downto 0);
		clear_n 	: in STD_LOGIC;
		clock		: in STD_LOGIC;
		load_n		: in STD_LOGIC;
		counter_output  : out STD_LOGIC_VECTOR(3 downto 0));
end counter;

architecture Behavioral of counter is

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

