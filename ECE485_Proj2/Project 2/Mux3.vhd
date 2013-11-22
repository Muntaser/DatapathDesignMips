--MUX for 3 input 32 bit numbers
--Muntaser Khan
library ieee;
use ieee.std_logic_1164.all;

entity Mux3 is
	port (ZERO: in std_logic_vector(31 downto 0);
		  ONE: in std_logic_vector(31 downto 0);
		  TWO: in std_logic_vector(31 downto 0);
		  CONTROL: in std_logic_vector(5 downto 0);
		  OUTPUT: out std_logic_vector(31 downto 0));
end entity Mux3;

architecture behavior of Mux3 is
begin
	OUTPUT <= TWO when CONTROL = "000000" else		--Shamt 
			  ONE when CONTROL = "110000" else		--Load Upper Immediate
			  ZERO;								--Else Zero(RD1(Rs Data)
end architecture behavior;

		
