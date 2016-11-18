--Se incluyen las librerias necesarias
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY ContadorTb IS
END ContadorTb;
 
ARCHITECTURE behavior OF ContadorTb IS 
 
    -- Se declara el componente
 
    COMPONENT Contador
    PORT(
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         Ce : IN  std_logic;
         Up : IN  std_logic;
         Q : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Entradas
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Ce : std_logic := '0';
   signal Up : std_logic := '0';

 	--Salidas
   signal Q : std_logic_vector(7 downto 0);

   -- Se define una constante para un ciclo de reloj
   constant Clk_period : time := 10 ns;
 
BEGIN
   uut: Contador PORT MAP (
          Clk => Clk,
          Reset => Reset,
          Ce => Ce,
          Up => Up,
          Q => Q
        );

   --En el proceso de reloj se establece para que este vaya
   --oscilando entre 0 y 1 acorde con el ciclo de reloj
   --que se establecio en la constante.
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
   
	--En este proceso se observan todas las posibilidades de las entradas.
	p: process
	begin
	--Inicializacion con el reset a 1 para ver que no hace nada
		Reset<='1';
		wait for Clk_period*100;	
		Reset<='0';
		wait for Clk_period*10;
		--Se pone Ce a 0 para observar que no hace nada valga lo
		--que valga Up
		Ce<='0';
		Up<='0';
		wait for Clk_period*10;
		Ce<='0';
		Up<='1';
		wait for Clk_period*10;
		--Se comprueba que el contador cuenta hacia abajo correctamente
		Ce<='1';
		Up<='0';
		wait for Clk_period*256;
		--Se comprueba que el contador cuenta hacia arriba correctamente
		Ce<='1';
		Up<='1';
		wait for Clk_period*256;
		wait;
		end process;
END;
