extends Sprite2D

@onready var lixeira_fechada = load("res://addons/cenario/lixeira1.png")
@onready var lixeira_aberta = load("res://addons/cenario/lixeira2.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	var porta:PortaLogica = area.get_parent()
	if porta.esta_arrastando:
		self.texture = lixeira_aberta
	porta.esta_sobre_lixeira = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	self.texture = lixeira_fechada
	var porta:PortaLogica = area.get_parent()
	porta.esta_sobre_lixeira = false
