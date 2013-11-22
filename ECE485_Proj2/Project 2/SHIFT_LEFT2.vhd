library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SHIFT_LEFT2 is
   port ( FEED: in std_logic_vector(31 downto 0);
		      RESULT: out std_logic_vector(31 downto 0));
end entity SHIFT_LEFT2;

architecture behave of SHIFT_LEFT2 is 
  begin
    RESULT <= FEED(29 downto 0) & "00";     
end architecture behave;