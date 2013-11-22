--MUX for 4 input 32 bit numbers
--TESTBENCH
library ieee;
use ieee.std_logic_1164.all;

entity Mux3Test is
end entity;

architecture behavior of Mux3Test is

COMPONENT Mux4 is
	port (ZERO: in std_logic_vector(31 downto 0);
		  ONE: in std_logic_vector(31 downto 0);
		  TWO: in std_logic_vector(31 downto 0);
		  THREE: in std_logic_vector(31 downto 0);
		  CTRL: in std_logic_vector(1 downto 0);
		  OUTPUT: out std_logic_vector(31 downto 0));
end COMPONENT;


signal TEST_ZERO: std_logic_vector(31 downto 0);
signal TEST_ONE: std_logic_vector(31 downto 0);
signal TEST_TWO: std_logic_vector(31 downto 0);
signal TEST_THREE: std_logic_vector(31 downto 0);
signal TEST_CTRL: std_logic_vector(1 downto 0);


signal TEST_OUTPUT: std_logic_vector(31 downto 0);

begin

	MUX4TESTING: Mux4 PORT MAP (
			ZERO => TEST_ZERO,
			ONE => TEST_ONE,
			TWO => TEST_TWO,
			THREE => TEST_THREE,
			CTRL => TEST_CTRL,
			OUTPUT => TEST_OUTPUT);

	ZEROG: process
	begin
		TEST_ZERO <= x"40000000" after 0 ns,
				   x"FFFFFFFF" after 30 ns;
		wait;
	end process ZEROG;
	
	ONEG: process
	begin
		TEST_ONE <= x"80000000" after 0 ns,
				  x"FFFFFFFF" after 30 ns;
		wait;
	end process ONEG;
	
	TWOG: process
	begin
		TEST_TWO <= x"A0000000" after 0 ns,
				  x"FFFFFFFF" after 30 ns;
		wait;
	end process TWOG;
	
		THREEG: process
	begin
		TEST_THREE <= x"A0000000" after 0 ns,
				  x"FFFFFFFF" after 30 ns;
		wait;
	end process THREEG;
	CTRLG: process
	begin
		TEST_CTRL <= "10" after 0 ns,
			       "11" after 5 ns,
				   "01" after 10 ns;
		wait;
	end process CTRLG;
end architecture behavior;

		

