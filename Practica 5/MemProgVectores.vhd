----------------------------------------------------------------------
-- Fichero: MemProgMIPS.vhd
-- Descripción: Memoria de programa para el MIPS
-- Fecha última modificación: 2015-03-09

-- Autores: Alberto Sánchez (2012, 2013), Ángel de Castro (2010, 2015) 
-- Asignatura: E.C. 1º grado
-- Grupo de Prácticas:
-- Grupo de Teoría:
-- Práctica: 5
-- Ejercicio: 3
----------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_LOGIC_arith.ALL;
use IEEE.std_logic_unsigned.ALL;

entity MemProgMIPS is
    port (
        MemProgAddr : in std_logic_vector(31 downto 0); -- Dirección para la memoria de programa
        MemProgData : out std_logic_vector(31 downto 0) -- Código de operación
    );
end MemProgMIPS;

architecture Simple of MemProgMIPS is

begin

    LecturaMemProg: process(MemProgAddr)
    begin
        -- La memoria devuelve un valor para cada dirección.
        -- Estos valores son los códigos de programa de cada instrucción,
        -- estando situado cada uno en su dirección.
        case MemProgAddr is
            when X"00000000" => MemProgData <= X"8C102000";
            when X"00000004" => MemProgData <= X"02108020";
            when X"00000008" => MemProgData <= X"02108020";
            when X"0000000C" => MemProgData <= X"02318826";
            when X"00000010" => MemProgData <= X"12300007";
            when X"00000014" => MemProgData <= X"8E322004";
            when X"00000018" => MemProgData <= X"8E33201C";
            when X"0000001C" => MemProgData <= X"0253A022";
            when X"00000020" => MemProgData <= X"0294A020";
            when X"00000024" => MemProgData <= X"AE342034";
            when X"00000028" => MemProgData <= X"22310004";
            when X"0000002C" => MemProgData <= X"08000004";
            when X"00000030" => MemProgData <= X"0800000C";
            when others => MemProgData <= X"00000000"; -- Resto de memoria vacía
        end case;
    end process LecturaMemProg;

end Simple;

