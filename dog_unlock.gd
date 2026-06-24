extends Node2D

var is_being_pet = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var button: Button = $Button


func _ready() -> void:
	GameManager.dog_unlocked.connect(spawn_dog)


func _on_button_pressed() -> void:
	if  is_being_pet == false:
		is_being_pet = true
		animated_sprite_2d.play("pet")
		await animated_sprite_2d.animation_finished
		animated_sprite_2d.play("idle")
		is_being_pet = false




	
	
func spawn_dog():
	self.visible = true
