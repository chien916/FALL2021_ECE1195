library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

entity rand_gen is
end rand_gen;
architecture Behavioral of rand_gen is
component thirtyTwoBitAdder is 
    generic(
            bit_width : positive := 32
        );
    port(
            input_1 : in std_logic_vector(bit_width-1 downto 0);
            input_2 : in std_logic_vector(bit_width-1 downto 0);
            k       : in std_logic;
            output_1:out std_logic_vector(bit_width-1 downto 0);
            c_out   :out std_logic
        );
end component;



signal op1:  std_logic_vector(31 downto 0);
signal op2:  std_logic_vector(31 downto 0);
signal zero : std_logic := '0';
signal rand_num1 : std_logic_vector(31 downto 0);
signal sumFromInternal : std_logic_vector(31 downto 0);
signal sumFromDesignBlk: std_logic_vector(31 downto 0);
begin
ttbadr: thirtyTwoBitAdder port map(op1,op2,zero,sumFromDesignBlk,OPEN);

process
    variable seed1, seed2: positive;               -- seed values for random generator
    variable rand1: real;   -- random real-number value in range 0 to 1.0  
    variable range_of_rand : real := real(2**31-1);    -- the range of random values created will be 0 to 2^31-1.
begin
    for i in 0 to 15 loop
        uniform(seed1, seed2, rand1);   -- generate random number
        rand_num1 <= std_logic_vector(to_signed(integer(rand1*range_of_rand), 32));  -- rescale to 0..2^31-1, convert integer part      
        op1<= "0000000000000000"&rand_num1(15 downto 0);
        op2<= "0000000000000000"&rand_num1(31 downto 16);
        --sumFromInternal <= op1 + op2;
        assert(sumFromInternal = sumFromDesignBlk) report "Sum failed";
        wait for 10 ns;
    end loop;
    wait;
end process;


end Behavioral;