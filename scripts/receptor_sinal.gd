class_name ReceptorSinal
extends PortaLogica

@onready var ligado = load("res://addons/portas_logicas/receptor_sinal2.png")
@onready var desligado = load("res://addons/portas_logicas/receptor_sinal1.png")
@onready var variavel:Label = %Variavel



func verificar_logica() -> void:
	if $Entrada.sinal:
		set("texture", ligado)
	else:
		set("texture", desligado)

	sinal = $Entrada.sinal

	atualizando = false

func set_variavel(texto:String) -> void:
	variavel.text = texto
	variavel.visible = true

func adicionar() -> void:
	var quantidade:int = get_parent().get_child_count()
	set_variavel("X"+str(quantidade))
	nome.set("theme_override_colors/font_color",Color.WHITE)
