library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_Shift is
    Port ( 
        A : 		in STD_LOGIC_VECTOR (31 downto 0);
        ALUOp: 		in STD_LOGIC_VECTOR (1 downto 0);
        SHAMT: 		in STD_LOGIC_VECTOR (4 downto 0);
        ShiftR: 	out STD_LOGIC_VECTOR (31 downto 0)
    );
end ALU_Shift;

architecture main of ALU_Shift is
    signal 			sll_0,sll_1,sll_2,sll_3,sll_4: 		STD_LOGIC_VECTOR (31 downto 0);
    signal 			srl_0,srl_1,srl_2,srl_3,srl_4: 		STD_LOGIC_VECTOR (31 downto 0);
    signal 			sra_0,sra_1,sra_2,sra_3,sra_4: 		STD_LOGIC_VECTOR (31 downto 0);
    signal			sra_m						 :		STD_LOGIC_VECTOR (31 downto 0);
    
begin
--Operations for Shift Left Logic:
	sll_0 <= A(30 downto 0) & '0' 						when SHAMT(0)='1' 		else A;
	sll_1 <= sll_0(29 downto 0) & "00" 					when SHAMT(1)='1' 		else sll_0;
	sll_2 <= sll_1(27 downto 0) & "0000"				when SHAMT(2)='1' 		else sll_1;
	sll_3 <= sll_2(23 downto 0) & "00000000"			when SHAMT(3)='1'		else sll_2;
	sll_4 <= sll_3(15 downto 0) & "0000000000000000"	when SHAMT(4)='1'		else sll_3;
--Operations for Shift Right Logic:
	srl_0 <= '0' 				& A	   (31 downto 1)   	when SHAMT(0)='1' 		else A;
	srl_1 <= "00" 				& srl_0(31 downto 2)  	when SHAMT(1)='1' 		else srl_0;
	srl_2 <= "0000" 			& srl_1(31 downto 4)  	when SHAMT(2)='1' 		else srl_1;
	srl_3 <= "00000000" 		& srl_2(31 downto 8)  	when SHAMT(3)='1'		else srl_2;
	srl_4 <= "0000000000000000" & srl_3(31 downto 16)  	when SHAMT(4)='1'		else srl_3;
--Operations for Shift Right Arithmatic:
	sra_m <= "00000000000000000000000000000000" 		when A(31)='0' 			else "11111111111111111111111111111111";
	sra_0 <= sra_m(0)			& A    (31 downto 1)   	when SHAMT(0)='1' 		else A;
	sra_1 <= sra_m(1 downto 0)	& sra_0(31 downto 2)  	when SHAMT(1)='1' 		else sra_0;
	sra_2 <= sra_m(3 downto 0)	& sra_1(31 downto 4)  	when SHAMT(2)='1' 		else sra_1;
	sra_3 <= sra_m(7 downto 0)	& sra_2(31 downto 8)  	when SHAMT(3)='1' 		else sra_2;
	sra_4 <= sra_m(15 downto 0)	& sra_3(31 downto 16)  	when SHAMT(4)='1' 		else sra_3;
--Operations for Multiplexing:
	ShiftR <= 	sra_4 when ALUOp = "11" else
				srl_4 when ALUOp = "10" else
				sll_4;
end main;
