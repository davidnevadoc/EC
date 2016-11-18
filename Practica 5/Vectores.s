.data
.align 2
N: .word 6 #
A: .word 2, 4, 6, 8, 10, 12  #
B: .word -1,-5,4,10,1,-5 #
C: .space 24 #



.text
main:	lw $s0, N    		 #Cargamos la variable N(numero de coordenadas del vector) en el registro t0
	add $s0, $s0, $s0
	add $s0, $s0, $s0	 #Multiplicamos el valor de N por 4 (100 en binario)
	xor $s1, $s1, $s1	 #Inicializamos el registro t1 a 0.
bucle_op:	beq $s1, $s0, fin_bucle_op	 #Se comprueba si se ha llegado ya al final del bucle de la operacion
		lw $s2, A($s1)			 #Cargamos el dato a correspondiente al valor de t1
		lw $s3, B($s1)			 #Cargamos el dato b correspondiente al valor de t1
		sub $s4, $s2, $s3		 #En el registro t4 restamos los valores cargados de a y b
		add $s4, $s4, $s4 		 #Multiplicamos por 2 el resutado almacenado anteriormente
		sw $s4, C($s1)			 #Almacenamos en la memoria el resultado obtenido
		addi $s1, $s1, 4		 #Incrementamos el contador en 4(tamaño de nuestras palabras en bytes)
		j bucle_op			 #Salta al principio del bucle de la operacion
fin_bucle_op:
bucle: j bucle 	#Bucle infinito(while (1)) 
