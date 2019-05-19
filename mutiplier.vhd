library ieee;
use ieee.std_logic_1164.all;

entity multiplier is
	GENERIC ( N : INTEGER := 4) ;
port(
    clk       :in  std_logic;                          
    set       :in  std_logic;                          
    a         :in  std_logic_vector(N-1 downto 0);  	 
    b         :in  std_logic_vector(N-1 downto 0);     
    r         :out std_logic_vector(2*N-1 downto 0));    
end multiplier;

architecture behavior of multiplier is
signal aux_result : std_logic_vector(2*N-1 downto 0) := (others => '0');
signal aux_a_sum: std_logic_vector(N-1 downto 0);
signal a_shifted : std_logic_vector(N-1 downto 0);
signal b_shifted :  std_logic_vector(N-1 downto 0); 	
signal lsb_b : std_logic;
signal carry_in: std_logic;
signal mode_shift_a : STD_LOGIC_VECTOR(1 DOWNTO 0)  := (others => '0');
signal mode_shift_b: STD_LOGIC_VECTOR(1 DOWNTO 0)  := (others => '0');
begin
	shift_a: entity work.shift_register_multi port map (a => a, clk => clk, mode => mode_shift_a, r => a_shifted); -- shifta todo tik do clock
	shift_b: entity work.shift_register_multi port map (a => b, clk => clk, mode => mode_shift_b, r => b_shifted); 
	
	add: entity work.ripple_carry port map (e => aux_result, f => a,carry_in => carry_in, S => aux_result, carry_out => carry_in); -- soma a cada tick do clock
	
	r <= aux_result;
	
	process
	begin
		WAIT UNTIL clk'EVENT AND clk = '1' ;
		if set = '1' then -- resetS
			aux_result <= (others => '0');
			mode_shift_a <= "11";
			mode_shift_b <= "11";
		end if;
		lsb_b <= b(0); -- atribui novo valor a cada tick do clock
		if lsb_b = '1' then -- add r + a 
			aux_a_sum <= a;
			mode_shift_a <= "01";
			mode_shift_b <= "10";
		elsif lsb_b = '0' then -- add r + 0
			aux_a_sum <= (others => '0');
			mode_shift_a <= "01";
			mode_shift_b <= "10";
		end if;
	end process;
		
end behavior;