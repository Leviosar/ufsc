LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity mux2x1 is
	generic(N : integer := 8);
	port(
		X0, X1 : in std_logic_vector(N-1 downto 0);
		sel : in std_logic;
		Y : out std_logic_vector(N-1 downto 0)
	);
end mux2x1;

architecture arch_mux2x1 of mux2x1 is
begin
	
	WITH sel SELECT
	Y <= X0 WHEN '0',
	X1 WHEN OTHERS;
	
end arch_mux2x1;