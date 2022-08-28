extends RigidBody2D

export (int) var speed = 85

func _physics_process(delta):
	translate(Vector2(-speed * delta, 0))
