----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/17/2021 03:31:42 PM
-- Design Name: 
-- Module Name: B_Register - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: custom bit register
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Tested by B_Register_Testbench.vhd
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

entity B_Register is
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
end B_Register;

architecture Behavioral of B_Register is

begin

	syncDetect:
	process(i_l_clock,i_l_reset)
	begin
		if i_l_reset = '1' then
			o_vec_dataOut <= std_logic_vector(to_unsigned(0,width));
		elsif(i_l_clock'event and i_l_clock = '1') then
			if i_l_enable = '1'  then
				o_vec_dataOut <= i_vec_dataIn;
			end if;
		end if;		
	end process syncDetect;

end Behavioral;
