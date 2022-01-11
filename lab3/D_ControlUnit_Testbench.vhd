----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/20/2021 01:20:14 AM
-- Design Name: 
-- Module Name: D_ControlUnit_Testbench - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: This will only test states! I/O are not tested here! 
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

entity D_ControlUnit_Testbench is
--  Port ( );
end D_ControlUnit_Testbench;

architecture Behavioral of D_ControlUnit_Testbench is
	component D_ControlUnit is
		generic(
			width: positive := 32
		);
		port(
		-----INPUT FROM THE INTERNAL PROCESSOR
			i_l_clock: in std_logic; -- Internal input of clock
			-----INPUT FROM USER (READ FROM REGMAP REGISTERS)
			i_vec_mtplierUser: in std_logic_vector(width-1 downto 0); --User input of multiplier (Use this ONLY ONCE!)
			i_vec_mtplicandUser: in std_logic_vector(width-1 downto 0); -- User input of multiplicand (Use this ONLY ONCE!)
			i_l_reset: in std_logic; -- User input of reset 
			-----INPUT FROM OTHER BLOCK MODULES
			i_l_done : in std_logic;
			i_vec_mtplier: in std_logic_vector(width-1 downto 0); -- Shifted Multiplier from Multiplier Shifter (Use this to determine if copy or no copy)
			i_vec_mtplicand: in std_logic_vector(width*2-1 downto 0); -- Shifted Multiplicand from Multiplicand Shifter (Use this to repass to the multiplicand shifter)
			--i_vec_count: in std_logic_vector(width-1 downto 0); -- Number of count in vector form (Use this to determine if 32 repetations are reached)
			-----OUTPUT AS DATA_IN TO OTHER BLOCK MODULES
			o_vec_mtplier: out std_logic_vector(width-1 downto 0); -- Unshifted Multiplier to Multiplier Shifter
			o_vec_mtplicand: out std_logic_vector(width*2-1 downto 0); -- Unshifted Multiplicand to Multiplicand Shifter
			-----OUTPUT AS ENABLE TOGGLE SWITCH TO OTHER BLOCK MODULES
			o_l_mtplierEnable : out std_logic; -- Toggle switch for Multiplier Shifter Enable
			o_l_mtplierShift: out std_logic; -- Toggle switch for Mutiplicand Shifter Shift
			o_l_mtplicandEnable: out std_logic; -- Toggle switch for Mutiplicand Shifter Enable
			o_l_mtplicandShift: out std_logic; -- Toggle switch for Mutiplicand Shifter Shift
			o_l_productEnable: out std_logic; -- Toggle switch for Product
			o_l_counterEnable: out std_logic; -- Toggle switch for Counter
			-----OUTPUT FOR DEBUGGING ONLY
			o_vec_sta : out std_logic_vector (2 downto 0) -- 001:sta_s 010:sta_1 011:sta_1a 100:sta_23 101:sta_e
		);
	end component;

				-----INPUT FROM THE INTERNAL PROCESSOR
	signal s_l_clock:  std_logic := '0'; -- Internal input of clock
			-----INPUT FROM USER (READ FROM REGMAP REGISTERS)
	signal s_vec_mtplierUser:  std_logic_vector(1 downto 0):= "00"; --User input of multiplier (Use this ONLY ONCE!)
	signal s_vec_mtplicandUser:  std_logic_vector(1 downto 0):= "00"; -- User input of multiplicand (Use this ONLY ONCE!)
	signal s_l_reset:  std_logic := '0'; -- User input of reset 
			-----INPUT FROM OTHER BLOCK MODULES
	signal s_l_done :  std_logic :='0';
	signal s_vec_mtplierIn:  std_logic_vector(1 downto 0):= "00"; -- Shifted Multiplier from Multiplier Shifter (Use this to determine if copy or no copy)
	signal s_vec_mtplicandIn:  std_logic_vector(3 downto 0):= "0000"; -- Shifted Multiplicand from Multiplicand Shifter (Use this to repass to the multiplicand shifter)
			-----OUTPUT AS DATA_IN TO OTHER BLOCK MODULES
	signal s_vec_mtplierOut:  std_logic_vector(1 downto 0):= "00"; -- Unshifted Multiplier to Multiplier Shifter
	signal s_vec_mtplicandOut:  std_logic_vector(3 downto 0):= "0000"; -- Unshifted Multiplicand to Multiplicand Shifter
			-----OUTPUT AS ENABLE TOGGLE SWITCH TO OTHER BLOCK MODULES
	signal s_l_mtplierEnable :  std_logic:= '0'; -- Toggle switch for Multiplier Shifter Enable
	signal s_l_mtplierShift:  std_logic:= '0'; -- Toggle switch for Mutiplicand Shifter Shift
	signal s_l_mtplicandEnable:  std_logic:= '0'; -- Toggle switch for Mutiplicand Shifter Enable
	signal s_l_mtplicandShift:  std_logic:= '0'; -- Toggle switch for Mutiplicand Shifter Shift
	signal s_l_productEnable:  std_logic:= '0'; -- Toggle switch for Product
	signal s_l_counterEnable:  std_logic:= '0'; -- Toggle switch for Counter
			-----OUTPUT FOR DEBUGGING ONLY
	signal s_vec_sta : std_logic_vector (2 downto 0):= "000"; -- 001:sta_s 010:sta_1 011:sta_1a 100:sta_23 101:sta_e
begin
	test: D_ControlUnit
		generic map(2)
		port map(
			s_l_clock,
			s_vec_mtplierUser,s_vec_mtplicandUser,s_l_reset,s_l_done,
			s_vec_mtplierIn,s_vec_mtplicandIn,
			s_vec_mtplierOut,s_vec_mtplicandOut,
			s_l_mtplierEnable,s_l_mtplierShift,s_l_mtplicandEnable,s_l_mtplicandShift,s_l_productEnable,s_l_counterEnable,
			s_vec_sta
		);	
		
		

	process
	begin ----          1        2         3            4          1             4          5
		---TEST PATH: Start -> State 1 -> State 1a -> State 23 -> State 1 -> State 23 -> Done
		-----sta_b--1 (Start): Triggers when Reset is high
		s_l_reset <= '1';
		wait for 1ns;
		s_l_reset <= '0';
		wait for 1ns;

		assert s_vec_sta = "001" report "ERROR STA@ 001";
		
	
		-----sta_1--2: Start -> 1 no matter what
		s_l_clock <='1';
		wait for 1ns;
		s_l_clock <='0';
		wait for 1ns;
		
		assert s_vec_sta = "010" report "ERROR STA@ 010";
		
		
		-----sta_1a--3: 1 -> 1a when multiplier(0) is 1
		s_vec_mtplierIn <= "11";
		wait for 1ns;
		s_l_clock <='1';
		wait for 1ns;
		s_l_clock <='0';
		wait for 1ns;

		assert s_vec_sta = "011" report "ERROR STA@ 011";
		-----sta_23--4: 1a -> 23 no matter what
		s_l_clock <='1';
		wait for 1ns;
		s_l_clock <='0';
		wait for 1ns;

		assert s_vec_sta = "100" report "ERROR STA@ 100";
		-----sta_1--1: 23 ->1 if count is not enough
		
		s_vec_mtplierIn <= "00";
		wait for 1ns;
		s_l_clock <='1';
		wait for 1ns;
		s_l_clock <='0';
		wait for 1ns;

		assert s_vec_sta = "010" report "ERROR STA@ 010";
		-----sta_23--4: 1 ->2 if multiplier(0) is 0
		
		s_l_done <= '1';
		wait for 1ns;
		s_l_clock <='1';
		wait for 1ns;
		s_l_clock <='0';
		wait for 1ns;

		assert s_vec_sta = "100" report "ERROR STA@ 100";
		-----sta_d--5: 1 ->d if count is enough
		
		s_l_clock <='1';
		wait for 1ns;
		s_l_clock <='0';
		wait for 1ns;

		assert s_vec_sta = "101" report "ERROR STA@ 101";
	wait;
	end process;



end Behavioral;
