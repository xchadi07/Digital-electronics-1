LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY top_tb IS
END top_tb;
 
ARCHITECTURE behavior OF top_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         SW0_CPLD   : IN  std_logic;
         SW1_CPLD   : IN  std_logic;
         SW2_CPLD   : IN  std_logic;
         SW3_CPLD   : IN  std_logic;
         SW4_CPLD   : IN  std_logic;
         SW5_CPLD   : IN  std_logic;
         SW6_CPLD   : IN  std_logic;
         SW7_CPLD   : IN  std_logic;
         SW8_CPLD   : IN  std_logic;
         SW9_CPLD   : IN  std_logic;
         SW10_CPLD  : IN  std_logic;
         SW11_CPLD  : IN  std_logic;
         clk_i      : IN  std_logic;
         BTN0       : IN  std_logic;
         
         disp_seg_o : OUT  std_logic_vector(6 downto 0);
         disp_dig_o : OUT  std_logic_vector(3 downto 0);
         disp_dp    : OUT  std_logic;
         
         LD0        : out std_logic;        
         LD1        : out std_logic;           
         LD2        : out std_logic;           
         LD0_CPLD   : out std_logic;
         LD1_CPLD   : out std_logic;
         LD2_CPLD   : out std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal SW0_CPLD  : std_logic := '0';
   signal SW1_CPLD  : std_logic := '0';
   signal SW2_CPLD  : std_logic := '0';
   signal SW3_CPLD  : std_logic := '1';
   
   signal SW4_CPLD  : std_logic := '0';
   signal SW5_CPLD  : std_logic := '0';
   signal SW6_CPLD  : std_logic := '1';
   signal SW7_CPLD  : std_logic := '0';
   
   signal SW8_CPLD  : std_logic := '0';
   signal SW9_CPLD  : std_logic := '0';
   signal SW10_CPLD : std_logic := '0';
   signal SW11_CPLD : std_logic := '0';
   
   signal clk_i     : std_logic := '0';
   signal BTN0      : std_logic := '1';

    --Outputs
   signal disp_seg_o : std_logic_vector(6 downto 0);
   signal disp_dig_o : std_logic_vector(3 downto 0);
   signal disp_dp    : std_logic;
   
   signal LD0        : std_logic;        
   signal LD1        : std_logic;            
   signal LD2        : std_logic;
   signal LD0_CPLD   : std_logic; 
   signal LD1_CPLD   : std_logic; 
   signal LD2_CPLD   : std_logic;   

   -- Clock period definitions
   constant clk_i_period : time := 10 ns;
 
BEGIN
 
   -- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          SW0_CPLD => SW0_CPLD,
          SW1_CPLD => SW1_CPLD,
          SW2_CPLD => SW2_CPLD,
          SW3_CPLD => SW3_CPLD,
          SW4_CPLD => SW4_CPLD,
          SW5_CPLD => SW5_CPLD,
          SW6_CPLD => SW6_CPLD,
          SW7_CPLD => SW7_CPLD,
          SW8_CPLD => SW8_CPLD,
          SW9_CPLD => SW9_CPLD,
          SW10_CPLD => SW10_CPLD,
          SW11_CPLD => SW11_CPLD,
          clk_i => clk_i,
          BTN0 => BTN0,
          disp_seg_o => disp_seg_o,
          disp_dig_o => disp_dig_o,
          disp_dp => disp_dp,
          LD0 => LD0,
          LD1 => LD1,
          LD2 => LD2,
          LD0_CPLD => LD0_CPLD,
          LD1_CPLD => LD1_CPLD,
          LD2_CPLD => LD2_CPLD
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
      -- hold reset state for 100 ns.
          wait for 100 ns;

          wait for clk_i_period*10; 

      wait;
   end process;

END;
