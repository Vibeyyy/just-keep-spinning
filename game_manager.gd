extends Node

signal spawn_tumbleweed
var tumbleweed_spawn_amount = 2
var tumbleweed_spawn_window_time = 3
var tumbleweed_held_amount = 0


	



func start_spawn_tumbleweed():
	spawn_tumbleweed.emit()
