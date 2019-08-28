LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity somador_monociclo is
	port(
		A, B, C, D : in std_logic_vector(7 downto 0);
		clk : in std_logic;
		S : out std_logic_vector(9 downto 0)
	);
end somador_monociclo;

architecture arch_somador_monociclo of somador_monociclo is

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
			Y : out std_logic_vector(N-1 downto 0);
			clk : in std_logic;
			enable: in std_logic
		);
	end component;

	--##########################################
	-- Adicione os fios utilizados na arquitetura
	-- ex:
	--
	-- signal ??? : std_logic_vector(X downto Y);
	-- ...
	-- signal ??? : std_logic;
	-- ...
	--##########################################
	signal outA, outB, outC, outD : std_logic_vector(7 downto 0);
	signal parcAB, parcCD : std_logic_vector(7 downto 0);
	signal parc9AB, parc9CD : std_logic_vector(8 downto 0);
	signal parcABCD : std_logic_vector(8 downto 0); 
	signal parc10ABCD : std_logic_vector(9 downto 0); 
	signal coutAB, coutCD, coutABCD : std_logic;
	signal enable : std_logic;
begin
	enable <= '1';
	
	regA : registrador generic map(N => 8) port map (X => A, clk => clk, Y => outA, enable => enable);
	regB : registrador generic map(N => 8) port map (X => B, clk => clk, Y => outB, enable => enable);
	regC : registrador generic map(N => 8) port map (X => C, clk => clk, Y => outC, enable => enable);
	regD : registrador generic map(N => 8) port map (X => D, clk => clk, Y => outD, enable => enable);
	
	somaAB : somador generic map (N => 8) port map (X1 => outA, X2 => outB, Y => parcAB, cout => coutAB);
	somaCD : somador generic map (N => 8) port map (X1 => outC, X2 => outD, Y => parcCD, cout => coutCD);
	parc9AB	<= coutAB & parcAB;
	parc9CD	<= coutCD & parcCD;
	
	somaABCD : somador generic map (N => 9) port map (X1 => parc9AB, X2 => parc9CD, Y => parcABCD, cout => coutABCD);
	parc10ABCD <= coutABCD & parcABCD;
	
	regTotal : registrador generic map(N => 10) port map(X => parc10ABCD, clk => clk, Y => S, enable => enable);
end arch_somador_monociclo;
