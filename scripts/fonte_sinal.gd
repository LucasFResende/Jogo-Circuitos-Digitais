class_name FonteSinal
extends PortaLogica

@onready var sprite_ligado = load("res://addons/portas_logicas/fonte_sinal1.png")
@onready var sprite_desligado = load("res://addons/portas_logicas/fonte_sinal2.png")


func mudar_saida() -> void:
	if sinal == false:
		sinal = true
		set("texture",sprite_desligado)
	else:
		sinal = false
		set("texture",sprite_ligado)
	$Saida.sinal = sinal

func _on_butao_ligar_desligar_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("btn_esquerdo"):
		mudar_saida()
