extends CharacterBody2D

@export var speed = 250

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	var input = Input.get_vector("left", "right", "up", "down")
	velocity = input.normalized() * speed
	
	if velocity == Vector2(0, 0):
		$Sprite/AnimationPlayer.play("idle")
	else:
		$Sprite/AnimationPlayer.play("run")
	
	move_and_slide()
