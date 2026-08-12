class_name Entrada
extends Area2D

@onready var sinal:int = 0
var linha_ligada:Line2D
var quantidade_linha_ligado:int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if linha_ligada == null:
		quantidade_linha_ligado=0


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("btn_esquerdo") and Global.esta_ligando_portas and Global.id_porta!=get_parent().id and quantidade_linha_ligado==0:
		var end_pos = Global.linha.to_local(global_position)
		Global.linha.set_point_position(1, end_pos)
		Global.esta_ligando_portas = false
		Global.id_porta = -1
		Global.linha.porta_entrada = self
		linha_ligada = Global.linha
		quantidade_linha_ligado+=1


func _on_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(load(Global.mouse_selecao),Input.CURSOR_ARROW,Vector2(15,0))


func _on_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(load(Global.mouse_padrao))
