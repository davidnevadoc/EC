----------------------------------------------------------------------
-- Fichero: ALUSuma.vhd
-- Descripción: 
-- Fecha última modificación: 18/02/2015

-- Autores: David Nevado Catalán || David Moreno Maldonado
-- Asignatura: E.C. 1º grado
-- Grupo de Prácticas: 2102
-- Grupo de Teoría:
-- Práctica: 2
-- Ejercicio: 2
----------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_LOGIC_arith.ALL;
use IEEE.std_logic_unsigned.ALL;

entity ALUSuma is
	port (
		Op1 : in std_logic_vector(31 downto 0); -- Operando
		Op2 : in std_logic_vector(31 downto 0); -- Operando
		Res : out std_logic_vector(31 downto 0) -- Resultado
	);
end ALUSuma;

architecture Simple of ALUSuma is

	begin
	--Se suman los dos operandos y se hace que salga el resultado por Res.
	Res<=Op1+Op2;

end Simple;

