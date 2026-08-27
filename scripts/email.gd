extends Control

var contador_email:int = 10
var tem_email:bool = contador_email
var foldable_group: FoldableGroup
@onready var cena_email = load("res://cenarios/email_mini.tscn")
@onready var container_email = %ContainerEmail

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if tem_email:
		foldable_group = FoldableGroup.new()
		foldable_group.allow_folding_all = true
		for i in range(len(Missoes.missoes)):
			var data = Missoes.missoes[str(i+1)]
			if data["liberado"]:
				var email = cena_email.instantiate() as EmailMini
				email.id = str(i+1)
				email.foldable_group = foldable_group
				email.title = data["titulo"]
				email.get_child(0).get_child(0).text = data["descricao"]
				email.folded = true
				container_email.add_child(email)
				if data["completo"]:
					email.completo_sprite.visible = true
