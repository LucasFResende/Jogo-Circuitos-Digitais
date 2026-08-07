extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(load(Global.mouse_selecao),Input.CURSOR_ARROW,Vector2(15,0))


func _on_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(load(Global.mouse_padrao))
