--PC Calculation
-- TESTBENCH
library ieee;
use ieee.std_logic_1164.all;

entity CalPC_Test is
end entity;

architecture behave of CalPC_Test is

--declaration of the Behaviral Encoder
COMPONENT CalPC is
	port (PC_IN: in std_logic_vector(31 downto 0);   --32-bit PC
		  IMM: in std_logic_vector(31 downto 0);		--32-bit Immidiate value
	 	  Branch: in std_logic;						--Branch Control Signal from ALU
		  Control: in std_logic_vector(2 downto 0);	--2 bit Control signal from Instruction Mem
		  
		  PC_OUT: out std_logic_vector(31 downto 0)); 	--32-bit PC output
end COMPONENT;

--Declaration of test signal Inputs
signal TEST_PC_IN: std_logic_vector(31 downto 0);
signal TEST_IMM: std_logic_vector(31 downto 0);
signal TEST_Branch: std_logic;
signal TEST_Control: std_logic_vector(2 downto 0);


--Declaration of test signal Outputs
signal TEST_PC_OUT: std_logic_vector(31 downto 0);

begin
	uut: CalPC PORT MAP (
			PC_IN => TEST_PC_IN,
			IMM => TEST_IMM,
			Branch => TEST_Branch,
			Control => TEST_Control,
			PC_OUT => TEST_PC_OUT);
			
	PC_G: process
	begin
		TEST_PC_IN <= x"00000400" after 0 ns,	--lw
				 x"00000404" after 10 ns,	--sw
				 x"00000408" after 20 ns,	--add
				 x"0000040C" after 40 ns,	--BEQ
				 x"00000410" after 60 ns,	--SUBI	
				 x"00000414" after 80 ns,	--ori
	     	 x"00000418" after 100 ns; 	--EMPTY
	wait;
	end process PC_G;
	
	IMM_G: process
	begin
		TEST_IMM <= x"00000001" after 0 ns,
				  x"0000004B" after 40 ns, -- BEQ for 2 cycles to test Branch Control
				  x"0000004B" after 60 ns, -- BEQ for 2 cycles to test Branch Control
			
				  x"00000001" after 80 ns, 
				  x"FFFFFFFF" after 100 ns; --END
	wait;
	end process IMM_G;
	
	Branch_G: process
	begin
		TEST_Branch <= '0' after 0 ns,
					 '1' after 40 ns,
					 '0' after 60 ns;
					 
	wait;
	end process Branch_G;
	
	ControlG: process
	begin
		TEST_Control <= "000" after 0 ns,
					  "001" after 40 ns, --BEQ 
					  "000" after 80 ns,	 
					  "111" after 100 ns;
	
	wait;
	end process ControlG;
	
end architecture behave;	

