.data
.align 2 # Direccion alineada a palabra (multiplo de 4)

lut: .word 0, 80, 160, 240, 320, 399, 477, 555, 633, 709, 785, 860, 934, 1006, 1078, 1148, 1217, 1284, 1350, 1414, 1476, 1536, 1595, 1652, 1706, 1759, 1809, 1857, 1903, 1947, 1988, 2027, 2064, 2097, 2129, 2157, 2184, 2207, 2228, 2246, 2261, 2274, 2283, 2290, 2295, 2296
angulo: .word 42
resultado: .space 8

.text
main:
	addi $sp, $zero, 0x4000 #Inicializalizamos el puntrero pila a 4000
	lw $s0, angulo #Cargamos el angulo dado en el registro t0
	addi $sp, $sp, -4 #Resrvamos memoria en la pila para el argumento que pasaremos a la subrutina
	sw $s0, 0($sp) #Guardamos el valor de t0(angulo) en la pila
	jal calculaAlcance
	lw $s1, 0($sp) #Cargamos el resultado de retorno de la pila
	addi $sp, $sp, 4 #Retauramos el valor de la pila
	sw $s1, resultado #Guardamos el alcance en resultado
	j bucle
	
calculaAlcance:
	lw $t0, 0($sp) #Cargamos el angulo que esta metido en la pila
	sll $t0, $t0, 2 #Multiplicamos por 4 para que nos indique una direccion de memoria
	lw $t0, lut($t0) #Cargamos el alcance correspondiente al angulo dado
	sw $t0, 0($sp) #Metemos el alcance resultado en la pila
	jr $ra	#Volvemos a la rutina principal
	
bucle:
	j bucle #ciclo infinito del final del programa (while(1))
