library ieee;
use ieee.std_logic_1164.all;

entity adder is
Port ( x : in STD_LOGIC;
y : in STD_LOGIC;
cin : in STD_LOGIC;
sum : out STD_LOGIC;
P : out STD_LOGIC;
G : out STD_LOGIC);
end adder;

architecture behavior of adder is

begin

sum <= x xor y xor cin;
P <= x xor y;
G <= x and y;

end behavior;