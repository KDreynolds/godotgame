extends ColorRect

onready var start_button = $StartButton
export var speed = -500
onready var background = $Background
onready var credits_button = $CreditsButton
onready var quit_button = $QuitButton


func _ready():
	start_button.connect("pressed", self, "_on_start_button_pressed")
	credits_button.connect("pressed", self, "_on_credits_button_pressed")
	quit_button.connect("pressed", self, "_on_quit_button_pressed")
	

func _on_start_button_pressed():
	SelectSFX.play()
	get_tree().change_scene("res://Scenes/Game.tscn")
	
func _on_credits_button_pressed():
	SelectSFX.play()
	get_tree().change_scene("res://Scenes/Credits.tscn")
	
func _on_quit_button_pressed():
	SelectSFX.play()
	get_tree().quit()
	
func _process(delta):
	background.scroll_offset.x += speed * delta


