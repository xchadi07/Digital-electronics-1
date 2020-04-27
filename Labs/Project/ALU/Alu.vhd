library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;
------------------------------------------------------------------------
-- Entity declaration
------------------------------------------------------------------------
entity ALU is
  
    Port (
         a_i          : in unsigned(3 downto 0);           --(vstupní hodnota A)
         b_i          : in unsigned(3 downto 0);           --(vstupní hodnota B)         
         op_i         : in std_logic_vector(3 downto 0);   --(operace)
         clk_i        : in std_logic;                      --(clock)
         alu_en_i     : in std_logic;                      --(ALU enable nebo taky clock enable) 
         srst_n_i     : in std_logic;                      --(synchronous reset, active low)
         
         zero_o       : out std_logic;                     --(výsledek "0")
         zapor_zn_o   : out std_logic;                     --(záporný výsledek)
         carry_o      : out std_logic;                     --(signalizace pøeneseného bitu carry)
         res_o        : out unsigned (3 downto 0)          --(výsledek)
         );
end ALU; 

------------------------------------------------------------------------
-- Architecture declaration 
------------------------------------------------------------------------
architecture Behavioral of ALU is

signal sres_o : unsigned (3 downto 0);                        
signal tmp: unsigned (4 downto 0);                  

begin

      zero_o <= '1' when sres_o(3 downto 0) = "0000" else '0';     -- nastavení signalizace výsledku "0"
      res_o <= sres_o;                                             -- pøiøazení výslekù
         
------------------------------------------------------------------------
-- Process declaration 
------------------------------------------------------------------------
   process(clk_i)
      begin
         if rising_edge(clk_i) and alu_en_i = '1' then
         
            carry_o <= '0';
            zapor_zn_o <= '0';
				
				if (sres_o >= "1000") then                  -- podmínka pro signalizaci záporné hodnoty kvùli pøepoètu podle dvojkového doplòku 
				                                            -- (max kladná hodnota = 7)
				zapor_zn_o <= '1';
				
				end if;
         
            if srst_n_i = '0' then                      -- reset
               sres_o <= (others => '0');   
               
            elsif alu_en_i = '1' then
            
               case(op_i) is
  
------------------------------------------------------------------------
-- Arithmetic part declaration 
------------------------------------------------------------------------
                  when "0000" =>                        -- A + B
  
                        sres_o <= a_i + b_i ; 
                        tmp <= ('0' & a_i) + ('0' & b_i);   
                        carry_o <= tmp(4);                         -- pøiøazení carry bitu 
   
                  when "0001" =>                        -- A - B
						
						      if (sres_o >= "1000") then                     -- podmínky pro signalizaci záporné hodnoty výsledku
								       zapor_zn_o <= '1';
   
                        else if (a_i >= b_i) then         
                              sres_o <= a_i - b_i; 
                              zapor_zn_o <= '0';
										
							   
                        else 
                              sres_o <= b_i - a_i; 
                              zapor_zn_o <= '1';
										
								
				            end if;
                        end if;
   
                  when "0010" =>                         -- B - A
						
						      if (sres_o >= "1000") then                     -- podmínky pro signalizaci záporné hodnoty výsledku
								       zapor_zn_o <= '1';
   
                        else if (b_i >= a_i) then                      
                              sres_o <= b_i - a_i;    
                              zapor_zn_o <= '0';
                        else 
                              sres_o <= a_i - b_i; 
                              zapor_zn_o <= '1';
                        end if;
								end if;
   
                  when "0011" =>                          -- A * B (krát) 
                        sres_o <= to_unsigned(to_integer(unsigned(a_i)) * to_integer(unsigned(b_i)),4);
   
                  when "0100" =>                          -- A + 1 
                        sres_o <= a_i + 1;
                        tmp <= ('0' & a_i) + ('0' & b_i);   
                        carry_o <= tmp(4);   
   
   
                  when "0101" =>                          -- A - 1 
						 
						      if (sres_o >= "1000") then                   -- podmínky pro signalizaci záporné hodnoty výsledku
								       zapor_zn_o <= '1';
   
                        else if (a_i >= 1) then                     
                              sres_o <= a_i - 1; 
                              zapor_zn_o <= '0';
										
							   
                        else 
                              sres_o <= 1 - a_i; 
                              zapor_zn_o <= '1';
										
								
				            end if;
                        end if;
                       -- sres_o <= a_i - 1;
                        
------------------------------------------------------------------------
-- Logic part declaration 
------------------------------------------------------------------------   

                  when "0110" =>                           -- Rotace vpravo
                        sres_o <= a_i ror 1;
                                                
                  when "0111" =>                           -- Rotate vlevo
                        sres_o <= a_i rol 1;
   
                  when "1000" =>                           -- Posuv vlevo
                        sres_o <= a_i sll 1;
   
                  when "1001" =>                           -- A OR B
                         sres_o <= a_i OR b_i;
   
                  when "1010" =>                           -- A AND B
                         sres_o <= a_i AND b_i;
   
                  when "1011" =>                           -- A NAND B 
                        sres_o <= a_i NAND b_i;
   
                  when "1100" =>                           -- A NOR B
                        sres_o <= a_i NOR b_i;
   
                  when "1101" =>                           -- A XOR B 
                        sres_o <= a_i XOR b_i;
      
                  when "1110" =>                           -- A XNOR B
                        sres_o <= a_i XNOR b_i;
      
                  when "1111" =>                           -- A = B ?  
                        if (a_i = b_i) then
                           sres_o <= x"1" ;
                        else
                           sres_o <= x"0" ;
                        end if;
   
                  when others =>  
   
               end case;
            end if;                     
         end if;
   end process;
 
end Behavioral;