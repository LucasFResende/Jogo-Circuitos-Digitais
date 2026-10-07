class_name EmailMini
extends FoldableContainer

var id: String
var aceitar_dialogo: AcceptDialog
var repetir_dialogo: AcceptDialog
var aviso_dialogo: AcceptDialog

@onready var completo_sprite: Sprite2D = %Completo
@onready var ativo_sprite: Sprite2D = %Ativo
@onready var missao_sprite:TextureRect = %Missao

func _ready() -> void:
	if Missoes.missoes[id]["completo"]:
		%RepetirButton.visible = true
	else:
		%AceitarButton.visible = true
	if Missoes.missoes[id]["imagem"]!=null:
		missao_sprite.visible = true
		missao_sprite.texture = load(Missoes.missoes[id]["imagem"])
	if (Missoes.id_missao_ativa == id) and !Missoes.completo:
		ativo_sprite.visible = true

func _on_repetir_button_pressed() -> void:
	if Missoes.verificar_completo(id):
		Missoes.repetir_missao(id)
		popup(repetir_dialogo)
		completo_sprite.visible = false
		%RepetirButton.visible = false
		%AceitarButton.visible = true
		var email:Email = get_parent().get_parent().get_parent()
		email.iniciar()
		
	else:
		popup(aviso_dialogo)

func _on_aceitar_button_pressed() -> void:
	Missoes.aceitar_missao(id)
	ativo_sprite.visible = true
	popup(aceitar_dialogo)
	var email:Email = get_parent().get_parent().get_parent()
	email.iniciar()
	

func popup(dialogo: AcceptDialog):
	dialogo.visible = true
