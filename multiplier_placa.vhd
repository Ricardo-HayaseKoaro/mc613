library ieee;
use ieee.std_logic_1164.all;

entity multiplier_placa is
	GENERIC ( N : INTEGER := 4) ;
port(
    clock_100Mhz : in STD_LOGIC       :in  std_logic;                          
    KEY(0)     :in  std_logic;                          
    SW(9..5)  :in  std_logic_vector(N-1 downto 0);  	 
    SW(4..0)  :in  std_logic_vector(N-1 downto 0);     
    r         :out std_logic_vector(2*N-1 downto 0));    
end multiplier_placa;

architecture behavior of multiplier_placa is
signal aux_result : std_logic_vector(2*N-1 downto 0) := (others => '0');
signal aux_a_sum: std_logic_vector(N-1 downto 0);
signal a_shifted : std_logic_vector(N-1 downto 0);
signal b_shifted :  std_logic_vector(N-1 downto 0); 	
signal lsb_b : std_logic;
signal carry_in: std_logic;
signal mode_shift_a : STD_LOGIC_VECTOR(1 DOWNTO 0)  := (others => '0');
signal mode_shift_b: STD_LOGIC_VECTOR(1 DOWNTO 0)  := (others => '0');
begin
	shift_a: entity work.shift_register_multi port map (a => SW(9..5), clk => clock_100Mhz, mode => mode_shift_a, r => a_shifted); -- shifta todo tik do clock
	shift_b: entity work.shift_register_multi port map (a => SW(4..0), clk => clock_100Mhz, mode => mode_shift_b, r => b_shifted); 
	
	add: entity work.ripple_carry port map (e => aux_result, f => SW(9..5), carry_in => carry_in, S => aux_result, carry_out => carry_in); -- soma a cada tick do clock
	
	r <= aux_result;
	
	
	
	process
	begin
		WAIT UNTIL clock_100Mhz'EVENT AND clock_100Mhz = '1' ;
		if KEY(0) = '1' then -- resetS
			aux_result <= (others => '0');
			mode_shift_a <= "11";
			mode_shift_b <= "11";
		end if;
		lsb_b <= SW(0); -- atribui novo valor a cada tick do clock
		if lsb_b = '1' then -- add r + a 
			aux_a_sum <= SW(9..5);
			mode_shift_a <= "01";
			mode_shift_b <= "10";
		elsif lsb_b = '0' then -- add r + 0
			aux_a_sum <= (others => '0');
			mode_shift_a <= "01";
			mode_shift_b <= "10";
		end if;
	end process;
		
end behavior;