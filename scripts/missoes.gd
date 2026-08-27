extends Node

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
	var arquivo = FileAccess.open("res://dados/missoes.json", FileAccess.READ)
	
	if arquivo == null:
		push_error("Não foi possível abrir missoes.json")
		return
	
	var conteudo = arquivo.get_as_text()
	missoes = JSON.parse_string(conteudo)
	
	if missoes == null:
		push_error("Erro ao interpretar missoes.json")
		missoes = {}

func atualizar_missao(id: String) -> void:
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

func atualizar_arquivo() -> void:
	dados["completo"] = completo
	
	var arquivo = FileAccess.open("res://dados/missoes.json", FileAccess.WRITE)
	
	if arquivo == null:
		push_error("Não foi possível abrir missoes.json para escrita")
		return
	
	arquivo.store_string(JSON.stringify(missoes, "\t"))
	arquivo.close()
