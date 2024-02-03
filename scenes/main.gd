extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if DisplayServer.is_touchscreen_available():
		get_tree().root.content_scale_factor = 2
