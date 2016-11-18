----------------------------------------------------------------------
-- Fichero: MicroSuma.vhd
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

entity MicroSuma is
	port (
		Clk : in std_logic; -- Reloj
		NRst : in std_logic; -- Reset activo a nivel bajo
		MemProgAddr : out std_logic_vector(31 downto 0); -- Dirección para la memoria de programa
		MemProgData : in std_logic_vector(31 downto 0) -- Código de operación
	);
end MicroSuma;

architecture Practica of MicroSuma is
	--Instanciacion de componentes necesarios
	component Regs port(
		Clk : in std_logic; -- Reloj
		NRst : in std_logic; -- Reset asíncrono a nivel bajo
		RtIn : in std_logic_vector(31 downto 0); -- Dato de entrada RT
		RtAddr : in std_logic_vector(4  downto 0); -- Dirección RT
		RsAddr : in std_logic_vector(4 downto 0); -- Dirección RS
		RsOut : out std_logic_vector(31 downto 0)-- Salida RS
		);
	end component;

	component ALUSuma port (
		Op1 : in std_logic_vector(31 downto 0); -- Operando
		Op2 : in std_logic_vector(31 downto 0); -- Operando
		Res : out std_logic_vector(31 downto 0) -- Resultado
		);
	end component;
	
	--Declaracion de señales auxiliares: 
										
	signal Op1s: std_logic_vector(31 downto 0);  --Conecta la salida del registro (reg) con la entrada de la ALU
	signal C: std_logic_vector(31 downto 0);	--Concecta la salida de la ALU con la entrada del registro (reg)
	signal MemProgAddraux: std_logic_vector(31 downto 0); --Auxiliar para realizar el contador

begin
	--Asignacion de los componentes
	ALU: ALUSuma 
	port map (
		Op1=>Op1s,
		Op2(31 downto 16)=>(others=>MemProgData(15)), --Extension de signo
		Op2(15 downto 0)=>MemProgData(15 downto 0),
		Res=>C);

	REG: Regs 
	port map (
		Clk=>Clk, 
		NRst=>NRst, 
		RtIn=>C,
		RtAddr=>MemProgData(20 downto 16),
		RsAddr=>MemProgData(25 downto 21),
		RsOut=>Op1s);	

	MemProgAddr<=MemProgAddraux;
	--Proceso del contador(Suma 4 con cada ciclo)	
	process (Clk, NRst)
	begin
		if NRst='0' then--Reset asincrono a nivel bajo (se pone todo a 0)
			MemProgAddraux <= (others => '0');
		elsif rising_edge(Clk) then
			MemProgAddraux <= MemProgAddraux + X"00000004";--Sumar 4 cada ciclo de reloj
		end if;	
	end process;

end Practica;

