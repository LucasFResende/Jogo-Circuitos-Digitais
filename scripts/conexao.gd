class_name Conexao
extends Line2D

@onready var porta_saida: Saida
@onready var porta_entrada: Entrada
var sinal:int = 0

var cor_desligado: Color = Color.DARK_RED
var cor_ligado: Color = Color.RED

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	default_color = cor_desligado
	width = 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if porta_entrada and porta_saida:
		set_point_position(0, to_local(porta_saida.global_position))
		set_point_position(1, to_local(porta_entrada.global_position))
		sinal = porta_saida.sinal
		porta_entrada.sinal = sinal
	
	if sinal:
		default_color = cor_ligado
	else:
		default_color = cor_desligado
		
	
