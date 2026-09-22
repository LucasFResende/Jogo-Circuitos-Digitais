class_name NOT
extends PortaLogica

func _ready() -> void:
	ready_padrao()
	$Entrada1.sinal = 1

func verificar_logica() -> void:
	var valor1 = $Entrada1.sinal
	sinal = !valor1
	$Saida.sinal = sinal
	for child in %SaidaLigacao.get_children():
		child.atualizar()
