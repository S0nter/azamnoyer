extends CharacterBody2D


var Bullet = preload("res://scenes/bullet.tscn")
@export var speed = 250

@onready var end_of_gun = $"Gun/Muzzle"


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	var movement_direction := Vector2.ZERO

	if Input.is_action_pressed("up"):
		movement_direction.y = -1 
	if Input.is_action_pressed("down"):
		movement_direction.y = 1
	if Input.is_action_pressed("left"):
		movement_direction.x = -1
	if Input.is_action_pressed("right"):
		movement_direction.x = 1
	if Input.is_action_pressed("shoot"):
		shoot()

	movement_direction = movement_direction.normalized()
	velocity = movement_direction * speed
	move_and_slide()

	#look_at(get_global_mouse_position())

#func _unhandled_input(event: InputEvent) -> void:
	


func shoot():
	var bullet = Bullet.instantiate()
	owner.add_child(bullet)
	bullet.transform = end_of_gun.global_transform
	bullet.look_at(get_global_mouse_position())
