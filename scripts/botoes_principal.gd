extends Node

@export var cenario_destino: PackedScene

@onready var botao_manual:Button = %ManualButton
@onready var botao_computador:Button = %ComputadorButton
@onready var botao_editor_circuito:Button = %EditorCircuitosButton


func _on_pressed() -> void:
	botao_manual.mouse_filter = Control.MOUSE_FILTER_IGNORE
	botao_computador.mouse_filter = Control.MOUSE_FILTER_IGNORE
	botao_editor_circuito.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var destino = cenario_destino.instantiate()
	destino.find_child("FecharButton").fechar.connect(fechando)
	get_parent().add_sibling(destino)
	

func fechando()-> void:
	botao_manual.mouse_filter = Control.MOUSE_FILTER_STOP
	botao_computador.mouse_filter = Control.MOUSE_FILTER_STOP
	botao_editor_circuito.mouse_filter = Control.MOUSE_FILTER_STOP


func _on_mouse_entered() -> void:
	Global.mudar_mouse_selecao()


func _on_mouse_exited() -> void:
	Global.mudar_mouse_padrao()
