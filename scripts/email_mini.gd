class_name EmailMini
extends FoldableContainer

var id:String
@onready var completo_sprite: Sprite2D = %Completo

func _on_button_pressed() -> void:
	Missoes.atualizar_missao(id)
