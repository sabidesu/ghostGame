extends Node


var health: int = 3


func subtract_health():
  health -= 1


func _process(_delta: float) -> void:
  if health <= 0:
    print('you died')
    get_tree().reload_current_scene()
