extends CanvasLayer

@export var tumbleweed_sell_price = 1
@export var bird_sell_price = 5

@onready var inventory_panel: CanvasLayer = $"."
@onready var tumbleweed_amount: Label = $tumbleweed_amount
@onready var birds_amount: Label = $birds_amount
@onready var birds: AnimatedSprite2D = $birds
@onready var birds_animation_easteregg_button: Button = $birds_animation_easteregg_button
@onready var tumbleweed_animation_easteregg_button: Button = $tumbleweed_animation_easteregg_button
@onready var sell_tumbleweeds_button: LineEdit = $sell_tumbleweeds_button

@onready var money_amount: Label = $money_amount
@onready var money_icon_click_easteregg: Button = $money_icon_click_easteregg

@onready var tumbleweeds: AnimatedSprite2D = $tumbleweeds
@onready var money_sprite: AnimatedSprite2D = $money_sprite






var inventory_opened = false

func _process(delta: float) -> void:
	if inventory_panel.visible == true:
		update_held_amounts()
	if Input.is_action_just_pressed("inventory"):
		if inventory_opened == false:
			inventory_opened = true
			open_inventory()
			update_held_amounts()
		else:
			inventory_panel.visible = false
			inventory_opened = false
		



func open_inventory():
		inventory_panel.visible = true
		print("inventory opened")
	
	

func update_held_amounts():
	tumbleweed_amount.text = str(GameManager.tumbleweed_held_amount)
	birds_amount.text = str(GameManager.birdy_held_amount)
	
	money_amount.text = str(GameManager.money_held)
	
	
	
	
	
	
	
	#selling handlers
func _on_sell_tumbleweeds_button_text_submitted(new_text: String) -> void:
	var tumbleweed_amount_to_sell = int(new_text)
	if tumbleweed_amount_to_sell > 0:
		if GameManager.tumbleweed_held_amount >= tumbleweed_amount_to_sell:
			GameManager.tumbleweed_held_amount = GameManager.tumbleweed_held_amount - tumbleweed_amount_to_sell
			GameManager.money_held = GameManager.money_held + tumbleweed_sell_price * tumbleweed_amount_to_sell
		
			print(" you sold ", tumbleweed_amount_to_sell , " tumbleweeds " , " new amount is "  , GameManager.tumbleweed_held_amount , " new money amount is: ", GameManager.money_held )                       
	
		
func _on_sell_birds_button_text_submitted(new_text: String) -> void:
	var bird_amount_to_sell = int(new_text)
	if bird_amount_to_sell > 0:
		if GameManager.birdy_held_amount >= bird_amount_to_sell:
			GameManager.birdy_held_amount = GameManager.birdy_held_amount - bird_amount_to_sell
			GameManager.money_held =GameManager.money_held + bird_sell_price * bird_amount_to_sell
		
		print(" you sold ", bird_amount_to_sell , " birds " , " new amount is " , GameManager.birdy_held_amount , " new money amount is: ", GameManager.money_held)       
		
	
	
	
	
	
	
	
	#easter egg animations
func _on_birds_animation_easteregg_button_pressed() -> void:
	
	birds.play()
	birds_animation_easteregg_button.disabled = true
	await birds.animation_finished
	birds_animation_easteregg_button.disabled = false
	
	
func _on_tumbleweed_animation_easteregg_pressed() -> void:
	tumbleweeds.play("easter_egg")
	tumbleweed_animation_easteregg_button.disabled = true	
	await tumbleweeds.animation_finished
	tumbleweed_animation_easteregg_button.disabled = false
	


func _on_money_icon_click_easteregg_pressed() -> void:
	money_sprite.play("clicked")
	money_icon_click_easteregg.disabled = true	
	await money_sprite.animation_finished
	money_icon_click_easteregg.disabled = false	
