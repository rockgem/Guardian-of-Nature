# A script for the main menu, extending Control to manage UI interactions.
# This is the gateway for players to begin their journey as the Guardian of the forest!
extends Control

# Called when the "Start" button is pressed.
# Transitions the player to the Playground scene, where the forest restoration begins!
func _on_start_pressed() -> void:
	ManagerGame.load_scene("res://scenes/environment/Playground.tscn")

# Called when the "Save" button is pressed.
# Currently a placeholder—add code here later to save the Guardian’s progress in the wild!
func _on_load_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
