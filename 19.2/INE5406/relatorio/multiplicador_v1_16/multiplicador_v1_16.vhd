library ieee;
use ieee.std_logic_1164.all;

entity multiplicador_v1_16 is
  port(
    inicio, reset, clock: in std_logic;
    entA, entB: in std_logic_vector(15 downto 0);
    pronto: out std_logic;
    saida: out std_logic_vector(15 downto 0)
  );
end;

architecture behaviour of multiplicador_v1_16 is
  component bc is
  port(
    Reset, clk, inicio: IN STD_LOGIC; 
    Az, Bz: IN STD_LOGIC; 
    pronto: OUT STD_LOGIC; 
    ini, CA, dec, CP: OUT STD_LOGIC); 
  end component;
  
  component bo is
  port(
    clk: IN STD_LOGIC; 
    ini, CP, CA, dec: IN STD_LOGIC; 
    entA, entB: IN STD_LOGIC_VECTOR(15 DOWNTO 0); 
    Az, Bz: OUT STD_LOGIC; 
    saida, conteudoA, conteudoB: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)); 
  END component; 
  
  signal CP, CA, dec, Az, Bz, ini: std_logic;
  signal saiA, saiB: std_logic_vector(15 downto 0);
begin
  Datapath: bo port map(clk => clock, ini => ini, CP => CP, CA => CA, dec => dec, entA => entA, entB => entB, Az => Az, Bz => Bz, saida => saida, conteudoA => saiA, conteudoB => saiB);
  Control: bc port map(reset => reset, clk => clock, inicio => inicio, Az => Az, Bz => Bz, pronto => pronto, ini => ini, CA => CA, dec => dec, CP => CP);
end;