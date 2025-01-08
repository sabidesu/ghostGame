extends Area2D


var camera_hovering: bool = false


func _on_body_entered(_body:Node2D) -> void:
  camera_hovering = true
  print(camera_hovering)


func _on_ready() -> void:
  print(camera_hovering)


func _on_body_exited(_body:Node2D) -> void:
  camera_hovering = false
  print(camera_hovering)
