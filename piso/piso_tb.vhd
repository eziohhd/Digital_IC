----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/04/12 15:49:15
-- Design Name: 
-- Module Name: ALU_tb - Behavioral
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

entity piso_tb is
--  Port ( );
end piso_tb;
architecture Behavioral of piso_tb is
component PISO is
   port ( reset         : in  std_logic;
          clk           : in  std_logic;
          D0            : in  std_logic;
          D1            : in  std_logic;
          D2            : in  std_logic;
          D3            : in  std_logic;
          shift_load_n  : in  std_logic;
          SO            : out std_logic --serial out
        );
end component;

   constant period   : time := 5 ns; 
   constant WIDTH  : integer := 32;
   signal clk     :     std_logic      := '0' ;
   signal reset   :     std_logic      ;
   signal D       :     std_logic_vector(3 downto 0);
   signal SO      :     std_logic;
   signal shift_load_n      :     std_logic;
   
begin
     reset <=   '1' ,
                '0' after    4*period;        
     clk <= not (clk) after 1*period;
               
     D  <= "1001",                   
           "1110" after 26 * period;  
           
     shift_load_n  <= '1',                   
      '0' after 5 * period,   
      '1' after 7 * period, 
      '0' after 27 * period,
      '1' after 29* period; 
      
                  
     dut1:PISO
     port map(  
     reset        => reset        ,
     clk          => clk          ,
     D0           => D(0)           ,
     D1           => D(1)           ,
     D2           => D(2)           ,
     D3           => D(3)           ,
     shift_load_n => shift_load_n ,
     SO           => SO                 
     );
     

    

  

end Behavioral;
