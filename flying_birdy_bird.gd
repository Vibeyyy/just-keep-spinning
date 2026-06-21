extends Area2D
@onready var bird_death_sound: AudioStreamPlayer2D = $bird_death_sound

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@export var flight_speed = 200
var birdy_spawn_side = ("right")
var move_direction = 1
var despawn_x = 0
var fall_speed = 0
var rotation_speed = 0
var stop_y_position: float = 55


func _ready() -> void:
	animated_sprite_2d.play("fly")
	if birdy_spawn_side == ("right"):
		animated_sprite_2d.flip_h = true
		move_direction = -1
	else:
		move_direction = 1
		
		
		
func _process(delta: float) -> void:
	position.x += move_direction * flight_speed * delta
	position.y += fall_speed * delta
	if position.y == stop_y_position:
		await get_tree().create_timer(randf_range(1,4)).timeout
		queue_free()
	
	if position.y >= stop_y_position:
		position.y = stop_y_position 
		fall_speed = 0
	if move_direction == -1 and position.x <= despawn_x:
		queue_free()
	elif move_direction == 1 and position.x >= despawn_x:
		queue_free()
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int,) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			collision_shape_2d.queue_free()
			GameManager.birdy_held_amount = GameManager.birdy_held_amount + 1
			print("you have ", GameManager.birdy_held_amount, " birdies!")
			animated_sprite_2d.play("death")
			flight_speed = 0
			fall_speed = randi_range(120, 291)
			animated_sprite_2d.flip_v = true	
			bird_death_sound.play()
			
			
