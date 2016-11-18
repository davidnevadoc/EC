################# Segmento de datos #################

.data			        
.aling 2		# Direccion alineada a palabra (multiplo de 4)
			
			#Address    Code
a: .word 0		#0x00002000 0x00000000
b: .word 0		#0x00002004 0x00000000
c: .word 43981		#0x00002008 0x0000ABCD
d: .word 4		#0x0000200c 0x00000004 # 0x0000200C contine el numero de pareja: 04
#Se les da nombre a las variables de memoria para que sea mas comodo.

################# Segmento de código #################    
.text
main:																#Address	Code		Binary
	lw $t1, c		 	#Se carga el valor de c en el registro t1. 						0x00000000  0x8c092008    100011 00000 01001 0010000000001000
	sll $t2, $t1, 16		#Se desplaza el contenido de t1 16 bits a la izquierda y se almacena en t2. 		0x00000004  0x00095400    000000 00000 01001 01010 10000 000000					
	lw $t3, d		 	#Se carga el contenido de d en el registro t3.						0x00000008  0x8c0b200c    100011 00000 01011 0001000000001100
	or $t4, $t4, $t3		#Se compara t3 y t4 con la funcion logica or y se almacena el resultado en t4. 		0x0000000c  0x014b6025    000000 01100 01011 01100 00000 100101   
	addi $t3, $zero, 6		#Se inserta el valor 6 en el registro t3. 						0x00000010  0x200d0006    001000 00000 01101 0000000000000110	 
	slt $t6, $t5, $t3	 	#Se compara t5<t3 y se almacena el resultado (0 o 1) en t6. 				0x00000014  0x01ab702a    000000 01101 01011 01110 00000 101010  
	beq $t6, $zero, target	 	#Si t6 vale 0 se salta a la etiqueta target. 						0x00000018  0x11c00002    000100 01110 00000 0000000000000010
	sw $t4, b		 	#Se introduce el valor de t4 en b. 							0x0000001c  0xac0c2004    101011 00000 01100 0010000000000100 
	j bucle			 	#Salto incondicional a la etiqueta bucle. 						0x00000020  0x0800000a    000010 00000000000000000000001010
target:	sw  $t4, a		 	#Se almacena el valor de t4 en a. 							0x00000024  0xac0c2000    101011 00000 01100 0010000000000000	
bucle:	j bucle			 	#Bucle infinito que se repite indefinidamente.						0x00000028  0x0800000a    000010 00000000000000000000001010

