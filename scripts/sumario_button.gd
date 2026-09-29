class_name SumarioButton
extends Button

@export var index:int
@onready var no_pai:Manual = $"../../.."


func _on_pressed() -> void:
	no_pai.ir_para_conteudo(index)
