LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY somador4bits IS
	GENERIC (N : INTEGER := 4);
	PORT ( a, b : IN STD_LOGIC_VECTOR (N-1 DOWNTO 0);
	sel: IN STD_LOGIC;	
	s : OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0));
END somador4bits;

ARCHITECTURE comportamento OF somador4bits IS
BEGIN
	s <= std_logic_vector(signed(a) + signed(b)) WHEN SEL = '0' ELSE std_logic_vector(signed(a) - signed(b));
END comportamento;