extends Node2D
var tumbleweed_scene = preload("res://tumbleweed.tscn")
var markerlefttop: Marker2D
var markerleftbottom: Marker2D
var markerrighttop: Marker2D
var markerrightbottom: Marker2D
var spawner_time_window: Timer

func _ready() -> void:
	print("spawner ready")
	markerlefttop = get_node("markerlefttop")
	markerleftbottom = get_node("markerleftbottom")
	markerrighttop = get_node("markerrighttop")
	markerrightbottom = get_node("markerrightbottom")
	spawner_time_window = get_node("spawner_time_window")
	GameManager.spawn_tumbleweed.connect(run_spawn_window)

func spawn_tumbleweed():
	var new_tumbleweed = tumbleweed_scene.instantiate()
	var spawn_left = randf() < 0.5
	var spawn_x
	var spawn_y
	if spawn_left:
		spawn_x = markerlefttop.position.x
		spawn_y = randf_range(markerlefttop.position.y, markerleftbottom.position.y)
		new_tumbleweed.tumbleweed_spawn_side = "left"
		new_tumbleweed.despawn_x = markerrighttop.position.x
	else:
		spawn_x = markerrighttop.position.x
		spawn_y = randf_range(markerrighttop.position.y, markerrightbottom.position.y)
		new_tumbleweed.tumbleweed_spawn_side = "right"
		new_tumbleweed.despawn_x = markerlefttop.position.x
	var spawn_position = Vector2(spawn_x, spawn_y)
	new_tumbleweed.position = spawn_position
	add_child(new_tumbleweed)

func run_spawn_window():
	print("window started")
	spawner_time_window.wait_time = GameManager.tumbleweed_spawn_window_time
	var spawn_times = []
	for spawning_tumbleweed in range(GameManager.tumbleweed_spawn_amount):
		var spawner_random_spawn_time = randf_range(0, spawner_time_window.wait_time)
		spawn_times.append(spawner_random_spawn_time)
	
	for spawn_time in spawn_times:
		await get_tree().create_timer(spawn_time).timeout
		spawn_tumbleweed()
	
	run_spawn_window()
