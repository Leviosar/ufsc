LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity somador is
	generic(N : integer := 8);
	port(
		X1, X2 : in  std_logic_vector(N-1 downto 0);
		Y : out std_logic_vector(N-1 downto 0);
		cout : out std_logic
	);
end somador;

architecture arch_somador of somador is
	signal w_X1, w_X2, w_sum : std_logic_vector(N downto 0);

begin
	w_X1 <= '0' & X1;
	w_X2 <= '0' & X2;
	w_sum <= w_X1 + w_X2;
	Y <= w_sum(N-1 downto 0);
	cout <= w_sum(N);
end arch_somador;

