
--Register_Data
--Input: Rs, Rt, Rd, Write Data
--Controls
--Outpus: Read Data 1, Read Data 2

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DRegister is
   port (RR1: in std_logic_vector(4 downto 0);		--5-bit Read Reg. 1
		 RR2: in std_logic_vector(4 downto 0);		--5-bit Read Reg. 2 
		 WR: in std_logic_vector(4 downto 0);		--5-bit Write Register
		 WD: in std_logic_vector(31 downto 0);		--32-bit Write Data
		 Control: in std_logic_vector(5 downto 0);	--6-bit Opcode/Function
		 RD1: out std_logic_vector(31 downto 0); 	--32-bit output1
		 RD2: out std_logic_vector(31 downto 0); 	--32-bit output2
		 CTRL_OUT: out std_logic_vector(5 downto 0));--Control Output to pass through the control values for alu operation
end entity DRegister;

architecture behavioral of DRegister is 

constant C_REGN_0: std_logic_vector(31 downto 0) := x"00000000";
constant C_REGN_8: std_logic_vector(31 downto 0) := x"00000080";
constant C_REGN_9: std_logic_vector(31 downto 0) := x"00000090";
constant C_REGN_10: std_logic_vector(31 downto 0) := x"00000100";
constant C_REGN_11: std_logic_vector(31 downto 0) := x"00000110";
constant C_REGN_12: std_logic_vector(31 downto 0) := x"00000120";
constant C_REGN_13: std_logic_vector(31 downto 0) := x"00000130";	
constant C_REGN_14: std_logic_vector(31 downto 0) := x"00000140";
constant C_REGN_15: std_logic_vector(31 downto 0) := x"00000150";
constant C_REGN_16: std_logic_vector(31 downto 0) := x"00000160";
constant C_REGN_17: std_logic_vector(31 downto 0) := x"00000170";    
constant C_REGN_18: std_logic_vector(31 downto 0) := x"00000180";
constant C_REGN_19: std_logic_vector(31 downto 0) := x"00000190";
constant C_REGN_20: std_logic_vector(31 downto 0) := x"00000200";
constant C_REGN_21: std_logic_vector(31 downto 0) := x"00000210";
constant C_REGN_22: std_logic_vector(31 downto 0) := x"00000220";
constant C_REGN_23: std_logic_vector(31 downto 0) := x"00000230";
constant C_REGN_24: std_logic_vector(31 downto 0) := x"00000240";
constant C_REGN_25: std_logic_vector(31 downto 0) := x"00000250";


--Changing Vectors
signal REGN_8: std_logic_vector(31 downto 0) := x"00000080";
signal REGN_9: std_logic_vector(31 downto 0) := x"00000090";
signal REGN_10: std_logic_vector(31 downto 0) := x"00000100";
signal REGN_11: std_logic_vector(31 downto 0) := x"00000110";
signal REGN_12: std_logic_vector(31 downto 0) := x"00000120";
signal REGN_13: std_logic_vector(31 downto 0) := x"00000130";
signal REGN_14: std_logic_vector(31 downto 0) := x"00000140";
signal REGN_15: std_logic_vector(31 downto 0) := x"00000150";
signal REGN_16: std_logic_vector(31 downto 0) := x"00000160";
signal REGN_17: std_logic_vector(31 downto 0) := x"00000170";    
signal REGN_18: std_logic_vector(31 downto 0) := x"00000180";
signal REGN_19: std_logic_vector(31 downto 0) := x"00000190";
signal REGN_20: std_logic_vector(31 downto 0) := x"00000200";
signal REGN_21: std_logic_vector(31 downto 0) := x"00000210";
signal REGN_22: std_logic_vector(31 downto 0) := x"00000220";
signal REGN_23: std_logic_vector(31 downto 0) := x"00000230";
signal REGN_24: std_logic_vector(31 downto 0) := x"00000240";
signal REGN_25: std_logic_vector(31 downto 0) := x"00000250";

signal Write_Control: std_logic := '0';

begin 
		
	--Read Operation
	RD1 <= C_REGN_8 when (RR1 =  "01000") else
	       C_REGN_9 when (RR1 =  "01001") else
	       C_REGN_10 when (RR1 = "01010") else
	       C_REGN_11 when (RR1 = "01011") else
	       C_REGN_12 when (RR1 = "01100") else
	       C_REGN_13 when (RR1 = "01101") else
	       C_REGN_14 when (RR1 = "01110") else
	       C_REGN_15 when (RR1 = "01111") else
	       C_REGN_16 when (RR1 = "10000") else
	       C_REGN_17 when (RR1 = "10001") else
	       C_REGN_18 when (RR1 = "10010") else
	       C_REGN_19 when (RR1 = "10011") else
	       C_REGN_20 when (RR1 = "10100") else
	       C_REGN_21 when (RR1 = "10101") else
	       C_REGN_22 when (RR1 = "10110") else
	       C_REGN_23 when (RR1 = "10111") else
	       C_REGN_24 when (RR1 = "11000") else
	       C_REGN_25 when (RR1 = "11001") else			
	       x"FFFFFFFF";
	
	RD2 <= C_REGN_8 when (RR2 = "01000") else
	       C_REGN_9 when (RR2 = "01001") else
	       C_REGN_10 when (RR2 = "01010") else
	       C_REGN_11 when (RR2 = "01011") else
	       C_REGN_12 when (RR2 = "01100") else
	       C_REGN_13 when (RR2 = "01101") else
	       C_REGN_14 when (RR2 = "01110") else
	       C_REGN_15 when (RR2 = "01111") else
	       C_REGN_16 when (RR2 = "10000") else
	       C_REGN_17 when (RR2 = "10001") else
	       C_REGN_18 when (RR2 = "10010") else
	       C_REGN_19 when (RR2 = "10011") else
	       C_REGN_20 when (RR2 = "10100") else
	       C_REGN_21 when (RR2 = "10101") else
	       C_REGN_22 when (RR2 = "10110") else
	       C_REGN_23 when (RR2 = "10111") else
	       C_REGN_24 when (RR2 = "11000") else
	       C_REGN_25 when (RR2 = "11001") else			
	       x"FFFFFFFF";
	
	Write_Control <= '1' when (Control = "100011" or Control = "100000" or Control = "100101" or Control = "101010" or Control = "001101" or Control = "000010" or Control = "001111") else
					 '0';
	
	--Write Operations
	REGN_8 <= WD when (WR = "01000" and Write_Control = '1');
	REGN_9 <= WD when (WR = "01001" and Write_Control = '1');
	REGN_10 <= WD when (WR = "01010" and Write_Control = '1');
	REGN_11 <= WD when (WR = "01011" and Write_Control = '1');
	REGN_12 <= WD when (WR = "01100" and Write_Control = '1');
	REGN_13 <= WD when (WR = "01101" and Write_Control = '1');
	REGN_14 <= WD when (WR = "01110" and Write_Control = '1');
	REGN_15 <= WD when (WR = "01111" and Write_Control = '1');
	REGN_16 <= WD when (WR = "10000" and Write_Control = '1');
	REGN_17 <= WD when (WR = "10001" and Write_Control = '1');
	REGN_18 <= WD when (WR = "10010" and Write_Control = '1');
	REGN_19 <= WD when (WR = "10011" and Write_Control = '1');
	REGN_20 <= WD when (WR = "10100" and Write_Control = '1');
	REGN_21 <= WD when (WR = "10101" and Write_Control = '1');
	REGN_22 <= WD when (WR = "10110" and Write_Control = '1');
	REGN_23 <= WD when (WR = "10111" and Write_Control = '1');
	REGN_24 <= WD when (WR = "11000" and Write_Control = '1');
	REGN_25 <= WD when (WR = "11001" and Write_Control = '1');
	
	
	CTRL_OUT <= Control;
	
end architecture behavioral;
