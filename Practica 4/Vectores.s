.data
a: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10  #
b: .word -1,-5,4,10,1,-2,5,10,-10,0 #
c: .space 80 #
N: .word 10 #


.text
main:	lw $s0, N    		 #Cargamos la variable N(numero de coordenadas del vector) en el registro t0
	sll $s0, $s0, 2		 #Multiplicamos el valor de N por 4 (100 en binario)
	xor $s1, $s1, $s1	 #Inicializamos el registro t1 a 0.
bucle_op:	beq $s1, $s0, fin_bucle_op	 #Se comprueba si se ha llegado ya al final del bucle de la operacion
		lw $s2, a($s1)			 #Cargamos el dato a correspondiente al valor de t1
		lw $s3, b($s1)			 #Cargamos el dato b correspondiente al valor de t1
		sub $s4, $s2, $s3		 #En el registro t4 restamos los valores cargados de a y b
		sll $s4, $s4, 1 		 #Multiplicamos por 2 el resutado almacenado anteriormente
		sw $s4, c($s1)			 #Almacenamos en la memoria el resultado obtenido
		addi $s1, $s1, 4		 #Incrementamos el contador en 4(tamaño de nuestras palabras en bytes)
		j bucle_op			 #Salta al principio del bucle de la operacion
fin_bucle_op:
bucle: j bucle 	#Bucle infinito(while (1)) 
