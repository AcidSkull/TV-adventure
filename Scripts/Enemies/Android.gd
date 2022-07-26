extends Enemy

onready var sprite = $Sprite
onready var deteciton_box = $DetectionBox
onready var chase_timer = $ChaseTimer

func _ready():
	$AnimationPlayer.play("Moving")

func animation():
	if l_ray.is_colliding():
		moving_left = !moving_left
		l_ray.scale.x = -l_ray.scale.x
		hitbox.scale.x = -hitbox.scale.x
		deteciton_box.scale.x = -deteciton_box.scale.x
	
	if moving_left:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func moving(delta):
	velocity.x = -speed if moving_left else speed
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_DetectionBox_body_entered(body):
	if body.is_in_group("player"):
		speed = 145
		sprite.modulate = Color(3, 1, 1)

func _on_DetectionBox_body_exited(body):
	if body.is_in_group("player"):
		chase_timer.start()

func _on_ChaseTimer_timeout():
	speed = 45
	sprite.modulate = Color(1, 1, 1)
