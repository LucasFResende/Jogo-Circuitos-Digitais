extends Camera2D

var esta_movendo: bool = false
var mouse_anterior: Vector2
var zoom_diferenca:Vector2 = Vector2(0.1,0.1)

@onready var ui:Control = %UI



func _process(delta: float) -> void:
	if Input.is_action_just_pressed("btn_meio"):
		esta_movendo = true
		mouse_anterior = get_viewport().get_mouse_position()
		Global.mudar_mouse_mover()

	elif Input.is_action_just_released("btn_meio"):
		esta_movendo = false
		Global.mudar_mouse_padrao()

	if esta_movendo:
		var mouse_atual := get_viewport().get_mouse_position()
		var movimento := mouse_atual - mouse_anterior

		global_position -= movimento / zoom
		mouse_anterior = mouse_atual
	
	if Input.is_action_just_pressed("scroll_cima"):
		zoom+=zoom_diferenca
		ui.scale = Vector2.ONE / zoom
	elif Input.is_action_just_pressed("scroll_baixo") and zoom-zoom_diferenca>Vector2.ZERO:
		zoom-=zoom_diferenca
		ui.scale = Vector2.ONE / zoom
		
