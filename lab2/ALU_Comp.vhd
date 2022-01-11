library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_Comp is 
	port(
			A_31: IN STD_LOGIC;
			B_31: IN STD_LOGIC;
			S_31: IN STD_LOGIC;
			CO: IN STD_LOGIC;
			ALUOp: IN STD_LOGIC_VECTOR(1 downto 0);
			CompR: OUT STD_LOGIC_VECTOR(31 downto 0)
		);
end ALU_Comp;

architecture main of ALU_Comp is
	signal CompR_Pos: STD_LOGIC_VECTOR(31 downto 0) := X"00000001";
	signal CompR_Neg: STD_LOGIC_VECTOR(31 downto 0) := X"00000000";
	signal A,B,C,D,E,F,y : STD_LOGIC;
begin
	A<=ALUOp(1);	B<=ALUOp(0);	C<=A_31;
	D<=B_31;		E<=S_31;		F<=CO;
	y<= 		(A 		and B 		and (not F)				)
			or	(A 		and (not B) and (not D) and E		)
			or	(A 		and (not B) and C 		and (not D)	)
			or	(A 		and (not B) and C 		and E		);
	CompR <= CompR_Pos when y='1' else
			 CompR_Neg when y='0';



end main;
