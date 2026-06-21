extends Node2D

var birdy_scene = preload("res://flying_birdy_bird.tscn")
var markerlefttop: Marker2D
var markerleftbottom: Marker2D
var markerrighttop: Marker2D
var markerrightbottom: Marker2D
var spawner_time_window: Timer
func _ready() -> void:
	print("birdy spawner ready")
	markerlefttop = get_node("markerlefttop")
	markerleftbottom = get_node("markerleftbottom")
	markerrighttop = get_node("markerrighttop")
	markerrightbottom = get_node("markerrightbottom")
	spawner_time_window = get_node("spawner_time_window")
	GameManager.spawn_birdy.connect(run_spawn_window)
	GameManager.start_spawn_birdy()
	
func spawn_birdy():
	var new_birdy = birdy_scene.instantiate()
	var spawn_left = randf() < 0.5
	var spawn_x
	var spawn_y
	if spawn_left:
		spawn_x = markerlefttop.position.x
		spawn_y = randf_range(markerlefttop.position.y, markerleftbottom.position.y)
		new_birdy.birdy_spawn_side = "left"
		new_birdy.despawn_x = markerrighttop.position.x
	else:
		spawn_x = markerrighttop.position.x
		spawn_y = randf_range(markerrighttop.position.y, markerrightbottom.position.y)
		new_birdy.birdy_spawn_side = "right"
		new_birdy.despawn_x = markerlefttop.position.x
	var spawn_position = Vector2(spawn_x, spawn_y)
	new_birdy.position = spawn_position
	add_child(new_birdy)
func run_spawn_window():
	print("birdy window started")
	spawner_time_window.wait_time = GameManager.birdy_spawn_window_time
	var spawn_times = []
	for spawning_birdy in range(GameManager.birdy_spawn_amount):
		var spawner_random_spawn_time = randf_range(0, spawner_time_window.wait_time)
		spawn_times.append(spawner_random_spawn_time)
	
	for spawn_time in spawn_times:
		await get_tree().create_timer(spawn_time).timeout
		spawn_birdy()
	
	run_spawn_window()
