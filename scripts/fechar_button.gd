extends Button

signal fechar

func _on_pressed() -> void:
	fechar.emit()
	get_parent().call_deferred("queue_free")
