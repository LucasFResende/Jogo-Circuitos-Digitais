extends Node

var esta_ligando_portas:bool = false
var linha:Conexao = null
var id_porta = null
var mouse_padrao = "res://addons/cursores/Arrow2.png"
var mouse_selecao = "res://addons/cursores/Hand1.png"
var mouse_mover = "res://addons/cursores/mover_arrow.png"
var jogo_iniciado:bool = false
var config: Dictionary

const _ARQUIVO_ORIGINAL := "res://config.json"
const _ARQUIVO_USUARIO := "user://config.json"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	carregar_arquivo()
	await get_tree().process_frame
	if config["modo"] == "fullscreen":
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		var resolucao:Vector2i = Vector2i(config["resolucao"][0],config["resolucao"][1])
		DisplayServer.window_set_size(resolucao)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc") and jogo_iniciado:
		var menu_jogo = load("res://cenarios/menu_jogo.tscn")
		get_parent().add_child(menu_jogo.instantiate())
		get_tree().paused = true

func mudar_mouse_selecao() -> void:
	Input.set_custom_mouse_cursor(load(mouse_selecao),Input.CURSOR_ARROW,Vector2(15,0))

func mudar_mouse_mover() -> void:
	Input.set_custom_mouse_cursor(load(mouse_mover))

func mudar_mouse_padrao() -> void:
	Input.set_custom_mouse_cursor(load(mouse_padrao))


func despausar_jogo() -> void:
	get_tree().paused = false


func carregar_arquivo() -> void:
	if not FileAccess.file_exists(_ARQUIVO_USUARIO):
		var arquivo_original := FileAccess.open(
			_ARQUIVO_ORIGINAL,
			FileAccess.READ
		)

		if arquivo_original == null:
			push_error("Não foi possível abrir missoes.json original")
			return

		var conteudo := arquivo_original.get_as_text()
		arquivo_original.close()

		var arquivo_usuario := FileAccess.open(
			_ARQUIVO_USUARIO,
			FileAccess.WRITE
		)

		if arquivo_usuario == null:
			push_error("Não foi possível criar missoes.json do usuário")
			return

		arquivo_usuario.store_string(conteudo)
		arquivo_usuario.close()

	# Agora sempre trabalha com a cópia gravável.
	var arquivo := FileAccess.open(
		_ARQUIVO_USUARIO,
		FileAccess.READ
	)

	if arquivo == null:
		push_error("Não foi possível abrir missoes.json")
		return

	var conteudo := arquivo.get_as_text()
	config = JSON.parse_string(conteudo)
	arquivo.close()
