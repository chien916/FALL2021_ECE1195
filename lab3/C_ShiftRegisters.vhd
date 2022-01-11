----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/17/2021 04:41:08 PM
-- Design Name: 
-- Module Name: C_ShiftRegisters - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: custom bit shift rergister
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Fully Tested by C_ShiftRegisters_Testbench.vhd
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity C_ShiftRegisters is
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
end C_ShiftRegisters;

architecture Behavioral of C_ShiftRegisters is
	
	signal s_vec_dataOut: std_logic_vector(width-1 downto 0);
	
begin

	O_vec_dataOut <= s_vec_dataOut;
	process(i_l_clock,i_l_reset)
	begin
		if i_l_reset = '1' then
			setZero: 
			for v_int_iter in 0 to width-1 loop
				s_vec_dataOut(v_int_iter) <= '0';
			end loop;
		elsif(i_l_clock'event and i_l_clock = '1' and i_l_enable = '1') then
			if i_l_shift = '0' then
				s_vec_dataOut <= i_vec_dataIn;
			elsif i_l_control ='0' then
				s_vec_dataOut <= i_vec_dataIn(width-2 downto 0) & '0';
			elsif i_l_control ='1' then
				s_vec_dataOut <= '0' & i_vec_dataIn(width-1 downto 1);
			else 
				s_vec_dataOut <= i_vec_dataIn;
			end if;
		end if;		
	end process;

end Behavioral;
