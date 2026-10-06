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
var testes:Array
var tipo:String


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
	if not missoes.has(id):
		push_error("Missão não encontrada: " + id)
		return

	id_missao_ativa = id

	dados = missoes[id_missao_ativa]

	# Limpa os dados da missão anterior
	resposta.clear()
	testes.clear()

	# Dados básicos
	entradas = int(dados.get("entradas", 0))
	saidas = int(dados.get("saidas", 0))
	completo = bool(dados.get("completo", false))

	# Tipo da missão
	tipo = str(dados.get("tipo", "combinacional"))

	# Carrega os dados específicos de cada tipo
	if tipo == "sequencial":
		testes = dados.get("testes", [])
	else:
		resposta = []
		padronizar_dados()



func padronizar_dados() -> void:
	if tipo == "sequencial":
		return

	if not dados.has("resposta"):
		push_error(
			"Missão " + id_missao_ativa +
			" não possui campo 'resposta'."
		)
		return

	for i in range(2 ** entradas):
		var temp: Array = []

		for j in range(saidas):
			var valor = dados["resposta"][j][i]

			if valor is String:
				temp.append(valor)
			else:
				temp.append(int(valor))

		resposta.append(temp)

func repetir_missao(id) -> void:
	if not missoes.has(id):
		push_error("Missão não encontrada: " + id)
		return

	id_missao_ativa = id
	dados = missoes[id]

	completo = false
	dados["completo"] = false

	atualizar_arquivo()

	aceitar_missao(id)

func atualizar_arquivo() -> void:
	if not missoes.has(id_missao_ativa):
		push_error("Missão ativa não encontrada: " + id_missao_ativa)
		return
		
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
	if not missoes.has(id):
		return false
		
	return missoes[id]["completo"]

func liberar_prox_missoes() -> void:
	var proximas = dados.get("libera", [])

	if proximas == null:
		return

	for id in proximas:
		if missoes.has(id):
			missoes[id]["liberado"] = true
