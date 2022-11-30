library ieee;
use ieee.std_logic_1164.all;
Library UNISIM;
use UNISIM.vcomponents.all;


ENTITY Mux4by7 IS
	-- No carry in or carry out for demonstration purposes
	PORT (
	--	clk: IN  STD_LOGIC;
        Input0       		: IN  STD_LOGIC_VECTOR(6 downto 0);
        Input1       		: IN  STD_LOGIC_VECTOR(6 downto 0);
        Input2       		: IN  STD_LOGIC_VECTOR(6 downto 0);
        Input3       		: IN  STD_LOGIC_VECTOR(6 downto 0);
        Control       		: IN  STD_LOGIC_VECTOR(1 downto 0);
        Output     		: OUT STD_LOGIC_VECTOR(6 downto 0)
	);
END Mux4by7;


ARCHITECTURE procedural of Mux4by7 IS
signal seg0,seg1 : std_logic_vector(6 downto 0);

BEGIN

dispMUX00: MUXF5 port map (seg0(0),Input0(0),Input1(0),Control(0));
dispMUX01: MUXF5 port map (seg1(0),Input2(0),Input3(0),Control(0));
dispMUX02: MUXF6 port map (Output(0),seg0(0),seg1(0),Control(1));

dispMUX10: MUXF5 port map (seg0(1),Input0(1),Input1(1),Control(0));
dispMUX11: MUXF5 port map (seg1(1),Input2(1),Input3(1),Control(0));
dispMUX12: MUXF6 port map (Output(1),seg0(1),seg1(1),Control(1));

dispMUX20: MUXF5 port map (seg0(2),Input0(2),Input1(2),Control(0));
dispMUX21: MUXF5 port map (seg1(2),Input2(2),Input3(2),Control(0));
dispMUX22: MUXF6 port map (Output(2),seg0(2),seg1(2),Control(1));

dispMUX30: MUXF5 port map (seg0(3),Input0(3),Input1(3),Control(0));
dispMUX31: MUXF5 port map (seg1(3),Input2(3),Input3(3),Control(0));
dispMUX32: MUXF6 port map (Output(3),seg0(3),seg1(3),Control(1));

dispMUX40: MUXF5 port map (seg0(4),Input0(4),Input1(4),Control(0));
dispMUX41: MUXF5 port map (seg1(4),Input2(4),Input3(4),Control(0));
dispMUX42: MUXF6 port map (Output(4),seg0(4),seg1(4),Control(1));

dispMUX50: MUXF5 port map (seg0(5),Input0(5),Input1(5),Control(0));
dispMUX51: MUXF5 port map (seg1(5),Input2(5),Input3(5),Control(0));
dispMUX52: MUXF6 port map (Output(5),seg0(5),seg1(5),Control(1));

dispMUX60: MUXF5 port map (seg0(6),Input0(6),Input1(6),Control(0));
dispMUX61: MUXF5 port map (seg1(6),Input2(6),Input3(6),Control(0));
dispMUX62: MUXF6 port map (Output(6),seg0(6),seg1(6),Control(1));

END procedural;




--top level LED display--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

Library UNISIM;
use UNISIM.vcomponents.all;

ENTITY LEDdisplay IS
	PORT (
		  clk					: IN  STD_LOGIC;
		  seg0,seg1,seg2,seg3		: IN  STD_LOGIC_VECTOR(6 downto 0);
        seg       		: OUT  STD_LOGIC_VECTOR(6  downto 0);
		  an					: OUT STD_LOGIC_VECTOR(3 downto 0));		  
END LEDdisplay;

ARCHITECTURE structural of LEDdisplay is

component Mux4by7 IS
	PORT (
        Input0       		: IN  STD_LOGIC_VECTOR(6 downto 0);
        Input1       		: IN  STD_LOGIC_VECTOR(6 downto 0);
        Input2       		: IN  STD_LOGIC_VECTOR(6 downto 0);
        Input3       		: IN  STD_LOGIC_VECTOR(6 downto 0);
        Control       		: IN  STD_LOGIC_VECTOR(1 downto 0);
        Output     		: OUT STD_LOGIC_VECTOR(6 downto 0)
	);
END component Mux4by7;

-- Enumerated Data Type for State
		TYPE STATE_TYPE IS (st00,st01,st10,st11);
		SIGNAL cur_state,next_state: STATE_TYPE;
		
signal control : std_logic_vector(1 downto 0) := "00";
signal Counter_Signal : std_logic_vector(15 downto 0);
signal downclk : std_logic;		

BEGIN

-- port mapping --
dispMUX00: Mux4by7 port map (seg0,seg1,seg2,seg3,control,seg);
--end port mapping --

-- next state logic --
next_state <= 	st01 when (cur_state = st00) else
					st10 when (cur_state = st01) else
					st11 when (cur_state = st10) else
					st00 when (cur_state = st11) else
					cur_state;
-- end next state logic --

-- internal signals --
an <= 	"1110" when (cur_state = st00) else
			"1101" when (cur_state = st01) else
			"1011" when (cur_state = st10) else
			"0111" when (cur_state = st11);
			
control <= 	"00" when (cur_state = st00) else
				"01" when (cur_state = st01) else
				"10" when (cur_state = st10) else
				"11" when (cur_state = st11);
			
downclk <= Counter_Signal(14);
--end internal signals --

-- state process --
process(downclk)
begin
	if rising_edge(downclk) then
		cur_state <= next_state;
	end if;
end process;
-- end state process --
			
-- clk down converter --
PROCESS (clk)
BEGIN				
	IF (clk'event and clk='1') THEN
				Counter_Signal <= Counter_Signal + 1; -- Counter updates every clock cycle @ 25Mhxz				
	END IF;
END PROCESS;
-- end clk down converter --
	

END structural;
