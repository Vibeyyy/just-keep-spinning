extends Area2D

@onready var timer_to_get_letter_from_trapper: Timer = $timer_to_get_letter_from_trapper
@onready var timer_to_get_letter_from_willy: Timer = $timer_to_get_letter_from_willy
@onready var open_mail_sound: AudioStreamPlayer2D = $open_mail_sound
@onready var got_mail_sound: AudioStreamPlayer2D = $got_mail_sound
@onready var mailbox: AnimatedSprite2D = $mailbox
@onready var button_to_read_mail: Button = $button_to_read_mail
@onready var button_to_open_mailbox: Button = $button_to_open_mailbox

@export var timer_amount_before_getting_letter_from_trapper = 10
@export var timer_amount_before_getting_letter_from_willy = 10

signal open_mail_letter_overlay(letter)

var is_mailbox_open = false
var is_shop_unlocked = false
var letters_read = {}
var arrived_letters = []

var all_letters = {
	"trapper_tim": {"id": "trapper_tim", "priority": 0, "title": "Hunting Request", "body": "Hey friend! I know you don't know me but you've caused quite the stir by getting the old mill running again! We haven't felt a fresh breeze around since I was still a child! Anyway I've heard rumors that the wind your mill is producing has brought back the local wildlife! My father used to operate the towns biggest yellow feathered fine hat shop, if you'd be willing to collect a few (or a lot) of the birds passing by your mill, I'd glady pay a very fair price for them! You can sell them to me from your inventory menu. P.S I heard weird willy was planning on sending you a request as well so keep an eye out! -Trapper Tim"},
	"weirdo_willy": {"id": "weirdo_willy", "priority": 1, "title": "I need some of them weeds...", "body": "Heya ol' buddy! well I guess you don't know me yet... But does that mean we cant be buddies? I DONT THINK SO! Dang it I'm acting weird again. I PROMISED I WOULD STOP SAYING THINGS THAT ARENT SERIOUS! Ah well... Oh I forgot I was writing a letter... Listen buddy I heard that your little mill brought back the wind? If so you may have access to something I've been searching for since a kid... WEED! Well, tumbleweeds that is, I'f you come across any PLEASE let me know... I'll even pay! You can sell them to me from your inventory. THANKS AGAIN BUDDY! Oh and please tell the others I'm not weird... I dont even know why they think that :("},
	"salesman_sam": {"id": "salesman_sam", "priority": 2, "title": "Making Lots of Money Eh?", "body": "Hello... Allow me to formally introduce myself, My name is sam and I am the local salesman. At least I was before that greedy company cam and took our wind... I mean who wants to come buy anything or even visit a town with no wind? Anyway that brings me to the point of this letter, Words gotten out around town that you've not only brought back the wind to our small town but you've also been making a decent amount of coin in doing so... Well maybe we can help each other out, you know a little I scratch your back and you scratch mine? Heres the deal with this letter i'm sending a catalog for all the wares I have to offer, You get some helpful items to insure your windmill stays running and I get a bit of money... You can find the catalog in the top left of your scree... I mean the top left of the sky. I forgot this was a very serious game... -Salesman Sam"},
}

func _ready() -> void:
	timer_to_get_letter_from_trapper.start(timer_amount_before_getting_letter_from_trapper)
	button_to_read_mail.visible = false
	button_to_open_mailbox.visible = false
	mailbox.play("no_mail_closed")

func _process(delta: float) -> void:
	if not is_shop_unlocked:
		if GameManager.money_held >= 100:
			if is_letter_read("trapper_tim") and is_letter_read("weirdo_willy"):
				deliver_letter("salesman_sam")

func on_letter_read(id: String) -> void:
	if id == "trapper_tim":
		GameManager.sell_birds_letter_has_been_opened()
		timer_to_get_letter_from_willy.start(timer_amount_before_getting_letter_from_willy)
	elif id == "weirdo_willy":
		GameManager.sell_tumbleweeds_letter_has_been_opened()
	elif id == "salesman_sam":
		GameManager.shop_is_unlocked()
		is_shop_unlocked = true

func deliver_letter(id: String) -> void:
	if letters_read.has(id):
		return
	if arrived_letters.any(func(l): return l.id == id):
		return
	var letter = all_letters.get(id)
	if letter:
		arrived_letters.append(letter)
		arrived_letters.sort_custom(func(a, b): return a.priority < b.priority)
		set_has_mail(true)

func set_has_mail(value: bool) -> void:
	if value:
		mailbox.play("mail_close")
		button_to_open_mailbox.visible = true
		got_mail_sound.play()
	else:
		mailbox.play("no_mail_closed")
		button_to_open_mailbox.visible = false
		button_to_read_mail.visible = false
		is_mailbox_open = false

func is_letter_read(id: String) -> bool:
	return letters_read.has(id)

func _on_button_to_open_mailbox_pressed() -> void:
	if arrived_letters.size() == 0 or is_mailbox_open:
		return
	open_mail_sound.play()
	mailbox.play("mail_open")
	button_to_open_mailbox.visible = false
	button_to_read_mail.visible = true
	is_mailbox_open = true

func _on_button_to_read_mail_pressed() -> void:
	if arrived_letters.size() == 0:
		return
	var letter = arrived_letters.pop_front()
	letters_read[letter.id] = true
	on_letter_read(letter.id)
	open_mail_letter_overlay.emit(letter)
	if arrived_letters.size() > 0:
		set_has_mail(true)
	else:
		set_has_mail(false)

func _on_timer_to_get_letter_from_trapper_timeout() -> void:
	deliver_letter("trapper_tim")

func _on_timer_to_get_letter_from_willy_timeout() -> void:
	deliver_letter("weirdo_willy")
