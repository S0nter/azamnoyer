extends Sprite2D

@onready var player: CharacterBody2D = get_tree().get_root().get_node("Main/Player")
var Bullet = preload("res://scenes/bullet.tscn")
var cooldown: float
@onready var shoot_point = $"Muzzle"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	aim(delta)
	cooldown -= delta
	if Input.is_action_pressed("shoot"):
		if cooldown <= 0:
			cooldown = 0.1
			shoot()
	

func aim(delta):
	var mouse = get_global_mouse_position()
	look_at(mouse)

	var difference = mouse - position;
	if position.distance_to(mouse) > 30:
		difference = difference.normalized() * 30
	position = lerp(position, difference, delta * 10)

func shoot():
	var bullet = Bullet.instantiate()
	get_tree().get_root().add_child(bullet)
	bullet.global_transform = shoot_point.global_transform
	bullet.look_at(shoot_point.global_position)
