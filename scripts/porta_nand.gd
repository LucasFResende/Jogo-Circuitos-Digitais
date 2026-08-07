extends PortaLogica

func verificar_logica() -> void:
	var valor1 = $Entrada1.sinal
	var valor2 = $Entrada2.sinal
	sinal = !(valor1 and valor2)
	$Saida.sinal = sinal
