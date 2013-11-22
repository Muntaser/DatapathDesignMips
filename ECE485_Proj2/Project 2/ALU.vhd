library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
   port ( INPUT_1: in std_logic_vector(31 downto 0);
		      INPUT_2: in std_logic_vector(31 downto 0);
		      CONTROL: in std_logic_vector(5 downto 0);
		      B_OUT: out std_logic; 				
		      F_OUT: out std_logic_vector(31 downto 0));
end entity ALU;

architecture behave of ALU is 
begin
  F_OUT <=  std_logic_vector(unsigned(INPUT_1) + unsigned(INPUT_2)) when (CONTROL = "100011" & "000000" &  "101011")
            else
              std_logic_vector(unsigned(INPUT_1) - unsigned(INPUT_2)) when (CONTROL = "000100" & "111110")
            else 
              INPUT_1 OR INPUT_2 when (CONTROL = "001101") --orI
            --else
              --INPUT_1 AND INPUT_2 when (CONTROL = "011000") --and
            else
              x"FFFFFFFF";
              
  -- Assuming 1 for Branch and 0 for no branch            
  B_OUT <=  '1' when (CONTROL = "000100") else
            '0';            
end architecture behave;