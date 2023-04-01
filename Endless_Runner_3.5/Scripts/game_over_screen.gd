extends ColorRect

onready var final_score_label = $FinalScoreLabel
onready var retry_button = $RetryButton

func _ready():
	hide()
	retry_button.connect("pressed", self, "_on_retry_button_pressed")

func show_final_score(score):
	final_score_label.text = "Final Score: %d" % score
	show()

func _on_retry_button_pressed():
	hide()
	get_tree().paused = false
