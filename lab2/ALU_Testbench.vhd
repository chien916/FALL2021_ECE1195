library IEEE;
        use IEEE.std_logic_1164.all;
        use IEEE.std_logic_arith.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_Testbench is
--  Port ( );
end ALU_Testbench;

architecture main of ALU_Testbench is
	component ALU is
		Port(
				A: 			IN 	STD_LOGIC_VECTOR (31 downto 0);
				B: 			IN 	STD_LOGIC_VECTOR (31 downto 0);
				SHAMT: 		IN 	STD_LOGIC_VECTOR (4 downto 0);
				ALUOp: 		IN 	STD_LOGIC_VECTOR (3 downto 0);
				Zero: 		OUT STD_LOGIC;
				Overflow: 	OUT STD_LOGIC;
				R: 			OUT STD_LOGIC_VECTOR (31 downto 0)
			);
	end component;

	signal		A_iter: 		STD_LOGIC_VECTOR (31 downto 0):="00000000000000000000000000000000";
	signal		B_iter: 		STD_LOGIC_VECTOR (31 downto 0):="00000000000000000000000000000000";
	signal		SHAMT_iter: 	STD_LOGIC_VECTOR (4 downto 0):="00000";
	signal		ALUOp_iter: 	STD_LOGIC_VECTOR (3 downto 0):="0000";
	signal		Zero_iter_expected,Zero_iter_produced: 			STD_LOGIC:='0';
	signal		Overflow_iter_expected,Overflow_iter_produced: 	STD_LOGIC:='0';
	signal		R_iter_expected,R_iter_produced: 		STD_LOGIC_VECTOR (31 downto 0):="00000000000000000000000000000000";
begin

	UUT: ALU port map(A_iter,B_iter,SHAMT_iter,ALUOp_iter,Zero_iter_produced,Overflow_iter_produced,R_iter_produced);
	testBenches: process
	constant waitTime: time := 10 ns;
	begin
		for i_iter in -100 to 100 loop
			A_iter <= std_logic_vector(to_signed(i_iter, 32));
			for j_iter in -100 to 100 loop	
            	B_iter <= std_logic_vector(to_signed(j_iter, 32));
            	wait for waitTime;
--===============================LOGIC //ALL TESTS PASSED
-----------------------AND //ALL TESTS PASSED
				ALUOp_iter <= "0000";
				R_iter_expected <= A_iter AND B_iter;
				wait for waitTime;
				assert(R_iter_expected = R_iter_produced)
				report 	"and error" severity error;
				wait for waitTime;
-----------------------OR //ALL TESTS PASSED
				ALUOp_iter <= "0001";
				R_iter_expected <= A_iter OR B_iter;
				wait for waitTime;
				assert(R_iter_expected = R_iter_produced)
				report 	"or error" severity error;
				wait for waitTime;
-----------------------XOR //ALL TESTS PASSED
				ALUOp_iter <= "0010";
				R_iter_expected <= A_iter XOR B_iter;
				wait for waitTime;
				assert(R_iter_expected = R_iter_produced)
				report 	"xor error" severity error;
				wait for waitTime;
-----------------------NOR //ALL TESTS PASSED
				ALUOp_iter <= "0011";
				R_iter_expected <= A_iter NOR B_iter;
				wait for waitTime;
				assert(R_iter_expected = R_iter_produced)
				report 	"nor error" severity error;
				wait for waitTime;
--===============================ARITHMATIC //ALL TESTS PASSED
-----------------------ADD //ALL TESTS PASSED
				ALUOp_iter <= "0100";
				R_iter_expected <= std_logic_vector(to_signed(i_iter,32) + to_signed(j_iter,32) );
				wait for waitTime;
				assert(R_iter_expected = R_iter_produced)
				report 	"add error" severity error;
				wait for waitTime;
-----------------------ADDU //ALL TESTS PASSED
				ALUOp_iter <= "0101";
				R_iter_expected <= std_logic_vector(to_unsigned(i_iter,32) + to_unsigned(j_iter,32) );
				wait for waitTime;
				assert(R_iter_expected = R_iter_produced)
				report 	"addu error" severity error;
				wait for waitTime;
-----------------------SUB //ALL TESTS PASSED
				ALUOp_iter <= "0110";
				R_iter_expected <= std_logic_vector(to_signed(i_iter,32) - to_signed(j_iter,32) );
				wait for waitTime;
				assert(R_iter_expected = R_iter_produced)
				report 	"sub error" severity error;
				wait for waitTime;
-----------------------SUBU //ALL TESTS PASSED
				ALUOp_iter <= "0111";
				R_iter_expected <= std_logic_vector(to_unsigned(i_iter,32) - to_unsigned(j_iter,32) );
				wait for waitTime;
				assert(R_iter_expected = R_iter_produced)
				report 	"subu error" severity error;
				wait for waitTime;
--===============================COMPRERATOR //ALL TESTS PASSED
-----------------------SLT //ALL TESTS PASSED
				ALUOp_iter <= "1010";
				if (to_signed(i_iter,32)<to_signed(j_iter,32)) then
					R_iter_expected <= "00000000000000000000000000000001";
				else
					R_iter_expected <= "00000000000000000000000000000000";
				end if;
				wait for waitTime;
				assert(R_iter_expected = R_iter_produced)
				report 	"slt error" severity error;
				wait for waitTime;	
-----------------------SLTU //ALL TESTS PASSED
				ALUOp_iter <= "1011";
				if (to_unsigned(i_iter,32)<to_unsigned(j_iter,32)) then
					R_iter_expected <= "00000000000000000000000000000001";
				else
					R_iter_expected <= "00000000000000000000000000000000";
				end if;
				wait for waitTime;
				assert(R_iter_expected = R_iter_produced)
				report 	"sltu error" severity error;
				wait for waitTime;	
			end loop;
			for k_iter in 0 to 31 loop
            	SHAMT_iter <= std_logic_vector(to_unsigned(k_iter, 5));
            	wait for waitTime;
--===============================SHIFTER //ALL TESTS PASSED
-----------------------SLL //ALL TESTS PASSED
				ALUOp_iter <= "1100";
				R_iter_expected <= std_logic_vector(to_signed(i_iter,32) sll k_iter);
				wait for waitTime;
				assert(R_iter_expected = R_iter_produced)
				report 	"sll error" severity error;
-----------------------SLA //ALL TESTS PASSED
				ALUOp_iter <= "1101";
				R_iter_expected <= std_logic_vector(shift_left(to_signed(i_iter,32),k_iter));
				wait for waitTime;
				assert(R_iter_expected = R_iter_produced)
				report 	"sla error" severity error;
-----------------------SRL //ALL TESTS PASSED
				ALUOp_iter <= "1110";
				R_iter_expected <= std_logic_vector(to_signed(i_iter,32) srl k_iter);
				wait for waitTime;
				assert(R_iter_expected = R_iter_produced)
				report 	"srl error" severity error;
-----------------------SRA	
				ALUOp_iter <= "1111";
				R_iter_expected <= std_logic_vector(shift_right(to_signed(i_iter,32),k_iter));
				wait for waitTime;
				assert(R_iter_expected = R_iter_produced)
				report 	"sra error" severity error;							
			end loop;
		end loop;
	wait;
	end process;
end main;
