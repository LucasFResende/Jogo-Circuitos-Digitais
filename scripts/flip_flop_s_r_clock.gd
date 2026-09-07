class_name FLipFlopSRclock
extends PortaLogica

var clock_anterior: bool = false

@onready var saida1: Saida = %Saida1
@onready var saida2: Saida = %Saida2
@onready var entrada1: Entrada = %Entrada1
@onready var entrada2: Entrada = %Entrada2
@onready var entrada_clock:Entrada = %Entrada3


func verificar_logica() -> void:
	var sinal_S:bool = entrada1.sinal
	var sinal_R:bool = entrada2.sinal
	var sinal_clock:bool = entrada_clock.sinal
	
	if sinal_clock == clock_anterior:
		return
	
	clock_anterior = sinal_clock
	
	if sinal_R == false and sinal_S == false:
		pass
	elif sinal_S == true and sinal_R == false:
		saida1.sinal = true
		saida2.sinal = not saida1.sinal
	elif sinal_S == false and sinal_R == true:
		saida1.sinal = false
		saida2.sinal = not saida1.sinal
	elif sinal_S == true and sinal_R == true:
		return
		
	
	for child in %SaidaLigacao.get_children():
		child.atualizar()
