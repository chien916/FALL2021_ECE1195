----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/19/2021 02:16:15 PM
-- Design Name: 
-- Module Name: X_Counter_Testbench - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity X_Counter_Testbench is
--  Port ( );
end X_Counter_Testbench;

architecture Behavioral of X_Counter_Testbench is

component X_Counter is
--  Port ( );
	port(
		i_l_enable: in std_logic;
		i_l_reset: in std_logic;
		o_vec_count: out std_logic_vector(4 downto 0);
		o_l_done:out std_logic
	);
end component;
	signal s_l_enable:  std_logic;
	signal s_l_reset:  std_logic;
	signal s_vec_count: std_logic_vector(4 downto 0);
	signal s_l_done: std_logic;
begin

	uut: X_Counter
		port map(s_l_enable,s_l_reset,s_vec_count,s_l_done);

	process
	begin
		s_l_reset <= '1';
		wait for 1ns;
		assert s_vec_count = "00000"
				report "ERROR COUNT WHEN RESETTED 1 @ " & integer'image(0);
		s_l_reset <= '0';
		wait for 1ns;
		for v_int_iter in 0 to 32 loop
		 	assert to_unsigned(v_int_iter+1,5) = unsigned(s_vec_count)
				report "ERROR COUNT WHEN ENABLED@ " & integer'image(v_int_iter);
			--Test: should there be a result change when enabled
			s_l_enable <= '1';
			wait for 1ns;
			s_l_enable <= '0';
			wait for 1ns;
		end loop;
		
		s_l_reset <= '1';
		wait for 1ns;
		assert s_vec_count = "00000"
				report "ERROR COUNT WHEN RESETTED 2 @ " & integer'image(0);
		wait;
	end process;


end Behavioral;
