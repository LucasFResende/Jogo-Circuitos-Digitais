extends PortaLogica

func _ready() -> void:
	area_2d.input_event.connect(_on_area_2d_input_event)
	$Entrada1.sinal = 1

func verificar_logica() -> void:
	var valor1 = $Entrada1.sinal
	var valor2 = $Entrada2.sinal
	sinal = (!valor1 and !valor2) or (valor1 and valor2)
	$Saida.sinal = sinal
