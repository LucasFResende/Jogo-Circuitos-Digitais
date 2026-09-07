class_name FlipFlopD
extends PortaLogica

var estado: bool = false
var clock_anterior: bool = false

var entrada:Entrada
var entrada_clock:Entrada
var saida1:Saida
var saida2:Saida

func _ready() -> void:
	area_2d.input_event.connect(_on_area_2d_input_event)
	entrada = %Entrada1
	entrada_clock = %Entrada2
	saida1 = %Saida1
	saida2 = %Saida2

func adicionar() -> void:
	nome.set(
		"theme_override_colors/font_color",
		Color.WHITE
	)

	estado = false
	clock_anterior = false

	iniciar_no()

func verificar_logica() -> void:
	if entrada == null or entrada_clock == null:
		return

	var sinal_D: bool = entrada.sinal
	var sinal_clock: bool = entrada_clock.sinal


	if sinal_clock and not clock_anterior:
		estado = sinal_D

	clock_anterior = sinal_clock

	if saida1 != null:
		saida1.sinal = estado

	if saida2 != null:
		saida2.sinal = not estado

	var saida_ligacao := get_node_or_null("%SaidaLigacao")

	if saida_ligacao != null:
		for child in saida_ligacao.get_children():
			child.atualizar()
