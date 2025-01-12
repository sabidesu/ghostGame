extends Area2D


@onready var camera: CharacterBody2D = %Camera
@onready var game_manager: Node = %GameManager
@onready var coyote_timer: Timer = $CoyoteTimer

enum States {FRESH, RIPE, ATTACK}

var camera_hovering: bool = false
var state: States = States.FRESH
var opacity_transition_time: float
var opacity_increment: float

func _on_ready() -> void:
  visible = false
  opacity_transition_time = game_manager.ghost_lifespan
  opacity_increment = 1 / opacity_transition_time

  set_modulate(Color(1, 1, 1, 0))

  camera.camera_shutter.connect(_on_camera_shutter)
  coyote_timer.timeout.connect(_on_coyote_timer_timeout)


func _on_body_entered(body: Node2D) -> void:
  if body == %Camera:
    visible = true
    camera_hovering = true


func _on_body_exited(body: Node2D) -> void:
  if body == %Camera:
    visible = false
    camera_hovering = false


func _on_camera_shutter() -> void:
  if camera_hovering && state == States.RIPE:
    queue_free()


func _process(delta: float) -> void:
  if visible:
    modulate.a += opacity_increment * delta

  match state:
    States.FRESH:
      if visible && modulate.a >= 0.5:
        state = States.RIPE
    States.RIPE:
      modulate.g = 0
      if modulate.a >= 1 && coyote_timer.is_stopped():
        coyote_timer.start()
    States.ATTACK:
      queue_free()


func _on_coyote_timer_timeout() -> void:
  print('attack')
  game_manager.subtract_health()
  state = States.ATTACK
