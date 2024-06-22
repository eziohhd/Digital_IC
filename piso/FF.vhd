library IEEE;
  use IEEE.std_logic_1164.all;


entity FF is
  port(   D  :  in std_logic;
          Q  : out std_logic;
        clk  :  in std_logic;
        reset:  in std_logic
      );
end FF;


architecture rtl of FF is
begin
process(clk,reset)
    begin
        if rising_edge(clk) then
            if reset='1' then
                Q <= '1';
            else 
                Q <= D;
            end if;
        end if;
    end process;
end rtl;