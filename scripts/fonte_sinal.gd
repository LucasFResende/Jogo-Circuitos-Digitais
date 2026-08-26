class_name FonteSinal
extends PortaLogica

@onready var sprite_ligado = load("res://addons/portas_logicas/fonte_sinal1.png")
@onready var sprite_desligado = load("res://addons/portas_logicas/fonte_sinal2.png")
@onready var saida: Saida = $Saida

func mudar_saida() -> void:
	definir_sinal(not sinal)

func _on_butao_ligar_desligar_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("btn_esquerdo"):
		mudar_saida()

func definir_sinal(novo_sinal: bool) -> void:
	sinal = novo_sinal

	if sinal:
		set("texture", sprite_desligado)
	else:
		set("texture", sprite_ligado)

	$Saida.sinal = sinal

	for child in %SaidaLigacao.get_children():
		child.atualizar()
