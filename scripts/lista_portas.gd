extends HBoxContainer

@export var lista: Array[PackedScene]
var offset:int = 0
@export var lista_nos:Array[Control]

@onready var fonte:PackedScene = load("res://objetos/fonte_sinal.tscn")
@onready var receptor:PackedScene = load("res://objetos/receptor_sinal.tscn")

func _ready() -> void:
	if Missoes.completo:
		var temp: Array[PackedScene] = [fonte, receptor]
		lista = temp+lista
	atualizar_lista_exibida()

func atualizar_lista_exibida() -> void:
	for i in range(len(lista_nos)):
		var no:Control = lista_nos[i]
		if no.get_child_count()>0:
			no.get_child(0).call_deferred("queue_free")
		no.add_child(lista[i+offset].instantiate())

func _on_esquerda_button_pressed() -> void:
	if offset == 0:
		pass
	else:
		offset-=1
		atualizar_lista_exibida()


func _on_direira_button_pressed() -> void:
	if len(lista_nos)+offset > len(lista)-1:
		pass
	else:
		offset+=1
		atualizar_lista_exibida()


func _on_mouse_entered() -> void:
	Global.mudar_mouse_selecao()

func _on_mouse_exited() -> void:
	Global.mudar_mouse_padrao()
