extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var manual_spin_timer: Timer = $manual_spin_timer
@onready var manual_spin_timer_text: Label = $manual_spin_timer_text

var is_manual_spin_spinning = false
var manual_spin_time_left

func _process(delta: float) -> void:
	if manual_spin_timer_text.visible:
		manual_spin_timer_text.text = str(snapped(manual_spin_timer.time_left, 0.1))

func _ready() -> void:
	input_event.connect(_on_input_event)
	
	
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if is_manual_spin_spinning == false:
				is_manual_spin_spinning = true
				animated_sprite_2d.play("Manual_Spin")
				manual_spin_timer.start()
				manual_spin_timer_text.show()

				await manual_spin_timer.timeout
				is_manual_spin_spinning = false
				manual_spin_timer_text.hide()
				animated_sprite_2d.play("Idle")
				(manual_spin_timer.time_left == 1)
				print("Clicked inside the shape!")
				
			else:
				manual_spin_timer.start(manual_spin_timer.time_left + 0.5)
