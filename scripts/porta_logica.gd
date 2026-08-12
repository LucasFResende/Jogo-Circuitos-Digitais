class_name PortaLogica
extends Node2D

var esta_arrastando: bool = false
var pode_duplicar:bool = true
var clique_offset: Vector2 = Vector2.ZERO
var posicao_origem: Vector2
var sinal:bool = 0
var esta_sobre_lixeira:bool = false

@export var ligar: Array[Area2D]

@onready var area_2d: Area2D = %ArrastarArea
@onready var id:int = rand_from_seed(self.name.hash())[0]
@onready var circuito:Control = get_tree().get_first_node_in_group("circuito")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_2d.input_event.connect(_on_area_2d_input_event)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.pressed and esta_arrastando:
			if pode_duplicar:
				esta_arrastando = false
				var posicao_final = global_position
				global_position = posicao_origem
				var novo_no: PortaLogica = duplicate()
				circuito.add_child(novo_no)
				novo_no.global_position = posicao_final
				novo_no.pode_duplicar = false
				novo_no.iniciar_no()
				if esta_sobre_lixeira:
					novo_no.call_deferred("queue_free")
			else:
				esta_arrastando = false
				if esta_sobre_lixeira:
					for i in get_children():
						if i.is_in_group("entrada"):
							if i.linha_ligada != null:
								i.linha_ligada.call_deferred("queue_free")
					call_deferred("queue_free")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	verificar_logica()
	if esta_arrastando:
		global_position = get_global_mouse_position() - clique_offset
	
func _on_area_2d_input_event(_viweport:Node, event:InputEvent, _shape_idx:int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			posicao_origem = global_position
			esta_arrastando = true
			clique_offset = get_global_mouse_position() - global_position

func verificar_logica() -> void:
	pass
	
func iniciar_no() -> void:
	for area in ligar:
		area.process_mode = Node.PROCESS_MODE_INHERIT
