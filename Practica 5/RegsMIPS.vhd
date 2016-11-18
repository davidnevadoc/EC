----------------------------------------------------------------------
-- Fichero: RegsMIPS.vhd
-- Descripción:
-- Fecha última modificación: 25/02/2015

-- Autores: David Nevado Catalán || David Moreno Maldonado
-- Asignatura: E.C. 1º grado
-- Grupo de Prácticas: 2102
-- Grupo de Teoría:
-- Práctica: 3
-- Ejercicio: 2
----------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity RegsMIPS is
    port (
        Clk : in std_logic; -- Reloj
        NRst, We3 : in std_logic;
        Wd3 : in std_logic_vector(31 downto 0);
        A1, A2, A3 : in std_logic_vector(4 downto 0);
        Rd1, Rd2 : out std_logic_vector(31 downto 0) 
    );
end RegsMIPS;

architecture Practica3 of RegsMIPS is

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
        elsif rising_edge(Clk) and We3='1' then --Escritura en flanco de subida y con el write enable a 1
            if A3/="00000" then --Control de que no se escriba en la direccion 0
                regs(conv_integer(A3)) <= Wd3;--Escritura sincrona en la direccion indicada por A3
            end if;
    end if;
    end process;

    ------------------------------------------------------
    -- Lectura del registro RS
    ------------------------------------------------------
    --La lectura es asincrona y se lee la direccion indicada por A1 y por A2
    Rd1 <= regs(conv_integer(A1));
	 Rd2 <= regs(conv_integer(A2));

end Practica3;


