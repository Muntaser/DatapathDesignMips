
--CalPC: takes in the PC value and control siganls
--to determine if the instruction needs to  branch, or GO TO NEXT INSTRUCTION
--return PC+4
--MUNTASER KHAN
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CalPC is
   port (PC_IN: in std_logic_vector(31 downto 0);   --32-bit PC INPUT
		IMM: in std_logic_vector(31 downto 0);		--32-bit Immidiate value
		Branch: in std_logic;						--Branch 1 BIT Control Signal from ALU
		Control: in std_logic_vector(5 downto 0);	--2 BIT Control signal from Instruction Mem
			
		PC_OUT: out std_logic_vector(31 downto 0)); --32-bit PC output
end entity CalPC;

architecture behave of CalPC is 

begin 
	
	PC_OUT <= std_logic_vector((unsigned(IMM) sll 2) + unsigned(PC_IN)) when (Branch = '1' and (Control = "00100" )) else	--For branch
			 	
			  std_logic_vector(unsigned(PC_IN) + 4); --PC+ 4 
			  
end architecture behave;
