class_name NAND
extends PortaLogica

@onready var entrada1:Entrada = %Entrada1
@onready var entrada2:Entrada = %Entrada2
@onready var saida:Saida = %Saida

func _ready() -> void:
	ready_padrao()
	%Entrada1.sinal = 1
	%Entrada2.sinal = 1
	
func verificar_logica() -> void:
	var valor1 = entrada1.sinal
	var valor2 = entrada2.sinal
	sinal = !(valor1 and valor2)
	%Saida.sinal = sinal
	for child in %SaidaLigacao.get_children():
		child.atualizar()
