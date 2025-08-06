extends Control


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Playground.tscn")


func _on_load_pressed() -> void:
	print("Load Pressed")


func _on_quit_pressed() -> void:
	get_tree().quit()
