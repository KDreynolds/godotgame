extends Node2D

export var block_scene = preload("res://Scenes/Block.tscn")
export var empty_block_scene = preload("res://Scenes/EmptyBlock.tscn")
export var block_size = Vector2(64, 64)
export var fill_probability = 0.6
export var generation_margin = 10000000
export var num_blocks_to_generate = 50
export (NodePath) var player_path

var player
var floor_y_offset
var ceiling_y_offset

onready var screen_size = get_viewport_rect().size
var last_generated_x = -1

func _process(_delta):
	check_and_generate_blocks(player.global_position)

func _ready():
	player = get_node(player_path)
	floor_y_offset = screen_size.y * 0.88
	ceiling_y_offset = screen_size.y * 0.08
	generate_blocks()

var generated_blocks = {}

func generate_blocks(start_x = 0):
	var gap_probability = 1 - fill_probability
	var initial_blocks_threshold = int(screen_size.x / block_size.x)

	for x in range(num_blocks_to_generate):
		var global_x = x + int(start_x / block_size.x)

		# Create solid blocks in the initial viewport
		if global_x < initial_blocks_threshold:
			create_block(global_x, 0, "floor")
			create_block(global_x, -1, "ceiling")
			continue

		if randf() > gap_probability:
			if not has_block_at_position(global_x, 0):
				create_block(global_x, 0, "floor")
		elif not has_block_at_position(global_x, 0):
			create_empty_block(global_x, 0, "floor")

		if randf() > gap_probability:
			if not has_block_at_position(global_x, -1):
				create_block(global_x, -1, "ceiling")
		elif not has_block_at_position(global_x, -1):
			create_empty_block(global_x, -1, "ceiling")


func has_block_at_position(x, y):
	var key = str(x) + "," + str(y)
	return key in generated_blocks

func register_block_position(x, y):
	var key = str(x) + "," + str(y)
	generated_blocks[key] = true

func create_block(x, y, plane_type):
	var block = block_scene.instance()
	set_block_position(block, x, y, plane_type)
	register_block_position(x, y)
	get_parent().call_deferred("add_child", block)

func create_empty_block(x, y, plane_type):
	var empty_block = empty_block_scene.instance()
	set_block_position(empty_block, x, y, plane_type)
	register_block_position(x, y)
	empty_block.add_to_group("EmptyBlock")
	get_parent().call_deferred("add_child", empty_block)
	empty_block.scale.x = 2

func set_block_position(block, x, y, plane_type):
	var y_offset = 0
	if plane_type == "floor":
		y_offset = floor_y_offset
	elif plane_type == "ceiling":
		y_offset = ceiling_y_offset

	block.position = Vector2(x * block_size.x, y * block_size.y + y_offset) + self.global_position

func check_and_generate_blocks(player_position):
	var player_screen_x = player_position.x - self.global_position.x
	if player_screen_x > screen_size.x - generation_margin:
		var next_generation_x = int(player_position.x / block_size.x) * block_size.x + screen_size.x
		if next_generation_x > last_generated_x:
			last_generated_x = next_generation_x
			generate_blocks(next_generation_x)

