extends CharacterBody2D


@onready var reload_timer = $ReloadTimer

signal camera_shutter

enum States {READY, DISABLED}

var state: States = States.READY


func _on_ready() -> void:
	reload_timer.timeout.connect(_on_reload_timer_timeout)


func _process(_delta: float) -> void:
	camera_movement()

	if state == States.READY && Input.is_action_just_pressed("click"):
		camera_shutter.emit()
		state = States.DISABLED
		reload_timer.start()


func camera_movement() -> void:
	var screen_size_x: int = get_viewport().size.x
	var screen_size_y: int = get_viewport().size.y
	var mouse_position_x: float = get_viewport().get_mouse_position().x
	var mouse_position_y: float = get_viewport().get_mouse_position().y

	if mouse_position_x >= 0 && mouse_position_x <= screen_size_x:
		position.x = mouse_position_x
	if mouse_position_y >= 0 && mouse_position_y <= screen_size_y:
		position.y = mouse_position_y


func _on_reload_timer_timeout() -> void:
	state = States.READY
