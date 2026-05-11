extends RayCast3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var obj = self.get_collider()
	
	if self.is_colliding() and obj.is_in_group("interagir"):
		%InteracaoUI.show()
		if Input.is_action_just_pressed("interacao"):
			obj.interagir()
	else:
		%InteracaoUI.hide()
