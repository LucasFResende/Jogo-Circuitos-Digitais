class_name FonteSinal
extends PortaLogica

@onready var sprite_ligado = load("res://addons/portas_logicas/fonte_sinal1.png")
@onready var sprite_desligado = load("res://addons/portas_logicas/fonte_sinal2.png")
@onready var variavel:Label = %Variavel
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

func set_variavel(texto:String) -> void:
	variavel.text = texto
	variavel.visible = true

func adicionar() -> void:
	var quantidade:int = get_parent().get_child_count()
	set_variavel(String.chr(quantidade+64))
	nome.set("theme_override_colors/font_color",Color.WHITE)
