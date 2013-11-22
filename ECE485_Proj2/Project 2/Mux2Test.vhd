--MUX FOR 2-input 5-bit Information
--TESTBENCH
library ieee;
use ieee.std_logic_1164.all;

entity Mux2Test is
end entity;

architecture behavior of Mux2Test is

COMPONENT Mux2 is
	port (ZERO: in std_logic_vector(4 downto 0);
		  ONE: in std_logic_vector(4 downto 0);
		  CTRL: in std_logic_vector(5 downto 0);
		  OUTPUT: out std_logic_vector(4 downto 0));
end COMPONENT;

--3 SIGNAL INPUTS
signal TEST_ZERO: std_logic_vector(4 downto 0);
signal TEST_ONE: std_logic_vector(4 downto 0);
signal TEST_CTRL: std_logic_vector(5 downto 0);

--Signal Output
signal TEST_OUTPUT: std_logic_vector(4 downto 0);

begin

	MUX2TESTING: Mux2 PORT MAP (
			ZERO => TEST_ZERO,
			ONE => TEST_ONE,
			CTRL => TEST_CTRL,
			OUTPUT => TEST_OUTPUT);

	ZEROG: process
	begin
		TEST_ZERO <= "10101" after 0 ns,
				   "11111" after 40 ns;
		wait;
	end process ZEROG;
	
	ONEG: process
	begin
		TEST_ONE <= "00001" after 0 ns,
				  "11111" after 40 ns;
		wait;
	end process ONEG;
	
	CTRLG: process
	begin
		TEST_CTRL <= "000000" after 0 ns,
			       "010000" after 10 ns,
				   "000000" after 20 ns,
				   "010000" after 30 ns,
				   "110000" after 40 ns;
		wait;
	end process CTRLG;
end architecture behavior;

		
