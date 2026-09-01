extends Node

const ARQUIVO_ORIGINAL := "res://dados/missoes.json"
const ARQUIVO_USUARIO := "user://missoes.json"

var id_missao_ativa: String = ""
var resposta: Array
var entradas: int
var saidas: int
var completo: bool = true
var dados: Dictionary
var missoes: Dictionary


func _ready() -> void:
	carregar_arquivo()


func carregar_arquivo() -> void:
	if not FileAccess.file_exists(ARQUIVO_USUARIO):
		var arquivo_original := FileAccess.open(
			ARQUIVO_ORIGINAL,
			FileAccess.READ
		)

		if arquivo_original == null:
			push_error("Não foi possível abrir missoes.json original")
			return

		var conteudo := arquivo_original.get_as_text()
		arquivo_original.close()

		var arquivo_usuario := FileAccess.open(
			ARQUIVO_USUARIO,
			FileAccess.WRITE
		)

		if arquivo_usuario == null:
			push_error("Não foi possível criar missoes.json do usuário")
			return

		arquivo_usuario.store_string(conteudo)
		arquivo_usuario.close()

	# Agora sempre trabalha com a cópia gravável.
	var arquivo := FileAccess.open(
		ARQUIVO_USUARIO,
		FileAccess.READ
	)

	if arquivo == null:
		push_error("Não foi possível abrir missoes.json")
		return

	var conteudo := arquivo.get_as_text()
	missoes = JSON.parse_string(conteudo)
	arquivo.close()

	if missoes == null:
		push_error("Erro ao interpretar missoes.json")
		missoes = {}


func aceitar_missao(id: String) -> void:
	id_missao_ativa = id

	dados = missoes[id_missao_ativa]
	resposta = dados["resposta"]

	padronizar_dados()

	entradas = dados["entradas"]
	saidas = dados["saidas"]
	completo = dados["completo"]


func padronizar_dados() -> void:
	for x in resposta:
		for i in range(len(x)):
			x[i] = int(x[i])

func repetir_missao(id) -> void:
	id_missao_ativa = id
	dados = missoes[id]
	completo = false
	dados["completo"] = false
	atualizar_arquivo()
	aceitar_missao(id)

func atualizar_arquivo() -> void:
	dados["completo"] = completo
	missoes[id_missao_ativa]["completo"] = completo
	
	var arquivo := FileAccess.open(
		ARQUIVO_USUARIO,
		FileAccess.WRITE
	)

	if arquivo == null:
		push_error("Não foi possível abrir missoes.json para escrita")
		return

	arquivo.store_string(JSON.stringify(missoes, "\t"))
	arquivo.close()

func verificar_completo(id: String) -> bool:
	return missoes[id]["completo"]
