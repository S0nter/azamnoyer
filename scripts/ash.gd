extends CPUParticles2D

@onready var player: CharacterBody2D = get_tree().get_root().get_node("Main/Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = player.position + Vector2(550, 0)
