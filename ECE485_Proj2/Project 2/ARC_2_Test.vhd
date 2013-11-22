
--Combination of Instruction Memory and Instruction Decode
--TESTBENCH
library ieee;
use ieee.std_logic_1164.all;

entity ARC_2_Test is
end entity;

architecture behave of ARC_2_Test  is

--declaration of the Behaviral Encoder
COMPONENT ARC_2 is
	port (PC_A: in std_logic_vector(31 downto 0);
			RS_A: out std_logic_vector(4 downto 0);		--5-bit RS output
			RT_A: out std_logic_vector(4 downto 0);		--5-bit RT output
			RD_A: out std_logic_vector(4 downto 0);		--5-bit RD output(R-Type only)
			IMM_A: out std_logic_vector(15 downto 0);		--5-bit IMM output(I-Type only)
			SHMT_A: out std_logic_vector(10 downto 6);	--5-bit Shift Amount (R-Type only)
			FUNCT_A: out std_logic_vector(5 downto 0);	--6-bit Function Code (R-Type only)
			TYPE_A: out std_logic_vector(1 downto 0));	--2-bit output to determine type: 00:R-Type, 01:J-Type, 10:I-Type, 11: error
end COMPONENT;

--Declaration of test signal Inputs
signal TB_aPC: std_logic_vector(31 downto 0);								

--Declaration of test signal Outputs
signal TB_aRS: std_logic_vector(4 downto 0);		--5-bit RS output
signal TB_aRT: std_logic_vector(4 downto 0);		--5-bit RT output
signal TB_aRD: std_logic_vector(4 downto 0);		--5-bit RD output(R-Type only)
signal TB_aIMM: std_logic_vector(15 downto 0);		--5-bit IMM output(I-Type only)
signal TB_aSHMT: std_logic_vector(10 downto 6);	--5-bit Shift Amount (R-Type only)
signal TB_aFUNCT: std_logic_vector(5 downto 0);	--6-bit Function Code (R-Type only)
signal TB_aX_TYPE: std_logic_vector(1 downto 0);	--2-bit output to determine type: 00:R-Type, 01:J-Type, 10:I-Type, 11: error
begin
	Combination: ARC_2 PORT MAP (
			PC_a => TB_aPC,
			RS_a => TB_aRS,
			RT_a => TB_aRT,
			RD_a => TB_aRD,
			IMM_a => TB_aIMM,
			SHMT_a => TB_aSHMT, 
 			FUNCT_a => TB_aFUNCT, 
			TYPE_A => TB_aX_TYPE);			
			
	PC_GEN: process
	begin 
		TB_aPC <= x"00000400" after 0 ns,	--lw
				 x"00000404" after 10 ns,	--sw
				 x"00000408" after 20 ns,	--add
				 x"0000040C" after 40 ns,	--BEQ
				 x"00000410" after 60 ns,	--SUBI	
				 x"00000414" after 80 ns;	--ori
				
	wait;
	end process PC_GEN;
end architecture behave;	
