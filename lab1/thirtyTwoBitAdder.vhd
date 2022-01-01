library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity thirtyTwoBitAdder is 
	generic(
			bit_width : positive := 32
		);
	port(
			input_1 : in std_logic_vector(bit_width-1 downto 0);
			input_2 : in std_logic_vector(bit_width-1 downto 0);
			k		: in std_logic;
			output_1:out std_logic_vector(bit_width-1 downto 0);
			c_out	:out std_logic
		);
end entity;
architecture rtl of thirtyTwoBitAdder is
component full_adder is
  port (
    i_bit1  : in std_logic;
    i_bit2  : in std_logic;
    i_carry : in std_logic;
    o_sum   : out std_logic;
    o_carry : out std_logic
    );
end component;

signal output_1_iter : std_logic_vector(bit_width-1 downto 0);
signal carryIn_iter: std_logic_vector(bit_width-1 downto 0);
signal carryOut_iter: std_logic_vector(bit_width-1 downto 0);
signal afterNotGate_iter : std_logic_vector(bit_width-1 downto 0);


begin
	carryIn_iter(0) <= k;

	loop_carry: for j in 0 to bit_width-2 generate
		carryIn_iter(j+1) <= carryOut_iter(j);
	end generate;

	c_out <= carryOut_iter(bit_width-1);

	loop_param:	for i in 0 to bit_width-1 generate
		afterNotGate_iter(i) <= k XOR input_2(i);
		fullAdderTemp: full_adder port map (
			input_1(i),
			afterNotGate_iter(i),
			carryIn_iter(i),
			output_1_iter(i),
			carryOut_iter(i)
		);
	end generate;

	output_1 <= output_1_iter;
	
end rtl;

	