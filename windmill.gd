extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var manual_spin_timer: Timer = $manual_spin_timer
@onready var manual_spin_timer_text: Label = $manual_spin_timer_text
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D



@onready var is_windmill_spinning = true
@onready var windmill_time_add_amount = 0.3
@onready var windmill_starting_time = 10


func _process(delta: float) -> void:
	if manual_spin_timer.time_left <= 5:
		manual_spin_timer_text.add_theme_color_override("font_color", Color.RED)
	if manual_spin_timer.time_left >= 5:
		manual_spin_timer_text.add_theme_color_override("font_color", Color.WHITE)
	if manual_spin_timer.is_stopped():
		animated_sprite_2d.play("Idle")
		print("game over")
		await get_tree().create_timer(2.21).timeout
		get_tree().quit()
	else:
		if manual_spin_timer_text.visible:
			manual_spin_timer_text.text = str(snapped(manual_spin_timer.time_left, 0.1))

		

func _ready() -> void:
	
	audio_stream_player_2d.play()
	manual_spin_timer.start(windmill_starting_time)
	input_event.connect(_on_input_event)
	animated_sprite_2d.play("Manual_Spin")
	GameManager.add_staff_time.connect(add_time_from_staff)
	
	
	
	
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			manual_spin_timer.start(manual_spin_timer.time_left + windmill_time_add_amount)
			print("click")
			

func add_time_from_staff(amount: int):
	manual_spin_timer.start(manual_spin_timer.time_left + amount)
