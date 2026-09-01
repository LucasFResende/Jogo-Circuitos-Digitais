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
const FONTE_SINAL = preload("res://objetos/fonte_sinal.tscn")
const RECEPTOR_SINAL = preload("res://objetos/receptor_sinal.tscn")

var possibilidades_entradas: Array = []
var quantidade_entradas: int = 0
var quantidade_saidas: int = 0
var resposta_certa:bool = false

var saida: Array = []


func _ready() -> void:
	if !Missoes.completo:
		if Missoes.entradas:
			iniciar_entradas(Missoes.entradas)
		if Missoes.saidas:
			iniciar_saidas(Missoes.saidas)
		respostas_certas = Missoes.resposta
	else:
		%ConfirmarButton.disabled = true
		%ConfirmarButton.visible = false
		
func _process(delta: float) -> void:
	if resposta_certa:
		await dialogo.confirmed
		fechar.fechar_no()
	
func _on_confirmar_button_pressed() -> void:
	verificar_resposta()


func verificar_resposta() -> void:
	# Quantidade atual de entradas e saídas
	quantidade_entradas = entradas.get_child_count()
	quantidade_saidas = saidas.get_child_count()

	# Gera todas as combinações possíveis
	possibilidades_entradas = gerar_possibilidades(quantidade_entradas)

	# Limpa resultados anteriores
	saida.clear()

	print("================================")
	print("INICIANDO SIMULAÇÃO")
	print("================================")

	for possibilidade in possibilidades_entradas:

		for i in range(quantidade_saidas):
			var saida_porta: PortaLogica = saidas.get_child(i)
			saida_porta.atualizando = true
		
		for i in range(quantidade_entradas):
			var entrada: FonteSinal = entradas.get_child(i)
			entrada.definir_sinal(possibilidade[i])
			
		var resultado_saida: Array = []

		for i in range(quantidade_saidas):
			var saida_porta: PortaLogica = saidas.get_child(i)
			if saida_porta.atualizando:
				dialogo.dialog_text = "Não existe caminho até a saída"
				dialogo.visible = true
				return
			resultado_saida.append(1 if saida_porta.sinal else 0)

		saida.append(resultado_saida)

	print("================================")
	print("SIMULAÇÃO TERMINADA")
	print("Resultados: ", saida)
	print("Esperado: ", respostas_certas)
	print("================================")

	verificar_resultado()


func verificar_resultado() -> void:
	for i in range(saida.size()):
		var resultado = saida[i]

		if resultado != respostas_certas[i]:
			dialogo.dialog_text = "
			RESPOSTA ERRADA\n
			\nEsperado: "+ str(respostas_certas)+"
			\nResultado: "+ str(saida)
			dialogo.visible = true
			return

	dialogo.dialog_text = "ACERTOU!\n
	Confira o email para ver a(s) nova(s) missão(ões)."
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
	
func iniciar_entradas(quant_entradas: int) -> void:
	var pos_ini: Vector2 = Vector2(140,100)
	var x = 65
	for i in range(quant_entradas):
		var entrada:FonteSinal = FONTE_SINAL.instantiate()
		entradas.add_child(entrada)
		entrada.global_position = pos_ini+ Vector2(0,100)*i
		entrada.pode_duplicar = false
		entrada.adicionar()

func iniciar_saidas(quant_saidas: int) -> void:
	var pos_ini:Vector2 = Vector2(1300,100)
	for i in range(quant_saidas):
		var saida:ReceptorSinal = RECEPTOR_SINAL.instantiate()
		saidas.add_child(saida)
		saida.global_position = pos_ini + Vector2(0,100)*i
		saida.pode_duplicar = false
		saida.adicionar()
