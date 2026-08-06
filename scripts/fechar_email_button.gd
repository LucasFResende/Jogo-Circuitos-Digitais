extends Button

func _on_pressed() -> void:
	get_parent().get_parent().find_child("EmailButton").mouse_filter = Control.MOUSE_FILTER_STOP
	get_parent().call_deferred("queue_free")

func _on_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(load(Global.mouse_selecao),Input.CURSOR_ARROW,Vector2(15,0))
	

func _on_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(load(Global.mouse_padrao))
