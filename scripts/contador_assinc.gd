class_name ContadorAssinc
extends PortaLogica

var clock_anterior: bool = false

var q1: bool = false
var q2: bool = false
var q3: bool = false
var q4: bool = false

@onready var saida1: Saida = %Saida1
@onready var saida2: Saida = %Saida2
@onready var saida3: Saida = %Saida3
@onready var saida4: Saida = %Saida4
@onready var entrada_clock: Entrada = %Entrada1


func verificar_logica() -> void:
	var clock: bool = entrada_clock.sinal

	if clock == clock_anterior:
		return

	clock_anterior = clock

	# FF1 recebe o clock externo
	var q1_anterior := q1
	q1 = not q1

	# FF2 recebe Q1
	if q1_anterior and not q1:
		var q2_anterior := q2
		q2 = not q2

		# FF3 recebe Q2
		if q2_anterior and not q2:
			var q3_anterior := q3
			q3 = not q3

			# FF4 recebe Q3
			if q3_anterior and not q3:
				q4 = not q4

	saida1.sinal = q1
	saida2.sinal = q2
	saida3.sinal = q3
	saida4.sinal = q4

	for child in %SaidaLigacao.get_children():
		child.atualizar()
