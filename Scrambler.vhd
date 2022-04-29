----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/07/2021 11:06:25 AM
-- Design Name: 
-- Module Name: Scrambler - Behavioral
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

entity Scrambler is
--  Port ( );
port(
    Clk: in std_logic;
    Rst: in std_logic;
    Init:in std_logic;
    D_in:in std_logic_vector(7 downto 0);
    Stream_in:in std_logic;
    Stream_out:out std_logic;
    Busy:out std_logic
);
end Scrambler;

architecture Behavioral of Scrambler is

type state is (sta_f1,sta_f2,sta_busy,sta_done);
signal s_sta_prev: state := sta_f1;
signal s_sta_next: state := sta_f1;
signal s_vec_register: std_logic_vector(7 downto 0);
signal s_l_streamIn: std_logic;
signal s_l_streamOut: std_logic;
signal s_l_lsbIn: std_logic;
signal s_l_done: std_logic;
signal s_i_count: integer;
begin
    --i/o ports connections
	Busy <= not s_l_done;
    s_l_streamIn <= Stream_in;
    Stream_out <= s_l_streamOut;
    --external
    s_l_lsbIn <= s_vec_register(7) xor s_vec_register(6);
    s_l_streamOut <= s_l_streamIn xor s_l_lsbIn;
    --sect1
    process(Rst,Clk)
    begin
        if(Rst = '0') then
            s_sta_prev <= sta_f1;
        elsif(Clk'event and Clk = '1') then
            s_sta_prev <= s_sta_next;
        end if;
    end process;
    --sect2
    process(Init,s_i_count)
    begin
        case s_sta_prev is
            when sta_f1 => 
                if(Init='1') then
                    s_sta_next <= sta_f2;
                else
                    s_sta_next <= sta_f1;
                end if;
            when sta_f2 =>
                if(Init='1') then
                    s_sta_next <= sta_busy;
                else
                    s_sta_next <= sta_f1; 
                end if; 
            when sta_busy =>
                if(s_i_count=0) then
                    s_sta_next <= sta_done;
                else
                    s_sta_next <= sta_busy;
                end if; 
            when sta_done =>
                s_sta_next <= sta_done;
       end case;
    end process;
    
   --sect3
   process(s_sta_prev)
   begin
		case s_sta_prev is
            when sta_f1 => 
                s_vec_register <= D_in;
				s_i_count <= 0;
				s_l_done <= '1';
            when sta_f2 =>
                s_i_count <= to_integer(unsigned(D_in));
				s_l_done <= '1';
            when sta_busy =>
                s_vec_register(7 downto 1) <= s_vec_register(6 downto 0);
				s_vec_register(0) <= s_l_lsbIn;
				s_i_count <= s_i_count - 1;
				s_l_done <= '0';
            when sta_done =>
				s_l_done <= '1';
       end case;
	end process;          
end Behavioral;
