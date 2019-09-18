LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity somador_multiciclo is
	port(
		A, X: in std_logic_vector(7 downto 0);
		clk, sel : in std_logic;
		S : out std_logic_vector(7 downto 0);
		overflow : out std_logic
	);
end somador_multiciclo;

architecture arch_somador_multiciclo of somador_multiciclo is

	component somador
		generic(N : integer);
		port(
			X1, X2 : in  std_logic_vector(N-1 downto 0);
			Y : out std_logic_vector(N-1 downto 0);
			cout : out std_logic
		);
	end component;

	component registrador
		generic(N : integer);
		port(
			X : in std_logic_vector(N-1 downto 0);
			clk : in std_logic;
			Y : out std_logic_vector(N-1 downto 0)
		);
	end component;
	
	component mux2x1
	generic(N : integer);
	port(
		X0, X1 : in std_logic_vector(N-1 downto 0);
		sel : in std_logic;
		Y : out std_logic_vector(N-1 downto 0)
	);
	end component;
	
	signal inX, muxR1, r1som, r2som, somaMux : std_logic_vector(7 downto 0);

	begin
	  enable <= '1'
	
	  mux : mux2x1(sel => sel, X0 => S, X1 => A);
	  r1 : registrador generic map(N => 8) port map (X => muxR1, clk => clk, Y => r1som, enable => enable);
	  r2 : registrador generic map(N => 8) port map (X => inX, clk => clk, Y => r2som, enable => enable);
	  soma : somador generic map (N => 8) port map (X1 => r1som, X2 => r2som, Y => somMux, cout => overflow);

end arch_somador_multiciclo;
