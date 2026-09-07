class_name Clock
extends PortaLogica

var tempo_clock:float = 0
var tempo_clock_padrao:float
var iniciado:bool = false

@onready var dialogo:AcceptDialog = %Dialogo
@onready var tempo_clock_input: LineEdit = %TempoClockInput

func _process(delta: float) -> void:
	if esta_arrastando:
		global_position = get_global_mouse_position() - clique_offset
	if !pode_duplicar:
		if !iniciado:
			dialogo.visible = true
		else:
			if tempo_clock<=0:
				verificar_logica()
				tempo_clock = tempo_clock_padrao
			else:
				tempo_clock-=delta

func verificar_logica() -> void:
	sinal = not sinal
	$Saida.sinal = sinal

	for child in %SaidaLigacao.get_children():
		child.atualizar()


func _on_dialogo_confirmed() -> void:
	var input = tempo_clock_input.text
	
	if !input.is_valid_float():
		tempo_clock_input.text = ""
		tempo_clock_input.placeholder_text = "Entrada inválida"
		return
	
	var tempo := input.to_float()
	
	if tempo <= 0:
		tempo_clock_input.text = ""
		tempo_clock_input.placeholder_text = "Digite um valor maior que 0"
		return
	
	tempo_clock = tempo
	tempo_clock_padrao = tempo
	iniciado = true
	
