----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 09/06/2022 04:26:38 PM
-- Design Name:
-- Module Name: bergen_lab2 - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bergen_lab2 is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C : in STD_LOGIC;
           Y : out STD_LOGIC);
end bergen_lab2;

architecture Behavioral of bergen_lab2 is

begin

Y <= ((NOT A) AND (NOT B)) OR ((B) AND (NOT C )) OR ((NOT B) AND (C));

end Behavioral;