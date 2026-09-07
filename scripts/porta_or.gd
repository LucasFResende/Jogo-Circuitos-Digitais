class_name OR
extends PortaLogica

@onready var entrada1:Entrada = %Entrada1
@onready var entrada2:Entrada = %Entrada2
@onready var saida:Saida = %Saida

func verificar_logica() -> void:
	var valor1 = entrada1.sinal
	var valor2 = entrada2.sinal
	sinal = valor1 or valor2
	saida.sinal = sinal
	for child in %SaidaLigacao.get_children():
		child.atualizar()
