extends Control

@onready var entradas: Control = %Entradas
@onready var saidas: Saidas = %Saidas
@onready var portas: Control = %Portas
@onready var dialogo: AcceptDialog = %Dialog
@onready var fechar:FecharButton = $"../Camera2D/UI/FecharButton"
@onready var tabela: GridContainer = %Tabela
@onready var label:Label = %Label
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
				label.text = "Não existe caminho até a saída"
				for filho in tabela.get_children():
					filho.queue_free()
				dialogo.visible = true
				return
			resultado_saida.append(1 if saida_porta.sinal else 0)

		saida.append(resultado_saida)

	mostrar_tabela()
	verificar_resultado()


func verificar_resultado() -> void:
	for i in range(saida.size()):
		var resultado = saida[i]

		if resultado != respostas_certas[i]:
			label.text = "RESPOSTA ERRADA"
			dialogo.visible = true
			return

	label.text = "ACERTOU!\n
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

func criar_celula(texto: String, cor: Color = Color.WHITE) -> void:
	var label := Label.new()
	label.text = texto
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.custom_minimum_size = Vector2(70, 30)

	label.add_theme_color_override("font_color", cor)

	tabela.add_child(label)



func mostrar_tabela() -> void:
	# Remove a tabela anterior
	for filho in tabela.get_children():
		filho.queue_free()

	# Entradas + 2 colunas para cada saída
	tabela.columns = quantidade_entradas + (quantidade_saidas * 2)

	# Cabeçalho das entradas
	for i in range(quantidade_entradas):
		criar_celula("E" + str(i + 1))

	# Cabeçalho das saídas
	for i in range(quantidade_saidas):
		criar_celula("S" + str(i + 1))
		criar_celula("Esp. S" + str(i + 1))

	# Linhas da tabela
	for linha in range(saida.size()):

		# Valores das entradas
		var possibilidade: Array = possibilidades_entradas[linha]

		for valor in possibilidade:
			criar_celula("1" if valor else "0")

		# Valores das saídas
		for coluna in range(quantidade_saidas):
			var valor = saida[linha][coluna]
			var esperado = respostas_certas[linha][coluna]

			# Saída obtida
			var cor := Color.GREEN if valor == esperado else Color.RED
			criar_celula(str(valor), cor)

			# Saída esperada
			criar_celula(str(esperado), Color.WHITE)
