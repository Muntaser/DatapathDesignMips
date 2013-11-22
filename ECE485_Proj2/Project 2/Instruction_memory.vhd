library ieee;
use ieee.std_logic_1164.all;

entity Instruction_Memory is
port (PC: in std_logic_vector(31 downto 0);  --32-bit instruction
INSTRUCTION: out std_logic_vector(31 downto 0)); --32-bit instruction(hardcodedin)
end entity Instruction_Memory;


