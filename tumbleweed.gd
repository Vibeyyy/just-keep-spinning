extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@export var roll_speed = 200
var tumbleweed_spawn_side = ("right")
var move_direction = 1
var despawn_x = 0

func _ready() -> void:
	animated_sprite_2d.play("roll")
	if tumbleweed_spawn_side == ("right"):
		animated_sprite_2d.flip_h = true
		move_direction = -1
	else:
		move_direction = 1

func _process(delta: float) -> void:
	position.x += move_direction * roll_speed * delta
	if move_direction == -1 and position.x <= despawn_x:
		queue_free()
	elif move_direction == 1 and position.x >= despawn_x:
		queue_free()




	


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			GameManager.tumbleweed_held_amount = GameManager.tumbleweed_held_amount + 1
			print("you have ", GameManager.tumbleweed_held_amount, " tumbleweeds!")
			queue_free()
