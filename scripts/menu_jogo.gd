extends Control



func _on_retomar_button_pressed() -> void:
	Global.despausar_jogo()
	call_deferred("queue_free")

func _on_confg_button_pressed() -> void:
	var config = load("res://cenarios/configuracao.tscn")
	add_sibling(config.instantiate())


func _on_menu_button_pressed() -> void:
	var menu_inicial = load("res://cenarios/menu_inicial.tscn")
	var nos = get_parent().get_children()
	add_sibling(menu_inicial.instantiate())
	for child in nos:
		if !(child == $"/root/Global") and !(child == $"/root/Missoes"):
			child.queue_free()
	Global.despausar_jogo()
	
func _on_sair_button_pressed() -> void:
	get_tree().quit()
