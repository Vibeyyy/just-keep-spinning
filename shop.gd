extends CanvasLayer
@onready var buy_sound: AudioStreamPlayer2D = $buy_sound
@onready var money_amount: Label = $money_amount
@onready var background: Sprite2D = $background
@onready var wind_staff_button: Button = $wind_staff_button
@export var wind_staff_cost = 200



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
		


func _on_close_button_button_down() -> void:
	self.visible = false	
	
	
	
	
