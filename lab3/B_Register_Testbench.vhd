----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/17/2021 05:56:01 PM
-- Design Name: 
-- Module Name: B_Register_Testbench - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity B_Register_Testbench is
--  Port ( );
end B_Register_Testbench;

architecture Behavioral of B_Register_Testbench is

	component B_Register is
	--  Port ( );
		generic (
			width: positive := 64
		);

		port (
			i_l_clock: in std_logic;
			i_vec_dataIn: in std_logic_vector(width-1 downto 0);
			i_l_enable: in std_logic;
			i_l_reset: in std_logic;
			o_vec_dataOut: out std_logic_vector(width-1 downto 0)
		);

	end component;	

signal s_l_clock: std_logic:= '0';
signal s_vec_dataIn: std_logic_vector(15 downto 0);
signal s_l_enable : std_logic := '0';
signal s_l_reset : std_logic := '0';
signal s_vec_dataOut: std_logic_vector(15 downto 0):="0000000000000000";

signal s_int_randNum : integer := 0;

begin

	uut: B_Register generic map(16) port map(s_l_clock,s_vec_dataIn,s_l_enable,s_l_reset,s_vec_dataOut);
	s_vec_dataIn <= std_logic_vector(to_signed(s_int_randNum,16));
	
	--Refresh s_int_randNum when falling edge from clock
	process(s_l_clock)  
	    variable v_pos_seed1, v_pos_seed2: positive;               -- seed values for random generator
	    variable v_rea_rand: real;   -- random real-number value in range 0 to 1.0  
	    variable v_rea_range : real := 65535.0;    -- the range of random values created will be 0 to +65535.
	begin
		if falling_edge(s_l_clock) then
		    uniform(v_pos_seed1, v_pos_seed2, v_rea_rand);   -- generate random number
		    s_int_randNum <= integer(v_rea_rand*v_rea_range);  -- rescale to 0..1000, convert integer part 
	    end if;
	end process;

	--Update clock and Assert
	process
		variable v_int_previous: integer := 0;
	begin
		s_l_enable <= '1';
		s_l_reset <= '0';
		wait for 1ns;
		for v_int_iter in 0 to 100 loop
			if v_int_previous/=0 then
				assert s_vec_dataOut=std_logic_vector(to_signed(v_int_previous,16)) 
					report "ERROR PRE STATE@ "& integer'image(v_int_previous);
			end if;
			wait for 1ns;
			s_l_clock <= '1';
			wait for 1ns;
			assert s_vec_dataOut=std_logic_vector(to_signed(s_int_randNum,16)) 
				report "ERROR POST STATE@ "& integer'image(s_int_randNum);
			v_int_previous := s_int_randNum;
			wait for 1ns;
			s_l_clock <= '0';
		end loop;
		s_l_reset <= '1';
		wait for 1ns;
		assert s_vec_dataOut="0000000000000000" report "ERROR RESET@ ";
		wait for 1ns;
		wait;
	end process;





end Behavioral;
