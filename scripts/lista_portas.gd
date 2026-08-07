extends HBoxContainer

@export var lista: Array[PackedScene]
var offset:int = 0
@export var lista_nos:Array[Control] 

func _ready() -> void:
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
	Input.set_custom_mouse_cursor(load(Global.mouse_selecao),Input.CURSOR_ARROW,Vector2(15,0))


func _on_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(load(Global.mouse_padrao))
