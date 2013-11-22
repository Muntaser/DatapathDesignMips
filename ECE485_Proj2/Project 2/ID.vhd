library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ID is
   port ( FEED: in std_logic_vector(31 downto 0);
          OPCODE: out std_logic_vector (5 downto 0); 
		      RS: out std_logic_vector(4 downto 0);
		      RT: out std_logic_vector(4 downto 0);
		      RD: out std_logic_vector(4 downto 0);
		      SHMT: out std_logic_vector(4 downto 0);
		      FUNC: out std_logic_vector(5 downto 0);
		      IMM: out std_logic_vector(15 downto 0));
end entity ID;

architecture behave of ID is 	
begin
	OPCODE <= FEED(31 downto 26);
	RS <= FEED(25 downto 21);
	RT <= FEED(20 downto 16);
	RD <= FEED(15 downto 11);
	SHMT <= FEED(10 downto 6);
	FUNC <= FEED(5 downto 0);
	
end architecture behave;

