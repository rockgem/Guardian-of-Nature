extends Control


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Playground.tscn")


func _on_save_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
