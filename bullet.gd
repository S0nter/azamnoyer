extends Area2D

#@export var Bullet : PackedScene

var speed = 750

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	pass
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()

