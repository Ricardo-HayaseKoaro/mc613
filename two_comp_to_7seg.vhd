library ieee;
use ieee.std_logic_1164.all;

entity two_comp_to_7seg is
  port (
    bin : in std_logic_vector(3 downto 0);
    segs : out std_logic_vector(6 downto 0);
    neg : out std_logic
  );
end two_comp_to_7seg;

architecture behavioral of two_comp_to_7seg is
begin
  -- add your code
  WITH bin SELECT
			segs <= "1000000" WHEN "0000", 
					 "1111001" WHEN "0001",
					 "0100100" WHEN "0010",
					 "0110000" WHEN "0011",
					 "0011001" WHEN "0100",
					 "0010010" WHEN "0101",
					 "0000010" WHEN "0110",
					 "1111000" WHEN "0111",
					 -- negastivos
					 "0000000" WHEN "1000", 
					 "1111000" WHEN "1001", 
					 "0000010" WHEN "1010", 
					 "0010010" WHEN "1011", 
					 "0011001" WHEN "1100",
					 "0110000" WHEN "1101",
					 "0100100" WHEN "1110",
					 "1111001" WHEN "1111";
					 
	WITH bin select
			neg <= '0' WHEN "0000", 
					 '0' WHEN "0001",
					 '0' WHEN "0010",
					 '0' WHEN "0011",
					 '0' WHEN "0100",
					 '0' WHEN "0101",
					 '0' WHEN "0110",
					 '0' WHEN "0111",
					 '1' when others;
  
  
end behavioral;
