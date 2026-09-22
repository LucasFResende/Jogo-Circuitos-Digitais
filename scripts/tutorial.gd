class_name Tutorial
extends Control

var tutorial_iniciado:bool = false
var contador_fala:int = 0
var principal:Control
var cena_aberta:Control
var sobre_pular_tutorial:bool

@onready var tutorial_popup:PopupPanel = %TutorialPopup
@onready var tutorial_texto:Label = %Label
@onready var anim:AnimationPlayer = %AnimationPlayer
@onready var porta_and1:AND = %PortaAnd
@onready var porta_and2:AND = %PortaAnd2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.tutorial_finalizado:
		queue_free()
	tutorial_iniciado = true
	principal = get_tree().current_scene.get_node("/root/Principal")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if tutorial_iniciado:
		tutorial_popup.popup(Rect2i(310,830,1300,250))
		tutorial_iniciado = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if sobre_pular_tutorial:
			pular_tutorial()
		if anim.is_playing():
			anim.pause()
			anim.advance(anim.current_animation_length - anim.current_animation_position)
			return
		contador_fala += 1
		if anim.get_animation_list().size() - 2 == contador_fala:
			Global.tutorial_finalizado = true
			Global.atualizar_arquivo()
			Global.config["tutorial_finalizado"] = true
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

func ativar_porta(num_porta:int) -> void:
	if num_porta == 1:
		porta_and1.process_mode = Node.PROCESS_MODE_INHERIT
		porta_and1.visible = true
	elif num_porta == 2:
		porta_and2.process_mode = Node.PROCESS_MODE_INHERIT
		porta_and2.visible = true


func pular_tutorial() -> void:
	Global.mudar_mouse_padrao()
	Global.tutorial_finalizado = true
	Global.config["tutorial_finalizado"] = true
	Global.atualizar_arquivo()
	call_deferred("queue_free")


func _on_pular_tutorial_button_mouse_entered() -> void:
	sobre_pular_tutorial = true
	Global.mudar_mouse_selecao()


func _on_pular_tutorial_button_mouse_exited() -> void:
	sobre_pular_tutorial = false
	Global.mudar_mouse_padrao()
