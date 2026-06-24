extends CanvasLayer

@onready var shop_icon: Button = $shop_icon
@onready var inventory_button: Button = $inventory_button
@onready var energy_drink_time_left: Label = $energy_drink_time_left
@onready var energy_drink_icon: Sprite2D = $energy_drink_icon
@onready var burger_time_left: Label = $burger_time_left
@onready var burger_icon: Sprite2D = $burger_icon



















# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.shop_unlocked.connect(shop_unlocked)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameManager.is_burger_active == true:
		burger_icon.visible = true
		burger_time_left.visible = true
		burger_time_left.text = str(int(GameManager.burgery_time_left))
	elif GameManager.is_burger_active == false:
		burger_icon.visible = false	
		burger_time_left.visible = false
	
	if GameManager.is_energy_drink_active == true:
		energy_drink_icon.visible = true
		energy_drink_time_left.visible = true
		energy_drink_time_left.text = str(int(GameManager.energy_drink_time_left))
	elif GameManager.is_energy_drink_active == false:
		energy_drink_icon.visible = false
		energy_drink_time_left.visible = false
		pass
	





#hover_size_grow_anims
func _on_shop_icon_mouse_entered() -> void:
	shop_icon.scale = Vector2(0.55, 0.55)



func _on_shop_icon_mouse_exited() -> void:
	shop_icon.scale = Vector2(0.5, 0.5)
	


func _on_inventory_button_mouse_entered() -> void:
	inventory_button.scale = Vector2(0.5, 0.5)
	
	
	
	
func _on_inventory_button_mouse_exited() -> void:
	inventory_button.scale = Vector2(0.445, 0.445)

	


func _on_shop_icon_button_down() -> void:
	if GameManager.is_inventory_open == false:
		if GameManager.is_shop_open == false:
			GameManager.is_shop_open = true
			GameManager.emit_open_shop()
	
func shop_unlocked():
	shop_icon.visible = true
	
	







	



	


func _on_inventory_button_button_down() -> void:
	if GameManager.is_inventory_open == false:
		if GameManager.is_shop_open == false:
			GameManager.emit_open_inventory()
			GameManager.is_inventory_open = true
			print("inv opens")
		
	
		
		
		
