extends CanvasLayer

var is_letter_on_screen = false
@onready var mail_box: Area2D = $"../mail_box"
@onready var mail_letter_overlay: CanvasLayer = $"."

@onready var body: Label = $body
@onready var tittle: Label = $tittle



func _ready() -> void:
	mail_box.open_mail_letter_overlay.connect(open)



func open(letter) -> void:
	tittle.text = letter.title
	body.text = letter.body
	self.visible = true
	is_letter_on_screen = true


func _on_close_button_pressed() -> void:
	if is_letter_on_screen == true:
		is_letter_on_screen = false
		mail_letter_overlay.visible = false


	

	
