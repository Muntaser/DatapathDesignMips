
--MUX FOR 2-input 5-bit Information
--Muntaser Khan
library ieee;
use ieee.std_logic_1164.all;

entity Mux2 is
	port (ZERO: in std_logic_vector(4 downto 0);
		  ONE: in std_logic_vector(4 downto 0);
		  CTRL: in std_logic_vector(5 downto 0);
		  OUTPUT: out std_logic_vector(4 downto 0));
end entity Mux2;

architecture behavior of Mux2 is
begin
	OUTPUT <= ONE when CTRL = "000000" else	--select R-TYPE,  Rt
			  ZERO; 	--select I-TYPE, Rd			  
end architecture behavior;

		