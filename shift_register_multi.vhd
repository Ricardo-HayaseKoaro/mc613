LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY shift_register_multi IS
	GENERIC ( N : INTEGER := 4 ) ;
	
	PORT ( 
		a : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
		clk : IN STD_LOGIC ;
		mode: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		r : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
	) ;
END shift_register_multi ;

ARCHITECTURE Behavior OF shift_register_multi IS
signal aux: STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
BEGIN
	PROCESS
	BEGIN
		WAIT UNTIL clk'EVENT AND clk = '1' ;
		IF (mode = "11") THEN 
			aux <= par_in ;
			par_out <= aux;
		ELSIF (mode = "10") THEN 
			shift_r: FOR i IN 0 TO N-2 LOOP
				aux(i) <= aux(i+1) ;
			END LOOP ;
			aux(N-1) <= '0';
			par_out <= aux;
		ELSIF (mode = "01") THEN
			shift_l: FOR i IN N-1 DOWNTO 1 LOOP
				aux(i) <= aux(i-1) ;
			END LOOP ;
			aux(0) <= '0' ;
			par_out <= aux;
		END IF ;
	END PROCESS ;
END Behavior ;