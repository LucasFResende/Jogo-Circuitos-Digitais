class_name Somador
extends PortaLogica

@onready var saida:Saida = %Saida1
@onready var saida_carry:Saida = %Saida2
@onready var entrada_a:Entrada = %Entrada1
@onready var entrada_b:Entrada = %Entrada2
@onready var entrada_carry:Entrada = %Entrada3

func adicionar() -> void:
	nome.set("theme_override_colors/font_color",Color.WHITE)
	iniciar_no()

func verificar_logica() -> void:
	var sinal_a:int = entrada_a.sinal
	var sinal_b:int = entrada_b.sinal
	var sinal_carry_in:int = entrada_carry.sinal
	
	saida.sinal = sinal_a ^ (sinal_b ^ sinal_carry_in)
	saida_carry.sinal = (sinal_b & sinal_carry_in) | (sinal_a & sinal_carry_in) | (sinal_a & sinal_b)
	
	for child in %SaidaLigacao.get_children():
		child.atualizar()
