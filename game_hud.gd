extends CanvasLayer

@onready var shop_icon: Button = $shop_icon


















# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.shop_unlocked.connect(shop_unlocked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_shop_icon_mouse_entered() -> void:
	self.scale = self.scale * 1.05



func _on_shop_icon_mouse_exited() -> void:
	self.scale = Vector2(1, 1)
	
	


	


func _on_shop_icon_button_down() -> void:
	GameManager.emit_open_shop()
	
func shop_unlocked():
	shop_icon.visible = true
