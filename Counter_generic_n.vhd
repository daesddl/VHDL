library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity Counter_generic_n is
	generic(
		n : integer := 4
	);
	port(
		RST	:	in	std_logic;
		CLK	:	in	std_logic;
		OPT	:	in 	std_logic_vector(1   downto 0);
		Q	:	out     std_logic_vector(n-1 downto 0)
	);
end Counter_generic_n;

architecture Moore of Counter_generic_n is

signal Qn, Qp	: std_logic_vector(n-1 downto 0);

begin

	sec: process(RST,CLK)
	begin
		if(RST='0') then
			Qp <= (others => '0');
		elsif(CLK'event and CLK='1') then
			Qp <= Qn;
		end if;
		end process sec;
		
	comb: process(OPT,Qp)
	begin
		case OPT is
			when "00"   => Qn <= Qp;		--Hold
			when "01"   => Qn <= Qp + 1;		--Increase
			when "10"   => Qn <= Qp - 1;		--Decrease
			when others => Qn <= (others => '0');	--Internal Clean   
		end case;
		Q <= Qp;
	end process comb;
	
end Moore;
