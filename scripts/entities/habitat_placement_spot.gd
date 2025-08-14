# scripts/habitat_placement_spot.gd
extends Area2D

signal habitat_placed

@export var habitat_scene: PackedScene

func _ready():
	pass

func _on_body_entered(body):
	if body.name == "Player" and Input.is_action_just_pressed("ui_accept"):
		var habitat = habitat_scene.instantiate()
		get_parent().add_child(habitat)
		habitat.global_position = global_position
		emit_signal("habitat_placed")
		queue_free() # Remove the placement spot
