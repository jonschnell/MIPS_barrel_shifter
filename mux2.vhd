library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2 is
    Port ( SEL : in  STD_LOGIC;
           A   : in  STD_LOGIC;
           B   : in  STD_LOGIC;
           O   : out STD_LOGIC);
end mux2;

architecture Behavioral of mux2 is
begin
    O <= A when (SEL = '0') else B;
end Behavioral;