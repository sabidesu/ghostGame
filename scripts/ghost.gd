extends Area2D


@onready var camera: CharacterBody2D = %Camera

var camera_hovering: bool = false


func _on_ready() -> void:
  camera.camera_shutter.connect(_on_camera_shutter)


func _on_body_entered(_body:Node2D) -> void:
  camera_hovering = true


func _on_body_exited(_body:Node2D) -> void:
  camera_hovering = false


func _on_camera_shutter() -> void:
  if camera_hovering:
    queue_free()
