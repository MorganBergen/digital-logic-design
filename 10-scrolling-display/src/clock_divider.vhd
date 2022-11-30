-- module name	clock_divider.vhd
-- engineer	morgan bergen
-- design date  tues nov 29 2022 	

-- description  
-- this component is responsible to take the on-board 450mHz clock input
-- and divide it so that the period of the resulting clock is about 1 sec
-- message_clk is the clock
-- this will control how fast or slow your message will scroll on the 4
-- 7-segment displays and you can test this component by hooking it up to
-- an LED to make sure it blinking at the correct rate.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clock_divider is
	Port (  clk		: in STD_LOGIC;
		message_clk	: out STD_LOGIC);
end clock_divider;

architecture Behavioral of clock_divider is

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
