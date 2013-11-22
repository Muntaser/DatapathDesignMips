--MUX for 4 input 32 bit numbers
--Muntaser Khan
library ieee;
use ieee.std_logic_1164.all;

entity Mux4 is
	port (ZERO: in std_logic_vector(31 downto 0);
		  ONE: in std_logic_vector(31 downto 0);
		  TWO: in std_logic_vector(31 downto 0);
		  THREE: in std_logic_vector(31 downto 0);
		  CONTROL: in std_logic_vector(1 downto 0);
		  OUTPUT: out std_logic_vector(31 downto 0));
end entity Mux4;

architecture behavior of Mux4 is
begin
	OUTPUT <= THREE when CONTROL = "11" else
	       TWO when CONTROL = "10" else		--Shamt 
			  ONE when CONTROL = "01" else		--Load Upper Immediate
			  ZERO;								--Else Zero(RD1(Rs Data)
end architecture behavior;
