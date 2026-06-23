extends CanvasLayer

var tumbleweed_sell_price = 3
var bird_sell_price = 10

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

func connect_signals():
	GameManager.spawn_birdy.connect(birds_unlocked)

func birds_unlocked():
	birds_amount.visible = true
	birds.visible = true
	birds_animation_easteregg_button.visible = true
		
