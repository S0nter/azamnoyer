extends Camera2D

@onready var player = $'../Player'
var prev_value = position_smoothing_enabled

# Called when the node enters the scene tree for the first time.
func _ready():
	position_smoothing_enabled = false
	position = player.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position_smoothing_enabled = prev_value
	position = player.position
