extends CanvasLayer

var is_letter_on_screen = false
@onready var mail_box: Area2D = $"../mail_box"
@onready var mail_letter_overlay: CanvasLayer = $"."

@onready var body: Label = $body
@onready var tittle: Label = $tittle

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D





func _ready() -> void:
	mail_box.open_mail_letter_overlay.connect(open)



func open(letter) -> void:
	
	GameManager.is_letter_shown_at_all = true
	tittle.text = letter.title
	body.text = letter.body
	self.visible = true
	is_letter_on_screen = true


func _on_close_button_pressed() -> void:
	GameManager.is_letter_shown_at_all = false
	if is_letter_on_screen == true:
		audio_stream_player_2d.play()
		is_letter_on_screen = false
		mail_letter_overlay.visible = false


	

	
