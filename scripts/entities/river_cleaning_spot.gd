# scripts/river_cleaning_spot.gd
extends Area2D

signal river_cleaned

@export var clean_river_scene: PackedScene

func _ready():
	pass

func _on_body_entered(body):
	if body.name == "Player" and Input.is_action_just_pressed("ui_accept"):
		var clean_river = clean_river_scene.instantiate()
		get_parent().add_child(clean_river)
		clean_river.global_position = global_position
		emit_signal("river_cleaned")
		queue_free() # Remove the cleaning spot
