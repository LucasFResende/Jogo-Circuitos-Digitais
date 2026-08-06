extends Button

signal fechar

func _on_pressed() -> void:
	fechar.emit()
	get_parent().call_deferred("queue_free")

func _on_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(load(Global.mouse_selecao),Input.CURSOR_ARROW,Vector2(15,0))

func _on_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(load(Global.mouse_padrao))
