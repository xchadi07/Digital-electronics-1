LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.NUMERIC_STD.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_0 IS
END tb_0;
 
ARCHITECTURE behavior OF tb_0 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         a_i         : IN unsigned(3 downto 0);
         b_i         : IN unsigned(3 downto 0);
         op_i        : IN std_logic_vector(3 downto 0);
         clk_i       : IN std_logic;
         alu_en_i    : IN std_logic;
         srst_n_i    : IN std_logic;
         
         zero_o      : OUT std_logic;
         zapor_zn_o  : OUT std_logic;
         carry_o     : OUT std_logic;
         res_o       : OUT unsigned(3 downto 0)
         
        );
    END COMPONENT;
    
  --Inputs
   signal a_i : unsigned(3 downto 0) := (others => '0');
   signal b_i : unsigned(3 downto 0) := (others => '0');
   signal op_i : std_logic_vector(3 downto 0) := (others => '0');
   signal clk_i :  std_logic := '0';
   signal alu_en_i :   std_logic := '1';
   signal srst_n_i :   std_logic := '1';


  --Outputs
   signal zero_o : std_logic;
   signal zapor_zn_o : std_logic;
   signal carry_o : std_logic;
   signal res_o : unsigned(3 downto 0);

 constant clk_i_period : time := 10 ns;
 
BEGIN
 
 -- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          a_i => a_i,
          b_i => b_i,
          op_i => op_i,
          clk_i => clk_i,
          alu_en_i => alu_en_i,
          srst_n_i => srst_n_i,
          zero_o => zero_o,
          zapor_zn_o => zapor_zn_o,
          carry_o => carry_o,
          res_o => res_o
        );

 -- Clock process definitions
   clk_i_process :process
   begin
      clk_i <= '0';
      wait for clk_i_period/2;
      clk_i <= '1';
      wait for clk_i_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin  
       --hold reset state for 100 ns.
       
     a_i <= "1111";
     b_i <= x"4";
     op_i <= x"0";
  
     for i in 0 to 15 loop 
     op_i <= op_i + x"1";
     wait for 50 ns;
     end loop;
    
     srst_n_i <= '1';
     wait for clk_i_period*5;
     srst_n_i <= '0';
     wait for clk_i_period*5;
     srst_n_i <= '1';
     wait;
   end process;

END;