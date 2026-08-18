class_name Conexao
extends Line2D

@onready var porta_saida: Saida
@onready var porta_entrada: Entrada
var sinal:int = 0

var p1:Vector2
var p2:Vector2
var cor_desligado: Color = Color.DARK_RED
var cor_ligado: Color = Color.RED
var pode_deletar:bool = false
var mouse_sobre_linha: bool = false
var distancia_mouse: float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	default_color = cor_desligado
	width = 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if porta_entrada and porta_saida:
		set_point_position(0, to_local(porta_saida.global_position))
		set_point_position(1, to_local(porta_entrada.global_position))

		sinal = porta_saida.sinal
		porta_entrada.sinal = sinal

		if not Input.is_action_pressed("btn_esquerdo"):
			pode_deletar = true

	if sinal:
		default_color = cor_ligado
	else:
		default_color = cor_desligado

	verificar_mouse()


func verificar_mouse() -> void:
	var pos_mouse := get_local_mouse_position()

	var ponto_mais_proximo := Geometry2D.get_closest_point_to_segment(
		pos_mouse,
		get_point_position(0),
		get_point_position(1)
	)

	var sobre_linha := pos_mouse.distance_to(ponto_mais_proximo) <= distancia_mouse

	# Mouse entrou na linha
	if sobre_linha and not mouse_sobre_linha:
		mouse_sobre_linha = true
		Global.mudar_mouse_selecao()

	# Mouse saiu da linha
	elif not sobre_linha and mouse_sobre_linha:
		mouse_sobre_linha = false
		Global.mudar_mouse_padrao()

	# Clique sobre a linha
	if sobre_linha and Input.is_action_just_pressed("btn_esquerdo"):
		if pode_deletar:
			Global.mudar_mouse_padrao()
			queue_free()
