extends KinematicBody2D

export var speed = 500
export var jump_force = 500
var velocity = Vector2.ZERO
var gravity = 20
var on_ceiling = false
var score = 0
var score_inc = 100
var score_label
var is_game_over = false
var is_touching_ceiling = false
export var speed_increase = 20
onready var original_speed = speed
onready var parallax_background = get_node("/root/Game/Background")





func _physics_process(_delta):
	var player_position = get_node("/root/Game/Player").global_position
	get_node("/root/Game/BlockGenerator").check_and_generate_blocks(player_position)

	velocity.x = speed
	velocity.y += gravity

	if on_ceiling and not is_on_ceiling():
		is_touching_ceiling = true
	elif not on_ceiling:
		is_touching_ceiling = false

	if on_ceiling:
		velocity = move_and_slide(velocity, Vector2.DOWN)  # Change the floor normal
	else:
		velocity = move_and_slide(velocity, Vector2.UP)

	if Input.is_action_just_pressed("ui_accept"):
		jump_to_ceiling()

	if is_game_over:
		return
	
	check_player_out_of_bounds()
	parallax_background.scroll_offset = global_position
	
func check_player_out_of_bounds():
	var screen_size = get_viewport_rect().size
	var sprite_size = Vector2(32, 32)
	
	if global_position.y + sprite_size.y < -sprite_size.y - 64 or global_position.y - sprite_size.y * 2 > screen_size.y:
		trigger_game_over()

				
func _process(delta):
	update_score(delta)

func jump_to_ceiling():
	if not on_ceiling and is_on_floor():
		velocity.y = -jump_force
		gravity = -20  # Reverse gravity
		on_ceiling = true
	elif on_ceiling and is_touching_ceiling:
		velocity.y = jump_force
		gravity = 20  # Restore gravity
		on_ceiling = false

		
func update_score_label():
	score_label.text = "   Score: " + str(int(round(score)))
	
func update_score(delta):
	score += score_inc * delta
	update_score_label()
	
func _ready():
	score_label = get_node("/root/Game/UI/ScoreContainer/ScoreLabel")
	var empty_blocks = get_tree().get_nodes_in_group("EmptyBlock")
	for empty_block in empty_blocks:
		empty_block.get_node("Area2D").connect("body_entered", self, "_on_empty_block_collision")
	$SpeedTimer.connect("timeout", self, "_on_SpeedTimer_timeout")

	
	
func trigger_game_over():
	if not is_game_over:
		is_game_over = true
		get_node("/root/Game/UI/GameOverScreen").show_final_score(score)
		score_label.visible = false
		get_tree().paused = true
		
func _on_empty_block_collision(body):
	if body == self:
		trigger_game_over()
		
func _on_SpeedTimer_timeout():
	speed += speed_increase

func reset_speed():
	speed = original_speed





