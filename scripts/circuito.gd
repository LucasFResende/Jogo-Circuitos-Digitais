extends Control

@onready var entradas: Control = %Entradas
@onready var saidas: Saidas = %Saidas
@onready var portas: Control = %Portas
@onready var dialogo: AcceptDialog = %Dialog
@onready var fechar:FecharButton = $"../Camera2D/UI/FecharButton"
@export var no_pai:Control

var resp_quantidade_entradas: int
var resp_quantidade_saida: int
var respostas_certas: Array

var possibilidades_entradas: Array = []
var quantidade_entradas: int = 0
var quantidade_saidas: int = 0
var resposta_certa:bool = false

var saida: Array = []


func _ready() -> void:
	if !Missoes.completo:
		resp_quantidade_entradas = Missoes.entradas
		resp_quantidade_saida = Missoes.saidas
		respostas_certas = Missoes.resposta
	else:
		%ConfirmarButton.disabled = true
		%ConfirmarButton.visible = false
		
	
func _on_confirmar_button_pressed() -> void:
	verificar_resposta()


func verificar_resposta() -> void:
	# Quantidade atual de entradas e saídas
	quantidade_entradas = entradas.get_child_count()
	quantidade_saidas = saidas.get_child_count()

	# Verifica se a quantidade está correta
	if quantidade_entradas != resp_quantidade_entradas:
		dialogo.dialog_text = "Quantidade de entradas errada"
		dialogo.visible = true
		return

	if quantidade_saidas != resp_quantidade_saida:
		dialogo.dialog_text = "Quantidade de saidas errada"
		dialogo.visible = true
		return

	# Gera todas as combinações possíveis
	possibilidades_entradas = gerar_possibilidades(quantidade_entradas)

	# Limpa resultados anteriores
	saida.clear()

	print("================================")
	print("INICIANDO SIMULAÇÃO")
	print("================================")

	for possibilidade in possibilidades_entradas:

		for i in range(quantidade_entradas):
			var entrada: FonteSinal = entradas.get_child(i)
			entrada.definir_sinal(possibilidade[i])

		var resultado_saida: Array = []

		for i in range(quantidade_saidas):
			var saida_porta: PortaLogica = saidas.get_child(i)
			resultado_saida.append(1 if saida_porta.sinal else 0)

		saida.append(resultado_saida)

	print("================================")
	print("SIMULAÇÃO TERMINADA")
	print("Resultados: ", saida)
	print("Esperado: ", respostas_certas)
	print("================================")

	verificar_resultado()


func verificar_resultado() -> void:
	if saida.size() != respostas_certas.size():
		return

	for i in range(saida.size()):
		var resultado = saida[i]

		if resultado != respostas_certas[i]:
			dialogo.dialog_text = "
			RESPOSTA ERRADA\n
			Esperado: " + str(respostas_certas[i]) + "
			\nRecebido: "+ str(resultado)+ "
			\nEsperado: "+ str(respostas_certas)+"
			\nResultado: "+ str(saida)
			dialogo.visible = true
			return

	dialogo.dialog_text = "ACERTOU"
	dialogo.visible = true
	resposta_certa = true
	Missoes.completo = true
	Missoes.atualizar_arquivo()


func gerar_possibilidades(quantidade: int) -> Array:
	var resultado: Array = []

	# 2^quantidade
	var total := 1 << quantidade

	for n in range(total):
		var possibilidade: Array = []

		for i in range(quantidade):
			var valor: bool = (n & (1 << i)) != 0
			possibilidade.append(valor)

		resultado.append(possibilidade)

	return resultado
	
func _process(delta: float) -> void:
	if resposta_certa:
		await dialogo.confirmed
		fechar.fechar_no()
