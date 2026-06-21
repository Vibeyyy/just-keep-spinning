extends Node

signal spawn_birdy
signal spawn_tumbleweed
var tumbleweed_spawn_amount = 22
var tumbleweed_spawn_window_time = 1
var tumbleweed_held_amount = 0
var birdy_spawn_amount = 22
var birdy_spawn_window_time = 1
var birdy_held_amount = 0
var money_held = 0

	



func start_spawn_tumbleweed():
	spawn_tumbleweed.emit()

func start_spawn_birdy():
	spawn_birdy.emit()
