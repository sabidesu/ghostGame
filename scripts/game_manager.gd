extends Node


@export var ghost_lifespan: float = 3.0
@export var health: int = 3

@onready var ghosts: Node = %Ghosts

var ghost_scene: PackedScene = load("res://scenes/ghost.tscn")


func subtract_health() -> void:
  health -= 1


func _process(_delta: float) -> void:
  if health <= 0:
    print('you died')
    get_tree().reload_current_scene()


func _on_ghost_spawn_timer_timeout() -> void:
  var ghost_scene_instance: Node = ghost_scene.instantiate()

  ghost_scene_instance.position.x = generate_random_x(ghost_scene_instance)
  ghost_scene_instance.position.y = generate_random_y(ghost_scene_instance)
  ghosts.add_child(ghost_scene_instance)

  print(ghost_scene_instance.position)
  print("spawn ghost")


func generate_random_x(ghost_instance: Node) -> int:
  # NOTE: texture_width also functions as left border
  var texture_width: int = ghost_instance.get_node("Sprite2D").texture.get_width()
  var play_area_width: float = get_viewport().get_visible_rect().size.x - texture_width * 2

  return texture_width + int(randf() * play_area_width)


func generate_random_y(ghost_instance: Node) -> int:
  # NOTE: texture_height also functions as top border
  var texture_height: int = ghost_instance.get_node("Sprite2D").texture.get_height()
  var play_area_height: float = get_viewport().get_visible_rect().size.y - texture_height * 2

  return texture_height + int(randf() * play_area_height)
