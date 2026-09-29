class_name Manual
extends Control

var index_exibido:int = -1

@onready var pagina_container:Control = %PaginaContainer
@onready var menu_container:Control = %MenuContainer
@onready var pagina_visivel_1:TextureRect = %PaginaVisivel1
@onready var pagina_visivel_2:TextureRect = %PaginaVisivel2

var paginas:Dictionary[int, String] = {
	#0
	0:"res://addons/paginas_manual/circ_dig.png",
	1:"res://addons/paginas_manual/num_bin.png",
	#2
	2:"res://addons/paginas_manual/tab_ver.png",
	3:"res://addons/paginas_manual/porta_logica.png",
	#4
	4:"res://addons/paginas_manual/porta_or.png",
	5:"res://addons/paginas_manual/porta_and.png",
	#6
	6:"res://addons/paginas_manual/porta_not.png",
	7:"res://addons/paginas_manual/porta_nor.png",
	#8
	8:"res://addons/paginas_manual/porta_nand.png",
	9:"res://addons/paginas_manual/porta_xor.png",
	#10
	10:"res://addons/paginas_manual/porta_xnor.png",
	11:"res://addons/paginas_manual/alg_exp_bool.png",
	#12
	12:"res://addons/paginas_manual/teo_bool.png",
	13:"res://addons/paginas_manual/teo_demo.png",
	#14
	14:"res://addons/paginas_manual/simp_circ_log.png",
	15:"res://addons/paginas_manual/simp_mapa_k_1.png",
	#16
	16:"res://addons/paginas_manual/simp_mapa_k_2.png",
	17:"res://addons/paginas_manual/simp_mapa_k_3.png",
	#18
	18:"res://addons/paginas_manual/simp_mapa_k_4.png",
	19:"res://addons/paginas_manual/simp_mapa_k_5.png",
	#20
	20:"res://addons/paginas_manual/simp_mapa_k_6.png",
	21:"res://addons/paginas_manual/simp_mapa_k_7.png",
	#22
	22:"res://addons/paginas_manual/arit_dig_num_com_sinal.png",
	23:"res://addons/paginas_manual/art_dig_adicao.png",
	#24
	24:"res://addons/paginas_manual/art_dig_sub.png",
	25:"res://addons/paginas_manual/art_dig_overflow.png",
	#26
	26:"res://addons/paginas_manual/circ_arit.png",
	27:"res://addons/paginas_manual/pulsos.png",
	#28
	28:"res://addons/paginas_manual/sinais_de_clock.png",
	29:"res://addons/paginas_manual/flip-flop.png",
	#30
	30:"res://addons/paginas_manual/flip-flop_latch_nand.png",
	31:"res://addons/paginas_manual/flip-flop_latch_nor.png",
	#32
	32:"res://addons/paginas_manual/flip-flop_s_r_clock.png",
	33:"res://addons/paginas_manual/flip-flop_j_k_clock.png",
	#34
	34:"res://addons/paginas_manual/flip-flop_d_clock.png",
	35:"res://addons/paginas_manual/flip-flop_entradas_assin.png",
	#36
	36:"res://addons/paginas_manual/registradores.png",
	37:"res://addons/paginas_manual/registradores_fotos.png",
	#38
	38:"res://addons/paginas_manual/contadores_assin.png",
	39:"res://addons/paginas_manual/contadores_sinc.png",
}



func _on_mouse_entered() -> void:
	Global.mudar_mouse_selecao()


func _on_mouse_exited() -> void:
	Global.mudar_mouse_padrao()

func ir_para_conteudo(index:int) -> void:
	pagina_container.visible = true
	menu_container.visible = false
	pagina_visivel_1.texture = load(paginas[index])
	pagina_visivel_2.texture = load(paginas[index+1])
	index_exibido = index

func ir_para_menu() -> void:
	pagina_container.visible = false
	menu_container.visible = true


func _on_voltar_button_pressed() -> void:
	ir_para_menu()


func _on_esquerda_button_pressed() -> void:
	if index_exibido==0:
		ir_para_menu()
		index_exibido=-1
	elif index_exibido==-1:
		return
	else:
		ir_para_conteudo(index_exibido-2)



func _on_direira_button_pressed() -> void:
	if index_exibido==-1:
		ir_para_conteudo(0)
	elif !(index_exibido==38):
		ir_para_conteudo(index_exibido+2)
