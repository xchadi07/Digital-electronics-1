library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;    -- Provides unsigned numerical computation

------------------------------------------------------------------------
-- Entity declaration for display driver
------------------------------------------------------------------------
entity driver_7seg is
port (
    clk_i    : in  std_logic;
    srst_n_i : in  std_logic;   -- Synchronous reset (active low)
    data0_i  : in  std_logic_vector(4-1 downto 0);  -- Input values
    data1_i  : in  std_logic_vector(4-1 downto 0);
    data2_i  : in  std_logic_vector(4-1 downto 0);
    data3_i  : in  std_logic_vector(4-1 downto 0);
    dp_i     : in  std_logic_vector(4-1 downto 0);  -- Decimal points
    
    dp_o     : out std_logic;                       -- Decimal point
    seg_o    : out std_logic_vector(7-1 downto 0);
    dig_o    : out std_logic_vector(4-1 downto 0)
);
end entity driver_7seg;

------------------------------------------------------------------------
-- Architecture declaration for display driver
------------------------------------------------------------------------
architecture Behavioral of driver_7seg is
    signal s_en  : std_logic;
    signal s_hex : std_logic_vector(4-1 downto 0);
    signal s_cnt : std_logic_vector(2-1 downto 0) := "00";
begin

    --------------------------------------------------------------------
    -- Sub-block of clock_enable entity. Create s_en signal.
		 
			CLOCK_ENABLE0 : entity work.clock_enable
			
					generic map (
									 g_NPERIOD => x"0019"      									 
														  
										)
					port map (
									clk_i => clk_i, 
									srst_n_i =>  srst_n_i, 
									clock_enable_o => s_en
				);
												 
    --------------------------------------------------------------------
    -- Sub-block of hex_to_7seg entity
	 
			HEX_TO_7SEG0 : entity work.hex_to_7seg
				
							port map (
											hex_i => s_hex,
											seg_o => seg_o	   									   												
				);


    --------------------------------------------------------------------
    -- p_select_cnt:
    -- Sequential process with synchronous reset and clock enable,
    -- which implements an internal 2-bit counter s_cnt for multiplexer 
    -- selection bits.
    --------------------------------------------------------------------
    p_select_cnt : process (clk_i)
    begin
        if rising_edge(clk_i) then  -- Rising clock edge
            if srst_n_i = '0' then  -- Synchronous reset (active low)

							s_cnt <= (others => '0');   -- Clear all bits              																						 
					 
            elsif s_en = '1' then
																									
							s_cnt <= s_cnt + "01";															
												
            end if;
        end if;
    end process p_select_cnt;

    --------------------------------------------------------------------
    -- p_mux:
    -- Combinational process which implements a 4-to-1 mux.
    --------------------------------------------------------------------
    p_mux : process (s_cnt, data0_i, data1_i, data2_i, data3_i, dp_i)
    begin
        case s_cnt is
        when "00" =>

				s_hex <= data0_i;																		
				dig_o <= "1110";															
				dp_o <= dp_i(0);   

				
        when "01" =>

				s_hex <= data1_i;															
				dig_o <= "1101";															
				dp_o <= dp_i(1);

								
        when "10" =>

				s_hex <= data2_i;															
				dig_o <= "1011";															
				dp_o <= dp_i(2);

				
        when others =>

				s_hex <= data3_i;															
				dig_o <= "0111";														
				dp_o <= dp_i(3);

        end case;
    end process p_mux;

end architecture Behavioral;