library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display_driver_1 is
    Port ( inputs : in  STD_LOGIC_VECTOR (3 downto 0);
           seg_out : out  STD_LOGIC_VECTOR (6 downto 0));
end display_driver_1;

architecture Behavioral of display_driver_1 is

begin
with inputs select

seg_out <=
"" when x"0" , -- "-"
"" when x"1" , -- "L"
"" when x"2" , -- "O"
"" when x"3" , -- "V"
"" when x"4" , -- "E"
"" when x"5" , -- "-"
"" when x"6" , -- "-"
"" when x"7" , -- "L"
"" when x"8" , -- "O"
"" when x"9" , -- "v"
"" when x"A" , -- "E"
"" when x"B" , -- "-"
"" when x"C" , -- "-"
"" when x"D" , -- "l"
"" when x"E" , -- "O"
"" when others; -- "V"

end Behavioral;

/*
X X ✓ X
- - - L		
- - L O
- L O V
L O V E
L V E -
V E - -
E - - L
- - L O
- L O V
L O V E
L V E -
V E - -
E - - L
- - L O
- L O V
L O V E

-----------------
-
L
O
V
E
_
_
L
O
V
E
_
_
L
O
V
-----------------

 - = "1111110" = "abcdegf"
 L = "1110001" = "abcdefg"
 O = "0000001" = "abcdefg"
 V = "1000001" = "abcdefg"
 E = "0110000" = "abcdefg"
*/
