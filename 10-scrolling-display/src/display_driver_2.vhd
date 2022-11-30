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
"1111110" when x"0" , -- "-"
"1111110" when x"1" , -- "-"
"1110001" when x"2" , -- "L"
"0000001" when x"3" , -- "O"
"1000001" when x"4" , -- "V"
"0110000" when x"5" , -- "E"
"1111110" when x"6" , -- "-"
"1111110" when x"7" , -- "-"
"1110001" when x"8" , -- "L"
"0000001" when x"9" , -- "O"
"1000001" when x"A" , -- "V"
"0110000" when x"B" , -- "E"
"1111110" when x"C" , -- "-"
"1111110" when x"D" , -- "-"
"1110001" when x"E" , -- "L"
"0000001" when others; -- "O"

end Behavioral;

/*
X ✓ X X
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

-  
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

 - = "1111110" = "abcdegf"
 L = "1110001" = "abcdefg"
 O = "0000001" = "abcdefg"
 V = "1000001" = "abcdefg"
 E = "0110000" = "abcdefg"
*/
