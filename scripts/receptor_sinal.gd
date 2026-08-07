extends PortaLogica

@onready var ligado = load("res://addons/portas_logicas/receptor_sinal2.png")
@onready var desligado = load("res://addons/portas_logicas/receptor_sinal1.png")

func verificar_logica() -> void:
	if $Entrada.sinal:
		set("texture",ligado)
	else:
		set("texture",desligado)
