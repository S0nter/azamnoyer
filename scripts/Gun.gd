extends Sprite2D

var fun_allowed = false

@onready var player: CharacterBody2D = $"../../Player"
@onready var end_of_gun = $"Muzzle"

var Bullet = preload("res://scenes/bullet.tscn")

var aim_point = Vector2()
const offset_of_player = 30


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var mouse = get_global_mouse_position()
	if Input.is_action_just_pressed("shoot") and not fun_allowed or \
		fun_allowed and Input.is_action_pressed("shoot"):
		shoot()
	
	# FIXME: we should rotate around player and look at mouse
	#global_transform = player.global_transform * Transform2D().translated(offset_of_player.rotated(get_angle_to(get_global_mouse_position())))
	#global_position = get_global_mouse_position()
	if distance(mouse, player.global_position) <= offset_of_player:
		global_position = mouse
		aim_point = player.position
	else:
		global_position = player.global_position + (mouse - player.global_position).normalized() * offset_of_player
		aim_point = mouse
	look_at(aim_point)


func distance(vec1, vec2):
	vec1 -= vec2
	return sqrt(vec1.x ** 2 + vec1.y ** 2)


func shoot():
	var bullet = Bullet.instantiate()
	owner.add_child(bullet)
	bullet.global_transform = end_of_gun.global_transform
	bullet.look_at(aim_point)
