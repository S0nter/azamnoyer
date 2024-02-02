extends Sprite2D

var fun_allowed = false

@onready var player: CharacterBody2D = get_tree().get_root().get_node("Main/Player")

@onready var end_of_gun = $"Muzzle"

var Bullet = preload("res://scenes/bullet.tscn")

var aim_point = Vector2()
const offset_of_player = 30


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var mouse = get_global_mouse_position()
	aim_point = mouse
	
	if Input.is_action_just_pressed("shoot") and not fun_allowed or \
		fun_allowed and Input.is_action_pressed("shoot"):
		shoot()
	
	if fun_allowed:
		global_transform = player.global_transform * Transform2D().translated(Vector2(offset_of_player, offset_of_player).rotated(get_angle_to(mouse)))
		## disable look_at(...) ##
		aim_point = global_position 	# uncontrollable in all directions
		#aim_point = position        	# swirl
	elif distance(mouse, player.global_position) <= offset_of_player:
		global_position = mouse
		aim_point = player.position
	else:
		global_position = player.global_position + (mouse - player.global_position).normalized() * offset_of_player
	look_at(aim_point)
	
	if player.global_position.x > global_position.x:
		flip_v = true
	else:
		flip_v = false


func distance(vec1, vec2):
	vec1 -= vec2
	return sqrt(vec1.x ** 2 + vec1.y ** 2)


func shoot():
	var bullet = Bullet.instantiate()
	get_tree().get_root().add_child(bullet)
	bullet.global_transform = end_of_gun.global_transform
	bullet.look_at(aim_point)
