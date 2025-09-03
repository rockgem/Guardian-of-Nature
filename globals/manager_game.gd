extends Node

signal fader_step_finished
signal fader_finished
signal scene_loaded


var player_data = {}


var fader_duration = .5
var scene_path_being_loaded = ''


func _ready() -> void:
	player_data = get_data("res://reso/data/player_data.json")


func get_data(path) -> Dictionary:
	var f = FileAccess.open(path, FileAccess.READ)
	var j = JSON.new()
	j.parse(f.get_as_text())
	
	return j.data


func load_scene(path):
	await fade_in()
	
	scene_path_being_loaded = path
	ResourceLoader.load_threaded_request(scene_path_being_loaded)


func fade():
	var mat = $CanvasLayer/Fader.get('material')
	var t = create_tween()
	t.step_finished.connect(on_step_finished)
	
	t.tween_property(mat, 'shader_parameter/progress', 1.0, fader_duration)
	t.tween_property(mat, 'shader_parameter/progress', 0.0, fader_duration)


func fade_in():
	var mat = $CanvasLayer/Fader.get('material')
	var t = create_tween()
	
	t.tween_property(mat, 'shader_parameter/progress', 1.0, fader_duration)
	
	return t.finished


func fade_out():
	var mat = $CanvasLayer/Fader.get('material')
	var t = create_tween()
	
	t.tween_property(mat, 'shader_parameter/progress', 0.0, fader_duration)
	
	return t.finished


func on_step_finished(idx):
	fader_step_finished.emit()
