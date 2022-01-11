----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/20/2021 02:41:45 PM
-- Design Name: 
-- Module Name: Z_TopLevelDesign - Behavioral
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

entity Z_TopLevelDesign is
--  Port ( );
	port(
		A: in std_logic_vector (31 downto 0);
		B: in std_logic_vector (31 downto 0);
		clk: in std_logic;
		rst: in std_logic;
		R: out std_logic_vector (63 downto 0);
		done: out std_logic 
	);
end Z_TopLevelDesign;

architecture Behavioral of Z_TopLevelDesign is
	component A_Adder is
	--  Port ( );
		generic (
			width: positive := 64
		);
		port(
			i_vec_dataInA: in std_logic_vector(width-1 downto 0);
			i_vec_dataInB: in std_logic_vector(width-1 downto 0);
			o_vec_dataOut: out std_logic_vector(width-1 downto 0)
		);
	end component;
	component B_Register is
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
	end component;
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
	component D_ControlUnit is
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
	component X_Counter is
	--  Port ( );
		port(
			i_l_enable: in std_logic;
			i_l_reset: in std_logic;
			o_vec_count: out std_logic_vector(4 downto 0);
			o_l_done:out std_logic
		);
	end component;
	--Intermediate Signals:
	signal s_l_clkReduced: std_logic := '0';
	----Logic signals:
	signal s_l_mtplierEnableFromControl: std_logic := '0';
	signal s_l_mtplierShiftFromControl: std_logic := '0';
	signal s_l_mtplicandEnableFromControl: std_logic := '0';
	signal s_l_mtplicandShiftFromControl: std_logic := '0';
	signal s_l_productEnableFromControl: std_logic := '0';
	signal s_l_counterEnableFromControl: std_logic := '0';
	signal s_l_doneFromCounter: std_logic := '0';
	----Vector signals:
	signal s_int_clkReducedCount: integer :=0;
	signal s_vec_sta : std_logic_vector (2 downto 0);
	signal s_vec_mtplierFromControl: std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(0,32));
	signal s_vec_mtplicandFromControl: std_logic_vector(63 downto 0):= std_logic_vector(to_unsigned(0,64));
	signal s_vec_dataOutFromMtplier: std_logic_vector(31 downto 0):= std_logic_vector(to_unsigned(0,32));
	signal s_vec_dataOutFromMtplicand: std_logic_vector(63 downto 0):= std_logic_vector(to_unsigned(0,64));
	signal s_vec_dataOutFromProduct: std_logic_vector(63 downto 0):= std_logic_vector(to_unsigned(0,64));
	signal s_vec_dataOutFromAdder: std_logic_vector(63 downto 0):= std_logic_vector(to_unsigned(0,64));
	signal s_vec_dataOutFromCounter: std_logic_vector(4 downto 0):= "00000";
begin
	--process(clk)
	--begin
	--	if(clk'event and clk = '1') then
	--		if(s_int_clkReducedCount = 5) then
	--			s_l_clkReduced <= not s_l_clkReduced;
	--			s_int_clkReducedCount <=0;
	--		else
		--		s_int_clkReducedCount <= s_int_clkReducedCount+1;
		--	end if;
	--	end if;
	--end process;
	
	s_l_clkReduced <= clk;
	done <= s_l_doneFromCounter;
	R <= s_vec_dataOutFromProduct;
	
	
	mtplicandImpl: C_ShiftRegisters
		generic map(64)
		port map(
			i_l_clock => s_l_clkReduced,
			 i_vec_dataIn => s_vec_mtplicandFromControl,
			 i_l_enable => s_l_mtplicandEnableFromControl,
			 i_l_reset => rst,
			 i_l_shift => s_l_mtplicandShiftFromControl,
			 i_l_control => '0',
			 o_vec_dataOut =>  s_vec_dataOutFromMtplicand
		);

	adderImpl: A_Adder
		generic map(64)
		port map(
			i_vec_dataInA => s_vec_dataOutFromProduct,
			i_vec_dataInB => s_vec_dataOutFromMtplicand,
			o_vec_dataOut => s_vec_dataOutFromAdder
		);

	productImpl: B_Register
		generic map(64)
		port map(
			i_l_clock => s_l_clkReduced,
			i_vec_dataIn => s_vec_dataOutFromAdder,
			i_l_enable => s_l_productEnableFromControl,
			i_l_reset => rst,
			o_vec_dataOut => s_vec_dataOutFromProduct
		);

	controlImpl: D_ControlUnit
		generic map(32)
		port map(
			-----INPUT FROM THE INTERNAL PROCESSOR
			i_l_clock => s_l_clkReduced,
			-----INPUT FROM USER (READ FROM REGMAP REGISTERS)
			i_vec_mtplierUser => A,
			i_vec_mtplicandUser => B,
			i_l_reset => rst,
			i_l_done => s_l_doneFromCounter,
			-----INPUT FROM OTHER BLOCK MODULES
			i_vec_mtplier => s_vec_dataOutFromMtplier,
			i_vec_mtplicand => s_vec_dataOutFromMtplicand,
			-----OUTPUT AS DATA_IN TO OTHER BLOCK MODULES
			o_vec_mtplier => s_vec_mtplierFromControl,
			o_vec_mtplicand =>s_vec_mtplicandFromControl,
			-----OUTPUT AS ENABLE TOGGLE SWITCH TO OTHER BLOCK MODULES
			o_l_mtplierEnable  => s_l_mtplierEnableFromControl,
			o_l_mtplierShift =>	s_l_mtplierShiftFromControl,
			o_l_mtplicandEnable => s_l_mtplicandEnableFromControl,
			o_l_mtplicandShift => s_l_mtplicandShiftFromControl,
			o_l_productEnable => s_l_productEnableFromControl,
			o_l_counterEnable => s_l_counterEnableFromControl,
			-----OUTPUT FOR DEBUGGING ONLY
			o_vec_sta  =>s_vec_sta 
		);
		


	counterImpl: X_Counter
		port map(
			i_l_enable => s_l_counterEnableFromControl,
			i_l_reset => rst,
			o_vec_count => s_vec_dataOutFromCounter,
			o_l_done =>s_l_doneFromCounter
		);

	mtplierImpl: C_ShiftRegisters
		generic map(32)
		port map(
			i_l_clock => s_l_clkReduced,
			i_vec_dataIn => s_vec_mtplierFromControl,
			i_l_enable => s_l_mtplierEnableFromControl,
			i_l_reset => rst,
			i_l_shift => s_l_mtplierShiftFromControl,
			i_l_control => '1',
			o_vec_dataOut => s_vec_dataOutFromMtplier
		);




end Behavioral;
