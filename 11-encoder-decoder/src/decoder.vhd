library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Decoder is
	Port ( x : in STD_LOGIC_VECTOR (0 to 2);
	       y : out STD_LOGIC_VECTOR (0 to 7));
end Decoder;

architecture Behavioral of Decoder is

begin
	y(0) <= (not x(0)) and (not x(1)) and (not x(2));
	y(1) <= (    x(0)) and (not x(1)) and (not x(2));
	y(2) <= (not x(0)) and (    x(1)) and (not x(2));
	y(3) <= (    x(0)) and (    x(1)) and (    x(2));
	y(4) <= (not x(0)) and (not x(1)) and (    x(2));
	y(5) <= (    x(0)) and (not x(1)) and (    x(2));
	y(6) <= (not x(0)) and (    x(1)) and (    x(2));
	y(7) <= (    x(0)) and (    x(1)) and (    x(2));

end Behavioral;
