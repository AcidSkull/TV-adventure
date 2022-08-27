extends StaticBody2D

export (int) var speed = 45

func _physics_process(delta):
	self.translate(Vector2(-speed * delta, 0))
