extends CanvasLayer

var tumbleweed_sell_price = 3
var bird_sell_price = 10



@onready var use_1_energydrink: Button = $use_1_energydrink


@onready var goodboy_amount: Label = $goodboy_amount
@onready var burger_amount: Label = $burger_amount
@onready var energy_drink_amount: Label = $energy_drink_amount


@onready var drink_sound: AudioStreamPlayer2D = $drink_sound
@onready var burger_eat_sound: AudioStreamPlayer2D = $burger_eat_sound



@onready var use_1_burger: Button = $use_1_burger

@onready var inventory_panel: CanvasLayer = $"."
@onready var tumbleweed_amount: Label = $tumbleweed_amount
@onready var birds_amount: Label = $birds_amount
@onready var birds: AnimatedSprite2D = $birds
@onready var birds_animation_easteregg_button: Button = $birds_animation_easteregg_button
@onready var tumbleweed_animation_easteregg_button: Button = $tumbleweed_animation_easteregg_button
@onready var windstaff_amount: Label = $windstaff_amount
@onready var money_icon_click_easteregg: Button = $money_icon_click_easteregg
@onready var tumbleweeds: AnimatedSprite2D = $tumbleweeds
@onready var money_amount_text: Label = $money_amount_text
@onready var sell_1_bird: Button = $Sell_1_bird
@onready var sell_5_bird: Button = $sell_5_bird
@onready var sell_10_bird: Button = $sell_10_bird

var windstaff_used_add_amount_seconds = 30
var inventory_opened = false

func _ready() -> void:
	GameManager.open_inventory.connect(open_inventory)
	connect_signals()

func _process(delta: float) -> void:
	money_amount_text.text = ("$" + str(GameManager.money_held))
	process_mode = Node.PROCESS_MODE_ALWAYS
	if GameManager.is_energy_drink_active:
		if not get_tree().paused:
			GameManager.energy_drink_time_left -= delta
			if GameManager.energy_drink_time_left <= 0:
				GameManager.energy_drink_time_left = 0.0
				GameManager.is_energy_drink_active = false
	if GameManager.is_burger_active:
		if not get_tree().paused:
			GameManager.burgery_time_left -= delta
			if GameManager.burgery_time_left <= 0:
				GameManager.burgery_time_left = 0.0
				GameManager.is_burger_active = false
				GameManager.windmill_time_add_amount = 0.2  # reset back
				
	if inventory_panel.visible == true:
		update_held_amounts()
	if Input.is_action_just_pressed("inventory"):
		if GameManager.is_inventory_open == false:
			if GameManager.is_shop_open == false:
				GameManager.is_inventory_open = true
				open_inventory()
				update_held_amounts()
		else:
			GameManager.is_inventory_open = false
			inventory_panel.visible = false
			inventory_opened = false

func open_inventory():
	inventory_panel.visible = true
	print("inventory opened")

func update_held_amounts():
	tumbleweed_amount.text = str(GameManager.tumbleweed_held_amount)
	birds_amount.text = str(GameManager.birdy_held_amount)
	windstaff_amount.text = str(GameManager.wind_staff_held_amount)
	energy_drink_amount.text = str(GameManager.energy_drink_held_amount)
	burger_amount.text = str(GameManager.burger_held_amount)
	goodboy_amount.text = str(GameManager.good_boy_amount)
#selling handlers
func _on_sell_1_bird_button_down() -> void:
	if GameManager.birdy_held_amount >= 1:
		GameManager.birdy_held_amount = GameManager.birdy_held_amount - 1
		GameManager.money_held = GameManager.money_held + bird_sell_price * 1

func _on_sell_5_bird_button_down() -> void:
	if GameManager.birdy_held_amount >= 5:
		GameManager.birdy_held_amount = GameManager.birdy_held_amount - 5
		GameManager.money_held = GameManager.money_held + bird_sell_price * 5

func _on_sell_10_bird_button_down() -> void:
	if GameManager.birdy_held_amount >= 10:
		GameManager.birdy_held_amount = GameManager.birdy_held_amount - 10
		GameManager.money_held = GameManager.money_held + bird_sell_price * 10

func _on_sell_1_tumbleweed_button_down() -> void:
	if GameManager.tumbleweed_held_amount >= 1:
		GameManager.tumbleweed_held_amount = GameManager.tumbleweed_held_amount - 1
		GameManager.money_held = GameManager.money_held + tumbleweed_sell_price * 1

func _on_sell_5_tumbleweed_button_down() -> void:
	if GameManager.tumbleweed_held_amount >= 5:
		GameManager.tumbleweed_held_amount = GameManager.tumbleweed_held_amount - 5
		GameManager.money_held = GameManager.money_held + tumbleweed_sell_price * 5

func _on_sell_10_tumbleweed_button_down() -> void:
	if GameManager.tumbleweed_held_amount >= 10:
		GameManager.tumbleweed_held_amount = GameManager.tumbleweed_held_amount - 10
		GameManager.money_held = GameManager.money_held + tumbleweed_sell_price * 10

#use handlers
func _on_use_windstaff_1_button_down() -> void:
	if GameManager.wind_staff_held_amount >= 1:
		GameManager.wind_staff_held_amount -= 1
		GameManager.add_staff_time.emit(windstaff_used_add_amount_seconds * 1)

func _on_use_windstaff_5_button_down() -> void:
	if GameManager.wind_staff_held_amount >= 5:
		GameManager.wind_staff_held_amount -= 5
		GameManager.add_staff_time.emit(windstaff_used_add_amount_seconds * 5)

func _on_use_windstaff_10_button_down() -> void:
	if GameManager.wind_staff_held_amount >= 10:
		GameManager.wind_staff_held_amount -= 10
		GameManager.add_staff_time.emit(windstaff_used_add_amount_seconds * 10)

##############################################################################

func _on_use_1_energydrink_button_down() -> void:
	print("button pressed")
	print("amount: ", GameManager.energy_drink_held_amount)
	print("is active: ", GameManager.is_energy_drink_active)
	if GameManager.energy_drink_held_amount >= 1:
		if GameManager.is_energy_drink_active == false:
			GameManager.energy_drink_held_amount -= 1
			GameManager.is_energy_drink_active = true
			GameManager.energy_drink_time_left = 10
			drink_sound.play()
			print("drink used!")


func _on_use_1_burger_button_down() -> void:
	if GameManager.burger_held_amount >= 1:
		if GameManager.is_burger_active == false:
			GameManager.burger_held_amount -= 1
			GameManager.is_burger_active = true
			GameManager.burgery_time_left = 10
			GameManager.windmill_time_add_amount = .8  # set to boosted value
			burger_eat_sound.play()
			print("burger ate!")
	






###################################################################################
func connect_signals():
	GameManager.spawn_birdy.connect(birds_unlocked)

func birds_unlocked():
	birds_amount.visible = true
	birds.visible = true
	birds_animation_easteregg_button.visible = true
		
