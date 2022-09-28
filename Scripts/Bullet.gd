extends Area2D

var rove = Vector2.ZERO
var look_vec = Vector2.ZERO
var speed = 2
var target = null

func _ready():
	look_vec = target.global_position - global_position

func _physics_process(delta):
	rove = Vector2.ZERO
	
	rove = rove.move_toward(look_vec, delta)
	rove = rove.normalized() * speed
	position += rove

func _on_Bullet_body_entered(_body):
	queue_free()
