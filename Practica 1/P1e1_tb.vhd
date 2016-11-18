--Se incluyen las librerias necesarias
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY P1e1_tb IS
END P1e1_tb;
 
ARCHITECTURE behavior OF P1e1_tb IS 
 
    -- Se declara el componente.
 
    COMPONENT P1e1
    PORT(
         A : IN  std_logic;
         B : IN  std_logic;
         C : IN  std_logic;
         Q : OUT  std_logic
        );
    END COMPONENT;
    

   --Entradas
   signal A : std_logic := '0';
   signal B : std_logic := '0';
   signal C : std_logic := '0';

 	--Salidas
   signal Q : std_logic;
 
BEGIN
   uut: P1e1 PORT MAP (
          A => A,
          B => B,
          C => C,
          Q => Q
        );
 

    --Se hace variar las entradas en las 8 posibilidades que hay 
	 --para ver las correspondientes salidas en la simulacion.
   stim_proc: process
   begin		
			 A <= '0';
          B <= '0';
          C <= '0';
         
      wait for 100 ns;	
			 A <= '0';
          B <= '0';
          C <= '1';
         
      wait for 100 ns;	
		    A <= '0';
          B <= '1';
          C <= '0';
         
      wait for 100 ns;	
		    A <= '0';
          B <= '1';
          C <= '1';
         
      wait for 100 ns;	
		    A <= '1';
          B <= '0';
          C <= '0';
         
      wait for 100 ns;	
			 A <= '1';
          B <= '0';
          C <= '1';
         
      wait for 100 ns;	
			 A <= '1';
          B <= '1';
          C <= '0';
         
      wait for 100 ns;	
			 A <= '1';
          B <= '1';
          C <= '1';        
--Al no haber clock se pone que se espere un tiempo, en este caso 100ns
--antes de cambiar los valores de las entradas.     	
      wait;
   end process;

END;
