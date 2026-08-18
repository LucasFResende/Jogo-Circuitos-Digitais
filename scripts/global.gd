extends Node

var esta_ligando_portas:bool = false
var linha:Conexao = null
var id_porta = null
var mouse_padrao = "res://addons/cursores/Arrow2.png"
var mouse_selecao = "res://addons/cursores/Hand1.png"
var mouse_mover = "res://addons/cursores/mover_arrow.png"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()

func mudar_mouse_selecao() -> void:
	Input.set_custom_mouse_cursor(load(mouse_selecao),Input.CURSOR_ARROW,Vector2(15,0))

func mudar_mouse_mover() -> void:
	Input.set_custom_mouse_cursor(load(mouse_mover))

func mudar_mouse_padrao() -> void:
	Input.set_custom_mouse_cursor(load(mouse_padrao))
