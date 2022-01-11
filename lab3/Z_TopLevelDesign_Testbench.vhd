----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/20/2021 07:38:16 PM
-- Design Name: 
-- Module Name: Z_TopLevelDesign_Testbench - Behavioral
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

entity Z_TopLevelDesign_Testbench is
--  Port ( );
end Z_TopLevelDesign_Testbench;

architecture Behavioral of Z_TopLevelDesign_Testbench is
	component Z_TopLevelDesign is
	--  Port ( );
		port(
			A: in std_logic_vector (31 downto 0);
			B: in std_logic_vector (31 downto 0);
			clk: in std_logic;
			rst: in std_logic;
			R: out std_logic_vector (63 downto 0);
			done: out std_logic 
		);
	end component;

		signal s_A: std_logic_vector (31 downto 0) ;
		signal s_B: std_logic_vector (31 downto 0) ;
		signal s_clk: std_logic := '0';
		signal s_rst: std_logic := '0';
		signal s_R: std_logic_vector (63 downto 0);
		signal s_done: std_logic ;

		signal s_int_productExpected: std_logic_vector (63 downto 0);

		signal s_int_randNum1 : integer := 0;
		signal s_int_randNum2 : integer := 0;
begin

	s_clk <= not s_clk after 1ns;---Simulated clock
	
	s_A <= std_logic_vector(to_unsigned(s_int_randNum1,32));
	s_B <= std_logic_vector(to_unsigned(s_int_randNum2,32));

	uut: Z_TopLevelDesign
		port map(s_A,s_B,s_clk,s_rst,s_R,s_done);



	process
	variable v_pos_seed1, v_pos_seed2: positive;               -- seed values for random generator
	variable v_rea_rand: real;   -- random real-number value in range 0 to 1.0  
	variable v_rea_range : real := 65535.0;    -- the range of random values created will be 0 to +65535.
	
	begin
			
		for v_int_iter in 0 to 500 loop
			s_rst <= '1';
			wait for 10ns;
			s_rst <= '0';
			--Reset everything to 0
			uniform(v_pos_seed1, v_pos_seed2, v_rea_rand);   -- generate random number
		    s_int_randNum1 <= integer(v_rea_rand*v_rea_range);  -- rescale to 0..1000, convert integer part 
	   		uniform(v_pos_seed1, v_pos_seed2, v_rea_rand);   -- generate random number
	   		s_int_randNum2 <= integer(v_rea_rand*v_rea_range);  -- rescale to 0..1000, convert integer part
	   		s_int_productExpected <= std_logic_vector(to_unsigned(s_int_randNum1 * s_int_randNum2,64));
	   		wait until s_done = '1';
			assert s_R = s_int_productExpected
				report "ERROR MTPL@ " & integer'image(s_int_randNum1) & " * " & integer'image(s_int_randNum2) 
				severity warning;
			wait for 1ns;
		end loop;
		wait;
	end process;


	





end Behavioral;
