extends Area2D


@onready var camera: CharacterBody2D = %Camera
@onready var timer: Timer = $Timer

enum States {FRESH, RIPE}

var camera_hovering: bool = false
var state: States = States.FRESH
var opacity_increment: float


func _on_ready() -> void:
  opacity_increment = 1 / timer.wait_time
  set_modulate(Color(1, 1, 1, 0))
  camera.camera_shutter.connect(_on_camera_shutter)


func _on_body_entered(body:Node2D) -> void:
  if body == %Camera:
    camera_hovering = true


func _on_body_exited(body:Node2D) -> void:
  if body == %Camera:
    camera_hovering = false


func _on_camera_shutter() -> void:
  if camera_hovering && state == States.RIPE:
    queue_free()


func _process(delta: float) -> void:
  modulate.a += opacity_increment * delta

  if timer.time_left <= timer.wait_time / 2:
    state = States.RIPE
    print('getting there')

  if timer.is_stopped():
    print('ya juice is ready')
