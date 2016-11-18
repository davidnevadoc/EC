--Se incluyen las librerias necesarias.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Creacion de la entidad con las entradas y salidas necesarias.
entity P1e1 is
	port (
		A: in std_logic;
		B: in std_logic;
		C: in std_logic;
		Q: out std_logic);
end P1e1;

architecture Behavioral of P1e1 is
begin
--Se establece la relacion pedida entre las entradas y las salidas.
--No hay necesidad de utilizar ningún proceso ya que se trata de un circuito combinacional simple, es decir, 
--no necesita que sus instrucciones se ejecuten secuencialmente(básicamente porque solo hay una)
Q<= (A or B) and C;

end Behavioral;

