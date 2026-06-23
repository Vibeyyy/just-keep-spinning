extends CanvasLayer

@onready var shop_icon: Button = $shop_icon
@onready var inventory_button: Button = $inventory_button


















# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.shop_unlocked.connect(shop_unlocked)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
		
	
		
		
		
