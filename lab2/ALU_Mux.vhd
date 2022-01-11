
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_Mux is
	Port(
			LogicalR: 	in 	STD_LOGIC_VECTOR (31 downto 0);
			ArithR: 	in 	STD_LOGIC_VECTOR (31 downto 0);
			CompR: 		in 	STD_LOGIC_VECTOR (31 downto 0);
			ShiftR: 	in 	STD_LOGIC_VECTOR (31 downto 0);
			ALUOp:		in 	STD_LOGIC_VECTOR (1 downto 0);
			R:		  	out	STD_LOGIC_VECTOR (31 downto 0)
		);
end ALU_Mux;

architecture main of ALU_Mux is
begin

with ALUOp select R <=
	LogicalR 	when 	"00",
	ArithR 		when 	"01",
	CompR 		when 	"10",
	ShiftR 		when 	others;


end main;
