----------------------------------------------------------------------
-- Fichero: ALUMIPS.vhd
-- Descripción:
-- Fecha última modificación: 25/02/2015

-- Autores: David Nevado Catalán || David Moreno Maldonado
-- Asignatura: E.C. 1º grado
-- Grupo de Prácticas: 2102
-- Pareja: 04
-- Grupo de Teoría:
-- Práctica: 3
-- Ejercicio: 1
----------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all; 

entity ALUMIPS is
    Port ( Op1 : in  STD_LOGIC_VECTOR (31 downto 0); -- Primer operando de la ALU (de 32 bits)
           Op2 : in  STD_LOGIC_VECTOR (31 downto 0); -- Segundo operando de la ALU (de 32 bits)
           ALUControl : in  STD_LOGIC_VECTOR (2 downto 0); --Selector de la operacion de la ALU (3 bits)
           Res : out  STD_LOGIC_VECTOR (31 downto 0); -- Resultado de la operacion (32 bits)
           Z : out  STD_LOGIC); --Señal de estado, indica si el resultado es 0 (en ese  caso la señal es 1, en caso cotrario es 0) (1 bit)
end ALUMIPS;

architecture Practica3 of ALUMIPS is

signal slt, Resaux, Resta: STD_LOGIC_VECTOR(31 downto 0); --Señales auxiliares utilizadas para las operaciones mas "complejas"


begin

	Resta <= Op1 - Op2; --Iguala la señal auxiliar resta a la resta de los operandos

	-- Se iguala la señal auxiliar slt al resultado de la operacion slt. Esto se lleva a cabo cubriendo todos los posibles casos de Op1 y Op2 
	--es decir, (por orden) Op1 negativo y Op2 positivo, Op1 positivo y Op2 negativo, Op1 y Op2 del mismo signo. En  este ultimo caso se utilizada
	--la anteriormente asignada señal Resta para determinar cual de los 2 es mayor.
	slt <= x"00000001" when Op1(31)='1' and Op2(31)='0' else
			 x"00000000" when Op1(31)='0' and Op2(31)='1' else
			 x"00000000" when Op1=Op2 else
			 x"00000001" when Resta(31)='1' else
			 x"00000000";
			 
			 

	--Se iguala la señal Resaux (resultado auxiliar) al resultado de una de las operaciones, esto depende de la señal ALUControl, es decir el selector
	--de operacion. Cuando se introduce un selector de operacion no valido Resaux se iguala a 0.
	with ALUControl select
		Resaux <= Op1 + Op2 when "010",
					 Resta when "110",
					 Op1 or Op2 when "001",
					 Op1 xor Op2 when "011",
					 Op1 nor Op2 when "101",
					 slt when "111",
					 (others => '0') when others;
	--Damos a la salida Res el valor de la señal auxiliar Resaux			 
	Res<=Resaux;			 
	--Damos valor a la salida Z en funcion de la señal Resaux. Es por esta ultima asignacion por la que necesitamos la señal auxiliar Resaux, ya que sin ella
	--no podriamos leer el resultado de la operacion (este habria sido asignado a Res y, al ser una salida, no podriamos leerla)
	Z <= '1' when Resaux=x"00000000" else '0';	 

end Practica3;

