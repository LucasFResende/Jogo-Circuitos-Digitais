extends Node2D

var is_dragging: bool = false
var click_offset: Vector2 = Vector2.ZERO

@onready var area_2d: Area2D = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_2d.input_event.connect(_on_area_2d_input_event)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.pressed:
			is_dragging = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_dragging:
		global_position = get_global_mouse_position() - click_offset
	
func _on_area_2d_input_event(viweport:Node, event:InputEvent, shape_idx:int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_dragging = true
			click_offset = get_global_mouse_position() - global_position
