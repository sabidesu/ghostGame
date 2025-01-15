extends Node


@export var ghost_lifespan: float = 3.0
@export var health: int = 3

@onready var ghosts: Node = %Ghosts

var ghost_scene: PackedScene = load("res://scenes/ghost.tscn")


func subtract_health():
  health -= 1


func _process(_delta: float) -> void:
  if health <= 0:
    print('you died')
    get_tree().reload_current_scene()


func _on_ghost_spawn_timer_timeout() -> void:
  var ghost_scene_instance: Node = ghost_scene.instantiate()

  ghost_scene_instance.position.x = int(randf() * get_viewport().get_visible_rect().size.x) #- get_node("Sprite2D").texture.width
  ghost_scene_instance.position.y = int(randf() * get_viewport().get_visible_rect().size.y) #- get_node("Sprite2D").texture.height
  ghosts.add_child(ghost_scene_instance)

  print(ghost_scene_instance.position)
  print("spawn ghost")
