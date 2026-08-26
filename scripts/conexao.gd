class_name Conexao
extends Line2D

@onready var porta_saida: Saida
@onready var porta_entrada: Entrada
var porta_logica_entrada: PortaLogica
var sinal:int = 0

var p1:Vector2
var p2:Vector2
var cor_desligado: Color = Color.DARK_RED
var cor_ligado: Color = Color.RED
var pode_deletar:bool = false
var mouse_sobre_linha: bool = false
var distancia_mouse: float = 5.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	default_color = cor_desligado
	width = 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if porta_entrada and porta_saida:
		set_point_position(0, to_local(porta_saida.global_position))
		set_point_position(1, to_local(porta_entrada.global_position))


		if not Input.is_action_pressed("btn_esquerdo"):
			pode_deletar = true

	if sinal:
		default_color = cor_ligado
	else:
		default_color = cor_desligado

	verificar_mouse()

func atualizar() -> void:
	sinal = porta_saida.sinal
	porta_entrada.sinal = sinal
	porta_logica_entrada.verificar_logica()

	

func verificar_mouse() -> void:
	var pos_mouse = get_global_mouse_position()

	var distancia_saida = pos_mouse.distance_to(porta_saida.global_position)

	var perto_de_uma_porta = distancia_saida <= 15.0

	var pos_mouse_local = get_local_mouse_position()

	var ponto_mais_proximo = Geometry2D.get_closest_point_to_segment(
		pos_mouse_local,
		get_point_position(0),
		get_point_position(1)
	)

	var sobre_linha = pos_mouse_local.distance_to(ponto_mais_proximo) <= distancia_mouse

	if sobre_linha and not mouse_sobre_linha:
		mouse_sobre_linha = true
		Global.mudar_mouse_selecao()

	elif not sobre_linha and mouse_sobre_linha:
		mouse_sobre_linha = false
		Global.mudar_mouse_padrao()

	if sobre_linha and not perto_de_uma_porta:
		if pode_deletar and Input.is_action_just_pressed("btn_esquerdo"):
			Global.mudar_mouse_padrao()
			queue_free()
