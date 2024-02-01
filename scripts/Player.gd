extends CharacterBody2D

@export var speed = 250

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	var movement_direction := Vector2.ZERO
	
	# FIXME: normalize this:
	if Input.is_action_pressed("up"):
		movement_direction.y = -1 
	if Input.is_action_pressed("down"):
		movement_direction.y = 1
	if Input.is_action_pressed("left"):
		movement_direction.x = -1
	if Input.is_action_pressed("right"):
		movement_direction.x = 1


	movement_direction = movement_direction.normalized()
	velocity = movement_direction * speed
	move_and_slide()

	#look_at(get_global_mouse_position())
