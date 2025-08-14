# scripts/tree_planting_spot.gd
extends Area2D

signal tree_planted

@export var tree_scene: PackedScene

func _ready():
	pass

func _on_body_entered(body):
	if body.name == "Player" and Input.is_action_just_pressed("ui_accept"):
		var tree = tree_scene.instantiate()
		get_parent().add_child(tree)
		tree.global_position = global_position
		emit_signal("tree_planted")
		queue_free() # Remove the planting spot
