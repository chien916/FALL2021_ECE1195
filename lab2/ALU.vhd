library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
	Port(
			A: 			IN 	STD_LOGIC_VECTOR (31 downto 0);
			B: 			IN 	STD_LOGIC_VECTOR (31 downto 0);
			SHAMT: 		IN 	STD_LOGIC_VECTOR (4 downto 0);
			ALUOp: 		IN 	STD_LOGIC_VECTOR (3 downto 0);
			Zero: 		OUT STD_LOGIC;
			Overflow: 	OUT STD_LOGIC;
			R: 			OUT STD_LOGIC_VECTOR (31 downto 0)
		);
end ALU;

architecture main of ALU is

	component ALU_Logical is
	    Port ( 
		        A : in STD_LOGIC_VECTOR (31 downto 0);
		        B : in STD_LOGIC_VECTOR (31 downto 0);
		        ALUOp: in STD_LOGIC_VECTOR (1 downto 0);
		        LogicalR: out STD_LOGIC_VECTOR (31 downto 0)
	    );
	end component;

	component ALU_Arith IS
		GENERIC (
	     	n       : positive := 32
	     		);
	   	PORT( 
			    A       : IN     std_logic_vector (n-1 DOWNTO 0);
			    B       : IN     std_logic_vector (n-1 DOWNTO 0);
			    C_op    : IN     std_logic_vector (1 DOWNTO 0);
			    CO      : OUT    std_logic;
			    OFL     : OUT    std_logic;
			    S       : OUT    std_logic_vector (n-1 DOWNTO 0);
			    Z       : OUT    std_logic
	   	);
	end component ;

	component ALU_Comp is 
		port(
				A_31: IN STD_LOGIC;
				B_31: IN STD_LOGIC;
				S_31: IN STD_LOGIC;
				CO: IN STD_LOGIC;
				ALUOp: IN STD_LOGIC_VECTOR(1 downto 0);
				CompR: OUT STD_LOGIC_VECTOR(31 downto 0)
			);
	end component;

	component ALU_Shift is
	    Port ( 
		        A : 		in STD_LOGIC_VECTOR (31 downto 0);
		        ALUOp: 		in STD_LOGIC_VECTOR (1 downto 0);
		        SHAMT: 		in STD_LOGIC_VECTOR (4 downto 0);
		        ShiftR: 	out STD_LOGIC_VECTOR (31 downto 0)
	    );
	end component;

	component ALU_Mux is
		Port(
				LogicalR: 	in 	STD_LOGIC_VECTOR (31 downto 0);
				ArithR: 	in 	STD_LOGIC_VECTOR (31 downto 0);
				CompR: 		in 	STD_LOGIC_VECTOR (31 downto 0);
				ShiftR: 	in 	STD_LOGIC_VECTOR (31 downto 0);
				ALUOp:		in 	STD_LOGIC_VECTOR (1 downto 0);
				R:		  	out	STD_LOGIC_VECTOR (31 downto 0)
			);
	end component;

	signal LogicalR,ArithR,CompR,ShiftR,R_pre: STD_LOGIC_VECTOR(31 downto 0);
	signal Zero_pre,Overflow_pre,Carryout: STD_LOGIC;
begin

	LGC: ALU_Logical 	port map(A,B,ALUOp(1 downto 0),LogicalR);
	ART: ALU_Arith		port map(A,B,ALUOp(1 downto 0),Carryout,Overflow_pre,ArithR,Zero_pre);
	CMP: ALU_Comp		port map(A(31),B(31),ArithR(31),Carryout,ALUOp(1 downto 0),CompR);
	SFT: ALU_Shift		port map(A,ALUOp(1 downto 0),SHAMT,ShiftR);
	MUX: ALU_Mux		port map(LogicalR,ArithR,CompR,ShiftR,ALUOp(3 downto 2),R_pre);
	Zero <= Zero_pre;
	Overflow <= Overflow_pre;
	R <= R_pre;


end main;
