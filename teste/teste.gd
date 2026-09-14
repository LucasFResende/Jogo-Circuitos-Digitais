extends Control

func _ready() -> void:
	print("=== TESTE ===")
	print("Modo inicial: ", DisplayServer.window_get_mode())
	print("Tamanho inicial: ", DisplayServer.window_get_size())

	await get_tree().create_timer(2.0).timeout

	print("\n--- TENTANDO WINDOWED ---")

	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	await get_tree().process_frame

	print("Modo depois de windowed: ", DisplayServer.window_get_mode())

	DisplayServer.window_set_size(Vector2i(1280, 720))

	await get_tree().process_frame

	print("Tamanho depois: ", DisplayServer.window_get_size())
	print("Modo final: ", DisplayServer.window_get_mode())
