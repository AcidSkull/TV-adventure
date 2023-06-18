extends Node2D

var target: Player

var speed: int = 500
var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO

func start(_transform, _target):
	global_transform = _transform
	velocity = transform.x * speed

func _physics_process(delta):
	velocity += acceleration * delta
	velocity = velocity.clamped(speed)
	rotation = velocity.angle()
	position += velocity * delta


func _on_Area2D_body_entered(body):
	if body.is_in_group('player'):
		queue_free()
