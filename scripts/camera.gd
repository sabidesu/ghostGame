extends CharacterBody2D


const SPEED = 300.0


func _process(_delta: float) -> void:
	var screen_size_x: int = get_viewport().size.x
	var screen_size_y: int = get_viewport().size.y
	var mouse_position_x: float = get_viewport().get_mouse_position().x
	var mouse_position_y: float = get_viewport().get_mouse_position().y

	if mouse_position_x >= 0 && mouse_position_x <= screen_size_x:
		position.x = mouse_position_x
	if mouse_position_y >= 0 && mouse_position_y <= screen_size_y:
		position.y = mouse_position_y

