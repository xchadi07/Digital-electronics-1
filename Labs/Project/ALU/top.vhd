------------------------------------------------------------------------
--
-- Implementation of ALU
-- Xilinx XC2C256-TQ144 CPLD, ISE Design Suite 14.7
--
-- Copyright (c) 2019-2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

------------------------------------------------------------------------
-- Entity declaration for top level
------------------------------------------------------------------------
entity top is
port (
    SW0_CPLD   : in  std_logic;       	-- Input A
    SW1_CPLD   : in  std_logic;
    SW2_CPLD   : in  std_logic;
    SW3_CPLD   : in  std_logic;
	 SW4_CPLD   : in  std_logic;			-- Input B
	 SW5_CPLD   : in  std_logic;
	 SW6_CPLD   : in  std_logic;
	 SW7_CPLD   : in  std_logic;
    SW8_CPLD   : in  std_logic;       	-- Input Operation
    SW9_CPLD   : in  std_logic;
    SW10_CPLD  : in  std_logic;
    SW11_CPLD  : in  std_logic;
	 
	 clk_i      : in  std_logic;
	 BTN0	:IN std_logic;						-- Synchronus reset
	 
    disp_seg_o : out std_logic_vector(7-1 downto 0);
    disp_dig_o : out std_logic_vector(4-1 downto 0);
	 disp_dp : out std_logic
);
end entity top;

------------------------------------------------------------------------
-- Architecture declaration for top level
------------------------------------------------------------------------
architecture Behavioral of top is
    signal s_dataA, s_dataB : unsigned(3 downto 0);
	 signal s_operation: std_logic_vector(3 downto 0);
    signal s_carry : std_logic;
    signal s_result : unsigned(3 downto 0);
    signal s_zero, s_zapor_zn : std_logic;
	 signal s_clock_enable : std_logic;
begin

		-- Sub-block of clock_enable entity
	 CLOCK_ENABLE : entity work.clock_enable
	 generic map (
			g_NPERIOD => x"1234"
	 )
    port map (
	 
			clk_i => clk_i,
			srst_n_i => BTN0,
			clock_enable_o => s_clock_enable
    );
	 
	 
    -- Sub-block of ALU entity
    ALU : entity work.ALU
    port map (
	 
			clk_i => clk_i,
			srst_n_i => BTN0,
			alu_en_i => s_clock_enable,
			
			--inputs
			a_i => s_dataA,		--data A
			b_i => s_dataB,		--data B
			op_i => s_operation,		--data operation
			
			--outputs
			res_o => s_result,
			carry_o => s_carry,
			zero_o => s_zero,
			zapor_zn_o => s_zapor_zn
    );


    --------------------------------------------------------------------
    -- Sub-block of hex_to_7seg entity
    Driver7Seg : entity work.driver_7seg
    port map (
         clk_i => clk_i,   
			srst_n_i => BTN0,
			data0_i  => std_logic_vector(s_dataA),		--data A
			data1_i  =>	std_logic_vector(s_dataB),		--data B
			data2_i  =>	s_operation,		--data operation
			data3_i  =>	std_logic_vector(s_result),		--data result
			dp_i => "1111",   
    
			dp_o => disp_dp,    
			seg_o => disp_seg_o,    
			dig_o => disp_dig_o  
    );


end architecture Behavioral;