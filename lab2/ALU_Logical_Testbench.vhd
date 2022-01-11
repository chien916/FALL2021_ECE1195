
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;s

entity ALU_Logical_Testbench is
--  Port ( );
end ALU_Logical_Testbench;

architecture main of ALU_Logical_Testbench is

    component ALU_Logical is
    Port ( 
        A :         in STD_LOGIC_VECTOR (31 downto 0);
        B :         in STD_LOGIC_VECTOR (31 downto 0);
        ALUOp:      in STD_LOGIC_VECTOR (1 downto 0);
        LogicalR: out STD_LOGIC_VECTOR (31 downto 0)   
	);
    end component;

    signal LogicalR_iter_expected, LogicalR_iter_produced : STD_LOGIC_VECTOR(31 downto 0);
    signal A_iter: STD_LOGIC_VECTOR(31 downto 0);
    signal B_iter: STD_LOGIC_VECTOR(31 downto 0);
    signal ALUOp_iter  : STD_LOGIC_VECTOR(1 downto 0);


begin
UUT: ALU_Logical port map(A_iter,B_iter,ALUOp_iter,LogicalR_iter_produced);
    testBenches: process
    constant waitTime: time := 10 ns;
    begin
        for i_iter in -2147483647 to 2147483647 loop
            for j_iter in -2147483647 to 2147483647 loop
                A_iter <= std_logic_vector(to_signed(i_iter, 32));
                B_iter <= std_logic_vector(to_signed(j_iter, 32));
                wait for waitTime;
    --------------------------------------------------------------------------AND
                ALUOp_iter <= "00";
                LogicalR_iter_expected<= A_iter AND B_iter;
                wait for waitTime;
                assert(LogicalR_iter_produced = LogicalR_iter_expected)
                report  "and error "         
                severity error;
    --------------------------------------------------------------------------OR
                ALUOp_iter <= "01";
                LogicalR_iter_expected<= A_iter OR B_iter;
                wait for waitTime;
                assert(LogicalR_iter_produced = LogicalR_iter_expected)
                report  "or error"             
                severity error;
    --------------------------------------------------------------------------XOR
                ALUOp_iter <= "10";
                LogicalR_iter_expected<= A_iter XOR B_iter;
                wait for waitTime;
                assert(LogicalR_iter_produced = LogicalR_iter_expected)
                report  "xor error"      
                severity error;
    --------------------------------------------------------------------------NOR
                ALUOp_iter <= "11";
                LogicalR_iter_expected<= A_iter NOR B_iter;
                wait for waitTime;
                assert(LogicalR_iter_produced = LogicalR_iter_expected)
                report  "or error at "   
                severity error;
    --------------------------------------------------------------------------
            end loop;
        end loop;
    
    end process;



end main;
