library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_Logical is
    Port ( 
        A : in STD_LOGIC_VECTOR (31 downto 0);
        B : in STD_LOGIC_VECTOR (31 downto 0);
        ALUOp: in STD_LOGIC_VECTOR (1 downto 0);
        LogicalR: out STD_LOGIC_VECTOR (31 downto 0)
    );
end ALU_Logical;

architecture main of ALU_Logical is
    
    
begin
    LogicalR <= (A AND B) when ALUOp = "00" else
                (A OR  B) when ALUOp = "01" else
                (A XOR B) when ALUOp = "10" else
                (A NOR B) when ALUOp = "11";
end main;
