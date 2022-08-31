extends Enemy

onready var sprite = $Sprite

func _ready():
	$AnimationPlayer.play("Moving")

func animation():
	if l_ray.is_colliding():
		moving_left = !moving_left
		l_ray.scale.x = -l_ray.scale.x
		hitbox.scale.x = -hitbox.scale.x
	
	if moving_left:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
