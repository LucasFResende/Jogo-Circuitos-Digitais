class_name Tutorial
extends Control

var tutorial_iniciado:bool = false
var contador_fala:int = 0
var principal:Control
var cena_aberta:Control

@onready var tutorial_popup:PopupPanel = %TutorialPopup
@onready var tutorial_texto:Label = %Label
@onready var anim:AnimationPlayer = %AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tutorial_iniciado = true
	principal = get_tree().current_scene.get_node("/root/Principal")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if tutorial_iniciado:
		tutorial_popup.popup(Rect2i(310,830,1300,250))
		tutorial_iniciado = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if anim.is_playing():
			anim.pause()
			anim.advance(anim.current_animation_length - anim.current_animation_position)
			return
		contador_fala += 1
		if anim.get_animation_list().size() - 2 == contador_fala:
			anim.play("fim_tutorial")
		else:
			anim.play(str(contador_fala))

	
func apertar_manual() -> void:
	cena_aberta = load("res://cenarios/manual.tscn").instantiate()
	principal.add_sibling(cena_aberta)
	principal.get_parent().move_child(cena_aberta,principal.get_index())
	
func apertar_computador() -> void:
	cena_aberta = load("res://cenarios/email.tscn").instantiate()
	principal.add_sibling(cena_aberta)
	principal.get_parent().move_child(cena_aberta,principal.get_index())

func apertar_editor() -> void:
	cena_aberta = load("res://cenarios/editor_cenario.tscn").instantiate()
	principal.add_sibling(cena_aberta)
	principal.get_parent().move_child(cena_aberta,principal.get_index())

func fechar_cena() -> void:
	cena_aberta.call_deferred("queue_free")

func alterar_script_missao() -> void:
	Missoes.completo = not Missoes.completo
