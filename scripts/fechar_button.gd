extends Button

signal fechar

@export var no_pai:Control

func _on_pressed() -> void:
	fechar.emit()
	no_pai.call_deferred("queue_free")

func _on_mouse_entered() -> void:
	Global.mudar_mouse_selecao()

func _on_mouse_exited() -> void:
	Global.mudar_mouse_padrao()
