class_name FlipFlopJKclock
extends PortaLogica

var clock_anterior: bool = false

@onready var saida1:Saida = %Saida1
@onready var saida2:Saida = %Saida2
@onready var entrada1:Entrada = %Entrada1
@onready var entrada2:Entrada = %Entrada2
@onready var entrada_clock:Entrada = %Entrada3

func verificar_logica() -> void:
	var sinal_J:bool = entrada1.sinal
	var sinal_K:bool = entrada2.sinal
	var sinal_clock:bool = entrada_clock.sinal
	
	if sinal_clock == clock_anterior:
		return
	
	if sinal_K == false and sinal_J == false:
		pass
	elif sinal_J == true and sinal_K == false:
		saida1.sinal = true
		saida2.sinal = not saida1.sinal
	elif sinal_J == false and sinal_K == true:
		saida1.sinal = false
		saida2.sinal = not saida1.sinal
	elif sinal_J == true and sinal_K == true:
		saida1.sinal = not saida1.sinal
		saida2.sinal = not saida1.sinal
	
	clock_anterior = sinal_clock
	
	for child in %SaidaLigacao.get_children():
		child.atualizar()
