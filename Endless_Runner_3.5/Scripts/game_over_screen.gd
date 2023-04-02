extends ColorRect

onready var final_score_label = $FinalScoreLabel
onready var retry_button = $RetryButton
onready var main_menu_button = $MainMenuButton
onready var quit_button_game_over_screen = $QuitButtonGOScreen
var custom_font

func _ready():
	hide()
	retry_button.connect("pressed", self, "_on_retry_button_pressed")
	main_menu_button.connect("pressed", self, "_on_main_menu_button_pressed")
	quit_button_game_over_screen.connect("pressed", self, "_on_quit_button_game_over_screen_pressed")

func show_final_score(score):
	final_score_label.text = "Final Score: %d" % score
	show()

func _on_retry_button_pressed():
	hide()
	SelectSFX.play()
	get_tree().paused = false
	get_node("/root/Game/Player").reset_speed()
	get_node("/root/Game/UI/ScoreContainer/ScoreLabel").visible = true
	
func _on_main_menu_button_pressed():
	SelectSFX.play()
	get_tree().change_scene("res://Scenes/StartScreen.tscn")
	get_tree().paused = false
	
func _on_quit_button_game_over_screen_pressed():
	SelectSFX.play()
	get_tree().quit()
