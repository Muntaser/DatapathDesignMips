--Combination of Instruction Memory, Instruction Decode, 
--Register, and ALU and misc. MUX's and Sign extenders, Data Memory, and pc generation
--Final version of the Datapath of the 32-bit processor
library ieee;
use ieee.std_logic_1164.all;

entity DATAPATH is
	port (PCIN: in std_logic_vector(31 downto 0);
		    PCOUT: out std_logic_vector(31 downto 0);
		    DATAOUT: out std_logic_vector(31 downto 0));
end entity DATAPATH;
	
architecture behave of DATAPATH is

--Temp Signals used as connections between components
signal DFEED: std_logic_vector(31 downto 0);
signal DRS: std_logic_vector(4 downto 0);
signal DRT: std_logic_vector(4 downto 0);
signal DRD: std_logic_vector(4 downto 0);
signal DIMM: std_logic_vector(15 downto 0);
signal DSHMT: std_logic_vector(4 downto 0);
signal DFUNC: std_logic_vector(5 downto 0);
signal DTYPE: std_logic_vector(5 downto 0);
signal DM2OUT: std_logic_vector(4 downto 0);
signal DSE5OUT: std_logic_vector(31 downto 0);
signal DSE16OUT: std_logic_vector(31 downto 0);
signal DRD1: std_logic_vector(31 downto 0);
signal DRD2: std_logic_vector(31 downto 0);
signal DCTRLOUT: std_logic_vector(5 downto 0);
signal DADATA: std_logic_vector(31 downto 0);
signal DBDATA: std_logic_vector(31 downto 0);
signal DBRA: std_logic;
signal DFDATA: std_logic_vector(31 downto 0);
signal DMEMRD: std_logic_vector(31 downto 0);
signal DREGWRITE: std_logic_vector(31 downto 0);
signal DREGVALUE: std_logic_vector(31 downto 0);

component IM
	port (PCIN: in std_logic_vector(31 downto 0); 
			  IOUT: out std_logic_vector(31 downto 0)); 
end component;

component ID 
	port ( FEED: in std_logic_vector(31 downto 0);
          OPCODE: out std_logic_vector (5 downto 0); 
		      RS: out std_logic_vector(4 downto 0);
		      RT: out std_logic_vector(4 downto 0);
		      RD: out std_logic_vector(4 downto 0);
		      SHMT: out std_logic_vector(4 downto 0);
		      FUNC: out std_logic_vector(5 downto 0);
		      IMM: out std_logic_vector(15 downto 0));
end component;

component DRegister
	 port (RR1: in std_logic_vector(4 downto 0);		--5-bit Read Reg. 1
		 RR2: in std_logic_vector(4 downto 0);			--5-bit Read Reg. 2 
		 WR: in std_logic_vector(4 downto 0);			--5-bit Write Register
		 WD: in std_logic_vector(31 downto 0);			--32-bit Write Data
		 Control: in std_logic_vector(5 downto 0);		--6-bit Opcode/Function
		 RD1: out std_logic_vector(31 downto 0); 		--32-bit output1
		 RD2: out std_logic_vector(31 downto 0); 		--32-bit output2
		 CTRL_OUT: out std_logic_vector(5 downto 0));	--Control Output to pass through the control values for alu operation
end component;

component ALU
   port ( INPUT_1: in std_logic_vector(31 downto 0);
		      INPUT_2: in std_logic_vector(31 downto 0);
		      CONTROL: in std_logic_vector(5 downto 0);
		      B_OUT: out std_logic; 				
		      F_OUT: out std_logic_vector(31 downto 0));
end component;

component Data_Memory
   port (ADDR: in std_logic_vector(31 downto 0); 		--32-bit Address location
	     WD: in std_logic_vector(31 downto 0); 			--32-bit data
		 Control: in std_logic_vector(5 downto 0);  	--LW for Read SW for Write
		 RD: out std_logic_vector(31 downto 0));		--32-bit data at specific address, only going to output when lw
end component;

component Mux2
	port (ZERO: in std_logic_vector(4 downto 0);
		  ONE: in std_logic_vector(4 downto 0);
		  CTRL: in std_logic_vector(5 downto 0);
		  OUTPUT: out std_logic_vector(4 downto 0));
end component;

component MuxIn32										
	port (ZERO: in std_logic_vector(31 downto 0);
		  ONE: in std_logic_vector(31 downto 0);
		 CTRL: in std_logic_vector(5 downto 0);
		  OUTPUT: out std_logic_vector(31 downto 0));
end component;

--component Mux2_32_1										--Mux for Write Data 
	--port (ZERO: in std_logic_vector(31 downto 0);		--Zero Input for 32-bit mux
		 -- ONE: in std_logic_vector(31 downto 0);		--One Input for 32-bit mux
		  --CTRL: in std_logic_vector(5 downto 0);		--Control signal
		  --OUTPUT: out std_logic_vector(31 downto 0));	--32-bit output
-- end component;

component Mux3											--Mux for A_Data of ALU
	port (ZERO: in std_logic_vector(31 downto 0);
		  ONE: in std_logic_vector(31 downto 0);
		  TWO: in std_logic_vector(31 downto 0);
		  CONTROL: in std_logic_vector(5 downto 0);
		  OUTPUT: out std_logic_vector(31 downto 0));
end component;

--component Sign_Extend_5									--Takes 5 bit number and truncattes with 0
	--port (INPUT: in std_logic_vector(4 downto 0);		--5-bit Input
		 -- OUTPUT: out std_logic_vector(31 downto 0));	--32-bit ouput
--end component;

component SignExt
	port (INPUT: in std_logic_vector(15 downto 0);		
		    OUTPUT: out std_logic_vector(31 downto 0));
end component;

component CalPC
   port (PC_IN: in std_logic_vector(31 downto 0);   	--32-bit PC
		IMM: in std_logic_vector(31 downto 0);			--32-bit Immidiate value
		Branch: in std_logic;							--Branch Control Signal from ALU
		Control: in std_logic_vector(5 downto 0);		--Control signal from Instruction Mem
		PC_OUT: out std_logic_vector(31 downto 0)); 	--32-bit PC output
end component;

component DM
  port (ADDR: in std_logic_vector(31 downto 0); 	
	     WD: in std_logic_vector(31 downto 0); 		
		 Control: in std_logic_vector(5 downto 0);  
		 RD: out std_logic_vector(31 downto 0));
end component;	
begin

INSTRUCTION_MEM: IM port map(PCIN => DFEED, 
									IOUT => PCOUT);
									
Decode: ID port map(FEED => DFEED, 
									RS => DRS, 
									RT => DRT, 
									RD => DRD, 
									IMM => DIMM, 
									SHMT => DSHMT, 
									FUNC => DFUNC);
									
Rd_Select: Mux2 port map(ZERO => DRT, 
					   ONE => DRD, 
					   CTRL => DTYPE, 
					   OUTPUT => DM2OUT);
					   
Reg_Data: DRegister port map(RR1 => DRS, 
							   RR2 => DRT, 
							   WR => DM2OUT, 
						       WD => DREGVALUE, 	 
							   Control => DFUNC,
							   RD1 => DRD1, 
							   RD2 => DRD2,  
							   CTRL_OUT => DCTRLOUT);

--Shmt_Extend: Sign_Extend_5 port map(INPUT => TEMP_SHMT, 
							   --OUTPUT => TEMP_SE5OUT);	

Imm_Extend: SignExt port map(INPUT => DIMM,
								OUTPUT => DSE16OUT);
								

A_Data_Select: Mux3 port map(ZERO => DRD1,
					   ONE => DSE16OUT,
					   TWO => DSE5OUT,
					   CONTROL => DFUNC,
					   OUTPUT => DADATA);								
									
B_Data_Select: MuxIn32 port map(ZERO => dRD2,
						 ONE =>  dSE16OUT,
						 CTRL => DFUNC,
						 OUTPUT => DBDATA);
						 					   
ALU_OPERATION: ALU port map(INPUT_1 => DADATA,
							INPUT_2 => DBDATA,
							CONTROL => DFUNC,
							B_OUT => DBRA,
							F_OUT => DFDATA);
							
Data_Mem: DM port map(ADDR => DFDATA,
						      WD => DRD2,
							  Control => DFUNC,
							  RD => DMEMRD);
							
							
Write_DataMux: MuxIn32 port map(ZERO => DMEMRD,		
						   ONE => DFDATA,
						   CTRL => DFUNC,
						   OUTPUT => DREGVALUE);
						   
PC: CalPC port map(PC_IN =>DFEED,
						  IMM => DSE16OUT,
						  Branch => DBRA,
						  Control => DFUNC,
						  PC_OUT => PCOUT);
						  					  		  
	 DATAOUT <= DFDATA;
	 --aTEMP_TYPE <= TEMP_TYPE;
end architecture behave;	

