LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY maquina_refri IS
PORT (Reset, clk, c : IN STD_LOGIC;
s, a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
d : OUT STD_LOGIC);
END maquina_refri;

ARCHITECTURE estrutura OF maquina_refri IS

	COMPONENT bo IS
	PORT (clk, Ctotal, Rtotal : IN STD_LOGIC;
	s, a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	menor : OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT bc IS
	PORT (Reset, clk, c, menor : IN STD_LOGIC;
	d, Ctotal, Rtotal : OUT STD_LOGIC);
	END COMPONENT;

	SIGNAL Ctotal, Rtotal, menor : STD_LOGIC;

BEGIN
	b_operativo: bo PORT MAP (clk, Ctotal, Rtotal, s, a, menor);
	b_controle: bc PORT MAP (Reset, clk, c, menor, d, Ctotal, Rtotal);
END estrutura;