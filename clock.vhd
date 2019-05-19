library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity clock is
  port (
    clk : in std_logic;
    decimal : in std_logic_vector(3 downto 0);
    unity : in std_logic_vector(3 downto 0);
    set_hour : in std_logic;
    set_minute : in std_logic;
    set_second : in std_logic;
    hour_dec, hour_un : out std_logic_vector(6 downto 0);
    min_dec, min_un : out std_logic_vector(6 downto 0);
    sec_dec, sec_un : out std_logic_vector(6 downto 0)
  );
end clock;

architecture rtl of clock is
  component clk_div is
    port (
      clk : in std_logic;
      clk_hz : out std_logic
    );
  end component;
  
  component bin2hex is
    port (
		bin: in std_logic_vector(3 downto 0);
		hex: out std_logic_vector(6 downto 0)
	 );
  end component;
  
  signal clk_hz : std_logic; -- 1Hz clock
  signal sec,min,hour : integer range 0 to 60 :=0; -- counters
  
  signal hour_dec_bin: std_logic_vector(3 downto 0); 
  signal hour_unit_bin: std_logic_vector(3 downto 0);
  signal min_dec_bin: std_logic_vector(3 downto 0);
  signal min_unit_bin: std_logic_vector(3 downto 0);
  signal sec_dec_bin: std_logic_vector(3 downto 0);
  signal sec_unit_bin: std_logic_vector(3 downto 0);
  
  signal aux_dec,aux_un : integer range 0 to 60 :=0; 
  
	
begin
	-- create a 1Hz clock
	clock_divider : clk_div port map (clk, clk_hz);
	
	
	-- digital clock
	
	-- set hour, min and second
	process(clk,set_hour, set_minute, set_second, decimal, unity) begin 
		aux_dec <= to_integer(unsigned(decimal))*10;
		aux_un <= to_integer(unsigned(unity));
	if(set_hour = '1') and (aux_dec <= 2) and (aux_un <=9) then
		hour <= aux_dec + aux_un;
	elsif (set_minute = '1') and (aux_dec <= 5) and (aux_un <=9)  then
		min <= aux_dec + aux_un;
	elsif (set_second = '1')  and (aux_dec <= 5) and (aux_un <=9)  then 
		sec <= aux_dec + aux_un;
	end if;
	end process;
	
	-- counter
	process(clk_hz) 
	begin 
		if(rising_edge(clk_hz)) then
			sec <= sec + 1;
			if(sec >=59) then 
				min <= min + 1;
				sec <= 0;
			if(min >=59) then 
				min <= 0;
				hour <= hour + 1;
			if(hour >= 24) then 
				hour <= 0;
			end if;
			end if;
			end if;
		end if;
	end process;
	
	-- convert to bcd and show in 7 seg led
	
	 
	hour_dec_bin <= "0010" when hour >=20 else
						 "0001" when hour >=10 else
						 "0000";
						 
	hour_unit_bin <= std_logic_vector(to_unsigned((hour - to_integer(unsigned(hour_dec_bin))*10),4));				 
					
	min_dec_bin <= "1001" when min >=50 else
						"1000" when min >=40 else
						"0011" when min >=30 else
						"0010" when min >=20 else
						"0001" when min >=10 else
						"0000";
		
	min_unit_bin <= std_logic_vector(to_unsigned((min - to_integer(unsigned(min_dec_bin))*10),4));
	
	sec_dec_bin <= "1001" when min >=50 else
						"1000" when min >=40 else
						"0011" when min >=30 else
						"0010" when min >=20 else
						"0001" when min >=10 else
						"0000";
						
	sec_unit_bin <= std_logic_vector(to_unsigned((sec - to_integer(unsigned(sec_dec_bin))*10),4));
	
	-- show 7segs LED
	 
	convert_hour_dec_hex: bin2hex port map (bin => hour_dec_bin, hex => hour_dec); 
	
	convert_hour_unit_bin: bin2hex port map (bin => hour_unit_bin, hex => hour_un); 
	
	convert_min_dec_bin: bin2hex port map (bin => min_dec_bin, hex => min_dec); 
	
	convert_min_unit_bin: bin2hex port map (bin => min_unit_bin, hex => min_un); 
	
	convert_sec_dec_bin: bin2hex port map (bin => sec_dec_bin, hex => min_dec); 
	
	convert_sec_unit_bin: bin2hex port map (bin => sec_unit_bin, hex => sec_un); 
	
	
  
end rtl;