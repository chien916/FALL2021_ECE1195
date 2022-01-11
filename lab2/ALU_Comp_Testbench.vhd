library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_Comp_Testbench is
--  Port ( );
end ALU_Comp_Testbench;

architecture main of ALU_Comp_Testbench is

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

	signal CompR_Pos: STD_LOGIC_VECTOR(31 downto 0) := X"00000001";
	signal CompR_Neg: STD_LOGIC_VECTOR(31 downto 0) := X"00000000";
	signal ALU_Comp_Input : STD_LOGIC_VECTOR(5 downto 0);
	signal ALU_Comp_Output : STD_LOGIC_VECTOR(31 downto 0);
begin
	UUT: ALU_Comp port map	(	ALU_Comp_Input(3),--A_31
								ALU_Comp_Input(2),--B_31
								ALU_Comp_Input(1),--S_31
								ALU_Comp_Input(0),--CO
								ALU_Comp_Input(5 downto 4),--ALU_OP
								ALU_Comp_Output--CompR
							);
	testBenches: process
	constant waitTime: time := 30 ns;
	begin
--------------------------------------------------------------------------1
	ALU_Comp_Input<="000000";
	wait for waitTime;
	assert (ALU_Comp_Output = CompR_Neg)
	report 	"000000 err" 			severity error;
	wait for waitTime;
--------------------------------------------------------------------------2
	ALU_Comp_Input<="010000";
	wait for waitTime;
	assert (ALU_Comp_Output = CompR_Neg)
	report 	"010000 err" 			severity error;
	wait for waitTime;
--------------------------------------------------------------------------3
	ALU_Comp_Input<="100000";
	wait for waitTime;
	assert (ALU_Comp_Output = CompR_Neg)
	report 	"100000 err" 			severity error;
	wait for waitTime;
--------------------------------------------------------------------------4
	ALU_Comp_Input<="100010";
	wait for waitTime;
	assert (ALU_Comp_Output = CompR_Pos)
	report 	"100010 err" 			severity error;
	wait for waitTime;
--------------------------------------------------------------------------5
	ALU_Comp_Input<="101100";
	wait for waitTime;
	assert (ALU_Comp_Output = CompR_Neg)
	report 	"101100 err" 			severity error;
	wait for waitTime;
--------------------------------------------------------------------------6
	ALU_Comp_Input<="101110";
	wait for waitTime;
	assert (ALU_Comp_Output = CompR_Pos)
	report 	"101110 err" 			severity error;
	wait for waitTime;
--------------------------------------------------------------------------7
	ALU_Comp_Input<="101000";
	wait for waitTime;
	assert (ALU_Comp_Output = CompR_Pos)
	report 	"101000 err" 			severity error;
	wait for waitTime;
--------------------------------------------------------------------------8
	ALU_Comp_Input<="100100";
	wait for waitTime;
	assert (ALU_Comp_Output = CompR_Neg)
	report 	"100100 err" 			severity error;
	wait for waitTime;
--------------------------------------------------------------------------9
	ALU_Comp_Input<="110001";
	wait for waitTime;
	assert (ALU_Comp_Output = CompR_Neg)
	report 	"110001 err" 			severity error;
	wait for waitTime;
--------------------------------------------------------------------------10
	ALU_Comp_Input<="110000";
	wait for waitTime;
	assert (ALU_Comp_Output = CompR_Pos)
	report 	"110000 err" 			severity error;
	wait;
end process;

end main;
