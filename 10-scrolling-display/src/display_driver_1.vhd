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
"1111110" when x"0" ,
"1111110" when x"1" ,
"1111110" when x"2" ,
"1110001" when x"3" ,
"1110001" when x"4" ,
"1000001" when x"5" ,
"0110000" when x"6" ,
"1111110" when x"7" ,
"1111110" when x"8" ,
"1110001" when x"9" ,
"1110001" when x"A" ,
"1000001" when x"B" ,
"0110000" when x"C" ,
"1111110" when x"D" ,
"1111110" when x"E" ,
"1110001" when others;

end Behavioral;
