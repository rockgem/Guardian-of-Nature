# A script for the main menu, extending Control to manage UI interactions.
# This is the gateway for players to begin their journey as the Guardian of the forest!
extends Control

# Called when the "Start" button is pressed.
# Transitions the player to the Playground scene, where the forest restoration begins!
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Playground.tscn")

# Called when the "Save" button is pressed.
# Currently a placeholder—add code here later to save the Guardian’s progress in the wild!
func _on_save_pressed() -> void:
	pass  # Replace with function body.

# Called when the "Exit" button is pressed.
# Safely closes the game, letting the Guardian rest until their next adventure!
func _on_exit_pressed() -> void:
	get_tree().quit()
