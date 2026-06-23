extends Area2D
var is_shop_unlocked = false
@onready var timer_to_get_letter_from_trapper: Timer = $timer_to_get_letter_from_trapper
@onready var timer_to_get_letter_from_willy: Timer = $timer_to_get_letter_from_willy

@export var timer_amount_before_getting_letter_from_trapper = 10
@export var timer_amount_before_getting_letter_from_willy = 10
@onready var open_mail_sound: AudioStreamPlayer2D = $open_mail_sound
@onready var got_mail_sound: AudioStreamPlayer2D = $got_mail_sound

@export var does_have_mail = false
@export var is_mailbox_open = false
@onready var mailbox: AnimatedSprite2D = $mailbox
@onready var button_to_read_mail: Button = $button_to_read_mail
@onready var button_to_open_mailbox: Button = $button_to_open_mailbox
signal open_mail_letter_overlay(letter)
var mail_close_played = false 
var salesman_sam_letter_read = false
var trapper_tims_letter_read = false
var weirdo_willy_letter_read = false
var arrived_letters = []
var letter_pool = [
	{"id": "trapper_tim", "priority": 0, "title": "Hunting Request", "body": "Hey friend! I know you don't know me but you've caused quite the stir by getting the old mill running again! We haven't felt a fresh breeze around since I was still a child! Anyway I've heard rumors that the wind your mill is producing has brought back the local wildlife! My father used to operate the towns biggest yellow feathered fine hat shop, if you'd be willing to collect a few (or a lot) of the birds passing by your mill, I'd glady pay a very fair price for them! You can sell them to me from your inventory menu. P.S I heard weird willy was planning on sending you a request as well so keep an eye out! -Trapper Tim "},
	{"id": "weirdo_willy", "priority": 1, "title": "I need some of them weeds...", "body": "Heya ol' buddy! well I guess you don't know me yet... But does that mean we cant be buddies? I DONT THINK SO! Dang it I'm acting weird again. I PROMISED I WOULD STOP SAYING THINGS THAT ARENT SERIOUS! Ah well... Oh I forgot I was writing a letter... Listen buddy I heard that your little mill brought back the wind? If so you may have access to something I've been searching for since a kid... WEED! Well, tumbleweeds that is, I'f you come across any PLEASE let me know... I'll even pay! You can sell them to me from your inventory. THANKS AGAIN BUDDY! Oh and please tell the others I'm not weird... I dont even know why they think that :("},
	{"id": "salesman_sam", "priority": 2, "title": "Making Lots of Money Eh?", "body": "Hello... Allow me to formally introduce myself, My name is sam and I am the local salesman. At least I was before that greedy company cam and took our wind... I mean who wants to come buy anything or even visit a town with no wind? Anyway that brings me to the point of this letter, Words gotten out around town that you've not only brought back the wind to our small town but you've also been making a decent amount of coin in doing so... Well maybe we can help each other out, you know a little I scratch your back and you scratch mine? Heres the deal with this letter i'm sending a catalog for all the wares I have to offer, You get some helpful items to insure your windmill stays running and I get a bit of money... You can find the catalog in the top left of your scree... I mean the top left of the sky. I forgot this was a very serious game... -Salesman Sam"},
]

func _process(delta: float) -> void:
	if GameManager.money_held >= 100:
		if is_shop_unlocked == false:
			letter_from_salesman_sam_received()
			is_shop_unlocked = true
	if does_have_mail == true:
		if is_mailbox_open == false:
			if mail_close_played == false:
				mailbox.play("mail_close")
				button_to_open_mailbox.visible = true
				got_mail_sound.play()
				mail_close_played = true
	elif does_have_mail == false:
		mailbox.play("no_mail_closed")	
		mail_close_played = false

func get_next_letter():
	letter_pool.sort_custom(func(a, b): return a.priority < b.priority)
	return letter_pool[0] if letter_pool.size() > 0 else null

func _ready() -> void:
	timer_to_get_letter_from_trapper.start(timer_amount_before_getting_letter_from_trapper)
	if does_have_mail:
		button_to_open_mailbox.visible = true
		button_to_read_mail.visible = false
		
func _on_button_to_open_mailbox_pressed() -> void:
	if does_have_mail and not is_mailbox_open:
		print("mailbox opens")
		open_mail_sound.play()
		mailbox.play("mail_open")
		button_to_open_mailbox.visible = false
		button_to_read_mail.visible = true
		is_mailbox_open = true

func _on_button_to_read_mail_pressed() -> void:
	if arrived_letters.size() == 0:
		return
	arrived_letters.sort_custom(func(a, b): return a.priority < b.priority)
	var letter = arrived_letters[0]
	arrived_letters.erase(letter)
	letter_pool.erase(letter)
	
	is_mailbox_open = false
	button_to_read_mail.visible = false
	button_to_open_mailbox.visible = false
	does_have_mail = false
	
	open_mail_letter_overlay.emit(letter)
	
	if letter.id == "trapper_tim":
		trapper_tims_letter_read = true
		GameManager.sell_birds_letter_has_been_opened()
		timer_to_get_letter_from_willy.start(timer_amount_before_getting_letter_from_willy)
	elif letter.id == "weirdo_willy":
		weirdo_willy_letter_read = true
		GameManager.sell_tumbleweeds_letter_has_been_opened()
	elif letter.id == "salesman_sam":
		salesman_sam_letter_read = true
		GameManager.shop_is_unlocked()
	
	if arrived_letters.size() > 0:
		does_have_mail = true

func _on_timer_to_get_letter_from_trapper_timeout() -> void:
	var letter = get_next_letter()
	if letter:
		arrived_letters.append(letter)
		does_have_mail = true
		print("you got a letter!")

func _on_timer_to_get_letter_from_willy_timeout() -> void:
	var letter = get_next_letter()
	if letter:
		arrived_letters.append(letter)
		does_have_mail = true
		print("you got a letter!")

func letter_from_salesman_sam_received():
	var letter = get_next_letter()
	if letter:
		arrived_letters.append(letter)
		does_have_mail = true
		print("you got a letter!")
	
