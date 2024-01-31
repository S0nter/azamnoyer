extends Sprite2D

@onready var player: CharacterBody2D = $"../../Player"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	#look_at(get_global_mouse_position())
	
	# FIXME: we should rotate around player and look at mouse
	const offset_of_player = Vector2(50, 10)
	global_transform = player.global_transform * Transform2D().translated(offset_of_player.rotated(get_angle_to(get_global_mouse_position())))
	
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#
	##rotate_object_local(Vector2(1, 0), 0.1)
	##rotate_toward()
	##position = $Player.position + (position - $Player.position)
	#look_at(get_global_mouse_position())
