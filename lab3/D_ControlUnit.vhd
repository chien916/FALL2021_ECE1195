----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/19/2021 01:09:22 PM
-- Design Name: 
-- Module Name: D_ControlUnit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Finite State Machine for Lab 3
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Partially Tested by D_ControlUnit_Testbench.vhdl
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

entity D_ControlUnit is
	generic(
		width: positive := 32
	);
--  Port ( );
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
end D_ControlUnit;

architecture Behavioral of D_ControlUnit is
	type t_sta is 
		(sta_s,sta_1,sta_1a,sta_23,sta_d);
	signal s_sta_prev,s_sta_next: t_sta := sta_s;

begin

	--SECTION 1: FSM REGISTER
	process(i_l_reset,i_l_clock)
	begin
		if i_l_reset = '1' then
			s_sta_prev <= sta_s; ---State reset
		elsif (i_l_clock'event and i_l_clock = '0') then
			s_sta_prev <= s_sta_next;
		end if;
	end process;

	--SECTION 2: NEXT STATE FUNCTION
	process(i_vec_mtplier,i_l_done,s_sta_prev)
	begin
		case s_sta_prev is
			when sta_s =>
				s_sta_next <= sta_1;
			when sta_1 =>
				if i_vec_mtplier(0) = '1' then
					s_sta_next <= sta_1a;
				else
					s_sta_next <= sta_23;
				end if; 
			when sta_1a =>
				s_sta_next <= sta_23;
			when sta_23 =>
				if i_l_done = '0'  then
					s_sta_next <= sta_1;
				else
					s_sta_next <= sta_d;
				end if;
			when sta_d =>
				s_sta_next <= sta_d;
		end case;
	end process;

	--SECTION 3: OUTPUT FUNCTION
	process(s_sta_prev)
	begin
		case s_sta_prev is
			when sta_s =>
				o_vec_sta <= "001";
				-----OUTPUT AS DATA_IN TO OTHER BLOCK MODULES
				o_vec_mtplier <= i_vec_mtplierUser; -- Unshifted Multiplier to Multiplier Shifter
				o_vec_mtplicand <= (std_logic_vector(to_unsigned(0,width)) & i_vec_mtplicandUser); -- Unshifted Multiplicand to Multiplicand Shifter
				-----OUTPUT AS ENABLE TOGGLE SWITCH TO OTHER BLOCK MODULES
				o_l_mtplierEnable   <=	'1'; -- Toggle switch for Multiplier Shifter (Enable)  -- because 1a will use multiplier(0)
				o_l_mtplierShift    <=	'0'; -- Toggle switch for Multiplier Shifter (Shift)      
				o_l_mtplicandEnable <=	'1'; -- Toggle switch for Mutiplicand Shifter (Enable) -- because 1a will potentially add multiplicand to product
				o_l_mtplicandShift  <=	'0'; -- Toggle switch for Mutiplicand Shifter (Shift)
				o_l_productEnable 	<=	'0'; -- Toggle switch for Product
				o_l_counterEnable 	<=	'0'; -- Toggle switch for Counter
				-----FINITE STATE MACHINE INPUT
			when sta_1 =>
				o_vec_sta <= "010";
				-----OUTPUT AS DATA_IN TO OTHER BLOCK MODULES
				o_vec_mtplier <= i_vec_mtplier; -- Unshifted Multiplier to Multiplier Shifter
				o_vec_mtplicand <= i_vec_mtplicand; -- Unshifted Multiplicand to Multiplicand Shifter
				-----OUTPUT AS ENABLE TOGGLE SWITCH TO OTHER BLOCK MODULES
				o_l_mtplierEnable   <=	'1'; -- Toggle switch for Multiplier Shifter (Enable)
				o_l_mtplierShift    <=	'0'; -- Toggle switch for Multiplier Shifter (Shift)
				o_l_mtplicandEnable <=	'1'; -- Toggle switch for Mutiplicand Shifter (Enable)
				o_l_mtplicandShift  <=	'0'; -- Toggle switch for Mutiplicand Shifter (Shift)
				o_l_productEnable 	<=	'0'; -- Toggle switch for Product -- because place the result in product register
				o_l_counterEnable 	<=	'0'; -- Toggle switch for Counter
				-----FINITE STATE MACHINE INPUT
			when sta_1a =>
				o_vec_sta <= "011";
				-----OUTPUT AS DATA_IN TO OTHER BLOCK MODULES
				o_vec_mtplier <= i_vec_mtplier; -- Unshifted Multiplier to Multiplier Shifter
				o_vec_mtplicand <= i_vec_mtplicand; -- Unshifted Multiplicand to Multiplicand Shifter
				-----OUTPUT AS ENABLE TOGGLE SWITCH TO OTHER BLOCK MODULES
				o_l_mtplierEnable   <=	'1'; -- Toggle switch for Multiplier Shifter (Enable)  -- shift
				o_l_mtplierShift    <=	'0'; -- Toggle switch for Multiplier Shifter (Shift)
				o_l_mtplicandEnable <=	'1'; -- Toggle switch for Mutiplicand Shifter (Enable) -- shift
				o_l_mtplicandShift  <=	'0'; -- Toggle switch for Mutiplicand Shifter (Shift)
				o_l_productEnable 	<=	'1'; -- Toggle switch for Product
				o_l_counterEnable 	<=	'0'; -- Toggle switch for Counter
				-----FINITE STATE MACHINE INPUT
			when sta_23 =>
				o_vec_sta <= "100";
				-----OUTPUT AS DATA_IN TO OTHER BLOCK MODULES
				o_vec_mtplier <= i_vec_mtplier; -- Unshifted Multiplier to Multiplier Shifter
				o_vec_mtplicand <= i_vec_mtplicand; -- Unshifted Multiplicand to Multiplicand Shifter
				-----OUTPUT AS ENABLE TOGGLE SWITCH TO OTHER BLOCK MODULES
				o_l_mtplierEnable   <=	'1'; -- Toggle switch for Multiplier Shifter (Enable)  -- shift
				o_l_mtplierShift    <=	'1'; -- Toggle switch for Multiplier Shifter (Shift)
				o_l_mtplicandEnable <=	'1'; -- Toggle switch for Mutiplicand Shifter (Enable)
				o_l_mtplicandShift  <=	'1'; -- Toggle switch for Mutiplicand Shifter (Shift)
				o_l_productEnable 	<=	'0'; -- Toggle switch for Product
				o_l_counterEnable 	<=	'1'; -- Toggle switch for Counter
				-----FINITE STATE MACHINE INPUT
			when sta_d =>
				o_vec_sta <= "101";
				-----OUTPUT AS DATA_IN TO OTHER BLOCK MODULES
				o_vec_mtplier <= i_vec_mtplier; -- Unshifted Multiplier to Multiplier Shifter
				o_vec_mtplicand <= i_vec_mtplicand; -- Unshifted Multiplicand to Multiplicand Shifter
				-----OUTPUT AS ENABLE TOGGLE SWITCH TO OTHER BLOCK MODULES
				o_l_mtplierEnable   <=	'1'; -- Toggle switch for Multiplier Shifter (Enable)  -- shift
				o_l_mtplierShift    <=	'0'; -- Toggle switch for Multiplier Shifter (Shift)
				o_l_mtplicandEnable <=	'1'; -- Toggle switch for Mutiplicand Shifter (Enable)
				o_l_mtplicandShift  <=	'0'; -- Toggle switch for Mutiplicand Shifter (Shift)
				o_l_productEnable 	<=	'0'; -- Toggle switch for Product
				o_l_counterEnable 	<=	'0'; -- Toggle switch for Counter
				-----FINITE STATE MACHINE INPUT
		end case;
	end process;



end Behavioral;
