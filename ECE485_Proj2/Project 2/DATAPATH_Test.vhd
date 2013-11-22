library ieee;
use ieee.std_logic_1164.all;

entity DATAPATH_Test is
end entity;

architecture behave of DATAPATH_Test  is


COMPONENT DATAPATH is
	port (PCIN: in std_logic_vector(31 downto 0);		--PC Input
		  PCOUT: out std_logic_vector(31 downto 0);
		  DATAOUT: out std_logic_vector(31 downto 0));
end COMPONENT;

--Declaration of test signal Inputs
signal TB_PC: std_logic_vector(31 downto 0);								
							

--Declaration of test signal Outputs
signal TB_PC_OUT: std_logic_vector(31 downto 0);		--1 bit Read data output
signal TB_F_DATA: std_logic_vector(31 downto 0);		--32 bit Read data Output
--signal TB_aTEMP_TYPE: std_logic_vector(1 downto 0);		--32 bit Read data Output



begin
	uut: DATAPATH PORT MAP (
			PCIN => TB_PC,
			PCOUT => TB_PC_OUT, 
			DATAOUT => TB_F_DATA);
			--aTEMP_TYPE => TB_aTEMP_TYPE);
			
			
	process
	begin 
		TB_PC <= x"00001000" after 0 ns,	--lw
				 x"00001004" after 10 ns,	--sw
				 x"00001008" after 20 ns,	--add
				 x"0000100C" after 30 ns,	--or
				 x"00001010" after 40 ns,	--slt
				 x"00001014" after 50 ns,	--beq
				 x"00000530" after 110 ns; 	--EMPTY
	wait;
	end process;
	

end architecture behave;	
