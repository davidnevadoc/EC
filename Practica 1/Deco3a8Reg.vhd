--Se incluyen las librerias necesarias.
library IEEE;
use IEEE.std_logic_1164.ALL;

--Creacion de la entidad del decodificador con registro con sus entradas y salidas.
entity Deco3a8Reg is
	port (
	D : in  std_logic_vector (2 downto 0);
	Reset : in  std_logic;
	Clk : in  std_logic;
	Ce : in  std_logic;
	Q : out  std_logic_vector (7 downto 0)
	);
end Deco3a8Reg;

architecture Practica of Deco3a8Reg is
--Declaramos una señal intermedia (E) que se utilizara para pasar los valores desde el decodificador al registro,
--sera por tanto un bus de 8 bits.

signal E: std_logic_vector (7 downto 0);
--Utilizaremos 2 procesos
begin
--1er Proceso: 
--En este proceso definimos nuestro decodificador 3 a 8. La lista de sensibilidad solo contiene la señal D, ya 
--entrada del decodificador (el parametro del case).
process (D)
	begin
		case D is
			when "000" => E <= "00000001";
			when "001" => E <= "00000010";
			when "010" => E <= "00000100";
			when "011" => E <= "00001000";
			when "100" => E <= "00010000";
			when "101" => E <= "00100000";
			when "110" => E <= "01000000";
			when others => E <= "10000000";
		end case;
	end process;
--2º Proceso:
--En este proceso definimos el registro, que toma como entradas las salidas del decodificador (E). Su lista de 
--sensibilidad contiene clk(el reloj), y Reset (ya que es sincrono).
--El registro simplemente asigna a Q los valores de E cada vez que llega un flanco de subida, siempre y cuando
--este activado el chip enable (ce) y el reset no este activo.
process (Clk, Reset)
	begin
		if Reset = '1' then
			Q <= (OTHERS => '0');
		elsif rising_edge (Clk) then
			if Ce = '1' then
				Q <= E;
			end if;
		end if;
	end process;

end Practica;

