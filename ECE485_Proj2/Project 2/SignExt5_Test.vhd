--Takes a 5-bit number and sign extends it to a 32-bit number
--TESTBENCH
library ieee;
use ieee.std_logic_1164.all;

entity SignExt5_Test is
end entity;

architecture behavior of SignExt5_Test is

COMPONENT SignExt5 is
	port (INPUT: in std_logic_vector(4 downto 0);
		  OUTPUT: out std_logic_vector(31 downto 0));
end COMPONENT;

--Declaration of test signal Inputs
signal TEST_INPUT: std_logic_vector(4 downto 0);

--Declaration of test signal Outputs
signal TEST_OUTPUT: std_logic_vector(31 downto 0);

begin

	uut: SignExt5 PORT MAP (
			INPUT => TEST_INPUT,
			OUTPUT => TEST_OUTPUT);

	INPUTG: process
	begin
		TEST_INPUT <= "01110" after 0 ns,
				    "01000" after 10 ns;
		wait;
	end process INPUTG;
end architecture behavior;

		
