extends Control

func _ready() -> void:
	await get_tree().create_timer(2.0).timeout

	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	await get_tree().process_frame


	DisplayServer.window_set_size(Vector2i(1280, 720))

	await get_tree().process_frame
