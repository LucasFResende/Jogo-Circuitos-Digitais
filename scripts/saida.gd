class_name Saida
extends Area2D

@onready var no_saida_ligacao = %SaidaLigacao
@onready var sinal:int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.esta_ligando_portas and Global.linha:
		var mouse_pos = Global.linha.to_local(get_global_mouse_position())
		Global.linha.set_point_position(1, mouse_pos)

	if (Input.is_action_just_released("btn_direito") or Input.is_action_just_pressed("esc")) and Global.esta_ligando_portas:
		Global.esta_ligando_portas = false
		if Global.linha:
			Global.linha.queue_free()
			Global.linha = null
			Global.id_porta = null


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("btn_esquerdo") and not Global.esta_ligando_portas:
		Global.linha = Conexao.new()
		no_saida_ligacao.add_child(Global.linha)
		
		var start_pos = Global.linha.to_local(global_position)
		Global.linha.add_point(start_pos)
		Global.linha.add_point(start_pos)
		
		Global.esta_ligando_portas = true
		Global.id_porta = get_parent().id
		Global.linha.porta_saida = self

func _on_mouse_entered() -> void:
	Global.mudar_mouse_selecao()


func _on_mouse_exited() -> void:
	Global.mudar_mouse_padrao()
