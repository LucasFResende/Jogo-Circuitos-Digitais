class_name ContadorDecr
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

	# Só executa quando o clock muda
	if clock == clock_anterior:
		return

	clock_anterior = clock

	# Guarda os estados anteriores
	var q1_antigo := q1
	var q2_antigo := q2
	var q3_antigo := q3

	# FF1: J=K=1
	q1 = not q1

	# FF2: J=K=NOT Q1
	if not q1_antigo:
		q2 = not q2

	# FF3: J=K=NOT Q1 AND NOT Q2
	if not q1_antigo and not q2_antigo:
		q3 = not q3

	# FF4: J=K=NOT Q1 AND NOT Q2 AND NOT Q3
	if not q1_antigo and not q2_antigo and not q3_antigo:
		q4 = not q4

	# Saídas
	saida1.sinal = q1
	saida2.sinal = q2
	saida3.sinal = q3
	saida4.sinal = q4

	# Propaga as mudanças
	for child in %SaidaLigacao.get_children():
		child.atualizar()
