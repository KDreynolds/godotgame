extends ColorRect

onready var final_score_label = $FinalScoreLabel
onready var retry_button = $RetryButton
var custom_font

func _ready():
	custom_font = DynamicFont.new()
	custom_font.font_data = load("res://Samson.ttf")
	custom_font.size = 24  # Set the desired font size

	final_score_label.add_font_override("font", custom_font)
	retry_button.add_font_override("font", custom_font)
	hide()
	retry_button.connect("pressed", self, "_on_retry_button_pressed")

func show_final_score(score):
	final_score_label.text = "Final Score: %d" % score
	show()

func _on_retry_button_pressed():
	hide()
	get_tree().paused = false
	get_node("/root/Game/Player").reset_speed()
	get_node("/root/Game/UI/ScoreContainer/ScoreLabel").visible = true
