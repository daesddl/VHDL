library IEEE;			

use IEEE.STD_LOGIC_1164.all;											
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity NEURAL_MOTION_HEX is 

PORT
(	  
  CLK  : in STD_LOGIC;
	Vout : out STD_LOGIC_VECTOR(11 downto 0) := x"999"
);	  

end NEURAL_MOTION_HEX;

architecture LOGIC of NEURAL_MOTION_HEX is	  		

signal PULSE : STD_LOGIC := '0';

type ArrayW        is array(0 to 11,0 to 11) of std_logic_vector(7 downto 0);		

type Array8b       is array(0 to 11)         of std_logic_vector(7 downto 0);	

signal W: ArrayW       :=((x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"40",x"00",x"00"),
	                  (x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"40",x"00"),
 	                  (x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"40"),
	                  (x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"40",x"00",x"00",x"00"),
	                  (x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"40",x"00",x"00"),
	                  (x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"40",x"00"),
 	                  (x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"40"),
	                  (x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"40",x"00",x"00",x"00"),
	                  (x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"40",x"00",x"00"),
	                  (x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"40",x"00"),
 	                  (x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"40"),
	                  (x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"40",x"00",x"00",x"00"));

signal V	: Array8b  := (x"40",x"00",x"00",x"40",x"40",x"00",x"00",x"40",x"40",x"00",x"00",x"40");
signal Vo	: Array8b;

signal Gamma : STD_LOGIC_VECTOR(7 downto 0):=x"20"; 	 			-- Gamma Constant 0.53125
signal Theta : STD_LOGIC_VECTOR(7 downto 0):=x"20"; 	 			-- Theta Constant 0.125 

signal COUNT : integer := 1;
  
signal i     : integer := 0;
begin	  
	
process (CLK) 	  								 -- FREQUENCY DIVISOR a 3Hz  F=(50MHz/3Hz)/2 = 8333334
	begin
        if (CLK'event and CLK = '1') then
            COUNT <= count +1;
            
		if (count = 5) then
                	PULSE <= NOT(PULSE);
                	COUNT <= 1;
        	end if;
        end if;
 end process;

process(PULSE,i)
begin
	if(PULSE'event and PULSE = '1')then
		if(i = 12)then						
			i<=0;
				for j in 0 to 11 loop
					V(j) <= Vo(j);
					if(Vo(j) = x"40")then
						Vout(j) <= '1';
					else
						Vout(j) <= '0';
					end if;
				end loop;
		else
			if(PULSE'event and PULSE = '1')then
				if(V(i)>= Theta)then
					Vo(i) <= x"00";
					for j in 0 to 11 loop
						if(V(j) >= Theta and W(i,j) = x"40") then
							Vo(i) <= x"40";
			      end if;
						if(j = 11)then
							i <= i + 1;
						end if;
					end loop;
				elsif(V(i) < Theta)then
					Vo(i) <= x"00";
					for j in 0 to 11 loop					 
						if(V(j) >= Theta and W(i,j) = x"40")then
							Vo(i) <= x"40";
						end if;
						if(j = 11)then
							i <= i + 1;
						end if;
					end loop;
				end if;
			end if;
		end if;	
	end if;
end process;

end architecture;
