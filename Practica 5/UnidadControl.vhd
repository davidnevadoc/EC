----------------------------------------------------------------------------------
-- Company: 
-- Engineer: David Moreno Maldonado, David Nevado Catalan
-- 
-- Create Date:    10:08:48 04/08/2015 
-- Design Name: 
-- Module Name:    UnidadControl - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 

--Grupo 2012 Pareja 04

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UnidadControl is 
port( 
	OPCode : in std_logic_vector(5 downto 0); 
	Funct : in std_logic_vector(5 downto 0);
	MemToReg, MemWrite, Branch, ALUSrc, RegDest, RegWrite, RegToPC, ExtCero, Jump, PCToReg: out std_logic;
	ALUControl : out std_logic_vector (2 downto 0)
);	
end UnidadControl; 
 
architecture Behavioral of UnidadControl is 
 
begin 
	-- Asignacion de las sennales de control en funcion de OPCode y Funct 
	MemToReg <= '1' when OPCode = "100011" else '0'; --Para la funcion lw
	
	MemWrite <= '1' when OPCode = "101011" else '0'; --Para la funcion sw}
	
	Branch <= '1' when OPCode = "000100" else '0';	-- Para la funcion beq
	
	ALUSrc  <= '0' when OPCode = "000000"  --Para todas las funciones de tipo R y beq
			else '0' when OPCode = "000100"
			else '1';
			
	RegDest <= '1' when OPCode = "000000" else '0';
	
	RegWrite  <= '0' when OPCode ="101011"        -- (se pone a 0) para las funciones que no escriben en registro: j, jal, jr y sw
			else '0' when OPCode = "000100"
			else '0' when OPCode = "000010"
			else '0' when (OPCode = "000000" and Funct = "001000")
			else '1';
		
	RegToPC <= '1' when (OPCode = "000000" and Funct = "001000") else '0'; --Para la funcion jal
	
	ExtCero <= '1' when OPCode = "001101" else  --Para las funciones ori y xori
				'1' when OPCode = "001110"
				else '0';
				
	Jump <= '1' when 	OPCode = "000010"  --Para la funcion j y jal
			else '1' when OPCode ="000011"
			else '0';
			
	PCToReg <= '1' when OPCode = "000011" --Para la funcion jal
			else '0';
			--Control de la operacion que realiza la ALU
						--add/ lw/ sw/ addi
	ALUControl <=  "010" when (OPCode = "000000" and Funct="100000") else
						"010" when OPCode = "100011" else
						"010" when OPCode = "101011" else
						"010" when OPCode = "001000" else
						--sub/ beq
						"110" when (OPCode = "000000" and Funct="100010") else
						"110" when OPCode = "000100" else
						--or / ori
						"001" when (OPCode = "000000" and Funct="100101") else
						"001" when OPCode = "001101" else
						--xor / xori
						"011" when (OPCode = "000000" and Funct="100110") else
						"011" when OPCode = "001110" else
						--nor
						"101" when (OPCode = "000000" and Funct="100111") else
						--slt / slti
						"111" when (OPCode = "000000" and Funct="101010") else
						"111" when OPCode = "001010" else
						--j/ jal / jr (o cualquier otro caso inesperado)
						"000";
						
					
	end Behavioral;

	