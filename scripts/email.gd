extends Control

var contador_email:int = 10
var tem_email:bool = contador_email
@onready var cena_email = load("res://cenarios/email_mini.tscn")
@onready var container_email = %ContainerEmail

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if tem_email:
		for i in range(contador_email):
			var email = cena_email.instantiate()
			container_email.add_child(email)
