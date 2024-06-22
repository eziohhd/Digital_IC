library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PISO is
   port ( reset         : in  std_logic;
          clk           : in  std_logic;
          D0            : in  std_logic;
          D1            : in  std_logic;
          D2            : in  std_logic;
          D3            : in  std_logic;
          shift_load_n  : in  std_logic;
          SO            : out std_logic --serial out
        );
end PISO;

architecture Behavioral of PISO is

component FF is
       port ( D  :  in std_logic;
              Q  : out std_logic;
              clk  :  in std_logic;
              reset:  in std_logic
        );
end component;

signal  Q0:std_logic;
signal  Q1:std_logic;
signal  Q2:std_logic;
signal  FF0_in:std_logic;
signal  FF1_in:std_logic;
signal  FF2_in:std_logic;
signal  FF3_in:std_logic;
signal  shift_load_n_inv:std_logic;

begin
shift_load_n_inv <= not shift_load_n;
FF0_in <= D0 and shift_load_n_inv;
FF1_in <= (Q0 and shift_load_n) or (D1 and shift_load_n_inv);
FF2_in <= (Q1 and shift_load_n) or (D2 and shift_load_n_inv);
FF3_in <= (Q2 and shift_load_n) or (D3 and shift_load_n_inv);
FF0: FF
port map(
    D => FF0_in,
    Q => Q0,
    clk => clk,
    reset => reset
);

FF1: FF
port map(
    D => FF1_in,
    Q => Q1,
    clk => clk,
    reset => reset
);

FF2: FF
port map(
    D => FF2_in,
    Q => Q2,
    clk => clk,
    reset => reset
);

FF3: FF
port map(
    D => FF3_in,
    Q => SO,
    clk => clk,
    reset => reset
);

end Behavioral;
