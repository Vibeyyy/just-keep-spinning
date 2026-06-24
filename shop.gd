extends CanvasLayer
@onready var buy_sound: AudioStreamPlayer2D = $buy_sound
@onready var money_amount: Label = $money_amount
@onready var background: Sprite2D = $background
@onready var wind_staff_button: Button = $wind_staff_button
@export var wind_staff_cost = 200
@onready var dog_unlock: Node2D = $"../Dog_Unlock"
@onready var dog_bark: AudioStreamPlayer2D = $dog_bark



var dog_cost = 500
var energy_drink_cost = 200
var burger_cost = 200


func _ready() -> void:
	GameManager.open_shop.connect(open_shop)


func open_shop():
	print("shop open")
	self.visible = true



func _process(delta: float) -> void:
	money_amount.text = ("$" + str(GameManager.money_held))
	if self.visible == true:
		GameManager.is_shop_open = true
	elif self.visible == false:
		GameManager.is_shop_open = false





func _on_wind_staff_button_pressed() -> void:
	if GameManager.money_held >= wind_staff_cost:
		GameManager.money_held = GameManager.money_held - wind_staff_cost
		GameManager.wind_staff_held_amount = GameManager.wind_staff_held_amount + 1
		buy_sound.play()
	else:
		pass
		


func _on_buy_energy_drink_button_down() -> void:
	if GameManager.money_held >= energy_drink_cost:
		GameManager.money_held = GameManager.money_held - energy_drink_cost
		GameManager.energy_drink_held_amount = GameManager.energy_drink_held_amount + 1
		buy_sound.play()
	
	

func _on_buy_burger_button_down() -> void:
	if GameManager.money_held >= burger_cost:
		GameManager.money_held = GameManager.money_held - burger_cost
		GameManager.burger_held_amount = GameManager.burger_held_amount + 1
		buy_sound.play()


func _on_buy_dog_button_down() -> void:
	if GameManager.good_boy_amount <= 0:
		if GameManager.money_held >= dog_cost:
			GameManager.money_held = GameManager.money_held - dog_cost
			GameManager.good_boy_amount = 1
			dog_unlock.visible = true
			dog_bark.play()
		


























func _on_close_button_button_down() -> void:
	self.visible = false	
	
	
	
	
