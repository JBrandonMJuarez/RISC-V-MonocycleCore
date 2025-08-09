#Practica Ordenamiento Burbuja 

#Seccion de codigo

.text
	#Carga de valores a ordenar
	addi	t0, zero, 50
	addi	t1, zero, 41
	addi	t2, zero, 65
	addi	t3, zero, 12
	addi	t4, zero, 20
	addi	t5, zero, 92
	addi	t6, zero, 5
	
	#Almacenamiento en memoria
	sw	t0, 0(zero)
	sw	t1, 4(zero)
	sw	t2, 8(zero)
	sw	t3, 12(zero)
	sw	t4, 16(zero)
	sw	t5, 20(zero)
	sw	t6, 24(zero)
	
	#Definir indice i
	addi	s0, zero, 0	#i = 0
	addi	s2, zero, 6 	#limite = 6
	
	#Primer bucle for
	for_e:
		addi	s1,zero, 0	#Definir indice j
	#Segundo bucle for
	for_i:
		slli	t0, s1, 2	#Offset de j
		addi	t1, t0, 4	#Offset de j+1
		lw	t2, 0(t0)	#t2 = mem[j]
		lw	t3, 0(t1)	#t3 = mem[j+1]
		slt	t4, t3, t2
		beq	t4, zero, incremento_j
		sw	t2, 0(t1)
		sw	t3, 0(t0)
	incremento_j:
		addi	s1, s1, 1	#j++
		bne	s1, s2, for_i 
		
		addi	s0, s0, 1	#i++
		bne	s0, s2, for_e
