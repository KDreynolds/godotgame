extends ColorRect

onready var start_button = $StartButton
export var speed = -500
onready var background = $Background

func _ready():
	start_button.connect("pressed", self, "_on_start_button_pressed")

func _on_start_button_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")
	
func _process(delta):
	background.scroll_offset.x += speed * delta
