extends Button

func _on_pressed() -> void:
	get_parent().get_parent().find_child("EmailButton").mouse_filter = Control.MOUSE_FILTER_STOP
	get_parent().call_deferred("queue_free")

func _on_mouse_entered() -> void:
	Global.mudar_mouse_selecao()

func _on_mouse_exited() -> void:
	Global.mudar_mouse_padrao()
