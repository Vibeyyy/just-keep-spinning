extends Node



signal shop_unlocked
signal open_shop
signal spawn_birdy
signal spawn_tumbleweed
var tumbleweed_spawn_amount = 22
var tumbleweed_spawn_window_time = 5
var tumbleweed_held_amount = 0
var birdy_spawn_amount = 22
var birdy_spawn_window_time = 5
var birdy_held_amount = 0
var money_held = 0
var wind_staff_held_amount = 0

	



func start_spawn_tumbleweed():
	spawn_tumbleweed.emit()

func sell_birds_letter_has_been_opened():
	spawn_birdy.emit()
	
func sell_tumbleweeds_letter_has_been_opened():
	spawn_tumbleweed.emit()
	
	
	
func shop_is_unlocked():
	shop_unlocked.emit()


func emit_open_shop():
	open_shop.emit()
