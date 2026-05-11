extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("btn_esquerdo") and Global.esta_ligando_portas and Global.id_porta!=get_parent().id:
		var end_pos = Global.linha.to_local(global_position)
		Global.linha.set_point_position(1, end_pos)
		Global.esta_ligando_portas = false
		Global.id_porta = -1
