library IEEE;
use IEEE.std_logic_1164.all;

entity TB_Counter_generic_n is
	generic(
	n	: integer := 6                                    --Higher hierarchy than generic main 
	);
end TB_Counter_generic_n;

architecture TestBench of TB_Counter_generic_n is

component Counter_generic_n
	generic(
	n	: integer := 4
	);
	port(
		RST	:	in	std_logic;
		CLK	:	in	std_logic;
		OPT	:	in 	std_logic_vector(1   downto 0);
		Q	  :	out std_logic_vector(n-1 downto 0)
	);
end component;

signal	RST, CLK	:	  std_logic;
signal 	OPT			  :	  std_logic_vector(1   downto 0);
signal	Q		    	: 	std_logic_vector(n-1 downto 0);

begin	
	
	DUT: Counter_generic_n generic map(n) port map(RST,CLK,OPC,Q);
	
	RESET: process
	begin
		RST <= '0';
		wait for 110 ns;
		RST <= '1';
		wait;
	end process RESET; 
	
	CLOCK: process
	begin
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
	end process CLOCK;
	
	MODE: process
	begin 
		OPT <= "01";
		wait for 2000 ns;
		OPT <= "00";
		wait for 60 ns;
		OPT <= "11";
		wait for 20 ns;
		OPT <= "10";
		wait;
	end process MODE;
	
end TestBench;
