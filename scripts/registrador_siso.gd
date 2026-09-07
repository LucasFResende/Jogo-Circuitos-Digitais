class_name RegistradorSISO
extends PortaLogica

var clock_anterior: bool = false

@onready var saida1:Saida = %Saida1
@onready var entrada1:Entrada = %Entrada1
@onready var entrada_clock:Entrada = %Entrada2

var entrada_ffd1: Entrada
var entrada_ffd2: Entrada
var entrada_ffd3: Entrada
var entrada_ffd4: Entrada

var ffd1: FlipFlopD
var ffd2: FlipFlopD
var ffd3: FlipFlopD
var ffd4: FlipFlopD

func adicionar() -> void:
	nome.set("theme_override_colors/font_color",Color.WHITE)
	iniciar_no()
	
	entrada_ffd1 = Entrada.new()
	entrada_ffd2 = Entrada.new()
	entrada_ffd3 = Entrada.new()
	entrada_ffd4 = Entrada.new()
	
	ffd1 = FlipFlopD.new()
	ffd2 = FlipFlopD.new()
	ffd3 = FlipFlopD.new()
	ffd4 = FlipFlopD.new()
	
	ffd1.entrada_clock = entrada_clock
	ffd2.entrada_clock = entrada_clock
	ffd3.entrada_clock = entrada_clock
	ffd4.entrada_clock = entrada_clock
	
	ffd1.entrada = entrada1
	ffd2.entrada = entrada_ffd2
	ffd3.entrada = entrada_ffd3
	ffd4.entrada = entrada_ffd4

func verificar_logica() -> void:
	var clock:bool = entrada_clock.sinal
	
	if clock == clock_anterior:
		return
	
	clock_anterior = clock
	
	var estado1: bool = ffd1.estado
	var estado2: bool = ffd2.estado
	var estado3: bool = ffd3.estado
	
	ffd1.verificar_logica()
	entrada_ffd2.sinal = estado1

	ffd2.verificar_logica()
	entrada_ffd3.sinal = estado2

	ffd3.verificar_logica()
	entrada_ffd4.sinal = estado3

	ffd4.verificar_logica()
	saida1.sinal = ffd4.estado

	# Atualiza conexões externas.
	for child in %SaidaLigacao.get_children():
		child.atualizar()
