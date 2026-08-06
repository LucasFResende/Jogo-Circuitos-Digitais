extends Button

@onready var email_cena:PackedScene = load("res://cenarios/email.tscn")


func _on_pressed() -> void:
	var instancia = email_cena.instantiate()
	self.mouse_filter = Control.MOUSE_FILTER_IGNORE
	get_parent().add_child(instancia)

func _on_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(load(Global.mouse_selecao),Input.CURSOR_ARROW,Vector2(15,0))

func _on_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(load(Global.mouse_padrao))
