library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity toplevel is
    Port ( segments : out STD_LOGIC_VECTOR(0 to 6);
           anodes : out STD_LOGIC_VECTOR(0 to 3);
           initial_value : in STD_LOGIC_VECTOR(0 to 3);
           enable : in STD_LOGIC;
           load : in STD_LOGIC;
           clear : in STD_LOGIC;
           clk : in STD_LOGIC);
end toplevel;

architecture Behavorial of toplevel is

component clock_divider is
    Port ( clk : in STD_LOGIC;
           message_clk : out STD_LOGIC);
end component clock_divider;

component counter is
  Port ( enable : in STD_LOGIC;
         initial_value : in STD_LOGIC_vector(3 downto 0);
         clear_n : in STD_LOGIC;
         clock : in STD_LOGIC;
         load_n : in STD_LOGIC;
         counter_output : out STD_LOGIC_vector(3 downto 0));
end component counter;

component display_driver_1 is
    Port ( inputs : in  STD_LOGIC_VECTOR (3 downto 0);
           seg_out : out  STD_LOGIC_VECTOR (6 downto 0));
end component display_driver_1;

component display_driver_2 is
    Port ( inputs : in  STD_LOGIC_VECTOR (3 downto 0);
           seg_out : out  STD_LOGIC_VECTOR (6 downto 0));
end component display_driver_2;

component display_driver_3 is
    Port ( inputs : in  STD_LOGIC_VECTOR (3 downto 0);
           seg_out : out  STD_LOGIC_VECTOR (6 downto 0));
end component display_driver_3;

component display_driver_4 is
    Port ( inputs : in  STD_LOGIC_VECTOR (3 downto 0);
           seg_out : out  STD_LOGIC_VECTOR (6 downto 0));
end component display_driver_4;

component LEDdisplay is
    Port ( clk : in STD_LOGIC;
           seg0, seg1, seg2, seg3: in STD_LOGIC_VECTOR(6 downto 0);
           seg : out STD_LOGIC_VECTOR(6 downto 0);
           an : out STD_LOGIC_VECTOR(3 downto 0));
end component LEDdisplay;

signal cnt_output : STD_LOGIC_VECTOR(3 downto 0);
signal m_clk : STD_LOGIC;
signal sig_segments1, sig_segments2, sig_segments3, sig_segments4 : STD_LOGIC_VECTOR(6 downto 0);

begin

clock_divider_0 : clock_divider port map (clk => clk, message_clk => m_clk);
counter_0 : counter port map (enable => '1', load_n => load, initial_value => initial_value, clear_n => clear, clock => m_clk, counter_output => cnt_output);
display_driver_1_1 : display_driver_1 port map (inputs => cnt_output, seg_out => sig_segments1);
display_driver_2_2 : display_driver_2 port map (inputs => cnt_output, seg_out => sig_segments2);
display_driver_3_3 : display_driver_3 port map (inputs => cnt_output, seg_out => sig_segments3);
display_driver_4_4 : display_driver_4 port map (inputs => cnt_output, seg_out => sig_segments4);
LEDdisplay_0 : LEDdisplay port map (seg1 => sig_segments2, seg2 => sig_segments3, seg3 => sig_segments4, seg0 => sig_segments1, clk => clk, seg => segments,an => anodes );


end;m358b583@cycle2:~/Documents/EECS140-Lab/lab10/lab10.srcs/sources_1/new$ cat toplevel.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity toplevel is
    Port ( segments : out STD_LOGIC_VECTOR(0 to 6);
           anodes : out STD_LOGIC_VECTOR(0 to 3);
           initial_value : in STD_LOGIC_VECTOR(0 to 3);
           enable : in STD_LOGIC;
           load : in STD_LOGIC;
           clear : in STD_LOGIC;
           clk : in STD_LOGIC);
end toplevel;

architecture Behavorial of toplevel is

component clock_divider is
    Port ( clk : in STD_LOGIC;
           message_clk : out STD_LOGIC);
end component clock_divider;

component counter is
  Port ( enable : in STD_LOGIC;
         initial_value : in STD_LOGIC_vector(3 downto 0);
         clear_n : in STD_LOGIC;
         clock : in STD_LOGIC;
         load_n : in STD_LOGIC;
         counter_output : out STD_LOGIC_vector(3 downto 0));
end component counter;

component display_driver_1 is
    Port ( inputs : in  STD_LOGIC_VECTOR (3 downto 0);
           seg_out : out  STD_LOGIC_VECTOR (6 downto 0));
end component display_driver_1;

component display_driver_2 is
    Port ( inputs : in  STD_LOGIC_VECTOR (3 downto 0);
           seg_out : out  STD_LOGIC_VECTOR (6 downto 0));
end component display_driver_2;

component display_driver_3 is
    Port ( inputs : in  STD_LOGIC_VECTOR (3 downto 0);
           seg_out : out  STD_LOGIC_VECTOR (6 downto 0));
end component display_driver_3;

component display_driver_4 is
    Port ( inputs : in  STD_LOGIC_VECTOR (3 downto 0);
           seg_out : out  STD_LOGIC_VECTOR (6 downto 0));
end component display_driver_4;

component LEDdisplay is
    Port ( clk : in STD_LOGIC;
           seg0, seg1, seg2, seg3: in STD_LOGIC_VECTOR(6 downto 0);
           seg : out STD_LOGIC_VECTOR(6 downto 0);
           an : out STD_LOGIC_VECTOR(3 downto 0));
end component LEDdisplay;

signal cnt_output : STD_LOGIC_VECTOR(3 downto 0);
signal m_clk : STD_LOGIC;
signal sig_segments1, sig_segments2, sig_segments3, sig_segments4 : STD_LOGIC_VECTOR(6 downto 0);

begin

clock_divider_0 : clock_divider port map (clk => clk, message_clk => m_clk);
counter_0 : counter port map (enable => '1', load_n => load, initial_value => initial_value, clear_n => clear, clock => m_clk, counter_output => cnt_output);
display_driver_1_1 : display_driver_1 port map (inputs => cnt_output, seg_out => sig_segments1);
display_driver_2_2 : display_driver_2 port map (inputs => cnt_output, seg_out => sig_segments2);
display_driver_3_3 : display_driver_3 port map (inputs => cnt_output, seg_out => sig_segments3);
display_driver_4_4 : display_driver_4 port map (inputs => cnt_output, seg_out => sig_segments4);
LEDdisplay_0 : LEDdisplay port map (seg1 => sig_segments2, seg2 => sig_segments3, seg3 => sig_segments4, seg0 => sig_segments1, clk => clk, seg => segments,an => anodes );

end;
