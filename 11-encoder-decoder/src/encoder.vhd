library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Encoder is
	Port ( x : in STD_LOGIC_VECTOR(0 to 7);
	       y : out STD_LOGIC_VECTOR(0 to 2));

end Encoder;

architecture Behavioral of Encoder is

begin

	y(0) <= x(4) or x(5) or x(6) or x(7);
	y(1) <= x(2) or x(3) or x(6) or x(7);
	y(2) <= x(1) or x(3) or x(5) or x(7);

end Behavioral;

