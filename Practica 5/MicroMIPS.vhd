----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:16:47 04/15/2015 
-- Design Name: 
-- Module Name:    MicroMIPS - Behavioral 
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
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MicroMIPS is
	Port( 
			NRst,Clk: in std_logic;
			MemProgData, MemDataDataRead : in std_logic_vector(31 downto 0);
			MemProgAddr, MemDataDataWrite, MemDataDataWrite: out std_logic_vector(31 downto 0);
			MemDataWe: out std_logic
			);
			
end MicroMIPS;

architecture Supermicro of MicroMIPS is

component ALUMIPS port(
		Op1 : in  STD_LOGIC_VECTOR (31 downto 0); -- Primer operando de la ALU (de 32 bits)
		Op2 : in  STD_LOGIC_VECTOR (31 downto 0); -- Segundo operando de la ALU (de 32 bits)
		ALUControl : in  STD_LOGIC_VECTOR (2 downto 0); --Selector de la operacion de la ALU (3 bits)
		Res : out  STD_LOGIC_VECTOR (31 downto 0); -- Resultado de la operacion (32 bits)
		Z : out  STD_LOGIC); --Señal de estado, indica si el resultado es 0 (en ese  caso la señal es 1, en caso cotrario es 0) (1 bit)
end component;

component UnidadControl port(
		OPCode : in std_logic_vector(5 downto 0); 
		Funct : in std_logic_vector(5 downto 0);
		MemToReg, MemWrite, Branch, ALUSrc, RegDest, RegWrite, RegToPC, ExtCero, Jump, PCToReg: out std_logic;
		ALUControl : out std_logic_vector (2 downto 0)
);
end component;

component RegsMIPS port(
		  Clk : in std_logic; -- Reloj
        NRst, We3 : in std_logic;
        Wd3 : in std_logic_vector(31 downto 0);
        A1, A2, A3 : in std_logic_vector(4 downto 0);
        Rd1, Rd2 : out std_logic_vector(31 downto 0)
		  );
end component;

signal MemToReg_s, Branch_s, ALUSrc_s, RegDest_s, RegWrite_s, RegToPC_s, ExtCero_s, Jump_s, PCToReg_s, Z_s: std_logic;
signal ALUControl_s: std_logic_vector (2 downto 0);
signal A3_s: std_logic_vector (5 downto 0);
signal Wd3_s, RD1_s, RD2_s, Op2_s, Res_s, ExtInm_s, PC4_s: std_logic_vector (31 downto 0);

begin

UnidaddeControl: UnidadControl 
	port map (
		OPCode=>MemProgData(31 downto 26),
		Funct=>MemProgData(5 downto 0),
		MemToReg=>MemToReg_s,
		MemWrite=>MemDataWe,
		Branch=>Branch_s,
		ALUSrc=>ALUSrc_s,
		RegDest=>RegDest_s,
		RegWrite=>RegWrite_s,
		RegToPC=>RegToPC_s,
		ExtCero=>ExtCero_s,
		Jump=>Jump_s,
		PCToReg=>PCToReg_s,
		ALUControl=>ALUControl_s
		);

Bancoderegistros: RegsMIPS
	port map (
		Clk=>Clk,
		NRst=>NRst,
		We3=>RegWrite_s,
		Wd3=>Wd3_s,
		A1=>MemProgData(25 downto 21),
		A2=>MemProgData(20 downto 16),
		A3=>A3_s,
		Rd1=>RD1_s,
		Rd2=>RD2_s
		);
		
ALU: ALUMIPS
	port map (
		Op1=>RD1_s,
		Op2=>Op2_s,
		ALUControl=>ALUControl_s,
		Res=>Res_s,
		Z=Z_s
		);
		
ExtInm_s <= (((31 downto 16)=>MemProgData(15)) & MemProgData(15 downto 0));--Revisar sintaxis	
		
--BANCO DE REGISTROS term
--A1 esta en el port map de regsMIPS
--A2 esta en el port map de regsMIPS
A3_s <= "11111" when PCToReg_s='1' else
		  MemProgData(20 downto 16) when	RegDest_s='0' else
		  MemProgData(15 downto 11);
--Rd1 esta en el port map de regsMIPS
--Rd2 esta en el port map de regsMIPS
Wd3_s <= PC4_s when PCToReg_s='1' else
			MemDataDataRead when MemToReg_s='1' else
			Res_s;
		  
--ALU term
--Op1 esta hecho en el port map ALUMIPS		  
Op2_s <= RD2_s when ALUSrc_s='0' else
			"0000000000000000" & MemProgData(15 downto 0) when ExtCero_s='1' else
			ExtInm_s;
--ALUControl esta hecho en el port map ALUMIPS
--Z esta hecho en el port map ALUMIPS
--Res esta hecho en el port map ALUMIPS

--MEMORIA DE DATOS
MemDataDataWrite <= RD2_s;
MemDataAddr <= Res_s;
--MemDataWe en el port map de Unidad de control
--MemDataDataRead es una entrada que se usa donde es necesario

--UNIDAD DE CONTROL
--Con el port map queda hecha totalmente

end Supermicro;

