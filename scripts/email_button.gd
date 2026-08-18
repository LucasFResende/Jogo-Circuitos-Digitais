extends Button

@onready var email_cena:PackedScene = load("res://cenarios/email.tscn")


func _on_pressed() -> void:
	var instancia = email_cena.instantiate()
	self.mouse_filter = Control.MOUSE_FILTER_IGNORE
	get_parent().add_child(instancia)

func _on_mouse_entered() -> void:
	Global.mudar_mouse_selecao()

func _on_mouse_exited() -> void:
	Global.mudar_mouse_padrao()
