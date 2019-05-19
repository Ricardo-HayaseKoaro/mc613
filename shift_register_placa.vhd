LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY shift_register_placa IS
	GENERIC ( N : INTEGER := 6 ) ;
	
	PORT ( 
		SW(5 .. 0) : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
		KEY(0) : IN STD_LOGIC ; trocar para sw(9) ;
		SW(6): IN STD_LOGIC;
		SW(8 .. 7): IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		aux : BUFFER STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		LED : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
		
	) ;
	


END shift_register_placa ;

ARCHITECTURE Behavior OF shift_register_placa IS
BEGIN
	PROCESS
	BEGIN
		WAIT UNTIL KEY(0)'EVENT AND KEY(0) = '1' ;
		IF (SW(8 DOWNTO 7) = "11") THEN 
			aux <= SW(5 DOWNTO 0) ;
			LED <= aux;
		ELSIF (SW(8 DOWNTO 7) = "10") THEN 
			shift_r: FOR i IN 0 TO N-2 LOOP
				aux(i) <= aux(i+1) ;
			END LOOP ;
			aux(N-1) <= SW(6) ;
			LED <= aux;
		ELSIF (SW(8 DOWNTO 7) = "01") THEN
			shift_l: FOR i IN N-1 DOWNTO 1 LOOP
				aux(i) <= aux(i-1) ;
			END LOOP ;
			aux(0) <= SW(6) ;
			LED <= aux;
		END IF ;
	END PROCESS ;
END Behavior ;