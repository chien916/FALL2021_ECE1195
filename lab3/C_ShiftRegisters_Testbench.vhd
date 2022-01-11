----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/19/2021 12:23:22 AM
-- Design Name: 
-- Module Name: C_ShiftRegisters_Testbench - Behavioral
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

entity C_ShiftRegisters_Testbench is
--  Port ( );
end C_ShiftRegisters_Testbench;

architecture Behavioral of C_ShiftRegisters_Testbench is

	component C_ShiftRegisters is
	--  Port ( );
		generic (
			width: positive := 64
		);

		port(
			i_l_clock: in std_logic;
			i_vec_dataIn: in std_logic_vector(width-1 downto 0);
			i_l_enable: in std_logic;
			i_l_reset: in std_logic;
			i_l_shift: in std_logic;
			i_l_control: in std_logic;-- 0ï¼? Shift left 1ï¼šShift right
			o_vec_dataOut: out std_logic_vector(width-1 downto 0)
		);
	end component;

signal s_l_clock:  std_logic:= '0';
signal s_vec_dataIn: std_logic_vector(15 downto 0);
signal s_l_enable: std_logic;
signal s_l_reset: std_logic;
signal s_l_shift: std_logic;
signal s_l_control: std_logic;-- 0ï¼? Shift left 1ï¼šShift right
signal s_vec_dataOut: std_logic_vector(15 downto 0);

signal s_int_randNum : integer := 0;

begin
	uut: C_ShiftRegisters 
		generic map(16) 
		port map(s_l_clock,s_vec_dataIn,s_l_enable,s_l_reset,s_l_shift,s_l_control,s_vec_dataOut);

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

	--Update clock and Asser
	process
		variable v_int_expected: integer := 0;
	begin
		s_l_enable <= '1';
		s_l_reset <= '0';
		s_l_shift <= '1';
		s_l_clock <= '1';
		s_l_control <= '0';--mode: sll
		wait for 1ns;
		for v_int_iterI in 0 to 100 loop -- test sll
			s_l_clock <= '0';
			wait for 1ns;--new rand generated
			s_l_clock <= '1';
			wait for 1ns;--shifted value ready
			v_int_expected := s_int_randNum*2;
			assert s_vec_dataOut=std_logic_vector(to_signed(v_int_expected,16)) 
				report "ERROR SLL@ "& integer'image(s_int_randNum);
			wait for 1ns;
		end loop;

		s_l_control <= '1';--mode: srl
		for v_int_iterI in 0 to 100 loop -- test srl
			s_l_clock <= '0';
			wait for 1ns;--new rand generated
			s_l_clock <= '1';
			s_l_control <= '1';--mode: sll
			wait for 1ns;--shifted value ready
			v_int_expected := s_int_randNum/2;
			assert s_vec_dataOut=std_logic_vector(to_signed(v_int_expected,16)) 
				report "ERROR SRL@ "& integer'image(s_int_randNum);
			wait for 1ns;
		end loop;

	end process;	

end Behavioral;
