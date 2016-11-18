----------------------------------------------------------------------
-- Fichero: Regs.vhd
-- Descripción: 
-- Fecha última modificación: 18/02/2015

-- Autores: David Nevado Catalán || David Moreno Maldonado
-- Asignatura: E.C. 1º grado
-- Grupo de Prácticas: 2102
-- Grupo de Teoría:
-- Práctica: 2
-- Ejercicio: 1
----------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity Regs is
	port (
		Clk : in std_logic; -- Reloj
		NRst : in std_logic; -- Reset asíncrono a nivel bajo
		RtIn : in std_logic_vector(31 downto 0); -- Dato de entrada RT
		RtAddr : in std_logic_vector(4  downto 0); -- Dirección RT
		RsAddr : in std_logic_vector(4 downto 0); -- Dirección RS
		RsOut : out std_logic_vector(31 downto 0) -- Salida RS
	); 
end Regs;

architecture Practica of Regs is

	-- Tipo para almacenar los registros
	type regs_t is array (0 to 31) of std_logic_vector(31 downto 0);

	-- Esta es la señal que contiene los registros. El acceso es de la
	-- siguiente manera: regs(i) acceso al registro i, donde i es
	-- un entero. Para convertir del tipo std_logic_vector a entero se
	-- hace de la siguiente manera: conv_integer(slv), donde
	-- slv es un elemento de tipo std_logic_vector

	-- Registros inicializados a '0' 
	-- NOTA: no cambie el nombre de esta señal.
	signal regs : regs_t;

begin  -- PRACTICA	
	------------------------------------------------------
	-- Escritura del registro RT
	------------------------------------------------------
	process(NRst, Clk)
	begin
	--Reset asincrono a nivel bajo (pone todo a 0)
	if NRst='0' then
		for i in 0 to 31 loop
			regs(i)<= (others => '0');
		end loop;
		elsif rising_edge(Clk) then
			if RtAddr/="00000" then --Control de que no se escriba en la direccion 0
				regs(conv_integer(RtAddr)) <= RtIn;--Escritura sincrona en la direccion indicada por RtAddr
			end if;
	end if;
	end process;
	
	------------------------------------------------------
	-- Lectura del registro RS
	------------------------------------------------------
	--La lectura es asincrona y se lee la direccion indicada por RsAddr
	RsOut <= regs(conv_integer(RsAddr));
	
end Practica;

