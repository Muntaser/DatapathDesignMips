library ieee;
use ieee.std_logic_1164.all;

entity ID_Test is
end entity;

architecture behave of ID_Test is
  
COMPONENT ID is
	 port ( FEED: in std_logic_vector(31 downto 0);
          OPCODE: out std_logic_vector (5 downto 0); 
		      RS: out std_logic_vector(4 downto 0);
		      RT: out std_logic_vector(4 downto 0);
		      RD: out std_logic_vector(4 downto 0);
		      SHMT: out std_logic_vector(4 downto 0);
		      FUNC: out std_logic_vector(5 downto 0);
		      IMM: out std_logic_vector(15 downto 0));
end COMPONENT;

--Declaration of test signal Inputs
signal SIGFEED: std_logic_vector(31 downto 0);								

--Declaration of test signal Outputs
signal SIGOPCODE: std_logic_vector(5 downto 0);		
signal SIGRS: std_logic_vector(4 downto 0);		
signal SIGRT: std_logic_vector(4 downto 0);		
signal SIGRD: std_logic_vector(4 downto 0);		
signal SIGSHMT: std_logic_vector(4 downto 0);	
signal SIGFUNC: std_logic_vector(5 downto 0);	
signal SIGIMM: std_logic_vector(15 downto 0);

begin
	SUB: ID PORT MAP (
			FEED => SIGFEED,
			OPCODE => SIGOPCODE,
			RS => SIGRS,
			RT => SIGRT,
			RD => SIGRD,
			SHMT => SIGSHMT,
			FUNC => SIGFUNC,
			IMM => SIGIMM);
	process
	begin
		SIGFEED <= 
				   x"8D530064" after 0 ns,
				   x"ADB400C8" after 10 ns,
				   x"01525820" after 20 ns,
				   x"02CD6825" after 30 ns,
				   x"022A702A" after 40 ns,
				   x"11B2003B" after 50 ns,
				   x"080002BC" after 60 ns,
				   x"15B20039" after 70 ns,
				   x"35CD000A" after 80 ns,
				   x"00097142" after 90 ns,
				   x"3C0B0028" after 100 ns,
				   x"FFFFFFFF" after 110 ns;
	wait;
	end process;
end architecture behave;	

