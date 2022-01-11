----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/21/2021 02:49:21 AM
-- Design Name: 
-- Module Name: W_Spliter - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity W_Spliter is
--  Port ( );
	generic(
		width: positive:= 32
	);
	port(
		i_vec_dataIn:in std_logic_vector(width*2-1 downto 0);
		o_vec_dataOutLeft:out std_logic_vector(width*2-1 downto width);
		o_vec_dataOutRight:out std_logic_vector(width-1 downto 0)
	);
end W_Spliter;

architecture Behavioral of W_Spliter is 

begin
	o_vec_dataOutLeft <= i_vec_dataIn(width*2-1 downto width);
	o_vec_dataOutRight <= i_vec_dataIn(width-1 downto 0);
end Behavioral;
