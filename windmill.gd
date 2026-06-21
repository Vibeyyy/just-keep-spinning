extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var manual_spin_timer: Timer = $manual_spin_timer
@onready var manual_spin_timer_text: Label = $manual_spin_timer_text


var windmill_time = 0
var is_windmill_spinning = true
@export var windmill_time_add_amount = 0.5
var windmill_starting_time = 5


func _process(delta: float) -> void:
	windmill_time = manual_spin_timer.time_left
	if manual_spin_timer.is_stopped():
		animated_sprite_2d.play("Idle")
		print("game over")
		await get_tree().create_timer(2.21).timeout
		
		get_tree().quit()
	else:
		if manual_spin_timer_text.visible:
			manual_spin_timer_text.text = str(snapped(manual_spin_timer.time_left, 0.1))

		

func _ready() -> void:
	manual_spin_timer.start(windmill_starting_time)
	input_event.connect(_on_input_event)
	animated_sprite_2d.play("Manual_Spin")
	
	
	
	
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			windmill_time = windmill_time + windmill_time_add_amount
			manual_spin_timer.start(windmill_time)
			print("click")
			
