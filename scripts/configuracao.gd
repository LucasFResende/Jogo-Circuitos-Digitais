extends Control

var resolucoes: Array[Vector2i] = [
	Vector2i(1920, 1080),
	Vector2i(1600, 900),
	Vector2i(1366, 768),
	Vector2i(1280, 720),
	Vector2i(960, 540),
	Vector2i(854, 480),
	Vector2i(640, 360)
]
const ARQUIVO_USUARIO := "user://config.json"
var resolucao_atual: Vector2i

func _ready() -> void:
	var modo := DisplayServer.window_get_mode()

	if modo == DisplayServer.WINDOW_MODE_FULLSCREEN:
		%ModoButton.select(0)
		%ResolucaoContainer.visible = false
	else:
		%ModoButton.select(1)
		%ResolucaoContainer.visible = true

	var tamanho := DisplayServer.window_get_size()
	var index := resolucoes.find(tamanho)

	if index >= 0:
		resolucao_atual = resolucoes[index]
	else:
		resolucao_atual = Vector2i(1920, 1080)
		index = 0
	%ResolucaoButton.select(index)


func _on_modo_button_item_selected(index: int) -> void:
	match index:
		0:
			%ResolucaoContainer.visible = false
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			Global.config["modo"] = "fullscreen"
		1:
			%ResolucaoContainer.visible = true
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			await get_tree().create_timer(0.2).timeout
			DisplayServer.window_set_size(resolucao_atual)
			Global.config["modo"] = "janela"


func _on_resolucao_button_item_selected(index: int) -> void:
	resolucao_atual = resolucoes[index]
	Global.config["resolucao"] = [resolucao_atual.x,resolucao_atual.y]
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_size(resolucao_atual)


func _on_button_pressed() -> void:
	atualizar_arquivo()
	call_deferred("queue_free")

func atualizar_arquivo() -> void:
	var arquivo := FileAccess.open(
		ARQUIVO_USUARIO,
		FileAccess.WRITE
	)

	arquivo.store_string(JSON.stringify(Global.config, "\t"))
	arquivo.close()
