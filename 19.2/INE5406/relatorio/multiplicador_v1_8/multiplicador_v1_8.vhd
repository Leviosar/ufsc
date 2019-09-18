LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY multiplicador_v1_4 IS
    PORT (
        clk, rst, start : IN STD_LOGIC;
        entA, entB : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        ready : OUT STD_LOGIC;
        saida : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END multiplicador_v1_4;

ARCHITECTURE top_level OF multiplicador_v1_4 IS

    SIGNAL conteudoA, conteudoB: STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL CA, CP, dec, Az, Bz, ini: STD_LOGIC;

    COMPONENT bo IS 
        PORT (
            ini, CP, CA, dec : IN STD_LOGIC;
            entA, entB : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            Az, Bz : OUT STD_LOGIC;
            saida, conteudoA, conteudoB : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT bc IS
        PORT (
            Reset, clk, inicio : IN STD_LOGIC;
            Az, Bz : IN STD_LOGIC;
            pronto : OUT STD_LOGIC;
            ini, CA, dec, CP: OUT STD_LOGIC
        );
    END COMPONENT;

BEGIN

    Datapath: bo port map(start, CP, CA, dec, entA, entB, aZ, bZ, saida, conteudoA, conteudoB);
    Controle: bc port map(rst, clk, start, Az, Bz, ready, ini, CA, dec, CP);

END top_level;