LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux IS
	GENERIC (N: INTEGER := 8);
	PORT ( sel: IN STD_LOGIC;
	a, b : IN STD_LOGIC_VECTOR (N-1 DOWNTO 0);
	y : OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0));
END mux;

ARCHITECTURE comportamento OF mux IS
BEGIN
	WITH sel SELECT
	y <= a WHEN '0',
	b WHEN OTHERS;
END comportamento;