extends CharacterBody2D

@export var speed = 250

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	var movement_direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = movement_direction * speed
	
	move_and_slide()

	#look_at(get_global_mouse_position())
