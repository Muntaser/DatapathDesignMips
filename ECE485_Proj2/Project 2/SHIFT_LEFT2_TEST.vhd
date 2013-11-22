library ieee;
use ieee.std_logic_1164.all;

entity SHIFT_LEFT2_TEST is
end entity;

architecture behave of SHIFT_LEFT2_TEST  is

--declaration of the Behaviral Encoder
COMPONENT SHIFT_LEFT2 is
port (FEED: in std_logic_vector(31 downto 0);
		  RESULT: out std_logic_vector(31 downto 0));
end COMPONENT;

--Declaration of test signals
signal SIGINPUT: std_logic_vector(31 downto 0);
signal SIGOUTPUT: std_logic_vector(31 downto 0);	
begin
	SUB: SHIFT_LEFT2 PORT MAP (
			FEED => SIGINPUT,
			RESULT => SIGOUTPUT);
			
	process
	begin 
		SIGINPUT <= X"00000001" after 0 ns,
				 X"00000002" after 10 ns,
				 X"00000004" after 20 ns;
	wait;
	end process;
end architecture behave;	

