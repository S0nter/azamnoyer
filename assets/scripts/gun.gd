extends Sprite2D

var fun_allowed = false

@onready var player: CharacterBody2D = get_tree().get_root().get_node("Main/Player")

@onready var end_of_gun = $"Muzzle"

var Bullet = preload("res://scenes/bullet.tscn")

var aim_point = Vector2()	# used by mouse
var aim_vector = Vector2()	# used for gamepad and virtual joystick
var cooldown = 0.1			# seconds before next shot
var mouse = get_global_mouse_position()
var sec_since_shot = 0		# seconds passed after shot was made


const offset_of_player = 30


# Called when the node enters the scene tree for the first time.
func _ready():
	if fun_allowed:
		cooldown = 0


func _process(delta):
	mouse = get_global_mouse_position()
	aim_point = mouse
	aim_vector = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down").normalized()  # for gamepad/joystick
	
	offset_gun()
	rotate_gun()
	handle_input()


func offset_gun():
	var player_pos = player.global_position
	if fun_allowed:
		# this is wrong way to do this stuff but it doesn't make it less fun
		global_transform = player.global_transform * Transform2D().translated(Vector2(offset_of_player, offset_of_player).rotated(get_angle_to(mouse)))
		## disable look_at(...) ##
		aim_point = global_position 	# uncontrollable in all directions
		#aim_point = position        	# swirl
	elif aim_vector != Vector2(0, 0):
		global_position = player_pos + aim_vector * offset_of_player		
	elif player_pos.distance_to(mouse) <= offset_of_player:
		global_position = mouse
		aim_point = player.position
	else:
		global_position = player_pos + (mouse - player_pos).normalized() * offset_of_player


func rotate_gun():
	if aim_vector == Vector2(0, 0):
		look_at(aim_point)
	else:
		look_at(global_position + aim_vector)
	
	# flip if needed and mabye rewrite some things here 
	if player.global_position.x > global_position.x and \
	player.global_position.distance_to(mouse) > offset_of_player or \
	player.global_position.x < global_position.x and \
	player.global_position.distance_to(mouse) < offset_of_player:
		flip_v = true
	else:
		flip_v = false


func handle_input():
	var delta = get_process_delta_time()
	sec_since_shot += delta
	
	
	if Input.is_action_pressed("shoot") and sec_since_shot > cooldown:
		shoot()
		sec_since_shot = 0


func shoot():
	var bullet = Bullet.instantiate()
	get_tree().get_root().add_child(bullet)
	bullet.global_transform = end_of_gun.global_transform
	bullet.look_at(end_of_gun.global_position + aim_vector)
	
	if fun_allowed:
		bullet.look_at(mouse)
