extends Button

signal fechar

@export var no_pai:Control

func _on_pressed() -> void:
	fechar.emit()
	no_pai.call_deferred("queue_free")

func _on_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(load(Global.mouse_selecao),Input.CURSOR_ARROW,Vector2(15,0))

func _on_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(load(Global.mouse_padrao))
