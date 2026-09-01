class_name EmailMini
extends FoldableContainer

var id: String
var aceitar_dialogo: AcceptDialog
var repetir_dialogo: AcceptDialog
var aviso_dialogo: AcceptDialog

@onready var completo_sprite: Sprite2D = %Completo

func _on_repetir_button_pressed() -> void:
	if Missoes.verificar_completo(id):
		Missoes.repetir_missao(id)
		popup(repetir_dialogo)
		completo_sprite.visible = false
	else:
		popup(aviso_dialogo)

func _on_aceitar_button_pressed() -> void:
	Missoes.aceitar_missao(id)
	popup(aceitar_dialogo)
	

func popup(dialogo: AcceptDialog):
	dialogo.visible = true
