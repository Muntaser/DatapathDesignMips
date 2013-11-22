
library ieee;
use ieee.std_logic_1164.all;

entity MuxIn32 is
	port (ZERO: in std_logic_vector(31 downto 0);
		  ONE: in std_logic_vector(31 downto 0);
		 CTRL: in std_logic_vector(5 downto 0);
		  OUTPUT: out std_logic_vector(31 downto 0));
end entity MuxIn32;

architecture behavior of MuxIn32 is
begin
	OUTPUT <= ONE when (CTRL = "000000" or CTRL = "010000" or CTRL = "10") else		--I-TYPE, Outputs IMM
			  ZERO;
end architecture behavior;