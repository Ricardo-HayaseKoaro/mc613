library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity clk_div is
  port (
    clk : in std_logic;
    clk_hz : out std_logic
  );
end clk_div;

architecture behavioral of clk_div is
signal count: integer :=1;
begin
	process(clk)
	begin
		if(clk'event and clk='1') then
			count <=count+1;
		if(count = 50000000) then
			count <=1;
		end if;
		end if;
	end process;
	clk_hz <= '0' when count < 50000000 else '1';
end behavioral;
