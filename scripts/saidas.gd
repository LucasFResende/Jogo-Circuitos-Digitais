class_name Saidas
extends Control

var circuito_atualizando:bool = false
signal circuito_atualizado

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not circuito_atualizando:
		return

	for i in get_children():
		if i.atualizando:
			return

	circuito_atualizando = false
	circuito_atualizado.emit()
