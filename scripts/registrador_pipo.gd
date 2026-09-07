class_name RegistradorPIPO
extends PortaLogica

var clock_anterior: bool = false

@onready var saida1:Saida = %Saida1
@onready var saida2:Saida = %Saida2
@onready var saida3:Saida = %Saida3
@onready var saida4:Saida = %Saida4
@onready var entrada1:Entrada = %Entrada1
@onready var entrada2:Entrada = %Entrada2
@onready var entrada3:Entrada = %Entrada3
@onready var entrada4:Entrada = %Entrada4
@onready var entrada_clock:Entrada = %Entrada5

var ffd1: FlipFlopD
var ffd2: FlipFlopD
var ffd3: FlipFlopD
var ffd4: FlipFlopD

func adicionar() -> void:
	nome.set("theme_override_colors/font_color",Color.WHITE)
	iniciar_no()
	ffd1 = FlipFlopD.new()
	ffd1.entrada = entrada1
	ffd1.entrada_clock = entrada_clock
	ffd2 = FlipFlopD.new()
	ffd2.entrada = entrada2
	ffd2.entrada_clock = entrada_clock
	ffd3 = FlipFlopD.new()
	ffd3.entrada = entrada3
	ffd3.entrada_clock = entrada_clock
	ffd4 = FlipFlopD.new()
	ffd4.entrada = entrada4
	ffd4.entrada_clock = entrada_clock

func verificar_logica() -> void:
	var clock:bool = entrada_clock.sinal
	
	if clock == clock_anterior:
		return
	
	clock_anterior = clock
	
	ffd1.verificar_logica()
	ffd2.verificar_logica()
	ffd3.verificar_logica()
	ffd4.verificar_logica()
	
	saida1.sinal = ffd1.estado
	saida2.sinal = ffd2.estado
	saida3.sinal = ffd3.estado
	saida4.sinal = ffd4.estado

	
	for child in %SaidaLigacao.get_children():
		child.atualizar()
