library ieee;
use ieee.std_logic_1164.all;

entity IM is
   port (PCIN: in std_logic_vector(31 downto 0); 	
	       IOUT: out std_logic_vector(31 downto 0));
end entity IM;

architecture behave of IM is 
begin 
	IOUT <= x"8E4B00C8" when PCIN = x"00001000" else	--lw
				  x"AD6C0064" when PCIN = x"00001004" else  --sw
					x"01524C10" when PCIN = x"00001008" else  --add
					x"12B2007D" when PCIN = x"0000100C" else  --beq
					x"35AE000A" when PCIN = x"00001010" else  --ori
					x"35AE000A" when PCIN = x"00001014" else  --subi
					x"FFFFFFFF";
end architecture behave;