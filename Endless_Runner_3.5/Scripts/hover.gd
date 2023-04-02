extends ColorRect

export var hover_size = Vector2(600, 60)
var original_size = Vector2(350, 60)

func _ready():
	original_size = rect_size

func _on_mouse_entered():
	rect_size = hover_size

func _on_mouse_exited():
	rect_size = original_size
