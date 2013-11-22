--MUX FOR 2-input 32-bit Information for data mem or alu out
library ieee;
use ieee.std_logic_1164.all;

entity MuxIn32_1 is
	port (ZERO: in std_logic_vector(31 downto 0);
		  ONE: in std_logic_vector(31 downto 0);
		 CTRL: in std_logic_vector(2 downto 0);
		  OUTPUT: out std_logic_vector(31 downto 0));
end entity MuxIn32_1;

architecture behavior of MuxIn32_1 is
begin
	OUTPUT <= ZERO when (CTRL = "100") else		--Just reads from data for 
			  ONE;
end architecture behavior;

		
