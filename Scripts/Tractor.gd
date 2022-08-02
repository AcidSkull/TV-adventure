extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 50
export var moving_left = true

var gravity = 1000.0

onready var l_ray = $RayCast2D
onready var animation = $AnimationPlayer

func _physics_process(delta):
	if l_ray.is_colliding():
		moving_left = !moving_left
		l_ray.scale.x = -l_ray.scale.x
	
	if moving_left:
		animation.play("Moving_left")
	else:
		animation.play("Moving_right")
	
	velocity.y += gravity * delta
	velocity.x = -speed if moving_left else speed
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_HurtBox_body_entered(body):
	if body.is_in_group("player"):
		queue_free()