library ieee;
use ieee.std_logic_1164.all;

entity control is
	GENERIC ( N : INTEGER := 8 ) ;
port(
    CLK       :in  std_logic;                      -- System Clock
    RES       :in  std_logic;                      -- Synchronous reset
    OPCODE    :in  std_logic_vector(2 downto 0);   -- Logic Unit Opcode
    A         :in  std_logic_vector(7 downto 0);   -- A input bus
    B         :in  std_logic_vector(7 downto 0);   -- B input bus
    Q         :out std_logic_vector(7 downto 0));  -- Q output from Logic Unit     
end control;

architecture behavioral of control is
begin


    

end behavioral;