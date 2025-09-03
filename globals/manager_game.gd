extends Node

signal fader_step_finished
signal fader_finished
signal scene_loaded


var player_data = {}

var fader_duration = 1.0

var scene_path_being_loaded = ''
var mininum_load_time = 1.0
var load_time_tick = 0.0


func _ready() -> void:
	player_data = get_data("res://reso/data/player_data.json")


func _physics_process(delta: float) -> void:
	if scene_path_being_loaded != '':
		load_time_tick += delta
		
		var e: ResourceLoader.ThreadLoadStatus = ResourceLoader.load_threaded_get_status(scene_path_being_loaded)
		
		if e == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED and load_time_tick > mininum_load_time:
			get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(scene_path_being_loaded))
			
			await get_tree().create_timer(1.0).timeout
			
			scene_path_being_loaded = ''
			$LoadingScreen.visible = false
			
			scene_loaded.emit()
			fade_out()
		else:
			$LoadingScreen.visible = true


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
