
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_Shift_Testbench is
--  Port ( );
end ALU_Shift_Testbench;

architecture main of ALU_Shift_Testbench is

	component ALU_Shift is
    Port ( 
        A : 		in STD_LOGIC_VECTOR (31 downto 0);
        ALUOp: 		in STD_LOGIC_VECTOR (1 downto 0);
        SHAMT: 		in STD_LOGIC_VECTOR (4 downto 0);
        ShiftR: 	out STD_LOGIC_VECTOR (31 downto 0)
    );
	end component;

	signal A_iter:		STD_LOGIC_VECTOR (31 downto 0);
	signal ALUOp_iter:  STD_LOGIC_VECTOR (1 downto 0);
	signal SHAMT_iter:	STD_LOGIC_VECTOR (4 downto 0);
	signal ShiftRProduced_iter:	STD_LOGIC_VECTOR (31 downto 0);
	signal ShiftRExcepted_sll_iter:	STD_LOGIC_VECTOR (31 downto 0);
	signal ShiftRExcepted_srl_iter:	STD_LOGIC_VECTOR (31 downto 0);
	signal ShiftRExcepted_sra_iter:	STD_LOGIC_VECTOR (31 downto 0);

begin
	UUT: ALU_Shift port map(A_iter,ALUOp_iter,SHAMT_iter,ShiftRProduced_iter);
	testBenches: process
	constant waitTime: time := 30 ns;
	begin
--------------------------------------------------------------------------1
			A_iter 					<= 	X"FEDCBA98"	;	
			SHAMT_iter 				<= 	"00000"		;
			ShiftRExcepted_sll_iter	<= 	X"FEDCBA98"	;	
			ShiftRExcepted_srl_iter	<= 	X"FEDCBA98"	;	
			ShiftRExcepted_sra_iter	<= 	X"FEDCBA98"	;	
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 1" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 1" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 1" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------2
			A_iter 					<= 	X"FEDCBA98"	;	
			SHAMT_iter 				<= 	"00001"		;
			ShiftRExcepted_sll_iter	<= 	X"FDB97530"	;	
			ShiftRExcepted_srl_iter	<= 	X"7F6E5D4C" ;	
			ShiftRExcepted_sra_iter	<= 	X"FF6E5D4C"	;	
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 2" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 2" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 2" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------3
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	 "00010";	---INSERT HERE
			ShiftRExcepted_sll_iter	<=  X"FB72EA60"	;	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	 X"3FB72EA6";	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	 X"FFB72EA6" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 3" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 3" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 3" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------4
			A_iter 					<= X"FEDCBA98"	;	---INSERT HERE
			SHAMT_iter 				<= "00011";	---INSERT HERE
			ShiftRExcepted_sll_iter	<=  X"F6E5D4C0";	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	 X"1FDB9753";	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	 X"FFDB9753" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 4" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 4" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 4" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------5
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"00100";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	 X"EDCBA980";	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	 X"0FEDCBA9";	---INSERT HERE
			ShiftRExcepted_sra_iter	<=  X"FFEDCBA9" 	;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 5" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 5" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 5" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------6
			A_iter 					<= X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"00101";	---INSERT HERE
			ShiftRExcepted_sll_iter	<=   X"DB975300"	;	---INSERT HERE
			ShiftRExcepted_srl_iter	<=  X"07F6E5D4"	;	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	 X"FFF6E5D4" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 6" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 6" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 6" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------7
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"00110";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	 X"B72EA600";	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	X"03FB72EA" ;	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	 X"FFFB72EA" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 7" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 7" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 7" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------8
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"00111";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	 X"6E5D4C00" ;	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	X"01FDB975";	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	 X"FFFDB975" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 8" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 8" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 8" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------9
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"01000";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= X"DCBA9800" 	;	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	 X"00FEDCBA";	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	 X"FFFEDCBA" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 9" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 9" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 9" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------10
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"01001";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	 X"B9753000";	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	 X"007F6E5D" ;	---INSERT HERE
			ShiftRExcepted_sra_iter	<= X"FFFF6E5D" 	;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 10" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 10" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 10" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------11
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"01010";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	X"72EA6000";	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	 X"003FB72E";	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	  X"FFFFB72E" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 11" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 11" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 11" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------12
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"01011";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	X"E5D4C000";	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	  X"001FDB97";	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	 X"FFFFDB97" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 12" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 12" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 12" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------13
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"01100";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	X"CBA98000";	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	X"000FEDCB";	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	 X"FFFFEDCB" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 13" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 13" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 13" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------14
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"01101";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	 X"97530000";	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	 X"0007F6E5";	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	X"FFFFF6E5" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 14" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 14" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 14" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------15
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"01110";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	 X"2EA60000" ;	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	X"0003FB72";	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	 X"FFFFFB72" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 15" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 15" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 15" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------16
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"01111";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	X"5D4C0000";	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	 X"0001FDB9" ;	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	 X"FFFFFDB9" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 16" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 16" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 16" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------17
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"10000";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	X"BA980000";	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	X"0000FEDC";	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	X"FFFFFEDC" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 17" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 17" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 17" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------18
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"10001";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	 X"75300000" ;	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	X"00007F6E";	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	 X"FFFFFF6E" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 18" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 18" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 18" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------19
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"10010";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	X"EA600000" ;	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	X"00003FB7";	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	X"FFFFFFB7" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 19" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 19" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 19" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------20
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"10011";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	 X"D4C00000";	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	 X"00001FDB";	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	 X"FFFFFFDB" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 20" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 20" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 20" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------21
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"10100";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	X"A9800000";	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	 X"00000FED";	---INSERT HERE
			ShiftRExcepted_sra_iter	<=  X"FFFFFFED" 	;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 21" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 21" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 21" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------22
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"10101";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	 X"53000000";	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	 X"000007F6";	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	 X"FFFFFFF6" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 22" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 22" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 22" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------23
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"10110";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	 X"A6000000" ;	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	X"000003FB";	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	 X"FFFFFFFB" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 23" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 23" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 23" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------24
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"10111";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	 X"4C000000";	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	 X"000001FD";	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	 X"FFFFFFFD" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 24" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 24" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 24" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------25
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"11000";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	X"98000000";	---INSERT HERE
			ShiftRExcepted_srl_iter	<=  X"000000FE" 	;	---INSERT HERE
			ShiftRExcepted_sra_iter	<= X"FFFFFFFE" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 25" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 25" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 25" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------26
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"11001";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	 X"30000000";	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	 X"0000007F";	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	 X"FFFFFFFF" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 26" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 26" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 26" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------27
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"11010";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	 X"60000000";	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	 X"0000003F";	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	 X"FFFFFFFF" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 27" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 27" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 27" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------28
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"11011";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	 X"C0000000";	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	 X"0000001F";	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	 X"FFFFFFFF" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 28" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 28" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 28" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------29
			A_iter 					<= X"FEDCBA98"	;	---INSERT HERE
			SHAMT_iter 				<= 	"11100";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	X"80000000";	---INSERT HERE
			ShiftRExcepted_srl_iter	<=  X"0000000F"	;	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	 X"FFFFFFFF" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 29" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 29" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 29" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------30
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"11101";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	X"00000000";	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	X"00000007";	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	X"FFFFFFFF" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 30" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 30" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 30" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------31
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"11110";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	 X"00000000" ;	---INSERT HERE
			ShiftRExcepted_srl_iter	<= X"00000003";	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	 X"FFFFFFFF";	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 31" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 31" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 31" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------32
			A_iter 					<= 	X"FEDCBA98";	---INSERT HERE
			SHAMT_iter 				<= 	"11111";	---INSERT HERE
			ShiftRExcepted_sll_iter	<= 	X"00000000" ;	---INSERT HERE
			ShiftRExcepted_srl_iter	<= 	X"00000001";	---INSERT HERE
			ShiftRExcepted_sra_iter	<= 	 X"FFFFFFFF" ;	---INSERT HERE
			wait for waitTime;
			ALUOp_iter		<=	"00";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sll_iter) 
			report 	"sll err 32" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"10";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_srl_iter) 
			report 	"srl err 32" 			severity error;
			wait for waitTime;
			ALUOp_iter		<=	"11";
			wait for waitTime; assert (ShiftRProduced_iter = ShiftRExcepted_sra_iter) 
			report 	"sra err 32" 			severity error;
			wait for waitTime;
--------------------------------------------------------------------------
			wait;
	end process;
	
end main;
