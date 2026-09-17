extends Control

@export var rect:Rect2

func _draw() -> void:
	draw_rect(rect, Color.YELLOW,false,5)
