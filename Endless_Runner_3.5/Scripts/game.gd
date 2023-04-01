extends Node

onready var player = $Player
onready var block_generator = $BlockGenerator
onready var game_over_screen = $UI/GameOverScreen

func _ready():
	# Connect the pressed signal from the retry button to the _on_game_restart function
	game_over_screen.retry_button.connect("pressed", self, "_on_game_restart")

func _on_game_restart():
	# Reset the player
	player.position = Vector2(50, 200) # Adjust this value based on the player's initial position
	player.velocity = Vector2(0, 0)
	player.gravity = 20
	player.on_ceiling = false
	player.score = 0
	player.is_game_over = false
	
	# Reset the BlockGenerator
	block_generator.last_generated_x = -1
	block_generator.generated_blocks.clear()
	block_generator.generate_blocks()
