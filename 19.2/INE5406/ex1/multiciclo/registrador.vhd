LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity registrador is
	generic(N : integer := 8);
	port(
		X : in std_logic_vector(N-1 downto 0);
		Y : out std_logic_vector(N-1 downto 0);
		clk : in std_logic;
		enable: in std_logic
	);
end registrador;

architecture arch_registrador of registrador is
begin
	 process (clk)
	 begin
		if (rising_edge(clk)) then
			if (enable = '1') then
				Y <= X;
			end if;
		end if;
	 end process;
end arch_registrador;
