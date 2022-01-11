----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/19/2021 01:30:00 PM
-- Design Name: 
-- Module Name: X_Counter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Tested by X_Counter_Testbench.vhd
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

entity X_Counter is
--  Port ( );
	port(
		i_l_enable: in std_logic;
		i_l_reset: in std_logic;
		o_vec_count: out std_logic_vector(4 downto 0);
		o_l_done:out std_logic
	);
end X_Counter;

architecture Behavioral of X_Counter is

	signal s_uns_count: unsigned(5 downto 0);

begin

	o_vec_count <= std_logic_vector(s_uns_count(4 downto 0));
	--Update counter
	o_l_done <= '1' when s_uns_count = "100000" else '0';
	
	process(i_l_reset,i_l_enable)
	begin
		if i_l_reset = '1' then --Reset data when reset is enabled 
			s_uns_count <= "000000";
		elsif i_l_enable'event and i_l_enable = '1' and s_uns_count /= "100000" then
			s_uns_count <= s_uns_count + 1; 
		end if;
	end process;

end Behavioral;
