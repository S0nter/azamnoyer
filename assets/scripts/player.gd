extends CharacterBody2D

@export var speed = 250

var looks_to_right = true

func _ready():
	pass # Replace with function body.

func _process(delta: float):
	var input = Input.get_vector("left", "right", "up", "down")
	velocity = input.normalized() * speed
	
	flip_if_needed()
	animate()
	move_and_slide()


func animate():
	if velocity == Vector2(0, 0):
		$Sprite/AnimationPlayer.play("idle")
	else:
		$Sprite/AnimationPlayer.play("run")


func flip_if_needed():
	if velocity.x < 0:
		looks_to_right = false
	elif velocity.x > 0:
		looks_to_right = true
		
	$Sprite.flip_h = not looks_to_right
