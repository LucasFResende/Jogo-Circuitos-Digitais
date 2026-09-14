class_name MenuInicial
extends Control



func _on_iniciar_button_pressed() -> void:
	var jogo = load("res://cenarios/principal.tscn")
	add_sibling(jogo.instantiate())
	Global.jogo_iniciado = true
	call_deferred("queue_free")

func _on_sand_box_button_pressed() -> void:
	var sandbox = load("res://cenarios/sandbox.tscn")
	add_sibling(sandbox.instantiate())
	Global.jogo_iniciado = true
	call_deferred("queue_free")

func _on_configuracao_button_pressed() -> void:
	var config = load("res://cenarios/configuracao.tscn")
	add_sibling(config.instantiate())
	


func _on_sair_button_pressed() -> void:
	get_tree().quit()
