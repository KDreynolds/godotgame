extends Node


export var speed = -500
onready var background = $Background
onready var back_button = $BackButton


func _ready():
	back_button.connect("pressed", self, "_on_back_button_pressed")

func _process(delta):
	background.scroll_offset.x += speed * delta
	
func _on_back_button_pressed():
	SelectSFX.play()
	get_tree().change_scene("res://Scenes/StartScreen.tscn")
