----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/19/2021 12:51:01 PM
-- Design Name: 
-- Module Name: A_Adder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: custom bit adder
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Not Tested
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

entity A_Adder is
--  Port ( );
	generic (
		width: positive := 64
	);
	port(
		i_vec_dataInA: in std_logic_vector(width-1 downto 0);
		i_vec_dataInB: in std_logic_vector(width-1 downto 0);
		o_vec_dataOut: out std_logic_vector(width-1 downto 0)
	);
end A_Adder;

architecture Behavioral of A_Adder is

begin

	o_vec_dataOut <= std_logic_vector(signed(i_vec_dataInA) + signed(i_vec_dataInB));
	
end Behavioral;
