extends Node

signal add_staff_time(amount: int)
signal open_inventory
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
var is_inventory_open = false
var is_shop_open = false
var is_letter_shown_at_all = false
var windmill_time = 0

func  _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS



func _process(delta: float) -> void:
	if is_inventory_open == false:
		get_tree().paused = false
	if is_shop_open == false:
		get_tree().paused = false
	if is_letter_shown_at_all == false:
		get_tree().paused = false
	if is_inventory_open == true:
		get_tree().paused = true
	if is_shop_open == true:
		get_tree().paused = true
	if is_letter_shown_at_all == true:
		get_tree().paused = true



func start_spawn_tumbleweed():
	spawn_tumbleweed.emit()

func sell_birds_letter_has_been_opened():
	spawn_birdy.emit()
	
func sell_tumbleweeds_letter_has_been_opened():
	spawn_tumbleweed.emit()
	
	
	
func shop_is_unlocked():
	shop_unlocked.emit()


func emit_open_shop():
	get_tree().paused = true
	open_shop.emit()
	
	
func emit_open_inventory():
	get_tree().paused = true
	open_inventory.emit()
	
	

	
